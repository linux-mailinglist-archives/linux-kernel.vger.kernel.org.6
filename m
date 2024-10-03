Return-Path: <linux-kernel+bounces-349452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9041498F66E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EA5283ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9641AC444;
	Thu,  3 Oct 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZX8ulK4o"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76B6EB4A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981062; cv=none; b=NJCZN0z+yTdXwT8mVDSwDGVrgomwYCeUywokhbNEwjbRm26P8F/rfmJVC/cigHKUnXi3KYu7DQ4VjTu1VZj/Fq8Zs4B7V26DS6DGkmZTh0xaL73eWVW3iZh8uQHz6VMDkF4QJvT2rlRCQOw2EOpcYSLkq3Fo3aQGF5CFt2LQ4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981062; c=relaxed/simple;
	bh=InjBtbOlAG4Mtx9LXGAb/6ABIpvoMW8OIGuGpjN3DLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wl98V1lx5uc9CuVr+AL/swDZ8mTT3RaEHllfAF5/ew2x6EYhIyxSr08xhLMnlDNIKdSBIK0yOXJcWWTe4zS8FUfKLtK4GaXXtBL+LN+bOrsDHTvAI8S3qW4XbNXBb+OJBzcJq25+dlIRvPFoPulsK6O9Ty7chZh29F6ayS1Z8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ZX8ulK4o; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id vrrns591xVpzpwQo9sZq3W; Thu, 03 Oct 2024 18:44:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id wQo8sOnPcWvXpwQo8s3jYa; Thu, 03 Oct 2024 18:44:13 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=66fee5fd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=3ekAXG7pR4iCrxVh9jYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eG7vV+8gxRB0uOsVEnr4E3TpXwHK9kPrxrRSBnOYWJo=; b=ZX8ulK4olZsrBtpjFw0YOFlYQF
	KwzCQxQ/jBPwZjQfqN/k6BSQ15Xe5fNh0L6SW7Kjqv9vrOqQ4C8VN2odtyqU+eUcGp+QvMaxK+i5t
	5v61MJC8PGxcoQXTOvOu7yu0lr/NDyLiXzNb8mJkUz5PELJ+pjh2EMOGprQ0S/34K1gJmKq2972lw
	saF8/LzyNF0bmDjS2WYftdRtmo/W3/h1cfFD1oY0W+MYtqMdH4jCEwHsgfuPsDbNj6LRnNdaNqAML
	fkhpL/M/hFOy6BkjQwFhLgFkiYxJmmXTfkDXMblfRrekZxwBhE5flkCOQFwzeRWDxc3ADytbQQNrz
	tfI9jFmQ==;
Received: from [201.172.174.147] (port=46111 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1swQo7-00192x-2f;
	Thu, 03 Oct 2024 13:44:11 -0500
Message-ID: <45560975-7215-4205-8d3b-a01009c9b4f5@embeddedor.com>
Date: Thu, 3 Oct 2024 12:44:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZsZLFS1CsHkKjw+C@elsanto>
 <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com>
 <30530165-0ea9-4f02-9d8c-e8abc9eda5a7@kernel.org>
 <035ae74b-5df5-493f-9835-02c1c30ccfcc@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <035ae74b-5df5-493f-9835-02c1c30ccfcc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1swQo7-00192x-2f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.174.147]:46111
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLxAzCungF/XDCP94yFFbSvccrgME0zzPZJp/v2TESFI6pyDj87OKmx5NE4cf7vg6HwYEcvHMOO0Rg6klQS0hgNzH1b9+Kv3NjbXOG0OD4X73q0+pAhP
 eIa2Mz0/e/BleA+vQb5kdRqpARoc0ge4coA3fP3HjD9aXs5TgkbAI7Xf/ceNgQJoIbq5YQAR0NRKAznmS1su38yfzkuXQKp0If5vBiS1XwpU6t2KMdy6QcV7



On 03/10/24 12:36, Danilo Krummrich wrote:
> On 9/13/24 12:23 PM, Danilo Krummrich wrote:
>> Hi,
>>
>> On 9/13/24 10:09 AM, Gustavo A. R. Silva wrote:
>>> Hi all,
>>>
>>> Friendly ping: who can take this, please? 🙂
>>
>> Usually, that's me. But I thought you might want to send a v2 based on Kees'
>> comments?
> 
> Do you plan to follow up on this? I'd prefer if we could get rid of the open-
> coded "17". So, maybe just go with the define until we have something like
> STACK_FLEX_COUNT()?

Do you mean the following define...?

nv50_hdmi_enable(...)
{
...
#define data_len    17
     DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, data_len);
...rest of function...
#undef data_len
}

Thanks
--
Gustavo

