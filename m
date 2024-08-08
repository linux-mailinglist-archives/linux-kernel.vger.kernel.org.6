Return-Path: <linux-kernel+bounces-278877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B894B5F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162A22838D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E39A83A17;
	Thu,  8 Aug 2024 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RYzdyctg"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021073.outbound.protection.outlook.com [52.101.57.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E333F7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723091817; cv=fail; b=BDqI+3PY6nmFJYlfqijoD7aGDcGEtFx9RMJvhOYdrjoUCm86sgg+bzdE8WE+g02aEU4hf/hlbBuLhA3Gj1gTS1v4RPCRSeImyE0U6mvsGv8gyUFidU9fiXKpUZjKGMgJe8MFOc10xGMkpSxsMhmJfTWppqfcmU1F//9eT1z8pVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723091817; c=relaxed/simple;
	bh=6B96FK0PR77MJz0FKRtwdhTeO4d8BWKN+2iRtmSr7II=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mjzMfYXPTtVtj5XDG3rfgKF9mpznzGODimP1CuifKWevsisGfqQivyVNEosLUNzsXcIoMQig+KG/9A2A4BfekruYj+LQoRuuMRezwNd9KWuCRP1CqNvuHuIws4aQaG4yJtSPE8fOUldjTHmHcsKNqjMRqdlpJzDSFXRTTHRRHDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RYzdyctg; arc=fail smtp.client-ip=52.101.57.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI9qIzcpgLlkq3Tfb67ffttNn3AZdFUdHYLqKbzDt9p/sJqRXWuFdI+5RDDoObWvGitaWDbRXZpz2ZV0qwbVRc+z8i/DujWmnilzXWtUsy1yYxhXYwk5h0oe/jji0/ldb1yTaMzh8vpUzn5WLHYOKlCF9gpIvpqiMDjQdNbCgAzjuX0g9zeUN2vGiZ9WJAEoSbrlY4E7Y8c/VNC/IN/YUbQi6UdVDMo84CI4CZrhBsge1rXxqzEcaQp/5tRmRpe8qr00Ha9/XWqunyKzBQm4FffBtU6+17jsqitby5PXz2vUyuTUGJxMRj50ZH+QHPZeicdofy/UOf8YbiwHUDMNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KbEXMnxBTK8cu4KdjXVE0hOLjeX6f7pn3rSEKsDmiE=;
 b=qtwI/f5E1hUS/b/kMYEGgRsC9QnRFg3XJBMoWOEEiNRdcOmQj9JhKJFZiuXmDX8Hz3aofazjXCfAZCTDs/G5jtAKbtsHFti29qhscdUKkRb4VSNvEU04vtoTJHmfUTPfHhPkV7FrgkLGYD8hj6Tl9eQpfA7TKbE2f+LqJVoKmHmdXY4ZSTflgNusGScv8GnZ9/zVJrflpf68Gr8718cSrgL2BSP1cVpKSvQNbcbcnacucjI8eGpGJyb5JzrVnNhvmcCckBVq31yoPPhOutx8vgu9HKkDfNq88TatyECn8Ddj8Qi2CJJEpHx0AuoQWl7xpO+lqD8eYxWMm+0zdzNfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KbEXMnxBTK8cu4KdjXVE0hOLjeX6f7pn3rSEKsDmiE=;
 b=RYzdyctgR5xyJ3Nrvz5iE9m32oPq6EG1uzxGw+lukDroiM1t1iAxUdgpfvuLgekmrPkFQjVvE7WJstNP/8UjBft6XGnl7wTjEfrt0+ABSANJirTMzeyfuOQgaKep1gomjxFoG6rOmAlCz+/RGXojbAD6spU0hqQXBmRo26pgUIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 DM4PR01MB7810.prod.exchangelabs.com (2603:10b6:8:69::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.27; Thu, 8 Aug 2024 04:36:51 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 04:36:51 +0000
Message-ID: <915fefb2-b0bc-4306-83ec-22570719e8e4@os.amperecomputing.com>
Date: Thu, 8 Aug 2024 10:06:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>,
 scclevenger@os.amperecomputing.com
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com, Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
 <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
 <4ba157c2-4a56-4d77-9a15-071e46adc33b@os.amperecomputing.com>
 <d3c86965-090b-41c5-85a9-187704754072@arm.com>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <d3c86965-090b-41c5-85a9-187704754072@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::17) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|DM4PR01MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5118dc41-5d92-40a7-1781-08dcb763b8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXFySGcybkFMWmZzSXRGYXpTdFNIWldIQWs4TFJXUEcxN1dnYkVaenNWV3hh?=
 =?utf-8?B?aU9oUFk2bGsramp5ckdNYTVjMjZ4ajZaZTJuT0RBTHhNbkY1eHVNWmw3WVlo?=
 =?utf-8?B?SnFMbm1mVnZXU3BNbktZTFdxUFB2aVJaeUxkQ1ZVbG1yVFV6eUJPZGc0aElw?=
 =?utf-8?B?RFBxSURPc0lYVGFwV1lWNGIvR1NqM21BMWsvbzAvQVRBeUFaSjAzTG00TGNO?=
 =?utf-8?B?NE1rNFY1SnZPZytDN0VPNytHdXA4di9hQ0JXcXpzZU5mdUs5YUMwVFI1VFNR?=
 =?utf-8?B?MFdPRDEwQ3cxZVl1UGFhSFp2YXRyekkyRjRUMGNuSTJoYUtlVzBNYXdieWxS?=
 =?utf-8?B?bVQzUlI4K0lKNHVoUTk4Z3BNankwV3Y0NlNhTzAxc3V1YU0zZDl0V0JQWTFi?=
 =?utf-8?B?cWRHbkZ6MGN6U0h4S2RGVjhYdk91RFcyWk5JQVI5U0UyM2VsaG1UdFRtcVFh?=
 =?utf-8?B?TDBFUU5icnV1SmhYRTVBUWVoMExYNEpHa2FaVXRFbUIvVmpvR1l3RmNXS1hs?=
 =?utf-8?B?WkM5azZkQThDUG1YSCtib1JGTFZNSUx6TnU5RjN0UHhsengyMVI2RUYvbldK?=
 =?utf-8?B?TmZNRi9WUzNRb21UdlovTlppRGJRRXF6OGxWUlhiRlorOUh0blcvSWMvVE5r?=
 =?utf-8?B?SnZYTUtzNjgxcmxLVUl6QU1TUS9pS1Z0WUwwdUxPSC9iY3owNjd2aWZiYWxL?=
 =?utf-8?B?R05lTHBOeTlDVkdQVHJhejZSdW9kN0ZHOG1oQThraU9hZkpUU09XbHFWYVp5?=
 =?utf-8?B?SFJQQXgxSUExb0ErZzNJdDJ2Vkd2THhaN0JsRXZERzl5NzJmaXc1ejBUbEVw?=
 =?utf-8?B?eFA2SlREczBIRWVkcE9zTUZTNjNYcHV6RXJLNXpUekpiOGQwVnNnZVBVQlQx?=
 =?utf-8?B?WGExUDBRSTJGRWx1QlNBMDZYdStkRXBSQlJqd21nYzl0QkZtSTdNVGx3bkJt?=
 =?utf-8?B?OHo3YVF1RUlqTVRzZVJxMDZNdTF0TXJVbXhHQTVGQWpYRWtEVWdlbGlEMmZ5?=
 =?utf-8?B?WEI2cGdENnhhV0xaU1NGeXYrWVNBWWZqVUlFaU5SSGIzcE5sU2d2R29uNEVs?=
 =?utf-8?B?aHZGd1BBU3FvczZzVzFnMTUwUHNsTUFIZmo4ZWc2Sk9rcHptMFBHRUtPQStD?=
 =?utf-8?B?WE41QnNhbi9aM2NpNWpqRTdoeW9oZkQ4bFFuT1NuTGZXRjc4MGpqcm9XaUph?=
 =?utf-8?B?WkE2U0ZmRmVnOXZWOFpZaFI4T250QUtSbDgyM0hFcElpTktUazNuWjlmZXFn?=
 =?utf-8?B?VWk0V044WkthWHprN2tPLzZxNEJoNXRTNEJlY0NpZDlGMCtaT0pPdmRCQ0Nh?=
 =?utf-8?B?MmZuaVhzUmVvTVhkYW1vZVQxZ2dCRUhpczdMRkd5emwzYk0vQy9VcngyS1pG?=
 =?utf-8?B?Yll4aU0ycSt6V0JpaG5pdTZqNjBneWRTMGJzc1J2UWpWV3dET3lyRmhyaDcx?=
 =?utf-8?B?VmFoMS9uTzBQYXlYYUpXUitvVVFCdXpKZXkreVFDS0hKREZWbzY4OG5OUUZH?=
 =?utf-8?B?aWVHc1NWRkFyQ0FkclFXMW9uRi81Q0FFanA3V3FYeURHVnViQU1MbWh4N3hy?=
 =?utf-8?B?ZkdOdDhsdDFtZ3FlZHY1bVhHS29KWFd4N3dXb3VpaUZOeDlsaEwzZDRQM28y?=
 =?utf-8?B?Qm1iR3QySkNLWi9QQVdsbVl6SUdiYm41OWpYVW1TOTdZWWdkQitudzkwRjNx?=
 =?utf-8?B?TENOeko2YWtzcVp5dWJtQlNhOHZFelp4dGx6U2JJaXlEa21tbWpGR3Jqd004?=
 =?utf-8?B?cTl0N3hzeS9DRE11SkVrT2pQZURGSllQQUJiazRiblBNeUp1eDhQLzhHaURl?=
 =?utf-8?B?d1U1Z2RzdEdzNEliTGxmdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjI3Y2gybytxVUJMTy9KVE8wUyt6THRKOGtyZGo3WEZyUVZBbWdEVEhpZHg4?=
 =?utf-8?B?RCs4QnpQQXdwZisyREZleGpkMjgzcm5IVEdETjVxZnpSaFBUUUt6aTRteXV1?=
 =?utf-8?B?amt1Yks0M3ppd0svcjdPeTFuUWpsZ3NadFJGNlNUNERyZERrdnpFM09OcEFE?=
 =?utf-8?B?cmdza1RPN0dhNHFod3YrTkZHQXY1MDBQTjBCZnVnY3FOdlFNK1pySU9ieUlB?=
 =?utf-8?B?dWxXREt5dWNrVlp4dE9Ldml3eXFhMFpldnNYWnhaQXZFZTB2d0pVVGRBVC8w?=
 =?utf-8?B?RjR6dndKMVZWTTNqRW5YUlZaMjBySWdrM0xzZ2lyQXBSbldEbG13RzFrMkhE?=
 =?utf-8?B?MHdBYW01QWVPK216K3NhSjVrNHM1LzZFdC9WV1QvQzJnZmNLUE1uU293UHJl?=
 =?utf-8?B?TFVEZEVmbDhDK1U3RmViZ3hqMFpsZFVCdlNFc3FBRkJ3WUZ2UDJnNjZxYUpU?=
 =?utf-8?B?ejA3VWp1VkZja1RpcFhIbEVUSlNQQWNveGk4TGdSSVZPRUozZlZ1K1RHV0Jn?=
 =?utf-8?B?RUFBYk1QZ1RxYW9zUE81dEhBbmNjNHBHQkd3ZXZnYUtHSGFBcDdVVk5ZaGtJ?=
 =?utf-8?B?VTJlRmdOcjlGR3BvSTVJYzZVQUFBdWJlaU1RSDFCZWErQjhueHUvZ1crOTZ0?=
 =?utf-8?B?eVNCNWcwMXQ4a1hzT3AwbERxRzJza3A2aXdVZGtFRUd6V1UyRytZbEdjcEpx?=
 =?utf-8?B?N2RtOGpQL09oSHNzTGRnelBQL0hCRXE1WHJhYUtPbzJkczNlMjA5c1dhQjhX?=
 =?utf-8?B?V01XWHRLWmRZRkFOQVk0T21MRER4K1lSVGNIWGVLditPNnNxRi9rYkI3ZDY5?=
 =?utf-8?B?SlRlV1hSc3hzTldmMFVOTEUrLzg1dVdabm53ZWNzdEF3ay9iYk5DdjltaUxT?=
 =?utf-8?B?S2ZwU3lNTG1QLzlYMFNQejJzRzJySGM4aFBxOXBWb1pHb3V4NVJxNWFVQU5Q?=
 =?utf-8?B?ck1MQmdxVjVHZTFQK2ZvSnllSzUwTlg4cHhKMDc0dVZmd0FDY0QrZW9JWEhE?=
 =?utf-8?B?TklPUEdPWHU4azI5TGw4TDY1U2srQlVScnBxVEh5bmdzVFJWd3Rmc2ZSK2N5?=
 =?utf-8?B?RzhQQkN6OUYySStoL0wrRTVXeVZMaTVLNmRNZ2UyVEdITG5mMGVPaTIwL21p?=
 =?utf-8?B?eUt0ckd0SGN5ZGx5UzRrVnp0MkZWME9aRnZQVVE0NzluTXF0Rk1jWkRLN3Bp?=
 =?utf-8?B?TXd3L3o2RGY0MVlEKzlZTWtlREFHKzNlSWpIRStUWDQrYVdKWFVGNXRUYkV6?=
 =?utf-8?B?RjEwQ0ZiOS9IdlNERUI5dkJLL1ZsWUVQK2tJYTY5dGtCUWg4a3ZKa1IvN056?=
 =?utf-8?B?ZU5IWlBzekE3THhlU0t4UTdRSVVJSVUzUEJ1bHZHV0VvMDBqaTlCUm5MSHZy?=
 =?utf-8?B?dlgwelpJWjNwck9CU2tzUWYwd213MzlWdmZHRjFMcDMvTjIyZHk2Y0t3Y0po?=
 =?utf-8?B?LzI1MkJLVVprTHBzd1FVdEd5dUh3QzVtYjhMV05IS3pIYUQ0NzE5YXVtOHV2?=
 =?utf-8?B?YXZvV0U3UUtQMDdVclplQ1J6cStxRDFXdHBTNkplR1U4OXd3a0FHUk9kSkdM?=
 =?utf-8?B?bGI2d0dHZjd1Z01TMEZaenFOL0I2bU4weVJ1eTNlbE90UVBrdVZ4OXVwRWI2?=
 =?utf-8?B?aERraXlodWlqcDdDWitvRGVrWWFxT0VMOWZIUDJsaUpDaEVZVGs3WXltVG1k?=
 =?utf-8?B?ZUlJMGR4UW91OHVyYlpDYVA1OWtUdjcvWmkzU0o1b1VKWHlMNUNaWU92WVB6?=
 =?utf-8?B?aURiRWR2ZFRHc3N2RGFUWTd5bmZsM1ZJeEV5TUt0RktRSWoySjRZVFdEL2Qw?=
 =?utf-8?B?aytDbnBNaUc4MW13TnFDNzRTa01hYkRUQ2tJcDJ0RTFGeFhjWUZmRUpBVkVU?=
 =?utf-8?B?d0tTL25rTWNSV285RGZWNDIzMjdBTUFZT2dneHZTNm9LZlVvYTkzVnl4R054?=
 =?utf-8?B?cXRXRFB4QTFKVXJKSVpPT0xMOUJwNWpJcW4vZTQ2SlQ2T20veU9PdHZBL1J3?=
 =?utf-8?B?aldMYkJVWnAxdklicG15aHNjNkkrOHhXNTc2a0owWitIdWsxYVI1V3hEVXFz?=
 =?utf-8?B?bk1Kc0EvaHBjV2h6eHEyY3d3VEN1bHg1Y29XUlBWMTJYMW9PMk1TUWt4bW1Y?=
 =?utf-8?B?Tlg2a3d6M1Zoa01INGFqRTRyc0xqYXU5OE9GWUJTR1pLY2lXaXJwa3Q0a01C?=
 =?utf-8?Q?Ze8rQRlGggNs4iILZoCsOe5xvmIoAdh40x1S9d49rF1g?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5118dc41-5d92-40a7-1781-08dcb763b8b2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 04:36:50.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYFj3QRQjmsxLfjY5eVO5xHx32IawRamB1SQYHGFwThgrA14D8vcpXyjHEfY/DuJ19/yqS3TI4p5xfnmpAEldw44Ft9D7ruTp4GOj7WxJcpIuuEF3dlbtKzyEVdhTYzC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7810



