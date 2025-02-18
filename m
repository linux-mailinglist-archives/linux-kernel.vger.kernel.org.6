Return-Path: <linux-kernel+bounces-519994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D759A3A475
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F170C3A45E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CE226FDAD;
	Tue, 18 Feb 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ihPoAuB2"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013024.outbound.protection.outlook.com [52.101.67.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4F26FD82;
	Tue, 18 Feb 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900341; cv=fail; b=UJ5vBs3gUixvFH3sUS21hM0Zlo5JJPdOKqjJzRi0ZPLjjsSbIdeJ/MvR9Q/0zsbRJ9yQiWvIyT2miTgqhLeEhZmlbIhcB0ckSgVb51zAL1uthtcaObh0zXyleKsVc8JfncTeysobejIeOgVysQmh2BGPsaPu02w2uJbv28HXHzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900341; c=relaxed/simple;
	bh=KIHj7PwQdY0qiy/wjZ3Mh3EsStsR7EPMMFh62m16X7E=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mCXi7+E9C5nkpjVNwKVCx14wJtcx/shXM4Ql7bs3Y8TEeOCbomwx/qPf58T1diDEl4aB07i7rRiIQF+g//LCVHy5seml7tbk4oyeWjaKZ70njOQDHBIYalBM5TAwIRE6WmNZBk2LSPg/xMeNE8J/eSktgEWad1/nxOUjSFOtpNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ihPoAuB2; arc=fail smtp.client-ip=52.101.67.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7VIrCpDV7JRCni/zVFS6aw4sp8ynwD0rpJx/yG3T6iITE2Wm39MHAjVw+yT8JAP8ySBftYk9XIQ7v1RxnHtcb+NvbvX35j5OiKyDv9QwYJgyx+1OVXsPkEWO7MyQatunS6dtTwtnqcl+0IU9fUEFh0kZzLP9VgFTFlfM4CKi7gYT//Xu+gUGSiw6CEzChark4cKbe5UIkmeDgU5lxJZtN9xVus8dr8AwdlF/5+yGpx6rJz4pJvLvAuLMjdIU4XY6C17ejG2U3wY0C5NxAwbF6EXIbXx3V0uLqOhUGXcRi6AE5LMf1epZAwlzXgtFc+wPWp6nAdo/7vekcdWOK3KKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzo1F1LtnGRQkyVgJfdqJcEc+fj8UTrSku4BkZRanjA=;
 b=dtSCtQUOVKtm/IJFYoDFUn0IJz8yfcl0y2HOxX6lInj8KliO5VDJgllwpW1KCKsL5fUtAnM/vJU4xoJ0ELnmdvUP0m6Z40LbudSloM1S1lrGchAAiLhPQx1rnO47ml808MEzJpe9+kopmTEOczoL1UY1kxLNuOw+a4BG/Fgy8bkuDSITSPIM+wV819vj83RD2elhieQ4v4PJzrqG84bZYUycfPQTk5fqVadvQXJZdGzXeHPnC59efnEE9l1AQtOahxuv5PSmRfSRPTXfUyXsJTgdcLrzBqxzwbDhDcbKxI2HgYoExgsJyNXHVWEPK5ajmDcOJiqpLPeviuDdHVD82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzo1F1LtnGRQkyVgJfdqJcEc+fj8UTrSku4BkZRanjA=;
 b=ihPoAuB25uK3Zc/DEv/FT6ZQSr7vAf/VeKgcwKC7KMU1VYCBQNEsbOer1iH4FZK9IsSwEF9N4QzL6Wpd7ecuDlLap/8SyJhpp1vpN9pASs6l0OswpwFG+AJ6rdqiti4OZkGObAyAA5CqTcL+dElnogmXtjmRYe3mt0fyMCjYeCo0CjROaEQeLR1HyL8x0Lb4vDSdJMyabyHfQGaV8FS7RXhVBRX13I8Z6FCPInq0txj9mnAC2Cl8pFw2GOBcmOwKVZJ8oKiie4NqA0EMyINPN3KXe7DUJOBlPxqqVS/z6paye96Dl/jCVQQOdXylIWMGqToFO1lmq5GOWPJBTVgMeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10241.eurprd04.prod.outlook.com (2603:10a6:150:1a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:38:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:38:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH RESEND v4 0/2] regulator: add new PMIC PF9453 support
