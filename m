Return-Path: <linux-kernel+bounces-545397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCFDA4EC7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B963188DFE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF2B20A5F3;
	Tue,  4 Mar 2025 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="svOWEAfN"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0408205E28;
	Tue,  4 Mar 2025 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114392; cv=fail; b=ldBC6k3VJzdy6hjnS0xN6Im8Px5jm5/Z1Mzdc2MA/EJMaRIXpgRtLWFGxbq7oEziw2u14jFNcfdUKDrp38d2EB3espebD901v5BOeWYX3b2Qb8Odhhl7/vANj+VW3GiO+uqtVhMaqlvg71DfZX9hQVSMwjjqAbKudWamsGG4qtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114392; c=relaxed/simple;
	bh=btD+8zq3EJSI8NZATV5QB1a5bILyKYmXrQwFo79nGW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IyHpzz3tt1gAgW1ole7RUSo0ruzX5LeK7QDbe7wbErEkmubHk08Z9KxwTyzGpQeV+M1BPH3DYaK8TDne8TX//45BuPXlJR7S0r1+NlqZgNMLBu+usc46VtDXSrMplr64vkiVTJY68FuSYUvMzS3oXheOl7FLCNXvrR6LAPZ4Mf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=svOWEAfN; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO4ogziPDODIgtZeknc5Fm1g6/W8IVf87+wdfbDaShsq98CnpNJ7MpnMH4aHSTfEqY6Gup/8LcwgbEG5Z0xjHM/0TdZBaKPEFtUDm5BGhUSArTiFiOTzQ5MnGTXyIbTzGR5BTqydh0W0VOfdsdyUwKVEG4LuPASb1TDbnEeyn2Zru4rzKM7U0wMIGer9Cbxdesplr+iZQaWkOXZu7O6K1BsRM17N9aaJ6r4CDSQEC1TVHc8J2W0UzfOFNbC+MNxrFWjP6npG0IV/RIY8Atd50cUFWxDGVbyP42QSiFm4mdslULgTOZMbLz/j+wUQLI+ovQbyfGyyRh6EHPgOiQiz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEHd0k5mDs7V+tsZWVbSFKwK2cagrY6OG7z0jTtq5kc=;
 b=wrMxJdquno9aNk7Jfnk6Ho3faIkb0hQL//Ga1YD9LEjVOpsqdtUXGik9ucO1y2ENtBbCjpIJHCaYLBre0u2+DSab8wbwekkqyX1Uvu8U/OD9UGB1Xkd9yyxNz76CDNyJzwKs7oc7NuS/76IJ71O8Suc6QTF60DTJH++edJvh6rehhqpIwFZ2PgAhl/70W3c4VZNvVsBDsQwE03o4SiqUdPZFe+1nefEIyB3ZiLdMOkO/Tkb9CARMnK4nKd+yUmPtnxr+yEHqRYhbAgWEgFjjX+b0bc6QFZ6RxPC1btYl8K9KJdQKrmDfVnsMPKpylH8CUHDJjt3+/TYNgOzjltuPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEHd0k5mDs7V+tsZWVbSFKwK2cagrY6OG7z0jTtq5kc=;
 b=svOWEAfNQ8i7OqhMSsMA/qpJc/9f4EwIsL7V85Bl/7e9AYNWQaJtbtjlzyRx+hl16LEu3YXnSxek/3Lr/XbBxTYPEs1pLDeyW+HA14tG9wPNFjKyxdYIXnmtwGDGN0L07SnXjRfmXZEkH0YWTTHYCE2pN459yfMDsRrRPZZq7lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 18:53:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 18:53:07 +0000
