Return-Path: <linux-kernel+bounces-237367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA91E91EFC6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD2FB243CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316DE12FF7B;
	Tue,  2 Jul 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dHYQUbOg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TwtnFXqT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dHYQUbOg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TwtnFXqT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129E12F5B8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719904489; cv=none; b=n+KlBN7zT6UqfgyfezsWByZENkQAYOjACd+09XY+6/V2pvmX593mGeJ3YerWHvD1Q+XlwCpXpUrbIjjHVvdS2z5FwuvObo2gdT6laEqMuNcLapFywjsiWBAawe7slVCSQT93Os9qd0LdO64tK6A/O9U+5hNN6VV0CAY9sttpS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719904489; c=relaxed/simple;
	bh=I7nd5tezkfUAfQgOQr5TpVAZP/Yy7DubQzC2dVaZySg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTvlsuL96mswdBosWixJIeGE3lX8KdGCXDNKaVtTKM7/2IPvpBOcJhgU+hHwIBrP09RWXYG32wDAdUdXRKDuWH5e2rELaDB5+2Ajf9C9uc8T/RBjuAZWkeoqz/bnXXojWyJfUryUpICX4wks/T5JDPMrrXpni/s6RjBpBBMkL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dHYQUbOg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TwtnFXqT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dHYQUbOg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TwtnFXqT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FF3E21AD7;
	Tue,  2 Jul 2024 07:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719904480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jPLI0h+9mMhtyorh8WHEAvQp94mjrnoqUJjSedScXFU=;
	b=dHYQUbOgnrQ309W6XnOyaHPLeR69jnfRa7EMR10A6Ra6gSowhK3wHzC8q39009ghGFJyKO
	rDcQwP9k7xITsNV91zYcX/VdgIkEy2HPWsXSzB2LKFGzxULcAChFufuNWyViH7+bgL/Z0t
	R1+Gcl75a54w0GP5JY8xvQ+eYU4iiek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719904480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jPLI0h+9mMhtyorh8WHEAvQp94mjrnoqUJjSedScXFU=;
	b=TwtnFXqT5ZM8trtFCaNFuDEqW8ORIDGAzdpQGNUhECjUSvA+tJ5cZUEZQQZf7LCiSY6pK3
	7pt2pkMBYKirdXDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719904480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jPLI0h+9mMhtyorh8WHEAvQp94mjrnoqUJjSedScXFU=;
	b=dHYQUbOgnrQ309W6XnOyaHPLeR69jnfRa7EMR10A6Ra6gSowhK3wHzC8q39009ghGFJyKO
	rDcQwP9k7xITsNV91zYcX/VdgIkEy2HPWsXSzB2LKFGzxULcAChFufuNWyViH7+bgL/Z0t
	R1+Gcl75a54w0GP5JY8xvQ+eYU4iiek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719904480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jPLI0h+9mMhtyorh8WHEAvQp94mjrnoqUJjSedScXFU=;
	b=TwtnFXqT5ZM8trtFCaNFuDEqW8ORIDGAzdpQGNUhECjUSvA+tJ5cZUEZQQZf7LCiSY6pK3
	7pt2pkMBYKirdXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C401C1395F;
	Tue,  2 Jul 2024 07:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KxacLt+og2bXfwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 02 Jul 2024 07:14:39 +0000
Message-ID: <800eca64-2815-424e-935a-ecd6298a6a2a@suse.de>
Date: Tue, 2 Jul 2024 09:14:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fbdev-generic: Fix framebuffer on big endian devices
To: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Huth <thuth@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240627173530.460615-1-thuth@redhat.com>
 <571556ed-17d2-4bcc-bb1f-fd4f827829c6@suse.de>
 <2108ac92-e241-4507-a759-c23de90d041e@redhat.com>
 <CAMuHMdWf3bE5UdFHoer_iVXeMwfqMpFeAFppo0dzyzL0zeU55A@mail.gmail.com>
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
In-Reply-To: <CAMuHMdWf3bE5UdFHoer_iVXeMwfqMpFeAFppo0dzyzL0zeU55A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org,redhat.com,amd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

Hi

Am 01.07.24 um 10:54 schrieb Geert Uytterhoeven:
> Hi Thomas,
>
> On Mon, Jul 1, 2024 at 10:42 AM Thomas Huth <thuth@redhat.com> wrote:
>> On 28/06/2024 08.07, Thomas Zimmermann wrote:
>>> Am 27.06.24 um 19:35 schrieb Thomas Huth:
>>>> Starting with kernel 6.7, the framebuffer text console is not working
>>>> anymore with the virtio-gpu device on s390x hosts. Such big endian fb
>>>> devices are usinga different pixel ordering than little endian devices,
>>>> e.g. DRM_FORMAT_BGRX8888 instead of DRM_FORMAT_XRGB8888.
>>>>
>>>> This used to work fine as long as drm_client_buffer_addfb() was still
>>>> calling drm_mode_addfb() which called drm_driver_legacy_fb_format()
>>>> internally to get the right format. But drm_client_buffer_addfb() has
>>>> recently been reworked to call drm_mode_addfb2() instead with the
>>>> format value that has been passed to it as a parameter (see commit
>>>> 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to
>>>> drm_mode_addfb2()").
>>>>
>>>> That format parameter is determined in drm_fbdev_generic_helper_fb_probe()
>>>> via the drm_mode_legacy_fb_format() function - which only generates
>>>> formats suitable for little endian devices. So to fix this issue
>>>> switch to drm_driver_legacy_fb_format() here instead to take the
>>>> device endianness into consideration.
>>>>
>>>> Fixes: 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to
>>>> drm_mode_addfb2()")
>>>> Closes: https://issues.redhat.com/browse/RHEL-45158
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>
>>>
>>>> ---
>>>>    drivers/gpu/drm/drm_fbdev_generic.c | 3 ++-
>>> This file is now called drm_fbdev_ttm.c in drm-misc-next.
>> Oh, ok, shall I send a v2 that is adjusted to that change, or can it be
>> fixed while applying my patch?
> As this is a regression in mainline, which needs to be backported,
> too, it's best to apply your fix to v6.10-rc6, which does not have
> drm_fbdev_ttm.c yet.

I guess we can put the current fix into drm-misc-fixes.

>
>>> And a similar patch might be necessary for drm_fbdev_dma.c.
>> Looks similar, indeed. Shall I send a patch for that one, too? ... I
>> currently don't have a setup for testing that, though...

It's up to you. You'd need drm-misc-next from 
https://gitlab.freedesktop.org/drm/misc/kernel

Best regards
Thomas

> Obviously these need to be fixed, too.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


