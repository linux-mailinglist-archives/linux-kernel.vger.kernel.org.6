Return-Path: <linux-kernel+bounces-346277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC8498C22A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83273286204
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529C41CBEB9;
	Tue,  1 Oct 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="md4eq4uU"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB41CB529
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798631; cv=fail; b=ZI8f/CC1u1NxDi1pM/+4MvR7wM30tKvAxl2B83VXxSGDdViSj37zvKreFXd9dp/vscM5YtwEXL3AERxmEk5sEXCfI7etMUEyscZxgZMtA2KIa85F/9HD6hvFql3AqFDCcs7CFJrAzK8mkVyEfwFD3YBCgoiG1YHyKaSpDcdSTl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798631; c=relaxed/simple;
	bh=bXdIg5zPM9BaWXsC+SgKZ7H7HKQdnYJSf5AlhHtZq7U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=R62Woyb7BKzr61Yzawz6A7EKcKNnMqWKrji3VJhVQcc9IaNVTM9cm/+N2ACF4zcijN9KCulKJFIQ0AyVvOGCRw58qLtC+tbosMH1h7n4P2qgT14e3vQM0lvV9OZaIE+y9ikcQgs3t79NIHgWDOqq4nlPgXqQ5HYdFQDxQ8Qcnyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=md4eq4uU; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCzFaRsniwF/UmqiKbka3S5AcXtYCbESh6lO+CBw6yZ898bP3NtUTdggYSBwAAXhdci8IEMG33jplc89WoRvn7AqcUDy0v79xW3Ha0nZuSXrPynMZ4Kd1mFmkfSTDKqgtb1onS1NKDWoOz5roW3bwyt4MidCkQeOqH45jZKsE37OJw5cpNmvtCeZBUvZ7DMya0hkI7KA/JhjfuB1+xdcD42SQ8euR+tgUfcXNStRRPyOfuWdLxXWRSV6ApIK42eUwIBPfFHPrQfKSndgrSjVn9o5UaLyY9lIV5n+wfREOBUBo0DCZsbWq00BTqrSFrvtNrSg27LDxglTN8A7anCxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUG3B5sw0m9FDBnZS2WFp6KjUgxzk050Wfyb+JjQsVc=;
 b=nPHBgzNGQ7FHHJ2Y1QM+Th1meQvnmzPtRu2XGbQ0uw9BB728gBg1Q7qhF9o2YCZFGNTY5tjNF/O+WjN7X3NIpO9+71ZMz1VFG1xWU7jsVIh/LvTiyyp0BSECi+oDpMH+tMMvoAQrNMvu0JbQsGamCGyaCzllbX3bsf9JlSw+diTRbqjY1ipd8sDR3sb70fI8yrLluEzhLs+jgyy7uQUwZfVke2xmDNA81ezwtT50m96HwDMaKHIjGmJiEpIA/6LQCOlg4HhhFmP6kZVQGa/F3smOHXvRYAEw/0wFQxtaJcFVaAiMbIiXIvh61sotUo/CpzttIgi6qAAwbNY40K+EdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUG3B5sw0m9FDBnZS2WFp6KjUgxzk050Wfyb+JjQsVc=;
 b=md4eq4uU3YIqrhIx10tW90ezYrUtS3P/wemPY/SX1XTB1J6bK5WTKLkXF8OrDYhiWDadcPLncah/X42l8m4y1fqUsehTYTI4X/Dfy49elXJiUGBNYWWv9GgifZXQiqxKzhyJlgm594cXIqpe4JEE/8r21/5sTYK9VYHa9sgf4jRWcU0t3SlRl2dAyZH9Q2YLrqSZrL/2jETWD6LYbKEQyE1r6N4CEXbyOj/XiaoDSfXAko1RJbU7jVa+NPoK5P2ugXhLEAkFx9Z4tZpgc7fX0k6nIv7tRd6Cdk/mx3MvY7rYdALL0sDioKrXvtIl5UfJALb1n1/+WcyjOLi8HjXIKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7879.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 16:03:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 16:03:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 01 Oct 2024 12:02:53 -0400
Subject: [PATCH v5 4/6] i3c: master: svc: use spin_lock_irqsave at
 svc_i3c_master_ibi_work()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-svc-i3c-hj-v5-4-480ab8aed849@nxp.com>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
