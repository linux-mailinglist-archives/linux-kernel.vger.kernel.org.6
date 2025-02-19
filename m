Return-Path: <linux-kernel+bounces-521863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA76A3C350
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7EC175A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DC51DE2BB;
	Wed, 19 Feb 2025 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="i00UNb/t"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022074.outbound.protection.outlook.com [40.107.193.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4741F540F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978015; cv=fail; b=iYStxZE3pOT+156KflfQvJvSf6O+L1HeCKa8+bD5uE0ACBJxtL+WCR/hxmfscTl6H+Er3xJiOqMly8iS2LWRm7trENgbkj9Z2fBc9tKWtgRBfzNZoYUVm3+Rd+LESTEDgGqoNppyLaZJOO+Ftg4Xp4//D0dIiX9UenAIT+HjNyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978015; c=relaxed/simple;
	bh=7IAzFHglTZS1Rp8lIF0Bi6JhCXZh2Hcanhrj372+qKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4XZUmTgBeZeFjDbLI+EQlhu7YvG1WRIto7QmOh44jJBTYTk66LYioC7rocMmT6ZNWQszz50w705Xc7HpP2RL3JFERGaLKBihgOw3NmZgT5HPo9+jIyYHeatVC+q8Rii9+y1P+GIcvdsQfHDEgfBpP3hh9EnDTronEh0TqUY4s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=i00UNb/t; arc=fail smtp.client-ip=40.107.193.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRDGQNc1vFQr7+B5zBKi3oL/XX3yxU696fjlLBd8aHJUF0XlUteCfZUDgacKQMb/Y0aGs2bI46V7bNNF4F/ioKs4ORoAUX2jb6zDrLPaSTOn1/puOdjAgT9kZsOkyNBKz8MsNzAhKVki6WTdwJsjCl79/cZMnvey54gE7OdZsvk93+n9vVcYD+zFV0Vwl1vknJFk0OqaXqVqyOI7IIZL8TmLx1uS2NIr1m28bCaTo7+4s2DE0/1jOpOOi9R46qtqNjLWGEMdmQewy2N0GJ6/ePeWbSIBr/dV7pZymLQVQiOGbIDEwlfeMKo0kpnsFc66mtRltIhHlysxZOhxR3mq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRZJDrnKp89xDA0SMMVQtOMzambriMArCE4vG6vipuQ=;
 b=D1ieNAFGbU7rQ9lEKh3Scfrd579KgypoUkT1P6AYNxaBb9qGZKGOUKVevIPA1lBi3zvUyK01yHuBSUIb0vC9/8CV0ZgPXgnSu2KLx0dExikJ2kMmdUZX06keO7ySReDL0mFeQZqIYuIS13MnwHBrQOaXxeFIaAabqGLYtKKHgIBkz7ROGO1xcoxb5NrljBbCJOKQ8Vu27bgwVl4/G0ZpmJNYHNdBklWsxCbeBl8e3nQk1plUaVuLhgvQEWUjbv/+NhYl3uLvQIb2rUw7mcd3t4N8bI+JOdd5ltfIQdkcIQatjizDC17WPGdExoDVeiPSL9AI1lYesR86ynXZCTG+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRZJDrnKp89xDA0SMMVQtOMzambriMArCE4vG6vipuQ=;
 b=i00UNb/tFoUrLsViJTzzGdWF/Hb4JvSOpNo9eoq0aPDgGHmZyGQkdUlDWc3niD1rOeiywPms+BAz7D77NEG6NIYc/AzycYLJwEcz44r6WW5Juui2awtDKxeUml1GYc5nIcRCwscn8QJox2TU42s4WlEYdlmDcki/CAxtbUdUSHwIpRlHWWhsdtIw4mr8YJ6YlClaDUdl7Xa6j3ZqWZxSzrkLr6OKwCAlYNTfZKxL1QUWxtYEQizJUeFx0ExbMG+hvy/iSwGojf+q/4re8ST2aGhslum22HsGaxSx7jBvGBG8lA9kTgDhHozpYfc9TiKRx+kk19bhUDHVwuqu+TNQvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 15:13:30 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 15:13:30 +0000
Message-ID: <8fc793e3-cdfc-4603-afe6-d2ed6785ffbb@efficios.com>
Date: Wed, 19 Feb 2025 10:13:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] sched: Move task_mm_cid_work to mm work_struct
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250219113108.325545-1-gmonaco@redhat.com>
 <20250219113108.325545-2-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250219113108.325545-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7620f2-8246-4326-5ce2-08dd50f7f7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTdVK1ltM3h2d3EwL213eTJwNmZaRnV3ZGJLY1MzcXZLeE54OFBMR0xEZTNU?=
 =?utf-8?B?bll4eVpCbGZISGhnMzZ3ZkZ6ZlJrdmQrcndraEVGaDNUd3YxelZlcDZlaHZK?=
 =?utf-8?B?OGF5aW40M3ppMmM5OVJVdVhUMy9rdmMzaFBTOEZhL01UaEtqd0VXeG9Ma1pw?=
 =?utf-8?B?NHFiVER5RGkxN1BXT3plTU1IR3hEMmlzRWZMWUwyZmVKQTN3RUpnUmphOFpL?=
 =?utf-8?B?ZHNUbUg5RGtSU3k4NVdoM081cVZQOXJWMnVnL093RzFBTURxa25zK3RrdGdq?=
 =?utf-8?B?V0tRYVJvZ0xXM0MwbW1VMjY1UHdFazcvZ0hEd0dKN0R0cG1qanRKNDluSUpB?=
 =?utf-8?B?NGpqQTR2bmNjTHVubE04aXlwZUJUSGxyN0hnMkU0WGM5Vi9lQU1RUXJSY2dt?=
 =?utf-8?B?Szhkc1FCS1d4ck5LWkFtaU9vWHl3NGxxSExxUFNnN1Ftb2tTZTNvNjI0ZVVa?=
 =?utf-8?B?aWd3ZThiM2RpRVlFYzFFRkdxb2hsaDQ4Mk5BSHp2VXNpSGZwWk81Y05ITS9K?=
 =?utf-8?B?aXRvUmR2NmhMSlp4Q0xEYk9oL3lMeTZrWGtVN1RTR29nRGtDVGxCcmtiZDZo?=
 =?utf-8?B?R3RldWxpcWM0eFdvS3h1TWVkcWpWdXBodTdHSGczdUNzOGpEa09oTEhmY2JU?=
 =?utf-8?B?d0xZUVMvb3JxVU1hcExtc1BRMTZhL29odW82YVFYOVVidVdMSnZqTzFNT3NJ?=
 =?utf-8?B?UW80SUorQllIRS9HR2V1cE5NZ2J1T01hT3Ayc1FVOGNMUXhGVFNtRmE0dnEv?=
 =?utf-8?B?anJGMkFaMnJJRXdHNHpOaUp1bVNLckR0cDQ4c1hKZ1dHdGdqRDFnNmxJVUZW?=
 =?utf-8?B?N0srS0xESVUxT2U0UFBvNHRoNFlIQ1JQa3lIMCtvWFBZdGg0NUZjNTZJYUJ6?=
 =?utf-8?B?UU5hTGdHNy9WT0ErUExKdGRrYXNZaHBock4vSkpNanFNazZPQ3FuNzZXNlpx?=
 =?utf-8?B?OWZCeVo5Q1lOam50ZEJIRkwwelQ2VW9WdWtKQTRIVysyWG5PaTFob05YWjVz?=
 =?utf-8?B?bWpxSnBKTjVIT1BiUmU2cDFIR3NEcnF2RkQzUGpESy9qc0I0bDZUM2RjQlhM?=
 =?utf-8?B?WGVHWUM1bzJ5ME4va2xoa2lmM04xckc4Ky9ablhGL3VvM0J6bFUrY2tYUDFT?=
 =?utf-8?B?UFJiN2VRUEpWbWFjd1o5T1NjTDdZS2dzMkRlS2oxMGRmM25UUFdvZGNSVUdp?=
 =?utf-8?B?Y2VwK2VTc0lrK1NpdFJ1Tnk0cmxTUUxJVkhHVE5oMktLcGtOa0VEaXBCSU5v?=
 =?utf-8?B?NUpqa1duTklXZnV6Z2p1VWozaW02aWFUTjViNGI3eiszbzlpcURRdk5CVmo1?=
 =?utf-8?B?NlQ3SmZXRjgrOU0zdEtxaHQzL2pOaFQwRTR0L242YXo1aEgrdm9TNUFqNkpu?=
 =?utf-8?B?VDZadGdGdWNoMWthU252bDBMUXhVbXlSUk90bXlWNCszREFuVWd5alU5cktZ?=
 =?utf-8?B?NjByYjVHUDU0eEFzZkxvcVFVTFVYLzZwWm5La3VNQVJRa1VMVXZsL2xXVnlk?=
 =?utf-8?B?emE0aDAwaFMxRWNnYVdGUFRzdDhqa3NjN0x3ZXg1U2IrR2U3d3ZHM2lFdDZO?=
 =?utf-8?B?c2h4NmFCNzBmY2lBdGFmczNrL1QzNmliaUdaWVRDeU9CMmVrdi9EZUZ5aXh6?=
 =?utf-8?B?VG01MlhpV3hFSUgrNHJCUEppNlV6Nk9hYUxscGlaMzVsMmw0Sm45ejFPMklZ?=
 =?utf-8?B?SnpRWXlzWFNOdWtTMmROc0NPNm9yZHdIbzIxWUp6MmVXamNsU3RoaEc2QTJZ?=
 =?utf-8?Q?zQwVK+E7WO+V9zcY5G9Ph34Xh+96EGFhnmxlBQ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU5FSm5tN1dBdWptcGpCbkN1NlpndDVPUGxqcHpsSDhRR003WlFXbW0rSGlX?=
 =?utf-8?B?bWtmeEQxS0RTdFhYeGVWNDlLK3pOYWNiNGtXWm5rUDRmVG5WaVBEazhITEtM?=
 =?utf-8?B?UU5WcnRtejlONWhPREk4WE5OVnNKZU9zVXlLR1FLcTZ2WU1uZ3NHbnRPUDZj?=
 =?utf-8?B?V1JXaWozVmNJQVZQS2I4dDNkSzc4WHJVZUhkQWpXR0NoZWpUUzlhNktIMjAw?=
 =?utf-8?B?VkI5WFFnNGhuUDFtMm81WTQ0OVNMUEVEempHcmlhOVMvSXVJcVN2eDh4TGp0?=
 =?utf-8?B?MXFJRllOMm56R3B0ekNINU1mVVZpS2FjM1RzYlZLSW5hMUtZeTNzeGFwVHZ4?=
 =?utf-8?B?c0xKY0ZpcFRaUkp5WnloNi82bVg4eWh2bmY2R2F5RUhFeEI2VUlyTlllT0tN?=
 =?utf-8?B?ZVc3NlVSa1k0dVlIVkhpK3NGWUttbTZYc3J5Tm9GcDBjYkNjN0tyeDBRVUZD?=
 =?utf-8?B?a21KRlA1RkI4K2ZreU1PVGZxb09lOUVlVzF1emFoUTg5V2hTZ3RTZ0U1N0pl?=
 =?utf-8?B?NFhOM1VvVlRRUWZxVDZjenlpNy9ieUs1a2ZTd2tIL1k3UXVPa0NVaDRVRnlz?=
 =?utf-8?B?c1NQK21mODVia0Z5TnZGU3hadUlHT3NZWW5GT2V2RjY3eG05QkE2TzdiRW4x?=
 =?utf-8?B?TzlBOTYweXh0bXl2VkdqQjJlZWlpck00MDNNcGdraTF5MndMd3pmcjJIMk42?=
 =?utf-8?B?SVBTZ3AwZnV4TUlhTG8wZWEzZ1d0eElzeVM3VjhLNTYwVjY1K29pZTRUM2F4?=
 =?utf-8?B?OXdnbzZMU3Y3M1U0Zmt4blFHRmIvY0lCYkExNGpoMHdiUHpmS3UwSjh3YWU1?=
 =?utf-8?B?V2VQVzRVdXZLcTMwU1BFSXRLQmJ2ZUdKbEptbllDN0luMVVmcElQb0YzbzY2?=
 =?utf-8?B?OEZXQWxvcmM3NUZ1MnNwQ3BPd3FGYTJkR1BOSllXU3dIcDRGVmhMWDVMeGF3?=
 =?utf-8?B?YlUrWFlTTVFBc2p1V0s3VlJQdTdkNHZKMXlkRlE1UFdaMlVZa09XOWVEMjNI?=
 =?utf-8?B?QVFqRVJ3bWpGaUhlbHRSK1hEa1RUM2xBSG5mSXQwYWZURlhCSHFyVTVpNlF5?=
 =?utf-8?B?L3dYUE1tT1A1L1hpSGtsTXl0MTczaFBJOWtKWGtOU3lLbm9xNmVvN05DdXo4?=
 =?utf-8?B?YUg1VTN1SDZmS3d4b2RTbTVuelhxSFBwbnFPSTU3cXUzUVB1Q3FULzgzb2xv?=
 =?utf-8?B?TGErdm9WdDRqRFJrQW82a2QxTElDU3d1ZkRJVXhhdzZhZ2FZbndJelhWS25u?=
 =?utf-8?B?ZTVyOHJOUEhTVEhYemlXSjdJOGJTTXdDS2thOFNRYWdnS21sZUV0clJsaUlC?=
 =?utf-8?B?R2tzaGdJWkFKZnV1VFp0UURBZ3dFTTNHS2paU2tKRm1WTkt5VEE2VEJORyts?=
 =?utf-8?B?RytVOU5vU0RDODJwVDJ2MjR5dE1lU016THVHT1lHK29xMHpkYTNKRDFJcWFF?=
 =?utf-8?B?N3dnOTFCQ3hQbERWcnlMWlNCVnJ3djAxd0N0S2hEYU1CTjFzcFhUeCt5Y1RF?=
 =?utf-8?B?ODNUbW52RXJxUzgxMmQ4QnBzaWVLbFZHM3FrT0s4OERzdUNGcFF1WHYyTGtF?=
 =?utf-8?B?K3ZrRzFPRThIRjd2alMyU2ZPVXVFTXZGdTJsRk1EYVRTZ0NhMjdsOXFZSW9D?=
 =?utf-8?B?aWxRcVNwc0thV2J5Vml3cHJrNXEvY290eUEyWGN2WTR1dGJZNDJvT3VTWVNU?=
 =?utf-8?B?V3k4Q3ZhL2JVTERTa0toaDdmcThxMUtvRWRzQ3QxNmtneVRmNFRFeE96ZXBR?=
 =?utf-8?B?ME5HdzdYOWtWQ01VUWRXUWpJZE52M2x0V3Exc2wvWUFMUi9LdHdGYkQ0TEtp?=
 =?utf-8?B?eTNPQzIxNlRWTDJaV2lKc1pkTlNIeVpDOU1BTm5vV29jL1FEdy9vZjltbnJV?=
 =?utf-8?B?WGdxOXRUeG9iS3NjalluMlBxaUZaamFXb0VkK1J3Zzg2RUNZVU1seUYrRVBF?=
 =?utf-8?B?SVF3L2xUUGNsTWVWZTRDYUc2WXNxQWFReC9xSVBNNlNLd01NR3J0aEl6cnZD?=
 =?utf-8?B?b3I4OVU0Uk5IQzk3VmRTcGc5ci9ZdURqb1pCZmtrNmx0VVM2OFA2d29NNHk2?=
 =?utf-8?B?N3NzYS9mc3NaMUVNc09wTnovRjZIeE9aVm5yQmdwZFFmYlFCNkIzalFqSEFY?=
 =?utf-8?B?UEJMcUlEOTVTTXRHMXMxTmMxekdmQm12eUJvWStkajBZS29UMUtoMjhnTlJC?=
 =?utf-8?Q?ftFiqAIvQhcmf6eJsoAS0GU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7620f2-8246-4326-5ce2-08dd50f7f7a2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:13:29.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UTasGYocd6m8qZ4HldejnYLKOg76qmeWkIdW9DuL2WvfHY7WXYNCWhLQhn9CJZT8FY9kjonkBEnxeBAirxFi5UHbMiXUiWMpCW4rb7SPCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6137

