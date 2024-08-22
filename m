Return-Path: <linux-kernel+bounces-297198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9592F95B468
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7571C23037
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1041C93C9;
	Thu, 22 Aug 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZjgWMlWx"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A913A244
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327988; cv=none; b=YKOF5WMX6IzAKOBcpV+GV41wsLoVX5AG0qfENy9vnPkfVf0Ey9HHsSJ1IZ9lx1vKUcQToAxcWk+pVbjlCX6mXixpz29/8HeJucx5WXvcD//754sB/ghJrB6FvZuT8GM0JrWytk85/+VhbsdlWwDdIwcobpXD0HhelV/NOoGCCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327988; c=relaxed/simple;
	bh=v13QhtP73doNPeUmViBh7ZBVqvc2ai+A0feVsChifzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKfX0ZTw7UzGYWPQ0aJerfi7CP4WzzJigFNiOr10gv16AvRoztsIOFzbtSDMcz2rOI1eWPJMWxB3JxRhbxjQpmJLoq73d+J/Tfp2MVj29qMYtimlV0rEGKAomHV7YblDkGiB33zuzrNPrPrlJLraSlvJV38WKEfNEBqnAxWyVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZjgWMlWx; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d933e865-2b6b-41c1-a0f2-46f8fef3cc17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724327984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDBmZn7g9DVk/1HehHsQgN3rBJjFfubx4OxAb5/I3IE=;
	b=ZjgWMlWxZ+FKIkJw9aPx3v4Muz1Uc5lO2loLaeVSuDqhSHxh0jcw3hPvwad6ujm209nB9W
	eCBexh0Y0X5KfioHNn2MWyztK3WQ6FpiLXIq/7dAAwP4R7YeuCM+r3C86bGZ+StUIY004P
	gZkFr90RgPZ8+5cKIkTXQhXw7ebtR6c=
Date: Thu, 22 Aug 2024 19:59:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] RDMA/rxe: Use sizeof instead of hard code number
To: zhenwei pi <pizhenwei@bytedance.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com, jgg@nvidia.com, leonro@nvidia.com
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
 <20240822065223.1117056-2-pizhenwei@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240822065223.1117056-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/22 14:52, zhenwei pi 写道:
> Use 'sizeof(union rdma_network_hdr)' instead of hard code GRH length
> for GSI and UD.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 6596a85723c9..bf8f4bc8c5c8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -351,7 +351,7 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
>   
>   		for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
>   			recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
> -		if (payload + 40 > recv_buffer_len) {
> +		if (payload + sizeof(union rdma_network_hdr) > recv_buffer_len) {

The definition of union rdma_network_hdr is as below

  797 union rdma_network_hdr {
  798         struct ib_grh ibgrh;
  799         struct {
  800                 /* The IB spec states that if it's IPv4, the header
  801                  * is located in the last 20 bytes of the header.
  802                  */
  803                 u8              reserved[20];
  804                 struct iphdr    roce4grh;
  805         };
  806 };

The length is 40 byte.

But in this,

sizeof(struct iphdr) (20) + sizeof(struct udphdr) (8) + sizeof(struct 
rxe_bth) (12) = 40

Not sure if we should use sizeof(union rdma_network_hdr) or 
(sizeof(struct iphdr) + sizeof(struct udphdr) + sizeof(struct rxe_bth)) 
in this place.

Best Regards,
Zhu Yanjun


>   			rxe_dbg_qp(qp, "The receive buffer is too small for this UD packet.\n");
>   			return RESPST_ERR_LENGTH;
>   		}


