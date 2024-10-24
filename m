Return-Path: <linux-kernel+bounces-379229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6839ADBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873A3B22361
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5403175D2A;
	Thu, 24 Oct 2024 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx+t+zJU"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E917BD3;
	Thu, 24 Oct 2024 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750178; cv=none; b=kPavHu3tFtiFFGCRiPYaZ5sCLFG4Xhq6v5BDMdRID4+t+KJOtV6SHKHPbhwedM867/hwQ3EHe80aov7moVyjY6MIdJqUBWRJMs23jWxVgjTX0t7buYssm/qJ+UVE+f7A6FSW6+PpuvDXTuKOuUmcmUbS7hH9gETPreU+ZmNJ2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750178; c=relaxed/simple;
	bh=PcgAAox4ofYSglKlR7U2qP9QT63P1uz7ubVNbTxtPfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqiLQRGVgDzxOBg5edehreihKAbRjruA/poIYDjDpL/T0GQjFOlVUEDjQFtERDLMn0770FUnkA4xjy/vXaFcSqlyTKvk1tlhn72YE7MfI/CMubHQP/RiETNoRULGRMBDQ7w4jTO8UOmRxBqlBVXlTtpNRq3T2IsZzusHelYtgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx+t+zJU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f58c68c5so776468e87.3;
        Wed, 23 Oct 2024 23:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750174; x=1730354974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxebdquBlAlwZJ5oz/fW7V6vZLRtB6HS9hVsNow4hfk=;
        b=Tx+t+zJU1iWxv0rBWfuwQmOeabJzjWEQiyQVDto/2KfHXuVfZH4tzqI/KRV9svC8Ag
         A22HYD/8ijXWeuW7PCq3K68eK/Xp9NbcXouWbPT8KQWcQxbC79TCHfUwMHp2pxHRcxE7
         0VKzdWD5fPcC316NjrUSoZ3gopiaewHdCkX1Yz1M4mJuVJxsYliF7sHH9n9as4pv8Aik
         8my1WSWj6VjHIX/5d6LT81SgLpR0BEReMlbVgT261eLO3lou47P4NdgVU76cJzYCc4NE
         EWNfDdIENErZS357Pe7igzTmDj9F0ipQAjfd+jTFkC6RFVfNClshiSGWBBw5+eBjZLH2
         EsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750174; x=1730354974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxebdquBlAlwZJ5oz/fW7V6vZLRtB6HS9hVsNow4hfk=;
        b=dZREKa+bkcSpgstlp6hbj6Nt72zi9jm07QiERElNjeUfqj5X0YYUGqKdcaIdN5Xp6C
         JCSXGhWxtYkh8/a5zONHp5uAfOvTcfJxm2DwLmspx9pnC5q7Mi0iwnEWUPfn9A5RFDQ9
         oJsgdRPseYiGGyomgNtvWhfYymGpfcTdXgGrNkTc4u8velHw2gOS+/Pn+g09hRmCp1uN
         xFiy8e00pSb7aHJ8Qy9wz3o5mBEmW9TR5ffEGhXOOmDqpsd7AiNnT04vY5VWNyHqzN90
         yxfkzzSww2R0z2VUOHKGQHjq0eASOnXGbSOxzlIf+Un4gGx1WObbsGdgvKyBC7pVQ8kp
         RbfA==
X-Forwarded-Encrypted: i=1; AJvYcCUyQvETqFJv5OsINq91sR7ov34Ukl6cF1h1y3Uv3Tqf23CXlmLa4KbAngEk51UIv1ep+wGPZ4W4cWKvD4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTiGWzGTfInsW2g8KEIxsHNI/IrOVkkk0c/3DZRqzkfAwkaZ//
	y+qm1YgthKCD+ZHLgDFBGFcfp0B0CixMEGisOA1vWeE6hE18Z+9U
X-Google-Smtp-Source: AGHT+IFhFF/po4GR7sgK1fno9tCDeh8VOqPb14fKZK/pIpdsZzUoh3CrVD0afSZ/iVNCBqSM9nc0dw==
X-Received: by 2002:a05:6512:1154:b0:539:e0e6:cf42 with SMTP id 2adb3069b0e04-53b1a39b039mr4532355e87.43.1729750174091;
        Wed, 23 Oct 2024 23:09:34 -0700 (PDT)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243145fsm1254817e87.192.2024.10.23.23.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 23:09:33 -0700 (PDT)
Message-ID: <bc15b5f4-9596-486e-a275-5cde82a92985@gmail.com>
Date: Thu, 24 Oct 2024 09:09:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: error: Add EOVERFLOW
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, a.hindborg@kernel.org,
 linux-kernel@vger.kernel.org, dakr@redhat.com, airlied@redhat.com,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
References: <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
 <20241023113309.1724992-2-abdiel.janulgue@gmail.com>
 <CAH5fLgj7zYc6jg3vyqKNc85vkAvfgD1yqrUWj2-NcyR3kDPCbQ@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgj7zYc6jg3vyqKNc85vkAvfgD1yqrUWj2-NcyR3kDPCbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/10/2024 14:39, Alice Ryhl wrote:
> On Wed, Oct 23, 2024 at 1:34 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> Trivial addition for missing EOVERFLOW error.
>>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>   rust/kernel/error.rs | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
>> index 7cd3bbab52f2..92bfdaaedb02 100644
>> --- a/rust/kernel/error.rs
>> +++ b/rust/kernel/error.rs
>> @@ -63,6 +63,7 @@ macro_rules! declare_err {
>>       declare_err!(EPIPE, "Broken pipe.");
>>       declare_err!(EDOM, "Math argument out of domain of func.");
>>       declare_err!(ERANGE, "Math result not representable.");
>> +    declare_err!(EOVERFLOW, "Value too large for defined data type.");
>>       declare_err!(ERESTARTSYS, "Restart the system call.");
>>       declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
>>       declare_err!(ERESTARTNOHAND, "Restart if no handler.");
> 
> The commit message should explain why you're adding it. What will you
> use it for?

Yup I forgot to include the intent of the change, which is needed in the 
next patch. But will fix in next update.

/Abdiel


