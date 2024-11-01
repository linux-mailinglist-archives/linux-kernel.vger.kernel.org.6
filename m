Return-Path: <linux-kernel+bounces-392885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42449B9947
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F57B21302
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD481D0E15;
	Fri,  1 Nov 2024 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FB8iuG/Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vxMbyIz5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E4168DA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492207; cv=fail; b=fkdzu/8ZF6aN1aMo8xIHpov3ASr6gQZoc94Dll5GcTrJ7jqkA3tn41nOn4az2rR2WaifSSh/eSAtaaX6ocxrjMQ55dIOWWhxyDNImRfcpURr+Ru1uuf6rzFN1jcmOkzirh3MOi25ZNpnefUN45XCw/E3FisfpHONAFZmBNC6Jow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492207; c=relaxed/simple;
	bh=ehbhSn2Itc2YDe2EY5tnYCOChfvAYJf/jLMmzu8OJfo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lMrDbp7OfvKSiPo+ItYydLJZyNfciAgj8OiFb++U7/w4fpw0IPJ0CIu4NKiddZl76PUSREux7C8iAlLYrQiOU0giup0DfnbzjDr1cacgLlYQsPujiA3Oa4LOo+0dNeWPIRiSjSG+xO73LQf6tddrUyySYKRDMgDlBVNIdpTv77s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FB8iuG/Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vxMbyIz5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GBlOE013029;
	Fri, 1 Nov 2024 20:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WDolfkZiwLAd+5hUIkncw5f9xUBKqqgBuqZw0vmMuvw=; b=
	FB8iuG/YDMiACxqASqLHSFlT+w7WMa+hnYfrOPIpagjLfwHTMCIftryUYm3s9ntW
	s1eroJS7GqpSQkyFPJox6+78sKiQTCp8IXE2hTeQSuqZmnsCTrwUiCh6kIZpY7Zt
	aadiTwAPUZGJmMotQ8v1wm2KbgoItimygeC6sNcTkqUvbFOhqmqKXodgD56i2Q/Y
	MnZEpGmrMq+kwQk4Uy6iYSXdj+TZhJgh+ekOK4/PQ71BfKvwcO8VApnHg9MB2PHD
	FOj8GOrWd5f8ga3sdYHzqCxQiRyoShFtT3CN5dSDODqASUIO4ap2wo1rOKxcSxhz
	B5wETtO1rXLsRB45YiUFMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqmwpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 20:16:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1K7PAL008486;
	Fri, 1 Nov 2024 20:16:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnedwab2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 20:16:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6tlRO9UHnR5i7itppr3iRCZXKAzujcrUpfN4CIEXaa/Ufs+yY9TGSmjTaId5INCsLO+DJlRSoxl54OQa/upmuKSklPnaCtGA+MBXkw7STFneqMi+9onp2fnp5PQHd7/tgNwJqOuzdTHbGq9DzrWUTocWkD9ybWOt+IV5WvyRFjqZzmGrscsqFMDDkC8wmZ2ezqpr45Mx1cXGAjfx3o9bWWwL9laTeL5cPmRgiAVrTfUP+oD51Zc//EqJvSIjK1kbYISDm27Ohg5sHwbFeTV27EZWAgqh7m0kDVwJZXPldQcw9CfLsBwij3m3gBrW8NJJM6td/S5ZrRKzb3uHEjh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDolfkZiwLAd+5hUIkncw5f9xUBKqqgBuqZw0vmMuvw=;
 b=RGvblq6rWyB+I4uhPQXM61QzrLn6oZsLBT4y067iW4xWp6P1GznP2gdrt7h0MIOSI8zk+jNRXm4FJgY4pQzXkHZsM+T6FuPYH/ynXAJ1HPN+pBH9WnQUvJt6+uT1MTKG6G4rWJhbFlNk0LvcmImGBHpEWipJiMLUyyvitgnFWyZDI71rsa+8X3vTbRCaO3HJQEbWL3e45UB61lJ7v+A5VDGxMCFgBmRZW+e7ldnX0rc7ndBms/HqW0XSCSpd+eb/pN+S61EONiBoZkFttB6Bd+MI8z+3C30wc5UvsOXbLQCM2cD7/RV8BhPjl249OtLnrJUg+1cRDMe0MTnXz3pNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDolfkZiwLAd+5hUIkncw5f9xUBKqqgBuqZw0vmMuvw=;
 b=vxMbyIz5HieNvPwuKxZXD8i24qxegrVTzCsn+3aTTNQps3A9IsmyDGnfXdgE6Q0xvtiAq71Diib/bUfmsM6L/PRSGXMcBnWeEkqD70VMHN+RcxDpWb7y8xyrEy6Lp0o7kemcALEVO1Pzg5uSQwtJACO9dA7lzvSPPG+dpJ3CQZ8=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25; Fri, 1 Nov
 2024 20:16:24 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 20:16:24 +0000
