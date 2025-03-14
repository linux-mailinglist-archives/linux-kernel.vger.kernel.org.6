Return-Path: <linux-kernel+bounces-562022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D373CA61A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E4C7A836F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292220D4E3;
	Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGMp10cn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4772206F34
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980570; cv=none; b=k0lax1Jw5hCm19hMjvUm6nza+b8+1szYyBJv3pzvN6whNJYjF8jSVkEBVpnQ+MN54LqGboKJipVe2zNBc/yEEgd64XlxQvAOhVwwiBcYyBl0B2J0/1cnX1relj9MOcT8cjnFzWDQA6lvyv4WOvITFjqmXjVNJR7LeCUVwLzhI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980570; c=relaxed/simple;
	bh=VEoiTYp1V7L0ENmhPyAnmcO45S5Fd8ceq65oHR8RUF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHb/slDUZDQoRIHgJl3Gr5RFmJ7TeXUX2YHzc3xwcFcM5tw7IxThVspW5/xDHUHiW5nV9dQiDO/BjM+JtOWtNPogRBnqRHxF+9LWgV13zXQL05x/DTvwtSpTMhIflgWzQc/8VhHeJtHzHbUPt15mg3F9Ndp+VUXB7E2mLD6p350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGMp10cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AACEC4CEE9;
	Fri, 14 Mar 2025 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980570;
	bh=VEoiTYp1V7L0ENmhPyAnmcO45S5Fd8ceq65oHR8RUF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGMp10cnlNa/SDBtl1tX/DQi6Nsi1HB7fKbEX2xrMkdviSBVn7+fpDpMaJ64fzkxa
	 xgf6akMD5I7MBOUmgOF2W8TaSE0oYpkey9ai9Z9fKhFtzsMh1dSndXQQjes+9ascug
	 M+7EtmwwJ/Sr1I4bkbbtv7Xi4vA3EaVl8r3rSmNFOiwzs9aYSwX7XQRkn5O4ao9uJh
	 wJMkd1kuypJWtO7N/YRDBoXnDkNwi9h65eE8awqlss6IvxC6X0FVGrJeWJc+bo2vGp
	 E3gcYaGMGaI+Yljp7l/OQyktNwjO9s6gvpOv3xYH7BAEhgL86m1ik36zD6q+wkYhpp
	 CsC/EAvm8/OiA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 05/13] objtool: Increase per-function WARN_FUNC() rate limit
Date: Fri, 14 Mar 2025 12:29:03 -0700
Message-ID: <aec318d66c037a51c9f376d6fb0e8ff32812a037.1741975349.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741975349.git.jpoimboe@kernel.org>
References: <cover.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase the per-function WARN_FUNC() rate limit from 1 to 2.  If the
number of warnings for a given function goes beyond 2, print "skipping
duplicate warning(s)".  This helps root out additional warnings in a
function that might be hiding behind the first one.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c                |  2 +-
 tools/objtool/include/objtool/elf.h  |  2 +-
 tools/objtool/include/objtool/warn.h | 14 +++++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6b9ad3afe389..3ddaefe97f55 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4528,7 +4528,7 @@ static int disas_warned_funcs(struct objtool_file *file)
 	char *funcs = NULL, *tmp;
 
 	for_each_sym(file, sym) {
-		if (sym->warned) {
+		if (sym->warnings) {
 			if (!funcs) {
 				funcs = malloc(strlen(sym->name) + 1);
 				strcpy(funcs, sym->name);
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d7e815c2fd15..223ac1c24b90 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -65,10 +65,10 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
-	u8 warned	     : 1;
 	u8 embedded_insn     : 1;
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
+	u8 warnings	     : 2;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index ac04d3fe4dd9..6180288927fd 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -53,14 +53,22 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	free(_str);					\
 })
 
+#define WARN_LIMIT 2
+
 #define WARN_INSN(insn, format, ...)					\
 ({									\
 	struct instruction *_insn = (insn);				\
-	if (!_insn->sym || !_insn->sym->warned)				\
+	BUILD_BUG_ON(WARN_LIMIT > 2);					\
+	if (!_insn->sym || _insn->sym->warnings < WARN_LIMIT) {		\
 		WARN_FUNC(format, _insn->sec, _insn->offset,		\
 			  ##__VA_ARGS__);				\
-	if (_insn->sym)							\
-		_insn->sym->warned = 1;					\
+		if (_insn->sym)						\
+			_insn->sym->warnings++;				\
+	} else if (_insn->sym && _insn->sym->warnings == WARN_LIMIT) {	\
+		WARN_FUNC("skipping duplicate warning(s)",		\
+			  _insn->sec, _insn->offset);			\
+		_insn->sym->warnings++;					\
+	}								\
 })
 
 #define BT_INSN(insn, format, ...)				\
-- 
2.48.1


