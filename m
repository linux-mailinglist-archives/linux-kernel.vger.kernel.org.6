Return-Path: <linux-kernel+bounces-533568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D07A45C23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A5F1741FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690782459D4;
	Wed, 26 Feb 2025 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DgwmjuI0"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17CC20E020
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567018; cv=none; b=MejgmXZTJOvP2ySxsjLNpObTh4MXNW8Grw1J8MsahRebUIwLNZJ21YkwKPdiTvNuekOxKDh8xjlRrhv+aXVbrOykMfX0zejkQ0ypOXGy93O8CDH+EDqTkAxCcMEdEmvV+2UIXt02adO2EJHbDSMw170ycqw7Fyuq+yrbZsXS3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567018; c=relaxed/simple;
	bh=uoDYynkwYtA/Oca3dwmaRmhdpYbBmATAd+rl5/doFAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TbN6YgtABgHorTK6I1rfhxD20d5kTlS4uhXF6JLQQ7Y0n5DQDfM6fibG9f2vLzQuASEeKZJMX3aXYVa2Bmkir7Vaidl5PkeeBavfvKU1zYmhEh6rDJvEHo30N50xacRrVRw9jMzhAqNmzMEHY2Dz8ffR2Q6Bqz3zItVIRCENvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DgwmjuI0; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QAisqA1525409
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 04:44:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740566694;
	bh=jo/UvzfaVefTj5QmF17mHt05v9bWd2UKSSqwvyDmE90=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DgwmjuI0Ej3hhm2PlZOGXrSLhaq4K4zanEVbUbgWhElgK0fZyzqlbyTC49ySsE9rY
	 ptWs86AY+0SQkS+yLYrVgRm378slc6VceFMXyhO29CqH2xyifLSIdCIt07uwFcvQju
	 k4YxXZ/8NUnJJfzgJKe+wQSRiU+LC0Lae4xWNCKs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QAishd024132
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 04:44:54 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 04:44:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 04:44:54 -0600
Received: from [172.24.18.117] (lt9560gk3.dhcp.ti.com [172.24.18.117])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QAipZ4106894;
	Wed, 26 Feb 2025 04:44:51 -0600
Message-ID: <0d33dea6-c021-4f2a-bb3f-92efd6eebd18@ti.com>
Date: Wed, 26 Feb 2025 16:14:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: Enable HSR driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann
	<arnd@arndb.de>
CC: <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, "Anwar, Md Danish" <danishanwar@ti.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
 <686f583d-6bf4-4486-b9e4-20c1e268eda6@ti.com>
 <d4954e5e-e51f-41c0-bca5-6e14b4640022@linaro.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <d4954e5e-e51f-41c0-bca5-6e14b4640022@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/26/2025 1:35 PM, Krzysztof Kozlowski wrote:
> On 26/02/2025 07: 18, Malladi, Meghana wrote: > Hi all, > > Apologies in 
> case you are receiving this email for the second time. > Any reason why 
> this patch hasn't been merged yet. Other than re-basing > this to the 
> tip, anything
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> updgnZav1ue7gKXOnHOpH5hg8gLmw9Osqsqh- 
> KTLRTnBEurV_VetrG7mzU898vB_5xFrYgbRkkuuFMBobM-uhFAmUgccRSk$>
> ZjQcmQRYFpfptBannerEnd
> 
> On 26/02/2025 07:18, Malladi, Meghana wrote:
>> Hi all,
>> 
>> Apologies in case you are receiving this email for the second time.
>> Any reason why this patch hasn't been merged yet. Other than re-basing 
>> this to the tip, anything else which needs to be addressed to get this 
>> merged?
> 
> I don't think you sent it to your platform maintainers, so no one would
> apply it. Usually people ignore emails they did not receive, although I
> am here an exception tracking missing-DT-patchwork things... :)
> 
> Best regards,
> Krzysztof
> 

Hello Arnd/Krzysztof,

Thank you for the replies :)
Was having ambiguity since this is not TI specific change. Wanted to 
confirm before re-posting. Will post v2 patch including TI platform 
maintainers.

Regards,
Meghana

