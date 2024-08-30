Return-Path: <linux-kernel+bounces-308721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE1C9660DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3816D2874FA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59714199FA4;
	Fri, 30 Aug 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AxFW/NxR"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5C195FD1;
	Fri, 30 Aug 2024 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017644; cv=fail; b=pwo7VO1hupCH32QFG+WJeUJJ028QDw/kdoYtKeH51ktrRdFM3gSQqyQqGriCiIvD34Lq9tp+EmzujNukV6JFwDm5T1SG8VPX1OXs/YoJuBeZf/0QoiTj0dJkTkFXk7rXdx5agA8CNEc+mcAah8AGuqp483XWhfW5zRjBjg3TZ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017644; c=relaxed/simple;
	bh=Psw9es/bwBXUPaPDc69w/OzVcFaerox26gHFiTahjuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hpbb+hqiMBtJpopnhr9THi7x0Tu8Jo6gCRFViu2FLs7VxpQC6jDqzCceAmTiApcFSsr0crHRY56LObzhr3AZI5UVZFBs9jEjz/JioTKnBSnNJgkLbll9+W3NMLamUahWuUTnaV9DpDs/P+DUN/RZV0LpxQ+rvs90peuUqvE8qgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AxFW/NxR; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5xrDDIihyCL4/4Jn5o4zJFAdwgb+gJnxxlR5pU5uaM3lGgfAoHNMPgVmgxiRnpFhig0tgOAXJq9AJlHikYULfOrR0wjTieDmsHAat/uPtUHVL8mEiIRLgUXU5BQRzsHZS3YXcVf3Ix97dY+qnDez0T6mU/TggyOIp2KVRRn0H2neny3juFkoosLI9+jasKzC6NtzYA3OuKmiN+m0ZpL654FbDwSIYPOEyx893BHwK4b1BHBgUztMMwFvSnPoPXrA4vpntLEcQt7q7WI97djFJn+i7rvJMNMRZUYm1p8palEA8GrRBENyGamogSqL2tURPfvaEPbqG0AQnrJgVdNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvHzmfEJzKOOu0trhKsIW2ufkKHjYtYZp708X87SZIw=;
 b=ha2/PGhrDLE0zDpsv9DvaQdONH6HEytjkM7SFgqT33yB865onvDuFyspsMmgNbtyj9YQRD3NmCgouINBEL0jjzDBsRpuRBx66/BnlXDiYftvLQTBOt4dCXMi6kr3P/H4HNPdGEFBHCUME/qNUmhs8QbVXrt/VM6BJF87L85/CbRZsPy/o+2PcWmX2zqzAIwlvsWxBof32/yYUKz0f7cbSmPCTDUbKCGx5Fs6zdfuNxgvfror6Cp9DU5lyYt0p/a0vHhaRjdrHP8cXyg/qiNpMfP43xz5rQ0d4c3g1GVh7xReHEvhqaIxpfFIWbJIXSv+wC7JxMgZw5zgznvQoRUlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvHzmfEJzKOOu0trhKsIW2ufkKHjYtYZp708X87SZIw=;
 b=AxFW/NxR5UqFMYYxu7tNj+eTjKuuJuBymxSq+SZvbR1saWWVpsOFb+kepJt6jD6JEr+VDZn5+NDlLwZ6wRGbJeGq3IkjBxul2x2EBWROaDEu4WUsECHVKLkXUQ6RJGi0zSmrgKJevLyX59e2i8iabSR5g38Sn0QD+ehU/bMBmX84KeKj63yvh6Vk8LOyzYOgpICWKgLEq/744l98M8WzPSuwq47W6xbBhe5/H1PK18NDKvDFHflIf6n24QwRfUpgg5bLsvuQW9s5XXlo3xNvS0AhZpSGuBcU6kkw8+w3TIWG/yuB+B4Lfu3rU8BjNkIvX7fa7fhG3ns9jlSUrQ3ODA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 11:33:56 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 11:33:56 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2 2/2] arm64: dts: s32g2: Disable support for SD/eMMC UHS mode
Date: Fri, 30 Aug 2024 14:33:47 +0300
Message-ID: <20240830113347.4048370-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830113347.4048370-1-ciprianmarian.costea@oss.nxp.com>
References: <20240830113347.4048370-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::33) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 147eae14-b570-438c-4f7b-08dcc8e7a1fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGU5N290MlZwZmtCbHFsOXREM1JvZkVPczRKWFNUMEZBTVFibkR0WFVNTzVW?=
 =?utf-8?B?VDhoRDdiT1o2Vmh1SHRJN0FCcEtobGZFMWM2bWRLL1lKTXZBUHE1YUp4UGFB?=
 =?utf-8?B?KzNFMHpVT0ZielpGK1p4M3VXUmlFYTNucXF6dTY4STN0ekV0dGFQNDYrYTNL?=
 =?utf-8?B?TkhaMytrMGxCaWtEOUJRbXVWdFlYMjY4Q29FZVN6aysyMktLajZncnY4TlY3?=
 =?utf-8?B?aUtpOHZIdC9sS3kwS0RWZmlkbm9wcUUrNTVnSHRDaEhPeEtpZTZnSkZpMUY0?=
 =?utf-8?B?U3M1a2lZZEQ0RmJZdjlhc0tOSkdUZWJZQ2s1VzRydXRpdW5ieXRoaGJlNHpa?=
 =?utf-8?B?WEM3OHZWbUJmS1R0QVdNVVhoS0YrY2RwK3hPdjBoVW9COGE5MUMrb1M1eFM0?=
 =?utf-8?B?ZkhNa1ZzNjNsRythRDhyd3lkcU85U0p0WmdLS1prOG1GTzRoa0g4dEdUaEdn?=
 =?utf-8?B?K3VQYlBCd3dQTzU2RGNTUngzQ3NMZHA4dTVPaUVYY25oSU84ZkFmeitQb2th?=
 =?utf-8?B?dnpiRnRJci9IS2FDUUFqbEViMW1WQ24zcFE4cWlTV1V3TkZlRVFjQzlKTHY0?=
 =?utf-8?B?MXBRdUhhcmE0a0xJbCtwR3A0Z0d1ODJPZEFtU3NlL2pFbE4wU1BkdEhHV2Zn?=
 =?utf-8?B?NVNGWkNzVWtQY0MyTUU4UGIzRkErV2luSXJvL015UkhqRFQwNEg0Mmx1alFv?=
 =?utf-8?B?Q1JHT1NRNmJrVEVTWlpFMmd6eHdqSVFIMnlqV1BrSjl0UEhsWjErRFA5NDhy?=
 =?utf-8?B?WjFmSENYcXpBVStCN1k4b2ZJdExlYjZUdlFJc1Q0a1d5bEpVMXNMREU0a2Za?=
 =?utf-8?B?U0gyaEJkdzZHeTduMTJ0Y0xDeG5waXl4ZlNLVUVDYmJ0L0pMM0FWaVEyeVJU?=
 =?utf-8?B?L05pWGpTZ2ZLeGJ0STdjMEVpVlptaTdCdlFlQVhFaEhKN3dDaWxhcVFjTGtY?=
 =?utf-8?B?cEZPWDd1VzNZSC9HNXdUblRUZHVNYko0ZmhKSXUvVTRqUEoySDl3Z3RTTVlF?=
 =?utf-8?B?TDc0cnVxTXpnR3ArT3d3UGRBZ214Z2Exb01hMUlHRlo3VStoSUJyYnFmT1Zh?=
 =?utf-8?B?VXdUdDhUWTV6N3pqSkxqWjMvek1iSHV1NVJZMDlqTHhHTDNvRnJlV1UwSjEr?=
 =?utf-8?B?b1Vpcit3OGc3cHlHS1k0R3pnQnplbFNIOHpZYXBxeTNzbU9oRjhnLzlYS0pt?=
 =?utf-8?B?cmJsWnk1ckRkeTVBVlViVnp2dmxMcmJ2N0ZwWWlXRDZ4aU1Jb05EVjFWYUxU?=
 =?utf-8?B?THM0OUtBbWc3SWhvekFneEJXczVLOHhraVMwb0x1dkJwWUtDOWpFMnNsTUFh?=
 =?utf-8?B?WS9QTnUxVG9rQkg1Y0FnbWlBMFNnRGM5SzNxQ1dXK2ZJU3crQXZuazE2OWg0?=
 =?utf-8?B?a0dzN0o1eWpyZTRQK0dBZFA2cjlmVjdibjNYWmNGZGEvQ1dwMVZNZGpNUE5p?=
 =?utf-8?B?Q2RwYW9jVFBDbDNPWlFUMHJaQ3QwbGowRFp6YTZ6M3FDbis4NXhZYmJVSzdt?=
 =?utf-8?B?RTRnRDkrNzNtQS9pall5TnlmWXB3TGRNUTNpamdOMTZER1QzS1dEemVrNFFM?=
 =?utf-8?B?RDQwVTJvZU0xa2xVemF5aW81VDRCMFNyMlZHZ01tTlIzSWd1N3JzVFV3S0E1?=
 =?utf-8?B?ZFlnYy83ZGtMa0lWYWVJUVdWU3BXU1hNYkM0YmtoaUZjZXNjek5sbStISlBk?=
 =?utf-8?B?MEY0UE00UE5TRXpGekt4RkNVRDlCczhUdHJYdWJZNGNNQk5rL1pwdmswM3Qz?=
 =?utf-8?B?dGVOVklSdDFjYTNYeE85VStuSTNHdXBJS3pmUXpGOWxXL0hqdVhscTd4RFls?=
 =?utf-8?B?SGc0YjFDY1lJVDVqUC9UUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXZsRUNmN1ZIRjV3UW1CbytIVW83d0hBYUNFaDRRaHF2dkorL1FycUJ4Mkts?=
 =?utf-8?B?Zmdza0NCeUJDNW5vckZuSmx6YzJ6ZWZ4Rm9oMUlUTGd1YnE2T3R6QTVVcWhU?=
 =?utf-8?B?NlA5dUMzVGVydWF6SmpIR05ackVnNWZrVUVvVmF3TWFUY3pyeStOVVRnR1FV?=
 =?utf-8?B?OHlkZms0N3NvYWFtN0xwc205dEpmMmxMWDhLdlBVUTZNa2t5Rjh0d2lhQlJn?=
 =?utf-8?B?aEFQSmJzY1BleW5MY2dxeWdsRWZLeDVFZmlmOVJMVjdYMUFlc3ptOHR4R1hu?=
 =?utf-8?B?alVRNmJvOW5lV01nNzd6L2VJblBvNFRhUmJWc1lSQlBMRi95cXI1ZzRxTGI4?=
 =?utf-8?B?eXRiQWhybGxZRFpMamZUT2JlRkpvV21sVWNNTmYwUHpCeU1Nbi9aTW9NeFl1?=
 =?utf-8?B?UGpIemYrQTBjTmJIMGEzcXFSUU50R0trSFF5N1hsVHV1dVgwSHJsbTVPWVVP?=
 =?utf-8?B?K2h4OU1VcnMzRkZXL21mQkVQYzUzZXZLcXVCU0lWTTFaT2FpSWR6alBra2xi?=
 =?utf-8?B?QVBpU00zRWkwVlpkWG5BUjlydzNzY1R0ai9HTG93RHFRem1waEh6SUY5UkJw?=
 =?utf-8?B?TjJVUjgwbXdDWVBucmNwS3RReW8rOUdOM201UytWT2ZFSytyU0lOK0dBd2s4?=
 =?utf-8?B?UlNQYWhpSFRrbTg1Z1Vtc0hoaURJdXlzR2o1RFRMdEdxTENZNmFPT1VWSXZS?=
 =?utf-8?B?ZnpiaXpkRzk0Si9OditYd0gzRDRFMWZMWFNIb1h5aFViRllKKzlQRDA4clgv?=
 =?utf-8?B?b2hzTC80NW0yUTVveVByamZGLzVYVzFhTkU3S1Vjc0hqME9wazFJZ0ZXZS9i?=
 =?utf-8?B?bGd6ekRBNTF6M0ljcGNhZ1QzcVNvd1ltRjBha2Q2WGh1THgyV25YallUTWN4?=
 =?utf-8?B?Vyt1R2V5dW5pa1ltYVBxV2JpdjV1NldIc2NKNjNvdWcyZ2FWYnR3a1g0dUlo?=
 =?utf-8?B?aU9COVo3Qi9XUEtleTNONnhoR09jR216Mk5PS2g2SlBuL1I2QzJoMEhld2ZU?=
 =?utf-8?B?MzlTZFN5QUVmSkV1M0FMeUx1OTRmMmJuSHJCVFkrVUwxc1I3NndtY1I3NUFT?=
 =?utf-8?B?b09HdDNiY3o2SjRHa1Q4VUdPZFhwOHVXNkxNRTg1ZTh5aU0vaWVCdzBIT1Bj?=
 =?utf-8?B?Z3N2Y24vNFowdlNRNkd2Vm9FZWdBOHRXbnN4Tlp6bDlDSm9rUTZvckFEUXhs?=
 =?utf-8?B?M2JrVjVkNDBDVVdYUnpLc3pXOGp5eTYyWHd0ZFUvdHFyODkwRFNFZ0VmT1or?=
 =?utf-8?B?TDNBNTlhcW15ekEzQkU2bmFueWJnUUFVTDlMbU1BUmZFNXNkS0VSZkxXdGM2?=
 =?utf-8?B?MEhpTnd6QzVycWUrckRXSmdCdEJrUmFwMXA3cERwUGJYQS9TRE0xZnpYNHdm?=
 =?utf-8?B?bFFwL1dZNm5KQlpBbDhTMVcrTHpHcGJ0dHB0dnZUNDJUVVFkbmVYbUlQRUNT?=
 =?utf-8?B?MTJ3TWk4czVzVEN0N09DODViZlVuTS9WZFR6RTkyb3EybDZoamluTFlOdmJE?=
 =?utf-8?B?VktsQkdKeHBYMWpkcDIwZTRrcHoxeW1FaVZlb2dWdGNaYzAzS1dzR1dlRTRW?=
 =?utf-8?B?M2ZuT3BjRWhQOVZoZzNNSG5sYVczcEZoRnFiTG1zOVBPZnlPR3hwNHpYT1d0?=
 =?utf-8?B?WUZkaUIwY3JEN0lQS3VEU0xubS9Oak9WVDZQajNRcmxleEJhRFRZNnZHeWpq?=
 =?utf-8?B?UjJoYzhad1B3RjdKZlBuM1FPK2JkdVNyRURzYUtCcjJhd2V1bndGVE5XSEtn?=
 =?utf-8?B?RnZydUFMZDJHeXl1WFJDRUwwYUtrb0UxM3BFOGlsdFhPWG9XMmRrVnRTVkJP?=
 =?utf-8?B?MHZhUGxlVGRZeHVXbzlaM1ZQbmVTR2I2TFRXTnRDN0JjQTFFN0xQbmVrd3lF?=
 =?utf-8?B?UFRaakM4c0tLdi9xSHU2VXpOblVHdEpla0t6dUc2M1Y2NWZ2UGluSzZWMmZZ?=
 =?utf-8?B?R05hM09LSFJidHJkb2ozSVpHWVRLUCtuVGNyaXk1bWxhVEF4QjQ5aWpycUlq?=
 =?utf-8?B?MU9TYVVDMmZOdndrUWJGRzVNNjYzSEg0aTgvQnZvc0dzeHNISWZ3UmFmTUI4?=
 =?utf-8?B?UlpTS29uZEtOczdicGpNV3d1Y1BmaGhqNXRWWktPT1l0TWhQQVNwQmU0YXlq?=
 =?utf-8?B?bTNEY01xd0NlVUpRcERXTEUwSkNXK1FORkRTTkRZSndhdlhjUDUxUzk5UG5T?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147eae14-b570-438c-4f7b-08dcc8e7a1fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:33:56.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5/GBxhBhiA9NN3VipitvQlRUp9yOIzeWuP+hzFGKHRAzIVSrWK9Vjf6caOoOep6HoAXclJCEMN7VQit/MmUv9Spg+5kKUuH7MEHOKCOdvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Disable SD/eMMC UHS modes for NXP boards which do not set VCCQ voltage
supply to 1.8V by default, such as S32G274A-EVB and S32G274A-RDB2.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 1 +
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index 7ab917f547ef..b9a119eea2b7 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -39,5 +39,6 @@ &usdhc0 {
 	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
 	disable-wp;
+	no-1-8-v;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index 8739f63771bc..aaa61a8ad0da 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -45,5 +45,14 @@ &usdhc0 {
 	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
 	disable-wp;
+	/* Remove no-1-8-v to enable higher speed modes for SD card.
+	 * However, this is not enough to enable HS400 or HS200 modes for eMMC.
+	 * In this case, the position of the resistor R797 must be changed
+	 * from A to B before removing the property.
+	 * If the property is removed without changing the resistor position,
+	 * HS*00 may be enabled, but the interface might be unstable because of
+	 * the wrong VCCQ voltage applied to the eMMC.
+	 */
+	no-1-8-v;
 	status = "okay";
 };
-- 
2.45.2


