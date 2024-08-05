Return-Path: <linux-kernel+bounces-274494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6059478CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266D71C2101A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90E315382F;
	Mon,  5 Aug 2024 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c0S3ZxsK"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6001137C37;
	Mon,  5 Aug 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851831; cv=fail; b=Oqb4fsYlt5Pjxta2F+bWg8IgC0DqvYCSqiUm5D6+HUGsglueYTtgvPJJeIgnkITC8J0V9u9lDXn1xe92zRvji2FbBaSkJXkXMHWcq8URy9bFlbnRmwV0UpecbhVotgJGLCM8psjGbrLOJyCr2WYbCgawDKTL9L0tFmFAu0eAAsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851831; c=relaxed/simple;
	bh=DpZZKyAeqSPmvKaVFLMb9QhoEbdSb0SC5fK/CQhIs1w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OoG/OGojE21d1T8j2MGfQavS/gmMlEZ8ohfpixAXKKok+JO7QEBDLRMQjx5dXXvaDFtp+0vQ2W2d8AoVq9fZXI+Iz7QURXsKW11mkbKdktxEuftsEhw45vdQK+ebY7FAXThELsUdBlKyGE0PtwMF5hT6z6LvDsV2FXf3+F3BPtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=c0S3ZxsK; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNrEo/Gl8ZOBbPbz0WQ5n3+K7pDdI3/RjH2eSOu6/WXOGGl1b0MsJksaMvSHXIJmTdw3M56seXTOExvNr8iYfXK90cFcfZfvoJveZnaH+7SZVQjronxfNGM/H7YgPyw8om/WLC24948WvXhE6gd9e4UKy5XiphR+GManDdAH11jOOI3/7DlF4JZqUFjLUGwXfDmLKX70zKda8vhxI9rPO4Z9zIGW/vaZgyDKXO/DlFX/pkStpG1EEopYwWjH70EEgcsaL0qhLy7SynGWRsI3RtGwiTExeDuAFc2sCs0bep3uMuOxqK2X6r9zWGwjbilvVUxT0b1QSWb+yqtF4ZACsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvVThpTVvCEOAYgC32yIuV3LUUb2KcpuZWonvv7QG60=;
 b=JEhhp5WWdwxddZW8B63ngwkpvwJxCtUQtEX0/M25MIgOCwo1wBfBRtXEpWX6KNiQtnj556D7Mi8B7k2xL4WpuON2yEi62rRQT2MMobaXIUALA+INAmQQHiarkVSpfnUlA8yCJ8q8+THvwxbPYe6z4afoL2+NxXi4yD3DM3MBwJ505Us40RRe+iGnNPzN2C8b5+EDDpnZT1SpTlicJ/osoH3MlCAddtTGGs1tfLBhkIKMJoyo/14HvhzSDe/4w7zBLJ+V0zJYxR3+846YFfKHu/Yuz3QIjNApn2EpKccDKzfTdW5QknlF7F1l0S77IaK8CPvbXo3EHb2i9fnUQw1yNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvVThpTVvCEOAYgC32yIuV3LUUb2KcpuZWonvv7QG60=;
 b=c0S3ZxsK1VFFOLT+FjSwaCClOrAoBvmR6Z093HUGtoJTFPBP7g5xGCycK1RB7lxG6WDrI3ieGYPLdmU2qS+/Fl4QDssuY2jb7T9CUzH+IPosQ+K75tX0/EjYUeqrvGRpl/j/Usn0vXV6/aL+w2RxoRmP4hCn0ZEzD3IMuFhSqVZADzvA3c2I7CkfM14A+HFImMDlKaQ/4vGxWYKnjdeiRpdbW7lTlXA1d8g6okdPzCtDwwZobQoqwQ4Efo+uwV5QreWaFikQ0xkUZZ6uM/u7nr67gzJAxemSBbsq/oA/ezFh8aLijEpGuiY1DVSEdwIab6HY4V7k5jPiqfcLDwjk6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU4PR04MB11080.eurprd04.prod.outlook.com (2603:10a6:10:587::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Mon, 5 Aug
 2024 09:57:04 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 09:57:03 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2 RESEND] arm64: dts: s32g: Disable usdhc write-protect
