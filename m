Return-Path: <linux-kernel+bounces-556332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AE1A5C435
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE603AA8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD325D908;
	Tue, 11 Mar 2025 14:41:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683FD25D8FF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704094; cv=none; b=eQBPxz8clYJIHYY8UZufeAtR8SKvn7Sa4AwtTNDaWGkMqgxMaTgxVtZRF/SczS/VavQSv5uZ1dNwIPg9f6SLxo1R1bZyI25ylVaSvQ4qC+iZ8Gl4vluaoiSJ6NmwpS/Uj8U+lwNTRG1hBvc4E6L4mM0d0urXF1mED6PXrtDQzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704094; c=relaxed/simple;
	bh=Q9lwWhybNJ//6+AOjlmGs5rjcr2W5os7HDLc5Uj//60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl7SW4gWlnStMypdMQ8xqHNg8SvWAjl+Q23xFquviez2Rvkdu3huf+z3gmSP9/mVsaeZxkj82PE/cnxcGb6D7tOFbjIN7epr0oU7L9mZNpqXDEmGJhNsrj74IyYf+dcS37pE+xSu9fjqyyF5dFyIGIch5P5Z0mcaBu/WszpapWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7BA5152B;
	Tue, 11 Mar 2025 07:41:42 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 673CE3F694;
	Tue, 11 Mar 2025 07:41:27 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:41:24 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@linutronix.de>,
	Sudeep Holla <sudeep.holla@arm.com>, <peterz@infradead.org>,
	<mpe@ellerman.id.au>, <linux-arm-kernel@lists.infradead.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<pierre.gondois@arm.com>, <dietmar.eggemann@arm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>, <sshegde@linux.ibm.com>
Subject: Re: [PATCH v12 0/4] Support SMT control on arm64
Message-ID: <Z9BLlOgL3RFLCFnz@bogus>
References: <20250311075143.61078-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311075143.61078-1-yangyicong@huawei.com>

On Tue, Mar 11, 2025 at 03:51:39PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The core CPU control framework supports runtime SMT control which
> is not yet supported on arm64. Besides the general vulnerabilities
> concerns we want this runtime control on our arm64 server for:
> 
> - better single CPU performance in some cases
> - saving overall power consumption
> 
> This patchset implements it in the following aspects:
> 
> - Provides a default topology_is_primary_thread()
> - support retrieve SMT thread number on OF based system
> - support retrieve SMT thread number on ACPI based system
> - select HOTPLUG_SMT for arm64
> 
> Tests has been done on our ACPI based arm64 server and on ACPI/OF
> based QEMU VMs.
> 
> Change since v11:
> - Remove the check and warning for heterogeneous platform as suggested and discussed

IIUC, the ask was not to remove it completely but to allow single
threaded and same number of threads in all the multi-threaded CPUs.
Anyways that is not a must, we can just stash max_smt_thread_num value
before updating with max and see if it changes from one value to another
with value != 1. It can be done later when we want to warn such systems
if they appear in the future and we can't support them. For now, it looks
fine.

-- 
Regards,
Sudeep

