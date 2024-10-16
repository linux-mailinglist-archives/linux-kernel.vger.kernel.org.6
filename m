Return-Path: <linux-kernel+bounces-368467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BDA9A1019
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDB11C20CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F720E02F;
	Wed, 16 Oct 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QEkkgoTN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8E1DA26;
	Wed, 16 Oct 2024 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097546; cv=fail; b=YrqZJYakuvBeew+7S8pcXxJR61rvnVusY5/19HnihEteHpQnPUdg8Nc98H7lU7eayEpmehOgE+qewhZPZ/ir457R92YDnPjfD+fODIQirqx5F68tm/l8DqyNzgsci5CJ7OLqfTDVizxgx8dU7Z4GzwhlBjf0jmfFI0Jy5Mxwcng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097546; c=relaxed/simple;
	bh=dLAkCmU2exHxSCtAuVcNPN0xZoKvgt/vaMCFG7UhqT0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Urdg6yVggvU8MNHLLxW5r1V9+TWggwrHfceYgUCjqAvWkyHZbpU0scGzGgK6hEnyGsOYBYU0RRnCqbFMS1HvQvMV2XPM9WU61u6b8lMwH/3vciuN/QQXP52Ovb9lovlgY5Q0KB1ZD817yJ1a8MxFdK6XwwhwEv/6AW0nwbA85/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QEkkgoTN; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBbeVKmstDL9bfegjmbVHG6LgLF5VpJgCu3NknamdEhX/LResK6O+ilyWCxArqJrzrN21piXmAkYUSpqZyudg+ZP/0MG1PBfltmFglcj1XUtYmMHj7rsREp5sYvEZA7scmv/iRep8tpXEahAFxqSgJc1Kq98rRLXTzUx/E/XQEuEId+HYL4mzLFAUyKYHzDqGeHGzSD2aVi3y04lTyUPG5y5XmXE0k6S2xnKPgs6yS1f8suw2k1MwAhZWwqBtbL2ZsWrenenixv/oWjqoPTjpm524zfVl9P6fQEg7KQ+KsbauU2L2aKXNbfece0GlhreCUgNXFy10tc+9NNAMYAnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R18CzfM1MZdXj6AjXsNi59XlA1FV5Za8iOpytGZWeu0=;
 b=GIeyLMUyIG18LN97E7reYm0igq9ZyMslYzv9vC9TQwbzKtxOYf3rRfsn/KTLGJ9P2Ti1Q2Pb2KwVcAAeLEVnOGcYHcZCmMNW1ATqIQvIV5SXLAOZ/z1X6pfPE+Zds7b+Jg5LnJS8aCjvxO8Gr5nOjSGLlHdwXGN9nM8DhUakwhnicD+yiRsF2D2WWX0w8z8VVrQIkQcIu3qDgslrQPPqqrh3jXnnwrdkV7IxBIyt7nsPLdWNBGfM8yc86uui1k14Uz3RO1KAVZjYk62UC/mERvVcJFyMjhiDpVu2Yb4uidwKtN+/1m7mikVPTXvjczWjMMdacy+OhlG7QBAcCI93ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R18CzfM1MZdXj6AjXsNi59XlA1FV5Za8iOpytGZWeu0=;
 b=QEkkgoTNXz/dL7VwryLTQiTyDDjF8rp34Gbd33JCQ6rsxROBtoWQotQk3R+UcRWVN4jQKw8orcRt/HNDBpINuCZD4upVdbg0c2U0b7Op5KZyINrrplIH718Pi/MNbtTaa+WXh0uk69jrqWqdishXRPwTegCVKKscL58PiQLwC9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 16:52:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.029; Wed, 16 Oct 2024
 16:52:19 +0000
