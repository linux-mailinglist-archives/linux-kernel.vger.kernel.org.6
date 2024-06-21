Return-Path: <linux-kernel+bounces-223762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CAB9117E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D301F22F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446901C14;
	Fri, 21 Jun 2024 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WU52wQeh"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FFE10FA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718932334; cv=none; b=rl/sPRucpbqa+M/LIDbEwaNmfKChaxNoMi8cEuFrhMhbeZ24Ix94pEh9qPn8rY8j+8t8puRfwPSIBYphOFFHoB0ptjI159H5y7GM5+3EXmFDT5uTORBruyHY4wsK2BGHmPV9zWdhgf3Nx4ZLN0Nw/OyYMiBjyWCeyE/sh8ehTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718932334; c=relaxed/simple;
	bh=S3canZcKahQeI0EJf5EI0Jhp2mTHLS0AOfjT7/IR5iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxFAtmKPTfkz80nCA8GFp964R7NxRizkdPYaemQH/+kVXL8E3nH2awNaqzlIvKVYjAvSxCM062OFALtYffLcbGiTILNeTd8KaBrlhECXJlsX9rPcluIX5/CQWRGa4HvtBbRdacIr9+5u2dHWVXcpy7vA8MdTuAV/znhF9OXiaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WU52wQeh; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kent.overstreet@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718932328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3canZcKahQeI0EJf5EI0Jhp2mTHLS0AOfjT7/IR5iI=;
	b=WU52wQehGB5IlWBEWmiAAL9u4Mb1QIDVilAegPqxImKz+LB0smUJPEJ3SJVla593LB6uLf
	rn7g9vdbp1qKBXoSIRDmq/aQ4FcMps73sd9i1r2AsT5aXLuUGPC2BN0/vfDjWxbdStae/y
	fQUT0chhwP4Wmu6ydlMO5q2gNhehnxw=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
Message-ID: <c24f044a-989d-4661-812d-3e2140f1f626@linux.dev>
Date: Fri, 21 Jun 2024 09:11:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bcachefs: fix alignment of VMA for memory mapped files on
 THP
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20240620012242.106698-1-youling.tang@linux.dev>
 <myw2h2mm7725gegy6pbqf4qpzghrfypnlbn4z6rh6idwfjzpjc@chzxxg47sw77>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <myw2h2mm7725gegy6pbqf4qpzghrfypnlbn4z6rh6idwfjzpjc@chzxxg47sw77>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi, Kent

Sorry to bother you, BTW, are the following patches still needed?

https://lore.kernel.org/linux-bcachefs/20240604084610.94558-1-youling.tang@linux.dev/
https://lore.kernel.org/linux-bcachefs/20240418083103.66703-1-youling.tang@linux.dev/
https://lore.kernel.org/linux-bcachefs/20240418005055.45482-1-youling.tang@linux.dev/

Thanks,
Youling.

On 20/06/2024 20:51, Kent Overstreet wrote:
> On Thu, Jun 20, 2024 at 09:22:42AM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> With CONFIG_READ_ONLY_THP_FOR_FS, the Linux kernel supports using THPs
>> for read-only mmapped files, such as shared libraries. However, the
>> kernel makes no attempt to actually align those mappings on 2MB
>> boundaries, which makes it impossible to use those THPs most of the
>> time. This issue applies to general file mapping THP as well as
>> existing setups using CONFIG_READ_ONLY_THP_FOR_FS. This is easily
>> fixed by using thp_get_unmapped_area for the unmapped_area function
>> in bcachefs, which is what ext2, ext4, fuse, xfs and btrfs all use.
>>
>> Similar to commit b0c582233a85 ("btrfs: fix alignment of VMA for
>> memory mapped files on THP").
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> Thanks - applied


