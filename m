Return-Path: <linux-kernel+bounces-224640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DA391253B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE35282D21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E293C1527AC;
	Fri, 21 Jun 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jo1XWV/P"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1BC152188;
	Fri, 21 Jun 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972861; cv=fail; b=N63G+MSLh9GXDJp959E7NjiMw2TK3Xn6Ata5UTjVSTF4+R4NbbnV87wSXuGe3P1QlIS4ZdWNzjPzQyq4jg4tjUP0Jw748NZgfJuiBKtHbxhYuqcUb26DTmfNRYJHn7fx744/kQvFRCh0OSlKFdPV/g+kkcLDU0CuqMsylWVBIAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972861; c=relaxed/simple;
	bh=xRvhaZZ3DcQeIyPH+7md57sueeYi3CQhVi/8YTmLZgY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lcsIooJ0qq5eKWNXQ7NP7yFgm0zSOu12DPJNUm5HpR6Q5a/bt7NVN7tRmWcEQuHK5u84q+oj0rYgH9XV9Nd+OhfwPWOznD3tkDddBBkx9LKZxuPlTE4NkW72GIVSb4eaUF1in+feKUAuh1bFZCvqxWpv0rXLn7DRJxVlz3k2HmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Jo1XWV/P; arc=fail smtp.client-ip=40.107.6.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5vG/IkTBGfUHJraHXH7Xy1KQqdDmcXn7E9FaFFwe0IeJ4Y2gYqMtPzfn0eanwKxmCjuTZHBpQmWRSf5hwMgLRxxkwvsMPFmZds6KQVnYnYz13SsLwcTxTvad34aK+4iw8whjbA6LV78YXnXEHTMIcaIUscR09h5cegIRWJW7tHiOHGUIb9eoGM3PyO8Z6pYQ/bOGP9+QdoD9aZKnV4u8BA40vkwPcLDj1vMl6E2erGGol1rjWjkrC94X3zHefLOxdtjf9WQcSvy/kpEPEx0D8ldYs/M6yKUp2giiw2rfoKFeDqOvzfZgPFnJ9R74pNGZMbd6DmgsdTSgk4ZH8DLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhnjjHEPZkyj/I8sdCiVwwGtcqPe795gcKxBrpX9EEg=;
 b=BK2uIxkuwmbPD09sOCxnKkvbryyNMmKeOGdvY4C9aueWhmqozKkK+slEFUEUZW/Ht7lruTsLFZGFA+kyc/I42/u3c9qmQpcW0ho0WnuGlhetGb12yeYg8AeK2sZ/fYhzHbrvSBXEjnNlV5kucrmQBANhTYN3B0hxvHkEnBz4VuTqPqWMYy7mAP2M88ySaiRrgzgZoZNdE9mOeaLHXbyY9SkWkFQyemxZl7fANTgnRuIT8yE3pmkXQFTxLMHxrKllBzTQxywG3gPosMOW89fGeVLbSTer+fVlU3MCacD5vPSeC3dqvbXIqoHPIzoDjtWg0y9Raoh5Y0l3R3gCEdA8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhnjjHEPZkyj/I8sdCiVwwGtcqPe795gcKxBrpX9EEg=;
 b=Jo1XWV/PQ5i5Huok3MI5Fa8JHgYBf/sljwxAC7T45Ejy7N3W4sjbDxQIOOR8J8kK0AJYD3avtV7xN50vBXFlEVvcASLeS9aezCZtPJhXCErn1SiC4SRYUf5rLF63EkoxFWfTK3Bx18UDS2SrEG4qokQ+oW1ihetaP0Wey7SnwR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 12:27:37 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 12:27:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 21 Jun 2024 20:36:39 +0800
