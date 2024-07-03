Return-Path: <linux-kernel+bounces-240000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE79267C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4179C1C24E79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4AE1836DA;
	Wed,  3 Jul 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UPZq2At4"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A65F9D4;
	Wed,  3 Jul 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030107; cv=fail; b=qFv1F0deC9Z0tYdGTEfeqAvsKny31SzPL4MUeBkiu4y0Vo+tI0hiZpoHcg0QyI0zp9I+Z/Ft31uTYIov5CVLbmeQptOmQrdnacihjPiVmBGLDOE0lvE5CmumVNYaEWf9kMBv4hV1bdrU89wIGEH+9f5eia47EVKdvO6tK1rxIXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030107; c=relaxed/simple;
	bh=1tqvYiGA1MnNFMQ7Fwqfv6/0+TipsbCbKUUn7uJGKw8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DpJHYtM0BxgNNxjevW8SfEfFzqIEO2ZjXti/Wxo13o243+fnwXrQPt1yRKws1//36WQdZa8RjFA5Wo4dF9Tn2MWDoZrRFT9xBMXToqjR9WZirh2GUExWV7lFpJPYPY0+LOzdsXPSR+RE5Vs6kOYeJ36nWCoUoSdkR2Lxsrdx6yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UPZq2At4; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrlO97dCI1Z/oLCX2nHhpghuTpJF9mn7mvwihcXo9XTaljuS4HLa2InPkilhbqPccfYLD4WdY1FGmipv+PjNQuTsta4tOSLn/s6pDO0xNnTmgCjPaLA/miZVWN/Pn9e1QTwngMxxfhEl6yT0gCZSX8BaIUlg1eUzLhUyNTqrz3Aul6g9H6Majh1ALjrhSlNlhds9P6EbsuzHmx7g+NVdXVq1Yv30FCK+IRYNDKQ3+1SFykqrDwB4w4L2knEAfGdDbXDRsKCY7hGqNehvBY3oA+5dEext8YkOZCePNuJ3w4rZztyZ7eiZzeF/Gax5YJqE84uSZGTRNahopC+Q9Pg4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jK1z/xKko3dB6ofOSc+ADQkk7C8EruksMxyxPZgBNg=;
 b=e9br9R99uZiRKINJm0vdrL8SfKbAeDADnSHVH52wDiU3FFNEXKCQ/rTD805TwTnRHA/DGP+euDcB3DuXtYMIBVyYzyFH4zIySzLD6wAZdzAtAydgFU+MpA/9XkcSVRAdgJcj2Yp6DdFfE8E0xegl1QiHsT0rGMIpXYjVnBb7EB1etdN+pRAPa+sQDpLq03VKLnXbUpGBaMLWn85YXeQmQybneJ4J9A3c5LIObLMiP+UIgaTqrJWlBCmCzECD9AjSzY1QJHq7gn78MBHQQgKqzBnl+3VWyrrYgnBsVjM6fG7PaUqO2nbKgYSAWAWypEuE9TdfSWa9irleVmHsJirFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jK1z/xKko3dB6ofOSc+ADQkk7C8EruksMxyxPZgBNg=;
 b=UPZq2At4M+HtHIgn7Xe2Hw0DIuDtqFEnh2c/QqSVtygurFpfuUDo2lT/XL6FMYPSYSm/KPuNRhyLHi06JM9RpqXFFqT3VpwTmn3G6t0dUZAbAbSh2LMl4Hsy1EXCBJbxe1l4QYIeGPFmv+Wm2BVwVPDLYU9GfXV8cTrNQDJlBf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 18:08:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 18:08:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] dt-bindings: soc: add reset syscon for reboot node
