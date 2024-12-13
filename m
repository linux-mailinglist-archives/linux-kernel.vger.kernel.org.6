Return-Path: <linux-kernel+bounces-445092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7D59F1127
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEB01629DC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADF1E2615;
	Fri, 13 Dec 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="NNkeFDJn"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895504A21
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104375; cv=none; b=lIEj3VXTYqBbpIyHj18DF72xWJsvP1sKCtt6cTvvWacgcoYOd9/6BctYUX+syiG6EUYZ8vTFgEmHeD5/bgyYwIpGWgwBpWVtDsk9UMkQtduB9W7LMVS1r5pC9s14DK0Bs2/JGxQ7ZChVJe3WMgTY2XPQwsxYcwnc+qq4gPRztZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104375; c=relaxed/simple;
	bh=RKihFC9YBEW/ETrAIEfAv4cIBxUfGxP80u59/IRxwjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASxQn7lDT97wH+YTJEsxggMKDa3ZFZLydUMI2T+y9ltrhzLTgvC+60RFxvwGXKc3SpxnCQomq7tDibRTRpNQn25YSUB+4L/WCFsdj8aehXsxXTTKK0a+qnUrUpAABT2nxmhfXo8G078DrVd3VnxDtYh3N3x37NR+q3Qja01qWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=NNkeFDJn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso256375266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1734104370; x=1734709170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwxYLXf0PWa/uwRl+LJ/8BH5+5LxmjtZLGszhfw4jPw=;
        b=NNkeFDJnI62OiFoEUMw6tO5PQF14Dc/E+MDEiG9KgzaCpc2FiiGRf2X8fe5AfR6RZh
         SCEZNNPLPojNBF/nw1ugESqxsbqZKmBcHAzxkkTHImMZ5fZt07iKR3ZZ3iKQq2/vrtnD
         E/BcDJ6Rju9ZEgOv1G33R3dPPGWQYELGal7PN1YDqImc+cIpJb349FSCpm8tYJASxZnP
         ZsjP/nDDMNa9R/fbv26eDH4HUQCU+8D7o7lqdO7/yXxKX7p/WfYTGzGxPreyxM9SQ7gB
         tFO//JYSFl1cbxSzj/dcQi+fr6r0EErGx22fVWz49JgZ3IUNWytYfADag8VgYjBibz8P
         /duA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734104370; x=1734709170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwxYLXf0PWa/uwRl+LJ/8BH5+5LxmjtZLGszhfw4jPw=;
        b=Czk52GsEjNXuZz2SFrPZEQakB73UqZPSn0KKNlzg5Xx6G2ybzFtD785puw0SQwbtoJ
         5pKfrVi8teYnN6diL4FKuqGdIohwKYhCBqDrKGgt+9xKnvpbX5D1AIMDWQRPL0kVpBYf
         TXI+Q833+jiBWrDRmSVJ8s9bk8/FP5wpgzCJfTsZysIHT46lgzKmYEJSugvQqy/yAl8x
         c/OMvSIr536/mplxqo7ePvrQyaIRF4wIRYEBsDGf+Tcf8wYqVFI+iDfDiAIhw6pJ+XQP
         i0a12B9B73/ILLmc6QESV9C6mAxCpWOiClYOnH1FnL4eDL8tE7f/M0iiMLgHuwnNEEf2
         ELpg==
X-Forwarded-Encrypted: i=1; AJvYcCU2wJ1w0ztADACgcizvmOpsHl2BehfvfZqOMCyajerZWEJzuw23y23R1tSOg/WSg5ylGRlMxt0xTImagzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAV7RFNGnmlTq+IOx6C5oZM5EjZVfiYqoxVEW28UpbvZD/jLj
	cYwCrN5QyUye5uyRZInXOSdhZbuLdx9ZsUyv5pLUSwFKy9uvPMjDAUhHr5wDKQ==
X-Gm-Gg: ASbGnctJEjDCmmkcWzbn8aLazg67kcbRyzgzbMv/wL3GlRocpRLAqbuVAVypPdqqxDM
	wV+OybmCI5HorYYc5E5q3U3gFA0z+HqoEf5Mf/W+iaswzSHxxDyxkL3/DUeIzgGelBFln8ZDPjg
	rjhq2pgnaYtgSa6CMfm1f+PmRIzNojgiaiHaVkvyTPlgwZpxKFAUzwCLM2WgcXa+dAeHPEgdRsD
	0YMWXCUe4Rr2Mq9k+N02nhI8cZIIAGtJqIXqg7pFJCCns+jp/SiQ0RwoLz6LI1ybkwJ70ZN
X-Google-Smtp-Source: AGHT+IGm+yIILF+7POv81tG+6AeVT8Ga597rPhWh9PCW0pqqVYpGTrJOQzJiXvocErL5vRRNA0L92w==
X-Received: by 2002:a17:907:781a:b0:aa6:730c:acb with SMTP id a640c23a62f3a-aab778c1ddamr269905266b.8.1734104370412;
        Fri, 13 Dec 2024 07:39:30 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6975b1f27sm622855466b.113.2024.12.13.07.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:39:29 -0800 (PST)
Message-ID: <eb7933ae-3462-49de-b76d-16ca652d714e@monstr.eu>
Date: Fri, 13 Dec 2024 16:39:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [for-linus][PATCH 3/3] ftrace/microblaze: Do not find
 "true_parent" for return address
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>
References: <20241213152647.904822987@goodmis.org>
 <20241213152704.448212590@goodmis.org>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20241213152704.448212590@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/24 16:26, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When function tracing and function graph tracing are both enabled (in
> different instances) 

What does this mean different instances? Two processes or two cores?


the "parent" of some of the function tracing events
> is "return_to_handler" which is the trampoline used by function graph
> tracing. To fix this, ftrace_get_true_parent_ip() was introduced that
> returns the "true" parent ip instead of the trampoline.
> 
> To do this, the ftrace_regs_get_stack_pointer() is used, which uses
> kernel_stack_pointer(). The problem is that microblaze does not implement
> kerenl_stack_pointer() so when function graph tracing is enabled, the
> build fails.
> 
> Modify the #ifdef check to the code around ftrace_get_true_parent_ip() to
> include !defined(CONFIG_MICROBLAZE) which will default it to just return
> the parent ip passed in, which may still be the ip of the function garph

here is typo.

> trampoline.
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> Cc: Michal Simek <monstr@monstr.eu>
> Link: https://lore.kernel.org/20241211153634.69c75afa@batman.local.home
> Fixes: 60b1f578b578 ("ftrace: Get the true parent ip for function tracer")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/trace/trace_functions.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 74c353164ca1..a75d107a45f8 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
>   	tracing_reset_online_cpus(&tr->array_buffer);
>   }
>   
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +/* Microblaze currently doesn't implement kernel_stack_pointer() */

Does it mean that this function should depends on ARCH_HAS_CURRENT_STACK_POINTER 
instead of name the architecture?


> +#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && !defined(CONFIG_MICROBLAZE)
>   static __always_inline unsigned long
>   function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
>   {

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs


