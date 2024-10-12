Return-Path: <linux-kernel+bounces-362305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D399B355
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0121C22D99
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C274F15B11D;
	Sat, 12 Oct 2024 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tqbWq5vb"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E6189B8F;
	Sat, 12 Oct 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731459; cv=fail; b=oLvGkVodLuqfqV3EgJcPuHSexhGqyGAYYzyOVQbof1PH49o/aUcCXVpU3b68GgQ8bwZ84548DP/ddBIXf3PWVA6ofMzTelTlFWJ7NguLw5tRj/i/ZVfi9C1AjB7I+qUpjkXjhrRSKxODw0w0HRgtYLI/ZM96n6a7lXGQ8brNPZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731459; c=relaxed/simple;
	bh=eMPQwKxYKXDEw4L1TXdShK43rvZdiodUEy41Ez2MUUc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sfUtuEud4LKMwm/Iz0Tb5tLTjgW7nQ1yk4JxdtAXZYnSVNZX5UthfMQZQiwzqoCzmakhEs7eVDpidx9FZxquQm3bUB8N52LJGyzMHcvmpkwVzvTv/gYeRJMoFWoJ9PRMO32rRg+9trdrx0/5CoJg1+MF/LLnr6IcJk3n1pDlEiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tqbWq5vb; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pw447UhI/Ay4uRzjbiMQLIA5Q0YxHzIFiKON1z0/OSIzONfOaR5Dng6u4DYzUQqO3FkmC0w9mZNJQg5r+7wB2iLSdhhdew3J4oOIA162Ov+H/f52RVGQ+ZgcXX5Eu79/9M+RoILGnOYqfsALEntP6BrYXlM7i6YKlPaEKkQHDIXdWg8Dj/yI7Tj+EEVzGeVYkwwxmmtQpnsFwSLNrbV1AxFV1d8fU/hDRTaXB8PWfsRFs8+xuaAoPFAdefAB0CIMsAwPXg05M0kmm7QHGEex39IRHoFPjtkgjPcouNQtAwMxfrcSquhvYoytJo950vGKqkuCUGI61y+hnH9JxvrLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvcDPZgW48sShMgPRS9p65repKDP5tQIjIcVNnOsSCA=;
 b=Q8VMEIdKbLh+Uwz8QUn34h7UacNYkBwlHZCViURLBsm1thoVg7Rlnm3V2eajH0i7M1CDGdpbVdnrMTZa29O8+rnQM2t2tZPY8G3WuYq4pV94pNrgxjIjHbm/6xn/ohmBx4CAZy5+sPrT1dDIquQZv7plqvyY8R7HNECVgj8tiRkanWvV6ivbjImXJZFLloYZbVEsoEmggmoPHv+RwdIE5A37Yn1H/0UvoClUOTdkwrf378ktglLCHBgbWUDQOXzytsNOKK3BkpJRgCVFptGW/oY5jTh+5yLpQ29qMDywuuhwfZ8mp8El2FO44MPtpG+ZVOY7a1HSHyDWjmj2Xstqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvcDPZgW48sShMgPRS9p65repKDP5tQIjIcVNnOsSCA=;
 b=tqbWq5vbwElgxA/gjlCA/ChwXD9YhKHzLUiInRC9AHuCvkTfXVRbmgi2gxBpL0L080FcsHzdA/PPOLKvfQ62RIPFVmFhHlaoBcXHunyK2MXC1pwZNwMSCC71bKNUFcb34Lfm3bNh/uBpptWlnbDGVdrgsem3ccaK9YnXlXqUkMkLrp7T0XVK5fvcZrFQhQjCmvAJ0hbCOvsW7YvR74T9aX272uICbzCZnT1/S120A7ac1HThdMvBuE/fOEIKSsNRMkfJuMD+b6Mj8v8NzmbCbFBBD2xX4O3hsZmOW1eLiKmGPptRRN0/H3uySTTLMrjvD1PKbcNqbjVxcglv1E8YgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sat, 12 Oct
 2024 11:10:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 11:10:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 12 Oct 2024 19:19:13 +0800
