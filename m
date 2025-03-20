Return-Path: <linux-kernel+bounces-569360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652C7A6A1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CD03BCE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4758021CA12;
	Thu, 20 Mar 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="RTE2HIWT"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2108.outbound.protection.outlook.com [40.107.215.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD6211710;
	Thu, 20 Mar 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460812; cv=fail; b=D4PiI8Y1LCLYMsnqdby0w5CMxBgM01DPYmEmMYfTxEN9PRfvmyvy3W1bB2siB93W/OaK4ob7C6bYvg3TNbmYzpsz5VTpIgkChpsMc31AUW7WMXkJMEl5p6tNFNDFXcVrLRTSCk/xnFkZaPmLZmwVhwajLugy4tnF57lSSRlnjxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460812; c=relaxed/simple;
	bh=kW135uaGtsDn/9FVkVOtNM/yldsFTyf1ggZXm13wtXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g7WozAYA5cF1a18fcMSNp/bWlwO1cUSZ/oqeR28TONF3kI0zv9zup2As5EVbLU/uyDCxRZeF6iDYtIDkAEEpu7oYQC5YrVf705K8tMe/R5BFRJfYUMwrkIKjgv4fUSCJrDOwhVwtKKkgoqZXDYPgtZQB3GbIogODW1NYvX1prfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=RTE2HIWT; arc=fail smtp.client-ip=40.107.215.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyADzLFrTOX5HXA28+UtgGGsOkNBY/C/Wvn2ohimpoNszs3IQIdhEe641VsJ5pfs7FeQLsrb3WXYFZkjC5Isz1HNTPtqkpklq9moeAjERODVwCQ+WiWaNeMuAQrra9etLClYk/pICoGt15X6yPchgFffosUlboKNmZPSRZULnQn/RDmwxq+uCSVESGTaZnN1NqaqgF81YlJDqhJIWTjFrIYt5crfaKvAQ7mbPUOQP3JY3aMnrHl7O+TbgbshGC2c6guu+fVDmGmq6mpiN1j3F54ncUt2Ybr6FEvEExC1i7x9FobHcyNtfqsfZc50UOY5UEXtb1KyK0GFrtJogR5o/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QuVi5m8TMQr1+OfyBDP3z2m8Fi/bOwH9zDg5M72r78=;
 b=ZPsmz5tgCFymbmtGSvBCmXwaKF7mgFXFzJtgtiKMomOINpoomF9TErx+zMh4gYDe/aCn+vyUYAGbiV9YWbE8Kd8yS4KT8GfqfYBAwNVIG//HuBS1c7lQRCekpZHSrCQBUSibLDRWl8WTwP4JKDURC4pgoOPcj43QEpQzoHGdiSPC66x9ohWbMLEMmN6XkVOwJEaxweN+ooCh1NjnQfyiQ96T9TcW6ln4ZkbBdqLJJuxMPoEnIpKUwABmc+HJ1+fPNT+izjbC5unlyIIeGtaBUadXhH3IHJu2NV2GXr8NLlZrynEWX8kvxZE/3neXqe5xIfmIhl8vR2lZjiEx/FhlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QuVi5m8TMQr1+OfyBDP3z2m8Fi/bOwH9zDg5M72r78=;
 b=RTE2HIWTLFTrH8mOoyN/k0jWLzYroZQKhjkcKjkFe5C211GsUjWuzYIJ/8qwcsZf9RdYjqgfyxxh2WigmC/0vo/R4rCccXiADYkufzq7LTf5OtWWhrE12YCYGizWhFCnu5remUNn5MKYsrTCF5bBaEJmQ6Pc1Sqw2XCHGDUFN4fz4kNBmy2mqVS/jlNi8rLanr1zf6TMDKKNe0MShLCKfW/qtBtV538QBY+VlCxZEZMA4GtOPI4PKJZ3taoyqAmPBwhpW9CFxQ9gNZrzJhf7VtqYNexHU3Ws+Kzq2NRD6tdLf4AeVlqeLLkR7mjP7CtdG/jGA/ESBTEIUboAyUv8sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by KL1PR03MB7717.apcprd03.prod.outlook.com (2603:1096:820:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 08:53:24 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:53:24 +0000
Message-ID: <1d2f7290-a126-4e6a-a4be-17320ac8e3b9@amlogic.com>
Date: Thu, 20 Mar 2025 16:53:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] ASoC: meson: g12a-toacodec: Add s4 tocodec driver
To: Jerome Brunet <jbrunet@baylibre.com>,
 jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-4-686867fad719@amlogic.com>
 <1jfrj82ioj.fsf@starbuckisacylon.baylibre.com>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <1jfrj82ioj.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To PUZPR03MB7135.apcprd03.prod.outlook.com
 (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|KL1PR03MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f7aabc-ace8-4eb3-c421-08dd678cac88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1JIRWN3dnhVQ0dYWFA3NXpSN1dZdkpNa3pWMEpPcmN4WDAzdG01RmIwcmZN?=
 =?utf-8?B?YjM0aGdNMFkzTHFEdmdlN0xyMW54OE1xNmNLQ1pyVTRNaVZyRTc2VUg2VDRV?=
 =?utf-8?B?bCtFeXZVTEsrSGUwQXFQYzJjc29KaXJXMk1HLzZjc2JjVmpwQ2praXBhUTZ4?=
 =?utf-8?B?K2lnanhBNXNyTU4wdjVRU0lCa2d5MDdwNU9UaFYrZS91UFU2T3h0Q2I0VGZj?=
 =?utf-8?B?K2kxUzIrZG5QaHF1YWU3ai8yMm9Jb1BQQUs3eVhoTHZKVzFCa3BvLzdBS2pX?=
 =?utf-8?B?UUZKVkErdGt0OGU3Z0lueHFkdGNCK0xMckNIVXJRRlh2RkNYQzcvUGtVZU1l?=
 =?utf-8?B?dEI1OFY1NHpsSndkQ0d0M0ZUTWFYT0hhQWNOSEpyLzNGODRjbEh1a1kyLzdV?=
 =?utf-8?B?dm9QVlhsejRWVVZOWHh1ekZVQTgyOGxNQkY5YVdSTHdqVmYwU0VVM0dJeE80?=
 =?utf-8?B?UUNyUUJiVmd5UHcycmdYRS9ZNFVuOTQ1eS9vRTBTajNtMFZDY1RzYnp0REJw?=
 =?utf-8?B?ZVN2NkZ6OFBVYVdJU0lJTnBkNW5Ealc3djJ4Z0RrK3BXVFRHaUIzbWtqOFlv?=
 =?utf-8?B?OXh5bVppc0N3dVcyY0s4TWtjcldJaUV6TFIrYkI5SEVDTkZxRWgyUDZScmZV?=
 =?utf-8?B?bEptWG9xZkgyU1ZESWNUeFltNUhYZWI3TmUrZTdwTkcwbE5DT01tVU5vYzFL?=
 =?utf-8?B?K2dKZEZEa0JvYTlvelhDWTI0ZTk2WjdZMHVyWWJOVUxQVlRvRHlUdDBoVGpF?=
 =?utf-8?B?WGZuRHFzNWk5alM0VStHMDdjVEttckNlaVdEVWJ1VERqVjFCSXNlclBRSGIw?=
 =?utf-8?B?cjVYZVJnRjNXNWdCdkpmNXREVzAyQjFEQ1JraU8zaXhCQjlLM2F0N0h5bGZC?=
 =?utf-8?B?NjM1WUY3KzZxclVMTnZMd3RpRTEwWkx4SlkxaFBHelhJY1dUcWw4bmxPMjdG?=
 =?utf-8?B?S2drV0pTNi9BRGFRamU3MlVGV3Q1aXZTSy9jeDJJODBDRGJsSlZSTFFMeERT?=
 =?utf-8?B?WnVYVHFKMGxKYVg4VE1MVFNPby9ReHF5WnhuT3lqWnlnQXI5Wm01QWxuMXFs?=
 =?utf-8?B?SnpoYkdOclVNSWNmb0tJSDlUOXVEQ0gvM0wvK2ZCa0ZxREtMOFRia0ZHR2VZ?=
 =?utf-8?B?VnVUMTg4Nk1heTJKVmo1Y0xEOEJwN0pCTjNUMzAyTkhlSUZLY3VIZlhyVlF0?=
 =?utf-8?B?ZjVuVk96NmFndVVrTENiMHFHR2U5WjJDV1FuYnNHTmtzc1E2NmxQYTVzbzhR?=
 =?utf-8?B?MTd6N05oTkFnSUt0RWl5UDBYc2VINmx6YmVENU1VSE1YOGp5UkMvWk9XMGg0?=
 =?utf-8?B?WHdGWXFqTTl6NGlvUTJaZWtDSUJubnhkL0VRekd4aU1kckVtVEoyNUF2NVhV?=
 =?utf-8?B?M0RwcEV4NjY5V3Y3czY2TXg0R1JlNFlnU1hGbUxwRjRHRENHcEtxVG5jWnRy?=
 =?utf-8?B?TTZid01MMm1xcGM2a1Z1R3J2SXpsbzQxQkg5U0M3alNIdzZTOEpzZVJkZytD?=
 =?utf-8?B?MnA3T05FcWkwb2lQbndvQWZaN0VqZzdqSnkxWTJabndrczZselFNWERrTVU1?=
 =?utf-8?B?MGVZZW1ZMnN4dTFvbVNpdEp1eXFZUW0xVFB4TG0vTVRxb0oxeXA0R2hRMjQ2?=
 =?utf-8?B?T3g1cnpZTms3dnVjOVdLbTQ2QnZDTUtUTmJVWFB3OVhMZ2tTQWZnOHQwMWhQ?=
 =?utf-8?B?ZDVyMnJqcHNHckdvM3ZaUVV3dmhUZDIwRkJSd3d5THJtVEdkZHdsYWNaNTB4?=
 =?utf-8?B?SmZhNVNucDRYZXhZQktGWlE3SkFxRzZBbUZkWm50b2lLZFNmQm81Qy9hS3NX?=
 =?utf-8?B?L0tSdkU1OC9KdkE1SXFwMTVDU2NKTXpUdjNSb2w0eExRQmtWc3dPSjVvaHRN?=
 =?utf-8?B?bXNEUGJIYkFPbWdQbG8zam00NjVxcWprK3VLdlNXUkZPS05sOVpNYUphUTNQ?=
 =?utf-8?Q?7Yrn3E6CENo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3dqSnZZOGdHUlJST1FuTkRZM1BhZy9rdmh2OFJ2ZGVjVnd3cHJZQytHYTgy?=
 =?utf-8?B?dlZnYURPVnFNdGZDV2tUbG5yNVdjS3BJS2M3RG82SDN5c0FXT1RBZlYxMkVH?=
 =?utf-8?B?eTJORG5BczU4NjF2WG9VdUtHRC9QckNMNVNGNzNxWjJzOGswTUhscTNQQVRI?=
 =?utf-8?B?TXdKUkFhWTdOOXozRHZNWk1vM3AxM0ZiQ2RQbUdPTWpNOXlqaTZueHY1ZFdj?=
 =?utf-8?B?WThvWWJhWmJKczRyZFFPYllkYjZwZmpaalhPMkl4WmJJWVZWa0Y0dlZkNk1J?=
 =?utf-8?B?SDZxbUpFSzFjRzR2NnhJRzBNNGNJZ2V4YWhOcVZaSXFTSTE0eVFIZGw3eU5E?=
 =?utf-8?B?MnJFTGJVbExFTVJQQThMZ0ZkTUt1MldhSldBQ25yRzIyanVjRVN5V0dGam5j?=
 =?utf-8?B?OTgzUnMvM1hNNXdpU29VdVVlSk8vcXpUYU1pK2FOMEFrZnVvMGVJTExTaXVD?=
 =?utf-8?B?YnFtZ0ZGQ3BNLzVQU2ZVdHVtQ1lRc3A0SGNScEp1QisyUEdlZEt6bm5OYzZS?=
 =?utf-8?B?NmZvVWwvWjJOOVFWR2Iyc1FxN09OeTQwMGx1elllMCtXRFVMMTZmbGJnOCtk?=
 =?utf-8?B?Zm1rRlVrVWh0YVlVTDRFWWZSMi9MTmgxQldVaEt3SzQxcEZ4elJHbm9MdkNM?=
 =?utf-8?B?SEZHSE5TVWlURGlSSWZkQjZPb25iUGJsQTBSeEM5andYOFd6VzlVNmRNaHN3?=
 =?utf-8?B?M0gvV3NFTGNHWDhFYUtyUUtuNjQ4Q2k3TzhERW1BSGZFYXpvYUd4N0ptVEQz?=
 =?utf-8?B?ay9ndmNhT1lGajJrYTFyb1F6Rm1LSzdwWkMvTW1lejBXZkdsNHpmRWd4Vk9D?=
 =?utf-8?B?U0NDUHlROHYzWEZyNnQ2NjdwK2pWeXU5WUFnclpGY1NVTXN2aGhJZVBlQVdH?=
 =?utf-8?B?ejFObnc3UHZRbzRxWWZDQ3pGaVdVOXFyeHk0aXZEejhBTDZNQTFHcUNYRkI4?=
 =?utf-8?B?T0ZHOGJsUG5XUzNZUnBoQWczQ2orVXRYMXZ5SEpEOG16RkJxRDZWUUZYYlZo?=
 =?utf-8?B?MlRCbDJHK0hEUUYzY3llb0JIWmlibVkwa2ZTNFJvVkkzZGxER21ubXpnTVJ3?=
 =?utf-8?B?eW43ZHlvbUZwMXlDTlZzUTRqQXcwWlA5cVJGWGEraFRLZWlwNkNPb1JFZHNS?=
 =?utf-8?B?VDEzMW5zcXlGTmd0bGRhbVdiU0NTU0pvSUJFQUZXdzg2WmNrb1J0NExndGRs?=
 =?utf-8?B?K0dTcHdOeXR2YS8xT0N1cVd6NEwvNko4QVNCSDM1aTJVckhrMU55Z0JQNndG?=
 =?utf-8?B?MkZuQkdTcVA0UUNSVGc0RkZKV2dsaEdxalBCNDRwbkFHcUgxZ1plOGZmc2N5?=
 =?utf-8?B?Y0U1MUhNOUNWWXhYSnlEWUtwWllZeWpTL2hmZUpUVk9rUzZMM2QrRmtGTVJp?=
 =?utf-8?B?cnMxYU94dzNPY05MNUhFSnRnUDRtekRuRVVkQTlBNWJ0ejVPK0tnZUg3Q2dL?=
 =?utf-8?B?dHJ1akkxVUdTNUtUV3ZBRlFCZGovOFBFa3pCM2k0N2RUTjFDVzg5YTZHOWpC?=
 =?utf-8?B?MFp2bW4weC9lckJjbXduSVQrbXNWN01BY3c2MlFxYWtPem5EeUpKSHlaaEtX?=
 =?utf-8?B?MWZ4TGRYcEVpS1VjZUFiSDFXc0VWQXplWENKdEVIZlRMSElJQWQ0dHZGRkFF?=
 =?utf-8?B?L1AxRjR6VjBYbGx0V2NEZXB6bXNxUU04eEROU2RQSUxUa2R2L0lIclZOOTkz?=
 =?utf-8?B?cUxxcXBPK3RGdHN3VE5nTHBIZ2ZxelBYaUhac2RiMC9LRlcwNHJTRVU2MWVT?=
 =?utf-8?B?ajRYSzhFenJ4ZTB4OWNLSWFOYVFCdm5YOEdDbGNWbHBNU2dxM0FhRFlYa1B1?=
 =?utf-8?B?SUVoL2tjK1FlWWNnb1Rya0Z4bkR0a29RWU1lWkhRL2pZSDMxNHFuSjZ1ZlRk?=
 =?utf-8?B?MzBmWGk0ZEtUZHNjeXkxUHpTeFoyM0h6cnFrMVlLLzIza21YelBIWDFlK0o2?=
 =?utf-8?B?WkNNOGZUYm54amtOQ1I1OFQ2UTc2L1RmSkR3dytNMkR6ZE1ZWEd6b0hYSHl5?=
 =?utf-8?B?Q3lCUzladXpvWWVac0RBcmVQM0ZLd2NPVzNyeld6bks4UWN4RE55TVdSbmtr?=
 =?utf-8?B?UUM3RG9sRFR1aUw3K2w5UTk2eThUN0hZWWs0VzV6eVNRcFQ0NDhIdGNwMEFS?=
 =?utf-8?B?WVZYNHhTdmwxQTZTWGdOTjBhR0JoR1EwRHZCYTlVd2hIc3N0aFQ3RnY5dVZr?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f7aabc-ace8-4eb3-c421-08dd678cac88
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:53:24.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSC2wffyfKHNsZi18UofsrhPQgatYx4yY5DU4g5ZV27wb0XWv2aGIbdgfRU6V8foDxto2hbAvxSRYKBvc3qNP82f9z46TowFse5fj1S9p0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7717


在 2025/3/20 16:46, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Wed 19 Mar 2025 at 15:04, jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:
>
>> From: jiebing chen <jiebing.chen@amlogic.com>
>>
>> S4 tocodec support 8 lane to input, It need to enable
>> bclk and mclk control bit when work
>>
>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>> ---
>>   sound/soc/meson/g12a-toacodec.c | 46 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
>> index 531bb8707a3ec4c47814d6a0676d5c62c705da75..88f9adabb3b5d7d8881fa110f1d0d51e9ac9c60e 100644
>> --- a/sound/soc/meson/g12a-toacodec.c
>> +++ b/sound/soc/meson/g12a-toacodec.c
>> @@ -41,6 +41,9 @@
>>   #define  CTRL0_BCLK_SEL_LSB          4
>>   #define  CTRL0_MCLK_SEL                      GENMASK(2, 0)
>>
>> +#define CTRL0_BCLK_ENABLE_SHIFT              30
>> +#define CTRL0_MCLK_ENABLE_SHIFT              29
>> +
>>   #define TOACODEC_OUT_CHMAX           2
>>
>>   struct g12a_toacodec {
>> @@ -129,6 +132,10 @@ static const struct snd_kcontrol_new g12a_toacodec_out_enable =
>>        SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
>>                                    CTRL0_ENABLE_SHIFT, 1, 0);
>>
>> +static const struct snd_kcontrol_new s4_toacodec_clk_enable =
>> +     SOC_DAPM_DOUBLE("Switch", TOACODEC_CTRL0,
>> +                     CTRL0_BCLK_ENABLE_SHIFT, CTRL0_MCLK_ENABLE_SHIFT, 1, 0);
>> +
> I think I remember commenting on this already.

HI, Jerome

This line is only defined and not used, it should be delete in next version

We put the enable of bclk on wiget in dapm when dapm power on, help to 
review

this method

+static const struct snd_soc_dapm_widget s4_toacodec_widgets[] = {
+     SND_SOC_DAPM_MUX("SRC", TOACODEC_CTRL0, CTRL0_BCLK_ENABLE_SHIFT, 0,
+                      &sm1_toacodec_mux),
+     SND_SOC_DAPM_SWITCH("OUT EN", TOACODEC_CTRL0, CTRL0_MCLK_ENABLE_SHIFT, 0,
+                         &g12a_toacodec_out_enable),
+};
+

>
>>   static const struct snd_soc_dapm_widget g12a_toacodec_widgets[] = {
>>        SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
>>                         &g12a_toacodec_mux),
>> @@ -143,6 +150,19 @@ static const struct snd_soc_dapm_widget sm1_toacodec_widgets[] = {
>>                            &g12a_toacodec_out_enable),
>>   };
>>
>> +/*
>> + * FIXME:
>> + * On this soc, tocodec need enable mclk and bclk control
>> + * just enable it when dapm power widget power on.
>> + */
>> +
>> +static const struct snd_soc_dapm_widget s4_toacodec_widgets[] = {
>> +     SND_SOC_DAPM_MUX("SRC", TOACODEC_CTRL0, CTRL0_BCLK_ENABLE_SHIFT, 0,
>> +                      &sm1_toacodec_mux),
>> +     SND_SOC_DAPM_SWITCH("OUT EN", TOACODEC_CTRL0, CTRL0_MCLK_ENABLE_SHIFT, 0,
>> +                         &g12a_toacodec_out_enable),
>> +};
>> +
>>   static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
>>                                         struct snd_pcm_hw_params *params,
>>                                         struct snd_soc_dai *dai)
>> @@ -236,6 +256,10 @@ static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
>>        SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
>>   };
>>
>> +static const struct snd_kcontrol_new s4_toacodec_controls[] = {
>> +     SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 7, 0),
>> +};
>> +
>>   static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
>>        .probe                  = g12a_toacodec_component_probe,
>>        .controls               = g12a_toacodec_controls,
>> @@ -258,6 +282,17 @@ static const struct snd_soc_component_driver sm1_toacodec_component_drv = {
>>        .endianness             = 1,
>>   };
>>
>> +static const struct snd_soc_component_driver s4_toacodec_component_drv = {
>> +     .probe                  = sm1_toacodec_component_probe,
>> +     .controls               = s4_toacodec_controls,
>> +     .num_controls           = ARRAY_SIZE(s4_toacodec_controls),
>> +     .dapm_widgets           = s4_toacodec_widgets,
>> +     .num_dapm_widgets       = ARRAY_SIZE(s4_toacodec_widgets),
>> +     .dapm_routes            = g12a_toacodec_routes,
>> +     .num_dapm_routes        = ARRAY_SIZE(g12a_toacodec_routes),
>> +     .endianness             = 1,
>> +};
>> +
>>   static const struct regmap_config g12a_toacodec_regmap_cfg = {
>>        .reg_bits       = 32,
>>        .val_bits       = 32,
>> @@ -278,6 +313,13 @@ static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
>>        .field_bclk_sel = REG_FIELD(TOACODEC_CTRL0, 4, 6),
>>   };
>>
>> +static const struct g12a_toacodec_match_data s4_toacodec_match_data = {
>> +     .component_drv  = &s4_toacodec_component_drv,
>> +     .field_dat_sel  = REG_FIELD(TOACODEC_CTRL0, 19, 20),
>> +     .field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, 12, 14),
>> +     .field_bclk_sel = REG_FIELD(TOACODEC_CTRL0, 4, 6),
>> +};
>> +
>>   static const struct of_device_id g12a_toacodec_of_match[] = {
>>        {
>>                .compatible = "amlogic,g12a-toacodec",
>> @@ -287,6 +329,10 @@ static const struct of_device_id g12a_toacodec_of_match[] = {
>>                .compatible = "amlogic,sm1-toacodec",
>>                .data = &sm1_toacodec_match_data,
>>        },
>> +     {
>> +             .compatible = "amlogic,s4-toacodec",
>> +             .data = &s4_toacodec_match_data,
>> +     },
>>        {}
>>   };
>>   MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
> --
> Jerome

