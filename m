Return-Path: <linux-kernel+bounces-274379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC651947786
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68DCAB21D77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5B15350D;
	Mon,  5 Aug 2024 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3D8tgBF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AAC14E2FD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847454; cv=none; b=on7GcgiUCepLUYIj/c1ZRrioSYXttEq58UXRMNC0nKavqrwYFDoZSImIh0yRCO146Pc0yklQKNIYm89QOqGGAUIyDOl9OOF572iLfJyQQ3Jewb4LUrBAmsMJacIZiLfOx2zP4RJjQOtLtaGkEtkABzTFvVtQYMkJchUvGfyzeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847454; c=relaxed/simple;
	bh=fm6iDdrrchB9TLaDEjrQrAmycPo24uRg4U4FYXtFY70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pg5VjGaxEHt7URrNomzrJ9QJL9LcKFdBvfZCgM+pJAW+XfJ4x2xk2+2/x8PEt/AJxczBQp3cYT3/txS8HtQ2Izia6eURqFxI0BQHJ7ALrOY4h4tnzXS0dMIYAdpiDo+1UARb973ar6MFaRPqIBCkgQPZkuPwmr4zsVvDpDF4a9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3D8tgBF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so69753545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722847451; x=1723452251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fm6iDdrrchB9TLaDEjrQrAmycPo24uRg4U4FYXtFY70=;
        b=x3D8tgBFQgUHyC3dJJfgzgsk+HEf9os+Dr4zhjZQeDbLQAmhyWveiQGLOUhKJKjLSE
         Yvhw0xxovCwCHOzMm3BfOtmcoCdH5BsYdrAleezGdvNRFDZSrq+NfLyyq8+CYgzbwwxp
         8TNLbh/bXoiKr9p5bHjQyTLj/ZAlaimLtGYI6lgeUN42TvWbI4dFGFjWGxt6SqWQlyKK
         ElL8hrsk9nN0Dpgobkm9Pz0Eu7FgJbJuVLnvYHRfY9I56X8+h4z5Gy0JihLebRTO91w5
         SWZFLJQz7dXsBuqE2uBDqMP9QoGiSgPFIWBJIxBzMqoJAVxsP57xOkW8okdhAJ/Pqik4
         knHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722847451; x=1723452251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm6iDdrrchB9TLaDEjrQrAmycPo24uRg4U4FYXtFY70=;
        b=Uxoe8nADWkSjGsp5Ypkxf9iV+hdKwA9tuPCBJ1ECbppt5C+C1iJ9O9bv13iFNpzoVU
         Fc8H3kA7hwMJumuzRJmejIr5Sm4tUuECicHq0JdL2LRI0UewEVM3j1EbbNYYmTonldod
         tHjTKdEb4/DXtJxMLDPDQEEOWDEmQA4/5xIYbfwHvDTD+flbHz0ddWHgdcPivhO0WRj/
         hHzgtEkp3c43kdh114l496OQRpIZJFX30z4rZwxYtgDDVHmGEh73J0atUccqB4v4mNgC
         Fs9SF24DyRShrm8cn06vQ22sS5uFKnd9K2yogwI06mATX/LBtj3rEkHn0cpREr5VXF2Z
         NSJA==
X-Forwarded-Encrypted: i=1; AJvYcCUfoeUs26IxbaGApFd+BqAZSec+vrUqO1a9jRx5l8FcRa8FyVXmFfi9vtYZMUxuniMKRUIV8DLkfgXSR7Ar67tRHukPTL/GehMRZfuo
X-Gm-Message-State: AOJu0YzkZ3/RwFi24vtEBOz7yOuRmrx1yW6G+0bkm2cpOlQlYDD2QBdi
	N9GbuFecoUKxvVGzvYaXOTDSTaHnRogcmWq0GtZ3AGaYFJUPnCaGv7GGArnVCW/qxJWgrj/BSW0
	og2mXPy+26tetgep0M9ecpJVAoIL5vbWmJCk+
X-Google-Smtp-Source: AGHT+IFQNNlLaN3e/vSKEN8qAWnUmVt+qaGbQE+xaDCrBD7/2Fspb+GbLuhT6mV28u0V7jNeDv4p8cFoq4FWkdW6LSE=
X-Received: by 2002:a05:600c:3b0d:b0:428:387:79ac with SMTP id
 5b1f17b1804b1-428e6aea8femr77816135e9.6.1722847450485; Mon, 05 Aug 2024
 01:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803141639.3237686-1-benno.lossin@proton.me> <2ddc08c1-ac38-4cc6-a102-2ad336d6b617@kernel.org>
In-Reply-To: <2ddc08c1-ac38-4cc6-a102-2ad336d6b617@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 5 Aug 2024 10:43:57 +0200
Message-ID: <CAH5fLgj2urZ6OD2ki6E=6EuPqW3Z8BGg8jd6Bgo4OOrNiptnDw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: kernel: add `drop_contents` to `BoxExt`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 1:22=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On 8/3/24 4:16 PM, Benno Lossin wrote:
> > Sometimes (see [1]) it is necessary to drop the value inside of a
> > `Box<T>`, but retain the allocation. For example to reuse the allocatio=
n
> > in the future.
> > Introduce a new function `drop_contents` that turns a `Box<T>` into
> > `Box<MaybeUninit<T>>` by dropping the value.
>
> Is this (and the stuff in patch 2) used somewhere? Otherwise, I think it
> would probably make sense to base this work on top of my allocator work.

Yes, please see the red/black tree.
https://lore.kernel.org/rust-for-linux/20240727-b4-rbtree-v8-0-951600ada434=
@google.com/

Alice

