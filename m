Return-Path: <linux-kernel+bounces-181321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7108C7A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C93F1F2208A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D234C8A;
	Thu, 16 May 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dM2SFDJz"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AF4A15;
	Thu, 16 May 2024 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877229; cv=none; b=NKt4pRh2kQwa4TIs7UfUL5dtukZxXL9jRQlJvQYXyhScclQ2KqLCCZf6RDATCsYtFd3T3zIbpE/zCU9F6cIFtgCN9pCWzQLZRwfnAjTMaOzbUA+NnzoeHCOacBPEYfXrS9kQGuggvN/Jqpfe89ek31Mc1cnQCnVKzkN/wbQfvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877229; c=relaxed/simple;
	bh=jc+p0uqi6u3V3KnhrnLdMf7Zn9A5zPWqZdmw9MFR0Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A3aacuBkb5xf8aq3vol1itzlhen4boskK3z8kzRyWX6YkdEy7+AdFkzRlpYkU85zAfcZDAmE8BzhQCad4pAg60RwORI5kFypLaAsXfPM1jibznR8rdhQuJwhyt3WgGH6FLMOdj7BQSvf63CZqP8MMWcEZwsavvFDQux6hudYQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dM2SFDJz; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GDhYe5005402;
	Thu, 16 May 2024 18:33:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=2pRzvEKsr2u9WywjaryEnBZCx349KN6Wpc4RHZd+rck=; b=dM
	2SFDJzSYm9AtY55y2HwV2Jyh8tSKydE5jusko5MbfwttReZjEn3YHFd0zMgY6lso
	aEk774snO5txwIxya4PGQGt+fuci8ATwfzLqhyI/SE0iwLLTI3QEP0x686iIuE0p
	yls1WTxNB6EaUDH6CvG0Wst0kOvj55xLoR4yZZemdhAXyIPoCS0SCbzP2Sa6NzEO
	DEQi6AKSAP83EEPGS+sUrFGdfDqdRrfk5JCl/EoXB1PhBEyoHlBjJoYuFSgu+iLN
	q27l4PC/TM7XcBuykhDDbui/wxORAI6++7wO21esoE1U5MHvwxW3Ezrkq3EXJMHz
	eJ0ta5KxTtYs+IhVaoDg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y4syme8rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 18:33:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E36A340045;
	Thu, 16 May 2024 18:33:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E8359226FC6;
	Thu, 16 May 2024 18:32:17 +0200 (CEST)
Received: from [10.48.87.205] (10.48.87.205) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 18:32:17 +0200
Message-ID: <2e5ad8c3-4889-4062-964b-acf4ec75986c@foss.st.com>
Date: Thu, 16 May 2024 18:32:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
To: Conor Dooley <conor@kernel.org>, Marek Vasut <marex@denx.de>
CC: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal
 Paillet <p.paillet@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
 <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>
 <20240513-stabilize-proofread-81f0f9ee38b9@spud>
 <d73d4435-75d6-4cea-b38e-07c7ceae3980@foss.st.com>
 <20240514-entryway-idealize-fcd5ed0e1de7@spud>
 <0c97408c-422d-46b3-8017-da9ebb0767e1@foss.st.com>
 <20240515-monsoon-starfish-0dc59707e843@spud>
 <9de93cbb-5868-473e-8b32-a6b6f50e128e@denx.de>
 <20240515-edginess-evacuee-356bd6dd1dfa@spud>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240515-edginess-evacuee-356bd6dd1dfa@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02

Hi,

On 5/15/24 18:15, Conor Dooley wrote:
> On Wed, May 15, 2024 at 05:37:49PM +0200, Marek Vasut wrote:
>> On 5/15/24 5:35 PM, Conor Dooley wrote:
>>> On Wed, May 15, 2024 at 04:33:22PM +0200, Patrick DELAUNAY wrote:
>>>> with
>>>>
>>>>     compatible:
>>>>       oneOf:
>>>>           - items:
>>>>              - const: st,stm32mp1,pwr-reg
>>>>           - items:
>>>>              - const: st,stm32mp13-pwr-reg
>>>>              - const: st,stm32mp1,pwr-reg
>>> Other than the extra ,s this looks okay, thanks.
>> I think the extra ,s are actually correct, those are the ones from the
>> original compatible which had TWO ,s (it does look a bit unusual).
> Oh my bad then.


Ok, I prepare a V4 with fallback


and comma in compatible "st,stm32mp1,pwr-reg" was clearly an error

but it is too late to change it, see [1]

[1] ARM: st: use a correct pwr compatible for stm32mp15

https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=847733&state=* 


regards

Patrick



