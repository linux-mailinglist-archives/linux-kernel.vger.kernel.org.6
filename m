Return-Path: <linux-kernel+bounces-413472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26459D197F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A499B2325D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8A1E631D;
	Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467811E5015
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960867; cv=none; b=NfkLob5t0D4182E71IqOj/35F0pq54BZPdyNbvkOl0zk276DPukFaQoueEwMKt2cYHLbrrN02b2f1IGEFNdaTU8IkiNDIwzJRsKydDevDJEfgMNwclrQWIl0+6zzCXbfku/BdOSJkclmrLfxWciaZW80zfnn5JrWqOCWTSyhg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960867; c=relaxed/simple;
	bh=MVdApGcyUkptaqX7YZykKxm5OO/+NabO5+9iyVWfb5o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=J36MZy1D6uQYx6pxDOJgbdv4NYK03YLfcV/15FbdZN5qKc+v06I/7Plzxd8KoESIgC4mZCOU3DmyQY5gPptLpbOG6MVJs+LdTy9MnkxUO09f4CDK55Zpbs+NsYrT612/yUpLRw+1EWUNdcxqGFJquC7pw/0TG17HvUmp81jj4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F39C4CECC;
	Mon, 18 Nov 2024 20:14:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tD89D-0000000D8x8-0RhF;
	Mon, 18 Nov 2024 15:14:59 -0500
Message-ID: <20241118201458.954141338@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 15:14:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 1/4] rtla/timerlat: Do not set params->user_workload with -U
References: <20241118201431.871648641@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Since commit fb9e90a67ee9 ("rtla/timerlat: Make user-space threads
the default"), rtla-timerlat has been defaulting to
params->user_workload if neither that or params->kernel_workload is set.
This has unintentionally made -U, which sets only params->user_hist/top
but not params->user_workload, to behave like -u unless -k is set,
preventing the user from running a custom workload.

Example:
$ rtla timerlat hist -U -c 0 &
[1] 7413
$ python sample/timerlat_load.py 0
Error opening timerlat fd, did you run timerlat -U?
$ ps | grep timerlatu
7415 pts/4    00:00:00 timerlatu/0

Fix the issue by checking for params->user_top/hist instead of
params->user_workload when setting default thread mode.

Link: https://lore.kernel.org/20241021123140.14652-1-tglozar@redhat.com
Fixes: fb9e90a67ee9 ("rtla/timerlat: Make user-space threads
the default")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 2 +-
 tools/tracing/rtla/src/timerlat_top.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 01dd337da13a..8b66387e5f35 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1073,7 +1073,7 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 	 * If the user did not specify a type of thread, try user-threads first.
 	 * Fall back to kernel threads otherwise.
 	 */
-	if (!params->kernel_workload && !params->user_workload) {
+	if (!params->kernel_workload && !params->user_hist) {
 		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
 		if (retval) {
 			debug_msg("User-space interface detected, setting user-threads\n");
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fca0da3caa87..f7422948205d 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -839,7 +839,7 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 	 * If the user did not specify a type of thread, try user-threads first.
 	 * Fall back to kernel threads otherwise.
 	 */
-	if (!params->kernel_workload && !params->user_workload) {
+	if (!params->kernel_workload && !params->user_top) {
 		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
 		if (retval) {
 			debug_msg("User-space interface detected, setting user-threads\n");
-- 
2.45.2



