Return-Path: <linux-kernel+bounces-341108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0758A987B62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4B8284858
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13431B07A9;
	Thu, 26 Sep 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bc6cYDys"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA31AFB2E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391269; cv=none; b=MTgJ+FH8nEHWZA+FdcSLHBfQTA+aY5zx9RA/vCa6ncbEbp6TlbhN0ceD/egzJPjYrUFUfUYRKCIFiafMbG3u9aG+RWCnV3bvkx7FNz4zb5TUEEInxyyfyJA37q1XsE+XHkJ6uAu5iMJN/fAALnK04zbj7x26vXr1PDEKn8pYBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391269; c=relaxed/simple;
	bh=YuvKxWBIf7PNXBTj+RM1pbAN0oV60CL2MBBZiDs+evU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skfHMos4ckF0/hC1BbxjAtEaPjOBgwe0Dh9gx3GlfHwzsbhrxuVeVSyxZ+LtGSS3LeiGb4aiNDTTUCBe5jba2tYPkX16hoOc0NiivR/EbR0w36maSO1cLttAF8AddcRvRSE50JPbtRpKYD4qf2sQ6lMW4/hQgcf+DqoSaTQEKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bc6cYDys; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582a5b495cso60941cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727391266; x=1727996066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl35wLMOPE0pkWqTWWx9ZXc6WTLidbwzi9Ei5sRpi+0=;
        b=bc6cYDys6zAG1+ILi2ilodlVaOpgELYU/EGY0zqehDIsl8BL2XRWNTfGVBuSCmfyAb
         fJ8H17IUerhohL6ZneXhDZF05P/16ovxaDSSA/fUKpsPFwDJGUziWMtvnI9OBvoUMBpn
         OGjSuxdztE0TV23wz/hVm7EZGGUDksTd+mS6os9uLOB5gJGusMQhQnUHm5OVI5zzaiMt
         qO7gSQfSuUdRstpjgBtHbQoB9sPxPAH1ztWfTy6Sdky/G0rO2ja4reVQQ+vA3urCPqJp
         nYduI+5W46GbLN+LNoksEWIxwc5H30wbHHyk50shQmTPK5+vW/XSdL3HMVSUTCPUCfUH
         JVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727391266; x=1727996066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl35wLMOPE0pkWqTWWx9ZXc6WTLidbwzi9Ei5sRpi+0=;
        b=g+KBXxVUdddRlQyTq/Ec0UPOOX+IqfwPOpW/T6vD5FJptF53yE8MubRFApRR5thAp/
         XOplXJ/WPURNZRgwqx6trsXmFpa0Z82W/gffveYdE/ZHLSow/1HJXdaKY+lOxvffgDfi
         kpNSbGwmLQv7J4vjRokXDv7sPWR3e5bkKcrY9S5LebhNaAjksaUyNErCdJMF7oJIhPPN
         EMljx2Km1VvsYJnxLJ/8w5MP05IeBTlssEqkKBS0dRFPLu3/2nqEtNNLldFB6+7e83hT
         HYEBbi2ZgMRorRQnrkyYNgvA549HuzB7oluPT391yJA8iByj0Dpj9UGgj+uuXJeImBOF
         Ihzg==
X-Forwarded-Encrypted: i=1; AJvYcCXHGEAX4IzGaNysoAW0uG262wnFDKhp93XKLCqSxki0ibvFPBLseC/Bxr4Pep5PPUcZwdLKLt+916euYlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkTqYbZ3/pR8j4bml0jkjB93oKAuOht2rQz8tg1ZqljM1+X3k9
	3L7sOc0hwYzr63LWtyadkjZfKtrJA2TpgNldUGclRF1PXIgyjQrLL60cK9PIh1fLbh+mZJLAjF0
	h5N0rSrtM0oe40qBStCUKFGE18pPplFQ7m7i9
X-Google-Smtp-Source: AGHT+IEUgS0ctjnhwyGFehblCt5Cuf6U9AZbfKffDPTgdSnQTEOj8Qmniu9tARJUyM5u8ykfq5FPxoUB/AlQ+bM4WgI=
X-Received: by 2002:a05:622a:a78d:b0:45c:9e26:ae3 with SMTP id
 d75a77b69052e-45ca1b03e0amr517501cf.27.1727391265943; Thu, 26 Sep 2024
 15:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 26 Sep 2024 22:53:46 +0000
Message-ID: <CABCJKudA=EvCE7vv44VDMqHjFv+5vyJ1ZfqG+TSPc49vtmT9RA@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Extended MODVERSIONS Support
To: Matthew Maurer <mmaurer@google.com>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Wed, Sep 25, 2024 at 11:39=E2=80=AFPM Matthew Maurer <mmaurer@google.com=
> wrote:
>
> This patch series is intended for use alongside the Implement
> MODVERSIONS for RUST [1] series as a replacement for the symbol name
> hashing approach used there to enable RUST and MODVERSIONS at the same
> time.
>
> Elsewhere, we've seen a desire for long symbol name support for LTO
> symbol names [2], and the previous series came up [3] as a possible
> solution rather than hashing, which some have objected [4] to.
>
> This series adds a MODVERSIONS format which uses a section per column.
> This avoids userspace tools breaking if we need to make a similar change
> to the format in the future - we would do so by adding a new section,
> rather than editing the struct definition. In the new format, the name
> section is formatted as a concatenated sequence of NUL-terminated
> strings, which allows for arbitrary length names.
>
> Currently, this series emits both the extended format and the current
> format on all modules, and prefers the extended format when checking if
> present. I'm open to various other policies via Kconfig knobs, but this
> seemed like a good initial default.
>
> The refactor to MODVERSIONS is prefixed to this series as result of an
> explicit request [5] by Luis in response to the original patchset.
>
> If you are testing this patch alongside RUST by manually removing the
> !MODVERSIONS restriction (this series doesn't remove it, because the
> CRCs don't mean what we'd want them to yet, we need the DWARF patch for
> that) and have kernel hardening enabled, you may need the CPU
> Mitigations [6] series. Without it, the foo.mod.o file produced by the
> C compiler will reference __x86_return_thunk, but foo.o will not.
> This means that the version table will not contain a version for
> __x86_return_thunk, but foo.ko will reference it, which will result
> in a version check failure.
>
> [1] https://lore.kernel.org/all/20240617175818.58219-17-samitolvanen@goog=
le.com/
> [2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org=
/
> [3] https://lore.kernel.org/lkml/ZoxbEEsK40ASi1cY@bombadil.infradead.org/
> [4] https://lore.kernel.org/lkml/0b2697fd-7ab4-469f-83a6-ec9ebc701ba0@sus=
e.com/
> [5] https://lore.kernel.org/lkml/ZVZNh%2FPA5HiVRkeb@bombadil.infradead.or=
g/
> [6] https://lore.kernel.org/all/20240725183325.122827-1-ojeda@kernel.org/
>
> Changes in v5:
> - Addresses Sami's comments from v3 that I missed in v4 (missing early
>   return, extra parens)

v5 looks good to me, thank you for fixing these issues. I tested this
with my latest Rust modversions patches [1] and everything seems to
work for me (on x86_64, arm64, and riscv64 w/ clang).  For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>

[1] https://github.com/samitolvanen/linux/commits/rustmodversions-v3

Sami

