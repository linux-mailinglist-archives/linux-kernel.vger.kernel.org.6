Return-Path: <linux-kernel+bounces-546373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ECBA4F9C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B27518875D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FD2045B5;
	Wed,  5 Mar 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="nlNBduz4"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BFA2040A9;
	Wed,  5 Mar 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166395; cv=none; b=QQh8FemlA/OgSn26ErsycE8kwMzVu8+tpeZxWhwzvzBUXMsbNS4g43R90ZLrcofxxtGWpeAPP51kDQHZ8lbW2aQogVpjb3iAIi819QWPKOllfNxlPNaEUbQghqr8CRcpQxo9SzuWVJC3ptDFrs4WrC6OT3GemsJdwysxYCsJWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166395; c=relaxed/simple;
	bh=PXV1lgxtk0LJOCnUVZPYytYwiCUv/0TsG37dZqIOl/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nx7q82lXAMp51E+PpLJ9zRN7ICdS73nJIcV/r090JnQt2Mqyfrj7zSma4Ahpo3V+QOH/fdujgRS94AlRhyd9TCUEupa1TFWA/ONAPJjJi/dbMAtABgI1k/lj8ZmtlhYbooehqG0TfuHEv37AfaOZLzU7kDLy4Iw7UiHVScP+4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=nlNBduz4; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166392; bh=PXV1lgxtk0LJOCnUVZPYytYwiCUv/0TsG37dZqIOl/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nlNBduz4ZHZqlj/I9rbX6gNHgyyP1jbR/UNWgfcGPMMd8WFnpSb7TDH41VkRZC66j
	 ZfVGdeOo34UWm+kRG+DDpic4u6JN9XjjrpyO+4QYfI1IDTjI/rCMaXrgzU5x6CIhkt
	 vxQyW7YrKTAHwshbfMnHpoPoKTfV8SPF8tjq/1MA=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/22] rust: pin-init: call `try_[pin_]init!` from
 `[pin_]init!` instead of `__init_internal!`
In-Reply-To: <20250304225245.2033120-7-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:57 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-7-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:19:52 +0100
Message-ID: <m2wmd3hm13.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> The `[pin_]init!` macros have the same behavior as the `try_[pin_]init!`
> macros, except that they set the error type to `Infallible`.
> Instead of calling the primitive `__init_internal!` with the correct
> parameters, the same can thus be achieved by calling `try_[pin_]init!`.
> Since this makes it more clear what their behavior is, simplify the
> implementations of `[pin_]init!`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