Date: Mon,  5 Aug 2024 12:56:42 +0300
Message-ID: <20240805095642.91606-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU4PR04MB11080:EE_
X-MS-Office365-Filtering-Correlation-Id: ca419ba1-94b0-47ca-12c1-08dcb534f50e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk92VVRySFNGblhHOENWWWI0NWpUTjdMU3EzZnc1ZGU4R2x5SzF0TnpudFph?=
 =?utf-8?B?MkY1WFA5TTNQelBtM29qd2hpTHAxUXNPUmlOSjNZL1J2a2FydmpWU0cxZHNB?=
 =?utf-8?B?Tm5DeklSdWRMME9aY1l5RytNUTBjWkdiSlhpVUdVdmlsY0NZTFNYZ1ZDTGgr?=
 =?utf-8?B?VGdqdUw1d3ozUTNPdC9objY4K3lwTGVFYi9leSsvYmxRTTdsWFc0TjBQTlNM?=
 =?utf-8?B?THhXYUp4b2FvaXVhT3hKZ1JCTXI0MHNtc3JlOG9PZkhyeUkySnVDTys1ckFx?=
 =?utf-8?B?eC9PeTZLTSs3d2FOM1hsSkVhZWRiT1JXMy9NaTJHUC9nM3JnNlpOSENZR0M3?=
 =?utf-8?B?Z2VzcytnVTVrNmo3T0tKYU9haWJZeVZ5Wmg0c0Vyc3IwY1RaakFZVHY0TlJs?=
 =?utf-8?B?S0IwRWl4VVJuM1N5NHhYQnJLaUZwV2dTMkJLWEVOZTByV3B5ZStxaStoWDlJ?=
 =?utf-8?B?cGt4c3ErMlp0MmViNDZxZGk4VFFlaGJKd2Z0dm1GWmJIOFloZWFZbWFpRlJO?=
 =?utf-8?B?bG5MRDVCbkVSUWxjZGtRYk92WkhHTnV3QWRTTmp0UllES0l4M1ZlNVQ2YWtz?=
 =?utf-8?B?cElSbEhHV1l1Z1BBVHBHNnNsZ2xjSzFxYVUzaTZVVzBzOHpWNG8wbzlMSHo3?=
 =?utf-8?B?SzdCNFVZWUFUUWZyU0VKbE8zdms4M3NmZi92WDcxVU9Sd3FxOVJJci9mMzBX?=
 =?utf-8?B?eXBNTnp1QU5uQUpCUldPTTdQOWFWMUhyc0kyQmZPVVREMDNGanJLWEFYTHBB?=
 =?utf-8?B?L3U3dHBqVHhxeStWOEFpV3N0OHVzbGhUb01FeXBoVnlSdHpreklCL3dqNzBz?=
 =?utf-8?B?dFp1KzR0aFk1TGozSU9ZVTl3a0JNUlJONEZoQUpoZ1d4Sm9jd1haanFCUWVp?=
 =?utf-8?B?UjFoVUhmODJIZ05YUS8zQ2pjakRtTWwyVFl6Tk9HSTRtRjhlZ2ZyR21qSTZF?=
 =?utf-8?B?NFhVb0FCVE5lZHYrWnpGRmpzK0ZNaXdIM3p5dGRnUGcrb0ZhamI4SGE0SVlR?=
 =?utf-8?B?ZHFvTHVpUU95SERBTXBpOUxOUXBVcTBROHZUOUVkVStyaTRwaTNkekxHb080?=
 =?utf-8?B?cmhxSzBoL0FDbHB0NWo4REZSV3pOdGh1Um5CaW4yVTJSSkRDeGM5OTBldExV?=
 =?utf-8?B?L0NLa2VRNG9wK25MN0dzWkhONk5nL3FjWlA0d00zZmxSNTBkQlRJQTRadU5H?=
 =?utf-8?B?SlFLL3pIaGs0c3h1NDdkcm11cDg4aTBUUlF0YzlIb1Btd2Y3Q0V1L1BkMysz?=
 =?utf-8?B?azh4TC9YVTZ4OFRtMzdicFBaM2F2b21aV2hMQmVjelRlZHZ3MGNQbkc0cmJV?=
 =?utf-8?B?M0d4Y0tqZVhTM0JqWnI1aVczd09TVlRzWFpmYnBZUHpGeVF6UFFLYVFXbmsr?=
 =?utf-8?B?N0lUK0daWG1VeWR0QXhWVy8wMDZ6THpvSGdBZ3lvcjg1NkJBYlZWd0l4ajZF?=
 =?utf-8?B?cHNaM21vSDhYd3ZxbmlFZk1JRm0rc2lwaGNXT2Rxa00zYkxZNERUWEJIYVha?=
 =?utf-8?B?VVQwNms1Uzh2MHMrbUF4QWFXeTdwUHZMdXpvY0FUdnJGR2lVMnpORjd2bktX?=
 =?utf-8?B?bUM0eGJZbnN6dVhMTVNDZDgyY01iRjR5Q2tyYjBXVUM0SjVUb0FqbVRIR1pV?=
 =?utf-8?B?NGhWc05HMXhla2psaDBqbHRyVEpTdU9HM3pwQmYxL1FwcjVQbnFqcml3cisv?=
 =?utf-8?B?RkdsZ24yR3drSUF2MTU3R3BwZk9ZSWpPcFptL3dicXo1NTd5dTBEcWFiYU11?=
 =?utf-8?B?TXZUaHlNREpMSloydmNnMFliMFh0cm9GWFRoUEVEZkdsKzRIVzI5VFlPYTNx?=
 =?utf-8?B?cndtZVZnZXhTNmtjenJ1azM5dmN3UkU1SnZiLzVTdUlyK2Z5R2w0cUJybk9i?=
 =?utf-8?Q?PS5Oih//x/aCL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG43NFU1TjVZMU15VFVwc0tXaUR0MkV1WUNZbjdvS3pZM0lpTWJnQ0F2UXBM?=
 =?utf-8?B?OW55MkY0TThqcjV5Vkt5Mks5Q0VJUUZTT1Qvcnh1bzlQRXpvb3lWakRUN3lF?=
 =?utf-8?B?d3hNSzV2KzFZeHFCQW9obHduUVNZVHpoVWxtREFhMWxjdkNtdU03aHFDZUVt?=
 =?utf-8?B?UENod3ZBa3M4b01NNDlxWkNmb1Y2eFNYQW9EVDQ2Ylk0VTBhbHA4d0tuUEpC?=
 =?utf-8?B?OTJST2FwSFRWNFJNOEgvZWFZL3grMWc1TkRkbHNrc20reGtSd29FMzQxSlQv?=
 =?utf-8?B?akhzbWY4cEw2R0krdzhwTVh4MXNKeFNsSG1uYTlNZElpMS8wZzlzYXNMU3hy?=
 =?utf-8?B?MGJ5ZWNGVW55dERtVEFJYlkwV25vcEwvbk1ycEI0RDU0VWVXZE1ybDB3Wlhx?=
 =?utf-8?B?Rmk2T2d2MWc0bWN5U2pqNU12bnFYdXVIUlpraUxkSWMrVS9MWXRFRVdWOHJN?=
 =?utf-8?B?Q0NKb0U3VHdkUWpUd0l4OVdwajVTUm4xbHZON05veWFxVmZaR0ZEYjRvRGt5?=
 =?utf-8?B?NjhsS2dVL0tLc3lIK1BDc25WU3pwa3RoK016dlFXelVWZXlBM25EQXV0NTVK?=
 =?utf-8?B?dzFqYkFDUGhkeUFNMDk4elNzNEo5dGoxNFZkdkZCdElDRXNqc0UvK0tJc3Fl?=
 =?utf-8?B?K1c5OG9FR0JTRE5Qb0poK3U4QW9DTFE3OExrL2I4ZzJLeU1xVE5idlhLUWxx?=
 =?utf-8?B?Skp0L0JKRUtlb1lTWmlRVVRUbmtjNHoxSVN2ZmZNSkx3UzVqbEljK0hwS25n?=
 =?utf-8?B?UFpSNzVOL1hLZmxJczhNOGRkMkkzY0FOejJsNkZuUWoydlRDTzU3TkpoZWhv?=
 =?utf-8?B?Skl0Q01IcCs4VDBVYWxvdi96NmZad25JUnhSeTY3VThJVU5QQkxxTUM1YUdl?=
 =?utf-8?B?V21vcHYwc2cyU1hhSzZBWCtqUDBWZXcrUFJwQUpHbWhMZTBVUkJJdUZwbjA4?=
 =?utf-8?B?T2lVbklkSVdWcWZGajcyUnlHZWkra1pOakZWNTJpcy9TZlpuVlZMcjZFZU1I?=
 =?utf-8?B?OVRFSGtnWUtqYVMxanVobjdYM2RSNmtJTFpGK2UyQVIydUpFbDUyYXAwQm5j?=
 =?utf-8?B?dDFsY3hlZzNId01wYXVLd3VabWxXQlZ6cWEvVjE0Vk1DUWpCOWJweWp1VXFS?=
 =?utf-8?B?V0kzNm9vWncwdmJtL3Q3U09kSEpZSi9PNW5KMGJoRTdobDMwaW12S0llSFIw?=
 =?utf-8?B?L0NxZ21vc1NCU05JVmVQUHc4YmNPNGk1ZmRrS29OU1pVekozWVI4cXRTTHUr?=
 =?utf-8?B?N1hmN2o3M2xHdXlpSURFTkM0K004MFhZRkl1d3Z1S3ovbkU2VHFsaVFmK2FS?=
 =?utf-8?B?dU5QR29QY3gzZklEOHpQbzM5anZVQ3BkMUFSRzg1WGhLUEEyTHlNSnREQklN?=
 =?utf-8?B?dThlVFpORlRJNVhnempzMS9qRWNiT3NTTEtHV25hWjJxNk1WWU1IbTJHTUF6?=
 =?utf-8?B?RnZWYTgrck03emtHQ2EwaDFJeHdNcWVBZVYzLzlSTGFzSmttZEFOc1dzZWFR?=
 =?utf-8?B?Uk5SOS9SeTc2aUNXM1VoSmMrZFZrWmM5ckxtUHYxWnM1VE1uWjlMMnZYQUxl?=
 =?utf-8?B?RHBWanJ4dVV2R3RMc2ZlVEhlTXB1RnpoUDdNQnphZXNDZnBQQko4VzdBQXNH?=
 =?utf-8?B?RTB2R0pjdHlaSHRid1ZObFQxell6OFlFL29kR0l2QVIzNWI4Ymo5WTZHbEpw?=
 =?utf-8?B?T3d1T2JwV280TzhyK3R6aXIzUW9QWTZpdG81UW40NnhWTDlvZ0krcUpDSzQ2?=
 =?utf-8?B?RjlGTDdndDNJUXByUk05MGhwNzkwdlV4WXFHNmM1VkZWb1diVUVPWEMyS3Bs?=
 =?utf-8?B?RWJJMHZITy9IUjUyNTZiQnBvT05uNjA5aG5zdjNtK1dJeWtOUDdNQ05DUmU0?=
 =?utf-8?B?RlpjS2VjSDZhZlBOMTh0S3NKa3cvY2FlMHJDLzNBczY1NjlPeDl4Z21rcnVl?=
 =?utf-8?B?d3haYmhhOWhqL1hMUEdpV2kyVFZCV3VMYTlZMy9ZQ09WRlBGWE9Uem1neWhN?=
 =?utf-8?B?Q2dKSGRYeVQxZktRS0RTendnZGZwemh4dmMzYUxmS2o1S2YwV25ENy9HdnpV?=
 =?utf-8?B?K3FkZEZFRkI0S01TVEJDU0ZMeFE5OXZoalJ5WFVnNVdKWHlQd2kxWDdKbzhB?=
 =?utf-8?B?cnhDZ0ZadnhHd3QrcGdjODg2WmI3ejlBWEpISS9ZM3Z5SkFZa2pwb2dTSWxz?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca419ba1-94b0-47ca-12c1-08dcb534f50e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 09:57:03.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbbdUg2oBqMBwyvJ1LQCgUZujdqJrhYUjA3CesfMNYPjd+7eGwvA0Cb+Z+JRfKxNpd+OhnPZEvm4f8uJYdZZBjUmsP2tmKxzBQaEx39ijMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11080

SDHCI controller found on NXP S32G based platforms do not
define a pin for SD-Card write protection.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 1 +
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 1 +
 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index 00070c949e2a..dbe498798bd9 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -34,5 +34,6 @@ &uart0 {
 };
 
 &usdhc0 {
+	disable-wp;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index b3fc12899cae..ab1e5caaeae7 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -40,5 +40,6 @@ &uart1 {
 };
 
 &usdhc0 {
+	disable-wp;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index 9d674819876e..176e5af191c8 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2021-2023 NXP
+ * Copyright 2021-2024 NXP
  *
  * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
  */
@@ -41,5 +41,6 @@ &uart1 {
 
 &usdhc0 {
 	bus-width = <8>;
+	disable-wp;
 	status = "okay";
 };
-- 
2.45.2


