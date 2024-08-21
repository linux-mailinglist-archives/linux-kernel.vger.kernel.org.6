Return-Path: <linux-kernel+bounces-295895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBC95A2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123AD1C2206A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45908154448;
	Wed, 21 Aug 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HPNMwVW5"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA015748B;
	Wed, 21 Aug 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257198; cv=fail; b=VvQSfJrouXQNIhyNSKDd490PHemDfnqeS7E4kB3Lrx+p85ipiMzuy8a9+MV7/ToeK91fQegi5o/AVhgo4r36IqExRA8bj1YsfBGwW3zc/j13lO1o1PH+0dVTmjR0gIQlm9zjRKe34DAVPwZIeAP7vRRk8dqfr4em25SSSNiyPr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257198; c=relaxed/simple;
	bh=nEj/K1ERPksvYT9CUWSWEh7L//sN6UL3ybiMuxZKiIg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sU/0449ke7juEYeSEVUVsMOaoHVirokba2V7vhRT/v8sBeN9EAQK26uWBUST95E/TyyenlDCtQb8e6wt70R4GxgHmEPWO8DaHExvVYB4BAuMFJOJNnt7g3Mu3gR6gG8svME98oERectOCR62q+7KRCiWFMu/eTGzZPI/Y9x+5rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HPNMwVW5; arc=fail smtp.client-ip=40.107.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIN7F9pwGsXwVjVMCtMPHaWRPU+Pddo6Wp+Mhr+g0Zcj8CXi9cB8yQBGVHIYbRmeaAxZzK+zh4XFTruzshdIFbbucDH4nMQXYHt5QCtmUxnUMhcPSmOiLRXb+mRIlmrfw4bnNF5AaFycNfMkaJrQIbz7JQSqMlBZg82kAVHzHJZddIOaUh9ACNBK8wi4qgB2b5okZiS1ppiJdwSyNsQu3ddWSVONawjPNm9c3NC3xS5lJsabaoa0QNjtJ/+BUOLXNUg2NsI8a77vNLzw4iHG5yxUyO6TUN4pEJWpLAc9M+EglltE3P6B6j9AbUpRTzFp6TdRypKRS0g/McN6YL1ViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgm4R5uH4tZ7nv2R+bN4sepTZE/cef+kW8N7+irfSno=;
 b=SoGRIZnN8Ep8LJypMgeZrN5LQ0QsK4PgjvqXTgpGsizi0BztjzJteKC9f1IQt85sQRTLC8dxDCb2A0I8z2ovtodxZEUWDXI9q6AkrWyynFd4Rou5ZwDYvdT5ZkoQ/obCMyCr/rTr3SevK72VR6JvqTm2navycJEJhCfsPviCFlveoBDluuK8GquZ7eb+XcN/jGfI7uAVJUQPu9BLcKVAZeUIo6vA9pqBnRy96NkZ8RmEpxFohGYsqzMND7yd9FT9ma0AxuRFRPAAOhazUf/lAZ0lGDHJiVDyhg5Zhi/WR7WFcXrxTgVlIhDshdqMbtJaEuJl62WcwN7cHZ0NGToi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgm4R5uH4tZ7nv2R+bN4sepTZE/cef+kW8N7+irfSno=;
 b=HPNMwVW5PfbPkZbCMpASH+eWpLSLP0RB12JBw0GA6DcK9X0zNa7iTMlA97Q9AXXvo4Hw74r8I5a9OMG9GCXRco6vjeA3YJDBzq7P3B/mIzrbyTtwNfw56oVLqIRtMhr1I9kPwQyqkgGrvFLKXdGQxzgtC4wLZj7COXl7CfrNrqPEC3fjK1YLMJtqH/Ivr/MD4zgjrEeK1BKZal6iXjFrIJD+A92+mp6/mV5wVJcIJ5RKGl5o5Q3A81+9EzXhb+jWONFguPuPl9my+m6xg1BpkvNDexgT7Q0SuHDJ5r7x00fpSB8UjabDjtOofQLiyrt7MqzVHpQWkALlfZrMYA4QKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 16:19:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 16:19:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 21 Aug 2024 12:19:08 -0400
