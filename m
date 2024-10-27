Return-Path: <linux-kernel+bounces-383577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E349B1D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCFB1F2199F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA9156242;
	Sun, 27 Oct 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d4+3wXqm"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9C170A23;
	Sun, 27 Oct 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730029825; cv=fail; b=YwPVa9+wy+vhQ2Y7jWWZSmy3YDCoA/WCl6HjeOWrsnEzyj5N6KTL/3NTdP0QqU3Ozgfs4azrBTdk/s6HWidi7t+jqYJdAplrgG/deCpNlTnckEwv99f0oa0k7asYC/MkC929ara5teCEBLKFajrCvvxtW6UlZNG0WSt7S7NGJ/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730029825; c=relaxed/simple;
	bh=FnyQJ4KbSA5IYehksxsDruXIF7wDWgXvyU0rehFEl0M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Z57EvXoBIjGrHtMDUqGO+VKUJJadq/lIMHXKDbF5o1HemjowFgdgOSl2bNRauCxSMBW3k37t2BrkckZBnJQLMneVHTABrHBMlT1MTHbwJIHwpCG9k8LnR71ne88PhsQTpvWTePBQPUBZZ0JbOXaxuwgv/GciC1TnC3TFRJMTwgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d4+3wXqm; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2+cBNjTy2WypiP9t1U+x0enAfKrnhbmNEDv3XmPeJwD3D+a9zNpvykZ8AdZqEvPqVZA7mGAX5Fy3yzKi7sVl16iZrrxDZiYzh+pOP0LjYj6nO1Qf0ajQoYQzHZlLeJNY2aCjC/S+D9GMjzZn3i/unL588fmYD2Dcsc2VPv0y2F4RYsJyFwQaIGooDPINxpG6EZBpQdG3HYKgnzi8uWvXtGCVvZCBOrgr3Q1Lg/HdmHPtiDLdVRxJkFI+z6ojr9BGFKFhBqcd/McVzW0jkvb6MQc05m3zIfhGVDeAPkmKiJeJZ4p/DBKVK7XmZu+MPPI3qxqSllC+J1CXtface4QCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeMdrbEeiHP0OWLxFzTmf1X1E5W0VvOXXT8+i272q4Q=;
 b=Caf67s8Sy/qBJ8M32pgT7vyNmRG/xjt6Yt6fORISj3LonrxJgM4FgpNVVAVcu98nrW//OZhacDwls4BxRdVQMaFWs+/OEvxbLSZQYzF+a5QDVGVHUF6zWPyVnlcPUdCw9SoFcKKSl6ig8Js/WeH9F2xP/gBuQouW5i6X3YSN+7Pj/rXxoW/SM59/F6EEmDjtmi0ZKyf2wkJq6Qfg8ng/b1ld7yhPGFkfvIBeoMJjLS/WkNGg34QkDUOHl52ypyczVeK6xV4q9P29jrerp58yjLJwuLIzpi3ZVKi0iutk9fhoSq2PAVQeUGiGc9YfUUHmppl8QnGn1Zz3yyAcKPe6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeMdrbEeiHP0OWLxFzTmf1X1E5W0VvOXXT8+i272q4Q=;
 b=d4+3wXqmLgdwscuh/NNO88jobkyH8y58LQXtf/5lgP9Bohiq0NrHkgKtgSmdiW0YvANK41VYEPsu7w9UzFFkMO7dOXXa/7eMLGx1bwEr7LdoxFhRCjDTqg9LIyo4xLBlvcJXy4lY6SRme8rpT0b934zx1A+WTvcE6wRYGH9nNznLLfEFHBjXZJfDvVf+NCqOHNfl/Tib6Z+7ofBazUuOLzpF9qOnJfTh1HFqUIU8VX3B+PgdFUqljOLzx+Ic96pi4RXNr4Q1E10WNVhM+iSRDIDK5QAytyg4gEKSm1JAr9i0gH7GrD9023fLWfTAi9vXvpcD1Y1NMFDlsJRJiaPUWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 11:50:19 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8069.016; Sun, 27 Oct 2024
 11:50:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 27 Oct 2024 20:00:11 +0800
