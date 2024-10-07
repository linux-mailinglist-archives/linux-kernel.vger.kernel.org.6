Return-Path: <linux-kernel+bounces-360420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204F999AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EDEB218B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB251F4723;
	Fri, 11 Oct 2024 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+mofnM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A91F1310
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614985; cv=none; b=P+o+kHQkpv4fI8QHaqVVNijSyiaZS6TmfCs0bX1OAwJQ/snWVPQk1pRYexyn2SczYg5tqvTt6MFvZAgY+LypBFj68mHDZPmUUuIJlPPsZs3L0drTII1aNrQea7nrBdffAuVkOJqQlveVIiyBCsYRDPfx6ID5lWpC9fvatzzbdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614985; c=relaxed/simple;
	bh=jwkX2e1uC07uEDB1lFEYtl2Phzsl08ExNHBCN07tv6w=;
	h=Message-ID:From:To:Cc:Date:Subject:Content-type; b=RRjTCa1uyktFaxCc/wXHdCO5U7dVTH09zspim1fvOQnIbKSwP891ygurwpGwZaABVq5gcbEPBHHhZR7jnsWDrp2VrzAzKq3RBXNQgdAW1xmIuGi/mg45ac5EIPHMv2QtjpRIgoOA16q7TfvfCAoACIQA8o4bLgMZYBvZ3LGmDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+mofnM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34FFC4CEC5;
	Fri, 11 Oct 2024 02:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728614984;
	bh=jwkX2e1uC07uEDB1lFEYtl2Phzsl08ExNHBCN07tv6w=;
	h=From:To:Cc:Date:Subject:From;
	b=L+mofnM5t7IA1Adxs4tzOU2bj61RZr5Inqny8D05QdRC4aN8Mle/LbJtjamAQ/Ubw
	 KYPQid3AbkC/85744DFV854JdeFjYpCgam0iN7g+bb9D7JE5/A8bUoqQLtLRsrgY5m
	 EYNaARmwm157F9c1y8wJ+U+tb/zHkrLKV7RNN4+cxEQt+Miz4ohleDBx9yXLN3oVa4
	 GTK20LmfevgcRwiYAfPcZb/ZKKs0ZcWy4o5Q0kKGzVAawScJKGJo/2LxYEu3KAmtCU
	 SWDkwazCzN3EpUqomKWmKUHoPpyXnatNSLDBirjbgNQag3BRbmLkYxXJl55+sS9f3S
	 29jBFzBtduMRg==
Message-ID: <46a74705b04cab96aa8acdff7df710a8@kernel.org>
From: Clark Williams <clrkwllms@kernel.org>
To: Peter Ziljstra <peterz@infradead.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, bhe@redhat.com,
	yang.lee@linux.alibaba.com, ardb@kernel.org, edumazet@google.com,
	".com"@web.codeaurora.org, penguin-kernel@I-love.SAKURA.ne.jp
Date: Mon, 7 Oct 2024 13:30:08 -0500
Subject: [PATCH] ksysfs:  add a sysfs preemption_mode entry
Content-type: text/plain
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch is the result of a discussion at the last
stable-rt maintainers meeting, regarding what to do about a
commit that basically just made a 'realtime' entry in /sys/kernel
to indicate that the running kernel was compiled with PREEMPT_RT.
Not very useful to non-rt-users.

This commit adds a sysfs entry /sys/kernel/preempt_mode which
allows a user to determine what preemption mode is active for
the running kernel.

When read, the file will return one of the following set of
string values:

	NONE
	VOLUNTARY
	FULL
	RT

These values correspond to the options CONFIG_PREEMPT_NONE,
CONFIG_PREEMPT_VOLUNTARY, CONFIG_PREEMPT_FULL and CONFIG_PREEMPT_RT.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 kernel/ksysfs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 1bab21b4718f..57ebde28e4b9 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -188,6 +188,27 @@ KERNEL_ATTR_RO(crash_elfcorehdr_size);

 #endif /* CONFIG_VMCORE_INFO */

+/*
+ * entry to display the current preemption mode
+ */
+static ssize_t preempt_mode_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	char *mode = NULL;
+
+	if (preempt_model_rt())
+		mode = "RT";
+	else if (preempt_model_full())
+		mode = "FULL";
+	else if (preempt_model_voluntary())
+		mode = "VOLUNTARY";
+	else
+		mode = "NONE";
+	WARN_ON(mode == NULL);
+	return sysfs_emit(buf, "%s\n", mode);
+}
+KERNEL_ATTR_RO(preempt_mode);
+
 /* whether file capabilities are enabled */
 static ssize_t fscaps_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
@@ -263,6 +284,7 @@ static struct attribute * kernel_attrs[] = {
 	&uevent_seqnum_attr.attr,
 	&cpu_byteorder_attr.attr,
 	&address_bits_attr.attr,
+	&preempt_mode_attr.attr,
 #ifdef CONFIG_UEVENT_HELPER
 	&uevent_helper_attr.attr,
 #endif
--
2.46.2

