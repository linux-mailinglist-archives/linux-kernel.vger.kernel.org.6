Return-Path: <linux-kernel+bounces-545747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C510FA4F0E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8153AF8CD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F627F4FA;
	Tue,  4 Mar 2025 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hTNQS3gu"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3E279349;
	Tue,  4 Mar 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128996; cv=none; b=W4GeQDsGq0qxfvx6TI6vz2vM8IyJ+uf/UhAli08BpvV6h3eO9o+/NlzsSO3dpnviDiHb1evuozPRkP5WFeaG2+CdQisoFCQNdjLMEKWCY8brgmxj/n39+XTpnrlUd2FJGF6n0gK0xwKh5WeikO0VKgwWGNe47PjtZK9U/oPsoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128996; c=relaxed/simple;
	bh=r5+NIDp2XF4eMwhB/70g3s0n8TuRc4TRKSpPySgRDUo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiRkdb1AiQVwYhXRWKMqkav0PsCzWqXBzRsUFr1pFt+MJYbmdmILPjnbhfhWdrK7mKXQK3FsCjdXFbGIm+JSJTYVPJ3S+9bUXl3xe2xjHzw/g8+mZzifboImM6ih0mgHDTHLBNZnPpcXuY2lP5ZA8W/O4ODuy8Mg71QBzakESHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hTNQS3gu; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128992; x=1741388192;
	bh=r5+NIDp2XF4eMwhB/70g3s0n8TuRc4TRKSpPySgRDUo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=hTNQS3guqlirujrKkdUKhdpz9it3OSQ2h00UoTWu8D9A+q9O6P0Qjr9Uq7ZD0qfrB
	 AH4oqqLt9044INAjieX/JNiIosk+yfIpI1BW7rfLQrgGUpxcj5/Hf8TgMyYyXDB1CF
	 gbfq5wjMh0XigkI8+DVgIK4HpZwCGB+loP+c09syRA1t0HafJVwD7MX6kOCxXlKNTD
	 UwT2JBVjVXKoxkl8fRGoOnc8jl6FMpLyVypdQnlvHAuEWx4AKaBdESFA4l+JVovou0
	 VtGFePWNVfVuqH2DP2QbrHroYdQseEhm9WDsAvN4gOPQibOfomIkwgbUmN1tU+0dbW
	 Jzf+z3rPLUKVw==
Date: Tue, 04 Mar 2025 22:56:27 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 22/22] MAINTAINERS: add entry for the `pin-init` crate
Message-ID: <20250304225245.2033120-23-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 344408caef3f5c1422addc16dead2ce56178304c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add maintainers entry for the `pin-init` crate.

This crate is already being maintained by me, but until now there
existed two different versions: the version inside of the kernel tree
and a user-space version at [1]. The previous patches synchronized these
two versions to reduce the maintenance burden. In order to keep them
synchronized from now on, separate the maintenance from other Rust code.

Link: https://github.com/Rust-for-Linux/pin-init [1]
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..ced7fac4dbbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20735,6 +20735,19 @@ S:=09Maintained
 F:=09rust/kernel/alloc.rs
 F:=09rust/kernel/alloc/
=20
+RUST [PIN-INIT]
+M:=09Benno Lossin <benno.lossin@proton.me>
+L:=09rust-for-linux@vger.kernel.org
+S:=09Maintained
+W:=09https://rust-for-linux.com/pin-init
+B:=09https://github.com/Rust-for-Linux/pin-init/issues
+C:=09zulip://rust-for-linux.zulipchat.com
+P:=09rust/pin-init/CONTRIBUTING.md
+T:=09git https://github.com/Rust-for-Linux/linux.git pin-init-next
+F:=09rust/kernel/init.rs
+F:=09rust/pin-init/
+K:=09\bpin-init\b|pin_init\b|PinInit
+
 RXRPC SOCKETS (AF_RXRPC)
 M:=09David Howells <dhowells@redhat.com>
 M:=09Marc Dionne <marc.dionne@auristor.com>
--=20
2.47.2



