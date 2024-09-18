Return-Path: <linux-kernel+bounces-332496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61597BA78
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526C11C22353
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99A9176FA0;
	Wed, 18 Sep 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="frkb6jfi"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FEF175D2E;
	Wed, 18 Sep 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653494; cv=fail; b=qcMNzUupFenQC4GDJMSXGAM87pRLA6owj7yrNrGlcBCf5FmvDzR3j9cIGMc7TI8grTRtdQL9Y28O9B245D8PEoDtDo/SO6tQQEJH7ObX7uUBY8T/gSzbYUqZ0XXK8RKpEwqawN1N0G+Wioc6GNPHcM8nogU9OCsroUnX+fzQeMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653494; c=relaxed/simple;
	bh=JcW3glokefz4QzVtMZzgUZZcA1+zsRLChoP3Rr9Hk68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nLjQgrREd5jGlJfFCquJDuKN+2/QsLEJQGsXG5dBB40Cx/OaEj/8KMT78sXELdZtkzht6XGpll0NeV3BZm5wsFt5qVG4FkhSoXBqV5cTEQL6osXNRuKmIOCT3Z5S6a2YKOj7TLMNRsAjNcU6yQHBQEKBDI0NGNUC2hzFMU4qgLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=frkb6jfi; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4I1lGM++PEhH+q844aU5ILTiqn/EGUKVJOZwHt3qhYHNuO3Cu2N2hKdIlzvabJue+X65H59pZa4pFF9ye9lqNjt1nhJmVVaYQMTOdfVb/kmdsLwLzzf2DVRasBB3SWY+TtQWBU3valRlWv8S9acPvFe608yEaV0OVxXewlH6rrORfy7cJuw8BGsn0br1//oNCeeyu4vmXkZa8ibDLoIHFqdUy9+PrALRCkbrVkIZgawL3XYHDGvYqegDht7a30Tn+CLP6yBiC1t5g+XO/0N8me6KSMeY6yJGYiqdk03CCC+J27WPbAJapWHdspPKvy7CxAp8sfGcZK7hQECuQcF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t8aT/C2ZVzqhz6vqWslPL1GdRNvOAnYgk3jh4BH5uQ=;
 b=j/08qCX+SeFDSKpXOGpNNR7WdGuuKArBuRNem0ICoFeB9fQ6+oQJ0IzYDO3r2tTh1nkNMKH4+etUccOaYm0mh9bdDB+W7R6iiUjbmKewk9uFvGgbaH8Hciq9kyIXFXM6lHtPF+MZTNNFfzWQuee+EPgEBzFSIoPgSkBsMK6PCt8DZVjQQRKPEEra12108ufQeDYDiaeibX4tjNJd6+BAYYKKr921LgN1LIKgOIuL+2mcA/o2BuFRi1eVwpnjaujyIv7FnuLgA2vBON/WX8ky8ObY9yAdEOKDIqEtiytYte2N8oPS48SzpCywERj5BxBOZCQaaINVL2I5hvKe62mGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t8aT/C2ZVzqhz6vqWslPL1GdRNvOAnYgk3jh4BH5uQ=;
 b=frkb6jfi8lCxtWbG0piSCyPa1SoC2AyghpIt2D0CvM34NNgqwS1WotYu2SI1GZfLJUqOwSnRvAh/6PG55PBbV0jwi4YjEofnU+rA2quk4B2CTl4XLJfvEuEIkJ1MjGb/hsbfG0T/YILbRmAZ3tIi+6UEh34yAmrqAEiM/g1F09mun6ykKRM7Jt9aRWYEwmN0iJSYiztipEc309vCzssXE77QuD1vOpXkc5fZnBxpkcLb+R7rgt+hRRkXVLeez3TF5KPteK+tSrNlCEvVhWU2eGw9ElNinbdmuc7djrK/NVMZnUeD3J0VsvuBpwdsNOuuTanCZziUctV96rteN5WkAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 09:58:07 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 09:58:07 +0000
