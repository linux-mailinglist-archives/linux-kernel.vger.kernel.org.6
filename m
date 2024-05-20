Return-Path: <linux-kernel+bounces-183559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4E28C9A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DD81F21CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DBE2E832;
	Mon, 20 May 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEgDGZEZ"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4113F9FB
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198271; cv=none; b=Tu7hv+PxH0NA50r9ZM4FToyTM7Qz1BDjtPvV4L7wc1HCFYYudMTvDulZmr/Q/gotbZkfLw+0JFMJO9xLdwQPiegoP2uXAfvDO62oHpIZO/YokXwF/GKKCpCaJMnacfvYvBy1qbFJrQ9Ha/djE2u3tzlVKBSk9pxzwneaiCAQw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198271; c=relaxed/simple;
	bh=9SQyahqkNTCE11p+YPTRBzNEGuv1mZ4mTj9rW50lNSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2JgJbvhRlytvIjqxI7tuD9yP+B5ZfycpOts88qOJ/EAwtqmFX6lQHfAmC540+pms1QgxqIGmA+9M9W00hTZiajJuHWUdUN/lbq3/L+qd1FbXvsFh/hnnalO0ZGJbVhI70f6+w0eaDpyFTW1PTbsqdcO8nnUknX5V0sLzWES8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEgDGZEZ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7fbbb2cf3c1so1259014241.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716198268; x=1716803068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SQyahqkNTCE11p+YPTRBzNEGuv1mZ4mTj9rW50lNSY=;
        b=pEgDGZEZpLpBHz7CSyPYgcd+CG725OdRFCWH4zXcJVDKWNgSZ3dQlrn41HkG0A5toU
         LtmjH99x28Q0twiRNs2GV1ZgmrkMd5NqHjc/Uej531pC8AmEOdCERiC7ILnua5IT35G4
         45lnudKLbGlIdF5ih6IsndaklMdoBDatBEAxt8HW8vZzANXc6uOm5vng+GX5ebnDPNZ8
         jCuS4Il9uNLjhqJtJTINCaJ9K2v0Ti3IYTehfLOazQiciAhfACmC8Y5VBKr9Ul6nkdFl
         bWnOs23JvJ4QaVrU6m8UESXzgs/fPEjrIo//lWCk0TpJJ1vMbP5SyI5ox0JyUItG4TdD
         KfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716198268; x=1716803068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SQyahqkNTCE11p+YPTRBzNEGuv1mZ4mTj9rW50lNSY=;
        b=P2pjcq/YzXvxrDqgzeZsaVVc7fYo1potKwcu9abGRHFV8QGMszf5c+1xXqFjHm1QkE
         0rO0MbBQLFHOKGKqm3qqSZ2dJjL2sl/kQHggGxUWi4PuU6ArWJgLPP3m6oHvhKZ6Aik5
         K5ZGAdHfiRGQlyA6sKbp4+g1+XQ0ZnwWloCaYTOm783vRKCXTa+LuxkTskDrbqIapO6A
         cY6jXEy3QzfAX47pEDiYKTQifRr2RzYVa4q/737s00F4SAs41EOGCt8NzLerIM72THbb
         b+8397QGvLd1/aB1+sO9fnDmoYXM+dpEuVY1jCfCMNBVrs3bQgmbZDwukd2IXWxPugDi
         7h6A==
X-Forwarded-Encrypted: i=1; AJvYcCUFVjDoHi7PBakcYPXDsvStbS5dUJBXF8l/JKMrB1aIK+GReMPn14oq66u8AcZnyIFhp8WDrlXXGwsJLOpOx68HfMGpmm5ZqYn21mgh
X-Gm-Message-State: AOJu0Yy0kPh75ZlHmLylif+BhkYJis8IBzEV6xIh9qJ/F1DmiuMGN8bb
	0ZBaB/lJJgZYLtq3Hm2Agup7Dcg7bfAYvfYyR3DlAP16l+hUL1di1MMiROIqFbDUgATBlgfjdaQ
	clDujIzVI5VKiq1P3iAyvjMNtrU1aFpOi594A
X-Google-Smtp-Source: AGHT+IHHXvr+M+34UawNAnnzqJygOBNlCpPhzSst4E67c+2hXFzQu8PTkPa+2afVxf4csgSkRirTEdacdSn42ZMv2C8=
X-Received: by 2002:a05:6102:d89:b0:47e:a214:8d02 with SMTP id
 ada2fe7eead31-48077cc45d3mr28209812137.0.1716198268543; Mon, 20 May 2024
 02:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519211235.589325-1-ojeda@kernel.org> <20240519211235.589325-3-ojeda@kernel.org>
In-Reply-To: <20240519211235.589325-3-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 20 May 2024 11:44:16 +0200
Message-ID: <CAH5fLgij=Wv0Fbd87piUrP9n-riQxM-4BUo26XDgKxuZEQEixQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: rust: support `W=e` for Rust
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 11:13=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> With `W=3De`, kernel C targets error out on warnings.
>
> Add support for the same feature for Rust code, but take the opportunity
> to apply it for every Rust target (i.e. not just kernel code), so that
> it behaves like having set `CONFIG_WERROR`.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

