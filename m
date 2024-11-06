Return-Path: <linux-kernel+bounces-398652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB39BF434
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C941285045
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA9206515;
	Wed,  6 Nov 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="VUmoJrsl"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706E204F96
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913648; cv=fail; b=I0CB7jXRNb149wxJ2hKyun3q69Ns0z9rv5aJN3RNLZh7TMCzsgsiYg3sbdwulTpNd4hYLr9/tuWLSNw6dS6C1Ro2zzdcLOANBn3ONfMiO0qD+C3nAvc/+I8rMLdIOWhMJpLb4ljKRRn5trUzkKAPPX46/JcOcReMfHvdcOgN6Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913648; c=relaxed/simple;
	bh=CWkg5JcV9sIGAnn4sQRj4391kvWPRKTknbogFjM2ycU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JOFiGCd3Da38gjolB3JsYr5GSoLcsOGWVbwv2gmLaT+xXTEkpoMRyf9GrCW0hrIFK9LrtMXTolk3rix1063taVyftfLB/Wr4EwPld8Br28jn6PZU30WQ4Qz6DwL2ZqDEmM7pvhNx9mBkvIZqGQGkqiCz3VsvxAGuYxoujVexfrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=VUmoJrsl; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RH53vTtLvuTr5oeuBfI07kkj8qdWpfj0tdYxzgjVSrcRl7JswM+MWPAjofF50p3K6Qcbvx3fi4eNplWODtGvyKN9u66k3jh7YW8jNwsYaWcTkKbn82UcVlcAAuBVmweA60fCC5JompPY1KlV82wRy3Y96hgTvLe4X5iB3JBIjGm26/1p2Mw4Qv+p34hpiD6zfkHXSDYMdrxfF8JWfpJ2BYEQZmPZTCcNvAwutgosMAcmJtPKh4sxlpE65Yjb3Iq4am0tuPv1FRUDg0qZwXz5C7WQvcUbwGGgsTWBD4OYM3bfNTdLKc/LIoTtygc28u7GYNuJj97eScyKABXTnBicOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31dUga2OLTvDKgzaKxxh9U6XKmD/SSFtHR5GIge9VsI=;
 b=vGEf2dVqrNWsoTG5DQacO0eReY7VL/B9ISgrmLcw7vEvSXsVvgm76GItw0uT3OJIrIgHFwFUYQ1qxE+2tCRJO4C8tRQuyhFrvAvGlmqoRbZ8b8rRPWsvQNzi6Uamp/idd8XvaUZzPjfjzHLAHvvakTh9/3CwKNdO4K8Qkt10Vz5xT6CT9TDx/I9auxU8eUPWqMCo1BmZVakmIqGGa1pm4X1G5bf6HjG05PGc+bz4KmxKNJct+g3Ir3vOzKbNGpXt6NVCEWvnyLqOLDWGeWaBZ7yBU2s47l7m82Tz+vAP+A6KoFUIcxp6ge+gBm3uucEYeJ9JMqbnIMEWScKCIiNvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31dUga2OLTvDKgzaKxxh9U6XKmD/SSFtHR5GIge9VsI=;
 b=VUmoJrsloimWfxV84kintXepmBPgCe+H6274BBMYguoF64CTmtrooQo9x5D1ej0VDsVcX/w+ObXnMdZka5A2KdcjVfYlba5Sxbym5yD0c2qGFOcZSGj3XWgR881/CpbeZ7sP2obCZfK0A232oIfqaAKLCKt6to5m9YkxfyzcSgmsTrJUrYzTLdgM7HkkMDgzChjYoltD6mGQGolzMdFBdc5RrSffL1vTn+e+K+dyI2xaIkAPhK4lILb28KWjhY9mrALWwjAvXn6sr8rWpkIWrjpegXBIU9oYjjl10WdKo3ZJwSTZZU9ykPNaCKm1plsT/E6HfIiyspz5KFlwpyoTIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com (2603:10a6:102:368::9)
 by AM9PR07MB7732.eurprd07.prod.outlook.com (2603:10a6:20b:306::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 17:20:42 +0000
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf]) by PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 17:20:42 +0000
Date: Wed, 6 Nov 2024 18:20:45 +0100
From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: x86/amd late microcode thread loading slows down boot
Message-ID: <ZyulbYuvrkshfsd2@antipodes>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To PAWPR07MB9579.eurprd07.prod.outlook.com
 (2603:10a6:102:368::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9579:EE_|AM9PR07MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: aeba916f-4765-4324-6b43-08dcfe875772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEwzNHZFL0IzZWdYSEpZWmtsdXNjVlUrWk1TNXpPOEtBd3JkZm5weWZLWWNB?=
 =?utf-8?B?aVh5ZnExR0dBZVUxVUpyV1ZBVmpuRWZ4VFY1c3ZVTmF2L1BSZFNIbGtxNUMv?=
 =?utf-8?B?UE5va1VlTXFlNlhoYWpjZTZ4KzhXYTNRWFZUL3Y0Q2k5R1RjeVk0SGhPZ0M1?=
 =?utf-8?B?cmxFWThPN2hNcDRaNjJaSTJXRGxXdTVRTTQ5NTJuUXVRMVdzZ2NxTTJlNmhR?=
 =?utf-8?B?N3NZbkJiVjBsTFNnd205RUtENTJtejdWYmZVeFJud3FRbi9jN3grT0VnNGZ1?=
 =?utf-8?B?WkprMTdhSEpPVHdjNFpFQmNpR2NHYmEvc1NxNGNOMHZPWUdHb1o1ZXBGb2tI?=
 =?utf-8?B?RURHVG9sM3FQYlUwUGErQkh4c2p4ZE1qQ08vK3ZwNWhvaWw0UVNZRDVnVGxO?=
 =?utf-8?B?cHQyL1F4Ylhja0MxZ2hjODVOUnVzRUxjSGg0Unp3UExvQ2xqMXNVS3d1Ym1L?=
 =?utf-8?B?ZzZUYnBaVlJ4ZkdGSENwcFlRbTdJbmJ4R1gxU2dGT2F1bGlhVlAzT201MXRP?=
 =?utf-8?B?S05kZXRVeUFUSUFWK1RhYnk2Yy91ek1vWmdjSVlmUTUvQWJWQlc3NHhQblVS?=
 =?utf-8?B?M1QyMTVZQUI3aUVXZmVIL0l4aW9NTVBqWWk4MjBzWGlIbFJNNThRQVowL21o?=
 =?utf-8?B?UWErTXU5Y3g5cUdGaXFHSUYybk16cG9YbjhuQmwydFpPeFRVVEsyOVFCTkV5?=
 =?utf-8?B?TXYyY3NaUGx5K0dmMmhBdUdwaHYrb3BML3IranBlNTdmTkxlemIwbCtnYjZV?=
 =?utf-8?B?S2pOTk5XSmtWRERMUVRSa3FKN3h1bDVhMHBFVThpZUJBTW80SHd1am1xbGo0?=
 =?utf-8?B?TWJXMXRKL09oaHp4TWk4N2FRWUgrUXM4TWVLZDdYOEFmMHdxVW1kZU9yT1oz?=
 =?utf-8?B?MlRBdHNjc21tWU5wNlZmb0VKOTdiRHUzb3lpTktnU3U3T3ArZ0ZmZ2hmSG5m?=
 =?utf-8?B?Y2VLb3JYMEczNFdzdHFQeFVLaGRvMlN1UnlHdTAwWXpEMzg3OW9XaWcvOEpX?=
 =?utf-8?B?Q0dncHo5dU5JbWlqWWt2M0MwMGVGaXdHemdKRnhkQUMraWpvT2gwUHU0bzRH?=
 =?utf-8?B?RytRZTJvc3Q3QU10WVVleTFZZzBaZ1FlMEJoREYyUlpvNHZrT1psNFdQbk5Q?=
 =?utf-8?B?UHRZOG80RmZWZUJxQzF4UWtXaXNHMmNKWEZHdUIxR1JSU3JJVW5Gb1F1bmpE?=
 =?utf-8?B?RndMZzlwRWx2NEg1UytKV0ZvUXZvaWhnQ2dWTE5aajZuUnN5c0IyNEdGWkZp?=
 =?utf-8?B?SFduSDZaYWpDL2VVVmVsNUR0dXZnZ1RZNlFpYXFFNmtldmVtNnE4Sk1LWGJy?=
 =?utf-8?B?QUZpM3g4bktIWnYvMklmM0pad3NaUC8zbXREM3dGaE1LSDZtZUF4aUIzdnNN?=
 =?utf-8?B?TytFQ1hKczJobFNJU0RpL2NLM0hXejkxMTJ1NkdXRm50dW1zSWllVW9mQVgw?=
 =?utf-8?B?WUFFVUZScXY1Z0dXQ1ZJUXg2Sy9UTzdtWGpxdldEK0VRUGNxL0lIdzR0Y0sw?=
 =?utf-8?B?eG9NamhZRHdmZW54cW1yRXBPVG52RzNCZGhHc29CN1VWdDF4Sm5wdVQ0d0NY?=
 =?utf-8?B?UW5PZ0JGUjBQSEFidW5Wbm5wY2pLNHUwTEY1dUlMZzBqamd2bDRXczQrMDU3?=
 =?utf-8?B?NDd3UmlaZHZRQ0Y1VEw5ejBLZ3MyemJKTS9FSk13RWpzZFN6ZlV6aWtWMWxX?=
 =?utf-8?B?K2U1MDV6ZUpMVHc2Z215Q0JiTU92OUNZOFdISWNYb3lpWkJ5aHl2WElhc01a?=
 =?utf-8?Q?fGzQ1aCUgWNnnaH1hp4PTIl9SZx9CCOlKl+xU2l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9579.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlRVdGM1LzJJblNaVEJHOWZIb3RMc3RkN1BJWGhzVk9HeFVwUUJOMzhGcXhH?=
 =?utf-8?B?MmJGOWtmOGx6dGs3VUw5NGh0anZPWGUvNFJFM2U2VXczWTFmU3VhN0xnU0dU?=
 =?utf-8?B?T01jQ1J3eWFDeHNNMVp2TzR5WjBOd0NvVXd4bjNEcUppZ242eGV1dVhMTFMx?=
 =?utf-8?B?QkNzWDA1a3JVTGJjbkt2czNPUURtVE92cWJkUEhxaGhseG03WVF3cGxTaTVn?=
 =?utf-8?B?M1Fsd3lNVmFmWDZZSWo2V2lha0R0QlhLcmgxRjgvR1JBT2ZGVkcySUVISm9S?=
 =?utf-8?B?NnZtZFNBUjFTZkZLNkNKeFRsYWV4VUpEWUR2RStvWDBBZDFjRi9ocEc5QTlv?=
 =?utf-8?B?ZFpVVElwSEUzZmtDcXRENGRIb1ZJdEltaTNxa3U4ZHpqTWVZSlg0Zmtuc3Ix?=
 =?utf-8?B?a1E0MDN0Ni9BS1B2RzdZMjdrK01mOVhzcXc3eTBmRjRWUWJMRXdLTTF3UFpq?=
 =?utf-8?B?VkdYNVVjRDZWQ2hWMkpqMFd6TW8rV0FBM25WSUJTSGtSckY2UDh2ZjRFRXRY?=
 =?utf-8?B?UkU5akpEcW9BUWkyQVhaWnFnU3h1aXlZRmZRWXJ4M3NWZHkrUlp0cHcxQUk4?=
 =?utf-8?B?T0JxK0t5cXFQb3B5VUlyZm5VT08waHhGMms1bHFucjl0Wi9WVXF6dWEwck44?=
 =?utf-8?B?ZnVtYktTUjA5Wk9tdVhTZmZYRDlvK09XY0ZFR2JKc2taWW9ZVWxpZVlzRFVF?=
 =?utf-8?B?WXpiZUxTUS80MjRHKzdkVkMxdkpaSm93d1pQNDdPTFhLcUxpNDkzbEg3Vjhx?=
 =?utf-8?B?QmFIaUFQZlgvMTREWHl2aEdTckxHS1NieEZYLzd2NTZUZ2xLMlc3WGt5QnJQ?=
 =?utf-8?B?SmZ3Si94M0gwTERCWm5kVSt3ZHdqVjhUNFdTNEp6UnNzbXlUVytOaktXdEFG?=
 =?utf-8?B?aUhVc3JPaEIrTVZNYkNpcmY3VGkwUU5IcFB1RmlQK1VqOGR1aW9LdFozNXpH?=
 =?utf-8?B?aXBCV2l2aGRMYnNmVkJVVEpVRnBrbHBudDBCQVNLQ2tCU25WZnRRcVdQNHJQ?=
 =?utf-8?B?VkJDdVhUbElERVBrR1BNRVdWSjFnMkJYUWYvTkNraFcxYUlLT0ZwblVhTDVw?=
 =?utf-8?B?NGlBWXQwVnE3a1FNd0RNZkt3ZUNSemFHMit0NmVzMnEwOU9VSllCbzBRSFZH?=
 =?utf-8?B?RkRLY3huQ3lxL2o0MVlCN204dEtUSFNxcWlSdEJGbWVESzVXb3NGZmtxSXJo?=
 =?utf-8?B?emhJSWovcE1QV201QnVpSWs5blhubEQzNVAzQS82U3dQQWM5MUIrK04rcXRH?=
 =?utf-8?B?YWxNZy9oZCtXQ2xzUHAyR0l6bFkyZWZjb0ZwTk1zdDJDZkxyRnMxMlAxeTUr?=
 =?utf-8?B?cmVxd0cwS1lNYnhOM1JsTHZHNnF3b0tNc0NqekI1NW9FTnU2MGwzeEhIbmcw?=
 =?utf-8?B?U0F1OU1kWTFQcFUwU3BVRUpLUmJPcmo0V3FJaDhPRE1hN2xHMnkyS21Ta2dJ?=
 =?utf-8?B?VW1FR21WUGVFV1o4Q0hncEhubEwyNmkyM1NRTTJFNmVMY2hCZjZrSjNaU3Jn?=
 =?utf-8?B?aXJQVWZDWHYvOEZrdGVqK3lYWEl6Z0Zyazc3b2hodFpVdXExeUNUa3p4ZWVk?=
 =?utf-8?B?VlFleWducG5lVktoT0pSUWJPTExFSjA1dTV6NmEwTkwrejI3ZHBzakJWenhl?=
 =?utf-8?B?QktpbFUzaHNuL1kwWWh1a3RtMDJPN0pCYkQ4VDF0M285TGVTUklwQXhrOHhw?=
 =?utf-8?B?UDRZdllGYlpzbHFoVlErVFVVaEFLdTltUVpQQU1TZ0M3a1o0VGtubG9wSkpQ?=
 =?utf-8?B?NnB3bEhwRnpBM3dOVlp0bjJBTEJkOWRnZ2VXWEZIaEdvYkpoZDhJcHg0NGJ4?=
 =?utf-8?B?cXZMendQdFVTQStPbmdLaTg2V2lkVEd1ZkFndEtmcGtvbjhOSzV4UlJVUWhp?=
 =?utf-8?B?L1dZdThVREluTU90SnY2M1hCbDU2MnNvdFdzZFhMMlhPQ1piRkxxZjRVcyt3?=
 =?utf-8?B?Sk5KS2F3bnJ6NFVXS0o1UUFrRXlzQUNiZ1VueHcyZjJVdVRqVUNHRUhic1Zz?=
 =?utf-8?B?WnF1UFQ1aFJPTmFDaXVkTkFUeHg0R1VGQjB3eC9OaDJFOHJqNS9DdEdTSEpG?=
 =?utf-8?B?Vi9mL1hKbnphUFN3dExqSzlMMTRjL2d3Zk9lb2hNRDh2aCtaeGRmeXVHc2Mz?=
 =?utf-8?B?U3NMVDlJTy9iRnhFQkZEaXI3YUVycytYdHNjRndKMUhiV0VrOEtoMUt6TnJ6?=
 =?utf-8?Q?lXQds25rYPADWBn2SWaPh6E=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba916f-4765-4324-6b43-08dcfe875772
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9579.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 17:20:42.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01ba3QnQwmzpESRLsM0kCc86BDJioeU+lWgpOxWT7rV/VupGetMMa7AraNf5UofQhLO3LMwhgMoAMuUZiQ/tzpX5cuerE7rs+rE/eGzrnKka/6UMtbT7SRJ8+awy/SXi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7732

Hi Borislav, all,

I am encountering varying delays in the boot process, bisected to commit:

    commit a32b0f0db3f396f1c9be2fe621e77c09ec3d8e7d
    Author: Borislav Petkov (AMD) <bp@alien8.de>
    Date:   2023-05-02 19:53:50 +0200

        x86/microcode/AMD: Load late on both threads too

        Do the same as early loading - load on both threads.

        Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
        Cc: <stable@kernel.org>
        Link: https://lore.kernel.org/r/20230605141332.25948-1-bp@alien8.de


The problem is observed by the initramfs taking unexpectedly long to unpack, as
witnessed by the timestamp on the 'Freeing initrd memory' trace (and confirmed
by additional traces).
Normally, that trace would be at about 12 seconds with only 1-2 seconds
variation across boots. But when applying the mentioned patch, the variation
increases. Most boots see no impact, on some boots the time is increased by a
few to tens of seconds, and in extreme cases even by several minutes (!).

In such cases, the hung task daemon will report a kworker to be hung and panic:

    [  246.812329] INFO: task kworker/u34:0:195 blocked for more than 122 seconds.
    [  246.820106]       Not tainted 6.6.52 #1
    [  246.824391] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  246.833134] task:kworker/u34:0   state:D stack:0     pid:195   ppid:113    flags:0x00004000
    [  246.842462] Call Trace:
    [  246.845194]  <TASK>
    [  246.847539]  __schedule+0x262/0x770
    [  246.851437]  ? prepare_kernel_cred+0x28/0x1c0
    [  246.856305]  schedule+0x61/0xe0
    [  246.859814]  async_synchronize_cookie_domain+0xe8/0x130
    [  246.865649]  ? __pfx_autoremove_wake_function+0x10/0x10
    [  246.871485]  call_usermodehelper_exec_async+0xc0/0x190
    [  246.877225]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
    [  246.883641]  ret_from_fork+0x34/0x50
    [  246.887634]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
    [  246.894051]  ret_from_fork_asm+0x1b/0x30
    [  246.898435]  </TASK>
    [  246.900876] Kernel panic - not syncing: hung_task: blocked tasks
    [  246.907582] CPU: 8 PID: 131 Comm: khungtaskd Not tainted 6.6.52 #1


