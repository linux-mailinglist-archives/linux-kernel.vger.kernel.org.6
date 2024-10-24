Return-Path: <linux-kernel+bounces-379151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAE39ADABD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9C81F22ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AFE16133C;
	Thu, 24 Oct 2024 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="nuSeo19g"
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021113.outbound.protection.outlook.com [40.93.199.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE631EB3D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729742271; cv=fail; b=A/yDfGEhBvZddM03aqDhkTEKEpggcYwzjvSh7tQ8n2I7SbSJBXuNQHG/NzpSKo8/yAhHKD3TnVY97HhFUni211TQtbEVTadD/ToSYVtNCehf7IIWphtEck3NyTPEduWwIFgU7zAlD4HfnNNzVoEUhEYfEcjyS2RtfUxOs6CU9k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729742271; c=relaxed/simple;
	bh=Lnr/fIk7zwSqGZfiCDWIwrKOINvx3dUV5G3UzggN9zw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gmhNYkq9dbW5n6MVK/jFNqo3+6E9w4QOfTmHw38RU68PHs70NXr8e/TWIGvi79AQMOp9MpK+M6IVN1U5eYjYfbPAxp0ctJkv/bdef4lupVwHkS0JBcg4FgJXNc7uXbQg4dYXHTKaNRJltQFtR/ZJHjrRn6M1GuwGJeHgH9J+6fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=nuSeo19g reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.199.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuWld7dNntbnpb5lxliRjAPN3RQrW8ffedVH94flt6Cn15rfqovCauEatp6e73aZgcbR3fEd8hutlr0SdzsYMrjah8WP3kKi/YWNaHq47dh61dbmUF0RWaCFidAOskbg2A6Ba/9UCi7OoWpnPP55mC2zu/zzKifwBIL0xlCvjJ6MV1a2SrsFrmik/xmZO11i7wglBRSwzi1zy8hNJSBk0f2PqTYaK99/mNW68HrDHIutyA7LdaB29REg+3oBSnn/BqR3od+VdBFnSDTpCvyRNKGE8Rt8/ZqH+3wa5cXwfERTjh1gq2ltIqcAyJq4fcGeYzqIeRK7RjKj32wVBHSpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itcuk7X4axARlCcRerIpeVEjjTENWCi2S10VIcUQSpo=;
 b=Qvgq/XHyWcrORYDZQ/iBxQ0hoOXTS6686h909xHTnLnJ4hlwDS+8AXhRcTCBRIxDTILxjshMJnxfBnKt2zyga/zqqdxfLe30FtWJLYJ9jhOaMdptyo65JxoM3aBNYjcwXmEzpDV1vjY35Vx4SNXulrFBjmD4zmCcBqrU7ypxegMa4LIbbIeHP8HJp2daJR4ThyAPj8E0XaXRScxIM/yc5lqaqoABsAt8NMPoF3ZsRP0XlV0RASK2f+ikOXX7jfWZ3ysvMALwF6iBkKO8oH6/2rS9HcBpjl3DONTHXWUH1PNZJ/MJjObXrNwLeyGhm3rpJF0L4ZzVr2JwUxrFIv+kiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itcuk7X4axARlCcRerIpeVEjjTENWCi2S10VIcUQSpo=;
 b=nuSeo19gLqY9C2h+4hVbyjTKKTvUodDV69l0BqyobrZH4HeV7H543jVYb+uAcpql3OIndrlpXueHvAKjmzTVFTf5yv5dTP/cnqrJ/YdlzQzrASyvnaZVOWjuqPndlOnAgREUva1SNTw42ErjAZkehihrADvc1K6QvdbhHqvwDag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BL3PR01MB7177.prod.exchangelabs.com (2603:10b6:208:344::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Thu, 24 Oct 2024 03:57:45 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%6]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 03:57:45 +0000
Message-ID: <3009e608-46ff-42d4-9898-0d7d8107ac06@amperemail.onmicrosoft.com>
Date: Thu, 24 Oct 2024 11:57:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: set "rodata=on" as default
To: Will Deacon <will@kernel.org>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, patches@amperecomputing.com,
 cl@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, adamli@os.amperecomputing.com
References: <20241021053948.5848-1-shijie@os.amperecomputing.com>
 <20241023163507.GC29251@willie-the-truck>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <20241023163507.GC29251@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BL3PR01MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 965f0f67-0bb9-4b2e-9d1e-08dcf3e0043b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUE0S0xLQ0lwdWlNektkV1dsZ2pGbGQ3WWxXZ1RCTnoxTzF1aEgzRnRkZXJk?=
 =?utf-8?B?Tlc4MEVlWGl1bjJPbzRIWThIVUVSR3RLNHQwYVBKQTBJcVo5Y1prYzgrUnBa?=
 =?utf-8?B?WUFBanBpeWRXOEwwVk00M2p1T0F0am4zNzI2YnpWVjN6Y2Y5UE9YZ1lxTjgv?=
 =?utf-8?B?TXY1UFdDYkt4bjc4dkhYN091Z0ljNTBOTExISXRseDZMWTkrY1FnbjE1aVYx?=
 =?utf-8?B?Y1ZxNk9SWWQ2eFMwVUJrZFlLZGNFc2k4RkVKZkhpWU41UkhMcjdGTFhtWFRN?=
 =?utf-8?B?aVRLb0Fyc3ZUUmdYUFFmUFZFTHJBRnlKbHZKM09qcHczS1V2SzNWRDlaQnBh?=
 =?utf-8?B?S01PSW80R2QrZUw3TVNNUlRIOG9PeWdlanIyK1VIc0RHbDNrYkQ0UlNRSkpP?=
 =?utf-8?B?OTR6Y0pJTFp5eEppNitTQVJTUGE5SVJKRjdlRlUxVCs4TXREbkd4UW91eENm?=
 =?utf-8?B?UW9mNG9IWXlRbUhBZTV2MUF3MVdFVmcyTjRGL21DcUlBYkVvbVVxZHNqeXlu?=
 =?utf-8?B?V3pNTDhQZDFPNEVtZUluU1JkNEYzR0Qxb1FKRGJicHpzeGdVdS9MdnMveExs?=
 =?utf-8?B?TVBqMUZRenptejRaMW1JTTVlWHZvUTJVcDlHbUhDZnFCcGE0NStVc0RuUEp5?=
 =?utf-8?B?ZTVjWVkvK2k4RVZNTUJ1NEZ4RGMrWjlXZ1czV2tpS1lzcDAvS0N6bnB2Y21y?=
 =?utf-8?B?V2Q0ZkE2eWJVZWJGV2NNQnpoZnA2RHh2WVR0R3RoNmxCN0VlSldlZ3R3eGJr?=
 =?utf-8?B?TS9DVDRBV0ZxR2h2b2ZoOXpqelBSckhTYlc1SnM1a1d1ZkM5SGVqZXRWYmZE?=
 =?utf-8?B?TllwdWVNS2FDQVYzTysyeGlxWFd4YzBSeGdhTm1pQkFFOC9nQmVrYWFnenBJ?=
 =?utf-8?B?K1NaNXNMZElVR29KYzhLYll0TnFVZGlFWTZPeTRYWWRYT2VqSEhlUUpCbjlQ?=
 =?utf-8?B?cFozMXVJNEdvUE1uVXgwL1M5cXN2Z3ZtN3htb3ZUYmttcVkyZUhRUFhNZ21V?=
 =?utf-8?B?TnFRRHprdUhTdHdWVWVHUS9HZmhsTzhtUmpxbHV3YzROaEMydTFKQXFLQmM2?=
 =?utf-8?B?QnJZRDNlQ2k0VjRDcVM5eTFQUDFEckkyakFZRnR4U0gvb2xxdjNPVGxpL1ZL?=
 =?utf-8?B?UDlYSWYxekkwL1ozb3dudDZXRTNCUHpkNFozMnZaaFUzbHZia293aUhicGdt?=
 =?utf-8?B?Ymo0ck1XczdkNjN0WGNWLzlvVzh0bitObGo3TGNlbHRjZWRrQWtMT1F3R2N5?=
 =?utf-8?B?czRhcll6N1dHWGJkcG12ejQ1SzBrV2V4OUIzUVRhMUcxNE5KbXNaUjIxbmVQ?=
 =?utf-8?B?QzlzZFZkRDdZeU4vM0pEWkx5cUdsNHRwNlVFeDl3RmloOFdXMTh0OG1wTjdH?=
 =?utf-8?B?V3ZPbDZJbUtiWTFieFEra1o3TW5UbUhjVDdzQjI4Tk1lM0hmMjFQM1lmelEx?=
 =?utf-8?B?ejZEdkNOa2ZYV3JMcDFVcXVHNW12MTNmY0Urc0syVWw3U3YrektDSEVHdm1j?=
 =?utf-8?B?OU9VMUZrMnYwRVhPWEdUYllady9QVlBJeVpsd0Uwdnl2QnZCRjRYTjdBQ3BD?=
 =?utf-8?B?L2dmZ0k5UDVDU203YXFsRjRCUUpPbzdCQzkxQUd1cVE0Tm9wOGExVGlQYTZX?=
 =?utf-8?B?ZmF4NHZMdmVBMUhOeklMMFhISmd3ckdxRkpLM2JYZGF4TjV5ZkY5NVFSWEgr?=
 =?utf-8?B?cGhrS1dMSE1aaDhna0JadUU3N05GOVkvUi9iemJrbzlwNkMxTllKcjk0WEs0?=
 =?utf-8?Q?ThgrhjW8lGYhEP8AfkYfvHN9AF8HNhbNQUABIGp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmhzYkhsVFpSTGZmVnhhZTM5WER1WkhZc0k5WERtczBpaWJ3UjhMYjJ0RkZD?=
 =?utf-8?B?YmlXTXBtVTRrSWJsWnpaRkdVZXY5Q05XL3Y2VHZHWitEYXhRc1FqNm5PcWZW?=
 =?utf-8?B?WmxzdURtTkJPemR4a0FwaCs4TFVOMjBTckhSeGtNY2ZXNkFLd0h0UTZJaVNZ?=
 =?utf-8?B?UnZqMEZoY1RGbFdXTjhodEhHa3laYTNpYzNZVUxaQmZTTHBVVjVZWVcwWEkv?=
 =?utf-8?B?NWVib3lpaCtNU2x6RW9HWlIzb1VXZVhUUE92K0lnU3d0VWdPNCtOMUZHR0lp?=
 =?utf-8?B?Q252WDV2NTlwaStLdnFpVVBxR2pNdzJNYWtMbVZlUE92VnVMMFJkeVFYaEZL?=
 =?utf-8?B?dVp4RUpHZmtWNEVTM3lhcHNvUUNWUVdTSGllV1RWMm1meDZhMlY3ai9PRnZy?=
 =?utf-8?B?c21uWmtKcDdaa0lTM1pIeDhWZGNmM2NUSFNkOHdaODc4Rm1NWXczSWU1a1l2?=
 =?utf-8?B?TjBVVUlVLzM3ZEtPek5MTTl0OTI5VjQ4bjZ1eldueklNL0x0NEM3MzU5amw0?=
 =?utf-8?B?SFN0NkNNRmovQ283WUJraWFVdm1PRVBJTlN1NDhyd2oxcGZ2MGFvZDVBNTZ0?=
 =?utf-8?B?UHY0dWZFUkRCUU1nTVVMR1hLeVVKelFXUTZjYzkwOTlTVTNpR2FtMnFZSjVY?=
 =?utf-8?B?bGR1a2xGb1FyV09ZZW5WaSszeE5ES3I5RFdIcE1jOGVVUU44S2UySlFjby9B?=
 =?utf-8?B?aW5jdHBaRVZjYzVEanI5VGRhb09PZVhKVjF1N2hrcHJWM0xtYnR6RnZoZ0ls?=
 =?utf-8?B?SEs2dFQ1eWtzNFFCVVZja0l1bFc5Z2xKUU0xejhreHd5YTVRMm1mSWM4a01r?=
 =?utf-8?B?WUQ4aXgzTHJ2ZVpkYmkyVFpoQWM5NnljMGlGSjlWNDVqdmRuRG9Yelh0bE1Z?=
 =?utf-8?B?dlVPZnV0RXZjWDY0TGpTOWxyWlRZQ2Vta2g1Q0dldW8yQVBydFl5TEZObmFS?=
 =?utf-8?B?R05vNlJjUGpLdHlONmRNYlN1K2kxcm05MVZLUDcwVWUyeW5TaUJNOU5XZjBr?=
 =?utf-8?B?VXJ5NTlST2NFSXFBWC9YYWFXZmVzcDJjSnMzTXVGckFRbVcrTm0yNXI2ejJx?=
 =?utf-8?B?bnV4NkJHYmwzazIxSU0vL09jRWJVZ0ZuSVZOMWJlVm1qVmlad1JmTDZkeXVO?=
 =?utf-8?B?VWw2TVE2cER4M01hUkp4SFlEMUsrd2VRMWM0dmdWT3J4dU1qZi9YcHEyMjgr?=
 =?utf-8?B?MjlEeHJjckpoTzJmZTlLWmlTa2t4YWtseVpLcmtuRkZ2ckRrWVY1eCtYZ0tD?=
 =?utf-8?B?d1RydHY2RWQvY0tTU3BFL2VXd2dub0hDdDUxZzE0cE5rQVlMUUhHTDNmc0Np?=
 =?utf-8?B?QmRaWlEvY3UxYTVHWW0zM2o4OUM5dk9iQVJoS3hEaDJialZrUVduby8zMWxZ?=
 =?utf-8?B?RzMxckNUUXVrSGtzSGNQOUR0VjlzZDlqYzZ4VFlpdytnMXROUTQyMHVrQTZ0?=
 =?utf-8?B?NzFPQUtyOEdMVGJMckNCSjg0YlFXQ2FRdDJWZktjbE5ZQzkyOFJ0Kzhibjd0?=
 =?utf-8?B?ZTFySDByNkZwRFZ2MEptV2lNT201aDNkUmJUci9BNDVFajI2MEhteVJCZ0l1?=
 =?utf-8?B?SXY1MmVuZUZ4TTVMSTl0NFBvR2QrempUYnlManFzUnFHbDRYWnI0VWl3UEYz?=
 =?utf-8?B?VW1pbkJIYWNWbkxSeFdibENtSEtkUU9DUFFRNzFqVFk0OFlxVS8ySTU2NFZl?=
 =?utf-8?B?cVhpRTYzTG1lalF3RnczMktZTHFaMFovRGcxc3VwQ3JibzM3cmc2TndpT0lh?=
 =?utf-8?B?aGJJcWsxeTArV3NDYjEwYU5OM3JoOTlRbnlMTmxtcHlKSm11bmkrbVdSajNs?=
 =?utf-8?B?YlU3VVlWSSt5bmFWbGw2dTVic3FvOEwzZzFOTDhIcGhlSktwT21QWFprcjlv?=
 =?utf-8?B?N2ErdkVjdHRPcTE5R2MrZkhMbGplam04SERmVmZOUTMrZkdIZlVYSjJkWmtQ?=
 =?utf-8?B?UVBWRmcvY3FUUXJ1T05HVmRHMk5uZHlxQkZtMUNzQW5TNzladU5nRlBtTWVu?=
 =?utf-8?B?L2pSaDcyR1VPbm5pVGpVRUNyRjZiN2tVdWMvVUo3TldySUc0K0Jqa2lRd2k4?=
 =?utf-8?B?UnlzZGlSVHVjQkFCR2tjcWRqcHBxblhBUHpkVUJ5b0ZwVjVHVkJXQWZUcVlq?=
 =?utf-8?B?Vm1tWDZwTUJyRUhEUDJRLzZPbWZmL3dkSXI0czhGQmdXM0dkR1NEbXpPampY?=
 =?utf-8?Q?5Tau9fY/Ydw22RFwv9eXYUQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965f0f67-0bb9-4b2e-9d1e-08dcf3e0043b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 03:57:45.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyIUCA6i6covkaC94lXNBxme6nqcOli6T4Kz3v4eLgco/QzxyCARJVEdLNTF8IgCp63ELFRjFOvCvEXz88TonCCLLeGO38aQ53NJgL0BZ7aKwqEMEBWj+7JyZlbfVF0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7177


On 2024/10/24 0:35, Will Deacon wrote:
> The "full" behaviour on arm64 is equivalent to the "on" behaviour on x86
> so the more consistent change to make would be:
>
>    - Make our "on" behaviour be what is currently done by "full"
>    - Remove RODATA_FULL_DEFAULT_ENABLED
>    - Introduce a new option (e.g. "rodata=noalias") which would match the
>      current "on" behaviour
>    - Update (simplify) the documentation
>
> That way, the default behaviour and the "on"/"off" options follow the
> x86 behaviour and expert users can fine-tune the security/performance
> trade-off using the "noalias" option.

Okay. I will do it in the next version.


Thanks

Huang Shijie


