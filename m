Return-Path: <linux-kernel+bounces-307696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA2896519B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8908A28673A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E111BAEE7;
	Thu, 29 Aug 2024 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jVc04ghb"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C151BA863
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966107; cv=fail; b=pfDLUVvY+EG+c1j1vTiL8G8RpZPqq/gLMOFeO9D03SviTbxDpIetLrc8g2u7B83jK2rxeeUovRl/HvPC1tpGk5Dq5QtM+ooj+dBmK/u+uHSRqWsVAOK8gOcwerwiQohl5N54O18MMOyHdMLyQ3Mr52oqHGFLi1/ZXvwg4eNsAaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966107; c=relaxed/simple;
	bh=uz6xhxIxIAnIyubwtBkXjuhhwkKj4UjgCJHpQO5eyaA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=APkPWmT243k9Wr7JJxezgneJwih8x6HVGUPaCJvt1zCRQYG/0wqb5t3qkY0MHkhnbJhURye/lXmXyKfNqFY/sZ4r9acScGQFLSXekPXFgiGNcsFSr2joqvoSQigUIhq75no59iVakx0+9It5tUxsM2ek4VBuDOBbkFdf2a/yL/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jVc04ghb; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFpgBnIlXQhRVmHvh8crKs7ji8VfLZsCIcqnzCKkJoEo6JIcoVO8QoLp0l63A6tjIZquI9cdJ48yhHbf2QO+oQtlPE3S5wA3QTjXIoRzfen6gLgpOmOVya1ZQ/jePENZgGT/4XkA0upf51cJcpt1SkGaOfHIJsR1QRj+GYgIXckTkdPTPb9RYlTTRBlhcZSMJneDs742IvoWWk3+ozZdE8A5DnvbuTEAOnTjkF/a/+GavhQhAd2HBCOqcyQyGrTXq5WRdZtqss7/WOIc5XPXFs0ZsuwDL/+7uSMkYWrB6FLOm95GMt2lZCMM4LBcHqjzgFgyjWr6Df+YCeJQ9b+BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy77LfzIZBFz5cAmmQqERugeCp1CMhNFr8Kv8JBCwYE=;
 b=kaYJ7g4G+HQm2J3k5jZBazBJaJdXdmZd2eaDWSkTR3mK85N9bFGsReFGl8F4Uh5kZ+pcr9w64AP2OU4746PtV5t5G4PquF9j603vAq7zitSC9EmhtlyW3TTxzVa6MrruLcH0URGHXIolXFz39gri8y5vAEuaAPq6EtifI2VBbQ6Xpu4uBX4IHHZBGET47jHD9y4fA6e3JveNVtXH+QZNffW8ppzUnFI6vfY9cU42Ol/aBRORxDXbl1C8q9YbkH0i4RfwWtwYLUQVI3l4edCihg+gNHjCJlH5+1XT+HofMeziODfRJ7DT/7vQnnQe5qSEH6e1ievDsStBX2hes8Ipyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy77LfzIZBFz5cAmmQqERugeCp1CMhNFr8Kv8JBCwYE=;
 b=jVc04ghb6puuup0n/oK65RLio9X9t8KiC4XM4sYNUDCNA+GDNKT8swuw7KosDU4hJhKYTkFnBCJJGOXs9TtUKYQgXrpimQuUKAlBdwLfh1KxM/vEIjsPtl0GolZYkSk0g4jfYElms2fyZwNdMVoTCNF8UXNYAONkUeNLtLBb+s2HPgG9JrjIfhvheGzX27DclEQxVOAcpCDbImLgBA0c1L5ZsdlK9vk/kVTJYF6QpbqsxL3WRDg22RUwMki60TlohNFTrwo26A5i0juWsjL94jwO3k8KZePBlyPOmn8EtYYU8EFVl8sSNsKn3H1CA+WIm6WSbA9G3TvFsLLCYPNU8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 21:14:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:14:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:14:01 -0400
