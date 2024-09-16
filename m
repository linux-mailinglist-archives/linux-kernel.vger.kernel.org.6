Return-Path: <linux-kernel+bounces-330887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139A97A5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4A41C26D61
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60584157472;
	Mon, 16 Sep 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Pn4TrNW8"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D32155C98
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502805; cv=none; b=IE2LVSaXw4zbqBS31FufQl1iLI8OTRAxE5VBpuP2/CbXXePCQxALvhI2B6W8PWUKV04qQ9ulh0TuUimoeHkv4K5Y4sTIpKHhPHcvS7sEKl6A6WQVzzYnC37jpHeLMtU47hg46VN/eu8xM4FjCkJkxistEM7YH4e8OdZxZXmTYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502805; c=relaxed/simple;
	bh=b6Q8eUH9zvrrhrhDEKqre90wvqxM3TEkJvBTx+SeLyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCY7fz5dJ3hKuM8dJkkK2TyUBaKyMaiyZ2ue4UO/6nhsOrcoINiWznfwL1VvPImWOGBdLk+cbCvheQcJgxRQ6cODj/eHWl2TjuK0GUa5p4sVSFqX46Zz9o6ULVJ3qbwCVnZzu1r/SnaGL5aWC8NrS8qmG5lmI2hLkurKcosFZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Pn4TrNW8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c962e5adso2948024f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1726502802; x=1727107602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4EePoXJ65S2GFrdEWGZyKJ6iStRDMqZJn/mKxq7FEQ=;
        b=Pn4TrNW8mjSGQsLzW2Ddk4dUd9df67UADvmWDMLDQer9s3ZQhbcA+QPq9FpZtdPem+
         jKYNux8oVIgNyVZ37LfBWFWMDFmKW024pn74h28KENjTohYt9EPzSeh8Eqy0P3OWdMqM
         VOMlPcG1wqXCMx54rnzbgS2FGTSKAMSWkw0Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726502802; x=1727107602;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4EePoXJ65S2GFrdEWGZyKJ6iStRDMqZJn/mKxq7FEQ=;
        b=PqlLL0pQ3BFDJh3K9ZZpDjgMOkQ4cZoSDtmAKslE1TyqPSo4NG3CF8++sq7HQVtOtd
         YSnt3R5jMEFftvyRSCNImKxmOl9U/pEqkaEFTt4OYg6cDGB9FIXS09s63Jr67PVd42Mi
         qNYlcEUQ0acWjX5y80mYvHDIBdaBL4TGcvwfL+u/WocDYkMtXyYatre7BEIPhLtjFTPr
         lz0GUTtQKfWSin6GjhZp+O7dy5WssAUpdl6ITm7P+V0UUuj00P+pegMlJnRPrRxqdiKF
         EiTQpVbs28sGg4Pzso/BOaRktJZ/LQH9tKIBBWZNVuqqCKN6cVkGI4q+z9IdCBC1xspS
         r97A==
X-Forwarded-Encrypted: i=1; AJvYcCU+L58T3SOngeGrKqUdYO93dtwgi9q8PfMyLf+cQuNilopFAefUC3ITWdPhnG/gQ4174GwJCrGih6p7mQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6FT1yHHlhYEFa6Mho/cu2dH0zA69zkRuqidutlSmMQHQs5SA
	VM38XGjKTvBCUAqQDM63q0Ea3NXAIsMmtds9Eevtwt63o0C1yWfLTpHSz3m2x84=
X-Google-Smtp-Source: AGHT+IESoTDG9glwPvkNduhdE+GUYWVIrnW+/9CKslB2p42aJ7pDmpCaUArBwFcrY6nTsrLzd6XNIA==
X-Received: by 2002:a5d:6e54:0:b0:374:cd15:c46c with SMTP id ffacd0b85a97d-378a8a1dac8mr14138290f8f.15.1726502800619;
        Mon, 16 Sep 2024 09:06:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc1374f61sm158629205e9.1.2024.09.16.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:06:40 -0700 (PDT)
