Return-Path: <linux-kernel+bounces-334938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097DA97DE90
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FADB2146C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D839ADD;
	Sat, 21 Sep 2024 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MY1gmZl3"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649C2868D
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726947570; cv=none; b=rFTaP+AHyr5qQfzAiI4ZmNME5Gtjc1KVTejCMuFRpgWmKeUhQ9r7ms0kLIrmY0oOtKvHFFDOrB8Ah1rnzDTSzyqlnHiRrGqyBke83BNFPOfZsKGvWFRGofw4uoqZ+qIPffw69DcIAyOuxQ/54kZHtNfjDDozoLhW+8v3o7vnnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726947570; c=relaxed/simple;
	bh=embnaUn0NMd04RPqq4np/PYFxzoxdA27vW7gQNHW+Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoMYb7Vy3RlsyMGctJhhBT+ieA9U8Qt6m0XsL1rHLa0GaukYUaLw4dRaufB47SOQRCdhOkIk/pCX5mttvi+4hBRfW/svPCrQh5gvw9p+5SQ57McRYbhT3OMxj8aijSCORlyHYamCfBw0DLdmIB0QKPPjd1lllVBw1xQvGwWBT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MY1gmZl3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726947566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ka1oZgGeT8IBBOkhhbs2VFlo0gl68ZrL/QFKMDjGj3g=;
	b=MY1gmZl3zMoE4uax1x/vVlG4JA8ESJ9bKZERIPuTAf1jXTfcxA7QUPOhlx+2drCgjaUHMG
	XTTtCpJjrbvtfYA4q63igUE45Bf3MpBeSXsBeNTgB3u6ZRz6zgeM1QGUkfrDBuScb/ggXd
	YlQxOn6u5Q9Lrq3vK3Bu6KezF1ulNf4=
From: andrea.righi@linux.dev
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	Phil Auld <pauld@redhat.com>,
	linux-kernel@vger.kernel.org,
	Andrea Righi <andrea.righi@linux.dev>
Subject: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Date: Sat, 21 Sep 2024 21:39:21 +0200
Message-ID: <20240921193921.75594-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrea Righi <andrea.righi@linux.dev>

As discussed during the distro-centric session within the sched_ext
Microconference at LPC 2024, introduce a sequence counter that is
incremented every time a BPF scheduler is loaded.

This feature can help distributions in diagnosing potential performance
regressions by identifying systems where users are running (or have ran)
custom BPF schedulers.

Example:

 arighi@virtme-ng~> cat /sys/kernel/sched_ext/enable_seq
 0
 arighi@virtme-ng~> sudo scx_simple
 local=1 global=0
 ^CEXIT: unregistered from user space
 arighi@virtme-ng~> cat /sys/kernel/sched_ext/enable_seq
 1

In this way user-space tools (such as Ubuntu's apport and similar) are
able to gather and include this information in bug reports.

Cc: Giovanni Gherdovich <giovanni.gherdovich@suse.com>
Cc: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
Cc: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Cc: Phil Auld <pauld@redhat.com>
Signed-off-by: Andrea Righi <andrea.righi@linux.dev>
---
 Documentation/scheduler/sched-ext.rst | 10 ++++++++++
 kernel/sched/ext.c                    | 17 +++++++++++++++++
 tools/sched_ext/scx_show_state.py     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index a707d2181a77..6c0d70e2e27d 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -83,6 +83,15 @@ The current status of the BPF scheduler can be determined as follows:
     # cat /sys/kernel/sched_ext/root/ops
     simple
 
+You can check if any BPF scheduler has ever been loaded since boot by examining
+this monotonically incrementing counter (a value of zero indicates that no BPF
+scheduler has been loaded):
+
+.. code-block:: none
+
+    # cat /sys/kernel/sched_ext/enable_seq
+    1
+
 ``tools/sched_ext/scx_show_state.py`` is a drgn script which shows more
 detailed information:
 
@@ -96,6 +105,7 @@ detailed information:
     enable_state  : enabled (2)
     bypass_depth  : 0
     nr_rejected   : 0
+    enable_seq    : 1
 
 If ``CONFIG_SCHED_DEBUG`` is set, whether a given task is on sched_ext can
 be determined as follows:
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9ee5a9a261cc..8057ab4c76da 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -874,6 +874,13 @@ static struct scx_exit_info *scx_exit_info;
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
+/*
+ * A monotically increasing sequence number that is incremented every time a
+ * scheduler is enabled. This can be used by to check if any custom sched_ext
+ * scheduler has ever been used in the system.
+ */
+static atomic_long_t scx_enable_seq = ATOMIC_LONG_INIT(0);
+
 /*
  * The maximum amount of time in jiffies that a task may be runnable without
  * being scheduled on a CPU. If this timeout is exceeded, it will trigger
@@ -4154,11 +4161,19 @@ static ssize_t scx_attr_hotplug_seq_show(struct kobject *kobj,
 }
 SCX_ATTR(hotplug_seq);
 
+static ssize_t scx_attr_enable_seq_show(struct kobject *kobj,
+					struct kobj_attribute *ka, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", atomic_long_read(&scx_enable_seq));
+}
+SCX_ATTR(enable_seq);
+
 static struct attribute *scx_global_attrs[] = {
 	&scx_attr_state.attr,
 	&scx_attr_switch_all.attr,
 	&scx_attr_nr_rejected.attr,
 	&scx_attr_hotplug_seq.attr,
+	&scx_attr_enable_seq.attr,
 	NULL,
 };
 
@@ -5176,6 +5191,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	kobject_uevent(scx_root_kobj, KOBJ_ADD);
 	mutex_unlock(&scx_ops_enable_mutex);
 
+	atomic_long_inc(&scx_enable_seq);
+
 	return 0;
 
 err_del:
diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show_state.py
index d457d2a74e1e..8bc626ede1c4 100644
--- a/tools/sched_ext/scx_show_state.py
+++ b/tools/sched_ext/scx_show_state.py
@@ -37,3 +37,4 @@ print(f'switched_all  : {read_static_key("__scx_switched_all")}')
 print(f'enable_state  : {ops_state_str(enable_state)} ({enable_state})')
 print(f'bypass_depth  : {read_atomic("scx_ops_bypass_depth")}')
 print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
+print(f'enable_seq    : {read_atomic("scx_enable_seq")}')
-- 
2.46.0


