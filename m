Return-Path: <linux-kernel+bounces-349533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0E98F7EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B31E2826FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EE21ABEDF;
	Thu,  3 Oct 2024 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oWFPEF83"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013041.outbound.protection.outlook.com [52.101.67.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2384C8F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986487; cv=fail; b=fW/VMCvI5H7nKw0Wi8/ZTG+rsYyhguVtpIiOeTrzLyoT6bHpKtaMZhjlEUvHTZ9evzgYEK6oL7LwTSxkmv53xiqUWWJ+J0CJ9aR5GccW2lNXatdtfMJMrrtDOy2XJgZjIMZEWOkEIVP+ksuAlX0k/R7gV8gFk4111OvbuRjwMgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986487; c=relaxed/simple;
	bh=Fn+xUFtUNC4/pC9Kg7zC3XBaOt3wtdtlXo5itdLWzaw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PwXNV4P0F+2SDLQWfpE0JE/RahESjhmPPuEugLlqRp+/CV++2claSoB9m4ZXTgsJsjVcWCy00XMN0/18QK6dhS8wbvdIXaTVfWn+CGmePPd7Rb8kOkiYufywey1AXNB3XvfR3WkLOSDYdf1iSgeMakiMQ8zIpwt9w1AHL+ROet0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oWFPEF83; arc=fail smtp.client-ip=52.101.67.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx6sKZsuzH1n9JyRAx1sBXE8mw8c7TA8ah3pxb/N/1WIBdmj5s6ecPzOJ8urzEK08pRCygYuN6YoG6JuGLb/G02LR2yX+iQASdhfBpnvZWGuvUnX2XRa9yHgE4Da6b5TOFaFWrqsCJ0W3U6knyAwmep4OZC2MDUJwKo6h4YCJm0aoO/Kl4cXbtpgfMJyAFBk5LOQZ93Vz3RdlfP3+v7FX1/5gvOniV3yxHLw6pGIbb7EKk9eCT/QHEdkxAZIrwpByhtkz5UHBUGgjbNpyoaunW6lJCHqctiIRDGTg4Jway4IrozXutc+PzNIn7/uQPL8HdFWtzJKW/VD+Fwy+pKUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3e7x9cLibEAaJLBsUqwYYYpuTR8RvsoOm9bWgcixXg=;
 b=bpt0BIpso6JdN5QiJnW8U2KzeH7jdqXd+wkLVqUxjHAlIFa5nS40X4yCj/7X5G+xmSL06aPZ9qmrz/X1d8jpTGDh501dsm4+J7odX5bNs3A/okMscLKir+1GsMy+Mh7WHhsX0IF+UkvZhkLu1KupkrB6HWwqiMc1B+0qX5jSYLrJUA+ZLaR53oxg8+9FWIjgt0WNieqcoZqkUmv1m5yBcsG/EoyADlgU+Rs+n68kaCXjxkGQ5Vxvj4QSMaNS7nesuf4nqRHor13rrFHFTGS6aWNhE/cVIts0kX9Gtt7e9yb2T7J47gs97J6cLbPIDbJdUJL+hfKqXlFW3t/2MM7hqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3e7x9cLibEAaJLBsUqwYYYpuTR8RvsoOm9bWgcixXg=;
 b=oWFPEF83eXeP8VDgeVVecmQSRrIm3uQIKUwtWgI5a4vyPPMbtqgwVfXKm9IFUL/DjOZR9gKuWCG+yXenhGkfz5bbQ49SfZnQCNyx1PtmTUdNmKwABOaXAiRE6O4vES4RPTGLCrVr7Cy0yGqvD0NocjyT9cWPHfklrhw0SjWd7A/f6HPTed9ZoDV6KY7KXQQz94WPTUApR9f0p0bkjzzbERSRS8LmPIBVCduI8APQCpxCUOjrqcUaK1WPy7YZeKxeLP18wAfv4bbCdvbp9fPL/RSPGfvAdhqhO4NZzJSp27DlFmlLhhKJDL0QfbponmzibDGrvXyI86+c7++FkkLjeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9291.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 20:14:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 20:14:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/3] I3C: master: fix the address assign issue if
 assign-address is exist in dts
