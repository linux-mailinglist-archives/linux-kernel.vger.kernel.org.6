Return-Path: <linux-kernel+bounces-549630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10892A554C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B46217123A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EC9272932;
	Thu,  6 Mar 2025 18:18:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F626BDB6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285105; cv=none; b=Ev4V4CVF5KDdTkjAx8t8XvRAI20+6ORvOVJuV38s5dgez1BNkEarnn0bmB4SwA2MRbE0ZuT8G0qYmCgaejbOvA7q0nJ8y6ULcvS9/63+w9PcW2QajCctDl0sVngmsftdBv1YOUjvPO0ZNXrxtYogOEcnJ5LyPVFhbbWuUxuHJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285105; c=relaxed/simple;
	bh=v29x7EAwZPqoODWj0J0BoDwxSmS05cdGsVA/4rz39mc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=d7ILSEzrPYx9UEPITF2XBAZ3fTtyjW4p7sdW/0IMQxMvGN7rjzYRqPL7LAeb90YkUQ8GQNOrnwUkC7EZ9dOM4EyjERU61+KlFB4tTmSb1jGzonwanY2dukNFdy9klMi+acUVZPlc899GsQ2Z5SBENEWqqb8apUO7ScZvM1cG+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA79C4CEE9;
	Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFne-00000000PJ6-39y3;
	Thu, 06 Mar 2025 13:18:26 -0500
Message-ID: <20250306181826.611132861@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Clark Williams <williams@redhat.com>
Subject: [for-next][PATCH 08/10] rtla/timerlat: Test BPF mode
References: <20250306181801.485766945@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Using the RTLA_NO_BPF environmental variable, execute rtla-timerlat
tests both with and without BPF support to cover both paths.

If rtla is built without BPF or the osnoise:timerlat_sample trace event
is not available, test only the non-BPF path.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250218145859.27762-9-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/tests/timerlat.t | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index e86f40e5749e..e939ff71d6be 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -4,7 +4,20 @@ source tests/engine.sh
 test_begin
 
 set_timeout 2m
+timerlat_sample_event='/sys/kernel/tracing/events/osnoise/timerlat_sample'
 
+if ldd $RTLA | grep libbpf >/dev/null && [ -d "$timerlat_sample_event" ]
+then
+	# rtla build with BPF and system supports BPF mode
+	no_bpf_options='0 1'
+else
+	no_bpf_options='1'
+fi
+
+# Do every test with and without BPF
+for option in $no_bpf_options
+do
+export RTLA_NO_BPF=$option
 check "verify help page" \
 	"timerlat --help"
 check "verify -s/--stack" \
@@ -23,5 +36,6 @@ check "verify -c/--cpus" \
 	"timerlat hist -c 0 -d 30s"
 check "hist test in nanoseconds" \
 	"timerlat hist -i 2 -c 0 -n -d 30s"
+done
 
 test_end
-- 
2.47.2



