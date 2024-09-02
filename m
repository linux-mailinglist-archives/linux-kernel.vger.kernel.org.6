Return-Path: <linux-kernel+bounces-311364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E493968813
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B44228342B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224361D61A5;
	Mon,  2 Sep 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Glj3Z303"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038719C56C;
	Mon,  2 Sep 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281848; cv=none; b=hXbKFVl7cdLPpyMI+J3c53qqUV2yOPMosfp9k1fpdSLWumLwxs4iO1oQxl0ATxB4OFxL19B7U4qWnV3vHO9ceBPsrHy/zGlceWtiea4tOryYfOfdCACG9zH14AV3M/ayoln5eD7qEQke72jO54ffco6ajKNBKMsRwmHB9jRs1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281848; c=relaxed/simple;
	bh=M91o09vL1bMwOmCoznkjH6oG2YpxUT+4OOrtCFleyvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V84VkMY5J5SMDwZmtXOUUIYyU0R7K0GPe+HJw2Nf9HqC7CMSgu1NzxFsS5yDiLkJ3AeHuT7+bpdsfKUH/MXM21cuU917iNZzOW9HVnMJcbcYVYhBl2Tg01kMa+C4nyNDDqvCOwdHjkZZX8IdGZg1Y4vKyhpMzLd/8dq0Cr9HJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Glj3Z303; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 482CvJ1B059155;
	Mon, 2 Sep 2024 07:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725281839;
	bh=YSefBqAQwm5Gsbjw4LNtV2qjJ+bxbq24H+xHL/t+zj0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Glj3Z303kQvg44KuY6NjMSwB7bPvuvZETLpbI31DM3TUSojw8ioiLlVsu7khFGB8R
	 k8HIf2Mt8V6K+INLVRQ72yOd2MudEuRJoMpL+gP5B19wZ431h4YOHdYJADmnoqykrm
	 FCktfOQfAURH5fchCJjnrm8g5XsJwecsRmYgJNbg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 482CvJ9C062914
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 07:57:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 07:57:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 07:57:19 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 482CvETp036513;
	Mon, 2 Sep 2024 07:57:15 -0500
Message-ID: <a778d080-9cc5-4b1d-ab4b-6a6d930d36f9@ti.com>
Date: Mon, 2 Sep 2024 18:27:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] arm64: dts: ti: Refactor J784s4 SoC files to a
 common file
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>, <u-kumar1@ti.com>
References: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
 <20240902-b4-upstream-j742s2-v6-1-6a7aa2736797@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240902-b4-upstream-j742s2-v6-1-6a7aa2736797@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 9/2/2024 5:56 PM, Manorit Chawdhry wrote:
> Refactor J784s4 SoC files to a common file which uses the
> superset device to allow reuse in j742s2-evm which uses the subset part.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>
> Notes:
>      v6:
>      - Rebased with conflicts
>      - Added a comment for MSMC node runtime fixup (Udit)


Thanks

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>
>   .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  148 +
>   .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2671 ++++++++++++++++++
>   ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
>   ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
> [...]

