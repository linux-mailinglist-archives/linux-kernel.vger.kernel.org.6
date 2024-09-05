Return-Path: <linux-kernel+bounces-317732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CFC96E2FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C4B2859F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9689118CC0A;
	Thu,  5 Sep 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W2zN0shz"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF4154C0D;
	Thu,  5 Sep 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563852; cv=fail; b=hIRSB7AlvRFiQW62Q66M6/i+RHy3CyHBBW69Vl1JCnQFECiO7M34jojO2UpgR5eXWshJ6dtQCLxcfyGaqKVB/5MQQHH6Jy9g4tT3nRdTV2FqcYPMU5RaW1b02StPdkMpc7HI9yeL9Hl7gqdqXxAdL5YfePaRZDgE48fV2uJLS8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563852; c=relaxed/simple;
	bh=Zgrbh9Fp34TytJcqkjMa9XEygbnbQyh1uxoPrrEChto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rlD1Yv09+e5oWE0QF0tB3yaTdYDzFB8g7Cw8dwjMyukYfUe4u9QCA8HJY/arYtcDV3yBMR+UIXROTf2RtMibnjIl6192sF6ekedM/Q3Fa5vYPaKPpnhV8VfUsYJM1qZSIkrw3oA3+jae5LzvJ3FOIpdalRYwqkw23M3aRngHv8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W2zN0shz; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRzQf2bdj1c7CK98A2IP5SLb+AjnrSiYL4XgvDOWvqFMftDz5P3176/KLSxxy2bdhy8L8Tusd7LDbr5F5B/5bT0Qe6qKyQd6UKpRrNjkLOJ2ZpM9cKpL2sOFgGi9R53pfxxcMtDMS908wxrGqbFjxW2+p11dwW5w1vqkk4/6wmrRBSaOJSe4dgvAgA9Pa1icVIplMknKdyN/IXTmYMBbyq1zaQ+UBtVop+VthkFtEZGtk4nDmKurUWwCIsUHRBRbbWOJEHgjGIT7iBLK6oxJ6KIW7sKkvhPz38bFNGoyPySpIsUJftVNT4zCMBNtymvtp3CI/Ju8LineoXslqQzvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uZCMzfy61F6FQirB7h720SoqpscoSsmQQoERSADzoQ=;
 b=yuw9BCcc7FPt0eFCNOXBuQ5FQmuTXEKu00LRKJuc7SFP0Sg31GX1fvXLrGnR9DLwKbE5LEhFdZEg2mrHJndJaXJWKaplLQYDYMFNfHz6KYB9xRIfEd5HNForeRyqqifBxxkeefeoVFEEuJ6SXOfMHx/xS9ncK4ssWoWYBkRJawXSPaSyzv2zH+rfCuvOwGQRnE2i8tbpbgeB9QHj8/4Ogn5lcSpAVh6+Gk7W8e5EvHvL2K0Pd2K2kRdeK8aopJMED6ItlH45d+Z/RgPujZ3Liy8FuwMZyGemIYRnOMsHfef9GMFOGUa8ospz4hGwfzEyLTInQnUzfirP223GAhDHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uZCMzfy61F6FQirB7h720SoqpscoSsmQQoERSADzoQ=;
 b=W2zN0shzFFxNU2wR1EsX5chnU98YZ9O/lBBaRINTrfX+wTqirx0F+gUUJY9RjwN6j5U2F9oY+2c2es1+pSZNMMxxCrFIBkh6WB7CJvwKrpBP03uZM36lQu+G3BJhU6LWXJc6XKCn+ohFj4NvOqrs14YHYdlzrp7P6sVnBA/g13hbUP8s155l4Uhr57YYMPSm+29t035olPwzJhYlkaJuyYDyizahI0qsWj4CygqI0KnaFEP/YMOAAh1aliCN61Ulap+o9Cg2eN2l9KrXtxtUmnhBtiBaeTyV1FDnnXQUmPcid/S1Hfa54Wz78DXG8mb/HIl1+vZ/+TIanM+WWtw88Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9844.eurprd04.prod.outlook.com (2603:10a6:10:4c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 19:17:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 19:17:26 +0000
Date: Thu, 5 Sep 2024 15:17:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 3/6] arm64: dts: imx8mm-venice-gw7901: add
 #address(size)-cells for gsc@20
