Return-Path: <linux-kernel+bounces-239832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198809265DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C575928454E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636421822D2;
	Wed,  3 Jul 2024 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="c9ZdgZJI"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022129.outbound.protection.outlook.com [52.101.66.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D57282E1;
	Wed,  3 Jul 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023564; cv=fail; b=ELz5IzGwZYUyLMLtaICjDwFcNbgknZZLYbtkzgEavSkW1XU1UPQ+1cibbkKOfN3vPo6U6kclRMK3AruLOrAws+AO6BwqJVWKlhdr+spf/fez2KRjHZuTzEQ97WRnmiZVqGzaWyBF+s4H6uoSoZg9vdbdCi8jQJEqiumKer4CDFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023564; c=relaxed/simple;
	bh=K0FuuqO7HEswnf5P7g9rZv9FumEIFEDGAjHq2yr6hAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sjyjKUnyVhKkmxNQWtmZzoGwJUS7QGE6eoU4232t6+cwTIzaHmvOuV7g9gp27VG7YtT3NaVGmPkqItFQ2Vwx06QO2+K8yq2bFlhDA/RwpOOj1EkcMK0ids6JDslVBtKylvqskRzlLRHfJ/KNwpd4brAPzAMjYV/YvyuK94Tvj2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=c9ZdgZJI; arc=fail smtp.client-ip=52.101.66.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfqz0JJbdMqMXrSm1wxdP2t3o+SOOLYLW+VMOnhvRfcmwjFU0W2HHgrNPRLhGsjhp7DVMGoprpBE9bVrW73xGJGBk2RPI7owyPW6VO8Yn93w41hJOGLiPppFA02HjVkrB5n6Czkr3HszUvTwaYwOHiGyMJCUQmadPd1lqlvr1rIY8ff+yFYssj4n/LlT4C47CnVpU4eFpbYgdxSQO4gWVNFua5k49GfVG9WHkjaNrAna/o8qxFm/0ujNjRsKYqh/EN6bFUh9mJ+5s0kPi9VNJ1vpOdyWHk6tA0G06bX4X9OTpn9cIN48OgO68gHCDpesOG+Tfwe/Nii8dCf/BSO5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHGxVbc+bT8OWe7ovM0g5M5Rz8RSWBmovLY6aOp9F4w=;
 b=OZQzIhued+tTUP2AGSJHbjO7ROO3bUhhWrcGn7lAoYXxVGCAfYqVulORAdSWPj2eouFmWD34nbngbJcRetrHrPIiKtztb7N+5omKlRfgnGuz9/eXHPqqqcJPZHlTqmuqBor6+eV2vALOmYDu3Ql5XPbNhPjWOm01i5g9XbynH7xkpn1qu1PLNwqXXP6jhJHMty5CS9wA0HCtcfA8Q56zvzHtcrepR7mHvtRmkaX0591je79bUKQjhtC2bSyYv9wk9n9sMVyWChWigPwP+Zxyx7B8u/q8fONmx/cQSgNAy/daXAyl4Xfhs3zx98Ukt3OJVHDq/dve8IXzH7lE03cHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHGxVbc+bT8OWe7ovM0g5M5Rz8RSWBmovLY6aOp9F4w=;
 b=c9ZdgZJIPQvGLveZ14Wrj2GWD3Pp6/1LxBi0cR1Xaf4NfPR4ARnIdPfXi/xj4pqtaGc18ju2bb0+tQyCQLc4Ib8BuZ0tg/nXaYggTbJo6Ce3CGNfm73/HSGyL6kI8iSvm4cEJlxINxeJDMCoXa1JVQlI0XZ+fLUoCQ96i5Mcmu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM0PR04MB6770.eurprd04.prod.outlook.com (2603:10a6:208:187::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 16:19:17 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 16:19:17 +0000
Message-ID: <015776ca-a9e0-470f-bbf5-39cec4147c6b@cherry.de>
Date: Wed, 3 Jul 2024 18:19:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] hwmon: (amc6821) Convert to use regmap
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-10-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240701212348.1670617-10-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::16) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM0PR04MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5ae198-435c-4dff-2482-08dc9b7be305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2l4NlpNaGFkcDJtVzE1ZWd5dkg1N21qalRHa2Z2blYxa1AyYXcrQzBzMzFD?=
 =?utf-8?B?Y2dCeEdoUUJsSzVnRWNCTFBPdDZLdERmdmpmVHhmS3loN253bDFMOWdRRUpM?=
 =?utf-8?B?RHNYOHFDODVvb3NCWlEwWUlTOEE1SEp1ZmVkRzhwUk45bXVVY04veWNZZFU4?=
 =?utf-8?B?WDFCWkxWSzRlbjNrS3lkd0pERDEzZEU0aFloYUkvVlhUNGZ3TkRjNVFnbWQ2?=
 =?utf-8?B?ejdrLzlGM09vY3FhU3R5TUgveTZFNGw5MjY2Rk5uYlFlVlM2OTdHS2NpRGls?=
 =?utf-8?B?UmVvVE42UGFEYytCM2xBcXVOb2dldFc2UWNqTzdGZ1V0SGp4VUJyY0drSm1p?=
 =?utf-8?B?citNQmZCeHNyT2lLdFJyN29Gd1JMQVRwR0xpc005aVpJVmdPM2JhZDhYMExC?=
 =?utf-8?B?N2tpUjRnVVVSWlo3MTZXY3UyQks4MXhLZ212QkZJMU5zd0lkcmVaT092VVRR?=
 =?utf-8?B?eDRya3RhanJpTHNYVGxDME1rTnVzckJrekhlTHhqMkdRVnpPUE4xNUEzSVJS?=
 =?utf-8?B?b29kaGhKamFBaytERzdhSTR4MnlTYUd0ekx1Tzk4U1ZYNCtNZnE2M050elp6?=
 =?utf-8?B?eUxuS3dCRHp5WG5zWWNkU28xcGxEY1Z5dWVtalJNWHlYK3crVTNpeE5yeUdj?=
 =?utf-8?B?Q0tKeGliRlRmMXFWdGRBcGZ3K3NuV3pieVBXOGN4OHFGb21DMGI1Q2tya0x5?=
 =?utf-8?B?Z2RtdUVQV0JCTDA0N2FTdGNTUW4yeGM4c2EwQVFyNUtyeXN0dVFIbVo3cWxx?=
 =?utf-8?B?YnZBUEk2dUUyV1hib2VZN0wzMzVTUDQ1WE0wOTVLV0RpRTZpY3RMUWUvKzBE?=
 =?utf-8?B?bTgwa0ZVZUFxVjhwSitDN0pBN3RzaER5OENIc3QzaVJKQyt5VHdmdVp6Y2g5?=
 =?utf-8?B?U0gzRlNlbGFld0xJRWJ4ejVlQXBEUnJMR2NmUFI0bEE5cVd1OTJtVVlJNEV3?=
 =?utf-8?B?Ni8weEVBOFVSbHdKTHU0UWhYQXBYSFV5QUlPbGcyTmVIMFQydTRjYTlNa1B2?=
 =?utf-8?B?cjhoZTgvd1VoV29XV2lFeUhwcGVtU0hNd2llQnFGRGdJS1Ivb1JDTTdISDQr?=
 =?utf-8?B?enhoSXVkL3ZyMzZseXd1ZzNxM0tDRmFSR3V3eWhzSFduV2JhS3QrSUhhcTdU?=
 =?utf-8?B?TmZRa2YzVCsxL2liZndzcjNieEhnVkladEt6WHp1NHFxaFJTZ3lzZVV0TnZi?=
 =?utf-8?B?OXAyWklzQVppMTU1a2V5N1pqMDBnVUdYZ1ZVc0pWNFBJUm84WkJDbXZ5TXBR?=
 =?utf-8?B?VENVZHlpdEQweldTblRzejA1dElQT1dhQkV0Z25TQVRjanIycitVWFd1REM0?=
 =?utf-8?B?SmpoTzRtR2lnbk42Sm1UWWc1T212bm50MGZSbXo0enFWUEhseG15ejcvbDVn?=
 =?utf-8?B?MnhIelM5UEdIUzU4RnVQMTlYMTU4NmRvTVZRT2Z1eHRTUXRERXV6b1NEdFJi?=
 =?utf-8?B?VDJ1dlhFanAycEhWSkJnMG91SjZoeU12WmdXSEhHcHc0NEpsRHh6QklFL0wy?=
 =?utf-8?B?Z3c1WW1xTHRYNXhzYk5TcXJLMG0vMi9JdGdQMkh3UXlvbXR3azZtTHpNU3lj?=
 =?utf-8?B?emIxOU02cnN6NHg0a2dkT3VIczBYOTFNMzRONVV1SUNoVVdsdTNkK3Fha2pF?=
 =?utf-8?B?NHVIbWJ2SUNGNHJqcWxsWWVtMXJHU1pTWlFwSk9jVTRBVTZKMkxwTkx2UHMx?=
 =?utf-8?B?Nmw1eUFMajFmdnlOb0JyYlN6YTNiNENROERGRi8yTGl4UERiZEdqWjZDblo1?=
 =?utf-8?B?VFJ5VzFHeFh6a0tRVkh1c240REE3eE0vcUpNQ2tZWHhPUDZMZzFYNFBBbmxy?=
 =?utf-8?B?VU1HNmQ0UmZ0ZmxPSnVHZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWFReFRicVdpU1MwR0hpYXhvRjl2RVVxYnFocGI4K3dnS3JBTWFNZGh5Wmp0?=
 =?utf-8?B?YXJRL3p4OWpJRUV1dER2ZGdFSTg2UHZhQTN3K042V1FaazhIQXJsVWd1YW42?=
 =?utf-8?B?L0RkOS9qdEdnY2JuZlFleGtjejZFZ1UzV0FTS1VTcU9lbXJ2czM5dFdkR1Fr?=
 =?utf-8?B?cVdiRE9BNlBPOUJaQjJpMUV3MEZtMEc1bGdzVkxqVEVFNTBTSkNhUnVwZW5L?=
 =?utf-8?B?WUl6cWdNWkpJaFB3cnFOM1puakd1azBONFNzNlQvSmZZWFpUWEJ2eGs2bmxB?=
 =?utf-8?B?d05sM1Z4ZVhibEpUSjgxeGFvQUVtVlJ5b0RpQTZlaTc4T2w0QWtRcTdLWEZN?=
 =?utf-8?B?MDlBNnNzbFlHUjhEaWVQSWU4TVB3RHpGT1Y3N1hvZ01oRzY0SGp1elEwQzR6?=
 =?utf-8?B?bGV0WlUyWmk3bmJhSXIxRDRNQkJORGYyMlVGNkRQbEhQZ1Z1SlhnU2Z5NHlC?=
 =?utf-8?B?dHYzNFhlWVZhTVpZSGlESGZIbHk0eEgrM0tBanl3VWxKKzdOY0VhWFJUalZQ?=
 =?utf-8?B?M3BtUDA3RHBYcnFvZENSVlNEeGpUQzZKQzNvZUpxaSs3SHczNk52d09JVitY?=
 =?utf-8?B?MVRQdXVrUklUT21zbThNaVV4QTVsajJqVlhpTlJORTQ2SStSSm4za0F0Nkk1?=
 =?utf-8?B?YWNnbS9HU2l0a0NaZWlscmVQVC96aW9mVndpaEo4enpWQkh4NUtaSFVhZGdP?=
 =?utf-8?B?YTJpaE9CQ2NlSG5XTnhqdW1jd3RzZnlTOWVzeWwvVC8xbXQ1VlA3YVNTdksr?=
 =?utf-8?B?bk9XbVYyOGxBeTlmNm91M2ZmY1hDeEpxc21iN1ZjN0F1Wm1yQ0dwZ0MyajBm?=
 =?utf-8?B?QWZpcHRuRXYzSE02NDM5TGo5cStySnlUNTZYT01VeThpdkRsQjZjeEMxTGVs?=
 =?utf-8?B?RTliMStXRU5xZktDVmxUR0Vxc0xaTVRPNkJ3TUE2TVY2OFFlaGxydlZCTC9F?=
 =?utf-8?B?eVV2cmVML014cUsyOGZ6cEpqbEdZU3hrS01xYVpUZkJ2SnF0Y1UwUkRPdS9D?=
 =?utf-8?B?ODc5R3RBNmp4N3dEQWNsdzkvZ1pqWTMvcFhJNHhGYk9GUTcyUnUxTkcxVnU1?=
 =?utf-8?B?N1V3MnNtUndrU1pFSENHUHZzUUVIbklpWEQwZklpZGpOUTVvWldrU0EyNnlT?=
 =?utf-8?B?TTI3bzd4cUhXUzRLTUduQmIyV3d0SDMyZ1lKcE4rSDEyeWY4bjBWL1U5TjRZ?=
 =?utf-8?B?NnkyNTZidisxNkN4aU5yaFhyRmRtRy9QTlZLZ1J3WERSeU5VQTlVdzJEVVg5?=
 =?utf-8?B?N1lXL25hVmlXNzAzeWZjcGwzMFN4R0ZYK1VDTWJwSGRxUkg5WE1uYjJqTUNw?=
 =?utf-8?B?c3JUN1RndDdOc2JjajgrUE1ETS9qTytuaEowWUFQK25aQmxGd2N2d2ZlNFJX?=
 =?utf-8?B?VDNjdm5LT092SEVlZkxZNFNPUEJqaVcrZWh5MTNJbktlRTl5cDV6VzMxWmxw?=
 =?utf-8?B?cHR6RlFPK29nYkx3b3Y4RHVVRFdVQU5zWS9tcWhVYVM3WGNSL252NVovZGdP?=
 =?utf-8?B?aXltRlFaZDUrMGpBSlp2RitwbEt6ZCtqNENCUEVJWkIxRmlXckE2QmJXTGxE?=
 =?utf-8?B?MnlsN3Q3ME9laGNEeklqRDNLUXc2REFXL2x1ZFg3eE9Tem1HQ09ybzlYMTYy?=
 =?utf-8?B?Wk1nYUNRZm1DUDk3dytiMzBMN0VZM3VURmppT3VUamhySVJxUUZMaDNKM3Mr?=
 =?utf-8?B?bitPa2F4b1lmYW9qZ2RISTI1TG1zV3Vka2RqTnZwZXJ1WGQydUJpT1FvVEF2?=
 =?utf-8?B?b1YwY1BaMHhNTzlGNjFSZ0k4L0RSZWxzTTZ3RG1XRHdVUHBlK0RiRE5JSG1a?=
 =?utf-8?B?KzZ5czJ3cWpFVVZXTXRTaTZ0a2ZQaFJHN3lRWFIxdXFDeDNQL3pERU5iL0dC?=
 =?utf-8?B?Tmcxa056UEhxUURrMGl2dkhlUFFvZjgwTUFXWVNBcVMwWG5LcFVteXZzeVUr?=
 =?utf-8?B?TUVaUEx1UitEbjZFN2o0MGVqSnpaV0FOVndpT0hVazN6cUhhajFMNFYyUG0z?=
 =?utf-8?B?QU1ISFZNRFVFK0ZjTENiNlN4ODEzOVRMUmZEVTViRktPeHRSYkJDZTZ6ZFhZ?=
 =?utf-8?B?YVc3QW4rMjcvU0xlbE52TE9yRTJ3MlVmT1E1VUEvSzFwY2ZpTG5VWWVyRHBq?=
 =?utf-8?B?RnlFcnB0VllkY3MyeFYzYzE4TzArcW9CRC9XeVRKNk5NYlVYVlZNYjJRWWIv?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5ae198-435c-4dff-2482-08dc9b7be305
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:19:17.3033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wZmfjZ7Qoul8MT8csYliRegniML2iwjoe4Bcg5+/4QkKxRAkyZ6/9ES267NfEJe4AOlF9nIrJsL3UERlTivLrxiECNmFatHlOn2JfikuY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6770

