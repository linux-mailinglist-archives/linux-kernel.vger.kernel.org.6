Return-Path: <linux-kernel+bounces-204282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09EB8FE6AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CD32833A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854B195993;
	Thu,  6 Jun 2024 12:38:59 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFFE13B28A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677539; cv=fail; b=eBWQfeRZ8vykBpoMRMtkQix0jQgctwkjFAL9q+yKpDvm36sHJDNVratNqooqnUfI5Xo+oa7Z48Fsvwd49kDcS0lIqvieVtzSiTYubla/eQSUrLhaQw76zqBWOrWNd+k+U7C8KGh42pnJaEKlhUFWELMKmgCWhakSp4FcTY4cTqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677539; c=relaxed/simple;
	bh=ew15OwVogXyekIsX0nGXTQgmyMlBxXlBSTsIFtULP0A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dbk/ag4ogKsyvfKjbzRrmGFKmXoefizoPZjyIYZ+UeRIOmYVGymUovOEhXLUHjG4s1Pl+Bohl4wDgXWZA9ViySnSzyaEJgJOmlc65Mx5y/F+Ji5FLEWB4b+PDiCPluIllFbZGqz72uEWLg24ig/CqGe/qnYjr/+klaGs/ltK1xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456Ba3Q1029696;
	Thu, 6 Jun 2024 12:38:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yftm7w78w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 12:38:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0SUWfpjyLMFsSZ8CMj9K3qgOv2hSSiW+eLmRdINt0wYXuHkpo0vGoi/FHY3578DLNyzBiD+CSLqO8JegArU2OUzj14C6H1fVh4Nqon7CmRJXah+xFTw0pALk+7GrX4i4MkjPzLlkOrZbMVYcT/xUUOiyZV43SDGH9XyXOQAArNwTmEt9YAtLsMCiQKE1AOCIG2Q+EOfUP+tt7fZDM9Oy+K2PmDclQgH+dZrm6dvT9k7zgOHN2LVuBzw8szuoU56MXg18uyIkdhpVARpv52qutC0YPSu/YAySm2dJD6uaQcupHPY2M+Q1wEE/swT2oiaaF4shWhnIAHy75WcPxqBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUZaZDtZzrIfOAIrw/W/lPsTV6NnKa8GlkGnjDPmdJ0=;
 b=anj0aXQzO2h7Q/4KYg0VCQOSK2lqOszVzUNLr7hE0H3lsAOsFq7DWKsN0P9NN8yDkesC4vhaEIvT8ZKOS33T6LUAVvpS3CNPQRSZNybyT+kiPGYalsp04Fux4SvfocapcbC4n/qpM+HWoHUvq95kgdDYvWkAMp3xq4/QtvovQ+l1jp7BroB+gLoEwfXwnv/SfhfL45mku+1Mz7ntH25S3RZpKcVDwwQ3jBWeUsDA2ywiY7cbfyI39i1Ffo/BgncuhoqJdxzeZIpAVKBz0PcOfmpB4WXrBAUBCMa6KqI/F5PUqeI7AVkXyCfYl7zZ18Kr8HeGTJTcXJ/vOXIx9v71vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Thu, 6 Jun
 2024 12:38:39 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 12:38:39 +0000
Message-ID: <ea5fcbf7-408a-4edb-aefa-15f17e712139@windriver.com>
Date: Thu, 6 Jun 2024 20:37:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hpet: Support 32-bit userspace
To: Arnd Bergmann <arnd@arndb.de>, Clemens Ladisch <clemens@ladisch.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20240606094620.3946453-1-zhe.he@windriver.com>
 <5050968c-6807-4688-ad7c-24c19820f1e6@app.fastmail.com>
