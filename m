Return-Path: <linux-kernel+bounces-199560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6C8D8892
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20D1281E15
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018481384B3;
	Mon,  3 Jun 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjOH/eo6"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2212F373;
	Mon,  3 Jun 2024 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439166; cv=none; b=Ng7xvCP/k5JUNPgJ3Q2ydL8EyjZI1MLV1oAjkWaFffUn31M6oo1dxsTpHIneZ0jKmJIknbl7Zb0Xr60fbq1aSUnK0G6qEq4pnlRc5zJnBnfPcXjMvLTMU6ySGxFt5m0oYvGguuSwNd4dEiYn2wmnu8gLmMap7G7PaPZFpvgpQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439166; c=relaxed/simple;
	bh=hjKrTRchuhmFlhG33L5CgE68znNAIqP22uwAWh2alu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbZMV49FZby7O6gzfIsxZssAOSJY8RxFg3OOS7j9hmJfhvaCIARxVaMxTxrjrqZsLDnc6sUEA0EFOGi7i0F3E5+znzsV6mAKLoYMPktBtgoxdILPgIYWXvI1M0we/Up/tkt9eoTdTYhLuyCNdr6KGco/F0q+A+7Y0XOETfA+xCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjOH/eo6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-794ba2d4579so307462985a.1;
        Mon, 03 Jun 2024 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717439164; x=1718043964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fCFyJO/J5aHagK4bUMQJpa9iUDqH+pER8Q5gFOrJVdM=;
        b=UjOH/eo6rScp0bn00jizVx2sNdX+10CFdscxmGc4ESFMpl7pZKFCrCzihhRHbgscoR
         DsZTELmcJK/kpxkTzywfiidRP1mapsAvIx9dLf6tGd1cNAmahBLv1DfHJRz6tt+9v5lO
         vjSvjwK2W5RPJkJtRkFjGFJzu1mQ+e24nwMflnOQbP8c9DnkyiGbiVWIExIjFuMQ6/0b
         8QWpfXOwM468sRQybDYf3uj6z1f/w5FJotK4lrIvaUj7G/wSmjgaGLS5kcgVM4NBdR6N
         RSiYOVrR7AV652Y9DDLinedDQWtFc2NAA4Tgm38jgw0+e/iOYNTs/oETeq2FwozaRGQ9
         /EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717439164; x=1718043964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCFyJO/J5aHagK4bUMQJpa9iUDqH+pER8Q5gFOrJVdM=;
        b=LMRfY4GCyeE52oNeljQIp+XSJOxsNli0RuEp9Hsva675JcMWCz2F57UD/iCI7bcEmo
         18BxK/y2kl2GUFvwDl3LIfblRxqda81m/cepl+pMFx+U+er5CXvzvGvJptR5q44chx+i
         Kd+v6/tm+T1RScDXpBKZ6w9+6z7Xk9GU2n8D6hzMqSceQXZP5lwkl9iWZliLc2nx5yyY
         1P7B//OyedK6l8TIN7X6bWd869zf2qO0IqLoqFjt4UUvwyVhs0mBYTORVYxt8DQSwDQM
         arlIxnfMU/ytYgVxDexlP5dqxK1Zg4tjFRlSiwiWiVA0qNEF99jTgrfL2m468WKbb5y+
         7sww==
X-Forwarded-Encrypted: i=1; AJvYcCXmIw852IsctKFbLBaMs35DicjYUO/E7Wm6F/haFJ9A+e+v68LyyPLFO4ODH4Z/kxfUQsLwh2jMU56Myk2IY+9qBaOj/z+SqGJPx7c5HHyVqjIfQcXCC1iFV6EWQf1a6upOtOOBMhJmEd2aLJg=
X-Gm-Message-State: AOJu0YwopyhB0uzczstYEgK39Mu1sVWzDsJ8wD6jFWWLJpF+WwI/XOxd
	0l8IJxDWakyV44nWDbjpkRIPERxRFRtnoxLpT0DLTlqB+gU0CX+g
