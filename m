Return-Path: <linux-kernel+bounces-563584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468CDA644BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2162D3AA952
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389C21B9C5;
	Mon, 17 Mar 2025 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X+km7m3T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qngA0eAx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X+km7m3T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qngA0eAx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19837217709
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198982; cv=none; b=uGcvobscOd2vpHz47qNPd1WaZXfyemthYE507ElODqO60X1gnnQSr+5a3gbe2uwzg9QYuo0+sxKDpyseJo+waZOzIu8cDQrXu+E1DgJDM45zrI7rBc45XaI3Xzbi7AgNXzGa2fSQeVLzGRhxKRjVT6jZMCp7kAwozgrxeMfSjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198982; c=relaxed/simple;
	bh=AFMU4dM5tJOK31s1+wnsrnYJEuCkOsbKBTL/7dEAPKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOg+Cd+ItfB/usuSH9QR0Y8dr92B+urdSAdx2orJeqAXA1pqb6zoTxpGe0GSAv5jzclzOmAjbNHYv23owIHnmpyWZhzAoFkgN5HwCgR7SrFMsmn2dZAda182wUwjRuPi3OcfjZvV4rkoVytHE1RhQMrsopt+2YlQ328yUihtMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X+km7m3T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qngA0eAx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X+km7m3T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qngA0eAx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2323D22006;
	Mon, 17 Mar 2025 08:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742198979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rXRQ/emhIb2I9c0u7jQxhIwQqoPFpVA6Pspwj45/DTY=;
	b=X+km7m3Tmdi+bWFoIQeos+dtK3my+jWR9tBfdK/bGgBdatMefl2IflTYY1knh0RUfwcOLG
	BA80bt463TJG9nE8hS7BTASUGoM5Ox5ReMKybnccCisplEdGa95YI89QhzjUelM11pElki
	hniUern8nl7z83MzYuR9M9mIbY7oSv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742198979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rXRQ/emhIb2I9c0u7jQxhIwQqoPFpVA6Pspwj45/DTY=;
	b=qngA0eAxDtN1jn8JWqOGktZXAdbgc1Pk/eKyXl0clZxMFqGPGHk95gTR6dme2V01gSYpcq
	SewMUzgHWSLHq5BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742198979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rXRQ/emhIb2I9c0u7jQxhIwQqoPFpVA6Pspwj45/DTY=;
	b=X+km7m3Tmdi+bWFoIQeos+dtK3my+jWR9tBfdK/bGgBdatMefl2IflTYY1knh0RUfwcOLG
	BA80bt463TJG9nE8hS7BTASUGoM5Ox5ReMKybnccCisplEdGa95YI89QhzjUelM11pElki
	hniUern8nl7z83MzYuR9M9mIbY7oSv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742198979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rXRQ/emhIb2I9c0u7jQxhIwQqoPFpVA6Pspwj45/DTY=;
	b=qngA0eAxDtN1jn8JWqOGktZXAdbgc1Pk/eKyXl0clZxMFqGPGHk95gTR6dme2V01gSYpcq
	SewMUzgHWSLHq5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AED7B132CF;
	Mon, 17 Mar 2025 08:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6moRKcLY12cRdQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Mar 2025 08:09:38 +0000
Message-ID: <12145722-609e-41d0-b02b-059df5b6d17f@suse.de>
Date: Mon, 17 Mar 2025 09:09:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] drm/i915/display: Fix build error without
 DRM_FBDEV_EMULATION
To: Yue Haibing <yuehaibing@huawei.com>, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, dev@lankhorst.se
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250315120143.2344958-1-yuehaibing@huawei.com>
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
In-Reply-To: <20250315120143.2344958-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[huawei.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,lankhorst.se];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,huawei.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO



Am 15.03.25 um 13:01 schrieb Yue Haibing:
> In file included from <command-line>:
> ./drivers/gpu/drm/i915/display/intel_fbdev.h: In function ‘intel_fbdev_framebuffer’:
> ./drivers/gpu/drm/i915/display/intel_fbdev.h:32:16: error: ‘NULL’ undeclared (first use in this function)
>     32 |         return NULL;
>        |                ^~~~
> ./drivers/gpu/drm/i915/display/intel_fbdev.h:1:1: note: ‘NULL’ is defined in header ‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?
>    +++ |+#include <stddef.h>
>      1 | /* SPDX-License-Identifier: MIT */
> ./drivers/gpu/drm/i915/display/intel_fbdev.h:32:16: note: each undeclared identifier is reported only once for each function it appears in
>     32 |         return NULL;
>        |                ^~~~
>
> Build fails if CONFIG_DRM_FBDEV_EMULATION is n, add missing header file.
>
> Fixes: 9fa154f40eb6 ("drm/{i915,xe}: Run DRM default client setup")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/i915/display/intel_fbdev.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.h b/drivers/gpu/drm/i915/display/intel_fbdev.h
> index ca2c8c438f02..89bad3a2b01a 100644
> --- a/drivers/gpu/drm/i915/display/intel_fbdev.h
> +++ b/drivers/gpu/drm/i915/display/intel_fbdev.h
> @@ -6,6 +6,8 @@
>   #ifndef __INTEL_FBDEV_H__
>   #define __INTEL_FBDEV_H__
>   
> +#include <linux/types.h>
> +
>   struct drm_fb_helper;
>   struct drm_fb_helper_surface_size;
>   struct drm_i915_private;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


