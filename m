Return-Path: <linux-kernel+bounces-312816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D30CD969BFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2AC1F24895
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15EF1C987D;
	Tue,  3 Sep 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOHqjb7E"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA761C62DB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363358; cv=none; b=thdKm36IkJtCNwOr+1QmVRgCeZ6vPJdJ5EwJzLE3YYz2l9DfzLuPoua9Y+47C7BK5cpP4e5GbEKwkZPbcctDZuna59dIaxlX7u6i9iHtWv+bSl2K7m60zKZzToS75vC9y/GQhh/jgMRfOCT16Q+SeTnhoo5muIrgSXkGFeMmBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363358; c=relaxed/simple;
	bh=bT4RGC2/CI90zsMbK3CXEI/uSpQdMQIiJJS3i73fW+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKXIhYZZTcSIofCdunM4I4mvr49/ErHFOGL4ZCSVryKWL5ohQnzqeAdlz2zyG+lk5lXFWC2I45AxIu3VL0VSTpTcbsOFb4xGrqJ5vvLCYPhgyNFatYt+KP8nIncudHcr/uZ5bakLBjhJi1JcvQ+6QUL/Mwxp6EIb95q63m7E04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOHqjb7E; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42c5347b2f7so28338125e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725363354; x=1725968154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEfBb5av8BFTOtupO7uTtvSgIG4RHj+5V1mUmY2oDqg=;
        b=TOHqjb7EGUzXr7ryAcjsxPmAL7Tb7uKEpUJb7qJA/tgZn/URRKaUzFyDKpRkRNXEhi
         mqNsESbDFPgObUo/6ZmflEIkgdBXpMeMowOISK6iukvTNclTskdv8Ygcrs6vrbJ0XhAX
         ExuRrS0fYQXB7nxwBjXyXvA+4Z6yVDf5nz4yuYx6rrF9H4rwvjXzOcsT73nqs7pMgXQ3
         u2IKfk42qVvwdncaOoGlHRcWtTWjUIuxQ1s+qod4elBVOvWgpGIuNBwEQDWqso4XGS61
         QDmqC0a4dcpPeEWLcq9H/qAIXMynKvsQ/zGPlur/yxow2TNMtzC8FCO6oohvUZa3etaD
         +8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363354; x=1725968154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEfBb5av8BFTOtupO7uTtvSgIG4RHj+5V1mUmY2oDqg=;
        b=NMhDkzfWR1nMsizrymfyWglPx55ov2nLxJUfK+rodDTGLOJoLUKJfrcJ6d40b5UQZQ
         cTSieSaGO39tdXIP7agf360eHn4Blwaerd6I/hkIpyhjWjB3Ykj7edVwXQQT8Gx1HA/0
         V7kerPD85pDCu6ACBSKpUWw60JkxmzO2eFvVTWb1/X9aJWYZLV/nQWYaWCMduQs47gWd
         qwCIt+5F6ixlKsTKqMNFy85o43DiNuGSFmP6n94M2v8KxoBQ91z2YU9zbnTIcw5a35jU
         LlzC9/wbwtCJMCdydvnJLi6Z6oIBQ3H/fYI6Nnf74PK+7aqxf0iiV6kA2rZ5B9CpYSQG
         nqDw==
X-Forwarded-Encrypted: i=1; AJvYcCWvn+Mh/f3GgoSkvicsLGwjhMRn8rr2J85AqWJtlEB2sn5yuXw+/is+YR2ljdHvZNAwd0/r5oUSAHfM0Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBymGmqHCLdNQnoT1ndzVW3vrILAu8Bz+BF6A+Xjfpo92k/U2u
	686Vw/D1ekUinvA3lmnfjOxuhIlovV1mLMN8nu5sjtZKe4zf341UV1tRwTOV8DToCiYCbei/Mn3
	zgvzK9PSp6n6uytttcz4qAesXNexZV96yweF/
X-Google-Smtp-Source: AGHT+IF9EQsoYXne6eLFgLTZXI3J+dUe2SLFltUotHmh01fE8kD9sVslO84tO3FvbvFkH2w8hwfuP0jI+0CAeaHMDUg=
X-Received: by 2002:adf:9bde:0:b0:374:bd05:a074 with SMTP id
 ffacd0b85a97d-374bd05a0cemr5743763f8f.12.1725363353295; Tue, 03 Sep 2024
 04:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902165535.1101978-1-ojeda@kernel.org>
In-Reply-To: <20240902165535.1101978-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Sep 2024 13:35:41 +0200
Message-ID: <CAH5fLghEz-6HtcpD5N8qXHZt8AK-8DUXHKXbHgs0YQ-pTJrTtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] `RUSTC_VERSION` and re-config/re-build support on
 compiler change
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 6:55=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> This series mainly adds support for `CONFIG_RUSTC_VERSION` (which is need=
ed for
> other upcoming series) as well as support for rebuilding the kernel when =
the
> Rust compiler version text changes, plus other secondary improvements.
>
> v1: https://lore.kernel.org/rust-for-linux/20240808221138.873750-1-ojeda@=
kernel.org/
> v2:
>
>   - Dropped patch #2 "kbuild: rust: make command for `RUSTC_VERSION_TEXT`=
 closer
>     to the `CC` one" (Masahiro, Bj=C3=B6rn).
>
>     In other words, now the `RUSTC_VERSION_TEXT` command is kept as it
>     was, without `LC_ALL=3D1` nor `| head -n1`.
>
>   - Replaced `macros` crate dependency with a comment in the code that `f=
ixdep`
>     will find, since we can do it for that one, unlike `core` (Masahiro,
>     Nicolas).
>
>   - Added patch (here #5) to add a warning when the Rust compiler used to=
 build
>     the kernel differs from the one used to build an out-of-tree module, =
like
>     the C side does (Nicolas).
>
>     If the patch is not wanted, then it can be skipped without much loss,=
 since
>     anyway Rust will fail to compile in that case. However, it would be n=
ice to
>     have to prevent potentially unexpected situations and to clarify the =
errors
>     that `rustc` would emit later. See the commit message for more detail=
s.
>
>   - Rewrapped comment to stay under 80 lines (Nicolas).
>
>   - Picked up a couple tags that could more or less be reasonably taken g=
iven
>     the changes to v2. Re-runs of tests welcome!
>
> Miguel Ojeda (6):
>   kbuild: rust: add `CONFIG_RUSTC_VERSION`
>   kbuild: rust: re-run Kconfig if the version text changes
>   kbuild: rust: rebuild if the version text changes
>   kbuild: rust: replace proc macros dependency on `core.o` with the
>     version text
>   kbuild: rust: warn if the out-of-tree compiler differs from the kernel
>     one
>   docs: rust: include other expressions in conditional compilation
>     section

I re-ran the same tests as for v1.

Tested-by: Alice Ryhl <aliceryhl@google.com>