Subject: [PATCH v3 6/7] arm64: dts: imx95-19x19-evk: add nxp,ctrl-ids
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-imx95-dts-new-v3-6-edfab0054c71@nxp.com>
References: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
In-Reply-To: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728731962; l=1463;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=efx64CdU6o516UnSSuW8d4LT5QtBcq0XsS3yN1yX1YE=;
 b=GCIsaQ2kYgsx2FWj+H6jfsc6VIfjyHYtuAnNbaOys6L4qCjezjWcLgexChXsb0OdnJXXjC12Q
 HZV/DZ2+/bSByEcFIKY73OfseDnYvU+teTh97hCyG92fTWddCWsG0h2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4b4494-6b6a-4dc6-d3a8-08dceaae8ac4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFY4bHFvb21WdEpuajN4RlBlamdTekdSenprUm5ZQ3lKTURBbmpsdmxmUnJW?=
 =?utf-8?B?Rm5kTk9YcVRpVUNJSWhUd0JTMUhVNjZzY3ZGc2xIc0JjU1dNSWVkWHVzUGJB?=
 =?utf-8?B?MWdIdDdlTjZxNno0YWVIcmNFRm4rUThwbk5leWp6NGpiU0RaVlJxU2tHZGxk?=
 =?utf-8?B?TklKWFViQ0dBWlZDbWZxRzlYVEhPNmNINmZSbGhxKytUWjJNM0xqZ3d4YlVu?=
 =?utf-8?B?RjFlOEhMNG15RlhacVM1V2tkL2xPRld4cHpyREwwZTMzSjR2ZmZZY3hPWmty?=
 =?utf-8?B?ZjZDMkdXQlRSUGttUUJqRmt2cVQwanZsTmVDUnhxVlRaM1dhRkpiK09Ha1kr?=
 =?utf-8?B?V0hsVzl6MTY5MXk0SmhVRUp4L1JNM3dDNjhvSXRLSS9vUCtvMS9ZSUZrSFNz?=
 =?utf-8?B?OS90UGZCckZ2VGljNFgyRU1lUGZTRE5YTXJ2ZTVoQllsT2IwN2ViUStMazZI?=
 =?utf-8?B?VFRvb3N6UitmbHVmdEZEZEhaUEY5Q1l6TFZoMjl4QWllTGZ0WHZQcTJkUGVy?=
 =?utf-8?B?TmdWQzFCQVRzU3VZcHcwd1ViRVJGMmxNbUVYNkQzcmJBL3ZTdGFqUXV5emVa?=
 =?utf-8?B?eTkyTENEcmZTdXRqcXE5U0hmWVpRb1I0WEkwT3FQT1dsa3h5OWFkZnNVS0JM?=
 =?utf-8?B?TDBNTXFIdS9EVkYxWXRHZ1FaY1BxanRWSzBidGdxWTRycU5zTlhyRWtERGx2?=
 =?utf-8?B?cUVBMkZTVHloNWlSeHQ2WjRqRjJVSTdYRXlsVW1HKzFKWnJXclJER2ZFbDlB?=
 =?utf-8?B?VzM2eFcwKy9aTGliZFBJeExuTUpkMFBnMWlvbjZTVDhPdGFmSVlMRitlWWJV?=
 =?utf-8?B?OUNLUnEyRU5HZmgzRWl1THhZbE5YZGFFdkNKcUdrZmo3dzZ4V3Bla2hpWjgr?=
 =?utf-8?B?bTJyMFJzKzJZeTAyUXFhQmxMOC9IOFdCcUFoNFpFTjRweUp0dFVKTkIwaVBM?=
 =?utf-8?B?OFp4MHZOeUUralJGN0Q0V3dWRURnVGhOLy82dEhCaVJkRFltbWVzV3I2UzVM?=
 =?utf-8?B?UGNRZjBqWExPazEyS2ZicHQyQXlwUWxabmlXSFdGVjlPazZTVWVqZjdXRVdy?=
 =?utf-8?B?bm44dk5LaEphNFExK3pPVndnTzBuZTc1SGtGMDh5cEloSHpOekdvbG84TThT?=
 =?utf-8?B?OHZFZjVHR3FBL2VxOTIxbHlNRC9PL211azhBVVZjcjl0VXZqTDZ4dUMrN0l3?=
 =?utf-8?B?c1NwWkYwSFhvQ0NjelltTGRYSTJkUDdhMEE3K1BsZGpNWXY1L1VLd2Vvd0hC?=
 =?utf-8?B?SUovVWE3REsyNzQ4QStVUmhra1RyVHh4STM0MDVtR0J2WWNEbVlNTEh5dmpq?=
 =?utf-8?B?MXdjajBJMXNNWVJzV3ZMQWx5TWs0U3ZROEZxT3M1NEhhbGFTZVRDSlRTY2VD?=
 =?utf-8?B?Nm5SWmU1Z0Fmc1h5alg0UDUxUytDWWQ0cnBXSHdNU29nVHVHbmtWNVdpUVNL?=
 =?utf-8?B?RytJOUNaVHRSajlmVmM3TlRYTzJiNHE3SUVnNXRwc3ltL2xNZHVWMzg4RXRx?=
 =?utf-8?B?bi96cGN4ZDkrSmZhbEpISDA0RWExakdWd3lhUlNudU0xOFlsVGpOQTU1ZnJp?=
 =?utf-8?B?MDhjaCtkU0s4ZjFhT1MwSmx2bklaa0pRVkVjUTJPV1VueGIvNEwvakVWMlRG?=
 =?utf-8?B?TFV5bzltdWRibjExVnJGSGxCajJzeGVocHBvdEs4SGMrSkdVaUYzaHBPMml0?=
 =?utf-8?B?NGY1aS9oL1VUdWZZWmVkQ3FpQlRaYlg4V0NrZndRTS9wNitwbmxMOFllZGJ5?=
 =?utf-8?B?Q3JtSlFZQWdiSk11bzV6WGNmdHhrRWtJYTZXV1RWcTJNUGc1cTNiM21GU0JG?=
 =?utf-8?B?V2RMUXoxSHBPMGNpRjYwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEhUeTJYa2cyS05BLysxb01tc1EzSGNhemJWZ1ZGOGZmVTl0eVpQWUZMOGFI?=
 =?utf-8?B?ZCt5K3Z0WGJCVVdMdjhkcThYZHI5VmhIVW1GVWtyRnNXSXdCejhBcFhWLzlX?=
 =?utf-8?B?Q3c0QUV1SDFsaDBNM1RIbzYzdGpYZzh6dmE0NiszMG1wTmlYUEpwVWp6QmM4?=
 =?utf-8?B?N0lqOWxMR0g5VkZQOVNQcGJOSjNYUEhkVDlkRlRwcTA5K0RNbFlCeXpGbWZa?=
 =?utf-8?B?dW9RMk5YeVBQc3VCa0szUEJKOVcwUTg2eTIzY0ZGUDFqZnYwc21lV0w4cVZN?=
 =?utf-8?B?dWJSK0JCWjVJSmFGRUxvZXZBL3kyZzRwa0hsUUppTy9rTDk2VFlwYVp3YTRT?=
 =?utf-8?B?b014aTU2Q3VyTVdOYnBLTk9nNE1NYld3R3d0T1FsUjB6WmFxZk5vdjBhRXdV?=
 =?utf-8?B?QUVPaEdmK1FoaFFkQ0IwRm94TkkvVzZiMlVzakVxLy9FcWpvOHlMOG50YmtQ?=
 =?utf-8?B?ZjBoZUQ4Q0J4WDhRRjlJeXAwTDhwWmx3b1RTQmNXaHFOZDZ5OHNyb3dpQXIz?=
 =?utf-8?B?TVJ0ZitacGFjcExFaDE0dTl6ZFJHc1F5WkFXS29yVW9RelM3eHppdVZXU0Nq?=
 =?utf-8?B?YmkxNEJLRVZrcU1jTVEwQnM2a2gyYm5WVU5zUW1haVV0b2Frd0VUV05LTC9T?=
 =?utf-8?B?VVRDT1RhU2wwdzM3eDRqV3pSSHphNHZHYUdKOFN6WWJoSnI4RitNRzRzWEpv?=
 =?utf-8?B?a3JScUdmN3FBNElnMVRMLytIWHI4K2kzT3J1eG0wL2xOVEZsOEJBT2lrczJJ?=
 =?utf-8?B?VDROdzRuZWlncnVWbnVHKzBlRitqeVFsNzBlL2psZXVGZnAxdEh3enEvZmpI?=
 =?utf-8?B?TkNhYkZGTFVBOWdUOXBRYnFVNDF1QTNCSGNDcU1vODd3Z1Q1aFZxUDIyd1Zo?=
 =?utf-8?B?Yy8yVHVzV3JKTkNHbS9Pd1JUQ3haSjBoWk1YMnRpMHlmN0xQUHlEV0hSS0ZI?=
 =?utf-8?B?SWFrcEpkVVRxM2gzYWhlYVkveVBXcG02dUMyVGVueVR3dVdUbWpnUDVlaGxj?=
 =?utf-8?B?aFJocERQdkpDeEtsTGI2RnU0dUJFTENaVVJ3a2hVaDZQVkJvTUpaeDJ3ZU5I?=
 =?utf-8?B?ZWdnZTVhVzMwdURNdzA4ZHhsUEprZEVuckhyaVFFbW5VYWR4c2RiTXJvTkVq?=
 =?utf-8?B?SVNJUDZHV2UwZkhVQlAvdDI4amNmRjMwdUlmT1VEYWdXWFZTN0xVZzhITm5H?=
 =?utf-8?B?alBFK2RIc0ZVbWl4bjBlbEc5emNyK2ZjbnlNSEl5cytLQXRWU29XQTNZWkZq?=
 =?utf-8?B?SjdnRjFCNFNVeDNIaEZQNG8yNXpkZnBaNFQ4UzVrcUk1TmN4N0N4aG92c3VI?=
 =?utf-8?B?VWdYajRoOEU5T3pXbnhPMlNSUEdXSTd2bU5EY2dvRVZxZEsvMUt5NnFvWUFG?=
 =?utf-8?B?ZUFGN1kzSElLU2htcDJyMnlaaGFKUHBENHNCYjk1TzV3bHJjb2RyNFZFRkll?=
 =?utf-8?B?SThVaW5UdFFTSndvcHBkTmhhQmhoazNiSVJSdjZDcFB4ZGQ5LzkvdTU5OWNp?=
 =?utf-8?B?UWRLdTBWbTVKMkxtb3hsemFkVW1icUlmMWhrS20xVmNFeWJaRDUrTkNkbCt0?=
 =?utf-8?B?OFE1QkxhSzZvdEkzRi9EalVzUy9FZVM1bkVpeWRKNWFmdldNTmRKdHNOSVZo?=
 =?utf-8?B?aUlHRVQrazFhanlyNWlBRG13dWJVMDZENytTTnRBQzdkclVHenhDK0RrOXAv?=
 =?utf-8?B?S1pKMnRyaHhHTnVvVEE2T2NjWm1uQ2hZNWZyT0ZvVGtEd21FVXdZbTdvd256?=
 =?utf-8?B?dnVXTTJmREJ0VkpyNzBLTXBKb1llZ3VGWGg4ZmhvaDM1NzJ5YnZQL1hRajVY?=
 =?utf-8?B?Y2YwNFhZNy8zcWxkSWNaQTY0REtZNWNvQlZ3ditTWExSM1hrcE44SUVUcklU?=
 =?utf-8?B?eGVWdXYyVWkwK0dxZEh0OFR4enZtdHBmTHF1YnNIZWZvcUt2dU82SklhZi9Y?=
 =?utf-8?B?WUVqRFRSbUxRckVxbGZodFk2TlVlMkRvREI2Qk5pTVkrSnBzMm9jMzlQenU4?=
 =?utf-8?B?MWVLaHJIUUtyRitEQUc2cGZYaitpcXZXeUdIRm0ycnI2R1dlTmE1NWRFWE9Y?=
 =?utf-8?B?TmhKcW8vd3pJWFpkc2M0STNEUFZEK2RKbkIvVXFudUVHRTZYSGZSQkNHWkc0?=
 =?utf-8?Q?sD9piZ034iezDCuikQjmr3PPz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4b4494-6b6a-4dc6-d3a8-08dceaae8ac4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 11:10:55.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgsUOWjeUvTehGnYhTHCRKAqR6n3xGTR792DZwUxB6Qa4UOd213pV1BxhiwfdCAMX4kkqCb79v5O3Eiv0s8alQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771

