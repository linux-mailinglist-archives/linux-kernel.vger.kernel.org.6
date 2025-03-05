Return-Path: <linux-kernel+bounces-546382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E412AA4F9E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328C83AC316
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F2204698;
	Wed,  5 Mar 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="o2JMilfB"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9820127B;
	Wed,  5 Mar 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166673; cv=none; b=g67itnMoMg8Fr5PuQZD7YiIPeZQTAPDlJNoyESazU8vgOjw29coOyi+ivDkDLfQOFr1+2CTKUf+1LaOybNHI+ZYyhheo2nYlWChySFss4miOXyKFB+/HzdFE0e5RpKq1UP2Mx2zYlswcRVrH4Ea93OHHP0oaG/WBpkhBH/9ix9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166673; c=relaxed/simple;
	bh=6Dueg+2Uh89sCdGWEFbTAs4vQ/frbcNjEkOb9fEQdnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MhE9U+ODJaIfzCHpDZF0jRmxV5x3ObYQFg/zbndD5K9HNTwYC1ZO0Et5YAeaenZVhxbd61+zfg7H4VvjRwz5lzZcVmSRmhSe2yelDf8PNMg+NjG3tjRy2JXJ0o7oPp+b8NArmRiNjb70hcCKNkuhZYMqzLJ1H2qs38/tYT5x1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=o2JMilfB; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166670; bh=6Dueg+2Uh89sCdGWEFbTAs4vQ/frbcNjEkOb9fEQdnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=o2JMilfBJnkhN2G218kqWioBEY03/YwN3nx/IZ1ln5kTopf5+FNbsy/9+arBoc0iE
	 Rq6P1AiNeb1y3JQCY5efsR8O5v/VOv14veSmLlGI/7Y/8SFT6S2O/qN7ZPyBlRCGc1
	 q5ZVPinrNAhOxCCGZPOcQNif0klUAsB8e5Q8AQ8k=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,
  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Andreas Hindborg <a.hindborg@kernel.org>,  Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/22] rust: pin-init: move impl `Zeroable` for `Opaque`
 and `Option<KBox<T>>` into the kernel crate
In-Reply-To: <20250304225245.2033120-10-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:54:23 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-10-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:24:29 +0100
Message-ID: <m2frjrhlte.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> In order to make pin-init a standalone crate, move kernel-specific code
> directly into the kernel crate. Since `Opaque<T>` and `KBox<T>` are part
> of the kernel, move their `Zeroable` implementation into the kernel
> crate.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>


