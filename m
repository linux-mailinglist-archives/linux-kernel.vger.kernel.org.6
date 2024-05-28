Return-Path: <linux-kernel+bounces-191764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C18D13CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D961F21A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B844CE0F;
	Tue, 28 May 2024 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hQ1PMNSF"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE8433C7;
	Tue, 28 May 2024 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873654; cv=none; b=frfeTAHWNuoDMdFVyTCdiANkOIXOksxetwomvqENrBIfKQLJpmFcTM2THwNQtVZ9wlsW5/162SUF8kC+9d0NUyDmkLLEGUHbzjhsTFDQ6WN9/frpjHRe4ZJ8MV84GH7UkUbuCKXeWfc3TJpEyHwG2xEmBqgp/29Utut9VN+523U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873654; c=relaxed/simple;
	bh=XMjXFYGYZYyJZ1QS9Q1X+avQXh8W39MkVH5Ccwq4h8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jvUpGafoudO4whBnahv0DhqFitF46gusFdYVFSfIdQFci7Mc55ZFdCcoOn1RYhmvUB6gCbIlLjo3SNCNZZAGzeTX8uMLNuywYcutxRnAXgtTB90pMAe3ARUFiA3QaRnkKivkrvgM1eQ0479VGJqGWB5gAPOaGWp8VASipgk9LR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hQ1PMNSF; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S5KLBn100835;
	Tue, 28 May 2024 00:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716873621;
	bh=qRafMzqv/7S63YAkKvNtnJR/IIpYxpBpHvO4Tik9U/w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hQ1PMNSFtkozncI+bYZ3jIVztm9TZC5v4vX4a1XBPSz0KBiXFojN5490OVWHY40cD
	 KXJsP4PorAL83acoCKvOHHsvCIvjZMNJEtb397O/Q6OfnJIBp/LlExYR7W6IJXmJsX
	 GI8DyGuoaEuKACZ15/6QndAFKRBtheWaHvkKEWkQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S5KL0c013049
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 00:20:21 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 00:20:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 00:20:21 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S5KEd6054253;
	Tue, 28 May 2024 00:20:15 -0500
Message-ID: <fb29682b-c9fc-4c96-bb0c-3b842447595e@ti.com>
Date: Tue, 28 May 2024 10:50:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Simon Horman <horms@kernel.org>, Diogo Ivo
	<diogo.ivo@siemens.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Schnelle
	<schnelle@linux.ibm.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Roger
 Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20240527055300.154563-1-danishanwar@ti.com>
 <20240527055300.154563-3-danishanwar@ti.com>
 <1d0f9d73-89e7-413a-b1df-5ff56bc1cac4@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <1d0f9d73-89e7-413a-b1df-5ff56bc1cac4@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 28/05/24 3:48 am, Andrew Lunn wrote:
> On Mon, May 27, 2024 at 11:23:00AM +0530, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
>> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
>> configuration.
> 
> You only mention dual-emac here. What about when it is in switch mode
> and is using the other firmware?
> 

Both dual-emac and switch firmware supports taprio. The implementation
is same for both firmwares and there is no difference. The patch was
developed before switch support and that's why the commit message only
says dual-emac. I will update the commit message. Is there anything else
that needs to be changed in this seires? If there is, please let me
know. I will try to post it soon.

>     Andrew

-- 
Thanks and Regards,
Danish