From: Peng Fan <peng.fan@nxp.com>

Add 'nxp,ctrl-ids' for SCMI firmware to configure the board ctrls as
wakeup sources.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 37a1d4ca1b2079880f6a0397027c22c5e471bd40..5101cd171e095fb5209464055a52ebdfa7dc5a61 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -8,6 +8,15 @@
 #include <dt-bindings/pwm/pwm.h>
 #include "imx95.dtsi"
 
+#define FALLING_EDGE			1
+#define RISING_EDGE			2
+
+#define BRD_SM_CTRL_SD3_WAKE		0x8000	/* PCAL6408A-0 */
+#define BRD_SM_CTRL_PCIE1_WAKE		0x8001	/* PCAL6408A-4 */
+#define BRD_SM_CTRL_BT_WAKE		0x8002	/* PCAL6408A-5 */
+#define BRD_SM_CTRL_PCIE2_WAKE		0x8003	/* PCAL6408A-6 */
+#define BRD_SM_CTRL_BUTTON		0x8004	/* PCAL6408A-7 */
+
 / {
 	model = "NXP i.MX95 19X19 board";
 	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
@@ -357,6 +366,14 @@ &usdhc2 {
 	status = "okay";
 };
 
+&scmi_misc {
+	nxp,ctrl-ids = <BRD_SM_CTRL_SD3_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_PCIE1_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_BT_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_PCIE2_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_BUTTON	FALLING_EDGE>;
+};
+
 &wdog3 {
 	fsl,ext-reset-output;
 	status = "okay";

-- 
2.37.1


