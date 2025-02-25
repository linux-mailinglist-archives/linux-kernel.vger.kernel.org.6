Return-Path: <linux-kernel+bounces-531009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1ABA43B02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B523B23E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A92676DD;
	Tue, 25 Feb 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D7KsomeS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zWM5DUhV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C426771B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478132; cv=fail; b=SOfyCTM0gokdz19IF7VbJDDi6UKMJIEXu8l/3MFQ71O04RL8vZ8FytMghTWs6cR1ftDsq8pmaxbx0mCAx8gsAlvcJVRiHziSqCjOaH12G4DMKO4KUIPCOQjtqJNgCnt8YAltrCMv7uKqwOWUEYaZD44KpUEeL10VW2f0+OJRBHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478132; c=relaxed/simple;
	bh=IKm1zrVGQ7Hdj0dQAmn9kCO2wd+USvixugQoUNbuCdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eVZYyGlAe/5ZCpG9YEpG1tQAXRA9CmlDagbXYM8dBPtuCrdTSqG8/YtCRy652z0JqdApQ+RxGy61LwD6lp7VRMzU8FUSsTX0qK3f96e8/mbKBXVqtzFsZ4WMjRYHh1fhrNkhNwILgtt6mCyS2PLxkvpuCIslRQmQ3fijVYGg26U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D7KsomeS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zWM5DUhV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P9fvFp028652;
	Tue, 25 Feb 2025 10:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WAiq/7yhb2+HcV3WXNfyOYxze0eVUT1Rlqk9/IyBDXY=; b=
	D7KsomeS6XBu/msUnoL6yfvakKIaLJHJJwMUXzeu9Taap3Jk1S/zlNMsGUMlOTyM
	RcPESLIgWJF90hpIehVTlg141oykzf4+esq+A2s2h1Z02+bAwA5MuLICrLbH44XH
	iQGbQZl1N/JNm/qn01EZ09ne8rc91QtYLi0hk66exKQ5wew31Ek4WYzGY5XBIyUN
	zzFBzMiKImrMrDnreR1yXOAuZlMdR09Hq7VRZVJ7pl26pWCO5TKeBJkyvat/HtE+
	Q2OLuUvVDh+UnQaYYj66VUVR9KR92np69aLQQFvfhd9uaNHg/SNlWdj2Sx2pwCK2
	N9Y0V5/7zetX/cwoCJF9Pw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bmq1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:08:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P9mYMn025436;
	Tue, 25 Feb 2025 10:08:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ffmmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:08:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iob1oHEhmcb+IDn+am7dQFXZuzjRdzTJXK6pjHM3522WEXIfzAPKfhySHGC4wh6yCxMpYuEZsAxoxkIFnjNJQiEhUH/J6YVD9W1NuciCB8BndfDsIuv8BuUZUABXW0IeDa07Na4vNR2K0jNk36AMtGgojV0T+ZyiAcqkmAhL05zzais9HNSQSsOg21YtzVFyLq1frfaEwJvCgYyoYwGp8LYGvnxmisaoJ0nRlIPUpQBwPG1VbVriCJzLqJN8ZiSjaYmWHa4BB9latpZBpvahRogkxLkURtnMbi3h6DKwTx9HzoVG7Eeqga7LCpIIhs5Yb9H+9soA+Kd9thJlnqeSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAiq/7yhb2+HcV3WXNfyOYxze0eVUT1Rlqk9/IyBDXY=;
 b=eIzzP6gDoK5DENtJ1Z2LMI0dEHeL73TdSAnyk9y2OmcBDDYDQZncW6KgM4PLgS6ITueaE8EtP9OpSx27MrSGLR39Fvc7pxQ3dAmCmBbV53OGR6KgS2vdtL+apAbLu/uLaKwLPbt2jTcaqvumSX3ob2UUYEQGzgfVDXlstws2Saw7rW8EwGojMLuOYF48fKn9PlM/uhh3MHTm5up1xSkan1mr91LRRsHZV52FXke8f7h+MfXpnfsQMlGA7P2zzyhv+7oVKqAFQPAILpBo65163CpTItVFXL12+cAf3ewMTibKrZ/vvFKfJQY0leI7TmtvK8hNmhTRvUM1VQhOBIX76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAiq/7yhb2+HcV3WXNfyOYxze0eVUT1Rlqk9/IyBDXY=;
 b=zWM5DUhVqPCR0g5RZ92jYbD19e6LPOYneYk/eqXFQ6XgDg3lVogvO9qrLpGdwOzRDSA03M1hea2gcr8B0Z2DU1yVeE0OIsRqnPG0rrT590Vw7STKwDmLykzMLW+YydTxVRePAtlMfEj41+xUwSUcYI/WqUI9qbtsYUiT0DVws5A=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN7PR10MB6953.namprd10.prod.outlook.com (2603:10b6:806:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 10:08:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 10:08:25 +0000
Date: Tue, 25 Feb 2025 19:08:09 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lilith Gkini <lilithpgkini@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
Message-ID: <Z72WiUlhxOGnrXFb@harry>
References: <Z7DHXVNJ5aVBM2WA@Arch>
 <Z7blsPJiOPTFWEL2@harry>
 <Z7b0CvTvcS47o7ie@harry>
 <Z7iUVJA-luvNaIac@Arch>
 <Z7lLXCZB2IXth7l8@harry>
 <Z7mX6PFxUptwX0mW@Arch>
 <Z7u2jgDadOwceYeN@harry>
 <Z7xiHTN0Q5yI-UmP@Arch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7xiHTN0Q5yI-UmP@Arch>
X-ClientProxiedBy: SE2P216CA0031.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN7PR10MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: cecb0f0b-63a3-4c1f-40ff-08dd55845766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG1OUGpJbThZQTdiUjA3ckowNXNtVWxPOVhCclhmVGwvcXluSXRlWldJbGJV?=
 =?utf-8?B?SUpsL1VkM096M1dqenpDNjV3TWNkUWdqZ1FEZVRyRFBJQkhDdDk4L2R4bnUz?=
 =?utf-8?B?QlJNYTB0VGFESStOV0RURWVhbEsyY1hJR1ExSk9idis5M3hPSW5XalVZYnV3?=
 =?utf-8?B?bUJ0SnhPL3Y1V2xUZVByUzlrMXB4V0RnOVd2SzNkZzBBZU5kR0ZvbW1xRXFm?=
 =?utf-8?B?aU9YV0k5ZnFEcko3cHM0d01WYkMycklkUk9zWk40a2UvM3FDbHhsK3lLM0wy?=
 =?utf-8?B?OW5jQmxyZFJRNjVBR0JzSENKOGYwZTErQlRMdlZIVnhhajg3eFZxcE1JQWsw?=
 =?utf-8?B?NkNQaThYaUNnZ1UrcUUxb3dtWkJ2RUh0TVJmaHBkSE1WM0VmcmtuUWFaMEtL?=
 =?utf-8?B?cU02clI0US9Sd3RxTXFWQU5vbTZvT2lZc3RsWVQwZTA4NURZK29oVEIzcjMz?=
 =?utf-8?B?YmZpeDNRbnBSblVIRGMxS1gvU2t2MXg3V0R6OXB0K2ZxYkhNR3hJaGZpWmVv?=
 =?utf-8?B?NTBEY0VCUll0K0FDQ3g3TUt4WFVFNVUrcUhsQ1lpbXZMeExMRHJzQk9oV1BY?=
 =?utf-8?B?Q0tXUEwwYjRRU0ZPTFRtTnZLUlA4MWZJTWJnTGk2QjJENS9qQzdwWXlmODNG?=
 =?utf-8?B?THgzZEVYeENzaC9XS3hiRDBKSWlpYnhMeEl3VkovT0JBb0p3djdHWm8xQTBr?=
 =?utf-8?B?MHdyM09nbURnL0ErYnZYRzBkN3NFeHB6RGtHc2w4Y1dhcTBJSXhLcTI2THRl?=
 =?utf-8?B?bHdFNXkrSnlvSTFvcUxnQXhzY3dQM3RZeHdwSEFPRlF4NStBQ2lPcG9MUDVo?=
 =?utf-8?B?NWJ6Q0VGc0dwS1UxSUFZTWVNQkVxbjlXMjU5OHFMQmsxNTVSaFNPTUJ4V1NM?=
 =?utf-8?B?ZnFjU0I5UXEvRkNUdWJFNFNjNVArTE44ajdSQUFtT2lhQ3BNYnBjbCt0TTF5?=
 =?utf-8?B?WjZHMFNnMGJlK2NDMWlzdVZ6bnU0M2FIWlc4SWtESnk2RkNzcDdQYnI3TEpK?=
 =?utf-8?B?eldUNXBIVmhVWDFob05kL016NU16UlBKTS9kd3NFWHNxeCtpcjhWeXdqZW1u?=
 =?utf-8?B?ajhuRmpuN1g5a3NmMkJuWUdnT0I3SVJqbmJ1OXlhRkRwQ2ZvdCs5V1d4V21G?=
 =?utf-8?B?aHM2Uk9xaEs3YjA2aWhWTnRiN2NNY011cWNMVkd0YjR2NkQrS2NQSUZmcDNa?=
 =?utf-8?B?dU1BVlRDSGh6N3JjNytJV1Z3N1BSSmxBaVBTVFAwZTV2L1NRYW1VaXdtRjBz?=
 =?utf-8?B?YnFEa0JTWXVMK0Z2d1ZHR1hFNTFneTVOdEJmMzFrakdsRmo3REsrMmlNWWNL?=
 =?utf-8?B?SitaeG96TFBOb1ZxVEZYK1RQSFFFMjlBd3ZZaWx5ZW1Ycm9pMjJBSmlqcyth?=
 =?utf-8?B?dXRZODRJV1VOS01XNWVRSkd3K2FndUlxOUhlemdsUDJvV0V3bTdhendsanhZ?=
 =?utf-8?B?cGdOSTBYZ0NjcW8yTUxaODFSU2VnOFg5S2V4VTE5YU9vTDNBR3FNZUVEZ010?=
 =?utf-8?B?WW9reEdSVnVnYnNxTzA3MGFZeHlmdnpQZ250WHhFYWxjSlVrMzVmQVBrdnB0?=
 =?utf-8?B?bGxFQjc4QnBqbWlybHdDOXcvTmtYZkVKaHpyTkYwOWtZWllld0oxV1I4QTQ3?=
 =?utf-8?B?TDJHb2xUU0JxUWZaMXJVY2xRbFUwdmgydUowQWVndWtxMU1wTlYrdGM1Rlh0?=
 =?utf-8?B?MGpEemlwWUtKWHU5MWNYWWgzdEd6d0FobG9jYnRNTVIvUm9hQkVYaWNDQjhU?=
 =?utf-8?B?RllWS3FsVDBOVTNoZU91THhqaU1Zb3c1ZFdweDBpMnpwVWFjdTEzMXcwR3hX?=
 =?utf-8?B?SUF6aS9YaTdTQS90TkMyd1IxekYwZXNmTjg1Zk9pSVNYcFg1TCsxRFNqV1o1?=
 =?utf-8?Q?oh5hfRsY+PVHX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3F2bFpkdlBlZ0lrRFV2WmlCMjc5NysxTXN3bEhxVUs3RGdadlFHMHYzd2p6?=
 =?utf-8?B?dFFmdE1yYXhmU0Qva1dZaHYxZ0JRQ2ZWVGpFWlZxS1VqVVZnckVnbGRWcWVH?=
 =?utf-8?B?Tmp1QVB4N2cyRFlYYzF5Wlc1blVia0hDUGpyaVRDcnBLYVRFQjhkZFkzSHJz?=
 =?utf-8?B?dE1pQ25oS0JMRTdmbmJWMCswSU5ycmlWd2ppblEyM0ZIMXg0T0lOSjUrL0Rw?=
 =?utf-8?B?TEpTclBhb3B6QW13L1U1aERDRTVUNklzVkFJUlozSXZJb2R0dnZPNXpNd1Bq?=
 =?utf-8?B?RFlrV2V4TkpaT0EzL0l0RnF2eGhOMW9VdnlhNy9HeHpvdGVSV2V1cW5MR2VP?=
 =?utf-8?B?T21nNjltSTZJNzRCN3l1aGVtanZpNEpUeGFydERkR2FMM2o3SXAwWnNSSzZN?=
 =?utf-8?B?UVVvVExMaGgzck85ZEV3b1gweVNFZEkxRHl6WldQQ0VTVmJpTlM5a1U0dzFR?=
 =?utf-8?B?UHpIdzNPUFNycXJCazJTM2lhbDJtKzZJQ2lFVjIyWGRlN2hnS1ZmL29XSVB5?=
 =?utf-8?B?OUZXY0E1YUJBNFhuR2Y4a0dlOG5XRWtneGNjTEVld3lUUjZkQzFaeVlMcmQv?=
 =?utf-8?B?SnVDNEwvTExFV2VhYjAwUGt0bzhSOTlJYUZldDhMWXZ2SFlIR3gzQ1hxQVU5?=
 =?utf-8?B?ZW0wUHkycmQ2bkRpMWtheWhyenV5T21Cdm1GOHJuRDRMTjZHenU4bkgzaHAv?=
 =?utf-8?B?dGNaODgvZmpuVmF6UVRyK3hUb0hnOEo4c2pZRmMyMEt0TVZ3RkhIKzF5VlVE?=
 =?utf-8?B?ZEVBb3dEWU83OFBVMnVwVlcvT1RITTBMTE00aEs4enVjQkxJN3pHYkQ0VDl3?=
 =?utf-8?B?bVgvUEg0c0hTdzYremN0WEVmSE94K2VJblp6SE8xK0diU0hMUWtiWms4SmU2?=
 =?utf-8?B?eGJYZ1VmbHRRblZ2L290RjZkWHZlQkZiRnVRRG5CSVd5WmdOdldYMGMzOXhJ?=
 =?utf-8?B?ZlU1QzBnQ2tBckNQN0x4b0VGcFZXR0RONDh6ZlVHS0E5NCtnQlp0V0RzVlNM?=
 =?utf-8?B?cklUTDNqbTF2S0NBUmJIcDdaSWliSlY0b1o1Mjg4QzZxK09iSmJFVVpFcE1J?=
 =?utf-8?B?akd6ZmkybVIzWnFTUE44UVlnV3d6SW54a002RGhFdUsxeWNjcVUvZVV4TUh5?=
 =?utf-8?B?WjZnRUdwU042Lyt6bG5aeTlmdlBJaThUSWVVSzhFS2Z2Z291OCtpQ0k5WE5r?=
 =?utf-8?B?Ry9ST1MvN0pPZThRcVp6RG0rQjhpeGZ4S1JxSkxxM3R4dHdSbWFkRkMrTmhk?=
 =?utf-8?B?VG1xQXRpTnNyL0I2M2gzYXFldXAzOEUwdndYK2NmWDBPODRTZWFXelNCczVn?=
 =?utf-8?B?NlNSeW8yQmIvZFlFd1dhMUtpWkhBMUpZaDY2NlZKdkNUVncvbk5ZblRGaWdx?=
 =?utf-8?B?Q0tRNjBIaEFrVTRwU01nall3SVRVcHNtUHRkbWZyRlcwOEZzbjNOZlFFODFM?=
 =?utf-8?B?bWkrdVJuSC9rK0pScTdyK0M0bzR4ZkZPbTZGVDZ3eElEalA4RmZneGVOSFBX?=
 =?utf-8?B?cG1uUmc2cVg2aWYyTEdrT0pZK2dFVko3STlUek9IQkd0MzUzcGd4aittNndO?=
 =?utf-8?B?RVR2VWlmYzdjdjJ5Y1N3RlEvMkw2UWlaejU2SDd6NGZzMEFqRjJMeitjcHNM?=
 =?utf-8?B?dE1hZVlJc3pva3A2c1U5V3MzUGdhVGdzSG5WT29wUjV3aFBXQjdwamZwbHQy?=
 =?utf-8?B?U3dZN2tZVVVmODhkbE1waDV6Y1BXNG4vUHhERVNlWG5HT2E2R3czSW1kTlpa?=
 =?utf-8?B?Tm1LcVkxdmtUZ3JEM0lSVWVyellLdU82UkJkK1BKQjF6NjVvSDhPRE9sREdQ?=
 =?utf-8?B?cnRSQklLWnNxcmNIeTEwNHBxcU9hMVVNcythUzlzb000MlpUUjZCREVMNUVK?=
 =?utf-8?B?MnNVMzllQlpTR0hleGZvcmlOcmtEdy9IaHNOWXV5eGhvUFpqLzRwVHliQjJm?=
 =?utf-8?B?cEJtWGpnZ0toWVlidkNyeEowTDVnYUtOYWllYklvb1Z4cnZrMU5vdXhMS1I1?=
 =?utf-8?B?dEU5cUQ3MU5zZHRkS0J0SDQ3QkFQYkhqMmNVeGJENHR6RFFuT1RWUWZRbmYx?=
 =?utf-8?B?ai8yZVVYUjFqQzRWcUFjOFNJQUx6UmFlejZiMFAvRnF0VXp3VytyQ1ZYamNP?=
 =?utf-8?Q?/EI8JUbeTSER9N2PBpppbz3UF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	13jwRkTd9w7PDuTwU9msRmTO7CNEKobLXY+At2fVXyfmlJ01SOuIDGgO4KfblOHrKeyTldIt4Jew73GeFhnYNl/NxSIdwPCXkNH72bpbqmSsI47N+P+lUzNu5h/uKDLWvXiR5MTFIAvLNXUCbjjYrxcKZH7rOzH6ZZ6POYL/ChHWJ3znOLLuZgYAIHr1kbiz816rQ4k1ZK2AsMifC82F0HLw+pc61/TWNbPUdmHzCEEu8od7Ud/OOyfFJUdTMZrSCJWZQJiIiwHOtD1wNFDd9KMJ0bodpc+tszg2gK/vQfMM4y3qAFat4LWc/GvfeCGTQVjtaaL/+V5sxXmGsFenzgj0qtaTfcIEyMqXo/kfK0Yx+efti0YhkTWonTlkvMwMk9+wGRwsZZgWnu/PxIE8DbMVVI8eJ1F0T23OH0Erg4H4/7TBk5QYYiaSKuoBy2BmUMAu6TjcusAAHR2m4U6FfTVM5XHC0v53x/E4JLedMI+T7S4cVsH+GEH8lve3advYPwJBOGfUZesa1ivbRRFYFnVRAyv3n3suVDxHUaXlZYC0AF1/p8CAqKyGsbTF1Sz2p+Im5A5rfGLVqTz/WEnIl0aMMBtsCmyOcXFSIDx8fqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecb0f0b-63a3-4c1f-40ff-08dd55845766
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:08:25.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78dqItYm3PmoDldZXELHOPVK2FRIGh/AAfcgW4QqP/4a12Sy1Lfw97plwncAJ0ErIbYGR98Aeclo9HunuyutCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250070
X-Proofpoint-ORIG-GUID: bK2Ox8tXM8oeuGs1hnVFttsNcM-Po4hf
X-Proofpoint-GUID: bK2Ox8tXM8oeuGs1hnVFttsNcM-Po4hf

On Mon, Feb 24, 2025 at 02:12:13PM +0200, Lilith Gkini wrote:
> On Mon, Feb 24, 2025 at 09:00:14AM +0900, Harry Yoo wrote:
> > On second thought (after reading your email),
> > I think it should be (fp == NULL) && (search == NULL)?
> > 
> > When fp is NULL after the loop, it means (the end of the freelist
> > is NULL) AND (there were equal to or less than (slab->objects - nr) objects
> > on the freelist).
> > 
> > If the loop has ended after observing fp == NULL,
> > on_freelist() should return true only when search == NULL.
> > 
> > If fp != NULL, it means there were more objects than it should have on          
> > the free list. In that case, we can't take risk of iterating the loop
> > forever and it's reasonable to assume that the freelist does not               
> > end with NULL.
> > 
> > > The reason I m saying this is cause the While loop is looking through
> > > every non-NULL freelist pointer for the "search" pattern. If someone
> > > wants to search for NULL in the freelist that return 1 will never
> > > trigger, even for normal freelists. If "fp" was ever null it wouldn't re
> > > enter the loop. Thus the result of the function would be search == NULL
> > > because the original writers assumed the freelist will always end with
> > > NULL.
> > 
> > Agreed.
> > 
> > > As you correctly pointed out there might be a case where the freelist
> > > is corrupted and it doesnt end in NULL. In that case two things could happen:
> > > 
> > > 1) The check_valid_pointer() catches it and fixes it, restoring the
> > > corrupted freelist.
> > > 
> > > 2) The check_valid_pointer() fails to catch it and there isn't any NULL.
> > > 
> > > 
> > > In the first case the problem fixes itself and thats probably why
> > > validate_slab() worked fine all this time.
> > > 
> > > The second case is pretty rare, but thats the case that validate_slab()
> > > wants to rout out when it checks the `!on_freelist(s, slab, NULL)`,
> > > right?
> > 
> > Yes.
> > 
> > > Also to make my added suggestion of `return fp == NULL` work in the first
> > > case (since it does corrrect the freelist we want it to now return TRUE)
> > > we could also add a line that nulls out the fp right after the 
> > > `set_freepointer(s, object, NULL);`.
> > 
> > Why?
> > fp = get_freepionter() will observe NULL anyway.
> > 
> > > But words are cheap, I should test it out dynamically rather than just
> > > reading the code to see how it behaves. Feel free to also test it
> > > yourself.
> > 
> > Yes, testing is important, and you should test
> > to some extent before submitting a patch.
> > 
> > > I know I am supposed to send a proper Patch with the multiple added
> > > lines, but for now we are mostly brainstorming solutions. It will be
> > > better to see its behavior first in a debugger I think.
> > 
> > I think it's generally considered good practice to discuss before
> > writing any code.
> > 
> > > I hope I am making sense with the thought process I outlined for the
> > > return thing. I probably shouldn't be writing emails ealry Saturday
> > > morning, haha.
> > > 
> > > Also I really appreciate the kind feedback! The Linux Kernel is infamously
> > > known for how rude and unhinged people can be, which can make it a bit
> > > stressful and intimidating sending any emails, especially for someone
> > > starting out such as myself.
> > 
> > You're welcome ;-)
> > 
> > -- 
> > Cheers,
> > Harry