Subject: [PATCH v3 5/5] clk: imx: lpcg-scu: Skip HDMI LPCG clock
 save/restore
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-imx-clk-v1-v3-5-89152574d1d7@nxp.com>
References: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
In-Reply-To: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730030419; l=1554;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=k5AgvMxJOkPlhKlSMu3UDdZczpUXI2PHGzFfZGRxtfs=;
 b=h9DapNZroXt/cac+Tk9/QxyshQKZrQEjnIj8f4f2v7n2b+Qo0H3xPMkLdQveOcR437j8IT5mw
 pstmqx+cr7YDPAgl3m4/goolf2Xx/VrGBxqD60Xc24qnbK05Xq95ctd
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: b818e4e1-a7b5-405c-34db-08dcf67d8847
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UklBM0wwbUJRZmFBT0lOT3IxMUNua21EQVFOOHRFSnVrZzlXbUZjV3F5Snoz?=
 =?utf-8?B?ZmtVSXk2dzhzOTlZUCs5dGhRMXI5eHNmT2N0dkIyejdsKzhQNEdFMXNDc2VG?=
 =?utf-8?B?OE90ditMMEZLZTc4T25HUHBPVnowaEJrUmZRY05yZ2Z2ZTZHMGIrMTZ0RFd4?=
 =?utf-8?B?RGZNQTNvd1RzQ3MzblZjUENBbEkvZWpUbk9BN3doTThHNGRXMUpNMWw4S2xj?=
 =?utf-8?B?Q1dzYXJPRnZiNGFyMmsrbGVSZWZXdzBENEg2ajduR1BIYWtSWjh4NzhNakZ1?=
 =?utf-8?B?c2psQTBhemNsT2kwRHBNeHBWQkt0NGdiMGNzUHlDWkdYM3FvQVBtMDNFbVJT?=
 =?utf-8?B?UUwyQnMwZCszRWJlUUJLTlJ3WWdyeFJjSzRFMGYyN0FrN1o4TVVySjVNR00y?=
 =?utf-8?B?bHloZzlZaHd4TmRyQTZZM2M4c1RLZ25wUGRFYUpWVG5HRU1XSTFJYzZjQk0z?=
 =?utf-8?B?ZjV1SWYxZEMxWVNRTGVSS05LcitUL2xrS3JFREluWEFHTFphbXVxM0hzbmNH?=
 =?utf-8?B?b0FQV1RZVHNUUmJXQ1Q5cXpzVWtJc3ZhWFEwUDVoMUw3MU5vU252NHROc0pn?=
 =?utf-8?B?aEl2WndxMTk4RXZVR2c5SmJCWVVUQS96dHVSTHRBSitWeTZVYWtqVUljVXBG?=
 =?utf-8?B?K2xRaXk1RGRCYmxwYm1ROUFZUGtyaVluQ1RVakNIMlQwb1hYQlNyZmd3Rnln?=
 =?utf-8?B?cTN5TmdVMVlaVm1DWlRsQ251bTR4NnlnblNXMUg1bXpmV0p2T2QwUjk5cDRn?=
 =?utf-8?B?aFZDSW4zVHU4QmhvNTkzeW15dzNCRFNHcExLRFVGVGVQdjRhVTNHSWZzQkxj?=
 =?utf-8?B?am50cVVNSENTWlZWUEtOM0ZWVjRqMCs2aDJCNnJBdzljWEU5ZVE1U1F5Sk9h?=
 =?utf-8?B?STM0NWxLNFlmSWZzTzJwSEsrMmI0cUVzMEs0eVBsUWNmbFZIYzRFbVJabWhs?=
 =?utf-8?B?aWc4WVd1UnBHdnJnUGxrZHZscDRHenFlbkdYZXNHcmx2N1VwbWozUWJzenlj?=
 =?utf-8?B?bGhJaXJ3RkRORWswYlV5MmhVTFZ3d1BzVG1waHF0TmVTeFNNUUhFU3Bxb1Vt?=
 =?utf-8?B?N2xFcnZib3hjTmNYcGwxTFlJV0xNMk1xVjlXMWVGU0dub2NpN1FEN0FWQzZI?=
 =?utf-8?B?TWFKaWQ1Vk96elYwL2s4V2NLT1hKZEVjd2c0RHEyRTVpVURBMmNDQloxb2xT?=
 =?utf-8?B?UEVWT1cxbFdoeVJOYnhhWGtOZVArblo4M0w5ZUxpYzRyd0RZRjNoUjgzdUxy?=
 =?utf-8?B?dXBMcjZCME0wSlpKeE5XTmVXTzRZazRrQWQveVg2UnFwbHd3NDVrbWJFUG5v?=
 =?utf-8?B?LzNKWHVyTHczUEJ5ZEtpcHQ2S3NFK1prWk9Jb0NDMGVvSk54RWdGeTFBS2Nt?=
 =?utf-8?B?c2xRREtENUlXR0dtRXZLN2QwZ25ERTI5VHljYjRGd291SU1lYktpZm95Z2w0?=
 =?utf-8?B?RjZuTFRaRVFnWmtBdjBpN2NjQXNRQjBaVXl4azRlZll0WlgyRThqQlNjTTU3?=
 =?utf-8?B?WmZqRyt0S09BeFQ4SmhRZHZYNlpZYzhOaWtpWnhlQjJMcDNCZ0s4eUlvUzZ4?=
 =?utf-8?B?NDJkWHBMRXdvdnhYZWI5NStGNWIrL1pkc1J0UENvRS9ydm1EaHYvTE5YTDBB?=
 =?utf-8?B?ZEpidGZMam9QR0IwYVRiTVVONkZ4Q3J5UHc5SXVxODU2cGFuY2FnK3FUdS90?=
 =?utf-8?B?THlaaGZTM3lHaHJHQXBZZnU4SFZSUk5lOTdqYlJ5QUpzTkhHbXdDSTNjME9n?=
 =?utf-8?B?MFpkS2JadHFGT0kxcXV2UmZ0WnY2WnZlbEJaL0hRSDVrVXpacGsxaHFaeENi?=
 =?utf-8?Q?1MwABbq5xDd/cdVeIn2puBpGXRM+z0UG9JSS8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzBxSENpeDlZelJQT2t3S3c2VWdyaWc3WURhQzJuRFBneEd0WXZQa0ozMXlV?=
 =?utf-8?B?cEpvVlNJUzlkV2tFNDhBY3hWSU9tMEpsSlpkcG1VbHYxVFlaQnYrUVhsRUUw?=
 =?utf-8?B?TVNxaEFPcHloYkl6czhJN1hPem5hV3JDWkpoQkRQbkxqYWcrMHU0R3JpcnRt?=
 =?utf-8?B?UVFuT1JobkdBaGsxK2wxZ3hSL3A4TUovUzdPTGgyWU1pS0NMZ05ua0IrdFIy?=
 =?utf-8?B?a3hmdm1GU0d1VWxnNmp4R1d0M2taTUdUUUtnazlFRTVtUkpLQW5CaFlCc2ZZ?=
 =?utf-8?B?QXlCNDMxTDJiN0UyV25PT2RabU95blJzNnl2eW5xQUhjTEZKQk1XaGxYclNZ?=
 =?utf-8?B?NmJoZ2ZQSU1xcmwzR0c0YTNsQ1hYUEpxaDBBRm5XS1F4WklNeW1tYmQ3THlj?=
 =?utf-8?B?SzJkMU1tM2NsYWxYOWdYQkY5ZlVWaFc2RXRBZ08zZ1gzbjNwbHZWZXd4NHdu?=
 =?utf-8?B?MFI0cUo0aFl5dEJEWU1pbndiZTZ1KzN2djNKV1RDSGtqMXlmMTc1bWJkdDJo?=
 =?utf-8?B?R1FFZ1lLR1RDekZ6RDBjZFRJR0VqZ0Y2WDhkSnQ5cDR0NWdmWCt5OGptdGJs?=
 =?utf-8?B?Z2FqVU0vajVZQ0ZXblBVdVVQbmo0RFpFOHR2YjZncFk5K3BrV1E4MVltOWk3?=
 =?utf-8?B?ZnJDV210aUt4azJoNnNlWEFqL3NndlI2SWdnbTcvTWJsRHA0TGIrQmlCYWpt?=
 =?utf-8?B?VjRBNGUxY3FRRzRTM2JrNmlPS1FvTG5rQ2lNa2IwYmVBUEVPTUJzdTNoeit6?=
 =?utf-8?B?TEZiN3ZGakQ5R3hqUmVPQXQ0VzNSMUU1dnpZd3ZsclllbDN2by90bHl6REk1?=
 =?utf-8?B?TXpkNzFoUE96TEhuWnhkdEFsUkFXM21nWDd2RGlIZmRRV3hZVERDcnU1WTZ0?=
 =?utf-8?B?SVJma1NwTnpCbndWbmVuOHg0RTdoQ040Tjhxczh2aTduOEV3TjhhakdjMjNu?=
 =?utf-8?B?L2RVV1ZZcXB1aUs2YS9panBENEZjSUlZTGYxbHdTYVc0cWI4U1d6SnFyZ3V3?=
 =?utf-8?B?bWJ2QXhqeGN2djIyTXE1QUFsS1JydlgvWVNCcks1em1RVk8wdzZZTGNSb2VN?=
 =?utf-8?B?N1IvOEFwVit0VWZvOFNzVkNqMFBiclVYM3k4bktGVlJqL0lPdC8rYTIxZFpv?=
 =?utf-8?B?azBxZU9FclNjQ3BwamhVcmVCUHBtNU9PckJKU0Q2Qy9haXd1KzNNYjhrSkk5?=
 =?utf-8?B?WHZXRVd5K1NGWFZZK1hFV2ZPR0p4Tjk1YVRQajU0WVc4Q1lCMzE3b0dlc3k3?=
 =?utf-8?B?aXFaMS9lNCtnOC8rNzFjMkVNRnJtVHBKUzhGUmZ4eEQ5dU1VUC9uS005b2FY?=
 =?utf-8?B?UUlkUExaSmhybzNTTHRSQmtVMGdOYkpZY2JkZ0plZnpXNWk4NTRReDVrVzRR?=
 =?utf-8?B?QSs5dVIwbWptcEVkbDdkTG8zSVcvN1diQXJKQlZVSXQyVlNKOUdNM3AyWjdl?=
 =?utf-8?B?UzdWZ1lDMFVjNjduMFNqS0VkUVFzVTdyaWd0enI4WFd4R2tjMHVzYU9uRjE2?=
 =?utf-8?B?UEZHMVl6ckVMcG9hWUdxNEdJcjRwampKMkxidnpJRE8xVzFMaFV4ZDFLbGFE?=
 =?utf-8?B?WDZMVVpjVXBnOEh6UU5EOENQRlhScFd2SEhtdVk1Uytybkw1bWZvZURYbVlU?=
 =?utf-8?B?Y0x1cGJCdnF1enhZWG1DUXhmUmpBb3NBK21FeEtGcTlqOFQ2QXhGS2RtcjJS?=
 =?utf-8?B?b3V2ajNJTS9kVzRPQ2U2NXJaei8xb2U4WlhuVjl5d09XWHB0TTVRSHZxYkFK?=
 =?utf-8?B?d0M2MWlaNjdkcDc0L2lBUXNoT3BwTC9xTExuQjJKajNraW0rajZHbGxLRUV1?=
 =?utf-8?B?Y0RKTmV3NGhVUzVlNlpUR3FmVGRzWHhGMlAyejdHZ0IxSWVyanBxTWNMS0Jl?=
 =?utf-8?B?TG03ZFcyUmRCcGlNQzRQNHplcWJPY3pYMXU4MDFMWU9KSSszRE1PQmNPKy9Z?=
 =?utf-8?B?SEIybG0wVkZsVExRSXhyQ3Jpa3J3Y2JZQ2xhNjBxV1VTTE1qMFVOUExsTlF1?=
 =?utf-8?B?VUg4eWFwYnRWMUJRbDd6S1hTejZJWXJoL1ZMbDNCeWw3NzZ4R0V4Vi90QzZP?=
 =?utf-8?B?MlpKdHBQazd1U2RKZUlxM3FNU3lrbkFsUGM2WWtaL09jZStaN1E5M240ZnR0?=
 =?utf-8?Q?8q/YW+zouOVofiSzuzSAE9NsL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b818e4e1-a7b5-405c-34db-08dcf67d8847
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 11:50:19.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBUUZHvq5ae7En+0T/bRzTPR/FE7AtYiEux6J8FSIXuZRqp+ppEj5dC/gUXIRf0tYDKyh2LArYwCZmHp6KEnQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689

