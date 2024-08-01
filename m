Return-Path: <linux-kernel+bounces-270940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD75944764
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC41F22DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307E16F8FE;
	Thu,  1 Aug 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4alP9hRJ"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D361FEB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502947; cv=none; b=Wx1eib+HDPVvrBI77Ck0JcMts4w944cpeKuQ1/bCDFBmQEJK0p0aVlwGiMAl50dFX+JDIaLLYZ0a/hZ9Pt1AUqWRTCRT1XlVwRWF6FFvuDvNHv+vxusrr27IagPoCB2+bcVA7w/wczoMax98Ei1StFvmg8gMsCAz0eZRw8Q9oaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502947; c=relaxed/simple;
	bh=htzbgoJecrAz4Gd0Hxqsrfi+e3ZhfhKt345PObGz7RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXAN8X4zkjkjQ+VBVKiz5dLCjKTv2b5Ny1hSNbRW7GSjjJzNeVIKJOR64dR8IeFcmCoB1jah83t9Hlnohh152pGnEztAWqr6Tnbhu9Bmq8N8mx2I08DiUTYdPNBJK4+teGg6qVUnqxWeJBh4ItmaoHsvRYrnESt+7fLrk3QaVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4alP9hRJ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so78057961fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722502944; x=1723107744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htzbgoJecrAz4Gd0Hxqsrfi+e3ZhfhKt345PObGz7RU=;
        b=4alP9hRJtisGD+r0w8QvncigEsKCxv7by/FiysmVwfLis3rL+QDqzAhj+AS+Zkc+zY
         J/6bK1p0NdzpODo9Ay+TF3CBoBptp/SBhNmFYjsHAVopGa3N/Yb6lnr3fHmCMgKqmxsd
         XBvsPVvyRr5vuaHyfnPzSKtY71tEpJJ/JZWwewAKhOtAHzXOnLD5Vt2NlhzI0C4wrrzy
         WeNNwbRhpNk/nqinZQuGIk3+/nvryP5F/ULpha8woUaH2R9Z5yzX9RKfBFGD82qf+2SU
         fIV1Jomlou51yIY4gBGpbgjDaOBMUGezfX5tjuxwfp6WuiIxRT8qqWlxTCDbL3VxiMpG
         5ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502944; x=1723107744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htzbgoJecrAz4Gd0Hxqsrfi+e3ZhfhKt345PObGz7RU=;
        b=p1hDBg6+O/yoyT7LLhJINU7HKZsPoHtEpJXHYp4bqUsWRJhbL9FJsWuETG8EMLXkjX
         QzzMgzikzfOanJLVCz5PkUo/soyP8kiGuSO0pmtww7JiRJpTrjQ0ichjMBylrAelH3WG
         XQf74/dQEwknU5R08aNJ8+BRfJr08NLzDKpdRFN2s8U0qUS6EW/ybsVV/zhYw06RXOQP
         NbQIa1XtdTBknA7XqVBFrWvtS/h2aNtvdcBYk1dypQTUjjwl3HYVQgGocURa2e5EPtQh
         Jyei3bkRseOCF4MmZxi6RQ0yLw8nKKCewaOIR4YeC8R+l2ueW0Vh9z5kfRVmYACDk/6g
         QHuw==
X-Forwarded-Encrypted: i=1; AJvYcCXGFQVq8MFMjQEU6Uux9j92WVqAgLD2Ne/NBo4bnMfGSxeC4WLrErORjSMs9WWU4pktbmkjDZxatdPgYVk7j0g2TO4H8sCRBQLNBKrR
X-Gm-Message-State: AOJu0YyoXYJRqid5/E+o5nghgNhL507qqA/NLRg+PZphHAFzObjY2qqP
	oD/vjva1wMulITKzbcfceOwKCVswCcm+oDzm7rWUC28aeFl9Q14UEQ/i0LzxdCmh6RSr8dR9Cj+
	++wSnL3QVYuTVz8dwNqTzZCI5PR0XLCLa80VY
X-Google-Smtp-Source: AGHT+IHQAkc028YtQvdTyl6rfkHihPZCplN9RTiItFNrpQcWi3f7rQMpfL7voVqa3vUDkYzpg2Chh/B7hilYhnufvfo=
X-Received: by 2002:a2e:9647:0:b0:2f0:26b8:44b6 with SMTP id
 38308e7fff4ca-2f1533c2d0dmr11885291fa.40.1722502943602; Thu, 01 Aug 2024
 02:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708205325.1275473-1-benno.lossin@proton.me> <20240708205325.1275473-2-benno.lossin@proton.me>
In-Reply-To: <20240708205325.1275473-2-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 11:02:11 +0200
Message-ID: <CAH5fLggTGzh=iAoThtRa10z7_L0k73QTW2BMLjyG89o7hvTBVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: init: add `write_[pin_]init` functions
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 10:53=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> Sometimes it is necessary to split allocation and initialization into
> two steps. One such situation is when reusing existing allocations
> obtained via `Box::drop_contents`. See [1] for an example.
> In order to support this use case add `write_[pin_]init` functions to the
> pin-init API. These functions operate on already allocated smart
> pointers that wrap `MaybeUninit<T>`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57ad=
3f5bc592@proton.me/ [1]

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

