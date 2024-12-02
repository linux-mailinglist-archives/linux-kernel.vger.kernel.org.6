Return-Path: <linux-kernel+bounces-427960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A820C9E0ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02146B827F8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F4E13CFA8;
	Mon,  2 Dec 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="myKL3FGG"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2106.outbound.protection.outlook.com [40.107.96.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356813B2A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155555; cv=fail; b=bbXAKXoA/8e1i1ut/AY/Vu2655dePlmHpC8xKwIIw2NipJM9LlJUwI/4a3H/4b5l4OMIqba/lJU4Fdh+iJV6NWMUenf7KI/xxlllrXs8mzP2+ZGwiKhui/8kWdGtzk0tbD2NM/awHcfUiCd2ekvqsQK9VH/KCCsvXzE9Bp4gY6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155555; c=relaxed/simple;
	bh=hhBNDp6j1O2UgFESNfZ54Sf0wfl7Mw/TjYIcgNtda0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuwElnvvJXMrndVUD6hblRzduW+0KgfHpxMrRtPic4mViwKbvtpqqO5tMa+DVQdnrU4Kvl+TCwAmJi3MF8nCMWHJwCVQic6bPPKt2zdzHrDoVugTz7xboWw1UUAjOsbeUE6sIOSxFJlSZc1AKHII01F9Zj+ZBSNFRu+R5LqTin0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=myKL3FGG; arc=fail smtp.client-ip=40.107.96.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mri/1jk7ClFs40Fq8ckwv9S6/R4aEiFXqFCeszFP+i1Qq0vcCM9c8Pj8eENHxX420MQDhxKBbb7v6Ga/4qSZrHEwUKG+WeXZIxgzfHsJEJtNx5wUXWTfIGqRRQllU+hnO8vNjqcLtQbIVlCkr5hkOiloBTGlBk/UWBPm9LbUcNncf8pC8BzaK/Tu2saF405yE0gBZdtw2ynGRrmQWf0/kQ7WOvA8efXVS2lTMgeHy5NeilYAebL8xt1jZyX2T128tpW4gMa683SniIZIr7yR3j4ttEYvTXodT6cFkfHlyLe5gFjv1+KCTcYaMgMgU6WprUlvm8xRStCDgpsffTDhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4FCIxpRauM+6bYGp+moJlYMIQy8N3zK4/ZDElwWZ9I=;
 b=wfDIKdTNevEqZ97nw4207iGwFvxolgJjoHWFmgAM8jezHTn4JnHGU4gwqa+/5z4PkzttiNoD7CTiTihj8b9lOqhiZZ0KrY1ETjgeVZki/Ake8WlD+yPvRxM5kXiZSHY/pXAS8Sv2a26uovPfhequmbNhClE5ZbFEyVjvzsVT3XLOOGiNVd8uKmCPDirnFGeh/DMIHUCebBkWN69qdVaBhFAQebw8HV5PeNR+rMPHL6V2Ucgu6XKMVTykNSSyfk+6rn9oFK0lF/doURPNtnQUjNsVyP+4+7bg3jnDJBBQKAxwEdVnh0oYfZvfUSqwYcOisSa0HluJDGWi+dSiPT15jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4FCIxpRauM+6bYGp+moJlYMIQy8N3zK4/ZDElwWZ9I=;
 b=myKL3FGGDeQR7Dtx3IZC77EG8C53ER/fw9B3+Tr6ZshRmMOOFvkCZ6E7LUDcE+5szbiZLNXmRTauWXnnDB3gX6FsbIAruoTpvpUUJhL0gkTwxCF5/6r6RtISVwss7c5TU65tprrmICKbxYpQdy+z7DJXLENHZisIKvRy1rGt3ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) by
 DM8PR01MB6919.prod.exchangelabs.com (2603:10b6:8:14::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.9; Mon, 2 Dec 2024 16:05:49 +0000
Received: from BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0]) by BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0%3]) with mapi id 15.20.8230.008; Mon, 2 Dec 2024
 16:05:48 +0000
