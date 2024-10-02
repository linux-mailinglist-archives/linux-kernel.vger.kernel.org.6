Return-Path: <linux-kernel+bounces-347738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0F898DDE3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DFE1F25C3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F49A1D14E7;
	Wed,  2 Oct 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bg5X0APm"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C11EA80
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880657; cv=fail; b=eX1AIbDJiB0tDli7+6uR29jVr1rdq/fDQnKA6xNjIE62gQOQ84Fs18xXLiQ2I70eAhBkJhCS92P0j44NzFFeoG601+On8xTlqDzPjkmfhDZBhCNWMt6Q0H1xwPuB7+ogaaYTdM8sxlGBtEW8W3psNOFWRH3tXLa5YzKbc0HlXlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880657; c=relaxed/simple;
	bh=0sQUkJwg764McOVMXQNewE9+U+ZyddcK0WVIVXKgVWE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=HB9yFT92QvSDPSDhhfGRS5pFAGfsWVN7+KhU5CL/NtMxVHRqoKUqVBf+FxSwjkNGN/y1xBsbnhqe86JV2GApBD/tbnKdndPVzoPTR9UPH2p0clJAyd03u3/dUF2cMLW3WCFTT+xLnxOrfbF4sgEhsF2VnCr9bE81Bs05X1gT/IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bg5X0APm; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5OQsz/FVVyEOF/Lm9Djyrmp+tAMGb7qz1lWJZecBOHv8udTDei0I5/TN3tmzFsWbFioxK7opO/fvxmbj2O2HM4FmX5cUjHiG1MWFfm4InPs/qv2+FlUcU/9ap4ZLU8YTYG7gQPGujd+rym3eG8OpJ1Y4u7mCuKQA4z65Wrt7Y7i9VqhRUNw9UszFhMUX/83ndbvKO2GWE60M1IvEXHMJIaMWPI/WkY7TvfnhemxoKQSD1GkRD/aUEBc1MPF0ldih7iagQ+/sfzl2yBijrotl0lJ5TyaaCcIwIJ2htCv4Q/A9L36W/P7W9KeaeSU+rF91uxfdxRhnfEqXyvgV/2zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDayDYfBFv5pbE9La5X79bAB7BYcyqlCImMG0eM57Cs=;
 b=rp/U8NarIlDh8aO8vsQ7stosOB85B8bj+LU92mJ/tAaQBVkb5cs/oBEVyuAYJLClqo2J3/a04xGoJ/C8b2HXeYJPH2Lj0qqVDpQlHYWpORJTUUF+GuEkHF2CjDff0F4wd4tfubq55EVDxqj2Qzp1bWeyCfQm6DaVlUr2+zmq1IiME13Ci2r5xMgxT7B6egBGYFHSzEajYvNJr0RZ+zva/CHg31fevE5basQwzHxvVBOvBc22hTDKtg+qKkYQ3sfACYyRiQFN+xz6EjQG6bLkoIh6PPevMIkSh2OMRRKdy5dWyVMwHLQPhaDYdmX9xoqxO46sgGI8c+vJ8SECr+FUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDayDYfBFv5pbE9La5X79bAB7BYcyqlCImMG0eM57Cs=;
 b=Bg5X0APmXDppd3wHGZlIL9X3uhr7utG8yDAtoYUaIjNOB/kvMOhuZ9YVHZtasA8pnaCtNVUFy0GskGNXePSxbBEDW9resljE+KQAiZIDa3+n6xbvf4EPRvPjJkoe3jcft1uvI+/pEQb6j30JoOrjEKBeKWbpz9DXXRl5hsHvXKdLKqSglRT5JltiAOODs+3u60Wc8mC/25ODpgpu5Q+qijYRx1ORzxd7yj0defX9MkgAlqYINUBLt3gpnZYaDJUy4mMefmmUKhrZtIKdlbNkpBnES2IuVJgkHqlsaaSJDpepavY0nc6KI38nXQ2O1MG8bXOYeFkawQer4d2FNDcmCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9699.eurprd04.prod.outlook.com (2603:10a6:20b:482::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 14:50:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 14:50:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/6] I3C: master: svc: collect all patches to improve
 hotjoin stability
