Return-Path: <linux-kernel+bounces-534182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F22ACA463E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1F1171166
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0B92222D0;
	Wed, 26 Feb 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j5dP5LnM"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DF221732;
	Wed, 26 Feb 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581924; cv=none; b=djP0Kxxd+Jv1CF7rve/jdYMLGteYZ0QHfZJCMIBIXCFq/wpp0fj7FDOtOOc2WqowQtVWuT/z96/aK3pURkeno5qqjoyFU9xeU3CUSf28FjI+Y7vvBn6zVIMg2G0orXlTMAARt7kydg+uTtdgfEmBSP09W/6gSB6NKxPeIhNhtnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581924; c=relaxed/simple;
	bh=OHpRm29ejlVV/G0aHNonMP2Y2YbznVl5ftbP8prKd7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vt+PdWt1ggqTSgf0YhN5D6b4xBzlTmFiucjupUThl4ixeqKMLT8ZThQrwPPsIGtqjg8ONb31ili2S5oYkqrFkDfx4szB8aMEYUmetwHD6GAyhyTzjAG1f9HcSWhWa0G3On8K7dEIGrBuRzBeipk+IL6wGTCdrbyvJGP3ThGwJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j5dP5LnM; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QEwTxr1494032
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 08:58:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740581909;
	bh=Wl/RXJwnlW0HcAbSZbnsW1EyC94rw8Ynnk5XKByQikc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=j5dP5LnMQM7gc5c8CJtu7tCaBhh1NK0I534IFjJzWTP6NACP1kZWlqJcVMdi6jNOF
	 7D/cRRUf7FqYAZBFLSSafVJGf8rZWYKi4ZzhMO8MclirPHW8QFErQPS2B+3y3bByUL
	 FM3nOoMh7ggxuMDzTOvDaJG+r6rE6wtjdHdbzczg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QEwSCI100560
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 08:58:29 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 08:58:28 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 08:58:28 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QEwSY6121157;
	Wed, 26 Feb 2025 08:58:28 -0600
Message-ID: <8cf95899-bebb-46a2-843e-debdfb5079ff@ti.com>
Date: Wed, 26 Feb 2025 08:58:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am62a/p: Add r5fss nodes
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
References: <20250122-topic-dt-updates-am62-wkup-v6-13-v1-0-f74835b91da9@baylibre.com>
 <c81ccd05-4fb7-4ec0-8cc0-c59ac4dff91e@ti.com>
 <qlqxmqluqrw36bkjaa7efcsk6cinyr2rxvznfhz6dopeu67dsf@w4lkuq65uwno>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <qlqxmqluqrw36bkjaa7efcsk6cinyr2rxvznfhz6dopeu67dsf@w4lkuq65uwno>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Markus,

On 2/25/25 4:28 AM, Markus Schneider-Pargmann wrote:
> Hi Judith,
> 
> On Mon, Feb 24, 2025 at 09:06:56AM -0600, Judith Mendez wrote:
>> Hi Markus,
>>
>> On 1/22/25 3:54 AM, Markus Schneider-Pargmann wrote:
>>> Hi,
>>>
>>> am62p-wakeup already has the r5fss node defined, but it is currently
>>> missing from the am62a-wakeup domain in the devicetree. This is added as
>>> part of the series.
>>>
>>> For am62a and am62p starter kit boards the r5fss memory region is added
>>> and referenced for the r5fss core 0 node.
>>
>>
>> This has already been sent here:
>> https://lore.kernel.org/linux-devicetree/20250210221530.1234009-1-jm@ti.com/
> 
> yes, I saw that recently. Could you please cc me on the next version?
> 

Sure no problem. (:

> Thanks!
> 
> Best
> Markus


