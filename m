Return-Path: <linux-kernel+bounces-174410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 446108C0E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB965B21621
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B50C12F5B3;
	Thu,  9 May 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lRImlVEl"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2134.outbound.protection.outlook.com [40.107.13.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE69322E;
	Thu,  9 May 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251577; cv=fail; b=O3s7azTEpFnFmIixY+FwvVCz3JlkK5xYFU7Hs0g+AWc2INCQhH/NrAW7lQI/A1Y+uCicABsqNm/iBuLjrh3uDY2H6vOY79JuKQOFO24szHEzIWiHGipCvqpqA8B3sLM5KH6+kC16cqiYfRGJkLZTsm+Ne0WxzuGtiCtBaJCq3Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251577; c=relaxed/simple;
	bh=I8c5Dmd/REgDEwT4s3aisaE/9M8JScc8cTBTcH1aYW0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=L122prT3Z+FXbylkBPEKoOPNZvCdVyF7OlQqE3N8gPyp7UOnjUvXNl5AOSiC5hOKmZU/BMuuTc1ki5HsEGMTDjEwo46zSEmPdzBLEAfxfttik3M3h8hV22ahGFdMj7sbS32uRzkZUl0Q3du2Gcgg9vkM/WB7XGdgyPIdGf+qenE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lRImlVEl; arc=fail smtp.client-ip=40.107.13.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g66X5VEWqhIo2csWZ4/nBumVZq5MZf3smfBYArIMOWUKFZZTML7AXmKOyRtzwKs41yoYjlDfin4gYwJSD7IXKV9WOck8laxvpfXei8k4ZbSyowx0LdBPoQqQhxhSVJu7/d4NYHnvRmvaV+9OwLvEUlhbXom1xxP69Zx0RhViIW3VNwtipRFCd/rgvTcTrhxKV4DnPMjU5WvZmZ8A1EdiySN0mxGFIh6sSX3tmUGhyWQV58rXZdUrgjzOxjs2VyVHvkbE2J1DgBPwVKFSatiJjvjHFdYPC1bZJr9/x61jC5Rpqn6x6XDP2gq3sxBuHIpbO0tB2Qz7JUc3dYHt7ocIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHuDlE4bz3Ri64XL5zF4+GOIm5j56U6XO6oNEWy+k7s=;
 b=dAo4Fn9dXOyXZX2jUJ0M/t4UAg7UaV78N0D/LY63w3cOIts4rqd/0VGsSD3TKgvhDwEJYzwX2Tfw/BhRimFr3UGah8s1jzs7/+VQDs8FuSXfpIr3I21TTPkc65PLEcatdc6T/0gerXhKwg69leB0GX2ih97VhSy7ibcCJSYVEQJrJscW0+2Ufk4+I3dKODysPsXO9jTNHb/8sgecb92EpFemL3QtEixsRGxQ1Hm/NPMJfJcAKV/DzANkx37RvPO0Hn0izOY/FES3iQSWEMSczzQ/raH9umUgz02I5oMv4mrF3pCSEugBtE4kVyuCgghWmevhJnuHaKmyRTgnDuYtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHuDlE4bz3Ri64XL5zF4+GOIm5j56U6XO6oNEWy+k7s=;
 b=lRImlVElIhzfyYfP/TtgsV+OQy7AZ+CNOVgx1Zgwbd+7G7Ihr5evqkUM2Rt8+ST6tg5fgB4VWupoRBfhbtUTcyP6u3ysFXIDJpFdc7r7oIz0cQmpCid48c5k3R/PvVVzFR5gHih9jhZMWyH3is7TLOmIsJnSZwi5ApochT80H/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 10:46:11 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 10:46:11 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 09 May 2024 12:46:05 +0200
Subject: [PATCH v5 1/4] dt-bindings: arm64: marvell: add solidrun cn9130
 som based boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-cn9130-som-v5-1-95493eb5c79d@solid-run.com>
