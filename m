Return-Path: <linux-kernel+bounces-447749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06049F36A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB13165F78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528E520ADEB;
	Mon, 16 Dec 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="exfyr9mW"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1420ADCE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367646; cv=none; b=ZEYqn8x8fyPetsoDJ2uUi3cblJwBmdR/55sZbFVTqwNVBhi2juYRuBSh3R3GMa5w3BhuY3rQKf1aP6V17IsoBq4TdBWqPe3J/C0VHc8VOdEnwuMJnbaclFwW6DbqMDgXOfBuGhsrAcA4nrK/ZJlTB12K/TkRg291seKk4y6piMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367646; c=relaxed/simple;
	bh=8Q1js+pcs8/n4rytudeIN8FuQ/fPk7XU2j+tixD6Ao4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwpaUfBx5OGKAQNhKtkt/dDpF8EYVvvSBLoeuihXo6oRWK8aBcri3Y53lx1vrA/F8tJUBUIRXyxrO/7UosnhDsj606xWDT72G7O7BP7ohIshXaP4QVFXyWSyru6JP1EajbmTtKD1IGsVET1OsqYFR/QJzxYIH2URjLxoPmKwQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=exfyr9mW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <affab92f-9a5b-481a-8816-8d5560721648@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734367632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skTx0h9TH3DNtnegz4CJL4HMrceOqd6LbXCDG8zrIto=;
	b=exfyr9mWtCx+Tvg/549jdKiZtgeUr3etAll3gsc6DiUfX7ar1SX9JdBfUe8ccrzA/BmSTt
	eIRKE9Nop2E3tushrQAR+PqDNCD+JScwnsUqfvNmifb5z5C2fBwiI2bsW7cilbqPRnLKkx
	/nr0eCBnGitylWlNB2ufauUDjHAfUqo=
Date: Mon, 16 Dec 2024 17:47:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix mismatched max_msg_sz
To: zhenwei pi <pizhenwei@bytedance.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20241216121953.765331-1-pizhenwei@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241216121953.765331-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/12/16 13:19, zhenwei pi 写道:
> User mode queries max_msg_sz as 0x800000 by command 'ibv_devinfo -v',
> however ibv_post_send/ibv_post_recv has a limit of 2^31. Fix this
> mismatched information.
> 

This is a buf fix. Perhaps Fixes tag is needed?

> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 5 ++---
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index d2f57ead78ad..003f681e5dc0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -129,7 +129,7 @@ enum rxe_device_param {
>   enum rxe_port_param {
>   	RXE_PORT_GID_TBL_LEN		= 1024,
>   	RXE_PORT_PORT_CAP_FLAGS		= IB_PORT_CM_SUP,
> -	RXE_PORT_MAX_MSG_SZ		= 0x800000,
> +	RXE_PORT_MAX_MSG_SZ		= (1UL << 31),

In the above, perhaps the parentheses is not necessary.
Except that, I am fine with this.

Thanks a lot.
Review-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   	RXE_PORT_BAD_PKEY_CNTR		= 0,
>   	RXE_PORT_QKEY_VIOL_CNTR		= 0,
>   	RXE_PORT_LID			= 0,
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 5c18f7e342f2..ffd5b07ad3e6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -688,7 +688,7 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>   		for (i = 0; i < ibwr->num_sge; i++)
>   			length += ibwr->sg_list[i].length;
>   
> -		if (length > (1UL << 31)) {
> +		if (length > RXE_PORT_MAX_MSG_SZ) {
>   			rxe_err_qp(qp, "message length too long\n");
>   			break;
>   		}
> @@ -972,8 +972,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
>   	for (i = 0; i < num_sge; i++)
>   		length += ibwr->sg_list[i].length;
>   
> -	/* IBA max message size is 2^31 */
> -	if (length >= (1UL<<31)) {
> +	if (length > RXE_PORT_MAX_MSG_SZ) {
>   		err = -EINVAL;
>   		rxe_dbg("message length too long\n");
>   		goto err_out;


