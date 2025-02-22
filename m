Return-Path: <linux-kernel+bounces-527219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B86A40895
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1256F3A438B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0BD207A35;
	Sat, 22 Feb 2025 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfl9Jmf/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877428494;
	Sat, 22 Feb 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740229470; cv=none; b=qc5hLDfHneOIbw4I1ByH4SW5Z3yiRCoMnMdvygLTNLVnE3JAqyPsDHj2MeeAA/hPerQu8TLk3yLSbDid+bT0RCuZpyC152jq58VpL/Srd9+LIbU2cwOZScjxYalqRtcbYvMBkNXaJF/uf8HOVYsDgk+j2Bf5vbwz6xdibxlbSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740229470; c=relaxed/simple;
	bh=CBfymnCcB17kUdICHcQ/09wwscvMW2UVOaYcXpoZ4ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSQH/kL08DI+urAo8JLbloadAgTJUn2JS+5So1XZ6wFfSR3k70fLEoohzIirzBMYUlAyYc/QUcMBW0viCOCUlrbFumXcl/om09a3T2SR9rZOWAVbKHkhYp70BBbp4VAu+wtP7Ah50ME6NojST/VjFzGJq8GlGhavqRYLwVe4UcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfl9Jmf/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22134a64d8cso7436485ad.3;
        Sat, 22 Feb 2025 05:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740229469; x=1740834269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBfymnCcB17kUdICHcQ/09wwscvMW2UVOaYcXpoZ4ks=;
        b=Jfl9Jmf/0sb+Kl/vuwglR2iINIDSSUPVhXHeL2Tughix5m1LrzybmVoteyMWgS9v2p
         4h6yMIpRdjiwrQ5v94J2vOMC9ULb1XtzrWDVk7LHCRQh1UL310EVMfcbBRcPZil5J6Ur
         MZa6EZMpg/X7pvnKXUXj7p9xrGbwVoj9t1pb5n9gy/X65ZBNYuksZJunozDR49Jlyjjp
         Wsaege/DVO9qorls7QAu7xyTIVnuQulRNNBzP+8r64er1Kknm4E+PKEgU8IC8+OsQ+m/
         oCP7TP9mmB8nw4UvZO4EHBrlibfqy4N2Bkk2w0v9yS27A048vusqm/+UgCU45402deLg
         RM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740229469; x=1740834269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBfymnCcB17kUdICHcQ/09wwscvMW2UVOaYcXpoZ4ks=;
        b=KASJnLXiSg9AoFNDlIX6oVt7qZxzUoK5xtirXE67ykV46stRO8vmX67ldF5Oj5ivt4
         hT+mlpcOGEZkWDWIeqPmh0hhIT14g7C0CV2hLsA+ay6dypw260LN7AvtBWyi8z3m9Gax
         nPVmH/ieRcoLQLCcbybAz2o5+g8Y9No1mRlVGaomNRWo46jKQhCq0F+IXEprPIK5yp5t
         LsFM6hWAKr+Zym0mFvkP+yHWtO5fLHNeDgQS7JP5GCNMIWGSsv10MTXZfakGkAAhidwc
         KLaOKNqsS3DDNmHG5JxbKHp4e2hjuNQVaot6M1uDk5PgusXSXIRehc77P48A4fiWVIdY
         8AFA==
X-Forwarded-Encrypted: i=1; AJvYcCUO1XyOP645e+5Vk2cOFqACtDTn89bXbblukJ8AaNFQJJzZm3QZvcjWmLMdkouD4nVisBFpIAhrz5kj6BCnyRg=@vger.kernel.org, AJvYcCXfRxn5hiVo8/UngQL6/fWiWcyd88NSGL9gpNkwgOJ7EsoeMNBy77H+17sA9F4UgTtCoJje2QSEXzTmroU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0MdRe0lxCxdlFNO7HQuvUzlFAd0h+sqwD5PNA9/62A8DxqQy
	figHhxIp/vK2ZCeyuhCDcDs6SkD9+wPVnqGRrnQLfqgt1wQVqRXBYF3z2ogfzumEP2WTSP3wT2n
	szbgGU1nhrZjPc/gL+TaiKI2vWMs=
