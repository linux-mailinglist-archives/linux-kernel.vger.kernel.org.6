Return-Path: <linux-kernel+bounces-260142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0252D93A3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8148F1F2448C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91147156F5D;
	Tue, 23 Jul 2024 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ej6VFBs6"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020104.outbound.protection.outlook.com [52.101.85.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3F13B599
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748416; cv=fail; b=JzLze6u/dOepli7vpms425plHtpt6jSd07H4H+sbN9g0dUPwl9c99TvHIYovUbsQfXVFnhQuwg3iBEHZ30n0VQDixvjcnDL6dXGAJDcLxuGzA7LCWoz0ZrrAILM71wjyu8ZrZqw+8tKGT8ySw3CLkLOh8tGMKeT09yhIwhqD8so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748416; c=relaxed/simple;
	bh=muIegvQh7GjCZI+Lcly/K1XhaYqt9v2wuCNrXgsbclo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jR28ePMk/t0wt92kLFwLksyE9whh4UGl3fiwQUcEVr5qZIpS/cIqdxoVLGdGG80r1+sxXzBm1SB+0tzTLFKYVH5txK0EsLG2gWSg/wuvYsrXQbpuH/Mwr0xnmlrUjliLiHBZNlN1sYBgodSbPvuvnDVw1iBo8qRyCjYPTIs3FcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ej6VFBs6; arc=fail smtp.client-ip=52.101.85.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaq+fIi0uN0XTyoTtr4TUHZmbAxJBm0y/Crz9yjzUv9E0ze6AMTjZJtKEnxaQn5yItnstI+BAe1j3I0CxUu84noWsXxfXH0T6BJ/D3YNMjWNY93R2ixLZBNncJ7TQq6BDXXJUgtzcLho5unOwV8WbxWYkTEyZ0SlLJEZI3Whv6SsGpBE5LY3Dctn+5VWyJjq4WCu7TQ3gZS3OTaWTK1m7Ygoz2wY4JTuNBfIhuhGjA9liuhhCBF+evyWn8oNsjReThWvBsFu1077dZc/GXpPNKGiAW80sDcAXOEe4TtlWQRzhDnUEHSEQdD0ombvspUt+p2rAmnTqbZOyEQYfGHDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byTdhp8ebHSSWrCnaqJsdA8rUf0Ir86zw/KRgEqmTj0=;
 b=onIlKYTtnNXTWBKwGs2a1uDorgB6pHFjQXHK9sz37tEbv07dbd4PqU5ED5OhYuI8QdgSZxbgJs6y1tcgnuoYrxoAmv2Bng3Uuo+m71S2q+81LwiIJPG0ntnFtM+DK1AxITq6IISvKcAF6zCSBlTEZZH+qNytvRzxFuSMBEyo8A22eywYBIk441zIGUwzjVVzMTp1yOojEtWjHMjtBLt4sOt9Qym8/guziBH/fnuAv358gRpZ/efRBALy9QuxK5NTownA1j/9wId4yDJKGbbbPE7VfmFMsPG3OdPq7km/VPtVBNDtOKiUI7VDV1U+f/DmMhbKF5vY83fsLKKkaSNrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byTdhp8ebHSSWrCnaqJsdA8rUf0Ir86zw/KRgEqmTj0=;
 b=Ej6VFBs6TTIopA8vKy+We8L2j66GqFapU6Cxe4buuCKRN/0XYG171mztvsgeX/4J4xjqqCTVOzxbGeSeItUqn6XtZZGj25TiNq8IqUedV0q9HcilTqumTOP3Snw0zX4apqCE2YyI/pnSJAY/ta616OHc0aFHAO6zlhtAF1b129M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB7185.prod.exchangelabs.com (2603:10b6:610:fe::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Tue, 23 Jul 2024 15:26:47 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 15:26:47 +0000
Message-ID: <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
Date: Tue, 23 Jul 2024 20:56:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>, james.clark@arm.com,
 mike.leach@linaro.org, suzuki.poulose@arm.com, Leo Yan <leo.yan@arm.com>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, scclevenger@os.amperecomputing.com
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::6) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CH0PR01MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be4fe8f-38ce-4c2b-dff8-08dcab2bdd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0g3YTVRTlFNMER2NUNWVVgyTWZVMjExaG9Qa2VFc0YwQnp3NnJjRmFuYTI4?=
 =?utf-8?B?YTJYMjNQMXdxcDBJTTJlTm9JM1NDMVdUS3k2aXBRQXpTZFV1MEJFdmFjajNX?=
 =?utf-8?B?UGdyYmFjeXFER2hCTnlMdEp1bVZzNHJCeFl3MWE2MFNBRjlKak1ZQ0ZlbTVS?=
 =?utf-8?B?elhnOVVhditqUGZ0NVFaZHZnMUthZk05VXZINUZMY3pSOElHb1VyZThZK1M3?=
 =?utf-8?B?LzFpQmFZMCs0RlBobXNDOE10aEhQajZ6VGxMV202bmRUN1Q2NTQ2cEJiS1F1?=
 =?utf-8?B?Wk52QnVvOGhiRmRUdzl3dXhDTnBlZkJGd25RM1R2Sk1BT0pQZHAxdGhXRnpi?=
 =?utf-8?B?Zyt0bzlnK1pvays2SStnVHdoQkZ4NU9jVDA4S2xlQmJmczZ2MGU1WkVlK0dz?=
 =?utf-8?B?dmhhVzkxY09jQlBiZTViQ1poNEFYb3NXY0xPM1hCcGpmWXdRNzFIRzNITzJO?=
 =?utf-8?B?SktMN1locjJPSG1vNkl1MityWjd2ME9TRi9xS29mRHpMYkQrZXlPTUt2cVhk?=
 =?utf-8?B?dW1YdXdSWDRzNWlENFY4U2VHajV3RXNRZ1BrNUhhcFhwc1k4S0JPVDQ0Slc0?=
 =?utf-8?B?dzBjVnZUbEkrcDhHTy9kc1hkd2FyV0M2cG81MmMzS2FUY2NRaGlIRklBanFT?=
 =?utf-8?B?dGh2Mmc3SmgxZ0lKcEYwUkV2R1JLVldMWldLM2FMTWdsMWxNRWxIUzk4SkhD?=
 =?utf-8?B?ckNMWktTY0pNcmt5TFRWTXBVV2VyVWVBR0MzSFN0Z1RIYWxPc1MwZnU3L00v?=
 =?utf-8?B?Z1ZZdnRUUjRMcEpyMW55V1VhT05ZRG0xMHNQMWtRYmFaK1lKMmtIam9hRWl0?=
 =?utf-8?B?dTlrZVd1ek5YejhvajFGUFFpV21lSFlxMjhkVzZzbnZaVGVEQ3NtZ01WajJH?=
 =?utf-8?B?ODZaMGViL1FsT3ZONkh5T1ZvOGZwSEpocVllMzlwZzlSMnNONzhnMk4vMC9V?=
 =?utf-8?B?czRTTTA0cEdzeW5XWnVxYmFhaVBrNkFKejJ0UTFWNGY2T0lTT3VpZFd5cEZR?=
 =?utf-8?B?RUgweVpmYjdaZDlEa0IxSDY2WHNhbHdMNzN3UVkzY0JmNTZ3MVpPZGUrNUMv?=
 =?utf-8?B?WU4veHFybVB4Z25wNkdlMzY4TGJBNUJwNVlvOTg3ODQrUndaTC83bnc1S2V1?=
 =?utf-8?B?WUNlTnB6bG5qYmw4ZVlRVW9LNzlMbHRSSG9VcUVkOTR0RDNacUxucHFnRnRT?=
 =?utf-8?B?OG1INFpFc0ptQjRjYzJUYzlOLzgxSVc1UFpzMWhuQ2RaL0pLL05VQU1FdzVP?=
 =?utf-8?B?VEZJdXAxTmhQUzdWcUJvTGxRaktEMGtVODlIQ2lET0k3a0YyOXZZa3RuU0U4?=
 =?utf-8?B?alI5eGUxSXNPdmdzalduekYyU29jemV4QkkwTUk0WVE1MVBvc09jYVJXL0Fi?=
 =?utf-8?B?WitGb250NjdNMDNVR2ZTbE5DVlVFbXZMU1ErK0tpTzhKV25PMHpyNUZRelo4?=
 =?utf-8?B?S0tmK0V6cTB5UW5mWEIzVUh6MXIxNXhMWmRxNmRaMzcvTzA1VmhlaVVtOEpv?=
 =?utf-8?B?TGhNbms4bGFRcTF0aGR5T3pOOUpDVXptVzZ2RXRLZnl5dXJEbXZ1b2UwalRs?=
 =?utf-8?B?QUYyUWtHT0VWYzcrVVN4L01KNVhtZis4SGhzOTd3bGpxeGk1cnlUcVFjUGZt?=
 =?utf-8?B?MnpiakVWczNRU0ZaOVd3R0JCRGhFb2FPWkVodkp2ZGhvVWxZSHh3SnZmbmIv?=
 =?utf-8?B?eml3eG54WitVUFpxbTZVaW1BNUVMaHpsTEJQN0pUT3NvWCtmUlZMNVlkWjRU?=
 =?utf-8?B?eUdkbDJ1QkN3Y0xUTStMSWIxaXd4eG5vamtGVitnWWN5UHFNSDIvb0RxVm5s?=
 =?utf-8?B?aFUxbG9Dd3RlVWxWOEpiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3dUTjlEUm8yTTVyZmtabXhOUFZpWWhGZk0rcU85RXlZdGpiRnFGL3kxeWpZ?=
 =?utf-8?B?VmpPdGtMWXEwUzhjSmdJZURnMkY2T1ZpcEFtdnJkcXhlUko4azhSSWZuUDFp?=
 =?utf-8?B?NHNJWmVaajJXTnRYTWxoTnRUc0JtcStRNVhiVklKZmlyR3Z2WUliazZMdnNl?=
 =?utf-8?B?ZmlET0NuQTE2c1JNc29QZVdES1VsU0NyNEVYS1pHeTc3aG1pRFpTZ3lCcTYx?=
 =?utf-8?B?UzdMc1RNanBiaGRXOFVBdmJ6K2hzRHlpa3lGSDltWWMwUmVhNjhHZU5OcHAr?=
 =?utf-8?B?V25IMEVwcUIzcEY0OFFtUVJYN2Vuekx0cGR3M3dYN2tsZkZGcFRQWUdjVVI3?=
 =?utf-8?B?eDVKbUZOU012Z3NUMzdiLzdSVUV2NmdSWno3d1pZaEtMa1NBOXpITEhmdWR6?=
 =?utf-8?B?Mi84S0l6blJWd2ZkdlFnUDNNalMyV05aYTJSbXB2YjRuU3VGVHlTRUFyc0tr?=
 =?utf-8?B?REk0QmZxejRaajRzSlZYalFibE90NXZ3aDhNNW9ZRjEwdW5meWVDaGRBb1dh?=
 =?utf-8?B?YlQxMzJMNEpNUGpkWk91bzlCYVp6b0ZlVDJja05oQ3BreDdEcDZuWHZVN2Ja?=
 =?utf-8?B?YVdpN2VSSEtoS3grVHlteE85UkI0MXVJY1hjTStXY2hVcHFxN3BsL1hXMXE0?=
 =?utf-8?B?eDFEemhxVVViM2srSVJvVzRVWmhJdENEclBEQlZOZzhjQkx2MDF0aFZ2MGtx?=
 =?utf-8?B?RXFrdmNoWlg4NitQYnhnNWRWZDJxSnNHS3MwSGZqSVRGR0NLWXpERlp2Qi9V?=
 =?utf-8?B?L1ZLb3BtcDMrU1JMeVc4V1V3L1NYSzB4ZjcreVV0dy9KdDl2WjMrZ0FrZVJT?=
 =?utf-8?B?NCtxbUIyQjVzenFiZGNGMW5CYk1hU2ljU0c0U21tb1hsYW8zOEQ1WktvVTBk?=
 =?utf-8?B?clZBekFOaFRKQUxFall2bGE1K1Q2cU5ud1dZZ2N3QWVYT2xwRXBTL29maXBh?=
 =?utf-8?B?QnpHMHVWdUVMYzNkRFJ4MUpoc3hFelRzQTZscTBVZW1vVkVqSVJNeEtiRmVo?=
 =?utf-8?B?S1hqWThURGxLblU3emlXTERtdG9UbWpWbmFQY2xUbDFsRTZZeWNGWUQ4OVJP?=
 =?utf-8?B?ZEF0U2hrNC9TbXFmRWZPN3ZOYXdNOUszMXNhTlFZQ2hPUnVRWEo0cTAyNW9k?=
 =?utf-8?B?QlJiVCtjNWFXdm5IaDR3NUUrL2FacDFQUjlVamloTjdZcFRDV2hNMWZhcHRK?=
 =?utf-8?B?M2tYQ1kxUmowYkdKRHpBRS9NY3ZYUmR1MzY2dmY1Y0tCOTlLSHRaelo5STFS?=
 =?utf-8?B?OW54MGx6UVc0VXFLS3ZDcHVJQVUrYmZicU5mZXo2WDRPTy9iUUxTRzV2ckZN?=
 =?utf-8?B?L2J4RkVTL085TkwzZXhyU2lCS29LUk1JOE5nbTV3eXhkQ1U4elZiM1hNQVo3?=
 =?utf-8?B?ekxmdWEzaFluUjFLMFBjUTF5R3dubDZlSXJWZ0RRcm50aktVdjgzbitiM21J?=
 =?utf-8?B?UGxtOEZGS2pMaWVIMnNHNURacmlqTkJBSy9TSzZ5Mm1JU0sxNTJQdjBkTEpU?=
 =?utf-8?B?MUxBSFhjcnhDVnVSZjUvem1wYy9DYW9rTHoweHp2aEVaV09zQnBqd2hBYURV?=
 =?utf-8?B?TEZyTHp1QVAyWGlKVWxBWU9HVFZPd1FJT2VNMXJwY3F0aFVxU3Z3a09mRjc5?=
 =?utf-8?B?NC90YXlHRDZqblJaYUM2aFlVdVhTUW9oVGFYMGpHTDRiQWdMdlpqckRmM2Nk?=
 =?utf-8?B?TmJaYm10MmtKOGZEQjl5eGhrYjNUb0tuUWZtVnVZYVplQWlJZWVxVTZyRHJz?=
 =?utf-8?B?dDZ5cVI4SXdqc1RUUWJ5STlZaTJFV2c0b3hoWGZnUXgrdmg3aWJJdmRWYUpm?=
 =?utf-8?B?Q0tnVFp1QkVHTys2c2ExbVBJd0htYmtKYnNTR1k4dE1uSTlZNjJRTk1uamV0?=
 =?utf-8?B?WlpmZ3NCT3A4WGYyWVd2RGxPQzJjTWlWMmxRT0Fvb3l4Q01vaUNWNXA3U3dT?=
 =?utf-8?B?NTJpTkVZZnRwYUVCSWhleW0rK1ZSUE1jM0IxYU11UjY1WENIbFBRRi92dlVx?=
 =?utf-8?B?aVlpdmdXdE4zOG1wMlRGeUkyWHZuRjdjNmRvRHdKM3FteUkrcVIrZ24xSHBX?=
 =?utf-8?B?M0dSWWI2YkdtQ2dyQ1laYWNtOVE2MHlub2Fsc3R5RXZ6V1MycnZXOW5sV1VB?=
 =?utf-8?B?ZFJkTE1UUEtIYWt0NWRqUkZhRVpjdVJtSVJKL2hFb1ZaZTVpSFhZdG5BVTBk?=
 =?utf-8?Q?REn9p0Rxhov7W55U71af3uY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be4fe8f-38ce-4c2b-dff8-08dcab2bdd7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 15:26:47.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkHqF/G7bnJnicwAg9PqCiBw4fKNAhb8fqk8jaTyFBiolBA6ptQUAuiwssdjFnqtYSby4sw98LKvHNC6TtfzgWDuGPrccZgunLYkZeAXCkgNGiMfPILgCQ3zm5VJ9Z35
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7185



