Return-Path: <linux-kernel+bounces-430839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D209B9E3660
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A56B2454C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69133199E80;
	Wed,  4 Dec 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wC/dx5wa"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD82500C8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303487; cv=none; b=JqegxXnKAznc8eUFz5BNCpbZtjMLf2Gz1783c60xE0uDr5PsL29W48dSXXZLT2JtZLv1EBjqQpZq2fXUAC3ju1Gum/SRfqeh5v5n3OL/rEQlNMKyLenp7GjHJceYqm0bAf3b53MiOsxgLf5IeaaIHbAR5IgxGz4XCdAT6cXUl+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303487; c=relaxed/simple;
	bh=uFPwSyG/JkzLTxtxg6Ctl7HEGoRQFQHwizIpQcLBeGo=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UNtBc/oylLbpzueR93peKoJGv4k4KhBAhaz3WDpSMQzTBwU1rjaar52LD4bUueh9tzHbDd52kUrk7/nmrhF4LFryq80x8J1F/yiYujTrIVPF3pnahdE3nwQFF5q+Sp/BYZFRma+qWxJnP01pLq7NLJa3FL1yB6BQcz6kwMNJDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wC/dx5wa; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B44c1Wx023405;
	Wed, 4 Dec 2024 10:11:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	uFPwSyG/JkzLTxtxg6Ctl7HEGoRQFQHwizIpQcLBeGo=; b=wC/dx5waZTaQVQVx
	P1ZdaQ53FkYiRrK60dYaSGPqr+pNS+s+mSG4azAWTFgyEtORXiOfjcfRHFZfWAy3
	2kpeOJ4C3/TnjaikF5i5Cj5IyGrvGO8LbLYVBs+MvWQ6OvLjVryoEH1BzN6la63f
	fgtOZMezUKdXqqZt8a9WF9mucXUyWJbW4AaO2CiN7zgCE67S9paNOVEHrxIyjJkZ
	an+QGcGPx09Oo1MMN1Rsb5ZXUeVqxNzbzLibJlms7n0vYTW0FwGUjiMTrqxqp/BJ
	y+VtxKs7/LqiJJBUn/ahdLhZro9+PQTn8GWFL2JRqbN3u6ne8ynM6Mg7v/G9d0FW
	juQRug==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437tfghah5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 10:11:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A8D1C40065;
	Wed,  4 Dec 2024 10:09:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D33962AA42A;
	Wed,  4 Dec 2024 10:08:03 +0100 (CET)
Received: from [192.168.8.15] (10.48.87.33) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 4 Dec
 2024 10:08:03 +0100
Message-ID: <0ac673bbbb63450fefbbdef15ae9bb8fb790589e.camel@foss.st.com>
Subject: Re: [PATCH] irqchip: STM32MP_EXTI should not default to y when
 compile-testing
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>
Date: Wed, 4 Dec 2024 10:08:00 +0100
In-Reply-To: <ef5ec063b23522058f92087e072419ea233acfe9.1733243115.git.geert+renesas@glider.be>
References: <ef5ec063b23522058f92087e072419ea233acfe9.1733243115.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On Tue, 2024-12-03 at 17:27 +0100, Geert Uytterhoeven wrote:
> Merely enabling compile-testing should not enable additional
> functionality.
>=20
> Fixes: 0be58e0553812fcb ("irqchip/stm32mp-exti: Allow building as module"=
)
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>

Thanks!
Antonio

