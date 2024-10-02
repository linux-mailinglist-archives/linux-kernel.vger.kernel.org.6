Return-Path: <linux-kernel+bounces-346944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0C98CB45
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CF01C221E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D798F66;
	Wed,  2 Oct 2024 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KVchHNls"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96AFC12;
	Wed,  2 Oct 2024 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727836152; cv=none; b=a0z3YKg9QthfaZgxmBSVZ295/0jurKn88R1wFmB1/8F+9BRHHzf+6PAnUmgtVE1gi7b3cgiR5IR6wRCbfXUi9+GEbMKjVVrYkq3oi6uxGzTt1OC7LtoSR/4SsCoH6jOVxYEXLDwN3EjxJq7hub/INRP2q7ztKI5C+9y2X9JSbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727836152; c=relaxed/simple;
	bh=a6muNuqouh2eDTeySEAd1onzVFurF8Em+siUXuwZKLE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGFBtEItVstX50IejlYzDGBRH1qmQ7LNEdPRaD5rSAI0Uw+aW177OQhyuKlwbZOB4VOX6mDv/ofX3avUU8fuE6jnI9UWwjpbB1SQgv1Kqj4TOoH/u/OJJUMMOc9RYZwyPmYTCHYO/KFbBaPsKdxtvXt9ut26bk95WDiRPjN22ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KVchHNls; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727836148; x=1728095348;
	bh=ac1HgfNmCk4awHc+1fYEnNOrVJgHC0ESWRjedn6k/6Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KVchHNls3XzmE1DotNEXkB7Y4XE6pwjnI1jLbRr2yZKUK50bqvuZkhg6vQ++FJyDn
	 YSPMp3qhBfm9fW+HhJzbdlL8QczyVTeBK3qyWlBSaX9aW21Pd2aVsqxfRqwLo/yKh/
	 uZ7qnD/ZxekBUhwq7/3O4LG4s8mdjqAgei0VEbMN1F6uIEGbkTgmAG3PtpY1/NTe9A
	 4VopW1akE3pwPtJNoR4JmyzFYNfvMOOYMcjh3CTfrhQyfBco7YBnkvcQp5M94fopWs
	 NpxmtT/ZoqPDF3xklMXRGNl3DCzSPsuGWM2vFXmgWDcp7idt93YgBtbzZWGtvG/j3Y
	 vMXUvxMV/GSWQ==
Date: Wed, 02 Oct 2024 02:29:03 +0000
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Patrick Miller <paddymills@proton.me>
Cc: Patrick Miller <paddymills@proton.me>, Hridesh MG <hridesh699@gmail.com>
Subject: [PATCH v5 2/2] checkpatch: warn on known non-plural rust doc headers and empty doc comments
Message-ID: <20241002022749.390836-2-paddymills@proton.me>
In-Reply-To: <20241002022749.390836-1-paddymills@proton.me>
References: <20241002022749.390836-1-paddymills@proton.me>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: 836639662c8165d02d175bd86197358680cc3c38
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------0c4394a6258ff74633d227f933c093d2dbde39163781e62af069d27088053794"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------0c4394a6258ff74633d227f933c093d2dbde39163781e62af069d27088053794
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
Cc: Patrick Miller <paddymills@proton.me>,
	Hridesh MG <hridesh699@gmail.com>
Subject: [PATCH v5 2/2] checkpatch: warn on known non-plural rust doc headers and empty doc comments
Date: Tue,  1 Oct 2024 22:27:48 -0400
Message-ID: <20241002022749.390836-2-paddymills@proton.me>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002022749.390836-1-paddymills@proton.me>
References: <20241002022749.390836-1-paddymills@proton.me>
MIME-Version: 1.0

Adds a check for documentation in rust file. Warns if certain known
documentation headers are not plural.

The rust maintainers prefer document headers to be plural. This is to
enforce consistency among the documentation as well as to protect against
errors when additions are made. For example, if the header said "Example"
because there was only 1 example, if a second example was added, making
the header plural could easily be missed and the maintainers prefer to
not have to remind people to fix their documentation.

This revision also merges Hridesh MG's [1] patch to check for consecutive
empty doc comments. This checks and warns against consecutive empty `///`
lines in rust files.

[1]: https://lore.kernel.org/rust-for-linux/CALiyAo=ZdFy0bR03NndODmE7vP_JRzxs52-z=iXKQbO_Z6rtYg@mail.gmail.com/T/#u

Signed-off-by: Patrick Miller <paddymills@proton.me>
Co-developed-by: Hridesh MG <hridesh699@gmail.com>
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Suggested-by: Trevor 
Gross <tmgross@umich.edu>
Link: https://github.com/Rust-for-Linux/linux/issues/1110
Link: https://github.com/Rust-for-Linux/linux/issues/1109

---
v1: https://lore.kernel.org/rust-for-linux/2024090628-bankable-refusal-5f20@gregkh/T/#t
v2: https://lore.kernel.org/rust-for-linux/92be0b48-cde9-4241-8ef9-7fe4d7c42466@proton.me/T/#t
  - fixed whitespace that was formatted due to editor settings 
v3: https://lore.kernel.org/rust-for-linux/da34f89c-f94c-43aa-946c-57fec3597974@proton.me/T/#t
  - move && to previous line and remove whitespace in WARN per Joe Perches
  - reformat following C coding style
v4: https://lore.kernel.org/rust-for-linux/20240914181618.837227-2-paddymills@proton.me/
  - add @fix option (credit: Joe Perches)
  - add Error to list of checked section headers
  - make check for rust file its own if statement because more rust
      checks are planned
v5:
  - merged Hridesh MG's patch[2] to check against consecutive rustdoc comments
  - revised Hridesh MG's
 patch to match against $prevrawline being new
      or existing
  - added fix to Hridesh MG's patch

[2]: https://lore.kernel.org/rust-for-linux/CALiyAo=ZdFy0bR03NndODmE7vP_JRzxs52-z=iXKQbO_Z6rtYg@mail.gmail.com/T/#m5afd633dc96ba366bbfd3d168c43d3a2a53b9198

 scripts/checkpatch.pl | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..080b0eebde0a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3900,6 +3900,26 @@ sub process {
 			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
 		}
 
+# checks for rust files
+		if ($realfile =~ /\.rs$/) {
+# check that document section headers are plural in rust files
+			if ($rawline =~ /^\+\s*\/\/\/\s+#+\s+(Example|Error|Guarantee|Invariant|Panic)\s*$/i) {
+				if (WARN("RUST_DOC_HEADER",
+				   
      "Rust doc section names should be plural\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] = s/\b$1\b/ucfirst(lc($1))/e;
+				}
+			}
+# check for consecutive empty doc comment lines
+			if ($rawline =~ /^\+\s*\/\/\/$/ && $prevrawline =~ /^\+?\s*\/\/\/$/) {
+				if (WARN("RUST_DOC_EMPTY",
+				         "avoid using consecutive empty rustdoc comments\n" . $herecurr) &&
+				    $fix) {
+					fix_delete_line($fixlinenr, $rawline);
+				}
+			}
+		}
+
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.46.2


--------0c4394a6258ff74633d227f933c093d2dbde39163781e62af069d27088053794
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmb8r+4JEJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAP3nAP936BWOr5t4BC0jSvvjuhtD37zUq77XsWU0KcvYtIr9aQEA/tEP
/bXcHcXJE9fHkCeh7OItQjelyV2jesBgngK8VAw=
=2WSD
-----END PGP SIGNATURE-----


--------0c4394a6258ff74633d227f933c093d2dbde39163781e62af069d27088053794--


