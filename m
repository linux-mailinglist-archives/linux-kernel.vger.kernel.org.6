Return-Path: <linux-kernel+bounces-374689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A29A6E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954BE28265B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF751C5781;
	Mon, 21 Oct 2024 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i++H4Dpt"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B481C462C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525529; cv=fail; b=kmyPM3JTQJBHRNYIEDqE7Wy210NhyKnhvo+taNl3py6+y4ZymZ00/iYXmz+OFCEZsHjH1E/OQjn4KfKnjpXb5qzuCnH647pQMMvN6KKeFfFdTmgwFJWM+KNuMtYG5KmZ/4SfXYcxEP3hhXEuzX0YJWEqCWtUISx7yZNgebdVnhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525529; c=relaxed/simple;
	bh=esXoixZSpbzjIDEWvvmytuS3RtOIyX8qdTSsowQdX4w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MzShjBqiIyoTYqOSuwKdPQ5IbAz+YLdeO0x/tjullYLVLzGGyVrsgHGS8JgRh2NqAl7xlWcDDXW2whsOF+gge4z7H3lCllxY/BtOejDsD3XOSveM18+PtIhzUd+jdgzaAgxi9rtP6OaE+6jY2HGKxuBhEEQDxjsOOh+zzeoKozU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i++H4Dpt; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOBMPRyXcvPA95BvoPzmWkMSybeV7g7sl53oudcm0I1viztl4jQRoglTCB7Qwj0M+S0+DsgVOukawmFWIPwFyrIjf1V0aZIs3x785r3SA1tM8yS9RD2M3kKWEQfKLHAfHku7ayT9GuvrkTohy/E7yUvFCC8RpeOzW8n9FsJmNB9m17TkSRcuVShgJd25yISyeahGCe7IdM1Kd3RTPYc1UsqZNUk6n9AZeUnsfcqnZitKd5bjSn0Euyim1kAdjT8EklnFjq3QWdmDTxBAvLj8lhEnelbcrw6QAWXLsCa9FmsCgvnIzlO8HEn31T0j871dF1SvE6cyzZoQ8xY7kINRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0YmqAjB45Meq1Bdun7KenPvmCCRCnUuYZU6Wf1cSQg=;
 b=mml+tMVZAWS/323rxiKSfMk/WY1Xm/oM7u0l9NndsXG1XZaFSODuQ1Pj30bMAkszefXfjh1uLq8LyIwo55kg5t8gDTPj1VCytk4sDGsXxp1dyqn3FG5W1DcDHgYlZaFe0DKVCl+EaouOxHXMs//u/NGMXzc3KPsoFvsWCS6QtrJB5ZHjIC6hiTXmFfMYoWYoHTBcBvcQjohYnZblX0Qwe3WqgMihcKRHgHhfrhu9rNsbQ/pObiOMTdlBp6jEg7gZJAiBb4RF37CH7FMKfgS19MD/L71xRAXl39Th3dKFhnB3ATs8JQy/TFIE4dwSECk6KWmwJ8CkhwhFsFsiDCTdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0YmqAjB45Meq1Bdun7KenPvmCCRCnUuYZU6Wf1cSQg=;
 b=i++H4DptPbqbvkPAPMXcTgMe19ArxpwJIKQ3WkmePkpKh0AeXeRu1xPQGVSfL0PvbqJkzdfxt9z9vI5UNmyYPEvhV8dOM9m5h2ekz7wkVxuYJOURMWGhmwcjU7F2IuEz7pJqc8GE28vn82mnMI2ukdVnnkKhT1qnIqgAWVyaUHFrMDybeRnO5bRN+RYt2flKdJcjUJ0VwNV0s9/HK3cDIvIYq/onIcUJNgVlfXnyFIG4Hhi6CTb2N9WAvOoAOFFEwYm0xd0clqzmbYc8KhEED1JbUtj4Nys7OpOFxSQYqzAHS4BMo0Uw9mOZar9yK33ETVfyqOruFNnTQuEAgPzaTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9058.eurprd04.prod.outlook.com (2603:10a6:102:231::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Mon, 21 Oct
 2024 15:45:22 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8069.018; Mon, 21 Oct 2024
 15:45:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v8 0/3] I3C: master: fix the address assign issue if
 assign-address is exist in dts