Date: Mon, 16 Sep 2024 18:06:37 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>,
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: harden index manipulation using ownership
Message-ID: <ZuhXjbb45QrefFb4@phenom.ffwll.local>
Mail-Followup-To: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>,
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240913210031.20802-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913210031.20802-1-aliceryhl@google.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Fri, Sep 13, 2024 at 09:00:29PM +0000, Alice Ryhl wrote:
> Rust is very effective at preventing memory safety bugs such as
> use-after-free bugs. Can we also make it effective at preventing bugs
> that arise from using indices incorrectly? As it stands today, accessing
> an array out of bounds is caught and results in a kernel panic, but Rust
> will not stop you from doing it. Accessing an array at the wrong index
> is not caught at all. This patch explores ways to catch these kinds of
> indexing bugs.
> 
> The Android Binder driver has a component where it "translates" the
> contents of transactions sent using the driver, which involves complex
> and error-prone index manipulation. The C driver has had several bugs in
> this area. A few examples:
> 
> 4df153652cc4 ("binder: fix UAF caused by offsets overwrite")
> bdc1c5fac982 ("binder: fix UAF caused by faulty buffer cleanup")
> 16981742717b ("binder: fix incorrect calculation for num_valid")
> a56587065094 ("binder: Set end of SG buffer area properly.")
> 
> Rust is not immune to these issues either. In fact, I've already
> encountered and fixed two bugs like this in Rust Binder. In both cases,
> the bugs could result in `Allocation::cleanup_object` calls on invalid
> data. Rust's safety guarantees prevented these bugs from affecting the
> integrity of kernel itself, but an attacker could use them to e.g.
> manipulate handles that are present in other processes and for example
> obtaining IApplicationThread handle belonging to another app from
> system_server, which in turn allows loading code into that app.
> 
> Ultimately, the root cause of all of these bugs is that there is some
> index in the destination buffer that gets written to twice.
> 
> The primary idea of this new Range API is to utilize Rust's ownership
> semantics to prevent reuse of indices. The idea is that you create one
> big Range for the entire range of indices, and then there are various
> methods to split it into smaller ranges. An example from Rust Binder,
> where several kinds of data are stored next to each other:
> 
> // Split the buffer size into sub-ranges.
> let full_range = Range::new_area(len);
> let (data_range, after_data) = full_range.split_within(aligned_data_size)?;
> let (offsets_range, after_offsets) = after_data.split_within(aligned_offsets_size)?;
> let (buffers_range, after_buffers) = after_offsets.split_within(aligned_buffers_size)?;
> let (secctx_range, after_secctx) = after_buffers.split_within(aligned_secctx_size)?;
> after_secctx.assert_empty()?;
> 
> The Range type is set up so that it cannot be copied or cloned, which
> means that any attempts to use a Range more than once will fail to
> compile. For example, if the line creating `buffers_range` accidentally
> tried to split `after_data` instead of `after_offsets`, then that would
> lead to this compilation error:
> 
> error[E0382]: use of moved value: `after_data`
>     --> /usr/local/google/home/aliceryhl/rust-android-mainline/common/drivers/android/binder/thread.rs:1101:50
>      |
> 1099 | let (data_range, after_data) = full_range.split_within(aligned_data_size)?;
>      |                  ---------- move occurs because `after_data` has type `kernel::range::Range`, which does not implement the `Copy` trait
> 1100 | let (offsets_range, after_offsets) = after_data.split_within(aligned_offsets_size)?;
>      |                                                 ---------------------------------- `after_data` moved due to this method call
> 1101 | let (buffers_range, after_buffers) = after_data.split_within(aligned_buffers_size)?;
>      |                                      ^^^^^^^^^^ value used here after move
>      |
> note: `kernel::range::Range::split_within` takes ownership of the receiver `self`, which moves `after_data`
>     --> /usr/local/google/home/aliceryhl/rust-android-mainline/common/rust/kernel/range.rs:108:29
>      |
> 108  | pub fn split_within(mut self, length: usize) -> Result<(Range, Range), RangeError> {
>      |                         ^^^^
> 
> Basically, the error says that you tried to use the `after_data` range
> twice, which is not allowed because `split_within` destroys the object
> you call it on.
> 
> In Rust Binder, I am using the ranges to prevent reuse of indices in the
> *destination* buffer. To enforce that, all methods for writing to the
> destination buffer are modified to take a `Range` as an argument,
> consuming the range being written to. As ranges can only be split into
> smaller pieces, this enforces that you will never write to the same
> index twice.
> 
> Of course, the API is not completely bullet-proof. If you call
> `Range::new_area` twice, you'll get two overlapping ranges. But we don't
> need it to be completely impossible to misuse. It just needs to be
> really difficult to do so accidentally.
> 
> Binder has one case where it intentionally writes to the same location
> twice: when sending file descriptors over Binder, the driver does not
> know what value the fd will have when transferring the data, so it will
> first write u32::MAX. Much later, it will overwrite it with the real fd.
> There is a `duplicate_range_careful` method for this case.
> 
> It is interesting to compare with the uaccess patchset [1]. The uaccess
> API takes a userspace pointer and length representing a range of bytes
> in userspace, and lets you read the range incrementally. The API design
> prevents reading the same address twice. This helps prevent
> time-of-check-to-time-of-use bugs where userspace modifies the data in
> between two reads, which can cause bugs if the driver assumes that the
> memory is unchanged.

I don't really see an overlap between Range and UserSlice. The former is
about managing a range of indexes, the other about incremental
reading/writing to userspace without screwing up. I think we want both,
since often you get the things you need to carefuly slice/dice with Range
from somewhere else, e.g. from pagecache or the fw loader.

Also where performance doesn't matter so much often the copy_from_user is
one step and then we parse some complex data structure in there where
Range should be useful.

> In fact, both Rust Binder bugs mentioned earlier are caught by this part
> of the uaccess API, as both bugs eventually attempt to read past the end
> of the userspace region, triggering an error. Unfortunately, this
> happens too late, as the previously translated data has already been
> overwritten by the time the error is triggered.
> 
> This patchset is also simliar to Benno's untrusted data patchset [2],
> which explores a different way to write misuse-resistant APIs.

I think you want both: Range to slice up a block of memory into variable
length structure, Untrusted to safely parse each part.
> 
> Link: https://lore.kernel.org/r/20240528-alice-mm-v7-0-78222c31b8f4@google.com [1]
> Link: https://lore.kernel.org/r/20240913112643.542914-1-benno.lossin@proton.me [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I didn't take a close look at the api since real feedback would mean I
need to type up a user, but this looks great and I want :-)
-Sima


