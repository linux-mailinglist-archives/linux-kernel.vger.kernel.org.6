Return-Path: <linux-kernel+bounces-551846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69CA571F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FA418980C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCE524FC1F;
	Fri,  7 Mar 2025 19:35:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58198183CB0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376142; cv=none; b=lh6GLVsiRdf1aqSPAbQBj2McmNga9CvAdMRISoSptRaeCBWwTjl6Ard9h8FIWuO9fJZAxvVrGBAIsG0JZTAFw0hrWCFssejX1K8SvjFqO5XOd4HZBMQfw3WkRSQdvYxiUnN1ry5qEp5tIpoO9xQ1Jnm8vxGPGRk44ktXquD2iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376142; c=relaxed/simple;
	bh=g7/oFp2KwrBtLUDUYgjRZXPWEC4FqpgEtuOvuaF45Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hn+fAvELdYld5fVAwJuU5s1uOw2aWpfLHVcSALDp2nlVy4sItsvK3sAL/i4SFHeMGXnazpRSUrtfO1u9THj5TfWo3ZGQVqVfDayMBIhnqbUs7XZMhQe8cImXMpqfdpnhAJG2rJUZaHFKY+mJi0bgQdjkkErc4uGfJzQR7VTbi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 901E81477;
	Fri,  7 Mar 2025 11:35:51 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 085E43F66E;
	Fri,  7 Mar 2025 11:35:35 -0800 (PST)
Message-ID: <ebfd206a-1a48-4c3f-958a-7cf981dd3671@arm.com>
Date: Fri, 7 Mar 2025 19:35:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/49] x86/resctrl: Move rdt_find_domain() to be
 visible to arch and fs code
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-13-james.morse@arm.com>
 <2c7ead86-138b-4d26-8524-8109176d791f@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <2c7ead86-138b-4d26-8524-8109176d791f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 07/03/2025 04:34, Reinette Chatre wrote:
> On 2/28/25 11:58 AM, James Morse wrote:
>> rdt_find_domain() finds a domain given a resource and a cache-id.
>> This is used by both the architecture code and the filesystem code.
>>
>> After the filesystem code moves to live in /fs/, this helper is either
>> duplicated by all architectures, or needs exposing by the filesystem code.
>>
>> Add the definition to the global header file. As its now globally visible,
> 
> "definition" -> "declaration"?

Ugh, I always get those the wrong way round.


>> and has only a handful of callers, swap the 'rdt' for 'resctrl'. Move
>> the function to live with its caller in ctrlmondata.c as the filesystem
>> code will not have anything corresponding to core.c.


> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James

