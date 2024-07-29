Return-Path: <linux-kernel+bounces-265188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC493EDBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A011C2153B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DAE71B52;
	Mon, 29 Jul 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iWyWOV5M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HB4Hhfxb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i5G0ZKB5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XV/xtixq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AE56458
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236420; cv=none; b=BLh2jb8Vx93yjrZAdLGHoR/78FVXmc2vdeAeTCWMh7Ax+uPK97Cmu6u6T0E/f9I40/A0jz5hOmu7CUlr1aFkOrTAYPGnMk207TuFFafHkRFBjxElwQ2OOFX3QspaiRm461DU47fUX1LRrtYOQ6rsU3HmTpu74/i55h9bh3TSs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236420; c=relaxed/simple;
	bh=8Re6q4rE5IFjZDeH/FPvMXiDsZAZKmU6gVBt/kOOW/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tssXHQL45VLdsjfQzchIsHHbH0TlDfpQ5WUV7qmrHY8lkLPUbhp0uTTMcT3eokFIRU3pv5ZZ/fXWYdVdG442PsQK6hBxLkTXeANTOwVHo1m9EMHv4hwCrEw/1XKyiIbb8gJ5OCzVwyrFGLpca5MaNvH/3sq9rg0rsYkerQSlKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iWyWOV5M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HB4Hhfxb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i5G0ZKB5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XV/xtixq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D946E1F78C;
	Mon, 29 Jul 2024 07:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722236417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J8ueglnNBdA4Q5mQronQ4Gm/pv63pORjDmoG9GkWGDQ=;
	b=iWyWOV5MGba3JczePiFZnYJYaiw33CE3NjpPxZ+qBPZEXlUfiMtcII6iOoNJij9tG6l7zh
	d4Vz3ZaAtmbb5HSzmh7qZIbS6lZ9HPj4TWBQaND2ScChhgXXdRyz26Cr1xQV5i4Ik0EV3h
	BCHf4It3GbmRy5ISNu3d9dg189lt48s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722236417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J8ueglnNBdA4Q5mQronQ4Gm/pv63pORjDmoG9GkWGDQ=;
	b=HB4HhfxbseClkwplQbbggUZXze8Z8nMz8zyr5O8h+JnfUY1cCXqW3A5KSb7Uex2BwjO8/u
	ZPfHVXsy7dicveBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722236416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J8ueglnNBdA4Q5mQronQ4Gm/pv63pORjDmoG9GkWGDQ=;
	b=i5G0ZKB5SMoyaGm3+gTRgf8ckA9VGPKpmBa2NLlygQFWde2WdI+hi2Rp6CexvX/LPHXN64
	/5OsG2rx5dtl4W15XO3ZgsofDjVK8kBLZMq0fjfYWFFkAJygpl2hBtShW15PRexH3aE5nT
	+SwBCGYruy2Ep62JDNfqsbtqyDzCIiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722236416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J8ueglnNBdA4Q5mQronQ4Gm/pv63pORjDmoG9GkWGDQ=;
	b=XV/xtixqeRIemwRcvr9zBEYi11hzo3sYKHF0TBSQ/IkgxtZOHMPiEmsSlIRaoiDnDzHpS5
	xJR3FQMnPjlXxwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9CD71368A;
	Mon, 29 Jul 2024 07:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XY0oKAA+p2YLXQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 29 Jul 2024 07:00:16 +0000
Message-ID: <9fe56280-608d-4859-85ba-340173649f00@suse.de>
Date: Mon, 29 Jul 2024 09:00:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: firmware/sysfb.c device path
To: "Olsak, Marek" <Marek.Olsak@amd.com>, Tj <tj.iam.tj@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "1075713@bugs.debian.org" <1075713@bugs.debian.org>
References: <lLyvPFC_APGHNfyGNHRpQy5izBikkaTPOpHooZIT3fFAoJPquSI31ZMueA99XTdr8ysir3X7O7IMdc6za-0m79vr_claeparHhoRouVgHOI=@proton.me>
 <1eb659d8-536e-401b-a427-19709a98953a@suse.de>
 <-sJINpD9sbYc288gXp2-Tf5w6diSusXAP8mM8l0mnLWfIXgjuNe1LBgkqQ2indMJOehVrPUPO3UMQ-AvObgCWUW9h_TepvcNy9gnqfvoyvM=@proton.me>
 <a01f6a7e-c56e-4a78-8605-ab5b253d9c9e@suse.de>
 <qRNIostAxg5303tUSChdxUG3k53ylqvB-EoPEFUnz6avhPGHXWKOznFRckJhDJCDjr65ptNRF87AIUqNzMH6eIp2QfL46HTtkMSxHjfo_l8=@proton.me>
 <DM6PR12MB473145875C16DFDC5B0DE65FF9A92@DM6PR12MB4731.namprd12.prod.outlook.com>
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
In-Reply-To: <DM6PR12MB473145875C16DFDC5B0DE65FF9A92@DM6PR12MB4731.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.09 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,amd.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.09

Hi

Am 23.07.24 um 19:38 schrieb Olsak, Marek:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Hi,
>
> If you have a patch, I'd like to test it.

Here's the proposed change:

https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/1612/diffs?commit_id=a745f59bb193c7a87959fddade9b637278e5528e


BTW, did you see

https://lore.kernel.org/dri-devel/1ff5b407-ff81-40ef-8aa3-9f155491f497@leemhuis.info/

? This looks similar to your bug report.

Best regards
Thomas

>
> Thanks,
> Marek
> ------------------------------------------------------------------------
> *From:* Tj <tj.iam.tj@proton.me>
> *Sent:* July 15, 2024 05:29
> *To:* Thomas Zimmermann <tzimmermann@suse.de>
> *Cc:* Olsak, Marek <Marek.Olsak@amd.com>; linux-kernel@vger.kernel.org 
> <linux-kernel@vger.kernel.org>; 1075713@bugs.debian.org 
> <1075713@bugs.debian.org>
> *Subject:* Re: Regression: firmware/sysfb.c device path
> On Monday, 15 July 2024 at 10:22, Thomas Zimmermann 
> <tzimmermann@suse.de> wrote:
>
>
> > We should definitely get your patch into the Xorg upstream.
>
> Working on that now.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


