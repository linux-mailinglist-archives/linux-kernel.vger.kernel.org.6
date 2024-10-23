Return-Path: <linux-kernel+bounces-378304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF509ACE16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070681C20442
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C21AC448;
	Wed, 23 Oct 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT5aVwqs"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF781AB6FF;
	Wed, 23 Oct 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695505; cv=none; b=S8JGwmlep3YVvPSuQUnX/Dfl+7QboHcLtRCK6j2g+bpGuLLMCtm77wWuES/FLTM2/VTT9HXN3nXspFJis9VemOpzTqeTNZsNVz23CIrokjqqGbD+JJzoeldX/VmwcH1PFT2JpV3k8a7EEI4w4Gc2hRo/QrMRrkJGzlLY25zbJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695505; c=relaxed/simple;
	bh=y6rLQxIyNFoNdsZV/13ky5RbJyH9fi6kCQ3YGmrAuM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOdzNsrKs2C1pvfMFxqyG9CsN04sKGpq+Ynwzj7oXyIiK5WzrtIgXj5F/+b1Es3HkJL6Gpw/lbNkqRq93wxfjLBOLj1qN/XE75NzP6G/LxHQjkyZH3DdSGozKToBqiu4XrE96rvNXwA9e9DOx3WX87i9MDhq9duTsjDUlIjujvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT5aVwqs; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbce16d151so38604946d6.2;
        Wed, 23 Oct 2024 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729695503; x=1730300303; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/bdllJ+6zU6vuA0yP3ixZJuotiMhPKsQQHDy2v76Pug=;
        b=nT5aVwqs5j94+SYOEjlWsKb1PHwYADaL8Wbx7UFh+wPMJYIrSCKhEH41drw9tZT8S+
         q61oUTulGOOgE2dp0ISUFVnMWJRLudkq9cgW/xq3srrKU+mCHMvb2NjGMkClTf/D2Z8V
         faOUkPYD54hDmqUsTuZ8Qbb8qiLlyYAuuQmkTbVYQ1TPFISUb77A9h+PVVt6+BBfX2Na
         B8oipM8oXQ1E8wMwixPHC/Z0zXTsCT8UNiCvS9trD9LqqkM5ojoepAocMBSXBzqng+qO
         FmXFRN3abHv+gFgi7oxTZ8+vuRu+lP5rIhX81uT8wOZ8GHmI2qqySkyRsDYfiudzbRCP
         N0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695503; x=1730300303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bdllJ+6zU6vuA0yP3ixZJuotiMhPKsQQHDy2v76Pug=;
        b=Rnl3d0pYKT4vZ+BN3f5eygH7IfdkeAX1gQ37pruF1aBXvDL/pgQok8eO/FuWAHBDX6
         +I5cxOhfgZVUMxxc5aadic8mAjug9sBD6PJCTkWeGDxh4UptMqJWjO3Q/MmV4h6HbmGg
         75KfEQ5TT9q1+MWEMEYjCsRXzeXguhGcylvkBuhFkHLOTPTIWUNkwoOV9e+2nVqzqdiZ
         PjAtoqBP6YoruskTIFUOzRMEQTIcWnrxlUY5X0fylHbmMy+gTXgrztXMuyQspTMWEOW9
         VFCD5jpl8cJqG+CNXGwNJN1BdHgdI9HuFRwlhcJeCLMFBL5ntHDlVcM34Sc5qK1CPQoo
         +I2w==
X-Forwarded-Encrypted: i=1; AJvYcCWx08mBQCGyGHIBcyiuk3xt2S/l7flulaTcmayVeYUG5LPXlQl05QH6IXBEhv0UzumXnfGHzlDJwAh36RE=@vger.kernel.org, AJvYcCXBVEc5aXTgeiLHTRiW84N4DDEDk72l+gdpCcL14cBcBvzuKnXZJfNCAQJq3fU7PQJw7+BtWFSqJIhnipYtbWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1wWUNWCrs7qIdNEIjD1N4wlsEsgIAzW+B2ymolv5VajjRFFR
	GcelrvwKvmkd73a2unqwlF02Wf0kgSG/deua6TdY3lKLfRUThOts
X-Google-Smtp-Source: AGHT+IFF1C94ugGV4x3EBhPDKydPA33U2GYGXo59U6dvslGWYt3wp4K7Jth18WyW4Vww8+1ekwWnZg==
X-Received: by 2002:a05:6214:31a0:b0:6cb:e4d3:91c5 with SMTP id 6a1803df08f44-6ce3424f4abmr39176296d6.36.1729695502619;
        Wed, 23 Oct 2024 07:58:22 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00700c0csm40189676d6.0.2024.10.23.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 07:58:21 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 28C801200066;
	Wed, 23 Oct 2024 10:58:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 23 Oct 2024 10:58:21 -0400
X-ME-Sender: <xms:DQ8ZZwXd-siF-WWrqG8ZjX_6xJZ1mWC7JbBodM8tciMuiE7zt5EzOw>
    <xme:DQ8ZZ0m19FOAs70VEptDDzEJIIkoN0-ARv-3fH8cKflALyV-BhmgkkfqBwCCm50U7
    -Xgz1e3aIe-ulKXlw>
X-ME-Received: <xmr:DQ8ZZ0Yevf7JbNbaICOzYbVuiDm1-ZmRf047d0AXNbULyMsfQPLzh_0p_2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnheptedvkefgieejgfegudeludejleektedtjeei
    udelffelhfdugfffffeljeeukeeknecuffhomhgrihhnpehpthhrrdgrshenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggsug
    hivghlrdhjrghnuhhlghhuvgesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggv
    rhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinh
    hugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtg
    homhdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:DQ8ZZ_UzJEEnQnFpvfrb3V5aR1qNIQD01IXS7h0N3e3tpIiq93hfHw>
    <xmx:DQ8ZZ6kBONsMBW1AItmVJowVwHH5hJAxPLbPX-dcLdR0Lmlj4ZlFBA>
    <xmx:DQ8ZZ0cnCT93uHMi5Q7mIAIHp8S30h40AI7x4JOCwuYfjoGSBAsgvg>
    <xmx:DQ8ZZ8EUQUryApghnybe9fFjWvHo-ppFWMe6lUiuew-OOm34fMwKUw>
    <xmx:DQ8ZZwkJ-J7BVaf3llZhy4Sc_9F9ZhFlxcYc3xwjgPSfZj7lM2enmJAd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 10:58:20 -0400 (EDT)
Date: Wed, 23 Oct 2024 07:58:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	dakr@redhat.com, linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 1/5] rust: types: add `Owned` type and `Ownable` trait
Message-ID: <ZxkPC-dLRBqBKZ5J@Boquns-Mac-mini.local>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-2-abdiel.janulgue@gmail.com>
 <CAH5fLgjZ91xFo4hV4dPnDXLFr9jX3na60tVt_KuNU_c6WhhzAA@mail.gmail.com>
 <b154dd13-8cd8-4066-ba3d-6597959ca5c5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b154dd13-8cd8-4066-ba3d-6597959ca5c5@gmail.com>

