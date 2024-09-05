Return-Path: <linux-kernel+bounces-317775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCE396E3A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E66E1F27B81
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC919EECD;
	Thu,  5 Sep 2024 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZkBVqt5/"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013055.outbound.protection.outlook.com [52.101.67.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9718FC92;
	Thu,  5 Sep 2024 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725566801; cv=fail; b=rOzqSfIi0SpmJAZ6A9/A1SCzv2K9n/0roYQWcB4Jg4QjxJ6GtCDggqXltvAXXXTNYaZdQCi2zwP7bUDL8vhb21yH85LQWBXbgTfds1dwi2F3wpaOeAROSRx1WMTn8sVhm+slIOdkwUJcyb4mo1YbOAJBGVu9BY6DyTgt5Sv9mO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725566801; c=relaxed/simple;
	bh=OPMEgo/PPVAH3sDsMsvf6tFyCZJh0Wh9SpXjFlyjVQQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bULBiR9pCqDIbP9lexKczOJ8sTWhBCLO8k+rJHtpWEnTHHigV6VY0tEltYQGCb7fW/gooArnKP84Zo9YIZ76oESFNLx2w3XH8eGIAnAfo9JPurfgNMq/blHdJlsIC4aAC/RKvOVn7q1tXtdMkibxxCFcx43K+Y5GgS7aOwp0Auo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZkBVqt5/; arc=fail smtp.client-ip=52.101.67.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MguGzlIH86OqN6O21ArpzAMR0hPTdHf14Knm35InYv9pTw+eye1xoU5zY1XHuIyySbQgAFrYv77knOm1T6V+VPpgX7cMTG3fnDJPrau8fWiTVh9PovUnNPgJmCyNxMLUlXw//Fw1S5FciidE3GK/DNwMMOAmr0plCgh1D2n0Mca7qOmf5VA4NMGEremlBZgzY+7YuVXJQTtbdZllFoFrWClmtF4vW8JHu6Upvoty09sh2EHBukv19G2egEakAvJdYIX2yaf7623L5dzjtXiajvjPSeIfKYrtVdk4I0HqdGyvWEa1viJp2GdRjLzD8n+DTrg9Bvon7D8ky7+906xv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FGgaU9IlyBHq49XF9k5+aS5ZI1cv/6PvMPvqC36+xQ=;
 b=UTq41jIH5diF7JiyOFeDKZ6B5YhY6tyz0ONblJzQns0WoCNXbPCThcg3eAB+PQWs4aSLYNw8QeEt4r5YqLcTDUtVKJVprcWTmFdVQ5Mw+Vy+2Zcud9Y8jfSTDxyMzX64m4d3c2WhlqQ2ERCtEkZBv8rAc7N14zakxIVB8sORYeDzw0ABhlhmfgd3sUPeBbDILaTUgnv1iYk3Uduz9WfidY1+Pd0wtcjtYaE/LlA8qDYGbv/5iYaQxMhTC6RT/kdXgCR66t6qGhzPSse6FDfF2NQjzneNfLQdlOpA71FBgMl13/3lKEhGyO0383EGFh7Zjt8OzuIc/ielCmxdbeNb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FGgaU9IlyBHq49XF9k5+aS5ZI1cv/6PvMPvqC36+xQ=;
 b=ZkBVqt5/88M/ebaPJ60Vkq1EU0FmCfwgtICUNj4M/7v0wLgtVjTbrRsPtc0gm84opcaHP7MSCq8xEWCUX8BZtKZLy1IkXOlHkIvalUMB5Ya3ksa69YF9ya9zV/h8aLTLXNPe5GSGrU7I80Z8YA9s0ysWn4xU97i4e/bpexLRKLvi9IACH/iW60baEELtKhT7OtOUpM3U13KWTCx1+cbhui7LYCGx69nOhEyqXmzv8+eAs0SHs7xBABOj0OnLav0sqx8wDZ2NacfX6WjLXFTGjM0zdiL6HYcu/MsncSkfOv5OofzckDVOnRwAWx1VE7CbOq9RMwqG6Hg/oCIy95zaiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 20:06:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:06:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 05 Sep 2024 16:06:19 -0400
Subject: [PATCH v4 1/3] usb: host: xhci-plat: Parse xhci-missing_cas_quirk
 and apply quirk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-dwc-mp-v4-1-aedaeacf0556@nxp.com>
References: <20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com>
In-Reply-To: <20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725566789; l=1035;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OPMEgo/PPVAH3sDsMsvf6tFyCZJh0Wh9SpXjFlyjVQQ=;
 b=xqSq/7oG089GSJzbz5BztXFenx0U4E7yMdF0beO8t0Quo3K6tigT/LvbOMFZxI7hoNaB+7jjL
 kbrakPLS7kEDkwM12xMwlDXekar3PP6WxUiwu807jgT87zowT9Lke1Q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a3f851-bea2-45fc-7566-08dccde63f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjYzWlFpaXRkVmJpUFBzL2c5TXozbkVPR3BQZ1JQMTZkam1ISGpWMkR3OGFU?=
 =?utf-8?B?d2lBLzVqZzI4UDhXemdsYmtDS2h0dlQ4cFdoT3FxUVMvZnVQRHI4allONDQ2?=
 =?utf-8?B?NWl5UXhiT2RYc1Y2cDE5NGNMd1lDaWNvRy84TndCMVVZRVEwV3J1WXZpM0py?=
 =?utf-8?B?dW9UdUNSOVNFdmc0TStiV3BaNTRmd0pIbDZ4cVZHQ1QyOVlHaFlUVHNKb2Fi?=
 =?utf-8?B?VXVMSEtpQ0V6R1NKOThuVU5xME80SlZrb2owckVvWWIyUW1lbEZxWmVKc3RJ?=
 =?utf-8?B?V0wrc0VzV0lBejZ3TnBEK25BNXpoSkoxakJGaGlERy9UZGd4OWVFbm51bUNn?=
 =?utf-8?B?a1crUlFDUHVSUjQzb0srNDJNc1VvMnNHdWtQTC8vc2lhVDVKZjZ4VlRGcHB6?=
 =?utf-8?B?TDc0YmMybFc3b1F0S3Q5eWlEZVJYWS93NTFuT0ZXYUtGRy8yYmF5V1JSM0NB?=
 =?utf-8?B?dGliQ1dPc3loQlgyaVNoVUE3OEZQbG9SR1ZQblRBdUZQN3NmTnByalU3c1Qv?=
 =?utf-8?B?d1p2QXJHdGNyVmNLWnNwWkozNk4rOXRRcWlQRDJEajJLYlRFclV4ZnBXanh1?=
 =?utf-8?B?M21PMi94V1Y5YU1RQ1ZzMnB3TWxDaEVjQ0NrTjZqQlQ3dFlwajRXTmsxWUZE?=
 =?utf-8?B?bHJqZWErUG9LYmlvZnFUcHY0UjUwaTkxTTJMUit6T29CZ1JteWtjRTgxVE1X?=
 =?utf-8?B?VGJCWjErc1plMnZiSGs3TC9pUm5pQytTTlRUWHFhdXRnT3BHd09hR1VoM0lU?=
 =?utf-8?B?dFM1eHJ1TW9TZFJMblRScHRZUUo4TDBJdWtSZElVMEFyU3Q5RjQrb1M4WHF6?=
 =?utf-8?B?NGNaSTY4K2VkeFFiaGtGK0lGbS9lZmhzSlB4dW1hbUtLOXpsN3NoNDBNSzdw?=
 =?utf-8?B?eHQxK1kvZWhYMG9lZ3NGR2kxbHRsaVNOZzgyVXBqcGYvR2UxcFY4VFhUenFj?=
 =?utf-8?B?MXV5N3pEa2ZucXRIT1NMYitCMlphdXF0RVlEeTlEdVFFc3VkVkxjV25Vckcx?=
 =?utf-8?B?cU9xYnV1WjlHNnJVQkhDeUw5bTVHR2NKZmpic3F1a0RVZFRnazhjanVXTEZW?=
 =?utf-8?B?QldJa0tldlRCcFNoVlhpdDBJOFRXdmtwL0hJdCtId3ZQNElZaXlNbGRRZ2t0?=
 =?utf-8?B?RG9oRFVYR3BGQTluM2hjUEZrS1RKNUtjR2JtYzZTZDc1Z0I1RHgwanpVeFF0?=
 =?utf-8?B?Q3JKUUY5UXpFU0E3cFY5SjIySi94SUh6M2JKOVpOVldoOEM3NGRVNmdrUUdz?=
 =?utf-8?B?bUYzQ2NOOUhhQlorMmsyZ0RDQ0NSaUpYaldFeEpjdjhTVmlKTlVqVEUwQTNs?=
 =?utf-8?B?eFlaUkk5YStOeUMzNXBIMno5QUdwQW16Qnd2ZzR2M3ROeXBJcXliUTRHcDEr?=
 =?utf-8?B?dFEzcjhEaVIyUmlobzllS2hNSXQ5QVVZZi9zK3dnMG1jc0RDNFJvTVZjQW10?=
 =?utf-8?B?V1Q4U2ZodEhLL2JUZEZNQU5xWHhVeDE2NmNOZms5NGNsWTFaT2ZlaUh1OE90?=
 =?utf-8?B?TEFKSDJpMjlFbDN0czRBSWlrQXplUk5FK2VJT0Nyak5pTmdZeGZ2RDc0ZHJB?=
 =?utf-8?B?UFZrQVJ5UkVFME43RjZEd3BvS3UxVmVsNHRGUkY2R3lIMmEraEdIM1Mzc3Nq?=
 =?utf-8?B?UzRUMXNYNHo2dWhJbTBiY0d6WDkzb0Zneno3YVdYNklHKzRoQVdxMFJUZjIz?=
 =?utf-8?B?ckprNnUrVEZFT2R0RWhCNmQxaDdLY2FlaDJjS0JCOWYydDhxajNoNXluZ1dM?=
 =?utf-8?B?SllzMTJXT3pRQ0NGOWxRWmFZU0l0MWFuQkcrYkgrRkh1dWdpS2dSczI3aXh1?=
 =?utf-8?B?WXlVWVJESzFaSXZJd252NGFmaElROWFtNHUvZFFveVhseE9HaXIyc01NOVBD?=
 =?utf-8?B?anlmVWZDdWVzOXpkYkxrZlFSbFdqVGRiSHVKeXRLbWNOUlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGFBN3dBRDU2UlVZN1FORDdQUE1NeGh4aDRqT0FsSG0vbXhoQm5aaFUxbVhR?=
 =?utf-8?B?bjF5NjdCaWJDbEFkVVR1S0tmTWhweWhMNElhL0VsMzNoRkEyVllEdFV4VW82?=
 =?utf-8?B?Z0luLzkyNk5PaWxXUUtPSjdQR2gwY0twYUFKMWE5K2FLeGJpNWFvRUpTWUxM?=
 =?utf-8?B?YWJEOS9LWlBHSDR4MzFOL1BlVVF6WXVWTWpFV3N2VWtWMS81VXg1aXgya0J6?=
 =?utf-8?B?b2RBdzROWlozZVV4emRLN0QwYzdmd3ExbVZRUkpuUEJDNm1kb05vUWZtcDB1?=
 =?utf-8?B?ZzhsTlV6Rmtlc2FXRTRxYXZFTFVaOEJ4TlB1YVhpZ0JubGh3bVk4c2Z1am05?=
 =?utf-8?B?ZFJhV05wbys1ZDJncUo2TlB4dEFTR0hrS1lpV2pOSUw5cm1sMjRrZ1dlZUNr?=
 =?utf-8?B?VGRyUWlPQ3RIVEFkNnJNWnZKcEU4UWorVW9MeEJCaXVhdnRyN0ZUWGZPM3BT?=
 =?utf-8?B?U2ZYclhhUjl2Rmdxd3NPU3Zmcndua2ZMbHBIa24yZkMwUmtRdVZHOHdGdnRO?=
 =?utf-8?B?OVhXQ1RmekxDSmZwTVZYdTBPWTlFcGROSHBtZkUvbmVYQ0k1Wk56UWJwaEdh?=
 =?utf-8?B?S3VQWS96K2VJbng3MkNkMUtwejlmeHpPV0tEZjNJZXM2S0hPM0NPeHBzNWFZ?=
 =?utf-8?B?dThBVnpyY0gydG96TitLM09GaGdHdmNlRE9kUUo3VGtETk1PTGFSdGtTaWU2?=
 =?utf-8?B?WFVDZXVXa0lsT0dEWlJyYjFjb01wZXI5aWROb2N5OEplRUw4YjBWcUNCamlZ?=
 =?utf-8?B?L1FMNUdQTVVWdis2UHhDVnVJRUFJc2pLeVliV2VYT29ya3pFVTJqRHp3aHZT?=
 =?utf-8?B?Rzk4UG1pQ245K0JvOEdoUVdxVjA0TXQ0TGJWT0FmYWNVL2NuUVJOTXNmZGRz?=
 =?utf-8?B?R1BRZWlQTVBqQXdMTlZRWkRRRHdSY3FRUE9xSWFtYm10eEVVZmlVYTBJL052?=
 =?utf-8?B?QnhDUCt0Z1psWE1sS3Z0VDE2a2Z5WVJIa1NWeGtiay9hNk5GYWFlM3Fvazlq?=
 =?utf-8?B?ck5OcU9qYlRYNlRxWmcxRlJKbFQycm1DQlU0Tm5LQ1lqR2RlZ202THZNUSs0?=
 =?utf-8?B?THZvWWoyeXhNaXh6WTdwc0k5cHZRb1huTUp0MVJsQllQWGFDUFRDMVFhckVy?=
 =?utf-8?B?ZUkycGJuMmtXcW5QRk9CUmxiZUhyYjY5SDQ5cmVlK2MzdVkzVzk3L3VJcis3?=
 =?utf-8?B?N2piKzJHVXZkWlduWG9ESFlFNDU4RTJlcmdRbURvbFh2TmVKeGdFOUhLT0Z0?=
 =?utf-8?B?QllVR1BiVWNNc0ptUnlTelVVZlpTNXYzVmlFMTEvODliRXI5cVQ4ZkduR0No?=
 =?utf-8?B?QnhCVElqY1BVY1BKN1hubktWdzg0V1ZLN2daWkdMTHUrWkZaZ2hxQmFJMEow?=
 =?utf-8?B?alk0L0djWVVpZzQrWjU5WU1rb0U5K3YwOTJOU2lRR1FsZUY4dDJLanYwQzY5?=
 =?utf-8?B?bnk2VjlMdmk5S3NSTnpEQzNRWFBGUUtrRXVmRFd5VzRmQk11LzlFOG1PeG5V?=
 =?utf-8?B?WUpTZDVQMW5zTWJwSEF4T0FuOUFQZEVCc3lMa0d3UkNlY2ZuOENpaHdqRVUr?=
 =?utf-8?B?MEszcjRLcHJxLzl3d0ZzcTdyRWJHUUt2V0tYWE5ONll4eUFTVFlYaERqNzE3?=
 =?utf-8?B?WU1BRzFrbUt3K3AvSSszYXBVNFI1dTRkTEhiM3FmNHJnR0JHTVpBaEVpckg4?=
 =?utf-8?B?QTQ0RGlOZUxYZCtzS0VqbzM5TXhDUEpCMi9rQ2VncjFCdE1sMEtvSUNoNnpX?=
 =?utf-8?B?K1c5V2Z2SUF3Mjg5SmxrL0gzUjNTUkhvNG5YRC9iWHg2bVJYSjBOejExVmZB?=
 =?utf-8?B?Q2wzZHo0RU9HUVl6aGk5SlIwOHA3R3dNemk4RGJkOWhLeWwyaE5wK3JjdGVT?=
 =?utf-8?B?MmVRV0xXT1NFdm4zVk5pWHdNSHo2aDRDN1hiVnNWcFdJczNmWk1mVklCV0Nq?=
 =?utf-8?B?ZzA0dkwxUGl1eEIyVXhwS1lRRmNoSzhkZGVmWHJLYTJTdDVIVVZIVWwweVVS?=
 =?utf-8?B?VTdvSWJkazAwalhCanBHL081VCsrcVd0bGZFUzdtY2VKLzhvSm9MUlNpcGZn?=
 =?utf-8?B?RHd6b3pOaW9tQVhXdVdRL0tINXZOd3U0M09NWU9GR1NzZmREUnRxNXhqdFRv?=
 =?utf-8?Q?bRLvt20P4WF8V0i71Fn0tFG8e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a3f851-bea2-45fc-7566-08dccde63f3e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:06:36.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAgqeMukva8U7CZ0atgeM3R8L4R32vjp2oxlG3N3tl6OfLgCtZiLPgSJ5M3JxQebQbci3cbEOO0X/goCI09ESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423

Parse software managed property 'xhci-skip-phy-init-quirk' and
'xhci-skip-phy-init-quirk' to apply related quirk. It allows usb glue layer
driver apply these quirk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/host/xhci-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 31bdfa52eeb25..ecaa75718e592 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -259,6 +259,12 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "write-64-hi-lo-quirk"))
 			xhci->quirks |= XHCI_WRITE_64_HI_LO;
 
+		if (device_property_read_bool(tmpdev, "xhci-missing-cas-quirk"))
+			xhci->quirks |= XHCI_MISSING_CAS;
+
+		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
+			xhci->quirks |= XHCI_SKIP_PHY_INIT;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}

-- 
2.34.1


