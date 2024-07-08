Return-Path: <linux-kernel+bounces-244931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFC92ABC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E75B21EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413FD14F9EC;
	Mon,  8 Jul 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6c9A7LX"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF185674E;
	Mon,  8 Jul 2024 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476779; cv=none; b=fwL7XLn36I6puAHZPpYXVI+Q+Sp4XCX88mK4ikAnH+psYsMtSUZCbX5GD5jgnBzkX7cJE7kFDOc6DYD28P0kyN9cLyyip8EdBvXL3OJTFyA9sQQmNjH/LoDsVpVmU+xfj9gMOaUrwRr1fSK6arNuIjWzMgvZQdctxr7xkFb47j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476779; c=relaxed/simple;
	bh=4n1Vc9tXg+YIewhgBSUCESwYVFBpDzFDKw3KRl/z55s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9PRg8a68vMp2wP8/dBZRGMEAX+MK8N16y9ehqW2fSk72JUpiYx8GMJi+ZkBMIQFrMrMs/RH9sXzxbG5687X2CKfqiXeqFeegzsOQDl3/CwrrS23ixhM9tLKAl+u7xCmWW+9oyDJ1ZX7WvnMqOK6D+yZdcH+EKSCd3q5QdS37gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6c9A7LX; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79f0c08aa45so127984385a.0;
        Mon, 08 Jul 2024 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720476777; x=1721081577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAOsl3qu4A6KcPFJBGEr5mKU1d6JWC06nIXsQ3Qf2RE=;
        b=J6c9A7LXYBkqDd9TS26+l8B+XRlDWF2P8cgXPomW8RVd83q+mr1lE0HKWv/7ZHt317
         qxIIx5XzRSLOQUt3Lyj5es+qyLyWTo7mJ+oFtYTyTGljo3ek9xTIQw9geVzOgH2ha6qP
         BVjPZc1p7d9rAYxcxjbctZ5nPJeamCqcLimcMkMJAvrr9JM+9EZrLuMujqg0lq0r+/Wy
         tZWRMVKOLduQnUfs33MV/4clqHe/PWAJGoAmsTiFx+AwXcr9GGWA5CFngAc1MEiaf4WZ
         J2O+tHnWDw7+VSo/8Whihubd/1Z0F56L5XPFvjxl4JmuK1TTBjs4sA2OhS4/IF0i3nqe
         CHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476777; x=1721081577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAOsl3qu4A6KcPFJBGEr5mKU1d6JWC06nIXsQ3Qf2RE=;
        b=POfiLR78u29HzkDWfSRXptPb4nNWQ9kzFBGuWMOV9+lR1XwWuJqsfHEJM4h/zAk9U8
         h4RypOLYx4AV6Q0YX/KMAotennnJFzhfV0t70Q3+knBsCl2uhJUnwRKHs/xXBbAz4j6T
         wCIGG8nCzpKjaKicWp9ncUalI6STDl8MrouF+6NMgbdwuqGoh32ZZ+SDejjT7HnOFxyx
         zvgmZM1kGB7H625D5+1Tq8pHxBmTYde2FW6Cr0NnEXUcY0Z8B13oUD/tGpPCyeBATdfw
         DkwqjaZHdRjXUyi3M5plTGm80+IezZFfNHOMyhXkqxOkD0OjmmaNQXcDnAVMbreT4kJO
         5O4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd7dbVRV2U/C/NJGUe6L9CKc/F6dvLGlVYLY9yB8ZcvJ4S5vClrsG1mqk/OGZutnHSRxUH85NLBYVa3jmA8Nf1z3a1dP8NEqHzvAbW1L77XzWhI9MvplMLg4I+TxzYICsz633bSZ2RihL5wa4=
X-Gm-Message-State: AOJu0YzVerKzTYRSI+eurSXuXDeiAW90vhpLQl4p6ZKYTRCwaM99GWIs
	yJOqDiLSmYUJol8YDNf2ZWv3NOmt0x60J7Ko1Fc65ipsGj76CfsL
