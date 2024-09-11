Return-Path: <linux-kernel+bounces-324309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365B974AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8D0288EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EFB137C37;
	Wed, 11 Sep 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="Ac20gMpR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2133.outbound.protection.outlook.com [40.107.22.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411E26AF3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038441; cv=fail; b=lYimuwuanSIx+qsWL8wouVmXXNoNOKxI6wyCsXJlUlbOtQSAMf0UJkw2vPNh5EfkmsI+GAofvfmP65NMzk/6efU7ef70M1BxD/KcShL7DCuaatFP+XLCulWwhXPN1TSmT69r4ASxcw/Xc+9Y+HwjIPiCvi2l/qW1N0rPHPRn/80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038441; c=relaxed/simple;
	bh=D9TQpQHyNSMBNUWP5QjciDU3As0z2Mn4eVmzhsy804o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m6WS2o8E7mj5Xqp5DQsmLaAKilcTzCMZC5qNmaeg2zMyuGcLye51hhASXKJMXaAgK3/7bZBfMafgI1N0geb8neRirwtYe29hMpIq1B67mVHaZkyc4jAytJ4v3nKLK3cvScoL+J4mUWo7h1jbp+l9rO5wte4FxFjf8oFy/65nRI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=Ac20gMpR; arc=fail smtp.client-ip=40.107.22.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag0oD1A6on10beb4fuu4vF1NQJHSOttJHc22LaYqcX7oGqEFJxKSnxwE9LzzuM/6hyYykjhcNgjbP6mLtYjITyTOq09yImW9glbsK9ip7Fmhb9CLa5S7jo9dr09dQMvcjIOeuTKiP5BfiuADwjLi9sutMWVlbAiChEM+yQYQA6RPs6wLIkAMq2QfY6GPHoBS/SI2ifFPxWcDgSRL6CABgYkmmHzwZIabXDZ+RAcen3P/bN43DLGRBcgLgRqw2hTCA2YU7Dw9Su+TltyS0SzjT66gd9GQZ209bq+IaH/p5/y/+VSIjzWTWmAPozl+i/gE0BbRN+A0KhCChInUCRCnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO6H6pbjt3BF+zv0QYr7fphurQT4aIY9uPX2+YzBsM0=;
 b=obpur3Bp8yyXRaz8BB5kvu8dfJ3fzwj051wNTrTpK0UQXOpNCDUirckVq0YYuc6ZmmmA7AI2bvxg292pZ+13pIy1EGLOZkqgSBAgJTPaackYjYJ95GMIWqwh+OAptg1UhGvgpwJ1nAOTaFIe3h3Sb3U4eEzuYZYm7PUpmwxMJlFS2eMPySxYFXenPlVZpWifkN8RcB8qjHfgmKKc6X+jbYKW87KVcLVSIl34XQbb60cRT2r1I6yapkPUaaB7jxLnMuvRDGdWFS2W7SpEzCtt+IhDac+NC4MbdqCXNW+55+T4vvxxlhqD2s8w9kwOoRu3elvEaT8+Q1pQg3sC7N4KEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO6H6pbjt3BF+zv0QYr7fphurQT4aIY9uPX2+YzBsM0=;
 b=Ac20gMpRvBgJkuiBdLq9bxNsefwfTrT2kM13yqAGKIqTGsaAo+qvbkUJ4KRMF95ojdpolUa2w/GSQ8SzWD44PPvQYUpKRJIGPZ4l0vdAv2DPO0dStWJetxCWFZoJ61JlIz47zJRA7mZ/QHLeG2+tBTnwEU7eDm5qRh5PlS3Obmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PAWPR10MB7391.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Wed, 11 Sep
 2024 07:07:16 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 07:07:16 +0000
