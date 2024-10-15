Return-Path: <linux-kernel+bounces-365714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3B99E7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3716CB22856
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4131E8855;
	Tue, 15 Oct 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJseQGVs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00B1D8DEA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993435; cv=none; b=nulvbw7suSnqe8sb4WrKvVs8Y3jtW6JS8QV33M8bLI5QLatJstY8nD8ZUOxJmvspNW1ds+Gnx1x7a7YoPGbmvIDto3X1bZsnX75FTRTs5Lans/Dke0NPDSJTSFOnK6cKuizDrzes1VBTGwqGROTsjjaCWnQ1LbNwNZqJZloj30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993435; c=relaxed/simple;
	bh=+wbt9HYrwKb1hGEQj88VTKcXRjJD0VJdt3AAdIFXDHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjFE4BMGs9GVZyJoag4yiQcF+OyoKVJ/hvRqHq7QPtXzxuaaO0FlB5+XWj1LQqRIS7ReXffKiLRBReYRsIEyQ1t5Hwsqiom0PusSf7HXLShlh51MbL6KhFQcOEgT+2eOTJJrnN7bUvqCv7FoDwX7RJtYbCp7jl08UVl3DVb/obA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJseQGVs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728993433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wUX33MfqTqiveIoRD7qXu/Q16SC0eDMuZFXHUiauSQ=;
	b=iJseQGVsB6CJwxKbZC2cD3EpNuKQ23LBremeJKmni5lz24GcWeafO9TUfDLbIPVFOk3Jzv
	EVw1Jw3LRSvHVc/I+/NJBcWBrdyZtTczaxTQ1OtNuuxdAYnJX9fPq6HIdQUyNi/+uBbjZD
	5I9rkz7+8FuRLwMcs8GbmEml/k1YsVE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-2CMndOiJMFWRWbEk9oG9Bw-1; Tue, 15 Oct 2024 07:57:12 -0400
X-MC-Unique: 2CMndOiJMFWRWbEk9oG9Bw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43057c9b32bso34138695e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728993431; x=1729598231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wUX33MfqTqiveIoRD7qXu/Q16SC0eDMuZFXHUiauSQ=;
        b=oDQpSBznbY7wM2czcBtWSuidmc2ax4tYwelT9SetPnkFyKAbH6PHASyed7xG35ftE6
         otB7f5j8buhvUyczzPQpSk2LIRhhHHnQwe3NSH31ZYBzHIVfnfgalxYucn2weZg3nrUk
         X4p9Pq2TqdHWwVQL+npUFxFaCcvETasv2reyrtn081xOrlfjukZWsBQoPpnlEZzG2Plw
         H5bfax7zwHz8vCd+u4NKhJqb3p+evckoZ59/kvBgV2NqOo9wzGZl+HiX2s8StrACZcze
         8QbxDMY+d1wISqrzrmY3ycNJPz9LJ8ysZV5BCs/MMp/F9sQbRRYiAmlMwB1eqr/ii/47
         LK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXlMZeB3OfHzW76jqWAgrG6UhWpHsK0MO77Qer92VgmaqeEZTm2NMmL9i8SkKMi6tprTUTtwx6NQ16VAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCNxqHX/4uuq6yiUVN9Do9VuN7WdPcGQTVxIHQgKc508tpNTnv
	oI8eHkhso0pveJ/eraIiQK9XdnFjswbPetVCLTKsb6hVHyoD+5tUau5xhfQLSm3O1GizlYDHrem
	rqAJF+YVuX7WQBehIfhSsPn6syWIQPmCXR45Hqkc3Uty4fvzHnkHTlirlyCB49A==
X-Received: by 2002:a05:600c:b8d:b0:42c:cd88:d0f4 with SMTP id 5b1f17b1804b1-4314a379091mr2264485e9.22.1728993430950;
        Tue, 15 Oct 2024 04:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaJdcOU0I1Tkr1eCvK/bDSFFWcsaC47MEVBpFH6HL5g1NpyHM6DXLpl2DzYAls6KyAVexj9Q==
X-Received: by 2002:a05:600c:b8d:b0:42c:cd88:d0f4 with SMTP id 5b1f17b1804b1-4314a379091mr2264085e9.22.1728993430455;
        Tue, 15 Oct 2024 04:57:10 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431487c194asm4869335e9.21.2024.10.15.04.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 04:57:09 -0700 (PDT)
Message-ID: <ee1205d6-3d6b-447f-991e-903936d45ac7@redhat.com>
Date: Tue, 15 Oct 2024 13:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010142139.3805375-1-shaojijie@huawei.com>
 <20241010142139.3805375-8-shaojijie@huawei.com>
 <2dd71e95-5fb2-42c9-aff0-3189e958730a@redhat.com>
 <44023e6f-5a52-4681-84fc-dd623cd9f09d@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <44023e6f-5a52-4681-84fc-dd623cd9f09d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 13:41, Jijie Shao wrote:
> on 2024/10/15 18:28, Paolo Abeni wrote:
>> Side note: the above always uses the maximum MTU for the packet size,
>> if the device supports jumbo frames (8Kb size packets), it will
>> produce quite bad layout for the incoming packets... Is the device
>> able to use multiple buffers for the incoming packets?
> 
> In fact, jumbo frames are not supported in device, and the maximum MTU is 4Kb.

FTR, even 4Kb is bad enough: tiny packets (tcp syn, UDP dns req) will 
use a truesize above 5K. You can get a much better the layout using 
copybreak.

Cheers,

Paolo


