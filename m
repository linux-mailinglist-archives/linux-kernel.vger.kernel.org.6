Return-Path: <linux-kernel+bounces-568183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0666BA68F30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B6B176528
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453141BDA97;
	Wed, 19 Mar 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHds8Fky"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6714B08A;
	Wed, 19 Mar 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394679; cv=none; b=jZRu5I7LCoMUPPzO6GFDiglEZBlptk/mc44lYmphswC3iF7BNcvGGnqEyUVzYa+VVqheIMNosWpG9ZSrOdt7whKeEsOSHMBEyqOmN/Z3lix+FbevBoAVtkEAcbhghbv4v5WFrWLmc3X3JHTeM4aPdIIDJQ5WIyHxOO9+H9o1hy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394679; c=relaxed/simple;
	bh=1LmqcPYwnCj3mzAbHZoHuXE/jGcVZCyiynN75T7aUcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty+by83Q4XO/RBfwU9c8zjV3LZsZ8h7FzvSw9abSrfA+M+hqy53Q4+OmUulOvwSiHpgv1suQbCmynqd/1gj9qjEnQ6/Q1U162l9PWZwDCkVBmgrt405libeNRODMOxsY9g3Y3T6MCcmXXpCMpkCPC54JiME+amUzahoicWHTP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHds8Fky; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30185d00446so1181524a91.0;
        Wed, 19 Mar 2025 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742394675; x=1742999475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvqgHRbIrrQWkBdA7Z6+Pzs4LSHBoaPOWki4q4Ueoz0=;
        b=VHds8FkylgObG2mM3wfa0CNAGbv1J/iCROBf+yslzskL83HaBCltUKaJRhbXB+9tyy
         5hmSCWiDN1e/PhJb5mzzejN56vWNcniKS7fpNtyil2DKalqiDPyR0nvoQwgosqirwTHc
         VIf6ADjB3tJHH1d+/bhLObwRqh4k/L66WXeeNhcAV65jHsljKnuGw8dW5qly8Kv2AI9g
         3+QyT4W6gj34O0CjOcVWqJvH6cCAZANKsI+bCYPoD+//9/klwlMOw8We6SVHQv/nD893
         RWQ0pDaoo42oQuJywYOOyX47U1EqfG7x6KtUuTzkfpNqYP2Kt29JNdmTpJyNXSN308KR
         PgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394675; x=1742999475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvqgHRbIrrQWkBdA7Z6+Pzs4LSHBoaPOWki4q4Ueoz0=;
        b=hPRhFilHYH8vl+EyQoY4qVCnx6oUSx3DcFhsKekpdbpLsn9mYVNLvXPKMyR66tO+SZ
         /olGNjo5o3OJCyoare7YQwq/E3E8LndaHMNJD+CYwFAtYJyiwfC0hfQeMb/YPaodwitc
         heULBOgPNPxLPBqYSMQ/p/c1SNbsZKljT5p/aHs9HOUMiPbcNbLyTLFtgjfvuQjv/smu
         ZHH4BfKVFnKhSKQZf6fpeMjNeqaVIVKU/SmVJ34An8oEomrUmoSGo+NVKtidPTJyZ+PV
         VituX2UEeExaZPsI9Dz9F0hvxIR1jVtrBOdU/+gxGfve3NYI9/2VAcPZfHxf0QvR7Zt8
         dzEA==
X-Forwarded-Encrypted: i=1; AJvYcCWF6tCYD28elwo9W8jU/ebo5E8O++k/MTtqDH2sEANrAf28pLeuozUHcZvkjv/fXjhT3MdKW/k6MD7zBxA=@vger.kernel.org, AJvYcCXGUWImzZabNt8wxxHHFUhLUSdQrn7Ma8bF0DP3jSDC6EY7qYP+/jSFXUqawM3JmRnUIXcWb9OSBLNWWE76NPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrIJ0LzozvTz/sQntXPjrjNofUza2pih5tmaHmB+48nt72Q9Lf
	FfejZjWnD2VZzWwHOv5TnhEXPco26iS0tJwNqPdSwVqtpq4y1Yf1