Message-ID: <f2c8b5de-5a51-4b03-8809-d396e99584f6@kontron.de>
Date: Wed, 11 Sep 2024 09:07:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240911012838.944630-1-aford173@gmail.com>
 <20240911012838.944630-5-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240911012838.944630-5-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PAWPR10MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e50d8b-bd90-4591-2a64-08dcd2305e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDNmQjNRcXlBQmw4bStNcTVJOXNHRytqckZRY1BUcDZESUZNR2hxcGV5bTJX?=
 =?utf-8?B?elN0TXJKWXYreUExTkYxMjJ0d1U0and4T1FMMmY0M09ZaUFReVVWZWdSN09S?=
 =?utf-8?B?bU42dmUyaHUwOGxTcFBSYmJ3Y2gvcmxBYVBKSGVSVXkreUNrT1pzMmNRR1Zx?=
 =?utf-8?B?UDFibmlheUZ4V1JQSGdpOGNMRUp1RGZmY3NpU2VSL2l4ODdSWjlmMlM4Q1dm?=
 =?utf-8?B?dkltRUlCWlNLMlM3WXZXdmpxeVBiVHBvdEkwalY5YmFWRjdvSE1EMVJwZEJN?=
 =?utf-8?B?ODJPQnBTSnZLa0pTMjBlRHBkSEJzK2hrK093ZWl2eVRiT0hFSFR3d2tXN1Fn?=
 =?utf-8?B?dGpGbjNta0dYQS9uZHNwNE96RVdKeFdaemRYUXAySXFjb0xGRTRmS2ROb3M1?=
 =?utf-8?B?cmhzeGFBdVdkUmxSallaOTM4S0NYZnJGK0NTTWFNSUhxdzcxSHJHWm54c3NX?=
 =?utf-8?B?YkVDQVdjNU5DY2JUa1RqMUc1Z2lvTHUralM5L003cGJvNHQ4WjBHM09jajFo?=
 =?utf-8?B?ZThhMzRIcmdnd2ZZd3ZCSk0rQUc3b2VGZGhlV3cxTlhTenpSOWo0K05xV0NG?=
 =?utf-8?B?TmxiNEZ1VWxjOTdXUkxpUmxYK2VjTUVjc0NrMkRJb0ZaeXE2TTFLdGFaVzFi?=
 =?utf-8?B?RGl5MUc1VUlBdnJUTk5VbFZiZllLVjU3WUdSL1A2eWl5b0ltRWppOVpYTkF5?=
 =?utf-8?B?bWc1cHYxcFVUM1lmSWkzN25wcjJuQkVyTEdtY1JFM0hER1kvVHhPbFA0WDNw?=
 =?utf-8?B?ZW50ZllnVHVzaURmYnNtdzdTUXlTc0E1MllUOFVUNXRXdTZmTjh2c090bHdK?=
 =?utf-8?B?dmNMSXVqcmhMcWw1RDNjS1RkQ1JiNFgzWHEza0c0Um9QaHd1TWlncVdwZ0l4?=
 =?utf-8?B?TDBKNW51NFV3bXVDZ0hUcnZnVnIySFkreVF0SFRNcHA4YTF1emxteVR1K3dM?=
 =?utf-8?B?TTc3Rks1bkJzYUU4aXE1WWp4STJnSFllaGZDU2VjcnNBN0FLelNMRFBXSjgy?=
 =?utf-8?B?U1V3Tmd6VW9BamJ3L2Z6R2hweGpVT3pXTDBrc2VzeUhwK2ZLLzhSUGErOXgz?=
 =?utf-8?B?V2tWbFJXTmVab1N1QjZlLzJRandlV3p6S3FEU0tUVU1abk1CNUlKNG9odGRB?=
 =?utf-8?B?OGpkSjJxYjdodURrZW9CdjhDaGFoOUNzVTNQVjdhWFVTTUNkUWxnMUhRY0s3?=
 =?utf-8?B?MmFMVkkzUmFUcHJhWVc1MTZ3M21jK3NFQUh4RjRhNzBnaGJpVWF2djQvVFpS?=
 =?utf-8?B?QU5IQkU0S2hGZFd4ODdlUnRGMFEwMTJrQkVVR09IdjZqR0dDM0Q0ZmJJNW1a?=
 =?utf-8?B?Y0huRVl3eFRkUWZvU1llN2tBT2tJVGJrMmFuSi82MUF3YzFZb3RnN1duelVx?=
 =?utf-8?B?VTBnL25GcS9XdVN5b2RVRkVRbUFhTWc3MmtMbms4TG0xQ2ROZ2pKSG9RaDhm?=
 =?utf-8?B?c3o3ZlJvNUloQ21Pb1cyMFZ1VXVVa3hOVlhWaTgvOEoxZWFKdXJXZGVFeW1V?=
 =?utf-8?B?Q0dKcFRMZUJXditsSVlEdmNoT3pubkljcGpMUkhBMWduMU90Q2FZRjNhMEJR?=
 =?utf-8?B?TitBNFdFSi9RUm9HY1UxRi8zaytzSjlsZ2ZqTzJYMWp3a2s4V1o0RkVHNlkr?=
 =?utf-8?B?UVo0NlhTYzB3VlVoVnJkY0Z5UXVFYUV3YU9oVG9DK29SQ3lmVW5CUVd3Tlll?=
 =?utf-8?B?U3VEOTFsVjVzMjdPVVlGTW1zcHZYTDM5S2tlU2Z2dkZWYjNrY1hBb3F4bHJM?=
 =?utf-8?B?K1ZnZTlTelZDVjhUakRFVmNtSzBDQWdRYVQ1TVdYTHVsWHcyV2RrOTAyd29z?=
 =?utf-8?B?RUZEQnljMi9CZTBqcG1Gdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzhpWVlLQ0JFTzNPSkliNy9JMFN5SHh3bzEyeUd6My9nSk9oSVhnZ3Z3Ymo3?=
 =?utf-8?B?T0VoRGJKMmNoRUFFK3VYdUxYc1R3ZmdkWjVjWmtJcUFISHNpOWpvVXE0WS94?=
 =?utf-8?B?RFA0NDFDc1VRclVKTDNHOHRtRWVzSGtQY0wwS3crQUhjT1UycUc2ci9sWHlB?=
 =?utf-8?B?d3NIc0FQWmFEVHZFNlJWTWVjVFlMR1dBOGc5ZWt2b2pqWmpLK2NYdVJwR0Q5?=
 =?utf-8?B?WWdxbCtEQnJueU85Z0hUYUI2RW1mL2NEZnJXeXZ3NGRFODFMS1BlcXlFZjBC?=
 =?utf-8?B?OS9HTGZvTXBIK2lsVFJYcmN0R0U1K3BIVEVPTkVCV3ZMTTNRWlVCS1o3ZDNr?=
 =?utf-8?B?MHZ6TExLSlJmNWQxSXQzM1gwYXFIUjNYci9NeWJUZUptR09kUHV0OHNHTGUx?=
 =?utf-8?B?QWlOOXF2M2ZtakN0TW80L0dDZ29pSHNvTHpyL2REN2pES2ZQVjhSaithUlR2?=
 =?utf-8?B?Q0YwQm9jM3MxNHRobzdtOEVlWCtsaGZDVnI5Zk1zclVKOFdGVFVsWFBGNE4x?=
 =?utf-8?B?Ym9jbzVkUmV1S2RCRStwZGNXOXF6Ymw1NW5WUkpuUWt3MTJrSTRrWXNhK2R6?=
 =?utf-8?B?VGs0VHRqNjc4RCtkaG9kNmZzcDk1R0dmdGcwUE9HOStnRGtERDBkSXYyb28y?=
 =?utf-8?B?TDlQZ2pBaGo1Q1JvN1RCT3VPSml6QVRFT2lMWlFNQkYzZ1BzaU5IOVFqZ0RU?=
 =?utf-8?B?clFTQ3lHRzhSclJHR1JQNGNVK0VZRXJLS3JNY2dzQm9qYWhiVjc5dEEvcEEy?=
 =?utf-8?B?c1huQUVjVXIrY09tQmNIR1l6RzZmSTVGUVFTd29WN1ZDUkJaNWJlN2xpVWdu?=
 =?utf-8?B?V3BlcWRWRXVRY0Y3bUR3OVFTVDNscHVMR2NJT3hkRk1JZFhGa2R3M2RXdVA2?=
 =?utf-8?B?UkZiWHVSL1VaNTFOQmtrVyttQUd4RVVwRGdLb0k1UHFBL2xiR2ExY0JHdEpP?=
 =?utf-8?B?bHhsSHpTbmRyOWlvRWU0am5Vb2JHQnF5Tmo3MjA4U21KM2dnWDRWR1ZKaVBz?=
 =?utf-8?B?VHMxbVo4Y1dCY0N6MDZ2RzFRRFEvWWpIZXY3aFc3bldQNmZnN0FxQlpPVmpp?=
 =?utf-8?B?ajBEc2ZHUWN6aTZ6OFJPWnVITy9JTjNJK2U4VEtrVmRoTGFsYkpoVElUWGJN?=
 =?utf-8?B?eHZpMHhROGlUTzI3TDJTaGZlUXE3SC9VdC9DZDlDcXIrWEFTczk3bUJHTzlL?=
 =?utf-8?B?NHg4V3hoNjkxbk9EVVd0djM1TG9NYzN6QS93eWNneS9pT2Izck9uWUpBRmFE?=
 =?utf-8?B?R1ZyWlFtd3h3K2tSK1FZUndCZjFtK0M5Y2xxc0xuUk1DQ3oyak9iakQvSUNT?=
 =?utf-8?B?N3FTcHB2MFhNVXNQMHdvOHp0NnR0N1NUc1NXWVd3cjNoQzhvY0RjY3V1Z01s?=
 =?utf-8?B?VUNEZUd1d0tYQzB0NTh2Z1BpSXFZUEhVYmtJSjAvaG1BY3I3aFU5Y090SkFG?=
 =?utf-8?B?MHk1SkJwekhBMVhiOW1Dd0lVOUoxcVhKSmVuVWVCUm50cHVHcElLNWFQcVB2?=
 =?utf-8?B?OTBaQU1Ga3RCTG5idzRwY2pPbHNhbE9BWmNRSWNxT1BOK1hQUVBkRnViV3RO?=
 =?utf-8?B?UU9aKzJHaDBvRnpnQm84V2ZNZldhY2JNNktVdjZ6dG9VcTRsdkdrdk9OanE0?=
 =?utf-8?B?UGZWN3EvOW1RaGt3dTlCT1RmdVVtWDd0V2hSeEQwYTBOcjVRMDFqa0F1aWZq?=
 =?utf-8?B?VTEvZ1JUWEdHbkhHMEcrcjI3bUZVWlNheXFpUEp5bndBMjZrMjl4bFpETXFI?=
 =?utf-8?B?SkE5ekhjdVl6YUswdE1SWDVyL0I3WmFMTU45UmJHT0daR0lONGxpczJnSjNL?=
 =?utf-8?B?clVqd2JEYWJOalZ0aDB6R0ZDZERRdjRzcUg2WXoreERwdGZDc0g0UXpnc1ZP?=
 =?utf-8?B?RklXNDA2OEtndy90dDhlMXdwSnVRbUxGQ1hQOVhZSjNGSVV1dFZGM3AwY1Vs?=
 =?utf-8?B?d3MyMXdsVnh5dEtldFJBcFNXR3BHSUpueThnZDlnc2doMU54RFFFZUlsQktv?=
 =?utf-8?B?TUJ5cUhvUGNrSTdaMjRJejNJck50MXJ5OXI2djRhbkxBTkxYSS9vVmQxQ0p5?=
 =?utf-8?B?RG1PZHAwMVJFZXZlVm5SaWh3YXZEWWlRL25UZ3NJUkFmalJ1MmR2Q3VwUVR2?=
 =?utf-8?B?TlZBRUFYN0lFcGxmcE1oa20wTnhQNEYyanlpMDlKejAycjBNWit6K3c2c1U0?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e50d8b-bd90-4591-2a64-08dcd2305e34
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:07:16.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgHhS5AFcoFGLf33PPW0CO9XljJo5phYNwY8zlPuac4kY01BUfbr4seykedubfZjZdKmsAZE30/uW/0n8ktZGChscd8WvNSsIBuYyDc5GHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7391

