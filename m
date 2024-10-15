Return-Path: <linux-kernel+bounces-366941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4C99FC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329DD2827C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81D61D9A69;
	Tue, 15 Oct 2024 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KfgB6TsH"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A221D2B34
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034964; cv=none; b=AKV0r4sR/yYz3TBdx4zsoyq//TPpFE8vtvzB1BbcNoFv/6fs96u7WNhATM47ihFJSXblzxIPtf1n8Cv/kuNnfG5p4D/A430RulbaEqfq8DMhYseVKc42KZEfV8JEo0j/eYycRSGmFwSea+A/deZr5PuqHeBw4nAGaxEln72TAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034964; c=relaxed/simple;
	bh=aSwLkbAg43vtDDBoHNNuZ5YDhsqlgniTJuAAONwuPS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9KK4mf2lMt6y88fnSU5puyhP4C7Axhspzz9+7MnaHGkcy5PW3vTcymgSVp6a92yuxNTeTaGwbOFCQytpfJorilXki/9LxV3YdcXyahKRk/RBf9LkjqZ7tgtsoxnolUPd6yjBaRWC23+GPMiO3qeJ6Ox74nykHXSeb/tS9MO0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KfgB6TsH; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8354c496c90so205320039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729034961; x=1729639761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiwQWjNAYRLv98HF5mn8aLwRjPp1fG7H9swFAKakcak=;
        b=KfgB6TsHLvnjhg5SblPvmJIrHVBi2df+vvclX+ebosY3TNaGDmS+ngahTNZpNRqf0M
         GMqDiChWpdZ42smlHGwi5+is7rAvgJ2Me+v9Gj9A4aPDD4bsyaWDHZSr26HFNAwxwfB+
         5JsFkUAD5QnW2L9uUf/tTdsYig7gpYf7Iwhbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034961; x=1729639761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiwQWjNAYRLv98HF5mn8aLwRjPp1fG7H9swFAKakcak=;
        b=VnhqQPIKg/jLV4UEQmIIyLw7/m6zF8Tx1p4zdZ8hXgXt0y0bTp3n7QPt+W+ct1GTvs
         SGiMcQfx9MZ6dXbkrzkV2DNwfChhV6TdW5Ml/4PWTTFHApaCdPRWMmcGeqzofErCSAVE
         WdRSLPSpuTsq0hF0uS8m7Qx52Jm48HazhiMmgnneav0wJ/VvgWQ4MCPoW55AJ1pfN9bP
         E37JKL5McjfYg+dRC+cFmkxVd7DhxGKG0InmiHl+NYS5l/pRDL/8SMfkw/HrUcK3vtDH
         zUDHXkcVLy5qCj1G7KQOo/0FzwPHOEBHUTclwPn2vIJTmuzr0Tu/xJv2IqHyZ3wZmBxI
         Enww==
X-Forwarded-Encrypted: i=1; AJvYcCU9L3DO2Zm9M+MBt+WK2PBwGB77XRZBnGhwrvnct229kiwmzYaUWhZjY2XSiyHt3l3BbqWtsQiFeJU78a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeU1UyXSCAm+0okWSpeNKfsTF35vJkThmOsINCNPVAHGGJ8SHO
	qEC9rXPLqGlHjQFwJDmZGPb8DOOGcFuujpsDbIwHUI2YieH4xhEk5uC4uMPBV64=
X-Google-Smtp-Source: AGHT+IG9/ijx8O8bt0d/vr41CJMfHDoF/ElE4j1gdOio/SpELPQZGy06Sl7jg/vuUeDNiohtllal/Q==
X-Received: by 2002:a05:6e02:1885:b0:39d:637f:97bc with SMTP id e9e14a558f8ab-3a3bccda708mr124780335ab.0.1729034961366;
        Tue, 15 Oct 2024 16:29:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70cd2f2sm5419945ab.43.2024.10.15.16.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 16:29:20 -0700 (PDT)
Message-ID: <748e78b9-3c70-4300-9de4-6df00dffe4c3@linuxfoundation.org>
Date: Tue, 15 Oct 2024 17:29:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: gpib: Move free after the variable use has been
 completed
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015215157.18571-1-everestkc@everestkc.com.np>
 <99056bd3-748f-42e8-a25a-131f7b194f55@linuxfoundation.org>
 <CAEO-vhEwkQKnPprdw_r=mg6KRbadY6B4A3R_sOsyH0ds78wb2g@mail.gmail.com>
 <f53523ff-1222-4fc0-9069-10ab895e1136@linuxfoundation.org>
 <CAEO-vhEGJ-5vX6=32VwNfiV7nSkDL4iEJVti8U0=q=NfOKrSAA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAEO-vhEGJ-5vX6=32VwNfiV7nSkDL4iEJVti8U0=q=NfOKrSAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/24 17:04, Everest K.C. wrote:
> On Tue, Oct 15, 2024 at 4:55 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 10/15/24 16:48, Everest K.C. wrote:
>>> On Tue, Oct 15, 2024 at 4:35 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 10/15/24 15:51, Everest K.C. wrote:
>>>>> The variable `in_data` is freed, but used later in the code.
>>>>> Fix it by moving the freeing the memory after it use has been
>>>>> completed.
>>>>>
>>>>> This issue was reported by Coverity Scan.
>>>>> Report:
>>>>> CID 1600783: (#1 of 1): Use after free (USE_AFTER_FREE)
>>>>> 19. pass_freed_arg: Passing freed pointer in_data as an argument to
>>>>> ni_usb_dump_raw_block.
>>>>>
>>>>> Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
>>>>> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>>>>> ---
>>>>>     drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
>>>>> index 1da263676f2a..75f39e1f3ed1 100644
>>>>> --- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
>>>>> +++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
>>>>> @@ -690,12 +690,12 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
>>>>>                 kfree(in_data);
>>>>>                 return parse_retval;
>>>>>         }
>>>>> -     kfree(in_data);
>>>>>         if (actual_length != length - status.count) {
>>>>>                 pr_err("%s: actual_length=%i expected=%li\n",
>>>>>                        __func__, actual_length, (long)(length - status.count));
>>>>>                 ni_usb_dump_raw_block(in_data, usb_bytes_read);
>>>>>         }
>>>>> +     kfree(in_data);
>>>>>         switch (status.error_code) {
>>>>>         case NIUSB_NO_ERROR:
>>>>>                 retval = 0;
>>>>
>>>> Looks good to me. Isn't this on next though. Don't forget to
>>>> indicate it is against next.
>>> No, it was fixed in the linux-staging repo.
>>>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>
>>
>> Okay - by the way the same problem is in ni_usb_write_registers().
>> Did coverity catch that one?
> No, there were no similar issues caught by coverity.
> Also, I just checked the function. I didn't see the variable being
> accessed after
> it had been freed.

Yeah. You are right. It was out_data that was freed after
last access. in_data is fine.

thanks,
-- Shuah