Hi Guenter,

On 7/1/24 11:23 PM, Guenter Roeck wrote:
> Use regmap for register accesses and for most caching.
> 
> While at it, use sysfs_emit() instead of sprintf() to write sysfs
> attribute data, and remove spurious debug messages which would
> only be seen as result of a bug in the code.
> 
> No functional change intended.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Drop another spurious debug message in this patch instead of patch 10
>      Add missing "select REGMAP_I2C" to Kconfig
>      Change misleading variable name from 'mask' to 'mode'.
>      Use sysfs_emit instead of sprintf everywhere
> 
>   drivers/hwmon/Kconfig   |   1 +
>   drivers/hwmon/amc6821.c | 713 ++++++++++++++++++----------------------
>   2 files changed, 329 insertions(+), 385 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e14ae18a973b..a8fa87a96e8f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2127,6 +2127,7 @@ config SENSORS_ADS7871
>   config SENSORS_AMC6821
>   	tristate "Texas Instruments AMC6821"
>   	depends on I2C
> +	select REGMAP_I2C
>   	help
>   	  If you say yes here you get support for the Texas Instruments
>   	  AMC6821 hardware monitoring chips.
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 028998d3bedf..3fe0bfeac843 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -8,15 +8,16 @@
>    * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
>    */
>   
> +#include <linux/bitops.h>
>   #include <linux/bits.h>
>   #include <linux/err.h>
>   #include <linux/hwmon.h>
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/i2c.h>
>   #include <linux/init.h>
> -#include <linux/jiffies.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/regmap.h>
>   #include <linux/slab.h>
>   
>   /*
> @@ -44,6 +45,7 @@ module_param(init, int, 0444);
>   #define AMC6821_REG_CONF4		0x04
>   #define AMC6821_REG_STAT1		0x02
>   #define AMC6821_REG_STAT2		0x03
> +#define AMC6821_REG_TEMP_LO		0x06
>   #define AMC6821_REG_TDATA_LOW		0x08
>   #define AMC6821_REG_TDATA_HI		0x09
>   #define AMC6821_REG_LTEMP_HI		0x0A
> @@ -61,11 +63,8 @@ module_param(init, int, 0444);
>   #define AMC6821_REG_DCY_LOW_TEMP	0x21
>   
>   #define AMC6821_REG_TACH_LLIMITL	0x10
> -#define AMC6821_REG_TACH_LLIMITH	0x11
>   #define AMC6821_REG_TACH_HLIMITL	0x12
> -#define AMC6821_REG_TACH_HLIMITH	0x13
>   #define AMC6821_REG_TACH_SETTINGL	0x1e
> -#define AMC6821_REG_TACH_SETTINGH	0x1f
>   
>   #define AMC6821_CONF1_START		BIT(0)
>   #define AMC6821_CONF1_FAN_INT_EN	BIT(1)
> @@ -130,224 +129,169 @@ static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
>   			AMC6821_REG_TACH_HLIMITL,
>   			AMC6821_REG_TACH_SETTINGL, };
>   
> -static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
> -			AMC6821_REG_TACH_LLIMITH,
> -			AMC6821_REG_TACH_HLIMITH,
> -			AMC6821_REG_TACH_SETTINGH, };
> -
>   /*
>    * Client data (each client gets its own)
>    */
>   
>   struct amc6821_data {
> -	struct i2c_client *client;
> +	struct regmap *regmap;
>   	struct mutex update_lock;
> -	bool valid; /* false until following fields are valid */
> -	unsigned long last_updated; /* in jiffies */
>   
> -	/* register values */
> -	int temp[TEMP_IDX_LEN];
> -
> -	u16 fan[FAN1_IDX_LEN];
> -	u8 fan1_pulses;
> -
> -	u8 pwm1;
>   	u8 temp1_auto_point_temp[3];
>   	u8 temp2_auto_point_temp[3];
> -	u8 pwm1_auto_point_pwm[3];
> -	u8 pwm1_enable;
> -	u8 pwm1_auto_channels_temp;
> -
> -	u8 stat1;
> -	u8 stat2;
>   };
>   
> -static struct amc6821_data *amc6821_update_device(struct device *dev)
> +static int amc6821_init_auto_point_data(struct amc6821_data *data)
>   {
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	int timeout = HZ;
> -	u8 reg;
> -	int i;
> +	struct regmap *regmap = data->regmap;
> +	u32 pwm, regval;
> +	int err;
>   
> -	mutex_lock(&data->update_lock);
> +	err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);

