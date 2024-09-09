Return-Path: <linux-kernel+bounces-321568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A2E971C19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061CF1F237D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7501B9B22;
	Mon,  9 Sep 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KxiRoGfO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z0Zpmo+6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1522095
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890853; cv=fail; b=L0HCeNSVqZfT7NkD6+oik4RMTDyhbQLls8OsvkiF3b4EBk8HAMpUChrG8LtKS/JCYStN/5tjSVt2xzIENcW8U+YRqmv2YunrQ2bZW5UN2QD/thwSO3Xt5R4pl/7szd80nIaVpWIdJWvwxFKI5urzOB3S6kuaNPiBs1MEZu5jX1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890853; c=relaxed/simple;
	bh=IBjGCFD5dQTg8mLN7e6KPtQXB3IjjtvdyKBhYlphLI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b3KtS835VlwtfE40zBDV740dDsBFLBTW4DUU+YIQqZkrbd7+rdOTmYdDdiDkFPBzSJxZ6wZg09SVv809Y5gq4kCJaacP9/WCenvfbqs+2GtCpNWBF5fmMz1Aa4Se6BEu5WPb8EEnzuVn0xIdleciajqN5WpnVeKcHelMuAosaVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KxiRoGfO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z0Zpmo+6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DfVXD020311;
	Mon, 9 Sep 2024 14:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=UhSoFs6n66jLmoc
	odWa2VaUsKCnGQB5VNqjSrxGJ+1A=; b=KxiRoGfOCdmH6a+adByBOpZTnpjIfR7
	NfpFonO9SZcCZsIEuWUciTU8ZNScYQ9nUSb/Jn9f7yXZHRLWCf1pcwyCPxPrbwbp
	DVI8D0WDKGNJQrsxXNJqVZZo+8M/2Phka9S0vA8L6VyYz9u1Vz9tPgNIm8knsRX7
	szsKtDesWSIL09MjjH6EajgJBQQ7NQIxetdH4EBJi6bBv3bPv2kaGoVrJPxrUmCE
	gHONFscnKgO6YnDmO7sJ5+6ZeM3yZfAjqkIv03QJ1C8Di8RqqeBw70HnvgqHP7jX
	0LJU0uDZydhjrLsI8jvBoW5nmIO1N0yqs5hbOX3oDN4hunEdOkXIPHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbujuxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 14:07:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 489E0Vmi032360;
	Mon, 9 Sep 2024 14:07:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9dgn78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 14:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANaEkK6Zm1A5eS/MAYwlBjeEcVpYxiqjIrdvrGHM4IonN5ztHA4CWqkj4UWMhPPRF0hLOB4a9VhPuQyqSmZtKMFwB7zO4GYf2ZQI0xXHo5sleC5beNXxCfX5KS1Dxg1M5GVDXByIU0Z4YtDt7YMmBSb9NPxzjd1dx75eu7sdfsTH1pzR1vtyK569n4BTTuEOUgB4KK45OWGCrOgWIhrsarD0kSPLkKEvWGAr8d6aTJ6Ly28wKK/XvO9oXrsBho9oZT/PLJfemOPH3YqV/qPcUWyFiYz6cMPChYav2OC10EtewNLvwOxjMjG3HwvfIxAeiADOx7SsFdRaVDCSA0wFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhSoFs6n66jLmocodWa2VaUsKCnGQB5VNqjSrxGJ+1A=;
 b=l13PM7mY3P66N7sFVgdZ4lvpyl8dJ2bD54fnpE1lNmhj2JF4XP0zP52Wontv1Grlq2ckjZAviZ2dWlejwAFr3eRGEMg3YAeO1otPEQiWb/NoI9lxwSEK6TIevjgtHAxBkGW0rmkaelxBk29/VXEewy29U1isuITqocZ4wbz3a0Sb9A0KCVe97odD2DF0YpktPKhDzHRWBdT98jvVdP0uh1769xBXVBlIqLdWbGjFXUWdF4d7Z6RfoD4LZQl0feyEXOYD0klQEPwmKXby5jwEJzGmDDqVnLuwUVvoIc9n+oPlCQFVvu+7kHoxpKOwZj9mSmpLZvhyQOflvGFUJMxGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhSoFs6n66jLmocodWa2VaUsKCnGQB5VNqjSrxGJ+1A=;
 b=Z0Zpmo+68d2irtX0CM2zPWJxI0Y0doVC5brhDwXofSq05mnVowJVBy5aHrzfj2pR5Y99X3bX24IXL68GvfwfAgDSrFzQzTFYcj7YkSaCq5jp8Sj3MW2Wrgs+qsfJD4KNpZJ3z7mtFmmoD5QRwel4hlsD9JLgcgpudfFCVuKxmTI=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by MN2PR10MB4175.namprd10.prod.outlook.com (2603:10b6:208:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Mon, 9 Sep
 2024 14:07:11 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Mon, 9 Sep 2024
 14:07:11 +0000
Date: Mon, 9 Sep 2024 10:07:09 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Xiao Yang <ice_yangxiao@163.com>
Cc: lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        oliver.sang@intel.com
Subject: Re: [PATCH v2] mm/vma: Return the exact errno in
 vms_gather_munmap_vmas()
Message-ID: <tixinevflrciek4bnjwzxv6dwqyokfhrhtmu6qndc7hs2qoizd@iqg2tpjjtwyt>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Xiao Yang <ice_yangxiao@163.com>, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ltp@lists.linux.it, oliver.sang@intel.com
References: <20240909125621.1994-1-ice_yangxiao@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909125621.1994-1-ice_yangxiao@163.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::20) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|MN2PR10MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 686f89db-b66e-4172-d1fb-08dcd0d8b304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CXg8rtBnlcoTWUP8570vMMkgBsZwiHegEkQymkNIYFZB4ypR05ZqPMsZ6NNd?=
 =?us-ascii?Q?luuixPZnFWSev5faLoRBPQrEQLVWO90xR0on9DWCIlOCKZR5fMbuwnDM0TT1?=
 =?us-ascii?Q?bKbUC7f58uLJnjodf2N4kq8niDP0Kh2WbPE/r3mdF4WIkBqoBNUNNwsm05UX?=
 =?us-ascii?Q?Sn8uOET0E0hmWXnpCEmrOA7AlaXl3K0YrKCTBTvSE3zgx79giwQTs20KP1ND?=
 =?us-ascii?Q?2N+fvarQpRwHzJx1yDeH4tc1NWWJMPWxoXKN1zC2jznJxC6z4fUyS6pUSBm5?=
 =?us-ascii?Q?FhIqf40QkO35thJS/sE2OcK2+FDL1E1aZRL2/Ri3TjYMNe2w7H0fQdORqGxi?=
 =?us-ascii?Q?1PKzTFLIzXARiw3YQ04YE3/3btea15Sg1E9pmDfDt21bVnSF0fFtuSCFfPD6?=
 =?us-ascii?Q?O3rUKLB9kOE1iQ1DQ23kgVXC89NYQYmrEqw+79Vu4doR0dbX6yIiE2jDKfNb?=
 =?us-ascii?Q?lGhiyuP0Zq8HyEu1BOGaJkR6rJMb3koEp1TydTAmVkmEpSYy6coZ20d6hJaJ?=
 =?us-ascii?Q?xAgzgEb2mwlz5f3vlmWfSwa9gBwxFDnLXPaRp2DEjvXyY/UNLZuiARHbGxrI?=
 =?us-ascii?Q?fYw0fQFx5F1gnqYAjfEoxRiMeEl0aaS8qdZ8/bN8p3ORTK1jauLbf8VF6Oov?=
 =?us-ascii?Q?Qujr7OLOA3741B1WZBwiypOC0aTo24hObKVwbbhYSE7i9cRLxR4eWYvVeNl4?=
 =?us-ascii?Q?pdaXAy98FTrujwwAm53z2uhE3rbeE1BCZgvIIb/dVEmqvz2zvz+msWqxiD8b?=
 =?us-ascii?Q?S7Efsy2J+7KOoRHM7X8zCJ6sMiEwdGVHvlAOCRWk+YcTg0xpnJxbIJKThMOc?=
 =?us-ascii?Q?znvPBiBC0fh2il0WMo2Xw7YAaOvtd/4IvYFuivh5EcAlUYMpKhzhVmF3fCiD?=
 =?us-ascii?Q?L82efaVa6RgxKqzD9oJ+JH/yrjQgTFd/xa8/HWCZXwwD34dNqzxNcfEaB335?=
 =?us-ascii?Q?QpDOX49at6fwQGMTA+3uYwPbqDyN4D1pg3j6j9o+zHJCHpfp9OpxLXFH137j?=
 =?us-ascii?Q?5zCpsK0Q1Ds/zAi6SL6QZvhc9uaf+uZm36bA4YpnkcJ7WqfvwqrHMN8uoJFR?=
 =?us-ascii?Q?95RIoj2Fu2As/Yd4OHynMICOOOSWZnLfNMaO7QHq8G49Vid17bUnxniT+IYe?=
 =?us-ascii?Q?iV5Ho0xFdI4NSiidx4k4KDbG5wl7n4RZNN7QGWjZ5+2+rf1kxygeCDm6YOct?=
 =?us-ascii?Q?VpaabXK6cJ182ROtP9Wkq6kmSW47gUCul3CnyXzafwXRlGIwnWK23Ec+BQZy?=
 =?us-ascii?Q?naB0ZMp6YB0vr+SanymYBS8nbAGgVYAJGWamuf3ieA4YSw003G5HvwOhjSpV?=
 =?us-ascii?Q?BFMUwLWR3x1TytqOjbJIQTI1nYbHBalT/k7lqfGw2a17C3INuJF+bqfZlJMO?=
 =?us-ascii?Q?oNr7k2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNl9hIl4bMu3T+kfy9u+9eHV0ExJ0wEHdTPf4B3X6U2Hwk1n18IkTGRNra3Y?=
 =?us-ascii?Q?xISMqIrnx2e97/OBEdOSraoUU+gUTbZ8R3Gnn77PeOelqIor8SbpvKaldBTC?=
 =?us-ascii?Q?poZAEgvgqEQmE18unblQRM3V1OM49HfEd6SEeTMJxyxJzMzsERN5ZHrDPJLS?=
 =?us-ascii?Q?YkAnAB4643EF6TdxgExF9Am9VmwGhMKV0LGzTzJ4WO7nnDlGfwQXN3o2PF9E?=
 =?us-ascii?Q?4+CYL360Rxi1BJRQC2zYIWRy/XHgPjLaJNgAftPIfVQlJpJkB1xq3Xy+3Q4y?=
 =?us-ascii?Q?Fm81eXaYJuSw6M5vNBPH2EoPtxHHY8hona8C2gCF8N+8f2uIkvamp4kSPaoG?=
 =?us-ascii?Q?G5VfuAbLwigeCD3zhCDJUsMciHEqEHGTfFPnoWw5SoLWSA7/omS1b7cM75ao?=
 =?us-ascii?Q?DL4d/HRUhFeFpjyRxnrB8AX+Wxr8CLvat6SCAzwHK5YwTkff0YJ6K+6ENVqK?=
 =?us-ascii?Q?mOI3ag624qllms+wYrVdcjfzg9ylKoc/Rw10iXkR/pQAjsA6icQEo+D01x2Z?=
 =?us-ascii?Q?gT2HhCrG5JW/m1HQYUGjM/F0Lopqo63aRO16o5hDngpWkPVKIXBNkaHDrPrn?=
 =?us-ascii?Q?anx7cUvxZdLgOwwvzgHp1dVBG19KPPNaPZDdO/Ip9UAfuBFLBlM/ef6Ruk9e?=
 =?us-ascii?Q?A+uZCgfVPz3DsfU2Muhx8mEnEXlbWGE9LbxPbuhH8EbiF+ie0iF+HfEycBjq?=
 =?us-ascii?Q?mmbI3/gGqfXk60ha0K4aL385SZUy9zPsrmhcqKr1TCvDRFKb8036NDHcp/tL?=
 =?us-ascii?Q?o5KCRE6RM9srVQz2virY/MMQLV/gEs69vmZpuY089NIIMwe/tk+snQ0olZmV?=
 =?us-ascii?Q?VpdJKjxTha4+snXVrYa+yUI7gofM4mksuaXfqSuqo2Qcajmn1AAe/AYqhf3X?=
 =?us-ascii?Q?S0zB7r9nlBQsGDDGPjijN2jFe6jyN1rHTEgmdGGmuBWjFX+1nTVB0I7SiL40?=
 =?us-ascii?Q?rkh45BxUoPso/L/circDP3bzt4OZ8uR6cjhyWXqPoBhMjnHJBo7djmI46uG2?=
 =?us-ascii?Q?m21aasC/fQ39rpNhnoZXbHtqu0TSBC5vKcuiJ7D9iygMCLnaRuOCl25m4Jzx?=
 =?us-ascii?Q?DlL17YagQoA0K6ArmhBjVlGCFbA0j9L0Go8dnAKSHWvYY/FslQHfA2JBxMGg?=
 =?us-ascii?Q?unowpuxjNxzqfV2BkP7K15F9dfH/5JbmozXnx95eiquZFA3SGvLBDrrdTqNo?=
 =?us-ascii?Q?3owrrRBTb4ZmMON55gz63o0gy47Ic3UAQqObft7k8wV+WyZvhfips/CQ0mP/?=
 =?us-ascii?Q?EAW82n6NrnoUNTkW4x3tzeCwfkw9UbIICDteOwYkXFonsyor81wcHRPSc3yh?=
 =?us-ascii?Q?+MV9qfdU9maStMWFVFg2VspWI48LHVA6gQaWOom2BQ9NChHOyWxgDfn/LR8f?=
 =?us-ascii?Q?JDJZl6Vuy/K+r/ROYP9ELOFFmA4WjdOSaX0JMbKuApJgFpHGRm9FKL+B1dvV?=
 =?us-ascii?Q?bwWc828QNIrGowEOhTpzR2Rexjcmhm351w9Td66bCqSS10neYBtFNUDyizOQ?=
 =?us-ascii?Q?P3dfV3YvtnY1+3xTRPowKpRfhpJxMrtCcbez7vQ+4Sd4xlnbzd/EXbq0IfYc?=
 =?us-ascii?Q?ZMH3hBt0Sv7k8u5b5qFiKz2aIaJva/VBdgmHcjSa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g5qCZ+GiXMPHhLFpK/iNjt7A85ytNUcPRMMzWscnFPvqIYG4TSc/nmax++IkgkqXwnzm85wufSgl5QAa7OaffjUQCLFm/qu3E4rzifxx97ue8t5jaGK9oXeum0BgITc4Fs+tfqzuX7nQSY9vyH2EOyOzBQ8LGXWHmaygeiiAh8tne96xtWH37MxqL2xJSIaUT9sEjXITWs+00pZkYLUm0GkXF45VxUA/+oofVRJ4kARNt/qOMw4y0jzdl1B7HWHR7jtEIHp0oykzAxxGjJrIJsM42ezK7mMhW+AK8AAgtQ761Un9mwOpoycFnkIJ56b9hDBN0lq7bHIXgFNR12HN8uI+U2RODqsXxgvXUutfPAIaWNl9wzvqSO4cHbQpfvyGd6hCGMKbcN0Xu6e+foef48PjmItqgv1Hxnfbnd8utzyuxMH5nSx7qBX1ga43zoPgeSbe27ySOspiegzlphJL23nOUVLZ0ycR5ymwpGblrd5a7c5vXpj4HK5ajUMdqwqR8pA1FKClgHJv2rHTH6Z2XqKWT6ewpCUgCGW/Qnk+VKn7jko1oocD5j3a9huHRs0wGuHRC4nuuoY4hdwTpr2Zvd8jjyr9qkhfsR8EiEATM7s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686f89db-b66e-4172-d1fb-08dcd0d8b304
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:07:11.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gd5lGUdaiAgRe5UmwwQpSnNstf92aqBUm5dMqxVK8px/3D5v797jIZ0aNHLbdWdgG3+9WvduWM5yD0cdBfU0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_06,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090113
X-Proofpoint-GUID: 9sx0DbzDwckLCnU8eX-ZQObl7YKVSDDf
X-Proofpoint-ORIG-GUID: 9sx0DbzDwckLCnU8eX-ZQObl7YKVSDDf

