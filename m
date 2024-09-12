Return-Path: <linux-kernel+bounces-327254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4549772E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55F1286189
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122341C0DF2;
	Thu, 12 Sep 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d03exMrO"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF61BFDE5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174083; cv=none; b=OUItbAJafXydcQOYKngvwWtoYhl0PZP1TnWYeuTNoK7DolU2ozmZNzzHVi133L9LJfLgrc05up6s/N6+5KCP+vWusUCGWlO2rt9ux5ShR6YbblvBSbr96OAMKW8Mi9MY85iw/63E6rLZb/GyQ5/BV/G6SVNM8V4FFo1wuw39owc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174083; c=relaxed/simple;
	bh=fFGd0nbcu1F8PntbunsMOTAoXiViOoBV+7xVFt/6B/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooW9RDA0TW8M0ZAGznOcmcohgWb/cI3Oxnms/R41QJvn53+3OgILem8UfLX+iaHogg3XelPA3ZsLU8DLBtTd/OrBcQYdUtuW7BdGSrKu7mUJSDlp8UpU0X5EEK2mni9L76QIb56XJ5T8z6tu29n8e+azgI8kWXg7rwTtdhALWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d03exMrO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53653ff0251so323705e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726174079; x=1726778879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkjthmIF2fQCuoFWxdVNQGVlLGFryPfHPsH+MeuiVys=;
        b=d03exMrOLgEbvBk+OcX/q32Qpde+WxGPyanEVkn59z9bRg9HWMdmPnlNZPEL0rjFhf
         CqvFbSrnl7B1qpYbZ3OCPKyraAiyqalvVFQVofFAbssJ03hZ3L4IfksBzTvlOZobQPnH
         B0x0BdllSCSw2LO0X0USaTAHQoPiRHz35y1KVGYjYxeB3mA8imk/P/qMKbPTOFTJD3+R
         mhhFUu7ZFldxpqqK3eu6rAFBsm85n/1bNr6Q790D4LbTBFyFmTeVGNWAtKqD9cDGRpaR
         1l8ztLOCHUidzuNgV8FC889vBC8r4JlfZTyXxHkHbTYJQ8MFqtwqrl9Lx8BBWTDsCb9F
         6G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174079; x=1726778879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkjthmIF2fQCuoFWxdVNQGVlLGFryPfHPsH+MeuiVys=;
        b=Ix9qxZWRdthuN2KNt6oLaPVJb4aZ25665AXgjbvUNTyCbMRFq6088FSk17B86T1klx
         sAE0D/jxJiHhetYqSiKT86ND/VmA0YgrskA07iEj7jhvbqESJWmUd5+THnU33u3vsKYh
         /YdlTdlCBcBbKAPtbZXH+2oA1TpmVkEVjmpq1nwRAT1TeWjrjTaZG66EHXHG2S/KDpep
         UFmBMKuRlGdqH4P4IDwk8NLjvnRnxwHUuGmQ7Tviz3FFVrW8gmak4l/y2M+AczFF1fDe
         KAAsXIBmon9PPrml3r2iUy84IyMJ8qvGZ40Yp3iQNAq4AJNYh5HuyE+lGOXLmt8LRClK
         0qbg==
X-Forwarded-Encrypted: i=1; AJvYcCXPmt8iIY45ahliEKXBzbXwI8NPScuygb9CBuBxgOhC9BtptzO+NPGfJv9jXZ5NUPjdxF1fXNRlXyXHXvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3FaekbvRa/2C5sLoIxZS7qd6bFxxKgy3RK5SnDi1ZY8OmRg77
	ijG+5yIi2dxuAgeYEsKNdxyjd7Wkf1d5EypFmxyuExnaj9Ha0BhS
