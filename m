Return-Path: <linux-kernel+bounces-230282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3761917AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A351285D14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBAC161904;
	Wed, 26 Jun 2024 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aDn/7TJH"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041116089A;
	Wed, 26 Jun 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390190; cv=fail; b=GOcx6vkdaFD9XPsgq0pMMsvUnKF9mhcXv90M1G15MZH6uczWxRREynegVaf67+UsKXCWbdNgHQ6tyjTRcawOxzshNTfn+u0PmwlrrU+62om/c8FvMjh8mzfJQpwIgxHaEEl7LQT1p96TlQCF1F4PZC5PV/2fSwBli1OdS1mdYdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390190; c=relaxed/simple;
	bh=G4dFF7RRr2NNI3rf3eXi/R/8vjhVTjK+BD5CLTOuCM4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=InG6KGYnFUVy8JaU/+ikim35uJ9neeOTDoDIq9lr8b3fkwk3j8K/0Hg3TEI27aYh/DhJYuN7jD0OudV9jKcgdreA+lCn75DITwqGNjFM0GoZKCW4JNE4PXt6OJk7qrhL10Z4MPAc3HeKGsHP2KrmMw6DqBEBY6IbGeqDTqWopDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aDn/7TJH; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1l1OkO3Cv/IrsBJNiYNbEtxzZ3Zzpem8X9U7RgTaoSANCPgQ9scldjxaUgUUJi/MoNwZEStDO2sN9/K2ZqKYhtTqvoZ4Zwo89okspLGWb4wFYVHJfydI2/zVzRCksNCEh6w4Pz0EMxaxCyf+sva3qhUMpXoQHsKqCVWGrCDzcQl73xzKYwxttYkxuP/WZIISYHuLITCQv0H2jHPb2vB2HtyMMpevKLcsjgStQRgFXgbtet+krVxqRwomrEkoWJVu7tZSOwF+m5EdpbdfSSamaXSGP/WoIV/eZxkbHsTvR9SkXJ4zRn44K2QD+ZLd7hD0YfJWIvBUONNIIvSHMDUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5JYFnzCQkKHPS+LRrU4FT4zFpiNqer6nnCd4t/ZTUM=;
 b=lW0RmsFMS1DLvys7l6BqfY4JUHAntVOnBcBjCxiizns7wVS3PjYqy4eVBHUm0yWf5yli8vdOpum6qc1lZda8cuVJYf9cYCjX3jfAI+N82fI9+mn5QR1K+HwsIEYXN5NGxpkgmEefa/EExpypq+b2cB/wMbZvvr2FmlubEI6CLpzHWbSHC3nV+6ZPBBDhUG9Hrn2VRFlwO4JF/XYPQBbMs6pBDahjYL6j0iNUkpmcCwg5SqpCu3RSFAYpfSsHOYBPJLLX2v9ACv/oLT9AUsJG4lKzomabZz2hgpNLN+AVDZ6bSk4TVfGeeP1Y1XqB5aU5TdvdQ68BRvof2KRC35ZERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5JYFnzCQkKHPS+LRrU4FT4zFpiNqer6nnCd4t/ZTUM=;
 b=aDn/7TJHM/I0sxEh7+SvAIzUPLh1yybvKAVKYCuu1skiWI98a76ZhHwznxEFN8SDmyNlxPBgt3L5xnrFYo7EGEmCAgEWFkK0I2t557g2S9+XUtrdXCcu9yE0Q9DuddOMvV+7BlmFd/7aJqkcVmt/dpMfklqQAo3hhilnDcSuH5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 08:23:05 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:23:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/2] firmware: arm_scmi: create scmi devices for
 protocols that not have of_node
Date: Wed, 26 Jun 2024 16:32:09 +0800
Message-Id: <20240626-scmi-driver-v2-0-8f2f85b87760@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAnSe2YC/23MQQ7CIBCF4as0sxYzYAPRlfcwXSBM7SxKm8GQm
 oa7i127/F/yvh0yCVOGW7eDUOHMS2phTh2EyacXKY6twaDp0RqrcphZReFCoq42BqufeLHeQHu
 sQiNvh/YYWk+c34t8Drzo3/rfKVqhGrWNzjlC7P09bes5LDMMtdYvFc3BSKQAAAA=
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719390738; l=1752;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=G4dFF7RRr2NNI3rf3eXi/R/8vjhVTjK+BD5CLTOuCM4=;
 b=H9Ao3Uqb1V96BnVfudYoQWUta2YGMPmZMMNE+10ndtWG0BIi97JhMRnMwJTYrjAs6mpsPhIqT
 K9wi9PsEIeMCQIdwZ523m1hNCFoc/UkaZ+DxhAGyrRyKWbj4DBziNpL
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|VI1PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 060e0711-854a-4cb4-52a3-08dc95b933c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c09HaUh1RVNNSUhkU0ZLajJmcXBrZ2V6Rm9ySzJvczByemRMU0lRT2NKY0VK?=
 =?utf-8?B?QnNtajVYU2wrQmZTKzVIWVM4WlV4eVRvZUU4ZzEyUk93TTA0RUNIOW04N0Zh?=
 =?utf-8?B?RVdNSlhLcy9KTEtZVEkwN2VieGVPUXNhSElTNllkUTZqRjJoL0Z6SnZmZVZ2?=
 =?utf-8?B?M3dGUjE4ZEtUbkN1S0lXVitrK1ptak1KZmo2bEh5RVc2TlZka1h1bWUwN3Zr?=
 =?utf-8?B?OTVuSGpjSkRQMzdUOUE5S2xqOEFKcGRiSW00b1VIVGIwQ1FvZURvZC9LSlZY?=
 =?utf-8?B?d1RhZmZkVWw3cGZEUm5XUXR6V2dMMmorWEkzSjVlRFNVYW8yM0xoYXNCcjF1?=
 =?utf-8?B?eWhqV280ZmJPZmEvaERjRktCUUhtMkpwQVB1VG5KS2dueUlocFhqcHBlSEVk?=
 =?utf-8?B?emJmaXZ1SCt0b0Y3K0FqYmZyTzROdGxXQ0UzMUtHNVdtb2ZtWmY1WlAzU3NC?=
 =?utf-8?B?N2RXRkFFTzdRZGd5U2tnemZUZjBUV0h2NzJXSUEzS0JIWmFNM2QzNjdnTVpS?=
 =?utf-8?B?aEwyQVdKUkFBbWRXeHFPbitCRTJkZjFwVGNFcCtsaU9IS0k3alJQR0Zxa0R3?=
 =?utf-8?B?QmJXVDVuVCtBdlZINFllbTdUaG52a1hiQUdCUGhCMHVqQVd6TlpyVVJwQkh1?=
 =?utf-8?B?Y295N0xHRUZoUlNXZnVtdXpOdThPZC90cXRNSEhkNWFhL2Q1eUg5cHBqSjJa?=
 =?utf-8?B?SjE4VWhwSW1taXkwSE1lczh1L0E0MWs2TTNhYWZ1bmZNMnk3Rlp0YVVWRGJH?=
 =?utf-8?B?YUpCWk95a0cvZ2tnQUh4SURQQmJMWEFpTWxkMEs4bVo1cGRGbE81aTF3WU1q?=
 =?utf-8?B?eEFndGorak5ybjAvQzdiREV0SHJ2YkxQeUd5U3A0NC9WVFc3UVRYVzBXbjNM?=
 =?utf-8?B?SHpBa2VCMTFHZnIvckNMQitlekpaSElWVE1QMDJQS1AxSnlZaVo5RTNoc3VQ?=
 =?utf-8?B?WVRJbDk1c25jRzlWUDVqMnBPdm5UNEVDWUtBeExWZ3NRWVlDaUcrMTQzUVdL?=
 =?utf-8?B?SWN2YXREMklrTkJ5MnpUQXJvc0txUkkxeVFYY0V0L0RGUllzNXg3Z0cxUXIy?=
 =?utf-8?B?M0J6TG1IaVZzR1N2V2hEWXBYVjBQMm1FZXNwbE5xYS9nZVFaZlBJWmIveE8x?=
 =?utf-8?B?RVM2K2d1MUtrSWcyNWRYa29sMGdtdzJGUHpSdDVqeDRhUTMyaXJZaDVKRzFx?=
 =?utf-8?B?dlFzVXNVTWNNRzd5Wk1uaVZHVlJMQlJyTTY3RmpsajRUWjdhdjFGa3hQdzkr?=
 =?utf-8?B?dlErd1k5T3F1eW5qTHNmSFJkckdiU204QnA2S2pyb0djWE5YSGowcUVKVUZr?=
 =?utf-8?B?RWNkQmREaE02dDRTeHRINnV4Kzh2R3RBZE0wemFPT1dhMUk5ejQ4UFVzcHQr?=
 =?utf-8?B?M2xWbzNkdnp1TU05cFg2OHpkakZZYU52b3R1VWZVZ1ZXVWwvcFBKNmNpaXcz?=
 =?utf-8?B?VHQzK3pLVTlSSFhMT213VmMrMmxiWkdwU0laWHo4cVJPQ1ZYOGxobXBDd0l0?=
 =?utf-8?B?Zm1MaEhQUy9NWmNkT0MrSGpob3BvMUZqR05QUEltRnFMRGZIL1p1T2IyQXFi?=
 =?utf-8?B?cS9HL2w4YlNKMHF6ekRFcmt6M1VsODVXNEhPTFplMk9yblFqN3NRcFNrakp5?=
 =?utf-8?B?bFUyOGNENE1IV2p1Wi9YZEpYUE5Tb0c0RFNrWStsbUt6cGtYcDBKRlArMmFi?=
 =?utf-8?B?aHEzYnNsRnF4NEV0RXNYcmkzQlpDME5hTnVvaTJnVjdoTmtxVHVkUnlFaHF1?=
 =?utf-8?B?NDcxV2VCK0Zqd0lRNVJoVzVqWGM3QzQ2NXpmOEJ2Zmx5NnpUZ1lhakpSQ0dF?=
 =?utf-8?Q?7LRajEGDVXqk2MQslXf9PoGXw2ds2yAO4asEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTVDMFRmVmwxMjlWWWwwcEROcmJ0SEJoNjBQV1YvZW4yNzFjL0FZb3U3QTh3?=
 =?utf-8?B?ZXd2UTVYVUtxUURNRVVxb3FBOWhHV2UwUWFQU3B3Z1JtMU1NQ2RxeSsxSGNn?=
 =?utf-8?B?Q2t4UzVNbWJsalFpSkMvL1BvalpFbjNFU21abWdRd3dRVlV4UjI2bVV6VEZT?=
 =?utf-8?B?NmtaR0l6cEM0VlFUYVlUdmRsc0hON3poZ0JtRldaSW1ZREtRNGdXS09DbEds?=
 =?utf-8?B?SXFiL081ZGxGaGt4NVM5NUFVRVgvR254MkIwcFB3UXRiVlFtKzBJNUZNZVov?=
 =?utf-8?B?Q3BIc3Rkcm9QKy9OZ1RMSmRXdzBGeERrM1o0ZE1GQ0xIVVdOdklDZXp4cUor?=
 =?utf-8?B?NnpyRFp2Z2JXNldsYjFIOUNndGxiRE1welpsL3o0dE14dzB1TURFeE5tRG1X?=
 =?utf-8?B?V1N0Vkk1blhCdkhrVU9vaVRjc1o5aVBjYVZ4ZEI3ZjU2dUNnR1Rjb2dra0pY?=
 =?utf-8?B?VWU1TTBsMTZVbGpBTUpNQWcvT3dKVnh2bG1sb2sxSzZZR1dSQldEY1lSUWtD?=
 =?utf-8?B?czdVUTd1c3RRcUpYWjlJTHpHUXd4VzFuZ1Azc2toMDVOZFIwZFVFRGJvSjBl?=
 =?utf-8?B?dXpSVjk5WERIT2VSQVFaVUdQSzBnZ2NPYlk0a1ZMcnVWa2RoRWRnU0Rya2pz?=
 =?utf-8?B?bzk0M1BMZEpobGtUbTRZdXhaV3VMeXZHSzZ2L2V5V295cnBIb3dzOVlxeEZ6?=
 =?utf-8?B?Mjh6V3JQMUV0UHowRTRVYlU3Vk0vZWIvNWIvTEVzT3UwQ2Z5eHZwTVpjclo1?=
 =?utf-8?B?Z2cxdmhzZnRPTlQ2bUlIZG1VWG5nY3ZVajRIZStTWGUrekQ1QkxzdnB0bzl1?=
 =?utf-8?B?SEhVUk9zTFV1V05CN2ZWaU9YVHpFenJyanpkVDRXVzdmdU81RzZTc1g1aG1q?=
 =?utf-8?B?WTJ3M2VFK0dKbUJNeWl0SU9TTHZzWFhVc0RTTGRwTkVCd1NYYVQxZVpxa1BZ?=
 =?utf-8?B?aXhudXJMZnJNTFlXWkNWQXpmS1RNaFl5RDlDRWpIWE5NVStTdVFqRHlXdEdC?=
 =?utf-8?B?UnJET24zUy8yei8vc1BpZVJPMnZOUlQ5R2RYM0IydmUxT2ZEQXNXRnh4RkNB?=
 =?utf-8?B?K0dVU2poZm5qTS8zMHNzSlhCTVdHMi9vQTljZDRZYlllS05oUUI0LzEwcXZL?=
 =?utf-8?B?cThTY1JmeHNqS1VEaXB1STlNbjRuSEdqeEh6TEltQ2lpbWFVVXVaNnc2aStZ?=
 =?utf-8?B?LzkzbDUxbWhBay90bkxKT0dkeGNDYlpDMzRYSWxXZ0RVallRVldrR2d0VG1K?=
 =?utf-8?B?azBBeTZUbFBLSHJJaDl1SWxHMU80L2ZyaVVYRXJwWUVLSmFqTStrbytYS2FI?=
 =?utf-8?B?Mkp6aWJnNFIxbFNmOVNjSzlQeWZnbkVuQWpQaE1DQ1FqVk9jZm5mdGFqSHlD?=
 =?utf-8?B?RzhnREFpMUUwbmZXdlI2Y3JGYkpmRnhyM1huU2xKa1ZEczYvOVhFMnIvbVBV?=
 =?utf-8?B?bUdUTE10MnB1VC9yVlhOdnRXZTVuYXJVUTM2Skg1Z0VLck5BNWxUem96V3Zv?=
 =?utf-8?B?M2djZFVDMnBIR3R0Qk1Gc3VnQkFTcXErM1pyK3Z3OFpJcHowSytNVEZTVmJn?=
 =?utf-8?B?Nlk0V1R4c3N6SGV1MUFLL21ncUQwUlJqbkcvc08xd2dpYzZzMXltZW5SZU1B?=
 =?utf-8?B?bkNkRlVQRkczd3lhUDFXMzRnQk9JSzVxdG8xRUttSWJZcmpZZk9qUXZiVTVQ?=
 =?utf-8?B?NDBBTEpKaHlFWU9KcG5uaUxyeW5BeTc2K2RVdFRoRjhFUHdRK0VwZlJ1Ync1?=
 =?utf-8?B?REZtaXNsUFFTbjlLek0wQTJENzVSYXl1cHVZUXFkZkkwOWF0NFFwK1ZvQWsw?=
 =?utf-8?B?OUI1MTl3aU1JbEF4cHdLU3d5L2NZN0Q1dkJUTVNtMmd0Mm9NSE9mY25LMW9V?=
 =?utf-8?B?SkFueHI4aGxzSC92NXNYUUtPazdmUlBMdE4xT0NuRVZHblVOSmlRQ0RrcXYv?=
 =?utf-8?B?WXhBc09ua096Z3dqQmMvMEM2M09EM1RWbDdobWw3UXdCTTF5K0Jma21xMW82?=
 =?utf-8?B?VUhrUFN4bmc1VmY2ay9mdjRvYnBmN0VVME9weUpPRkJNUVpkdlhSLzFRNWtX?=
 =?utf-8?B?WHMzMXZSNHdneDhDZU1GZVMwNEdVekd3MEU1aEYyNWZzOXZtM2Z5V09kQzE3?=
 =?utf-8?Q?edsqVRxrfi5r2x6dQoIuRAt8A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060e0711-854a-4cb4-52a3-08dc95b933c1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 08:23:05.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xhSZtozHIIBrFwTW+HldPeqIFaNzJ6CHxc7Ln8O1gqi9NC65TW44alZWH+YIqv43HAVBgXpte7PVrwG/Y+ybw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165

