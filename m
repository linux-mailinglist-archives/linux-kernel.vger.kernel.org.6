Return-Path: <linux-kernel+bounces-191807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A828D145E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F11C21C46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E853368;
	Tue, 28 May 2024 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WVfCCit5"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195B23C9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877636; cv=none; b=PrdRA52Hw13HlCOktNJF5TOa57XbEdtREEn0yNnIqvyfi0XC8YsrHR/PKRY3zx+BReH+MUXA00IY8+BuEuE1VqvZPyv2qxrhrUXSsgwoyxRpW646gko8ZlakR1GBNqdhH01gsRh1Dk0G+yOBjZ1xxew4KqISrqRVMNWEd0T8GII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877636; c=relaxed/simple;
	bh=8yBizgjhi7tMgvv88i2HXEOGylN57byouvG8pAjwiYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tQiqqv+0qgEXGa5rIw6cwb4HiT2IDWcXwZPGEOC+kvJVXXraziKWbnSjDoB0k90bGhL6Cv6v41HOTVoR8Xs/Eo4eAMErIH6QZHDDDnyvfsM1xPTiEuNf9V+jbSrv3jKygNOnevP8B4q3jM07aPogR7tRwN0ouU1+Id6g5+yIddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WVfCCit5; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S6QYlv080677;
	Tue, 28 May 2024 01:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716877594;
	bh=LV9HHwQZOyg/pyJVAFZSMcYDcxaKD8j2pH6IA8DC24s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WVfCCit5fS8o9XQ3VU9t+ZW87oj2OZYDya4m/3DcobE86oCv9d6oNbUnrOQpJvYIj
	 WeCwmYHZWZnsIPWYvTWue2sa8nyaJ3pk8TDKsO66M5GORlC4lrtuAzeTb2W1AqQJuJ
	 x12EY+yheb8pXGGOLm7TDr25DgWRlRNcucZnDiAs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S6QYcb053292
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 01:26:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 01:26:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 01:26:34 -0500
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S6QT0H124268;
	Tue, 28 May 2024 01:26:29 -0500
Message-ID: <9170a555-7cd3-4888-bad3-01b71c6f445e@ti.com>
Date: Tue, 28 May 2024 11:56:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Modify number of usable 8250 uart ports
To: Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: Udit Kumar <u-kumar1@ti.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
	<nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Biju
 Das <biju.das.jz@bp.renesas.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>
References: <20240516095733.276807-1-b-kapoor@ti.com>
 <1d1c92f3-1692-40a1-aeb9-ef3e342e9bf6@app.fastmail.com>
Content-Language: en-US
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <1d1c92f3-1692-40a1-aeb9-ef3e342e9bf6@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Arnd, our most boards have 6 uarts that can be used in the runtime

but overall our SoC has 12 uarts. And some of our customers have this

requirements that on their custom boards they use more than 8 uarts on their

boards. Thus, we need to enable this to 12 uarts.

Regards

~B-Kapoor

On 17/05/24 12:19 pm, Arnd Bergmann wrote:
> On Thu, May 16, 2024, at 09:57, Bhavya Kapoor wrote:
>> Jacinto SoCs have a total of 12 serial uart ports. But only 8 out
>> of these 12 uarts can be used at a time.
>>
>> Thus, Modify maximum number of 8250 serial uart ports which can be
>> supported as well as modify how many 8250 serial uart ports which
>> we can use in the runtime to 12 for all the SoCs.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> I forget what we had already discussed here. To clarify from my
> side: it's ok to raise the limit if there are any known boards that
> connect more than 8 8250 style uarts to external devices or
> populated connectors.
>
> On the other hand, I don't see any dts file at the moment that
> has more than the maximum of 8 in k3-am642-tqma64xxl-mbax4xxl.dts.
>
> If you are adding another board that has more, it helps to
> clarify in the patch description that this is indeed a board
> requirement, and not just done because the chip has additional
> unused uarts.
>
>       Arnd

