Return-Path: <linux-kernel+bounces-569783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038DA6A7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E844189181B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26B2253EF;
	Thu, 20 Mar 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePKdm4JR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FC2253EC;
	Thu, 20 Mar 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478005; cv=none; b=ooOJzbeOlwjvvAXmEkFatSrEyEey8WJXKFeCYRVJsrLPnmQa2Ldvh6Fw+fxoImCq9cwGBT/oXfFTy7AqnrTeiJfRfOxsGVttGLds+08tmf7awc50eEBG3gR0WoI2OvM0x/uZfWcbmGDE8rvgre9F8NwfHkb1nZhObcakT23INmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478005; c=relaxed/simple;
	bh=LtWi7OjWEJ70WoRQ+ITfE9olr6zQDR0kAGYpbs7gw3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUtsYqmfBNxNgXFv+6EtoSATxHFMMe0eQBJf6ScLpjYH3zKNzS7mdvufFGkF7h0OWmWmDvVinXLUyow386hzfWIvw4nlmjmClQAyPVq4C9QTGpswM8xpWToGFiFUanPxKvPrTRbQshFeErIDqxkLpTTLOnv1Q9lxKU3RG00OPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePKdm4JR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478003; x=1774014003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LtWi7OjWEJ70WoRQ+ITfE9olr6zQDR0kAGYpbs7gw3Q=;
  b=ePKdm4JRVtw/B9d/8CKYXwpp5rqDvSNakIpOcbn3WIqP6gY0q7AGU8Q8
   kxmXA5npW79ezpK+7IE10BsexuRVpV2DOJ7KzMZOXscZocpTbd1b2n11D
   dtUujrpCS2LlUoTcS88N+QGWSdZ4T2NOfzLWP87V/rsk5gFLXsPcFgfFj
   T5JbS09OW3/CSOQCtU0322z5+KUCwlfUlFhPFh95u42OeRZwcuBDR522Q
   S4QXn33fO4y1zkoVNKgrzwfS6ifCY5Myb618UOWZs15jdUaozGhuwBHa7
   Ou7WicJS5O3RCZoYkUc+3mkphQUibNk/nn6hYmtbf7qmjcZ9PzFs9Qns7
   Q==;
X-CSE-ConnectionGUID: 0S0kZJLIRAidb3aVyyX6UQ==
X-CSE-MsgGUID: tjjbsyTGQwu0riyWAR5Brw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43628203"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="43628203"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:40:02 -0700
X-CSE-ConnectionGUID: pT1/HkoDQWWTbz5tShmYvQ==
X-CSE-MsgGUID: qIaaMbFGQLCv5lsW4B3/Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="146305344"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:39:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvG7b-00000004EWe-3yk8;
	Thu, 20 Mar 2025 15:39:43 +0200
Date: Thu, 20 Mar 2025 15:39:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com, leon@kernel.org,
	lukas@wunner.de, bhelgaas@google.com, wagi@kernel.org,
	djeffery@redhat.com, stuart.w.hayes@gmail.com, jgowans@amazon.com,
	jgg@nvidia.com
Subject: Re: [RFC v1 1/3] luo: Live Update Orchestrator
Message-ID: <Z9wan08CpbvddHhc@smile.fi.intel.com>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320024011.2995837-2-pasha.tatashin@soleen.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 02:40:09AM +0000, Pasha Tatashin wrote:
> Introduces the Live Update Orchestrator (LUO), a new kernel subsystem
> designed to facilitate live updates. Live update is a method to reboot
> the kernel while attempting to keep selected devices alive across the
> reboot boundary, minimizing downtime.
> 
> The primary use case is cloud environments, allowing hypervisor updates
> without fully disrupting running virtual machines. VMs can be suspended
> while the hypervisor kernel reboots, and devices attached to these VM
> are kept operational by the LUO.
> 
> Features introduced:
> 
> - Core orchestration logic for managing the live update process.
> - A state machine (NORMAL, PREPARED, UPDATED, *_FAILED) to track
>   the progress of live updates.
> - Notifier chains for subsystems (device layer, interrupts, KVM, IOMMU,
>   etc.) to register callbacks for different live update events:
>     - LIVEUPDATE_PREPARE: Prepare for reboot (before blackout).
>     - LIVEUPDATE_REBOOT: Final serialization before kexec (blackout).
>     - LIVEUPDATE_FINISH: Cleanup after update (after blackout).
>     - LIVEUPDATE_CANCEL: Rollback actions on failure or user request.
> - A sysfs interface (/sys/kernel/liveupdate/) for user-space control:
>     - `prepare`: Initiate preparation (write 1) or reset (write 0).
>     - `finish`: Finalize update in new kernel (write 1).
>     - `cancel`: Abort ongoing preparation or reboot (write 1).
>     - `reset`: Force state back to normal (write 1).
>     - `state`: Read-only view of the current LUO state.
>     - `enabled`: Read-only view of whether live update is enabled.
> - Integration with KHO to pass orchestrator state to the new kernel.
> - Version checking during startup of the new kernel to ensure
>   compatibility with the previous kernel's live update state.
> 
> This infrastructure allows various kernel subsystems to coordinate and
> participate in the live update process, serializing and restoring device
> state across a kernel reboot.