X-Google-Smtp-Source: AGHT+IHi5QY6aOU/WfdEDsoZ702+Jha+1ivkfvHI/THqRPTrQpNhiNk3cEqtuiMPLisMQiaU7SLgBg==
X-Received: by 2002:a05:620a:3bc5:b0:792:a238:4a0a with SMTP id af79cd13be357-794f5c5c44fmr950558085a.1.1717439163670;
        Mon, 03 Jun 2024 11:26:03 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f31716edsm301547185a.104.2024.06.03.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:26:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A3F281200032;
	Mon,  3 Jun 2024 14:26:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 14:26:02 -0400
X-ME-Sender: <xms:ugpeZhkVnqFjwoGCUq5fc1yFmQnJN7IuSO6G9j6OWS2sRC3WnE6GWQ>
    <xme:ugpeZs2NRUBklufRDCsWnOYpwogKLxgPWlLJrmQdCMFctmtcnlChN4z3jcAP7XFmt
    uUStF5vIu7pWcOfXA>
X-ME-Received: <xmr:ugpeZnrmX1GBBTuE3NtJ5aehKDBPpC6uhwTo4Qh7monQHbMn_5aPWLp7-dRXvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ugpeZhkqQlgN8v1fINVHwT5LEt15Rd2fBf-_Gqjrr-uHCKL5gjL22w>
    <xmx:ugpeZv0mTr99AvQ-hoWMcsijv9QP-of8U3ou35Ux9hAWnwOfADYfOg>
    <xmx:ugpeZguEcIO0F98DgyeVOaDVIgMLYhl94ipdYCwb1bLiwA8FM3MDUQ>
    <xmx:ugpeZjWsS8SlJ1T5FWkZWfKqN562ohf-Ql9v7Bk7SNJmuB5ZTdOiHw>
    <xmx:ugpeZm29fFA423pXYIVBs0olCZq9MoG4WAdlEPMengsiDFEqU2fJ9bS->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 14:26:01 -0400 (EDT)
Date: Mon, 3 Jun 2024 11:25:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Matt Gilbride <mattgilbride@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>,
	Michel Lespinasse <michel@lespinasse.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] rust: rbtree: add mutable iterator
Message-ID: <Zl4KgPuFn9HSmXen@boqun-archlinux>
References: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
 <20240603-b4-rbtree-v4-4-308e43d6abfc@google.com>
 <Zl4AVUqq8Hd-a230@boqun-archlinux>
 <CAH5fLggfMNcuu0KD13_K49NBXXWD133BB6uc5ph7xQi0WTxBZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggfMNcuu0KD13_K49NBXXWD133BB6uc5ph7xQi0WTxBZg@mail.gmail.com>

On Mon, Jun 03, 2024 at 07:52:36PM +0200, Alice Ryhl wrote:
> On Mon, Jun 3, 2024 at 7:42 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Jun 03, 2024 at 04:05:19PM +0000, Matt Gilbride wrote:
> > [...]
> > > +/// A mutable iterator over the nodes of a [`RBTree`].
> > > +///
> > > +/// Instances are created by calling [`RBTree::iter_mut`].
> > > +pub struct IterMut<'a, K, V> {
> > > +    _tree: PhantomData<&'a mut RBTree<K, V>>,
> > > +    iter_raw: IterRaw<K, V>,
> > > +}
> > > +
> > > +// SAFETY: The [`RBTreeIterator`] gives out mutable references to K and V, so it has the same
> >
> > s/RBTreeIterator/IterMut ?
> >
> > Also `IterMut` doesn't give out mutable references to K, which makes
> > me think...
> >
> > > +// thread safety requirements as mutable references.
> > > +unsafe impl<'a, K: Send, V: Send> Send for IterMut<'a, K, V> {}
> > > +
> >
> > we can lose the constrains to `K: Sync`, right?
> 
> Either Send or Sync would be valid here, but almost all types that are
> Sync are also Send, but the opposite is not the case. So I wouldn't
> consider that to be loosening the constrain.
> 

You are probably right. But it's a bit pity that we miss the `Sync` +
`!Send` case :-/

Regards,
Boqun

> Alice

