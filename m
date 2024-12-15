Return-Path: <linux-kernel+bounces-446281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0359F2225
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B43165F9B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E232FC2C8;
	Sun, 15 Dec 2024 04:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HgF07gQ/"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB358F40
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734235614; cv=none; b=FyMggQXOvWtpY1D9oRugwEvIv0Odks0mmaipUEdKE1zg+P8kPUchOK3F3EXt3kY/RQalzhrgZvhdC5muclmdAe1/T/lP5n0pxr5PCOaQqcMs2xkEhgPknqh8/E4KHS2VKjkI3qzBx48OEjuzukcc/jtx3nexV/0R1C/U9BnwECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734235614; c=relaxed/simple;
	bh=Ay04HpLjmUaaTo2gJTtteen8NM9RRkH3i44zC+bEA8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsOLSwd7KbeRfy5gNlah6cngH95z5gu1L5ySMy+W8QfxbFdYAguUx4l5fRF+Kla6xmsACgwL0ZLxLIhgjmQn/ASLt9vEuA/xeDWWyX4nc8znYBFi9IvRvSlSsdvfERUkdpORCnGA1oYHNdkGfxCvVJfW3AIfh88QDzo2mmUWreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HgF07gQ/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e8522445dso612092466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734235610; x=1734840410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZvkSmrnw3tmKglFGmepEGzr8bFfHZm0FxzV8LFP20M=;
        b=HgF07gQ/mVy9E8OBgNtB/xjeqLcQ8UeGJAtwy20JNjb+2EIjzidKCAIU8IjrKK9cMZ
         Z0wKOttuW68OMhGo5vJJGqZ0Fbgrp5F3ofkEh0VMWlf7fJlHkfID7zV4iQn5cYXMC1jl
         oldFytquz/dhIKdD+0Kn9tHyku9o6cYezt+Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734235610; x=1734840410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZvkSmrnw3tmKglFGmepEGzr8bFfHZm0FxzV8LFP20M=;
        b=Ra6Pq7axVZuxs3kE5fX6Gz6Ev89UURwtYUKhqwHSKdhZ+rfBhO2IxqRKg9Mje4yQz2
         +i7uPeGu0zUJb50sAt9ut4/pnht3pkvjwB8ZlrIXROmtgDuxYue1+cLeuIVO0a1qat47
         faKjI6c6cBT+I+DPm2CU3hV22VlY6Q8q5c5Gk/s1/kAX5nG8GT8evXXQlpLlSdj+joOg
         Bq9EbGOqJkAkHCQtXSGzN2J+f7myCXcBQ/81iDcXqnqfXhSffdr4IBc//RL04r2Z8UH+
         tf1+i1tfOWIds3us16lzryJtLv9iJE6pe2G3LPJfKrBs9nNZZ8AFLtSNQcbD48IMRmWO
         HQcw==
X-Gm-Message-State: AOJu0YzW/lvfImCUl7fNGyAC84UemnzVwlwphPOCfomrYTta6mkBeVT0
	1ZXN+SQHCaRXb8K5E/fXYH6QnaYswQrGH77fvgn2k35UmPag16e0gunCVbcZfrkv3T3wxu0PcF4
	BKOg=
X-Gm-Gg: ASbGncsFtEnL14QxkkEBjtWq1LKd9X3rtKLOVgu7ZMyNL+VYQ0k4QdxFgv3HIiGSgpb
	aIHA3ra5ePpWHTbzWsRcN88c27sPQpyQoo0IQacPlxzUQbeEQo3cH1pLGAOGqJslq728vpdor7w
	DJLskHrBf4tWFmvaYYqpcKFvxS7Kpbk/OmnabaDPs/Yze+2cvUAkuKm3AZLm3MJBDDO5z9UwIiT
	6UEtwsTBdoCQ7a422wJAQJrvg/L4gV2hITrG+Wf3h0E7/NlqI3c/3ahf0duiryVrRNVt738yPsA
	ywAThaWYF336XOWpyC/Ljn4Muov6Dd4=
X-Google-Smtp-Source: AGHT+IFSGdb8vQDya7oDEyKpI+wXAc/w5M4iHnUAsUI2HPs5nm0ZXJSC581/CiF7ECLNwhLHZkMXww==
X-Received: by 2002:a17:906:314f:b0:aa6:92de:ddae with SMTP id a640c23a62f3a-aab779585d2mr689186866b.16.1734235610469;
        Sat, 14 Dec 2024 20:06:50 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963c5489sm165198966b.186.2024.12.14.20.06.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 20:06:48 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aab9e281bc0so138639566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:06:47 -0800 (PST)
X-Received: by 2002:a17:907:785a:b0:aa6:82e8:e896 with SMTP id
 a640c23a62f3a-aab76d0ac70mr631034966b.0.1734235607275; Sat, 14 Dec 2024
 20:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home> <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home> <20241214221212.38cc22c3@gandalf.local.home>
In-Reply-To: <20241214221212.38cc22c3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 20:06:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
Message-ID: <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 19:11, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> That is, even though:
>
>   TP_fast_assign(
>       __entry->ipv6 = ptr_to_ipv6;
>   )
>
>   TP_printk("ipv6=%pI6", __entry->ipv6)

Again, you're not talking about the code that is being fixed.

I'm complaining about the mess that you try to fix in commit
ff54c8dc3f7a ("tracing: Fix trace output when pointer hash is
disabled"), which is that eldritch horror called
trace_check_vprintf().

You are describing something entirely different: the admittedly
similarly named test_event_printk(), called from the event init code.

I think trace_check_vprintf() should be removed entirely.

And I think test_event_printk() could probably be expanded to handle
at least some cases of '%s' (because, as you say, pointers to various
static allocations are fine for it).

And no, I don't know the code all that well, so maybe I'm overlooking
something, but trace_check_vprintf() really is a horror. And all your
arguments for it seem to be missing the mark and are actually
arguments for test_event_printk().

               Linus

