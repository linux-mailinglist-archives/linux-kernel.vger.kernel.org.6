Return-Path: <linux-kernel+bounces-230103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8F917866
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7591F2204E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977914A4EB;
	Wed, 26 Jun 2024 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnbtJ4C1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF14139D04
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381511; cv=none; b=d7EU/vJ/675dsgl5mbSKj/Wtu2PTgMtXCjqkCe1Wy+Ud6d4tznzWNDd5TR4wfUykzBdWs+AQlRfkCLQBpRrogk4JMIMfgz3w5faQM1ZTGy/WFNMhthLpogmmvAx/Ho71wzDoBapnbwGZ+eHgs4uqZt9FwrpeCdO8AIi9V2vcot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381511; c=relaxed/simple;
	bh=9IPhk6AEIWixPMzOsQXSjxV3V4L3+7zRf1D6E49+RaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8iOvrYUc78GqjMjdzf4s4JkpbuZFxhdP2lzMIhkc9UQyX8HeUFoWZ5+/JNEF244MHfVh+74Ewqvfq2vUAK+qVdw57k3DAYm0uEjGOSj+2aFdLbZ1GcDbRV2L43bRoTchtj/da/80rjXk5eTX6DbHbN+fPdom9aREqNwrqrM9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnbtJ4C1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E84AC32782;
	Wed, 26 Jun 2024 05:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719381510;
	bh=9IPhk6AEIWixPMzOsQXSjxV3V4L3+7zRf1D6E49+RaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnbtJ4C1yLwGUofwhf0SfUSIWlpe8Ayti8jeb1O+YtaGSn1yDhfH3cNYf0b39w3n3
	 V7VPaGormkB5wl4lRgLBMmEUz0unW73UfiZdtIZp6wn3Vk/U4KwJYeZFjBJQ3PA3ec
	 escLsQdE0tIwBiP0NWnNCYwziSgakgtCabkiZWZzQHXjzzyXDNXdXugU2m6gGwGfwV
	 RFmGwJdwZ66X6p5Dp1jpziPK1xPyHRs8w56QR7CXR1J3tVIufv9wZoyleOfVxoeYxJ
	 T8o83AstmqKqgaQ/DW0qDWJlqIjz3Q/gZkZEsg3GH9PuB5c8V6r3kg00O2GU/F9yCZ
	 bco/NQe7Tnd8A==
Date: Tue, 25 Jun 2024 22:58:28 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Message-ID: <20240626055828.ziui7i42wofxvfel@treble>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
 <ab3e92eb-d35e-4f5a-8e99-10b3ccb7c2cf@linux.intel.com>
 <20240508051953.oz3q3hdvifo6lb7o@treble>
 <22da39f0-e73f-4e11-830e-914b5bc04029@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22da39f0-e73f-4e11-830e-914b5bc04029@yandex-team.ru>

On Mon, May 27, 2024 at 01:45:59PM +0300, Maksim Davydov wrote:
> I think it will be useful for us to have appropriate Kconfig option. Could
> you please add it to the next version?

That should probably be a separate patch, something like the below?

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d7122a1883e..ab1ea701bc42 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2642,17 +2642,46 @@ config MITIGATION_RFDS
 	  stored in floating point, vector and integer registers.
 	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
 
-config MITIGATION_SPECTRE_BHI
-	bool "Mitigate Spectre-BHB (Branch History Injection)"
+choice
+	prompt "Mitigate Spectre-BHB (Branch History Injection)"
 	depends on CPU_SUP_INTEL
-	default y
+	default MITIGATION_SPECTRE_BHI_ON
 	help
 	  Enable BHI mitigations. BHI attacks are a form of Spectre V2 attacks
 	  where the branch history buffer is poisoned to speculatively steer
 	  indirect branches.
+
+	  The compile-time default can be set to on, vmexit, or off,
+	  corresponding to the "spectre_bhi=" cmdline defaults described in
+	  Documentation/admin-guide/kernel-parameters.rst.  The cmdline
+	  options can be used to override this compile-time default.
+
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
-endif
+config MITIGATION_SPECTRE_BHI_ON
+	bool "on"
+	help
+	  Enable the HW or SW mitigation as needed.  This protects the kernel
+	  from both syscalls and VMs.  Equivalent to the spectre_bhi=on cmdline
+	  option.
+
+config MITIGATION_SPECTRE_BHI_VMEXIT
+	bool "vmexit"
+	help
+	  On systems which don't have the HW mitigation available, enable the
+	  SW mitigation on vmexit ONLY.  On such systems, the host kernel is
+	  protected from VM-originated BHI attacks, but may still be vulnerable
+	  to syscall attacks.  Equivalent to the spectre_bhi=vmexit cmdline
+	  option.
+
+config MITIGATION_SPECTRE_BHI_OFF
+	bool "off"
+	help
+	  Disable the mitigation.  Equivalent to the spectre_bhi=off cmdline
+	  option.
+endchoice
+
+endif # CPU_MITIGATIONS
 
 config ARCH_HAS_ADD_PAGES
 	def_bool y
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 94bcf29df465..d415f24b7169 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1628,8 +1628,13 @@ enum bhi_mitigations {
 	BHI_MITIGATION_VMEXIT_ONLY,
 };
 
-static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
+#ifdef CONFIG_MITIGATION_SPECTRE_BHI_ON
+static enum bhi_mitigations bhi_mitigation __ro_after_init = BHI_MITIGATION_ON;
+#elif CONFIG_MITIGATION_SPECTRE_BHI_VMEXIT
+static enum bhi_mitigations bhi_mitigation __ro_after_init = BHI_MITIGATION_VMEXIT;
+#else
+static enum bhi_mitigations bhi_mitigation __ro_after_init = BHI_MITIGATION_OFF;
+#endif
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {

