Return-Path: <linux-kernel+bounces-441964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDE29ED624
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09885165FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77564242EE2;
	Wed, 11 Dec 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LStFnb3T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JZc327+P"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBD23691C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943447; cv=fail; b=f55gHlvIB3QeiqSTMY7+mZe4z4liMMnARDY7XPsO1b3lneialzbJrssE12OVhEH47/XK5AoRyUV3Ms1UZ66yLSje9UX72AQtQ53abQMKFDTXjq8CUKluVlwUkttkSYBXzF/Qj4d7vJ8II03A1oiZfLlq+7UuR5G/U8J4VuW8PS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943447; c=relaxed/simple;
	bh=AqbQzoTJ11CThHqhGqxWRRKp/tx4NC8NtihejR8viag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WtcbXZvMHC4IUQ/kOkxs2gbxD2YmcE7TNiI66RMuYI/V4qKTR7sbJnpgwQIWOQjyAo1Y78Q11aCQ/xfLJQa2h7qnxJkL0DBxhbcgm+J9VVk012Tzah/65ZqsuXxkEm7QR6uX/Hrckau7+gNjGLioqhM2b2oyVBexh4OcLgZL/GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LStFnb3T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JZc327+P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBEMvs4022056;
	Wed, 11 Dec 2024 18:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6jcPgsO79CH2X+amn3Quui9AHa/LhsHM49vO3P6om5Y=; b=
	LStFnb3TuTBwAR+tbq8TVXjBsM+UUz8JvRT9A/oTZPqGU+qieJ20bYG+0FMqNm6j
	1yK7128p5yC+NbqZ6zBK6P4Yu76WxE5vSlchfm7DcsWdGxJ11ii/B/T3HMfO0pt+
	qyuhucTj6So8peEiVI0YaNE/EfAEVc9ln18ZhMxCB3KwasVGCRTSEyRZF8uWSTZ/
	pa+8REtS5/61jNeM3yjuynk7MnWch6fRC1ndqhaAZVyy8ipSTqBqADRefrSom+OI
	rVOw62vQjF4UxIEypCRJFTNegBWBNayUg/Z3NpN9lqP04HAITqQ21PmQER4XTahs
	DeIq12bu6MjUvYqPTaEp4A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s6j00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 18:57:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHxRd9009482;
	Wed, 11 Dec 2024 18:57:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43ccta4b6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 18:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFWQRo8XOJ8YyaRLC3TvwlDPnjJkpZ+JnCzAcctwp3hJRyYQyzQwCzXXJ7Q2AKLa/Zs5yBkaMiQD2C/GQI0iJj3qnlHUvZsG2IbpnRBk0SuIyjjv4s8jJvnaL/FcQDFPmKtJFhTNxGZWGhD4OZQSCzLWn6vSsOUvlvJ9Zqh2fv4fvebeCpnpVQ5HmrpAxH+DpOzxMsIYqtYBh7lZI5RL1Kpaj92UzTgkzSkR3/XyWeLqXEZkdk2lOFxWBFvSCV5W6KMgmt98XFeiMlcQvkFjfbCxZq7jGR4mQn36bcjGkj4tZUDQQX5CiNnwm9zRNoKJTe1ThE7EV+ywYeBVToSv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jcPgsO79CH2X+amn3Quui9AHa/LhsHM49vO3P6om5Y=;
 b=rhU9LqC4VGMzGnxYgIg/CYPS7p8EjmoyxdcOG5RASth/+FRBEk5lQXg012pk39rEG6ndbVheDpVRJhqmNE9hlTFJ8rbhCpbT/sj5J3ylrt6uu3gkVWEhdrzlXuw2W+VHWlitrnyTD0H2f+Bi2mH9eo3Vc7rtkERjlBilTnTjVNf6lcQB+tTVXFUuGqazOhUf420KIn5pn0/wul9mq6KGb3PlyYXu+5REWvGAhf3wT7QiFSdLOE/geWV2LN9KkQYp+J+ZhrIouf4z1AwvfTjz9v4ngLciWIQT5KjLufyEYtwobGGXomrYFtY43ovAMNwwj+6zVNAbaHfBXZBPi8Yhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jcPgsO79CH2X+amn3Quui9AHa/LhsHM49vO3P6om5Y=;
 b=JZc327+PD+G/YFCpIdMZCEbeFipOvSG+RQ4NccQdYt/L1OPsNzOTNdhZ+3lzdlibPnW9A9h0LHCvmZ6BLH3UKbFKyq/7WPWVwmCOhH1Cx9NLIFr76n7Ck6je0UKN4XHQktPjm3WnnZT+Ayc2XojeDRac6TSrvuxZnI8gGHVkqb0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6064.namprd10.prod.outlook.com (2603:10b6:8:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 18:57:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 18:57:09 +0000
Date: Wed, 11 Dec 2024 18:57:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
Message-ID: <a2c43cfe-5c99-481a-b599-fca8b4fe1e38@lucifer.local>
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
 <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1064ac-603e-4a37-c014-08dd1a159d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0pXTElYRnZxRDBiNEZ1SnAxVUhTcFo5YThOL21xS1B4b2txWm5aSThaQ05y?=
 =?utf-8?B?czY2eXRBZEJYS0FKRTMvNlBuM3J4aHhsVFRGaUhNUGdzR0gyZ2tldWU2ZVdk?=
 =?utf-8?B?dTFHeld5Kzhkd1k4ZTFSOG10TG5Mbm9pd09DWXFYQjdIdk1rZkVDZzgvR0My?=
 =?utf-8?B?dVVwQVI0TThhN3RibWlaVCtya1JJNHcyS3JvWHFVRGhkMUR3d0pmKzhxaWNL?=
 =?utf-8?B?dDRUajhNeGcyZ2YxdlcwY3EyNEFMYXlpKzJ0YkwwQ1k0ODJYUFFxOW9Ub1lS?=
 =?utf-8?B?UmRhUXdWVCtSYU1rVXQ3NVYxaVlmUW1pTlhxaXJQSURWeWdnVmczUFJtOVpy?=
 =?utf-8?B?dklUc0RIbVpOQmczd2ZVY2ltdWpGQWtubnJtbTMwaEtLeVNxMEVVMXJQaXh2?=
 =?utf-8?B?eHpGTVZrUEYyZHZDUlVURzUrWW9yTFR6S3FPVmlXa0N5Rm04KzloU05LblB0?=
 =?utf-8?B?Q29MS0tJMlplN3hQU3NSVkJieVhJMU9pY0JhU0E0WXVSbkY5c2JTV1pwRXFR?=
 =?utf-8?B?cTdnenpJMFdOaWRhVVN2OENjN2ZLV3NLVDRldTNmZzd0ZkVtVVU1Vm40cXRU?=
 =?utf-8?B?RlNNU2xjYjdkRm5HcEIxRUp5M3VaOFNKV2oxYVc2bWNVcW5BMDk3R0t1VVJH?=
 =?utf-8?B?VWlxZEkzR1RhR0dkVU1ZdFBMeVZMUC9CcEdWMnhOMXJqZFhaZWh0MlR1Y2pI?=
 =?utf-8?B?YThKZ0I1NUVaeHRFOC9jaXdsNEJnMVI0T0VxS1pyeFpkMi9EdFduNFh6aWYw?=
 =?utf-8?B?MlBkR21jNmk3ZmNDbGZqdmhRKzI5VEJDNEw5YjNBM29tNTFmRXNsdUZzMmNW?=
 =?utf-8?B?Y21IUHoyaDV4NTNlNURZSG1zU3BCRXNwS080dnFBLzFtbDAyM1YvTE9mUUl0?=
 =?utf-8?B?VUZhbzg3U0RjVSt1dnJTbW1obmJRUkNsRmo3OU4vZ0daUGk3UGdyS05lMGd3?=
 =?utf-8?B?Q2FHWk14dHdZbHZNVjFNcTBIYStnazR0clNYb0dDTGhEZEc5aG15RlpiVVAw?=
 =?utf-8?B?bC9sZG5FYkxpTjVyWDd4VUxlSDh2TU5GVm5XWW4wVzFFWXoyTTB1Ni9pQ2VK?=
 =?utf-8?B?YUhKL3VaQUlPWHBxT2ppUDVQNzY1MzZ0V1B5VnQ0a2Zhd2wwOHlGQUxlK2lT?=
 =?utf-8?B?VFRrUXdIcmpvdDlYazMrcTU1N09qVy90K3pxNUxqTWJSVHM0VjNZRFNVN2ls?=
 =?utf-8?B?RkNFUnJEbFFvVmMyM2hNczUzQkJnYjF0YkMrblhQZ0w1Y202VENVaHJpZjJp?=
 =?utf-8?B?aGc5MlAwajhYT2o0TjNwZDJOQjMvQ3pFaFNTdUVockZtTlZiL2tHQUhtSzBL?=
 =?utf-8?B?aU12Vy9UdGpXL0NnNjNaeGkxR0hkZGtrVHJTQjFWa0Z6K1NxS3dYcjRwSDhD?=
 =?utf-8?B?YXBuZkhSQ0h4VXJYeGRkNjl2U3VjRzNwMDY3V0RqTDY0eHA2cUVYUkhlc0Nx?=
 =?utf-8?B?SGFZNFRsRnRUOUg2VEdEWllEdTJpNm43blpyQXdCbTlIQm96aGlaY1RFbnB3?=
 =?utf-8?B?aDdacGdJVGVRUXYya0diaENYd1hvRGRZWVhOTkswUVdjNDR5YXlJQTZpWGkv?=
 =?utf-8?B?RDZuZU9sUktjQTZ2RXFlc1NPRzlOQ3pHZnhsZEZ1b3lqMHJuaURrenA1ZkMx?=
 =?utf-8?B?a0xpM0p4d250Z24xWDdWT0ZJTTI4VTN2NitSZTJyRDlVS0M2U1daRndUSGN1?=
 =?utf-8?B?MDE0bjFEejdyVEFia1BnRWpMQ0VhNnZMajVPcE00dkcybkpmanExL3ZtMi9C?=
 =?utf-8?Q?5TugRjLntXgpfXzc5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHhDRjcvWmtUdnErUEY3QThCUElaSlNzNW1KNjRFVUpwVUpFRGt6VDVleUNa?=
 =?utf-8?B?akVhRk9IOTczQmt1dlgxS1RqendON0hLRXBWa3V6NVZSS2llQVN6RWt6OGFr?=
 =?utf-8?B?eUg2V1JGTXZaRG54V1htT2JqT3l6anE0eHZSQWFDRUYyS3NVdWFZcThETnVP?=
 =?utf-8?B?ek9QS3J3VFVLeStLemQyelcrNHJmSXZseXhNdnowTTY0WjFlZlR2QkwwYjBE?=
 =?utf-8?B?eUNxb1JzeWp0WWZweGErUGlsSHZ3VmV3SWM4YWF1SlBOQmJXZXVIU05kUzRu?=
 =?utf-8?B?NmxvSmRzbTEremlDL2pYdFFvYlFUbkJza3FsZ1phK2x4V2xXT2oxTWNMYUdj?=
 =?utf-8?B?TFI3clhFYUx1NldWSUVWTmU1RXFBbVNYSWF2dEVZSnRIQ2RVaEdtbHpvaTdO?=
 =?utf-8?B?eVlwWm1yTDVDc3JwUytuMGJEWklXMG9CZ0lVaC9JcnAwdkJpRE1nS0FHcHpl?=
 =?utf-8?B?dlJvak9YWkp0bXZDRWJoRUErQUxBKzk0OXVTU3FBRERNYjJoUUd6MU1tUHdW?=
 =?utf-8?B?WjhVTVNqSWhLSmVnbTdGdlBSNGQ0VXZpWFhLaHJsUjV5UWtvMkNGMEYvbTRJ?=
 =?utf-8?B?ZjJYNHA1SHBSRWtBNklpazhZMUFHZ1JBY0ZYQjh5b0lBa0k1TFlUczlDU1NB?=
 =?utf-8?B?MTF3T2swdGtoQkZhVE0zL1BFcDJ4OS9FQ3ZZMng0R2gyWXpsSHgrTExJRUQ4?=
 =?utf-8?B?UmZuK0FMUDY3NklkYk40ZmEyMFFGVXJIUTgxN0RHNEJsWmphQUFWbWN1UHZB?=
 =?utf-8?B?Qm9MYkZpV0UrZyt6bXJlRUxBTC92c2pPZlNWRDl4ZTc0ZjdrTFczMGc5eDFJ?=
 =?utf-8?B?djVNWUx6S2UzamF2V3NSZlRjejdUNW9peENhSmF6TllPcHZpcm1IZFY2dE8x?=
 =?utf-8?B?ZXppMktkMERVL1U2ZEQ5Smd2MEorcURrSVE5Nkowb1hUMEh6SGRRTmJ0RHpC?=
 =?utf-8?B?NWlaQ2RucTJsOEVWbCtIMjFDQW56N0c1cFpEZG9GcmVCNFFsREQ1Z2l5ZU5F?=
 =?utf-8?B?SEkvb3F6UFNlbDl3RW8yZ09uY085ZVQ2S2NCRVc4MGVlKzRyYnlDMWRvSkll?=
 =?utf-8?B?SlJCYmxWSWZIbnhaU0JQS01QcVhlZnJ2eHlVTGRCMTQrVjdVeDhKeXBGblpH?=
 =?utf-8?B?c0VTNVFIOVpNUHFURnNXSlMwaWhtVGlMOHR4aUxlamhQZDVWanJiUG5vbk55?=
 =?utf-8?B?OXhGbGlRWGU5TUtXZzNyOVFYT0NVdzlEWXI2eEs3a2p3V0RmYmY1UGM5MitJ?=
 =?utf-8?B?RHNqQjBMc1NsZ3E3bEMxMDhLa3VsKzFvQWZHL3Qwb0hHN3Y2SHU5UUJFVDBZ?=
 =?utf-8?B?dTZ0d2Jla0hqTXVzRFhrTFp3WGQ2cXZLY3JnS2dFRHFJeHl1emNRUVJZZ05i?=
 =?utf-8?B?QndrdkFUeGI5UDhhb0g2QUwyTk9od3ZwOE5HdEVuYysvU0lrUXlVelpXV3NJ?=
 =?utf-8?B?OERiUWtUS20xcDFlMWh2K0NMUE9oRWlDaU1tcnh1UDVnTitnWTN0TVpScEc4?=
 =?utf-8?B?TklLaERNWW9FUGNRQ3NRK25WRUtaMVM2MUI5R1hCWG5RSTlOUnk1d0VBTnZT?=
 =?utf-8?B?R1dpU01yYmJzZ1V3aVF1d3htaEhKaVU0VnpUQTJmSUhhbnE1dGlENkkrSS9m?=
 =?utf-8?B?NEhGQlVLS3FXYXFxM0dhcXZMUE9LcXRmU0hqOFZ4cXRzS09oMkFzU1lLak5r?=
 =?utf-8?B?cHY3d1llZmVpTW5oMFdDY0M5QTMxbE9ML2ZoMXlTUFpMV1RQTXJLTkpYTzZp?=
 =?utf-8?B?aTF0MlJwdE5tOUVxaDZWWXpsbTN0RUZPcnIxZFlNcmlySlA3K1NBeDgvZG1i?=
 =?utf-8?B?VW0yNnY2SDdEZGc1eXgwR2lKU01zOGgzN2lBTlVRbG5FQndqbUM5RWNiTFZl?=
 =?utf-8?B?MnB1aWJyV1BzWFV0M1VJSjJnQ3BnUGRqUlRETHVoK2xxUTk5T3hJM201OEEz?=
 =?utf-8?B?L0RGc0tTRVgzZVA4djJDeE9pbzZqa0lkTThNT0tyS0lQazBkS0hDdFJERkMx?=
 =?utf-8?B?aHdLS1VTK2V1ZTV5VDNhM1pnUkpqSHFkNGpLREFVTjNRdWpEMnpHaVdrODBI?=
 =?utf-8?B?ZlJ6RytaU3JHYW1PcHRhNkdMbjdNK0VuSiswZHVrU29OUXlyK1dxdFZ5Tm9W?=
 =?utf-8?B?UFBOWjlxa3NOaGtDcjREUHlGZjgwU3dZaFl1ZjZzQ0lGNDlFeDBkZVpRMFNw?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mkhU3N08W5mgGGuJscmNv6jP4SejbUBEDGV6LDDiOc9kOoYBL2aWFGatPaT6h8J1s8WmVSBKCGy6vVKZTasuk3qGg6yArzYtExbEc9MjDCck6JD1bscaaoPTmKVfqpALh+TmYOZqHNrkJEmjwrw7HQNmOU1eSFjUz6sOtD1K7j3q8kDqUBvdq/kq3B2TCzc3V1W2ulqJfN/bCQZ0n1vfUJvPOh0a4NbzqLLLp0sg/moiUm/qlDisXLcdR3X0xvsytV1PasZDdb5MLsy7slL2uoGjNweUcDo9E7FlGFSkO6ufivehj7Jj9XQ7edKn+d67ED+WAbUoJgi50DhXtoTNMpALe2aBA8e3GRcsKAKf3Om2VAxmkAcTb6zypn1JrlXGELEnUg6/idJaXI0xVxsYdyZIl+y7lWQZBvWUs995r+tW1tMH7w/HhVaCx4PibdMGwEE65lFsz6X3bXGzSNZ86qqGZZ/Xe6N8IF+pKrialsh+K6Nn3Db4QTmE7SA6p78lDYBqCIv7sw6u/JffMXVay4IbjuIj5AyVtr+R9SjUEDl8yupyChiHvMBy6wlNRUoM9K9IJk2ReK9TFc2SlA1Y0u05WD4DZIuc4pZcwPEwm/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1064ac-603e-4a37-c014-08dd1a159d67
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:57:09.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAU0RMj93cbimE8A3y1hQXuGaISi3IMinV+vR2eoGxB/6wE049KwtZq/qv4gfVrTc35QmtVnanWTtQbdcEf7IwruFwNwdcNFQdD+gzJSk9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_11,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412110135
X-Proofpoint-ORIG-GUID: nb74h01bSynlTcYvc_x-M70MwYsBTodd
X-Proofpoint-GUID: nb74h01bSynlTcYvc_x-M70MwYsBTodd

On Wed, Dec 11, 2024 at 10:36:42AM -0800, Jeff Xu wrote:
> On Wed, Dec 11, 2024 at 2:53 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Update the MEMORY MAPPING section to contain VMA logic as it makes no
> > sense to have these two sections separate.
> >
> > Additionally, add files which permit changes to the attributes and/or
> > ranges spanned by memory mappings, in essence anything which might alter
> > the output of /proc/$pid/[s]maps.
> >
> > This is necessarily fuzzy, as there is not quite as good separation of
> > concerns as we would ideally like in the kernel. However each of these
> > files interacts with the VMA and memory mapping logic in such a way as to
> > be inseparatable from it, and it is important that they are maintained in
> > conjunction with it.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  MAINTAINERS | 23 ++++++++---------------
> >  1 file changed, 8 insertions(+), 15 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 68d825a4c69c..fb91389addd7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15071,7 +15071,15 @@ L:     linux-mm@kvack.org
> >  S:     Maintained
> >  W:     http://www.linux-mm.org
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:     mm/mlock.c
> >  F:     mm/mmap.c
> > +F:     mm/mprotect.c
> > +F:     mm/mremap.c
> > +F:     mm/mseal.c
> > +F:     mm/vma.c
> > +F:     mm/vma.h
> > +F:     mm/vma_internal.h
> > +F:     tools/testing/vma/
> >
> Will  madvise be here too ?

No. We had a long discussion about this on another version of this patch :)
it's blurry lines but it, in the end, is too much related to things other
than VMA logic.

