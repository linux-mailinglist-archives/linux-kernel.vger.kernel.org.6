Return-Path: <linux-kernel+bounces-266310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5393FDFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A051C22798
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9118C347;
	Mon, 29 Jul 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KtvkkIaa"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB21187865;
	Mon, 29 Jul 2024 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279616; cv=fail; b=Occ6gztgfHkrZGUROTfjS5/9tpGBg2qBBxqDQOSnTNV1WFM2vykxjusR805y9V8yYTL1sVf95I22vSxQUb5PsDMIv8M0SKQt86a2Xv7wlpqprxGiCWY3vqsR68vfiKLFbpeSE9HuYVpbtxY0qiUA5fVI1kQrEsHyD7GW8khc+sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279616; c=relaxed/simple;
	bh=W4bRgxCqt+Ga1qGwSWEDe3h2f3qynga3C8vfY1Xce1o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VhWvzw5i7tIcpLFcUkn89Mga6dHeBiLUiV8eQdLL4kNWBjclPfngeQrMjr1SUwfFDfZbZs3osXad89D8N6hwafWpZx8XlFbhZ6hd1iexsLySqcjhYfgDp6Z/XAu7w7u+xZhollx2xVmDGagJmjfcJc9AXYAcFSnvqUmIbaQ3YnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KtvkkIaa; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSfwGKN8pmalh8iuz45a11imgB3MapGQi/14feJkOmtiUT2fEnIPs/WH4unLD4RcqCwPpOkZMKUgZjPfDy8ymq6IUltnFr45v10UBa+ef4V5ZeeUbXvWeMObpce+Rm1/NlDI3xHf34fqVIUvh8mHy7AMquXg5ttZ7URZQAYsTHcMwpHz7xGEZSnNs5D2iH4O+CxrOheijVt0bAsMFaxKZ02W8M44QYYyxU2PBcu5+d3cvhilH1C5VXML8RdyWSvC5fSLmXwGq1ZcCssCH2H4onvRqNle6n5lJcSYW0TgrQaCOEh5ZgLPnY5/bT+TktOH/iwFr7UfGh7UinjV4k1jXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBKOYA0hYcQo3EV1H/1oq+3Pr9yud5lo+SGdBn2wUI8=;
 b=NDwDDud+8mZo2vZkvXL/aiX/rVz6zpnvfXsehlnX8lUN7m1Og8f9Bw80ETYkslTDOfn0mL2C6P0VURhEo9OjRZRkX0qaYMa/yhacDzYFvQsV4xsM9esN9+ii1L95YuqTnMWt0qkn6wLDmTwxgwi1g0zjmuKSNQRFhZqiholHqrpmGvvB96093/kCD+OWhXCWRyGMDF24wSqzxFU/+Ek28CrEqUw03Od3MhRZ9HIUh53snSTPiJxKEoSKuNwE93W1nb2YmD66OfAV/L0WfyoVMEgx4EnAwEJlWIzyp+gxI18izXqug1AISXy5u7uODDA0lTMcyN3ERoRtwnjeeLfiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBKOYA0hYcQo3EV1H/1oq+3Pr9yud5lo+SGdBn2wUI8=;
 b=KtvkkIaacRiakldBNwIRMDMMbY3bozctiIjzEkLvXUruP2/9aEqB+q+I1C7DDU6RIenHknM4VhfIZ3alGyfOi5cRRmoeiMhYfqr/Gi3IDfA3eX+xf0j3+++SaPVNYqpVJGpb9qVFPk4K3OtbspI6lDEJ2ykleVuB0/w9KRna8ltxYvsoFa5mw57aZN/wkctgUft+YbK1FCMIfxDtWE7snoU+2V/VesAY96URgGDUIkxUbMBghCus+gzAtDm0pimzrGKONjS/DF0EzmgoginICHUZzhvkxS1hTqaheMo8FZweFrokDJoOSWrOBQhOY6zJFQbwErHhgOfR2xpfUc7QTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 19:00:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 19:00:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:29 -0400
