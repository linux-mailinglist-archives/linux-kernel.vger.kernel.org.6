Return-Path: <linux-kernel+bounces-546398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C3AA4FA25
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A30B3AA3E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD05204C2F;
	Wed,  5 Mar 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="r+h7OFXx"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE31547E2;
	Wed,  5 Mar 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167141; cv=none; b=mNGczmZL/vuQYQz7BccSa4dthG8ge9LdLKmyRff3zVF/bMQ+oY4DjGL1qL7OV9+rzoiC3QOHMcAIR3bDV6jlG9qO3OGYXv+tH3Phh8TLjEK7INrJs+5tsXnCFgNOhrhscfzXG1f9EdkbzOxKscLHLG7sNoiUhIvTZcKXYuHjc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167141; c=relaxed/simple;
	bh=Pfk/zB+A/uUvPI8g6Yk3/5DKZZjnI1cmWg90wF/do9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uiBbDWeDo8nZ4gTiRcQUxRNtQN2+lU3Ybp6KfClYWHrZFOCzzBPa99MopUFfnVZelLSvzQ8LKpW5YJHh3KvXZ53KBUSo4DxpXaS0vg70zS+7tKuK9APw/XEtQxdTK8NeXiBVgAV4clj3hklFlYsdlSnPPcY2LGuvYukhS9txm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=r+h7OFXx; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741167137; bh=Pfk/zB+A/uUvPI8g6Yk3/5DKZZjnI1cmWg90wF/do9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=r+h7OFXxgk9Q4pxX/wK8QrWpzSyPRQSi9Sf/Rkp8mGNQhqferpr/z900xsmhSTqKg
	 nOsSYu0RGTppQqxQuCdDXJGB4Or/o4+qYsHgiCoXckVDhhYFZHEVExFLoeEHOJBhci
	 ZI8Y/oLFUtDazR8sI0TLtAt3TG4d17uYExh5V2Lw=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  linux-kernel@vger.kernel.org,  rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 16/22] rust: pin-init: add `std` and `alloc` support
 from the user-space version
In-Reply-To: <20250304225245.2033120-17-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:55:32 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-17-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:32:17 +0100
Message-ID: <m2h647g6vy.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> To synchronize the kernel's version of pin-init with the user-space
> version, introduce support for `std` and `alloc`. While the kernel uses
> neither, the user-space version has to support both. Thus include the
> required `#[cfg]`s and additional code.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