> ---
>  rust/kernel/lib.rs   |   1 +
>  rust/kernel/range.rs | 236 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 237 insertions(+)
>  create mode 100644 rust/kernel/range.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index a7fefc4ae725..72a998cd02e0 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -48,6 +48,7 @@
>  pub mod page;
>  pub mod prelude;
>  pub mod print;
> +pub mod range;
>  pub mod rbtree;
>  pub mod security;
>  pub mod seq_file;
> diff --git a/rust/kernel/range.rs b/rust/kernel/range.rs
> new file mode 100644
> index 000000000000..8fb9d96ac724
> --- /dev/null
> +++ b/rust/kernel/range.rs
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Utilities for working with ranges of indices.
> +
> +/// A range of indices.
> +///
> +/// This utility is useful for ensuring that no index in the range is used more than once.
> +#[derive(Debug)]
> +pub struct Range {
> +    offset: usize,
> +    length: usize,
> +}
> +
> +impl Range {
> +    /// Creates a new `Range` for an area of the given size.
> +    pub fn new_area(size: usize) -> Self {
> +        Self {
> +            offset: 0,
> +            length: size,
> +        }
> +    }
> +
> +    /// Use this range of indices.
> +    ///
> +    /// This destroys the `Range` object, so these indices cannot be used again after this call.
> +    pub fn use_range(self) -> UsedRange {
> +        UsedRange {
> +            offset: self.offset,
> +            length: self.length,
> +        }
> +    }
> +
> +    /// Duplicate this range.
> +    ///
> +    /// Be careful when using this method, as it allows you to use a range twice.
> +    pub fn duplicate_range_careful(&self) -> Range {
> +        Range {
> +            offset: self.offset,
> +            length: self.length,
> +        }
> +    }
> +
> +    /// Peek at the offset without using the range.
> +    ///
> +    /// This doesn't destroy the `Range` object, so be careful that the range is not used twice.
> +    pub fn peek_offset(&self) -> usize {
> +        self.offset
> +    }
> +
> +    /// Peek at the length without using the range.
> +    ///
> +    /// This doesn't destroy the `Range` object, so be careful that the range is not used twice.
> +    pub fn peek_length(&self) -> usize {
> +        self.length
> +    }
> +
> +    /// Peek at the end without using the range.
> +    ///
> +    /// This doesn't destroy the `Range` object, so be careful that the range is not used twice.
> +    pub fn peek_end(&self) -> Result<usize, RangeError> {
> +        self.offset.checked_add(self.length).ok_or(RangeError)
> +    }
> +
> +    /// Truncates this range to the given length.
> +    pub fn truncate(&mut self, length: usize) -> Result<(), RangeError> {
> +        if length > self.length {
> +            return Err(RangeError);
> +        }
> +        self.length = length;
> +        Ok(())
> +    }
> +
> +    /// Assert that this range is aligned properly.
> +    pub fn assert_aligned(&self, alignment: usize) -> Result<(), RangeError> {
> +        if self.offset % alignment == 0 {
> +            Ok(())
> +        } else {
> +            Err(RangeError)
> +        }
> +    }
> +
> +    /// Assert that this range has the expected length.
> +    pub fn assert_length_eq(&self, length: usize) -> Result<(), RangeError> {
> +        if self.length == length {
> +            Ok(())
> +        } else {
> +            Err(RangeError)
> +        }
> +    }
> +
> +    /// Assert that this range is empty.
> +    pub fn assert_empty(self) -> Result<(), RangeError> {
> +        self.assert_length_eq(0)
> +    }
> +
> +    /// Splits the range into two sub-ranges.
> +    ///
> +    /// Fails if the `length` is greater than the range being split.
> +    pub fn split_within(mut self, length: usize) -> Result<(Range, Range), RangeError> {
> +        let left = self.take_from_start(length)?;
> +        Ok((left, self))
> +    }
> +
> +    /// Splits the range into two sub-ranges.
> +    ///
> +    /// Fails if the `position` is not within the current range.
> +    pub fn split_at(mut self, position: usize) -> Result<(Range, Range), RangeError> {
> +        let left = self.take_until(position)?;
> +        Ok((left, self))
> +    }
> +
> +    /// Modify this range by taking the first `length` bytes.
> +    pub fn take_until(&mut self, position: usize) -> Result<Range, RangeError> {
> +        let from_start = Range {
> +            offset: self.offset,
> +            length: position.checked_sub(self.offset).ok_or(RangeError)?,
> +        };
> +
> +        let new_self = Range {
> +            offset: position,
> +            length: self
> +                .length
> +                .checked_sub(from_start.length)
> +                .ok_or(RangeError)?,
> +        };
> +
> +        *self = new_self;
> +
> +        Ok(from_start)
> +    }
> +
> +    /// Modify this range by taking the first `length` bytes.
> +    pub fn take_from_start(&mut self, length: usize) -> Result<Range, RangeError> {
> +        let from_start = Range {
> +            offset: self.offset,
> +            length: length,
> +        };
> +
> +        let new_self = Range {
> +            offset: self.offset.checked_add(length).ok_or(RangeError)?,
> +            length: self.length.checked_sub(length).ok_or(RangeError)?,
> +        };
> +
> +        *self = new_self;
> +
> +        Ok(from_start)
> +    }
> +
> +    /// Split this range into sub-ranges of the given size.
> +    pub fn iter_chunks(self, chunk_size: usize) -> Result<ChunkIter, RangeError> {
> +        if self.length % chunk_size != 0 {
> +            return Err(RangeError);
> +        }
> +
> +        Ok(ChunkIter {
> +            pos: self.offset,
> +            end: self.offset.checked_add(self.length).ok_or(RangeError)?,
> +            chunk_size,
> +        })
> +    }
> +}
> +
> +/// An iterator over ranges of the same size.
> +pub struct ChunkIter {
> +    pos: usize,
> +    end: usize,
> +    chunk_size: usize,
> +}
> +
> +impl Iterator for ChunkIter {
> +    type Item = Range;
> +    fn next(&mut self) -> Option<Range> {
> +        if self.pos >= self.end {
> +            return None;
> +        }
> +
> +        let range = Range {
> +            offset: self.pos,
> +            length: self.chunk_size,
> +        };
> +        self.pos = self.pos + self.chunk_size;
> +
> +        Some(range)
> +    }
> +}
> +
> +/// A version of [`Range`] where the length is a compile-time constant.
> +///
> +/// This can be used to store a `Range` without using up space to store the length.
> +pub struct RangeFixedSize<const LENGTH: usize> {
> +    offset: usize,
> +}
> +
> +impl<const LENGTH: usize> RangeFixedSize<LENGTH> {
> +    /// Create a `RangeFixedSize` from a `Range`.
> +    pub fn from_range(range: Range) -> Result<Self, RangeError> {
> +        if range.length == LENGTH {
> +            Ok(Self {
> +                offset: range.offset,
> +            })
> +        } else {
> +            Err(RangeError)
> +        }
> +    }
> +
> +    /// Convert this back into a `Range`.
> +    pub fn into_range(self) -> Range {
> +        Range {
> +            offset: self.offset,
> +            length: LENGTH,
> +        }
> +    }
> +}
> +
> +/// The return value of [`Range::use_range`].
> +///
> +/// The only way to access the indices in a range is to mark it "used", which converts it into this
> +/// type, destroying the original [`Range`] object.
> +#[derive(Copy, Clone)]
> +pub struct UsedRange {
> +    /// The offset of this range.
> +    pub offset: usize,
> +    /// The length of this range.
> +    pub length: usize,
> +}
> +
> +/// The error type returned when ranges are used incorrectly.
> +pub struct RangeError;
> +
> +impl From<RangeError> for crate::error::Error {
> +    fn from(_range: RangeError) -> crate::error::Error {
> +        crate::error::code::EINVAL
> +    }
> +}
> -- 
> 2.46.0.662.g92d0881bb0-goog
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

