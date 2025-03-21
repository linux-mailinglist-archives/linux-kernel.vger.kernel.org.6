Return-Path: <linux-kernel+bounces-571043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB1CA6B83F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18358188F2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BAA1F151A;
	Fri, 21 Mar 2025 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="gGjXUZSM"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9294182B4;
	Fri, 21 Mar 2025 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551091; cv=fail; b=hk9M5JOrbPPvbqCLPVixVTpn64+MkTR08DqvTLzm0eafnB1qFDLniRVv8spCUmrsCQBv3J2qHrS3mvOTLUzvP8Y6OnfTVlX44pu1My4+zulaGTujxsQuXjdrnhtGMWn3G0Meni8mdiGGwISqSM4Uf+RbBTuDA4KRJUWOiWFujT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551091; c=relaxed/simple;
	bh=NVzDQDKib3XIwmT7N6OzOhehTkYg8yLTG3OMQil/9+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DAtZoxN5Rc4dSKCfx2zWGTQs6KKA/sW3L1Rz7WB3YGopSxvNvXJxNFO8ahiqRjW34Kd9JaEX2Nl9Anur8HNzPAxOxMBVMu8uS1jJUkXDklSKzko+UnpRTFSZ6lAysD4bMXxeG1AzlkMZ+YAUG1QDH+zMGLySH8E8n1oqXxseUK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=gGjXUZSM; arc=fail smtp.client-ip=40.107.255.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHt5ecasC5Vqs5kmxD45czvxul3U88WK8wcPUD+eL6N36N0P4GEu2fdRZGj/2KS551QIcfwMbla6rfFcVPqoCjXHjUpW4Ywg3Y4p/848+wGmCU0l2WWGKwaH+AZh2ew5YBcLJN7LsQvDyW7CjGuj989XnVaqj3zJmpgSgm8/zmjg+FZXmoHBWCjf0JzKJqLnSvx2q1HB88rDHejf5Z+06rFLiIukyVcv5OgCPDK41dxs1dH404d5pNpsnjpActP3FqGCqvG+bgcC0I3fei/FacdOAwD0qAEcsqxKThGHZcHJwFLkvLONz195gMM7FnwVBg5gIxEJwmWsE0EvwPCt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrL7M5ix94exlaHYjFzpjY5nYsd3UiiZBaQrBkg7IdA=;
 b=yJCBCH0PbnXWF0hVMq/306r98Jq++5owzI6swRu1eA7QXR489DT5Md1sIGbYw3jU91hcNmQ2n22y68vxk414bUcgTdnrlEUyC/PffK45AQV+RQSfzmnICqYDD8Z5oD6X8MX7uhyawSnD+qiY6gBtZgETv7J/i1nZRXwmUfbulK7Oxz23wuMs0bqWJ2N/1r5vLUlvWO9hH8slg9dKZYHqzpuZg+2U+W9oQOU9VxMmDokCrlnMFTyYOfvEI4STo8/OPHnJKZQrJM2FxUBIVpeuzsTa49/Kz7FRouLCEbkPbM7TQeOtK5/C40UWad4dFMIIMOW0agwfsq/fl9SPzrPWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrL7M5ix94exlaHYjFzpjY5nYsd3UiiZBaQrBkg7IdA=;
 b=gGjXUZSMF6EVR/TksgTqfxrebVuTw1I5Wsh+XTb/eTyGq1zXEzwtwgtia/R0bmP3baxlFiK8mWnuZwvrU8w+gJp9SN/EnH4ItNJlv+070zhslk9+sZsVZKWRNQGcaoqNKzgcg9MMNguKIkuMxnwYvyBaSb3zhhEj3DaKk207yg1ZS0oznRIXnzRKigiigjOCmsEZeCZEke841lxMw6PWlX2aGK9BTnrpE3iVgw18KF5QFLktcsHXrO1VaeTmrdpuBYoSJll0UVlAsBBh+j1zJaF4dw2a3bbFEEyD7tIWjJavR/UOVLiTavP3UKI3Y909dty4LSGWLzCC5Q39pRP6+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB8467.apcprd03.prod.outlook.com (2603:1096:405:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 09:58:06 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%5]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 09:58:05 +0000
