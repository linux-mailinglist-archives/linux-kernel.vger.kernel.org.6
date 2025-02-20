Return-Path: <linux-kernel+bounces-523622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93757A3D95E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA5C17AF2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E271F5833;
	Thu, 20 Feb 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9CR+wPi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68D1F462D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052758; cv=none; b=ULesTyuxFQggBDTSDh0Oz7yKIWF1NxCo2DEpaWAuF7DVLUAJ1uGtFDk0LByr9OjxbuYoDHMg+PSsKigKrCT9ywMKdLONuHqUZP5YI88fgN4v7KGnBym3lauuH1QKLjvPHVrzw8y5WFYHG26ITPMpx2kiALVBpVnxxfvn7C/VowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052758; c=relaxed/simple;
	bh=Ea3jIKLYow5Ekha8QuzjFImb1hLb9NcGCStRxsno7W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CKuuLO2iqO4dAMnMej10xU4myV2MINpbSqDK7WlN7Y4MGAf4i0+6PQL1+qO1u1/CSbpJcx417e9+jIt/feDb305Pu915nXbS+mKw8UomOF5W9B+ZU2vmQ9cfPCYQLJ0naQ6XGKg6E1S88Khx12Z58LXnRLFSEvrkWx+cJ6OBmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9CR+wPi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740052754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqjvrMahp88i80gSL9/FkktsPFnEDI7mV502dC5mGqw=;
	b=V9CR+wPiKZlOYINWBbpTJWSAi6msjtRdhircAQO10/8OiZ9qIn9WuzyauaemSmrNQkZJP5
	xe6T8Lw94q/vMSVheak+eKe2Pld884MZecLyBFqGEDhRf2TNziWQKb10D29iLUl/AwKnrC
	RU7PRbuWS3hvvbMSs2mxYdibUrzgdTA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-oTVS0P_xPKKItwAw67wNxw-1; Thu, 20 Feb 2025 06:59:13 -0500
X-MC-Unique: oTVS0P_xPKKItwAw67wNxw-1
X-Mimecast-MFC-AGG-ID: oTVS0P_xPKKItwAw67wNxw_1740052752
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso372520f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740052752; x=1740657552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqjvrMahp88i80gSL9/FkktsPFnEDI7mV502dC5mGqw=;
        b=Gnq9l4ijEXaOXzKP3Qx9n5U70zCaFxMgdEQFfVzessI/RSp0oPIfv8irxC4dlnK37m
         515jK/UblxB8sENEftEtCzuOXFWc4tzY7/zlY+xduzNz3YBOYUuVmMhweqvr1lCwJYyz
         XEfRsJ64IKY6cjZAmZPwUMlAHXtZlqDk/ZIK+c0mCZSu0Z+qb99FfHGYkONCkLKpqIeO
         lzuez2jIiOpj568y1PzLezoXHAeZFZN3OP3lagZbz6x+0JK+qX+RP1FT+oaHsSdEZ7jK
         NHCJKlxhdY6NDTNCejFh2++GVfiQU0STnhnkCU3f8RwSotTughJY199DcuPSOCkMVBDL
         1QmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpzX/b42rUoEhfh3lXTvAiC+Oz61rlD4vt6Qvdu4YHdr97RMVz1+rz2kR7O0R3XKb+1R+09fcw0pwt5Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLzsNfAsPABT0JRzqhahV4FhyAuFRdJGDy/oNoLIUxqF0piN3C
	P7P57OL5uEWMsF1qeHjJ1WAz5uAl4krZuosF0SuDlifGH8nZyoDGqNbM19aW7dVMfILPaX3sYcS
	n0JRlzOd2B/bfp6br97pI2dvV/np2/+leRpGdiZkJ8GPvMnO1msI9oT19cg7Eew==
X-Gm-Gg: ASbGncs28f0pG7Dj2m8919Wf0bJXofmJ9ba/MD2lDKZN+aEUsp/GvCOy/FaXAjrSmbO
	TcGmV7fgrA1QpZYBCJQ5I48UwwnSJY7WMkRnSwYXvoB8pQYv9EJttM1vXRTiT89sKBKzikzDwIX
	+cI9uS/66mJ+Ykt5xgfes8eWxj7bhmFbHKKVR+RrhZjj68NauzUkaSQECqBMKIqpNBkQz23zqXB
	20GjV+OZRuRLmZhW0v+ui2N+HKVp22tXvpiGoH2Iwh6PXALupIB7FFcFovnxJi2iF7z03lUpMO6
	pUjtjCOH0ICOt78riV0GU6sNfa3Z7JoGxUw=
