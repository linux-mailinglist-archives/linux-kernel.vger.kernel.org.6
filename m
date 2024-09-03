Return-Path: <linux-kernel+bounces-313567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6E96A71C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE501C211A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5057C1D5CC6;
	Tue,  3 Sep 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVaHKo3p"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365321D5CC0;
	Tue,  3 Sep 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390536; cv=none; b=e6o9FgA/JR8VOxAtp/D8uEP2PCv/Ojsr+hJlZGC0MPrpycnEpNOlOt4a0tAxDv0dcvccRnIDG6KHNAn7K8kVu5DCDvebPSXitpJ2z0SReG3npw9BpqBMmMrHDZ20n38FQ1+ekSvdlwpVrklTVbApELStUEL+T1y3Tb9GObzMPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390536; c=relaxed/simple;
	bh=IEXjWfEq84DXfETdW81agNiGv57E65QfxLkph8camuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeE9s09hrfJQSXeQznaXu2nTTmuCfOIYj9N2X7hNug463IRhhUaBJfDSU3GKJJEZxKY/PmTY/UVmzxY+SWG9EUMv64rvv9bF4e80dRsh2dv1o02tWSupQ4ecpzM/9JbelcD8DuQsp92aSrq5vnZ1EMc9SbRQ8AwKBfCMccdtGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVaHKo3p; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-277efdcfa63so1329750fac.2;
        Tue, 03 Sep 2024 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725390534; x=1725995334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbOQUlni+K3mU+VT36wyrqeCHc06ganEEsHZCUl3X20=;
        b=gVaHKo3pd3rjnd0wpbzcKEXvVYqwUQGZP/tNoqLMqka6S7C1LP19CdlvWAkJVQqKNg
         m02lxACZ9DaNLUBQi3SCSCLs/TXJn5u8LQXz/iRJlaZ+kG+k2tQler2Z5KrPT44E6ID/
         PZXwXtHqtOy7FLb+YfVEMR882apVc3Jo/YFN3+M1D2aqvbmrjd+NwvfNwUl553CdrfrD
         YQpiqeeiNeNyn0JQ3qRPVOw6cVV88TNnz9D0yh1xZgsfQtFhwSN6RS7/ovucyzBkXCxT
         YFVvIXG/9nvdLplbW0W8hrTYEvniUm27uhi35Ttqw4BHNvMKpHig5O1L5qDPL+eESnks
         RDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390534; x=1725995334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbOQUlni+K3mU+VT36wyrqeCHc06ganEEsHZCUl3X20=;
        b=NU+xpqu7t6NgL99pEr2gpTX45bBiU8qbW2ht9e1ehTzd6BwaqNClDU9S+BATRwThcn
         ep7Xje0NHtTj4gVdwnBY0Ig39ZK7bZ/GPWCpmvWqRvO9Wnio1rKFsoujqGob89TIz5i/
         isfRcJP5eG5qomdoAvNbY/nN4M4COrJTE3Hu87B4MweCJFJKGZipV+NDPIsJuaG+9Udw
         pC4vZeTH58yx46RU/uCwgObKtPY3rUx5hKHwSvDXR0aPbkSQ5azf/jmGuYSGw8V+4oeC
         +aBKilPWhUkVBBYCB8eX873bCY1+C0Nag4xWWxB51IrFybF91i+PNj65vspLO0016R+o
         rIvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1xQi+QgfItK0eKGA3xxSrnOOLfBqRB4mSdmROeiq7eIRp6lsr6KL7Abfb90YUn9ifvAJsCQW6EP39x8aBp9Y=@vger.kernel.org, AJvYcCXAJ9RSu1LVLcaOnxdcKLK8L7HodN6VElO/KfZwc5xnuJbbG1r7z0Kfe07DaMfl169GOgEHhtDmrEV5L40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXef6i/6Ow5zwnLWt/7L43JXHkaV5SVTEq0OXyf0D9O49DQcnE
	+mzsS+oglOMRlbo2e2KHcuUfi4fm/8nEJIYFSOf4jbOG6a/tgbmp
X-Google-Smtp-Source: AGHT+IGtCzQWoZOtKA3syrQPJGzUcBg/Ps85zPwRD229jSRfHPmnAAhoD8+rYvbPIs4FoggfBXP+Ow==
X-Received: by 2002:a05:6870:c110:b0:278:986:1e44 with SMTP id 586e51a60fabf-2780986204amr6402016fac.18.1725390534144;
        Tue, 03 Sep 2024 12:08:54 -0700 (PDT)
Received: from pfauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806bfb8f5sm552822085a.12.2024.09.03.12.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:08:53 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id F0E191200087;
	Tue,  3 Sep 2024 15:08:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 03 Sep 2024 15:08:53 -0400
X-ME-Sender: <xms:xF7XZhQlqc1otvOeyL3vr-oO9IrY6CSO7MadvUT0j0OJIfsDU9UaNg>
    <xme:xF7XZqzdulaaoXFRRpZw302oMPagZPhRiMicFT0v21YrS3umSonTtNea0MLEJhQYN
    eg7L15a84ex8BsklA>
X-ME-Received: <xmr:xF7XZm1CqUqXTQ_WQnUsVUN7W9BxBYkWjUB_H6f5mBaOidaK56U7Vi8jNxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfekudfhfeffvdfhhfdvtefhveffhfeftdef
    vdehjeegkeeftdeggfevfffhveeknecuffhomhgrihhnpehpthhrrdgrshenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdp
    nhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
    hkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtph
    htthhopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhies
    ghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonh
    hmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhn
    rdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrghesshgrmhhsuhhnghdrtghomhdprh
    gtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:xF7XZpCiHuPyziMORgpFYPZnudQdourFlgh3PsHv587ReIoX0LPgJA>
    <xmx:xF7XZqhbHDP7sL-EOBI6lTHHtZ8jL6H0-S1OliblQBCJFX5I87OIZQ>
    <xmx:xF7XZtqSMu1mueqmLcuIoDlgEocfDDJzCS_N1XQzfh-suPtK4MjBsA>
    <xmx:xF7XZlj0DU7e5fem_WC7oHUY29dym1oDgRuWFZkJjUbsgb-L23MeUA>
    <xmx:xF7XZlTmSF9vnAj4mIsBVsorEz-XWWXUeV85wPtlePiIEpaYKmlpB83J>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 15:08:52 -0400 (EDT)
Date: Tue, 3 Sep 2024 12:08:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <ZtdemCduZ1KqayXw@boqun-archlinux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-14-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816001216.26575-14-dakr@kernel.org>

On Fri, Aug 16, 2024 at 02:10:55AM +0200, Danilo Krummrich wrote:
> `Vec` provides a contiguous growable array type (such as `Vec`) with
> contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> `Vmalloc` or `KVmalloc`).
> 
> In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
[...]
> +
> +impl<T, A> Vec<T, A>
> +where
> +    A: Allocator,
> +{
[...]
> +    /// Forcefully sets `self.len` to `new_len`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `new_len` must be less than or equal to [`Self::capacity`].
> +    /// - If `new_len` is greater than `self.len`, all elements within the interval
> +    ///   [`self.len`,`new_len`] must be initialized.

Maybe use "[`self.len`, `new_len`)" to indicate `new_len` side is open?
Also `self.len` may confuse people whether it's the old length or new
length, could you use `old_len` and add note saying "`old_len` is the
length before `set_len()`?

> +    #[inline]
> +    pub unsafe fn set_len(&mut self, new_len: usize) {
> +        self.len = new_len;
> +    }
> +
> +    /// Returns a slice of the entire vector.
> +    ///
> +    /// Equivalent to `&s[..]`.

"s" is used here without pre-definition, it's a bit confusing. Either we
use an example here, or we can just avoid mentioning it at all?

> +    #[inline]
> +    pub fn as_slice(&self) -> &[T] {
> +        self
> +    }
> +
> +    /// Returns a mutable slice of the entire vector.
> +    ///
> +    /// Equivalent to `&mut s[..]`.

Ditto.

> +    #[inline]
> +    pub fn as_mut_slice(&mut self) -> &mut [T] {
> +        self
> +    }
> +
> +    /// Returns a mutable raw pointer to the vector's backing buffer, or, if `T` is a ZST, a
> +    /// dangling raw pointer.
> +    #[inline]
> +    pub fn as_mut_ptr(&self) -> *mut T {

I think this function needs to take a `&mut self` to mirror the
`as_mut_ptr` of a slice.

Regards,
Boqun

> +        self.ptr.as_ptr()
> +    }
> +
> +    /// Returns a raw pointer to the vector's backing buffer, or, if `T` is a ZST, a dangling raw
> +    /// pointer.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *const T {
> +        self.as_mut_ptr()
> +    }
> +
[...]

