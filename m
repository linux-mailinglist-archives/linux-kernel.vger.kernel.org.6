Return-Path: <linux-kernel+bounces-307693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CBC965198
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D1B2866CC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E185189F5A;
	Thu, 29 Aug 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LeROZesu"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071518A92B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966100; cv=fail; b=cRdxMiPlfp0N6f1E7lX70zMnz1uh3oQYAHi3l5jG7QtBlmPN3YpaUbq/R6wZ+H8jvDjvUWGYPFxFzKV/DJLvj3uqh0/xfbvVFU2jy9T+NTQ+J+63IX+pduLnGzpjim5hPvKInfDqUZmlSCt9A2MiERyJ8z7rAAXIfhAtjYZWHow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966100; c=relaxed/simple;
	bh=f1WC+vskhA3R8JbdDiScsOFGTy5BtQ/6Qqg3RFmi3zw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SKj59I+VgSJelFsoP9O33dheQat6CK23cFwMDenzE5GI5euaIAB5pzcWu5JiVRiMVDHaF8VBLPTqzTWJoMgUCFJUSRuKzoDrt3Z3xvEpdUSmU7dJDrXBG+MEtyCo5cxSKAtTgAD6rhbTAp22Nv7A10/p3Xqg6pgjbtplqcjLPmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LeROZesu; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERW9fo1YvgNIJyOrAbcuAIHX16Bz1v4Fx3dEuzFCSnjWe7V7umyzEpMgb/h94RwDZICDyzviv3cBzI46MHPclRz7ha+SL+LCmljnev9hzfzEluVgRK4daSbg17bo4YkDByG9/sKUiGLl6TE3CvV2CD7vnX+3wRhFjDs+MRFmIyRvgEPv9gAQtpZb93Yqu/rWLgjO8782MtwFwUwJFdhrR5rN5HeDi89RnKOhG+e63gsbCZf3fCFhpfRnKVlnBIwbXGcrvnHPb617pIXx33EgQs5wTwYEqj9Ko41oJJruWa988s7/6BlIP62Ek2yHUTgtXKhYK3Em8kq6VJHsvDtg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsacC2sM6vudLiEelzwlwh0ehUTpf5ImMKYhC7eTeKY=;
 b=NfPwFdKrdIGLj6nf1TAo6smVCjYzLB0bw9iBxSu1EKiQRS+j4JP/tEaIfK3jvsWGU0iltvpnni2rokpakUz0qdZcSfIpnHBQkeWoMgr0xsk2/yFjG++TlTeiPRSOBrRoGDy4yXsR/x0bWlIZwevANxw8p7eu9GxHjJYQsA1vo5w2MuPyNBon2lzc6KdNUIw58palx7nzQAGWWso0pxhSa2nG2vUsbIyQwgOBQdjP5FpywgaFA2SYzQtWm+cF81GxJgXrLkwCDDB1LNhw8jVb+Mh0Z4+i8Nvhiu8ZrMhsaSLCGr3iHxinEFqaZlz07QJDCJNikMxVVcsEl7yi5+nE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsacC2sM6vudLiEelzwlwh0ehUTpf5ImMKYhC7eTeKY=;
 b=LeROZesu+wfpI+EgPjDaKIqhQ91aMrKCTbt91YlCejRnWqA/uqBRyNAt84DtawzfH2Sg0l0FQzvAzxPdutnax0NYhwFlSPqvnayEBgq6+ttlDebhvOr7RNa4njEv5lwXF9//moAs+DRCWCjBcd9kW1Uq60zlJIcK8Y/1/ZEiqhmNL2Nzw8Kboq/ZToS0zcBaIvhkRuSM7HVK5pivbWYckFOcNzslLYV2oxWiM8oC6WlAsKfsjODBJkZkQJ7Y0Hvnd7IQmzetAzl0WkuStVUSaUO72vdEWWEJEDneyNbjZUnOxGiDOh4UhIP3+tK7EEXN8Cxo5ulDC6oB5QbbQoLRhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 21:14:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:14:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:13:58 -0400
