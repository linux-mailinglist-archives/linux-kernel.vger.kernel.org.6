Return-Path: <linux-kernel+bounces-281126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775A94D35E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608A9B22EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED42197A66;
	Fri,  9 Aug 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh57/3Ae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72587197A6B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217030; cv=none; b=Yw6425VrrJKC/y89G4vE6YrO6VYN/kQ151Sz39WWasKmQFdOaTVq0WocTxwzXj2Bkk7oAkWr1XJJCiSeY4AxJOIq95lzVYAPgW+krxj7YSWLJKbqAT3iGqLnIj2bTX19eKV5eW0H5yDMTKS6KDiM7PH456e3FPGNeqtbZnchYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217030; c=relaxed/simple;
	bh=zCl5DYK5+AiXVxLQ+vXqaTAD+6WyEs2p08NnrqRzt/E=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=SjqfqbQDQoToRHWIYf/mp3Dy5A6Ca2S2EhDd0qgqQXHG73qllME2Srynr/eRBZDVn7RchcgtxGDoct2vjs4rkCbYF+57ndHjQIFeqixOjrv2JRhIJL92WHGzaKHZXycNuQ5T38/EkAQC1O7l6fMVO2P/HpLVyv+t9hOmjuk1hNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh57/3Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4E6C32782;
	Fri,  9 Aug 2024 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723217029;
	bh=zCl5DYK5+AiXVxLQ+vXqaTAD+6WyEs2p08NnrqRzt/E=;
	h=Date:From:To:Cc:Subject:From;
	b=Yh57/3AeW7SJWVpdVbnC/POgFdWZZ9KRCt3VwqbHuGV+6M1m45Z+w31AbcSblbZm0
	 L+D42fWE6OtTd0IiCnCpfYihvdsOesQ4FOZ4Hzx3wSB/WaNjHFNFLS6/ieF5FNw4yK
	 Omy+arwaRu49M9ruNzftHYSxAHVNZvQrokCOr5XoX+F1kKtN3KLp1WNmQ205rO7WtI
	 yYWOEi2+ubqeAZ0JDAcHCOpmWgwc7paDVoWUvRHC2z3HvdslthqcZ/Ksi5jOtFR7Mp
	 W5D+OEldg3/UHNCbAr6L2Rk9Mlm/cTImdmHTS17ySOcUHbKO2gxD27eFDIbuxGfKBO
	 Ieh+mba+KJ3zQ==
Date: Sat, 10 Aug 2024 00:23:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.11-rc2
Message-Id: <20240810002345.abb569694b6aa9fb6afa1fe8@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.11-rc2:

- kprobes: Fix misusing str_has_prefix() parameter order to check symbol
  prefix correctly.
- bpf: kprobe: remove unused declaring of bpf_kprobe_override.


Please pull the latest probes-fixes-v6.11-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.11-rc2

Tag SHA1: 495cd5d4c81ddcbaf8f5e2d7768292adc7309e2a
Head SHA1: 8c8acb8f26cbde665b233dd1b9bbcbb9b86822dc


Masami Hiramatsu (Google) (1):
      kprobes: Fix to check symbol prefixes correctly

Menglong Dong (1):
      bpf: kprobe: remove unused declaring of bpf_kprobe_override

----
 include/linux/trace_events.h | 1 -
 kernel/kprobes.c             | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)
---------------------------
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 9df3e2973626..9435185c10ef 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -880,7 +880,6 @@ do {									\
 struct perf_event;
 
 DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
-DECLARE_PER_CPU(int, bpf_kprobe_override);
 
 extern int  perf_trace_init(struct perf_event *event);
 extern void perf_trace_destroy(struct perf_event *event);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e85de37d9e1e..da59c68df841 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1557,8 +1557,8 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
 	if (lookup_symbol_name(addr, symbuf))
 		return false;
 
-	return str_has_prefix("__cfi_", symbuf) ||
-		str_has_prefix("__pfx_", symbuf);
+	return str_has_prefix(symbuf, "__cfi_") ||
+		str_has_prefix(symbuf, "__pfx_");
 }
 
 static int check_kprobe_address_safe(struct kprobe *p,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

