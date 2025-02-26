Return-Path: <linux-kernel+bounces-532758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0BA451E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152C519C0DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA5185920;
	Wed, 26 Feb 2025 01:05:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B215573A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531937; cv=none; b=HtLMIsEx4w80SDQ5Xkwo3JX5JPdtYz6G/zDEbQE3eH6kBM46+/w+t0zEQyvq0kCT/doHP8sX+Cun2KJRGTBGEhBsycCLjfClCUt6QvugN9xIq5uduq6T5i3hvPCOS6P/dtTLWFJLQbU2jMKAiUg19w0vRQEPAcuDY0PTQqYMmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531937; c=relaxed/simple;
	bh=lxxp7ttCQOpNKNUOpZILzSwscCviuGV0JaaK1i0JVNA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aA+IJoTxyHflQDpm5hnGhHDPt4P+we4xebK3B/gS/olX8MmmCvJjRdBrmuBmHW7roNYVRV3L8fAVCyHtpOdMmHlsJqOI979aV/MJt9EFAKqWsnaRdrS1O/brXDZl2Tv/Pg43FR0/zgzqNw8j0KWplf+/ExVXzH8Wxg0bKy2O7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BECFC4CEEF;
	Wed, 26 Feb 2025 01:05:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tn5sO-00000009EZk-3s6f;
	Tue, 25 Feb 2025 20:06:16 -0500
Message-ID: <20250226010616.775247087@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Feb 2025 20:05:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>
Subject: [for-next][PATCH 3/4] scripts/sorttable: Use normal sort if theres no relocs in the mcount
 section
References: <20250226010556.526552688@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When ARM 64 is compiled with gcc, the mcount_loc section will be filled
with zeros and the addresses will be located in the Elf_Rela sections. To
sort the mcount_loc section, the addresses from the Elf_Rela need to be
placed into an array and that is sorted.

But when ARM 64 is compiled with clang, it does it the same way as other
architectures and leaves the addresses as is in the mcount_loc section.

To handle both cases, ARM 64 will first try to sort the Elf_Rela section,
and if it doesn't find any functions, it will then fall back to the
sorting of the addresses in the mcount_loc section itself.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/20250225182054.648398403@goodmis.org
Fixes: b3d09d06e052 ("arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64")
Reported-by: "Arnd Bergmann" <arnd@arndb.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/893cd8f1-8585-4d25-bf0f-4197bf872465@app.fastmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 23c7e0e6c024..07ad8116bc8d 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -827,9 +827,14 @@ static void *sort_mcount_loc(void *arg)
 		pthread_exit(m_err);
 	}
 
-	if (sort_reloc)
+	if (sort_reloc) {
 		count = fill_relocs(vals, size, ehdr, emloc->start_mcount_loc);
-	else
+		/* gcc may use relocs to save the addresses, but clang does not. */
+		if (!count) {
+			count = fill_addrs(vals, size, start_loc);
+			sort_reloc = 0;
+		}
+	} else
 		count = fill_addrs(vals, size, start_loc);
 
 	if (count < 0) {
-- 
2.47.2