On 23-07-2024 06:40 pm, James Clark wrote:
> 
> 
> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>
>> Hi James,
>>
>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>
>>>
>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>> To generate the instruction tracing, script uses 2 contiguous packets
>>>> address range. If there a continuity brake due to discontiguous branch
>>>> address, it is required to reset the tracing and start tracing with the
>>>> new set of contiguous packets.
>>>>
>>>> Adding change to identify the break and complete the remaining tracing
>>>> of current packets and restart tracing from new set of packets, if
>>>> continuity is established.
>>>>
>>>
>>> Hi Ganapatrao,
>>>
>>> Can you add a before and after example of what's changed to the 
>>> commit message? It wasn't immediately obvious to me if this is adding 
>>> missing output, or it was correcting the tail end of the output that 
>>> was previously wrong.
>>
>> It is adding tail end of the trace as well avoiding the segfault of 
>> the perf application. With out this change the perf segfaults with as 
>> below log
>>
>>
>> ./perf script --script=python:./scripts/python/arm-cs-trace-disasm.py 
>> -- -d objdump -k ../../vmlinux -v $* > dump
>> objdump: error: the stop address should be after the start address
>> Traceback (most recent call last):
>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
>> process_event
>>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105, in 
>> print_disam
>>      for line in read_disam(dso_fname, dso_start, start_addr, stop_addr):
>>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in read_disam
>>      disasm_output = check_output(disasm).decode('utf-8').split('\n')
>>                      ^^^^^^^^^^^^^^^^^^^^
>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in check_output
>>      return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
>>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>      raise CalledProcessError(retcode, process.args,
>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
>> '--start-address=0xffff80008125b758', 
>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned 
>> non-zero exit status 1.
>> Fatal Python error: handler_call_die: problem in Python trace event 
>> handler
>> Python runtime state: initialized
>>
>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>    <no Python frame>
>>
>> Extension modules: perf_trace_context, systemd._journal, 
>> systemd._reader, systemd.id128, report._py3report, _dbus_bindings, 
>> problem._py3abrt (total: 7)
>> Aborted (core dumped)
>>
>>>
>>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>>> ---
>>>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>           return
>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>> +
>>>
>>> Do you need to write into the global cpu_data here? Doesn't it get 
>>> overwritten after you load it back into 'prev_ip'
>>
>> No, the logic is same as holding the addr of previous packet.
>> Saving the previous packet saved ip in to prev_ip before overwriting 
>> with the current packet.
> 
> It's not exactly the same logic as holding the addr of the previous 
> sample. For addr, we return on the first None, with your change we now 
> "pretend" that the second one is also the previous one:
> 
>    if (cpu_data.get(str(cpu) + 'addr') == None):
>      cpu_data[str(cpu) + 'addr'] = addr
>      return  <----------------------------sample 0 return
> 
>    if (cpu_data.get(str(cpu) + 'ip') == None):
>        cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but no return
> 
> Then for sample 1 'prev_ip' is actually now the 'current' IP:

Yes, it is dummy for first packet. Added anticipating that we wont hit 
the discontinuity for the first packet itself.

Can this be changed to more intuitive like below?

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..d49f5090059f 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -198,6 +198,8 @@ def process_event(param_dict):
                 cpu_data[str(cpu) + 'addr'] = addr
                 return

+       if (cpu_data.get(str(cpu) + 'ip') != None):
+               prev_ip = cpu_data[str(cpu) + 'ip']

         if (options.verbose == True):
                 print("Event type: %s" % name)
@@ -243,12 +245,18 @@ def process_event(param_dict):

         # Record for previous sample packet
         cpu_data[str(cpu) + 'addr'] = addr
+       cpu_data[str(cpu) + 'ip'] = stop_addr

         # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
         if (start_addr == 0 and stop_addr == 4):
                 print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
                 return

+       if (stop_addr < start_addr and prev_ip != 0):
+               # Continuity of the Packets broken, set start_addr to 
previous
+               # packet ip to complete the remaining tracing of the 
address range.
+               start_addr = prev_ip
+
         if (start_addr < int(dso_start) or start_addr > int(dso_end)):
                 print("Start address 0x%x is out of range [ 0x%x .. 
0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
                 return

Without this patch below is the failure log(with segfault) for reference.

[root@sut01sys-r214 perf]# timeout 4s ./perf record -e cs_etm// -C 1 dd 
if=/dev/zero of=/dev/null
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.087 MB perf.data ]
[root@sut01sys-r214 perf]# ./perf script 
--script=python:./scripts/python/arm-cs-trace-disasm.py -- -d objdump -k 
../../vmlinux -v $* > dump
objdump: error: the stop address should be after the start address
Traceback (most recent call last):
   File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
process_event
     print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
   File "./scripts/python/arm-cs-trace-disasm.py", line 105, in print_disam
     for line in read_disam(dso_fname, dso_start, start_addr, stop_addr):
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "./scripts/python/arm-cs-trace-disasm.py", line 99, in read_disam
     disasm_output = check_output(disasm).decode('utf-8').split('\n')
                     ^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib64/python3.12/subprocess.py", line 466, in check_output
     return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib64/python3.12/subprocess.py", line 571, in run
     raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
'--start-address=0xffff80008125b758', 
'--stop-address=0xffff80008125a934', '../../vmlinux']' returned non-zero 
exit status 1.
Fatal Python error: handler_call_die: problem in Python trace event handler
Python runtime state: initialized

