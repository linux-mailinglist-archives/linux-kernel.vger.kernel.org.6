Return-Path: <linux-kernel+bounces-558855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CA0A5EC23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFED87AC442
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A787A1FE457;
	Thu, 13 Mar 2025 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PGTIzan/"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E51FBE89
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849235; cv=none; b=kd+RDT5v87zqS8H1pSKVtXA/TchjcsqZ5hoWfatdTmyDLTHvmnkzLTwiQwciq0JkvKHqHYFthcCj4sd9pxRzEM3mxcN5o4ojzs9SMSrZyVT4EnV4saYbpG8CUM5Jhe2NFD7cxKCdViFRnrH5mOZ/d0AXVVuPBV5fd5VvuVRbrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849235; c=relaxed/simple;
	bh=hbckj2439RyzHlFItCxWkuEvCZCBQ7rX8qiXsoHvjB8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyXRZqvVPAXFedzYzgjlYY3ih+7b6/qbwiZjRteZPYpY6bQa/b+MFnJhZN/p/+sH58r+z8P+kmmE5s9mRbbaprROpLyPd6bDxTg+ojjhETwfXqDoBKesF6MHkdZaZ71WIC+l2bgKZoBK9Mk9iJJ64HeASb+efV7jhtj/52w/5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PGTIzan/; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741849225; x=1742108425;
	bh=0s2berSwzI7yaE7YSCf7lWpcnxi2O3hV8xLc04jUCBw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=PGTIzan/LQj7c0JMPHTpl+JvTNHzA54Hq+ayLzWl+zrYa7LGkTS6Cu2fGCIWoGCHp
	 Iq6SKY4jO1DLvEFxwugWBckNMKthBecmbtnaW6h/BRq/WcPF968VJIHKrZ2XwPBrQ+
	 pQrvbXJRxOO72ouciCYK40wqcb/phq2HMDooRCJW0VxEX3BcjXEP+oFvn5figE2jKJ
	 ffbNB1ZFBdsQ3qiYYYbcIiY1OdOEa6LRZYeoIy0wTBhXPOYEwwXvK/KjJdalI2lNp1
	 sciNZzNGRo43tYKvHTF5duH2J2100fEZvQVRR1zAacUiCw2ySh4fKrhUWp5MxuMrpb
	 b02XL8AafkEeQ==
Date: Thu, 13 Mar 2025 07:00:17 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v8 3/4] rust: kbuild: provide `RUSTC_HAS_DO_NOT_RECOMMEND` symbol
Message-ID: <20250313-unique-ref-v8-3-3082ffc67a31@pm.me>
In-Reply-To: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
References: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: fe3498edcb4202658a8926033d43aa9713e1229a
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
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
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



