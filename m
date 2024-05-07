Return-Path: <linux-kernel+bounces-171694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E18BE767
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3194283B34
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C70D16ABCD;
	Tue,  7 May 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fY8S2lN0"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E3165FB8;
	Tue,  7 May 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095633; cv=fail; b=vFFtS2WBOveZAg6ZQBjqubj//On2n8OB4mNPUZOGqIa7nryj4L+o37/y6ywdHxKtM3P4LseS55iUcicbJe6x/XMlVN4UDTz/KPYABvh9tBJ6rO4Aq5SgKNb9SD/Uf7dIIfQQs3d7C+KJTJEaR5+qCnsR6il6nqbbs746KAiJ4u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095633; c=relaxed/simple;
	bh=R8P3W8tWTZls8VRAz9rqj0K8p/8Zhx4eAdasms0fIl8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TcK32a5JXW4ujMO/XH3t0hkTVql9mzPWa4t/XESq5laGVph6BxSyAzF8W6lRE0MprOT9c2cqZQAlqH6Z/vQJTnR1JyFZqsdGyctKLUxsg/Z8g//7n8f8Ls+wl3rADp9bp1Pahyw9bXafZJzdYebuaZw4gE/go3X2xp5Wgm4l8QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fY8S2lN0; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmfLTSsJE309wxGqF284eaBJe78SVtJJuvMsGiqQv6Y1b0kUgrX14d+b21MA44Jm9d2mOQunYcd0qmPGSt9/33D/s3FXZTvBO7ecr8qd4QcDYp0d+/XKGaEeiEwmaVZtoUFZEII8srFoTZfLacB9QNK4zpOOn0/P4Htjb6W3EqKz7++PwnNoMoMFI9NRBwI2OHhj695h7QXouyKjYjwtT5BIaNdoTOnhZEVG0xp4YhkCKCB3u2Nhq38vFZu2Ezn0t1uuoc+UDgpmrrG1oXgeidQi5v1kigzr47lc9BcZ4CM43nTtsZfnR04Y5byLj/3zrJWFTnf1ogCyVv4NzWpgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8W6QroVXRCpCfE3XgHPNIW55+hj09hN6D5oQdhQUfU=;
 b=I1kZijLJxdJn+G+4ttjJthquTlTJG2Sgcx+/eQ+b7IgcOjOcDGPl6IGqY3dYYqEcAcXr00SUfRp9b+kUpI0LtgtYING0Sp+pAnxaNVTQTWtoDAOfUAk9S5Z5PBdWRwukxL+r3wggcdgMJciXJB/dJRvh3L4GoV8quC4JvsacMAOQc7Vn7FabBNLaD9VcpwPhTmCesSbEcsUP1wi7/HtixPGvFSbn5Imx4ckYrnf+4zf+Jx2z8NhaHY7PlLZcWPvniUAfpOG7wVALnyDMbzFW/xs0xgC60j2pffaCBJ/vtBDq2Qid1r1gDM3Ewr2vQ9valqrmEYoLRFi1DfVdRFEbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8W6QroVXRCpCfE3XgHPNIW55+hj09hN6D5oQdhQUfU=;
 b=fY8S2lN0vHYe/bXdyYpcZ42PkgvAPCZnpFpjrCYWHUlTPwATKzA4EjhBLiQ53CfXeqKJAD9z44PrDoRc9zbWsKS0roErdduktiirAKQytQotHr0WFSKpMvWDeXw70HmwrkXU9/NvKsBcudz2AFn+iUw5jSEUq1Pu39h3qHYLYyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:27:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:27:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 May 2024 23:35:01 +0800
