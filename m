Return-Path: <linux-kernel+bounces-287630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2475952A23
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3F71C21358
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C011817B51C;
	Thu, 15 Aug 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="luiBVcIL"
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D45199393;
	Thu, 15 Aug 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708184; cv=none; b=rGO3eu5d2b8A5Ryci6yTYRHBn+Mx48BZD3P9r9U7C52b3Xbgq0wPB9FIuVz3pZ5onvMkG2LGFx1fs1GBi8tHY+rvDr80yYQpddROUEL8pDTzkgIBSvqmjZCqvegjxvzK8YM1TupMwZuPT9VunzmHJh+LrKFTUKq+1EQ4foQSKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708184; c=relaxed/simple;
	bh=5nwVUuNYwKfVCpbEE+hUU9mFT7cu5aK8oxDDp7r0klc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VIcwUKvlt0Q4bME4x0JscSWIgdHoccq1xHAv5xq+SZBANnxT2cfo0sLuO0x8UswHGHg2s66ZXchnbL/73cwAP6E3zX9HHgPtarm63in4ngSe0jkTJrK8CkWNZau7OkCbfqzwqxapHzX/eXuv3ncR0XSGyW3r7U1MJYbqIFhgVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=luiBVcIL; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1723708175; x=1723967375;
	bh=pIXY+KRFjfzm2ElAJyOBnCOo4x0siZc6A7HAj9o5HdY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=luiBVcILTJT1FVlY8AKCrYNlcQDeG6ESjOFmw8nhdTiQ4U9C0oxD3zQ/dFycluFIu
	 mOdJ0xKijQutqSrkMy1lHnm7RJBieKQxSHtt2+6oZ192Fp8sRWEQcGTdEJRdGqkFzG
	 WGMH5Bs6V6eHKm/Ct/izUUJDuVaHIBsW86vO6WAvQ0pJGqT0CWN0Bf8MgEb4kZ1jXC
	 b8ueHL+Z84YeR+WIvmsLZWkO7jiSXiUPeOc6RtPNm4LiHce2HuhZUOcKzY78VXVCdl
	 XDHUSAU89gj4ssgPK/Pz7Da+CMLkwHO0RdRii8/9CCwnLBnbK1+5skB91fc4y1AyJc
	 qqxRqM32oDlAA==
Date: Thu, 15 Aug 2024 07:49:30 +0000
To: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: fix export of bss symbols
Message-ID: <20240815074519.2684107-2-nmi@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: efe389b12c330869968acf4e5341f24708aaf04c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Andreas Hindborg <a.hindborg@samsung.com>

Symbols in the bss segment are not currently exported. This is a problem
for rust modules that link against statics, that are resident in the kernel
image. This patch enables export of symbols in the bss segment.

Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 1f10f92737f2..c890ec4b3618 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -305,7 +305,7 @@ $(obj)/bindings/bindings_helpers_generated.rs: $(src)/h=
elpers.c FORCE
 quiet_cmd_exports =3D EXPORTS $@
       cmd_exports =3D \
 =09$(NM) -p --defined-only $< \
-=09=09| awk '/ (T|R|D) / {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $=
@
+=09=09| awk '/ (T|R|D|B) / {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' >=
 $@
=20
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 =09$(call if_changed,exports)
--=20
2.46.0