I observe this problem on more than 10 systems, with following parameters:

    vendor_id   : AuthenticAMD
    cpu family  : 23
    model       : 1
    model name  : AMD EPYC 3251 8-Core Processor
    stepping    : 2

or

    vendor_id   : AuthenticAMD
    cpu family  : 23
    model       : 1
    model name  : AMD EPYC 3255 8-Core Processor Industrial Temp
    stepping    : 2

The original microcode on these boards is 0x800126c .
The microcode I'm updating to is 0x800126e. I also tried 0x800126f but it didn't
make a difference.


During early boot, the microcode update has been done successfully. But, due to
the changes in commit a32b0f0db3f396f1c9be2fe621e77c09ec3d8e7d, an additional
'late' microcode update will be done, even though the reported version already
matches the expected version, to cover the other CPU thread. This reasoning is
described in the commit message of e7ad18d1169c62e6c78c01ff693fd362d9d65278 and
is also discussed in mail thread [1] related to the proposed 'chicken bit'. In
that mail thread, it is claimed that the added late loading does no harm on any
CPU newer than Bulldozer.

Yet, based on my observations, I think this statement may be incorrect.

Filtered dmesg output for an extreme case is at the end of this email (the hung
task daemon was disabled to avoid a panic).

Could you please check this?
Let me know if you need additional information or have changes you would like me
to test, preferably based on 6.6.x .

