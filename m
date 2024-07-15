Return-Path: <linux-kernel+bounces-252282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D59310EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AF51C220AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07BF186E20;
	Mon, 15 Jul 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sL2kg5Ba"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96F1862B2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034717; cv=none; b=hWLmXEMGv9RQn5ptU6KjR16TMRJd78uOpqm1cEN9DGswbPPTZI8M1BFhIIn/qryb0BnCrJTYiVsRmIFwP6vhHv3dame3HfYo22fRda/oWWOY9EdjmeU8V+c8FXLz9cK3nBUBXIp4pIbu7AGgNwUAmCZ8xSrjmlgRYYM96VoyZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034717; c=relaxed/simple;
	bh=EmBq4iYlhep3ZGRFPwGod6Rwi9HusrX/rf39e4GhoPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EGqCtBP6hOQS6Qh+5UZNfHz8MeKoauCP/xJfMoS+luF+cVZ1x9Qh78T+S/Z837DFMZJQEgJpBzoraEqwWtPIs1ryPXJG/BZjA0tn/Dip52jZqBnvy8bYa9ggZ7FwOqd4klME2Vg/yNgfsUN2q7GN9VSHjYLyhkeTHrgUN/zWgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sL2kg5Ba; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F7nQAY011784;
	Mon, 15 Jul 2024 11:11:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	EmBq4iYlhep3ZGRFPwGod6Rwi9HusrX/rf39e4GhoPk=; b=sL2kg5Ba5l3zIKIy
	72wYw8A4IqRvX627qjMpEHz7ZHHqYknfLccmEqqCnITeHsF4XFSYAETGftsGw9Ly
	RMh04G41xx5AkrFuJzLtL4oDkqVQmhLgZrJlbjnPVsn4MPpRTevLXz44+uDODwgb
	G0oGgZp6ygZ/c3zGmZP/kQpxmgv7nj61EJbhk8cDqH9PbDfaAkfHQX1fEaNecV/O
	LMuuTOKKmeNx/8AfL6yqk4vfIOlM9jLc3Tegf5WGAiXyLHNe7HirMBzCEsOaAMsd
	HuUwWfrvki2m+98mmdRqnZ7ZRhlOJMWn/A5yQDLeXTTyrX0vliPZWQ6AXucNHdyB
	zWyqqA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40bgfddrdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 11:11:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BC8C84002D;
	Mon, 15 Jul 2024 11:11:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CC568210F72;
	Mon, 15 Jul 2024 11:10:19 +0200 (CEST)
Received: from [10.129.178.17] (10.129.178.17) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 15 Jul
 2024 11:10:18 +0200
Message-ID: <aa8d12a0-1cf1-4f83-aa52-e0f3d8e3338f@foss.st.com>
Date: Mon, 15 Jul 2024 11:10:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: ltdc: Remove unused function plane_to_ltdc
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <yannick.fertre@foss.st.com>
CC: <philippe.cornu@foss.st.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Abaci
 Robot <abaci@linux.alibaba.com>
References: <20240624024113.54850-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240624024113.54850-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_05,2024-07-11_01,2024-05-17_01


On 6/24/24 04:41, Jiapeng Chong wrote:
> The function are defined in the ltdc.c file, but not called
> anywhere, so delete the unused function.
>
> drivers/gpu/drm/stm/ltdc.c:494:35: warning: unused function 'encoder_to_ltdc'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9403
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>


Hi Jiapeng,

Applied on drm-misc-next.

Thanks,
Raphaël


