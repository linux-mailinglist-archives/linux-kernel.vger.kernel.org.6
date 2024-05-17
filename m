Return-Path: <linux-kernel+bounces-182380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE13B8C8A95
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C61C2103E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D013DB92;
	Fri, 17 May 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrFkxNyy"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8C13D8B8;
	Fri, 17 May 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965850; cv=none; b=LWWqpZwCuHDmYE/3xS3Dcsq22ybF4th4nY9q95DPCJL7C1Pct95ugIC6TiLC06HtBSWqcorxGe/G8ndXCx/DzcYiOqpcvNw3cAuGQFpuzXJvsbJwtD3G6HqSAmdvqkKKQlUGw8eg0yMDOot47PUqO4weWejMIySKBke8iUqCQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965850; c=relaxed/simple;
	bh=OkDC481zFr3zxzpw+em2PUv7vlhq7LknWjI47ro8VnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiFSQMezRvpFE+utRVF9juOFVaRYNnUwga25Qe75vML4hBYOdQIv5KOV9zKpljTN8dGcvkCcVC0IN/6OuBZLRy1fBX48W/LXlpJo5DTTsIVP/g8GjPwvb87XAgV5oj+r27QBIjrbkMmFNjsxTJjJAZbL47XEZ/rJp/UwJN2JEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrFkxNyy; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-60585faa69fso1054595a12.1;
        Fri, 17 May 2024 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715965848; x=1716570648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDj4uFMrmhKzYSh39UgL2iN+N33zW/zRmcdvFGlj4ic=;
        b=KrFkxNyyqA8x0RzMZ2kttotWxG9c8Yo72oiDbriBsqo3FgfuWjjRXrNc7iJgNKJY7x
         hmy7JXNsgM21JRUNabRSK5qXkiAmgzZa7kW3gXD7Kr16+BrZmJz+Erlr0V/cNab4zgP2
         nwaRqxEdnY8pTxcY3U0EdJvqZas5i0fSpYjzlogKFjMtpk2Puoxe9nolvEkYXCV6rkjF
         rvG0TCztyLivDB4twQydSFVf3pxvBkgwc2U0N3RZVcM+qtculf+0h/OkwhYGbtT65v1e
         4m2FSsmu9QgIlelcODnBUzXkalOq6QMBDqPjvLcoh35gjb5w+CxDlWFCU1h3XLjYn8uk
         E56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965848; x=1716570648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDj4uFMrmhKzYSh39UgL2iN+N33zW/zRmcdvFGlj4ic=;
        b=S755/ZTNKiD2uRtqsIi5qIdPE6d7JEPAFQ11w8157FtZGRZLyRGJClBaWgeiZAz3MF
         47b+LKrtR7r0sekKYEbObf+EpknIOM4tjHqlmjGI02xcAYoooTH/ijeMNi2K4x7CJ9Fh
         ek+mcU6VNyapjtN45IM9EM7xzIdazznS9gQfqpm7GmT+niFB4NbmLBxQ42RFafoxRW6D
         i9znte8tA5J7lI30zRrVBZg2cRJGpRuOmLIEEF921r7/bb0UMBlGZNe1MzNgsvVVFA2q
         OwQJCm3ZqKo0yOddqS2Y17HMNApADqVTJZX9vvoLW3kVHenjy/68v0Cqc/7wB+v/25aZ
         KtHA==
X-Forwarded-Encrypted: i=1; AJvYcCVnSaIpj4/dP6FGC4sUz6UQXsljsY2oSWyAkEiosONe/YoWkmxWHpodMxVeeIVN8Jlp5Kt3PVtTqtqB1bNNbnXdDjrNZ3j6byaKNPruVSHUrfmjRKG5qtifXiO6lbmhhf0TvVr1pWHSMXA=
X-Gm-Message-State: AOJu0Yw5ozNlUJuL83Idqd63a8yc1TUKUZ35CDgEiR0FY/6CB123J2Cz
	MYR52wvy50gDS6EGvNDfWJSaCLwmdNM3VU5ayVOVeNdOpdNhNeuO0hP101eY1R0=
X-Google-Smtp-Source: AGHT+IHf7EzDobBuG28rhBGM/jrbz7z2TmfK7/0FLrxUx9ilsRJHlu782DHm4IF+5lQiJWvjS7MVjA==
X-Received: by 2002:a17:902:d4d0:b0:1ea:691b:3692 with SMTP id d9443c01a7336-1eefa139e6fmr376856575ad.17.1715965848337;
        Fri, 17 May 2024 10:10:48 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31000sm159213325ad.145.2024.05.17.10.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 10:10:47 -0700 (PDT)
Message-ID: <a258b613-3697-4f21-a8fd-20b276f63132@gmail.com>
Date: Sat, 18 May 2024 02:10:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] line6: add midibuf init failure handling in
 line6_init_midi()
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, skhan@linuxfoundation.org,
 Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240516174737.415912-1-yskelg@gmail.com>
 <8734qg260i.wl-tiwai@suse.de>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <8734qg260i.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/17/24 5:32 오후, Takashi Iwai wrote:
> The allocated object is already freed by snd_line6_midi_free() that is
> called via rawmidi private_free at its destruction.  So your change
> would lead to a double-free.
> 
> 
> thanks,
> 
> Takashi

Thanks for the review Takashi.

I have one question:

line6_midibuf_destroy() have no NULL check for the memory to free.

If line6midi->midibuf_in is in this->buf = NULL from
line6_midibuf_init() with memory allocation failed,
won't the free(NULL) when accessed by snd_line6_midi_free() to
line6_midibuf_destroy()?

In the first patch, I was making a misunderstanding
Now that you mention it, I can see where it's freeing!
It helped me a lot in analyzing the driver code.

Please let me know if I've misunderstood anything.

Warm Regards,
Yunseong Kim

>> ---
>>  sound/usb/line6/midi.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
>> index 0838632c788e..abcf58f46673 100644
>> --- a/sound/usb/line6/midi.c
>> +++ b/sound/usb/line6/midi.c
>> @@ -283,13 +283,18 @@ int line6_init_midi(struct usb_line6 *line6)
>>  
>>  	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
>>  	if (err < 0)
>> -		return err;
>> +		goto error;
>>  
>>  	err = line6_midibuf_init(&line6midi->midibuf_out, MIDI_BUFFER_SIZE, 1);
>>  	if (err < 0)
>> -		return err;
>> +		goto error;
>>  
>>  	line6->line6midi = line6midi;
>>  	return 0;
>> +
>> +error:
>> +	kfree(line6midi);
>> +	return err;
>> +
>>  }
>>  EXPORT_SYMBOL_GPL(line6_init_midi);
>> -- 
>> 2.34.1
>>

