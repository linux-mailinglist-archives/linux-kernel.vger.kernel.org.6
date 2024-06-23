Return-Path: <linux-kernel+bounces-226347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23071913D55
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F381F21213
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4EA1836C4;
	Sun, 23 Jun 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mHvI5iQK"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981BF181CED
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719164391; cv=none; b=SP1wjpifIh8L4XQCIRXDNfWhIp/PzVvBAsrRQPjQLkCrmNj+k4njSwm/CAbZbNR1K6eRjNAZz6ip7u7ASjkk3UVo4tTf9nSX5AoCcXkL9rcf075RgrAUsgj6jph3MtEl8+NyhLwLvBrlKudQqSRy1kg/jstzWz/i7/Kc8ykZDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719164391; c=relaxed/simple;
	bh=J9TMkV4ZdM0Epwm9IEsv8V+QNbxwRffk7WxHdUlTbAQ=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RpB0rE+zwUjr9RK7Iixy+EMtS7vACny2+jvenzJG8L38cMUyfK2ijwvjAxAqPXfCogbrYdu8Q7i2Z0gZ3dhcWdySCMl1jfxpmpfbFeKiFNk8++gxe0kcfoBuRivi4JBHmYZEdYz8H2GTvpFcX+pBmiqro+OYC+xVM+GixUX3jMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mHvI5iQK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NHBVjM026625;
	Sun, 23 Jun 2024 19:38:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	8psInQVn9Me0332vc4g9dy61RVy3/pavE8OpH2L34BE=; b=mHvI5iQKUNHIm5+i
	PQ2PwoTrEpayZrTYyD9XtOMMDXTi4zXQNyw5fU8XeJn0XL4hnP/6TUEZzQ5w4O9V
	774FD4oscz/d1IrEn8aBc00zmosa5BRuGq0OuYKSGO+7lwHDzgKtE1HnCLscM//T
	LuKsUYixgwmM01Zd6vd5D+GNvb29d9B+p/T0NStyCLoAb3cXIr4wdDLrFzIcXcL/
	ZOApvk7Lp+e6oSSK3L8T0TznTEiHMoJUQPFVgBnist+8D3sATpdaYPYkEGS/hMqA
	klVb6cTC9KfTCCDVfffq9F+NAMIPgMqk91mfUWv1p2lRTmXtwSDHolWTGwedA4Jq
	12wJ2Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywnxx3spn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 19:38:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A11A04002D;
	Sun, 23 Jun 2024 19:38:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46C932207A7;
	Sun, 23 Jun 2024 19:38:14 +0200 (CEST)
Received: from [192.168.8.15] (10.252.20.50) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 23 Jun
 2024 19:38:13 +0200
Message-ID: <2ee5ec54d3aff6e37ec1245eeb019d52e6a3d63f.camel@foss.st.com>
Subject: Re: [PATCH v3 7/8] ARM: stm32: allow build irq-stm32mp-exti driver
 as module
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Russell King
	<linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Date: Sun, 23 Jun 2024 19:38:11 +0200
In-Reply-To: <87le2va7t5.ffs@tglx>
References: <20240620083115.204362-1-antonio.borneo@foss.st.com>
	 <20240620083115.204362-8-antonio.borneo@foss.st.com> <87le2va7t5.ffs@tglx>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-23_09,2024-06-21_01,2024-05-17_01

On Sun, 2024-06-23 at 19:27 +0200, Thomas Gleixner wrote:
> On Thu, Jun 20 2024 at 10:31, Antonio Borneo wrote:
>=20
> > Drop auto-selecting the driver, so it can be built either as a
> > module or built-in.
>=20
> How is the driver selected then? Has this to be done manually now?
>=20
> If so, doesn't that break things when starting from an empty config?

In patch 6/8 it is already selected through:

+	depends on (ARCH_STM32 && !ARM_SINGLE_ARMV7M) || COMPILE_TEST
+	default y

Regards,
Antonio

