Return-Path: <linux-kernel+bounces-514540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB18A35843
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3101891C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C438E21CA08;
	Fri, 14 Feb 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IFFwaYxe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7S2rrWQE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IFFwaYxe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7S2rrWQE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3820C038
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519731; cv=none; b=WsIk7YIUuHIoqT3Hlu9nx3X1IDjuJmAoivLehwy5XaO1lyzDSc0rRzAHn8JMolIj3iUfvR81MEe3exi/Gc+1z8Vxh1P1Sw0rUE/m2GZK5EYYy5uRyLp2QJxxuxt7iq+0EZ3Ka7/KCGWss+XorXoGSn16YpUJUm7ZlkzQXhqDzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519731; c=relaxed/simple;
	bh=1Aj40sKhHmDT09tAaZjQlS5MYMd1a+gmHa7neOfrG4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxE+gMzSwONmG5/GCU0CWnkD0q/rI4y2t8UuRZi4eVo7Pwi1bWdqJsHtSLH+CTZILqQ9haViRMeo4an7UzWoE3iApCMtmITWPaD+Z/1J/nZgux0CVcEkXNN6UI7HNh9sGNu5VYY7PUmLyGD4XnzmGlBKNOa/ldCU9cUcmRyDZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IFFwaYxe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7S2rrWQE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IFFwaYxe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7S2rrWQE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE97821D9C;
	Fri, 14 Feb 2025 07:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739519727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fyDttw15PU0HUrcTKbIAMTy/BqbOtIX3AmP1wbwDKnw=;
	b=IFFwaYxeSue9uPD2yvJvmO0M7vdRFJSliRTXgGYhd81AZUYsvEYioIoOSLMC1e9xo8sbcc
	TdyS3yP+I042weOA1lBcxr+VpQNyQTMrBFNwitT4zs4mztu7Yt9h8E2LDLcLHcvoZ+Midp
	k6yJC84YEOsvc8IQf+7KQNZIEbxQ1OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739519727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fyDttw15PU0HUrcTKbIAMTy/BqbOtIX3AmP1wbwDKnw=;
	b=7S2rrWQE8apvHTij4BuTtcMF2GzNLesUMksFs47Ke+gabqJLtUdhCgML3ihreYNljOui6C
	mphvag5Zz99qISCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739519727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fyDttw15PU0HUrcTKbIAMTy/BqbOtIX3AmP1wbwDKnw=;
	b=IFFwaYxeSue9uPD2yvJvmO0M7vdRFJSliRTXgGYhd81AZUYsvEYioIoOSLMC1e9xo8sbcc
	TdyS3yP+I042weOA1lBcxr+VpQNyQTMrBFNwitT4zs4mztu7Yt9h8E2LDLcLHcvoZ+Midp
	k6yJC84YEOsvc8IQf+7KQNZIEbxQ1OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739519727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fyDttw15PU0HUrcTKbIAMTy/BqbOtIX3AmP1wbwDKnw=;
	b=7S2rrWQE8apvHTij4BuTtcMF2GzNLesUMksFs47Ke+gabqJLtUdhCgML3ihreYNljOui6C
	mphvag5Zz99qISCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70B3F13285;
	Fri, 14 Feb 2025 07:55:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L5hCGu/2rme+GgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 14 Feb 2025 07:55:27 +0000
Message-ID: <59811676-52d1-4432-b6ae-2f519dc95f83@suse.de>
Date: Fri, 14 Feb 2025 08:55:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Handheld gaming PC panel orientation quirks
To: John Edwards <uejji@uejji.net>, Hans de Goede <hdegoede@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Andrew Wyatt <fewtarius@steamfork.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250213222455.93533-1-uejji@uejji.net>
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
In-Reply-To: <20250213222455.93533-1-uejji@uejji.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[uejji.net,redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi

Am 13.02.25 um 23:24 schrieb John Edwards:
> Hello.
>
> I am submitting a small number of patches to add panel rotation quirks for
> a few handheld gaming PCs.  These patches were created by the SteamFork
> team and are in daily use by us and/or members of our community.
>
> The following devices are covered by these patches:
> 1: AYANEO 2S
> 2: AYANEO Flip DS, AYANEO Flip KB
> 3: AYANEO Slide, Antec Core HS
> 4: GPD Win 2 (with correct DMI strings)
> 5: OneXPlayer Mini (Intel)
>
> Thank you for your consideration and for taking the time to review these
> patches.
>
> John Edwards
>
> v3:
> - Correct indentation errors in Flip DS/KB and Slide patches
> - Include Reviewed-by tags for Thomas Zimmermann and Hans de Goede

Thanks a lot for the patches. If no further comments come in, I'll merge 
the series next week.

Best regards
Thomas

>
> v2:
> - Minor rewording of commit messages
> - Include Tested-by tag for Paco Avelar in AYANEO Flip DS/KB patch
> - Add OneXPlayer Mini (Intel) patch
> https://lore.kernel.org/dri-devel/20250124204648.56989-2-uejji@uejji.net/
>
> v1:
> https://lore.kernel.org/dri-devel/20250116155049.39647-2-uejji@uejji.net/
>
> Andrew Wyatt (5):
>    drm: panel-orientation-quirks: Add support for AYANEO 2S
>    drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
>    drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
>    drm: panel-orientation-quirks: Add new quirk for GPD Win 2
>    drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)
>
>   .../gpu/drm/drm_panel_orientation_quirks.c    | 40 ++++++++++++++++++-
>   1 file changed, 38 insertions(+), 2 deletions(-)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


