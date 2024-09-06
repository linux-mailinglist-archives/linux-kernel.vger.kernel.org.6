Return-Path: <linux-kernel+bounces-318710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7260A96F1E1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C131F24AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233F1CA681;
	Fri,  6 Sep 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oydiRIJC"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE6B81745;
	Fri,  6 Sep 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619790; cv=none; b=n7AXGCpXB1mZ2avXw5eydtFAyelKpUBiyfYAUatdRhC1pACjmXvsRfMrY4hj7VjWuNKmQZ1h4HRnEMXECN3hSwJIoJ1HHHhQpuodG+/U1YteerddUvDHRrZRrVoBt2DADNonnyQ9oep7r6gEDLMRk5XzP7R+HfAyGhklVkVj5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619790; c=relaxed/simple;
	bh=4K0E2IyzitApeYg9mDwYc+t/tsR74FtzrArJll1VuNw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DeCrQhTpWcQxCQwjSUVAylBNRNXUP7jEDNJhF5MKBpOEXQlmN9TF+rNyMG7LxeAXaVRGxqrHCgsJSWVvECXwNq5m84v2DgTgXMBc4rEkn2d7k6MW/Nlnc7eZ6uMauZ+pJAzCuqKS3BbXiHdwSgiqAmtLZDkrd9YX8hMV5ginCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oydiRIJC; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725619788; x=1757155788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YlJkwc7o0S1aTS/rvhzlAXNLvyMkdLbJRU2SAjbOMrc=;
  b=oydiRIJC8y5tRYKPvEBsLungkA46fhcuHfQx464SpNmYLT0xN91Qan5b
   0i94t42AGgIGQaloFPHZrcvlRgECpqvDCUM9Ruhsn4h3wStBJtFb0b1FF
   eQ3sPseDYJMs/5czfR0XXr7L4oOD7pHfK6SA0rQ3c2cdjCEGkoG39uwFe
   c=;
X-IronPort-AV: E=Sophos;i="6.10,207,1719878400"; 
   d="scan'208";a="425971812"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 10:49:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:55306]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.175:2525] with esmtp (Farcaster)
 id bd08bdf5-e25b-41a9-9336-62441350f5e7; Fri, 6 Sep 2024 10:49:42 +0000 (UTC)
