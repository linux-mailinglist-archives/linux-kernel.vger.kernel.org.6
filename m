Return-Path: <linux-kernel+bounces-561704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8DA6150E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E82B3BDC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C47202C4E;
	Fri, 14 Mar 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpwq+yes"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278293A8F7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966403; cv=none; b=sIivNlQSDkBWnTY/bqebBdL9+WKcTDBJm95fxhVlvdi/h5IxTOK2JQ+oBG+5ck8jq97aGdEk58R5bY8DTMZRb+t+KWmOvY3SnTsVSTe1K0CONrPXkSOm0KmgbPHDhUh8gDMonZqGwr+n3ijjs6k+DmgR4pBfVyCVJm7Jtt+2B7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966403; c=relaxed/simple;
	bh=/f2p3mVne0w65vJBsRvlHiSppBWtyePw6OccsVBcLdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAz58zLVlmPvWvLL3YKqba909VwbhBNMZFjSwZVF2SY1xjwymixsbBDcFITs/kP944gqhPSix6xbPHys2uojHUumxFI+8ltO278BDEe4K5qFxHB/CM2gwKtD8+WBRtW/zBDTd7t4lEDDTHublT6ZRW7eAPM7QCoZofm64KS6Xkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpwq+yes; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so11398a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741966399; x=1742571199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZkLdAwaa8FNMkQTBuDbjMAgl7BLJESMsVIBZknuir4=;
        b=wpwq+yesxd722wzuAFLZWuHqLmqJbtguuYQMkPenrdSJmbvnDD4FmdO/ecCSvIBDAW
         SeynUSAxKsyakCC81QIPFwm7bW9273ZspUor9GOebNmAsW/FV+SCAGCAQsEZLQxLqWPG
         nGj19nqCCyyW9qZlS8XCjl2hLuGa+pWvLPGNsSvRTgPxP3Dd5kebp+mLP8GMCeO1J0xP
         Emh9DwLzAwFdGPa5YIIT1g+L/DyBeElzdqAqUDpFeleCxoX4v3RWq17+Kv+rF5SCswYF
         aqCjJVZX1e+LgnJtLdUk38yUnNGNo4e0GoHDvzHr1BkgsFDeMTA4fdwmP/LQkKrrrGLk
         x3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741966399; x=1742571199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZkLdAwaa8FNMkQTBuDbjMAgl7BLJESMsVIBZknuir4=;
        b=DJ2Q2sKVNKTT+PY1Ie8p8AAgvwIm0VQQ8nOCyG3LK0vBvp6flupveRlwC7Ze/6Sp8c
         DXfuumRXHkQgG0AbdLjWQwTDKKPOY3EmIJG9sQLEeAe8TIuWInzfBD/yiHGTh4bBwDUD
         wI55k6rZiF2NeuivbuMz7d4eh7Nm3jP45hQQT+5yPP9oT6TQOBgxS2VR/GftmO5xrK3H
         ptFfpPMgJEuXrxUE6EU071xTUMSW+zWOoW1WkVWTLBhBoQ47q8g3hzhdJvVJEsddlBHf
         9W0KUuBvqLllWxf6QNgHtzbH642dO7L6bnG4SsTxnvTCGCys2Jp596HaCSUoIu8ymVQ4
         J9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXPtlEcqiUOBg85qbphMt6foaqug6tBfx6/85xVYUkPENGeWWRd0zCPcmFMna1tnb3tJysFKNhXvPQaGP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+9Mp8QReP8nTKOEMoJpXkfJTD+LEti3ABn2gD+24Q+eq7Eh0
	0+evupeu2wZQ6TwDDwLMln5hal2kLY1OyYoboe5Bwf2R5jpt4MJbeIxp/sr3akF5X6xWpbQhtxo
	qbGdXdjgmslZk0TB+LerETmqEnghpXTbM2M1VAbhQOBpAeZyybg==
X-Gm-Gg: ASbGncvNgKOyt3qacBMwvwgvCvj4mRevDaMxZwS9RnwLf7+fIJtqTfT7gxMlq1RSeqL
	cBDIQyA/cHnvPQHV8i3v8BPoSqo8/gjyjdj3wTCk4HdZyM7XnILD7kjr4yRn2ICz0ZRd8RXom6l
	3unR9JkGRWEIlqJy7CNQuh6n9+Xg==
