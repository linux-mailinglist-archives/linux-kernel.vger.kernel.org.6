Return-Path: <linux-kernel+bounces-532759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB1FA451E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625477A8E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ECE185924;
	Wed, 26 Feb 2025 01:05:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F715575C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531937; cv=none; b=myfoYnyvDalWXJW2L0upILeVSFd5vvVgnoxS6dPldndb8qeqLkviBfdk2V1ZTgdcJrn0PLqJUu1+YRpW1/Zp6CekcLQHc0QdrZeOX1FdSlJiOKs9jcaqkeJWZil6h7yJqvpiarYgkEzZmjfLf4XQdIN1kg/El7LTiG9D7Vj+xNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531937; c=relaxed/simple;
	bh=bN4wLmU21n6ebSzvaJ8q1Sy1XYCq7ySgO0WZX8FrzWQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QTnK1Ni1MlOPaO7M/VBsuwVsbJPeUq0RcMeBl471ARFwnN6vkTap/kgwc+HUaTdoAjeqdBpwflKag4NOowKflEGrkjXEQFh48np1uV9ci5bp3kxkDvyuw9RGUuTp3aNYSkSbUpS/UcnU+WytwDnUZv/Nxj4HjlnkDAarCbbIZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B4CC4CEE8;
	Wed, 26 Feb 2025 01:05:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tn5sP-00000009EaF-0O2Y;
	Tue, 25 Feb 2025 20:06:17 -0500
Message-ID: <20250226010616.944876524@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Feb 2025 20:06:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>,
 Mark Brown <broonie@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
Subject: [for-next][PATCH 4/4] scripts/sorttable: Allow matches to functions before function entry
References: <20250226010556.526552688@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

ARM 64 uses -fpatchable-function-entry=4,2 which adds padding before the
function and the addresses in the mcount_loc point there instead of the
function entry that is returned by nm. In order to find a function from nm
to make sure it's not an unused weak function, the entries in the
mcount_loc section needs to match the entries from nm. Since it can be an
instruction before the entry, add a before_func variable that ARM 64 can
set to 8, and if the mcount_loc entry is within 8 bytes of the nm function
entry, then it will be considered a match.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: "Arnd Bergmann" <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/20250225182054.815536219@goodmis.org
Fixes: ef378c3b82338 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 07ad8116bc8d..7b4b3714b1af 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -611,13 +611,16 @@ static int add_field(uint64_t addr, uint64_t size)
 	return 0;
 }
 
+/* Used for when mcount/fentry is before the function entry */
+static int before_func;
+
 /* Only return match if the address lies inside the function size */
 static int cmp_func_addr(const void *K, const void *A)
 {
 	uint64_t key = *(const uint64_t *)K;
 	const struct func_info *a = A;
 
-	if (key < a->addr)
+	if (key + before_func < a->addr)
 		return -1;
 	return key >= a->addr + a->size;
 }
@@ -1253,6 +1256,8 @@ static int do_file(char const *const fname, void *addr)
 #ifdef MCOUNT_SORT_ENABLED
 		sort_reloc = true;
 		rela_type = 0x403;
+		/* arm64 uses patchable function entry placing before function */
+		before_func = 8;
 #endif
 		/* fallthrough */
 	case EM_386:
-- 
2.47.2



