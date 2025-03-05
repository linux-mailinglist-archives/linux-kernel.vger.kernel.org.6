Return-Path: <linux-kernel+bounces-546682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB2DA4FD9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D623B3ACC7E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6A233709;
	Wed,  5 Mar 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc46K095"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7B1487DD;
	Wed,  5 Mar 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174244; cv=none; b=OVTDQ0DlNmtXjoNu5Egq29cGmsOitujkRvdUxaVwUQ80VP5zTCurKrPeXk3WxUwiLvPTkbqOGdguysqdvicXoG5aihk1NwmDQQFzFnohxO7zY2PO82i2eMx7+K4mqj88HDLHLn90vRk6Jb30G39tDbJRi/FETBZ3+JbP1Jgpqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174244; c=relaxed/simple;
	bh=kqW29jSdmrti6t2I8P8JpBU34vQOvSjv6WsFmhLE2YE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RetYrcL7gBjpEwZuYw0jJEInnN4KXO4oRvx6QzAKfa1+Sska/Iv0eIMTyavKZo0y3ZU/pcN0jUnEqCKNTI917Y48WeuoSaTgrIMfHMEW6mYfZuSaHZZi2ZTvKMdvNbT1tYiTxxTRvhuCVIFQVqcAxMsfzTEE3vc3kLXmnXhvcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc46K095; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234EDC4CEE8;
	Wed,  5 Mar 2025 11:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741174243;
	bh=kqW29jSdmrti6t2I8P8JpBU34vQOvSjv6WsFmhLE2YE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mc46K095o5MwVgsKi5lYm+fewZruuSWY8F+PeTEC/jSvP3iFiloSSmE5m5MWvtM0m
	 EAcR5BMgXEMP+YjglfpTLrS8vx31rNJc2KA6ek2hr6tFvKt/g/3mN8oZotDBgPmOXY
	 r5w4F3r5OCGdeXNnf6waBiRki7iMFamsBHIO9LjBizEgEb8MZa9uYSCPEg872MI1P8
	 3eMd0HBcUPBY/9hJmRExKA1mZ3v6mJqQlYpNhMypAffgNLOx5z7hDxGxQqm1ZafCFU
	 PbhZCDU429yjisxH0tIdiePZ64elBESw+DHEVlqbhRq4h0tDMnBoUCkN8Ov4YJFEpD
	 htl30Cvf90OXQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/22] rust: add `ZeroableOption` and implement it
 instead of `Zeroable` for `Option<Box<T, A>>`
In-Reply-To: <20250304225245.2033120-11-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:54:31 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<4GBkGKBeIGr7_9dZKLrXDqpQb_4t8k64hj3vP_D9fgaBSRRtLMwIQWDTshcTAf9o1sMCD_m9Dl42FHl-DN84bg==@protonmail.internalid>
	<20250304225245.2033120-11-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 12:30:16 +0100
Message-ID: <874j07emuv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> When making pin-init its own crate, `Zeroable` will no longer be defined
> by the kernel crate and thus implementing it for `Option<Box<T, A>>` is
> no longer possible due to the orphan rule.
> For this reason introduce a new `ZeroableOption` trait that circumvents
> this problem.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




