Return-Path: <linux-kernel+bounces-575540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA7A703CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F99416A18E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34625C710;
	Tue, 25 Mar 2025 14:34:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1425A63F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913259; cv=none; b=r4Jt4Dfbr0CfQbWJQZbyMJMWCZq+eYzQCSiZKK9c/TRuscii+NLZ1ljJnw/2vIcecunR+GdMQYa8SOvIxcwUFDWSixAEispl2c+OFQkgtzqgvpSNWzsBnvP5Q8j2hF/uLY2f3HozZJPw4/QoLKJOeP1RHZceYQYYpc+RP+vwlcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913259; c=relaxed/simple;
	bh=p1UvD5es+f6vd4FWSW5Osq7Jzz0sqwLEu4VL8BAEl+0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EGFSDCXPFmI3cfuJd+G6/HM9Es5eknKXhNnrpw6JL1akjaLIwvhPVTUmNDWrLIAMvI60tdHsI0v5uLNNbNz4zTRiKF0B7/hYgrxk4WgVtlP4mIU8lEd6HRJbISUUrhXia7gE0qtoA06UAMw03V4JtOVIF1CYxpk1f8n2Nsq/Gqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF6CC4CEEF;
	Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tx5Mt-00000002P1q-0VHr;
	Tue, 25 Mar 2025 10:35:03 -0400
Message-ID: <20250325143502.973810949@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 10:34:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 7/9] verification/dot2k: Add support for nested monitors
References: <20250325143436.168114339@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

RV now supports nested monitors, this functionality requires a container
monitor, which has virtually no functionality besides holding other
monitors, and nested monitors, that have a container as parent.

Add the -p flag to pass a parent to a monitor, this sets it up while
registering the monitor and adds necessary includes and configurations.
Add the -c flag to create a container, since containers are empty, we
don't allow supplying a dot model or a monitor type, the template is
also different since functions to enable and disable the monitor are not
defined, nor any tracepoint. The generated header file only allows to
include the rv_monitor structure in children monitors.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/20250305140406.350227-8-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/dot2/dot2k                 | 27 ++++---
 tools/verification/dot2/dot2k.py              | 79 +++++++++++++++----
 .../verification/dot2/dot2k_templates/Kconfig |  1 +
 .../verification/dot2/dot2k_templates/main.c  |  4 +-
 .../dot2/dot2k_templates/main_container.c     | 38 +++++++++
 .../dot2/dot2k_templates/main_container.h     |  3 +
 6 files changed, 125 insertions(+), 27 deletions(-)
 create mode 100644 tools/verification/dot2/dot2k_templates/main_container.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_container.h

diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 559ba191a1f6..767064f415e7 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -11,22 +11,30 @@
 if __name__ == '__main__':
     from dot2.dot2k import dot2k
     import argparse
-    import ntpath
-    import os
-    import platform
     import sys
 
+    def is_container():
+        """Should work even before parsing the arguments"""
+        return "-c" in sys.argv or "--container" in sys.argv
+
     parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
-    parser.add_argument('-d', "--dot", dest="dot_file", required=True)
-    parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True)
-    parser.add_argument('-n', "--model_name", dest="model_name", required=False)
+    parser.add_argument('-d', "--dot", dest="dot_file", required=not is_container())
+    parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=not is_container(),
+                        help=f"Available options: {', '.join(dot2k.monitor_types.keys())}")
+    parser.add_argument('-n', "--model_name", dest="model_name", required=is_container())
     parser.add_argument("-D", "--description", dest="description", required=False)
     parser.add_argument("-a", "--auto_patch", dest="auto_patch",
                         action="store_true", required=False,
                         help="Patch the kernel in place")
+    parser.add_argument("-p", "--parent", dest="parent",
+                        required=False, help="Create a monitor nested to parent")
+    parser.add_argument("-c", "--container", dest="container",
+                        action="store_true", required=False,
+                        help="Create an empty monitor to be used as a container")
     params = parser.parse_args()
 
-    print("Opening and parsing the dot file %s" % params.dot_file)
+    if not is_container():
+        print("Opening and parsing the dot file %s" % params.dot_file)
     try:
         monitor=dot2k(params.dot_file, params.monitor_type, vars(params))
     except Exception as e:
@@ -37,8 +45,9 @@ if __name__ == '__main__':
     print("Writing the monitor into the directory %s" % monitor.name)
     monitor.print_files()
     print("Almost done, checklist")
