Return-Path: <linux-kernel+bounces-214977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB2908CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D10288AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C846C2C6;
	Fri, 14 Jun 2024 13:59:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB244C121
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373561; cv=none; b=VIceiXi9xuopAevE6vi0jTqdGWytH6nEcGbjmRWnaC6rcruRgoAskDqEnv2q3aZ/I8OqtgTYL3SDWszLXDMLQo0nfO1a5wIN7+PC4std7HiZZyJfG2mjPBlzh8KDW14jdH3fTjUXwAz/7ExIS5rKvBSOu0Mkql4bOyWD+/gUb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373561; c=relaxed/simple;
	bh=VzF7H8nx1isKnKUKhtia+u6KmCU39ft5R5J4m1JcvSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/C5xLgktML7t3KLkgNJNMVpZrDe5/mR/YE9hsa/O7OWda7KorWdH7JDJvdrNeFEpfqTSomFu0JhD5VZsCSAUiIZr5f7VCZufWIALAKOXnZV2hcYtw2w1f6smH6jLPcDn+RBd9kSE07gjg+4ElxRMZqQ+WwHowPA2WnFLdF41+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECF011480;
	Fri, 14 Jun 2024 06:59:43 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 776E93F5A1;
	Fri, 14 Jun 2024 06:59:16 -0700 (PDT)
Message-ID: <c9efc671-549f-4fb5-96fb-0948badbcef1@arm.com>
Date: Fri, 14 Jun 2024 14:59:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/35] fs/resctrl: Add boiler plate for external
 resctrl code
Content-Language: en-GB
To: Dave Martin <Dave.Martin@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, "Shaopeng Tan (Fujitsu)"
 <tan.shaopeng@fujitsu.com>, baolin.wang@linux.alibaba.com,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 Peter Newman <peternewman@google.com>, dfustini@baylibre.com,
 amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
 <20240426150904.8854-29-Dave.Martin@arm.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20240426150904.8854-29-Dave.Martin@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 26/04/2024 16:08, Dave Martin wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> depend on this.


> FYI: Dave Martin, James Morse (et al.):
> 
>  * Review the new Kconfig RESCTRL_FS help text.
> 
>  * Because RESCTRL_FS combines a userspace interface and a kernel
>    library providing services to its own backends, there is a circular
>    dependency between this option and the arch-specific options
>    (CONFIG_X86_RESCTRL and eventually CONFIG_ARM64_MPAM) that
>    nastifies the presentation of these options in Kconfig.
> 
>    Can this be improved?
> 
>    The current situation works, but is not very user-friendly for
>    menuconfig users.

I don't follow what the circular dependency is - Kconfig would bark if there was one.

I agree its odd that you can't disable the filesystem under the filesystem menu - but that
is so that the existing Kconfig symbol name remains the switch for this. It's possible
no-one cares about that...

A more obvious approach would be a switch for the arch hardware feature, that when enabled
allows the filesystem to be selected. This seems overkill as there is only one user.


Thanks,

James

