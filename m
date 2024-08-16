Return-Path: <linux-kernel+bounces-289998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49616954E45
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E871F253D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF71BDABB;
	Fri, 16 Aug 2024 15:54:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4B71B86FB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823693; cv=none; b=QsMOHkwYc08OkXyNPeIweyw8xh3joGnrm7qDkX1ZSun6f4QHfmiwZno6e6gLkZ08nwIbLCgY5BkqkePMDXIDftb5ZbQ83F0VrFpCsVWnPGO+gwWNxIAoY86fN2IaUWdTLSmGrljGJ9UTHq01WdZQFh+vz6C0PNu5oqZVxEpLsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823693; c=relaxed/simple;
	bh=kjt5QDvru1RweyhCZtLcwu7y4Z0Tlaav4KHtlHsEp94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agGSZw1XRWsodVT98p1fL1Zp8rs5D9Xj4Tk2jLcYs2Guz4/CXr13Knn/sPYY5JBc+I5ZUkd+Yr1NLejWbTUxX/G3epRDL6+Lx26k6rK8m58RNmUTbgQYxOarXuV4Eiv6/A/EeR2++0C7RQqmQWQBdATFZFNNONpccSSLtJB07sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F1613D5;
	Fri, 16 Aug 2024 08:55:17 -0700 (PDT)
Received: from [192.168.181.244] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 931F53F58B;
	Fri, 16 Aug 2024 08:54:46 -0700 (PDT)
Message-ID: <9c46d5f0-f4ff-461b-b483-840fab6dfecc@arm.com>
Date: Fri, 16 Aug 2024 17:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, tglx@linutronix.de,
 peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com,
 yangyicong@hisilicon.com, xuwei5@huawei.com, guohanjun@huawei.com
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-2-yangyicong@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240806085320.63514-2-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 10:53, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently if architectures want to support HOTPLUG_SMT they need to
> provide a topology_is_primary_thread() telling the framework which
> thread in the SMT cannot offline. However arm64 doesn't have a
> restriction on which thread in the SMT cannot offline, a simplest
> choice is that just make 1st thread as the "primary" thread. So
> just make this as the default implementation in the framework and
> let architectures like x86 that have special primary thread to
> override this function.

IMHO, ARM64 (/ARM), RISCV and PARISC (SMP) use GENERIC_ARCH_TOPOLOGY
(and drivers/base/arch_topology.c) so they could share
topology_is_primary_thread() also there?

[...]