Message-ID: <f5756484-fb93-447c-a6aa-a76f518e3b48@amlogic.com>
Date: Fri, 21 Mar 2025 17:58:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: amlogic: a4: fix dtb compilation warning
 issues
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321-fix-a4-pinctrl-node-v1-1-5719f9f09932@amlogic.com>
 <e21f3e39-573d-4391-885a-2df7c2598d80@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <e21f3e39-573d-4391-885a-2df7c2598d80@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0c818a-ae51-48df-dd93-08dd685ee079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUhnOGpTT1NmZEU1NVBvQjg3ZzQ5cGRabUdMZ01YclZEbmFHWVNKMHBTSFU0?=
 =?utf-8?B?SjlnM2ZpQ0liU29LSmFzZUdjcmdaaS9jazZnYUpjYlZ4VE1zME55b1ZKOThW?=
 =?utf-8?B?aXJjaWpXZVA1R3JNOFNRbk9aUHEzODJvYlI2SHoxVVlKUlE5UEI0SjFWOVh5?=
 =?utf-8?B?c1ZYSmt5NUpyZ2xWV2hXM0NkUUZTUGpJZ0dFeHpnOFQrNkY5T3pHWHNFVXpp?=
 =?utf-8?B?ZEYzcHZaQlE5YmMzQUVLbnI0WjdDcHZNNWtXQ0FzdHNud3pGWlZoTmQxQWhK?=
 =?utf-8?B?MHgxSG1CWG5mbTF4UjJVTVhyekpNemJIeThZNnJoem4vQzMzakZHcURIQ0c2?=
 =?utf-8?B?Ti9mQzlraHNYS2t3K2xXUGJWdzUraHBZUGJzZ3k2OTNNQytWYWs4eWpmdGVC?=
 =?utf-8?B?REpna1BHeThUMXE0QS95cXFoUVBWcEE5amZ3RHpXSXk3ckpmaFYrVXFGcytU?=
 =?utf-8?B?N09uRFRMSkFwaEd6ZVpvV1VKYjVFWjZEQzdRVVVjazBuREpIdGRKbGNmcFRz?=
 =?utf-8?B?aHR1TW9jY3ZxWTE5QWRZY2lPTGhHY0xaNFJ5a3BabkRlUE02SFFYSXBiN0lW?=
 =?utf-8?B?cDdsZjd0aFVlSzRDd3hsMzFVRnNienFod0ZuVms0aWhCU0pxK2tVUTMxYjc5?=
 =?utf-8?B?QmdqS2EyNHVYanp2aEh5SjhGbkNQeklqQjJJdEVZaDRCcmY4QkxZMlk5U25J?=
 =?utf-8?B?alAyRi9Ld0hmOUs5Z0R6bk83ZXEzaGxvbXFVQ3E4SldQdHR2WVVEUlNicDJ4?=
 =?utf-8?B?dWcxRC83Y01sVllYQjBncVUwZHM1enhpTEJmdkE3bXFUcmZzWjl3bEdGVm5q?=
 =?utf-8?B?elZTRStlRC9zbTlWaVBXLzFwQkVjelgwRGhEUEI0MDd1WUNyVDljNk9EZVlu?=
 =?utf-8?B?ZktBcVpWb1BUVTcvd2ZBTVJ3SlAwSER4ZSszOUhhenlncEREQUdadXhWWXRq?=
 =?utf-8?B?UlFnNXN6ZVFISEpIeXlYbmdscFlxNVJocGV5WStjT2xJNjVHYXIxR0hXdHJT?=
 =?utf-8?B?bTB0WXRQdTQ3TkJIVkFRK3J4U0lhbiswV01WZ1E2R212UHJjaTZhTWdFQXFq?=
 =?utf-8?B?VDE4RmRGOFJMNUhiMFIzZUJ0Q3dzMzBYK2J6VG1iTCs1b2hBWG9QWkRqQUh0?=
 =?utf-8?B?QndDZ0dKOGt0M2NQSG1CbDRlb2xrRnpTZDVQamxYOUcvTGNyMGxjeTBiSjJJ?=
 =?utf-8?B?aTRwY2dTdm9PTUpxanF0aUFQVHh3bzV3S3hrQ285WmdyOFBQa0RvOHc0ZE1D?=
 =?utf-8?B?RUZvMGY0a3QvQUkvbFpuck53R0JvVU1yRDRGMHQ3NGZHRzZTRXlOVlM5MUll?=
 =?utf-8?B?UEw3b0ltNEE2YjJjdkRuMVFXQ0w1V0JxbUo0cEFnZ0JINDJWcTQwWG5wMVpT?=
 =?utf-8?B?d01KMldvS2ttSHcyZWVmTUlEL0RHQjkvazJ3SVF5eUFmZlp0b0Vla1JncWNl?=
 =?utf-8?B?eXZvVTl1RFcvckRKRGcwc3RzQTJBWEZDaDRwR3Z2UzNnV3R2TGkwNkg3aGN4?=
 =?utf-8?B?Zmc1R1pIQ2lUVXNNejlZeWZndHR1T3BWaWxaY1pWNzJ6aXlLRC8rWjZmSytw?=
 =?utf-8?B?RW5XRHAxN0hxS2FrblVYeTNFODJpUjZUcXZ4SEgyL2xVclJKNVY1eDFwYStW?=
 =?utf-8?B?bnBiUnRYbkdBTk5qNENDemtGbWdsa2N3Q0FYUlc0eGwwcTRmaW8xNWtWK2Iv?=
 =?utf-8?B?Z0RVU1Q2WGNMdjVpZi9FS3JIYVJXVnRWT0p2OElFTWtZMWZLcWozQWVDSUZa?=
 =?utf-8?B?akR3WFJ2NjFoTUsrNDNSdmtJcVZLTHJYVisrbkYrRjZFamNpSTBkUTVpWGx1?=
 =?utf-8?B?OXVOSjQrN0VqNW1NcWFleGNRb0NTRjFHSVRHWmFjVDB0YjU2bTR3QXZnWjdu?=
 =?utf-8?B?SndhZml2ZE9YVlJtTG5LNjVNZTh6OURJRGZqcHd5ZUpSYVl4VU5xS21TeE5M?=
 =?utf-8?Q?5aX1hQPbcgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWNVZDUyWmpSUUtJaUhEbEFJM0t6ZnJXK3Y2WjRZeks0dDVKd0JOYkdVeUU1?=
 =?utf-8?B?RklUTFMzVy95K293dE5YM1B4Mmp1MGtWWEhjM1NKV28rQ201dUVCNU5GVjdu?=
 =?utf-8?B?bnRLZ0FmTHY3NkdKaGVCMGNWWHVRcEo3MUlOSURtaXhsMEJOdmtXNk40cXh0?=
 =?utf-8?B?UWpaWCtNdHU0NXpTQkE5STYyN0pETjhDYnZJbDhISGhzcTh5WlZzUlpBYnp0?=
 =?utf-8?B?V0ZtYm1ONGdub1JRRnIvS2E0NjE0a1JnTjBsc3U5Z2tpM09STmM4TkQ1SElz?=
 =?utf-8?B?S3FOYmhYSlRCcTNVbWNwWjVOa0U0MmxJNWt5ZmlsZExKUC96angySkF1YlFy?=
 =?utf-8?B?LzBOTXEwRUZCZGRhQStZR212ZDJIT2wzT2NPTHpRTDF2eEUrVG1ETHdLV2pl?=
 =?utf-8?B?dHd6VStvZ2tVcE5TNnZyaWN2YVpxT004RU83aWpPZG1XWkFESUJoeFZOQnE2?=
 =?utf-8?B?SlhUakRJZ3g5Q1dabkJLeVNXN1ZDcFBLd09TOE5yNERWOTUreDZ5V1I1OHgr?=
 =?utf-8?B?MktpTDUvMFVtcFZsWEVIM0xsMGkyQnpQdFRvRGh5dnE1cHZYM3Z0cEFuUWVO?=
 =?utf-8?B?cGdrcGV2VlFPeU4yV1F0cnhqM3l6cWNUdDgrT2FXeDF3b2U0QWZRZ3JsNzJY?=
 =?utf-8?B?dHkvbUxLUXVpME5WZnV2c2d5TTdlekpTa1A5ZUxuTU00Ky9uc2UzaFVTWFVn?=
 =?utf-8?B?NDIvNWROUmpZZVlKYU5lWm1tMUtabC9SWDg1MXZXdUw1Z25lc3hVaG9DVERi?=
 =?utf-8?B?UVVWY2JycEh3UHlDYVBIb1N0NUVPa0ZONHk2S05ERzZEQzRzRitxUEtyTGF3?=
 =?utf-8?B?N2tzUUpheGJ2MkNwY0V0eFVDWnY4MTZrTFZacHZrak5SVFdiRVExc1ptU3BJ?=
 =?utf-8?B?aElnam9FMDFjVUwyU0xSZjdDNjV4SXp5ZXZ6NUJRTDBLdGZXNzRrVVAwYmtG?=
 =?utf-8?B?K1owTUdDRkdtU1dzN2hadmY5SnN0VmNUSlJYM1FBRmxVYk5FV1B0QTlycmlp?=
 =?utf-8?B?ZkwyZFZsVDN4cUFFTTFzdXRFbWxLckYyWFVUb3Ryd0N0YlZ3K0FhK25GR2tV?=
 =?utf-8?B?dDRKemZsdHlvK1FCRlh4K3oxQnhxVzZiOXl5Yjd3OHlnZlNJaXorS1p6Vzdp?=
 =?utf-8?B?QVZKeGd6K0k4bkRubWlWOERrbVVUcis1dkVkTll1RjdBeHRucHQyeDdBU0NP?=
 =?utf-8?B?OUIzWTRxR0hSbUNJWDZoOGNCM3NOMWZZeFFhUVlpOWc1eUJza0ZjZ091dnNa?=
 =?utf-8?B?UkxGZ1lVU0c3LzVnVzNhbWZmQ05sUTgzRDNKKzZnK0hMeWsvcjlGRWl6SmJo?=
 =?utf-8?B?NDFuQnBPZkhDcEdHVTVrKzFQY0wydi9idUgzSml3TWlrN203NkduWnJxYytn?=
 =?utf-8?B?VXFtNUZJc0d4ZUsrcC9OdzMzbUt1MG1RdGdZZ2xaNHlEMTYxWG9UbE1Ield6?=
 =?utf-8?B?TlpsZVg1S09aZmhMTm9vSHhGbEs0MkVQdFNBbGRlSnI1WVdnTUhoZFNnSHp1?=
 =?utf-8?B?V2pjN09xdUtmdE5LQVQxOVBoci9nQ0hyc0M0ZkFtOWRqZWhhR1NHSXNJNHZX?=
 =?utf-8?B?RDJWcklteTJmMllQYndRc3h5VzhWeEJCY2RCTHhiVHR6eU1DdDNUVVdtaXVG?=
 =?utf-8?B?Z0JQcWthWHBiNWhlNVNEb0lWZW5vZW1RcnhJamtkOEU4R0FvemtHakxjQi9B?=
 =?utf-8?B?RDZxdjlzS0ZPMm5WWGJzSXRNZ25JNG1GSjFnTW1WZVlrdUdNQjR6aFRVODhh?=
 =?utf-8?B?TllrU1BNQ3VWU1ZyVm9Na2lyMkZWZEVNa2ZaQzh4clJPZ0pPY2ZmOW5DV3ZQ?=
 =?utf-8?B?NG51OVRDMnQ2cUxOcHJTcFByYXNKbU9tazM4Y3VWbEV4ZG55ZDk5c3lXRUdQ?=
 =?utf-8?B?UlNnT0RETkdhZ3BKQXM5YmZtSkRhQ29aeTgyNk1PL2RWcFZsU1h4c0hhQVBV?=
 =?utf-8?B?R3pOYW5oT1dqeEZ0VU52S1hNZnBCVWJ1OWMzWTVZMU56MDdvMGRhMXdvU3Zw?=
 =?utf-8?B?VGVRVTI0c0s0eWJLYlQ5Yk4zR3lKQUZ2SmlPSnFoUHdLSTg3Y0NacVFrdTNZ?=
 =?utf-8?B?eTNCRFRBbkVaRitRNS9uM2JobFk2WU5SWHg4VzBmcytmMHk5YWFtZnFaY0lq?=
 =?utf-8?B?UXI2NDhwNmxRb2ZXVTVqaDlMR1VnNHhma0tiNVdjSDRwT01FdXREQmpWRmdv?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0c818a-ae51-48df-dd93-08dd685ee079
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 09:58:05.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmc+1B+ZM7MrXqu0fXmMF+OE+AfbTBQ4oGZHylpgC9om0NSJJAB56rSwsGuN+Sq5QTqxOO/KGD6VrkZK1akLXJZAe7JWUxReLBr1RTyUOu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8467

