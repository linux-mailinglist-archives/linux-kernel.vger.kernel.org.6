Return-Path: <linux-kernel+bounces-324097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E49747D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2583B1C25C14
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FADE469D;
	Wed, 11 Sep 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="P3p+AmCc"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB04A29
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018673; cv=fail; b=mM3d1HvD27ueqXYlcQgP5+Aen8RE/+diGQloZIfJPW9m+TUDiNpIG/wORsWMfe6dlRbKCuTohOm5xkZ8U292E+vEEZj1z+EdGyixagP01sQ+vIJMtcpXfi25SuitqEqrm5ekLA+0bfLXP5XDceGua7C/H4aAP19ksMmXl/NukUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018673; c=relaxed/simple;
	bh=4wZgePxK+XJGdNnzZIsr9jL5tTFOTvvC3RGkZdGFrpI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iUgtLSzkQJyinPaiEUWWWxcSddZTUwf9uExldycoG2bBOMtjX7YvU93Nq9SkWN5bQ8XV3FQo6XYodNIhaIL17i2I4oE5MBYJjRmMe7RCczKFuwlj2jvIS4uRv8dN7fuQGIJiSVFZwy30OGah/mFVYZlrIKDvf8R1o1eZtsq67kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=P3p+AmCc; arc=fail smtp.client-ip=40.107.117.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkAeGUuF4iCRPKdhtm88OuHfbaV43acWEWZ8h5dItM+qEYDnFRjKNDiiN74vWs7bU6kXb1SElpJo6DanUhd2E78B+mtMsDMDBpWb4BqKQIBQXxtk9hCadU0fTgd5x87yRcaj3v7NTygkh2nWJvQO7B9RNP/oZK3Ks9apl6K/0kuvGhSx+iar37jh8nvolV7RcbxJN5u+qu9afrW3goDAurIpkRcf3aHcGOOC0aAWRpjqeqjG2++tPhm0U6BideySrrfkGgE5/y1gHvkO335lR6XgH59acJQ6wiX57QjKYhKxlutuk7Npgft+8hSq634VcCeAw/SH91/LVW24d+/Jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wZgePxK+XJGdNnzZIsr9jL5tTFOTvvC3RGkZdGFrpI=;
 b=IzxRJu5j8rH3QY5ss/ML3Iq3LaAjRpC6/VBfBQMwD11XCbIh8MTEifJuctt6cHFm4CXzfngbRliiyiqSC3xTQi3CDicHr6owDGvhnWnMA/KM2lgcFh+vjbydvJa2qbGQjgOPgs3p6W+2ouV7kl3/tOlPzNekiobEkDDXiM00z3hYYWRSiuvpfFH8Yp8KJC9LS3n91z95CGo+gKRoBbe9kjMcfrsdvpXhsHVEKSJzep4Jneu36LIDK3od1PuM3Z3tfo2F2AKZarUP8FjS3ZZsxz5Dy83olgAjmHFQv5o+cRMutv8FOSHt0FNhhwNaeDgsS9jLynkFDODGDRRySWchgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wZgePxK+XJGdNnzZIsr9jL5tTFOTvvC3RGkZdGFrpI=;
 b=P3p+AmCcY57IQ0sidAgWa/gsZuWWJK7l56gSK0Ijg5W5wzHpMJB0xmCxb2F0r1dKa2yV02QE8M7qluP8F8D52NqsTux1Lvx1w9dKJfjPAueL8C8wmgZoN/dI2ekh/mAFiqqEZ1Gm/xEeliHBsGUwhIOicuDw62Vfu9oNat7wvA5efpdctSpW8tB/a9ojo6cp6NQS4XAVLxkzaxrZsvre8CvT8sXefkiUWn0tU8HeNeWoxwuelhwCHIVq0dv2lb+tDRGFUuNA+chET/C0B8nweuVCYaJx8uDUCg/NXTWdfNyBSXbZyseZLx+vsYAWcFtNc0uRxZb+dnISqRD8qot5aA==
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by JH0PR06MB6387.apcprd06.prod.outlook.com (2603:1096:990:18::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 01:37:46 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 01:37:46 +0000
From: shawn.shao <shawn.shao@jaguarmicro.com>
To: Jacob Keller <jacob.e.keller@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v2] lib: Export the parsing functions and related data
 structures of the PLDM library
