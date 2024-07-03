Return-Path: <linux-kernel+bounces-239062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95259255A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B6A1F23423
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A4B13B29F;
	Wed,  3 Jul 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iVnoTUj5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QLWIqNHv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iVnoTUj5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QLWIqNHv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000B13B280
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996226; cv=none; b=Ttl1UoI4dcVqwaFBhh/SVIqyCEV3ZGURLFFXyFNmAyjd0NsM6ZdqNo4EkTcvgERnG6nuN8ZeE87Z4X9t8mO5bWkK5XN77tvPdDex8BcyL+aF0HEjeq4jggBSJMXI6roTpuJmMwyy3LbLESwERezUCErQTYKI4M2WUQOUM2lJP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996226; c=relaxed/simple;
	bh=WEdpR6bmVi1yZMdLUQ7mI9VlHFxK2cACfl9b7wLh27I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8tYstQkzdgSdpM0ofIRMQJnws7/+v/k0UNznzOP+egx/GFscRGIbyimRhEB4jVDKHz9O1hRr2OPhamOfVdeXqCMMvCz8+0CfTR6Vq66er0UoGhrIjy6ot6gLJ07PggbS0XiJZ4wLEPY8FVb7U8U1VuAzMYUSxDurSFIDflMeWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iVnoTUj5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QLWIqNHv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iVnoTUj5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QLWIqNHv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F7A321B14;
	Wed,  3 Jul 2024 08:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719996223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M5mPImjflznCvU8v6E0k5Lt065ivRLse5XN+jzBNIO4=;
	b=iVnoTUj5f0euGbehg8dw/9Q9yb7hHPAu/SBwWQsYv6ZvjQDFdtsIJnuxvYshWnHDK+xEQT
	0Z0lhiGx9aijMrkv5AdFG1m8arWqRCAIZiGRSx6uF19i3wazuDOjqfmEqKdLy1ZTmNU9v5
	Xjxea8AnSstjT6hgQH+At7+WHf4HmUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719996223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M5mPImjflznCvU8v6E0k5Lt065ivRLse5XN+jzBNIO4=;
	b=QLWIqNHvuDfq8ERGNK2F83+0J0Fw3L9nRVA5kQxE2BpVaiSMszJWHQKtv4SLQYtshpfVbz
	9bWwHqKwJ41iwiBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719996223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M5mPImjflznCvU8v6E0k5Lt065ivRLse5XN+jzBNIO4=;
	b=iVnoTUj5f0euGbehg8dw/9Q9yb7hHPAu/SBwWQsYv6ZvjQDFdtsIJnuxvYshWnHDK+xEQT
	0Z0lhiGx9aijMrkv5AdFG1m8arWqRCAIZiGRSx6uF19i3wazuDOjqfmEqKdLy1ZTmNU9v5
	Xjxea8AnSstjT6hgQH+At7+WHf4HmUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719996223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M5mPImjflznCvU8v6E0k5Lt065ivRLse5XN+jzBNIO4=;
	b=QLWIqNHvuDfq8ERGNK2F83+0J0Fw3L9nRVA5kQxE2BpVaiSMszJWHQKtv4SLQYtshpfVbz
	9bWwHqKwJ41iwiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7F9713889;
	Wed,  3 Jul 2024 08:43:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NsJeNz4PhWYJSAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Jul 2024 08:43:42 +0000
Message-ID: <7efdb950-5da8-4a31-93de-9b9981aaefbf@suse.de>
Date: Wed, 3 Jul 2024 10:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] drm/radeon: remove load callback from kms_driver
To: Wu Hoi Pok <wuhoipok@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240630165949.117634-1-wuhoipok@gmail.com>
 <20240630165949.117634-3-wuhoipok@gmail.com>
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
In-Reply-To: <20240630165949.117634-3-wuhoipok@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 



Am 30.06.24 um 18:59 schrieb Wu Hoi Pok:
> The ".load" callback in "struct drm_driver" is deprecated. In order to remove
> the callback, we have to manually call "radeon_driver_load_kms" instead.
>
> Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/radeon/radeon_drv.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 739bb1da9dcc..88d3de2a79f8 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -310,6 +310,10 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>   
>   	pci_set_drvdata(pdev, ddev);
>   
> +	ret = radeon_driver_load_kms(ddev, flags);
> +	if (ret)
> +		goto err_agp;
> +
>   	ret = drm_dev_register(ddev, ent->driver_data);
>   	if (ret)
>   		goto err_agp;
> @@ -569,7 +573,6 @@ static const struct drm_ioctl_desc radeon_ioctls_kms[] = {
>   static const struct drm_driver kms_driver = {
>   	.driver_features =
>   	    DRIVER_GEM | DRIVER_RENDER | DRIVER_MODESET,
> -	.load = radeon_driver_load_kms,
>   	.open = radeon_driver_open_kms,
>   	.postclose = radeon_driver_postclose_kms,
>   	.unload = radeon_driver_unload_kms,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


