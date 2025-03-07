Return-Path: <linux-kernel+bounces-551914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841EA572E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4B6189A305
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E22517BF;
	Fri,  7 Mar 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uVqKP61V"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022076.outbound.protection.outlook.com [40.107.193.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567313C8EA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378953; cv=fail; b=Y2v7v8nLTU/j5nzN6RXmstS3wGq+jCaXGHfEzGMh1d3PWA86WkqDtdEcZhN5bFds8cwKc0w7l5gNC1Tx0eht4TRYrzl2nVDBqSn4uhs2T0AsOE96bIG//t2saFKHUf0zzkz9QZp6gVmQl1auLTP0OpmYYWHHR+227SrFkHLXjig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378953; c=relaxed/simple;
	bh=FHdWkmNJoaE67AgfFvtO9rcLKSJ5RV3SUzSX8+OfLzk=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=bVMlgPhMV1FsfYPVV9RDX9Oy/LLUPtMdR4WDShdprrgsKmdcmPgB+lnufJG9yViIqBNxz/e+VXOxSH+pQry8s/WSyRUNISnHhTeyAr78a0d25MOVoQ4vIA2fSHZ2lOZ4VtBW0RudFXCtLbp2QSg2UuX8TJ5qqeNS6w32Tgu4dsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=uVqKP61V; arc=fail smtp.client-ip=40.107.193.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ4UqMPPJjcSLVrSqOnatiksQbjzQ4kiwoKhJNXEfbbKElVebiGzE/PtOrGOLsfDYI5mC3GclHqPp5nIc8iWjHmDkGc+ntPnQBunftuCkNwcyLVEkXP2YWjI9pOABO8kCUBXqZ4qGZ8XTf4yfYLitULO1L6JYgzY+QRgzpQpeABVxa4WUQhxFQyegvWJfdrSnYwmIMmo4ZrUIbsZN4N1wVzAT4/Mk9YYBUld/ZOQryMUFDJEAlQIPFfKzt328RcynVZKMRO6D/n65zUny5NLrKvI7eZrKsfKlWn7IVfqMZ14/mg54b7Yh4Acw07pzmnx7Mm2g8DAy1K/1uaEfTqm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTYLaJhIE5CL77AbzY0WRIW4J0RNvMLT0TFxGHUtWRg=;
 b=PcYS+sLdrpS98NZoqNoIsXLODoJ+rKCblruVzGxQosTz+pIiPt8LvpOTrxNGRpKh96PyqjQLSAmr1DV+WcvDhEe/IqtqvMhJKWFbk+XyGO5uSUABHDuHl53GzlZL7+u3Noso83hm/VWChlyPuPhuvfH5QuvE9AAhpNZIAGk9Bd/uSudAonF18INIBOxCZ13N0UgTw0ytvLOBWo0BWTEYPxXQgeUFpvg+9/ORTdBFFYqBevKfZyRRUHaC9V5hQc9g/IJedlk3p5EQvkyHLTihj/Y2SgTfVgOh5ApXRjgITEdt2z3+JoG+r8FErLac5PYXwcN1mh5DkER+bHQkT2/G5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTYLaJhIE5CL77AbzY0WRIW4J0RNvMLT0TFxGHUtWRg=;
 b=uVqKP61V2HIXnRl/qJW4Xmy0dkvyfL+OeCsGKcuwLN1U8/NCqbSo3qnyEy8nuPuXrkAwmIeE2bWeEiwbY7W9JsZ1e0f0kyaEKg4AVkasNKr/9oXratS5wVNdBMC2v8JpOCLlhwmRCBnR7T86at9I5MYRsP7noOfnddzjve5aEwNCSSw4VB/EDnm0NN4xbx3pDZSGV/1NKSqB+c80RJeQsL0GI5e0ZlODnMCkxmEiDK5RAe+ZRzg8M+19nYOX++Ly1O8ic0RGzBJObm8fGPo74oD173hnK+TxnetlcSuFXtOY92h+prg+4LLfiIr9Y4idjZpB9MZh+yrmo2jxlJmXeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Fri, 7 Mar
 2025 20:22:28 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:22:28 +0000
