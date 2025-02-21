Return-Path: <linux-kernel+bounces-525661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B54A3F2DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA643AE99A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3AE204F64;
	Fri, 21 Feb 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yspIs/mv"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D422AE89
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136953; cv=none; b=PuGYRdoRRnSD7Xhj5SRLsWjSvTW0aAPCddhmWHUdHYpHLu+lq5xE5dQ3HMj7Y7SEikVMGV2hSSBHihIwzDaRGrZQl2TFtVENCFG+55DJENgcaUic1Dpsm0ofLDAQBNGtOwqv84hJuwZu/NdQuw6DVx5m5rJc5s5OKbEnya2bIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136953; c=relaxed/simple;
	bh=L2rUQxjbPOLbd2Kw96fzXC6emSGdbgv1UZnlLwd++Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5G/0doGCKsxxR09eNdnQTPzI6VINZRRqcNo3RmQ915zMVaFcp5z5J0m7QkRd1sDFQKiGgYpOZOoMuqdkqjfdPus71nWkzvoTmmh5BrTSv4IPmyJYuGARj5m9Hy49DcdvAlxXV3Sl9oxC/L5MEti3JBurq79uZZkItVGjK4nszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yspIs/mv; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30a440effcfso30667991fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740136950; x=1740741750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8+9KeMMiAG2RW36K8s9O3Gc3H9PdhpNmTXNj9o2DO34=;
        b=yspIs/mvp/7eXcBq+i6cibOI1M0WtjjpyNpQ9nPMktouxWNLMaiTnwjpsX71SLmlEI
         L/1j+Fv1hRHCOrA5NgZ0N//bQM8stxe+kMOpguWE0rcsOxGcPNPJZE+gkAQYQiHX6hd8
         LzN4yzlTT9XQ80nNQun8KbrJJJ4Gs+n8daVM+GrJPvkiTMxEXCou9yBoQJyHhWfc0kVa
         IeuVag3CTYChqVy6Rim0mDKlR1AN2uxqHT1JYuKWYQgzVQWv4uYXhLJs8aq4FNDlD/eV
         y401GoOe9zYDqkO/4okJrHFfPmhSBMbNc7/RujGH4j3lGDARbPFR/MnrmHD8Ig2PNmjB
         tWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136950; x=1740741750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+9KeMMiAG2RW36K8s9O3Gc3H9PdhpNmTXNj9o2DO34=;
        b=BnUJAhIk+CIzESM0acJX7d++8TaGVUtl5JPce1AiS8EhaKto7y0eHCjjncBq5I/1UP
         +8qW1dKmHOZYdw1/xgrR2kJS0aNQx5+VPE3lN9BO8AdOduRpEX+kUjeHGvvcLV0eLqZL
         2JSlzeIU3l+VBJBEpHajbrBk/7QcGPzV7yLKHc51R7wQ1dwPAZOgOMp3+MD6+yTi4OJg
         0gou6UJITKLePsIzts8ctGI7mvlpijm9VLd7Bqq47wul5bCZqvkGhuJVhnqgDW7ObuQ9
         CIcwguYKwc9gIekojBKPXSnXrmOPDWQERgudC0sSR7QJ2t1Sx2Bv6YIfBivz7Ir/lrwZ
         dAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN0OgHEuvIV77JCga4/u9yxSFGIAn+rG8lOo9HtyFWIVKBeQljJOETx/TjVh2Z1ZklFKqPSguVbB384ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJtRZGB/kXl3T/4aGbInhZPxq9VLL8RsO5Uc6K5EOAOCxK6Pz
	x06eiI2aYep+JOxmnLhoqRtBKfY5pNsY1uLSpP7ydPqDhE4DnBl0kkOkNxxaCFU1wAJEZ7/iHvN
	JcspGmwvjNLb7FqhOlZBmsIC1rQ1SxqMK86yk
X-Gm-Gg: ASbGnctz8ssefpMCcKS8Y55qd5s2YBdMeeubPIJRr6qCZdvPVyMaNaFopNzV1AOxCX9
	hEOUuwywfmiAp4YtfYeIXP3DEukSVkRg7BDfcrJ3gRLypUHqOCUnpYg9A8EA1DAd6JJxMZa/8+D
	m3NnnilvNkEy2T5DDzajE0bWMxkhQSqM4NCVv4jJ5j
X-Google-Smtp-Source: AGHT+IFpg31UnzFIXED9dJthnSJa+/8P0RFfkhsbBDrJFCj/wHQhkYRQG6mG2KElDA/XJ2RMWc6ZUUTQIfMv4uuWZEk=
X-Received: by 2002:a2e:3c14:0:b0:309:2999:77d4 with SMTP id
 38308e7fff4ca-30a505d863cmr25896811fa.6.1740136948350; Fri, 21 Feb 2025
 03:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <f68741e0-0cc8-4faa-8144-e1786b9591f1@efficios.com> <CACT4Y+Ym7=9mLS8b=Rq6cyHMgyboMqh15nqkRfgru-qFVTx_0A@mail.gmail.com>
 <cf7af2a8-c004-481b-ad2e-6aa991aacb67@efficios.com> <CACT4Y+Z3PCBWDdR5PifXoMBSYJ-cdUmzLRdgbjTUG+A2S8Qq1g@mail.gmail.com>
 <2bcfeb11-74a1-497b-b271-06dfb51eace3@efficios.com> <CACT4Y+bu3WtdMLEOj0qFC_MK4G20Joq52Cr8W86Xx4xK3MsB9A@mail.gmail.com>
