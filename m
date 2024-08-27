Return-Path: <linux-kernel+bounces-302967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC0960595
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9255C1C22D42
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8119D886;
	Tue, 27 Aug 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yiJgRpbm"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3919D89E;
	Tue, 27 Aug 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750967; cv=fail; b=aTPqkgbg6L+LiwjofuGFlT7y9VNVzuIcQi+gBZNC7ESZOso9VhHZVNQDrheaamBvJVR97A6WRD5E44+o+HgQNPyiXZF2rjRTEY+zDHSNH/KOLP2gudvNfuQW6ULxEl3VPm9174qbb+STrT2Zac2Yh0+iStHZ4j+up0J5FW2fYs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750967; c=relaxed/simple;
	bh=TM4I0ZvBn3aZ082xyco62M0FWTmaemgVRxDRMh8QSSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XFh59Wf+WuojE8H/YC0awEsvjB++h7NGHbOdVW9zCDFRACMRQh0lfqYB4VuR+b61eI8gLV7jkMvWsra6z4g+dX4M31WTBmCywoxjSL6gfLYuvORC87J+uVXZUQlUHaR8muPGPIq8LFIZKEYCR3hfBwYtJKdo9hywV+PFiVW8I30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yiJgRpbm; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cA/Bk3I6YosQNlLGoAXQb8RIxAEU2PDefDcc01HfOgKO7dLpg5DINaEg7S/5MKkCHdh3MecpKVqerAS+n6mZv5Q/XEuCM9VrhCCrfGtq/W3IVCOOz8sNCQulGEvq4rsnWGr3CYsfrrewCAekNLfec4/IU9f0LPnil1KKqyqoxmqCIkBp0pSkchPYklYbtmy9ESWeAH5XG168o3mZ7T6ABLOkYostts+BsnEM/vJIqNoJE1oHRQH8oVAYhuEioj8shhz8wZCtPj4ONgzZp4FHfDUyGT0Xx/wSEgp1yGhC0pgyIXCk2uvVT7tYA6dNh0AyE6LxlXbEziUOgvXlfeWbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ccQznSoDs3LJrExlVBxCHIAc024QlG4N4ePShP0RXU=;
 b=R73yTQc/T88pAm3hbKePXCdxogBfzSG1LU8rlj1o8C6ozJhDXBnPYiN2saWRK+SF2oOlvMGSZv1oDBi5Sifr2Fj4h9TjG/hW+2lB72XNVhNo3XRePCsc2IiqsmheExLGSP6wBv6Ow1NQWtZ8gEQnLHqGXYa5zwPGQFzi7+VkCff6scExeHkEX4+2rB4JGi4gbzE0AymsWvpLXXSTXRCqUrXY6Lms0BXsxRlZDr5rGGTCDMIVnUKpG9QL0WI7t65fk28FkX9/SbvDd43a3GKP1dhlNqqAVPMDG4P2/PruG5Sb7Jppj1PxoXAbmisKsBqdDzRFD5/hBpXRen9s0F2spA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ccQznSoDs3LJrExlVBxCHIAc024QlG4N4ePShP0RXU=;
 b=yiJgRpbmP0GIpnsOD1X58gtL+xihmWnfs2H6wxmsdhimvrSJWFuVOsqeJiyVKamsxJhqlh6CDmELHr/CMKzuXU6jkK3iDU0+PyUQrRgwpSUfGV5TiC3xbrczvLqZxGXXsOUCQ0FvULc+R4riBAZCdfo3lI+jwS+1pz1nZMftZdia00+COzV6ybwXl6aRo7DuQu1Jp1SoaLmIiGwos2XUVOS/8Rnl5IAnQEs8M+aJSnLa3wURJOcaortJsvoMSLGwnswyMwo6HRmluZBBBDJWqTZbfPqt5MG2bn2amon6LKHV0l1A0Y1CxDhDoyEXGJgsXqLBl4ZDt9YNHLXFsBlQWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3713.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:29:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:29:22 +0000
Message-ID: <61a3467a-ed7c-4827-924e-c100d9078a7a@siemens.com>
Date: Tue, 27 Aug 2024 11:29:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: soc: ti: Add AM65 peripheral
 virtualization unit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
 <a167791956834ca40c39acde8a55a1de41809b36.1724709007.git.jan.kiszka@siemens.com>
 <6m4znz74jzktnyjmt2sec3gudr7cij4xax4b27qb5ypcnllely@dw5z576bge6j>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6m4znz74jzktnyjmt2sec3gudr7cij4xax4b27qb5ypcnllely@dw5z576bge6j>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:610:119::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3713:EE_
