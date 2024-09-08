Return-Path: <linux-kernel+bounces-320330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FC39708EF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C4C1F217B4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5B176230;
	Sun,  8 Sep 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2GRixWI"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAB26281;
	Sun,  8 Sep 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816228; cv=none; b=qaz8eGLZ/z21e0ns5JoyuyI1X9tZrLRXAdVsCwWYZhjzaXFRrGZPsqQwDkei4/uCAwlkTiv6rOQUWNbop4iAPmlSr+IvWtiO9ftefrjKwkx8bnz9HjttYzWHioQdMLGFdBulZ4ERr9jB0hb9anr0WoQlPJwZetsO9wSUm4dpV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816228; c=relaxed/simple;
	bh=d3JyulI1YkWBehu99lvw/J7ZVW1shJYR0a1nM3qSO9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bsQoP49HEEaZ30FT5WuaQmq5pnT4rNvBrqydkWUOYpNLBWiNQrVNyzUyIRchHvHrIzGuQXGF2jTP3to8RwUaEAFGZ5RID7WY0nyvGgT8K4Rte48ev9z15205FQedxZzekQy57tJH3xy2LQKiJyctdzJNPK4HqTnfEbb7mKKVob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2GRixWI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4582a0b438aso6245141cf.0;
        Sun, 08 Sep 2024 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725816225; x=1726421025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wIxoUlkfEly4H78q6CgnMvXEL//MI3ToZCRp9mLEJJY=;
        b=R2GRixWI/a3oSEiq9C/i1jqlv0nh4W81TVD006MGW9dalKbHX9I6LgRhBYNpAFXDQu
         OeM5A2WcIJQzhR4LeMXRzefln+dSBTUh8o9JTaF0IKbeJrcrDRR84Hvr+JCg1dro7DrZ
         Mx34MgvBhsICJnv1Wpb3zpYIgNHZsPRWbNZbgQ77lBT6Fo9EmxoF/uQTQ692nfsxKSPG
         xxp0LV/+5Gr7gW4ZfDpIK1mI0hH6iLZHQ6Hfq8vZSeivHO35+ggg2nlyXmlCuwZv7AKj
         j5syYofVqc6uMScwyXiW1dGcLHMtrbwNLzHOlxKPApOcu8eMrGyJDMK+8kbQs0m33baS
         Qigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725816225; x=1726421025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIxoUlkfEly4H78q6CgnMvXEL//MI3ToZCRp9mLEJJY=;
        b=gxC1r52g25syiUhAuLjpTfUqjJeVwOTrBTZNYHgEG9pzyy6HBSuR7cYYDMEzqI3VHJ
         glBUgndTfC/hUobw6I+kCDKZqWzLrGsvEEda2iiFmPpeAxHvBWKjJ4Hfz9/eJ2i4Qkaq
         Es48TDQQovBwRX8TO4WKhHRuWWaw0wSB/joTzNAczZZC2nTQRXvfm96uX2KPrrayQtyD
         gMmgMDtu8ZubZddGffSIZ1/z9dR0PXxWmraNiOadUMXJoXdRrjUjlBiuMA/WfrTqtAXX
         q1SpgyeFeY6b//X5I2ch2P7yw4w91Ie7b/ApfNIYlRFbEQ26GZqZM6F3DkVssGXqgY67
         WTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRAOuaGH/Q397mNyauQRi3XSgkAowx/rvh1TZMHO1JGbopI6U33ZV3PJIm+pjzkzR/bd73I/YoMxQ48rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOOxtuZftFtbT165avN5hK4VTWj1TLZN9DYgGninzcwISQLHp
	cPkY+WEodPwpeolYLSRC5HzlnnWljVNZe5+IYuQv0vFkJqbNKSxqDKNGJN7VNdE=
X-Google-Smtp-Source: AGHT+IH4Sh+w1lojndLbehsEbJW+koQdBHSAZywohICDSKK2ndSLuYVttkZcVnbpG5sWjpHl8MnCEg==
X-Received: by 2002:a05:622a:1448:b0:458:2a24:6ed6 with SMTP id d75a77b69052e-4582a24719fmr52560311cf.21.1725816224227;
        Sun, 08 Sep 2024 10:23:44 -0700 (PDT)
Received: from ip-172-31-16-54.ec2.internal (ec2-52-90-172-172.compute-1.amazonaws.com. [52.90.172.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f94e8asm13959931cf.85.2024.09.08.10.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 10:23:43 -0700 (PDT)
From: Takahiro Itazuri <zulinx86@gmail.com>
To: linux-doc@vger.kernel.org,
	corbet@lwn.net
Cc: zulinx86@gmail.com,
	bp@alien8.de,
	jani.nikula@linux.intel.com,
	jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	peterz@infradead.org,
	tglx@linutronix.de
Subject: [PATCH v3] Documentation: Unify format for vuln sysfs
Date: Sun,  8 Sep 2024 17:23:41 +0000
Message-Id: <20240908172341.571476-1-zulinx86@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The format for vuln sysfs files was diverge across pages. Unifies the
format as follows:

* Use list table for possible values for the sysfs files, because simple
  table does not allow line breaks for the first column; otherwise
  recognized as two different rows

* Insert 2-spaces indentation before the sysfs paths

* Wrap each possible value with single quotes

* End description with a full stop

Signed-off-by: Takahiro Itazuri <zulinx86@gmail.com>
---
Changes in v3
- Return to list table in favor of presevation of the existing HTML appearance
  and readability/editability in plain text format.
- Link to v2: https://lore.kernel.org/all/20240906104936.15558-1-itazur@amazon.com/

Changes in v2:
- Use grid table over list table (applying to not only GDS but also
  other vulnerabilities)
- Link to v1: https://lore.kernel.org/all/20240903132533.26458-1-itazur@amazon.com/

---
 .../hw-vuln/gather_data_sampling.rst          |  44 +++---
 Documentation/admin-guide/hw-vuln/l1tf.rst    |  37 +++--
 Documentation/admin-guide/hw-vuln/mds.rst     |  70 ++++----
 .../admin-guide/hw-vuln/multihit.rst          |  26 +--
 .../hw-vuln/processor_mmio_stale_data.rst     |  72 +++++----
 .../hw-vuln/reg-file-data-sampling.rst        |  27 ++--
 .../special-register-buffer-data-sampling.rst |  39 +++--
 Documentation/admin-guide/hw-vuln/spectre.rst | 149 +++++++++++-------
 Documentation/admin-guide/hw-vuln/srso.rst    |  81 +++++-----
 .../admin-guide/hw-vuln/tsx_async_abort.rst   |  52 +++---
 10 files changed, 342 insertions(+), 255 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
index 264bfa937f7d..815c78acc4be 100644
--- a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
@@ -81,27 +81,35 @@ GDS System Information
 The kernel provides vulnerability status information through sysfs. For
 GDS this can be accessed by the following sysfs file:
 
-/sys/devices/system/cpu/vulnerabilities/gather_data_sampling
+  /sys/devices/system/cpu/vulnerabilities/gather_data_sampling
 
 The possible values contained in this file are:
 
- ============================== =============================================
- Not affected                   Processor not vulnerable.
- Vulnerable                     Processor vulnerable and mitigation disabled.
- Vulnerable: No microcode       Processor vulnerable and microcode is missing
-                                mitigation.
- Mitigation: AVX disabled,
- no microcode                   Processor is vulnerable and microcode is missing
-                                mitigation. AVX disabled as mitigation.
- Mitigation: Microcode          Processor is vulnerable and mitigation is in
-                                effect.
- Mitigation: Microcode (locked) Processor is vulnerable and mitigation is in
-                                effect and cannot be disabled.
- Unknown: Dependent on
- hypervisor status              Running on a virtual guest processor that is
-                                affected but with no way to know if host
-                                processor is mitigated or vulnerable.
- ============================== =============================================
+.. list-table::
+
+  * - 'Not affected'
+    - Processor not vulnerable.
+
+  * - 'Vulnerable'
+    - Processor vulnerable and mitigation disabled.
+
+  * - 'Vulnerable: No microcode'
+    - Processor vulnerable and microcode is missing migitation.
+
+  * - 'Mitigation: AVX disabled, no microcode'
+    - Processor is vulnerable and microcode is missing mitigation. AVX disbaled
+      as mitigation.
+
+  * - 'Mitigation: Microcode'
+    - Processor is vulnerable and mitigation is in effect.
+
+  * - 'Mitigation: Microcode (locked)'
+    - Processor is vulnerable and mitigation is in effect and cannot be
+      disabled.
+
+  * - 'Unknown: Dependent on hypervisor status'
+    - Running on a virtual guest processor that is affected but with no way to
+      know if host processor is mitigated or vulnerable.
 
 GDS Default mitigation
 ----------------------
diff --git a/Documentation/admin-guide/hw-vuln/l1tf.rst b/Documentation/admin-guide/hw-vuln/l1tf.rst
index 3eeeb488d955..a049e1ab935c 100644
--- a/Documentation/admin-guide/hw-vuln/l1tf.rst
+++ b/Documentation/admin-guide/hw-vuln/l1tf.rst
@@ -123,34 +123,43 @@ The Linux kernel provides a sysfs interface to enumerate the current L1TF
 status of the system: whether the system is vulnerable, and which
 mitigations are active. The relevant sysfs file is:
 
-/sys/devices/system/cpu/vulnerabilities/l1tf
+  /sys/devices/system/cpu/vulnerabilities/l1tf
 
 The possible values in this file are:
 
-  ===========================   ===============================
-  'Not affected'		The processor is not vulnerable
-  'Mitigation: PTE Inversion'	The host protection is active
-  ===========================   ===============================
+.. list-table::
+
+  * - 'Not affected'
+    - The processor is not vulnerable.
+
+  * - 'Mitigation: PTE Inversion'
+    - The host protection is active.
 
 If KVM/VMX is enabled and the processor is vulnerable then the following
 information is appended to the 'Mitigation: PTE Inversion' part:
 
   - SMT status:
 
-    =====================  ================
-    'VMX: SMT vulnerable'  SMT is enabled
-    'VMX: SMT disabled'    SMT is disabled
-    =====================  ================
+    .. list-table::
+
+      * - 'VMX: SMT vulnerable'
+        - SMT is enabled.
+
+      * - 'VMX: SMT disabled'
+        - SMT is disabled.
 
   - L1D Flush mode:
 
-    ================================  ====================================
-    'L1D vulnerable'		      L1D flushing is disabled
+    .. list-table::
+
+      * - 'L1D vulnerable'
+        - L1D flushing is disabled.
 
-    'L1D conditional cache flushes'   L1D flush is conditionally enabled
+      * - 'L1D conditional cache flushes'
+        - L1D flush is conditionally enabled.
 
-    'L1D cache flushes'		      L1D flush is unconditionally enabled
-    ================================  ====================================
+      * - 'L1D cache flushes'
+        - L1D flush is unconditionally enabled.
 
 The resulting grade of protection is discussed in the following sections.
 
diff --git a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admin-guide/hw-vuln/mds.rst
index 48c7b0b72aed..542b6c1ee56d 100644
--- a/Documentation/admin-guide/hw-vuln/mds.rst
+++ b/Documentation/admin-guide/hw-vuln/mds.rst
@@ -91,43 +91,53 @@ The Linux kernel provides a sysfs interface to enumerate the current MDS
 status of the system: whether the system is vulnerable, and which
 mitigations are active. The relevant sysfs file is:
 
-/sys/devices/system/cpu/vulnerabilities/mds
+  /sys/devices/system/cpu/vulnerabilities/mds
 
 The possible values in this file are:
 
-  .. list-table::
-
-     * - 'Not affected'
-       - The processor is not vulnerable
-     * - 'Vulnerable'
-       - The processor is vulnerable, but no mitigation enabled
-     * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
-       - The processor is vulnerable but microcode is not updated. The
-         mitigation is enabled on a best effort basis.
-
-         If the processor is vulnerable but the availability of the microcode
-         based mitigation mechanism is not advertised via CPUID, the kernel
-         selects a best effort mitigation mode. This mode invokes the mitigation
-         instructions without a guarantee that they clear the CPU buffers.
-
-         This is done to address virtualization scenarios where the host has the
-         microcode update applied, but the hypervisor is not yet updated to
-         expose the CPUID to the guest. If the host has updated microcode the
-         protection takes effect; otherwise a few CPU cycles are wasted
-         pointlessly.
-     * - 'Mitigation: Clear CPU buffers'
-       - The processor is vulnerable and the CPU buffer clearing mitigation is
-         enabled.
+.. list-table::
+
+  * - 'Not affected'
+    - The processor is not vulnerable.
+
+  * - 'Vulnerable'
+    - The processor is vulnerable, but no mitigation enabled.
+
+  * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
+    - The processor is vulnerable but microcode is not updated. The
+      mitigation is enabled on a best effort basis.
+
+      If the processor is vulnerable but the availability of the microcode
+      based mitigation mechanism is not advertised via CPUID, the kernel
+      selects a best effort mitigation mode. This mode invokes the mitigation
+      instructions without a guarantee that they clear the CPU buffers.
+
+      This is done to address virtualization scenarios where the host has the
+      microcode update applied, but the hypervisor is not yet updated to
+      expose the CPUID to the guest. If the host has updated microcode the
+      protection takes effect; otherwise a few CPU cycles are wasted
+      pointlessly.
+
+  * - 'Mitigation: Clear CPU buffers'
+    - The processor is vulnerable and the CPU buffer clearing mitigation is
+      enabled.
 
 If the processor is vulnerable then the following information is appended
 to the above information:
 
-    ========================  ============================================
-    'SMT vulnerable'          SMT is enabled
-    'SMT mitigated'           SMT is enabled and mitigated
-    'SMT disabled'            SMT is disabled
-    'SMT Host state unknown'  Kernel runs in a VM, Host SMT state unknown
-    ========================  ============================================
+.. list-table::
+
+  * - 'SMT vulnerable'
+    - SMT is enabled.
+
+  * - 'SMT mitigated'
+    - SMT is enabled and mitigated.
+
+  * - 'SMT disabled'
+    - SMT is disabled.
+
+  * - 'SMT Host state unknown'
+    - Kernel runs in a VM, Host SMT state unknown.
 
 Mitigation mechanism
 -------------------------
diff --git a/Documentation/admin-guide/hw-vuln/multihit.rst b/Documentation/admin-guide/hw-vuln/multihit.rst
index 140e4cec38c3..8aff9640c216 100644
--- a/Documentation/admin-guide/hw-vuln/multihit.rst
+++ b/Documentation/admin-guide/hw-vuln/multihit.rst
@@ -70,22 +70,26 @@ The Linux kernel provides a sysfs interface to enumerate the current iTLB
 multihit status of the system:whether the system is vulnerable and which
 mitigations are active. The relevant sysfs file is:
 
-/sys/devices/system/cpu/vulnerabilities/itlb_multihit
+  /sys/devices/system/cpu/vulnerabilities/itlb_multihit
 
 The possible values in this file are:
 
 .. list-table::
 
-     * - Not affected
-       - The processor is not vulnerable.
-     * - KVM: Mitigation: Split huge pages
-       - Software changes mitigate this issue.
-     * - KVM: Mitigation: VMX unsupported
-       - KVM is not vulnerable because Virtual Machine Extensions (VMX) is not supported.
-     * - KVM: Mitigation: VMX disabled
-       - KVM is not vulnerable because Virtual Machine Extensions (VMX) is disabled.
-     * - KVM: Vulnerable
-       - The processor is vulnerable, but no mitigation enabled
+  * - 'Not affected'
+    - The processor is not vulnerable.
+
+  * - 'KVM: Mitigation: Split huge pages'
+    - Software changes mitigate this issue.
+
+  * - 'KVM: Mitigation: VMX unsupported'
+    - KVM is not vulnerable because Virtual Machine Extensions (VMX) is not supported.
+
+  * - 'KVM: Mitigation: VMX disabled'
+    - KVM is not vulnerable because Virtual Machine Extensions (VMX) is disabled.
+
+  * - 'KVM: Vulnerable'
+    - The processor is vulnerable, but no mitigation enabled.
 
 
 Enumeration of the erratum
diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
index 1302fd1b55e8..e86188ae107c 100644
--- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
+++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
@@ -214,36 +214,39 @@ The Linux kernel provides a sysfs interface to enumerate the current
 vulnerability status of the system: whether the system is vulnerable, and
 which mitigations are active. The relevant sysfs file is:
 
-	/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+  /sys/devices/system/cpu/vulnerabilities/mmio_stale_data
 
 The possible values in this file are:
 
-  .. list-table::
-
-     * - 'Not affected'
-       - The processor is not vulnerable
-     * - 'Vulnerable'
-       - The processor is vulnerable, but no mitigation enabled
-     * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
-       - The processor is vulnerable but microcode is not updated. The
-         mitigation is enabled on a best effort basis.
-
-         If the processor is vulnerable but the availability of the microcode
-         based mitigation mechanism is not advertised via CPUID, the kernel
-         selects a best effort mitigation mode. This mode invokes the mitigation
-         instructions without a guarantee that they clear the CPU buffers.
-
-         This is done to address virtualization scenarios where the host has the
-         microcode update applied, but the hypervisor is not yet updated to
-         expose the CPUID to the guest. If the host has updated microcode the
-         protection takes effect; otherwise a few CPU cycles are wasted
-         pointlessly.
-     * - 'Mitigation: Clear CPU buffers'
-       - The processor is vulnerable and the CPU buffer clearing mitigation is
-         enabled.
-     * - 'Unknown: No mitigations'
-       - The processor vulnerability status is unknown because it is
-	 out of Servicing period. Mitigation is not attempted.
+.. list-table::
+
+  * - 'Not affected'
+    - The processor is not vulnerable.
+
+  * - 'Vulnerable'
+    - The processor is vulnerable, but no mitigation enabled.
+
+  * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
+    - The processor is vulnerable but microcode is not updated. The mitigation
+      is enabled on a best effort basis.
+
+      If the processor is vulnerable but the availability of the microcode
+      based mitigation mechanism is not advertised via CPUID, the kernel
+      selects a best effort mitigation mode. This mode invokes the mitigation
+      instructions without a guarantee that they clear the CPU buffers.
+
+      This is done to address virtualization scenarios where the host has the
+      microcode update applied, but the hypervisor is not yet updated to expose
+      the CPUID to the guest. If the host has updated microcode the protection
+      takes effect; otherwise a few CPU cycles are wasted pointlessly.
+
+  * - 'Mitigation: Clear CPU buffers'
+    - The processor is vulnerable and the CPU buffer clearing mitigation is
+      enabled.
+
+  * - 'Unknown: No mitigations'
+    - The processor vulnerability status is unknown because it is out of
+      Servicing period. Mitigation is not attempted.
 
 Definitions:
 ------------
@@ -259,11 +262,16 @@ processes. ESU dates will typically be aligned to end of quarter.
 If the processor is vulnerable then the following information is appended to
 the above information:
 
-  ========================  ===========================================
-  'SMT vulnerable'          SMT is enabled
-  'SMT disabled'            SMT is disabled
-  'SMT Host state unknown'  Kernel runs in a VM, Host SMT state unknown
-  ========================  ===========================================
+.. list-table::
+
+  * - 'SMT vulnerable'
+    - SMT is enabled.
+
+  * - 'SMT disabled'
+    - SMT is disabled.
+
+  * - 'SMT Host state unknown'
+    - Kernel runs in a VM, Host SMT state unknown.
 
 References
 ----------
diff --git a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
index 0585d02b9a6c..00bcc0424980 100644
--- a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
@@ -82,21 +82,24 @@ The Linux kernel provides a sysfs interface to enumerate the current
 vulnerability status of the system: whether the system is vulnerable, and
 which mitigations are active. The relevant sysfs file is:
 
-	/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
+  /sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
 
 The possible values in this file are:
 
-  .. list-table::
-
-     * - 'Not affected'
-       - The processor is not vulnerable
-     * - 'Vulnerable'
-       - The processor is vulnerable, but no mitigation enabled
-     * - 'Vulnerable: No microcode'
-       - The processor is vulnerable but microcode is not updated.
-     * - 'Mitigation: Clear Register File'
-       - The processor is vulnerable and the CPU buffer clearing mitigation is
-	 enabled.
+.. list-table::
+
+  * - 'Not affected'
+    - The processor is not vulnerable.
+
+  * - 'Vulnerable'
+    - The processor is vulnerable, but no mitigation enabled.
+
+  * - 'Vulnerable: No microcode'
+    - The processor is vulnerable but microcode is not updated.
+
+  * - 'Mitigation: Clear Register File'
+    - The processor is vulnerable and the CPU buffer clearing mitigation is
+      enabled.
 
 References
 ----------
diff --git a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
index 966c9b3296ea..5b8c4e816e9e 100644
--- a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
@@ -122,25 +122,32 @@ SRBDS System Information
 ------------------------
 The Linux kernel provides vulnerability status information through sysfs.  For
 SRBDS this can be accessed by the following sysfs file:
-/sys/devices/system/cpu/vulnerabilities/srbds
+
+  /sys/devices/system/cpu/vulnerabilities/srbds
 
 The possible values contained in this file are:
 
- ============================== =============================================
- Not affected                   Processor not vulnerable
- Vulnerable                     Processor vulnerable and mitigation disabled
- Vulnerable: No microcode       Processor vulnerable and microcode is missing
-                                mitigation
- Mitigation: Microcode          Processor is vulnerable and mitigation is in
-                                effect.
- Mitigation: TSX disabled       Processor is only vulnerable when TSX is
-                                enabled while this system was booted with TSX
-                                disabled.
- Unknown: Dependent on
- hypervisor status              Running on virtual guest processor that is
-                                affected but with no way to know if host
-                                processor is mitigated or vulnerable.
- ============================== =============================================
+.. list-table::
+
+  * - 'Not affected'
+    - Processor not vulnerable.
+
+  * - 'Vulnerable'
+    - Processor vulnerable and mitigation disabled.
+
+  * - 'Vulnerable: No microcode'
+    - Processor vulnerable and microcode is missing mitigation.
+
+  * - 'Mitigation: Microcode'
+    - Processor is vulnerable and mitigation is in effect.
+
+  * - 'Mitigation: TSX disabled'
+    - Processor is only vulnerable when TSX is enabled while this system was
+      booted with TSX disabled.
+
+  * - 'Unknown: Dependent on hypervisor status'
+    - Running on virtual guest processor that is affected but with no way to
+      know if host processor is mitigated or vulnerable.
 
 SRBDS Default mitigation
 ------------------------
diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 132e0bc6007e..f8d5e3c10fdd 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -332,22 +332,24 @@ vulnerable, and which mitigations are active.
 
 The sysfs file showing Spectre variant 1 mitigation status is:
 
-   /sys/devices/system/cpu/vulnerabilities/spectre_v1
+  /sys/devices/system/cpu/vulnerabilities/spectre_v1
 
 The possible values in this file are:
 
-  .. list-table::
+.. list-table::
+
+  * - 'Not affected'
+    - The processor is not vulnerable.
 
-     * - 'Not affected'
-       - The processor is not vulnerable.
-     * - 'Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers'
-       - The swapgs protections are disabled; otherwise it has
-         protection in the kernel on a case by case base with explicit
-         pointer sanitation and usercopy LFENCE barriers.
-     * - 'Mitigation: usercopy/swapgs barriers and __user pointer sanitization'
-       - Protection in the kernel on a case by case base with explicit
-         pointer sanitation, usercopy LFENCE barriers, and swapgs LFENCE
-         barriers.
+  * - 'Vulnerable: __user pointer sanitization and usercopy barriers only; no
+      swapgs barriers'
+    - The swapgs protections are disabled; otherwise it has protection in the
+      kernel on a case by case base with explicit pointer sanitation and
+      usercopy LFENCE barriers.
+
+  * - 'Mitigation: usercopy/swapgs barriers and __user pointer sanitization'
+    - Protection in the kernel on a case by case base with explicit pointer
+      sanitation, usercopy LFENCE barriers, and swapgs LFENCE barriers.
 
 However, the protections are put in place on a case by case basis,
 and there is no guarantee that all possible attack vectors for Spectre
@@ -370,81 +372,116 @@ per process on a case-by-case base.
 
 The sysfs file showing Spectre variant 2 mitigation status is:
 
-   /sys/devices/system/cpu/vulnerabilities/spectre_v2
+  /sys/devices/system/cpu/vulnerabilities/spectre_v2
 
 The possible values in this file are:
 
   - Kernel status:
 
-  ========================================  =================================
-  'Not affected'                            The processor is not vulnerable
-  'Mitigation: None'                        Vulnerable, no mitigation
-  'Mitigation: Retpolines'                  Use Retpoline thunks
-  'Mitigation: LFENCE'                      Use LFENCE instructions
-  'Mitigation: Enhanced IBRS'               Hardware-focused mitigation
-  'Mitigation: Enhanced IBRS + Retpolines'  Hardware-focused + Retpolines
-  'Mitigation: Enhanced IBRS + LFENCE'      Hardware-focused + LFENCE
-  ========================================  =================================
+    .. list-table::
+
+      * - 'Not affected'
+        - The processor is not vulnerable.
+
+      * - 'Mitigation: None'
+        - Vulnerable, no mitigation.
+
+      * - 'Mitigation: Retpolines'
+        - Use Retpoline thunks.
+
+      * - 'Mitigation: LFENCE'
+        - Use LFENCE instructions.
+
+      * - 'Mitigation: Enhanced IBRS'
+        - Hardware-focused mitigation.
+
+      * - 'Mitigation: Enhanced IBRS + Retpolines'
+        - Hardware-focused + Retpolines.
+
+      * - 'Mitigation: Enhanced IBRS + LFENCE'
+        - Hardware-focused + LFENCE.
 
   - Firmware status: Show if Indirect Branch Restricted Speculation (IBRS) is
     used to protect against Spectre variant 2 attacks when calling firmware (x86 only).
 
-  ========== =============================================================
-  'IBRS_FW'  Protection against user program attacks when calling firmware
-  ========== =============================================================
+    .. list-table::
+
+      * - 'IBRS_FW'
+        - Protection against user program attacks when calling firmware.
 
   - Indirect branch prediction barrier (IBPB) status for protection between
     processes of different users. This feature can be controlled through
     prctl() per process, or through kernel command line options. This is
     an x86 only feature. For more details see below.
 
-  ===================   ========================================================
-  'IBPB: disabled'      IBPB unused
-  'IBPB: always-on'     Use IBPB on all tasks
-  'IBPB: conditional'   Use IBPB on SECCOMP or indirect branch restricted tasks
-  ===================   ========================================================
+    .. list-table::
+
+      * - 'IBPB: disabled'
+        - IBPB unused.
+
+      * - 'IBPB: always-on'
+        - Use IBPB on all tasks.
+
+      * - 'IBPB: conditional'
+        - Use IBPB on SECCOMP or indirect branch restricted tasks.
 
   - Single threaded indirect branch prediction (STIBP) status for protection
     between different hyper threads. This feature can be controlled through
     prctl per process, or through kernel command line options. This is x86
     only feature. For more details see below.
 
-  ====================  ========================================================
-  'STIBP: disabled'     STIBP unused
-  'STIBP: forced'       Use STIBP on all tasks
-  'STIBP: conditional'  Use STIBP on SECCOMP or indirect branch restricted tasks
-  ====================  ========================================================
+    .. list-table::
+
+      * - 'STIBP: disabled'
+        - STIBP unused.
+
+      * - 'STIBP: forced'
+        - Use STIBP on all tasks.
+
+      * - 'STIBP: conditional'
+        - Use STIBP on SECCOMP or indirect branch restricted tasks.
 
   - Return stack buffer (RSB) protection status:
 
-  =============   ===========================================
-  'RSB filling'   Protection of RSB on context switch enabled
-  =============   ===========================================
+    .. list-table::
+
+      * - 'RSB filling'
+        - Protection of RSB on context switch enabled.
 
   - EIBRS Post-barrier Return Stack Buffer (PBRSB) protection status:
 
-  ===========================  =======================================================
-  'PBRSB-eIBRS: SW sequence'   CPU is affected and protection of RSB on VMEXIT enabled
-  'PBRSB-eIBRS: Vulnerable'    CPU is vulnerable
-  'PBRSB-eIBRS: Not affected'  CPU is not affected by PBRSB
-  ===========================  =======================================================
+    .. list-table::
+
+      * - 'PBRSB-eIBRS: SW sequence'
+        - CPU is affected and protection of RSB on VMEXIT enabled.
+
+      * - 'PBRSB-eIBRS: Vulnerable'
+        - CPU is vulnerable.
+
+      * - 'PBRSB-eIBRS: Not affected'
+        - CPU is not affected by PBRSB.
 
   - Branch History Injection (BHI) protection status:
 
-.. list-table::
+    .. list-table::
+
+      * - 'BHI: Not affected'
+        - System is not affected.
+
+      * - 'BHI: Retpoline'
+        - System is protected by retpoline.
+
+      * - 'BHI: BHI_DIS_S'
+        - System is protected by BHI_DIS_S.
+
+      * - 'BHI: SW loop, KVM SW loop'
+        - System is protected by software clearing sequence.
+
+      * - 'BHI: Vulnerable'
+        - System is vulnerable to BHI.
 
- * - BHI: Not affected
-   - System is not affected
- * - BHI: Retpoline
-   - System is protected by retpoline
- * - BHI: BHI_DIS_S
-   - System is protected by BHI_DIS_S
- * - BHI: SW loop, KVM SW loop
-   - System is protected by software clearing sequence
- * - BHI: Vulnerable
-   - System is vulnerable to BHI
- * - BHI: Vulnerable, KVM: SW loop
-   - System is vulnerable; KVM is protected by software clearing sequence
+      * - 'BHI: Vulnerable, KVM: SW loop'
+        - System is vulnerable; KVM is protected by software clearing sequence.
 
 Full mitigation might require a microcode update from the CPU
 vendor. When the necessary microcode is not available, the kernel will
diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index 4bd3ce3ba171..63343e3a04fd 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -42,67 +42,62 @@ The sysfs file showing SRSO mitigation status is:
 
 The possible values in this file are:
 
- * 'Not affected':
+.. list-table::
 
-   The processor is not vulnerable
+  * - 'Not affected'
+    - The processor is not vulnerable.
 
-* 'Vulnerable':
+  * - 'Vulnerable'
+    - The processor is vulnerable and no mitigations have been applied.
 
-   The processor is vulnerable and no mitigations have been applied.
+  * - 'Vulnerable: No microcode'
+    - The processor is vulnerable, no microcode extending IBPB functionality to
+      address the vulnerability has been applied.
 
- * 'Vulnerable: No microcode':
+  * - 'Vulnerable: Safe RET, no microcode'
+    - The "Safe RET" mitigation (see below) has been applied to protect the
+      kernel, but the IBPB-extending microcode has not been applied. User space
+      tasks may still be vulnerable.
 
-   The processor is vulnerable, no microcode extending IBPB
-   functionality to address the vulnerability has been applied.
+  * - 'Vulnerable: Microcode, no safe RET'
+    - Extended IBPB functionality microcode patch has been applied. It does not
+      address User->Kernel and Guest->Host transitions protection but it does
+      address User->User and VM->VM attack vectors.
 
- * 'Vulnerable: Safe RET, no microcode':
+      Note that User->User mitigation is controlled by how the IBPB aspect in
+      the Spectre v2 mitigation is selected:
 
-   The "Safe RET" mitigation (see below) has been applied to protect the
-   kernel, but the IBPB-extending microcode has not been applied.  User
-   space tasks may still be vulnerable.
+      * 'conditional IBPB'
 
- * 'Vulnerable: Microcode, no safe RET':
+        where each process can select whether it needs an IBPB issued around it
+        PR_SPEC_DISABLE/_ENABLE etc, see :doc:`spectre`
 
-   Extended IBPB functionality microcode patch has been applied. It does
-   not address User->Kernel and Guest->Host transitions protection but it
-   does address User->User and VM->VM attack vectors.
+      * 'strict'
 
-   Note that User->User mitigation is controlled by how the IBPB aspect in
-   the Spectre v2 mitigation is selected:
+        i.e., always on - by supplying spectre_v2_user=on on the kernel command
+        line
 
-    * conditional IBPB:
+      (spec_rstack_overflow=microcode)
 
-      where each process can select whether it needs an IBPB issued
-      around it PR_SPEC_DISABLE/_ENABLE etc, see :doc:`spectre`
+  * - 'Mitigation: Safe RET'
+    - Combined microcode/software mitigation. It complements the extended IBPB
+      microcode patch functionality by addressing User->Kernel and Guest->Host
+      transitions protection.
 
-    * strict:
+      Selected by default or by spec_rstack_overflow=safe-ret
 
-      i.e., always on - by supplying spectre_v2_user=on on the kernel
-      command line
+  * - 'Mitigation: IBPB'
+    - Similar protection as "safe RET" above but employs an IBPB barrier on
+      privilege domain crossings (User->Kernel, Guest->Host).
 
-   (spec_rstack_overflow=microcode)
+      (spec_rstack_overflow=ibpb)
 
- * 'Mitigation: Safe RET':
+  * - 'Mitigation: IBPB on VMEXIT'
 
-   Combined microcode/software mitigation. It complements the
-   extended IBPB microcode patch functionality by addressing
-   User->Kernel and Guest->Host transitions protection.
+    - Mitigation addressing the cloud provider scenario - the Guest->Host
+      transitions only.
 
-   Selected by default or by spec_rstack_overflow=safe-ret
-
- * 'Mitigation: IBPB':
-
-   Similar protection as "safe RET" above but employs an IBPB barrier on
-   privilege domain crossings (User->Kernel, Guest->Host).
-
-  (spec_rstack_overflow=ibpb)
-
- * 'Mitigation: IBPB on VMEXIT':
-
-   Mitigation addressing the cloud provider scenario - the Guest->Host
-   transitions only.
-
-   (spec_rstack_overflow=ibpb-vmexit)
+      (spec_rstack_overflow=ibpb-vmexit)
 
 
 
diff --git a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
index 444f84e22a91..478590e8a419 100644
--- a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
+++ b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
@@ -89,34 +89,40 @@ TAA system information
 The Linux kernel provides a sysfs interface to enumerate the current TAA status
 of mitigated systems. The relevant sysfs file is:
 
-/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
+  /sys/devices/system/cpu/vulnerabilities/tsx_async_abort
 
 The possible values in this file are:
 
 .. list-table::
 
-   * - 'Vulnerable'
-     - The CPU is affected by this vulnerability and the microcode and kernel mitigation are not applied.
-   * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
-     - The processor is vulnerable but microcode is not updated. The
-       mitigation is enabled on a best effort basis.
-
-       If the processor is vulnerable but the availability of the microcode
-       based mitigation mechanism is not advertised via CPUID, the kernel
-       selects a best effort mitigation mode. This mode invokes the mitigation
-       instructions without a guarantee that they clear the CPU buffers.
-
-       This is done to address virtualization scenarios where the host has the
-       microcode update applied, but the hypervisor is not yet updated to
-       expose the CPUID to the guest. If the host has updated microcode the
-       protection takes effect; otherwise a few CPU cycles are wasted
-       pointlessly.
-   * - 'Mitigation: Clear CPU buffers'
-     - The microcode has been updated to clear the buffers. TSX is still enabled.
-   * - 'Mitigation: TSX disabled'
-     - TSX is disabled.
-   * - 'Not affected'
-     - The CPU is not affected by this issue.
+  * - 'Vulnerable'
+    - The CPU is affected by this vulnerability and the microcode and kernel
+      mitigation are not applied.
+
+  * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
+    - The processor is vulnerable but microcode is not updated. The mitigation
+      is enabled on a best effort basis.
+
+      If the processor is vulnerable but the availability of the microcode
+      based mitigation mechanism is not advertised via CPUID, the kernel
+      selects a best effort mitigation mode. This mode invokes the mitigation
+      instructions without a guarantee that they clear the CPU buffers.
+
+      This is done to address virtualization scenarios where the host has the
+      microcode update applied, but the hypervisor is not yet updated to
+      expose the CPUID to the guest. If the host has updated microcode the
+      protection takes effect; otherwise a few CPU cycles are wasted
+      pointlessly.
+
+  * - 'Mitigation: Clear CPU buffers'
+    - The microcode has been updated to clear the buffers. TSX is still
+      enabled.
+
+  * - 'Mitigation: TSX disabled'
+    - TSX is disabled.
+
+  * - 'Not affected'
+    - The CPU is not affected by this issue.
 
 Mitigation mechanism
 --------------------
-- 
2.34.1