Subject: [PATCH v2 3/3] usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for
 system sleep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-dwc-mp-v2-3-2a29b6a5c2f4@nxp.com>
References: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com>
In-Reply-To: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724257180; l=2128;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5+IVkwBerM0rBDtlaz9W/KvOLIbVp8/vpBPWsSyKKOE=;
 b=P1kcUcvTcUNH7zx+WBhqy7hSd3LltbRirQhmDI7Ocvl8hfzpPGrshn6IyLVnLGV3CUFoaqXK/
 H9cL2g+JFEABuHydmCBTko0cwLgaQCsZFjH2naK9t98gvyM1/9A34Cn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd0510e-7b33-4b79-2412-08dcc1fd1771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2g4UnF0NWl3TWoxc0dFa0M4RHNHYWFVbzQzWWR1Z09MdkFDbW81Y0EvbFpp?=
 =?utf-8?B?OWNCaHRjWGxhNXhJakN6T09zZmc1MmVLeDVGMWE1RjRkMnpuZE5OV0t1QkQr?=
 =?utf-8?B?cDFiU3QyME5SaEpyZWpXZi91T0VBeExpTEdEbno0WGhDZGE2TXFFQXRJWTRE?=
 =?utf-8?B?QVcwTWtLc244WUhYZEhGc2YrMXJ4TzBiSUE2R0pDYjhVTmI2dDF5WGlIY3lr?=
 =?utf-8?B?QUoyM1piVlBRaEpxWldvNEZsNE5zTmk0dStuTUdBYk5BQVM5eTJpVVhPSUVx?=
 =?utf-8?B?dzNKTFdOdlNJMEM3M0M4aVkyeDMvNi8xcnpDRzEwcXRPaGIyRGJiYzh2SmU0?=
 =?utf-8?B?S0VTb0l3ejRBQUhUb1hFcmVNY2JWOE4veHZaNnd3aDV1UkhFcmVkMTdPbGlm?=
 =?utf-8?B?VzcrdHE0ZmtCcXkrR2ZLdmgvVExHMDhnbUVjRWt0dHZYYTZ6Q0VsZWpXemhE?=
 =?utf-8?B?RDh5SzBQYjJIcGtJZkRiOC9HYTJBL1NaZlFVMzVGdE9KWlFSVkhuUVA2TDhj?=
 =?utf-8?B?NGk0ZGZLRkJacytmVHdoSjhDeVNuYzBESUhYdjVYTjF0SUVHbGpsMk1FdDI0?=
 =?utf-8?B?Wk9LNlB5UzNDcHhkaTFxak4xMmRDOFlPUWE1ekEwVlkvU21QYk00eHVxM1BI?=
 =?utf-8?B?d3dXS3I1TmNzdjgvZmpZNldOdjc4TzFHZWxJVUpKdFV1SHZ5QUFuUTB2MVlq?=
 =?utf-8?B?bHVhaE5xNHVnOG5NOWVIT2xEcSs2eWFldnR2b3VlbzRUY0RRUGxCUHg4L25K?=
 =?utf-8?B?VEEyTHdKa1U1Mmd6Y2JiQ29DMllQcW1KUm1OejdnMTJzWEErY0xVbjVZUWhy?=
 =?utf-8?B?bWNuRDlkOVUxRC9XWlJMaS9qYjNneVRVVGJ4c2NaeHRSUG4rM0k5Uzdhb2pU?=
 =?utf-8?B?UVpFRmFGdGY5d1k3eTNSMEl6VHozS0pGTzZqSHlwdTVFWnhqUGpNOUVNWHFu?=
 =?utf-8?B?U0xGNmRtVk5YVjhmTmhTd2RUTngwcDJyQUFhazZtT0Frb0xIczRRR2s0UzRq?=
 =?utf-8?B?L1lKdGFMbWpZeG1xUnQzVDhuWWZXVHBtQVZWK2c5SC9hRUczM2ZQQzFnNGgw?=
 =?utf-8?B?Y1dRSGFTd1ZldGFvY0VvY05Kd1R5QTY5TnJ0TTFPK0RMUy9acGxMYm41ZjU4?=
 =?utf-8?B?dTBtYlBCeTkyOU0rcDAyeWVDczNENkpPa0VJRklFN3ZBalZqZ1YzYmNCYTFO?=
 =?utf-8?B?dWdFOWxHZE41dTdnZ3BZSXVqNi9QK2ExbFJTV1dHeVUxUjNnTDRaK3BrbE9I?=
 =?utf-8?B?aGxNWERGTGJieW5kNUVLWWYwd1p3aGFoMjNVNFNNSXhTZ3RMbHRyUERGbFlq?=
 =?utf-8?B?Tml0OWh0Ry9sM3NrR2pJcHVlQ0xQYVlNQ2d0czlTNG91dE5TQWg4Z08wQmRv?=
 =?utf-8?B?Y3dkc01pdFhyOXZEZmcvcXh2cFR6d01TU1NhK3NFaG5RcG1pMEFYRitwVEVN?=
 =?utf-8?B?cTRaUU1MQ280ZGNQbEVJWXBGTWVhU3ZxdjFaYzRLQ2RheGRROWVKWlNLQ2hZ?=
 =?utf-8?B?OTRZVWN3dHRXdE4xU0pqOGk2U1VOK013aWYrYkR3bWZNQVBmekdVU1pPQ25K?=
 =?utf-8?B?djRWb2o5UTExdDA5SnNaaXRHd2s2MWNwRWpCNU5nYlYzVFRKSTNMckVVWmdp?=
 =?utf-8?B?Uzh2cXJlTEd1clJ6TFJ1cnFnNkZ2UDllcVdxd2tLNVowMHVURFRRbFdIM3NW?=
 =?utf-8?B?MHhOdmxjdGVPZnJwQmRVTkdCem4zZFRZRDFoa0RmNVZvM0xHRG00RlE1ZW1T?=
 =?utf-8?B?QXNlZngwSXFjWGxqckFqeUJhdEpBQVFpNW9WTHBYZmkzNUhzK014bTk5Vk13?=
 =?utf-8?B?Z0pOQkxRN1NFWHZIQ1QyMDRyaHNkV1lucVZrbXNsV1JhcS9kbjIvMXRWZTlz?=
 =?utf-8?B?SGFiWmJHQllZK01aL1h5OVh1dWtkNEszQS9TNWlYY0w1RGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG1KQ1NkVElaRXQvWTV6Z3pEQ2FRSm5FT25DbFk0TDJiNU9ic254dGd6WEtt?=
 =?utf-8?B?ZW5sY3BjM1lvRThoRmdxQUp5UW5uZ0hPSTJiM0RJczlramRMWi9kaVVOMDlQ?=
 =?utf-8?B?Zk5DZ2NmaXJxcWltL1J3b1dqMlZ2a0hra2U0YW56VVRoc0ZzNDgrZmpKNFF0?=
 =?utf-8?B?TXU5N3c2bDNDNWxKUjlLQVBhbkVrS2xpcDM1YTk4R0JiWGdZa1hjdHVCcW5L?=
 =?utf-8?B?WkUwSDNaUFVKR1huUFFRZVcyeEY3SVZxNWxGMEVuQ085OEdwOEcrV1lRUFp2?=
 =?utf-8?B?VjZQQUtuTXpiMnA4N2RyQjNYT2xVaE9wd1gyQXpZbUZVcExLZFpLSWgxdEx5?=
 =?utf-8?B?T3VtNkxBWis2OVkvVHJEVnByQ2RJcGFXMldqQzlQY3JZV0Y5aTMyM2RxN2Yx?=
 =?utf-8?B?Z2ZkNm13NU91d3BVTTFVS2VuVXlNUDYxUmtmL3V1V2o5cUtHY21rN3ZEVWEr?=
 =?utf-8?B?dTBnM2ZGZGNHbjd1TjVzV3J1cVBsUmFUVWkrclUyVVBmMlJQcGFHOGcwbTJn?=
 =?utf-8?B?MkdLem9mWVdXN2RTeFNKMzZsRklseHlpc1lRMGh5TUpZY25VSDlBamlXSnE2?=
 =?utf-8?B?UHZvcEV6QjdLUTAvVzYwVzk1MnRlL3ZRcHRBS01Hcmg2NWxKenBlcnR5Z3Vz?=
 =?utf-8?B?V3p1ZEZ2V2o4cWdWdGZ3dXhra2psWXJaK1BtbkFydzNpN1JtUS9PbmcyZWN0?=
 =?utf-8?B?bm54alJpYjdIMmhOS0M3eGE1SXlid3JWVUVXTjZ2M0FreWUzN2ZScHNqczY5?=
 =?utf-8?B?Y3JzUDBMc3VBdjM1L1k4eGt6Mk1PM2E5RHdEUkE5d0ZqK2Y3bVYrQ28rbnV0?=
 =?utf-8?B?VzkzcXp6V0l2VkhMazhESHlqZHhqTkNHZDVDbDFVT0F6NERDbXNlaXVPMjFo?=
 =?utf-8?B?bmhqNDg0cjNoMEZLSXV4MUh4R3NnQStQbWRZUTVsY3FGaGlRV3cyNGdCSEF5?=
 =?utf-8?B?M1cwTDI2ZXFPMWFOS3p2VXdXSXl6Q0hJUFRZT1JDSzF2OUVHMmlXTVplV0Nw?=
 =?utf-8?B?QjA3MW1RR1puMk1iMnloUzMydE9nRkRFM0NJZU1FRjRSV1JJa3hSUXFOUzJQ?=
 =?utf-8?B?WDRpaFFtOGlUaHVNZ3BMOThZdVBpODFsUTkvWVBuYmNMeTErYmQvZG8wWkdJ?=
 =?utf-8?B?SFdBNUxOSW01Yk5MM3NqVmtXMk5DTlNpOGtEMVFmS05CNEsxSXZzS2QvQTNn?=
 =?utf-8?B?UHZHT1BQeW5OdU44Wm1GK0pqWlg4Y0FMNVlWRzdHYkMxNHhzeEl5bjQ4VXE0?=
 =?utf-8?B?LzN4VXQwVlJEdmovVVpDOW4rdDhvNjNNT0JSdFB0R1hqNVZqTk04UFZJQ2xV?=
 =?utf-8?B?TEQ4UDR3NElnclVReXExUkFPRFhwOTF1MjQyRmF1Y1VNcS90OXNUZURvMGha?=
 =?utf-8?B?azhjSThkMnJ6bm5xbE0veUhtRVl2WDZtKzhDYmNXTXBacFM5WnVwdXNXU0dW?=
 =?utf-8?B?cmZHOGhOc25kcnMrTFNmVzY5Rll6d1ZnSjBoakxONnh1MnhheEhBVHlOQVo1?=
 =?utf-8?B?V0g4ZDduMWxjWlpKQU5QZ2VFdlNPaW4wWTdwODR0cG9rZHhRT1NtWnRUc1V2?=
 =?utf-8?B?dVByYkt0b2QxeksyZno0SFNUYlZVRkgwcVM0ZUNzNU9qVVR1YXNoRWtSKytu?=
 =?utf-8?B?M01YYW9Gd1FwbTRENmdVNEtRKzRMMzI5MGZzeUg4WTJTQzlMR1JFdkl3ZWtG?=
 =?utf-8?B?ZnJkTW4rTmtReHh2OFZZMWE5RjY3WUs2emNnNlBwZFNXbzlvZWh6aVBRREdJ?=
 =?utf-8?B?RFJRM0EwUFlRSnEwS0JBWlFNWXUwTU93Y25JZ0hrc1J3WklvOEhRaEdDWDNT?=
 =?utf-8?B?bDdvalM5R0tLQVV0S0lVSnFNdzQrQnk2d2VwT3R0UDBYcEFkdU0vS0hScVJw?=
 =?utf-8?B?ZGFMZVZIU0RWaHo4K0NTMFd4NEtEZ0lIUVFFeGI5b3h5N2xvUGFOQnZ2YURu?=
 =?utf-8?B?TWluTkZSSFIrZGpKNERvTlQ5eldTY0RuNXR1SU1NUGlPbVlKOWp0czZyY25R?=
 =?utf-8?B?RXNOMHdJeHR0WjBadmhMZkplaWJ4bnpWbnhOTUJ1RTN6ZzNnTDFmeVd0OS9r?=
 =?utf-8?B?MEpMUVE4RFhBNzMrZkprYUdUaFBrRThWRSt1SjdGblczU2czQ3NySFc2SFlh?=
 =?utf-8?Q?k0sdzsF0cyinSI1Xozkneoagv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd0510e-7b33-4b79-2412-08dcc1fd1771
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:19:54.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u06oO0KvO2Ku56fBQ9es2BtRe2kCnMwR1YnETRAPradlKiTSSOHF5BZCQNxRpnJlr7z/dzFp653wh61BhUEIew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817

