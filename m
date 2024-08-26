Return-Path: <linux-kernel+bounces-301665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3FD95F3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AC7281AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9532118D639;
	Mon, 26 Aug 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tvoADcHV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+XRpAvxX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="invywaEX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qbS7j2Pn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB44188914
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682305; cv=none; b=YcXQnMdCuNcw1KFuWaaIElGWuQoFq/HVwtud9hRohJgsHn8Kpbh3Yh3taFtg3gKjouvcQAn3LJqfuKIfjS+BNgreUb/GMNl4i7GJIHT5c0hJUf4QUFi51CZZTvBzdHrNSeTIAL7VMbRYEAeODs7hvraKd+zdwaF1xM5Ltn6Wdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682305; c=relaxed/simple;
	bh=PpPsTTL03+ADz/+tNv1r4d7XVXRtERBm0prMNlI+oa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VX+MT4LCBHtMADGRvDFyfLQtZtflROFG0YK17LMb8tmm6JQCiiryjfN1y0k44P9xlVMB5ZiJxLEzgdA/0xmKg/lY9XPxo5RVpkLtm3Kb4mITzx83pVIrV6k2NeWjGWfMNgmYpUf2EIg9UgUjbAaee5wHpeE2R3ceMtQ3gHEEa+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tvoADcHV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+XRpAvxX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=invywaEX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qbS7j2Pn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDC6021ABF;
	Mon, 26 Aug 2024 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724682296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mT4SL3Amhn8KJLninO+r45oxbS6uIvkH0X6W6ctal6E=;
	b=tvoADcHVXS/DkR/NjG+faMEPAQaT6+KMRiRiCpLBHh0MYWs4lpBgrxNBemlLTMIPd+PbV2
	PT4KwaXxsmTwoIA/9TGCnsxFyvJ8DVnLncrlvl3necJji5gu+QhllqQGny9T1rAYOW0Ppy
	DzIbveSOnX9OfIM+okbma3VMwbjxayc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724682296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mT4SL3Amhn8KJLninO+r45oxbS6uIvkH0X6W6ctal6E=;
	b=+XRpAvxXi1VoBiA9n7XPJNx/exg6PSME+jHZQ8Bjlf5Vxg9eo/3Pkfpxw8TlKDNAbim8+S
	HpOY7+fTNTXQQoDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724682295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mT4SL3Amhn8KJLninO+r45oxbS6uIvkH0X6W6ctal6E=;
	b=invywaEX4iUq99XFkFJJ4OGspM1yA2gnb+xd2VJHfonneikIQvA6Sexv65wHYdQN6TcAJf
	Y5EPPIhJAvtO20u5duYu33BcQjWAGB2I7Xz7p6UMquv3BKUHGsqBIZ23aMaxHWvFqMOIk9
	M8ZJDpdXk1H3QebOJH/A67ljJYOa82Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724682295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mT4SL3Amhn8KJLninO+r45oxbS6uIvkH0X6W6ctal6E=;
	b=qbS7j2PnFXALIXvsJpiF3WXUACB1QaU+pAAPUSsTv7HPoNoAdS3OeQ92dSwNlB9ldwEQgL
	rkbKfDI2PdhBjTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A840A13724;
	Mon, 26 Aug 2024 14:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wAKsJzeQzGZrVAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 26 Aug 2024 14:24:55 +0000
Message-ID: <000402f0-b0bf-4842-817d-b0c5873cb5f7@suse.de>
Date: Mon, 26 Aug 2024 16:24:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/atomic: fix kerneldoc for fake_commit field
To: renjun wang <renjunw0@foxmail.com>, maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <tencent_6EF2603DCCFAD6A8265F8AAD9D6D5BCB9309@qq.com>
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
In-Reply-To: <tencent_6EF2603DCCFAD6A8265F8AAD9D6D5BCB9309@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com,linux.intel.com];
	FREEMAIL_ENVRCPT(0.00)[foxmail.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO



Am 24.08.24 um 10:20 schrieb renjun wang:
> According to the context, the function description for fake_commit
> should be "prevent the atomic states from being freed too early"
>
> Signed-off-by: renjun wang <renjunw0@foxmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   include/drm/drm_atomic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 4d7f4c5f2001..31ca88deb10d 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -460,7 +460,7 @@ struct drm_atomic_state {
>   	 *
>   	 * Used for signaling unbound planes/connectors.
>   	 * When a connector or plane is not bound to any CRTC, it's still important
> -	 * to preserve linearity to prevent the atomic states from being freed to early.
> +	 * to preserve linearity to prevent the atomic states from being freed too early.
>   	 *
>   	 * This commit (if set) is not bound to any CRTC, but will be completed when
>   	 * drm_atomic_helper_commit_hw_done() is called.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