Current thread 0x0000ffffb90d54e0 (most recent call first):
   <no Python frame>

Extension modules: perf_trace_context, systemd._journal, 
systemd._reader, systemd.id128, report._py3report, _dbus_bindings, 
problem._py3abrt (total: 7)
Aborted (core dumped)


dump snippet:
============
Event type: branches
Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff800080313f04 <__perf_event_header__init_id+0x4c>:
         ffff800080313f04:       36100094        tbz     w20, #2, 
ffff800080313f14 <__perf_event_header__init_id+0x5c>
         ffff800080313f08:       f941e6a0        ldr     x0, [x21, #968]
         ffff800080313f0c:       d63f0000        blr     x0
             perf 12720/12720 [0001]      5986.372298040 
__perf_event_header__init_id+0x54 
.../coresight/linux/kernel/events/core.c  586         return event->clock();
Event type: branches
Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff80008030cb00 <local_clock>:
         ffff80008030cb00:       d503233f        paciasp
         ffff80008030cb04:       a9bf7bfd        stp     x29, x30, [sp, 
#-16]!
         ffff80008030cb08:       910003fd        mov     x29, sp
         ffff80008030cb0c:       97faba67        bl 
ffff8000801bb4a8 <sched_clock>
             perf 12720/12720 [0001]      5986.372298040 
local_clock+0xc 
...t/linux/./include/linux/sched/clock.h   64         return sched_clock();
Event type: branches
Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff8000801bb4a8 <sched_clock>:
         ffff8000801bb4a8:       d503233f        paciasp
         ffff8000801bb4ac:       a9be7bfd        stp     x29, x30, [sp, 
#-32]!
         ffff8000801bb4b0:       910003fd        mov     x29, sp
         ffff8000801bb4b4:       a90153f3        stp     x19, x20, [sp, #16]
         ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
         ffff8000801bb4bc:       b9401260        ldr     w0, [x19, #16]
         ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
         ffff8000801bb4c4:       b9001260        str     w0, [x19, #16]
         ffff8000801bb4c8:       94427cf8        bl 
ffff80008125a8a8 <sched_clock_noinstr>
             perf 12720/12720 [0001]      5986.372298040 
sched_clock+0x20 
...sight/linux/kernel/time/sched_clock.c  105         ns = 
sched_clock_noinstr();
Event type: branches
Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff80008125a8a8 <sched_clock_noinstr>:
         ffff80008125a8a8:       d503233f        paciasp
         ffff80008125a8ac:       a9bc7bfd        stp     x29, x30, [sp, 
#-64]!
         ffff80008125a8b0:       910003fd        mov     x29, sp
         ffff80008125a8b4:       a90153f3        stp     x19, x20, [sp, #16]
         ffff80008125a8b8:       b000e354        adrp    x20, 
ffff800082ec3000 <tick_bc_dev+0x140>
         ffff80008125a8bc:       910d0294        add     x20, x20, #0x340
         ffff80008125a8c0:       a90363f7        stp     x23, x24, [sp, #48]
         ffff80008125a8c4:       91002297        add     x23, x20, #0x8
         ffff80008125a8c8:       52800518        mov     w24, #0x28 
                 // #40
         ffff80008125a8cc:       a9025bf5        stp     x21, x22, [sp, #32]
         ffff80008125a8d0:       b9400296        ldr     w22, [x20]
         ffff80008125a8d4:       120002d5        and     w21, w22, #0x1
         ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
         ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
         ffff80008125a8e0:       f9400e60        ldr     x0, [x19, #24]
         ffff80008125a8e4:       d63f0000        blr     x0
             perf 12720/12720 [0001]      5986.372298040 
sched_clock_noinstr+0x3c 
...sight/linux/kernel/time/sched_clock.c   93                 cyc = 
(rd->read_sched_clock() - rd->epoch_cyc) &
Event type: branches
Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }


With fix:
=========

Event type: branches
Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff800080313f04 <__perf_event_header__init_id+0x4c>:
         ffff800080313f04:       36100094        tbz     w20, #2, 
ffff800080313f14 <__perf_event_header__init_id+0x5c>
         ffff800080313f08:       f941e6a0        ldr     x0, [x21, #968]
         ffff800080313f0c:       d63f0000        blr     x0
             perf 12720/12720 [0001]      5986.372298040 
__perf_event_header__init_id+0x54 
.../coresight/linux/kernel/events/core.c  586         return event->clock();
Event type: branches
Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff80008030cb00 <local_clock>:
         ffff80008030cb00:       d503233f        paciasp
         ffff80008030cb04:       a9bf7bfd        stp     x29, x30, [sp, 
#-16]!
         ffff80008030cb08:       910003fd        mov     x29, sp
         ffff80008030cb0c:       97faba67        bl 
ffff8000801bb4a8 <sched_clock>
             perf 12720/12720 [0001]      5986.372298040 
local_clock+0xc 
...t/linux/./include/linux/sched/clock.h   64         return sched_clock();
Event type: branches
Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff8000801bb4a8 <sched_clock>:
         ffff8000801bb4a8:       d503233f        paciasp
         ffff8000801bb4ac:       a9be7bfd        stp     x29, x30, [sp, 
#-32]!
         ffff8000801bb4b0:       910003fd        mov     x29, sp
         ffff8000801bb4b4:       a90153f3        stp     x19, x20, [sp, #16]
         ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
         ffff8000801bb4bc:       b9401260        ldr     w0, [x19, #16]
         ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
         ffff8000801bb4c4:       b9001260        str     w0, [x19, #16]
         ffff8000801bb4c8:       94427cf8        bl 
ffff80008125a8a8 <sched_clock_noinstr>
             perf 12720/12720 [0001]      5986.372298040 
sched_clock+0x20 
...sight/linux/kernel/time/sched_clock.c  105         ns = 
sched_clock_noinstr();
Event type: branches
Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff80008125a8a8 <sched_clock_noinstr>:
         ffff80008125a8a8:       d503233f        paciasp
         ffff80008125a8ac:       a9bc7bfd        stp     x29, x30, [sp, 
#-64]!
         ffff80008125a8b0:       910003fd        mov     x29, sp
         ffff80008125a8b4:       a90153f3        stp     x19, x20, [sp, #16]
         ffff80008125a8b8:       b000e354        adrp    x20, 
ffff800082ec3000 <tick_bc_dev+0x140>
         ffff80008125a8bc:       910d0294        add     x20, x20, #0x340
         ffff80008125a8c0:       a90363f7        stp     x23, x24, [sp, #48]
         ffff80008125a8c4:       91002297        add     x23, x20, #0x8
         ffff80008125a8c8:       52800518        mov     w24, #0x28 
                 // #40
         ffff80008125a8cc:       a9025bf5        stp     x21, x22, [sp, #32]
         ffff80008125a8d0:       b9400296        ldr     w22, [x20]
         ffff80008125a8d4:       120002d5        and     w21, w22, #0x1
         ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
         ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
         ffff80008125a8e0:       f9400e60        ldr     x0, [x19, #24]
         ffff80008125a8e4:       d63f0000        blr     x0
             perf 12720/12720 [0001]      5986.372298040 
sched_clock_noinstr+0x3c 
...sight/linux/kernel/time/sched_clock.c   93                 cyc = 
(rd->read_sched_clock() - rd->epoch_cyc) &
Event type: branches
Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff80008125a8e8 <sched_clock_noinstr+0x40>:
         ffff80008125a8e8:       f8756ae3        ldr     x3, [x23, x21]
         ffff80008125a8ec:       a9409666        ldp     x6, x5, [x19, #8]
         ffff80008125a8f0:       29441261        ldp     w1, w4, [x19, #32]
         ffff80008125a8f4:       d50339bf        dmb     ishld
         ffff80008125a8f8:       b9400282        ldr     w2, [x20]
         ffff80008125a8fc:       6b16005f        cmp     w2, w22
         ffff80008125a900:       54fffe81        b.ne 
ffff80008125a8d0 <sched_clock_noinstr+0x28>  // b.any
         ffff80008125a904:       cb060000        sub     x0, x0, x6
         ffff80008125a908:       2a0103e1        mov     w1, w1
         ffff80008125a90c:       8a050000        and     x0, x0, x5
         ffff80008125a910:       a94153f3        ldp     x19, x20, [sp, #16]
         ffff80008125a914:       9b017c00        mul     x0, x0, x1
         ffff80008125a918:       a9425bf5        ldp     x21, x22, [sp, #32]
         ffff80008125a91c:       a94363f7        ldp     x23, x24, [sp, #48]
         ffff80008125a920:       9ac42400        lsr     x0, x0, x4
         ffff80008125a924:       a8c47bfd        ldp     x29, x30, [sp], #64
         ffff80008125a928:       d50323bf        autiasp
         ffff80008125a92c:       8b030000        add     x0, x0, x3
         ffff80008125a930:       d65f03c0        ret
             perf 12720/12720 [0001]      5986.372298040 
sched_clock_noinstr+0x88 
...sight/linux/kernel/time/sched_clock.c   99 }
Event type: branches
Sample = { cpu: 0001 addr: 0xffff8000801bb4ec phys_addr: 
0x0000000000000000 ip: 0xffff8000801bb4e4 pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff8000801bb4cc <sched_clock+0x24>:
         ffff8000801bb4cc:       aa0003f4        mov     x20, x0
         ffff8000801bb4d0:       f9400a61        ldr     x1, [x19, #16]
         ffff8000801bb4d4:       d1000421        sub     x1, x1, #0x1
         ffff8000801bb4d8:       b9001261        str     w1, [x19, #16]
         ffff8000801bb4dc:       b4000061        cbz     x1, 
ffff8000801bb4e8 <sched_clock+0x40>
         ffff8000801bb4e0:       f9400a60        ldr     x0, [x19, #16]
         ffff8000801bb4e4:       b5000040        cbnz    x0, 
ffff8000801bb4ec <sched_clock+0x44>
             perf 12720/12720 [0001]      5986.372298040 
sched_clock+0x3c 
...ux/./arch/arm64/include/asm/preempt.h   74         return !pc || 
!READ_ONCE(ti->preempt_count);
Event type: branches
Sample = { cpu: 0001 addr: 0xffff80008030cb10 phys_addr: 
0x0000000000000000 ip: 0xffff8000801bb4fc pid: 12720 tid: 12720 period: 
1 time: 5986372298040 }
         ffff8000801bb4ec <sched_clock+0x44>:
         ffff8000801bb4ec:       aa1403e0        mov     x0, x20
         ffff8000801bb4f0:       a94153f3        ldp     x19, x20, [sp, #16]
         ffff8000801bb4f4:       a8c27bfd        ldp     x29, x30, [sp], #32
         ffff8000801bb4f8:       d50323bf        autiasp
         ffff8000801bb4fc:       d65f03c0        ret
             perf 12720/12720 [0001]      5986.372298040 
sched_clock+0x54 
...sight/linux/kernel/time/sched_clock.c  108 }

Still we miss tracing of 0xffff80008125b758, however seg-fault is avoided.
> 
>    prev_ip = cpu_data[str(cpu) + 'ip']
> 
> This means that prev_ip is sometimes the previous sample's IP only 
> sometimes (samples following 1), otherwise it's the current IP. Does 
> your fix actually require this bit? Because we already save the 'real' 
> previous one:
> 
>    cpu_data[str(cpu) + 'ip'] = stop_addr
> 
> Also normally we save ip + 4 (stop_addr), where as you save ip. It's not 
> clear why there is no need to add the 4?
> 
> 
>>>
>>>    prev_ip = cpu_data[str(cpu) + 'ip']
>>>
>>>    ... then ...
>>>
>>>    # Record for previous sample packet
>>>    cpu_data[str(cpu) + 'addr'] = addr
>>>    cpu_data[str(cpu) + 'ip'] = stop_addr
>>>
>>> Would a local variable not accomplish the same thing?
>>
>> No, We need global to hold the ip of previous packet.
>>>
>>>> +    prev_ip = cpu_data[str(cpu) + 'ip']
>>>>       if (options.verbose == True):
>>>>           print("Event type: %s" % name)
>>>> @@ -243,12 +247,18 @@ def process_event(param_dict):
>>>>       # Record for previous sample packet
>>>>       cpu_data[str(cpu) + 'addr'] = addr
>>>> +    cpu_data[str(cpu) + 'ip'] = stop_addr
>>>>       # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>>>>       if (start_addr == 0 and stop_addr == 4):
>>>>           print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>>>>           return
>>>> +    if (stop_addr < start_addr):
>>>> +        # Continuity of the Packets broken, set start_addr to previous
>>>> +        # packet ip to complete the remaining tracing of the 
>>>> address range.
> 
> After looking a bit more I'm also not sure why stop_addr < start_addr 
> signifies a discontinuity. What if the discontinuity ends up with 
> stop_addr > start_addr? There's no reason it can't jump forwards as well 
> as backwards.
> 
> Can you share the 3 samples from the --verbose output to the script that 
> cause the issue?
> 
> I see discontinuities as having the branch source (ip) set to 0 which is 
> what we do at the start:
> 
>     Sample = { cpu: 0000 addr: 0x0000ffffb807adac phys_addr: 
> 0x0000000000000000 ip: 0x0000000000000000 pid: 28388 }
> 
> Then the ending one has the branch target (addr) set to 0:
> 
>    Sample = { cpu: 0000 addr: 0x0000000000000000 phys_addr: 
> 0x0000000000000000 ip: 0x0000ffffb7eee168 pid: 28388 }
> 
> 
> And it doesn't hit objdump because of the range check:
> 
>   Start address 0x0 is out of range ...
> 
> So I don't see any missing disassembly or crashes for this.
> 
>>>> +        start_addr = prev_ip
>>>> +
>>>>       if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>>>>           print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] 
>>>> for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>>>>           return
>>
>> Thanks,
>> Ganapat

Thanks,
Ganapat

