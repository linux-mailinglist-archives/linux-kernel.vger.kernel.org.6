Return-Path: <linux-kernel+bounces-348286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C09EE98E546
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2CDB24A71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138BA219484;
	Wed,  2 Oct 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAP+BuJj"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182A217916;
	Wed,  2 Oct 2024 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904494; cv=none; b=oSy8dJjIXP1d6xAm+sNK5R9WyPBvRSdKuXOYnZChaaaFX3uqL9UNXrH8MP3SgMP245+rS5qzmv5nTBd7trLw1kKg3AhIOUxP/NEbo7sXmL/99sVef0heEv+ZmNZt0jlhQEQqBtLHD1jDaP7cBvHkDKSVk7z3CUZ7rP7vzYtQE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904494; c=relaxed/simple;
	bh=Ek5xP7tDojZIjV5cpwXc270GU/QwGv4towDbDwIlbzk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=WH8h/zyRAzDOF7Q/wWB5IJ2MW8HintxEVD3tsbuhpRfdYlez4LrGdkEuW9kAoiAu7w/Dw13rkqXOvlGqvJTS7jOC8ZGl5fhuzeOrr0No9p50Pov9oinEnG/t8CxGruJUYZCXBeMhuo5ldh1IVPVAK2zx+O4yIkJ5/4672vjUWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAP+BuJj; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a1a4870713so1146735ab.0;
        Wed, 02 Oct 2024 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727904492; x=1728509292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZ7/ZmdrYH4n2tD9mSFZRsbwEz9ztlvm2F1fv4gyLGI=;
        b=JAP+BuJjF9npsOPEISLMGLi+d8C6NWMUUrOXqRn70DeOYdZC7fTw3NvlKZaLRAO88O
         13tLzIAHc8IM2PLmvbZWO56CD+IL6Pe5pLh1T8VhgII4Qn89TE9zkR384gWXoWIEnK+Q
         l0bUGnY3zOkjBeLMp5LqK3radnS8gjeNXDBTvbNqVSWWNOrZcYRBeZm7JFpbqD3/QuD0
         4ii2K1ZP+poGxYgUYXvMWafnb//P0ijnXIlUI47OlUs/F3dogMlR4vC7/ER//lcYKX/o
         G3Sj7L/iA/fTEZDxVtegQW+QjZ53U7GiEULkQGX5IFnAjYK03CgNMa13FYUm8BzCRkuC
         ToEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727904492; x=1728509292;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ7/ZmdrYH4n2tD9mSFZRsbwEz9ztlvm2F1fv4gyLGI=;
        b=xUlHX3rZitdYwls+LKGLhv5mT4lNepAIdH66u3Wuq6YWlBQ0E1N1JlZwgsjKnh8ecw
         kiGC8bG//qhxFwivv2pPvZ6vI1P1helFUGEGUEhmJAazBZmjDj76UhgrjbRVbwxuWlnE
         LeKssTJH7embkDKjU4bcvovtYn3b/DnB3u0NA+5HpirX2mzGunwzpNsAD+6+S9sEVSs2
         rN0pS/7XVjQw+u1MvSo3MZE/3fugCn9zJ7PwiEe4dwhcVjJBNBfHwD9/NCNdjr530gt9
         r3FjRmrzv8laKJuX1MSvbTJyqBF0fGguz/JDuqrwar769tX+35h9M9al/fUYlfhoxYBT
         eKwg==
X-Forwarded-Encrypted: i=1; AJvYcCUrevtw0agdOH64FMh0D/j2ojG41QTKh2QvWpV3h0D295VS6dUJlzgyks0e3uYT2VcPqe6COwjxsmqYXuw=@vger.kernel.org, AJvYcCWqdX7nr/uTBgiHwWo2UXtpqX8XteARTLmyelR9dZsCAQS2zTtorwV9Bf9j29Pdbcpzv++JsosDMdZP6zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOoknKGe3i+Le64cLe4QeA/A7oKYdGN9l3y6E1/9NGzFviS7/h
	LBC/jjZNTuVpKH4naRbPeaiyRCkLoJsxUhjGbmbyJbqTm8HwLOwCHP13B72nqlYsTw==
