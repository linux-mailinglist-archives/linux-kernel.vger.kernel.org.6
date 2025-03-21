Return-Path: <linux-kernel+bounces-571617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8532CA6BFB4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F53D17FB52
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F092222B8BD;
	Fri, 21 Mar 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuWeEyUg"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7222CBE9;
	Fri, 21 Mar 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574030; cv=none; b=sV9E5G/LqTUpYgUYO/WYDDxH+jvn76TueVgvGZ6u0WVpegvHR/TdeVULXmrbep0HTKFMM5AuOJSch5x7u1aGTg31VOZHRlSfS+szanFmyIE0le3feFMONzph71CRclQ4SvE3evCJ0rA0H6Wr1gHx5Ez5JZUFyCD9NYxNXTNkFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574030; c=relaxed/simple;
	bh=VDB4zIshf/T/lwTivGW1p4hFRSRWCA+FyrB9RNp5Opo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti2AEtFH0fWkpkuu5iVKHY6R9sDP50hQBSXcogRD1wffyCM4spMw+XRkMClkGIH6pnQd4C8DlIpzv5Dq0Z8c6afMv1qlVQC95dorGCG5AzJcxD0NTGjuAQlLVtuh2r47y2ncTJFJ2kByFbka3dudypD1vQAvQMjWhRKKyFA1ZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuWeEyUg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5675dec99so248747985a.0;
        Fri, 21 Mar 2025 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742574027; x=1743178827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RwLK5iQXF+IRc7OqME3cPmsOdwPfPmJm2toTj6Nzyw=;
        b=MuWeEyUgVpMF2pkkn87ah92epe4LJtjIeSINH5YXOdr0wsYVnvarA+M0ynwKWiB09e
         nC8a4xOhhGr7NnAU1lbZZj7BjqQtjWiY7J8eotXxKcChyY7z9lWhtQssnavK/nBV46OK
         YRnyQ4zIFFqtfGZru9cAlAPFPwAczOKWGhHpdsxDZJHmHQyruj0IqRoZGOmgHLNiPkk6
         2QdN2/3PeXhwQHHeILy7xnd3dqEvibKqdomVhJai+gMxV91pK5HWCEIHdof7kJTHNHv8
         AB0fEJZuL4e11M0pcXPi+4cZekfoAN6jBKy+65v90LKHC826y5QqdAS+2NOMl7siSlD/
         +Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574027; x=1743178827;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RwLK5iQXF+IRc7OqME3cPmsOdwPfPmJm2toTj6Nzyw=;
        b=EmBsLbATEzNJd/kEG/imLAd8XzA/dNI0B0CxFeQMElaGCNTleIZXbAQKMb6g4p9S/M
         2zJQYld5quxcqnoYoYMJ/NIx7B2RGCT4IQTNtt6m5gNzfNDB6lt5YW0aB1kAX2Sd5113
         i6jc1s8nV+EoAv+xtLwilz9Js3dDpGTqa2lrkRH6WnhF0MKdxoWaJL9fMkMPlxw8vxun
         RkMCTyXFSGPI44S0hGvUlejNPqG5bjsUxUxlWUFNKctywklfAfZkuMSk1qrtjRYhnhdJ
         a3N/LiN4YpNNvFFODiZwaNBuLYuEK61PAhW67uV9px1rEXTjy5CUWo4Z/iwJJ690ZsTH
         8a4w==
X-Forwarded-Encrypted: i=1; AJvYcCU09JJJMVxz+84FYdkZeo4hayeeM5Pm8VcIRPoDx1Na3HZBds3F3nu044qm/oPE5NYAPhk63JOEy2IWoHh6ewA=@vger.kernel.org, AJvYcCWWyEavg+GFy2aGAVMLqIZTRU5cqYogkQ/U/2xPLxbcRcnaxNM+/mRih2HE+i+Ner8mB7bviedi2riazDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7EFZVU/D5Qc4KM81RPYo67MwOi+kL6Gqed0CA0JrWzFGgsoPE
	in5PosHPy8AufPWHROLht0dRJjmSvgQHvS1XlpFx8wdhpyjj3W5f
