Return-Path: <linux-kernel+bounces-259898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68802939F45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233B52836BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8FD14F9C7;
	Tue, 23 Jul 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFmxf8PO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974C14D2B8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732613; cv=none; b=Fcx4LBoKWzbTem2WW4q0/UsMKdApw8hj3txazsO+tJnPDDNzOgUQQ1xf688UvFarmmwPqR39J9z+WOKEpdgFcW6O9I+GMAwasytNs8j1As7NpASHzkvWh/c6IscEjIsfbH70AfnsBF/CDGmeJR/ZFR5JDTJ4P6xyOtrJvOZ+Cp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732613; c=relaxed/simple;
	bh=OOYTAc0WoZeRWU6IrWBLljNUtPQtZJ/KFGIhwGS8JGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Htz/FX4wsmRPTQVXzgqoTppXr8yP1nfnka7+8AbNrSbzk9kfS+GKiA522YEqAJzK2DTLON38801iFBT/fMTPHeMsQtkledXH0V/VZDl/BpRST8SbpbTKGthbfwuPcsjQ916eBQvClbDjl8yOoRNeILEGSo05FbPKyZaW/UyjZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFmxf8PO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721732611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CG0TDjV60g77He2sGPyPmAEOzJNVXOyb6cTctysXaN0=;
	b=VFmxf8PORVHXrpsqM4ltJ3s2pzk4wRztrymqsXv3TlV3/EU7ND2XTc1l/ADpOMqKJ89J8B
	yvhQTsvekt/C+/FEhrYrEsBvczEON2QisqeYvfzv0nqnQwRzY63XxDHtvo593o0F1adxH5
	SRJoY3VkPB4kUClj6s1pQOiZFAZavus=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-9HJpCw0QOI2UVEi03_bB0w-1; Tue, 23 Jul 2024 07:03:28 -0400
X-MC-Unique: 9HJpCw0QOI2UVEi03_bB0w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a29c8de0f9so377337a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721732607; x=1722337407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CG0TDjV60g77He2sGPyPmAEOzJNVXOyb6cTctysXaN0=;
        b=qWIfC3dXl0eX5iQc6Wf03VYhM4bqxvwNmPbMwno1jxWT6DddWhSX7BibTQG5wKI0/A
         Vdfk0C4/RnZv9C5g3nAlogg/pl8n84Rp5Xf6MWFbzWy4W+v83ZwPaM+5oXhPbOHEjo5L
         osblk/llII3Pewbd9g48DVadIznox1TvZi7Zzzdko9RBNb8AiXeUZG9Qx43PHApAJsjq
         rOw7DgDGbki2TC2OoUTkOvmWNFgIEb1fG+jy8pRIhPafCpLnm27FzU4ad9gST6Ns28m3
         PC4JqIY/nHcLBsmvLvQ6f+HnSGYjs48F/LCB41PtyE0ma3ljQdzvJFgmaM8BToP4PZRM
         8lAw==
X-Forwarded-Encrypted: i=1; AJvYcCXrCSlP2fTS37AgmKS6XUqQG3kc+4wQa7ibpYx7CYjRakG4Ree9LFByskPyzG4eZDzdHdu88FW8YRqXMruFcxuiCgY+hhstTHIVfYUB
X-Gm-Message-State: AOJu0Yx949qCdzsj0GRyTyUVpdndF5mm9NtzMuTdpSHZEwgRDJqVMhrn
	uiuyjpp5f8gEAlfXnJn8MYueBF1UlXBg+yy87LZ9e60rXZhXJ7ryxxbxv8wlOt5T4hcHIRUl1Of
	tMMN0TrVGH/hvxHnhMDtpTMIGJI6CjguoOSqNzLsU06SgAwoVFDMwrQS0B5JyeA==
X-Received: by 2002:a17:907:9714:b0:a79:a1b2:1a5e with SMTP id a640c23a62f3a-a7a420b8f79mr397237966b.10.1721732607616;
        Tue, 23 Jul 2024 04:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEPlHAKH81TEBLznH9C53oe8ITsSDPLiHU5eE2F64XzAAmhKtDgdv28xYCROtzjI27l2T9gQ==
X-Received: by 2002:a17:907:9714:b0:a79:a1b2:1a5e with SMTP id a640c23a62f3a-a7a420b8f79mr397236266b.10.1721732607162;
        Tue, 23 Jul 2024 04:03:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8beef9cdsm92164066b.89.2024.07.23.04.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 04:03:26 -0700 (PDT)
Message-ID: <9552840d-b431-4e0b-b79f-e7a90431b709@redhat.com>
Date: Tue, 23 Jul 2024 13:03:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] net/mlx5: Reclaim max 50K pages at once
To: Anand Khoje <anand.a.khoje@oracle.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, tariqt@nvidia.com,
 edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com
References: <20240722134633.90620-1-anand.a.khoje@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240722134633.90620-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/24 15:46, Anand Khoje wrote:
> In non FLR context, at times CX-5 requests release of ~8 million FW pages.
> This needs humongous number of cmd mailboxes, which to be released once
> the pages are reclaimed. Release of humongous number of cmd mailboxes is
> consuming cpu time running into many seconds. Which with non preemptible
> kernels is leading to critical process starving on that cpu’s RQ.
> On top of it, the FW does not use all the mailbox messages as it has a
> limit of releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES +
> MLX5_PAGES_TAKE device command. Hence, the allocation of these many
> mailboxes is extra and adds unnecessary overhead.
> To alleviate this, this change restricts the total number of pages
> a worker will try to reclaim to maximum 50K pages in one go.
> 
> Our tests have shown significant benefit of this change in terms of
> time consumed by dma_pool_free().
> During a test where an event was raised by HCA
> to release 1.3 Million pages, following observations were made:
> 
> - Without this change:
> Number of mailbox messages allocated was around 20K, to accommodate
> the DMA addresses of 1.3 million pages.
> The average time spent by dma_pool_free() to free the DMA pool is between
> 16 usec to 32 usec.
>             value  ------------- Distribution ------------- count
>               256 |                                         0
>               512 |@                                        287
>              1024 |@@@                                      1332
>              2048 |@                                        656
>              4096 |@@@@@                                    2599
>              8192 |@@@@@@@@@@                               4755
>             16384 |@@@@@@@@@@@@@@@                          7545
>             32768 |@@@@@                                    2501
>             65536 |                                         0
> 
> - With this change:
> Number of mailbox messages allocated was around 800; this was to
> accommodate DMA addresses of only 50K pages.
> The average time spent by dma_pool_free() to free the DMA pool in this case
> lies between 1 usec to 2 usec.
>             value  ------------- Distribution ------------- count
>               256 |                                         0
>               512 |@@@@@@@@@@@@@@@@@@                       346
>              1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
>              2048 |                                         0
>              4096 |                                         0
>              8192 |                                         1
>             16384 |                                         0
> 
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Acked-by: Saeed Mahameed <saeedm@nvidia.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


