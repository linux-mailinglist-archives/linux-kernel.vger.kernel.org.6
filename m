Return-Path: <linux-kernel+bounces-430409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99AE9E3097
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1217FB2577D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B279D0;
	Wed,  4 Dec 2024 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O21RvWsB"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B32500DE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733274070; cv=none; b=K/qAIytQo39BrQoHO+LtzISsM21CfqD8HaxQuPKEfgpoz1Hsd8CQ69u3S9igfQvGHcsUc2gra1bKCvAqSu4cKsDMh6WyfrBx8IsHUnCOXvLnFlF/5yxoM5NppRGcFp1ynQUd7hRp5hKVqgVaygW9gXCQkI8p74uyQFkKMSio5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733274070; c=relaxed/simple;
	bh=+PnW8Rx8QB0eXrlBZgoHpq6Fxpv9sFiJp0O5DS2PCTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3gIF6wwPnEc0cG87bjeHFj2ZrBGwIxDeLjuQasi58TOQIOITVUmFpPnkBmf+rp1T+cH9PHw9JPQfkLQN3FTHX9r7FuBJ3e7oXxRr92uzKYvvphm67VlAyVHBvzQwZBMvV/3U8dE+APmLNMe05yrSasrqnjdPorHO4eDHdp+F/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O21RvWsB; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a77562332aso22221535ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 17:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733274068; x=1733878868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NA+ElRETJKY5CqdJTdKRnj5fYbwfNKrJQ8Yc5F8bfeI=;
        b=O21RvWsBnhtQ/WVgO05CT5EXVUCJcnWaxDuH6WVNl3DuOEKN+579/pYgVGyzXLP50L
         0s2pMeoDAuJjzWa92LlUslWOUPz6dng5QjgDF0CPgKUutLekMwR3woO3VydXbYZzO+r0
         OS6/tvfn0D4ilchWmRBKaYDpxrPgfIILMNlA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733274068; x=1733878868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NA+ElRETJKY5CqdJTdKRnj5fYbwfNKrJQ8Yc5F8bfeI=;
        b=bKvWM6Hoeiy+fdhqC9nmvHlhm7ZKRN04Y3xOeTgQvKTnuX+aeG6YrlEobK1hCZtcTv
         5o/rUITe3LRvS1fsAzsmNuNJQz1gv7jPTbVpMTXVbing0ySCsecXnHrmJ5xVoqkxhk7N
         +wjeSbQMKblAt0o7hI2gBUB+0Zf7epOfaimaoPTA2jWlzTvEFwOnQfnWCwYDdUbWLWNa
         myFtw3vvYvF7Aq7jcWEsiWylWyAd2mJNoAhP6Lq3V327VtP8FF0W/aiqK3ZUirLg1nOZ
         jFwpSa83RyGOlU64WDuvZRnePFXDc+wXGzN+uOen/5mSJhegZnT3VjEsxGvjMKg6/aG4
         2v0g==
X-Forwarded-Encrypted: i=1; AJvYcCUZTK5kGWT3uOYkFXiEY3q8fv8X1xv0Xomjo666b+l1X8sge64CIG04cmLbWdMJcvC9EIaDEXZG8ymNc9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mVdMBJE6kzqFnsAsSYWnCAeEYC964UDJCHDBo/t+FhSTtFSY
	rNeAxXYgI1YTnBInj7bP3QWwTBrQLPqgpIY1n8lAELSJFo+2AkKk7dwp+Z/sNa8=
X-Gm-Gg: ASbGncv+cK22eMqBMC7NnRiXsHKIyeMp4rlXj9/D0T6+mgW/gkmBjgDjKtk5nBwTH3x
	Wl4Dcx5T174EZzaJT8KWXb2QpX35yYC/ou9Jq2uv9AAgO34GY17fC3074IQ/TVuFf2byvqdHLG9
	O+00zI/2QtSfOw5xhi0Bqdz+EWzSJ7yneUif2tY56G6wSGfjvvtE3HI064GRVvTDw5DB8LJ7uEy
	N6saQup15J4lM5UP3hNiDhL8aih3qjEIiItfCBE4b6NdBqAtfa3wQJj8MPfOw==
X-Google-Smtp-Source: AGHT+IFa+Bd2NpYOHu6EHzfrniiaLxPU/ePwfT0m1+/YTPvjeHG3Isi7m4kg/5QlpdI+LxP5aHV9sA==
X-Received: by 2002:a05:6e02:164f:b0:3a6:ac4e:264a with SMTP id e9e14a558f8ab-3a7f9a46431mr58360885ab.10.1733274067594;
        Tue, 03 Dec 2024 17:01:07 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e779e8sm2783394173.137.2024.12.03.17.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:01:06 -0800 (PST)
Message-ID: <fa1e747f-1823-4d20-86c0-b85a3b959952@linuxfoundation.org>
Date: Tue, 3 Dec 2024 18:01:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/ftrace: adjust offset for kprobe syntax
 error test
To: Steven Rostedt <rostedt@goodmis.org>,
 Hari Bathini <hbathini@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Naveen N. Rao" <naveen@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241129202621.721159-1-hbathini@linux.ibm.com>
 <20241202144111.75d1bb3b@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241202144111.75d1bb3b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 12:41, Steven Rostedt wrote:
> On Sat, 30 Nov 2024 01:56:21 +0530
> Hari Bathini <hbathini@linux.ibm.com> wrote:
> 
>> In 'NOFENTRY_ARGS' test case for syntax check, any offset X of
>> `vfs_read+X` except function entry offset (0) fits the criterion,
>> even if that offset is not at instruction boundary, as the parser
>> comes before probing. But with "ENDBR64" instruction on x86, offset
>> 4 is treated as function entry. So, X can't be 4 as well. Thus, 8
>> was used as offset for the test case. On 64-bit powerpc though, any
>> offset <= 16 can be considered function entry depending on build
>> configuration (see arch_kprobe_on_func_entry() for implementation
>> details). So, use `vfs_read+20` to accommodate that scenario too.
>>
>> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Can you take this through your tree?

Yes I can take it. I do have question about whether this is
a fix - sounds like it is from the change log.

Clearly stating that it is a fix will help so it can be picked
up for stables.

thanks,
-- Shuah