X-Google-Smtp-Source: AGHT+IEJ3divZG1giZLk4zL0xR+Zgkb9nKkzNvfUXc9d1wNJItRtam0P+33/fr0+sYxqjutD2DBQFw==
X-Received: by 2002:a05:6512:a91:b0:535:3d08:5844 with SMTP id 2adb3069b0e04-5367feb964fmr331262e87.6.1726174078682;
        Thu, 12 Sep 2024 13:47:58 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8557:476b:8cfa:99ee:514e? (p200300c78f2a8557476b8cfa99ee514e.dip0.t-ipconnect.de. [2003:c7:8f2a:8557:476b:8cfa:99ee:514e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced20csm795531666b.172.2024.09.12.13.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 13:47:58 -0700 (PDT)
Message-ID: <6180dbde-16a7-48e2-8926-b17a13dc0c57@gmail.com>
Date: Thu, 12 Sep 2024 22:47:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vt6655: mac.h: Fix possible precedence issue in
 macros
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240911180149.14474-1-dominik.karol.piatkowski@protonmail.com>
 <f4e58090-0229-4a72-9bb6-d57757eb708c@gmail.com>
 <ILhrP61gFh-bKmnqG1DTIWCjW8yXNVEI1mGa2Fm-y_yhZ4kV-WCxXoid_Yuy7w4-kyH4QVT7B3h-OUUBH0rAtjCM8P5tMQxG_zLjKrq4NEM=@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ILhrP61gFh-bKmnqG1DTIWCjW8yXNVEI1mGa2Fm-y_yhZ4kV-WCxXoid_Yuy7w4-kyH4QVT7B3h-OUUBH0rAtjCM8P5tMQxG_zLjKrq4NEM=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/24 22:18, Dominik Karol Piątkowski wrote:
> On Thursday, September 12th, 2024 at 21:29, Philipp Hortmann <philipp.g.hortmann@gmail.com> wrote:
> 
>>
>>
>> On 9/11/24 20:02, Dominik Karol Piątkowski wrote:
>>
>>> It is safer to put macro arguments in parentheses. This way, accidental
>>> operator precedence issues can be avoided.
>>>
>>> Signed-off-by: Dominik Karol Piątkowski dominik.karol.piatkowski@protonmail.com
>>> ---
>>> drivers/staging/vt6655/mac.h | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
>>> index acf931c3f5fd..a33af2852227 100644
>>> --- a/drivers/staging/vt6655/mac.h
>>> +++ b/drivers/staging/vt6655/mac.h
>>> @@ -537,9 +537,9 @@
>>>
>>> /--------------------- Export Macros ------------------------------/
>>>
>>> -#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, iobase + MAC_REG_PAGE1SEL)
>>> +#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, (iobase) + MAC_REG_PAGE1SEL)
>>>
>>> -#define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, iobase + MAC_REG_PAGE1SEL)
>>> +#define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, (iobase) + MAC_REG_PAGE1SEL)
>>>
>>> #define MAKEWORD(lb, hb) \
>>> ((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned char)(hb))) << 8)))
>>
>>
>>
>> Hi Dominik,
>>
>> git shows your name with the following characters:
>>
>> Author: Dominik Karol Pi^Etkowski dominik.karol.piatkowski@protonmail.com
>>
>>
>> I think it is better to change your name to only english letters.
>>
>> If you send in a second version of this patch please use a change
>> history. Description from Dan under:
>> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>>
>> Thanks for your support.
>>
>> Bye Philipp
> 
> Hi Philipp,
> 
> Thanks for testing my patch.
> 
> About the mangled author field - it was sent as
> "From: =?UTF-8?q?Dominik=20Karol=20Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>"
> and =C4=85 in UTF-8 is indeed 'ą' character. When looking at linux-next tree,
> previously accepted patches also seem to have 'ą' as intended. I am not sure
> why you are seeing "^E" instead.
> 
> Thanks,
> Dominik Karol


Hi Dominik Karol,

you are right. On the from Greg accepted patches the 'ą' is as intended.

Then everything is all right. Sorry for the noise.

Thanks for your support.

Bye Philipp



