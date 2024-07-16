Return-Path: <linux-kernel+bounces-254429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6396933315
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E971C222A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19C6F2EA;
	Tue, 16 Jul 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="k/+fRV+b"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023087.outbound.protection.outlook.com [52.101.67.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41D55887;
	Tue, 16 Jul 2024 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163171; cv=fail; b=dbiMI7ktSqIBp2eEVe2MDKCO3sotgsO99JHsDCfbtgdTUiLxB/jFwW70pm/w+qS9zoYtA+a/6IgUE0QRg+3Dn0z4z4Z3AosZVa6t6AAiPV+wZIa2X/8+y5ilR6mSuOpwjT0XIRmBczo++pJFL06wF66jMAYMw29diKLz6gX6BYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163171; c=relaxed/simple;
	bh=x3/nlQtUo30veTcAh/q/dKeHYc8H4kFP5z6v2j+jBbI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=hHDN1U4d5Fkqb6ekCb1Uoj043XDEEKHL4iyJrg5xR7fQGem3Xkbp6qm/Z2sce2KLyLCudykYWAkuaFMmUnf6snXe5NuArsPFhj8wKsyCxhQT3OznRAAvINn0iVwjZ4ww6Sb5AyRV2F11wpjj8WZM8v57OBHl6sr9/ZT3rf1s5ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=k/+fRV+b; arc=fail smtp.client-ip=52.101.67.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi6CetBsEL8pgRcuo3pK5xsjvg0xxRlJBeKmb1VLtupzpCBWKrz+l+WspLzdOgqnHMTEIVgQ6hK+npko1HbNBaHbV0itHY/Vv1Jz9IryPMDgDlFrQNKtX38IDIJ8Bll1ussv3ZDXuZZoJoy0sr4p5uePjDTivaMi6f//5bsPd/jybqXn0YcNmshvFEdMHpc0vahJwLGffhs67WK8f1RZI/oMh6+je2/Bwse6XUoa+jJPCM1IWmhPjeSkZM+yHqtie2Prr07F1pjs4EfTdd+H//wwanw3xaG4mxR+2aOvzuxgxBAnbDl6aYKw8shlpI2Qp4YMbkFkWtXTK4ov9MC7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoLjOlIljrLB31KwWA/jhpX7M1e/THvrNgazB0DVYjA=;
 b=Yoc9Y2MsqwUY9QF+0clNno/zOJSXD4fDodG0/1E/GqNd/5hIW58ppK0St6lyiMGPLVmsUnYHfepKBXUxiL2nv1T8O2ASiBHNPV+IpdjbDk7FSOfDQCdCkLFL1AQ96lZYmfTIQh/JCidfu+9U4s6poRjdHuJa66+RdJQIyr38jyPQ1/15i0d0tPOtPFtjqKAq0zEASN/Aog6zJp8VHF9Hj9PQJEHgzPZvePNiyNtPCuGH5B6saudLR9iqzLOuFE6cQp7LGupGzqVQ9LDOWVd5xE1Uj8VwJXtreD1uBslTRuErFmJhUWQkTp6kZLk62mrsgPUrRJYYshEk4rtB+I9RDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoLjOlIljrLB31KwWA/jhpX7M1e/THvrNgazB0DVYjA=;
 b=k/+fRV+b6lu8wGWC38cu2jzBZ8zZW7ks3CmbgXecmDyilkC7UsHVkobsKn9KgmJ4f/RlGnB6tv2NdZx3A+V30EoEgULq9ja5v6+dHUdQ6iNmRMk0bP4oG561SUTTqJE471nFvBem7l4JLk7Rj0kxIkIkUBGxQOB84D2BtI2aPMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM8PR04MB7907.eurprd04.prod.outlook.com (2603:10a6:20b:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 20:52:44 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:52:43 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH RFC v2 0/4] phy: mvebu-cp110-utmi: add support for
 armada-380 utmi phys
Date: Tue, 16 Jul 2024 22:52:36 +0200
Message-Id: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJTdlmYC/3WNwQqDMBBEf0X23C0xadD2VCj0A3otHoJu6kJNJ
 FFRJP/e4L3HN8O82SFSYIpwK3YItHBk7zLIUwFtb9yHkLvMIIW8iKrUaFS94jwNjGO/oZBUC30
 1lpSGvBkDWV4P3xtezwc0Oew5Tj5sx8dSHtUf3VKiwE5XUgurVWvlPfovdxhmd279AE1K6QcGq
 5g+swAAAA==
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM8PR04MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: c79f0622-f116-4401-6511-08dca5d93d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K29DYnRSd05PN05SQ0VCeFgyeFVHVklNVTAwSUtGRDVCWUd3RWdCbWFQMWxo?=
 =?utf-8?B?ZURoNkgxdHJTWThCT00yTFUySUNQd3FieGVEYVNxZFFoNmQxU0tGN3dwN3Rn?=
 =?utf-8?B?aHR3TEdwdmtIOXF4OUlwOHB5MjZFVWEyaFhBbE5ycXprRkJkZFZJSUplY1A0?=
 =?utf-8?B?dytCaUNYMm9sNlhoOGRqUk53YkphQkE4TTFqUmU5TmY5MmVoNkYzalZJM1py?=
 =?utf-8?B?VklpNGt2MzhkQk9nR2k3UDlKS1JiZ3NUVXNoQmU4QXZKVnRndGlOR0V5MWpt?=
 =?utf-8?B?NGZMT0Y1NDFQaGdZaEplK3RuOWpTbUp1blFyUG15bzlpbmZxb0tsOUNRUHQw?=
 =?utf-8?B?V0cvWjRKSDNrREYrL2pIN0JXY1JZb3ZyOW9tT1U2b2FvMXdxOGcwRXkySG14?=
 =?utf-8?B?em5rR25LV3BrRjBzNGRRNHcwMkRaRE5yL1p3VFVrb2ZrdzVwdnNLaDI0cUxT?=
 =?utf-8?B?ZXVEVlRkMU9Edkk4WlJzbkdzV1Y4NnUzOUhUSWszZ2UxS24zNkFwY0trYjZ3?=
 =?utf-8?B?S3dNTHpNYlJ2SEhHZGtPKy9yY0QwREFyN2h5SVVJL2g5UExxSnBMRFQ3N3JD?=
 =?utf-8?B?UjhFVmxtTWhFNkpPcm01amFwY0hGenFrbUJCNFl0d0FHZlpjQm1Jc2xWRG0w?=
 =?utf-8?B?WnJPVklia3hWS0VZU3ZRUHpmTFJDeHl1YnMxbWVFTG9ZV0RUVmYxV2JKelZP?=
 =?utf-8?B?WU9haitERFQ4RjIwdDJMQ0xyZXZXYzRKdnN2cnh5dC9KTGxIRVNIM1RGcXdN?=
 =?utf-8?B?Q1dOekUyMHNpcGxSYmNnSEh1bVdSMS95aU02UGRySlViOW9WSThGb3BRTXlU?=
 =?utf-8?B?KzRMcVMwbzhMdmJxMTJtSzJzVld0bVM0YWRzYUFHN0ZSMThsbGdvdTd0L2Vu?=
 =?utf-8?B?b0p2cVhQY2lTYkJ1SVlVVFNSTlJrdlp4MzlSeFVkYXRZVytXbVJxRE9SWlVo?=
 =?utf-8?B?SzBsZi9qTndjWHdEdlBCYU41aXQwK2c0SSt0Rk5EOTZvMXlqVENoNjB0YVY5?=
 =?utf-8?B?ZkplUGRqR3FBTWNSUUdLQyttNVZuUW9UcG9icTVIMkFqY0ZNTDF2ZXBpbXJl?=
 =?utf-8?B?MDVBYlRGZTZKR3BLa2xSMFVscmhrTFhVWlJmME9xY3ZnMXl0bXlSenl5Q2Ux?=
 =?utf-8?B?M2RtSC83bmVpQmk2Y0N2WmhFWEZFQzRXQ2FwYWRlVHZuUzkwYUJSRmxRMUZk?=
 =?utf-8?B?SXE5Qm4wb1lJT2FtVVUvZGZneTRheitVWXBTMzZuY2FERWFEU09SY3RScWpF?=
 =?utf-8?B?eWRWcVVrSzBSKzZvbURuelZ6Z0NqcW1ORitucjdkRld1T1N5NjJ1bFpkdVFU?=
 =?utf-8?B?NFVWWmFxMVE4R0FQeDAzV0Z2bVhORE9xMUF3TkJCTlp0dzRLZExwc0llbENu?=
 =?utf-8?B?UlMrd3A4UEJEUDdvcXRIeUo5WW5scjhpUlZROGFZYTl4YjFxSlRmcVgxVXJY?=
 =?utf-8?B?eTNPZkF0dHBkMTM2bDZlM1UyRnc3VXljckF4TjE0MkFtYStjVUlWLzNZK0ZO?=
 =?utf-8?B?TzhSUHNKM2wxU214T3g5TE12Rm9haDV4eEh0K2NmY1lxaE1LRklEL1lDTzZB?=
 =?utf-8?B?cExlMnVKZ2s2Z1BCREJyUG1sME0rY3BaVEZTeFVHYVdYaVUzS0N5WUE5bUEy?=
 =?utf-8?B?dHdGVmJkdXhHNitLdGk4c3NOSzZ1ZFRra2NDaW1jYlJ6ME4zU3NXeHVNem9D?=
 =?utf-8?B?Q1crZHh0dGsycGl0QW5WRzc4TVBCUkpKR0ZKeWpiMzlYZ3ZST1QyelRUaEJ2?=
 =?utf-8?B?bFAraFBEQU5QZUdpb3FJdUNSMSsrNXhPaVhhYmZXVGdTWWhDL21FZlREOVgr?=
 =?utf-8?Q?E/J0cuuB5PWh/A8J1RNLcYDU79N+7Ddtoynb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXVqd2tiZTRjOC9heENaclgvdnVvK2lkNlVPTFM1eitqYVJ3SlN4VWdRUE5G?=
 =?utf-8?B?VmMzVmxZdU9UeTNVaHpkWlp5cXNjOXFKMXVpYUR6UnFwK1RrS0tJZ1lGR3Js?=
 =?utf-8?B?dkNMUlJqajB4VzJhaDVxSzJvN1FVbUtkT2FnMmNEa2ZCdFNHZUZDdDJSOUwv?=
 =?utf-8?B?WFdVeGVEMVVDdFhKejFWUlZEaU0vR0RpdGY3R2d5V1NBWTZodzVhS3NZNStk?=
 =?utf-8?B?L3ZENEJXOU05d1FKd1k1Qmg0UVlla1oyV0RpT1ZYTEgvU3dWdWR3RlpTWHg0?=
 =?utf-8?B?ME5HUTVMSXNxZy9QY3pRRkhIeFhMY0ttQkVZUVo2MndSMlZ5WWxFUEVMclZn?=
 =?utf-8?B?ejZRdVY5OTZrZm4xczcwbnArOGp0UUVzL2hYQmRhV3BuSS9WdEx0MUVPVjhv?=
 =?utf-8?B?TnNmUnZhWE1ueVdPVWcyeW1IQk01S0x3L29NZHFCV2JZN3FTa3B3WVlSdnJj?=
 =?utf-8?B?OWRUSU5FdEpTZ0RiRlJabUpSaXFQWlVwM2ppMnV1K2dEYTFQOWRiZUttbzEx?=
 =?utf-8?B?R1NUUDR3WnpNNFd6TW5iM0VLek9vcGIvaUFHSENyemEwQTdIWVpKN3F4NXZD?=
 =?utf-8?B?NjM3aGxqNXhvTjBaYVpKQkJXbTRuUDhkSkR1R3M1V1NyZ1ZMNlpQa29NQlRw?=
 =?utf-8?B?RjU3NmJmSVh4Y3JhdTZISEY0SEU1QmtuMU5IUTd0NnJibnpMSXFIR2dMOEV6?=
 =?utf-8?B?TFBaQmxuSHIxM0dvVXgrWHphWDdERCtrZ25QWkYxV29HYVBRNEFNWTBaN0E3?=
 =?utf-8?B?TG1mdExvcmZ6UDBKNS9KWnB0YTBWMWNod3dOOTg4blpLNHZrd2M5ZlF2Yzlx?=
 =?utf-8?B?c2h0Q3YvdHFFN1lVdWF2eU9mUUxqaU1zTzdMU0J2T2VINVlLT1NFcWhtSE9U?=
 =?utf-8?B?U1lLRGhVU3JHR1E2NGNkWWUydmZIdkxhbnVjaGxPZ3J3a2t0RzhXQlcvZmxK?=
 =?utf-8?B?d2RDZm1zTTBoWmgrSHFtOEdjQ2x6YVR1dTk5ZzBqbWYydkI0UGZrUkFWVHhC?=
 =?utf-8?B?NGZuNU9vSnZtVFVQeXRBdWNSeDg3d1oxSnZKNlV1VUdXTTlIT0N1N01vaUJO?=
 =?utf-8?B?azV0WVZpajVVVWV2KzFpTURTaDd2NXhlQ04rdzB3YlUrZXlGb3BtYUtUVUNo?=
 =?utf-8?B?VGUrWjJ3VTRjejVrbXErQVU5RTA5cFRHZTE5aVRIR3IxcUFhclBSU2dGWkd1?=
 =?utf-8?B?VVVPa29RRi9MOUtwcVQxVVNXeXp3RUdZUzVmb0Z3ZThOd1hlVEtJdW1nSUgx?=
 =?utf-8?B?WnBZcWRNM2M3Qk85aGY4cVUwZlJDWnlhL2Q0S2lVNUdKUXBTUHdXUVZkQ1NY?=
 =?utf-8?B?ZlRKTSs3azlVZHJjNFMvWWZIMm1nVWlHWHF5RlRSRER1WFg2YisxQm9lWHJR?=
 =?utf-8?B?ZVVFdlh3VkZadklmN1o2amhvWlNKZHY3SmppV0Y2aC9WemxZbTAvdmFnaUpv?=
 =?utf-8?B?R0hTUTQxT200UkhDVWJnaHljM3BRTWdJZlEzei9QVG1GYStHODh1L2tHRXlR?=
 =?utf-8?B?YkM2WWFDK1BwdlFYVnMyV1dldDJKaklxRmN0NGtubHhmUDFrOVBqSFRqR1ZF?=
 =?utf-8?B?OERMWjZxeEpkTWlNUWhSRGNtQ1o4U1dMOXpUZmIwRUYraGppcUZXazNrTVhI?=
 =?utf-8?B?ekh5MDk5VmFSS1RyWnFNQUhGcWF5bjBJeUUvNkxTWlcybzJrWVBWZTlaVUpr?=
 =?utf-8?B?aEpNRmFJUHB3Q3p3RFhXckVYSXNMd1FGMmF0QytwbGl1WkJnbXFHd21GeDZj?=
 =?utf-8?B?YU1FT2FUVFpCQ3NOTGxYTmtjL1VnTkpJelZoVlV3bkhGa2lFeDh3V0dwK0x6?=
 =?utf-8?B?dDNjVjJFbGhSQVNoSzVqYUloM202SjYwb3E3akNibk4wZmdHY2RBZ3g1citk?=
 =?utf-8?B?NGFEVUdsMTRKWnMvY2ZpT0NDdlQ0VFIyVTJhS3Zzd2ZMZzdBczV4empGMzNO?=
 =?utf-8?B?RlQ3WXlNaFl0aHhTcGEwandFMC9WcTFnVnUrNEQvL3E3VWVSK1VjeThyWjJz?=
 =?utf-8?B?TkxhU0oyV2k4amNHTDIzSWorbFNvdHBNUm9hbVJWOTZVUU9lKzRCWUllVWVV?=
 =?utf-8?B?Y3dCTGlGd1hRMUd4eE9ia3RSN0hOWUVFOWlaUzlQbUtLY25oZ241cDRvNlR1?=
 =?utf-8?Q?UVBggX/gZk3YhoiUUaKjoczJF?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79f0622-f116-4401-6511-08dca5d93d6f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:52:43.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLhqx+EDREvfI1h6wzh0kkC2J/m8OrpSZy+ixChYYP8HuOx9OE7oU/ZoQ5wzo6nVTkXD3ypmdyUHtgeiSHaLtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907

Armada 380 has smilar USB-2.0 PHYs as CP-110 (Armada 8K).
    
Add support for Armada 380 to cp110 utmi phy driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- add support for optional regs / make syscon use optional
- add device-tree changes for armada-388-clearfog
- attempted to fix warning reported by krobot (untested)
- tested on actual hardware
- drafted dt-bindings
- Link to v1: https://lore.kernel.org/r/20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com

---
Josua Mayer (4):
      dt-bindings: phy: cp110-utmi-phy: add compatible string for armada-38x
      arm: dts: marvell: armada-38x: add description for usb phys
      phy: mvebu-cp110-utmi: add support for armada-380 utmi phys
      arm: dts: marvell: armada-388-clearfog: add description for usb phys

 .../phy/marvell,armada-cp110-utmi-phy.yaml         |  15 +-
 .../boot/dts/marvell/armada-388-clearfog-base.dts  |   8 +
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |   8 +
 arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi |  30 ++-
 arch/arm/boot/dts/marvell/armada-38x.dtsi          |  29 +++
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c         | 209 ++++++++++++++++-----
 6 files changed, 244 insertions(+), 55 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240715-a38x-utmi-phy-02e8059afe35

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