...

> +Date:		March 2025
> +KernelVersion:	6.14.0

This is way too optimistic, it even won't make v6.15.
And date can be chosen either v6.16-rc1 or v6.16 release
in accordance with prediction tool

...

> +#ifndef _LINUX_LIVEUPDATE_H
> +#define _LINUX_LIVEUPDATE_H

> +#include <linux/compiler.h>
> +#include <linux/notifier.h>

This is semi-random list of inclusions. Try to follow IWYU principle.
See below.

...

> +bool liveupdate_state_updated(void);

Where bool is defined?

...

> +/**
> + * LIVEUPDATE_DECLARE_NOTIFIER - Declare a live update notifier with default
> + * structure.
> + * @_name: A base name used to generate the names of the notifier block
> + * (e.g., ``_name##_liveupdate_notifier_block``) and the callback function
> + * (e.g., ``_name##_liveupdate``).
> + * @_priority: The priority of the notifier, specified using the
> + * ``enum liveupdate_cb_priority`` values
> + * (e.g., ``LIVEUPDATE_CB_PRIO_BEFORE_DEVICES``).
> + *
> + * This macro declares a static struct notifier_block and a corresponding
> + * notifier callback function for use with the live update orchestrator.
> + * It simplifies the process by automatically handling the dispatching of
> + * live update events to separate handler functions for prepare, reboot,
> + * finish, and cancel.
> + *
> + * This macro expects the following functions to be defined:
> + *
> + * ``_name##_liveupdate_prepare()``:  Called on LIVEUPDATE_PREPARE.
> + * ``_name##_liveupdate_reboot()``:   Called on LIVEUPDATE_REBOOT.
> + * ``_name##_liveupdate_finish()``:   Called on LIVEUPDATE_FINISH.
> + * ``_name##_liveupdate_cancel()``:   Called on LIVEUPDATE_CANCEL.
> + *
> + * The generated callback function handles the switch statement for the
> + * different live update events and calls the appropriate handler function.
> + * It also includes warnings if the finish or cancel handlers return an error.
> + *
> + * For example, declartion can look like this:
> + *
> + * ``static int foo_liveupdate_prepare(void) { ... }``
> + *
> + * ``static int foo_liveupdate_reboot(void) { ... }``
> + *
> + * ``static int foo_liveupdate_finish(void) { ... }``
> + *
> + * ``static int foo_liveupdate_cancel(void) { ... }``
> + *
> + * ``LIVEUPDATE_DECLARE_NOTIFIER(foo, LIVEUPDATE_CB_PRIO_WITH_DEVICES);``
> + *

Hmm... Have you run kernel-doc validator? There is missing Return section and
it will warn about that.

> + */

...

> +		WARN_ONCE(rv, "cancel failed[%d]\n", rv);		\

+ bug.h

...

> + #undef pr_fmt
> + #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt

Leftover from the development?

> +#undef pr_fmt

Not needed as long as pr_fmt9) is at the top of the file.

> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt

...

> +#include <linux/kernel.h>

What for? Can you follow IWYU, please? Here again semi-random list of
inclusions.

