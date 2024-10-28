Return-Path: <linux-kernel+bounces-384039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF599B2385
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8361F21D49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D018732E;
	Mon, 28 Oct 2024 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CLOlYape"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888217C22A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730085902; cv=none; b=NRjik0UXXOPq/p4PDm4xiGhtQzMuhbGagVsOJ2yCObaaRJ0v8zs4ZgGaw69I1UwEvS+SMkAX9p6kCSORjeT5aB/Su9X/zrEC8nqUEDxfySZloBWKWZlj8Bvb5czXDZ3z11dedpBTyYArwMNGJ3tDyPd1x0P4KQsS/88vw6PyqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730085902; c=relaxed/simple;
	bh=BgAxH7BuovLSb/VyMg+CeBt7AY44ASR1oxeFqo3yo44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kExa6orpYwBPHbnYxOyCJ+QUhr59uUEaYKJC1yAfVBaBcaup/Z8oUwKX3U6QbfKmoIgg7rMw7iETothY0Mu4CMcBotQ5kZUMrmHcoqzujQ1NDoK5ryQiE5fuHtCaDRxS2nk8QvNVB/dstQbd8XLFyPY0sd7oThjTnpPfBnDyXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CLOlYape; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2890f273296so1612314fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730085900; x=1730690700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQps+ZocWxrGBOwCyIh53YeKrI3fc0l3GGoMpgWYcYE=;
        b=CLOlYapeHgS7qupjvOvjXCSufM9OGk4V80iE3+Lgxny41pwpLnlauhIJgGQpzbIgTA
         dLpWDwOwQS7GOjFmZagsxLJaFf71R9eW3yeY7VGXnNeBOjes6Sz266bzPib7nI9UtXv7
         Um302kJ9X+BN8eNXMRMqwktxlY900lh7BT+lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730085900; x=1730690700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQps+ZocWxrGBOwCyIh53YeKrI3fc0l3GGoMpgWYcYE=;
        b=Vai52xseLQGEdMzxyIqtXNL6t5T7RoQ4Be9mA1Y0sP1Sm9gLQhIz62LsehbG0IsQiw
         5N6lFpX87fOa1eJQyqs7BSUmPaYPTkcWrwUD5gcq0uINo44JdwJLe0B+KAQATZLXPRbr
         JxrqwRFn83qWL62AHSsZJq3qN8xI8tXQ9KNalY9UMLAV7HyIgNcfmzzpkcMxDuQlpXY0
         sw8FqbmLKAzgIQBJMh3+3EsPzZ4cq0LWTyd/hexhKprxNe0+cxhV/XouEg+dzWe8rE5E
         6erKjw90OSbOVsf/j/TlWdF+cW4niCkW/87L8y97fYrRUcz66UzvXbr2/IeM4xz0V1ds
         n6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCW27mV5eff/NCPZEBtH0P3URoKcEODJvhPbac2JOJ2AgbuTPyU2omQah0hNsEpCbBki+h+FmUYTXAtQncg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+HypvVNEwejlzi6E1xqO5Tu8bjQ9RViA2QrIeiw7xHA3Fbpl
	GXLEoc9tc4beQ9H1XRgi5Bp2iuwlt6YM8H14I5CHJN5s1fjaYODMPB5hiKUZDb8=
X-Google-Smtp-Source: AGHT+IGE75zSHhwyyDDQtRp4FgDHkbHA5Xo/zZuHaCPkdqAGRqL3DWjJapnemFbOWTvX+FJ/kTXKiA==
X-Received: by 2002:a05:6870:32d2:b0:286:f2cc:7a71 with SMTP id 586e51a60fabf-29051d705b0mr4868242fac.32.1730085899683;
        Sun, 27 Oct 2024 20:24:59 -0700 (PDT)
Received: from [10.200.3.216] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8661061sm4781718a12.17.2024.10.27.20.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 20:24:59 -0700 (PDT)
Message-ID: <5d87c8ba-8464-4d9c-9152-611097b5ae3e@linuxfoundation.org>
Date: Sun, 27 Oct 2024 21:24:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Removed unnecessary initialization of "ret"
To: MottiKumar Babu <mottikumarbabu@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 anupnewsmail@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20241027211913.26718-2-mottikumarbabu@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241027211913.26718-2-mottikumarbabu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/24 15:18, MottiKumar Babu wrote:
> The initialization of ret to 0 was redundant since ret is set to meaningful values later in the function. This change simplifies the code and avoids confusion about its initial state.
> 
> The issue was reported by Coverity Scan.
> 
> Report:
> CID 1633338 Unused value - An assigned value that is never used may represent unnecessary computation, an incorrect algorithm, or possibly the need for cleanup or refactoring.
> In register_ftrace_graph: A value assigned to a variable is never used. (CWE-563)
> 
> 

Check submitting patches document for how to write short log and change logs.

> Signed-off-by: MottiKumar Babu <mottikumarbabu@gmail.com>
> ---
>   kernel/trace/fgraph.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 69e226a48daa..b13ab2ad0e88 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1249,7 +1249,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>   {
>   	static bool fgraph_initialized;
>   	int command = 0;
> -	int ret = 0;
> +	int ret;
>   	int i = -1;
>   
>   	guard(mutex)(&ftrace_lock);

It makes sense to initialize ret - i think you might see a warning about
ret being not initialized before use. I don't see much value in saving
unnecessary computation.

thanks,
-- Shuah


