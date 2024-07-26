Return-Path: <linux-kernel+bounces-262963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 770FB93CF23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BCCB21039
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49445176AB5;
	Fri, 26 Jul 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ev68stnT"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84642F50A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980637; cv=none; b=i3PTX8xdv6LOvSe+mYRoo9Ex1gC69mUnItk3NLNy8D9tBtm5U7ZSScakjMXCEB8XBPwyb38e/C/xBvdc5Jkp6Hr3MS+toI/lSaJP+heuQRCh/HJXl3puug1MgsxfDTizlgeuxa3ExbmAitNvvHiJ6QEiT3m1utkgoMvJ1+F+QJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980637; c=relaxed/simple;
	bh=GuUhpBn47DZILbinm2qLn6S0jkbGVv+octBG00N1wz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h/3yxmtKCshTPQABonX2aEFdSTrO2gDGaPWUw6QMVpXw/A6vmP7j+wLwAr0rUxxeJc7+iNDfDL+HFYHLspw9NfHH/nKcCKBaUxVrRAioe9BaRzzIxYrAwx2EUGej8gUrgqlHEcecY5icYodDS8FX4ex09xyXluFhy6e951Xg2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ev68stnT; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q17Z4a014966;
	Fri, 26 Jul 2024 09:56:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Brr04Pe1fkXs9tsSusvMFJGsR4bSgiu85SIGyKI1YuE=; b=Ev68stnTu+1elg9J
	seY2LFurY4iEQ4jYFF2CCCPEYt2Excg5ZNYd+5polc8o83Iof9i+SZdooch5pBLl
	Z38on+noiBUqi+xXNMyGh125eZTyF7ZeUz7LEskMcp6Xqm5fsItNmJnyh5Z9W00d
	hE6hnK6c2692wvcVrMuuwdSHx5QFNy9UwsaaXXo37uovHW1vCGsDapr3MzamNM2u
	xqN/qMKPDvOhb1T4RM/Eg0wXQFzSs1urfv67mvPYT0xkMEs9/6hnlDy0oCpPaZKa
	pEeEn1d4hlDop3mCx6F9hWPyb0WHV+4yAD9k4BhfCPU581IRzC2fg1kVp/UHLg+V
	MMoWEA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40m1s118nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 09:56:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F3F0940045;
	Fri, 26 Jul 2024 09:56:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4704E2375D3;
	Fri, 26 Jul 2024 09:55:41 +0200 (CEST)
Received: from [10.252.18.134] (10.252.18.134) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 26 Jul
 2024 09:55:40 +0200
Message-ID: <e059f157-ff9c-32cb-57a6-48f2331f2555@foss.st.com>
Date: Fri, 26 Jul 2024 09:55:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Linux-stm32] [PATCH RESEND v3 0/3] Update STM DSI PHY driver
To: Yanjun Yang <yangyj.ee@gmail.com>
CC: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com>
 <21f4d43d-4abd-4aca-7abb-7321bcfa0f1d@foss.st.com>
 <CAE8JAfy9NtBa--DnUt2AEZPFnvjU6idj8DqUbaeLaH0DMFvuhw@mail.gmail.com>
Content-Language: en-US
From: Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <CAE8JAfy9NtBa--DnUt2AEZPFnvjU6idj8DqUbaeLaH0DMFvuhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_05,2024-07-25_03,2024-05-17_01



On 7/22/24 10:38, Yanjun Yang wrote:
> On Fri, Jun 28, 2024 at 8:47 PM Philippe CORNU
> <philippe.cornu@foss.st.com> wrote:
>>
>>
>>
>> On 1/29/24 11:41, Raphael Gallais-Pou wrote:
>>>
>>> This patch series aims to add several features of the dw-mipi-dsi phy
>>> driver that are missing or need to be updated.
>>>
>>> First patch update a PM macro.
>>>
>>> Second patch adds runtime PM functionality to the driver.
>>>
>>> Third patch adds a clock provider generated by the PHY itself.  As
>>> explained in the commit log of the second patch, a clock declaration is
>>> missing.  Since this clock is parent of 'dsi_k', it leads to an orphan
>>> clock.  Most importantly this patch is an anticipation for future
>>> versions of the DSI PHY, and its inclusion within the display subsystem
>>> and the DRM framework.
>>>
>>> Last patch fixes a corner effect introduced previously.  Since 'dsi' and
>>> 'dsi_k' are gated by the same bit on the same register, both reference
>>> work as peripheral clock in the device-tree.
>>>
> 
> This patch (commit id:185f99b614427360) seems to break the dsi of
> stm32f469 chip.
> I'm not familiar with the drm and the clock framework, maybe it's
> because there is no
>   "ck_dsi_phy" defined for stm32f469.
> PS:  Sorry for receiving multiple copies of this email, I forgot to
> use plain text mode last time.
> 

Hi,
Thank you for letting us know that there was this error. We should have 
detected this before merging, really sorry for the problems caused by 
this patch. We will investigate the issue and get back to you as soon as 
possible. In the meantime, I think you can revert this patch in your git 
tree.

Philippe :-)

>>> ---
>>> Changes in v3-resend:
>>>        - Removed last patch as it has been merged
>>> https://lore.kernel.org/lkml/bf49f4c9-9e81-4c91-972d-13782d996aaa@foss.st.com/
>>>
>>> Changes in v3:
>>>        - Fix smatch warning (disable dsi->pclk when clk_register fails)
>>>
>>> Changes in v2:
>>>        - Added patch 1/4 to use SYSTEM_SLEEP_PM_OPS instead of old macro
>>>          and removed __maybe_used for accordingly
>>>        - Changed SET_RUNTIME_PM_OPS to RUNTIME_PM_OPS
>>>
>>> Raphael Gallais-Pou (3):
>>>     drm/stm: dsi: use new SYSTEM_SLEEP_PM_OPS() macro
>>>     drm/stm: dsi: expose DSI PHY internal clock
>>>
>>> Yannick Fertre (1):
>>>     drm/stm: dsi: add pm runtime ops
>>>
>>>    drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 279 ++++++++++++++++++++++----
>>>    1 file changed, 238 insertions(+), 41 deletions(-)
>>>
>>
>> Hi Raphaël & Yannick,
>> Applied on drm-misc-next.
>> Many thanks,
>> Philippe :-)
>> _______________________________________________
>> Linux-stm32 mailing list
>> Linux-stm32@st-md-mailman.stormreply.com
>> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32