X-Google-Smtp-Source: AGHT+IFF6zvtjUtSil3YQCaVuVBNZbAuGL+crIdVkcP96QT4wqN0NXECjqWbfVLB7+eaHeRG9plJbg==
X-Received: by 2002:a05:620a:2989:b0:79f:e70:ceef with SMTP id af79cd13be357-79f19a78e07mr121230785a.44.1720476776921;
        Mon, 08 Jul 2024 15:12:56 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3d293sm3736921cf.25.2024.07.08.15.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 15:12:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id CE84D1200071;
	Mon,  8 Jul 2024 17:53:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 08 Jul 2024 17:53:30 -0400
X-ME-Sender: <xms:2V-MZtrSqomAxyL4CFJRZ2BVZ4Tgj_7x_raReQGwWxpHzCvf_0l-QQ>
    <xme:2V-MZvq-Gcyb2lTQBEHuy3v1r6L08KGYajEzj_0Aaj_vA78QVhdCSyxbNljvCNYPj
    kwFlAfN1IFZCstj3Q>
X-ME-Received: <xmr:2V-MZqNEY9qAhysLdO1gmbetpsqRwNk1Mf-L6r1sXb4v6lHxF88dHJeTsXzmkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddv
    hedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:2V-MZo4XFhEo3ZnDNGXr8xeZmGHOgFcHbGJqM-I465jpCJ3Pft4pQg>
    <xmx:2V-MZs5fvTaXVRFyaUZyjnfMNyCigoCgWRpzuLjii7HETn2ixdJ9RQ>
    <xmx:2V-MZgh7g-ku1Ejh7KILunmEQOouq0peDGZfQO9ULjcSAsXSmGvorw>
    <xmx:2V-MZu4jgls2Q4ESYghYIeJELgWSeZvAhER6QJjIVnjnF0NTaG-fOQ>
    <xmx:2l-MZjLtyW62YwbYJ1PWv7-qwbbuHcWirAf7zder1u3sCuceX6qkoJqz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 17:53:29 -0400 (EDT)
Date: Mon, 8 Jul 2024 14:52:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <Zoxfjfl9Izaz2Wtj@boqun-archlinux>
References: <20240708205325.1275473-1-benno.lossin@proton.me>
 <ZoxWyr3fL8GkyOAR@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoxWyr3fL8GkyOAR@boqun-archlinux>

On Mon, Jul 08, 2024 at 02:14:50PM -0700, Boqun Feng wrote:
> On Mon, Jul 08, 2024 at 08:53:38PM +0000, Benno Lossin wrote:
> > Sometimes (see [1]) it is necessary to drop the value inside of a
> > `Box<T>`, but retain the allocation. For example to reuse the allocation
> > in the future.
> > Introduce a new function `drop_contents` that turns a `Box<T>` into
> > `Box<MaybeUninit<T>>` by dropping the value.
> > 
> > Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e134390ce@google.com/ [1]
> > ---
> >  rust/kernel/alloc/box_ext.rs | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
> > index cdbb5ad166d9..6cf79f96d6c7 100644
> > --- a/rust/kernel/alloc/box_ext.rs
> > +++ b/rust/kernel/alloc/box_ext.rs
> > @@ -5,6 +5,7 @@
> >  use super::{AllocError, Flags};
> >  use alloc::boxed::Box;
> >  use core::mem::MaybeUninit;
> > +use core::ptr;
> >  use core::result::Result;
> >  
> >  /// Extensions to [`Box`].
> > @@ -18,6 +19,18 @@ pub trait BoxExt<T>: Sized {
> >      ///
> >      /// The allocation may fail, in which case an error is returned.
> >      fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
> > +
> > +    /// Drops the contents, but keeps the allocation.
> > +    ///

(I spoke too soon ;-))

> > +    /// # Examples
> > +    ///
> > +    /// ```

need a `use` here:

	use kernel::alloc::{flags, box_ext::BoxExt};

> > +    /// let value = Box::new([0; 32], flags::GFP_KERNEL)

missing a '?' and a ';' at the end of this line.

> > +    /// let value = value.drop_contents();
> > +    /// // Now we can re-use `value`:
> > +    /// Box::write(value, [1; 32]);

Need a line:

	# Ok::<(), Error>(())

here.
> > +    /// ```
> > +    fn drop_contents(self) -> Box<MaybeUninit<T>>;
> >  }
> >  
[...]

I queued this patch in rust-dev with these fixes applied, FYI.

Regards,
Boqun

