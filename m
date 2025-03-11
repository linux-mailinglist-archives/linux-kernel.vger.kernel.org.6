Return-Path: <linux-kernel+bounces-556336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74CA5C428
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446623B544E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797325D1FC;
	Tue, 11 Mar 2025 14:42:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27825D1E5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704157; cv=none; b=PI/sbAmP/EfoZVvbbg+2WV02aaq3ArytWtSTyPgKA51UmKUOxBy1NYEXTxUPIB9AvSpCeE5zlaQ6OWMoHIT5YGSMGtjSGI4Dkh7t41VfCgKpfdLWDyTGJaTIHCDxaPBGNNvKXex1B87qis5bVWRtKuzSfS3VvDVwOOsnTwErM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704157; c=relaxed/simple;
	bh=3AIzpA5wlaib9NVO6P+nqnFxlRCZ0W1Viqud+/pU19Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oscKEWnIysoNx6RuanFw8PVxiyHpC4CYB38o14xt1FLk3xEQTP6N7jzyNXXDL9vX5lwJBSg1OLNsbEgQYfWA7NUsOAnykqn4vrHGTi4fSWb6NiJkMxv8/isNGXXCDLVKGksVTWl1TUJnm6wo6PRqwXUb/jzgR6Rwjh3R+jgrGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BB3F27B5;
	Tue, 11 Mar 2025 07:42:46 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61E293F694;
	Tue, 11 Mar 2025 07:42:31 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:42:28 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<pierre.gondois@arm.com>, <dietmar.eggemann@arm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>, <sshegde@linux.ibm.com>
Subject: Re: [PATCH v12 3/4] arm64: topology: Support SMT control on ACPI
 based system
Message-ID: <Z9BL1DgDlcYKVaDu@bogus>
References: <20250311075143.61078-1-yangyicong@huawei.com>
 <20250311075143.61078-4-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311075143.61078-4-yangyicong@huawei.com>

On Tue, Mar 11, 2025 at 03:51:42PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> For ACPI we'll build the topology from PPTT and we cannot directly
> get the SMT number of each core. Instead using a temporary xarray
> to record the heterogeneous information (from ACPI_PPTT_ACPI_IDENTICAL)
> and SMT information of the first core in its heterogeneous CPU cluster
> when building the topology. Then we can know the largest SMT number
> in the system. If a homogeneous system's using ACPI 6.2 or later,
> all the CPUs should be under the root node of PPTT. There'll be
> only one entry in the xarray and all the CPUs in the system will
> be assumed identical.
> 
> The framework's SMT control provides two interface to the users [1]
> through /sys/devices/system/cpu/smt/control:
> 1) enable SMT by writing "on" and disable by "off"
> 2) enable SMT by writing max_thread_number or disable by writing 1
> 
> Both method support to completely disable/enable the SMT cores so both
> work correctly for symmetric SMT platform and asymmetric platform with
> non-SMT and one type SMT cores like:
> core A: 1 thread
> core B: X (X!=1) threads
> 
> Note that for a theoretically possible multiple SMT-X (X>1) core
> platform the SMT control is also supported as expected but only
> by writing the "on/off" method.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-devices-system-cpu#n542

Ditto, just path please.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