Message-ID: <abbc7a82-3a52-45b3-bdb0-3fe90f63b2cd@amd.com>
Date: Wed, 16 Oct 2024 11:52:15 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 5/7] x86/resctrl: Add interface to enable/disable SDCIAE
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <e43947374dd9124ef5a6c677d0ec3ab715b6a7e7.1723824984.git.babu.moger@amd.com>
 <cd0585f6-1d90-4ef1-9a10-7db50cb879ea@intel.com>
 <ecdffce0-796b-4ebe-8999-73f2be1e703b@amd.com>
 <ec170d40-7390-4cc7-9128-d200df7405ee@intel.com>
 <a6a1dde1-5b4c-4c3e-a9e7-b2f2b327894e@amd.com>
 <9d52bac8-5e4c-4bd2-b01d-c78d4b7274d6@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9d52bac8-5e4c-4bd2-b01d-c78d4b7274d6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0184.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 5adf5680-ed5c-4c0c-bd26-08dcee02e5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0lsOHMwcml1QXJkT291WHRWWDYvWlBuRlZGTXJJUTQ1eW42QjZJM0tSakRa?=
 =?utf-8?B?MnNvNHZCNjU1Q0RmREFhY0FVTGo5dVEvUE8yVVVNOG1BY3c3T3dOQm0wMHdw?=
 =?utf-8?B?ek5ZM29iS2lFSG41djVoQzBTS090OENTblVoV1lGa0pXejJkTTJodnhiN2JJ?=
 =?utf-8?B?VEowM2cyYUxzOVluaEtwYzczcm9ONnpzblo3QW5MdHlRU0twRWg2UU1ZNU9l?=
 =?utf-8?B?ejJub3NqOFF6R0swczNidDRpNm5ieDUrNjJJQnVlZU5jSmoxeWU2YTdZN0hR?=
 =?utf-8?B?MzZvTGZiZzdTOUoxKzgzSjU4NE84WVBhUGdzaFJVdU16RlRmVE43L2ZtOHYx?=
 =?utf-8?B?WGRtRWZ2RDRxNkdOeEVyTnMzNGlUeExQQkg1TmF3WlRuTnY3VXpiT1JpZnMz?=
 =?utf-8?B?Lyt0ZkRSU1Uxam13NXBhZktCKytXNURuaGk3eUpHU2tzc0RqWmxOcU9GL1k5?=
 =?utf-8?B?eGdCZGhtYnRkNURjekNpYWc4dk9YYmF4YmhoMnB6OXBiNXVIZUNJY1E4bFlP?=
 =?utf-8?B?MW5zZzFDRXQrbEJ6VGY3SnhpdysyTVlPUzdRb1Jsc2NkZHJVeTAwZFh2a0hC?=
 =?utf-8?B?VFYrSnIrc2U1SWozYytjNlkxUnhTRzdiVGFDNlliMXBYTmh0V0liWitzR1NW?=
 =?utf-8?B?WHhOeVpGbDFTSDR6dHlsdUhYSSsxWHdBczV0cEpXcHROVlV5bThZaFl2b0wz?=
 =?utf-8?B?RUN0d1RXVzVUc1h6V05xZHF0M05ZMW1qb0d5TXYxQWx6UUJhY1RUeTN6SEUw?=
 =?utf-8?B?SU80eURFSElBTGxZL0JhVG54M2VseVp5bFdLdUwveDM3RlBVYXZiY0Fldy83?=
 =?utf-8?B?VDBsN09YZVRqWW5RTWdnU2wwczBiaXB4dzIvbnFOV3hkWFRjcHFNd1ZxNEVh?=
 =?utf-8?B?dnltemFrREl6ajkzbld2VjQzTS9jbVZRZXljWDhoamgyRm4wbWRqeEVBT0dO?=
 =?utf-8?B?cU5wTzZPTG9oQUFZaTdZb0xUanZNTmlGaldQMS9VRTQ0VUJkWE1LS25zdStY?=
 =?utf-8?B?Wldnc2hJVE9yaWY2NCtiVmJHOEsyaW1LdG1ZNnhLaDYyWFdzeHFMNFNZVnMy?=
 =?utf-8?B?bTllVlE3Qnp4VmM2VlU2ZFhBZnhCTWVYemdjem9aRC9wZDhCRmJwT3hYNmV1?=
 =?utf-8?B?Ukl2c25vem15S2FJWWZXVG5ZUXNtV0cvR3FUVGdXeEVKRDRQeFk0a0dTWE8w?=
 =?utf-8?B?dkJ1OHhTYWFzbFNQamY4TDBUTndMSXVVR0VYL3JmK1gyaUM1NUgvTUVKbWRI?=
 =?utf-8?B?OC9scmhLVmNEdzFwdlBRU05UWnVSa0tBalUycTdXZlpyb2R1aFRzcUM4Zkhp?=
 =?utf-8?B?Zk1sMDJ5VVlBa2c2K2dvQVlpUE5rVXNNMHZiVWZodEw0VVJVWldOMmFtZzRv?=
 =?utf-8?B?SGNGNU5xMnhWcUViRGlzK2J6SWhMMXZvV1FmNFF3VXlkYTFFc3o1SE9QR2Rr?=
 =?utf-8?B?dVI0M2pPOXlBc0Qvd3pxaXZ4RzVqdjBsU20rRm1VRUoyUVBDSWFLSkxoNmRa?=
 =?utf-8?B?c29nNVUvSUdHQmx1VlJHdmZUYjBGTXVERUNiTVVMYU5GMUVhZ0JoMm9TekR0?=
 =?utf-8?B?SFlBWUljM2x2ZTBRTFpyYmFrUHhjUk5kU0ZFVUdPRjI5TE9yaXBINDJaRXlG?=
 =?utf-8?B?T1o1VjJ3T3N3Wkc0alRaQXdKcnBCVFdSRURIekxIZmlhc1lQQkx2SmlUdE5x?=
 =?utf-8?B?ZlNjRUh4MFczYVpXQmZaOTQ0eEVxTW9PMDRGM0gwQlBTSy9TRk5iazZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elNTcUE2OU5BY0ErdTdjenc1bk1HZXo5L25QMkZLeXBPNHhCcWV4Wjl1SDlK?=
 =?utf-8?B?VDUybWlXWTRra0J0ZFMrekhQSGhDZWdlNXpWbnVHU3Frc0JycVVPdytWNG5r?=
 =?utf-8?B?YjhYME1qQVFLd3hrM2R1c0lDUTY4R1hST1AxUVlJRjhpdUZOK092b1d5SkR3?=
 =?utf-8?B?Z0svemliT2ZRTmkrOEtScGMyTTlHb1JQNkFqTlFaUUtTemF0bXliMlRLcEhC?=
 =?utf-8?B?bG90UmFRSXA0T3NXUlRhWjZCbDZYYUFmWThZMWpPcTBWNWoyVUxjUGxMeEFS?=
 =?utf-8?B?bXJ4TjVIZ1hGQ1g5WVc1NENMRjZFdS8xQW9nOVVZd3RGTE1MbzZHeFF5NGNS?=
 =?utf-8?B?aFdpWnhuS2dqd3hNL1lLUFExYmhHUm85REJjNytzSGV1eUtrUDFNcytQR1pN?=
 =?utf-8?B?MW5lK1VzM3JGYkE0MEUvOUZYUkJUeG9PQ3hlOEgxUFFLeDI4bUc2R25qWjlo?=
 =?utf-8?B?MUVwNzdqai9PSkR4ZEdHSjgvZGhhalRBamlUOFNLeEdLc2JSMmxwb01PT3BG?=
 =?utf-8?B?dEprRWpZeWoxMUNwVEtHMmtHL1lwVDVET1RiM3VvcDM5K3hDVHZUYktvTGxp?=
 =?utf-8?B?VzlrOUNRWllHRlVPdDExYWhHS3l5T3hHSXBpdktROXhmWmZrSlQyZ1NzaG9q?=
 =?utf-8?B?dGN6ME8xcGU4WUlBejlJN3VNRDR6K09zbVNaRnl5QjV5RWpmVGRyNVcvWHRI?=
 =?utf-8?B?WmpwWm1rRm1Hd2tNa05JVDJnU3I0Sit2WnlkaG13MHJyVUhML3NvRC9uQzNo?=
 =?utf-8?B?QVM4Vmo4MFJ6OEJ1bVlkNlZ6bUZqbTdLWmhQbEZCb3BzVC9vZ0pVazEzRXBO?=
 =?utf-8?B?VTh2TVJnZ0NWS2lWOU1NMlVUU1pUaFEwcWo4WnpLbVJFMmZ1cE5BZmsyOGZ1?=
 =?utf-8?B?d0ltOU1EcHpJbXI1aGdVOUxkQUY5L0FnVlAvK2JGaTl5QjNYVUM3SG9mdGgy?=
 =?utf-8?B?UFdkaDlNaGsrajJHNzdhd2Q0WVVESVpnNi96cXpOWHAzb3ZDUWVhcDlFcEN5?=
 =?utf-8?B?bEJlUGJ0ZHR3U3lqL0VDaEtMZ1A4Q0pFcUNyRlhTRm9BbEdhdXFOdWZPaFMv?=
 =?utf-8?B?MmZucWZRbGlmZWZyZkdxNVB1N0pjdGJPM0FCd3dEQzUvTnc2Mi9tK3hmQXI5?=
 =?utf-8?B?a0ZGdWRsQVpMTFZQemhrSkQvQkhhWlZLNC9STS82VmliRUNVV1BjeUQwcVNu?=
 =?utf-8?B?UmNMRWdNMi9sRkoxS0tqVWZWdHI5U1p6L1lCMUNvK05FcWxOS1FhUjlqaGZE?=
 =?utf-8?B?RjJTTklROHhKTVB6RVFEKzYrT0JhOEp0M2NZQ1E0bG5PdStnT2ZKTHUxZlVi?=
 =?utf-8?B?WDR2ZFB1L2QrYjZpcDdaM3Z1RlZIZzNoQXJhRnRGbXZjY0RTSnQ2M0VwRFVO?=
 =?utf-8?B?UEJIT2VvNjNlYXEza2ZvT2RXaVB3RnhadXRSTHUxL3F1bmVObzNpSVpyVHBa?=
 =?utf-8?B?MVZJTUw2b2tsNi9FV1JzaGI5a0hjenlnMDdSYnFwWUQzdzJGYVFWUHdRR0pa?=
 =?utf-8?B?aVlvbklYWXR5b1Z5Ymk0OXNnRDhub2tEUWorY3AxT1kwTTVyd2V4QmR0YmRt?=
 =?utf-8?B?NHQ4enBhRHdSb0psWXAyVC9YSTg0bk1XcVBUejNSU1luT01zdEcrYlZFQUZu?=
 =?utf-8?B?YVpLMmZPT2xjTEhJMHRKVmdhSGlBWlZEdlpRRGx2WTJzdEQyN1gyQnBuZCt2?=
 =?utf-8?B?aFRyUE91ZGhwdDhOTjZQZkU4VkIydkRWbnlGdE9JbC9pSVJFOERQM2lUellP?=
 =?utf-8?B?amhUWFdJVUNiMXhPblp6Z3hXRUdLOE1DVzBvczJvdE5IOFJvZHZkayt6MStr?=
 =?utf-8?B?UXcwemZHRlE5Q2h4OFlPN2I2bWxRbzY3Tlo0Q3RselYzWWpwalROQS9QalJC?=
 =?utf-8?B?RkhJdE1PVDM2aVFISnQzcURrMktHaVNUbk4rUHFseTVSeWgwTkYxVW02QzhZ?=
 =?utf-8?B?SHNCbzdIeTVuSTN5M3VtZ0FOdHBiWXVKbjlyZ2dPVXF3eEZyVStBL205bzlT?=
 =?utf-8?B?dXg4NGRtQWQzL0VoQkdIdGtkalI3ZTRrVkZab01OZmpseHpsL3lyOEdjck9H?=
 =?utf-8?B?MXBrYlc1QUladG1jalI3ZFJmekF1bkV2MExScXptdENCaXBDNVhHdnRTYytj?=
 =?utf-8?Q?H9J4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adf5680-ed5c-4c0c-bd26-08dcee02e5a5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:52:19.2968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KdqCnsnL5n0rqdFfJOnWsY3QeTBRSPfS3lg/B1neyKe0p8uM+YsZtTQP3rcZNpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539

