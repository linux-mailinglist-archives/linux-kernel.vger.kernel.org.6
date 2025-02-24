Return-Path: <linux-kernel+bounces-529558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA77A427D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3A9188E050
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5E262803;
	Mon, 24 Feb 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it5v0a4t"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F9218950A;
	Mon, 24 Feb 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414254; cv=none; b=KBZ/RGXtcSINtyj7I6fhzOKlKOGk86qe4/auSm5M5oZadPe2OLMlHvlKtlCyi4+YEkQc4LBnm4OWUuMTMGaIbcklCymnhiNWfoLICeHGp3CE+gGNYlROyaWKlzT+TZ92hyfzjZ5yOtA32OVCx1AEGeu05DqY/Y9afVSLKLIgZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414254; c=relaxed/simple;
	bh=qUSwjH4iIZdUOhSw/4PeSaU1cl3qms07OYHka94Q6k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y256uI5YPSWDs+b83e+hgW1dHRwr3qz0Io7WCIkZHIPpwJctGg0iuyKhir0aaaftspsZ9WF6fa0c6hhaLPzciUz//K/VCVUvqq9qtgnITHU+uOXt/sgDt4LKOJOf1shLM8hV9KHFoVUyLsxJ239wngW+ouadg8OhRLMb+EEuNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it5v0a4t; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fd02536660so667178a91.2;
        Mon, 24 Feb 2025 08:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740414252; x=1741019052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUSwjH4iIZdUOhSw/4PeSaU1cl3qms07OYHka94Q6k8=;
        b=it5v0a4t1bQ/y015d0X95DfXA7kZCmU9UQ9kr0aMr9F29V7rcw8W8Mrw5eKlLtbV5Z
         tWeVm112/DFxwbBz8syBvXh3/kEuHYHDbhMCeq6JA2IBuSSS9BBujOXCP9z9jQWJwOZY
         zH+xf42nEwfyZCiPPdZZACPZXpKUB2L0t/o1aN4O7a0Lzov/aKSh32v6bi9PryqH3hcz
         L5lA0msNztmEqtMGzl1IaY7QP3B94KyW2Q+42A2Ad3IK1D6ldLJ+owreM1HomSpKyJc9
         Wtd0x5sO/UO0MDJcmlSi9y16eJ1gOSbn5PsuUeiJ3EeUieRwxHVOysXyocCv73CJTjE9
         mqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414252; x=1741019052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUSwjH4iIZdUOhSw/4PeSaU1cl3qms07OYHka94Q6k8=;
        b=lfQbKLtao4monmWs2M0Ji1Os06Fv7LkLAppDCom/i+7UyKmueVUy1N5p6K6zVUe/W0
         zkODiI5o76RQ4e4D463HWE2QXpZQ4lF5fmxyWvYwDtSdvt/Urocr6FR0uP7gVpbmaFEE
         8+/A5cj/QTMuoVXyryWXcy1TKOBSi8nIEJ/bp0DvmvACk+ebS2eJCC+A3uhmhMqAvbSC
         vWA0iXA8pMgZydzs7Y/LjZx5PCAZo+5/qWxYK4TB6twThiHG73UqARYUUxTLSJR4KhG4
         j4znF9pXhDkGzcCXOXYu/pBaOyttdnC2GgUKdPR2Fjt/UpSq2kJ6adbvN3qWTsrHy2zR
         cniQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaL9cVVjTb5tuIIHKFiU0drGLoLmzWimyH4+zYCYnTgIbRV1gppmBpgldMdBG1FvBZiBSrGPsyjih4Dwk=@vger.kernel.org, AJvYcCXUqr7GawFlwu5HcdcYCR4esKfs6sVk/WdqVM9pGUJOeISJqHj3F1GPZXEDQM/Xm25JHFwhuFcKDejoDEUehe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC/5XPzQhEry9+WPEKVTgobXI7ZtbaAla7/lEZ4/klXr7xskxb
	UU1vInN44c/WxJUKLtU9y+xnw2iEGI9mhLQ4ZC2eJtQMtVvN3hqvaxiPRZCvtvuQbaXHAP1dMhI
	If3LrXoiSmjc4HX2umzQwTCI+6QA=
X-Gm-Gg: ASbGnct8pb5QcheIYWGyTrfnlaqTATRv0/Ts2RFukhTj9OQTrKaWvuU97IUJUiwLzDY
	vMsCCr9dWL0yR52y8PylfZt4quyMeKBpkU7tsqyrSIk9Ye583K6OnBp1VScnwOZDYT0s3qjDnsA
	Nsq48OzwA=
X-Google-Smtp-Source: AGHT+IF03jpYDR6bCisrsUhFC8E/DfFr3s3Tt8qsVO0zmC7ojxOYgj0ndtm7LNnO+jHKPERZceQNcdO44Vf1A20l6ro=
X-Received: by 2002:a17:90b:1e46:b0:2ee:6a70:c5d1 with SMTP id
 98e67ed59e1d1-2fce7b14ce7mr8428363a91.3.1740414252306; Mon, 24 Feb 2025
 08:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <Fg4QliwzbHj3m-Fr3ZeUiU11d6Bu-I7w_9xzSsnDlzQtqCkjgqxJpI6_YxuXnB8m0MqESq6V7vK7FhPnEcvGwg==@protonmail.internalid>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
 <874j0j1nv2.fsf@kernel.org> <Z7yUTNEg6gMW0G7b@Mac.home>
In-Reply-To: <Z7yUTNEg6gMW0G7b@Mac.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Feb 2025 17:23:59 +0100
X-Gm-Features: AWEUYZm0lZOEykvMW5AYszhUv7NNzoN9gkGQEc0C7vlcjcVMVXpA0B_ikKmgKBQ
Message-ID: <CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:46=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Why do we need this new kconfig?

I suspect it is to provide flexibility (i.e. to avoid building
everything if there are no users of the abstraction) and/or to limit
the set of configs that may be affected by a breaking change on the C
side -- Andreas and I discussed it the other day. The description of
the issue has some lines, but perhaps the commit message could
clarify.

We have a similar one already, i.e. a "Rust-only" config, in
`CONFIG_RUST_FW_LOADER_ABSTRACTIONS`.

Since this one is default "y", it may still affect unrelated
subsystems that just enable `RUST=3Dy`, though.

(I guess we could consider `select`ing from end users. But they cannot
be hidden symbols, because that limits the control too much (e.g.
someone may want to just build the abstraction), and in general they
may have dependencies, so it may not be a good idea.)

Cheers,
Miguel

