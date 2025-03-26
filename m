Return-Path: <linux-kernel+bounces-576733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5344AA713BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636A93B0112
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383F2187872;
	Wed, 26 Mar 2025 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RBlGHB9o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vrrpfHVb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RBlGHB9o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vrrpfHVb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F62F42
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981549; cv=none; b=Rb+2CyieRvO6emKUeETEoJz11qIYQa0SgHhZ4c+vVjX2cac+eZIm7fSWgk/AVETJ20wMyypMLsNr5Dro24+08p0Qv93XJhEHBWjBgiPQjCyr8kjtewZeFTnXaXTnx3nT7WW2Kym7mTEwkOfUy9a3ThrspMhvzkBzZOelCeOMC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981549; c=relaxed/simple;
	bh=WOgRLODx2mJ+ddf4QzJd2mzZ58I0OakByTGbqfp58P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsUL7WKhjE375PqPtIHoBF+CPH0iogBe8Yu0nxlZ4TtUPd69JGKykX+T5XNxS4KuzZU8uoZXI99rEZD2CE76VqziYnfFWnyi0JwElKABWF+lOfCW6HqTQ186vWHW19pWZS8673ceVHZ7gsiygboe0y14HPa1ca9HSE7uPdFSB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RBlGHB9o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vrrpfHVb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RBlGHB9o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vrrpfHVb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1513D1F449;
	Wed, 26 Mar 2025 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742981546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DswBERMkpxR267niKK/AGKT9RXW/1Vb0AVG9m8FuzFs=;
	b=RBlGHB9oL3a+QP9/UY46yElWDc49kg0eMw4o9trDJt07a/qCI6qauGTc8a6+8e2j6zvK0P
	KdirChV3m8zy4FeHNI7OJKoG4BTikT8CoUjaH6M+vrXNAkCpjVP23WFz4e2cjftDuixN8t
	OuklcvTCMDu8d9mreaDo4wsTHX3e+Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742981546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DswBERMkpxR267niKK/AGKT9RXW/1Vb0AVG9m8FuzFs=;
	b=vrrpfHVbQMXZ7s5mib7CPoTs04bmhASyonzsDI9tsqkIyfZPcyYoyk6XSSC+c7aKy+KaGl
	DWn7YKjHwJ0usQBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742981546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DswBERMkpxR267niKK/AGKT9RXW/1Vb0AVG9m8FuzFs=;
	b=RBlGHB9oL3a+QP9/UY46yElWDc49kg0eMw4o9trDJt07a/qCI6qauGTc8a6+8e2j6zvK0P
	KdirChV3m8zy4FeHNI7OJKoG4BTikT8CoUjaH6M+vrXNAkCpjVP23WFz4e2cjftDuixN8t
	OuklcvTCMDu8d9mreaDo4wsTHX3e+Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742981546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DswBERMkpxR267niKK/AGKT9RXW/1Vb0AVG9m8FuzFs=;
	b=vrrpfHVbQMXZ7s5mib7CPoTs04bmhASyonzsDI9tsqkIyfZPcyYoyk6XSSC+c7aKy+KaGl
	DWn7YKjHwJ0usQBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D38BF1374A;
	Wed, 26 Mar 2025 09:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P/2gMqnJ42e+ZQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Mar 2025 09:32:25 +0000
Message-ID: <888333e6-e81c-4186-b543-78fda7e3eb68@suse.de>
Date: Wed, 26 Mar 2025 10:32:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/mode_config: Make
 drm_mode_config.(max|min)_(width|height) signed
To: Lyude Paul <lyude@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250325212823.669459-1-lyude@redhat.com>
 <20250325212823.669459-3-lyude@redhat.com>
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
In-Reply-To: <20250325212823.669459-3-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,gmail.com,ffwll.ch];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi

Am 25.03.25 um 22:27 schrieb Lyude Paul:
> Similarly, it doesn't really make much sense for us to allow devices to
> specify their minimum/maximum resolution as signed. So, let's fix that as
> well while we're at it.

This commit message only makes sense in the context of the series. 
Better remove 'Similarily' and 'as well while we're at it'.

>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> ---
>   include/drm/drm_mode_config.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 271765e2e9f2d..4b8f0370b79bf 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -532,8 +532,8 @@ struct drm_mode_config {
>   	 */
>   	struct list_head privobj_list;
>   
> -	int min_width, min_height;
> -	int max_width, max_height;
> +	unsigned int min_width, min_height;
> +	unsigned int max_width, max_height;

No problem, I just hope this has no fallout where these fields are being 
used.

Best regards
Thomas

>   	const struct drm_mode_config_funcs *funcs;
>   
>   	/* output poll support */

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