Hi Krzysztof,
     Thanks for your reply.

On 2025/3/21 17:25, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 21/03/2025 03:23, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> When use command 'make ARCH=arm64 dtbs_check W=1' to compile dtb,
>> a warning message appears.
>> "Warning (simple_bus_reg): /soc/bus@fe000000/pinctrl:
>> missing or empty reg/ranges property"
>>
>> Add the unit address to the pinctrl node to fix it.
>>
>> Fixes: ce78f679e08c ("arm64: dts: amlogic: a4: add pinctrl node")
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 102 +++++++++++++++-------------
>>   1 file changed, 55 insertions(+), 47 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> index fa80fa365f13..582e0043024b 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> @@ -51,87 +51,52 @@ pwrc: power-controller {
>>   };
>>
>>   &apb {
>> -     gpio_intc: interrupt-controller@4080 {
>> -             compatible = "amlogic,a4-gpio-intc",
>> -                          "amlogic,meson-gpio-intc";
>> -             reg = <0x0 0x4080 0x0 0x20>;
>> -             interrupt-controller;
>> -             #interrupt-cells = <2>;
>> -             amlogic,channel-interrupts =
>> -                     <10 11 12 13 14 15 16 17 18 19 20 21>;
>> -     };
>> -
>> -     gpio_ao_intc: interrupt-controller@8e72c {
>> -             compatible = "amlogic,a4-gpio-ao-intc",
>> -                          "amlogic,meson-gpio-intc";
>> -             reg = <0x0 0x8e72c 0x0 0x0c>;
>> -             interrupt-controller;
>> -             #interrupt-cells = <2>;
>> -             amlogic,channel-interrupts = <140 141>;
>> -     };
> 
> 
> Not related to the change you described in commit msg.
> 

I will add the corresponding description in commit msg.

> 
> Best regards,
> Krzysztof

