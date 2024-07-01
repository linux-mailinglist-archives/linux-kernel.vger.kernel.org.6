Return-Path: <linux-kernel+bounces-236974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6D591E945
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8751C20E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD1916FF5F;
	Mon,  1 Jul 2024 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vq8yO1P3"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043DC16EB71
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864842; cv=none; b=ehaYnQBtu666XtE9ONTDe7FslqNyP0KPl68mkGkvF7lDJDH4p0T4SDF1Dv20z0QOfpbgbfcKGQ4gxjG5Y4478zeaEtjX8MKgbXT7t7fRh34+yrSDC81mx/0RzFCbORz7IchjQ/yE3H4xtlArfVKBlQzQZbpuBZayM+S/MK+T/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864842; c=relaxed/simple;
	bh=Ndb5tmWj2t6x8ReEqmKsTqHT3T9VRXbJNhom5ZerJWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiuV/Ps3oet/J22YW1eU0QmWYdv2UDWccxV6Gv6UpukPIGvyoglrGSGCrgkUrDAmRZERYgmoAuev/vXTFTcUk5GAGVLfTsLv7nYJihs5Ya4B+FOGhorisW0ZqGxe0K91cjkGLZx0aspw58Z9DPf3xYDc+y55kx9RkQ6WbCcwgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vq8yO1P3; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WCcgr2tlwz6Cnv3g;
	Mon,  1 Jul 2024 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719864838; x=1722456839; bh=s3p0y6oCJfmqRErS35Xg3T7r
	p10skE//lwfuVK9bxtg=; b=vq8yO1P36uFGHMXXboxKskGk2TAwQAK+/ZA4ETJd
	HsnmVpCBNSk5NnykYcev0hKwW4q8alrQSnaHfbJhXmg0y96W4pMBEJVmyytHKoG0
	8V3twDmzKCthXCaDgKUq0CGtof9V1Kos+E5Il7THaGa/xf5fZuFTSXCemp5D7hxf
	+T+M9y1Df+LQrd2O8NiT+IWIqjSunyNcQXBrqw6BwkFd0+RuKalyfYB5UuPNxz3N
	5ZWdMafdkL+0VZJFZz9YRsm6e+g6tVNxEqy+m5KHL8Knq9XSZqJI8mpAnBXwExLm
	O14hlQ0h8gvo/CfWo2nSJU2UMgco31/LliAFpzE4+NumCg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vQwZ7Eajtq53; Mon,  1 Jul 2024 20:13:58 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WCcgp0qrPz6Cnk9Y;
	Mon,  1 Jul 2024 20:13:57 +0000 (UTC)
Message-ID: <63917f94-d9ed-4d43-b0a8-50ae4afcf1ee@acm.org>
Date: Mon, 1 Jul 2024 13:13:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/53] Let create*_workqueue() accept a printf-style
 format string
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org
References: <20240630222904.627462-1-bvanassche@acm.org>
 <ZoMF1ZydZUusxRcf@slm.duckdns.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZoMF1ZydZUusxRcf@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 12:39 PM, Tejun Heo wrote:
> On Sun, Jun 30, 2024 at 03:26:18PM -0700, Bart Van Assche wrote:
>> 1. Introduce the create*_workqueue2() macros that accept a printf-style
>>     format string and argument list.
> 
> I don't think we want to update create_workqueue() interface at all. Please
> convert them to use alloc_workqueue() instead. Once we convert all
> create_workqueue() users then we can just drop the old interface.
> 
> The challenge with converging to alloc_workqueue() interface is that the
> conversion needs to explicitly decide whether WQ_MEM_RECLAIM is needed or
> not but that shouldn't be *too* difficult.

The create*_workqueue() macros are used about 270 times in the Linux
kernel (the macro names also occur in some comments):

$ git grep -nHEw 
'create_workqueue|create_freezable_workqueue|create_singlethread_workqueue' 
| grep -Ev 'Documentation/|include/linux/workqueue' | wc -l
     271

That's too much for a single patch series. I can start with converting
the SCSI workqueue creation code.

Thanks,

Bart.

