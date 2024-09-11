Return-Path: <linux-kernel+bounces-324108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532DF9747FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16274282B11
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB5125762;
	Wed, 11 Sep 2024 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IazZ/49A"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118927446;
	Wed, 11 Sep 2024 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726019732; cv=none; b=bdLN7uuXpLtRjCpVcPvPs27h6v6bXXtshUPusw7aX5/RceQ3OoHnTPPZ62MtHJbLMTrfeDjnb48rtPTAjPY5La/vCgnH7ZwdOxTD8yTTaFqANaKAv7h6Q7wB6PiF6iwf92t5wlfLBbcOmkyNknF/X97p3BdgPlK3k3rR6ONjYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726019732; c=relaxed/simple;
	bh=8butQKKyRn3hnqeVHrgtVu+CTLHq0RkmOSFk94x8Guc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuKsvg9r+PPTlBK77E2iIPAEvH1TuxlVJOtr0ETKBeMzAp1/chU+93nboXe7yJC51hLYUwokqFV6rw3CLCgakDeJmWQovhrWOxkDKmNPEMiQiRMGGhFsmkpHgOeIpOaQiA8m2l6EDjPUTMjiB868p2P1yk1MVt4HyM4VDnsl8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IazZ/49A; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d8b96c18f0so4877322a91.2;
        Tue, 10 Sep 2024 18:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726019729; x=1726624529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eMvk/O7eAPCOv1mMP8o+KkhjDZ2EnCpGJ2GRMSBEiQ=;
        b=IazZ/49AW9KJ07fnVqhdx1P9exhZYCT58kcWX276hE4TECvZvsmGbF4PM0sEK2g91T
         gg9uce3d+8YTCQ7EksnCsm2y6R/Aqbmmu8JHLSa8ra9iQm5WQtzPeWO6L9BusIxL0hTI
         Uyjy0liHrIaisQYtQIArKlm2Hzteql1jhzC9dH1kqkPobaXScclPzDvHKWoUOf1dfo+g
         PELtgiF5AfKK3MLin/4A/oAvS8vO6sA4wWXM1VTihAQfcM299w9LPpjEy5rdn5tkedEm
         9BT9NEc1SzZdhVV7mVJR12knUcCjAVuiU5iscs1ddjEVOHQ8fYJ8vSUc6h1aGPP4QCDm
         q5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726019729; x=1726624529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eMvk/O7eAPCOv1mMP8o+KkhjDZ2EnCpGJ2GRMSBEiQ=;
        b=i+h5eiAlQ1vL814ZGPLNAHlseP/WVs4ghXYpmCZYj+50vEv9FsK5kTGAEPEbG4VSVh
         rP1aG2JicX/JopK1sL4YQ7Sz8T0o3xA6Yd5NNgWDEz+x+pvJVHsgrmbKz8SHTEyUejbo
         VdHhbLxsAxh8RYhfk0vBGsjV2Bzk63fyCIe9lMPacTUUg6I9qUlxYY9Ee4cmZvAQ8n6u
         x+w8EvZXHp/MqmLMM9SiODEcWJVIHi2tYLIFzXskCiWhsi/4BUMnXbLkfQ3JoYVAttmF
         WYADzJPijGe59atx5wr2KVmP8aWR+bbWbjq+Wo8J0nR6z5AlrbpmXBg94DOY98Kbvr5j
         hSRA==
X-Forwarded-Encrypted: i=1; AJvYcCW8KNdsOQlKgB9YZSFW2/Z3xiyskNeXpJJcmwUH7ilLp4wmgqeHfWG2ffbsPlQOsfxnjYK1wukKlLI0XMMc@vger.kernel.org, AJvYcCWe4Bcjae7dw7MgHzeO09aG1FrRxdKgEEoImog4AOMl8JGpTASKt0oUDVWu5kKegMLO9NclGWsxSkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywith+6QQ81jgl/DzgOJn7GFCW1fC/2rHRkli+D8d51srNN3j7C
	h8DNnMBgVoVEQZKJ6Aul2ajj3wVCulPGwfara4DcRmIjxOayOOtN
X-Google-Smtp-Source: AGHT+IFMav+SiIWQSr/EKSXW8Qi/0IE0Jer5qrGzpap7wrxZT9TyB0UyNrcHPaRpf6qBdXupp/rYrw==
X-Received: by 2002:a17:90a:fe06:b0:2d8:859b:931c with SMTP id 98e67ed59e1d1-2dad50f3eddmr22934298a91.33.1726019728877;
        Tue, 10 Sep 2024 18:55:28 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04507cb1sm7084986a91.33.2024.09.10.18.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 18:55:28 -0700 (PDT)
Message-ID: <db636067-7995-48a9-9bf1-88f64389d701@gmail.com>
Date: Wed, 11 Sep 2024 09:55:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation/mm: Translate physical_memory.rst to
 Simplified Chinese
To: Jonathan Corbet <corbet@lwn.net>, jiang.kun2@zte.com.cn,
 alexs@kernel.org, siyanteng@loongson.cn, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn, Pengyu Zhang <zpenya1314@gmail.com>
References: <20240904112020232OieLhsFZ_M10gBxJtUieP@zte.com.cn>
 <87seu75gs6.fsf@trenco.lwn.net>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <87seu75gs6.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/11/24 5:40 AM, Jonathan Corbet wrote:
> <jiang.kun2@zte.com.cn> writes:
> 
>> From: Yaxin Wang <wang.yaxin@zte.com.cn>
>>
>> This patch translates the "physical_memory.rst" document into
>> Simplified Chinese to improve accessibility for Chinese-speaking
>> developers and users.
>>
>> The translation was done with attention to technical accuracy
>> and readability, ensuring that the document remains informative
>> and useful in its translated form.
>>
>> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
> 
> So I have a couple of simplified-Chinese translations (this one and
> 20240830133230.7988-1-zpenya1314@gmail.com) sitting in my queue, but I
> have no way to evaluate them for accuracy.  Is there anybody who can
> help to review these?
> 
I will take this one.

20240830133230.7988-1-zpenya1314@gmail.com, I asked the author to resend
his patch following the submit process. but didn't see the response..

Thanks