X-Gm-Gg: ASbGncvIkB59C+ZdluAUjSQLRG2fSFif49pbIuZA2mm0nhD+DHfHtkye9/vB1i15+KS
	DJEXgY+99aN2ZNGHyeocRPKcrec8eiGDWvfRMw0Tk3pJenWN+tnn4fA3fSzVD6uDAfFFX5rKeOA
	31ysPVpNg=
X-Google-Smtp-Source: AGHT+IHMRA+PnHU3dE1lHiEiPxP2f7T5v6bGxqdbiEPyBDOSpaNkhfTf5Z1uGA6jrhap6zkUtujoedsO8rPxOHN/mAU=
X-Received: by 2002:a17:902:d58c:b0:215:a57e:88d6 with SMTP id
 d9443c01a7336-2219fec4ee6mr41354585ad.0.1740229468697; Sat, 22 Feb 2025
 05:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIJ0ymzdUceCN05hwJpth4erH5u2SHYzYl52wGeT3uiO9bdk92ZkEmEEq9a9NXsInJYSz9uziwq-1fvdsXoeDA==@protonmail.internalid>
 <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <877c5mci3p.fsf@kernel.org> <5kF-NYTBZbEqnnQud5LKnRXO0lfM0i6I2PoeFrpKDhCYwUuk_bG2Li1T1Nuv82r3VFD8adTcdx7yenXSIfTwmw==@protonmail.internalid>
 <Z7eYp_vZo5yDVOdI@pavilion.home> <87frk7hera.fsf@kernel.org> <Z7hheOSAuKdhq-1C@pavilion.home>
In-Reply-To: <Z7hheOSAuKdhq-1C@pavilion.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 14:04:16 +0100
X-Gm-Features: AWEUYZmi0olrnUbV-pHkmUPEUfk9IaPB-HHAp78OseSSS51sgFBiFuULXVitU2c
Message-ID: <CANiq72mpYoig2Ro76K0E-sUtP31fW+0403zYWd6MumCgFKfTDQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] hrtimer Rust API
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 12:20=E2=80=AFPM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> I was thinking the patchset would be better routed towards the Rust tree?
>
> How do you guys proceed usually with bindings tree maintainance?

So far, what we have been doing is ask maintainers, first, if they
would be willing take the patches themselves -- they are the experts
of the subsystem, know what changes are incoming, etc. Some subsystems
have done this (e.g. KUnit). That is ideal, because the goal is to
scale and allows maintainers to be in full control.

Of course, sometimes maintainers are not fully comfortable doing that,
since they may not have the bandwidth, or the setup, or the Rust
knowledge. In those cases, we typically ask if they would be willing
to have a co-maintainer (i.e. in their entry, e.g. like locking did),
or a sub-maintainer (i.e. in a new entry, e.g. like block did), that
would take care of the bulk of the work from them.

I think that is a nice middle-ground -- the advantage of doing it like
that is that you get the benefits of knowing best what is going on
without too much work (hopefully), and it may allow you to get more
and more involved over time and confident on what is going on with the
Rust callers, typical issues that appear, etc. Plus the sub-maintainer
gets to learn more about the subsystem, its timelines, procedures,
etc., which you may welcome (if you are looking for new people to get
involved).

I think that would be a nice middle-ground. As far as I understand,
Andreas would be happy to commit to maintain the Rust side as a
sub-maintainer (for instance). He would also need to make sure the
tree builds properly with Rust enabled and so on. He already does
something similar for Jens. Would that work for you?

You could take the patches directly with his RoBs or Acked-bys, for
instance. Or perhaps it makes more sense to take PRs from him (on the
Rust code only, of course), to save you more work. Andreas does not
send PRs to anyone yet, but I think it would be a good time for him to
start learning how to apply patches himself etc.

If not, then the last fallback would be putting it in the Rust tree as
a sub-entry or similar.

I hope that clarifies (and thanks whatever you decide!).

Cheers,
Miguel

