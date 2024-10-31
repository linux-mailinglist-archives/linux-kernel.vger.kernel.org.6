Return-Path: <linux-kernel+bounces-389979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408E49B7400
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F028622C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F313D29A;
	Thu, 31 Oct 2024 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fYsPVyL"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EE13C906
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351190; cv=none; b=ebFRlUuc6ItZXLfpxL+pWYhjK/9KNk38XcEzJ0u09nHmjDDeIjNXms/s12X3xBE8FhmDEkSCj8pMO5qDgX+Tw9/pzR1B8q8SkSH3RFQ+YXAY+SB+/6CLsraam8BUuWUK1dS+uGidO7jxr8toETQlVsYjUZxlWu/MccbHLG3a7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351190; c=relaxed/simple;
	bh=CFQpG6SQWKfCkcBSL/I30J6EEER7ES3CKQCiV1mDbS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha2yQgGJjLFlf4VUD6/mEn9knA+xRz4q0v8PKz8kFfBqOoEK9Zn6uTkJOL2hTbWW1ER04ATR7k8n9NUoM1jqB6GaTSqrVUOpATrYEIeGMZBdVTRDEQxcxRZRDQsKJA5dL6Khx+TPFylJB2C2/eDcZsMBpBYgY50PY1bsvVBIPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fYsPVyL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so321a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730351185; x=1730955985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i2Hp+Jo553Bp7SVYgd1y/RHX4+QcCFvIVpGPREXUzM=;
        b=3fYsPVyLoT2T4oTbcm9S/y5jCqTwGNzpZJdqL7Xb+ZesNgKoMlz1QiALWKXuOd+X7r
         pTVtADZanbzDZFhbwcUIS6cvjKXM5NpYnmyp45ePviv9o3q0PFWCKgxLzGeMtcIo9DPk
         hZLWYkNFAHy0DRiug3CblKiGd7/12zZ7cmvQu3PsBVQ0ZMD/9cyiMRyXmwAamjSzUbOF
         yfUbqoaa/ZJ7HctqTzTQZKeZIwBSkDroxZiEbF0ZJnKCEAdQV3J6i4nwsRzDz031BkEo
         HOKXuPe35qUd7eEJifY8ZGHYVK/BTyPKHpk6OjKf8+9/FmhiTf3Icqknwfcb1U0Ly0Kp
         9sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730351185; x=1730955985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i2Hp+Jo553Bp7SVYgd1y/RHX4+QcCFvIVpGPREXUzM=;
        b=dO9t9XlUgJe5UYfhEGtYH/EPHAW4RhEY+8HJ1YbFetYinnD1n+DdQ7SzJE+CFRk65k
         V7XjeOQosX+F+TRJL/AAudJHtAyXIOPWWcIMa+aoBoztcWy6NDsi++JPJsdnIt0eT36r
         jThKbvx1TrGM4M112cZWrs4aFUwqTmwMhNSgjLb48QOCU5slreLUbamYorI4cYbvg9GK
         W4KxyfkGyf6qUjtPtviM6V1ciNzxut/Nu81XT8dkmpUWO5X7fIzgaDSZO/dMDk0O9oHl
         dDFYTGbk7eqI61hqd/LWG7I5V/eVtK9wTdE98qm9y38EhiMC46pNtd3B6fr4K2Iio1yj
         rPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlF597W4hg/AVW3AsKnPJsNLhzjAtnwt5yoeZ8fgsEBhhoXwKZh648tLZO9F0tT4xVKgnuA7X+ncKOge8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8ihX6mCAvNBo/vB5Qzc/k1W1L1AXFMu4Lz4JsrFsa8RnRc1x
	L1EPmAW3C9xwrqCjhX4b+17hp8jQFgiX9pKZTiqQbdb2Lt60yom50LhV+Ui5SMY6Ql1uhOM8uVz
	LlRt4bSelEd5psj2Xlj2BeLeyHwbR/tOL2zsP
X-Gm-Gg: ASbGncsoqpc/jTYAN2QnulLh9/cte4jA8D85zJwifsW4pSilI5kVfAgKZ2otMd4Dzkz
	rjLU8Id7IVLI5IPd7wVaMYnhTed+XqFr22tAgzYRoPM7l+jJMmnCIHAKiCmyd9coU
X-Google-Smtp-Source: AGHT+IEa2MH5wcVvPPE8kavAhbMUGA/AKUSL18Rtzs97BVFow1m5e63bvnyqTFocsSVTt92eT3Zz91fTBE0w+m9p+IY=
X-Received: by 2002:aa7:d6c7:0:b0:5c4:2e9f:4cfc with SMTP id
 4fb4d7f45d1cf-5ceaa4c1727mr5520a12.6.1730351185225; Wed, 30 Oct 2024 22:06:25
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
 <20241030-extended-modversions-v8-1-93acdef62ce8@google.com>
 <874j4tcbhf.fsf@mpe.ellerman.id.au> <ZyMJaFcF4dTTzNgK@bombadil.infradead.org>
In-Reply-To: <ZyMJaFcF4dTTzNgK@bombadil.infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 30 Oct 2024 22:06:12 -0700
Message-ID: <CAGSQo02H_RwtLpdt4E_LWKjzGvryY_7s20e4QhhA5B7N0LPxVA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] modules: Support extended MODVERSIONS info
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:37=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Thu, Oct 31, 2024 at 12:22:36PM +1100, Michael Ellerman wrote:
> > Matthew Maurer <mmaurer@google.com> writes:
> > > Adds a new format for MODVERSIONS which stores each field in a separa=
te
> > > ELF section. This initially adds support for variable length names, b=
ut
> > > could later be used to add additional fields to MODVERSIONS in a
> > > backwards compatible way if needed. Any new fields will be ignored by
> > > old user tooling, unlike the current format where user tooling cannot
> > > tolerate adjustments to the format (for example making the name field
> > > longer).
> > >
> > > Since PPC munges its version records to strip leading dots, we reprod=
uce
> > > the munging for the new format. Other architectures do not appear to
> > > have architecture-specific usage of this information.
> > >
> > > Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> > > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > > ---
> > >  arch/powerpc/kernel/module_64.c | 24 ++++++++++-
> >
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> Michael, Matthew, why make everyone deal with this instead of just
> making this an arch thing and ppc would be the only one doing it?
>
>   Luis
>

I'm not sure I understand - the PPC changes are in an arch-specific
directory, and triggered through the arch-implemented callback
mod_frob_arch_sections. What would you like done to make it more of an
arch-thing?

