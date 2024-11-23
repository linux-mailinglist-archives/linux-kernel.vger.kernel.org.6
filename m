Return-Path: <linux-kernel+bounces-418908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90FC9D6717
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3418D28221C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D4E7DA87;
	Sat, 23 Nov 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6pXtRLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B188A59
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732326749; cv=none; b=oXoI+aLypsDZ3hsQo3I1uswCvkz6jbpiv3EdL5zS+XP9mwxiDWsQHNjLq+OnYIk8+pRMdkiMEkgXl08GFt9ldd3vNHP4Cch5B99DzVMtfIeImkY5HjijFqeV8XN06/xkmUG9qmoNa5fMCOouNOJvpk69Gk6rCGMC/gdrg/Rf7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732326749; c=relaxed/simple;
	bh=Z8mLV1I0i65fQMKFNNuFW+i16/5RGdQifigv/kT1a0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnNz/dEfIH67w8qvLZGlMT1ezw4twjPUCzmv3cNi5UM1XCWMMhd7HcdS4+au3I3JwMdFRApiK6zQ0teLqjvjhqKM2XcrSzxsAw1HEcpCDwteUEs2Y4rd/wpOLg2PU/Kx+bSqVi9YNQnJXs/gyvemU+DvafPtMYlHHYj5igCYxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6pXtRLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1441C4CED3;
	Sat, 23 Nov 2024 01:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732326748;
	bh=Z8mLV1I0i65fQMKFNNuFW+i16/5RGdQifigv/kT1a0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6pXtRLYMs8w0v15Y8qYFC8ffbLVEWrnOeEtND+RbYVCF4HhScp1S0w7BhrH9fH6/
	 9bbDpmDgGr/MH5wuactdA5ayW1AgGUOvZmWVWyio0/SKReauPE1/pVIeWWG9D2/cPl
	 2rSbYqnoGO4Ln5hpNIa46ONoq2B3QrpcCvyolb7HERxelrWCElFALDRv9ewBz9a4+y
	 7AipK8CaRH4Kk+Nk8Lv9F4RaLRswpt3CNbvn6bx8Pt6OQug/zMJQlH9MjP8omwoMQF
	 FmeufdR3S2c9NDt3EBut9dTF3rTFib8tgRLpO9ExamesuKGRgJ3TtLvyTt6s6a+Eww
	 5WMZSyjzgmGGw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] jump_label: Add annotations for validating noinstr usage
Date: Fri, 22 Nov 2024 17:52:20 -0800
Message-ID: <f9d71d6c6f87b6ea88b904f328595b7663e6a6d2.1732326588.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732326588.git.jpoimboe@kernel.org>
References: <cover.1732326588.git.jpoimboe@kernel.org>
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


