Return-Path: <linux-kernel+bounces-347643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E298D89C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C1C1C22FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5911D0B89;
	Wed,  2 Oct 2024 13:59:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3A1D04A2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877582; cv=none; b=BHJjdL9b/8kKOrwh1pZ4S6RSnKbx5xdwp6NWabdk/JtHveaG99oPZ2j68770GOM+XZCkmjdIijkOGVuru1D97DUlzRZw35pS1SBFrZ3lsU4BneGs7cYBaHyW4CeJa6n1VP3NCe2IPprEAIF7L0rDeWd9jwCfctIH8GrQbVko9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877582; c=relaxed/simple;
	bh=tjc9EzR1gYYnir0DhXjsCV+fSjmQ3M+O0mYfuApw+bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rwda43HJBvp/X0aNCbHzP9hIh7dzeNgb8+5k/HxqUpt896OjGwxTsKyCVU5dVncIOY/Cu5RBSg3YLKjoF+ev8Fz07dHhdxk5SQCSpQrUiqBD1VhRuZhY49ZlIvSpHhthsDpQ+5HmwE07Eh512oq/fqBRqreEtJbd6OUZna+HFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26D2E339;
	Wed,  2 Oct 2024 07:00:09 -0700 (PDT)
Received: from [10.57.64.205] (unknown [10.57.64.205])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED3083F58B;
	Wed,  2 Oct 2024 06:59:37 -0700 (PDT)
Message-ID: <9b7e5e81-622e-4726-b8c0-3171f48d2639@arm.com>
Date: Wed, 2 Oct 2024 14:59:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] irqchip/gic-v3-its: Share ITS tables with a
 non-trusted hypervisor
To: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Marc Zyngier <maz@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20240905091738.28544-1-steven.price@arm.com>
 <20240905091738.28544-2-steven.price@arm.com>
 <SN6PR02MB41579C5C46B4F5F72A888743D4992@SN6PR02MB4157.namprd02.prod.outlook.com>
 <875xqay61a.ffs@tglx>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <875xqay61a.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/10/2024 14:43, Thomas Gleixner wrote:
> On Mon, Sep 09 2024 at 03:47, Michael Kelley wrote:
>>> +	ret = set_memory_decrypted((unsigned long)page_address(page),
>>> +				   1 << order);
>>> +	if (WARN_ON(ret))
>>
>> On the x86 side, the WARN is done in the implementation of
>> set_memory_decrypted()/encrypted() so that each call site doesn't
>> need to do the WARN. Each call site must only leak the memory
>> if the return value indicates other than success. There are call sites
>> in architecture neutral code (such as for swiotlb and DMA direct)
>> that expect the WARN is in set_memory_decrypted()/encrypted().
>> To recap a previous discussion, we want the WARN for notification,
>> but also so the most security-conscious users can set
>> kernel.panic_on_warn=1 to stop further processing if there are
>> problems in the decryption/encryption operation.
> 
> What's the resolution of this?

Sorry, I should have replied.

Moving the WARN into set_memory_decrypted/encrypted() makes sense, and
I'll make that change when I post the next version of the Arm CCA patches.

I'll post an updated version of this series with the WARN_ONs removed
shortly.

Thanks,
Steve

