Return-Path: <linux-kernel+bounces-538044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC824A493EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B1F16D0F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C6253F3B;
	Fri, 28 Feb 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eouDypAC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iOoYcs4M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eouDypAC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iOoYcs4M"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72C253F13
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732469; cv=none; b=o+l05fO78uKjpVeYSC62CjgyhxTgpWvFC65/LrvG2ihVCk1sneGdGKCEBmJH+VZjA5IiXcBR6hyI8o+QmxgnKKUmkTwLVnGuRjvXIV4zZsMjqhvM16Q4B5oAVgn4jmtnm5ObfShE1CcKvtCK5mIqbDiNOW8U0qhArx8WZRdJPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732469; c=relaxed/simple;
	bh=4Q5oILbXMxrrU4VjcwFUQjMplCK9CtDavEUxQ5bZSAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF/ybB7x9F5Ue1sximxDkn4/4tOg7Ewx5NoZBj2q1MwVez3E/XJcxAb1lwTYS/wGJhcTjLh4p9FArR4NxwN5fYr7dZo+8hx4cv7NxuzE29olUCA6znY8Mz249mIWWUBgoc54snOv4nob7nYILa1RGCYh/r4C1XvUzco7EVBebA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eouDypAC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iOoYcs4M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eouDypAC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iOoYcs4M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B251B1F38F;
	Fri, 28 Feb 2025 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740732465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r5If7arQhwOzI5vcI8gvkSKGFBxrGqK8T2dKZQWOqaY=;
	b=eouDypACCHhxu+DI3Ca9bQINU098CZ4ISQ+MfwqXvY3i8WJY9SAU2N9FE39gBHJrdBdIUk
	+UM+frt3bnxH6O0+fq19OM1Y9xyP1esH9mTbtumvHYdP2p/JJryvYepObedm8kUdOiDuVj
	dFmCkA6glsRPaXOJA3qxL+G4K/v+JJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740732465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r5If7arQhwOzI5vcI8gvkSKGFBxrGqK8T2dKZQWOqaY=;
	b=iOoYcs4MmvDtpRnqRXGAadP4GuFIxX9qnvM6RlkrGxhIzUJiFuxkNVnZYqZ+JDQNd32Utz
	3++z2yC3uQUbRICw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740732465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r5If7arQhwOzI5vcI8gvkSKGFBxrGqK8T2dKZQWOqaY=;
	b=eouDypACCHhxu+DI3Ca9bQINU098CZ4ISQ+MfwqXvY3i8WJY9SAU2N9FE39gBHJrdBdIUk
	+UM+frt3bnxH6O0+fq19OM1Y9xyP1esH9mTbtumvHYdP2p/JJryvYepObedm8kUdOiDuVj
	dFmCkA6glsRPaXOJA3qxL+G4K/v+JJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740732465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r5If7arQhwOzI5vcI8gvkSKGFBxrGqK8T2dKZQWOqaY=;
	b=iOoYcs4MmvDtpRnqRXGAadP4GuFIxX9qnvM6RlkrGxhIzUJiFuxkNVnZYqZ+JDQNd32Utz
	3++z2yC3uQUbRICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7451213888;
	Fri, 28 Feb 2025 08:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bWIQGzF4wWeKQAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 28 Feb 2025 08:47:45 +0000
Message-ID: <f853d48f-f0aa-45af-89f3-4081a620f234@suse.de>
Date: Fri, 28 Feb 2025 09:47:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vboxvideo: Remove unused hgsmi_cursor_position
To: "Dr. David Alan Gilbert" <linux@treblig.org>, airlied@gmail.com,
 simona@ffwll.ch
Cc: hdegoede@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241215220014.452537-1-linux@treblig.org>
 <Z8DaVW_U-QtBVSMf@gallifrey>
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
In-Reply-To: <Z8DaVW_U-QtBVSMf@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[treblig.org,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 27.02.25 um 22:34 schrieb Dr. David Alan Gilbert:
> * linux@treblig.org (linux@treblig.org) wrote:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>
>> hgsmi_cursor_position() has been unused since 2018's
>> commit 35f3288c453e ("staging: vboxvideo: Atomic phase 1: convert cursor to
>> universal plane")
>>
>> Remove it.
>>
>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Hi David, Simona,
>    Will this one be picked up by drm-next?  It got Hans's
> review back on 16 Dec.
> ( in 2513e942-6391-4a96-b487-1e4ba19b7aeb@redhat.com )

Merged into drm-misc-next now. Apologies for the delay.

Best regards
Thomas

>
>    Thanks,
>
> Dave
>
>> ---
>>   drivers/gpu/drm/vboxvideo/hgsmi_base.c      | 37 ---------------------
>>   drivers/gpu/drm/vboxvideo/vboxvideo_guest.h |  2 --
>>   2 files changed, 39 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_base.c b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
>> index 87dccaecc3e5..db994aeaa0f9 100644
>> --- a/drivers/gpu/drm/vboxvideo/hgsmi_base.c
>> +++ b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
>> @@ -181,40 +181,3 @@ int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
>>   
>>   	return rc;
>>   }
>> -
>> -/**
>> - * hgsmi_cursor_position - Report the guest cursor position.  The host may
>> - *                         wish to use this information to re-position its
>> - *                         own cursor (though this is currently unlikely).
>> - *                         The current host cursor position is returned.
>> - * Return: 0 or negative errno value.
>> - * @ctx:              The context containing the heap used.
>> - * @report_position:  Are we reporting a position?
>> - * @x:                Guest cursor X position.
>> - * @y:                Guest cursor Y position.
>> - * @x_host:           Host cursor X position is stored here.  Optional.
>> - * @y_host:           Host cursor Y position is stored here.  Optional.
>> - */
>> -int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
>> -			  u32 x, u32 y, u32 *x_host, u32 *y_host)
>> -{
>> -	struct vbva_cursor_position *p;
>> -
>> -	p = hgsmi_buffer_alloc(ctx, sizeof(*p), HGSMI_CH_VBVA,
>> -			       VBVA_CURSOR_POSITION);
>> -	if (!p)
>> -		return -ENOMEM;
>> -
>> -	p->report_position = report_position;
>> -	p->x = x;
>> -	p->y = y;
>> -
>> -	hgsmi_buffer_submit(ctx, p);
>> -
>> -	*x_host = p->x;
>> -	*y_host = p->y;
>> -
>> -	hgsmi_buffer_free(ctx, p);
>> -
>> -	return 0;
>> -}
>> diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
>> index 55fcee3a6470..643c4448bdcb 100644
>> --- a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
>> +++ b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
>> @@ -34,8 +34,6 @@ int hgsmi_query_conf(struct gen_pool *ctx, u32 index, u32 *value_ret);
>>   int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
>>   			       u32 hot_x, u32 hot_y, u32 width, u32 height,
>>   			       u8 *pixels, u32 len);
>> -int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
>> -			  u32 x, u32 y, u32 *x_host, u32 *y_host);
>>   
>>   bool vbva_enable(struct vbva_buf_ctx *vbva_ctx, struct gen_pool *ctx,
>>   		 struct vbva_buffer *vbva, s32 screen);
>> -- 
>> 2.47.1
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


