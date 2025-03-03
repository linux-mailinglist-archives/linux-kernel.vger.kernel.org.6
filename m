Return-Path: <linux-kernel+bounces-542416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4D8A4C9C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A843B92EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6222C325;
	Mon,  3 Mar 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Il2X9PVD"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023119.outbound.protection.outlook.com [40.107.201.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E8214A71
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021652; cv=fail; b=h8fdhQa/+y4ExGzUuWccovXfAeTOkSuEv2jlPcfH/aduCu5f4mBTB14xwy5JQubicCt3MxOo4C0J6uMm6MMFuk4KSJf4g32hDcw2GlL7veKzN9ZloKaXRQ8aUxO+sDWBgo/mlXv+rGizHbCli/A7txRUAemjJaYsiGKxbM0Jysg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021652; c=relaxed/simple;
	bh=mKSnpj1OGp1wWt1LM4F4RKaxzepGSd3WneG27wBgpxU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DVviI17SOVnVhCiur3ZHekQbAtGgcutRHQM/pL2UxRoQUqp7cFSAufD8MNzaCQUnRt49g3tDrQjsguhCH/pqcgmF8hDLZ6UsK32jc+5nmaPpRmZuUNsU8/yUGPx21bG4io0UGHtN95jc1I7KR/hcbhRiV56b+PoLpVMRCebG5Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Il2X9PVD; arc=fail smtp.client-ip=40.107.201.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfvJQ+ul1+M9HKg+tBwJZ2cBW8NyV4d3W+6D4Fb25wHtRo8lp0E6jjNdAUOIRttsyBgSO+Vs8MDnyBA8j503Zl0mjZLlzl9Ywaq+CQOWtVj8P+lYhzpyT+26fUxL3yqrNYkQ0PxkjeK2tL/wYZX5jt0TtBar5czuS0Uvk1sALhpsfPK2Jfe1hlkRANjbY1aAEfr/7TWIO+QgLynvhnKeVJZGD3TE6WroSkQRY56Mf7C8AUUIhgMmSmZes/LiAJ6WEt3XqDAlnjPRYXTDmoy4FGHikzUEIfzb0HyhQAYYZTyDkAF+196b1CB8Q3hD+Ox9WnFr1p7DrbnxqYrwBf0O+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWFUEKRq0UCbK8vUCDwUAFeRtRvG5PRpuQ43W/KHMmE=;
 b=ktjXXkMWJbkl38YxkH3XgDHIzdJxEQLGu78xeLsnqLp4738SBua+qWUfAADCNqEiqJ4CbSWC11As26WTYIpjjspDt/eHXLTi1GCgqR0Plz/DFo8WOAZ9uDyZ9fLy0ugpqoExxPlD8UDuJVzuzF/ew36QSTdr83ezBEvzhanWYB9ylsYlRKCLvLhLrRn/TJdR0SlcmT1jaPxEQ3OtXHxSba4xof3vRMwiiZi+VjQYDWgou1g8K+X2o4KOBtVfaDMfvnnigOHaDFS0hw07tj1fvqAbu8/jQF2BvMSCrs54yOYaQ6rxEqdrWkUOiuhINVYJgTpGJtwsqTGpDmTOjUf1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWFUEKRq0UCbK8vUCDwUAFeRtRvG5PRpuQ43W/KHMmE=;
 b=Il2X9PVDBl47XllaM4b0OGQwrkQvYZbOLC06kPMj3EV//63G724V8Z+flrIxSjLzRb8rQ6Cr0i8mmgVCYd3vu+nbm3i0b568+b7yEYimghCgG+X+9/jT6yNh52W6hVIief0zen379vKNDzHzXIxX5qFeSQdZl473fuhJ2YToGYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8501.prod.exchangelabs.com (2603:10b6:806:39e::18) by
 IA0PR01MB8278.prod.exchangelabs.com (2603:10b6:208:488::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Mon, 3 Mar 2025 17:07:26 +0000
Received: from SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d]) by SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d%3]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:07:26 +0000
Message-ID: <7869d30c-283f-4015-98ae-1bfc7d1efbc0@os.amperecomputing.com>
Date: Mon, 3 Mar 2025 12:07:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] firmware: smccc: Support optional Arm SMC SOC_ID name
To: Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20241114030452.10149-1-paul@os.amperecomputing.com>
 <20250219005932.3466-1-paul@os.amperecomputing.com>
 <Z8W6HXZy46K7ebWe@J2N7QTR9R3.cambridge.arm.com> <Z8XAiMSoaOmR5JxY@bogus>
