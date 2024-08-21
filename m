Return-Path: <linux-kernel+bounces-295378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39FC959A41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C826C1C213E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649601C2DD6;
	Wed, 21 Aug 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rTfOUQ9L"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162061C2DB1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238080; cv=none; b=QutnViL11A/2vDnPBbhXoIbceVdAtqr0Hs7CpaLb8EX2FH2Cdss2+F/qLHgjNggEN1iP/+//9ncvQxp8NvwPgAhTZhPGufQe8mLbOL0Zo+KpcoIvgId8qd7Z/IpXl7/781VU0rws8aPc9dqv8tcu5zKBJ2BuQmm3nWx1efDj3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238080; c=relaxed/simple;
	bh=z4lk1rL8XdNEYrlPwLf7R4dzP7C4titZHNDwk09n1EY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec8nkmv2SUcS1XC1n1Ac8MxVH0gt0xD2/DGW5UbsYAcN5lYquxO85NgA8MUa/KlOSyvVxY4hX3r+zujbAsKQqucU7wZ9UOq9WKQtthWUkby9QO/7psNB6ilrM9BwPZSDjaxvsETKjPNt/wR0jg4Sla070Ab7gDp9M0Aff6Ww/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rTfOUQ9L; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LB0sPH095111;
	Wed, 21 Aug 2024 06:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724238054;
	bh=AeCmsSw9VD5x/Ef/8bpYaAl79A4g47wj1+h6S4GqYLA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=rTfOUQ9LM6SXX/q3oc65JN1NnkD4vSA0XXVtBQ4wu7fj4tlIwPXwdQumcik+DZyJL
	 ZD8ePcdx6VbfoRaHuMsemdAkPJngpu37uuLXcLWcHuTPl5JEeVwjOflL9XSmF/uN0L
	 ZA7wI3bS36mBviVI+EaxggH9Z2ddrySXDiD6sGJ0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LB0sa2001635
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 06:00:54 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 06:00:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 06:00:54 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LB0sdS006270;
	Wed, 21 Aug 2024 06:00:54 -0500
Date: Wed, 21 Aug 2024 06:00:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Arnd Bergmann <arnd@kernel.org>, Judith Mendez <jm@ti.com>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn
 Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
Message-ID: <20240821110054.35u5ubgaogzjv6c4@rover>
References: <20240819204352.1423727-1-jm@ti.com>
 <1a7def3f-a19c-4f1c-845c-a3854c165995@linaro.org>
 <20240820115331.myibtim7enhpg4cm@mortality>
 <323cc7c0-8511-4d21-9925-97a6ba94280f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <323cc7c0-8511-4d21-9925-97a6ba94280f@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Krzysztof,

First: I appreciate all you do for the community and this discussion.
Thank you.

On 08:33-20240821, Krzysztof Kozlowski wrote:
> On 20/08/2024 13:53, Nishanth Menon wrote:
> > On 23:01-20240819, Krzysztof Kozlowski wrote:
> >> On 19/08/2024 22:43, Judith Mendez wrote:
> >>> SK-AM62A-LP is a device targeting automotive front-camera applications
> >>> among other use-cases. It utilizes the TPS6593x PMIC (interfaced over I2C)
> >>> to power the SoC and various other peripherals on the board [1].
> >>>
> >>> MMCSD requires the PMIC to be setup correctly before setting the bus
> >>> pins to 1.8V using the TPS6594 driver interfaced over i2c.
> >>>
> >>> Currently, the following could be seen when booting the am62ax platform:
> >>>
> >>> "platform fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready"
> >>> "vdd_mmc1: disabling"
> >>>
> >>> and a failure to boot the SK-AM62A-LP.
> >>>
> >>> One solution is to use initramfs [2], but using initramfs increases the
> >>> boot time for this automotive solution which requires faster boot time
> >>> parameters.
> >>
> >> This is a defconfig, not a distro/product config, so your product
> >> constraints are not really relevant. You are supposed to boot defconfig
> >> with proper initramfs with necessary modules.
> >>
> >> I don't get why people mistake defconfig with their product stuff...
> >>
> >>>
> >>> Another solution is to change MFD_TPS6594_I2C to built-in, that way the
> >>> PMIC is setup and the regulators are ready before MMCSD switches to UHS
> >>> mode, this is the preferred solution since it does not increase boot time
> >>> like the initramfs solution does.
> >>
> >> Use initramfs. Several devices, e.g. most Android ones, have fixed size
> >> of boot partition, so size of kernel is important.
> > 
> > am62a products do not use android in general. Standard distros such
> 
> But I (and others) use sometimes devices with Android partitioning so
> the size of vmlinux is important. I want to be able to enable KASAN. If
> each person brings their modules into built-in, I won't be.