Date: Tue, 18 Feb 2025 12:38:38 -0500
Message-Id: <20250218-pf9453-v4-0-ddfd34e02da0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739900333; l=1504;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KIHj7PwQdY0qiy/wjZ3Mh3EsStsR7EPMMFh62m16X7E=;
 b=pGdpS1pRcPLqHZS+Do0EwCYiuOP4FI4y2yV7RwUo9sfv2O367xI8xL/3E1TqeMEqZN4bqa/Jk
 O2+bciKHZ3yDbsFMDWx/K0bhG5G/IcdAGjZnadS7goLUc4kvaJBXU4t
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10241:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e37c67-4101-4ec2-90d4-08dd50431eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGhWZXFQcHFLTnozQXVqdTI0bWwySXp5Y0oyNVZ6enF0ZGFyRFFYV1diOHBx?=
 =?utf-8?B?dHRiWkhoWnhDcFNlMUw3Wm9EVUZJTHBScXczOGo5V25NOHcyU0pWMnJDd08x?=
 =?utf-8?B?UjlRT3NpRUM2TElpOHZEMjY5aXBMc3d4WTBJMVJzSWlPUUNRMzl1RlVXN0tI?=
 =?utf-8?B?TEJBY2NwRGNjQWdUK3pTUlhIWStrdWRvSVFCRUxtWnFxMjhXL0lNTjdzZXBO?=
 =?utf-8?B?Nm9QTVA2dTBPNUE5S2dYRGU1Z1UvY3ZPbjROeDNySjh2MnB1ZTJrZ1VWR3lp?=
 =?utf-8?B?Mm1UY3dSZ1B1bE02SXI4anVPbHVScjVRVTVvUjNZd0hGczNBQ1dIR05NTzJ1?=
 =?utf-8?B?Zy8vYXVSMVlzUEs2anI3MmptTm8zK2J4am44QzBtYVBmOHlJY1paSURPVG1O?=
 =?utf-8?B?c09Pcis0MWJ5OE41T0xxRkE4SHU5MFQ5UTZ0dkRjS2pwY3VsdDZrVTBWdzJq?=
 =?utf-8?B?VjVjMGxjeUYvRjF2Z1V1U2IwUVhUaWNrTjZNUFltc3hjMUttMHVzWHVLNFQ5?=
 =?utf-8?B?QlhrRm5yUTlTU1RJRzJNbkNTeFpxZTlMUHRtSGFTQ0hhQjE3Q1p1UG9SSmdG?=
 =?utf-8?B?UFRvbEZHek9TbnF3L3c1NDFOY2o3T0NmZjV0Zy9Yc1FjOGY0QTBNMURqQnRD?=
 =?utf-8?B?RjdHUEcvZWhUc1Ixd0JUOVNORC9uSGZ2OWliTEZBQ0lRUkl3M3dwRGpKRzdy?=
 =?utf-8?B?dTF0aXpmVzhwODRlRE5ISDZ5d3dUcHJWRFF2U0VVVkJROTR0dERSSU5oSEZP?=
 =?utf-8?B?aVh5UzZhbTJjd284bWNEb3JoRW12bWVVdHVrdUVkM2lFS3NyYzJCdUtXSlNx?=
 =?utf-8?B?UTlJU08rN25jM1ZNM3N5bHVVYmxacVJralR2aCttNG5OajZFV0t2aVhXNWxP?=
 =?utf-8?B?QzJoMmZ5Wjh3cXZxbmszL0wxTWZLM0plOXFpVHhhTzZWNWV0VXRBRU1obWRr?=
 =?utf-8?B?Yi9BQ285SjlKclN6OUZRMVIvNXdBQ3pnckEzWnlyaXBSSXVrSlN3Um5ibG9p?=
 =?utf-8?B?cE85eTE0MTgvRjR3Mlk2NCtwUjBRamRiY0hLVGxDU0tTYm5pajEzekNjVTht?=
 =?utf-8?B?cm1oR2RBODlleE9Xb2VuVE01Q2M5d0V3MHVCMmVKS3BBeVJOSWpOQlo0aVBp?=
 =?utf-8?B?ZmFmZVJJekJJaDlHd2VERnRzR2RCUFZUMjllWGxqUzFOWlZidXJJd3RVZnE4?=
 =?utf-8?B?YXZpOXdyK3YwLzR1bzd5WloyUmg5S3Z5NWErWU5iVVJTV0hONnZTSUI0cXpu?=
 =?utf-8?B?Ukl3Ykxxbm9XUHUxbGtiam5HMUFpSkZpelA2WE1saFZybE4rNk5kSTVXcm9K?=
 =?utf-8?B?eGdSSU1XWnlvOFJJRjQ3UmZGNSs2YXBTU2lQQmFuRU5VUEpCRDZ4NzYrK0NF?=
 =?utf-8?B?blJwc1hKOE1wYXY2TzBiOHdTRW52OGR4R2dOWnRsUmVNVXpXa2J3MHdKa1FB?=
 =?utf-8?B?RFlRVkdyNXVHakJ3eUJVMm9ZM3FGTmxRVVcwMDlLVDJnSW5UUzkvQ2VKUDNn?=
 =?utf-8?B?VldrY3NrRUVNNGcrWEZicm1oSURCck9wMEFtdkJwcU5mWGE1YkpLNm93WUFl?=
 =?utf-8?B?UVlkY0w3UlFNQUZVNEtodG90Qk5IN3hiL1FCa3g1N2VhTmdudEVqVmg0dzB0?=
 =?utf-8?B?S0dYeHZxdm9JcFBQdmtNVlU1NWxlZmczQVd6UUpHL3JLNUJYclEvSVdMeVlL?=
 =?utf-8?B?UU91Y3V3NGYreC96ajlDQXcrYmxXT1lOdkU3NmVUOFVmUGtMdDZpbDRtaVdm?=
 =?utf-8?B?bzlSMGVjWXlWZTlvY0JlNkNGY1o4Nk8wYkw5NThKeGgyMjJ4RHF5RGdLNGp6?=
 =?utf-8?B?cHJHOTFCcDVzMXVJaVFPZXlNSjRrdzh6YjJlQWEvamJZbnRVLzRLTWtQZ1hv?=
 =?utf-8?B?c3hxaGpDL3JXZVo3TVdLSkY2Q01pa2NaeWlmQzJVaFpWQTBidThhUjN4eFdW?=
 =?utf-8?Q?s4EJ7yzVxvIVTKaYoq16Y63PGvR1TcDg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFY4RmQ5ZGRRUkpIVS9leElxbzVyZjJRaGxYMTM4UWpKZVovRGFFYktHejJO?=
 =?utf-8?B?bVlDVHVnUTl1Mzk2YjhRU3FBbFRHZmR5KzZ6Z05KMXJwT2lJVFN5ejUyU1FE?=
 =?utf-8?B?OHd3M0dxdEs0eTduaHN5bXJJNVJ6UkJXZk1xTHRtdURLNi9RNlUvQWx1Z0Zl?=
 =?utf-8?B?QXNwK3lwT3VpS0NhWXM0TUcxSEFxRmU4ZDNGWWpXeE9OTEhkamN6K3Q1bVZx?=
 =?utf-8?B?bkJWLy9JdXA1OUxJbEwwSzgzUzRBSFB4WGo2WmZYVk1VVk9NbzN0QXRrbkYz?=
 =?utf-8?B?L3k5c1VBRmhjdXdyZ0tLT1ljTTNweUFXRW5oNnVCN3JXOGhLNWpxMFVOMXQ2?=
 =?utf-8?B?Nk1OYVB4SnRHQ2VRZThjNXVSRnZyT2NGZkdYRFpneGNXNXNQaWdaRUo5U3hy?=
 =?utf-8?B?V1N0eXp1eXBsYkxiMkVOZjJqYi9BM3lLSXpsZk8wUjlLY0V5RGRDY1NzeVhm?=
 =?utf-8?B?LyswdVRSNTB4djdKdHp4OXJiQnAzNWE1NUdYTnd3dTUzdkV6L3A4aTIvcHB4?=
 =?utf-8?B?QTdsRy9KZ2RFTC9CZk42VW5ZTDQ1cGNnMUpzc0YyM1hWOVl5eEJWcklGdngr?=
 =?utf-8?B?aC80cHhkSlltVjZWZFNhajdMWWwwQzZDUWhZME0wd3BZbENkdDJmZnB3VUgz?=
 =?utf-8?B?aVNJM1pxSG5wcXpRMnlFdlVZb2t5NDZXb1M2NFNHOEVJNlJvYzZlL0oya25C?=
 =?utf-8?B?aGhkSjhYeHhYVUtzRk5wTUsrdll6dU10NThpYk9aamUwT25UMDRZQU1rT0Zw?=
 =?utf-8?B?bU1QVk16UG4wU21FUTRaQUcyN0hNa2VjcDAzaDU0WWNGeXdaazZCK2o2NmIv?=
 =?utf-8?B?L1ZwVnRuc1NsemFBQXVqZ244Y3dIVUZtSW1VKzZVMDl0MHJtQXJ3Yk4vRjZR?=
 =?utf-8?B?RURLeWx2M2Myb01nUFB3dzBWQlJGRVh0L3pjWHRtNmZCRzAxYVdEcTlYV2pV?=
 =?utf-8?B?Zit5bVpMbXpYUVhzVHhrckNJOEVvd0xDK2FiZmNHWW95U2tPaGRJZVNiZU9F?=
 =?utf-8?B?aXREQStzaGUrRm5seVJoSWV6MFFxRjk3ZmpMUFVVVVJ2VTNaM0FPWEU2QXVv?=
 =?utf-8?B?bW5lYTJ5TTlGN0hlTXZsRkJMVFAvT1BSN3NHanRyVXFHMENlcFdwMzZXRHBj?=
 =?utf-8?B?ekRmeFpDcTZWQTFrdDdJd1NublVFdGk2MXEwVHpmUUdRZGJsbFZLdmFTSVBO?=
 =?utf-8?B?dnJsQlZDaTJkOHk5NVZNOGR4TU5vMWJZTWVvOFdBSzJtQlR4SmlSenp2cWx6?=
 =?utf-8?B?YytVSnMyaHNzaUpubkY4TnBvSFZaYVdEMndId2ZlSDJiczRlUlM0WURSUXBy?=
 =?utf-8?B?OU1mR2NZNnhuRHFFNE5NbGFVN0IreERDZ3Y3anpEZkhSa014eG1Vd0ZiYkpS?=
 =?utf-8?B?NUZzVTc1WkFRWkN2dTJRa3FmbkNmVnF5VjhUazdwUEM2V2RlNGNFdm12UWZa?=
 =?utf-8?B?TmU5eFhhV0UveE5aMW0wSDZkTmZpL0lWTkZBVU9lQ1VURDV1SzJoL2l3TGxq?=
 =?utf-8?B?YWo4VmkxSVpCanNLWGFOeGVWcjMxRkd4ZlJpNUtibUo0R1VIMGUxWEhIRnJ4?=
 =?utf-8?B?NzErcC9zU1QwaW9BZVQ5RFRjbkhLZW9pU3JVTFlNclhnLzgxc2pOcThnSTYr?=
 =?utf-8?B?RmNGV3FMZ1RWWXFwSWptaEowS3pHQmR1RnlQdjNyc2JFRmNIbXpYRDkxckNO?=
 =?utf-8?B?SFQ4bHJJYnZQNGhsV0ZhdEJxUkhKT1p0dHB6TTNrZ01PemxCRWZuNHJZVkZh?=
 =?utf-8?B?TGVWR2dmVFFubUdVaThxcThWV24wUVgwOWxKRTl4dGF4N2lLbjNGaFFmMWJB?=
 =?utf-8?B?ZVl5ZEdRNlVQcEtWa09FZEhWVktXQlNUN1h3TUNIV2RTTllmSmp0Wm5xY0gw?=
 =?utf-8?B?aDcrak5SQlJ1S2c5bVlreEJPUUZkd25XNjFRSU0xQy9EUDRkbUJHWUUwMTk2?=
 =?utf-8?B?UjJlV0V4RldLMGFVYU1uNU54bURFMkxJL1JMaFpzUmRpMHFid3krS25LZ1Yr?=
 =?utf-8?B?QlZzL2JsWXJPWTA3RlgwYmRwdE5Bb1dTU3VUMXJtUHU0cVBuWWxtdWJqNjVE?=
 =?utf-8?B?TlJ3UXMwcUkxb3ZPQWRSSHkvNGtBVDREbjByWFNqd2VNdjJoT1JhRUFQN2dE?=
 =?utf-8?Q?PqJWGOiY0Ws9RpI+oKCkc9IWU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e37c67-4101-4ec2-90d4-08dd50431eed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:38:56.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLWWZ3JEGCf+P/OF/78e5HuTCS79PwkZR93DpzPMYxE3pQ/34teLQMpGV54CCDUQlpimLykzynUFpaNIJvRqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10241

