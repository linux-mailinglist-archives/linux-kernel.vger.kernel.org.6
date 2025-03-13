Return-Path: <linux-kernel+bounces-559081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0297A5EF55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9141890CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD61263F4F;
	Thu, 13 Mar 2025 09:16:20 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1D1EA7F4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857380; cv=none; b=gP9meJ2uMkAxXa2mN9m62hqD+5AwYvNgnQ/lAOnsbg1kavSptowHxafyzQFW/AOf6H/DaAyy2CaX4HUsziXOstaehGL4l2IU/PzMeLhRA5bnKPPApBZ08dnzUFGp/LFzuhkQ1hdNiLBEEWaUchf6sOlF3XVQkdUQhWCyssJ8VzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857380; c=relaxed/simple;
	bh=W5QK6QqVcznmQqARidUnOoYQrIFJ04RMSyctJIUJChg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dp2USOJKgw8G7CS80PSZiR1GW1EIbH6yUkA1uK/1yOqLARISzACVcpB/kpoHhDz3HhDZwPVr+xC6scOya1iA72sCztu13JHzpffJ5RcDrhFEKqZIph1ujuifi2m3dOvYAK3/fUeOUxKNxCgn9/grypeU1hr+O7HzV/uJN3kQ5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD1vy6Wlyz6J6cn;
	Thu, 13 Mar 2025 17:11:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F8BF1403A8;
	Thu, 13 Mar 2025 17:16:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:16:13 +0100
Date: Thu, 13 Mar 2025 09:16:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>,
	<dietmar.eggemann@arm.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v12 2/4] arch_topology: Support SMT control for OF based
 system
Message-ID: <20250313091611.00003ccf@huawei.com>
In-Reply-To: <20250311075143.61078-3-yangyicong@huawei.com>
References: <20250311075143.61078-1-yangyicong@huawei.com>
	<20250311075143.61078-3-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Mar 2025 15:51:41 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On building the topology from the devicetree, we've already gotten the
> SMT thread number of each core. Update the largest SMT thread number
> and enable the SMT control by the end of topology parsing.
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
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

