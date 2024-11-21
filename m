Return-Path: <linux-kernel+bounces-417130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA8E9D4F73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D7B267AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4B1DB375;
	Thu, 21 Nov 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcZNEP+p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21E1D89E3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201264; cv=none; b=hgqxG2QkiL7s3PSV4OSsSvHxG/2KaBKkvotjietj1cyHi5vqAT5WiHCQZhBToO4aokrcA6fypfK70A8QplFmq2R8B+fSk03EE3RaAt2YYNA+0O3wdxt6EXergGCA4bLKE86BbyWzuVAwX+uUG1zwOsPaP3CHTx3in4BBBkKZBpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201264; c=relaxed/simple;
	bh=JvjdpnaUwgwv0rIqON9pusPqdfHB9BeP2R6MTGXWOao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pH2+wf95ODdpuZeGWzUrr44dyHAR+LKNKDAQWPjxs9+k0UA+mRO1tgDx+TFnVM3FcDQnMPL01WF3DAR0QuP1vC1vXbIHocqr9eyJ/niHDHg8NLSQq124u26zkWovv6a7FpQ8dwAr8aUruhFsv8QcQainjpkIPJrIeHMHfhbcqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcZNEP+p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732201260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NzyuGggMc+ms8dd+Ov71Li4jWsgpAsQIap/nhORs9E=;
	b=YcZNEP+pJquvuZ6jT09a0Dj7Qbl+UW+cWr7iQbhWGxspCjgbD0FVo0gl76zXgCT5QfdhIB
	IHSI0FOLSVN2dzwENToTIS6pkKrQAICXQwlyiTxT2sSnCJw9lbaWaoIZ8sj8rTcvpzbvsO
	5sUMVYVly+CaTgVOS99Hm+6QPOOgkEE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-jMK0yHb5OUS5gjdhxduT3A-1; Thu,
 21 Nov 2024 10:00:57 -0500
X-MC-Unique: jMK0yHb5OUS5gjdhxduT3A-1
X-Mimecast-MFC-AGG-ID: jMK0yHb5OUS5gjdhxduT3A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3117B1956069;
	Thu, 21 Nov 2024 15:00:56 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.194.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6F4530000DF;
	Thu, 21 Nov 2024 15:00:53 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 1/4] verification/dot2k: Fix template directory if not installed
Date: Thu, 21 Nov 2024 15:59:54 +0100
Message-ID: <20241121145957.145700-2-gmonaco@redhat.com>
In-Reply-To: <20241121145957.145700-1-gmonaco@redhat.com>
References: <20241121145957.145700-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch adjusts the directory where dot2k looks for templates if we
are in the kernel tree: we can run dot2k without installing it if the
current directory is `<linux>/tools/verification` by running something
like `python dot2/dot2k ...`

Additionally we fix a few simple pylint warnings in boolean expressions.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/dot2/dot2k.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 016550fccf1f..f6d02e3406a3 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -14,14 +14,14 @@ import os
 
 class dot2k(Dot2c):
     monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
-    monitor_templates_dir = "dot2k/rv_templates/"
+    monitor_templates_dir = "dot2/dot2k_templates/"
     monitor_type = "per_cpu"
 
     def __init__(self, file_path, MonitorType):
         super().__init__(file_path)
 
         self.monitor_type = self.monitor_types.get(MonitorType)
-        if self.monitor_type == None:
+        if self.monitor_type is None:
             raise Exception("Unknown monitor type: %s" % MonitorType)
 
         self.monitor_type = MonitorType
@@ -31,7 +31,7 @@ class dot2k(Dot2c):
 
     def __fill_rv_templates_dir(self):
 
-        if os.path.exists(self.monitor_templates_dir) == True:
+        if os.path.exists(self.monitor_templates_dir):
             return
 
         if platform.system() != "Linux":
@@ -39,11 +39,11 @@ class dot2k(Dot2c):
 
         kernel_path = "/lib/modules/%s/build/tools/verification/dot2/dot2k_templates/" % (platform.release())
 
-        if os.path.exists(kernel_path) == True:
+        if os.path.exists(kernel_path):
             self.monitor_templates_dir = kernel_path
             return
 
-        if os.path.exists("/usr/share/dot2/dot2k_templates/") == True:
+        if os.path.exists("/usr/share/dot2/dot2k_templates/"):
             self.monitor_templates_dir = "/usr/share/dot2/dot2k_templates/"
             return
 
@@ -98,7 +98,7 @@ class dot2k(Dot2c):
     def fill_main_c(self):
         main_c = self.main_c
         min_type = self.get_minimun_type()
-        nr_events = self.events.__len__()
+        nr_events = len(self.events)
         tracepoint_handlers = self.fill_tracepoint_handlers_skel()
         tracepoint_attach = self.fill_tracepoint_attach_probe()
         tracepoint_detach = self.fill_tracepoint_detach_helper()
@@ -160,8 +160,8 @@ class dot2k(Dot2c):
 
     def __get_main_name(self):
         path = "%s/%s" % (self.name, "main.c")
-        if os.path.exists(path) == False:
-           return "main.c"
+        if not os.path.exists(path):
+            return "main.c"
         return "__main.c"
 
     def print_files(self):
-- 
2.47.0


