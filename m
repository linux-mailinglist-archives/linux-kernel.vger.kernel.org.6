Return-Path: <linux-kernel+bounces-282673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F1694E73A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0032CB2484F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2C21537D6;
	Mon, 12 Aug 2024 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ikSFscPO"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01391152DF5;
	Mon, 12 Aug 2024 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445622; cv=none; b=sSTaiRLQ5xIakA67EGeDkLVEYOxHZ77sczV1AowFNn4bcuDoPAX9SZYjXW6wMyBwbE9kSP8Yb3oBMplfwDAWiAy9ogRjwOBsLJLw7fQ7dcMN1o5PQDSlQjiOUIcs+oVw2kL9Osh/Yf/+5e9n3LZDO6N90qGU5ghNV4K2F9raXek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445622; c=relaxed/simple;
	bh=NATnWUQWBSRGhjg8ncxKP6s/TcNs4Jved++zg33TLLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dq+DUatcGn+Vvm8K56/9VJE2a3RaLoz29gysp0flafvE4XcR6SWJ633GI4090BTkEsjjIkl8VJmHyRjb/eFJwEnbM4eWKiOnywaKZtQe/4jSnUhRUDnXzh3i+Mci+nWNK0mn4gkWuYUJXzDVlobjiY6aPRCWVY5GcIYQWhybjxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ikSFscPO; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47C6rWCi064172;
	Mon, 12 Aug 2024 01:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723445612;
	bh=NATnWUQWBSRGhjg8ncxKP6s/TcNs4Jved++zg33TLLI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ikSFscPOmh1jJrUUx+CHxV96c8/lxBoEoZkISNJonKXU9Q3F3ur3lqTcrZJDA5v94
	 xDWUnMfuPv/DsfxyFyctgOnn7b1c+2t98Wj4lgUQXwuVOK6yW3pnfCbE7uHbMOOui2
	 4EkfLaAX0ScOxRPmLAcsDdH6GkvonAenoifeqYFs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47C6rWws004625
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 01:53:32 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 01:53:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 01:53:32 -0500
Received: from [10.249.128.135] ([10.249.128.135])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47C6rQqg068667;
	Mon, 12 Aug 2024 01:53:27 -0500
Message-ID: <413dc315-e8d0-4971-af23-ba21833eb855@ti.com>
Date: Mon, 12 Aug 2024 12:23:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin
 mux for mmc1
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <sinthu.raja@ti.com>,
        <n-francis@ti.com>
References: <20240809072231.2931206-1-b-kapoor@ti.com>
 <20240812051058.ooq7uxd6xdbhgjln@uda0497581>
Content-Language: en-US
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240812051058.ooq7uxd6xdbhgjln@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

HI Manorit, please review again for the limitation you found in the v1.

Thanks and Regards

On 12/08/24 10:40, Manorit Chawdhry wrote:
> Hi Bhavya,
>
> On 12:52-20240809, Bhavya Kapoor wrote:
>> mmc1 is not functional and needs clock loopback so that it can
>> create sampling clock from this for high speed SDIO operations.
>> Thus, add clklb pin mux to get mmc1 working.
>>
>> Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board")
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>
> R-by already given in v1 [0]
>
> [0]: https://lore.kernel.org/all/20240808050914.4jleprwmlrtv4alb@uda0497581/
>
> Regards,
> Manorit

