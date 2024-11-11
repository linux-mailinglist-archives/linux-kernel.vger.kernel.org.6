Return-Path: <linux-kernel+bounces-403965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE949C3D31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342341C22127
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0819C56A;
	Mon, 11 Nov 2024 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="SXU2AQDO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xf2FD8aQ"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0582218D63E;
	Mon, 11 Nov 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324418; cv=none; b=scwePdrGlZiblbukvqBohK90+GVIuS3WfdlTClIRr80/+lCBbyj/tj9p5PO6X3iFS+/mV4CAQk67uOTTmBy8vBwZqCtEfqdJH6ex17o511176sk87/YUH1LPEjokxA/TzAGE2k8pNC98zwobGixiJcxzkspf40l/FTpgHZpeBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324418; c=relaxed/simple;
	bh=58FL7pO/o2ICsLVI9Pf9dWhZeHr7aEJk3ywVQGdXZ58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuGI3g8iV8GF2CNnJpHzYNhaIuikTRys03s17apXfr9BA8OCnPNQQHhY+qpF5Yr37rAd+2+OngxWFdSyP8UfgoZBbgWuVeizMYDFEbh4D4T+q3Vu3F1onAJN1GlQ+qznqmnsXglGKN1ySB8O1SWFhIzN1c+C7u8yWc6z3I8uvso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=SXU2AQDO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xf2FD8aQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C06913805EE;
	Mon, 11 Nov 2024 06:26:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 06:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324416; x=
	1731410816; bh=o0J4L60Sq8xxKMC4EQmqGP3LlG/Y7G9sOLqiDCT9zsk=; b=S
	XU2AQDOyAQyurw5CWHo5vsPgsySLRC5UWNrZPXWIMxXamItV0jG6IHakTXB3e6XI
	4oVs1LprDSyrojTV7h/dH52saZpsHKKG5fMr6yl4vFaDu8dZW/I0C3iv462FQmhR
	8pfk0ZfHq6NFW/bgy9FdFL21OApvrnuRQKrxC8IIpPPWd86XN+uAYhTbHiFlxZSy
	l4lsPl4WplKFe43lpELTOs0PPWnX7Q0nGQLPWtsmAsDqoUMJKZH2lfTq+nVZZ1Tq
	0uVL/phWBAPSF2CI3hkgQqVrbadMVIt4pObGsYKRU3i4acwya4QaB86kfSyfRsK6
	9BVgBBXt8oUP50tXZ/cgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324416; x=1731410816; bh=o
	0J4L60Sq8xxKMC4EQmqGP3LlG/Y7G9sOLqiDCT9zsk=; b=Xf2FD8aQ2Wi2jH61j
	jMNkMyF+AS7AYI9TM0CP2zQdnmjkBr36YaQmQ+FrRK1CSdGWWsNJJcNDg8Etz4fP
	SGizApg9K1Z88nAwXbwJ8e3UHZQsnmhufIJptAf2rFP/DQ4K14BV/YwZZu7fvrI+
	Abznunan71ygsPId8cM5+0xYB39iRm+enhtYgtjYmJAf7Dp+/BX4sRXQ7aV7hnx8
	sNQMfChRTwhbSB9fOtN2VFMTQOSR8OtEf4aHlg6hZk/Y1Jbv6l0SMkkHFyjQ8cRi
	rNAeOgMikLN6S5dkqlaS8lyWG0bWhiwGv8LQjyP0wE1Yh7/88Jx5un1o3ohMNqmE
	h1/jw==
X-ME-Sender: <xms:_-kxZyBqVQLgpbUzYkQxLrMjlYPOKrLGNqPTb5I6XCM1wyl_jwHSsg>
    <xme:_-kxZ8gLLZng4RXMDvo3OTfkdlkDW-STUv7qK7UA_k2fYycC1ev0nYU4WcctNvnkk
    j4yARTFXVKRhA-syDc>
X-ME-Received: <xmr:_-kxZ1kMhPShaV9zje3i7gIbAwJYumpX6N2YkmSxO97PCpgLpRXiHzgHhLTkk_Xj0cdNiMm60YLN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehtmhhgrhhoshhssehumhhitg
    hhrdgvughupdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_-kxZwykQJSbCXi3NjrDSzlEmRw1hTufMKBC0uvgTgsn5CyGxatEeQ>
    <xmx:_-kxZ3RlPBIG_kmVxfekhvY6lH_lk52E2XrZh5DYPfP4E80zz-rJkQ>
    <xmx:_-kxZ7YGtKbYd14d5-OSaDpk8Kl0YcxmvkiaZkT-o8hmCPWg2JxMmA>
    <xmx:_-kxZwTxEy8tmUm0NojcKo5Cq9beYOZHfrpFirLciO2g1gYY0QxRFg>
    <xmx:AOoxZ4igEJRgHNLjRtuFSr3TSeckBzg49hMwBTIfmUyImGDHtVHaOzA4>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:26:51 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	aliceryhl@google.com,
	gary@garyguo.net,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	alex.gaynor@gmail.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 07/11] rust: helpers: Remove some refcount helpers
Date: Mon, 11 Nov 2024 21:26:11 +1000
Message-ID: <20241111112615.179133-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111112615.179133-1-alistair@alistair23.me>
References: <20241111112615.179133-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
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


