Return-Path: <linux-kernel+bounces-444029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA3A9EFF9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB5F286616
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9C1DE4CA;
	Thu, 12 Dec 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfXfyzvI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C21AD9ED;
	Thu, 12 Dec 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044230; cv=none; b=UP0Nw0fTu3SxlM2FvnkILewvkDEtokQRkUSK9uAGbgdAfkFBzWjM8pO7KW9j3h/vpJohPoM7814GTDhO4e9IWIZ5IK8Rm475ldd/ulgjmgno5yCOLsqP1ecT2j26c5Wfs+qKHumbLH8RqowHQu10OEuTmjJPBxhKZYCuXKBN7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044230; c=relaxed/simple;
	bh=/mf7rv+3KEx/PrhkxoX5mnEASmUXUBGL+lt5kPUv9H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI37B43oJhybLSSZt8PovcjvKuNlzDvTAQC1hqTuXAtP7eCVDYlCjulEy3gzwNdUxQlMchTZHBEYuNulWBSWbRst043q75WLbMzdK04AzGVGTY7rrICdlWFUzElGP1Gk9WXrqG0km3rPNA9eGoONa2eNwjdlqG03pNZWjOC8QVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfXfyzvI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734044228; x=1765580228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/mf7rv+3KEx/PrhkxoX5mnEASmUXUBGL+lt5kPUv9H0=;
  b=nfXfyzvIkzp+w5wauyXl12okkqqHea9gwU8RM+7WSwFdwnHRzcFNgMZz
   uqBws2BceMJbkZ+6nBmsO+Zw+G5mBHzLdf7O1wf2matnNqXBcI2eoCNIB
   CMtKO5JBAQtVmbWRWrJAo/ELIVQAWREaL1vrdbifdvQIptMIzvuQYtBui
   k3UaZdK1h7WVRCIDQyyZPK+gCT3L42fkPzAd2FmJo4JC3zUFoIMDUi7Cx
   LAxbJ6mPXaO8HTQvlazuFMw9KuOh4EmSBbTglnMp1sjKjSRg7Q3kt0Hbz
   8LHoNdnGDRLz9Zk1J4oY3c5xsJNbOC0k9vlfZEZ0ZZ/u9BuxrK2gJ0GVH
   A==;
X-CSE-ConnectionGUID: 4lKDNGg1RqaoIMaw1MDtJA==
X-CSE-MsgGUID: mV5vc2WXRbuUXdiPF7DoKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="37334230"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="37334230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 14:57:07 -0800
X-CSE-ConnectionGUID: xdJRhPbhR0u6u4s7NCOMBg==
X-CSE-MsgGUID: d7qMtfEqTAmWmuQGpa11/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96111293"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 14:57:07 -0800
Date: Thu, 12 Dec 2024 14:57:05 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	peternewman@google.com, fenghua.yu@intel.com, x86@kernel.org,
	hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
	thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, andipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v10 23/24] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Message-ID: <Z1tqQaflpkcGRVzx@agluck-desk3>
References: <cover.1734034524.git.babu.moger@amd.com>
 <865b7f067bd0a1e90a07950fc4edce8dcf1c99e1.1734034524.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865b7f067bd0a1e90a07950fc4edce8dcf1c99e1.1734034524.git.babu.moger@amd.com>

On Thu, Dec 12, 2024 at 02:15:26PM -0600, Babu Moger wrote:
> +static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
> +					    struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	struct rdt_mon_domain *dom;
> +	struct rdtgroup *rdtg;
> +	char str[10];
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +	rdt_last_cmd_clear();
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
> +		mutex_unlock(&rdtgroup_mutex);
> +		cpus_read_unlock();
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +		struct rdtgroup *crg;
> +
> +		seq_printf(s, "%s//", rdtg->kn->name);
> +
> +		list_for_each_entry(dom, &r->mon_domains, hdr.list)
> +			seq_printf(s, "%d=%s;", dom->hdr.id,
> +				   rdtgroup_mon_state_to_str(r, dom, rdtg, str));
> +		seq_putc(s, '\n');

Other resctrl files with domain lists use ';' as a separator, not a
terminator. This code results in:

//0=tl;1=tl;

rather than

//0=tl;1=tl

> +
> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +				    mon.crdtgrp_list) {
> +			seq_printf(s, "%s/%s/", rdtg->kn->name, crg->kn->name);
> +
> +			list_for_each_entry(dom, &r->mon_domains, hdr.list)
> +				seq_printf(s, "%d=%s;", dom->hdr.id,
> +					   rdtgroup_mon_state_to_str(r, dom, crg, str));
> +			seq_putc(s, '\n');

Ditto.

> +		}
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +	return 0;
> +}

