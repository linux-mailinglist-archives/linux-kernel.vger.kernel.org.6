Return-Path: <linux-kernel+bounces-559732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F153A5F8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C001E7AD48B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7398A267F7F;
	Thu, 13 Mar 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t3e0afZS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iYXDxEp8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t3e0afZS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iYXDxEp8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12371267F4E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876847; cv=none; b=YBkeUxCFIBGXU9h+T+A6u7mf6u45w/osmWRD5FZsZX+nfj6+HF9kxYRAPdYhsKEXn+OjUkAYvjII63TSJDIoFqWI9KK6SM/SbAMSWcv+izfIufrfJZFbKD1Li6rt9xtEu3O0ZB9afjEpuuiV1XVEZ5nnUgraAnP1KEBqRD2ZDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876847; c=relaxed/simple;
	bh=+vC0AmVh0P4bj1VYeHozzCLLENrPxucZGleRivtLPew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YI+ZUpBODKzLcpHJPhTC13wnAtAvhw0oPX05AWLoZloDPT9gUH7b2t046wh60FH5LqZmLtPIbiixEJIoMOcNSfxB09YZzbR3BrxYdUO80ppdSwR+yXqVgbK6mPcQ+4DlL5ZiZO4g+9ABBXoHSA2lX5gI31xH4oreL0AmpxKKGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t3e0afZS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iYXDxEp8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t3e0afZS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iYXDxEp8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 152E821194;
	Thu, 13 Mar 2025 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741876844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jo/jk4JFe8UCdTh0ifv3q1KeaASwi/COhWBjjuCpOAY=;
	b=t3e0afZSr4tB5TWd9p1l3Xg3P4T9ZsFv1m67GInUpkWRavTekwOHZutU+eHwMTcfLixvdw
	imaEoFV73kb0ukTehoxQ0ij9a1Q8b1aEO7Rjbr/Q3zUaG6PNKoNSmvgpp/4VrV0uToEh34
	YzqHi95DEtCmp9oWOhGOMIqB3ds618E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741876844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jo/jk4JFe8UCdTh0ifv3q1KeaASwi/COhWBjjuCpOAY=;
	b=iYXDxEp8QkAk+JFxi5orXM+p4IfQSSF98Bb8a/lxBHcua3cbSKBqVjJfLnbP06Qu8DyA27
	QE0BPLcw7dcQwtAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t3e0afZS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iYXDxEp8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741876844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jo/jk4JFe8UCdTh0ifv3q1KeaASwi/COhWBjjuCpOAY=;
	b=t3e0afZSr4tB5TWd9p1l3Xg3P4T9ZsFv1m67GInUpkWRavTekwOHZutU+eHwMTcfLixvdw
	imaEoFV73kb0ukTehoxQ0ij9a1Q8b1aEO7Rjbr/Q3zUaG6PNKoNSmvgpp/4VrV0uToEh34
	YzqHi95DEtCmp9oWOhGOMIqB3ds618E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741876844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jo/jk4JFe8UCdTh0ifv3q1KeaASwi/COhWBjjuCpOAY=;
	b=iYXDxEp8QkAk+JFxi5orXM+p4IfQSSF98Bb8a/lxBHcua3cbSKBqVjJfLnbP06Qu8DyA27
	QE0BPLcw7dcQwtAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A42813797;
	Thu, 13 Mar 2025 14:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xQhaJGvu0md/EAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 13 Mar 2025 14:40:43 +0000
Message-ID: <468c6352-3301-4f0b-a2d4-d6a013417a0e@suse.de>
Date: Thu, 13 Mar 2025 15:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mxsfb: fix missing rollback on failure in
 mxsfb_probe()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250313-mxsfb_probe-fix-rollback-on-error-v1-1-ad2fb79de4cb@bootlin.com>
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
In-Reply-To: <20250313-mxsfb_probe-fix-rollback-on-error-v1-1-ad2fb79de4cb@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 152E821194
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[bootlin.com,denx.de,agner.ch,linux.intel.com,kernel.org,gmail.com,ffwll.ch,pengutronix.de,amarulasolutions.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi

Am 13.03.25 um 15:25 schrieb Luca Ceresoli:
> When aperture_remove_all_conflicting_devices() fails, the current code
> returns without going through the rollback actions at the end of the
> function, thus the actions done by drm_dev_alloc() and mxsfb_load() are not
> undone.
>
> Fix by using a goto statament, as done for the previous and following error
> conditions.
>
> Fixes: c8e7b185d45b ("drm/mxsfb: Remove generic DRM drivers in probe function")
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> The offending commit is not yet merged into master, and even less in a
> released kernel, so this does not need to go through stable.
> ---
>   drivers/gpu/drm/mxsfb/mxsfb_drv.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index c183b1112bc4e9fe4f3b048a2b6e4c98d1d47cb3..b4273e678d26dbc3dee2014266d61470da4e8010 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -365,9 +365,10 @@ static int mxsfb_probe(struct platform_device *pdev)
>   	 * located anywhere in RAM
>   	 */
>   	ret = aperture_remove_all_conflicting_devices(mxsfb_driver.name);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "can't kick out existing framebuffers\n");
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "can't kick out existing framebuffers\n");
> +		goto err_unload;
> +	}

I must have missed that when I reviewed the patch. But this call should 
happen much earlier. right at the top of the probe function before 
drm_dev_alloc(). Conflicting drivers need to be kicked out before 
setting up DRM. Could you please send a patch to move the call to the 
top? No extra cleanup would be required then.

Best regards
Thomas

>   
>   	ret = drm_dev_register(drm, 0);
>   	if (ret)
>
> ---
> base-commit: f9f087d946266bc5da7c3a17bd8fd9d01969e3cf
> change-id: 20250313-mxsfb_probe-fix-rollback-on-error-3074b9080f34
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


