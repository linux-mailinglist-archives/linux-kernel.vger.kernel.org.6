Return-Path: <linux-kernel+bounces-423030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11C9DA190
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80943B250BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C298913D882;
	Wed, 27 Nov 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQDVY0fI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7A13C9D9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732682867; cv=none; b=nuRHMjrJzoFUWeSzm5tMiXpr/JeLaBbTMEYQDM1t472fWxryoIR3frEFNBR9Gz/AcdmLZxfLQHemMCEQL2U9obwGrHwCUxCI8t7w4Tc+frn0ZhzbnkCvf94H/bdlw6h+usW88yhFC1k9W0yXZs96lkrR7hFdT9EFEyAw/OuoZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732682867; c=relaxed/simple;
	bh=V7BtTSq2q3ni0D0tak7aDYXcHjl/SVb7F9S3WE0i7cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTX9liDpQ4qFZ+azBC+RBiB1qn5dAjxifWAGpr2QK/Epk77Urbvr7Nl6Z9qJSt+ysK2dFTv5kOLQDf4yBJNuTHGt+u6yq5/InUYXM5ouzrwdYUWfjDZXt1GyBxvpULoQoiQsQedxOq3X3H/98zWYONldRznOyNRbdXW+TYg9Xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQDVY0fI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C38FC4CED9;
	Wed, 27 Nov 2024 04:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732682866;
	bh=V7BtTSq2q3ni0D0tak7aDYXcHjl/SVb7F9S3WE0i7cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQDVY0fILkQWq0WHZTP8NHvLmV7vAjohbjhsqAdIb7v+ZYWR+dQs2HaVClFVU1uuH
	 epT2Asm0km+777OVb/pTUtwfX8nRruLtu3OyoN+E1gtgzgwMGSpKEfBS7TQB41cFzL
	 0gRzUoWv+FN5uyEYFH/ZhzVaPTn2VywGmTWar8TwZrAtgK0W41gcoWneKeBmMXgF/L
	 LjOySdCv6mMtP4rN5zaATQVmmR6suhCAZmwraTRJedwAIMpPFfr/LPSxPL7cHtUGKM
	 Z98UUsZdlyzTY7Y6O24wE96ja4AcdCRGYqevYNW1gbQWHIv1bW3++l5Jl3KTdTAeMf
	 PXOvnGFsMtWwA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 2/3] static_call: Add read-only-after-init static calls
Date: Tue, 26 Nov 2024 20:47:41 -0800
Message-ID: <069be22d3643046173edbbe110218a9fd28a2e55.1732682344.git.jpoimboe@kernel.org>
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

If a noinstr static call only needs to be patched during boot, its key
can be made ro-after-init to ensure it will never be patched at runtime.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/static_call.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 141e6b176a1b..34970e178fdf 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -190,6 +190,14 @@ extern long __static_call_return0(void);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
+#define DEFINE_STATIC_CALL_RO(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
+		.func = _func,						\
+		.type = 1,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -198,6 +206,14 @@ extern long __static_call_return0(void);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
+#define DEFINE_STATIC_CALL_NULL_RO(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
+		.func = NULL,						\
+		.type = 1,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-- 
2.47.0


