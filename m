Return-Path: <linux-kernel+bounces-346276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA02498C228
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DC0B2169A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613EF1CBE8C;
	Tue,  1 Oct 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WEaLVngP"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F61CB536
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798630; cv=fail; b=A9IABqADb9k1j9PrOvZVF26kmUMJhd8OWB8mNfCv3Q6ydH7mZh5n7JKU5QViQp6KYcisn0CB1jLBDBunrlN2g+iGaJYIlDgEip787jxmFgusRrC1fT673xft16Mu7lofCAYlWfZMMxHcmV845Mbm+YS6qMfu1dAad4lN9zyyfSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798630; c=relaxed/simple;
	bh=pwmMPQ+ocskT4O4TSE+gJnxlQ1bipztOKdsbjLcczOM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h2DAvpJ19e7xaAxQeoP/BMy6rRYj57Vp1utNVb1KZIYaA82oSjPPyJVB7qbRxWIwbBVR8IWCo5Qx+8EuRH/cAGq4d2scbpGrcVEdScVTCVAquoEX9Af+Y/loDnDtr2LQL6aoYAanunLFDCU7HoTk+TRAbyYjT3WG0otPhXLvV7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WEaLVngP; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnmbQX7IFixK+5S2jn2hldzmxwqYWdbuJoPfH1cT61Qsud/73tfEsF3CxFUx9GLrbW/jLLhqJG2K3RS2+dzr7HEh5XD9LjPXI95dXUEPviudHdIlySaiQlB3pVJECz+S/H32Q0MBCbt5iaKegANlzEpPBK8sxx8xOl6uCvmXHVOsG/vVz72dF7rWU16/9f4m/ZBCVBksIJ3ExZcG3vacWkcAk4fPW8q5pCn4XcxkMys7mukHhRz94d6vrsw8RXgwh5q0EjtXa56qrDb1JnQvxvoqasFf7ydtBKC2cPfKCACHCmdyiEpxOlKAxQy3ecMKvwNuSG/GK+EkQGiLu7ypRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+OzaKZA6ebzx86iqa64+hJKH2qCqmdVir1M259mJ4c=;
 b=WWhaZ+QpLkbfH5q+GxURcCAnJE9eLOsP5OpgX3aWVxGGC58gwVcTTLA2CX3T1Fi8p6t2W/VWIkH+Ncswpbg9QjK4iPVy8kHCHvbc5yoraJ9wbCffxq1XEL2BGCQi/mWkpaawfDtpU7B/9fQo5ny9qeVK80nJ8tVp52xLQOWURYTVVrp1O+LVvTh0szvWLxix0i86MBPwET+AbJhyQ8JlpBsTL6T41a+1xM5X64iBRJ6y6zS3X89UXZF5ZyWM9R9nxjQ41/ly40E4denq6W0stRDt8bZcRp0iC9ycl1EH5JRNYlR+Cf4XDg7+IYMyP42m8Hw/mYIVmEb/UnRwRCAcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+OzaKZA6ebzx86iqa64+hJKH2qCqmdVir1M259mJ4c=;
 b=WEaLVngPa2qsT8oxqluRd1UDjeFzXXI4GQ8uHLyaGmca9olqmtiXNcN0j7a2JjlJiv0jLpHjpLkm9ND9fLg4EiRVsMR9mYoG1fOAodpAWgHGFQxMhpmk9aIJqyAVBpvBVk318T9PmEBOx7CZlRFQEbwsMGzGWR64I6OA50ZKFfKq0GArplQNzREiR/rkdBZkuEbd23X8ABVSW062b3uDVLdkIFfwJs7kEh9t1dsuvNeLho0OKCDPC68AVDjTVCLffXEYvYWAjO4MHMdJcgtJx4aQyZc3PLP57HHjbHNauJUR+jPxvxQFMo/alesH7QMSzGY00v+szs0E2b9B1Pwxpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10437.eurprd04.prod.outlook.com (2603:10a6:800:216::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 16:03:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 16:03:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 01 Oct 2024 12:02:54 -0400
Subject: [PATCH v5 5/6] i3c: master: svc: wait for Manual ACK/NACK Done
 before next step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-svc-i3c-hj-v5-5-480ab8aed849@nxp.com>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
In-Reply-To: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727798616; l=3288;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pwmMPQ+ocskT4O4TSE+gJnxlQ1bipztOKdsbjLcczOM=;
 b=pnkIDMq8WXknCTRdmARsA1Ks+epfrvLNkLd3IlcLWzautELYeEsYtsbCbbRgqtyYydHsPARA+
 sY6vVAsoEbrDmDLJunWpSFdTvavXysaLaPNn5BYvYQTywkPHolNFaEX
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10437:EE_
X-MS-Office365-Filtering-Correlation-Id: 70597d2c-eecb-4a3e-03da-08dce232a0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEYrb0xUNFdYb0FsSGlOT1lUcExKSDZtKzhkUmJiYU4wVEozUjUvY044SzRO?=
 =?utf-8?B?MjV4dE9PZWVTSGZpN2t4OW8yY3JSZHVwbktjVzNtbnhmM2JEWGZPejBFMGpF?=
 =?utf-8?B?RFBlVzRHU0hXZkRYMFZiSUNsQkpBKzh5Y2ZrNHlPZk1CenhBeld4eGluWjhP?=
 =?utf-8?B?OTlQeHMza2swUUZ2TmIzd0tTdVBiN0Fac0g1VkhDekdJTUJqYXdqdlJhQkZL?=
 =?utf-8?B?QXlVaHpoaXZlamtTM1hRQ0RVV0JrUVVMTUlXL0hYTklHV0luZkl0eS9TRXJZ?=
 =?utf-8?B?M0FjclJhbS9EeXJXZ0JlR1VKMHEwMHp4ZG0yL1RiR0I2YXRPZVg3NkhmWU55?=
 =?utf-8?B?ZVZhWmYwb3NUcWxZaDg0SDUyaGdaSXVMWHhRSk9FM1FyQWpSR3YraC9iQ1NJ?=
 =?utf-8?B?dVBySDVzTG55K1Y5UTNNb05HM0tNSHFEVUdHTXZNbk9NR0I3b1JHVEtibkhB?=
 =?utf-8?B?OUw0UDFjUVdvY09JZ1ljREsxMFBNUHZWSzZXUVJjZFRvYS9kdlVXZTVZYVNB?=
 =?utf-8?B?Mk9HVnB5WlhZSUdSODVja3gyTGNGclFaeTZoMlNLeXJFTWlwVjJpZlB1MTE5?=
 =?utf-8?B?bHJrVWltVlJxckJnc3FHelk5Y1U4SmNaQy8wYkttL2xCcXVIRlBCaER6UlNn?=
 =?utf-8?B?Q2VSbWMyUjlmUzRmZFZWdFhmVFV5QjU0RmlyQXlKZGIwRU5nZVdFelhsRG9Q?=
 =?utf-8?B?ODFTdDVNVml6aUtLNlJMcTJCZWtkUitpQ1gzSWxYR3ZQOXN0KzlkdDZCY3NR?=
 =?utf-8?B?VWZBS0gvMmtkQXh6ZUU0VllKMGg4K3NENXpDUldqdUZzVERHVnRIdWtHbXVa?=
 =?utf-8?B?VStWeE4wUUpwbjh3bWNaazNCYVVrZ29iTndod3lJaWY5QTJVYmVSQXYzWFZl?=
 =?utf-8?B?OTFsNGZwVGdYVEhOQUVFQVlOMFdSODNoeFRlaVgwUHpNUUtwek80ajlWTENV?=
 =?utf-8?B?WEFCbElyRFpVSE9tNnVBKzRVUyt1VVVhQlNiTDlESCszMTlwVVRtdWR4TjUv?=
 =?utf-8?B?c0JpMVVyWURzSjM2M2V2am12Y0NFQkFsMEE2dlk2QlV4SGdKMEtxaUdaYVJE?=
 =?utf-8?B?bUp1V2g4aFJjQUpVSTMrODkyakZUUEM2SzYyUXQ1T2NvSVVFMVIzUU1CT0lR?=
 =?utf-8?B?Nml1ZHhTU2hHMjIxWjBVdlVEOE55b0RVb0JUVmkrSGxiMG5oZUFOSmlqNFFJ?=
 =?utf-8?B?VTloL2VGTHBpUEI4QTR0eXJBc0pJQUtqNU1wY01sNjExaVV1RzRVRS9WajA2?=
 =?utf-8?B?M242UXYvOXpkVjMrTWg2cDZzK00xTHp5YzJpSWVoeFVKWEVjVUxleW5SY0pp?=
 =?utf-8?B?ZHFPN1ExQ2VIUjRxRUdsdlVJZTlXc1VBMVFoZ29lbHpWV0c0cG5kTnRjZ1ha?=
 =?utf-8?B?UGQxNHZINjZ5SUhVdkdEcE1OT21NaTNWZkFiQU44d1l0ZVJxSXJEdFp3UlBr?=
 =?utf-8?B?dGZ2eC9xa0p0STZ3TURFUVpES01Ka1BUZzQzYmZlalJ1KzBIYzhTRUFhNGo5?=
 =?utf-8?B?Mk5nd0RPNVdmVDNGSjduOXRTV2IxeUt0UnMvYkx0cE84aEFZT0JNNHdMSzQv?=
 =?utf-8?B?SzhIU3Q2ZDV0ZCs0OXQ3M1lIU1crOXI3SmpRVmNZbDB6SVNLMUFMODl6cW5O?=
 =?utf-8?B?Yjk4d0lxMWIzV0VEaW92eWhzTHVJelgwaFp1Uy9TZWRibVdlV1V0K2hObEp4?=
 =?utf-8?B?Q29XZDB5b0x0SE1jSDNYMStTOUdtVWE2dzJ3MFZLQzJqSTBpK3o2TnlOYUNK?=
 =?utf-8?B?d3ZRUk50U2RKekJrUGpmb21jbzRtT29IdkdvaFZZODhQS2kwUE9kNXd1Zmty?=
 =?utf-8?B?S3NBalpaN09hOU9yQ2ZTMzRUL09OUFBvL3ZsY3E4Uk9UWlFJbjY0M0lKR1VK?=
 =?utf-8?B?WTZsUnBhN0ppZm1WdC9CSFRmYks2NklTOWpUS1NpamtYWWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVV2MEV5cDRNSzZHMzMxSmhDOVhiaU42QXhianBqcm4wM2ZYSW5uRk9WaGNI?=
 =?utf-8?B?dDVtWmhyUytYUm1paGM0RDdrdWlqay9BdVVWeUdmMnF5VktLL3dnSVJmdTVO?=
 =?utf-8?B?dnhPVStHeTFZTkpNajBub3dnaXVsYTBxcWJ6amFpaVhTdmVRN3UzNkFaV3dK?=
 =?utf-8?B?MXUvVHovcDNNVys0MmwydmhLMFFCR3NuUFlreE04a252eWdaRlNVZTNPbTJp?=
 =?utf-8?B?VGpmWEhWTXBIZDErYnd2V2g2MVRVOVRNM3p2MCswUUI4Rll0eURRMW1lVVlZ?=
 =?utf-8?B?aUhSSE5VL1RUSlZQOXN4cmJFcEFzR1pEdHRBNDNrU1JzcDZkWTlYSk54WVMr?=
 =?utf-8?B?RW44OHZwOU5RWGd6NE1vaWx4Um0xNVFEZk9Ya3JoYlkwczRWRFdxdHlRUU5C?=
 =?utf-8?B?MFd2ekNPc2hTbjFxZ3gzSEd0SCtSZ3ljRnQ3eHpMeGNRKzZvR1BWRjBlWkIr?=
 =?utf-8?B?T1RaUjhOcGROb0RvSEc1QXp0eW5JSGZOWk9QUno2dkRXeWhRUHY5WUx0bHVT?=
 =?utf-8?B?SlphbFpXRk1KMGEwNkdKMENGOXpsdDlMMnI4Vi9BZk9GVzF3VTUzYUZLNmtL?=
 =?utf-8?B?VFhsV3hNVzU3bll2Z2FEeTVmZlV1aUNtZXNQMUc0cjVodW5iU1ZYckE1MGlp?=
 =?utf-8?B?RzBjcHA0Sm4wUFgwSjJLRS93N0t4WTZOeUlUVkdJQ0IvWkUxdkR0NVZGc2hi?=
 =?utf-8?B?a3liN3oxT0grU3I1WHA2R0ZmaGxKV2N6ZWpxeGdJN0hEbDZGV241dk5kVkZL?=
 =?utf-8?B?d29GZlhnU3lTcFFJbitYV09KKzcwejNhSjNaaXhic1JEa3h2cXVoYWVTY0hv?=
 =?utf-8?B?U2FvSzJXOGFlNnljYkpEcE5GdFFybzRBSmJIcGJFZTFJUjBWUld3ejJRQ01B?=
 =?utf-8?B?d2ZhbTJtR3R1ZXl2elBrL1VqRWdWdk9tK3VpTUFsUm5Rb3FqTE9JUkQ3T05l?=
 =?utf-8?B?SE5kc1BpYWxWSTl2QmZKZnVQeXlIQTJ6NTJoUDd4cXFhRHlLOWVhRzRSb2J2?=
 =?utf-8?B?WEtNTXNLUnJJQmFRTnFxUXlRSlFMZmpvV0Y3M1JrL0hha0ROUW5YNnVHTHhx?=
 =?utf-8?B?b3c1Znl2aWhkVERkYVBQOFYzbUlES0VIcGpBQTE2UnVoY2l4KzRPSTBONWdj?=
 =?utf-8?B?ams0S292M2dnR3k5b1k2MUM5c0E1bVM0RHBUMncvQVNMMnJUd2VEZktqbnpz?=
 =?utf-8?B?K09JdnltSVBhWHp0aHcyWjBRNEhBU1c4ZVRqY1JiZ3hveXVjdzFvU1g5V21Z?=
 =?utf-8?B?Tk54K1Z3cVJtZjA5bEVDWFZtNmJPT2FMYmpOemVBMnBxS1dzOGtNcjUwb2g1?=
 =?utf-8?B?TXFCcWxxcHd0ZW1NNzdKcUlzZnF0MGdtU1A4RCs5ZjR5OFdTL2lKQ3RaQ3o5?=
 =?utf-8?B?Yy9zdFE0K1pURWF2ZDF6QlV3UnBMMERKcyttSmtwZytMM2ZXMVdJRHBadGJr?=
 =?utf-8?B?Z0hTamRHcURLdGRxNHhQMTZXVlRaV05LWTR5cFFTdmZ4aDdtRmoraVZKN29x?=
 =?utf-8?B?TFUrK2hQaHZRNjR1RWNPRWZUTTE5UHF0ZllCZGs3bnNDbmtkN0cwcU1jdktC?=
 =?utf-8?B?STBKZWw1YVlvZXlKaDgxbnFGOGtuL2xmSHVMM0U3Q0JDVy90WXMxamJqYkEw?=
 =?utf-8?B?OGFpK0krNnlOdVd6M0NhZ0Q2KzVXWk9VWmNsa3NZS25vemtGRmR4VzB1Z2dv?=
 =?utf-8?B?bENCalJUZDFBQ2VuN0VmMFMyYVplcnkrZmoxNjZVbXFQVFJDcDF5YnNuSmt5?=
 =?utf-8?B?N3VtOVl0L2FmRkpYQWEvK0F6bk85V1hxa3lEYVdJNkxBcVhBVlRNdVdwVUh0?=
 =?utf-8?B?NHNpWlN1bmV3dFB6bEVWZ25EemhyTkpXa0VrdWh2QWdtL1BxRjlZMFhUYnZ1?=
 =?utf-8?B?Tm12WllDMm1mNjc4emMzMnBKTTA3aGRCSUpTb3IxNHphQ3RyQU0rcHlmN1Vi?=
 =?utf-8?B?dHA0K0tZTXdONWxvQ0VzN2JkcnRYVkR5VVJ2bjZoQ0J5THgwc0xGbTJsdWc2?=
 =?utf-8?B?Tjg0UmppMElTeEdXaXVnVlNtN0RoWThpdTZEQkxBeW0zaFhHYjUvL2drWjdT?=
 =?utf-8?B?V1dnVzd0L0JpYVlxMHBaaGZPSXcwUld6VmI5WS9Id2l2ZFE5anVRd0lNRGRw?=
 =?utf-8?Q?Ssew=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70597d2c-eecb-4a3e-03da-08dce232a0d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:03:45.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNqwfkAxW/8lnJMcUZP1gsUcwURx8VnYcXtHFEB3DRu3D7ami5i0KFPEbIm3jTrV2iRsAUtiTnD7KsAzXp8xrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10437

Wait for the controller to complete emitting ACK/NACK, otherwise the next
command may be omitted by the hardware.

A "command done" check in svc_i3c_master_nack(ack)_ibi() and change the
return type to int to flag possible timeouts.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- rework commit message
- add miquel's review tag
- directly return readl(...)
---
 drivers/i3c/master/svc-i3c-master.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 1ee6ce186195c..3388c9af63fcc 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -388,10 +388,11 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	return 0;
 }
 
