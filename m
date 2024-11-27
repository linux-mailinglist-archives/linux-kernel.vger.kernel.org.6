Return-Path: <linux-kernel+bounces-423029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2968C9DA18F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B85C168352
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09413D278;
	Wed, 27 Nov 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPilOLCU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6913AA3F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732682867; cv=none; b=KsKmdursKxY8OKT5zHAHMgw2WUk9de41GbZyXGlPjGZIQIjB9dkSeIlJ3AyNfIrSSWkhV23H4Dh3odj7j51LpmmFJ3gGrNRiiM+1lDug1/rLWSJtHqnXLdfGP0PfYPyJYT8ex9ch5UCT9nx+v/hQsSxD2BIEkW/Cvs1hF5dzAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732682867; c=relaxed/simple;
	bh=Z8mLV1I0i65fQMKFNNuFW+i16/5RGdQifigv/kT1a0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQcFdIkHduoNCU9zWNEEXIHa1Cb1poyRGHzAJHPDQWnnEAddUuadTksPrLxOcHr991wcyuxWjgz2kjw5K5it8tSe0pz3yn/l0jBKnnyn9EjqUF9tdOUZB8V0VfMgAmkte6DFJ969PJ3o3ioODbzUODeEaf7aPu52BqSCYHzJ0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPilOLCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CEAC4CED2;
	Wed, 27 Nov 2024 04:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732682866;
	bh=Z8mLV1I0i65fQMKFNNuFW+i16/5RGdQifigv/kT1a0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPilOLCUp1s842UPNiJlXTBRjr+FzyRxgyrFXrp9Mt7luwWR4mViZ14mILwrbY16v
	 aESyuRe6eqDtNYKV0BJKbmhdVEG8RyjqBLEiV987aRBLGB6EOYJ4qcDD1a9UlIdUyQ
	 fFEFDUFYLrt4lBbgpX1Dh2AfME6PF2pKmkWgrO9trKTD0sOGMtIvsI81ROGfWxz5Be
	 2fEZBhmxh17dOeB0vsArLZxYDyNkwATzfTKdAzRQENKOVphbx5mMWRo7pSHmMwPVMx
	 nhS/8nGDzgLk+EpbSwL+ufK8HKH9R0cSmnumMD5FatmIgrgir9DH/6Pq/ZSXSYe32F
	 Q2s4PSrewYVOw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/3] jump_label: Add annotations for validating noinstr usage
Date: Tue, 26 Nov 2024 20:47:40 -0800
Message-ID: <f9d71d6c6f87b6ea88b904f328595b7663e6a6d2.1732682344.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732682344.git.jpoimboe@kernel.org>
References: <cover.1732682344.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deferring a code patching IPI is unsafe if the patched code is in a
noinstr region.  In that case the text poke code must trigger an
immediate IPI to all CPUs, which can rudely interrupt an isolated NO_HZ
CPU running in userspace.

Some noinstr static branches may really need to be patched at runtime,
despite the resulting disruption.  Add DEFINE_STATIC_KEY_*_NOINSTR()
variants for those.  They don't do anything special yet; that will come
later.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/jump_label.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index f5a2727ca4a9..88bb6e32fdcb 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -385,6 +385,23 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_FALSE_RO(name)	\
 	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT
 
+/*
+ * The _NOINSTR variants are used to tell objtool the static key is allowed to
+ * be used in noinstr code.
+ *
+ * They should almost never be used, as they prevent code patching IPIs from
+ * being deferred, which can be problematic for isolated NOHZ_FULL CPUs running
+ * in pure userspace.
+ *
+ * If using one of these _NOINSTR variants, please add a comment above the
+ * definition with the rationale.
+ */
+#define DEFINE_STATIC_KEY_TRUE_NOINSTR(name)					\
+	DEFINE_STATIC_KEY_TRUE(name)
+
+#define DEFINE_STATIC_KEY_FALSE_NOINSTR(name)					\
+	DEFINE_STATIC_KEY_FALSE(name)
+
 #define DECLARE_STATIC_KEY_FALSE(name)	\
 	extern struct static_key_false name
 
-- 
2.47.0


