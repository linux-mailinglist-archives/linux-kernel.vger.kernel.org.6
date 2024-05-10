Return-Path: <linux-kernel+bounces-175502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0428C207D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7251C21A78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815F6170887;
	Fri, 10 May 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JK6mW8TC"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89D170838;
	Fri, 10 May 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332326; cv=fail; b=jD+sX6iMcYcrTkiOvRyK13qoPLPktChejkL55Lv2sixlzDw/lPMlLJ4rO3IRbLJePNnnPQC/lRL5pnYsutOWWiQ7XiwQPX5W6RVpeXSATHA7j3wH66M2c2YU+hQyRyDv0vfBRGyAKzLp5LbhmkMHmJQfouaea9s5s1V9w+Mm498=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332326; c=relaxed/simple;
	bh=i6s2BDOKW6zn7tKgno8avPO6dvuo9b/4Fzr1Ewfft/o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j+bgFB3n8SXQwlnwIhTgPSEj+K93s97EZAwTSqySgJIygE+4ry1xNsDXwwgzokCro+XpEQui39JVszCp8fRSSYBmpt9rR+Rg6Wod+aot/L//zwbjJYqTz/88OotXLhFeGdEscKihkr1mn/CBhmSdC6LyaO216EsfHXrb4fz86Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JK6mW8TC; arc=fail smtp.client-ip=40.107.8.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aea/nlJXv9Rhn0E7LzG+bOrhIkNscZJs8PvwENVBPI3HMhg8f1KQLmZwXPBWV4xxce2Mgsni3SYAAGXf6rMDNUeG+/bDHZDPKrCSm3h539spPPW5SIEiSrKsS0GWnoRrv7MsbZG/+m9POF4wUAecBYbnabmckWSmPu2eNIIAo+fFcoAI7uiu+dKHS5TWAHGeL+LZKgz0G6HsX0eETQQ/r98O3nOGK5tXrrtqSDgXu3acYlqA3KihRJ1ng7CalMD9CVKsJ0GrtaHssP4vHjG9RTdk4hMjyLAhI1YyTqTrRjtCYr3WFvoVmEX/tkS9NxZQwbX42+SY2a40rOsHCLVXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QiLEK8YsyGhwnQqocYVdqygEuHwuHli5O/GR4Kb5nc=;
 b=SWsxR1aKd1q2hVcKp/+TyX0dW3+rCG6QLiuwcCJG4riz+XdsE6gaDCzPnmtAfLvmsP0PWFY7pF56WnHywLENcjTn0r9hJ+moP6L9MMQQkyjBG1fu3rexxcelEYQropVJJpRWNIjxfC3Qo7KfeU0LbvwWQvngkPFMszvw4cDMgEWfq1n0VSZ89Iu/PhEwHG63CTtADl8DILN+ahvNT0OpbBdivtVmwAmSKNYBtU0ylnuylHxnuLSPvlyA6fyzA4en+PrKZ834W+LrfDrgPd+aoEHeZROlfxY2uffhXYH2rglbCQaxW62gyj1KjIx2Etaye98KNowWxHs6WvjKm4B3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QiLEK8YsyGhwnQqocYVdqygEuHwuHli5O/GR4Kb5nc=;
 b=JK6mW8TC1PUD34lIwy5Cmqb5dEtzxY2FnWz2IUYB+q9X7ZVkvwlHWhWL3cbCtNmeSoThJOgqo11sPFUefmMk7tiYty6u6JIXcKWrOFFHyoTUYjSZm4Bms+lUwCjTcyAlQbujjFMsZZAnYuNEzBRk1a5rXShySPQDeYIrQ1ESHXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA1PR04MB10399.eurprd04.prod.outlook.com (2603:10a6:102:452::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 09:12:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:12:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:05 +0800
Subject: [PATCH v2 10/17] clk: imx: add CLK_SET_RATE_PARENT for
 lcdif_pixel_src for i.MX7D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-10-c998f315d29c@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
In-Reply-To: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1922;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=enKh4CGkqPk5jRnK8VpEttysezgL5JHxfHa9hFqdaL0=;
 b=5rtOgw3ew8w0xRRlALZ7v6gXXz1AflBdQp3JefC/mLry9sneIHjnjaecZa20XLh1X9bROBk7u
 sB5Ag7qeutpCG6M4gKj5fEJKcyrhmSVzYldY3tklb+qpYLni/wvdhKm
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA1PR04MB10399:EE_
X-MS-Office365-Filtering-Correlation-Id: ae59ecbb-9c1c-49c0-104d-08dc70d14037
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2dIWlI4TzlTQkJoSzZ5WTVsNVdMVG12Znp0YTg3cjF3TDR1QUl0R2xzaHlO?=
 =?utf-8?B?VGE1c2V3V1hlUUFjVnN3dUtZNHBrdU13OEZPNHExRHMyVm1mT2hTSk1rblhH?=
 =?utf-8?B?a0RFTjJ1MmlwQk8wTkYvU1FtdXMxU3M1aWVobVNtbjJSQzY1Zk9xMEN5amdt?=
 =?utf-8?B?TmNPbENuTEo4ckNTczFYS05NT3Q2ZHk1UkFFa0hvMnMzNGgybHRudUZWNG9Y?=
 =?utf-8?B?Z1NCK3ZBclg2Nnp1R0xJdnIxQ3RRdXFRazVGM3JKWDJCNkliejliTkRkL3kx?=
 =?utf-8?B?ZE9OWktrS3A1blNicXVkcUh5RnJHSFMzYXNac1pGMUhKblFveFBQYUdlMUdD?=
 =?utf-8?B?Wlh3RkY4UGNzaFQzaWRBNitZcXYyN25NendxL0RNQ0cxWHVPeTZEMmFkbXVE?=
 =?utf-8?B?M3FBeCtZT0pXbDJFdXFOK0ZVam02T2RWRGhUMzRKNjlxNkdIeDl1YTRnTlVL?=
 =?utf-8?B?UjJCaFVYVUpHUUErK0NCV2tISmxmK3pDZTE3WUNIT3ArRnR5emphWHRxeDJ0?=
 =?utf-8?B?dHZOSGgrK0hKVTk4NlVTU3hrYlJWeGJDbFFuQmFzMHp5UG82SEFsYmdyZVVG?=
 =?utf-8?B?TzdobllXcnlmRHQ5bUtUNlp3TzJTOU0zNmlmaUtqbWdPNWhxUG5IN25ESURS?=
 =?utf-8?B?TUdYOGI2RXIxSE00R2lyOWRPb2luNjFUT0ptUWRJZXNMME9WKzlzc2wzR2dW?=
 =?utf-8?B?M3hTWUh6VkJtb0Z1blJCZXB2NGhCd240NDZuZm4vQm1Bck9xM0R3SDAyQndZ?=
 =?utf-8?B?RnJrUjBoZHBIb1kzQUhxdU5FK005VC9nSFMra01JeFgyY3JQQTBiVTRzYWp1?=
 =?utf-8?B?dXJBelJENCtLRjg2dEpDRW9HYjBHY3ZidXIrc2RLQ3ArWVdUcGNlWjh2Z2l1?=
 =?utf-8?B?NjlJMFQ2ZzByU0pwUU5HUlpicXpwcUVaWTNqVlNIUXQrWFFxNStVdm1jSTdV?=
 =?utf-8?B?ZUZVNXNRamVGQktOOHU1UVRCdVB4L1JwQTBCbWgvV3EvakMwWjBGWEEzbFhU?=
 =?utf-8?B?NXRYWVZPbnFOSXNxMTU3T3Z1TFJYWktTOVVjeHl0UWtLZkVqMVVsMEZyWjd4?=
 =?utf-8?B?MXg1OGZScHlBZHV3aVhkMko1dkZ5aHdlZ1cvTVVVbkJRcklJa0w0L1YzNElW?=
 =?utf-8?B?Q3lZdDgydytuRXM3THFNTE92TnlZMkZmZVVYTUVXcWpsL2l0UDI1WHRYTnhr?=
 =?utf-8?B?bWZEYS9Nb0JVT3IwYm51QlYzN1NmSHJLNWNsZG1wRUVpRWphVlY5RktyK202?=
 =?utf-8?B?TWUvZkxUZXZ3eCs5eGVCd2lLVE94UlI4NXU2VkhENEpzTTczbmdyOVVvR0JL?=
 =?utf-8?B?aDUwbGtQeWVDVGNhRzJyUWJHcU5BMmFkUUV4VllMTWZFRjk1dFd5QUQ1RUIy?=
 =?utf-8?B?d3VsMjMzdWROQ1ZzMEVUM29EeDNrSStKV1hqeXBhTmV4ak96Q0RKZ0NlSkV6?=
 =?utf-8?B?eGQ0V3BUTUlGR3ppU0d5ZlpCVXZpenNJckRuK3hXRUtDWVM1S0JzdnZ6UmI0?=
 =?utf-8?B?OWlsNGRJWFZFeCsrZ1FIcnJEOEg3SzRvbElTSXBvTVd6V3p0Z0ZMOE8zMzhk?=
 =?utf-8?B?c0lMOFNNaTBLY0c0UnNyL0R3ZVZlQ1JWVWZJNG5jYnJYZWVGYzhaZFE4S1RX?=
 =?utf-8?B?M2lidFRVanFDdUd0THBrUCswUm9uVjQ1dVBqVTBTZGYrSlJYT201eUtKeTBT?=
 =?utf-8?B?Y3I4OGxmaDh4MFVIRFZSQXF1ZkM1dFRWTjFSK3p2Nk1ZRGpXcEpZc3NveEdR?=
 =?utf-8?B?RkFBbmFwd1F1M1g2M004RGFINlZaRjVSQ2lpdjhEY2tyYzU2MWhVTjhranky?=
 =?utf-8?Q?Dec9QZqEtFSxNckw5F6omxAUG7kiTqOSbMmSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3AwdnJBalJsWno4WUZDcGVEZ2xNZExBejY4cFBuWktLRENkaHBpU25hN3BZ?=
 =?utf-8?B?aTQxdDAwWXJYZzhiaFdLSzZJRjdPOGtHVmtNeEJXdTVacmF2OUtHclhTaCtC?=
 =?utf-8?B?eXFXUUY3SW5sdm9udnFpbjc1Mm5mNEVoZWVYSHd4WVB1KzBHdlRobm1rTWlD?=
 =?utf-8?B?VHFMc3pOTEVkSEx0OXN2cmtZUDFoOXJucHlqN240a1J6TTlwSmFvdWVhbXp2?=
 =?utf-8?B?K000RnY0c0gzeXl2VVR3SWRSbC94WTYybjV5N2grNlpYaHRlWHhTWGVaZERq?=
 =?utf-8?B?K0poUUpTTm9VcklMWHFXWG5jaVlNaFB5Q1MrOXlheG8rZCtFN212SDhhYUk5?=
 =?utf-8?B?MmRrQkViSzVoY3FPM2UvWm5rT3RUZHZDU0tHMFpQTTRRb2tzMnBsTGFaTXZT?=
 =?utf-8?B?bmxHd1d0NlBmSmhkOXZvM0E5TFp6OFA0NnV4RGs1WXNmL2VHR3o0Y1lRTmE4?=
 =?utf-8?B?QVZ1bWlNenAwMjdZRWRZUFBGZUZOOFM0WXFQeGpnOWg0cDF3QTRpZ0FxRlZX?=
 =?utf-8?B?eSt6L05qbE5DUnhMRHhsdzk4ZnJUVjRrUHlXbGNnbTIwUStxaGJiamlMMkg2?=
 =?utf-8?B?d2lrQmppTFN3NVNsRjk3NzVhejZWS2VPTFVUakYrdEZ4QUh3K2tTbVkrUEVQ?=
 =?utf-8?B?dXN2cU9kNlB1VjB2dkdWbG84VDFqbkZXN05HTUFrV3BDTmlvbGdSbS8vNVdV?=
 =?utf-8?B?RkdQeW1HUkkzYUFUYkFqZDVHd1ZGdnBYUGZoT1lVQ3ZSbzU3YktidmRWZnJD?=
 =?utf-8?B?REdEbTdHU3ljUUN5RkdoN0xSVWRBL2tLRmtvVENzUEtPNW94UEl0ZkhsK3lE?=
 =?utf-8?B?ckRzY1RCT3NrWlRDU0ZPOUkycEEzWXBSYS81ODRaOGtJdkg2WHN2UkxDeEdB?=
 =?utf-8?B?cGJZeHVkbHJiSFJ4ZjBwZUdXcG0yV1pQc2F5c1hhOVpOTGVNdDdDQzRJbHZt?=
 =?utf-8?B?dkJDWkx4ZkdCbVlYN1I0VUpzNjUyY3B6MUVkYVRZaHFLeDhZWURZZmt5U2kr?=
 =?utf-8?B?SlRvS2lNaDJFVnFrTStSNUpIL0lSQXBnRHBUb2NtSE9LRjF6RzRiMm9jZ0ZB?=
 =?utf-8?B?cFRoMmxIekJRVS9VTjFXSG03MFdCbE5zWS92ZEEyNWdUWThXVExUaVhWV0lW?=
 =?utf-8?B?WUlaSkJ3L1lnMUVaV0dYdVFSdXdBdjA0QnpOeFcwVXFMUVBFeXZYY0hoUWNL?=
 =?utf-8?B?S21XUEh0NHpyam5BSzFSZHRrQXMzT3F4eEV4cWM4eW5nS3R5WHRQK3lmRWoz?=
 =?utf-8?B?d2NXdElQWTlDNWFPM2FlOUdUZE1Gd3RoNTFyYXZka2tqZlFDa3lCTUV5SGhi?=
 =?utf-8?B?Z1R3M1Vra0hTcDVjdi9aK3UwTnNJY29EWmFCdUsxODBxam5kQXhiU2EwMVM1?=
 =?utf-8?B?RmplZ05DY0MvMWtDemI4YWFtQ0ZHZGlnY1dRbm5yT2Zoc095RTdaS2p2akl3?=
 =?utf-8?B?clVFa0JpNTY3M25qb09VbWNDZ3RtZW9XWTlBOHVvSG82M2Y1MFpTSkgwUDVw?=
 =?utf-8?B?clF3SEZXQWRoVEVZNmRTbkRlMkVYZXB6aE1oaGgxQW1uRDV6dmRlaEQ2blpp?=
 =?utf-8?B?elV5b3lCc0MzWnl1V29STjJDVnFSQVgyMlQ2RjlKeDlTc2pIaVFPY01BNXR0?=
 =?utf-8?B?K01NNFg0b2RXaU1xdWpwL2Qrc1FETncxQXZjUWZBd0hoc2t0amxTbVpFWTl1?=
 =?utf-8?B?aEZLWW1qQVFHeEtNVlkzcUFXcFRUakczNndHQldLaTl3bXRERGVpaGpibFhK?=
 =?utf-8?B?aXdCeHJBUjFNQ1hQWEo1V1pIWVRlUkwzak9sNk1WMTRVQUoyV21peGZHNWEz?=
 =?utf-8?B?QXhoQ1hacllyWjBIL3BGNWgxVG1sTTFBY1hkd2pBNEltOHZSYkhjaElFUlZp?=
 =?utf-8?B?N0NoNlNPeWtOdFFTNHh2cG51WG5mbHhWb3RJMDR3YjFScGsxL1JPbDVXTlNo?=
 =?utf-8?B?a0hiREgzbExSS0tKQXEwRlVoT0ZEWUZQRVZmYkRNdThDNVpqM2dBNDRhcU1D?=
 =?utf-8?B?RjJVNG9CT3lDMENubTdCM3g0eG1vbTkyWERRTjNtUkpCbTFkUUdZVElZSGFT?=
 =?utf-8?B?UVU3N3ZqcGFhTmpneTJLOWw3QXpKSDRSaFZxVjZoS2dGR29KOGd1dEdxYjg5?=
 =?utf-8?Q?2j1zIknPIWDwBMaMeeFDRjH7u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae59ecbb-9c1c-49c0-104d-08dc70d14037
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:12:00.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CED35cwXT96iDptGOksf07Klh/YiTXpOr0iwLv6x06mQcJPfcZrvhCcuS/3xpwj9yVI8Zc+KxqrSVERkDFx5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10399

From: Peng Fan <peng.fan@nxp.com>

Add flag 'CLK_SET_RATE_PARENT' to 'IMX7D_LCDIF_PIXEL_ROOT_SRC' to
propagate rate changes from LCDIF pixel clock to video PLL to
provide more accurate clock rate for LCDIF pixel clock.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 1e1296e74835..99adc55e3f5d 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -505,7 +505,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_EPDC_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("epdc_pixel_src", base + 0xa280, 24, 3, epdc_pixel_sel, ARRAY_SIZE(epdc_pixel_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel), CLK_SET_PARENT_GATE | CLK_SET_RATE_PARENT);
 	hws[IMX7D_MIPI_DSI_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_dsi_src", base + 0xa380, 24, 3,  mipi_dsi_sel, ARRAY_SIZE(mipi_dsi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_MIPI_CSI_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_csi_src", base + 0xa400, 24, 3, mipi_csi_sel, ARRAY_SIZE(mipi_csi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_MIPI_DPHY_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_dphy_src", base + 0xa480, 24, 3, mipi_dphy_sel, ARRAY_SIZE(mipi_dphy_sel), CLK_SET_PARENT_GATE);

-- 
2.37.1


