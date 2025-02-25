Return-Path: <linux-kernel+bounces-530653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3492A4363C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F03AC887
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214201DF97E;
	Tue, 25 Feb 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dgIRHSuu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YS+zGVaF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dgIRHSuu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YS+zGVaF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA01F60A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469062; cv=none; b=okseadggbK1a8o1stU++jgh9s2bSF0j1KRQyPMd4cn4GzBU9Z15icapXXTS3HCB3AkWrYxwjDuGo6niN3/LDQ1QvlOB1F1IPYVsIkFHHYXYjezLWH2mqGrZ1Ni2aIkyRhkOnvFhJS7EinGEHBjBDh3o2L7IXcS4BUWu65xzwsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469062; c=relaxed/simple;
	bh=4TJxAcbMgjIuf77+szboTESgqOPtZ39HKIBt02Li7Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/oMNDx99r10sktI3gIVbPZFgp5LnLDyRtVlYfKn/+Dq9+2us3krtlJBbqfbBa6qGcF4FZRKGXk8umh0pUB+tb+z/5TA3lkk0HvQCUwbqFW7rRJVyudcTz0Kw/bhIS3gVcb7IThqonpATiXC/pwsLn1RYmVMV82xtJsc07+DYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dgIRHSuu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YS+zGVaF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dgIRHSuu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YS+zGVaF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B206C21189;
	Tue, 25 Feb 2025 07:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y5WDztHzk/ESA1ZcgwdQycKbRCQMy9XUvHwa8HMzFSE=;
	b=dgIRHSuuaT7Z6EHqtDd4xCwHgMTHcP+GT+98DsoyaBzeoqq6eao2amGhx0+NkLjQj6urJU
	DlF0woXf+eU46iEUxciZWw316EayrTngox1oBdjekgZZR/iLT9JGvBlFOIHpvdY4y6eCAw
	7PcER7k6PvmEtZmK9tq+Hh5oci1T778=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y5WDztHzk/ESA1ZcgwdQycKbRCQMy9XUvHwa8HMzFSE=;
	b=YS+zGVaF7J3n30ywrN9k3abQLo/GH20KMwnecYGsorDqxdPEHCs4ZNdclZ/wZjPDyZ37XN
	vB0jl1mJqxBa4qDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740469052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y5WDztHzk/ESA1ZcgwdQycKbRCQMy9XUvHwa8HMzFSE=;
	b=dgIRHSuuaT7Z6EHqtDd4xCwHgMTHcP+GT+98DsoyaBzeoqq6eao2amGhx0+NkLjQj6urJU
	DlF0woXf+eU46iEUxciZWw316EayrTngox1oBdjekgZZR/iLT9JGvBlFOIHpvdY4y6eCAw
	7PcER7k6PvmEtZmK9tq+Hh5oci1T778=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740469052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y5WDztHzk/ESA1ZcgwdQycKbRCQMy9XUvHwa8HMzFSE=;
	b=YS+zGVaF7J3n30ywrN9k3abQLo/GH20KMwnecYGsorDqxdPEHCs4ZNdclZ/wZjPDyZ37XN
	vB0jl1mJqxBa4qDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67F6313332;
	Tue, 25 Feb 2025 07:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hUYMGDxzvWdcbgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Feb 2025 07:37:32 +0000
Message-ID: <466c38c3-7f74-46db-8270-bebafacf0007@suse.de>
Date: Tue, 25 Feb 2025 08:37:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/format-helper: Add conversion from XRGB8888 to
 BGR888
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 Aditya Garg <gargaditya08@live.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, Kerem Karabay <kekrby@gmail.com>,
 Atharva Tiwari <evepolonium@gmail.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <B08444CD-38A8-4B82-94B2-4162D6D2EABD@live.com>
 <03FA573F-6D01-40E8-A666-CEA17A917036@live.com>
 <Z7yCLxBN4Cl4btQm@smile.fi.intel.com>
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
In-Reply-To: <Z7yCLxBN4Cl4btQm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.intel.com,live.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,kodeit.net,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 24.02.25 um 15:29 schrieb andriy.shevchenko@linux.intel.com:
> On Mon, Feb 24, 2025 at 01:38:32PM +0000, Aditya Garg wrote:
>> From: Kerem Karabay <kekrby@gmail.com>
>>
>> Add XRGB8888 emulation helper for devices that only support BGR888.
> ...
>
>> +static void drm_fb_xrgb8888_to_bgr888_line(void *dbuf, const void *sbuf, unsigned int pixels)
> Okay the xrgb8888 is the actual pixel format independently on
> the CPU endianess.
>
>> +{
>> +	u8 *dbuf8 = dbuf;
>> +	const __le32 *sbuf32 = sbuf;
> But here we assume that sbuf is __le32.
> And I think we may benefit from the __be32 there.

No, please. XRGB is the logical order. The raw physical byte order for 
DRM formats is always* little endian, hence reversed from the logical 
one. sbuf points to raw memory and is therefore __le32. DRM-format byte 
order is impossible to understand, I know. But that code is correct.

Best regards
Thomas

*) White lie: there's a DRM format flag signalling physical big 
endianess. That isn't the case here. So nothing here should ever 
indicate big endianess.


>
>> +	unsigned int x;
>> +	u32 pix;
>> +
>> +	for (x = 0; x < pixels; x++) {
>> +		pix = le32_to_cpu(sbuf32[x]);
>> +		/* write red-green-blue to output in little endianness */
>> +		*dbuf8++ = (pix & 0x00ff0000) >> 16;
>> +		*dbuf8++ = (pix & 0x0000ff00) >> 8;
>> +		*dbuf8++ = (pix & 0x000000ff) >> 0;
> 		pix = be32_to_cpu(sbuf[4 * x]) >> 8;
> 		put_unaligned_le24(pix, &dbuf[3 * x]);
>
>> +	}
> Or, after all, this __le32 magic might be not needed at all. Wouldn't the below
> be the equivalent
>
> static void drm_fb_xrgb8888_to_bgr888_line(void *dbuf, const void *sbuf, unsigned int pixels)
> {
> 	unsigned int x;
> 	u32 pix;
>
> 	for (x = 0; x < pixels; x++) {
> 		/* Read red-green-blue from input in big endianess and... */
> 		pix = get_unaligned_be24(sbuf + x * 4 + 1);
> 		/* ...write it to output in little endianness. */
> 		put_unaligned_le24(pix, dbuf + x * 3);
> 	}
> }
>
> The comments can even be dropped as the code quite clear about what's going on.
>
>> +}
> But it's up to you. I don't know which solution gives better code generation
> either.
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