Message-ID: <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
Date: Fri, 1 Nov 2024 15:16:21 -0500
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH] mm/slab: Avoid build bug for calls to kmalloc with a
 large constant
To: Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20241014105912.3207374-6-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BN0PR10MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 39116157-c71b-4906-828f-08dcfab20e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWlrMWdnM2loNTZIRkkxSERJbUI4Rmk2Q3VqTjdKTCtjY083WDVNSmtWekRD?=
 =?utf-8?B?TWdJQ1dpMkp3SVJNMFhwWkJpZldPU1pCMEhETThqQjVmdjhQNzRsV1dCbUhF?=
 =?utf-8?B?NnBjbFJXUkdhQzNXekYzWWNwZ1VQRkdhMWRURzdlOTZkdEQvZjFLSkhKR3Np?=
 =?utf-8?B?cklRblVidFNjb1JMMVl3OE1UeEtka1RyNHpaNTFUK1g2dXlIMkNPZVhyMFpB?=
 =?utf-8?B?QWFsaS95UTFNVnlnZEpma0FrM0hERXF5OVE1VkpqeUs3VkRvZy8wdWg2eUp0?=
 =?utf-8?B?Y002L3RyNVpZdjROZUVaT0ZFSk1Tb0tLVUcwTHVDVE9GZE1ySkdESFVMUzFE?=
 =?utf-8?B?dG9CUGdIUGlyTTBId1gwMlVEMkRIbEsvVEZDYzdLLy9JSHg3Rk5DWnpYUm4v?=
 =?utf-8?B?RTE0dkYxd2ZPNzVqSWprS2l4ejlsVE5zb1BWYVZybi9Ibjk1U3E4WHc2OUxB?=
 =?utf-8?B?aXdaaFVHSjVWNm56UWcwWWRQZjNzSXlwcXh6cE9EZDFOSGtyR0h2NGx1WUZn?=
 =?utf-8?B?M0pZWldNTnlFTGtHQ04wbHlpbUl3TW1VRTNhMUFsY2NtYnR4Z3pGQ0RIMk1t?=
 =?utf-8?B?dGgyOTNsY0ZFOVRyeWpUUnkwZUgrRFdrcmgyNlNaWnk1MmRSa0t2NldSL01G?=
 =?utf-8?B?aXgyM3o2QXR1cDUvRkdqcHZHdTJXOFR4dUNIMG01Q1hmdXY3b0Z2emtGZk1N?=
 =?utf-8?B?cll6ODBvVEk1alRNMVVRUzZyOC8vRlM5cE5qVVREckQ5enAwQUpLZ2JoMGlC?=
 =?utf-8?B?VStpdi9JdklkQUVHczg2akdLODMzbC9uQ0p0YkFEY0ZyMlBoV0R3cTRwVTdQ?=
 =?utf-8?B?MVZqa2ZiSTlsaFdVbE0yZjcyK1ZvS0tRWXkwVEljRVRab3lrckdSK20zK0ZO?=
 =?utf-8?B?Y1JrSkUyakZNUTJ4blozWFVEK3duS2tkVUhDNVZqalVFcXVqSWdURkdDVjdk?=
 =?utf-8?B?WVh2OGlvT1I1bW42S3R4RGZ3aS90YlVWeUhPRkEvQ2cvUTNDSDdsNGtsRmdB?=
 =?utf-8?B?MFZpc0w2SzQxK1E1ZTBwOHJndnZJN2tuNnkzcWsvWUpuaDFvbkJNQ0ZVTms0?=
 =?utf-8?B?eU9UbXN5dWp6ZHVLVHpXTW11c2czSkVFcTBENVFydG5IV0NqbkxacC9HZnAx?=
 =?utf-8?B?dVE4K0wwQ0xUYUZkb3V4aFllS2ltK1hsQ29VQ3lPUnlWemlmS240UmxKeFo4?=
 =?utf-8?B?ZThYT0dhQVRGYVN6SW5DbXQwYlZrT29zaWtWcURUbGxiV3BabUtBcWN6M2s1?=
 =?utf-8?B?aUFYWFlSVjBuV2grRFBwS3RwMStmZm92ZVQ2OEg0Y2RVODQ1bStHK0svQUUz?=
 =?utf-8?B?YWpuay91RFc4UFIxTER1L1dxNkJXN0dCejVuN2pkNzVTemR3RkRQUjhpcVZo?=
 =?utf-8?B?R0JMZGM2U3l5QmNrdmVHbmFhUjVCWER0V3d1Qy8zSkF1RHByWVhleXJpRVpx?=
 =?utf-8?B?VjlDNzBrWVFZMm1lcDVXT092emJJNHNCaWhoa01vNWhXWVUydjFFeHluSWxW?=
 =?utf-8?B?UlFqSzRaa1ZzMzhuanB4NXZmS2hYUDFneXZBTk1CYWRiOHMvQzZNMmI4cXc4?=
 =?utf-8?B?MjhYbHN4bUVtcUtzRzdtM2wyWHEya0g1dWgrSnpRdmREVklFcFV6QVE4czQx?=
 =?utf-8?B?R0xwUGpLcTJQaHpGcXpsVzJoZDk3VUN1UHkvdU9EL296ZmtpTjQ4SmMxb1V6?=
 =?utf-8?B?dUhlQ1NyZi8ranAwWWh4K01HdEd0UjBWVU1wbjJUTDAwSmE1VkpEY0I0Y2Rw?=
 =?utf-8?Q?jKOwHLYxqF7IVEVcDq3PkheQ39ccXm3/WR/c/Mj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEEwRkphMnpyTjNjeEc3dFdxVHcvbU53WXJOSkI2cER1NWprU0N1bEVlQWs2?=
 =?utf-8?B?dHhlZ014UUZXQ2E1RFlXMjIrSVJwK2MyVGhKbGlBVlduWVZoazRTbTFJM1Y2?=
 =?utf-8?B?a3BZcVlTRHBlYy90bTh5dVppUEpjWWFCL1hSeFlwSDlDWXhRbi9KRmo0dEUy?=
 =?utf-8?B?ZTJ6MDl4eElmWlgxRHpUV0ZnTmRvbm40YUVQZlJaRW9obDdDakFHTXE2M3A1?=
 =?utf-8?B?SS9TbWJrMVNPVi9XQXpUaVNEYWZsNFp6SVZNWFN2bW5lOXpqZnk4ZVJBVnJi?=
 =?utf-8?B?K0ZyZWR6TUpEU0dGUG5OWWZ5TzdGR1BzU0p6b0E1NStyRFZDU3VYeEs5K2Zy?=
 =?utf-8?B?ODF6cjhRQ09BMTR0UTRRZHFCekhuWDF1bTRDZ1AvLzN5TW8wdVM3Y0ozdGxT?=
 =?utf-8?B?cWlxRUJoWU5HcVh1MnJpeW9hVkFmV1BwU0REQlF6S3lyNUN6UUxQc0JRVHdt?=
 =?utf-8?B?L1JFQjNkcmw5NEVmTUtFT3FySGZibVRGMlZ0TW14dmd1bTdaUmEraVU0K2RB?=
 =?utf-8?B?aFgxRGwzV1QxM1Y2ZmNOQlpZbFEwbjMzZGpCQjFMbFBsbm1FOG84QWlLYW1O?=
 =?utf-8?B?d0VIZC9UVUxyby9uSnNsem16VEkvc2F2REo3bGxPUXBHRExjZllTOVBaNGFi?=
 =?utf-8?B?ZWpWSkVWOWpWUXB6eVdZNlJTMWlaSWhSOWFlVG9MSENKSml1QURYcVFBOEtJ?=
 =?utf-8?B?SHlucExaaWsyREJaSVd1RllOTndBd3VJU2VQcGI1OWF3Mk53T0tYTDdRaURC?=
 =?utf-8?B?cCtpNUtwRUR4aUxWNFk3c0pLdVd0TERlRDhyZUlBTWsxZHdtUXFiL3NVaGVI?=
 =?utf-8?B?KzFHNlFPbjZmbFlxcFQ0eW5kSExWOG9CVUxHaUx3WDhINXRQOWdMSVB3YmN2?=
 =?utf-8?B?ZGJPY2M2MXNZanEvK1YycGVWbjltYjZ4L1N4WGkvelhSOXVJb1hFNWcxVjRa?=
 =?utf-8?B?VWs0b3ltTS8wTFE4SXJwbnFtd2RWcTRSUkIyTXQvNk54L0k0Z3Y0MldNbWdv?=
 =?utf-8?B?eUZscVh0aW42SDVPUGNabkROUktaMmlqU1RxTUZTeU1SUndTeGlua1ZURjBS?=
 =?utf-8?B?NE5zQXZoRENWck5HdU1PUGUyVlF1Mk1yWjlseWU5b2oxTGQxSlo5QkM3cEto?=
 =?utf-8?B?QkRmZHNSSlVDZE9ReTQzTXBjWEZBalpnQmdyeHJBdTF4T2NidVU5MlpXNmdR?=
 =?utf-8?B?d0ZXWDNERkI2RXVtNVUzUHV1dHBWTi9rSnJVOE0ycFJOeDVoajZVak9ielV3?=
 =?utf-8?B?Tk80SkVBdHF5UXk3S1ZyVUxNSmN3WHI2Y0FzbjJhWlNuWmhTbU5KbHNlOStB?=
 =?utf-8?B?T3dwbkVJWWh5MDFXdFBkY2dnaTdqalN5bG1uQ2wwaFQvbkY2V2pMamd4QmJK?=
 =?utf-8?B?ZzRTQjJiK0krNWtaWXRhS1NpcVlxWWxVMEtpeWtqMjhNTk04MS9rdFV5TnJv?=
 =?utf-8?B?bGQ4K1pUSG9kNzRXSDZ4TmgvSU5KYjlXUC9UT3VFRzU4akFFS05YaXVRSFY1?=
 =?utf-8?B?QThhQm82YmI0QlY5MEpWODJsd2M2c3FnZlV5NC9GMnpvOHB4MExuZ2pLeWJu?=
 =?utf-8?B?S3l4Q1JObi9rSmx1MzN2YXZhZ2VYUXZMYy9COElHYS9taWhPaWhQeThSa2k5?=
 =?utf-8?B?QmczZlN1OU9zZXIwL3FJOTl1MGpRUWFsZDhRUFpSL3dzdXpRdWVGUDFSVWQv?=
 =?utf-8?B?bFoxQ3l4U3IrZzBnbzIzSzViRG5acEh3bEFCZVpKY3VXOWtmUWgrdFFYd2Nt?=
 =?utf-8?B?aktOaHpTRWdhTVFuREkzeVdiVFllVVBDVEwrR3JtNXJKaDRHNWZVTld3RFZ5?=
 =?utf-8?B?M1AyVHJJWVQyejRYakh2MFNoSWNYL0NpWW1BY2dNMmxmZ04rVWswUEs5alVq?=
 =?utf-8?B?b3dBOFF0VC9GNVBjaXlBSklIZ0dXS0llYXVBMGFFa1I0cnlhZUZCOU5LL3NJ?=
 =?utf-8?B?eXN5Mi9FeTBKeHRtbzFtTG1lSnFRK0Raak45dDFTNm81azI5VkxKUGR0WkJ1?=
 =?utf-8?B?MjkrME8vTWdVbjB4VzBKMHlkcGN1cDBEcUhJaEdKZDZEMU0xRDF5d1RmUFFJ?=
 =?utf-8?B?TVFJZVd3Nzcwb043a1orVVJzRTZFTmtPTlhXME5xVWxQSnBEdHhheDUwMjY5?=
 =?utf-8?B?cWZQVEVjTUV5YTB1ZFVOdWlVN0tQdzhaMUdDWlo2OHpkZWpBUEUxbkVSSU1z?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x2WL1VQfSD6vya1LEyWAjqsvICyDhNovCPadc0oFJE3E/JE4hb9ZIh22/X8/tNKNM/PMSCOJeg7fFYeHD7Kiy0RUeqfGF5Af1KGBLa7Jp5yNhGCZn0R5bMFUb8YOi7q457l1ld+X0rj8KErg3LnJ9cD9UM1n/r8n1rIG33yFv8746Fb4qAmpSfEad+5Ps9wpa2OkmZWQUFczy2rOu9V3YNohamp3lWiKUKDbQ3wfqcG9VFWjJZekMzYPcicR3UtT6sxjW9anJthJZK/T2M8LSb2U52LAU/TqbmxoVvKiMnWeZJjfaXIKyBk59bGoeVEcdzGolJMdvVlMp3fAWaLivxuQIzPMgfMoDnf+tdXucvOcuFlLkDH5MDwa+On69CCsaEvK8rjEZJ7YzqRLiRNTNEMPove4g0tFTgBy4ybp4Yx94sOcWBZSijckPv0WLDXXi2aFf7DLltxHmHiVBWHXnG2H9ODutbtxh6beRB2GwMd+CByQ845ZjghN9gBz4CAnFrRcOg2BNq9wTAgLMKUWybKiYOLvDT+jVCtkkoZHwwqgwNsPmzcXl+qHFsMHgfVuFdro0xUDdpsmz/BJf8KxY6cqRLI4ASRCxK1lB6YFdRQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39116157-c71b-4906-828f-08dcfab20e7a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 20:16:24.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1ZJmRqo0mL5cfT3uGhlxNyRmGZbKNanJbEhp2M5+2fz/nrIzm+wgKJTtT3BkWB3gQ/UzSeyRWh3wsN7mSb2AW0z8HnQ6xtuD7aGw+ZFoJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_14,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010144
X-Proofpoint-GUID: QpWxRYv46KESwOO_otYXXTfIXtTT57oO
X-Proofpoint-ORIG-GUID: QpWxRYv46KESwOO_otYXXTfIXtTT57oO

When boot-time page size is enabled, the test against KMALLOC_MAX_CACHE_SIZE
is no longer optimized out with a constant size, so a build bug may
occur on a path that won't be reached.

Found compiling drivers/net/ethernet/qlogic/qed/qed_sriov.c

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---

Ryan,

Please consider incorporating this fix or something similar into your
mm patch in the boot-time pages size patches.

  include/linux/slab.h | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9848296ca6ba..a4c7507ab8ec 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -685,7 +685,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
  	if (size <= 1024 * 1024) return 20;
  	if (size <=  2 * 1024 * 1024) return 21;
  
-	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
+	if (!IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) &&
+	    !IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
  		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
  	else
  		BUG();
-- 
2.47.0

