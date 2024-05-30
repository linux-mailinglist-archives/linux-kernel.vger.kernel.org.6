Return-Path: <linux-kernel+bounces-195315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206838D4AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A391F233A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1B817276E;
	Thu, 30 May 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz9+MCiz"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B1183964;
	Thu, 30 May 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717069552; cv=none; b=bYJI3P3Vr9nRSWyVshY/Qn2APdGV+UJkiSez0eSZIrnNCVTJ2dCOME/u/f8dBwC/cBJPjTgLf4rzvOIph/aTE41I49cTCFg4FZ735DWbGD8EdJ2WvZlyF/LX/VwT+P7oecy1k8C2vlzKvCFHvrU4kOOcGX4Sz3ORYg5Jh70ILmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717069552; c=relaxed/simple;
	bh=sX4RJy4YoFPq1EwjTgAPQQ0l9jpIrZkiHp4K0YDIK7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abcY6KOZsBCjv8aQNTHGJg6jGkcykwmpho1kiMLo0Ibx8yuzU2i/3HB2Ww8JAVzKCXiO2y0zmufWLS4izdFH3TEUUj8d7fdoeLgDPgMSAnNskTy1YuDoHJcBnSg0o9CMAt99AtrU0yNW2EnGB+qot+KbTowriRub++FjRSM0ad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz9+MCiz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-68197edc2d3so622593a12.2;
        Thu, 30 May 2024 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717069550; x=1717674350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dt6lbse5R4B5MkccKBRXCeSKahpc61vxjuJbAqOgTYY=;
        b=Nz9+MCizaHelNPr9/4r265Y+l2Kywg1MriAAneoSj+BS/7/IHBrNPkZiQ4E/3Lz/Tp
         IyLFzwElRUoS8wq6h7EnHVu3TXPyEJ300SmTm3VeFnIYxTdqX6i3pFZglj9yND+x5tyD
         LBvKfvlMw4RHTbSvzOkrvAYxPZ2EtqZytuZUrpQARtaqgyBVcwmjvsXQ/KsyZcysemyK
         n++dO623unZWXdpeW/7oLSR4iZA5I/ZhPFU5MDlGHQ9U4YqBC6icCBXywposkKiwJeYn
         YI+vbdOT6L7yJs/m9XK53HLmkMQwR8rK4ws99zYArKiS+F4V2Zm/QZmR9i1V/XVW5Csd
         aCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717069550; x=1717674350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt6lbse5R4B5MkccKBRXCeSKahpc61vxjuJbAqOgTYY=;
        b=qa0CrkTlUVi/FwbQvQ961Wrt9/dNVuDRysybCB8Za1HvhNzVkfr9lNgc9//io+Fnbh
         dqnpzoSHrIpuX0ocUvp5uLZQ2CYNNbtH0OkV5w5W1F5vR414vBPS3wypGk5ggYTqMx76
         UHFgwVm9e/HineukqCc8FlqpKrj+8Z9JiXPiQPxCtQ/QF/GuPvDOa5fCvWkQyH4pVt82
         wGPNYy6Vl+wFC6vpprGYKIIeU/nJzlujY+Fid7Vk7C0pclFtU8VB/SipZ4M94PiqR3Iu
         ZN/m4kpQQKNvZJF8dC2GoiHsxx8En9wnD36M5uZ7WkLMFIMEB1d1M5cLnQga+U+OIrKu
         R6jw==
X-Forwarded-Encrypted: i=1; AJvYcCVU9mayggPNWaRlN0d6OdrqpcbrfbR/kIKIW4vllrJ3ic10c74BAE4bmkQ4c3YgrI8IkmhkZXvMDP6KFz+u9OaJdwhfzWIsVcSwIT/NX4OYm5zqbgvdcpqxKjrGInDpyXfs+E6xmtPeONinkGPqEltRbwFx4Lky5WjPi0lZC/XbUDih
X-Gm-Message-State: AOJu0Yy42u3g7mgtP9ri8x5pE8wEvDmaB4QsmttPGw/eeYfBITH+6yi4
	TDiPpxnSqSO1pRG8vbouuAk9RtYczOEr2TZ/CAQHi/EmIY3JChZf
