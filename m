Return-Path: <linux-kernel+bounces-188483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFF8CE28E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F21F221BB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44181ABE;
	Fri, 24 May 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HEWofvCn"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D01292D0;
	Fri, 24 May 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540499; cv=fail; b=cq1rYFr5J8skSPYwwMi8z+/xqviLger7Vj7hLdrvDN04fqRKowRq2MQdZ17hcfzqty6VGeuTGpK09bF4HFH8q1b0expZ+CfFcnUISXUIkdSqDuJywvCMEeu7ejkm4QH+2EHo4cHGOpJIvK7PWNOeeYYRtTYPXNP0cmOpf9Pt7QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540499; c=relaxed/simple;
	bh=OcwkAzpACFTgLbGgtrLeYYIXMip8rieT8eRRolhkmx0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HGI5p5yH6By0/fDKNtG9a3rpKZsSGk74kLymERGhjlgzaiExw2i9QgftaIMxamIi2Ipft5TZtu05AZygrHRToz1Yd+UxvvTBAUVcnmwoLgxZXYRZ4rpxR/4FaDEsnotQ5a5lqAdB+yvFJP9p2i07xbXNpJcqbmJxtprXwsb3STE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HEWofvCn; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atJYFbZtcj7Ip+OHbTgR9iSvSg1Fn2SCgD+ARMfPdLSK6JA3uEYo7aWPJOxPsRqSY6soiNQQQZW/dTWcmNiHQmhw4SEpLvmExJH2P3rAclS0/gJaSPgIoe4xpEuTZsdFf/+6PxGzsppV3U0Yv7wS5epYzaS9RM0dYx8UQ6O69emQggFpCrOlIO/eaMwk0xyjhPbVNGs29JsAg+CQvWNLznDga5iWjoShLvUV+NQLFFMtxHEJW/5k4W8TygSymcNzWD1GUrTgwMP9NNu2Ul4AKUOuyk3JWy90UwszP96M1XerU5NU9DOmK0Gi32BYS/l7Q6U92wbdOyzjTzefaIxfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDIiQ0WXldpS1c0zaz2zUEuRzwAAaQlxl5NUitHzIMk=;
 b=eL6E9puI65lFooGTxb4M/pJlkVeAcWGpm27vVGDdcYM+Xvwu5JjrGp+jiQgEJLvU0zf8d1+vTe0di/aD59aZWsKIuGy5WiVvxsX8/6tliEtRNFgkT5lbzal/Ua5oTroeXitb/Ao117N6DXsAqpxK2D8gCeqHCuvVPcuQ8z5b3RME39mZO32KoEwczgqdZnU8bOkx+e70CnfB+DoR9aMYDFNvFzXFNksxNmRgii90ns61oY5JQP6hWS35gsARwpKx9nLbAtEn6H39wUZGJgA27mgWwU1161OwsX4lTOy2zFedhJFSJHL2WzRSrF+CizSkf0ZwvU4aon9/eQTNuLavkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDIiQ0WXldpS1c0zaz2zUEuRzwAAaQlxl5NUitHzIMk=;
 b=HEWofvCnWfEMLJyFvQZbHzsMvDS5g7m1xmCv79zSv1nar02QAw1wqpvEuwkSTLnIZTuHtMVXWFSMniF2HIXqVmVhBTkZJMcLmbx+IZpxRFQaDTF6pF/TVX2O7aCrSuQMJo5CNbxZKFLDONVlipJfQtJgkfbdJoKL2NuAIyxK8LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7149.eurprd04.prod.outlook.com (2603:10a6:800:12e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 08:48:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:48:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 24 May 2024 16:56:45 +0800
Subject: [PATCH v4 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-imx95-bbm-misc-v2-v4-3-dc456995d590@nxp.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541024; l=13836;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=LiEwtdf7o7H0ejhXmj7WnyGO4q5yLREiDmkzoa9AJTE=;
 b=ho5i5/6eHOq1JXzSaicvgEyzWSQvdVGwFnFMh8VIPGxFiwTrxqqY+HB+2lWSumhi+b6QoW81a
 YtOUyTRKpKNCS+qKNLV2iLuGxAIIJ8LGGB/P7IKhkooi2+/9NHFLiIf
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 543a458b-45ed-469e-8c27-08dc7bce3f5a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|7416005|52116005|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWtnRlV1Zjh4clpIc293c2JiMnFVdERMaHNhQ1MrTithZTlBLzhvbGJVOHJw?=
 =?utf-8?B?WTVpdXplWEFnSjNaeG9SS3FteFZ4bXVRSlhRa2FRREk1R2dXczZXNUpuSHEw?=
 =?utf-8?B?V2xteHBldkNBU0JGdEVUeWpEMXU3Vnd5RFdIUFc5MHBzTUdKZEhxVklnUU1N?=
 =?utf-8?B?L0l4SGoyQ3U4NVJkdG0zd3cyQ2RxZjZmY3RJZzNidmlmWDk4QnFndVhPdDUr?=
 =?utf-8?B?bjMzMnNwd0RiT3Z4MWQrK0tldzhpVXBHbytVNEVBTkM5TkFMUUtTR3A3SldU?=
 =?utf-8?B?b2xpQlpySXJFemJJRGZMNUxPbU1XQ1Fhc2tkcURsdE42T1dDNEt3bWo5WHZw?=
 =?utf-8?B?OW5DbUx3V0lkSTUzOUVwbUhqVjdRWXB4cHhSVGpCcWgra0RoNEU4d0ZSTUVo?=
 =?utf-8?B?U0JRYnNrYjY5eXV2UnNqdUcwYkpFYld4NEU4QXhWbWgvK0Z2YWx2bmdtNldO?=
 =?utf-8?B?T29yL0VWcnNTQVZ6S256M3VIRXgrSGlRdjhrQThyVGpvY0x1U3ZKbUlhVEs2?=
 =?utf-8?B?N2UweWkwbW8zMW1BY3N5Q2tMa3V0dmpQbm9WMlhzZmN4L2ttWHFkV3VNdTVC?=
 =?utf-8?B?UjdxMk9GL3hwblUvNDNrWVBieWd6aTJMajNSb1RsYlNIWkxCdnlvdkVDdTVz?=
 =?utf-8?B?VUpLZmEyOW9ucHkyak53cEttRmFSOHVYZW90V1hHZ0xGM3NhaGVIekpram8y?=
 =?utf-8?B?M2ZJRGo2aGhPYlA1WWY5Q04wMnpJeThUUEJZRjFKYUxWWkppaHEybVdRNEQz?=
 =?utf-8?B?dVJ2Z2NoQ1BVTGxFejI0cGMzWjZYTTJSWTY3VUdKWnBGaHFPNkRVR0NXNW1E?=
 =?utf-8?B?VnBCcTFkYTYxSVNKODdGVWNiUCsyanBqbXZBVURpSEFtWVU5NlFGWFc2T1Vv?=
 =?utf-8?B?T3pPQzloUDZqUFY1WjQzNFZObzJEUjd3S0lFY3djZ2NXMEpKdElqMGkwWjhT?=
 =?utf-8?B?VUlUSUdJVGdHNkJwOElMVllqQVl6SWNoRFNORGNrN2Z6bkxrRVllKzdLNHcv?=
 =?utf-8?B?YnBEblB4RndYVVBDemJjUTVMVE5lZDd4bXFkMy96Q01yYlp6dUxZTG5HZGhy?=
 =?utf-8?B?ZkNqNVdIU01DWHpVV2haM1hEaDVTbVB1bHhsZ2xwWGlTVG10N2FDM1lsK20w?=
 =?utf-8?B?VmhEcDBtSWpoSW1XS0kvWTFWM3B3SlVaR2FJYldqc21vcGdIMURHdEljSFZy?=
 =?utf-8?B?eloxdkVjT1MrbDRYTVlrNmdrWDk0elNUSXBJTVhONnpVcHhYaEVoTldOUzhh?=
 =?utf-8?B?YUpuZGNZOE9TUzQ4c1VaMzc3L0s4T2QrWE5XZzVMTm5kMi9tYWR6Ri91dW1V?=
 =?utf-8?B?a25nalNGN2t1NU9pVzk5K25hdDZqTkFPam0vQ1diTXg1N3NISlNQV1orYzZF?=
 =?utf-8?B?Yi9ERGZRYmRJYWZSMnViSThtTDhSSXVJamw2ZUx5L3RRSGcrOStoY1hCaGdx?=
 =?utf-8?B?MDNLbUkzdkZiMmlqVVdCbUdvQkUyQUFMMWxEcmFWMzNBcUJLRVQ1aHBPREN6?=
 =?utf-8?B?ZW5JR3NCYVdMWmNYYkRRbzR6b3psdU1uWGsrOVNvcjU2YnQ1a3hxV3hOQUZr?=
 =?utf-8?B?OFcvWlNKVStzcDBYTjJsZHdrWUkxNXBjVXRkVk11Nmd1NFFWVGtEeGJnK2Nv?=
 =?utf-8?B?TFJhekkweVJ2c3l6OVNJek1zUXpOOGVXWTRiM25Wd2xQYzFWZCtKL21SeVVx?=
 =?utf-8?B?U2R0TG9NeW1obVBNV1E3SFRDNDhWalpVaFk0RWUwaTRJNGlLTDU0d000Sysw?=
 =?utf-8?B?VEsrR3RwQ0I0VFd5WHgwYWVtNVJrbjFyMlZRTXVNU2dZWTBvMkZFa016YzYy?=
 =?utf-8?Q?D9ae++f4Xg14whKr0ubwUiFZMdxrjMUDXT/TE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUFzbjFwY2tUUExzMnZ0TVZVWlF3eENaMjFaZytGN1NWMjRzVWxZbW1YREhP?=
 =?utf-8?B?aXgzQXNOemFEeVkyeDlsNC8rcTBnSmJFMUduTWhpd0Y5N0xyamhuWG1OSlNw?=
 =?utf-8?B?VXlNVUd0c1IyRmNxSi9IQlRPL3pGZmZlbThKSTliNXpScEk4Q24wc09Renlv?=
 =?utf-8?B?SUZQZnI1Y0pYWGlsMFRLQTF5REl6RGV2ZVZ4eXltQlV1SGZvWFYrVFVOc3Jk?=
 =?utf-8?B?Z0NxQVVJL1lFckJjOUFNUGlpSXc2UkllY2NqRnd1MTVEanpMU05ZMEx3dENi?=
 =?utf-8?B?SzMxWmFvSXlweUxHNGpJSEtJYTBZMWhBN29qbkRKSk5IeVJrTkZyYzRlODcx?=
 =?utf-8?B?Z1VmYXZCNWpPWE5hU2hmOGRYUzI5Nm0wR2xRREpJdlZFKy92a0V1ZVVyNjRh?=
 =?utf-8?B?VE5YNWFDYkxSVlVEYXQ4SjJNak5OS1RjMGNjdlo0bHMxNTN4eEJRT2xqbXcv?=
 =?utf-8?B?bnJVMXZqMHZmQ2UzeHZsK0lCOXo0WER3Yk55NlhkT1EwdWYwcy9RdlU3K0hv?=
 =?utf-8?B?OExyNkVBUENoSitINWdxZGJ3Uy9BUDZKZmtOb2VrM1VyeTNXVktQMm83UEpM?=
 =?utf-8?B?SEMvSzFwQVNTZlp6MWlxZ3ZhUHFQS2ZkUnpRaFAwRFJhVU5YanZOVmtOSW4r?=
 =?utf-8?B?amhwZkJHRTFUWXl0YjFySkFyTTRCQTYySU13L2hPZXNtUVBDQnp3VzRQZHBs?=
 =?utf-8?B?U0VnYWU1blBKQzR2QXhtV29iZ0xXeGJ6Rnc1bGxLamY0NVlFNlJJMWo1aTRu?=
 =?utf-8?B?M1E0dFZXemFKWkZPNHpnTGsxUkpSTmdESVdaV1pCMDFLZ0p6bFROeEZjMS9X?=
 =?utf-8?B?UHExNmF0R3c5ZjZzZFRMc1libFJUek1RZGhhaUpkbkN3NGZBdVdHb2dOWXI4?=
 =?utf-8?B?UnJYeEpSQmVLL3FPQi9YZkIwa0gybEk5TjEwd0d6aVdqdk1rb3VmTEluWEl2?=
 =?utf-8?B?c0w4cnBTVkY3bjRkMGFXdmJUWS9meXFBcTM1WXZMYTVMbUxac0c4VzJMdE5J?=
 =?utf-8?B?SFFsV3kzTk5LK1RCZWhDS1hjWUU3RE5FdHV4Z2hCL2VOQ2tDTTBLVzdBUTNU?=
 =?utf-8?B?ME51ZHc2dXllN3RrZ0orb2xRanBpb3ppODFjZVlCQzFMemcrVDZ6OWVMaWV6?=
 =?utf-8?B?Q1FYUmt2WjZkcEtQUEZ0RGR3TFB0MHVveVpVNE55Mjh6eWJQUWc4TnZhaGUy?=
 =?utf-8?B?RWZzajlMWG5ucFZXcTgrS29HWTBtVlhzWEJsQ0V2UU5mUEt1ZWw1QWZvdWwy?=
 =?utf-8?B?b1E4SmNZdE1kT3NyWUhPZmx6MDUydVk0Wk1VMjlqRFFOZ0VxYnB6d090bFVE?=
 =?utf-8?B?VFVMeittb2pzNWZDMThmSmE5U2YwemNxT1R6eE11dmFDbStIaUY5am43eW1K?=
 =?utf-8?B?bHVJUmFEV3BHMUdmcW1INmVYOVZLa1VJZUJaeEdBUDNiang1NS83NVFXU3F5?=
 =?utf-8?B?SDcvQXI5dndyT3AvaUhqWnNpU0lMMFBPSStZS0hPb2xQeUp3ZU02WVduRHJN?=
 =?utf-8?B?OW4vNFRkeEtySkJHbU12V00yVVY5bzZCcDFvQUFTTWs1dTlLSTVqRExBUWFm?=
 =?utf-8?B?ekdWdHp5RzJZaHRDUkxaNWswSVEzRXpjcUxGcjA4RkNkaDBqSXcxKy9yWkFr?=
 =?utf-8?B?VzVZYkh1Q0VEZEF6aVF5UDBwejJJNnZZK0FPd3orOVBpeHFYYjhUeHV2cU1Q?=
 =?utf-8?B?OVZEK0JMM3FkNnlzeGhQR0tEdXFIM3VSc3paRTdTUWZrbHQrelRVdVZyV0FL?=
 =?utf-8?B?Sm9xczlDcG5WZ2R6ZU1zT2owUUNhaHNkMWxPd3dpWnVpWm05bGthdzJpTVlE?=
 =?utf-8?B?b09EMVgrdzRHQ2F5L2NSRUlDbXhxLzFnbVlTMFNkUzRKMDRSVjJFb3JLZmxm?=
 =?utf-8?B?SjNtSSs5TTRjY3F0Wit4Vm05cW1PRFlEcXc5NzRWd1JkNTM5dmJ4amZ4NEdv?=
 =?utf-8?B?Q3FiVThiVU42Z2Z6MFZqbHA5VUdUWkRRY241QjJ1UndjZklhVDJaTXhzZDVB?=
 =?utf-8?B?TGp0QWdMTFhPUjM5bkxrK1UyMXpJMnUwU3c2QlpFNldlUnZucEY3Wk1DSlFZ?=
 =?utf-8?B?RTltMk1lYmcrZEdTQVE4dXFORmw1UTAyaGFEVEtET29wdFpRblB0Q2lTdHBz?=
 =?utf-8?Q?/mZ0JUKSXMKSaxUNpu0e6JCnC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a458b-45ed-469e-8c27-08dc7bce3f5a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 08:48:13.6867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2OdhUjYpDKCItjwLmbDozUeHVIfneLaxXTxUCZWVE1MQGEC91hq/t7Mj3AJyIfN7X8yUFB5btKBj0sMQa9RuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7149

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has a battery-backed module(BBM), which has persistent storage (GPR),
an RTC, and the ON/OFF button. The System Manager(SM) firmware use SCMI vendor
protocol(SCMI BBM) to let agent be able to use GPR, RTC and ON/OFF
button.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Kconfig          |   2 +
 drivers/firmware/arm_scmi/Makefile         |   1 +
 drivers/firmware/arm_scmi/imx/Kconfig      |  14 ++
 drivers/firmware/arm_scmi/imx/Makefile     |   2 +
 drivers/firmware/arm_scmi/imx/imx-sm-bbm.c | 380 +++++++++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h          |  42 ++++
 6 files changed, 441 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..79846cbaf71b 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -180,4 +180,6 @@ config ARM_SCMI_POWER_CONTROL
 	  called scmi_power_control. Note this may needed early in boot to catch
 	  early shutdown/reboot SCMI requests.
 
+source "drivers/firmware/arm_scmi/imx/Kconfig"
+
 endmenu
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index fd59f58ce8a2..fb9407fef60c 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -16,6 +16,7 @@ scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
+obj-$(CONFIG_ARM_SCMI_PROTOCOL) += imx/
 
 obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
 
diff --git a/drivers/firmware/arm_scmi/imx/Kconfig b/drivers/firmware/arm_scmi/imx/Kconfig
new file mode 100644
index 000000000000..4b6ac7febe8f
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "ARM SCMI NXP i.MX Vendor Protocols"
+
+config IMX_SCMI_BBM_EXT
+	tristate "i.MX SCMI BBM EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System BBM control logic which supports RTC
+	  and BUTTON.
+
+	  This driver can also be built as a module.
+
+endmenu
diff --git a/drivers/firmware/arm_scmi/imx/Makefile b/drivers/firmware/arm_scmi/imx/Makefile
new file mode 100644
index 000000000000..a7dbdd20dbb9
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
diff --git a/drivers/firmware/arm_scmi/imx/imx-sm-bbm.c b/drivers/firmware/arm_scmi/imx/imx-sm-bbm.c
new file mode 100644
index 000000000000..3f8321d247ae
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx/imx-sm-bbm.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) NXP BBM Protocol
+ *
+ * Copyright 2024 NXP
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications BBM - " fmt
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "../protocols.h"
+#include "../notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_bbm_protocol_cmd {
+	IMX_BBM_GPR_SET = 0x3,
+	IMX_BBM_GPR_GET = 0x4,
+	IMX_BBM_RTC_ATTRIBUTES = 0x5,
+	IMX_BBM_RTC_TIME_SET = 0x6,
+	IMX_BBM_RTC_TIME_GET = 0x7,
+	IMX_BBM_RTC_ALARM_SET = 0x8,
+	IMX_BBM_BUTTON_GET = 0x9,
+	IMX_BBM_RTC_NOTIFY = 0xA,
+	IMX_BBM_BUTTON_NOTIFY = 0xB,
+};
+
+#define GET_RTCS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
+#define GET_GPRS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define SCMI_IMX_BBM_NOTIFY_RTC_UPDATED		BIT(2)
+#define SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER	BIT(1)
+#define SCMI_IMX_BBM_NOTIFY_RTC_ALARM		BIT(0)
+
+#define SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG	BIT(0)
+
+#define SCMI_IMX_BBM_NOTIFY_RTC_FLAG	\
+	(SCMI_IMX_BBM_NOTIFY_RTC_UPDATED | SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER | \
+	 SCMI_IMX_BBM_NOTIFY_RTC_ALARM)
+
+#define SCMI_IMX_BBM_EVENT_RTC_MASK		GENMASK(31, 24)
+
+struct scmi_imx_bbm_info {
+	u32 version;
+	int nr_rtc;
+	int nr_gpr;
+};
+
+struct scmi_msg_imx_bbm_protocol_attributes {
+	__le32 attributes;
+};
+
+struct scmi_imx_bbm_set_time {
+	__le32 id;
+	__le32 flags;
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct scmi_imx_bbm_get_time {
+	__le32 id;
+	__le32 flags;
+};
+
+struct scmi_imx_bbm_alarm_time {
+	__le32 id;
+	__le32 flags;
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct scmi_msg_imx_bbm_rtc_notify {
+	__le32 rtc_id;
+	__le32 flags;
+};
+
+struct scmi_msg_imx_bbm_button_notify {
+	__le32 flags;
+};
+
+struct scmi_imx_bbm_notify_payld {
+	__le32 flags;
+};
+
+static int scmi_imx_bbm_attributes_get(const struct scmi_protocol_handle *ph,
+				       struct scmi_imx_bbm_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_imx_bbm_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_rtc = GET_RTCS_NR(attr->attributes);
+		pi->nr_gpr = GET_GPRS_NR(attr->attributes);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_notify(const struct scmi_protocol_handle *ph,
+			       u32 src_id, int message_id, bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	if (message_id == IMX_BBM_RTC_NOTIFY) {
+		struct scmi_msg_imx_bbm_rtc_notify *rtc_notify;
+
+		ret = ph->xops->xfer_get_init(ph, message_id,
+					      sizeof(*rtc_notify), 0, &t);
+		if (ret)
+			return ret;
+
+		rtc_notify = t->tx.buf;
+		rtc_notify->rtc_id = cpu_to_le32(0);
+		rtc_notify->flags =
+			cpu_to_le32(enable ? SCMI_IMX_BBM_NOTIFY_RTC_FLAG : 0);
+	} else if (message_id == IMX_BBM_BUTTON_NOTIFY) {
+		struct scmi_msg_imx_bbm_button_notify *button_notify;
+
+		ret = ph->xops->xfer_get_init(ph, message_id,
+					      sizeof(*button_notify), 0, &t);
+		if (ret)
+			return ret;
+
+		button_notify = t->tx.buf;
+		button_notify->flags = cpu_to_le32(enable ? 1 : 0);
+	} else {
+		return -EINVAL;
+	}
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static enum scmi_imx_bbm_protocol_cmd evt_2_cmd[] = {
+	IMX_BBM_RTC_NOTIFY,
+	IMX_BBM_BUTTON_NOTIFY
+};
+
+static int scmi_imx_bbm_set_notify_enabled(const struct scmi_protocol_handle *ph,
+					   u8 evt_id, u32 src_id, bool enable)
+{
+	int ret, cmd_id;
+
+	if (evt_id >= ARRAY_SIZE(evt_2_cmd))
+		return -EINVAL;
+
+	cmd_id = evt_2_cmd[evt_id];
+	ret = scmi_imx_bbm_notify(ph, src_id, cmd_id, enable);
+	if (ret)
+		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
+			 evt_id, src_id, ret);
+
+	return ret;
+}
+
+static void *scmi_imx_bbm_fill_custom_report(const struct scmi_protocol_handle *ph,
+					     u8 evt_id, ktime_t timestamp,
+					     const void *payld, size_t payld_sz,
+					     void *report, u32 *src_id)
+{
+	const struct scmi_imx_bbm_notify_payld *p = payld;
+	struct scmi_imx_bbm_notif_report *r = report;
+
+	if (sizeof(*p) != payld_sz)
+		return NULL;
+
+	if (evt_id == SCMI_EVENT_IMX_BBM_RTC) {
+		r->is_rtc = true;
+		r->is_button = false;
+		r->timestamp = timestamp;
+		r->rtc_id = le32_get_bits(p->flags, SCMI_IMX_BBM_EVENT_RTC_MASK);
+		r->rtc_evt = le32_get_bits(p->flags, SCMI_IMX_BBM_NOTIFY_RTC_FLAG);
+		dev_dbg(ph->dev, "RTC: %d evt: %x\n", r->rtc_id, r->rtc_evt);
+		*src_id = r->rtc_evt;
+	} else if (evt_id == SCMI_EVENT_IMX_BBM_BUTTON) {
+		r->is_rtc = false;
+		r->is_button = true;
+		r->timestamp = timestamp;
+		dev_dbg(ph->dev, "BBM Button\n");
+		*src_id = 0;
+	} else {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	return r;
+}
+
+static const struct scmi_event scmi_imx_bbm_events[] = {
+	{
+		.id = SCMI_EVENT_IMX_BBM_RTC,
+		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_BBM_BUTTON,
+		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
+	},
+};
+
+static const struct scmi_event_ops scmi_imx_bbm_event_ops = {
+	.set_notify_enabled = scmi_imx_bbm_set_notify_enabled,
+	.fill_custom_report = scmi_imx_bbm_fill_custom_report,
+};
+
+static const struct scmi_protocol_events scmi_imx_bbm_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &scmi_imx_bbm_event_ops,
+	.evts = scmi_imx_bbm_events,
+	.num_events = ARRAY_SIZE(scmi_imx_bbm_events),
+	.num_sources = 1,
+};
+
+static int scmi_imx_bbm_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	u32 version;
+	int ret;
+	struct scmi_imx_bbm_info *binfo;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM BBM Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	binfo = devm_kzalloc(ph->dev, sizeof(*binfo), GFP_KERNEL);
+	if (!binfo)
+		return -ENOMEM;
+
+	ret = scmi_imx_bbm_attributes_get(ph, binfo);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, binfo, version);
+}
+
+static int scmi_imx_bbm_rtc_time_set(const struct scmi_protocol_handle *ph,
+				     u32 rtc_id, u64 sec)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_set_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_SET, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = 0;
+	cfg->value_low = cpu_to_le32(lower_32_bits(sec));
+	cfg->value_high = cpu_to_le32(upper_32_bits(sec));
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_rtc_time_get(const struct scmi_protocol_handle *ph,
+				     u32 rtc_id, u64 *value)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_get_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_GET, sizeof(*cfg),
+				      sizeof(u64), &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = 0;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*value = get_unaligned_le64(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_rtc_alarm_set(const struct scmi_protocol_handle *ph,
+				      u32 rtc_id, u64 sec)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_alarm_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_ALARM_SET, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG;
+	cfg->value_low = cpu_to_le32(lower_32_bits(sec));
+	cfg->value_high = cpu_to_le32(upper_32_bits(sec));
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_button_get(const struct scmi_protocol_handle *ph, u32 *state)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_BUTTON_GET, 0, sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*state = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_bbm_proto_ops scmi_imx_bbm_proto_ops = {
+	.rtc_time_get = scmi_imx_bbm_rtc_time_get,
+	.rtc_time_set = scmi_imx_bbm_rtc_time_set,
+	.rtc_alarm_set = scmi_imx_bbm_rtc_alarm_set,
+	.button_get = scmi_imx_bbm_button_get,
+};
+
+static const struct scmi_protocol scmi_imx_bbm = {
+	.id = SCMI_PROTOCOL_IMX_BBM,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_bbm_protocol_init,
+	.ops = &scmi_imx_bbm_proto_ops,
+	.events = &scmi_imx_bbm_protocol_events,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+	.vendor_id = "NXP",
+	.sub_vendor_id = "i.MX95 EVK",
+};
+
+module_scmi_protocol(scmi_imx_bbm);
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
new file mode 100644
index 000000000000..e59aedaa4aec
--- /dev/null
+++ b/include/linux/scmi_imx_protocol.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SCMI Message Protocol driver NXP extension header
+ *
+ * Copyright 2024 NXP.
+ */
+
+#ifndef _LINUX_SCMI_NXP_PROTOCOL_H
+#define _LINUX_SCMI_NXP_PROTOCOL_H
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+enum scmi_nxp_protocol {
+	SCMI_PROTOCOL_IMX_BBM = 0x81,
+};
+
+struct scmi_imx_bbm_proto_ops {
+	int (*rtc_time_set)(const struct scmi_protocol_handle *ph, u32 id,
+			    uint64_t sec);
+	int (*rtc_time_get)(const struct scmi_protocol_handle *ph, u32 id,
+			    u64 *val);
+	int (*rtc_alarm_set)(const struct scmi_protocol_handle *ph, u32 id,
+			     u64 sec);
+	int (*button_get)(const struct scmi_protocol_handle *ph, u32 *state);
+};
+
+enum scmi_nxp_notification_events {
+	SCMI_EVENT_IMX_BBM_RTC = 0x0,
+	SCMI_EVENT_IMX_BBM_BUTTON = 0x1,
+};
+
+struct scmi_imx_bbm_notif_report {
+	bool			is_rtc;
+	bool			is_button;
+	ktime_t			timestamp;
+	unsigned int		rtc_id;
+	unsigned int		rtc_evt;
+};
+#endif

-- 
2.37.1