X-Google-Smtp-Source: AGHT+IHgibR7ADqZA35lgaDS2RgZ8vFqR4FlGXDJh3YM+0ILrAchqkHslljrvId/LqcXOKRCV8qLaO1Lhi8GKR9+5qY=
X-Received: by 2002:aa7:c642:0:b0:5e4:afad:9a83 with SMTP id
 4fb4d7f45d1cf-5e8846f4a08mr112948a12.2.1741966399048; Fri, 14 Mar 2025
 08:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225004708.1001320-1-jmattson@google.com> <CALMp9eRHrEZX4-JWyGXNRvafU2dNbfa6ZjT5HhrDBYujGYEvaw@mail.gmail.com>
 <Z9Q2Tl50AjxpwAKG@google.com> <2fd1f956-3c6c-4d96-ad16-7c8a6803120c@redhat.com>
In-Reply-To: <2fd1f956-3c6c-4d96-ad16-7c8a6803120c@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 14 Mar 2025 08:33:07 -0700
X-Gm-Features: AQ5f1Jp_7HH-kHyl_ZHpZdf2UgPE-gHIUbSENkLZMH8Wh8uKbOKB3H5Bw5MC98w
Message-ID: <CALMp9eRYvPJ5quwa7Dr1GgjPpmZVm+6TM_fkhA6KbVAdMsGH7g@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Provide a capability to disable APERF/MPERF
 read intercepts
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 8:07=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 3/14/25 14:59, Sean Christopherson wrote:
> > On Thu, Mar 13, 2025, Jim Mattson wrote:
> >> On Mon, Feb 24, 2025 at 4:47=E2=80=AFPM Jim Mattson <jmattson@google.c=
om> wrote:
> >>>
> >>> Allow a guest to read the physical IA32_APERF and IA32_MPERF MSRs
> >>> without interception.
> >>>
> >>> The IA32_APERF and IA32_MPERF MSRs are not virtualized. Writes are no=
t
> >>> handled at all. The MSR values are not zeroed on vCPU creation, saved
> >>> on suspend, or restored on resume. No accommodation is made for
> >>> processor migration or for sharing a logical processor with other
> >>> tasks. No adjustments are made for non-unit TSC multipliers. The MSRs
> >>> do not account for time the same way as the comparable PMU events,
> >>> whether the PMU is virtualized by the traditional emulation method or
> >>> the new mediated pass-through approach.
> >>>
> >>> Nonetheless, in a properly constrained environment, this capability
> >>> can be combined with a guest CPUID table that advertises support for
> >>> CPUID.6:ECX.APERFMPERF[bit 0] to induce a Linux guest to report the
> >>> effective physical CPU frequency in /proc/cpuinfo. Moreover, there is
> >>> no performance cost for this capability.
> >>>
> >>> Signed-off-by: Jim Mattson <jmattson@google.com>
> >>> ---
> >
> > ...
> >
> >> Any thoughts?
> >
> > It's absolutely absurd, but I like it.  I would much rather provide fun=
ctionality
> > that is flawed in obvious ways, as opposed to functionality that is fla=
wed in
> > subtle and hard-to-grok ways.  Especially when the former is orders of =
magnitude
> > less complex.
> >
> > I have no objections, so long as we add very explicit disclaimers in th=
e docs.
> >
> > FWIW, the only reason my response was delayed is because I was trying t=
o figure
> > out if there's a clean way to avoid adding a large number of a capabili=
ties for
> > things like this.
>
> True but it's not even a capability, it's just a new bit in the existing
> KVM_CAP_X86_DISABLE_EXITS.
>
> Just one question:
>
> > -       u64 r =3D KVM_X86_DISABLE_EXITS_PAUSE;
> > +       u64 r =3D KVM_X86_DISABLE_EXITS_PAUSE | KVM_X86_DISABLE_EXITS_A=
PERFMPERF;
>
> Should it be conditional on the host having the APERFMPERF feature
> itself?  As is the patch _does_ do something sensible, i.e. #GP, but
> this puts the burden on userspace of checking the host CPUID and
> figuring out whether it makes sense to expose the feature to the guest.
> It would be simpler for userspace to be able to say "if the bit is there
> then enable it and make it visible through CPUID".

Good point. I'll take care of that in v2.

I feel like I am abandoning my principles with this patch, but as long
as you and Sean are on-board, I will do what needs to be done.

