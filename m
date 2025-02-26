Return-Path: <linux-kernel+bounces-533997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD6A4614B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8193116D2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5542621B1A8;
	Wed, 26 Feb 2025 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YPnxwRnJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ox88Btnt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YPnxwRnJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ox88Btnt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40284A2B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577914; cv=none; b=budLdvtXxHpVez9GfC9nL1faquLTjMkJffq5a00hdbovlXOmMlDFpQlY29oUZbGRLzc1rLVIjX3UXcUx52fjeq5SfysBQeWbFUgOyTC+iJNnU+ZLavJ8jPd81a7tq3918Fgl34p1KaSn0HpNgHHVDTlvcDKxE3AMCv2DM0WJ0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577914; c=relaxed/simple;
	bh=n6+vqD8OBgmg6NJxmCBafvaY5/baYtUyA6dIJbLCsro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rjv/sQ6BhVF2n93cBDfIytjXc6JZs+Pmtez+GbAcviLIq7hV/wPfOob1ozYnLAdeHxLQyHZNQMAR2RbvwKs6B3E56O5OW+cTnstZ+NGFZSbRTgxCG6+/KUgGE44LHPA+xFOcDt7tsCpBoaI+e9AyGOa91+T87kzdjzU74kF2zRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YPnxwRnJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ox88Btnt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YPnxwRnJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ox88Btnt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD5F4211A8;
	Wed, 26 Feb 2025 13:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740577910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a60y0C5U4R0lxbJdKCRKT2MexrT2LdRj0i6qqnMEpck=;
	b=YPnxwRnJUIv0piMcvgn2c873cQHlZEbG8jwF/ATsanId5egNNvCpPyJHLsGbLRqOEBIUmB
	sLNiqwrTuUI6BwD4iDkV2HmwqNzWgO4XB0NH4nkijwCK4yWJxyPXKu6OBtvc70F4t92kQv
	AF8Jgwn2fNMZexEaJT5j/SmDrI3OyAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740577910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a60y0C5U4R0lxbJdKCRKT2MexrT2LdRj0i6qqnMEpck=;
	b=Ox88Btnt4TgzxuTtpT+Def2hlyyPvV0eWW/bvobt+k35KKXlTlGLGFe5zTNSqcvPC++OAW
	nwWsqPw3oJcLCEDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740577910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a60y0C5U4R0lxbJdKCRKT2MexrT2LdRj0i6qqnMEpck=;
	b=YPnxwRnJUIv0piMcvgn2c873cQHlZEbG8jwF/ATsanId5egNNvCpPyJHLsGbLRqOEBIUmB
	sLNiqwrTuUI6BwD4iDkV2HmwqNzWgO4XB0NH4nkijwCK4yWJxyPXKu6OBtvc70F4t92kQv
	AF8Jgwn2fNMZexEaJT5j/SmDrI3OyAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740577910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a60y0C5U4R0lxbJdKCRKT2MexrT2LdRj0i6qqnMEpck=;
	b=Ox88Btnt4TgzxuTtpT+Def2hlyyPvV0eWW/bvobt+k35KKXlTlGLGFe5zTNSqcvPC++OAW
	nwWsqPw3oJcLCEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80E3E13A53;
	Wed, 26 Feb 2025 13:51:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ll0jHnYcv2cLNwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Feb 2025 13:51:50 +0000
Message-ID: <81c34fda-0081-41ce-b87c-31ff831137c5@suse.de>
Date: Wed, 26 Feb 2025 14:51:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update maintainer of repaper and mi0283qt
To: Alex Lanzano <lanzano.alex@gmail.com>, airlied@gmail.com,
 simona@ffwll.ch, noralf@tronnes.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250210233232.3995143-1-lanzano.alex@gmail.com>
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
In-Reply-To: <20250210233232.3995143-1-lanzano.alex@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,ffwll.ch,tronnes.org];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 11.02.25 um 00:32 schrieb Alex Lanzano:
> Add myself as the maintainer of the recently orphaned repaper and
> mi0283qt drivers.

Merged into drm-misc-next. Thanks for helping.

Best regards
Thomas

>
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1c5b22f00434..b5e46f23d1ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7352,7 +7352,8 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/mgag200/
>   
>   DRM DRIVER FOR MI0283QT
> -S:	Orphan
> +M:	Alex Lanzano <lanzano.alex@gmail.com>
> +S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
>   F:	drivers/gpu/drm/tiny/mi0283qt.c
> @@ -7455,7 +7456,8 @@ F:	Documentation/devicetree/bindings/display/bridge/ps8640.yaml
>   F:	drivers/gpu/drm/bridge/parade-ps8640.c
>   
>   DRM DRIVER FOR PERVASIVE DISPLAYS REPAPER PANELS
> -S:	Orphan
> +M:	Alex Lanzano <lanzano.alex@gmail.com>
> +S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	Documentation/devicetree/bindings/display/repaper.txt
>   F:	drivers/gpu/drm/tiny/repaper.c

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


