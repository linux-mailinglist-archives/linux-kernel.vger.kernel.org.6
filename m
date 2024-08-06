Return-Path: <linux-kernel+bounces-276398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A29949318
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B798E284723
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562241C37A9;
	Tue,  6 Aug 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WLezUN71";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PBEhf5Nr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862C17ADF2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954666; cv=fail; b=IW1sPLKyOZh2axYp84KhzO2Q3gA8JQOdkNSXzwGMWl76Lcu1ZVq0O0mY8mB/VdWn/xdPsup0SWp7kENfLf27/qC8XQgjXxaeVgVKi0PkV9ucgDPPXRTmiOb9lyqtodMDWTGmYdyHhopIoH6WU9LrA4Xej+RAP1YBjla7oManmNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954666; c=relaxed/simple;
	bh=83wT0fVk5+mUmVbijrDxBeZAJJCV2Ihb8JY+pMPIvmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dRnkvCDKcTWjVfmSpjTU9tIOxBh7W7lJmOQFG+EM4iMzvwISdrnuCJXp3rDcQf59cGkUazE5N8Yt411+HZj5wkDay5uGHCT4tOPI53xI+nOeRuWYSRggJb7OHjBxMoLU4rVgJK28+SNR5G6A8jMZ4O193eWckaYcZGuQAxQnrPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WLezUN71; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PBEhf5Nr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765kbYH031248;
	Tue, 6 Aug 2024 14:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=sBPLsISRwYEDrIjHJ2v89ycPyuYEsqBImHTp7uf23hk=; b=
	WLezUN71P5xOHLkQV+bP9z0qHUAYBOPbD3ZxESfIjl0C6Xa9LlUyTkJ46vT0GVsv
	eWjNlX9wK7d8BCM8++9P89WVPxqvz9N2c9/uLm/Sr3d1OJuROwm+YWEo8jMJ80nH
	wzVV76mO3aQOSSp5E/vDHrIqG7DWYM5K4X7m9tjU2lDEeoUK64So9bNiMktL3b1R
	OU5KlSmaPbZCYaMXmUs0BaxBBVgRg+5VqTkiGmWLuov1kXZLnudle0DG05NzgSKE
	0pTdwbjRV5M31F+kLevt+SfHiRqnRX+68geOlZDivtheuu1n7wIZ2/7cEVTBVI9v
	fYBSIi8Ihv0o3BmdRfetCg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbb2ngtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 14:30:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476DnJar004853;
	Tue, 6 Aug 2024 14:30:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0esja0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 14:30:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSy6iJe+4zN83PlzlWRVEra7EHz3KndTgroTQjgPFulPEQqMp7t3rvW85ukYm9GfOfsc5oxQi6cUwN39paOiQpW8xuiZgWXxbglQmZgaCkrYEo2v3DJkSgK6NSn4Z81lTqqXtZE8ezfbm6pCI3YgBK6prMSB8oFtmBueQNcbIM70pyjF0je+YsdrBaX6Dx3NMp0ssGZ3MJL/8bAx5Q/SefhQSCov1u72X1U7FAGXiZgUXsmUmg3NFIP58ZBY4vYXmMAE3afcf5ivXKe3458zHBTxG0U7H+9t3tbYhRQcu1B/QQrwCR2ZbH2pFg4yp3o2KEGcuvZQFArC++mRGgaJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBPLsISRwYEDrIjHJ2v89ycPyuYEsqBImHTp7uf23hk=;
 b=pUwDLsNYrUYvpFpmpuA9hmkx0zBXLWevN1AcanUirOPWJdVGPQ6hjxAyKyZPdc7srGzHdI0wldlxoDnp5KZ2TgelLujm9WTAYFzECYW69nhfAEOLNT/CAgG881wv4BehmQThuovjCAa5CVHO1y42d/q9xv+JcSFyG5iHsLSJjsmSMHhQpx+Ne3yLyD3KIBaRdrOTB6ED2dkOJ/ycm8n16oc4toNK44d4iM8/ZlyotNeaH+FvDn0UPBMjEYPTMN1RtG5B3tA7n+o7gUv7oPtTJ/nPlmObm7nDHG4gZJfGCFF3IHjoVtboxoNLD0S5YRxQtzk4qPu9PAmKI7EiOMGJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBPLsISRwYEDrIjHJ2v89ycPyuYEsqBImHTp7uf23hk=;
 b=PBEhf5NrQFE2CuO1Ny5pwAsTiPyNsigmd7xfVkuguAaxuPBeDKLpHy7VFyKrogqOxAnJ+xCVq1Fk2vkyiJPXbd3EiN/WW3q17qcVRDx7YSloqRIV4TVbhpV8WGwubYfYcarkm6VarGGhU8S7i3DKOIXHtrKHYlZlnpMZAHnGSyo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 14:30:52 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:30:52 +0000
