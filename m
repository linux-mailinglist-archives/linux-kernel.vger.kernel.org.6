Return-Path: <linux-kernel+bounces-256872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC52C9371A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3263A1F21A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEB117C9;
	Fri, 19 Jul 2024 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QKXyMBpK"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76E1362
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350212; cv=none; b=bIWB/qCoXWZh+FIaPNc9/mVPsykWUEA5b3JMXW4fXqSPptEEHeqtnSOX772HKul18jUzKBEiP9niF96x/nhzwnEFWVPRR2iqKicye7PqXRRrGprY6lS3zaoICzKo8YKrmXhjhHNO+QZ4AfxkGTHDaeNWWY628wlRqpi/wUA24C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350212; c=relaxed/simple;
	bh=1/ZxoNBOp/rkxbDJ5E2xbV1LwhZHfhltUhVrThMbr+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+pn1IC1WJZvah25H8qEQdpe1R1MGdnjy8gjsJCJD5vdptQLTdYfozEF0r6PZMXOAYh27kgFNl3OmzWPqHn41AThtWcdXvYZu31eVuag3ulp8HHpJ9izCHh7WsOiirKyBqOAw1JMTr/W3irWhyVlEtYUrhbtL+3gtM+12VoEQfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QKXyMBpK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77e392f59fso147817366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721350208; x=1721955008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SawMcA6RKHaxSNJ9k+ogFeE6vFf+HJgntyc4ehNjbu4=;
        b=QKXyMBpK6XQCJONlq7/Jq3828Y1HjI8uaVcPIjvey+xNB1P26Ej/jOEPeRXAh3Aepd
         CpGKL7tCPlCq9BMAJkAHricyz3AvyE11DV201HsY0UQ+rtPYA0XkKrqJiSfpcJJmhgiD
         tmGWoNxT3OlRlX3Bpt/UBiLQ3prJ8CYp9xs1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350208; x=1721955008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SawMcA6RKHaxSNJ9k+ogFeE6vFf+HJgntyc4ehNjbu4=;
        b=T6aHj0tJTAph2R+xIxZqklNmvF0DSJxzCQ5J0Vr33zZdDesRvN9JHP6vEL9W/Ix6IO
         fr6JafhtN1VIy6goTfEdYse4feysHRf3u4iRUtcHDdPjGW3O/x9uL/hh9Cy5HxEGjNQp
         rpoMR8YLWr/cygzxcmIdAMciecakkx6j3A6mRuOG/yTrSw/i0bML34rPOJGkpAEG42jV
         oc63TeaNAflVM3FlviEmjFi3Bo9Ij2+nBQZ54w4vn420XkWoMTv1G/I49x9YWf02Pbid
         ua7ST/ZEgDgJprbxW2zi8QVZ2DK0fgbyRuFUr5rb1oXDMRiAcIJ4vd3+Xj3p1zGbOTiJ
         kjCw==
X-Forwarded-Encrypted: i=1; AJvYcCVZl3Fc8tFLFQtVOJ+Nt5KiWXt5aYFhBnPcdBRKJo4U8gjKSn5Qo4JLEvxHEf/t0OAMyg2y+2fKJiCcmcjrsYFEFxvO05BmC76qazgE
X-Gm-Message-State: AOJu0YwM8iNE+UaiIGLtMxZS3sj0Ku3lfYja9L377AXVJDvlTIDhMdfB
	W59WTkBTYRdgiE4Zwzu7Gm7BFFLiGL2A88icG49X+157LMGM5K9BYfHPcNsC1p6LmN4bmKgJLaF
	R8qtvWw==
X-Google-Smtp-Source: AGHT+IFwcyov6c0722xDDzM6L7P1/PRYgIQe17a1xGs4WXdNX+Df9WaFWJZUFlxqStn3+Y2GmAhftA==
X-Received: by 2002:a17:906:310d:b0:a77:c548:6456 with SMTP id a640c23a62f3a-a7a013408fbmr404088366b.59.1721350208127;
        Thu, 18 Jul 2024 17:50:08 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a33d9f69fsm22486466b.117.2024.07.18.17.50.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 17:50:07 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so367048a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:50:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiTX0MSO44Do/BQTjSIxzH0Wk1ZVmYypHjDYo44vC3V7pl7jMFR4qTBeq/syeQTwcVo5qKKpgGeNGN3aFo3X8u4VV2taM2VfcEY9k8
X-Received: by 2002:a50:99d5:0:b0:59e:6b89:fdad with SMTP id
 4fb4d7f45d1cf-5a05b4165ecmr4716092a12.3.1721350207330; Thu, 18 Jul 2024
 17:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org> <20240719102824.1e086a40@canb.auug.org.au>
In-Reply-To: <20240719102824.1e086a40@canb.auug.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 17:49:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6RzMFr3zWfkwHh1JwLxQzN0BtH3H7M6JJogVxOat8CA@mail.gmail.com>
Message-ID: <CAHk-=wi6RzMFr3zWfkwHh1JwLxQzN0BtH3H7M6JJogVxOat8CA@mail.gmail.com>
Subject: Re: [GIT PULL] probes: Updates for v6.11
To: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 17:28, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> But another fix that I have been carrying was missed:

Hmm. I'm starting to absolutely hate that "generic" syscall.tbl file,
and it was literally merged just two days ago.

That may not be a new record - I'm sure there have been other things
that I started hating even more quickly - but it's certainly up there
with the best (worst?) of them.

It's now come up twice in just this merge window for different
reasons, and I think both cases showed that it's just fundamentally
bogus.

There are system calls that are architecture-specific (the whole vdso
thing), and nothing is ever going to change that.

Others may not be as fundamentally tied to certain architectures -
like this uprobes thing - but will simply be introduced at different
times because they still need possibly a lot of architecture support.

So considering that it was added this merge window, and already is
showing all these issues before the merge window is even over, I'm not
at all convinced "scripts/syscall.tbl" has a future.

Now, I do think we should strive to unify the system call table
generation under one syntax. I don't think *that* is a bad idea.

But I'm not AT ALL convinced we should strive to unify the numbering,
and do it in one file.

In fact, I think that the numbering should not exist at all in that
"unified table syntax", because the number itself is causing problems.

That whole "the numbers themselves are a problem" is not a new issue,
we've seen all these silly renumbering issues forever, just look at
something like this:

  git log --oneline --merges --cc arch/x86/entry/syscalls/syscall_64.tbl

and that's with people often _trying_ to work together.  So I think
'scripts/syscall.tbl' is actively detrimental, because it introduces
*new* problems, and it doesn't actually solve that *old* problem.

So I think this needs to be re-visited.

One possible model might be:

 - remove the numbering from the syscall.tbl (because the numbers
_are_ going to be different)

 - make it really easy to add actual generic new system calls in one
place, for when the system call is NOT something that needs
architecture-specific trampolines and stuff

 - make the common infrastructure generate the numbers

because I think the current model of "let's share a table with
numbers" is already dead in the water before we have even completed a
single merge window with it.

Other ideas? Arnd?

             Linus

