Return-Path: <linux-kernel+bounces-210386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7019F90430E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFFC1F23B73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA25BAF0;
	Tue, 11 Jun 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ej6UaA7W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cm0Rg7oV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519459155
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128949; cv=fail; b=cc3x7/bWXx+/l+DAOKPgCku4fPD2bSAN1SrJNZ32I7mWCpH4xrLanTTXrQYFtN6+5S/XPTTPJvBvXHNQ2kaaVtcsGIwmEI74BeU6puo+88/+Z35+g3o1T7aSALN3rIsws4L3e1F6P8EXe9iTS0w/rtWgiHY5K5AjQrhYTDEDIyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128949; c=relaxed/simple;
	bh=LETSl4nVh7EvsMCDkjA0LHVCgEsZ/KEoX+fhPqA0Nvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eE9cebA5u0w7z5GkflNfmzCWcnLifEhB9KjKAYcw3tC6TR9QQe2RzcrUsN65QDPuvt3H7kqySuT1ZT2caBL0gMUYgtV0ZQPPY8Ubj7YAKenfw/bRwDPm8KX1hmW/hheqPrQkvG4pvbrPhO285DoZTlmB/1g2lhs9U4IqFyLQaTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ej6UaA7W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cm0Rg7oV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BG26sZ013369;
	Tue, 11 Jun 2024 18:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=i5vn5hEThji5R3Byq/r+9qaY6XKYUCF5aSw8TtdOQeU=; b=
	Ej6UaA7WakWII7uGuPy7cXC9fUSaFgHeB5D/xp+Hwp+jSxLerbqDEl5+3EqLSxIg
	TdfNwX+qKyeiFeMz2WC5/ypf6L+lVVxXsvqPBw6sKjjcjjFileWAgUjEO1+SbBoi
	M6yITD2QLEBvRcf4pRmHPz+ymVYkowZcKGaWJdboafuiTIg+zZ9W6phZh0rl5AGl
	CXsB86zSHUQwY6XYBiRFvaHu3bbPQYmoBAwBB6HI0j7/h2yLcLLa3Q+ZWeMuYd+E
	ANm3S1g4qVdl1Un164s+J4ZXF+RvNxivzr1fs+DreNAIp3F+U8C2MBQbasXIZudo
	ZxHU5Ojdgg6jDsFHNyqnQQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fnd8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BHw4A0036562;
	Tue, 11 Jun 2024 18:02:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdwm7x9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCb/vI/aeK5isp3V0Z5w7nWwg9vs5Ut+vi1TPg90QZUnBoaZPb0x/y79jCyyxQe0CcPNHAYP0vTLAr0y2/7FhLApQpFZ4s3LJtEAS03ssM1m5CswkzYmnp7dg4wREkbUE2Ecd2dkLhDVGLYBpNu4a9iKWhlZ3OQ4QjnhjCANg8e1mdSh5tTf/blm/TJYEBL9X8PL1KwF6rFeEoC3is8OuoEnA92hno4lCX0feiR+xoORROpufmWGlgqvA5w2VlsMJ4KoqGPWfcIcX0Q7ubL1XiEfDeAyvS8folHDrAmSxlD4SH+zb5/nmyt8GVAorvD4MvN/vH2Q2U0sQn8mnyglFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5vn5hEThji5R3Byq/r+9qaY6XKYUCF5aSw8TtdOQeU=;
 b=ad9qPwDpFMuqCHnqmteSxOuH8MgpcPjndM0FIckRfdIOXuSrlNrxSJJGysXO1trz7WqxJX+aeBNsykUS837o4cuHEPB6xEi9wa6pfymyVzMJW94mcCzbYqrGGfHddt4y5rGa7oisvWDzxg8mkf2N6RKIhzr6OEfJ+y3GpUTCm1WNfPTLM8P2U4qNbDn+bXG9dQPDvCjsmxgeZNO4QKXUnpVhQCDzPpqhv7ie0j1NRGWdHveIgzVglq5i2qCJMOlKTr/8GR6bjYxav7/giSkCUHTDCBCpVYmd3TNbT0LzrOxpS2XQuWLGU/8wE8XfJrj1TJoOjQirec0+ZIpgmu1puA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5vn5hEThji5R3Byq/r+9qaY6XKYUCF5aSw8TtdOQeU=;
 b=cm0Rg7oVqMPQSXmbgmL9MwkD/91sIJlzjrxd4cEWt2e9flE+2yTftSY8WIJPzeBrd/EvU+Gu/s0CcfpaSbzKFSvzRe+WLGxU+lk7ORFhPG0yzGcA9Rus6mCgjLXk6R5Uw3nOwFTO/ryWdsnZEsE4m5vDRMZOK21IqlsdaNaOL58=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:02:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:02:17 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 2/8] mm/mmap: Introduce abort_munmap_vmas()