Date: Thu, 03 Oct 2024 16:14:18 -0400
Message-Id: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABr7/mYC/3XMQQqDMBCF4avIrJuSMTVIV72HiMRJ1Fk0SkbEI
 t69qfsu/wfvO0BC4iDwLA5IYWPhOeawtwJocnEMin1uKHX5QK1RsaHOr9I5ER6j8hargYwhQg/
 5tKQw8H6BTZt7Ylnn9Ln8DX/rX2pDpZXtXW08YRX6+hX35U7zG9rzPL9Q7CAvqgAAAA==
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727986479; l=2848;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Fn+xUFtUNC4/pC9Kg7zC3XBaOt3wtdtlXo5itdLWzaw=;
 b=AZD6hOV+dyTjy+/An8j0rt0krZIDclUj9O8ZiXBaziPx2dTLqKwirt4JeySq+9QfRW6Cc/j53
 L40c5ZqjGplDZb51ib5yUBmMm6eu0LNzDlcMNxjZPaoDJZRo5k3yF9P
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: 42202554-aec3-48d4-522e-08dce3e8044d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VElGTW8wS0QwdnNuU00wUEp3cldDZnZmVVJXSXhZLzVyRHJLbVo1WExlTy9R?=
 =?utf-8?B?d2hJWTZJVjBHSjRTQVE5MU16REppdXhDOERFRkVwWm1Kc3VlcVpzYTlYcWxI?=
 =?utf-8?B?Q0EwMnM4OHZSdXhXRUZZeFRCNGVyNWZYMGZqL00vRFIwcXlmOWhINmlIZXpI?=
 =?utf-8?B?OUxwMzV0L0dlckMwc1BTU2JPZDBGVnBBWFpldFgwUlUvc0NMTHJaOFMxckJl?=
 =?utf-8?B?U0NMM2E3VnlmZlVydVIyWXpKa0JVY2tOa2NyT3lJRXNYT29OS25rVGZoalRh?=
 =?utf-8?B?SXZIR1FjeTZsZlFNbU9DVURoTm5MMFVjNzE4a3ZiMm9LR2JDd24ydHVBdUw0?=
 =?utf-8?B?cEZNNjdoZUVwaDZHeXVKY3RTVmNpeUhFWC9aQ0tqTkNPSEZkMXVFOHR1MXlT?=
 =?utf-8?B?K1FrbzR0VlBOR3JLUTQyMG1aMGMxSkdGbEtjUmw2TUFhaVJkbW0ySU81Tjd0?=
 =?utf-8?B?U3RTaUJGVTY1ZlFMRjc4ZWs2MmpwTlZxUXJuci82NnRwT3dXTWRYY0ZlTzZp?=
 =?utf-8?B?MmpHbkI5SzZ6Tlh2bVl5cHhyV2Ruc3o0a0M1Nk9uYmhmUHUxRjladWZQdnpM?=
 =?utf-8?B?cnRDNDZCaHI0Q1FaOUlvbWZZcTdjTGt6K1NER0lsL2NybnhkRmFyV21EVWVJ?=
 =?utf-8?B?K1ltdXRmdElVTEdCSTNzOGNueXVCdVNTWkxiVGEyWHFqUGhDUHArQjAvTlVL?=
 =?utf-8?B?UExmOExMbzZ5Q2xzcHlPSDJiM0hScCs3MnlwdE1BTENNOFdReTYzOTFuUGRM?=
 =?utf-8?B?ckhJUGtVbHdrMzkwZTlHa2dEeHBrMlNIL3JxWmFNZ3U2TkxPdFp3czlzNkVI?=
 =?utf-8?B?aFhRNWhUV0xIb3pwKzVUcW9OaUM5dld2TmVPVFpjT0Uxb1BuWlQ1MU42aWJy?=
 =?utf-8?B?MVU5Z0FRSVRiNGNXTzdjVmtUdFVzM1hYeS9DY3MvUnlZM3BKRGtkcEZ5WS91?=
 =?utf-8?B?TDZYN0tjMnRaTm5PQzM1YWpiOFl1QUVGN0R1ZGpzREhhMjJVZWtXc3Y5aW0y?=
 =?utf-8?B?SlVPMTFYYWRtcjREd2V0ejVFSVBXWEx5TkRwV0YwaURGelBmNlpQTTMwUDNC?=
 =?utf-8?B?c3ZWSXpLM2g1c1Q3eFFNV3dhRis1dFhQRFpFdUU5eHpzSmxTTm5mSVpMKy94?=
 =?utf-8?B?WlIycEZkdC92UTBuSXFYUHNLSkN6ZHlqNGtUQXJVNTg5bTUyWUFsWDNzNXR5?=
 =?utf-8?B?WGpNeWRTUUI0SkJmRVFidklPRWs3ZmlTWEtpempac0JDaFJtaWFtQ2ZEc1BS?=
 =?utf-8?B?WHlLQ1JrOFFJK1Yxb1BnNE90ak9QamszVFpVbEY4cDlISEVjZmc0YzhTeWJ6?=
 =?utf-8?B?a2Zoa3Z5eW9KOGFSREZ4bUt4d05XUjdxNzU4SG5SYnpmclNTRzV5dVBzbmJN?=
 =?utf-8?B?Nm5TdTlQaDBVZlVEKzU0Q3g2cytUMm0xaWREOWpneXBSRlRMTG5ac25PcGFV?=
 =?utf-8?B?WnBuUUo1Mi9tTEdMcUZOU1VRTTJsekhTcE4rbW8vZTZGS0drTVBYYlMvQjM1?=
 =?utf-8?B?Mit5VE9rZHNyblZITnUrbFhVYktYakZNT0psV0VkdkpVcm1jTCtCSkVZaEx5?=
 =?utf-8?B?QmRjN1lPTHc2MkFlVGpBQ1lOU1UxY0NTUU9Denl1cng4Y0g1V1Z4T0xSUjFJ?=
 =?utf-8?B?Sm5LbFQ5bDE1bW9zT2RmVGVjYUVFQ3FvQklVcjhoWUdYZk5xYWVsUDVYWmNm?=
 =?utf-8?B?NnhsbkFvcUtTbUt6U01vUVZyYTlHVGIxTko2Szd6dzZGMzBJdUp6QTJiWUNJ?=
 =?utf-8?B?ck5zQ2ZhWTlKYmxQMXAvNERCbGlYaDh6SFRBUG0xbXBRWUpRejFWQVdPNHZH?=
 =?utf-8?B?OHpnQnFsOXRZY3RsRjJpUT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NXdLSG1BY01iVDNabCtDcCtMK2pFZEJnSDROcmlzRmNVZDFpOS9nc2gxRk4y?=
 =?utf-8?B?NFFLUFAzRmovUTlSNmcremwyc2tudlIzK1VYS2pBbXlvRS9HNysrVGhNZitR?=
 =?utf-8?B?bGZPT1hZTUMyNHhQUlQwYzN1VnVqcXRzK2RDUDNvZlN5bTJCOFlMNFpFSytq?=
 =?utf-8?B?bzRQbnI4NlZkTnEyK0dZT3EyY2RRd2ltR2V1YWptS2dENVlySTFqd2wxZnVj?=
 =?utf-8?B?aXVpZUVvZFBITlp1TnRuc1VOaWFMcjJFSWhONG1UZ3JrdndmeUdJMmZNUnNT?=
 =?utf-8?B?NVVqWE1HWUhRZ01SQ1J5bnFoWUZDNC83bGVGK0ZINGVUdTVOU1R0Uzhia1FG?=
 =?utf-8?B?cVplWkh6empyVjkzMXd0ZjRySWRxMW9OYW1DeU9EVGIrME96Mm00M0ZWa2JO?=
 =?utf-8?B?N0dxbHpzWmlFaG01NS9XTmF2T1VTc2NPVUx3dmVGdUlZRXp6d0hJMnlUTExU?=
 =?utf-8?B?VXoxWXlyWWQzdi9Jb2FSRDUvdnZBT3lKRXJjMkQ5emdBMXVIMlFidnd5Y2J1?=
 =?utf-8?B?eVEzckJYL25sbnIwcEk2aTdNbDUwQXVNeUFYaytqOXN0ZGxHSm1CdWgxVFI4?=
 =?utf-8?B?RTRvUGNkM0lYQm5SYnpSa2lsVkVJUlR3OEQ5QUZscDRZK1RyNmpXSnFzTGRX?=
 =?utf-8?B?ZExEemF4UjkzaVJodGI5azdoVnpIRU1VTzY2WXpVY3QrTlJCQXBhR0pHRmJl?=
 =?utf-8?B?K0hwVEYyTXhSKzhrQjVWQzl2TE9BcUZNOUdIOEFoUTUvdmpNZkE1dHE3bjMv?=
 =?utf-8?B?ZkZlMTZiR2VlYkw1ZzgvZERFQWNHSGxMSENRNU5lMTFqM1dpTnRCZVFmeUpJ?=
 =?utf-8?B?QjFqSHdQTGJYOVM0RDJTbk4vTjJ0b1ZwM1NRNHpMVnlodzlNYjJBdXc0ZXZl?=
 =?utf-8?B?TTNSdm5lODRPZElLYlkvUTBNQUlBa2hBY2lnU1p1eUxacnBIUUJYWHdqUHNz?=
 =?utf-8?B?OUUrcGdCSmo2b0FtT0JiSG1VUnlaaU9STm5UUGV5RXdrNVBqUDY3SVFBSHRI?=
 =?utf-8?B?ME0vUWZtVUZFZ1ZIVHdjRU1mV21SRzByOEtEeDZBUWFTUWRVWFd6NlJqT2NG?=
 =?utf-8?B?OHlucUpaendYbEdBMGhmemQ3bmF2QTJvb3EwWHB6N1ZNdi9OOWFEMmZ0WHJa?=
 =?utf-8?B?c1M4cmtPRWdMVzNVcFZXMlZHWlRwR1Y2dEJxNUVZeWNkekp3OGJLMGxwMzZa?=
 =?utf-8?B?VzdGbDVlcExUdHZtR2ZuSGYvK21rb2srclRnWlpHUWM1VWpFcWx4VnI4SEt6?=
 =?utf-8?B?dXNiZExOblIxMGt3RWtFRmdoSUZUQ3VmTU43NC85K0Y2dnRTSDRJR1VnanBI?=
 =?utf-8?B?bmlqbVVXU0hacGpwRUgybTBzUFhYTTJPWDVONHNjMHlLeGo1Y21pOXFiMUxN?=
 =?utf-8?B?aDVWbCtjNjRONm95SlhBVzZzUkh6cmxJbXhLYkE4QitLYXEzWVR0VXZGbndB?=
 =?utf-8?B?M0RhMHV3OFQvbXNrS0N1VGNHK1BNSjVWazJoNEJ6K0lGUHJ3Si9uYXpkdzlG?=
 =?utf-8?B?WS9lMThYRnpqRkp0S2ViamFHRGFLamVDWURtdlZYNUxaV1hlWWhPVGdFZUVM?=
 =?utf-8?B?UnBEOVpYeGljVHRCejg2SytJeVZsTTJUUzJZOThvc0VFcW1ITmpHQlRuZkRn?=
 =?utf-8?B?bXgwZ2RsWG43WWkzL3ZIUEpxTnZrMXc4eDh0bFFRSk5EbkJzc2pueFd5KzRM?=
 =?utf-8?B?MlhFY2tFaC9mS2JKYVNrdW5mNUN6RnZkdEdMSzMwM04wYlI1WmhnVlNIOUZN?=
 =?utf-8?B?aHR5d0p2QzNDQ0tueDVUQnVRVWdQVXkvVytXMHZ3Snh1THJSMnlZZmRrNXpv?=
 =?utf-8?B?QmNzbzgvSUZialptSmR1dFRGSTlOOW9YRVlFSEYzTnNxNE9SaGd1SzZBdWw0?=
 =?utf-8?B?aEtPVWtYSk5WTkw0MGF0K2dPWTM0RktROG4xdVZvZzlJdU9SMzFGN2dkKytL?=
 =?utf-8?B?dDNYVGVsMC9QL2s2Uy91RG5BcDNpN3FOL290UGVhcXQ5SGVNT1lyWU5mMWRi?=
 =?utf-8?B?N056cjMvcUE2WXdCcWRaaHlTd05oVE40U2o5OGhpbWpZZWVsdC83ZTVWMk1R?=
 =?utf-8?B?ZWdPemQ5WHB6cUhQdmZGVExMVW9MbGdBZG5Seld0UVhsZmN1ek8vdE9mcVNN?=
 =?utf-8?Q?n6Rc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42202554-aec3-48d4-522e-08dce3e8044d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:14:42.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+lwjshSKvDCDgriOVaB087AHmRLSJiYyKQAPxchw+H3z+unslOkQiWHMkZ3ivR3SmyEEzcDiYkspvgIfIymTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9291

These patches are split from
https://lore.kernel.org/linux-i3c/ZvrAuOBLgi+HtrPD@lizhi-Precision-Tower-5810/#R

There are discussion on
https://lore.kernel.org/linux-i3c/20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com/T/#m16fa9bb875b0ae9d37c5f6e91f90e375551c6366

Basic back ground is
The current framework is
1. get free i3c dynamic address
2. if found dt have assign-address for such device (identify by PID),
change to such address.

There are problem in current implement.
If device A have assign-address 0xa, device B have assign-address 0xB,
which described at dts file.

If device A is not ready during i3c probe, and device B hotjoin happen,
0xA will assign to device B, so if device A hotjoin later, address 0xA
Can't assign to A because B already use it.

Mirquel's opinion is return address B when B hotjoin by scan dts by PID.

The issue is the controller HCI (i3C standard),

I3C HCI Spec 1.2, sec 6.4.1, when do DAA,  "DAA CMD and dynmatic address"
queue to cmd together.  We don't know PID before DAA CMD. So dynamic
address can NOT get based on PID.

When do DAA in HCI, it needs a dynamtic address firstly before get PID
information.

Consider this need more time to discuss, so split from previous big serial
to avoid prevent other fix patches can't be merged into i3c tree.

This patches's overall design:

1. keep current frame's work flow
2. reserver all address, which assigned in dts.
3. the device with assigned address have high priorioty to get such
address.
4. if all address without assigned by dt are used, use offline devices's
assigned address.

To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de
Cc: bbrezillon@kernel.org
Cc: boris.brezillon@collabora.com
Cc: conor.culhane@silvaco.com
Cc: gregkh@linuxfoundation.org
Cc: imx@lists.linux.dev
Cc: linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: miquel.raynal@bootlin.com
Cc: pthombar@cadence.com
Cc: ravindra.yashvant.shinde@nxp.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com

---
Frank Li (3):
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_DESIRED
      i3c: master: Fix dynamic address leak when 'assigned-address' is present

 drivers/i3c/master.c       | 77 ++++++++++++++++++++++++++++++++++------------
 include/linux/i3c/master.h |  9 ++++--
 2 files changed, 64 insertions(+), 22 deletions(-)
---
base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
change-id: 20241001-i3c_dts_assign-d615fc33cc1d

Best regards,
---
Frank Li <Frank.Li@nxp.com>