From: Li Jun <jun.li@nxp.com>

SS_CON and U3 wakeup need 'ref_clk' on. iMX8MP turn off it while system
sleep, So disable these wakeup source and only enable DP/DM wakeup source
for host mode.

Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index bd6953246f42e..02159cd820a10 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -96,7 +96,8 @@ static void imx8mp_configure_glue(struct dwc3_imx8mp *dwc3_imx)
 	writel(value, dwc3_imx->glue_base + USB_CTRL1);
 }
 
-static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
+static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx,
+				      pm_message_t msg)
 {
 	struct dwc3	*dwc3 = platform_get_drvdata(dwc3_imx->dwc3);
 	u32		val;
@@ -106,12 +107,14 @@ static void dwc3_imx8mp_wakeup_enable(struct dwc3_imx8mp *dwc3_imx)
 
 	val = readl(dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 
-	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci)
-		val |= USB_WAKEUP_EN | USB_WAKEUP_SS_CONN |
-		       USB_WAKEUP_U3_EN | USB_WAKEUP_DPDM_EN;
-	else if (dwc3->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE)
+	if ((dwc3->current_dr_role == DWC3_GCTL_PRTCAP_HOST) && dwc3->xhci) {
+		val |= USB_WAKEUP_EN | USB_WAKEUP_DPDM_EN;
+		if (PMSG_IS_AUTO(msg))
+			val |= USB_WAKEUP_SS_CONN | USB_WAKEUP_U3_EN;
+	} else {
 		val |= USB_WAKEUP_EN | USB_WAKEUP_VBUS_EN |
 		       USB_WAKEUP_VBUS_SRC_SESS_VAL;
+	}
 
 	writel(val, dwc3_imx->hsio_blk_base + USB_WAKEUP_CTRL);
 }
@@ -307,7 +310,7 @@ static int dwc3_imx8mp_suspend(struct dwc3_imx8mp *dwc3_imx, pm_message_t msg)
 
 	/* Wakeup enable */
 	if (PMSG_IS_AUTO(msg) || device_may_wakeup(dwc3_imx->dev))
-		dwc3_imx8mp_wakeup_enable(dwc3_imx);
+		dwc3_imx8mp_wakeup_enable(dwc3_imx, msg);
 
 	dwc3_imx->pm_suspended = true;
 

-- 
2.34.1


