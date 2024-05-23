Return-Path: <linux-kernel+bounces-187937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF3D8CDAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1B5280F97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3FF84A35;
	Thu, 23 May 2024 19:43:39 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEF81AD0
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493419; cv=none; b=RDYkApDLvzHqh+Mec3QwOr+Dc3v1I83vuCmfbQ512914dpnUF3LWN1OQxm6jGplXxDpultXJe3ZOKcESTl3Qd55SkXB4GIE/WZ3xmVcueoBlUoQGqRx7E9Bsdd8r01I9xVTIA+y5DlltCj9iJPx8w93ahojONLsP3sy5zqoz47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493419; c=relaxed/simple;
	bh=hwJnow95Alh/ZOXDYGhP/XTkujibrRJUnoj+M7pyhcM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=osBGG5kFk+ViOhXiE/IToN8C3pQzbzAkmPBl8Ll5pVA6V/psMo2t3Pdx6DcFqcy+qOXeYmXmPL5FpHLCHduHmZ2RC7aGpPvpC6Wcqmq42eiRWmbPr3iucsQ7r0Ek+YcmPcPYnxjQMDSHP59AyK4/OyuYQ3URbZ6Y5+zFgr5QS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id D80A440251; Thu, 23 May 2024 12:43:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id D4F91401F3;
	Thu, 23 May 2024 12:43:34 -0700 (PDT)
Date: Thu, 23 May 2024 12:43:34 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org, 
    anshuman.khandual@arm.com, scott@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
In-Reply-To: <Zk-SNVyEHT1UsxqD@arm.com>
Message-ID: <ad87bb77-a9a5-2c0d-b4b2-13db09615d7c@linux.com>
References: <20240520165636.802268-1-yang@os.amperecomputing.com> <Zk93vBqAD3LgmbGb@arm.com> <640f8606-2757-4e82-721f-9625d48ded65@gentwo.org> <Zk-SNVyEHT1UsxqD@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 23 May 2024, Catalin Marinas wrote:

>>> While this class includes all atomics that currently require write
>>> permission, there's some unallocated space in this range and we don't
>>> know what future architecture versions may introduce. Unfortunately we
>>> need to check each individual atomic op in this class (not sure what the
>>> overhead will be).
>>
>> Can you tell us which bits or pattern is not allocated? Maybe we can exclude
>> that from the pattern.
>
> Yes, it may be easier to exclude those patterns. See the Arm ARM K.a
> section C4.1.94.29 (page 791).

Hmmm. We could consult an exception table once the pattern matches to 
reduce the overhead.

However, the harm done I think is acceptable even if we leave things as 
is. In the worst case we create unnecesssary write fault processing for an 
"atomic op" that does not need write access. Also: Why would it need to be 
atomic if it does not write???

It is more likely that new atomic ops are added that require write 
permissions. Those will then just work. Otherwise we would need to 
maintain an exception table of unallocated instructions that would then 
have to shrink depending on new atomics added.

The ultimate solution would be to change the spec so that arm processors 
can skip useless read faults.