Per
https://lore.kernel.org/all/20230125141113.kkbowopusikuogx6@bogus/
"
In short we shouldn't have to add a node if there are no consumers. It
was one of the topic of discussion initially when SCMI binding was added
and they exist only for the consumers otherwise we don't need it as
everything is discoverable from the interface.
"
https://lore.kernel.org/all/Y9JLUIioxFPn4BS0@e120937-lin/
If a node has its own channel, the of_node is still needed.

i.MX95 SCMI firmware not have dedicated channel for 0x12, and no need
of_node. This patchset is to support protocol 0x12 without the procotol
node in device tree.

Without of_node, still need to create the scmi devices. As of now,
it is based on an array 'protocols[]' in 'scmi_probe'. 

And no of_node, means no per protocol channel, so reuse the base
protocol channel. Need patch chan_available to support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Fix a build error that missing ";" 
- Print hex value of protocol id when error
- Link to v1: https://lore.kernel.org/r/20240626-scmi-driver-v1-0-f16d777e004a@nxp.com

---
Peng Fan (2):
      firmware: arm_scmi: channel unavailable if no of_node
      firmware: arm_scmi: create scmi_devices that not have of_node

 drivers/firmware/arm_scmi/driver.c  | 33 ++++++++++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/mailbox.c |  2 ++
 drivers/firmware/arm_scmi/optee.c   |  3 +++
 drivers/firmware/arm_scmi/smc.c     |  7 ++++++-
 drivers/firmware/arm_scmi/virtio.c  |  3 +++
 5 files changed, 46 insertions(+), 2 deletions(-)
---
base-commit: d8003eb2eb0200352b5d63af77ec0912a52e79ad
change-id: 20240626-scmi-driver-96dc61b036a2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


