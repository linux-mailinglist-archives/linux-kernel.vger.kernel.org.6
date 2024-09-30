Return-Path: <linux-kernel+bounces-343835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F7998A015
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DA41F20FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20AD18CBE5;
	Mon, 30 Sep 2024 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLR1CEj8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nLNp9w+4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82213D52E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727694389; cv=fail; b=bxEztnIShSX1s2rAUh0n4ufBpFsI0vCcap2vas80XFpEflNvWUxQcSIQyL88hx2RJvMLKNYDPjllv+zg9SXpTJnzFVUzBp9HlSsvwPIBHpc/qAnAHd3NlPCPQHLDm02BAvzq0d/9o59oTlGDagElXmbljiV+xDLnJjV3pabtCL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727694389; c=relaxed/simple;
	bh=ifLg7wAdNwQQnm3tWGK+SA79UgA9CbsZkRvWE4uyR2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uhpm4e7GC/H1GjeRIARbreRdrnG33Q5vOhlQz8sSwqTWxX0zIjRXUI/71RZ17tZbWKLGhSnbFaroHG3aCX2MxH4DAGSYig8cUbKHH/dQ54EDXJ/7zWwyYRBDReg+WOWp7rqT0oQsBQrlFTCkVGyVWgBFjzxBaeMAI77p4GObZJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JLR1CEj8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nLNp9w+4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2uAZw015335;
	Mon, 30 Sep 2024 11:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=dnLcSUpSXGL8IvX5VS21HkQmbDaR3mFEQvGGEub/pk8=; b=
	JLR1CEj8fX3Kft9TE+nXrjJj4FXCTpeXPplH+Cv02D0VPfTJeB7wZ0zIqkU6qRUG
	kl999RYmQZ9247sDdsbW68f/5zng0Vxd4VUEn9Ih4bndRCNQD0HPiZI10Lu1jzmK
	bd7pSrTnShvhE+z+ETbvSgSF4I2qJNAcPZ+zi4tSoOTLdCcuuqCng/SFPvS/KE8+
	v92s12kBfipUhVMkgbq0HcHIEpcWD8R1rU+pKgFZOsA2YOlfGVcWLgPcTmfyyULc
	gMZR10OJ6xf1tnqiz1lnGo/kHh8ARSR444/kRlCD3rAt7OQQtmJThRXYpt1KGvWg
	HC6AuGB46kcTobeL+IKY4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb31bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 11:06:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U9ZfHb017272;
	Mon, 30 Sep 2024 11:06:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x885w0ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 11:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLdvDHnX+oTGzxWWbtvqRKd722BYUixexe+mV2vbUfkvuzQfbwrXpazOCq96HjVOY/W6XJ1irdbug0bkm3KCe1scKK9vbNpYTmq6SjTUyexYbCrR1lMnPgW15TOjk/EckebSety7Azmk8GLYnkjPs3r7U7tlAsNakICDFHazsyDuj2CWJ9K4JfaqVeZhPW7ikA/HYrQERZEyz7yKXQd5+qrKXU1NhMoJD56gn2qGA3s5+0hr8M/0o/14daMJ4XsVVssyCMT9NasW7x/07v5DBLPGhVcg7Vr16Bzp+brCse3PzWj3dldsSty81cqLcAjBRLAlRd+zB4B78xnUJzdlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnLcSUpSXGL8IvX5VS21HkQmbDaR3mFEQvGGEub/pk8=;
 b=wEjx3EhFwxzgW3yH3/cH312tFi7ucZC8+NvlyxdGOkTK6uHRLHkkaf5UHlLx2cLLS7deKODuVl8oaTdNMd+1ONmkOccqENjiK5WnU62vQi63ylCh+hXschahSLQ7/9Ao8aguQsLXeFfL8vExzOD2FmDmqj0FWytOSAMfYydgYU6SHiqDqrXWawD6fmwrb2+2YraIMP09QukDG1RG+zx7lRZAM4xJ9Tj7oyu0IMruFMMJRSv8P9AWAARjz8w+1ChPq0Xvr1jmgneItTJKCh3PcqOypssQ5l5Uww4ACmywwRY5vwszlbNTv9HB8ZDIM4gqv7C0G1gxR7Bm/+uGAT/rRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnLcSUpSXGL8IvX5VS21HkQmbDaR3mFEQvGGEub/pk8=;
 b=nLNp9w+4CLMqpGky1gUbrkwc+TPDggXqpvngHa4IERXhhiQOsXG+FFkmVpSx7GRXRxpwRaX/1cyCLubsvgFtujPLXQCVrmkXWliPvArqkXp6IH/NzMyBz15pgtxMhQIPxANxl9Scc/AkSmKu7hEDHbszejLp6UZ1gFS0X4/RPPc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW4PR10MB5862.namprd10.prod.outlook.com (2603:10b6:303:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Mon, 30 Sep
 2024 11:06:14 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.8026.013; Mon, 30 Sep 2024
 11:06:14 +0000
Message-ID: <8ff9d672-88ba-4be0-8666-b63917600d73@oracle.com>
Date: Mon, 30 Sep 2024 12:06:07 +0100
Subject: Re: [PATCH 1/1] device-dax: Correct pgoff align in dax_set_mapping()
To: Andrew Morton <akpm@linux-foundation.org>,
        "Kun(llfl)" <llfl@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
References: <23c02a03e8d666fef11bbe13e85c69c8b4ca0624.1727421694.git.llfl@linux.alibaba.com>
 <20240927104646.3a0b777b5114ec62becd7f47@linux-foundation.org>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240927104646.3a0b777b5114ec62becd7f47@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::8) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW4PR10MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f901c07-ebae-4f21-bf32-08dce13fe60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0k4cHg3UUdhSEVvSWpBNmNySHlHMFNaSHh3dzNBQVVJSGhURUNXTEo3V2NP?=
 =?utf-8?B?YXh5NHZ2cWcxckZUcExuYjNDWFEvYUtxWG05NFRYQjZmVFJDUmN6bXZlSDUv?=
 =?utf-8?B?NzBDb3FGN0Z3YTBYUlh1ZzhSUTFOOTFFZWZsYUxMa0VSZGZaNnMxVHdWK3dC?=
 =?utf-8?B?bXRHWnFYR3ZUTFVhNUFyNVc0dTY2czNSYlpPWVBQYmM2aEhLQnJQblNPaS8w?=
 =?utf-8?B?czFJMFI5d21rcmNyb0tWOUlwTFlrWnRoYUdGT1A5bVQyMitvWnorckxaOUNi?=
 =?utf-8?B?U1hld3l1WjdQdUU2OHhNdTNYWE1DSDA0SDV2YmV4dXp3NndUQW1oSUlwMkFC?=
 =?utf-8?B?WVFadVYwTXFCME5Yc1VkMGtlcUJtZHhUNTEvcXlrN2ZRbXBwczVnMDd2Y1FG?=
 =?utf-8?B?cDUxRHdsM1kzZGkzQWp4Q2hQc0FzSDJPcFpkZitzU29EY1p2QTlmNXNkL3Qy?=
 =?utf-8?B?OW1tenVGSnl5RzhOenJvWldiU2FzZzlqV1EzcUVYTDh6a2N3Y3E2ZHVpWCtI?=
 =?utf-8?B?YTUydG1Vb3dSRXlVWURYa1gxSTJZek1MV3J4blVkYWV5UkRXWGlPVitxVUhT?=
 =?utf-8?B?OTFWQ3JkOGlVV1g3Mk9ubXlWbFgydXNVSmZpY3FSbStIMHdpYXVRKzhSR0VB?=
 =?utf-8?B?S252bUoxcjZNcWhsSmFPdWU3LzUxQjZrWXJWNm1OWUR6L3NvR3JnWC9ES1Fw?=
 =?utf-8?B?MXo1aU56UU8reThsd2pBYXBxbGhrUFhKemxBblNpMTdvZExpK3QrWDJybGZr?=
 =?utf-8?B?VjhUaWtDdW1sSjltUk94TjhKY3BRbWk0YTdBeXpER1BlRVIvaEIxRUtObndx?=
 =?utf-8?B?V1JydFJVY05vS0ZiQk8zNlZSaWxpYm00THRTRWFvSy90K1YzcEs0ZVQyL3dh?=
 =?utf-8?B?QmxHYVoxYWkrZ3RvVC9wa2ZyRUd4VEczWVY2MEZpOURQTjZDbkRCVy9HalFo?=
 =?utf-8?B?ZFFoSkF5dFh6eHl4Y3Z2UUVrUHl3TDJZQ3lSM0YxVWJjMFhhckRCWDQzY2JC?=
 =?utf-8?B?ZU16eTQvNlpkMzZHcFJLN3hBL1dWVHM2NjlsUUlGdjhJazRxbENFQkJRT3lp?=
 =?utf-8?B?K3k5VHlMbW1iUXNOUGZybnRUM3Z0bVN6TDlNVTJ3NDRPN2dzb0NjQkgrRkFp?=
 =?utf-8?B?NjV6RjNxbjB0bEgrdTZ5c1hVczFUMWczbVRRV1VXS3BaaDFTbmxLUDZQUytN?=
 =?utf-8?B?WFBmMTVZdUJxUysyd3dUVkpvTEVxVzhreVliaFlJbFUxSmFWdWVRRGtBdGJ5?=
 =?utf-8?B?TE55Y1d3Z1lLWEw2RSs5R2JGRGd0UytTbWwyS05uczY2MkNpdFluZ0dQdVB6?=
 =?utf-8?B?UXpKZWNEZTRnR3crbnVKT2ZKQXdwU2VSRUNZN0FFNVFsYWdUdnBXTUdXbDh6?=
 =?utf-8?B?M0pWNGdoRUlhOERvWHBRdVdPYXlSL3ZoMjd1eVhMU1lKdEhYNmZGOUNzeS9L?=
 =?utf-8?B?YStNY0k4WXFha0E2dmVza2lHdnlnR3VOSi9tSXJKK2E4OTQ4TzByUElCU21R?=
 =?utf-8?B?akIyQ201bk9Ic0lRekxpM01CR0VLYUo0blRJTUtSVTJJRUJETXh5MGhJVTlK?=
 =?utf-8?B?clZmS1Nlc0FGOVQ2WEdkQU1KOTNHa1U5YUZzSW9hSWZ3bEJIRWpoOW5MZlhh?=
 =?utf-8?B?bTFuY01QM0lub1RlMk5CL3F2a0pGTUFWb0lMb1Qrb0ZjWU51V0VHQ2pjR0dm?=
 =?utf-8?B?cU10SFBudUFsVTlVcFlmS29MUWtjei9zNnFYcFJKa1k1NSsrWFVtVlduMlc3?=
 =?utf-8?B?WVYrSzVkYklKU1dIZ0dMNHVaeGhjb09kRXhFY1VwTzVueHJsR010TkhTcUdB?=
 =?utf-8?B?NlViSE5ZU2ZISTBZb1lUUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmE3U1VyK0ZPNTdZcFExQ0EzQW5KOVRxUmRtMWtwRUZ5L2RSTjZlU1FFcnpE?=
 =?utf-8?B?b3UvaklPd3JscVVQei9OaGhyWEFTRndNL052bFdYT1plWHFkN0FyL3FtK1Jz?=
 =?utf-8?B?WnducmRlR0FNQmNRMHZtWWxBcHhDOTJXc2J4QXNjK3NnNDRpYWJUcThTd1Jn?=
 =?utf-8?B?MmJoRERHMjJ4ajFSSGRybThla29QVVFTcUlZR1NWQXJWOUVZSC9ONFA2TVg2?=
 =?utf-8?B?bHdFQlNPZktiU2M1VWQybW1MUk15eExWZnU3Umw0VUpDSWhJL0kvTUxDeGFt?=
 =?utf-8?B?ZHZibjdrZVp2ZEcraW04MUhNTm9DcTM2QnYyVUVSZ3Y2UFJYMkNZbFBLMDMz?=
 =?utf-8?B?VnhJSDZ5bmtaREpmcVVCUkxsTkp0NFpkYUtIbTVGSkEvRUozcVFhZFZyYzdt?=
 =?utf-8?B?VnhaTkcrdzhtTk51NmQvSU9UTHo1T2NrQTBpRXVrM1pyZnRKNndHWEJqKzhY?=
 =?utf-8?B?aG1MRkFOUUtZNUJERlFVeTJMRGZOazcwZGNucmVRYmsrYS9ranNJWXN1Y2ZU?=
 =?utf-8?B?N0g0UzNXM0lEY1crREx5bVFxV2hjUVFrNUtjRnNFanpmaU5HbDFhY1RXT09n?=
 =?utf-8?B?Q0piNHdZdzBGelcvSnpEWUMvSzNwU3NRK0VFWnoyM1JjWXZYakM5VE5JTldv?=
 =?utf-8?B?Skw4VU9zTzJYMEpGVFB6NFFSRFFxK2RRRkU2RDdyc3YzWXhxb0VEQkR4NzV4?=
 =?utf-8?B?NE15UWJXdlluYzFaQ1hDdXhkTmRpTjRqN2diSy92T0drN0VmUUFjV1B6NUZE?=
 =?utf-8?B?cXptWExGRC9YZTBhYkxKUGQwUHRwRnBkVTVkUlNwc2ExcFYzc0IvZllJR0Rp?=
 =?utf-8?B?cW95NWpaQXlHcGd0YTN1OEpnazF4OXltZzNmWUZmZjJ2YmtCWWtvZlJYT0ZL?=
 =?utf-8?B?b09MQmsrbG4vYTVkUGFwUlhCa1IvTFV4VC9jcEp4UUFlc1Q3Ti9qemRZWlV0?=
 =?utf-8?B?S20rZmk3Q2MrZHBTbTZIWDZvYmFTMGFZYXBZelloVTAxN21aNll1aFhXU1Bi?=
 =?utf-8?B?RjYwVUlTOXlRa0xQdGFjWHVKUlRJS201em9EbWtIdmlKaWJJRkppd013Mitx?=
 =?utf-8?B?Z0RHOUlGdzIxU0hiVmZJdHB4VDBDLzdwaHJKSjNZWm0zMjJ0c0FvbldWS0dL?=
 =?utf-8?B?eXNsT1dyK3g2b0tOT1djTUFRb3BYV1EyTkF6M0tpcU1UWUNXcXNLeWthdjdY?=
 =?utf-8?B?K0xWMTVidUxWU1pzeFVLbnRHbkVpL2tQdmlIL1RjckgxdDRyc0RCYkpkNFg5?=
 =?utf-8?B?Zk05cTVYUEh1MFl3cmNoK2FJUGVPWVI2dkppK1ZlbEt3Y01NZ1ExYXVrQ1Y2?=
 =?utf-8?B?MVZUcXRTMmpSaGJsM1BLaTJHT0Y4eFRTbW1iSmVXVEs4UUxOR0lCQ3lnWXVS?=
 =?utf-8?B?cksxL0dBMGhZd0srVVRiQVBaT05ldUhxVWhMTndvWWZtYitFeVNtS2JiSTJp?=
 =?utf-8?B?SFM3V053cU93V0lmcDVJZXlrV2x1aW9mU2RsQ2FwYkdXMGNHa2tCWmFrbk05?=
 =?utf-8?B?ektvdDMrL29ldDl4OHJHaDJ0L3VXYWZ5MHBvby8rK2QrRWZMMml3cUUxOXdV?=
 =?utf-8?B?VWtRRjkyODF6bWxGaTZNWHRaOFEyUUhHMGtrSVhCTS9PcHJXTWx4d1lIaU5z?=
 =?utf-8?B?WUV6TTh2VEE4Y09DTStwYy9NVEJ4TldtTFZvdUxISmpuVGlwazhxdUR4Uzgz?=
 =?utf-8?B?blVNVUtmM2J1ampmd2I0TUZZSzBDMyt5Ti9NY1VPWm15Mk0rbXNHQ1pZZVVT?=
 =?utf-8?B?emRBUk9pODJxbjlGTnRQYm96VFpWWUQvU2RodmhKaUZ1UVoyeVFPclJTSktW?=
 =?utf-8?B?bXdhMTNwaEdCS2FBM2RJcU1LVDZqN3dFMFJIYVhqQ1ZVbHgvaHFJaUhoWFNi?=
 =?utf-8?B?SVh1clhhbkh2WlZiRjdacmIxSmVtbUVHMnRPaERSQnFLdWVBRVpZWk9sQTFM?=
 =?utf-8?B?Vk5wZldFSm5zblpaak50OTJLV25sWWI3UncyQkpZZmVRZ25PcVJFRitZWWR4?=
 =?utf-8?B?Y25WaEsxSEs3UXRZZUlZN1lwWXRESUdDdGdjeXVRR1VyeWErZDNvamhnWWpJ?=
 =?utf-8?B?bDZLdHhpMzk2bWZxN29YSlBaUGVwWXN0NGtKWllrR0o0YlFYTUwwRlhmMmNP?=
 =?utf-8?B?SzlRdTlzbzh3ZXBGRnhPRFQ0aUVlanBYRGg2dzlBWXZjTGtNWTAycDUzMjBk?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qF9x8wM3G6lbWvgWjO0RbM9CaT1rbMeOXTw4iwD9NqL+TstmnZNZGluH6MmpnCsmmeigla556kRbWEaRigf7eHOzZWAR2ijC7ZqEU34ZSvAr1xg27cqR80FCVXzeFft7iHy5HKAnaXTvg96gFtzlhug9ZoHrSrRNKMn8YWgliZm3f/x1XDjfLg7pCH9SfIQ2r9nGHA7lV2PAC4F4sCMXSFd2ki/neX6JZyrK67IhzH3Pr944VS6DJKUbxmPDAoVTflY036IXq4irMWavpqu29sJc/tASzNIdN6N5zju7J/7TNvjrZneAoz4RT0RUt1q+5noKeGA+mkMBleH00sgN2h9m9k6KC9JvlykgNys+1QGmJtxzU67oYBr0kIdHQiBrgE0UUuxqBT2leiXLF4w/nGHVQo13e6ycwNOMoXhHTff6P5gNPAqmHRjAsc7wW/JNhX3NOtRO/23Iz/QC8r+iYgTxWiyVSJJ4eKf9dcLwiNJ6iGuzZjjoRdkwxl0tzRmMriWQRP9BIPcg83p3gStmtbcQkFLelKmWjnxp0kgkhWYgTm6W5zBB9lDX+lk96kQjN5PYdhKLJDogEqKR9fIPj+aDDgt52CYFI/PnT/pdyyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f901c07-ebae-4f21-bf32-08dce13fe60d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 11:06:14.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GSfGpzDLpx/odtYGdJ5N2XuW1v7EUmrzYMouaWds50Jf1BIKXZtJ6C2wSxCNlwaCq3bp8N6e9sLEhEIMTF1utNsNwYnJykJpLhGcHOqs0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-27_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300080
