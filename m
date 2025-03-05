Return-Path: <linux-kernel+bounces-546834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34420A4FF41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F67B16CDB7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748D42451C3;
	Wed,  5 Mar 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4yneXUY"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456EC1E531;
	Wed,  5 Mar 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179646; cv=none; b=a9+y1tA7FJBEiDkTo5T3HCxcGe2X+TDbb25M5awo0b/9IkVViJaoLjn4wrHf0Oq1j98eIQnvOrPsJyLXhI8bXE7c6rjgj/BecGtLrZDR5tMO6TGY9U4QEeRgpVXrZ23RMXg5IucHML7Ad8DFnA7W+ZyMnq7F1oDo6NcDD5M/4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179646; c=relaxed/simple;
	bh=am38cV80OHA435HwJkqLyIVBRjkmsPfRrrnlE5GXzNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbNaG0vevmLy1B25wK4v3BPS4OR9NAz8zto98dp+BIF/jJx50fAlTvvQUMUEphGqUlA+8X673pejMvCMNo+btaTfubgUbp1dpQ6+z6a67yC1tvAJogJz7eYD3mfxRsLAn0hkhWqkG1NAg8+wlJIGaY3UDSFyF9qjmUFYf7XMmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4yneXUY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5495fcb78easo681951e87.3;
        Wed, 05 Mar 2025 05:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741179643; x=1741784443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am38cV80OHA435HwJkqLyIVBRjkmsPfRrrnlE5GXzNE=;
        b=M4yneXUYVmPTTrDy/CEbwTNHQ68+wVOyhl96SlRiW44fIP0OwdZgc891hqBWAjDdOB
         x0wkk6TtbR7fhAGauIRRiQytErLNzrMdh2QESmIHDsIEpmUFstf+kFX8r3veOacP2u/i
         ebeK6v5Lm568EO14kBu7CvZqDtX1jPlTmAQve3kDMqapUGtwmplzHtDsjlpG+2zUa17G
         IR4nGW9Hx97EwFicVNRfqx8+/5MS/dj+5IbRYCh3uof7iXG6KitEI3hJ62vsXXASKUX2
         Fcq9Q3xGcMKFv7UIN5XO0i4nXMkqw8dQqLFbTTaEMX0Fw2cT/47l4n+Kf7T3RIO91Ai8
         yJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741179643; x=1741784443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=am38cV80OHA435HwJkqLyIVBRjkmsPfRrrnlE5GXzNE=;
        b=wVvXP58nXjvizDoPIIQYwrAM4Po1QX3/NqCcNwYFw7osgnfKlHzCaF+mFF7xoLS+Lf
         c1twHvtAairCcVXOo0/RT+3voPM1IKknemrGBZvQlKd0caN0VoHi8zg99iY/BjuOjXcK
         DfhQQLlL8cP8ZKAJXMpXB8q7cJQE5Oc1x115QEpYFVeysNcW3EGuxr6YGDXkN2roeT5T
         040f6DgmPgvcxw7eYHbd6M5IL7PUz56+XDEordcHK7aYgznX6E3qrTTWdLToq4cDUVIh
         ugDYY9HhnAgIFQ20+auZr/Q0ppYbc2okgoGuVHrVV4EEd8444VSIfNHiKYnWjMiYsWsm
         HlzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYJ3ERdZBoP2RokpcEojt6fW+Vg5wb6P2h1PINcoGFemjfVfqNPR3eGO56enm0u5Ia6mECuhhMvE7Kiuc=@vger.kernel.org, AJvYcCXJ3wrd7PX3BklpGZ7Gbicn0AZZboBMWgiDIMoI8F9NN24smhr5mrMBqtl2X0q7kzz3txT+qoY+4Ov95qGeO+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF53KExtahUrFCV+bkD90BhC5qyEXXQKtdsc20p/rtvq02W9vH
	t6d+GXrTVtkTty1q/XRvyYz/9SkpirSFlD7MmsjiZgPqdmMtuy/CWpqFkqK0H28h9Fgdyz5G/b+
	nIG8hsjmjcpfEfTDixy6ekhu31mI=
X-Gm-Gg: ASbGncvsj3kGi5bn+4/t4/UW6tVZ9s8a112Fta+JxpLFMCR9oGlSuiEdf7Rnc4MDFpF
	IhiQqehHj7ne/vX/8ebMsHSBeYvKbflxIWfzBsxU5nGKToRDBxNfQf2wGE71SL6Yj2fkYT91Ku8
	7uOf2gheEGOUOdQz4yWWaFqKG/Xw==
X-Google-Smtp-Source: AGHT+IHi9Kkx1vmghxcNkIJrkV3V9CV0qEWcoJi1Yg9qZ4APb3bN52o1c9uTuPuSqFLq/WFtQJpGFq68pksd0NGbOlI=
X-Received: by 2002:a05:6512:6cd:b0:545:fdd:9efd with SMTP id
 2adb3069b0e04-5497d38b4cemr397465e87.12.1741179643006; Wed, 05 Mar 2025
 05:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304225245.2033120-1-benno.lossin@proton.me>
 <sIa0gEFObIVkQIOds6BkLjVFyVpGcJ70lKQ6CC6zAjpKS4xGB0hcKqo170yhITiDQfjg7s2CigwRoJfJ2fFvmA==@protonmail.internalid>
 <20250304225245.2033120-2-benno.lossin@proton.me> <87plivg8s7.fsf@kernel.org> <D88CITPM946W.1O2W73CGF7L6G@proton.me>
In-Reply-To: <D88CITPM946W.1O2W73CGF7L6G@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Mar 2025 14:00:28 +0100
X-Gm-Features: AQ5f1JpTEVtGJwoxxfHELesckM-F1iyqJrCcykmaS3lg_v1VCy-BoQJQYQIpic4
Message-ID: <CANiq72kUwxNCao1-3AeBfzWQu5rjaHMMA6vzXXudD=5NxC869g@mail.gmail.com>
Subject: Re: [PATCH 01/22] rust: init: disable doctests
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 1:53=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> Thanks for pointing that out, any suggestions for this concrete case? I
> wasn't able to come up with an imperative statement.

Normally I follow a "Context, Why, (thus) What, Alternatives, Future"
format or similar.

The imperative is meant for the "What" part, i.e. the actual change
you are performing, which you already do in "..., ignore all doctests
...", so that looks fine to me.

You could just remove the first line, or perhaps move it and reword it
with ", in order to..." after the "ignore" sentence.

Cheers,
Miguel