Message-ID: <6284ad03-bf31-4096-b62f-12fb888683af@oss.nxp.com>
Date: Wed, 18 Sep 2024 12:58:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: s32g: Add S32G2/S32G3 uSDHC pinmux
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux Team <s32@nxp.com>, Radu Pirea <radu-nicolae.pirea@nxp.com>
References: <20240830113347.4048370-1-ciprianmarian.costea@oss.nxp.com>
 <20240830113347.4048370-2-ciprianmarian.costea@oss.nxp.com>
 <f2660611-6f60-4913-8705-e99956ab23b0@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <f2660611-6f60-4913-8705-e99956ab23b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 929dbf09-6b00-4a87-95a5-08dcd7c86558
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXZFOEpPNVkvZ3pPQTB6anZNWFhkOWhhNFdoclpjTWxYaERmcjExRXp5Yzd1?=
 =?utf-8?B?WlBJT0JUK1lZTTVzaSsyS0pKY1EzUHA5bVpRVVlFRWtZdmliemgyVTQ0aU5z?=
 =?utf-8?B?S245MVJXL0lIQVRZRElXemhFZVpHOUdpbGZDVUNsVVpzZjJBSXkwWDk1MWhJ?=
 =?utf-8?B?U3BpSWpIZGFXK2taWlVYNERXN2svWGp4NzJweTVJRTRQMUZLV1hNbkV2Uits?=
 =?utf-8?B?Wm9YelYxYXFqdmg2Z3UxQ0ZWa0t6N3JQMmtoM3NHSVdPZmk4Q2oxT1FweVVE?=
 =?utf-8?B?NzlaMitndUhNRXo2dTZtcXQzUk9MZHBmQnFZUWNtZ1VWMGR2c3RwUVVVTzha?=
 =?utf-8?B?dzRyVm5YVXhDQXJSbUROcitGWEx3dTBjOFFNZzBncWhTWTNSZUxiRXhRV2Zs?=
 =?utf-8?B?Tmo0WXpValE5YjZrUXh3ZDcvM0M3cmxOdG94NVNGMll2eGJwU3I2OExCYzdj?=
 =?utf-8?B?WWVDa3hwQmo0TXZlUTVaOFh0NkhmbmtIMFJRQnRiSnU4NDdmaXB4WlZ1YlpU?=
 =?utf-8?B?NEs5YjJGN1NiMzcvOUthZ1VlalhEalpndFlVY21iblVCTzFMbUNSQnoxYzFJ?=
 =?utf-8?B?QlI2ZlBIOWlEU0NjbVl6Z2VyMmlyYmhnRGY3U2pxdStaQndzWUkrYWNlTE1G?=
 =?utf-8?B?US9nYlFuUjlzMVg3REhTVmI0ZFVrNzl2ZTIyTnRReHcwUlNVTHFIa2x3NkUy?=
 =?utf-8?B?ZTVSd1VQM1JJYzVGRVNzL2x6NHViOElUQk9JaGtySmVURkZxQkVMeEE5enha?=
 =?utf-8?B?NlMxYUpXR1BDUTlBdnNlYWFqS2V3dDgrWUR6NlJjUVRweVlETml6czhaTmts?=
 =?utf-8?B?VTBScG8vQlJHVzg1V1dORERSeFJQNUh2UVp6WlhMMmMrc003TEZyL0Y1ckFS?=
 =?utf-8?B?UDRCVEtiUVBWTm9kRkZkbmlhZDlTYmttbzRMVENmSCtrYnlMN01BVTIyVHFT?=
 =?utf-8?B?dnVvWTVWL3ZqOVVSM2ZQQTVheGpYREFjTEhrb01oMVdYNmZHeFVuWDZUd3Np?=
 =?utf-8?B?VGtCRnpBTlBDRldmaVRld1JnUFBURTBZbUZGSDdtNGVtOTd3UGxkeWg2TmMy?=
 =?utf-8?B?RWtMZ0UxVEFpMUJUanV5WWNFeTZCVGl4eTJCbVQzMU56d0tDZDdZbU82Rkho?=
 =?utf-8?B?RzV6WjkvUGFFSVN6N1NFYjJ2U1dXb3Y5Nmp0b1VadUt2cGJKSC9pYzZGVWpz?=
 =?utf-8?B?UEp4UENxVHk3WnBrTFNCVHQ4TEpnWmx4ME85dlAxMTlGL05KNlY1RVh5aHhQ?=
 =?utf-8?B?aFl5dkNOV3JZR2xJKzRYWnY3SUtxYTRNU1kxcjhNODFCOWMwWjdMb3FSd25x?=
 =?utf-8?B?andSbXJKd1ZqY2hZR0tUaEpPT3lJa1pRdTVLUlBZektqblltak1RSDZ3Q3Rr?=
 =?utf-8?B?MVVBa0NvQXlxWmJWc3lzY0M0d3pVSGF6TVppN1ArbVNDdTF1VTJ3QjIzRGVW?=
 =?utf-8?B?K2ErQ00wYUM0K2lVRnl6NjBaUXRZVUF1ZnJnQUdxc2VyakMzODhKajUxOHM1?=
 =?utf-8?B?RDJFd2tNWW1abTRLVjdLTjdOdDJaelY0dWN0ZVVkem16cVE0UTJtUFhaK0xG?=
 =?utf-8?B?dXEyekIyajdBTk5yb2pEOFFlY1ZqODM2dnpWb0pqQTZsNGNZTU5kNk5WRmVM?=
 =?utf-8?B?ZUpTRXlEaXJGRjB2QlRqU3FrNjQrN3cyTzRlY29Tdytlc1Fzd2h1R2poQTR1?=
 =?utf-8?B?NUFoVE1qd0RKVEVZeTVPSWlmUG4zUlRZa0krR1FEU0NaamE1ZXRvQ1V3SHZG?=
 =?utf-8?B?MW1TRmR6NjZ0UGVMekROVUd6TDhlVEhBMlh3c1Q2OXQxYWkxcWtIekNSWDE4?=
 =?utf-8?B?WnorLzk0eVFJMGE3Z08yV1J2aG5nemNZSitZRzRweEZiRGFiUnluUDBqdEFU?=
 =?utf-8?Q?O01seMtlsZJvP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlB0ZDd3R1ZKZ3ZPaDMvenc1OUdXaXhFbURtMUdqdmxJZ0FiUW1FbTdQSlFB?=
 =?utf-8?B?N1dUUTVqa3FuaXo1SmhORHZsUDdITHhmM2JhV3BLcGRZQW9mNVBRblJmdDRa?=
 =?utf-8?B?NTNITzMwOERWb295K2RRMXFCZTZRaDZtM1N2MXpiWTFZMUZXU1dpdkQrRGJI?=
 =?utf-8?B?bVJ3bnVwdGkvbWdTUE9MTVk2Uk0vZGI4Nks2TFMrWkNiSXpuSmVwbXJ3U2p2?=
 =?utf-8?B?aEhlM1NSY3RBNUhjVEtGS2kvQ0ozTmd5aTAvVnU1SUlOT0x4azRpMWdyL0tI?=
 =?utf-8?B?NDZ3NElObUthelVzUnFMcUNZcmh6bDJFTWVmLzB3a0RIemx1d2JrMnFkSEE3?=
 =?utf-8?B?RVRoVGlSKzBSRmI0MUEyQkFDREhGc1ZvRkY5OENYRWxGa08zUkkyUDlxNGdK?=
 =?utf-8?B?d0xJVkIyK0Z2dXFjYWo5R0NVUkhpTktGQzExd3BlYlpFWks4Q1dQRFBrOHdl?=
 =?utf-8?B?aVVGdVdwUFRpZ3puazgzMXhpZkpxYTBIN2ZkVldtdXBvdk1SMzkyKzRCRlFa?=
 =?utf-8?B?R01qNlRXelVCWVdSTXR0b3NGb3NUNFRQa2dpc0lqQVFOZEZsQmxVMTYyV1R5?=
 =?utf-8?B?REpadis5cSszeWVmb3MveS9MejFRczhoYk9TNFhaSnNVN0I5YWFZcUZ0Ykdw?=
 =?utf-8?B?SmprMDhWY3RlejBkMkYxU04wVTBoR0syT0JubWQxclduZXVIUUlJbnk1dm9h?=
 =?utf-8?B?THNXbExzRlU2a1VxWmVKYjRxQUQya2YwRUNKR0lFb3pLSXhTNXMxQytFMWpm?=
 =?utf-8?B?d2lsSGIwUVdCNnA3U2Q5a2pjaXdwRm52bU1SdXpINTZYanpaS1BCSlRHMVdY?=
 =?utf-8?B?YWRoUnNnRzNQWEZDNWJQZ0hBeWJjM0RXKyt3MmZWc2VCWllibmcvWGw0MkJl?=
 =?utf-8?B?ZUN6M1ZadmxiTkxWMFlGZGtSY2tBMGl4MlI1V3dMQWZRUEpnM2loSHg0eFlY?=
 =?utf-8?B?NWYxY2ZVNVBVdVN4N2U1TndNTGw4T1FrVE51QU1DcXBsTjE0SVozbzlOa1pC?=
 =?utf-8?B?MnZHQllMeHQvTFA1clU5eTRST04vSGZEbXc3ampyQU5zNVFZZmRJU0xva0pC?=
 =?utf-8?B?SHUrN2lCNThmQSt1cFJJME5KeHQ5VEpjZW9yTENIWVZIRmNuZnRVQzNCbVg2?=
 =?utf-8?B?czhFeC9KWDh5K0czbmUzREExcGRBdEtsVmJJL0FnK0lBcUdxVVphc0dZc1Q2?=
 =?utf-8?B?eE5XcVY3ODEzdlpxQThxeGNKeG9ybGIrTkJHNy9SVGEvODRaRlFDODRNSmpW?=
 =?utf-8?B?MTVkQTVaSWlIYldwYnVyNklDRmdRZ0xYOStOK0c2R0NOd3VCdWlqNFNmaCtz?=
 =?utf-8?B?Tm9HMzFkVDVCOTdkRWF1Q2Jtbml4OXF0cXJhYUZCQTNlRnI3MHh5bUY0eXFR?=
 =?utf-8?B?enN0N1NqOXI3cUhCSUlVUlo3OTJOVjRYMTVOQnhCYkdKQTB5ZnEvS0R4cDBh?=
 =?utf-8?B?RGpxUk5zbzJyN3hYVkIyVGFsU0JZc3BOeVRtLzljWUhrWDRBNTZoUVJEYldz?=
 =?utf-8?B?eVBHSG5QeWdHbHVVTk55bk9nU3VRcURxajJtYjN3L3lkQlhEOFJXcWJ3R2Uv?=
 =?utf-8?B?ZUVZZHNaWlI3ck10OEpIMlBkQ2RhRkEzc01qelVFTEFjUHNLRVVOWXQvMndS?=
 =?utf-8?B?cGpjY2NxZldzcGpNbDBFSDA4L2JsK3E1T2FwVExDQ2xoVlh0U0FhRzR4ZDU2?=
 =?utf-8?B?OXN5SU52cGR3K2hMREN4bEk1VWZUekdzNU1XTG05SU5lWDd3Q1FuVk14Ynlv?=
 =?utf-8?B?VjFTNllXdWwzRFF2c2o5SG4rdm9ZSzFCVWx6RWFCT2dEaU1kbVhOMm45cFpk?=
 =?utf-8?B?ZDRZaGJ2MEVPYllIV1Qyd2ZoUHZsb3dzMkFVRG9WN0pjeHg3Z1ArZ1pIb3dp?=
 =?utf-8?B?Vk5pOU5kMjNvaUF6OTJYM3ZTQjJlQTVOYU5UdzV1RnN1dmVyV1JFS1N3STVs?=
 =?utf-8?B?NlRwc243N0REcHhyY1IrcE5IY0lHWTNMU0tTTnlIQjV6eUYvQ2lsajdsZXZE?=
 =?utf-8?B?ZzNVUUpnZUtYcXQ2Z0hrTjRuTUp3REZ5ZTUwaE1MV0s1eTg5ODhyT08vaCtM?=
 =?utf-8?B?UXdGajVjMXdLTS8wMU5CcmJXMkc2T1BkZXVIdm9aTDJ4djdZZ3ZtNkdUY2VT?=
 =?utf-8?B?UlhoMm9VZFdNeWZmd1daWTNtRGJmVjZqaDlhS1ZIaTN5T3FsZGI4NWh2UkMv?=
 =?utf-8?Q?EregD8ub5YRceZqEPttgbmA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929dbf09-6b00-4a87-95a5-08dcd7c86558
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 09:58:07.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXcw2MRGiZgbFiD4CCURwomz9Nq0uu86s+WvWv7yNcm7KcGCSyZmtUPWs3m1xkr9MfX9LRSeP71VBniZCcGV7PRVhu/SYyV3+XA30SQSyhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