References: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
In-Reply-To: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8cd003-a2d2-4fa5-af7d-08dc70153d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|7416005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDdEbDN3M3RialZhaERUNG1TQ3pUdHlpVUV5Z3NMK3dWdlhtWEswaHd1ZVBQ?=
 =?utf-8?B?L05qaWFTY2ZRTjh2WXpqbWtWVTN6bTNCNnIxOWlvUko1K1VHUGR6MUhaUXAw?=
 =?utf-8?B?c2p2b1FGRDMxTzY4NmxkL05JaUVBazJwMmVUSlk3U3d1ZHIwVzMxUitlRk5r?=
 =?utf-8?B?UWVnc3AzWUprRStGdDR5M2hoY3RObWtidFNqYjJnS3dDLzM0YjhiTmVLSjBs?=
 =?utf-8?B?UVNmdElVcTdIN0RBK3MzRzBFL2wxWXJxWjBrQ1VuSmx4TnA3ajN3U2hjajdo?=
 =?utf-8?B?Wk9ZNE1xWVlnUUVneDZKdXNFdHBURVhwWm51S3hxN3dBeGY0dlNvc3orbjZu?=
 =?utf-8?B?ZjFhTW9BV1lOK1NuVlJSblNNWktFQWlPc3lsQVZ0Tjh5U0ZmSW54MzRVNEtH?=
 =?utf-8?B?NHlBd1lGM29zeXNIaHRGOG15dkVyemFXTDArVWRzcDQrTGkyUC9MQXlzaWcw?=
 =?utf-8?B?a1FyR0xJRXhhSk41ajBpeXNRSWlhTVYrdFgvZG1jNEFFVGNjT0NRMWVueVlR?=
 =?utf-8?B?TkNNZFFTOW5nQ240NEZKU0Rzb095Z3lrSjc2Wm4rb2dsUWhWSlBldWNWNVdW?=
 =?utf-8?B?Yi93WnpyWDRCeStsVmVFYmxnUFVXblNOTEtxbTRZWVpxZm5tejQ3RU9NU29V?=
 =?utf-8?B?bFMzeUhOcmxhcVlScVhkZDlMZi9aR0dWdWhqaEc1RlN0eTlUYVpYQXBRaVFW?=
 =?utf-8?B?dzI4Q2YwcUhqNGtEdVZjRG5YYjE3SDVaQXdrMHJXNlF4cTc3ZTBqMGRDZm1o?=
 =?utf-8?B?Y01nU3grckt4UDRjN1JQZEFiN3dzSHltYUNXbTUzWVVCWWVSNG9MeTZLT2JK?=
 =?utf-8?B?QUNaQzhIT01VSG5RNlJOUHRLR1ZnOXAvNlFTQWdLaG5UYlZWTkR6M2tWMXBj?=
 =?utf-8?B?WDhvcDNPN3M3MGJDVTIxbHN3SncvdzhsaytMR3dORVQvSkw4eVFTSzVMMjBF?=
 =?utf-8?B?Tm8yY1NjQ0xiOHl0clpGbWlienVCOE9YMnZaSXVaMkw5Zjl3Vkkva3pJZmlF?=
 =?utf-8?B?LzNVc01jVVozTURDc3A4SmRGeXNGS3BPdTJqTkxhUVhlOG52R3RVeGQwNllC?=
 =?utf-8?B?cGV3UFBYc1R4R2NJWGU4U1BKRWF5UWYrTXVrWld4dXF3UkJYQ3F2ZDhLVmxr?=
 =?utf-8?B?Z0ZUREJpVVVQRDdBdVNEUHY1STAvbVllY1IzbEMzVXBKMTh4TEFwUDdFUmxE?=
 =?utf-8?B?b3pnWnJ2alk3RENQRXVvaXdPYVdYaGxoT1p1YkhEUmlDQjJPZ2VXMGJiT085?=
 =?utf-8?B?VjFPTFcrVG5IWUJhTWR3UjR5Vlc4bVJYZi9WbHNsNGVnSUV6eVZST0FHSXhk?=
 =?utf-8?B?RVhtRWY3L0NiZFNjWFFIVk5GLy9oS1UzVTRjSTNQbjlaSm1heW9VVUhBbXNE?=
 =?utf-8?B?TmZuMUdoV3I2MDlmSExCZi9qazhxQWlnUHN1ZTJuRXdTRlVNR3lhamFUamVm?=
 =?utf-8?B?MXVRTjdEdWdNbklPekc5aFhvdUg0Tk8xSXhEcmprUWVZQUpkMVRyZlVtRE5z?=
 =?utf-8?B?ZzdQSWlXcUNUbHVrZXZZOTBsOVJodGZseUkybjBISnVwcGlVRDZFRk4xMFJY?=
 =?utf-8?B?UDlobnNDdlk2SmxPYVFUWlZFMVhnUWdRdnhCYXBZTnJzK2VZRk5Lc1lIamVr?=
 =?utf-8?B?eVJWbGtmV25lWjAvNm5pUW9qL0VQLzlJd21BQnZaNkNPNTlGcWJQeUlaeFlw?=
 =?utf-8?B?aUhtcWcvdU5NZjNZV1BTZGwzUFdKYzZBZDJBMnBjUkg3YnpPcXZndGMvdENl?=
 =?utf-8?B?QkNlaS9vdDB2NXFqV0p2dEJFR3Ara0JtVFlzQlQ5OThWSjFSN3BPUVBIaGx1?=
 =?utf-8?B?OEpWK29pbnd4YThsUnEyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzVPRCsvTy9qbmRwZS9RME1pemQ0WGlZNE5QQk1LNnlXMHlkSHo1eXg3UTdC?=
 =?utf-8?B?R3BOQlorcS9ybDU0QjdEYzZiMThZZGUzaExteUZmUkR1aXFoSnJFTEt2RGZC?=
 =?utf-8?B?QjlkYjZlUS9yYlJhSjlxYnZIeTRJYmwzakdaRlhRNGU1akMzU0FWMjNEVVRy?=
 =?utf-8?B?cnl0T25BMHBLNG1ZM3E0cXBsTXJxQ1NVbUllRncxQ25SMXRRTDNlU2dDakFk?=
 =?utf-8?B?T1NPZFRGZWlvVjJzY3FnMlRVbHc5UVIyZWxkMlNxKzRBZEpoYmtCU0dyRGVE?=
 =?utf-8?B?bXJVVjZlN2pQWmRyQU9uYUt2dXNqQ1pLeHlmSFVCNDBxa0ZsVE5uUEQ0OGtN?=
 =?utf-8?B?S2t4cGlCMjFNNytDVGw5UUozSmhzbHRVczNXY2dub3hWbXJTeFBiWlhXQXJy?=
 =?utf-8?B?SlJsS3Y4M0M1UUlaYWt0Rzh0azhBQkFlWFVWU3RzVzZDSHJJN1ZyTFAyb1l6?=
 =?utf-8?B?aTFraEhLelNqdTE1dDNEOXFtbnAvb1gyb1Y1TTRUN1JvanpkWHBaMlhPZnRG?=
 =?utf-8?B?d0FpRGFranl3OTMzZnNCRUpKZTl4MHY1eHFQSVlzQzRPdnV6dUc2WHlsS3p4?=
 =?utf-8?B?UGxBQ0crTTJoNVhlTDN1Y2g2akRlR0lxZUhjVE9hcTVKYTljcHRqTHhxQStl?=
 =?utf-8?B?cHh3MmQyMG5TUDQvRWlTb1duZEluazA1NC9iZmcrVmZQVWJsQXVrZUxoTk9a?=
 =?utf-8?B?L1g0OWJRWkkwTTRQOGpJRjR1eit6SGp0U1FQSlZoaUU1U25VVFBNcUJUYlhN?=
 =?utf-8?B?bUQwNUFVY0g5eGxNZGpYaFFrdUN0QWxGbm5kYWIxZkJGZlNqbnd4eG9tbVZ4?=
 =?utf-8?B?NjN3MCtNYWNXeHBVVW16MHRtZXpuMkxRUHh4L1FNQ1VhL3BaTGNVMlJnOE0w?=
 =?utf-8?B?TzRFc0RhT3Iyc0g2NWF0S0FoVGlLNnNkQllnY2d2NGJCdzNvUk16OHBxQUFw?=
 =?utf-8?B?V3BHS1plWnNENG5uL3RZSXp1TzVEWHQybUFWREd3bm56MXFxTjlRTFdybCtE?=
 =?utf-8?B?MzA3dWNyUTVpNXEyT3ZRMWRMNWFPK1dQT1hMdE1GVlhyK2J5WVR1TjdvT2Fy?=
 =?utf-8?B?cm9HalVPOHMydWxHZzROZnVwSXlWSnVyV3AxdUYwUVFoTitaZ1ZSMGxnTFVP?=
 =?utf-8?B?SHZKRUYxdkRQUDEwakdRbFBWSnFhZitEb1dzS1VRK1NINFduUjgwWStGN2l3?=
 =?utf-8?B?anBLWHdQYmFmMFZ4SUdBTjZjaG1GVkJ2UVJXWmVsNjRTaWZ2elhRcC9vNWor?=
 =?utf-8?B?WW5haTFpc3VvVnRIalRqNHp1QVF0cmxtcFZMTXN6TmJYdWd3T0Z4bTVyQ01E?=
 =?utf-8?B?aGNITXBWOHMrTDBhQ1Q5eXFhSVJrcEhnUEs4alM5Q0FMd3F1dk5tTEVOWDBv?=
 =?utf-8?B?SjBoamRFcThlZHZXck0zNDJQMTltODVndnF1ZHBrZUt1YUhGaXYrbGJMdXhR?=
 =?utf-8?B?VzNUTUdvV0g2d2VkOWRKN3h5SE9ZWE1hSEszbVB3UTF0ZHkxK3dIWnB6TERw?=
 =?utf-8?B?di9iYzFSOUpjM2xnR0ZmRFlHZUtMb3hIQXQvM0FwTjlyNWFQYW5BSVlLYnVx?=
 =?utf-8?B?R09yUjFMQTZMMmdMK0VIdE9sMk52em1DK3Z2WGYzMkVzZ2xwMWlIZnNmTDBT?=
 =?utf-8?B?a1pCcndSMWN6N3V2SzFBZXRPdXF4UG1OZlRTN2w3YVdyV0hxT2p5VjA3aXBm?=
 =?utf-8?B?NzR0UHdjNTB0Z1kzazN5SWJSd1BhSTV1Wk5jVXZJUnh0M0Vxa0FCeHNQY2tp?=
 =?utf-8?B?QkVMakdicTFkVWU0ZWxKRVh2ZTZzaGV6ZlV2aU4vZXVIK0dtZDVFc2FLQ0xH?=
 =?utf-8?B?dVd6NGlBM1NDWGVtalU0aXpqWEhPSFowNCtPWXJiWXlEc2ZYVExtMFJIVXJD?=
 =?utf-8?B?Uy9nQVpteDRCRW4zbmdGK1hqUHhSeFdwZXJSdWd6amdYNGZsbUVvU2x6WUdZ?=
 =?utf-8?B?cnNFV1pRZWlsMko3cEp0OHBnQ1dNdTBveFJjTDM5T3pxZFpET0Mza0lRVVRm?=
 =?utf-8?B?TW5Da1IvQmNBWlBYQks2RUhGZDdnME5XT3pLNzFXemJmc1BndHdGaEpLRnNS?=
 =?utf-8?B?S3U0RHdXUWdxSXJMOGRQQTZOY3BWSURjRnYwYUhoTmRJRENtaW1sWWhMcFFr?=
 =?utf-8?Q?I/eMD0onnZALHuMMhEk1xPEwV?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8cd003-a2d2-4fa5-af7d-08dc70153d4e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 10:46:10.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMmTxipBSYl0tclIMNndU6kAvHPJ5NXhe6iuw/sD1no+K1SRl/BoENda+lIWEmZU6D7KwY1EJ4a8wNS52fGcpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

