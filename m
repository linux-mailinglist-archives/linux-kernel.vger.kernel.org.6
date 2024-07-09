Return-Path: <linux-kernel+bounces-245361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3913792B1A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDF11F21673
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEFC14D705;
	Tue,  9 Jul 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoHlAIDp"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615F12C478;
	Tue,  9 Jul 2024 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511733; cv=none; b=el63hsDKV81tSN5pjbEY79pSeSwnt5bAmS8SJdRrszG5CvGtg2/ePYiaSVKb88ac/ecW42/g44jKf27dPXnsDgaJdthepci2c7KHKwdMuFR2DKeY+WdXpKAq//LTmGojI76YpSITghDa0lwC4UDGeOFOLF2rjdhXvL07z6j5dnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511733; c=relaxed/simple;
	bh=YzvYfGmfAcSYTrnLdb6YghFGvOuva+jojEq/hwMLN68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkbvDHIgyUaMyq6lvoUvX8IItZ4yo1IxP5dTWAilDZB0R+NLVdERRtCUhdjOrqkvkXVS51cb1asmZAZGVOknH5TV9QS9gOgk5P2EBh1kzCQ4zsfv+hiysn/B2GT8dzJcIJxPjG4E1gay6xFZc5hDtjbfxHxqfu0B4MJ/i7sjHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoHlAIDp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-707040e3018so3151453a12.1;
        Tue, 09 Jul 2024 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720511730; x=1721116530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzvYfGmfAcSYTrnLdb6YghFGvOuva+jojEq/hwMLN68=;
        b=RoHlAIDpy8DoiphmP5GU39+vnLNyRIvlyvN/OV4+NyL8Dj1FkbTbGmh4V1Eu1vxRJN
         uq5wYXg7nlVSm41qhJn1vae7vJUpUG0KhYz3AnHU2cxe1L/qgA2iu7sRdQN2zjdWpKQU
         848x6BzQMN3oke9DBrHfdpszTbKeCBTEyBACq10AeCJpklBfYiy29Hjdx1XrsvzIB8tq
         SuuZDwJTN3259J63yk5yRXOKIjTdVjVPt+xCqF29aGurAGiMdpCd2gAHVLM+ANZlW3vC
         41m8XzV0eB/X96f1spkJYs0AXCZtJrkthDPz9hlhGgNneFEiIz7aZ5M/k7VoHf3z0laG
         XCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511730; x=1721116530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzvYfGmfAcSYTrnLdb6YghFGvOuva+jojEq/hwMLN68=;
        b=YU7BZroIWEhsdOfKmDhd5ZonDtHjzPN3tWnHMNMcX57tMEeFC5s0bSFAgyx7Ak/3Ag
         ynBmEydMT/ckeVISmR9iyDz1djRfMTn2auRDFP8Sra7AACqDdCFgXjGosBMSevk+flpr
         Oqo46EQ7/Lee7M5KBsGpkFU7dPc3zNfRFVT7KtfxrJB1hqnhukErUiNOD65mdh8kWgQL
         ffrcNNJ0Yjr5UNy3AjvsWk2PBREQBgjcRu50mjqQgS0CSlYANe1cDKe/nMO/GIicQnOr
         YsoLv+NIa3eWST0zBymuU01ibSV5kPfCZhfs7xfsCuPKu1AS5aOdslvIn6/pfTYFrOg1
         f1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVUleZtOynDWYWNgxorKKhxfnZ/KMwlNcI7V/MsVcZT8DCGHKFKh0IwNyITD6V9yowqSvv1qbxfYSJoyx0LislWuXBhgOeNcG+BMC3GvU+bE2QtAd3KxXdN0JrBmqDuMbr1N0JoNA3msIzAfdI=
X-Gm-Message-State: AOJu0YwWL9GI01isllBdQyzAEr7/lMWin9T9LEW4cG8huAOPEGvmIBlu
	9yEj4vMKLk4Q+gryPg8lDGXpyXH0M2cyBtdfexVJ6gqk5bpKw+0OQfYA8OCL8VOq/sNSvdFr1c5
	/kVpZxG8H5Z67C296nu6RgZLa5UQ=
X-Google-Smtp-Source: AGHT+IEPkJ7kX8DP6xXn1hqgjitAHhqA1vLoNVaXSl0RLERC8TNfjOKtWnm7ZTa/2tCJN+5SgSAPu9kP6iKo39EEFF8=
X-Received: by 2002:a05:6a20:4321:b0:1c0:eec6:85ea with SMTP id
 adf61e73a8af0-1c2981ff8bemr2187647637.12.1720511730113; Tue, 09 Jul 2024
 00:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607-highmem-v1-1-d18c5ca4072f@google.com>
In-Reply-To: <20240607-highmem-v1-1-d18c5ca4072f@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jul 2024 09:55:18 +0200
Message-ID: <CANiq72kO2rpPBf0Gxfqmt7cUMMsrH9kx0==63rthwXQD3fgAqw@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: add __GFP_HIGHMEM flag
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 10:23=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Make it possible to allocate memory that doesn't need to mapped into the
> kernel's address space. This flag is useful together with
> Page::alloc_page [1].
>
> Rust Binder needs this for the memory that holds incoming transactions
> for each process. Each process will have a few megabytes of memory
> allocated with this flag, which is mapped into the process using
> vm_insert_page. When the kernel copies data for an incoming transaction
> into a process's memory region, it will use kmap_local_page to
> temporarily map pages that are being modified. There is no need for them
> to take up address space in the kernel when the kernel is not writing an
> incoming transaction into the page.
>
> Link: https://lore.kernel.org/all/20240528-alice-mm-v7-4-78222c31b8f4@goo=
gle.com/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next`, thanks!

Cheers,
Miguel