The scope is restricted to be sd and nfs boot capability only in Image
file.

> 
> > as debian etc usage are limited as well. These products tend to have
> > limited resources just sufficient for the normal operations.
> 
> So defconfig is not suitable for them in the first place.
> 
> > 
> > While I understand that we do keep the product usage model separate
> > from what upstream defconfig looks like, we have been very careful
> > to only enable the basic configurations necessary for default system
> > startup. During the initial days of K3, we had considered going down
> > the initramfs route, but realized that this was not a practical
> > option for developers to sustain and iterate quickly for triage or
> > development. Till date, we have maintained nfs and sd card boot as
> > default to allow for automated testing of upstream kernel.
> 
> I don't understand what is here not practical. Entire Qualcomm Landing
> team for all products uses initramfs, my Exynos development uses
> initramfs. There is no difference in building the kernel, no practical
> impact, the same effort (after setting up the scripts, but we all are
> scripting). I know, that 10 years ago many of developers, including
> myself, did not want to switch to initramfs, but things change.

I understand initramfs is not new and it is not rocket science. The
ecosystem however hasn't adopted it for few reasons that I mentioned.

As of commit v6.11-rc4-19-gb311c1b497e5 blindly doing a make
modules_install with the default defconfig is 1.1G loaded via
initramfs Vs putting it in a filesystem - those extra load times are
significant for iterative development - you can see what is
practical - unless I deal with each of the engineers having custom
scripts selectively setting up modules for their initramfs environment
and dealing with that consequence - I really don't want to get into
the business of distro build rules with each engineer (and this goes
to the entire ecosystem I deal with).

> 
> > 
> > I understand that you have provided similar comments for other
> > platforms[1] as well, but, I am now wondering if this is a new rule
> > we are taking in aarch64 platforms to allow just initramfs and
> > force all drivers to be modules (I understand that is the default
> 
> It's not particularly new. The use of modules for multi_v7 and
> arm64/defconfig was since years.

The insistence of initramfs as the only way the default defconfig will
boot is a bit new.

> 
> > preference in android, but that is not true in other ecosystems). I am
> > curious if this was some sort of conclusion in the list (my search of
> > public-inbox seems to fail me here).
> 
> There are different point of views. I am presenting here mine and I back
> it with arguments, that such changes accumulate and have impact on
> developers workflow.
> 
> Defconfig is for developers and as starting point for distros or
> products. Not as final product defconfig.

This is a bit of a duality thing here - the argument you have
presented in the thread indicates that android based product platforms
you work with uses fixed boot partition sizes for kernel Image. And as
a result increasing Image size has side effects of preventing boot.
K3 architecture devices had already considered the possibility that
Image files will grow given newer SoC support being added. We picked a
balance of what was practical for our ecosystem. From where I stand, I
see insistence of "your product" usecase to be more critical than my
ecosystem needs of consistency and flexibility.

To the implied statement that we are insisting on product defconfig
in upstream: NO, we have not. We maintain config fragments in our s/w
products as necessary already.

For upstream, we already have insisted on a line in our ecosystem that
is sd and ethernet/nfs boot as the minimal configuration, if there is
an effort to force just one k3 product to do initramfs Vs all other
products in the family to have capability of sd/nfs boot - that, in my
opinion, is not treating the ecosystem fairly and equally.

Further, I am not a fan of arbitrary new "it should be better done
this way" rules introduced just for a few products, but not for
others.

I think you already know this, but the right way, IMHO, to get this
kind of general recommendation is to introduce documentation into
Documentation/arch/arm64/ or equivalent with reasonable guidance to
developers how to manage the initramfs. I would however suggest doing
this with the 2025 kernel as the first transition point and we can all
work together to reduce the size of Image. Do send a patch introducing
the recommended content for arm64/defconfig and we can debate the pros
and cons in that context.

That said, there are things to improve in this patch, I will comment
separately on it. As such, enabling SD/ethernet nfs boot is inline
with the base policy we had set for k3 ecosystem. Unless Arnd or SoC
maintainers insist we start arbitrarily break parts of the ecosystem,
I don't see a reason to reject this support (If we have a problem
adding a few K for a regulator driver, I suppose we have already
reached a limit where adding a new platform arch with common defconfig
may be impractical and we have much bigger problems and needs to be
addressed via reducing the scope of defconfig generated Image overall -
but lets do that across arm64 platforms consistently).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

