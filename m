Return-Path: <linux-kernel+bounces-526405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E74A3FE3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB5B70214E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E42512F1;
	Fri, 21 Feb 2025 18:06:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C9250C15;
	Fri, 21 Feb 2025 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161172; cv=none; b=Jx4VrcLQeSX5eyvvpQ7tlgOzDJaD8ZpbbMlj9tuMBuOEOzUAFf4yOVdUBQ1AtXFlVqbMSK9COKQCLSxx3vY9Z5AkHb/k3qCHqvVkOtJT1n4GjM/ISLV0/QFO4NG2MWKproS93yPZ5fw8pcTowmD+5lAHXnsjCzfzqsVzb3OpWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161172; c=relaxed/simple;
	bh=mMvWUoSRlAaNEsLyBJHtnf16wTWbSTlAbIB9/7o41KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEVNKCevW4rgzlkGTspFjg40d7k/NAOz/9awpWKfhS5IVLMKQ+ZnzoFqgN3LRqadxoJNtTQQKve5DAUWvzRDvMYeDDlKJikxgG166/1oHaWC2CDWW8lTFy6euewjHfJgyl2MBRINtfCZtDrH5KafTKb01hz+2qBx9VhyS4lgzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C08D61C2B;
	Fri, 21 Feb 2025 10:06:26 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D31D3F59E;
	Fri, 21 Feb 2025 10:06:04 -0800 (PST)
Message-ID: <5b6cfa6e-9f2f-4d84-9b63-14386a2fa3dc@arm.com>
Date: Fri, 21 Feb 2025 18:06:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/23] x86/resctrl: Introduce the interface to display
 monitor mode
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
 <b298391d4db5806c145ba0b92d79e02a4df8d8c5.1737577229.git.babu.moger@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <b298391d4db5806c145ba0b92d79e02a4df8d8c5.1737577229.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 22/01/2025 20:20, Babu Moger wrote:
> Introduce the interface file "mbm_assign_mode" to list monitor modes
> supported.
> 
> The "mbm_cntr_assign" mode provides the option to assign a counter to
> an RMID, event pair and monitor the bandwidth as long as it is assigned.
> 
> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
> 
> The "default" mode is the existing monitoring mode that works without the
> explicit counter assignment, instead relying on dynamic counter assignment
> by hardware that may result in hardware not dedicating a counter resulting
> in monitoring data reads returning "Unavailable".
> 
> Provide an interface to display the monitor mode on the system.
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_cntr_assign]
> default

> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index fb90f08e564e..b5defc5bce0e 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -257,6 +257,32 @@ with the following files:
>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>  	    0=0x30;1=0x30;3=0x15;4=0x15
>  
> +"mbm_assign_mode":
> +	Reports the list of monitoring modes supported. The enclosed brackets
> +	indicate which mode is enabled.
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +	  [mbm_cntr_assign]
> +	  default
> +
> +	"mbm_cntr_assign":
> +
> +	In mbm_cntr_assign, monitoring event can only accumulate data while
> +	it is backed by a hardware counter. The user-space is able to specify
> +	which of the events in CTRL_MON or MON groups should have a counter
> +	assigned using the "mbm_assign_control" file. The number of counters
> +	available is described in the "num_mbm_cntrs" file. Changing the mode
> +	may cause all counters on a resource to reset.

> +	"default":
> +
> +	In default mode, resctrl assumes there is a hardware counter for each
> +	event within every CTRL_MON and MON group. On AMD platforms, it is
> +	recommended to use mbm_cntr_assign mode if supported, because reading
> +	"mbm_total_bytes" or "mbm_local_bytes" will report 'Unavailable' if
> +	there is no counter associated with that event.

But if you read a value instead of "Unavailable", that doesn't mean the value is correct.
For two reads that succeed, the counter may have been reset in the middle.

I'm suggesting something like:
| it is recommended to use mbm_cntr_assign mode if supported, to avoid counters
| being re-allocated by hardware. This can cause a misleading value to be read,
| or if no counter is associated with that event "Unavailable".


>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f91fe605766f..3880480a41d2 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -854,6 +854,30 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
> +					struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (r->mon.mbm_cntr_assignable) {
> +		if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +			seq_puts(s, "[mbm_cntr_assign]\n");
> +			seq_puts(s, "default\n");
> +		} else {
> +			seq_puts(s, "mbm_cntr_assign\n");
> +			seq_puts(s, "[default]\n");
> +		}

What do you think to an architecture being able to opt-out of this flexibility?

If there aren't enough counters I can expose what the hardware has through this interface
- but if user-space turns it off ... then what?

For MPAM this would need to be some best-effort software allocation strategy that I'd
rather not write - its not a problem that can be solved, and any value that is reported is
likely to be wrong. For ABMC platforms, existing stable kernels expose a value, so being
able to preserve the existing behaviour makes sense. MPAM doesn't have this problem.

Something like this:
----------%<----------
@@ -861,16 +861,21 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open
_file *of,
                                        struct seq_file *s, void *v)
 {
        struct rdt_resource *r = of->kn->parent->priv;
+       bool enabled = resctrl_arch_mbm_cntr_assign_enabled(r);

        mutex_lock(&rdtgroup_mutex);

        if (r->mon.mbm_cntr_assignable) {
-               if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
+               if (enabled)
                        seq_puts(s, "[mbm_cntr_assign]\n");
-                       seq_puts(s, "default\n");
-               } else {
-                       seq_puts(s, "mbm_cntr_assign\n");
+               else
                        seq_puts(s, "[default]\n");
+
+               if (!IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) {
+                       if (enabled)
+                               seq_puts(s, "default\n");
+                       else
+                               seq_puts(s, "mbm_cntr_assign\n");
                }
        } else {
                seq_puts(s, "[default]\n");
----------%<----------

x86 wouldn't define CONFIG_RESCTRL_ASSIGN_FIXED, arm64 would, meaning for MPAM the file
would be either:
 | [default]
or
| [mbm_cntr_assign]


> +	} else {
> +		seq_puts(s, "[default]\n");
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return 0;
> +}


Thanks,

James

