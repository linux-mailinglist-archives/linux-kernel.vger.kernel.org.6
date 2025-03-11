Return-Path: <linux-kernel+bounces-555698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DFEA5BB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D4618971E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8B22D4FE;
	Tue, 11 Mar 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPYLoAxQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4A22B5A8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683598; cv=none; b=u0tNnirXEQKZxdJCYnmnPFMYkwI2LoriNIW3+FVhXxBkTKDjnIJv/PfXQONO1llUiwkiyfsshb0PaKLfpe2a8++RBoJDBhAvm76OkeyS5ni5OqcN59VwZJa+Orkd+ge2j5Bmr/zM79s34qPYeUUTGczeMfE4oYWIPOT/F6ma/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683598; c=relaxed/simple;
	bh=iA6mnCj7Qy5YCe/bg0WzxBq0xFn9tOEWd8Sg/pfOH78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyQBYpiu/tKezlrmwewslf5ei7P9ZbcTlCYWY3UeZZKhCkbyHZ/ANQCPiVQoN9YorbkCk67v+wQhd3YeO7KuGOl+nDobBQkI5ftHi+upAVVKMXWMM06AHrD3lsXkzlxxKWK34cXgu0/hJL/W4xqTN4Clj5xp6cYL8rSSnhiRMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPYLoAxQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741683595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqnlKZZInNbUMVaxemGpweqmwSoqd9viWeAicyRcRjo=;
	b=UPYLoAxQzW1B1fjTrZ9cNstv7tRA+devNR6g6ycjdH2bsX5OkNHVMdY6kfc3Ejd2VGfIFX
	mQEOllaSLQAvaPAovt/bG3bMx3d48OgR5duwe5dnJ97XEFJQw9fpBIcEN2B5eu/bewMnKn
	4EftR+9kJSRQOcGlVORUYy4tpXM6pT4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-Ldss8hrXN52GTZqkskj_fw-1; Tue, 11 Mar 2025 04:59:54 -0400
X-MC-Unique: Ldss8hrXN52GTZqkskj_fw-1
X-Mimecast-MFC-AGG-ID: Ldss8hrXN52GTZqkskj_fw_1741683593
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so11529925e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 01:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683593; x=1742288393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqnlKZZInNbUMVaxemGpweqmwSoqd9viWeAicyRcRjo=;
        b=ZzP24XWrYDjVa/yEHm4dMza4swU3hTgkomMKm+XSlce3GmczZUzhfroXEN7fIP/Xgf
         L3TABn/ugun/RVe2rOF+0SSrTQr3R9Uwg/9VGCg3bRrbYdHQGNTUPI0n9JMnVkqy0VMO
         87iomgOuRCVgrMWdHWWM5tPxLzyHzOeB1FQ9LN617cLnFS2hV/mH9CXCGrGZttZl/GSZ
         EDESkiDAvFm/kQGrTu7OFbzSj9p5zzecPkKEMCz7LAqUG7vcQbsGXdsFqBdNOyeAa+Vp
         f6P8B7BWZngcs7/KdphK1tvgeT22vaqD5+LutsfcCtVDb39ZQbtC2Ne+jcxkSMkA+GTC
         CxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeCllVlN8vKuceBWTYgzeanwG+XJ7A56ApALn/KTO1/SCTPgcCdSB0HLQq+J/6uR8YKL7OQvM/QX/hHVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6zMETVJGPYdsuLxSA2KDKybiPEngoq/HbEJF8lQAdF7x90dk
	gT9XBrgjmKMyPt4sovK+6H9Pzy3vLXQ8N4d/e0PksadYP5pypQjf0w12OykoEKlXIO2ch8ufx4Y
	q/FlVCiH1MoOmwQtGBmJKtIF+b0G2kCF6+SSxLhz/OHwHOPLRc5fMaXlg2CBqXw==
X-Gm-Gg: ASbGncsek7133Wz1i0eYQWlAMH3nMNuTmozXyvGEZE6qNFm/z7OCBW5LnTmfkU2G/9n
	H7ekUpuCDKGxG2Jb7k5hLa9KbENKigNDeQ34hvSpVrHuGzFLJNkI/B439pICR/tciw/sYDLtb+V
	d0cQRIH5yrZrNcOcnz323sRTMvm88ht0/kMVtx2knkgQb8PJpKRqUdVUaM6IRtH3p0SxCu13Xxi
	CKfIx2H0yaDDOPMsS20uzpfdv2QqOgE49GN1Hrxx8LUi57ceSgrirve70WjydRwN/d6ee50k/Uq
	6PJ30iYPJttO8RL69+VLEyYyNbzDaId90/iXGNrT1M/VKw==
X-Received: by 2002:a05:600c:3542:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d01bdbc01mr40750265e9.10.1741683593082;
        Tue, 11 Mar 2025 01:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ5AVycEeQIEPH/bGBFOO7jW/oC4hoyt2MafohO5QdfjBwnRvqtWeJdoi9Lli+bBR0MxeIMA==
