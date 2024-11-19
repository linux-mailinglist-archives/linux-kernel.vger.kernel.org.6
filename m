Return-Path: <linux-kernel+bounces-414092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61EB9D22E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6650F1F22840
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600F91C1AC9;
	Tue, 19 Nov 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FBtpbdYJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zyNxIwYm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FBtpbdYJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zyNxIwYm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380D1993B4;
	Tue, 19 Nov 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010330; cv=none; b=IX3Bm5yeV+8UiBRXcjOnUrlqIFzrs1yQzsrWizdLGsXkV/pRuSj+NQuU88GZNLBP2ar+ObHqn6q61FqgB0jwVuAiyh0ME7M2s8v2lTHtN/aNIR7B9moQIpRoyDwABF0H9AXhhu6nbkCJb9rTg6gjo7PpIxZNT9lXoT5J7bToRMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010330; c=relaxed/simple;
	bh=zQIikO0GBs+YujTONJpDT2qcd27uAJI/XYbLhsbKmx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a94Uag1wJCzTYfBgerM7eY3XPz2y26gYqrU2bbh1ltF3bjOBDshS4N2ujQAuMrzTUwvwSQ+QLQNDXI88WNLMJHR+RleGvyC/mhIDTFWn6ZUw39Jzkjh71RpmyQgUVcOsEDwvKggTSOZM5UB8AKugcokEAeYvjB0wo9uHLGFXQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FBtpbdYJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zyNxIwYm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FBtpbdYJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zyNxIwYm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B6541F889;
	Tue, 19 Nov 2024 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732010327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tzJ/Qp5/7cpbxXGfdSBC3oSrdNQ+xYn9ZukBL2E6cUI=;
	b=FBtpbdYJ96udJr+nHNONXfuwgkwdE0dZT5VYZPfk/UzKwX7uU5AJTyPJNYAHUY5ZD7Q4ZH
	0cbk1xN1G0eA0oNoKcZoTVmnsRAfV+Dmoa/AsschvhSIajaPyiDXDJ1hj3bdH1+vJmT+ba
	qTvjrXrPqyuZE038ViJezry1gEkPbww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732010327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tzJ/Qp5/7cpbxXGfdSBC3oSrdNQ+xYn9ZukBL2E6cUI=;
	b=zyNxIwYmpLAZXMYzE/L5Xit7XbiMc4qKs/wjrobQL3izevphz6XpGxDWgEOVECWl6mcfUp
	xTLHhSf1fAsnVgAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732010327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tzJ/Qp5/7cpbxXGfdSBC3oSrdNQ+xYn9ZukBL2E6cUI=;
	b=FBtpbdYJ96udJr+nHNONXfuwgkwdE0dZT5VYZPfk/UzKwX7uU5AJTyPJNYAHUY5ZD7Q4ZH
	0cbk1xN1G0eA0oNoKcZoTVmnsRAfV+Dmoa/AsschvhSIajaPyiDXDJ1hj3bdH1+vJmT+ba
	qTvjrXrPqyuZE038ViJezry1gEkPbww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732010327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tzJ/Qp5/7cpbxXGfdSBC3oSrdNQ+xYn9ZukBL2E6cUI=;
	b=zyNxIwYmpLAZXMYzE/L5Xit7XbiMc4qKs/wjrobQL3izevphz6XpGxDWgEOVECWl6mcfUp
	xTLHhSf1fAsnVgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 931B81376E;
	Tue, 19 Nov 2024 09:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wl81IlZhPGesNgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 19 Nov 2024 09:58:46 +0000
Message-ID: <62557e58-55f1-4260-9357-30a222bb204e@suse.de>
Date: Tue, 19 Nov 2024 10:58:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/i2c: tda9950: Constify struct i2c_device_id
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux@weissschuh.net,
 broonie@kernel.org, lee@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <d0f63518a053a817cec0ad0e7d9241f9eb2a4a8e.1731689044.git.christophe.jaillet@wanadoo.fr>
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
In-Reply-To: <d0f63518a053a817cec0ad0e7d9241f9eb2a4a8e.1731689044.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[wanadoo.fr,weissschuh.net,kernel.org,linux.intel.com,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,wanadoo.fr];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 




Am 15.11.24 um 18:17 schrieb Christophe JAILLET:
> 'struct i2c_device_id' is not modified in this driver.
>
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
>
> On a x86_64, with allmodconfig:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>    12136	    822	      0	  12958	   329e	drivers/gpu/drm/i2c/tda9950.o
>
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>    12200	    758	      0	  12958	   329e	drivers/gpu/drm/i2c/tda9950.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> Compile tested-only.
>
> v2: fix missing const :(
> ---
>   drivers/gpu/drm/i2c/tda9950.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
> index 82d618c40dce..5065d6212fe4 100644
> --- a/drivers/gpu/drm/i2c/tda9950.c
> +++ b/drivers/gpu/drm/i2c/tda9950.c
> @@ -485,7 +485,7 @@ static void tda9950_remove(struct i2c_client *client)
>   	cec_unregister_adapter(priv->adap);
>   }
>   
> -static struct i2c_device_id tda9950_ids[] = {
> +static const struct i2c_device_id tda9950_ids[] = {
>   	{ "tda9950", 0 },
>   	{ },
>   };

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