X-Google-Smtp-Source: AGHT+IFtTdeOoDQGQrpybtl8PD/Lm2as5ATYsxj1tCZUA6ygEz2H8Aix3rjgqiyYIhj1dX+xWEn/+g==
X-Received: by 2002:a05:6e02:154c:b0:3a0:a4dd:683b with SMTP id e9e14a558f8ab-3a3659194cemr41174355ab.8.1727904492099;
        Wed, 02 Oct 2024 14:28:12 -0700 (PDT)
Received: from [10.130.138.83] ([149.88.104.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db29427bsm10434846a12.15.2024.10.02.14.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 14:28:11 -0700 (PDT)
Message-ID: <d348ca06-38ca-474f-8673-dff2248331e5@gmail.com>
Date: Wed, 2 Oct 2024 17:28:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Takashi Iwai <tiwai@suse.de>, Christoffer Sandberg <cs@tuxedo.de>
Cc: christian@heusel.eu, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, perex@perex.cz, regressions@lists.linux.dev,
 wse@tuxedocomputers.com
References: <87jzfbh5tu.wl-tiwai@suse.de>
 <ea6e5168-238f-41f5-9600-36b75ed990a1@gmail.com>
 <87jzetk2l0.wl-tiwai@suse.de> <b38b5947482a5ca4b55e0ddb908c2f34@tuxedo.de>
 <87seteli51.wl-tiwai@suse.de>
Content-Language: en-US
From: Jerry Luo <jerryluo225@gmail.com>
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <87seteli51.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 10:00 AM, Takashi Iwai wrote:
> On Wed, 02 Oct 2024 10:21:22 +0200,
> Christoffer Sandberg wrote:
>>
>>
>> On 30.9.2024 09:44, Takashi Iwai wrote:
>>> On Mon, 23 Sep 2024 21:37:42 +0200,
>>> Jerry Luo wrote:
>>>>
>>>> Hi Takashi,
>>>>
>>>> On Mon, 16 Sep 2024 19:22:05 +0200,
>>>>
>>>> Takashi Iwai wrote:
>>>>
>>>>      Could you give alsa-info.sh output from both working and
>>>> non-working
>>>>      cases?  Run the script with --no-upload option and attach the
>>>> outputs.
>>>>
>>>>      thanks,
>>>>
>>>>      Takashi
>>>>
>>>> Issue now reappear, output from alsa-info.sh are attached. If they
>>>> are still
>>>> needed.
>>> Thanks.  The obvious difference seems to be the assignment of two DACs
>>> 0x10 and 0x11 for headphone and speaker outputs.
>>>
>>> Christoffer, how are those on your machines?
>> I attached alsa-info from the Sirius Gen2 device.
>>
>> Comparing the working/nonworking of Jerry, yeah, the assignment of
>> 0x10 and 0x11 looks switched around. I don't see what difference this
>> would make. Also, node 0x22 has "bass speaker" controls in the
>> non-working version.
>>
>> Comparing the Sirius Gen2 alsa-info with Jerrys, to me it looks like
>> the non-working version corresponds to our working version.
>>
>> I would expect the non-working version to happen all the time though
>> with regards to the "bass speaker" controls. Why would this only
>> happen sometimes?
> Thanks!  The assignment of DACs depend on the pins and topology, so it
> can be a bit sensitive.
>
> Now looking more closely at both outputs, I wonder how the commit
> breaks pang14.  Maybe it has a PCI SSID 2782:12c5 (or 12c3) while the
> codec SSID is 2782:12b3?  If so, the patch below should fix.
>
> Could you guys try it and verify whether it fixes for Pangolin and
> doesn't break Sirius?
>
>
> Takashi
>
It does seems to fix the issue on Pangolin. It might worth mention that 
the headphone output will have the same issue when the speaker is not 
working. Now they are all good. Thanks!


Jerry


