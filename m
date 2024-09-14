Return-Path: <linux-kernel+bounces-329562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F79792EB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 20:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 879F1B22B39
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0361D1315;
	Sat, 14 Sep 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DtBwNX+U"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891671CDFC6;
	Sat, 14 Sep 2024 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337832; cv=none; b=Ii2FjEeqierl9SXh4eefViV2Wn9ki5PO2VVDcufa6J1YLjziirud4x+OGABtdCzbHcH+jiov/EPFUcjfcZC3kEWIsTxsK4cwpKdaFZ2Xi4SCBZNQ79spBNSdt656HcQuJbSgh9TADA7TnBvr2h8w6rayVl8sp1NugekCbGcE8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337832; c=relaxed/simple;
	bh=KSxYMvwzWExMOlybnMZ65eeInZIByCHwyO/WMYkPYac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPTAgag8tF5wx2unT4WXlFpPt3N3MXgDESGJgRkMZo6ZooD5WimHKMaNYcePHfXOu/Y9rCDZrwOSto9EtTUOOFpCndHjqqCtlBovl/PPqOTwnvRApUdJFRUqwXAmLBx+DhvJLmXWn+c+l0rMLDHvyiFKtCnkkeIifv/3yAFJseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DtBwNX+U; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726337822; x=1726597022;
	bh=/KR+FXEOU6u/KXqaVStIhlDxBZ9t2csbGHnVL3UlLOc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DtBwNX+UdrRc/re1CvuzSkks1sKdbdnPqNwaCiJxV/J180X8zsibeSpa3gVNScZVV
	 eydnH5cEtmvQjRHJ08P2LYsygxcGer7fZQIbk7Jj/JLPpDDSyoLj15fk7zd57UZJVE
	 8HxFsFdut56QHn+O1SDRGfnckx75OOnnCU82TW5jdZ3tYODV7HYTm8i1O+ThZKOoyX
	 jJWnqn6xowBa7LHkRU0Vjrpb8HMom8HvkaYi/CFQCOdsyhyKVwxiEAneVoNf1kX9es
	 4h7BXEGDMScswPBh8UGxZ63KPHDXw3BJ5tBhjmX0uj2WO+MXhym8qFTxVu/CfPfjch
	 OUosgS3hfyg+w==
Date: Sat, 14 Sep 2024 18:16:56 +0000
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Patrick Miller <paddymills@proton.me>
Cc: Patrick Miller <paddymills@proton.me>
Subject: [PATCH v4 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <20240914181618.837227-2-paddymills@proton.me>
In-Reply-To: <20240912195649.227878-1-paddymills@proton.me>
References: <20240912195649.227878-1-paddymills@proton.me>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: 7b1fc0057ce9d945857cd673e7073809e11ee970
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------5298901a6e89a37904785a8d17e5fbdf3129cdc3fdfa6b1748cd390d78d5855b"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5298901a6e89a37904785a8d17e5fbdf3129cdc3fdfa6b1748cd390d78d5855b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Patrick Miller <paddymills@proton.me>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Patrick Miller <paddymills@proton.me>
Subject: [PATCH v4 2/2] checkpatch: warn on known non-plural rust doc headers
Date: Sat, 14 Sep 2024 14:16:17 -0400
Message-ID: <20240914181618.837227-2-paddymills@proton.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912195649.227878-1-paddymills@proton.me>
References: <20240914181618.837227-1-paddymills@proton.me>
MIME-Version: 1.0

Adds a check for documentation in rust file. Warns if certain known
documentation headers are not plural.

The rust maintainers prefer document headers to be plural. This is to
enforce consistency among the documentation as well as to protect against
errors when additions are made. For example, if the header said "Example"
because there was only 1 example, if a second example was added, making
the header plural could easily be missed and the maintainers prefer to
not have to remind people to fix their documentation.

Signed-off-by: Patrick Miller <paddymills@proton.me>
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1110

---
v1: https://lore.kernel.org/rust-for-linux/2024090628-bankable-refusal-5f20@gregkh/T/#t
v2: https://lore.kernel.org/rust-for-linux/92be0b48-cde9-4241-8ef9-7fe4d7c42466@proton.me/T/#t
  - fixed whitespace that was formatted due to editor settings 
v3: https://lore.kernel.org/rust-for-linux/da34f89
c-f94c-43aa-946c-57fec3597974@proton.me/T/#t
  - move && to previous line and remove whitespace in WARN per Joe Perches
  - reformat following C coding style
v4:
  - add @fix option (credit: Joe Perches)
  - add Error to list of checked section headers
  - make check for rust file its own if statement because more rust
      checks are planned

 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..d4711cd14b36 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3900,6 +3900,18 @@ sub process {
 			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
 		}
 
+# checks for rust files
+		if ($realfile =~ /\.rs$/) {
+# check that document section headers are plural in rust files
+			if ($rawline =~ /^\+\s*\/\/\/\s+#+\s+(Example|Er
ror|Guarantee|Invariant|Panic)\s*$/i) {
+				if (WARN("RUST_DOC_HEADER",
+				         "Rust doc section names should be plural\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] = s/\b$1\b/ucfirst(lc($1))/e;
+				}
+			}
+		}
+
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.46.0


--------5298901a6e89a37904785a8d17e5fbdf3129cdc3fdfa6b1748cd390d78d5855b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmbl0xgJEJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAP3hAP9EAzqV0t6KrEC30osktcjOX/wpmG6aOPo3cI/JBduDlwEAoVUT
XtySwU6su03pc2emeY/dFraDHGFhAOjOeEuKqAE=
=Dyq5
-----END PGP SIGNATURE-----


--------5298901a6e89a37904785a8d17e5fbdf3129cdc3fdfa6b1748cd390d78d5855b--


