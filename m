Return-Path: <linux-kernel+bounces-408504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E759C7F99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5445A2843EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92DB71750;
	Thu, 14 Nov 2024 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="I3PrvCUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QnlzPPsO"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF296F2F3;
	Thu, 14 Nov 2024 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545843; cv=none; b=c3srrOFkyDwf7vKnm0z0Xp5RZA1PwH49j+TOwxW/66G9UeMQCxh8M+QYbhX7rtWzOTViWIYJMHH0La5NE+VzLJvqaMAFwbHqfncNe7XT9ks5liEZW1dMXSRgC3CK9lKi1hQStk8NJXgjAwNaFQitC33uZXq8aTX4cYew5bHy/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545843; c=relaxed/simple;
	bh=9u/Y9xRFEB9gelgdOptWLSVcjsjDsrc48AYyYZp4ReM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbLBfS62hoJovx5jHsGFotIx9eb551y9yESU01BZkGcsl4oiEbATV2r+wQXsNNvOX0jdd/8LQYoWpuBqzyybJIkc4bI9sMJd4MNwpin3C84zn1Ko1Z1qO41SgNrq+iOY5+0an71wpa5jZisafpq0zuACLGSYq2p2+W4XHJ3JqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=I3PrvCUh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QnlzPPsO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 66BE1114021A;
	Wed, 13 Nov 2024 19:57:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 13 Nov 2024 19:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545839; x=
	1731632239; bh=mOGJ14rZcyKsHL1uCIepHrlEZTpF9vGzxYwzQBdCEVE=; b=I
	3PrvCUh+1JMtdF9n1350cEH6L6rLSXMlXdudEmuESGEecIcmsvd7Nr5RXa45r2NL
	Grpawiy/83kFdu0tHNDAm1q26df66Qgne3Nt/DNDJd1UcSUq5O1HncMKPEADQONB
	ksSA96SWeAgIqeBCYgXkV+rrNPWO2LNc+3X7KKy3Y9cP35BfCzhP8dj2zBvQUytm
	S1Qoc6z8O+eEZUygHppdD9bL6ZM336M4+oej061q7JXp9/LIH5I+YhaBhJ9thUZK
	nMmzeWkGyxCSD4NYV3DvEmlhdXZyXn+ZJgVagFsElhQBs+1ePEYeMYRVciKmZdIX
	L4kvSCWlBtLMITsQ6nalw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545839; x=1731632239; bh=m
	OGJ14rZcyKsHL1uCIepHrlEZTpF9vGzxYwzQBdCEVE=; b=QnlzPPsO6s4m1cwMR
	Zh0EmUpFtGwAPOaqyiaGdPt1Y8YhNuT/Bl5pvXTBmgOcXpk7KAnGDlzMAVhzSo2/
	CcpHgfCmFRykuvNw2Tk44h43HXr2zzyUJfNAUZwF+mR/xgE9y4laEMPCHnJkV5RD
	o1fUxYkEksUaom1POCm6aLL/CiOSG6SaAVTWuDComt3ro+e0e5cuf2T2p7ijj/Rh
	vTx6BCFUq0GV1qopY/fRlen7csvVEQxzU8V22Gtjidww/A1rWPgvFW3+19XL2t6q
	IJGmDDoa+jI8SYaA/vn/g4Rg75VAsnVyyOAQvNuCM3b6sJj8E2ya1+aTc2St9NKT
	CPhwQ==
X-ME-Sender: <xms:7ko1Z8zQn3Tw3EtKdq252nzTmo9AFgW-Ath5s2hKBBezmWgg1rqzHQ>
    <xme:7ko1ZwRLqel2KtWAsG0jAa9_JWCrP6yCEGmss9o8cHF5ruA8Q7_-dWKm2fHkUKzqQ
    EWb6rg6WmiAUZoRe7U>
X-ME-Received: <xmr:7ko1Z-Xgii1rXd8Pbwg-uyciIT-AZO5HpRQbM4Pt-HXaFXj4sKjEFEnsOnEAwtjYydUfHvmdL5-l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekteelvdelveevueeu
    jeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdv
    fedrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsg
    hoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehklhhovghn
    khdruggvvhdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishes
    figutgdrtghomh
X-ME-Proxy: <xmx:7ko1Z6jrLli-2U3Btdgi2Puvh0FGsFD2IV3MKsU-Lp14tZrwu9iT-Q>
    <xmx:70o1Z-AK19751QaQPh29E1jGP5nBTsrOAMsNS--x-BOHRbvyo7A1Hg>
    <xmx:70o1Z7J9u9ygwZjtOQ-pjRwtaXJ7MV67bWI9oP_l7a068Al7s9lwNA>
    <xmx:70o1Z1ACeB0NuONpwCPnAnpmSpA8PV_bz0clT_ERutF_6nBIkPdDkg>
    <xmx:70o1Z4w_OCbZNN0d6b48uLugLlN90QpF3fNYYs0L7ZhbLDDif-fr-fv2>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:57:14 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	me@kloenk.dev,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v4 07/11] rust: helpers: Remove some refcount helpers
Date: Thu, 14 Nov 2024 10:56:27 +1000
Message-ID: <20241114005631.818440-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114005631.818440-1-alistair@alistair23.me>
References: <20241114005631.818440-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 rust/bindgen_static_functions |  3 +++
 rust/helpers/refcount.c       | 10 ----------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index e464dc1f5682..9c40a867a64d 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -15,3 +15,6 @@
 --allowlist-function kmap_local_page
 
 --allowlist-function rb_link_node
+
+--allowlist-function refcount_inc
+--allowlist-function refcount_dec_and_test
diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index d6adbd2e45a1..ed13236246d8 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -6,13 +6,3 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
 }
-
-void rust_helper_refcount_inc(refcount_t *r)
-{
-	refcount_inc(r);
-}
-
-bool rust_helper_refcount_dec_and_test(refcount_t *r)
-{
-	return refcount_dec_and_test(r);
-}
-- 
2.47.0


