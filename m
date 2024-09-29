Return-Path: <linux-kernel+bounces-343179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F8989786
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9C7B22A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A617C7CA;
	Sun, 29 Sep 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="aQKEgcAJ"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1614386D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643643; cv=none; b=MrUQC48RdZfQnQzxgvOdJ0Vz5K1LhmPgBXhNnjgzSpwEeZ8/m7ONAgM0Pt+05jSDtD5L6v4EQu1qyk7XXSJYlzXi4wbRJ1XPGTN0ZtWCZbJfXjOFLDF6MMVspqStYUalWxC26aq9DUa/sSZCiVcg3f5lr6F/XO7Sw2LkaMQKGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643643; c=relaxed/simple;
	bh=6goDgIvXlrnFCc9KRrG8W8k4uU9ZlRJdc5Z2jkIGVPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyyIZmGtRcBnzY7YOwWaBTPgMzRzZo0wjNfC9UqBmiPxhy/5La2zzNSWOkpcArqbJBbF7r5EfB/lrKkcKB0PJmZJ8tVoQ7/pJRnTohEyJpilYKKxvDXi0hoQHCis0ViQnmlozFBd/raGWZUwc+xT+nxznEiYFcE9XraoBWITX88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=aQKEgcAJ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ddd138e0d0so33770107b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727643640; x=1728248440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6goDgIvXlrnFCc9KRrG8W8k4uU9ZlRJdc5Z2jkIGVPM=;
        b=aQKEgcAJ5noYDhM2tmPyi8QrAP8Xl9FpagWgopB1/4eX/Yo23BrwP4PuRs45E16VBr
         JLSpLEAjW5bYbk+sTUsQkVnwYge/zH2823WRejiPBOMUwRDshkR6nQ7IMgadWWKXsK6p
         ueFBNJR1b/pnX1o7jbjGbtUtlPYGm6nZGuRIEgKTztzGaU8S5na3L8v0p8oU4DnMnlRx
         8tjjXPxQa1f6qtMIpTZxM28F01kFHaYS6fKOGsTI3wOMEj92TX8rZKM7051YzgU6coW8
         7Ug0jW3/yQLeD54FiRf9l9ZcKxhmaCTtWILstHsR5AEmC6sI5AW+7A1AzrZ2Pqg1BFWf
         fwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727643640; x=1728248440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6goDgIvXlrnFCc9KRrG8W8k4uU9ZlRJdc5Z2jkIGVPM=;
        b=Hqs2dFxnBMGyUj4QXeaEl15gO5afFqzGuoXJE6Maz4M8VQYxhboBK9NJMCjJcysvSC
         YkbZBHLrNOdXWCTX5JZdipo1aOr9Udy/mcXa/Qt5nnh+cJVTjJN3aqqV/sK77Axtc+to
         rYiUf1VAoflil5/irZ3CX3YjfzdhPLKyBfSU7eAmeVdi0a4AUOPsg+ufjwiIVpAM/zpm
         ucSCkb6cTTGeJbgoMkEdqiby63jHt5BWR5/o0K95zTr3v9NAntyUY4TyhGsiwu5+pmdi
         3O0IsoCqQaX/7fXfMy1nAiXpegs6YZ1ru0I4pqNe6JIPrAnBOnUe2E7YpirQq94PBCFQ
         +nKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxQZG+doaaC42/Fq9dCQDfMO2JnBqi4VLti5NWpUxW3/ajqrC2XFemBxXxZsjDsDXCnB7FZp79UCgkpDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaC7DltzODBIPG0ztiyZzaNqu60nvvM62EbvUpLuvapix2MJ1E
	c7Hezkc04ZxyWibxxc6of1laeNefg+73dim+LZt+0TxsiYXA8wnr48rGhcas6V63OKnn39mybCE
	2TBygkQn8GXIWaOR47y89io1PR/0DvKFBWerb0A==
X-Google-Smtp-Source: AGHT+IGyowJOWGUWAKF2NVl2DVZ7EqWnGUFKSfa0zIPMF+JmPrRPt6l+JRpnKHOqXHz5x05oV7aAmMN8LnpJhXdpZvI=
X-Received: by 2002:a05:690c:6bc6:b0:6db:dede:ec63 with SMTP id
 00721157ae682-6e2475e8caamr69779507b3.28.1727643640240; Sun, 29 Sep 2024
 14:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913213041.395655-1-gary@garyguo.net> <20240913213041.395655-2-gary@garyguo.net>
In-Reply-To: <20240913213041.395655-2-gary@garyguo.net>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 17:00:29 -0400
Message-ID: <CALNs47sgdi4PU8YXxozMm4=7aQ9RspJsKkKrYuT++9KiC8E-KQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] rust: fix size_t in bindgen prototypes of C builtins
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:32=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:

> -bindgen_c_flags_final =3D $(bindgen_c_flags_lto) -D__BINDGEN__
> +# `-fno-builtin` is passed to avoid bindgen from using clang builtin pro=
totypes
> +# for functions like `memcpy` -- if this flag is not passed, bindgen-gen=
erated
> +# prototypes use `c_ulong` or `c_uint` depending on architecture instead=
 of
> +# generating `usize`.
> +bindgen_c_flags_final =3D $(bindgen_c_flags_lto) -fno-builtin -D__BINDGE=
N__

I wonder how reliable this behavior is. Maybe bindgen could do a
better job controlling this, is there an open issue?

- Trevor

