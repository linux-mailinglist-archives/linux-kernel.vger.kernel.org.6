Return-Path: <linux-kernel+bounces-343610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7168A989D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0751DB24796
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938F717E8F7;
	Mon, 30 Sep 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2xOjVht"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327417B4FC;
	Mon, 30 Sep 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686168; cv=none; b=tO950X/6dKbDdFjA2dJOEGJ/jnuSUBwhfk3zJJlTtamlcu/grCZaX8rh1iX+F72juV75CKznJCgmKdPDz96fgXxVdCHoce4UiyyBpIETddzy8+aVjdhbN6cReAaK3xEfVbGT+GDerLRGeV3WTTptQi80my3MuZrgIuzHw2TWo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686168; c=relaxed/simple;
	bh=lqTiyXirW32QfOM0FkJASZM8KV41WbXnidi5f4JRW4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTHNt0vmBngawjBDlQmnePk8FhzUJUG6HWDvfgm9TxeSA8q9yhbhX02xUE9l9cyRU253eZmxtM5ZXilVNDeRYKR0BwKsBSeCIQd9hTjbwoKLOyM5t5+8k+ySgK4yLdiWHXux8Gy2cyvK7DAqP4D4zdNtv1w9LkDMH//cLsVp4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2xOjVht; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e0ad414718so804247a91.2;
        Mon, 30 Sep 2024 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727686166; x=1728290966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqTiyXirW32QfOM0FkJASZM8KV41WbXnidi5f4JRW4w=;
        b=C2xOjVhtkDNUTbp+PGhHWfsDvI59hNXPncTAH/V9ODcIN269zMD4zd4SWHRZnlMyU1
         Emh+o38hjUBAFxE9jEnKC+KBiGeEoBjN+7Ydg2pT0N3OG65/h9QHaXkvcqG/cYK91yVv
         aXrumN7Eg2Zn6Bx2S4Fv+pGPzt+IroN6+b8+m6sK5yuqh4SR1xdciCOgtaH2GPWHpM6q
         t7nwhsaVnR7rsqiWmvXxNnwfSQFdTNdrz/dEgD+zFxovzWTqmHarL4e2ql/hu8P4fukM
         ZUTgnjR27WfnHICk3b8BCA1+MaRNKRj+iBbN6aOol/Ci0LH3ec8E/3Qttus4ohGM483l
         BhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686166; x=1728290966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqTiyXirW32QfOM0FkJASZM8KV41WbXnidi5f4JRW4w=;
        b=VP1ptlOyEI+gv+dhFTxidhM/ndZs25IqZlS9Cx9DrBO5fWAlUSjyV3Qo8g5cLqxRk4
         /nguPCzw9aBradW5gjKUMTK60pX5mBZ9qWNui+GKUWtEf9V7GFKr9pXW8yCeHEhiVYcC
         5PeyiWtx1uyGY/W0h52UHHW1UvLsnhShVb6Ki8TCnUzTKhfqQ15tDrnIMAJwlTGDKW09
         pG7N58+P2lIVjej6TYc/zOAn0VjggTChrf18+lYjg8QAleWUVTt7EbQeiTyPjRJZa65x
         Pny5CmIDdUavsV07vCO23OHQCSlU2R7XCF41FtSFrDlTdLfc0CnJKykftckvPdVVFthW
         UL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo/rNBVVtRDXiEW51hzTx0h3wWrHKNGNp8TT5TVlJmKHKJKqlfbO32uPkHCTmhvf+XiTI8WYsFNCsZNZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSa/BOeht4GDrZSr0WeBrPhFFdq1h93FrWWHpLxjTPgxEok/su
	xu3nXU1Xj07Co20caYTAnbPleu3hFJ6qQPBT0pPfS9A5vugmAuNtMIKSRA1dCjf9Tr8RMJ/Sq2m
	5sb9Xlyj4ORK3l3H9gu6+EwzEj2s=
X-Google-Smtp-Source: AGHT+IEQ1tdrQhsCvZI+arTKIhH29l9Gv8+v9ylxuggJaKyYGTRwbYu39EbSEyWqUiwQKvMqwVaUPKmwadNyJOzltA8=
X-Received: by 2002:a05:6a20:a113:b0:1cf:2be2:6524 with SMTP id
 adf61e73a8af0-1d509ba84f7mr5326919637.10.1727686166045; Mon, 30 Sep 2024
 01:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
In-Reply-To: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Sep 2024 10:49:12 +0200
Message-ID: <CANiq72mrcMq7KKn5UiT2GuZPCeFMtr63tj9JTHnVLfzmYDgauQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2 RESEND] rust: kernel: clean up empty `///` lines
To: Hridesh MG <hridesh699@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 1:15=E2=80=AFPM Hridesh MG <hridesh699@gmail.com> w=
rote:
>
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>

The patch looks good, thanks!

However, the kernel needs known identities to accept patches -- I know
you added "MG" since the first version when I asked, but is that your
full surname? i.e. it appears to be initials -- if they are not, then
I apologize in advance.

Cheers,
Miguel