On 9/17/2024 8:44 PM, Krzysztof Kozlowski wrote:
> On 30/08/2024 13:33, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Adding 100mhz & 200mhz pinmux support for uSDHC helps to enable
>> higher speed modes for SD (SDR50, DDR50, SDR104) and
>> eMMC (such as HS200, HS400/HS400ES).
>>
>> Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/s32g2.dtsi      | 153 ++++++++++++++++++
>>   .../arm64/boot/dts/freescale/s32g274a-evb.dts |   4 +
>>   .../boot/dts/freescale/s32g274a-rdb2.dts      |   4 +
>>   arch/arm64/boot/dts/freescale/s32g3.dtsi      | 153 ++++++++++++++++++
>>   .../boot/dts/freescale/s32g399a-rdb3.dts      |   4 +
>>   5 files changed, 318 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> index fa054bfe7d5c..7be430b78c83 100644
>> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> @@ -162,6 +162,159 @@ jtag-grp4 {
>>   					slew-rate = <166>;
>>   				};
>>   			};
>> +
>> +			pinctrl_usdhc0: usdhc0grp-pins {
>> +				usdhc0-grp0 {
> 
> Are you sure that this passes dtbs_check W=1?
> 
> Best regards,
> Krzysztof
> 

Hello Krzysztof,

I've checked as follows:

$ make ARCH=arm64 CHECK_DTBS=y W=1 freescale/s32g274a-evb.dtb 
freescale/s32g274a-rdb2.dtb freescale/s32g399a-rdb3.dtb
   DTC [C] arch/arm64/boot/dts/freescale/s32g274a-evb.dtb
   DTC [C] arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb
   DTC [C] arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb


Best Regards,
Ciprian

