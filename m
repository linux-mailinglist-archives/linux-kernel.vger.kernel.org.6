Return-Path: <linux-kernel+bounces-252658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469DD93166F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0042D2864FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E318EA64;
	Mon, 15 Jul 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mHm65XzY"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD6433B3;
	Mon, 15 Jul 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052746; cv=none; b=Vaua0aANZxWhrV0m8HFHdnyKWSsJW+gDXkGvmfkdo032gnCnDTo7Nz0BtxALyIP5cgaXEEufXNuoIlcxzKwsYbk0HSIWmB9jdv3VSoJrgAIYcd8YO3HT2B1za0F+wfCpJI/X7PI06AmDtVhM1JLGv0d3a8iH3P0mtKn02JJbgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052746; c=relaxed/simple;
	bh=/E6d9NSn3kJQAkuAkw0xDF8+REcuFMzRMVtSfDS4kqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=brDx4tny35Z+vQw9/Gp5vuyAChRuZo3c1CmQNOKmE41quxWaohTJMhXaeJitKBF8tAc7p0qhH1+ZcD1qVZq8M+kj+mWS0VAcf2mhgHZYGZWJ2L9kajuuRLgzpQj1a5it8fyVhOz05WNW7JYvYyellc4aocBpReMtofWYaXtf3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mHm65XzY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46FECGnW038051;
	Mon, 15 Jul 2024 09:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721052736;
	bh=+HAU2E0csD3sG3f5lx5N+K+4dNpKo8af9UxtHFdSupw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mHm65XzYb5SN/rMfiJuyhog10Lj+/IK4B1a8iFWZ8tpuijr5qQJh0to8jqSC6snLf
	 P8vbfLddwQPKFtYXH0eVaDysQ/qAzXC1hpkjqCr/VQx7tUJ0CWqTGXUje5EFSQum/E
	 KFcKL57oDY4loosgMIk/3i5NaEv5w3/F73YvSUIE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46FECGR8003895
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jul 2024 09:12:16 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 09:12:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 09:12:16 -0500
Received: from [128.247.75.151] (ula0511493.dhcp.ti.com [128.247.75.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46FECGYw003661;
	Mon, 15 Jul 2024 09:12:16 -0500
Message-ID: <2a1ccecd-f81f-4de3-a4f8-c056496802b1@ti.com>
Date: Mon, 15 Jul 2024 09:12:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
To: Krzysztof Kozlowski <krzk@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220321155417.13267-1-bb@ti.com>
 <55e161d1-face-6958-1d86-8a85b82e8485@kernel.org>
 <766dceb1-222a-401b-95e3-69b7fb331411@ti.com>
 <e5ded1c1-be7e-4e16-b175-f4bd4a121d3a@kernel.org>
Content-Language: en-US
From: Logan Bristol <l-bristol@ti.com>
In-Reply-To: <e5ded1c1-be7e-4e16-b175-f4bd4a121d3a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 7/10/24 01:52, Krzysztof Kozlowski wrote:
> On 09/07/2024 18:20, Logan Bristol wrote:
>>
>> Hi all,
>>
>> On 3/22/22 13:14, Krzysztof Kozlowski wrote:
>>> On 21/03/2022 16:54, Bryan Brattlof wrote:
>>>> Texas Instrument's am642 is one of many k3 based, low cost, low power,
>>>> chips designed to work in a wide range of applications spanning an even
>>>> wider range of industries that TI is actively developing
>>>>
>>>> With its pin-mux and peripheral rich designs, these chips will likely
>>>> have a multitude of custom device trees that range wildly from one
>>>> another and (hopefully) guarantee an influx of variants into the kernel
>>>> in the coming years
>>>>
>>>> With overlays no longer a thing, I wanted to ask for opinions on how
>>>> we can best help integrate these dt files as they begin to be developed
>>>>
>>>> I also wanted to introduce a skeletonized (nothing but uart) device tree
>>>> to give others a good starting point while developing their projects.
>>>
>>> Real hardware as DTS please. There is no need to add some skeleton for
>>> specific SoC. What if every SoC goes that way?
>>>
>>> Feel free to create re-usable components in DTSI ways, still reflecting
>>> some hardware parts.
>>>
>>
>> I am working on a project for the AM62 and came across this email thread.
>>
>> Following Krzysztof's direction, I am wanting to submit a DTSI to serve
>> as a minimal configuration for the existing boards based on the AM62
>> SoC, which are currently defined by bloated DTS files.
>>
>> This DTSI file can be consumed by other board DTS files to reduce the
>> configuration. Krzysztof, could this be merged upstream?
> 
> Aren't you writing something contradictory to what I wrote above? I do
> not see your description matching my earlier guideline.
> 
> Best regards,
> Krzysztof
> 

I understand your statement now. Are there any other paths you can
suggest for a minimal configuration to be accepted?

Thanks,
Logan Bristol

