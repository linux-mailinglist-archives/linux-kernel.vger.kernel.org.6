Return-Path: <linux-kernel+bounces-403968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC0A9C3D34
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF636284531
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C5619D083;
	Mon, 11 Nov 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="QoiWDhaA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HM71lfDw"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322319D089;
	Mon, 11 Nov 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324432; cv=none; b=coH/p3SO+PZcF8qxi1z7bkuv4eLIar6rmNQ5Rt+VEusdM2aOY2rA3u6eIOm/v0Id89osok8JzYmsXQ2WHauxF/WFhJFz7dE3JcqdhYfnPCmApd1peisvWRq7NQGFYTTtY2BYgOhCVJyq3QCbmFcvuF8G143B0XzBerE9zaG9Qiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324432; c=relaxed/simple;
	bh=R65aQHF8S29WYMZTDd0AF6M7wAHphSEKHYPhQqNa1/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCnNHAh9RKodZq8yGntSj8cbThdLLtTdkl2cTxskYdA8oJKnBV4Gb/cK95bqR5KWlCO9A+0H/RTcgfLByijHiEcmEVDJSCoEOFsKPpawkUj9TXwDhg3K4VIPn9HvaK7fvFr56JNWiaZsDVeIiwhQDVD3PTKRZz8Cb4XK15Be6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=QoiWDhaA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HM71lfDw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 727751140169;
	Mon, 11 Nov 2024 06:27:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 11 Nov 2024 06:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324430; x=
	1731410830; bh=es18TvJLVSKmeYC1eMKi2tSXwgG+M8AS6GTeeBImdmU=; b=Q
	oiWDhaAdtTGzatl6CpNNHmfFIxcsU9IBbZIascgnGjgxhmPdK7K+u5Y9aRFmhqc/
	EyUHkEM7apkKMWZVNZT7HG7JuId+XMbaEt/dzKLaqga1UDJsQ40Pob/dFzjABpAH
	ojMHNAHirSSNQMwSe7P6vXWP8PA4eP7dS0uRLBqlK2NmeopXtzhlcWYVi33q6QUb
	9FozQn1eyz6YgbFSD14vh5fcM2xbJMmQPaIvUMVvmn1Mk3hcL3Kmnk/HYNjbeB0/
	WsdYf4L55mzNRzLTI9Wr3+PhUphYte8LL/UC6SNbSxIAgEMSqj836Nx3WtynNyiQ
	reqtjPMabRVQ74ZL2gtow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324430; x=1731410830; bh=e
	s18TvJLVSKmeYC1eMKi2tSXwgG+M8AS6GTeeBImdmU=; b=HM71lfDwyyexVwRKq
	QCSacHn4ImNm3vo7rRTm0RKKifYAIQQjIkija9+M5Ze70QNArX7htZhbiN3TIt2P
	kxxCo7t5sTVP+nLqDkv/6SvZaqeesnBlulRldoCs/PcORvK7W2GNwrJj/rr3xrwd
	KveX8+DK5L0q++IetkCQhHpdLHAPLGpQdgNRADIqS6IgmQUUpEUEz0uIi2KYVcVk
	hfu38b+NKfIvJeSWSMg1miHJuBS9hImoGpXYwb4QEX1kTx++1x46cIddRE+IWUkl
	2EEHCIYkYrGrCzJzhicqh7G2RRNtb/Emz58mzKXvk3InYcsKY9WoykhCGOiNhRoF
	murrQ==
X-ME-Sender: <xms:DuoxZwFWjQElNr_bqYCGVbSo34ADYloeNN00VL8nzHsYR-4ZPiMBYQ>
    <xme:DuoxZ5WgVBOSUgDFfs6ZJEWOQquPzpDDH2NnDA2QtD7zSbmd4YavLDsleDau5R9EU
    gHaCi8A6X_CAfl-nMY>
X-ME-Received: <xmr:DuoxZ6KVCnrGq8ucAxX7XVcoLZuMtX97SA3PeH313ScTt2QUmZuTMRKix7sPtszLioelIDTf9KCN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehtmhhgrhhoshhssehumhhitg
    hhrdgvughupdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DuoxZyGuLCswKDZrdZyuYGVDtsBZzCPgz67ViEwLR7i9MYtRcv5A8g>
    <xmx:DuoxZ2WOJ-dvwO9kf0BGW3ODzZ1gyaYHx-ULvoZMKRnDnWoPihbZxQ>
    <xmx:DuoxZ1P7yFEYlWYEIAXo2ieK63dtZNLSGUdhnMcX8OzAgv354X9zlw>
    <xmx:DuoxZ90lgYGbHIXJV1cc1jvisPPwRnJ4Zl0YNEsZ0y7NANPXGIbPGQ>
    <xmx:DuoxZymA7z9XGNtx8895NCJt9s10mbLSubZdMmzhGwW4FnwlgsRddCwF>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:27:05 -0500 (EST)
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
Subject: [PATCH v3 10/11] rust: helpers: Remove some task helpers
Date: Mon, 11 Nov 2024 21:26:14 +1000
Message-ID: <20241111112615.179133-11-alistair@alistair23.me>
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
 rust/bindgen_static_functions   |  3 +++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/task.c             | 10 ----------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 9d6c44e277b5..8bc291a7a799 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -24,3 +24,6 @@
 --allowlist-function spin_lock
 --allowlist-function spin_unlock
 --allowlist-function spin_trylock
+
+--allowlist-function get_task_struct
+--allowlist-function put_task_struct
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e21a5f260e3c..63b78a833303 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -22,6 +22,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index 190fdb2c8e2f..788865464134 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -6,13 +6,3 @@ struct task_struct *rust_helper_get_current(void)
 {
 	return current;
 }
-
-void rust_helper_get_task_struct(struct task_struct *t)
-{
-	get_task_struct(t);
-}
-
-void rust_helper_put_task_struct(struct task_struct *t)
-{
-	put_task_struct(t);
-}
-- 
2.47.0


