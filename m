Return-Path: <linux-kernel+bounces-405485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116189C51FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA46A2862D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DCC20D4F4;
	Tue, 12 Nov 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nCiw8iZU"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2520D4E2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403728; cv=none; b=OOtJmff5sONhxcd4G+srYUAw4Sc2tI2y+uHqXSCBJpPeZpNevO4Q0Vpw7w4RA1wj0DdgiuEsClpyc1SpNJ2Z1PC9E23BuL3sk7nUt3t/Wgx+hKZr3A37PmQdu3TMjWpb7E7ZZQPMS+qnsPHfrZI+hAfzC9kgOWLBrbxg1nPM7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403728; c=relaxed/simple;
	bh=IrfvUkChhPYRCajlEMQkArFbQ6tLDYvdvd1gz7c7f5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OcBW/rBlxmQuUgBW203NmBcaTqQk8v8gkVlgRNEe7S/EG0QRXtQd4oCDbZeOqg2Zu9J4xlWCrUcnWybrjIpgukGiCR2P9dbzXrWde3d949tB9mQdHB40RdH/bkdJRhvBx3UgsBWRsqf9B2g3csV8CeL1VrSTjqQzBqCaO5Rq19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nCiw8iZU; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC8wnH3026281;
	Tue, 12 Nov 2024 10:28:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	RBX0wkPtCAIZ/zoNdwhmrm7wwaHeAwtcOpxkNtXwcK4=; b=nCiw8iZU9w34ZRT/
	fZzJR6AMPkuSzJaxHBZyMBF4gJ3S3XG0euXWX6TRPtXsvsLljIFjLsH5f95eDods
	t7VXYiU6rrnxq1vD61xWK+RBcHJfCv0qtZKUuX94yXTSuFVrlwwe0Jfb058De5Ms
	HCD9Ok6BEzVLdyzTcCS5KDeGnH3Z1t/20fhMQdGM6C+QK/XfCKknDXH1tW3j3BDL
	MMonKdPLvUFVDx5OqwAZdE6BoxCzB7U1vPcFDQ845kfRYTyqDCvMzyhKWZv+2aJj
	6ZX/VEaOMuTrKoAJlZXTTkIppYUoqucaf8Cg+ereCIlyqVmOwydCKVJzJv5nAqOS
	PJa+sg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42swr8u40v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 10:28:24 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A916E40056;
	Tue, 12 Nov 2024 10:27:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1D9028E842;
	Tue, 12 Nov 2024 10:25:54 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 10:25:54 +0100
Message-ID: <cfb1caed-9402-4148-831d-57c50bdf6a27@foss.st.com>
Date: Tue, 12 Nov 2024 10:25:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firewall: remove misplaced semicolon from
 stm32_firewall_get_firewall
To: guanjing <guanjing@cmss.chinamobile.com>, <mcoquelin.stm32@gmail.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
References: <20241109055049.269163-1-guanjing@cmss.chinamobile.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20241109055049.269163-1-guanjing@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi

On 11/9/24 06:50, guanjing wrote:
> Remove misplaced colon in stm32_firewall_get_firewall()
> which results in a syntax error when the code is compiled
> without CONFIG_STM32_FIREWALL.
> 
> Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
> ---
>   include/linux/bus/stm32_firewall_device.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bus/stm32_firewall_device.h b/include/linux/bus/stm32_firewall_device.h
> index 18e0a2fc3816..5178b72bc920 100644
> --- a/include/linux/bus/stm32_firewall_device.h
> +++ b/include/linux/bus/stm32_firewall_device.h
> @@ -115,7 +115,7 @@ void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 su
>   #else /* CONFIG_STM32_FIREWALL */
>   
>   int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,
> -				unsigned int nb_firewall);
> +				unsigned int nb_firewall)
>   {
>   	return -ENODEV;
>   }

Acked-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

Thanks
Alex