Message-ID: <ZtoDviZZQ0/pVGZs@lizhi-Precision-Tower-5810>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
 <20240807-fsl_dts_warning-v2-3-89e08c38831a@nxp.com>
 <CAJ+vNU3ZsJG-eoqf3JcHTyDwjp4uOW1XiEhnOfWZ1FJ-q1Y9Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU3ZsJG-eoqf3JcHTyDwjp4uOW1XiEhnOfWZ1FJ-q1Y9Hw@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9844:EE_
X-MS-Office365-Filtering-Correlation-Id: 8feab3a3-1a0d-46c5-4e4d-08dccddf60bf
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VjE1dGVvVzRyaDdHRlhnc0FjeUUwNTl4RXRNS2tSTnlZQUVFUjJWRGpoaE5x?=
 =?utf-8?B?L01QQ1EwS0haNWNWRWlFcU10b29TK1lQNnN2MDVlWWtJM3Y1djE3aVROZjhp?=
 =?utf-8?B?YXNoZjVkNWt1V0oxMnRaSjkvN3dvUmIzanVFLy9JUlI5czlaUEd2MS9NYnhC?=
 =?utf-8?B?UUZ1Z3d5bTBmenBSOE44SWdnd3RKSmRkY1JqZTJVR1RaSC90QVNMNkh4YlFB?=
 =?utf-8?B?dXJSY25oSitJbnFldGx2NkFldFI1VFR0KzNXM0IyMVh1STQ5QUJXZksyMWVk?=
 =?utf-8?B?MXBGbjFwc0pqZ1J0QnBKaGFXbGVIUlhQNS9seGNoNEo3N1pHeEJ5MjNJQURW?=
 =?utf-8?B?c09NVE9iMFBDRjVQc0haTHdiMHBjSTl6MU85bldlbmlDQ0dIenZOdzI1czVw?=
 =?utf-8?B?TEw4cGZCN0xpWHdjZEJDWEdGUWRNOEJaelZzenlSWXJHbGM1eGgvVG9NbHVB?=
 =?utf-8?B?cDkxTTJJRlVCUE43NTByeTBPTGJoWHpsb3BYMzAxbE1RWEdENXhaSWk5NzVV?=
 =?utf-8?B?cTVnMHViUUNtU1V0VlRDeFl0SytUS2UwMHplZHk3eTE1bzE5am9ibmlvZ1lX?=
 =?utf-8?B?Sm4zaHlrNzhKbDJRaFVtZERPNGFpT29vTnJVZmpBUkdpdDZmYjlFenpPNFBE?=
 =?utf-8?B?V3E4dW50aVFjM0dGeXpDOFJyTHRncGlmSEREdVJ5WStFQk5FbjRKNGN6YkRO?=
 =?utf-8?B?Q3VzQUNUUmdEMi9TRDh1cTMxdkZscGZsMTl3SXlYMWhlQzgrMHJYd2VJR3lU?=
 =?utf-8?B?QURvZEhXZlNrZXRvV1hlSFJNUVRMbVN5QTBxNVFleWhzV1ljcUJwTjFVZXRI?=
 =?utf-8?B?WTZDYXBKOTNMKzl4VFAwRzJ2dUY3SGpPbUladllyQjNaRGw1UlJvTWlwRGt3?=
 =?utf-8?B?ZnFkZHozWEg2QU5lN01FSHJnWnk2MnpPcjE3N3lYN3YrdGlrcXgzbjZNWDZo?=
 =?utf-8?B?Z05xQlhwVEpSTzUzeEUxOGtDaU5XK3V1cGVxT1pqeUN4YjFlUjdzVEl0UmNv?=
 =?utf-8?B?WWxXUjU1ak1XekNNUERoQytVNFQrVmhlZ093YWtRNU5PWWt2bStHOUxXaGZy?=
 =?utf-8?B?NkVQTkZXelZUWURPWVJZU2c4dVN1QklweUExQ0hhYU9qSk5wL1ZmMTUrWGR5?=
 =?utf-8?B?Sk1FQlZmZmpQbzdLTCtKQTN6Njkya1hBcUNnVXdsS2FabHI0ajcrbGRZYzVn?=
 =?utf-8?B?a1l6dGZPTXVOY0lmdElvTDB5WXBsdVlNbDljT1RkQkUvcXBETkVwMnVTaHRW?=
 =?utf-8?B?VTJKam4rY2JScXRTZFV2WjNHMjZVbytjcGZmUGQ0VTlBMkZCak9RS1oramF2?=
 =?utf-8?B?aEczR0FvcEFoMzNheG1xMldnT3VaVEJ5eVN5a3dKWUNaVWNyQ05YSVJBOCt1?=
 =?utf-8?B?TE9NMkpkNTNObENScXZTd3E3MzBHT29aOHJRU3lFWGlXVU9rZ2YvWU5QRHow?=
 =?utf-8?B?aFVsZGM0SWptekxsa2VNNk81ZFNKRnNYQkRaZEVZdDV6N0xWUHBJNE1mSm5V?=
 =?utf-8?B?eXVDSDBFeThwcW9hWTBVSDF2bUNvUU03eHZ4WDkyZ1RKZEhLOVRPcjFqR3pW?=
 =?utf-8?B?UEdHY2RHWm5udU9TNWtsREVBdW02QzRsdlhXRjM3YldwSUpsTWp4aTRqa1R0?=
 =?utf-8?B?ODhJTUs4YkMxT3JzdUU0TU1WeGMxQzFKN2NoUUNiWVg1TnozL2JNS1ZNUmI1?=
 =?utf-8?B?T1FTZldSaFA5STNTcVdwcmdqSHV6bmw3WXdSdzdTSXE1d1dJRkxrY2ZTN0lE?=
 =?utf-8?B?NXFsZy91WGVZNDhpVVUyTjlhY2RiS0tNbExyVFdIRi9KWFRUT0pITGFSSUEr?=
 =?utf-8?B?Qm1sQWEwd0NJZlo5dWY0d2kyN0pXUE1RdTAvWlZ3QjUrekNFaWRPS25aemJn?=
 =?utf-8?B?cXdjcDRXMWJoNFJLUWx1aUZiTmY0cGxsdHB2ZWlBVWVQUGc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R0swaFduMWQ4Q0Z1WktPQmdEMW13M0dkUVk3STcrT0dQQWFHVzExNTV5THB4?=
 =?utf-8?B?VmorYTQxWVlVT1JGTm90bFFleWFEbmt1cTlqUjFSZklMQmFRVVVmcFBvbnV1?=
 =?utf-8?B?enN0dVdSVVFZLzJmSlZocTlkc0lTNi9hVGVJMTJkc21ZZTFZd2tSajJicWNW?=
 =?utf-8?B?c3RBYVIyZ1ZFT3dHeWJET0RyZnFGQk92WXVoU2s5aUljWDBab0dOa2VybUF4?=
 =?utf-8?B?c3BXeW5xcVg4QWg2dnVjNkd0MjloOGRaazFwLzV4YkZacGgxZkY5NmlQV3RR?=
 =?utf-8?B?bEQ3UHlBT1JFeFp3RlA0dnZud3JKVUxjZ3h4WUw1aWxQQ3JTVkhYeUdJMlpH?=
 =?utf-8?B?cVZqejVKM25aWDdNNEs4V0dWZStOeUN1bTR0bkp6ZEFtenVHUnNzNGdJMGgv?=
 =?utf-8?B?cUcyY01CbS9wV0o0bDdFdmprMklWZkZrVGFEM3VNUVIwWWNxSDJmd3JBTVNB?=
 =?utf-8?B?eHNOQnpuR0lYUUVkcmdBanAwWVhNUVZmNnovWS9KMnQzVCt4bW5MNkwvZzl3?=
 =?utf-8?B?NG9TQjRWdnNVRTdBK29hYWZsa0JDT2RvVzdpMTBuSFB6bGhWZ2pKcTV5YzJB?=
 =?utf-8?B?ME9tREJuVGUzU3htRzQ0dnpXWkZHVXM2NWFsY0pWNTZrd1kxemM3S2NkQ2s4?=
 =?utf-8?B?NWdHY1o5dDZ0Tk1lMzhPejBJUWZmZm1zUDgxK3RyQW9BSmtvdmI4Lys5ZFFG?=
 =?utf-8?B?eWlxTjJ1MVAwNU55K0pueVE2VmJwQndQT3AwQ1dOVUE2ajhwRGFVdkVIRDJl?=
 =?utf-8?B?ZzZWOGJDTE03bkRGUWw4L0FMcE1qVjFGVng5ZXhvVExNVzl2end0RzlHOWR0?=
 =?utf-8?B?RzdzNXlob3pFOTczWk9SMGJnVUF0Y1d3Mml6OVczZW81eGVieHFwNTB2bGx6?=
 =?utf-8?B?cHF6QTJGZjdUYnNVOWtEa2dxZVRyQVFyNWR3OHhnbWdpRllnSk56ek4xSUtG?=
 =?utf-8?B?WWVWcmwreXRQSWNXc09EQTNGVG1xVnF6c2tSbGpDSDhZcFBWam1zRVptNTVZ?=
 =?utf-8?B?elVjZytDZS9HMVJwaTRXSUc0b1NIOHZLTzRKbUFORjU2MG1lNnRTZXlId0FR?=
 =?utf-8?B?RVdOdVZKYnBPRHBkajFhOU5YNnh1Q1l0ZUlSUmQvT1dmSEdHVW1FVm16eThT?=
 =?utf-8?B?bnVTQ0k1blJDNHpOV2pMb3JFeUVGT0pocVM5a3RMcGN6WHFNelJHcHFqWkpH?=
 =?utf-8?B?ZSthZlFuRFlNUjBraWFTMlYwVVFOSlJGOUVLZUdRNkhzZll5ZURGY1dzUmhk?=
 =?utf-8?B?N3ZpWjF6WjlMNjVSdTZkMjRVbU9pUTF2Ri94VGZacm45UUtoZytMUksyaWZh?=
 =?utf-8?B?YWRTSVhTOUl2eFNySkZOanJBdEt4TWsrTTZ1NVBsUG1mL3FKenZzdUoyanBy?=
 =?utf-8?B?K05zMUh1K0dhbjJ3OVl3ZVpxRjloOGQ1Qi93T2J6bDRzbEZnZG4vTk5RYkRz?=
 =?utf-8?B?UThBeVNjaXRnb0t5YWRqREV3QnVpeUdpUzRFWXc1Y0J6WEQ3MkdLTTk4SVlW?=
 =?utf-8?B?SDNTRGlFL1l6QmFLOS9UQXRJb3ovSWtmQk5oUVBiZUEvSUlLSXZub0FhV0ho?=
 =?utf-8?B?ZEJEcS9tUEk0Qml3Y0FqUUUyM05UdGlOMFg3VVhjbzV3bnlxajBaOG02RG44?=
 =?utf-8?B?ZUVvaFB6aWRaV3hwcE9aRk5TUWVodWdISndyVTdtRGFwb2tOT1RTM29wd3E5?=
 =?utf-8?B?TkdYaTVENlFFWHhTSVA2Q1pIVkNmMWdFdUMwMHpLK0dLbGRWSU1hS3lKM0Q0?=
 =?utf-8?B?clZHSU5TbFZncVQvTlk4ZzQ1bkJCdlpIbDdVQlVRc29SU2pBTzI5QWVMbVhq?=
 =?utf-8?B?bTJGS3duMFBHTFNyY1FWYjlINmEvOHFhNWFwK0NlNDBKRDRrQmJQdEhrTlFw?=
 =?utf-8?B?V2JYTDdlQ0dIY3pvbG5CKzlFWGZLV21seDZ6aHpabGZnWUs4eHlZVW9YY2N4?=
 =?utf-8?B?QzhmYmd6NzNveEFIbUsxSG9va1FpN1ZCc3ZNM1d4U21rV2NRcmMvbkNaZFor?=
 =?utf-8?B?RitNc1NGOCs1a2pLWkphVU92alNjWWJITlhBNEYvU2NRWm1udjlGa3FHWVUz?=
 =?utf-8?B?ODdMRGtaTXFONFZqYkdBN3dLSThSS2JtZW1GLzF4c2Y1dzNQalJtb3pIeXR4?=
 =?utf-8?Q?t7F8r4XwaZjEyH3SPFgzTJ4qm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8feab3a3-1a0d-46c5-4e4d-08dccddf60bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 19:17:26.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agescDCW0IAkhOKIusC2/5Nd5d4kLNCLjnbBGNan63GMjwlM1+K7S0cAjA2GluogW6bx7U+g0ggDy6sl8HS41A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9844

