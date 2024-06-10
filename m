Return-Path: <linux-kernel+bounces-208875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700F902A21
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C4E1F21352
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C11514C6;
	Mon, 10 Jun 2024 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MMKLyG0o"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E715098A;
	Mon, 10 Jun 2024 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052423; cv=fail; b=NteC8LMcYR3yGcums+xsoMCkkI1Na/ga3uNQU0784EUXamz1TT1h71d5yAq+TWyxBMbCVDw2unVNtkYE84lFgYJ86ZVb0plXvBeseB0ysAQdKur/nHSL/YzxQaiFxT9cw83dIUFI0fl/jaWJV0c4mQcPv2t9gD2G0UmMcAjUdt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052423; c=relaxed/simple;
	bh=IzehZz/tcy+OhZEkvv5yDy+VxEZsjK9N9TUy6La0efE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C1XuOVweLc7sG2M6+IrtcL6WuwElHr2mit9TRfpbrYBC/rVqIpgZgB2Hek6PYT6w/kcNOZhZ/BQf6ITdTq9/UFqZJ69M6BZIcCWB6mgB61D37VDAy7SiaMTbaXefRIwmejI6N1NSd5Om8xDhkikJf5YOVBPwIUC6HknpcJGCubU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MMKLyG0o; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI3nyfn6sg27nST1tOEYDtGEVitYOXyzADG2mLHJ9LLwZd6wI9lkNIjgTQbYzv2JWGfAyCvWTbQQO7qW4Tk544UWets8F0UohoaiZPjJNjQe+prNB/arC+yNNWNmBzO+oDjDdeUAR0Xo4mk2fu+Bf5LJtvTUeBXdRmvqzrE+dyLljAoiovBq4u8bocYi567ST+nQyVK3dLD+awmPQAFtpR95MnZgXc/2n86tkxFXjcT6TTkMZFayDieUEpzVjCGqZNeYeD7zz6hQPyK37q21nG0Pc8AwhlWMGRajnBQA9QTvBjpq+ylR8VS6kn7Au5V9QO+b8Ca+iYBbPnE2ycAZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haeK8I07Q7QcIqVN+q6IdsLyvhH9JoPZFR3uZWs4m+w=;
 b=X81JUD6EAqM5UUsgP5bF4rBZfqOpdUYe5iyjtSptJYhgKWN7kMR4jTAV4Dbb/oHOgwLcRRzgs1n6zJ1Te4cRXQ1WhlG4754vzLOFLmuwlZQlKSTHRGKPp95DSbnPYxJY9gbd/vPiAWktyqEjZqzqI84mtrVgxPUtsPytsIDkihUXFTJPcs0zgUiyj3u3yb7xKqrax/CwL584DqI56VzXHCZMiEhjl3iIaZUPzPwA/2yu5Ck/w8S78JcBL8i9dd+6HXfT1r61IKzUefyoyPOrIV41DL+g6uQGg2/bLPgijy6fMjYW/KFs7UrbfoI2diVkQ2we5WhHUXBzUxbcttyzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haeK8I07Q7QcIqVN+q6IdsLyvhH9JoPZFR3uZWs4m+w=;
 b=MMKLyG0oRMBUdcMDFF+Ja9KhQlQbr6ruVZ4IHPL8AwOXi0QPdzqz+jUfF7aZd8pJD0YdyqbEfiR4i6f2MLsSKjg1vw5tVbgHuk4a+1+T3srSPAgh5v7dqHyjOhVGOe2BTw5ykIcgR5355gTyfC0EpfOYNom8KC8X2LgRMSrBNwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:46:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:46:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Jun 2024 16:46:24 -0400
