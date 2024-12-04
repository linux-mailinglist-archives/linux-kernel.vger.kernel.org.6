Return-Path: <linux-kernel+bounces-430880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C8F9E36CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA0F283A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B9199FB0;
	Wed,  4 Dec 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCtcplt4"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE251194A59
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305213; cv=none; b=VyXU4Hv/8PKei70kafi968X8Xn+TT9fu6lDbGYNFvycsLRy/YUKNHI9rT+4cESa+T4Uq3OYZuUKPnp9XaQRoXfjUepFhaPSRA1SrlRPdJn+ZLNK/TaXMMfMKGop0tzZXlw/gRM/5vjMLYjVhakHb+/8AxDCbX4xFACeELxo6Ed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305213; c=relaxed/simple;
	bh=ciZiSF8l2bRuo96MgTGys453NaZJ21QaR/1Vkn6LbeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkDX+vDj/1gA9BAI9EjSTCoxQdbLk8tzUh/Y+i3Zh6W+6ajrEPkGQRm6IxXvtXUwPiTYqfgMLxpiuklExpUxi8qHo3yrMG+VoRkrU7Cre0SZ2lFwMuBKGNCLPNUkhuQ+xV/HXc1i6PJUMArVZpub+rZ+98atQAHP+UdoCKHK0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gCtcplt4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e87b25f0so386439f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733305210; x=1733910010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFrZSoqi/L4Q/j3dvgmVmN/U9TUdf5LF8q9wgVtrI3c=;
        b=gCtcplt4f6XD4q1jiJHyZE69SyX1IQ+aZqKXEmsXIhfui4dnhrq+4fM5jIVtU6RwOc
         wRCRgNmARsOyDh9FtMhTP93xQNABe+/SuLHQr8Blkq0batbnhTGdgn1HFNWAi8tVXF1J
         E8cLYPcd4j7ZNZJ7qUJKYR2/rW/XMw8ltVU3FGmpq7hfk02C2dt4P9Hng3evZQCz2gMo
         bNasRKUzdZMf8MhvUlCiwlaVMoRFOYgtyNNQzgg78MoUw3sMO3Ry9AnmNggTAu9TRFnF
         qoRimJW1ISLuOY0BGcjiSbnMiAHmVhn9RQWguWjVduYnNKCwjjOFd/xWmdyF3UYIgWZo
         qnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733305210; x=1733910010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFrZSoqi/L4Q/j3dvgmVmN/U9TUdf5LF8q9wgVtrI3c=;
        b=oyX5rLxYeBPKmTz+OU744WQ8fZgGQS1/IF7wkuIaHnpZm7eTjvrXM1FZPYCXQk5kWz
         aMLTX4XT/Ve4kNPVNk0p/PdvJQGcnlNVXEmQY2cH6PyeY2amlaUR2Yb+gXCDOAo9s9YQ
         DivlzZk5qYlAahkzDLx3jpdfBDf9fAnEfeFxbpa/qfgiz7mtHFJL3VJsFP0mh6MBssxw
         weWvxHBDs2cIroA5eYcrOsYu1+zgmnqgxkRu/AvVJxZw2ReLhQzu6vyqRu7H3Gix75sD
         mf1DWBoxW5tUzUsVd7Scr3HboYwvO4hHMufVenvkPb6CGcKETIArrq35nxqSSeRqcKgk
         9N5A==
X-Forwarded-Encrypted: i=1; AJvYcCXkDkCopVYR1gV1mBZ8yGK7FApmS6IN9zGumhqwtMVamrQ2Nxx8iCIGwsyfVOWpW2Ge5nFUMBgqXX6lYJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOqcXv2OvglWQNktf9mk1SeW7Xf/EqNjdnFYIYSNNFCQI/XXLS
	Aa2KZpkn1MnQABAdPbtPfmYsAruiAKv7aNQgWokciR6jQcGcdDyz1QMnGGCZnBsfEd/Qtp3dhJQ
	etGuVawgL62MfPAr7FOOcNAAYq2QPoIx4Jrh4
X-Gm-Gg: ASbGnct+/7Lhr+qRGeNuy6cgx/4wDmYMYc6QVtegtjfmSdkrNAPmyjhqHPrqgaU7z5a
	O7OQNME5ssuIvQASizi3Fr2N2u81PuuBovqTPfsnMUFd3Tn/p2A6I+RndW8cSHg==
X-Google-Smtp-Source: AGHT+IGRblWIDZ2C6Yh3qV1LG4hQ2laf1qX4XN6zuWGMVMNt8LaHH44zWnW45GQaqyEOBqEtoQDCxGpUzAmCqXr5PCo=
X-Received: by 2002:a5d:6484:0:b0:385:e10a:4d97 with SMTP id
 ffacd0b85a97d-385fd9abec7mr4009298f8f.21.1733305210170; Wed, 04 Dec 2024
 01:40:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com> <20241203215452.2820071-5-cmllamas@google.com>
In-Reply-To: <20241203215452.2820071-5-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 4 Dec 2024 10:39:58 +0100
Message-ID: <CAH5fLgiarbw82R34Ct=GP3-6ophJOuhuRoerr427gHsEPy+Rcg@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] binder: store shrinker metadata under page->private
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:56=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> Instead of pre-allocating an entire array of struct binder_lru_page in
> alloc->pages, install the shrinker metadata under page->private. This
> ensures the memory is allocated and released as needed alongside pages.
>
> By converting the alloc->pages[] into an array of struct page pointers,
> we can access these pages directly and only reference the shrinker
> metadata where it's being used (e.g. inside the shrinker's callback).

Using many allocations instead of a single array will increase the
number of allocations a lot. Is it worth it?

> Rename struct binder_lru_page to struct binder_shrinker_mdata to better
> reflect its purpose. Add convenience functions that wrap the allocation
> and freeing of pages along with their shrinker metadata.
>
> Note I've reworked this patch to avoid using page->lru and page->index
> directly, as Matthew pointed out that these are being removed [1].
>
> Link: https://lore.kernel.org/all/ZzziucEm3np6e7a0@casper.infradead.org/ =
[1]
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

[...]

> +static void binder_free_page(struct page *page)
> +{
> +       kfree((void *)page_private(page));
> +       __free_page(page);

I would cast the page_private to a pointer of the right type here.
There may be tools or future improvements to kfree that use the type
information.

Alice

