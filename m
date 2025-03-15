Return-Path: <linux-kernel+bounces-562549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0353A62BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 12:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A06C189916E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF981F8733;
	Sat, 15 Mar 2025 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYSjmgPD"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE1133987;
	Sat, 15 Mar 2025 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742037357; cv=none; b=euTvCETlTWqmFpFZkcaHtc3PD1N1oP44B/5Np9F9Qvipy17HG/KgEvxYSCcYpQJ3HuzY2P1G2mLJ+2L5fr2iX5wZVl12u6HpfpMfm0hRI0cR0SSDUoTDGdozNwAtJM/AHD9lnPNsBTPFCapK6oQnQ60vslLC1ytDhiMahJD8mH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742037357; c=relaxed/simple;
	bh=m6ehkspKr2IXuGJm63dn4TwHsb7aj4gwJG3UE6JMseg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ius0I0OkZWBkzZEzMSw4aFD1QPvTpyvzwO/7nNAnynlbnh9ZWj3IaYP4u9mdhMkrbggcOnyYg2Me1giQKHY6O88Uk2anSj9c2N6EHnxJoQripgi4ts8iQSU+JOx4D9PDbMD3WtRUTG9N+Miv5pnb6FzW/QMIuiqyjAgm7bwpN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYSjmgPD; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-601f1250436so235372eaf.3;
        Sat, 15 Mar 2025 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742037355; x=1742642155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsE4ot+F7yV8gTFDUQj/QcGbskBzPPy0s/mWjVIBgJ4=;
        b=XYSjmgPDP9dHzAZG/U7UsOW9tun796oD426IDdI9oop+h+DgafTGW+5CaM+RzX1lWB
         2TEJRQ3Xyuaqj96tR+JrlaVj8TlVh4eFsaOlv5wq0ZGYcNu3SbwtO+MmrX1T7ut0FkYs
         kQ5g5PvWNJCWAsFg4q7S6fXjqjZeIv4byQBz2b25uSJfuUuQwMGKq+W1S/2SzE6vt/oF
         XZuOYab8jheoFIA+7hpDwGlZqi8OGLNR/NUfEzeAxcgGnsVJfYE/5lwpOuRkFUR3KMhu
         JuF4c39nBvkLDr7hhOoPl8ibBGz37sXvOD9hENzl8dPx38J40Ax2OU7mSBPY/be7siZ5
         IDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742037355; x=1742642155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsE4ot+F7yV8gTFDUQj/QcGbskBzPPy0s/mWjVIBgJ4=;
        b=NsOiv8UnUEniJ5lKi4J1AFQUjn/ePNujOWj7XUcYruvbR74ZNRI/qBPu+VX5Q2YczX
         PiURyfvxwUOA9z6US5MifYhMvEBdEcQgRXHfa2DvKRMrZXGnkeO381V4FOwwsFu+f7k5
         xFPfkzwXx3euJ38VETWRBeqaYLHb+M4i7rXv1PtDdelAIegXwju+JBYiTLtrukfjSZ37
         yAFAb+X74hzDA9mKXyaiA2XoLSEF1QOcF/Ellpw4mlePML99+yqP2Xox/78CHzzxr7yp
         QIxS6qpmBaO/r3s0rg3xfsd4HNt3bC6WGeV56Dqdef5jy/tDT5VWpU2quJtn6XoYsuj+
         yxag==
X-Forwarded-Encrypted: i=1; AJvYcCUEcxKZmSsBT4ewo++aNmSp9d9Klgg/aEcMqojDPFYa2jhAB2nTbCi9OkwsX4EMum2omU6llUhk17ndUTYl@vger.kernel.org, AJvYcCVhN76xw5f0ohexp1+R2VWgw+y8NrqWZIRUCvGGtKsPCWOabYw31Tf9lgjQweld3ZEP82zYrkIhNfA=@vger.kernel.org, AJvYcCXMNeSaQ7/m60q/P0J3Do2wBK+wMf2+AKjrrbmykTJvmuSlCf804rCUP5Q2lcWnLvp5D/jAxb78Fd/XJV5aFrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyglruF9lUKtWVuinIQqDGW7lKCU+l5UDrmPWaIaXgVmF1S3XTg
	4SVLZE5OMaDOm87EUFKLVRPjot/5D8k4psllVvwb2mFq1ufe6iO4