Subject: [PATCH 1/2] of: property: add of_property_for_each_u64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-clk-u64-v1-1-d28a611b2621@nxp.com>
References: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
In-Reply-To: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718973409; l=2684;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VQgWQEkZAtD8vvzYVsrC8omPI8Ofhy4Rly8IvK0keKo=;
 b=ADQEs54+VVKIEpx9O8ZEtAc1p4GG0/8hr876i9vHvdAPJhXj2gGoxzggTx5yAberty8YeLgbU
 Sp1Up56JaVuCcIFPhKyXGwrVLP8VKiMbqgapV6/39ObFVBUUNwXkF7E
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DB8PR04MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2077ab-8588-4fa3-3bbd-08dc91ed8921
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjEvUzVhZzM1a1k2VTdDbGwvTnJVdTNXSXdkRkMzdmFDRHpmNVV0bWJrUnFL?=
 =?utf-8?B?amVBZjRPSi9mTnBRMFBqN3F6T0ZkcXpMRXBOWGs0OUdpZVc1eG5oNVlXUEJj?=
 =?utf-8?B?MG1VcTVaWVNyc2NJUHVnckpTL2gzWlJydC91bURRK1VPVzUwZy9UOXpiZmda?=
 =?utf-8?B?R1RZeW1ncjZ5cFZGMTkxNXR1NUxCNUFFQ1U4Sm95TEFUZ0NjemI1Zy9jMXFQ?=
 =?utf-8?B?bTZxRDh4ZXpNM2J2aHZBdlN6eUk0YzcvemFrVmdJeFFBZkNhOWVLN1QzZGtS?=
 =?utf-8?B?MEZLZWQydUNiS3BlVUhJQzJaUUc0dnpYb2JSWUNKcitJeEZQSEdkYmdrVExU?=
 =?utf-8?B?RDVEb0hEVjU0d3lZSU9KQllDWlA4dVZEVDBIRzZQV1htV0Zua0IrTkhSNXRN?=
 =?utf-8?B?YnZSQUNxRU5pRnc0YUprck1CSGo3Y3ExL2V5OENXcDdyVnJKVGIwb05hUU0z?=
 =?utf-8?B?TnZJQ3BXME5BMDZWQy9DNjBOblN6RzgzaHZwSGZ2M3VnMEc4d0xpOG1NcFJw?=
 =?utf-8?B?V1BPVndlbWhJcVdmY0o4NkFNblQwYTVHOEc5V1NNK3lIRVpzUlR0b1p1REhM?=
 =?utf-8?B?VExGWmZudk1uTHFHcWpEd3dFWGt1bktTSEw1TWtpVFM4Z3ZXMVF1RWh2Rktu?=
 =?utf-8?B?OHV6ZVpqMDU1aStPM09JNDRoNE1PeVpiVFdFamVTSy9LVWtIbENDTzVaUHBo?=
 =?utf-8?B?Y0dKZDRNQWJHK2hWUm1IeEJxeXBmRzJ2eHRpaDBVMEhwdlRvcDhWZ25pQ0hi?=
 =?utf-8?B?ZFdUcXBnQ2lDcVp3Q2RUQnFpdHlFSlpXWGFQT1ZDbDJxcVRQait2L3Nxekc5?=
 =?utf-8?B?V3ZPdHNGbEd2MVd2UWltYndEWlV6ZXRPM0d3R2tic3JSck82MUo1M0NkZ0ZE?=
 =?utf-8?B?OWxqYWE3dGRvV0cwVHY1TVFtZU9BakZSVlhMemtVYXRxejYweVFmeUw3VUhp?=
 =?utf-8?B?VWV3dFgxbEZ5QXlKKzBKbEoralZzTFgyYVlPNGx2ejI2cUpIeiswY2xPaGh0?=
 =?utf-8?B?RG1BZ2R5eHhPNlVWbTZNVlhXL2xiT0tjNmFpTFRLMS84WVl4VkxGUjd4YUdh?=
 =?utf-8?B?QzFpMWhzZzlqU3Zld05BZWsvL3hPR0NvQVo2eEVoRG9lTHdGbU9JZ1pnM0NV?=
 =?utf-8?B?cXdVZlBMQVljMnNJSDZlc2E2VzJ6K1E5cXR6QTJ6cnV6dFUxZ2NYS1RwZ3R4?=
 =?utf-8?B?bEtiaUIzWnFMYUhBSlZab0NKVVJ4eTVuU21oV3I2TUhjS1A5aWgvQ1R3VGp0?=
 =?utf-8?B?OTRPL3BHYzZIWmNzcEFVYlRSMnRySlpLUnIrNUlXUmtyNXFDQkhadTdKRUpn?=
 =?utf-8?B?NjEwSmNiN2FMbXFSaGtQbFBqcEhheXFubXkreWpwcDZPc3QxSWRLR0lBQUly?=
 =?utf-8?B?NUdHS3llcFRRYU1OaldDbFRib3BBRWVLQzZ0N3Jmd2pYbXA1dXM0c2F0S2Rz?=
 =?utf-8?B?UXBzc3d6MGpHZXQwWU11dHpKUGoxSFBQVFRJejR1clQ4ckZxMnp5Zmk3TmQ4?=
 =?utf-8?B?b1lra3FEM0N6Mk5XZ3JCcVpuVWJzbURwTDdvN2h5bFFmYWxQdmJJNXJhclZX?=
 =?utf-8?B?NXhUOHZ4M0VQY3VYTmFSUGY0YzQ3czFWN3ZEZlc2eGJCbHZGb3hUaVExNHov?=
 =?utf-8?B?WjZacnlTM1R1SU04a201MGVnZ2dua1NoNUpXWmtHTUVlcng0bkd5OVVSU2Rh?=
 =?utf-8?B?K2VCVTI1OWt6QlQ0S05MOWxDOHNDcVFKWDVDUmNVS3NSQmpxaXVkWVcwTDE3?=
 =?utf-8?B?SGxqRG05bWRlaTZzZGJycjZCOURVQmdpL1h4WThmM0ZOUWhTOFF3aTVGNmQv?=
 =?utf-8?Q?fwP9BAQuo+Ri8Q4YyQyvt4YFkbaFPSqFhRDNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXVxUWVuRUJmeVFqbDhydGYwTm1qbEY5VHF1Z1dRaDU0ckQ4R0RPczJYZWtS?=
 =?utf-8?B?aGJCY2tmYlRXMTdUZGxmVGp1Wm91bFpwZi81cS9WTHdvbVpydVpvRmVtQTdB?=
 =?utf-8?B?SjRHMGJmb2xNeHhDZm90MFprZkt3NDNreUxXalBjRmxMV093MWdvemVKcEhG?=
 =?utf-8?B?OWl6OHpjNkQvcDhqbDh5ekpwcFBTSjEzamhmSUVaWU5PYVhKNkx4eTYzbEtE?=
 =?utf-8?B?TTkvTyt2UEpaN2ZHM1Z3QUpMOWFGbmNJODEwc1kydzYyeGNSMFg0d0dpbFJa?=
 =?utf-8?B?MisxSDNUcUE5YkhBejRZZE9XR3NhMDRmanJPV0pVaUF0RlhZRStDVUFzRVgw?=
 =?utf-8?B?Y2ZrZ1RXSExXKzZZLytqcFFhY29ncnMxbE53RUZFV25RTTRCTU5mRTNTcDRo?=
 =?utf-8?B?Zy9XbEhvaWZuQ0VBejFvY2RMdkFIdDI0SFpZempoOTUrQmFTSFBxTmpBSzhM?=
 =?utf-8?B?bjEwQzdTTlhHQWFReEtkTi9uell5VERCNENiY0YzZW14bWwrSnVhQnh0bTFD?=
 =?utf-8?B?S2tJTUhsMFpDbmFrUWhQMXZDREF6QzJlR0N2aTMyUmtaenVqRTQwR3JzQWxx?=
 =?utf-8?B?Wlk5YVZWcUF3UzBBWUxOb2FsWFlHUU1iYW52R2NnVUpWTVpCZGhFZG9INlVa?=
 =?utf-8?B?eVl4RExBY3BML2Y5a3hFRFh4MkNKVEwzT1kyTnFjckZ3WHRDTzFUdndtamYv?=
 =?utf-8?B?Z0lxMUhBRC9XT3NxWklMS0pEeUdHUUVpeEJZRmNhNzRzRnZFMjFhdGNKUDFX?=
 =?utf-8?B?WUdlSEk2TlFIVE5COGxRZlRYa29KVDhQNVRYc05SRmJSb09TTGZHMW15aTdN?=
 =?utf-8?B?YUNwSjVEeVhYRys3UDdvbTlZMlY5NmFwQlBZeENVcS8yTkhiUjI3WjhVMGli?=
 =?utf-8?B?REJLT0tkNEFmYXBIN2VyWVRpM0ZrRmFGRkt3bm5ZTkZuMVNrU2pWcUpuTHZL?=
 =?utf-8?B?OTN6VkYzdHpUdDZLakY5V0tLUy9rM0U3bmZmei9GRWE3Qlg0U2ZlYkxxendk?=
 =?utf-8?B?b0pFV1FlMDlPR2hPM2RJQTU5dVEveFFzdVpkUVBEMzlvMitjWmY1QXhOSnVQ?=
 =?utf-8?B?VjJzVkhrbyt5cXNuZmsrYVJVcjE1SDNSM2EzQ2lSbnE3QVZQVzZCZ2dONlpr?=
 =?utf-8?B?OTk1L2JDbi94bU9Eb0JhM0Q1Y3A3dytEOFBtSHh5Qkw5MWtEa2RVSlF5Y2hJ?=
 =?utf-8?B?ZFU0SkxDZVdyR3BRUE5SeVkxbFNtUkNvaTJKRFFreTMvTCtFUnNGenBBV3U4?=
 =?utf-8?B?K1ovRUFicTRVVFhUcjh3L1RrVm5OcHE4TFRKUjVEdXVoL2ZLUDFFa2ZiOUk1?=
 =?utf-8?B?Q2xOMGx2VmJqZk1HbXUwUVJQM1hGb05Vc09EZ1FrL2UzZFRNVW9nbnR2ZHR1?=
 =?utf-8?B?M3k1dU0rbWtDOEJkYVNER2JTQmFDNlljTHo3ZVlITyt0cXcxZFIwNWZmZUJS?=
 =?utf-8?B?YzlwdEh3RmJKRE96ajd4YTFsTjJnK0JuVzM1dFhjQXZTdCtZQWYzQml3S2Rk?=
 =?utf-8?B?eVZNVFlsVEE2MitBSjloTk90UWtVd0Jncnp3RktjWEFmb1Z2ejFjZjdjaXdJ?=
 =?utf-8?B?bGgwNjZnOVpNTWF1c1lTRTRIQVFLcy9JdzRNRHFDUThJYVZCMFlYdzhSVFNt?=
 =?utf-8?B?TTZWcG5xT1psTkovY0pCYndDeGVERnJUcHFNdmw5Wk5MaFVRTk5xQUlRRzdB?=
 =?utf-8?B?dkd4WHJNL0Q3S0N1K3ZsY1hMRUxCV0ppNXhBdk83NGo3R2xoQ04xNjFNYytO?=
 =?utf-8?B?b2tUWjVLYUU0SXR4UUtJSEczTWNGUE4rSUZmdE9NaW12SDJtS0RqVXhOWFZF?=
 =?utf-8?B?ZWxJNTQreFJEMlVmaVR5T3k0bDVxM3hOaUV0SFZXdVMwQ1JGODNlYUZZUFNR?=
 =?utf-8?B?S3doL2x2SDNBSVprQ1NaVzRsUitNY0xETzk1UWFYWEVSMWFteEJrK2Y3RnQw?=
 =?utf-8?B?L2pCZi9zYjQzUkFxK1k5RHd3SWF4SjFrclhMWE0rbGM0aXFWcjdWanBKZ29Q?=
 =?utf-8?B?amI2QXVydFY1RFd2cmRBVDA1RHB6ZUd1ZDRkQlNrb0JJOXA2aXZiVm1XdUFx?=
 =?utf-8?B?akQ1c2JHK1VKamNuaXNpbDZtV1NjZ3pjRXdvMUdLY2dNeWdrN1ltNlE4ZmVD?=
 =?utf-8?Q?4BE7qkkCD4jqulTca8oinUGEi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2077ab-8588-4fa3-3bbd-08dc91ed8921
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:27:37.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7r2Cf1gx3u7knY01ib84ba+zQEWSVHEOeJ/fLEmUPwca84nAg5N1iAKGrcYKwzoQlPsT7GSZvFG9jcEi76iUrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6795

From: Peng Fan <peng.fan@nxp.com>

Preparing for assigned-clock-rates-u64 support, add function
of_property_for_each_u64 to iterate each u64 value

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/of/property.c | 23 +++++++++++++++++++++++
 include/linux/of.h    | 24 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 164d77cb9445..b89c3ab01d44 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -548,6 +548,29 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 }
 EXPORT_SYMBOL_GPL(of_prop_next_u32);
 
+const __be32 *of_prop_next_u64(struct property *prop, const __be32 *cur,
+			       u64 *pu)
+{
+	const void *curv = cur;
+
+	if (!prop)
+		return NULL;
+
+	if (!cur) {
+		curv = prop->value;
+		goto out_val;
+	}
+
+	curv += sizeof(*cur) * 2;
+	if (curv >= prop->value + prop->length)
+		return NULL;
+
+out_val:
+	*pu = of_read_number(curv, 2);
+	return curv;
+}
+EXPORT_SYMBOL_GPL(of_prop_next_u64);
+
 const char *of_prop_next_string(struct property *prop, const char *cur)
 {
 	const void *curv = cur;
diff --git a/include/linux/of.h b/include/linux/of.h
index 13cf7a43b473..464eca6a4636 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -439,6 +439,18 @@ extern int of_detach_node(struct device_node *);
  */
 const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 			       u32 *pu);
