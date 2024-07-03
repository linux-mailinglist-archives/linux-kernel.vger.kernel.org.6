Return-Path: <linux-kernel+bounces-239027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A53B92550F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE34282AF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AA7139CE2;
	Wed,  3 Jul 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FCCV3Sfu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zk6d+egk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FCCV3Sfu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zk6d+egk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896548F58
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994115; cv=none; b=rzav2YJfw6CNkX6wAyQAFpj5OxNT+t4O1EfrgfngALwoN4rZIK4FyGOnLQSNgzz7df6afEsolrCzHY9CTCSlNcEfO6ab0A3hEuY7M6UhsAjuTSAEH9885jYyK2/HP7nf+vRi8BEq1iCIt/RNkz+SDDBIeyH2Fc9ldFd0FD5r4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994115; c=relaxed/simple;
	bh=xtTvXYG5GZ4VR84vBtTIslxGkqCij1GdBJ/XnWHzp3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mci4PzMt3Ew92X6jjrILDk1NEZIhKm27BDvJbU3OeZT3Tg/Gnx4v7SaO9DQx79AixhTmY4SVPyi4G8h5aWJk4eggdH/P99wlD1HYw+5j782zm0WKI+rK+raQPvWdvGtxqlW8O6qOxrvU80zbTWvbPIgskiLTonl1+lJ+QTdXA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FCCV3Sfu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zk6d+egk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FCCV3Sfu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zk6d+egk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C264F21A35;
	Wed,  3 Jul 2024 08:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719994105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Moc3H8p+XrDovdw3v8ZXZOTn9vngqwF/qRln2sohiBg=;
	b=FCCV3Sfuxi9JjbvWCmLD2riKgWT24pKIKNwmamFu6lrWyRK02IGmWlk2iypWKp4LikSiBR
	uPcx/loO5yQUskDJxkSkFwMBkeyfUIAJjcHnad0OPfnQCcqTGkAoaIohi9F94L4I4Txgur
	OmXA6E3SaMjHdqfBfV503y7tQ9TRFyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719994105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Moc3H8p+XrDovdw3v8ZXZOTn9vngqwF/qRln2sohiBg=;
	b=zk6d+egkTh3QKtTlPUIQsrDZWd6SA8WW4hLOybWcDdOCQjL9I6wtHCfEqhLkyKbK3jXFSS
	ccy/REV9frxNeVBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719994105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Moc3H8p+XrDovdw3v8ZXZOTn9vngqwF/qRln2sohiBg=;
	b=FCCV3Sfuxi9JjbvWCmLD2riKgWT24pKIKNwmamFu6lrWyRK02IGmWlk2iypWKp4LikSiBR
	uPcx/loO5yQUskDJxkSkFwMBkeyfUIAJjcHnad0OPfnQCcqTGkAoaIohi9F94L4I4Txgur
	OmXA6E3SaMjHdqfBfV503y7tQ9TRFyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719994105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Moc3H8p+XrDovdw3v8ZXZOTn9vngqwF/qRln2sohiBg=;
	b=zk6d+egkTh3QKtTlPUIQsrDZWd6SA8WW4hLOybWcDdOCQjL9I6wtHCfEqhLkyKbK3jXFSS
	ccy/REV9frxNeVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E71713889;
	Wed,  3 Jul 2024 08:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 22CZHfkGhWZbPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Jul 2024 08:08:25 +0000
Message-ID: <8653374a-d9a5-4389-8a18-bc7dedba8545@suse.de>
Date: Wed, 3 Jul 2024 10:08:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fbdev-generic: Fix framebuffer on big endian devices
To: Thomas Huth <thuth@redhat.com>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240627173530.460615-1-thuth@redhat.com>
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
In-Reply-To: <20240627173530.460615-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.20
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-0.92)[-0.922];
	NEURAL_HAM_SHORT(-0.19)[-0.958];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[redhat.com,lists.freedesktop.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,linux-m68k.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Merged into drm-misc-fixes.

Am 27.06.24 um 19:35 schrieb Thomas Huth:
> Starting with kernel 6.7, the framebuffer text console is not working
> anymore with the virtio-gpu device on s390x hosts. Such big endian fb
> devices are usinga different pixel ordering than little endian devices,
> e.g. DRM_FORMAT_BGRX8888 instead of DRM_FORMAT_XRGB8888.
>
> This used to work fine as long as drm_client_buffer_addfb() was still
> calling drm_mode_addfb() which called drm_driver_legacy_fb_format()
> internally to get the right format. But drm_client_buffer_addfb() has
> recently been reworked to call drm_mode_addfb2() instead with the
> format value that has been passed to it as a parameter (see commit
> 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()").
>
> That format parameter is determined in drm_fbdev_generic_helper_fb_probe()
> via the drm_mode_legacy_fb_format() function - which only generates
> formats suitable for little endian devices. So to fix this issue
> switch to drm_driver_legacy_fb_format() here instead to take the
> device endianness into consideration.
>
> Fixes: 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()")
> Closes: https://issues.redhat.com/browse/RHEL-45158
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   drivers/gpu/drm/drm_fbdev_generic.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
> index 97e579c33d84..1e200d815e1a 100644
> --- a/drivers/gpu/drm/drm_fbdev_generic.c
> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> @@ -84,7 +84,8 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
>   		    sizes->surface_width, sizes->surface_height,
>   		    sizes->surface_bpp);
>   
> -	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
> +	format = drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
> +					     sizes->surface_depth);
>   	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
>   					       sizes->surface_height, format);
>   	if (IS_ERR(buffer))

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


