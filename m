Return-Path: <linux-kernel+bounces-309174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868EC96670A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB10DB209D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950EC16C6B4;
	Fri, 30 Aug 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Puiqd24N"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5513BAE2;
	Fri, 30 Aug 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035681; cv=none; b=oKCeod8lWt+dTNtivDpgCzkCjv6v8V91lB09bJepHhmO6K8QT7nkkuXLgsX8Ck3Xyek6PAMYD3Wz4h/cz6sidJHeNgKFphy48/2fImEWErkZbwChpccsz2NyXD3ihgQJiKBP3/7YsFecO9ltzfewPgKItflRUBJgIhHHWORsvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035681; c=relaxed/simple;
	bh=iFzf0Lzty/5yMH4AQkyBN8IKf0cDxoABsMXKbvCcmOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwrBylRx7TfXzlA5XkJUV3keV6zekemM50rbnHheIHB0YEC2n9jLixal4ufmeJPoVJRCgkACimfXnQUdC1C+k+rO8noIzCWtOD3TAZqS0nkbGSF7ab6tC/BkzTzJCUR+NY1bGNWFHyqQGcwdcNRmk6SZ1iN8CQfkJu9D6Z7cpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Puiqd24N; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4567587224eso11463331cf.0;
        Fri, 30 Aug 2024 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725035679; x=1725640479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UuncYEpLqNPDMV52iLjYpBbuWE5/gdn/gZaZV8ruJY=;
        b=Puiqd24NQZlWnZgk1/yUZR99GzL1zJPOjywXqWrwAtE5RDy2S9/X3qowjvYrFnzzX9
         iBkLa1ICqmf9kTfzIfzuk8vxXNhORN2MWczDJApLDQwj8lq5VZXIuVDmIhP3SwcoHzJW
         FZ8mh3KAS/yftmw0uynn53cZMwf+DOioFQOG+BqM7dMy/S8HI4pv/l36YetqK9WOHIff
         o0a13sdE60rolPsJAw3odlrTIxp+RN4idBiSZkDg7Ipp/5e9Piw1h+Eh+iyk+5S4hsyq
         z8EQGdJEI2kByF10+85dGyCbDDYZUmOyRmK3gR3awlMXLRqR3sfqo4tqb9fkaYaEXwnS
         CM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035679; x=1725640479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UuncYEpLqNPDMV52iLjYpBbuWE5/gdn/gZaZV8ruJY=;
        b=nltI63mY10utEQfGMxR6VadU6LAPWKHXWWQdcUpQNvaDDY06Nqz/zSm6lqnAOqZQgy
         IOqKEuYPF5LQtRxkZYp0Ai+KMCymeyimDejom0XZAT4PHJv+46KOxkGYTAoc4NWI8ESx
         eM/BV9SH+/CS5X7cTZJMIWXNiFCL44KxQWe05Q2LpwFQFyPmHEdM6MNuNfmVjWUNC22e
         5ZbS16um0yX8izD5uk03iJueuUhj4hgDoB0iGu5qes4a0IUPcHpdSMiySkSkowKRHM96
         z8jlTGtCFXBvD+giDfBiLjkNcrObaVMHKrNLFjH2DNlB+ziSZVg7DayyZNeQmZjZoPnm
         k15w==
X-Forwarded-Encrypted: i=1; AJvYcCU1jG9UhAGFtxIjCgUOvf9kuKmgg3gfznflX4LZuCMg9FpB7/t4/VEgC/xMwfnJ6GEPOENxjqk34FrA3O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cFtS0TcNIh9fpVfKFuwX4UXUKV3UvThgnofdNlU3qv0c1mPu
	yTK95hQAxvtDNvJZuzfTp/o7oGTFA83IAop+n1pQvNiHePyGuUth
X-Google-Smtp-Source: AGHT+IEThTZ4xKh5mN+fRZwI2iFzvcos3RJSkzDDdnkBqxXLHqtt0P1KtSwmRav6LrT88HooOIUBUg==
X-Received: by 2002:a05:6214:418a:b0:6bf:6b15:a6da with SMTP id 6a1803df08f44-6c33e62780bmr64898766d6.25.1725035678888;
        Fri, 30 Aug 2024 09:34:38 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340cacccbsm15931756d6.129.2024.08.30.09.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:34:38 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E5C4B1200043;
	Fri, 30 Aug 2024 12:34:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 30 Aug 2024 12:34:37 -0400
X-ME-Sender: <xms:nfTRZry0Qlh7vpx1oQqcnKrHGRnb4XIcP2_LWErdrEdaHgWNcOzIjA>
    <xme:nfTRZjT4DXD4UNmxoderv9V9XGFIckmXGcI4FQr5vVt1UAQ-4Bc45G9gGJu94VYDr
    VVe2k7QhuYmp2PGJg>