Subject: [PATCH v4 04/11] i3c: master: Fix dynamic address leak when
 'assigned-address' is present
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-4-ebcbd5efceba@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966082; l=3667;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uz6xhxIxIAnIyubwtBkXjuhhwkKj4UjgCJHpQO5eyaA=;
 b=Roesay8np1PbKxGrXQ3hkNHYDpTVwaMlAy/eHLfxCBNNfSp5d0Pg8m5UwsvQ+rxkiVaEkXloc
 B0twHo4kYo4C+ZRYex1qK4n+YjFky9AWA9Wk2fUZypDUh6aT+yZfXJD
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
X-MS-Office365-Filtering-Correlation-Id: 9806d1f2-0fc1-4719-2e36-08dcc86fa3a5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TW5yTVNrTjlScExVbmFhdmRQNysvdHlsMlAvNVlTMFkvV3ZwS1pyQUp4UkM1?=
 =?utf-8?B?ZlRRSmVUU0RxZVlvQ3BQNDRnQ0RYa1FuNDN5YmNWNVpVMnZrVGlMM2Z4emVs?=
 =?utf-8?B?cVVTTVBjbnEvQlQwaHNEY0t2c3hpN0FOTytoRzVWVnl2TkRGWWR6dnhWU3Qw?=
 =?utf-8?B?QmVXc2JNRmdRK1gyQUJjRlE0MGoxNzJSRUh4VGpoTUdrQjZtWGRpTTRyaDdH?=
 =?utf-8?B?a3lXLzhKdjl2Rmg1UzJRV0hvZU9IT1M3OWNKMzZPT0NhK05UOUU1MkhsT0NX?=
 =?utf-8?B?dTVERi95NDlEcU1RTkpGOE1WOTV1TFd6Y1NmWlNtcm9IdmNvUXkxd2xLaitJ?=
 =?utf-8?B?VXM4dzJkdVgraTNpRXlmN0NUT1FoRGpNRVVRNkQ0alFtNGFhQkNYbGRXU2cy?=
 =?utf-8?B?N2I3NXZueTVNVHNEYzN5L1JsaW41NEZSRGdRSVk5VlhIN1ZOdjZjN1lCM3Y5?=
 =?utf-8?B?L1dodEZLdjY5d01XbXVvTWJTYzN5WEpkOW5zdE5YMHQ4MWZEZXlhMUlZSW5k?=
 =?utf-8?B?ZWdlcVlXUm9zUVN3bTdFeGdycm95REVrc3pkUmlMb1JyVUxDUnI4eWVhYXI5?=
 =?utf-8?B?Wm9KSU1nQndLdjVEVWZxNGd4Kzl2Z04yR2VTb3lQczhkdS9ETHRyUzluV3dG?=
 =?utf-8?B?Y3hobzViOW0wdmxXcTlyc0hhTXlyZzBZZjV2Nm95b0JXelBzNGY0bGhWVDJ3?=
 =?utf-8?B?bm9EUmtJWkI1cWtSWkNHV0dDLyt5ZkpidmhBcDN4THdMSVM4RE9aY25zWXFR?=
 =?utf-8?B?ZzBaTkZtcHhZMXM1REhZeW03ZXFiUEFqNmo3OHQ4VDh6djl5SndIYUhsVGly?=
 =?utf-8?B?N1V3RnRNSTF1OGZkd3dPTWhEemtvaFNMNE1uWWpBc0svY25yYTJJK2Z4RVJh?=
 =?utf-8?B?WDNSUy83b2RwUFlOM1huNmdvT2FrY0JwT055M1hhRDR4bU5WazVFQkc3bDRr?=
 =?utf-8?B?UE5UQlhrdlNUekEzaytzRno5aUxEOUc4OFJuU2ExNHNmZngwdEwrSjljOWE4?=
 =?utf-8?B?bzBzeU9vZzNVb09zSm9MUkFiUE5PRlJtWlU1Tm0rQWx1NG5BK0gyMmkwVnJl?=
 =?utf-8?B?VkJGNkxUczBhVlVadWVXN0g5YkU5WlBoM2VuNm1KNU1iM2p4bDFrVFl3NW11?=
 =?utf-8?B?emNsL25VeDhIUnJZbWxCZ3ovajd0a3N3MjFlbWhUSEZZV3ZSbHZXWnVpY3lD?=
 =?utf-8?B?KzNtUVVoYW1YWFpxTU9VWVJjdEt0eUJXRnM0UnJFaHduczdwSlFuVXJ6dVBD?=
 =?utf-8?B?WFJjUkRzeHRjOG9qcjh3QnRweHN5WWxtRHNnbXhQTjhDVy9jVFZEUkZvY0F2?=
 =?utf-8?B?TDBIYzVKdi8xYUkzUDFtY2NPUFIvbmp3Rmg2SjRDbXpUaDJ4T1hSTDNyMFFu?=
 =?utf-8?B?eE5LSjZuVmhJSmdpRGxIc2tQeDRuYWVOSHFTb2tvdG5JNUNlTDVQU2tlSDVY?=
 =?utf-8?B?WDNBSW5FUXNTdDg0Y1Y5Vm4rNEE5NmFobnVFRHE1WWE4Znp1K2RXbWVSZSs5?=
 =?utf-8?B?TjRxYlhSZFJnM0YwektTR2xoOGNacG9Nc29wZUxLc3N0eFEzaGR1R3U3V3Q0?=
 =?utf-8?B?S1Z5cEc5K3hwSWEwdyt2ckhMUHFJbDJOZ1ZzL0hWZHFYVXBjOXlodExIK2lW?=
 =?utf-8?B?bzBrVGtqcDBXWkVXVSt0d2RCQkJYeUJQQlFnMXlYZlNWd3lENUYyODVnUHQ2?=
 =?utf-8?B?RVhyZzI5RWsrNmY1ajFUTitvT1h3QnpMSjc5UkVKMTN4UG50dnhwS3BISlo1?=
 =?utf-8?B?cVI0V0UrampWSjdwT2J6aml0aXZ6ekN3Nlh6SlBLWnpMbUMzaVJ0U2lIV0g3?=
 =?utf-8?B?cjQzZTcxZXhOaHpmYkRQTm1yVVhhelZlTTBGT3dpdWhUODNBV1lpMnNZbDl2?=
 =?utf-8?B?SW9xT3BITTdGT3M1anZXQzdIWUtSanE1SllZcHc2UjdWR0E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VHIyNDF4a2FwZVlwMFN1NnpvZ2lZWlNPSGRpTXVadm1YL25aUjB1dThxWng3?=
 =?utf-8?B?dDhFUXFNdWduK3ZtbXdveVRCMm85MmtWWnB6VmNYSnUzbExORjZPd3ZFbFBm?=
 =?utf-8?B?Sk1EcG5ydGRTNDZxRDdZUkVDdG9yRjByRjhxbUZYSml1alZLcGtUM08rQzNZ?=
 =?utf-8?B?b2xMTVlqVWRkdEtrTnNSbWEwN294RHVzNUhMamhBNVJTNUlBQTdKUzFjNk1J?=
 =?utf-8?B?NC9ESkpsYVRrYnJub3I1STNBb2lDQ1Z0ZjlnOHZOc3lUUmZqek80ZE03TnNy?=
 =?utf-8?B?dTlSRmsyVHJYU1BFTzZHRFZTaUppSHlqUlNXa2xCT3RzVmJWaUwycWNncjIw?=
 =?utf-8?B?ZXBhTTRzZ3A5bnp0MEVNbUhLei81SnpYVlVWU1pnSFFOUVJPaHBuNVIyYWNq?=
 =?utf-8?B?dWw2dytNYXZabStiTU5jajcwSlYxSmQ1VGF4UGZVdmdoWi9WcXczTzY5QUN1?=
 =?utf-8?B?WVlHMllTaUFOYVpkSUdvTnFDTXF3dHc4WnVRVnNJZ1BEU0o4cjlQY2JmY0gy?=
 =?utf-8?B?enRLWmlyV1NUeGtyYk52QTNlN1Q5ak9xMWxUVGJGOC92eWJZVXJNL0VEcHlp?=
 =?utf-8?B?Nm45a0ZmOVZGczVSaXBpdGZnRzN4cEU5b2l4akRNSlNpZ2ZwQkg2NnVSL3Q2?=
 =?utf-8?B?TjIyYTNqRDBxVEdpZE9lL2RHVTV3dC80ZWt3ZllZTHpoTnE0MWQ4VnduUUJZ?=
 =?utf-8?B?T3pFN01Sd3JaV21NOVg3ZTIvSytnVU1DODlReThxdzFkOEZHTE94WGw3ZzBu?=
 =?utf-8?B?NXovV3RUVWg2WnpEN0U0Q2czV2ZkNisySGhGYlhnZXl0UmY2d0RtaHVyQnAr?=
 =?utf-8?B?NTlUYmpMWXU1b3pKbklvdGFwM2FGQldrcjMvd2xJYVR5aldSSEN6dm9YMzJQ?=
 =?utf-8?B?M1NLak1HVGtQTmIzUTIwSEpRMTdVeU1qU0hFSlViNEh1OUtjTi9WSnhkNndC?=
 =?utf-8?B?Q3gwYzIydWhJK1JIN3Brd0pteXhyc29lZm9jTTZYa3VURUN4NUFtK3dIUHNY?=
 =?utf-8?B?VFBqOWh2M3FRZ01tRlg2WHJIdlhkeElDOERDQXhWL2VEL2MzaWZqck1RRGpy?=
 =?utf-8?B?QUVuQUd6dklBWHpBT2x1T2JxeVk0WVpHVEVpb3Exc1NaU3FTV2FjREhORFBP?=
 =?utf-8?B?SW92TFVGU25waVRVdVVXM1pjZlNJK20rVG1WaWtiK3FzVzVpUXZPcTV6Yi9W?=
 =?utf-8?B?WUhZUysxSnR2WXd4Z290S0dKUEtLdmlrT0x2YTFXaXdiQXREQXRKd0wxUXZi?=
 =?utf-8?B?OHZkYWlrVnh4NFJveGYxc1ZpenJGdXVvbFRVbXBwbSttRStLV0htMjFhZzVI?=
 =?utf-8?B?RWZ6TFUyRTd3d21SWCsxeUkxSmxEMDZQRnIrWnY4STcramlsYU5aQkM1MVZS?=
 =?utf-8?B?Z3NKWlpjaWtLOGpORXBBZmhwSUxGdDdaSVFkUjlEeUtHb29tR0tGbUxyQU9k?=
 =?utf-8?B?cnRENWxjeEZqd1FlRXdPWVV1eFkxQ2UvUVhDUzE2M2JFOVRKRWR4OHpxeHlk?=
 =?utf-8?B?dENHU2ZKenJCZ0k3R08vL1hpZlJVVHd5WHN2d2VJL0JzSG8zbEtrK2t2ZUVZ?=
 =?utf-8?B?Q2lKcHNCZTRCS2QwVTUyanpEWWdkSXJNUFozSUp5Y0RzbzZEMVpBM3RTbjBK?=
 =?utf-8?B?d2xSa3Zib0M5ckhDbXlWTUdqYmZzN05EMzU1SXpLMW81YTRaN1JKWHhpK0JT?=
 =?utf-8?B?Q3IyZWxqSHN4aXNORUVWdEd0WWRRQkEwTmhMYlo1a1ZGSWFNNS9IRHFXSlhC?=
 =?utf-8?B?RW1lWXhuaHpQWXBUUi9UbVEzWVhNTUZVYjdKK2RYOTVSdHMzSHFlWFR0RWFU?=
 =?utf-8?B?TTNoL0dDU2FYZzE3TXVFQkN3R0F2Qmd0UnZ0TTJDUHNqNWdIYXlwY3g1WmV0?=
 =?utf-8?B?R2c5YmFGQ1cxb3VtY0hJS3A0b1RyUExSQWl6SnlIbEU1aUVwWTcxdmlOU3h4?=
 =?utf-8?B?bXJLNStHZDEvZUV2V3JWcTc3cjFFOHVWWHFJdGpxMVpVV3ZiSEw0dUlncERF?=
 =?utf-8?B?NWpENkVPTGMrMEQ1a3RyR2pJOEl3QURxa2lnVFdPeG80WER4MTNOMXZnNUhz?=
 =?utf-8?B?elJsMnJvTWFoMmtiT3YyWkVpZUx5R25qdDRDbjFHbkdtL0hNTG1WYXZ3WmZz?=
 =?utf-8?Q?2UzEVNiVOLtFHDqs6vdbW6hHS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9806d1f2-0fc1-4719-2e36-08dcc86fa3a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:14:59.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3H+cQ05VSbFTM2aCD5eqJKa18/QlW/lTXvlYtRgh4z+cfcPanplvi+Gnd7UZxCR5QGOPGxrN4rDES9IOVs+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560

