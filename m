Return-Path: <linux-kernel+bounces-208761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D309028D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A231C21019
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1DA14E2EA;
	Mon, 10 Jun 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBTj2nsi"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E29142E79;
	Mon, 10 Jun 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044714; cv=none; b=kR9fQFdPkD4lBoBRWCE3zHgivNojIoiehPUxKDb48ykoATfao5Sgo0ZraQJeHHl75OJtM5GeWSieaop5D7pmz1lFDYf6wtRPGBUp2MPmBVkQr7QqXBbMuIvlJ8RX4uOx+xQuhlmYWlZVmEPro457COtxFEqxOKVtcc7BGaPSNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044714; c=relaxed/simple;
	bh=ejGHWAb9GefhywC3TAx8q6a9ruEZKc6g1Y+QeyzGYzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGI7sIfsjo2K/PSAVQmNC0PKTb5/69GplKqoKH+owO36jJEgI8K+bdtdfwzGipjUIzdS4eTS+c4g1z7HDMOxHWYq0BAr++WZU/ACF4uNZLitbIdigwuR1ucPlb6LLYWMWuXqAYmmkC6l1jEmUK59BGMFGYWVSIxAp+5ocKal8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBTj2nsi; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6af6c2bee7bso40652616d6.1;
        Mon, 10 Jun 2024 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718044711; x=1718649511; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OywUQ9KGRGgplnGy/1tiQUpY5rZ67qOaYLzLaaTA3N0=;
        b=SBTj2nsi+HAY1prdDL8+ohDur879oF5zQqNM3I3/5VZop22vEaW2xMfxKQl93VtRh8
         L0sGnWMjkfwMcG+2Cti1oSYz1HRrlvu+h/k8UdVP00SZOcRL+bSh5UaUSrdkFZKhOjwL
         zf05saBphpVl1OIHMR+c+kDs4sFvksn/iMlZnSH51le/KD5B6y4RRfmL+SwzRLSQPTqg
         9ml6RlixA8Kx3Y0GmAspizBbxk4W0XeNrPHnvKhEI+XWsTZeNGAJxgccA9n2SGFxEWS2
         N6PbWr2DoWW501Ohbpp6+u5j19ltr6NNGDg/L0CsZSgt1bOv4aFQ+6DZmRUzXTWd1PK9
         nrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718044711; x=1718649511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OywUQ9KGRGgplnGy/1tiQUpY5rZ67qOaYLzLaaTA3N0=;
        b=ZVCP6kiNRaBcnV+oSz2C6R7xlz7y1PyPZ88cR+b9xffet6omEAs2V5Mul0qzyN/atY
         Zh+8MKIbsRwxVMBZuMKvVyPfdRRllSrBZn4mojAUg7rGXdGnnl9MJI+rCJUXRqBJWf0x
         HeDGqGiB6BGMr6WX+Xg74HrL9glPT8OTVJPLWif2Wj+GH+WlhTHDxt3RLGcj+NCykvsv
         oevj7KgNkcv/eaG4JwWrMls0Ksh8Ap5rFkFKBtXlcguzqpAsNobnps6EbM+pqH8q42dX
         HgsZa9soM0iGzMYQpthgT+/BYeIPYxjiFJJvoTLnSClI8pninX7EAfoyNvoiRNU0PeOn
         hhKw==
X-Forwarded-Encrypted: i=1; AJvYcCX3bxVD8qdWc65298TiXL4DHxTdOfteBe0CulC3Pv71z5THM6tpsXvbxcFt1QfeEWf53fgu4B/d6awXV7wg1q41dkjTxzLMXkcUN7G5/T5uG3ZydGjA+GkY47OfnUbBncwUHOUxh3Ueq1VJR54=
X-Gm-Message-State: AOJu0Yx0WpgvTrmVSE3FS1F7rNr/4cOrQ3uvD6synT1yP2KZ3HrYskyM
	xN9TlC9YvdEMV7XPcwk/g85u1gQuREmQjbF3kxdF8KnJDihInk0Z
X-Google-Smtp-Source: AGHT+IHTtX4KA0fvm9Wi2kPtV/uEJXFC7qOtaKwh1m9M1n5JDv9OyZWucMNKfRstwhZqpEQh+g2/3A==
X-Received: by 2002:a05:6214:21ef:b0:6b0:5e5d:8d5 with SMTP id 6a1803df08f44-6b089ebd1c2mr8691706d6.8.1718044711332;
        Mon, 10 Jun 2024 11:38:31 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b064df1b70sm33675046d6.128.2024.06.10.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:38:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 480641200043;
	Mon, 10 Jun 2024 14:38:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 10 Jun 2024 14:38:29 -0400
