Return-Path: <linux-kernel+bounces-405704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB7C9C5605
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718372851D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C809921F4BF;
	Tue, 12 Nov 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHWiZsx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFE21EBBC;
	Tue, 12 Nov 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408602; cv=none; b=QCJp7sRhTG8BqWDeAi6HXrDNB/X57Y7z41D030RuKTMUGDADGAjZDC8nleErgohcH33DnCX61FxjAipTZTF9KwZ3S1ge38hjP1TqXFEeYTdEuNVfNhMakr5cgU+6DB03/Yeb5bIHaiu3tHQNs0Ndn4Z/Ls16ER1jPz9a53n8EZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408602; c=relaxed/simple;
	bh=2LtJ6LIQPEot/STYnu9LrFvWXA/RX5wArFzBBTsAx2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNLj6Hn7u+2BymxlGwwTwnDQ3LuVVh+LBZp786jZ3MR6LTViGjsXpAfV1fi08osuaz+bEZ+cLYzpf5mQEXAnimqY0VyrYm6d/HghOyK1+scpYwSk+3i6DS4xoAOCxd0HbbHt5JBQOxMrsAk+C2wOK+/nC6eBB/RUU1GSXG2h4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHWiZsx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2BDC4CECD;
	Tue, 12 Nov 2024 10:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731408601;
	bh=2LtJ6LIQPEot/STYnu9LrFvWXA/RX5wArFzBBTsAx2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MHWiZsx5g5c/wb5hwqf8jDj/qIVTD7cSuQ1WoYF79llfbS1Qz0wGnxGG8GwvmWAQr
	 8QAqHVS6nURmY3PMOF4Ke1AFyqjB/5UC4LvTQRT6bjRbN4LEQbeYDh+gP5+BUB2pck
	 Hs+EGcp8lfOebj+bt7AZ3cVht7L0Zxa31k+WL+6mtx3ebfNKgOQVwowhQlLpu5Ywaz
	 z1kjOrTiiw9DQKBk34J9qD2PuROqTGjfxt2dWgC8P3hCUFs15UaRknatDWJJO4QOjP
	 LCqKbcmr7hg2xGN8kCXQdK05+zOw70hXySh2OkXSFCqKAJ4LKFzj1FDBvPZYiRgJBV
	 gp7SXt9gBIC+Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] rust: types: avoid `as` casts
In-Reply-To: <20241110-borrow-mut-v4-2-053976068215@gmail.com> (Tamir
	Duberstein's message of "Sun, 10 Nov 2024 09:14:03 -0500")
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
	<KNMCgZysuWJ8Txv8p8AzM45QyjzEHAvhYOfKS4ttGI4N1QupMGtOmKUZX67u1TD-ExpyLcfvbt9z6oB9ZXduyA==@protonmail.internalid>
	<20241110-borrow-mut-v4-2-053976068215@gmail.com>
Date: Tue, 12 Nov 2024 11:09:13 +0100
Message-ID: <875xossr06.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Replace `as` casts with `cast{,_mut}` calls which are a bit safer.
>
> In one instance, remove an unnecessary `as` cast without replacement.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



