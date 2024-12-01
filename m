Return-Path: <linux-kernel+bounces-426730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8272A9DF711
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E5328187C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901D51D8A08;
	Sun,  1 Dec 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ClVM0sNK"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9915A8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733084628; cv=none; b=kigLodbmtUcyPwhipsED9B6/OFF2pkRR2GXWfVW/j7j+L8D82y8bTeb/epSZt9cF82Q4ZXxOS3rFLRQILNBBkPT8YcOyaId8eryRh8vPmFOE7UjsHaO+IS/CpJNktGyzIyOyGn5fvtPyTvYehYAJ+ytPKhAY2Gx8wh8x4lRmkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733084628; c=relaxed/simple;
	bh=4xGNzN9Wp70Q9GgcCs1b92wuOYHLnPfSc5E75h7FS04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgD4JS1NPSicO5B9mzheCr9dEZfCL47B9HrW9vT6J2cFaJWL/YhvOlz1SFnTRiJhZnfHweF6gGbxR5jbTo6VGHCkNG61wHQTXlcID5TRjEGqJ/MEI1pwocIJ24HHXbe3QHQq0G7rd+S66LdfSIx4Qsewb71iSjshKGgkMRiqcMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ClVM0sNK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso599066266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 12:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733084625; x=1733689425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N0PBRuUNrVMG3jWkuVgZ+alnShpvbiX+xpV3R8jGwMw=;
        b=ClVM0sNKSDnknCjA3+6BriVdMXCWvq/v6OkJMNg9JoNcL3X79C/ftYQ+14DJC1mx4U
         qfO2kxc3bDTVWRzi+RWEn/hQZ5rWx7eutN9cMxZakQNRaX3DjIWuPZURlz7NoPbEsCCX
         KdLh53i/Ex5q2TVXjCLcKiwnCHPBXrRDWqDes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733084625; x=1733689425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0PBRuUNrVMG3jWkuVgZ+alnShpvbiX+xpV3R8jGwMw=;
        b=GGT3Sy/ZzS9p2W4zgHiFF8OO8fbyYOW2hVRwBp09rLW6c87WhwfVb/duQEQzx/o6xo
         7k6bHgKHYihGm99nUFhlT9KCZfH8NglTEZaKBhrsbwlqutvdkLxVoSmYePJb35Z+2AiH
         2sBDjz0vIbujrQU4t7jGO3L4XuYydqQQyJUbrxYSduoothPmIHkPHug5GaYIat2VwbUS
         i6U1P3sZq6O1mm82XZceGGqdWCPr/Tkfpqu8XpO9RabMAlOkUkmYRHycL5lTVgpzbLUg
         nv6sJ0Viegt3dNDFn9GcTowh8yHzRi2tawawX/rX07g9wuYhPIBPdOKwMYYGriNcv51P
         Y1mg==
X-Forwarded-Encrypted: i=1; AJvYcCXpjrKiK5vF16CAe2La7Y7IBAbWBXh21SjX2FYYodjyGZojM+NCasn3uFXEH8o1KI2iyGhkRRoqiDm8iRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuevEoahDmm5MknVNU19cxrPE5Edq6pLA67TeiylOMj9XbYjJj
	YaYoB+JmyNap3B++FrkmYhSX2+3vG+mXK0T5J41kOsi3JU9ycxJW/1puV/OsbSr3LnXNtx2DKrL
	X8K4TEw==
X-Gm-Gg: ASbGncu4o56TEnPA8SiREAd22mkpYqYi3P/kS+PIDlm7El6rXVzARTTeLJjwaro31lL
	cU/fvunvvtzKl9vFeZ1RQDWBTIg2M8kj4T5gfHajuXwvRnGcPb+4GzgNjxZ2lpLEX69jlgMjfHl
	SnSEJgS04Zw2zOEjJGRMOnv4ANEsbMpV6gTqGwTxw1ANxzTzaVQwHxhKl/CS1fq9xRF22lpNC+w
	0j6EgV88K4BEtdwRP0L9gbMmbcscrTCLsRbydcry9H1IrFZvryub7S/N3SsFWId205qtMIJHhVM
	zsz78iPU3+tFqdZQtZNUv28R
X-Google-Smtp-Source: AGHT+IFU9E4QNZ8kKafTOXYbZDQkprApFKtAwRDXC7N3krZzjerD2Ehf9fGtYtruhKUr0zHkfHxxrg==
X-Received: by 2002:a17:907:8713:b0:aa5:da4:3c0a with SMTP id a640c23a62f3a-aa581066ba7mr1437745766b.59.1733084624777;
        Sun, 01 Dec 2024 12:23:44 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d40desm429702966b.82.2024.12.01.12.23.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 12:23:43 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa54adcb894so480652266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 12:23:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdMmFi9/sEGdqSu/KUrWlF0+mc2UWxWrA7lxoyXxoc+S2HpZePBt4GV3QXkqLJbE8LOoFVa11uJ+I2tAE=@vger.kernel.org
X-Received: by 2002:a17:906:3090:b0:aa5:1585:ef33 with SMTP id
 a640c23a62f3a-aa580f1ae0emr1684398666b.23.1733084623092; Sun, 01 Dec 2024
 12:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130044909.work.541-kees@kernel.org> <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
In-Reply-To: <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Dec 2024 12:23:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGWbU-MpmrXnHdqey5kDkyXnPxQ-ZsGVGBkZQ5d5g0mw@mail.gmail.com>
Message-ID: <CAHk-=wiGWbU-MpmrXnHdqey5kDkyXnPxQ-ZsGVGBkZQ5d5g0mw@mail.gmail.com>
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Yu <yu.c.chen@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 23:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yes, we could make the word-at-a-time case also know about masking
> the last word, but it's kind of annoying and depends on byte ordering.

Actually, it turned out to be really trivial to do. It does depend on
byte order, but not in a very complex way.

Also, doing the memory accesses with READ_ONCE() might be good for
clarity, but it makes gcc have conniptions and makes the code
generation noticeably worse.

I'm not sure why, but gcc stops doing address generation in the memory
instruction for volatile accesses. I've seen that before, but
completely forgot about how odd the code generation becomes.

This actually generates quite good code - apart from the later
'memset()' by strscpy_pad().  Kind of sad, since the word-at-a-time
code by 'strscpy()' actually handles comm[] really well (the buffer is
a nice multiple of the word length), and extending it to padding would
be trivial.

The whole sized_strscpy_pad() macro is in fact all kinds of stupid. It does

        __wrote = sized_strscpy(__dst, __src, __count);
        if (__wrote >= 0 && __wrote < __count)

and that '__wrote' name is actively misleading, and the "__wrote <
__count" test is pointless.

The underlying sized_strscpy() function doesn't return how many
characters it wrote, it returns the length of the resulting string (or
error if it truncated it), so the return value is *always* smaller
than __count.

That's the whole point of the function, after all.

Oh well. I'll just commit my strscpy() improvement as a fix.

And I'll think about how to do the "pad" version better too. Just because.

                Linus

