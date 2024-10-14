Return-Path: <linux-kernel+bounces-363845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 264F599C7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B58FB218A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A161A00EC;
	Mon, 14 Oct 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yE6/v7N/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA691199249
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903378; cv=none; b=IIgB/it6De5JVboc01jCxl5KZjm0+i/8FpujriN0J5JRgDnuH1Ma2YaDIstHcYKnsy7e1YQ6AfmqfVrW7NBuXJd7tTLxTV+AHNxFO2J5iFqBZ3QzUmOgTLbF/ZyK+5jlAUOkZ88s7RYVwm51JMh6abF2gw5XLd3BJPx1wxVaIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903378; c=relaxed/simple;
	bh=Xx7EaSar/S2rSLvZ8rXtHhKPcKbC9rBzFsJKDME9CDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPWR9yrFOt6njE5NgHeE9kODyJDh4A6zLkMwdvKusomwyftNnNDScfszUT/5KNcjVrrs3a1c8feqck6ocKpeJ4/JnSoOThKoDSkaQoOoIDnzOG+JV0d9Ny7HhSBdfmbM3seln5DeBkuqQIoET3ckz6WAiHxzEyUyl9shay7Wc78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yE6/v7N/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so40332705e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728903375; x=1729508175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4gp6e12cg+sqnH5wDR5jIQXbUcLC2B1xW6NEdqt2eU=;
        b=yE6/v7N/Ml1YeO4W/EOoFPv25KnQ/oYeSfLKQpxuMTsXwu3Odcil9evc7kwID6JRKl
         VGeX0WIxtckje64FUEiSenGgRQiQpPaI0TXCgVzcqUO6WW18SQISAYpoqL1aOpWcCLDT
         BFBrBMi491Y56DPxOI5ge0jrSGiX0si/tchIzY7j/6dUh+B6oz/dEMdJ23NeHqw2t35Y
         8/1+i7AMYGUIBVvLAWz0kAjs6oJomBfmvt1UsDMnNKFc/aFZg1IwQQU4xxALx/v/XWco
         W2QefVQ3En+UEZ9n4H2oe/vbWpDZfLKm+uGrpl3nhCITgwrgsb3ToMBsju+kvOufzaKn
         2ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728903375; x=1729508175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4gp6e12cg+sqnH5wDR5jIQXbUcLC2B1xW6NEdqt2eU=;
        b=ZRM6SizA6h7kEv0fyz3T90Vs2Ha/ZaEVVzSHO24cZ3RMmWgMb7ot+BnGF+XekHKzFh
         ZNrCgL0j8ODPCWlbsI9JBoMV2uLcq290KgDLE7rK4rpQDp/3QUhBxPq9aSmTnNrN1X4w
         XmUttNqCHdUsozDuKkTruF1N6htrDC9H0AycfnhtkkccrzOgoUNRMnd+LrTgiBOr7xcj
         q00E6Eu37viroNcFviB8PxXbaemN1bbn761OWElMsH7kjM+J+0C51k4xOwWO29RkZ3H4
         M07b4psWzuPclKzi+rsEolW1uLq7mj94Q6NTWoexf56mc4/pEwKUDSgxMjlUDiLzqlbo
         EZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCVLLCRqrpG/TiichSurOWu3ryQ2I2RJDU7x6uMkvOApYuf1kOC8ow6YPsvGTdrHzHAj5PQ52C/heCiFU7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynoqTMVM0X4Rjpxibrh8Am3DtP7JGF9hyEkZbICSP4sxpsJqnI
	3sgkTTaHk8K1Fh6SXEMXlu7cXpMxlJchs8VTeyZdC0xXYadetI6PWHaRtfKQ2I8x6iGEeu6fF7c
	A/IQqcqfxIayRh9YK69fKpUf2qK7nWMSby0gA
X-Google-Smtp-Source: AGHT+IE5eRoWQDx97xOv2leEqqV4jcEBkFr3gadIwamzFJS8TDNfpmwWZcvrbJruha+0XkR+9A8/cfjYWgRPs4yHYCk=
X-Received: by 2002:adf:ea45:0:b0:37d:4cef:538e with SMTP id
 ffacd0b85a97d-37d552d29edmr7335919f8f.55.1728903374819; Mon, 14 Oct 2024
 03:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-vma-v7-0-01e32f861195@google.com> <20241014-vma-v7-1-01e32f861195@google.com>
 <CANiq72n8oKnAWVj71uus8FuYEqqi+Bvy2zJ4SP=DX9Cgd39UKg@mail.gmail.com>
In-Reply-To: <CANiq72n8oKnAWVj71uus8FuYEqqi+Bvy2zJ4SP=DX9Cgd39UKg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Oct 2024 12:56:02 +0200
Message-ID: <CAH5fLgjSzGojkkDyETOtU_UHBGyVK5=8WfpsBm5nMqfBQvK+ag@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 12:47=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 14, 2024 at 11:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > +/// #[repr(transparent)]
>
> Line in docs.
>
> > +/// #[repr(transparent)]
> > +#[repr(transparent)]
>
> Ditto here, but in this case also outside the docs.
>
> Some trivial nits I noticed below since I am here.
>
> > +    /// during the lifetime 'a.
>
> Backticks (some other instances on lifetimes too).
>
> > +    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
>
> I would add `bindings::` since otherwise it may be confusing to say
> the C name without qualifying, since this function is also called the
> same way.
>
> > +        // SAFETY: The pointer is valid since self is a reference.
>
> `self`.
>
> > +// Make all VmAreaRef methods available on VmAreaMut.
> > +// Make all VmAreaMut methods available on VmAreaNew.
>
> Backticks.
>
> > +    /// Can contain "struct page" and pure PFN pages.
> > +    /// MADV_HUGEPAGE marked this vma.
>
> These are copied from C, so it is fine, but we may want to take the
> chance to format them.

Thanks for the docs issues. I'll give others a chance to comment too,
then send a v8 soon.

Alice

