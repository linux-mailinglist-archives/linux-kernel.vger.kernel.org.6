Return-Path: <linux-kernel+bounces-242822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767E8928D98
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1240F28373F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D000B16D4EC;
	Fri,  5 Jul 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HWPNhOck";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yd/fj4OL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01F81E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720204822; cv=fail; b=oNxVcoN0eUDYOUaum3tn3jmi52+5vIsiYWdm0o41Z+aFDViPmaqhoQMer2zfVxhSq5neKCwwsKHAQlMxWoUXX28mMDIoyN1z8wHHqrNE8byoEbSef6CBMVf0rJB+6z01A/Hqk211cgzn4QI0fmR3DPuPVjUqw1vIJvcVT1l2YvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720204822; c=relaxed/simple;
	bh=nqHqBU6DXc4D0e6IdL/ihTtJ8qzJ6ODjzZgTKgU5BH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RlrGcjAF3u8JIpVOuFEhIyvej2X/+NVZ291PjVXGvetcINird3XknfuQ9xMbp0/wZqc7/tp8UWk9h/YbASn8IHypdXUI+zqpD0MbqJS92EKAc+x5FQeEKJePz9kSBOtXsFs1IoR9EUWNf0XbzUmNLjBPWv7inest6Wl88+qnTpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HWPNhOck; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yd/fj4OL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMYZs007953;
	Fri, 5 Jul 2024 18:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=XXPNTB9o3rSbkxk
	EbyT9E3YfttED2SxSJA+MKdHS4vI=; b=HWPNhOckm9qK5bD6FCvbOtTh4kWwZ++
	3U9HXpmMUhVf1ux8RawdhcADJgirZDSFRlS71nXL5rO91X1+C6PBzyJdIhw8xTQA
	4j05MAL/Wnhtl4BFxMDOdqCsv61LQQ8yYqkyYvlfGVwydaQ3q/FnY6VMlZDHN6Ly
	sm0LJykQiTwzzswOWahQwRJYteR+skmb4WuSrKVjozD5peaVhGArhf88PWPdPnXg
	jSpPPhQEjoHmkHAKk4x74L4uNldMCrLf0rzmzM7XS0Zn0gXkuzZAyB71FiJ0qk+k
	UFYvQYxlNHoM7OPrqYb7FuN83hEzpxnx/n+E8iijn5JZS83Xsgmjc/g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgnxhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 18:39:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465GEwaK035683;
	Fri, 5 Jul 2024 18:39:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbcp9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 18:39:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFkuC4xb5G/HZx+8QHw5WF3KgOishKV9HLlRmdmHsoDaxVa1YKL1Nh7SYceCZPyy2pljV5mAbehlnXg8Ww/Br99BBNndtcxcII7HcayLht9frFtYaJLMfJjGU+DXP1MTwX6mnDOx6/D7Uur1oW+ebRvyQ8otUO54jWcg4vD9H14ScF9qebrweoNTwJQ+hcdDLWoKO21Y0k1eTMbEpt+x2TLWPjLj6A5mheaXcVtDO9svtobgxij/vDHlNERFY8H+TJBn/XyWsLyz/o+wfcywiQYHZy7a6Gldz3UMeu7V7rGRXeTQUhLgropfkPDE++kEjv0ZlWrNMxVTiMu5MiHisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXPNTB9o3rSbkxkEbyT9E3YfttED2SxSJA+MKdHS4vI=;
 b=GbmCjbmjAZYUH+oYE3uVZULzG4zf3SE3tRKyoSvNixmaJzbL4WqxNV3GFyH6+Yswl5Z9RuV/IRo9W0CXYmVF1TJjykM3B5M/XFLsEn/m80DLgPnZXcFBEA5UbOSiQnanUqtoUhtj35j8xh9WKwa4MjfcGe9UgiODTFweaTShAh48gOIruqRl9GaTBdCUVrJJ7S6Xss7WaDfU1pnUZ5uACYeRTf3WGInOHQ66u3dNNTqwhBPOvElCp3i2OLujg2GmpEMEgLpNwM4cR67uPLrlSf/cykPurTIsJIElZqvj7969f9en27EI0g2f6yihct0dfTS74CZtXDMySFXxOO8Odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXPNTB9o3rSbkxkEbyT9E3YfttED2SxSJA+MKdHS4vI=;
 b=Yd/fj4OLBd6igFasant/u3AnGC4V/zcKjZHI8SqrJxpUUgQSJTDxU30/k+t88RsfWV3L97buRxFpOGtHi8u3K9A78ubZKwK08CmkuM5TqpGlse5CttQE6dq83XFmtdWSBrtdicBJdS1WWuu+njI7HLGzPUonce3YCVPXkThHMNw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH4PR10MB8195.namprd10.prod.outlook.com (2603:10b6:610:243::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 18:39:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 18:39:46 +0000
Date: Fri, 5 Jul 2024 19:39:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 05/16] mm/mmap: Introduce vma_munmap_struct for use in
 munmap operations
Message-ID: <a1f1e48c-5aed-4c03-b4d1-b4d4ac85a6de@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-6-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-6-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO2P265CA0514.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH4PR10MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: f24f7883-603b-4bdf-c4fc-08dc9d21d7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?o9twvgqBP4TkJ6wDSogBy2vYYZ0mi4iysrgUDwi/SWY+sPuUmHT4BXb6s93Q?=
 =?us-ascii?Q?vI+RLrqIV8ONb+tvCb77v2To43TJ964Bd8JxHHEOL2+3kQPC6cvnpLmg304/?=
 =?us-ascii?Q?2X5/wgGxVmMRJeHwZfhEMlIHNzfW1GMhs++VbD9qqU6XeJEagr+Dr7MTWDwr?=
 =?us-ascii?Q?RwEGebqcSxI1WSg+VvX0FDs2UJtckI9X6xEQNhT3C2Bfrd0AutrcedZ/XB49?=
 =?us-ascii?Q?SnneXZs3inwFBdS9WxB4a7BOYTrGkGw/rgizWpSlQZCeO0OZVsN+BLU2GmqV?=
 =?us-ascii?Q?eCI0Pqh1tIMwqIHTvL85IoqLVsUW9WcGC7A9zzDh6pCuW+tPjqC67Gq2kFir?=
 =?us-ascii?Q?rioMLSCv/gyTXDkdNDT1jtuAEk8Ry2KyIU8wUw2c8ISiPsfSr5sLrhTguQq9?=
 =?us-ascii?Q?zYeAEYC1hl+XWzOiA3LxrevOmXLcM4zaxThqATYOny+QwUkI+/4AEgChhfwk?=
 =?us-ascii?Q?s3fzVU4uO/5YSzL1a0ZoTRkEtpmR25Uv+ZYW09hNYS5+0OF3t2vF8pdQy/kl?=
 =?us-ascii?Q?TK4Y582m/iZyfmSswm0Krxr8YhnxI1w8kgtphkC7yNJrP+eruj1mcPOZSIHB?=
 =?us-ascii?Q?XG+XZoYX46/qB3LALFj6zDLaFs6yY1JYiyyeiythUdR673QXdxw3VPBtfcxv?=
 =?us-ascii?Q?skn+Oo56na+4xWuhJnDfOzGGHmacVcOwcLyQ+zAUQHW2ZdU3SsNdk3geJ48w?=
 =?us-ascii?Q?KdgQCpLclxBnTJHxyrRw4ZnVsS0eq2NpoDW9PuHJ1X2hdJPyFXzPFGJrCUH/?=
 =?us-ascii?Q?JH5Xb+/Sv9hYrp5Kt8GML+8VeOxTnUpqB+kpo2toiLzk2WZj3lvQxufIPfyS?=
 =?us-ascii?Q?AEad38yFycUiE8xV7OWA/ez0H5osGJR4gvuNjzraIODKkIl5IFowhl9VZVZn?=
 =?us-ascii?Q?3RxWz0MgJYKpFYGJgg13RkLRBEsQp648L8oRDt5qKCvc5nkdVnIJFG62qTB0?=
 =?us-ascii?Q?v2P+8/U65OFNfbQp+Wl4JTo4ddIrm5bEMHqeyLxxMbWNj4qd6txHkyPOar38?=
 =?us-ascii?Q?UhtrT/5XFsasIHWQLzYjyUAe9FbxiHffBpx3+tslrMFzM4qaacGDoprccNcc?=
 =?us-ascii?Q?KsnqTSpmYjYK1Uj3dQzBZuyCtUc9oiyu/cUHIQBodYgItwEyzLNcwQqFpZOJ?=
 =?us-ascii?Q?iXPaLuf1DXNyZGWdSB6rGAo5bWaYX734o1SlKBAJ99prcdl4P1T7k+LX/hmJ?=
 =?us-ascii?Q?nbvUEzIT4MhRjABuWRL/j+s7cGinG5OXQV50Z9Fsk+KpmxLP2u+8iJhF9WN8?=
 =?us-ascii?Q?IRtRinAdrivCVwvw9oLE3TNBz3CFUQnwb1mDLJ4NvvaoDO7D+V2IfVgPrxUS?=
 =?us-ascii?Q?Ac6SbV2qMqjFHznM+oVhMrAI7NUKV6DZbvEvSn8Ueyx0MQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QN+HzYux0pl6/vUlwR7zI3j1AC0oQRYI3h7MpFNdC6PfS5Fw0D9flrJjtHpy?=
 =?us-ascii?Q?8FzV6bhE0P4eXPH0B6/KteNeN9bKwce9FRHivMeGccJWHfiixCJjRK8HX6RX?=
 =?us-ascii?Q?8GH1z94g2qXVmxjFTDuS85vZkLRcL4A0Rm9JFWAHXrDK4W8TIkQ3oMdPfH0p?=
 =?us-ascii?Q?sYv777CpI13JXGv4eELmjVTemVUx/1RdjWwY67VHRAVDP9T/7jGeTXb0UP9P?=
 =?us-ascii?Q?bwjKhJVmzgCqhAmIIFYSVSplAZTGgSjf6lBA9vTvyU+IDHYpf+1wN0/AXd7S?=
 =?us-ascii?Q?uaMuCXhH86HyhmLeIARg+NxVqfFTYKLFYjsiVD6nwQh9UC8wS1m5zySMeYod?=
 =?us-ascii?Q?dYGGthZZpOKJK4PwDdoFPqPcg/ifLz6e5vEL/bk/V2mSkVh5BOmq0cYdgqlM?=
 =?us-ascii?Q?rjN1X65mJMtHY4uiTV1tNuqyCdC96wAvKxEb55jX8iCfbEyXPbcistmbq0it?=
 =?us-ascii?Q?LMuHF6a/d6wpCIxiz0vguq2qyGEq3+rIBAPJHKIuutC4pugLukd2X8zlpu5s?=
 =?us-ascii?Q?gRgyCSZRK89w8OpUUDHa4TQHTfa6syNsEaastWekGvvL1jmzR3OnIHxSvwu/?=
 =?us-ascii?Q?cs4e5WTZrCuTjp/I95571Xm3q3u+mgLBz5bbHXZvieBtF/WLdWelz6nJC/1y?=
 =?us-ascii?Q?rvPYVdzksX/b3za0CNtCL/rnlAWODCaJ+ISwJ/O1Ct97zMc3/suqHrXol9pf?=
 =?us-ascii?Q?PxOXklKtkdtbDqT4HC7KpL4jy7xokzXFVkivn6q/IowXB+Jev7lfP3XYaJVi?=
 =?us-ascii?Q?cfRM5T4Jc5wpzA5GTW4rsdw1ZCIQ99h+jxF8dr9ctReYyiHX7ANLWUMmJU6+?=
 =?us-ascii?Q?PbSyKJhTMaSStk9fRiUBznW/BsMyRQ1YG5SQ3vftre2iqsK5JMkmQfuaE6jB?=
 =?us-ascii?Q?NXx/KutmRy+/WtYLU2bn4Y+A6BOp+psxCw33EMSqGYzqykNrNgijuBy/UGIX?=
 =?us-ascii?Q?EaC8lpzCxo7EzGPxXzQD2PTXmrpxPc77Y8wuiYoRiJfQx7F3RWYpIdY2IK8J?=
 =?us-ascii?Q?HVWnyGdf9jyG8G3amt9GRQ+16XcEyviWw6XnUm0mA5wK1Ahvfxdnl2mG0Y2T?=
 =?us-ascii?Q?I4N8NzrprVP2bXKvsV9/4gbnXzmERL5j5TH9Q7Oo/Gpdu3kWN6Y8SCaq8jzS?=
 =?us-ascii?Q?g6ePqs/gFh6vifvGZlCpIvLgovNX1GUje5aZT/jsYBRAVqoV6gtMxDsswCJB?=
 =?us-ascii?Q?E2jEMUCPyUAw7BniNTY9Vh9zXqamvpTpQHrUIWBuse8Pzabzqy4V3dBj/6W/?=
 =?us-ascii?Q?mOEKQ0w+FW2owB5jbpRnCSDoV4I1a412b6yJ4sZP00DwqCuxylIGhO90dQSj?=
 =?us-ascii?Q?VsP/Ja2aK0B28EOD7J8553CAHf3zNWwM+67Q6M9dYrVYCwXQtWu2pAtkrglY?=
 =?us-ascii?Q?3i7wM38Ih3rpp6xmXfaHcLfzWmn1bynKJjmmWA9fGt4ISkTB6KgUU0QBjgtm?=
 =?us-ascii?Q?g7JgIH+kCyVyYlNdlimQ/xP0HkeW6ubx4melWfY48tklPk+nmMaKW5fK7/pJ?=
 =?us-ascii?Q?MRAtVBkNsbnUhnA3btWJ50pD6NR/kr+pECBWbZtvEnjnwN8jfTofOGxX4xrY?=
 =?us-ascii?Q?4dKJmNOY71iexwapGDKh7SZksxGFZBpTRME041XUhAeOw1oMl2D8w4H+Rw+O?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rP2/bKuaFAkjrejRNJbzBJLtRW9X7J79bijU0UYDE3Cj3qBUjhc5+pUPoROJTlktH0WiSJOYx4Epm2llHpbSlq0fqA2Ntwbq0oz+OC6T0ZNiQb14ZVOO/mdvbB7Kr8ZFJdLKBWChrlhqkiaZaFWJHDFfG9rIDFUCeb5tLw+e3lF4Fc5uG7Zt5W0fYGiF/0k41+wfwuxvoj7v9PPP32NhSuZFMRGfqWnl+h37azuv08XzGWGwKc07GY2R0T+O9AiVmWPJB4nbHenLdCeTe9Ib96DHiQt57FkEfdCA1gNaNP1zLEI3DvagTr+92wERhKGWUTWHPS6dZezlZJg8gz+GUNFT170q/RtuEm2pkYm51/zR+wQ4d/LHvOkDzPtiIqyG+zpWCY0vo790XZsaXp3yoKyMcKWJAzayZwrtaE1uKNXPlQw2NNtL1FM7fRMOsD7LQkybepJcxp/AKvLzPJxLh+oGvJ+yJZWfsSbmCOhfT282NvXexNoqWgiTsmJ38K72fh+8X02v5iDPKhNhZEOx/EqtaOC5v4IBxFgf+TTeGx0pEl6nuAi5/mus/hPhh9OolN3HQAjEMGRkeoeaA7pm3qtFxi+zYyn1vZgMfs4W4X8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24f7883-603b-4bdf-c4fc-08dc9d21d7dd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 18:39:46.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VKuq60wXPYrDW0JbVPhl1pS1yPgx+INjEUOA1PFoZnqMQZCoJXZAc5HgcNZovQ6JL8H88+NClcciYl/jp6BzlOauZE8DhUHPlP2T393S/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050135
X-Proofpoint-GUID: 35FLGjRbqDAeVwD4XMMxIxd-amVumX1z
X-Proofpoint-ORIG-GUID: 35FLGjRbqDAeVwD4XMMxIxd-amVumX1z

On Thu, Jul 04, 2024 at 02:27:07PM GMT, Liam R. Howlett wrote:
> Use a structure to pass along all the necessary information and counters
> involved in removing vmas from the mm_struct.
>
> Update vmi_ function names to vms_ to indicate the first argument
> type change.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/internal.h |  16 ++++++
>  mm/mmap.c     | 137 ++++++++++++++++++++++++++------------------------
>  2 files changed, 88 insertions(+), 65 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 2ea9a88dcb95..f1e6dea2efcf 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1481,6 +1481,22 @@ struct vma_prepare {
>  	struct vm_area_struct *remove2;
>  };
>
> +/*
> + * vma munmap operation
> + */
> +struct vma_munmap_struct {
> +	struct vma_iterator *vmi;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;	/* The first vma to munmap */
> +	struct list_head *uf;		/* Userfaultfd list_head */
> +	unsigned long start;		/* Aligned start addr */
> +	unsigned long end;		/* Aligned end addr */
> +	int vma_count;			/* Number of vmas that will be removed */
> +	unsigned long nr_pages;		/* Number of pages being removed */
> +	unsigned long locked_vm;	/* Number of locked pages */
> +	bool unlock;			/* Unlock after the munmap */
> +};


