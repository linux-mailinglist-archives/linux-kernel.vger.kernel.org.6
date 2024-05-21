Return-Path: <linux-kernel+bounces-185135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66038CB101
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE91C21470
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5820143C58;
	Tue, 21 May 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SYaiRjdA"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC90143C46
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304208; cv=none; b=QXTBF8+FQhNKSsU//U7K3jbSx96G4SoNDpxTi3x4D5cKCUv5dvUbXLHkg/r5We5Kb5gj4l8or2fvRH/sJTv+XUWNVyZSu3HTbF4cwsKexawXmgTUQizqlOgFUSTEFblsHl5Tl3JZrc3ps+hX2Bdu0kerq6Ll01InjnTnBuksTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304208; c=relaxed/simple;
	bh=/5a3h4M20FUoYZhlXVbMuNxjpi38FtVo4tnwNlycoEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg4VBbsoolPdT9ttMwyYEWJJaTHiFONLD4FJdnUpxHz6jsfIZ7At+Ob+H9Rhv+MCQyq56af32uII9JGZgWItRABsSPIQMDks5AB4YZaonB+7k9QXvZ7oilWZFz9VyRKx+hJkIyuiQM8g0uM+WAr2uxnsakqc60sZpysGPngXcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SYaiRjdA; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36daacdbf21so1475795ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716304206; x=1716909006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZPbXhzIjF9CTIYlsze2Xc3NxTWVq0EkO8P78eNK6Zw=;
        b=SYaiRjdAwVfXv+VGpEa/G6bRcjZkcTFFpUKGcKeW+aO1l52sv5wN+ouxjmEEbAn8ik
         9pIIC0dEKf8OuNH3JoMp+wX/QqExrRRnC7pkzFQjQbsSeKVqNE/ZXXlrwON7M2MIXobu
         bRbLSMOkLlKRjzSkCSyPhHIzbHDazY+3AN1gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716304206; x=1716909006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZPbXhzIjF9CTIYlsze2Xc3NxTWVq0EkO8P78eNK6Zw=;
        b=alJ8yPLJzYoXd0DP137GPMXfU3np5Mag4omPuz5ggntnIhMFL3kkehV0wSjw+h2huU
         0qqz6/+whqpA8Isls7JgUFn34+YI32WjxB4fs7+ihwbD3eEJyTZmENdAQoeTRjjAe6lj
         iSlGXb6JmYX8FZersUptP4+p2PdqiHuQ13kA2vf3Dy8bvr9x/tPqS14hRGpYPp8BXEJ2
         taIbg5g+vSMfBFVgIRjrS+tq11lTHL/GPWK4iS/QOfMR8cs7M7CfaY+HwxWANYZ+8+/K
         QGwUkycCkBtFDGwj/gvVnpkQbKecuywBpPyvxK0t7abVwy1lL9Qjq49uir+FoGE1y5rw
         yg+A==
X-Gm-Message-State: AOJu0Yz7m9qkpDGUDIoI6IVvYBoA5NZqXGqpBSoRWPLhMQmQStOWcIVd
	oJpBOoDY+vHlUfPtyjtDLfijtPT20O2TtTr4ys/6gqkA6yuoJ/3+lC4rWW+6qYk=
X-Google-Smtp-Source: AGHT+IESEt4nFF0aT8EhBUwdWsXz0bCKQ0ruhojcanJcimk1/Ix+PO0KtmO3gxLFKazgT5fxv/vXPQ==
X-Received: by 2002:a6b:d203:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e1b5022577mr3286292639f.0.1716304205729;
        Tue, 21 May 2024 08:10:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-48937141644sm7017385173.69.2024.05.21.08.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:10:05 -0700 (PDT)
Message-ID: <2d65388d-753f-423d-9682-60b00fb66879@linuxfoundation.org>
Date: Tue, 21 May 2024 09:10:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/selftests: Fix kprobe event name test for .isra.
 functions
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <shuahkhan@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240520205737.5085e53a@gandalf.local.home>
 <20240521104919.c8fd7a91b4a9c0435d17017b@kernel.org>
 <20240520215148.287e417f@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240520215148.287e417f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 19:51, Steven Rostedt wrote:
> On Tue, 21 May 2024 10:49:19 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>>> It is listed twice. This causes the attached kprobe to it to fail which in
>>> turn fails the test. Instead of just picking the function function that is
>>> found in available_filter_functions, pick the first one that is listed
>>> only once in available_filter_functions.
>>>    
>>
>> Looks good to me.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
> 
> Thanks Masami,
> 
> Shuah, can you take this through your tree?

Yes. I will take this though mine.

thanks,
-- Shuah


