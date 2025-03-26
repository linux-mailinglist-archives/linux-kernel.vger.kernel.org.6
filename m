Return-Path: <linux-kernel+bounces-576730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1AA713B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036A8188F08F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0BB1ACEAD;
	Wed, 26 Mar 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QGtMg2U0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xxv2O7WJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QGtMg2U0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xxv2O7WJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8C161310
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981383; cv=none; b=pYKysQNgwKiZj8/jdu1DihqlSSsGT0Z+sgs+4YGHyjngGCfhWoJmn5kwwwuazHshNFoGNa9yHMoQT3SjPwCzG6oD6x3mXexlKFloJQLRZHUMfz0BiA+JEfSRvgb9bTm41bebjqcmtRjQRlfL/anS6OO3i/oCOltvM48FESnGnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981383; c=relaxed/simple;
	bh=XNxiDXdUii5+6jtcVssnK0QG/NSun2SoqoNA+Q5kiMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nx5qv9DcflmC5j1KE8bLwhyR1DubSjKcR02llGgIyCXznIZrdpqlCnC8iJi/NaI0n91P16XKXTCuSbqQOZc5pNT2cM1hkcq8ZJJzUyzu7+RymdoR4+VcmxaWXww+k54DhcB68AiwEzLL0m7B3+fTiNWMoBh4XlSo3W/mcsI2ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QGtMg2U0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xxv2O7WJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QGtMg2U0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xxv2O7WJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47AD81F391;
	Wed, 26 Mar 2025 09:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742981380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NBb0DLxbZ1Xy8lV9iYYVobxQWtWXO/9x6FdnTg4oeN8=;
	b=QGtMg2U0W13REvRyAO6iDul3Ln6Bx540Pebz0AnigxAlctpaW5tnp/Tr9s107PyFC16lzg
	rNczVYQsyqUn7Lp9J6TfMsoKosduFhkUL+TGCCal108Z0OOnYWlOGcjC+qmxevt3TRpvn+
	1eB1Zj9AhorFqlWNVmDZb6rn7c5Y+JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742981380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NBb0DLxbZ1Xy8lV9iYYVobxQWtWXO/9x6FdnTg4oeN8=;
	b=Xxv2O7WJ45F+uM7cVwGdJbh1i6TGufa2DOjjrVXsA7xVB5GzhRyBVfpnYRhe0Nx1K4Zjqx
	Bu2fT1EhfApvJlCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742981380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NBb0DLxbZ1Xy8lV9iYYVobxQWtWXO/9x6FdnTg4oeN8=;
	b=QGtMg2U0W13REvRyAO6iDul3Ln6Bx540Pebz0AnigxAlctpaW5tnp/Tr9s107PyFC16lzg
	rNczVYQsyqUn7Lp9J6TfMsoKosduFhkUL+TGCCal108Z0OOnYWlOGcjC+qmxevt3TRpvn+
	1eB1Zj9AhorFqlWNVmDZb6rn7c5Y+JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742981380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NBb0DLxbZ1Xy8lV9iYYVobxQWtWXO/9x6FdnTg4oeN8=;
	b=Xxv2O7WJ45F+uM7cVwGdJbh1i6TGufa2DOjjrVXsA7xVB5GzhRyBVfpnYRhe0Nx1K4Zjqx
	Bu2fT1EhfApvJlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC3061374A;
	Wed, 26 Mar 2025 09:29:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eRKQNAPJ42fQZAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Mar 2025 09:29:39 +0000
Message-ID: <65cd8976-3e07-4886-8eaa-f9a6094f6f1e@suse.de>
Date: Wed, 26 Mar 2025 10:29:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/edid: Use unsigned int in drm_add_modes_noedid()
To: Lyude Paul <lyude@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 "open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>
References: <20250325212823.669459-1-lyude@redhat.com>
 <20250325212823.669459-2-lyude@redhat.com>
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
In-Reply-To: <20250325212823.669459-2-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,gmail.com,ffwll.ch,kernel.org,garyguo.net,protonmail.com,proton.me,google.com,umich.edu,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,bootlin.com:url]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 25.03.25 um 22:27 schrieb Lyude Paul:
> A negative resolution doesn't really make any sense, no one goes into a TV
> store and says "Hello sir, I would like a negative 4K TV please", that
> would make everyone look at you funny.
>
> So, let's make these parameters a bit more reasonable and ensure that
> they're unsigned - which makes the resulting rust bindings for this
> function a bit easier to understand and work with.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_edid.c | 2 +-
>   include/drm/drm_edid.h     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 13bc4c290b17d..2e2e1d2347397 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -7099,7 +7099,7 @@ EXPORT_SYMBOL(drm_add_edid_modes);
>    * Return: The number of modes added or 0 if we couldn't find any.
>    */
>   int drm_add_modes_noedid(struct drm_connector *connector,
> -			int hdisplay, int vdisplay)
> +			 unsigned int hdisplay, unsigned int vdisplay)

You should also remove these branches:

  https://elixir.bootlin.com/linux/v6.13.7/source/drivers/gpu/drm/drm_edid.c#L7109

Best regards
Thomas

>   {
>   	int i, count, num_modes = 0;
>   	struct drm_display_mode *mode;
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index eaac5e665892a..b38409670868d 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -437,7 +437,7 @@ bool drm_detect_monitor_audio(const struct edid *edid);
>   enum hdmi_quantization_range
>   drm_default_rgb_quant_range(const struct drm_display_mode *mode);
>   int drm_add_modes_noedid(struct drm_connector *connector,
> -			 int hdisplay, int vdisplay);
> +			 unsigned int hdisplay, unsigned int vdisplay);
>   
>   int drm_edid_header_is_valid(const void *edid);
>   bool drm_edid_is_valid(struct edid *edid);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