X-Google-Smtp-Source: AGHT+IFprFj2EtA/cGtVlylQzuJQE1K6E83+32v7QgNJ6Q6uC7jejf6yvmpaSuKNZMUBiSgUm93iDg==
X-Received: by 2002:a17:90a:4586:b0:2c1:961c:790 with SMTP id 98e67ed59e1d1-2c1abc42ffamr1732303a91.30.1717069550185;
        Thu, 30 May 2024 04:45:50 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a777f7cdsm1372393a91.25.2024.05.30.04.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 04:45:49 -0700 (PDT)
Message-ID: <00b9c76f-0beb-46e9-9a0a-5b8e304b2759@gmail.com>
Date: Thu, 30 May 2024 20:45:45 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: cve Korean translation
To: Austin Kim <austindh.kim@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
 Jinwoo Park <pmnxis@gmail.com>, shjy180909@gmail.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20240527102313.27966-1-yskelg@gmail.com>
 <CADLLry53yZ6PZ7X8DwdS=GGp6+6L0tbAkb+hiL-Eth4FZ+ZTNw@mail.gmail.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <CADLLry53yZ6PZ7X8DwdS=GGp6+6L0tbAkb+hiL-Eth4FZ+ZTNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/30/24 12:46 오후, Austin Kim wrote:
> Hello,
> 
> 2024년 5월 27일 (월) 오후 7:24, <yskelg@gmail.com>님이 작성:
>>
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> This is a Documentation/process/cve korean version.
>>
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>> ---
>>  .../translations/ko_KR/process/cve.rst        | 107 ++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>  create mode 100644 Documentation/translations/ko_KR/process/cve.rst
>>
>> diff --git a/Documentation/translations/ko_KR/process/cve.rst b/Documentation/translations/ko_KR/process/cve.rst
>> new file mode 100644
>> index 000000000000..94610c177f17
>> --- /dev/null
>> +++ b/Documentation/translations/ko_KR/process/cve.rst
>> @@ -0,0 +1,107 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +:Original: Documentation/process/cve.rst
>> +:Translator: Yunseong Kim <yskelg@gmail.com>
>> +
>> +==========
>> +CVE 항목들
>> +==========
>> +
> [...]
>> +
>> +잘못된 CVE 항목들
>> +=================
>> +
>> +특정 배포판에서 변경된 사항 적용한 배포판은 더 이상 kernel.org 지원 릴리스가
>> +아닌 커널 버전을 지원합니다. 때문에 Linux 배포판에서만 지원되는 Linux 커널에서
>> +보안 문제가 발견되는 경우 Linux 커널 CVE 팀에서 CVE를 할당할 수 없습니다.
>> +변경된 사항을 적용한 특정 Linux 배포판 자체에 요청해야 합니다.
> 
> It is a little bit hard to understand the above section describing
> 'Invalid CVEs'.
> Please refer to the following sentences if you consider revision of this page.

Thank you for your document review Austin!

I'll take your suggestions and incorporate them into the next patch.

Warm Regards,
Yunseong Kim

> ---
> 유효하지 않은 CVE 항목들
> 
> 보안 이슈가 특정 배포판에서 확인되면 특정 배포판에 변경 사항이 적용됩니다.
> 이 변경 사항이 kernel.org에 적용되지 않으면, Linux 커널 CVE 팀에서 CVE를 할당할 수 없습니다.
> 대신 변경된 사항이 적용된 특정 Linux 배포판 자체에 요청해야 합니다.
> ---
> 
> Thanks for dedication, everybody knows that it is challenging
> to carry out translation work.
> 
> BR,
> Austin Kim
> 
>> +
> [...]
>> +않은 일부 변경 사항이 관련성이 있을 수 있다고 가정합니다.
>> --
>> 2.34.1
>>