X-ME-Sender: <xms:JUhnZtwkszzpQmbG1a5eBADADAGX4-n_QCOrPBGg4CUx3x3h_wNQvA>
    <xme:JUhnZtR1KtZO28I6strg0Mwx7LmlEIjW7AUy7kyEOTbJmDX5NYc0kGSsWOAp-tPQM
    H8DrS0EjmSo96UnvA>
X-ME-Received: <xmr:JUhnZnX7wMQF4hrs-hpUNyoB96NtdKBrxpyfYsyS91byz1TkD06G-JyNDgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedutddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:JUhnZvia1bKHxxXnVHwTme-23MCo7yQRi4ocAu3ql1fIDp24Cpi3cA>
    <xmx:JUhnZvCPETc3k2Ndj6PHEmjRcgRBhPrhptXSTmItBvFOkH-UZINQPw>
    <xmx:JUhnZoKF8oub_WunXy0qaigORpiT6UUvg12LiYL8qLShbyak1cWcGg>
    <xmx:JUhnZuA1q7ynaUMVHvz5TtTpYz8iwYZYXXyXbm4u1aFse6-DS1Yizg>
    <xmx:JUhnZjz9fRpNFdNIe4hZniXt8Z5klYTGi1z_iX_GqqcaL-_81kJWvVIX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 14:38:28 -0400 (EDT)
Date: Mon, 10 Jun 2024 11:38:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
	russell.h.weight@intel.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add abstraction for struct device
Message-ID: <ZmdID8AlXtoxUfC1@boqun-archlinux>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-2-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610180318.72152-2-dakr@redhat.com>

On Mon, Jun 10, 2024 at 08:02:27PM +0200, Danilo Krummrich wrote:
[...]
> +/// A reference-counted device.
> +///
> +/// This structure represents the Rust abstraction for a C `struct device`. This implementation
> +/// abstracts the usage of an already existing C `struct device` within Rust code that we get
> +/// passed from the C side.
> +///
> +/// An instance of this abstraction can be obtained temporarily or permanent.
> +///
> +/// A temporary one is bound to the lifetime of the C `struct device` pointer used for creation.
> +/// A permanent instance is always reference-counted and hence not restricted by any lifetime
> +/// boundaries.
> +///
> +/// For subsystems it is recommended to create a permanent instance to wrap into a subsystem
> +/// specifc device structure (e.g. `pci::Device`). This is useful for passing it to drivers in
> +/// `T::probe()`, such that a driver can store the `ARef<Device>` (equivalent to storing a
> +/// `struct device` pointer in a C driver) for arbitrary purposes, e.g. allocating DMA coherent
> +/// memory.
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `Self` is non-null and valid for the lifetime of the `ARef` instance. In
> +/// particular, the `ARef` instance owns an increment on the underlying object’s reference count.
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::device>);
> +
[...]
> +
> +// SAFETY: `Device` only holds a pointer to a C `struct device`, which is safe to be used from any
> +// thread.
> +unsafe impl Send for Device {}
> +
> +// SAFETY: `Device` only holds a pointer to a C `struct device`, references to which are safe to be
> +// used from any thread.
> +unsafe impl Sync for Device {}

These comments need some rework, `Device` is not a pointer to `struct
device` anymore. For the `Sync` one, how about:

// SAFETY: `Device` can be shared among threads because all immutable
// methods are protected by the synchronization in `struct device`.
unsafe impl Sync for Device {}

and for `Send`, I actually don't think we can easily say the generic
`Device` is `Send`: you can create a `struct device` where `->release`
requires to be run on the same thread that creates the `device`, and
nothing is wrong about it, I think (e.g. making a thread be the sole
owner of some special devices). Unless, in the #Invariants of `Device`,
and the #safety of `from_ptr`, you mention that `Device` assume its
`->release` can be called on any thread.

Regards,
Boqun

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fbd91a48ff8b..dd1207f1a873 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -28,6 +28,7 @@
>  
>  pub mod alloc;
>  mod build_assert;
> +pub mod device;
>  pub mod error;
>  pub mod init;
>  pub mod ioctl;
> -- 
> 2.45.1
> 