Subject: [PATCH v4 01/11] i3c: master: Remove
 i3c_dev_disable_ibi_locked(olddev) on device hotjoin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-1-ebcbd5efceba@nxp.com>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966082; l=2753;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=f1WC+vskhA3R8JbdDiScsOFGTy5BtQ/6Qqg3RFmi3zw=;
 b=J8nMUXgzeslqh5WmJsxxzz0j288LGN5mX+W+tUM/6Crkahe2aycbREfYoE999yFKM+ZxRWOJS
 yyUmraSHnwCB74PaugzE5z61iE8pBeVIPdBkadPeKBNar0PvXSMUWMs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: d4796f60-dc79-4915-2e1c-08dcc86f9df1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RzhmS3dHdGRheHpjMGQwVWFQZk9lcVR1NWtqdGMzMGlWUzhrTkpvVUNMVTdB?=
 =?utf-8?B?K1JlZjFNSG5JeW54Q3FSUVJjU3V1M2FTWFRsTFN3RzhCKzZ2WXFjMjljOXRZ?=
 =?utf-8?B?WkE3enBFVGRtb2kyOVRWdC9ZUHVtZDh4WUYreW1vdW5FeFk5bExXUGIxdDJ4?=
 =?utf-8?B?SG9xK0psdHpqblhmTDloZEh3RjRTckNXaC9qTnhHcjZ4RS9JUjJEKzhJYjJ6?=
 =?utf-8?B?dzF2VnJRTTBZQ0NjSkpTZkUza0duck01SDlIL2IxRTlEVnF3RXJBQkhtNjlj?=
 =?utf-8?B?WTlLazBPWWZRRDFZZURRMEd1SEk1dnRMTVJtVXVXTTFzQUo3WWY2K0o3SW0y?=
 =?utf-8?B?ZVhrNWpCODJFWXdMazZTUXJENEVGK0J5dE1OYW13djh4dEJ0eVJwYmxzMm9s?=
 =?utf-8?B?MDFEQU54TWxIVVIrVmRTRTdVUGdOOUdGVFk0QWJ2Y3M1NTNSdnBMeHZpN0Va?=
 =?utf-8?B?RjhIZEpmbFBhT2ZTQTJQQVgrMmUzTkppcmExMjdsOFZiQWVnQmVtZmk2eWx0?=
 =?utf-8?B?M1liS1BsbHBsZnN4ZWtWZEZMdUpnYzBIMngrTGNjSTVVaEZlUG96ZlJnWjhH?=
 =?utf-8?B?Y2llRU1JdmtoTThKQVBDeVdpb1ZrL0tSK1dyL2JtQ0oyNFJhSUw5WFJJblRp?=
 =?utf-8?B?QXJ0a1ZyMzBQUk9hQklHdkg5THRMMnpTbHhBeXNFekc3cmhjUTQvRTlqYkRw?=
 =?utf-8?B?TURuMStCY2ZhclM3V2RlaHBDOHBKUFZTbTcrNDR5dnlTVVhSOUhKSldQWkJt?=
 =?utf-8?B?bGd2RUxvRUhlT1k0dkphNXl1cFV2cC9nWVNFcDVWR2d3bkFpbmlFekp2K1Iv?=
 =?utf-8?B?WlI5emJpL2h1OUNieVBXTk4wSU5hRXJja3hiREtHd0RJYXMwQWtSa1Qvekkz?=
 =?utf-8?B?K0tqZnBGN0p1N2ZNNkVxNFJ1OXNFeE5JT1VmalY4VTYwNmFRakdpdWsrTERz?=
 =?utf-8?B?N0lKRVBBbVJ1TFhvWjJSZEZrRkxuWmF2U2JOWS80aHUySUcwY1N1c3Nyamds?=
 =?utf-8?B?VDFZK1BVOUhubHpObzFlM25PRGJZR1M4WjNYT0E5dmV5bjRneWl3a1BwS2dk?=
 =?utf-8?B?dEpoN1ZQWU5qUjdacHpqcy9CRHhoSmlZOTZYSEx3NDhva283SS9YUitYcXRq?=
 =?utf-8?B?T2lHbGFEZDl6V2t0dmtlZktma0R1MGwvd0t5aDc2aE1rZDhhbHYyUzB4SmR6?=
 =?utf-8?B?R0ZMLzR2REVxL2ovWWdoZ1FIMDNpcFYxN1JmRlVJOVQ5VGk1aFI0NCszSU1i?=
 =?utf-8?B?UC9jZmdEVXJndkJMVzJnN3ZMT29seU81QmRyQ01sdTBFUGRUeTEyQ2ZWcWdQ?=
 =?utf-8?B?dDBMN2Q0dWh3MFdkUlZDdWs2Ky9IWmQyNTNVV083N2oyMkhBNlIyRG5OZVdH?=
 =?utf-8?B?YUlrZzNQYUlobDYrSVMyU05LUTJ3eWlLQmc5STRWcVpSR0VjLzNNOTJIdmJ6?=
 =?utf-8?B?amppUmtTYVl0bkZNNWFqVndJK2tjUHMvQkZlMjA1TkRrSUF5cHNrZ2k0Wk9H?=
 =?utf-8?B?MTF5cHpUUVVBVlNERTZCTVEzMkoxcytQenZUaHZUb2U4SVJZT0NIeG5wK3lx?=
 =?utf-8?B?c1FzdXNseURsWVozdTcrMUtrNEhvK2hLTGFBVGdaTVVGRnhHL1BOcHRmY2Z5?=
 =?utf-8?B?ems3RDNCcjZLdmMzV24wcldBTVlsTnNEdzBsRkx3T3VJUVBGWGNIRmExaWJn?=
 =?utf-8?B?VkdURGh5eHRZQ3ZKZGFnTkRpMzJ0c2txL0g4ZjZUaGNKZXlJdTVTS3pTdXRN?=
 =?utf-8?B?MkQxRkg0MmI1dS8rMnVFZXdMdHZBaldKUWkvbm5iTEZFTHpoL2Z5UUppQkl6?=
 =?utf-8?B?cmdnejRWck42dzJXMjQ3M2p5NHhOSTVJcXZjcnk4WlRneC9WU2FBQU5GSzhP?=
 =?utf-8?B?N3FSYmVPUUo4b25lZk5jekRXK3VIZENsQnR6eVhNUHRIVUE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UXM1aCt6bmlKK2N6bXFpc09FcmxYZUxPTXhYNnd5UndhNzdJc09qU2NXZWkz?=
 =?utf-8?B?eEZ6Q2d5Mk1GT2NsbHh4ZzN4U0dDK2J6a3Q4dGpGaWhRMnRJWHBBdE9CVElw?=
 =?utf-8?B?VDVMVDhHNkE0VVBKTHFINlpEelQrZFZFK2xjUUsyWEpnK1pmaGgyS0J3TnJi?=
 =?utf-8?B?U3VuQ1UrcC9CZitBcGZLOCtRSG5QTTUvcVVtemFZODg1TSsxRXo2WmRkaFpr?=
 =?utf-8?B?N3BJd0xmVGZrem5NTTFoVFlCenphRGU3U1k1YUpVTjJpM2I3SkJycmR4MWJu?=
 =?utf-8?B?WE5vd0pwNDR1NGdYODdlZUxGT3hoY2lHUDRWZFNzaGVrTjFZUGZLSEJZTytD?=
 =?utf-8?B?d0MySjdtTmRvelpSMmpuNWlBNEowSEpBMGJUS3h0cnlZY0dXQUprYy9KMXho?=
 =?utf-8?B?Y0dzL0Q2REU2RG0zMGJCR2JGYmd0WW8rZ3pHNmdXYkttdFY0bVZOenFFK0hM?=
 =?utf-8?B?a0ZKMTVTbktLN3k3VnQ1RmlmWnEzOWVnOHhkMGFlMUxwZGZwN3JUVlA1T0VW?=
 =?utf-8?B?VzN3VnZQRG0ySy9MQnJ5aHY3MHRkbXpuREVjRFd5WWlZeUh0TkpRQThrbEJ6?=
 =?utf-8?B?bnNreko2MXkycE5pVW44NS9rSjZwKy9kY08yS2NEY2pBTVNrekpsQ1JYTFNn?=
 =?utf-8?B?U082QVNCWUFHd01kTkoxVDZMcHMwc0RkRldITkZjdHB0UlBSMzFhakh6WUFj?=
 =?utf-8?B?emJ5SWdDVGJrZVVZMlpOM2ZOd0NzT1JrbGZQbmJCTTBvQzVWUEgyUXBlZFlC?=
 =?utf-8?B?ek9UbHNYUElVK3R5cEtTRjAza0NhZzVoeTNhaVE0WFAvSW5FUnhRZVk2TXVQ?=
 =?utf-8?B?dzFGTFExZHV0MnpPbmVDWTNXc0Q2eUdsdmRxWGV4UXBGZFcxZXlET0lqZTdE?=
 =?utf-8?B?TGg1S1pRQ2xNS1g4KzR2N1NLeTc1VmltT3hRR0RCdDVtQWVBemgwSTRrY2xS?=
 =?utf-8?B?TFp0Zzl0Y2JDdi9YOXdJbGl1MUJsWk45WlNVbHhCL3VWYWNrUGs0bHVVM0lL?=
 =?utf-8?B?ZENSWDRwTlJ1SS81STJMaTUyMUc0bnNhY3cySzBPeGpkWFVINE5tSG9IRFZa?=
 =?utf-8?B?aytUWkp3SHZudkRxdk9HWFFielRVckEvSFJjZWc4TXNjbEhHRU9NTkp3Z1d1?=
 =?utf-8?B?eXV4dGcrY0tuc2VTb0ZBZFNwalQydUNWbkNRZ0NWNFl1d0R6T2pEaFJWTVhN?=
 =?utf-8?B?TWNrbXlFY0lJeXdGRStoL29OWjF4VEp2VVI2NURpVGY3aUhWaDRNRUZFVDVk?=
 =?utf-8?B?dzRUbFRjb0lDQU1JTkJUZjhxSEZsWEVDdVI0MjdRUlAwWjA0eGVuOTVxRU5B?=
 =?utf-8?B?b053TTkwVjh1SGxQZW94clJnSDFubkYxVEpSbTl5OTNYTEdXakR1VEhqaTQw?=
 =?utf-8?B?RXNBMnNYSnB1WUtlSkw0cUk1Z0lyZktZYzU3c25HZGVtcllCMVdMa2hGWlIz?=
 =?utf-8?B?SlBJaS9VUUMvMGhNbDFOTk9sbXRlYlRvZzZkakNlWUEzRXJCK1RjUFFhM0Zz?=
 =?utf-8?B?b0pJMUt1eGRBc3pnTFpOUlRobzNIdWZOd25qODJZRFF3NEN6c1o4NHZVbHBl?=
 =?utf-8?B?MUtxM1FKbWs1ZytQbjRjQ0ZPWUZ6TlEzcGJzNlFZVThCRlJrZE1NWCtmbXo2?=
 =?utf-8?B?S0h1U3BSS1FJSjRES0ZUQ0J1NlVJaEtzUlR1dFEzR2U3VUJsbWRNaUNVa0Vy?=
 =?utf-8?B?clBUSHl0aEh5QkpxdXEwcUZocWxkS25CWjdMM096YkZMRHorVGZ1VnpOQ0hw?=
 =?utf-8?B?dk52VnA0TmJMdGZTc1U4YzE5R0g3Z1NaZEVlQTUySSs2STBlNjZvZitXN2R4?=
 =?utf-8?B?a3pOYlhjaUxyZ09nYU1ocWFzTUhxYWh6ckg3RjNFSFNPT3NWRlJYWG5UUmZD?=
 =?utf-8?B?eFl1dFVTNzgzczFvTVUxamIxTWxRQXNkSjJLSWhPMG4wOFcyWWh0WXA0UXBE?=
 =?utf-8?B?TFB1VHpKMGFGL1RFQktOL2Z4akZUOURmZ1BSYVJSZzlyek44WEozdCtvQzVW?=
 =?utf-8?B?SnFHS1RLbmZDS05GVndybHg2TVhPM2MwOGNYbGRWVll3VzQ1aEErMzZsTytV?=
 =?utf-8?B?c2dZTVFLNU5uTzNCVzBNYWI5Y3JnMnY1N3YyWldVRjgrOS9lc0FDZHhueGth?=
 =?utf-8?Q?zZ9P5c7dO3EpxCdViLFSKX4tc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4796f60-dc79-4915-2e1c-08dcc86f9df1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:14:49.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3ATcurYXBxOpcPxb16DwgeNBzEBK8erKVBaTYGqX93CwYXU5OifKedr8qSvp4uUrLT0+bnzW+In9GUwUyYfbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560

