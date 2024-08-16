Return-Path: <linux-kernel+bounces-290043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA0954EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3196728773C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C51BF30B;
	Fri, 16 Aug 2024 16:28:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FC16F2F0;
	Fri, 16 Aug 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825726; cv=none; b=p9YJ//iSVp1C6e/luaoj6SAVHfA5Yuvgav5a2u5HVDH/UTVatXpvDAPooSMOUMCQAA1kdzQ8sfw75BG4Cewmv80zNcA1pjd+h2nprwdGxK69GFIeO2S/vGOGfaFzEYC/jNXmh8dDIZcNlCsD9ErwSyOZaGIutuRkLO7AszLesro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825726; c=relaxed/simple;
	bh=LVw0tx1utB3GHkbmshgKd2Ittj3SbfVwKa96NMxP6xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bace3qbW0OqmsXOMF/F8vCBwBn/gIPIXNyI5clnycS04Y4UzC9jz+zPPDqdN4gwbvXUPgnnsjFZlndTmwfmPTlHB0YTQJ5sy6f+TYulmTIjN/86hWRajylkOk6qOXgfEQjQVuSSnwch+rwcugJ+FBGgn0+fDqpE5/SKW5jafufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA0513D5;
	Fri, 16 Aug 2024 09:29:08 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CBC13F58B;
	Fri, 16 Aug 2024 09:28:38 -0700 (PDT)
Message-ID: <2a65c646-ccd4-4e5e-bd1a-f56e69b1532c@arm.com>
Date: Fri, 16 Aug 2024 17:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/22] x86/resctrl: Introduce interface to list monitor
 states of all the groups
Content-Language: en-GB
To: Babu Moger <babu.moger@amd.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 dave.hansen@linux.intel.com, tglx@linutronix.de, corbet@lwn.net,
 fenghua.yu@intel.com, reinette.chatre@intel.com, mingo@redhat.com,
 bp@alien8.de
References: <cover.1722981659.git.babu.moger@amd.com>
 <821b725e9f00b4d423cc28d777d66d5681e1ba29.1722981659.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <821b725e9f00b4d423cc28d777d66d5681e1ba29.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 06/08/2024 23:00, Babu Moger wrote:
> Provide the interface to list the monitor states of all the resctrl
> groups in ABMC mode.
> 
> Example:
> $cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> List follows the following format:
> 
> "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> Format for specific type of groups:
> 
> - Default CTRL_MON group:
>   "//<domain_id>=<flags>"
> 
> - Non-default CTRL_MON group:
>   "<CTRL_MON group>//<domain_id>=<flags>"
> 
> - Child MON group of default CTRL_MON group:
>   "/<MON group>/<domain_id>=<flags>"
> 
> - Child MON group of non-default CTRL_MON group:
>   "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> Flags can be one of the following:
> t  MBM total event is enabled
> l  MBM local event is enabled
> tl Both total and local MBM events are enabled
> _  None of the MBM events are enabled


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d15fd1bde5f4..d7aadca5e4ab 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -965,6 +965,75 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static char *rdtgroup_mon_state_to_str(struct rdtgroup *rdtgrp,
> +				       struct rdt_mon_domain *d, char *str)
> +{
> +	char *tmp = str;
> +	int index;
> +
> +	/*
> +	 * Query the monitor state for the domain.
> +	 * Index 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
> +	 * Index 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
> +	 */
> +	index = mon_event_config_index_get(QOS_L3_MBM_TOTAL_EVENT_ID);
> +	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET &&
> +	    test_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map))
> +		*tmp++ = 't';
> +
> +	index = mon_event_config_index_get(QOS_L3_MBM_LOCAL_EVENT_ID);
> +	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET &&
> +	    test_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map))
> +		*tmp++ = 'l';
> +
> +	if (tmp == str)
> +		*tmp++ = '_';
> +
> +	*tmp = '\0';
> +	return str;
> +}
> +
> +static int rdtgroup_mbm_control_show(struct kernfs_open_file *of,
> +				     struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;

> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);

This is filesystem code, once it moves to /fs/ you can't grab an architecture specific
struct like this. (suggestion below).


> +	struct rdt_mon_domain *dom;
> +	struct rdtgroup *rdtg;
> +	char str[10];

Shouldn't new commands that might fail start with rdt_last_cmd_clear()?


> +	if (!hw_res->mbm_cntr_assign_enabled) {

I think this should be wrapped up as:
| resctrl_arch_mbm_cntr_assign_test(r)

as this flag is private to the architecture.


> +		rdt_last_cmd_puts("ABMC feature is not enabled\n");

lockdep barks that you need to hold rdtgroup_mutex when calling rdt_last_cmd_puts() -
otherwise this can run in parallel with another syscall.


> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +		struct rdtgroup *crg;
> +
> +		seq_printf(s, "%s//", rdtg->kn->name);
> +
> +		list_for_each_entry(dom, &r->mon_domains, hdr.list)
> +			seq_printf(s, "%d=%s;", dom->hdr.id,
> +				   rdtgroup_mon_state_to_str(rdtg, dom, str));
> +		seq_putc(s, '\n');
> +
> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +				    mon.crdtgrp_list) {
> +			seq_printf(s, "%s/%s/", rdtg->kn->name, crg->kn->name);
> +
> +			list_for_each_entry(dom, &r->mon_domains, hdr.list)
> +				seq_printf(s, "%d=%s;", dom->hdr.id,
> +					   rdtgroup_mon_state_to_str(crg, dom, str));
> +			seq_putc(s, '\n');
> +		}
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	return 0;
> +}


Thanks,

James


