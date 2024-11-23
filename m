Return-Path: <linux-kernel+bounces-418910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008E9D6719
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C644B2822C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BFE15C144;
	Sat, 23 Nov 2024 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1CeStiI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2741C65
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732326749; cv=none; b=RmvupXK9JJTq4EVobbw0eTKAcV/3TULlR8kvxRfN71R6sIKZKmMIsoLFZHNwZJQvsX96J6HAM5pfGMnp5UD/CBBCcd17VlxXkg6A/gvhp3D6O2QLAkv3EjAOqRkXNluvyttkf3tvsDxwcZtyGhyIysDDD3++QxaPzKBYTh6SPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732326749; c=relaxed/simple;
	bh=V7BtTSq2q3ni0D0tak7aDYXcHjl/SVb7F9S3WE0i7cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft5thIYugKidw46ConheDKGlQfd4GYbdulBuDAUcyQYKlHpUCLyGIBfhpqIEEZSwbDgltz8Cu49oX/0ZS/bCIJJW/ZkpmzcFs/dHQEnXqYPObFkthyMqvvtFGBI7b253J64EZ99Hgj8XGrywn3R8W9B7rmXonTPtk5jdYKU4G9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1CeStiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFB2C4CED2;
	Sat, 23 Nov 2024 01:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732326749;
	bh=V7BtTSq2q3ni0D0tak7aDYXcHjl/SVb7F9S3WE0i7cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1CeStiI86WismLcrWmjSJ8KnT4roPAy8FuM0ENb2BCbpIBMQTWwm/VB8AUDC9MLk
	 o1YaINSNGewfySi4x1a+LT2uEAxXdSrRasBnrK+npuuM6SMyuOdM6kPDbJkiqwvsq5
	 H6QX8q9zrz4JvGBIdS6kwf51xlmOSwI3/C1XhdjApJ0h+6UTtfnI6QnHCIcdJI006y
	 JVWa028QkfXa2ED5HXMHJ4LHydWSGezd0q0I5FP+9pPGhupiUCumwe145toLJve+YY
	 wDvgkJDivxNoWfE3gflDh16KbYPsVzrLr9I4Qp3sFj04v5DIemKTMDBVZJE5F0CYru
	 ge+n7yO/5GiSQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] static_call: Add read-only-after-init static calls
Date: Fri, 22 Nov 2024 17:52:21 -0800
Message-ID: <069be22d3643046173edbbe110218a9fd28a2e55.1732326588.git.jpoimboe@kernel.org>
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