I'm a big fan of breaking out and threading state like this through some of
these more... verbose VMA functions.

I have a similar idea as part of my long dreamed of 'delete vma_merge()'
patch set. Coming soon :)

> +
>  void __meminit __init_single_page(struct page *page, unsigned long pfn,
>  				unsigned long zone, int nid);
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8dc8ffbf9d8d..76e93146ee9d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -500,6 +500,31 @@ static inline void init_vma_prep(struct vma_prepare *vp,
>  	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
>  }
>
> +/*
> + * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
> + * @vms: The vma munmap struct
> + * @vmi: The vma iterator
> + * @vma: The first vm_area_struct to munmap
> + * @start: The aligned start address to munmap
> + * @end: The aligned end address to munmap

Maybe worth mentioning if inclusive/exclusive.

> + * @uf: The userfaultfd list_head
> + * @unlock: Unlock after the operation.  Only unlocked on success
> + */
> +static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> +		struct vma_iterator *vmi, struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end, struct list_head *uf,
> +		bool unlock)
> +{
> +	vms->vmi = vmi;
> +	vms->vma = vma;
> +	vms->mm = vma->vm_mm;
> +	vms->start = start;
> +	vms->end = end;
> +	vms->unlock = unlock;
> +	vms->uf = uf;
> +	vms->vma_count = 0;
> +	vms->nr_pages = vms->locked_vm = 0;
> +}
>
>  /*
>   * vma_prepare() - Helper function for handling locking VMAs prior to altering
> @@ -2606,78 +2631,59 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
>  }
>
>  /*
> - * vmi_complete_munmap_vmas() - Finish the munmap() operation
> - * @vmi: The vma iterator
> - * @start: The start address
> - * @end: The end address
> - * @unlock: Unlock the mm or not
> - * @mas_detach: them maple state of the detached vma maple tree
> - * @locked_vm: The locked_vm count in the detached vmas
> - *
> - * This function updates the mm_struct, unmaps the region, frees the resources
> - * used for the munmap() and may downgrade the lock - if requested.  Everything
> - * needed to be done once the vma maple tree is updated.
> + * vms_complete_munmap_vmas() - Finish the munmap() operation
> + * @vms: The vma munmap struct
> + * @mas_detach: The maple state of the detached vmas
>   */
> -static void
> -vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		struct mm_struct *mm, unsigned long start,
> -		unsigned long end, bool unlock, struct ma_state *mas_detach,
> -		unsigned long locked_vm)
> +
> +static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> +		struct ma_state *mas_detach)
>  {
>  	struct vm_area_struct *prev, *next;
> -	int count;
> +	struct mm_struct *mm;
>
> -	count = mas_detach->index + 1;
> -	mm->map_count -= count;
> -	mm->locked_vm -= locked_vm;
> -	if (unlock)
> +	mm = vms->mm;
> +	mm->map_count -= vms->vma_count;
> +	mm->locked_vm -= vms->locked_vm;
> +	if (vms->unlock)
>  		mmap_write_downgrade(mm);
>
> -	prev = vma_iter_prev_range(vmi);
> -	next = vma_next(vmi);
> +	prev = vma_iter_prev_range(vms->vmi);
> +	next = vma_next(vms->vmi);
>  	if (next)
> -		vma_iter_prev_range(vmi);
> +		vma_iter_prev_range(vms->vmi);
>
>  	/*
>  	 * We can free page tables without write-locking mmap_lock because VMAs
>  	 * were isolated before we downgraded mmap_lock.
>  	 */
>  	mas_set(mas_detach, 1);
> -	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
> -		     !unlock);
> +	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
> +		     vms->vma_count, !vms->unlock);
>  	/* Statistics and freeing VMAs */
>  	mas_set(mas_detach, 0);
>  	remove_mt(mm, mas_detach);
>  	validate_mm(mm);
> -	if (unlock)
> +	if (vms->unlock)
>  		mmap_read_unlock(mm);
>
>  	__mt_destroy(mas_detach->tree);
>  }
>
>  /*
> - * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
> + * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
>   * for removal at a later date.  Handles splitting first and last if necessary
>   * and marking the vmas as isolated.
>   *
> - * @vmi: The vma iterator
> - * @vma: The starting vm_area_struct
> - * @mm: The mm_struct
> - * @start: The aligned start address to munmap.
> - * @end: The aligned end address to munmap.
> - * @uf: The userfaultfd list_head
> + * @vms: The vma munmap struct
>   * @mas_detach: The maple state tracking the detached tree
>   *
>   * Return: 0 on success
>   */
> -static int
> -vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		    struct mm_struct *mm, unsigned long start,
> -		    unsigned long end, struct list_head *uf,
> -		    struct ma_state *mas_detach, unsigned long *locked_vm)
> +static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> +		struct ma_state *mas_detach)
>  {

This is actually glorious.

>  	struct vm_area_struct *next = NULL;
> -	int count = 0;
>  	int error = -ENOMEM;
>
>  	/*
> @@ -2689,17 +2695,18 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 */
>
>  	/* Does it split the first one? */
> -	if (start > vma->vm_start) {
> +	if (vms->start > vms->vma->vm_start) {
>
>  		/*
>  		 * Make sure that map_count on return from munmap() will
>  		 * not exceed its limit; but let map_count go just above
>  		 * its limit temporarily, to help free resources as expected.
>  		 */
> -		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
> +		if (vms->end < vms->vma->vm_end &&
> +		    vms->mm->map_count >= sysctl_max_map_count)
>  			goto map_count_exceeded;
>
> -		error = __split_vma(vmi, vma, start, 1);
> +		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
>  		if (error)
>  			goto start_split_failed;
>  	}
> @@ -2708,24 +2715,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * Detach a range of VMAs from the mm. Using next as a temp variable as
>  	 * it is always overwritten.
>  	 */
> -	next = vma;
> +	next = vms->vma;
>  	do {
>  		/* Does it split the end? */
> -		if (next->vm_end > end) {
> -			error = __split_vma(vmi, next, end, 0);
> +		if (next->vm_end > vms->end) {
> +			error = __split_vma(vms->vmi, next, vms->end, 0);
>  			if (error)
>  				goto end_split_failed;
>  		}
>  		vma_start_write(next);
> -		mas_set(mas_detach, count++);
> +		mas_set(mas_detach, vms->vma_count++);
>  		if (next->vm_flags & VM_LOCKED)
> -			*locked_vm += vma_pages(next);
> +			vms->locked_vm += vma_pages(next);
>
>  		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
>  		if (error)
>  			goto munmap_gather_failed;
>  		vma_mark_detached(next, true);
> -		if (unlikely(uf)) {
> +		if (unlikely(vms->uf)) {
>  			/*
>  			 * If userfaultfd_unmap_prep returns an error the vmas
>  			 * will remain split, but userland will get a
> @@ -2735,16 +2742,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  			 * split, despite we could. This is unlikely enough
>  			 * failure that it's not worth optimizing it for.
>  			 */
> -			error = userfaultfd_unmap_prep(next, start, end, uf);
> +			error = userfaultfd_unmap_prep(next, vms->start,
> +						       vms->end, vms->uf);
>
>  			if (error)
>  				goto userfaultfd_error;
>  		}
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> -		BUG_ON(next->vm_start < start);
> -		BUG_ON(next->vm_start > end);
> +		BUG_ON(next->vm_start < vms->start);
> +		BUG_ON(next->vm_start > vms->end);
>  #endif
> -	} for_each_vma_range(*vmi, next, end);
> +	} for_each_vma_range(*(vms->vmi), next, vms->end);
>
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>  	/* Make sure no VMAs are about to be lost. */
> @@ -2753,21 +2761,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		struct vm_area_struct *vma_mas, *vma_test;
>  		int test_count = 0;
>
> -		vma_iter_set(vmi, start);
> +		vma_iter_set(vms->vmi, vms->start);
>  		rcu_read_lock();
> -		vma_test = mas_find(&test, count - 1);
> -		for_each_vma_range(*vmi, vma_mas, end) {
> +		vma_test = mas_find(&test, vms->vma_count - 1);
> +		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
>  			BUG_ON(vma_mas != vma_test);
>  			test_count++;
> -			vma_test = mas_next(&test, count - 1);
> +			vma_test = mas_next(&test, vms->vma_count - 1);
>  		}
>  		rcu_read_unlock();
> -		BUG_ON(count != test_count);
> +		BUG_ON(vms->vma_count != test_count);
>  	}
>  #endif
>
> -	while (vma_iter_addr(vmi) > start)
> -		vma_iter_prev_range(vmi);
> +	while (vma_iter_addr(vms->vmi) > vms->start)
> +		vma_iter_prev_range(vms->vmi);
>
>  	return 0;
>
> @@ -2803,11 +2811,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	MA_STATE(mas_detach, &mt_detach, 0, 0);
>  	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
>  	mt_on_stack(mt_detach);
> +	struct vma_munmap_struct vms;
>  	int error;
> -	unsigned long locked_vm = 0;
>
> -	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
> -				       &mas_detach, &locked_vm);
> +	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
> +	error = vms_gather_munmap_vmas(&vms, &mas_detach);
>  	if (error)
>  		goto gather_failed;
>
> @@ -2816,8 +2824,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		goto clear_tree_failed;
>
>  	/* Point of no return */
> -	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
> -				 locked_vm);
> +	vms_complete_munmap_vmas(&vms, &mas_detach);
>  	return 0;
>
>  clear_tree_failed:
> --
> 2.43.0
>

Very nice refactoring.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

