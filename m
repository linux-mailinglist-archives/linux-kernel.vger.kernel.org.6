Return-Path: <linux-kernel+bounces-526681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF52A401F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9AA3B6786
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF1D255E25;
	Fri, 21 Feb 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iqF5BOJc"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4661E254AED;
	Fri, 21 Feb 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172593; cv=fail; b=XLreUvwUExlv9o0foOWS/s83aW4etgcLC1JVoafPPlRDgnKSTP2Jf6WxvFB8HsLV1pswSf0VLzvgnm3Mqdw12rJBldkHj5x0NWEMjAYO5pl1abLZLkH/uXy/21xTHBUSlSCK9PDQrreXvsVVbmpH3aXlpv4SUmXCcNHO3D2j088=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172593; c=relaxed/simple;
	bh=lTGoGE67IOXkwco1thoVtLrTh1eClnbIL5LATnIRX/E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mOoyzRh/4xFxi+7xG2LtqWt+MYe0poIyERAc0oPj1YvfQsNfzZaFEXYZcSerTg5Hrxj9P0MhFzY0LxtZ+3CLLtu3ezohwekKznE0sEbAD8JE2J9GmbEvp9VB/uLpkskqhY2hj66OnC6aaoMMmUaZAk/TTPBafzIHcj5v/2eDHfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iqF5BOJc; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IP6h2WY/ekZhDzE8LH768WesRscKSDDwF3/wABqP9xeuAaacabi0cShXysh3CfskiEnZrRffACu9HHdjGtKQXj6tXgjxUyjTM2deQ/30BflY/a/b7MYcUdpFZLqMu0HrakR3oAp/17oTgIbxfvO9Po4e36lw7Q2ZqlkjKjq7ioyEeoiDcPRoPw9XIM18n8X2oBiOdtXRzn16JvfKBdtejhCd0fAFx35bmijUpa0oVVMUbq8FYm0DZfJd4pIarrRbehgtsRLzLQYwj/wCs0xPrTepovtS7O3T9m5Urmqbq7jv0MIeNcyz+0a0wcVhWaAbsefIcMnzycUcbcQeB+2q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q2aasrqQZxwfQl8JS7h/fvea4UaeV5PZXZanSdfLzA=;
 b=SP6ehA0JZp7iYq90LbHujiUA9XMEXDcGs+8jJtUfzG9dEVYgG0PdXxTcI/tXY6tE3HGyuRZKYf0QELxPqditLO8ifNWNmrRHWDuXgniMq91NnAWImCGCuO/fqOcB6Z29Ky4XutTZvFfqMy6B6yVm2iBlbuuVnz0Zj2lkls3ydqubMAlh9qb/x65PmEIqXGTWuPSJu5JmNKQToA+w7SoWkySzvhacNbXDe9F9ZoskTNpdyC5YbLxDFXep7AxUMp9dLypQTgscVqWc0zQBrwYx84noZHdrIWpq5KRP8QE87vqk6Fd913gMNUuD4hc85K9UmtNM+HiqG00H1VhgtcaY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q2aasrqQZxwfQl8JS7h/fvea4UaeV5PZXZanSdfLzA=;
 b=iqF5BOJcosxZjlHZQycykVFGCJwL3rdnWx56GgzT0HWcfhCFc9XU5+TPOfjJM/avbziVPqoG4q+Jtb18dUPLvW5D78L4OZTOiYBClyX2cIoRsDjpTnSB+bjlnV7aKrXjj7DTDTU6NSVqoZ+L7G+2jGbhSluJphQbbCamZwIQYx82pLNfzReDOH7aKzLeaViH2oUwdQ+djt+FdC5vLsGnvyvgaZ66XaXY9vOGEekNOe0EoQtd97bKo06RXFK0hdYjxwdxTo/0q1oRj6gJy3t4tFMCFhk9INjCPEPO7LQUwTCRyWvTapCrT139CfNwRIW+myyESmElTrfHQkrxeIHmWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8925.eurprd04.prod.outlook.com (2603:10a6:102:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 21 Feb
 2025 21:16:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 21:16:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 21 Feb 2025 16:15:59 -0500
Subject: [PATCH v4 3/4] arm64: dts: imx95: Add i3c1 and i3c2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-imx95_15x15-v4-3-385ee8e03dfd@nxp.com>
References: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
In-Reply-To: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740172577; l=1691;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lTGoGE67IOXkwco1thoVtLrTh1eClnbIL5LATnIRX/E=;
 b=gNTLLQUo7++BnVZ8Z/521OxKOaMafD27wbUKYqyWtqlVMVk53irwI9BOHryNW/hDeGrUl2zie
 HLXFEe3vWXoAwPXx/Y6yt84+xlViODSOoRydwnyRyNRkSrFJHsjxHic
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 14242b96-5c24-41f3-af62-08dd52bd02ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0d0U0RWb05MbHo0MVdxWFJlYmdLK0tRaEphaENIUjd5Z0FuVGFXSDk1Z3J2?=
 =?utf-8?B?NzRBRVJhN2pkYXJsY1NrRVhxVXVrdDAyWjA5ZCtxMnNMd3ZvbndvR0djWGpa?=
 =?utf-8?B?RTlSQUFvY1UrV3hTUE94eEdXeTFuTVc4S0pIVlZlWmhUMnc4QTZlS0MrOVdn?=
 =?utf-8?B?c3hEcUQvOGNHZVA2NlVZclo0MzYxYzRlZnRVVUdkN0Z6aE5YdjYwTit3Um5n?=
 =?utf-8?B?MXR2ZXg4bTNOUmNBR21hckJ3bmVRK0o5VDk0T2Q3Z0U3TDhRUG1IbzRpMHZx?=
 =?utf-8?B?OWM0SUtzektLUHNoNVF3NDJFTnJpakU2VFg2VGxHM1FxblhWYXhtS204RGhM?=
 =?utf-8?B?WEVsZmpUYlpnaTl5T2ovRVdySmxMTGlDeFJoWTFZUm92U0NiTFV4cmE3Tisx?=
 =?utf-8?B?RFVjV09SVExpOERCVUVpUkk5RFFEUXV6NzJqOWc2eU1VVFpGODArT0RBd0Fi?=
 =?utf-8?B?MzMwcVhjRkZWRG1WR1lCZDFJbWd6MkVoMndQM0ZFeXNXRGw4UGlpYnd0bGlp?=
 =?utf-8?B?TGprdlh0dkljYUdZRzF0M0NFUE4yNGNUYTVhNXFnVC9JZ2djSkVjRDVRVzkw?=
 =?utf-8?B?azRuK0dQNnpaQjdVVndFRmsrc2cvckhNdEpmSVZHTUV0ai9LZEV6aExGNTdk?=
 =?utf-8?B?NE9sVXA2WmVhMXo4S2RLcTFPcXI0VFhDU29hVk1aYUlzaGpkekNOVS9CYVcv?=
 =?utf-8?B?OTBaSnVOVjFoTEFqNzhKYkFMUVRVeHQ5UkVxcVJzUVhaem9QMWNzVXV1eXNB?=
 =?utf-8?B?cVdJOUxBUEcyV05LSnpRRWF4ZTdEUURYRXRQQmtxUHptbkFqU3lWSnNHWGt2?=
 =?utf-8?B?ODZudWphVVNJZ3pNVDJiZkNqM0ljbGVhNFEvQnlFamJzWjBDc0FLZDc2Tnha?=
 =?utf-8?B?N1lWRWdyL1JRUHhrdmlGSmxjdHZzRXZtUlJiY2ZQSmpGbTRSZGJLQnY3aDlI?=
 =?utf-8?B?QW95dDZRa1BXU2o1UUI3VUlTVHVTc2RrTFdiUmE0K1d2dVorWWVxS3pSWkNK?=
 =?utf-8?B?UVlWSHJ1dkNOV200SmtQZFZaSk1JZWMrck9RcVBJckhWZm10YVcxTzRiSXpT?=
 =?utf-8?B?ZGZsUkJiOXhFZHhqaXNhWU9VRkFQaHFXekhaMXI4ZkMrS2trdWpFWisyUFlw?=
 =?utf-8?B?eG9nZkNhdVpsWWhoQ0MwK2RDby9aclNPQytyZnZZUmlPZjVQWThDN0RWbHZq?=
 =?utf-8?B?VnBRVEpWSTVHTEUrMld3U3lxaU05c0RKN1I5SUM5UjFpZFVUR2hhb0Y3a2pX?=
 =?utf-8?B?YjV4MmgvWXBpZXBOWW5vK05ka0VKVm1jN2loQ0hSWjY4RVh4VHhnRGFLbzNC?=
 =?utf-8?B?b1k3YTFyN21SNmE2QStIZUtRUTlpR2hOQjQvWWtTbVk5c2ROQXpMVjQ3NXVk?=
 =?utf-8?B?SkU4eDN1VUdMYmhIUzB3Uk9TL0hoUXRLODhOZHFTOTRSaWd3SGdpSzF6Yllx?=
 =?utf-8?B?ZkRVWHNaSUs1ei91aHFXNVpvQ0RsOVpCd2ZZekRoYWUrU0dqUzlHWkpWd3hy?=
 =?utf-8?B?NFdSWkswQWYwYnYyYmFXRklYR2FoeUh1L0hWVG4zOEhYRTVOSFBKS1R6ZmZB?=
 =?utf-8?B?eTdtK2ZOUlN1eWIyNVRPelRHL1JxYjFUTkZ0eW90elFmSkk0anMzbUxKNkVj?=
 =?utf-8?B?czBTUkNaQWFnVmVWQTB2YUJ0Yi9OV21LeXMzRW9jS3A5SE85MjdZOVRIZFlK?=
 =?utf-8?B?NXJ4dnN4Z3NwNzEvQ1JlV25CdVM5dFhxdEhybjlCSVB2RGpzeVJBcGtORGNy?=
 =?utf-8?B?U0R6cHBVeXNHRGt3T3FJVUdIY2duVWtLdmYvVnVleHc4R1cxWUJycXdvTU1N?=
 =?utf-8?B?UitCSEZkSFNFcmZlSEMwNDc2RDBBQWxMSUQ4aFpSZG84a1lFbmJDa2V1MFRD?=
 =?utf-8?B?R0lKdDN0VC9lUHNLZUsxVnl4VXY2dDR3b3h3SFRaUXh0SStCM3k4dGZSeVNr?=
 =?utf-8?Q?DNpndwuYf0xjAfRxSYr1cRXlDa6SDoNG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2RMQ1pmZ2svM1lQcGNiN0IvSXBaT0k0K01ldFM1Yi9CR2JZS25vbGo3S1NM?=
 =?utf-8?B?R3VaaERlajVXSkNPODRXMEVMemNhbEVxN1h1c0djenNvaThwNXF5bGNyNlRy?=
 =?utf-8?B?T0dKcVo1NTUyZzRxblA2b2t0a002K1N5UVJFQ0UzakZYRXlvTnNqSmd1TE1K?=
 =?utf-8?B?VVBCTFdYaE5OcEZRVFhJOEprcHBKa1dCVVJqUHBIWHhvRExtNG9ucGgzdHJM?=
 =?utf-8?B?YnYvYnJWaXBKVVNwdmprVUZIcGNhMWtVTWU3djVBeDdybEdEbnZOSjBzb3hh?=
 =?utf-8?B?cG5JdmhrMDdsN0JCYW5SbHovVHI0T3ZGSExRRjBlNkxZL1gySTF0emcyOXJU?=
 =?utf-8?B?MGJCMzRxTHFpL29vQ0toMW05YS9FTlNoTDRoT2gvbnVxd3JLNkN6NExBR2dj?=
 =?utf-8?B?eTlmbzZUUzZBd2xjOFpxeVVMbjV6SkJoK1BzQkJNZUJ2Z3QrdnlkQ2RRMzlH?=
 =?utf-8?B?ZDRPZlZMZ29lcHRjZ3JUSlhBd0dEeUVBbUdwYjIwL1RndGt6R1RRY200QUtL?=
 =?utf-8?B?T3ZpR2NjNFlhUTl4Z1hCcGhlZll0SUx4WHJVeG4zTk83bjRhWTRvamRLQkRW?=
 =?utf-8?B?Qm40OW9jWCtZdEhpRFRJWXNqZGYxZGR5ejhjOVI4UTJuV1FWWE1hVk1mQVRS?=
 =?utf-8?B?eDh2Ym4xalJnMS96bTJUM29vWGdWR1JGczkzNVFHdXVZYnZNT0pVTTVUTU82?=
 =?utf-8?B?cXQvZHFvd2hwTU5HUXFQOHE1eVNvaEJsdjNUSndGQVoxRU1pSGxhTTBUZ0Y1?=
 =?utf-8?B?VFVjR2w1RU03ckE2RDcxdGkxVlpHOWRIYTg2bCtXc09oVHN3R2wzVXVGWi9n?=
 =?utf-8?B?aTR0NlNjVmVUbDlVbE50TFQzQU01VVFRM0JCM3AwdUNBNHBrQXpLWGlta1hs?=
 =?utf-8?B?MXdjdGZSWWw1cWdoRWdMTkpxdU1lemxWTXlNMzdBQkpic050aFNWS1ZHZDky?=
 =?utf-8?B?RWdyV2N3Q0RFUExVWFJMZ1ZzUHZKbGZHTSthY2xaK292R295cjY1WXN2N0FM?=
 =?utf-8?B?aUc1bXVqTEdjcWxqR1FBekdaMjV5ajRGMml3OFNhcXpGcVRKeTdxa3ZDY1Ev?=
 =?utf-8?B?bGFjY21CblhaSnBvUmk1SDVlb3dXMVNxbHN6OTQ1NG9GWVlYZ20zY1hZN0E0?=
 =?utf-8?B?bHAzMEE4VUhZMkJRcjhCRE9Sb1ZJT1YxTmRQeXFHQlJIWE1MVGtKY00vWldx?=
 =?utf-8?B?UWd0aG91UGJkai96Y0dIVnR5Z0F6QndwWHlJZkM1VGRpRjFBeGNScmdpb1VW?=
 =?utf-8?B?a1F5L2F1THd0emhqaFdoT0JQckdUaDNHc29haTk2RFRXcmpCUjMrUzFzR2xS?=
 =?utf-8?B?L2RHL1J5Nm5QRjU1bExIZDV2M0tSQlNsMEwwNzZ4UnJaOHVQckFyQXBSdUlF?=
 =?utf-8?B?S2hDT09SK1ZiMDF3QXZ4YmllOWgyVTJDdVFBS1pUU2ovYlMwUVF1TmJXMHJB?=
 =?utf-8?B?MFZyczNhRkpHSVlhNkFRMVFGeHBaMFgrd1F0TEdvYVo0SDA0SzI5ckpUQk96?=
 =?utf-8?B?RjgxUnp6Y2NCdEx0eWo1VTBiNGlDdHVNNVVHSHc2TElPNml4N0YwOXBTMDRN?=
 =?utf-8?B?OEZoazRqQk95TUczTkN1ZjJOdEtmZmoxZkZ6WWZIQzJJN3VCalVmNTFkVjQx?=
 =?utf-8?B?VmpoVWRwR1F1MU9GZVFEanN6aHdOcVdjVE9MTGxkOVZ1L0pEZVE5ek1PQnJY?=
 =?utf-8?B?ZHhHVTZ4VnMwSkdSRlVYdStWZGVESEgrd2x4aG42UUo5NlU4S2RVNnVOdUg4?=
 =?utf-8?B?L25ZdVhaQTRTWkpxd09wN2ZWWHZJb1c3eFN4Y1NvVWFCdzJLZ3B3KzRqY2Rl?=
 =?utf-8?B?cUQwc3BRc0tEamY3b1FjbFhjMU9SdWZsU1cvd1NNanhDUHVUNCsyNjRxT1F2?=
 =?utf-8?B?dVV5d1YxKzBoanBUbDJqN0ZzR0VmUUx2T3MvQzJOZjc4MlJvSDVIMlpHd1pU?=
 =?utf-8?B?Z1FLVk1USEcxc3lRdmxUelNzYWlyWm5CcGYrLzVFVHorSCtLWGVoMDVNM3g3?=
 =?utf-8?B?U1pVQm91UlljaWFtSGRUMXVLYWtkdlBmbUNCM3NtZFk5d3lxcFdmTUd1M3ll?=
 =?utf-8?B?L3FzOVhDUnNJNm5kT3J0QU8wWVhoOGtRVnY5RllNNkM0UnVUNmd5VGdFRTlQ?=
 =?utf-8?Q?ZcO9Aa1dMj6E9YdPFzLQYIzEN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14242b96-5c24-41f3-af62-08dd52bd02ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:16:30.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR5H++GA9OhY/glnJfQmkoxK/AZq/E9UJ50+edbd5nOZkg1qWv6UOZgk/9qnwI58aOV9RVoPhwSclwJubNXbPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8925

Add i3c1 and i3c2 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index ce4c0aa70a07f..0f2094d670527 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -673,6 +673,19 @@ tpm6: pwm@42510000 {
 				status = "disabled";
 			};
 
+			i3c2: i3c@42520000 {
+				compatible = "silvaco,i3c-master-v1";
+				reg = <0x42520000 0x10000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <3>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>,
+					 <&scmi_clk IMX95_CLK_I3C2>,
+					 <&scmi_clk IMX95_CLK_I3C2SLOW>;
+				clock-names = "pclk", "fast_clk", "slow_clk";
+				status = "disabled";
+			};
+
 			lpi2c3: i2c@42530000 {
 				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x42530000 0x10000>;
@@ -1245,6 +1258,19 @@ tpm2: pwm@44320000 {
 				status = "disabled";
 			};
 
+			i3c1: i3c@44330000 {
+				compatible = "silvaco,i3c-master-v1";
+				reg = <0x44330000 0x10000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <3>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>,
+					 <&scmi_clk IMX95_CLK_I3C1>,
+					 <&scmi_clk IMX95_CLK_I3C1SLOW>;
+				clock-names = "pclk", "fast_clk", "slow_clk";
+				status = "disabled";
+			};
+
 			lpi2c1: i2c@44340000 {
 				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x44340000 0x10000>;

-- 
2.34.1


