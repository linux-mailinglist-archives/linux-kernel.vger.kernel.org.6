Return-Path: <linux-kernel+bounces-396111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02CF9BC7F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39BF1C22368
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E51AA785;
	Tue,  5 Nov 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VkTiBz7F"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1918C93B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795133; cv=none; b=cN9lDbA/asnF65xOPj02xCEUJW2eZ1QR+UEi8BmWSNsZoa4pugNDA4js6h3QiuMGV2/l/+elZyeaJH0haPIDwFkbmm75/p3FBVTrJIl0Ar7vByRQW2matl1AFufa8zk1qA7S3KRr4UhSaibETC7G62WSoEZNTGL2R5se74O2faI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795133; c=relaxed/simple;
	bh=25JB0joO6/APWdWGU9npMYA29F9CUK1XLBMuinxiP4I=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCb5FhCDhu4HJo+Y22ELd+eSq6HOvwm3FvlHuPFYtfs/KyZEh4tDhpLRwMVgI6zR8x+IjTPBlFMsEzmI8Yo0mIg5YYbkK+bUtQvpsTLPcLxm3C4Z/cEcB9SnX6NJx+oKy+eEGsQIJ05bxKuen0Wvpd6aniy4s8VDEdMIceAMP3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VkTiBz7F; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A56uQvx022315;
	Tue, 5 Nov 2024 09:25:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	25JB0joO6/APWdWGU9npMYA29F9CUK1XLBMuinxiP4I=; b=VkTiBz7FYMa5Tv0k
	J+YUoTY39W91PJZv+iyDXEEiisQF037iGaJ30A/fDNHsAdXrRunxyQhic9qSqfGS
	BCUJbeWwFQ+EgdqBIRtlfpGEEgcwRiHdRHWwVuMhvSBoxF/Y8YxzgVLmsXwuPiTO
	GhSo+OuSmVspehP/HsL1gIr080uRnIkrjeJExPWPQIBZ6GJnMf9nRMnogDLLAlwJ
	d0sXxtTiuAhevV7OMmuw03ewYTYlEwQLoAB39fiTLZlDYXp0IejQfysKNCxT6i1w
	K1uje9cgzoM40AkGdWlhnM5KDJD4yownykkP7Sz6O8dexHYomgJIZIZ+O9nkMGWh
	fdx1xw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42ncxbu10k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 09:25:02 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4380240052;
	Tue,  5 Nov 2024 09:24:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 787DF24B194;
	Tue,  5 Nov 2024 09:23:44 +0100 (CET)
Received: from [192.168.8.15] (10.48.87.33) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 5 Nov
 2024 09:23:44 +0100
Message-ID: <008a261f5407ab38bb025768624bdc6bd1869c84.camel@foss.st.com>
Subject: Re: [Linux-stm32] [PATCH] irqchip/stm32mp-exti: Use
 of_property_present() for non-boolean properties
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Date: Tue, 5 Nov 2024 09:23:43 +0100
In-Reply-To: <20241104190836.278117-1-robh@kernel.org>
References: <20241104190836.278117-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On Mon, 2024-11-04 at 13:08 -0600, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> =C2=A0drivers/irqchip/irq-stm32mp-exti.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm=
32mp-exti.c
> index 33e0cfdea654..cb83d6cc6113 100644
> --- a/drivers/irqchip/irq-stm32mp-exti.c
> +++ b/drivers/irqchip/irq-stm32mp-exti.c
> @@ -696,8 +696,7 @@ static int stm32mp_exti_probe(struct platform_device =
*pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (of_property_read_bool(np, =
"interrupts-extended"))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0host_data->dt_has_irqs_desc =3D true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0host_data->dt_has_irqs_desc =
=3D of_property_present(np, "interrupts-extended");
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}

Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>

Thanks,
Antonio

