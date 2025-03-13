Return-Path: <linux-kernel+bounces-558727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41899A5EA0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38D4177043
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974442A82;
	Thu, 13 Mar 2025 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rpsf7PeQ"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020076.outbound.protection.outlook.com [52.101.85.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AD2E3390
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741835073; cv=fail; b=RMKLvWxrT7LJCZtdtLfFEo5FpYMbSNHnunNS8OlOnPHcp6rE5Vs57T0mMhNXf1+95SbaTfSdzly/fn16R5HT7t8+oHHksPowp/TGvOcSMPlyn9pEgFaBYSAULK2l7SGGHm9zg22TM03wwr3enHgJOZo5ARJw9o0N9adv+1NUG2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741835073; c=relaxed/simple;
	bh=lpsaA8ubcdHti/ksb9OTEqaMZl0TiHpd9ZkiFO4tzuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uL0xOTJlHmVDPWOIpWZgwWEZpkY+s1w+LhYi+44v0s/1Hinmk0rkZpuDkyDV00LwnwNe+vLFEBR5QXLfOBx0I302NrP2fRS+supkMY8zLS+WQhZynsxiihe8TXQl570DsWpVeH1HNtiy4c12YBK+xoUm68l3oXUGdlchzuQ6hKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rpsf7PeQ; arc=fail smtp.client-ip=52.101.85.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRt4SHevjNm+csC2GYF9ZmHiBYxoOx/Gu8QnH31GAl/aR/nivXJ9dS3V4DXzdMhbLwLRogix3kRrbaSjSfTz1mEm2KVk+X4Nn4gOxGD+xucPB9OwQoVf0BaaeOFhbWTfuNtwEwbed9rNyahXzqZg3RZY1Ve/kWx6lzJcHe6GgIGuAGw1tG9+PKxgvjeA6UZyfASMiC9fxhFdxAxMJyfi1aaz53RrvZ02nuBEs5tvtn8NZNQxjicZ7T6Qz502Bu7iQSfKkTcJqFlkfl0/I03wmOvWEv0HSpZGO1BbOVII3vHq51GWi5ZSABMrviJhSUE5RDA6dnSVHJjpdXdQPqVJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkHFL//OxiOOF9P82kpId4X0i+rNY17IYGxm2hmk41Y=;
 b=VwZf2F+QFQNbbp+PakhGKf6wZ1aZzl3itWvHUMtM2R7njTxIbGDkuQzaIa7SWtg/VcMe9x8DgpGqoUNN4Vq4tia9swm9ydb125ItjBJ6kmaRxmOeEc66r0n9VRTmeW5NpvLyma8O2I8MFGZPZtKQrJ96mVI0VdSD1/osNaoaA0JbFhsdU/VkY4X89bToo9l+C4leQ+fAeO10RuQoKBjzdqgVyRegdb6TWlHE/GN3AN3AxzpPO3J2aZuiTYuj5VFiTPiuhaWJD4heIln7VYR3iUzlDPp+9AuFAsyAxfVJr5Gt8PytCmaGxtUj4wtclmdRld7Mm0baEXYbLE1RAmPi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkHFL//OxiOOF9P82kpId4X0i+rNY17IYGxm2hmk41Y=;
 b=rpsf7PeQLBSstsocYcJSs+qqJGRMucApsmIwdLCRUo2+xmOsxU9gdaKQuXigsgfLHMNGJtjpl8Gdr20a2MmocuBh/hWaRaiJQXeSa4IybVdCacHK/3s4pEi1EGp/lAVa2H5De7fo64GHIjn4edU3FGXH4DAMCPF4L4bJE4MbkuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH0PR01MB6924.prod.exchangelabs.com (2603:10b6:610:105::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Thu, 13 Mar 2025 03:04:27 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 03:04:26 +0000
Message-ID: <459212b0-6440-48c4-b7ae-47be46f17089@os.amperecomputing.com>
Date: Wed, 12 Mar 2025 20:04:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mm: vma: skip anonymous vma when inserting vma to file
 rmap tree
To: Vasily Gorbik <gor@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, oliver.sang@intel.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <your-ad-here.call-01741821544-ext-0004@work.hours>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <your-ad-here.call-01741821544-ext-0004@work.hours>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:930:48::10) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH0PR01MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f14c81-dd02-4312-83d2-08dd61dbc3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEJGS1l3aWgxR3hnaXRpNThlVElKdzVPMnZoNjRBUmIxVjZiNHBCcS9Fbk5L?=
 =?utf-8?B?clE2Z3FIZGhMUUlpOFFBR25JV2Y2MExHRW1ycjVMcFJ2eG5PemVwNkZObnhB?=
 =?utf-8?B?Z0Jwb3BlajlmTHlCc0EwZmVEdkN4enhtd3VKUytySmo1dDRLRXFUcU9xc0xJ?=
 =?utf-8?B?NGdJK1hYZERMV2hvVGFRTVcxc0N1SkU4cjVKc2U1MGtuTG1EMWR3OXZZcHpl?=
 =?utf-8?B?aGFTNjhZRHFjWXFsY21XamR1bnBncTcwSmpDRGd0UFZwUnpBaXBFTlo2TU1v?=
 =?utf-8?B?Z2x6V2ZNSkM4OWh1aTVzYXFWMENzZU5lSDdGTnBYQXFHa1JtNUsrUVRmMys1?=
 =?utf-8?B?bnVjVVRZbE1odVJsbEpNQ1M1R3hUYkdVWW1vQ3ZqT29uTThyNkgwMU5nUGR1?=
 =?utf-8?B?NkdNdDlwWlR4Q0gyZEc2V2ZIZmJaTW5xdFBLQlhTam5KNGI4UjdJYk5mZHJK?=
 =?utf-8?B?MWxucmM2emFVMWVJZmVScHhPYTFMTFdGOGFTdDdLSVQ5ZkhNVHV3WU5qSWFv?=
 =?utf-8?B?QjdMUm1Dc1Nqc3J5cjNkdkp6WGhadnBGNDlRaTJ1NDZydnRIZ0FEVExvQ3FY?=
 =?utf-8?B?cU5WaURZYW15eWFKR1FUdGU5czFVVTdsb3JRN202OUxNUXNsZHFiU0VacEJ4?=
 =?utf-8?B?Vi90WWJsOXpkVzdaOW12TUMwc25sanhwNGNOcEFpNEo0bVdQZTZ2YW9jR1hj?=
 =?utf-8?B?ZWkzOUU2d1lNNiszSk1aYXREd2UzZVIwd0I5WEFnQ2pOdDNjUWc0Z0FYOUlI?=
 =?utf-8?B?OGErYUZVQnBpUlpYd2NodnRaWDRCb21seGxBZ3RtZGFvTCtONjNibGlEcmQw?=
 =?utf-8?B?ZDNtZXhacFhoTCt5OEt1UTU2ang1QzJoK01GaFFPM2tqbEdoZXZxZk9KQUVw?=
 =?utf-8?B?Tjd1V2pZOUxYOTlyS3ByTGZzZXNGeXlwdnZBMlUrcjEvbTE1MDUzcDVOcmFC?=
 =?utf-8?B?RHdQbEpUNzJPRk0yYTFXcVdkaDhrUkgvY2Q4NUlJRkVPejMzU010QUFCb3V6?=
 =?utf-8?B?eXR0NDhGVnFrMnRTS1h4eVJkNytYaHNVcWdRL0JZSUdTeHpyNGcwUDlzRGNE?=
 =?utf-8?B?RHI4ak1FTmFiM01EbS9jeDcwVmp4OU1LTkk3R3FYb2JPV1Axa2RPTFh0d3Q0?=
 =?utf-8?B?dmlsZ05sZUpCNEdIRkFOME0xbEFXR0pwMm9xL2FaL0lYL3Vxcnl3SUhzc2JT?=
 =?utf-8?B?LytPTjZRaU9kU29USExVQ0dZS21lbEJLcWV0OWh4c0hEajBkNnRuWFJjUFcr?=
 =?utf-8?B?VC8wdEYyRXU0ZmRJRGFZNmhRRFFpNzRYRGdyZTBVVGgrSGk3bnZ1L01CSDI0?=
 =?utf-8?B?NGp1ak5CNGExckdQQXJ1d0FIeVRZekZLNFVPSDlMQ3ZLdWVsd01kWlg2N3A2?=
 =?utf-8?B?a3gydFBNRC95VS8wNEZDandDL3JqcGE5TG9XV3QxTlkzaGtUTUp0MkdjWVo5?=
 =?utf-8?B?Mmo2a0hTcnhmNlBaWlJOQlRZcUtwOFdWRU85cGpVWkVGOE5KSU4reXNzY0Vk?=
 =?utf-8?B?UmhCVG9UVEo3S3E4YzhaNnBBTzFzbUpHcE9PV1BURDZCazdGY3cvZWYwYmNo?=
 =?utf-8?B?VXArU0ZzYk56Tzh3aVdaN0hJWnZiRFBEeVBqUlN1UHBsQlU3SDlqQm9zUzh5?=
 =?utf-8?B?VUU1Y09yQTk5c1dHUk9tQ3RXNnRGN3RPVnB3RDBBMEZGem9DbnJsS3VLWndU?=
 =?utf-8?B?Q0todzlOR0c4SGRITVA5eU5EMnQxTmFhbWgzVTNlM3E3YllwMjFZSmxyRDRK?=
 =?utf-8?B?WGNkOXRHM1IyaVZaUGVzSHE1emFJRG5wOUlDc3k4Yjg3UHFNcmNqOUFGY1VI?=
 =?utf-8?B?UGN4ZVlwdnVuSTQrRy8wcmhOMTdnZ2wvRHA2bXlYaTJpdDQrMjd0NDA4Y1M4?=
 =?utf-8?Q?brRkRMR7Ui8dC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUowNGZXbEFYZVlkUmxjb1ArZi9sa2IyS3JBQzRGeFdEZTRWN0JTWkN0Y21K?=
 =?utf-8?B?UEQ2QUh4bEhuQkhLZzlNeWRSVG1NbzB6UDVpaUJYdElxQzllY0pxWm85WmNH?=
 =?utf-8?B?L2ZOUVZpY01hUnU2cmtNU24zM2Mwc1duUXpkN2lRZGRUbnl1U1llT202WlBm?=
 =?utf-8?B?S3pmRmhyZGh0VkFSNkYzcUgxWWpiNFN0bk5nQlM2NjJNK1plSSt6T1RQR2o4?=
 =?utf-8?B?SWpiaDJwM01RR2hNQlZlSnoxdFZ4aXY5NUhkZTJtZVdya3hsV1hTRHB6MkRo?=
 =?utf-8?B?RmRORkU0ZGJ1d3M4WHpzMGkrVWtPYjFkeTU2UzBDNEZFL1h0bTNUejVmMy9R?=
 =?utf-8?B?MThvYm1mSWlXVWNnWnRJSmw1MkpsM1cxUmp2d1BORHBDUTc1b3dmYThqV1BZ?=
 =?utf-8?B?WnpxdFB6WVRPaWZkRkNsaC9ZenhhYUk0bm5rb0NyZFdCaGRvd0N3T1czejVx?=
 =?utf-8?B?dzFJc0ZBa3p5Mk5iZzN4aGJoUU5ScXMrN3YwR2RyTHRxQTNWbXpPRk1Cd24z?=
 =?utf-8?B?WTI5ejFtWnRVdytRUXQ0eUZPaGMzNW4xYjNGd0t2MjJTbFFCSzR1QTNDTk9E?=
 =?utf-8?B?eU93aVM2a0luQmh2bGl2RzNEY1hTT3VrMlI0dkNDRmJSYW9iMm5zL2Q1K0or?=
 =?utf-8?B?OE5NeW1iOGVMQTlIQm9POVFaSEFzRVVhUFFKSHRia25ZaDJuYjFyKzJiMDZG?=
 =?utf-8?B?dTNyQU5SUkIrRktVRnhwcHBnS0lkNjUxbU05eXZJNEJmby8xOFF5NHlrUHJX?=
 =?utf-8?B?R0kzdEJkZ2xZa1FkZnJCZG4vTmRqbzNEOENCSmNQcEZOd1lYRXZyZk5icnNy?=
 =?utf-8?B?WnF5RlpiVWliVkNXUzU2ck9VZ20vS1pJYzlYaWlxMTlsekNRK25LbVVyandv?=
 =?utf-8?B?Y3A2SXlTUUV4cnk5WHJROVJNR1ptdjRXMTlQMy9BeFZoNXhOQTJFTkJxbHl0?=
 =?utf-8?B?cXYzakF1bURBZUxiMG5wYmtEbCtmV1RHbWdIeGdLMXN5d0k5VFdRbzdPUW5z?=
 =?utf-8?B?cTlwNVRDVVh2dCs0NnI5eU5yRmFUS2xvZmUxVnlrdXVxVjJTbmx5clVJVFdD?=
 =?utf-8?B?Y3V5REltTVBBanhFVFVZa1hCVSt0SFZJMFZiTGg0aHJqaTJKYnRnOHZkR1d6?=
 =?utf-8?B?aGV0dzUxTmVUcjhxa3EvU2o4RkVrRTZzMHZ4Z01Vemc3dnE5c01VU1RqcnpP?=
 =?utf-8?B?SnlLYnV1TzA1SldqZGpDUmhJZWN6Z1U0RFVIdnhkbUFNOS9KckVEZHFaVVJ4?=
 =?utf-8?B?TXRFNWpoZmVmVFFpZ3pvcWpqZVFsSFI2T25pTXAwNXJDaWM1YzBZaFdGb2I2?=
 =?utf-8?B?d0o5OTRReUNHVWtNTEdzNGIzU1Z3MDNjdld5eFhoQzJRVVZqWVJ2NXdscXFo?=
 =?utf-8?B?M3pLVVJYT01PQ0JJZzJqa25hcjlnT0VOb0Zpd0FINDJXR2tJUWlENnYxNEpS?=
 =?utf-8?B?akpBUk5TWExKQ29tQ0lmOUdKY2l2dnAzSUlFMVpYTXNkenRMM2hIejI5bER1?=
 =?utf-8?B?VEZMQ1hNUk5FL2RBcjFwVzdQV25xRU9VSVJ2dDVjUlZLQjVYdlJkdURNamFr?=
 =?utf-8?B?bU1aNFQ4MDkyY2EyM21BNFE1anE5WS9IbEg5MVRJemM0RnFMQ2hNaCtzcHJh?=
 =?utf-8?B?MlluL0FpNDZiNndHNVVaNkhvU2J5UGxva2w5eDdXNHQyZmR4RWlWay9Xb1R6?=
 =?utf-8?B?ZEU2a0VYdFFKb3Q5aTU1bVVvajlaQTBxTXFQa2xYSmZzM1JLSW94OSt3L1Za?=
 =?utf-8?B?aURIcGZVNm5RR2U1aTBPMHJVYWRxKzk0bFNHbGhlcmUwclZ0YnBmWUdvNnpz?=
 =?utf-8?B?aURRYkowc0FOdUdObExLLzJWT1I2SWovdmhxKzNQQ2Vsek9SMjJ5OFhvUEpR?=
 =?utf-8?B?WGhBRDRlYlhPSWo3Y3BYaVJrK0NaQWJlNjZZM3lvaitZMEhsY0t3cGpmYU9D?=
 =?utf-8?B?OEIyeGMvbVBVVDZKbTJvZlpOZUdWNmQySE1hVEYwNzhyZXNDaWVBcVdqM3By?=
 =?utf-8?B?ZXFPbHFDWjBHRjRNTmhKT3pnamQ3VGRHTlc1VlpUWHNWTmpueW05YUxvUGVB?=
 =?utf-8?B?TGp5L2oxSGxYUTFmcnBZM25NUlJwZzdua2dFZlFGNHhYNWl1d1RHN0wvcU5E?=
 =?utf-8?B?cHBhMkZYc2l3NmlJaGZXT0V5eGxqYzdQcUNXRG4vYkE3L0I2RzAvcWV4LzF1?=
 =?utf-8?Q?jcXvvOH1BKr00zvlwXdfhTM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f14c81-dd02-4312-83d2-08dd61dbc3a6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 03:04:26.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1zdKQWrHq7B0VbC08XlEtaz9wsKfHnxWX3CpEpPIcP5z08D3GNhaecux1bMEUG6d6VQE0QlRpMdtF7LSo7hN1dzvjd/G8ZiNumA1gcwbVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6924



