Return-Path: <linux-kernel+bounces-449777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8398D9F55FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8612E1891677
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92691F8666;
	Tue, 17 Dec 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gwZpeegf"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086581F9A8E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459607; cv=none; b=JOu6rjKMKUJLXpeRLPyrjodo8lj2Qsgi+45Blh/N+Y0Eo1NXX1Y4GeI7uudZKDCRwW38V/WZj/gKz8x1BdtzHUv/uy9zswUUQCu1LXdS+ukSFlV1dE04qpr9LBBHVxpXATZhwU66+Fa7lD/hXe7dNktbs7NSt+8TEC3DrvPS6UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459607; c=relaxed/simple;
	bh=l2yRZ36y2wW9dvgVix4csSbmNDAJNiwmbO6uhLXvPm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oe7lPlSvxG/aPXPf3widSRNK6mDNyeV6fsG4wNvC1B7IUaF0KnSEb7YdPpfolFflBMxsTE5qWyjN3QB3N3x9TZNW40clObYMLRxEHDeRSOIfyhKxQT6IJd29S+lJG+lHMt1TC67fQ/DAGd2K3+ar2YcGyBpld2L6w+yztfwmQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gwZpeegf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa692211331so1047715966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734459603; x=1735064403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ucYQz3pug45wlWkI5/rqDm7d8VUZXMh7k+KyEWxY/qg=;
        b=gwZpeegftA6CLxCNKk6lELmJnEBdX7H0jBk3hTlM/xKpnJoPjRh8yXN8EJVfSkoTJe
         XEYSi5lpQATtNFixduQzjm0OEYIoi/uL6+yyoian5p1se7HwSMNKhXLUSs8b7yGx3d/l
         m2Ol7orgx6b3jqjdJ6mTRoniwGd03rCPRthMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459603; x=1735064403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucYQz3pug45wlWkI5/rqDm7d8VUZXMh7k+KyEWxY/qg=;
        b=qdMA9AMmElmOAX3dm7cbXosgROQvIgP3kIKZetDS5Bd1BRsEa9guEQkFAVfvmY8ssg
         h2yHLjIOYcPO4dm1YriJnQv6IRecoZz+Elv8PSgilrNY229Sjoyb0/vqZXpYS/Xhcfvq
         dN2+68cWyH6MReMA9827mDVYSlxx/uis6rMkA3RJiA5w8xP46OEOvuUiJGBmuwTXMdf9
         wEM3Z6H1IdP7RvnEtYZHWj4+3pAZ2lhcHnFQSk+10QMN+hB7Etfpw7nYMxpVtFJ8Kxne
         +VTDIuqZUVRRyFP8kbwm79zJvUmjkWKsRbVaPp+oJuUZ6FPaF9S1KDCW7aNP5vIJVLpR
         gFwg==
X-Gm-Message-State: AOJu0YyIr+o9+xSCpuv9vx0u2UfEb570bIBapQoDtKd+z4wg37hu+oa3
	EVferaeJi1aSqHYmMWK8xYbk/SAecrsP8QkMXIwYj3N54MXJ/nhjQbNtrn8PEgbvPJW5jO0N3Ie
	1gSI=
X-Gm-Gg: ASbGncvL8Dl/TtdaVEW+TcSzHkbj8BBAnHZ9t+Qux2yktgsc+WQR3hjD5g1uH08Tfbi
	H/bbEB3Z3wds4B3BrogF+Te4R8lzwjNM33Vp5dijM7ho0Dpjw9AzxVaoyE4HcrLsZgGvOElyiPp
	GJYsktS8OVVFsgdDvzIbNsO5B9NY3XYiFt5Bo+edMhUYbxjBlrqxAjaV5greHWqgxV6S9zjRkmo
	nYAvSxwLZyceP4jzqmh+sHRH7e1PWtt7tuSerTP/YuGWPkjDwR9lT/SqsEDAFDUGE9SIOsAljP8
	dx041FTiPVLCY/ouHrBFMUPoJxpfAEw=
X-Google-Smtp-Source: AGHT+IGA4Cd7zrEFIw1uvH0ywtje4sA8hLNMDh86knGF2usgbJ95fiWES+8hn3U2Gj+srf3Ujsvz2Q==
X-Received: by 2002:a17:907:d8e:b0:aa6:8764:8738 with SMTP id a640c23a62f3a-aabdc963abdmr414296566b.23.1734459603147;
        Tue, 17 Dec 2024 10:20:03 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9606b3a0sm466235166b.81.2024.12.17.10.20.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:20:02 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa679ad4265so1215444466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:20:02 -0800 (PST)
X-Received: by 2002:a17:907:d1c:b0:aa6:7ff9:d248 with SMTP id
 a640c23a62f3a-aabdc88c2bcmr443639066b.8.1734459601680; Tue, 17 Dec 2024
 10:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com> <20241217130454.5bb593e8@gandalf.local.home>
In-Reply-To: <20241217130454.5bb593e8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 10:19:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
Message-ID: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 10:04, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm not sure what you mean. If the kernels are the same, then the pointers
> should also be the same, as KASLR just shifts them. This no longer uses
> module code. It only traces core kernel code which should always have the
> same offsets.

 (a) the shifting is what caused problems with you having to hack
round the format string and %pS.

 (b) the data addresses are more than shifted, so that "data_delta" is
*completely* bogus

 (c) neither of them are AT ALL valid for modules regardless

Stop using the delta fields. They are broken. Even for the same
kernel. It's literally a "I made sh*t up and it sometimes works"
situation.

That "sometimes works" is not how we do kernel development. Stop it.

What *woiuld* have been an acceptable model is to actually modify the
boot-time buffers in place, using actual real heuristics that look at
whether a pointer was IN THE CODE SECTION OR THE STATIC DATA section
of the previous boot.

But you never did that. All this delta code has always been complete
and utter garbage, and complete hacks.

Remove it.

Then, if at some point you can do it *right* (see above), maybe you
can try to re-introduce it. But the current delta code is pure and
utter garbage and needs to die. No more of this "hacking shit up to
make it sometimes work".

             Linus

