Return-Path: <linux-kernel+bounces-516820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4295FA377DA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535613AFD9A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CAA1A5B9C;
	Sun, 16 Feb 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WgHNDspo"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B41A3166
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739741930; cv=none; b=NCzHmTJXX/PTEVvaa0Qb+DYGjMHQh0Xs/W+tXt4V34eQApng9jKxzNGv2GSRpjgs82h6O6aLDTCEEYMa9pbuC+klDH9pRa32RUN2pqr99ZgZdhxDcgRVKhdcYGbcYLPS/b6dRfnBYv1alUzxHBVqm06CXUTD1AWsoqQha5Tm3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739741930; c=relaxed/simple;
	bh=QeFFtZgHkMaXspJcP66WLFzo+8qNtheRTzO9lhhvciw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OHtXH75ewLF4Y4zRjhf60XzTtw+OI9kR2SzDC37jBkUc+BXZIlz/eTCeD29JKQyh6+A9TSr2F89IEUcJJ+m1x94AhrUi29CkFRe9NyG7gWK/fcputCqexSg+QOyMCmTOCldoMbjyT7hkGFzsaIoHtJH2fln6Za0IpzJFerkq25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WgHNDspo; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=mfss4sjirzaaxdt4eycarldnya.protonmail; t=1739741920; x=1740001120;
	bh=QeFFtZgHkMaXspJcP66WLFzo+8qNtheRTzO9lhhvciw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=WgHNDspolWnALrDwVKo6LCCw3kSADs7v4pk1fWDAo6ZLwI+7gE3OHRrVfBwwH6nxQ
	 0tcPkJ6Hd4rNIyVJt6w7Ozc/zEsQE0CIHgMdZYwgF20dIKeQwcDaITUbc6dOlcUJLI
	 qK6HsxWHrFlCZAahRLaJASdUAvOxJQCWkKP20oTZmIKnLNpw1hf0StvEU+CofVxD2S
	 42IB9yxRCQQL2/zPf54tpjdL40yUPmjGWnkgzbsdnKYGIW2DJioz1I2hIYGiv8Ai7F
	 EbEbptAIX04PVjyQVD4LBYAxDaHLY9blNsIekHvlzYuUn0gXppzqmo6zOFxVHbewd7
	 pSMiZ/OQJGkKQ==
Date: Sun, 16 Feb 2025 21:38:35 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: fix clippy::too-long-first-doc-paragraph
Message-ID: <20250216213827.3752586-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 94730bd3855b21b6a0950b7b805e9e24c365066e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Before enabling the `too-long-first-doc-paragraph` clippy lint, fix the
only violation by prepending a short, single line description.

Fixes: ea7e18289f44 ("rust: implement generic driver registration")
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/driver.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 2a16d5e64e6c..65c9c1776556 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -10,6 +10,8 @@
 use core::pin::Pin;
 use macros::{pin_data, pinned_drop};
=20
+/// Generic interface for subsystem driver registrations.
+///
 /// The [`RegistrationOps`] trait serves as generic interface for subsyste=
ms (e.g., PCI, Platform,
 /// Amba, etc.) to provide the corresponding subsystem specific implementa=
tion to register /
 /// unregister a driver of the particular type (`RegType`).

base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
--=20
2.47.2