Date: Tue, 6 Aug 2024 15:30:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 08/10] mm: introduce commit_merge(), abstracting merge
 operation
Message-ID: <c60acd5e-e7c7-42ba-9ad3-1b221cec2ddf@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
 <20240806154116.015e329a@mordecai.tesarici.cz>
 <415d9d9c-7b63-47f0-9091-678f0d8d1268@lucifer.local>
 <20240806161321.376f0a55@mordecai.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806161321.376f0a55@mordecai.tesarici.cz>
X-ClientProxiedBy: LO4P123CA0358.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN2PR10MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d50223-7136-4f2f-515b-08dcb6245fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW82ajZFRDNSTW1XbXNtRjhJVzJmSlBvVzJwdkdzL0JVOVVuVGM4SlBLLzgw?=
 =?utf-8?B?Q3JKMlJOUFdxQTNUR2tMRzBGSmNUM1BHSTU1WkJXaUpqeExUMWg4dGV5NTdD?=
 =?utf-8?B?SjVlNFFPc1l6RjRqV1lKeWtzOTdrNjRGb1RLa3lzdGl1N0FxNDNLU3hFYmJr?=
 =?utf-8?B?OGZxejFPaEVPLzVXS0JaVG9jd242ckU0K1ZyNGNjT1M2V2FFbVM1V1crWXA3?=
 =?utf-8?B?ZG1YQlgwREY4VlF1WDNLem9CdWRjZ1F3TWI5S1BoMEUrV0NkVncwbmFpbjlv?=
 =?utf-8?B?cWZid3I5YTFyZTRMVWptNHBrTk9pUTR6TjBkVVM5RG5jaCtjQUYzUEtJRjM4?=
 =?utf-8?B?bWg4MjUrSGNHRTJmNjFpU0VEYmZRYno4ZmhtcWZCekkyeVFUbjNVM0RQQ1BE?=
 =?utf-8?B?b3N4dnZzcmZjZit6c002U2J4eWxDdVZhd0c1b3RneUNiRFJ3OEpXMGNkSlJ3?=
 =?utf-8?B?Yk1nQUpaVzdpR0l1ZnRGSnVBb01PbFVHa1lFT29URjNkd0FDcExrc3dlTk0z?=
 =?utf-8?B?TkJkQXNmSElrUUNMRDdwSFcxbmtFeGJwOGEzY3p5eXZzYmxLVkdrY3lyMkYw?=
 =?utf-8?B?cytRZnBHVERoMkZzdmVuc2l1bjhhczQ3ZFRMTXhkL2tOazEwbDBidVhzWUd0?=
 =?utf-8?B?a2M2WFUyZWY2Y1NPckk5aytDRTNpODRwT0xHT2FVT2hYZnNla2MzZUJBTDBD?=
 =?utf-8?B?Zzh1VjRPZkJrckFqR1BleXlTS09iRG5aUkZOcFJGZFQ1WWRHdzNKU1J6dWhP?=
 =?utf-8?B?SUpIamt1YVNBek1qTy9zRXBoVFF4VTEveDM1NmlKZlE5YmdBMnhXb1dqbG52?=
 =?utf-8?B?bFVRekpoL2Z6OHdlbHhJSUd1MzVuNWh6a3lHbmFaRCt3eGJzZHdoYnBYLzFF?=
 =?utf-8?B?OERYYlFFTnM5TUI3QWY2RUNRUHBZNjNINjVYcm9udmFvcWZ1cmZuWVhvSG5m?=
 =?utf-8?B?d2hVaVV6aGROZ1ZSUk5rdEk4MkthSWxnSEJsS08zREd5L2dQVFVTdWlQbHZl?=
 =?utf-8?B?M2lYUkpTNUJPWUJMRXI0cUZhOUU0NHVrazJMV3FiNXA2U01DS0JBVFo0aU1H?=
 =?utf-8?B?cnBJVFp0UXh2cW1iWHFmaHFrZzBBL0s1Y2N1ODVzNVd3K09NWFBKZEtHL2Z3?=
 =?utf-8?B?OHhvRFdQdUUyTFdZbytqV1BlZ2FFZFFJS1hna3cxeGkrMm9WV0pHM0Qzenc3?=
 =?utf-8?B?SG05c0hvZFZtbWJ2OS9YUFlCZzhHaFd1aCtOZnpMTVdROEFkUzBCVURDN1cz?=
 =?utf-8?B?QXY3SEVkcjZqVnV2dlV4UkJ6ekdSdmNZbkx5UTlNclRBVUkwZFJaRlcrMVY0?=
 =?utf-8?B?QVlibW9kRi9OeGpPV0NWQU1VdjBYR2xXa3FXNGxVRmlZRjlsYnpPVU5MTHRW?=
 =?utf-8?B?dkxlaStDSEEwT1owU2Q4anhEMm5lZGpFczljWlVPcmVja2RzWlZFUEtLeXdr?=
 =?utf-8?B?amVkUHB3bnJ5OTlhV09kOU8ySlVVZFQxL0t0aWNnUmR1dWNHUEF5clZnL1Rj?=
 =?utf-8?B?NGRFdzN3V29nWGdpa2pZK2g5THF2U3cyZG9vV3FjRWFTTGIxcVNkaWlvR2ln?=
 =?utf-8?B?UVVIYmdaNmxtSld4dEM3dVl4Q0tTNXJ1anRRSmRzUm5PYWNDNDUyNnBpR0lw?=
 =?utf-8?B?Rm5ydElMRzlJQnYvRTQyd3JKOVExelUwdWdRWVh6V2h1RTgvL0N6MGYrTmhs?=
 =?utf-8?B?d3d4MEg4bmZZL3p1cVhmNjlBNVNHOFZVcDRyUHlkcURIeHgyandIeVVOQk91?=
 =?utf-8?B?Zzh1Rk5adzI4QjBKd2loR2Nha3QrYW1qWmd4Rlo2bG1BeGp2ZFhqTllHanRK?=
 =?utf-8?B?SkVFcFI1a0p4R25PV0pWQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3dZczBVMjhPRFdwejhXSjdGU2lHMmMveXhlSWpTOFRtRERZc3kwZm9EQXFY?=
 =?utf-8?B?d3g3ZTFpM0NTZjNnZmdGZGN2VTQ4ekRBNzI5bTRETEhpeFpET2hnbXJSUnpW?=
 =?utf-8?B?bll4bTFwSCtBR1Z3Z1JVNnpLQjlwZC9KMzd1K0drS0JMd1I3T3g0NHlSY2NI?=
 =?utf-8?B?cmt1eEFSVHdKaVYwSmxtSGlZbDhMaGdZd2M2L2pZVHJaWTlNZGRPMWZuRDQ4?=
 =?utf-8?B?LzRPOU43NDZ0RUp2Wk12VFUxSThqUmdqcTJKYm1zbGZGcHBLZ0NIOUIzVmkv?=
 =?utf-8?B?RFhlWDdkSkoxOHRyRk9oeEE3d2RrSUE3UUpRMDVtMjE1VURzZVZJYUlFYUVF?=
 =?utf-8?B?WEE0ekE3ak9DbEI4SHZTSEJTQUxZZXM3Y3QrU3pBb2dPMDNsYVNIVnlGT0g5?=
 =?utf-8?B?UWJhdWtyaGlyc0w5M3BpM2grQUw4c1FITmRwNkxMUERyajgvekthd0FKeGp1?=
 =?utf-8?B?UUZlMmR0MzQxL2RkZW9jMWpTN2kwaDh0M1NaSU02QW9GWHljOU13Y0ZRWDds?=
 =?utf-8?B?NE43NldsajNpVlRPM3piell3M2QxcG5mMzZqKzVacDZJTWEvVWttK1VnWVJq?=
 =?utf-8?B?Y0ZOQnVseStBRVNEc2Z0N1BsMWlucS9PK0lxU2syc2g5dWIxcm9IZXNQbitt?=
 =?utf-8?B?QVZMSG4rWTdoZHArcWk2S05VYUdvbzRQQTJCY09SZXVZdkRyZUoyUFdJNEoz?=
 =?utf-8?B?eXJJMVdOcmhhWnlBczk4NjhBT3BZaitYeTJubUxqUklyRS9uVm0wcHBRWUEw?=
 =?utf-8?B?NXhDZkY4RGZNWkZQeWcrOW9MSW5nVFM2UGdRUGtXNG54Wld2dUJFSmVWbkl0?=
 =?utf-8?B?MjBEeG9OZS9pVDNhNjYyNHdyWlV6eWdNOFBTQnQxRWc2ZFRuaVJEY0F1ZnA1?=
 =?utf-8?B?YlZUWTNmamw0aGRpNlBBa0NURFRlTUIrNHA4a0ZXb1dRaG9KSFRGMUM0dnd5?=
 =?utf-8?B?anZ0aXk5dU5uY0k3Y2VwSVFreVU4bG9Ld1M0Z0RNN1pvMkgwV3d4NHZNTmJT?=
 =?utf-8?B?aXJqN2lEU1ZuZjRLTTlsc3Nld21CamhRRC9IbU04a0lxYjdodlFadkpWZWJO?=
 =?utf-8?B?djNFMkY2L1F3bDdWcVBUdDFuMENJdm45ZnVBd1dZRzBUWEtQcGFNaDh2ZERU?=
 =?utf-8?B?NUY4ZnVMZUZYQzc3VDhOaE1pRGJwN25BbUtIdzY1bndRVHZkSjBleU10WFZq?=
 =?utf-8?B?SVlhVlBWUytxY3FqNDlpT2JqdE9DNWFFUUVKUEw1NDB2N1diUThPWEJ1d3B0?=
 =?utf-8?B?ZXdVd2lMQWZRUllueTZZUXh3Skt0Tm8rekRxbnVDeWVpZC9YblZBaHZRTXNQ?=
 =?utf-8?B?Yk01dlhTWlFpeTVYZDJOWExBTDg1RHdla29OakVKOHY0eGtiM1BpTkI4ZExC?=
 =?utf-8?B?a284dnhHem9ndVY1bHBpRTB3SjlUY0xWRDRMZ3dZdW9YaG5SZTd3NGdJZEUy?=
 =?utf-8?B?V2R4Rmt3M2s0dW9YNTcwSkdwUW1iNjFLbENuWElXOENZOVpGcWJIM0xweTdT?=
 =?utf-8?B?ZTd0ZnYzYytSS05FbW5aT2g4SEJhOTh0eTFlRU93NGZtRlhhU3NlOEx4cFIr?=
 =?utf-8?B?OU96RjBYKytXUGI1c3ZiT0VidHc3VFp1SU4vVnpDa05ER0oxVDk2QVdwQ1Fq?=
 =?utf-8?B?QUlWcXdWYzBkSHBucmV0cUd0UjBLREluZk9YSW5ObHErSHcrWE9WbXVmdHpC?=
 =?utf-8?B?NG5wV3ZZVGZlT1lwUWVObE1jME1wVHNMaU9GdmNkSURYL3lNaTNTY21wcld1?=
 =?utf-8?B?ZmpLd3ArS2pSSTNzam5KUzF2aW1MOHU5NTg2aXFSTVk4R0xpTlFEMkoyVTJO?=
 =?utf-8?B?SmpwUGxtOHBRL3Z2elBvcTFsbitKWjd6RHJLNFZtcCs4MnU4c0xQTE9BQVhS?=
 =?utf-8?B?djMyN0J5REFHWDNTZ280TDJVZ0krYXRvUGhFM1VDdTkvOFJlTkJSRTJwTEhX?=
 =?utf-8?B?alNxZkovWEg5WG5ESDNrNUdaVHFwVDljZlRoSWpONkVGampzTTYwU3RKZ0F2?=
 =?utf-8?B?c2txdUl0K2VtOXlzcWJkWVluTDZDUXdPdGFiM1l2U1huWVRKb3RiTEREeFhI?=
 =?utf-8?B?ckJPVndhc3NkUTZob1NYYUE0aTl6NUt4YklDR0Q0clFkSXdUOVlrYW5jaUlw?=
 =?utf-8?B?VWlhbDkvV21FUk1IU0JDbk55NWtBb0F5VWFHOGdWeCtKYWNsMUQ2ZzdMN21a?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rBCyXJt68TLZKaw1zFDpk/IG0Vxl0Uf5vhYehexs6rKt8YzfBrlC1XRxoHP/qiLf1Qzt8ce4fjhBG0Hz31MmwhhBlht/cZ3k33Kqjnf/xdELi3wUaKz+Moff1pJ0w4paMFgHBL2kV/LeVId/xgaGkpQjbcLdQ3twqQiCqEFIp0nO7JlqCUHe+xO3e2pkcf1lwwTPrtWdC3cymxzZibw42ViOXI1MHGsDfIhqKeBsPfwSfUCGN/0mZ2HqoSGiMPocOwbPMiKWiDy/DitYXD/5MFBFvCUCqvKjTdZ8OyxjjAneyzrfYXkCbs41F5b9Oag1V4QyQS8BamAuXqPc/X+rPDK/RStwVqmHkm87SVAYPh6kwVmhlRMmbyyBfHKxrCO3eF+2ThBeNpQr7BNloFNZ0/41AfoQw4Ex/2CTdrOY0+xn2aDi6Knhb0M57gXaJcDPbJ/g/1MVyMH/qTdx3TZRusUZ2DgH8hMGPKijoKu7vYzJacgLkxs3PfR2zg83QgE4CLvq2ddjekZKMnG37r2orh/9kWKZEX5BjB7jBFN2FigZyG5LWVhJvZh9cfuJclzJm1i3AN/PlXWBykFrpvGjoW7QLsvU9sU8LdgyL3ILTYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d50223-7136-4f2f-515b-08dcb6245fad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:30:52.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IifcdPs0QsgMF537uThlPOyjfpLN1SVwqON2BzgL2TqVb/+OgN70n5qAxCOQwH8zAD4qopV8BUZ6/HjXZoWyfgl+NwUElOMx+5sJWjemjEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060101
