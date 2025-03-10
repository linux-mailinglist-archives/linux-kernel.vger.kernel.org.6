Return-Path: <linux-kernel+bounces-553770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A9DA58E93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A996A18868C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1A52248B5;
	Mon, 10 Mar 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CMTv3bYR"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5521224254
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596620; cv=none; b=cweGUsU/6JyGZMk+0TCipKQerXvRsb16y656GYiyUaVr1N8IGpdtoHA0QZ3kGba5S5nGVlZqnkAF01AFPDjGsG2cIxKbyipi8qsLumpt34qV/jVZ8Yzh+0GSO+WQOyYk+pUZ3KECWeuDEcR6KfULwXCN3A6DIpTPVAB6KWWpwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596620; c=relaxed/simple;
	bh=idDmyFUgXPaJOu1CXOrhpiHpL6UUs3ZIpxSUAda+eJk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+7x3zlfdigbnZetn7Avbml5br1K1RMeotP+dgcVqOKsoITrPdEDHkWoQxwKHvuC7B+NVMR2NU/tCLpBpV/CMp3pmEjtInCWGiBcuGME13jjh73Uw9nmiODNDGQ8yfahp5B7I5mbD2TTaUgE106nu4bZ6t6JLYBnrL8l49QyimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CMTv3bYR; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741596615; x=1741855815;
	bh=F63nsiaAbeY5umplCWazypSw8hjLyornkx6vX9eWMF0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=CMTv3bYRYOOgvAzvgUfXHBBZmgSAPPkaWyizeDzvxGCmwGYbBJb4bIjI6yiIYl84a
	 B4Gy+d0E6HDXRSQ14Wens9JYt5dMRcwvdzcvZfu9NlBM0ytmhdgXBUVgKZ8IhKIQr+
	 eR5AYMaZ7PjmOHJB/g072Ll6BzL44GhPO/6LhSRzRH3DE2PEORGOsVuK35LIBMBsWt
	 NfDElYBnoMassHrCVxqwQy4W1ONHZUcmzONEhMzAfkFunFSii4ja7SHzIzTHS66tuo
	 alNQIA1E+7G2vILZ9lYKp+5ba0qMRTyBtYMSOQUGLIXA9cYP4HyifNRLb4ewnirhvH
	 4QQyJ3wDoZN/A==
Date: Mon, 10 Mar 2025 08:50:09 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v6 4/5] rust: kbuild: provide `RUSTC_HAS_DO_NOT_RECOMMEND` symbol
Message-ID: <20250310-unique-ref-v6-4-1ff53558617e@pm.me>
In-Reply-To: <20250310-unique-ref-v6-0-1ff53558617e@pm.me>
References: <20250310-unique-ref-v6-0-1ff53558617e@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: b8f67d842ece3d2b1058e4c6d1611284cfe1bb7e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Miguel Ojeda <ojeda@kernel.org>

Rust 1.85.0 (current stable version) stabilized [1]
`#[diagnostic::do_not_recommend]` [2].

In order to use it across all supported Rust versions, introduce a new
Kconfig symbol for it.

This allows to perform conditional compilation based on it, e.g. on the
use site to enable the attribute:

    #[cfg_attr(RUSTC_HAS_DO_NOT_RECOMMEND, diagnostic::do_not_recommend)]
    impl A for i32 {}

An alternative would have been to `allow` the following warning:

    #![allow(unknown_or_malformed_diagnostic_attributes)]

However, that would lose the checking for typos across all versions,
which we do not want to lose.

One can also use the Kconfig symbol to allow the warning in older
compilers instead, to avoid repeating the `cfg_attr` line above in all
use sites:

    #![cfg_attr(
        not(RUSTC_HAS_DO_NOT_RECOMMEND),
        expect(unknown_or_malformed_diagnostic_attributes)
    )]

That still loses the checking for typos in older versions, but we still
keep it in newer ones, thus we should still catch mistakes eventually.

In this case we can promote it to `expect` as shown above, so that we do
not forget to remove these lines if we stop using the attribute somewhere.

Link: https://github.com/rust-lang/rust/pull/132056 [1]
Link: https://doc.rust-lang.org/reference/attributes/diagnostics.html#the-d=
iagnosticdo_not_recommend-attribute [2]
Link: https://lore.kernel.org/rust-for-linux/CANiq72mYfhuRWkjomb1vOMMPOaxvd=
S6qjfVLAwxUw6ecdqyh2A@mail.gmail.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 init/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 12b0847603b20fe1d8c70c4c57dabc924efe697b..ed1abb1beec0767f3696dbb6ac9=
844ba7e0610c9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -147,6 +147,9 @@ config CC_HAS_COUNTED_BY
 config RUSTC_HAS_COERCE_POINTEE
 =09def_bool RUSTC_VERSION >=3D 108400
=20
+config RUSTC_HAS_DO_NOT_RECOMMEND
+=09def_bool RUSTC_VERSION >=3D 108500
+
 config PAHOLE_VERSION
 =09int
 =09default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))

--=20
2.48.1



