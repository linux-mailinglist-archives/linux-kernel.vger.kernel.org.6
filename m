Return-Path: <linux-kernel+bounces-573308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FFBA6D583
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2451892C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D625D1F4;
	Mon, 24 Mar 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKcVZgFP"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7862500DA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802825; cv=none; b=jQIvnGvA99XccbTl4U7Y20kzONmD7zVml1W6kgqVRbsjMhjh4s9IwK0dVMEhx4afgagDzZPwU/B8GkMScnydDY8o5OVwboUQ2+pRxdH7W5OhNp+xAl9s2cja0sbG9JGhSMWUScE55TVsia9tNa+A2lgmPzYjUsy0ncMw60UFz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802825; c=relaxed/simple;
	bh=+f+zTy+HCdb0nsVnI6YMF9DFCrlapfwDiIEaJAlJXcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8frpg2/vIJFSavqJEVedpXyk5NP9BUhfDx5KBhtp2tuyCICWcuVLBn9LehiGAwhqH8uxsY69DGc8A2ne/r0718s8s0e8y02u3qDQxSXB85y4RO+EfMCNhtm6brTT9DU8iONcgNszTkTUHdp6g97U813VaazpEMAjWtensmVWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKcVZgFP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476f4e9cf92so26600421cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742802822; x=1743407622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoORNtbY+B2IUJ3dsVJjusx0671z0wqj3fYYp3L4WQk=;
        b=zKcVZgFPTsVNtdKaPMgj9ynLjkchYceTBXU0MTD9eCP0hP84+ZjuD3rpBz4phcOvHk
         XiAnSgLZbpysc35eoVtjQ15UlDPAxRaIl0M1XgoWiur+GF6VNOzUtQh2ue0flm1qdnT2
         ClbvZb/gTJZ8V8I5pMolHSRY6FrZml9DHZ4ol37jtkYegbvuEgX5AMMQQdFSOuv6q/3V
         XgcRdQ4kKhgJOQerKJnQkflibZnFK3886VYPzHtoe6eDm4+dBS14Xmq+Pi7hY1tXX513
         Xn9nKHj4mkfji5k21L9wQ1cx8F+UKnmBccV8ZDE2SpXFysoNVsezpD4DSkYiuDHJBVkB
         tl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802822; x=1743407622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoORNtbY+B2IUJ3dsVJjusx0671z0wqj3fYYp3L4WQk=;
        b=VnPtfyR6d8d2A0AgWRY05x8WX82ssXccziRCjqpam7NcmqxOvH7steWnpSFbLudWVl
         VNq2QBTwdUMrecWbTiXV7YjVKnXLwybEtL5Y2Ox4KqyJU4RboQdDuVhaLkb3So9xwh6m
         WHmLgx8CPEdfjdLT7woEQzNAZ1wb5GQj0Q5Otv+VAPuU0/nRj1OD6NPaL8l6eBdQ2Fwa
         4xBG5IXlIAZQZXO0XfK+JmVOfyYo0GvbhF6XYhadKfvjFQbwjMpScR/U3Y2CorxcFOqN
         0dTnKFRtHjyTGGonWmFHT2OAwf48ChtDZW2jlfNO0vHPa2ffPWG+esG2NOjccDXwlLFY
         /M2g==
X-Forwarded-Encrypted: i=1; AJvYcCWpXBAEj6NBNkrdek3Kn4tgl052mi6ye93jC1C93AgzlpN8Awiry0sSWypsg1ULiIdFy1mgKHV6WKH4BSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItBWc656YGbjIBx5/dnFoDWxy4kCYxIuOACaHBlda9telaRi3
	S756LgBPGuc7GP99Xz8imsb9L0v0txhM+77dplwA0559NqEmREeqrcZVtu/xuXLtp7s5bIMIoto
	WXEIU9VCZ7gAp+8B6ZY1UwL1m9+dGfYXsrE/7S0AbLi7ZPbuTrssu
X-Gm-Gg: ASbGncsAj2QaLvYmvlfIUQjc3NqD0C0oWLWRxXewrJUKp2evtVyH/zira4AUCEtDHy7
	tAzERUyXtsD4oROcRGG8Qzl4LAf7teffIdnkgTH9ISDphXtlEP0EdddhKAdi/3wXtVr2iwKUuUK
	sC1kHibEEh/+Fhf9TAEqpBJSNjACg=
X-Google-Smtp-Source: AGHT+IGiwsWFuYsLMNRyd+YyNDH5S9vrOYtns1KAlBv0TwB+wIKjZFlUfAJvYJceCxx7xV/sibpXW8eyBJzWnUP1oqA=
X-Received: by 2002:a05:622a:4009:b0:476:8cad:72d9 with SMTP id
 d75a77b69052e-4771de3f530mr200487331cf.33.1742802822174; Mon, 24 Mar 2025
 00:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323072511.2353342-1-edumazet@google.com> <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com> <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
In-Reply-To: <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 08:53:31 +0100
X-Gm-Features: AQ5f1JrzgIBhkWXtEZlLxzH8STpfXyvqiZx0ev4PTk9UGx7V7iWN5IFKTjlaI7Y
Message-ID: <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in poke_int3_handler()
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	Greg Thelen <gthelen@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:47=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Mar 24, 2025 at 8:16=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wr=
ote:
> >
> >
> > * Eric Dumazet <edumazet@google.com> wrote:
> >
> > > > What's the adversarial workload here? Spamming bpf_stats_enabled on=
 all
> > > > CPUs in parallel? Or mixing it with some other text_poke_bp_batch()
> > > > user if bpf_stats_enabled serializes access?
> >             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > > > Does anything undesirable happen in that case?
> > >
> > > The case of multiple threads trying to flip bpf_stats_enabled is
> > > handled by bpf_stats_enabled_mutex.
> >
> > So my suggested workload wasn't adversarial enough due to
> > bpf_stats_enabled_mutex: how about some other workload that doesn't
> > serialize access to text_poke_bp_batch()?
>
> Do you have a specific case in mind that I can test on these big platform=
s ?
>
> text_poke_bp_batch() calls themselves are serialized by text_mutex, it
> is not clear what you are looking for.


BTW the atomic_cond_read_acquire() part is never called even during my
stress test.

We could add this eventually:

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d7afbf822c45..5d364e990055 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2418,7 +2418,7 @@ static void text_poke_bp_batch(struct
text_poke_loc *tp, unsigned int nr_entries
        for_each_possible_cpu(i) {
                atomic_t *refs =3D per_cpu_ptr(&bp_refs, i);

-               if (!atomic_dec_and_test(refs))
+               if (unlikely(!atomic_dec_and_test(refs)))
                        atomic_cond_read_acquire(refs, !VAL);
        }
 }

