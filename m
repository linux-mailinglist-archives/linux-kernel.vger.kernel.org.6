Return-Path: <linux-kernel+bounces-408148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A529C7B90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A017FB357D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B777E202638;
	Wed, 13 Nov 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nIK8sgDp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b5eCZMhE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB133997
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522203; cv=fail; b=PRJEDiAZ1oRf10spOYPyEcNj/9x9WzLVKWVylFVuXcOzNFjOlY9ejdYkhu0gbgI6MNsM60iwYHSAkaySz+JwvnE6I5NHVocktsjJxpC+1teaPiTdsHY4EiHvYG7Ct2O9Veu3EJlb7jKeZUxdvcu6BRseBODRgSO1SjzEFhjuNsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522203; c=relaxed/simple;
	bh=v3SH96iUTYRmKbyYosmMDFve/2reUtCsV8WxOryTCwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pssONCylQefs4AvMfCAwpTEzpuWJGxcjlnC61xW82MzOX/CLeqvBR9iistWebiGJuZt+I+Q5ZNBLu+ZLK7GxzPbfH+fTUsF+VpYx0rBzf2DCYmApEr4zb0VOV13Jwec/BE466eOpkA5pbJiD8gbQvk7NEKGJoV+ps4B2h0bdA3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nIK8sgDp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b5eCZMhE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBdPX029069;
	Wed, 13 Nov 2024 18:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LsG//cvi1fqCPB8GyaCCLyqrsb4K111WAglm3GmlKJc=; b=
	nIK8sgDpGGnh3VESIp+1QQbHo9J9u7lGLgxueUm8idk1eCV7L/G9jHNO0I23645d
	Nm+5byMsAT2Krf/bfB72vz6FUSg/l8jJrnIg95tFd4bp0WRATgA7ZQ/Gu5gOmpUy
	fWTS1fSirmMBwX+1KLzdbVzVkWo0OsayMiyrYDce2Q1InmRoLlBpNbazABYZV9+E
	t6clmEU1jn7OpuweQdSpy3fSodIe+Vs3S7rjhZbS7mF4BihrQMWrMcV6xXh6YYsf
	fl4gx5jVxi+NY8WBMazh8rPO5x0t8dGaQtLH10NJQ3SaqAO9loIO3ZsCFZ+oX6P7
	HEjZjs2Z4SOhqHaWduATGg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbfknh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:23:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADHLsh7022765;
	Wed, 13 Nov 2024 18:23:02 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw06bbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:23:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCnIPgIL6hPXPAyHNLVtotkSFnac3xvPtRQ3lNqbT3EyzXlqEqiBO5Vo5EuZNmWSov11rol2VVVbOcSGHZOHkPobKnXWXHPegtSXwImkzg+ysgqle/wnvo4yhgOnI+YA1iekm9Oy9qasGbjBO4pcVV9UEtpFHqisnFJtrzd2k+6c1xFDQ2dBocl0AykIVQp9LWJScBuJ5SjhruS5uPgK7RsMrjhuJAQuCxFTNXnCXHG9XjCfgWY+v+7iVbOmjMCs2gF7an+CKvGQ/2MFtsiuIgMk//5Z6FUPfgpjugra7gnJyi/M0WHjBcgff7OvdNXCJFKsGFGp5szqVFtPVocS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsG//cvi1fqCPB8GyaCCLyqrsb4K111WAglm3GmlKJc=;
 b=NDQaiwpo8KxyYOIyBufy1PmMb0i01tERtql671LRfYHSX/oRkTcshvuAeGv9vltuGn+QcsbQmOINL31uqWLo+9oXSuWV/vKfJjDqjADWLDP1J31ZMgJXr6Nhmn4dCkEh7qtwxfZA+8iYi6PelWkKJ/I6sqq9CjmICNujDtzk1/unTeUtBJUacfmdwO23b+bv2TPWu+GJmA1qi6JxuddBHAsmw8eUIP2ZSz8JYS11xGYY41uPxPjBkn/WztPCIrtM3FsTRt9l3AgrAN/60FsoeQ9ZORrraI12RCw4I05ByNiqMEy3qz74YqIjdx2d5RXfvHNS03ksDdTLrDaIAkQ6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsG//cvi1fqCPB8GyaCCLyqrsb4K111WAglm3GmlKJc=;
 b=b5eCZMhEfbazWGdgaIA/+AMAicxT1I+K5IIy/CIwPSRUR7Y0HH1FzdV2ZR9PILUz+9jKiHVvj2a1uyLMZvNXVD8+AFCGSdLKiIK/X+4UCvlH8wknMahiGJ4lReoxeDa1qx+XOtEMcJrDSWOUl+IEhOJY6qAyTvJ0V5imPDw+mJg=
