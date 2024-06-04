Return-Path: <linux-kernel+bounces-200099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C18FAABA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101F3B23D70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329F13E031;
	Tue,  4 Jun 2024 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="QaA0cbCe"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2115.outbound.protection.outlook.com [40.107.22.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1F65F;
	Tue,  4 Jun 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482460; cv=fail; b=QHG4JbvF9gb23jwHywreYIPLIbRpavZONqpvkf8dv2SDtBT7AgKlS/bN+9sbSTKC6Olpxe+yaVz/q0eN/+dPQk8DtJEs6cePStgzJxzqeahr1EYR2a9BmSgEElWkKSBYOhitt2mQRix1eX9t55/twznvCKzyFjtujIVEVdJhWac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482460; c=relaxed/simple;
	bh=Wh2DIfCB5AaSPSmUVnt7FNa67cEICcSIbMbgirYFpG0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=Ta52wolnU7R5oym7uWjOVdaRt2bb1hNDsqDGk0yKT0JpIK/WLXjzHxCrxNtC2MI68qPVhgkC0ppqZ7gBrAdfTZa6WyGDe20n6rHVZemFyjIQslvt269opFjl3QBcNlOokMfEg5uMCpJXHF6U+cAZJ925VQMtKw/eSCnLrUEySQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=QaA0cbCe; arc=fail smtp.client-ip=40.107.22.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsxoZUaqyFjsJDqtqt6gTlUGMm9yO31Eh458TNaW4flglILPqkCSYYsTPNG54pEtz0bzsCOX+Tso6+5IAnlougPz+OpOfHAHsqrqFa2FTVDJvY2j/m3tu5QlFLsc3RkMBTYyd5a1AUn6Ap0Hzmzv5SKwCDneSwYc2pQRU/78MJ4vR6k9mchFAk8dKcw/o8mO+9WQEhNQ4tzqjtJ+Wd/Ne0BmrGnWHw8EYyIbe9pr7rFuG76SJbIr7sSRiJvItp983vH5wRSvr4ADvK6ALb6AmUf7i9hy8e4zEeH0kil7Kty/WYFHcCy0cv2Cz22psyWczKG1IGgQjAuBxOjThjqQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKWRHnJnzazHeTWgcWN3cynjAouoReeOOsag9rGYCvw=;
 b=W82iBp3MicHNJRX5Pwv6B095dXh8Dn5fJTNvq7SDQJT9Ci0UxOHlBuEAg5mZSWIQWSyyySpR27s8ASA8M//VzqeEURw8aWj/E/9C5+7SQZO5QHFzNVuX6DDMXeIWcq3I3kIFyd4wig2xUyAm/8IoxhU0IkAYq4PfgHzAd46354lmKetaqOK4adMgU9pWH3K2JwIIdjfM2v/0TbPN36rWYtFMnwYGLFCsIMwG3LtlhZYprfJ+86Du0Vhn1TJjsjALGgHGSuy/OOMUDhfrc4v16lXg7o7jePpCSSRLWzIep9a/moW9BfhN/PQGqB0Aofb4r1WZZuqK/DvVGuyEBfOH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKWRHnJnzazHeTWgcWN3cynjAouoReeOOsag9rGYCvw=;
 b=QaA0cbCeNX8liR08T7ZD9hjU3W/grfBRfsJaTmbqoGT9jGTnCuDO3Nk9eIWzvmFDelhZTzJ+ADCTr0fVYup+zYu0J0PADH1rAi4zV4teilg4uI6So2pietIhfUIgoskB9JJMu7LVk57OiS897XDadhamjedtPBUg8cdFr8Aepzaaptlf9cNCQiF3tnIkyAFjhoPet65b2Y1wEP9U5xhwL/a/8XsnFJk3FcmtRZSkhstbGK3ViCGosmmrKjtUKl5+T4GIeqPsictI75MovU6S9xqF+/m514Z6vg7zRW42q/GFgHN7YUpb5jYuzbFEBdhbfuq8olTvqOJ0ANA18DBWiA==
Received: from DU2PR04CA0336.eurprd04.prod.outlook.com (2603:10a6:10:2b4::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 06:27:34 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::3e) by DU2PR04CA0336.outlook.office365.com
 (2603:10a6:10:2b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Tue, 4 Jun 2024 06:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 06:27:33 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.41) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 04 Jun 2024 06:27:32 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DB9PR04MB9260.eurprd04.prod.outlook.com (2603:10a6:10:370::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Tue, 4 Jun
 2024 06:27:29 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 06:27:28 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: devicetree@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: ls1028a-rdb: Add EEPROM nodes to I2C bus
Date: Tue, 4 Jun 2024 08:27:22 +0200
Message-ID: <20240604062723.82703-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::44) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DB9PR04MB9260:EE_|DB1PEPF000509E7:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: b52742ab-a799-4e05-a87e-08dc845f6b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|376005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aXpEWXU1b2RzU21IQVhyaDNEQzZ1bitxMi9JSmV6ZDQySUovVUpaNTdCWHBw?=
 =?utf-8?B?Y2JLZG5vc0xWUFJjRTIySWRlaktNVXdCL05RWUZQV21haXl5eXZ5RmxQT3RH?=
 =?utf-8?B?bHNvaVNBcUo3M2RnRzd2RnZXaDYrM0VmZnNpRGpIWWxlOEJxL0kraU9NZEMv?=
 =?utf-8?B?TTRpczdzZGlSTXl0VWg3bEpGU2luaEEzWmhJUXJKY1MrcnRFWXhTTUREcFox?=
 =?utf-8?B?Sm9RdFZBdlk3Q1FCK1YrMklVWVIyOWg3RGJYK0lacHltVUEybDZxZkJYUTBt?=
 =?utf-8?B?Y0g0SDRicmlqR3VIaHpMRm44QWk1LzZnSjBHL3ltZCs3M0E3RU4ycGFCbEdH?=
 =?utf-8?B?a3FLTDdlT0owMzVFMkpMSmkyQzBkdFowcWNLTTlZaUdhS2lvV3h2R21wUHUw?=
 =?utf-8?B?eUVVZ3lURklXU0d5WGFRYXBZMlNPakZKL1RJenBKY1MvdjA5OHNJNXF0SE5H?=
 =?utf-8?B?aXdCTGg1SHBscGJpTG4rYVpjcEV3RHh0Wms2aXdMbXVNTUdMdm5oR2hzZ3E2?=
 =?utf-8?B?dEhjcEMvbGNqbWw4K01CaUJZS3BTU21tcU0wZytyS1hVRDgyenFxQ1NoZ2hY?=
 =?utf-8?B?T1NlOThuZXAzYzA2bitKUzl2WTkyNC9OU1JZNG0vbmNDZ01qSmJrNHRPMDNq?=
 =?utf-8?B?WnFuZzlndmJaeFIrdEV0N0daOEZSRlpmVW9Pc214S1dxd01xQ25IUzRTZlVV?=
 =?utf-8?B?VHpuOUdvNWhGMEpXbkh0QmxkUUFvWlhnemdCa2FkT2ltRFpsbVdzcTRpZ05J?=
 =?utf-8?B?UXFVQUZZMDM0Q0lia3BNWGo3eWpjaElUd1FKTTFRTDlWaXM5U1NXU1hLNkJT?=
 =?utf-8?B?RTZCdUlhVm5uU0MveEtPY3hIWmVwS3ZnbjAwS3kvOVFrUHZqOER6QVduQ1NX?=
 =?utf-8?B?c3RNczNTeTBLS0V6a1ViZDlZTzRzc1Fxa0FtYllBOTEvZnNCUjRVRUxFMEVR?=
 =?utf-8?B?Yy9GVzBoYW9YZEoycURNMUlsWGNHOG1BclVVbStUZ3Azdi9Nd1lJR0l1ZkJD?=
 =?utf-8?B?b1hvV2wrZXdMRmROV0dUQXQrdHBaRnIzOUFQQWMxcXNrU1JNK2x1czJ4SGJB?=
 =?utf-8?B?STNJdzU3Wk5CV0dVeDdqbU1wM1U0STRUbDNNQk5JZGxlSXoxMy9UeW9LOE1v?=
 =?utf-8?B?TGdTMXY2NGpTYnJuL2UyWmtFWUZ1WjgvTlc4bE1VTUdQd3ZsSnd2UFl1bEg2?=
 =?utf-8?B?eG5sTjk3UXh3QXhmM2M5SHFPVE5naFRRNktXa1NEVVJNNXB5Sk5iM0tBZjUr?=
 =?utf-8?B?ZWVjWjJ2SzhnRE9HbWZwVlgrVFozQjhzSmNEQ0JPOTZIWjBtZ29XWG9ITU1v?=
 =?utf-8?B?Z2ErUGw0UG5TN2xIOVE1MFVUaWU3SWZSYVpaeEh2ejQvS2NQT0Z5YzkzRmRS?=
 =?utf-8?B?NFBoby85M1l0cG9KUFJTZXFWVG9HU01Oc1hyUUhuakxZaWdHcy9uNkZIK3RP?=
 =?utf-8?B?MUE0QlV1R1pwM0ZBRWNuREd5THZYTlhRWlduRldaNDhBcE5Yb0pxZjcxZ3F6?=
 =?utf-8?B?dkcvMWdJODR3K3hpWHVuRmk4Rk16SW43NUdEdUl4anhyL2FTR0VZQzJLYndJ?=
 =?utf-8?B?b3RsbWRXSzJWWURLWnJSUXkwbTliaTNEUWs3MlhGNW5LK0I1dHFKRktqYXRD?=
 =?utf-8?B?YTFiY2RUTFltdTBVOXA1Rmd2NENrdXA5L04yblRPMTJsTWdkWDV5TmY0SHVN?=
 =?utf-8?B?S0FkUUgzOGhra3dxNzNYenlncGd3b2pOcDBseGZob2J3VEFvQXZBVkNtbkJz?=
 =?utf-8?B?a3NyemprL2pGZWFZNGVpcWJvS2Z6cWFBd1JNVDlTUTEyYUpWa3lOWWl6Tlg5?=
 =?utf-8?B?VjBmellUR3hNMDJEclhtZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9260
X-CodeTwo-MessageID: 5f6f6085-28a7-47a9-b797-b474336aca9d.20240604062732@westeu12-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c99f8488-228d-4347-9f04-8a0b4c3c2a3f@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	958e1619-007b-4f26-998c-08dc845f6852
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|35042699013|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um1WMlNPcUNOWFkyYTB0alk1RDRLQUVBemY0VnpFY1hVRXJpTGkxOHBta2Z1?=
 =?utf-8?B?STZYWUplVGZxWDQ0R0V6dzJ5ZDhzejYwMlREV2ZVYkphM2svbEZyTmIvZjM2?=
 =?utf-8?B?ZFk0c29uS29TQzdMSzlTZjk2WXdhQWxtUU9XUmU5Y3RnK2lsR003ZEZhSC9z?=
 =?utf-8?B?OXJJOEVZaG1nbXBURnllRnhYSG5WczF3NTRkWm5PK0sweWxZckhWdTNLUmUz?=
 =?utf-8?B?SCtpUmt1d0N4enY5c04wL2lXMlBKSVRxQnpRVEo5MEVJUHNDRFFtOHdYNlB1?=
 =?utf-8?B?SzJHd1pJbW5yV1FuY0ZvR2tuQUt2eFM5MXhRZExtNGNLbW9nNGo2bEdFNG9o?=
 =?utf-8?B?aG1vVnIvVmFlQytQaE5BRTA1M3g2RUh5UmU3NWVQUjFDVGJoQjhoOFYxM0dj?=
 =?utf-8?B?TStONEN3QWtmaHJHbkdWdWRQalhsRHo2N2F0S3ppUjFLNjhnTXZsRm1DNDZP?=
 =?utf-8?B?SlEzQmhyd3VEN0hlR1gvUXo5UHpnTWRoZjR0dWhJWFhMSk5oRDhhbCtnMDd3?=
 =?utf-8?B?akdKQ3lDWUxUcHNZRmdEU0QvVmd3dXY1TXd1UkxDYUdveDVONExReFBaNXJ0?=
 =?utf-8?B?QWRqMnl4WVZYSldaMmQ4MW0vU3VzVS9xVmJtZzVjOU5qNmtrOWw4Q1hKNE4r?=
 =?utf-8?B?YjRLWml2ZmdJY3F4QkRjdzk4aGVZVWpkcVhPazFhQUhxaUtEcnRRV1dib2Vq?=
 =?utf-8?B?NytRcmZmZ05EMFBFMlJLWUJwMERLWTQyZWd1d1JPWDB5RDROOHRKZjR4ZXBn?=
 =?utf-8?B?S21qVDN3U0ZrVGxKNG1WdU9RQ1NiR0xjZW9zTUhONVByTW5wS3lPaWlxU2xl?=
 =?utf-8?B?NGJTRDRHK1hBTHQwNEZrTnFyd1p5bnNOUmgxaU9DamNnWElnOWtscXZkblN3?=
 =?utf-8?B?NTRNeno3TTExRUxlS256Uy9NZzRyYUd0R0dkK1FZbi9HbFkrb3hHNzh3ejRE?=
 =?utf-8?B?dnBGb21HRTJ2UlJkZ2QwR3NJTWFjYlQ0UDhUVFhRK3c1dmw5K2JXUmhzbEFv?=
 =?utf-8?B?TUNITDZuTzFCNmpkdCtOY1hsVmdTQkZvQms4RW9HT0RSUlcyaStESkprMTdE?=
 =?utf-8?B?U2VoV3YrTGdVTmVUckxWZ0IyRk1OQ3lvVG90U1ZEY1k2Q2RPTktlMkRxOGVW?=
 =?utf-8?B?ZnlXbit4ZUxzY1FaZ2plOGVpTmp6a0FPcGZnQ0QwV2FHNG5lMjd5M2VvTzMz?=
 =?utf-8?B?SkwzY21EaVlkVEVEREJiSExBYkNBM3ppMnBiUE1YZzJzNWlPeFVwN2E0dkts?=
 =?utf-8?B?eHlWUFJ6YzBSbHFYclhNa3FVWWpZK0pOK2M2UzQvZHNZKzQ0U2J1SW9RU2pX?=
 =?utf-8?B?cTNRL1lsQkpCWGJIY2JGcXB3em51RTErOE5XZGlvVTM1YjBFb3RmMGVJZS8x?=
 =?utf-8?B?Yy8vem0yR0ZNRUUzUlZubk5wQzhSb3ZRS1pMa1JoRXVzdnowWkV5ZjN1WHVj?=
 =?utf-8?B?RmxmR1lXR0tFRk5waUxKZ0d4UXN6Y1p6TEcyWW1peEdTVXgrdlc3Q2dqeEZT?=
 =?utf-8?B?Qys3TWdPc3F5dEpkSkJvc2hrekMyM2pOTE9sVnRjR3lQcUV5eWsvWCtsOFcw?=
 =?utf-8?B?L1ZLY0JGenRlQUZGVFU5ZVArQ1h2Ky93cFBWVlRQSzNKMjdFN3IrK0hmZW0z?=
 =?utf-8?B?Zk5WRXZSaENLUW4vdmdLUXhYd1F4QWxLa1ZtLzAzTHdMeGpwWWFnOS9wTGpo?=
 =?utf-8?B?YTFjS0w0dk5rNW5QaVFFd0lRRC9xV3oxeCt2bStuNmpDNmtRcHhRZU1zRjRs?=
 =?utf-8?Q?CCi1DPAvXEVdEveT15yn8TqdIpe/XTh2c7U353S?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(35042699013)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 06:27:33.5140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b52742ab-a799-4e05-a87e-08dc845f6b53
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840

The LS1028ARDB board contains three EEPROM devices, for
storing boot code, DDR SPD and board information. Add the
missing entries to the devicetree.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-ls1028a-rdb.dts
index ecd2c1ea177f..757a34ba7da3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -201,6 +201,37 @@ i2c-mux@77 {
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
=20
+		i2c@0 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0>;
+
+			/* Atmel AT24C512C-XHD=C2=ADB: 64 KB EEPROM */
+			eeprom@50 {
+				compatible =3D "atmel,24c512";
+				reg =3D <0x50>;
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+			};
+
+			/* AT24C04C 512-byte DDR4 SPD EEPROM */
+			/* Documentation says 0x51, but must be even and i2cdetect says 0x52 */
+			eeprom@52 {
+				compatible =3D "atmel,24c04";
+				reg =3D <0x52>;
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+			};
+
+			/* Atmel AT24C02C-XHM=C2=ADB: 256-byte EEPROM */
+			eeprom@57 {
+				compatible =3D "atmel,24c02";
+				reg =3D <0x57>;
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+			};
+		};
+
 		i2c@1 {
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