+
+/*
+ * struct property *prop;
+ * const __be32 *p;
+ * u64 u;
+ *
+ * of_property_for_each_u64(np, "propname", prop, p, u)
+ *         printk("U64 value: %llx\n", u);
+ */
+const __be32 *of_prop_next_u64(struct property *prop, const __be32 *cur,
+			       u64 *pu);
+
 /*
  * struct property *prop;
  * const char *s;
@@ -834,6 +846,12 @@ static inline const __be32 *of_prop_next_u32(struct property *prop,
 	return NULL;
 }
 
+static inline const __be32 *of_prop_next_u64(struct property *prop,
+		const __be32 *cur, u64 *pu)
+{
+	return NULL;
+}
+
 static inline const char *of_prop_next_string(struct property *prop,
 		const char *cur)
 {
@@ -1437,6 +1455,12 @@ static inline int of_property_read_s32(const struct device_node *np,
 		p;						\
 		p = of_prop_next_u32(prop, p, &u))
 
+#define of_property_for_each_u64(np, propname, prop, p, u)	\
+	for (prop = of_find_property(np, propname, NULL),	\
+		p = of_prop_next_u64(prop, NULL, &u);		\
+		p;						\
+		p = of_prop_next_u64(prop, p, &u))
+
 #define of_property_for_each_string(np, propname, prop, s)	\
 	for (prop = of_find_property(np, propname, NULL),	\
 		s = of_prop_next_string(prop, NULL);		\

-- 
2.37.1


