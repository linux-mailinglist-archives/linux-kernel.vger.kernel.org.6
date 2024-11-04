Return-Path: <linux-kernel+bounces-395127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA79BB8E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538D61F2246C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B2A1C2DDE;
	Mon,  4 Nov 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hdErziA5"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F11C233A;
	Mon,  4 Nov 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733832; cv=fail; b=pYqit41BziwefVgRHo4KXLAn9qCqGByXsyZnP/+ffmjDoX0EiQQM7IB5DH+NLm7TpTHGmuOyhFZ5qsL2luws23AWnw3ItVgUlZ/iSb/O/GWyeQgYuGV6foi08SKVdlnivoJC/FsHjTGYZvKTP1MMOCmnLtXfpepV3irxXa1XRkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733832; c=relaxed/simple;
	bh=X7L54Pf8cad6lIqQ0/IcEl4EHG7vXMrgvLZIE0JjbaY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QtPS3jEwbFayvRIw0YtzhTv4sAw8QcAnpEm6Nc3uRrE7sZmS83Xhm5xk9t2QkdwC3P056ztQ9hgfD4/N+Cqdm1eBzl68m2IXq/zaUgrN9r01KeW3/qHlSdgRT18DaDw2B2xVfvDEExepLg1Opyz196UXIlRyRnyGZ/5iyBYg4x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hdErziA5; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3XNKtVIZBlSa2Z7FnK4ZIpPa3RE+HETADnjalxnMpUJhZbgic3L2Mhn91tBGKh9LJVZRVYWeb9vRw68VpJUsp6sIva3g4Z5Hl3theySUkL47k8EMUFPdehO4pfSMPrOsZbgBPr8EM3VcgEr6WFNTdB+bXKGWHQeEGLRr48uEMoWqbRkW9rwlvalNfuzMxoXMIFrwJag6N3Toh0maumuyV8sE77zmD5QV1hI8I+N2J5pbflGy5Tkkrxyf1ahw1mHEWVDJrfOdybMSHMmu2t9/YXWfnWEx5531nmuLuEJHcNvv7NZY/Z+dT2VTFyxybenZoitwSwqVJvjRIOY+K9lDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT82V0eP8eGr39fOe7L9GiawqkFMhwEIDTz+BK0Y4iE=;
 b=v0HWSkTNX6hop0Ce6n2a/5aYpOhy8RxoIVcA1p2atI6cCvojOpt/NI61HDaRGsBONcaQeJutogGoONpprpWrO5Wuh7ah6GUoCsADynjY2Dwx9p8sanY0YRXw47bhQs0cWpkSA2eRc0y3qPFulHDzFxo9d3J0JbpJ37kmS+cKSrnJIwaCWHHJ+mNBS83RGioR2g4mLGzZupGyu2jlGqN8YsZqStjKl3Mx2RynLNQj2fzX1CYVPhE4s5cienNoXg4KWI81lDjhlh956pzQW+8AHXBOsrbLzd7KXd/1un/jEcKHGyhBiLMOqwz1HVd2r4oNYZTuqFK5feVakwio2Z13UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT82V0eP8eGr39fOe7L9GiawqkFMhwEIDTz+BK0Y4iE=;
 b=hdErziA5xp1e23eirEWEtsDpPiN0apOHsJ50LGC7hG/gMyli5uipi5dAcRfYu13lWhMRAtUzheAYIdRr7AtwrCSIvqSXPXVal6b3ZEdzWgTG5KcaKL0xptC4zklJNoJl72f/G2KLdcV9QwKbLIp/yHL0HFKilrERq2I+BYGkNj9wCWQ01AVeOmwIDFd+24McDdyTGHIUgI9KnGIOkk776It3mtpEX0ac1zAu/NZMBWyGulQF6KMhwBrQPLluVyAuK75kbVTetGmsAiSrmviI6uwQZe1xelG0Fy7WlmrvVywPwm6g7f3vn2m99KUfF6Zn/FfbSM5ky3ga11niMzxyvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 15:23:47 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 15:23:47 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 04 Nov 2024 20:48:42 +0530