Date: Wed, 02 Oct 2024 10:50:32 -0400
Message-Id: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALhd/WYC/23MQQ7CIBCF4as0s3YMrbRBV72H6QLoVMZEaMCQm
 oa7i127/F/yvh0SRaYEt2aHSJkTB19jODVgnfYPQp5rQyc62QrRYsoW+WLRPdEYbfSg7NKShnp
 YIy28Hdh9qu04vUP8HHbuf+tfJvcoUCqhjdI0K3kd/baebXjBVEr5AixI2qqiAAAA
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727880649; l=1398;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0sQUkJwg764McOVMXQNewE9+U+ZyddcK0WVIVXKgVWE=;
 b=0QftKsixa7pP52UNP2L7FxvDomMIULKt2UCdWJrmMEkqo7+ywFKKp5AGl35iKdTc526HkZtgN
 NxqFPZTWn6HC8LEbKM2h6Gsu+Ty0dKJP0q3yaXTyQDJ2hRe02UdLcHz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: ed365095-3be3-4b0e-a455-08dce2f19c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkhVT05zdEprQS9PeHVPd3RpbXM3aHhGNm8wZW81bE0zSVpoQWlNRHNRbVhj?=
 =?utf-8?B?YitwUkU5bGtIMEpHRzg5MkUyaElsOGxrc1NjNGJqRC9lYjk1REhoaDlET0g2?=
 =?utf-8?B?V0cxdjhPYnEyV3BSQmpPSmxPSTUwOWxZODRldlJpQ3ZpVmpEVmtmci9lWnkw?=
 =?utf-8?B?UWZlQkc3SXE2bTJYSDJ0RVJVb09La0FSVjBqLzhobUxUSDJCdWs2eVBSMk1V?=
 =?utf-8?B?cWJWWXV5RzhjOHhZL0llWlpFTTBjbGYxQ0o2VVg1SnNwaW94NWJqSC9XdWoy?=
 =?utf-8?B?YjBnOXlPSllyOHJUekZUWGlLVCtMOVBRekNjMFM4ejFWMWtXN2tYMEdVQ2xk?=
 =?utf-8?B?c0NXc3dsWTJ1RW9TRm1PcEhtaXhkUlRRakEzWE9pcjRDelpaNDV2bC9tSEIw?=
 =?utf-8?B?NXcybTZGcnlSYWUzRHBrRjNxQ0t4Ris1bWxIYTlPOXo3WDU5TVljWmhjVkJK?=
 =?utf-8?B?RE80VTJRb282d2pKL1RzNy96UzBYbkRERjUrZ01raDdZWmdxK0s4R0YzT2w3?=
 =?utf-8?B?RVpQTTBuTk5TNzdWZzlEYkdrSlMwOW1xS283eWhiZ1MxbTVGWk8wSnZFSW1k?=
 =?utf-8?B?d2JHanFjbjdkQi9ZQjEzTFBXdFpCVzlkdmxTOWZwWnZxRmsrTVdxZ1lzeDNi?=
 =?utf-8?B?Um55NWZHVjF5L2F0eWkyZkErRG8vbEZCSDh0eWw2OENLUEx6U0JNbXdlRUtE?=
 =?utf-8?B?MFFEUEREWW9OOWtYNEY0ajRrZTZYdWRzYlBBWjlleU1mOTA5RlNZMS9PZlEv?=
 =?utf-8?B?UDk1dC9VZytCOVp3MGRxN3Nrd1M2cHBGaDI4ZUVlTDV5RnJhWm10VGtKRWpu?=
 =?utf-8?B?VXhKRkpZRnJoWURLR2wwcEszZkQzZ05SN1JTWjFPcHBJQzE0M21QU2w3bXlT?=
 =?utf-8?B?NjRqQzc3bkowbXAvVG9HZytvTkVqZXJCS001ZjNQem1EMStIaS9HNmoxS0RG?=
 =?utf-8?B?cHNId2F6L2lDWlByQnIzRmNJRmt4ZHYzL0JIQ3FibkoycEFyeGJnNU5EY0JW?=
 =?utf-8?B?eTdCY3JUVGZiVTB2ZEVsYmo3K2Fkb2tuc09xRnVVdldQdG9wbTZJL0lkTVBG?=
 =?utf-8?B?YVpMeW9iL2NoTGYrcFhxSmtyeDZqNCtWc1V2VWFlVjNscmRxaEpMWE1hd1BK?=
 =?utf-8?B?YzlzVU43Z0NTZmFad3M5d0duejBUN0ZyNUlJRTF3SC9BL0xPWnI5b255Y2kr?=
 =?utf-8?B?SEFqMlhVbWM0VkVpbXJhNENjeHR2RG0wc2hUY05FaHloVTh6cEdiUHdXUjBP?=
 =?utf-8?B?SXFuVmpJRHdIM1hiWEZKVUZlOTRnQUR6Q1YrMlZRcTNKalYrOEdsWEFiMEYr?=
 =?utf-8?B?WjlHWDBrYmJjZ3hCSjFjRzBNS0kydjIzL2s4ay9qTlpiMUNNOEVmWTRQNkxD?=
 =?utf-8?B?VHM1M0M5di9JNFVlcFJhRkZYYVNvdDB0SllzejU2dTVtcU1GYXNCUHowSE50?=
 =?utf-8?B?c2NEeUd0UFZvNlJwaXN3SVFRRHN6WXl0eE94OTJxb1RsR1hmL0xvLzkwK3M0?=
 =?utf-8?B?cFJ5TWpERzVCSUZ2YXltSkpZR0RoQ2gyYUhnQ0g0RWpKc1c5QlVRbVN3RHU5?=
 =?utf-8?B?RGJrV002WVlrZksyRms2S2VMWGxVNEhvODZqRDFKYkk0d3JTMXpJM2Q3UWtS?=
 =?utf-8?B?ckpiaklWMFp4Z1dSK3JLMkl2enNUblppamNPczdERWRCOGtHL2N1ZDF4SUFK?=
 =?utf-8?B?dE9ZQkllL2RFbFU5V0JkM0Z6bmJ4SWc2eXlob2lHa3dHUmhQamtjN0RFalJC?=
 =?utf-8?B?TEdnRk9TY3RhZlNsdDVVWW5BUFU3WHd3SjZXTUorQjVZMXBuWU1YYVB2cHho?=
 =?utf-8?B?TVZVa1JrSC9lTDc5ZEVOUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU5yd25LR2lkM3RJZDRoeUNoSGZRbHRZR0krd1FCbkN3MjRmamxBMHFuRnVB?=
 =?utf-8?B?bzNUQ2pLc05zWFhKOE9pajlJSktDR0l3eVpJVEYrT1ZyM09ObTg4dXpSbEZV?=
 =?utf-8?B?RW9KY3RTMGJETVFDK1UvR2F5dC9FZ0tUU2o5REh0UjNGVzA3LzdTR0w3QmJM?=
 =?utf-8?B?cVZmWFozMlEyRStndVNjK1JaYnVyQTd3aVRJSkhDcHphKzFZL1JBRi9KNEFE?=
 =?utf-8?B?YnZKTEJhdzhReURyMStBOHdOMVZSSzFOdzV1USt6R1VxWlN6eGZRR0JORTFu?=
 =?utf-8?B?RjFrSWdtTERKajRsVFkwQTVNWVFwU3lqZGNkcGZkWURMVWVjRE8zdDhjN3pu?=
 =?utf-8?B?V1BtM3RCRnlWN2RDdzR1RmNFVTJaVFlPNDM1UGpDejJZQkpjQXluaTEydzZE?=
 =?utf-8?B?QXhxMm5NeUJxM1IrTDNKMFo3SUJ5NnNySnFQUWxHTGtNb2VHMU9FdzJsakxj?=
 =?utf-8?B?aVFYaXAxNGtta2x4aTNSWkZ5NkZheG12Ykx1eW43WXNja28relJ0QXlsc01y?=
 =?utf-8?B?Q2hWY2VDU2hkSDlDbjR4N1dsV2xSMHFFUStPNFlHbkdnV3h5ZGFkTjhyRmFE?=
 =?utf-8?B?Vkd5eE13b0E4YWxacjdHMVlvaUVzWS9aTmZMeHBjQ1pNcDRIazlaaG14TVJ1?=
 =?utf-8?B?Ny9FU3phdFAyNGh1eXg4RjRubDZDZ3BBM3RJVk9RTElURnk1RHMrazNicDdY?=
 =?utf-8?B?UFNHdmZhWEtqeTF2eWcxTmtLTWpSVU9ZVWNvSUJrNDh0YnZEeStEN3Y0V3or?=
 =?utf-8?B?dXpJMlREbnFmcU5zZGd4a1lkZUpDUHhPL2hqNEhoRlZhTURJeDRiVjVNN3BV?=
 =?utf-8?B?RU9tY2ZqQlRkdDgzY1Z2VUhWSEhrQVRLVXpPeU1NTzRKWjJHSkxGSkxGdGFT?=
 =?utf-8?B?dnZUZVlHQWhDMXRvWmJhbjhoT0M4eFlrNnZLUmxHejRxWDVSWGdDaFR4VDRy?=
 =?utf-8?B?Z0VDYS96SW03NUgvKzNkYnkzRllLR2ROK2ZRNEZqOHU4SUMveEJ3b1MxeEg5?=
 =?utf-8?B?Y1lxbmFPdTYrRzE4dVRWODE5ai85dWRJZ3Ziai8vSE44aU5KTXBqUGhic2tH?=
 =?utf-8?B?VXNxV05hcStoVjF3YjMrQnJqdHdGbWxmK2VrWTFKTmgwV1ZuSHYzNWhTbE9a?=
 =?utf-8?B?TjA2SHlHTVh6VG5CQ002QVg2cE1hc0txNlYzaGZwMmlvS1Z4eXdrVW9MM0lv?=
 =?utf-8?B?dzM2MW1CV2g5SUE0aEhIR0VlcS8xc2drK1J1elhlZzNxM0dmSHQ0VWpnQWdY?=
 =?utf-8?B?SThRU1pqS3AyS0lEMUxBREptcjdLeUd3MTQrYm5NLzZtcFIxb0FMc1FGZHl0?=
 =?utf-8?B?RmN1dnNzaE5sZnk1WjRhSzFBbE5DS2lrZ3hGWHFHMzB5NnpoeWxlQjhxOTRJ?=
 =?utf-8?B?VXBzOGNMRGxwWHpkbVhPQTF6ZFdzeEJXcFo0bWVnS2FOWGVPZHdLcFRWZG1w?=
 =?utf-8?B?VlpJWDhVRmZPV21DT1FXNmticUhZS1MrTDNOa1ZhN3hremplU3U4cWF6Vndt?=
 =?utf-8?B?TmlPTTMvSXFwVnVSNlpXNUtycDdxVW1Vc0pybnlleHE1bFA2b3l3cEhmY1Vu?=
 =?utf-8?B?V2tMRDhxcHhkTEFSb2M5SWtFU2szMkxYbFJadmJmWDBFek5FNHdpVndFcWxP?=
 =?utf-8?B?K0Vkdkp6MUwwbFVpRThSRm1jK0orcGZ5T0RrQVF1TDFOM0JPemdqbUNJVFFw?=
 =?utf-8?B?ZWxUMFhyWmUvb204VzhDSG13YXhEOVo0bm1JNkZRcDhRdzFCL1UyU040blgz?=
 =?utf-8?B?cGNOR0s1UUVUTzlkTUl2UDQwNDY3SzZsNm5zVFMxMmJuc0lNbDU1TXQyTWk0?=
 =?utf-8?B?anZwNHVQWHhkSFR5VWV5M3NiYXFQYlJKcmo1cTA2WXFIa2pSRjBoMWFWZjFH?=
 =?utf-8?B?YjQwc0xGSWcveHk0NEE1U2ZkQzRGTkRIa2hvS2NKOHIzTFJpNk5ndXh4NGNz?=
 =?utf-8?B?SEpDU3dzWVFYd0JZUFhWeWR4Nkp5Skxrak5veVlaWk1zN21QcUxSeDZrS1Er?=
 =?utf-8?B?ZXVZLzYyUUlYRWhRSXRLb2RSK2NFRnNDVkQ1S3BaZWliRzV2Z3pjNWVyb3lG?=
 =?utf-8?B?dVpEVHpubWtNK1VidlBTNnpLa0o3N0pJRUJMNWw5Qm5hVlZONVNlUmpEQXd5?=
 =?utf-8?Q?5FZKvySzdrk7UM1+k7IkaRmKw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed365095-3be3-4b0e-a455-08dce2f19c30
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:50:51.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3zets5H5g0rw5eDKYHY2yM+JV2QFVEpBqMJeEih7AnZH/sv77I1dPs7lKCviQAKvLz/wJzTWIhYjOadd0S2SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9699

