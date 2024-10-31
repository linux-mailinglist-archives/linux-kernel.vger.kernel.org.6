Return-Path: <linux-kernel+bounces-389782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A8C9B7139
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06111C21028
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2081F5FD;
	Thu, 31 Oct 2024 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me2qE0hM"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8217991;
	Thu, 31 Oct 2024 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335312; cv=none; b=B/LIVO1wuE8tTXccGMwIc1AaOrAbfJARwrq1P4bjEy/ouyahd4EeJjUnVPSGXMhpBhs8mWE8G+YVqW8AYxVXwCuKIxrFprBTgvSQTVDRRuuznn3jCRNNNsbJQB1LgKkjiXAm2n7+JY6VQhM5SsjrSoPjvKKfmyfEWdC8W8aJabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335312; c=relaxed/simple;
	bh=qA1rYBoTcRGu4j/brwnbXznrXHIEbVFk3fpviSwXAOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6r9452eBEYwzmW763gLWv2xkp2OIumie2YtkrI6Jp4wBLr8oYCWLR3rEBqp+g4jdydn/8vmDPC72bQlT8E1jpnvUtA+bzBY4TiaY6lYUY1SHkl88Pd7SzNNcM47k/+U7t4yIbzlmT803aV477U++6gdPDoL0UJUgCRlsx8c47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me2qE0hM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2d1b7bd57so59477a91.1;
        Wed, 30 Oct 2024 17:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730335310; x=1730940110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA1rYBoTcRGu4j/brwnbXznrXHIEbVFk3fpviSwXAOE=;
        b=Me2qE0hMyl7+XHSRyNetog+H1FcStNGG1QeWD6kJDn9yaXsq7gy7zySxYA2wrzpaa+
         Ki3HV73kP7AHtIFZUT/k+d/bxiVNksqTvdTbpuxCe+BN6cZShZyUkiPtTjiDz0eje9ZB
         zXks1Sz6HB9PfO/3u14r6g3TMMvMeAePRZ6NmV5jrCWd0idYk0K5dTZADpOQBJ+TRkIe
         hs5/IG9NoREkwh9scF4Po9QQeAS0bv9LV3SRcgqJYYxjN/k48oSK+R7ByyGdQ55ji+JQ
         D/lsOgjrDpOqHxqpXUmpS+svIVwSTeN69dpigshaLgk8mCVszWixfCqcuwZURd1xLehn
         8v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730335310; x=1730940110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA1rYBoTcRGu4j/brwnbXznrXHIEbVFk3fpviSwXAOE=;
        b=w4b+zDwefBJqFxQPo3aRREmRnk+B9JKUm0/K4+1BB8QjFA7Xp809406a/F5EkT4hw1
         Mn9fJnSxDzLoXYzNvz9YBVU/K7aB1NpgEmPt5W/P51Qjb2aY6jHkqw5/OGeut1QBGCb9
         AndS9sfFd+T+5wWGdjqu5UBInq4umjjAnprFXE9NEMoj6wez6rg1G/hQoElly6cEzMwP
         8sYS8UFTCdkUIBqL3QYJbWwfr5f6qUnihfGY3q8EEPpBUsksEsbYd2AI5plTF+VOMcrO
         bTuovbCP0gpxEbavc3A26chhclj5zNCVPhW2/2TsZZhVxtICjwUpmHM2UrebAqI6iDt0
         GFKg==
X-Forwarded-Encrypted: i=1; AJvYcCVzyRMf7euxJfHQZPCua/cG+4PKEXv/hYResZqq8vsHlHXQUOz6rOt5gBuQ/PDt0qoRZgIkR6feFkkG4AYpsd8=@vger.kernel.org, AJvYcCX7StFzbBCxuPZ8iceHMYx0VXnfXx09wtzmdMuKvBIRYajB4F014My1Y21xXyrKrIKL6BabeWIUh8wmP7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWD+73QG/cVevFE5hEfdt4N16/56/bbgqwcYCzrRPQj4JwfqZ
	up5qkDfLxTxGu6FOhAlp/Ox9Z9Ati9blFlJyFrB3Q8s9pclSF8JdbmUX4dT4aPe+G4p48v2lYOC
	0GI7VOnT/Vq2TjvuzRgTwGuIOGl8=
X-Google-Smtp-Source: AGHT+IHhV0Xkp1Tr39p6coxF85Ir1uMvPPvrs9jINbR+k5GV/0iQHouMzFAY9zvvFItUs3YR8ROUukzamuV6Gzynz0E=
X-Received: by 2002:a17:90b:3594:b0:2e2:9026:8bee with SMTP id
 98e67ed59e1d1-2e8f12e2bcamr8883272a91.9.1730335310165; Wed, 30 Oct 2024
 17:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-cfi-icall-1913-v1-1-ab8a26e13733@google.com>
In-Reply-To: <20241030-cfi-icall-1913-v1-1-ab8a26e13733@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 31 Oct 2024 01:41:37 +0100
Message-ID: <CANiq72nUBuqbKm6Z0mWRcZ_J3=LOEPEdTiPEq3vYTWtrfLpwvg@mail.gmail.com>
Subject: Re: [PATCH] cfi: tweak llvm version for HAVE_CFI_ICALL_NORMALIZE_INTEGERS
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 11:31=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> The llvm fix [1] did not make it for 19.0.0, but ended up getting
> backported to llvm 19.1.3 [2]. Thus, fix the version requirement to
> correctly specify which versions have the bug.
>
> Link: https://github.com/llvm/llvm-project/pull/104826 [1]
> Link: https://github.com/llvm/llvm-project/pull/113938 [2]
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202410281414.c351044e-oliver.sang@=
intel.com
> Fixes: 8b8ca9c25fe6 ("cfi: fix conditions for HAVE_CFI_ICALL_NORMALIZE_IN=
TEGERS")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