Subject: [PATCH v2 7/9] arm64: dts: imx8qm-mek: add i2c in mipi[0,1]
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-imx8qm-dts-usb-v2-7-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
In-Reply-To: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=1699;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IzehZz/tcy+OhZEkvv5yDy+VxEZsjK9N9TUy6La0efE=;
 b=evZc31/JK7Jrpi/z1h6jegjqRdT4j8h2PXsklLFXGlDLl82EBpirrKB2SoMWkO9Bsokv1JJiU
 o5PtwMUyDqcCbnvLhTUNxeuImjzGrJj2ltqBD4MsdtQ19x2VdDA3F8U
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: f62ee35a-3831-4fbb-0033-08dc898e7904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEdjOGxudlhDNXY0bkFUWno4bTF4VlIrd2x2L2Vla0lQSUdaZXNlTEZXRk02?=
 =?utf-8?B?VmV5YmxJZW5vR3kvdHBjcmpnTVdyb0VWUnp5dGVSb0tRSS8rTWhhUVBUVFIr?=
 =?utf-8?B?TkdIY2hpR1pCMUl3T0ZzeVpvbk1BOWtaMGRWZVBhU0FZYVh3Wm54RkZQcXA3?=
 =?utf-8?B?a3AxRURtS2k0MEJFVVRXTHU4SlVRVjRMTUZlTzVGdEkzZkh4dTJoVXdvVjYx?=
 =?utf-8?B?MHdySGZIWWp4RC9LSTFNN3BmaDEwbGV6MmtBOWV4NG1XQWtHcEJUTlNhV2Fu?=
 =?utf-8?B?OWRtUzVsMHF3U29lU0p6VTd1ZzJyeXdhNFg2aEVkU2JIYW50Y0JneXY0ODI0?=
 =?utf-8?B?QmQ4NGpWSWUyVnNBUTIyemtmbFI3QXl6MVVHSTJPTWl6UUJsbkNPbEoxY0RX?=
 =?utf-8?B?OWNXNkRnTmpkdm01Y3BmZ1NEMkhQQWFydDV3QjFGMU5zY0cvb25ibDJWczYy?=
 =?utf-8?B?UWs2ZjU4YWZRNVBzU3VXREtyOFpsL1RDMjlvR0JPK0ttN1pMNmk0R3V0MkhK?=
 =?utf-8?B?YWh0dFJHN1lYL2VDaFJINGMwR2t1RHJQc1p6OFNUd0VvS3ptdk9lWjFXZ1NO?=
 =?utf-8?B?M3VXckxiNzVRNGpXb2tadWpqcnRHZTRYU3A2RUN5eWpOQ1RyRzB5aFRPSExw?=
 =?utf-8?B?QURYOUhMUVh4T2g0MElVWkNmMnVxeHJMYlZBa0o4Wkx0ZndWb2RUblJrVzBi?=
 =?utf-8?B?QnUyMTBFRFlPOUdTVEhUZENqdDhsZUxwZTBCeHN3U01vVmhtc0VxalMzMXQw?=
 =?utf-8?B?eW1jWFZwOXBjaGtCMlBFa1ZxQ08vOXJ6YmxRVi9NTlVsS0xPN1NFcHNxZ2pV?=
 =?utf-8?B?RXVNSVZpR2RhQXE1WU94OFhhU2h5bFFoMWw5OFhXYXlHVWdILzJRU01tOW5j?=
 =?utf-8?B?ZkN5QVdpd2RuUjhBYXFUdy82eWF4VTNoOWNURkxqdnZzdTlnL2N6K3hpalFI?=
 =?utf-8?B?dkloU2tqdHZReDltd0NxbUN3VE12anJlU2xTQXJwRkcxdUJiR1FUMzFwY0dE?=
 =?utf-8?B?bzdVQzd1TGU3N0NPcVlyM2JYdlRkNjhHamlZYTk4ZFdTV0ZydEliOTdnMThv?=
 =?utf-8?B?RG0wZTcvWDNzSmIvbkJ3TlljOWZOVUJ6SUtPeEkxemZNSzlXT0pacjdxaFV3?=
 =?utf-8?B?NW9KTWRWUnY1dU1Cb1Y0RjNRYXIvS0k5UTBJY2J4TzJRY0IwanVhNlBqaWJN?=
 =?utf-8?B?Y2lncUpyd0lpV3hZWVJwOXJSbGJZZDBUUnFYZjFDQzBGWnZYTENldkNlaURN?=
 =?utf-8?B?ZHRwcnBKVUJvOEtvUXE5ZWIzWTlQV1RWWFlQdlhDVVBITzJnUWV5c0YyQVha?=
 =?utf-8?B?djZHaHRwSTJqRFQ3dHpQUmVtQ1J1V0dEdXBWemE0QXhTdGg1ZVdtTFJJc2tj?=
 =?utf-8?B?Y2pGMWhWVU4yVkJZSWo4eFZFOEwwQXdRbUpqWmRmWVVFd2pHQ3hrZTg1cVl5?=
 =?utf-8?B?TFlXdmFNMm93bXdQT2dOUHMvenB0N25uVVYzSW1jRTFiSnN3UWxka3lFUlB1?=
 =?utf-8?B?Y2pkdEJhVWFGSERGZ2FZN0JTeUJQWFFHUXhVaUk0b1RrMnNiMWFuVDZYZmtM?=
 =?utf-8?B?VE9pRGZIUFhiWGtFSFZTeThKM2tLMUR2VUVvYXlqWkIrRHRwWFpsTyttNERr?=
 =?utf-8?B?K0lFdVJQZzhSb1Y2YTU0aWdqSGNRNGpEa0I0MjJUbVZvR3NVZUFNNENtdjMx?=
 =?utf-8?B?S2tIUjBFeDNhMkExcXI5VXRUUmVDOUoxWUd3ZUl4am1OS2RXMDBUTXprOUNl?=
 =?utf-8?B?NnNSMFpKRTUvWUhRRWdTRGRjaFVzOUE1OEVCTXdkZjhrSytwME42c1pQUzdh?=
 =?utf-8?Q?iz8aS5NHCybwluzAiKiVG/5uVDxRhj0YB0S9k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGdVWW1PdnU4Vk53L1lUbGpMSm5qM2JodTlBcXdtWk9TMXVpaFFJRUYySjhK?=
 =?utf-8?B?cWJQbDdNbEVDYjRocm1weFJncVJFdTlFYUZOcWlWSm0ycFFHdXRoSk53TDlJ?=
 =?utf-8?B?cWRXV0kwbk8zKzhCWjQ2R1dmRE12R0Y0bktSS0NtdUFjWEsybUxzRVJHdGhM?=
 =?utf-8?B?L2hOTXFDUlNlek9Qc1VnQlRFb2FhK0FNZGhtUVBCTkJYSytqQlRTL0NqVHg3?=
 =?utf-8?B?S0k5a2JCWWNvZGpla3c5TVpEaGR4ZkdldVl1aXhIN090RjcrQ3o3Q1l0ck1Q?=
 =?utf-8?B?eGk3Tm94RnExamtPZ0JJRmNGeERZQ2tFL0dVM0xQenJ3UnlleWNGejNleXR3?=
 =?utf-8?B?NDZ6WFNWM29YajBFajFkQjV5ODYyaGxUUmFFQ1pZcnY5VlI3UVd5Tm44Qkgv?=
 =?utf-8?B?SXdrVTgwMDBqOCtob2RWc0ZCVjh3bVJscWpzSzY4MjB6NHNGMXRSQmZmYjNh?=
 =?utf-8?B?RjlLZnlMcGdjTWZuRi9MZUFpWWFDbFg3QitXZ3dKUlUzYXFjeW9iUWdoZDZo?=
 =?utf-8?B?bUhEOWFTZi9wSEtDSXR4YkhGSlczSW1HaWUvbENPbFZRN0JGcXY2VzlFdlhm?=
 =?utf-8?B?ZXFEUFZDYlVKUHNTWGJOVS9UT2xhVUVKNkhXc0lhcXByMEZqOVAvNjJla1RC?=
 =?utf-8?B?K2tpandubmhmYU1jeEQ3YkJnZ1VRSUVub000RzJNMWxFOTA3M2FhS2FXRjNn?=
 =?utf-8?B?S001NDhPdzBobUtnazVDTUd5aGVaQzkwYk1GYUtJOTk1RkcyS1B0ZkE5T0Z3?=
 =?utf-8?B?TEtMcVBmYUFEYnpjcHZIUGVhcFppZnF4Uld2UjB3NzhiVlNIQmVLbEZPZUV4?=
 =?utf-8?B?dDZUL1lZcDg4R0tnazhxbjNCcmM2Skd6RnFYeTN1RWkyeU1mNGUvLzJoWUJv?=
 =?utf-8?B?WnZhNW8zMEJZd0NSU1piVENiS1lTdTVPd2NsSEFqRW53MnAvcDl4RkZwZnl6?=
 =?utf-8?B?ZVB2a3VZYmFRemZGREYxbGgxTlhrOFNkRUNkRkFSTGJINGR1NHlNTXlRZHV0?=
 =?utf-8?B?WS8rZ2ZtWTYyLzdtTUloVU9Mc0NkQnJMYXpBZ0RlL2dLanFvbS9ySEZuZFdw?=
 =?utf-8?B?MVg1S0NpZjBmMDd4bkl0WGFmT2lRZUkxWU80a0ZBS3prM29xMWo1MHFWVkM4?=
 =?utf-8?B?ODFFZWhBZkc4WU9pbXZNN2V5L0FNeWNUK0V0cEZsSFhScm1Fa2FpdkJPUVJB?=
 =?utf-8?B?a0ZqQVMzc1BTbmNrSkpORnloQmh4blA5YWZaOXVMZ2E4TXpRSy9yWE1zaWJa?=
 =?utf-8?B?N05wTlYzTzZJQ0tta2NGVVlRTFZjV0JXb2VvSlZUWVQ3ZHkxRUxESkNFTWFM?=
 =?utf-8?B?SzhYUlFMOXpVQjJrTTM1MXM3L2M2NU1iRWd4L21RUUhmODczK1lramoxekZv?=
 =?utf-8?B?bWVjcEFFZTZSSzEvSmRVbVJGMU5vOGlvY3dWTkZna2FmMzNFM0FJWm1mY01u?=
 =?utf-8?B?YzdObEZTVmMyamZoRWtvazFzR2lmNGd5T1hmanNVOTdLdzBwYVJLRTNjVTk4?=
 =?utf-8?B?eUhMQ1Jsb2JWRGJmcE5pZFRCQ2tLZk9ROWJnd3lGZVpyTTM4QjJUMFlrWkxF?=
 =?utf-8?B?V01FSlBJbnZwWFV1TSt5Skg1S2VHWjhZdUplR0UybVZybDRCblhxbDBJWHNX?=
 =?utf-8?B?anN2S2xlb0lFS09jM2tzd0F0TTdkYmNkWEs2WGxabWVLMWJjWE4xOEs5VzZZ?=
 =?utf-8?B?ck5mOUxVK1VZM2pSK2phNXBlWllKSGR1ekdkNGpIeVJqNkEveWVYSVpyYzNn?=
 =?utf-8?B?Z0J3enRRWEZQSzQzdDNsRWNBY3BGUU1Sd2o1TXJLL3cwQzQyYlZMdUUreTNK?=
 =?utf-8?B?SGVWM0w5emhQem9IODJJR3lCSncydUE2NzV5UktOR2xXQUVjQmFCZkZ0Nk54?=
 =?utf-8?B?bDRHZzMyRHZHYlA2WGRJZEM0RUFLZ213V1hoTnIvZzNxSlVxVU5ocWJlK3pO?=
 =?utf-8?B?cStmMkl5eVZ5SDBuYmxQMjdxbC9Ya1NJQlRRTCsyKy9GOXlKMDh3NmJ2bmY5?=
 =?utf-8?B?OWRGbitHUGVEMUlWZ0FVOGxEVnFzN0tYWUkvdGpYK09RakNkQ0VMZWV2dU1k?=
 =?utf-8?B?WHJaa1RmcTUxeVBIaEdWQy9FTG9nT2hPVTYvbWpwbkt4NzRVQlBHWUJkbndH?=
 =?utf-8?Q?fWaw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62ee35a-3831-4fbb-0033-08dc898e7904
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:46:58.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orr+QdeghY7yiUW5vF0ChYk5CuKx5uBgSSHuSi0N3M9qYVAAulJvEkA6fkOxqwzNeh1E4zIUOJrS+7EZxPhZZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376

Add i2c node in mipi[0,1] subystem for imx8qm-mek.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 3cf39c868e752..e3a653be7dacc 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -364,6 +364,20 @@ &i2c1_lvds1 {
 	status = "okay";
 };
 
+&i2c0_mipi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mipi0_lpi2c0>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c0_mipi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mipi1_lpi2c0>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
@@ -636,6 +650,22 @@ IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
 		>;
 	};
 
+	pinctrl_mipi0_lpi2c0: mipi0_lpi2c0grp {
+		fsl,pins = <
+			IMX8QM_MIPI_DSI0_I2C0_SCL_MIPI_DSI0_I2C0_SCL      0xc6000020
+			IMX8QM_MIPI_DSI0_I2C0_SDA_MIPI_DSI0_I2C0_SDA      0xc6000020
+			IMX8QM_MIPI_DSI0_GPIO0_01_LSIO_GPIO1_IO19         0x00000020
+		>;
+	};
+
+	pinctrl_mipi1_lpi2c0: mipi1_lpi2c0grp {
+		fsl,pins = <
+			IMX8QM_MIPI_DSI1_I2C0_SCL_MIPI_DSI1_I2C0_SCL      0xc6000020
+			IMX8QM_MIPI_DSI1_I2C0_SDA_MIPI_DSI1_I2C0_SDA      0xc6000020
+			IMX8QM_MIPI_DSI1_GPIO0_01_LSIO_GPIO1_IO23         0x00000020
+		>;
+	};
+
 	pinctrl_flexspi0: flexspi0grp {
 		fsl,pins = <
 			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021

-- 
2.34.1


