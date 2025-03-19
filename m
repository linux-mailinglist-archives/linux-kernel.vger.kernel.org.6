Return-Path: <linux-kernel+bounces-568552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F5A69745
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700AC1B6062F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F141E832C;
	Wed, 19 Mar 2025 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="weVaQ9on"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013068.outbound.protection.outlook.com [52.101.67.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576581E22E6;
	Wed, 19 Mar 2025 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407228; cv=fail; b=pgz9x/N69bCnc6OtIGDx1HhGwLVKBBYwGIFltQ9D3HK+tRp08PEueRv+suN0UBUJqKyLIOnU3OtHlp8unxuLNCY8lpEfzYuIsry5nYPUFa8+EH2eTaurrz5ZvkF2JUsh4RsbLggoEqzjsAoqvhOuIepoXqbcVO/5tL4dhNIMVz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407228; c=relaxed/simple;
	bh=lIzsyhDOTRjbaanK9wF9NPISxJS+vS6LEyGmfKtPu+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdAUlIkMAgjhqMCBQCGaK1zPQHXo6Gc9EebqWQvVOL7vU3ygK27mMcmGLc/Pj6LM1OJMuIntR0M/Dx0tqmGUGgvZLn480HrpbwmINeoclf3vmBSflIIT7vUAGz030AdaZgO90kdstrDBVRG/ybuSAZN15wB7ppQI+X1x7gLYNmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=weVaQ9on; arc=fail smtp.client-ip=52.101.67.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qem7YK7w4QrY/7g1qO/GcmPCNE8HzkECQEnR1+r6QsEiVXcPuLoB9DXh6LsYZIEDPdIwy1R7r0YFkKOj1kk80J0btZaoEoAn5fw8m6LIo2qC1cYnfevmuThYcxHiLfbCH4uUkuKs9aVu9V5rAvkGvPnEE1aE2iOMO4j5/lOuu/sXOMbb/yE1z5zLbaXAoyLPgvBKeq6KTjPUocWNXqR2F1bJA2MbrXXz3Wo4TpQBc3A2rrUWTnkz9HdlvNdjiRhukYAczyKvNx1Pa6symgm6RvmHhir010xTYDbXzq3tkw7s3I8CxmsOMdTlB7XcsQp4zrFC6vnPtjIrttcJmhNXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIzsyhDOTRjbaanK9wF9NPISxJS+vS6LEyGmfKtPu+4=;
 b=N0koa/YD7N6BuM2vyiAQUeCNYGzr7CTTwRtnUOZkg04vghzkMWrtPPciQmDCU4hArDwbKN3tMiaewZkzCNaajRH1M8SWFcLc92NlM5PfTj1zCRa8MzkJ4j19puka6aFdvK/OlxnW+fccAzJMA6hQJ2Y+sAKiG/rpJyxN0CmYu5Xn6Rz9Kr/waGb2eoaGxbKGOhvdj4EthNJhEwo7sy4jXR8saEZzNWobH7AzXX1xLWfC2AtmLiPiuasouyAdszQZru9SpS+HesXngaSVcfXbo5BX2WzYQCHTdt2+aa0WlvfjWe454ATpOIpbdNcfwrGeUafu8FDBi87D8GRtixFBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIzsyhDOTRjbaanK9wF9NPISxJS+vS6LEyGmfKtPu+4=;
 b=weVaQ9onoDbhyDURYC5g7y1B9lwrt0Kxs+zosth5UYUqr9db5PGf+WAV/EkvJnhexHIS6YYwVokiXy8NBTNR03cSKva8XGoLU37PseHW83ldRyBThx6mmqZ2hqv4j99GaTUcCxlsUGlce1qGgVX0AmWCzqOukgsnlcPxo42Q3pOpZwepTC4xv6N8j8mbg8fGjXa/TMxDXab8+NPyuXSka28b5L3jBvItc4oW0Vo4VBiKwOO6SM0F6S5dclXQKddP7CX1lH4y3Ti3lyb70o6GkSREAaTjt504YtbbtulCKob7ZRFkrgQ0jSFC4FHheSJub29TRH55SsTRcKEdyWh7LA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 18:00:22 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 18:00:21 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "aradhya.bhatia@linux.dev" <aradhya.bhatia@linux.dev>
CC: "j-choudhary@ti.com" <j-choudhary@ti.com>, "u-kumar1@ti.com"
	<u-kumar1@ti.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "devarsht@ti.com" <devarsht@ti.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nm@ti.com"
	<nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "praneeth@ti.com"
	<praneeth@ti.com>
Subject: Re: [PATCH v4 0/3] drm/tidss: Add OLDI bridge support
Thread-Topic: [PATCH v4 0/3] drm/tidss: Add OLDI bridge support
Thread-Index: AQHbPn5WIr4uDRt/y0KwBpNmDAlljrN7dJOA
Date: Wed, 19 Mar 2025 18:00:21 +0000
Message-ID: <8366a3d736f9937667aab024895a59e5947dd4a5.camel@siemens.com>
References: <20241124143649.686995-1-aradhya.bhatia@linux.dev>
In-Reply-To: <20241124143649.686995-1-aradhya.bhatia@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6130:EE_
x-ms-office365-filtering-correlation-id: e69148c8-fb42-47ae-84a1-08dd670feadb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2lqUGVtajNYL1VMMHE3VUhYajFZNDZkVW43ZElJK2dHRktMMnNXY1hTU3ZK?=
 =?utf-8?B?OGFidldtVkV3K0ExdnBQaXZIMXVyWklvM1c3UTFiNWRzYjgvdzY4cG05Mmt0?=
 =?utf-8?B?VzNYcXJQQWFEVitVNmFMbEw3c2hydE1UUUdVMWFoU09WaHZGN3hXOXJYR0VN?=
 =?utf-8?B?Z0ZRR1FWblNjZGxFdmZxOGZRa2llSEJRem94UXlZM2pEMVROdm1jYjRQckVy?=
 =?utf-8?B?MW9BQzFsOVg1eGp4ekkxTnZadnUyRUFVY255dnJXWEp1RTRvTmxEckJCeUJQ?=
 =?utf-8?B?NWFmQXZhakZzY09XdDlwVStJUW1HZmNZOGxpVFN5dXVnQVBvaU00cWQxMnlY?=
 =?utf-8?B?OVp5d0llQmxPWlhuV2o1V1daMWIxd1VmRFQyVnhOc0lobG90dmFpS3FTZWhz?=
 =?utf-8?B?RERoZSttUTE1M3gza1h4ZXUrYnhYWVBidnJ0VE5tNHJxRCszLzJiRWxTRTBn?=
 =?utf-8?B?TmNkU3doSmtrT1k5azVNc2RiRVZSZ0R3QzhvdjhWcU9sU3FLVXBjOG93VzFH?=
 =?utf-8?B?Ti9iR2oybEJVanlndTFScnYrSDlRNUZIYlU3UCsxWDFtT3YyYjU3RVB4WGJO?=
 =?utf-8?B?U1FWalhFVGpmVW83dWNOYTV4L0Y2cVEyTnJFRVl0VG1zQ2tMMnFPNm1OR2Zs?=
 =?utf-8?B?U2ZoRnhudHBQdEJaQkFNTkNRRWpVSTFXSXdCck5jekVXNDBVc3VwNzVkUVJl?=
 =?utf-8?B?ejNEd3FycVRGVmtHeWNqUXhMREx1ZFZoaVFXeUxCbUxUTk4zejRHK21GZWJw?=
 =?utf-8?B?VHhydWdqTlcxMHVJZ3MzSVZqUkw5b1Bsd0trbFdXOVZLWTc2RU1BOFE4d3Fj?=
 =?utf-8?B?RXBSY24rWXhGc1hiTURUcGNwenRNSzNNS3FjUHhXSGxmREpJRFR2K2FqRmdQ?=
 =?utf-8?B?WU83UXkxaUhJZEFhQWxndDJJN2orR3ZlUTJONEZYa2dCQXNnK2M2N3VHTnVN?=
 =?utf-8?B?d1JTelpwd1FaaWl0NVpnaitBT3F0NDczUzN3MFpKVU5aTTF5a3FBU3lENTM0?=
 =?utf-8?B?OUV0SXRuOWZJbnFLNzlqaTU1UXJvNjlScW4xOTdoNW9aWUdXYW51NXB2TUlk?=
 =?utf-8?B?NGI4a0FGRUVWOU1EQnJXMjF3T0JBUVRQeWIwbzNTVk9kZGdQVUpxeFNodU1N?=
 =?utf-8?B?NnFGYlYvMGZWWisxNEdEZmkwOWJFeUxSWGsyR3BKQXlMNlV5NUQrWlVQdWpw?=
 =?utf-8?B?WWwvTTgrRXB4b3FoYStJYjlIclFkWTE3bEdycHNETEVUbGx6Yk5RYzk1a0Z5?=
 =?utf-8?B?Qkl5blVKWmNqV0JHeVk3TE1vT3dZZFplRVZuU2o0UTVGMDIwTzYzMS9tQmY5?=
 =?utf-8?B?eHN6NUJ2b3JETUVzMmRXZnRVYnc5NG83VkloUmVaamFuS3dLSFVHeGFKakR6?=
 =?utf-8?B?SXZHWE13cjU1WXovYWdqTDJ4OVZtcDlCOC9IcDNVdkczaGdvSW1nY0tudDZQ?=
 =?utf-8?B?dTlSRDBZQXExNWsyZVE0b0tnUnJKNm9FNHNLbjVuclEwdDJEMEVkM0xVbnRF?=
 =?utf-8?B?YnZXNEVOVVBXcnNFQTZiZXRKTC9nb0hFN2N5WFljNzhzV1dmNjlvalgzRzgr?=
 =?utf-8?B?NTBiK3pGYW9UWEk4dXNqdG9tUDA5T3RhS2FEaHJWd2FOS1JIZ1UzS0M4STNJ?=
 =?utf-8?B?eDdTUzF3WDVJR2RiWkpOQXk0aEFDcjZDWG9RVStMK2dBQXpQS3lHZzBuNDdk?=
 =?utf-8?B?R1RDK2xXVitrakRnQU1NMnlORXVxVld2RnBFalY1VzNkYndkYUxSZzVyZENI?=
 =?utf-8?B?d0xNMWJuUjByR0FDekgwYVhYOUNBY0lQMUpJek9RZitPOTJvRElLWStMa25k?=
 =?utf-8?B?eVU1NmJXdGtMZmxQNGtPaVU0ZHc3UTh4Mjh4bFV6SysvV1hMcGRqTFBUelp0?=
 =?utf-8?B?YzBvZHduM3dQVHkvV1VDcnFEcG9hRFZPczRTdjRwRFBYWGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzFZNTZudC9LdkIrU1RWMnAwZlFSemVQYzE3OTJjWng2aXhxa2FiMmZobUVq?=
 =?utf-8?B?UllSdVQ1TzFlMndLMWMxNi9hc0RQaVRSY0ZkL1lXS2tiSytLRjVpUlJQWTJB?=
 =?utf-8?B?cHpkQjdNdkVRQk9MUkxmK2Evbkc3dk1Iekk1M1JlUUJONWdhZVhrTVZDeU9M?=
 =?utf-8?B?M2w3aloxaGFCQ1F2KzhsL1V0Ti8yQ2xsQkEzV0lHdWQ5dG8ybUhLZ21RenA1?=
 =?utf-8?B?T3ZHMVBoMVNHbW8xWFArWmZrQk9oYlVJZ21nNmJSNDFsSWE2ZkErckI4K1Yw?=
 =?utf-8?B?WVhUQmJKbTZPZkpVV2gyV2Q3dk9oblJ2TlJ6aTFXTnNiOXZMaU9CRGZ1clNE?=
 =?utf-8?B?T21ET3hKQVhWU29WZ3hweUFkVlExckI0aGVhUEVKUGlLdWZVdTJoRWJsalhz?=
 =?utf-8?B?Znd0cmhkdDZMcFNZeWhNKzZkbnBzQ2o3ZTU0NUlFRGNJRGtvYnJMQWFxTTkw?=
 =?utf-8?B?eDJ4MWM5Ty9VWTNvWk0zZEt5ZmF6ZlhCWE9yUERuRjRmaDUrWTM0Rnl1RDB3?=
 =?utf-8?B?RjFmK2I3SXdJdDZrVTBoNUxGeFBhOWdpWkh3bUE0YUdFblZiUW1SRnUvZGti?=
 =?utf-8?B?K3pMN0JSdkNLWGFrcDRINk85LzNVa3JqOGR2bEhMWmdIZ3YxSlZjSFZMUHM0?=
 =?utf-8?B?d0gxSGFEVjFCS2VEcThVSUdjbXhyNllLRWFhL0N5TThMVVlUWVcvSmNYemE5?=
 =?utf-8?B?TWJwVFF0OUk0WVRuZTI3SWZKZlpWRzJ4T2hJNUR2am5QVDlMUGlWVDRlVEtt?=
 =?utf-8?B?OHIvNkh2ODNBWmVRODlORmpSTGNMTVd3ZDB0bUZNMjZNRUZmQURWSGU2NThF?=
 =?utf-8?B?RE9wREpYeW9VMW1rU3BuUk9HWGpJa0tjWmREZnQrcFUrTW4zSjZsWmpHRFZX?=
 =?utf-8?B?SXdObTc4TVA5RGZNbjNQOUNLK3o2UVZVQnJZVDNybHAxRWJ2TExvZ1RxcTlR?=
 =?utf-8?B?amxEYnAwREsrWjYwelIrVTl5UVBuUXh3dmNBMWNUbE5Hck1ZcEQraGZvS0Fz?=
 =?utf-8?B?VHoweFJpa0cvd2xsaytQWjc2Wi9jSVJWTkJyT1lWZFI1dm1CS0lGMkdGblNa?=
 =?utf-8?B?UkorNnNpT3BhaEc5T2tlcEgwZS9kZ3FIc2tvSENMTS85dzA5MHZCK1hwWFNW?=
 =?utf-8?B?aGZ4c0tDamVzM1pyQXkybGN4czN2NHU2T0F0dlgrb2VVY0U5M01iYWdRMk81?=
 =?utf-8?B?L1p4Skl6aktZKzFDdldIUnRLRWpMTTR6N1QvSGI2dFdQNytEbisyUG5ENDRL?=
 =?utf-8?B?bHB3cGh5Y0twVGNnc1diS1lPN2dTVkZDMlB3eWFVNmE0a044NjVGamE2MHpS?=
 =?utf-8?B?eGp6QmFSQUpTcGhDTFdUOHVZREZkOW1LV2VCNC9BbHF4SEVZaDRoTzlvcXN3?=
 =?utf-8?B?MXRMbUdLRjcrQXNoZThhM2t6UDhUUUZXQ3lpT05MZG9lYU5zZ1BnUnJaVGNS?=
 =?utf-8?B?dW0yL2JHMjlrU1RBb1lBRHBjcDFyK2hqbTJYN1k1czFpQ3d4cndnUFd3ZnR1?=
 =?utf-8?B?dDVUQm1vK1lQTlFsTWt3OFdTcXErZ2JNOTBuYUlVRHlJY0FublFKQ3BJaUNR?=
 =?utf-8?B?amhlcGNGQXA3VHFET3hxTGppNDlRYzhuMjRhOXhOb1JJajV4aG1HcmZLanpV?=
 =?utf-8?B?U0lmczdnRkFHbzZqdmRHdTBLK0pWYUh2M0tFdWVEZThwSWpleXRLR2dMUkxY?=
 =?utf-8?B?eHVIVC83eG93L3RzVTArUnFQNXN5RVVYMTM1UXRYY0huNGRLNTdvSWZmdDgz?=
 =?utf-8?B?OS9GcDdlaU5nLzRVQXFZWis5ZURYRDhDLzZBTzNNdVROTVJyRDBYZVlSSWhM?=
 =?utf-8?B?c1hTeWVkSXJyRWRDbk1kcXFWSExHdkdBQ3J3WUV2WEtWSWFWOVp1ZkI2MVVY?=
 =?utf-8?B?bGhwdGpBWGNmanNtbnZHY1p2UlFxRnFLaEVubDd3WUMyQlllNmM0NWQwamVa?=
 =?utf-8?B?QlpjWVZ5UkJndXpJUncwYStRVHRyL2JvcDdaNXJ4OGczZWkrRGExaFIvY1Mw?=
 =?utf-8?B?ZnRnY3J0SVF6ZDJkWFdSSklrNXg4Nkp4ajdsbXhibjZXeGNzVENla1NLVGxk?=
 =?utf-8?B?TjJrMGl0eUFsRXlLakVISGd2ZVNlTDlWRnBjRVlxaDNPRk12QVh4MFl1QVhx?=
 =?utf-8?B?WnRKcS85OU5wQ1MzSVF0WUdDR0N2QkJGUDNaa1N3Yys2UWFMWWpQdHh4eUdi?=
 =?utf-8?Q?/c6f5YbkMRYxbfG6WJIKj7Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79C236FAD3640743B2286AE361A294B4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e69148c8-fb42-47ae-84a1-08dd670feadb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 18:00:21.8620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/92fU4Xa5R52UZ/7pBFVSCUxXMa4JimMEgbSRT50Mk3bGOSmL6J18TXUaiQSoeRk9R1DLRyqsLb1s5LVYrkq9SZlXiyGCQ3uz1YAitf2FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6130

VGhhbmsgeW91IGZvciB0aGUgcGF0Y2hlcywgQXJhZGh5YSENCg0KT24gU3VuLCAyMDI0LTExLTI0
IGF0IDIwOjA2ICswNTMwLCBBcmFkaHlhIEJoYXRpYSB3cm90ZToNCj4gUmVnYXJkbGVzcywgSSdk
IGFwcHJlY2lhdGUgaXQgaWYgc29tZWJvZHkgY2FuIHRlc3QgaXQsIGFuZCByZXBvcnQgYmFjayBp
ZiB0aGV5DQo+IG9ic2VydmUgYW55IGlzc3Vlcy4NCg0KSSd2ZSB0cmllZCB0byB0ZXN0IHRoZSBw
YXRjaHNldCB3aXRoIG5lY2Vzc2FyeSBwcmUtcmVxdWlzaXRlcyBhbmQgRFQgYWRkaXRpb25zDQp3
aXRoIGEgc2luZ2xlIGNoYW5uZWwgTFZEUyBwYW5uZWwgYW5kIHdoaWxlIEknbSBub3Qgc3VjY2Vz
c2Z1bCB5ZXQsIEkndmUgYWxzbyBub3RpY2VkDQp0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQoNCnRp
ZHNzIDMwMjAwMDAwLmRzczogdnAwOiBDbG9jayByYXRlIDI0Mjg1NzE0IGRpZmZlcnMgb3ZlciA1
JSBmcm9tIHJlcXVlc3RlZCAzNzAwMDAwMA0KDQpldmVuIHRob3VnaCBsYXRlciB0aGUgY2xvY2sg
c2VlbXMgdG8gYmUgY29ycmVjdGx5IHNldCB1cDoNCg0KJCBjYXQgL3N5cy9rZXJuZWwvZGVidWcv
Y2xrL2Nsa19zdW1tYXJ5wqANCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5h
YmxlICBwcmVwYXJlICBwcm90ZWN0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkdXR5
ICBoYXJkd2FyZSAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25uZWN0aW9uDQogICBjbG9j
ayAgICAgICAgICAgICAgICAgICAgICAgICAgY291bnQgICAgY291bnQgICAgY291bnQgICAgICAg
IHJhdGUgICBhY2N1cmFjeSBwaGFzZSAgY3ljbGUgICAgZW5hYmxlICAgY29uc3VtZXIgICAgICAg
ICAgICAgICAgICAgICAgICAgaWQNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGNsazox
ODY6NiAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgICAgICAgMSAgICAgICAgMCAgICAgICAg
MjUwMDAwMDAwICAgMCAgICAgICAgICAwICAgICA1MDAwMCAgICAgIFkgICAzMDIwMDAwMC5kc3Mg
ICAgICAgICAgICAgICAgICAgIGZjayAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2aWNlbGVzcyAgICAgICAg
ICAgICAgICAgICAgICBub19jb25uZWN0aW9uX2lkICAgICAgICAgDQogY2xrOjE4Njo0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMCAgICAgICAwICAgICAgICAwICAgICAgICAwICAgICAgICAg
ICAwICAgICAgICAgIDAgICAgIDUwMDAwICAgICAgWSAgIGRldmljZWxlc3MgICAgICAgICAgICAg
ICAgICAgICAgbm9fY29ubmVjdGlvbl9pZCAgICAgICAgIA0KIGNsazoxODY6MyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDAgICAgICAgMCAgICAgICAgMCAgICAgICAgMTcwMDAwMDAwICAgMCAg
ICAgICAgICAwICAgICA1MDAwMCAgICAgIFkgICBkZXZpY2VsZXNzICAgICAgICAgICAgICAgICAg
ICAgIG5vX2Nvbm5lY3Rpb25faWQgICAgICAgICANCiAgICBjbGs6MTg2OjIgICAgICAgICAgICAg
ICAgICAgICAgICAwICAgICAgIDAgICAgICAgIDAgICAgICAgIDE3MDAwMDAwMCAgIDAgICAgICAg
ICAgMCAgICAgNTAwMDAgICAgICBZICAgICAgMzAyMDAwMDAuZHNzICAgICAgICAgICAgICAgICAg
ICB2cDIgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGRldmljZWxlc3MgICAgICAgICAgICAgICAgICAgICAg
bm9fY29ubmVjdGlvbl9pZCAgICAgICAgIA0KIGNsazoxODY6MCAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDEgICAgICAgMSAgICAgICAgMCAgICAgICAgMjU5MDkwOTA5ICAgMCAgICAgICAgICAw
ICAgICA1MDAwMCAgICAgIFkgICBvbGRpQDAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlcmlh
bCAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZGV2aWNlbGVzcyAgICAgICAgICAgICAgICAgICAgICBub19jb25uZWN0
aW9uX2lkICAgICAgICAgDQogICAgY2xvY2stZGl2aWRlci1vbGRpICAgICAgICAgICAgICAgMSAg
ICAgICAxICAgICAgICAwICAgICAgICAzNzAxMjk4NyAgICAwICAgICAgICAgIDAgICAgIDUwMDAw
ICAgICAgWSAgICAgIDMwMjAwMDAwLmRzcyAgICAgICAgICAgICAgICAgICAgdnAxICAgICAgICAg
ICAgICAgICAgICAgIA0KDQpMb29rcyBsaWtlICJjbG9jay1kaXZpZGVyLW9sZGkiIGRvZXNuJ3Qg
cHJvcGFnYXRlIGNsa19zZXRfcmF0ZSgpIHRvIHRoZSBwYXJlbnQsDQpidXQgdGhlIHBhcmVudCBp
cyBiZWluZyBzZXQgbGF0ZXIgaW5kZXBlbmRlbnRseT8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRs
aW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

