Return-Path: <linux-kernel+bounces-205456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1748FFC4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E694285740
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9115278C;
	Fri,  7 Jun 2024 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U5Me/K+7"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D314445008
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741997; cv=none; b=BrZbzv1NJEvYVnwEn12Dq5q/U42zQrYiwtepyKL8h9UBA7W+VjMvQ2EqmcdY8UG9EZrGTkke/abQOzVnq5RuZHc//cULS/e2VzVpMlILXBFkqdD4sqwON7O7nqhAfy428f/PJa2aPM84je0QKZH9wKZyNo2H2hvHOEMo9lWIFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741997; c=relaxed/simple;
	bh=aeeAV18NL5zwnJhyY5Mu0GQcHJndNDUCKeVCW99ZGG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxNN9hTOz+P9K6OSlBQPywEAjOyNtE7Mb5+sdCVbvVeVv5MmisZbHQRAfFgZQz3uMLQ1RcwAQz8LcNPTitepZuCzdUi4dCx+MV6jT6ZP9KC7+Fy3QsV0fFRP5zIOLsoBl1pFoE5AgCTzdC0nQII/y0hprfjNcHmJi8IZVDDo6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U5Me/K+7; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hch@lst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717741993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqn98qnbHlEsgzTqMBvOqaHJPzVEiq0rM4rP3bX1Rw8=;
	b=U5Me/K+7cduPOZrRRjB59q7O7SRFQM2ACruBZevtAGPMJ9H5JNCUSZxtxTGRQovbDSWgfJ
	VGd2T2T11otqHh3sj2AMIkvuOVM2Jyl5J0PKAfPW9qcYiPmxwSR3OtCW5sLbl93RdT/XpG
	DLb30vyf6TvHfCINSJ1lHIwTmD+JxJE=
X-Envelope-To: f.weber@proxmox.com
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: t.lamprecht@proxmox.com
Message-ID: <1899ff04-f1de-4d1a-be97-a8702ca3cd65@linux.dev>
Date: Fri, 7 Jun 2024 14:33:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
 ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
 <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
 <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
 <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com>
 <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev>
 <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com>
 <dea87c0a-1c36-4737-bea5-cb7fa273b724@linux.dev>
 <20240607045511.GB2857@lst.de>
 <2223bbb9-8bc8-4566-9c3f-ef6103422068@linux.dev>
 <20240607063101.GA5387@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240607063101.GA5387@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/7 14:31, Christoph Hellwig wrote:
> On Fri, Jun 07, 2024 at 02:24:52PM +0800, Chengming Zhou wrote:
>> Right, how about add WARN here to catch it? Or just set it to PREFLUSH?
>> Not familiar with dm code, need help if we need to fix it in dm. :)
> 
> We'll need to fix dm first.  I'll take a look if I can reproduce it.
> Let's kept the list_del_init fix in first, I hope I can allocate some
> time to this soon.

Ok, it's great, thanks!

