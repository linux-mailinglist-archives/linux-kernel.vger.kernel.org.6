Return-Path: <linux-kernel+bounces-182779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEE8C8FBE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 07:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FFDB21890
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 05:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FBFB661;
	Sat, 18 May 2024 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d69BRHRZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87ED502;
	Sat, 18 May 2024 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716011894; cv=none; b=tKtxsDQWcDlPls7EHz/YIdakWJMxGnNWYQ1dtkFOKwa+6Irij5m5ZGDZFa9okKZlwRevh11V0vOMFPI2BtJCbsR/z1qe1S2mzsm5j5CZboCscN9NJYbPfM58aQfQY/t5fHfTrry0Ue0W6bXt/adDo0dhxmlNShcUTN3dDOJRaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716011894; c=relaxed/simple;
	bh=ugRuViyFEPNBRrmZZ9sug9AkrtWkTDBbReRg8Nng84c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=astR2ST8wRDb8QehZU3xfeb2RXYMb9eYyayrJAjKyxE/gZFDNAVcAuBTAb8ubNrQ8JFq4OI7NAdrLDHdr+7x2wuQJenEKyXNaXngoAcwyUVK5UMVwU4zaXf80R3Pll8Iu+uPQegx/U2t4DTJU1doEYTpRIZooNjo9oHUtSxu/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d69BRHRZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso31758085ad.0;
        Fri, 17 May 2024 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716011893; x=1716616693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpoWf0kPCPHx4qZHC3NR+sgkhHGRLiJPxCUCzupdh8I=;
        b=d69BRHRZ3Jol8D1v6uY2qRKD6yK0GCLZGy8oQLe81326UYzVP7KzU1HjWDHjyeXku1
         AmDiBmp6U3XCFdf9gMYQ7dgZacxGFw/eCauvvDyaUZAzcLfMrMrLwoWiWIgEHBsFHBhF
         aiY0K5r6wcYehpf8PagQZrsFu9KqqkTBR90qYoaHnyDSkvVni+ZeG/3aA4EG6L4R7NCR
         Sy2XC9+96bSMMtqLW3WOOBFRZy4GPtLzN4czwu0ObtmuLSTMzAz+gvMjFrYv+48zf1Fi
         s3L8iZd0ukjBFRS0zTARIV+HiGudvHLKXtkCx8peYt7pUtx9OajA8QpXA+HzZYYW1Ka3
         nMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716011893; x=1716616693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpoWf0kPCPHx4qZHC3NR+sgkhHGRLiJPxCUCzupdh8I=;
        b=irODBgNaWRszgEDU0thtpLkVXdD6+Wg8CvxPPAcGXhycpV1iR4j53rAADgkJBjUFYV
         RStUCa43vAl87cYVY4/WkBd5wchM6BCN6d7D6NyQ63l8oJnkBpgOddo1bXsIcyAI5Mjb
         Uae44gn/gBQpnEzB31qhr/jdW6WoG/Z854CebpVmJh3GokfbJfGFAPsrQY/6rSyNtiFW
         OALHT3SdqUOX0sO7h4fVlijPYdM/dJqTFc/U2noFhxvBmhm1r/IEqy14DwiS8H2a4+dl
         kA2dgtexZt3/Bi1miNZUB6zc2UlhFN0HzSiPEkK5594FLnlyOBdhlqCg/qeC7xTy2v4M
         CzGA==
X-Forwarded-Encrypted: i=1; AJvYcCXQFBZMxEg0+NJWEEWvTr9rhv0n/LxQNsUss5kDwQAm9uozysZJYHUbybUohQiYtvoQ/ySdLSL8memjNGbX7v6muUnZmYQPY/yyJo8qbEgi85+Ysci7g2MlyR/YBKdUAk0rNfAmni/tCPE=
X-Gm-Message-State: AOJu0YwQ9k9r4FePZprcy7lNwEhK3qldhX8qH/ybpvh/bq3KKPFbAXHX
	WrSx4cwnpAXE3XiSOeGF6jO/nqFx/m8B9AUBY/Jsnb1hd6RNd3NH
X-Google-Smtp-Source: AGHT+IGcKN+aZvNtvPth44dcJoWcC+S2QgC7f/MO2/BNFqKqDZh2q+d6XXj89yqtZTH9iDzPIIkppw==
X-Received: by 2002:a05:6a20:daa8:b0:1b0:1a02:4136 with SMTP id adf61e73a8af0-1b01a024396mr11872218637.8.1716011892754;
        Fri, 17 May 2024 22:58:12 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886d069sm18213737a91.25.2024.05.17.22.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 22:58:12 -0700 (PDT)
Message-ID: <659f274a-7152-4a6e-915e-6ed9f99d08cc@gmail.com>
Date: Sat, 18 May 2024 14:58:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] line6: add midibuf init failure handling in
 line6_init_midi()
To: Bjorn Helgaas <helgaas@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240517174426.GA2285947@bhelgaas>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240517174426.GA2285947@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/18/24 2:44 오전, Bjorn Helgaas wrote:
> On Fri, May 17, 2024 at 10:32:13AM +0200, Takashi Iwai wrote:
>> On Thu, 16 May 2024 19:47:38 +0200,
>> yskelg@gmail.com wrote:
>>>
>>> From: Yunseong Kim <yskelg@gmail.com>
>>>
>>> This patch fixes potential memory allocation failures in the
>>> line6_midibuf_init(). If either midibuf_in, midibuf_out allocation
>>> line6_midibuf_init call failed, the allocated memory for line6midi
>>> might have been leaked.
>>>
>>> This patch introduces an error handling label and uses goto to jump there
>>> in case of allocation failures. A kfree call is added to release any
>>> partially allocated memory before returning the error code.
>>>
>>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>>
>> The allocated object is already freed by snd_line6_midi_free() that is
>> called via rawmidi private_free at its destruction.  So your change
>> would lead to a double-free.
> 
> I stand corrected, sorry that I missed that!
> 
> That said, it seems unreasonably hard to verify this path to
> snd_line6_midi_free().
> 
> Sorry for misleading you, Yunseong.

Thank you Bjorn for your detailed advice. I will take them to heart and
work on them in the future.

Warm Regards,
Yunseong Kim

>>> ---
>>>  sound/usb/line6/midi.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
>>> index 0838632c788e..abcf58f46673 100644
>>> --- a/sound/usb/line6/midi.c
>>> +++ b/sound/usb/line6/midi.c
>>> @@ -283,13 +283,18 @@ int line6_init_midi(struct usb_line6 *line6)
>>>  
>>>  	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
>>>  	if (err < 0)
>>> -		return err;
>>> +		goto error;
>>>  
>>>  	err = line6_midibuf_init(&line6midi->midibuf_out, MIDI_BUFFER_SIZE, 1);
>>>  	if (err < 0)
>>> -		return err;
>>> +		goto error;
>>>  
>>>  	line6->line6midi = line6midi;
>>>  	return 0;
>>> +
>>> +error:
>>> +	kfree(line6midi);
>>> +	return err;
>>> +
>>>  }
>>>  EXPORT_SYMBOL_GPL(line6_init_midi);
>>> -- 
>>> 2.34.1
>>>