Subject: [PATCH 2/2] firmware: arm_scmi: mailbox: support P2A channel
 completion
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-scmi-notify-v1-2-1fdefc984d53@nxp.com>
References: <20240507-scmi-notify-v1-0-1fdefc984d53@nxp.com>
In-Reply-To: <20240507-scmi-notify-v1-0-1fdefc984d53@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715096110; l=6970;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NraZrTIh1CTKRDWgkHiH7fWJ14BXSdQDjIzIxPoolEU=;
 b=NidSZ+xByfvkRpnRR9RsCgCyIKNIB7dWBiIwq2/doiQs66LRCA9mMc0tWtrbRhID4GDrZicth
 S63ujB+PVvjCjG3GULCyRWnyGqUnVBItuHUXbhS3uKGC6X8FLjOv3gP
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8454446d-98d0-46b0-9e32-08dc6eaa28cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk5JWVByV0hJRmh0bkh0ZEpuakc0cnpQYWcvRFlmK0xlR01FalVwYTV1aGF5?=
 =?utf-8?B?UndLenhoUU5DeGhBaXFFVWJGbTdGSTM3NTBVVGVrYkoyQVpUOUtOZ0c0RkdX?=
 =?utf-8?B?M0pQNmNUMGZiNFZHaVlDbXZEV0xwTFpkcE9WNndaZUJQaEdlRDRqb2tSeVZ4?=
 =?utf-8?B?VWJrakR5VXBZeElFZTRvamRqRHgrY1ZnaDBuaExNZEpSTVRPZWdIa2plQjhS?=
 =?utf-8?B?UmtIbFpyRVpScVRqNUlpSVFmWk1MK0VIOWdybjJjdHUzOVQvTGo4SUJSS2tj?=
 =?utf-8?B?R2FyNDZCOWp5dGEwRHVNRVQxS0c1ZFFDWnp6MkU2cHhBb1F3ZVpkN3VzWFFE?=
 =?utf-8?B?V2VDbzNwY3BmVGVkMjZ6WUJBMitsZVg4UHlXK3pGTjNPUGp2Tk9jcWVaVU44?=
 =?utf-8?B?enZXWW9NbTJkMDBjWFhYRDhJNjhPNG9KeWsxcmxTYUQ4V2tzbVNjRXcvTjQx?=
 =?utf-8?B?RUp6NFM3bXBlQmdtVzQ1WmlBQmNyQ2VaVHNpNmp2K2ZVUVhQVmNmY0VHL0Mx?=
 =?utf-8?B?SjMzNnYxMzBVY3F5aTdLK2NLM0I1WlBVaC91OHpTdzhuUm5MZkIzRm1FVUFU?=
 =?utf-8?B?bktnbXB1cFJKbjVUenR6b0hwdStOaXIyQUg3eEJoM0owMHlNeGNtbkZkNW93?=
 =?utf-8?B?RkVpTkFxSzVYa09XN2JlM24waDViNU9oYk8wYjBLSEFQVEtKM0d5R3VhN09F?=
 =?utf-8?B?ZGlnRXhSbzdIMCtiZmh6dnpnU1pXTGhJMFNVTlVyYWJtcUs0SStmb1JKeEh1?=
 =?utf-8?B?UWxjdlJ3RWxnZE9SWGdzVGQrVjRCemF3c2g5ZVFQOGxQNlFaUFdUVDFVZ1BN?=
 =?utf-8?B?YXZHakNkbjVVYlNKbmREWnM1Zno0Ly96bkxCSjdteDdOVktKN3FxbW5YQmVx?=
 =?utf-8?B?a1hzOWs1MG9wKy8xTFlwd3V4M1hJQW1yV0hCNFVKK2ZhOHJYRGw2M214Rk1S?=
 =?utf-8?B?QXNWalNPRDRTSnpKQnZyUmlYVG5sVytVRUZMMEIrOTJ1T2dsNHN1bjc5NGNK?=
 =?utf-8?B?NnBYRHVXbUEzZC81YlRJeWZsb1ZIYmNtNnRPeEkxWTdIOFFGSUpPVEFkVnZO?=
 =?utf-8?B?VzlPNnFid1hvQklJeWRFTHc2U3lScEJFcFBRbVMxTk05MEpKdnV4dUdndkdG?=
 =?utf-8?B?ZUVKNWlwSnFma2dOdGVKTWhaWENpR0xWeTJLc05NV2Via0Exc25YWXdTMDBK?=
 =?utf-8?B?aExxZWR3R0ZxcStlelROWGlvZlFPbGRUbFhEMkdvRkFZcThHRDFMSmZnWlpE?=
 =?utf-8?B?SEtvY1JDOElRbkdybjhiM3dEUllucE5OUkNZbFZQbkFpcjNsT1pyZ0Roa1lp?=
 =?utf-8?B?bnZvWlVvSm1tNkNHYnRkTVRWR21XYWtJZjAxNVU5RTY5QSs3bndXYXhKODk5?=
 =?utf-8?B?NSs2Z1ZXREYvREpjaExOc0R1bm8wNmc4L01iWTdDdDRFMVR2V0tYM0FabUpP?=
 =?utf-8?B?YzlLR1BweHhhRElqalhLWEM1Z0xaU0NjeTgvYzFyK1Q5eFVoTEJ5V3ZzcFlR?=
 =?utf-8?B?L0x2ZHZOK2JTLzR5N0pFNlpWNnBBRjJVQmpud1hSWFJYK3gvdkg4anNESDNt?=
 =?utf-8?B?SkxZc0R5TjlaRWtnNVdCZEhoaHNtN1BMcVNIK2c0RjVtcmJzYkR0T1RZNEl5?=
 =?utf-8?B?aVppSENLVzhSOSswSEJheWs0UXZTRE9wbDZGVUhrWjNoWlBpKzhNMVdhWmdE?=
 =?utf-8?B?enE3ekNOTXRTNlVMR01UTzlEdEtjWDVMdDZLVW51U2o1N0xpYWFETngxanIy?=
 =?utf-8?B?ZzZpK3k5c29FeVdEdlQwbHNvSnBWalVTRWJkcmJBMzVnYkl6U2l4a25yVldT?=
 =?utf-8?B?bmhwRUhqS1VKcnBoNUxFdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3dFL2Q5QjlCNjZmR25VZ05ROXhMaGRkZ0RLVXpVaW9QbUJ3djNZbEVtWFkr?=
 =?utf-8?B?dzhIeEdUYzFRbWlySlo0US9qdjJMOXFCdUVxMENYMTQvZjN0MlpnWThjaGVD?=
 =?utf-8?B?RGlqRU9YZHdkcFoyNlh2RU9zYWxhVTA4d3g0L1k5WmpvendQb2lYd2p6SzR2?=
 =?utf-8?B?cm54ZlZLejc1OTJkeEU5TittYTVueUg1Q1BvbGdWSjhldjh6dE12RlpzRjdR?=
 =?utf-8?B?b2I4V0dOUk5RUTNJNkxpbFlwVDM2cWhVTmFoMUtrWU9wZmREV29tc2hNb1pw?=
 =?utf-8?B?cEhOZnE1RTdnNHpwVFJHZzdVYVVWSmg1bnBlL0E2K2RkNmFPRGFJNUdsZEZM?=
 =?utf-8?B?eEtWbW1HeVYvTmZBcHpac3FXWW80N3ZtUGFyYmJ4NTlnbFNCdWd5RzZkMTZI?=
 =?utf-8?B?R2pyMDdqOHphdEw4R0pHOFBuV29WbG9uaFhSTkh4d1p0ZmllQ2YwVVovNll1?=
 =?utf-8?B?R2luVkJiL1NxbHFlRkVHdlVONjhJRmRHN2RTU0FYazR1amFiSDcvemtEV2Jr?=
 =?utf-8?B?MHRiam05V0lQNWVDMGplNTZmVENteGRxTTZjMzdYVUgxQkxhWkhtQ1Y4cjdH?=
 =?utf-8?B?SDlPNE5BK3NvVkswRTVlNnREUURsYnFzRVRqWFg2eVRuK3BNNGNWNTUwY2hv?=
 =?utf-8?B?bU1mT2VkcE4vN0xUaGFweGVRem96OCtEQXZSV2x6cFM1Rk96ZURXL1h3bDBx?=
 =?utf-8?B?R0ZIWkx3ckJobHR6enFkZlU4cVZkR2pqR3N5akpyWStOQnZNWkxhOUp2Ym4x?=
 =?utf-8?B?di9MYy9OQkNRUUJWYnNFdjE3SUtEU2ZUOWVsMUVraGlnaUZIR3pXdC9DYUVt?=
 =?utf-8?B?cyt2Tmxxcm1HV05waTBsWVNJKytsY25EUzJHTFJ3ZnJSRG9IQXJmNkZtSmlU?=
 =?utf-8?B?bnJCaVFFU0xrMllXNHZ6TVY1U2tqdjh2TlRlVk5XRFMvQk9VZTJpaHkvRTFX?=
 =?utf-8?B?OGhwZVlNK1N6UWR5ZG15NkRzT0NwWlVaM3A0ZFJGSmM5bk5zdUU5VXlYa0tn?=
 =?utf-8?B?WG9JaEJNS3VIYlhTam5zQjRFb1RhYU9BQ0h5aEJWTS9jMVIzdWxPNzlzTkJM?=
 =?utf-8?B?VmdFN3JrSUZBcmVpaGsvUC85dUVmeU55TVFhQ3NDWFUwUEkwaUZtNWdtYXF4?=
 =?utf-8?B?NnQ3aXNIU2tsL0gwZkdIaFRaQ2RYVEpzV3J4N2lSRC9NTG5mOWNyMEVtdlVV?=
 =?utf-8?B?bzdrcXgvd2Mrbjd6RHpVbTFqOEVqNDRpcXordHRUWjFmVGl3L2R4b2prNW51?=
 =?utf-8?B?d2NlcDBWaWpjVENUR05zQVlMR0JsWGVhRzFheTU3SkdRQ0xmU1BENHV4dHpU?=
 =?utf-8?B?N3BuYkEwSnk4c3UvTE5XL255aUZZS1F3ZVJqN2UvMEEyT2tvSG44MVF2OTc1?=
 =?utf-8?B?UU5oV2NDb211c3E5aUEvZFIvRGluWkZVSkwySzhucmtSK2NTYnpvRFByNFBP?=
 =?utf-8?B?RmNPQWtDV2RzZDhpYWRoU2s0R0ZyYlNaRWJoREhqWGZ4d01QdnNnMGh1S3lG?=
 =?utf-8?B?OTc4aUV2RU5Pd3dNNEx3Z0NrdWVZVEZ2ejRWQ1ZwUmhFeXNhNDBWcUF3eVZJ?=
 =?utf-8?B?WTVhZitLekhMVFF1NDRzcEZvZWdOOGxNaFp3ZDdvMVhwNW9wR3EzbmlTU1NU?=
 =?utf-8?B?RmszYnk5a2E1WlRFTCtqcEc1Y2pQS2dVRDdEeWM1VGNnU0tTQmhjbFFaLzF1?=
 =?utf-8?B?cS9wVWRLZENOd0N4Y3lsOWp4bXliRUlQYmJaWTg2enpNV3pBbnpiaHBSVjNL?=
 =?utf-8?B?R3lLblZ0QjRBSHNEaWU0Q1o2OUkyZm1jejNBTXBGYjBLdkdTK0ZhQmg5SHIv?=
 =?utf-8?B?UDM5d1kzeFFhcTNzN1VwNHZNbnJsaUdwY2tTdER2R0JCSFB0TzM4RmoxNzZo?=
 =?utf-8?B?Vm5Vc0JUMU4rS3gybTBkU3pSejE5ckJwTXluWTZBRlZOdUpHaHl0MXhja2U4?=
 =?utf-8?B?cDEwNW1yMFhiL2RpbHpRWWFXSFppRzIyOTZzY2V5K3dBMEgvRG5PVHNWWGkv?=
 =?utf-8?B?MitwQ1hQajcvbXNBdTduNGYrUWc4eSt6OTlYaG04OHdHZmQvMXJxa1E2cHpt?=
 =?utf-8?B?TU9IcFh3TVdsaWcvMWQzWXZyZEtQZVMxRnRxUUhWUzBtQWkzbzlEcjkzZ0RF?=
 =?utf-8?Q?F0KE5ugid+6KYVQ6b7C/jfHcO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8454446d-98d0-46b0-9e32-08dc6eaa28cf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:27:08.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbMNZXrV61PcoVBRbyov7DTClo7yCrSlpw0XK5QvCSc9DYdLEF9SfdaIQ6PB479FK/L7e5tyhp/aYg/Hw/woMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Manager firmware is fully interrupt driven. The notification
