Return-Path: <linux-kernel+bounces-396255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7CC9BCA29
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E891F23322
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548EE1D2211;
	Tue,  5 Nov 2024 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="odoFa2jR"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0ED1D0942
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801863; cv=none; b=ae6MdLoBr1LKDEy0cJwkyahWog35cqwhPJ2b0fil9OtzuGBYw4V6NVnwvuVfdCzqQX871I6KIpL6h1v68QKStjv8k67Rz5g5ncQmRYJ+Jj91eL3oYNKI0KzSqDyxRxQ8mXsf8wrtnE5gGhdJC4r83YEqv46nQkmYkqzzpSOXndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801863; c=relaxed/simple;
	bh=Pfxp3UgmocCduvz74SEU8A/Gr1NiH79Ak9TQv8JebjI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qsg6cq+7DFkj3SbiVgN+OtcSA7vyarleAH0CBU/Ug4J+hhJXY0yNX/g5SUW2wQ+4N6enMAPo+sK62IWIpotnksbB+etSHbijatTHL6H0lQvGk1qSCuzyXkeJFxlKh7ol8rCkriV+HyHxKZ96Ugx3EdaTk5u4yoE5yrIA6UHt11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=odoFa2jR; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730801858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8X+2xCjEs0rBr3R/4kav9LiDnlmN+TNDD9ICLlYSxM=;
	b=odoFa2jRg/7/75GQpXFacn7upyeh3uTIb2m3Y+ooiT3sQBf6+ou2BK9NSJIHM+MRumSZAG
	r0SqmZWiPjEI2drWlZKjaynUYAc6cGoKmzNfRvBefK3OdcgJc6CgoFM+rikgR+MqEe+xvj
	bG9UJTxpvZbOGBXO/4tJLqp5vqH0cRA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] ext4: Annotate struct fname with __counted_by()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2024110530-ashen-deforest-9f71@gregkh>
Date: Tue, 5 Nov 2024 11:17:24 +0100
Cc: Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0323DE8F-A0F4-4396-A755-41CE1DCC6A48@linux.dev>
References: <20241104234214.8094-2-thorsten.blum@linux.dev>
 <2024110530-ashen-deforest-9f71@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 5. Nov 2024, at 10:52, Greg KH wrote:
> On Tue, Nov 05, 2024 at 12:42:14AM +0100, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> 
>> Inline and use struct_size() to calculate the number of bytes to
>> allocate for new_fn and remove the local variable len.
> 
> This is two different things, why not do this in two different patches?
> 
> thanks,
> 
> greg k-h

No particular reason. I'll submit a v2 for the __counted_by() annotation
and a separate patch for struct_size().

I'll keep Jan's Reviewed-by: tag for both.

Thanks,
Thorsten