Hi Reinette,

On 10/16/24 10:53, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/15/24 12:25 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> Noticed I didn't respond to this comment.
>>
>> On 9/19/24 10:35, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/18/24 1:10 PM, Moger, Babu wrote:
>>>> On 9/13/24 15:51, Reinette Chatre wrote:
>>>>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>>
>>> ...
>>>
>>>>>> +        if (enable) {
>>>>>> +            ret = closid_alloc_sdciae(r);
>>>>>> +            if (ret < 0) {
>>>>>> +                rdt_last_cmd_puts("SDCIAE CLOSID is not available\n");
>>>>>> +                goto out_sdciae;
>>>>>> +            }
>>>>>> +        } else {
>>>>>> +            sdciae_closid = get_sdciae_closid(r);
>>>>>> +            closid_free(sdciae_closid);
>>>>>> +        }
>>>>>
>>>>>
>>>>>> +
>>>>>> +        ret = resctrl_arch_set_sdciae_enabled(RDT_RESOURCE_L3, enable);
>>>>>
>>>>> I assume that once SDCIAE is enabled the I/O traffic will start flowing to
>>>>> whatever
>>>>> was the last CBM of the max CLOSID? Is this intended or should there be
>>>>> some default
>>>>> CBM that this feature should start with?
>>>>
>>>> It will start with whatever the last CBM for max CLOSID.
>>>
>>> This seems arbitrary based on whatever allocation the previous resource group
>>> using the CLOSID has. When a new resource group is created resctrl ensures
>>> that it is created with all usable allocations, see rdtgroup_init_cat().
>>
>> Checked again with with the team here. When SDCIAE is enabled, it uses the
>> value in L3QosAllocMask15 (value in L3_MASK_15 MSR).  Enabling SDCIAE does
>> not change the value of L3QosAllocMask15.
> 
> I see the issue as similar to how resource group allocations are managed.
> Just like resctrl ensures that when a new resource group is created, it is done
> with maximum allocations that the resource group may use ... not the allocations
> left over from the previous resource group that used those MSRs.
> 
> I understand that the hardware uses L3QosAllocMask15 and does not change
> L3QosAllocMask15 when SDCIAE is enabled, but resctrl is in a position to initialize
> those registers at the time when SDCIAE is initialized to create a sane default
> allocation, not an allocation of whatever happened to be in MSR at that time.

Yes. We can do that. Will add in next revision.

> 
>>> Letting cache injection start with whatever allocation remnant programmed
>>> in a register does not seem ideal. What if, for example, after that resource
>>> group was removed, a new exclusive resource group was created that overlaps
>>> with that allocation? 
>>
>> In that case. it will share the bit mask with the exclusive group. We may
>> need to add a text about it.
> 
> No. This can be avoided entirely when resctrl initializes the MSR to a sane
> default, no?

Sure. We can avoid it.

-- 
Thanks
Babu Moger

