Return-Path: <linux-kernel+bounces-271836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA99453C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B041B233A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2614AD2C;
	Thu,  1 Aug 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1S64wZUr"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4557C4087C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722544421; cv=none; b=dJL6ozobC5RqqjYgw0kKW9H3Dr4RCUh6GhDWLij8u12P0JoC4tBC93KSBriNiMq+IHp3mK+nX8J3Y7yAs2pZCSBsygTRsiXgs+9pSTPRSoDvJRP+BfK1FCKw5aObfgqcefuBiuNaE1+jpHcNne+YK4nZIiNjNW4mqCYu8RUHiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722544421; c=relaxed/simple;
	bh=uj3FPwEIG0xfFR02AOfEaaHGXag/9QLqipufHIU4Zg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6h3nYQvWmm6iyRhss9uDychgyM05j4M/7CotiA9zT6q4EGnrvqyODD99YS3Z/t0aM6cCougc2vWdvAjOIxbIKEDh2HISVV7CElULv63A+/EWYXw8VMkoX5Ih865MwWp7QgoAp2rkY3BYbD9V616whYX9cQW++OysfSjNlBThww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1S64wZUr; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7a0ef0e75so42821046d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722544419; x=1723149219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4LGUqfUQLcaI5k3gnfYaAsiGSEmX4XZthqSuVaynW0=;
        b=1S64wZUrN9QvfqICVzOdMAgivDxNlDPBenaSiM70h6WY/ufwWA8Z04cnOQzQjBlNZz
         TRhLZoskzQhmYoLIZmzJpiPnIzqij2A1FK/aJqJaBYopn2nZQkEV49OAsknzljZGLGvl
         IWp1SkMBL4V1/QxDuyZhFtJnE7i6JiyIC8mWua2xFCp3Tht1N8WB8BZXU5BNm/h1rnD7
         IA6r76Q1RY5X/FhpMZUdGLc+vrkOXnKTALE6vrIJWkFVzb5mkXbyt+YxO5RBAQ0QVoD3
         wFFJi3u7Q24uPeEX4dQFT/bN6eu1flP0kHpVH6cIiPqW9eWPM6cxp2nXTaAodDtaLA5I
         x+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722544419; x=1723149219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4LGUqfUQLcaI5k3gnfYaAsiGSEmX4XZthqSuVaynW0=;
        b=tWX0WZwPDtZRI2RzG56PeCQNfwAUggToYpxDptZrFTzJR0MmTRAFuxPXEgfD1efcb6
         /39240xQOXuTI/BysLoNum6DO8G+/kSEPL27FL514dr5M9qvp4RMTLS0R4JBeRtHowFQ
         Sg3IhEw7KS2jW8D1EIugbuh2l1Lm6RtiKVeWByWBQ5a3p5ZFSnM2YO/Ur5za/4VX3MWC
         kKwqGKRQWcgz7A9P2e+Z3lUHDe4jqYbUjxwWp9gUm8XYKXPJqvA0dEdKrQDEzO8yDeG3
         ldR2ltvWy7K5M+wC4e33429IGpKClbmVlTuEvwIajIfwh3wq4F9uuWg0BAMbanjchD+l
         E8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeIwx70ZCgT7W8wyINQ9ulffrsJFzmFRIvB4G1RPsJek62xFwE7St1oyJtsYfDNEcax6gULnmKI99s6C129pqc2ZO9hDEWgCgicuYu
X-Gm-Message-State: AOJu0YzJgCVx0VQOsWfW7KqSHiIxMF8YBsIpQD6p//8VJv2M/QyW/BmF
	wRfV8r8u3dvVn06gbrXCjcHzNJ2NouGZLileLMP+LD4A5EKvdx8uhwHNqVq7AK8bO8dbb0AtXOK
	inQL/VcNA1m4D3O0JnCTcX1r2FL99Wg5AAkjh
X-Google-Smtp-Source: AGHT+IHRRf+iCcZWfIUk8eMRP01GYpsdBtZcRDR9lDO2O6lJi8LWaU5YtyCRFpNWDktDnSX3GuCXW/wCS7u9+pP4Sbo=
X-Received: by 2002:a05:6214:3103:b0:6b7:b08e:e795 with SMTP id
 6a1803df08f44-6bb9836b891mr13930256d6.25.1722544419100; Thu, 01 Aug 2024
 13:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-kcfi-v2-0-c93caed3d121@google.com>
In-Reply-To: <20240801-kcfi-v2-0-c93caed3d121@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 1 Aug 2024 20:33:02 +0000
Message-ID: <CABCJKue_8S8jJ1b5RRHGjnqpq=u9KYf1SjPTyS0NCWS4TthUQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Rust KCFI support
To: Alice Ryhl <aliceryhl@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Maurer <mmaurer@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alice,

On Thu, Aug 1, 2024 at 1:35=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> The control flow integrity (kCFI) sanitizer is an important sanitizer
> that is often used in production. This patch series makes it possible to
> use kCFI and Rust together.
>
> The second patch in this series depends on the next version of [1],
> which Miguel will send soon. It also depends on [2].
>
> Link: https://lore.kernel.org/r/20240709160615.998336-12-ojeda@kernel.org=
 [1]
> Link: https://lore.kernel.org/r/20240730-target-json-arrays-v1-1-2b376fd0=
ecf4@google.com [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v2:
> - Fix for FineIBT.
> - Add more info to commit messages and config descrptions.
> - Link to v1: https://lore.kernel.org/r/20240730-kcfi-v1-0-bbb948752a30@g=
oogle.com
>
> ---
> Alice Ryhl (1):
>       cfi: add CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
>
> Matthew Maurer (1):
>       rust: cfi: add support for CFI_CLANG with Rust

Thanks for sorting this out!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