Subject: [PATCH v10 5/5] firmware: imx: adds miscdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-imx-se-if-v10-5-bf06083cc97f@nxp.com>
References: <20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com>
In-Reply-To: <20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730733536; l=36791;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=X7L54Pf8cad6lIqQ0/IcEl4EHG7vXMrgvLZIE0JjbaY=;
 b=8Bjt9a+Rao3+rZD51FqKu7K//tu2+8oMpcx8h0VNvJxIRZuOmdUtng8P35wF3OnbP4w+ZczFO
 AGihdXHspBEAhbR+S6OxyHOMHHw4kP2xu6i4le2SPH1ewosdPtJNS8L
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c8b8c6-9084-4ec2-fa70-08dcfce4ad45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzdaWnBlUmlkYUFTK1pYOEhtbzBhYlNTejdtaDhnV2grK3doQ1p5Ykc0dGFr?=
 =?utf-8?B?bkJiWXNyVGNrT2pGSHZNV0JKcUVzZ05MeHFYWkFlNGRndTlBMGp2V3h3UXEx?=
 =?utf-8?B?RmtZWWdpejd5K0x1aCt1STFUQVNkRnJKejF3UlVNZHNJU1dUWnk1WU1lZktx?=
 =?utf-8?B?R0RSaENCSlhWa2phYUFLMzZXRmk4N09haTdHcitmYTN3dUFhQWlnSWhIbUR2?=
 =?utf-8?B?eXpJSWtmd3ZUdGdGRDRxd0MyNzBMVWs2UXhXK2RZaVpqaEk1OCt4QllsT3pq?=
 =?utf-8?B?RGFOS3N5YStxcjRHY0ozSzB6aUlrWUdMU0ErSU8xMjcyN2N3eVZyck11WVpu?=
 =?utf-8?B?WmNmUEt2bkJ2dnErWStMTmkyVlY0NEVlY21MQTVmSDVjZ2VPem5ncUFzQXNj?=
 =?utf-8?B?SWgrVFg1c2NvWVIxY3lsK3VMYTl0MkFiQnBHQS9FWC9PWEI4S1VNLzdYTEFP?=
 =?utf-8?B?NmhGTkRyL3RRV2lGbmNwWC90VzR4WlQ5VDVuQ2dpQlFBSUltM21xb0E2V0lp?=
 =?utf-8?B?U2JCVysxQzFPMWJxNWFzd1VERTlxNjhiNFd6QkNQT29vSThJMVlGNVVkWWZk?=
 =?utf-8?B?UlNjZXV3WGdpd2F2NzhEVFIvbmR1MDNWNUVFOVpsekhaN0FyRk96QzFpNlpI?=
 =?utf-8?B?Ykd2L2VQanIvREI2STNob1FNRUlGNG5ZZy9wRVU0QjVQQTdEWi9iTFJRZGQ0?=
 =?utf-8?B?d09uN2pQQXkwbEFRVUdqVTgxVGIvWlJ3OGlqNitmeFBaUVFGeVBsTksyNlBo?=
 =?utf-8?B?MHVFaExLcjgrRmE4VE4zSG1JQnAwK29vZWZZbTJGam5rSUpxNjQ5NkVkSGhE?=
 =?utf-8?B?T3FTVVdHVStvbDY3ZU1peXY5NW1lZW5Hb0YvdERFOVhmUjE1cXJQSjVGNVRE?=
 =?utf-8?B?SmllckFiUkJldDlVWWpza1duVFp4NGdQQkhDbUUrZWFaQldlUy9FaGViM2pq?=
 =?utf-8?B?NW5GUVpEZjYvK2JZbG1nTHplRXBpcE9SamtMRitudzMwVXUrSGxBMFJBaDYw?=
 =?utf-8?B?NHMzb084K3ZEbkw4aWlDdGRyRlRkbW9nREhVU1E2dzUvM0hESGtwK2JoMWF6?=
 =?utf-8?B?Rmk3YjFZY3lGaXVZb214ci8yMGUzc3BramZPc0NCZmJyVlVSQzNKZCtaQ0Mr?=
 =?utf-8?B?eUx3ZnpPZG9IejFweXFibFkxZ1dSV2lwd2lxMi9WNmlSamhpL1J5VnAxdjlF?=
 =?utf-8?B?YWk2WitwM0dvZ3dGRXBwWTVZZGFZVk04V2ZUSmFJRTJua3VSZEhZajR5TlFx?=
 =?utf-8?B?SmlRMFZLajBtcFNScUdFVk5mVXl1enBaZUpyZ0gwdlpYeFlhNUdWTHlZMzZu?=
 =?utf-8?B?eXZEcmRzRGpocFR3UzkyRDAxQUFtQXdaOHdNbTgvR2wxUFpIL3hmbVJGRmFW?=
 =?utf-8?B?TGRRdE55VXpKcmJ4K0dNRk5JS0ZobGJZbTRNdUc3T3dtZG1zVFRJUGpPcnBk?=
 =?utf-8?B?MlVzMDZnQ2hNSEZyWU02SDRDVTREcko0WVAvRFp4SDJQQ0JLWVBqUTBUNE12?=
 =?utf-8?B?Ym1XeTBXS3lleDlPTHNrTWlVcDBTQm9peERjQ3BOcUxMU2pFZGpaZVZUMnVO?=
 =?utf-8?B?OWtNQytIMWx1WVh5SjZyRFFSUkRwenhWMTRVdDNKZGVmNlRQR0NzRG5ELys5?=
 =?utf-8?B?RGRGQVJONThpVnZhMlFzRk5kaURnUDJMSDRKRFZzamxBdTNpZ3JIampNOExC?=
 =?utf-8?B?WFpTVHNuVWovQlFmVlhiaWhuUmtwUUQvU011ckg4V2ttZkZkdWNaQlMwWlVi?=
 =?utf-8?Q?X736PkqacLRL/H7eqMSW/3hw+VCIgbfUyc8X67A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJyUzN6bGVjTWZuUWh4VjFkSEl0bzdZSFh6MFhyQmZDMDZ1L2dwZERqZERM?=
 =?utf-8?B?b3I1SVJReEpWTVh6N2dRS3JVUlcvMzNUcnNTdkRCQ0dMV3JENGlCSEVxR1lt?=
 =?utf-8?B?K3pCUS9lcXFaM3dCQklqRTBkb0xaM2hKVllKdmlxamhSN1owNTRKMEN6ditG?=
 =?utf-8?B?TENmQ0NEUUxmR3p4bXFpSTZKZWlqVXNkVzB4RDV2dUY2dHJtTHVpT2Rudk9y?=
 =?utf-8?B?QW45aTc4bCtCenJpWUtLTDZMcGNkY3paZEpFS084czM0SXFpN0xwLzN0QTlp?=
 =?utf-8?B?bFA3Q0lMTm82SWJPTk9uVHJXOFM4ekE0azEvblBURXZNVE1CTUs0UFlqc1po?=
 =?utf-8?B?YWxQcFdtS3QvTTRuYXo0N2pxK21lL002MnA0emwvZFpHVDRxdWNyYWlNMWZa?=
 =?utf-8?B?cGRSV0ZLNjY0YUJqL0pEeWRickhBcVl0cSthYnh0WitvZDlpVHdUdThxcUt2?=
 =?utf-8?B?eEYvQjg1M0NnVmpUOXhaaDcweTJwWnpvK0JEM2QxbFNXNThPdUVhVThlRUlq?=
 =?utf-8?B?QU1JK1lWSWVONmtpZzgyNmJ6Q093S1hlQnJGQ3hYd3l0a2g2L3lmS0U3OTI5?=
 =?utf-8?B?aVdySEVCbVJock9ucEwzcC9STmpiWW1DM2dDdDIycXR4Q2pDenJwMzdsbHY4?=
 =?utf-8?B?TWFWcllDQUxHRDcvWk01RG1wQTA4cGMwYkhZcnNWbEhtODduNkU5MVVVcHlP?=
 =?utf-8?B?WWVhWVRIYTBydWN0amVVcDNZQUtOYXlWS1lZT3ZpbmwrYnYvT3hHMTJpaW5v?=
 =?utf-8?B?TzFYb1N0MlRHYWJEM0R3OW54bW52aGJFaFZKekx3UWJTbDk2M2ZXUkdQSkMx?=
 =?utf-8?B?UDVid1NveCtkZ3ZHN2lIZ1FsTitmRDRTY0JkWEltWXNOSkdTMDJCMWJiaysr?=
 =?utf-8?B?WFVldG01NG1aOWF5c0NxSXU4dmlhK1Z5eEx4SmJ0UDJWbUhDM2ZSbEFnN3ZW?=
 =?utf-8?B?aUpiWVhmVG5uYld2TTc2bXJiTTlLQlFuRUIyaW44L0xsZEV0bGRiT0MvWmdK?=
 =?utf-8?B?djJYbVJuQ0pTRE80VS9aQzZ1MkdUbER6UlZ3MnEyZEpBVU5uUzhtUHZtU3lZ?=
 =?utf-8?B?SHRPOUdvWFJrcDUxdVdubFVqeXJpVDF3dC9iK2owNWExaUx5YkZmWkgrNnFV?=
 =?utf-8?B?bnZpUUxZSTFKYS9IVmo4WWF4Nk9sKzNyVzhHVmlmNEVqYk9OR1JQaGxzempY?=
 =?utf-8?B?b1BLRndwaHVxMDVuNUlkYWtJMS9oNXdtLzFPd1V4RStIMUxlVCtTalBIbnEr?=
 =?utf-8?B?NzFxbFFtRE9ZOG4xMTNSMnZCYnkwZzBGWGxWVkt0bnVTNFplNGxWUC9rVHhH?=
 =?utf-8?B?MjQxbFo2SzNFanBaQzA1bVlkaVQrd2FLeGNJRWdJTzJjWElIa3BWeDdDZnBC?=
 =?utf-8?B?TUdaUXoycTBMMElIMkIxeTc4Vk83TTF5TUs1RWszVEw5QkN2MjhKdCtJT292?=
 =?utf-8?B?ckZhbmo5Vk1jSS9BSmxLOXlndlZDSlJlWVF1VkV0em9QYXJyYUxBY2M5Y3dP?=
 =?utf-8?B?d1JJYnZYZElwaU9aSDVaQlZrenNTR3BIU3FMZVdJeDBGcE5uVXhBOXIxd3RX?=
 =?utf-8?B?NXdGVXhBclNHNjljMTd6WUtXVzBmcFJxUWhzNkkwSWltU2dmSHlnT2ZoM3hO?=
 =?utf-8?B?amJzUWl2SWlyR0FidFhpZ0dROFFHK0ZUQy9WVi9IcWFlYWhuRGZxL2U4N0Vs?=
 =?utf-8?B?NWlzblNQTk1uWEFDSkZLU1FDaUY3UTlIcnBFaDlZOVhTM211WWxwUk9XRDdT?=
 =?utf-8?B?TFNlUjdSRkhseUhDVHIrRkZCZjRuejBlallTR0lVSTlhcDFlN2ZGL0FzUU1E?=
 =?utf-8?B?QnJZSXpEa1laMWJLVythbHF5ODVabWsrdHgzeEdHK1B5aXVVUzMzVkdMYk1X?=
 =?utf-8?B?V0dUTGJVRUh5YlFnUDRSSFN6ZVZPbUN6R0M2ZTIvWHhHSUlRTGdZNWpFenpM?=
 =?utf-8?B?ZjFYeTRMNi9oVUY1akhTTm9jQ1czN3JLSVlCUjZaZWNtODFJZTFvOTVVam9S?=
 =?utf-8?B?K1Z4MUhINWpDUWlrMWp0bUNxOEFYY00yMEpPU1NKdnYzUFhXTEU2YmxGenlI?=
 =?utf-8?B?MHNaUTg2Ulo3azkyNWRqVEV2QVVhWW0rTkJkRG93ZVBvUWs5ejJjdXBzV3RP?=
 =?utf-8?Q?vawkSmK1YW28Sw/ATU/0zA9da?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c8b8c6-9084-4ec2-fa70-08dcfce4ad45
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 15:23:47.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gj8tGQqsFXa5CKYlgKrROFenPb3aV4iLx1RY+26ZzldSpu2J2qMnxueGlwwK2IPXlqLYW4lpayM0Y3iMbUgVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451

