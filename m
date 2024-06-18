Return-Path: <linux-kernel+bounces-218829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCB990C6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D887282AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F213FD8D;
	Tue, 18 Jun 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Aig2xZ1E"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184B13AA5E;
	Tue, 18 Jun 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697695; cv=none; b=TiXFlB0hsBtUShtW4Jc/5FJQ+ZQAcWG9ofR6yp4Sh7fVwKCXIZ+aFZkxfaqGsLf4HgcC7Wh7EYFNvkBBan5V4oy4VqkKhrBUPCquv2cCjFvQAmr57ZPieviYVvc7V5UW3gcxEmFa0qrMongrZt/hD8T9WbpC9qhfvXL+bxt5oP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697695; c=relaxed/simple;
	bh=QC34Q+xe0n335kILA5aIWLckgMazYorNz/uLH/P8qsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=KBE4Lb/jEhtgIq2sbAWoZcVMhEFpdJ4jg2JVTZxsDQQgAO0jlgKFAgft0+cxoU+kbKURnaKorc5OJppabRKLMMUoKE7jaseS/WN9WhDmm6dfG/3Z1S1rhpvWyBTWs2EvvzxcZkR6VySLipd4GCv5N+SqJIXdqZcfwyCgvySxPys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Aig2xZ1E; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7SjZ4011154;
	Tue, 18 Jun 2024 10:01:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	KD5DJPIUWljRkbKyGSSk9X0rvNhJfAYrmRTUTF8bu0U=; b=Aig2xZ1EDoDtB4zy
	RCgnLXckb/C5OOIQlev/+QgxHtyLGEojPbAgmgKWCGMGG44AtmNVdNY7uvurqenQ
	pKpkFRXgIgfvyKshpAwkhjaysFhT1dtyfDYUzuQzSnR+HLfp1mDYhKz06HNkt9so
	XJOBRmbrQExx+XhFRGOjQYN0jHhDAvq3CbLRJK94VwtdCPcf3byMLmRtxcDBQ1Wl
	uogFCW9dfVNkD1xkN6Hzpw68wJf2RkoMBcR2pYQTvB31QvYdlLYOHQpcmoTey69L
	v7Z1dAKv5kH5PXiTCqh/wk0u/ZHBKmDBu4paIFyeES1Ytw+Fj63+t1yVw6eGhExn
	A/sbXg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys0cgabqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 10:01:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8C08740045;
	Tue, 18 Jun 2024 10:01:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8EF58211973;
	Tue, 18 Jun 2024 10:00:42 +0200 (CEST)
Received: from [10.48.86.232] (10.48.86.232) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 10:00:42 +0200
Message-ID: <10e21012-d7f0-4329-a1bc-537828d7dca1@foss.st.com>
Date: Tue, 18 Jun 2024 10:00:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mfd: dual licensing for st,stpmic1
 bindings
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240617092016.2958046-1-etienne.carriere@foss.st.com>
 <VE1PR10MB3407EE2C8715D390E286BDB385CE2@VE1PR10MB3407.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, Lee Jones <lee@kernel.org>,
        Pascal PAILLET-LME
	<p.paillet@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        Etienne CARRIERE - foss
	<etienne.carriere@foss.st.com>
From: Pascal PAILLET-LME <p.paillet@foss.st.com>
In-Reply-To: <VE1PR10MB3407EE2C8715D390E286BDB385CE2@VE1PR10MB3407.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01



On 6/17/24 11:20, Etienne CARRIERE wrote:
>
> Change include/dt-bindings/mfd/st,stpmic1.h license model from GPLv2.0
> only to dual GPLv2.0 or BSD-2-Clause. I have every legitimacy to request
> this change on behalf of STMicroelectronics. This change clarifies that
> this DT binding header file can be shared with software components as
> bootloaders and OSes that are not published under GPLv2 terms.
>
> In CC are all the contributors to this header file.
>
> Cc: Pascal Paillet <p.paillet@st.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>

Acked-by: Pascal Paillet <p.paillet@foss.st.com>

> ---
> Changes since v1:
> - Change request license from "GPL-2.0-only OR BSD-3-Clause" to
>   "GPL-2.0-only OR BSD-2-Clause".
> - Update Lee's e-mail address.
> ---
>  include/dt-bindings/mfd/st,stpmic1.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/dt-bindings/mfd/st,stpmic1.h 
> b/include/dt-bindings/mfd/st,stpmic1.h
> index 321cd08797d9..9dd15b9c743e 100644
> --- a/include/dt-bindings/mfd/st,stpmic1.h
> +++ b/include/dt-bindings/mfd/st,stpmic1.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>  /*
>   * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
>   * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> -- 
> 2.25.1
>


