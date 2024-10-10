Return-Path: <linux-kernel+bounces-360093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655C99945E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C701C214B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D321E2858;
	Thu, 10 Oct 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a3AkH2dR"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B61CDFD4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595462; cv=none; b=dDL574uBGZ3vuHTysEi3L8AcTz9uDMRX0S+gxAr+zqkyefnyqkPIpUidXHYngG5QC9fgkMKCoeHrPn/excwc2wv1fZUbZ2ISWO/TVqbcUB10XVl2FI4IHGoiRrBRFqgo4gPhw2H7aGYDqCmaBgqcbKI5mrwlG91U9hrAWJH+g4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595462; c=relaxed/simple;
	bh=IvXBq22p6qcwQpaq5eTge6FDXANkdgf7r8d8TkHkgHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp00FYabFBO4eaElbQ/y+NHI4qsUxVocErxSewsMTCVLtqBhnktp3vmekWNxufVoGNmnAfoYiZD/9OmQyRUYOJEbHhHZvPoAT4Zf14my8oKihwlg75yrValbnxHV55/zX4d9e4fA6k+nuPRSlXWOlB1mdQy4hkmOqul+I2dn8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a3AkH2dR; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-832525e7449so82002939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728595459; x=1729200259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnFmO+JO0vAHh3WQGgxd4V2TgjaB2XL1XQA6JbK9oG4=;
        b=a3AkH2dRu5bBnfgc1V8oAhte1wIURt1DzWv5DLVaj0VHLi18xY1OAqOJFYVHTsFzp4
         RiCGH8ZmxHJMKslrf727pIFtVI6vGy5ziIoydridCa6qMvMLsjT6uodrHYCEa10hlZ9n
         8cx28NejJZDLqdU2StoKIjiUTDWvnELyenrPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728595459; x=1729200259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnFmO+JO0vAHh3WQGgxd4V2TgjaB2XL1XQA6JbK9oG4=;
        b=Scr8hC1zNyGUCA3+Wm1pE7YmqqqkEl1v9agaP0cLauQ6WAJmYsxpr0qjrDPWeW9xwD
         ry/a6YaA5Udl41C+4kmZd9ne7QB7xhBrhT8ZqR6EBGRxQBDcM4q7ylWUlKuA5b/cSJUJ
         ibMGYmBJg3u5Ug9sum6gBQb0vwoMFWd9uw86HFPsChCTSMYJPzIFFbN1uqwGP3JZ+SgZ
         PUh0grHJrmro8IFz3YbsSKXH6CRRgvre4Jcc/M/F4ht4cV3oMcxlIHiRuKcGtKqRrNCB
         HWyLUxOOVonCKPuc5rIHbC9aVfDfsH6cuWFxJ6E1jgWf8/Zs6rRUfa161GNNlU8eOuUE
         i0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXNleVkG8h4aiiRyZVWed1FbcYucM1iMUkSWeuIOtTVUje7ie82sHXLeKSwC/NAp3Ihg3xvNvvAWY+yj6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YznR1kYXumaA6SAaLHQXS4YSC0Zu1YjT5/+dK8WI22A9jdWnEEX
	m0gHRXurG7UhBhsDxsujTVRifm6/PLNAE+WjaDeZxWTATbCCk6nj/1hflBrLcx7Uycnh8+4dAes
	2
X-Google-Smtp-Source: AGHT+IGd8YjULQ5BgNmgPudrci6pRddPv1aAy6Zho1lX9ktZjptVS9rb0mbIN/F9nZopayfpk8di4Q==
X-Received: by 2002:a92:ca4c:0:b0:3a2:aed1:1285 with SMTP id e9e14a558f8ab-3a3b5c7bd20mr4241855ab.0.1728595459638;
        Thu, 10 Oct 2024 14:24:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadaa8cb2sm387245173.123.2024.10.10.14.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 14:24:19 -0700 (PDT)
Message-ID: <0ba33212-d38d-42f1-9864-010e1802a7ac@linuxfoundation.org>
Date: Thu, 10 Oct 2024 15:24:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241010165235.35122877@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241010165235.35122877@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 14:52, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Masami reported a bug when running function graph tracing then the
> function profiler. The following commands would cause a kernel crash:
> 
>    # cd /sys/kernel/tracing/
>    # echo function_graph > current_tracer
>    # echo 1 > function_profile_enabled
> 
> In that order. Create a test to test this two to make sure this does not
> come back as a regression.
> 
> Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v2: https://lore.kernel.org/20241004145618.18436d7e@gandalf.local.home
> 
> - Fixed grammar of comment
> 

Thank you. Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah


