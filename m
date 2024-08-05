Return-Path: <linux-kernel+bounces-274954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9287947EAE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748D3287E53
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F7B15ECE3;
	Mon,  5 Aug 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YN4gV495"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C615DBBA;
	Mon,  5 Aug 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873035; cv=fail; b=uJLiu/9fqiH5QzRrldwtw7F+gU7JvgIKZgCeNaf4bgPVCIc4ohxOugVqEufc5FmqncElxBKfQrksjWCLW5i06feYgKwEN8Yk6VSw7dUoKS2OY3ktO4uDs8O9ICfqWCRCf/CwVJGAkzkBs+cTYdARs2pYIBAjxo6XE4TAE9ava/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873035; c=relaxed/simple;
	bh=hT0OWCJA6JL0xCBifx9HxcQ7HPBi4gGgZ4apa2j4fpU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Gzs57i9H5TybcO5e02oj6RLSH1nJFDmc4vA616W+y5Bg8YoVlRF4cEzZbuBXPvMmg6xCJhtH7J9oUDzve9BiYgQyYj+HOH2qnQuO/4z/X24Aax9oDULVL9/Hi4w3+fq10VmpJjYfUqPUKnLCjZwI0FPLaZlEJnHxEz8orwTvFsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YN4gV495; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoXETS+aAY/Jams7Qi5h7CaUmviWxmNU+rhdh7Y8Ko/ofyXl8Gq/+rTRuoX0Tm2sHw2eIE6B4AFryd1sRgnxAchP7pJWsuLAa5jgZyG8G9SslT0rHHFrGiIV/ZSzCWlzUnPthhL3gA6qAkMVKG87fI0mTeezjaUZQiy+vfCTEgrN4UoV415/uiylVi8ukC0AdW62eg6JwxF1uGgA2R4ibY4rJxPyVXb1AM8zdSvDaG+EYO90jdcIv2AKcR6yEHYPVe/WMLa9TzJiKaC9xyxjxDK4oRbBDNzJphIBFnBmfk2Xs0EwFmhFffBctWKLb4oFptAgey6DZrO+/poR+nLuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt1NNvyDVw8E1p3/A0XVIr+NswrmXJdp3OWjzLeb8MY=;
 b=SYhQ7sRY/txTjQ+rTGU08a02xhyigNcd3uZ7qkGr/KrXwjcNVzb+So2totOl/SE8bSYNO72TGAqGZ5Av+XknDwDC5VIn98w77FTVvFFeHlYKo5lK/3aKkt2GbSAb5CU80UVHN5mVAr1rHoRYvvijHOKYBW+3LR9Ahq02eMkZ/nMW5XtGzcE7hKJe7He9woRKZX+Us/p89mDEvYphiW3l0gaWs4vYDLXxi30e3lbJKj+C/UBD0GF2TscxyiGNKLrq7Rrb23ybsFR0icEbr7i7XZamCS4EH8hiyiZgW+KBCcal4X5rIPK8RxYyZZQiR5OJt//OZJ9fZupAinRC+xN2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt1NNvyDVw8E1p3/A0XVIr+NswrmXJdp3OWjzLeb8MY=;
 b=YN4gV495bNkdJLjnO76emimQYAzR2Dj+Uxi8Ne9ANdp8an20AQoQXbDKbDSJsXH1eISw5q1NyLyfSBco8bctImE9pNvhT0/emVynaHYE2Loryg1akx6G0Kn97dOMtNL4jHCuqALo2kQYWHaIU0vewVOr1yBBp2WPnzdo0Cho+wTsXqoCOHEJSqQMMfZWb335+7dTuLiKzpi5Jcy5zp+5LCKD5zn/VfTcXscW5BBgKe63GpA/+bT+edKay2Tyt79E+diZVKQuDC9pJ0SDDB0boJjRqF83unDauX23eWZ3iq5AWg2WvCbLzg+k86DSCQ0rzk8cIRxOFzhcCY8XBjBu9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Aug 2024 11:49:48 -0400
