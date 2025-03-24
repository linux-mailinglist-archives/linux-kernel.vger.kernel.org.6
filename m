Return-Path: <linux-kernel+bounces-573299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403E4A6D56B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231967A372C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A14525C6ED;
	Mon, 24 Mar 2025 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxLCFSWl"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55B1662E9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802469; cv=none; b=d6/s7G8wKngMQ49H7xUSqbffzc5cJlf1h7ihPrX1kaqX/xtHlsY6CqwBfyGdeEbv1ksYxh0mDmz+lNBcPouQKoJw33ShJMKo5/MGDpEEItPJX6lG+R8YU0kLQ5knFXItsqNATciQRHI2sGQJj5j5I0SevkZhe7EYuIO/SrNTf4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802469; c=relaxed/simple;
	bh=xM1RjYHZg1ekNoAXaFX4dfA87jJ+mzAUjYXKSB4NO94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoTQ9iyuHAzWdiLnDxCKoaU7TGMUJUQxytsFigZShqLEjQWzmX1kCfw9k9vE9W4pk3P3Djk3ckoH1RKEj8eCvw1/mBpVSa6w7dvD363nqjN1Twp/evAKJ7lP1lFuW9cM3VqXSyMUYaqfh4Kj1Vr9U+T1uVgDgd726MFHa7q9MAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxLCFSWl; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4766631a6a4so42823861cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742802467; x=1743407267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKZ69y/TQcyXRUiF6XUhG0mlXyhTl3QHF+MMx6pYAh0=;
        b=UxLCFSWloleU7t7QhvmkTXVY+GK/SlaxbyVtmDoA141NJMy6MZ8feFQPX7t4aMCHXD
         rHETt7F3+CPBWt1+a9Rz6TUyV6nVSjZ1unGPidBAwOZKS0qCqGqmsyLzpFcfUzRFIBij
         6/CYoIics6TmYw5lPVVhfi9VfUFrjvTIopWtgjGbiun0yRBvneMhb/VTdJ6PkwUEyCUG
         hf4Z7fNIvrPXFcNxCpCzhHnPtKB2XHTCLfYAMuLHdNM+Kx7J9ma0GbZhbBQvy8thFM3w
         F3JUwS+wdcqxLWaicWRMckNpEEF8YdAjq1HkaLTNBl1bRMxreJiK68Lr6eMC4pE37sKV
         SVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802467; x=1743407267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKZ69y/TQcyXRUiF6XUhG0mlXyhTl3QHF+MMx6pYAh0=;
        b=ehQmqiY179sGYbKDxuG9To1hEPoteo/UTT4e9MCY5RAcqiUoj6YradcWyqxVxHKa0O
         rZ+6D69aLZ340b6utKWkHnaZ7wDNJwABijrc7jce4uWx2jvn9eeg8nkAHOiWCUh3gM3A
         83XtPQO3VdyoEgOA4zaHSO5cJNM8sTTRvWTnaYD1zYbC1dYPDqafHF4bSVGWA2Aiqhj2
         1ueRi3aWzNrwHf1XORoNjBdgucq48BBdwxCOO5OLTZ9pmPLd16BpJIbfRkINgtAlyamc
         ENbaF1vxaPGeQ0l1IXN9mOsA19cTV31yM7CP0uuvkvyvwFHKpAnZk1mMhWPo5pTe1zVE
         dqeA==
X-Forwarded-Encrypted: i=1; AJvYcCVYOJ7cB8b2wzNJpgwJHdrSaP8nHiQD2EAkqZL7wi4QN9uyAwnyTykgWWxH9YumO04HVvPAJydmyY3a+yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGMAm7tQkluLse4ToxAPPxdUO9vV2BX7RN09j0Wqh6ZUOqa1Z
	7hg9GBE5Zhohe9xuj+7ixCrs9AaEQIX8ufD3+W6/nuZsflDl0fpiHQYNUrO7MBTvRf0cEtOlC7h
	nY2Z5E0H1MbGyvc+oejEi8vNDymLE0inbeZXs
X-Gm-Gg: ASbGncvHBEWk3aisRtHisQE8vKNU8J5NbszacXvN9BWoH1de/axH7x4OgVTjGbgQJc4
	j4NAtvVUWFuZsFoWEropEutNzmf04GK6WYfDKJ0B0m0o9S42c9OshczcfP9JH0QFJCMZSqijaA4
	qzRjfe7xzvu6fbopimtNRN/ubZSOyhobpMmP4I1w==
X-Google-Smtp-Source: AGHT+IGVn8dvxxgjkwNb8YI2q+jmg9rlDVF2xdS1848nZqsdIPKHlHUnwUJJPFBj1qHHZDapYBLUSgCczoRLBR4OMeI=
X-Received: by 2002:a05:622a:4d03:b0:476:7873:91ae with SMTP id
 d75a77b69052e-4771de1183fmr195931471cf.34.1742802466880; Mon, 24 Mar 2025
 00:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323072511.2353342-1-edumazet@google.com> <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com> <Z-EGvjhkg6llyX24@gmail.com>
In-Reply-To: <Z-EGvjhkg6llyX24@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 08:47:35 +0100
X-Gm-Features: AQ5f1JoywH4uiLtRUtKnn-7sY9WO8V0TlYkoOg-PlWum09feuGxw0wsL46OuhRg
Message-ID: <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
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

On Mon, Mar 24, 2025 at 8:16=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Eric Dumazet <edumazet@google.com> wrote:
>
> > > What's the adversarial workload here? Spamming bpf_stats_enabled on a=
ll
> > > CPUs in parallel? Or mixing it with some other text_poke_bp_batch()
> > > user if bpf_stats_enabled serializes access?
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> > > Does anything undesirable happen in that case?
> >
> > The case of multiple threads trying to flip bpf_stats_enabled is
> > handled by bpf_stats_enabled_mutex.
>
> So my suggested workload wasn't adversarial enough due to
> bpf_stats_enabled_mutex: how about some other workload that doesn't
> serialize access to text_poke_bp_batch()?

Do you have a specific case in mind that I can test on these big platforms =
?

text_poke_bp_batch() calls themselves are serialized by text_mutex, it
is not clear what you are looking for.

Thanks.

