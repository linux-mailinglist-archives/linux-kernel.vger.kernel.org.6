Return-Path: <linux-kernel+bounces-387273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1E9B4EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931801F23E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4A0195F22;
	Tue, 29 Oct 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Hzt5EAsS"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA61917E7;
	Tue, 29 Oct 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217953; cv=none; b=p3klNJp5tBFKu9JRknb5MJtljZQCmJI4N8j9FHlG8OECe8EpfIYfGvgUetmgUAXQIKhS+rAUEQ7g5i6r5SHs2dxWB6QMXPIUNRj9+EYKiO6T3IEJUyVkYUVrQHCT7BoVYfauEXbeIirMuyVrWKrcC5cIv12/A2QUFqkFyDqtPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217953; c=relaxed/simple;
	bh=8oTkPQpxrNI9UGq/jvh8x0pdz9WaIWRU4V+70/Yko/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ghr5P9rI+0vs2m11tousB5EBo0cKqz5Bb4nt4YPC48SnIweKqUwo2Zku+BXEiRlD+Jpjh4Y4ngnMfqfulKs35w/xkgblSXmIXbvsrIxTMH84269Xlb4VnIhEHnHNf8lNAfmseoIlk5kDAfgAf2QThskJEYsUbZz0N8Q1Fh+1VaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Hzt5EAsS; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCOSNf022762;
	Tue, 29 Oct 2024 17:05:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	A9RHv1s9fRZ1l/E0wCeEXv4fppRhjYbx9rteeeM09nk=; b=Hzt5EAsS/nPCClIH
	8LVAmJrvfFnKiuZA/gyJj6cmzvP6tzNHtprkmpNaiO7nmmnccsA8heza4pC/pdcM
	CQtj7XFDbxeyjy+hAXrLc4hJAyDGokdWjHGgacFBoSvlOUOqtgi9KtHkuZuFABWI
	U9lOkdgC/lWEwCLF3zIWmbod6c9AiyRcyrlI76l4iI0EkZ+ommEZpZyaL3W4SCPs
	dOHe1TYaQpXfGVp3sBzQwoS9CMbHSrDpL4kM2f+2Byj3HNYLoFGpcHZG1s35kete
	zJuCAUfD+AhzzPBIWCG4uOj7h0rU2+yeBXh+ezMKsCOOx40SltfmNBWEUe8LUq9Z
	Z2hY2g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42gnj4frmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:05:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 46A1740044;
	Tue, 29 Oct 2024 17:04:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E12B726D0B1;
	Tue, 29 Oct 2024 17:02:45 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 29 Oct
 2024 17:02:45 +0100
Message-ID: <a4bf6356-700f-4646-9867-ade436341812@foss.st.com>
Date: Tue, 29 Oct 2024 17:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] ARM: dts: st: add WLAN/BT on disco boards
To: Valentin Caron <valentin.caron@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>
References: <20240827140455.345086-1-valentin.caron@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240827140455.345086-1-valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Valentin

On 8/27/24 16:04, Valentin Caron wrote:
> This series enable WLAN/BT module on stm32mp1x discovery boards.
> Use LSCO from RTC to supply 32kHz clock to WLAN/BT modules.
> This is done by selecting "rtc_lsco_pins_a" in the WLAN pinctrl node.
> 
> And also add RTC nodes on stm32mp25x to enable RTC on stm32mp257f-ev1
> board.
> 
> Christophe Roullier (2):
>    ARM: dts: stm32: add support of WLAN/BT on stm32mp157c-dk2
>    ARM: dts: stm32: add support of WLAN/BT on stm32mp135f-dk
> 
> Valentin Caron (7):
>    ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp15
>    ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp13
>    ARM: dts: stm32: rtc, add LSCO to WLAN/BT module on stm32mp157c-dk2
>    ARM: dts: stm32: rtc, add LSCO to WLAN/BT module on stm32mp135f-dk
>    arm64: dts: st: add RTC on stm32mp25x
>    arm64: dts: st: enable RTC on stm32mp257f-ev1 board
>    ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp25
> 
>   arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  7 +++
>   arch/arm/boot/dts/st/stm32mp135f-dk.dts       | 52 +++++++++++++++++++
>   arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi   |  7 +++
>   arch/arm/boot/dts/st/stm32mp157c-dk2.dts      | 51 +++++++++++++++++-
>   arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  6 +++
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        | 10 ++++
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  4 ++
>   7 files changed, 136 insertions(+), 1 deletion(-)
> 

I applied the series by removing patch[9] as it raised a build issue.
Furthermore, the pin pin configuration in patch [9] was not used in a 
board, so no need to take it.

Regards
Alex