On 11.09.24 3:28 AM, Adam Ford wrote:
> Currently, if the clock values cannot be set to the exact rate,
> the round_rate and set_rate functions use the closest value found in
> the look-up-table.  In preparation of removing values from the LUT
> that can be calculated evenly with the integer calculator, it's
> necessary to ensure to check both the look-up-table and the integer
> divider clock values to get the closest values to the requested
> value.  It does this by measuring the difference between the
> requested clock value and the closest value in both integer divider
> calucator and the fractional clock look-up-table.

  ^ calculator

> 
> Which ever has the smallest difference between them is returned as
> the closest rate.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V7:  Because of the previous patch refactoring, the flow of this patch
>      changed quite a bit to use more help functions and goto statements
>      to hopefully make the code flow better and improve comment
>      readability.  Because of the change, I removed s-o-b and r-b,
>      and t-b tags.
> 
> V6:  Simplify the calculation of the closest rate and fix
>      a situation where the integer divider values may not be properly
>      setup before they are used.
>      Fixup some comments
> V5:  No Change
> V4:  New to series
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 40 ++++++++++++++------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 49317a96f767..67a28aac9c45 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -577,6 +577,16 @@ static void fsl_samsung_hdmi_calculate_phy(struct phy_config *cal_phy, unsigned
>  	/* pll_div_regs 3-6 are fixed and pre-defined already */
>  }
>  
> +static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
> +						 u32 int_div_clk, u32 frac_div_clk)
> +{
> +	/* The int_div_clk may be greater than rate, so cast it and use ABS */
> +	if (abs((long)rate - (long)int_div_clk) < (rate - frac_div_clk))
> +		return int_div_clk;
> +
> +	return frac_div_clk;
> +}
> +
>  static long phy_clk_round_rate(struct clk_hw *hw,
>  			       unsigned long rate, unsigned long *parent_rate)
>  {
> @@ -624,27 +634,33 @@ static int phy_clk_set_rate(struct clk_hw *hw,
>  		goto use_fract_div;
>  
>  	/*
> -	 * If the rate from the fractional divder is not exact, check the integer divider,
> +	 * If the rate from the fractional divider is not exact, check the integer divider,
>  	 * and use it if that value is an exact match.
>  	 */
>  	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
> +	fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
>  	if (int_div_clk == rate) {
> -		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n",
> -				   int_div_clk);
> -
> -		fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
> -		phy->cur_cfg  = &calculated_phy_pll_cfg;
> -		return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
> +		goto use_int_div;
>  	}
>  
>  	/*
> -	 * If neither the fractional divder nor the integer divder can find an exact value
> -	 * fall back to using the fractional divider
> +	 * Compare the difference between the integer clock and the fractional clock against
> +	 * the desired clock and which whichever is closest,
>  	 */
> +	if (fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
> +						  fract_div_phy->pixclk) == fract_div_phy->pixclk)
> +		goto use_fract_div;
> +
> +use_int_div:
> +	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n", int_div_clk);
> +	phy->cur_cfg  = &calculated_phy_pll_cfg;
> +	goto end;

You are jumping into this part of the code and then back out again to
the end of the function. In my opinion this is beyond what is generally
considered "good" use of goto. It makes the code hard to read.

Can we rewrite/rearrange this to avoid goto in this function? Just
creating additional functions as necessary and calling them in the right
places should do the job without having duplicated code, no?

> +
>  use_fract_div:
> -	phy->cur_cfg = fract_div_phy;
> -	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider rate = %u\n",
> -			   phy->cur_cfg->pixclk);
> +	 phy->cur_cfg = fract_div_phy;
> +	 dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider rate = %u\n",
> +		   phy->cur_cfg->pixclk);
> +end:
>  	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
>  }
>  