Add bindings for SolidRun boards based on CN9130 SoM.

Three boards are added in total:
- Clearfog Base
- Clearfog Pro
- SolidWAN
The Clearfog boards are identical to the older Armada 388 based boards,
upgraded with a new SoM and SoC.
However the feature set and performance characteristics are different,
therefore compatible strings from armada 388 versions are not included.

SolidWAN uses the same SoM adding a southbridge on the carrier.

Since 2019 there are bindings in-tree for two boards based on cn9130 and
9131. These are extremely verbose by listing cn9132, cn9131, cn9130,
ap807-quad, ap807 for the SoC alone.
CN9130 SoC combines an application processor (ap807) and a
communication processor (cp115) in a single package.

The communication processor (short CP) is also available separately as a
southbridge. It only functions in combination with the CN9130 SoC.
Complete systems adding one or two southbridges are by convention called
CN9131 and CN9132 respectively.
Despite different naming all systems are built around the same SoC.
Therefore marvell,cn9131 and marvell,cn9132 can be omitted. The number
of CPs is part of a board's BoM and can be reflected in the board
compatible string instead.

Existing bindings also describe cn9130 as a specialisation of
ap807-quad. Usually board-level compatibles stop at the SoC without
going into silicon versions or individual dies.
There is no programming model at this layer, and in particular not for
parts of an SoC. Therefore the ap compatibles can also be omitted.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 16d2e132d3d1..74d935ea279c 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -82,4 +82,14 @@ properties:
           - const: marvell,armada-ap807-quad
           - const: marvell,armada-ap807
 
+      - description:
+          SolidRun CN9130 SoM based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9130-clearfog-base
+              - solidrun,cn9130-clearfog-pro
+              - solidrun,cn9131-solidwan
+          - const: solidrun,cn9130-sr-som
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


