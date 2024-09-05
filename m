Return-Path: <linux-kernel+bounces-317489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC8496DF0A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEF0B22787
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E519FA7E;
	Thu,  5 Sep 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXQ2vv6T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792819F489
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552049; cv=none; b=NE54RUhJBcWyPfd3ApnSTHstTgDzdoLEGoILyXWBGoGI+ocZZTCIzMYz+HX0B+/9a59ImmJP9Sv0DnrXAuIQZomdHqvnjIG9C+9OQTJzHlhkCsFJg0WAnb91cI/iWPvrpi5Ax1gO2KBHcvbcJQc8TjPDov7QcdtvOB0m8kwETWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552049; c=relaxed/simple;
	bh=OduRHAVBGOjYFmib5cZvnd9hU/f1pWV6cNPWVVpgWck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX6hZoTBrAX/lxz0P4m0WJ3e9V0bRPLRegqR4XzCE7DMlO1vviBOunkRvLd4nuo57d6/b1iWrjSX8joNlUsdmhOVp4RaC9bD4SUErNrbTmP2lIf0wCvf2pthGbtwkAgDWK4nMkhBx4z50Rt/WwtSKWLgxmo7xStlg0nixTHfLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXQ2vv6T; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725552048; x=1757088048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OduRHAVBGOjYFmib5cZvnd9hU/f1pWV6cNPWVVpgWck=;
  b=CXQ2vv6TXjlVx/wCgrKNqe7a4iemhNe2vJnay9zbWoTaoHw3RPY+YiSf
   LZI82EaILMT+vVUF6Cs2IQtMHhwtFDu4Zvk2U7o0hshFgU6+BujHhQ697
   9rm2uJoONOfBw6xGjIzRUJJNGNEZo+tKL4bWKpUqR5wqUKtZpM7Ptn/CL
   r0RCLdJ4/NzIAMMZnLy4CanQRawSHI3Afyk1gpRUzI/AaytBDDp7hws5A
   20pPbdm0JZHbiAsQBeXTCkOuxbgieOIoDoPbNBmjhdrIi5OEB0SfAE7SP
   xU108Lo9ISygsOYqhtyMXf3Mj0zoV93kiH++x+ybqLjxzsWdpgQLbOA/+
   Q==;
X-CSE-ConnectionGUID: Bznn2VnkQPGqWbs9qwyvAg==
X-CSE-MsgGUID: 3441DCKWTsK95tCEypwHzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24147239"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24147239"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:00:47 -0700
X-CSE-ConnectionGUID: 1Y7tpDMhTcOBMXbhts50QQ==
X-CSE-MsgGUID: Td1pJgRVSuacoTssJHuW0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70462544"
Received: from bllerma-mobl2.amr.corp.intel.com (HELO desk) ([10.125.147.102])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:00:47 -0700
Date: Thu, 5 Sep 2024 09:00:45 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: [PATCH v6 1/3] x86/entry_32: Do not clobber user EFLAGS.ZF
Message-ID: <20240905-fix-dosemu-vm86-v6-1-7aff8e53cbbf@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com>

Opportunistic SYSEXIT executes VERW to clear CPU buffers after user EFLAGS
are restored. This can clobber user EFLAGS.ZF.

Move CLEAR_CPU_BUFFERS before the user EFLAGS are restored. This ensures
that the user EFLAGS.ZF is not clobbered.

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Reported-by: Jari Ruusu <jariruusu@protonmail.com>
Closes: https://lore.kernel.org/lkml/yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com/
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814efbff6..9ad6cd89b7ac 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -871,6 +871,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Now ready to switch the cr3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	/* Clobbers ZF */
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
@@ -881,7 +883,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.

-- 
2.34.1



