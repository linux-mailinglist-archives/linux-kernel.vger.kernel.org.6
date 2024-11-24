Return-Path: <linux-kernel+bounces-420353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070979D793F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A742B23602
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED3188704;
	Sun, 24 Nov 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEo4reMF"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2646F06D;
	Sun, 24 Nov 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492561; cv=none; b=OC3uBhYCdk3WrTamtpsp7cxs+HV3q3ruBPFUjqDCho5IOq+aS+8gmRaLBzEJ5op3v0OZ7+NxRQZSBqDj6vz86NWttU6K3NuJ2WcvpUeEBYdJ2bb4kVusMC9QeGEY5tqHIIktLTVvQExEAZEuz+2LoSMfACgbwBIoIgUH9257UD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492561; c=relaxed/simple;
	bh=PD/UJLm7LH6MMLLNmAJycIDksAQ/wERoT2FSyYoRmQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmvogy95VyIMzpnRbBCyOn5RM0x9a0fVea1Ga0+LWSm4RIga/H55pn2bCTpxLfksg/flSPOMk/ByXyzLQMFoY9T+FuZlmY6LcvXREGWH25+Ox7323PMeY6CUj3yrmF82APmS4G7/JZ5UP+477daZN4Bx6jW8Xp/aB42W97m6GO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEo4reMF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2edbe217f00so178049a91.3;
        Sun, 24 Nov 2024 15:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732492559; x=1733097359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSNG3NPvuuTBpMAx70Czhut8CJdhpPvO+OEns2dE0B0=;
        b=TEo4reMFkFUQtYy16ELC0Np0LEakV6gWab61JD+RPIBuoCFCe0TDw9fcJ48m4qQHAi
         tvtdgR57n/O2PD/rNBBMh1zXbzptsDGF+gUP1RdmlQS7eTDzU1GRicdW18PyENoUj2tE
         Q6/oS+6XOYWBfv1LUI5uvKzGBu8FIw25O+GFg4gfZDNM4lJSNfckZyrnLovWhXeUybY4
         wzXRkyKkqmJJ3Uj1e1fOcRsffHnIFHRMiBl7mv7h/8e3Lzlg9Y49ZappdgqI5bwzYymn
         j9ZP9INj4l+pmSzng4iA4qm3JK1+vl/e0i6TriFfuBSkBh/k7o/fwB1SM3peEGF56b39
         DrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732492559; x=1733097359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSNG3NPvuuTBpMAx70Czhut8CJdhpPvO+OEns2dE0B0=;
        b=QawHnTorRXObXcyV60NuNPBa3vgIgVhiw6tKaeVTJZk6s2NVFwZwYnoZkY9+ypzUUm
         TiZqCqUEpWT8Pea3lVB1Jw8zDqEUudzy4DnHYMRz7Vz9pMUaCQoKWz6fsoA64zsoDXNI
         XBJ06COJGyhyFyxgux1w8q7T72d3GJdZFi7dO5UYXp38GAsL9AOw/1Yqsh1kvJ3Z1sdJ
         rkkA66n7radN91MkilPKB6iOiYsfYirgwL5Gloy2whokWAfnKuLk1PvWg89aXIpF4VsT
         VovH06jPiLJweP6eE+Ek4HdY9+S4GYZNXB07EbGYW/QpEkldLJBV8YP/VDlXk8Hw3frL
         enKw==
X-Forwarded-Encrypted: i=1; AJvYcCVDVIgZpq72vaKZcMaDTEMRGtynz6XvTY8dJmSZb884hew8MXKrxs+ELtVYl5Zz2jz4wg14JbRk0XP5OvUpuWI=@vger.kernel.org, AJvYcCX7F0lO50eO5rkVsv/Rzr1WWsrs53zBsA4Sf6Hw9QJNgUwu4hflGAP6C9KLcQ3GJWZ6SXFORAfs2t0JVSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOI+SeuFuWd+TphA/j0rLZrOHhJYgWEbLlSkczJNyad0NHA261
	08H9ye6J1SkpIIRhzNTaDNpXtyi6K9bZ4AeFKiT7nlFD2F2/gJcqkeWeR3uo1eYVapntaDCNav0
	ZH2Qdq+QqKR7xbrpMjbFpZH5p2tY=
X-Gm-Gg: ASbGncs0tFiyve0DPGHkAeAi6iexPdNiR8xphyeyf8hZehfvMWyEqjYNFIXIC7knDIy
	YdgixIhu6iNrxrdOHnwexPjACTc4vnA==
X-Google-Smtp-Source: AGHT+IExKJPMfSptNdZi1BZ8FL450ZEm2k8j2KwKqOU+8iLFSl8lseaokzOBbj+tjOdhAv+NUZEjQc4mBf4vzHjZBLU=
X-Received: by 2002:a17:90b:4b42:b0:2ea:a9ac:eeea with SMTP id
 98e67ed59e1d1-2eb0e025c93mr5664097a91.2.1732492559391; Sun, 24 Nov 2024
 15:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116181538.369355-1-ojeda@kernel.org>
In-Reply-To: <20241116181538.369355-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Nov 2024 00:55:47 +0100
Message-ID: <CANiq72m46L5sqU_fUapFMNF6m4mA9XHRaT-bRsPA7kffBmwnSg@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `clippy::needless_lifetimes`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 7:16=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In beta Clippy (i.e. Rust 1.83.0), the `needless_lifetimes` lint has
> been extended [1] to suggest eliding `impl` lifetimes, e.g.
>
>     error: the following explicit lifetimes could be elided: 'a
>     --> rust/kernel/list.rs:647:6
>         |
>     647 | impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator=
 for Iter<'a, T, ID> {}
>         |      ^^                                                        =
          ^^
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#needless_lifetimes
>         =3D note: `-D clippy::needless-lifetimes` implied by `-D warnings=
`
>         =3D help: to override `-D warnings` add `#[allow(clippy::needless=
_lifetimes)]`
>     help: elide the lifetimes
>         |
>     647 - impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator=
 for Iter<'a, T, ID> {}
>     647 + impl<T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator for=
 Iter<'_, T, ID> {}
>
> A possibility would have been to clean them -- the RFC patch [2] did
> this, while asking if we wanted these cleanups. There is an open issue
> [3] in Clippy about being able to differentiate some of the new cases,
> e.g. those that do not involve introducing `'_`. Thus it seems others
> feel similarly.
>
> Thus, for the time being, we decided to `allow` the lint.
>
> Link: https://github.com/rust-lang/rust-clippy/pull/13286 [1]
> Link: https://lore.kernel.org/rust-for-linux/20241012231300.397010-1-ojed=
a@kernel.org/ [2]
> Link: https://github.com/rust-lang/rust-clippy/issues/13514 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` so that no one gets warnings on Thursday under
`CLIPPY=3D1` -- thanks everyone!

Cheers,
Miguel

