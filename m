Return-Path: <linux-kernel+bounces-557149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288FCA5D441
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69C23B5C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E091448F2;
	Wed, 12 Mar 2025 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fugaGWXC"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF102D600;
	Wed, 12 Mar 2025 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741744601; cv=none; b=ld0eX1dkXUOlZSXkXm7oIDBHFbO4srfuEhEYSKeU28bf8TvnjUj6vkOPio/a5eyPhQ417d6DPsVl7XpyMOKRc9l/LQG3fUz4iP7qwZCBtxGEmsVsrsH4ZzcY1nQeO7n0Xw09YXVZXswMN5i/Nm7flgOcnWQuif59a9mcvf+V//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741744601; c=relaxed/simple;
	bh=i8z2Xb9lFxcMgAI2K80UrHzxA3FJTlfeKI/zXvLiMok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJqqzhxzq4192V58HDui+O8GTWRxdcp2rJaTgtLu2c9O4AweQsthKuuBA2EvVSBnxlg015/c7Z+GB6W8bxYyAW5vXG8OcQD02DyQ7AI3E0eSC6NBOgn8EGbkV3OvqzJv2TRVAuQ0jWIC0+kMG6oxh6e5g0G7EUwwLAnPUPLcaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fugaGWXC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fd02536660so1599712a91.2;
        Tue, 11 Mar 2025 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741744600; x=1742349400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhWzg/d0ytpwp9W4Azext2ZzMQHgy1fZGnKhTFyW2CU=;
        b=fugaGWXCNnRcR4mgC7K4mHNWQy+SVcA4cjg1JaECSPourlW09YG2/IE/0zNO1FaoHg
         zZlzu2XPSND6jSQxv+DZ3fErXAJNJlDVdu4KI33uDYYuWOT5AKTXmxax0SSjQYMVhzYa
         PVWu9+VULH024oksJv6pwTv0RjB1EhQXWbc52UkajdRbvMksat95Hohw5xbnxtuavWds
         tVhMF46O9nhtoTzwStupHYUXfnMDLaRro3EvjCu7vNGdJT7o4OzhTS5VDF8pe7X63TsU
         YGtLG19loogMDALn4IOi9l9dSFaayR97DAwM36KxFpU99QjKZEoBkkbH1t3981Ya/Pzt
         Yaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741744600; x=1742349400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhWzg/d0ytpwp9W4Azext2ZzMQHgy1fZGnKhTFyW2CU=;
        b=YsqWGaHBQYBGjNmdOqHHtvTKEUsyPFV7fIw6GLTHW/hHXUXF84yiFCu+eN1zo+nWbz
         12+4OJ709IqexlgvdsrqEJMR/0Vldv+2qost6cOWVGJ734bU6MjEG8Sxs+nM48/gu3UZ
         UnXWRaXloBX57CzGb3wGbI57kZDUaOaYXJ4Tpw1IELSKAahtk8Q0di4OZrDNk1k0LZS2
         AZBCONKTy/T8jEV45KDh2O7ejK5TwwQre4MvGVj0GvgSf6YlRwkc+C0GaS2PHRl0DMK8
         2AGvQB/CQzsAuY6wjSwBLI+3VKaJeVJTDzIucJW5Bh2N4AZDdIBeOSGnGDJU+JoIdPDf
         EuAw==
X-Forwarded-Encrypted: i=1; AJvYcCUvqiXDEMpFgzBAmMwSTQmkbJsTrYrD0YEMk/MWpp0urphtsHym6mcNG3m9JvNGlf8+LpNFBtJPVJT6A7Y=@vger.kernel.org, AJvYcCXCPhjlBxBRKqD5tzh4RiqB6mO1r/5+sLNg6+s/dEoAL92Q8ZcPnPmp7Sw9EXZ4i7NNgCpZcrLgTuxfjPnzhP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUFvaO01LgQ/7Ibv3rajdFI8KjzUmLP38KkXNKNZkcOVLCa715
	hyVpR0BrnfwNoXoVYLtDiFgldcovF8WC9nIw6mDtWUsY844wQB5dUibMwXpHsJB89mjQ+ZOTfy7
	7b7HnCjTHBe99f/L8kzzOVy2Eps0=
X-Gm-Gg: ASbGncsQnKq0FgSBUjJHbtCKav1mXoQvHApOdZc07/m0a5Z8V73WadAYImstHvQytpW
	G5hrbpry/svz8x7U2XSpYm9u3XHh42LDz4VQZNFezaDpyk8ZqF1tljW7Yd0cAOdXe388Zy0848M
	5TB+jJ+VJyL17Af/dFPg5/H6Elf06msS/6FYVI
X-Google-Smtp-Source: AGHT+IH2TOWzUeGxG1/VvM5umB2zQLllV6LRmfHEFJ6bEJKnEcBXB5BqfvcaUtU8PlHUHYAax8MNb/fMhf3PDUmziAs=
X-Received: by 2002:a17:90b:1809:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-300ff380aaemr2857882a91.0.1741744599798; Tue, 11 Mar 2025
 18:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <010001958798b97c-4da7647e-d0bc-4f81-9132-ad24353139cb-000000@email.amazonses.com>
In-Reply-To: <010001958798b97c-4da7647e-d0bc-4f81-9132-ad24353139cb-000000@email.amazonses.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Mar 2025 02:56:26 +0100
X-Gm-Features: AQ5f1JqsRDOX4s34-mUC-bMUKfIpM7ebb8PdNYncW_1xsWSlQpvBaseM_USJnec
Message-ID: <CANiq72mV=160jejuTO8jmsOszrkbXX0UAa1dvZ0VSyKaWcLqBg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: uaccess: mark UserSliceReader methods inline
To: Antonio Hickey <contact@antoniohickey.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:44=E2=80=AFAM Antonio Hickey
<contact@antoniohickey.com> wrote:
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: https://github.com/Rust-for-Linux/linux/issues/1145

The Suggested-by tag is meant to explain who suggested it, rather than
duplicate the link -- please see:

    https://docs.kernel.org/process/submitting-patches.html#using-reported-=
by-tested-by-reviewed-by-suggested-by-and-fixes

(I typically also put the Link after the tag, if the link is meant to
show the original suggestion, just like the documentation requests for
the Reported-by/Closes pair)

In any case, there is no need to re-send a v3 just for this, you can
wait to see if there is any feedback.

Thanks for the patch!

Cheers,
Miguel