Subject: [PATCH v2 07/10] arm64: dts: layerscape: remove big-endian for mmc
 nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-7-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=2484;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=W4bRgxCqt+Ga1qGwSWEDe3h2f3qynga3C8vfY1Xce1o=;
 b=4UXkZs6CFI2Or9+oAjNQ79dQtQATSd3MwrxSWv4zEQTCPBAUXaUMuv0iW4m110djhSzpeXYxo
 YIITJ9rtpA3Cb+RIFzyzN5QL9Q1dG3IQ4reilL8rs476CqQD+Vs+GZE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 98209896-cc10-4b5f-0ac8-08dcb000a94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1dlZ1JxM3VxYWdiQm9JdmxkRGc0cXJrakFtT1ZwbVNPNmNaUWQ3VW9pY0p5?=
 =?utf-8?B?ajVXOHdpTHRaY0prbDdhMklUN21DdlNhZjU5cWFGOEZGRjI5Vi81TzdhdzZp?=
 =?utf-8?B?cWJOOFFaVHNISEZtbmVOZmlMRTRIOGtLOFU2Wk5rOENLaXVkdVJML2Vrc2Jk?=
 =?utf-8?B?VUordTM0UTVCN1dNd2FqckZ6aUZZTGRiV1R0RmZtblNFRHQ5ckI1MVJ0U2ZW?=
 =?utf-8?B?c21iN05qSGgrQzcwYmYvcWQ1enBBNnVjWC9hS3dvUVNUdW1sRWVrWENqa293?=
 =?utf-8?B?YWgrQW4wRXQvcnZ0SmN6UmJoM3psV0NsSXVvMEtVRHozNlF4UVdKMC9WUEha?=
 =?utf-8?B?OWloZks4clE0RVRKcy9qbWJiL1BHbVpTZGlEaStDSG1GM1UvSFJrUVlvTi80?=
 =?utf-8?B?ZWw3MzVUaDBlaVhZMnp5TlN3cDQ1Z2ZyUGxxUW03Sm84OUY1NHdva2Uzbkd0?=
 =?utf-8?B?enFXRkJSVElQNTdnQ3UxNFZSb01PWC8xMDVIVzRwc3Eya0pEMGJ4OUs5elRQ?=
 =?utf-8?B?Y2dBTWVTYlZwVndPL2dGVW9Hb0JVYnMxVU5YWTVQNndDSFFvdWd1Z2F0Qldl?=
 =?utf-8?B?ZHY2Uk9kVU5zTUsrdnBFOXlMZFl5N21iNjh6SDAyWHZnZTlkS2RVTEZsdlBQ?=
 =?utf-8?B?KzlqK3NjemhyZG5lVnljeW5Lbnp3aS9Cb0tNM0E3eUV1SkFjaHB5Q1VIbm5J?=
 =?utf-8?B?Tng5MVVLMk1HNEJqVWc0YzFhclE1eGJGcUJvRE5oSkhsZ28rdENSZzJCTy9P?=
 =?utf-8?B?SkUwTE9WaUZ3VjViWDE1S0tCNTV0Zng3RTRjTElUTHNIR0tiS1JkSUdJZi84?=
 =?utf-8?B?T3lzbHNxVUhpQXdqVmN1UzR6Wm9oU25HWDgxYlF2dlAvZ3Y1U2RRVXdvalN0?=
 =?utf-8?B?REtlUzh5T3R1ZWxxSTdxdjhPMnRtMXRYZnBXbFNEQlFEVldhSFNBZi8ydWlY?=
 =?utf-8?B?WlJ0a2owTzY4M1cwSlk0NHp4dVlsbG5tUDd1SHZWWVJ2bHFiWDZKNWdEOW9J?=
 =?utf-8?B?aVFyWWJBSXdTZm84ekdWaEpkcjlOK0UrbTJ2RzhvS0IyS09pdnczM1lWcjlp?=
 =?utf-8?B?OVZlK0pvSFY4UlRGQ0J1ZGxnaEpkVDJFQXlDdlN6VnFGVG1laGNCUnhnczVj?=
 =?utf-8?B?U2xCTDJxREJFek0vZjNsZytSWHpIaU5CUmlRVGFUNVB0Z1lybUN0YTgyMnNU?=
 =?utf-8?B?SGVyejl6ZXR6NGhaM0FSbFMzSGMxUy9TQjF5YkZUNnJQclJtbi9JQmova1Vp?=
 =?utf-8?B?c2dwTjA2WkxiTzcrZ2x6NVp1OVVXWHkzYkVCNmZjc2xseVpRSVhNRk04UDha?=
 =?utf-8?B?L2svekNVN1NwZFN0M29GZVBTR1hJWEhrd2hMSm5vVk42S1N1bjZUWDNLNlRM?=
 =?utf-8?B?TWNzQ2pLRDNDK3gyN2pKZGx5VVordW9jVGxLdHkxUmk4ckJhMWl5YmRnSUVa?=
 =?utf-8?B?S3NPcmRoaVpUQTljQ20wOTdWdTduMy9GWGVoVWNWbU5mdHRIVEFjbEpyWkU1?=
 =?utf-8?B?cDNuOTdBaGtZOG1mRFFWYjc4QzZIeVdQSWVlV01UUTZ5NnIvM041N205TTRE?=
 =?utf-8?B?ZEhBYVVaQ2RCakR6SnlPUWFQdzVCWnhPNlovcitYeGw0cWdYdXRLNVVIM2tS?=
 =?utf-8?B?VGJ0bmV1OGFvUmNXN3lMcmduUElQZVU4YWFuQU03SFYxbFJxMmdBMlhsT0ZT?=
 =?utf-8?B?cmFhMElTS1ZoZGNuR1prOWdVK25LSDU3dHpGblJ1eTQ2TlFaVVdWN3ZvVitn?=
 =?utf-8?B?Tk4vbWNUTTZTd29JV2cvNS9vbVdnSjI4WVVDdDY5dXc2WWwzcHpaOCtPRjcv?=
 =?utf-8?Q?P452j3/zakKEwYAGKmRbkNK4CECWMHXa97iek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1Z6T2hHQ2hsdkxtRWpNMWZkb3Rwc09vdGh6a2RuTlp3Q1pDNHJKUTZyNTZS?=
 =?utf-8?B?UmdaT1BQVjUrYnl1TWt1NnFHZTRvRG5NVnAxY0hzelY3Um0xWkRlSmZOTkdl?=
 =?utf-8?B?UHJCWTZMRHl5eW8zblNVYnZUUWxuN3Fzc2haYW1lSGJGYzNqSFgvcTlNVDVs?=
 =?utf-8?B?WkRJdW1Hd2Rpa3hsanR0ZGE4WTNKL2hoUG5VUTNDSElHYVdOT00wS1FRSkVC?=
 =?utf-8?B?Tkx0V2ZRekp6SDdXUzhsdHBmcVpXdmo3T2UrZDJDdkJFM25VNURXNnBIUmQx?=
 =?utf-8?B?NXFTaXJPWUY3UlR4ZWdEMkNrNWQvM1JzbkJhTDlrLzV3bzIyOGoyUW43M1Ex?=
 =?utf-8?B?MFVUbGFwVHFhYjlqd1JSb0sxWUlnMlI2Uk1yRVFDWnl6SjdMbDFwRHB3ZTNa?=
 =?utf-8?B?aXM4SW1PUVNwV2NtRXhBcGxLWXlET3l2MnlvZTJsUzZpb3gxMGRZbXEwOUlB?=
 =?utf-8?B?V1FWV2RJa2ZqSlJ4VHdoMm9RMXd2VFc0VkYxckNIWk82VlZEcHpVS2NhajlO?=
 =?utf-8?B?UlAxM2VPbjJ2alVma3lGQ0R6dW1GNEpZeTAvSTZ3RGJPSmZwTVRaSnV2SVM0?=
 =?utf-8?B?Zjd2NWdyZ3BVQzZZcnFHZ0E3RnFmNzgwWkUrR0xKMU00UXRFSngwMmNGTlRk?=
 =?utf-8?B?WHQ5THVYU1YrWUx5aXM1K0R4amg3aUhISGNRbldrY2FaLzlScXYxRjBsWTY4?=
 =?utf-8?B?VmViblM2R0tvN05pL2JvNU53dWtXU2lmbmlHMWliOUhCN2Q0T0tPbXVIaHc5?=
 =?utf-8?B?Wm5ncEdPYmNtRDJBOEdzNFdaaXc4dGZwV1dDbmJUR2Z3MDUyU2E3ZW1tQWtH?=
 =?utf-8?B?Z2R2TjBlUVduSmNKUVZDV01CelBFOFRuTm41Q0ZzRHcrQ3QxRlBIdGlqVFJZ?=
 =?utf-8?B?L2RLVWlSOSthY21WTGh4bzhEeTlQbzJEU2pycFh6QXNPUVdFUWJRVURWZ2c0?=
 =?utf-8?B?N3JXYWtrYno1VTB0R1lvMWMwVWd6eFFyclduTWtvMThXbmh1bVZIQzhsc3dy?=
 =?utf-8?B?T2pRM0JGZkxqSGw3K21BQXl0VU50RUdzR0t6Z0dyMlI5dlB6VjN0dHRoNUdL?=
 =?utf-8?B?endGMnVRVGdNYmtiUEZXSDNad00rZWJBWE9WK2IrdkthbFEyamtCaHU2TlRl?=
 =?utf-8?B?UlJpUXE4cjBoR0R0b1FPSHMxNzNZZ1RoWXBKT0orV29MUEZERkFYcHNoNDlQ?=
 =?utf-8?B?RU5mQXpQN1FpZmpZMlg0UEF3c0ozL25Tc0tLc29RYVJtSlB6VGNCenJJUGNn?=
 =?utf-8?B?cEptZWdiS0xrejFNeHhwV1lHVDNRRE5GZHlZQlhYd2tHWmVBT1Q3ekY5MU9m?=
 =?utf-8?B?WWpUNzNFRVFtNHlzbHNrQ1F0bXBIa3AwajZKWlRiRlA5MmRYNDc0Kzc5VTNi?=
 =?utf-8?B?Q2JPbWNUc3ZqSjlxdHh5UUhSZ1dncFNiRXZLcWZKc2dXcnlnYXJQdjkvSmds?=
 =?utf-8?B?eVhpTUlqNmdhbmFETHJyckJBUmk3eG9pSjh4WlplUkQxaUd3Qm1sRE1CUDZH?=
 =?utf-8?B?OUhFcFJTMGV2M1RyL1NSY2pseXRiTzNuVzRCRHVwMTJmNVA0N0VLR1g1MklR?=
 =?utf-8?B?WVlyUnlGeG1mcFA3ZWdHZEMxNXczbmZiTjY5eDN1UWhsb1M4NWZYN0xrVWFU?=
 =?utf-8?B?ZXJQNHI5SDVBZXlsRUowRmwwZVRPYWZZS3Yxa3ptRG5wdGM4QUlMVkVpb3pD?=
 =?utf-8?B?NzFUZXJVRWZLUjRnbVZxbDUrdWFYY3I1SXFBR0dKbmhlRm1temlBZ3dtaUNM?=
 =?utf-8?B?L2ZRTDZaVSthMVlMVDlLelUrcEVpeDlQcXkwRW91MmQ3U3haK3VCU2hPb211?=
 =?utf-8?B?OTJLZzlneUc3QWVoY24zMlIwK3ZHSzRzZ1FqM25UM0xmYVpOVUtNY3pzeG4w?=
 =?utf-8?B?bkV1RUV1dTJnQzY2MnAyWUUrQnFWbFlGOWdOeHA0Vksvbm9qdWxCRnBVWExZ?=
 =?utf-8?B?ZFVCN0lTQmNlaHlobldDa3VLUHRLRndnY29FSXBFWVhWUHBkOGlmMW1qMzFx?=
 =?utf-8?B?cWRHdEsvSndaOVYwQ2VtK3VrR2Q5R2JMTUlCZG1JNys2MkNjSW8zajV0YTJL?=
 =?utf-8?B?dkQ5UjJEUWlTSlRlNlRlUGZDdUU4MnRMWldTR2lxZzBFUE1tZHpVTzg3cnJP?=
 =?utf-8?Q?B3C34KMGBxgxgjv/XJMHPg55j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98209896-cc10-4b5f-0ac8-08dcb000a94c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:00:06.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjYUOfY47g2sweJ6ohMt2bNCxM3kOxJJMq72yGx3JqaIZyT1fVzGhTsu1bgc9SQ4QRgC+z33rWRSppxaW/M7cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939

