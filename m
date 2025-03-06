Return-Path: <linux-kernel+bounces-548449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44116A544FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0DC18886DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93289207A05;
	Thu,  6 Mar 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hYgVT4vy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KLP59fuR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18D19C54C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250107; cv=fail; b=c5w6D0sUIg/jQHOIcaCHc2jcq96mrF7bHuIcP83woxOCZBFxweGgEU+AhLkYn68l/JWu2l//GsG9e0izw7+hrFJ9qe7nzx7DkarJddiZTv0FJGSAmOD/k2F5Ggr0DCNVWJWh76XsIY0rjUWbhIxNmsfGsyvsNOhdGmOxFvoFxMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250107; c=relaxed/simple;
	bh=B6/h/bpSn0bShoJIzvFmb+nklZjjf3nIu8nDBSy0B9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VbBHew5Wh5a2r62/oqDemkjfGaonbxgO4a2puBZ6N5THYSjAH7ovlfj4FCnIVDmL53GMUgqcxH/IC2x5/M7ditLZQ7+MBGZ/7ewLVr/+iFkjFaxxTOKB9eVEa0HPjdEqK9+uAvxEIzGeSKrL/F7hy+f6b11E34VIf5TK9nSpSv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hYgVT4vy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KLP59fuR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5261u13J005885;
	Thu, 6 Mar 2025 08:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5Cvu889bHy74ykZRCqbvbbwYdm3N7MbWBWXaDdTUhDo=; b=
	hYgVT4vy3DCT4+vLeDSXuflJ0aureg36XzjIzzi3KjXY+wPsdHVTVv6ICX+/Eggi
	EJLFb0oCMkqpWfAsis5FLXMiGcMwCPTO6+gb7Fib4O8jWhhd2x/k87E2reo5+2kV
	Sl++JDm64WDloEN6IhDUOWArIui1Yznky3aUz5t5IHgWPFA5TGAOY8yq3osoX48+
	N0LhVGk4e3O7DmkpxLcWExEXgXAVZa2yYI2okpBbBJDqgXBhLgyONQeJE7oWQ062
	Xpm3XBwg2VY1sTSvPSdWUF7z4QiOMScbgYj+jXYe4MiBG/vPoMHe519F2WReJZjW
	RVbzFmmPyF/jvL7ri9syMw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r49egg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 08:34:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5267ihGG003198;
	Thu, 6 Mar 2025 08:34:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbqn76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 08:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez/rrenr80z8a3IenQN4tFw3VjGKGK+H93buDfdzR8aB66V49wKfL6YycYPiR7eNw3XXXEAAzozMiPtodR2I9Ht+rqZA6YxiTEEwOqXLmOL09ZWYzUcJ9r7KpguBGTeFM9hniynb3XfysrefR50Ea/t3qEt8+VlGEJ23Kq1sPXC33w5WlJq7ceUVusITZxazk8nYI5YmSfrTSOhZFNcKZRLPATXeOPDi2CEfsAFyIpISO0u9KKfmaORk43dfyzSAVnUVTmv0VoD7eBDHfQssPKSaBkeQ3Vg7e7Dbn/FgHkX6mmAkcWUyaiJGTNxRwYAO+6IAEsNi3u/W69xc1DtI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Cvu889bHy74ykZRCqbvbbwYdm3N7MbWBWXaDdTUhDo=;
 b=HDOPWBHbe6+IbPsi/hlSNyKbsdR1Isfb+GhkPQc+CqIECc84nklPtyVFB4uWm6c+hWSD422xgBZXgTUKyAexs58zHToKpoz6PhfBeek65h/XDO8g6Kd120x1E5WnlmDwpTdjRTSgqqr7BSGN60yvDvG1DnQkTZNbxGZTj+sDGLNqQOHd8unfYPC9R40K4bLuLxxhJ0kbMO+yQU6RvbpEsOh4TmjuI0196y2oIHy9p0w5fTfTt63x2WCU3wasFCG827S28RfRxlYoLLCXpfjHJk44vbHGpDhinVm1k0GFUzz1RYBwB5rDCLwdqAkUXdMuuTs1GZBx5KbQdxb+5kTp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Cvu889bHy74ykZRCqbvbbwYdm3N7MbWBWXaDdTUhDo=;
 b=KLP59fuRUoEcaI2W+hngkYJ0Id+vsa6gVbopPhm1uP8bgnXsNNZQWilKktOlOi/wbz55AOlwJ8z8ofv/h7ODQ9ZjafzXxCxcpN6mbu5wtPcrZZc42ZokwNE2yydZRcnKEFFqPEUBaWdXTTU44OdigJ5PwAmCd2DjpNuspRl+JZs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB7770.namprd10.prod.outlook.com (2603:10b6:408:1bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 08:34:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 08:34:43 +0000
Date: Thu, 6 Mar 2025 17:34:36 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lilith Gkini <lilithpgkini@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Adds a way to handle freelist cycle in
 on_freelist()
Message-ID: <Z8leHDicTjUR9850@harry>
References: <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>
 <Z8XbomV9WCabATIM@Arch>
 <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz>
 <Z8a4r2mnIzTD2cZa@Arch>
 <714d353a-49c8-4cbd-88d6-e24ae8f78aaa@suse.cz>
 <Z8benEHigCNjqqQp@Arch>
 <c736fbe1-f3f4-49a0-b230-41f9da545fad@suse.cz>
 <Z8bvfiyLelfXskNw@Arch>
 <c99235b8-3859-42dc-988b-250b3f042d00@suse.cz>
 <Z8hyV4sROVDtwRDE@Arch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8hyV4sROVDtwRDE@Arch>
X-ClientProxiedBy: SL2P216CA0104.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a52e32-1f68-43df-7710-08dd5c89be2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXJkSkp1SU56SW1tQWhsVVJ5cDB5ZkEraFVsQU1OZjNoTWVKNm1VREVWcmtu?=
 =?utf-8?B?SFVkTHkzQVE4SDZuRHRqUFVjU0N1U1JYSGRDYTdiTGRDZEhaR0xYYll1cTh6?=
 =?utf-8?B?bi9xb3JZaTRzeWJjRHE0cmFQTUJUcE9UME1UVkRHYlRuMTkwaktoL05nVVNU?=
 =?utf-8?B?a0VXMjl1akFab0F1cUlmSWc5Yi9uRy9YMzYzc2hYWDhZQi9DQmNyUlRtaCtQ?=
 =?utf-8?B?WVF4UkxSYzlDZnBBa2xhYzdqeThZNzIvOFJRaW9kYTJBaCtmWmpSNkxOM3c1?=
 =?utf-8?B?MGtGd285RUM1ZHdrREppS2Niak9DYWY1UlNNNFRyQzg2WGIxWGR6T3dnaTlP?=
 =?utf-8?B?dU0rMm8rZ3VVaVNCQnllVFoyRG5TRkZ2Zld3T0hFam9qdHA5c2lObmt0RmFi?=
 =?utf-8?B?UEd5dGpDRkg2TnBjQUtHWi9pcnhaajNOdnllQk5LbFljTjA4dGhDN2RmYk9T?=
 =?utf-8?B?UEljUmFFVGU0Nkw0bTR2QWw3bDNkTUJEN3J3bFl4cEdwMCtNVndEeFV0WU9l?=
 =?utf-8?B?V0hyQjEyMW43cUsvYXI0anlIL0Z6Q3pZZUdyR3l1YkdSRjNTMXBScEZrZkZL?=
 =?utf-8?B?RmhQbm8xUEM5QWtxUUxvRWpUeTFlWGF0ZDFzYU9CMVVVOTVEVU9WMzlXUnc5?=
 =?utf-8?B?V21haGZzZmlsWTViVDdEMzZ2SmVxdTIxVjluUjF3d2xLdm9hK2F6MkQ4ZGNy?=
 =?utf-8?B?UXJUenZnTmhBeDVMRFNSd2I0Qm9hdkxOZjRRU3R5QWxubnJlejA2ZXNPTlpo?=
 =?utf-8?B?a29FUTZabGZWTEVMdEhrTDhFdnhuajFQRmxhdFI1dUo0S2NGOGVRVXI3Lzd4?=
 =?utf-8?B?eTlDdFMrYWM5QWZYLzNJUGh6OGhCU25kcmVWN3hTNG5lM1V5NFlRODk0aUl4?=
 =?utf-8?B?cHZlUWpQd0ZxVGk5K0xIRE1vazIwRmZBTFUwVDhDUWVRcmVySThhMmlkaUFu?=
 =?utf-8?B?WlFxY0NEUU8zdk1FTmJlbzhFTmpac0QvTEZCZzBNUmJLWC9mbjdRVGZ1MGhI?=
 =?utf-8?B?cmwrWVJwYXlGdWY4VzVROGRhKzZZNW5FaUdpd3FSNFg0RFJzQjJVdElKL1Y5?=
 =?utf-8?B?YlFBTDBHTld5RzFiYlVZSS8wNVNaZ2FXVDVBY1lwak0rWGttWGpXdlFPbFJL?=
 =?utf-8?B?TzRRdjNPKzFPNGpCM1ZBTmpZOTJxZXR6cHIzVHM3S280UU1ZRmdQdWZGWHRy?=
 =?utf-8?B?ZjI3UkVXTURxRVFQSE81YXhmN1ZMM0UvUnJNS1h5QUJyc1A3U0FiNTAzVDR5?=
 =?utf-8?B?bkpLQTljU0JQQW1USmxVR2UxM2ZaOFJsYll1czlDTWZ3ZHRJQm9tWThRYThx?=
 =?utf-8?B?NHFzRVZVYTdKQnlobzUxSThzalRKWnZOQ2xJWDgxVkxXWlZXbnNlWHhTTVk3?=
 =?utf-8?B?Z0wzUzFyVm1wcHozQWZ3eE90NkFVblluMm4xd1VKUWk5V043RVh1YWNUYm5J?=
 =?utf-8?B?MG10Z0dJRTlmSUFCb0tnMEVFcGl4TG5DSEkxZVVYdVdzZFdSN2g0UG9VaEhM?=
 =?utf-8?B?Z0NEUFB6MjBIMTdjZmJhdW9CNis2cFJJcHY5SjVUa2FFMVUwRWhhVlRUc2pw?=
 =?utf-8?B?dlJNZjFET1NibVgyU2pxSDJ0bzBiSWhqd01NVTlGRjhEcUN0WkgxdkQ4RUVN?=
 =?utf-8?B?VS9vWGFXU3ppZXpZMWd5OTdWUGFUMDJWNXhLWUhzQkxhenp6eEp1N3VXZzgw?=
 =?utf-8?B?ZHA3UEZWUFNZZms2YWNVM2Jub1RGQlV3TCtnck1EL21MMzRMM3FKRHhQa3d5?=
 =?utf-8?B?cDgyY0M3LzZyS2pNbnkvYVRoaFQyRmx1dGRUSi9ZdFlKeTIrVWh1VThpQXBr?=
 =?utf-8?B?dmNkLzl3c1BZU1hsYktPaXFucktMUjlVTXhtS2twUXV5emNzTXprc2ZRSWp6?=
 =?utf-8?Q?vRmv5oEZ5KU6L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0FqUTNwUjNDc05kRytQZUNVS25MU2p6TVpGc3RsLyt4NHc4YjRBUlBzQmo1?=
 =?utf-8?B?eWFTeGVFVHpLZUx4Z2k2SVhhYkc2NmgwTGFWQVdNVWNCa1E3ZTJFYU4zMnhK?=
 =?utf-8?B?ZEdRUEIrZVJJWEtBRTk1Z0dSb2l3TTB3T3NxWWg4dWdjY2tDZVF6Y3ZYRWZS?=
 =?utf-8?B?QnhWaE1MbTNKcDFKb1ltN3RFVXZyQm8yMTlHN2tHdkJBZm5qQzM5dFJnVkQ3?=
 =?utf-8?B?NjhMbkZOdi9yc0h6cmxHUnJScHR1WjJRaUkvN1VGdWtBOFYvWkZzYkhGYklI?=
 =?utf-8?B?bFc3SHQyeEV3VVpaeHhlQ2lnaXBhMUYxcVBtME1wclBQSDhudjZjVDcvcDNS?=
 =?utf-8?B?U2hBazJhL2l0UE9lM1FFUXdHWVpkWmxEenVzZWFpNko4S2RFZ2JzODVIbGRY?=
 =?utf-8?B?RkNCemRMMW9EZDRpVjFwZGtFQkpPTGdKYlpWc3N5SERPMmpkUTlHdTR4azdD?=
 =?utf-8?B?SytQcDdqaDFkOUp4QlN5ZUVyalNsNnNoMmMvRllRcFRhRUJOb0xZLzBNUWdW?=
 =?utf-8?B?TXI5ZzF1SHJFaElwZUZmTjFSKzk1MmxEMEJzWVFkRzAwWUd4SEV0K0ZsWkNt?=
 =?utf-8?B?WFZPTmZManUvWm5tMWNZU0JwR1NGY3pFdGg4OE1mLzdKcjZtRCtweVhMWmlE?=
 =?utf-8?B?NTVjZGpIUVdxQi9oZ05HVUFIZGdNdXJMSHZJb01DRHhBUlpIck1yYUJTaVNH?=
 =?utf-8?B?Y2ZiVmJwK1BTU2FPU2htalhEVnU1SXkvaFZZeVhUYzAvZ0dURlZkNjlSYlJ6?=
 =?utf-8?B?MHEzemdmbzhQQXZxU0UvZzk4RXUzSjFZUmxEVU44NU9vWlhvanUyS1dpMUZI?=
 =?utf-8?B?ZDYzdTk2dGRsTDluSWp5dStWWHlnQjhEYm1ZNnJ2WXBZa0g0NHdUSWdEOWFL?=
 =?utf-8?B?THJtZUZ2SUdpMFZNeWQ1NXozU1UxYXlJcUJQOWhvMk5BaVZmTnlQU2prdGIr?=
 =?utf-8?B?dUQ1MDZVK3Rlck5vQkFwZVd5QW5KUk5zUmk1dXl4aVo2YVZDTEJPdEJtcHAz?=
 =?utf-8?B?SVFVUU1selFWOFNDSEdwYmNUK1oxVWdpdUE5Yzd2dTU1T0tSWFFmK0xpcUVX?=
 =?utf-8?B?U0dhMXdzek5sMDlXbVFkVnVoTVhveDVHVnR1N2RIZEtqWk94SWF0MXM1SGpJ?=
 =?utf-8?B?dWlNZHo0eXdZL2xEc1ZoZlpoWVBzQUR5TDU1cEhHNUNKUGZTQ1Y0NkFjVWsz?=
 =?utf-8?B?YXp3azVNallqaGlmOWwrQmJSYW52NERJU2l2SCtDcWdOTVAvcENFbFVXNEY2?=
 =?utf-8?B?WVk1ZXlNMDNZQkFJYVhTL0pmNk1hTy94aDd5U1ZyZ1VYNVZmVVQ2c0NBd2Nl?=
 =?utf-8?B?Zlorc1RpSmhuOGxLSERNN2FYbWpBQTNJaXpuUEdScG1la3MzbFNxR2hLdk1W?=
 =?utf-8?B?cHRzV1FROWpwZzZWUlUyRlNtQ0VFa2QrWVErd3A5L1FFSnUzdU8vWW5FQ2R6?=
 =?utf-8?B?cHM0V2ROYnRHdnk5Q0pVQWdwQk0zdXltUW1oZkRBWVNON1dSU29qcXg5NW12?=
 =?utf-8?B?S3JFK3RkSzB0VW83SytwK3FVaWtVeXpBbGY4K2JxQUtucDA0bVZ3emM5SmJF?=
 =?utf-8?B?TkE3SEZ6ZUQxSHlpOUNTdkpPRWRwbnZuMU05UnlOK3BTVUtXQmp4OTNLSGJh?=
 =?utf-8?B?dkcyQlNFNFY2NWphVjFlV1JMcDNNK3hsQ0RuaXd6Y0xvcVRtOFBndVMyZUhC?=
 =?utf-8?B?WGpCWkoyWGczMnlLaHp4RkQwOXpmbnEzb2NuL3RhYzlWNGdMTlowaVdpLy95?=
 =?utf-8?B?MDRlWDMrWXhoSjJYVmp6K1VEU2hsbWJFeDMxMTh6ZFFZZ1VDNXc3VWZWeFNO?=
 =?utf-8?B?ajQ4MUo3QTdMTExvbTRQL3N0a2V0Y20vMXU0bDFIMXJINTZkQmdpa0lMaXo4?=
 =?utf-8?B?ZzY4UUVMVkR2dEtMdS9zMEVzeEVuV2plMnhJUGdTcndJTEFBM0F0OGI3NUtG?=
 =?utf-8?B?TDlVajRmbWsyd29ESWo1b0NsWks2S3k5WStRcU9MaEdIVmxmZVRKd2ZNWE9X?=
 =?utf-8?B?RUppbHJRV003ZGM0Y1JqNkxBUCtoZ2Vad1J6eFVicVhqeUJsbjAyTDhjTkxQ?=
 =?utf-8?B?QlcyZnl2SW44SDlqcXc3ZkNxa0N6QnVPWUNPU1lpTVF3MkZqaC9YSSt6YVVY?=
 =?utf-8?Q?npSWgEIiFfbY5SLLZn0sXLqlO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i4CEhWZ2sd2RwiPAlyMrA3hoqQoNERsn5Hlrl0/SbptYzRycGc6ZJsY+ISpXp81jsod3Tf8eLc6mu7NYYl7vr62FXEGOEI1VMB4lyPrAMP+tTetMqkZ0V5VVjn3O1QVaQRV7qjRQBR8yjlBgVh4sWiyuHFd68RakMD6fex3KlCc1pcqJ8OYuRWiVSb68LBg9JmMvqZa4g0E4l82H3iPz4OQZXpzQyT72biErK0ajV94gljnte82JPi/JOydgoUjRYqJ8oe13NV0USK/oG7HKG5vHCXemAgOK9ru5qO9xw1jD2Dx2uSXdzeX2jthvJDCbuBdHBgmrQyD0j93g4ZpiWr8xQPJI8f4zCCKzEnj4HVa41X84VJeuLoe8a+CpPmxGbm7p6kHGNYtnyLWx6HRY5sH8tZTU58/Hae5FJqxL4nvJh6LkCWVZSqT7ggHgV33haY3vgbykg7mY/jfJAOv7F99l2WkHnXDYyLxBTEgxnLKWah7L4QCzy/uUTyzUNuc1pCXxMs7qt7hhRNJhkQnb1KiDQ2OihVTzYYpuGz5DtPFmjjER/CrnMSwd5ANNRnm7NxnpvJ47becvgd/Q0+KXor5BHJgE1Iba2dIcWr/y6zI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a52e32-1f68-43df-7710-08dd5c89be2e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:34:43.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Rs8jzRo/Rze7Ahma9IDWqUDB6G6I44OYb9rXRRJ76oQYDKunlPXntzKjVVbHqCvNualdgwj+rP8Q48ETADAQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060064
X-Proofpoint-ORIG-GUID: BffC-OvITcA3Bm1xVjNl3b7qfa6slMa3
X-Proofpoint-GUID: BffC-OvITcA3Bm1xVjNl3b7qfa6slMa3

Hi Lilith, the patch looks good, and it's great to see the improvements
over the revisions! I've added my Reviewed-by: tag after the '---' line.

A few nit comments are inlined below.

From Documentation/process/submitting-patches.rst:
> Describe your changes in imperative mood, e.g. “make xyzzy do frotz”
> instead of “[This patch] makes xyzzy do frotz” or
> “[I] changed xyzzy to do frotz”, as if you are giving orders to the codebase
> to change its behaviour.

nit: Per submitting-patches.rst, I think the subject could be:
- "slub: Add a way to handle freelist cycle in on_freelist()"
or more concisely,
- "slub: Handle freelist cycle in on_freelist()"

On Wed, Mar 05, 2025 at 05:48:39PM +0200, Lilith Gkini wrote:
> The on_freelist() doesn't have a way to handle the edgecase of having a
> full freelist that doesn't end in NULL and instead has another valid
> pointer in the slab as a result of a Use-After-Free or anything similar.
> 
> This case won't get caught by check_valid_pointer() and it will result in
> nr incrementing to `slab->objects + 1`, corrupting the slab->inuse entry
> later in the code by setting it to -1.
> 
> The Patch adds an if check to detect that case, notifies us and handles
> the freelist and slab appropriately, as is the standard process in these
> situations.
> 
> Furthermore the Patch changes the return type of the function from
> int to bool as per codying style guidelines.

nit: codying -> coding

> It also moves the `break;` line inside the `if (object) {` to make it more
> obvious that the code breaks the while loop in that branch.
> 
> Signed-off-by: Lilith Persefoni Gkini <lilithgkini@proton.me>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry

>  mm/slub.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1f50129dcfb3..95e54ffd5330 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1427,7 +1427,7 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
>   * Determine if a certain object in a slab is on the freelist. Must hold the
>   * slab lock to guarantee that the chains are in a consistent state.
>   */
> -static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> +static bool on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
>  {
>  	int nr = 0;
>  	void *fp;
> @@ -1437,26 +1437,34 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
>  	fp = slab->freelist;
>  	while (fp && nr <= slab->objects) {
>  		if (fp == search)
> -			return 1;
> +			return true;
>  		if (!check_valid_pointer(s, slab, fp)) {
>  			if (object) {
>  				object_err(s, slab, object,
>  					"Freechain corrupt");
>  				set_freepointer(s, object, NULL);
> +				break;
>  			} else {
>  				slab_err(s, slab, "Freepointer corrupt");
>  				slab->freelist = NULL;
>  				slab->inuse = slab->objects;
>  				slab_fix(s, "Freelist cleared");
> -				return 0;
> +				return false;
>  			}
> -			break;
>  		}
>  		object = fp;
>  		fp = get_freepointer(s, object);
>  		nr++;
>  	}
>  
> +	if (nr > slab->objects) {
> +		slab_err(s, slab, "Freelist cycle detected");
> +		slab->freelist = NULL;
> +		slab->inuse = slab->objects;
> +		slab_fix(s, "Freelist cleared");
> +		return false;
> +	}
> +
>  	max_objects = order_objects(slab_order(slab), s->size);
>  	if (max_objects > MAX_OBJS_PER_PAGE)
>  		max_objects = MAX_OBJS_PER_PAGE;
> -- 
> 2.48.1
> 

