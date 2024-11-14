Return-Path: <linux-kernel+bounces-408506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B653D9C7F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75731284405
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D04F28E0F;
	Thu, 14 Nov 2024 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="KNfF2aPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIwNqYX3"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755282488;
	Thu, 14 Nov 2024 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545853; cv=none; b=ScxCTqvcLDRUDVUE3PLVkLiZo/A+7RcWpq8hzgd35jIgn09hk3ns/5k+d6xwnI4M8JY6QToqLr2EzNDU7UbA7QaEQ+my/u2VThxygnD1pooVS23P9/uCkzZQjezAGwmRByeUzmXaqGi/w+2YpaaGoKT/u0VdPolUobghHv1NgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545853; c=relaxed/simple;
	bh=jjfm8JYmC2I9nJYRBvn8sy2FkQjaxe2N72DR2frCwl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQngAkL6Is7ZF1T1pQe0j6cQDzL2lazuAL88HhWQfOluhAhBN4Ubds7exMr3NhPhHd4xIr3QB49btwA5OKR9G0nzDXWEYIVBKk2PhrVceX9ZBAGK20IsSLZlu1vhhuk+hYO3u5lrwPDddGA2Km5JkoPkwPZ0+E8P2gG8/A+l7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=KNfF2aPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIwNqYX3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E6BC11401FE;
	Wed, 13 Nov 2024 19:57:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 13 Nov 2024 19:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545850; x=
	1731632250; bh=jd0+lguZJuYa2lTmU37tGJeQL8Ao2i0Sy/ndm1dnMtc=; b=K
	NfF2aPzfSGya6F99fiwI6CnJecEoLR50IiogLDVjA6pINOWoQ2iXgZur7HYhM5nL
	1TllAunMUZjNR2uOMuLdqsndEyn+bpHmNS5NlWb6GVwEf0gZhsed4vDoyjChk8+p
	z+RWQKRkqclIdCc4lvrRUjRnp2yNeZT97Fr1o2Vg56klCb9p5RhLKUVz7EaCSoA9
	W2II9gU7ue2LQ+Ay1RsZghvc/RBxu7yUPuWpcfNCcv9BmlyJY/hfk/4mFihPJAKm
	6Fo9xylOm0AtbLbTvIvqxnDOzSz++aId5LBawEmYpOD+O4LhJ9gaWuYJ2jllyB+z
	5DAonkbv+Y4UuQIWKRnbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545850; x=1731632250; bh=j
	d0+lguZJuYa2lTmU37tGJeQL8Ao2i0Sy/ndm1dnMtc=; b=nIwNqYX3jBi0TFtsN
	QGsIRIrYMKwnpTsfT7edtq817uyG35a30KZx860OSt48D2soZSrgoPSU1luQ0ZsP
	sA+5MxAeY2vvO7/OXaPJB4sO8M35wT6uhN42KJtwZW3C0xOC2ethmukiY7DyYzgC
	nCJ2CObkrenaxDbgo5Wn7hTX42fFFVIFcN9ajJpXzd4DIEPDrr+bQJFllNpogx7s
	xIlara1VMhBvh5Yx9m9Asmqzg46UHHfXD0Bg9NMxUdBQ18+Qv2HUJXnB01aKrr/2
	ieawxycHNTvQwHmJVFm42IQCMtplmN85BENxE+sxYLDSNkMrd67zvdlZl/i3LxNw
	vTfgg==
X-ME-Sender: <xms:-ko1Z-aR2S7BegHEwXCZbzxQ9SvNfhHOGLilwVKp5LvXYWutwXx_1g>
    <xme:-ko1ZxbftacWTK8j1U4zPBmQdZVAtxmufgMObZMvCvQud-uTulIepYMCtl61Hhrpa
    PKRs9cGWDSlsaPKi5I>
X-ME-Received: <xmr:-ko1Z48YhoIHVSEZS7ET9jlDAhdSHcjjRgsje3SBLx7GD4ngcMf7lssRP6NQZHkzNvVMo1tyZvD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekteelvdelveevueeu
    jeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgvrhfuihiivgepud
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
X-ME-Proxy: <xmx:-ko1Zwpb4Pdjya7CagwmY4BQ3D4oR8F31yvjJNbOvZN_QVoftirO-A>
    <xmx:-ko1Z5qDzfFWeauf3P4fC7dKOmFfQ9DFnwaKdgZyKCkSZ2MUiJxMUw>
    <xmx:-ko1Z-QAnPcvshG-Xzug0XSnDM_pOSAbX6y68oJPjavB_iiV_NetLA>
    <xmx:-ko1Z5rKBpPNCv_TXRfevdCWYS_9oNm_rf4w32rHj6MAqwRoLneRWw>
    <xmx:-ko1Z_aQ_UTRYFO1afXLRxiOcWi03f7VtnrFwFIXN7gpwYRzsUZxMNz2>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:57:25 -0500 (EST)
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
Subject: [PATCH v4 09/11] rust: helpers: Remove some spinlock helpers
Date: Thu, 14 Nov 2024 10:56:29 +1000
Message-ID: <20241114005631.818440-10-alistair@alistair23.me>
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
 rust/bindgen_static_functions |  4 ++++
 rust/helpers/spinlock.c       | 15 ---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 407dd091ddec..9d6c44e277b5 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -20,3 +20,7 @@
 --allowlist-function refcount_dec_and_test
 
 --allowlist-function signal_pending
+
+--allowlist-function spin_lock
+--allowlist-function spin_unlock
+--allowlist-function spin_trylock
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index b7b0945e8b3c..1c47608c42ed 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -11,18 +11,3 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 	spin_lock_init(lock);
 #endif
 }
-
-void rust_helper_spin_lock(spinlock_t *lock)
-{
-	spin_lock(lock);
-}
-
-void rust_helper_spin_unlock(spinlock_t *lock)
-{
-	spin_unlock(lock);
-}
-
-int rust_helper_spin_trylock(spinlock_t *lock)
-{
-	return spin_trylock(lock);
-}
-- 
2.47.0


