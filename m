Return-Path: <linux-kernel+bounces-363601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8499C492
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FC228905F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEA2156230;
	Mon, 14 Oct 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iu97b0DL"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57860154C04;
	Mon, 14 Oct 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896574; cv=fail; b=lH7B38nMH/Va8gQ0/E18eWIZcMZLwtXfgRv46oOxEMOSOaWWfRkKahn++xbIe+32r2kZ5tLrr3jHPBRq6qjqautsn5iheUALmNn8gaCcPqSfKM/OJb233PcXJM5iWUK4o2KLzLYRBm9EYEZZS2UUP+3Z1KH/WzuqhBPdYZW+B94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896574; c=relaxed/simple;
	bh=nyNphbDXdv9/89sxQwH8tfm2s5SLSBvnQOiphaKcSfM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fu64clC1bE3QV0p8bdJ72CZCHx5pQ0mCkQvw3qo+Y5ZDGZNJW2INus3ZfvRwy8PMaOW1tA1EdMOoln9RxCcnRgKJGjFjrJJc6TRp9Zs40cmvb6p0zie9ga4vywLG6KeWPCrcHkUPggs+e+YEl2ka8rZHTQTUNsCxYrk0AwfChHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iu97b0DL; arc=fail smtp.client-ip=40.107.247.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVFJkXecSH9AeX1f11Tlbl+gGwkYSV5HvW4ekg99Xidxds9E4/FB24ZXxfPhqgy1lG6ZoXOOzpd2wyXRDFgDPkY9b/BYY4A+VRthyWnteWOBh8LLfA7GuQUukL6S3+4FMQimBxqK0vAblcT9S5xGDYsOMUGcGhu+jBgccyr1Rzmr+qMLx10k/RwRM6eiU8Psj2j5CZUjKhxOBWACPWe//xgeAAfxrtXxJ92iPJ4i/yYQnAWr8G4RZLJrZ+W92Ut++aV0cLvkbTtq7tE6in9Sy9ELGSOH+DtBsgpDsO1JgYrQKY3Y6UKq0mzwDom42ai8ryVHWB3kJRPPuk8HXbB6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWkiDlRqKMQVrdTslJQGTlBhAYtEMGibd+A9k4ZRs+w=;
 b=cXdZwyUMC94W87LNPaZ58UUyw+mSmIK5jtw7NKMdoaKttXbvwEw7z0/aiZWzFFarNvdvAsShmYKkZXKYJTTXa31eawKwvMguICzE4s4JJpuhLwjI9BWAehuxoSCC2CmBnVLBNYiGbinY2tNkcK2VXMIbi2X+soY3r+IU6RkJZBZgCD71xrIl0SUOx61TJ5h90spBN8wHBxMlCBQAtgLvbn/LdkHOk8uB6R0XZ1dVtr/4zsWgWlC7WQ9EGpZKN6kSgIQv59WTPOB4koYOh6cFJxWLuF7GbmmUPXAa/vPnmhBqh6ciz7IMownX0fyGXhmznef+ejAL1BqobU763Goskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWkiDlRqKMQVrdTslJQGTlBhAYtEMGibd+A9k4ZRs+w=;
 b=iu97b0DLUMF6ID8t8zXVNQElPOVPLpIyWuhPwnUzVqn5D3fD+XRHE0WUzYO2QuORuPEto+nSB+58CbpCA0GsIyK2q4NdMuhoU30jv+OqvdwrytsrctrpcNbtPLB9XnmhXsnmWzhptMH9AiWr2mp/xGCCoaomQFzrqqCXKg3WbjtetZjQpBd86lMXqHui6CXGt1UOeaPXiKOS9eMa2vGBr1qiDGLqp3+atmpZrCsEY1/KTlpPOxy8u9CQf9Z/suJVNvJG+OcFo78zrP6ZtfVg2e6snIjiPESAiAOacKIaffgKTpit/qaIl9uU03a567aWp9M9lfkcWtoiUpTU/ojm8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB8765.eurprd04.prod.outlook.com (2603:10a6:102:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:02:49 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:02:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 14 Oct 2024 17:11:22 +0800
Subject: [PATCH 1/4] clk: imx: lpcg-scu: SW workaround for errata (e10858)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-imx-clk-v1-v1-1-ee75876d3102@nxp.com>
References: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com>
In-Reply-To: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728897092; l=3000;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gPVJ62hn10fd8Mk5dUx6+DMIgNMDHMz4XiIGb+nUuxg=;
 b=+PT+d02018SH4dIlmd6VmmT5NpESWMszR+mVBeYO8QAysQV722o2BDe4uxr5gx7KCnZFckipX
 D48pvrY+sWGDFzskGMUlIUT+aY5VoRMlq3N71FQv4yLTN7KWP5bdTgX
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 42597541-d9ad-4d82-ebf1-08dcec2efa48
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnIvRDBFMGU5QVdTdW9zdTdIbkdDaW9EaTFuZ0IybFY2TUh0cTQxZDFxcXNB?=
 =?utf-8?B?ZldDM2JoSThMUUhvR0tVUlhLQlErN1lqRzNSaVFWdnZITkhpUDJmNE5tYkJW?=
 =?utf-8?B?TWdNZ0VoY0x5bWV4OHR4MTQzTm1MdGhHYytoOW5Dd1hlSHI1SlNWY3hQTklL?=
 =?utf-8?B?UGlBTXJUUVhadXJ2eXZFUHNYOHdwakxWQUhiRlVwM1hVdkQxeDNGb2RGSldC?=
 =?utf-8?B?TURkMUpmRUpSaW14NERWQ21oeVk1cXZaNzZtSE9vMHhKVUNWQkVrckZkenZw?=
 =?utf-8?B?VmQ2bGNRN1FZeCtNRmhMQUZyZlNjVVdta0ZOZ3NqYm5YUzVNNU16VlJURlc4?=
 =?utf-8?B?S3JMVEZxK3JTV1RiZHUwQkJQbjRLcndQSFdqd2IzL05kdHRRV2g2b1lkZUpi?=
 =?utf-8?B?UVJJVzJ0WTRHekIyK2NKSGhLN2JPT0FyL0w4R0VndjZoWmtFSnBwUEdMSGd2?=
 =?utf-8?B?TE5IMG93S3VGNjFwemh1Yk9oM3ZRc2xmbFJOMFNGUFBTK2N3Rm1zcm1ZZ0dJ?=
 =?utf-8?B?UUxWcmFXSUU5YzRERkpiWWU4em9NMnhQWStjZStmQVRTQ2grTFVIazJsMVZ5?=
 =?utf-8?B?ajJ0ejZseGdVekJTOHpQYnZkai83N1RVU3EydEhPeUR5KzNncHF6cXZ1THZs?=
 =?utf-8?B?aUFHRGFSZWNMdW13cVRhL3RFS3IvUVQ4djg0V0hRTUs3dGxwT2RuRURreXZZ?=
 =?utf-8?B?clhjc1FXN1VoVjI3SVBHckJNYWpaMmxRakFtOWlJejhSaWFvODl5alFoM3JP?=
 =?utf-8?B?SC9qOWpyakNzQlJRajdkZENwT1BWK0VaMGx0YVFjMWc5eEJKdEVJOExXYjlC?=
 =?utf-8?B?VHVIRGpoVXVCWEUwRFpBY295bmU2SUc3b3ArajlJL3JrZHVXS1RwbXBOaXBB?=
 =?utf-8?B?Q093dXcvMVZhKzJnRkF0bG1BY1B2ZzVnV28vbVFteDh0bU5EVzRhWlN5Mldr?=
 =?utf-8?B?UGNzZURYRlFVcmNRaE90UHp4aHVtV3ora1dQUzlXYTNEOWJmTkp3R0xjTUJZ?=
 =?utf-8?B?UVhGSUlRalpDMkVjV1N4RTZRREpSZW1USGxSbFVjZ0h1UTgwbnRma0FkaFAw?=
 =?utf-8?B?Z0VyUWpnSGVpdTlGOVNXMVpRa21TK0Q4QkJSTTBpRklDNTdWTnZ0RFJzNkNZ?=
 =?utf-8?B?UWxneDBOZVBEUitob1FQTHhJSHpONlR1Wm85ZmUrc3Zqd2lDaFFGRFV5a1pF?=
 =?utf-8?B?Y0h4N2lyQ1hwZ2tJeXJoTG5vQ0NtWC92aGcxa290elA5bFJjTEJFSk9UVzlN?=
 =?utf-8?B?MzltTlFwbmVoNjZEcUZIT3o2ZlZselBJZzM4cVFSU2NPS1cwSmRhS2RjbDZx?=
 =?utf-8?B?K2NsaGVKdzNaeE9tQTlKZnFDRjRkOG9xeEZHY2wzYm5HSVltNTFyc2ZLeHpV?=
 =?utf-8?B?Qi9Pd3ljdlVES2J6OTEveTFITy9MUEJkTHBxd3Bhc2lXdXkrb1BFZ0lndDNa?=
 =?utf-8?B?MGcxK1l5VUlLOU9YeXBYOVlYVFhFeXYrUzZLcnUvYndrVDRlRnRVUFVkMER4?=
 =?utf-8?B?WE9wTmxyRkNhZGNiTUgybDhVS3ZrWWllQjF0cHlqMUJDMHFhMUlSQ09IL1Rj?=
 =?utf-8?B?STlhK3hOL2RSb3JYdkhHaHgvdHEzTUhPUWV5bElRbCswU1lUc1pMRUFVNWpX?=
 =?utf-8?B?cWlLZ0hJeHRoWWMwaXdtRGZ3VGx6bC9yaUtQU1lqVXl6djFtajVjQ2NGWDh5?=
 =?utf-8?B?UzkzYlNYb2tKQTVuYiszNVBDVTd2YSsyYXJJQjJ1K1NaVTE2ZkpZOTJLcW5y?=
 =?utf-8?B?dC9rU3lVUWdKS0RQaWhlWWttNFRxa25TeFI4L1FMU3pGeXdsTGkwaDY5b3Mz?=
 =?utf-8?B?LzJZYmp1Z1YyQzU0UERRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXpXWm92VnBzbzJaMzNyVzRVTnVZeGp6bXNNN0dXVmd3NlZBWElqUThTb01N?=
 =?utf-8?B?T1JDMnNFMXArM1FiTFdmaHhHclkycVNDQit0dE1xTWl2QmVqdGkydnR3S1dv?=
 =?utf-8?B?ZGxqKyszU3hUSGdSZUcySWFvdHJ5ckxtRXdkNXY5STU2MWVOTkhiTm95OENs?=
 =?utf-8?B?T2ZTVmlSMllwWGxRKzFod2xhZlV4OVBsRVhnalR0ekFVZGl1SERWamdGc2Fn?=
 =?utf-8?B?SmNjeU8ycWEveTVxMEhycHdCNytBODhDbGJXbVdvWmVJaHQwaTJaT3ErV2NG?=
 =?utf-8?B?YXZCS0FmYnpid3NlbzJxVFE1TXBDN2ZMMk9XQm1wRmU3RlpqOWdORnpseWRR?=
 =?utf-8?B?S0xKeHZjaSsxNGVJMUp4VFp1bVFjazVoNGFGakc4OXFRN1QwSmdncTVVZXkr?=
 =?utf-8?B?dE5hUk9zbmhrNm1RdWlxWTgxRnhYVWRFaXVzZTVVNkpldWFTOFpNQTNJM1dl?=
 =?utf-8?B?ZlkwSXUranFLRm0wZ2RQaDJkOEFiSjluUkdCVzljL3FQRy9URHhWcW9yaDdV?=
 =?utf-8?B?REVVZE52Uk1OVUxlZ2VnTzR2ZUFjZktKUG5WcVltcHZqNjgzSGRYNFhXRm02?=
 =?utf-8?B?OHZ1ZWx4bS82TzlHMm1sU3VSUVVPTkZFY3h2Zk4wSUxBUXZFbWZGanlHNXkv?=
 =?utf-8?B?SCtkRTNIUU00Um5TZ2hwb01uY0lZNVBMZWE4ZFJ1dlczY05Mb2xoclRzUnVY?=
 =?utf-8?B?bkFleFRyMTZkQjUrWXdoVW4wS25YVncxTzFObDRtd0dVaTB3bElVb2hXcEpz?=
 =?utf-8?B?aDBYY2FnMEtFYldtV2RxNW5hQ3FiaTNYZTk3ekhPanp6Mi96Mzh0MG9nL3Jy?=
 =?utf-8?B?elRiWXJrRmlQT3g2M2RmVlgrcHowMGhMSzRFdXV1Z1k3dXU5NlBvRk1sblZD?=
 =?utf-8?B?aXpsWkdLNWRJcnFrNnM0dEp3R2ZjQ3owRjRaM2NyUmFyQmZEYjJ1YU13eS91?=
 =?utf-8?B?blpMR1JJU3RYamdWeUFkQ1l6NVVtS2h6c096N3Q1V0lPbEtvNWpoMFBLMWp6?=
 =?utf-8?B?STN4ZFRUTGpUSmZvT2IwV2lYTzh1cFlubFU1eHBNNjV6dEppbFFpK0dQMnZY?=
 =?utf-8?B?QndXTHVPMm9uS25qdlVXaURDU3FieVlBZ08wVC9KLzRtbE1TZmtzMDhCOWVa?=
 =?utf-8?B?a2RMeGdzYk5PRXNob2QrbXNJekFWT0s2SkcyNmxGMER6Q09qbVB6NmpLRUxO?=
 =?utf-8?B?UWpCZ3dRWjV3N1NDVnVnc3VKZE9JYm9lSmdMSGZ2aVErYnlOWGlwRlBQd2Mw?=
 =?utf-8?B?ekpTVkFRWDB1S0RJQWR5UGppVnJRNjBFRlBaSTk5QTczbjJmSmh6dVlKOWlQ?=
 =?utf-8?B?elM5Q3MrWWluaXgxNzkrT3NMb0dlZGhWZTdUNWcrR2RFOFVOWUFaMVBmS2dY?=
 =?utf-8?B?RVdJV1g2OWo3dVVUMTlHeWFoaGRPeEwwL3Z3M2R4UWpzSUVnOGFvWUl5VzE4?=
 =?utf-8?B?QjZBMXhmTW5qQzdoYmpwRGpyTXZCU3Y5bnZZTDJkTnJJd2w5bHVkS2V4Kzkw?=
 =?utf-8?B?b283RW5wZGN6RlRFSU9ZU05hOWhLQjVNaXF2MGEzdEtzS1lRNkhOYmR3bFRh?=
 =?utf-8?B?a3VrM3o3UW1IMmJpL0dLeVR1Mm1mWERDN1R6bU1OVG5rYlcrdTBCTnFzNEZP?=
 =?utf-8?B?RUIwY1BXTXQxSFJ2TGtwN1dzdEFXYlZ5b05pWFNpRkIwTzRkUWl6eXJjNUlF?=
 =?utf-8?B?cmVnQXRUQjF1cHZ6S3Uxc0lZRW9LV2tnb0plSkllM2xCQWU3U3lQVjViRXhy?=
 =?utf-8?B?dk9IVUZ6QkVidGtmYXQwU1ZzeVEwdkFsVlg4cndJaUliTVFiZDgydWlBcXl3?=
 =?utf-8?B?VGdseklidEdpYm5wVFJkcFlVMnJ2RzN2d1FZb1JYTmhQWkVpalMxZFYvY0h0?=
 =?utf-8?B?Y3BNTkVSd28vR1VCcEx4ejg3Zmo0ek5MaUxNc1lJYUJYT0lkaU9LV1g2d0M0?=
 =?utf-8?B?VkVSTmo4Nk1QY0lPTTZOdjYyeXArZG00TFpSSU05R1ArTFExK0MzelVqZ2VM?=
 =?utf-8?B?U29Sd2xpR01uQVJ2TFlaSGV5Q09Od295R0dNUnhheFJqVW5VNms3UzJnVnVj?=
 =?utf-8?B?WkhlbkJYRjJJb0I5U3dNZkFpdjIzRjdUbnZISXpNT21yZVdud2JubXVNdkVG?=
 =?utf-8?Q?4LYEY6CT6miPp4FyZdJMrW2RP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42597541-d9ad-4d82-ebf1-08dcec2efa48
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:02:49.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fiz9BBZG2yLBfYeTAg9Xr7u2aH7G1kRfxWfgrBG6VgchT48fz6r3R+EmKjfma01m6u9YFqPbmYSBo+OTgCD9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8765

From: Peng Fan <peng.fan@nxp.com>

Back-to-back LPCG writes can be ignored by the LPCG register due to
a HW bug. The writes need to be separated by at least 4 cycles of
the gated clock.

The workaround is implemented as follows:
1. For clocks running greater than or equal to 24MHz, a read
followed by the write will provide sufficient delay.
2. For clocks running below 24MHz, add a delay of 4 clock cylces
after the write to the LPCG register.

Fixes: 2f77296d3df9 ("clk: imx: add lpcg clock support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-lpcg-scu.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index dd5abd09f3e206a5073767561b517d5b3320b28c..2cffec0c42dccc256e8dc5e9181952e250870a76 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -6,6 +6,7 @@
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -41,6 +42,31 @@ struct clk_lpcg_scu {
 
 #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
 
+/* e10858 -LPCG clock gating register synchronization errata */
+static void lpcg_e10858_writel(ulong rate, void __iomem *reg, u32 val)
+{
+	u32 reg1;
+
+	writel(val, reg);
+
+	if (rate >= 24000000 || rate == 0) {
+		/*
+		 * The time taken to access the LPCG registers from the AP core
+		 * through the interconnect is longer than the minimum delay
+		 * of 4 clock cycles required by the errata.
+		 * Adding a readl will provide sufficient delay to prevent
+		 * back-to-back writes.
+		 */
+		reg1 = readl(reg);
+	} else {
+		/*
+		 * For clocks running below 24MHz, wait a minimum of
+		 * 4 clock cycles.
+		 */
+		ndelay(4 * (DIV_ROUND_UP(1000000000, rate)));
+	}
+}
+
 static int clk_lpcg_scu_enable(struct clk_hw *hw)
 {
 	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
@@ -57,7 +83,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
 		val |= CLK_GATE_SCU_LPCG_HW_SEL;
 
 	reg |= val << clk->bit_idx;
-	writel(reg, clk->reg);
+
+	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 
@@ -74,7 +101,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
 
 	reg = readl_relaxed(clk->reg);
 	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
-	writel(reg, clk->reg);
+	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 }
@@ -149,9 +176,8 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
 	 * FIXME: Sometimes writes don't work unless the CPU issues
 	 * them twice
 	 */
-
-	writel(clk->state, clk->reg);
 	writel(clk->state, clk->reg);
+	lpcg_e10858_writel(0, clk->reg, clk->state);
 	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);
 
 	return 0;

-- 
2.37.1


