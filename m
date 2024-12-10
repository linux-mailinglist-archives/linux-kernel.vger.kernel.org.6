Return-Path: <linux-kernel+bounces-439119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B89EAB01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA281888631
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB223098B;
	Tue, 10 Dec 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3CNt1mlF"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824712DD88;
	Tue, 10 Dec 2024 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820554; cv=none; b=OfbYuOme+socbZMVPQ9bXmdC2eHgQ0eM8mt+RyMe0TD50J+aqSyUsycRsIyRuRMKVORRi3l3enimnqMcxZ4IZ8gzsxvSj7wxPv3i9plYqvFP1agCZJzUx2/0K8+pl1pAVZ/Py6s+lr/NCHIN6TqcXbT7dAY1/WJyxJUnwSsDiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820554; c=relaxed/simple;
	bh=l3s4QUmyaBf0y9iBGYr+ehke0uHdjlI4zsLQ7DoxMlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OTVAn9rOJGr81TpIWHiq6HfdhHsQ6/RKZ4bJLU6YGidcioEdLpwevsMCO6KFBSfZ9A4d9/OkdYOBW1m3/jqBN4+/mjmhAo4HdNZO0AYdEoKRXsasmC9jw3soBX38Ac7SCxEu9HoCEgNNt2JjDkbNjlLOAcW35yQGFLzL+3luBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3CNt1mlF; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA4YK5t005427;
	Tue, 10 Dec 2024 09:48:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	wTMNPKp9Javw7QGcnqA0o3v+GDe3cl06vv45gRAkrrk=; b=3CNt1mlFNJBQQrSq
	8C+DRiW76FX6sGs18gKLWQF0izrAHU8JA7XbqwBgVOr4A9s1lss0r9KQNNNaHoqF
	3cA3EZaWfbg0mIx5AiRT1Nf/waVQB036t5GEehmkhv2vuBAxBAXG3y42fKMUMXHr
	jVKGcOvObJZlxPVHtdBZVl/1xZbWvun7OrPAOgnMgmlXWvNDWXt1T1d3L28Gxb9e
	WYXUSwls9B2BRrNjgYED3Nqy3t0hjSpkrTncD79xb0vwpJj6m4Sd4Hu//wNbNc3x
	r6ydB+pJgc6ifcjzUBMSEJeTHJzSGVlpYGhyQ5/Yes9IiJ8AmevTSAvz+9OLUwEB
	ySLEtQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccc8uhgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:48:51 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D0F0140090;
	Tue, 10 Dec 2024 09:47:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EE05C22E20A;
	Tue, 10 Dec 2024 09:46:34 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Dec
 2024 09:46:34 +0100
Message-ID: <8cda7859-523c-4850-8b89-9d9c9bf07cb6@foss.st.com>
Date: Tue, 10 Dec 2024 09:46:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] ARM: dts: stm32: lxa-tac: fix gen{1,2} boards and add
 gen3 board
To: Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <kernel@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
References: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Marc

On 11/19/24 12:34, Marc Kleine-Budde wrote:
> Hello,
> 
> this series fixes some problems found in the lxa-tac generation 1 and
> 2 boards and add support for the generation 3 board. It's based on an
> STM32MP153c, while the generation 1 and 2 are based on the
> STM32MP157c.
> 
> regards,
> Marc
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Leonard Göhrs (6):
>        ARM: dts: stm32: lxa-tac: disable the real time clock
>        ARM: dts: stm32: lxa-tac: extend the alias table
>        ARM: dts: stm32: lxa-tac: adjust USB gadget fifo sizes for multi function
>        dt-bindings: arm: stm32: add compatible strings for Linux Automation LXA TAC gen 3
>        ARM: dts: stm32: lxa-tac: move adc and gpio{e,g} to gen{1,2} boards
>        ARM: dts: stm32: lxa-tac: Add support for generation 3 devices
> 
>   .../devicetree/bindings/arm/stm32/stm32.yaml       |   7 +
>   arch/arm/boot/dts/st/Makefile                      |   1 +
>   arch/arm/boot/dts/st/stm32mp153c-lxa-tac-gen3.dts  | 267 +++++++++++++++++++++
>   arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen1.dts  |  84 +++++++
>   arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen2.dts  |  84 +++++++
>   arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi      | 100 +-------
>   6 files changed, 455 insertions(+), 88 deletions(-)
> ---
> base-commit: b0191a5cbc222fc7af3f9511b44d1f330ef980e9
> change-id: 20241112-lxa-tac-gen3-8dbc3481ce7a
> 
> Best regards,

Series applied on stm32-next.

Thanks!
Alex