X-Received: by 2002:a05:600c:3542:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d01bdbc01mr40750015e9.10.1741683592688;
        Tue, 11 Mar 2025 01:59:52 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79cfsm17510326f8f.10.2025.03.11.01.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 01:59:52 -0700 (PDT)
Message-ID: <2c9accbd-fd6f-421c-9d00-1f36a6152b8d@redhat.com>
Date: Tue, 11 Mar 2025 09:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: use the correct ndev to find pnetid
 by pnetid table
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 pasic@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 1:43 PM, Guangguan Wang wrote:
> When using smc_pnet in SMC, it will only search the pnetid in the
> base_ndev of the netdev hierarchy(both HW PNETID and User-defined
> sw pnetid). This may not work for some scenarios when using SMC in
> container on cloud environment.
> In container, there have choices of different container network,
> such as directly using host network, virtual network IPVLAN, veth,
> etc. Different choices of container network have different netdev
> hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1
> in host below is the netdev directly related to the physical device).
>             _______________________________
>            |   _________________           |
>            |  |POD              |          |
>            |  |                 |          |
>            |  | eth0_________   |          |
>            |  |____|         |__|          |
>            |       |         |             |
>            |       |         |             |
>            |   eth1|base_ndev| eth0_______ |
>            |       |         |    | RDMA  ||
>            | host  |_________|    |_______||
>            ---------------------------------
>      netdev hierarchy if directly using host network
>            ________________________________
>            |   _________________           |
>            |  |POD  __________  |          |
>            |  |    |upper_ndev| |          |
>            |  |eth0|__________| |          |
>            |  |_______|_________|          |
>            |          |lower netdev        |
>            |        __|______              |
>            |   eth1|         | eth0_______ |
>            |       |base_ndev|    | RDMA  ||
>            | host  |_________|    |_______||
>            ---------------------------------
>             netdev hierarchy if using IPVLAN
>             _______________________________
>            |   _____________________       |
>            |  |POD        _________ |      |
>            |  |          |base_ndev||      |
>            |  |eth0(veth)|_________||      |
>            |  |____________|________|      |
>            |               |pairs          |
>            |        _______|_              |
>            |       |         | eth0_______ |
>            |   veth|base_ndev|    | RDMA  ||
>            |       |_________|    |_______||
>            |        _________              |
>            |   eth1|base_ndev|             |
>            | host  |_________|             |
>            ---------------------------------
>              netdev hierarchy if using veth
> Due to some reasons, the eth1 in host is not RDMA attached netdevice,
> pnetid is needed to map the eth1(in host) with RDMA device so that POD
> can do SMC-R. Because the eth1(in host) is managed by CNI plugin(such
> as Terway, network management plugin in container environment), and in
> cloud environment the eth(in host) can dynamically be inserted by CNI
> when POD create and dynamically be removed by CNI when POD destroy and
> no POD related to the eth(in host) anymore. It is hard to config the
> pnetid to the eth1(in host). But it is easy to config the pnetid to the
> netdevice which can be seen in POD. When do SMC-R, both the container
> directly using host network and the container using veth network can
> successfully match the RDMA device, because the configured pnetid netdev
> is a base_ndev. But the container using IPVLAN can not successfully
> match the RDMA device and 0x03030000 fallback happens, because the
> configured pnetid netdev is not a base_ndev. Additionally, if config
> pnetid to the eth1(in host) also can not work for matching RDMA device
> when using veth network and doing SMC-R in POD.
> 
> To resolve the problems list above, this patch extends to search user
> -defined sw pnetid in the clc handshake ndev when no pnetid can be found
> in the base_ndev, and the base_ndev take precedence over ndev for backward
> compatibility. This patch also can unify the pnetid setup of different
> network choices list above in container(Config user-defined sw pnetid in
> the netdevice can be seen in POD).
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> ---
>  net/smc/smc_pnet.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 716808f374a8..b391c2ef463f 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -1079,14 +1079,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
>  					 struct smc_init_info *ini)
>  {
>  	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
> +	struct net_device *base_ndev;
>  	struct net *net;
>  
> -	ndev = pnet_find_base_ndev(ndev);
> +	base_ndev = pnet_find_base_ndev(ndev);
>  	net = dev_net(ndev);
> -	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
> +	if (smc_pnetid_by_dev_port(base_ndev->dev.parent, base_ndev->dev_port,
>  				   ndev_pnetid) &&
> +	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
>  	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
> -		smc_pnet_find_rdma_dev(ndev, ini);
> +		smc_pnet_find_rdma_dev(base_ndev, ini);
>  		return; /* pnetid could not be determined */
>  	}
>  	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);

I understand Wenjia opposed to this solution as it may create invalid
topologies ?!?

https://lore.kernel.org/netdev/08cd6e15-3f8c-47a0-8490-103d59abf910@linux.ibm.com/#t

Wenjia, could you please confirm?

Thanks,

Paolo


