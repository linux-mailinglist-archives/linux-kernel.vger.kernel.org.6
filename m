Return-Path: <linux-kernel+bounces-258100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2493839E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 08:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0D32816BF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054998F66;
	Sun, 21 Jul 2024 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uor6/RuC"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B079CF
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721544087; cv=none; b=rG+ug0ukfPlEJ1EJPJx5g7ZscT/Jvhycg9Wjg2feLtKPi+/oTMv/w421XYf475c+obHu4N4gnkm8pjjokrPF3u/ZdKwJu2Bl7Noeim8ZVOjhtqSnASGCsVHhOEJmjNDMvb2himXbrubENadjujuiQUu8DZpY7zJmuzrZFxWFfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721544087; c=relaxed/simple;
	bh=h/FKIp9xMFC2FXIsZqzoruSg8zaMec3+Ui8zW18MmKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ja6cdjussRqgxTuxSF71S7eNPo4fUN8WImG+Nq9XADuJu5bT4OWYdPMJJTESWUk3hpE/bfuRLGgpsoH4ZveVBqNPd+qdh4tg87VvK02QJjNNLuhY+7s0SQRUeIOmar+984h8q5LpsrPWFDTqTIV6P6cIj/eZycvf59YX36nvSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uor6/RuC; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux@treblig.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721544081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BhzfpEAkMtM1dmk7F6Pxzl6Zv6RGXBbJz8lZCjiaexQ=;
	b=uor6/RuCwrfZtEtZCy6VtHgqA+hWDOenHgRlRfXTHv5Gle8KjTjI/DKXe4bWNxd2aglWyq
	d5BsLBAtqD3aN0bXBGKL/KnKkQX2hMSa0Yr6Lqeq8pQ8ytbZ+VN5neXfiDSrTHY45Ay13K
	BJM2+XA9NCPsxiHaH6Xw0ztPDvekqCs=
X-Envelope-To: allison.henderson@oracle.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: rds-devel@oss.oracle.com
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <8b5fd878-a952-4cca-87af-aa44319a4f86@linux.dev>
Date: Sun, 21 Jul 2024 08:41:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
To: linux@treblig.org, allison.henderson@oracle.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20240531233307.302571-1-linux@treblig.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240531233307.302571-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/1 1:33, linux@treblig.org 写道:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'rds_ib_dereg_odp_mr' has been unused since the original
> commit 2eafa1746f17 ("net/rds: Handle ODP mr
> registration/unregistration").
> 
> Remove it.
> 
Need Fixes?

Fixes: 2eafa1746f17 ("net/rds: Handle ODP mr
registration/unregistration")

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   net/rds/ib_rdma.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
> index 8f070ee7e742..d1cfceeff133 100644
> --- a/net/rds/ib_rdma.c
> +++ b/net/rds/ib_rdma.c
> @@ -40,10 +40,6 @@
>   #include "rds.h"
>   
>   struct workqueue_struct *rds_ib_mr_wq;
> -struct rds_ib_dereg_odp_mr {
> -	struct work_struct work;
> -	struct ib_mr *mr;
> -};
>   
>   static void rds_ib_odp_mr_worker(struct work_struct *work);
>   


