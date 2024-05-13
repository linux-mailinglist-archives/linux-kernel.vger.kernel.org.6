Return-Path: <linux-kernel+bounces-177422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C378C3E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892391C21233
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201BD14885F;
	Mon, 13 May 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5P9qNtXY"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCF219E7;
	Mon, 13 May 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593683; cv=none; b=KwZNWb60f3Jmz9FEKv8CjoEopY8qtb0No1NsprvgVO2lsCexQ6wD773MLcziyKZW7SJe1NGH1FV5iL+Ei0EJDBXcYMLZ+1sX8jB0XMf7XXF5sSe3vQyvQSesTVh4ZEw2Qtmz9yRf5t0dcbiThc2D1y/9fXHvx8BWdW0OCu8E4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593683; c=relaxed/simple;
	bh=n6JggoWLEqq+YAsDrsHI8PvikIbWLVL7xVOriXVwCWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uYDf5lVetj7fNBoY5hZ6hdWMjpVV5sEp/83uFvVL11SItSAgqAuMykgFHeLYXjlKsv1l2uKHa/ERkDaWmv7slj64A3BHNNIYr7oZCuCtV6XRcHiCOWYNQDGytYOhDr8oQp2DHXlzpCKw6V7T0kyrqkxzj8bG05P6t+bhWle8FOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5P9qNtXY; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D8M4ed006222;
	Mon, 13 May 2024 11:47:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=J91FaHv7K61YRR5CQcOUKWoI+9a2+43DfrKnnkSzsko=; b=5P
	9qNtXYKiATNn95JbF6kvCKlE+QV3Mg33LxIp5JqtfzCUYu3KpTMqUX/WOowDF3u2
	RtnszL+QGrK+loY2x+Sn2gxmBHce42OjdXaez4gdC7Cj4t19PHqCE6Mhk0jPNWsD
	Ln0Yjr7AS39pGE4S9Iw7O5zBw+jpEqSn5XYncaf5l7+OsyY4Umsh4iUmTUq7PN7L
	ekN1qGVFQQ7VGaQOFJ19wtkuKD5fm2rbeNGBP4Irp0OZEShxmiD4PLm1gR/kdXWN
	dP4HCuFZtG8SEHxURpT3BZIrOVFC2Zuc7wT2LFcckN3KzqUp5cCTP1VWIypUebO0
	0CF8EjrPfvgV10/FPUog==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y1yjb5fdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 11:47:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5156F40044;
	Mon, 13 May 2024 11:47:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6BE26216600;
	Mon, 13 May 2024 11:46:25 +0200 (CEST)
Received: from [10.48.87.205] (10.48.87.205) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 11:46:24 +0200
Message-ID: <f37d220b-1364-4c77-8cc5-169844d47c8f@foss.st.com>
Date: Mon, 13 May 2024 11:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre TORGUE
	<alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal Paillet <p.paillet@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240426183253.1360098-1-patrick.delaunay@foss.st.com>
 <20240426203245.v2.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <b0e794ad-f164-4304-b59e-736606bfe529@kernel.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <b0e794ad-f164-4304-b59e-736606bfe529@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_06,2024-05-10_02,2023-05-22_02


On 4/29/24 07:11, Krzysztof Kozlowski wrote:
> On 26/04/2024 20:32, Patrick Delaunay wrote:
>> Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>> Changes in v2:
>> - update for Rob review, only add compatible for STM32MP13 family
> Please start testing your patches BEFORE sending.


Sorry,

I don't know why I don't see the issue even if I executed

make dt_binding_check SCHEMA_FILES=stm32


I will sent a V3

and I update my way of working to avoid this error

=> clean the output biding directory before to execute again 
"dt_binding_check"


>
> Best regards,
> Krzysztof


Regards

Patrick


