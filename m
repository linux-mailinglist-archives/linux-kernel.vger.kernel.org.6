Return-Path: <linux-kernel+bounces-308007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFBE965617
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCAA1F247C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53414BF85;
	Fri, 30 Aug 2024 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eC9zapJv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OIwSSGNT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7C13E022
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990490; cv=fail; b=qRr3ANx2KFYo3SULBFqJZCo4pEzLFT8VZqMeqQ2RPwfXcLnTdMukivGEAH3zQ2tejLH3ZZRuJCVtG51ujk6MS5qIWQ6K8ePFUrTgKZQHIZH1Jso8CJ2PzJHQBpNhttXbzR0lYjEeae9LY7kdpd4POVRGX8VsgsyRno5VNUfVUdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990490; c=relaxed/simple;
	bh=VOUDrA/3pOEobvQHsjhY4Mw0X+i5TXp10gtl99DoZVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DnRMy4XHqUPXUu/I0APPY6v+347v+fqt5k5/Y7B5Z5tCGZujmFGarz4f9sbVMFm2j0al52BQBE/G5/82kwxmIOsOkLNccGmwqkmrHcvnMnr1qq8l4+QOfp5AkTCm3/V1lo4EUe8R+LG5qMAJVq8uhhRzc054V0fu7PUwOX2Vzlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eC9zapJv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OIwSSGNT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2fiFW001321;
	Fri, 30 Aug 2024 04:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=WZRaFvqKhmeZGOgIn0cNM+Fo1hKAtKZhH+jC5oCYViw=; b=
	eC9zapJvxyW3cugG2HVSrnuBJ6J5m68xK8kCdiDrbfV1hohw4vMmlLNkYaSMXCuG
	gyHj4ilkSr7fLDLKng16e27hCSSDBXw3c+fvxZJr+4y1hUqsu42TbvpXDP8Rx2qd
	KhSGCG3WqDzIpY/kui4fpFevlcMorojgPjBI0QlZWzM7ijl+yC5orvFmYHeMlnz5
	3XiX+6cP+53cW8KHZS8oYjrL9wgI2N9PoepiXXMjrTMNMHELCX30AFLpqeEjVCGp
	ia177EqKs4/ckE92XMCHlcB4D9ivmqlUPraLQqu8l6S8MREkiJhTya6Vr4x4nrOl
	fP5UKA51w1U00s+l0VgGhA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b25qg882-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U0URNe032483;
	Fri, 30 Aug 2024 04:01:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0xj8a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFnQqHYNEiXLZ+XpXpRWAa4icArX9Y7CDlrIgiLC70cL8siW+JwQPzAvUslgxLtXHfW3/M/4LUvULEdB0uaqP5UI7kp8JLaPTKUj81PyObrMghmxMMG9UCxK4hFHsjlqUcZqHvuVAkhDCMD81S0zumfLfRpA3PgRHKpXPrSYw/vhFgNxvtS1b2HAmp4DSqhrxZp3jCGONlXzVraNln+s5Ci755pvAIi6raTUqTGBx+fYWuWxi8wdBT1pR21KPCrZ0SzYIgYF1dsabYGX4PCqOIqvAP3VunvFiZSknbIdXVe4vAQ/1JXyaEGhLHp2rWwtiqP+f/C61GULc9+QgVXGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZRaFvqKhmeZGOgIn0cNM+Fo1hKAtKZhH+jC5oCYViw=;
 b=O/2bRHgXXdT7Y747TvCV5GpUh2FYnZa0t2yl3lipRDdvlGd6Wkx/drC2XJpVpOGTg8RHoP0RmJz54qsPBIzNXhy7mCda9Gr3MEYbF6kSTr8joVOM973v5yCQ7/eH5eiXJALNEO6xZoaq6/lMTIqa1E9nGl+7U1ezQGng/ZDFiyadJ4KQqx4PunD62yvhyJiGXerxpjgTv9gMQAEqh5uC24Bpkjx9GLe/0T7ya1iT3ky9blJRoI/sytIHxeSB6lemwThIu0D6rUBzSPnCvf1rTXRXb54pCHcbYRMphJUp6ltnpOL1ESiyJjuK5WAO4Gu2KiFCv932vypWy4ghnyBR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZRaFvqKhmeZGOgIn0cNM+Fo1hKAtKZhH+jC5oCYViw=;
 b=OIwSSGNTN8NtAmSI/XdH4HeUbYJe9By5V64xPS3Ixx3EXCOGucJ00QsIBnDmrFN9LE/P5FhAFsvn/3Q8nD/lpZQ73Vg+xodc9EynkWs0x3uP9u9oMh7rKPqzV4GYAXpRXd9PjwiLh66QuftRjAeNHd8qAw1C/Bepc3kPUsLL/X4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:10 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:10 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v8 02/21] mm/vma: Introduce abort_munmap_vmas()
Date: Fri, 30 Aug 2024 00:00:42 -0400
Message-ID: <20240830040101.822209-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 5906c6d6-d9c7-490f-cad7-08dcc8a861a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pSBls0z6fsGqUQzyVkFUnFpiFrIEgb+l1SmFKMP+vxuV7K679DBrlmcRBYbT?=
 =?us-ascii?Q?StnzlKm1MI3P+wxX3gcCapZIG7TBrlshAQIyvJz0EAkoyL8VUCo7zwU6EpbN?=
 =?us-ascii?Q?KSkdSTjSg8zgd+yK6Fqf/WK8BG4tDF0Hkp2dKWXyH5pZUTPYr5yPDPCHxamO?=
 =?us-ascii?Q?3NIHLA2XySuo0P8EH/F3laib3Miw5fVoFacOjE9BEnvkRJHQ+rea9dm7xKDJ?=
 =?us-ascii?Q?snDC75NurIEYNdu3IcsEsUIzk/S+AxYOPVWrS5UM24AKFnYO5dNRXSTI4qRO?=
 =?us-ascii?Q?zLPAujlxla7KD4e3cPRtVvvR8M2O+Zg3hDDHkFlC+RTu13IKbdcyd+u9HXOM?=
 =?us-ascii?Q?RTFn4AxaRzsP037VtJYbvzB0fQbdWKK04+KKSfiirL7kl4/VJhw1zXk90InD?=
 =?us-ascii?Q?H5jr74JgZr0jzwH8N1sCJ1wSZa/53kWBDgM67XqzQLGoKp0upff7fis1Hk5V?=
 =?us-ascii?Q?NzHUJAihqMDdU5HW8nAowuh+iIj4DxBppgWT5o/1Oq6AMwW25gP7cpUolkpd?=
 =?us-ascii?Q?qI1E+Sq2/yVeExiOxr06bzEokGU0FmEp8KXVZrSrHM3XtiJya2Pq0ysOe4Gx?=
 =?us-ascii?Q?Trxsgk6VIJIPTERqqiG9Q7Pm8gkNIQ3GI8FFMwi6R//auGhY50MwUGkGCN73?=
 =?us-ascii?Q?rhKctmVGkdSfW56Ah5fZ3SNd11TQNu9ubYLzetV1dYaFoMnzvYK6iNF1F92r?=
 =?us-ascii?Q?7I8KgRPcu4KPo4i9BIthV49lrsUXU5Ol9zkM4JUijjIbdlSYSUCCSA2KLTfC?=
 =?us-ascii?Q?dwqUAAExGvy/J5y8roTSXfuCHx38dNJ/3DPEcne5KKhlFJ5o2j08Gb7QOdeL?=
 =?us-ascii?Q?7pUK8B4niaz/9lCADaDoHuNc+K0YYrKr2Q9F025lM9UXawmaA4jTh9J1yuj6?=
 =?us-ascii?Q?LoQMzfw+XJ4aa+lFl1l5rK38KfPhN2Hg8FbzV4AfZCIklbpfSMLcEEHueAeI?=
 =?us-ascii?Q?EdLzIwXICFEq0dbRGzy6LVkCQQI1k6lDa79tfWz8dsCGRyxCX0v5yZTDOCH4?=
 =?us-ascii?Q?NdkL/DjbOSnPZ9MQWoVf9NR52xeCc8y35f5nMKxQSVdu+Tfbn5+M5YgxU3eN?=
 =?us-ascii?Q?mV77vJAr27jpKcCTK2AP60Fi2ZZU2xY2TVUBWZon1fYifHFZgmHjUNo5fOPm?=
 =?us-ascii?Q?MTTWFPRMZOYXlH5gH7B9XuD8Hgme4d/kMvUXtD8qXDwKWerZP+Y+Ggfjvxoe?=
 =?us-ascii?Q?NOY6VyCf9xBsiHsF6jh4rj/VwTqlYUulsEWDJ+UwTYBmXeyxbGHwlka1cZ3g?=
 =?us-ascii?Q?vsA20sbdrTMLu1NnEhuB6KJomJqZnGIz3MercGiZLgE4eL8zeiMkItNKVj45?=
 =?us-ascii?Q?Xw1MIt1Xo5ZylyjxlTkIRzQ78SSl9F55H4OVi8SMRDglnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0yCsSBYJfGuPp5iE2ASZdEsEfVSUvPo70gzw7JTvGiBuL2unqdHok7cSCuk?=
 =?us-ascii?Q?VKTQLYBDbWlmPJDwL/FZcMkeuL2GUvXAOrNkx+AeGSvvHX1JYqiyLapmYkpV?=
 =?us-ascii?Q?mFa/NbTFzABcI0EMzKkGyf6/Y7tcueieENhUfqsnHiV8/ZSWmqn1CnB66qsA?=
 =?us-ascii?Q?TD4mfjDUps9K07jbbIUvVqYgjQ/5ajGgEl8btQUmdwXVpclesoBBFWAUypDZ?=
 =?us-ascii?Q?juvGuRVdaIv9Rjxhs1sWT5sVw5AijEH9wbxj0oKMhTuKAkqe471m4zeQAvY+?=
 =?us-ascii?Q?9rfEiz/prJwlKtAzb9AlOJKXNK+t/Y+CD9/5esaGrHcUPCnVxB3V1xOBI4k4?=
 =?us-ascii?Q?5X/wNlGfdXV1EPHVW89upS3eWFp8p4DPPdNvJhYAXrrj5WetrpUU5N2M6vX9?=
 =?us-ascii?Q?liOBhi0acTqYtu7mSl24RgLmOiAYvyIfdk/7akDRzniUnQ7Mn3+43xgFXNun?=
 =?us-ascii?Q?3xTonet66AA6DYUYRslMeHsxHghFn6xH57nAYNvctuAeSu1cA098HcBU030T?=
 =?us-ascii?Q?RidVYvGxi+Ko+xaXxcBg5+3o5UKPuR/cpf+HTphSSYZi7m6h6gHwzrGuIKhX?=
 =?us-ascii?Q?yWfycYrYMAKBtUrUP6ZCTOXpB0rmh7r2d5BxohWGD11OGb1IHjgDb3IaFTdw?=
 =?us-ascii?Q?0LkLm5yXkheFIx9Clo8tNKVc80PAkXLTBo83aoyH8pkcipdKD4Jku3i0luaP?=
 =?us-ascii?Q?YniougzR8iRa5XmfzKRkPlUxPe03DAJ4BfSdWPAoHEKrYVZCknEFtXCxy/ah?=
 =?us-ascii?Q?jmAgpFYcBzbCG2Lo69JEakFWAuvs1bzhGHBKOMyjXAkZYm51HgMC5sdgLEUN?=
 =?us-ascii?Q?BM0/x8fCUCRo/NQoMckeJD+zgpm6Yf2FdJHDA69qJYDdf7gfOt+ytt6XCK5W?=
 =?us-ascii?Q?pgnfGfG3h5tiVPOvvw42uKkUpcH4RZxh71p3z1bgq0sKClZIQvxkkPEkRtcH?=
 =?us-ascii?Q?iYTNf9/C5OMerpHVqy51SDDl89hMEaDxumlNH0cBSZjS6HH6WiDZ8wvE6GfP?=
 =?us-ascii?Q?+AvurYDwpnPf17XHhw3IZlfopiz6VkW0te9bblQ7d5wEo91YAWBRudFq/rFP?=
 =?us-ascii?Q?uAdx6G5Zc1HkI0hE/fDkzH+YEn7hZKtFkvnA2pqG9ud2QSy1wNJq6OMN7d51?=
 =?us-ascii?Q?zwTGYxE8awgSc0UtgeURtsj9wfGCUH3rAQAX6bQQ2i73plmTwuk1pm6N3Tqr?=
 =?us-ascii?Q?3NBcEvq6iTRU+5dcHoaF2IK09mzXxx1FQTcTnjYA8QfOZho7cRb3FHfwM0Ve?=
 =?us-ascii?Q?KCz/AZhbXiqeZyRsbnWkD2eONeWhoXYnPMVBKmhiPAqikpKAcleQPSPxfKps?=
 =?us-ascii?Q?EumtoqfgImfxXjjoUXIuH1gbvSfqBtv6kxVDuAqYDQCX8GymRCexuGlYJSht?=
 =?us-ascii?Q?9W+8fHu1bqUVvOUU35fvlMmQ5JO5w/3TvdXvisb4CKDMfc6IZn0Q7Q7Nt5Ov?=
 =?us-ascii?Q?AduzANvMEGhB/Izhi09uRKjrSgen3ZqIafkf+EZhK4st25Jw5POfawDiOxZd?=
 =?us-ascii?Q?bYdxMly71E4szGzR8fGNh896RaxNHZmbm4kcjqibI/qYOz0zoEWAfYpch0Tq?=
 =?us-ascii?Q?n7L7Ax786wd9VjnYNe5mcvvEQC/9HhCDTRsZAyND?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ez4DOe9DlIf4igwCLTDkxB9OGUcTimFVqt0aoZ3AW8DhUpjZaqv7uFRUNpkmoDutUqYrl3G9dfMvxTbJNAw9s9RJiXyOKOqh9Lj32LK3ot0xx4bJh7YxE8aCsb/kpwZPKqDayPH8FdF2b7eXehg9mubi0RQA0DhJ1Wbwq0S8tFo1KSvrSOK/Yz2E2nqW+MtlbtpCJev+TsKpjVv12RXV4Y3ohfZu+vI+7Qmqe29clIHQMgWdoDKkliiwZaA/YIDVPoCpp+0a17rqHSWTrmDPi5gFClzo6Jgc0CR/mrAnyZ9ZiZ8l64Vvp2ZWALiJgQ2TRRxBhjaqf2c+6+EEPVt4e/B1WUBDKwE2uNsOSRmUeGT/icKZgltXbLqY5cI0MMv3uF2ZbOI9yZw2iMvXCbE4krN+qLjAnh3nAu4rgoNp2W3cojjEpg0AIwrivaghvPYL34E9oHCPNBj0+ZdWQUQ0FI5Ns2XPiNrm1ChCZsMp0znrZNdcHVHg5p7EO6c6lULt+ODyRpcU+UhES/VsWU1SfOuiwcHbODXfKv/vtjgDBT6Vzn+tWE3ZP4irhboI55W8uR4sr3urM8IYGWV+gqlZ7soQ+RBlID0A1LuLY/Xorvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5906c6d6-d9c7-490f-cad7-08dcc8a861a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:09.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF2yrXvr+qwy8QC0lm/7KWQv58v43QT0K6MmHMERigokz3rLx2+ProXNKZdwh9j50iGLiLrG0T7sNQapS7mllw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: 08MpBUmu_sHQCXsvpvdvRka9Xf9--INf
X-Proofpoint-ORIG-GUID: 08MpBUmu_sHQCXsvpvdvRka9Xf9--INf

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Extract clean up of failed munmap() operations from
do_vmi_align_munmap().  This simplifies later patches in the series.

It is worth noting that the mas_for_each() loop now has a different
upper limit.  This should not change the number of vmas visited for
reattaching to the main vma tree (mm_mt), as all vmas are reattached in
both scenarios.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 066de79b7b73..58ecd447670d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -668,6 +668,22 @@ void vma_complete(struct vma_prepare *vp,
 	validate_mm(mm);
 }
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -834,11 +850,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
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