Adds the driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like
EdgeLock Enclave from:
- User-Space Applications via character driver.

ABI documentation for the NXP secure-enclave driver.

User-space library using this driver:
- i.MX Secure Enclave library:
  -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
- i.MX Secure Middle-Ware:
  -- URL: https://github.com/nxp-imx/imx-smw.git

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 Documentation/ABI/testing/se-cdev   |  43 ++
 drivers/firmware/imx/ele_base_msg.c |   8 +-
 drivers/firmware/imx/ele_common.c   |  39 +-
 drivers/firmware/imx/ele_common.h   |   6 +-
 drivers/firmware/imx/se_ctrl.c      | 779 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  42 +-
 include/uapi/linux/se_ioctl.h       |  96 +++++
 7 files changed, 992 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
new file mode 100644
index 000000000000..3451c909ccc4
--- /dev/null
+++ b/Documentation/ABI/testing/se-cdev
@@ -0,0 +1,43 @@
+What:		/dev/<se>_mu[0-9]+_ch[0-9]+
+Date:		May 2024
+KernelVersion:	6.8
+Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
+Description:
+		NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
+		Enclave(ELE), SECO. The character device file descriptors
+		/dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
+		enclave shared library and the kernel driver.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include]<linux/firmware/imx/ele_mu_ioctl.h>.
+		ioctl(s) are used primarily for:
+			- shared memory management
+			- allocation of I/O buffers
+			- getting mu info
+			- setting a dev-ctx as receiver to receive all the commands from FW
+			- getting SoC info
+			- send command and receive command response
+
+		The following file operations are supported:
+
+		open(2)
+		  Currently the only useful flags are O_RDWR.
+
+		read(2)
+		  Every read() from the opened character device context is waiting on
+		  wait_event_interruptible, that gets set by the registered mailbox callback
+		  function, indicating a message received from the firmware on message-
+		  unit.
+
+		write(2)
+		  Every write() to the opened character device context needs to acquire
+		  mailbox_lock before sending message on to the message unit.
+
+		close(2)
+		  Stops and frees up the I/O contexts that were associated
+		  with the file descriptor.
+
+Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
+		https://github.com/nxp-imx/imx-smw.git
+		crypto/skcipher,
+		drivers/nvmem/imx-ocotp-ele.c
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index 53c83eddd52a..329badcc3d14 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -67,7 +67,7 @@ int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
 	tx_msg->data[0] = upper_32_bits(get_info_addr);
 	tx_msg->data[1] = lower_32_bits(get_info_addr);
 	tx_msg->data[2] = sizeof(*s_info);
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_GET_INFO_REQ_MSG_SZ,
 			       rx_msg,
