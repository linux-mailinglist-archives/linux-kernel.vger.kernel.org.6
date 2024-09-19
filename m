Return-Path: <linux-kernel+bounces-333190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A8097C539
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FB1283300
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7C195B18;
	Thu, 19 Sep 2024 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="EddgHVqN"
Received: from out187-13.us.a.mail.aliyun.com (out187-13.us.a.mail.aliyun.com [47.90.187.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30380195390
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732093; cv=none; b=Q0Wd56FwxgSOzoy08WB5S2VuiaXu+67T5Ce7sgKWGS5WDx7CyoL+1mgD1WWhTIA3vufxvM2qe3Z6MQVSwvc1ffwba30mgQgjIgfg+q7TlI7/8+96hl3s7zQqpiD92TkWCxdHOK63rHAMu3qdMg1W2XlvYBQif7VNToTEBCsJE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732093; c=relaxed/simple;
	bh=BIIS+CjQk3qH1Dkl+KdaXyMXVz9ppYb9EoGgxjvqnLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfnrfbQZJIqFRCeeMYp/6e6Bf1an5Wbtw2/l5DSH9bN64Sg9Ye8YpvxujzwfTKA/Ss4APvsnN1h95HC6XUObyFT4QW52yIeehM9zEk1Ld4+TUa8g+RhtRl9RDEZ7iBr0Q69W4g5vqjcR2Z7B63ny71dCI8E0HXM0jTS9f+LI3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=EddgHVqN; arc=none smtp.client-ip=47.90.187.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726732070; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WaWmR/2gbJuAnFjeJ7UqO4YR7c/p0mLjhuVApW14H/8=;
	b=EddgHVqNPCcj9ffUtQdDmaiMC1CCRpHTZtXarkmjINP6eVBorwYcdVuQlsuUpTiv0aVal1A+ffVD5HhyFAZcoUeCXIIGLnMS3ZOGHzM03EcyJQ9J2rB4CbUVzgQkdeBbsEfP7cnxLUBypVGwCeXCFA3fP/FgLxv04ATE2EtSSm4=
Received: from 30.230.84.113(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZNEik1g_1726732064)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 15:47:49 +0800
Message-ID: <75b42537-e895-4c3a-85b5-3c9beab3e149@antgroup.com>
Date: Thu, 19 Sep 2024 15:47:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Remove 3-level page table support on i386
To: Benjamin Berg <benjamin@sipsolutions.net>,
 Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240918061702.614837-1-tiwei.btw@antgroup.com>
 <0a73298f1c0ed189046360ea867e6da32276381c.camel@sipsolutions.net>
 <627bd11a7fe69fed02719c2ecf5370b59328e80d.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <627bd11a7fe69fed02719c2ecf5370b59328e80d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/9/19 15:22, Benjamin Berg wrote:
> On Thu, 2024-09-19 at 08:54 +0200, Johannes Berg wrote:
>> On Wed, 2024-09-18 at 14:17 +0800, Tiwei Bie wrote:
>>> The highmem support has been removed by commit a98a6d864d3b ("um:
>>> Remove broken highmem support"). The 2-level page table is
>>> sufficient
>>> on UML/i386 now. Remove the 3-level page table support on UML/i386
>>> which is still marked as experimental.
>>>
>>
>> No real objection, but with the 4-level page table work on 64-bit
>> pending as well (which likely conflicts), I wonder if we should just
>> remove 3-level *entirely*?

Fine with me in either way. Keeping only one page table implementation
on UML/x86_64 may require smaller maintenance effort.

> 
> Fine with me. There is only the tiny advantage of saving a few pages of
> memory for each process. I just erred on the side of keeping it in case
> anyone is cares to the option …
> 
> I'll resubmit the patchset without 3-level support then, possibly on
> top of this patch.

Thanks! :)

Regards,
Tiwei

> On the assumption that no one actually cares about
> 3-level page tables on x86_64.
> 
> Benjamin


