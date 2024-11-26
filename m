Return-Path: <linux-kernel+bounces-422852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D09D9EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0964166710
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC461DFE16;
	Tue, 26 Nov 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRLRpqbi"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541D1DF978
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657888; cv=none; b=V0TITW1JfTankrn3+rKx+d1O9U/CY51KUt75ncUkKz2LqPg/gveWDxg0XLgCJyS9CV4zbVbhGjUD4TbngDAAlLm+MTzslNtC+5j45zEBGTCBzknuZmWE+fR2kJz8xinFNekKoiP8/Dqf/2+tXb+q8RAAW6LFz6/4HbYwE8350NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657888; c=relaxed/simple;
	bh=yvlDvtEahYtNUso+6qH92gmUyN3C/oxlbIcZCyFM3B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKtEoPunG8RhvsOmYjVQDBpJteW0GF+U1CvoZY4HdQhOBXF7h8aELdpeSCqPjrNFLP0giL3ieYV3x8iFHUxGdqzBicCFfakTffJS0dJLbcf+kiHhzZ5R/gSAKhR87LeSFJtK1IJHGYirp1lf7R5Fa5bnqLI3ujZ9XunABt1yGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRLRpqbi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so530a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732657885; x=1733262685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvlDvtEahYtNUso+6qH92gmUyN3C/oxlbIcZCyFM3B8=;
        b=JRLRpqbiqMlXDVn5yw658ha1oEOJYdhN0CjmNFgAFjyWwYftzLG2QtvpRz80ewEdyp
         XFiIzSe0W2Qjkt60CQRcBHjamJER9yxxRl5e8wYc7Bnaxbr0opT22YRTsx0/3OhWNaIX
         sZMOxW6dS1bgTKBaTGkzgTamgLnY7yIrB8DpxaZF85DtWdE0xo9xgXJg4EJrZuTqsYLU
         THt08ZdpUVQySPiaqVsesjJygLxQhhUQeWo077QaW4VJaRDvYeWvVxdY5wJFTysNMe/e
         fgRyQ76bNqo5pC4LVuJ3SG9vMsv/Dhz5TQvEtak6GHIAqeYWZ/O/Le+MXjPVzuKJj58T
         fEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657885; x=1733262685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvlDvtEahYtNUso+6qH92gmUyN3C/oxlbIcZCyFM3B8=;
        b=G+Co0gIfM76YYRVpHaX7oSNujDlb4314EuAI3xrYsr7zxCyujdExvulquMTmWf89E1
         SqYRvZesbyuAfFVwzjzDP7D0exyOoPO4uOlsSCyvH4qfOo2FIu7MDSuWA9/jaZooJxXY
         4v0i2Mw6GJPvNq5flTzh0WjVXwHlwyki54Oe2MNyjn18g864g7TydCnSmCurV0O2PR5E
         T+6mXNS1yV6maqLZcwZkofSysPuf7oQCicoiqdTcMwQqFTQQthOQMxN4T67Ql4wETYWr
         ZIN7gaXsZNE5YjwyWtfxwlmK1GVfFVWbF1Mn8zBBkU7SA6sd5aHK5fgl67OKKj+PW+0P
         Qc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiWSNhozfZnxzyPXkvL5w2WGfKx9cfKhfKc6+NpCkPTQW14XWz8Aq2opG1tOYaEuwrtdViToUnx/5xcI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyscrTsil5pE3vAIhfrBWbUToF/WwhrCIC6NwCbGlEooD3aCiO/
	E+v875KtvT35OKCkU1wmcrXXfuUBi0nQq3ARLUAmFROz+pV0QhdoLw8TOniXJusLehNIgE9oWBZ
	jSMIIVhuERimSIrllrHINQZqouftbgPZqHKdq
X-Gm-Gg: ASbGnctwynmA0JX6yEQ0FZ6oiZO8xd45ZpiEOr2JG6ZvBPoCAyhN57vvyJjSxVvpczY
	yTsbyz8/ezD/pJ3OcNbW3dFvL/NivHlfQbiiqrgmsI+rgjo9yPv+0UxZyQTw=
X-Google-Smtp-Source: AGHT+IHYQJvZD1gGExfwDIDFj+tKBXqsEL5uzf01tAJOezpTzJHEU8dGIvX2EzXD8gHsvJpS7xP/SwNGKEiMqDRt/dg=
X-Received: by 2002:a05:6402:1774:b0:5d0:78d0:f845 with SMTP id
 4fb4d7f45d1cf-5d081159fccmr23577a12.2.1732657884146; Tue, 26 Nov 2024
 13:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-4-7127bfcdd54e@google.com>
In-Reply-To: <20241122-vma-v9-4-7127bfcdd54e@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 Nov 2024 22:50:48 +0100
Message-ID: <CAG48ez1MGawv0EVA7ZFgjWi76DRuQax-5PbGqG-msAzqRMkA-w@mail.gmail.com>
Subject: Re: [PATCH v9 4/8] mm: rust: add lock_vma_under_rcu
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> Currently, the binder driver always uses the mmap lock to make changes
> to its vma. Because the mmap lock is global to the process, this can
> involve significant contention. However, the kernel has a feature called
> per-vma locks, which can significantly reduce contention. For example,
> you can take a vma lock in parallel with an mmap write lock. This is
> important because contention on the mmap lock has been a long-term
> recurring challenge for the Binder driver.
>
> This patch introduces support for using `lock_vma_under_rcu` from Rust.
> The Rust Binder driver will be able to use this to reduce contention on
> the mmap lock.
>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Jann Horn <jannh@google.com>

