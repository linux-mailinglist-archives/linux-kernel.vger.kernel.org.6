Return-Path: <linux-kernel+bounces-251904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F05A930B5F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45350281405
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01A413C833;
	Sun, 14 Jul 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MQj4nYce";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SZvjZoZE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MQj4nYce";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SZvjZoZE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F065910A22
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720986074; cv=none; b=Kr51f2mOESIxExR+bFfJzPtCD1fuYzNy/t8Zq0gzE5ZXSeahNUyzzz3jiPciPfLwvnyzMWCISznixfgezr0Z6OUUDn3A/aBuGKOPIZoMa6Fbcc/sOAtX6EW0BkSGRDtTBpDE7LWktZf47t0O6GUNYUttyo9mgdedVMAuv5o4i9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720986074; c=relaxed/simple;
	bh=/sNJrD+V9BtVFk3KnBwIWdWkU8HgOFokh95G82JfR+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTXqfZMspya4PB5Sb+6ecKvtfhIL5dsIYUCdk90L9cITUbcwf9PZdx2LIGAXOcsuvhT1i3Y/gJkI3AqLiB89MCfuBqRMtS3v/ZHo5sW4tuv1dPPTiqQzTUIp3soO+h1IY9TOh+IjZp17IQ/rkxGFTmprzqooxDw+X1Ta7Y0W0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MQj4nYce; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SZvjZoZE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MQj4nYce; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SZvjZoZE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 139951F7DA;
	Sun, 14 Jul 2024 19:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720986071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i3SpeDvYny1C+vfkie/uYx3wo947EUL3CjYwQhAer30=;
	b=MQj4nYcejLaYbBrg56uH3YivAfAtZ3YA+pZDg787fc8JqdJ5HnxqhheBFlB6kZ8J2vOsJ7
	IqDnh3hSGUMi7M0FHanwELaFRbA6JFVCVMfzHbi7H5+rrndCLA6UPdeLJthZqkzcwVrrUV
	xJuEF3BKbOmoHmRlbLsbE9r0R/01krg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720986071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i3SpeDvYny1C+vfkie/uYx3wo947EUL3CjYwQhAer30=;
	b=SZvjZoZEP6gL3nJr/ahHMPfeI17MdZslPbaegf82FGwAoRRY8S1nPFcwtuuqPyA7MoGLdL
	fDH3Y7hwyskhV9Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720986071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i3SpeDvYny1C+vfkie/uYx3wo947EUL3CjYwQhAer30=;
	b=MQj4nYcejLaYbBrg56uH3YivAfAtZ3YA+pZDg787fc8JqdJ5HnxqhheBFlB6kZ8J2vOsJ7
	IqDnh3hSGUMi7M0FHanwELaFRbA6JFVCVMfzHbi7H5+rrndCLA6UPdeLJthZqkzcwVrrUV
	xJuEF3BKbOmoHmRlbLsbE9r0R/01krg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720986071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i3SpeDvYny1C+vfkie/uYx3wo947EUL3CjYwQhAer30=;
	b=SZvjZoZEP6gL3nJr/ahHMPfeI17MdZslPbaegf82FGwAoRRY8S1nPFcwtuuqPyA7MoGLdL
	fDH3Y7hwyskhV9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7EBA137AC;
	Sun, 14 Jul 2024 19:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id //wyK9YplGbiPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Sun, 14 Jul 2024 19:41:10 +0000
Message-ID: <bef8086b-754e-4260-b3b5-e45744a714ab@suse.de>
Date: Sun, 14 Jul 2024 21:41:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: Fix cpu_to_le16()/le16_to_cpu() warnings
To: =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
 rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com, mairacanal@riseup.net, hamohammed.sa@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, louis.chauvet@bootlin.com