According to binding doc fsl,esdhc.yaml, the default endian mode is
big-endian. So remove big-endian property to fix below CHECK_DTBS warnings:

arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: mmc@1560000: Unevaluated properties are not allowed ('big-endian' was unexpected)
        from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 --
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index dfd245b326a0d..a3c57da63a01b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -164,7 +164,6 @@ esdhc0: mmc@1560000 {
 					    QORIQ_CLK_PLL_DIV(1)>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			bus-width = <4>;
 			status = "disabled";
 		};
@@ -183,7 +182,6 @@ esdhc1: mmc@1580000 {
 					    QORIQ_CLK_PLL_DIV(1)>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			broken-cd;
 			bus-width = <4>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 6d89cb5ddfc9c..58daf3f1d6373 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -431,7 +431,6 @@ esdhc: mmc@1560000 {
 			clock-frequency = <0>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			bus-width = <4>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index baf9cb90ba8e7..41a1f4f2f880e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -315,7 +315,6 @@ esdhc: mmc@1560000 {
 			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
-			big-endian;
 			bus-width = <4>;
 		};
 
@@ -694,7 +693,6 @@ wdog0: watchdog@2ad0000 {
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
-			big-endian;
 		};
 
 		edma0: dma-controller@2c00000 {

-- 
2.34.1


