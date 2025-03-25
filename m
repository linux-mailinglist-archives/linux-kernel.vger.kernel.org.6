Return-Path: <linux-kernel+bounces-576290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE34A70D83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7165D171C71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC5D26A0B0;
	Tue, 25 Mar 2025 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vp3NWqvx"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF81E7C2D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944397; cv=none; b=mN+4qIZZHgGBC5THn/19T/LKryVnV8LQh3vIBTCF4v7Fi+ezRLnMoogSyzk869M6/kGb4e2bqBUglueryhAW2/jdmCw+yaG1W27aXebSVAiBKzZuh5mScwTAnP0I2ZyJHU9Yg1oaJxezqG60Q5tA+xcxfhxk0pW7jSR9laUH5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944397; c=relaxed/simple;
	bh=jw3maACCO3f6vt9Qr0IksUHDBNePsVPYv0eL53Q5Uko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTqLTUxc7BYbMDmvBEFiL+ELlwWfi8i3hyfky29lvo+0Dp7iQTD5iNbCMXMD5QyjtGKkk4L8HdiWeH9D0epjqPeHv+to+1abf/hXcbVTJpUfaKwQ6FAVp5s7APb/FTs3zbJzw33NK9lxPDX+nT1vqCriUKgj+Cz+kUPADuKxUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vp3NWqvx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso1034256366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742944394; x=1743549194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3h0xRoLxiN1v7pMNtH0qapseB+kIL16c87ibP89wiw=;
        b=Vp3NWqvxJQJH9Tqz976dYwrBJ39GbXgtXhwSyJ2zz/vWMGUeLKoY9fcNO1j+McPb+m
         1gjpiG/+WvLV24XPvsPyddGG5j561OTEwWD17PiTakIEVMrfZET6qRimMAAHan99zLfm
         3Hgni7fsta5LUT66hDBbL/uY+pnJAbVmtIocc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742944394; x=1743549194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3h0xRoLxiN1v7pMNtH0qapseB+kIL16c87ibP89wiw=;
        b=NWMvBcZKGfmU8hjMziBu5SOyy7g+s82/8yyxYrAs4oCwlw2t5dOQ7g6PxvuAnKhwot
         vrhFdv1VbrdxYMl93u4AeAAyRmDTHUTKAPgw8El30PmxrsKor92OJpeDTCH4N5WwGIBB
         PP7NMAY5WdmdUsABo7XFGs/8KC79Fir5c4pxBWmcDS66tUT19OUWCmTOHSB9eDONXDl4
         abYOOcA+6uQE6N8rf6gAXWHmhwE9uf4ZPsP/fmMiiQoiR7ZUDpFxvvjas8qdsV+OY4q0
         yFVBnEhTvArnDrTHtUI+I6FbfRfwbZP/rjrceGswb2gzCeOk9GIXfWHb4aKZDIzKMu+K
         /CXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs1wD4g4nvmsVjT31Y8TKPGK0CadY6v5fhuD/Ldt1M6rXN9Gd95HPZ7sCRny/7OFy9/HbwfqL6K7wBCMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6x4gsEJFGPdyBPZNMHaFvWjo4tD35rIGQVX8/awoj/D7I8cD
	SKaiO1eeWI7PXJRtVo7RfWpzy/1ECV/IC90vTZPRBHQh1pxIr5MoTDwa2o1XiJRvdTrI7GUMjIj
	xjoou/w==
X-Gm-Gg: ASbGncsExCdkgjAQxEcrvgDTOfQG8k7HjT8fdFUZXg3EwUo7zT8oT4pYVcncU43epak
	JNMJElcvF5vc/4smJ2zB1oOj8+Valuz2JUzVY6VWi6o2pSFBMMYydzjdS5WIglL0gh2eJfdi30W
	xE+dPRghZd0HmeOQWmxbuHSey7NFzOemG2MRSiYVLufrajaqWRnXH3deYA1yqgZzRPwaoDSBRN1
	HtAvQVCOqLrQuaoewMIIS/p+5jbhGLAblg2LylecpB1MX2T0LrhnznKJemuEhjQk8UAXiTN6EkE
	Ka7Oeyov0k2eMqD9ALRt/zAHtNQhBS6jcxtOAebFLc6x4Ivtov2rue1B4tbY9jkI/sDeNptkmaY
	Jo7BZW3qqT6+HfRyr28M=
X-Google-Smtp-Source: AGHT+IFdjbmYOxtQRVM1fSV2CsR7vZmMoWEEL2JZaOrvrl9mlqW4mp+aCpWDA+VmvK4qTb6DKKOtBw==
X-Received: by 2002:a17:907:7f24:b0:ac3:3cff:268 with SMTP id a640c23a62f3a-ac3f22b2c30mr1671702966b.30.1742944393836;
        Tue, 25 Mar 2025 16:13:13 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd163cesm915945766b.151.2025.03.25.16.13.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 16:13:12 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac34257295dso1274494166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:13:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+QRtSTwz7aiQyNCzWqjQGrvA53YAtd6u2QkYOaIWkdna+asc+NWjVjgl5noTWdHczt+y/zZ7lCjSJUJc=@vger.kernel.org
X-Received: by 2002:a17:907:9728:b0:ac3:26ff:11a0 with SMTP id
 a640c23a62f3a-ac3f251ac63mr2074660766b.38.1742944391848; Tue, 25 Mar 2025
 16:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317104257.3496611-2-mingo@kernel.org> <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net> <Z-J5UEFwM3gh6VXR@gmail.com>
 <Z-KRD3ODxT9f8Yjw@gmail.com> <20250325123625.GM36322@noisy.programming.kicks-ass.net>
 <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com> <Z-MxULQtc--KoKMW@gmail.com>
In-Reply-To: <Z-MxULQtc--KoKMW@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 16:12:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMu5iGZ2ifBqjzV4a993D13OnDvfbtYe6jgPP8cZnAGQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr72i2YXbGGJdC978hKkzVdmQ4LG3orQqVMCJwAlQF0vF7KbLFr4RRoHnc
Message-ID: <CAHk-=wjMu5iGZ2ifBqjzV4a993D13OnDvfbtYe6jgPP8cZnAGQ@mail.gmail.com>
Subject: Re: [PATCH] bug: Add the condition string to the CONFIG_DEBUG_BUGVERBOSE=y
 output
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 15:42, Ingo Molnar <mingo@kernel.org> wrote:
>
> So something like the patch below?
> [...]
> After:
>
>   WARNING: CPU: 0 PID: 0 at [ptr == 0 && 1] kernel/sched/core.c:8511 sched_init+0x20/0x410
>                             ^^^^^^^^^^^^^^^

Hmm. Is that the prettiest output ever? No. But it does seem workable,
and the patch is simple.

And I think the added condition string is useful, in that I often end
up looking up warnings that other people report and where the line
numbers have changed enough that it's not immediately obvious exactly
which warning it is. Not only does it disambiguate which warning it
is, it would probably often would obviate having to look it up
entirely because the warning message is now more useful.

So I think I like it. Let's see how it works in practice.

(I actually think the "CPU: 0 PID: 0" is likely the least useful part
of that warning string, and maybe *that* should be moved away and make
things a bit more legible, but I think that discussion might as well
be part of that "Let's see how it works")

            Linus

