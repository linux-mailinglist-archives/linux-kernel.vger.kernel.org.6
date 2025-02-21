Return-Path: <linux-kernel+bounces-526409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9212A3FE43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C107033F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A845B2512E0;
	Fri, 21 Feb 2025 18:08:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8211C250C15;
	Fri, 21 Feb 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161281; cv=none; b=Soe1ZWSO+8Y1WPm2KzxU4p8ixYWAMfvJV+MENsjyupPraObYXPC1YeOz2TcJ0Yc72j1UJ5cdIsDht1iviaxSYDcBMxAIh6VEkHl8CUwG+NlMItKVRy2yPCD/PCdft6HpsNBPksad1U8UeUo/zJAcGpPS5psyOMJfupHiUZSM0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161281; c=relaxed/simple;
	bh=OqAAY9P7w8CZaB90FulQ6i99+Eihuh/hRRAyZ7GHsNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7xuMZnn7+BLERYD8Fl8DdrseU8XDUZBCktrRd5jeZcg8ykkBIKbSimu5Ot727awqCxgWWBKLzVTigP8TUCkWAxbXsEVErpM6S16y1rEyj+q6lYwoh4uNEkYLvBbHjlwCLwCCAd2nriqSK25V+IMpxSk7ojYtATnj89xSXzV74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF0391EA6;
	Fri, 21 Feb 2025 10:08:16 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606D33F59E;
	Fri, 21 Feb 2025 10:07:55 -0800 (PST)
Message-ID: <8f783170-feb4-4819-bbdc-cdf0a7c25dd0@arm.com>
Date: Fri, 21 Feb 2025 18:07:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com,
 peternewman@google.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 22/01/2025 20:20, Babu Moger wrote:
> When mbm_cntr_assign mode is enabled, users can designate which of the MBM
> events in the CTRL_MON or MON groups should have counters assigned.
> 
> Provide an interface for assigning MBM events by writing to the file:
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control. Using this interface,
> events can be assigned or unassigned as needed.
> 
> Format is similar to the list format with addition of opcode for the
> assignment operation.
>  "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Format for specific type of groups:
> 
>  * Default CTRL_MON group:
>          "//<domain_id><opcode><flags>"
> 
>  * Non-default CTRL_MON group:
>          "<CTRL_MON group>//<domain_id><opcode><flags>"
> 
>  * Child MON group of default CTRL_MON group:
>          "/<MON group>/<domain_id><opcode><flags>"
> 
>  * Child MON group of non-default CTRL_MON group:
>          "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Domain_id '*' will apply the flags on all the domains.
> 
> Opcode can be one of the following:
> 
>  = Update the assignment to match the flags
>  + Assign a new MBM event without impacting existing assignments.
>  - Unassign a MBM event from currently assigned events.
> 
> Assignment flags can be one of the following:
>  t  MBM total event
>  l  MBM local event
>  tl Both total and local MBM events
>  _  None of the MBM events. Valid only with '=' opcode. This flag cannot
>     be combined with other flags.

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6e29827239e0..299839bcf23f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1050,6 +1050,244 @@ static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,

> +static int resctrl_process_flags(struct rdt_resource *r,
> +				 enum rdt_group_type rtype,
> +				 char *p_grp, char *c_grp, char *tok)
> +{
> +	unsigned int op, mon_state, assign_state, unassign_state;
> +	char *dom_str, *id_str, *op_str;
> +	struct rdt_mon_domain *d;
> +	unsigned long dom_id = 0;
> +	struct rdtgroup *rdtgrp;
> +	char domain[10];
> +	bool found;
> +	int ret;
> +
> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
> +
> +	if (!rdtgrp) {
> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
> +		return -EINVAL;
> +	}
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +
> +	op_str = strpbrk(dom_str, "=+-");
> +
> +	if (op_str) {
> +		op = *op_str;
> +	} else {
> +		rdt_last_cmd_puts("Missing operation =, +, - character\n");
> +		return -EINVAL;
> +	}
> +
> +	id_str = strsep(&dom_str, "=+-");
> +
> +	/* Check for domain id '*' which means all domains */
> +	if (id_str && *id_str == '*') {
> +		d = NULL;
> +		goto check_state;
> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Verify if the dom_id is valid */
> +	found = false;
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
> +		return -EINVAL;
> +	}
> +
> +check_state:
> +	mon_state = resctrl_str_to_mon_state(dom_str);
> +
> +	if (mon_state == ASSIGN_INVALID) {
> +		rdt_last_cmd_puts("Invalid assign flag\n");
> +		goto out_fail;
> +	}
> +
> +	assign_state = 0;
> +	unassign_state = 0;
> +
> +	switch (op) {
> +	case '+':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		assign_state = mon_state;
> +		break;
> +	case '-':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		unassign_state = mon_state;
> +		break;
> +	case '=':
> +		assign_state = mon_state;
> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
> +		break;
> +	default:
> +		break;
> +	}


> +	if (unassign_state & ASSIGN_TOTAL) {
> +		ret = resctrl_unassign_cntr_event(r, d, rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (unassign_state & ASSIGN_LOCAL) {
> +		ret = resctrl_unassign_cntr_event(r, d, rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (assign_state & ASSIGN_TOTAL) {
> +		ret = resctrl_assign_cntr_event(r, d, rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (assign_state & ASSIGN_LOCAL) {
> +		ret = resctrl_assign_cntr_event(r, d, rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}

This sequence of if's allows the helpers to be called on platforms that doesn't support
both local and total. Could we reject such misconfiguration here in the parsing code?
You have these checks in rdtgroup_assign_cntrs() added in patch 17.


What do you think to trying to group these four by event type, and passing the event type
in as an argument? ... it ends up with a helper that takes a large number of arguments,
(both assign_state and unassign_state), but there is less repetition...


Thanks,

James

> +	goto next;
> +
> +out_fail:
> +	sprintf(domain, d ? "%ld" : "*", dom_id);
> +
> +	rdt_last_cmd_printf("Assign operation '%s%c%s' failed on the group %s/%s/\n",
> +			    domain, op, dom_str, p_grp, c_grp);
> +
> +	return -EINVAL;
> +}
> +

