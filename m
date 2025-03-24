Return-Path: <linux-kernel+bounces-574310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE66A6E3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CFF7A227E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B1A19DF5F;
	Mon, 24 Mar 2025 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDWr3mpD"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABE199E88;
	Mon, 24 Mar 2025 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845111; cv=none; b=IhXy+1/XSq6oT8xLodLqFURA0rxzj4DqMBnZtUdSg6zL4vRy85wZlSNioxuQRHgsuhm+ZI5AAqKH8WOb/UNWDpTrW0lQEKYK8K0r5mYkADkni5QUBJp9FC+qGf9R2nNiiKr8dOsCMq3VKGWSBLvGIX21mRfpIptcTCRCM/YfhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845111; c=relaxed/simple;
	bh=g83wf0IEi+f+2DpKce8QxRkFG7Qa2QHDJEAGQpQF9DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ+7T8EgTR8vKBpra2jxYpK6/LlIBZH8q4/tUfaatABmsrupd1RQfq1M+PzB+XdSgOthAXu5rkTcqzWqE26R1K24GpYkkABheL09fTxnmiYeq6rGrxDfHXYq2COVFfWtFH8oAUEbx4WndIuw+QgAK5tMKvgXGH5IgpLTALEdNfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDWr3mpD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so1478435a91.1;
        Mon, 24 Mar 2025 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742845109; x=1743449909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/1WJJoHQRs17pT9/JxCO6Fw+nrbC0tR3gi1sviT9Qg=;
        b=aDWr3mpDuH/5xZS56lUR9b9/u/m3mLH4bVNn3De4+00wuHw4cXpHU/ERuiEosZiw/U
         rJnXTJ7dHVL4n2uSt2IVSX3O7fwIfhcefI5mlknmJbqt1g6DEpGJl/Bc0DPH0rB6U3ZP
         K/8DfapufjYjZwEc75UXeatCEO9pG22H9YAQHO6xwxd9luFOwzJOnD6mHI56eDyTNFOr
         Wq4ZWLWfJc1lHEhE++4Rr1JZZilg6CqfXr4Z150yNxLaAGXISKTh1eKf9geuhFEo3y9o
         uYsaCj5jAPYAdzgucm7PBjkICAoW3mAlohlRp7ilTiEUKQY3H80W77lEt2x1CrFrGWBn
         Jj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742845109; x=1743449909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/1WJJoHQRs17pT9/JxCO6Fw+nrbC0tR3gi1sviT9Qg=;
        b=AGEVkyu3GMaAq+IJ3wu9JY18/DXyWZbKo2j48H/NVQpp75WIIRGzOdX7fLArUOsiDd
         K+2ek+qhmoCvAUggCYNlgdmFx6cHJngumv3a+Eqc3z5MabdjAtBZrMdu3PumTL5agSXb
         w6f7gtQS3vDD+bJkhrgSo4bizSQDILBAZrg+aivvXmBsVvMUsHenD1OelIQFWo3eG9ej
         /ze9JZhX0Y8ejYz9pjY5GkrwksxoGPmV88biW9fRI9Mn/QrTDZUoYBDIOS/vinqcDXI1
         UMBYRS0lftwuSSoupotU+TP+aukoS/3FCTaOn0MxkEJd1Vzfo7rwbre+uNcj52m2wsbZ
         URrA==
X-Forwarded-Encrypted: i=1; AJvYcCUibhbaQ+bHvA4F20jWjxlp7LLTDoUVCsFqn2Bw8LoC86Sl8OZsq/iLXdGskTmwBtir69fgWdZ/lSIDvXQ=@vger.kernel.org, AJvYcCXV20VyHF3DP5C/sUYJsOHx5bEYQt5tn4X2cQNwuX4J6+AOfCBvtJP78EOVw9fa09rV1L6FOAhqS+4TZAcMYB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDRiUpGdbb0ASdH1XysX+JUTbJXupkHTemJLecdZhyRkeeUa1
	Jo8q0Im1fLOVuB18nBFKvEow36hRvuLwBlq9OPYslWVwfvPSPiNBUIKGJvE9mlCdnRgl3lj57Bt
	xjBc5HORvUTRG19jqcAuFB/rjkI0=
X-Gm-Gg: ASbGncvdXh8V/ZllyvywARz2FT/AmU3zMFvWd9TKQXCQf81+Pz5jXggHoS2CDv6kUFj
	uxgPkp0gipX+30ZPgDftlrneLP853FnFFolzNGDUeBccINYnIOR+SJExco47uMBmb+nG1WzJIXU
	D4c99LEJbmh4VyTdsJnFunII6ESQ==
X-Google-Smtp-Source: AGHT+IEMUSgfwqdKG7ewoqDLmuTi+jz5Z8D+a7P7lvhW95GrosUyZ6srAtGj1z0Sm9IhoTqBMT68weNwQYnP7YyHjjw=
X-Received: by 2002:a17:90b:1647:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-3030fb1fbc7mr7922237a91.0.1742845109433; Mon, 24 Mar 2025
 12:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-gpuvm-v1-0-7f8213eebb56@collabora.com>
 <20250324-gpuvm-v1-2-7f8213eebb56@collabora.com> <CANiq72mQ3zuYmsq1PD-49kKLNji8OJwuvxK5QWkNaBMuC-PHQg@mail.gmail.com>
 <509EADD7-607B-4DED-ADAC-152D7338EB50@collabora.com>
In-Reply-To: <509EADD7-607B-4DED-ADAC-152D7338EB50@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Mar 2025 20:38:17 +0100
X-Gm-Features: AQ5f1Jrk0Og2yGB9k38WW0Nb1tuHdGjlzNVcWtDKGMvkDWjXn2FYepG3LyWjwKs
Message-ID: <CANiq72=aVRMvOaU48DBLL=p+VoG3RvHK+K48XQhvHw3ARc0BNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: drm: Add GPUVM abstraction
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:25=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> By the way, maybe we should have a lint for CamelCase in docs? I tried my=
 best to
> cover all of these, but some slip through :/
>
> i.e.: if you write something in CamelCase somewhere in the docs, there's =
a high
> chance that you should actually use Markdown and link as appropriate.
>
> I have no idea whether this would actually work in practice, to be honest=
. It=E2=80=99s just
> a random suggestion (that I'd be willing to help with).

Yeah, I asked upstream if we could have something that at least
detects what could have been intra-doc links, because that should not
have too many false positives since it is a subset:

    https://github.com/rust-lang/rust/issues/131510

It is still tricky, because e.g. `Some` or `None` would need to be
excluded, even if you require the exact same case. So it probably
still requires extra heuristics.

Then there is:

    https://rust-lang.github.io/rust-clippy/master/index.html#doc_markdown

which is closer to your idea. It has a few false positives (e.g.
KUnit) from a quick try, so probably we cannot enable it for
everything, unless we commit to maintain a list of terms in the
config. It spots a handful of things we should fix, though -- I can
send a few patches or create good first issues.

Cheers,
Miguel

