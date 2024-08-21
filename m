Return-Path: <linux-kernel+bounces-295385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34C959A55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FE01C20C92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A91B3B11;
	Wed, 21 Aug 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WezmwKM4"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928E1AD5E6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238599; cv=none; b=sBcuZ1+aKrkIbLrhzHnZ92rAyQ/nU6ClU7OH7oav+YOi7f1MloTEJmpj79xkokjiW15H3sIV8+dSwq5osYQB40vAZU+ug1x+J2bZP+2vXZT3q0mltr8D+bffBcBWQqLRuxDjRCaNEaIRa1nBqh9WB1cNNhqMAwR3+/+u+fWcWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238599; c=relaxed/simple;
	bh=UkWxvbAnrPzYLMQmhv+P/jtpnRCKsUjkkAwTRYhGUg8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InhwvnQtKcakdGp642DlRvOsyuyyOu7+clnv5GaciUka9SNIXztvtnE2V3B4QcKx2iPn68Wh8+RbzGIHM13JUvqhlKwhrToGbmQBq0Y05s6ifVBu4PlZMqW1hbHF5RtRtZuCW3oHlYNJhqsEsqVWV/XFwqRMqkagz3Gx+o52v8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WezmwKM4; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LB9fcc098519;
	Wed, 21 Aug 2024 06:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724238581;
	bh=m5dSbMkXiUKXyGMq2DZiV57p5tXBDfaI3mEs22KkMGo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WezmwKM4nsVbUm7X4ezUgsXvYcKfj8FhOuc6cwx3toFAJEHCMTotf9ecEpaYvvglB
	 8h71OIhBTVWXLWqewQiY2KcZH6mez1h/bg+nALupEF2DTxLfsKvl4ZZh+U+ctBIMaX
	 68ZgbTZMTfqFrlUyyathZtf522XcXkHjQn8bm2P0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LB9fNx070162
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 06:09:41 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 06:09:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 06:09:40 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LB9ecf000669;
	Wed, 21 Aug 2024 06:09:40 -0500
Date: Wed, 21 Aug 2024 06:09:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: Judith Mendez <jm@ti.com>, Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
Message-ID: <20240821110940.s5ubbcozk2bouklh@chaps>
References: <20240819204352.1423727-1-jm@ti.com>
 <ZsTHj/Fyffi2LxIu@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsTHj/Fyffi2LxIu@hu-bjorande-lv.qualcomm.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:42-20240820, Bjorn Andersson wrote:
> On Mon, Aug 19, 2024 at 03:43:52PM -0500, Judith Mendez wrote:
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
> 
> Is this the regulator framework disabling the "unused" vdd_mmc1 while
> you still have a probe deferred client?
> 
> That's not right.

I think context of the full log might be missing, hence misleading - but
if this is correct, regulator framework might have a problem as well -
it does not change the fact that we will need regulator driver to
support switch from 3.3v to 1.8v to enable UHS (which is another
topic as well - do not trust the bootloader either for the default
voltage enabled in the system).

Judith: This is why providing links to previous versions of patches AND
providing links to the full before and after logs in the diffstat
section helps reviewers - please do that in the next revision.

> 
> > 
> > and a failure to boot the SK-AM62A-LP.
> > 
> > One solution is to use initramfs [2], but using initramfs increases the
> > boot time for this automotive solution which requires faster boot time
> > parameters.
> > 
> > Another solution is to change MFD_TPS6594_I2C to built-in, that way the
> > PMIC is setup and the regulators are ready before MMCSD switches to UHS
> > mode, this is the preferred solution since it does not increase boot time
> > like the initramfs solution does.

What is the adder in cost? bloat-o-meter report summary should have
been part of commits that increase vmlinux

> > 
> > [1] https://www.ti.com/lit/zip/sprr459
> > [2] https://lore.kernel.org/linux-devicetree/5f03207b-c29b-4d16-92b0-d14eef77bf17@linaro.org/
> > Fixes: f9010eb938be ("arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A")
> > 
> > Signed-off-by: Judith Mendez <jm@ti.com>
> > ---
> >  arch/arm64/configs/defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 7d32fca649965..61f767246d3a5 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -756,7 +756,7 @@ CONFIG_RZ_MTU3=y
> >  CONFIG_MFD_TI_AM335X_TSCADC=m
> >  CONFIG_MFD_TI_LP873X=m
> >  CONFIG_MFD_TPS65219=y
> > -CONFIG_MFD_TPS6594_I2C=m
> > +CONFIG_MFD_TPS6594_I2C=y
> 
> These things should work with =m, and then you can make them =y in your
> product config to avoid the probe deferral.

I think this is inline with the discussion with Krystoff on the topic as
well


Judith: you just need the regulator, for sd/mmc to work. Why is there
half a dozen unrelated stuff coming with it [1] report from
bloat-o-meter? Please fix the driver dependencies before adding
un-necessary stuff to the kernel Image file.

[1] https://gist.github.com/nmenon/0caff032a430bbf649ad1107e6f12f9a

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

