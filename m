Return-Path: <linux-kernel+bounces-356041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF553995B63
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 042F2B23D77
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE77216446;
	Tue,  8 Oct 2024 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHzdjsHg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50231D0F44
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428917; cv=none; b=WeTttqMq4SpEAGndswzWu3AknPuaWdW/nTJErlUEEepQ7U3vACU2sdBamW+EGxJtkMhCU+ZQSzyNus9LMPLz75cFnmM+I1DxHhwEQKLcjGd1e/95p1ZZlp2bsgAdZ8f9TA+LrHn3zp8MbrrPaly+at4BuucX8CrlA/mfhuLDNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428917; c=relaxed/simple;
	bh=FoVKTD3zrmoWGWg+wvfB+nxWvWGc06CtDz8PpdFUSfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELyCoS1qkNvaUDkGnY/RM5+PlpILJik3VeS6WJQGhD8scDRmQCh+7bRFVQOSUksMx/yXJtgzTtlj88E+Jsj9uC3qjhcf+3UxX7gEaX90V7rFY9MYInQKTgDMtbxfZSsS088zTBRPpDJL9KTvHx1IYvAqbJ63j6E2wuwWmguCudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHzdjsHg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428916; x=1759964916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FoVKTD3zrmoWGWg+wvfB+nxWvWGc06CtDz8PpdFUSfU=;
  b=mHzdjsHgd7r3QOwwjvVPsfUFLlrxBfAgac3hPG/hzUq/rE8D/33d2Wbt
   1Iy5JvckQLqAYgKWhMz5BJcCQeP9sFD47m1TGSziUK309FkHbFGKVOL1D
   jHEhrpwRxJ+tJMLVpqFRjxo/Qw5LKj1N9r+rwXm5o/EEePWKkKRUtWzRr
   zg/vOqtgYaJ6A/yR01wXNVPbsk/dpI6dDZDVN3TLuuzkNXzG3g5+YWhjh
   ucVDvrQd37itMaamrx9EjkpFO1BreKTk/sNTti8aNYJGWPUxCcNdSS+o7
   1+aJ456yZ//wlR9XvA3JI+CtgP3NlthrUsxs5qPpfjRJQAHZU47/jmsXI
   Q==;
X-CSE-ConnectionGUID: fRHzqJv/SrOtLYyfVLawag==
X-CSE-MsgGUID: lzvvWAkTT7Sf88wJzW7bKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31388601"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="31388601"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:08:35 -0700
X-CSE-ConnectionGUID: h6NX9e0uQgaLK5/FJs61hQ==
X-CSE-MsgGUID: +qWONnZzR7S3A3d/jVIUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="76032910"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:08:34 -0700
Date: Tue, 8 Oct 2024 16:08:33 -0700
From: Tony Luck <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v5 40/40] x86/resctrl: Add python script to move resctrl
 code to /fs/resctrl
Message-ID: <ZwW7cWgXJmfW8AQP@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-41-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-41-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:47PM +0000, James Morse wrote:
> +functions_to_move = [
> +	# common
> +	"pr_fmt",
> +
> +	# ctrlmon.c
> +	"rdt_parse_data",
> +	"(ctrlval_parser_t)",
> +	"bw_validate",
> +	"parse_bw",
> +	"cbm_validate",
> +	"parse_cbm",
> +	"get_parser",
> +	"parse_line",
> +	"rdtgroup_parse_resource",
> +	"rdtgroup_schemata_write",
> +	"show_doms",
> +	"rdtgroup_schemata_show",
> +	"smp_mon_event_count",
> +	"mon_event_read",
> +	"rdtgroup_mondata_show",
> +
> +	# internal.h
> +	"MBM_OVERFLOW_INTERVAL",
> +	"CQM_LIMBOCHECK_INTERVAL",
> +	"cpumask_any_housekeeping",
> +	"rdt_fs_context",
> +	"rdt_fc2context",
> +	"mon_evt",
> +	"mon_data_bits",
> +	"rmid_read",
> +	"resctrl_schema_all",
> +	"resctrl_mounted",
> +	"rdt_group_type",
> +	"rdtgrp_mode",
> +	"mongroup",
> +	"rdtgroup",
> +	"RFTYPE_FLAGS_CPUS_LIST",

Something goes wrong with moving the RFTYPE_* defines. A new copy
shows up in fs/resctrl/internal.h but the old copy isn't removed from
arch/x86/kernel/cpu/resctrl/internal.h

-Tony

