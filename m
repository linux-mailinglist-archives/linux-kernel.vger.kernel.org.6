Return-Path: <linux-kernel+bounces-573136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5081A6D36E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD2118900F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B31898E9;
	Mon, 24 Mar 2025 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKFKTxGM"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651812CDBE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742788766; cv=none; b=U9yIjlwSyXEg05Mx/ZDOv5sf5OMkfbyWiw94xXXb7qmrFtZfGWnOOtMaF4qHRLhCNl2dRmoxKvUIZwlCO+XEyC68t236IReoJwAgsMqzyrGZG9cKZMTBJt30b2zpBIprjBnnAcTDlnqNpYOsx+10Vv4ZRv4UWTAQY15CBRbaaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742788766; c=relaxed/simple;
	bh=Wq+njKOQoQ99uBxCYYmu1SdJbJ9l8kYeBFwtH+SIH6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kb147ToyuY/esqCWhTjVyoeFN7QEoYjpgtcAxTlj9kLGxuLqD32aEZ5KP3M9XxrPNSKLwSnFbpWsu9CaodSgEPX9PPBR0GsJG8S0lRmXCaNVY2QyRUBqR9nsci8/hz6PZKWspf0qxIcg08nDzQ+VeLfOBD7pU85pC0L+aEebIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKFKTxGM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-477296dce8dso17870771cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742788763; x=1743393563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHCjbbw8cS5r9fVyN01ZZMdpGoFgkz+MT6KHTqF2eLw=;
        b=JKFKTxGMEOOESchKHG/VMgtdCGwZ839HIkwjrciv3zgVa2DiGLEdCKwsTrn+jZU82P
         O4wQPs8oyxX21F5p+r9rGSeBUEbQRps8SC4D3lE6AHPqGcg0JO8Tnn0gq/4HBik794WE
         zqoBWXDAouFIE30VL3BIyb4AmMKrG+i+FQ0MdnfKdUEew9Rf//N9ygFTuAr1fMufZCQY
         9MBo4MUALmkiRY31EARDWNHdw5JuIUaVQdTp5VkJexlOG0jlLA6BEURwHOKLcO+dU8KS
         Vio0DBTO8uZonRXX6u7Tddq+3slLFwTgiDlOmme6n8ICB2tKIibfNDIxF5C9jwvrpcMW
         eLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742788763; x=1743393563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHCjbbw8cS5r9fVyN01ZZMdpGoFgkz+MT6KHTqF2eLw=;
        b=OqBO2SsyLpgdSMDXMx04YgB56XDzoqV0QE4GKTClJavlrAOsIwuRJKqEYf50+yeEwj
         9bDia8stodIRFzj2erXUXoH2GxeTdeRaGONJmPabqTKVMxEOkJHuyaM5kTZ78zUu9hYQ
         LppXMpYzj1+vhI2EXHF4/PrbJqKYjp84igcYXlaQPNlnzx8w07f6FeUkECmDMhMAYRjo
         vI3Tlgd2Fpxt+lnrW5za9e27pUt64wpMnd8SLG/gMyscJcxZh7XYAJ9ZIVFx+auN9Iu5
         3dr7ymGj/0/rqteK91hHNmkH4mGEnqdPRhgCVujlBbDVAUqWcZssgjGawDcC9Mymlw5Z
         Dy1w==
X-Forwarded-Encrypted: i=1; AJvYcCVjCDmr/+nrpfSpTgEWBXJT1hWjXNyeJ5l8Ym2hg9pat9Jn+1mfORoWYVy/dUbBJlvYWh8SgCLZyKrCZVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN12zQ929hvjX48BIeOP3i/n+OjFRNDn8ZG/f+4B7irwuLWiM2
	HdYe36pPSzOwt6mq4UI5aq6+bIKlykk5mIdOm9cwzdQq/itMcp/RxM1OyQIEM7iZ0ZZ6+XsZTFY
	eRAsKnDaQ2+CcNqv66B1tsx7rJcJDvt42w1z4
