Return-Path: <linux-kernel+bounces-299105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F22AF95D023
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D351F22182
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E041885A9;
	Fri, 23 Aug 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxBDA8Kc"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB7914A4EF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423733; cv=none; b=gRKqtbWE1/eLJD1/Od1xnBpFPFFGMET0YiyCA47v9RsLg1pBQh894LyiOoitWqDnXqXQy9t0SLrbGoBEciQyF9mrpgxu3BKjaULzAW+tVmlsUjYf32Egqw3TksgALDtXvzD4KgDmu1AhhMkwlyEKOW4hqSPxwNpaoj/IQUF9XE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423733; c=relaxed/simple;
	bh=c3HWaWoFAgmB8EljcQNSX6ZgAU01aTv2LG8hn6I/IL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5LwYI53jPuK4vMkCAVuwvKP0dFaI7eSdJjQwzhZIOv0jFjdrIL6aosBAB7lzdRE6phdMh0O0X7Gbxl3kI0RgJnaogwlFujq1ofJIxyA5KHAFhPteTzOcQPcajQns6pxbh5XbdMVZi2ETPKXQTeVLtKT96f1jELoJtmcuH5Qoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxBDA8Kc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fe58fcf29so11409641cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724423731; x=1725028531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD0zYUJdm5kof1yO+rSoAs76Cq9RGjC/6dlObPwrCXI=;
        b=fxBDA8KcKmrxUa5e6ersLDBtulEgIvm3h+DDXXO9qJ5Hcb8PDchyS6Vv2reo7yCIR5
         z/q3HL7YmLoLTJqkhL9tdaSihMFOma+fkCTLeNDRa2nj9YLj6iJXh7ewviiG5vlqAx3/
         5EcZKJmD+s6b+sw748hIDYkrb3KOZj4/C0O0BGKY4OvV+qxxu4GGZIM8qTvmjPvaPjiZ
         rT0ss+htOrdGcZOZb40giHEvXzz5dioh0/5vhWk6xoq0BVUUZFd/2D2AIokMXlPU576e
         jF/d0IpjKx/XsWe6yUZaMygDA4EyFELLuCabuyRK4QaiWHaEekQGJRA/EVoU9SdTlDHg
         Kk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724423731; x=1725028531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HD0zYUJdm5kof1yO+rSoAs76Cq9RGjC/6dlObPwrCXI=;
        b=mQodKfmQwLPcqcZhaCt7yb5urcH4C9+FNaJyMqDPee/Y6QrGugqRP0Kv2Qm+UGfn1B
         cg6/XzJ0uyEMSHBHnIdqpAp1ZvScxthxsXJhuREX+fd9NH62ggGkXdI3N8hWA869HGFs
         /Pga6zOzGW3sviUtQAKRCHvwPKUT2zkXWuo1rb9xuttf+s1mlnnA8tkhzzh4o/I3mD3I
         SQ6VAneRp0f1KUx7b7nQjrOUtqsWIKNFWBT5bTbTSgaql5nczJNW/xPoWmJxVzsNdBGh
         t9EzhzrFtO5ziHBs6moWViiibAxD1Gv0FFNpRgKm/AUBJcKSYPF4K6cbc5XTx0MHcS1H
         juZw==
X-Forwarded-Encrypted: i=1; AJvYcCW0bxXDoPTmW/MZZpE1cWHJUPUxzL8Moq04RNw0yYjazh5upvKrZzktEEhSu783wSV9DGDTmwkMJqnnWkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNd2k5nyRrmhJVj0xH1qEQdKjNwBsm8RHHzRRSdLf4PldNgvIV
	iDMSwTDvjcNxY21JwNxdhFX3k55Cp+TZt35GFA/BT8j1+dBqmJJis85Rd3VZI2dIf441cqmard8
	1w8ivBzTLYEASbt4EC2wXm8SlyScvuaeX
X-Google-Smtp-Source: AGHT+IESFCFL+ihJkBnUp6givjnwP4o1Pp6kQALg8BhCOcp0A/eLi4A6hjRT9RWUkP3HTXAVkZuPMFV4yiJHkghj5zM=
X-Received: by 2002:a05:6214:3281:b0:6c1:6b00:6e90 with SMTP id
 6a1803df08f44-6c16dc27931mr28556486d6.7.1724423730563; Fri, 23 Aug 2024
 07:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
In-Reply-To: <ZsiLElTykamcYZ6J@casper.infradead.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 23 Aug 2024 10:35:19 -0400
Message-ID: <CAKEwX=PEye=VcXF=r-A9B47VsNtpLLxz5cJiswzuQXBio8rizA@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:13=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
>
> That said, zswap could handle this better.  There's no need to panic the
> entire machine over being unable to read a page from swap.  Killing just
> the process that needed this page is sufficient.

Agree 100%. It is silly to kill the entire host for a swap read error,
and extra silly to kill the process because we fail to writeback - for
all we know that page might never be needed by the process again!!!

>
> Suggested patch at end after the oops.
>
> @@ -1601,6 +1613,7 @@ bool zswap_load(struct folio *folio)
>         bool swapcache =3D folio_test_swapcache(folio);
>         struct xarray *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
> +       int err;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> @@ -1638,10 +1651,13 @@ bool zswap_load(struct folio *folio)
>         if (!entry)
>                 return false;
>
> -       if (entry->length)
> -               zswap_decompress(entry, folio);
> -       else
> +       if (entry->length) {
> +               err =3D zswap_decompress(entry, folio);
> +               if (err)
> +                       return false;

Here, if zswap decompression fails and zswap load returns false, the
page_io logic will proceed as if zswap does not have the page and
reads garbage from the backing device instead. This could potentially
lead to silent data/memory corruption right? Or am I missing something
:) Maybe we could be extra careful here and treat it as if there is a
bio read error in the case zswap owns the page, but cannot decompress
it?

The rest seems solid to me :)