Message-ID: <b3acfb1e-2d7a-42ef-9705-bf0b20a0d152@efficios.com>
Date: Fri, 7 Mar 2025 15:22:26 -0500
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Pavel Tatashin
 <pasha.tatashin@soleen.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Memory hotplug locking issue: Useless (?) zone span seqlock
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a67ac7-a734-43cf-0e26-08dd5db5c802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGpxOXpMaUc1cTZmUFUySWxzTkJCU2NNaVJnb3I4Ym0yL0d0QjQ5bTV2eDdZ?=
 =?utf-8?B?NzY2bmhON0JUNzRDTjdHMnpuWVF6TGV0dmNETkI3VDdZL1p2RmFoYUZ2RTkz?=
 =?utf-8?B?MjV2UEowWGFndVcyS2RwQjdXTDFtelNrdlUrNy9mM1lHQThNMjFIdWNlSlVS?=
 =?utf-8?B?ZjRpamhKL241enlCc1pVTGNRa2NxWTlTSGZ4VlFZVzA0UUxhSnRaejhQQmFs?=
 =?utf-8?B?Nnd3VHhjV01pbHZKVGhlZWhFVUJROVplSUphMThEK1ZuYWZsdEwzQUE2TnVX?=
 =?utf-8?B?Y3UrZlVCd0hNVmpYUGtWY0F5VDdnSkFhd2xVWGt5NEJXQ0RiTXNvU3BPb0I3?=
 =?utf-8?B?dHVnYlJsNlhPcVFVQkVPL3pBMll6QVcxNjdjaFFNT1VNNElRZW5ia1d4Y2ly?=
 =?utf-8?B?VU9zRWhjNjFTV1dDREptb1UvM05lOGE0WVpBTVZPYTExVS9tQ3pEcEZMVHNr?=
 =?utf-8?B?b0EyVWxnY1doa2ZlR3IwT0RvMlI2U2U0U2VlQUNkeFFUTnM3ZThpc0VvR0tF?=
 =?utf-8?B?UUdsOTJaWUQ5UnF4Q0ZTN2lWQWZRYUxWdXUyWGZaN3hCMm5HcmNTaDdiZkpY?=
 =?utf-8?B?ZmVWNTBaR0hFR0MwVmdHWkg3TGhoeFAxNm5wUzhLWUcwV3ZVcmJSemZCRFc1?=
 =?utf-8?B?WkZ6OW9Ja3MyeFVmUDVrR1dvN29JQVBEMUhZNHorZXlaaTVFS09uWXpFNjlG?=
 =?utf-8?B?TUtNWDZsR3hUSGQyMWR5VGpTeVplRjRJWE1GQ1lsYXlJd1RXaXY5L2xyWjJk?=
 =?utf-8?B?SjJ4U2R1OGl2MFozdHBUSGhLZEhCcC9PQ1oyRis3cEQ5MFdNYmdTZDhNcVBh?=
 =?utf-8?B?Tk0yMFAvYXc2L3JjUERSb3pZZWFVUnE3dDEyZzVFUWZ2QkJLSituYUh2eDMv?=
 =?utf-8?B?UWdNQit0Y3FNMmhMVEh6b2tHelpzUEwrVkc1MldxZW44VHBzUzJnY1ZSdnFC?=
 =?utf-8?B?b2pSYXFSWm14MHNlQ0NNL0p3VkRtWHJmVzdmUEtMSGhnNzVINGhFajJxZm0v?=
 =?utf-8?B?NWlSTERuTUQ5amxDd3B5di9PWWRoSDdLSmNsbVpTbjI1ZndLZTRQUDBxbGxE?=
 =?utf-8?B?U1N1U09iWHNhbzhUVDM3VmJiam5LNjJQbHhLcTdubWNUMVN2VXBNUTN5M0I3?=
 =?utf-8?B?TnRRaE9kNGFqMzduQldwQVRjQlp6RjE3eExXNUhjMENUaHozcHlLZmN0S0NT?=
 =?utf-8?B?cnduM2N3VWpHUXBJRW1YTlJFaUJmYk0rbFZod0gwZTJacWpJZEdwTXA5b0lD?=
 =?utf-8?B?NkF3citYYzFoVW0xRVkrNG0yb095MXROZmNkUSt3Zk5JbXg0SFlFRzdaWTVW?=
 =?utf-8?B?WTVGRlU2eUZLUy9oTFV0QVhvOVF0V1IwRzVXbk0zMDUzOGc0TWJ1bFhnL3lN?=
 =?utf-8?B?Wmw0TU4wVkkyUThCbGxhQ0Y4M1BOdnVucytlWUtSZVB2aHg1dm42OHh0MStU?=
 =?utf-8?B?VWJ2OFR3Tml1UHJFWjV1bThHNGFwZFBLRG9jMVoyYVdpL2lhSm9tc0RXU0xq?=
 =?utf-8?B?RUR3YVF2aHRRRWE2WlhBN0ZHWGxVbHV3TXUwZnhWQ0RkeCtyUkVBYXgzK1hV?=
 =?utf-8?B?bWVUTEpnay82ZEw0a2ptNWNnUTFoMm8zaG93WGZhaFcvUk41QXBaVG5wY3V6?=
 =?utf-8?B?SmJYbGdobk9hcmxEK0NEb2k5QUMra0h0dGlYSGphQmFFNFJXelFMcnJ3Mmlr?=
 =?utf-8?B?U29maHhFT3llVVYwY3FFY1cyK2VsZ01uQkxWZG5LVDZxTjUyQStpUlA5cGlC?=
 =?utf-8?Q?il6XRMpGMwzsIYIHtVOZUvGLZo0IoP4tszlCYfS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVFMbHZjclk5WDBrT1ppemxPZlhBVmVZejJERXE0MzRuYzZBUk16aDB4MHZ6?=
 =?utf-8?B?TmJrVEJ3cmpMTHlBUVAzOFJSYWYySVM0UkpsNk5XRG5rMy91RmQ2RjkxcG83?=
 =?utf-8?B?Vnp5Q1lKc1AwSXJncEVlSjJvSkJaSFVpWnhpK0lnV2FOUlNVMXUwQkp1ZGdN?=
 =?utf-8?B?VlBUV0dSSnFjVVI2ZTVMY2NJUkFXR1ptTW03emR2Y0h3LzVIMm4vMWNvN2xv?=
 =?utf-8?B?bjR0Qld3Ym9kVjFRaGs4VDJoRXAydnIrWFFpUUVJN21Bd0Rhck5hd1A0YlNr?=
 =?utf-8?B?NUp2MVU3S1poYi9aTXNjMEkwUzlFNHRYYnNZcjBvektMSlNyOExVdUMvUnVu?=
 =?utf-8?B?UitJaENra09odkJvbUFYQTRrU0poQStYV3NaVmZxZzZZSzcyUGhrd3RZSlpw?=
 =?utf-8?B?OXN4K2V3UnFvZWZKM29NMmY5eTM0Q2xHalVmcDNTZ01DdmhocGNQd241dTRo?=
 =?utf-8?B?VEErYjdrTWlPb2xxWFdiL20vWGZZY3VzcjdGWlNhRnJWaWVTNTAvUG1zeXIv?=
 =?utf-8?B?NU56a0tiajlocW11YlZZVzZob1pXZlZIRUg4cW9UUzdJOHg5UEtudHI0bmtK?=
 =?utf-8?B?UUJHMVlOT2hRNUwvbzZ4UmlsbGRpYnZ3NHBTL1gyRlMwM2tEVGhLTkllY2lI?=
 =?utf-8?B?bTlobDhZM1NqQlAvYytJbGdXWVNyd3pJVStid1dUQXA0NFM4YXFvS3FZODRw?=
 =?utf-8?B?T3NPRlN1SUwrYlI5Y1FsNnkySDhvQ1V6cjM2dDZiUy9HQXpIaHRmTFlKZDlT?=
 =?utf-8?B?L1puQzFvTFZJZEI1b296SFBIU3lvQUF4SEowQ2N0cUZZM2g1bG5tdjdpQmd5?=
 =?utf-8?B?UFJOeGw5azd4enpJMlFBbVRMdFRrWW0yZU92RzYvQ3pIWmlFNjduWTZTeUdr?=
 =?utf-8?B?U3JyNFkwRnRGeGhkajJqVEluVUZHV1JPeEl4bUIzb2Rob2ZCWGF2Y1JBMXJn?=
 =?utf-8?B?RmFqQ2F1cmV2WUMwRHlhTDIveXd5TUU1WlFvTmhIWXBSMXJ5SzZIYkFzVFMy?=
 =?utf-8?B?TXQvN0V2cnhzTkpYcEFFeDBWSitsWGN5UjFQbCtPYVFXSDdEaDZyQ3d1OUZ0?=
 =?utf-8?B?QVVKaFZGYk55VVV4TExOeWsySUJTS3lPakpNVHQ5Rm9HdmZOMDZhWDUwaUQ1?=
 =?utf-8?B?R0Myd3BaRWRzaWRsWndiOVhtQ3VYeFZsNTB4aVl6ekN0Vko4cFlsaXE1UzUw?=
 =?utf-8?B?NnhNajJYTkJzRExvaGR0NFE5eisxVnlKUGM4cS9DY201OHQ2bWM5ajJHakk1?=
 =?utf-8?B?RGxOazcyeXN6b1lpYWY4ejI5RU9oc2R5bDBaQ3BKSHJkM09sUks2bWttMkRW?=
 =?utf-8?B?MlJqSFlIMHg2bWMvTTZXSkMxa3dPazlVdHhQR1VDbUt0NjhleXU0SlhMSnRZ?=
 =?utf-8?B?SlVyVFpXS09ab1hnN3NVZGZGdm4zdmQwbGZTb2d0ZytPTUhRbW15dFpyL1lH?=
 =?utf-8?B?WVkzTmpCRHVURkZoNG1nbFhBcTREVVB1bTByUjJPY1BxdVg0dHZwNFdYYjc4?=
 =?utf-8?B?dkdQcmQ2MnRXY0JBYWtXcjRUeHpwc1I2WC9DZ21zOGV1SW5kY3gxZnVvbllM?=
 =?utf-8?B?Z2lWQnN6bURscWlsWTFWNVVXWk5JbGZkb0ZnU2lQQ2dKYXh0SkdUZFN6QXZD?=
 =?utf-8?B?TVM5N1hWT3pXSXU1YnRkVjgrMWkvY3BGNFFLcGM3RmdWbjBnWmtRQTV2aGVz?=
 =?utf-8?B?V0NqUVpnOWhoNmE2Q1VQRjdLNW1XaVVvT0FRSlc5YWtqejhlNTE3K3E0dDA5?=
 =?utf-8?B?UTYwdHhwdzRueEQvTEN6VTZNeXlZYnBtdTNBcGJaZExmcWpoMFcvRFM4a3Nh?=
 =?utf-8?B?eTlRN2NTZEV4OEVhZlZCZ05qM0pPYVROMGJpbVVkNUR4dXErRHZzZTU3MnJ2?=
 =?utf-8?B?YWwyZ1VUdktHMzZ6TlRDaktYMUJkUlNTK0NQWSt6d0ExN3cxSkp0blExOEcw?=
 =?utf-8?B?N3hkbTVWdGdvcm5tK0FOYnJ4eHJCdndVV1RJL2VqYWpsSjhoZUlQN0dnOTVT?=
 =?utf-8?B?TU5qa1d5TjkrWkxaMXpTNjZabHQ5NDFyVmp1Tm1pZ2dYU0oxczh5Y3A4Vm05?=
 =?utf-8?B?SjFEL1d3bWpTeHFSb3A4UzRmZDRXMnpzVWhRWjZNL3llVFFjTkxIY1ZjR1Nl?=
 =?utf-8?B?VlZYaFNITFBlY2dOTWpCbXpGZ29rRlA4Y05uSElxTENRVHRQU29GTW83NkNj?=
 =?utf-8?Q?nKs0f/pbGrx+R2xgxvG/6e8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a67ac7-a734-43cf-0e26-08dd5db5c802
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:22:28.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SbAuGNNVTFZzqNpStVXhJq+jFQC1EqqXIpPcR3O7ZeEuTdsCZ05fGxfQYY81+C8e9cg3v9pfRF/fdphhYjeH5DO8YhNrEtWv7APjMG2DDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9065

I'm currently perfecting my understanding of the mm code and reviewing
pieces of it as I go, and stumbled on this:

commit 27cacaad16c5 ("mm,memory_hotplug: drop unneeded locking")

This commit removes all users of zone_span_writelock(), thus making
the inline useless, but leaves the now useless
zone_span_seqbegin()/zone_span_seqretry() in place within
page_outside_zone_boundaries().

So I'm confused. What's going on ?

And if this commit got things very wrong when removing the
seqlock, I wonder if there are cases where its partial
pgdat_resize_lock() removal can be an issue as well.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


