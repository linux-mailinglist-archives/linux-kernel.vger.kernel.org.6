Return-Path: <linux-kernel+bounces-296234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D2095A805
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2373282575
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3B139597;
	Wed, 21 Aug 2024 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llX0/Ebs"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4769176FA0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281307; cv=none; b=TfeoTyu0UtpuUYBxtpAxfgtmBtwTzojcfCQckjk0wf5B0vLRCi2GTSCxjTy5oqfYItp0NXbOOcoeFRUULc1a3r+gyTWPgqQJCG1VJdqNIIAYaSRoU9DhaobWnbGzX1VFvzg0it7tJR2xXATcRyNm+Mx6ILZLVwN9D0iQKnl/Zuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281307; c=relaxed/simple;
	bh=aWbQKsoO/3O0Lnp0a6MfXVSMRVMVZaRxC4kpSF7nsAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElBnFA+Mv1403bvdKi+J+4SzSCvVC0RWTCqimI14boAyA5y3BWiHcMMnNaArSTIN+vEYTcD40u5cyDOjt+t6+IAAckh3+ffIRm/DVj8zA4/KA8yPzSzLZ61NCxgFhPLr1teIuRSZ0wzk2gw0s54+IZcxhhJQ5uUP3XsXzCFVysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llX0/Ebs; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45029af1408so57441cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724281305; x=1724886105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYqlc+O3M1PAGsmUtdwrYwO0p9/AGmcfM5YGYrhFe/U=;
        b=llX0/EbsQWgvdxkuMG03M4wna6v5q5zCeCqz7SqNw5lp/bqWGLMeWiFQS5I+AOppAz
         yRD1BXQvCMXbl1fexId6GidUm3kwklzprBlBeOMxUMhUUvqIXyK8gqZpafLYPEQzFgo5
         8pHYYgSB0MHgHKyTgKzZAZ94AHAceSyIrrnRVNBuPhWr5wiiwqP1AwBTM/9dnHufGi/D
         5oCqwQvSSzDpp0jyYBiPoZyDSJM2RhN6RoOzm8Oe65yz7leKjEdvwSxP38R4U8+bGzZq
         PtdkEFAW5GDSbWEJLcSX2gLaKPxFw0i+grH1YWORFdvw2Ma3lXOqUVckvan5dJzDiSSf
         c8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281305; x=1724886105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYqlc+O3M1PAGsmUtdwrYwO0p9/AGmcfM5YGYrhFe/U=;
        b=sKkF6bymiL7cATExBJX0HYjRgkvGUZf3aNU422HbyHGPLuUSiR4p9ZsyMKMQb77fUG
         YJQyB+zRkp1LmvoCA/B5Fg0jyUvc7JT5Zq2Xp6ScN2mqU9mY9g/F9sz7umhfpT+eD5rH
         hLNShcqck1EFWl2JjxSBHxuLilWpchjS3BO+3ywTOhpPsFeyvyTV50BcBeWprKTf3+oS
         RXvsTSieIu0GNX7bsitEihhLSu+s7vTZLzipKFEF3YyoZvab9rM/yUzO2Rm5DXuKIZl+
         CW8IRBopjyK2DKBWSF5KwK56SAuIu4EBNj/W2zmJN3FIvFFCjSUOY/XsyH3flYvsfRvB
         LTdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg4dqFDrdBdgA7aucY9DPxw9bJ/VBKrEoOtXOeJO7LereOptTpkxe5f2RRZmPs2zslmb9GaxPyRSKlgs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gBuyYX4yZ4zqM7akStQTpLkZQimJmt9a20SUq35wp0HJDCfr
	VyXQ3WvkSolKfD1rL7m/wVROHEoQwdvf2X11APFPOrmS/dOSAqe2WihtU7U9POz4ftEjAtlfZwp
	Yn38HH7CdJyVnUkmT3nhVqqxRxxtDVt8JwPZ9
X-Google-Smtp-Source: AGHT+IHr6GY8qz9jDAmwr42+hMsnH5B+DA3xc3h3v+2emTPxckOukoEGDbPDha957SRPhSwjOBNcOQFJ2vjqfFpTJfg=
X-Received: by 2002:ac8:5708:0:b0:450:47a5:2203 with SMTP id
 d75a77b69052e-454fd778a28mr587521cf.11.1724281304543; Wed, 21 Aug 2024
 16:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-37-samitolvanen@google.com> <2024081600-grub-deskwork-4bae@gregkh>
 <CABCJKuedc3aCO2Or+_YBSzK_zp9zB8nFwjr-tK95EBM3La1AmA@mail.gmail.com>
 <2024081705-overarch-deceptive-6689@gregkh> <ef6f7294-0afe-46af-8714-ed4a4aaee558@proton.me>
 <20240819193851.GA4809@google.com> <a76f9422-4001-416a-a31b-37ab7dcb17f4@proton.me>
 <CABCJKudAF0=29js8SDcYY5r6kM7RBveTrZH9RyECNGqkcqy=nw@mail.gmail.com>
 <CAGSQo01kCUd64nB7C7Ssy1N=UBpOP3bORsRDcHJ1k2CqkbKsfQ@mail.gmail.com> <c6c1e84a-40f3-41a5-a732-f1cf06521691@proton.me>
In-Reply-To: <c6c1e84a-40f3-41a5-a732-f1cf06521691@proton.me>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 21 Aug 2024 16:01:08 -0700
Message-ID: <CABCJKudN7vGB1gfGDuEArdkH9DL4iPFw3DXMPrX1ZLzPRp8+3w@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] gendwarfksyms: Add support for reserved
 structure fields
To: Benno Lossin <benno.lossin@proton.me>
Cc: Matthew Maurer <mmaurer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 4:31=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 20.08.24 22:03, Matthew Maurer wrote:
> >>> The way `KAbiReserved` is implemented is via a `union` (maybe a bit
> >>> ironic, considering what I said in my other replies, but in this case=
,
> >>> we would provide a safe abstraction over this `union`, thus avoiding
> >>> exposing users of this type to `unsafe`):
> >>>
> >>>     #[repr(C)]
> >>>     pub union KAbiReserved<T, R> {
> >>>         value: T,
> >>>         _reserved: R,
> >>>     }
> >>
> >> I like this approach even better, assuming any remaining issues with
> >> ownership etc. can be sorted out. This would also look identical to
> >> the C version in DWARF if you rename _reserved in the union to
> >> __kabi_reserved. Of course, we can always change gendwarfksyms to
> >> support a different scheme for Rust code if a better solution comes
> >> along later.
>
> Yeah sure, that should also then work directly with this patch, right?

Yes, this would work without changes.

Sami

