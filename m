Return-Path: <linux-kernel+bounces-293885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D2195862C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159CE1F2061F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4011418E76A;
	Tue, 20 Aug 2024 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XnFqe1ET"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA118E047
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154831; cv=none; b=oqoF24DwzUMuac7Q5rrRM8tAd5b96VrDDFoQkkSdxHJeeeM2obxYQiDxQpEz1DZodEJPnggQ6SCWMYuTp/KrIxEKMJvI0QchNKdQVXOvMd6yWBeJDdJB772tMko/p/g/2SEYCaDn3zWnpETPpdhGfRt/orW0Bk4BVX/mkaX1iEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154831; c=relaxed/simple;
	bh=YX9SBUx/g3awvNbfvK5b0UdC1Lgii1YRZQiXQR8vO34=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfxUEM1kaVKnMeaIlbauWq/LV23XwaN0g2Ei7bggDp49yOWGOdQG1V1SIC3aSkJl/npowBTLmcFsMLHYwBw93UNmVaNLLMT/NjlhK0U5vdiRaCCRRdSD1eECB+zwqfTM7rbdRFO3IMUPPamvY4GQSqXZMAE1eCE6JiKOGwTyFMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XnFqe1ET; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KBrW5p125836;
	Tue, 20 Aug 2024 06:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724154812;
	bh=aNNETTM4glcMWuVKC/h6PLYWIg2YWEzJbjvEtcW3p0U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XnFqe1ETXIZkm7XvZTE6MpuyjCm/2vz4Q+GtquqYGPpbMIfuveylIEgQ2+znCeeQr
	 k4Q8dZAEO2mfGNQSkYz6mSl0aVI6QZDF2wfZE0kRGron/FlAhYPAwPK/6F3r7K7Xj1
	 rmpLTz1P++Q9f97i30ZeCPdJXAROJajX2eBCtyJc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KBrWPB011154
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 06:53:32 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 06:53:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 06:53:31 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KBrVrC044368;
	Tue, 20 Aug 2024 06:53:31 -0500
Date: Tue, 20 Aug 2024 06:53:31 -0500
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann
	<arnd@kernel.org>
CC: Judith Mendez <jm@ti.com>, Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
Message-ID: <20240820115331.myibtim7enhpg4cm@mortality>
References: <20240819204352.1423727-1-jm@ti.com>
 <1a7def3f-a19c-4f1c-845c-a3854c165995@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a7def3f-a19c-4f1c-845c-a3854c165995@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 23:01-20240819, Krzysztof Kozlowski wrote:
> On 19/08/2024 22:43, Judith Mendez wrote:
> > SK-AM62A-LP is a device targeting automotive front-camera applications
> > among other use-cases. It utilizes the TPS6593x PMIC (interfaced over I2C)
> > to power the SoC and various other peripherals on the board [1].
> > 
> > MMCSD requires the PMIC to be setup correctly before setting the bus
> > pins to 1.8V using the TPS6594 driver interfaced over i2c.
> > 
> > Currently, the following could be seen when booting the am62ax platform:
> > 
> > "platform fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready"
> > "vdd_mmc1: disabling"
> > 
> > and a failure to boot the SK-AM62A-LP.
> > 
> > One solution is to use initramfs [2], but using initramfs increases the
> > boot time for this automotive solution which requires faster boot time
> > parameters.
> 
> This is a defconfig, not a distro/product config, so your product
> constraints are not really relevant. You are supposed to boot defconfig
> with proper initramfs with necessary modules.
> 
> I don't get why people mistake defconfig with their product stuff...
> 
> > 
> > Another solution is to change MFD_TPS6594_I2C to built-in, that way the
> > PMIC is setup and the regulators are ready before MMCSD switches to UHS
> > mode, this is the preferred solution since it does not increase boot time
> > like the initramfs solution does.
> 
> Use initramfs. Several devices, e.g. most Android ones, have fixed size
> of boot partition, so size of kernel is important.

am62a products do not use android in general. Standard distros such
as debian etc usage are limited as well. These products tend to have
limited resources just sufficient for the normal operations.

While I understand that we do keep the product usage model separate
from what upstream defconfig looks like, we have been very careful
to only enable the basic configurations necessary for default system
startup. During the initial days of K3, we had considered going down
the initramfs route, but realized that this was not a practical
option for developers to sustain and iterate quickly for triage or
development. Till date, we have maintained nfs and sd card boot as
default to allow for automated testing of upstream kernel.

I understand that you have provided similar comments for other
platforms[1] as well, but, I am now wondering if this is a new rule
we are taking in aarch64 platforms to allow just initramfs and
force all drivers to be modules (I understand that is the default
preference in android, but that is not true in other ecosystems). I am
curious if this was some sort of conclusion in the list (my search of
public-inbox seems to fail me here).

[1] https://lore.kernel.org/linux-arm-kernel/e08e6325-4b2b-c1ce-b33a-877de2c0babe@linaro.org/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

