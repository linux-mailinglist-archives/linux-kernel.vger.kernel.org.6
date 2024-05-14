Return-Path: <linux-kernel+bounces-178807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80FB8C57EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6448C281EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCE145326;
	Tue, 14 May 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N2P4OVPF"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA1144D1C;
	Tue, 14 May 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696985; cv=none; b=aW4V5lGcqmH+RZJC7cPnkdvBaIrPnwsl3AEZc+HFZGHL9Qe1lZlOxPmN7CqvrhDcpTYU5atdlF+LHtWh8cA/R+0OhbTMHP68D0YI89+pCyJnGlv+4FWRfLKkzhaUYh6ZzUoU1RSresjFaSDvlPuZWIu/EpOXkpAVjWGkI1eINbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696985; c=relaxed/simple;
	bh=dwNVR7ca4QlNEsSuPL8Sp2uaU6DNnzNYe3WImPBpFsA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=YDMG6FkD0viNvVPNR9E4a9+WKq2cae1F4CexmxWqVNbKlzJGvpPaF6+1Ij/nrDVAKSLOZjaxJruxPns7kM+0rBjsRm9+15bTbOs0tDh+C34RfskMv4SlL3xQ7yAKRVpKoflnSShcjhmGmVFh/EfPz9VOBN+TY4YdgltuS8qkw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N2P4OVPF; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44EETT5C017469;
	Tue, 14 May 2024 09:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715696969;
	bh=J+2Dx63m3rl/avn6WlrRF0ewymLz6wPP3CDkECjxYqo=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=N2P4OVPFpRWLPxmxd6L2IzL3sr2/+S0SoG5DtOlW+KgBhsj2z7rVmvjHp+9lRF01u
	 sPe+mymPxjfx9o1qz9bOSCG0kK5ku+EQvqEklnguu2z1yUqBwajSa+aqsUCKBAjxb3
	 cU2Wu/AhVPVlofozCvNXwiJA0rztOCryB/goprHE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44EETT57061774
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 09:29:29 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 09:29:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 09:29:29 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44EETNm1001116;
	Tue, 14 May 2024 09:29:24 -0500
Message-ID: <0eee0424-f177-808f-3a86-499443155ddb@ti.com>
Date: Tue, 14 May 2024 19:59:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of
 global CMA
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        "Raghavendra,
 Vignesh" <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <praneeth@ti.com>, <j-choudhary@ti.com>, <gregkh@linuxfoundation.org>,
        Brandon <b-brnich@ti.com>, "Pothukuchi, Vijay" <vijayp@ti.com>,
        "Etheridge,
 Darren" <detheridge@ti.com>
References: <20230803111455.811339-1-devarsht@ti.com>
 <20230805193355.o657pwbq2w3tciui@vehicular>
 <9b61e8a0-fec0-b33f-259c-c744aa5a88b9@ti.com>
 <18bb47b8-c441-00b1-7ac7-f9038dffedc4@ti.com>
 <d2c6c120-5d3b-4975-5972-155343c1c0ca@ti.com>
In-Reply-To: <d2c6c120-5d3b-4975-5972-155343c1c0ca@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew, Vignesh, Nishanth,

On 08/08/23 13:44, Devarsh Thakkar wrote:
[...]
>>>>> Reserve 128MiB of global CMA which is also marked as re-usable
>>>>> so that OS can also use the same if peripheral drivers are not using the
>>>>> same.
>>>>>

I wanted to re-initiate discussion on this. Per discussion with few of the
maintainers in OSS 2023 Summit, the suggestion was either to have MMU in the
devices or use the CMA region as done with this patch.
There was not much traction for the idea/suggestion to have some updates in
CMA API to dynamically increase the CMA region per the requirement (for e.g.
move the MIGRATE_MOVABLE pages to CMA area dynamically). Also I see some
efforts in the past made on that direction for introducing CMA_AGGRESSIVE
Kconfig to allocate from ZONE_MOVEABLE but were not accepted [1] and
nevertheless it still requires CMA region to be available to begin with and
only gives a bit of extra margin for the CMA.

My vote is still to use global cma region with re-usable flag (as done with
this patch) and 128 MiB is well estimated per the use-cases AM62x EVM is meant
to cater (the vendor specific kernel has been using it) and is very much
needed to provided out-of-box experience as otherwise basic display and camera
use-cases don't work out-of-box. Besides I see many other boards [presumably
mmu-less] using a similar approach :

     $git grep linux,cma-default arch/ | wc
     36      72    2538


Kindly let us know your opinion on this if we are aligned to proceed with this
approach or not.

[1]:
https://lore.kernel.org/all/20141107070655.GA3486@bbox/
https://linux-mm.kvack.narkive.com/LCGSAqAp/patch-0-4-cma-aggressive-make-cma-memory-be-more-aggressive-about-allocation


Regards
Devarsh

