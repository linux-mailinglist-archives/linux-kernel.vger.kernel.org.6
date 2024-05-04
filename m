Return-Path: <linux-kernel+bounces-168691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE168BBC3E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CB31C21116
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A2937700;
	Sat,  4 May 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0RripFr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A7347A2
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714828761; cv=none; b=Qa8TAep7ZcJNEAIasxa3ZpLdX2eUnyulpj7jk/588y39jssJ6Zpj7obTxkpPMtwx9uU9gSzJ6b6huzQTtHlTKen62zUMnfGxPXej2M+9yn5SnOlhZwZ2blK7JgN/ZHUzrtdppJPSHI5o77XBN4YuJWii9ebVN3qBYfQgoFvqH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714828761; c=relaxed/simple;
	bh=0iM6ddpSHy9QRibkfi4w6+c5/GvHMDRispgBTIldvY4=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=LsoNYLE4kPVMAAMH5nMjq3D3ce8Xc1/iA2qGcwfLxsVgPV8jijMh5mtgBadwhiASJOisA5str9Cp/cDg5hKHMFccBq+wfC3aSGNSkjaoCi2WphvfEgJ/RxpcOxNK219XnmAP13gqHIMZooDU5F2db2Cbbs7R2+zVrP/lW/1OAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0RripFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571B0C072AA;
	Sat,  4 May 2024 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714828760;
	bh=0iM6ddpSHy9QRibkfi4w6+c5/GvHMDRispgBTIldvY4=;
	h=Date:From:To:Cc:Subject:From;
	b=e0RripFrDu5yGApT5MAafPDUvfmk0UOhMkAQ+L4LEyZs5toqPDGuSP4LbAaLsB8iE
	 Ijs2zkAxIvxu9/8Jny/gBiGQw6CpsGRFTUJaqCUW6mki0fZouxydJN7P5QYRLSEaow
	 yb96tCHMh3/KscTGt3Zljv+0glN0WHq6DveRT9ygntCWfWz8Xxrtymbv5BW4vCn+rQ
	 GbN5m1cfzU7KK0bQm0OrPAuby0dp62Cvj0inIbnw6ARLdJzwUQmjdlfV+Yk5VtEKZ3
	 nyX7F68GEMZ+Wgk9xhv6uroUkzdnKa6UrHGrIbzzG5gblrLMZBEZQ1dzJoa7PrVh5E
	 yULgO7i7Tt3Qw==
Date: Sat, 4 May 2024 22:19:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LuMingYin <lumingyindetect@126.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.9-rc6
Message-Id: <20240504221917.4917a9eac7ab8cc90a0af5a1@kernel.org>
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

Probes fixes for v6.9-rc6:

- probe-events: Fix memory leak in parsing probe argument. There is a
  memory leak (forget to free an allocated buffer) in a memory allocation
  failure path. Fixes it to jump to the correct error handling code.


Please pull the latest probes-fixes-v6.9-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.9-rc6

Tag SHA1: 7ecfa9b34f812e244746158de5abfdd5132a4a62
Head SHA1: dce3696271af7765f04428ec31b1b87dc7d016c6


LuMingYin (1):
      tracing/probes: Fix memory leak in traceprobe_parse_probe_arg_body()

----
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit dce3696271af7765f04428ec31b1b87dc7d016c6
Author: LuMingYin <lumingyindetect@126.com>
Date:   Sat Apr 27 08:23:47 2024 +0100

    tracing/probes: Fix memory leak in traceprobe_parse_probe_arg_body()
    
    If traceprobe_parse_probe_arg_body() failed to allocate 'parg->fmt',
    it jumps to the label 'out' instead of 'fail' by mistake.In the result,
    the buffer 'tmp' is not freed in this case and leaks its memory.
    
    Thus jump to the label 'fail' in that error case.
    
    Link: https://lore.kernel.org/all/20240427072347.1421053-1-lumingyindetect@126.com/
    
    Fixes: 032330abd08b ("tracing/probes: Cleanup probe argument parser")
    Signed-off-by: LuMingYin <lumingyindetect@126.com>
    Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dfe3ee6035ec..42bc0f362226 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1466,7 +1466,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		parg->fmt = kmalloc(len, GFP_KERNEL);
 		if (!parg->fmt) {
 			ret = -ENOMEM;
-			goto out;
+			goto fail;
 		}
 		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
 			 parg->count);

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

