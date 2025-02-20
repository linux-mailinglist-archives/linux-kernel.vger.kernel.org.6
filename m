Return-Path: <linux-kernel+bounces-523355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CCA3D572
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFB01898A51
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EA11EE006;
	Thu, 20 Feb 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dZYMHoki"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A501E9B36
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045172; cv=none; b=DmNqjcuQ7kRPBT6bh/6GSCZELRJtv30hg4GngS9bnEDhyVOJDVKS4IaVo0en7D3pwf+kuiYS91rfXgoJvSqqHNpmgigkTnDONh0FeBIfeEPgwQYlsNbVcO/VeUasq686Tj3/n7XtrjblM054i47vtMknaN2tB7dt/HzOJ2cKj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045172; c=relaxed/simple;
	bh=6UUs/Jo7ZbJdxRb140Kxx2e+0xZg0ypRcjIrjXbe06w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1LKTxGKAQKF2WMsJ+KS1bGofhUxR/RGvJk3UR4NFJsSZoKdMCI6BwaGEB7RQGw7QTrY6k1cg4gToVZSujaeLYhFWAi2I3PDgz0zKCk+jXKaNCoFw/JL4vBuZ7jhYVllK0Kc7CuC0XvLAl2IvgqKhXQAQwh+DgUHCG3gYAppnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dZYMHoki; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6O27F006861;
	Thu, 20 Feb 2025 03:52:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=yY+l2M/rIyGedVKpG4E7Aob3HsYRuTepJXAzAhoO6+U=; b=
	dZYMHokiH2PG3fSTyficisHYbBMPyv8m7dU40dU996JdARnLGjlRLz4o8abSCP0l
	i/bZbC5MNX7Jv64yPe2iquk3yaMshxvjaq4HP8UiiYu8gi09irG4jfb8p0w5VMiD
	HFeaeLLJWDYa0uWpfjC5FpbJwogZT4VmXl3dASuGIGAUkX7mzaK0KKXvE/hQvJfP
	/pL7w+AU8sVxtj81PLK5WZU6gteXR6rQDoyFETONieSZaDNlXmJoxeIOlNglkXgB
	Pcttq22XSab1Zc8YvVB+9FuZL3c/5CltLQmnRg6PRvORkACHKnjyTpObl/S/ZbYH
	rayIumwR8yXlBivD1YzH4A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44vyywv5k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 03:52:38 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 09:52:35 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 09:52:35 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id AE22482025A;
	Thu, 20 Feb 2025 09:52:35 +0000 (UTC)
Date: Thu, 20 Feb 2025 09:52:34 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
CC: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] firmware: cs_dsp: Remove usage of GFP_DMA
Message-ID: <Z7b7Ylk55D1LZ2WX@opensource.cirrus.com>
References: <20250211-cs_dsp-gfp_dma-v1-0-afc346363832@linutronix.de>
 <0e9c1cca-592f-4983-93f4-ab2f76a3c97e@opensource.cirrus.com>
 <e93d1b72-43da-4e96-9523-e1bbf3853031@opensource.cirrus.com>
 <1e251815-5d58-436b-9120-e88f75a7ecaa@sirena.org.uk>
 <20250213161059-a4c53711-fdf6-480c-af49-f9f36227ba42@linutronix.de>
 <8d15d138-658c-4083-885b-62495023bb9a@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d15d138-658c-4083-885b-62495023bb9a@opensource.cirrus.com>
X-Proofpoint-GUID: hh4Z1bQdNNYjCpIXScJUQhCzOajF4DKZ
X-Proofpoint-ORIG-GUID: hh4Z1bQdNNYjCpIXScJUQhCzOajF4DKZ
X-Authority-Analysis: v=2.4 cv=WOSFXmsR c=1 sm=1 tr=0 ts=67b6fb66 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=8nJEP1OIZ-IA:10 a=T2h4t0Lz3GQA:10 a=0uJkZ3h_mcAHihPl4hIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Reason: safe

On Wed, Feb 19, 2025 at 04:26:55PM +0000, Richard Fitzgerald wrote:
> On 13/02/2025 3:16 pm, Thomas Weißschuh wrote:
> > On Thu, Feb 13, 2025 at 03:06:59PM +0000, Mark Brown wrote:
> > > On Thu, Feb 13, 2025 at 02:28:06PM +0000, Richard Fitzgerald wrote:
> > > > On 11/02/2025 5:21 pm, Richard Fitzgerald wrote:
> > > 
> > > > > > Not tested on real hardware.
> > > > > > This came up while porting kunit to mips64.
> > > > > > Apparently GFP_DMA does not work there, but IMO the usage of GFP_DMA by
> > > 
> > > > I would say that is a bug in mips64 that should be fixed in mips64.
> > > > It is not reasonable to expect generic drivers to have special cases for
> > > > platforms that don't handle GFP_DMA.
> > 
> > Indeed, I did that, too.
> > 
> > > What specifically is the issue?  If it's a build time issue I'd
> > > definitely agree that we should just be able to assume that platforms at
> > > least build.  IIRC there is a Kconfig you can depend on for DMA but it
> > > seems more trouble than it's worth to fix all users.
> > 
> > More details in [0], It's only a runtime issue.
> > 
> > I'm still wondering how all the on-stack buffers used with regmap_raw_read()
> > and regmap_raw_write() by cs_dsp are satisfying the DMA requirements.
> > 
> There are 3 suspicious regmap_raw_read(). The others are all integers,
> which are guaranteed not to cross a page boundary.
> 
> However, it looks like it might be safe to remove the GFP_DMA flags
> now. regmap_raw_read() calls spi_write_then_read() which specifically
> says that the buffers do not need to be DMA-safe and internally uses a
> DMA-safe buffer. regmap_raw_write() uses either a temporary physically
> contiguous buffer or GFP_DMA buffer (the implementation is terrifyingly
> complex so it's difficult to determine exactly what it does).
> 
> (Some older systems could only use certain special memory areas for DMA
> but we haven't seen any of those used with cs_dsp.)
> 

We also need to consider what the I2C subsystem does, I have a
vague memory of thinking the SPI system will attempt to remap
buffers but I2C will just use them as is. cs_dsp will be used
with both, although SPI is slightly more common for obvious
reasons.

Thanks,
Charles