Date: Mon, 21 Oct 2024 11:45:05 -0400
Message-Id: <20241021-i3c_dts_assign-v8-0-4098b8bde01e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJ3FmcC/3XMQQqDMBCF4atI1k1xEo3aVe9RisTJqFlUJRGxi
 HdvdFOLdPkefP/CPDlLnt2ihTmarLd9F0Z+iRi2umuIWxM2E7FIII6BW4mlGX2pvbdNx42CtEY
 pEcGwgAZHtZ334OMZdmv92Lv33p9ge/+mJuAxV5XOpUFIqcrv3TxcsX+xLTSpI5YnrAImTSJVB
 RYC9S/Ojjg/4SzgQhEW0kAtE/zidV0/1eaqTiQBAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729525518; l=3102;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=esXoixZSpbzjIDEWvvmytuS3RtOIyX8qdTSsowQdX4w=;
 b=/8yCUkyCLfQDkIgg8Pg4ZoHTZkMwsEVQCReSV2S82ciD8A0Ii6Mg5bfmkfJGoW94vYxXFAm1f
 Q+UaMYVXeUaCfoNlpg4Ggs6eBdwam9peppd2SVi7kT71x0RL9aCqjZ8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:a03:100::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c9e608-0d5c-4525-6298-08dcf1e75f6e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TXNYaVErcUNPY0h0OWdMSWJvOUpDNnM0NGhFbnBIMDd3ZTd1bW4rb1Jsdlli?=
 =?utf-8?B?OEJRZFpUd2RzM0xTVXBDR0xGcG1LYVhZK2RYZzBwUjlUajdVcU03Y3pUNUR5?=
 =?utf-8?B?Nzl0RTJjckNIbXFKelZrTitmVzV5M1puL04yaFppNWZVN0dZWTAvQnp4R3Zr?=
 =?utf-8?B?MXU4R1BmcGRVZWtvNU1LaEtSdjFIOWxyUWJlUGJTdUVUVmxudSt6eVRYYlgv?=
 =?utf-8?B?UWdRU2oydVdnTG9jR2lIVUU5L0Y1QVMraXFPSmNNRjkzM3RVQ2JidXNndkJ4?=
 =?utf-8?B?TXc5dDc1am90UjlvaTJDbDI5MUJuL0VHaHlpSVVIUUcxNDgwNUJDcDNHck1y?=
 =?utf-8?B?WjhXQ255M2NaUUVhOUJGbWs2ajVWeE1OWnpWQzZyVmViKzFtL2dZYXYwamRo?=
 =?utf-8?B?aEUzTU1tODNpc0dlMm9HdkYxSHpaOUdtNzc2OXRHbms5clNVUzNMYk9NUUdG?=
 =?utf-8?B?dDNoa1JZN1Q3b3NOVC9BZlNHZHM1TllRdHpVRElXSXkxMXQ5Ulk1QnJ5VzVL?=
 =?utf-8?B?SzJoQ3RrMWRhWTFTZEppUkIxZXBlSFZJcVZnM0sxSnZQeXRRVHRBSzMxM3NX?=
 =?utf-8?B?ZkcyczlDbU8yYVdpRks2Q25XUERLL1ROY2hjMjFHZmgrc09tbWFWVjF0aHlT?=
 =?utf-8?B?cnFGMEhnOFZVckJHZlMxNTk4UDdTMDEwUmdtWEl3bkJrSWIzY2U4Vm94WVZQ?=
 =?utf-8?B?QytoVU5lc1hoRTZkMWhwVXhxajRLVk5zVTBJS3pYSXFXbzBMTFAvVWtwOURa?=
 =?utf-8?B?aGJtZmM2aWVFSFJJMHFzazRkb1JzNXlqQkFTR2RVdXlxK3FWN3hwdk9Cbndv?=
 =?utf-8?B?QkI2bFhpeExvbkZWSFdkcEhUUHF6OVcxenF6WGVhZ01aZE1JYjllWEV5Snph?=
 =?utf-8?B?bXBvejVoUGVHZS9XYkhNNTJUOVJaTXJJcmhpWXhsNVRMRklENitsNlVuVzM1?=
 =?utf-8?B?VSs1MDhwMTUxT1h1TTJCU2p4OU5qYjU3RG5EbXhYUHltT0ROa0RybDZXelNZ?=
 =?utf-8?B?UURrNnA2WVlsM0pOaVo0NXVMZElhSktUbTY2TUdMdzlIT2ZZYng0OC9lSDN3?=
 =?utf-8?B?OXZySXNPTlNGajF0L1NodEtKWjJxbFRVc1l4YjlMLzZEeHFDUzZRL1pzVVBT?=
 =?utf-8?B?TEE0YWRmdG83UDR3bjFUUVZrT0ZMY1l5TmJlVlh4YWxtRlE5ZGo1YkxFUW1s?=
 =?utf-8?B?N3prb2FKcGhmcXh5b3VHUVFEYWJjLzlOVkpKc3QrWXpwVGlmdlFySG1MUk1F?=
 =?utf-8?B?MndjTXJHNkhtdVpPRFNob1pvaVBGVVNkWURlNkE0dTdsZnYxeEpURUt2Lyt3?=
 =?utf-8?B?bU84aDRuZ1hhcTBLUEgxbmpybzJhd0x4aDBzbXptdi96VXR0Y2llTVMxUXFE?=
 =?utf-8?B?ZTBQRXJBRjNyN0E1RENzTWhYUExnUUtZMVRreDN6ZDJmcDB5UDZhUVdWdVlW?=
 =?utf-8?B?TkVjTzlaOXd3L3RFSy9DUFFENkNNdUl3T2ZaeDN0MmtKVWd2VkxMRnc3cFRY?=
 =?utf-8?B?Y3NHeXIxc1pJcGM5d3VHQUpPSWZNS0wxNllzWGJVNkd0R1NOU0VpcDg1cGhj?=
 =?utf-8?B?eE1jcWFZb0tGb2lDV0g3NVBFUG1FcG9wRldsZDg5aUptMTRvM2JEb3hUcm9n?=
 =?utf-8?B?ZXJaM3VRa1pyTEVSNlpIYkk3WXBEMnA4eDNCeGlpQU16bFVLTFZjdHU5aFU2?=
 =?utf-8?B?MjBRY2Vhbm5kQVR2dlYwYm5oRE9NNDBxRWNBSk9LbW1VbDFiWG8yelpuU2ZB?=
 =?utf-8?B?QlNrNHpTWWF2aHd3bTRoYktiK2NyWjlvd0JTNW92aDFUeWtKYTZrU0pUS2tO?=
 =?utf-8?B?VCtWMFdaY2VraEJPWkhidjNwTVcrMTFZZW1WU05ub0Fkb3lZaGJ2eDJSZE95?=
 =?utf-8?Q?Zx33dhA8o9Kfq?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bWVhbnVycFU4cE1EUmRoaXNoWlV1WlREU3EwOXhRL2phbDJpenpQTXRpeXls?=
 =?utf-8?B?Q05jSUUzSW5XVFR3SjVGT3lYUWdQem5PaW5zaUJKR1RpMWUyQmRTS1ptNUZs?=
 =?utf-8?B?WnBFVUF4cEY2aEdPdXZ1dzdiUlM2ZFZXTmpQUFhzK3dNekJHRlY1T2svSFY5?=
 =?utf-8?B?QkdKRTV5S2diZmdkaWZuMTZ6MnpYMmpabjJPQjNrVWJnRC9ZWUZBZnd0OUJt?=
 =?utf-8?B?RmMwcThwZWh5RUtrQ3hiS1N4V3BkRTZweEoxUWFHU2REejRvMWZRYndJRTNS?=
 =?utf-8?B?MVQwZGgwOUdOUCtFdElmUjF0UGVnMmhSa0JTL2FWT1MxSlhNZnhkb21YdVJC?=
 =?utf-8?B?OVllNEQ0V0hYYTZMZlFJMGRGSWFRT0dPRFlxM0M5NXFvRFRrMldUOHIwQ0k0?=
 =?utf-8?B?bmdxdms4L0dyeXpmVXN5cGNFM1c4RGtKcExBczRmSExVenZ1bjQ4OHdUVnJS?=
 =?utf-8?B?blhHVEFURW9kU3lBQ0Rud2VnU0NzMkg5ZW5rVXN6Wm5Oc1ZVSkhkNW5qSkZo?=
 =?utf-8?B?MW5IbjdnOVdRNHYvM1JXVHR1WGVHTmplSjU2YjJ3ZFFkWENFZmpDNytIbDlI?=
 =?utf-8?B?dEtxazFhaE5IaFl0WFFoakw4M2tRcWpTdnFTbmJTOGdsek9SeUlRZ0ZPMDdx?=
 =?utf-8?B?Y2ZVYTVLd1pWVVdLTFR5eXRrSDlta3BIOFRzTzd6N2lrSXBBeFgrb0V2TkQw?=
 =?utf-8?B?U2VKNjRRcTZFa2tvVnJNdzR0bTRZNVRKRFJyd3BTQ1dQUnNVc1JROWUzc3VO?=
 =?utf-8?B?NGVrZFdRa2NzMkNHV1M5L25ZZXIxeHVONUkvR213YjFZYTJscDRnV1VwR3Rn?=
 =?utf-8?B?VVp1WERaemJvRGRyT0wzcU5jVmsvSlB6SGpGYWl2YWJucDgrQzB3ME92NElP?=
 =?utf-8?B?M2N1WVBtSkpkZVpST3VyOC9rdC81WC9SMWtuelJRcXZvRlBJVTlmSFZmTFd5?=
 =?utf-8?B?eS9BQy9sMk9zOWFyS1FHNktibnBkSXl2V051L1B5NnJkajlya3JNb2FCYlZU?=
 =?utf-8?B?bC9YVVpsSG1PNTlsVlVyeHQ0QkR5RFNzTFdYbVpSWThUblBQSlhGQzA4Mmw3?=
 =?utf-8?B?a0RkbG9XVk9XYkhmb1pISy9rK3hscWY2eXNtMUhkVWllNnJmZUFpenpLbm8v?=
 =?utf-8?B?c1lHSEw2dDA2YVExREE5M0RDTGhULzJMUkUyOUd3U2Z6K1M3NFpheGVBbC95?=
 =?utf-8?B?YUxiTWpOTW9TcWZBSG5iYTBwbk9iUGVlVm9oRWhZTWRydVBHL2RFMGF2dVFX?=
 =?utf-8?B?dVJSTGlJTFdpckxNVFBNOFpxdUZZMnVvVnZCZDFuK0pCdGFmY1NNUWhqTGIx?=
 =?utf-8?B?WFZnWUFuL3AyNCt1T0UwbWRkeHk3bUhGdUt5b212K3RZaFlkM3BDdVNONmUx?=
 =?utf-8?B?ZksvRTlrYm4rRDRDU2xPQVZhL0NGNThNc1lCYTJjcXdMS3IzY1B3VDhYb04v?=
 =?utf-8?B?ZFhEZHJpcEFtUjRjcVNmV2hBOHpCeEpsSTZBc1hSMFcvSXFoaUF0SE1HdDU5?=
 =?utf-8?B?amN3Zk4vcVZiWENxRWJvT3hiRjZ4Mk1jbC8vM0NKUXFqalM2Z2lBQnBta3Ni?=
 =?utf-8?B?UEFkZHlvekVGbnhuZEVCNEdxTmxnd3E4d201S0duOHBmZ1lEaS93dFFES2l3?=
 =?utf-8?B?TVVrUUkvY09XYmNkWU5xZDliUDlyOS96TW96YkFwMkNDQ1ppdUhyVXVGWm9V?=
 =?utf-8?B?UUFqblBDYlVCOSt5a0oyRWVORXg1QUNoNlpaSkU1SHNKNkRqVVQrbmpZeXI3?=
 =?utf-8?B?WjJ4L3YyRmlYOC92NVJUcUFXdHBjL1dua1FvNG45UU80T2xYUHMxcDRoWkpY?=
 =?utf-8?B?NThBcllNdGQvVXVoVS9RN004eHF5YlNqenZGN2FIYm1NMXhXeElHUzZXbEVv?=
 =?utf-8?B?UWU2eWhERFAzYnVCS1FyMmQwVnRTSVY5aWNBSEFRM1FReVhpZ2Z3cmFNZEY2?=
 =?utf-8?B?YWVub2toNUdIRU9ROHRQUC9HTUlYVHpWbE1ML0k5aU9iVWhIdnd5S296V0N0?=
 =?utf-8?B?SzVxSzltdGZiYmpNZGZpUWZZNk9MeitHUWxPU2FrL3VLd0xWZ3RmbmlPcUlk?=
 =?utf-8?B?Z3RRSDdsODJwWmw0aStZMWlnMlpQNlRXSTdxdWttNlZzMlJ6OVM0TTRZUE4r?=
 =?utf-8?Q?qhIUbL/TzJVFVueJwdtVzl6V1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c9e608-0d5c-4525-6298-08dcf1e75f6e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:45:22.5371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMI2KXeJbNdU9L1q5orkkop1im5IO0j07U9G3ve3d7BWa74HSB52DO5dEMxQFlfv7WVp6NK/Rprjxom/bCW0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9058

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
Changes in v8:
- see each patch.
- Link to v7: https://lore.kernel.org/r/20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com

Changes in v7:
- see each patch
- Link to v6: https://lore.kernel.org/r/20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com

---
Frank Li (3):
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_DESIRED
      i3c: master: Fix dynamic address leak when 'assigned-address' is present

 drivers/i3c/master.c       | 82 +++++++++++++++++++++++++++++++++-------------
 include/linux/i3c/master.h |  9 +++--
 2 files changed, 67 insertions(+), 24 deletions(-)
---
base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
change-id: 20241001-i3c_dts_assign-d615fc33cc1d

Best regards,
---
Frank Li <Frank.Li@nxp.com>