Add binding doc and driver.

DTS part wait for
https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Add Krzy's review tag
- fix GENMASK(7,4) problem
- Link to v3: https://lore.kernel.org/r/20241213-pf9453-v3-0-5587c1693155@nxp.com

Changes in v3:

binding part
- Change to LDO-SNVS from LDO_SNVS

driver part
- remove pf9453.h
- remove double space
- use low case hex value
- remove , after terminate
- use GEMASK
- change to LDO-SNVS
- Link to v2: https://lore.kernel.org/r/20241212-pf9453-v2-0-f59d2c096356@nxp.com

Changes in v2:
- Reuse nxp,pca9450-regulator.yaml. Add nxp,pf9453 in nxp,pca9450-regulator.yaml
instead of create new one.
- Link to v1: https://lore.kernel.org/r/20241206-pf9453-v1-0-1e4685114271@nxp.com

---
Frank Li (1):
      regulator: dt-bindings: pca9450: Add nxp,pf9453 compatible string

Joy Zou (1):
      regulator: pf9453: add PMIC PF9453 support

 .../bindings/regulator/nxp,pca9450-regulator.yaml  |  24 +-
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf9453-regulator.c               | 879 +++++++++++++++++++++
 4 files changed, 910 insertions(+), 1 deletion(-)
---
base-commit: 0768222687cbdbe7c300c4428f0c0c6b153386e3
change-id: 20241205-pf9453-90e8dbda562a

Best regards,
---
Frank Li <Frank.Li@nxp.com>
-- 
Frank Li <Frank.Li@nxp.com>


