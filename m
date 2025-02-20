Return-Path: <linux-kernel+bounces-524674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A932A3E5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B891A1896765
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF702116F4;
	Thu, 20 Feb 2025 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsJ392q/"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F61DDC14
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082743; cv=none; b=gLARz5a9tXtluNw5CAk8wc1SLune5Roe5rwlyoAh1rxzLv7QWSVnlwZ1d7FNA55+PfXBCy3cC+WPU8jy4HYK4PBwB+gZcyeXlnlp886pkAULfA7WExkjULSqVWyPaveoXq9gp38tB6Te9txQNAEUlNo38AO8B9Cbm11ZjtZW5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082743; c=relaxed/simple;
	bh=ufNNg2rNOkDICBHFg0h+S6poNghZSgivhHBZkJrRIyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXqBRsge3IR7TFAjq+1q8ZJmq6sU3/ncfEPnnhalTL5SPRP7nUEaDCKMrIGr7sIgJ+dI0kdXBJGG1VQFlfnexVQl0aFIk9xw/Z5SAdNEZM2Rto0Vvvu7wCI2/YrrE0Tq/mOBkQolW2ipM0RyN7P+6mhMr7pPwJhJe8fClaWdetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsJ392q/; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso4392435ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740082740; x=1740687540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/Ezzc0bR8B+p/byl9E3hgmtjeFWLzb0FMiOjqIXu3M=;
        b=HsJ392q/wkvDvLQmauQAj8II+0R2/QAaYU27Crjm/FAnRmhN1cW1bI+7iMGZOgSnJz
         HDH2HupVeUndve4vs45NEbAOrLG2iRQEnYWZPwdCUWtvTaeLpZPBW8efug5CFFh29/2s
         J9mOMu2vKMts9wrnk8t1TwTk2YBAWAM7Nij9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082740; x=1740687540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/Ezzc0bR8B+p/byl9E3hgmtjeFWLzb0FMiOjqIXu3M=;
        b=S9UYkAmLkpqL5HFnXX20muBgdd0fFtUdGirEJAtxGmhXxcwHaf95enDuncLlkD/vjA
         qrlb3CjPdipyUjIDEoGARejkwKGMfQPi22xTNfggYEI2Yuc//oO8mcR0c4pzr3EVRFqU
         YFjcBl7WPo/a1iYQ01+f65J8s16P0XkF/fCxyP/t68RXsJ7ZEGkNupPW1868xMYlvI4T
         iiIm2PEPittI3o/gMrVzzX6fQWghOlgmw/W3+YPTlXxd4dgg6tR4rFdZ/JR2i4pU/3Np
         mxLpxgYSa4JQuq5EghQi4DYs13jH2EeRFlQjvuiqhIPVKgWv2nKhkwNoFBqBdKWLua0w
         5B5A==
X-Forwarded-Encrypted: i=1; AJvYcCUxosxDcm63HARQb5QqncSF9yHQArWraqahXDYSleIOukppt+ycHvm/ETAeivOBm9pfhf0ZpaAAlLzbkxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOkBQQviki75dE+2bGlPLhRiZ1PnI2gK4DnpZtoi9AmIfgvhHq
	odvaFIwkct78lhmRWCnZatxxvjGtZkeuHYUmejPgelmiwHJ6X7sszWu5xeZ7uCU=
X-Gm-Gg: ASbGncslhbIWDdzjR9GsW50bABhy8I7IH9tkQk+dbqY+oprHr9+6KsnY5+Gi/DkQRjv
	e7ivFGtRtmwZquPrRHm22WABKhne6fA0efnqguhluUb4O6vqQyks5gIXdLfvNQ9OoBtcZq9MExL
	tCHoHXk1m8m3LdgZU4GAp3us988EUP8C5+l3wncloKpLevBnx4eW+A+2XmkGx4ca/2g5p509P2m
	zbYhuyMjPTzNIA9DBUIV1Dpi3c1rolbmiTrzKuVm4oyE1hwZl/OE4YS7f2cEIGFQMzyF0Mv7ifE
	KS90IHv1yTF9P8pKJU+hQWrx0w==
X-Google-Smtp-Source: AGHT+IF79ckeVt665lYdXJU7VJLqlE8Q15fFZXr1QkP6ouOQoPFieWVNlE/ofs7NRQPHbTbqq2wz5Q==
X-Received: by 2002:a05:6e02:378c:b0:3d0:d0d:db8e with SMTP id e9e14a558f8ab-3d2cae49deemr4900315ab.1.1740082740482;
        Thu, 20 Feb 2025 12:19:00 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea680c803sm1719151173.14.2025.02.20.12.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:18:59 -0800 (PST)
Message-ID: <16def228-662d-4db5-bb1f-7d79c4ed3ae6@linuxfoundation.org>
Date: Thu, 20 Feb 2025 13:18:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH 0/3] selftests/tracing: Test only toplevel README
 file not the instances
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20250220185759.811830333@goodmis.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250220185759.811830333@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 11:57, Steven Rostedt wrote:
> Allow some more tests to run in instances. There's a few tests that
> require something in README to be present to run. But currently README
> can't be used for instance tests. Fix that and then allow 4 more tests
> to run in instances.
> 
> [ RESEND to include selftest maintainers and lists:
>    original: https://lore.kernel.org/linux-trace-kernel/20250116012009.840870709@goodmis.org/ ]
> 
> 
> Steven Rostedt (3):
>        selftests/tracing: Test only toplevel README file not the instances
>        selftests/ftrace: Clean up triggers after setting them
>        selftests/tracing: Allow some more tests to run in instances
> 
> ----
>   tools/testing/selftests/ftrace/test.d/functions                   | 8 +++++++-
>   .../test.d/trigger/inter-event/trigger-action-hist-xfail.tc       | 1 +
>   .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc    | 3 +++
>   .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc    | 3 +++
>   .../selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc   | 1 +
>   5 files changed, 15 insertions(+), 1 deletion(-)

Thanks - applied for Linux 6.15-rc1

thanks,
-- Shuah