We probably need better separation of stuff, but that's another thing...

> I'd like to be added as a reviewer on mm/mseal.c.  Is there any way to
> indicate this from this file ?

This is something we can consider in the future, sure.

However at this time you have had really significant issues in engaging
with the community on a regular basis, so I think the community is unlikely
to be open to this until you have improved in this area.

You will, of course, remain cc'd on any mseal changes regardless, so
functionally nothing will differ.

And equally, this change doesn't alter my or Liam's role, we will apply the
same review regardless.

The purpose of this change is, as the message says, to ensure the integrity
and maintainership of logic relating to memory mapping, and mseal is really
entirely a VMA operation so has to be included as a result.

So it is administrative in nature, ultimately.

>
> >  MEMORY TECHNOLOGY DEVICES (MTD)
> >  M:     Miquel Raynal <miquel.raynal@bootlin.com>
> > @@ -25019,21 +25027,6 @@ F:     include/uapi/linux/vsockmon.h
> >  F:     net/vmw_vsock/
> >  F:     tools/testing/vsock/
> >
> > -VMA
> > -M:     Andrew Morton <akpm@linux-foundation.org>
> > -M:     Liam R. Howlett <Liam.Howlett@oracle.com>
> > -M:     Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > -R:     Vlastimil Babka <vbabka@suse.cz>
> > -R:     Jann Horn <jannh@google.com>
> > -L:     linux-mm@kvack.org
> > -S:     Maintained
> > -W:     https://www.linux-mm.org
> > -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > -F:     mm/vma.c
> > -F:     mm/vma.h
> > -F:     mm/vma_internal.h
> > -F:     tools/testing/vma/
> > -
> >  VMALLOC
> >  M:     Andrew Morton <akpm@linux-foundation.org>
> >  R:     Uladzislau Rezki <urezki@gmail.com>
> > --
> > 2.47.1
> >
> >