Date: Wed, 03 Jul 2024 14:08:10 -0400
Message-Id: <20240703-ls_reset_syscon-v1-0-338f41b3902d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIqThWYC/x3MSQqAMAxA0atI1hbiRKlXESkOUQPSSiOiFO9uc
 fkW/0cQCkwCbRYh0MXC3iUUeQbTNriVFM/JUGJZo8ZK7WIDCZ1WHpm8U6ZBPRrdYGU0pOoItPD
 9H7v+fT/t9B8oYQAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720030099; l=807;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1tqvYiGA1MnNFMQ7Fwqfv6/0+TipsbCbKUUn7uJGKw8=;
 b=y0f7aqo5PAEqSxXYnLNdI2DBqQbcIS+GCLnu36mL9V1O4THSFTvfF9gPGXUQHmq68z6NKP+Tz
 e/qHpxIx2wBAyYkGP5aSyLGjP5rFPQRrSaBJ4BXHzv8Otx3N8sB2779
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: 2692a38d-dfae-4121-7a3b-08dc9b8b2015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzJmZkJ1Q0Z5ZkI4TnhoaFlvZXhDNHhDYVdoOEU4RnV3eDVtemxyTWl3WTdh?=
 =?utf-8?B?MUdJZE14VEZoREFHN282SHNaZ0RqZzN3b2hGL2FzakgyWWZ5Z3NCV1lTajAw?=
 =?utf-8?B?b0xZQmVJYVQvZ1F2NURZVGovaG14bC9RY016YWwvZDF6Q05QVGgycThDbE04?=
 =?utf-8?B?L282RWpqUU9STTFWU0pRbFRwMTJjdmpNemtBNUxlTWIva09EYk9XcStFazht?=
 =?utf-8?B?aTQ4YWF1c05idExmMmxTQmc3bGlJc1RjT2phK3ltZlhPYmFHem1lSGliMXls?=
 =?utf-8?B?c2tMTGVSSzhpK20wTThBOElqOWtCRWxaZnJmV1FFQ2p4NzZVUllvckRBa1NL?=
 =?utf-8?B?cms5QnJqZThDLzBSN2JzTCtEWTlTelVoMjdSdHdqU3V3SjV5Y2prQWpCc2gw?=
 =?utf-8?B?OUhkcTNEcU43bXpUYnZmSzRrQzNRMFZWZWZ0QnJiZEZ5dDNJOXlWejlCOXJ3?=
 =?utf-8?B?UEJWMzNGcWFuanB2NGtKUnB0a1ZUdllYd0pyYlpqMXhBM3lKTHFjMTlLZFFv?=
 =?utf-8?B?aE5IdHpRVktkWGtBYmltdWFJcUVwem5OczFYcXN6c3Q5U0pyaXRwdllHbThK?=
 =?utf-8?B?MmhnaW0zZHVkbWpRYnhIWS9EcjNhRmM3Vjd3K2k0cUZVQTFVRWhIY29SLzda?=
 =?utf-8?B?czJsbXpvTlQrZjFkZ3FDSEEyYzhwTHBJRlFWcmd1eXhSTEJuaWY4WFphc2I5?=
 =?utf-8?B?N3RCd2gvZVYvV0pjUzNFK3VwaURaa2U4WkdJQXZNVGZmS1U2WnA0MTJtMmZh?=
 =?utf-8?B?eU5YTnU1cEM5dGh1L0xzMDl1SFpBNTdIS0tiM2h3NEwrUUFUcFBEVVBkYjQr?=
 =?utf-8?B?QUJ0TzhScnNHOUwzUXJUSW1sU3kzalEySDM0QjM0b0JPVVdQZG5KMUt4eXpw?=
 =?utf-8?B?TmUvSFZZVjNRZEd5b1hBZnB4YndJREJUM3lQRVozT3c1YWhBWlN6YmlpYkFy?=
 =?utf-8?B?YUZMcnBkR3k1ejZ0aVFnL2JTZWQvYmRTMEQzK3BPYXlpVGYxQi9KUWtZRVVk?=
 =?utf-8?B?bmpLUDZxZ2NtV2JWRUlEM0FlUXI4Wlc0ZmdSZlNTSjZIeVMrbXlHZEVmOHZj?=
 =?utf-8?B?aUdySUZVOU8wejdwb2VuRURVN1htVTMxNTN1UUVrWDl3Sllvd0o4S05jQi9C?=
 =?utf-8?B?dnY5czZjZ3J3S0JrcHBDK2J0VUtiOGxINHNFN0oyQlRsejJUTkRhTDJTRHVL?=
 =?utf-8?B?emZId2lGZDJ5ZTcxM3hJeVB3aGpydkIvSXF1U01NdmloeWUzU0xyQ2ErTHZM?=
 =?utf-8?B?UGhJajMzN096NTA4YnQvRmJGZWpxMUlhOFZON3FoUHp1M2RjZUpFazRhWnRE?=
 =?utf-8?B?ckJnQUJNTEdRRlh6NFRla29kZS9NYjZaSWhBY2tFbUhyYmtyQmswejZIZ3Zn?=
 =?utf-8?B?cXpUS1kwc0NsdDhkN3phbXVkamp2RU1pWFcwVll6SEkxTXdUUmFDdmNNMWNo?=
 =?utf-8?B?UkRrVGhYbzRvdGpzWmZXbTAxdFhyTzIybjU1dTErUlVMaUZwM0FkczVYNnB3?=
 =?utf-8?B?OHhxVG8zdEZmTmxqM01iMThyVnFDU0lkSDdoMDRVQmVndDNXME9iNnVHcmZO?=
 =?utf-8?B?ZWZMMnBFbjI0V3lmeVVVRGZLN2pjUkhFdEZZMmlFeWhRS0NickI0L2ZiVmlB?=
 =?utf-8?B?OW10eXMrYkY5Q0dKOCs4bW1JT25odzNxcG5pU2VKWlNhZVFwQVdNQVJ2STZP?=
 =?utf-8?B?STdBM0VOYmJxYmhidlpNS2IxT3B4U0JVSFo0Mk05RE9ZM2dtSjc0aFgzbkM1?=
 =?utf-8?B?QTY0SEJTOGZVVDBZTnFPdkhLUGwxT2h4U0xJdEVuYkZLdzlMUktjcVVveU1o?=
 =?utf-8?B?cXlnUFdxRW1rRWpxNm82MkVKUURlMUpiQ0ZPSDN5TmRNTGZZL1pvci9iSVVR?=
 =?utf-8?B?VEt6d01JUERZUEZSbFo4OEVuVEh3OS92aWV5S01iemk0TlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFBlME9UUExzTU1ZSDRIbkp1MUhtRHR1UzFUUUgxRWxEOUtzODRyKzJrY1R0?=
 =?utf-8?B?K1VMdEJaNlBSQzhFcXJNSndudnl1ai9zQnBWUU9GNlBMNzVjQ1RkVXB4d1kw?=
 =?utf-8?B?YWU3VEw1VEpKOWluWVNDM1p4M0ZSazE2WnN5Rktyd1gxZlpSK2NYNkpveHhV?=
 =?utf-8?B?TUh0b3I4UWVVbnpKWCtoQXAvYjA0MDdRVHBLbzhDM3pmOWg4c1dycG9tTERm?=
 =?utf-8?B?dWF3NzBZZVF3S1BDS3pUUitmUDAyNWd6UWpDaVZ1VkdCajdOTUhtOGd2Wnpl?=
 =?utf-8?B?RnphK0orc2hGNk10RzhPTUE5VVR3bjVDRnl3bFNiUHllWHA0Uzh2a2l2Q3c0?=
 =?utf-8?B?dmpGNkgxTklpYkVDd0dsTWQ5RE10eWtKSnczMUFqQzc0UTdMSFBUSTZ1TWx6?=
 =?utf-8?B?ZjJJWVA4Z2J5OXFCQ3JNU0lrakZwcHUvYzc0amJGWFBTZzhTbHhLMGlEcGE5?=
 =?utf-8?B?RVc2VENNWHEyQmJCYlF6TTc1Tm1jTUx4bkhRWjk3dm5DYTRLcHRBeUZYQmVx?=
 =?utf-8?B?YndlRUhGNVRKVTZ6VU5zRCtjZkRJN2JKZlE5NWp3c1pDVmVMdmpRcWZ5VnFY?=
 =?utf-8?B?NnN5NmlTNlB0WkFlUVZOSXUyUHFmdmFsNUxrb3ZJZXJQVU15WFVxc09GMzVs?=
 =?utf-8?B?VlFTa1UzNkdXRFRJcWRhYjRkaFk4bC9ybzFaTmxIcEs3SEN3OURlOGozd0JU?=
 =?utf-8?B?YVJLWTdoTFptWjJTR3doQkFCbmg1bU1JREkyOGtBS3ZhT20vNnBPNmdydldn?=
 =?utf-8?B?dk5SSnIwdktBa3VpUUo3cVIxUVNiU3Z1MTJCUlBKKzMwd0k2aEVKUUlRa2hn?=
 =?utf-8?B?d2V2YVlUYmhYY0ZNbnBLMHFOTHNFYjNucG13QWpkU2Q0c3M3MDJBdngyaVdu?=
 =?utf-8?B?RzBiTndkWmx6L0p1STF1QnBXWFd3cS9sMVE4Vk1qbDVraXJsbkxGMlpwc0JC?=
 =?utf-8?B?cHhHdVdWV1ZRK3ZWRGVRUkhsYlZaZlBMakhDVDAybWs2U2w0d3lnRkJXc25K?=
 =?utf-8?B?d3ZKVlhBNVFRL2Mzd1kyRXVYTDR0WnczemVyOE43amVRMHZvRjVmeDZNS2gv?=
 =?utf-8?B?aVhycE1saHo5RTNBYnR1akt5aHpsOUpjdG5aY2E0aDdhMFh0bmRzeDNWNDh4?=
 =?utf-8?B?SldOOHFnOThtL0hCUUJkRnBRZENyczViSXVsMUNSRHNlVklOUmc1VEM2U253?=
 =?utf-8?B?SUl2MThMTVhLTDh3VlVIZE9Sb2M0a1Mzd0NyeGNKOVNnekxpNzZQWHJnLzFF?=
 =?utf-8?B?djBveW5QRCtNcElkZEhlZXNHd3B1TkV5dkxqZXc5ZUJwNmpjODJGTk11MGtH?=
 =?utf-8?B?L1ZMQUdwTG9oby84R2c2SnJWeEtWdjJzb2tpWE95NlNYY3ArM2ZUckxLeFZN?=
 =?utf-8?B?aXczYVBYdXVaUW9VRGJpWkR6N1g5YTY2RmRLWm5RTjhnZ3RxSmQ4NE1NVTRa?=
 =?utf-8?B?WUJEb2ZPdWx6WGR3YkNiSUJBR3JNMmdSMEUwM3pkVEJEUHFqOWtBNWdYaGxp?=
 =?utf-8?B?T25UeE9PdW5BdC9ka0lUVHQ5LzJXZzcxQTZON0p4Ly8vZ2svcEZ2SWR6MHh3?=
 =?utf-8?B?QVZteFdKVWdxaWVKdE0yRHlEMGxDRlVmZTh5MTRTaVhyNWlFVE5sTmJKWGVQ?=
 =?utf-8?B?SGpXejRTN25HSkhRallJa3lzVGFVMHMwRnJnZkpFSzZyeE1VNlh6Ykxvc2hI?=
 =?utf-8?B?dlRMNlBWNFBoM1lhR0lHdjBuRFpLR2pJVlphVmNkeDJMSXZEWElWa1ZiVWFI?=
 =?utf-8?B?L0t6cjZZRlJJUS9VVk9iZVJVUmNDSC9HTHIzVFRWRTBsUnFRbSs3K0xjcjcw?=
 =?utf-8?B?anV6UmtCblQydmJrNkhHZkh4cURlbHUyam1ZRndVRjIrelVjcGcyYzZiVldt?=
 =?utf-8?B?bDNoOXV6MnNKWi8rV2Z0L09aekNydFUrVlljYWFyYXR2ejBGL2RHbU4zbG1y?=
 =?utf-8?B?dGsvU09jRVZtcnZJYk16T3p2TU9oNCtrUDJrRFI5dUFxK29qRWNwNklBRVVX?=
 =?utf-8?B?VDV1UERyTm5WSTBwMHU1b0R2Z3dVYjZkYWIvT3dZRHhnRFMrQnBVVDQwQXBL?=
 =?utf-8?B?eFl3VGo0ZmFNYnZLdkNkQXQrLzk5MmlWYUVRNUFTTGRqcXNiQUxLSU1ObFcy?=
 =?utf-8?Q?YtjDFQQKf3JDQqXYp2qeZnUm4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2692a38d-dfae-4121-7a3b-08dc9b8b2015
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 18:08:22.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ok3CJeUHpfcJTQhj5nKiiUPLhOEB/B6g+pTAPNTkym8lpzX7pdjZlfUiXmTrGf8zILsanshUUUkkLtpz5zUs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111

Add ls1028 reset syscon and fix below warnings.

syscon@1e60000: compatible: 'anyOf' conditional failed, one must be fixed:
            ['syscon'] is too short
            'syscon' is not one of ['al,alpine-sysfabric-service', ...

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      dt-bindings: soc: fsl: Add fsl,ls1028a-reset for reset syscon node
      arm64: dts: fsl-ls1028a.dtsi: add fsl,ls1028-reset for syscon

 .../bindings/soc/fsl/fsl,ls1028a-reset.yaml        | 56 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     | 17 ++++---
 2 files changed, 64 insertions(+), 9 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240703-ls_reset_syscon-9507b9750397

Best regards,
---
Frank Li <Frank.Li@nxp.com>


