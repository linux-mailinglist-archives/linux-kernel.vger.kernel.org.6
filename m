Return-Path: <linux-kernel+bounces-556724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EDBA5CDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5B47A2BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F62620F9;
	Tue, 11 Mar 2025 18:33:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF31EF361
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718021; cv=none; b=Vq1d8973kQWsTi9OD6whb+bJRocYYo7aUCfZjUy6yA8L6R3cWSUMxkthUrtrxKDQ2/iBlbNEm+v8GpAEjDsJoiblwsqs3jaco8shGLDQ5pCXoMVHSPbWNYua4VbyoaLX6u1iLvR4Bh9/2EtBqjxQX0EAHMwmP6SbGuE7+rJU158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718021; c=relaxed/simple;
	bh=HAg0brZjYZBmF/cz8Bw/dPL5gjDO+oOBDkSYN6yMXLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZOl/buoJbqmbMkSAzWoiWipG8+GEVb2ru/lYU/q/z+TsZbZqNaiyz7QCm+g1yxoK2krVGbRJHyAQfxPrVfOWmLB+8clp+rEO7nimMyoNdqFRZVXtJslQyAoVz5pkmVnSo9pDTvWzZzujUO0aGdrysh4AhL6E2s9XGMYObTtbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 471791713;
	Tue, 11 Mar 2025 11:33:50 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0340A3F694;
	Tue, 11 Mar 2025 11:33:31 -0700 (PDT)
Message-ID: <4629144c-8a52-4f0e-aac8-7139a0fcd883@arm.com>
Date: Tue, 11 Mar 2025 18:33:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <5436632b-cdc8-4a55-8766-0cc2aec0b807@marvell.com>
 <5f3171e0-d96e-47ea-92d7-0a3e3e3f8147@marvell.com>
 <956a210d-1883-477a-9c90-9667031610e6@nvidia.com>
 <18057287-42b3-4743-bd85-c12c098e98ea@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <18057287-42b3-4743-bd85-c12c098e98ea@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shanker,

On 07/03/2025 16:50, Shanker Donthineni wrote:
> On 3/7/25 10:38, Shanker Donthineni wrote:
>> I have tested this patch series w/ MPAM patches on the Grace server platform.
>> Validated both the features CPOR and MBW, results as expected.

> Typo, tested with MPAM patches.

>> Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>


Thanks! (as noted elsewhere - I've added an '# arm64' suffix to this)

James

