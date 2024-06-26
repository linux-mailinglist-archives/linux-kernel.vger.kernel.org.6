Return-Path: <linux-kernel+bounces-230355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDEC917BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956582883EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6494B168498;
	Wed, 26 Jun 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v8ku+4nV"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF413AD11;
	Wed, 26 Jun 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392627; cv=none; b=Uu0k6PQmv3he+RlgGWKeBLk3KEcCzLfJBUW3tUCUesg4Bl7AoxWFuPx+6GFUzhMioebrbZEDX4i8N9f15LzeELz2jKuoqBbtIvMY2cdhicFRMTr0lqy8LYuuf+qgT+smQMslA+rxFQJl9CY2aoHpCCZ/gQ5v8v8cv+B4QPgmw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392627; c=relaxed/simple;
	bh=k3PLt6Qap4FdlP7ECaBc49dWOBbtLC1oMmAgYSuV5nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iQgIdu9n5ELB3t0j+51RurVw5oPW+YMPzBWaCFtThroFziu27AEIKxUfBVtbZaP1HhD6cWUvzT/ak/L0hBlRLStadUs0BQ+kzhvVK/tzNHjWT0D7ZozHDJNfxVXcWrfvQ4Gpho4RMX2q+AfUws/+jpm5+QY6L0BTjkBeioJmViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v8ku+4nV; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45Q93dwc073472;
	Wed, 26 Jun 2024 04:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719392619;
	bh=cWeEf3KLTcWgvTlC83TSV46FqXXPxQmL+5Tu0fty2A0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=v8ku+4nVPlqqqentLXpzhNljpkBOFeZX8C3SdvVDc+bTQaGLkQLx2enM6+pfmMcoy
	 CqmInFiriI+0OAbqAPO2quqMg5WsdfiSDH5ZAzLdswaSleVN9F9Bb+sP8DXf9ztnkn
	 3aR8Msc83/k1iadUGfQL4y1cXQfn5zB4YoCeZs3I=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45Q93dsu023463
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 04:03:39 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 04:03:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 04:03:38 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45Q93YEo120771;
	Wed, 26 Jun 2024 04:03:35 -0500
Message-ID: <c895f7f0-17fc-47b3-9f63-78174a5d2a86@ti.com>
Date: Wed, 26 Jun 2024 14:33:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add documentation for PA_STATS and MAINTAINERS
 entry for ti,pruss.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>, Suman Anna <s-anna@ti.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth
 Menon <nm@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240625153319.795665-1-danishanwar@ti.com>
 <20240625153319.795665-4-danishanwar@ti.com>
 <c4ee50a8-2fdd-4aa9-9d88-ec3f3ea52633@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <c4ee50a8-2fdd-4aa9-9d88-ec3f3ea52633@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 26/06/24 2:29 pm, Krzysztof Kozlowski wrote:
> On 25/06/2024 17:33, MD Danish Anwar wrote:
>> Hi,
>>
>> This series adds documentation for PA_STATS in dt-bindings file ti,pruss.yaml.
>> This bindings file doesn't have a MAINTAINERS entry. This series add the
>> MAINTAINERS entry for this file as well.
>>
>> Changes since v2:
>> *) Added RB tag of Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> to
>>    patch 2/2
>> *) Added patch 1/2 to the series as the binding file is orphan.
>>
>> v2 https://lore.kernel.org/all/20240529115149.630273-1-danishanwar@ti.com/
> 
> That's some duplicated posting.
> 
> Why you just can't use b4?
> 

My bad. The email got sent twice. Will keep this in mind.

> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Danish

