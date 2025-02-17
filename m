Return-Path: <linux-kernel+bounces-517146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6DA37CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE41893C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E7F1990C3;
	Mon, 17 Feb 2025 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tvhjxXRE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tfkPmbmj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tvhjxXRE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tfkPmbmj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FC18DB28
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779473; cv=none; b=pi4eEquHvI59DXsFjvagTLOTAOlu2h5lIFeF0hsStC9/NNRfPiv76RUKBfO8Kob0nnkHbrtwotxGoUIoNJC5QB2KzeYv6iDsT5amCW4zLPVIv9De/v9G1NiXhvIkQM+0LMLBnyj8LSeChfoyqk/APo6hIFudaoqioYI/9RlEW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779473; c=relaxed/simple;
	bh=e+NHkqu0XUnISeGWpo7rUjk26NZiV1HdJ1ijYf8qlCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWq/niwPQOJrlLUWtxg2d3CWvpm2PJ2Auj+0ox5avdaWwlfIT4vGFmXcaStRLxbvppW88houvlr/fCmkulbeB47xMPhkGVr4dyg7iz2wsJqeSnWrbj9IcHYjLfao5UeQWTIlS1BJpsDUYjrdnt/7wXeR57vQ57t1nJ/X48L2cEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tvhjxXRE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tfkPmbmj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tvhjxXRE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tfkPmbmj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79C4E1F397;
	Mon, 17 Feb 2025 08:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739779469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NwP/KFPDJoRYJCbBNMnc8T3qUJwOR0LhVvJQygwxFok=;
	b=tvhjxXRE0kB/CSK3nHS+AlrHy8dZ7lbr0gu1Vj4+6GvVXWaCmeHxoObiwfJgjtnsWoCL62
	wmklLsP2Kt0SwkCsGrQUuSx4kPm4+VTSx/YqT2woBqysKHUocy9xjKsT7ABGXqZJRwRJyJ
	jYRqjK5gbnUqSChUcpuiELnQ/jXvIbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739779469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NwP/KFPDJoRYJCbBNMnc8T3qUJwOR0LhVvJQygwxFok=;
	b=tfkPmbmj01UxMb5l80r5xFwLAotQn5XyZjy9vivsnbVzy4BbuCCNB+SEsu+TSGAoNLW0aE
	XkWCNlPh8oYjzqBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tvhjxXRE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tfkPmbmj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739779469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NwP/KFPDJoRYJCbBNMnc8T3qUJwOR0LhVvJQygwxFok=;
	b=tvhjxXRE0kB/CSK3nHS+AlrHy8dZ7lbr0gu1Vj4+6GvVXWaCmeHxoObiwfJgjtnsWoCL62
	wmklLsP2Kt0SwkCsGrQUuSx4kPm4+VTSx/YqT2woBqysKHUocy9xjKsT7ABGXqZJRwRJyJ
	jYRqjK5gbnUqSChUcpuiELnQ/jXvIbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739779469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NwP/KFPDJoRYJCbBNMnc8T3qUJwOR0LhVvJQygwxFok=;
	b=tfkPmbmj01UxMb5l80r5xFwLAotQn5XyZjy9vivsnbVzy4BbuCCNB+SEsu+TSGAoNLW0aE
	XkWCNlPh8oYjzqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21027133F9;
	Mon, 17 Feb 2025 08:04:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SOPdA43tsmdwIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Feb 2025 08:04:29 +0000
Message-ID: <3df4e526-66a4-4dcd-8c6e-adacd9a2a5aa@suse.de>
Date: Mon, 17 Feb 2025 09:04:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 10/10] drm/tiny: add driver for Apple Touch Bars in
 x86 Macs
To: Aditya Garg <gargaditya08@live.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch"
 <daniel@ffwll.ch>, Jiri Kosina <jikos@kernel.org>,
 "bentiss@kernel.org" <bentiss@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>, Orlando Chamberlain <orlandoch.dev@gmail.com>,
 Kerem Karabay <kekrby@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <DD9C41AD-6543-47CE-8504-69E4992229B2@live.com>
 <3C9E8938-32EC-44AC-A783-3BFDE2F01290@live.com>
 <8d0296fe-536f-4a9a-bd9e-624bb4cd8703@suse.de>
 <1C5F4A8E-018C-4A39-B8EE-CDDDF9FABD7A@live.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <1C5F4A8E-018C-4A39-B8EE-CDDDF9FABD7A@live.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 79C4E1F397
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[live.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,t-8ch.de,vger.kernel.org,lists.freedesktop.org];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi Aditya,