In-Reply-To: <CACT4Y+bu3WtdMLEOj0qFC_MK4G20Joq52Cr8W86Xx4xK3MsB9A@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 21 Feb 2025 12:22:16 +0100
X-Gm-Features: AWEUYZneSqfP2f4ru45m4086kHS9Qner0QFKChMu80taOdNgCYtd8UZiuC88Xc0
Message-ID: <CACT4Y+bKde42MqWsxXD99RZhDZkkNs58kv1H9dxPAh13QLqNEw@mail.gmail.com>
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 16:37, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, 18 Feb 2025 at 16:27, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2025-02-18 10:10, Dmitry Vyukov wrote:
> > > On Tue, 18 Feb 2025 at 15:57, Mathieu Desnoyers
> > > <mathieu.desnoyers@efficios.com> wrote:
> > >>
> > >> On 2025-02-18 02:55, Dmitry Vyukov wrote:
> > >>> On Mon, 17 Feb 2025 at 21:21, Mathieu Desnoyers
> > >> [...]
> > >>>>
> > >>>>     we still let this function read the rseq_cs.
> > >>>>> +      * It's unclear what benefits the resticted code gets by doing this
> > >>>>
> > >>>> restricted
> > >>>>
> > >>>>> +      * (it probably already hijacked control flow at this point), and
> > >>>>> +      * presumably any sane sandbox should prohibit restricted code
> > >>>>> +      * from accessing struct rseq, and this is still better than
> > >>>>> +      * terminating the app unconditionally (it always has a choice
> > >>>>> +      * of not using rseq and pkeys together).
> > >>>>
> > >>>> Note that because userspace can complete an rseq critical section
> > >>>> without clearing the rseq_cs pointer, this could happen simply because
> > >>>> the kernel is preempting the task after it has:
> > >>>>
> > >>>> 1) completed an rseq critical section, without clearing rseq_cs,
> > >>>> 2) changed pkey.
> > >>>>
> > >>>> So allowing this is important, and I would remove the comment about
> > >>>> hijacked control flow and such. This can happen with normal use of the
> > >>>> ABI.
> > >>>
> > >>> Thanks for the review!
> > >>>
> > >>> I've addressed all comments in the series in v2.
> > >>>
> > >>> I've reworded this paragraph to simplify sentences, but I still kept
> > >>> the note aboud malicious rseq_cs.
> > >>>
> > >>> If we would not be circumventing normal protection, then, yes, these
> > >>> cases would be the same. But since we are circumventing protection
> > >>> that otherwise exists, I think it's important to think about
> > >>> potentially malicious cases. In this context inaccessible rseq_cs
> > >>> values that resulted from normal execution are very different from
> > >>> malicious onces. Normal ones will point to a fixed set of real
> > >>> well-formed rseq_cs objects, while malicious ones may point to
> > >>> god-knows-where in an attempt of an attacker to do things we can't
> > >>> even imagine right now (e.g. rseq_cs overlapping with protected crypto
> > >>> keys).
> > >>>
> > >>> It's as if a particular instance of copy_to_user would allow
> > >>> user-space to write arbitrary kernel memory, and memory of other
> > >>> processes circumventing all normal protections. In that context we
> > >>> would need to be very careful regarding what we actually allow.
> > >>
> > >> I'm considering that we should clear the rseq_cs pointer whenever
> > >> userspace issues pkey_mprotect.
> > >>
> > >> This would ensure that no legitimate scenario can trigger a load
> > >> from a rseq_cs area which has the wrong pkey, and therefore we
> > >> could accept read/write from/to a struct rseq which has the wrong
> > >> pkey, but kill the process if trying to read/write from a
> > >> struct rseq_cs with the wrong key. This would prevent userspace
> > >> from making the kernel read/write from/to memory with the wrong
> > >> pkey through a pointer it controls (rseq_cs pointer).
> > >>
> > >> Thoughts ?
> > >
> > > I am not following.
> > >
> > > There are pkey_mprotect calls, then independently installs on rseq_cs
> > > pointers that happen concurrently and after pkey_mprotect, and
> > > independent set of pkey_set calls that happens concurrently and after
> > > the previous 2.
> > > I don't see how doing something at the pkey_mprotect call for the
> > > single thread avoids any scenarios.
> >
> > Hrm. Sorry, I mixed up pkey_set() vs pkey_mprotect(). What I had in mind
> > was actually pkey_set(). And that would need to clear rseq_cs for all
> > threads belonging to the process, which may not be straightforward
> > because those could legitimately be inside a rseq critical section.
> >
> > OK, let's try another approach: rather than kill the process if
> > read/write of the rseq_cs area with the wrong key fails, could we simply
> > clear the rseq_cs pointer in that case ? Technically there would be no
> > legitimate use of this except for the case where it is meant to be lazily
> > cleared.
>
> This may work, but 2 concerns with this:
> 1. We don't know if the failure happened due to pkeys or not (at least
> not easily), and I am afraid of touching the logic for other failures.
> If the rseq_cs was a bogus pointer, or protected with normal mprotect,
> what does it mean? Are we masking a programming bug? Are we
> circumventing some other protections that were supposed to lead to the
> process termination?
> 2. This will complicate __rseq_handle_notify_resume() logic as it
> would need to handle failures when accessing rseq and rseq_cs
> differently (+plus there is signature check). The more complex the
> logic, the higher chances of adding a bug now or in future.


Do you see any problem with the current code? What exactly is it?
If not, can we merge it as is?