X-Gm-Gg: ASbGncsVzfRKQ+QSsZr9pnlHGYjia4OalN/5zXPFLQFbctacFGGNZjvFO+XpvoI0VEf
	AlQYMsz/OVPVnZg7yRRxesf5bdGby1KNQfgd0wlwkKKU5Xa6INu11wVRf6kYk1Qed5KNCTD6LjG
	49wcvRF55T2oqIyqfY+mdHmo3olub1VV0yh0ISL4RPuEl1v6ojBPzv405wlLOKL++kcauVwVM1z
	VAuzR0wa6WhAG8tw+z/6SSqksRuuqOPGYIU/NHA3ym4a+dtM6xUDnXo7E61wnziYs+rovSaW4ZZ
	jVI/ag4j+TrpB3F6PCODCWYlD/kVRKbbL+6O0VZ/PS9fRafOXwSrs/Fqgo6d6d0Xkthu9I4aYFQ
	xk4cYxzE+ExUVD6md
X-Google-Smtp-Source: AGHT+IEtJfw/w3NFqPpk/9J3e/w+rGmcMb9d2v6gwwk8XdHXokvYktoc9+s3uuIp+BGxQ9A7JuIynw==
X-Received: by 2002:a4a:ee85:0:b0:600:2ff9:acb9 with SMTP id 006d021491bc7-601e45a7a78mr3037153eaf.1.1742037355049;
        Sat, 15 Mar 2025 04:15:55 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-601db65a010sm913826eaf.1.2025.03.15.04.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 04:15:54 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: benno.lossin@proton.me
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	airlied@gmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	andrewjballance@gmail.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dri-devel@lists.freedesktop.org,
	gary@garyguo.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	nouveau@lists.freedesktop.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	simona@ffwll.ch,
	tmgross@umich.edu,
	tzimmermann@suse.de
Subject: Re: [PATCH 1/3] rust: alloc: add Vec::truncate method
Date: Sat, 15 Mar 2025 06:15:11 -0500
Message-ID: <20250315111511.107047-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <D8GRAC8YQIVC.2LS1EIIIRZU3I@proton.me>
References: <D8GRAC8YQIVC.2LS1EIIIRZU3I@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Mar 15, 2025 at 10:09:26AM +0000, Benno Lossin wrote:
> On Sat Mar 15, 2025 at 3:42 AM CET, Andrew Ballance wrote:
> > implements the equivalent to the std's Vec::truncate
> > on the kernel's Vec type.
> >
> > Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> > ---
> >  rust/kernel/alloc/kvec.rs | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index ae9d072741ce..75e9feebb81f 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -452,6 +452,42 @@ pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocEr
> >  
> >          Ok(())
> >      }
> > +
> > +    /// Shortens the vector, setting the length to `len` and drops the removed values.
> > +    /// If `len` is greater than or equal to the current length, this does nothing.
> > +    ///
> > +    /// This has no effect on the capacity and will not allocate.
> > +    /// # Examples
> > +    /// ```
> > +    /// let mut v = kernel::kvec![1, 2, 3]?;
> > +    /// v.truncate(1);
> > +    /// assert_eq!(v.len(), 1);
> > +    /// assert_eq!(&v, &[1]);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn truncate(&mut self, len: usize) {
> > +        if len >= self.len() {
> > +            return;
> > +        }
> > +
> > +        // [new_len, len) is guaranteed to be valid because [0, len) is guaranteed to be valid
> > +        let drop_range = len..self.len();
> > +
> > +        // SAFETY:
> > +        // we can safely ignore the bounds check because we already did our own check
> > +        let ptr: *mut [T] = unsafe { self.get_unchecked_mut(drop_range) };
> 
> What's this `get_unchecked_mut` method, I don't see it in `rust-next` or
> `alloc-next`.

Vec derefs into a slice which implements get_uncheked_mut
https://rust.docs.kernel.org/next/kernel/alloc/kvec/struct.Vec.html#method.get_unchecked_mut

> > +
> > +        // SAFETY:
> > +        // it is safe to shrink the length because the new length is
> > +        // guaranteed to be less than the old length
> 
> Please take a look at the documentation of `set_len`, in the safety
> section you'll find what you need to justify here.
> 
> > +        unsafe { self.set_len(len) };
> > +
> > +        // SAFETY:
> 
> A couple points missing:
> - why is the pointer valid?
> 
> > +        // - the dropped values are valid `T`s
> > +        // - we are allowed to invalidate [new_len, old_len) because we just changed the len
> 
> This should justify why the value will never be accessed again.
> 

I will fixup the safety comments for the v2. Thanks.

> ---
> Cheers,
> Benno
> 
> > +        unsafe { ptr::drop_in_place(ptr) };
> > +    }
> >  }
> >  
> >  impl<T: Clone, A: Allocator> Vec<T, A> {
> 
> 