I think this is incorrect logic.

amc6821_init_auto_point_data is only called once in init_client, in 
probe. While we currently do not write to AMC6821_REG_DCY_LOW_TEMP, we 
could in the future. But writing to it would desynchronise the 
auto_point_temp values for the new value of the register.

I suggest we put the logic into a function and return the value for a 
given temp_auto_point (1/2 currently) so that we are calling this 
function instead of a member in the struct so that we are never caching 
it unknowingly (regmap would do it for us in any case). It's a bit odd 
anyway to have only **those** values be cached in the struct as members 
and migrating everything else.

> +	if (err)
> +		return err;
>   
> -	if (time_after(jiffies, data->last_updated + timeout) ||
> -			!data->valid) {
> +	err = regmap_read(regmap, AMC6821_REG_PSV_TEMP, &regval);
> +	if (err)
> +		return err;
> +	data->temp1_auto_point_temp[0] = regval;
> +	data->temp2_auto_point_temp[0] = data->temp1_auto_point_temp[0];
>   
> -		for (i = 0; i < TEMP_IDX_LEN; i++)
> -			data->temp[i] = (int8_t)i2c_smbus_read_byte_data(
> -				client, temp_reg[i]);
> +	err = regmap_read(regmap, AMC6821_REG_LTEMP_FAN_CTRL, &regval);
> +	if (err)
> +		return err;
> +	data->temp1_auto_point_temp[1] = (regval & 0xF8) >> 1;
>   
> -		data->stat1 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_STAT1);
> -		data->stat2 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_STAT2);
> +	regval &= 0x07;
> +	regval = 0x20 >> regval;
> +	if (regval)
> +		data->temp1_auto_point_temp[2] =
> +			data->temp1_auto_point_temp[1] +
> +			(255 - pwm) / regval;
> +	else
> +		data->temp1_auto_point_temp[2] = 255;
>   
> -		data->pwm1 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_DCY);
> -		for (i = 0; i < FAN1_IDX_LEN; i++) {
> -			data->fan[i] = i2c_smbus_read_byte_data(
> -					client,
> -					fan_reg_low[i]);
> -			data->fan[i] += i2c_smbus_read_byte_data(
> -					client,
> -					fan_reg_hi[i]) << 8;
> -		}
> -		data->fan1_pulses = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_CONF4);
> -		data->fan1_pulses = data->fan1_pulses & AMC6821_CONF4_PSPR ? 4 : 2;
> +	err = regmap_read(regmap, AMC6821_REG_RTEMP_FAN_CTRL, &regval);
> +	if (err)
> +		return err;
>   
> -		data->pwm1_auto_point_pwm[0] = 0;
> -		data->pwm1_auto_point_pwm[2] = 255;
> -		data->pwm1_auto_point_pwm[1] = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_DCY_LOW_TEMP);
> +	data->temp2_auto_point_temp[1] = (regval & 0xF8) >> 1;
> +	regval &= 0x07;
> +	regval = 0x20 >> regval;
>   
> -		data->temp1_auto_point_temp[0] =
> -			i2c_smbus_read_byte_data(client,
> -					AMC6821_REG_PSV_TEMP);
> -		data->temp2_auto_point_temp[0] =
> -				data->temp1_auto_point_temp[0];
> -		reg = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_LTEMP_FAN_CTRL);
> -		data->temp1_auto_point_temp[1] = (reg & 0xF8) >> 1;
> -		reg &= 0x07;
> -		reg = 0x20 >> reg;
> -		if (reg > 0)
> -			data->temp1_auto_point_temp[2] =
> -				data->temp1_auto_point_temp[1] +
> -				(data->pwm1_auto_point_pwm[2] -
> -				data->pwm1_auto_point_pwm[1]) / reg;
> -		else
> -			data->temp1_auto_point_temp[2] = 255;
> +	if (regval)
> +		data->temp2_auto_point_temp[2] =
> +			data->temp2_auto_point_temp[1] +
> +			(255 - pwm) / regval;
> +	else
> +		data->temp2_auto_point_temp[2] = 255;
>   
> -		reg = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_RTEMP_FAN_CTRL);
> -		data->temp2_auto_point_temp[1] = (reg & 0xF8) >> 1;
> -		reg &= 0x07;
> -		reg = 0x20 >> reg;
> -		if (reg > 0)
> -			data->temp2_auto_point_temp[2] =
> -				data->temp2_auto_point_temp[1] +
> -				(data->pwm1_auto_point_pwm[2] -
> -				data->pwm1_auto_point_pwm[1]) / reg;
> -		else
> -			data->temp2_auto_point_temp[2] = 255;
> -
> -		reg = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
> -		reg = (reg >> 5) & 0x3;
> -		switch (reg) {
> -		case 0: /*open loop: software sets pwm1*/
> -			data->pwm1_auto_channels_temp = 0;
> -			data->pwm1_enable = 1;
> -			break;
> -		case 2: /*closed loop: remote T (temp2)*/
> -			data->pwm1_auto_channels_temp = 2;
> -			data->pwm1_enable = 2;
> -			break;
> -		case 3: /*closed loop: local and remote T (temp2)*/
> -			data->pwm1_auto_channels_temp = 3;
> -			data->pwm1_enable = 3;
> -			break;
> -		case 1: /*
> -			 * semi-open loop: software sets rpm, chip controls
> -			 * pwm1
> -			 */
> -			data->pwm1_auto_channels_temp = 0;
> -			data->pwm1_enable = 4;
> -			break;
> -		}
> -
> -		data->last_updated = jiffies;
> -		data->valid = true;
> -	}
> -	mutex_unlock(&data->update_lock);
> -	return data;
> +	return 0;
>   }
>   
>   static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
>   			 char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr(devattr)->index;
> +	u32 regval;
> +	int err;
>   
> -	return sprintf(buf, "%d\n", data->temp[ix] * 1000);
> +	err = regmap_read(data->regmap, temp_reg[ix], &regval);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%d\n", sign_extend32(regval, 7) * 1000);
>   }
>   
>   static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
>   			  const char *buf, size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>   	int ix = to_sensor_dev_attr(attr)->index;
>   	long val;
> +	int err;
>   
>   	int ret = kstrtol(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   	val = clamp_val(val / 1000, -128, 127);
>   
> -	mutex_lock(&data->update_lock);
> -	data->temp[ix] = val;
> -	if (i2c_smbus_write_byte_data(client, temp_reg[ix], data->temp[ix])) {
> -		dev_err(&client->dev, "Register write error, aborting.\n");
> -		count = -EIO;
> -	}
> -	mutex_unlock(&data->update_lock);
> +	err = regmap_write(data->regmap, temp_reg[ix], val);
> +	if (err)
> +		return err;
> +
>   	return count;
>   }
>   
>   static ssize_t temp_alarm_show(struct device *dev,
>   			       struct device_attribute *devattr, char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr(devattr)->index;
> -	u8 flag;
> +	u32 regval, mask, reg;
> +	int err;
>   
>   	switch (ix) {
>   	case IDX_TEMP1_MIN:
> -		flag = data->stat1 & AMC6821_STAT1_LTL;
> +		reg = AMC6821_REG_STAT1;
> +		mask = AMC6821_STAT1_LTL;
>   		break;
>   	case IDX_TEMP1_MAX:
> -		flag = data->stat1 & AMC6821_STAT1_LTH;
> +		reg = AMC6821_REG_STAT1;
> +		mask = AMC6821_STAT1_LTH;
>   		break;
>   	case IDX_TEMP1_CRIT:
> -		flag = data->stat2 & AMC6821_STAT2_LTC;
> +		reg = AMC6821_REG_STAT2;
> +		mask = AMC6821_STAT2_LTC;
>   		break;
>   	case IDX_TEMP2_MIN:
> -		flag = data->stat1 & AMC6821_STAT1_RTL;
> +		reg = AMC6821_REG_STAT1;
> +		mask = AMC6821_STAT1_RTL;
>   		break;
>   	case IDX_TEMP2_MAX:
> -		flag = data->stat1 & AMC6821_STAT1_RTH;
> +		reg = AMC6821_REG_STAT1;
> +		mask = AMC6821_STAT1_RTH;
>   		break;
>   	case IDX_TEMP2_CRIT:
> -		flag = data->stat2 & AMC6821_STAT2_RTC;
> +		reg = AMC6821_REG_STAT2;
> +		mask = AMC6821_STAT2_RTC;
>   		break;
>   	default:
> -		dev_dbg(dev, "Unknown attr->index (%d).\n", ix);

Was this an intended removal? I think we can afford keeping it in?

>   		return -EINVAL;
>   	}
> -	if (flag)
> -		return sprintf(buf, "1");
> -	else
> -		return sprintf(buf, "0");
> +	err = regmap_read(data->regmap, reg, &regval);
> +	if (err)
> +		return err;
> +	return sysfs_emit(buf, "%d\n", !!(regval & mask));
>   }
>   
>   static ssize_t temp2_fault_show(struct device *dev,
>   				struct device_attribute *devattr, char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	if (data->stat1 & AMC6821_STAT1_RTF)
> -		return sprintf(buf, "1");
> -	else
> -		return sprintf(buf, "0");
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	u32 regval;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_RTF));
>   }
>   
>   static ssize_t pwm1_show(struct device *dev, struct device_attribute *devattr,
>   			 char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	u32 regval;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AMC6821_REG_DCY, &regval);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%d\n", regval);
>   }
>   
>   static ssize_t pwm1_store(struct device *dev,
> @@ -355,24 +299,43 @@ static ssize_t pwm1_store(struct device *dev,
>   			  size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>   	u8 val;
>   	int ret = kstrtou8(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   
> -	mutex_lock(&data->update_lock);
> -	data->pwm1 = val;
> -	i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
> -	mutex_unlock(&data->update_lock);
> +	ret = regmap_write(data->regmap, AMC6821_REG_DCY, val);
> +	if (ret)
> +		return ret;
> +
>   	return count;
>   }
>   
>   static ssize_t pwm1_enable_show(struct device *dev,
>   				struct device_attribute *devattr, char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1_enable);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	int err;
> +	u32 val;
> +
> +	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
> +	if (err)
> +		return err;
> +	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
> +	case 0:
> +		val = 1;	/* manual */
> +		break;
> +	case AMC6821_CONF1_FDRC0:
> +		val = 4;	/* target rpm (fan1_target) controlled */
> +		break;
> +	case AMC6821_CONF1_FDRC1:
> +		val = 2;	/* remote temp controlled */
> +		break;
> +	default:
> +		val = 3;	/* max(local, remote) temp controlled */
> +		break;
> +	}
> +	return sysfs_emit(buf, "%d\n", val);
>   }
>   
>   static ssize_t pwm1_enable_store(struct device *dev,
> @@ -380,49 +343,37 @@ static ssize_t pwm1_enable_store(struct device *dev,
>   				 const char *buf, size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>   	long val;
> -	int config = kstrtol(buf, 10, &val);
> -	if (config)
> -		return config;
> +	u32 mode;
> +	int err;
>   
> -	mutex_lock(&data->update_lock);
> -	config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
> -	if (config < 0) {
> -			dev_err(&client->dev,
> -			"Error reading configuration register, aborting.\n");
> -			count = config;
> -			goto unlock;
> -	}
> +	err = kstrtol(buf, 10, &val);
> +	if (err)
> +		return err;
>   
>   	switch (val) {
>   	case 1:
> -		config &= ~AMC6821_CONF1_FDRC0;
> -		config &= ~AMC6821_CONF1_FDRC1;
> +		mode = 0;
>   		break;
>   	case 2:
> -		config &= ~AMC6821_CONF1_FDRC0;
> -		config |= AMC6821_CONF1_FDRC1;
> +		mode = AMC6821_CONF1_FDRC1;
>   		break;
>   	case 3:
> -		config |= AMC6821_CONF1_FDRC0;
> -		config |= AMC6821_CONF1_FDRC1;
> +		mode = AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1;
>   		break;
>   	case 4:
> -		config |= AMC6821_CONF1_FDRC0;
> -		config &= ~AMC6821_CONF1_FDRC1;
> +		mode = AMC6821_CONF1_FDRC0;
>   		break;
>   	default:
> -		count = -EINVAL;
> -		goto unlock;
> +		return -EINVAL;
>   	}
> -	if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF1, config)) {
> -			dev_err(&client->dev,
> -			"Configuration register write error, aborting.\n");
> -			count = -EIO;
> -	}
> -unlock:
> -	mutex_unlock(&data->update_lock);
> +
> +	err = regmap_update_bits(data->regmap, AMC6821_REG_CONF1,
> +				 AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
> +				 mode);
> +	if (err)
> +		return err;
> +
>   	return count;
>   }
>   
> @@ -430,26 +381,45 @@ static ssize_t pwm1_auto_channels_temp_show(struct device *dev,
>   					    struct device_attribute *devattr,
>   					    char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1_auto_channels_temp);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	u32 val;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
> +	if (err)
> +		return err;
> +	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
> +	case 0:
> +	case AMC6821_CONF1_FDRC0:
> +		val = 0;	/* manual or target rpm controlled */
> +		break;
> +	case AMC6821_CONF1_FDRC1:
> +		val = 2;	/* remote temp controlled */
> +		break;
> +	default:
> +		val = 3;	/* max(local, remote) temp controlled */
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%d\n", val);
>   }
>   
>   static ssize_t temp_auto_point_temp_show(struct device *dev,
>   					 struct device_attribute *devattr,
>   					 char *buf)
>   {
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr_2(devattr)->index;
>   	int nr = to_sensor_dev_attr_2(devattr)->nr;
> -	struct amc6821_data *data = amc6821_update_device(dev);
> +
>   	switch (nr) {
>   	case 1:
> -		return sprintf(buf, "%d\n",
> -			data->temp1_auto_point_temp[ix] * 1000);
> +		return sysfs_emit(buf, "%d\n",
> +				  data->temp1_auto_point_temp[ix] * 1000);
>   	case 2:
> -		return sprintf(buf, "%d\n",
> -			data->temp2_auto_point_temp[ix] * 1000);
> +		return sysfs_emit(buf, "%d\n",
> +				  data->temp2_auto_point_temp[ix] * 1000);
>   	default:
> -		dev_dbg(dev, "Unknown attr->nr (%d).\n", nr);

Ditto.

>   		return -EINVAL;
>   	}
>   }
> @@ -458,44 +428,59 @@ static ssize_t pwm1_auto_point_pwm_show(struct device *dev,
>   					struct device_attribute *devattr,
>   					char *buf)
>   {
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr(devattr)->index;
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1_auto_point_pwm[ix]);
> +	u32 val;
> +	int err;
> +
> +	switch (ix) {
> +	case 0:
> +		val = 0;
> +		break;
> +	case 1:
> +		err = regmap_read(data->regmap, AMC6821_REG_DCY_LOW_TEMP, &val);
> +		if (err)
> +			return err;
> +		break;
> +	default:
> +		val = 255;
> +		break;
> +	}
> +	return sysfs_emit(buf, "%d\n", val);
>   }
>   
> -static inline ssize_t set_slope_register(struct i2c_client *client,
> -		u8 reg,
> -		u8 dpwm,
> -		u8 *ptemp)
> +static inline int set_slope_register(struct regmap *regmap,
> +				     u8 reg, u8 *ptemp)
>   {
> -	int dt;
> -	u8 tmp;
> +	u8 tmp, dpwm;
> +	int err, dt;
> +	u32 pwm;
>   
> -	dt = ptemp[2]-ptemp[1];
> +	err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
> +	if (err)
> +		return err;
> +
> +	dpwm = 255 - pwm;
> +
> +	dt = ptemp[2] - ptemp[1];
>   	for (tmp = 4; tmp > 0; tmp--) {
>   		if (dt * (0x20 >> tmp) >= dpwm)
>   			break;
>   	}
>   	tmp |= (ptemp[1] & 0x7C) << 1;
> -	if (i2c_smbus_write_byte_data(client,
> -			reg, tmp)) {
> -		dev_err(&client->dev, "Register write error, aborting.\n");
> -		return -EIO;
> -	}
> -	return 0;
> +	return regmap_write(regmap, reg, tmp);
>   }
>   
>   static ssize_t temp_auto_point_temp_store(struct device *dev,
>   					  struct device_attribute *attr,
>   					  const char *buf, size_t count)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	struct i2c_client *client = data->client;
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr_2(attr)->index;
>   	int nr = to_sensor_dev_attr_2(attr)->nr;
> +	struct regmap *regmap = data->regmap;
>   	u8 *ptemp;
>   	u8 reg;
> -	int dpwm;
>   	long val;
>   	int ret = kstrtol(buf, 10, &val);
>   	if (ret)
> @@ -511,12 +496,10 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
>   		reg = AMC6821_REG_RTEMP_FAN_CTRL;
>   		break;
>   	default:
> -		dev_dbg(dev, "Unknown attr->nr (%d).\n", nr);