On Thu, Sep 05, 2024 at 11:56:41AM -0700, Tim Harvey wrote:
> On Wed, Aug 7, 2024 at 7:54 AM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > Add #address-cells and #size-cells for gsc@20 to fix below warning:
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb: gsc@20: '#address-cells' is a required propert
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > index 136cb30df03a6..35ae0faa815bc 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > @@ -364,6 +364,8 @@ gsc: gsc@20 {
> >                 interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> >                 interrupt-controller;
> >                 #interrupt-cells = <1>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> >
> >                 adc {
> >                         compatible = "gw,gsc-adc";
> >
> > --
> > 2.34.1
> >
> >
>
> Hi Frank,
>
> I just noticed this patch (along with a few others to
> imx8m*venice*dts* which undoes what was done in commit 3343ab4cc698
> "arm64: dts: freescale: imx8m*-venice-*: fix gw,gsc dt-schema
> warnings" which my commit message states: Fix the dt-schema warnings
> due to #address-cells/#size-cells being unnecessary when there are no
> children with reg cells.
>
> With your patch applied I now see warnings again:
> $ touch arch/arm64/boot/dts/freescale/imx8m*venice*.dts*; make dtbs W=1
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts:361.14-467.4:
> Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
> 0a20000/gsc@20: unnecessary #address-cells/#size-cells without
> "ranges", "dma-ranges" or child "reg" property

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 CHECK_DTBS=y freescale/imx8mm-venice-gw7901.dtb
No warning report at my side.

Did you update your dt schema?

pip3 install git+https://github.com/devicetree-org/dt-schema.git@main

Frank

>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts:311.14-418.4:
> Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
> 0a20000/gsc@20: unnecessary #address-cells/#size-cells without
> "ranges", "dma-ranges" or child "reg" property
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts:277.14-364.4:
> Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
> 0a20000/gsc@20: unnecessary #address-cells/#size-cells without
> "ranges", "dma-ranges" or child "reg" property
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts:330.14-411.4:
> Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
> 0a20000/gsc@20: unnecessary #address-cells/#size-cells without
> "ranges", "dma-ranges" or child "reg" property
>   DTC     arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb
> arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts:309.14-416.4:
> Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
> 0a20000/gsc@20: unnecessary #address-cells/#size-cells without
> "ranges", "dma-ranges" or child "reg" property
> arch/arm64/boot/dts/freescale/imx8mn.dtsi:1128.11-1138.7: Warning
> (graph_child_address): /soc@0/bus@32c00000/isi@32e20000/ports: grap
> h node has single child node 'port@0', #address-cells/#size-cells are
> not necessary
>   DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx-2x.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx-2x.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rpidsi.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rpidsi.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-rpidsi.dtbo
>   DTOVL   arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-rpidsi.dtb
>
> Is this some case of dueling dt-schema checks for dtb checks?
>
> Best Regards,
>
> Tim

