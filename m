Return-Path: <linux-kernel+bounces-298243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FF095C459
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9130CB211FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4B481A7;
	Fri, 23 Aug 2024 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD+jfGlU"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C20F8488;
	Fri, 23 Aug 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724388429; cv=none; b=MR0HyZbZBQ46htdtOlnCKQPe+ywdETMkAS+cIJHW66MiKjxtQAp+GWpXLPOz1jteIIMn4IKi8PAMmWARmyX66pF/8+6GOqpRXl6Y8jTU5ewp9EWR14whfi2Mcq2AMKRBGm0KN7D/YV+9CNfQywjOqC+IhaQrRNL9+GU2kOX/n44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724388429; c=relaxed/simple;
	bh=UgsCOU70BEQw+615teebyPSG0RIXwCBvP44BbHG5MZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urBaXTGtxsqPBFuOc/Kc8puPVHq6h40PCNUgh04FsJ4vvjj/uoYErvn3PkFh1TwHcyGy+5lfe0CLxdBComdVVq3sQc+fKKhYSJV/gI8eukVcjAOGJdOhxFVJ0ghLN4NQVL6Ir2XM7p0xVZ+hEF/RCtQs0r6XQ/Kt6ECk1dnfSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD+jfGlU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd86a30706so86131a12.1;
        Thu, 22 Aug 2024 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724388427; x=1724993227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgsCOU70BEQw+615teebyPSG0RIXwCBvP44BbHG5MZE=;
        b=RD+jfGlU5DrpS0yewePRi5QalCgo+6ALi0JTUSNTfG8ehYC3i4y3QIUSB+eCkmnpO5
         6jy3yJPP91p+q5UDK6+B4K0zCXP1uJhV/URX8CmaFGub4TeKL97AE3jiN4pov69Q74Hv
         0c7+uZ6GgUwy+SztIDEFuhPoK/RKR/cSSeGsvkP2id1+PQXKSb03+14gofmstFtDh1hY
         zDcrkyR4/UrW7chxtEITflR5+XC63gYL4wJMAy6HcMshOJR8xE/9+/gF89uLkLYBQ4oq
         yFN7ru5dLfzTq27oNJF/lvYMFbECSYCvK1O1Rk9zS02Iea9wGndh4Ol8xpEJ+tQXCF29
         JbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724388427; x=1724993227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgsCOU70BEQw+615teebyPSG0RIXwCBvP44BbHG5MZE=;
        b=vblAyv3oOsBTxqhsgw2bhERGfZpMqwOzaaQ3I3d9WmZleqWB/AxWT06zLOpbTAogPD
         YCEZmCdeE2uctgg5FMikAxJodq1f1rHMzi9HjjT5qXwY8kr8TkjiAn8AEZocYKvqx9eM
         DGJ9KorbkNAeIvKl6mInkUxRMC4wL89itkhO2Jm27sEkB+usOe9HHuJgGA68+U/mngs5
         5hkKG3TFpf3xGgA36Ur3ve4leZi50UgKUGYykqCFHBsqNYD725bSrAnSJ7KvxlhYMi3P
         N2UfRbsENi1Y0fHgCm2oH2LqyZmh6WctvIfbHiLOIVHkBncQF1G0m1uL6EpipRhzJP9g
         X59w==
X-Forwarded-Encrypted: i=1; AJvYcCWcqvvjzCh1Ft4o+zGbC9BIeGO7eEjVI0TZLvn2S66HML9Ad1aipuZ8RHmM65PdEb/bUnud1QHT9+EjjxFooVw=@vger.kernel.org, AJvYcCXOwLcStpXPpfWPZW4wZ/eqYqYCP8c7MVqJUpILYJKEOqjZhXp0E5eCW2y9uI9H8p8ldL8bk0i6uXHSILk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6nIRxyrAN+MWskD7Rn95DyGhivUdgRlvha/cUbWKbycoDdiZ
	oOjWhqRbRYPhKtBNRx3oW+6IVxKFpv5fKcYVBuCRKBhi9tLfq6jz+DsQ7MaAvhJfL/I1j4PcXT9
	XecKYj74LPqNWAzfSTHirOd6wrntJOlc3
X-Google-Smtp-Source: AGHT+IGrjhXA1BvPYTpdNdtLIkMKEdLBwD7b3X3ja2V2iIbIqmLisqeOng7WZgOMLYu2DO0gEyz0MOJFcX8BW4zSBSU=
X-Received: by 2002:a05:6a00:1989:b0:70d:140c:7369 with SMTP id
 d2e1a72fcca58-714459084f9mr762917b3a.3.1724388427306; Thu, 22 Aug 2024
 21:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-target-json-arrays-v1-1-2b376fd0ecf4@google.com>
In-Reply-To: <20240730-target-json-arrays-v1-1-2b376fd0ecf4@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Aug 2024 06:46:54 +0200
Message-ID: <CANiq72mrnSPVVRCMUwsjUhmugSmBrmJ6WjxK2j6+1MS_NSd_Ew@mail.gmail.com>
Subject: Re: [PATCH] rust: support arrays in target JSON
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:26=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> From: Matthew Maurer <mmaurer@google.com>
>
> Some configuration options such as the supported sanitizer list are
> arrays. To support using Rust with sanitizers on x86, we must update the
> target.json generator to support this case.
>
> The Push trait is removed in favor of the From trait because the Push
> trait doesn't work well in the nested case where you are not really
> pushing values to a TargetSpec.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

