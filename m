Return-Path: <linux-kernel+bounces-355712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEC69955F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38A61C259D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCA620CCD7;
	Tue,  8 Oct 2024 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4zB1Ocpr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B320CCD5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409613; cv=none; b=SA/gy8JozCkF+khXaGCHfWoAW2Bw+YPNBst2Y8kcqAyx1REQCL1eBsb/KW58Nc3yUjEJDc2Vw5hqgdaMhTVS6yKhaBM8yOqxDVNkSTSqyHVyK6ghsNQXyMGc6o5q0On6KWJpq7pWkG/rZzPyt0k/4Vd0f3ahz/YRPIwpWMZCAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409613; c=relaxed/simple;
	bh=4X3HDuD2VnWtaf+tW+I5S2mqufTmgR/niQRbWK6L8T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfvXX+5a0DH66Ve1DuNkiL4+khjS0vUhpBFMxkdSPLHQpAxTR9Xrw2XWopAysU/T9HfXZmHetWLHVCXyvawxiIo/GVGNvxfo9Bc97Q1KaKmqMmapn6ueUbMxWJcX20/ouC+tOrMAKlGYEaReVQeeqXZgcKva5VfLNddj4yghdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4zB1Ocpr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42f6995dab8so28495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728409610; x=1729014410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvhMia/mJ061vWokn+L348+3EuZws0Igoktfqv3fLi0=;
        b=4zB1OcprxZq8kUkV4SrVY6no0n5qoaNba0zZ1Wz4ud6E75s06pNCPw3Y+TvjF2Z6st
         /961XbXB+vY42AYJddh6yNUwK7cLBSEfKYpPHoZo42JOZApN6LIQ3rA4RUstVad7Yyyb
         inet7uLyyOR2jXfX/ask4rkSN7gNhEs9b8eudnaS91KRgELQT+wqPvuNv9x/UI1Pegbx
         ojULNVRjj4gtyJVQOorV4wd35qqPB85U+w/Wq2veqJlzRFSm8w/7Nr24Bt3NxnsiPCK4
         5N0z8dCE8Bxe7vks8s8Wp60tu41qBsyWv1w9I70dDC+kuOB+ftTPJzt4g57A8iJgH2et
         MfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409610; x=1729014410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvhMia/mJ061vWokn+L348+3EuZws0Igoktfqv3fLi0=;
        b=ukoN3UXfJVHhXm3/iSjMGhSic76vwc5RLkAlSmVtqenpezwttNXrlv7mS/I/1wIDso
         TVPzUHd/JbvfgvDPx/cIn3hMeZOWml6CmzgDCTGDk99kE3TDZHNbffyN9mmv8oDvH8y3
         oXYoC8lbpoN0fP453oohQuGo+GyyogMk8s3ofEM4p9GwKi1bAHr6MjjAD/Ui6xDTIbch
         veQvTYFLbbakyuLVvjdFtukKSBZ8Y56iK9f2eS3QwMhh2sj5FtmGujiwCYEaTY2V4/V2
         YSVnhhOfn7GTfxSEFLEwEqXzs3kLJMsh4TO5QWVqHpRlHb0KYQFWDrmenL+6OzpWg4op
         UtJg==
X-Forwarded-Encrypted: i=1; AJvYcCU5/5xIIA37XA4+MrPiTA3waCVt+atAkyG330IKfDvJ69Ngh5TxhnzYgQGV32nz4r95/y3ReIJdSbBHtK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UcsK60ldJi+IjsvD3zuM3wYNLd+hz0VCdEWsLOAhOSXjfgTf
	08uj9csGDgAlhgM9DMqmGLkM5U/99NxDYU/LRb6rKENF5fucXMJtDaicSmrgNAtBTeK2k4PEfnA
	mflSVRCMeD7KHJ1ATTyjnLlpYlOkT8WaPAFDb
X-Google-Smtp-Source: AGHT+IGQnxUu7S8sNprAY4+irLZJ3ENfCBPUtxKDr44Y0O32/q5eFiDbTpcEReOVOk7pxJi5i1xxWZIhi8Fss/s7Cvw=
X-Received: by 2002:a05:600c:34cb:b0:42f:808e:52e6 with SMTP id
 5b1f17b1804b1-43058d748a2mr104025e9.6.1728409601402; Tue, 08 Oct 2024
 10:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-cfi-fix-llvm-gate-v1-1-32d47459eee4@google.com>
In-Reply-To: <20241008-cfi-fix-llvm-gate-v1-1-32d47459eee4@google.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 8 Oct 2024 10:46:29 -0700
Message-ID: <CAGSQo03ZOppScZT_1DuWYsnveKvYHdc-K_djHi=AB4CKjAbgyQ@mail.gmail.com>
Subject: Re: [PATCH] cfi: fix conditions in HAVE_CFI_ICALL_NORMALIZE_INTEGERS
To: Alice Ryhl <aliceryhl@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This makes sense, as some folks have a Rust compiler they know has the
fix, but build system detection for it isn't there yet. This lets them
override availability if needed.

That said, we should definitely be sure to get this back to a
non-configurable toggle once the LLVM version detection is in.

Reviewed-By: Matthew Maurer <mmaurer@google.com>

On Tue, Oct 8, 2024 at 10:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The CFI_ICALL_NORMALIZE_INTEGERS option is incompatible with KASAN
> because LLVM will emit some constructors when using KASAN that are
> assigned incorrect CFI tags. These constructors are emitted due to use
> of -fsanitize=3Dkernel-address or -fsanitize=3Dkernel-hwaddress that are
> respectively passed when KASAN_GENERIC or KASAN_SW_TAGS are enabled.
> However, the KASAN_HW_TAGS option relies on hardware support for MTE
> instead and does not pass either flag. (Note also that KASAN_HW_TAGS
> does not `select CONSTRUCTORS`.)
>
> Additionally, the option is configured to have a prompt and gated behind
> EXPERT. The previous method for a user override of the option did not
> actually work. This is expected to be temporary, as I intend to add a
> precise detection check for 6.13 - I did not included that here to avoid
> adding a RUSTC_LLVM_VERSION config in a fix.
>
> Fixes: 4c66f8307ac0 ("cfi: encode cfi normalized integers + kasan/gcov bu=
g in Kconfig")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  arch/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8af374ea1adc..2632de28c05a 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -852,8 +852,9 @@ config CFI_ICALL_NORMALIZE_INTEGERS
>           This option is necessary for using CFI with Rust. If unsure, sa=
y N.
>
>  config HAVE_CFI_ICALL_NORMALIZE_INTEGERS
> -       def_bool !GCOV_KERNEL && !KASAN
> -       depends on CFI_CLANG
> +       bool "Are normalized CFI tags for integers available?"
> +       default !GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW_TAGS
> +       depends on EXPERT || (!GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW=
_TAGS)
>         depends on $(cc-option,-fsanitize=3Dkcfi -fsanitize-cfi-icall-exp=
erimental-normalize-integers)
>         help
>           Is CFI_ICALL_NORMALIZE_INTEGERS supported with the set of compi=
lers
>
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20241008-cfi-fix-llvm-gate-115e48d6acc9
>
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>
>