Message-ID: <82e98235-4436-4f2f-901c-a25cfacd2673@os.amperecomputing.com>
Date: Mon, 2 Dec 2024 08:05:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sasha Levin <sashal@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap> <Z0TLhc3uxa5RnK64@arm.com>
 <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
 <Z0dhc-DtVsvufv-E@arm.com>
 <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
 <Z0h6Qtleb-znhX3u@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Z0h6Qtleb-znhX3u@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To BN0PR01MB6877.prod.exchangelabs.com
 (2603:10b6:408:161::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6877:EE_|DM8PR01MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 6927b4eb-1be1-4774-b59b-08dd12eb2fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlZFbTl3RFRpTkdkUWN3UGFiUTdFRHd0bGpNVThIT1ZwVkh0NXZBcGtGNGpZ?=
 =?utf-8?B?SVk3REVmRmZPT0tGbzl6OTFwRU1iUnBLVUROMk9wTDhSL2FKekE5YXd6OVNo?=
 =?utf-8?B?elEwLyt4eUgxYVlYbzdvTWFNSzNocTVyUGlFekxUalIvSjlwQ2dEVUg1azlu?=
 =?utf-8?B?U1JGcmJpd2owc2xKZy90alFRblFOUGxkaHo5MFZ6eTlSWExuU2dRaENsbVZx?=
 =?utf-8?B?bWM3c0xnYVJDdWpRcGNoRE1oenlYd1QrMEUybzlIOFljZC9SUVV5Vy9UNFBD?=
 =?utf-8?B?WHRhWWtLem45V3IzT09WL25hOGhWdHFZTHdKVU9Vei9hOTNKMVhFMDA1RE5D?=
 =?utf-8?B?b0YwaEdUcmN0ZnZiSWRSWUdRS0NGd1dxSDF3K0pUSFd5ZElSdmFQVSt3Qy9D?=
 =?utf-8?B?cGFjNHpwTFdpSGM0cWlabGZWM0lHMGRiUDBRRkY3bE45Ukc0ZzBWUGVSczEw?=
 =?utf-8?B?MmRqOVowR1NhME1BT3BPOE9ldnZnU29hV2l3TEpUUGlFc3dFdjR3Mmc3VkxF?=
 =?utf-8?B?SmI0SitpUFRJTGIxUWFRTlBiUlBGL0pJaTdIc2czN3pobzY1eDRpY0I2OCtE?=
 =?utf-8?B?YVZPQ0R0cmFNQkV2TmVlQWllR1FsYXJjQThCRXdOODVLeWREZ0ljWjVRU3li?=
 =?utf-8?B?NVdwM0lZT01OdkFNVDVSZEt2aStDRjFUQXBvNDRlMFRFL0VMRlV1RHVEZkpE?=
 =?utf-8?B?eTlkOThEYVRxanZQN0JwZ1pvRXZ0UGhrNHZ1bnR3WGJUZFVuRW9kQldLNXZ0?=
 =?utf-8?B?NHdSNG10elV2TVJua3NPSjJMMGhFb3FsM2MvWWgycG5JUHFQNHdZSi9NZFpu?=
 =?utf-8?B?MW9Cdmx2eDhlRVM2MjR5K3Nsd09qd0VnV21qYWlXUUhiSFY5Z1VVcjRpek9x?=
 =?utf-8?B?c1NaTnpscWd6RkhsaC9jeitIMjB5a25JL1hhZTUzdlBaQ0hWaS9ISEZwUVFn?=
 =?utf-8?B?UDRpSy8xblNoRkJ6Y3ZEdktrVDg4dzF1WmlIWjhJT2J1ckhEeWRDMzNJNUFk?=
 =?utf-8?B?K25UbklMZVJRQXBLUDA2TUlDOUhxSHVId1VpMlJtNUxJblZEQUVZVkVpM0Rl?=
 =?utf-8?B?L0RkZHRCYllSc3M3MDdUcEk5MldLK0NCbWt0RSs2M1ZLNExpcnBuSEpOTzQ1?=
 =?utf-8?B?YUVPd09LcGlnd3ZrY0h5c2dYM3RsbmhBbUN1STRkR1N4YlZkeEdSWGFzajdq?=
 =?utf-8?B?QjkxbEROd2ZwK0NERFMyWFRjU0ptUnFYZ2plcFYwc2lkUUczUXUzaTR1Z2pQ?=
 =?utf-8?B?dVcyR3dIVlRrQU5EZzdwbkgwWFVNTFlUbC9rSU9rOFpkbml6TFhyNG5zWDZU?=
 =?utf-8?B?VGswY0lDdnFXM0JBbzFrdnRPZjlJdWNlQkd4VVU1a3oreEpIejZVenNCWUdJ?=
 =?utf-8?B?eStIR3RWZFZoSUtQRFpGb0dZWjdRZVJFazZOZ0hUK2dtRlQ4Unc2QzlQeDJU?=
 =?utf-8?B?THZIdHU4aG1DUG9wUVIvTHE1Y1lPZy83WUVrdzhSbEpla0E5dVBZQ2E0ZWZq?=
 =?utf-8?B?dzVOZ3dIcVVQM2RJYzVGTGhSZVNrQ1pYN0tSVzlvbkx1QXVRbDlIZE5xOEJO?=
 =?utf-8?B?WDc0TGVNbzdiYTF2TWJOMkh2RXdrUy9PaHBReC9FZUUyVWROeDM5K3VlanpE?=
 =?utf-8?B?eHluZ3NZZk90YVMvQ2F3OWUrVS8yN0Z0R3dGbkZ0K0U0eXdhbm8yclRyeVhR?=
 =?utf-8?B?MzBNV0NwV1A0RjQ2bjFwYTZsZ3FHVitXdXVmR1hMelhMRUVYVnhrZkRxSUVQ?=
 =?utf-8?B?WkZQZVlyYURKTjZnTGIyQU11dElQcWNJbVRhcjdsVFpFUVBwNkJiOXVLNFBY?=
 =?utf-8?B?RWhpd3hZcjZTdXZrby9wUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6877.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTlnenBRcllVYy9hbk9mb0ozd2ZmVjFVSEwzVHlCMGNOUWpNL2tWTGdiSGVP?=
 =?utf-8?B?dFJ0eVluY2tTNFhVRmgwRFZBSXREUEVJMytCNm81c0V4eHRmTk0xUHNHL1dn?=
 =?utf-8?B?UWVrWTBqUzNSWkVLQ1YwQ2xKS1pMR0pQVzcvTW0wMmlQdHBUMHh4MittSVk0?=
 =?utf-8?B?UXRPQXl2ZmxNYldrNWJMdHdBdWRjT2NZcytrV056K2lJcVltMXd4dXA4aU5a?=
 =?utf-8?B?Tm1lQ0EzTnlLU3dCOWJDVDdSTGdLVUllK0hoTDVWMUxwZENpMXF0TnZmVnBS?=
 =?utf-8?B?RU5PWjFlS2xReWNKZnVseG5iRm8rRFBoOXhseGR5aTdDZUZWS3FwY2Fxb3lh?=
 =?utf-8?B?RG5lNm1nQ1dSeUtlcGJ2Yis5cXZ1YWVnTEN2bTFiSUl2ZWUxQmNDREZFYWRy?=
 =?utf-8?B?LzNzSG9FdUFKWXA3cjZmV04yU21EZVNYQkVZZy8wVjFJbGI1aklMWHRyMHda?=
 =?utf-8?B?SGwxMU81Mm53bmVFcEFnUTBnUEdRY29Zd3Nnb1UzdmtEMnRQZ2JQbjhiTUhU?=
 =?utf-8?B?VFQ0eGNxS1RKZi92ZnFjdGJ6M0JlL2FWUG1XYTVHckp4SHRwcHZlMFJpYmpr?=
 =?utf-8?B?M0x4TWZFUDVVZWFuanh0TXFjUjNnajRUanVNMUVNQnp5NnRxODBaNkoyb3A0?=
 =?utf-8?B?dS9MVjhHMml1QzlkbjhycU10QkoweVVZRkI2aFZ5SlRkY2M3anl5L1lZV0xh?=
 =?utf-8?B?eXdNRkw3aFVZOGJKcFNjMllNYzlvSnMxMnFXdlcvWE1ONTY5SGRCZGF0NnNW?=
 =?utf-8?B?MGFpTHVLNG5zc3NPaThKV1ErSlR0cDhLTlFoYURJbHFBSm5oMjZtbDFpdVVB?=
 =?utf-8?B?MzdFeVhEclV3ekUxdy9QemxKVkw0bVJueFJldnIvTmdtZjI4YzJ4TzhtaFZO?=
 =?utf-8?B?cnZ5T0JEUnFnaDY4dzFNV1JKREF3TEtaSjFPOHhpQjRnWDJLeDVQUVM5WGtF?=
 =?utf-8?B?ZnNkQ1NZVlppeG5zQm1kQTRaYjkzNnI0UlhLMklKMFd3RkdXcXRUVExBOFpo?=
 =?utf-8?B?V1BlTHl4ajRSWDk4NmNOSTg4b1A4UlJsZGxxVkxkMUdoRFhGYlVLV2NtSnB0?=
 =?utf-8?B?dXFMQnR1RnVpOWVyYmhxZGJaY3AxUjMwMWJxUnhudzhkRWs5ZHJPMTdzZUU1?=
 =?utf-8?B?R0pqTHlDRHhvMGtkMHlMU0Fyc2J4RW1nREtKcWpPdXlEQVdiUFBrcXluK1RW?=
 =?utf-8?B?MmlUcnkvZGZhalZ2T2VscW0xdGp5aGx1VWtnY0NZL2RLajc3dGdzQjhGeGZW?=
 =?utf-8?B?RVdlelpIeitsblRhQm81QmM1dHI5bGlHbU1tdDNHSmJxUzFRQml3dzQzK01M?=
 =?utf-8?B?N3gvSmE4NWs4cHFoUzlCTTdvbjBpaSszaUhwcXRnT3JTNmI2WFRxTDRmdmQ4?=
 =?utf-8?B?bWtMcEg1ZzJjR0xDWi9GYmlEektQUkVLL3k4WHBOT2F5NTVVeDhpenppMUEy?=
 =?utf-8?B?SWk3RU1GbVpqcy81OUQwQzNxdDhBOW1qVTEyQlZNWVVhSWVLNXUyTkxIR0tl?=
 =?utf-8?B?ZU9DOXdobnlMSWpaMkRjbDNBWnN6WTVQakVzUW5nTU5PeUdmd0ZCUXhXMSs3?=
 =?utf-8?B?MEJqNHhZQTQrNXF0UUl4QnYxZTNVY3k2QXY5WlNEVEx2Z3AxbUtKU1JCZ1NH?=
 =?utf-8?B?aXJiQjRVQ2x4TVRKQklxTTV0RWppY1ZYcXRvMnhUY2psRkxhZVVoRlRTdy9M?=
 =?utf-8?B?OGdpcUxNbG1IZkhXYnNLbmtBK1NvMjdFeGhTRTFyOWNmV1g4bmNsbG1XT0tW?=
 =?utf-8?B?OGVWcndrWDFjQ01LTmV4VlJJK29BMVhsclpUWDdBcExLdm1ib1UrbityRFBB?=
 =?utf-8?B?L2g2NU94S0xqTEl2Y3QxWVgwOUVKUlJWcVBoWThrTGpLa2lOQmhTSDZnRUpB?=
 =?utf-8?B?SlVhL0FPNURzUjB0eEQ3ZUxmckE1MGt2bmlTZGJWcVA0eVhvWWdsOUw1UnJt?=
 =?utf-8?B?dUN0MU9rc2xETnQzUzFtYVNUSlZ1V0N4akE4TEs1cGFhaTR2QjhtSzVoVERK?=
 =?utf-8?B?VzZ6RTZOTHdBSzI1MW92bm8wZk9DcWQ4aXlNTHgxVEFoSDZ0N3NOK1VsVU9W?=
 =?utf-8?B?OTlvaFh5YmR0Z3U1NlVUWDlLeE1KQkVWaWhkcXQyRC9FVTNIZFB6Mk94RDZm?=
 =?utf-8?B?R2lDdVQxdjhRc1g3NVlXcU1UbHdTWFp2bFJGeXFMczBJRWxWTUZMK3haNnRn?=
 =?utf-8?Q?2k3Br1Xnb/Up1blJ4UnNn+w=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6927b4eb-1be1-4774-b59b-08dd12eb2fcf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6877.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 16:05:48.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXM64D1GokKMG3YzpkhsOZ1yBr1D7uahVf33Vpy5wmeSzIw5jesimN37DdPu0OYa2qjQc+Hjd+HuHUXZ/M8RTgeRpq3r5yK4+Gggcx8qODo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6919



On 11/28/24 6:12 AM, Catalin Marinas wrote:
> On Wed, Nov 27, 2024 at 05:21:37PM -0800, Yang Shi wrote:
>>>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>>>> index 87b3f1a25535..ef303a2262c5 100644
>>>> --- a/arch/arm64/mm/copypage.c
>>>> +++ b/arch/arm64/mm/copypage.c
>>>> @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct page *from)
>>>>     	if (!system_supports_mte())
>>>>     		return;
>>>> -	if (folio_test_hugetlb(src) &&
>>>> -	    folio_test_hugetlb_mte_tagged(src)) {
>>>> -		if (!folio_try_hugetlb_mte_tagging(dst))
>>>> +	if (folio_test_hugetlb(src)) {
>>>> +		if (!folio_test_hugetlb_mte_tagged(src) ||
>>>> +		    !folio_try_hugetlb_mte_tagging(dst))
>>>>     			return;
>>>>     		/*
>>> I wonder why we had a 'return' here originally rather than a
>>> WARN_ON_ONCE() as we do further down for the page case. Do you seen any
>>> issue with the hunk below? Destination should be a new folio and not
>>> tagged yet:
>> Yes, I did see problem. Because we copy tags for all sub pages then set
>> folio mte tagged when copying the data for the first subpage. The warning
>> will be triggered when we copy the second subpage.
> Ah, good point, copy_highpage() will be called multiple times for each
> subpage but we only do the copying once for the folio.
>
> Now, I wonder whether we should actually defer the tag copying until
> copy_page() is called on the head page. This way we can keep the warning
> for consistency with the non-compound page case:

Yeah, we can do this. Looks fine to me.

>
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index 87b3f1a25535..a86c897017df 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -30,11 +30,13 @@ void copy_highpage(struct page *to, struct page *from)
>   	if (!system_supports_mte())
>   		return;
>   
> -	if (folio_test_hugetlb(src) &&
> -	    folio_test_hugetlb_mte_tagged(src)) {
> -		if (!folio_try_hugetlb_mte_tagging(dst))
> +	if (folio_test_hugetlb(src)) {
> +		if (!folio_test_hugetlb_mte_tagged(src) ||
> +		    from != folio_page(src, 0))
>   			return;
>   
> +		WARN_ON_ONCE(!folio_try_hugetlb_mte_tagging(dst));
> +
>   		/*
>   		 * Populate tags for all subpages.
>   		 *
>