channel needs completion interrupt to drive its notification queue. Without
completion interrupt, the notification will work abnormal.

Add an optional mailbox channel. If the channel flag has INTR set, and
the completion interrupt channel is provided, issue the mbox message
to Platform after the channel is freed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/common.h  |  1 +
 drivers/firmware/arm_scmi/mailbox.c | 51 ++++++++++++++++++++++++++++++++-----
 drivers/firmware/arm_scmi/shmem.c   |  5 ++++
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index b5ac25dbc1ca..4b8c5250cdb5 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -326,6 +326,7 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
 bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
+bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem);
 
 /* declarations for message passing transports */
 struct scmi_msg_payld;
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 615a3b2ad83d..59a3085ce366 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -21,6 +21,7 @@
  * @cl: Mailbox Client
  * @chan: Transmit/Receive mailbox uni/bi-directional channel
  * @chan_receiver: Optional Receiver mailbox unidirectional channel
+ * @chan_platform_receiver: Optional Platform Receiver mailbox unidirectional channel
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
  */
@@ -28,6 +29,7 @@ struct scmi_mailbox {
 	struct mbox_client cl;
 	struct mbox_chan *chan;
 	struct mbox_chan *chan_receiver;
+	struct mbox_chan *chan_platform_receiver;
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
 };
@@ -91,6 +93,8 @@ static bool mailbox_chan_available(struct device_node *of_node, int idx)
  *		 for replies on the a2p channel. Set as zero if not present.
  * @p2a_chan: A reference to the optional p2a channel.
  *	      Set as zero if not present.
+ * @p2a_rx_chan: A reference to the optional p2a completion channel.
+ *	      Set as zero if not present.
  *
  * At first, validate the transport configuration as described in terms of
  * 'mboxes' and 'shmem', then determin which mailbox channel indexes are
@@ -98,8 +102,8 @@ static bool mailbox_chan_available(struct device_node *of_node, int idx)
  *
  * Return: 0 on Success or error
  */
-static int mailbox_chan_validate(struct device *cdev,
-				 int *a2p_rx_chan, int *p2a_chan)
+static int mailbox_chan_validate(struct device *cdev, int *a2p_rx_chan,
+				 int *p2a_chan, int *p2a_rx_chan)
 {
 	int num_mb, num_sh, ret = 0;
 	struct device_node *np = cdev->of_node;
@@ -109,8 +113,9 @@ static int mailbox_chan_validate(struct device *cdev,
 	dev_dbg(cdev, "Found %d mboxes and %d shmems !\n", num_mb, num_sh);
 
 	/* Bail out if mboxes and shmem descriptors are inconsistent */
-	if (num_mb <= 0 || num_sh <= 0 || num_sh > 2 || num_mb > 3 ||
-	    (num_mb == 1 && num_sh != 1) || (num_mb == 3 && num_sh != 2)) {
+	if (num_mb <= 0 || num_sh <= 0 || num_sh > 2 || num_mb > 4 ||
+	    (num_mb == 1 && num_sh != 1) || (num_mb == 3 && num_sh != 2) ||
+	    (num_mb == 4 && num_sh != 2)) {
 		dev_warn(cdev,
 			 "Invalid channel descriptor for '%s' - mbs:%d  shm:%d\n",
 			 of_node_full_name(np), num_mb, num_sh);
@@ -139,6 +144,7 @@ static int mailbox_chan_validate(struct device *cdev,
 		case 1:
 			*a2p_rx_chan = 0;
 			*p2a_chan = 0;
+			*p2a_rx_chan = 0;
 			break;
 		case 2:
 			if (num_sh == 2) {
@@ -148,10 +154,17 @@ static int mailbox_chan_validate(struct device *cdev,
 				*a2p_rx_chan = 1;
 				*p2a_chan = 0;
 			}
+			*p2a_rx_chan = 0;
 			break;
 		case 3:
 			*a2p_rx_chan = 1;
 			*p2a_chan = 2;
+			*p2a_rx_chan = 0;
+			break;
+		case 4:
+			*a2p_rx_chan = 1;
+			*p2a_chan = 2;
+			*p2a_rx_chan = 3;
 			break;
 		}
 	}
@@ -166,12 +179,12 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct device *cdev = cinfo->dev;
 	struct scmi_mailbox *smbox;
 	struct device_node *shmem;
-	int ret, a2p_rx_chan, p2a_chan, idx = tx ? 0 : 1;
+	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan, idx = tx ? 0 : 1;
 	struct mbox_client *cl;
 	resource_size_t size;
 	struct resource res;
 
-	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan);
+	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan, &p2a_rx_chan);
 	if (ret)
 		return ret;
 
@@ -229,6 +242,17 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		}
 	}
 
