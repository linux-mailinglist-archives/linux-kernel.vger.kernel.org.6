Return-Path: <linux-kernel+bounces-186055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72EE8CBF44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC5E1C21544
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CE182480;
	Wed, 22 May 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqE23WdT"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BFD7E572
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373756; cv=none; b=YMifLdtXTLSaaJY2CILj/twCpjnENh+hOh/kVAO2pb3zqxMtW96Oc+9j83u8LcJKKOTKs4QEqI17kk8fVqqIkZyTEGiTRBY2QX/Di5cFEv5iKoEQ+CtR08QAQBuyWStKEPlXUecsGNbColro90B0QIjay3OKT+HLW+fseS3Y4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373756; c=relaxed/simple;
	bh=YgWOXcmXZa+NxNmnvSW0g33eq38hRBxHQFuxngZ9Po8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/lsSVntMCsNi1HQX5yN+OJoaAxTU8IoItphxaQQCzT+u1t0PpdSK4/c4q7/ZNGnUEFXKFagJ2QLveTfRbwYL5jBzLL4g+Ns+n61k78AZfURzaD2FpKq0ojXvmT1QXoiAcvR90WqbcV/y/dArXsIwObIOWqiASN/6TLRxX1NF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqE23WdT; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kotaranov@linux.microsoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716373750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBqCPT8x+cGM4ULy2b+eQuWgpEzPPgSD98pYc3964+Q=;
	b=cqE23WdTOHz3c6Jp+iMdabjGcebl/Tfu5NNgrG2fL0upgM3qZpFnGRGVygnZIMF0dpOnVD
	Fnvlv1RoaFgFfkYcpfMxAFJKplKMvQ7JWZdDlKg7+kHAcO7/InSkam1rmJG/0BaEPbTXV0
	Jv7dOi2bL4+CBhzK5l9v/UtkvVoVv9U=
X-Envelope-To: kotaranov@microsoft.com
X-Envelope-To: sharmaajay@microsoft.com
X-Envelope-To: longli@microsoft.com
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <10a9df97-7b1b-4c0f-ad11-3ecf6512d926@linux.dev>
Date: Wed, 22 May 2024 12:29:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next v3 0/3] RDMA/mana_ib: Add support of RC QPs
To: Konstantin Taranov <kotaranov@linux.microsoft.com>,
 kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/5/22 10:23, Konstantin Taranov 写道:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch series enables creation and destruction of RC QPs.
> The RC QP can be transitioned to RTS and be used by rdma-core.
> 
> RDMA-CORE: https://github.com/linux-rdma/rdma-core/pull/1461
> 
> v2->v3:
> * fixed c99 comment style

Thanks a lot. I am fine with it.
You can add:

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> v1->v2:
> * Removed an old comment in 2/3.
> * Fixed text in a debug message in 3/3.
> 
> Konstantin Taranov (3):
>    RDMA/mana_ib: Create and destroy RC QP
>    RDMA/mana_ib: Implement uapi to create and destroy RC QP
>    RDMA/mana_ib: Modify QP state
> 
>   drivers/infiniband/hw/mana/main.c    |  59 ++++++++++
>   drivers/infiniband/hw/mana/mana_ib.h |  99 +++++++++++++++-
>   drivers/infiniband/hw/mana/qp.c      | 166 ++++++++++++++++++++++++++-
>   include/uapi/rdma/mana-abi.h         |   9 ++
>   4 files changed, 328 insertions(+), 5 deletions(-)
> 


