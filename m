Return-Path: <linux-kernel+bounces-302892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C709604BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BB32822C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE5199E88;
	Tue, 27 Aug 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqLrf7GJ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653051714A8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748278; cv=none; b=CxpgjB9LVQA1kVDqpzesB1W8kIOEzy8h6XK+wn8orMoLsVQ/E1EIVKTSjESjORWlQVtEsUeQ67qs+bTGQdq5hcDCGXeeCIMccZpgyWSH7pR8d3VDqi9UgwNrXrbJ0IwbSruTsnaHlw5/U9ELMeFcNBPw57JKSNc8riyigbXFcwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748278; c=relaxed/simple;
	bh=NvbeC148oSRbYXMM0uzSxMd4msog5xZUYO0JEMUJOOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMferSWVPIgSdw+rv38dr1K9u19Npa+63whqQZsoDZCO4G6EG8WiMxO4JzMHTV8wnH5twMd8bwWH9+1MYSpdimamBMbF0uZUkDHmNCeb/408Fz4Rb/dN5997ElQ1+FcFZ0F/KwbY0d8B9eWJoVIcjTNNgJ7vrEjcfuDkuSwcs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqLrf7GJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37186c2278bso3291510f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724748275; x=1725353075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/3mAhAO5h0s/qUUCeFcScHoCRmtt4LbfBn/mVCsy1I=;
        b=UqLrf7GJk1WupUC9xoD42lZVBZf9bHjeN3DXHQJnFTv+ckjSRpB8lY/nyRVheG3V+K
         2gWV/GiYqXDK8BZi8twV7IvUQ/73cJtV0ENoPMzLE2GlYvYsl0pA3s9nYN4oX9mArWSO
         HdRyTsBoKeZ8eSqw4Jdy/LLIZefVF7oq3VDIb2dedBHLGbGHkFjVStIatdfX1nlLAnBQ
         0DRSyYqxcAsocAIQW1um9HBE/nBmA1btIO2d5uVSE69q4uHJM7puJJe7KRb6PteJ7lyY
         8KMNoli1UAe3SCs4DLxan0BNpOoRle+2BKCpLxZYdfY5rohQOBBXFf8B7oB3uvyRJm97
         wnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748275; x=1725353075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/3mAhAO5h0s/qUUCeFcScHoCRmtt4LbfBn/mVCsy1I=;
        b=bhPptwAKZuNc3ARJ6W9vueAXyx5+/kz9KsGp05v4SfuxmVut2lklagOHJweJ0EBx7P
         XAVVUwOOAEXerLV1713sMYbolZhLKnia/h0tsyz3EHuOM+KVuOgmmO5yWXsBEVG9CllS
         mPvNkXpqKSBxXP3N+EdlaBpyvqTZTispSUEXdctZmKNP7uYvpqhxCH/9ZGVp+YOhxMVj
         a5sM3PKzrcQGGmxsn5LBpmPkAodFI+52dOHr4Vie/1CaRsBm8P0q9H1Hf/MTJLixoELl
         QlBoCcKR+fkasiToa1qZM1ShRLYS/w/NhIToxwocfLDBV88JKata6GDvjAXa66RN7ctz
         3etw==
X-Forwarded-Encrypted: i=1; AJvYcCUcqOM8GVSFnc0HfHWF2pidT8/AYU7qzIos2K6xn0VHLXjFp3GKRXi9P/E3UlP7FrEBTAXh9bmDqsZamak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmRhKoeMkp8dNtsJTC3syLVy5+6EgnWLWVocxl6wJaIttgA8d
	eCCius4nBE76uUe2Bx7nDKZ5kGMuxc9O4UeA08qJS1fxMB8lT27eknVN2EJFD3J+phTT9KQAqK2
	kpgiGs4GDmKmn7uPu1EbTS+YtftFHttByfndd
X-Google-Smtp-Source: AGHT+IFYTHQlYLYW/Qk5Rja0NVX3FfQ92z+GUd/bLTu1Q3IiU54YX4Xx5iOcW8R6LXMQYW4lLg0MDKKJc0XPIyhj5L8=
X-Received: by 2002:a5d:4a43:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-3748c88a644mr1182066f8f.19.1724748274370;
 Tue, 27 Aug 2024 01:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826-static-mutex-v1-1-a14ee71561f3@google.com>
 <9feb41cc-cb1c-4d0d-a3df-09298e69af69@proton.me> <CAH5fLgjtSVMcKL4aMrNT=zJPGvzAPJt3qAUMYdB-+3=s80FNKQ@mail.gmail.com>
 <91ce9f9a-5def-4f5a-ab9d-9bde4736cca0@proton.me>
In-Reply-To: <91ce9f9a-5def-4f5a-ab9d-9bde4736cca0@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 27 Aug 2024 10:44:20 +0200
Message-ID: <CAH5fLgj3fZpHQ3Mxz-1tNgmR_Y9Cpqrxwo2HeT+QT36bYoD0xA@mail.gmail.com>
Subject: Re: [PATCH] rust: add global lock support
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:46=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 26.08.24 17:31, Alice Ryhl wrote:
> > On Mon, Aug 26, 2024 at 5:30=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> On 26.08.24 17:27, Alice Ryhl wrote:
> >>> +    /// Initialize a global lock.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// * This lock must have been created with [`unsafe_const_new`]=
.
> >>> +    /// * This lock must be pinned.
> >>
> >> You could also ask for `self: Pin<&Self>` and remove this constraint, =
or
> >> is that not possible in your use-case?
> >
> > The value is going to be in a static, and it's inconvenient to have to
> > use Pin::new_unchecked when calling this initializer. Not sure much
> > value is gained.
>
> Can't you use `Pin::static_ref` [1]?
>
> [1]: https://doc.rust-lang.org/std/pin/struct.Pin.html#method.static_ref

That's an excellent point, thanks. Sent a new version with that.

Alice

