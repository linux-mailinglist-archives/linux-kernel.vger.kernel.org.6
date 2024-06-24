Return-Path: <linux-kernel+bounces-226505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE8A913F54
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A554B1F21AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C533637;
	Mon, 24 Jun 2024 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F8myoMX2"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A549173
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719187623; cv=fail; b=Gq+oyHvRYpLF2RBy5fOp87+OThysTO+ATuz//L6hxH6gzgYW0/lWGoOq5toZn5ZoCMCrCssTP1Bpc0gg1aBoBuwL0tGgE0pXtBwtue0cYTPtbNtHTPPcjkfeoYIlDGwveXuFS0yRNrZqcYK1E07OM2+DJIqN3RXjYBZcQn/x3EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719187623; c=relaxed/simple;
	bh=fYfPEJ6AxF6Q6+7ZiD4QT0LkDUZ8VOmZav6M0SZd3DE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uNvgLV0NveaqVOAqrhOVSaPQ1UqSxZGCgZRIRc6CZOhTJv4KDuBiki00FVhHg88zLF5fyJpGk4fY1PJKzPA5aETiDEImMvXVH/And37k6yMmu+KH+LLrOYG812XVk6qMPmFhntuuM0+lWArRMWzpFPbc7rn/V6ACwGy1iDutpn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F8myoMX2; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn1+81K26JqBA/8JWnxrpLZZ4rtBldtMblZMkqLz21E4YKaNv9BCIL2tdNy2XlGfh8R+kYEdwIN8L30RxaG3FcZdodyGmskvXX8Y2xivVWEPlAPeGylDzslVbo+jKZ1e71taNiH/MY381nYvzroMv6lt6ZNkfzhYEVNPrI+pBtw6/gHZsK5nXTHOwQC0KUDiRhM+cYqDhufiA8HF8n+e4ovuS/dXi+88jT9EfIgXne3u8hueymURZ/7r+psF2rlh4UvHR5etFRHNLlOKgUQETGjOa+piRmok8XvDhaA/yUoac8tEyzfD2LwR19p0D2BENIwlL5gL5lBlPKkjcAuhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYfPEJ6AxF6Q6+7ZiD4QT0LkDUZ8VOmZav6M0SZd3DE=;
 b=aLZxepFWsFNNdQ2z3t0HMVKCAnzdt0SoxjqchDANA56JbdV7xxwsHcb0FQXumvvzdMXyubGSblnW+ymEdHKuy6qQdPpLYFSPjWXwmUeGdgYaaNFDDNh9Idx5j6XBlMp3CeZ3+Bh05DrBg2thNd4IGj2fdqKnyLx3t1iWFpR7SROwShH6S30dEvr0UJCeSWZEyNzKr3mr/3jAFj0iREhWyhTVWFm6X3ukfobjOQMfyIp9EL4q25aMCuAqsefv3kU1N0UHGS/It0JvuZnSxhic7AfF7PnOR+8BxgcciTpT/e7X05u5AyQ+DSl7inJCn4ADqNh51BC9g47/n8o/Kunj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYfPEJ6AxF6Q6+7ZiD4QT0LkDUZ8VOmZav6M0SZd3DE=;
 b=F8myoMX2w9w+DCAxzW5tTm2lgKiKSUB3+vt1l6sFcxmAb1PQMCUgjKHPgEpb4QmCCy37Y4SG/7ZKn/rE4FWoPPg6MrPNZCARygV+S3ZsSCTKmFmrQvudk6liB49rV6bTCyHgkrCbPkIptNVF8RVfwPUZg01nceC6RlwMfKM2jac=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DUZPR04MB10063.eurprd04.prod.outlook.com (2603:10a6:10:4af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 00:06:56 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 00:06:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 1/2] nvmem: kconfig: set i.MX OCOTP default y
Thread-Topic: [PATCH 1/2] nvmem: kconfig: set i.MX OCOTP default y
Thread-Index: AQHatYJpTf45oXyOSESugzrK2ig1+LHTuAiAgAJxLKA=
Date: Mon, 24 Jun 2024 00:06:56 +0000
Message-ID:
 <AM6PR04MB59413C0889EA0606996324B488D42@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240603070007.2413599-1-peng.fan@oss.nxp.com>
 <7b97ef5b-a3e1-4c02-a013-2bd1c97a0e65@linaro.org>
