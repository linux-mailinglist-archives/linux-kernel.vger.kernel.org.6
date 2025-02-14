Return-Path: <linux-kernel+bounces-514948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65CEA35DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB3F188F5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F025A626;
	Fri, 14 Feb 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VzKZrRie"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327217555;
	Fri, 14 Feb 2025 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537389; cv=fail; b=ijoprKNjg9i3dKnGysk9SBjaIJVr47ydkiHE+KerjIDvY9CrTEhVDzj43fFQPmAedGwezQOMXHFqrQS7HV9qeJWf1aCmdsM2PiT8LvR61j4/TPFOKIxOnzlHqZkJPzkF5+HjwvQicSXpA9dyb6FluDkpGWQuAEoTiLVWj6t/SMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537389; c=relaxed/simple;
	bh=blfg8H0vQDEIiKZG114KkRTO8ohZwcp2UxFBIlsowf4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QSKGtgxNSi74N4abSAj/vNdi5BzUs0Lx15CG+UIlzWTi9gYZ2ixU0k3WrTUGorQmgRJviSl68+i5zRNcezejD3W3S6lqqmsg15Hl35eHe8vJtqwcDRzpz4DN4ayuwh8qMeof8Fxo3eUA2dH2k3Kymc0UTplyCqcG7j8YidWgumg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VzKZrRie; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4UxWy+3k9CaRJoIXC0To7sQrhuqgVK6vNliw/zEbmwR7+csN9mrdCRfi6XxdWF8kpHv/eErdJ4p0gxEBvmrkNef/CWoV0BiFtOhHmKcPF3KzrcnwYCzftcBawY2SdtZL0xRDXsgYOFhIFsgfpnik/UT6QeIZKe/27EbV9bw99TGMmNahEtX+EHkS/urmlIi1JkxBCePq8vHw9/+bGjiht+MIqOWOi3dXag5o0Ai0Ckcrr/nOI9dxSKAM7fuYS5PViFHezvD9e3oMi50mGaB82hDey7KdmR7C6KZmHaB9N/Zqx8CeiS3W0Ws/8vSvzuioPfL1M7TyS0BDUgBYMk/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1TxbHc0UIEtofbHZQ2s1Kpqiwu9cm/FuTDAL9nsoQ8=;
 b=eKuMvBs2fEtgTINREJXUifHfIk1NX84syk6s1Gl6vO9g6cvsEl38B0+MOuXdJl7qk4lPJdqWsZ3Sq6rEkXYnljEBc78dIohlBtqr6SDSSQTxBd5NJaAbdZWyBWmwGlvM8010vBrnRGfkLdO9umx5GqVmel7Zu5Dkfb8gDQPeKxDsUEdDfdD/whERlS4MKTbXwzvHNX+VOgpWvoSGH2ZVQd+mjxPe5s47arQ+pknpYW2Htd9XOjBMwnnTkIv+6YEIrAntP/c8y4LDs99hgjZ/vtQul7UdaJ2Nxhtwwi1KugL4hZSUq2T6BeIv/jsIS0277/wenFPJqUvjOx5pWMMD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1TxbHc0UIEtofbHZQ2s1Kpqiwu9cm/FuTDAL9nsoQ8=;
 b=VzKZrRieLZn/O+lXNZK+8SyGSvPqEhcV4ot8/+xNnj0nx02t6TqVsS09GcbruP5CZ6iFqoXmRGynJx2l7+ltLcKzyg3/X6OamRQiAH+TUrgbX75NB7O3+0a9EDznkdTAkyurmJDg+LFpSChJ5EN/8xNJhIlUm8CaMvVnoKSbzZwznTwujR01vzDxXoZPPSJElGE974zSfsAwithvl3KL+JmrxhFV1Mmi8cq+a+AfirV6C+kQBlDsA00/iiKiJuwWeZlzpc8XQd7m43ktqJxRXp6Eqv/9JKl6IEYE7p8fPLUIt7ghmOyzkVeZPmHWMHZ5ndPceuT6tWGZ2f9SeNGnpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by GVXPR04MB10325.eurprd04.prod.outlook.com (2603:10a6:150:1e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 12:49:43 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1%7]) with mapi id 15.20.8445.011; Fri, 14 Feb 2025
 12:49:42 +0000
