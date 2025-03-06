Return-Path: <linux-kernel+bounces-548323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C778A5435D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0093D3A3CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70061AAE2E;
	Thu,  6 Mar 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hmiM+tov"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60819DF4D;
	Thu,  6 Mar 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245170; cv=fail; b=nkUA7cViz6uPbSYgl349nE51xhTJhorxShBFUEWeNLJRVpkOPNfafRyfTvdZOWdLIfXEoASiKAOybZ2lbKPmcfBOCw6z+9X2WN6D5GLY2vFUrc93XwdzOwHsAimgE0CHly4AzsPU3F8vQXVFt++3Fx5SNEMzI5oW51zwOSkiwDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245170; c=relaxed/simple;
	bh=2Oe4H1XCHUP2Y2S8n1QQMYO62S2xit+8kBXR9zfhGFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SDDi4+kzxi+YcP3nJF/H6phwwzTJ0No2wIruxZa0L74uEUtO5Wup89LtLZo9sPgj0rM5KWVh3G/Tl9s9fkeEprmAkZ8ySKdq4k+cNVJMumdv61GJoKenlk4Nfa9n76VHIBnmYkL0bAA9n2VRwpAzIxq/BMHAvEHBwRoz2nrVRbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hmiM+tov; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAQjyazizvCdyfm+8GiWW2bdnnzjeFUTTJ2t5anEgasKE5/frj/N3WKocTmzk7XuRU0tbO6gP++FH0/yyR+E7/eBVhaSGOzzMq11QpSIrCAsEvCWzw3/csJwh0CHpWK4UayNpnND2cAkgaQBpXeD5eigaCEpjNuTOcGego+tCnaUq9NrZVEx3XQcu8uH3FScGyBFoMHajVLxOh07aJ4bKUVR7dRLiyYDwwE8ew5MuhxhrkAqCzQ0A9mx/SSwaj/yZIVNgByQWGCG8LAP9Y3UmRKAENlM9JII9YkFZXIvPekT17aVL3rTDrl74UBWfiALYHbSZZjhY9Inv06C/vrlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0tAR0w/mPjTkSOJf5kqAAA4AQAFaRiGOz70k3Ox5xI=;
 b=fjM+lfHrEjmOk2lMRywv7C8EHDypj55UY7T1eDjzNeAGAHfoZat1dz6nEt6r+4oaLvHqfnXfPpWoMxC4faZsXMEXIq9U3StANmkBgJOjT+UIBvdsFACL+qS5CytJv+77Z0p1iTl+JAlJb/Pe9rs34Jt2AAH7EPjTvg/4M1qD3yDoAx3YdLAOFAB/+g9wS0XkAoR/I6uB4q+9etmQUfNOC4GWGss4qEKi+ta4NuzFIR4DqSY0LoyGqpkCpvY4QNwYcteVuVQfYsnqOSxzf8dMQFoe/rb34vE+sz7nqdksiZhIjLOyTpQbAhmHBzm9R/KSqDX+0O56qnLmRhZX6CqStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0tAR0w/mPjTkSOJf5kqAAA4AQAFaRiGOz70k3Ox5xI=;
 b=hmiM+toviUJV/rrP9nKeBTTaXE0pdUfdB+sgZtr/WgYJpB0yk9Zh/7O79+3v9+jB+UN7V7TspSNJ/b4CdLbCQESq8Kqb7JbyBqdeNULP7pqSxxGoldQuHiNx8BrqicEkrC3rVQKNinK/HVMP3+X2afVEq4S21O1NLfyClySDevxlHxpHv3w/s8M27yUTWF+ZecCceYIOa7Sq8mJ/31htJ+JKQi0QUyKkvqwvIRxKTsG+Q1iq8nsANsmUa/gCSgdvcKyeHSDMa0/wcx5l0DLC4Rwfdw0cBLyH+04meWizr48az6uSqOs9RmftqghmTwgp5H1+g1RQAMGySWoJBFcovA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM7PR04MB6901.eurprd04.prod.outlook.com (2603:10a6:20b:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 07:12:46 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 07:12:46 +0000
Message-ID: <eef39d56-0914-4416-aea5-e04072333849@nxp.com>
Date: Thu, 6 Mar 2025 15:13:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: display: Document DPI color codings
To: Krzysztof Kozlowski <krzk@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-2-victor.liu@nxp.com>
 <20250304-deer-of-striking-pride-ff6e86@houat>
 <20250305-important-quizzical-chamois-ff48af@krzk-bin>
 <20250305-mustard-parrot-of-karma-1caf5d@houat>
 <0606709e-2a08-4168-89f0-826a0fb23cab@kernel.org>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <0606709e-2a08-4168-89f0-826a0fb23cab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM7PR04MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 7547cf78-88ff-422d-be80-08dd5c7e4b87
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S0pBZmJCK0o3ZS82YVdaWXdESndpWG9QRDRIZEVxZ0hyS3FOMWhwN0NYaHUv?=
 =?utf-8?B?WGQ4YjZFU1M1MXBCTnNoZlU0NktpV2U3aW9XTGJPR0VpaEdjN0VkUmRQVzhL?=
 =?utf-8?B?eWo5UkFKaHhLOGFKUncrUEcrQ1hxWnA3R2VRdkZXaklaMWdERGZIdFh2UHZH?=
 =?utf-8?B?dzV4K1p2S0ZXWmY3YmZyMWNjRUt1V1pPN2NSb1pXQktHQ0lWblhjdmwwdHJG?=
 =?utf-8?B?NGplZmlsK3VwYWVYNWhLMThQVlRVZ0JNUUtMN3FmbEZtcm1MTUxqY0l1RGJ5?=
 =?utf-8?B?STZIOTgwQ2ZLTWJjUXlET0xFRXU4VUVUalY0TXpsUm5OY21qajl5MytHZ2VW?=
 =?utf-8?B?Tm15RDNERkkrZ0dKc3BtSnJSUGcvRm1zY2lKem9WblZkVkdLcVZtbW1WczUz?=
 =?utf-8?B?K2VGVHpKbkFlTVRFdEp4TzdUbk5YUDdWMGtqRkx2VW8rM1ZXLzRwTEQzdkQx?=
 =?utf-8?B?K096SEVnYW5TWTYzemlYU3dGcFJxdDNPNUlZRG1NTFBZWGwyYUh6TW03NHhk?=
 =?utf-8?B?Zk5CZUMzTEdVeERsSjVYWFVheVUxRXJGc2ZmYlRSWG03YUprS2JnYUJOUURC?=
 =?utf-8?B?RG5naWlxMVp0aGJ3M2dSMks2R1BIQXROV1V5clJDKy9DU1Z2ZlJraU44MENN?=
 =?utf-8?B?SWo4Z05uNDFZeUtkc3dHakYyaVcrd1A4UkcxQUtjY0ZNTUswN3ZqYWNiYkJs?=
 =?utf-8?B?aDB3bmhpRjJaMkQ2dTNMNzZBVUZJK0RYMFh5dU9LVjNzS1JpcG5HbmdsaCtn?=
 =?utf-8?B?WlFTNHliZnZwanpJd0c0ckV2WEJ1RzA4bklSUVBJV0dIcXU3cjhPTVRlcktm?=
 =?utf-8?B?ZFJzUFNZS1M4UGRmZlhKcE5lQ0FQNy9zU25jMkRsQS8vcWthanRyaTNyZkNy?=
 =?utf-8?B?dGZ5cDlwRklzREE3UitQZnhqMkRrRFRTWUM3bnNLTlhBc1NTSkJhbVo0Mk5Q?=
 =?utf-8?B?YzFFYkdLNDFCMkllNGUxcGxDeFgxWC9GWVlIaHF0WkR0eXdjZnJIeXJqakVn?=
 =?utf-8?B?UVFjMDdtNTNGVHNBWjZXakdpZllaeE5oYy9NeWhyOWtnMEpTQU1WWVI1WW0r?=
 =?utf-8?B?QlBrSEU3V2Q1SDcxQkJ1TUZadTdnazJ0bjhkVmttV2cvcHVEUjUvbEVpMml2?=
 =?utf-8?B?WTJHUzdDQXhXS2NBeDAwWXRvc1RDVnliaS9ub052Y29NMzUxQ0RUSFZjN1p1?=
 =?utf-8?B?VzdoVGYrbUpUQWR2NzdPQlRPemhYWWl5ZjZsQmY4TlF5QkUrMHI5bjUybjF2?=
 =?utf-8?B?cDZVSXFrWFAxWmRlNHY4LzJ5QjFleDVtMVVRRFJJb2swSjcwdHZyMUpBbVBS?=
 =?utf-8?B?WUV6ZGtTc3lybEhUd2wrV1lqZDJSWGl4Zk11NmZUeTd6RmFlVkZJN29SQ1NX?=
 =?utf-8?B?U3pJQVNybnBmQTF0dTFTVCs0MXJsY1R4dzJGY2hjU1psQjNTY2pRc1FaYXY4?=
 =?utf-8?B?Zi9La2luMVFDdlRuMHVEYkdWVjBOQWJnL3BZbnpoalBWVjdBd3QrUFkwZEoy?=
 =?utf-8?B?TVB5TmgwUXVBdDRSbWZiSlM1b3A3NXpEVTlpOXYrMi9hOW9vQjNuZXdLUHhq?=
 =?utf-8?B?N0VaQWk4U3pQVFlIT0NTYW5IUEJDb1BLNlU5YkJZeHhkSURNc3oycUc3akt1?=
 =?utf-8?B?dU90Z0kycHJFMVh3OUVWS2xOajFkbWFzNEhMcnY1bG1EUHJHQUlPQ05pcDJx?=
 =?utf-8?B?RjlYUUVpbkU0ZGdnbW9UUGNOemJVcG8vNGhtZzVzbHkwektWdnBWYjVhWkFy?=
 =?utf-8?B?VXRmdXhzR2VwVVNhbzRQclRlVWZrQXI5WFBZd2xWUTNuNFUxQ3E4OU1iSG5V?=
 =?utf-8?B?VXR0V2NiVVg3bkFKcXpYdEZMa1dVV1lhT2JUd3k0ekhmTVcxa0hCeVBGb1VB?=
 =?utf-8?Q?sTIsWnxys+hbC?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K3c5YjRmYVpHcFVneE9tV0xqeS91QnF1Qk1zb3ZXM2NKQ1paNmJZRGo2M0JB?=
 =?utf-8?B?Wk9BclkzcHIvakw0dWxjQmVPcWFNSGFDNDd2UDZXVU9uc1J4ZEdwY3F0eHVi?=
 =?utf-8?B?Vy9Zc21IbFJDWnVNUm9pL2JJRVRkRlN2SFVJVkd5aUJVUGdvYjNCWDErRkp0?=
 =?utf-8?B?SmQzWFZhT3NkaTI2OEYwQzFEYmZrMTJVbU5JNzF2SytXMHBUSmZTR2hMOE5m?=
 =?utf-8?B?MFpmRzBTdjhkTjc4NkFkTVdGZlptbGdsOEdIenFTYW50OVNOWFhrWmZjT2sv?=
 =?utf-8?B?Um56bGdQd1RCb0JyL1ZTZlhkaGVDdmhQa3Y2K1FtelhkOGpRR3B6VzhudjJ5?=
 =?utf-8?B?K2hlQUNUcW9NdHZVWlhZR1E2SGVDc3hnYlFIVFF6SkpvdTBERytwejVKYVhW?=
 =?utf-8?B?Y294WEVVU0Vzcmsxam0xc09lUU5PMStpWFJDaTRpMkFBVVIzV3JGOUZpaUt1?=
 =?utf-8?B?VnJLLzh0dEFtVkRSeHdoaU5YdFZGZFp1N0VHcG9zNmlHNlAwcE5FUENsOVFC?=
 =?utf-8?B?QUVyUUVzbThrYk1wSWIyWERiNW8wWlpRdElkclk4OHY4eXREL2lhem1kbUZP?=
 =?utf-8?B?ajJiWmNyeEFOSDBmT29kN2R1TFBBdEtHNXQwUFprVnlRdUozMlZqb2pDWnhw?=
 =?utf-8?B?eXdOaXdlMHNLYmEzUU4yVnZIWTluOVZFZFJ1VkdVNDJHMXZDU3JwYWFWOWNX?=
 =?utf-8?B?SHlaamo2VEpuaFRxRDhHdm43QVpRaC9tNkVhaEVXL3JySnVSdWh6OHJwd1Vj?=
 =?utf-8?B?RmxqcmFPajhVNVd3M05zVVdzWDErZFhSVm15Ti9pcmQzckI2WThRM0ZvRUhM?=
 =?utf-8?B?NUUySnR4QTFDQlV2TXBlS0tZQ2VSQThrc3VjQUNTNkNjQlkrZ0hEdDh5bHB3?=
 =?utf-8?B?SXRyZVh2YmlBZjdrdzJTVXkxTWp0Q1B5dEZsL3FkZUoxUGIvZllpT1VudGM5?=
 =?utf-8?B?V1VZZWpwV2hNZHRFVjNqUk9pbTVNZEh4S1YwTEkvSU5LUjhVSExpK01CcExN?=
 =?utf-8?B?RGFNYXlsdHVaSGx2aG5XOEgrc3B4SDlCQ1RpeXJ4ME5nZmpIZDM1RUZQRHRD?=
 =?utf-8?B?Mm1nbm9pbjhRL1lPVE15di93Q3dFc09LZVBJakJMN2ZPWC9tdjBkVTl3RlRF?=
 =?utf-8?B?aUlPRWdTcGExMHRjbTNsVnUvQUxRME15OVFBUlR4YXBjbitWSHJiemoxWVY2?=
 =?utf-8?B?d3k2WHZvZE42Mk5KOHBULzhRajU2REJxNE5OUGMzRDd4ZHd3OWNodFJNeXdp?=
 =?utf-8?B?eFJWRG0vWk1Bcm1WWHpORC9EeVNHZW5LTGwzK0l2NnpUWURjTW9qb3VGd2tm?=
 =?utf-8?B?ellreGZRL1VFRFFORzE4RVpFUDdZZEhpeGJFYkZqeUNiRHFiTnFlNlFDUFpZ?=
 =?utf-8?B?UWVoTlVqOVZQZTR0bFQrejBvbThrMDJXOUFISkpqeW9DN01ja3VCaUtpWndE?=
 =?utf-8?B?M2JwLzdidGx3QmdUWTNwRG9kK2V2Q0s0NFVOQnVVVzRUVEUwbWxhN3NhZXRH?=
 =?utf-8?B?TFFKRmJUVW44T3lnOVRqMWFPQVdlNHVrZFFjamdXeUt3anNJamlremw3dndk?=
 =?utf-8?B?Ny9qa1RBWU9qMkhpUlY1NVNjaWxHRWhZM0RjOHllb2lFN2dkdktIbExzenQ0?=
 =?utf-8?B?MkFENW9qa2lTc25nNW05K2FUMHg5K3hXMnZTWTd6R3NrcFRwclRtUngzL2FJ?=
 =?utf-8?B?UkwzdERTTDFrWnpwcWhIRUFFS1NUUjI5LzJ2NlF6dlJ3RUxicUdpMUlXSHdw?=
 =?utf-8?B?TXVaNFA3K3dHZXVWcCs1aWRLTkhFazRLSjRXU3dIZnVWQVJyek5WRTlJNmc1?=
 =?utf-8?B?QnFDemtzdVlhek15ZHhLaFVNZTdOSE0yclYwdVAvS2pIZDJnT2NycDJ4VEpz?=
 =?utf-8?B?ZGVOeE4wYnp5SGNmTCtxNlcxU0J6Z3FReU5qYlh5YWRaeGFaRk9qQmtuRU5X?=
 =?utf-8?B?Z2Q4UHZVZ2NvZHNjWXllRHo0K0QwUTQ3SEwrVURtOVJYQTE1RGE5RWoxaUpT?=
 =?utf-8?B?Y3BYQ0FqZ2kyRCtCM1MzSVh2YlM4WmdiM1VOTlZUcmV0Uld1N1dHOUo1RWl0?=
 =?utf-8?B?UWpkK2UyUGtXTHlZNTMySTRsWXhUY0t0blRNVzBjSEFJUXNudWRndEtTVnlq?=
 =?utf-8?Q?Yi5Ok++5KvnF15tDomGg+LEhc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7547cf78-88ff-422d-be80-08dd5c7e4b87
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 07:12:46.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fLmD3OlnvIU/W3jNmyACjjA+7wEzPKFHE1JDgrS8Hn+Cg9cb3FZFCVUtnC7vam5G278SwEGsPmS1BWcuT4Mhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6901

On 03/05/2025, Krzysztof Kozlowski wrote:
> On 05/03/2025 09:26, Maxime Ripard wrote:
>> On Wed, Mar 05, 2025 at 08:51:35AM +0100, Krzysztof Kozlowski wrote:
>>> On Tue, Mar 04, 2025 at 11:33:44AM +0100, Maxime Ripard wrote:
>>>>> +properties:
>>>>> +  dpi-color-coding:
>>>>> +    enum:
>>>>> +      - 16bit-configuration1
>>>>> +      - 16bit-configuration2
>>>>> +      - 16bit-configuration3
>>>>> +      - 18bit-configuration1
>>>>> +      - 18bit-configuration2
>>>>> +      - 24bit
>>>>
>>>> Do we really needs strings there? It would be much better to use an int
>>>> plus a header

I thought it was fine to align to lvds-data-mapping.yaml where data-mapping
is defined as strings, like "vesa-24".

>>>
>>> So DTS would sill have a name, just being a define? Then what is the
>>> benefit comparing to strings above in DTS readability?
>>
>> There's no benefits and no downside when it comes to readability.
>>
>> However, it's not the only criteria, and not having to manipulate
>> strings but instead just doing int comparison is a huge plus.
> 
> Sure, defines work as well. BTW, it has a minor drawback on bindings as
> it means you might need to update both binding and the header when
> adding new entry, but I understand that it makes implementation life
> easier or faster.

If no objections, I'd use integer color codings.

> 
> Best regards,
> Krzysztof

-- 
Regards,
Liu Ying

