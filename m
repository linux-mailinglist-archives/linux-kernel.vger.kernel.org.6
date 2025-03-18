Return-Path: <linux-kernel+bounces-566092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2FEA67319
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944513B3B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C2320B81D;
	Tue, 18 Mar 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWYWPWeK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220720B808;
	Tue, 18 Mar 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298501; cv=none; b=L1nQ0VgsJddzoOOrzH5VSOzkCxEIJE5JyBherD4fLqJgmiCVBoZiuBYFoVG1FvGgTY12iyomlCyJDxdezW0wnoWpO+yJqfLFfpNAPHgzfRUQ8khig/9FTDtKLJcFf77JffCn/HpG9Xwewp6kuODtrmRkiGh9AHVeqZkmiCzUyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298501; c=relaxed/simple;
	bh=iZKbysmadyN4gvdvLBypMLfzEOWp2ju0duHYR4lHPig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXI91R4z6vmm3ivlrwSbFaixS4DmSDdxytDWwZGHHSXE35JIkemVm0eOQw+UD/PrYxwc4SgbhVe7jc9Ok+RWglPuEUg0rkL5St9FKs5pOa798VOZlcdkAFHgGBcvVQ6mOH9ygg/UXWf1Je42RRbxTrcWyqT1SYE1T5GlRhORs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWYWPWeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C537C4CEDD;
	Tue, 18 Mar 2025 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298501;
	bh=iZKbysmadyN4gvdvLBypMLfzEOWp2ju0duHYR4lHPig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gWYWPWeKS7Sx7FfdzxS7/bUuhU88K36ELyJouE0c8Cfa72ImZYXUH0DKR45zBuTid
	 zuKJzc+58JQsymAsmVrVg2V0zd6HkPj/dKFK+cw0X6Q8rx1KZ7seEYC8y7QDa0woL0
	 lHfplkziKGrCboe+PutiqE9D+SnjmiPog/4VzFhj0sU3f9OlczGf2awiGc4Adtdm/P
	 FozyuyjjuSq0Rzt2Es6K3K9okuyhISavkVkvOYRtJ+kZZEeNH1Tw8NJ6A/HV/h2yl0
	 x2O3hWzFNAjY5Zvr3JDD5Zyv8l6SMsrNOfd+iV7Mi/3E70upcpUB2+ClcUAjwts1Jw
	 dnKv5qvwlY9ew==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Fiona Behrens" <me@kloenk.dev>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/22] rust: pin-init: move `InPlaceInit` and impls
 of `InPlaceWrite` into the kernel crate
In-Reply-To: <20250308110339.2997091-9-benno.lossin@proton.me> (Benno Lossin's
	message of "Sat, 08 Mar 2025 11:04:34 +0000")
References: <20250308110339.2997091-1-benno.lossin@proton.me>
	<4jTSWKhER39aInjsYkcRrNWw9o4HPVOeasiHy5Trqkc6aRdtG0T6b5U41ynKNv0KCySjSaMLIQuD5KDI_y62oA==@protonmail.internalid>
	<20250308110339.2997091-9-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 12:37:22 +0100
Message-ID: <87cyeelgct.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> In order to make pin-init a standalone crate, move kernel-specific code
> directly into the kernel crate. This includes the `InPlaceInit<T>`
> trait, its implementations and the implementations of `InPlaceWrite` for
> `Arc` and `UniqueArc`. All of these use the kernel's error type which
> will become unavailable in pin-init.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



