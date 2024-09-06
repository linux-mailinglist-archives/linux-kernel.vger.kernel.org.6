Return-Path: <linux-kernel+bounces-319231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEDD96F987
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8EA1C21B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A31D365C;
	Fri,  6 Sep 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RKh8s4SH"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143E49620;
	Fri,  6 Sep 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641159; cv=none; b=VvErT/6NIJMiizqFMw+6a25yhhbMvF/I0SIDbo9olZTNjtEMsjVGhNO+bt+IVtDl4wZaQizKxtc/8//JbC1mkKprevyT9AUv3B1yreaZ98WJd5R3zWhai2wnKkkKFXvBVguLMxI44lrJCwCx6oaHsZ1G6Jy4iExErarHBwu5vPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641159; c=relaxed/simple;
	bh=Q0TI8eNUcc2ITbUPrGjL/io31BBt+cZ1OD4D3jLg1yo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ofL9ElkLnKky8fWrACzJHr1yLBh+IWhcUXrX/aohkWXqBkdD4tfMZyFiGaL7BszNVo3DUtHxYxUqxn1g73aZnqaYeLpkp3YkpzDI4mc/lABrRK/tzJ6UiwyanSx+DXmxn+Gu1eEl1Mn+aiTotAwp5+Ne+f+khax7ADo6iu0IhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RKh8s4SH; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725641155; x=1725900355;
	bh=W5eGXVreA8taGNehSOoVIcszezqdCX9H14vgT1GVY4I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RKh8s4SHudjYYFUsLvw826gICytoFkT7BJm6R07OQLcQBpeYHA4ITAGihMUb2/lAE
	 WkJij/nrZgj5YmqopSE5jWqn5dYOnEn8eKsecnjPK0RVfs48D5jL/2CMIyD2Fkz7ZM
	 mc1bhYCj47tVbAO1en0t5WfrgfG8vWyJV2Uba+HwWDe+avSFHdmCbYjtu+4M0CL+DZ
	 uasVDjfQRnHxPdjWHqnInAOKikVXdnWBX13e+chWnhsOB43YVSB020jV4yUki5qnlu
	 yt/JQSaOsKQDRuwshZY/S4lXmu6ZMmrthDgpP2KGtMSSScNUkV9bMTi+4xI3lPatz8
	 H+Zulrj3SafQQ==
Date: Fri, 06 Sep 2024 16:45:49 +0000
To: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net, joe@perches.com, linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
From: Patrick Miller <paddymills@proton.me>
Cc: Patrick Miller <paddymills@proton.me>
Subject: [PATCH 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <20240906164543.2268973-1-paddymills@proton.me>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: 8a3f6e0dbd20e1883cf7e4be85ea260019a3bc8a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------d3a9539b36a28e4e0770d6c8a60593c78a8ace430973b74f0bb0b8aced7d0732"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------d3a9539b36a28e4e0770d6c8a60593c78a8ace430973b74f0bb0b8aced7d0732
Content-Type: multipart/mixed;
 boundary=8d9aacc8f1d60e0a24550943c3647a61efc76ccebfe4d9c7fb2a3c8eecc4
From: Patrick Miller <paddymills@proton.me>
To: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dwaipayanray1@gmail.com,
	gary@garyguo.net,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	wedsonaf@gmail.com
Cc: Patrick Miller <paddymills@proton.me>
Subject: [PATCH 2/2] checkpatch: warn on known non-plural rust doc headers
Date: Fri,  6 Sep 2024 12:45:43 -0400
Message-ID: <20240906164543.2268973-1-paddymills@proton.me>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0

--8d9aacc8f1d60e0a24550943c3647a61efc76ccebfe4d9c7fb2a3c8eecc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adds a check for documentation in rust file. Warns if certain known
documentation headers are not plural.

Signed-off-by: Patrick Miller <paddymills@proton.me>
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1110

---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..0e99d11eeb04 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3900,6 +3900,14 @@ sub process {
 			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
 		}
 
+# check that document section headers are plural in rust files
+        if (   $realfile =~ /\.rs$/
+            && $rawline =~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant)\s*$/ )
+        {
+            WARN( "RUST_DOC_HEADER",
+                "Rust doc he
aders should be plural\n" . $herecurr );
+        }
+
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.46.0


--8d9aacc8f1d60e0a24550943c3647a61efc76ccebfe4d9c7fb2a3c8eecc4
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - paddymills@proton.me
 - 0xDCA74891.asc"; name="publickey - paddymills@proton.me - 0xDCA74891.asc"
Content-Type: application/pgp-keys; filename="publickey -
 paddymills@proton.me - 0xDCA74891.asc"; name="publickey -
 paddymills@proton.me - 0xDCA74891.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuNy40Cgp4ak1FWWs0UnNSWUpLd1lCQkFIYVJ3
OEJBUWRBU1FhVy9FUmQ4dGZncXNNSHQweTY3ZFdRTEU3UnV2T3gzanphCmdhRWI0c0xOSzNCaFpH
UjViV2xzYkhOQWNISnZkRzl1TG0xbElEeHdZV1JrZVcxcGJHeHpRSEJ5YjNSdmJpNXQKWlQ3Q2p3
UVFGZ29BSUFVQ1lrNFJzUVlMQ1FjSUF3SUVGUWdLQWdRV0FnRUFBaGtCQWhzREFoNEJBQ0VKRUp0
UgpHcnN1cjU0UkZpRUUzS2RJa1N2VW5DdmU4MDFtbTFFYXV5NnZuaEZpcUFFQXQwVCtwZ3AwUm9X
d0lmbURQRlRuCjNsbVRRcVA0dUEreDRnNXB2OG5SSHBJQS8xVU1YLzh3akZlK24wZUM0V0pqeTRu
NS9OZUtxMXovOFBKdFlhdXMKZVZnT3pqZ0VZazRSc1JJS0t3WUJCQUdYVlFFRkFRRUhRRi9mTnBE
ZmxsRFJuSEhyZUh2VHRJdEZ3dURMM0taQQphaDhZd3dxV0FyNFJBd0VJQjhKNEJCZ1dDQUFKQlFK
aVRoR3hBaHNNQUNFSkVKdFJHcnN1cjU0UkZpRUUzS2RJCmtTdlVuQ3ZlODAxbW0xRWF1eTZ2bmhH
R2Z3RUFuWkFzR3BvTDdRaTlWQ05PcGNrcjB2OE41S3hic2xJTGZlUCsKMmNJU0hlY0Erd1RxWDNs
Z3dnNVJDN1lBT1MvUTBDc3EwY2tPSTBKbnNMS1VaU3I4TlJvQgo9VzE4bgotLS0tLUVORCBQR1Ag
UFVCTElDIEtFWSBCTE9DSy0tLS0t
--8d9aacc8f1d60e0a24550943c3647a61efc76ccebfe4d9c7fb2a3c8eecc4--

--------d3a9539b36a28e4e0770d6c8a60593c78a8ace430973b74f0bb0b8aced7d0732
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmbbMb0JEJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAPhQAQDlbR/xcOP2IQhEcEkJsqM7Ld4hmqS1+AkKESAjXhJi8gD/WzXR
DYQTZpJCTDJ8mP4SKdJDtBvzwQOcdJHv6I7y5QU=
=obod
-----END PGP SIGNATURE-----


--------d3a9539b36a28e4e0770d6c8a60593c78a8ace430973b74f0bb0b8aced7d0732--