On Wed, Oct 23, 2024 at 01:26:14PM +0300, Abdiel Janulgue wrote:
> 
> 
> On 23/10/2024 12:28, Alice Ryhl wrote:
> > On Wed, Oct 23, 2024 at 12:49 AM Abdiel Janulgue
> > <abdiel.janulgue@gmail.com> wrote:
> > > 
> > > Add the 'Owned' type, a simple smart pointer type that owns the
> > > underlying data.
> > > 
> > > An object implementing `Ownable' can constructed by wrapping it in
> > > `Owned`, which has the advantage of allowing fine-grained control
> > > over it's resource allocation and deallocation.
> > > 
> > > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > > ---
> > >   rust/kernel/types.rs | 62 ++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 62 insertions(+)
> > > 
> > > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > > index ced143600eb1..3f632916bd4d 100644
> > > --- a/rust/kernel/types.rs
> > > +++ b/rust/kernel/types.rs
> > > @@ -429,3 +429,65 @@ pub enum Either<L, R> {
> > >       /// Constructs an instance of [`Either`] containing a value of type `R`.
> > >       Right(R),
> > >   }
> > > +
> > > +/// A smart pointer that owns the underlying data `T`.
> > > +///
> > > +/// This is a simple smart pointer that owns the underlying data. Typically, this would be
> > > +/// returned as a wrapper for `T` in `T`'s constructor.
> > > +/// When an object adds an option of being constructed this way, in addition to implementing
> > > +/// `Drop`, it implements `Ownable` as well, thus having finer-grained control in where
> > > +/// resource allocation and deallocation happens.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// The pointer is always valid and owns the underlying data.
> > > +pub struct Owned<T: Ownable> {
> > > +    ptr: NonNull<T>,
> > > +}
> > > +
> > > +impl<T: Ownable> Owned<T> {
> > > +    /// Creates a new smart pointer that owns `T`.
> > > +    ///
> > > +    /// # Safety
> > > +    /// `ptr` needs to be a valid pointer, and it should be the unique owner to the object,
> > > +    /// in other words, no other entity should free the underlying data.
> > > +    pub unsafe fn to_owned(ptr: *mut T) -> Self {
> > 
> > Please rename this function to from_raw to match the name used by
> > other similar functions.
> > 
> > Also, I don't love this wording. We don't really want to guarantee
> > that it is unique. For example, pages have one primary owner, but
> > there can be others who also have refcounts to the page, so it's not
> > really unique. I think you just want to say that `ptr` must point at a

But then when `Owned<Page>` dropped, it will call __free_pages() which
invalidate any other existing users. Do you assume that the users will
use pointers anyway, so it's their unsafe responsiblity to guarantee
that they don't use an invalid pointer?

Also I assume you mean the others have refcounts to the page *before* an
`Owned<Page>` is created, right? Because if we really have a use case
where we want to have multiple users of a page after `Owned<Page>`
created, we should better provide a `Owned<Page>` to `ARef<Page>`
function.

Regards,
Boqun

> > valid value of type `T`, and it must remain valid until `ptr_drop` is
> > called.
> > 
> > > +impl<T: Ownable> Deref for Owned<T> {
> > > +    type Target = T;
> > > +
> > > +    fn deref(&self) -> &Self::Target {
> > > +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> > > +        // safe to dereference it.
> > > +        unsafe { self.ptr.as_ref() }
> > > +    }
> > > +}
> > > +
> > > +impl<T: Ownable> DerefMut for Owned<T> {
> > > +    fn deref_mut(&mut self) -> &mut Self::Target {
> > > +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> > > +        // safe to dereference it.
> > > +        unsafe { self.ptr.as_mut() }
> > > +    }
> > > +}
> > 
> > We only want Deref, not DerefMut. DerefMut both requires uniqueness in
> > a way that is stronger than what we can really promise, and it also
> > implies that the value is *not* pinned, but we generally want to use
> > Owned with pinned things. Thus, we can't use DerefMut.
> > 
> > > +/// An Ownable type is a type that can be put into `Owned<T>`, and when `Owned<T>` drops,
> > > +/// `ptr_drop` will be called.
> > > +pub unsafe trait Ownable {
> > > +    /// # Safety
> > > +    /// This could only be called in the `Owned::drop` function.
> > > +    unsafe fn ptr_drop(ptr: *mut Self);
> > > +}
> > > +
> > > +impl<T: Ownable> Drop for Owned<T> {
> > > +    fn drop(&mut self) {
> > > +       // SAFETY: In Owned<T>::drop.
> > > +       unsafe {
> > > +           <T as Ownable>::ptr_drop(self.ptr.as_mut());
> > 
> > This uses NonNull::as_mut which creates a mutable reference. You
> > should use NonNull::as_ptr instead.
> > 
> > Also this code will look better if you move the semicolon so it is
> > outside of the unsafe block.
> 
> Thanks for the feedback! Will do that in next revision.
> 
> /Abdiel