In-Reply-To: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727798616; l=2497;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bXdIg5zPM9BaWXsC+SgKZ7H7HKQdnYJSf5AlhHtZq7U=;
 b=3dJeBl7aVLwecgJrIlp8kF/ymDU4ZRPIwNY3GrPbPaPg5DF6K3DRd7q8IXlQKUFDcB0pdSDg6
 WLMO7iSISDsBqIjxFMOpXjLIx/p8WY2WSaM9GbMwwRbYe3xwfW2RksI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b594cf1-5c5a-4e69-1aec-08dce2329ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjY3UmVmRElIN2Zxa2FsRnFlVkZrckhlVnRTQ1lLODlBcGFNd0tubXZTODJL?=
 =?utf-8?B?cjl6ZmRveHVkK29LcGpPNVJDaVE3LzV0d09XeGZiVkd3bSs2Q2ZnUWR4R2Iv?=
 =?utf-8?B?aHdjTUhrWjNzczEzVERPcFJhS3BybHRZeTB0azFxQTI5NmZQRytuUUtvdlBu?=
 =?utf-8?B?NHA1SnF0d0xqRFd3WXZxaXlsVy9RN3N2SmxHSW5rRStjb050RmtFWEVyc1cv?=
 =?utf-8?B?d1BFaHBwcWl0dUs3SnBWL3F2aE0zcDNOeDNyYTFadit5bFJBSGZtTXNYSnBP?=
 =?utf-8?B?YjRtOHM3QlQxN1U2NzJlSFhoU04wRy81YUMwbStJS2h1QWtpQWs5Nm1HVm54?=
 =?utf-8?B?aUdOVzBRd04ydDFHcnM0dWhRbFlLMjVEL3dzdUtlR1RyTzRZdFhEeGxmR2VO?=
 =?utf-8?B?anVZa1dyK3A4Y0hDbEZadkNYYkNNd1lyM21XWThNanJRNWdYKzVNUXp6MjZt?=
 =?utf-8?B?c01EdDRYc3FKcTU3S0VLYWdFVkR6b0JFd3FRWVR5M1Z3YWhiU1BSUkFySHcy?=
 =?utf-8?B?dUMyZDVBTlFrUkQ0Ri80ZmF5cERpalNsQXBRQ0Nsa2lNbzRnN0tETnpTdjhx?=
 =?utf-8?B?YTJrZWVBS3hPZFA0WTlLZ2ptR1AyZXVjcC9OREhkc3YxOFJyc2pIRGNmTXFj?=
 =?utf-8?B?RDZib2RtK2lnZ3JQVnl4aGVyRnhCMURMNkFQaTFZUVBtSjF2NHFZb1FWWFc5?=
 =?utf-8?B?YnBaMFUwUFh2anZjbkgrSDM0ZEEyeHJqdkQ2dy9ueXc2L0RtcVNjRU9rR3NZ?=
 =?utf-8?B?RGM3OFJCUmFWZ0RHNEtXYngwWmpVbFN0cHFPOEU4SDU1QUZ3RFpjZ3NPZEx5?=
 =?utf-8?B?ZktoakU5VHh6eGQ4WkNhRm16d2krQzRsaVQ5eWY4ZThDUTBUaWh0YjlFTG1R?=
 =?utf-8?B?eUFEWkwwT2ZYKzVTQjI3SWsxZkhTbmEwK1JNZldqREkzMzJKQW5kRys5eGVF?=
 =?utf-8?B?bUFOWWVGSkFYNWtSY0V1NWJWbHZLQlpkRkw4ZFlZMEY0aDFzU09LN0NndUdv?=
 =?utf-8?B?U1VnUU85dk5rdmZ4MHZWRmUwQlVUakNpSkUyY3N3eFBkVU04bkFwZEJWM1Q2?=
 =?utf-8?B?S25VenBMNmhKMjhKSGpjMXBORjMxNFN1ZTVnaGRLZ0UyUnQreFIzQjVUNlNK?=
 =?utf-8?B?a1FmWktsWkxUVzY3b0pBZWc5bTJuQ1FLYXNXeEt2YVVOTGdFMHJWejBHY1lv?=
 =?utf-8?B?M1d4bTVVakhqZXB0eFdIVlNHTXA4R3hvczBSTlNOb2Y0ZjI1UnBkZ3UvSXl1?=
 =?utf-8?B?N1VZaHpvZkpncGR1VEFwbnVDUjdYOE91eThHT3FGVHlJR2E3NGkwanJxSXBR?=
 =?utf-8?B?bW9DYVJ1cWJpMkk3dE8rQWFISmNMVTNud0wrQ2pqSmxDdGRRVFRrOGlsK0Y0?=
 =?utf-8?B?emExZk42OHlTcW1Db2MzeHk1YkM4Ymw1N1BRazZJVVlaTkV3RWhIand2eTBX?=
 =?utf-8?B?ZTZ1L3VKekRIMDhWQXRCQkYxN1FVVzUrUmYwblZLVGMxYnlFeFJRbzN0VUpp?=
 =?utf-8?B?amVJRXhMNm9KbmIzMFd3K3k5cWtZK08vTkNNbUhNbU50UDB4dEErbEpBOUFq?=
 =?utf-8?B?UDRCZ0k2ZTYzKy9jaU80VTlvck1PbnBFNWk3WVU5a3JWWDhCakNtdnJ3SmVy?=
 =?utf-8?B?TTF6MXBrRTkrV3NlaW05eitIeXNITEJXeWx5YXhQT3g3YVg3aEx5RFh5YTEy?=
 =?utf-8?B?N2hoeUFZcjNyU3YvcWdyQi9rRW8weFJEaDBvV2RlbHVZNzM2QmdrVWFucmI0?=
 =?utf-8?B?THBaaWhvL0p4eUl0NnhOYXZvNC91M1pWK0VjOTVmR1JucE0veEdqWm8ycHU5?=
 =?utf-8?B?WTdOaHUzb25FOGZLQkRRZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVhVV3NONFI5UERPWFZPUC9wZTdDa0ZaWHRJQno3bjFhZ1JTMWh4UnRCcllZ?=
 =?utf-8?B?cTl6Y2IrbEZvd3YwOWJ6aHlvZDJZeDdSWGJWNVdkRnprc21DYndScEd4VDlF?=
 =?utf-8?B?Rm1RN1BGaHJEaWcwZERVQWx2V1lIbXNpYTBSOE53SVJXbnFHbnAzZ3hrZkhP?=
 =?utf-8?B?eXZ1V0s3dHoyc0RUZWk4Q2MrQU1TU00yM1lpLzUvUUZvOGpRa2ZKMEtFMVMr?=
 =?utf-8?B?UTZ4KzkyVDJjSjJvQWhxN210ZjdyS0tsOHM0R1YxcXlHQ0NxOUJxTlQ5OElh?=
 =?utf-8?B?YVhQQ1RvQ0RzRWxOOTFMU01VYzQ4UUhSenBkTmF3RWJLMG9HRDlOdTVLMDRs?=
 =?utf-8?B?ZkdxdFpGcEZzQXVlSVJlRUIwL3hrUUhaN0NJNUxnMWorUG5qSHlZVTZlZ3Nv?=
 =?utf-8?B?T1pzRmhQOVJvK0ZFTzluSklzcmNkWHhFdlBnUFk3VUYrL3F6TUM1WnJVdTVy?=
 =?utf-8?B?UDQ2dlVXUUl3dk55b1RqbGh4NTA3dTBvN2hsTnp0T1FzMXNieVlKOUhianJ0?=
 =?utf-8?B?UHBreU9wajlLdXQrekozalB1dTZ6M0c2Z252ZlVoaE9DdGUxbENWT25JNWxv?=
 =?utf-8?B?ZDBsSFFDcTQ1WS9mTXpZNFNycFIxNjMvclJTanlQMHM0QXVQdFFCbURyMVRo?=
 =?utf-8?B?cW9MTXRMenJSUXk4WkJ0cThIR3A0R3g3Z2VlR0Y1d3FOeU9JRVpqTU45bkVM?=
 =?utf-8?B?SUs3ZUlNUkk4dlVrTUZ5dTlYaGhPcnFISis4N0RWQUJEL0JCd2I3N2dBWlRq?=
 =?utf-8?B?aHhtemFuZVlRRFUvbDE2MG4vb2wxU3VxRmhicHl0OVRQNERVK0M2cUdGUmlz?=
 =?utf-8?B?QnJPc2FiWGFFck5LQm5qQ0xFZ0RHMXdIQ2VkTFJNT3dtYytIMzNlKzZJK1hu?=
 =?utf-8?B?QmRkVnM0WkR5MDMwRUFGYzBOODdWdi85VzV4Zld3QUwyVC83SUkyNlVUeVlX?=
 =?utf-8?B?MnYvRzRwaGpDeTluczhjTXRmVks3UWRZREJCSjgvaE9FM2FFNnVORmxRZURX?=
 =?utf-8?B?T3ZLeHY4aFZJeWRSazUwTXlvZWpTaUQxU0FyZnUwSXRmS1Ewc0JqaExTRlNq?=
 =?utf-8?B?ZHJpRGxpV3hVb3AzN01ZbFN5RU82VTVnM0d3VUd4NE1xRWtVNkEwNVdQNzJk?=
 =?utf-8?B?N0dTL05DN0s0WUFaUUNpMURFaUh6TVdMZTBKd3NvN0VHWTlDRXRoQWJvZE5l?=
 =?utf-8?B?TnhSVmhFZ0luZ3l5c0N0TmZlOTJkU0pCM1ZRQ2tsb3UvR25xSE4xME04Yk5W?=
 =?utf-8?B?TEZma0RGNXdFcnk4dE94ZXNUTW1jZVYyUzB2akRzV1dlcGo4L3A4M1hxQzZP?=
 =?utf-8?B?VVl3NlVsYUtLenVwT2poeXpuVTBCSklLWE93ckJxdXE0Ym1DVVRXcWpDb0NJ?=
 =?utf-8?B?WXBaMXdVTnAvRll5cUFEdUw3V2xYaEZBaXpXQ2hBaFZZd0Rkc0hDOFpacHRq?=
 =?utf-8?B?Y3FYVUNoWnhJWThiUEZReUxxdHlhZzhGL1Z0YXBuTjFpVHZDYURqVDFIenZB?=
 =?utf-8?B?S2d3Ym1CY2hCYTkrV00rWjgzcDVMVWdWSmhxQXVvaTlFTW5PeWVLN1NSSG5F?=
 =?utf-8?B?Q2RXdHExSE42aUlXdU9KUEJ5VWg1L09CNDdFTVl3Q05mTS9hdVkyZ0d0cWZV?=
 =?utf-8?B?RzU5cXBqSDJsdkl6b28yZ0VOaHlLZys0S3ZrOUx5eG85b0J6a0hDblVxenJM?=
 =?utf-8?B?cHRiejNtZSsvbUlTcmN2RTlPNjR2ZVUzTTN4OC92Y2JlM0w5WEhsKzRtK1JL?=
 =?utf-8?B?VFV3U0dIc0VRaDJTd08rdlA0cHhTVkZpMHpwRHRLS0lEcktBaElLNWhCYW03?=
 =?utf-8?B?d1IybkZKeklXMnJvbFZuYkxKenFIR3ViWEtYN01ETFpjOHBSL1U0R3crTzBr?=
 =?utf-8?B?ME9sNXY5YzNVWUdhRkdXd0VKc3lVVjRoZ2dYaW5vSUd6eUF0UC9CSWFuV0w5?=
 =?utf-8?B?NGRkNi9YRDJOS01vQ0ZPaURiekE1cDZZRnJPcEZmUFF0WDY5V3NvdHpPclkz?=
 =?utf-8?B?Q3NqTDNoU212c3hyM0VIOGJ5TzY4UHNvcVo2VXFOQ0VDTEdRd0lFeTJsSTRT?=
 =?utf-8?B?ekEwT3dpQXU2Tk5rZkNWMTNxOGFHWWpicnRDL216NUdYOUlDREhsL3ozUTlX?=
 =?utf-8?Q?V7ns=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b594cf1-5c5a-4e69-1aec-08dce2329ff9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:03:44.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F40fmGiCNXghkeQ8H75uUvFv2KDiFAGFfPVmeAmb6H9AL42g/dfjDSQMOK58w9ddLOC+kfV3Y3voRR4d9DknA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7879

