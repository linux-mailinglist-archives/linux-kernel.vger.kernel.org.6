Return-Path: <linux-kernel+bounces-282973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99A694EB69
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7A2280DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545EA170A08;
	Mon, 12 Aug 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oP2beYPx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQtFJCuO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oP2beYPx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQtFJCuO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D4616F0FE;
	Mon, 12 Aug 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459435; cv=none; b=SpP0w4lO7bpmiPG5Htnmd6ybtBjfjAITs9hsYM59lQhKElF0pMAlxBG6yW6eKJBnBZtAiLdXggtsyXltV1NsNEpCoujEDNuZudR9u/c2am9Kh3caEbU1yUKUfeSp92eARq424FvtNIUXGF2DdZT7zz1spNl9J/Sjp3B1dG7aTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459435; c=relaxed/simple;
	bh=DXBAbx6A9hZ3YdIIGG084DXdJBvQACaZ7iFPGaDcwik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEldAvV35PU8LORC99zEiOHRjFSImaxOmNhKraQXVGju9BAnak3WBh5CwkDer82uXWEvyrBz4gs0Zvby488E54FMwwHbnlHwjTqBuVBsTs/yWWBAwv6e8ZSAG2ece2XwL9AuyiDb2tydmTm4wAL50hQRD9ZmIk7iTZJ3wF6UiCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oP2beYPx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQtFJCuO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oP2beYPx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQtFJCuO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7B6020260;
	Mon, 12 Aug 2024 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723459431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JVvRLrQ3elun+u5uD+SaZoCrJyIIyo14nzqyT8Wbrcg=;
	b=oP2beYPxU68KNXQsLuHHQbduVN2ZnhIidlcGStzO3b70Q/S7nzusYopTRaU5E0IkZtxCCk
	FehLVPjZ2mCnCSf8KT6wBKs7zHetGHYe9vPyAVKLklUXwdjYl5ruIaO7+ABHVVJtrjWC0n
	5xKo8u3Z0jGhBE+UtJ+G9fKEJtxsog8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723459431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JVvRLrQ3elun+u5uD+SaZoCrJyIIyo14nzqyT8Wbrcg=;
	b=kQtFJCuOFPh6DPIBRXwlSGsKZVtGk6JmfCZMMiVBNID4bXwntQngodxXbtDFEUouUYK+0r
	d0K+sr38C3/bZGDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oP2beYPx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kQtFJCuO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723459431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JVvRLrQ3elun+u5uD+SaZoCrJyIIyo14nzqyT8Wbrcg=;
	b=oP2beYPxU68KNXQsLuHHQbduVN2ZnhIidlcGStzO3b70Q/S7nzusYopTRaU5E0IkZtxCCk
	FehLVPjZ2mCnCSf8KT6wBKs7zHetGHYe9vPyAVKLklUXwdjYl5ruIaO7+ABHVVJtrjWC0n
	5xKo8u3Z0jGhBE+UtJ+G9fKEJtxsog8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723459431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JVvRLrQ3elun+u5uD+SaZoCrJyIIyo14nzqyT8Wbrcg=;
	b=kQtFJCuOFPh6DPIBRXwlSGsKZVtGk6JmfCZMMiVBNID4bXwntQngodxXbtDFEUouUYK+0r
	d0K+sr38C3/bZGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FFFD13A23;
	Mon, 12 Aug 2024 10:43:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RxcFFmfnuWYMSAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Aug 2024 10:43:51 +0000
Message-ID: <9ab2e0bb-3c9a-4197-ab73-e0cc82c3efb6@suse.de>
Date: Mon, 12 Aug 2024 12:43:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/ast: astdp: fix loop timeout check
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1ba8da25-2d09-4924-a4ff-c0714bfbb192@stanley.mountain>
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
In-Reply-To: <1ba8da25-2d09-4924-a4ff-c0714bfbb192@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.50 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Rspamd-Queue-Id: A7B6020260

Hi

Am 12.08.24 um 10:29 schrieb Dan Carpenter:
> This code has an issue because it loops until "i" is set to UINT_MAX but
> the test for failure assumes that "i" is set to zero.  The result is that
> it will only print an error message if we succeed on the very last try.
> Reformat the loop to count forwards instead of backwards.
>
> Fixes: 2281475168d2 ("drm/ast: astdp: Perform link training during atomic_enable")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks a lot for the fix. I'll merge it during the week if no other 
comments come in.

Best regards
Thomas

> ---
> v3: V2 had the same bug but just without the always true if (i) statement.
>      Remove the final sleep.
> v2: In V1, I introduced a bug where it would msleep(100) after failure
>      and that is a pointless thing to do.  Also change the loop to a for loop.
> ---
>   drivers/gpu/drm/ast/ast_dp.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index 5d07678b502c..ca022c287785 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -146,18 +146,19 @@ void ast_dp_power_on_off(struct drm_device *dev, bool on)
>   void ast_dp_link_training(struct ast_device *ast)
>   {
>   	struct drm_device *dev = &ast->base;
> -	unsigned int i = 10;
> +	int i;
>   
> -	while (i--) {
> -		u8 vgacrdc = ast_get_index_reg(ast, AST_IO_VGACRI, 0xdc);
> +	for (i = 0; i < 10; i++) {
> +		u8 vgacrdc;
>   
> -		if (vgacrdc & AST_IO_VGACRDC_LINK_SUCCESS)
> -			break;
>   		if (i)
>   			msleep(100);
> +
> +		vgacrdc = ast_get_index_reg(ast, AST_IO_VGACRI, 0xdc);
> +		if (vgacrdc & AST_IO_VGACRDC_LINK_SUCCESS)
> +			return;
>   	}
> -	if (!i)
> -		drm_err(dev, "Link training failed\n");
> +	drm_err(dev, "Link training failed\n");
>   }
>   
>   void ast_dp_set_on_off(struct drm_device *dev, bool on)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