From: He Zhe <zhe.he@windriver.com>
Content-Language: en-US
In-Reply-To: <5050968c-6807-4688-ad7c-24c19820f1e6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|CY8PR11MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 7361b091-83d1-488d-460d-08dc862597b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cUJtMS9JSEpWWld3WmMyUy8vM0RMbFd0YXRaZGJWUlJlci9uQk1qQWpPT3RI?=
 =?utf-8?B?WU1EcE1zbCtodzI4dUM3SFRXQXRjZjc1Ykx6K1AzczhrK1JYMWZHZklwNXpL?=
 =?utf-8?B?RDRMVXRVM05MMGhhcVYxWUhtUkhxN1BiNEcvT0NsemJsV1dVRE5sbTVYZEt6?=
 =?utf-8?B?dTFDYlR1TnJlQ1ZKY0h3Sy9QZGpzdWpTQjA0WXlybHg0a08zMUt0M2NjN3lR?=
 =?utf-8?B?MnVJUVJwY1BBdjNyNjU2RmcvbWc1bXdoS0Zpc1J4VE44aGwxN2FwcVk5MkpK?=
 =?utf-8?B?THNxTGVIdjV2MWpvVjkxenVrOEt3ZG5yckNPL0NFRjZIaFhRRDZkOHVTalow?=
 =?utf-8?B?TnRsQmNROTNJbVJaTmRKbkhZd1VJQldxQkw5TmtsNzNxeDBHNFpNZ3VpTy9h?=
 =?utf-8?B?ZDZ4aDBwMTRqL3pCZ3RZNUgxWnpVZndkTlJMNkZxbG9Sbll2RDdpZUVObit5?=
 =?utf-8?B?dHgxTm5TQ082d2VCVFhsZjZVWHY2MzJtT3lDUENZTHcrWEpXQVp4SVdNM2lJ?=
 =?utf-8?B?UkZxU2FLdlhuSTk5bUdRdnI3YktBbmVJaVFkMlFndHJvbEdLMFZQZDNmSUl2?=
 =?utf-8?B?ZEFQcjE4VVZkd2JRWktPcGRJLzVuSzZjRHEvLzVrb2J3a29ubE5aclU3Z3VQ?=
 =?utf-8?B?TE9LQlRVMjlEbGNSZHZqZVZsTFNQUklWOTVVdkl2dHB2VWhWQzdzUG02Q0hy?=
 =?utf-8?B?ZHVNdkNScHpnZ1JrUmpZdDVOVTB5SWNTYTNCdlhzVEZXZmJkS2R4RXd4TElu?=
 =?utf-8?B?QW9ydFVuTnZkajhPVmVKS2YzRlFCd1J0OFVmdHcvQjkvMmZ0N2FMcmtmODdK?=
 =?utf-8?B?Q0tyUVBiUHRwV2F6L3VLRnF0SVpGV256cldWeWtadldRSDZVRG5CT1BDSCtz?=
 =?utf-8?B?dXJPUmhPVG54ZGhpVFpvRWx4RHYrdUQxL3JrNnlaTFZpTHJLTWV1MllZWUJF?=
 =?utf-8?B?ajhQU1I2azA5UUFTVllsWWdqTkk2SG5qV2JWYUhIc2JxaEZFT1NNQ0xMblRG?=
 =?utf-8?B?UmM2NjZqUXR5bDVUUGU0c2FEajNBNit2allqZVpybU1iajNvbGRGU1B4RVlm?=
 =?utf-8?B?b01DbEFqcjFvRERqSkhlenYvUXJPZ1RjUlFsR25wMThKRnRCNktnOHl6OU4z?=
 =?utf-8?B?UXdyQWU0TDRKd1o5TzltaC9INXI0WUJTSzZFTlIyQVBQUmJHaDRsdSsrcTRO?=
 =?utf-8?B?YnNEYWFXUEVlNmN0RGNmRTZhVFNYenFiYVBTaHRDMFZtUmYrcEdERFpCYkl3?=
 =?utf-8?B?RlNwa3QrNFFaWUthNkFmbDVGR2JsUmllajM1Nmhkd1ppbnQ0NUx4SDlFQTAx?=
 =?utf-8?B?aFNTM3Zjd21scWloVXpadFdOZEpUYmxLZ0hhTXZWNUFoRmg4cUxTKzZPT3hW?=
 =?utf-8?B?ajBVL1NZNnhENmVmUW4xa0w4Ri9CQTczRnhpd210a0FCMUFuZE1pOWg0ZUNN?=
 =?utf-8?B?TmN2Ym1kZ3dnRUs4SmZtRjdTdk1ldkNubnFHREV5UlE0Kzd1TSt3WFJZcWQ1?=
 =?utf-8?B?VnozODloUnM3cUt0d2FwZVJvaEJUbTFBK01lYkxiRDdnblBpN1FXTnZvMHR3?=
 =?utf-8?B?RGMyOVhRY2ZRdTNPdlU4ajl3YXVoREc4ZitOaHp0M0VrZzFNbXRBTGhyclZR?=
 =?utf-8?B?aEgyUjYvdzlycnloMHBhMXg2clkvWXRtd3FWUUM5WTY5cktFWWRERlFOZ2Zr?=
 =?utf-8?B?U0RBU2RhbXNKYXNkMWZiSFdOZktXN2tRR1JTS1pwRWVBbTBsT0ttbi85eSsz?=
 =?utf-8?Q?MGTSdgJBCEb25bvmirAhGdHVp9sK2iv2qAwDnEM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R28zMFJKQnExTEx4Z2hwc3Y4SnMrb1lHQXVDVSsxNGg0MU9ucHUxUThFMnlQ?=
 =?utf-8?B?WmtqVGVLVkJjc3o3R3lwTUoyblVzZW1EeG9QWm1IZWVKR2NwV3JMUXZNaU5i?=
 =?utf-8?B?MzZWcFVtRVprWTZKOXdBZWlIQllIUHYyT0t1OUtEZFNULzI3ZmI4YjVDT3NT?=
 =?utf-8?B?dzI4L2dESXNxWHFQODBPQ2RUN2hvN3J0cDl6MDEreXpNWFlJdXlNaUkzYWxJ?=
 =?utf-8?B?S0JyaHhTSlErMGpWSHU2am5iN1FhYXZPaUpuRG1rMUVhQUpmRXZkWUs0MjZ3?=
 =?utf-8?B?c1lsWG0rRHo5SEh1bHJhVzBhS1RwU2RCd1dVS1RWOXZJNmp2SUpZa3BscWNq?=
 =?utf-8?B?ajNSSXVERkFpTTZiakhkUUVUTWQydWYyY3BrS2hTUFA3bUdLOEQyeGVPZ2o1?=
 =?utf-8?B?SjZaV1lUaE5XSGpYZE1oY0FyVEpzcFRwalRYZmxyalR4ZkF3alJSOEJER0l2?=
 =?utf-8?B?aUV1VkcyMk5DcndaT2ZNcFVHVDRqa2hRNmtIQWZ3TldhUjY5Z1NjaUhXYWlh?=
 =?utf-8?B?SzRMQ3BDTS9CYjRGQlY5L2lWcGlYWk5KNFNkMXlUY2VRQWc4eGE4NjExVE8w?=
 =?utf-8?B?WVJ3QVAxd3hmYThDNmRFY01JMDU5d3pTSjZVWmxlOGRIVDIrTWIxWFYvTkQz?=
 =?utf-8?B?bWpQU3h6dElsTGdhQldQMFBsbjN6dytMV2syYTE4Z3BDbHZYWUg3eXJqbmxy?=
 =?utf-8?B?ZXNzV2p3OWxPZ2ZnM0RnbHFld2JrYVp3RWFta1FsZUhtRTJjQzRNdklLNDRB?=
 =?utf-8?B?TnIwTTZmK1lpdmVZdUN5b1BxNDVjSnRMYVZwRUtaTGtPcjcyNmwxNzVrcXJw?=
 =?utf-8?B?Q210bXJFZThxWmdEQTBzU2JsWXFRMmR0QStwYXpGOS9zUlNtZys2anBkTDA1?=
 =?utf-8?B?ZG95QkdVcE1kbTZsQ3NqQnZGczc0cVlFMXR5VFg2TWN5NytDYlp6TjlvOTJi?=
 =?utf-8?B?K0pqbm9Zd01zWTRMY3pQU3lUOUI1RjZYa1p5Y1NuNE5uS1ZYVUwyK3FwNzk2?=
 =?utf-8?B?YWVQQmpTaHhScHJKVk5vMEtvdzdhOGZmcllkQ3d4Vlk4R2gycmxXQnFsN254?=
 =?utf-8?B?am41MFVRZWQxQ2ZNK0FKQ2pBWXh3RFBqSTJWL05SOCsrL3ErSkNISlRLRG1H?=
 =?utf-8?B?OXVtZXV2cEhoMDVDSkJzMXl1MlpaamNndEI3b2tMSmhzdUZpaTd4RjhiZS8x?=
 =?utf-8?B?eHRVTzVETDdrdDUxcmh2dzA0UXE4LzRqVDJmc3Jwd0tlMjlwNnN4Sm03Tnli?=
 =?utf-8?B?aU9yZE1pdG9HaCthOFBIMWNkeGJhSzVOSjdSKzVyTG9mQXdFNzhLejNnelk2?=
 =?utf-8?B?TWJqM29ZR1hzQWtHRWl0UXpldWxRaTFEc0ozWkhDdFhaYkZlV3dKYUtLRWFY?=
 =?utf-8?B?b0E1SXpOOFZyeHYyeE5HbFBmTUd4cXhwcnJ3aE9ndUJjcDdsYlBXN1ZWOFQw?=
 =?utf-8?B?MUFqMnZPSHp4MGlMUFRuS1FXUG9KMnBiVXB6Mld4Ti9uaVM0bGNiU3FtRzVu?=
 =?utf-8?B?alVMZEFhbzUwbG9yTlAyNitxeDc2eGcrczlvYjEwajNZQ0pIV2JZRzRPM1Ns?=
 =?utf-8?B?VTU4QTN4Mkh6YkQyOXBjTU44NlFtUndTV2c4RFVaRktsOTV6RVgrekdoejk1?=
 =?utf-8?B?VmJHcWdUV1llTit6Rlg4Z29haVp5S09PSmtQbEZUeU5vbVBqaGFXaHlrU2k1?=
 =?utf-8?B?djYyVyt5ZGtzc2c5N0ovc01CTFpPREE0MDdiSDJwR1M1YXVuTTlwNXM2NFZP?=
 =?utf-8?B?RUtQN0dzeFExY2Y1VFNGQzhhK0Q3QTdCMjQwQzRJaG1oVkhnYklNOFRUOTVx?=
 =?utf-8?B?Q0pBTGxDRWJQL3Fwc1JCay9CdnFUUjQ4YUZlWU9zdy9RdzRPNFVMSWF5dG5o?=
 =?utf-8?B?WW9aQThBc1V1OTMvQkxjM0J4K3ZMTm1GZGg0WklMTW83NzJHa2ZxWkdjUlVz?=
 =?utf-8?B?ak9WVmd0aDFNSFF5bGtTcWE5RkM1TWdYZGZZSGNLNkV2Sk1UWkZFR3VTY0tC?=
 =?utf-8?B?WVlIeUhXZlJySE5Ud2lDZmVucjExckFsVE9qdjRZVWR1dXNaZWtnaEZWOUd0?=
 =?utf-8?B?UXNVWlh4N1ZmU0Z5U0M1Znl5RTdadkdOQXcrV1Q5RTFDMS9ZTG1kSlJyeXYx?=
 =?utf-8?Q?MqWc/n1ebQhNjRUcJleCjuryG?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7361b091-83d1-488d-460d-08dc862597b2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 12:38:39.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jrs2lqe3oa3oOJpWmaKAsMBTalX+iit+qczNhRx1gLD7ZkEaQluSvMwNGdVCDLKb8N0J5SGYEN6Y3UkY6gDHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-Proofpoint-GUID: cwzbCcmNRQAfc6gEft5uE9QQx3_pKZgP
