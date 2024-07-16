Return-Path: <linux-kernel+bounces-254166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F5E932FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53B51C20B17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283FE1A0701;
	Tue, 16 Jul 2024 18:06:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B01A01B3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153194; cv=none; b=nIh6qYlLbYKdRb0kewFMjjLo7DfOZOGoYhejyzEXJTpE8ShkzpmIYISIBpYdscETQ0ELLRXcoKw2aKo+LRibcm2vB2TOYEBJPu18fkKoNPpdu8hPGqINA3GT+nejvTzVFr/Zx7X9S5YdeZ6a15ObjPuLIbGhBNOBgRuKf/wE+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153194; c=relaxed/simple;
	bh=o55I4gHeeFGPA/rtS3Pc4UlxasX1vWtXbPM/0m2q6dc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=H1WuXmKrSZYCowThIg7r66Fc6qd/iPI/C5BrajmCgy/RZvIBXFv4tfChWpUu0z72cbhn+jYelE7D1yXxFx+qOsgxFFMmAq7XxiQOwXOMRoeLAMGFaFoSR07wEBZik3wUWcj53K0C7byRZVDBVnYtNLdiWnJNWJ4T5BUT9/2c1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D56C4AF0F;
	Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sTmZP-00000000730-05cj;
	Tue, 16 Jul 2024 14:06:35 -0400
Message-ID: <20240716180634.882067002@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 16 Jul 2024 14:06:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Clark Williams <williams@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [for-next][PATCH 1/3] rtla/osnoise: set the default threshold to 1us
References: <20240716180613.399475893@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>

Change the default threshold for osnoise to 1us, so that any noise
equal or above this value is recorded. Let the user set a higher
threshold if necessary.

Link: https://lore.kernel.org/linux-trace-kernel/Zmb-QhiiiI6jM9To@uudg.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Reviewed-by: Clark Williams <williams@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/osnoise-tracer.rst | 2 +-
 kernel/trace/trace_osnoise.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 140ef2533d26..a520adbd3476 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -108,7 +108,7 @@ The tracer has a set of options inside the osnoise directory, they are:
    option.
  - tracing_threshold: the minimum delta between two time() reads to be
    considered as noise, in us. When set to 0, the default value will
-   be used, which is currently 5 us.
+   be used, which is currently 1 us.
  - osnoise/options: a set of on/off options that can be enabled by
    writing the option name to the file or disabled by writing the option
    name preceded with the 'NO\_' prefix. For example, writing
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a8e28f9b9271..66a871553d4a 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1444,9 +1444,9 @@ static int run_osnoise(void)
 	save_osn_sample_stats(osn_var, &s);
 
 	/*
-	 * if threshold is 0, use the default value of 5 us.
+	 * if threshold is 0, use the default value of 1 us.
 	 */
-	threshold = tracing_thresh ? : 5000;
+	threshold = tracing_thresh ? : 1000;
 
 	/*
 	 * Apply PREEMPT and IRQ disabled options.
-- 
2.43.0



