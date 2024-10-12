Return-Path: <linux-kernel+bounces-362414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9B299B4AA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A165D282965
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255F155759;
	Sat, 12 Oct 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="G0uPOVnP"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED55154C09
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734329; cv=none; b=s7ma1d9PY3RdbdnUF81jKoyA9Ecg8j/JVfTZ3KbJdTNhT7FccTyjbuWUjna1Hd3Su1Mr+3m1ehCGR323BOA+BCvG/pTbyosNR7683vzHgvYyXzUsnMgnKvley5BnNR3D1Cz6qcDLXFVo87uEdyRlkOfnASmaz5E/v4IQ1B2SwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734329; c=relaxed/simple;
	bh=eUse1WaKbLNTi+lH1lFNxvAR/3Z5+DaPJh8J6RQchok=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WSKEWBNJCeFRxRKheILEpTHCjcLUxBcf6luFYAtS6xyZATvO3hCRB1ro0iWEesqAO1zTF0+PzJibwDjoFWgucVhDe0k30e+nqm7tA7v8jAI4nYcTWCZ92A21j3sg1tvmP2ux9K4SHea1xTOUoM3E1wY58+m4f15JH+4z38DA35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=G0uPOVnP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45f0a0f9687so27239591cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728734326; x=1729339126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Diub50GAsamJSYxMpuxJNl2q4XzBU/QQSzsDe5urvxI=;
        b=G0uPOVnPlaEHdTMT4knYoOwCjZ8N4ezGYLG/RMmu1Tx4k8Kd5Lc6UMXyDaJ6eydT1t
         CJTo3zyNcdeolc3SJGROQWLGOczciIJKWfbNPArt1mUu2l2VKtHR54MLjWeDRQ71solV
         wzm2FJR46TaHphr3WKKvq+X6D6EH1TGs/gj2/BWFdnasU4wBqhPqpmN1iYK8Ww0flAqn
         9k/Cil9ibkZGGI0ew4v7CAr4PV4dbEo2E5GxFJcA0LnqfMPf3V+gFKn1vUL8GC55lXfi
         H0BkNq8HAhatnRPnpA2EjqObpFkmfGCicCaxwBDLn1/r1QKyV3GVz0Ur3rSJrz226D9L
         GpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728734326; x=1729339126;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Diub50GAsamJSYxMpuxJNl2q4XzBU/QQSzsDe5urvxI=;
        b=IQISgNznzNOAqIW4uAnn3dsZ9aBzMrij3mW+DTZi38/vnyL7R2Z4cFhTzqrZr/F4XI
         zDX+YwU/dX239cXIerg49aVd5xR1BOSOGglC24Ba58bQPqew4oNLPw0WWvSAYeY/Mnx5
         LKn834Tq+T4PffqH15xS78o/WVKRx5qnrfpsEWBaLSlr7tp2t7eiqICv8TXqOTI7rAbk
         M94+sFOSqZatBA+m0hcEMxxYCKNkacO9+9xk+m1cr5x25KE+XDMidif12bpYdtEiInmE
         obNF+zCyjerEBqrmms3/Ul5AJQuw6J3s8T3Y14al3aFPVk0NwbJipmS4tLZg4vpN4WA1
         6nwg==
X-Forwarded-Encrypted: i=1; AJvYcCXuoYU+To1/9mdMWsq2Xj5rG55mDoDiXRIhqYHDp/jzfAuPaVzX3cuJrhJV7M6ZcbTYW3bICtGfOZ5+pH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNtPnbh1b1SThV+lnHpPHzgTbUnwySBXeZsqfyv+IcOcm/CLL
	wTuKcGRLEIAZXKia0vm4Nd9E9sJfsCAxc9MJLdJy/MH/W46Ro30ht23hpOzExSl9gTkNuPV+/a/
	Rt5k=
X-Google-Smtp-Source: AGHT+IG48YvSRedxV9qgCtTINLv1hMQ+u3WbGEyfbf2QUOxBeV0LQCrBJBQXamJYXZzcuASZZIqS8Q==
X-Received: by 2002:a05:622a:11d6:b0:458:3a34:b7b5 with SMTP id d75a77b69052e-4604bbccd65mr84992431cf.26.1728734326462;
        Sat, 12 Oct 2024 04:58:46 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042895a9csm24040501cf.91.2024.10.12.04.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 04:58:46 -0700 (PDT)
Subject: Re: [PATCH 1/3] efi/libstub: fix efi_parse_options() ignoring the
 default command line
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20241011224812.25763-1-jonathan@marek.ca>
 <CAMj1kXFstg+2j9nYCO=_=L3LAd4PYc5vO3OX4EtHfFA90BXv5Q@mail.gmail.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <5364ea9f-9042-3fba-5cb1-c42ae94b0d4b@marek.ca>
Date: Sat, 12 Oct 2024 07:55:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFstg+2j9nYCO=_=L3LAd4PYc5vO3OX4EtHfFA90BXv5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/12/24 3:46 AM, Ard Biesheuvel wrote:
> Hi Jonathan,
> 
> Please use a cover letter when sending more than a single patch.
> 
> On Sat, 12 Oct 2024 at 00:51, Jonathan Marek <jonathan@marek.ca> wrote:
>>
>> efi_convert_cmdline() always returns a size of at least 1 because it counts
>> the NUL terminator, so the "cmdline_size == 0" condition is not possible.
>>
>> Change it to compare against 1 to get the intended behavior: to use
>> CONFIG_CMDLINE when load_options_size is 0.
>>
>> Fixes: 60f38de7a8d4 ("efi/libstub: Unify command line param parsing")
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   drivers/firmware/efi/libstub/efi-stub.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
>> index 958a680e0660d..709ae2d41a632 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub.c
>> @@ -129,7 +129,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
>>
>>          if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
>>              IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
>> -           cmdline_size == 0) {
>> +           cmdline_size == 1) {
> 
> I'd prefer it if we could keep the weirdness local to
> efi_convert_cmdline(). Would the below fix things too?
> 
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -395,9 +395,7 @@
>                  }
>          }
> 
> -       options_bytes++;        /* NUL termination */
> -
> -       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, options_bytes,
> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, options_bytes + 1,
>                               (void **)&cmdline_addr);
>          if (status != EFI_SUCCESS)
>                  return NULL;
> 
> Note that the only other caller of efi_convert_cmdline() in x86-stub.c
> ignores this value entirely.
> 

Just changing this would just make things more broken, the following 
snprintf would remove the last character of the command line because it 
uses options_bytes.

Since this patch has a Fixes: tag, I wanted to make the fix as simple as 
possible. If you think comparing the size to 1 is "weird", the fix could 
instead check if cmdline[0] is non-NUL (or just strlen(cmdline)==0 if 
you don't like that either).

And then my followup cleanup patch can just remove the cmd_line_len 
argument from efi_convert_cmdline().