Thread-Topic: Re: [PATCH v2] lib: Export the parsing functions and related
 data structures of the PLDM library
Thread-Index: AdsD6vFm1b0NRWqARoGlfDk/kmwwvA==
Date: Wed, 11 Sep 2024 01:37:46 +0000
Message-ID:
 <TYZPR06MB3933C05503216CFE44BAA5AD9D9B2@TYZPR06MB3933.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB3933:EE_|JH0PR06MB6387:EE_
x-ms-office365-filtering-correlation-id: 3162258d-0589-4389-66be-08dcd2025699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFJ1dkl5eDNnQjdmRk9JNVREYXlZZVJBMWRZS2dwMjh6Q2loaXFSZTJuZDJw?=
 =?utf-8?B?RUtmdDNUbGszUXViRFhBWTVnSlQvMGpGWmdHZTFSNE8rVTdtR1VBVEFVTmd0?=
 =?utf-8?B?VFRNcmlUWThndDRXOTU5djJyUkpyQy9EVkt4NUdqRW4xbnc2cTJ4ZzNMQVlz?=
 =?utf-8?B?RkRDNk5qcXIxajFsU3BXV2VSU1RmWTBZdHZsWWo1RVppdjNvK0VhUXhDV1Fl?=
 =?utf-8?B?NmhPeThtSUt5UUphWW91RStSL0Q5WHBpTnFaem94cExndWdySFVETndXWlVQ?=
 =?utf-8?B?aGlIYXloWHcvejhrRlJHMm1qOWZ2d2RLdm9hVW10N1RCUlR1OGYzSkpmd0FD?=
 =?utf-8?B?Vyt1dXFBcFhVUGwyY0dvMjBwMS9QYit1SkdMZHVxbXRLVXFhc1JZWFF6Vk9y?=
 =?utf-8?B?allGOTNidVRwQ2dLeGRweUlFb0dxNnJqVUV3blRaMG9tUHpEZHcvYXlyQ3RN?=
 =?utf-8?B?WlJaZUhZSjBDRll0ZTRTUzlVdk1kOHpEUVRueWFPNGNsT1Y1WEJrUDA5blAy?=
 =?utf-8?B?aXdYNWc4aUQ5M3ZOMFBYQ1pUODFKNTVCbTFSbG4xZStPZ21IN1ExZk9GeGNN?=
 =?utf-8?B?R2V0SC8vbzJTMTFqQkNOeFowdy9nU0IrcjdncHYyZDZneVJQL0luVUdmN0JY?=
 =?utf-8?B?Y3BEZllzV1ZJL2wwY1pXVjNTaDF1Z2VVWXViMDlEUnV6L3J5RWVoMnZCaHJ2?=
 =?utf-8?B?Z3ZDd2JLdVY5b2g0SjgvQzkvbC9IQzU5NHI1Z2dDckVqYmhMTThTSWVhRklm?=
 =?utf-8?B?TkI0S1NneStkVlZMZldOYkYzMy85VWN4dGhvVFd2WFJQT3hZYmJwQUc1VlNE?=
 =?utf-8?B?TmxnSTROT05pbFNNdU4wckJzdm9wUG44S096S2ozZE1Qc0lWMHhJQVcyK2pC?=
 =?utf-8?B?dXhGYWQwVDdlQlhvUEdQdUdUTFVmMCttZmo5Nnpsa0NSUjZnNk1idmwrMW9J?=
 =?utf-8?B?ODRzYS9VUmJVK3BGT2lJSCsweDlQdGZNZ3RQY2tZaHBvS1FHZWpzUmpZWXE0?=
 =?utf-8?B?dDU0RGRhWjdEUmY0MmJzMG5ZeXVTSzhHV2djL2hEQTBaSlRvU3ZXNGE5SGtK?=
 =?utf-8?B?WS9ab0Q2WnQ5NjFOT1V5b1ZjaWNZZzhrRkJoZkJhWlFvd3hDZjhlb3FtLzNY?=
 =?utf-8?B?Z1ltWGRLUjFxakx0ME1UWkhyTEgzS1BUSWtTM2FPSmY3UG4wLzZmUjlWdzR1?=
 =?utf-8?B?aW5qTC9tb01CSjFwTUJOZVpvT2srbTU0WXNqa3ZVcnR0V2crbWNIekpQaDcy?=
 =?utf-8?B?YXJOdmRMeFc0L0RiSkk2N0pRS0Q5d25kb2tqOEJMdVY5ZHZWR0R3YThUN0Vn?=
 =?utf-8?B?ZlpqSjVXcXROQU5pZHQyL2lUL2trMWIrSU4yZ05YenVnWXZ0NlU0MVZCT0xn?=
 =?utf-8?B?RGRURHVtYThwVnhvd1RxV3o2SzF6YkJXZ0pwM3lqZFNVWHF1NlJ6U1hOVEQw?=
 =?utf-8?B?dDY0Z1B2bDc0ZHRkc0FKc2R6VVRtc1VxUG9HdUg3M3F0aStnTjFFT3RiSDhh?=
 =?utf-8?B?YjV0UUhDYzZQQmhNYlMwWkdaNzZJb3krd2FMUTRMRStqTW9FenBjUGhWSjFs?=
 =?utf-8?B?R2FrbXhOV3NGVW11RkJhUyt4YjErQWJzTjRPbmd2YlY3RlB1aUhMRm9VMDQz?=
 =?utf-8?B?clRQRjZIY0lPU0RXemppVnh3OWhEaDNpa0h4V1NYZkxtMS9rMXBKTmJCZFdk?=
 =?utf-8?B?TlVUU3o1clo1RlgwVWw3NVA3YW9lcE9hckFBMEhXOWZyWGM2Q0haVmYrdW1i?=
 =?utf-8?B?OHdtdkRKcDdmQVRHcjJYb3I1bUJYcFhXQ3lMUURldzVSb3Y3alRwSnBSbjUv?=
 =?utf-8?B?VUlLRFlaZXlZMFV1QzZUaGJMalJwMnZ5Qk1wSkRWSi9PVXp0cUw2S1JLL0Zj?=
 =?utf-8?B?UnBNSkJUOTlDSW1CWUorSklHYW83MHhyZzl4azEvZm9aZXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVgyQVBsRjVHeUtJaHo0WWxIeFNtUkpqdWtiRXB1dVJVK3hSeUl0SytsL0JK?=
 =?utf-8?B?eHRzajZBRUtMbzlkTDVBSHJOYVcreVdlT1RkQlRWdkRDMVNGdHNlaVhjRm1B?=
 =?utf-8?B?c0lRd09xcHdLOGQ5QndOUWkxcXM3UGZhR1lwazZsQW9Cc2NHTC9hZGZiSFFa?=
 =?utf-8?B?eHljTVZ5Zk9iV3gwVUF6cTY0Y3J1Yzc5TDUzaldGY0xQYnRqSklnaWw5RytJ?=
 =?utf-8?B?dXJ0RjBrd25QQ2JQMUZTY3gvU3pQRUxOTnVLUlVCZlp4bkFQcm9yY1cwR2x3?=
 =?utf-8?B?ejdVSFVzK0VPclhQajU4Z2poam9DaDYzUHM1R0NjTCtmSXlWdG5uMHdaZlNX?=
 =?utf-8?B?WkFSUll5U1ozbGpIR1ZweXlCMGFLaHhrRit2dHdIS1N0Q2JNYW1pVSs2by9N?=
 =?utf-8?B?TU1BSTVydG9LdzRBVUhIVkp4MVRKS3pud1NOdmg1b01jMnBlWUNDT0hBNDVF?=
 =?utf-8?B?bzh2Y1BxN1RRNGQwaVdwa2M5UnhJanRGSldyUjZIeGY4cWg3eFl5RmdaK3pu?=
 =?utf-8?B?UEZvTjk4NjhITGxhYVRxYldoOHhaUUhZSHcxN1lydW5yM3AvV0tmcmR5M0pq?=
 =?utf-8?B?cm5jaCs1eVRXRHFsZjF1SGtzak5jVjNNRDh6Ri9hMWRDYVpUZ0lNTXNzUHdB?=
 =?utf-8?B?TmE2bXJlbFZ2US9XOGJML2hMeTNVN3NIVFZmZzZlK3Mvakd6djFSWmlVamIw?=
 =?utf-8?B?V3IrZFRjS3Zhc3JzRUNBS3VqQlBpS1pYVHR1OXNNQXdKUWVNU3B1OEI1eGZk?=
 =?utf-8?B?NCtyeVlrM2dwY2RsTW1ETHBXSHo2ZFNzRlo3bVlZTGtNdUt1c3VEemVqVVRZ?=
 =?utf-8?B?dkxIRDRFcS8vbW4rWDVYdUM4K0UxbncwQWcyUFZlaFRMM1FnQnhxalFqVXV4?=
 =?utf-8?B?dGFyWStZUmlvZmlMZEpyOU1MU0NrVlZLemNnUlNRRGFsaXAxbXIwVVBXb1Br?=
 =?utf-8?B?d1V3c0hJZ1kyaVhIZzZIQkE1S3Avc2tlcndSVHNodFlPWC90Q0o4VlRKRldU?=
 =?utf-8?B?QVpNVXR2RGpKOGRMRzYrN014ZUUybjBnYXl1dmdmMHMwZ1NyaEdIK0lsNTMv?=
 =?utf-8?B?OVFwa05RZFM5eHVNbkwrSjZhZnVaQmRHQTdZdTE5OTBaTTdQdklJZStXRmd0?=
 =?utf-8?B?dXJ3QWhOb2Y5MHVpcUpIRlgrRXZ2VUFmNmxQcTFOS0syUlFuVytFTzIxL2Vh?=
 =?utf-8?B?VUh6TnRhQ2tmbW9ucVoyZGdGUlVlRWJuNXdVRlZBVGUvcS8zR1F4OUNta251?=
 =?utf-8?B?cWRxYStLWUpDb00rT2FQWkZSZlJ0Ym45VWEzZGl6QytFVThTdGFoUXMyekpj?=
 =?utf-8?B?NEQ3V3VGZ3FmWmsrZVEwcUJLQTFRMVdvZXJ5RmxBeUZjQ0xtYi9NZi9PS0Y4?=
 =?utf-8?B?dE9ZdnRNd0M2VjhNS0lBT1VxWmlHc2FKbHEwM3dCSm5DVTB1Tm1ndnFidEx6?=
 =?utf-8?B?WmRmbHF6ZVpkeE9OL3RGQnkwbHhwRWVEejl5YzdVSm9ka1JIMHdyVGM0NjFT?=
 =?utf-8?B?Wk4rS0N6cS93N2VHS1V6Qkh0OW9MZ0pDNnUvMXRIVnpTQW5TQkdKeGJCK2Ew?=
 =?utf-8?B?TmhkVUliaDR4dk13WFl3WXVVdWhkdEZyS2hNVjlRVTRPd0JhYkplSjdqVTlD?=
 =?utf-8?B?QjBoKzJTMmcwZkR6QkdXQ1dreVhERVF3SVhBR1lpQjFQRmxVMUR0N0I1NFo5?=
 =?utf-8?B?NVUxbDJsWk9LUGhWb1VuZEgrZEdBcjYreVROYVozbUtLeUQwNlJCRGo2bHZh?=
 =?utf-8?B?Y1ZkblQ4dEdBYnoyRmY4MnF2Z08xVFlhU1ljdXVJelViU2dBb29hOExLakEz?=
 =?utf-8?B?NWY1T2hSNnRTRThINGpnWnEydHlma2NQNXJFa21RTzgweGIrdkNPQklXNU5W?=
 =?utf-8?B?M3hqeWtxSXdaYUdISnJ4SzdZdVNPQ3dTeGFldXdoeFQ1R3E3bVh2ZDhOQWxX?=
 =?utf-8?B?SFZLN3VpUzV0UklDR0diRS9UVjh1T3JMWCtIeW9ZcEZ6S0NqY0s5TjIvY25M?=
 =?utf-8?B?NXhuMmhsRmdPSHdCTndQaWsxQ2VDamM5KzRlSWpFaXhiUytzR1FJZGpwdHNP?=
 =?utf-8?B?b2hFRk9QV3M3bk9XMlVHRnJ5by9RWjU4V3Z0S0F2b29kY1pjSHlVRXdUTGhr?=
 =?utf-8?Q?cJ/e1J1jyFrBO9U/03omFGmwN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3162258d-0589-4389-66be-08dcd2025699
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 01:37:46.4067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbiSR4cPCt36uG9g7+j+fUtVFHlhJHY5i7zDENZaRJ9AD+xypbReO+DxbbRBhOCuFECF/p3mmHKWvl3tm8YKsU+b6FnYjnE4x7nLWadbqjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6387