Message-ID: <61980b3a-9eea-46aa-9b5b-074600d3273b@amd.com>
Date: Tue, 4 Mar 2025 12:53:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 FN-keys
To: Werner Sembach <wse@tuxedocomputers.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250303190442.551961-1-wse@tuxedocomputers.com>
 <20250303190442.551961-2-wse@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250303190442.551961-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0131.namprd05.prod.outlook.com
 (2603:10b6:803:42::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa7bf7c-549e-40e3-0813-08dd5b4dcd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlY2c1orclR3S1FWVUxiajQ3OExIblhXKzF6WHErKzhjK1RkZ25xbXpDaG5o?=
 =?utf-8?B?T1RxRWJiMzFaelZNR2IwSFlSR2h3OUZaQlVCTWhLaXNPV3h0cEgwUDVqYk9k?=
 =?utf-8?B?RjljS0Z2Vi9rdzhBS2JVSFlJUEx6S1VaTjA5Z3hxUHVoSEVsREZ5R2NMeVpu?=
 =?utf-8?B?YzdHSzVKWGdaeXVJSi95ZzZkQmdYYjhoRlI0bEttVEpTRkh4cklXd2FFL0xM?=
 =?utf-8?B?RUYzbFEyRUZQZFFvTzB1TkdSVnd3bGNBZUVtb1psaWc5UFVzZXp2a3VQNUxE?=
 =?utf-8?B?d0pKdU10WEUxbXpZUXM3NEg0aWJqV2MzK01ta05lWE5VQlhhK2RidkR1VFVR?=
 =?utf-8?B?aEtUZEwwN2xZZmNQWVRZMFMxMTlXZXJYNnk1L2cwVHVHcDdkU0RWVDJDWFd5?=
 =?utf-8?B?aDJiMDk2Qm04SGI2aXYxYjd6NzlaVnhWQmRRVG04Q2FRZmxhZkd0ZW43VjhU?=
 =?utf-8?B?WFo1V2JNd21CZFFWcnlmSmtDdDRubkEzQ0JUUXh5STVKMEpJeHF0Y2gwSFNN?=
 =?utf-8?B?V0M0QWp1WDBDMEQyUjFCYTZNY0lCd3Z6bFlrMVZZN2VlclNlNWQ4SDBkR01V?=
 =?utf-8?B?MDZOR1E0cCtwSW0xcDhpTnpLRmFCZkM0czcwdFBPMVNaYUxWVU5TOWtDUWtL?=
 =?utf-8?B?SUNTMVpSejNqVVhPSTZzT1RVRXZmTVV1VS9jcFpWdldxK0F6N3BJTmRGb2RQ?=
 =?utf-8?B?d3RhaUxhclBwYzIzU05SVktZSEZBVGVxbmhvTkYvNHVRbnh5ZWxGK05pMjht?=
 =?utf-8?B?TXcrSFJXVm9PUGNSUDZHTjBYNUg2YzhFYVNnREk4bGMvY2t0R0EwOUNSOGNy?=
 =?utf-8?B?UC9WbHpWYzd6cG1LanNKWElKdVpRYnZjc1cxR1laOVZPQjIvK1JXUk9TSWEv?=
 =?utf-8?B?WWhid1RwRHluY1lZUHJNQXNpNHR4ZElJUktlc3V6RlNUZElrcFZWNzY4VW1m?=
 =?utf-8?B?ekYveHloc0IrbnpUV00rTTFWdXBpUHIxMWVIWVRKQ1dEaklzOTRQZU5mUEVI?=
 =?utf-8?B?RzRlNTFyUVk1U3NvVEdqZW5FYkpqUzZRcHlkaG11WjM1emxROW5NWXFOQm14?=
 =?utf-8?B?c2E2L2plTHJBZUtHc3VsdUx2S20rVjFwOUZiOFhqMHpZem8wNlVjVFd4QnFn?=
 =?utf-8?B?YmZ4NnV1bWVDZThFRjE3MDFZY3dpRWhZeCs0K2hNVkoyWm1GaWhSZXpScWxk?=
 =?utf-8?B?UzE1eGNnUmVkN1k5ZU9FcmR5b3d6R3JrQTdRcVNuTE1tV1dBUWZmc1FQVWlX?=
 =?utf-8?B?SmF2MDlwNWJ5VjBGN0ZBQ0NhdEFvN09DZXgyWWlGcW92NmdEZktKeEkwbXd3?=
 =?utf-8?B?emdXbVYrTzVXMlBDdnFJN0tOd25SVk15WFFsQ0xWNk5qZ1JsWWhGSzgxUGxY?=
 =?utf-8?B?SERUOGphNUxBbUxmMVBKMUJ4ZHNka2VwUXJhcDNjNHRUN2UrOFo1c1ptaHA0?=
 =?utf-8?B?NVpmMUFobWFNWWpMTzJmVnphWW92b0tzV0FqQzJzek1tRDlMSFYrUVM0dENa?=
 =?utf-8?B?dFcvMFhCZU9kL3J3UytHVTJoQ0hhajYyMTZ5UkU2TitOVldlck1tV3lLRlpo?=
 =?utf-8?B?V2hIVjNjam5uQzBvZVVVZzl6RlhpSnNNS2hkKzE3S2lIRDNZalNoSE5BUWUx?=
 =?utf-8?B?OThHTjBxOE9Pc2V5aHVnZTQwLzYrWnVZU212MWxiZEFML2JOUjVLT1Y3SGpw?=
 =?utf-8?B?QnRtb0JiK0kxRjNXWll0Qm5ZNlRBY2VQTElneHJQSE5McTd6UlI0UnpTZFBa?=
 =?utf-8?B?WTdicW12OG44clQ0VSsxZTVaR1NpbHZLdm1hQ1h6VldOdkdzM1NXNFh4dUw5?=
 =?utf-8?B?eDdVZTIrcGYzVUpwMkVaWStGV0xnZkltUUdGZXNkVnczRmRpMTJUTUlDN09V?=
 =?utf-8?Q?5I8IUwu9eMTDJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1k5eWFXcndlWGJKaDh5R0FJdXMvalYrRUpwd0duakYxNkplbUFZbm5OYjI2?=
 =?utf-8?B?eHJWVTVWK2V5NmxLNVc2VEFKbEcvWmlEV0tjbkxTSFJyZzA3MGdzUTBmcHFu?=
 =?utf-8?B?SWludnNhalBwVlMvVWRuaTNXQWY5Y0ZhcDdST3hDWElZKzhsNUl5aWpqWW52?=
 =?utf-8?B?VVJIUHl5M1BrcmtiNFlyV1lKSnhpeFZGelBsemVmU01zT0phUmxvY1I5NW1j?=
 =?utf-8?B?OFVsRmhvdVVhdTFnMFdzNmJyQWFYYmhaZHhqeXBpV1lqMXBzU29BcnpVVkti?=
 =?utf-8?B?MnE3dHVTVmFuSnhvWlJIaWM3NVhkckR1Y2VROFVsM0thSTkyZkZqeEFGaUdk?=
 =?utf-8?B?Q2x3ZnVmWTF0Zm9PNG9OWjEvL1NQZ0ZJQlBxc3dvbG9NdDJhOG55WmhnWVVE?=
 =?utf-8?B?ZFFGdHNHSEFkSnlNOHhlMHQ3NjBFcmZITmhRKzZRWUsvSlNoZC9rczN2Mlda?=
 =?utf-8?B?K1d0Smk0UVhQL0Nqc3J3TTVoZk9nRXEwempLTHVNRnJCMzR6Tk9rSXh4K1Z0?=
 =?utf-8?B?cDM1eWtwZHRkUGp0dmxvM3ZDRzJFTU9LK0FDUVczMU9UR3JVbm1lS2xERTQ4?=
 =?utf-8?B?SEc5MWxoUlM3UU1BRlZmdnhDRnJJUlo2ZVpYRmVKemZoUlNTd1Y1WDRjZWIz?=
 =?utf-8?B?RHpCTC9QV3BHR3M5eTZTelB3QUVXejVLNEZnL0pIejBCNDFlTUFjZEUvTEZs?=
 =?utf-8?B?Z29pT0M2d0NFY3VpN1ZSOTErbDlDTzZoWjRwNlh4aC8zRkFYSmZOM3NZWW13?=
 =?utf-8?B?SHNTQ2lQVWdlcU9hVHZhNC9kdzk4VGFwR1l4c1Fvdy9HSGViKy9iYXdsSFMw?=
 =?utf-8?B?U2grdjhUQ013Z1FzUC90bGJ0UW1QdWJqcDVQWmZLemtnZnVOSzIzQnErTUxK?=
 =?utf-8?B?Z1p2YWp2M2ZkV2IwSk5XTHZPQ1BKQnpUQXpQZm5RWkZLRlI0MHVpcFRvbHNL?=
 =?utf-8?B?dWI2K0tXVG0veFpWQ0pZQTU0Y2cyc2t1QTlzTndBRkVnZ3FnMjladktUandY?=
 =?utf-8?B?QURFTVU4Z0pnRExoc1FzbWhRaE5QQWxsVU9JdlJPVFNFdVlRZkhMMDVnQnFS?=
 =?utf-8?B?elVWSng3bFdrQ0t4MGZseUdWT2x5bHNweHR2RS9jSzRXU2FNVmlNcXJTSmFa?=
 =?utf-8?B?SnRIdjJTNjhReEsrYUNmVnRIcUUyTXV5RXNvSGIrTEhWbXRUWHkxTTJKQVVQ?=
 =?utf-8?B?SlNMMUFqc0plSXhUY2hneStnWjdnS0pqa2dvMzV6cG1WV2FjYzdmMVZaZ0dK?=
 =?utf-8?B?aktCZW1aRlhjNG92SzNVSHNJYTdVS3hmT0Rzd1JPdXJQcGNDTlc1L2ZxWW00?=
 =?utf-8?B?c0Jvd0xzaWVaSlVBYktybEwwZ2lHbzh3V015UjhwR2VCYmNmM2NSOC84c1Jx?=
 =?utf-8?B?WXJkc3A5OFZHK0tZYkcrMG9ZVktnTWYxSUt1YUVXS3NPVkFMeHJwb0FrTjY4?=
 =?utf-8?B?ZlNJQ0czcUkrVElIdHptV204YUJXbEl4Qk5PQnd0MXFLL3d0eFB0eWFzTW4z?=
 =?utf-8?B?MHhMRVNoOWoxUy9IKzJua3lybDhyTmZUdmNOaW92NkNSTUFjdCtNL3VzUUUr?=
 =?utf-8?B?YlJ4dUZENnFsNUxzdFFVUFhvTjVmbXp5d3ZYZlRYQUpaNmlraUF1REl4UjI4?=
 =?utf-8?B?MlhoMllKWm5HZ3k3OTJxdEl4KzV5aUpDU3dkMlc3dlczcC9wbEJwck9jNXFq?=
 =?utf-8?B?ZkRmZjl3bjdNRkNEUERhMGYwaWV5NjIxNGhYTzNlRGFSSjVId3NYanA3Rzhz?=
 =?utf-8?B?cSt4djh4UXowRFVrYTJ4ZHVXK01iSkY4VS9TbFVaM2hXa0Q3aXRuTmJzQzJM?=
 =?utf-8?B?anNJVFpzdm81Um5NWUJVOW43RkwxK2NnOU4xekNFSHAvTjdtaGxtcStCY2R1?=
 =?utf-8?B?OG04WUdRU1ZLTnhJTllmaDlEYlpHeWJlbXFhYzYrempQNlBubmkrL1FVRGU3?=
 =?utf-8?B?VEVYbUtSUDBQd1MrajgzTmM2ZFpQdEdqY3dQSkVVZzA4MzB2c0grT0pmaGQ0?=
 =?utf-8?B?SEt1Q0t6SC84aFFxL09BdCsrVEhUOTdia1ZCS1dNUUNFTGZqNWNwQVMxazJt?=
 =?utf-8?B?U3RONEVTSS9ENmZaNGIvWmZLTEJUUDk5RkhEQ2k1bDVJeDhPa2xQanYrdHR4?=
 =?utf-8?Q?4fdn76kZTPXJbSypltt9Y+s4S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa7bf7c-549e-40e3-0813-08dd5b4dcd76
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 18:53:07.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLlgoex0WzFEBAHqSYz8HtGaJ2IjipksG4oxgkwGqZJkPbWUoZcUh7eQGolHf8XRdIyP0nTejvVV5r2Ff4x80g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

On 3/3/2025 13:04, Werner Sembach wrote:
> This small driver does 2 things:
> 
> It remaps the touchpad toggle key from Control + Super + Hangaku/Zenkaku to
> F21 to conform with established userspace defaults. Note that the
> Hangaku/Zenkaku scancode used here is usually unused, with real
> Hangaku/Zenkaku keys using the tilde scancode.
> 
> It suppresses the reserved scancode produced by pressing the FN-key on its
> own, which fixes a warning spamming the dmesg log otherwise.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   MAINTAINERS                                 |  6 ++
>   drivers/platform/x86/Kconfig                |  2 +
>   drivers/platform/x86/Makefile               |  3 +
>   drivers/platform/x86/tuxedo/Kbuild          |  6 ++
>   drivers/platform/x86/tuxedo/Kconfig         |  6 ++
>   drivers/platform/x86/tuxedo/nb02/Kbuild     |  7 ++
>   drivers/platform/x86/tuxedo/nb02/Kconfig    | 15 ++++
>   drivers/platform/x86/tuxedo/nb02/platform.c | 94 +++++++++++++++++++++
>   8 files changed, 139 insertions(+)
>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ff26fa94895d..d3fbbcef813b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24178,6 +24178,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>   F:	tools/power/x86/turbostat/
>   F:	tools/testing/selftests/turbostat/
>   
> +TUXEDO DRIVERS
> +M:	Werner Sembach <wse@tuxedocomputers.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +F:	drivers/platform/x86/tuxedo/
> +
>   TW5864 VIDEO4LINUX DRIVER
>   M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>   M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64b..9b78a1255c08e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1199,3 +1199,5 @@ config P2SB
>   	  The main purpose of this library is to unhide P2SB device in case
>   	  firmware kept it hidden on some platforms in order to access devices
>   	  behind it.
> +
> +source "drivers/platform/x86/tuxedo/Kconfig"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index e1b1429470674..1562dcd7ad9a5 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
>   
>   # SEL
>   obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
> +
> +# TUXEDO
> +obj-y					+= tuxedo/
> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
> new file mode 100644
> index 0000000000000..e9c4243d438ba
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kbuild
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +obj-y	+= nb02/
> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
> new file mode 100644
> index 0000000000000..e463f92135780
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +source "drivers/platform/x86/tuxedo/nb02/Kconfig"
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild b/drivers/platform/x86/tuxedo/nb02/Kbuild
> new file mode 100644
> index 0000000000000..8624a012cd683

For a brand new directory isn't this structure a bit heavy handed for a 
single source file?

Or are you envisioning a lot more coming to this structure and just want 
to be ready?

Why not just d/p/x86/tuxedo?

And within there you can have exactly 3 files: nb02.c, Kconfig and Kbuild.

> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +tuxedo_nb02_platform-y			:= platform.o
> +obj-$(CONFIG_TUXEDO_NB02_PLATFORM)	+= tuxedo_nb02_platform.o
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig b/drivers/platform/x86/tuxedo/nb02/Kconfig
> new file mode 100644
> index 0000000000000..bed56276b9b36
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +menuconfig TUXEDO_NB02_PLATFORM
> +	tristate "TUXEDO NB02 Platform Driver"
> +	help
> +	  This driver implements miscellaneous things found on TUXEDO Notebooks
> +	  with board vendor NB02. For the time being this is only remapping the
> +	  touchpad toggle key to something supported by most Linux distros
> +	  out-of-the-box and suppressing an unsupported scancode from the
> +	  FN-key.
> +
> +	  When compiled as a module it will be called tuxedo_nb02_platform.
> diff --git a/drivers/platform/x86/tuxedo/nb02/platform.c b/drivers/platform/x86/tuxedo/nb02/platform.c
> new file mode 100644
> index 0000000000000..68d83b9b4c2f5
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/platform.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#include <linux/dmi.h>
> +#include <linux/i8042.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/serio.h>
> +
> +static u8 tux_nb02_touchp_toggle_seq[] = {
> +	0xe0, 0x5b, // Super down
> +	0x1d,       // Control down
> +	0x76,       // Zenkaku/Hankaku down
> +	0xf6,       // Zenkaku/Hankaku up
> +	0x9d,       // Control up
> +	0xe0, 0xdb  // Super up
> +};
> +
> +static bool tux_nb02_i8042_filter(unsigned char data,
> +				  unsigned char str,
> +				  struct serio *port,
> +				  __always_unused void *context)
> +{
> +	static u8 seq_pos;
> +
> +	if (unlikely(str & I8042_STR_AUXDATA))
> +		return false;
> +
> +	/* Replace touchpad toggle key sequence with a singular press of the
> +	 * F21-key.
> +	 */
> +	if (unlikely(data == tux_nb02_touchp_toggle_seq[seq_pos])) {
> +		++seq_pos;
> +		if (seq_pos == ARRAY_SIZE(tux_nb02_touchp_toggle_seq)) {
> +			seq_pos = 0;
> +			serio_interrupt(port, 0x6c, 0); // F21 down
> +			serio_interrupt(port, 0xec, 0); // F21 up
> +		}
> +		return true;
> +	}
> +
> +	/* Ignore bogus scancode produced by the FN-key. Reuse seq_pos as first
> +	 * byte of that is just the "extended"-byte.
> +	 */
> +	if (unlikely(seq_pos == 1 && (data == 0x78 || data == 0xf8))) {
> +		seq_pos = 0;
> +		return true;
> +	}
> +
> +	/* Replay skipped sequence bytes if it did not finish and it was not a
> +	 * FN-key press.
> +	 */
> +	if (unlikely(seq_pos)) {
> +		for (u8 i; i < seq_pos; ++i)
> +			serio_interrupt(port, tux_nb02_touchp_toggle_seq[i], 0);
> +		seq_pos = 0;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct dmi_system_id tux_nb02_dmi_string_match[] __initconst = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "NB02"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static int __init tux_nb02_plat_init(void)
> +{
> +	if (!dmi_check_system(tux_nb02_dmi_string_match))
> +		return -ENODEV;
> +
> +	return i8042_install_filter(tux_nb02_i8042_filter, NULL);
> +}
> +
> +static void __exit tux_nb02_plat_exit(void)
> +{
> +	i8042_remove_filter(tux_nb02_i8042_filter);
> +}
> +
> +module_init(tux_nb02_plat_init);
> +module_exit(tux_nb02_plat_exit);
> +
> +MODULE_ALIAS("dmi:*:svnTUXEDO:*:rvnNB02:*");
> +
> +MODULE_DESCRIPTION("TUXEDO NB02 Platform");
> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
> +MODULE_LICENSE("GPL");


