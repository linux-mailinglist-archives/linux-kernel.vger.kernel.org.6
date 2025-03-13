Return-Path: <linux-kernel+bounces-559770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC2A5F957
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C40179AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1224F26869C;
	Thu, 13 Mar 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WoqK02lK"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384401D8A0A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878860; cv=none; b=qzeyLdcahWXJ0qGQ9qOUYSvb78082i2W2ZCIk4aciSBb5Dr3hK2aVZ7louM2Yt0HaMy+zuOO5FL6IG/5zQ8Ke6r3VzbWldoSKTUmClQynHzWZoV6LtUqAjfH2LMry/QwqJo5UlzUntIjN/VZHMqqYbmtbwumObcWgU6EnHdA9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878860; c=relaxed/simple;
	bh=1P9eAXy79yGLdU5tp3zlyGps03BkUiPsqFBCm2cxcMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bjcy6l1XfNGvI2lsBWCdnHJpsb2UbOegs2t239xG6odCBBR70Fl9ecynSRZkyi366Gd4eQSpa7qKkLHDMJGRJ68+ATwoQnUhpvbB8Dks7aUsw5yuUS928ZDbeAf601fqOL4X9h/YxMEJu27K5rjNBhioEb+GRDdUYC3r4I3Dycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WoqK02lK; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55B084421A;
	Thu, 13 Mar 2025 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741878855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9luUN/dEXHB6yOQaOu/R2VJ4c9o/k4HnO8bdSVrfaX8=;
	b=WoqK02lKedHD6pknpCYD3wUB4cb9WBWsuwqfmbaKjvYll+hAiPLQmsK6HdnqxeRBw0G+F/
	2Vm4bYCBgcp+gcP45FoiM+iSwf3GJKg7st/NGTxFgxI/19ZdFWH/jUfNSt2b0lZXoggZcE
	KzKYF67mIrT703ucVzNH/d7+o9VZyV8PPDYzJSloqiHkdz2TRzUroJDdPTFqoR0QXRwmY8
	eBVkyPZ4wThW7j4SCO8112nd/u05O6RelraW+/8LQd+cvXsx1kv2STr7wCd8RyPSs0YH+V
	/fRWGqn3nj9tWiihFo16iNAFzAXf/SETaUAVOcJ7Atd1rO1aulo8ojcvl2RqYA==
Date: Thu, 13 Mar 2025 16:14:11 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mxsfb: fix missing rollback on failure in
 mxsfb_probe()
Message-ID: <20250313161411.4604a1a1@booty>
In-Reply-To: <468c6352-3301-4f0b-a2d4-d6a013417a0e@suse.de>
References: <20250313-mxsfb_probe-fix-rollback-on-error-v1-1-ad2fb79de4cb@bootlin.com>
	<468c6352-3301-4f0b-a2d4-d6a013417a0e@suse.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgdttddvmedusggrjeemgeekfhejmedulegtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgdttddvmedusggrjeemgeekfhejmedulegthedphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhtohepshhtvghfrghnsegrghhnvghrrdgthhdprhgtphhtthhopehmrggrr
 hhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Thomas,

On Thu, 13 Mar 2025 15:40:43 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> > @@ -365,9 +365,10 @@ static int mxsfb_probe(struct platform_device *pdev)
> >   	 * located anywhere in RAM
> >   	 */
> >   	ret = aperture_remove_all_conflicting_devices(mxsfb_driver.name);
> > -	if (ret)
> > -		return dev_err_probe(&pdev->dev, ret,
> > -				     "can't kick out existing framebuffers\n");
> > +	if (ret) {
> > +		dev_err_probe(&pdev->dev, ret, "can't kick out existing framebuffers\n");
> > +		goto err_unload;
> > +	}  
> 
> I must have missed that when I reviewed the patch. But this call should 
> happen much earlier. right at the top of the probe function before 
> drm_dev_alloc(). Conflicting drivers need to be kicked out before 
> setting up DRM. Could you please send a patch to move the call to the 
> top? No extra cleanup would be required then.

Sure, sending v2 in a moment.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

