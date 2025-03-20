Return-Path: <linux-kernel+bounces-569085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC59A69E61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771D08A6CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0CF1EE7A9;
	Thu, 20 Mar 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Drzz8U7K"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8061E0DEB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742438422; cv=none; b=Rcm1QMNYrxiiBG6ck4zLser2PrwpuuFl5+foqEhw9YZi8tzKEeojVax5j/2to41xGU3H4fZAJJuf2UeApP0eMKqALhpFBBsZZlbKQFMDPMtR4/bVKSL489LrUuB+J9UE+nOdcvyDfvzNFCiX4m8O/c/Rl/6yUhuk11R1bWpi4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742438422; c=relaxed/simple;
	bh=oUG8URVwL7hgoL7A0Syp6JtiW7YzotL8mXkD7FBHINQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs399TYchx1LAVCG0DDxl4KOecZRZXA0BgSUFFVHjp/X0Sto1wLpQGhZ6x42Na+R4qVZuqHi3F/tqV12U/7V2lp/T/LhQ9AffldzGwWLIHc6jdNomkWfZn35Ti29m1e9fe+LOKPeQxxd6swhE1ejzpBRrIUYM0OU3wGsf1LX66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Drzz8U7K; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c58974ed57so35199985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742438417; x=1743043217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+Xiz6rkBGzGCx6+zJzw9Yhwx3PtKxS1SxbWRWfwpXc=;
        b=Drzz8U7KocmJKum6DuOcSK0C6OZQp+4O59lVOjvoc1KggJ369wtRYiF/TUyDigbjsT
         phsDn62Xmx57Dcss2ASSKSjq6kjC2OgrQE43pExRgduIxP70v+xVD5ddQJrvE/SVHCpY
         q5rTnMh11zwVlQ33TIIS49+PSnvd+QBFFGibblsz/+0VFQ0TvyqVrEASJKNC3plfHPO6
         iCg3X83NZ1yPL8SgjASQbE3G/8lBsU72Ag2ttQRo7A5wiLfCEFootLOUu5kej6FDAejM
         C9DMYB2m36D6e0Nm5N8G/O9W9JI/BgsELy7yZ+GjwZFpDQoOokO7mR3tA1cyC1dvqmw8
         XxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742438417; x=1743043217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+Xiz6rkBGzGCx6+zJzw9Yhwx3PtKxS1SxbWRWfwpXc=;
        b=wppg3pHKb2/fBfPJFMMk80swiN0DCkd/WMJLBVFFLsCWs26YUNBmHnT9LnSLOk3NqM
         AkgQ+3GB/QoZRmjla0xYqy2F9mC0ULxs8r/riupskF6RBTicmcggE04Pur0stW6NVJcP
         GhOiCWAhAZJ9w3pOgUNudYspQVXshz25qXfX+BEenasArgjWPzcfPM6kL75Poep8bjjM
         jK+e31Ne5YcCgFCZSaUU7iwwzH+1iw1L4yfHFFNrzfcWjX1C7FBVhYgYYRffnReEAhdp
         GjCbL7WjPgjVe/IH+6HjBkIM6oyj02q+Z45qGN2uBSlBCDv4IiRZYpkbxepIBFu6h9ME
         9s/g==
X-Forwarded-Encrypted: i=1; AJvYcCUtIwVtHPt6Y5JTran79BkErV5RjsGyNWJlOHan2LE5a49UfqNsTXRlm0Y2q8OBGskZK7xwYQOQNSdpaTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqINDDdMpwktN6wVaOSMAHn+/UydgycPlBVCQHC3fETjo2tfU
	NoHXiluOtyZ852RBx0eus3xagAcDhDRRkzK/kNxWBjJd2qZR+oINzfzmcdbfdCM=
X-Gm-Gg: ASbGncv3XJs5XG2OkIKVt7dePQRCH6qYXwINhfiQc7V94eQ6MFZoGSKq8+1Kfb/LcTk
	rlVik/SIBXkAFzJWNBYDbPymSMz5Wo7tx3JWjxnKpuQsjMMIVbp9iKlTOnqUWkjSkslAXl99VI7
	vQVNHzyDtkyJ3tz9zIVDapHVFJCRgBPDPnvKf+7uSncaudIf8Ao5l8Uh0h2khuFOoLhrXqOmd92
	9IRnvkH88N4gyzpmRcm1wIkP4R2jzLEPd3fpCJiRM/ipcrbEH9z01NlKN3HBUBDAVk++Hpx3nGe
	3z5cXNr5fjtRIcvHAmGVLToI+pKGekIFzAsLYg/Xr1R6ay4/FmjK7lTj2tvdcHxqKk0IdmPzupn
	cPtLY6nveTWy7c+x8nTEWmu8NHST6FlG5
