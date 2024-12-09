Return-Path: <linux-kernel+bounces-437957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2971C9E9AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DF118874F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8951369B4;
	Mon,  9 Dec 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KMjxD+Gr"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3810233139;
	Mon,  9 Dec 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759817; cv=none; b=mZX0I1Fe71Orx3tsYNrEusjCGjPAdkU/YH4Ma+ihBBshBGq/k/HEASMkOyVmfSm+OMpj5gaT9Y96QcMA0rmHfKQJi8XEjY73Fjl42NKcw/dOWg/UkZ5VO0FCvt+UKCJqWA5CSKETlQtwupE39+Xba8VJI7cFQays2bNAwCkBfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759817; c=relaxed/simple;
	bh=A6wM4VWA9krXQgwIlMNaGA/cVuxsmxetqtEokNetuH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dbkU6uIpJrfafpHHIUnbzoKp2iG4VSKKXMzG2JeyffC+Zp5qH8/JuAFZw++TBOjhZ+TFWYYvQVZc3OE4pCnlFsN813THMTTYIbFXOsRrYLxyLf6K8bSyZBjoCct2OQGCQs7F3auKY9iASuB7xc+e1b0U5gCOZLarxv6Ofadl9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KMjxD+Gr; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9E3IDX013783;
	Mon, 9 Dec 2024 16:56:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6q/GQ8e/5AdWnp2sT3tKqIF8BpsMpOI2KwP+899KLBQ=; b=KMjxD+Gr23lmaDkx
	rxl8Eb/Gr+eMbb6QYtDzJgYhY1oeHFkm1S2UzRgUT9nIwlGldeLVi+PYMgXkBKNn
	AvmJHJHDlWQUX5+K/iY6G3NtYLFqUvKP+HKCeqfGWS5CqiIX73wb1+kluthGzjwt
	XNrR/Vzw+uhrnzFqaZjySTFLPNJOT+x3iR7acZhprr5tRo6JAu8PmGkCjhXTuuzx
	XaMwIxR7uJ5RFQzBJgiedmNXqvcz0V9KfpnnDFH2n2sRdf2gKvKtpHaMYhVSxoYo
	6rCqcdZ7bvfNmSS6DOeMGuHs86grpt3LaALNmfKEGQXglirqMt9BPmGD2RPrfGgq
	vHqoeg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccnm0w6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 16:56:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 68A0D4004B;
	Mon,  9 Dec 2024 16:55:25 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 074CA28D444;
	Mon,  9 Dec 2024 16:54:39 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Dec
 2024 16:54:38 +0100
Message-ID: <feca2ea8-38f9-41c8-b4c4-1a6cbeec73a4@foss.st.com>
Date: Mon, 9 Dec 2024 16:54:20 +0100
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
 <20241209-magenta-boobook-of-respect-14ec68-mkl@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20241209-magenta-boobook-of-respect-14ec68-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Marc

On 12/9/24 15:30, Marc Kleine-Budde wrote:
> Hello Alexandre,
> 
> On 19.11.2024 12:34:57, Marc Kleine-Budde wrote:
>> Hello,
>>
>> this series fixes some problems found in the lxa-tac generation 1 and
>> 2 boards and add support for the generation 3 board. It's based on an
>> STM32MP153c, while the generation 1 and 2 are based on the
>> STM32MP157c.
>>
>> regards,
>> Marc
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Leonard Göhrs (6):
>>        ARM: dts: stm32: lxa-tac: disable the real time clock
>>        ARM: dts: stm32: lxa-tac: extend the alias table
>>        ARM: dts: stm32: lxa-tac: adjust USB gadget fifo sizes for multi function
>>        dt-bindings: arm: stm32: add compatible strings for Linux Automation LXA TAC gen 3
>>        ARM: dts: stm32: lxa-tac: move adc and gpio{e,g} to gen{1,2} boards
>>        ARM: dts: stm32: lxa-tac: Add support for generation 3 devices
>>
>>   .../devicetree/bindings/arm/stm32/stm32.yaml       |   7 +
>>   arch/arm/boot/dts/st/Makefile                      |   1 +
>>   arch/arm/boot/dts/st/stm32mp153c-lxa-tac-gen3.dts  | 267 +++++++++++++++++++++
>>   arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen1.dts  |  84 +++++++
>>   arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen2.dts  |  84 +++++++
>>   arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi      | 100 +-------
>>   6 files changed, 455 insertions(+), 88 deletions(-)
> 
> since the merge window is open, can you merge this series please.

Yes sure. It will be in my PR for v6.14.

regards
Alex



> regards,
> Marc
> 

