Return-Path: <linux-kernel+bounces-514907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D488A35D27
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEBF97A18C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C7263C6B;
	Fri, 14 Feb 2025 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lr6T6Ymv"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1A275412
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534205; cv=none; b=e7p4l/ge+eN5Q2vqWYFGOJNovAKn1XDHL81jf4i/uRKfWkyt0hk/hj5SD1InwHQu4wNTUIN1Q1fSo2Dg+YVTjsUb6qoJjOrsCp/ReJMpB1Ghs71hcB2pwNyHidEXezXhQqHhZYLjiSBPzrEcIXb29ELZ4wtnpK4rRiEanMHq5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534205; c=relaxed/simple;
	bh=L9c0JFwKJ9yBA/bjUoNYqEyW/Hf5BnPlVV9B509rjMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JetmFO7SrYHC8HK5teVnlzU2/W4ZfpT1NddEh8C+dntBG9Nlo23JUD1QnkZH3uJtYNMZHPV9HhuDyryvnkskJgiXoPzArsjuCbDHXmMpPgU56BAEiD1vTsPcYzHAmn5GLbKSFj0Oc5sgPB663qvKf/SlEpQY9/NdEE1tyH3f44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lr6T6Ymv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so11211905e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739534202; x=1740139002; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMR3vBvnlqm3PumoLJkgqkpo27BYfX73XjJodLfEdDU=;
        b=lr6T6Ymvvs0NN4MQ+uTCllni4Jeiq/HySPebjIdwf7zm11vj2a4AkzQEFMS7dLtokG
         PEQ922cQBAgZbttxrFZxEFFSb5kYe7JkWftw62e95DSAcHGSKphTuyGJUAG5r5c+j0ro
         Gw+1s6S8GlBd/ZIrV8rrlwVjuCUeFC6/bBWL7+3jJWJP6lcTZuTg32QeGQJpdMvKgLeB
         1TrqV+Lu6Oj+RFMcfX+/GESnX+vDxtbsGIhAv2cCSVZH73V2lxq0DKxQMA1IQpEYTUz9
         rAK753sp8dB9Bz4CIOe5f9Td/rIowPkoR5RJI95XxSySrVK413CwBlTDr6J9WHxPpQus
         nI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739534202; x=1740139002;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMR3vBvnlqm3PumoLJkgqkpo27BYfX73XjJodLfEdDU=;
        b=tMD57zMegd22SFoOJwpxLV4TbkzXTzL7f2rg4E+6gUD+YzphAL1l2QEscYc7UZoOpS
         iNsn5oyZPemokSSXI9sjks4WoEj++xQ7PsXjLnEQWtgFRGxPcU+D60USPiLA4mdUPpVI
         Vud2N+WPYgWzpjbTKcQT9QPb0ABuuuStwv0mkLj9FaahbNuoXWWK9dCvsVkoWFyVS4Tx
         89Kpj+L15QDDpDcJGd1B7pvA+HunpZARSgvhzp/0tRfDypUPpzlTzt1Drxk8nhXoODgV
         BdWPkgqxrJJ5lNbmTdw48IOOTBF4pCrtY4Cz/4uVs1BWtDKK8Qx1DnW4SlzmmgoAGeIi
         hWVg==
X-Forwarded-Encrypted: i=1; AJvYcCUr4lYgHEk2HCd2uBj/fU4dqr2IWZZ/Sq9mLzjUl8X69yAf2+69MRPFGN8vXIdH1jVvFBtBZQ6odJdtel4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtsV81GvtN+GadyT7Awn6B1+uRmxiFuL2A2TF0IthVKTLtfFC
	XAO8N2djWN4rRyTAR4fEHCfFlqCDXCfCIq2cTtKFWkJBlZDIQQVNgXF5JN0joex6SQ4cm/bDCQO
	taFGhE8vYFQjiyKz7dgbDGjoDq9iFCyHybWNF
X-Gm-Gg: ASbGncuyRhwzDFdTNP7V8UxIVCDPNai8yIMw/Y6bhh1hc1ukqecmmbpQ4Zmd7fFjv29
	/25QrTf89JBTGM3Uy8/OpEGY9sqBt16nNumUNqksN519PIYmti5GS4UvQphZunyNVQZLAfYipFX
	zdse6qfVZVdlwyQ43Bi1if6Ftfd80=
X-Google-Smtp-Source: AGHT+IEZ22UUGVhiiq7xVdL7CJD3HC6qEtfMJUPWWKc2YPQxG9qXcYyvAelDw5b/vP4y3rllPzdwoOMfF19GqBCkam8=
X-Received: by 2002:adf:e9cc:0:b0:385:f7ef:a57f with SMTP id
 ffacd0b85a97d-38f244edb57mr6988765f8f.27.1739534202310; Fri, 14 Feb 2025
 03:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com> <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local> <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
 <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local> <b6b5tnaw6vnuib7nzcm7ajszxiptqz3i2hex5yengzbsirztks@l3coijkqwtpb>
In-Reply-To: <b6b5tnaw6vnuib7nzcm7ajszxiptqz3i2hex5yengzbsirztks@l3coijkqwtpb>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 14 Feb 2025 12:56:29 +0100
X-Gm-Features: AWEUYZmWqwY5t_8PDQeT_6I9FVQA4YJBfP9c7yKAgf-iSodbVpOlpCnJ67_smRA
Message-ID: <CAH5fLgjMC2Q1tjuVtbhMvU-pmEsn1Ai4=AAB3Tm8HTWi7PFHfg@mail.gmail.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and mmap
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Balbir Singh <balbirs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:46=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250213 07:16]:
> > On Thu, Feb 13, 2025 at 01:03:04PM +0100, Miguel Ojeda wrote:
> > > On Thu, Feb 13, 2025 at 12:50=E2=80=AFPM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > Right, I don't mean the rust subsystem, I mean designated rust
> > > > maintainers. The point being that this won't add workload to Andrew=
, nor
> > > > require him nor other mm C people to understand rust.
> > >
> > > Sounds good, and apologies for being pedantic, but given the recent
> > > discussions, I thought I should clarify just in case others read it
> > > differently.
> > >
> > > In the same vein, one more quick thing (that you probably didn't mean
> > > in this way, but still, I think it is better I add the note, sorry): =
I
> > > don't think it is true that it will not add workload to Andrew or MM
> > > in general. It always adds some workload, even if the maintainers
> > > don't handle the patches at all, since they may still need to perform
> > > a small change in something Rust related due to another change they
> > > need to do, or perhaps at least contact the Rust sub-maintainer to do
> > > it for them, etc.
> > >
> > >     https://rust-for-linux.com/rust-kernel-policy#didnt-you-promise-r=
ust-wouldnt-be-extra-work-for-maintainers
> > >
> > > Cheers,
> > > Miguel
> >
> > Ack, for the record I'm happy to help with any work that might come up.
>
> Ack, here too.
>
> Without the drama, I'm not sure how we'd feel so alive :P
>
> Can I be added to whatever list so I can be Cc'ed on the changes on your
> side?

I'm happy to format the entries whichever way you all prefer, but for
example it could be a new MAINTAINERS entry below MEMORY MAPPING along
these lines:

MEMORY MANAGEMENT/MAPPING [RUST]
M: Alice Ryhl <aliceryhl@google.com>
R: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
R: Liam R. Howlett <Liam.Howlett@oracle.com>
L: linux-mm@kvack.org
L: rust-for-linux@vger.kernel.org
S: Maintained
F: rust/helpers/mm.c
F: rust/kernel/mm.rs
F: rust/kernel/mm/

Alice