X-ME-Received: <xmr:nfTRZlW-QSJNpEbZwnYRS7jNuNcxmVNHDyfwXIawU7sET36IOVmMYCtgvfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepffdtiefhieegtddvueeuffeiteevtdegjeeu
    hffhgfdugfefgefgfedtieeghedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehruhhsthdqfhhorhdq
    lhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhi
    nhgusghorhhgsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:nfTRZljUPRhh4BLtS3S152_uk6oC6aVTf-wtsK3jDw3uA01q20xqTg>
    <xmx:nfTRZtA9fix1m5OJctmIseslus_qaASqiGxIsCnRJUJAdKLjV7rI1g>
    <xmx:nfTRZuLN7zkwJTfmoddc4fjtzJnjn6SZR70R3z6KxeMDnvBWXRodlw>
    <xmx:nfTRZsBGCVl5PhHJZjxTP7gPjMa4mj51fmFi-5eKzOcXYG-xqy2lqA>
    <xmx:nfTRZpxsNACeIxEEmv6xIsnaWKX6x2H86uekq6gmzrpucpwqwyyzgreA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 12:34:37 -0400 (EDT)
Date: Fri, 30 Aug 2024 09:34:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [RFC PATCH] rust: Provide correct provenance when constructing
 THIS_MODULE
Message-ID: <ZtH0nK8ytZCiZs-_@Boquns-Mac-mini.local>
References: <20240828180129.4046355-1-boqun.feng@gmail.com>
 <20240830160532.4a526a62@eugeo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830160532.4a526a62@eugeo>

On Fri, Aug 30, 2024 at 04:05:32PM +0100, Gary Guo wrote:
> On Wed, 28 Aug 2024 11:01:29 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > Currently while defining `THIS_MODULE` symbol in `module!()`, the
> > pointer used to contruct `ThisModule` is derived from an immutable
> > reference of `__this_module`, which means the pointer doesn't have
> > the provenance for writting, and that means any write to that pointer
> > is UB regardless of data races or not. However, the usage of
> > `THIS_MODULE` includes passing this pointer to functions that may write
> > to it (probably in unsafe code), and this will create soundness issues.
> > 
> > One way to fix this is using `addr_of_mut!()` but that requires the
> > unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
> > an extern static `Opaque` is used here: since `Opaque<T>` is transparent
> > to `T`, an extern static `Opaque` will just wrap the C symbol (defined
> > in a C compile unit) in an `Opaque`, which provides a pointer with
> > writable provenance via `Opaque::get()`. This fix the potential UBs
> > because of pointer provenance unmatched.
> 
> `const_mut_refs` is getting stablised so we should be able to use it
> soon. I am slightly inclined to use `addr_of_mut!()` over `Opaque` in
> this case so we can use it directly from bindgen.
> 

That's the reason why I put "RFC" in the title, although I feel `Opaque`
is better, one of the reasons is you can easily provide a `*mut T` with
wrong provenance (e.g. casting from a `&T`), but it's harder to
construct a (or an? ;-)) `&Opaque<T>` incorrectly. So if an API takes
`&Opaque<T>` instead of a `*mut T`, it can reduce some user errors.
Therefore personally, I prefer `&Opaque<T>` (or `&UnsafeCell<T>`). But
of course, I don't think this is something really strong, and I might
miss something, so I don't feel bad using `*mut T`.

Moreover, besides `const_mut_refs`, we also may also want to wait for

	https://github.com/rust-lang/rust/pull/125834

to be in stable to avoid unnecessary unsafe.

> That said, the current approach also LGTM.
> 

Thanks!

Regards,
Boqun

> Reviewed-by: Gary Guo <gary@garyguo.net>
> 
> > 
> > Reported-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/macros/module.rs | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> > index 571ffa2e189c..aef3b132f32b 100644
> > --- a/rust/macros/module.rs
> > +++ b/rust/macros/module.rs
> > @@ -217,7 +217,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
> >              // freed until the module is unloaded.
> >              #[cfg(MODULE)]
> >              static THIS_MODULE: kernel::ThisModule = unsafe {{
> > -                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
> > +                extern \"C\" {{
> > +                    static __this_module: kernel::types::Opaque<kernel::bindings::module>;
> > +                }}
> > +
> > +                kernel::ThisModule::from_ptr(__this_module.get())
> >              }};
> >              #[cfg(not(MODULE))]
> >              static THIS_MODULE: kernel::ThisModule = unsafe {{
> 

