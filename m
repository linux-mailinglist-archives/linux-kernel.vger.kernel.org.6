Return-Path: <linux-kernel+bounces-233900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E144091BEFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7BECB21D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B51946D6;
	Fri, 28 Jun 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2Pd9qWSs"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6CF1953A8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578827; cv=none; b=UfSmJQPxdZx/gghfSz4zAdQe2I0neBXN0ZEaAqSiT2kt5YQZ5l6+9P6rutNcsBPYTLVu4va1FhVnJ6TER4qfU1ZQXXW3N3vKb860tsV4H2dX90Q/pTXCD6X2vUcNSjoVR94dGi4jgfgNfqYn9zmVtG+bCxqePRqlqpAhcLAAmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578827; c=relaxed/simple;
	bh=7jPexHrV/W4ImEvkL858EPEYGhVlC87FfSGCCPQU1BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R89q5p4HtlrTaAjPnHbcaUUtnEI33UgnoUi2lHWO4kXwWn0a3JjWhM+yXDGpRiuS2skaalUF63XrRjG0SKnCZSOdIWCMT9Q94nwWijitImiv47Ltj+DyJakxEy40/Y+7qA2ds+54Z1EeOOKAw2lQZD0l0DYKsNGyFIBlf/rkDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2Pd9qWSs; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S958Kt022997;
	Fri, 28 Jun 2024 14:46:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ZAPW0T4mk6+g9RGuq3Ms922nET7aswPOyugOIngcHKU=; b=2Pd9qWSsIfkL0qEw
	+CjoWW7KavAWCHIpnaFU6LkIKt6De71CvzkU3m7Y28k4TqSs5FR7/LWHRL+EWTRq
	lrD88aB4Sc7RByWtbwnzKGBDPPmhUbhN8EkIe5YHhlnuZAmGVXzH43NcGHkfACEW
	GeoE/b1aLOVnXtL7/XYnexWBUwGWf9EQcziidRafZKmBwBwdaG1ECHCgjLXXQXOK
	LV/0WWmsxAO1JHOLKTXcmYRpKhdyC0uEeYuXjboOV8s+BT3pYeY+UA3anR09+awV
	pC/r4CAoVMHooouVSg0xrYiIqT2XoiIEtWwr1LmVmTTGcNxkW7PJWSrOoGwzi3Bn
	PVbEfQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jjqgfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 14:46:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9E1C740048;
	Fri, 28 Jun 2024 14:46:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CA7A02258A2;
	Fri, 28 Jun 2024 14:45:45 +0200 (CEST)
Received: from [10.48.86.145] (10.48.86.145) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 28 Jun
 2024 14:45:45 +0200
Message-ID: <21f4d43d-4abd-4aca-7abb-7321bcfa0f1d@foss.st.com>
Date: Fri, 28 Jun 2024 14:45:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND v3 0/3] Update STM DSI PHY driver
Content-Language: en-US
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com>
From: Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_08,2024-06-28_01,2024-05-17_01



On 1/29/24 11:41, Raphael Gallais-Pou wrote:
> 
> This patch series aims to add several features of the dw-mipi-dsi phy
> driver that are missing or need to be updated.
> 
> First patch update a PM macro.
> 
> Second patch adds runtime PM functionality to the driver.
> 
> Third patch adds a clock provider generated by the PHY itself.  As
> explained in the commit log of the second patch, a clock declaration is
> missing.  Since this clock is parent of 'dsi_k', it leads to an orphan
> clock.  Most importantly this patch is an anticipation for future
> versions of the DSI PHY, and its inclusion within the display subsystem
> and the DRM framework.
> 
> Last patch fixes a corner effect introduced previously.  Since 'dsi' and
> 'dsi_k' are gated by the same bit on the same register, both reference
> work as peripheral clock in the device-tree.
> 
> ---
> Changes in v3-resend:
> 	- Removed last patch as it has been merged
> https://lore.kernel.org/lkml/bf49f4c9-9e81-4c91-972d-13782d996aaa@foss.st.com/
> 
> Changes in v3:
> 	- Fix smatch warning (disable dsi->pclk when clk_register fails)
> 
> Changes in v2:
> 	- Added patch 1/4 to use SYSTEM_SLEEP_PM_OPS instead of old macro
> 	  and removed __maybe_used for accordingly
> 	- Changed SET_RUNTIME_PM_OPS to RUNTIME_PM_OPS
> 
> Raphael Gallais-Pou (3):
>    drm/stm: dsi: use new SYSTEM_SLEEP_PM_OPS() macro
>    drm/stm: dsi: expose DSI PHY internal clock
> 
> Yannick Fertre (1):
>    drm/stm: dsi: add pm runtime ops
> 
>   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 279 ++++++++++++++++++++++----
>   1 file changed, 238 insertions(+), 41 deletions(-)
> 

Hi Raphaël & Yannick,
Applied on drm-misc-next.
Many thanks,
Philippe :-)

