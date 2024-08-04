Return-Path: <linux-kernel+bounces-273898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18838946F59
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FA92816C9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B29750288;
	Sun,  4 Aug 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6I8/f52"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421971E86A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722782779; cv=none; b=SJFbPwgnFxaSgIPCeSnDCJKaQ6EhuvzPONf4lj59xJTkrArA69d+Ll/dz9XnkBdvHut73EZV7tokL8rbgzPM/tNRB4RyF0mBnj1iq5qME7Gsx8hR2tuVZFBHESZFOkK3DbPAkRW90YBWR3Y2RZxPThLgwKeJXwB6a3iXGRtdcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722782779; c=relaxed/simple;
	bh=tX2MZCGvCBsJFE1Fnbp5nwfRaRqQG7QQf6nwoYU3/XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BorSZgdU+3e1kfjZE3J4A2hoMcruKIv9AzPfLCZzKsjz0qg1ejCP5+b6dcUnS4xjkAtw+vsPQBgEPeWqqhIuKyk/ELMVHFRWx6tuzXsBUgkuEdEWysoIf1tXjhhLoBr2De1Wjk9drTPcen4YSSqTKMIvszzg5piyYthEUGY9FCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6I8/f52; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722782777; x=1754318777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tX2MZCGvCBsJFE1Fnbp5nwfRaRqQG7QQf6nwoYU3/XM=;
  b=Z6I8/f52NQkNRpWvf+/MBMgExmFqJeTvfPyHLlms/bGn0U8U9a7r67XY
   ajDCfbl82BgvFSEZon8U50YYzcGvG2fVNsqpH+Rj5Vjm6ihLiLqXZIyRv
   rMd3Qmiinb+mU4H0wEqOPer4k7SChl1nwN2riZuFUpYiRVSOSQm7G1RTS
   +V0MF224KSR3ce9n3rwatB03t9IuCQnhrvTYoImRC5JtxuhXKBw3zvjmX
   zZFEuSW7c9uqCgUrQFECVSEFQvag5FvORanU4HYJD7ykJ7F8uDUA3H823
   2IsW/+HY2MvfQzxwW1Ywm3z3krPE7pXb+jdEkpnH+8iRhMMCeqsd6NIOT
   g==;
X-CSE-ConnectionGUID: iNllnTaXR4yWcaiZpiszdw==
X-CSE-MsgGUID: AoPR4IfgQLirpkpIAPQ+9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20559222"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="20559222"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 07:46:17 -0700
X-CSE-ConnectionGUID: wCMpDcHrQ1+ak08//FXsHQ==
X-CSE-MsgGUID: XTERBRsZSW2ycGd9p59/KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="60051809"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 07:46:15 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	qiuxu.zhuo@intel.com
Subject: Re: [patch 08/15] x86/ioapic: Cleanup guarded debug printk()s
Date: Sun,  4 Aug 2024 22:34:43 +0800
Message-Id: <20240804143443.25139-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240802155440.714763708@linutronix.de>
References: <20240802155440.714763708@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> From: Thomas Gleixner <tglx@linutronix.de>
> To: LKML <linux-kernel@vger.kernel.org>
> Cc: x86@kernel.org
> Subject: [patch 08/15] x86/ioapic: Cleanup guarded debug printk()s
> 
> Cleanup the APIC printk()s which are inside of a apic verbosity guarded
> region by using apic_dbg() for the KERN_DEBUG level prints.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/apic/io_apic.c |   67 +++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 38 deletions(-)
> 
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1186,26 +1186,21 @@ static void io_apic_print_entries(unsign
>  	char buf[256];
>  	int i;
>  
> -	printk(KERN_DEBUG "IOAPIC %d:\n", apic);
> +	apic_dbg("IOAPIC %d:\n", apic);
>  	for (i = 0; i <= nr_entries; i++) {
>  		entry = ioapic_read_entry(apic, i);
> -		snprintf(buf, sizeof(buf),
> -			 " pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d)",
> -			 i,
> -			 entry.masked ? "disabled" : "enabled ",
> +		snprintf(buf, sizeof(buf)," pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d)",

Need a space after the 2nd ','.

> +			 i, entry.masked ? "disabled" : "enabled ",
>  			 entry.is_level ? "level" : "edge ",

> [...]

> @@ -1226,19 +1221,15 @@ static void __init print_IO_APIC(int ioa
>  			reg_03.raw = io_apic_read(ioapic_idx, 3);
>  	}
>  
> [...]
> +	apic_dbg(".... register #01: %08X\n", *(int *)&reg_01);
> +	apic_dbg(".......     : max redirection entries: %02X\n",reg_01.bits.entries);

Need a space after ','.