-static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
+static int svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 				   bool mandatory_byte)
 {
 	unsigned int ibi_ack_nack;
+	u32 reg;
 
 	ibi_ack_nack = SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK;
 	if (mandatory_byte)
@@ -400,18 +401,30 @@ static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE;
 
 	writel(ibi_ack_nack, master->regs + SVC_I3C_MCTRL);
+
+	return readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					 SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+
 }
 
-static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
+static int svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
 {
+	int ret;
+	u32 reg;
+
 	writel(SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK |
 	       SVC_I3C_MCTRL_IBIRESP_NACK,
 	       master->regs + SVC_I3C_MCTRL);
+
+	ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+	return ret;
 }
 
 static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 mstatus)
 {
 	u32 ibitype;
+	int ret = 0;
 
 	ibitype = SVC_I3C_MSTATUS_IBITYPE(mstatus);
 
@@ -421,10 +434,10 @@ static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 msta
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
-		svc_i3c_master_nack_ibi(master);
+		ret = svc_i3c_master_nack_ibi(master);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void svc_i3c_master_ibi_work(struct work_struct *work)
@@ -935,7 +948,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			if (ret)
 				break;
 		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			ret = svc_i3c_master_handle_ibi_won(master, reg);
+			if (ret)
+				break;
 			continue;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
@@ -1209,7 +1224,9 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			ret = svc_i3c_master_handle_ibi_won(master, reg);
+			if (ret)
+				goto emit_stop;
 			continue;
 		}
 

-- 
2.34.1


