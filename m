Return-Path: <linux-kernel+bounces-210770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64690487B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6459B1F230F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FB34A15;
	Wed, 12 Jun 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdO/Fv0E"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39363BF;
	Wed, 12 Jun 2024 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156186; cv=none; b=MtCet8Wki5kjz21XKNf6+gnl0bP7fA8L6zsJNpl35TLBgR0w1c199q+2vghn+fbICc7AqGK8dioD93gdr8PL91IqO/fjHoZKUY03NsCEyl8YCaXqP2GRXucODeou6L1j8+QFeBUOOF+OTwF9RVUGkddxd8TQi9Xs70qodQFl3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156186; c=relaxed/simple;
	bh=K6BKv4LjR1+g983yeFe0wOKlJGVHwpBlqXDjuG38I/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYsP8CkW3l+lIS9kGotR/EU8BWazXaR3wakWanx5E+j5R6t7iO9juVxIRwRIRFvWuWueXy0kKJsWj2QBme5LGj5zLOhKYc8k/PV+xNnhhGcGL7ED5B94dnNK9bXTEENaejnhiZnrr6mE4caiFLzT9pFRTbq/NAahdjsUWXtat2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdO/Fv0E; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6fada63a6so27648765ad.3;
        Tue, 11 Jun 2024 18:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718156183; x=1718760983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzozW17kq7wTzk1ggk4+JCXlo/GoqamN6TK/nxUtA8A=;
        b=DdO/Fv0EAvOXdSExaNCjEuGot+1AWuw6EuZhRZgmT7t9evXQ4N43vSZyakSbgqnGu/
         3lK5DYEsVY1vlVgJC8Mh8phgipUUmDJ5m6XfoeXfi1MIQ5x7fVdfI+88J71FYJIC+H1x
         EXbhPR0TV9o2AO4NnKAOlox6SRzDyC5nQ+9Ya1oOUN1aHjBPrJbwt10oUIPBnJNHaoQR
         wdWumpCIqtB3qegYBtMp0btA3nUQvJjENF2l3PeaJsH2lVd9U8OtcigqNAAON/K5UfGa
         KIHe9gBMcsZIC63y2qUPrGqCgH0uC+pxtm6Xlo+9vtKK+CkJkDnOk3Mc/iqYv9qJm+Ca
         c8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718156183; x=1718760983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzozW17kq7wTzk1ggk4+JCXlo/GoqamN6TK/nxUtA8A=;
        b=lzdTL8Kq7QivmeVSAsFt0f9rvFBvK5aUE7pcdwp1UJhJxlmccXuXp9eFKW58jJGO3v
         gy/+bJzIKBtsQD9U3jfFSo1Nbs1W2zVbNi5yU1UBmstomWTcw4vy1XMsE9MrYnpK67wZ
         4yDIfxM8BkIGLBcAFKQF3NAYnwr4BUsw27E+wN1YKZ2WIpqgsXucEDEPTJWMiM1JYj/n
         z5XpOAN0+0kAtUuPZGcogWsRmFKozrThuyThI3/ElLxBclq46eXuV3qUCgi5EPvdNWZ6
         EcHIA4czRsuRYRTeyZ+RXjXD0eU7wUQ65oc3hWZ263OoDzJUoh5VPFb89ci3SbU/pbRs
         WEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeUCz9o3z30KQbriJKzIrqXmRrQ4isDKI6j5y1zD9sbithgI364Jlte5TdbxuyeWM2DsteJ+2BbJ0vxrxD7UG+H5llHgs8A+V8Mb6R69/VlvrTkY+9Zwz6FZwv9U07A0zCrDpplIBI
X-Gm-Message-State: AOJu0YycOb2fBE5WisJNuEgDINKOp86EHQOCVRyfTe6AIRLTdYp3YF9H
	rdKH+9WWUlOdtpoY23dAmc/7OZLTWn6gMIVXowU1adA/pqwpvl3Z
X-Google-Smtp-Source: AGHT+IF6kcxVfe2CgnQ4I5h1Z43glCxZSpNlQiyocYEfsPAz5meXYHfzh2e3NSne7y82gtXwCtnIrw==
X-Received: by 2002:a17:903:1c9:b0:1f7:908:964a with SMTP id d9443c01a7336-1f83b56a77emr5329605ad.2.1718156183485;
        Tue, 11 Jun 2024 18:36:23 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76cf28sm109892745ad.97.2024.06.11.18.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 18:36:23 -0700 (PDT)
Message-ID: <5961a584-dbb5-40e7-8e25-69eb7aefcdb1@gmail.com>
Date: Wed, 12 Jun 2024 09:36:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: Update the translation of
 dev-tools/testing-overview
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Hu Haowen <2023002089@link.tyut.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240611044358.25689-1-dzm91@hust.edu.cn>
 <1c3c4698-c70f-4b04-ae96-a83c3b9bbc4d@gmail.com>
 <CAD-N9QXY8frJmxp+LWM9g2_8UdubzMushMEPGyM9Z-UFEHfN3A@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAD-N9QXY8frJmxp+LWM9g2_8UdubzMushMEPGyM9Z-UFEHfN3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/11/24 2:50 PM, Dongliang Mu wrote:
> On Tue, Jun 11, 2024 at 2:36 PM Alex Shi <seakeel@gmail.com> wrote:
>>
>>
>>
>> On 6/11/24 12:43 PM, Dongliang Mu wrote:
>>> Update to commit 42fb9cfd5b18 ("Documentation: dev-tools:
>>> Add link to RV docs")
>>>
>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>> ---
>>>  Documentation/translations/zh_CN/dev-tools/testing-overview.rst | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>> index c91f9b60f9f1..d89d0ec1d4cc 100644
>>> --- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>> +++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>> @@ -99,6 +99,8 @@ Documentation/dev-tools/kcov.rst 是能够构建在内核之中，用于在每
>>>    参阅 Documentation/dev-tools/kfence.rst
>>>  * lockdep是一个锁定正确性检测器。参阅
>>>    Documentation/locking/lockdep-design.rst
>>> +* Runtime Verification (RV) 支持检查给定子系统的特定行为。参阅
>>
>> Why not translate the words 'Runtime Verification' here?
> 
> If you translate it into "动态确认", this sounds like a very general term.
> So I keep the original English.

Runtime is often translated as '运行时', so could be ‘运行时确认’

> 
>>
>> Thanks!
>> Alex
>>> +  Documentation/trace/rv/runtime-verification.rst。
>>>  * 除此以外，在内核中还有一些其它的调试工具，大多数能在
>>>    lib/Kconfig.debug 中找到。
>>>
>>