In-Reply-To: <7b97ef5b-a3e1-4c02-a013-2bd1c97a0e65@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DUZPR04MB10063:EE_
x-ms-office365-filtering-correlation-id: 69747503-ce1f-48c7-836b-08dc93e18f6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUNrSlc2blc3Z2RnSWhUYlFNb0o5cEVzQTRYalVOaUNWcDFGOThVRFdwcm9P?=
 =?utf-8?B?dzZzOHNkdUdZd3NwcFBwZ2hyeHg3NThFYzl6Z3FLeGhTa3hIcEg1OGZDdWJF?=
 =?utf-8?B?UERKTHltb2xNK1VYK004T0REQlhPdEk1akM5aHV1R2IwQ3JPUTRBcDY1L01M?=
 =?utf-8?B?ZmJ1UzhVQW1TVGkwY1RvSGFLVitJRnVremlRakFEdmhyTDdqeHB1ZlZKK3ZP?=
 =?utf-8?B?MEtiUUtnQitKcUx1aGRkaEJhUml2T0ErSDdHNTBKSTVVa2RFbHNaLzF6SElC?=
 =?utf-8?B?Q01UNS80MnJtZmFGeHYxTkNYdXBLUTBkVFRjc3I1aS9rSzhCbmVoV2ZNUTNR?=
 =?utf-8?B?ZXpFWjdXSHovMWcyNGNsOGVoZW9QRTMvMmR3anF5MXlOcEZ3MDdSeUQ0Q0NX?=
 =?utf-8?B?blM1Sm9YSVZpelhPbUFQUjh6Y1djT1NobkNnVU1hZnZKQysrdUpTZkJzeFIw?=
 =?utf-8?B?R1dxZ3JUNGxQbmtTT2I4L2hZQlRSVjU3WWU3UTJ4bHo2dm03bFJDM01aSXJJ?=
 =?utf-8?B?ZnBCOGIxQitOQ3p4VVVCSU1FSklIMk1iV2RldTBOaytMamlNSEk5TVlTeVVz?=
 =?utf-8?B?K1grSEltZ1d6d1g2S0N6UllUWnhVYXlNaWxWU3BJT2FBTU9nd2VEa0VObHds?=
 =?utf-8?B?Q0prSXl3cFVwTThCVlM2UG40RnhLZldPbThERmVHYUgyYU9VQ0t0MTI4cEQy?=
 =?utf-8?B?L0tPMDRDYlJBbmsweFY1RndYM3psYVljallOOFg4bzRDblRFcFN3dnd5ak43?=
 =?utf-8?B?MWJrMUY4UjJFM29JZE5RbkxxY2l6c05ROEZhbEVteTFhQ2JESmR0L25UWmtM?=
 =?utf-8?B?eDZKWHJXNkR5QjJBZ2UxUWRpYVlpQTJXL3FQRUVqdnZqNXNYMWxOWjJSN016?=
 =?utf-8?B?RVdDcEJORXpZd0dOU2NZTTNSdXQ1bmw5eUE0bTQ2cmQxVGpxcmVRWE1yL21v?=
 =?utf-8?B?SDEyM3pmalg5VWFHNVloVTQ2dUtmek9TT3BsRkQzTzFTTSt2Ykl6SWcrM05B?=
 =?utf-8?B?NWYxcTdvMkZoY1BEYm9PcGhJNkZKM20vb1NtSHlWTHcwRS9XSlJYaWwvdUh5?=
 =?utf-8?B?MVB4Q3M4WHNGaWVVcFNuVEw5UVB4YlF2ak1zOEhBZlBTN2UzUXBVNDRnSTgx?=
 =?utf-8?B?cFhKaTV3MTdjYjNsQ1IvWTFEdUlZazdTQTVVWFpqMlZFemI5a2xocm9sVFg0?=
 =?utf-8?B?dEhOM0JRdnM1bEMwUGNaczZ1WmdBN3Q4eGl4L1ptbXZ0NUw5U0p6V0QzYndV?=
 =?utf-8?B?TFpPMjljMnhWMWVIYWNlUlJDOG5OcTNrL0J1bys2cmRtNzdDKzZOQ3VacUps?=
 =?utf-8?B?M3dRVlMxZnpqYnZxanB4SVJZWVErMWNlWlhTdEx4TGJ5SU5zb3VrZXJqZ3R5?=
 =?utf-8?B?WXpNaGppY3Zsb1FEcnRJSllqRXZSQkxWbUJKclBjd2J0d2FlZyt3UDdWaDl6?=
 =?utf-8?B?Vnh2MVVnblN4QlVPVkVXbEZNS25uaVdMTmdGdUw1NFZPRjhLYlJzc0tiUk5l?=
 =?utf-8?B?OEN3NVpzbzF2M1ZMcWlxWmlVWkJYWEx1bUg0akI4a1VkZDl0bWxYQVNWRURo?=
 =?utf-8?B?Z3RQVkdNN1ZXN2s0djJnUHRnYXdMNlJmUzREelUzMGVlVWU3RGcvc2hCY29Y?=
 =?utf-8?B?d3pEV1RvRCt4RWh3bXFwditzNnR1em96bmd6TWNDenJ3MmY4R0xqN2VFMHhi?=
 =?utf-8?B?dzJXcHdPMzhhVWdjdUI3UVNjdnBSU0REMXlOL1VCazdwZGhQdTAzTHY0b3Q0?=
 =?utf-8?B?MVdEM3pZdStzdHczY0QwaTJ3YXhYRTZPWTc1QW5ZNitFa3dpcC9ZMmxINENV?=
 =?utf-8?Q?wbsHZ49MVfBJcAnF+f/yzcMpKpj3JaZZUiXXI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmNwMHpGd1YyMVdhR00zV25WM3hLeFlTYjJraGpuemhoV1JPUElvREFWajEy?=
 =?utf-8?B?WDN0SkZXb2FKWktsSzNDYjBFMWZEWlhkcEFDZ2xCV2NyN2k4eDZEUGg2SWtV?=
 =?utf-8?B?QlNHS0RhUjVoZUNycEhaYnFERFV1ZXZCWW1vQ2FOdkpDT0tqS3ZiWWlXUWl3?=
 =?utf-8?B?ZUxxU1k2YzBRSWhkS01Yc0dmZkdZOXVQa2gxejVHWEp3dXdlWjNEVHVLZFEw?=
 =?utf-8?B?c3ZEZWxWQzBGaXNmemloRWdqZFlTMkRjV1hVV3lJcnRVeEFKaVZPRUMzazhm?=
 =?utf-8?B?QnpQNzRITG1nRE1DS0sydk9iYnBGTis0aXRHTVlkbW81cW91d3g3dExkQ0Uw?=
 =?utf-8?B?NmkvdHhwVjQwM29sSE1Ia1JqQnlId2hISGgreko0MEwxWWZLSWxzYVI1OWsr?=
 =?utf-8?B?ZCtySGkrQXNKTGkyMEhvQitRNzJSMkt4Q3ROL00vL2Rtd01oTzJ1aWtYb1gw?=
 =?utf-8?B?bm1BL2xoYUdiTjBzOTdaVXlmTXBSbjIrWCsrS1c4ckVRdGQrOC9yVnBGNXpY?=
 =?utf-8?B?dVRYQlJyYVhnbGRRMGdTQUpFeitqNHhDcUozT2Npc3lqZnFYbzBaR0NYNnda?=
 =?utf-8?B?SDFicHR0Y0R0U0t0WDFkZGxVNlN3ekw5dEJiS2M1bDIycCtvL1VHUVZtN0Zy?=
 =?utf-8?B?RkFwV1V6ZHUzTHBjZGdyN28rUWhtZDRIOTdSc1RoekdYOEkvalR4SS9SeE1R?=
 =?utf-8?B?RndhcVh2WkJVaGV1WWNzdUUxSUlQNzgxL2g3QWMvN3JWZjFpQjFnWnVYdkdL?=
 =?utf-8?B?RElacXh4elBneHNUSTYrMHc5RnNuQ2l6eEttTHNtZlc3alE4S2Z1dUZLMXZv?=
 =?utf-8?B?bFJIZzUwZnpvZWs5QUh1eUs5YnVzeFBDTG5LRjJMbWhndWlhMENuTm1CN0tO?=
 =?utf-8?B?ZXZsNTJWTzRDaEZQTllxNjRyZEdiSDRsMzNPV0ZRNlhWS2NtcU1La1h5UTJn?=
 =?utf-8?B?L3A0R3ZYVnc1NTgwcU44dTJHVVFkS002S1JNRFJMNVY1RUpieTZ5akU2ZWtF?=
 =?utf-8?B?VGdaRVdLWU05UjVzN05jM1FBK29KSEExRE9YRjlMY2VkZ3lFeGQ2aTgvOWs1?=
 =?utf-8?B?TXM3V01RSThXaG1OdW1pVVJ0TDFtREltdjdyOXlZMGdlRm5VSWZXN0lxUEZy?=
 =?utf-8?B?MDdzZXIwUHRYSHpPekQzYW9HV3lxK3dmR1d1ZE5JTkRGWXYyNlFYYkgwT3JI?=
 =?utf-8?B?cllLMDNjWVM2ZW44SHRtQTVsRVQwdEhwVjJOTGlLSHEwaDB1bGV4UUQ0TUtO?=
 =?utf-8?B?My9xb3pVdkRqVFdEbUx5MWVxVktYSUpNZnJTbEZXd05Ca2M5dFI5RC9uWEM3?=
 =?utf-8?B?Smo2QVNIRTR6OWVEbTgwUHRzbjBmR2hEVTJ0eTZKS2twS2huSHNod0FWT0kr?=
 =?utf-8?B?ak9jaG8yem8vV2pFVy9oaUUwWTVkTm1JQm12bU4wc3dxaDVyaEJhUXUwU2gw?=
 =?utf-8?B?NXpsQ1VaUzcvR1Q3cnQ4WDBFa1hXUkRDYXRiNUtYR2dYZHQ0bU1SUDRJM0lv?=
 =?utf-8?B?L3BBa3hyNFBrczFWZGgzY1FFckErWTJLcFFoVFVJMWxrTnRlQ3BMekZ2VGRB?=
 =?utf-8?B?UldROERyTHQ5OEIvQWowRDFKL3RsaUNiUEdFdzlONkN3d3k4c0VlMXlkdDdt?=
 =?utf-8?B?ejhmejJiMTl0MUNsVytyZ0t0eWFwcE1zSjRGVXExckN3a2Y2RXZpL2tlNExT?=
 =?utf-8?B?dUloell6djA3Mkd0bDZXN2kxeXNkVFZmQjBqRnRGZGc4dUtOaFN5NEU5eWh1?=
 =?utf-8?B?OTR0RzRmS0xvc05wNkZtZzVlejEvMWVpem5lZzBDZWJMYTlkZ21uajlMeFNJ?=
 =?utf-8?B?UVdQRFp2YWlrd0FpalJYYXY4RUxDc2tLUjJjQW0xa1ZhRHVOcVlCSXBHb1Mx?=
 =?utf-8?B?NU42NXJ4bllwcE9KbFJYbzJqcGdqZWNIajBidGgvYUNhK285Wk5VMjZGRjlH?=
 =?utf-8?B?M2RYZXdTUXlzNTBHNHp6RDZ3WUJoMDIvVko1NGJQQmJ1V2doRUVjNXo0Y2Nr?=
 =?utf-8?B?cVcvemxEQmJTNXlaOUdNM296ZnJVNnNReUVWMTdQUjBJZkVPelM4UTR6eGNO?=
 =?utf-8?B?NGtqb2VscFNOSGpFdzJ2VGlVdjRrV2pMQ2ZrcTFVNTBreStSNS9NeStYWUJR?=
 =?utf-8?Q?kcrY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69747503-ce1f-48c7-836b-08dc93e18f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 00:06:56.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80Isk+T6GDsEsY5z6veyYCqCRsS8oyaHMnUBFU2dk4Vc5Qh69kMpkyZJffe5qvFIlIhQg1rnRiWr6T/zp56DNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10063

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gbnZtZW06IGtjb25maWc6IHNldCBpLk1YIE9DT1RQ
IGRlZmF1bHQgeQ0KPiANCj4gDQo+IA0KPiBPbiAwMy8wNi8yMDI0IDA4OjAwLCBQZW5nIEZhbiAo
T1NTKSB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0K
PiA+IElmIEFSQ0hfTVhDIGlzIHNlbGVjdGVkLCBzZXQgTlZNRU1fSU1YX09DT1RQWypdIGRlZmF1
bHQgeSB3aGljaA0KPiB3aWxsDQo+ID4gbWFrZSBuZnMgcm9vdGZzIHdvcmsgc2luY2UgaS5NWCBu
ZXR3b3JrIGRyaXZlciBuZWVkcyByZWFkIG1hYw0KPiBhZGRyZXNzDQo+ID4gZnJvbSBmdXNlLg0K
PiA+DQo+IEdpdmVuIHRoYXQgQVJDSF9NWEMgaXMgeSBpcyBkZWZjb25maWcgYW5kIG1ha2luZyB0
aGVzZSBkcml2ZXJzIGFzDQo+IGRlZmF1bHQgeSB3aWxsIGluY3JlYXNlIHRoZSBhcm02NCBkZWZj
b25maWcga2VybmVsIHNpemUuDQoNCg0KUHV0dGluZyB0aGVtIGluIGRlZmNvbmZpZyB3YXMgYWxz
byBub3Qgd2VsY29tZWQuIE5vIGdvb2QgaWRlYQ0KZnJvbSBtZSBob3cgdG8gYWRkcmVzcyB0aGUg
bmZzYm9vdCBpc3N1ZS4gV2Ugbm90IHVzZSByYW1mcy4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiAN
Cj4gLS1zcmluaQ0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbnZtZW0vS2NvbmZpZyB8IDMgKysrDQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9udm1lbS9LY29uZmlnIGIvZHJpdmVycy9udm1lbS9LY29uZmlnIGluZGV4DQo+ID4g
MjgzMTM0NDk4ZmJjLi43ZTkyZTg1NWViNTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9udm1l
bS9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9udm1lbS9LY29uZmlnDQo+ID4gQEAgLTc2LDYg
Kzc2LDcgQEAgY29uZmlnIE5WTUVNX0lNWF9PQ09UUA0KPiA+ICAgCXRyaXN0YXRlICJpLk1YIDYv
Ny84IE9uLUNoaXAgT1RQIENvbnRyb2xsZXIgc3VwcG9ydCINCj4gPiAgIAlkZXBlbmRzIG9uIEFS
Q0hfTVhDIHx8IENPTVBJTEVfVEVTVA0KPiA+ICAgCWRlcGVuZHMgb24gSEFTX0lPTUVNDQo+ID4g
KwlkZWZhdWx0IHkgaWYgQVJDSF9NWEMNCj4gPiAgIAloZWxwDQo+ID4gICAJICBUaGlzIGlzIGEg
ZHJpdmVyIGZvciB0aGUgT24tQ2hpcCBPVFAgQ29udHJvbGxlciAoT0NPVFApDQo+IGF2YWlsYWJs
ZSBvbg0KPiA+ICAgCSAgaS5NWDYgU29DcywgcHJvdmlkaW5nIGFjY2VzcyB0byA0IEtiaXRzIG9m
IG9uZS10aW1lDQo+IHByb2dyYW1tYWJsZQ0KPiA+IEBAIC04OSw2ICs5MCw3IEBAIGNvbmZpZyBO
Vk1FTV9JTVhfT0NPVFBfRUxFDQo+ID4gICAJZGVwZW5kcyBvbiBBUkNIX01YQyB8fCBDT01QSUxF
X1RFU1QNCj4gPiAgIAlkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiA+ICAgCWRlcGVuZHMgb24gT0YN
Cj4gPiArCWRlZmF1bHQgeSBpZiBBUkNIX01YQw0KPiA+ICAgCWhlbHANCj4gPiAgIAkgIFRoaXMg
aXMgYSBkcml2ZXIgZm9yIHRoZSBPbi1DaGlwIE9UUCBDb250cm9sbGVyIChPQ09UUCkNCj4gPiAg
IAkgIGF2YWlsYWJsZSBvbiBpLk1YIFNvQ3Mgd2hpY2ggaGFzIEVMRS4NCj4gPiBAQCAtOTcsNiAr
OTksNyBAQCBjb25maWcgTlZNRU1fSU1YX09DT1RQX1NDVQ0KPiA+ICAgCXRyaXN0YXRlICJpLk1Y
OCBTQ1UgT24tQ2hpcCBPVFAgQ29udHJvbGxlciBzdXBwb3J0Ig0KPiA+ICAgCWRlcGVuZHMgb24g
SU1YX1NDVQ0KPiA+ICAgCWRlcGVuZHMgb24gSEFWRV9BUk1fU01DQ0MNCj4gPiArCWRlZmF1bHQg
eSBpZiBBUkNIX01YQw0KPiA+ICAgCWhlbHANCj4gPiAgIAkgIFRoaXMgaXMgYSBkcml2ZXIgZm9y
IHRoZSBTQ1UgT24tQ2hpcCBPVFAgQ29udHJvbGxlciAoT0NPVFApDQo+ID4gICAJICBhdmFpbGFi
bGUgb24gaS5NWDggU29Dcy4NCg==