X-Gm-Gg: ASbGncsr/kCynPW+NDXbX2jPqs3x1XAw2cb0kd+D2SDYH4MmZ2LyD+SVs70DvCinOaX
	rvMiQFgzXSXcbEBC7ZnpXyjowM1mp6VQmNcRccRhKZFd5dA+ZxOYkAKmv/9wBnrOUA5D/CoUjfs
	xjFy60d1nYzFB+bDzZpD8yXVeUDzTAa4oX/pI6tIIL3RZ+vV/iCAVrox99msmLOixMwC4GwjkCq
	Tr/nz2j1sdFFhQrLi/mQVAfBcyOTVdnoFCPR+Qb3qukFcxx0lZHyjEmOwJQC/kBzXrnq0nB2j1j
	AjyATdeRIpUrUDH2JRDeL3A5bI91IYKZIaerXmJtDCbb7Z1NJViVIET3rYamEM2VFsRrpmGFLq+
	Vlk2KVLCrgQ/CviwvB80cZp3p12peWPjEAiE=
X-Google-Smtp-Source: AGHT+IFNWTQlBe0RD+otYXkE2VK+jyUjA6UsznLgPDt5EOPT6xTqgiVMK35DXGrMeG/Y+qkbjXLI6A==
X-Received: by 2002:a05:620a:4051:b0:7c5:61fc:d325 with SMTP id af79cd13be357-7c5ba17c942mr598322385a.31.1742574027080;
        Fri, 21 Mar 2025 09:20:27 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b935820asm146708085a.94.2025.03.21.09.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:20:26 -0700 (PDT)
Message-ID: <67dd91ca.050a0220.acaf0.79d2@mx.google.com>
X-Google-Original-Message-ID: <Z92RyFxwF_XQhDF6@winterfell.>
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 318491200078;
	Fri, 21 Mar 2025 12:20:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 21 Mar 2025 12:20:26 -0400
X-ME-Sender: <xms:ypHdZwSRvH1uy2L12IFYhG_BvGW4JvcUTd-vJFoYuZXMmZtFzTcKnA>
    <xme:ypHdZ9xyOWPWSKmSyCntfzjCnQKbpGTmzMWuuE2H2PdXguQndx4V_BlB_lgbTm8St
    pt3UGraLobuGPKvwQ>
X-ME-Received: <xmr:ypHdZ93n135Uyho_o1gr1cwVa8glwGZGlSc48CQMs5kyoAEYoFL9wKFC3WY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevudeihfelffehiefghfehtdfgieeftdeu
    tdffkeellefhjeekiefhleejkeehtdenucffohhmrghinheptggrshhtrdgrshdpihhnsh
    htrghntggvrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopeholhhivhgvrhdrmhgrnhhgohhlugesphhmrdhmvgdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrgh
    grhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhho
    rdhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtoh
    hmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghp
    thhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlh
    hitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehu
    mhhitghhrdgvughu
X-ME-Proxy: <xmx:ypHdZ0Cz3aaVt8M23Ygzn_HUCm0o-I0inCe69AQF01yfifbRtEUEOQ>
    <xmx:ypHdZ5iWtDZ9FTUepY9TI1G5wBdad-Wl5d06cVOpJIqIx0ExIbJ6YQ>
    <xmx:ypHdZwpLN684E69EGwYUvqgoW7Y-onXSfTs6mZfJPjs-yAb7mfuzQQ>
    <xmx:ypHdZ8iAy5O-CRRp_gI-eGhfuQexnIJvPzSz72He5o-uJmpuV31AbQ>
    <xmx:ypHdZwRSavSFiVND7Mh0leKSZpOu9DCSBYULo2BUQjspPotvxKOiLGOC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 12:20:25 -0400 (EDT)
Date: Fri, 21 Mar 2025 09:20:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/4] rust: rename AlwaysRefCounted to RefCounted
References: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
 <20250313-unique-ref-v8-2-3082ffc67a31@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-unique-ref-v8-2-3082ffc67a31@pm.me>

On Thu, Mar 13, 2025 at 07:00:11AM +0000, Oliver Mangold wrote:
> AlwaysRefCounted will become a marker trait to indicate that it is allowed
> to obtain an ARef from a `&`, which cannot be allowed for types which are
> also Ownable.
> 

This commit log doesn't explain why we need to do this.

> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/block/mq/request.rs | 10 ++++++---
>  rust/kernel/cred.rs             |  8 ++++++--
>  rust/kernel/device.rs           |  8 ++++++--
>  rust/kernel/fs/file.rs          | 10 ++++++---
>  rust/kernel/pid_namespace.rs    |  8 ++++++--
>  rust/kernel/task.rs             |  6 +++++-
>  rust/kernel/types.rs            | 45 ++++++++++++++++++++++++-----------------
>  7 files changed, 64 insertions(+), 31 deletions(-)
> 
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index 2f2bb5a04709cc90ae8971da166fc83bb53fb86b..f6bee0932499e554f88907861997f8b9d1ffd51a 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -9,7 +9,7 @@
>      block::mq::Operations,
>      error::Result,
>      sync::Refcount,
> -    types::{ARef, AlwaysRefCounted, Opaque},
> +    types::{ARef, AlwaysRefCounted, Opaque, RefCounted},
>  };
>  use core::{
>      marker::PhantomData,
> @@ -209,10 +209,10 @@ unsafe impl<T: Operations> Send for Request<T> {}
>  unsafe impl<T: Operations> Sync for Request<T> {}
>  
>  // SAFETY: All instances of `Request<T>` are reference counted. This
> -// implementation of `AlwaysRefCounted` ensure that increments to the ref count
> +// implementation of `RefCounted` ensure that increments to the ref count
>  // keeps the object alive in memory at least until a matching reference count
>  // decrement is executed.
> -unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
> +unsafe impl<T: Operations> RefCounted for Request<T> {
>      fn inc_ref(&self) {
>          self.wrapper_ref().refcount().inc();
>      }
> @@ -234,3 +234,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
>          }
>      }
>  }
> +
> +// SAFETY: we currently do not implement `Ownable`, thus it is okay to can obtain an `ARef<Request>`

s/we/We

