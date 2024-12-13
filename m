Return-Path: <linux-kernel+bounces-445659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A02889F192A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D28B163CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F361195B1A;
	Fri, 13 Dec 2024 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hvFuhEE6"
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020081.outbound.protection.outlook.com [40.93.198.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E01990D3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129305; cv=fail; b=pjeAeoHS5VewdtE/ArPP1HxyhXfto8ZQcuuv42G9r1gQlpXdzVkpoDPdvTjJIHN7F20AMY6zRuPtNwbTwhuQtNtqyzvbdWfwkBlKEvG2VpluSo6z7OaUHv+rFeuft95uQLjbWkmFm8u2uV+UbTotTSqQqh4aDTiDit0yafHYHws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129305; c=relaxed/simple;
	bh=60utX+c3A70Mk8OX88nKOXNVyInLBr8ZAQ1U6vyGWFI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HwSr6jl+QoZI5USdDXKJ2oAguqU/XgJEJyW1zVOp0PRxLUJnFsiFodettTyfI1l2G/WyjozpAFp1pUV16AJ5VR1MNXVyFeBCnc8jEJypDN2vTGBzzJF9pcQ+HTeISsvtNItFLWL9mSOu5W1zGhz5Aqxp2zw4lZDwduhQJ2iwfaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hvFuhEE6; arc=fail smtp.client-ip=40.93.198.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3MQhBQiBgnPvXeYLAWH7ulkfXKvoLRYqWjV7d54DO8bOFLI0XEJFag/REVUZXl5YTAT7bBuZwGXyhOdNZJOXxGj8VqAP3QwSh0BA3fDtDlL6dgdJ7ezan3kE1/CMrdaw+6XVcWQHyY6NWkrP1D/ReZmU32aUU40lP+Mj+Onx6uBxiiKKWBdo8IjOSkDltWwEQ01Xr/84s3/XcnGB1Wb0jeEfvS//MHP/avBms0nINihvpt0Qd6uYBecWGS5mspnC7YObZnv8dOqDY8bsVNoGUQAlFuZNMzkvjQDtY7kv7BEzJz41jUJ/AjZ3UHfc19Jhh4aj0C89x+nCzURlCwndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9cdx4s0AAa4O5SM13Z3i/oZDeXDWbIBAQPl+zoASdM=;
 b=XNkee8O8ZeJTVB05nK1hjpAIAa7K/7bOqKYW+BoPpHWvfE36y9owzmkYWty9KGTesPogcmDl3poMOCxFpCt+WnuuDohfsQRt5MDz9Dqjqt3bwyIpWSUBNCqey/czLfownVvah0ovA7KS4m/XaBfyh3H0i8AMjkFyaYuZiQO/F5jpzZUfWOXDS7QFiJs1PTg2IN2Cu3he9ioi/kL/a3clxVhpKJi1wwnlJukFs/Kg92dW9mmujmqFkSF9FXKT94+1/tsPkHw/ZnNUpuIwWM0lmTPhH8rObWA9O9skXKlzwxbCjUJUg7kuIx6/T7+ntnm+rFGKAjEEyM/+/0i4v+sQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9cdx4s0AAa4O5SM13Z3i/oZDeXDWbIBAQPl+zoASdM=;
 b=hvFuhEE61FIgBIqWp4ed1QLaArJJboueM7O1gFqeNopefbdrm30rp3coYE54MJTMkDGNtW4SPt6+Es9e515/KxQu5nG1876SHew7k8BCKtWeOPr7aO23JO+D8xRFoDuF1GPBBCX5ThuTKZn9PyuxYKqdDcLqpWcxEq3avNAS5ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH5PR01MB8909.prod.exchangelabs.com (2603:10b6:610:20e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.12; Fri, 13 Dec 2024 22:35:01 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8272.005; Fri, 13 Dec 2024
 22:35:01 +0000
Message-ID: <21e72a5d-d488-4011-9abc-9f717e1c6643@os.amperecomputing.com>
Date: Fri, 13 Dec 2024 14:34:57 -0800
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [RFC PATCH v1 2/5] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, corbet@lwn.net, maz@kernel.org,
 oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
 liunx-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvmarm@vger.kernel.org
References: <20241211154611.40395-1-miko.lenczewski@arm.com>
 <20241211154611.40395-3-miko.lenczewski@arm.com>
 <20241211210243.GA17155@willie-the-truck>
 <20241213161726.GA30314@mazurka.cambridge.arm.com>
Content-Language: en-US
In-Reply-To: <20241213161726.GA30314@mazurka.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29)
 To CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH5PR01MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 410db9eb-5b44-478c-4fd5-08dd1bc66170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXRVWi8xMEZ5TWFkbTFmVmtranhuZFVxT1VFTWZtayt4Y3FLRERTSUREcEJG?=
 =?utf-8?B?OTRSQmpUQVVsekM5elNId0gyb3p4RXZrN3NXNEVWY3FvZ0NvZlhaQjRHNVVN?=
 =?utf-8?B?VkRRTUdkamNrbWpraUxmSE1WNjBRY0hUdXFPTVp3L1J5ZHMxUThidnFuT3lH?=
 =?utf-8?B?RDFhUVZCcUcxRXAwdmtYQW9CYVZzR0RMb0pCM2UweFBUY256STc2cTVnYkFu?=
 =?utf-8?B?dUp3Umpac2pxTkRJZkhGRGdXdlpJd3pTUmhhVkl3U1dUY2JWVEU1OTd3OC9V?=
 =?utf-8?B?emVOK0wwWm1WNmpsWUtEU2g0KzVIdUdqUWNheVJzd2tLT1FCdHQ1cEZQVWl6?=
 =?utf-8?B?Wm1EWUIrWVpqR3JGaUdTOGFKblVEZGtTUTBVdkRtb1VoT1JuZFFPU2x1NUdB?=
 =?utf-8?B?ODFjR0VlblRBd1c1NTlzRG5XT2xEa281RHlBOXJNN0ozciswVDB3ZitneVJW?=
 =?utf-8?B?MEJlR0pYQmdFN0NZOFNYeVpxQ3JGNHRFZFU5M1VsNXVXZ2xmTEpsd29rK3ow?=
 =?utf-8?B?Ym1oSGg0UUh2OVkwOWxlRU5UTE1QTW44L2N2ME1aWWlyTjVldW45OTBtWmNm?=
 =?utf-8?B?dkIrVHRPNGhFYjNKMnJvU3FYakd1d2YraGpkeU41RnhBaHNyOFhvaHZBcW5l?=
 =?utf-8?B?UmNLOGc3bGVsekJ1WWxIUGxOZnNLcVlITmFPYXFtZVZTUWlWQXdobENVcGFq?=
 =?utf-8?B?YTV5eFkvNGxsZlU0dEFpNzkvU0R5NnVQZE12VXd4dDhkY1EveVVDVXdVcmNo?=
 =?utf-8?B?L01LMVdwNk5ndFJFZHVSV1g4SEJsVDhBQXRpU3BUMkNRT1c5clNUbVQ1M1NP?=
 =?utf-8?B?UHdJZE9WQ2d3UFFaK1MweGpJcTFZSjkxem1KSjJLS09jaGIxSmNVaXJCU3Iw?=
 =?utf-8?B?MkxITFRZUS9lSWJucmNDTUtsSXZsRzZyR3lzKzdaL0d3WWYrNDNuOFU0QkFP?=
 =?utf-8?B?S2szK092MkQ2L2FidlYzNFVrdjR3N2NxeDd4bXNLWU8xdndLMWlyWXB5RVZ3?=
 =?utf-8?B?eE1PZGV5Tzlid0UybTNraExtZitOdFkzSlM2TXlHQWdxd1Q1MTZTY0pOWXVX?=
 =?utf-8?B?Mk9Cd1NZM3UxeFJxWGNZMkZDV0pMOWRUaHlLNEF1TWhlNjdScnJtOXRuc0ZP?=
 =?utf-8?B?ZXNVZXRIUUVvMXkrdzlHU1MweUdyTGp1Rm5pYS9CUEZ1YTNZYWVJWm9kV2hZ?=
 =?utf-8?B?U25KSjh5emdSTytCNDhGS2Y1UXk0RzNEdVE3WGJGUmpDak1iZitFbFNyeHBN?=
 =?utf-8?B?SlR0NEFiVVBOc2ZJSWwrMGVCTThTZ2NyN1VybHRyei9Ud21KMmdiNk4yT3F6?=
 =?utf-8?B?cWFvbHFWQTh4dG15Q2tFcEZ1OG1XbEhtWjk0OUprRTBzSFBXQnMvTGhPaGlS?=
 =?utf-8?B?amhsZEZBaDl3cDgwU2tvOU9RRFZUSmZrbDZXMDJyUWN2VUZUOW5HRDRpbXo4?=
 =?utf-8?B?TjduY1dOaFlDUTY2bWFtbW5jWHJtUnZjdXRHWEhYOTNKN20wbWRNK2wrNTYw?=
 =?utf-8?B?TFdKNldXUmJ0Q3pNc1ViMkRDVm9EenZvVDRKVWV4elM4MDZkVkNDbERvVTRa?=
 =?utf-8?B?bGRxNVdoOElIUzl2YUV4Q254ejRoeExLc0xScndLb1psb0ZrTWdPQ3IvOVB5?=
 =?utf-8?B?dmtSTHJZMnJmWXlFWk5VVEJIV1BTN3V4cXRONytJakNvdlIzYWNTQWhBOXhK?=
 =?utf-8?B?MFRraStrS05scml0dkhuUUdrNXNGNG5KOHNPbVpZeWVFbVlTcTI0QW03eUU1?=
 =?utf-8?B?WUlkVm1Kd2x2eTJpK0tMRXBXM203WUN2elJkNjk2YUZISDd4NHJFY3dkTVZs?=
 =?utf-8?B?QnZjTVJrUmtIakpFaGpXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXFUd2FhWGlFamJBNDZJSmpQV1NMd3UrTEo3cnlvR2M2cXNCK1JZa29RNUZa?=
 =?utf-8?B?RmhGaUVyL2JjS3ZCNmh2czZsL25Mbzk5UTA1RU16OGxGQzN4RWZkV1ozQnJJ?=
 =?utf-8?B?eHhsaGg3d3N6cEFKNWhxSUtTU2lmSk0xdWFvZHRlWlJyUnVXNXZVTkJWbGdF?=
 =?utf-8?B?aFo5UytTY3JrQVlYZHpITUk4Mll2WjlZT242ODJhMkJuWkVjcXFDdE9xMGZN?=
 =?utf-8?B?WmRNNUkyVDViNWRPWkd6czJKSHBSenE0eFE4cGRUdjBHRTFTRFV6cGRIQXFE?=
 =?utf-8?B?QUVnVlR2bHJveXo3SWxPQytVaEpHeXpNYXVGWnN2MVBGMDcxSmFjRmcvUGFi?=
 =?utf-8?B?ZjBjQjRKSnNhbUxUa2ZCNnJlN093SHRzVXpua3Qrd1pOUEFkZFFOS3ZLTENI?=
 =?utf-8?B?ZU9jYjNoemxqZVBIOHBYNnI4WGc0TTBLYmhSYUFUUTlzaDJqUW5FeGVBSyt4?=
 =?utf-8?B?YTdCdGhnL2FZdTltWUROc3dQZmJPYmJDNkMvTlNIcTR6WGdWQzJFaWZwRUVV?=
 =?utf-8?B?eWdMYlRCbnhVVlM1SXNrM284dzBmRklJZmxDUEUyQXU2YTF0NnNiWnIzck9p?=
 =?utf-8?B?bUVWZk54eURpT2Z3bHhHYm1HZXBUendobFNjbWhDSkZBdlNKcERERk1KTGZy?=
 =?utf-8?B?STVBM1pmaFdGV1FYNmRkRllhakhkb24wZ3lQeXFnQUthOHcyTzBoVkNocWlj?=
 =?utf-8?B?TGdsbXREbnorREJRa3FJeXU1emYzWUhpMElsZ280bzFxSHFLWW1zWU0zQzF1?=
 =?utf-8?B?V3QvYlZ3SDVPdEdLdXE3T1JFdHVJUW4zbHNoend5dGlWZjBZK3VzMXl3QnlF?=
 =?utf-8?B?VFpPbEVrTzU3Ti9YN2RRRmlLdDdReEpvMjEzUDVxOGdNZzF6dk0rc0trdktm?=
 =?utf-8?B?UkJtV1JsN0VsN215amRXdWcxM1I0QW9OTEhnNkRJN3cvbkdiOUU4V1BYTERB?=
 =?utf-8?B?WHcwMnNRaHJuZlF3TTdxY3dWN2dRZGxRdzlqRjc0NE83N2tEMmxEbW9mM0V5?=
 =?utf-8?B?dWsxVGtLT3NXNHc3NVJQNkZXazNtUWtHT0Yzb2I1bVkweDJpaTBKdHFQS2pv?=
 =?utf-8?B?Y2xuQUpxaWE2VkhxS0FmSmc3NitFVkdlNkhEWGFyWE9hVXVDZFJMR09LdHZR?=
 =?utf-8?B?Rkt2aG5RZWdaaEJZVGwySkpETU9UU2l0ZmEwU2EwaXRycVVCR25FRGYzQUhB?=
 =?utf-8?B?RGs3RUQyQnUzTTFJU2VSeTMxMmVob3BuYlgxZVdOVVZkeWNpaGt3SkRNeWpn?=
 =?utf-8?B?aE9ieU9TTFQ1eXdUd2hOZlZZcFIyd2RVSEt2R1l3aWFTa1NUQjJXVXMvVUhj?=
 =?utf-8?B?ZEprQjhDOW16TkUyOVNlTkdDeTFQOEp2MG5ZdFY4S2hRblBNZXdSSk9aWE5Z?=
 =?utf-8?B?SllNZWZCMCsreUd5OFY1SHkxV21LSTU2ZUJ2NUp0OERHYzh5bE9lWFgxRlZI?=
 =?utf-8?B?MzAreDZXczlOS2pxMjQxOThZUTl5dFBVcWJoRm9jTnhJRXBMN0dTTW4vVkdS?=
 =?utf-8?B?dXBEZCtReTErODN5RmlYd2dPbEt1elBwZVIyL1ZzOXZRcW43QS90a2pBR1VV?=
 =?utf-8?B?YWlVc000N3dEN3JVSUJDdGxpRFYvZEd0RUo2aWo0cVJDUGpkck0zOXI1d1c2?=
 =?utf-8?B?ZEhVMkNTSTlySDU1RFBNMnlNaS9OUWZGZWloQ3VJTXdlUk9CcFNVS0ZFalBo?=
 =?utf-8?B?RlN3MFQ2TnR1Q0VreVh1eWN3TmUrOVFxczQ1TmI4cDZxd2lPVmxFQUM2SFRu?=
 =?utf-8?B?elUxZ0hEYzczMS9BTXYwYVN1WllOdElYSkc3OVoyL3NESTJKdGRDWUdQMnBU?=
 =?utf-8?B?a21sVFVvR254TFhkVzY5UFZ0dE9CTmZiL3dVRWx6RHlHdVZObDg3b0p0Nkxi?=
 =?utf-8?B?TjlJUzhVa0tOQVpFNnd4UnlTYWV5MlJzRjh5ZXM3QUR1Mm1aaGlnMU9oaVJW?=
 =?utf-8?B?WjlTdnpmU1l1eUsvQ3dKd3dXaGcxZFJiREVQZXdhbDdKWGJMeGFXSEo3dlFa?=
 =?utf-8?B?NXk4c1lCTmdYbWFGUXBoRW9zOS9Kd3drM2w0WWVxNFdNK2swc3ZFSEpMZ0dP?=
 =?utf-8?B?TXlnSzZhL0plT0NVTXBHV005R1VCbXl6dEdab0VzRXpUWkVRMnBha1V0c0hG?=
 =?utf-8?B?djkwbC9LUkNEd3Rxa3c2ekEzakdMUWQvazJMZ0JFT2toQWhoNzdLbk5US0Fj?=
 =?utf-8?Q?+nmg4wgC/kFWy64oH0hHt1E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410db9eb-5b44-478c-4fd5-08dd1bc66170
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 22:35:01.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMgMbeTf7ttsjFwiKU7qUVZytvR8rlU8qwpmEfZq1mVBtm6CBx/H5iEsUOaURjQQrotIzM6UPKgknHH6LG3xNovJAl18NiVUnm4CF3ZRchw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8909



On 12/13/24 8:17 AM, Mikołaj Lenczewski wrote:
>>> +static int do_conflict_abort(unsigned long far, unsigned long esr,
>>> +			     struct pt_regs *regs)
>>> +{
>>> +	if (!system_supports_bbml2())
>>> +		return do_bad(far, esr, regs);
>>> +
>>> +	/* if we receive a TLB conflict abort, we know that there are multiple
>>> +	 * TLB entries that translate the same address range. the minimum set
>>> +	 * of invalidations to clear these entries is implementation defined.
>>> +	 * the maximum set is defined as either tlbi(vmalls12e1) or tlbi(alle1).
>>> +	 *
>>> +	 * if el2 is enabled and stage 2 translation enabled, this may be
>>> +	 * raised as a stage 2 abort. if el2 is enabled but stage 2 translation
>>> +	 * disabled, or if el2 is disabled, it will be raised as a stage 1
>>> +	 * abort.
>>> +	 *
>>> +	 * local_flush_tlb_all() does a tlbi(vmalle1), which is enough to
>>> +	 * handle a stage 1 abort.
>>> +	 */
>>> +
>>> +	local_flush_tlb_all();
>>> +
>>> +	return 0;
>>> +}
>> Can we actually guarantee that we make it this far without taking another
>> abort? Given that I'm yet to see one of these things in the wild, I'm
>> fairly opposed to pretending that we can handle them. We'd be much better
>> off only violating BBM on CPUs that are known to handle the conflict
>> gracefully. Judging by your later patch, this is practically keyed off
>> the MIDR _anyway_...
>>
>> Will

Hi Mikołaj,

> Thanks for reviewing. Apologies for the delay in responding, and for
> spam (replied instead of group-replied).
>
> There should not be an option to take another fault while performing the
> handler, as long as the mappings covering the fault handler table or any
> code in this path are not screwed with. This is discussed further in the
> resent patch series [1].

Will lead me to this thread when we discussed about my series 
(https://lore.kernel.org/lkml/20241211223034.GA17836@willie-the-truck/#t). 
My series tried to use large mapping for kernel linear mapping when 
rodata=full. The common part of the both series is BBM lv2 support. My 
series depends on BBM lv2 to change page table block size when changing 
permission for kernel linear mapping.

Handling TLB conflict should be ok for your usecase since the conflict 
should just happen in user address space. But it may be not fine for my 
usecase. At least the TLB conflict handler needs to depend on 
CONFIG_VMAP_STACK otherwise the kernel stack pointer points to kernel 
linear address space. I'm not quite sure whether there is any other 
corner case which can trigger recursive abort in the path or not, maybe 
bad stack handler? So Will suggested MIDR based lookup. IIUC, he 
suggested just enable BBM lv2 support on the CPUs which can handle TLB 
conflict gracefully. This should make our lives easier. But the downside 
is maybe fewer CPUs can actually advertise BBM lv2 support.

Thanks,
Yang

> The MIDR revisions will be fixed. I was confused as to which revisions
> were affected on an earlier version of the series, and had missed
> updating them. The kconfig workarounds should be correct in this regard.
>
> [1]:https://lore.kernel.org/all/084c5ada-51af-4c1a-b50a-4401e62ddbd6@arm.com/
>


