Return-Path: <linux-kernel+bounces-531143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD78A43CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707401675E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A264267B89;
	Tue, 25 Feb 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lCL+vXa+"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE8267AE2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481326; cv=none; b=TX/4qXs9iFU0WgIpuRG4T//DbYtwELg+4+UbGahgVHWF4g7m/MP6OGU1P85iSKb/cP8ywBAYK/jIE2V4kmP+mseCBbcWzszO5ZIDxSCKGdM8ZU1arjQDdRuJhY3E1B5wpznFg3DQgdzZnSkjb2giySoHywO/b+mIeJxxE4he2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481326; c=relaxed/simple;
	bh=DSemMjXuLRT1W45tXg7AciVv7q2d8d8LrKzhCVgHSY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADTfl4HJXQ9zuC5+bZhioir/5pwTosoAdpsj0P4CGf72sacwez1aY3yVPGql7ah9XqhwSubCKOboC+r6hz0ymtYW83n5M00b2nBcKP18s7N72nwpxf+NEf0Nt86tJFYhhNFczfu6qWmfvyxzlp89sqKuPCtyxvLPu6Zw5oE26tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lCL+vXa+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A34C44203;
	Tue, 25 Feb 2025 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740481322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxD7u52Yk2El+HIBdZJ8lh/YrSDRYFqQDU0BbGyBxkc=;
	b=lCL+vXa+lkl5Ofhep46H22CSF48piNP70ZLVYlvvkl4ttKDGXz2WxgiGn/HC3P2ZkpPdZs
	FYlGrP7Z2EYeAfcpzflmStPD630cV3T9GBVrtxVa+Mz0CFirbLHlkXp3YmUKUW5BHl5Y8M
	0smCZwKTKoZgWDJDd+RNC6Bwq6ISuq2W0CnV4oVcGAo4IgxqeswPxMwDy6UNarBgeQit58
	4Hn7IkxPEKs1cUoY2lBsfOWW/Bwd4c1IZGLu+rJW1BkkNgfEsH3p56+gOjMf6agL73C+oH
	STFRHbIEyXKLUptqIobrnlZI/TBAb27yFuokdo3qMC1tmELE0iJzYgvJ6WRQvA==
Date: Tue, 25 Feb 2025 12:02:00 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/16] drm/vkms: Allow to configure the default device
 creation
Message-ID: <Z72jKC7lpWAsbFLm@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
 <20250218170808.9507-16-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218170808.9507-16-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfejveetkedvleetudeuudegfeejheeujeefkefgtdeugfetfeeutdevieekvdeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/02/25 - 18:08, José Expósito wrote:
> Add a new module param to allow to create or not the default VKMS
> instance. Useful when combined with configfs to avoid having additional
> VKMS instances.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 5bcfbcb6c0c5..b4ed19c97576 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -50,6 +50,10 @@ static bool enable_overlay;
>  module_param_named(enable_overlay, enable_overlay, bool, 0444);
>  MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
>  
> +static bool create_default_dev = true;
> +module_param_named(create_default_dev, create_default_dev, bool, 0444);
> +MODULE_PARM_DESC(create_default_dev, "Create or not the default VKMS device");
> +
>  DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
>  
>  static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
> @@ -219,6 +223,9 @@ static int __init vkms_init(void)
>  	if (ret)
>  		return ret;
>  
> +	if (!create_default_dev)
> +		return 0;
> +
>  	config = vkms_config_default_create(enable_cursor, enable_writeback, enable_overlay);
>  	if (IS_ERR(config))
>  		return PTR_ERR(config);
> -- 
> 2.48.1
> 