On 2025-02-19 06:31, Gabriele Monaco wrote:
> Currently, the task_mm_cid_work function is called in a task work
> triggered by a scheduler tick to frequently compact the mm_cids of each
> process. This can delay the execution of the corresponding thread for
> the entire duration of the function, negatively affecting the response
> in case of real time tasks. In practice, we observe task_mm_cid_work
> increasing the latency of 30-35us on a 128 cores system, this order of
> magnitude is meaningful under PREEMPT_RT.
> 
> Run the task_mm_cid_work in a new work_struct connected to the
> mm_struct rather than in the task context before returning to
> userspace.
> 
> This work_struct is initialised with the mm and disabled before freeing
> it. Its execution is no longer triggered by scheduler ticks: the queuing
> of the work happens while returning to userspace in
> __rseq_handle_notify_resume, maintaining the checks to avoid running
> more frequently than MM_CID_SCAN_DELAY.
> 
> The main advantage of this change is that the function can be offloaded
> to a different CPU and even preempted by RT tasks.
> 
> Moreover, this new behaviour is more predictable with periodic tasks
> with short runtime, which may rarely run during a scheduler tick.
> Now, the work is always scheduled when the task returns to userspace.
> 
> The work is disabled during mmdrop, since the function cannot sleep in
> all kernel configurations, we cannot wait for possibly running work
> items to terminate. We make sure the mm is valid in case the task is
> terminating by reserving it with mmgrab/mmdrop, returning prematurely if
> we are really the last user before mmgrab.
> This situation is unlikely since we don't schedule the work for exiting
> tasks, but we cannot rule it out.
> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/linux/mm_types.h |  8 ++++++++
>   include/linux/sched.h    |  7 ++++++-
>   kernel/rseq.c            |  1 +
>   kernel/sched/core.c      | 33 ++++++++++++---------------------
>   kernel/sched/sched.h     |  2 --
>   5 files changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0234f14f2aa6b..e748cf51e0c32 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -889,6 +889,10 @@ struct mm_struct {
>   		 * mm nr_cpus_allowed updates.
>   		 */
>   		raw_spinlock_t cpus_allowed_lock;
> +		/*
> +		 * @cid_work: Work item to run the mm_cid scan.
> +		 */
> +		struct work_struct cid_work;
>   #endif
>   #ifdef CONFIG_MMU
>   		atomic_long_t pgtables_bytes;	/* size of all page tables */
> @@ -1185,6 +1189,8 @@ enum mm_cid_state {
>   	MM_CID_LAZY_PUT = (1U << 31),
>   };
>   
> +extern void task_mm_cid_work(struct work_struct *work);
> +
>   static inline bool mm_cid_is_unset(int cid)
>   {
>   	return cid == MM_CID_UNSET;
> @@ -1257,12 +1263,14 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
>   	if (!mm->pcpu_cid)
>   		return -ENOMEM;
>   	mm_init_cid(mm, p);
> +	INIT_WORK(&mm->cid_work, task_mm_cid_work);
>   	return 0;
>   }
>   #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
>   
>   static inline void mm_destroy_cid(struct mm_struct *mm)
>   {
> +	disable_work(&mm->cid_work);
>   	free_percpu(mm->pcpu_cid);
>   	mm->pcpu_cid = NULL;
>   }
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9632e3318e0d6..2fd65f125153d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1397,7 +1397,6 @@ struct task_struct {
>   	int				last_mm_cid;	/* Most recent cid in mm */
>   	int				migrate_from_cpu;
>   	int				mm_cid_active;	/* Whether cid bitmap is active */
> -	struct callback_head		cid_work;
>   #endif
>   
>   	struct tlbflush_unmap_batch	tlb_ubc;
> @@ -2254,4 +2253,10 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
>   #define alloc_tag_restore(_tag, _old)		do {} while (0)
>   #endif
>   
> +#ifdef CONFIG_SCHED_MM_CID
> +extern void task_queue_mm_cid(struct task_struct *curr);
> +#else
> +static inline void task_queue_mm_cid(struct task_struct *curr) { }
> +#endif
> +
>   #endif
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 442aba29bc4cf..f8394ebbb6f4d 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -419,6 +419,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   	}
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
> +	task_queue_mm_cid(t);
>   	return;
>   
>   error:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9aecd914ac691..ee35f9962444b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5663,7 +5663,6 @@ void sched_tick(void)
>   		resched_latency = cpu_resched_latency(rq);
>   	calc_global_load_tick(rq);
>   	sched_core_tick(rq);
> -	task_tick_mm_cid(rq, donor);

I agree that this approach is promising, however I am concerned about
the fact that a task running alone on its runqueue (thus without
preemption) for a long time will never recompact mm_cid, and also
will never update its mm_cid field.

So I am tempted to insert this in the sched_tick to cover that scenario:

      rseq_preempt(current);

This would ensure that the task runs __rseq_handle_notify_resume() at
least each tick.

>   	scx_tick(rq);
>   
>   	rq_unlock(rq, &rf);
> @@ -10530,22 +10529,16 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
>   	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
>   }
>   
> -static void task_mm_cid_work(struct callback_head *work)
> +void task_mm_cid_work(struct work_struct *work)
>   {
>   	unsigned long now = jiffies, old_scan, next_scan;
> -	struct task_struct *t = current;
>   	struct cpumask *cidmask;
> -	struct mm_struct *mm;
> +	struct mm_struct *mm = container_of(work, struct mm_struct, cid_work);
>   	int weight, cpu;
>   
> -	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
> -
> -	work->next = work;	/* Prevent double-add */
> -	if (t->flags & PF_EXITING)
> -		return;
> -	mm = t->mm;
> -	if (!mm)
> +	if (!atomic_read(&mm->mm_count))
>   		return;
> +	mmgrab(mm);

AFAIU this is racy with respect to re-use of mm struct.

I recommend that you move mmgrab() to task_queue_mm_cid() just before
invoking schedule_work. That way you ensure that the mm count never
reaches 0 while there is work in flight (and therefore guarantee that
the mm is not re-used).

Thanks,

Mathieu

>   	old_scan = READ_ONCE(mm->mm_cid_next_scan);
>   	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>   	if (!old_scan) {
> @@ -10558,9 +10551,9 @@ static void task_mm_cid_work(struct callback_head *work)
>   			old_scan = next_scan;
>   	}
>   	if (time_before(now, old_scan))
> -		return;
> +		goto out_drop;
>   	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
> -		return;
> +		goto out_drop;
>   	cidmask = mm_cidmask(mm);
>   	/* Clear cids that were not recently used. */
>   	for_each_possible_cpu(cpu)
> @@ -10572,6 +10565,8 @@ static void task_mm_cid_work(struct callback_head *work)
>   	 */
>   	for_each_possible_cpu(cpu)
>   		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
> +out_drop:
> +	mmdrop(mm);
>   }
>   
>   void init_sched_mm_cid(struct task_struct *t)
> @@ -10584,23 +10579,19 @@ void init_sched_mm_cid(struct task_struct *t)
>   		if (mm_users == 1)
>   			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>   	}
> -	t->cid_work.next = &t->cid_work;	/* Protect against double add */
> -	init_task_work(&t->cid_work, task_mm_cid_work);
>   }
>   
> -void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
> +void task_queue_mm_cid(struct task_struct *curr)
>   {
> -	struct callback_head *work = &curr->cid_work;
> +	struct work_struct *work = &curr->mm->cid_work;
>   	unsigned long now = jiffies;
>   
> -	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
> -	    work->next != work)
> +	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)))
>   		return;
>   	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
>   		return;
>   
> -	/* No page allocation under rq lock */
> -	task_work_add(curr, work, TWA_RESUME);> +	schedule_work(work);
>   }
>   
>   void sched_mm_cid_exit_signals(struct task_struct *t)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c8512a9fb0229..37a2e2328283e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3630,7 +3630,6 @@ extern int use_cid_lock;
>   
>   extern void sched_mm_cid_migrate_from(struct task_struct *t);
>   extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
> -extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
>   extern void init_sched_mm_cid(struct task_struct *t);
>   
>   static inline void __mm_cid_put(struct mm_struct *mm, int cid)
> @@ -3899,7 +3898,6 @@ static inline void switch_mm_cid(struct rq *rq,
>   static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
>   static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
>   static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
> -static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
>   static inline void init_sched_mm_cid(struct task_struct *t) { }
>   #endif /* !CONFIG_SCHED_MM_CID */
>   


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

