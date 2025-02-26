Return-Path: <linux-kernel+bounces-533253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E8A45782
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94BA18857A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3726E162;
	Wed, 26 Feb 2025 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zHChsxQ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0HHONTqc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zHChsxQ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0HHONTqc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F7258CF6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556419; cv=none; b=UAOs2HL87urjvAF8AC4RbPWTQzA4+bSyBwdAm7zlHwxUXkqX3MwW5irPnQg/TUDnaRDtSIC+TT5zShuhU3iLRc672vPvL5y2J25EA1b7eSw2XD+2/FpwekePtIg4BIx+repEFC9WcPjQqUKkXeUFESsza8q6piSNb6hCwW6MMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556419; c=relaxed/simple;
	bh=j5cAfjBC4qoe1Dptf8YekTrGK5qMFB6pNMAq3Cz4O+M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iPHKaIgD/dJDZlNUlom5LsQA1DuwOJxvrpCyAqgDKrfyerx0ZSmJczc5WbEqUqRAoAHzwhFwyIHpdzsQGHlby84YpcvcWoliK6e2oNWkJuq9tVfdTs1VMsQTGt382QfR9+zVX0MiMBKeaelJCMr37UMpPjESrcDaHyIugwM2+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zHChsxQ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0HHONTqc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zHChsxQ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0HHONTqc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 433741F387;
	Wed, 26 Feb 2025 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740556416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ba1ahW1C2nj3WOUS9yZkifA6l7VQeYlK+p+Uj5DrlXc=;
	b=zHChsxQ3apQJ3SWTkhyQofk0GcVLK1n0UYmRO97zyyMYbOLpF665kKmN5Np1MlxMD3TyIx
	MaXsI1H4+s7hhmRyQwDKL0qFucFNi+Pn2QRtOD3xtrD2ltSXKzEB3qZY+3iKwh1Si0kW4X
	qJ8Ck3QoNLhHR0ijgdBM5A+D1kCGEUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740556416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ba1ahW1C2nj3WOUS9yZkifA6l7VQeYlK+p+Uj5DrlXc=;
	b=0HHONTqc81figXnfNkjlmaklEAoDBZA8b2WVwaletNVJjXoLh7vKbEDoLrddkzel+p5uNo
	NI5nEhGNMr4qMfBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740556416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ba1ahW1C2nj3WOUS9yZkifA6l7VQeYlK+p+Uj5DrlXc=;
	b=zHChsxQ3apQJ3SWTkhyQofk0GcVLK1n0UYmRO97zyyMYbOLpF665kKmN5Np1MlxMD3TyIx
	MaXsI1H4+s7hhmRyQwDKL0qFucFNi+Pn2QRtOD3xtrD2ltSXKzEB3qZY+3iKwh1Si0kW4X
	qJ8Ck3QoNLhHR0ijgdBM5A+D1kCGEUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740556416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ba1ahW1C2nj3WOUS9yZkifA6l7VQeYlK+p+Uj5DrlXc=;
	b=0HHONTqc81figXnfNkjlmaklEAoDBZA8b2WVwaletNVJjXoLh7vKbEDoLrddkzel+p5uNo
	NI5nEhGNMr4qMfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1064F13A53;
	Wed, 26 Feb 2025 07:53:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E0yxAoDIvmfxOgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Feb 2025 07:53:36 +0000
Message-ID: <1c4aefef-df2a-497c-87d1-8f69af996515@suse.de>
Date: Wed, 26 Feb 2025 08:53:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dummycon: only build module if there are users
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250225164436.56654-1-arnd@kernel.org>
 <4d047af3-fd30-4fa4-aa3d-c0359856d750@suse.de>
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
In-Reply-To: <4d047af3-fd30-4fa4-aa3d-c0359856d750@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	RSPAMD_URIBL(4.50)[arndb.de:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,gmx.de];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 



Am 26.02.25 um 08:48 schrieb Thomas Zimmermann:
> Hi Arnd
>
> Am 25.02.25 um 17:44 schrieb Arnd Bergmann:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Dummycon is used as a fallback conswitchp for vgacon and fbcon
>> in the VT code, and there are no references to it if all three
>> are disabled, so just leave it out of the kernel image for
>> configurations without those.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

>> ---
>>   drivers/video/console/Kconfig | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/console/Kconfig 
>> b/drivers/video/console/Kconfig
>> index bc31db6ef7d2..1c4263c164ce 100644
>> --- a/drivers/video/console/Kconfig
>> +++ b/drivers/video/console/Kconfig
>> @@ -47,8 +47,7 @@ config SGI_NEWPORT_CONSOLE
>>         card of your Indy.  Most people say Y here.
>>     config DUMMY_CONSOLE
>> -    bool
>> -    default y
>> +    def_bool VT || VGA_CONSOLE || FRAMEBUFFER_CONSOLE
>
> What about MDA_CONSOLE and STI_CONSOLE. Don't they require this as 
> fallback?

I did some grepping in the kernel sources and found the answer to this 
question. It's still surprising that the other consoles don't use 
dummycon. They are never unloaded, it seems.

Best regards
Thomas

>
> Best regards
> Thomas
>
>>     config DUMMY_CONSOLE_COLUMNS
>>       int "Initial number of console screen columns"
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