X-Proofpoint-ORIG-GUID: cwzbCcmNRQAfc6gEft5uE9QQx3_pKZgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=891 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406060092



On 2024/6/6 18:34, Arnd Bergmann wrote:
> On Thu, Jun 6, 2024, at 11:46, He Zhe wrote:
>> v2:
>> - Use in_compat_syscall to determine if we're handling 32-bit or 64-bit
>> - Drop unnecessary compat_ptr for hpet_ioctl_common
>> - Add comment for COMPAT_HPET_INFO and COMPAT_HPET_IRQFREQ
> Thanks, this version looks correct to me,
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> I would suggest one simplification though:

Thanks. v3 is sent.

Zhe

>
>> +#ifdef CONFIG_COMPAT
>> +	if (in_compat_syscall()) {
>> +		if (count < sizeof(compat_ulong_t))
>> +			return -EINVAL;
>> +	} else {
>> +		if (count < sizeof(unsigned long))
>> +			return -EINVAL;
>> +	}
>> +#else
>>  	if (count < sizeof(unsigned long))
>>  		return -EINVAL;
>> +#endif
> The #ifdef/#else is not really required here, since
> in_compat_syscall() is defined to return false when
> this is unset. For both cases, it should be sufficient
> to keep the part inside of the #ifdef block.
>
>      Arnd


