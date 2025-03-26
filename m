Return-Path: <linux-kernel+bounces-576478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC07A70FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62AE81705BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989315DBB3;
	Wed, 26 Mar 2025 04:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YM//LUdD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BDMQB1p0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C095477F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742962166; cv=fail; b=f1PQqoG2fLeWcbO35yTD1zCCPfN/PATWbXVr1ZfBjGVPmBCkJbfhlQGHPoSO5YPTE/Ett4KU+Z2KztEkncKPiaLLCQVqxbzlok4fV3gBttz0YuVQezlf4KUFybQ1Yml6AJa0/Jexsh5sGksLVc6Q/J7/aaBAk8aKChMhzMH0DNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742962166; c=relaxed/simple;
	bh=iv0KwVYq6q9W50HOkUeDkLSq1DPqdo5L4va7PYKtTAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VwmIO2N68lujATG0PNveIBNicF2lP+oDgCSM4ZB9J+kq0aZaQV4Xy+xkDuMat11MRMn1sYY3/8Tc+csUAlflGlgoLzpTtoTWRTR/R1NLdRxgas4J21QkNcRhnkDkYL1S7B5Plb+cXeeZY8MUn4FJ21UzxnsOLM3pu9AjamRAVhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YM//LUdD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BDMQB1p0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLuZQF000803;
	Wed, 26 Mar 2025 04:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uNomfswMIZBvKVrL+K5N5Hw/r62erHhbs8VvHWVBVoM=; b=
	YM//LUdDVEWOXY6J5PfhwbSKleE6yiWpMKa04FjHCGEt+kBt0nTwb5afNKJKmfbO
	lrIvu5ax/S3/vfiWY47zZRCViLP6dvFtsOjg9IjiS1OOZd/dBmK3zsNOVg/6/k/o
	YcX6GMVvWDV3hjAaYGl5Ec0UEHZfr3bgi2fVfGbuRbZKmM85vmajc/iBuIIiduwb
	Ctu3HzYL0qBzpLpx9FR+bGRgSCv1xfK4ltQjNxP5z7tezcjZ5KjtRXRZx4AjmkDk
	3PTwqwaZfkiuOVc9+R8a+saRxuHcO3yXMBu5NfGRvztaCA5K5uUHQuev8ILVgBKM
	eHkhD3d8fdXt5qm0iheMpA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnd68gym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 04:09:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q3ZSdR008200;
	Wed, 26 Mar 2025 04:09:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6v1fm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 04:09:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbEe916Wq+OkVGX+fuF/e9IWqDTwLhhkgn6omQGiYILHKZo/cj9JUPukeXBQIN6RlR/w5z5zBjyNDA+IEeqoryzhQHVS2Ec8TX+O3YoyOrxjdZD1H9jQEiBswVtH9H6y78spbUEn+ApF07z1T0AWV4Jka97wAANfzVPLPTYg1MU2oBK9KAVkvR10+xHcks1dG7SVb7VGakRFunzUtgVH923udskgIg3pij9KeEe2GNXdS9dD94j4KisT80JoiUJ1kDeFFgFRVCaPGII5usa33VYojHIPIRiuI3ja1zdc3O1V9m7ujAiAZ++tuWcCvlHmRU8TpPxVJ/Mm7EhjbSaGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNomfswMIZBvKVrL+K5N5Hw/r62erHhbs8VvHWVBVoM=;
 b=DqWd+V3UiQeemN2DEeuM//V5hfenyNGYm6XTeofGytsxyk0IhrsRElovWTbgra8iHf2AUPwgta8pNk5Cbd5cbw4V7Int22kg9Gju8QFWRyb2DW7csCsG8Tuvhe5bZhVTbmSbuUQkKt0xubs1x3heBDtrlvfphgeLACtVUrFVZOLEBPOmUuNK35ZBx7YXIT6lmLnH9/wIR+kLmkmd0HskMWw6GTMrD/Qz363H3uOhdK2O/C1FI1EcRX3aI0USj5rtBWNeZdq9YY2M6ci0DBfiwOTFHClmjdNwBW/LW+cF/tWS2kGyu8YZtk3wjiaNJZ6V6ybflB0Y3416NjgfzAaUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNomfswMIZBvKVrL+K5N5Hw/r62erHhbs8VvHWVBVoM=;
 b=BDMQB1p0pYM7Y8RClo5mGpWzWdxNVGE3fyKqGOrt/IyxrrK5v0Vh8ACmNADJLslZZMfNcXhjUxKVd+T7mhaVNk7WupkmeTwt5TRhnPuq1KlTz/QvurlWGQZCSG7X2z/FprbqXQ4c89Su9q+9nG/P4HKRLE86y/ISXsohpnsAmfE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB5989.namprd10.prod.outlook.com (2603:10b6:8:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Wed, 26 Mar 2025 04:09:13 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 04:09:13 +0000
Message-ID: <fcf84b1e-c117-467f-b34b-c906b3663f39@oracle.com>
Date: Wed, 26 Mar 2025 00:09:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testing/radix-tree: add cleanup.h to shared/linux
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, "mingo@kernel.org"
 <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>
References: <20250325214049.87817-1-sidhartha.kumar@oracle.com>
 <1ab95590-9a70-4380-af43-6b21a158fa7e@amd.com>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <1ab95590-9a70-4380-af43-6b21a158fa7e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0038.namprd19.prod.outlook.com
 (2603:10b6:208:19b::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: d444b212-cb46-41bb-fb24-08dd6c1bf770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW5tbFZMOFpFckUrUHdCSkprSEErNExjellKVk9VblFjZUhYSVBYNkV6MjBN?=
 =?utf-8?B?ZzY1WjBpVmZjZEpEWFdCaDlGMjJUVzc3bXFBcEFydkREd1BOMVBua2VtMlNR?=
 =?utf-8?B?eVFNV0hUZU43SzVHaVR6NkNxYUdZYWRHcXl3VnZHNTE5MVZKanZaM3VnZVp0?=
 =?utf-8?B?WjlPZUY2aUJFcWpKdmhrcUwxMDFDanRkcHd0YkhTSTM2bVVRM0lEK05RWTVC?=
 =?utf-8?B?T1VrYktlRDkvRGdJTjNWOWxFVWdpRUlYT2Z3Q25BWW04VUE2UEFGdklKL09P?=
 =?utf-8?B?MG93TUd1eThVSlNWbG9wNEFCem5PR1R4d2dTTlp2VGJjelp2UXJoN0cwQ0dK?=
 =?utf-8?B?NHlYMUxUaHlTalZ6bWU4SGtzaDVuSTE4eVgvZEV3RG5YU2ZoSzZZc3UxcTl4?=
 =?utf-8?B?azRuTjRwVzg4Q2VTRHAxdXpMd09YOXdKbGlPTkNXU0lyNXhDSmpwdGtQWmFh?=
 =?utf-8?B?MHNseDZGRTdRazZldDJZNFhPcGEybzdQa1pQdXFPdlcxR1FYcXJkaDNvWEZJ?=
 =?utf-8?B?ZVgxelRTcnZmSDEwOEc5b2JFcm1iaEhkQmRXM2N5TFVjWEVxSzZzRG4yY1Mv?=
 =?utf-8?B?TzlyNHRhOGRIeFlMS2pTZ0ZPVjZZWFdYT2ZBbTIzOVVKanlyYkZDQ2pJZHBo?=
 =?utf-8?B?TUcyS0lsMVM3d3NVeUt0YWlwZGZkYXoxblkzL1VhM0w5NzRicWdYRHR1TUlT?=
 =?utf-8?B?K0ptRXFsU3BoZTZXL05zU1ZnYzlYMWJXb1I0am0wY1huZ0JYV2pvMUJYNjNH?=
 =?utf-8?B?UUl6UFhieVVlYlNMKzR4Sk5jTUNJMXlFaU9kTjZOZ1hJSkVRd3NycVcySTVo?=
 =?utf-8?B?T1dhQWM3K1M0STFQZlNUYVJoTDBSdTJVSEVWUENvcllJQXN4cnRZTGh3clFa?=
 =?utf-8?B?UW9KWDJpMldtY2l0TE1kTktzSzRvQWRTZkQ2TlpReWtUbXhHYUJDRWs1ZnZC?=
 =?utf-8?B?ODB6NEF1b2xkdExVVkhQb2dkbHMzeVlaQ2Iwamh1OVF4blVncFdTNU5IRlZQ?=
 =?utf-8?B?eGFyR1p4WVN5aXlpUVhmQ0dCMDFYMGY2VkJaQlB0eUNGYmJscUJpZ21iMjRM?=
 =?utf-8?B?eHNnZHl0ZEFjNlF6azB3MGxLRGQ2N2cyNnpJWjRLK0JUVnNMYkZmKzYzMm9I?=
 =?utf-8?B?SnBLVzFYY3F6YktVYkhiKzBISHc0RUI5UG51YTRka1pRNmZJODU3cWM5aUxs?=
 =?utf-8?B?SDRRamJKMW1DN2FJdkZLaEZ5eEVvNUZoMGtlYzlWTWIyWDBUeWJFRFp1eVJj?=
 =?utf-8?B?Q3EvVUhLbEpHZ0JaQW5taVZMc1BKclhMa09XM2hzemRHQ2ZackY5eTZOYVU2?=
 =?utf-8?B?VjVmMERCR1lJcXN3MFNrSHdPbG5MZ1J0NjZrYXA3NFBQbE1jNnJZbURjbis0?=
 =?utf-8?B?eWxuRlNoUEx1ODlpU25zckV1SkZJWENta0hwKzFMTE5LdFFZN2RqUHpzc0Zx?=
 =?utf-8?B?UW5pd2hyak5ldzNqajNSQi9MNGphdlpRblJ4a0w1SFNRMmovN1ZVYW9KWUU4?=
 =?utf-8?B?WnpNS3JyL2JvRjhvMGgreU9SZzRsOWFoUEU1QXl3Y2VCREZrVkxKaFBpeWpr?=
 =?utf-8?B?a3YxcGxFNE5COTFXb2dwbGNya3d2OEZFMTE5SlBVdS9nY3NmL2tKTEVXSUNy?=
 =?utf-8?B?Z2tnT2diQmhHMVRzWVI4WFhaT3hqSzgzVnpZWE5NTHBKQ2dETWord3Bab3Rr?=
 =?utf-8?B?TXZtSnJJM2EvWUc4d0w1NVd5Q3gzQjFBbVE2V0VXaXN1bEhBeHBOcnF0RGUy?=
 =?utf-8?B?akt6R2xtZGZLMjdxZzEzZWZRSlRmQWpGa3hCKzc0bm1jNjl3bHVhUkVZNGJ4?=
 =?utf-8?B?QjZZa01OUGpXOVc1a0NGOWUwT3prakI5SldubEcveTU0Q1pzVG9hQWE3c2xF?=
 =?utf-8?Q?JYh5nh6kF68o3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VndHcmV3Q25nOCt6WFYxSndOSE1OTldzOVpnSlBoTWZKNlF0S2JiQk81YTAy?=
 =?utf-8?B?bkoyVUxab1NMMXVwcGVsK3p0MU1vaE1laW1HamMycHJXRVVaS3d4YlppSmd5?=
 =?utf-8?B?aWs4S2VIOWdDcG8xY010QTRIdTczQlRoOHM2ZGxheE12YmQ5V0tQSFcraS9a?=
 =?utf-8?B?VUh1RCs5ZFlrL2JaeXE4YlV3WDZOdXQyWDA0QyttU3U4Zy94OWI5NGRSMG5V?=
 =?utf-8?B?YllPZm5hUEt3VUxrMngyU2tTOVpDdmRVNFdqbGxWbjJ5UTdhNlhyMDdHZFor?=
 =?utf-8?B?Y0g1VUZrTitCQmtNdnd5REtuTlhUTXoweFk5ZnFVb1JIcUxnZkFSdkhEOGNU?=
 =?utf-8?B?NGx4ZHkzb2V2cDcydmo3bDN3K3hReXRhUmUxVWkwWjBXNDUrR2ova1M5eGkx?=
 =?utf-8?B?SC9FaVlDbTRhc1AvbElLSFN3THpoenAydCs3d0R5aXZyNktlckF4WjlZYktn?=
 =?utf-8?B?SnJNN09Wdi90R2plb0FCM2ptUThPM0JKVzV1SW5HY0FDMTU1SnZLakxqa0dw?=
 =?utf-8?B?TC96L0NaL2NLNG1abmVGa0g3S1NLRisvTWt6Y095VkhKc1ZveUxZRDlqNVd3?=
 =?utf-8?B?OC9BSzg1MzQ0bUIzc3krK1RjS2RVc3VvQVJhY01hWUh4SytCa3JQditmT3JL?=
 =?utf-8?B?eHM0dGFlSGFNenRMdWltY2RGb005TGdQN3l4YitjTDdjYkVWaklrTXM4bmtD?=
 =?utf-8?B?eGFnQXBVY3RuaXJvc1pJakJIbFFpblJpTHFlRXd1TDRwQWpNSkpXVlpOWGdO?=
 =?utf-8?B?SlQxTHpuWmp0Z0FHSUd5QitkVVNVOXdRK2oxeWR6QzFiYVR3bEtFWSs0OFBX?=
 =?utf-8?B?UjV4VVdQeTl5UzdReGEzWGNja0ljK3B1Z2lDU1lSN0Q4cWtnaUdKTndTc3Nr?=
 =?utf-8?B?dS9jOFZQaHBqWU9waWlTSmo3MkpVeVB0K3IyWE9jRDZsR2kvSTRvM0dzaHpC?=
 =?utf-8?B?eDJWWmhWamhPYkg0SXVadzVlZHRJKzFYVlF0QllFemsrclJyZzhOTEEvUXFR?=
 =?utf-8?B?eWZSNm1uQkE1MUd0QUxUUjlHdWU0d0gxQmNLb2JKd1V3TW8zcDdEM1JTd080?=
 =?utf-8?B?RkdNakxDYjJUOWJzYVlmbk5rMnBPY3FkTldSMTdlRXEyT3pZbFJmR2dQTFdy?=
 =?utf-8?B?Nlpkc1pJSVhJY1hxTWpTRFlVVmgzQi83SGJ2TW1pY29idytDMktORkdRVCtC?=
 =?utf-8?B?WTlydWpFWVkvSnZydjlHRmlpdkFyY0dRYWxGUDJrUTJ6SEV3S09UYWdFdTVP?=
 =?utf-8?B?b2NEK0tHUmNBSXdiL1U0Uk11eVRwQnh1ekh2OU91UE5ZK1BpOW03Sk1RYVhq?=
 =?utf-8?B?QjhiN294ZFZJeVlNY3c3SVpQQjdXakVMVG9DVWNLRUthK3V3SEIvMXpYMVo5?=
 =?utf-8?B?TDR4aGlxZzVNUjU4TXNoZFBXK203b1NRaTE1SU9sSjhRZzdkYldNZ2VQQ0x5?=
 =?utf-8?B?cUh5YTJTa2F4R3F5TGRVL3VCczQrbXhNSGdwM2pBbHp1TEd1cFhqd3BieXox?=
 =?utf-8?B?Y0paLzc5NTB0UHNuRnpueWtNcHY1UGpYNURHbXpxSWNIbk52RmdEQ21lK0tL?=
 =?utf-8?B?UWZLd2x3Y0dCcGRyQTA4RWx4cjNiaFo4S3JwaEZ0VVp5NEpPaklXMXFWcUtI?=
 =?utf-8?B?ZmplNzJtQ1hWbGtCbEJ4Z1RGNGRVNTFlNktOdlFyb1liZW5UendLVFVRREcw?=
 =?utf-8?B?KzY5eHJ5VXRtS2owbXYzYjhZQStGV2s5VVcvdnFRbmxEbU04K0xCcExDR1pE?=
 =?utf-8?B?U2M5ZGh3T3BBblFNZlFuV1JiVGtrMFlEMDcrUThQMXVGc0JlUFBPQWVLLzJh?=
 =?utf-8?B?UldRNkMyZkVyTks2TEwzdWtDY1hicVR6WkpITDVhMC94cUZVUTMvUEFyUUNW?=
 =?utf-8?B?TGgxS04wcWFzL0JHV0VzNWxWY1l2SGx0aWZMdHlubVRuNWNjTWkreU5NUnZq?=
 =?utf-8?B?NS9uTllkUG41SnpIek1yWjNLekZNQk40TmV0aGpMZFE3ZExOUE9CdmgzZGwv?=
 =?utf-8?B?RUZLQ1JZdWVJR0VIMzJScUkyekRzVGxBYUNOMFJnaVVsSEtnTkNON1U3eDZO?=
 =?utf-8?B?ZHZncTMzWHhlRUxoaUIvYUhKcjVsY1l3SW5zekhuTWx2V0NWeDVxMzVlVVdK?=
 =?utf-8?B?NVVLb3QwU0Qrc3Fja2lvTm1QQ2NmL0EzQ1JkTFhyalc5bzV1RFZVR09XY0Z0?=
 =?utf-8?B?b0plUytJa3JwZkxUUG1tWWdnOVVwT3pORStUU0xIbmVGUWR1V1I4ck5LMzFD?=
 =?utf-8?B?bFVhSzI1TDVJcnl2QzZWaE1Nd0lRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xTpIydZInUmcWkLpIlFb5MDcEI8UDjPAYEbQ5aeBKT50JdANHPtcALSSijQUUen4lhkh+riMwWA9Z8koK2lwo7u4g3lZlufzjlMWzrYTqVMOp18z0L4SmS0nGdKKV1i/jOLRXPUv6JpIUHMa8qRoqWRTVeyI/rhgZCzvT166Z3O/UeugQ6zzW60rBNcKWTSPoTg7bQIU2GISU6/StuFx1v8IF+chwn/odsg/jXmyB5wzSEztkEyRkV0TFRJr6Qhxy85r6gUj5cXYqE3JWLGq+2OplDA8fYTtn10e+NCEjg7Bf7PD1zIRawqGKM2tgpz2pl4F/6lF8kpNKNu0UMiiNFQ6nG7khwiGkdXGU0dOMnLc0R5GPSwBK6y1wRkbFlyiAdVSMA/qC2fYYFkayD3iMNfikz2o3YDCvPesY7HDe8ubFmepaS0l+DjfP64gwAKl9CRMbrwyDd+pcvEjgbZ7305QefZjq8e48IThNS7EErcSZpSN8LcPRI7qiPVdqgCiJgy71lgmS9Uhu0MBF8bRFoY6HnpE3iUThBZxLHCyqxL3GFiuXiri2ezk9cStZW6MkLShSudvYpOBwR0JJw0GhtEEjWycfDpbCzaARxW1Jek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d444b212-cb46-41bb-fb24-08dd6c1bf770
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 04:09:12.9383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dz2eGHEzJjFE3xJ8BxjDEJgyEj3WLdzc/9YVS2YuThWp+WUn5LS0piR3NuBpmIE758/sGg1FMWbujQ64NB3yrhiVsED0mA+YfbmcVa7Wxd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260022
X-Proofpoint-ORIG-GUID: JRx0kHbjXpApTZMJ0Fv8Egm4R0-TEOyF
X-Proofpoint-GUID: JRx0kHbjXpApTZMJ0Fv8Egm4R0-TEOyF

On 3/26/25 12:06 AM, Ravi Bangoria wrote:
> Hi Sidhartha,
> 
> On 26-Mar-25 3:10 AM, Sidhartha Kumar wrote:
>> Create a cleanup.h implementation in tools/testing/shared/linux to build
>> the idr code within userspace. This is needed after commit 6c8b0b835f00
>> added #include <linux/cleanup.h> to include/linux/idr.h to build the
>> userpsace radix-tree testsuite.
> 
> FWIW, similar fix was posted few days back:
> 
> https://lore.kernel.org/r/20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com

Thanks for pointing that out, this patch can be ignored then.

Sorry for the noise,
Sid

> 
> Thanks,
> Ravi