@@ -145,7 +145,7 @@ int ele_ping(struct se_if_priv *priv)
 		goto exit;
 	}
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_PING_REQ_SZ,
 			       rx_msg,
@@ -200,7 +200,7 @@ int ele_service_swap(struct se_if_priv *priv,
 	tx_msg->data[3] = lower_32_bits(addr);
 	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
 						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
 			       rx_msg,
@@ -261,7 +261,7 @@ int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
 	tx_msg->data[0] = lower_32_bits(addr);
 	tx_msg->data[2] = addr;
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_FW_AUTH_REQ_SZ,
 			       rx_msg,
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index f7c760bbc7a3..97f34e4e5d2c 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -18,9 +18,10 @@ u32 se_add_msg_crc(u32 *msg, u32 msg_len)
 	return crc;
 }
 
-int ele_msg_rcv(struct se_if_priv *priv,
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
 		struct se_clbk_handle *se_clbk_hdl)
 {
+	struct se_if_priv *priv = dev_ctx->priv;
 	int err = 0;
 
 	do {
@@ -31,12 +32,13 @@ int ele_msg_rcv(struct se_if_priv *priv,
 		 */
 		err = wait_for_completion_interruptible(&se_clbk_hdl->done);
 		if (err == -ERESTARTSYS) {
-			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
+			if (priv->waiting_rsp_clbk_hdl.dev_ctx) {
 				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
 				continue;
 			}
 			dev_err(priv->dev,
-				"Err[0x%x]:Interrupted by signal.\n",
+				"%s: Err[0x%x]:Interrupted by signal.\n",
+				se_clbk_hdl->dev_ctx->devname,
 				err);
 			err = -EINTR;
 			break;
@@ -46,10 +48,11 @@ int ele_msg_rcv(struct se_if_priv *priv,
 	return err ? err : se_clbk_hdl->rx_msg_sz;
 }
 
-int ele_msg_send(struct se_if_priv *priv,
+int ele_msg_send(struct se_if_device_ctx *dev_ctx,
 		 void *tx_msg,
 		 int tx_msg_sz)
 {
+	struct se_if_priv *priv = dev_ctx->priv;
 	struct se_msg_hdr *header;
 	int err;
 
@@ -62,7 +65,8 @@ int ele_msg_send(struct se_if_priv *priv,
 	if (header->size << 2 != tx_msg_sz) {
 		err = -EINVAL;
 		dev_err(priv->dev,
-			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			"%s: User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			dev_ctx->devname,
 			*(u32 *)header,
 			header->size << 2, tx_msg_sz);
 		goto exit;
@@ -70,7 +74,9 @@ int ele_msg_send(struct se_if_priv *priv,
 
 	err = mbox_send_message(priv->tx_chan, tx_msg);
 	if (err < 0) {
-		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		dev_err(priv->dev,
+			"%s: Error: mbox_send_message failure.",
+			dev_ctx->devname);
 		return err;
 	}
 	err = tx_msg_sz;
@@ -80,29 +86,32 @@ int ele_msg_send(struct se_if_priv *priv,
 }
 
 /* API used for send/receive blocking call. */
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
 		     int exp_rx_msg_sz)
 {
 	int err;
+	struct se_if_priv *priv = dev_ctx->priv;
 
 	guard(mutex)(&priv->se_if_cmd_lock);
 
+	priv->waiting_rsp_clbk_hdl.dev_ctx = dev_ctx;
 	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
 	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
 
-	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	err = ele_msg_send(dev_ctx, tx_msg, tx_msg_sz);
 	if (err < 0)
 		goto exit;
 
-	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+	err = ele_msg_rcv(dev_ctx, &priv->waiting_rsp_clbk_hdl);
 
 	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
 		err = -EINTR;
 		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
 	}
+	priv->waiting_rsp_clbk_hdl.dev_ctx = NULL;
 
 exit:
 	return err;
@@ -149,7 +158,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	if (header->tag == priv->if_defs->cmd_tag) {
 		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
 		dev_dbg(dev,
-			"Selecting cmd receiver for mesg header:0x%x.",
+			"Selecting cmd receiver:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname,
 			*(u32 *) header);
 
 		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
@@ -158,7 +168,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 		 */
 		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
 			dev_err(dev,
-				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				"%s: CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname,
 				*(u32 *) header,
 				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
@@ -169,13 +180,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	} else if (header->tag == priv->if_defs->rsp_tag) {
 		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
 		dev_dbg(dev,
-			"Selecting resp waiter for mesg header:0x%x.",
+			"Selecting resp waiter:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname,
 			*(u32 *) header);
 
 		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz
 				&& !exception_for_size(priv, header)) {
 			dev_err(dev,
-				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				"%s: Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname,
 				*(u32 *) header,
 				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 3d8b6f83fb9d..9bded800c103 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -14,12 +14,12 @@
 #define IMX_ELE_FW_DIR                 "imx/ele/"
 
 uint32_t se_add_msg_crc(uint32_t *msg, uint32_t msg_len);
-int ele_msg_rcv(struct se_if_priv *priv,
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
 		struct se_clbk_handle *se_clbk_hdl);
-int ele_msg_send(struct se_if_priv *priv,
+int ele_msg_send(struct se_if_device_ctx *dev_ctx,
 		 void *tx_msg,
 		 int tx_msg_sz);
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index 40d815d0ac9b..f41c6441eac1 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sys_soc.h>
+#include <uapi/linux/se_ioctl.h>
 
 #include "ele_base_msg.h"
 #include "ele_common.h"
@@ -313,6 +314,762 @@ static int se_load_firmware(struct se_if_priv *priv)
 	return ret;
 }
 
+static int init_se_shared_mem(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_out);
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_in);
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	se_shared_mem_mgmt->non_secure_mem.ptr
+			= dma_alloc_coherent(priv->dev,
+					     MAX_DATA_SIZE_PER_USER,
+					     &se_shared_mem_mgmt->non_secure_mem.dma_addr,
+					     GFP_KERNEL);
+	if (!se_shared_mem_mgmt->non_secure_mem.ptr)
+		return -ENOMEM;
+
+	se_shared_mem_mgmt->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+
+	return 0;
+}
+
+static void cleanup_se_shared_mem(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	/* Unmap secure memory shared buffer. */
+	if (se_shared_mem_mgmt->secure_mem.ptr)
+		devm_iounmap(priv->dev,
+				(void __iomem *)se_shared_mem_mgmt->secure_mem.ptr);
+
+	se_shared_mem_mgmt->secure_mem.ptr = NULL;
+	se_shared_mem_mgmt->secure_mem.dma_addr = 0;
+	se_shared_mem_mgmt->secure_mem.size = 0;
+	se_shared_mem_mgmt->secure_mem.pos = 0;
+
+	/* Free non-secure shared buffer. */
+	dma_free_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
+			  se_shared_mem_mgmt->non_secure_mem.ptr,
+			  se_shared_mem_mgmt->non_secure_mem.dma_addr);
+
+	se_shared_mem_mgmt->non_secure_mem.ptr = NULL;
+	se_shared_mem_mgmt->non_secure_mem.dma_addr = 0;
+	se_shared_mem_mgmt->non_secure_mem.size = 0;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+/* Need to copy the output data to user-device context.
+ */
+static int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_buf_desc *b_desc, *temp;
+	bool do_cpy = true;
+
+	list_for_each_entry_safe(b_desc, temp, &se_shared_mem_mgmt->pending_out, link) {
+		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr && do_cpy) {
+
+			dev_dbg(priv->dev,
+				"Copying output data to user.");
+			if (do_cpy && copy_to_user(b_desc->usr_buf_ptr,
+					 b_desc->shared_buf_ptr,
+					 b_desc->size)) {
+				dev_err(priv->dev,
+					"Failure copying output data to user.");
+				do_cpy = false;
+			}
+		}
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		list_del(&b_desc->link);
+		kfree(b_desc);
+	}
+
+	return do_cpy ? 0 : -EFAULT;
+}
+
+/*
+ * Clean the used Shared Memory space,
+ * whether its Input Data copied from user buffers, or
+ * Data received from FW.
+ */
+static void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct list_head *pending_lists[] = {&se_shared_mem_mgmt->pending_in,
+						&se_shared_mem_mgmt->pending_out};
+	struct se_buf_desc *b_desc, *temp;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		list_for_each_entry_safe(b_desc, temp,
+					 pending_lists[i], link) {
+
+			if (b_desc->shared_buf_ptr)
+				memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+			list_del(&b_desc->link);
+			kfree(b_desc);
+		}
+	}
+	se_shared_mem_mgmt->secure_mem.pos = 0;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+static int add_b_desc_to_pending_list(void *shared_ptr_with_pos,
+			       struct se_ioctl_setup_iobuf *io,
+			       struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_buf_desc *b_desc = NULL;
+
+	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
+	if (!b_desc)
+		return -ENOMEM;
+
+	b_desc->shared_buf_ptr = shared_ptr_with_pos;
+	b_desc->usr_buf_ptr = io->user_buf;
+	b_desc->size = io->length;
+
+	if (io->flags & SE_IO_BUF_FLAGS_IS_INPUT) {
+		/*
+		 * buffer is input:
+		 * add an entry in the "pending input buffers" list so
+		 * that copied data can be cleaned from shared memory
+		 * later.
+		 */
+		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_in);
+	} else {
+		/*
+		 * buffer is output:
+		 * add an entry in the "pending out buffers" list so data
+		 * can be copied to user space when receiving Secure-Enclave
+		 * response.
+		 */
+		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_out);
+	}
+
+	return 0;
+}
+
+/* interface for managed res to unregister a character device */
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
+static int init_device_context(struct se_if_priv *priv, int ch_id,
+			struct se_if_device_ctx **new_dev_ctx,
+			const struct file_operations *se_if_fops)
+{
+	const struct se_if_node_info *info = container_of(priv->if_defs,
+							typeof(*info),
+							if_defs);
+	struct se_if_device_ctx *dev_ctx;
+	int ret = 0;
+
+	if (ch_id)
+		dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
+	else
+		dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
+
+	if (!dev_ctx) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	dev_ctx->priv = priv;
+
+	if (ch_id)
+		dev_ctx->devname = kasprintf(GFP_KERNEL, "%s_ch%d",
+					     info->se_name, ch_id);
+	else
+		dev_ctx->devname = devm_kasprintf(priv->dev,
+						  GFP_KERNEL, "%s_ch%d",
+						  info->se_name, ch_id);
+	if (!dev_ctx->devname) {
+		ret = -ENOMEM;
+		if (ch_id)
+			kfree(dev_ctx);
+
+		return ret;
+	}
+
+	mutex_init(&dev_ctx->fops_lock);
+
+	*new_dev_ctx = dev_ctx;
+
+	if (ch_id) {
+		list_add_tail(&dev_ctx->link, &priv->dev_ctx_list);
+		priv->active_devctx_count++;
+
+		ret = init_se_shared_mem(dev_ctx);
+		if (ret < 0) {
+			kfree(dev_ctx->devname);
+			kfree(dev_ctx);
+			*new_dev_ctx = NULL;
+			return ret;
+		}
+
+		return ret;
+	}
+
+	/* Only for ch_id = 0:
+	 * - register the misc device.
+	 * - add action
+	 */
+	dev_ctx->miscdev = devm_kzalloc(priv->dev, sizeof(*dev_ctx->miscdev), GFP_KERNEL);
+	if (!dev_ctx->miscdev) {
+		ret = -ENOMEM;
+		*new_dev_ctx = NULL;
+		return ret;
+	}
+
+	dev_ctx->miscdev->name = dev_ctx->devname;
+	dev_ctx->miscdev->minor = MISC_DYNAMIC_MINOR;
+	dev_ctx->miscdev->fops = se_if_fops;
+	dev_ctx->miscdev->parent = priv->dev;
+	ret = misc_register(dev_ctx->miscdev);
+	if (ret) {
+		dev_err(priv->dev, "failed to register misc device %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = devm_add_action(priv->dev, if_misc_deregister,
+			      dev_ctx->miscdev);
+	if (ret) {
+		dev_err(priv->dev,
+			"failed[%d] to add action to the misc-dev\n",
+			ret);
+		misc_deregister(dev_ctx->miscdev);
+	}
+
+	return ret;
+}
+
+static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	const struct se_if_node_info *info = container_of(dev_ctx->priv->if_defs,
+							typeof(*info),
+							if_defs);
+	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
+	struct se_if_node_info_list *info_list
+				= container_of(info,
+						typeof(*info_list),
+						info[info->se_if_id]);
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int err = 0;
+
+	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 __user *)arg,
+			   sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%d < %d)\n",
+			dev_ctx->devname,
+			cmd_snd_rcv_rsp_info.tx_buf_sz,
+			SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
+	if (!rx_msg) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
+			     cmd_snd_rcv_rsp_info.tx_buf_sz);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	if (tx_msg->header.tag != priv->if_defs->cmd_tag) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (tx_msg->header.ver == priv->if_defs->fw_api_ver &&
+		!info_list->load_hsm_fw.is_fw_loaded) {
+		err = se_load_firmware(priv);
+		if (err) {
+			dev_err(priv->dev, "Could not send the message as FW is not loaded.");
+			err = -EPERM;
+			goto exit;
+		}
+	}
+	err = ele_msg_send_rcv(dev_ctx,
+			       tx_msg,
+			       cmd_snd_rcv_rsp_info.tx_buf_sz,
+			       rx_msg,
+			       cmd_snd_rcv_rsp_info.rx_buf_sz);
+	if (err < 0)
+		goto exit;
+
+	dev_dbg(priv->dev,
+		"%s: %s %s\n",
+		dev_ctx->devname,
+		__func__,
+		"message received, start transmit to user");
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(dev_ctx);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     rx_msg,
+			     cmd_snd_rcv_rsp_info.rx_buf_sz, false);
+
+	if (copy_to_user(cmd_snd_rcv_rsp_info.rx_buf, rx_msg,
+			 cmd_snd_rcv_rsp_info.rx_buf_sz)) {
+		dev_err(priv->dev,
+			"%s: Failed to copy to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+exit:
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+	if (copy_to_user((void __user *)arg, &cmd_snd_rcv_rsp_info,
+			 sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
+				u64 arg)
+{
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_if_node_info *info;
+	struct se_ioctl_get_if_info if_info;
+	int err = 0;
+
+	info = container_of(priv->if_defs, typeof(*info), if_defs);
+
+	if_info.se_if_id = info->se_if_id;
+	if_info.interrupt_idx = 0;
+	if_info.tz = 0;
+	if_info.did = info->se_if_did;
+	if_info.cmd_tag = priv->if_defs->cmd_tag;
+	if_info.rsp_tag = priv->if_defs->rsp_tag;
+	if_info.success_tag = priv->if_defs->success_tag;
+	if_info.base_api_ver = priv->if_defs->base_api_ver;
+	if_info.fw_api_ver = priv->if_defs->fw_api_ver;
+
+	dev_dbg(priv->dev,
+		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
+			dev_ctx->devname,
+			if_info.se_if_id, if_info.interrupt_idx,
+			if_info.tz, if_info.did);
+
+	if (copy_to_user((u8 __user *)arg, &if_info, sizeof(if_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy mu info to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/*
+ * Copy a buffer of data to/from the user and return the address to use in
+ * messages
+ */
+static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_shared_mem *shared_mem = NULL;
+	struct se_ioctl_setup_iobuf io = {0};
+	int err = 0;
+	u32 pos;
+
+	if (copy_from_user(&io, (u8 __user *)arg, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed copy iobuf config from user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	dev_dbg(dev_ctx->priv->dev,
+		"%s: io [buf: %p(%d) flag: %x]\n",
+		dev_ctx->devname,
+		io.user_buf, io.length, io.flags);
+
+	if (io.length == 0 || !io.user_buf) {
+		/*
+		 * Accept NULL pointers since some buffers are optional
+		 * in FW commands. In this case we should return 0 as
+		 * pointer to be embedded into the message.
+		 * Skip all data copy part of code below.
+		 */
+		io.ele_addr = 0;
+		goto copy;
+	}
+
+	/* No specific requirement for this buffer. */
+	shared_mem = &dev_ctx->se_shared_mem_mgmt.non_secure_mem;
+
+	/* Check there is enough space in the shared memory. */
+	if (shared_mem->size < shared_mem->pos ||
+		round_up(io.length, 8u) >= (shared_mem->size - shared_mem->pos)) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Not enough space in shared memory\n",
+			dev_ctx->devname);
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* Allocate space in shared memory. 8 bytes aligned. */
+	pos = shared_mem->pos;
+	shared_mem->pos += round_up(io.length, 8u);
+	io.ele_addr = (u64)shared_mem->dma_addr + pos;
+
+	memset(shared_mem->ptr + pos, 0, io.length);
+	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
+	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
+		/*
+		 * buffer is input:
+		 * copy data from user space to this allocated buffer.
+		 */
+		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
+				   io.length)) {
+			dev_err(dev_ctx->priv->dev,
+				"%s: Failed copy data to shared memory\n",
+				dev_ctx->devname);
+			err = -EFAULT;
+			goto exit;
+		}
+	}
+
+	err = add_b_desc_to_pending_list(shared_mem->ptr + pos,
+					 &io,
+					 dev_ctx);
+	if (err < 0)
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to allocate/link b_desc.",
+			dev_ctx->devname);
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	if (copy_to_user((u8 __user *)arg, &io, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy iobuff setup to user.",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+exit:
+	return err;
+}
+
+/* IOCTL to provide SoC information */
+static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
+					     u64 arg)
+{
+	const struct se_if_node_info_list *info_list;
+	struct se_ioctl_get_soc_info soc_info;
+	int err = -EINVAL;
+
+	info_list = device_get_match_data(dev_ctx->priv->dev);
+	if (!info_list)
+		goto exit;
+
+	soc_info.soc_id = info_list->soc_id;
+	soc_info.soc_rev = se_soc_rev;
+
+	err = (int)copy_to_user((u8 __user *)arg, (u8 *)(&soc_info), sizeof(soc_info));
+	if (err) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy soc info to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/*
+ * File operations for user-space
+ */
+
+/* Write a message to the MU. */
+static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
+				size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev,
+		"%s: write from buf (%p)%zu, ppos=%lld\n",
+		dev_ctx->devname,
+		buf, size, ((ppos) ? *ppos : 0));
+
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (size < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%zu < %d)\n",
+			dev_ctx->devname,
+			size, SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(buf, size);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     tx_msg, size, false);
+
+	err = ele_msg_send(dev_ctx, tx_msg, size);
+	if (err < 0)
+		goto exit;
+exit:
+	mutex_unlock(&dev_ctx->fops_lock);
+	return err;
+}
+
+/*
+ * Read a message from the MU.
+ * Blocking until a message is available.
+ */
+static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
+			       size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev,
+		"%s: read to buf %p(%zu), ppos=%lld\n",
+		dev_ctx->devname,
+		buf, size, ((ppos) ? *ppos : 0));
+
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = ele_msg_rcv(dev_ctx, &priv->cmd_receiver_clbk_hdl);
+	if (err < 0) {
+		dev_err(priv->dev,
+			"%s: Err[0x%x]:Interrupted by signal.\n",
+			dev_ctx->devname, err);
+		dev_dbg(priv->dev,
+			"Current active dev-ctx count = %d.\n",
+			dev_ctx->priv->active_devctx_count);
+		goto exit;
+	}
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(dev_ctx);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     priv->cmd_receiver_clbk_hdl.rx_msg,
+			     priv->cmd_receiver_clbk_hdl.rx_msg_sz,
+			     false);
+
+	if (copy_to_user(buf, priv->cmd_receiver_clbk_hdl.rx_msg,
+			 priv->cmd_receiver_clbk_hdl.rx_msg_sz)) {
+		dev_err(priv->dev,
+			"%s: Failed to copy to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+	err = priv->cmd_receiver_clbk_hdl.rx_msg_sz;
+exit:
+	priv->cmd_receiver_clbk_hdl.rx_msg_sz = 0;
+
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+	mutex_unlock(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Open a character device. */
+static int se_if_fops_open(struct inode *nd, struct file *fp)
+{
+	struct miscdevice *miscdev = fp->private_data;
+	struct se_if_priv *priv = dev_get_drvdata(miscdev->parent);
+	struct se_if_device_ctx *misc_dev_ctx = priv->priv_dev_ctx;
+	struct se_if_device_ctx *dev_ctx;
+	int err = 0;
+
+	if (mutex_lock_interruptible(&misc_dev_ctx->fops_lock))
+		return -EBUSY;
+
+	priv->dev_ctx_mono_count++;
+	err = init_device_context(priv,
+				  priv->dev_ctx_mono_count ?
+					priv->dev_ctx_mono_count
+					: priv->dev_ctx_mono_count++,
+				  &dev_ctx, NULL);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed[0x%x] to create device contexts.\n",
+			err);
+		goto exit;
+	}
+
+	fp->private_data = dev_ctx;
+
+exit:
+	mutex_unlock(&misc_dev_ctx->fops_lock);
+	return err;
+}
+
+/* Close a character device. */
+static int se_if_fops_close(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* check if this device was registered as command receiver. */
+	if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {
+		priv->cmd_receiver_clbk_hdl.dev_ctx = NULL;
+		kfree(priv->cmd_receiver_clbk_hdl.rx_msg);
+		priv->cmd_receiver_clbk_hdl.rx_msg = NULL;
+	}
+
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+	cleanup_se_shared_mem(dev_ctx);
+
+	priv->active_devctx_count--;
+	list_del(&dev_ctx->link);
+
+	mutex_unlock(&dev_ctx->fops_lock);
+	kfree(dev_ctx->devname);
+	kfree(dev_ctx);
+
+	return 0;
+}
+
+/* IOCTL entry point of a character device */
+static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	/* Prevent race during change of device context */
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	switch (cmd) {
+	case SE_IOCTL_ENABLE_CMD_RCV:
+		if (!priv->cmd_receiver_clbk_hdl.dev_ctx) {
+			if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+				priv->cmd_receiver_clbk_hdl.rx_msg
+					= kzalloc(MAX_NVM_MSG_LEN,
+						  GFP_KERNEL);
+				if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+					err = -ENOMEM;
+					break;
+				}
+			}
+			priv->cmd_receiver_clbk_hdl.rx_msg_sz = MAX_NVM_MSG_LEN;
+			priv->cmd_receiver_clbk_hdl.dev_ctx = dev_ctx;
+			err = 0;
+		} else {
+			err = -EBUSY;
+		}
+		break;
+	case SE_IOCTL_GET_MU_INFO:
+		err = se_ioctl_get_mu_info(dev_ctx, arg);
+		break;
+	case SE_IOCTL_SETUP_IOBUF:
+		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_GET_SOC_INFO:
+		err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_CMD_SEND_RCV_RSP:
+		err = se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
+		break;
+	default:
+		err = -EINVAL;
+		dev_dbg(priv->dev,
+			"%s: IOCTL %.8x not supported\n",
+			dev_ctx->devname,
+			cmd);
+	}
+
+	mutex_unlock(&dev_ctx->fops_lock);
+
+	return (long)err;
+}
+
+/* Char driver setup */
+static const struct file_operations se_if_fops = {
+	.open		= se_if_fops_open,
+	.owner		= THIS_MODULE,
+	.release	= se_if_fops_close,
+	.unlocked_ioctl = se_ioctl,
+	.read		= se_if_fops_read,
+	.write		= se_if_fops_write,
+};
+
 /* interface for managed res to free a mailbox channel */
 static void if_mbox_free_channel(void *mbox_chan)
 {
@@ -348,6 +1105,7 @@ static int se_if_request_channel(struct device *dev,
 
 static void se_if_probe_cleanup(void *plat_dev)
 {
+	struct se_if_device_ctx *dev_ctx, *t_dev_ctx;
 	struct platform_device *pdev = plat_dev;
 	struct device *dev = &pdev->dev;
 	struct se_fw_load_info *load_fw;
@@ -372,6 +1130,18 @@ static void se_if_probe_cleanup(void *plat_dev)
 		load_fw->imem.buf = NULL;
 	}
 
+	if (priv->dev_ctx_mono_count) {
+		list_for_each_entry_safe(dev_ctx, t_dev_ctx, &priv->dev_ctx_list, link) {
+			list_del(&dev_ctx->link);
+			priv->active_devctx_count--;
+		}
+	}
+
+	if (priv->priv_dev_ctx && priv->priv_dev_ctx->miscdev) {
+		devm_remove_action(dev, if_misc_deregister, &priv->priv_dev_ctx->miscdev);
+		misc_deregister(priv->priv_dev_ctx->miscdev);
+	}
+
 	/* No need to check, if reserved memory is allocated
 	 * before calling for its release. Or clearing the
 	 * un-set bit.
@@ -456,6 +1226,7 @@ static int se_if_probe(struct platform_device *pdev)
 			goto exit;
 		}
 	}
+	INIT_LIST_HEAD(&priv->dev_ctx_list);
 
 	if (info->reserved_dma_ranges) {
 		ret = of_reserved_mem_device_init(dev);
@@ -467,6 +1238,14 @@ static int se_if_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = init_device_context(priv, 0, &priv->priv_dev_ctx, &se_if_fops);
+	if (ret) {
+		dev_err(dev,
+			"Failed[0x%x] to create device contexts.\n",
+			ret);
+		goto exit;
+	}
+
 	ret = se_soc_info(priv);
 	if (ret) {
 		dev_err(dev,
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index de0d4a1bcb9e..a7f740e83a7c 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -13,6 +13,7 @@
 #define MAX_FW_LOAD_RETRIES		50
 
 #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
 #define MAX_NVM_MSG_LEN			(256)
 #define MESSAGING_VERSION_6		0x6
 #define MESSAGING_VERSION_7		0x7
@@ -31,7 +32,7 @@
 struct se_clbk_handle {
 	struct completion done;
 	bool signal_rcvd;
-	atomic_t pending_hdr;
+	struct se_if_device_ctx *dev_ctx;
 	u32 rx_msg_sz;
 	/* Assignment of the rx_msg buffer to held till the
 	 * received content as part callback function, is copied.
@@ -46,6 +47,40 @@ struct se_imem_buf {
 	u32 state;
 };
 
+struct se_buf_desc {
+	u8 *shared_buf_ptr;
+	void __user *usr_buf_ptr;
+	u32 size;
+	struct list_head link;
+};
+
+struct se_shared_mem {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 pos;
+	u8 *ptr;
+};
+
+struct se_shared_mem_mgmt_info {
+	struct list_head pending_in;
+	struct list_head pending_out;
+
+	struct se_shared_mem secure_mem;
+	struct se_shared_mem non_secure_mem;
+};
+
+/* Private struct for each char device instance. */
+struct se_if_device_ctx {
+	struct se_if_priv *priv;
+	struct miscdevice *miscdev;
+	const char *devname;
+
+	struct mutex fops_lock;
+
+	struct se_shared_mem_mgmt_info se_shared_mem_mgmt;
+	struct list_head link;
+};
+
 /* Header of the messages exchange with the EdgeLock Enclave */
 struct se_msg_hdr {
 	u8 ver;
@@ -89,6 +124,11 @@ struct se_if_priv {
 
 	struct gen_pool *mem_pool;
 	const struct se_if_defines *if_defs;
+
+	struct se_if_device_ctx *priv_dev_ctx;
+	struct list_head dev_ctx_list;
+	u32 active_devctx_count;
+	u32 dev_ctx_mono_count;
 };
 
 #endif
diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
new file mode 100644
index 000000000000..939c461210f3
--- /dev/null
+++ b/include/uapi/linux/se_ioctl.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef SE_IOCTL_H
+#define SE_IOCTL_H
+
+#include <linux/types.h>
+
+/* IOCTL definitions. */
+
+struct se_ioctl_setup_iobuf {
+	void __user *user_buf;
+	__u32 length;
+	__u32 flags;
+	__u64 ele_addr;
+};
+
+struct se_ioctl_shared_mem_cfg {
+	__u32 base_offset;
+	__u32 size;
+};
+
+struct se_ioctl_get_if_info {
+	__u8 se_if_id;
+	__u8 interrupt_idx;
+	__u8 tz;
+	__u8 did;
+	__u8 cmd_tag;
+	__u8 rsp_tag;
+	__u8 success_tag;
+	__u8 base_api_ver;
+	__u8 fw_api_ver;
+};
+
+struct se_ioctl_cmd_snd_rcv_rsp_info {
+	__u32 __user *tx_buf;
+	int tx_buf_sz;
+	__u32 __user *rx_buf;
+	int rx_buf_sz;
+};
+
+struct se_ioctl_get_soc_info {
+	__u16 soc_id;
+	__u16 soc_rev;
+};
+
+/* IO Buffer Flags */
+#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
+#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
+#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
+#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
+
+/* IOCTLS */
+#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
+
+/*
+ * ioctl to designated the current fd as logical-reciever.
+ * This is ioctl is send when the nvm-daemon, a slave to the
+ * firmware is started by the user.
+ */
+#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
+
+/*
+ * ioctl to get the buffer allocated from the memory, which is shared
+ * between kernel and FW.
+ * Post allocation, the kernel tagged the allocated memory with:
+ *  Output
+ *  Input
+ *  Input-Output
+ *  Short address
+ *  Secure-memory
+ */
+#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
+					struct se_ioctl_setup_iobuf)
+
+/*
+ * ioctl to get the mu information, that is used to exchange message
+ * with FW, from user-spaced.
+ */
+#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
+					struct se_ioctl_get_if_info)
+/*
+ * ioctl to get SoC Info from user-space.
+ */
+#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
+					struct se_ioctl_get_soc_info)
+
+/*
+ * ioctl to send command and receive response from user-space.
+ */
+#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, \
+					struct se_ioctl_cmd_snd_rcv_rsp_info)
+#endif

-- 
2.34.1