On 08-08-2024 12:50 am, Leo Yan wrote:
> On 8/7/2024 5:18 PM, Ganapatrao Kulkarni wrote:
> 
>> Is below diff with force option looks good?
>>
>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> index d973c2baed1c..efe34f308beb 100755
>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -36,7 +36,10 @@ option_list = [
>>                      help="Set path to objdump executable file"),
>>          make_option("-v", "--verbose", dest="verbose",
>>                      action="store_true", default=False,
>> -                   help="Enable debugging log")
>> +                   help="Enable debugging log"),
>> +       make_option("-f", "--force", dest="force",
>> +                   action="store_true", default=False,
>> +                   help="Force decoder to continue")
>>   ]
>>
>>   parser = OptionParser(option_list=option_list)
>> @@ -257,6 +260,12 @@ def process_event(param_dict):
>>                  print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>                  return
>>
>> +       if (stop_addr < start_addr):
>> +               if (options.verbose == True or options.force):
>> +                       print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
>> +               if (options.force):
>> +                       return
> 
> I struggled a bit for the code - it is confused that force mode bails out
> and the non-force mode continues to run. I prefer to always bail out for
> the discontinuity case, as it is pointless to continue in this case.

Kept bail out with force option since I though it is not good to hide 
the error in normal use, otherwise we never able to notice this error in 
the future and it becomes default hidden. Eventually this error should 
be fixed.

Having said that, It is also seems OK to avoid the error with the 
warning message as you suggested.

> 
>            if (stop_addr <= start_addr):
>                print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % \
>                      (stop_addr, start_addr, dso))
>                return
> 

Thanks,
Ganapat