References: <20240712161656.7480-1-jose.exposito89@gmail.com>
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
In-Reply-To: <20240712161656.7480-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 1.21
X-Spamd-Result: default: False [1.21 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,riseup.net,ffwll.ch,linux.intel.com,kernel.org,lists.freedesktop.org,vger.kernel.org,bootlin.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: *

Hi

Am 12.07.24 um 18:16 schrieb José Expósito:
> Building with Sparse enabled prints this warning for cpu_to_le16()
> calls:
>
>      warning: incorrect type in assignment (different base types)
>          expected unsigned short [usertype]
>          got restricted __le16 [usertype]
>
> And this warning for le16_to_cpu() calls:
>
>      warning: cast to restricted __le16
>
> Add casts to fix both warnings.
>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 32 ++++++++++++++---------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 36046b12f296..053fa6ce41a9 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -77,10 +77,10 @@ static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
>   {
>   	u16 *pixels = (u16 *)src_pixels;

You should rather declare pixels as __le16 pointer. Same for the other 
changes. See [1] for an example.

Best regards
Thomas

[1] 
https://elixir.bootlin.com/linux/v6.9/source/drivers/gpu/drm/drm_format_helper.c#L420

>   
> -	out_pixel->a = le16_to_cpu(pixels[3]);
> -	out_pixel->r = le16_to_cpu(pixels[2]);
> -	out_pixel->g = le16_to_cpu(pixels[1]);
> -	out_pixel->b = le16_to_cpu(pixels[0]);
> +	out_pixel->a = le16_to_cpu((__force __le16)pixels[3]);
> +	out_pixel->r = le16_to_cpu((__force __le16)pixels[2]);
> +	out_pixel->g = le16_to_cpu((__force __le16)pixels[1]);
> +	out_pixel->b = le16_to_cpu((__force __le16)pixels[0]);
>   }
>   
>   static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> @@ -88,9 +88,9 @@ static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
>   	u16 *pixels = (u16 *)src_pixels;
>   
>   	out_pixel->a = (u16)0xffff;
> -	out_pixel->r = le16_to_cpu(pixels[2]);
> -	out_pixel->g = le16_to_cpu(pixels[1]);
> -	out_pixel->b = le16_to_cpu(pixels[0]);
> +	out_pixel->r = le16_to_cpu((__force __le16)pixels[2]);
> +	out_pixel->g = le16_to_cpu((__force __le16)pixels[1]);
> +	out_pixel->b = le16_to_cpu((__force __le16)pixels[0]);
>   }
>   
>   static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> @@ -100,7 +100,7 @@ static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
>   	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
>   	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
>   
> -	u16 rgb_565 = le16_to_cpu(*pixels);
> +	u16 rgb_565 = le16_to_cpu((__force __le16)*pixels);
>   	s64 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
>   	s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
>   	s64 fp_b = drm_int2fixp(rgb_565 & 0x1f);
> @@ -180,10 +180,10 @@ static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
>   {
>   	u16 *pixels = (u16 *)dst_pixels;
>   
> -	pixels[3] = cpu_to_le16(in_pixel->a);
> -	pixels[2] = cpu_to_le16(in_pixel->r);
> -	pixels[1] = cpu_to_le16(in_pixel->g);
> -	pixels[0] = cpu_to_le16(in_pixel->b);
> +	pixels[3] = (__force u16)cpu_to_le16(in_pixel->a);
> +	pixels[2] = (__force u16)cpu_to_le16(in_pixel->r);
> +	pixels[1] = (__force u16)cpu_to_le16(in_pixel->g);
> +	pixels[0] = (__force u16)cpu_to_le16(in_pixel->b);
>   }
>   
>   static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> @@ -191,9 +191,9 @@ static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
>   	u16 *pixels = (u16 *)dst_pixels;
>   
>   	pixels[3] = 0xffff;
> -	pixels[2] = cpu_to_le16(in_pixel->r);
> -	pixels[1] = cpu_to_le16(in_pixel->g);
> -	pixels[0] = cpu_to_le16(in_pixel->b);
> +	pixels[2] = (__force u16)cpu_to_le16(in_pixel->r);
> +	pixels[1] = (__force u16)cpu_to_le16(in_pixel->g);
> +	pixels[0] = (__force u16)cpu_to_le16(in_pixel->b);
>   }
>   
>   static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> @@ -211,7 +211,7 @@ static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>   	u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
>   	u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
>   
> -	*pixels = cpu_to_le16(r << 11 | g << 5 | b);
> +	*pixels = (__force u16)cpu_to_le16(r << 11 | g << 5 | b);
>   }
>   
>   void vkms_writeback_row(struct vkms_writeback_job *wb,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


