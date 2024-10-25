Return-Path: <linux-kernel+bounces-382707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F99B1280
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D39B21F36
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157BF20EA2F;
	Fri, 25 Oct 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeq18V2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B71D45FD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894747; cv=none; b=IfLuBqLVCPmOMk97hKo8nhPo4xb9FonF7Ikff3ypmYVmkbK9jAGF0X6A6dBbGWCCU4mAIAgcsXde0UL9eZu3xeVPTxUJEuOQOThJq0z7jQUTSmtwhXXKTtM64RHcyL8G+OeBmZMnfO87pJumC2pX/NmxcPXgpkRcvHRQz2+RNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894747; c=relaxed/simple;
	bh=+YD9R3YvmWs980S8NVbfZ5PqSjuqPsyxlTD7tozoEPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Strs7fme6gd5B8l+V0rhTp2CSXj0i4wSgh/fElKN2zx3vbVXxJ4LOrbv7U0BhiJCeQIMsA1N+L5KWZVIzg6mx8tNrcMHtxG+XGj0W+cEce047Clp5YEXNo+JZXP0ZU24sYbJpYHx+KKwWG2sVLHQUSmwY0y/QHyEsfxH7NEQAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeq18V2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7B3C4CEC3;
	Fri, 25 Oct 2024 22:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729894747;
	bh=+YD9R3YvmWs980S8NVbfZ5PqSjuqPsyxlTD7tozoEPc=;
	h=Date:From:To:Cc:Subject:From;
	b=oeq18V2Iold/RqWJTkno5flCIotBGGAGqSPwkjAsqEXrYG+44Nd2m6zvoTdqJA6gL
	 ptRTZPqKHmQwouyQpLnqPekhMzUyTFsy3Ac9nHWE+9gBElf+32yc1yccPnvKiz7mg5
	 TZpmaPiXgnBQBEOmpFoKCy70o0AVsbk+qzeeCm6EzTU8fz0tl4bPZW65EvDyzFfdPP
	 /1FAo50Bh+L3HtlPdYR63LpHiCoC2eZ0pLXMLy2TO0htL4dTji6KMG5x++uYeHWCiH
	 rWab3XB4sHyniUFZm//0MzrSDXbogM6VOrzNF0ijPp129d36aXZ36ro6Mw20mjiOGc
	 tERhewWvbOFQw==
Date: Fri, 25 Oct 2024 12:19:06 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: Fix
 enq_last_no_enq_fails selftest
Message-ID: <ZxwZWpbmKfVcMxMj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

cc9877fb7677 ("sched_ext: Improve error reporting during loading") changed
how load failures are reported so that more error context can be
communicated. This breaks the enq_last_no_enq_fails test as attach no longer
fails. The scheduler is guaranteed to be ejected on attach completion with
full error information. Update enq_last_no_enq_fails so that it checks that
the scheduler is ejected using ops.exit().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Vishal Chourasia <vishalc@linux.ibm.com>
Link: http://lkml.kernel.org/r/Zxknp7RAVNjmdJSc@linux.ibm.com
Fixes: cc9877fb7677 ("sched_ext: Improve error reporting during loading")
---
 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c |    8 ++++++++
 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c     |   10 +++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c
index b0b99531d5d5..e1bd13e48889 100644
--- a/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c
@@ -12,10 +12,18 @@
 
 char _license[] SEC("license") = "GPL";
 
+u32 exit_kind;
+
+void BPF_STRUCT_OPS_SLEEPABLE(enq_last_no_enq_fails_exit, struct scx_exit_info *info)
+{
+	exit_kind = info->kind;
+}
+
 SEC(".struct_ops.link")
 struct sched_ext_ops enq_last_no_enq_fails_ops = {
 	.name			= "enq_last_no_enq_fails",
 	/* Need to define ops.enqueue() with SCX_OPS_ENQ_LAST */
 	.flags			= SCX_OPS_ENQ_LAST,
+	.exit			= (void *) enq_last_no_enq_fails_exit,
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c
index 2a3eda5e2c0b..73e679953e27 100644
--- a/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c
+++ b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c
@@ -31,8 +31,12 @@ static enum scx_test_status run(void *ctx)
 	struct bpf_link *link;
 
 	link = bpf_map__attach_struct_ops(skel->maps.enq_last_no_enq_fails_ops);
-	if (link) {
-		SCX_ERR("Incorrectly succeeded in to attaching scheduler");
+	if (!link) {
+		SCX_ERR("Incorrectly failed at attaching scheduler");
+		return SCX_TEST_FAIL;
+	}
+	if (!skel->bss->exit_kind) {
+		SCX_ERR("Incorrectly stayed loaded");
 		return SCX_TEST_FAIL;
 	}
 
@@ -50,7 +54,7 @@ static void cleanup(void *ctx)
 
 struct scx_test enq_last_no_enq_fails = {
 	.name = "enq_last_no_enq_fails",
-	.description = "Verify we fail to load a scheduler if we specify "
+	.description = "Verify we eject a scheduler if we specify "
 		       "the SCX_OPS_ENQ_LAST flag without defining "
 		       "ops.enqueue()",
 	.setup = setup,

