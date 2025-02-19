Return-Path: <linux-kernel+bounces-521031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87FA3B2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD41F171F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919F1C3C12;
	Wed, 19 Feb 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CaP6o4M8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fg+6U9lP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="znwyIw5A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CytNWTwG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377B1C1AB4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951840; cv=none; b=a1ARmejPvIlsOM3VFVo6HHBAB4uFzArETc8RqIpt27pu2TFdAU74lVAcEG98rBROfIbi7lv4hd/W2NCR/0I3naQbu2Lmbh+pQsQFVuWLU9o+sE9cqAF/qX28jOhqkx6flmiIssq1AdGjQwW/jVVHbuqg7kFGAVWaYPVavxKPX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951840; c=relaxed/simple;
	bh=Lq/QgHp+/lRpL7BbEfxDVPqPeaGR9JP5sVWOxp22LMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JK4tVvFqdf3r2jvpuka5wZ+GseMknb1F61mW4C4faiZvq5NhUg1esxiLiEllWrLGVlKGYtJu5JTgct9CgILyKPkCcBlh0YLXPXRxWP9lA7b0oDVrtTS3tLNXzbMZNOM0Ny9IMn25fhLHruO3LLqNsOUn1DRKWPdnojVmdIHBUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=fail smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CaP6o4M8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fg+6U9lP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=znwyIw5A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CytNWTwG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBD3A21F92;
	Wed, 19 Feb 2025 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739951837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=epgq9lhcK/GD6iEOWEZ2braEaMsDndp1rBFaDGg7IBw=;
	b=CaP6o4M8vRhiQUu5VSmmzBaVelQVinAk1Oh0X0pMpiz5b7ZQldqzDzR8epuiCGXvy88P+o
	/GEcig+VRO56Rb4CrGnud6ExWeYuXsL9BN639LhrB9ON3Vs1pZ8igLTRh+iOmyeVZlyDYg
	0Pn2wBkkmN5RZR0WY0bq/ofXK52iEY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739951837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=epgq9lhcK/GD6iEOWEZ2braEaMsDndp1rBFaDGg7IBw=;
	b=fg+6U9lP2fgNnvwWL4pj6yoYhnElxSQd7wofN+flOF2fT28rPstJhMmb7g03LKRu7Lehap
	ndiBBIxLqy8dbCBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739951836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=epgq9lhcK/GD6iEOWEZ2braEaMsDndp1rBFaDGg7IBw=;
	b=znwyIw5A4Mzs2Wno0Oir3iCFbMEJWHahtzoHKB6YiXXaZCITB2qi4OVdHIuUt6q7SPJlzk
	IPfb7MuejOocvRosia3XEjdq0OT2OcUA7FS6xEBybz/L8DogyMXTlBxyQRjVQ7am2bMG+L
	3DYMXjdUoF+rcIWXi1iGt0kYj1yH8dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739951836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=epgq9lhcK/GD6iEOWEZ2braEaMsDndp1rBFaDGg7IBw=;
	b=CytNWTwGIq+7idS/URVkUFkLhrRlnsyS3Kat4OISgqGgdBX6SeIigKt4RCOqWhhY0MyahY
	8aPA8EabosL5KrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD60D13806;
	Wed, 19 Feb 2025 07:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c7j6KNyOtWd+EwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 19 Feb 2025 07:57:16 +0000
Message-ID: <81826e1b-1ec8-4665-9682-2a57c95f06d3@suse.de>
Date: Wed, 19 Feb 2025 08:57:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/tiny: add driver for Apple Touch Bars in x86 Macs
To: Aditya Garg <gargaditya08@live.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, Kerem Karabay <kekrby@gmail.com>,
 Atharva Tiwari <evepolonium@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <4BAFD886-84E0-4C4C-94B3-90BF911ED0E7@live.com>
 <F16BB9EB-632C-4BC4-A8BA-492BF32E43C1@live.com>
 <d9304ed0-911b-4877-a15c-981b3335bbf9@suse.de>
 <BC25CBDD-D101-49DA-B10B-F47F1CAE2A6F@live.com>
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
In-Reply-To: <BC25CBDD-D101-49DA-B10B-F47F1CAE2A6F@live.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[live.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,bootlin.com:url]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi

