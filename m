Return-Path: <linux-kernel+bounces-323048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037EF9736F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60CE1F265DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2FC18D637;
	Tue, 10 Sep 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MIjHtFZf"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2826184535
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970589; cv=none; b=pIh6Z2FJ3l7DZGKdqZ6lcf3QzjQub5AcWncCINyrHRVdj0QD/BUUXNSCsYz/MYdfciYizf8Kn8EwgOGcT3+i5pMint66BYcfokvS0LHSLOtyLuaAHQC5s/qQUE2s8WwBqYK9wCcSZBBywfC/CIRHDnL4Rr/POQ2kszjzoILk4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970589; c=relaxed/simple;
	bh=xfrMjNFodOzpbauEC6IlGFGn4nN1hQBw54FOY00V2aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eqasudgA8E9t+wQJQ3lCLMzZlV8cDi2YyP1TMiRI4FBMx9zHOD2GoWnkpHjADX9aypBvdISv4c1dSTJPBYK5Si2BV1F4uVjcAvMUwvgm499xt+dYNStjng2ArM0GqvpjMHGwSTfYtFELjH4n/oO0+7AgXsTCW6sgeoK4lmp+1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MIjHtFZf; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A81HtJ011709;
	Tue, 10 Sep 2024 14:15:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ioOMx4SZoDn6Y4I5z6mPsXYFUS0WP23smSQRZ2j69ro=; b=MIjHtFZft5ESF+0r
	WnHUXVLSZ+bXJzkMdpgXmCowdh5tFCDNW2D4gy5M/M5vtS9fTS4qif1h7shoVBsz
	t0kx9y9rIBfbYeTtl5yMDVUvac5S1TmwbA7fosczroQZm4286xfzc0UTkvypxVUh
	MNCxDHhoegcTsyH9jBiisDzpOk6ATt+Y5kagb/Gie/k//1jt/oTIoL6eP2KbvNDj
	sLsuGGRcrOrmnBFOJ8F0LINlONwnu4R3Wp9r6j0ESzNebYBT4oJR2ZWlv3OLS6VN
	q/1kLQ5klo8MPT65lvvhra1Bg7zlxkqYva6UbFSdxhNc7xd+kX9O1o2xMHCqLBd/
	sFQaAQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41gy7s9u01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 14:15:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BE71A40045;
	Tue, 10 Sep 2024 14:14:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC59B2681BC;
	Tue, 10 Sep 2024 14:13:26 +0200 (CEST)
Received: from [10.252.24.111] (10.252.24.111) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Sep
 2024 14:13:25 +0200
Message-ID: <2f5b8627-60c0-4528-83fb-25d5af324516@foss.st.com>
Date: Tue, 10 Sep 2024 14:13:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dw_mipi_dsi-stm.c:(.text+0x8db9a3): undefined reference to
 `clk_hw_unregister'
To: Maxime Ripard <mripard@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, <linux-stm32@st-md-mailman.stormreply.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann
	<tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240905081902.GAZtlpdlQp5XOm5XtO@fat_crate.local>
 <544a633e-de53-493d-9c29-de8ff52630da@foss.st.com>
 <20240909084506.GBZt61kqqGVUTqjKc4@fat_crate.local>
 <0e9018d0-c49f-4dac-aa0f-b05504f9c6f6@foss.st.com>
 <20240910-gleaming-boa-of-drama-d0a4db@houat>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240910-gleaming-boa-of-drama-d0a4db@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01


On 9/10/24 13:59, Maxime Ripard wrote:
> On Tue, Sep 10, 2024 at 12:48:49PM GMT, Raphael Gallais-Pou wrote:
>> On 9/9/24 10:45, Borislav Petkov wrote:
>>> On Mon, Sep 09, 2024 at 08:57:57AM +0200, Raphael Gallais-Pou wrote:
>>>> Arnd Bergmann sent a patch regarding this issue on x86 that I merged several
>>>> weeks ago.
>>>>
>>>> https://lore.kernel.org/lkml/20240719075454.3595358-1-arnd@kernel.org/
>>>> https://lore.kernel.org/all/c3d0757a-07c0-4f83-9f06-c3ad205aa1e9@foss.st.com/
>>> Thanks.
>>>
>>>> Now, I'm not familiar with PowerPC architecture and toolchains, but I think
>>>> this patch should fix your problem.  Do you have the above fixup in your
>>>> tree ? If not please try it.
>>> Not PowerPC - it is an x86 build. I do random config builds as part of build
>>> testing and when a driver depends on COMPILE_TEST, it does gets built in some
>>> .configs. So some may fail, as in this case.
>> Unless I am mistaken, the link you provided refers to a PowerPC linker error:
>>
>> [...]
>>
>> compiler: powerpc-linux-gcc (GCC) 14.1.0
>>
>> [...]
>>    powerpc-linux-ld: drivers/gpu/drm/stm/dw_mipi_dsi-stm.o: in function `dw_mipi_dsi_stm_remove':
>>    dw_mipi_dsi-stm.c:(.text+0x664): undefined reference to `of_clk_del_provider'
>>>> powerpc-linux-ld: dw_mipi_dsi-stm.c:(.text+0x66c): undefined reference to `clk_hw_unregister'    powerpc-linux-ld: drivers/gpu/drm/stm/dw_mipi_dsi-stm.o: in function `dw_mipi_dsi_stm_probe':
>>    dw_mipi_dsi-stm.c:(.text+0x98c): undefined reference to `clk_hw_register'
>>
>>> So I think you should send that patch to Linus now so that such randconfig
>>> builds do not fail anymore.
>> What do you mean by 'sending it to Linus' ? If you meant to do a pull request,
>> then no. This patch is already in the drm-misc tree, which means it will keep
>> its usual pace of merging with the rest of the drm-misc tree.
>>
>> For more information about drm-misc tree:
>> https://drm.pages.freedesktop.org/maintainer-tools/repositories/drm-misc.html#merge-timeline
> That's not entirely correct. This should have been merged in
> drm-misc-fixes to begin with. I've cherry-picked the patch and pushed
> it.

Hi Maxime,

Oops I stand corrected, I effectively should have thought about sending this to
drm-misc-fixes.
Thank you for doing this.

Regards,

Raphaël

>
> Maxime