If the DTS contains 'assigned-address', a dynamic address leak occurs
during hotjoin events.

Assume a device have assigned-address 0xb.
  - Device issue Hotjoin
  - Call i3c_master_do_daa()
  - Call driver xxx_do_daa()
  - Call i3c_master_get_free_addr() to get dynamic address 0x9
  - i3c_master_add_i3c_dev_locked(0x9)
  -     expected_dyn_addr  = newdev->boardinfo->init_dyn_addr (0xb);
  -     i3c_master_reattach_i3c_dev(newdev(0xb), old_dyn_addr(0x9));
  -         if (dev->info.dyn_addr != old_dyn_addr &&
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 0xb != 0x9 -> TRUE
                (!dev->boardinfo ||
                 ^^^^^^^^^^^^^^^ ->  FALSE
                 dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 0xb != 0xb      ->  FALSE
                 ...
                 i3c_bus_set_addr_slot_status(&master->bus, old_dyn_addr,
                                                     I3C_ADDR_SLOT_FREE);
		 ^^^
                 This will be skipped. So old_dyn_addr never free
            }

  - i3c_master_get_free_addr() will return increased sequence number.

Remove dev->info.dyn_addr != dev->boardinfo->init_dyn_addr condition check.
dev->info.dyn_addr should be checked before calling this function because
i3c_master_setnewda_locked() has already been called and the target device
has already accepted dyn_addr. It is too late to check if dyn_addr is free
in i3c_master_reattach_i3c_dev().

Add check to ensure expected_dyn_addr is free before
i3c_master_setnewda_locked().

Fixes: cc3a392d69b6 ("i3c: master: fix for SETDASA and DAA process")
Cc: stable@kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change v3 to v4
- none
---
 drivers/i3c/master.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 1dad727e28435..7c8fc4378b979 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1556,16 +1556,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 				       u8 old_dyn_addr)
 {
 	struct i3c_master_controller *master = i3c_dev_get_master(dev);
-	enum i3c_addr_slot_status status;
 	int ret;
 
-	if (dev->info.dyn_addr != old_dyn_addr &&
-	    (!dev->boardinfo ||
-	     dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
-		status = i3c_bus_get_addr_slot_status(&master->bus,
-						      dev->info.dyn_addr);
-		if (status != I3C_ADDR_SLOT_FREE)
-			return -EBUSY;
+	if (dev->info.dyn_addr != old_dyn_addr) {
 		i3c_bus_set_addr_slot_status(&master->bus,
 					     dev->info.dyn_addr,
 					     I3C_ADDR_SLOT_I3C_DEV);
@@ -1956,9 +1949,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
+		/* Not mark as occupied until real device exist in bus */
 		i3c_bus_set_addr_slot_status_ext(&master->bus,
 						 i3cboardinfo->init_dyn_addr,
-						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
+						 I3C_ADDR_SLOT_EXT_INIT);
 
 		/*
 		 * Only try to create/attach devices that have a static
@@ -2126,7 +2120,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	else
 		expected_dyn_addr = newdev->info.dyn_addr;
 
-	if (newdev->info.dyn_addr != expected_dyn_addr) {
+	if (newdev->info.dyn_addr != expected_dyn_addr &&
+	    i3c_bus_get_addr_slot_status(&master->bus, expected_dyn_addr) == I3C_ADDR_SLOT_FREE) {
 		/*
 		 * Try to apply the expected dynamic address. If it fails, keep
 		 * the address assigned by the master.

-- 
2.34.1