When a new device hotjoins, a new dynamic address is assigned.
i3c_master_add_i3c_dev_locked() identifies that the device was previously
attached to the bus and locates the olddev.

i3c_master_add_i3c_dev_locked()
{
    ...
    olddev = i3c_master_search_i3c_dev_duplicate(newdev);
    ...
    if (olddev) {
        ...
        i3c_dev_disable_ibi_locked(olddev);
        ^^^^^^
        The olddev should not receive any commands on the i3c bus as it
        does not exist and has been assigned a new address. This will
        result in NACK or timeout. So remove it.
    }

    i3c_dev_free_ibi_locked(olddev);
    ^^^^^^^^
    This function internally calls i3c_dev_disable_ibi_locked() function
    causing to send DISEC command with old Address.

    The olddev should not receive any commands on the i3c bus as it
    does not exist and has been assigned a new address. This will
    result in NACK or timeout. So, update the olddev->ibi->enabled
    flag to false to avoid DISEC with OldAddr.
}

Include part of Ravindra Yashvant Shinde's work:
https://lore.kernel.org/linux-i3c/20240820151917.3904956-1-ravindra.yashvant.shinde@nxp.com/T/#u

Fixes: 317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")
Co-developed-by: Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>
Signed-off-by: Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- merge https://lore.kernel.org/linux-i3c/20240820151917.3904956-1-ravindra.yashvant.shinde@nxp.com/T/#u
- add Miquel Raynal review tag
- add Ravindra Yashvant Shinde 's signed-off
---
 drivers/i3c/master.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42e..82f031928e413 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2039,11 +2039,16 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 			ibireq.max_payload_len = olddev->ibi->max_payload_len;
 			ibireq.num_slots = olddev->ibi->num_slots;
 
-			if (olddev->ibi->enabled) {
+			if (olddev->ibi->enabled)
 				enable_ibi = true;
-				i3c_dev_disable_ibi_locked(olddev);
-			}
-
+			/*
+			 * The olddev should not receive any commands on the
+			 * i3c bus as it does not exist and has been assigned
+			 * a new address. This will result in NACK or timeout.
+			 * So, update the olddev->ibi->enabled flag to false
+			 * to avoid DISEC with OldAddr.
+			 */
+			olddev->ibi->enabled = false;
 			i3c_dev_free_ibi_locked(olddev);
 		}
 		mutex_unlock(&olddev->ibi_lock);

-- 
2.34.1