* Xiao Yang <ice_yangxiao@163.com> [240909 08:56]:
> __split_vma() and mas_store_gfp() returns several types of errno on
> failure so don't ignore them in vms_gather_munmap_vmas(). For example,
> __split_vma() returns -EINVAL when an unaligned huge page is unmapped.
> This issue is reproduced by ltp memfd_create03 test.
> 
> Don't initialise the error variable and assign it when a failure
> actually occurs.
> 
> Fixes: 6898c9039bc8 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")
> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com
> ---
>  mm/vma.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 8d1686fc8d5a..dc5355d99a18 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1171,13 +1171,13 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>   * @vms: The vma munmap struct
>   * @mas_detach: The maple state tracking the detached tree
>   *
> - * Return: 0 on success, -EPERM on mseal vmas, -ENOMEM otherwise
> + * Return: 0 on success, error otherwise
>   */
>  int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		struct ma_state *mas_detach)
>  {
>  	struct vm_area_struct *next = NULL;
> -	int error = -ENOMEM;
> +	int error;
>  
>  	/*
>  	 * If we need to split any vma, do it now to save pain later.
> @@ -1191,8 +1191,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		 * its limit temporarily, to help free resources as expected.
>  		 */
>  		if (vms->end < vms->vma->vm_end &&
> -		    vms->vma->vm_mm->map_count >= sysctl_max_map_count)
> +		    vms->vma->vm_mm->map_count >= sysctl_max_map_count) {
> +			error = -ENOMEM;
>  			goto map_count_exceeded;
> +		}
>  
>  		/* Don't bother splitting the VMA if we can't unmap it anyway */
>  		if (!can_modify_vma(vms->vma)) {
> @@ -1200,7 +1202,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  			goto start_split_failed;
>  		}
>  
> -		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
> +		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
> +		if (error)
>  			goto start_split_failed;
>  	}
>  	vms->prev = vma_prev(vms->vmi);
> @@ -1220,12 +1223,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		}
>  		/* Does it split the end? */
>  		if (next->vm_end > vms->end) {
> -			if (__split_vma(vms->vmi, next, vms->end, 0))
> +			error = __split_vma(vms->vmi, next, vms->end, 0);
> +			if (error)
>  				goto end_split_failed;
>  		}
>  		vma_start_write(next);
>  		mas_set(mas_detach, vms->vma_count++);
> -		if (mas_store_gfp(mas_detach, next, GFP_KERNEL))
> +		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
> +		if (error)
>  			goto munmap_gather_failed;
>  
>  		vma_mark_detached(next, true);
> @@ -1255,8 +1260,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  			 * split, despite we could. This is unlikely enough
>  			 * failure that it's not worth optimizing it for.
>  			 */
> -			if (userfaultfd_unmap_prep(next, vms->start, vms->end,
> -						   vms->uf))
> +			error = userfaultfd_unmap_prep(next, vms->start, vms->end, vms->uf);

This line is too long.

> +			if (error)
>  				goto userfaultfd_error;

Good you saw this issue, I was going to point it out.

>  		}
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> -- 
> 2.46.0
> 
> 

Besides the line over 80 characters, this looks good to me and should be
squashed into my series.

Thanks,
Liam


