Return-Path: <linux-kernel+bounces-257211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CAA9376C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4103F1F218D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86CC7E782;
	Fri, 19 Jul 2024 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lrTrJsCq"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59E8F77
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386071; cv=none; b=f7jfxVdTCF+hhHwErMBQA5zIvZeb0tg5MwDIe8YqnqU+OG0TQItT4X7SRKyzRvPHH6rKTri3+tDBHnXZRnQeW4HwDq+frB5S7KrsqTmoTsaTSQsB5iVRkFeuXVZ9CANswfZMwSCJ9R8Y3lGqBUALHxG2Uwgdgz6LqWlaVxe39H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386071; c=relaxed/simple;
	bh=RZzj3xHQgxgU107La7qjlbXpfm5eUgRVHoyUDQSd6KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E0KkjB01NfKFMUI+1/ArBqtZ+xlROeP3Nz9HImAsbCRIiDRMxbkXs/78Xkn25wlYgifcXs/yaUq6BIsyIExDR4V0oUErz50mOXF6yjQGfwCWoqoNpLlhOQqXuuNRM3cKxRqVu1vfVZzwOKnD97fl1WnykH7Qoap5Bd2eYTRzpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lrTrJsCq; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46J9Zwhn029511;
	Fri, 19 Jul 2024 12:47:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	RZzj3xHQgxgU107La7qjlbXpfm5eUgRVHoyUDQSd6KY=; b=lrTrJsCqgSQle2Om
	LxEWA/Dt+ATafATyv5hLaZbFZR3reM+Ko2Z9BRsI2p2Ao+7Kf0D77m1zJpUkF1FV
	k9FAJj3J/S4hH91GMKvolG9y6o6nHTGaFPDkmrniQ3lgAllZt/27OJ/vhD05/NUO
	z6wLI/952vYK/8Q0QVyu2jhUVkNj5D5wfZUV1z4BFa+obDN750zZLkhQtdpFX0jq
	/3OD3f8q/9YO9nNLdyTJmFPOVW/0oHc/0cQhJ9FMZVE3QuuxoMwe4dd31noSLRuw
	371mcc5TbZX9nTkRGgLvJbuZVZHJ6SP/BU9+Ek9EBRpzRXorLANtEEnQmB3jW02z
	BQUapw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40fe1nhyx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 12:47:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D0C4340044;
	Fri, 19 Jul 2024 12:47:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3173C24DCA3;
	Fri, 19 Jul 2024 12:46:22 +0200 (CEST)
Received: from [10.129.178.17] (10.129.178.17) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 19 Jul
 2024 12:46:21 +0200
Message-ID: <2e47028a-fc8c-40d6-a69a-4b7bc3464974@foss.st.com>
Date: Fri, 19 Jul 2024 12:46:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: ltdc: remove reload interrupt
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
References: <20240712131453.98597-1-yannick.fertre@foss.st.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240712131453.98597-1-yannick.fertre@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01


On 7/12/24 15:14, Yannick Fertre wrote:
> The reload interrupt is not used by the driver. To avoid
> unnecessary calls of the interrupt routine, don't enable it.
> Solve small typo and add mask to simplify the driver.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>


Hi Yannick,

Applied on drm-misc-next.

Thanks,
Raphaël