On 3/12/25 4:55 PM, Vasily Gorbik wrote:
> On Wed, Mar 12, 2025 at 03:15:21PM -0700, Yang Shi wrote:
>> LKP reported 800% performance improvement for small-allocs benchmark
>> from vm-scalability [1] with patch ("/dev/zero: make private mapping
>> full anonymous mapping") [2], but the patch was nack'ed since it changes
>> the output of smaps somewhat.
> ...
>> ---
>> v2:
>>     * Added the comments in code suggested by Lorenzo
>>     * Collected R-b from Lorenze
>>
>>   mm/vma.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
> Hi Yang,
>
> Replying to v2, as the code is the same as v1 in linux-next:
>
> The LTP test "mmap10" consistently triggers a kernel NULL pointer
> dereference with this change, at least on x86 and s390. Reverting just
> this single patch from linux-next fixes the issue.

Hi Vasily,

Thanks for the report. It is because dup_mmap() inserts the VMA into 
file rmap by checking whether vma->vm_file is NULL or not. This splat 
can be killed by skipping anonymous vma, but this actually will expose a 
more severe problem. The struct file refcount may be imbalance. The 
refcount is inc'ed in mmap, then inc'ed again by fork(), it is dec'ed 
when unmap or process exit. If we skip refcount inc in fork, we need 
skip refcount dec in unmap too, but there is still one refcount from mmap.

Can we dec refcount in mmap if we see it is anonymous vma finally? 
Unfortunately, no. If the refcount reaches 0, the struct file will be 
freed. We will run into UAF when looking up smaps IIUC. It may point to 
anything.

Lorenzo,

This problem seems more complicated than what I thought in the first 
place. Making it is a real anonymous vma (vm_file is NULL) may be still 
the best option. But we need figure out how we can keep compatible smaps.

Andrew,

Can you please drop this patch from your tree?

Thanks,
Yang

>
> LTP: starting mmap10
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 800000010d22a067 P4D 800000010d22a067 PUD 11ff09067 PMD 0
> Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 5 UID: 0 PID: 1719 Comm: mmap10 Not tainted 6.14.0-rc6-next-20250312 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> RIP: 0010:__rb_insert_augmented+0x2b/0x1d0
> Code: 0f 1e fa 48 89 f8 48 8b 3f 48 85 ff 0f 84 a4 01 00 00 41 55 49 89 f5 41 54 49 89 d4 55 53 48 8b 1f f6 c3 01 0f 85 e1 00 00 00 <48> 8b 53 08 48 39 fa 74 67 48 85 d2 74 09 f6 02 01 0f 84 a0 00 00
> RSP: 0018:ffffc90002b47cc8 EFLAGS: 00010246
> RAX: ffff8881143ab788 RBX: 0000000000000000 RCX: 00000000000009ff
> RDX: ffffffff814ad5d0 RSI: ffff888100bb5060 RDI: ffff8881143ab088
> RBP: ffff8881053af8c0 R08: ffff8881143ab700 R09: 00007ff6433f2000
> R10: 00007ff6433f2000 R11: ffff8881143ab000 R12: ffffffff814ad5d0
> R13: ffff888100bb5060 R14: ffff8881143ab700 R15: ffff8881143ab000
> FS:  00007ff643df1740(0000) GS:ffff8882b45bf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000011b042000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   ? __die_body.cold+0x19/0x2b
>   ? page_fault_oops+0xc4/0x1f0
>   ? search_extable+0x26/0x30
>   ? search_module_extables+0x3f/0x60
>   ? exc_page_fault+0x6b/0x150
>   ? asm_exc_page_fault+0x26/0x30
>   ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
>   ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
>   ? __rb_insert_augmented+0x2b/0x1d0
>   copy_mm+0x48a/0x8c0
>   copy_process+0xf98/0x1930
>   kernel_clone+0xb7/0x3b0
>   __do_sys_clone+0x65/0x90
>   do_syscall_64+0x9e/0x1a0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff643eb2b00
> Code: 31 c0 31 d2 31 f6 bf 11 00 20 01 48 89 e5 53 48 83 ec 08 64 48 8b 04 25 10 00 00 00 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 89 c3 85 c0 75 31 64 48 8b 04 25 10 00 00
> RSP: 002b:00007ffdac219010 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff643eb2b00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> RBP: 00007ffdac219020 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ff643df1a10 R11: 0000000000000202 R12: 0000000000000001
> R13: 0000000000000000 R14: 00007ff644036000 R15: 0000000000000000
>   </TASK>
> Modules linked in:
> CR2: 0000000000000008
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__rb_insert_augmented+0x2b/0x1d0
> Code: 0f 1e fa 48 89 f8 48 8b 3f 48 85 ff 0f 84 a4 01 00 00 41 55 49 89 f5 41 54 49 89 d4 55 53 48 8b 1f f6 c3 01 0f 85 e1 00 00 00 <48> 8b 53 08 48 39 fa 74 67 48 85 d2 74 09 f6 02 01 0f 84 a0 00 00
> RSP: 0018:ffffc90002b47cc8 EFLAGS: 00010246
> RAX: ffff8881143ab788 RBX: 0000000000000000 RCX: 00000000000009ff
> RDX: ffffffff814ad5d0 RSI: ffff888100bb5060 RDI: ffff8881143ab088
> RBP: ffff8881053af8c0 R08: ffff8881143ab700 R09: 00007ff6433f2000
> R10: 00007ff6433f2000 R11: ffff8881143ab000 R12: ffffffff814ad5d0
> R13: ffff888100bb5060 R14: ffff8881143ab700 R15: ffff8881143ab000
> FS:  00007ff643df1740(0000) GS:ffff8882b45bf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000011b042000 CR4: 00000000000006f0
>
>
>
> LTP: starting mmap10
> Unable to handle kernel pointer dereference in virtual kernel address space
> Failing address: 0000000000000000 TEID: 0000000000000483
> Fault in home space mode while using kernel ASCE.
> AS:000000000247c007 R3:00000001ffffc007 S:00000001ffffb801 P:000000000000013d
> Oops: 0004 ilc:3 [#1] SMP
> Modules linked in:
> CPU: 0 UID: 0 PID: 665 Comm: mmap10 Not tainted 6.14.0-rc6-next-20250312 #16
> Hardware name: IBM 3931 A01 704 (KVM/Linux)
> Krnl PSW : 0704c00180000000 000003ffe0ee0440 (__rb_insert_augmented+0x60/0x210)
>             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: 00000000009ff000 0000000000000000 000000008e5f7508 0000000084a7ed08
>             00000000000009fe 0000000000000000 0000000000000000 0000037fe06c7b68
>             00000000801d0e90 000003ffe04158d0 0000000084a7ed08 0000000000000000
>             000003ffbb700000 00000000801d0e48 000003ffe0ee057c 0000037fe06c7a40
> Krnl Code: 000003ffe0ee0430: e31030080004        lg      %r1,8(%r3)
>             000003ffe0ee0436: ec1200888064        cgrj    %r1,%r2,8,000003ffe0ee0546
>            #000003ffe0ee043c: b90400a3            lgr     %r10,%r3
>            >000003ffe0ee0440: e310b0100024        stg     %r1,16(%r11)
>             000003ffe0ee0446: e3b030080024        stg     %r11,8(%r3)
>             000003ffe0ee044c: ec180009007c        cgij    %r1,0,8,000003ffe0ee045e
>             000003ffe0ee0452: ec2b000100d9        aghik   %r2,%r11,1
>             000003ffe0ee0458: e32010000024        stg     %r2,0(%r1)
> Call Trace:
>   [<000003ffe0ee0440>] __rb_insert_augmented+0x60/0x210
>   [<000003ffe016d6c4>] dup_mmap+0x424/0x8c0
>   [<000003ffe016dc62>] copy_mm+0x102/0x1c0
>   [<000003ffe016e8ae>] copy_process+0x7ce/0x12b0
>   [<000003ffe016f458>] kernel_clone+0x68/0x380
>   [<000003ffe016f84a>] __do_sys_clone+0x5a/0x70
>   [<000003ffe016faa0>] __s390x_sys_clone+0x40/0x50
>   [<000003ffe011c9b6>] do_syscall.constprop.0+0x116/0x140
>   [<000003ffe0ef1d64>] __do_syscall+0xd4/0x1c0
>   [<000003ffe0efd044>] system_call+0x74/0x98
> Last Breaking-Event-Address:
>   [<000003ffe0ee058a>] __rb_insert_augmented+0x1aa/0x210
> Kernel panic - not syncing: Fatal exception: panic_on_oops