Date: Tue, 11 Jun 2024 14:01:54 -0400
Message-ID: <20240611180200.711239-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611180200.711239-1-Liam.Howlett@oracle.com>
References: <20240611180200.711239-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0026.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::8) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 3559d057-bcf3-42db-9883-08dc8a40a082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PQFqcV9XLaS1dyRm2KHuEOfQz9aW00Dw++3LCyxMQyVmRkYLUMj4yujGv9Va?=
 =?us-ascii?Q?BcFruDm7U3Naz/mu9voql9HP/D7ASJvSpgBlolSlAGMC+F4b3PyBXVst2+w2?=
 =?us-ascii?Q?qK1QD+zBheaSecIRbLjJJZBvy977aI3w1pKjLsPAS0Wgbm1a3NYQjGVy9PsB?=
 =?us-ascii?Q?aNW6YA6ajii9dGR4ZH2XX/QAtvkppbUO9OdtTWfCaHLD1i++Z2/NUlsF/evc?=
 =?us-ascii?Q?USSBnxYKca0rixEiTbRYAm7njmirF53w0ZaMSIS3SQ4KJOQMBW5AnlUhLoGC?=
 =?us-ascii?Q?zEgEA7FZcwx52EhCFirrWMtN7qS/TLzjGfpW8Sqp890hEqXceF5cT+YsJaU8?=
 =?us-ascii?Q?6y0kjyVI2s5duvKbCo+RSw4wTxvFzeUZgzWkG83Y1zIFf9MCaVZ581CUHch3?=
 =?us-ascii?Q?xejyTA2r68/6ncMH+Ri7KfaZ+TMxBOx816fOK13TRSzcQBwiQCKTVu68PVA6?=
 =?us-ascii?Q?i84B7abT8p8F+QSWxMX+B94uQwgSncP6uz6KOirRLNH4zH2CgT8KaQBFMXp/?=
 =?us-ascii?Q?k9M4lIyTS+ATljOPeYf+7RwxVI0BKKcDFD3ww+ueU1ARazMR0uv5T0YSErE7?=
 =?us-ascii?Q?R/rohaEvzGTCSu42aNQg47sftoxODxMmfMzYFNAVDZL6b97vflHPtKoy7IAj?=
 =?us-ascii?Q?BMpmCsINlscyWVYxx5kGgWNZo+6DXwcqXRCk3ApEpSssyUNzZ/ET+MGKx7a7?=
 =?us-ascii?Q?3LFaFKeMg6WxFTStzSab5Ocwp5qz5mDjsvFkNFLxtlmdNF/m7pOZw7I2RnRp?=
 =?us-ascii?Q?GiRe7HpMCWh04w4f+yOr41ZWq4Ysq4+20srtRVwWuiB0gvWRxtorahkKrq46?=
 =?us-ascii?Q?aSIyZTe+vErQYI5NCkAhS3GJdmKnZDhC9v9DyjN74aLn+L9vrGqo04S0Qgkp?=
 =?us-ascii?Q?uxp1TEYq4LPLdeHl9mOKWvnW280biEQpz70IviMlOIAkxi5907DYXrdRl/eq?=
 =?us-ascii?Q?12811J6RiMiEsrqOiZCCuGVgCJeNVLEqGznZWzBQgpQcuD6kF0RENAXcPeCx?=
 =?us-ascii?Q?dwwGZObMcgN4rnIfqgxjqxQB4HvICCFVwJY4vgXHYq7txTX+UAV+ulE18tUS?=
 =?us-ascii?Q?wPabVJdSnX5jg6NP4Rv2Mx93O9R5qlOzIgBHgzClPyvpgJaAVk5eHj7pVz9k?=
 =?us-ascii?Q?ZwzD9Lwv0zkSEp80eZaz+cVLflm+s1s84Eb/5v/BdiO7vil140fesAk/axXa?=
 =?us-ascii?Q?AsKyy33F3qljbOXX8rMKPESXRYT3OfldZzDmRR5iVJcPJllaaxWvK0FN2ZKW?=
 =?us-ascii?Q?BQ1UCuSYOBbMxjfq6rlyZsNs4JfC3VXWg9jYJdBLF1DcK6NbqYTgI8maQZYz?=
 =?us-ascii?Q?taFx0HBcJwUJqaai0zqtAmfh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XmYJ0Fq+APNLE24qeLX8/8dbZn0E2QxmMIPSM8XDoRu+qOsH+oFfPhXvRhI6?=
 =?us-ascii?Q?HS/N9LXPlVMwuTz19bNamSbSFoWEbivl8Sf+S2cLde2C5JXvRi3/iLfSiNxz?=
 =?us-ascii?Q?Poklw/ZB1i9x4RfdSIK3B/fyEvTXAuF07wfdkS+Y7/HPsjBbXKm8Y+rS7rbx?=
 =?us-ascii?Q?33k1F0JSYRpwMn+BDYsyNL+et2Mfuo6GQJceP5kaA/w3sOF+Vc93z3DARjcE?=
 =?us-ascii?Q?WBysOuYJnBnmEbx6vSoJ9G/E/0azvirOKXN+Q56thU5Fztw4frp40RbVxg9k?=
 =?us-ascii?Q?XAYISdH2Izw+M4eLTr/0FKhNzNO3ICAnOOsMUL5g4mKbWh2m1oc++3anJHiI?=
 =?us-ascii?Q?flk9MuzO4EwzxUTXKnA7AbElwd/Y1WTKfkgE199u81VnWZjMU8bxD5pE4a9a?=
 =?us-ascii?Q?Lt8fcCoHmGjgFaktoxrtS6lNs7YGRI+duh+Y0VBf5sNdFKtvwBu6O/C/tB7W?=
 =?us-ascii?Q?J4Esium60M+XRaC7WpvqazCfSwVFm9uY7NS1nQ61qSUipa56XL9O/mKyamlS?=
 =?us-ascii?Q?ZCf12u7XnaCEz0OTK8SEAqzsSByaayM4AQe0rAe2cBARUIaxNAOWnV0DbTd+?=
 =?us-ascii?Q?6zB2fhxuCjnqiBmVd7y3haLmKSUGlIzZXC/IfiIJ/gfGVgygy9sjNDNgEXJI?=
 =?us-ascii?Q?c2tJ6W3P126foF6e5L2npBipD51OoqE0en7YjAiOpY4v0zpm27laYnKzMLl0?=
 =?us-ascii?Q?InY/15o7Yjjozw17h0Kq1d9pyMEDRvfrFNoHJAI+I2yTV59X/8Yd4q8MpkvV?=
 =?us-ascii?Q?AmDW44533W6TldF0DUNGG06+rascJI4Z+tvMV4b9Ine6WhXUa1IDjolPC4P/?=
 =?us-ascii?Q?kjSbVU6gZkHM9AbBgtX2/mM+3jVVznwYe0PbsVi957x6bhKdZKafi6uOcOQI?=
 =?us-ascii?Q?0XUSyh9xLwJ7ugBXH27wJ7Y955zJaS2pZUmtx+6fI0vPTx5+eYwNFwiXIQHB?=
 =?us-ascii?Q?8MJgbWzzoeyRxRAXxcXryUh+jRxWvfuqkUMO/+yYYUzXl4oJ/TJnNM1DzVmL?=
 =?us-ascii?Q?TUmzcXCJkbowl7bseEXGtI4UiNSz+2yDZQhet/fT0cl9/OhPz6Qe1QC2xhXM?=
 =?us-ascii?Q?ge3wEd9EFZXl8O1SAuWsVE1QwaqvZNyAvmC8ZMNo1BFUZWOGnitv4OzUk6A7?=
 =?us-ascii?Q?APi1OQAqQTCUMzrHAV7Gik5Epr/EED/1qyx9+wd7Hy0UVyjRmLpB34cUQb00?=
 =?us-ascii?Q?ovDUYyhyv337DgK3bNnDra4teRg7gJRWOuBHc0vIxeSOHVtcDjd6sTJz7Rn+?=
 =?us-ascii?Q?gFxpJlqB8AOFPDPUfSvnrtynPNzvEfcci/kjkw72JoCb2aaK2End83peF3DI?=
 =?us-ascii?Q?HoMkaCG95VzUcFYzCMpE4xY3EPUHcYbFslq4G6efrGsRtA92GFyFJbwJ/Itl?=
 =?us-ascii?Q?XDAiU7fww6ORZqh5cR6mugBWDKBeiyj+IBjG1AMx4BhKSECqKzHHOPdzI+8o?=
 =?us-ascii?Q?M/mOIwKIP+krCuHmWdVVFVGCy6fFXxlFMnO0MZHi2MFr2zxSLlm3XtbfNcOW?=
 =?us-ascii?Q?vg2+vksn8fJ2WbPTUgNrJhGQz12YVPp46hzLf3zGbiLOXh692avZuGiOkZUk?=
 =?us-ascii?Q?Q3468z1kA+dA9E30/1T4105ftuVqtU9NWfTkzDIK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/Doz1UG7dPkqjElFhDk0LKVFTxdprTCnHKEdUgXZOIQKbw+pcCPaDWlefBHJBWdvon/1cNssvUfuefIzHdBN/nMtdtMi8qsQMoTkOEUxeMmXCDQfEHXtsflV1Fz8JWwerwbA6gUkmBM+q2XIU88YEaTl8YAGZCWIdkL2dv+OCRv7dgfbQRZKvvEztwPW5Uh7l0VrHm/Ayau/uxJJdRi5Tq88IT7p4NaVTEVsULPiQccZHYXY9lItwMWZDsZtni8D0+9T7GMvmC8HQobmcc17L8fKgqaYKt2VaBViSPZln5zoKNy1szlBkBgtAhd0v9ujfa/GoYFNH0httWOaE4bd6L59+rA0JczNdoyM5ceha/w9C7GZJpvKngA7JXHRY/a6uIFIRSmiR0cCg8ikbih239/BmSKtBW5Ny1xUhBAT7RMS9rPtk9xqIp2JPyqNsKQTjHMFlNDdD97cPQosDAIpdkrUKratJAnvrkpmpkhSe8fuFIXMbE3nfcg/ggHVJPfmKuGpHWhUgGB7CjJ54LBT2xoRD5YspxWRVcczTuUN2YTkASKd3CbU96MsnvAe9j65HQXuZegwpL4i0eNol72iEbRSAzBOOJlYsKGuUN/Zlpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3559d057-bcf3-42db-9883-08dc8a40a082
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:02:15.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxOh2QT+0CjgojXEr6WBriv+PdGEYwKTJCmyuWLwXB52WEDwwmDkPxeNnaGdR+lisPQ5l+A77tKMkOMvmX8urg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406110123
X-Proofpoint-GUID: ViI8sNpOhNVne46ufb6JpFJJwZAeuOJq
X-Proofpoint-ORIG-GUID: ViI8sNpOhNVne46ufb6JpFJJwZAeuOJq

Extract clean up of failed munmap() operations from
do_vmi_align_munmap().  This simplifies later patches in the series.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4a9929bc18bd..bcfcbe006b1e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2545,6 +2545,25 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach detached vmas, free up maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+	int limit;
+
+	limit = mas_detach->index;
+	mas_set(mas_detach, 0);
+	/* Re-attach any detached VMAs */
+	mas_for_each(mas_detach, vma, limit)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2699,11 +2718,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
-
-	__mt_destroy(&mt_detach);
+	abort_munmap_vmas(&mas_detach);
 start_split_failed:
 map_count_exceeded:
 	validate_mm(mm);
-- 
2.43.0


