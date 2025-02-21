Return-Path: <linux-kernel+bounces-525899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6891A3F70C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799EE424F78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C803120F093;
	Fri, 21 Feb 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tna6WbAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94220F083;
	Fri, 21 Feb 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147604; cv=none; b=ez+fATwUSlyq+8Bf8UvJMm9rBl8XfogHcStO8fcr2SYy/9gOOTWOR0kjpDFP+o5rpk4vLIc3UTnZM2Ubp07tJkp25lpGU70hkLKHgB9El07vJqlaEXawWlCJwEIKWudChIwTGevyv2aHyWPE6WiEL8JTvL8ol8GtbS0EEDRenZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147604; c=relaxed/simple;
	bh=16wc131hRy3vmO/f0E6njdkMNEF4EscGQQXDlDpJIPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eS8iaFtuqtY3m40vzPEqibFO9m0qMnKhSRf1yV93Wv/B5PlTCvO4RmjzA5pdbMNLuKx/21dfWTbZAexjJmlnx6JE4DtVMAqexg1dSAJpqNdAKTd5DfdmDEmjziz+E0RYyV6pMJSMwSf20hd+5WMrNc/7VO2eusYPgTFsrGOEND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tna6WbAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F25C4CEE9;
	Fri, 21 Feb 2025 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740147603;
	bh=16wc131hRy3vmO/f0E6njdkMNEF4EscGQQXDlDpJIPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tna6WbAM5LDg/JBcO4CbF0oQY/50f2nYN3Rzih61Pov2dEsgjj2Kq1OHAuV2riyaP
	 MJq92H5A3boVXUUf5ElobX5St5CDF/G1/lqPgN6GJTYe6En+tdVpWNehU6aQTzkJTN
	 k6E3clYLIXmKwOc/XJ3NnN/CxdrCx97vqVThyJCkjldH90UVShR7P/OuPEjQeFgQtf
	 ImzQ13Wj5+biI2pKWcjLC6JLqLIZxGG1Z5yHj+BbsRQI/rHKGyrmM8M81H7IBKdWyS
	 7t2hIrHGTa+pfLvzcruQx6HDIJeU8SIVlJKc0gfAJ9lzr/l6eQX/os/ct5cauVeIIQ
	 R5vHrnv9k1t2Q==
Date: Fri, 21 Feb 2025 15:19:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH] ACPI/processor_idle: Export acpi_processor_ffh_play_dead()
Message-ID: <Z7iLie2SvPtUAu96@gmail.com>
References: <202502151207.FA9UO1iX-lkp@intel.com>
 <de5bf4f116779efde315782a15146fdc77a4a044.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de5bf4f116779efde315782a15146fdc77a4a044.camel@linux.intel.com>


* Artem Bityutskiy <artem.bityutskiy@linux.intel.com> wrote:

> On Sat, 2025-02-15 at 12:51 +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
> > head:   96040f7273e2bc0be1871ad9ed4da7b504da9410
> > commit: 541ddf31e30022b8e6f44b3a943964e8f0989d15 [3/5] ACPI/processor_idle: Add FFH state handling
> > config: x86_64-randconfig-077-20250214 (https://download.01.org/0day-ci/archive/20250215/202502151207.FA9UO1iX-lkp@intel.com/config)
> > compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502151207.FA9UO1iX-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202502151207.FA9UO1iX-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > > > ERROR: modpost: "acpi_processor_ffh_play_dead" [drivers/acpi/processor.ko] undefined!
> 
> Oh, this is the 'CONFIG_ACPI_PROCESSOR=m' case. The function export is missing. Sorry for this.
> 
> The below patch fixes the issue. Could you please fold it into the following commit?
> 
> 	541ddf31e300 ACPI/processor_idle: Add FFH state handling
> 
> I am not sure about the rules of the tip tree in cases like this, please direct me on
> how to handle the delivery of the fix.

Additional patches have been added since then to tip:x86/cpu, so I 
created the commit below, and added your Signed-off-by.

Thanks,

	Ingo

==========================>
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Date: Sun, 16 Feb 2025 14:26:14 +0200
Subject: [PATCH] ACPI/processor_idle: Export acpi_processor_ffh_play_dead()

The kernel test robot reported the following build error:

  >> ERROR: modpost: "acpi_processor_ffh_play_dead" [drivers/acpi/processor.ko] undefined!

Caused by this recently merged commit:

  541ddf31e300 ("ACPI/processor_idle: Add FFH state handling")

The build failure is due to an oversight in the 'CONFIG_ACPI_PROCESSOR=m' case,
the function export is missing. Add it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502151207.FA9UO1iX-lkp@intel.com/
Fixes: 541ddf31e300 ("ACPI/processor_idle: Add FFH state handling")
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/de5bf4f116779efde315782a15146fdc77a4a044.camel@linux.intel.com
---
 arch/x86/kernel/acpi/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 5bdb65516969..86c87c01d23d 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -214,6 +214,7 @@ void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
 	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
 	mwait_play_dead(percpu_entry->states[cx->index].eax);
 }
+EXPORT_SYMBOL_GPL(acpi_processor_ffh_play_dead);
 
 void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 {

