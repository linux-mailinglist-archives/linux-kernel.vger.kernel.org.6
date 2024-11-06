Return-Path: <linux-kernel+bounces-398391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352AF9BF0B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672881C232BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69A2038DE;
	Wed,  6 Nov 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uz7Wy61N"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F682202F8C;
	Wed,  6 Nov 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904624; cv=none; b=gx6z1hshf2Wcch/QCeb8+lPg3Xn9hRL7DN257eom9MP1SuOYoDD7TyHYxRYdY2tIW3z8E9tkidjQpLN46mLeX68pxiHeUNuEehsEXI/I8tiG0SS/+VV7NRi+1RvH57Zd6ZAw4TnI6R0NwUYrPfUbYXvjV5vveBqb0h7l5Ulw9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904624; c=relaxed/simple;
	bh=iDEwX+g4Ur3/zyz3crOZWXtwI9ucPQKHXj2tbC3hFEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DbMjK/DumuV/L0BQFYjcFVAL5BzjLCLtwt5KhoI9108hxse+d1qTfztN9IhbpQv7gzZ9dhD89QCFh1yeeSgbuYtn5/6p+58nOIlIqDfInICtO5C9+JuTcjCSIQIzKspEIGbJQ2v7h2lRedSJO8QuH9kV1BK+s0ymzFNjE/Rh+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uz7Wy61N; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A6EoGQR128579;
	Wed, 6 Nov 2024 08:50:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730904616;
	bh=efS7acrXh5DSwLU5SzsYhrAffKDNrSh6CsFPp+MqqO8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uz7Wy61NG52aUG4vO4CcVaa8rbIdwKQxfFw17U4hcchUIUS+SnjsA/oNgZQWJ7E/+
	 gaMcdGmDU7OA3eWc7xWSW9dOSvyNwRd4R38h3cvjAtLFK2paUAYiOsxAftbIfE5U/C
	 k7SUDZnXCzWW5+TghopuTYcov2Nhy2+YNCMUfWDo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A6EoGGs110252;
	Wed, 6 Nov 2024 08:50:16 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 08:50:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 08:50:15 -0600
Received: from [10.249.129.69] ([10.249.129.69])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A6EoBrI125773;
	Wed, 6 Nov 2024 08:50:12 -0600
Message-ID: <4891b955-b2aa-4590-9369-65a4b77ce0fa@ti.com>
Date: Wed, 6 Nov 2024 20:20:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Add dt overlay to disable
 icssg for Linux
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MD Danish Anwar
	<danishanwar@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
CC: <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kristo@kernel.org>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20241030114458.1358800-1-danishanwar@ti.com>
 <52f9bfc5-b2c5-47d0-b790-913dc8a8631e@linaro.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <52f9bfc5-b2c5-47d0-b790-913dc8a8631e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/6/2024 8:15 PM, Krzysztof Kozlowski wrote:
> On 30/10/2024 12:44, MD Danish Anwar wrote:
>> Add k3-am642-evm-icssg1-disable.dtso overlay file that disables
>> icssg1-eth from Linux so that icssg peripherals can be used by
>> RTOS or some other OS running on R5 core.
>>
> 
> I first approach privately but you deny, so let's make it public: this
> is based on some old kernel. Please don't. You need to rebase and work
> on recent kernel.
> 

I might have not re-based it on latest kernel before posting this. Will
make sure to re-base on the latest kernel.

> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Md Danish Anwar