Hi, Lilith.

If you don't mind, could you please avoid bottom posting and
reply with inline comments like how I reply to you?
It makes it easier to follow the conversation.

> Alright, I managed to run some tests through a debugger.
> 
> You are right, my code isn't correct, `return fp == search` should be
> more appropriate.
>
> So I think the right way would be to do these changes:
> - 	while (fp && nr < slab->objects) {
> 
> -				fp = NULL;
> 
> -	return fp == search;
>
> The first line removes the "=" so it doesnt iterate more times than
> slab->objects.

Yes.

> The second line sets fp to NULL for the case where the code caught a
> corrupted freelist (check_valid_pointer) and fixes it by setting 
> the freepointer to NULL (set_freepointer). Now NULL will be in the
> freelist.

Yes. but do we care about the return value of on_freelist()
when the freelist is corrupted? (we don't know if it was null-terminated
or not because it's corrupted.)

> The third line is the return value:
> TRUE if the final fp we got happens to be the search value the caller
> was looking for in the freelist.
> FALSE if the final fp we got was not the same as the search value.
> 
> This should make the validate_slab() work right and if anyone ever uses
> the on_freelist() again with some other search value other than NULL it
> should also work as intended.

Yes! that makes sense to me.

> For my tests I wrote a kernel module that creates an isolated cache with
> 8 objects per slab, allocated all 8 of them and freed them. Then called
> validate_slab_cache() with my cache and set a breakpoint at on_freelist().
> From there I could set any value I wanted and observe its behavior
> through GDB (I used QEMU and GDB-ed remotely from my host).
> This way I didn't have to set a bunch of EXPORT_SYMBOL() and change
> stuff to not static; It made testing a lot easier.
>
> Here are the tests I did with this new change I just mentioned.
> 
> Note: By "full slab" I mean that I allocated every object in the slab
> and freed them.

FYI in slab terms (slab->inuse == slab->objects) means full slab,
You probably meant empty slab?

> By "partial" I mean that I only allocated and freed some
> objects, but not every object in the slab, ie if the total objects can
> be 8 I only alloc-ed and freed 7.
>
> search == NULL
> - full slab
> 	- correct tail				true

> 	- corrupted tail with garbage		false
> 	- corrupted tail with valid address	false

Two falses because when the freepointer of the tail object
is corrupted, the loop stops when nr equals slab->objects?

> - partial slab
> 	- correct tail			        true

> 	- corrupted tail with garbage	        true

This is true because for partial slabs, the number of objects
plus 1 for the garbage, does not exceed slab->objects?

> 	- corrupted tail with valid address	false
>
> search == some fake address
> - full slab
> 	- correct tail			        false
> 	- corrupted tail with garbage	        false
> 	- corrupted tail with valid address	false
> 
> - partial slab
> 	- correct tail			        false
> 	- corrupted tail with garbage	        false
> 	- corrupted tail with valid address	false
> 
> 
> search == some address in the freelist
> - full slab
> 	- correct tail			        true
> 	- corrupted tail with garbage	        true
> 	- corrupted tail with valid address	true
> 
> - partial slab
> 	- correct tail			        true
> 	- corrupted tail with garbage	        true
> 	- corrupted tail with valid address	true

The result seems valid to me. At least, this is the best SLUB can do
while avoiding the risk of infinite loop iteration.

> I apologize if am going into too many details with my testing, I just
> wanna make sure I didn't miss anything.

No, it's ok ;-)

> If my proposed changes look confusing I can send a proper patch.
> Should I send it in this chain as a reply, or send a new email
> and add you as well to the cc?

You can either send a new email or reply to this email with
In-Reply-To header. And please cc SLAB ALLOCATOR folks in MAINTAINERS file
including me—I recently changed my name and email (previously Hyeonggon Yoo).

-- 
Cheers,
Harry

