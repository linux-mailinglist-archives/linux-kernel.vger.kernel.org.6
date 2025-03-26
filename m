Return-Path: <linux-kernel+bounces-576723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F8A713A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32E7178C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AA01C861B;
	Wed, 26 Mar 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TqDWag+M"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA91C84BE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981001; cv=none; b=TYNfWMmaiqCeC3Owt5G0TPzI1F40chxh3p65S2wKCHiHzEepafc9LDJE3wL//+Xiqk6r7YJicQKm62tVCZpA5tdvskuEuz/uYVJblNUY5YFN0ngA6FjbSnc4RbE80j6df+B4LX27fASbZmP3Y1HfNluvlIj2oPbleiBZisxRuvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981001; c=relaxed/simple;
	bh=FOpYOXESCMiYyzsUiUOPjvu6De560UeT5Mgunj6yv3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKovD6sfppDROMI23mJS6lEImHjxuR1gLppezdUVewkSxtDKZimI+iJpZ2w38RIFCvOE1CdKpoXDttkqbyxcaA48u4/pS48t05qmBZfO6CCXr6YczYKv42VagJvHhLCbkz/BBbxnrTxGZPs5YHGT0p1ne1ATES7NltRW+r/s/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TqDWag+M; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15E9343218;
	Wed, 26 Mar 2025 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742980997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIgmAGx5B4hdQ72teEZ+hI6P8gPF2945GQP3NL7E4eE=;
	b=TqDWag+Mn4HjxNKykAvU2xIZ5qW/qhNK+1Bs2OyZ/5XDPk37aQyyflX6psLI6cHo6PFkqg
	nQCHkLArDxoDFaQG2WSIz1hEgh1XFUMegF07q34kiysUBow87mfldgFrC/I13QjINKK9br
	SaKC+hq6XoGbzMoxWBgNFS5siLwsVPsCq6/D0VF3rbfa591XPz0q7/CUiZCtBG8jCOPn+i
	IG7aKukYtj3r4lqq+h0NTqx7t89BmvoQ2NeWqi2V9nOIr6pxFpOL6BSDXaQ4pqtHHq059s
	1hivr8vGTVKOL2ru7MfyBieqwmsNTyiJdA2ggn/MBaWLk4351a2HV3QcDFty7g==
Date: Wed, 26 Mar 2025 10:23:14 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/panel/panel-simple: Use the new allocation in
 place of devm_kzalloc()
Message-ID: <20250326102314.2a1bce9c@booty>
In-Reply-To: <20250325-b4-panel-refcounting-v1-5-4e2bf5d19c5d@redhat.com>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
	<20250325-b4-panel-refcounting-v1-5-4e2bf5d19c5d@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprghsrhhivhgrthhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhhuihgtpghjvghsshiihhgrnhesqhhui
 hgtihhntgdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthh
X-GND-Sasl: luca.ceresoli@bootlin.com

On Tue, 25 Mar 2025 13:24:12 -0400
Anusha Srivatsa <asrivats@redhat.com> wrote:

> Start using the new helper that does the refcounted
> allocations.
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 6ba600f97aa4c8daae577823fcf17ef31b0eb46f..60b845fad4e1b378af52d34dfae0139c4625dc51 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -579,7 +579,8 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>  	u32 bus_flags;
>  	int err;
>  
> -	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
> +	panel = devm_drm_panel_alloc(dev, struct panel_simple, base,
> +				     &panel_simple_funcs, desc->connector_type);
>  	if (!panel)
>  		return -ENOMEM;

devm_drm_panel_alloc() returns "Pointer to new panel, or ERR_PTR on
failure.", so you need IS_ERR() to check for an error condition:

  if (IS_ERR(panel))
    return PTR_ERR(Panel);

Otherwise looks good.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