PiBPbiA5LzkvMjAyNCA3OjA4IFBNLCBzaGF3bi5zaGFvIHdyb3RlOg0KPiA+Pj4gT24gOS85LzIw
MjQgMTI6MTcgQU0sIFNoYXduLlNoYW8gd3JvdGU6DQo+ID4+PiBGcm9tOiBTaGF3biBTaGFvIDxz
aGF3bi5zaGFvQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPj4+DQo+ID4+PiB2MSAtPiB2MjogVXBkYXRl
ZCB0aGUgY29tbWl0IG1lc3NhZ2UsIGFkZGVkIGEgZGVzY3JpcHRpb24NCj4gPj4+ICAgICAgIG9m
IHRoZSBjaGFuZ2VzIHJlbGF0ZWQgdG8gYERldmljZVVwZGF0ZU9wdGlvbkZsYWdzYCwgZXRjLg0K
PiA+Pj4NCj4gPj4+IFRoZSBQTERNIGxpYnJhcnkgaXMgdXNlZCB0byBpbXBsZW1lbnQgZmlybXdh
cmUgdXBncmFkZXMsDQo+ID4+PiBidXQgdGhlIGN1cnJlbnQgbGlicmFyeSBmdW5jdGlvbnMgb25s
eSBzdXBwb3J0IHRoZQ0KPiA+Pj4gYHBsZG1md19mbGFzaF9pbWFnZWAgZnVuY3Rpb24gdG8gY29t
cGxldGUgYSBmaXhlZA0KPiA+Pj4gcHJvY2VzcyBvZiBwYXJzaW5nLCBzZW5kaW5nIGRhdGEgdG8g
dGhlIGJhY2tlbmQsDQo+ID4+PiBhbmQgZmxhc2hpbmcgKGFsbG93aW5nIHVzZXJzIHRvIGltcGxl
bWVudCBjdXN0b20NCj4gPj4+IGxvZ2ljIHVzaW5nIGBwbGRtZndfb3BzYCkuIEhvd2V2ZXIsIHRo
aXMgcG9zZXMNCj4gPj4+IHNpZ25pZmljYW50IGNoYWxsZW5nZXMgZm9yIGRldmljZSB2ZW5kb3Jz
IHVzaW5nDQo+ID4+PiBQTERNIGZvciBmaXJtd2FyZSB1cGdyYWRlcy4NCj4gPj4+IFRoZSBmb2xs
b3dpbmcgc2NlbmFyaW9zIGFyZSBub3Qgc3VwcG9ydGVkOg0KPiA+Pj4gMS4gT25seSB1c2luZyB0
aGUgUExETSBwYXJzaW5nIGZ1bmN0aW9ucywgYXMgdGhlDQo+ID4+PiAgICBjdXJyZW50IGxpYnJh
cnkgZG9lcyBub3Qgc3VwcG9ydCB0aGlzIG9wZXJhdGlvbi4NCj4gPj4+IDIuIFRoZSBmaXJtd2Fy
ZSB1cGdyYWRlIHByb2Nlc3MgZGlmZmVycyBmcm9tIHRoaXMNCj4gPj4+ICAgIGZpeGVkIGZsb3cg
KHRoZSBmaXJtd2FyZSB1cGdyYWRlIHByb2Nlc3MgbWF5DQo+ID4+PiAgICB2YXJ5IGFjcm9zcyBk
aWZmZXJlbnQgdmVuZG9ycykuDQo+ID4+PiAgICAgICB8LT4gcGxkbWZ3X2ZsYXNoX2ltYWdlDQo+
ID4+PiAgICAgICAgICAgICAgIHwtPiBwbGRtX3BhcnNlX2ltYWdlDQo+ID4+PiAgICAgICAgICAg
ICAgICAgICAgICAgfC0+IHBsZG1fcGFyc2VfaGVhZGVyDQo+ID4+PiAgICAgICAgICAgICAgICAg
ICAgICAgfC0+IHBsZG1fcGFyc2VfcmVjb3Jkcw0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAg
IHwtPiBwbGRtX3BhcnNlX2NvbXBvbmVudHMNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAt
PiBwbGRtX3ZlcmlmeV9oZWFkZXJfY3JjDQo+ID4+PiAgICAgICAgICAgICAgIHwtPiBwbGRtX2Zp
bmRfbWF0Y2hpbmdfcmVjb3JkICh4eHhfbWF0Y2hfcmVjb3JkKQ0KPiA+Pj4gICAgICAgICAgICAg
ICB8LT4gcGxkbV9zZW5kX3BhY2thZ2VfZGF0YQ0KPiAoeHh4X3NlbmRfcGFja2FnZV9kYXRhKQ0K
PiA+Pj4gICAgICAgICAgICAgICB8LT4gcGxkbV9zZW5kX2NvbXBvbmVudF90YWJsZXMNCj4gPj4g
KHh4eF9zZW5kX3BhY2thZ2VfZGF0YSkNCj4gPj4+ICAgICAgICAgICAgICAgfC0+IHBsZG1fZmxh
c2hfY29tcG9uZW50cyAoeHh4X2ZsYXNoX2NvbXBvbmVudCkNCj4gPj4+ICAgICAgICAgICAgICAg
fC0+IHBsZG1fZmluYWxpemVfdXBkYXRlICh4eHhfZmluYWxpemVfdXBkYXRlKQ0KPiA+Pj4gMy4g
VGhlIGN1cnJlbnQgUExETSBsaWJyYXJ5IGRvZXMgbm90IHN1cHBvcnQgcGFyc2luZyB0aGUNCj4g
Pj4+ICAgIERldmljZVVwZGF0ZU9wdGlvbkZsYWdzIHBhcmFtZXRlciwgd2hpY2ggaXMgZGVmaW5l
ZCBpbiB0aGUgUExETQ0KPiA+Pj4gICAgc3BlY2lmaWNhdGlvbiB0byBmYWNpbGl0YXRlIHRoZSB0
cmFuc2ZlciBvZiBjb250cm9sIGluZm9ybWF0aW9uDQo+ID4+PiAgICBiZXR3ZWVuIHRoZSBVQSAo
VXBkYXRlIEFnZW50KSBhbmQgdGhlIGZpcm13YXJlLlBsZWFzZSByZWZlciB0bzoNCj4gPj4+ICAg
IGh0dHBzOi8vd3d3LmRtdGYub3JnL3NpdGVzL2RlZmF1bHQvZmlsZXMvc3RhbmRhcmRzL2RvY3Vt
ZW50cw0KPiA+Pj4gICAgL0RTUDAyNjdfMS4zLjAucGRmIFAzNy4NCj4gPj4+DQo+ID4+DQo+ID4+
IFRoYW5rcyEgSSdkIHByZWZlciB0aGUgRGV2aWNlVXBkYXRlT3B0aW9uRmxhZ3MgdG8gYmUgc2Vw
YXJhdGUsIGJ1dCBJDQo+ID4+IHRoaW5rIHRoZSBjaGFuZ2VzIGFyZSBnb29kLg0KPiA+Pg0KPiA+
PiBSZXZpZXdlZC1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+
ID4NCj4gPiBGaXJzdGx5LCB0aGFua3MgZm9yIHlvdXIgcmVwbHkgYW5kIGd1aWRhbmNlIHNvIHF1
aWNrbHkuDQo+ID4NCj4gPiAxLiBJIHdpbGwgc2VwYXJhdGUgdGhlIGRldmljZV91cGRhdGVfZmxh
Z3MgaW50byBhbm90aGVyIHBhdGNoIGZvciBzdWJtaXNzaW9uLA0KPiBhcyB5b3Ugc3VnZ2VzdGVk
Lg0KPiANCj4gQXBwcmVjaWF0ZWQsIHRoYW5rcy4NCj4gDQo+ID4gMi4gSSBoYXZlIGFub3RoZXIg
cXVlc3Rpb24gSeKAmWQgbGlrZSB0byBhc2sgeW91LiBGb3Igc3VwcG9ydCBvZiBoaWdoZXIgdmVy
c2lvbnMNCj4gb2YgdGhlIFBMRE0gbGlicmFyeSwgdmVyc2lvbiAyLjAvVmVyc2lvbiAzLjAgc3Vw
cG9ydHMNCj4gQ29tcG9uZW50T3BhcXVlRGF0YS9Db21wb25lbnRPcGFxdWVEYXRhTGVuZ3RoYCwg
YW5kIHJlcXVpcmVzDQo+IGFkanVzdG1lbnRzIHRvIHRoZSBgX19wbGRtZndfY29tcG9uZW50X2lu
Zm9gIHN0cnVjdHVyZS4gSSB3b3VsZCBsaWtlIHRvDQo+IGNvbnRpbnVlIHN1cHBsZW1lbnRpbmcg
dGhpcyBhZGp1c3RtZW50KHN1Ym1pdCBvdGhlciBwYXRjaGVzKS4gSeKAmW0gbm90IHN1cmUNCj4g
aWYgeW91IGFncmVlIHdpdGggdGhpcywgdGhhbmsgeW91Lg0KPiA+DQo+IA0KPiBJJ20gbm90IG9w
cG9zZWQgdG8gZXh0ZW5kaW5nIHRoZSBsaWJyYXJ5LiBIb3dldmVyLCB3ZSBuZWVkIHRvIGJlIGNh
cmVmdWwNCj4gdGhhdCBhbnkgY2hhbmdlcyBkbyBub3QgYnJlYWsgZXhpc3RpbmcgZmlsZXMuIERv
IHRoZSBuZXcgZmllbGRzIGNvbWUgYXMNCj4gcGFydCBvZiByZXNlcnZlZCBzZWN0aW9ucyBvZiB0
aGUgcHJldmlvdXMgZGF0YSBzdHJ1Y3R1cmVzPyBPciBkbyB3ZSBuZWVkDQo+IHRvIGlkZW50aWZ5
IHRoZSBmaWxlIGZvcm1hdCB2ZXJzaW9uIGFuZCB1c2UgYW4gYWx0ZXJuYXRpdmUgc3RydWN0dXJl
IGZvcg0KPiBuZXdlciB2ZXJzaW9uPyBPciBpcyB0aGlzIGRhdGEgc29tZXRoaW5nIHRoYXQgd2Fz
IGFscmVhZHkgdGhlcmUgd2hpY2ggbXkNCj4gbGlicmFyeSBjb2RlIHNpbXBseSBpZ25vcmVkPw0K
PiANCj4gSXQgbG9va3MgbGlrZSB0aGlzIGlzIGFsc28gZnVydGhlciBjb21wbGljYXRlZCBiZWNh
dXNlIHRoZSBleHRyYSBvcGFxdWUNCj4gZGF0YSBpcyBpdHNlbGYgdmFyaWFibGUgbGVuZ3RoIGFu
ZCBmb2xsb3dzIHRoZSB2YXJpYWJsZSBsZW5ndGggdmVyc2lvbg0KPiBzdHJpbmcuDQo+IA0KPiBJ
IHRoaW5rIHRoaXMgd2lsbCBiZSB0cmlja3kgdG8gYWRkLCBidXQgd2Ugc2hvdWxkIGJlIGFibGUg
dG8gdHJlYXQgaXQgYXMNCj4gYSBzZXBhcmF0ZSBzdHJ1Y3R1cmUsIG1heWJlIF9fcGxkbWZ3X2Nv
bXBvbmVudF9pbmZvX29wYXF1ZV9kYXRhLCBhbmQNCj4gd2UNCj4gY2FuIGNoZWNrIGZvciBpdCBi
YXNlZCBvbiBzb21lIHNvcnQgb2YgdmVyc2lvbiBmb3JtYXQgaW4gdGhlIGhlYWRlcj8gV2UNCj4g
Y2FuJ3Qgc2ltcGx5IGFwcGVuZCB0byBfX3BsZG1md19jb21wb25lbnRfaW5mbyBiZWNhdXNlIGl0
IGFscmVhZHkgaGFzIGENCj4gdmFyaWFibGUgbGVuZ3RoIHN0cnVjdHVyZS4NCj4gDQo+IEFzIGxv
bmcgYXMgY2FyZSBpcyB0YWtlbiB0byBlbnN1cmUgdGhhdCBleGlzdGluZyBmaWxlcyBkbyBub3Qg
YnJlYWssIEkNCj4gc2VlIG5vIGlzc3VlcyB3aXRoIHN1cHBvcnRpbmcgdGhlIGFkZGl0aW9ucyBv
ZiBmdXR1cmUgdmVyc2lvbnMgb2YgdGhlDQo+IHN0YW5kYXJkLiBIb3BlZnVsbHkgdGhlIFBMRE0g
c3RhbmRhcmRzIGJvZHkgcHJvcGVybHkgaW1wbGVtZW50ZWQNCj4gdmVyc2lvbi9mb3JtYXQgaW4g
dGhlIGhlYWRlcj8NCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhlcmUgaXMgMHgxIGZvciB0aGUgaW5p
dGlhbCAxLjAgcmVsZWFzZSwgYW5kIHRoZW4gMHgyIGZvcg0KPiB0aGUgRG93bnN0cmVhbSBEZXZp
Y2VzIHN1cHBvcnQsIGFuZCAweDMgZm9yIHRoZSBjb21wb25lbnQgb3BhcXVlIGRhdGEuDQo+IA0K
PiBXZSBjdXJyZW50bHkgb25seSBzdXBwb3J0IHJldmlzaW9uIDB4MSwgYnV0IGV4dGVuZGluZyB0
aGlzIHNob3VsZG4ndCBiZQ0KPiB0b28gdHJpY2t5LiBDYXJlIHdpbGwgaGF2ZSB0byBiZSB0YWtl
biB0byBlbnN1cmUgdGhlIGNvZGUgaXMgc3RydWN0dXJlZA0KPiB0byBtaW5pbWl6ZSBleHBvc2lu
ZyByZXZpc2lvbiBjaGFuZ2VzIHRvIGFzIGZldyBwYXJ0cyBvZiB0aGUgcGFyc2luZyBhcw0KPiBu
ZWNlc3NhcnkuDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgaW50ZXJlc3RlZCBpbiB0aGUgbGlicmFy
eSENCj4gDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgZ3VpZGFuY2UgYW5kIHN1Z2dl
c3Rpb25zLg0KDQo+ID4gUGxlYXNlIHJlZmVyIHRv77yaDQo+ID4NCj4gaHR0cHM6Ly93d3cuZG10
Zi5vcmcvc2l0ZXMvZGVmYXVsdC9maWxlcy9zdGFuZGFyZHMvZG9jdW1lbnRzL0RTUDAyNjdfMS4N
Cj4gMi4wLnBkZiBQNDINCj4gPg0KPiA+IFRoYW5rIHlvdSB2ZXJ5IG11Y2jvvIENCg==