X-Gm-Gg: ASbGncsKUtK8ReRA5tel3cRSr0Mx1NbNqhb0SeyRDH5CvlS4k1+6WGvRpDNvGflXV61
	SZX+LtRb7xzo+ATmAhRX3m4p5qDNw5WebGMZid8lYZF6Q6ob2YnkOKnrCJNGYcJhgTRd0NDnRWy
	Cp8uRSRaEY9JG3Ksoup5hkjDEter6m3p/MCV7EMpZaGDAE+sEKDCkR59+wmcW5xDOqxAjnCirCQ
	4mSup+QQ1h4d2N6i6n7+OzwwSw3hIatNFwusfuHiiZ1Gbwcoz2rbnD5hZcoBk4Lj908A/fNf9Q2
	wvcOoeiCG1YnU0P7X2oNBawv91tN1MOxIH9Q3FA1ygZ5ZzycXgZ4uae3katA+QCZSqnsV0iahYd
	wKQo=
X-Google-Smtp-Source: AGHT+IF6yMlkkpmwRZofLzUPvdoVeiuovJSIu7oyivZzgn36B31pLb/gQA8RJPRcpim+DfrT0mQnSg==
X-Received: by 2002:a17:90b:3909:b0:2fa:4926:d18d with SMTP id 98e67ed59e1d1-301a5bde7edmr10820194a91.13.1742394674799;
        Wed, 19 Mar 2025 07:31:14 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61b34dsm1627865a91.30.2025.03.19.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:31:14 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:31:12 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Adds Rust Bitmap API.
Message-ID: <Z9rVMJMlx4klpt4h@thinkpad>
References: <20250318164221.1533590-1-bqe@google.com>
 <20250318175322.1627073-2-bqe@google.com>
 <Z9nUzjinU_mozCXC@thinkpad>
 <Z9qe_cLk4FDg_fAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9qe_cLk4FDg_fAE@google.com>

On Wed, Mar 19, 2025 at 10:39:57AM +0000, Alice Ryhl wrote:
> On Tue, Mar 18, 2025 at 04:17:18PM -0400, Yury Norov wrote:
> > On Tue, Mar 18, 2025 at 05:51:53PM +0000, Burak Emir wrote:

[...]

> > Are those 'drop' and 'new' something like a special rust words? If not -
> > can you use alloc and free wording? Would be nice to have rust part
> > looking similar to C. Nobody wants to keep two sets of names in mind.
> 
> Rewording `new` to `alloc` seems reasonable.
> 
> As for "drop", that word is special. It's the destructor that is called
> automatically when the bitmap goes out of scope - you can't call it
> directly. It must be called "drop".

OK, then drop and new.