X-Received: by 2002:adf:f446:0:b0:38d:dc4d:3473 with SMTP id ffacd0b85a97d-38f3417156cmr16845528f8f.51.1740052752398;
        Thu, 20 Feb 2025 03:59:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOPU9lInC1kfstheHqHqAmL45KoNtwIEMLJYAbzRSdouRWSdZYAklADI4skYnwy90tyvYQmg==
X-Received: by 2002:adf:f446:0:b0:38d:dc4d:3473 with SMTP id ffacd0b85a97d-38f3417156cmr16845505f8f.51.1740052752017;
        Thu, 20 Feb 2025 03:59:12 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25914d73sm20784465f8f.54.2025.02.20.03.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 03:59:11 -0800 (PST)
Message-ID: <1a053f30-4a13-4199-bf1f-40b729b4a146@redhat.com>
Date: Thu, 20 Feb 2025 12:59:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
To: Sai Krishna <saikrishnag@marvell.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 lcherian@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch,
 kalesh-anakkur.purayil@broadcom.com
References: <20250217085257.173652-1-saikrishnag@marvell.com>
 <20250217085257.173652-4-saikrishnag@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250217085257.173652-4-saikrishnag@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 9:52 AM, Sai Krishna wrote:
> This implementation uses separate trigger interrupts for request,
> response MBOX messages against using trigger message data in CN10K.
> This patch adds support for basic mbox implementation for CN20K
> from AF side.
> 
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/cn20k/api.h |   8 +
>  .../marvell/octeontx2/af/cn20k/mbox_init.c    | 215 ++++++++++++++++++
>  .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  17 ++
>  .../marvell/octeontx2/af/cn20k/struct.h       |  25 ++
>  .../net/ethernet/marvell/octeontx2/af/mbox.c  |  83 ++++++-
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |  69 ++++--
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  16 +-
>  .../marvell/octeontx2/nic/otx2_common.c       |  10 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   9 +-
>  10 files changed, 420 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> index b57bd38181aa..9436a4a4d815 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> @@ -15,8 +15,16 @@ struct ng_rvu {
>  	struct qmem             *pf_mbox_addr;
>  };
>  
> +struct rvu;
> +

A few lines above the header file rvu.h is included, the forward
declararions should not be needed...

>  /* Mbox related APIs */
>  int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int num);

... otherwise this line will give warns in the previous patch.

[...]
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 9f145c540253..acd9e1ca6d2b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -597,8 +597,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
>  		base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
>  		       MBOX_SIZE;
>  	else
> -		base = readq((void __iomem *)((u64)pf->reg_base +
> -					      RVU_PF_VF_BAR4_ADDR));
> +		base = readq((pf->reg_base + RVU_PF_VF_BAR4_ADDR));
>  
>  	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
>  	if (!hwbase) {
> @@ -647,7 +646,7 @@ static void otx2_pfvf_mbox_destroy(struct otx2_nic *pf)
>  	}
>  
>  	if (mbox->mbox.hwbase)
> -		iounmap(mbox->mbox.hwbase);
> +		iounmap((void __iomem *)mbox->mbox.hwbase);
>  
>  	otx2_mbox_destroy(&mbox->mbox);
>  }
> @@ -1312,7 +1311,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
>  
>  	/* CQ */
>  	for (qidx = 0; qidx < pf->qset.cq_cnt; qidx++) {
> -		ptr = otx2_get_regaddr(pf, NIX_LF_CQ_OP_INT);
> +		ptr = (__force u64 *)otx2_get_regaddr(pf, NIX_LF_CQ_OP_INT);
>  		val = otx2_atomic64_add((qidx << 44), ptr);
>  
>  		otx2_write64(pf, NIX_LF_CQ_OP_INT, (qidx << 44) |
> @@ -1351,7 +1350,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
>  		 * these are fatal errors.
>  		 */
>  
> -		ptr = otx2_get_regaddr(pf, NIX_LF_SQ_OP_INT);
> +		ptr = (__force u64 *)otx2_get_regaddr(pf, NIX_LF_SQ_OP_INT);
>  		val = otx2_atomic64_add((qidx << 44), ptr);
>  		otx2_write64(pf, NIX_LF_SQ_OP_INT, (qidx << 44) |
>  			     (val & NIX_SQINT_BITS));

All the changes here looks unrelated. I guess they fix compile warnings.
Should go into a separate patch, earlier in the series.

/P