Received: from IA1PR10MB5994.namprd10.prod.outlook.com (2603:10b6:208:3ee::18)
 by PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 18:22:59 +0000
Received: from IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757]) by IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::f2ab:1ccf:7941:1757%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 18:22:59 +0000
Message-ID: <164634c5-32df-4542-9a5a-2b357e10a67e@oracle.com>
Date: Wed, 13 Nov 2024 13:22:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [REGRESSION] sched/fair: Add lag based placement
To: Phil Auld <pauld@redhat.com>
Cc: peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <58289b1c-8a56-4607-8632-d36aef1fc5dd@oracle.com>
 <20241113181930.GD402105@pauld.westford.csb>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <20241113181930.GD402105@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To IA1PR10MB5994.namprd10.prod.outlook.com
 (2603:10b6:208:3ee::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB5994:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b635b64-ea53-4094-4f92-08dd041033c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXlPQnI0dlJjWnEwNzNpRWpibHkrNEhaaTFGYWJaUm9abE1VTXlzN1lOL2Ez?=
 =?utf-8?B?OC9CL2prSkFMQW5zM3ZlWU0xUWVCQllmNTBpSGN4U3F3YzhVM3d2eC9QUWVK?=
 =?utf-8?B?QXNickhibnluZTgxN0FwakFIL0ZaOWVIZDdWNnNwa2t1NWhFQmJoTStGdHll?=
 =?utf-8?B?Q1JCOXIyZng2cXdTL0xrUEtFS0NyN2pzMkVYaWliYlp1eWlxc3ovMUJicDZs?=
 =?utf-8?B?L2l5dGJ5ODNQb2xCWXJUU2FrYldrU0lRYWQwYnppdGtlc3VDTFpPQlJ5bEg0?=
 =?utf-8?B?R3JmUTlSUXVua1FhS24vVW9wY2kxOHJhcm5oQmV4Vjg3M1R1SHFYTGxhbm9j?=
 =?utf-8?B?WVdRcGM0b3ZvL1lBSmgvN2FzdE1wK3JWT083VDZpUGpTNUdHa0dKdlp2QU1j?=
 =?utf-8?B?YW1LV2YwRXhpeTVhb3Q1NkQ2ZWQ2eFpBYnFsS1RFdzRIN0pUOFZyQlVDUDBx?=
 =?utf-8?B?bXo3QVdGMWljNXFjOTNrb2x1SkZaMUlqbzFhMVNqYXN3Z3FvZDVXOUdIcS9D?=
 =?utf-8?B?Q1dLQStpT2M3dERUZWRpbHBNVFB6YXgyUThFSnJCUloyeXhrUFpMYXlKMnJ3?=
 =?utf-8?B?NXMxRWFTN3hubzJsQUZzU1RxNDZKZWN4M2VkVkIrRXNPS2o5RE5DOFh2L2Nl?=
 =?utf-8?B?M3JhOGVxT0xHZk1VQUN1c2sxd0ZCVnl1TnFJUEYvTkgwa2ltbkNiUXlqcFly?=
 =?utf-8?B?OGJ3YmZOSjBvUWxwZlpUUjc0aWpxenhmbGQxcEM5Wlc3aUZlVStCcEJpU1RX?=
 =?utf-8?B?eWNYQ0hic2pCN0hlYVdxWGFoODJOQU5nYjMvRThYZjViU2tpQ1Bmb2NScUVH?=
 =?utf-8?B?QkphenBPK090aTdMNDAwYSthNi9WM1BLbW11TURSdFpWMDcwbnlRSExkZ295?=
 =?utf-8?B?blRDcFpGRGpveE9lZFB0NHhRUk0vQUFFRm45blZpSUU5SlV4OENvUUluTGtr?=
 =?utf-8?B?ZzhIRVRhUkJ3cFZRTE5ibXYrVjhIYlNjalMrUDIvUTZpL0kzdGhGajZKWGda?=
 =?utf-8?B?cXdaOWs1NjQ4U0o2WFBsK2U1OW5kY3VOMlRiT01ZczIyWk54NlQvbC82SXZP?=
 =?utf-8?B?NU1QU1YzazFVbDJES0g1SmQzS29INU44WjMySGxPZ1ozZmh5LzQvMVJYQSsv?=
 =?utf-8?B?SkJxcXFvQmdDNW5zVmtaUmxQYk8xc3h1MUtrS1ZDeE5SRTNSbklSd1NCSWE5?=
 =?utf-8?B?aUdzNGFQK2EwdG1QN1FvVnZhWElQZm5rMG5NOHorbWg0anlnaXJXaUl6K2ds?=
 =?utf-8?B?cnZIMC95b1Z2K1FabExlQmtwUWFTTzFZWXpPL2sxOVRPc1phMm1ZZ2pZUmhs?=
 =?utf-8?B?WUFIeXB2NmdrbTkxS1lDWmtBbFZZKzZrM2o1L1VmbmZBWG9LdG1XNXkyM0lJ?=
 =?utf-8?B?N2psK1R5SnczWmRnSXY1N3hIVGVUV0tZbWZQdUxpbmQ0UGZ2ZmR5aWJ3TFVm?=
 =?utf-8?B?N2NCS1VnVmt2bUpZZWFRM2ZqeXoxeWliK0hzbjhKZEFrRTRGR20wT0dPY0JP?=
 =?utf-8?B?RlJLSmNGZFpVellkdHZma1FZWkNZamNaZDI1dnRIQ1FOeGhKM3pxb2NPYmFZ?=
 =?utf-8?B?VmQyM0NmQnMwN1VJZWxSUmlJRGRBR2tVUkw1Vlg3RUlLZnBmaHpmSmw3TENB?=
 =?utf-8?B?aDliYjk1KzZMYzBmNXBudXZCbHBvVU9LaFhCcjBJZjM0NEtNRXp1VXZpZ0RD?=
 =?utf-8?B?S2hldHAxTGN5UXRTd1FBYU41cUc0Vkd5NHRhbzkrQkVhZytsOEFNTnJwRXVE?=
 =?utf-8?Q?Fe8tS4yhs7nsUMX/vqpnj028RNP141LJaef2bsR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB5994.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE1XMWptV2w2aEhUZW10NmN4ZzJENW1yeXN6MWVGbTB3MzgreE1vYzhoSkFs?=
 =?utf-8?B?c3FnZnFpU2hVUm1MSktHSDRmOFVocmora0RyOEJ5Z05XWS9oWFFuUnJqWS9P?=
 =?utf-8?B?K0NZTXJIS2tFZ1AvWW5POU1xaktnWjYzL3krSjBSRjJINWF2UTd5cjkwQXlq?=
 =?utf-8?B?ZFhQQlQrWmxCN09PL1RHc3N5TnV4L0U4N1g2U0phN1ByRTNCVTIydnA5ZzI4?=
 =?utf-8?B?ZmpiUjB5NFpocnE2aWsyTk1qWXRJWURZamoxbGFUbWg5T0lqZGhOK0xqSklM?=
 =?utf-8?B?TEFoUzZzOXQ2djZ5K3dKbC9Cbm1sZXpOQnZoeFdWMU1yNkhpblN6MUl3UC95?=
 =?utf-8?B?VWxST204cGtibFJtbWF4aXFQTW55ckNIbDlzUXZ6UG9xMEd4cWtxVU02UERI?=
 =?utf-8?B?RE5UVk01WVVlSnF4S1ljTFZ6TVMvQUwwSzBicFVGblY3S2Y2TUl3dXByVUtQ?=
 =?utf-8?B?V2UxOFFheXBuZVlEYWl4U3phdXh0dHB5c280RDlWQ0cvZkpVWnJOazFZcGhi?=
 =?utf-8?B?Q2IzQUlrUVZuUkFuYlRQTHhmTU91bjNMU0orR2t2dmpwSnZKRzZpWlNMaXJj?=
 =?utf-8?B?SHlwVmJOWDZGWnBmK282d3ZNaEN5Q1BmRlUvb0ZTMDh4dnR3azJOWCtiTzhr?=
 =?utf-8?B?Y0g0YkFGQ3RBaGVPWXp4Yzh4QXZ4eHRTemZoc0IwemtCUklpWVVlK0xiZTNi?=
 =?utf-8?B?WVo4dUs5QmlMSGN1eHk5anFxTm5jbG9VSWFhTUFHa05qdFVaZ3RwVkI1RlRQ?=
 =?utf-8?B?M1o1bjlBekpGY0VQU295OUgyVCtCWVZtSlZQeWZyUmVkLzBXb05tcHJBYU5K?=
 =?utf-8?B?WFo5U25ReFJQZEhra1RQbFdGeWpYZnlITDRkeFQ0ZDV6WXZSbnlERlFjOVZy?=
 =?utf-8?B?MGNnRnhmTTlDOFZkZDhsMGhxaHNWdkxGV09GeVVJNkpSTDg2bEdTdUZwVmZ2?=
 =?utf-8?B?ejgyM2tneTdBbC9ENDBLTExONFAwZmtVQ0EvRVJGdkFZVDVVaGJ6MDkzZE44?=
 =?utf-8?B?aEpZdGlaM04xT2FiMkZDTzlUemxyYkt3TEk5eElLLzdxMjBUWExTajBqQ3l3?=
 =?utf-8?B?dktlenVhUThjV2pxWDlwek5vSk1pYVJyTVBxbGVKczgzUStLejlHbVpkN0Nr?=
 =?utf-8?B?TmxLRGFTM2NmMGZ4WTdUK1RKbFdEdzZYMmR0aExOQVFpUjcvcW1wNmhnaTdh?=
 =?utf-8?B?Q2s5enFJVTUyZHZEOWM1aE9hUHBoTWl0eTRHb01NNFRGeE5VVVkwSWdaRUdM?=
 =?utf-8?B?S05QUjVNNEszd3h5UDZNdjF5WTFmZFR4L1ZtU3NvSkVaYzJiYnJEd3owaEJp?=
 =?utf-8?B?TDB1U0FNVkM4VG5GS0x2V1MxOWJXbFRqR2xkWGxSNFA3cmNwSmtyYmpGSTlH?=
 =?utf-8?B?VWFmQlJjVGJFYWVPODdDVUR0akVrMFVXbWhFSVZabS9LMFBZbk56cmN2NWY0?=
 =?utf-8?B?eHVObkRhSm15Z25ObFpSRkdlWkJmVXdVRDhzQUJIaDdoMHFDK0NkUFdndWl2?=
 =?utf-8?B?MFk4YnRtK0FvQUF5REpXTFNDL2J3NHdpbmFUeFVjR1Y4anFMYlQra2hZLzJ5?=
 =?utf-8?B?dk8ydDVFbE8rTFk5eG5SRGFrWno4YjBZdUxPNjdpWS9KYUhqMUZ5WGxJaGhl?=
 =?utf-8?B?RWpiRWloanhOREhicWNCNjdtZGRYSmE3TkdiTituMjlCakNlTkdtbXgreVRW?=
 =?utf-8?B?NzBjcHhhaU5wWGpYZEswaXRFcXkrWVpYRU43b1VFNWlTc2tTK3FvQWJXemZE?=
 =?utf-8?B?TkRSYVNuTEkvM0ZRRmhKVHRoejFwdFdxLzVJc0VTazlQWnp2YkpuUWxldVRs?=
 =?utf-8?B?STZ0K1RqK3pqMDJuMnJJZGpaUGc1Z2p4YUZiYnU2ZWExSWVmK0IyMUpEV0xV?=
 =?utf-8?B?ODVaK2JqOS9sT2czNzJjbjBsb0NqUXd0bExzVEkrbEIzV1NTRzVTY29zOVF1?=
 =?utf-8?B?eUdTRzl0ZWpNczNHYWZZZ1hJNXJtbVY3SzhlT3RmdXdadlVJdFhkVFo4ZzU1?=
 =?utf-8?B?Qk9Ea1lYUEl4MFhYWTlDVmxMQ0xiWkZyQVIzY1M0N1dieEo4SzAyd2NKK2cy?=
 =?utf-8?B?UERBdHhickZpcnFERGVBTXZFV1EyVlhsZFREZjRVWmVsemZrRWN0TnVxR3Ex?=
 =?utf-8?B?L3FYKytBN3ZveExWMWhrdkNpa01lQTlYUTRFb2tkejdKTi9KbmtId2czMFhq?=
 =?utf-8?Q?72Yflfek36qqeYPOvw7aBuw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NtVjvLQDJ28a4UDHOzw6sqPkMKBv2oG8DmcKrNPpTWqeLcZdExIUpmvHyjz4CyQzfuPRG+WfS0FPFptKHVHOEqGtsIFLNKM6lZADd5fKN0GKPHCamLUgmYxp9QNFt1L0uLK58QpuowRpbhxa00yfMIhHX+65XmWcrRV5sTYBx+abV8IM63JZnL9XOb6EGp4PWJhlRbkjGlGI/uaghyqCBWvkv78fz5anMhSj3yAzfWx2wDxs1YyQB3LHaWabwS7Ptn8wzNhqJPjEbf4pbtM+OIFxMPjFLn2ykPmxnewTtw7rWbqspWLhIbCubFdd1jlHT06Q5BVv/CDIDBIlpiy+Fu84pimLEjPu15+j0vsSvlBgp1QHtlpT0IoeJM3OFfcSalXVFR8O9TglOk9LZ4rsb4HxJk8L6VMYkDFSyUraaR9mNqJFw4Wv8VObNycYMoaks/t3T6wWwdUmwyVpdHk2SfHj3EOVEKGZ1pZWMtaSSM7sB6ScDKlzhTI/xQMjCMJ+31yuXHxKulMXZ2OkdqBWK2H6R/bPM7cyY5/E8Bg0fXzyao0bAhsmAvjMcnKWjKkG4CwLmZOzpcuYElHZmiCjbLo7L5g4Li7bJD4V9HkiTfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b635b64-ea53-4094-4f92-08dd041033c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB5994.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:22:59.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPVcklv36rYzSI0S7EZ3jjQC/VTDM7xElvhQH8K0GEklivX21qPTX5dS81P+uuYE/5qYrABsv9V3HJE14MmkprG62kID/SMYq8RPB1LTdyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_10,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130151
X-Proofpoint-GUID: kJEsZoOohJiYUFFiX8sCfDPIOvzzKrCJ
X-Proofpoint-ORIG-GUID: kJEsZoOohJiYUFFiX8sCfDPIOvzzKrCJ




On 11/13/24 13:19, Phil Auld wrote:
> Hi,
>
> On Wed, Nov 13, 2024 at 01:03:00PM -0500 Joseph Salisbury wrote:
>> Hello,
>>
>> During performance testing, we found a regression of ~9% performance with
>> the TPCC benchmark.   This performance regression was introduced in
>> v6.6-rc1.  After a bisect, the following commit was identified as the cause
>> of the regression:
>>
>> 86bfbb7ce4f6 ("sched/fair: Add lag based placement")
>>
>> I was hoping to get some feedback from the scheduler folks.  Do you think
>> gathering any additional data will help diagnose this issue?  Are there any
>> tunable options that can changed to see how performance is affected?
>>
> You can try turning off the PLACE_LAG sched feature:
>
>      echo NO_PLACE_LAG > /sys/kernel/debug/sched/features
>
> It's not what I'd call a tunable but it would allow you to test w/o it and
> see what it does.  It should allow you to switch back and forth easily for
> testing.
>
>
> Cheers,
> Phil
Thanks so much for the suggestion, Phil!  I will give that a try and 
report the results.
>
>> Thanks,
>>
>> Joe
>>
>>
>>
>>
>>
>>
>>
>>