-    print("  - Edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
-    print(monitor.fill_tracepoint_tooltip())
+    if not is_container():
+        print("  - Edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
+        print(monitor.fill_tracepoint_tooltip())
     print(monitor.fill_makefile_tooltip())
     print(monitor.fill_kconfig_tooltip())
     print(monitor.fill_monitor_tooltip())
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 153cc14bcca4..745d35a4a379 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -19,16 +19,31 @@ class dot2k(Dot2c):
     monitor_type = "per_cpu"
 
     def __init__(self, file_path, MonitorType, extra_params={}):
-        super().__init__(file_path, extra_params.get("model_name"))
-
-        self.monitor_type = self.monitor_types.get(MonitorType)
-        if self.monitor_type is None:
-            raise ValueError("Unknown monitor type: %s" % MonitorType)
-
-        self.monitor_type = MonitorType
+        self.container = extra_params.get("container")
+        self.parent = extra_params.get("parent")
         self.__fill_rv_templates_dir()
-        self.main_c = self.__read_file(self.monitor_templates_dir + "main.c")
-        self.trace_h = self.__read_file(self.monitor_templates_dir + "trace.h")
+
+        if self.container:
+            if file_path:
+                raise ValueError("A container does not require a dot file")
+            if MonitorType:
+                raise ValueError("A container does not require a monitor type")
+            if self.parent:
+                raise ValueError("A container cannot have a parent")
+            self.name = extra_params.get("model_name")
+            self.events = []
+            self.states = []
+            self.main_c = self.__read_file(self.monitor_templates_dir + "main_container.c")
+            self.main_h = self.__read_file(self.monitor_templates_dir + "main_container.h")
+        else:
+            super().__init__(file_path, extra_params.get("model_name"))
+
+            self.monitor_type = self.monitor_types.get(MonitorType)
+            if self.monitor_type is None:
+                raise ValueError("Unknown monitor type: %s" % MonitorType)
+            self.monitor_type = MonitorType
+            self.main_c = self.__read_file(self.monitor_templates_dir + "main.c")
+            self.trace_h = self.__read_file(self.monitor_templates_dir + "trace.h")
         self.kconfig = self.__read_file(self.monitor_templates_dir + "Kconfig")
         self.enum_suffix = "_%s" % self.name
         self.description = extra_params.get("description", self.name) or "auto-generated"
@@ -105,6 +120,14 @@ class dot2k(Dot2c):
     def fill_monitor_type(self):
         return self.monitor_type.upper()
 
+    def fill_parent(self):
+        return "&rv_%s" % self.parent if self.parent else "NULL"
+
+    def fill_include_parent(self):
+        if self.parent:
+            return "#include <monitors/%s/%s.h>\n" % (self.parent, self.parent)
+        return ""
+
     def fill_tracepoint_handlers_skel(self):
         buff = []
         for event in self.events:
@@ -146,6 +169,8 @@ class dot2k(Dot2c):
         tracepoint_handlers = self.fill_tracepoint_handlers_skel()
         tracepoint_attach = self.fill_tracepoint_attach_probe()
         tracepoint_detach = self.fill_tracepoint_detach_helper()
+        parent = self.fill_parent()
+        parent_include = self.fill_include_parent()
 
         main_c = main_c.replace("%%MONITOR_TYPE%%", monitor_type)
         main_c = main_c.replace("%%MIN_TYPE%%", min_type)
@@ -155,6 +180,8 @@ class dot2k(Dot2c):
         main_c = main_c.replace("%%TRACEPOINT_ATTACH%%", tracepoint_attach)
         main_c = main_c.replace("%%TRACEPOINT_DETACH%%", tracepoint_detach)
         main_c = main_c.replace("%%DESCRIPTION%%", self.description)
+        main_c = main_c.replace("%%PARENT%%", parent)
+        main_c = main_c.replace("%%INCLUDE_PARENT%%", parent_include)
 
         return main_c
 
@@ -216,6 +243,14 @@ class dot2k(Dot2c):
         buff.append("	     TP_ARGS(%s)" % tp_args_c)
         return self.__buff_to_string(buff)
 
+    def fill_monitor_deps(self):
+        buff = []
+        buff.append("	# XXX: add dependencies if there")
+        if self.parent:
+            buff.append("	depends on RV_MON_%s" % self.parent.upper())
+            buff.append("	default y")
+        return self.__buff_to_string(buff)
+
     def fill_trace_h(self):
         trace_h = self.trace_h
         monitor_class = self.fill_monitor_class()
@@ -233,12 +268,19 @@ class dot2k(Dot2c):
     def fill_kconfig(self):
         kconfig = self.kconfig
         monitor_class_type = self.fill_monitor_class_type()
+        monitor_deps = self.fill_monitor_deps()
         kconfig = kconfig.replace("%%MODEL_NAME%%", self.name)
         kconfig = kconfig.replace("%%MODEL_NAME_UP%%", self.name.upper())
         kconfig = kconfig.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
         kconfig = kconfig.replace("%%DESCRIPTION%%", self.description)
+        kconfig = kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
         return kconfig
 
+    def fill_main_container_h(self):
+        main_h = self.main_h
+        main_h = main_h.replace("%%MODEL_NAME%%", self.name)
+        return main_h
+
     def __patch_file(self, file, marker, line):
         file_to_patch = os.path.join(self.rv_dir, file)
         content = self.__read_file(file_to_patch)
@@ -324,19 +366,24 @@ obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
 
     def print_files(self):
         main_c = self.fill_main_c()
-        model_h = self.fill_model_h()
 
         self.__create_directory()
 
         path = "%s.c" % self.name
         self.__create_file(path, main_c)
 
-        path = "%s.h" % self.name
-        self.__create_file(path, model_h)
-
-        trace_h = self.fill_trace_h()
-        path = "%s_trace.h" % self.name
-        self.__create_file(path, trace_h)
+        if self.container:
+            main_h = self.fill_main_container_h()
+            path = "%s.h" % self.name
+            self.__create_file(path, main_h)
+        else:
+            model_h = self.fill_model_h()
+            path = "%s.h" % self.name
+            self.__create_file(path, model_h)
+
+            trace_h = self.fill_trace_h()
+            path = "%s_trace.h" % self.name
+            self.__create_file(path, trace_h)
 
         kconfig = self.fill_kconfig()
         self.__create_file("Kconfig", kconfig)
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig b/tools/verification/dot2/dot2k_templates/Kconfig
index 03100eda1707..291b29ea28db 100644
--- a/tools/verification/dot2/dot2k_templates/Kconfig
+++ b/tools/verification/dot2/dot2k_templates/Kconfig
@@ -2,6 +2,7 @@
 #
 config RV_MON_%%MODEL_NAME_UP%%
 	depends on RV
+%%MONITOR_DEPS%%
 	select %%MONITOR_CLASS_TYPE%%
 	bool "%%MODEL_NAME%% monitor"
 	help
diff --git a/tools/verification/dot2/dot2k_templates/main.c b/tools/verification/dot2/dot2k_templates/main.c
index 9605ca994416..83044a20c89a 100644
--- a/tools/verification/dot2/dot2k_templates/main.c
+++ b/tools/verification/dot2/dot2k_templates/main.c
@@ -15,7 +15,7 @@
  * #include <trace/events/sched.h>
  */
 #include <rv_trace.h>
-
+%%INCLUDE_PARENT%%
 /*
  * This is the self-generated part of the monitor. Generally, there is no need
  * to touch this section.
@@ -74,7 +74,7 @@ static struct rv_monitor rv_%%MODEL_NAME%% = {
 
 static int __init register_%%MODEL_NAME%%(void)
 {
-	rv_register_monitor(&rv_%%MODEL_NAME%%);
+	rv_register_monitor(&rv_%%MODEL_NAME%%, %%PARENT%%);
 	return 0;
 }
 
diff --git a/tools/verification/dot2/dot2k_templates/main_container.c b/tools/verification/dot2/dot2k_templates/main_container.c
new file mode 100644
index 000000000000..89fc17cf8958
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/main_container.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+#define MODULE_NAME "%%MODEL_NAME%%"
+
+#include "%%MODEL_NAME%%.h"
+
+struct rv_monitor rv_%%MODEL_NAME%%;
+
+struct rv_monitor rv_%%MODEL_NAME%% = {
+	.name = "%%MODEL_NAME%%",
+	.description = "%%DESCRIPTION%%",
+	.enable = NULL,
+	.disable = NULL,
+	.reset = NULL,
+	.enabled = 0,
+};
+
+static int __init register_%%MODEL_NAME%%(void)
+{
+	rv_register_monitor(&rv_%%MODEL_NAME%%, NULL);
+	return 0;
+}
+
+static void __exit unregister_%%MODEL_NAME%%(void)
+{
+	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
+}
+
+module_init(register_%%MODEL_NAME%%);
+module_exit(unregister_%%MODEL_NAME%%);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("%%MODEL_NAME%%: %%DESCRIPTION%%");
diff --git a/tools/verification/dot2/dot2k_templates/main_container.h b/tools/verification/dot2/dot2k_templates/main_container.h
new file mode 100644
index 000000000000..0f6883ab4bcc
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/main_container.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern struct rv_monitor rv_%%MODEL_NAME%%;
-- 
2.47.2



