Return-Path: <linux-kernel+bounces-318932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA2B96F54C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE5F1C21EF5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D3E1CE701;
	Fri,  6 Sep 2024 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2dy1zl1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5C1CDFA8;
	Fri,  6 Sep 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629224; cv=none; b=Z0WLce1OyiU/IQ7KOL4YRtQOw3MNV8BzxroDUw1fJaeNRoeoLvThLsEaFsj1ZtPRxQAy/9rRyoGtJXb1/DVIrcUcgPu4OORY9I3KK8m+x592Y9xt/Z/fIYDGSo4xGMHLTFVn/J/VEJjTB/9Dwt2ExyYWkR5hCDA8IWQIOPrQ9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629224; c=relaxed/simple;
	bh=X7vPvaFQ513SQbs61qlar260dm1thHMT6A5VykXMVRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mvwEmb0XuGX/+aaZbgLH0VlaVQfMS2vn3OCu7XTfvFuvPy6vfmJlVjmPTQ1LtFc4xfs8lx9g3CjF2I7ejd/SABibsYj/1qubKAyz+Lem7LjGDGZxa4ZyRDvWpgZnlXFSRwa9gE8rkar2LEv9ZHyyoSgP24ojWav8talD5EjEeS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2dy1zl1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725629221; x=1757165221;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=X7vPvaFQ513SQbs61qlar260dm1thHMT6A5VykXMVRU=;
  b=g2dy1zl1TdGcDL4tNBDRCE4MzgA8qcmJScsGET5t1nUVOgizAy7/9ZTw
   XkBsCb1+5sShmWzaU3WGGM3yfwIDdSwm7ouG5S9uRYA1ixlCbDWhIKj0o
   SB2z+xCY7mliUzKWBWWsmT48g86eNWiTA3bmLc8ehGSXKlYuOG/W+dlVY
   KuGL+JWycr+I6UxpGsz8SUZQ63i/od6nKm4jFdj3+iGE/GrEB1K2OZvsb
   3q/18KnjkMX26i77Qq9WeOAOV29g3fjpsJSvyV9JcuGyU3VZmjuxNX00U
   4U4j1SMN52+fxZSE2voerl3obH3OMG1alqFCizEROpyg28iRgd7zjgRyc
   g==;
X-CSE-ConnectionGUID: bgFRRo96TIeapC0hlfhxAg==
X-CSE-MsgGUID: QEegtCJgSiGBWy+dDYI3iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="28135755"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="28135755"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:26:59 -0700
X-CSE-ConnectionGUID: bggBOJJ1Qf++BbLw+z5s7g==
X-CSE-MsgGUID: 20oRehf2QheMA/CjYlA8nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="96742569"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.62])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:26:55 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Takahiro Itazuri <itazur@amazon.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net
Cc: bp@alien8.de, itazur@amazon.com, zulinx86@gmail.com,
 jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCH v2] Documentation: Use grid table over list table
In-Reply-To: <20240906104936.15558-1-itazur@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240906104936.15558-1-itazur@amazon.com>
Date: Fri, 06 Sep 2024 16:26:49 +0300
Message-ID: <87zfoknc9y.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 06 Sep 2024, Takahiro Itazuri <itazur@amazon.com> wrote:
> Using a simple table, a line break in the first column would be
> recognized as two rows. To avoid that, list table was used but it
> is unreadable for plain text readers. Uses grid table instead.
>
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
> Changes in v2:
> - Use grid table over list table (applying to not only GDS but also
>   other vulnerabilities)
> - Link to v1: https://lore.kernel.org/all/20240903132533.26458-1-itazur@amazon.com/

I see that Jon asked you to use a grid table.

But when I look at what's being changed, I can't help but think a
definition list [1] might provide the best compromise between readable
(and easily editable!) source rst and generated html. I don't think it
has to be a *table* in either.

Up to Jon, of course.


BR,
Jani.


[1] https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#definition-lists


