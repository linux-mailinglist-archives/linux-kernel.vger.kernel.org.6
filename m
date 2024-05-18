Return-Path: <linux-kernel+bounces-182780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA98C8FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 08:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C29F28359F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 06:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3428946F;
	Sat, 18 May 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgiT0S2y"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1005228;
	Sat, 18 May 2024 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716012046; cv=none; b=iIg2boWPnmcGZkjzLcRVRYhZ0US/yHAwCz3vteM8S6khNlEtmsqewR1PAC/K96mtD6N5uEzdkhtSpl79uFmVPTseQoyxGSbi645FhIeyFH5VB2vwQ404qXK7w8wNEYMZt6KOqpCN9xqHl54mL+ARwxu1b6sd+6H6KlPy47rEdk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716012046; c=relaxed/simple;
	bh=iPVwY+FLQJN/2C/In5skBXJrWKGZ7CLLiR6TcZqpUcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMJWliqVHjXqkrDWwOFGGMXJzMB06FfXKZCP7vPC09shYJaEcISo52YgJ+WBU71qUKNeMLScdTwqSyfrFBwxebY+JAQND+Z3G5bcROiSSN5eRLigwVzTy5ajUUr4J2zMwU+4GEj/lXKZgqMSUKCeNeLF9jVkQor+BqyQFxNA0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgiT0S2y; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3c3aa8938so28730445ad.1;
        Fri, 17 May 2024 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716012045; x=1716616845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2UEI9fgxAaUwQb09cLy2ONzt7BSkEaSUgAIAN/09lw=;
        b=DgiT0S2yccUDXBXB+LDR5k3KJH1lc7g9AeABGFcuzYSjeIDhzEIWAvQE/h2NOGNzKc
         Mh/W88ioNbRaD26ei/z53xSdMsMBekyc0N3DXSmd9GySlHsFZDOq1rwSVhPM8Pkonppa
         GB/2PsO11f1ssmLNBd3mJ+zIh+RMQHfb3fUbeUp5tAg3PsQgJP4aZpXypyb0eSnlA6d5
         mFk8SoyMGTfPSecjPVGu4fkJeSQJhT2qSRNMwhfbnURlRurXH1h8DTAnFYZYu5rhoj7s
         GC3PADa5nvYIuJHVh8Xqkmo4QW+G2H5H0AD1tPiUBDeQWPNLBY/pUhn+AzcAG8IxxqDL
         Po5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716012045; x=1716616845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2UEI9fgxAaUwQb09cLy2ONzt7BSkEaSUgAIAN/09lw=;
        b=B60vTpR13SJjmirLoo1IB0JKoEjorI3coIWFZC7PCYjfMwEvopgTPJvcNXPgDXMq94
         ike0HcNmFAtuyZ+SDpqiLi0MfDvpn3YzPobGkjpL7ZEaCG86fqCASnWHQPl9RoYZKirN
         S9ZFX42r4Mn1b9A6iYNYSfyrvWrZZI6WAUch2wR8DwOF7kkr16oZTy3IfSGb8de0DZWs
         MpRhR9SbQRxAerDw9+vcJBFnkIRcB8LYTMWO7aVwd4PiwHQpTR15QHuuVpZWJovKfYWO
         CL9niB2eO/6zak6X9eRpA6+wnxV/s4U/sE23BOWfJ4vAAA7zk5Cj1Cy0WJaga41h6U5s
         W6/g==
X-Forwarded-Encrypted: i=1; AJvYcCWePG8ZmdzEXLJ+PNC13WwWCS9xGFWwnouSrIR9lCunQzhf4ms0c9fidrlHkrrEkEvB/WhZp5duxyXTXYWMjFgxkRl6tJPgzl7ugtSdAdgeQb5pw+Ukn8LVGaC2TeaMxmnsGDb9D2rROQY=
X-Gm-Message-State: AOJu0YzI9Lrhtwi7meT5tcdVM7DNXOiBFJxUfocRPBH4/72zAoO0CgVQ
	ywt/+XXRUVhQVNty8ScdrhIOZjbpYhjm+ikQTHTU9F6/DVDEe16u
X-Google-Smtp-Source: AGHT+IHGQXL2vAX8CQ2cBc+7aBoKlt4Ku42AcF7oUx9sqTlVMsGFxj6YPilu4ncfGFmuHtEizpkYvQ==
X-Received: by 2002:a17:903:24d:b0:1de:f91:3cf3 with SMTP id d9443c01a7336-1ef43f4d284mr244213975ad.55.1716012044866;
        Fri, 17 May 2024 23:00:44 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136838sm167030095ad.232.2024.05.17.23.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 23:00:44 -0700 (PDT)
Message-ID: <b2537aa6-4c00-4c47-862a-0e706ebbf305@gmail.com>
Date: Sat, 18 May 2024 15:00:41 +0900
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
 <a258b613-3697-4f21-a8fd-20b276f63132@gmail.com>
 <871q608gz7.wl-tiwai@suse.de>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <871q608gz7.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/18/24 2:51 오전, Takashi Iwai wrote:
> On Fri, 17 May 2024 19:10:44 +0200,
> Yunseong Kim wrote:
>>
>> On 5/17/24 5:32 오후, Takashi Iwai wrote:
>>> The allocated object is already freed by snd_line6_midi_free() that is
>>> called via rawmidi private_free at its destruction.  So your change
>>> would lead to a double-free.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>
>> Thanks for the review Takashi.
>>
>> I have one question:
>>
>> line6_midibuf_destroy() have no NULL check for the memory to free.
>>
>> If line6midi->midibuf_in is in this->buf = NULL from
>> line6_midibuf_init() with memory allocation failed,
>> won't the free(NULL) when accessed by snd_line6_midi_free() to
>> line6_midibuf_destroy()?
> 
> free(NULL) is fine, it's defined to be noop.
> Many codes just call free() unconditionally for that, as it reduces
> the code size.
> 
> 
> thanks,
> 
> Takashi

Thak you Takashi, I've been studying the kfree behavior in detail since
you mentioned it, so thanks for advicing the details.

Warm Regards,
Yunseong Kim

>>
>>>> ---
>>>>  sound/usb/line6/midi.c | 9 +++++++--
>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
>>>> index 0838632c788e..abcf58f46673 100644
>>>> --- a/sound/usb/line6/midi.c
>>>> +++ b/sound/usb/line6/midi.c
>>>> @@ -283,13 +283,18 @@ int line6_init_midi(struct usb_line6 *line6)
>>>>  
>>>>  	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
>>>>  	if (err < 0)
>>>> -		return err;
>>>> +		goto error;
>>>>  
>>>>  	err = line6_midibuf_init(&line6midi->midibuf_out, MIDI_BUFFER_SIZE, 1);
>>>>  	if (err < 0)
>>>> -		return err;
>>>> +		goto error;
>>>>  
>>>>  	line6->line6midi = line6midi;
>>>>  	return 0;
>>>> +
>>>> +error:
>>>> +	kfree(line6midi);
>>>> +	return err;
>>>> +
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(line6_init_midi);
>>>> -- 
>>>> 2.34.1
>>>>

