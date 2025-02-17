Return-Path: <linux-kernel+bounces-517175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B15F2A37D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6F7188D9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F41A2632;
	Mon, 17 Feb 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eD4g1/ce";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PiEj4XEP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eD4g1/ce";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PiEj4XEP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378001519A3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781819; cv=none; b=pkQjtxirxc9kVqW7dnwN4hYrTRFMp5+3dMt65bnqXFtulSvT9DBuGnsW7NpItFE5MrNAMHLyn7c3tS0S0VPl6ZYzeEv5+ryDAFSLlSOjokFGHJo6sa435cMemzNg9hGTVtlVdR3JZ7bSBlitJLeLz33Odl3NmcpaEcyyj1y1Ies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781819; c=relaxed/simple;
	bh=fm33fU18m71EHalA8xc5SJw20UsSKY2T07z8KtiSxME=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Yxw9z+E/iIvtW6rxhYQqhNmTqzKDl/qpmvc8iHRl9RBkLKDFGON0USjGYrO3z6NtumIKacQSvbEZQ3sHiIBKP098/zJPG+UB9X5R/yj1zAXSQGooNM8U3Qp2GJZmas3EtC1cRK51pfptqyvWgbkXPd7/SzQ0Yat3pTM3gjXqp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eD4g1/ce; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PiEj4XEP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eD4g1/ce; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PiEj4XEP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48B731F443;
	Mon, 17 Feb 2025 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739781815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IZxCSM7XkSzfRFgumZsyCUCqvazndhJgSYtdp1OuQmQ=;
	b=eD4g1/ceIec0w9H5kTNhRxny6FK/7Nei1HCeQx9F1yCkxbhGyEcTa32i8E0M7h2WisPypG
	mPM3BJ0FD9zOGcAVrd8wQjwW4UIEo7JxayQn2IHS4QIeU7qrpswSEMcGXT8C08rKwIo4vg
	+vHne6NCbKF4Zg442oaIIm/Uct67BgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739781815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IZxCSM7XkSzfRFgumZsyCUCqvazndhJgSYtdp1OuQmQ=;
	b=PiEj4XEPcxGJk0pIekxvaLxfJdYAJ8ztEIWLJPg9lR//j4UcwTNwnx2SY5Mc3vu8mNeboK
	3vWiQChI5JdoRdBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="eD4g1/ce";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PiEj4XEP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739781815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IZxCSM7XkSzfRFgumZsyCUCqvazndhJgSYtdp1OuQmQ=;
	b=eD4g1/ceIec0w9H5kTNhRxny6FK/7Nei1HCeQx9F1yCkxbhGyEcTa32i8E0M7h2WisPypG
	mPM3BJ0FD9zOGcAVrd8wQjwW4UIEo7JxayQn2IHS4QIeU7qrpswSEMcGXT8C08rKwIo4vg
	+vHne6NCbKF4Zg442oaIIm/Uct67BgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739781815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IZxCSM7XkSzfRFgumZsyCUCqvazndhJgSYtdp1OuQmQ=;
	b=PiEj4XEPcxGJk0pIekxvaLxfJdYAJ8ztEIWLJPg9lR//j4UcwTNwnx2SY5Mc3vu8mNeboK
	3vWiQChI5JdoRdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A23D1379D;
	Mon, 17 Feb 2025 08:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oSMEAbf2smdjLQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Feb 2025 08:43:35 +0000
Message-ID: <ea563bf1-b341-4942-899a-85af76fa8fc8@suse.de>
Date: Mon, 17 Feb 2025 09:43:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Handheld gaming PC panel orientation quirks
From: Thomas Zimmermann <tzimmermann@suse.de>
To: John Edwards <uejji@uejji.net>, Hans de Goede <hdegoede@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Andrew Wyatt <fewtarius@steamfork.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250213222455.93533-1-uejji@uejji.net>
 <59811676-52d1-4432-b6ae-2f519dc95f83@suse.de>
Content-Language: en-US
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
In-Reply-To: <59811676-52d1-4432-b6ae-2f519dc95f83@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 48B731F443
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[uejji.net,redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi

Am 14.02.25 um 08:55 schrieb Thomas Zimmermann:
> Hi
>
> Am 13.02.25 um 23:24 schrieb John Edwards:
>> Hello.
>>
>> I am submitting a small number of patches to add panel rotation 
>> quirks for
>> a few handheld gaming PCs.  These patches were created by the SteamFork
>> team and are in daily use by us and/or members of our community.
>>
>> The following devices are covered by these patches:
>> 1: AYANEO 2S
>> 2: AYANEO Flip DS, AYANEO Flip KB
>> 3: AYANEO Slide, Antec Core HS
>> 4: GPD Win 2 (with correct DMI strings)
>> 5: OneXPlayer Mini (Intel)
>>
>> Thank you for your consideration and for taking the time to review these
>> patches.
>>
>> John Edwards
>>
>> v3:
>> - Correct indentation errors in Flip DS/KB and Slide patches
>> - Include Reviewed-by tags for Thomas Zimmermann and Hans de Goede
>
> Thanks a lot for the patches. If no further comments come in, I'll 
> merge the series next week.

I've merged the series into drm-misc-next. It should be available in v6.15

Best regards
Thomas

>
> Best regards
> Thomas
>
>>
>> v2:
>> - Minor rewording of commit messages
>> - Include Tested-by tag for Paco Avelar in AYANEO Flip DS/KB patch
>> - Add OneXPlayer Mini (Intel) patch
>> https://lore.kernel.org/dri-devel/20250124204648.56989-2-uejji@uejji.net/ 
>>
>>
>> v1:
>> https://lore.kernel.org/dri-devel/20250116155049.39647-2-uejji@uejji.net/ 
>>
>>
>> Andrew Wyatt (5):
>>    drm: panel-orientation-quirks: Add support for AYANEO 2S
>>    drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
>>    drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
>>    drm: panel-orientation-quirks: Add new quirk for GPD Win 2
>>    drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)
>>
>>   .../gpu/drm/drm_panel_orientation_quirks.c    | 40 ++++++++++++++++++-
>>   1 file changed, 38 insertions(+), 2 deletions(-)
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


