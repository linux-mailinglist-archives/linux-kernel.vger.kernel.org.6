Return-Path: <linux-kernel+bounces-262998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E094C93CFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A107B283024
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139D9176FBB;
	Fri, 26 Jul 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJ5oUVrP"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791B36D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982769; cv=none; b=KmacjCTOqxfOqeBBt4f9s55BsRIe+eoHx5f+6cLIg9/X+ENvDDN/u3hIAinvld+GbL5+NoMsKEdSnpdeFLtl4aTUxXTLW0PMorRRJ8ESomRAYHitJ/zxp4SoQL2tUkKVN3kT0Ei0i5rSTGc8SlcFR+nLDrR+M6Tadx7tCxbzM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982769; c=relaxed/simple;
	bh=vwKVjdvi7q/mOK8CLeQJUjtonGZ4eAyz4iuobreU3q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7H60Qyto6Y1wx/2LOdDSR09BJmba2b6bPtZhh5cWZ6TCmKfBYbBICuIMB9pGkJrIYhkj8wCuS2iEc3awGbMztS8BZZvmjGXlSHFAhgLMWAaLFGOg0XzExYIkA0v8MEm0UQiDhF0eDqd60/MJ1LvcRE1LfqEufqdnSFri1j2dBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJ5oUVrP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280812ca01so10010845e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721982766; x=1722587566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwKVjdvi7q/mOK8CLeQJUjtonGZ4eAyz4iuobreU3q4=;
        b=IJ5oUVrPdbbZ4gm8AQjTbZwG88gOFmXuzv5a1hOD+h/xmk7oTl830xN8Jw69YlkC6B
         9vdhoFm3ZfzhE5xK2+kfB/tFYS6QllCTeyNmCx8Cp2bV4Ep1vxQ3PGQUP/cRsVkMZYEl
         1nxPCE18PLB23KZs/OEqVpEQ9oEgqDx2WSULHG+L0HsB/qcfTwQp2dL1Od/2KsjDht6t
         YyxUNetri99/OpFXsHanJht1SfZyOJnpcdGog4GyX+Wx5L787FhLotVbwOBy0DH1XvvA
         Iet05AZq1EMMXIpFLLsywRAojFSBfqgLImEJniKNM45hIrMNLc7/jTpwBs8wnxcpNidD
         9YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721982766; x=1722587566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwKVjdvi7q/mOK8CLeQJUjtonGZ4eAyz4iuobreU3q4=;
        b=AoG1+u59I/cmIy6KqrKNoDb+sepr/KOJutC8U7ur/oavwf/bDT5VVHb7gAZmphbBiP
         mFJ8y89IHTSwNbLtNBpWxYavP3ToRlZmwnzQbMSyGpNnCYATDPHtj5hoYZxhdEAuYpz0
         ZZyttklxGYdnoPZuGedasuEk3NKIHtx/bQDAcQg0Qi6PO0vtJytbu4eBUkIlvuj/cQG2
         PpjR2Ocblbzdgf3Yat40/wDLUCP0DUOL4/MK9uZuan8c8PuY4n0gzfipMvAHOCcJ0ODG
         E5kgo0Os9g4eUlNZm8vNVE5vN+DSt6A4Eufq2ScE5OJ/q6Q4KL9Xob5MaDljZmB0pxrc
         P7zA==
X-Forwarded-Encrypted: i=1; AJvYcCVVJ3PiFK1iFXYyErM/IiL7zLuYSjEHeGS6CKHExsbVLJLH2Bqj6N7F4QM66hQbpDEvAm+hd7tXlwacBcGv6VDnT7pWq3blQD+Zlm/C
X-Gm-Message-State: AOJu0YzFZJ/p0ad7jVlTRtwPlY9SLrRNT1vTG0uBpCahQ8fe5XQHAiMl
	m1Nr8/QLh9iBAUpmIVHsK1azSpkkvEIW0ylTjBGWn0bs3JliIViI2skD0dRK58xMU5VWprM1i+5
	ZM6r5aY2zkaeM6JAdv1jdpd3TAYBg9jaetlRi
X-Google-Smtp-Source: AGHT+IFw9aEiWWbNWrKSwIfNsoFiq7Z1Ie3/K23HqXX8wAt/1ZIGy3iHnGySvW1LYIP+uZ2IjLERURUQtmKWmr5gbqE=
X-Received: by 2002:a05:6000:1544:b0:368:557a:c64d with SMTP id
 ffacd0b85a97d-36b319d238dmr4990492f8f.9.1721982765950; Fri, 26 Jul 2024
 01:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-vma-v1-1-32ad5a0118ee@google.com> <3bf6bfdc-84af-442a-acec-a58f023d1164@proton.me>
In-Reply-To: <3bf6bfdc-84af-442a-acec-a58f023d1164@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 26 Jul 2024 10:32:33 +0200
Message-ID: <CAH5fLgjfiE6xNpKVBAgXu=eFyE65k+RxWqNt10J+44pK-mJgTw@mail.gmail.com>
Subject: Re: [PATCH] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 10:11=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On 23.07.24 16:32, Alice Ryhl wrote:
> > This is a follow-up to the page abstractions [1] that were recently
> > merged in 6.11. Rust Binder will need these abstractions to manipulate
> > the vma in its implementation of the mmap fop on the Binder file.
> >
> > The ARef wrapper is not used for mm_struct because there are several
> > different types of refcounts.
>
> I am confused, why can't you use the `ARef` wrapper for the different
> types that you create below?

Well, maybe I can, but it means we have several wrapper structs of
Opaque<mm_struct>. Would it not be confusing? Could you suggest a
naming scheme for the structs I should have?

Alice