Message-ID: <56ad5caa-3f31-70a8-0c27-2a6d22ff1306@nxp.com>
Date: Fri, 14 Feb 2025 14:49:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/2] ASoC: imx-card: support playback or capture only
To: Shengjiu Wang <shengjiu.wang@nxp.com>, shengjiu.wang@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
References: <20250214070533.2808496-1-shengjiu.wang@nxp.com>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20250214070533.2808496-1-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::22) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|GVXPR04MB10325:EE_
X-MS-Office365-Filtering-Correlation-Id: f9991c2b-d758-4057-8ac8-08dd4cf60d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzhZOWhrKzZyVHlycWR4M1hYK0dFUUFwZU9JbzRCaVFWVkVZSk9zNnZDVjdC?=
 =?utf-8?B?U1JkWGE3WVFLNXZHUkRIMERocXU1VFVUN05tYlNaS3YyWm9qMEQ3MmZFdUxM?=
 =?utf-8?B?L2RReWRKQWw5bFVBZFcxOWRSd3VOcW1qWXV5YlVGL3R6c0VqUzN0WGZWU2Nu?=
 =?utf-8?B?cmVScFJLUCt6aEx6SUMzeW5MSkttZmZ5REM5SFlDNHNMai9KVTlnNyt0S2RN?=
 =?utf-8?B?RlVjRG5RcjNvK1M1YnpjNlpnQ0g2bGJmd0ZTVXM5aWZOUUVjVFhrRnlPVkds?=
 =?utf-8?B?cS9GZVBHQmc5ZHE0N0FUTjZMalN5aWJPbXlvaEVKZXY4MTd6RzROL0N4UnNK?=
 =?utf-8?B?QjhScjcvNmZHMnh4SlkxMUc3dTFWdW9udDJiTVZxeW5uM0VPbDFsYmJEM1Y4?=
 =?utf-8?B?aitoMFU3YnVjQ3NacU1jd1NpalZhUi8yRFdvYy9MYWl6S0lYelRJcUJaL3Y3?=
 =?utf-8?B?MWFSUW5Qei9zY2dkOGFpOWxQZTFud0dVa3BSZi93ZVhySkdDdnRzdnZndXJE?=
 =?utf-8?B?MHFzQnBoOWxaQWExRk1kazhBM001Ujl4bXNGUEIxOGxzR3pualNQMWRLU1gx?=
 =?utf-8?B?eVZhTXNHcml2TnZrYlczQXN6TFp1TFFIOUY5YTRYamNuM1ZDK25lcisvOWNQ?=
 =?utf-8?B?LzFqSlpoZ1JOdVlibDY4anJuVmd5VzlzdGV2ekRWNnozUEozdUpzUzMwMDlS?=
 =?utf-8?B?K3h0TjZCcTREVk9KbGFqR1c0eXlYei9zdVN5a2orbFNHUitldE1yWFljOFQw?=
 =?utf-8?B?RytuaGplQncwdmtBamwwbnpmbGhoVFFZRmdsVVRQblZ0SzVVR2FCNFRMNVpZ?=
 =?utf-8?B?WXo0WDRNNWxhRk55cmJGc2s2MllHYmJ2WFRZNXRTdzlwd2RSTEM3eVRVdlZY?=
 =?utf-8?B?RHZuNWlsQjQrYTRVOFd1bjJwekJqalJlM3dOVDQxdmphN0E5ZUhtRk90czNR?=
 =?utf-8?B?VlA5VHdtUnlWSkx3ZERteWo2UEhRSGRoUk1CbXBBbHg2YjVETHgxNDV5aXdh?=
 =?utf-8?B?ZDJVUGFlM2pjSWt2ZXNnN0VTQUNQRk5uL1ZTbnErTzRkSWYzeTg3NWFJc0pu?=
 =?utf-8?B?a2xXTFBkYmthVHA5WVFEM3U2aWY0K05FallkcGFjdmNqVkE0QTRJaTR0Zm94?=
 =?utf-8?B?OXlHL292UVlsa0FHTnVoVmszS1FTUXpCZjQ1SmFla1RoRitlVGxJRDg1Nkph?=
 =?utf-8?B?Skl1eUYrbVBheEUyZWx4RmxZaWN3aGdpdHg3eDgxRW5BazVCU1Nta0VHSmZL?=
 =?utf-8?B?ZjJ5NzJSWEZlWUlDYTFJOFVxR3lWM2lqMjlteEt5QW9PVmxKTU1YODVOODhZ?=
 =?utf-8?B?R3IzNGl5TG5FSDBYbklHckZUcEgydzJGV0ozTUJqN2Q0UjZ0eHcxdE53RzFF?=
 =?utf-8?B?WUpKMFBKUDE5aXBLUU1kVEJUN3FIS0phdHBmT2p3d2JtelVjUHF6WWt1bE5Y?=
 =?utf-8?B?cHloZldEeVJqcEdMb1Z1VmVIUUpGTVZZZUhLMVJVTUVOQUNDZm80TTNYN09Z?=
 =?utf-8?B?SDV4cGRYaCtmb3JtMllBUlB1MkpRQlVDQmNQWmt4dU45KzhQQ3dQWVl0RmFs?=
 =?utf-8?B?VUw0YTZnbDlMOTZOVTZzTjdobWNqUXpSZjBualZLVWZzWS8zaHpZbVBXTVpI?=
 =?utf-8?B?L1NZZWJCREd1NmhuOC9ZTTZnSWVVV2lGUUVtZjMreGpyZFNBKzhuclc4YWN3?=
 =?utf-8?B?TTZCUmRxWHpOOHZPWUI3Tm1TSGppTzJraDdCY29NaXlYYU8vSDhabWFyM3gv?=
 =?utf-8?B?MEFjK3FyY1Qwc0lhM1ExVlh1eEVScHBMM3BEZ1hGYmJuL1lUMlVxb1JpMmZW?=
 =?utf-8?B?Q0dwUHdZWkpPWmJ6ZDV1OXB1cC9GS2FsNDFEOG1OeVNEdndhZHluS1VzVTIy?=
 =?utf-8?B?ait3K0FRVENQQXYzRWc4YlRKVEpWUVp0RkoyMlErQ3hwU0xUMWRVVnNiL3hW?=
 =?utf-8?Q?dcVKW0+5LU0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWpLOEFzVVhsSlFnbWh5aEVvQUNmTG9GL2QrL05nclJQWkVYOTNaY1N1amhs?=
 =?utf-8?B?aUE1bWJWYmtJNHN5ZUhOeGtMZjZWeDlWK1NBcEJaODQ1K2doclg1dGpZT1JZ?=
 =?utf-8?B?WHJDdFAyZUxiMHNveXA0eVAvdkVOS1IyT2drSm1takJwTVpuaW1xQjRjN2p2?=
 =?utf-8?B?TlhGUkVTTFBmcHBzK1JITG5PbDhBM2haYWs1MmJJMFZRTGNvbUxwQ2xnaUZE?=
 =?utf-8?B?TlBwMzVVN1ZHNHcva21tdGJteTFYR0hidnZLUlZkSFVmNEVSQlRaQTRETUpP?=
 =?utf-8?B?WlJlTWZMenN3L0tveHFXVzlxR00zWlhPaFJLTXhZK0NYZmpSanhaLzJnTnZI?=
 =?utf-8?B?bGpqSjVOK1kvLzR1YVNnS3VUL2xJendVVWd0ZFgzT0NVaDJ6TVlTQUhiRjhY?=
 =?utf-8?B?VkE2YTJZdG5BSWZGcmg2aldIUlppREJldzVVZ25RNXBSNUZMcWxhV0tNSTky?=
 =?utf-8?B?OVlsZnZZYXd6eTVORUF0cXVBQkNURGdRS2M1V3pJZHk5djNCaHJycmtSbWEr?=
 =?utf-8?B?RVN1cWkxK21FcWhSUTV2SXZNNUFOdSt2VTRQWEdmaUlkQVpIK1NZUkFWSTVO?=
 =?utf-8?B?UVkxNnQ4Z29FRDREL21kWElBaE0yelhHN1FUQlhDaGtyNzI3ZjN2QitFRUc3?=
 =?utf-8?B?Sloxa1NINm5lTnNIdENYL1Bjd3FrQ2Fmc1hydkFJWFVtSWFva0F1aTNFSW1o?=
 =?utf-8?B?YXIwSnM3N21ZZytuRE54K1NRNldDOEpaNnc1d0d1M2Rwb1FpTWxhS2R0T0xj?=
 =?utf-8?B?dmpuSTlrNUUxNnZuRzhCR0ZmZVFKL1BDR2pvYXAvdWM0VXRGR3ZCUlovbTRl?=
 =?utf-8?B?L1Zjb3o5eE5ZRmg2YlNLTGpRRVZZUFBQeWk3VFVjMTUrbGR3dTFOTzFWSGhw?=
 =?utf-8?B?ZHM5L01ralQ1OWlEKzBqdlJKYUJtSGxENlI5S1R0aHB6bTFMUEhIc3dmb0s5?=
 =?utf-8?B?S05FelRTOHlmOUVJVWpIVzg3cjl0amNCaEVDSWpZZnNyNzJaSnhubm12Ykw2?=
 =?utf-8?B?UHRBbVJqSVVDa2ZaUGZyTUZCYm5DY0R2amFlZklXTnJqU2FRN1VwSFVTZDJU?=
 =?utf-8?B?RDBmWmxTaVFLS1YvSGdjZ0dYV0ZIemRDYkdzanB2UjJIMHI0eTk3R3hVSnlX?=
 =?utf-8?B?QnVqblE2THROSUJHdDl6T2YvTGJTK29BbTRqOGhwY2dkK09SUXJYbEFiM2NR?=
 =?utf-8?B?VUU4Y21HMXpWdDZHaEdNeWpFZHBlSDhyR3FxUFZsZnJlOVZvR1J4WVZ2LzV6?=
 =?utf-8?B?aWwzeWFlU3psMUZHWnBjcjdDVW5zZmwrLzdmZDdNR0gvbmlITWxUb3FOSzhj?=
 =?utf-8?B?TVN6ZytUcUI5MVlpSW9WNGJTODBvbWNBclhpU0tHaytPRVk1dzJyQW1JTVVY?=
 =?utf-8?B?aEwyeEZCaHJyTXVsbWRIU1NyRXBBSEUrWEVPT3lXbGlYaHhubEQvMFVibkdw?=
 =?utf-8?B?UnlqTnJzWHBNWDVkUCtYMk1qVTB1T2pUUHZ6UVFiV0hjaHZUMGJLMGQ1RERv?=
 =?utf-8?B?RFZsaW1CY0VjM0lXejR6Q3huM0V6SGFUcEoxV2o1dFVwNUxmTHlXVC9wUXdB?=
 =?utf-8?B?RUN4NlJVcnR1Ym85UkorZ3ZKVnJYTU1xbUYyUllDQ2E3RDA1dTBnZ2Z1eTNz?=
 =?utf-8?B?RWdTTjRTOU44bmhwaXpTUkFVYi8zZ3lNTU5kZ1dzaHVndDZZS0RXUC9lbFg5?=
 =?utf-8?B?NHRWVTBKOGtqc29oUGtOZnpqQVFYcUR5VVpRdk13L0dOQ0MwZFJ6WDNlUUhl?=
 =?utf-8?B?RlRpaFdJMXdMemxMeElHaXpETHZBYStIUXZ5RUh3OVk0UEJNMk83REVNT3Q2?=
 =?utf-8?B?QkxXQmNqRURPUC9VRStGVDZjRFdUQW4veEVpUnB1T1V1eDZxaDRwT0c0dXNa?=
 =?utf-8?B?OStyVFlkWU4zVW9yTE85YWNGbTh2TFpTRnpCbkhGZktCb2NVWG9DaUJOSnlv?=
 =?utf-8?B?OGxEeCtWZ3hzSmg1TXlidjBtL21DR1JBZEZyR0l0NlJKcDREZ1IvTG5NeFBM?=
 =?utf-8?B?WWh1R3FSbWcyVnUzUlROeUxUdUVoM3RXWTlOVkM4aHltODR6NHowNEEwQkhQ?=
 =?utf-8?B?UW1XamhpNkdqN1BZUjQwVTVvdkt3SGlWYVlURVE2em8xOWRJVjJweFR6TGFa?=
 =?utf-8?B?L2hCZFo0dmwvVjlYSlAwWnlYM2Y1NG95RGtGWklFTVZSZWp0NzZSeHNwZ2JG?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9991c2b-d758-4057-8ac8-08dd4cf60d5a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 12:49:42.8123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enhRn9hXkAcVz8JqbhGsEZqZxadlI/lZn6HF4xYkeQCARFo/VurWjFtGi+74baIh04AQD9u9q/RXTRggtojmZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10325

On 2/14/2025 9:05 AM, Shengjiu Wang wrote:
> Be similar to audio graph card, support playback or capture only for
> imx-audio-card.
>
> imx-card can't directly refer to audio-graph-port.yaml, because it is
> not based on 'ports'. Add playback-only and capture-only property
> directly
>
> changes in v2:
> - wrap at 75 chars for commit messages
>
> Shengjiu Wang (2):
>    ASoC: dt-bindings: imx-card: Add playback-only and capture-only
>      property
>    ASoC: imx-card: Add playback_only or capture_only support
>
>   .../devicetree/bindings/sound/imx-audio-card.yaml         | 8 ++++++++
>   sound/soc/fsl/imx-card.c                                  | 5 +++++
>   2 files changed, 13 insertions(+)

For the series:

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia

