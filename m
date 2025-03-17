Return-Path: <linux-kernel+bounces-563332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D4A63E60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB29C3ABE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEFE2080EE;
	Mon, 17 Mar 2025 04:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEHOld82"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABB140E30;
	Mon, 17 Mar 2025 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742185969; cv=none; b=qNg9MNBNXibdQitQql8Y+st72jLY1h0JP1XhiFPvzzBkRpZwaAafC35Y3RTVvNjiYk+2E8RVWrT5hB/DeszJzuItlX2ZDosfOdHhhfcBenUu7VG1jYardfL3wHhkj3reGaBabSuWesazVyYoGLtAIqQJFAYPz1R/V6IIj/S2YtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742185969; c=relaxed/simple;
	bh=2SdimwpHKWgYHXE66CJ46HkbaQg5iDFsA6BYDwJ2hg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4aiT2h3uUfQkXDEJw8uIZEQgphGnMBiJ9KL9r+42uElcHaPH0FIjxg2Ep0cskjK25XUjtB988sowmv3q93TOnxllqPBxSssTnU0KbjwK1W6BmxhuJ9tkj8bDuy5Eap+Y7HXrkVm9IqwZTRRNI4uFJg+OC7uf587uT2Is7GVZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEHOld82; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46c8474d8daso35285411cf.3;
        Sun, 16 Mar 2025 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742185966; x=1742790766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9dqufYgh0fyD9FV/7pLNG6sVYtwehfa7tkru5bKQk4=;
        b=JEHOld82YjDzXkBA5TyPbNgv9l/mWpvKjZbG7HB5xrHroXPWFoxP1JR8/LUZOBGQi9
         uy5ZSdQ1at0I0OdT9PzfCVJBt6lLHioG88WNkp+VpObsJ5YTfWgpEb6Al/N1LRgChMQ3
         CPwzaEFonXPKEmQepJisxE93jgex75BQVzpbXy2vQM35GQmCUPMDqnidC6vyK2NLcGG6
         6utwQZbCdvVDf0QDLKsgWhp+HkSftDkaw0ncSxWLhtHD6U7cXHzQAIEX6cudsBbahjlo
         gukJCIYX6V2k+rl2ip+nP5KgsT8ZfK1hvYYbMrSFrtQimaPPiP+KiUXeJqs0x4ofajfF
         YKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742185966; x=1742790766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9dqufYgh0fyD9FV/7pLNG6sVYtwehfa7tkru5bKQk4=;
        b=uHgavOIrF92ewNPj7y/j4MP+45rZ17a5ShprMNS1U2ELnrJSZiAvr/D6jaM1xwX1HF
         Z+c5Jm5dcddA8LG0iBI4gcXfjg//91gNnhGPEGqXf04Nd638Xbp6y3JsifGp+DrTWDAt
         AiquVFKubpXH0XMJjVUM4jlTVbtdWz4uZdkEx6Cq9/uAzOS19+vSJetGuf4HVdY9Zvvl
         4pqeE4X1TlPFJO8njVw8LosjLnuZ0b+T8Zb4fZD17V10J6U5CjXXV4lYHNOu+wSHvEzT
         7+9TO0Bj81usXlDC7oATh+1R14DpO+U7sf2Ka2Tu/izaL9yxjqLagq6RT09FH/oyRmCW
         qVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqmNFBAdgyeUMSlSwJd017wwlokBXBceeSka9ni51h5OPfvn2P1SZmKRT53u2GP87MOE5m0H0o9ZbS6E2bDKI=@vger.kernel.org, AJvYcCXKy2eQt3JH2aAID5e4IpKAzX+7reMADUv6bjz7hlAVhD9sA+SYfuJXwpk1WBbklBG3imXr8YFLz0nVbtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62VJlolp39axH1AkUm89QsIJwdRD1XExnYrXwo4+X4OYyDAPj
	S23ApjmAbMxT3GYkleQFyZrMg8u7X7S5AmNPT+cZEoSn5XVqTGf0
X-Gm-Gg: ASbGnctvkx0fYy4HgqP89a+L+11kjyxCyKg/xyxO4pqNYmyhBMnhnemYScgRd3duUfu
	Ef9fIqN5ddH5VOfa8CcTV7vWD7vbT5AL1doWoYPXytnJTWd1o7NuQYxBl5OliKBlOzIQNwSGDJP
	B9VikKGi9vq/jk/2AYAO7CJ2dTfz5yADbT353Fipn9HUtq+3mVHhGuB3krG9h/73fcAbI1/qUMm
	Mj37Zh91n5elRz2HYVXZn6pYpmo6Z/R1XF5tHDnPASClpNMAabJLKMyHEQNPchvscQl1vTJE+Wd
	ahVpbMlzNc0YmMcqKwKF5h8rEh+VUlhC0B2qcg8xukkRIjk2+Az7VI56pvGiGtcM723qbXywYwI
	Pb+rPantVpaXtPOqRSdu8WbgzV7fNi/Z9TyU=
X-Google-Smtp-Source: AGHT+IGr7aDjNX7m6tFfUwFKKS3lWqhE5kxW2W52pmxUT7hTm2zuCjlr4CPLRlE25zMxRMEJ4dOYQw==
X-Received: by 2002:a05:622a:1487:b0:476:8917:5efe with SMTP id d75a77b69052e-476c81c8c5bmr152323901cf.42.1742185966489;
        Sun, 16 Mar 2025 21:32:46 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb831efasm50342211cf.80.2025.03.16.21.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 21:32:46 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id AF6F01200043;
	Mon, 17 Mar 2025 00:32:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 17 Mar 2025 00:32:45 -0400
X-ME-Sender: <xms:7aXXZ7sv-zMcUYBp3HVEMlzjPhzJPlxRX9pZm-kldrKoJGp5omlCWw>
    <xme:7aXXZ8dwL0GFvH_C5Pf2gP-5BYeWoF_tohPFtzxEyTmMCJRUxvYcniy6ZSHAkOcN7
    owPECctTYD0wxsjTQ>
X-ME-Received: <xmr:7aXXZ-wmWuGOdQZ5XNvcCBz-f9nUiI7ogJf5oLvANMrjiTBEjDVnsYQV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheptghonhhtrggtthessgihthgvqdhfohhrghgvrdhiohdprhgtphhtthhopehojhgv
    uggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghp
    thhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhi
    nhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:7aXXZ6MGzsD6mTn48NHY35yMO7w_9mia8j7v9xh6S4FZq7IgUDOVgw>
    <xmx:7aXXZ78JN-YrDORfiUWmOLuZtZD3jIUCfXwofkS8FcJtsaeh6OhLwQ>
    <xmx:7aXXZ6VcK5dCmPLJTvpewsfoxDxaXpjJQ6M2_k7jSfSNflmz9i_7ug>
    <xmx:7aXXZ8dBbEMncvKSU8KYwK3dK4j7R7skY9dkvxYngDxKEj6MP7hsow>
    <xmx:7aXXZ5eYVTb3X2HwVYfux_85R-cHqJOZItL-fjYsbWmZkUu72DqiZZPe>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 00:32:45 -0400 (EDT)
Date: Sun, 16 Mar 2025 21:32:44 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Antonio Hickey <contact@byte-forge.io>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/16] rust: workqueue: refactor to use `&raw
 [const|mut]`
Message-ID: <Z9el7P-_jrzb7w0i@Mac.home>
References: <20250316061429.817126-1-contact@antoniohickey.com>
 <20250316061429.817126-10-contact@antoniohickey.com>
 <Z9ejLCnJHvaRWgQ4@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9ejLCnJHvaRWgQ4@Mac.home>

On Sun, Mar 16, 2025 at 09:21:00PM -0700, Boqun Feng wrote:
> On Sun, Mar 16, 2025 at 02:14:18AM -0400, Antonio Hickey wrote:
> > Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
> > with `&raw const place` and `&raw mut place` respectively.
> > 
> > This will allow us to reduce macro complexity, and improve consistency
> > with existing reference syntax as `&raw const`, `&raw mut` are similar
> > to `&`, `&mut` making it fit more naturally with other existing code.
> > 
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1148
> > Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> > ---
> >  rust/kernel/workqueue.rs | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > index 0cd100d2aefb..4e27df324d26 100644
> > --- a/rust/kernel/workqueue.rs
> > +++ b/rust/kernel/workqueue.rs
> > @@ -401,9 +401,10 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
> >      pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
> >          // SAFETY: The caller promises that the pointer is aligned and not dangling.
> >          //
> > -        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `addr_of!` so that
> > -        // the compiler does not complain that the `work` field is unused.
> > -        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
> > +        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use
> > +        // `&raw const (*ptr).work` so that the compiler does not complain that the
> > +        // `work` field is unused.
> 
> I think we can actually use the pointer casting here. Because now we use
> pin-init for Work initialization, so `work` field is always used.
> 
> Could you replace this with a:
> 
> 	// CAST: `Work` is transparent to `bindings::work_struct`.
> 	ptr.cast_mut().cast()
> 
> in a separate patch?
> 

Hmm.. think more about this, this raw_get() function can be a safe
function because it's just a pointer casting? I've checked the
callsites, it doesn't seems that they need the pointer provenance
from Opaque::raw_get().

Alice, any objection? Am I missing something subtle here? We can also
remove this function at all, and use cast() in __enqueue()s.

Regards,
Boqun

> Thanks!
> 
> Regards,
> Boqun
> 
> > +        unsafe { Opaque::raw_get(&raw const (*ptr).work) }
> >      }
> >  }
> >  
> > @@ -510,7 +511,7 @@ macro_rules! impl_has_work {
> >              unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
> >                  // SAFETY: The caller promises that the pointer is not dangling.
> >                  unsafe {
> > -                    ::core::ptr::addr_of_mut!((*ptr).$field)
> > +                    &raw mut (*ptr).$field
> >                  }
> >              }
> >          }
> > -- 
> > 2.48.1
> > 