Ditto.

>   		return -EINVAL;
>   	}
>   
>   	mutex_lock(&data->update_lock);
> -	data->valid = false;
>   
>   	switch (ix) {
>   	case 0:
> @@ -525,13 +508,9 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
>   		ptemp[0] = clamp_val(ptemp[0], 0,
>   				     data->temp2_auto_point_temp[1]);
>   		ptemp[0] = clamp_val(ptemp[0], 0, 63);
> -		if (i2c_smbus_write_byte_data(
> -					client,
> -					AMC6821_REG_PSV_TEMP,
> -					ptemp[0])) {
> -				dev_err(&client->dev,
> -					"Register write error, aborting.\n");
> -				count = -EIO;
> +		if (regmap_write(regmap, AMC6821_REG_PSV_TEMP, ptemp[0])) {
> +			dev_err(dev, "Register write error, aborting.\n");
> +			count = -EIO;
>   		}
>   		goto EXIT;
>   	case 1:
> @@ -543,12 +522,10 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
>   		ptemp[2] = clamp_val(val / 1000, ptemp[1]+1, 255);
>   		break;
>   	default:
> -		dev_dbg(dev, "Unknown attr->index (%d).\n", ix);

Ditto.

>   		count = -EINVAL;
>   		goto EXIT;
>   	}
> -	dpwm = data->pwm1_auto_point_pwm[2] - data->pwm1_auto_point_pwm[1];
> -	if (set_slope_register(client, reg, dpwm, ptemp))
> +	if (set_slope_register(regmap, reg, ptemp))
>   		count = -EIO;
>   
>   EXIT:
> @@ -561,10 +538,11 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>   					 const char *buf, size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	int dpwm;
> +	struct regmap *regmap = data->regmap;
>   	u8 val;
> -	int ret = kstrtou8(buf, 10, &val);
> +	int ret;
> +
> +	ret = kstrtou8(buf, 10, &val);

Not sure this cosmetic change is worth it? Or maybe squash with an 
earlier commit?

>   	if (ret)
>   		return ret;
>   
> @@ -572,27 +550,24 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>   		return -EINVAL;
>   
>   	mutex_lock(&data->update_lock);
> -	data->pwm1_auto_point_pwm[1] = val;
> -	if (i2c_smbus_write_byte_data(client, AMC6821_REG_DCY_LOW_TEMP,
> -			data->pwm1_auto_point_pwm[1])) {
> -		dev_err(&client->dev, "Register write error, aborting.\n");
> -		count = -EIO;
> -		goto EXIT;
> +	ret = regmap_write(regmap, AMC6821_REG_DCY_LOW_TEMP, val);
> +	if (ret)

I think we're missing a count = something here?

> +		goto unlock;
> +
> +	ret = set_slope_register(regmap, AMC6821_REG_LTEMP_FAN_CTRL,
> +				 data->temp1_auto_point_temp);
> +	if (ret) {
> +		count = ret;

In some places, we replace set_slope_register return code with -EIO 
(like it was) and sometimes we propagate it, like here. Is there some 
reason for this or can we have some kind of consistency across the code 
base here?

Looks good to me otherwise.

Cheers,
Quentin

