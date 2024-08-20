Return-Path: <linux-kernel+bounces-294156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23882958A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D85FB248BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD2192B84;
	Tue, 20 Aug 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CYj9lVJW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013059.outbound.protection.outlook.com [52.101.67.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE718E756
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165127; cv=fail; b=el8i4IIR3sovsCwzUnXah0GRzZQaeErZTKPtGXIFUQQWMbaTKAdzBPGxgf0TlnNmvX7413AI7zNCWD+/g+u4MSrpksIsuIBhiuOZgEU3NFPdDPaeBRRrUCFm4+Z6+G40te+Z/+t38Ow2mf47PVDeG9olxZHapRZkbhievPr2Vlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165127; c=relaxed/simple;
	bh=Tki3c5zCV14v2vEg8RkKCBdHdCh8vjjMGdjcF58CQgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PEJ3vFSXsYEpeaZ6dzmLO68kz7UnvSmt7YAzNBeuhDYArblYHKYK+0uB2izJv7jkRpPoJAvpFH7usXNPHBotXefALkS5pu3INegN1zX66eO43Z7om0rO+ROheYIFJhXM71VIrQ2WQRH8aKBV0RO/Kyh22BO2rsoYqoThlzHEjHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CYj9lVJW; arc=fail smtp.client-ip=52.101.67.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKBo52IyajZPlDQsihZMxkYnW33z2tWQMJEuae8OWc7fMiMLwQNP3VLrPn+NZOWoErhqsa0xvj+i1WuFOIFWhY3cBhr25VUutnDgdLAvFJBTcRh98jnH0YQd3gXLTqPhHMRwgzc4SrrTQXCrvBlzAusbEPNpDPbGDuXaoFM6OFbdflxfUGDQ7FPsWa3/LvA7w/O0z/XsZFu3zHrqWXqqvNbioc4H4mIrCR3OBd05JxLcft9ShonYDlys0IZEdWMEpVwkHXPWZdDnLB7SGiDPSQKoO8/TwnfLfqBf3H2KD+EDCND+hdySg3RzCUhTM6AoSN/7yiVQ01NXFd/E5hLF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnHzpp4NZPSUYSiQttUzH+ovjxYq3H9S4wJNgxhHmJI=;
 b=h2ZQ1tEriiqoCgw18G7Q429e+LuD15izhd1Sj8Nnlpqsk0d4q5UrLiRoaKHvPDGrzlnW9nFbNKrm9hWURQpEbudNsIPhcxs8Ow3B9a9l2bm8OlSPLG27OxJg2270IIyEWUXx35QG2SMhy9D90NPDw9WLczdMP71nFiIH5g7YyXwJuPdJ2rakHdAawsJjDdkmTIAOrN+1zuwQFyiKfxSgGmybYr+NL27KVJbR3hjVGKIDJh85I7y3H46pSx4uvHdzZ7L2ZQ5Up2V7GGFoMy0dThgedrVHywjSVHJsOwNADkUUkm4XgoIkaLbbyIXqAIosxJVhEBwWxqZpcWRT2WWHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnHzpp4NZPSUYSiQttUzH+ovjxYq3H9S4wJNgxhHmJI=;
 b=CYj9lVJW1KBp1QFKtwsSLrF2bPpCfhQoR1lsc7uNvjrWJBFR4q6vMI84t/1NQoejaeXZTr6TYzM/EfBEN24KY2QTsm0eeWa0/b3QqYEqjIo2rZjeDVFmcMiBsgYH5dkS7rVIMTNHvwcKKa6NrEf2v97DUZ4lRGcDZUEWsfsMktkPKPLVrPUqTlaOBKc0jY6Mo4hHiOr0CmibnFu1vlKM+vhQoNPO9jWiIhbKYy6KH2lvdXfGRCHJwshOeiprqR1JowFxY8J5k9rXDsXVBU5wLF4B4DSNT3dfxFBuEtKQIGmN0GRLl/875QqbQZn8/k3s3mUTi1mniAceZ2zY0z++Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6916.eurprd04.prod.outlook.com (2603:10a6:208:185::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 14:45:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:45:22 +0000
Date: Tue, 20 Aug 2024 10:45:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 01/11] i3c: master: Remove
 i3c_dev_disable_ibi_locked(olddev) on device hotjoin
Message-ID: <ZsSr+vmyzcmQIN3e@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
 <20240819-i3c_fix-v3-1-7d69f7b0a05e@nxp.com>
 <CAPwEoQOXme+GofEhpXaBBmsyGJP-QQtLMJG45PTdNsSqFn391w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPwEoQOXme+GofEhpXaBBmsyGJP-QQtLMJG45PTdNsSqFn391w@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: fc76302a-9459-4f04-dbb1-08dcc126b834
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z3RvZUU1aUlBMHlUUk1PTHhCNmtDWTczU3ZPSkxsMmJDcW5qbmZHL3MvN2tJ?=
 =?utf-8?B?Zkw4ZlFnaDFjRWxUazRpMHhCNlVwVXpwUno3OTZDR0N0bDYyTkpJenFta2F1?=
 =?utf-8?B?Q0piVXFFbW1La1BkR1QrclZlZnJpS210L1gyV1NFWXZMRGgwNWxidWNiTVJi?=
 =?utf-8?B?eGdMTTBuVytOSzVMYW40ZEs1aHZHSmRJeFdISlJBdlpiZmtDL2JzNE0xbEpX?=
 =?utf-8?B?M21WWTVXc1dMdVBLUVRuWXJUV2o1QnJ5TkRGRmF4Z2F5K0JFTnM2T1U2WDJB?=
 =?utf-8?B?L3N5bTVYUWJYZDRFMklXdXhXVzA2VlpZMVVhUkpDMFJ4SlJQN2pHUklVVDYx?=
 =?utf-8?B?d21IRTREekNTQWJwbmdPeEVTRUJpK3F3anQxNWF5dkdjazZOeGtoQWs1Y2p5?=
 =?utf-8?B?RklEYjFmcTVMQXEyU2t5Z041ZGZvQUJodWErMDdwVG01bFhGa1NqbktkaDBT?=
 =?utf-8?B?S2hEd2JkVHdVUnFjQTR0RkYvVkJMcTYrdE0zazlldFl0aXc1WHJ6UUFodGpZ?=
 =?utf-8?B?MEhRUUQwdmlhdnRNcktZME0rRlp6ZERVc0gydE5OaE5WWEJ1dVlOTy9PWit1?=
 =?utf-8?B?WDVzWTQxVnk1WDl1MU5BWU50dmNHQ1YwS0syQ2Y3Yk9nQTV1QXZoMFBCNUZa?=
 =?utf-8?B?bmx2STZKZkpUKzNsN3NLa1lrTFM0T1ZheHZkQkRyM0JmeUV4QjZxd2M2V3l3?=
 =?utf-8?B?eG5nZzhLT0dHbTBGdlBOSFIycHlneUZvQUFVVEltMXp6VHZWWUQ0LzVMTDZW?=
 =?utf-8?B?eGlrTXJ2dEdQZDh1UGMxcVNONzg0OE9yTTZxY0NSRldmNVJrZkoraHM3OUU4?=
 =?utf-8?B?bFJQNWlaMjliRkh6MytRK3RUSlNQSlZGSTNKTzkyWTFGeU9RRE5Hek1OWkxy?=
 =?utf-8?B?S2JpclBqY1BQdk9UdUJicFVzaFFZYkluNkwzc0pMZnRoTjhrbXNRTC9wTFZx?=
 =?utf-8?B?VjNBS1RCUnFQVmU3bkNUcnMvZUFlRElTcmFvZUNuWGlkbVB2Si9iUjZ2UzIv?=
 =?utf-8?B?VE9weVpERUczbzRlajFEZmtzREdaeE1XYmpDSzd6amVicUZ0ZGwybVVGY1FC?=
 =?utf-8?B?SXFjRWNFTngrRndPTXh6bkJrZ1l1RVJGQzVLZklMZ284aGtQNjZHbkNmV1Nn?=
 =?utf-8?B?TkpYYytNdDAwRnFudVhZa2REZnNYZ1owRjJ1SDNRMEtCZGl2ZGdPYkNlY0ZB?=
 =?utf-8?B?SFgvOVl6b0x2aVhJYVpRTDdhQUVUWDZCV1ZhTGVXay9TWnRlK2doTkJQNmJr?=
 =?utf-8?B?VzJzOFBFZHBUTE9xM0QrSEtCbFJCdjV4UGZocGVUZ0hSd29MT1dQZFQxMmlL?=
 =?utf-8?B?MjBiOUtRTStseXhQNkFBTVh6V1A0R3BVaTRXQzM5SkdVRExDdTAzL2FIY1pw?=
 =?utf-8?B?WEtSUHRuZEdqMHhNOVNyWEYzTDdIekVzaCt0enA1czh5cVNnVTRRYTdsQ2Vh?=
 =?utf-8?B?KzNyMVkyYUxQVGUzQlY4cTlMOXRtaEwwanNVcGVzcmRVWUczc25PUTNkaUVI?=
 =?utf-8?B?RHc4VUcwMGsyQ2oweGtEZzVWTDRGTVN5NVZ0cnQ1dlZHMGIzSlVhblhLUlRD?=
 =?utf-8?B?dCtyM1l0ZUR3Q2VTY01aV1FGejd6bGNJekF2QzNhMWE5UGpSL1VIWWpVT3dG?=
 =?utf-8?B?M0RJL0lGMmhYQ2dxcTJxaXhEUlh4NXBNeVNxNW1lV3pCU0xjNnZZZzhJQ3Rh?=
 =?utf-8?B?RmVqQXNhNVJmODlXdld0cFFvRVdkMDNlb0trS2sxcXd0d25Sd0NLV1MrbVJQ?=
 =?utf-8?B?eEtkdWhVcG5sbUhYUk96bDdodDBhVW8zVnNlalF0b1hiQ0RubURsQzNFTlAy?=
 =?utf-8?Q?MkBT9okRB2Z/HZ3KRQaP/22gt7ktzSKofNoIM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bUFtL0JpYmwvTENkUWNOMDRnaklLUUdJQUYyTXpQYzdOTTM0akdZM1B4ZWZ3?=
 =?utf-8?B?eGdQQUdjeGhFMHRlWmQwMW1OYkJzMm1qeTVHOHR5OHJKZ21TSUVLdW9icWJn?=
 =?utf-8?B?VWRxaHFvS1lwMHhnU09aZUNVUDVRbzY4R0Uzak11VVplWUJseXo1NEhwdHgr?=
 =?utf-8?B?Qi8zTjVyZDU4Z3JmaEhCOGl6bGJpeWUxblJPUUFIREZhWjdhZm9FTktUSU1F?=
 =?utf-8?B?cWRxLy94OGZvdkIzOHRkQlkvVkhRTm9wS2tFNEdwUUVBNmN1S3pHTjFKRG9J?=
 =?utf-8?B?d1llSWFSdys2YTF5ZlIwN1llM1RiMG42VWNxaGV4M0ZSdkJLRGt0ZVhyZTZv?=
 =?utf-8?B?NThjRTArVVZaNGVUQWtwOTFmZDVZY0lQUnhaR3VCajJjUE1qZFlsSnN4NWtF?=
 =?utf-8?B?d2g4dEQ0cTkwWjlTWjhDSjN2WEZ2RExxYWFTUWdMUWttdFhKTkwxcEVCU2JJ?=
 =?utf-8?B?bHNTTkF4QVVOT2Z2WnE1OXhOUUxlRStpaW5xV1loWmxwR3ZQWUxIWkhwVzdO?=
 =?utf-8?B?TUdrczJqT3JTVks3N2pzcm05QUJZUGRZNzM4b2tGdjQ1cGMrUUhTUW00Q1N4?=
 =?utf-8?B?dndpT1FlcWNEcWU1MzlsOThBUXlINE1FVzZteldQWFNUdVVzVldNT3BFS0Jq?=
 =?utf-8?B?c3Zna05MQVdJdDBzeFViMmlTdFQ1ZG95NHFqd3lOWjYxS1VhbEsvUW5HeW5N?=
 =?utf-8?B?RnZrV2gvbWZkSXhpV3JwMUo4K2VTTlBDVzlSa2VRTWgyR3VkSUdPRHJVQ1dE?=
 =?utf-8?B?MGI5SWlkdzJkQ2dRRzZVUXV5NkF2SDIxekExS3VCS01zMDdaS2syV0FlMER4?=
 =?utf-8?B?eUdxZmNMK0ZtWFZGR1Q3ZEM5REpTMk1hUFFRR3EvcnI3S1V5UkZ6czZFN3g3?=
 =?utf-8?B?cjhCMmpXUGNKV3grRlorVGFQem9Zc0xSbyt6eFpsY25OR0tLSDN5VmRVeE0v?=
 =?utf-8?B?bk9NdUg0WmlGcjJKU1dQb0lRSFVNODh1T0xmbmJPbVRSZm83UVAxZVhYS0d3?=
 =?utf-8?B?cnk3RjBwTjdWMzJYaWh2ZS9CSmZWRDZNWDdlQjQvQ3V2K3RtU3VNRmlJZVB0?=
 =?utf-8?B?ZnZYdXRoK0V0UHUrdlJkb1htR3YzaExwNXVBRlNaSmxSczhvMUV0R1lnR09l?=
 =?utf-8?B?d0h2MVNwTUxCUmFGZGtGU3lrRFZVb20wV2NBVkl6WU9ueVUwajVicDdweDc5?=
 =?utf-8?B?L0x3SXdBTngyVzV5UHVzUDhEUHFKQStPM1ZReE5ENjZBeHd4S3B0WjFwOVRK?=
 =?utf-8?B?cmJBV2pZZDZiMWdCM1VhZUZNRGpjR200MUt1MkFOODNwemo4QXZpeXBKeEhM?=
 =?utf-8?B?ZzlLS3k5UHIydDV6ZnpjL05FbTVPM245VnRsNmVEQnVLeXdHVVI2WWQvNjIz?=
 =?utf-8?B?S2owcTV1ZXZ2YkRaUjAvVjBDWEtBaVNKR2NKcXFOQ0M0cmdGSnhqcG5naDB5?=
 =?utf-8?B?OTRXOFJ3UXE3VEpUUUdhZG41KzNkTndMOTNmcVRkL0MrcWxJTXhNVTRpcEg5?=
 =?utf-8?B?MXZndTJ2UFIycmVMdEEyWitGR0dPbWxhWFRRSmI3Z1F2MVR0azk1NENEak1I?=
 =?utf-8?B?RiswV095dmJndG5OaUtLblpGZzZPcVdCOTZQUG9wVXVMWWtXT1BzOGExNENu?=
 =?utf-8?B?M0FRT2Y0bjJBaFlmM1lCd2wxRHAzdEI0MUFSSlhJbHd5eGUrL2diUnFYSGk0?=
 =?utf-8?B?MC9XYzRONDgzOUY2cXpJZFlCL1FscDl3L0VJZE1uU0hVRnh6ZG1QTzNyVDFm?=
 =?utf-8?B?T2JxemRzdm5nWmI1c1dla2M3Q3Z2Y3FmVlhtcVRUUlZtbnAvMGRqbmFGOTQv?=
 =?utf-8?B?ZDU1VFo1cldURHBCMExhUmE5WFc5cTBadjFySTlNUVpnUms0TGsyM3hkVXBW?=
 =?utf-8?B?c1U0ZHQraVhQNkNvdDBoK1N2cEJId0l3Q0FuZkxFdHM4czVJQVRKLzd5STVk?=
 =?utf-8?B?VUVmbzAwT213OFN6bGpJQTJzd2x5N05JU0I1bk5GTnVYRFJDbGZXeWxRbVVF?=
 =?utf-8?B?NXJSU1BoQ3V5SjJObHIyRHorVUR5bjNERlZrNldtRktWZEFkVHJ2VnFUcDI0?=
 =?utf-8?B?QkIyQlFqS1JRRGtCM1N4SmRLTkVXamoyR1VMS0xKN21WaTg2NFJOVmk2UkEz?=
 =?utf-8?Q?OW5ToYchpg2F04xXek2bu+zDZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc76302a-9459-4f04-dbb1-08dcc126b834
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:45:22.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npPSB/ECdng3zrP7n0RwyWr5HcGcQ+RrRw/iah3RgH3d/4Vd93q+slIx/4X9/QDf/muQMYBAhIu/tc6CGfenPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6916

On Tue, Aug 20, 2024 at 09:34:11AM +0800, Stanley Chu wrote:
> On Tue, Aug 20, 2024 at 12:02 AM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > When a new device hotjoins, a new dynamic address is assigned.
> > i3c_master_add_i3c_dev_locked() identifies that the device was previously
> > attached to the bus and locates the olddev.
> >
> > i3c_master_add_i3c_dev_locked()
> > {
> >     ...
> >     olddev = i3c_master_search_i3c_dev_duplicate(newdev);
> >     ...
> >     if (olddev) {
> >         ...
> >         i3c_dev_disable_ibi_locked(olddev);
> >         ^^^^^^
> >         The olddev should not receive any commands on the i3c bus as it
> >         does not exist and has been assigned a new address. This will
> >         result in NACK or timeout. So remove it.
> >     }
> > }
> >
> > Fixes: 317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/i3c/master.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 7028f03c2c42e..852b32178b722 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -2039,10 +2039,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
> >                         ibireq.max_payload_len = olddev->ibi->max_payload_len;
> >                         ibireq.num_slots = olddev->ibi->num_slots;
> >
> > -                       if (olddev->ibi->enabled) {
> > +                       if (olddev->ibi->enabled)
> >                                 enable_ibi = true;
> > -                               i3c_dev_disable_ibi_locked(olddev);
> > -                       }
> >
> >                         i3c_dev_free_ibi_locked(olddev);
>
> i3c_dev_free_ibi_locked will still encounter WARN_ON(dev->ibi->enabled).

Thank you test it. The below patch should fix this problem.

https://lore.kernel.org/imx/20240820043818.3352614-1-ravindra.yashvant.shinde@nxp.com/T/#u

>
> Thanks,
> Stanley
>
> >                 }
> >
> > --
> > 2.34.1
> >
> >
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-i3c

