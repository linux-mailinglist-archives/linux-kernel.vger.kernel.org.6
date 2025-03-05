Return-Path: <linux-kernel+bounces-546391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E97EA4FA01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D228188C487
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CE22046A8;
	Wed,  5 Mar 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="bpqDS2Op"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3820468D;
	Wed,  5 Mar 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166912; cv=none; b=p8PpdImmiFLzi3Rww1rSS1jCZYwcVuysjw80Z7AvwsuM13df8XHXe9jB/ZkcKawAkrXJ4lIbBx03DhJJ2dqGbuTpfal8260mwP3yIcNoEhSpsi99GDqOGIcXetmUDU95Irdc2vNKfgesN9NE2FDU/M1HFLo2tzJ+c45XrXjuQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166912; c=relaxed/simple;
	bh=HAmzIWJUJOo5m7sRzM2uEfv02F02Mzu8LISK0F8PUhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rrQRdRdspWNyldDa+82brvIneLFE4NtE8wWBt1A7MN8otkiroB1jKv/Mdpt3koN5wcROPrKCvi31mA3j+py3JE0Sc96XGigx+u7C/4vSWw1MgxlQnT6C0fmFAXmR9s2HRoFZSosi4JLt4qyvUvoVUCbjA+qkmX9eRnQnDX7b/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=bpqDS2Op; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166908; bh=HAmzIWJUJOo5m7sRzM2uEfv02F02Mzu8LISK0F8PUhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bpqDS2Opo2Jz7yrtrC6VB6uIfSMJr5hzBmkWAtPt5cunYJfi/zda1sWGqiqM5kIQ8
	 x3aQcK0MTl9j3K8zsZLnqr/zxHFqNainLpD6CeI9g9Niw9eWuUhUKDxrNvEs+IyV86
	 1LiUNot2ghDtWmEvCT9s5+L+9nBFKc9Pv7MUOLX8=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/22] rust: pin-init: change the way the `paste!` macro
 is called
In-Reply-To: <20250304225245.2033120-14-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:55:00 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-14-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:28:28 +0100
Message-ID: <m2senrg72b.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Change the paste macro path from `::kernel::macros::paste!` to use
> `$crate::init::macros::paste!` instead, which links to
> `::macros::paste!`. This is because the pin-init crate will be a
> dependency of the kernel, so it itself cannot have the kernel as a
> dependency.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

