Return-Path: <linux-kernel+bounces-448842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7619F4651
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE74D1882ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3B1DE4FF;
	Tue, 17 Dec 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DDGCDnvA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F242AA1;
	Tue, 17 Dec 2024 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425059; cv=fail; b=LzJ26CpezljaDOuAL1IYGYLlYLYR/IyzyfZthSPhp1JNxoLesKW2YDqWuxfQyNgDdbrAzb8bqOHNJuawhxYWdVPEQDdreZmLzxZ9Kdfw2tLAveGRFGSjKETAEEF+7AEKIMSidH94cGlPeM5B6ePuaKYWHzpenFxHkU4/bniYG7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425059; c=relaxed/simple;
	bh=IP2JClLGuNa6xGfwV+VeLZg28RDa60wLjCC9SnkTd1A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KRIM57nPs0Eotal07Zpi9nvi5VFTuYcXfV4rVtFdxHjbA4iQ53om3kVAO0F9M/FU6ZGRluIxb7ZtpUk3KfjVg9jskW1V/hL12Eg5A98eUidXIj8lx6gM5RUO7dR+eXxnodWCAduXWILTjwqC7vETC5Ctqy+7rF3/LHBu0VEJ3gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DDGCDnvA; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exb119cH5et7+y329upNaLuCtdkiRmx2ggrfKVhadZLTiTEJgiUiDJenAHrFsK7NXgz2QTJG9hljJwgftCgXEItpCtYHLDxOiBkKRDbueIPuhktltVxcrFX0n1rwOKEtIQYxrxjp7rd9vbLBvtrcyj/PTfZLNzsrm8DHQlAtuTW4hV1R1eYoFMX50Uur9rsCZlyY0pEc8B18S+WRUqIu+bQ+qeATEin33saZbixiar8bmoW8m+oKtinhKFmP/yW89Gia62dnLoQYN+HzceJSznPtZS5EiDdZ7AEbkx4gwjjp+tp5zZ7qvaj2iBCJ2X5jNLQBlJpEb1mjTZmOEFYm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfl+6fu6j/buxkWTqIhOBZn8JuDX5zw9xNawUWw+yqM=;
 b=gznVf0Vbk5Sv37Nl7BDMHpqIyusmHxeZI7y+qU1+H508Xr/feXHVuLFfvTG4e6AYLCanIIXBWPimUG3v5c47X0fer7kqIX+HAweCojo9qW3bK72VJj7aZAE53d+IzXHNgJfNhWVQZcs/M8JmR25YZHoEqYOaQQeiyvpXNT2lF+j3Anb2qRl6B7MVjHmK6r9DqaBjEnFb6TLMmWhfF6ec+PkNrXRpIYTLDPTu6ThzRiBIdV78FrSKtJsr5bj6nZ1c07DdyB9nrXu5PM6EDbLjVpHlte6KDAO2sh0OEMaCJuSiY+Nu4AGAdhmqRsSXPJq5vY3NUel5jNnajZf8fMVFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfl+6fu6j/buxkWTqIhOBZn8JuDX5zw9xNawUWw+yqM=;
 b=DDGCDnvA8AkJzVgjRaCffd6u0ifL+2xS22QxFM8JyzxEm9YR0E4ow4sztX1+rTpPbdsKqPDZvsdi8jglHSpQAb97Jji+3C0W8ewV68vKQ0LmGBLFEah+UqLXcu3l2cpM/88JcbyRzzUqKbMuZDZ3QLZZezXAhN/+30VT3n8F6SP85CPY+Rgxaf9fMRTqD5qMF3ubDQdKjAnZznOIkM+4dKxOZOfkLvM1wvu92Ydcfl70s9iS4tB0nkPOQEUn5xuN81o1hvMEib8aJPkZwG+ArOq9Up3LbUYS5izHPWq5wSBa2R5Ajl5rD7k3v/kYpdZEFcKZC56gkH8pywK5I0cmjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB11054.eurprd04.prod.outlook.com (2603:10a6:10:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 08:44:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 08:44:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Dec 2024 16:43:36 +0800
Subject: [PATCH v2 1/2] dt-bindings: nvmem: imx-ocotp: Introduce
 #access-controller-cells
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-imx-ocotp-v2-1-3faa6cbff41b@nxp.com>
References: <20241217-imx-ocotp-v2-0-3faa6cbff41b@nxp.com>
In-Reply-To: <20241217-imx-ocotp-v2-0-3faa6cbff41b@nxp.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734425027; l=4015;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=dKaDD9hIu9R5UEg3RwIF9YElE6ysMwqpQ3PJh/tH63Q=;
 b=YMyi70X1QlTs+/deaZqCVrBs5Huzsv+LN5kdxrjWDGTpeYIk0lsyVGG1BW9LZUnDI8vYRsvns
 Pu6nRhA1BUgCKIkMPYaWdd0AYlJeH+hopni00Bo9K27RalQQDxcQl0Y
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB11054:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5a6757-2ce3-4cb9-d25e-08dd1e76fb64
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGdKcVhCcDZrYzdzei9saGNlbUxTSWJFUnVWUmQ4clo3a1EwT0ZyNjhMZTM0?=
 =?utf-8?B?RGdBUFZTb3oySXRlWVRneTV2c2NsRDRmcXRoMkRWa0JhZDNQSmk0azNnTEhS?=
 =?utf-8?B?QWNYMjllSERCTjFmeFVjeVZYQ0xRVHVrbUpmNElSSUQ2ZGpZU055SzdMd2o2?=
 =?utf-8?B?b04wbFV0VDRQUmN5N2JLaytoUWhoY2g1bnJmYXE5RUQ2dENYRGJscEhxanVm?=
 =?utf-8?B?UkZMaVphVnNWV1BNb2FQcEIwQXk2K0Z4aUtTMURocjJQVlp1TXRSZUFoZXN0?=
 =?utf-8?B?Vm9RYU5GL3pTWkNUWlE1a2RVaGN4THNjMHlQQXIyb2dOYmVPQlRCQUU2djNy?=
 =?utf-8?B?S3FEQ0tMYU5UMStXR2JNRnhKSVFvYlJyemdDOVBPakFLd2ZpK0t2WHYxTjBW?=
 =?utf-8?B?Ti9PSVAvQnk4R2RQRmxESzBqV3BIODBzUmZNeEJlb0tOWTVZTDBqZmFZYTVz?=
 =?utf-8?B?dndHWERheXZNOG5OY0lDVWdhVHJvUkw1WjdQc0ljYzZla3pIbUo2bnlJU09C?=
 =?utf-8?B?ZURlQWpjRXZjVjZ1U0hJa0JsZnNMdTA5RjdHRFB1ck8rd3cxTFQyczNXeU8x?=
 =?utf-8?B?cXZpR2JtM0dSUHpQZFB4d0orKzI0VHBHQy8yUDJKZkN5Ulc0d2dFTkZGaS90?=
 =?utf-8?B?ck5yYmlzT2lMR0NNZXRPQ0pGamJ3TDRUMmw0bDZNbCsxdEFJVTJZNlhKVG5z?=
 =?utf-8?B?UkFCcUlPVDBsUDVhbld6aUlvT3VZVkRlR3owWkJVRlVHNnBBaWs3VElhbHlx?=
 =?utf-8?B?SU45aStjZzJMME1GTFdkemh4U1BST3NkT2FLU0xiR0oyTVlSclpQTnBZMFVN?=
 =?utf-8?B?dW4yMVdDS29PZWxxRUJ4cHJkbTNFTjljcEZxcnJTZDUzbmhVdmRsNUxCVjJH?=
 =?utf-8?B?S0tyOXFwZXJUWU1ibWdTZTZFUUhyUTVBTHdjVG1xM1dsMitnb3VNb2dxWjY4?=
 =?utf-8?B?Y1d0azdXTzFEdG1vbUtXeFllZEJqajVuWGNKdHk5ZzRuOHlLbEUvdzZzYUtq?=
 =?utf-8?B?cU83aHN5MG5ReThzbFlSOGFxL2RSMHFENW5QS2F2TzQvTy9JbUwyUzh5QkFE?=
 =?utf-8?B?L3kvdnQzRU1UdC9GdXZ4TDByV01kdGdRMFlzM2R6MW1hdXE4b21maGkzL3gw?=
 =?utf-8?B?T0N2MGZxa1hiQmhzN24zQmZpMnh1OVFlM3RiMzVucW9Xd1lKRi9KSlozd3lO?=
 =?utf-8?B?dnFQSUdpTnlsaGZManhSRlpWL2FjdVJoVWtpVzRiYXk4VDBKcjlsOThMZ1ZJ?=
 =?utf-8?B?Q1FMK2dZUEN6NEQ2c3pCQTgyM0RVSzQ3dDFQWkU4MEpKdy9BUkRmK1ZYbGVr?=
 =?utf-8?B?RE02Ly91YVlmM29sR1JXWGZqNVo1K0JVQ2lzdWRoZ3FuT1JYcGdXYTFOc2hh?=
 =?utf-8?B?ZjcreVM1RFhia04zTFo1SHlLVVA4dzJQOVhHcjRRRWNDbU5VZG9vaUZPWTdW?=
 =?utf-8?B?VUVHUnZNNmNndUVMeStKajFYdzgvYWpuSDlRNUNTRGgyWlJSeVJRYnByRXJw?=
 =?utf-8?B?am55OTRUejJUNHZsREhuUTVTWFFJYlZkaFNnVEpLREdNbnlkWitnMVJiTkJT?=
 =?utf-8?B?a1k0akdIaGY2cFllcWM2ZWdHYjMzb3FRcjdhRkdCbC81TWpCNy9RM2Rrb2s5?=
 =?utf-8?B?cm9hM1EvVVFwS1AyZGhQMTZVUnZTcFhiTjdHVVJkY0h0bkpSbmZnd3E3cGR0?=
 =?utf-8?B?YVhKb3htbDJLZDJVN0c1TDJ0NTI4VGFLSDRFR1lYbW5ucE9HaEpIb1FSdlNz?=
 =?utf-8?B?bzFvRmNMejkyTUhESXBsWURBMDhrQWEyb3dEYmtlTHIweFRtbzBxVWxadGtW?=
 =?utf-8?B?Nnh6NWVaTjZ6L3ljSmdrTW5iaVdYOUxsK003VzJSK1FHK2JvYlRIOW44Rnl6?=
 =?utf-8?B?cTBlZFIzakZzU0hpaldtYm5TNHdwL1l1STRmOG9WQkE5MEQ1ZHRmWUtTTlJn?=
 =?utf-8?Q?X5oVF7wDJf0UjEaBKLc7dVITxQiRjkoZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXdLOTduaHlWaW5SYStPeFlUWVRSM2xMYjVyaXRjUHUxcjM5OGZHM3VLS2hL?=
 =?utf-8?B?bWVHYWZwb0lyTU9WenRRTk1EVFZQYjhDVCtiSVE0bWRHRk1MZ2tCSnhjWEJY?=
 =?utf-8?B?bDVVWVFsUFZMOFZRUXAxaXBGOVhXVzZqaGVCeWVNT2EvZ2ZzeFJwcWhMakJQ?=
 =?utf-8?B?VUtuUjJWUnFhYWFoRm02YlZ6cXc2VUJ1MjBLMnRvMFBCMy9ER0o2Z0plVUxI?=
 =?utf-8?B?MlhhN3UrYUpXS0dpWHJaN0lSVWRBVVJIdUhNT2pwa2ZVMWxEVk1Db1pVcWZa?=
 =?utf-8?B?eHkwek83amsxOTNCL3pvcms3TXFpK1NmRVhpSzcyNGdVMHJZY2ZqY2U2ZnB1?=
 =?utf-8?B?dW1ueE1lWlhRWnBFWjFDRm1sOTlQbGwzeHNua0t1U2puSFNteUFyNEIrckFi?=
 =?utf-8?B?MEsvM084cmFaNnpHZGFyZllVTkxHV0xncjJCc0E2UW04Mnp0Q1NBRDlYeEFV?=
 =?utf-8?B?c25YcFZVQmZ2N3pxcklnci81VmZBUU5wMmg0ZjIycGpTcVc0Sjg5ckE1TEN1?=
 =?utf-8?B?Rk9wQlhhalc2dHFaTmRkOUNQOWlFSktWY2FDSHd6SW9Salo5cjcycVF3SEY0?=
 =?utf-8?B?T2dMRGR3cnBGU1U0Y2dIWUVOWHc2enROZXFuRWx6dmtMeFpqajNXWW9YOVYz?=
 =?utf-8?B?ZnpHckRUN0tIME5iUGhOamorTzYxOHJTWVZtRUdDY2w4NEs4aVVwOVFveFY0?=
 =?utf-8?B?bjNRL00vQnUwaDlQbmxSUGN0UndkQnV1V0xXVmc1MVJYUWY2NGhhcGR6RXJT?=
 =?utf-8?B?SlRWVUIvU1R5N3VrdWZLUkxPLzgrK2FtYk1RMFliSUVqSmJzckM2MVY5YjM1?=
 =?utf-8?B?bGlRRE1POFhWK1hsR3pyMzJiU3IwNlc5K0JkQ2FJZHNwZytua1NGN0pqeVdH?=
 =?utf-8?B?cGFqaCtReTM3a1k1QXdrV1pWK1B0dzRhQUV2aGdzc2VpdExaWGZwaDlOaFov?=
 =?utf-8?B?Q3JVVXhoK3dmbHMrTlNBdUlCdHNOZEJWTlJGd0tUeDdvQjVIajNDRXo4ZWF0?=
 =?utf-8?B?d3ZsQ29NRW92cm1XbmtHbURyOTlMTms0bDJhbjJ1d2JTYUtDVVFmWjAzUlpO?=
 =?utf-8?B?SXNGY24zbVArRUVEM1YzRnVHK3ZwblZqdnM4V3FVemhxRkNDdDFobGIrbnJv?=
 =?utf-8?B?WjFNWnZzZHNVc1VlNGU4T1ZFbExGdWhoVFJlZ3lBMTdvei9xWTd0QldtUG0z?=
 =?utf-8?B?a3kwUHZoVlRjSnJPWkRPMHVjNlRuVXFHcnRIWmRRM3hnTGV2NkNqN1NVcml1?=
 =?utf-8?B?TjdvamJTdTVFb0hpcnFKdWxaOG1DMHp0UWREbGNId3JkK0M2Zkg3SE5rMFMw?=
 =?utf-8?B?YWFJWVczcSt1cm1FQTVrdVN3aG5ua0UwbUZaTmFTanBwdVFMcS9DeVRtVmVR?=
 =?utf-8?B?TDFEZXdiZmNHd1lKM2xtdzJuQmpWMHNTTHJ4Q0dJRDB3b2pzSlJmZlBPWFhU?=
 =?utf-8?B?cXRiUHB3Y25URDN5TGcrSHplQUVDVWdmMzh3QUFjVDdkMVRNMWJUSXdsSWEr?=
 =?utf-8?B?emZtTjlDdllQMTE3S1pqVlY5RVZ6dHhaQTNXSHVHWGhQRERJUyt4Y2NzYytH?=
 =?utf-8?B?NUxZVllINzZJN3ZqZHpDdGNubzFTU05pNzhiSnRHa0pCRWsxRzl5a0NUb3BR?=
 =?utf-8?B?a1BjeDBUK1FLdVpScE9tTWRkRHMvSTExaVdmUEE1TXB3OTZldTBoMTFhL0FT?=
 =?utf-8?B?bkVoN3hOMzRtckorbjc0Z2FMWi80dDNyUGhDSXlrN093ZEtnQkJvSHhBcm9o?=
 =?utf-8?B?VzhBcStFUHhYbEVQcHgzUys2dkNrMXMrclVEdkVaMHpBY1I2bEdNV2l6Tjdr?=
 =?utf-8?B?RmlYamZnMy9ZUHNHWEdZVDVuNWJFekI0NVU3Rk9lNGRFUnAvQmQ0V0hRNy9B?=
 =?utf-8?B?N2VYcUJiZkwrU256TFQvb09Ib0huZFRMV2NoeS9IWEt2YUd0MVdiblJyRldI?=
 =?utf-8?B?cHB0QisxRlU2Q2pPakp4ay80Y2poQjVPelc3YWhDbHJQTHpheExMWm5uWkY5?=
 =?utf-8?B?ZGZEbGcyb20rcjJKK3JFR3BKVTJCdGlKRUlKQ0lGdXNvZDdDMnh3VXV0V1pD?=
 =?utf-8?B?QUJZaklLQ0VjSzNSS2M1dlN2em5RaWZoNmtxUkFQc0JRamRNMzBTQjJSQmFU?=
 =?utf-8?Q?xFh+xNlhbO1T8YRUPjURQO/1V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5a6757-2ce3-4cb9-d25e-08dd1e76fb64
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:44:13.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGKWOxrYVAsRwH9lLpu+1J7xse79So8lVhmM1P15Xf9fXj5QtCXiMHFaaoPRoxo0F2TNtcydt2USQctk0NYFGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11054

From: Peng Fan <peng.fan@nxp.com>

Introduce "#access-controller-cells" to make OCOTP be an accessing
controller, because i.MX Family OCOTP supports a specific peripheral
or function being fused which means being disabled.

Add the i.MX[95,93] OCOTP gate index.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |  5 +++
 include/dt-bindings/nvmem/fsl,imx93-ocotp.h        | 24 ++++++++++++
 include/dt-bindings/nvmem/fsl,imx95-ocotp.h        | 43 ++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index b2cb76cf9053a883a158acaf5eaa108895818afc..c78e202ced22f1c278f7be827b71ba434832d2a7 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -54,6 +54,11 @@ properties:
   clocks:
     maxItems: 1
 
+  "#access-controller-cells":
+    const: 1
+    description:
+      Contains the gate ID associated to the peripheral.
+
 required:
   - "#address-cells"
   - "#size-cells"
diff --git a/include/dt-bindings/nvmem/fsl,imx93-ocotp.h b/include/dt-bindings/nvmem/fsl,imx93-ocotp.h
new file mode 100644
index 0000000000000000000000000000000000000000..6ef525173845fd4ee0e847cf5a17e53a14f71362
--- /dev/null
+++ b/include/dt-bindings/nvmem/fsl,imx93-ocotp.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+#ifndef _DT_BINDINGS_NVMEM_IMX93_OTPC_H
+#define _DT_BINDINGS_NVMEM_IMX93_OTPC_H
+
+#define IMX93_OCOTP_NPU_GATE		0
+#define IMX93_OCOTP_A550_GATE		1
+#define IMX93_OCOTP_A551_GATE		2
+#define IMX93_OCOTP_M33_GATE		3
+#define IMX93_OCOTP_CAN1_FD_GATE	4
+#define IMX93_OCOTP_CAN2_FD_GATE	5
+#define IMX93_OCOTP_CAN1_GATE		6
+#define IMX93_OCOTP_CAN2_GATE		7
+#define IMX93_OCOTP_USB1_GATE		8
+#define IMX93_OCOTP_USB2_GATE		9
+#define IMX93_OCOTP_ENET1_GATE		10
+#define IMX93_OCOTP_ENET2_GATE		11
+#define IMX93_OCOTP_PXP_GATE		12
+#define IMX93_OCOTP_MIPI_CSI1_GATE	13
+#define IMX93_OCOTP_MIPI_DSI1_GATE	14
+#define IMX93_OCOTP_LVDS1_GATE		15
+#define IMX93_OCOTP_ADC1_GATE		16
+
+#endif
diff --git a/include/dt-bindings/nvmem/fsl,imx95-ocotp.h b/include/dt-bindings/nvmem/fsl,imx95-ocotp.h
new file mode 100644
index 0000000000000000000000000000000000000000..2d21d1f690974d0215c71352168378a150f489af
--- /dev/null
+++ b/include/dt-bindings/nvmem/fsl,imx95-ocotp.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+#ifndef _DT_BINDINGS_NVMEM_IMX95_OTPC_H
+#define _DT_BINDINGS_NVMEM_IMX95_OTPC_H
+
+#define IMX95_OCOTP_CANFD1_GATE		0
+#define IMX95_OCOTP_CANFD2_GATE		1
+#define IMX95_OCOTP_CANFD3_GATE		2
+#define IMX95_OCOTP_CANFD4_GATE		3
+#define IMX95_OCOTP_CANFD5_GATE		4
+#define IMX95_OCOTP_CAN1_GATE		5
+#define IMX95_OCOTP_CAN2_GATE		6
+#define IMX95_OCOTP_CAN3_GATE		7
+#define IMX95_OCOTP_CAN4_GATE		8
+#define IMX95_OCOTP_CAN5_GATE		9
+#define IMX95_OCOTP_NPU_GATE		10
+#define IMX95_OCOTP_A550_GATE		11
+#define IMX95_OCOTP_A551_GATE		12
+#define IMX95_OCOTP_A552_GATE		13
+#define IMX95_OCOTP_A553_GATE		14
+#define IMX95_OCOTP_A554_GATE		15
+#define IMX95_OCOTP_A555_GATE		16
+#define IMX95_OCOTP_M7_GATE		17
+#define IMX95_OCOTP_DCSS_GATE		18
+#define IMX95_OCOTP_LVDS1_GATE		19
+#define IMX95_OCOTP_ISP_GATE		20
+#define IMX95_OCOTP_USB1_GATE		21
+#define IMX95_OCOTP_USB2_GATE		22
+#define IMX95_OCOTP_NETC_GATE		23
+#define IMX95_OCOTP_PCIE1_GATE		24
+#define IMX95_OCOTP_PCIE2_GATE		25
+#define IMX95_OCOTP_ADC1_GATE		26
+#define IMX95_OCOTP_EARC_RX_GATE	27
+#define IMX95_OCOTP_GPU3D_GATE		28
+#define IMX95_OCOTP_VPU_GATE		29
+#define IMX95_OCOTP_JPEG_ENC_GATE	30
+#define IMX95_OCOTP_JPEG_DEC_GATE	31
+#define IMX95_OCOTP_MIPI_CSI1_GATE	32
+#define IMX95_OCOTP_MIPI_CSI2_GATE	33
+#define IMX95_OCOTP_MIPI_DSI1_GATE	34
+#define IMX95_OCOTP_V2X_GATE		35
+
+#endif

-- 
2.37.1