> +// from a `&Request` (but this will change in the future).
> +unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {}
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> index 81d67789b16f243e7832ff3b2e5e479a1ab2bf9e..e04d1021130eb1ec46fe48feb088959da7656d66 100644
> --- a/rust/kernel/cred.rs
> +++ b/rust/kernel/cred.rs
> @@ -11,7 +11,7 @@
>  use crate::{
>      bindings,
>      task::Kuid,
> -    types::{AlwaysRefCounted, Opaque},
> +    types::{AlwaysRefCounted, Opaque, RefCounted},
>  };
>  
>  /// Wraps the kernel's `struct cred`.
> @@ -71,7 +71,7 @@ pub fn euid(&self) -> Kuid {
>  }
>  
>  // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
> -unsafe impl AlwaysRefCounted for Credential {
> +unsafe impl RefCounted for Credential {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>          unsafe { bindings::get_cred(self.0.get()) };
> @@ -83,3 +83,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
>          unsafe { bindings::put_cred(obj.cast().as_ptr()) };
>      }
>  }
> +
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `ARef<Credential>` from a
> +// `&Credential`.
> +unsafe impl AlwaysRefCounted for Credential {}
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index db2d9658ba47d9c492bc813ce3eb2ff29703ca31..189298518dc184405b1d62404b190d4c0b08b7ad 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -7,7 +7,7 @@
>  use crate::{
>      bindings,
>      str::CStr,
> -    types::{ARef, Opaque},
> +    types::{ARef, AlwaysRefCounted, Opaque, RefCounted},
>  };
>  use core::{fmt, ptr};
>  
> @@ -190,7 +190,7 @@ pub fn property_present(&self, name: &CStr) -> bool {
>  }
>  
>  // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::types::AlwaysRefCounted for Device {
> +unsafe impl RefCounted for Device {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>          unsafe { bindings::get_device(self.as_raw()) };
> @@ -202,6 +202,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `Device<Task>` from a
> +// `&Device`.
> +unsafe impl AlwaysRefCounted for Device {}
> +
>  // SAFETY: As by the type invariant `Device` can be sent to any thread.
>  unsafe impl Send for Device {}
>  
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index e03dbe14d62a566349c4100f2f78b17d4c79aab5..a7836cc754e7927b6addc3bd06cfe8c8119f1d9f 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -11,7 +11,7 @@
>      bindings,
>      cred::Credential,
>      error::{code::*, Error, Result},
> -    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque, RefCounted},
>  };
>  use core::ptr;
>  
> @@ -190,7 +190,7 @@ unsafe impl Sync for File {}
>  
>  // SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
>  // makes `ARef<File>` own a normal refcount.
> -unsafe impl AlwaysRefCounted for File {
> +unsafe impl RefCounted for File {
>      #[inline]
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> @@ -205,6 +205,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `ARef<File>` from a
> +/// `&File`.
> +unsafe impl AlwaysRefCounted for File {}
> +
>  /// Wraps the kernel's `struct file`. Not thread safe.
>  ///
>  /// This type represents a file that is not known to be safe to transfer across thread boundaries.
> @@ -225,7 +229,7 @@ pub struct LocalFile {
>  
>  // SAFETY: The type invariants guarantee that `LocalFile` is always ref-counted. This implementation
>  // makes `ARef<File>` own a normal refcount.
> -unsafe impl AlwaysRefCounted for LocalFile {
> +unsafe impl RefCounted for LocalFile {
>      #[inline]
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
> index 0e93808e4639b37dd77add5d79f64058dac7cb87..3e45e945b7509b9607266b2e0e6ef130e7a1ed39 100644
> --- a/rust/kernel/pid_namespace.rs
> +++ b/rust/kernel/pid_namespace.rs
> @@ -9,7 +9,7 @@
>  
>  use crate::{
>      bindings,
> -    types::{AlwaysRefCounted, Opaque},
> +    types::{AlwaysRefCounted, RefCounted, Opaque},
>  };
>  use core::ptr;
>  
> @@ -44,7 +44,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_namespace) -> &'a Self {
>  }
>  
>  // SAFETY: Instances of `PidNamespace` are always reference-counted.
> -unsafe impl AlwaysRefCounted for PidNamespace {
> +unsafe impl RefCounted for PidNamespace {
>      #[inline]
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> @@ -58,6 +58,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `ARef<PidNamespace>`
> +// from a `&PidNamespace`.
> +unsafe impl AlwaysRefCounted for PidNamespace {}
> +
>  // SAFETY:
>  // - `PidNamespace::dec_ref` can be called from any thread.
>  // - It is okay to send ownership of `PidNamespace` across thread boundaries.
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 07bc22a7645c0c7d792a0a163dd55b8ff0fe5f92..1cc1b02cb7fada6703da8cad77549dee578fc08d 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -327,7 +327,7 @@ pub fn wake_up(&self) {
>  }
>  
>  // SAFETY: The type invariants guarantee that `Task` is always refcounted.
> -unsafe impl crate::types::AlwaysRefCounted for Task {
> +unsafe impl crate::types::RefCounted for Task {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>          unsafe { bindings::get_task_struct(self.as_ptr()) };
> @@ -339,6 +339,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `ARef<Task>` from a
> +// `&Task`.
> +unsafe impl crate::types::AlwaysRefCounted for Task {}
> +
>  impl Kuid {
>      /// Get the current euid.
>      #[inline]
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 65f6d0721f5f23c8db79c6735dc7d5e1ac984ea7..5a96da714348cc2369969200e6070972226c00fe 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -402,11 +402,9 @@ pub const fn raw_get(this: *const Self) -> *mut T {
>      }
>  }
>  
> -/// Types that are _always_ reference counted.
> +/// Types that are internally reference counted.
>  ///
>  /// It allows such types to define their own custom ref increment and decrement functions.
> -/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
> -/// [`ARef<T>`].
>  ///
>  /// This is usually implemented by wrappers to existing structures on the C side of the code. For
>  /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
> @@ -418,9 +416,9 @@ pub const fn raw_get(this: *const Self) -> *mut T {
>  /// at least until matching decrements are performed.
>  ///
>  /// Implementers must also ensure that all instances are reference-counted. (Otherwise they
> -/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
> +/// won't be able to honour the requirement that [`RefCounted::inc_ref`] keep the object
>  /// alive.)
> -pub unsafe trait AlwaysRefCounted {
> +pub unsafe trait RefCounted {
>      /// Increments the reference count on the object.
>      fn inc_ref(&self);
>  
> @@ -433,11 +431,22 @@ pub unsafe trait AlwaysRefCounted {
>      /// Callers must ensure that there was a previous matching increment to the reference count,
>      /// and that the object is no longer used after its reference count is decremented (as it may
>      /// result in the object being freed), unless the caller owns another increment on the refcount
> -    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
> -    /// [`AlwaysRefCounted::dec_ref`] once).
> +    /// (e.g., it calls [`RefCounted::inc_ref`] twice, then calls
> +    /// [`RefCounted::dec_ref`] once).
>      unsafe fn dec_ref(obj: NonNull<Self>);
>  }
>  
> +/// An extension to RefCounted, which declares that it is allowed to convert
> +/// from a shared reference `&T` to an owned reference [`ARef<T>`].
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that no safety invariants are violated by upgrading an `&T`
> +/// to an [`ARef<T>`]. In particular that implies [`AlwaysRefCounted`] and [`Ownable`]
> +/// cannot be implemented for the same type, as this would allow to violate the uniqueness
> +/// guarantee of [`Owned<T>`] by derefencing it into an `&T` and obtaining an [`ARef`] from that.
> +pub unsafe trait AlwaysRefCounted: RefCounted {}
> +
>  /// An owned reference to an always-reference-counted object.
>  ///
>  /// The object's reference count is automatically decremented when an instance of [`ARef`] is
> @@ -448,7 +457,7 @@ pub unsafe trait AlwaysRefCounted {
>  ///
>  /// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
>  /// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> -pub struct ARef<T: AlwaysRefCounted> {
> +pub struct ARef<T: RefCounted> {
>      ptr: NonNull<T>,
>      _p: PhantomData<T>,
>  }
> @@ -457,16 +466,16 @@ pub struct ARef<T: AlwaysRefCounted> {
>  // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>  // `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` using a
>  // mutable reference, for example, when the reference count reaches zero and `T` is dropped.
> -unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
> +unsafe impl<T: RefCounted + Sync + Send> Send for ARef<T> {}
>  
>  // SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync`
>  // because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
>  // it needs `T` to be `Send` because any thread that has a `&ARef<T>` may clone it and get an
>  // `ARef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
>  // example, when the reference count reaches zero and `T` is dropped.
> -unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
> +unsafe impl<T: RefCounted + Sync + Send> Sync for ARef<T> {}
>  
> -impl<T: AlwaysRefCounted> ARef<T> {
> +impl<T: RefCounted> ARef<T> {
>      /// Creates a new instance of [`ARef`].
>      ///
>      /// It takes over an increment of the reference count on the underlying object.
> @@ -495,12 +504,12 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// ```
>      /// use core::ptr::NonNull;
> -    /// use kernel::types::{ARef, AlwaysRefCounted};
> +    /// use kernel::types::{ARef, RefCounted};
>      ///
>      /// struct Empty {}
>      ///
>      /// # // SAFETY: TODO.

While you at it, could you also finish this todo? ;-) Thanks! I believe
this is just using a ZST to simulate a RefCounted type, therefore it's
safe to assume `Empty` is ref-counted.

Regards,
Boqun

> -    /// unsafe impl AlwaysRefCounted for Empty {
> +    /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
>      /// }
> @@ -518,7 +527,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
>      }
>  }
>  
> -impl<T: AlwaysRefCounted> Clone for ARef<T> {
> +impl<T: RefCounted> Clone for ARef<T> {
>      fn clone(&self) -> Self {
>          self.inc_ref();
>          // SAFETY: We just incremented the refcount above.
> @@ -526,7 +535,7 @@ fn clone(&self) -> Self {
>      }
>  }
>  
> -impl<T: AlwaysRefCounted> Deref for ARef<T> {
> +impl<T: RefCounted> Deref for ARef<T> {
>      type Target = T;
>  
>      fn deref(&self) -> &Self::Target {
> @@ -543,10 +552,10 @@ fn from(b: &T) -> Self {
>      }
>  }
>  
> -impl<T: AlwaysRefCounted> Drop for ARef<T> {
> +impl<T: RefCounted> Drop for ARef<T> {
>      fn drop(&mut self) {
> -        // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
> -        // decrement.
> +        // SAFETY: The type invariants guarantee that the `ARef` owns the reference
> +        // we're about to decrement.
>          unsafe { T::dec_ref(self.ptr) };
>      }
>  }
> 
> -- 
> 2.48.1
> 
> 