Content-Language: en-US
From: Paul Benoit <paul@os.amperecomputing.com>
In-Reply-To: <Z8XAiMSoaOmR5JxY@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:805:66::41) To SA3PR01MB8501.prod.exchangelabs.com
 (2603:10b6:806:39e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8501:EE_|IA0PR01MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b81a192-54ae-46a0-c9db-08dd5a75df3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzdGVjhhaDhpQW9FanBlQWZveDF2SHQrQ0NuUDg0NWNqQnY2TjZhV2JhTW85?=
 =?utf-8?B?alp1TG5LU29YZnJqdkhKTGFwSFBvYlg5bUpBWlV1T1V6b28yNFRMQWtHa3Q2?=
 =?utf-8?B?T05IQWhIa2ozMXdaenFKYmN5d1FGUzN0ZzlURHJDQkFrNi9JWTdLclFDQ01q?=
 =?utf-8?B?N2J3OHBqVlVORjhrMlovQjBoUGsxejVWQ2VvRmJ3OEh1SDdzZjlET1d0bStn?=
 =?utf-8?B?TDRQejU5UVdwaDlBWUI0NFdIdUpFRWw3SjNoVHlBNWFyODhZWC9pTEtiZ0FB?=
 =?utf-8?B?Z0d6Z3NIbXFKNXVCRVozcDdqNFJBdlRqTUg5UFpKSVFuT1ZYNkhmRk90Yjdz?=
 =?utf-8?B?Q3JnNXE2N3BWY0ZYTFljY1U1OXowbzZ1U2JmUC9zZ1Z6YmU2YklZaVhnNnlT?=
 =?utf-8?B?VXhCR1RYVm9KRGIrT3BBWnRrYm1DVEhpSVh4eW9acXdzR1F5RVBaMDNzUUpu?=
 =?utf-8?B?WVcrMS9yS2VqSUhNZDNFb0tZMG5iZ1JydklqRlAyMXZDdUx1QU1PMk9tbWZ2?=
 =?utf-8?B?bUhpbzFiOWgvRFNtYndxdVo3SjBpREcvdzJiOHVhRkEvUlBWbTdFUGJNRnU4?=
 =?utf-8?B?V3BCdzVOdGhlQ1d6QnUrcjlyWDlxV1RvQmgyZUZSTWZzVkV4S1JpSGo1U3N6?=
 =?utf-8?B?MWlNYlRmL1BQRksrVTJLRGM1c1BnNjFieGQ3WjB5Z2ZvdWFKRzU0eW1TaHR6?=
 =?utf-8?B?eHc0dGNVWUU4WExrSVROeWJBM1lwbGJ6UnU1aDllQUg5NDJlRnNoMUR1ckhM?=
 =?utf-8?B?RnBOTVAydFJnZUludXFKR2pqR3RwWUVRcDZrUVMrU2poNWpCQ2gvdytnTDMz?=
 =?utf-8?B?aUlma2o5YW5HZkxzOW9nVFcvRW9IRWZKcW9YVy9jR3VVNjIrYWJhbGVaTHYr?=
 =?utf-8?B?bG1nSUhWd1hFRFEySWw0Z0VRZ2xyeUoxODVaWVcraWY1ZDRqcTY1SExwdGx6?=
 =?utf-8?B?a0RsMWE1SFlOWEtqOFMycXN4ZEhWWTBuazI5bkpYN0gwbzVpK3JpMjhNQkk4?=
 =?utf-8?B?Y2tBaFgwNk0zRHpNVTZrUnNBUVhlY0FvMVcxYWNtTUdhOGkxZm5RZzFNejQ5?=
 =?utf-8?B?c3FpUzZqaFdJOWtlNmVzazRySFlaVVRXMTFOTmFwV1dJSjYzSEFHSTR3K3Q4?=
 =?utf-8?B?UGlsdHI1Unp4L2FyZXh2WG51eTIrQUlZU05PZW1CN0ZrWGVka2FJcXVtT0FB?=
 =?utf-8?B?SUt0TDJlWkhNSXlsbkk1WklYWjRnb1MvSmIrVzJ5ZU5uNUE2L1YxOW8zY29j?=
 =?utf-8?B?KzdJYXRibkk3YzNlU0VVU1BSbktWakpBbGg2ZFdpSG9Pc1d0UC9PeUdnNHhj?=
 =?utf-8?B?UlFnc3hLSnJIVjRabWg4OHBtTzYzSm1jSWY4OVptOW4rNnNPY3dNSDdRNHMy?=
 =?utf-8?B?ekZjZmdjT1JFZmRSMU5QNG92TnMzZmpVbXFRNXd3cGFQUmI3cXdRSnBnd0Vh?=
 =?utf-8?B?bFJNc090bXQ5K0ROSGZvQUM0RVFHK0xTWWpoODQvSGlBS0RkTWY2S0hIZmVj?=
 =?utf-8?B?VHRPdmFMQThQM1BLZlZZSDVyZUdlWXBpNmY3ZG5HTmdpbUExLzFxNFkwTDIr?=
 =?utf-8?B?SXJTSU5UQ2s5ckRKdFZuOW9DVExGMGNVK0NRNytsWCtFNXAwSlFINkNHVVg0?=
 =?utf-8?B?UWhLREg0T091UkZpL0JEeldNVjdrNVBXLy9XNG5xbVV5aTg0Y0FvbTJpZHNj?=
 =?utf-8?B?UTEySkNKRHdaUFVHM0F2ekw3cDFRcUZncXNWMVZZa28zV1ZSZkc5R3l1TWhI?=
 =?utf-8?B?SGFFQnpIU0dDSXgweXNzbkVlNFN4TkVSTEc1dnd4QmxSMUlmbi9ldy9xREdM?=
 =?utf-8?B?cExmcUdVeTRQVzI2Mk84SERpdUZZR0JqSDdlWXNUcFMxWXhPc0VCaUJUNkMz?=
 =?utf-8?B?WjZraDRLSHZWbWJvempUYnRYNmhxNGFESkYrSHU4VnpiWmtvZzZmbWpWaUNi?=
 =?utf-8?Q?lOUxIcKB+im4KlFwELhYDGCGus8V9+qQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8501.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTk1cm9sSnFXUUozaEFENzZwNElwNGRwOVcyUkwvaEM3RWp0bzB1K01EaFEz?=
 =?utf-8?B?OG1yZzd6NTV3ellQTm1RczdvNVljRy9xM3RWbGs3VXphWFN2V1drbjRWZWR6?=
 =?utf-8?B?WEVTM1ZxY2k2eGNmWHR6YXc3eEVUS3VjU0I0bDBCalY2Q0xKWkVXaVFUdnRZ?=
 =?utf-8?B?b2UvVmZYNllFdW5XTnZISitVMUsrS2ZOTVBpaWwzS1VEZHdGUTVmRTJwSmdM?=
 =?utf-8?B?MWhtNGZFdXNaUHc2VHBoRTg0OVFJK3lnZ3lhS1YwdFZBdndKYWxSckZTTGxO?=
 =?utf-8?B?Wks5RFo2aE9LVHdZM0VCeXU2MXVYWWEyQ1AyeW92WTY3ZVlHQnhKWXk4QlQy?=
 =?utf-8?B?d1hBUWkyc0ViNVZHNXg3SUhxdXN4NjdPdFNBdkNVTXIzZWRKcm5rYlNjaUxU?=
 =?utf-8?B?RU00Q1V2aGN0UVdhMzdNekg3SGxqdllWQlF5VzVuVnlQeXBadWdFMU1oZ1ln?=
 =?utf-8?B?clhoYUQrTFNlMHNOT0VsclZJYkNSWnE5ZkFXdm9Rem5GL2VrS1Y3dHh3VTd4?=
 =?utf-8?B?b0JXK0I4dmZieGNDMDdTT0ZlMVB4NFFlbEFnZDFIcENhcFVCYzUrQTZuOWda?=
 =?utf-8?B?SUthd3lYL3QyVHlqbDZYUnpmMFFQK2hVc1BTNlF4TTFQOFhkZWxRcEpRTVVz?=
 =?utf-8?B?RWFnbTR6ZDMxYWNFZlRuRnJuc2M1NHVSMnVRZlVQZXJLUjdnS3RoUU11SWFU?=
 =?utf-8?B?VFI4eEVSQ1NUUzFOWjlxNEZ3dHYyZmVqeHRKKzR5K2FFRWVCNmk2Y0kwbFJ0?=
 =?utf-8?B?RkJuaTdNNldtZW1kY2EzeDczeFBWcUpPWDdrWEM2SHZVM3owbnZQcFNBRndB?=
 =?utf-8?B?TXU4ZUhNMW9OaWNuU2JId0ZPT2xEbXA1Sk91YUh4RVhWYkNVNHpIMUtrZ2tI?=
 =?utf-8?B?NHhuTEgycko2UnFRTUxGR1p3UjBWNHFMcmJOUmhIT2Y2d0RubFNFTHFmZUl5?=
 =?utf-8?B?UktyTS90eENrbSs4Z1p6Sk9HM0M4dFBPaTJTQTJ4M2lKQWxnSUY1c25wWEw0?=
 =?utf-8?B?ZnNJaFZjN1kxMWFtd1ZwSGUwS0ZITXlkcUtzTnhsQVRjSnBBdnZzY1FuK1Q5?=
 =?utf-8?B?UUlTMUpBOUdndUJ4aDJuYnBWQ1p5ZUplTitFcUZpa0g0S0FsVzJkTkNtRGFX?=
 =?utf-8?B?SEc4dmdidTltNHdrakMxajlMMHRCNWNZOEFqVzRyZHJsKzdiY3gyWWZyVy93?=
 =?utf-8?B?alNaY2VQTlZON3lWaW9LY2lBUTcySWZmd0oyY2pmczBrYy82Y09VTW5iR3Jh?=
 =?utf-8?B?RXg1c1pXNnVuUFM5aU1DSzlialpvZXlyMFp2YnE5bGt0dW9aTnJUTmg1SGMx?=
 =?utf-8?B?Mnl2Tk9TQVE2V3NNWEZLWm9sNnRhL3RIbHc3aC9jZGtsY2VEc1NDUlpOdURw?=
 =?utf-8?B?UXZIdGdOV3owMVgyWHluRXdkaGhQV1dxSk0xcGRqcEYwQkRQM0RKQWo0WEtH?=
 =?utf-8?B?MGk1dGRqSWltYlczK216Wnp1OWxwQjluK3MzQjVERHpMM25wamRqcUxSdjJE?=
 =?utf-8?B?Wk40NDVucW9aZ1VlQU5wZjlTQmgybHBFb0Nscm80NXJiK2hsaTArUDdQTmRC?=
 =?utf-8?B?dnpWTUtxNnAwZm9mOFZoeS8zQThHY1ZacVVHRTh0ZFNVaStPaTJNWjhWOHhr?=
 =?utf-8?B?cHdWa21xU1IvUHhBaGZaRUJCZ3BtTmlIR1FaTG95dmJRYW1CbnBpQi9MUCtq?=
 =?utf-8?B?ZWhsV0RiMzVxR3hzY1BmNUZEeTh0MWNLdUYycnk2V09vTUt0WDNWVVFuNVBn?=
 =?utf-8?B?QWZLWWdKRHlNZXdjVFErYmoycGwzY3M1N0p5VGN0SXE2b2FUSzd1QWI3ZS9Q?=
 =?utf-8?B?NVMwVlc5THQ2Z1JMTFo2TVQ4aXV3aGJlUnRoMTFacERZeFZ0cTBURExYRnJu?=
 =?utf-8?B?bDV6SEorcVdSQ0JyN3BXTlIrb3R2M2RrcHpOYUg1TERHWllYRjh3Q2N2dk1Y?=
 =?utf-8?B?cTZWQlAxd2swc2FNU2xTL1FHc1pXMXpFamt5QnNycjJsa1JDaDV5SnZYN0lV?=
 =?utf-8?B?Y3FiR1NzZnNLMm04S0svV3RvanRTb3gzVGFtNHVEZnpLTEQ0dU1KL2pDQzBU?=
 =?utf-8?B?MmFORE1SOXNUczVTSVZYUzZPeTRWcm5lYzdiaFlLTEEvRVlsNUpwMUx2OEpR?=
 =?utf-8?B?M1FDUjA4K3RwbkNINWVKT0c5VCtmQzBLQVRZVnJoTUxFWTZmR1J1dnVNVnZT?=
 =?utf-8?Q?lr7XOx6Z7r9UQDbC66x7QQ8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b81a192-54ae-46a0-c9db-08dd5a75df3e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8501.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:07:26.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69+JUfvnOCxoEohzndQcq2G3UDddiB3DMYqxn0ulu4FfHRAQf7VlZ9yyJc/Uvr6uI1aQRQGCorS8ew2safit5/nMk1rTbAwQjLfUW6L5qj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8278

Thank you Sudeep and Mark.

On 3/3/2025 9:45 AM, Sudeep Holla wrote:
> On Mon, Mar 03, 2025 at 02:18:05PM +0000, Mark Rutland wrote:
>> Hi Paul,
>>
>> This looks generally good with a couple of minor nits.
>>
>> On Tue, Feb 18, 2025 at 04:59:32PM -0800, Paul Benoit wrote:
>>> Issue Number 1.6 of the Arm SMC Calling Convention introduces an optional
>>> SOC_ID name string.  If implemented, point the 'machine' field of the SoC
>>> Device Attributes at this string so that it will appear under
>>> /sys/bus/soc/devices/soc0/machine.
>>>
>>> On Arm SMC compliant SoCs, this will allow things like 'lscpu' to
>>> eventually get a SoC provider model name from there rather than each
>>> tool/utility needing to get a possibly inconsistent, obsolete, or incorrect
>>> model/machine name from its own hardcoded model/machine name table.
>>>
>>> Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> ---
> 
> [...]
> 
>>> +static char __init *smccc_soc_name_init(void)
>>> +{
>>> +	struct arm_smccc_1_2_regs args;
>>> +	struct arm_smccc_1_2_regs res;
>>> +	size_t len;
>>> +
>>> +	/*
>>> +	 * Issue Number 1.6 of the Arm SMC Calling Convention
>>> +	 * specification introduces an optional "name" string
>>> +	 * to the ARM_SMCCC_ARCH_SOC_ID function.  Fetch it if
>>> +	 * available.
>>> +	 */
>>> +	args.a0 = ARM_SMCCC_ARCH_SOC_ID;
>>> +	args.a1 = 2;    /* SOC_ID name */
>>> +	arm_smccc_1_2_invoke(&args, &res);
>>> +	if ((u32)res.a0 == 0) {
>>> +		const unsigned int regsize = sizeof(res.a1);
>>> +
>>> +		/*
>>> +		 * Copy res.a1..res.a17 to the smccc_soc_id_name string
>>> +		 * 8 bytes at a time.  As per Issue 1.6 of the Arm SMC
>>> +		 * Calling Convention, the string will be NUL terminated
>>> +		 * and padded, from the end of the string to the end of the
>>> +		 * 136 byte buffer, with NULs.
>>> +		 */
>>> +		str_fragment_from_reg(smccc_soc_id_name + 0*regsize, res.a1);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 1*regsize, res.a2);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 2*regsize, res.a3);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 3*regsize, res.a4);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 4*regsize, res.a5);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 5*regsize, res.a6);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 6*regsize, res.a7);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 7*regsize, res.a8);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 8*regsize, res.a9);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 9*regsize, res.a10);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 10*regsize, res.a11);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 11*regsize, res.a12);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 12*regsize, res.a13);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 13*regsize, res.a14);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 14*regsize, res.a15);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 15*regsize, res.a16);
>>> +		str_fragment_from_reg(smccc_soc_id_name + 16*regsize, res.a17);
>>
>> Please get rid of 'regsize' and use '8' directly. This only exists for
>> arm64, where the registeres are 8 bytes, and the comment immediately
>> above refers to "8 bytes" specifically anyway, so 'regsize' only serves
>> to make this harder to read.
>>
>> It'd be a bit clearer as:
>>
>> 	str_fragment_from_reg(smccc_soc_id_name + 8 * 0,  res.a1);
>> 	str_fragment_from_reg(smccc_soc_id_name + 8 * 1,  res.a2);
>> 	...
>> 	str_fragment_from_reg(smccc_soc_id_name + 8 * 15, res.a16);
>> 	str_fragment_from_reg(smccc_soc_id_name + 8 * 16, res.a17);
>>
>> Sudeep, are you happy to fix that up when applying?
>>
>>> +
>>> +		len = strnlen(smccc_soc_id_name, sizeof(smccc_soc_id_name));
>>> +		if (len) {
>>> +			if (len == sizeof(smccc_soc_id_name))
>>> +				pr_warn(FW_BUG "Ignoring improperly formatted Name\n");
>>
>> It's odd that 'Name' is capitalized here. Not a big deal, but it doesn't
>> look quite right.
>>
> 
> I can fix both of these and apply. No need to repost.
> 


