Return-Path: <linux-kernel+bounces-433010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D6C9E52E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AE2856A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7751D89E9;
	Thu,  5 Dec 2024 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8nR0UJo"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BB2391A1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395711; cv=none; b=bfLbqEVets5dkE7JgtB6obYgnP3fVZgOitgICcFRHn7UybsivH9NATgP+mDYKElO2yJqvI/ikbZ1cXoBEArP4r2of1buLnnBawkqFEcLcNsZ1hVA5WO1MW7Y6jyHFZMxdLmDU00hrDlsGuKzn8svKRq4LsrzhsZ6TTOIgkdOZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395711; c=relaxed/simple;
	bh=IxTz9zgttBOQ+lH0ph6RIITGv0Uth2xEdLeUBCMC6Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCX/f9YOanUZtqJIGUkt6Kd811pFqf1UxEvSd6p6KDvPtDNPqyCWqdCt9pG0YrHbv+U3MsAGjn8WUL/5upyF1DW1aV3CQTB26NFPFw+jkSN9+Okmi0WHaff/ILtwDWDLiRG9kXd7ZEJNKsOtlJs5US6WWLS2R7FX3rvKJ91By6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8nR0UJo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a83c6b01so5089855e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733395708; x=1734000508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxTz9zgttBOQ+lH0ph6RIITGv0Uth2xEdLeUBCMC6Lc=;
        b=K8nR0UJoOB1y+E4LvGEuq4sXIjnHqJ+Bt/bayZdAdL7B7YZrBsgvj55Veggv9wbrK9
         QBjqDfT/LliaMYHY/ZA8ALXs4BkfjBtmk76kAQWvfUi1UaF5KiUahIVqgV43PtejVsOA
         NoFSbLQAX0Co67hqLmGjOsHRja5Ijg5Kgb7GBA+eOL4OHkys1AFZol1uvA0zNQUIxXh9
         XxkH4dKEwa1Qs0Dcn0L2TFeA96JC8io8nqD3dmR7CXZ6/A2URahsj8j7sHpfG+QX76oI
         acXNI/VWsEBwt1d9z2luDYYaAkkyXYdrXWX7FIg88gwBWBVQdKw4jKTfE0LVW/oaYOXs
         sX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395708; x=1734000508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxTz9zgttBOQ+lH0ph6RIITGv0Uth2xEdLeUBCMC6Lc=;
        b=Mts0uFV1Ctcj1aIR62+vnmPs3EnF5zbimurk/7w0JnDzaulH/yqEpjgcfCcK6ah+RB
         Cd5NunRj1k7towe92ex4sHjNdb7i+YwZH02rgnY+gH/oPvCTcwc9H6X5OsiGOrAlPG6s
         8IDmRYdy1D2Y20asRxp3R5sGBfAHH6RjyzNbmJKgSfS3oooWgbkZo3EiM33ebsxq1UN6
         BiUGBhPu2AGiP0RhReQIKbIHsUzonVL4y7zFEDtGrRSaccpF01CgI3yWSfHogayKE6YW
         mudsfrQgyA91yGG/IcJa9vaq8SeWZCsJe4R8RH1AsGk8eKHAh+Q4CwRx0vmOP6fCZMR5
         EQQg==
X-Forwarded-Encrypted: i=1; AJvYcCXyQ8SbXArE1vMa8BkLFKykJWGo9OBluDzpm/6eguoglwIHZ9+JtyeFWrk12MloykKOC3pyEw/EBviGYys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5eu24AOI0WSDFYdou5Jj8xHfpJVlNI8dfYFHLuNPwjLM8RKl
	MniKpUxhSFyE7NZSCVujj0D+Vu3Mt/2aVYfDgO7xeXwNtSgWIbgzTCOTj27dqR5Xqvna06gO5A6
	RfkwLB45yE8K2fvOIltZBqmf2PMzWjHkWA/Y6
X-Gm-Gg: ASbGncv8f+yJ98Gqp4Wm1NlpI9oIeAgPRzMdELmG0r1aGeLKYAueCAD0QInj7/5nAUr
	54eThznVoAYina74WcXdmNiVjpoUWbc9i4yltlNjPso6x7YaIIdqbZqAQ4Aaw4Q==
X-Google-Smtp-Source: AGHT+IEbHnZx89I6BS82qCs+JQ5CGtVbg/W2xXe2U7Jo5dGn4llV3v/F1YKlT4a62G5qQqKIfepFCQ6XOik9Hc67qu8=
X-Received: by 2002:a05:6000:2811:b0:385:dfab:1644 with SMTP id
 ffacd0b85a97d-385fd3f502amr5477346f8f.33.1733395708123; Thu, 05 Dec 2024
 02:48:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-vma-v10-0-4dfff05ba927@google.com> <20241129-vma-v10-2-4dfff05ba927@google.com>
 <CAH5fLgjxmpcLJwj5k85O39R00+vRRixA6i3xeK1STe_LQLHkTA@mail.gmail.com> <ab86d283-7393-4b11-b08b-ced744de7f82@lucifer.local>
In-Reply-To: <ab86d283-7393-4b11-b08b-ced744de7f82@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Dec 2024 11:48:15 +0100
Message-ID: <CAH5fLgg9ay1tWpKo91hYXn0dmj2Gzk1mZLvf031nnTzKbQbTZA@mail.gmail.com>
Subject: Re: [PATCH v10 2/8] mm: rust: add vm_area_struct methods that require
 read access
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 11:45=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Dec 05, 2024 at 11:40:03AM +0100, Alice Ryhl wrote:
> > On Fri, Nov 29, 2024 at 5:32=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > This adds a type called VmAreaRef which is used when referencing a vm=
a
> > > that you have read access to. Here, read access means that you hold
> > > either the mmap read lock or the vma read lock (or stronger).
> > >
> > > Additionally, a vma_lookup method is added to the mmap read guard, wh=
ich
> > > enables you to obtain a &VmAreaRef in safe Rust code.
> > >
> > > This patch only provides a way to lock the mmap read lock, but a
> > > follow-up patch also provides a way to just lock the vma read lock.
> > >
> > > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> > > Reviewed-by: Jann Horn <jannh@google.com>
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >
> > It looks like binder needs a way to check whether a given vma is
> > associated with a given mm. I guess we can do that by adding a method
> > to VmAreaRef that returns a &MmWithUser.
>
> Presumably this would be with a lock held to ensure the VMA doesn't
> disappear from under us?
>
> I guess that's implied by possessing a VmAreaRef in the first place.
>
> I also suppoes that the mm having users is implied by you having the VMA
> that implies a lock held on it :)

That was what I was thinking.

> So that's probably fine then, as long as you can implement some sensible
> means of comparison between a known 'given mm' vs. the &MmWithUser.

We can use the stdlib function core::ptr::eq to compare the address.


Alice

