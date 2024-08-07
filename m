Return-Path: <linux-kernel+bounces-278535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DD794B18B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2920B282965
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54DF146000;
	Wed,  7 Aug 2024 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="xMvaotYz"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3D84A51
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063409; cv=none; b=GRIWLvqf7Y1CBmBcJyJhpCYMsFrPfyFSK2xmSMKd1alXXbmm9hJ+ugq3ay0z0qV8R/psnaEzUHiy/dXs6fLdo9LIM2vODjveOhgD3GuVc+Jl23uN+oDq5Xx91RMot2RHGf6MzbSTZByp9Xb6CERg3lCqnHNBWUvkrCiK2tNAw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063409; c=relaxed/simple;
	bh=TUdmzF4Dz7pi04rHPVvMU10XnGbfRwdQqk8C4Hwo1mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knU5wT3fANNO0XrfLrKVN35fSL9Td0GiWttQ/1+pebn3L0HM0kUfsN5wSWzZz1vCqsAmTDWDPaULR6kQhbRMM9MLq1PqpuE4mMH6T8CkSKF/5FCBWY7AhdB/4sJPjzb8G01M3tbFC9sJhzlXN1NROW3GraABmUmTOwK/nsVhj/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=xMvaotYz; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id bnFUsIVKYVpzpbnVHse1wX; Wed, 07 Aug 2024 20:43:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id bnVGs0Pg9ks1PbnVGsgsz5; Wed, 07 Aug 2024 20:43:26 +0000
X-Authority-Analysis: v=2.4 cv=Ud+aS7SN c=1 sm=1 tr=0 ts=66b3dc6e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=OgNgpzeeqhBM75w_DO4A:9
 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8meIjU4p2sBqnFEM+5AxNwgHdl5Y20EE/5kwe2KxHEA=; b=xMvaotYzL+yiEzCGrCWW+wHEAc
	MXpPO0kieNg0j3f5pkp45kfgOiLw9RjCYMqVg0Ecck2PA7nJbSGlpWSC5XPH0j+ZdJC2tdoTUYLZl
	yqeobpBM5OyStjnukI5+06cRPv4qRaJWND2oLDK/Tg/t+uGIRUYgXWOvpBgU9DMgWN2oPzy+Ph3MZ
	vKrVOS3HFZhPxc+66Hx4qNdy7EthAzk7+0nNMQbj4Y52tUi9QLnGVK1PDPa5u8vVNCy79hTuPcVu4
	OJuXzx7tArnTFqDdmG6s2YzZWSaQXjYBZqKTl6rbaYYu17lsTylyzHjsL204zaR/4sLYbOJX81ueE
	ShACXJ3Q==;
Received: from [201.172.173.139] (port=48540 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sbnVF-004IhR-2N;
	Wed, 07 Aug 2024 15:43:25 -0500
Message-ID: <41c0cb7a-6fd4-4757-8d1a-7466fa268666@embeddedor.com>
Date: Wed, 7 Aug 2024 14:43:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] rpmsg: glink: Avoid -Wflex-array-member-not-at-end
 warnings
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgG8bbEzhmX5nGRE@neat> <202404290937.C22567C1@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202404290937.C22567C1@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sbnVF-004IhR-2N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:48540
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCyvG91yZVm1Ur/ULI1A5lid2uTQzagCXr6laoJ71GC9BWBqOy0DaxukLQoS9sraPBWQKPHfmhD/fDzOVuBDUrLesM11T9Is37Z+XTxGOYXYlMHyNLVw
 xj3HT6aOQ+Ob1sB8l87pDLHDukC9V+svtalauKNfl1JuO7wP3WxEvmGj7syPykQmR3LEuuJtXbkmypLYUv2Y/Y4SWnBal1Vyu+E5PsjVSe+B0tEua7YNGMR6


>> @@ -48,7 +51,7 @@ struct glink_msg {
>>   struct glink_defer_cmd {
>>   	struct list_head node;
>>   
>> -	struct glink_msg msg;
>> +	struct glink_msg_hdr msg;
>>   	u8 data[];
>>   };
> 
> Instead of this change (and the container_of() uses below), I think you
> can just simply drop "data" here. I don't see anything using it except
> the struct_size()s which can all change their "data" argument to
> msg.data. e.g.:

Whaa.. I'm sorry, I totally missed this response. I think I was traveling
a lot back then.

> 
> -       dcmd = kzalloc(struct_size(dcmd, data, extra), GFP_ATOMIC);
> +       dcmd = kzalloc(struct_size(dcmd, msg.data, extra), GFP_ATOMIC);
> 
> With those changed, I think this patch becomes more readable.

Yes; I think I can change the code like this. :)

Thanks!
--
Gustavo