X-Proofpoint-GUID: QrWc7iaHTWViT7FX--ZzKjSS7Ye6RtEc
X-Proofpoint-ORIG-GUID: QrWc7iaHTWViT7FX--ZzKjSS7Ye6RtEc

On 27/09/2024 18:46, Andrew Morton wrote:
> (cc's added)
> 
> On Fri, 27 Sep 2024 15:45:09 +0800 "Kun(llfl)" <llfl@linux.alibaba.com> wrote:
> 
>> pgoff should be aligned using ALIGN_DOWN() instead of ALIGN(). Otherwise,
>> vmf->address not aligned to fault_size will be aligned to the next
>> alignment, that can result in memory failure getting the wrong address.
>>
>> Fixes: b9b5777f09be ("device-dax: use ALIGN() for determining pgoff")
> 
> That's quite an old change.  Can you suggest why it took this long to
> be discovered?  What is your userspace doing to trigger this?
> 
Likely we never reproduce in production because we always pin device-dax regions
in the region align they provide (Qemu does similarly with prealloc in
hugetlb/file backed memory). I think this bug requires that we touch *unpinned*
device-dax regions unaligned to the device-dax selected alignment (page size
i.e. 4K/2M/1G)

>> Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
>> Tested-by: JianXiong Zhao <zhaojianxiong.zjx@alibaba-inc.com>

Thanks a lot for the catch and sorry for the pain that it may have caused you:

	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

>> ---
>>  drivers/dax/device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
>> index 9c1a729cd77e..6d74e62bbee0 100644
>> --- a/drivers/dax/device.c
>> +++ b/drivers/dax/device.c
>> @@ -86,7 +86,7 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
>>  		nr_pages = 1;
>>  
>>  	pgoff = linear_page_index(vmf->vma,
>> -			ALIGN(vmf->address, fault_size));
>> +			ALIGN_DOWN(vmf->address, fault_size));
>>  
>>  	for (i = 0; i < nr_pages; i++) {
>>  		struct page *page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
>> -- 
>> 2.43.0


