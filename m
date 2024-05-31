Return-Path: <linux-kernel+bounces-196992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66A8D64AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4F21C23435
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A64D8C4;
	Fri, 31 May 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MvrDWyHF"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D257C8E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166463; cv=none; b=BOxgAuRXQ8rKOHBj28/5Hr6f5MdnlL2PVXD7CRK5gX0kxMGsg36JqwECD8u1omWRzSlACjyU3e23cIpwscv3yj3cGurjZa1eaQk1QySDGXcQnb2UEXb2doWpGJeqLafu8U0ExFmQIIp/16N/MsOQCZo3FVJ4UDpzHxl6KFp4AI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166463; c=relaxed/simple;
	bh=EA1snWN6KFF5x58Kt5WwrvhXqKcKC51UqvoEgW2mLYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUnyziPJhCJXSbK0LOXKopTAggDSP2bJ3J0rRvXrSc81akuwDeOS1N+vs0+LTl1XGyR0dGb1hkVmq5G0q8NuxONnicLBQRuIKX/d4xd4HIK7VwTEnG4SK6beHhf0AEvwVTg3fkDFnga75TOdlU8eyD3J6yaM2AguSZL5YKF5TRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MvrDWyHF; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e24aa659abso10499539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717166461; x=1717771261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SomH4SrINp7a9UmlUPOr1vNpjB9i9zy5D571kfh3Q3U=;
        b=MvrDWyHFpzDBF2dtBnEeWlWw0s2mB1nwQdvyPyym6tMbE1ffjMiRssvYzdk6O6rslw
         1W4ikXaxAiIkgJHEb3NZ3GiSDCV3CfS8i9MUJfKOPOYy+OzgaBvJdG1IaUeqGrIi1r1v
         rg6Q83dpvTs/69GSlGu6d8As/dYKLlUmP0Klo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166461; x=1717771261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SomH4SrINp7a9UmlUPOr1vNpjB9i9zy5D571kfh3Q3U=;
        b=CpGak9P1NvCvprVOI0Zva4Jzn42J8F7asDDugiofHQfnGqWcCDgt6H7p6F09HKA+ye
         b5nO1TBmtx45y7Aj9odJdc4fxFbb3zmwWEoya1KRceBN7vr6Vcn4Chp1XbtRK7ZdBH8x
         YLdjlu1UvO/8uWhZN7WL/peHanT3sPVhj7dkNm64LjZDuvn2H/XcjqCSI2f8SufUv6wl
         OkJ9liqrmqg2zaUUnhbx37U1ZqFlII0TTKXQR/OrQj4nSyRPwiqEiGhdawL96S5gLvyA
         Q/XSOrBhVdMAlb3Ks8bUv7iLpeMFIs6aZtAtMQzRDaZQJ9MQPfj14J5t6Zua5pb0/2q0
         HlfQ==
X-Gm-Message-State: AOJu0YwOt4J4LRgauy507uMcbUk7ldNq0TyUfEExSy+QtGVTEWVyESrP
	HRw7BQlG4la2O8/SbNEjsOk677ysT+3SxUGm5nR15fvyNUt3V3cUnxsJeWy07ZM=
X-Google-Smtp-Source: AGHT+IGsUGKjhnM1nomuA4q/rSCCqjBn03K1FeDVNYNScTmTrlQPUOkSjVi7mrCm63zBW4n0fHwJ+g==
X-Received: by 2002:a5d:8485:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7eaffdb5092mr236846439f.0.1717166461094;
        Fri, 31 May 2024 07:41:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48cd01333sm496174173.161.2024.05.31.07.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:41:00 -0700 (PDT)
Message-ID: <85472ab9-aa2e-4f5e-869d-5ab42e47c8a0@linuxfoundation.org>
Date: Fri, 31 May 2024 08:41:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/tracing: Fix to check the required syscall
 event
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <171714860864.198407.18416314586430149538.stgit@devnote2>
 <171714862700.198407.14000969067636098427.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <171714862700.198407.14000969067636098427.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 03:43, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since test_duplicates.tc depends on syscalls/sys_enter_openat event,
> it must add the event file to `requires`.
> Without this fix, the test fails if CONFIG_FTRACE_SYSCALLS=n.
> 
> Fixes: 297e1dcdca3d ("selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   .../ftrace/test.d/dynevent/test_duplicates.tc      |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> index d3a79da215c8..5f72abe6fa79 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> @@ -1,7 +1,7 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0
>   # description: Generic dynamic event - check if duplicate events are caught
> -# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
> +# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README events/syscalls/sys_enter_openat
>   
>   echo 0 > events/enable
>   
> 
> 

This change is already in mainline. I sent the fix up in my 6.10-rc1 pr?
The short log is a slightly different:

commit f6c3c83db1d939ebdb8c8922748ae647d8126d91
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Tue May 21 09:00:22 2024 +0900

     selftests/ftrace: Fix to check required event file
     
     The dynevent/test_duplicates.tc test case uses `syscalls/sys_enter_openat`
     event for defining eprobe on it. Since this `syscalls` events depend on
     CONFIG_FTRACE_SYSCALLS=y, if it is not set, the test will fail.
     
     Add the event file to `required` line so that the test will return
     `unsupported` result.
     
     Fixes: 297e1dcdca3d ("selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes")
     Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
     Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