This patches is splited from
https://lore.kernel.org/linux-i3c/ZvrAuOBLgi+HtrPD@lizhi-Precision-Tower-5810/T/#t

It needs more discussion about dt assign address issue about i3c framework.

This series is svc driver improvement and bug fixes for hotjoin. It fixes
all kinds hotjoin problem when 2 devices random hotjoin and A normal data
transfer is on going.

This patch version start from v5, which exact the same as old series's v4.

See each patches for detail issue.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- see each patch
- Link to v5: https://lore.kernel.org/r/20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com

---
Frank Li (6):
      i3c: master: svc: use repeat start when IBI WIN happens
      i3c: master: svc: manually emit NACK/ACK for hotjoin
      i3c: master: svc: need check IBIWON for dynamic address assignment
      i3c: master: svc: use spin_lock_irqsave at svc_i3c_master_ibi_work()
      i3c: master: svc: wait for Manual ACK/NACK Done before next step
      i3c: master: svc: fix possible assignment of the same address to two devices

 drivers/i3c/master/svc-i3c-master.c | 124 +++++++++++++++++++++++++++---------
 1 file changed, 94 insertions(+), 30 deletions(-)
---
base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
change-id: 20241001-svc-i3c-hj-bbaba68cf1ea

Best regards,
---
Frank Li <Frank.Li@nxp.com>