>
> ---
>  .../hw-vuln/gather_data_sampling.rst          | 40 +++++++------
>  Documentation/admin-guide/hw-vuln/mds.rst     | 50 ++++++++--------
>  .../admin-guide/hw-vuln/multihit.rst          | 27 +++++----
>  .../hw-vuln/processor_mmio_stale_data.rst     | 57 ++++++++++---------
>  .../hw-vuln/reg-file-data-sampling.rst        | 23 ++++----
>  Documentation/admin-guide/hw-vuln/spectre.rst | 55 +++++++++---------
>  .../admin-guide/hw-vuln/tsx_async_abort.rst   | 57 +++++++++++--------
>  7 files changed, 170 insertions(+), 139 deletions(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
> index 264bfa937f7d..15d124fe979a 100644
> --- a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
> +++ b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
> @@ -85,23 +85,29 @@ GDS this can be accessed by the following sysfs file:
>  
>  The possible values contained in this file are:
>  
> - ============================== =============================================
> - Not affected                   Processor not vulnerable.
> - Vulnerable                     Processor vulnerable and mitigation disabled.
> - Vulnerable: No microcode       Processor vulnerable and microcode is missing
> -                                mitigation.
> - Mitigation: AVX disabled,
> - no microcode                   Processor is vulnerable and microcode is missing
> -                                mitigation. AVX disabled as mitigation.
> - Mitigation: Microcode          Processor is vulnerable and mitigation is in
> -                                effect.
> - Mitigation: Microcode (locked) Processor is vulnerable and mitigation is in
> -                                effect and cannot be disabled.
> - Unknown: Dependent on
> - hypervisor status              Running on a virtual guest processor that is
> -                                affected but with no way to know if host
> -                                processor is mitigated or vulnerable.
> - ============================== =============================================
> + +----------------------------+----------------------------------------------+
> + | 'Not affected'             | Processor is not vulnerable.                 |
> + +----------------------------+----------------------------------------------+
> + | 'Vulnerable'               | Processor is vulnerable and mitigation       |
> + |                            | disabled.                                    |
> + +----------------------------+----------------------------------------------+
> + | 'Vulnerable: No microcode' | Processor is vulnerable and microcode is     |
> + |                            | missing mitigation.                          |
> + +----------------------------+----------------------------------------------+
> + | 'Mitigation: AVX disabled, | Processor is vulnerable and microcode is     |
> + | no microcode'              | missing mitigation. AVX disabled as          |
> + |                            | mitigation.                                  |
> + +----------------------------+----------------------------------------------+
> + | 'Mitigation: Microcode'    | Processor is vulnerable and mitigation is in |
> + |                            | effect.                                      |
> + +----------------------------+----------------------------------------------+
> + | 'Mitigation: Microcode     | Processor is vulnerable and mitigation is in |
> + | (locked)'                  | effect and cannot be disabled.               |
> + +----------------------------+----------------------------------------------+
> + | 'Unknown: Dependent on     | Running on a virtual guest processor that is |
> + | hypervisor status'         | affected but with no way to know if host     |
> + |                            | processor is mitigated or vulnerable.        |
> + +----------------------------+----------------------------------------------+
>  
>  GDS Default mitigation
>  ----------------------
> diff --git a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admin-guide/hw-vuln/mds.rst
> index 48c7b0b72aed..a57f50233d42 100644
> --- a/Documentation/admin-guide/hw-vuln/mds.rst
> +++ b/Documentation/admin-guide/hw-vuln/mds.rst
> @@ -95,29 +95,33 @@ mitigations are active. The relevant sysfs file is:
>  
>  The possible values in this file are:
>  
> -  .. list-table::
> -
> -     * - 'Not affected'
> -       - The processor is not vulnerable
> -     * - 'Vulnerable'
> -       - The processor is vulnerable, but no mitigation enabled
> -     * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
> -       - The processor is vulnerable but microcode is not updated. The
> -         mitigation is enabled on a best effort basis.
> -
> -         If the processor is vulnerable but the availability of the microcode
> -         based mitigation mechanism is not advertised via CPUID, the kernel
> -         selects a best effort mitigation mode. This mode invokes the mitigation
> -         instructions without a guarantee that they clear the CPU buffers.
> -
> -         This is done to address virtualization scenarios where the host has the
> -         microcode update applied, but the hypervisor is not yet updated to
> -         expose the CPUID to the guest. If the host has updated microcode the
> -         protection takes effect; otherwise a few CPU cycles are wasted
> -         pointlessly.
> -     * - 'Mitigation: Clear CPU buffers'
> -       - The processor is vulnerable and the CPU buffer clearing mitigation is
> -         enabled.
> +  +------------------------+---------------------------------------------------+
> +  | 'Not affected'         | The processor is not vulnerable.                  |
> +  +------------------------+---------------------------------------------------+
> +  | 'Vulnerable'           | The processor is vulnerable, but no mitigation    |
> +  |                        | enabled.                                          |
> +  +------------------------+---------------------------------------------------+
> +  | 'Vulnerable: Clear CPU | The processor is vulnerable but microcode is not  |
> +  | buffers attempted, no  | updated. The mitigation is enabled on a best      |
> +  | microcode'             | effort basis.                                     |
> +  |                        |                                                   |
> +  |                        | If the processor is vulnerable but the            |
> +  |                        | availability of the microcode based mitigation    |
> +  |                        | mechanism is not advertised via CPUID, the kernel |
> +  |                        | selects a best effort mitigation mode. This mode  |
> +  |                        | invokes the mitigation instructions without a     |
> +  |                        | guarantee that they clear the CPU buffers.        |
> +  |                        |                                                   |
> +  |                        | This is done to address virtualization scenarios  |
> +  |                        | where the host has the microcode update applied,  |
> +  |                        | but the hypervisor is not yet updated to expose   |
> +  |                        | the CPUID to the guest. If the host has updated   |
> +  |                        | microcode the protection takes effect; otherwise  |
> +  |                        | a few CPU cycles are wasted pointlessly.          |
> +  +------------------------+---------------------------------------------------+
> +  | 'Mitigation: Clear CPU | The processor is vulnerable and the CPU buffer    |
> +  | buffers'               | clearning mitigation is enabled.                  |
> +  +------------------------+---------------------------------------------------+
>  
>  If the processor is vulnerable then the following information is appended
>  to the above information:
> diff --git a/Documentation/admin-guide/hw-vuln/multihit.rst b/Documentation/admin-guide/hw-vuln/multihit.rst
> index 140e4cec38c3..4870afa5b40a 100644
> --- a/Documentation/admin-guide/hw-vuln/multihit.rst
> +++ b/Documentation/admin-guide/hw-vuln/multihit.rst
> @@ -74,18 +74,21 @@ mitigations are active. The relevant sysfs file is:
>  
>  The possible values in this file are:
>  
> -.. list-table::
> -
> -     * - Not affected
> -       - The processor is not vulnerable.
> -     * - KVM: Mitigation: Split huge pages
> -       - Software changes mitigate this issue.
> -     * - KVM: Mitigation: VMX unsupported
> -       - KVM is not vulnerable because Virtual Machine Extensions (VMX) is not supported.
> -     * - KVM: Mitigation: VMX disabled
> -       - KVM is not vulnerable because Virtual Machine Extensions (VMX) is disabled.
> -     * - KVM: Vulnerable
> -       - The processor is vulnerable, but no mitigation enabled
> +  +-------------------+-------------------------------------------------+
> +  | 'Not affected'    | The processor is not vulnerable.                |
> +  +-------------------+-------------------------------------------------+
> +  | 'KVM mitigation:  | Software changes mitigate this issue.           |
> +  | Split huge pages' |                                                 |
> +  +-------------------+-------------------------------------------------+
> +  | 'KVM mitigation:  | KVM is not vulnerable because Virtual Machine   |
> +  | VMX unsupported'  | Extensions (VMX) is not supported.              |
> +  +-------------------+-------------------------------------------------+
> +  | 'KVM mitigation:  | KVM is not vulnerable because Virtual Machine   |
> +  | VMX disabled'     | Extensions (VMX) is disabled.                   |
> +  +-------------------+-------------------------------------------------+
> +  | 'KVM: Vulnerable' | The processor is vulnerable, but no mitigation  |
> +  |                   | enabled.                                        |
> +  +-------------------+-------------------------------------------------+
>  
>  
>  Enumeration of the erratum
> diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> index 1302fd1b55e8..7f9a5d8de10a 100644
> --- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> +++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> @@ -218,32 +218,37 @@ which mitigations are active. The relevant sysfs file is:
>  
>  The possible values in this file are:
>  
> -  .. list-table::
> -
> -     * - 'Not affected'
> -       - The processor is not vulnerable
> -     * - 'Vulnerable'
> -       - The processor is vulnerable, but no mitigation enabled
> -     * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
> -       - The processor is vulnerable but microcode is not updated. The
> -         mitigation is enabled on a best effort basis.
> -
> -         If the processor is vulnerable but the availability of the microcode
> -         based mitigation mechanism is not advertised via CPUID, the kernel
> -         selects a best effort mitigation mode. This mode invokes the mitigation
> -         instructions without a guarantee that they clear the CPU buffers.
> -
> -         This is done to address virtualization scenarios where the host has the
> -         microcode update applied, but the hypervisor is not yet updated to
> -         expose the CPUID to the guest. If the host has updated microcode the
> -         protection takes effect; otherwise a few CPU cycles are wasted
> -         pointlessly.
> -     * - 'Mitigation: Clear CPU buffers'
> -       - The processor is vulnerable and the CPU buffer clearing mitigation is
> -         enabled.
> -     * - 'Unknown: No mitigations'
> -       - The processor vulnerability status is unknown because it is
> -	 out of Servicing period. Mitigation is not attempted.
> +  +------------------------+--------------------------------------------------+
> +  | 'Not affected'         | The processor is not vulnerable.                 |
> +  +------------------------+--------------------------------------------------+
> +  | 'Vulnerable'           | The processor is vulnerable, but no mitigation   |
> +  |                        | enabled.                                         |
> +  +------------------------+--------------------------------------------------+
> +  | 'Vulnerable: Clear CPU | The processor is vulnerable but microcode is not |
> +  | buffers attempted, no  | updated. The mitigation is enabled on a best     |
> +  | microcode'             | effort basis.                                    |
> +  |                        |                                                  |
> +  |                        | The processor is vulnerable but the availability |
> +  |                        | of the microcode based mitigation mechanism is   |
> +  |                        | not advertised via CPUID, the kernel selects a   |
> +  |                        | best effort mitigation mode. This mode invokes   |
> +  |                        | the mitigation instructions without a guarantee  |
> +  |                        | that they clear the CPU buffers.                 |
> +  |                        |                                                  |
> +  |                        | This is done to address virtualization scenarios |
> +  |                        | where the host has the microcode update applied, |
> +  |                        | but the hypervisor is not yet updated to expose  |
> +  |                        | the CPUID to the guest. If the host has updated  |
> +  |                        | microcode the protection takes effect; otherwise |
> +  |                        | a few CPU cycles are wasted pointlessly.         |
> +  +------------------------+--------------------------------------------------+
> +  | 'Mitigation: Clear CPU | The processor is vulnerable and the CPU buffer   |
> +  | buffers'               | clearing mitigation is enabled.                  |
> +  +------------------------+--------------------------------------------------+
> +  | 'Unknown: No           | The processor vulnerability status is unknown    |
> +  | mitigations'           | because it is out of Servicing period.           |
> +  |                        | Mitigation is not attempted.                     |
> +  +------------------------+--------------------------------------------------+
>  
>  Definitions:
>  ------------
> diff --git a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
> index 0585d02b9a6c..e5f324206bed 100644
> --- a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
> +++ b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
> @@ -86,17 +86,18 @@ which mitigations are active. The relevant sysfs file is:
>  
>  The possible values in this file are:
>  
> -  .. list-table::
> -
> -     * - 'Not affected'
> -       - The processor is not vulnerable
> -     * - 'Vulnerable'
> -       - The processor is vulnerable, but no mitigation enabled
> -     * - 'Vulnerable: No microcode'
> -       - The processor is vulnerable but microcode is not updated.
> -     * - 'Mitigation: Clear Register File'
> -       - The processor is vulnerable and the CPU buffer clearing mitigation is
> -	 enabled.
> +  +--------------------+---------------------------------------------------+
> +  | 'Not affected'     | The processor is not vulnerable.                  |
> +  +--------------------+---------------------------------------------------+
> +  | 'Vulnerable'       | The processor is vulnerable, but no mitigation    |
> +  |                    | enabled.                                          |
> +  +--------------------+---------------------------------------------------+
> +  | 'Vulnerable: No    | The processor is vulnerable but microcode is not  |
> +  | microcode'         | updated.                                          |
> +  +--------------------+---------------------------------------------------+
> +  | 'Mitigation: Clear | The processor is vulnerable and the CPU buffer    |
> +  | Register File'     | clearing mitigation is enabled.                   |
> +  +--------------------+---------------------------------------------------+
>  
>  References
>  ----------
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index 132e0bc6007e..114139f86d1a 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -336,18 +336,20 @@ The sysfs file showing Spectre variant 1 mitigation status is:
>  
>  The possible values in this file are:
>  
> -  .. list-table::
> -
> -     * - 'Not affected'
> -       - The processor is not vulnerable.
> -     * - 'Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers'
> -       - The swapgs protections are disabled; otherwise it has
> -         protection in the kernel on a case by case base with explicit
> -         pointer sanitation and usercopy LFENCE barriers.
> -     * - 'Mitigation: usercopy/swapgs barriers and __user pointer sanitization'
> -       - Protection in the kernel on a case by case base with explicit
> -         pointer sanitation, usercopy LFENCE barriers, and swapgs LFENCE
> -         barriers.
> +  +------------------------------+--------------------------------------------+
> +  | 'Not affected'               | The processor is not vulnerable.           |
> +  +------------------------------+--------------------------------------------+
> +  | 'Vulnerable: __user pointer  | The swapgs protections are disabled;       |
> +  | sanitization and usercopy    | otherwise it has protection in the kernel  |
> +  | barriers only; no swapgs     | on a case by case basis with explicit      |
> +  | barriers'                    | pointer sanitization and usercopy LFENCE   |
> +  |                              | barriers.                                  |
> +  +------------------------------+--------------------------------------------+
> +  | 'Mitigation: usercopy/swapgs | Protection in the kernel on a case by case |
> +  | barriers and __user pointer  | basis with explicit pointer sanitization,  |
> +  | sanitization'                | usercopy LFENCE barriers, and swapgs       |
> +  |                              | LFENCE barriers.                           |
> +  +------------------------------+--------------------------------------------+
>  
>  However, the protections are put in place on a case by case basis,
>  and there is no guarantee that all possible attack vectors for Spectre
> @@ -431,20 +433,21 @@ The possible values in this file are:
>  
>    - Branch History Injection (BHI) protection status:
>  
> -.. list-table::
> -
> - * - BHI: Not affected
> -   - System is not affected
> - * - BHI: Retpoline
> -   - System is protected by retpoline
> - * - BHI: BHI_DIS_S
> -   - System is protected by BHI_DIS_S
> - * - BHI: SW loop, KVM SW loop
> -   - System is protected by software clearing sequence
> - * - BHI: Vulnerable
> -   - System is vulnerable to BHI
> - * - BHI: Vulnerable, KVM: SW loop
> -   - System is vulnerable; KVM is protected by software clearing sequence
> +  +---------------------+----------------------------------------------------+
> +  | 'BHI: Not affected' | System is not affected.                            |
> +  +---------------------+----------------------------------------------------+
> +  | 'BHI: Retpoline'    | System is protected by retpoline.                  |
> +  +---------------------+----------------------------------------------------+
> +  | 'BHI: BHI_DIS_S'    | System is protected by BHI_DIS_S.                  |
> +  +---------------------+----------------------------------------------------+
> +  | 'BHI: SW loop, KVM  | System is protected by software clearing sequence. |
> +  | SW loop'            |                                                    |
> +  +---------------------+----------------------------------------------------+
> +  | 'BHI: Vulnerable'   | System is vulnerable to BHI.                       |
> +  +---------------------+----------------------------------------------------+
> +  | 'BHI: Vulnerable,   | System is vulnerable; KVM is protected by software |
> +  | KVM: SW loop'       | clearing sequence.                                 |
> +  +---------------------+----------------------------------------------------+
>  
>  Full mitigation might require a microcode update from the CPU
>  vendor. When the necessary microcode is not available, the kernel will
> diff --git a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
> index 444f84e22a91..24811752d9a9 100644
> --- a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
> +++ b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
> @@ -93,30 +93,39 @@ of mitigated systems. The relevant sysfs file is:
>  
>  The possible values in this file are:
>  
> -.. list-table::
> -
> -   * - 'Vulnerable'
> -     - The CPU is affected by this vulnerability and the microcode and kernel mitigation are not applied.
> -   * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
> -     - The processor is vulnerable but microcode is not updated. The
> -       mitigation is enabled on a best effort basis.
> -
> -       If the processor is vulnerable but the availability of the microcode
> -       based mitigation mechanism is not advertised via CPUID, the kernel
> -       selects a best effort mitigation mode. This mode invokes the mitigation
> -       instructions without a guarantee that they clear the CPU buffers.
> -
> -       This is done to address virtualization scenarios where the host has the
> -       microcode update applied, but the hypervisor is not yet updated to
> -       expose the CPUID to the guest. If the host has updated microcode the
> -       protection takes effect; otherwise a few CPU cycles are wasted
> -       pointlessly.
> -   * - 'Mitigation: Clear CPU buffers'
> -     - The microcode has been updated to clear the buffers. TSX is still enabled.
> -   * - 'Mitigation: TSX disabled'
> -     - TSX is disabled.
> -   * - 'Not affected'
> -     - The CPU is not affected by this issue.
> +  +------------------------+--------------------------------------------------+
> +  | 'Not affected'         | The processor is not affected by this            |
> +  |                        | vulnerability.                                   |
> +  +------------------------+--------------------------------------------------+
> +  | 'Vulnerable'           | The processor is affected by this vulnerability  |
> +  |                        | and the microcode and kernel mitigation are not  |
> +  |                        | applied.                                         |
> +  +------------------------+--------------------------------------------------+
> +  | 'Vulnerable: Clear CPU | The processor is vulnerable but microcode is not |
> +  | buffers attempted, no  | updated. The mitigation is enabled on a best     |
> +  | microcode'             | effort basis.                                    |
> +  |                        |                                                  |
> +  |                        | If the processor is vulnerable but the           |
> +  |                        | availability of the microcode based mitigation   |
> +  |                        | mechanism is not advertised via CPUID, the       |
> +  |                        | kernel selects a best effort mitigation mode.    |
> +  |                        | This mode invokes the mitigation instructions    |
> +  |                        | without a guarantee that they clear the CPU      |
> +  |                        | buffers.                                         |
> +  |                        |                                                  |
> +  |                        | This is done to address virtualization scenarios |
> +  |                        | where the host has the microcode update applied, |
> +  |                        | but the hypervisor is not yet updated to expose  |
> +  |                        | the CPUID to the guest. If the host has updated  |
> +  |                        | microcode the protection takes effect; otherwise |
> +  |                        | a few CPU cycles are wasted pointlessly.         |
> +  +------------------------+--------------------------------------------------+
> +  | 'Mitigation: Clear CPU | The microcode has been updated to clear the      |
> +  | buffers'               | buffers. TSX is still enabled.                   |
> +  +------------------------+--------------------------------------------------+
> +  | 'Mitigation: TSX       | TSX is disabled.                                 |
> +  | disabled'              |                                                  |
> +  +------------------------+--------------------------------------------------+
>  
>  Mitigation mechanism
>  --------------------

-- 
Jani Nikula, Intel