From: Peng Fan <peng.fan@nxp.com>

On i.MX8QM, HDMI LPCG clocks operation needs SCU clock "hdmi_ipg_clk"
to be ON. While during noirq suspend phase, "hdmi_ipg_clk" is disabled
by HDMI IRQ STEER driver, so SError will be triggered when accessing
the HDMI LPCG registers.

Skip all HDMI LPCG clocks save/restore to avoid SError during
system suspend/resume, it will NOT introduce additional power consumption
as their parent clock is disabled when suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-lpcg-scu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index 620afdf8dc03e9564bb074ca879cf778f7fc6419..6376557a3c3d03130ca8168a6cb69eda73c43abe 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -161,6 +161,9 @@ static int __maybe_unused imx_clk_lpcg_scu_suspend(struct device *dev)
 {
 	struct clk_lpcg_scu *clk = dev_get_drvdata(dev);
 
+	if (!strncmp("hdmi_lpcg", clk_hw_get_name(&clk->hw), strlen("hdmi_lpcg")))
+		return 0;
+
 	clk->state = readl_relaxed(clk->reg);
 	dev_dbg(dev, "save lpcg state 0x%x\n", clk->state);
 
@@ -171,6 +174,9 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
 {
 	struct clk_lpcg_scu *clk = dev_get_drvdata(dev);
 
+	if (!strncmp("hdmi_lpcg", clk_hw_get_name(&clk->hw), strlen("hdmi_lpcg")))
+		return 0;
+
 	writel(clk->state, clk->reg);
 	lpcg_e10858_writel(0, clk->reg, clk->state);
 	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);

-- 
2.37.1