X-Gm-Gg: ASbGncuN4n036AUTk8Bod/ATme2kJpmeJX0TlZ5yMKQIuB8uwHjmOCrey82o/PF1nwa
	yuGJe2mMuYRLnYnrVFziSLR5x+q9Ix1NXvEngVdFB3dZlgCpSHAf4903wSvpTgzb0RcfU0uRWwZ
	BTmKZQ2f4eVbgeTAIWFR6GI7HKsw==
X-Google-Smtp-Source: AGHT+IGK12fhHHVbahJ7SysnMjn37oqNWgxttj/oJLfD8m7bfXLO2LhJ+ZdJWh372ToAug2mpXl0iXJ/1PfveaeuNsQ=
X-Received: by 2002:a05:622a:4816:b0:476:6d30:8aed with SMTP id
 d75a77b69052e-4771de80b3dmr206300591cf.49.1742788763307; Sun, 23 Mar 2025
 20:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323072511.2353342-1-edumazet@google.com> <Z-B_R737uM31m6_K@gmail.com>
In-Reply-To: <Z-B_R737uM31m6_K@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 04:59:12 +0100
X-Gm-Features: AQ5f1JrD2KBd12qso3pX-i2q5qA5RW02Ppfc4GqZZTsvRfJx8oBuRknHp5449Qc
Message-ID: <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
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

On Sun, Mar 23, 2025 at 10:38=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Eric Dumazet <edumazet@google.com> wrote:
>
> > eBPF programs can be run 20,000,000+ times per second on busy servers.
> >
> > Whenever /proc/sys/kernel/bpf_stats_enabled is turned off,
> > hundreds of calls sites are patched from text_poke_bp_batch()
> > and we see a critical loss of performance due to false sharing
> > on bp_desc.refs lasting up to three seconds.
>
> > @@ -2413,8 +2415,12 @@ static void text_poke_bp_batch(struct text_poke_=
loc *tp, unsigned int nr_entries
> >       /*
> >        * Remove and wait for refs to be zero.
> >        */
> > -     if (!atomic_dec_and_test(&bp_desc.refs))
> > -             atomic_cond_read_acquire(&bp_desc.refs, !VAL);
> > +     for_each_possible_cpu(i) {
> > +             atomic_t *refs =3D per_cpu_ptr(&bp_refs, i);
> > +
> > +             if (!atomic_dec_and_test(refs))
> > +                     atomic_cond_read_acquire(refs, !VAL);
> > +     }
>
> So your patch changes text_poke_bp_batch() to busy-spin-wait for
> bp_refs to go to zero on all 480 CPUs.
>
> Your measurement is using /proc/sys/kernel/bpf_stats_enabled on a
> single CPU, right?

Yes, some daemon enables bpf_stats for a small amount of time (one
second) to gather stats
on eBPF run time costs.  (bpftool prog | grep run_time)

One eBPF selftest can also do this.

tools/testing/selftests/bpf/prog_tests/enable_stats.c


>
> What's the adversarial workload here? Spamming bpf_stats_enabled on all
> CPUs in parallel? Or mixing it with some other text_poke_bp_batch()
> user if bpf_stats_enabled serializes access?

The workload is having ~480 cpus running various eBPF programs all
over the places,

In the perf bit I added in the changelog, we see an eBPF program
hooked at the xmit of each packet.

But the fd =3D bpf_enable_stats(BPF_STATS_RUN_TIME)  / .... / close(fd)
only happens from time to time,
because of the supposed extra cost of fetching two extra time stamps.

BTW, before the patch stats on my test host look like

105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
3009063719 run_cnt 82757845
-> average cost is 36 nsec per call

And after the patch :

105: sched_cls  name hn_egress  tag 699fc5eea64144e3  gpl run_time_ns
1928223019 run_cnt 67682728
 -> average cost is 28 nsec per call

>
> Does anything undesirable happen in that case?

The case of multiple threads trying to flip bpf_stats_enabled is
handled by bpf_stats_enabled_mutex.

Thanks !

>
> Thanks,
>
>         Ingo