According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:

The I3C Controller shall hold SCL low while the Bus is in ACK/NACK Phase of
I3C/I2C transfer. But maximum stall time is 100us. The IRQs have to be
disabled to prevent schedule during the whole I3C transaction, otherwise,
the I3C bus timeout may happen if any irq or schedule happen during
transaction.

Replace mutex with spin_lock_irqsave() to avoid stalling SCL more than
100us.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3-v4
- improve commit message
- needn't mutex here, other place already use spin_lock_saveirq to protent
i3c transfer.
---
 drivers/i3c/master/svc-i3c-master.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5df0ec02d73ce..1ee6ce186195c 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -436,7 +436,16 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	u32 status, val;
 	int ret;
 
-	mutex_lock(&master->lock);
+	/*
+	 * According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:
+	 *
+	 * The I3C Controller shall hold SCL low while the Bus is in ACK/NACK Phase of I3C/I2C
+	 * transfer. But maximum stall time is 100us. The IRQs have to be disabled to prevent
+	 * schedule during the whole I3C transaction, otherwise, the I3C bus timeout may happen if
+	 * any irq or schedule happen during transaction.
+	 */
+	guard(spinlock_irqsave)(&master->xferqueue.lock);
+
 	/*
 	 * IBIWON may be set before SVC_I3C_MCTRL_REQUEST_AUTO_IBI, causing
 	 * readl_relaxed_poll_timeout() to return immediately. Consequently,
@@ -456,7 +465,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	       master->regs + SVC_I3C_MCTRL);
 
 	/* Wait for IBIWON, should take approximately 100us */
-	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
+	ret = readl_relaxed_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, val,
 					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for IBIWON\n");
@@ -529,7 +538,6 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 
 reenable_ibis:
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
-	mutex_unlock(&master->lock);
 }
 
 static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)

-- 
2.34.1