Thanks,
Thomas

[1] https://lore.kernel.org/all/20230605141332.25948-2-bp@alien8.de/


[    0.000000] Linux version 6.4.0-rc1 (oe-user@oe-host) (x86_64-vendor-linux-gcc (GCC) 13.3.0, GNU ld (GNU Binutils) 2.42.0.20240716) #1 SMP PREEMPT_DYNAMIC Tue Nov  5 09:56:34 UTC 2024
[    0.000000] Command line: console=ttyS0,115200n8 quiet root=/dev/ram0 crashkernel=80M loglevel=8 tsc=reliable
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[...]
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.7 by Phoenix Technologies Ltd.
[    0.000000] efi: ACPI=0x7e9fd000 ACPI 2.0=0x7e9fd014 TPMFinalLog=0x7e831000 SMBIOS=0x79d42000 SMBIOS 3.0=0x79d35000 MEMATTR=0x74572018 ESRT=0x741af000
[    0.000000] efi: Not removing mem43: MMIO range=[0xfed80000-0xfed80fff] (4KB) from e820 map
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2499.992 MHz processor
[    0.000015] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000018] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000026] last_pfn = 0x47f380 max_arch_pfn = 0x400000000
[    0.000033] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000178] last_pfn = 0x7f800 max_arch_pfn = 0x400000000
[    0.004544] esrt: Reserving ESRT space from 0x00000000741af000 to 0x00000000741af038.
[    0.004549] e820: update [mem 0x741af000-0x741affff] usable ==> reserved
[    0.004566] Using GB pages for direct mapping
[    0.004932] Secure boot disabled
[    0.004933] RAMDISK: [mem 0x2c173000-0x320b0fff]
[... ACPI ...]
[    0.005129] No NUMA configuration found
[    0.005130] Faking a node at [mem 0x0000000000000000-0x000000047f37ffff]
[    0.005134] NODE_DATA(0) allocated [mem 0x47f37b000-0x47f37ffff]
[    0.005142] Reserving 80MB of memory at 1696MB for crashkernel (System RAM: 12139MB)
[    0.005163] Zone ranges:
[    0.005164]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005166]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005167]   Normal   [mem 0x0000000100000000-0x000000047f37ffff]
[    0.005169]   Device   empty
[    0.005170] Movable zone start for each node
[    0.005171] Early memory node ranges
[    0.005171]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.005173]   node   0: [mem 0x0000000000100000-0x0000000001d9ffff]
[    0.005174]   node   0: [mem 0x0000000001f21000-0x0000000076c33fff]
[    0.005175]   node   0: [mem 0x000000007e9fe000-0x000000007f7fffff]
[    0.005176]   node   0: [mem 0x0000000200000000-0x000000047f37ffff]
[    0.005178] Initmem setup node 0 [mem 0x0000000000001000-0x000000047f37ffff]
[    0.005183] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005206] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.008926] On node 0, zone DMA32: 385 pages in unavailable ranges
[    0.009265] On node 0, zone DMA32: 32202 pages in unavailable ranges
[    0.009585] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.009617] On node 0, zone Normal: 3200 pages in unavailable ranges
[    0.010557] ACPI: PM-Timer IO Port: 0x408
[    0.010567] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.010569] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.010570] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.010571] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.010572] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.010573] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.010574] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.010574] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.010575] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.010576] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.010577] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.010578] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.010578] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.010579] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.010580] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.010581] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.010609] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-23
[    0.010614] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24-55
[    0.010616] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.010618] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.010622] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.010623] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.010628] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.010645] [mem 0x80000000-0xf7ffffff] available for PCI devices
[    0.010649] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.015416] setup_percpu: NR_CPUS:64 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.016208] percpu: Embedded 59 pages/cpu s204800 r8192 d28672 u262144
[    0.016214] pcpu-alloc: s204800 r8192 d28672 u262144 alloc=1*2097152
[    0.016217] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15
[    0.016238] Kernel command line: console=ttyS0,115200n8 quiet root=/dev/ram0 crashkernel=80M loglevel=8 tsc=reliable
[    0.016392] random: crng init done
[    0.018490] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.019603] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.019710] Fallback order for Node 0: 0
[    0.019718] Built 1 zonelists, mobility grouping on.  Total pages: 3059076
[    0.019719] Policy zone: Normal
[    0.019721] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.019792] software IO TLB: area num 16.
[    0.047969] Memory: 1823812K/12431180K available (14336K kernel code, 5006K rwdata, 5164K rodata, 2692K init, 4516K bss, 528072K reserved, 0K cma-reserved)
[    0.048108] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.048135] ftrace: allocating 38800 entries in 152 pages
[    0.054657] ftrace: allocated 152 pages with 3 groups
[    0.054720] Dynamic Preempt: full
[    0.054768] rcu: Preemptible hierarchical RCU implementation.
[    0.054768] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
[    0.054769] 	Trampoline variant of Tasks RCU enabled.
[    0.054770] 	Rude variant of Tasks RCU enabled.
[    0.054770] 	Tracing variant of Tasks RCU enabled.
[    0.054771] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.054772] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.057563] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    0.057743] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.057852] Console: colour dummy device 80x25
[    0.057875] printk: console [ttyS0] enabled
[    1.360910] ACPI: Core revision 20230331
[    1.365444] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    1.375671] APIC: Switch to symmetric I/O mode setup
[    1.382289] AMD-Vi: ivrs, add hid:PNPD0040, uid:, rdevid:152
[    1.388621] AMD-Vi: Using global IVHD EFR:0xf77ef22294ada, EFR2:0x0
[    1.396087] Switched APIC routing to physical flat.
[    1.402932] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.413672] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x24093255d7c, max_idle_ns: 440795319144 ns
[    1.425426] Calibrating delay loop (skipped), value calculated using timer frequency.. 4999.98 BogoMIPS (lpj=2499992)
[    1.426424] pid_max: default: 32768 minimum: 301
[    1.429452] LSM: initializing lsm=capability,yama,integrity
[    1.430424] Yama: becoming mindful.
[    1.431470] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    1.432450] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    1.433674] LVT offset 2 assigned for vector 0xf4
[    1.434438] process: using mwait in idle threads
[    1.435425] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    1.436423] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[...]
[    1.451511] Freeing SMP alternatives memory: 32K
[    1.555512] smpboot: CPU0: AMD EPYC 3255 8-Core Processor Industrial Temp (family: 0x17, model: 0x1, stepping: 0x2)
[    1.556576] cblist_init_generic: Setting adjustable number of callback queues.
[    1.557423] cblist_init_generic: Setting shift to 4 and lim to 1.
[    1.558441] cblist_init_generic: Setting shift to 4 and lim to 1.
[    1.559442] cblist_init_generic: Setting shift to 4 and lim to 1.
[    1.560439] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    1.561424] ... version:                0
[    1.562423] ... bit width:              48
[    1.563423] ... generic registers:      6
[    1.564425] ... value mask:             0000ffffffffffff
[    1.565423] ... max period:             00007fffffffffff
[    1.566423] ... fixed-purpose events:   0
[    1.567424] ... event mask:             000000000000003f
[    1.568519] rcu: Hierarchical SRCU implementation.
[    1.569423] rcu: 	Max phase no-delay instances is 400.
[    1.570681] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.571565] smp: Bringing up secondary CPUs ...
[    1.572530] x86: Booting SMP configuration:
[    1.573428] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    1.581533] smp: Brought up 1 node, 16 CPUs
[    1.583424] smpboot: Max logical packages: 1
[    1.584423] smpboot: Total of 16 processors activated (79999.74 BogoMIPS)
[    1.610760] node 0 deferred pages initialised in 23ms
[    1.616606] devtmpfs: initialized
[    1.617480] x86/mm: Memory block size: 128MB
[    1.622733] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.633428] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    1.641527] pinctrl core: initialized pinctrl subsystem
[    1.647980] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.654543] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    1.662428] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    1.671427] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    1.680477] thermal_sys: Registered thermal governor 'fair_share'
[    1.680477] thermal_sys: Registered thermal governor 'step_wise'
[    1.687424] thermal_sys: Registered thermal governor 'user_space'
[    1.694451] cpuidle: using governor menu
[    1.705504] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.712494] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    1.723426] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved as E820 entry
[    1.731437] PCI: Using configuration type 1 for base access
[    1.738464] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    1.747451] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    1.755424] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    1.762424] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.770424] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.777469] cryptd: max_cpu_qlen set to 1000
[...]
[    4.453544] Trying to unpack rootfs image as initramfs...
[...]
[    5.597938] microcode: microcode updated early to new patch_level=0x0800126e
[    5.605837] microcode: CPU0: patch_level=0x0800126e
[    5.605837] microcode: CPU1: patch_level=0x0800126e
[    5.605839] microcode: CPU2: patch_level=0x0800126e
[    5.605839] microcode: CPU3: patch_level=0x0800126e
[    5.605840] microcode: CPU5: patch_level=0x0800126e
[    5.605840] microcode: CPU4: patch_level=0x0800126e
[    5.605843] microcode: CPU7: patch_level=0x0800126e
[    5.605843] microcode: CPU6: patch_level=0x0800126e
[    5.605846] microcode: CPU8: patch_level=0x0800126e
[    5.605846] microcode: CPU9: patch_level=0x0800126e
[    5.605848] microcode: CPU10: patch_level=0x0800126e
[    5.605848] microcode: CPU12: patch_level=0x0800126e
[    5.605848] microcode: CPU11: patch_level=0x0800126e
[    5.605849] microcode: CPU13: patch_level=0x0800126e
[    5.605851] microcode: CPU14: patch_level=0x0800126e
[    5.605855] microcode: CPU15: patch_level=0x0800126e
[    5.606797] microcode: CPU14: new patch_level=0x0800126e
[    5.606802] microcode: CPU2: new patch_level=0x0800126e
[    5.606801] microcode: CPU0: new patch_level=0x0800126e
[    5.606839] microcode: CPU11: new patch_level=0x0800126e
[    5.606966] microcode: CPU5: new patch_level=0x0800126e
[    5.606968] microcode: CPU4: new patch_level=0x0800126e
[    5.606748] microcode: CPU7: new patch_level=0x0800126e
[    5.606983] microcode: CPU6: new patch_level=0x0800126e
[    5.607039] microcode: CPU12: new patch_level=0x0800126e
[    5.607041] microcode: CPU13: new patch_level=0x0800126e
[    5.607041] microcode: CPU15: new patch_level=0x0800126e
[    5.606834] microcode: CPU9: new patch_level=0x0800126e
[    5.607086] microcode: CPU8: new patch_level=0x0800126e
[    5.607090] microcode: CPU10: new patch_level=0x0800126e
[    5.617884] microcode: CPU3: new patch_level=0x0800126e
[    5.716623] usb 1-4: new high-speed USB device number 2 using xhci_hcd
[    5.717926] microcode: CPU1: new patch_level=0x0800126e
[    5.795625] tsc: Refined TSC clocksource calibration: 2499.995 MHz
[    5.804743] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x240934df233, max_idle_ns: 440795202126 ns
[    5.812239] microcode: Microcode Update Driver: v2.2.
[    6.113951] clocksource: Switched to clocksource tsc
[    6.114024] IPI shorthand broadcast: enabled
[    6.129904] AVX2 version of gcm_enc/dec engaged.
[    6.132935] usb 1-4: New USB device found, idVendor=0424, idProduct=2240, bcdDevice= 1.98
[    6.144197] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    6.152168] usb 1-4: Product: Ultra Fast Media
[    6.157227] usb 1-4: Manufacturer: Generic
[    6.161803] usb 1-4: SerialNumber: 000000225001
[    6.166884] AES CTR mode by8 optimization enabled
[    6.167367] usb-storage 1-4:1.0: USB Mass Storage device detected
[    6.179082] scsi host0: usb-storage 1-4:1.0
[    6.210818] sched_clock: Marking stable (4857023098, 1353615596)->(6452406360, -241767666)
[    6.220186] registered taskstats version 1
[    7.203607] scsi 0:0:0:0: Direct-Access     Generic  Ultra HS-COMBO   1.98 PQ: 0 ANSI: 0
[    7.213623] sd 0:0:0:0: [sda] 15542272 512-byte logical blocks: (7.96 GB/7.41 GiB)
[    7.222724] sd 0:0:0:0: [sda] Write Protect is off
[    7.228077] sd 0:0:0:0: [sda] Mode Sense: 23 00 00 00
[    7.234350] sd 0:0:0:0: [sda] No Caching mode page found
[    7.240283] sd 0:0:0:0: [sda] Assuming drive cache: write through
[    7.254292]  sda: sda1 sda2 sda3
[    7.258027] sd 0:0:0:0: [sda] Attached SCSI removable disk
[  233.542760] Freeing initrd memory: 97528K
[  233.549574] Key type trusted registered
[  233.556012] Key type encrypted registered
[  233.560499] ima: Allocated hash algorithm: sha1
[  233.580213] ima: No architecture policies found
[  233.585287] evm: Initialising EVM extended attributes:
[  233.591025] evm: security.selinux (disabled)
[  233.595793] evm: security.SMACK64 (disabled)
[  233.600561] evm: security.SMACK64EXEC (disabled)
[  233.605716] evm: security.SMACK64TRANSMUTE (disabled)
[  233.611357] evm: security.SMACK64MMAP (disabled)
[  233.616512] evm: security.apparmor (disabled)
[  233.621377] evm: security.ima
[  233.624691] evm: security.capability
[  233.628683] evm: HMAC attrs: 0x1
[  233.717708] RAS: Correctable Errors collector initialized.
[  233.723891] clk: Disabling unused clocks
[  233.729671] Freeing unused decrypted memory: 2044K
[  233.735506] Freeing unused kernel image (initmem) memory: 2692K
[  233.743617] Write protecting the kernel read-only data: 20480k
[  233.750415] Freeing unused kernel image (rodata/data gap) memory: 980K
[  233.757709] Run /init as init process