X-MS-Office365-Filtering-Correlation-Id: 61794941-9337-4ab4-6b5b-08dcc67abbcb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzZ2V3dnWGQ3V1FSOXNoRHpwN2ZuM3pYWmwxU3Awa3pKZTlSL3lPcjlFYllU?=
 =?utf-8?B?UU9CQ21EZmtCc1BQSUxYU3JYSXlqR1VTWEFVWGpUQU1VbzZjZVdyODdZcTlJ?=
 =?utf-8?B?RkZkSDVRK1k4TWdqMDlHb2FzaG9PYXJWb2RyVXFQNjVSdU1XNk03bU9wTTNa?=
 =?utf-8?B?eExvMVJGcjhvS2daVkozSmlTQTZ6TmJDeEw0ZVZGTWV5V1lLZzVUOXhyYVJZ?=
 =?utf-8?B?MnlWV2dMY0N5TW4yRVJxc3E2RFpkYUZLME0xSjcwUTdOVFpKUGRpUG1nSkN0?=
 =?utf-8?B?MEw5c1A5VUdqczRvVHNGYXkrcjU3eTR1a2xjcXlCZXdRUGlIVlB6WmdIdmd4?=
 =?utf-8?B?NmxDRnRVSXZScElXU1pJdW1VZkdPdDN2OFZwTzZrSDZhYm5Rc1pVbWp3U2Q1?=
 =?utf-8?B?OWJWM1llckQ1djZVZHVJYU1yWVVkRE1mbGJReTlFZ3kzNEZOMldNMzdVYk5N?=
 =?utf-8?B?Mm5hbGoxSGhLS3UxR1RkMHZ4M1FuM3E4YTFzaWYzU1JBZDRlSzJNWVlidTZM?=
 =?utf-8?B?U2VxWUZDZkxmUUswR3NRSlc2UmM0Vm9nSlJlUDNyMTFwMHdBY0p4ZnozZmNt?=
 =?utf-8?B?czUyem9BbnJoTDZTMmVYUElVTnhmL2hVWVYzaHhyaGYraUVJWnpFUmg4dTlN?=
 =?utf-8?B?V2NrUU1QNmQ2cUdkMXlRZ0JSWXBuaGsxTngzN3ljTUp4RlZrN1N4WkV0VFNJ?=
 =?utf-8?B?alcvVG52ckUzc1JWdDJzMDZVbG5nay9PVnJaYXF6VEFFdDdUNitXcUtnQnZ5?=
 =?utf-8?B?NUZab20wdnAvYWE3RzYvRTBUb2luTkJRMnEvVWhPKzhoZWM2bytQOWhhTEIv?=
 =?utf-8?B?R1UyUXVyb2xzS2dId01ZcWpMb2syZGN5UjZpK2ltZVZ5akVGdDhYdUZrS21R?=
 =?utf-8?B?TU1EMFBBU2doVVpERU1lNWVHdWs2MHk4bHB4Nk5XS2wvaUhNd0JIa0hEbEYv?=
 =?utf-8?B?TTRHZXFUOEpNT2xVWEdwb1VIUE5sUFpEa3dsUTRzQmhWODA5bzVpSnlPb0ds?=
 =?utf-8?B?djB6cW5oamFmcExiVXo4Q3UzY2Q0UFBaMzNaZE5RZ2UwU0VYR0kwcGJCMEhq?=
 =?utf-8?B?K01jZlFGNzFHbVI2dWZZQWpCU2NkK0xab1VZSEp2N3k4N0JLckxSZlJKUHdE?=
 =?utf-8?B?TGkwZW9VNjUvMlNaS0xnT1cycG9tUFRnaStTajNkaDU3ODJvODBidDB0MjI0?=
 =?utf-8?B?dlhUVmFzcTl1RnpzVWJsRzZxeU41b1E5VDIxLzRPQk9JaEl0OWFuTnI0MVpo?=
 =?utf-8?B?SlQ0M2FKRWorVFFBVmc2SWYvdkQzeXRRYUpJUUJpN2tVQVkySENpTldnbTN4?=
 =?utf-8?B?NmhEMGUyTm05eFhsT3k1WkRhRUhwampvOUVEalBkS200WGlVazN5cnBjQUpk?=
 =?utf-8?B?cWxZZzk5NWFOWXFJWUp4UUxDTWdyVTJsN1RnRE9ISTQrTTdNK2N4cmY5WDN6?=
 =?utf-8?B?dVBrM0VrMWl1MjNyZU01amp0bGdENGtFN1BjNE54N2E2cE1mSENtRVJtOHBJ?=
 =?utf-8?B?R092alg2YVorMUdVcWYwSVNId3lpOTF2dno0aHRnNWNBaFpyeWZ1a29iTlg3?=
 =?utf-8?B?MEN6ajU3T0dNbVdhWXcrRmlEKzV1eG5tMGQ5RGFhcHIzMGs3M3VUMklrazNu?=
 =?utf-8?B?eUxxZWlWS2NlU2FmZ2ZwYXhNbHI0WEJYVkN6Q25nNDBkUC8rS2U1bUJUZ2VO?=
 =?utf-8?B?aGtHU01uV3RURDEyNHZEZlNjdklWUEp5VDZTODRKMVdERTMrcENTZGprcHNC?=
 =?utf-8?Q?f5PmqjDcf7mgF5gXrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aC9KNkRPdm5qbk54M3FjWHEyOXV1L3V3ZlZLRGEzL0t3ZjlzQjcyYllkZExn?=
 =?utf-8?B?RjZTYld6ZTFuRWxpTTR5WXFEVGZPWXQvQi9zMEdzMm5HeEVORlN3NmNLeHYz?=
 =?utf-8?B?dTg3d3AxNlZEZllWYUh6ejdEdy9mQmMrZUtXL3hqbUIwZXErQ1UzQkQ0TDI4?=
 =?utf-8?B?UjJ1SHRqY1RoRUxkZGZteDk4YmVTdTNjbmtteERwSGcxS1B2ellIRDg4MktG?=
 =?utf-8?B?UEhlSFJYUjhrMVAwVWhQbkJpUlp1QWlzUmZUTW9pbzV4cVdFOGN0VGRqTmh6?=
 =?utf-8?B?Y1JnRFNVUG9GS0FILzdjSmp5ZDA0d3hNVU5oR1ZkeUtqd3pQN1cxdjJyQ21X?=
 =?utf-8?B?Ykt1SnJ0WkFNVkRYVEJmbkZBNktzSkVEQWFJRVBpR3JWM09iTmxEcXMxUUQ4?=
 =?utf-8?B?OE02ZmYxRGxwR1IvT2tMRWVVYzI3eUMrL3g4d0tYQ0d1TDdlc25ucTFLUDVG?=
 =?utf-8?B?czlFUWh4c2sybmxnN2drTk5LeTNWTEpZcGR5TXh6bm9uWnV4M0duanBmRXlS?=
 =?utf-8?B?OG9qZ3d1Rzg5dHYvS3FTZjRjR0ZIczdQR1ErVExPUit6VVFaN0hwUmdxYU0v?=
 =?utf-8?B?V2V2M3ZtSE5BQ1NvWTArUzVOd3BYdnlHUWl6Z0Z5Z2NHeHZxQWRLSDlHcEYy?=
 =?utf-8?B?WXFoOERpSE42Nllwaml6SzZxR2NsMDduU3lGVGVTT0tDcTZQRHdFaXM4cDN6?=
 =?utf-8?B?QU1kNjJzWHpqYkl2U1VQZFQySFZQQ3FEcGQzaThUZllaZzJUeTE2MjZEaUs3?=
 =?utf-8?B?TzhNUUpEdk5PK2lBYjRPSWhmQnpFa1RCbXBXZmE1TDFHK0VndEptc2llQ1pB?=
 =?utf-8?B?blVETitZcFphUXZBN1pzUHJOK3k3V2Qxc09CY25XMlUyQ0VKMWhlSG1ISUV3?=
 =?utf-8?B?MWVJWndPT3JMMXJSeE1zVXBMU2hyZi8xTE91UUJ1cFdwQ3JyNnpXOWY5Tk9C?=
 =?utf-8?B?RFpHbU5YSjhoRGJieEl3MWdTS2hrZmFhUWJUK3VQTFE1TVFxYXZRa2V6dnds?=
 =?utf-8?B?aGZ5a1JaWTFHRERIcUUzNUVBdzNpNXk5RWhWcmFGRndqc2FNMnVJUWZIRnAr?=
 =?utf-8?B?SEZNRHhibFpSYkJEUHNPWEtUKytXTng2L09DNCtXUTlMaERneXl3eGYxT3JS?=
 =?utf-8?B?RkJWOEw1Y2pBRUFSMXdBUXFlU2tFU2hQNGpFNDVNMDFDVTN0blJTdGtqRC9x?=
 =?utf-8?B?aGNOTGlIUk45QjQzdVNCcEZ4U2ZJVlI1NlRlN0RwMmpaNG40eC9rWUV2ZU5w?=
 =?utf-8?B?SUFleUE1Qi9qeU5OdmJpamxsWUh6eTlDTG5wSkNqS25oOHVFWVBWVGZld05z?=
 =?utf-8?B?UjRWQzlaektxZmRPVTgzUW1DMTdqQjZ4OTU2dWU1dEx0UmxZd2ZTMHZsZG9C?=
 =?utf-8?B?dEc4M1VpcGJtZnpHaEF0QVJWS0xhRjZZU2VYNitmTDhwalNsb3Y5VldvRkMv?=
 =?utf-8?B?bHJlcjRyWGdrZHVTMFZtQkhCWVlnM3ZFNEtPSE82MWR4eHNwNXI4RWRvUlow?=
 =?utf-8?B?OTYrTVhFcUY5WFdmc1ZlTldvS29qdmpDbGxhZCszV3BJc090WnRGb3ZKTzY2?=
 =?utf-8?B?ZytROXBxR2pNWjlqdzl1UDltOW5FckY3YWhBS1c5Wml2aU9aNUxZRFgyVXlI?=
 =?utf-8?B?bUJGek5DUERYeW9WQ2tPZEYyZzJOeFdrTkZkMGw3QmdOVXV0MVQ1NkVyamFB?=
 =?utf-8?B?V0VxYk1oSUp4SnVLaloyWklzQ3JyMGNWbHQ1dlNaaDdnQk5ibm1nekxQdGZY?=
 =?utf-8?B?OUJlLytCMkdUWGNnTmlMUm8xRmtBVkV0dEQ0ZUkvZjlOQU9nTzhWcml5RHgy?=
 =?utf-8?B?ZGJycFFvbmpuOFNUVHVpbXZ4Q3EyaE9wZHFBR000dHRPT0hKMUcwdnlNc2hx?=
 =?utf-8?B?dGVCTEdXWGY0cTl5YUxZczdHRWdVOGdRd1V2djhINmRQZUJDUkphNWpyazBt?=
 =?utf-8?B?VHp6dWhVWnltSjEvbVNRWk9XM0twYjBKakRrRlVQOFVMRmJXNTJJTjJHWE1S?=
 =?utf-8?B?b29hSnNBWVpFRE0rb1hSVHNwUnBpR2hMbVBOTlUzQUxKaldpSE90OHhjTUt6?=
 =?utf-8?B?MDFmZzZZOGxxU2pGejlkeFpSYTJ5WUFxNWk4WHNnZ2RuNS90T2NUVlM5eVA4?=
 =?utf-8?B?TlVxNnFPSFpyQTJEYmlFSFQ0L2Vxd0J5SHBrVDRRRVJjVVl3dGdzRFNnRklT?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61794941-9337-4ab4-6b5b-08dcc67abbcb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:29:22.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvOsYAeBobp7m3fAqoiOWHeBGCJBGmKsb6QyWtaYorVjDDxf1KwH0WCmR4hkAUik8v9Y/IjafPvc5YdfXRrNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3713