Subject: [PATCH 6/9] arm64: dts: imx8mp-data-modul-edm-sbc: remove
 #clock-cells for sai3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fsl_dts_warning-v1-6-055653dd5c96@nxp.com>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873011; l=919;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hT0OWCJA6JL0xCBifx9HxcQ7HPBi4gGgZ4apa2j4fpU=;
 b=BjtD95OAxDbe3aM0xfcV5Zb3jmzwpS8BlUfPtS7RU78K/qs7oY24vryFlz6yObWXGxbdAwkYP
 CLHhHERGnvwBGt0j6CB6I4noTKi5Wr+KD6SvHpPVsmhkdofJNA+9gVM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a685ba6-6b7f-4a2f-bd50-08dcb56652bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEIwL0FRdU51T1hmbHgvSnNMYVhBYVNZeDJ4RkthbmIzLzBSQTk1VU9rQzBj?=
 =?utf-8?B?S011Vm0zZURGK0REQzUwUm9oR3NvR1dqMHVlQmlpOEgrSllzdGtNQVhSSm9R?=
 =?utf-8?B?WDdrZHR2cjRWYStCTS9JRDBQYnQvUWZZeDVxazRsNkpOd3FUcEhLbkZhT0wx?=
 =?utf-8?B?T1Zycm5Sd0dFVURKVDJrMWZ6dTlab3had01XL3diSGVScEZ0MHU3Qk9Ta0Rj?=
 =?utf-8?B?ZkZiTnZkQzhUSU00dmh1cU43Rm1PQnp3NXE2VTk5cXhzbUFkaVE1QWpNcDNl?=
 =?utf-8?B?TGhqVlFuNGxVUkNCbG0vRkxBM0JxWGVaVE9VcTlVT0tMT0N2dmR2UEt5Zitr?=
 =?utf-8?B?bVcyN2pjVGdzWDI0Q0hDZ1hudFlUT2l5a0l4VWpBbElHeW5sRXhpVzBvRXRv?=
 =?utf-8?B?WEJKUnI0K0NiZEluYXFsV0dLRFBXZEFvV3lWcGN2NlhSVDE2SlFnK3RERlNU?=
 =?utf-8?B?Z0tHWFc1WU8ybFVCUGhoMzB0RndDaHpyVmFlcjFrV2EyNVZDeUNVdkRTcDdh?=
 =?utf-8?B?M3k1NXBaOUd6U2ZGbUVTa1NyUnF3ZXU0SUpBQVBiRXhuQ2pNU05qUm50M3Ax?=
 =?utf-8?B?U2xHZ2lob3ozL2dFMzl3MzU5WTFhK00wSWcvWmZZa0hiWkRuK0ZIdGEydU00?=
 =?utf-8?B?Q1hLclNWUExYaVhha0UwYXl5UnplZGtTbmpkZk1zb2ZBZnF3eURlTzZNNThx?=
 =?utf-8?B?b1kva2VuQzVLSUNuaHRXanhTNEk5amxKV0hJZUpLV245TExpV0dNSnQwVDkw?=
 =?utf-8?B?b2IzdXRLVkNaN3RvSUFBdDZiVUFQK2N4RzFqNGlrNkNhSnY5YzM1NDdmVEEw?=
 =?utf-8?B?M2pYbVl6a2pjR3d4QXJobDVFWjVVS052UUxJSFU3Ukt1ZXcxZFIySjZwaEdI?=
 =?utf-8?B?S2M4andjWGhjUVoxN1prM2FwSk9USTZBdWxuZndVcTNNaVZ1czNiZTI4eWtv?=
 =?utf-8?B?YU1PcFZ3Yy8rWlFYUnlDWTFQRXg1WGRmcFVWbW0wSXkxSGtyYXVjMEVFeDRn?=
 =?utf-8?B?SXVHOStVRXZ6enJaZEJ5K0N0VjdHK3kwb0ZpS0phT0lDOWJWWWZPZDFGUVN0?=
 =?utf-8?B?VG5oYkhoSWEzek1uMURMb2k0RTQ2MjRWcnZMM3E2ZDFvYUR0a01qOE1XcFNt?=
 =?utf-8?B?RHNvKzJlS1ZhYzVRK1RTMDUwUmxEblVNNURmK2NOTm5WZTJZNmJ1NVlvUU9a?=
 =?utf-8?B?MWUxd0NTaDBuaC9PQ3REeFBlUE1vNUJXTUFEbTljL2huUUl6YmdDaUZ0REpo?=
 =?utf-8?B?Wi9TdDJsS284V3MrUGo0dmhyRndXMXVvTXluaFdoNjlLVGhHbGpZM2t4OEVD?=
 =?utf-8?B?SzF1VFM4ZjkvS3RhSXQ1cVFmMG9mVTlKU2h1OHVjNU1tZlkyNGRGMEZHamlU?=
 =?utf-8?B?bzlDRnExVXhBRVQ2a1pvdW1ZbmRZMFJFQXQ2cjlNTW81dnZKdE1jN2o1RStR?=
 =?utf-8?B?ckhHWmpJL3E2VGVWSXIyckg3bE9lalJkNTB1ZTZDZTFpU2xWbHF2TUhQc095?=
 =?utf-8?B?dFhodDJDaHVLVHRTcWhYdUZQbWI5MXIrc1VWSkhxSkpURVpaVmJNNmJSU25M?=
 =?utf-8?B?QUZmWERFLzQ5bUlidW5MZmcwaWNDcHdvaWxIUWJJdEc0WHdTdzFpc2hUUFlz?=
 =?utf-8?B?Z01xdG1MazMvRUlibFNzWTNjb0FEbW1NMVBobm9ITUw4eVB5YTFoMTdUMkpz?=
 =?utf-8?B?OGdlcm9Pb1FqeFJTOG9uNUljbFBPa0t5L21ra0RSbHBTdkhpMVc1Vk5QSUpQ?=
 =?utf-8?B?TmhMTEZJQzlKRCtYTGpUMnlEVVRwZld5RGRoYSt5eVFYd1gvZVVKb29yUzc0?=
 =?utf-8?B?N2xCbUhTdVdtZW9CeWFoWGpBQWxrQWl2dnFsUWtlaFY4Y2ZmNUhkamFQMkpP?=
 =?utf-8?B?NXpsWGlnczJPeVpzQUFUWVNoZDN5cWpwcDJ1S0xMdlB3Zmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVB1YWo3NzUwVCtOc3BOVWlxbWZLNHRtL0NRRzJsQmV4U3BPTnJ3bnRVU0NN?=
 =?utf-8?B?UW11NzdtaS9xS1hMQVFTdDlJWGVMaGg5ZUdBa0g5Ty9IbUhwWUlKMUpRaFVE?=
 =?utf-8?B?Q0syYmNNam9RQmVIUGNxNDMvcFZwMlExK05JYk9VQVI1RmxIUjY3c0dXMDFV?=
 =?utf-8?B?MHMraStIeXludDlpWGhWUkVIY21XZjcwaWtacFZBTTdhbVE1dWNOSDBzSi8w?=
 =?utf-8?B?Umhla3NmOHdHN2l2MWhRNlRUck9ZenBXcEhFV3daTXgyMmo1cnpCV3pmK3FM?=
 =?utf-8?B?RitPZ0U3MkdCZnNFemsrTis1dUhlSFN1d3ozNlpkKyttbHVaZDFQaTNmYzlF?=
 =?utf-8?B?Rzh6VkpzK0xEd3NCaU9rK0RISTdTWFNveUVhR2d0Y1NpZmZldzlFanQ0bVA2?=
 =?utf-8?B?LzlYSWV3Y1dlMVFkYVYvb0I3M0puRHNCT3ZCVXFzZWxwczRVUjErTW9sbzZM?=
 =?utf-8?B?UGRKanhxMlNsakVFeGg0ZUZPSVQwZzNaU0pWeXhaTEdTSGh1Qmx4NVRBcXFn?=
 =?utf-8?B?UDFSMGZTRFRaMUp4K0ROQzY2RzNxZnVYa2JnY05UTjdrY2ZUOG1ycWxxNUJv?=
 =?utf-8?B?dW9lSEZzK2huZGlhYUxhSDVXTnVia3VDbklaeEVMRkhGMHdKNEtEZnB6ZUpp?=
 =?utf-8?B?Q2l1aHJndzBwekMvNEs5ZzhxK2tpekJrSE9HVlA4K0t1b1RTUFBzTHBGRFBN?=
 =?utf-8?B?U3JYVzZEcW8raTQwMUVhWHQxZjVLeEZBQzdKa3NVbzQxZVBBRy83KzU5aWdK?=
 =?utf-8?B?OHh0Qm5kdEo2b2ZXY2lwL3JSdENwbkRvejJVVjY5NXFOZTFkQ2wwaDRHRldY?=
 =?utf-8?B?MHVCS09ZSSs4cXZZd05SWmdxdHpvQk9uamRyRm53bjAxdkw4eFV1azkzMVZJ?=
 =?utf-8?B?RUlQdHNOMWdpaXJ6Z1cxZTlYQllpVmRhK0Y4bGdvbzJOaWRubHFYYU1UNll3?=
 =?utf-8?B?Q2dzS2gzc01jeU13K1BJRjJhWnd3VnF2WGVkT3VvM2ZRKytKemtjaEl4blRB?=
 =?utf-8?B?ZW5WcFUrQ0lHSkoraUwrWlpzZ0ozNW5mSCsvOGw1Nk55RHQ0S3QyLzhLUHlz?=
 =?utf-8?B?RFpabzRCWTFQUUhmeVYrdUpXemRLa3VWWXV1aG9jWmowREd2TFA1K2E0emRV?=
 =?utf-8?B?NE8wSVVqTExIejZWSkhDTjh0Y09qb0Q3WUlZV0F4bmRiZWtZSVBLUXZCOE15?=
 =?utf-8?B?MjhhSHZ6VmZtM085OTZWS3R1NWdsR2NESzhtM2RmV0tHSXRNajNMd3dXT2lZ?=
 =?utf-8?B?TEk3S1lRWll4bUNFWHpOYlFDL3pKQklyRXhwNHd0MEVwSHBxcDRVU0l6cVl1?=
 =?utf-8?B?OStKVFdMM3dqSTN3a3JkTEV4RVZPUmNpQjV5b3k4MDBkc3EvcVRVbkhqSC85?=
 =?utf-8?B?QW81bndzYjVLUGtDNDdPY29mWE5vaWlYYUkzUkJwWWcvL2s3Rm8xSU82emVR?=
 =?utf-8?B?MVpDMGdJUDFLUmNXWThJL1pYTUlqakVUWmhDMEw5YVppaFozZDgwbjRwQUFv?=
 =?utf-8?B?SUEwOHAzY0Faak9JNGRHTFFoR291aW0vd1pMeldsSmtDY2h2QWFEVDJZVzRk?=
 =?utf-8?B?a3JqT1J2Y1BrdHFHcm5mMi9LWm9YaFB2MTFRa1hiZjM0Z3V1akhINE54a3hX?=
 =?utf-8?B?T1V6ODdaWjc5U3U5bG1mQUoxVVl6M1U5cnptZTI5eWZpK3FUNW16YXozNVF5?=
 =?utf-8?B?K1JDSWxiUTY5Lzk2dlFQZk1wNlJRcHRDei9VRW83MnBiQ2hjTDZBMGFpelFH?=
 =?utf-8?B?N09Idi9Zc1ZPUzhobDV0Z245ZjNGbE9KNndET3dieXRHT01mYUFKZjBITWpr?=
 =?utf-8?B?TnRKdWhOZDc5WmFoQWJCMDdMRDNxaVJqUHArM0dqa2dyc2JLN1M2MDArb0py?=
 =?utf-8?B?QXRqNEd0dUMreWlBRlkxYjRtdHJsemNPSVFoNFRTQkRON2Q3ejBBTjhEOFlO?=
 =?utf-8?B?Nk1NZVJaVzdOV3J6QVpoNjlVZE10allrMGh1clFhN1dXcGpDdUZ0SCtFc3Ax?=
 =?utf-8?B?SUp3Q1A1OUh0dmRDVEJYY2wyeXRjb2NIVWRoYk1pVmdEYXR2bGQwMzFDd3pD?=
 =?utf-8?B?QjFtSXJtSzVJTFJ6WlExWktZbWN0V3luWW5pZEQ0NTJsdnlBYWRqTkZwQXV2?=
 =?utf-8?Q?MzZNKSIAwoZAfYD+LbvsSl1EV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a685ba6-6b7f-4a2f-bd50-08dcb56652bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:25.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7o9wnbrgHCniAz/MlnH3g+DwB3ynm65EdCIXnkWeCmbrllA9c7Menr3lErYblBiK4SwsGqTslywm3QHlokDIyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Remove #clock-cells for sai3 because sai3 is not clock controller to fix
below warning:
/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dtb: sai@30c30000: Unevaluated properties are not allowed ('#clock-cells' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index 7e1b58dbe23a7..837ea79741e8d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -499,7 +499,6 @@ &pwm4 {
 };
 
 &sai3 {
-	#clock-cells = <0>;
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
 	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;

-- 
2.34.1


