Return-Path: <linux-kernel+bounces-563079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE42A636BE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3879D188FFFD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4571A1B4132;
	Sun, 16 Mar 2025 17:18:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433712C544
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145511; cv=none; b=evgRydeia4lSJviot1S68PpPRhm6KmhQQoO3f73VgN98E9SeRALTpuanP8oX2FuLrxqJLLl5dke4A9D1S9FAhvuG1thJKRy62+xTV1RAj6yfjHqYoBlM+4xBLwQGldWguf4QU75aU3/J60ODgvCEwr+FtBqfiTxqQgMGnk83Ahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145511; c=relaxed/simple;
	bh=xBz2WjY6BNBTg5FUHG1s+DNHHjDK9bMAcC2kU0YAYk0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cd322CoISlmxConhJ8WC7SsemcUPntiGiZePg2BwXdzC6Me2PyEIaDy1EmD1wkkYY9epgB13ruhd5gqdbsKfSnNxyBuySFT/kyg4Rgxza+CMlMndTBpL1pd/w1r+C3qmJdFXieOAK+sfWIfcs6Xgxn2MzidcSv1CJtLtXkP2rxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B50EC4CEDD;
	Sun, 16 Mar 2025 17:18:29 +0000 (UTC)
Date: Sun, 16 Mar 2025 13:18:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tengda Wu <wutengda@huaweicloud.com>
Subject: [GIT PULL] tracing: Fix for v6.14
Message-ID: <20250316131827.4d989e91@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Fix ref count of trace_array in error path of histogram file open

Tracing instances have a ref count to keep them around while files within
their directories are open. This prevents them from being deleted while
they are used. The histogram code had some files that needed to take the
ref count and that was added, but the error paths did not decrement the
ref counts. This caused the instances from ever being removed if a
histogram file failed to open due to some error.


Please pull the latest trace-v6.14-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.14-rc5

Tag SHA1: 81862092868cd7b5ee12ffe7cc52fcc97978d891
Head SHA1: 0b4ffbe4888a2c71185eaf5c1a02dd3586a9bc04


Tengda Wu (1):
      tracing: Correct the refcount if the hist/hist_debug file fails to open

----
 kernel/trace/trace_events_hist.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)
---------------------------
commit 0b4ffbe4888a2c71185eaf5c1a02dd3586a9bc04
Author: Tengda Wu <wutengda@huaweicloud.com>
Date:   Fri Mar 14 06:53:35 2025 +0000

    tracing: Correct the refcount if the hist/hist_debug file fails to open
    
    The function event_{hist,hist_debug}_open() maintains the refcount of
    'file->tr' and 'file' through tracing_open_file_tr(). However, it does
    not roll back these counts on subsequent failure paths, resulting in a
    refcount leak.
    
    A very obvious case is that if the hist/hist_debug file belongs to a
    specific instance, the refcount leak will prevent the deletion of that
    instance, as it relies on the condition 'tr->ref == 1' within
    __remove_instance().
    
    Fix this by calling tracing_release_file_tr() on all failure paths in
    event_{hist,hist_debug}_open() to correct the refcount.
    
    Cc: stable@vger.kernel.org
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Zheng Yejian <zhengyejian1@huawei.com>
    Link: https://lore.kernel.org/20250314065335.1202817-1-wutengda@huaweicloud.com
    Fixes: 1cc111b9cddc ("tracing: Fix uaf issue when open the hist or hist_debug file")
    Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ad7419e24055..53dc6719181e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5689,12 +5689,16 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	guard(mutex)(&event_mutex);
 
 	event_file = event_file_data(file);
-	if (!event_file)
-		return -ENODEV;
+	if (!event_file) {
+		ret = -ENODEV;
+		goto err;
+	}
 
 	hist_file = kzalloc(sizeof(*hist_file), GFP_KERNEL);
-	if (!hist_file)
-		return -ENOMEM;
+	if (!hist_file) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	hist_file->file = file;
 	hist_file->last_act = get_hist_hit_count(event_file);
@@ -5702,9 +5706,14 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
 	ret = single_open(file, hist_show, hist_file);
-	if (ret)
+	if (ret) {
 		kfree(hist_file);
+		goto err;
+	}
 
+	return 0;
+err:
+	tracing_release_file_tr(inode, file);
 	return ret;
 }
 
@@ -5979,7 +5988,10 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
-	return single_open(file, hist_debug_show, file);
+	ret = single_open(file, hist_debug_show, file);
+	if (ret)
+		tracing_release_file_tr(inode, file);
+	return ret;
 }
 
 const struct file_operations event_hist_debug_fops = {