> +#include <linux/sysfs.h>
> +#include <linux/string.h>
> +#include <linux/rwsem.h>
> +#include <linux/err.h>
> +#include <linux/liveupdate.h>
> +#include <linux/cpufreq.h>
> +#include <linux/kexec_handover.h>

Can you keep them ordered which will be easier to read and maintain?

...

> +static int __init early_liveupdate_param(char *buf)
> +{
> +	return kstrtobool(buf, &luo_enabled);
> +}

> +

Redundant blank line.

> +early_param("liveupdate", early_liveupdate_param);

...

> +/* Show the current live update state */
> +static ssize_t state_show(struct kobject *kobj,
> +			  struct kobj_attribute *attr,

It is still enough room even for the strict 80 limit case.

> +			  char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", LUO_STATE_STR);
> +}

...

> +		ret = blocking_notifier_call_chain(&luo_notify_list,
> +						   event,
> +						   NULL);

There is room on the previous lines. Ditto for the similar cases all over
the code.

...

> +{
> +	int ret;
> +
> +	if (down_write_killable(&luo_state_rwsem)) {
> +		pr_warn(" %s, change state canceled by user\n", __func__);

Why __func__ is so important in _this_ message? And why leading space?
Ditto for the similar cases.

> +		return -EAGAIN;
> +	}
> +
> +	if (!IS_STATE(LIVEUPDATE_STATE_NORMAL)) {
> +		pr_warn("Can't switch to [%s] from [%s] state\n",
> +			luo_state_str[LIVEUPDATE_STATE_PREPARED],
> +			LUO_STATE_STR);
> +		up_write(&luo_state_rwsem);
> +
> +		return -EINVAL;
> +	}
> +
> +	ret = luo_notify(LIVEUPDATE_PREPARE);
> +	if (!ret)
> +		luo_set_state(LIVEUPDATE_STATE_PREPARED);
> +
> +	up_write(&luo_state_rwsem);
> +
> +	return ret;
> +}

...

> +static ssize_t prepare_store(struct kobject *kobj,
> +			     struct kobj_attribute *attr,
> +			     const char *buf,
> +			     size_t count)
> +{
> +	ssize_t ret;
> +	long val;

> +	if (kstrtol(buf, 0, &val) < 0)
> +		return -EINVAL;

Shadower error code.


> +	if (val != 1 && val != 0)
> +		return -EINVAL;

What's wrong with using kstrtobool() from the beginning?

> +
> +	if (val)
> +		ret = luo_prepare();
> +	else
> +		ret = luo_cancel();

> +	if (!ret)
> +		ret = count;
> +
> +	return ret;

Can we go with the usual pattern "check for errors first"?

	if (ret)
		return ret;

	...

> +}

...

> +static ssize_t finish_store(struct kobject *kobj,
> +			    struct kobj_attribute *attr,
> +			    const char *buf,
> +			    size_t count)

Same comments as per above.

...

> +static struct attribute *luo_attrs[] = {
> +	&state_attribute.attr,
> +	&prepare_attribute.attr,
> +	&finish_attribute.attr,

> +	NULL,

No comma for the terminator entry.

> +};

...

> +static int __init luo_init(void)
> +{
> +	int ret;
> +
> +	if (!luo_enabled || !kho_is_enabled()) {
> +		pr_info("disabled by user\n");
> +		luo_enabled = false;
> +
> +		return 0;
> +	}

Can be written like

	if (!kho_is_enabled())
		luo_enabled = false;
	if (!luo_enabled) {
		pr_info("disabled by user\n");
		return 0;
	}

> +	ret = sysfs_create_group(kernel_kobj, &luo_attr_group);
> +	if (ret)
> +		pr_err("Failed to create group\n");
> +
> +	luo_sysfs_initialized = true;
> +	pr_info("Initialized\n");
> +
> +	return ret;

Something is odd here between (non-)checking for errors and printed messages.

> +}

...

> +EXPORT_SYMBOL_GPL(liveupdate_state_normal);

No namespace?

...

> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -18,6 +18,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/uaccess.h>
> +#include <linux/liveupdate.h>

Can oyu preserve order (with given context at least)?

-- 
With Best Regards,
Andy Shevchenko



