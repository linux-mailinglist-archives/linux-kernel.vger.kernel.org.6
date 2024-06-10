Return-Path: <linux-kernel+bounces-208351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802CF9023D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF2284D19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30184E1F;
	Mon, 10 Jun 2024 14:16:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A815F56452;
	Mon, 10 Jun 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029016; cv=none; b=DW8eNxTxV6UK4ovoOjn6+8O9U23kqyCBcmASsgCFL/nTeLIRxhkzeSHs5z1r4/rFp/1874CJEAN4It3gkjiujHlSZx1IOjhZwK8634JZ6Lp7ucR6QohI08CV8GPCWR5E/raf357IytyvVANTPi6zl20079E7bkXD96z+TWPt0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029016; c=relaxed/simple;
	bh=4HS81ASWp6hOMozhfLKqK3VhDPIEvMdvM0yobdh++Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jH6We7XgPjUNXS1MRX6SJJ7j++ofjtV7ZDB8oypQe18RiLH3RaTcdb46ttNHq0Oj9CbXRDv6k8VEJ1O7WLJmiH/Wp57ZtQg+2b4EO+JRfJ9Y8QddwDJn28AqblNleq59fONLYxXnepwJZPvzfttDo0eY+hyFGgHOvIqeIA/TBcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9807A106F;
	Mon, 10 Jun 2024 07:17:18 -0700 (PDT)
Received: from [10.1.35.41] (e122027.cambridge.arm.com [10.1.35.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 875323F73B;
	Mon, 10 Jun 2024 07:16:50 -0700 (PDT)
Message-ID: <dd86dbe3-689e-4488-b2bc-100d0f5fac04@arm.com>
Date: Mon, 10 Jun 2024 15:16:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] arm64: Detect if in a realm and set RIPAS RAM
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
References: <20240605093006.145492-1-steven.price@arm.com>
 <20240605093006.145492-3-steven.price@arm.com> <ZmcJmvBDtjaLay5k@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <ZmcJmvBDtjaLay5k@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2024 15:11, Catalin Marinas wrote:
> On Wed, Jun 05, 2024 at 10:29:54AM +0100, Steven Price wrote:
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 9b5ab6818f7f..9d8d38e3bee2 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -41,6 +41,7 @@
>>  #include <asm/kvm_host.h>
>>  #include <asm/memory.h>
>>  #include <asm/numa.h>
>> +#include <asm/rsi.h>
>>  #include <asm/sections.h>
>>  #include <asm/setup.h>
>>  #include <linux/sizes.h>
> 
> What's this random include here? It looks like a leftover from the
> previous version.
> 

Whoops - indeed that shouldn't be there.

Thanks,
Steve


