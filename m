Return-Path: <linux-kernel+bounces-286720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F0951E34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3F528349C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2FA1B4C52;
	Wed, 14 Aug 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="m4df2kK2"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFE1B3F1E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648205; cv=none; b=aI2pq/xX2nYID/uhGGyu9xFk87T9MTL9SSTWvCF7dli96wocWr9fy6OSVsQLFZ9RbPvHszy0nnh3weRV4i9aAc4PzT7zPJdkYSL/6rSU//NlhSR8hp9S2n5kAcb4n1C0mrX0kesSjrvokDcB+mU8GHBbXb1Jcygt0D4RXprHYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648205; c=relaxed/simple;
	bh=FHx7qJc0rABbF4NSf3NTybFhb4n7ip9vSjH8KWDE5R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhJFGkYLz+atGbHy1b8SAuWN4Ler/dBR9Jx0wEkqg+YrDlehn0inQrbENmRJouT+zCod9WOMwptd9mYV6txlkmjgFjDGisQLhmS2hHDXR9CBJ//pmwlkIAe79qOvNyUfrHQ1hlEYykOoADMpjJuon0V6CMlHjNzIIsLMPX9W9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=m4df2kK2; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EEWxvM029220;
	Wed, 14 Aug 2024 14:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=6khWYz4q73IP7+Nkk+qlC5A
	rVKc5YVb8/czRVJNToBo=; b=m4df2kK2P0MnhQLslXZVr/fqIX6EvA1/vawdR+1
	vh/qHCgWQ4vdF9yawT7csyywBzLNao9biK/6AmevXSe4EKtoE79XarnrIpKIhlzi
	adbiNNhxd2EpTqgLzRxEzeV+zGKUHHzAQ6HoPl6VeVlZqEoH8V7jLmhS2yu7j9xk
	bf0ujhwZSk5H/wnK5jSbq+XeDRe474QnkkTyfKSOvxZG6tWgLFHw0Z+RKF1XTseU
	3EMWMzzu2XY1raaQHzMX46d/HO+HkMJ4CfberAXIB/Q674sFr/0xwxcbZupD14qF
	asIcgy6ba3viS87zCmwpdKYuErHxcKI+sBeU6OgJuiEpZ/A==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 410w3j8xcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 14:52:02 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id B335B806B18;
	Wed, 14 Aug 2024 14:52:00 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id CBA298014E4;
	Wed, 14 Aug 2024 14:51:56 +0000 (UTC)
Date: Wed, 14 Aug 2024 09:51:54 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: steve.wahl@hpe.com, justin.ernst@hpe.com, kyle.meyer@hpe.com,
        dimitri.sivanich@hpe.com, russ.anderson@hpe.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/apic: Remove unused declaration
 uv_irq_2_mmr_info()
Message-ID: <ZrzEiq7HC8kr8y5o@swahl-home.5wahls.com>
References: <20240814031636.1304772-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814031636.1304772-1-yuehaibing@huawei.com>
X-Proofpoint-GUID: i_SyV04zL2U1_68805GK0OGhQGxJ8BtF
X-Proofpoint-ORIG-GUID: i_SyV04zL2U1_68805GK0OGhQGxJ8BtF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=840
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140104

On Wed, Aug 14, 2024 at 11:16:36AM +0800, Yue Haibing wrote:
> Commit 43fe1abc18a2 ("x86/uv: Use hierarchical irqdomain to manage UV interrupts")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

> ---
>  arch/x86/include/asm/uv/uv_irq.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/uv/uv_irq.h b/arch/x86/include/asm/uv/uv_irq.h
> index d6b17c760622..1876b5edd142 100644
> --- a/arch/x86/include/asm/uv/uv_irq.h
> +++ b/arch/x86/include/asm/uv/uv_irq.h
> @@ -31,7 +31,6 @@ enum {
>  	UV_AFFINITY_CPU
>  };
>  
> -extern int uv_irq_2_mmr_info(int, unsigned long *, int *);
>  extern int uv_setup_irq(char *, int, int, unsigned long, int);
>  extern void uv_teardown_irq(unsigned int);
>  
> -- 
> 2.34.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise

