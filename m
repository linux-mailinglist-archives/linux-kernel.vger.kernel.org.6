Return-Path: <linux-kernel+bounces-198045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010E38D72C3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1305281DA5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2147A48;
	Sat,  1 Jun 2024 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwVyWHJA"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41922D03B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717285117; cv=none; b=tlGQjEWYbGM7YIhn7prfi2EUKziJQaz8DnxRxnCFU6UYZrQukjahgULu0n6Jper1yiDPcLyIus3wGHnWeINbq8GR8x+scUEH4yJiI9w+L1xBkuJvHZDH04L4pP93tiHi7t1MROHg3bo9099NWmStk43pQ4P//f+H4eQ8e97JbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717285117; c=relaxed/simple;
	bh=QNoUF02nF/xwAPfYwSPbKWf+84Ra605LdQjS2BDTsKI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hvc1STjC2qoyMZBogacvufGyxS3qJqqcYcU2Rf8TwvPNosEfI+JghhvqTNMNL6ihXq67cWu2BQ7frToASMIUmS4E7s5UrykrnGEjZWgqgb1GTVngK7u2LOgTfiAO3u4bYVXR0fO85OOe9eYhjgPpD7um5wIH7TSUWJYFTmHbTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwVyWHJA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa7843b501so2993318276.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717285115; x=1717889915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kZYI7szeEV/JGCAfsUUNi2/D4wUrEpjRfowLgkGTZlA=;
        b=QwVyWHJAd/jsJPZMBqgVYE+399KwIYH5KRqZ2q1oVMYOJQuyjGSUq7MRkBHVttLvqb
         cda0SIcw74C/nVwm6QAI+tNmBR7DutWfudeSG3bfGSAM/k1ZwoS3IJR53hj+eZaPfQ2Q
         Ktr+YEq+0W7x2vDRm3OVI5Om/8JTBGiy2EsSBDlxx7D4QG9yt2MYV1PNjkIVVNiwdlNm
         7mwJsnhrOfIj4ISJjfOaBr7swCR4h3tOpGWaNmsfaHAfoc4lSRJH0vTv3qaFFb7N3K01
         Ms4ngZfFd0VVpUXqQoJXciz5zp++Gjp+IC6+M1TYejVR/nNxw63GMntl7URMuKtcvN1q
         Ubxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717285115; x=1717889915;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZYI7szeEV/JGCAfsUUNi2/D4wUrEpjRfowLgkGTZlA=;
        b=BZbiijPXDU1E7BQIGgaQCmYc0UbEyv57OQMLBclJiAYVPnjmP3VAZNv9CAL+MZ4iNo
         y796raEWIKgjTJa/pJvJfD+z8xgK6g9SD021Rh7GHfRV2xbZnz2xXMbuIplAeIVv0z6/
         lR6gfQMpMmd3x0g9q4gd1lFB3itBx9cgFB4rqrqvYUUNOpBlGhXlmLCSdIZEiAw69VFn
         6/lJUyMbCO0/eLNykmES3tVvyMxfzNSGgX7nxcbFJXHXLQiR3x7HNAj6LdAzfXLHMOAc
         T2sqaQLjlZTHhtq7WiW5w61iRdDTZB4mmDiL2iV3zzSX1oLeUWOpeYSCEg396SgybhMN
         jtLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdf5RTKKexDrKx8exvQNRZUUnt2lAkue2to4UdxeEtyomvgxmRUTNMliEU4abAew7j3H2HahOLOC3G2+8vqu/KhTe3ZZs/ifYjQR0r
X-Gm-Message-State: AOJu0YwNbYQTvaxG88FIHJ/52ij7KRGh1v/nzOdAzQrhs+a8yIBty3S6
	ksjX9bvqshGxzsCdMZYbOznu6vpAwM3GamEgbqnO6gN+PLJtBf7CAEPRYZujWl+waRxhAUnXZR5
	MaA==
X-Google-Smtp-Source: AGHT+IGc0EzkS4huRPd+zXDTXGm4OldrghJAUs34M6l7DcRfqwVB2dZkEWz0x5Ey8il+XQ4f1eJpCGyyUt0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:81fd:fd40:a37b:76d1])
 (user=surenb job=sendgmr) by 2002:a25:6910:0:b0:dc9:c54e:c5eb with SMTP id
 3f1490d57ef6-dfa73c3429bmr1273251276.7.1717285114740; Sat, 01 Jun 2024
 16:38:34 -0700 (PDT)
Date: Sat,  1 Jun 2024 16:38:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240601233831.617124-1-surenb@google.com>
Subject: [PATCH 1/1] lib/alloc_tag: do not register sysctl interface when CONFIG_SYSCTL=n
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Memory allocation profiling is trying to register sysctl interface even
when CONFIG_SYSCTL=n, resulting in proc_do_static_key() being undefined.
Prevent that by skipping sysctl registration for such configurations.

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405280616.wcOGWJEj-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/alloc_tag.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 11ed973ac359..c347b8b72d78 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -227,6 +227,7 @@ struct page_ext_operations page_alloc_tagging_ops = {
 };
 EXPORT_SYMBOL(page_alloc_tagging_ops);
 
+#ifdef CONFIG_SYSCTL
 static struct ctl_table memory_allocation_profiling_sysctls[] = {
 	{
 		.procname	= "mem_profiling",
@@ -241,6 +242,17 @@ static struct ctl_table memory_allocation_profiling_sysctls[] = {
 	{ }
 };
 
+static void __init sysctl_init(void)
+{
+	if (!mem_profiling_support)
+		memory_allocation_profiling_sysctls[0].mode = 0444;
+
+	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
+}
+#else /* CONFIG_SYSCTL */
+static inline void sysctl_init(void) {}
+#endif /* CONFIG_SYSCTL */
+
 static int __init alloc_tag_init(void)
 {
 	const struct codetag_type_desc desc = {
@@ -253,9 +265,7 @@ static int __init alloc_tag_init(void)
 	if (IS_ERR(alloc_tag_cttype))
 		return PTR_ERR(alloc_tag_cttype);
 
-	if (!mem_profiling_support)
-		memory_allocation_profiling_sysctls[0].mode = 0444;
-	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
+	sysctl_init();
 	procfs_init();
 
 	return 0;

base-commit: 065d3634d60843b8e338d405b844cc7f2e5e1c66
-- 
2.45.1.288.g0e0cd299f1-goog