+	if (!tx && p2a_rx_chan) {
+		smbox->chan_platform_receiver = mbox_request_channel(cl, p2a_rx_chan);
+		if (IS_ERR(smbox->chan_platform_receiver)) {
+			ret = PTR_ERR(smbox->chan_platform_receiver);
+			if (ret != -EPROBE_DEFER)
+				dev_err(cdev, "failed to request SCMI P2A Receiver mailbox\n");
+			return ret;
+		}
+	}
+
+
 	cinfo->transport_info = smbox;
 	smbox->cinfo = cinfo;
 
@@ -243,9 +267,11 @@ static int mailbox_chan_free(int id, void *p, void *data)
 	if (smbox && !IS_ERR(smbox->chan)) {
 		mbox_free_channel(smbox->chan);
 		mbox_free_channel(smbox->chan_receiver);
+		mbox_free_channel(smbox->chan_platform_receiver);
 		cinfo->transport_info = NULL;
 		smbox->chan = NULL;
 		smbox->chan_receiver = NULL;
+		smbox->chan_platform_receiver = NULL;
 		smbox->cinfo = NULL;
 	}
 
@@ -300,8 +326,21 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
 static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
+	int ret;
 
 	shmem_clear_channel(smbox->shmem);
+
+	if (smbox->chan_platform_receiver) {
+		if (!shmem_channel_intr_enabled(smbox->shmem))
+			return;
+
+		ret = mbox_send_message(smbox->chan_platform_receiver, NULL);
+		/* mbox_send_message returns non-negative value on success, so reset */
+		if (ret > 0)
+			ret = 0;
+
+		mbox_client_txdone(smbox->chan_platform_receiver, ret);
+	}
 }
 
 static bool
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index 8bf495bcad09..b74e5a740f2c 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -128,3 +128,8 @@ bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem)
 	return (ioread32(&shmem->channel_status) &
 			SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 }
+
+bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
+{
+	return ioread32(&shmem->flags) & SCMI_SHMEM_FLAG_INTR_ENABLED;
+}

-- 
2.37.1