the code looks correct overall. There's one place where I think it 
fails. See below.

Am 15.02.25 um 14:43 schrieb Aditya Garg:
[...]
> DEFINE_DRM_GEM_FOPS(appletbdrm_drm_fops);
> @@ -484,10 +537,38 @@ static const struct drm_driver appletbdrm_drm_driver = {
> static int appletbdrm_setup_mode_config(struct appletbdrm_device *adev)
> {
> 	struct drm_connector *connector = &adev->connector;
> +	struct drm_plane *primary_plane;
> +	struct drm_crtc *crtc;
> +	struct drm_encoder *encoder;
> 	struct drm_device *drm = &adev->drm;
> 	struct device *dev = adev->dev;
> 	int ret;
>
> +	primary_plane = &adev->primary_plane;
> +	ret = drm_universal_plane_init(drm, primary_plane, 0,
> +				       &appletbdrm_primary_plane_funcs,
> +				       appletbdrm_primary_plane_formats,
> +				       ARRAY_SIZE(appletbdrm_primary_plane_formats),
> +				       NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret)
> +		return ret;
> +	drm_plane_helper_add(primary_plane, &appletbdrm_primary_plane_helper_funcs);
> +
> +	crtc = &adev->crtc;
> +	ret = drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
> +					&appletbdrm_crtc_funcs, NULL);
> +	if (ret)
> +		return ret;
> +	drm_crtc_helper_add(crtc, &appletbdrm_crtc_helper_funcs);
> +
> +	encoder = &adev->encoder;
> +	ret = drm_encoder_init(drm, encoder, &appletbdrm_encoder_funcs,
> +			       DRM_MODE_ENCODER_DAC, NULL);
> +	if (ret)
> +		return ret;
> +	encoder->possible_crtcs = drm_crtc_mask(crtc);
> +
> 	ret = drmm_mode_config_init(drm);

Try to do drmm_mode_config_init() first. The initialization of planes, 
crtcs and encoders requires it. See [1] for how other drivers order 
these calls.

> 	if (ret)
> 		return dev_err_probe(dev, ret, "Failed to initialize mode configuration\n");
> @@ -530,13 +611,13 @@ static int appletbdrm_setup_mode_config(struct appletbdrm_device *adev)
> 	if (ret)
> 		return dev_err_probe(dev, ret, "Failed to set non-desktop property\n");
>
> -	ret = drm_simple_display_pipe_init(drm, &adev->pipe, &appletbdrm_pipe_funcs,
> -					   appletbdrm_formats, ARRAY_SIZE(appletbdrm_formats),
> -					   NULL, &adev->connector);
> +	ret = drm_connector_attach_encoder(connector, encoder);
> +
> 	if (ret)
> 		return dev_err_probe(dev, ret, "Failed to initialize simple display pipe\n");
>
> -	drm_plane_enable_fb_damage_clips(&adev->pipe.plane);

> +	drm_plane_helper_add(primary_plane, &appletbdrm_primary_plane_helper_funcs);

This line can be removed. You've already set the plane helpers a few 
lines above.

> +	drm_plane_enable_fb_damage_clips(&adev->primary_plane);

And this call should better be done next to the plane init. The code at 
[1] again gives you an example of the preferable order.

Best regards
Thomas

[1] 
https://elixir.bootlin.com/linux/v6.13.2/source/drivers/gpu/drm/tiny/bochs.c#L606

>
> 	drm_mode_config_reset(drm);
>
>
> The commit history having both old and new revisions of the driver is here:
>
> https://github.com/AdityaGarg8/apple-touchbar-drv/blob/atomic/usr/src/apple-touchbar-advanced-0.1/appletbdrm.c
>
> Thanks
> Aditya

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


