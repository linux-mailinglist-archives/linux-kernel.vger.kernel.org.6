Return-Path: <linux-kernel+bounces-557299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F6A5D6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7CD177C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64B1E9906;
	Wed, 12 Mar 2025 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sm+nUs7C"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54B18858A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763119; cv=none; b=KzRvHKnVFWliwb7ypHw3LaLCbv8TxCT6ZT1QubC78ie3eBl0z9I91NwdcITRhEJsDpkrYrm6Rj5+RTAP+r1/vbqnaSmsmqmh2cjW0+8BWRTAgjYxzmXDkJe/bx9lyz5lKh9X1N9A/fPBsaKXnwY0mh5remwHNLJIXeL/CyXWvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763119; c=relaxed/simple;
	bh=FEbOfK0ey8liI08NuyrWFEw0OniKYYGH/Dmyspp9NK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eCekHggdL/z+UgSpymBc/Elb6EMprmOkGRt3IKrX2JSZvWqpMomB3nsMLh00jBOErnOgkNRsESSfMT5No76/LAAzE/iRlT+Em8zwImHDSTpLzwwXOY4Eqmb2NIstYiQJs5Sw13U9N/T4zTuZ40CLhKrMytslnbNvqCz3hG+bjS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sm+nUs7C; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so44425055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741763116; x=1742367916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4BN7/p/kplLMFpVggVcZWXKc7X2r0rN1QbraxZm9iOA=;
        b=Sm+nUs7C9bvjtcgqCePQxVmqXIj/dbrZRMzxDsmCBFUVQC9FWsu1TBnO7meGex8Qdc
         Oy5rexENJBiPS7AW+EjdwgRvG3Jq7dCdlueQoCG+/WVf9CMRrsSpWP83W18qhcz/MbsY
         nwTCiXDH/xogdQqLG4M9F13Z5jqf7/7SmUeewVX0H1EOJzYUCdKXRCsJFQmgALw4cZzP
         7CNAJxvpqRIipLPuHuWddDhhpJGT5YsM6Si8ukHiXkzCSi5b78sF2FHy2mUcmaLDP7Lq
         tH9CGsrN3caWSgIGntkHpbkMjB88tE3PXCEb4Mk3E+IDl+v3ONcnMBg9SWYRAxGxAbsx
         Y9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741763116; x=1742367916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BN7/p/kplLMFpVggVcZWXKc7X2r0rN1QbraxZm9iOA=;
        b=N0HxcLVLYtT7N1k9+VQbqtqMp9C/jk9zIYpIpq6i/fFiEzXDizMud6OXlKP0pn7skA
         Ze4Yxl6pCO27mvBAXv+BuHGLFMcWwcJwvsVJ5Tc1ZkPymfE5Opo+6xWFBMkhMIarQGxx
         EoSHJYc9hazN2UvLV6T39xhsTGKI1wEPfu8dAkjp1bbb/7ZubezEs7iapngMNlyV0gLZ
         AcLZJTxTB4MWuuOI5YnaHq724ncNaGzuF15Qoi9GEj90kuP0usbpHbsv95gzU5S5jK6o
         QmuiHxFemhKTBLlH9JMhUSqD45oQ3uj4kzW2oC9//UTs6g8sOEnLimBWrrKwGAZRO7QS
         Xcrw==
X-Forwarded-Encrypted: i=1; AJvYcCV8sFCxNeS9KbnIUviqlRIrtuWswpU7DMTbOGA9STXM4OpqAZG4cXWG6Sojjp+mguWujkR69YlEqWwmEDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJ7kUTlDf67fNoiVxfPpFZpmv7ZrVF40OlKhTmGcus7ReqW/T
	8RQrXgnBWTc2twbsD0bXPuct61dPSeH8/zoecLXcADE41oaB1Z8pCWfAb4wSxpEZ4BOQFGAfZNI
	OlhkvV0chvXrS3w==
X-Google-Smtp-Source: AGHT+IE1Ndoas0phFTS9IKILHjYozDjJaUSr/37ugbBFiqmfz/CZUAbv+FfIm2JiPMaXQyasqJT6X/8dogmc6jE=
X-Received: from wmbbe15.prod.google.com ([2002:a05:600c:1e8f:b0:43b:d6ca:6dd3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1547:b0:43c:fceb:91f with SMTP id 5b1f17b1804b1-43cfceb0aedmr110482365e9.11.1741763116368;
 Wed, 12 Mar 2025 00:05:16 -0700 (PDT)
Date: Wed, 12 Mar 2025 07:05:14 +0000
In-Reply-To: <Z9BLc7P2FKiJAo2p@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
 <20250311-iov-iter-v1-4-f6c9134ea824@google.com> <Z9BLc7P2FKiJAo2p@cassiopeiae>
Message-ID: <Z9EyKgrlMVwBagfu@google.com>
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::clear
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Mar 11, 2025 at 03:40:51PM +0100, Danilo Krummrich wrote:
> On Tue, Mar 11, 2025 at 02:25:15PM +0000, Alice Ryhl wrote:
> > Our custom Vec type is missing the stdlib method `clear`, thus add it.
> > It will be used in the miscdevice sample.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/alloc/kvec.rs | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index ae9d072741cedbb34bed0be0c20cc75472aa53be..2d213ede2873cef87116a5527e8e24008c970a58 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -395,6 +395,33 @@ pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
> >          (ptr, len, capacity)
> >      }
> >  
> > +    /// Clears the vector, removing all values.
> > +    ///
> > +    /// Note that this method has no effect on the allocated capacity
> > +    /// of the vector.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = kernel::kvec![1, 2, 3]?;
> > +    ///
> > +    /// v.clear();
> > +    ///
> > +    /// assert!(v.is_empty());
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    #[inline]
> > +    pub fn clear(&mut self) {
> > +        let elems: *mut [T] = self.as_mut_slice();
> > +
> > +        // INVARIANT: This call changes the number of elements to zero.
> > +        self.len = 0;
> 
> Please use self.set_len() instead, such that we have to cover all safety
> requirements enforced by self.set_len().

Will do.

> With that,
> 
> 	Acked-by: Danilo Krummrich <dakr@kernel.org> # for char-misc
> 
> in case you want to take it through the char-misc tree.
> 
> Ironically, self.set_len() lacks your invariant comment and corresponding safety
> requirement, I will send a patch to fix this up, unless you want to. :-)

Go for it.

Alice

