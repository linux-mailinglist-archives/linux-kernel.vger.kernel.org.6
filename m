Return-Path: <linux-kernel+bounces-552452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E26A579F0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B032169949
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9271F3FF8;
	Sat,  8 Mar 2025 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZzFyBRMe"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8071EB5F5;
	Sat,  8 Mar 2025 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431946; cv=none; b=uAvZrd6JEVX08H6FWbwBjx4Ds5Y4LMq6IkFOh+7+KTr9mvculr1+n8BGtwSdsWisnwZ2rRW1h/RH83rueGEpK+qxEECwgg56Hz59nngHE5d66sQUhtbcNzrfyGEelAwmDFgYbf+6kTSmn6SXwaS5P9ZyRotJMbZdBjIyBtAdEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431946; c=relaxed/simple;
	bh=r5+NIDp2XF4eMwhB/70g3s0n8TuRc4TRKSpPySgRDUo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJt7AZqI+Uvv++omMywqmCJbW+bkHohl2fTMxbtTbijY+qVYSYMfkSzScjUX4OoAJUt7PyuUu1hcoDKsO1zGPXv/Hs1XkievXHUYyilWhSDcxlNVaXhocdVXUwxVs6y93fjRfeOUfntVA4bJ9iv+ylzsITGT3SmbXtF8BdGlZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZzFyBRMe; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431942; x=1741691142;
	bh=r5+NIDp2XF4eMwhB/70g3s0n8TuRc4TRKSpPySgRDUo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ZzFyBRMelHpk6HnnU9zY2n36G9bpjkZePBnVUEhUqobmAEbsEWCmkMKrO+IKR6xt4
	 msCXgisq3k+Jta4xG04z61qvJYq2ZXnAfsrePLsalZcge8YjDKXCMU2cVXoPpqCGQo
	 yAHC0bPIsHYsXIE1QlMt5F/jiYrbMMDFfH589G/3sWgMp5iZo1rbIaPYV6+zTvpx0+
	 UIxiy9647ti+hI97jEHHiRa7fblAGKfUktgdgqMugREKg2qITnH5Nf63MLxiMmF41i
	 8oheHu6jtCyzzTYkS1h+QZr0wt2HUIqn0EHqvrzo/5HEM/15N+iy1Fy83wobSW6TKh
	 GPfsvfDbQj6Xw==
Date: Sat, 08 Mar 2025 11:05:39 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 22/22] MAINTAINERS: add entry for the `pin-init` crate
Message-ID: <20250308110339.2997091-23-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 998cc5c1787eabe84b45a746df8538c804016087
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