> > > +        if let Ok(nbits_u32) = u32::try_from(nbits) {
> > > +            // SAFETY: `nbits == 0` is permitted and `nbits <= u32::MAX`.
> > > +            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> > > +            // Zero-size allocation is ok and yields a dangling pointer.
> > 
> > Maybe it's OK, but I'm not aware of any a correct algorithm that needs
> > 0-sized bitmaps. I already asked for it on previous iteration, right?
> > So unless you can show me such an example and explain what for you need
> > 0-sized bitmaps, please drop this wording.
> 
> Thinking about it, I actually think there is a good reason to support
> zero-sized bitmaps for the Binder use-case. Right now, we always
> allocate at least one long worth of bits even if they're all 0. But we
> can improve the memory usage of this code by not allocating any memory
> for the bitmap until the first time we use it.
> 
> The reason that dbitmap.h doesn't do this is historical. Originally, the
> bitmap started out having BIT(0) set to 1, so we needed an allocation to
> hold that from the very beginning. But that was changed in commit
> 11512c197d38 ("binder: fix descriptor lookup for context manager"), so
> the bitmap now starts out empty.

Empty bitmap is not a 0-length bitmap, right?

If it was me inventing dynamic bitmaps, and if I was concerned about
usability and performance, I would think carefully what exactly the
request for 0-bits Bitmap object means.

I would probably consider it as a caller error, which makes total
sense.

Or I would consider it as a special hint, like 'give me something to
begin with'.

If I decided to go with the 2nd option, I'd probably avoid memory
allocation at all, and re-use the pointer as the bitmap of the length
BITS_PER_LONG. That would save _a lot_ on useless small kmalloc()
calls.

The whole business of dynamic arrays is about potentially infinite
number of elements. User of your array doesn't even care about the
exact length, because it may get changed anytime, right?

In that case, the comment would sound like:

  // Zero-size Bitmap request yields a bitmap of an arbitrary
  // non-zero length.

[...]
 
> The clippy linter emits a warning if you have a `len` method but don't
> have an `is_empty` method, since Rust containers usually have both.
> 
> https://rust-lang.github.io/rust-clippy/master/index.html#len_without_is_empty
> 
> But the confusion with "no set bits" seems like a good reason to silence
> that warning for bitmap.
 
So the comment at your link says:

 It is good custom to have both methods, because for some data structures,
 asking about the length will be a costly operation, whereas .is_empty()
 can usually answer in constant time.

In this case both len() and is_empty() are O(1), but the last one
is totally misleading.

You guys would better teach your linter to understand when the len()
is cheap, so is_empty() is useless.

> > > +    /// Sets bit with index `index`.
> > > +    ///
> > > +    /// # Panics
> > > +    ///
> > > +    /// Panics if `index` is greater than or equal to `self.nbits`.
> > > +    #[inline]
> > > +    pub fn set_bit(&mut self, index: usize) {
> > 
> > set_bit() is an atomic name, but you wire it to a non-atomic operation.
> > This is a mess.
> 
> Hmm. I do generally agree that we should try to match C names, but I'm
> unsure about this particular case due to the underscores.
> 
> This method takes "&mut self" rather than "&self", which means that the
> caller must have exclusive access to the bitmap to call this method.
> Attempting to call it when the bitmap is shared will result in a
> compilation failure, so it is impossible to call the non-atomic method
> in cases where you must use the atomic version.

Does mutual access implies memory barriers? Your code doesn't add
them. Is rust compiler so smart to realize that you need it?

I mean the following scenario:

CPU1                            CPU2
a.set_bit(1)
                                a.test_bit(1) -> 0
cache_flush()
                                a.test_bit(1) -> 1

If the above is impossible, then yes, your set_bit is atomic.

> We could call this method __set_bit, but using underscore prefixes for
> methods is very very rare in Rust code because prefixing a name with an
> underscore usually means "do not emit warnings if this thing is unused".
> For example, when locking a mutex, you might write this:
> 
> {
>     let _lock = my_mutex.lock();
>     // do stuff ...
> 
>     // _lock goes out of scope here, unlocking the mutex
> }
> 
> Here, if you called the variable "lock" you would get an unused variable
> warning, but prefixing the variable name with an underscore silences
> that warning.

But underscored method is not a local underscored variable. It doesn't
have scope.

> We can still call the method __set_bit if you think that is best, but

No I don't. Nobody likes underscored notation for non-atomic bit ops,
but it's a historical thing.

> because underscore prefixes usually mean something different in Rust, I
> wonder if we should use slightly different names in Rust. Thoughts?

This is a new project, and you may decide to change notation. Just
please be very specific about it.

So I'd suggest the following:

1. Mirror C interface: __set_bit() and set_bit()
2. set_bit_nonatomic() and set_bit()
3. set_bit() and set_bit_atomic()

The last one looks the best to me, except that it just the opposite
to what people got used to in Linux. If you go with #3, please add
both atomic and non-atomic set_bit()s in the same patch, together with
a bunch of comments, so people will be aware.

> > > +        assert!(
> > > +            index < self.nbits,
> > > +            "Bit `index` must be < {}, was {}",
> > > +            self.nbits,
> > > +            index
> > > +        );
> > > +        // SAFETY: Bit `index` is within bounds.
> > > +        unsafe { bindings::__set_bit(index as u32, self.as_mut_ptr()) };
> > > +    }
> > > +
> > > +    /// Clears bit with index `index`.
> > > +    ///
> > > +    /// # Panics
> > > +    ///
> > > +    /// Panics if `index` is greater than or equal to `self.nbits`.
> > > +    #[inline]
> > > +    pub fn clear_bit(&mut self, index: usize) {
> > > +        assert!(
> > > +            index < self.nbits,
> > > +            "Bit `index` must be < {}, was {}",
> > > +            self.nbits,
> > > +            index
> > > +        );
> > > +        // SAFETY: Bit `index` is within bounds.
> > > +        unsafe { bindings::__clear_bit(index as u32, self.as_mut_ptr()) };
> > > +    }
> > > +
> > > +    /// Replaces this [`Bitmap`] with `src` and sets any remaining bits to zero.
> > 
> > Please: replace and set, not replaces and sets.

Also, bitmap_replace() is an existing function. It's better to avoid
that word in different context at all.


