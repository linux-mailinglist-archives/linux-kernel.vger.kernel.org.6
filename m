Return-Path: <linux-kernel+bounces-182754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63918C8F53
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 04:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65288282913
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E92523A;
	Sat, 18 May 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HsbFmIDj"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C071A2C10
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715998347; cv=none; b=c4V6DpGcw0wVdL57fp9RAOza2GNTRAtI4Lf505EDmCKVkFkZSUpQYosB0IEEmS9OggzdBf1ym7u9PoYuaq5mPicA+fkthQzeddzKLuUxUiFgvV39qauxFxxB7d0jNSivZMcNcZY/2jBwfkTS3wDaayT+vVYUOw5jlE58RhTz0JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715998347; c=relaxed/simple;
	bh=wEqb3ugYw+MxkHvbeVUBC21UpY7oQkGhMAEKRg+APOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmFN5Gy4g5iAlItPrVE9rDHT9677BLWNLHq1pMVW85rAV/RCPvrjIhQi/WpCoBubNnaVg3daVbsZgeccV9qnbLeFdgfLtZSWKcESgEdvhoX0rWc4GomitTjCWS156G1MHRAF4a6ZOsPzDmNsCIFRXd4HFLZz53Vrh8VwwVtQfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HsbFmIDj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so1490958e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715998342; x=1716603142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah/WS4n5Wflso/zVaZ6tliH5iboXt1JXQylb9EYjTRw=;
        b=HsbFmIDjWZhxtEVMtQlITMspW18X1rWH0msqU0dNI6tBYHYGdRg8jmewH1/mJjGzhi
         /OiadTzVD6eZiFS1jUwEiHpS7jMWalCzbH8hsFC+DT//0Ahu59TRzpudJBkbfV8Ph55/
         gjfKp4MFF2uXiD/vAQpFG+EzFwveCisPDNhT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715998342; x=1716603142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ah/WS4n5Wflso/zVaZ6tliH5iboXt1JXQylb9EYjTRw=;
        b=YXF+HYyVj+qkSg+Z5q6aYz+M8es6DFuGC3ip44j/XJu4WuCYSn8n54LcfdOntlWDNU
         wCT6BpLOwIn+nDpWhsbodlhVLsDXvChs3tCqdaHjcCG5waYH/sQjpYlEdRGit8nonCMU
         MXwxrBxwED4goPhOAPwQiEKPM3Lh0voQccMAc4ZV1JMgoI6+2dXjJKAYw2pIkbipZCQ8
         FJyT9isML9z0vageeNR4m53NYbKJ0h+jxJYzkYorpyXIdIA3PNczLsRfUa4+NxdKDIeu
         +D2aTkSmUUTEeBuLW1CWW/saipN42/IiHLF9BQm6q9FkNwEfcikrbPTCqz7V9+XYvh7h
         51+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDiZYxxFqRo8dsiQRjr3sHzob/DHDsmCf6xg2agIsbjMvxSBm8mTQ27remz/PeqaY6UOG/CpSoKXH4+O9E5ZJ8u9GS69clSc1DqTgK
X-Gm-Message-State: AOJu0YxuGzvNz4mqmQewzfZ9d1neU2uteEKYO+rRbv/KVQfKRlFA5fLb
	CXk1QGsBOiqxU4tydDnSLT87D8BVpgZhqsLkExbAlIs1tcCOaJ0+uWA7+n+cc3yuTW2+a2iTVK5
	T5/EKCQ==
X-Google-Smtp-Source: AGHT+IEENP/98w4OYOeOebjOAh6VPrxXYG23yjw1mFABMq+72XdPlELgQ2PqCAvJ8Y+/LqsgHFHA8w==
X-Received: by 2002:ac2:4193:0:b0:521:e967:4e77 with SMTP id 2adb3069b0e04-5220fc7c267mr18808720e87.28.1715998342402;
        Fri, 17 May 2024 19:12:22 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-573413b2ac3sm12266858a12.38.2024.05.17.19.12.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 19:12:21 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso490453366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:12:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM3O0oBq27W3+z02yw6Q88yGc8cpXPUuPLK7DzTO9rdHziIGrgwYNtux4Pcc1faWl1Q0YF1MCkHV/bAb+oN+r5cEByjymG9ikBSbZP
X-Received: by 2002:a17:906:684a:b0:a59:a64d:c5b9 with SMTP id
 a640c23a62f3a-a5a2d67635fmr2183610966b.76.1715998341117; Fri, 17 May 2024
 19:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
In-Reply-To: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 May 2024 19:12:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ_MNipb2fOSDmXJ9tYko8OhzA0fPueR-kh6eYT_MbDg@mail.gmail.com>
Message-ID: <CAHk-=wgQ_MNipb2fOSDmXJ9tYko8OhzA0fPueR-kh6eYT_MbDg@mail.gmail.com>
Subject: Re: [GIT PULL] probes updates for v6.10
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Jonathan Haslam <jonathan.haslam@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Ye Bin <yebin10@huawei.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 17:52, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Probes updates for v6.10:

Grr,

This doesn't even build right.

Yes, it builds cleanly in an allmoconfig build, which is what I did
before I pushed out.

But after pushing out, I notice that it doesn't build in more limited
configurations and with clang, because:

> Stephen Brennan (1):
>       kprobe/ftrace: bail out if ftrace was killed

This is no longer valid C code, and hasn't been for a long long while:

    void kprobe_ftrace_kill()
    {
        kprobe_ftrace_disabled = true;
    }

we require proper prototypes, not some ancient per-ANSI K&R syntax.

It turns out that gcc apparently still accepts these things, but it
really shouldn't. But with a clang build, you get a big error:

    kernel/kprobes.c:1140:24: error: a function declaration without a
prototype is deprecated in all versions of C
[-Werror,-Wstrict-prototypes]

and the reason it didn't get noticed in -next is that this commit had
apparently not *been* in linux-next.

Dammit, that's now how any of this is supposed to work.

Why was this untested crap sent to me?

              Linus