X-Google-Smtp-Source: AGHT+IECui50SakZ7C7j7snjuNIthZesTdZJUHAg91VJ4PC9grwsGDIy6VwaTrETU0CHVsqqi/YDqw==
X-Received: by 2002:a05:620a:469e:b0:7c5:6ba5:dd40 with SMTP id af79cd13be357-7c5a83967e9mr732231285a.17.1742438416577;
        Wed, 19 Mar 2025 19:40:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (249.60.48.34.bc.googleusercontent.com. [34.48.60.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4dd9fsm947815985a.4.2025.03.19.19.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:40:15 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: changyuanl@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	jgowans@amazon.com,
	jgg@nvidia.com
Subject: [RFC v1 1/3] luo: Live Update Orchestrator
Date: Thu, 20 Mar 2025 02:40:09 +0000
Message-ID: <20250320024011.2995837-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces the Live Update Orchestrator (LUO), a new kernel subsystem
designed to facilitate live updates. Live update is a method to reboot
the kernel while attempting to keep selected devices alive across the
reboot boundary, minimizing downtime.

The primary use case is cloud environments, allowing hypervisor updates
without fully disrupting running virtual machines. VMs can be suspended
while the hypervisor kernel reboots, and devices attached to these VM
are kept operational by the LUO.

Features introduced:

- Core orchestration logic for managing the live update process.
- A state machine (NORMAL, PREPARED, UPDATED, *_FAILED) to track
  the progress of live updates.
- Notifier chains for subsystems (device layer, interrupts, KVM, IOMMU,
  etc.) to register callbacks for different live update events:
    - LIVEUPDATE_PREPARE: Prepare for reboot (before blackout).
    - LIVEUPDATE_REBOOT: Final serialization before kexec (blackout).
    - LIVEUPDATE_FINISH: Cleanup after update (after blackout).
    - LIVEUPDATE_CANCEL: Rollback actions on failure or user request.
- A sysfs interface (/sys/kernel/liveupdate/) for user-space control:
    - `prepare`: Initiate preparation (write 1) or reset (write 0).
    - `finish`: Finalize update in new kernel (write 1).
    - `cancel`: Abort ongoing preparation or reboot (write 1).
    - `reset`: Force state back to normal (write 1).
    - `state`: Read-only view of the current LUO state.
    - `enabled`: Read-only view of whether live update is enabled.
- Integration with KHO to pass orchestrator state to the new kernel.
- Version checking during startup of the new kernel to ensure
  compatibility with the previous kernel's live update state.

This infrastructure allows various kernel subsystems to coordinate and
participate in the live update process, serializing and restoring device
state across a kernel reboot.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../ABI/testing/sysfs-kernel-liveupdate       |  51 ++
 Documentation/admin-guide/index.rst           |   1 +
 Documentation/admin-guide/liveupdate.rst      |  23 +
 MAINTAINERS                                   |  10 +
 include/linux/liveupdate.h                    | 238 ++++++
 init/Kconfig                                  |   2 +
 kernel/Kconfig.liveupdate                     |  19 +
 kernel/Makefile                               |   1 +
 kernel/liveupdate.c                           | 749 ++++++++++++++++++
 kernel/reboot.c                               |   4 +
 10 files changed, 1098 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-liveupdate
 create mode 100644 Documentation/admin-guide/liveupdate.rst
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 kernel/Kconfig.liveupdate
 create mode 100644 kernel/liveupdate.c

diff --git a/Documentation/ABI/testing/sysfs-kernel-liveupdate b/Documentation/ABI/testing/sysfs-kernel-liveupdate
new file mode 100644
index 000000000000..92f4f745163f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-liveupdate
@@ -0,0 +1,51 @@
+What:		/sys/kernel/liveupdate/
+Date:		March 2025
+KernelVersion:	6.14.0
+Contact:	pasha.tatashin@soleen.com
+Description:	Interface to control and query live update orchestrator. Live
+		update is a feature that allows to reboot kernel without
+		resetting selected devices. This is needed, for example,  in
+		order to do a quick hypervisor update without terminating
+		virtual machines.
+
+What:		/sys/kernel/liveupdate/state
+Date:		March 2025
+KernelVersion:	6.14.0
+Contact:	pasha.tatashin@soleen.com
+Description:	Read only file that contains the current live update state.
+
+		The state can be one of the following:
+
+		normal: no live update in progress.
+		prepared: live update is prepared for reboot.
+		updated: rebooted to a new kernel, live update can be finished
+		by echoing 1 into finish file.
+
+What:		/sys/kernel/liveupdate/prepare
+Date:		March 2025
+KernelVersion:	6.14.0
+Contact:	pasha.tatashin@soleen.com
+Description:	Is a write-only file that notifies the devices about upcoming
+		live update reboot or cancels it.
+		Writing '1' to this file changes the live update state from
+		"normal" to "prepared".
+		Internally, all drivers that implement liveupdate callback are
+		notified by calling this function with LIVEUPDATE_PREPARE
+		parameter. If any liveupdate() callback fails, the state is not
+		changed, and all already notiified subsystems are notified via
+		liveupdate(LIVEUPDATE_CANCEL) prior to returning to usersapce.
+		Writing '0' to this file change the live update state from
+		"prepared" back to "normal" state by notifying all registered
+		subsystems via liveupdate(LIVEUPDATE_CANCEL) callback..
+
+What:		/sys/kernel/liveupdate/finish
+Date:		March 2025
+KernelVersion:	6.14.0
+Contact:	pasha.tatashin@soleen.com
+Description:	Is a write-only file that notifies the devices that live update
+		has been completed.
+		Writing '1' to this file changes the live update state from
+		"updated" to "normal" state.
+		Internally, all drivers that implement liveupdate callback are
+		notified by calling this function with LIVEUPDATE_FINISH
+		parameter.
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index c8af32a8f800..049f18034e10 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -95,6 +95,7 @@ likely to be of interest on almost any system.
    cgroup-v2
    cgroup-v1/index
    cpu-load
+   liveupdate
    mm/index
    module-signing
    namespaces/index
diff --git a/Documentation/admin-guide/liveupdate.rst b/Documentation/admin-guide/liveupdate.rst
new file mode 100644
index 000000000000..f66e4e13f50b
--- /dev/null
+++ b/Documentation/admin-guide/liveupdate.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+Live Update
+===========
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+Live Update Orchestrator (LUO)
+==============================
+.. kernel-doc:: kernel/liveupdate.c
+   :doc: Live Update Orchestrator (LUO)
+
+Public API
+==========
+.. kernel-doc:: include/linux/liveupdate.h
+
+.. kernel-doc:: kernel/liveupdate.c
+   :export:
+
+Internal API
+============
+.. kernel-doc:: kernel/liveupdate.c
+   :internal:
diff --git a/MAINTAINERS b/MAINTAINERS
index d0df0b380e34..32257bde9647 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13481,6 +13481,16 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
+F:	Documentation/admin-guide/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	kernel/Kconfig.liveupdate
+F:	kernel/liveupdate.c
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
new file mode 100644
index 000000000000..66c4e9d28a4a
--- /dev/null
+++ b/include/linux/liveupdate.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef _LINUX_LIVEUPDATE_H
+#define _LINUX_LIVEUPDATE_H
+
+#include <linux/compiler.h>
+#include <linux/notifier.h>
+
+/**
+ * enum liveupdate_event - Events that trigger live update callbacks.
+ * @LIVEUPDATE_PREPARE: Sent when the live update process is initiated via
+ *                      a sysfs by writing '1' into
+ *                      ``/sys/kernel/liveupdate/prepare``. This happens
+ *                      *before* the blackout window. Subsystems should prepare
+ *                      for an upcoming reboot by serializing their states.
+ *                      However, it must be considered that user applications,
+ *                      e.g. virtual machines are still running during this
+ *                      phase.
+ * @LIVEUPDATE_REBOOT:  Sent from the reboot() syscall, when the old kernel is
+ *                      on its way out. This is the final opportunity for
+ *                      subsystems to save any state that must persist across
+ *                      the reboot. Callbacks for this event are part of the
+ *                      blackout window and must be fast.
+ * @LIVEUPDATE_FINISH:  Sent in the newly booted kernel after a successful live
+ *                      update and *after* the blackout window. This event is
+ *                      initiated by writing '1' into
+ *                      ``/sys/kernel/liveupdate/prepare``. Subsystems should
+ *                      perform any final cleanup during this phase. This phase
+ *                      also provides an opportunity to clean up devices that
+ *                      were preserved but never explicitly reclaimed during the
+ *                      live update process. State restoration should have
+ *                      already occurred before this event. Callbacks for this
+ *                      event must not fail. The completion of this call
+ *                      transitions the machine from ``updated`` to ``normal``
+ *                      state.
+ * @LIVEUPDATE_CANCEL:  Sent if the LIVEUPDATE_PREPARE or LIVEUPDATE_REBOOT
+ *                      stage fails. Subsystems should revert any actions taken
+ *                      during the corresponding prepare phase. Callbacks for
+ *                      this event must not fail.
+ *
+ * These events represent the different stages and actions within the live
+ * update process that subsystems (like device drivers and bus drivers)
+ * need to be aware of to correctly serialize and restore their state.
+ *
+ */
+enum liveupdate_event {
+	LIVEUPDATE_PREPARE,
+	LIVEUPDATE_REBOOT,
+	LIVEUPDATE_FINISH,
+	LIVEUPDATE_CANCEL,
+};
+
+/**
+ * enum liveupdate_state - Defines the possible states of the live update
+ * orchestrator.
+ * @LIVEUPDATE_STATE_NORMAL:         Default state, no live update in progress.
+ * @LIVEUPDATE_STATE_PREPARED:       Live update is prepared for reboot; the
+ *                                   LIVEUPDATE_PREPARE callbacks have completed
+ *                                   successfully.
+ *                                   Devices might operate in a limited state
+ *                                   for example the participating devices might
+ *                                   not be allowed to unbind, and also the
+ *                                   setting up of new DMA mappings might be
+ *                                   disabled in this state.
+ * @LIVEUPDATE_STATE_UPDATED:        The system has rebooted into a new kernel
+ *                                   via live update the system is now running
+ *                                   the new kernel, awaiting the finish stage.
+ *
+ * These states track the progress and outcome of a live update operation.
+ */
+enum liveupdate_state  {
+	LIVEUPDATE_STATE_NORMAL,
+	LIVEUPDATE_STATE_PREPARED,
+	LIVEUPDATE_STATE_UPDATED,
+};
+
+/**
+ * enum liveupdate_cb_priority - Priority levels for live update notifiers.
+ * @LIVEUPDATE_CB_PRIO_BEFORE_DEVICES: Callbacks with this priority will be
+ *                                     executed before the device layer
+ *                                     callbacks.
+ * @LIVEUPDATE_CB_PRIO_WITH_DEVICES:   Callbacks with this priority will be
+ *                                     executed at the same time as the device
+ *                                     layer callbacks.
+ * @LIVEUPDATE_CB_PRIO_AFTER_DEVICES:  Callbacks with this priority will be
+ *                                     executed after the device layer
+ *                                     callbacks.
+ *
+ * This enum defines the priority levels for notifier callbacks registered with
+ * the live update orchestrator. It allows subsystems to control the order in
+ * which their callbacks are executed relative to other subsystems during the
+ * live update process.
+ */
+enum liveupdate_cb_priority {
+	LIVEUPDATE_CB_PRIO_BEFORE_DEVICES,
+	LIVEUPDATE_CB_PRIO_WITH_DEVICES,
+	LIVEUPDATE_CB_PRIO_AFTER_DEVICES,
+};
+
+#ifdef CONFIG_LIVEUPDATE
+
+/* Called during reboot to notify subsystems to complete serialization */
+int liveupdate_reboot(void);
+
+/*
+ * Return true if machine is in updated state (i.e. live update boot in
+ * progress)
+ */
+bool liveupdate_state_updated(void);
+
+/*
+ * Return true if machine is in normal state (i.e. no live update in progress).
+ */
+bool liveupdate_state_normal(void);
+
+/* Protect live update state with a rwsem, take it as a reader */
+int liveupdate_read_state_enter_killable(void);
+void liveupdate_read_state_enter(void);
+void liveupdate_read_state_exit(void);
+
+/* Return true if live update orchestrator is enabled */
+bool liveupdate_enabled(void);
+
+int liveupdate_register_notifier(struct notifier_block *nb);
+int liveupdate_unregister_notifier(struct notifier_block *nb);
+
+/**
+ * LIVEUPDATE_DECLARE_NOTIFIER - Declare a live update notifier with default
+ * structure.
+ * @_name: A base name used to generate the names of the notifier block
+ * (e.g., ``_name##_liveupdate_notifier_block``) and the callback function
+ * (e.g., ``_name##_liveupdate``).
+ * @_priority: The priority of the notifier, specified using the
+ * ``enum liveupdate_cb_priority`` values
+ * (e.g., ``LIVEUPDATE_CB_PRIO_BEFORE_DEVICES``).
+ *
+ * This macro declares a static struct notifier_block and a corresponding
+ * notifier callback function for use with the live update orchestrator.
+ * It simplifies the process by automatically handling the dispatching of
+ * live update events to separate handler functions for prepare, reboot,
+ * finish, and cancel.
+ *
+ * This macro expects the following functions to be defined:
+ *
+ * ``_name##_liveupdate_prepare()``:  Called on LIVEUPDATE_PREPARE.
+ * ``_name##_liveupdate_reboot()``:   Called on LIVEUPDATE_REBOOT.
+ * ``_name##_liveupdate_finish()``:   Called on LIVEUPDATE_FINISH.
+ * ``_name##_liveupdate_cancel()``:   Called on LIVEUPDATE_CANCEL.
+ *
+ * The generated callback function handles the switch statement for the
+ * different live update events and calls the appropriate handler function.
+ * It also includes warnings if the finish or cancel handlers return an error.
+ *
+ * For example, declartion can look like this:
+ *
+ * ``static int foo_liveupdate_prepare(void) { ... }``
+ *
+ * ``static int foo_liveupdate_reboot(void) { ... }``
+ *
+ * ``static int foo_liveupdate_finish(void) { ... }``
+ *
+ * ``static int foo_liveupdate_cancel(void) { ... }``
+ *
+ * ``LIVEUPDATE_DECLARE_NOTIFIER(foo, LIVEUPDATE_CB_PRIO_WITH_DEVICES);``
+ *
+ */
+#define LIVEUPDATE_DECLARE_NOTIFIER(_name, _priority)			\
+static int _name##_liveupdate(struct notifier_block *nb,		\
+			      unsigned long action,			\
+			      void *data)				\
+{									\
+	enum liveupdate_event event = (enum liveupdate_event)action;	\
+	int err = 0;							\
+	int rv;								\
+									\
+	switch (event) {						\
+	case LIVEUPDATE_PREPARE:					\
+		err = _name##_liveupdate_prepare();			\
+		break;							\
+	case LIVEUPDATE_REBOOT:						\
+		err = _name##_liveupdate_reboot();			\
+		break;							\
+	case LIVEUPDATE_FINISH:						\
+		rv = _name##_liveupdate_finish();			\
+		WARN_ONCE(rv, "finish failed[%d]\n", rv);		\
+		break;							\
+	case LIVEUPDATE_CANCEL:						\
+		rv = _name##_liveupdate_cancel();			\
+		WARN_ONCE(rv, "cancel failed[%d]\n", rv);		\
+		break;							\
+	default:							\
+		WARN_ONCE(1, "unexpected event[%d]\n", event);		\
+		return NOTIFY_DONE;					\
+	}								\
+									\
+	return notifier_from_errno(err);				\
+}									\
+									\
+static struct notifier_block _name##_liveupdate_notifier_block = {	\
+	.notifier_call = _name##_liveupdate,				\
+	.priority = _priority,						\
+}
+
+/**
+ * LIVEUPDATE_REGISTER_NOTIFIER - Register a live update notifier declared with
+ * the macro.
+ * @_name: The base name used when declaring the notifier with
+ * ``LIVEUPDATE_DECLARE_NOTIFIER``.
+ *
+ * This macro simplifies the registration of a notifier block that was
+ * declared using the LIVEUPDATE_DECLARE_NOTIFIER macro.
+ */
+#define LIVEUPDATE_REGISTER_NOTIFIER(_name)				\
+	liveupdate_register_notifier(&_name##_liveupdate_notifier_block)
+
+#else /* CONFIG_LIVEUPDATE */
+
+static inline int liveupdate_reboot(void)
+{
+	return 0;
+}
+
+static inline int liveupdate_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int liveupdate_unregister_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+#endif /* CONFIG_LIVEUPDATE */
+#endif /* _LINUX_LIVEUPDATE_H */
diff --git a/init/Kconfig b/init/Kconfig
index 324c2886b2ea..9800b8301fa2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2079,3 +2079,5 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 # <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
 	def_bool n
+
+source "kernel/Kconfig.liveupdate"
diff --git a/kernel/Kconfig.liveupdate b/kernel/Kconfig.liveupdate
new file mode 100644
index 000000000000..8468591fac4a
--- /dev/null
+++ b/kernel/Kconfig.liveupdate
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Live update configs
+#
+
+config ARCH_SUPPORTS_LIVEUPDATE
+	bool
+
+config LIVEUPDATE
+	bool "Enable kernel live update"
+	depends on ARCH_SUPPORTS_LIVEUPDATE
+	depends on KEXEC_HANDOVER
+	help
+	  Enables support for Live Update, a feature that allows to
+	  keep devices alive across the transition from the old kernel
+	  to the new kernel. Live Update designed to minimize downtime
+	  during kernel updates
+
+	  If unsure, say N.
diff --git a/kernel/Makefile b/kernel/Makefile
index cef5377c25cd..18c65f71ddb5 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
 obj-$(CONFIG_TRACEPOINTS) += tracepoint.o
 obj-$(CONFIG_LATENCYTOP) += latencytop.o
+obj-$(CONFIG_LIVEUPDATE) += liveupdate.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace/
 obj-$(CONFIG_TRACING) += trace/
 obj-$(CONFIG_TRACE_CLOCK) += trace/
diff --git a/kernel/liveupdate.c b/kernel/liveupdate.c
new file mode 100644
index 000000000000..64b5d4d4b6c4
--- /dev/null
+++ b/kernel/liveupdate.c
@@ -0,0 +1,749 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: Live Update Orchestrator (LUO)
+ *
+ * Live Update is a specialized reboot process where selected devices are
+ * kept operational across a kernel transition. For these devices, DMA and
+ * interrupt activity may continue uninterrupted during the kernel reboot.
+ *
+ * The primary use case is in cloud environments, allowing hypervisor updates
+ * without disrupting running virtual machines. During a live update, VMs can be
+ * suspended (with their state preserved in memory), while the hypervisor kernel
+ * reboots. Devices attached to these VMs (e.g., NICs, block devices) are kept
+ * operational by the LUO during the hypervisor reboot, allowing the VMs to be
+ * quickly resumed on the new kernel.
+ *
+ * Various kernel subsystems register with the Live Update Orchestrator to
+ * participate in the live update process. These subsystems are notified at
+ * different stages of the live update sequence, allowing them to serialize
+ * device state before the reboot and restore it afterwards. Examples include
+ * the device layer, interrupt controllers, KVM, IOMMU, and specific device
+ * drivers.
+ *
+ * The core of LUO is a state machine that tracks the progress of a live update,
+ * along with a callback API that allows other kernel subsystems to participate
+ * in the process. Example subsystems that can hook into LUO include: kvm,
+ * iommu, interrupts, Documentation/driver-api/liveupdate.rst, participating
+ * filesystems, and mm.
+ *
+ * LUO uses KHO to transfer memory state from Old Kernel to the New Kernel.
+ *
+ * LUO can be controlled through sysfs interface. It provides the following
+ * files under: ``/sys/kernel/liveupdate/{state, prepare, cancel}``
+ *
+ * The ``state`` file can contain the following values:
+ *
+ * ``normal``
+ *   The system is operating normally, and no live update is in progress.
+ *   This is the initial state.
+ * ``prepared``
+ *   The system has begun preparing for a live update. This state is reached
+ *   after subsystems have successfully responded to the ``LIVEUPDATE_PREPARE``
+ *   callback. It indicates that initial preparation is done, but it does not
+ *   necessarily mean all state has been serialized; subsystems can save more
+ *   state during the subsequent ``LIVEUPDATE_REBOOT`` callback.
+ * ``updated``
+ *   The new kernel has successfully taken over, and any suspended operations
+ *   are resumed. However, the system has not yet fully transitioned back to
+ *   a normal operational state; this happens after the ``LIVEUPDATE_FINISH``
+ *   callback is invoked.
+ *
+ * The state machine ensures that operations are performed in the correct
+ * sequence and provides a mechanism to track and recover from potential
+ * failures, and select devices and subsystems that should participate in
+ * live update sequence.
+ *
+ */
+
+ #undef pr_fmt
+ #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#undef pr_fmt
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/sysfs.h>
+#include <linux/string.h>
+#include <linux/rwsem.h>
+#include <linux/err.h>
+#include <linux/liveupdate.h>
+#include <linux/cpufreq.h>
+#include <linux/kexec_handover.h>
+
+#define LUO_KHO_NODE_NAME		"liveupdate_orchestrator"
+#define LUO_KHO_VERSION_PROP_NAME	"version"
+#define LUO_VERSION_MAJOR		1
+#define LUO_VERSION_MINOR		0
+
+/* 'version' property */
+struct luo_kho_version_prop {
+	u32 major;
+	u32 minor;
+};
+
+static const struct luo_kho_version_prop luo_version = {
+	.major = LUO_VERSION_MAJOR,
+	.minor = LUO_VERSION_MINOR,
+};
+
+static struct kho_node luo_node = KHO_NODE_INIT;
+static enum liveupdate_state luo_state;
+static DECLARE_RWSEM(luo_state_rwsem);
+static BLOCKING_NOTIFIER_HEAD(luo_notify_list);
+
+static const char *const luo_event_str[] = {
+	"PREPARE",
+	"REBOOT",
+	"FINISH",
+	"CANCEL",
+};
+
+static const char *const luo_state_str[] = {
+	"normal",
+	"prepared",
+	"updated",
+};
+
+static bool luo_enabled;
+static bool luo_sysfs_initialized;
+
+static int __init early_liveupdate_param(char *buf)
+{
+	return kstrtobool(buf, &luo_enabled);
+}
+
+early_param("liveupdate", early_liveupdate_param);
+
+/* Return true if the current state is equal to the provided state */
+#define IS_STATE(state) (READ_ONCE(luo_state) == (state))
+
+/* Get the current state as a string */
+#define LUO_STATE_STR luo_state_str[READ_ONCE(luo_state)]
+
+static void __luo_set_state(enum liveupdate_state state)
+{
+	WRITE_ONCE(luo_state, state);
+	if (luo_sysfs_initialized)
+		sysfs_notify(kernel_kobj, NULL, "state");
+}
+
+static inline void luo_set_state(enum liveupdate_state state)
+{
+	pr_info("Switched from [%s] to [%s] state\n",
+		LUO_STATE_STR, luo_state_str[state]);
+	__luo_set_state(state);
+}
+
+/* Show the current live update state */
+static ssize_t state_show(struct kobject *kobj,
+			  struct kobj_attribute *attr,
+			  char *buf)
+{
+	return sysfs_emit(buf, "%s\n", LUO_STATE_STR);
+}
+
+/**
+ * luo_notify - Call registered notifiers for a live update event.
+ * @event: The live update event to notify subsystems about.
+ *
+ * This function is notifying registered subsystems about the specified event.
+ *
+ * For ``LIVEUPDATE_PREPARE`` event, it uses
+ * ``blocking_notifier_call_chain_robust()`` to ensure that if a notifier
+ * callback fails, a corresponding ``LIVEUPDATE_CANCEL`` notification is sent
+ * to already-notified subsystems, allowing for a rollback.
+ *
+ * For ``LIVEUPDATE_REBOOT`` event, it uses ``blocking_notifier_call_chain()``
+ * and if it returns a failure, cancels the operation via calling
+ * ``lou_notify(LIVEUPDATE_CANCEL)`` to notify every subsystem to transition
+ * back to ``normal`` state.
+ *
+ * For ``LIVEUPDATE_FINISH`` and ``LIVEUPDATE_CANCEL`` events, it uses the
+ * standard ``blocking_notifier_call_chain()``. These events are expected not to
+ * fail, and a warning is printed if they do.
+ *
+ * @return 0 on success, or the negative error code returned by the failing
+ * notifier callback (for ``LIVEUPDATE_PREPARE`` and ``LIVEUPDATE_REBOOT``), or
+ * 0 for ``LIVEUPDATE_FINISH`` and ``LIVEUPDATE_CANCEL`` even if a warning was
+ * printed due to a callback failure.
+ */
+static int luo_notify(enum liveupdate_event event)
+{
+	int ret;
+
+	if (event == LIVEUPDATE_PREPARE) {
+		ret = blocking_notifier_call_chain_robust(&luo_notify_list,
+							  LIVEUPDATE_PREPARE,
+							  LIVEUPDATE_CANCEL,
+							  NULL);
+	} else if (event == LIVEUPDATE_REBOOT) {
+		ret = blocking_notifier_call_chain(&luo_notify_list,
+						   LIVEUPDATE_REBOOT,
+						   NULL);
+		/*
+		 * For LIVEUPDATE_REBOOT do CANCEL for everyone, so even
+		 * prepared subsystems return back to the normal state
+		 */
+		if (notifier_to_errno(ret))
+			lou_notify(LIVEUPDATE_CANCEL)
+	} else {
+		ret = blocking_notifier_call_chain(&luo_notify_list,
+						   event,
+						   NULL);
+		/* Cancel and finish must not fail, warn and return success */
+		WARN_ONCE(notifier_to_errno(ret), "Callback failed event: %s [%d]\n",
+			  luo_event_str[event], notifier_to_errno(ret));
+		ret = 0;
+	}
+
+	return notifier_to_errno(ret);
+}
+
+/**
+ * luo_prepare - Initiate the live update preparation phase.
+ *
+ * This function is called to begin the live update process. It attempts to
+ * transition the luo to the ``LIVEUPDATE_STATE_PREPARED`` state.
+ *
+ * It first acquires the write lock for the orchestrator state. Then, it checks
+ * if the current state is ``LIVEUPDATE_STATE_NORMAL``. If not, it returns an
+ * error. If the state is normal, it triggers the ``LIVEUPDATE_PREPARE``
+ * notifier chain.
+ *
+ * If the notifier chain completes successfully, the orchestrator state is set
+ * to ``LIVEUPDATE_STATE_PREPARED``. If any notifier callback fails a
+ * ``LIVEUPDATE_CANCEL`` notification is sent to roll back any actions.
+ *
+ * @return 0 on success, ``-EAGAIN`` if the state change was cancelled by the
+ * user while waiting for the lock, ``-EINVAL`` if the orchestrator is not in
+ * the normal state, or a negative error code returned by the notifier chain.
+ */
+static int luo_prepare(void)
+{
+	int ret;
+
+	if (down_write_killable(&luo_state_rwsem)) {
+		pr_warn(" %s, change state canceled by user\n", __func__);
+		return -EAGAIN;
+	}
+
+	if (!IS_STATE(LIVEUPDATE_STATE_NORMAL)) {
+		pr_warn("Can't switch to [%s] from [%s] state\n",
+			luo_state_str[LIVEUPDATE_STATE_PREPARED],
+			LUO_STATE_STR);
+		up_write(&luo_state_rwsem);
+
+		return -EINVAL;
+	}
+
+	ret = luo_notify(LIVEUPDATE_PREPARE);
+	if (!ret)
+		luo_set_state(LIVEUPDATE_STATE_PREPARED);
+
+	up_write(&luo_state_rwsem);
+
+	return ret;
+}
+
+/**
+ * luo_finish - Finalize the live update process in the new kernel.
+ *
+ * This function is called  after a successful live update reboot into a new
+ * kernel, once the new kernel is ready to transition to the normal operational
+ * state. It signals the completion of the live update sequence to subsystems.
+ *
+ * It first attempts to acquire the write lock for the orchestrator state.
+ *
+ * Then, it checks if the system is in the ``LIVEUPDATE_STATE_UPDATED`` state.
+ * If not, it logs a warning and returns ``-EINVAL``.
+ *
+ * If the state is correct, it triggers the ``LIVEUPDATE_FINISH`` notifier
+ * chain. Note that the return value of the notifier is intentionally ignored as
+ * finish callbacks must not fail. Finally, the orchestrator state is
+ * transitioned back to ``LIVEUPDATE_STATE_NORMAL``, indicating the end of the
+ * live update process.
+ *
+ * @return 0 on success, ``-EAGAIN`` if the state change was cancelled by the
+ * user while waiting for the lock, or ``-EINVAL`` if the orchestrator is not in
+ * the updated state.
+ */
+static int luo_finish(void)
+{
+	if (down_write_killable(&luo_state_rwsem)) {
+		pr_warn(" %s, change state canceled by user\n", __func__);
+		return -EAGAIN;
+	}
+
+	if (!IS_STATE(LIVEUPDATE_STATE_UPDATED)) {
+		pr_warn("Can't switch to [%s] from [%s] state\n",
+			luo_state_str[LIVEUPDATE_STATE_NORMAL],
+			LUO_STATE_STR);
+		up_write(&luo_state_rwsem);
+
+		return -EINVAL;
+	}
+
+	(void)luo_notify(LIVEUPDATE_FINISH);
+	luo_set_state(LIVEUPDATE_STATE_NORMAL);
+
+	up_write(&luo_state_rwsem);
+
+	return 0;
+}
+
+/**
+ * luo_cancel - Cancel the ongoing live update preparation or reboot states.
+ *
+ * This function is called to abort a live update that is currently in the
+ * ``LIVEUPDATE_STATE_PREPARED`` state. It can be triggered either
+ * programmatically or via the sysfs interface.
+ *
+ * If the state is correct, it triggers the ``LIVEUPDATE_CANCEL`` notifier chain
+ * to allow subsystems to undo any actions performed during the prepare or
+ * reboot phase. Finally, the orchestrator state is transitioned back to
+ * ``LIVEUPDATE_STATE_NORMAL``.
+ *
+ * @return 0 on success, or ``-EAGAIN`` if the state change was cancelled by the
+ * user while waiting for the lock.
+ */
+static int luo_cancel(void)
+{
+	if (down_write_killable(&luo_state_rwsem)) {
+		pr_warn(" %s, change state canceled by user\n", __func__);
+		return -EAGAIN;
+	}
+
+	if (!IS_STATE(LIVEUPDATE_STATE_PREPARED)) {
+		pr_warn("Can't switch to [%s] from [%s] state\n",
+			luo_state_str[LIVEUPDATE_STATE_NORMAL],
+			LUO_STATE_STR);
+		up_write(&luo_state_rwsem);
+
+		return -EINVAL;
+	}
+
+	(void)luo_notify(LIVEUPDATE_CANCEL);
+	luo_set_state(LIVEUPDATE_STATE_NORMAL);
+
+	up_write(&luo_state_rwsem);
+
+	return 0;
+}
+
+/**
+ * prepare_store - store method for starting live update prepare state or go
+ * back to normal from a prepared state.
+ * @kobj: The kobject associated with luo.
+ * @attr: The sysfs attribute
+ * @buf: The buffer containing the value written by the user.
+ * @count: The number of bytes written.
+ *
+ * This function is the store method for the 'prepare' file under the
+ * 'liveupdate' sysfs directory.
+ *
+ * Writing "1" to this attribute will trigger the luo_prepare() function,
+ * attempting to start the live update preparation phase.
+ *
+ * Writing "0" to this attribute will trigger the luo_cancel() function,
+ * attempting to cancel the orchestrator to the normal state.
+ *
+ * @return The number of bytes processed on success, or a negative error code
+ * if the input is invalid or if the underlying functions fail.
+ */
+static ssize_t prepare_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf,
+			     size_t count)
+{
+	ssize_t ret;
+	long val;
+
+	if (kstrtol(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val != 1 && val != 0)
+		return -EINVAL;
+
+	if (val)
+		ret = luo_prepare();
+	else
+		ret = luo_cancel();
+
+	if (!ret)
+		ret = count;
+
+	return ret;
+}
+
+/**
+ * finish_store - store method for finalizing a live update.
+ * @kobj: The kobject associated with the luo.
+ * @attr: The sysfs attribute
+ * @buf: The buffer containing the value written by the user.
+ * @count: The number of bytes written.
+ *
+ * This function is the store method for the ``finish`` file under the
+ * ``liveupdate`` sysfs directory.
+ *
+ * Writing "1" to this attribute will trigger the luo_finish() function,
+ * attempting to finalize the live update process in the new kernel and
+ * transition to the normal state.
+ *
+ * @return The number of bytes processed on success, or a negative error code
+ * if the input is invalid or if luo_finish() fails.
+ */
+static ssize_t finish_store(struct kobject *kobj,
+			    struct kobj_attribute *attr,
+			    const char *buf,
+			    size_t count)
+{
+	ssize_t ret;
+	long val;
+
+	if (kstrtol(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val != 1)
+		return -EINVAL;
+
+	ret = luo_finish();
+	if (!ret)
+		ret = count;
+
+	return ret;
+}
+
+static struct kobj_attribute state_attribute = __ATTR_RO(state);
+static struct kobj_attribute prepare_attribute = __ATTR_WO(prepare);
+static struct kobj_attribute finish_attribute = __ATTR_WO(finish);
+
+static struct attribute *luo_attrs[] = {
+	&state_attribute.attr,
+	&prepare_attribute.attr,
+	&finish_attribute.attr,
+	NULL,
+};
+
+static struct attribute_group luo_attr_group = {
+	.attrs = luo_attrs,
+	.name = "liveupdate",
+};
+
+/**
+ * luo_init - Initialize the Live Update Orchestrator sysfs interface.
+ *
+ * This function is called during the kernel's late initialization phase
+ * (``late_initcall``). It is responsible for creating the sysfs interface
+ * that allows user-space to interact with the Live Update Orchestrator.
+ *
+ * If the "liveupdate" feature is enabled (checked via luo_enabled()), this
+ * function creates a sysfs directory named ``liveupdate`` under the kernel's
+ * top-level sysfs directory (``/sys/kernel/``).
+ *
+ * It then creates the following sysfs attribute files within the
+ * ``/sys/kernel/liveupdate/`` directory:
+ *
+ * - ``prepare``: Writing '1' initiates preparation, '0' cancels.
+ * - ``finish``:  Writing '1' finalizes the update in the new kernel.
+ * - ``state``:   Read-only file displaying the current orchestrator state.
+ *
+ * @return 0 on success, or a negative error code if sysfs directory or
+ * attribute creation fails.
+ */
+static int __init luo_init(void)
+{
+	int ret;
+
+	if (!luo_enabled || !kho_is_enabled()) {
+		pr_info("disabled by user\n");
+		luo_enabled = false;
+
+		return 0;
+	}
+
+	ret = sysfs_create_group(kernel_kobj, &luo_attr_group);
+	if (ret)
+		pr_err("Failed to create group\n");
+
+	luo_sysfs_initialized = true;
+	pr_info("Initialized\n");
+
+	return ret;
+}
+subsys_initcall(luo_init);
+
+/**
+ * luo_startup - Initialize the Live Update Orchestrator on live update boot.
+ *
+ * This function is called during the kernel's early initialization phase
+ * (early_initcall). Its primary role is to detect if the system is booting
+ * as part of a live update sequence by checking for the presence of a
+ * luo node in the kho tree.
+ *
+ * If a kho node named ``liveupdate_orchestrator`` is found, the function
+ * extracts the version information from the previous kernel. It then performs
+ * the following checks to ensure a safe continuation of the live update:
+ *
+ * 1. Verifies the size of the version property.
+ * 2. Compares the major version and checks if the minor version of the
+ *    previous orchestrator is compatible with the current one. If a mismatch
+ *    is detected, the system panics to prevent potential memory corruption.
+ * 3. Checks if the ``liveupdate`` kernel command-line parameter has enabled
+ *    the feature. If the kho node exists but the feature is disabled, the
+ *    system panics.
+ *
+ * If all checks pass, the orchestrator state is set to
+ * ``LIVEUPDATE_STATE_UPDATED``.
+ *
+ * @return 0 always.
+ */
+static int __init luo_startup(void)
+{
+	enum liveupdate_state state = LIVEUPDATE_STATE_NORMAL;
+	const struct luo_kho_version_prop *p;
+	struct kho_in_node luo_node;
+	int len;
+
+	if (kho_get_node(NULL, LUO_KHO_NODE_NAME, &luo_node) < 0)
+		goto no_liveupdate;
+
+	p = kho_get_prop(&luo_node, LUO_KHO_VERSION_PROP_NAME, &len);
+	if (len != sizeof(struct luo_kho_version_prop)) {
+		panic("Unexcpected version property size, excpected[%ld] found[%d]\n",
+		      sizeof(struct luo_kho_version_prop), len);
+	}
+
+	/*
+	 * Panic if feature is disabled or version mismatch, we do not want
+	 * memory corruptions due to DMA or interrupt tables activity.
+	 */
+	if (p->major != LUO_VERSION_MAJOR ||
+	    p->minor > LUO_VERSION_MINOR) {
+		pr_err("prev orchestrator version (%d.%d)\n",
+		       p->major, p->minor);
+		pr_err("new orchestrator version (%d.%d)\n",
+		       LUO_VERSION_MAJOR, LUO_VERSION_MINOR);
+		panic("Orchestrator version mismatch\n");
+	}
+
+	if (!luo_enabled)
+		panic("Live update node found, but feature is disabled\n");
+
+	state = LIVEUPDATE_STATE_UPDATED;
+	pr_info("live update boot\n");
+
+no_liveupdate:
+	__luo_set_state(state);
+
+	return 0;
+}
+early_initcall(luo_startup);
+
+/* Public Functions */
+
+/**
+ * liveupdate_reboot - Notify subsystems to perform final serialization for live
+ * update.
+ *
+ * This function is called directly from the reboot() syscall path when a live
+ * update is prepared (i.e., the system is rebooting into a new kernel while
+ * preserving devices). It is part of the "blackout" window where the old kernel
+ * is transitioning to the new one.
+ *
+ * During this phase, the function iterates through the list of participating in
+ * the live update subsystems and invokes their registered ``LIVEUPDATE_REBOOT``
+ * callbacks. These callbacks *must* be extremely time-sensitive as they perform
+ * the final serialization of device/subsystem state necessary to survive the
+ * imminent kernel transition. Any delays here directly impact the duration of
+ * the blackout window.
+ *
+ * If any callback fails, the live update process is aborted, and a
+ * ``LIVEUPDATE_CANCEL`` notification is sent to all subsystems, that were
+ * already notified and were not notified to bring machine back to the
+ * ``LIVEUPDATE_NORMAL`` state..
+ *
+ * On success, the function adds a node to the KHO tree to indicate to the next
+ * kernel that a live update is in progress.
+ *
+ * @return 0 on success, or a negative error code if a callback fails or if
+ * adding the KHO node fails.
+ */
+int liveupdate_reboot(void)
+{
+	int ret;
+
+	if (!IS_STATE(LIVEUPDATE_STATE_PREPARED))
+		return 0;
+
+	if (down_write_killable(&luo_state_rwsem)) {
+		pr_warn(" %s, change state canceled by user\n", __func__);
+		return -EAGAIN;
+	}
+
+	ret = luo_notify(LIVEUPDATE_REBOOT);
+	if (ret < 0) {
+		luo_set_state(LIVEUPDATE_STATE_NORMAL);
+	} else {
+		/* Add live update orchestrator node to KHO tree */
+		ret = kho_add_node(NULL, LUO_KHO_NODE_NAME, &luo_node);
+		if (!ret) {
+			ret = kho_add_prop(&luo_node, LUO_KHO_VERSION_PROP_NAME,
+					   &luo_version, sizeof(luo_version));
+		}
+
+		if (ret) {
+			(void)luo_notify(LIVEUPDATE_CANCEL);
+			luo_set_state(LIVEUPDATE_STATE_NORMAL);
+		}
+	}
+
+	up_write(&luo_state_rwsem);
+
+	if (ret)
+		pr_warn("%s failed: %d\n", __func__, ret);
+
+	return ret;
+}
+
+/**
+ * liveupdate_state_updated - Check if the system is in the live update
+ * 'updated' state.
+ *
+ * This function checks if the live update orchestrator is in the
+ * ``LIVEUPDATE_STATE_UPDATED`` state. This state indicates that the system has
+ * successfully rebooted into a new kernel as part of a live update, and the
+ * preserved devices are expected to be in the process of being reclaimed.
+ *
+ * This is typically used by subsystems during early boot of the new kernel
+ * to determine if they need to attempt to restore state from a previous
+ * live update.
+ *
+ * @return true if the system is in the ``LIVEUPDATE_STATE_UPDATED`` state,
+ * false otherwise.
+ */
+bool liveupdate_state_updated(void)
+{
+	return IS_STATE(LIVEUPDATE_STATE_UPDATED);
+}
+EXPORT_SYMBOL_GPL(liveupdate_state_updated);
+
+/**
+ * liveupdate_state_normal - Check if the system is in the live update 'normal'
+ * state.
+ *
+ * This function checks if the live update orchestrator is in the
+ * ``LIVEUPDATE_STATE_NORMAL`` state. This state indicates that no live update
+ * is in progress. It represents the default operational state of the system.
+ *
+ * This can be used to gate actions that should only be performed when no
+ * live update activity is occurring.
+ *
+ * @return true if the system is in the ``LIVEUPDATE_STATE_NORMAL`` state,
+ * false otherwise.
+ */
+bool liveupdate_state_normal(void)
+{
+	return IS_STATE(LIVEUPDATE_STATE_NORMAL);
+}
+EXPORT_SYMBOL_GPL(liveupdate_state_normal);
+
+/**
+ * liveupdate_register_notifier - Register a notifier for live update events.
+ *
+ * This function registers a notifier block to receive callbacks for various
+ * stages of the live update process. Notifiers are called when the live
+ * update state changes, allowing subsystems to participate in the
+ * serialization and restoration of state.
+ *
+ * @nb: Pointer to the notifier block to register.
+ *
+ * @return 0 on success, or a negative error code on failure (e.g., if
+ * the notifier block is already registered).
+ */
+int liveupdate_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&luo_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(liveupdate_register_notifier);
+
+/**
+ * liveupdate_unregister_notifier - Unregister a live update event notifier.
+ *
+ * This function unregisters a previously registered notifier block from
+ * receiving further callbacks for live update events.
+ *
+ * @nb: Pointer to the notifier block to unregister.
+ *
+ * @return 0 on success, or a negative error code if the notifier block
+ * was not found.
+ */
+int liveupdate_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&luo_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(liveupdate_unregister_notifier);
+
+/**
+ * liveupdate_enabled - Check if the live update feature is enabled.
+ *
+ * This function returns the state of the live update feature flag, which
+ * can be controlled via the ``liveupdate`` kernel command-line parameter.
+ *
+ * @return true if live update is enabled, false otherwise.
+ */
+bool liveupdate_enabled(void)
+{
+	return luo_enabled;
+}
+EXPORT_SYMBOL_GPL(liveupdate_enabled);
+
+/**
+ * liveupdate_read_state_enter_killable - Acquire the live update state read
+ * lock (killable).
+ *
+ * This function attempts to acquire the read lock protecting the live update
+ * orchestrator state. It allows multiple readers but excludes writers. The
+ * call is interruptible by signals.
+ *
+ * Subsystems should acquire this lock if they need to read the live update
+ * state and potentially perform actions based on it.
+ *
+ * Callers *must* call liveupdate_read_state_exit() to release the lock.
+ *
+ * @return 0 on success, or ``-EINTR`` if interrupted by a signal.
+ */
+int liveupdate_read_state_enter_killable(void)
+{
+	return down_read_killable(&luo_state_rwsem);
+}
+EXPORT_SYMBOL_GPL(liveupdate_read_state_enter_killable);
+
+/**
+ * liveupdate_read_state_enter - Acquire the live update state read lock.
+ *
+ * The same as liveupdate_read_state_enter_killable(), but not interruptable.
+ */
+void liveupdate_read_state_enter(void)
+{
+	down_read(&luo_state_rwsem);
+}
+EXPORT_SYMBOL_GPL(liveupdate_read_state_enter);
+
+/**
+ * liveupdate_read_state_exit - Release the live update state read lock.
+ *
+ * This function releases the read lock protecting the live update
+ * orchestrator state. It must be called after a successful call to
+ * liveupdate_read_state_enter_killable() or liveupdate_read_state_enter().
+ */
+void liveupdate_read_state_exit(void)
+{
+	up_read(&luo_state_rwsem);
+}
+EXPORT_SYMBOL_GPL(liveupdate_read_state_exit);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index b5a8569e5d81..d57413cdc9b9 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -18,6 +18,7 @@
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
 #include <linux/uaccess.h>
+#include <linux/liveupdate.h>
 
 /*
  * this indicates whether you can reboot with ctrl-alt-del: the default is yes
@@ -791,6 +792,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 #ifdef CONFIG_KEXEC_CORE
 	case LINUX_REBOOT_CMD_KEXEC:
+		ret = liveupdate_reboot();
+		if (ret)
+			break;
 		ret = kernel_kexec();
 		break;
 #endif
-- 
2.49.0.395.g12beb8f557-goog