X-Farcaster-Flow-ID: bd08bdf5-e25b-41a9-9336-62441350f5e7
Received: from EX19D002AND004.ant.amazon.com (10.37.240.230) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Sep 2024 10:49:41 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D002AND004.ant.amazon.com (10.37.240.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Sep 2024 10:49:40 +0000
Received: from dev-dsk-itazur-1b-8445a99b.eu-west-1.amazon.com (10.13.227.122)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Fri, 6 Sep 2024 10:49:38 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<corbet@lwn.net>
CC: <bp@alien8.de>, <itazur@amazon.com>, <zulinx86@gmail.com>,
	<jpoimboe@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>
Subject: [PATCH v2] Documentation: Use grid table over list table
Date: Fri, 6 Sep 2024 10:49:36 +0000
Message-ID: <20240906104936.15558-1-itazur@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Using a simple table, a line break in the first column would be
recognized as two rows. To avoid that, list table was used but it
is unreadable for plain text readers. Uses grid table instead.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
Changes in v2:
- Use grid table over list table (applying to not only GDS but also
  other vulnerabilities)
- Link to v1: https://lore.kernel.org/all/20240903132533.26458-1-itazur@amazon.com/

---
 .../hw-vuln/gather_data_sampling.rst          | 40 +++++++------
 Documentation/admin-guide/hw-vuln/mds.rst     | 50 ++++++++--------
 .../admin-guide/hw-vuln/multihit.rst          | 27 +++++----
 .../hw-vuln/processor_mmio_stale_data.rst     | 57 ++++++++++---------
 .../hw-vuln/reg-file-data-sampling.rst        | 23 ++++----
 Documentation/admin-guide/hw-vuln/spectre.rst | 55 +++++++++---------
 .../admin-guide/hw-vuln/tsx_async_abort.rst   | 57 +++++++++++--------
 7 files changed, 170 insertions(+), 139 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
index 264bfa937f7d..15d124fe979a 100644
--- a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
@@ -85,23 +85,29 @@ GDS this can be accessed by the following sysfs file:
 
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
+ +----------------------------+----------------------------------------------+
+ | 'Not affected'             | Processor is not vulnerable.                 |
+ +----------------------------+----------------------------------------------+
+ | 'Vulnerable'               | Processor is vulnerable and mitigation       |
+ |                            | disabled.                                    |
+ +----------------------------+----------------------------------------------+
+ | 'Vulnerable: No microcode' | Processor is vulnerable and microcode is     |
+ |                            | missing mitigation.                          |
+ +----------------------------+----------------------------------------------+
+ | 'Mitigation: AVX disabled, | Processor is vulnerable and microcode is     |
+ | no microcode'              | missing mitigation. AVX disabled as          |
+ |                            | mitigation.                                  |
+ +----------------------------+----------------------------------------------+
+ | 'Mitigation: Microcode'    | Processor is vulnerable and mitigation is in |
+ |                            | effect.                                      |
+ +----------------------------+----------------------------------------------+
+ | 'Mitigation: Microcode     | Processor is vulnerable and mitigation is in |
+ | (locked)'                  | effect and cannot be disabled.               |
+ +----------------------------+----------------------------------------------+
+ | 'Unknown: Dependent on     | Running on a virtual guest processor that is |
+ | hypervisor status'         | affected but with no way to know if host     |
+ |                            | processor is mitigated or vulnerable.        |
+ +----------------------------+----------------------------------------------+
 
 GDS Default mitigation
 ----------------------
diff --git a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admin-guide/hw-vuln/mds.rst
index 48c7b0b72aed..a57f50233d42 100644
--- a/Documentation/admin-guide/hw-vuln/mds.rst
+++ b/Documentation/admin-guide/hw-vuln/mds.rst
@@ -95,29 +95,33 @@ mitigations are active. The relevant sysfs file is:
 
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
+  +------------------------+---------------------------------------------------+
+  | 'Not affected'         | The processor is not vulnerable.                  |
+  +------------------------+---------------------------------------------------+
+  | 'Vulnerable'           | The processor is vulnerable, but no mitigation    |
+  |                        | enabled.                                          |
+  +------------------------+---------------------------------------------------+
+  | 'Vulnerable: Clear CPU | The processor is vulnerable but microcode is not  |
+  | buffers attempted, no  | updated. The mitigation is enabled on a best      |
+  | microcode'             | effort basis.                                     |
+  |                        |                                                   |
+  |                        | If the processor is vulnerable but the            |
+  |                        | availability of the microcode based mitigation    |
+  |                        | mechanism is not advertised via CPUID, the kernel |
+  |                        | selects a best effort mitigation mode. This mode  |
+  |                        | invokes the mitigation instructions without a     |
+  |                        | guarantee that they clear the CPU buffers.        |
+  |                        |                                                   |
+  |                        | This is done to address virtualization scenarios  |
+  |                        | where the host has the microcode update applied,  |
+  |                        | but the hypervisor is not yet updated to expose   |
+  |                        | the CPUID to the guest. If the host has updated   |
+  |                        | microcode the protection takes effect; otherwise  |
+  |                        | a few CPU cycles are wasted pointlessly.          |
+  +------------------------+---------------------------------------------------+
+  | 'Mitigation: Clear CPU | The processor is vulnerable and the CPU buffer    |
+  | buffers'               | clearning mitigation is enabled.                  |
+  +------------------------+---------------------------------------------------+
 
 If the processor is vulnerable then the following information is appended
 to the above information:
diff --git a/Documentation/admin-guide/hw-vuln/multihit.rst b/Documentation/admin-guide/hw-vuln/multihit.rst
index 140e4cec38c3..4870afa5b40a 100644
--- a/Documentation/admin-guide/hw-vuln/multihit.rst
+++ b/Documentation/admin-guide/hw-vuln/multihit.rst
@@ -74,18 +74,21 @@ mitigations are active. The relevant sysfs file is:
 
 The possible values in this file are:
 
-.. list-table::
-
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
+  +-------------------+-------------------------------------------------+
+  | 'Not affected'    | The processor is not vulnerable.                |
+  +-------------------+-------------------------------------------------+
+  | 'KVM mitigation:  | Software changes mitigate this issue.           |
+  | Split huge pages' |                                                 |
+  +-------------------+-------------------------------------------------+
+  | 'KVM mitigation:  | KVM is not vulnerable because Virtual Machine   |
+  | VMX unsupported'  | Extensions (VMX) is not supported.              |
+  +-------------------+-------------------------------------------------+
+  | 'KVM mitigation:  | KVM is not vulnerable because Virtual Machine   |
+  | VMX disabled'     | Extensions (VMX) is disabled.                   |
+  +-------------------+-------------------------------------------------+
+  | 'KVM: Vulnerable' | The processor is vulnerable, but no mitigation  |
+  |                   | enabled.                                        |
+  +-------------------+-------------------------------------------------+
 
 
 Enumeration of the erratum
diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
index 1302fd1b55e8..7f9a5d8de10a 100644
--- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
+++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
@@ -218,32 +218,37 @@ which mitigations are active. The relevant sysfs file is:
 
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
+  +------------------------+--------------------------------------------------+
+  | 'Not affected'         | The processor is not vulnerable.                 |
+  +------------------------+--------------------------------------------------+
+  | 'Vulnerable'           | The processor is vulnerable, but no mitigation   |
+  |                        | enabled.                                         |
+  +------------------------+--------------------------------------------------+
+  | 'Vulnerable: Clear CPU | The processor is vulnerable but microcode is not |
+  | buffers attempted, no  | updated. The mitigation is enabled on a best     |
+  | microcode'             | effort basis.                                    |
+  |                        |                                                  |
+  |                        | The processor is vulnerable but the availability |
+  |                        | of the microcode based mitigation mechanism is   |
+  |                        | not advertised via CPUID, the kernel selects a   |
+  |                        | best effort mitigation mode. This mode invokes   |
+  |                        | the mitigation instructions without a guarantee  |
+  |                        | that they clear the CPU buffers.                 |
+  |                        |                                                  |
+  |                        | This is done to address virtualization scenarios |
+  |                        | where the host has the microcode update applied, |
+  |                        | but the hypervisor is not yet updated to expose  |
+  |                        | the CPUID to the guest. If the host has updated  |
+  |                        | microcode the protection takes effect; otherwise |
+  |                        | a few CPU cycles are wasted pointlessly.         |
+  +------------------------+--------------------------------------------------+
+  | 'Mitigation: Clear CPU | The processor is vulnerable and the CPU buffer   |
+  | buffers'               | clearing mitigation is enabled.                  |
+  +------------------------+--------------------------------------------------+
+  | 'Unknown: No           | The processor vulnerability status is unknown    |
+  | mitigations'           | because it is out of Servicing period.           |
+  |                        | Mitigation is not attempted.                     |
+  +------------------------+--------------------------------------------------+
 
 Definitions:
 ------------
diff --git a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
index 0585d02b9a6c..e5f324206bed 100644
--- a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
@@ -86,17 +86,18 @@ which mitigations are active. The relevant sysfs file is:
 
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
+  +--------------------+---------------------------------------------------+
+  | 'Not affected'     | The processor is not vulnerable.                  |
+  +--------------------+---------------------------------------------------+
+  | 'Vulnerable'       | The processor is vulnerable, but no mitigation    |
+  |                    | enabled.                                          |
+  +--------------------+---------------------------------------------------+
+  | 'Vulnerable: No    | The processor is vulnerable but microcode is not  |
+  | microcode'         | updated.                                          |
+  +--------------------+---------------------------------------------------+
+  | 'Mitigation: Clear | The processor is vulnerable and the CPU buffer    |
+  | Register File'     | clearing mitigation is enabled.                   |
+  +--------------------+---------------------------------------------------+
 
 References
 ----------
diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 132e0bc6007e..114139f86d1a 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -336,18 +336,20 @@ The sysfs file showing Spectre variant 1 mitigation status is:
 
 The possible values in this file are:
 
-  .. list-table::
-
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
+  +------------------------------+--------------------------------------------+
+  | 'Not affected'               | The processor is not vulnerable.           |
+  +------------------------------+--------------------------------------------+
+  | 'Vulnerable: __user pointer  | The swapgs protections are disabled;       |
+  | sanitization and usercopy    | otherwise it has protection in the kernel  |
+  | barriers only; no swapgs     | on a case by case basis with explicit      |
+  | barriers'                    | pointer sanitization and usercopy LFENCE   |
+  |                              | barriers.                                  |
+  +------------------------------+--------------------------------------------+
+  | 'Mitigation: usercopy/swapgs | Protection in the kernel on a case by case |
+  | barriers and __user pointer  | basis with explicit pointer sanitization,  |
+  | sanitization'                | usercopy LFENCE barriers, and swapgs       |
+  |                              | LFENCE barriers.                           |
+  +------------------------------+--------------------------------------------+
 
 However, the protections are put in place on a case by case basis,
 and there is no guarantee that all possible attack vectors for Spectre
@@ -431,20 +433,21 @@ The possible values in this file are:
 
   - Branch History Injection (BHI) protection status:
 
-.. list-table::
-
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
+  +---------------------+----------------------------------------------------+
+  | 'BHI: Not affected' | System is not affected.                            |
+  +---------------------+----------------------------------------------------+
+  | 'BHI: Retpoline'    | System is protected by retpoline.                  |
+  +---------------------+----------------------------------------------------+
+  | 'BHI: BHI_DIS_S'    | System is protected by BHI_DIS_S.                  |
+  +---------------------+----------------------------------------------------+
+  | 'BHI: SW loop, KVM  | System is protected by software clearing sequence. |
+  | SW loop'            |                                                    |
+  +---------------------+----------------------------------------------------+
+  | 'BHI: Vulnerable'   | System is vulnerable to BHI.                       |
+  +---------------------+----------------------------------------------------+
+  | 'BHI: Vulnerable,   | System is vulnerable; KVM is protected by software |
+  | KVM: SW loop'       | clearing sequence.                                 |
+  +---------------------+----------------------------------------------------+
 
 Full mitigation might require a microcode update from the CPU
 vendor. When the necessary microcode is not available, the kernel will
diff --git a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
index 444f84e22a91..24811752d9a9 100644
--- a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
+++ b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
@@ -93,30 +93,39 @@ of mitigated systems. The relevant sysfs file is:
 
 The possible values in this file are:
 
-.. list-table::
-
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
+  +------------------------+--------------------------------------------------+
+  | 'Not affected'         | The processor is not affected by this            |
+  |                        | vulnerability.                                   |
+  +------------------------+--------------------------------------------------+
+  | 'Vulnerable'           | The processor is affected by this vulnerability  |
+  |                        | and the microcode and kernel mitigation are not  |
+  |                        | applied.                                         |
+  +------------------------+--------------------------------------------------+
+  | 'Vulnerable: Clear CPU | The processor is vulnerable but microcode is not |
+  | buffers attempted, no  | updated. The mitigation is enabled on a best     |
+  | microcode'             | effort basis.                                    |
+  |                        |                                                  |
+  |                        | If the processor is vulnerable but the           |
+  |                        | availability of the microcode based mitigation   |
+  |                        | mechanism is not advertised via CPUID, the       |
+  |                        | kernel selects a best effort mitigation mode.    |
+  |                        | This mode invokes the mitigation instructions    |
+  |                        | without a guarantee that they clear the CPU      |
+  |                        | buffers.                                         |
+  |                        |                                                  |
+  |                        | This is done to address virtualization scenarios |
+  |                        | where the host has the microcode update applied, |
+  |                        | but the hypervisor is not yet updated to expose  |
+  |                        | the CPUID to the guest. If the host has updated  |
+  |                        | microcode the protection takes effect; otherwise |
+  |                        | a few CPU cycles are wasted pointlessly.         |
+  +------------------------+--------------------------------------------------+
+  | 'Mitigation: Clear CPU | The microcode has been updated to clear the      |
+  | buffers'               | buffers. TSX is still enabled.                   |
+  +------------------------+--------------------------------------------------+
+  | 'Mitigation: TSX       | TSX is disabled.                                 |
+  | disabled'              |                                                  |
+  +------------------------+--------------------------------------------------+
 
 Mitigation mechanism
 --------------------
-- 
2.40.1