On 27.08.24 08:36, Krzysztof Kozlowski wrote:
> On Mon, Aug 26, 2024 at 11:50:02PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The PVU allows to define a limited set of mappings for incoming DMA
>> requests to the system memory. It is not a real IOMMU, thus hooked up
>> under the TI SoC bindings.
> 
> You still keep developing it on wrong, old kernel (or not using
> get_maintainers.pl, but this one seems too obvious so I assumed wrong
> kernel).

Explained elsewhere, will update the two subtly changed addresses in the
next round.

> 
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../bindings/soc/ti/ti,am654-pvu.yaml         | 51 +++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
>> new file mode 100644
>> index 000000000000..fd0f86fa27b0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (c) Siemens AG, 2024
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/ti/ti,am654-pvu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI AM654 Peripheral Virtualization Unit
>> +
>> +maintainers:
>> +  - Jan Kiszka <jan.kiszka@siemens.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,am654-pvu
>> +
>> +  reg:
>> +    minItems: 2
> 
> maxItems instead.

Can change, but maybe use the chance to explain to me why "maxItems" and
why also "instead".

> 
>> +
>> +  reg-names:
>> +    items:
>> +      - const: cfg
>> +      - const: tlbif
>> +
>> +  interrupts:
>> +    items:
>> +      - description: fault interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: pvu
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    ti-pvu@30f80000 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> for sure "ti" is not generic. pvu is the device name.

No problem - which one do you propose for this type of device?

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