X-Proofpoint-GUID: xRmWFoICu9gI9I-c_oFX6-Tw4gXSkgsx
X-Proofpoint-ORIG-GUID: xRmWFoICu9gI9I-c_oFX6-Tw4gXSkgsx

On Tue, Aug 06, 2024 at 04:13:21PM GMT, Petr Tesařík wrote:
> On Tue, 6 Aug 2024 14:48:33 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > On Tue, Aug 06, 2024 at 03:41:16PM GMT, Petr Tesařík wrote:
> > > On Mon,  5 Aug 2024 13:13:55 +0100
> > > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > > Pull this operation into its own function and have vma_expand() call
> > > > commit_merge() instead.
> > > >
> > > > This lays the groundwork for a subsequent patch which replaces vma_merge()
> > > > with a simpler function which can share the same code.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  mm/vma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 45 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > index a404cf718f9e..b7e3c64d5d68 100644
> > > > --- a/mm/vma.c
> > > > +++ b/mm/vma.c
> > > > @@ -564,6 +564,49 @@ void validate_mm(struct mm_struct *mm)
> > > >  }
> > > >  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
> > > >
> > > > +/* Actually perform the VMA merge operation. */
> > > > +static int commit_merge(struct vma_merge_struct *vmg,
> > > > +			struct vm_area_struct *adjust,
> > > > +			struct vm_area_struct *remove,
> > > > +			struct vm_area_struct *remove2,
> > > > +			long adj_start,
> > > > +			bool expanded)
> > > > +{
> > > > +	struct vma_prepare vp;
> > > > +
> > > > +	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
> > > > +
> > > > +	if (expanded) {
> > > > +		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> > > > +	} else {
> > > > +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> > > > +				adjust->vm_end);
> > > > +	}
> > >
> > > It's hard to follow the logic if you the "expanded" parameter is always
> > > true. I have to look at PATCH 09/10 first to see how it is expected to
> > > be used. Is there no other way?
> > >
> > > Note that this is not needed for adjust and adj_start, because they are
> > > merely moved here from vma_expand() and passed down as parameters to
> > > other functions.
> >
> > See the next patch to understand how these are used, as the commit message
> > says, this lays the groundwork for the next patch which actually uses both
> > of these.
> >
> > I have tried hard to clarify how these are used, however there is some
> > unavoidable and inherent complexity in this logic. If you don't believe me,
> > I suggest trying to follow the logic of the existing code :)
> >
> > And if you want to _really_ have fun, I suggest you try to understand the
> > logic around v6.0 prior to Liam's interventions.
> >
> > We might be able to try to improve the logic flow further, but it's one
> > step at a time with this.
>
> What I mean is: Is there no way to arrange the patch series so that I
> don't have to look at PATH 09/10 before I can understand code in patch
> 08/10?

No.

>
> This PATCH 08/10 adds only one call to commit_merge() and that one
> always sets expanded to true. Maybe you could introduce commit_merge()
> here without the parameter and add it in PATCH 09/10?

No, I won't do that, you haven't made a case for it.

>
> Petr T

I appreciate you are doing a drive-by review on code you aren't familiar
with, but it's worth appreciating that there is some context here - this is
intentionally isolating _existing_ logic from vma_expand() and vma_merge()
in such a way that we have a _generic_ function we can use for this
operation.

I think it'd be _more_ confusing and (surprising given your rather pedantic
interpretation of churn elsewhere) churny to rewrite this again with a
bunch of added logic in the next commit.

I think this is highly subjective, and I'm not sure it's a great use of
either of our time to get too stuck in the weeds on this kind of thing.

Of course if you or others can present a more compelling argument for
reworking this I'm happy to hear.

