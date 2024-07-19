Return-Path: <linux-kernel+bounces-257212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7EE9376C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B380282BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B40180026;
	Fri, 19 Jul 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oHzqhXAQ"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854368F77
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386085; cv=none; b=cQ3LyiIfil+Bj0O6ZyA0iIK7Yyzshg4yP5q9LXDvCHUAiWi22yVRl1WDC2MgqHhynydzQ/zvCBUj4/U10xFR/MSV4Vsty2B/qCARIR2A6SeRWkkazL63ZGn7N4v9CzykP9+gLzcyUDGCxQVjY+F1GnXpyNt4khLGkRlkYePEB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386085; c=relaxed/simple;
	bh=xvyI+WGXqWRZXoeNUQj2HzWk/pc5qUbVmwJwZRTL30o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TgqdExkWcCElfmpo2DGC/ODrq8myDg23Gj6rpfRW4wj4EaG5DSX538wv8i/KeeI0xtb6jeAxXReutDH437bHJIoZDMMqOYP4vrC5efsqN7Nf11KhG5ptVomdlYVrOuY6CeXKl/PpBBTK6YI1p2ftsdOJfx/2VOatKqQM7AZMxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oHzqhXAQ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46J9Ocbp010375;
	Fri, 19 Jul 2024 12:47:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	xvyI+WGXqWRZXoeNUQj2HzWk/pc5qUbVmwJwZRTL30o=; b=oHzqhXAQKjeh29+W
	rTMoGDvrWksbkOqlfCQ1s6ojPJ+mY7tU8+hF6/VtDh31JOzAHX1/r/mmNxo9lAX/
	9r65rJwrbzMfI54QCqGelsD9HutInNctqAdQLWT6VbS/5S73a+RuAlss9e6Es2Ce
	r4bUazmIFKE9D6IC+9bHx5mKekY3c+0MzbjPAMC6D+gfuQGIwFFufHDt7lRpSE4t
	StlrTlAgxoHVXfIzp2YRBF9Ka+xhcRPx5oDNKIU7qyvA3vFsI3u4BTWBGJp9gMCG
	4xRrFT2EhcfbN3XahD3U3TplzUvvZTPVfiQZiWoRlnyeCpjEBvtRTtG8KsgeiVWt
	u02cSw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40fe179ysd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 12:47:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6457A4002D;
	Fri, 19 Jul 2024 12:47:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7CB224F382;
	Fri, 19 Jul 2024 12:46:47 +0200 (CEST)
Received: from [10.129.178.17] (10.129.178.17) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 19 Jul
 2024 12:46:46 +0200
Message-ID: <f7685e3e-3da3-48f1-8752-f5091bb0a889@foss.st.com>
Date: Fri, 19 Jul 2024 12:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: ltdc: add mask for lxcr register
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240712131423.98405-1-yannick.fertre@foss.st.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240712131423.98405-1-yannick.fertre@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01


On 7/12/24 15:14, Yannick Fertre wrote:
> The purpose of this mask is to simplify writing to the lxcr
> register and not to forget any fields.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>


Hi Yannick,

Applied on drm-misc-next.

Thanks,
Raphaël