Am 18.02.25 um 21:12 schrieb Aditya Garg:
> Hi
>
> In continuation to my previous mail.
>
>>> +
>>> +static int appletbdrm_send_msg(struct appletbdrm_device *adev, u32 msg)
>>> +{
>>> + struct appletbdrm_msg_simple_request *request;
>>> + int ret;
>>> +
>>> + request = kzalloc(sizeof(*request), GFP_KERNEL);
>>> + if (!request)
>>> + return -ENOMEM;
>>> +
>>> + request->header.unk_00 = cpu_to_le16(2);
>>> + request->header.unk_02 = cpu_to_le16(0x1512);
>>> + request->header.size = cpu_to_le32(sizeof(*request) - sizeof(request->header));
>>> + request->msg = msg;
>>> + request->size = request->header.size;
>>> +
>>> + ret = appletbdrm_send_request(adev, &request->header, sizeof(*request));
>>> +
>>> + kfree(request);
>> This is temporary data for the send operation and save to free here?
> Probably yes. If I understand correctly, it’s needed to make the touchbar go into the display mode, from the hid keyboard mode.
>
> We here are doing the same as the Windows driver [1] for this does.
>
> [1] https://github.com/imbushuo/DFRDisplayKm/blob/master/src/DFRDisplayKm/include/Dfr.h#L3

Yeah. My concern was that request is being freed while the USB send 
operation is still using it. But in the USB code, it doesn't look like that.

[...]
>> Can we void the use of drm_fb_blit()? Since you know all formats in advance, just do
>>
>> switch (format)
>> case XRGB8888: drm_fb_xrgb888_to_bgr888() break default:
>>     drm_fb_memcpy() break }We use blit in simpledrm and ofdrm, where we don't know the formats and output buffers in advance. But it's really not so great in other drivers, I think.
> I think you mean this:
>
> #include <drm/drm_framebuffer.h>
>
> 		switch (fb->format->format) {
> 		case DRM_FORMAT_XRGB8888:
> 			drm_fb_xrgb8888_to_bgr888(&dst, NULL, &shadow_plane_state->data[0], fb, &damage, &shadow_plane_state->fmtcnv_state);
> 			break;
> 		default:
> 			drm_fb_memcpy(&dst, NULL, &shadow_plane_state->data[0], fb, &damage);
> 			break;
> 		}

Yes.

[...]
>> For USB devices, we need special wiring to make PRIME work. The PRIME device must support DMA, but a USB device doesn't. So we pass the USB controller device instead. See [2] for what udl does and how it obtains dmadev.
>>
>> [2] https://elixir.bootlin.com/linux/v6.14-rc3/source/drivers/gpu/drm/udl/udl_drv.c#L76
> Disregard my previous reply for this. I believe you meant by this?:
>
> —>8—
>  From b6fda730995b7f28374c1ff38778a6f3e6da65da Mon Sep 17 00:00:00 2001
> From: Aditya Garg <gargaditya08@live.com>
> Date: Tue, 18 Feb 2025 22:47:44 +0530
> Subject: [PATCH] prime
>
> ---
> drivers/gpu/drm/tiny/appletbdrm.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
> index f2d911325..b835063c2 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -118,6 +118,7 @@ struct appletbdrm_fb_request_response {
>
> struct appletbdrm_device {
> 	struct device *dev;
> +	struct device *dmadev;
>
> 	unsigned int in_ep;
> 	unsigned int out_ep;
> @@ -521,10 +522,22 @@ static const struct drm_encoder_funcs appletbdrm_encoder_funcs = {
> 	.destroy = drm_encoder_cleanup,
> };
>
> +static struct drm_gem_object *appletbdrm_driver_gem_prime_import(struct drm_device *dev,
> +								 struct dma_buf *dma_buf)
> +{
> +	struct appletbdrm_device *adev = drm_to_adev(dev);
> +
> +	if (!adev->dmadev)
> +		return ERR_PTR(-ENODEV);
> +
> +	return drm_gem_prime_import_dev(dev, dma_buf, adev->dmadev);
> +}
> +
> DEFINE_DRM_GEM_FOPS(appletbdrm_drm_fops);
>
> static const struct drm_driver appletbdrm_drm_driver = {
> 	DRM_GEM_SHMEM_DRIVER_OPS,
> +	.gem_prime_import	= appletbdrm_driver_gem_prime_import,

Exactly. The TODO item for this problem is at [1], but there's quite a 
bit of change involved to fix it. Setting a dedicated DMA device is the 
next best thing.

[1] 
https://elixir.bootlin.com/linux/v6.13.3/source/Documentation/gpu/todo.rst#L615

Best regards
Thomas

> 	.name			= "appletbdrm",
> 	.desc			= "Apple Touch Bar DRM Driver",
> 	.major			= 1,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


