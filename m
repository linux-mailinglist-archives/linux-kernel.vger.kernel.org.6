Return-Path: <linux-kernel+bounces-298277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B5B95C510
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3C4281E71
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2C74BE1;
	Fri, 23 Aug 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wQPaHuAL"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839048CCC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392575; cv=none; b=j+NzFwxATBcpjvDA8/H1syBVRBdxrRkaU20myl+I6Xcjk6/0nO3blVaBqTnBKvcvwFtxi5HlWpafczrY/9y+cSwUaW2bdDcC/OPue7RSA386jiRDtalNMD/3xTtMqGdKG7d/sVt1r79o/R/6S6Umc/2sv1ks/dGewul+FMKBRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392575; c=relaxed/simple;
	bh=UH/845C3CKqyzAbizs/Nu/leaga8purHzb9PP0avFys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AptvWbI6dlKYpezdWwh4okSEsWwosefpn+sJ1I5htldS+nxaZoB1jSXU9mo/iiLV0xcfg4xeTfX1kGn+siF2vnqTLCkvgJ+UFhjA80DGsXuKitIlXvbgYz4a1rVeZ00QYvt9kWukz+DuX8mg8pxcdtnA+tTOJ81uRzNWsCz9ATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wQPaHuAL; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70f73586-670e-43d0-adf4-0950a9b3940d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724392570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4VR43m38UmF4fnbqpzcLCBIxvAClHFKLB7ul2q3ync=;
	b=wQPaHuALIFdCW4qTRlYfHw74flRHn/b7xx0uFq3raDuJb2dLDad+2jdqLdaZjDCbcEAaKO
	MyVZZoIkY8I17v2cv3G4BXW/qFjDj1mGRz3xc+UIey2Tse3mHDQ0Tw2HhZx5jMlAE1QvQQ
	k7u+Svvf2DM07yq2qsH4t27rWkvK/Fg=
Date: Fri, 23 Aug 2024 13:56:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] RDMA/rxe: Use sizeof instead of hard code number
To: zhenwei pi <pizhenwei@bytedance.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 zyjzyj2000@gmail.com, leonro@nvidia.com
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
 <20240822065223.1117056-2-pizhenwei@bytedance.com>
 <d933e865-2b6b-41c1-a0f2-46f8fef3cc17@linux.dev>
 <20240822123649.GP3773488@nvidia.com>
 <CABoGonKvG9AyuVPMG29b3q5bGr7ZAH5RsGg7TOtkcaAZm9F-Dg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CABoGonKvG9AyuVPMG29b3q5bGr7ZAH5RsGg7TOtkcaAZm9F-Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/23 10:30, zhenwei pi 写道:
>
> On 8/22/24 20:36, Jason Gunthorpe wrote:
> > On Thu, Aug 22, 2024 at 07:59:32PM +0800, Zhu Yanjun wrote:
> >> 在 2024/8/22 14:52, zhenwei pi 写道:
> >>> Use 'sizeof(union rdma_network_hdr)' instead of hard code GRH length
> >>> for GSI and UD.
> >>>
> >>> Signed-off-by: zhenwei pi
> >>> ---
> >>> drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c 
> b/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> index 6596a85723c9..bf8f4bc8c5c8 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> @@ -351,7 +351,7 @@ static enum resp_states 
> rxe_resp_check_length(struct rxe_qp *qp,
> >>> for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
> >>> recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
> >>> - if (payload + 40 > recv_buffer_len) {
> >>> + if (payload + sizeof(union rdma_network_hdr) > recv_buffer_len) {
> >>
> >> The definition of union rdma_network_hdr is as below
> >>
> >> 797 union rdma_network_hdr {
> >> 798 struct ib_grh ibgrh;
> >> 799 struct {
> >> 800 /* The IB spec states that if it's IPv4, the header
> >> 801 * is located in the last 20 bytes of the header.
> >> 802 */
> >> 803 u8 reserved[20];
> >> 804 struct iphdr roce4grh;
> >> 805 };
> >> 806 };
> >>
> >> The length is 40 byte.
> >
> > This looks like the right struct to me if this is talking about the
> > special 40 byte blob that is placed in front of UD verbs completions.
> >
> > Jason
>
> Yes, this is the front part(40 bytes) of UD/GSI verbs completion.
>
When running, you can print the value of the front part (40 bytes) of 
UD/GSI to confirm that these 40 bytes are the union rdma_network_hdr.

If these 40 bytes are the union rdma_network_hdr,

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Best Regards,

Zhu Yanjun

>
> -- 
> zhenwei pi
>
-- 
Best Regards,
Yanjun.Zhu


