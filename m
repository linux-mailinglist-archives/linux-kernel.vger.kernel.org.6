Return-Path: <linux-kernel+bounces-349011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622FF98EF51
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E81F224E2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691D186E40;
	Thu,  3 Oct 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="szACed/e"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E181865EB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959091; cv=none; b=Irh2cPMsmGz/s+QoKpTLaaHz3rnXK5WEzd0ZJHRkT4TeO+11cC07iR4f4L6zy/KSMMu+Y9qNzXzJsbAJhY77Q+4NIuB8JXhwIDC1gFPEHTsWUVNWAarkkpQnxzyUDSxldxa54icjKUzamBvy6/OAf5d/zYbTEYjKYbhrUUXmZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959091; c=relaxed/simple;
	bh=vb8Coua1UV7GIuV7O/n3TRGJWVH8YgKLKwGrnG3H89w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L74fA930q9Wwq8+lhLKMLLaV2Q6MTdrVFg8vbDJPJD2avg1lD/K5u/jQ086qkJY04NR3w8DVfDmPF6idrweJnU5Zp3de49cMdB6+WvYVa6u1nYhG0KNG1gxY7z44Q3nl7+aS0nFyLr3j6jkWQntJAV7ifPhT9KMHeQZrHQkznp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=szACed/e; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727959085; x=1730551085;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vb8Coua1UV7GIuV7O/n3TRGJWVH8YgKLKwGrnG3H89w=;
	b=szACed/eDxpSKUZNKe4xH8xNKMd61xpQ5bX1fOgWxdN23j8Vb5ZRFj6gvoBdRg1C
	kKth0kcePnbhe9qHzjV46Liae41fpXeN+oUbB+k/7rbDHzxvkAWAui7cJXei84aM
	RkJaBdIiavqlRQbTbyeeuD0tDeXXInA5ykv7wQQKOvc=;
X-AuditID: ac14000a-4577e70000004e2a-70-66fe902d0ef4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 39.C5.20010.D209EF66; Thu,  3 Oct 2024 14:38:05 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 3 Oct 2024
 14:38:03 +0200
Message-ID: <1eaaeaab-e606-419c-be69-79d171518e33@phytec.de>
Date: Thu, 3 Oct 2024 14:38:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-phyboard-lyra: Drop unnecessary
 McASP AFIFOs
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <j-luthra@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20241002224754.2917895-1-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241002224754.2917895-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWyRpKBR1d3wr80g/0/uCzW7D3HZDH/yDlW
	i71dj9gsln+ezW7xctY9NotNj6+xWlzeNYfN4s2Ps0wWHxo3s1n837OD3aL7nbrF/7Mf2B14
	PDat6mTz2Lyk3qO/u4XV48/Fd6wex29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK2NjdzdbwVL2
	iisT2lgbGH+ydjFyckgImEgsmPqZrYuRi0NIYAmTxJ8HJ1hAEkICdxglrjcGg9i8AjYSN/q+
	MIPYLAIqEut+9bNDxAUlTs58AlYvKiAvcf/WDKA4B4ewQIzE+xUsIDNFBHYwStx92scI4jAL
	tDFKPHl4gBligY3Ek2MNYFcwC4hL3HoynwnEZhNQl7iz4RtYnFPAVuLU3xVMEDUWEovfHGSH
	sOUltr+dAzVHXuLFpeUsEN/IS0w795oZwg6V2PplO9MERuFZSG6dhWTdLCRjZyEZu4CRZRWj
	UG5mcnZqUWa2XkFGZUlqsl5K6iZGUOSJMHDtYOyb43GIkYmD8RCjBAezkgjvvO1/04R4UxIr
	q1KL8uOLSnNSiw8xSnOwKInzru4IThUSSE8sSc1OTS1ILYLJMnFwSjUwMq/gf37neV5i4uxq
	25/dwjuXiRdq6DzsuVGTk717Q/Rfwz2rm66ts42b3aDzRMXPJjP9/b/eJ/dqnqxINpJZc8fX
	6lr79w/tqs/L4ld9XvMlMW7GewfdnS3BIbcdQs5rsX1Rztlo/ky42GPJremzZiVqLLE506fr
	ZXjmickj2a/in/3ONsksVWIpzkg01GIuKk4EAJ+RVHCqAgAA



Am 03.10.24 um 00:47 schrieb Nathan Morrisson:
> Drop the McASP AFIFOs for better audio latency. This adds back a
> change that was lost while refactoring the device tree.
> 
> Fixes: 554dd562a5f2 ("arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Drop McASP AFIFOs")
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
> index e4633af87eb9..d6ce53c6d748 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
> @@ -433,8 +433,6 @@ &mcasp2 {
>   			0 0 0 0
>   			0 0 0 0
>   	>;
> -	tx-num-evt = <32>;
> -	rx-num-evt = <32>;
>   	status = "okay";
>   };
>   


