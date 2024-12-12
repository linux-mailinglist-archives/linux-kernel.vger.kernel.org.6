Return-Path: <linux-kernel+bounces-443215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8AB9EE8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EEE16761E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992162144C7;
	Thu, 12 Dec 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="PMk0ZhCs"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9172135B0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013964; cv=fail; b=gShU0Cyd4Wm4cuNCKnCmXNkxwApI2chPZCbOLQTt1nKVA20NsTrAmwkYd7czn3rHUFlNfamS2JECCg8DxB+/cj/jvhsRqWzhBYtNU7htI2VhtS4F9WbD3+IclA1F6YgXAhexImaq/orJ/vqzmZYPUj8kzFC2pnBB3DP3bd1NX+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013964; c=relaxed/simple;
	bh=EiWi32DzsoTLXo3BqPU78eWPk3bV7zGnQj6kXcvFUoo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U2wMdkfwGPxXxAn7jYXAe+OSkSqbLJy4anGTYXjpXMnip3NYDTtMieWIzqdDlIt229Itg/aXeKPvwrpji4K0GIRZmKTEcg8zD4RTIsmP2OPIv7aQc02vKyA3XTRNkJtO+hxWIp+BBX1kPBt7Es411znGe8RXJxQQDjycDXpEIkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=PMk0ZhCs; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+++nRP7eFZdUk4qciZaE2BOV0CQql9deKPMjMnHoTkNxnUp71JH6Hj/sw2cqOUi8mhMdWHpeHSaP2BlMIDlJZvI3G0y2nTjx/T3/QBA5Oyxa0Enj/+VneHH33UoGUSljZ9uPa+IpLqX/Q8bBlTYTh2YjhQgiougFqkcDaLNjs+Y2i5i59h4zrUojq0f7a53AObMKACJOwgHoMStXge5ukEMFxfPERnu0cydOwpnn7JPdxq02ORyQCiUTceAYwKAurrc6BY4U130MM9D1cmtNVVzeQJ1TQAyachGVqiTIyhRJCBMhmo8PYkwomVWCMntFYiiJQqyUqbil71qEOrjDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4J/d9zxWUJEukUvZyzXOIynIDLyx3qmYLLaNHiiXh0=;
 b=q8YvWnnG6z7lRTriuYYOryFaz3SnowOlEbjdo7rkTuGgxofdm9vbaD55+LdCQWEwjbPh5WddBikvfC7nDNkGdzBe2qzvQq9eF4s2cIB/SEUZI1vHlETGGp2lH0pRa9z+8wbCwC7Xf3uyANHT4S1wRZ4BRB7mZME72BI6Ov25G4AUmMFy+im0/2A/4co5MW5g5SJH6KiUF24z2i3sVblFnX1sTDguZYT1rdyEV4mFLNHHaQlk4eRMF71IH6B7v3JN2pewD6xU83wlyMZJ34rl1z5WaD1hlZDOGuckfdNPcIdPguhIy8n1PTMsNVhspphqFb9Wdd+/YSK7OrV5NfvV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4J/d9zxWUJEukUvZyzXOIynIDLyx3qmYLLaNHiiXh0=;
 b=PMk0ZhCs+A8vgqPULa03Lt70h5127hOi+YsjobvTPdcTmqBof+F2J1Rzgr84iQfi9O/M6mx3TbRnXF3R/aqUgDMZimZxTo1LmDMcvxWjro+3GXYlv0jfigKpxUyVZs3diOAZm86ZIYCBE1AgUetEaWRsxFEMEcVK2qb7hBKO0r8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB7620.eurprd02.prod.outlook.com (2603:10a6:20b:42b::20)
 by PAVPR02MB9305.eurprd02.prod.outlook.com (2603:10a6:102:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 14:32:38 +0000
Received: from AS8PR02MB7620.eurprd02.prod.outlook.com
 ([fe80::e5d0:75db:fe23:951a]) by AS8PR02MB7620.eurprd02.prod.outlook.com
 ([fe80::e5d0:75db:fe23:951a%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:32:38 +0000
Message-ID: <621c1b86-0c3c-4ffa-a187-aff1b12ed539@axis.com>
Date: Thu, 12 Dec 2024 15:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/bridge: adv7533: Reset DSI receiver logic
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@axis.com, Biju Das <biju.das.jz@bp.renesas.com>
References: <20241119-adv7533-dsi-reset-v2-1-e12cce42e25a@axis.com>
 <26b95b57-05b6-40c8-b64c-2cb1ae5e8454@kontron.de>
Content-Language: en-US
From: Stefan Ekenberg <stefan.ekenberg@axis.com>
In-Reply-To: <26b95b57-05b6-40c8-b64c-2cb1ae5e8454@kontron.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::32) To AS8PR02MB7620.eurprd02.prod.outlook.com
 (2603:10a6:20b:42b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7620:EE_|PAVPR02MB9305:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce12e11-7da8-4c28-b173-08dd1ab9d39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OCtxMXBmSzZ4K3ZFTHVsSFFMUGpUeE14UEJ6UE1pNnF1QnF1RlQ4cHZwVm5M?=
 =?utf-8?B?SlNGZ1kxQndqR3d3czJWMUc1U0JxTlVpSkVyVmxkSSsyYmtPNW1KYk5KOElm?=
 =?utf-8?B?ajM1ZC9oeG4xMVBpK0QrYzlNS09ra2NsSFdUdkxUYWhLdVFIbnVwWG14SEg4?=
 =?utf-8?B?NFdXQTNQUXpPSmV2ZTBHQzdZYXh5V0kyZWhUN3Y2bkk1eUZOdVZpUTI0d250?=
 =?utf-8?B?azZhUE5hVHpGcEpCYWNEUW8zSGdJQjdPdXluTzQzNkdYL0p1R2NER2hZcmd6?=
 =?utf-8?B?RDQ3UzQ1SCtwWGVxeUVUejlIUHoxc0xITW9VeU5nTzkvYXdmQzdRcmZWWmJy?=
 =?utf-8?B?OWcwak1iYTI4cWRPejB1M3loVTFtQnAwM1Fra2RBMU96TS8wTWxrb3psQTlz?=
 =?utf-8?B?Q05MZFFLQTg4WjFxVGJURER2MEVTcXphL2IvR2JIVEdtRFRjNTZXZTVjOGQ2?=
 =?utf-8?B?cUN5MlNqOXdkVnBndWs4TEFISCsrbUtuU2xrN3dRYnpFYTY5RXVFNjBSQjAw?=
 =?utf-8?B?dmJob3N0ZEJLMDFQRmhnNWlpQ0RzbGUraUtLcCs0QXZOclRRWWtNclFFN0RZ?=
 =?utf-8?B?SE42SVNxVmI1NjZaOWtiYk9zRUo0M0dyMWxha2FYS2hBU0xyODJGTnVGYk1m?=
 =?utf-8?B?dTM1MVZpQXZyT0I3QjZnaVJMNlBFblNwMmVMeE9QRVBhS2ZjQmwwY1RoZHN1?=
 =?utf-8?B?cmdoSFhxZytYTjJwK05sRHBpaUFmcno4TEJxYllIbklTa29xblNoOWRkeXNY?=
 =?utf-8?B?UzFaN3J3S3pWS2o5d1piSC9rRWZpc09OUW5yM0ZSeCtjVFRUT0pibzFpR1FK?=
 =?utf-8?B?Q21NQ0ZwWnp3ZXpTZmpVdHN1Qk9Gdk51U1NCRnZiWlNNc1h0NW1iYWRvYTBO?=
 =?utf-8?B?eXhtWmxnQnpEUkRDaXdhMkxFREs4YWkvYjNBVGZ4eEdrOGtXUEdUMVd0SEVX?=
 =?utf-8?B?TEQ1ajRiKzNreDRuUzM5MHJSU2xDYUd0MzVMMkx5VitWNnN5cnVhNW10bVpK?=
 =?utf-8?B?cGpCdWdOVjRSdUMvcWJvd0w4UFJ3YUs3dy9Od25CdTVUb2s1bjB4SlpQMTE1?=
 =?utf-8?B?dlZ5WXM4ZlVKUkNyRzZtNi9yZFdJWkEwSStUK2s3K3M2OHVZYzNCeHNGVmcy?=
 =?utf-8?B?V0p6bytHbDgraWhLWHd5L2RiK3NSOGIwQ2k1QjFETzA0SEpaUHQ2ajFscmtQ?=
 =?utf-8?B?NG1HRCs2MHJxcnh1YnhPeWZveFdyVi92OFVXRjBmK1pubjdhSzVRazB3T2g5?=
 =?utf-8?B?R1pNNUw5YmtXM2FMSWloZnFtL3hURFRYbGpWLzZRVDJ5UHVkbms2Qkh3R0Zq?=
 =?utf-8?B?S2FOYnl6eWR5QUk3OUxKOFRjS2tFUFhRRTREakFWS0NETksvMTNPYU0wbDJC?=
 =?utf-8?B?a3Roam5QTThmQmRKd0dVdFFqN2tXME1FR1VuVllUcU02L1ZES3lUU0VUSDBk?=
 =?utf-8?B?RjhsdTlRSUY5OVVqUGp0YkxOVGlQd1JOdlIvTlZpcFo2M0NFNXc5SEdiRmM2?=
 =?utf-8?B?a0ozQklzQmlDSVpDU2tpN1JlVE5JYWVTYm8yYkd4ZFBpY3dmRlNVdERPM2k0?=
 =?utf-8?B?Ym5FNkpoR01GaURUcEsyNmJRZlpLYjVuT1NsR1NsZUZwZlN3K0p6K21wM3h4?=
 =?utf-8?B?OFhPNnJ4ckNWZERLTEg3K3pVaXFGcldxK2dDeXNBNXMxWXJlK1pRUDB5b0ZP?=
 =?utf-8?B?TXg1UG9yMGJlQnNISmFIcWN1ZmJUNnYyZ2N6dnRLb3RtMitQRFBvYnlmZG5C?=
 =?utf-8?B?UmppbzhiQytIOVk0MXFmSW1ma3ZvNTdoZkZyTTlLUU5xT3dsUVIrN0FhTWR2?=
 =?utf-8?B?cGlrNXRWdzk1SnpCRjdRZ1NaZWJUYk9kOXIrai9RdVNCZ29sS05IZFZiRnd1?=
 =?utf-8?B?SDgrUzZxdHIrUktrTFpsZmVUTWtZelJkdVY3S2dXWnZMSUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7620.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW9iZERZNy8xbFBjUkRCckgxbFVlVjlqK2dDYStiQThHaDFNM0FJM29uOXN1?=
 =?utf-8?B?YmJGYWdSRXhkVjdVeUM3Y05JTXdpRWp3MllMWTdSeHlzUzlYZUpJRG9Ka1RO?=
 =?utf-8?B?NlFLT2U5RkpBZkJESFhkUmtYVExYMVdrbm5JWXhFMjFGejU2eXB4TWRPVlBV?=
 =?utf-8?B?NDlOaVo1QUVCanMvVUh2V0lpZC9PejZVVVdlWnozVFVzODlVSjA3VmtVNUxt?=
 =?utf-8?B?MHp1M2h4RW5hdVFDVkM1MGwvMjU5cWJ2ZjNsR3cxV2s1Vmhtb0FvbkZleGdB?=
 =?utf-8?B?UGVQd3hLcFBVRmxPMFA3WEM4YkNTN0dGTjIxNlY2YlUxQ0ZXcDlCbWhkMGVl?=
 =?utf-8?B?S0JXVUlZQ3Z3bmZrQXBNRVRQYjdyenVTVkdnNE1zTmppKzFxTUVtWkVQYmc0?=
 =?utf-8?B?S1NOc2NHMHhTRjBNSmNJTldCd2xIbDB1ZEZvNG13RjVCRE5LT3RSd1JCczFC?=
 =?utf-8?B?RFFvMXQvQnFWMnVLczFQdDR0QU1FOW52Y2tBaFZFakJVN3FkeVh0VmMxQU1B?=
 =?utf-8?B?anZWd0tDY2tkS0lOYmtXdHlCOUg4WWxGai8rc2gzZWoyUThHTnRVbnc1cEh4?=
 =?utf-8?B?d1Nub01GOEtXU0tndzJuN3BBdG1JZzFhTDZqWFZDa1V0SXZ1OXJDZjlZMVZw?=
 =?utf-8?B?QVlBdEZEMUpZM3lielh2ZDNYdStOck81MDgrMkN2Zkd0cWlDbURLWmszZGpR?=
 =?utf-8?B?YVk2NDVhZHdxaEJLQkFEOC9jQ2o4QUpud3NSZTMzL29BQUVOTm9xSEtVdkhl?=
 =?utf-8?B?Y0tqYlRkK2wvbnhVVW95WllpQlpxdGxBUXc5WHJEWFV2MVRIMDJDcldwdTdm?=
 =?utf-8?B?bHppSTI0enRjbGRMSG5CM0FwNWJldEYza2NRT0pqaXdsNWNRQzRtTVlPRFgy?=
 =?utf-8?B?VEd3THVnc2FBdklsK3BFTHhvMlBIcGZCL3pmSjg3UUh3a3BhMklMT09pcDQ1?=
 =?utf-8?B?WjRZUkVmMGhndS83RHJmNzZQazJ3V3RkeDhKTWZaQ3RaLzJuaWdpcHg1Vm5E?=
 =?utf-8?B?RFRkZ01WOGx6YkNYZGpLYjM2S3doYS9nUlJZT2VUVmpnYjRWSFdiK2JJdURu?=
 =?utf-8?B?VE5YVTFlMWhKZ3BkWHdWVHFHRVlnN1RIanVsTmpFajRVei9pTDRkSU5wRnVF?=
 =?utf-8?B?blJIZmplTzVUTlFROGxScDE5NU5hUW1EL3EwdENKa2ZDa0ZuY2N3RjlBMHZF?=
 =?utf-8?B?cHdkMTkxRlBhTitWbWFqQWFMNTVvN1ZNeUoxa085OENlTnhzNXRzVXNIOHdC?=
 =?utf-8?B?T1FVajFMejlqMFNqK2l6UFExaldVWVIzOG0zVXZlUjVrbVEvVjAyaDFHYkZU?=
 =?utf-8?B?Y0NVUWlHUzVGSEhGVHhqOTR1NzhaZG5uYUFJQ2NHOThSSncwbFNYejA3NWs4?=
 =?utf-8?B?S0ZraFZQeForVVRaajNaZE1aTklIM214VW9Hem9vbmo4Y1VMR3V6TFBKZUc4?=
 =?utf-8?B?S1ZxZFQwZ2Iyd2lUUmUrYkVEV3RTZVo5MWhzWXhOWTA2bThuN2lwN2lnbFpU?=
 =?utf-8?B?dnFCVGRKeEFDOStmUjFSbkhIZTcxSHp0UjdoZjBjN1NSQUFrNGFielc4QmFw?=
 =?utf-8?B?dzFUc25VU2xoQ09tU2NhZGdpYlNzOCtHdTcwdXJNSEU5Tlg1alhvdFJhWStv?=
 =?utf-8?B?T1ByWmNBOTNXc2ZqMGJWajRaQkpjR3VhTkpGZDlEMzFGQ09WRkNwNWxaWVFq?=
 =?utf-8?B?T29mS2cxNThyTG1LNEpUalRueXMvL2lnTlNFTC91cWVsUTU0eHVYY1JDSUpv?=
 =?utf-8?B?bkhvakdMekJJKytZcVYyNktyQy8rTWwrWUpuRG1wTXcvdWlvL1lDSXY5QVpE?=
 =?utf-8?B?V1hsZlZuL2I0Tnlhdk1lMzdXdVhHZ0N6SXk0QTZrR2JnYUlQaWdtdW16Ni8y?=
 =?utf-8?B?NzdUeFQrZlZTbzd2REZ4b09SMXphSHhaNkZGUktoSFlaVDZrdkpyV202RlZQ?=
 =?utf-8?B?RkpZb0tLRWVDWHQwZjhQOHltZ1ZPeHp3bzFHN2VBQUFrMlV1NHA3VThDQVZY?=
 =?utf-8?B?dDErcDFabXdzSnl2aGJtSlhlR0FLZjdoeHc3N3NiS1c0Nzh4VzVaNG1tSjdj?=
 =?utf-8?B?Q0VkSkI0b1orb0RVeTUrOHN6bjhrazlNQ2t4UmlnbFFjSWhRLzhVMnpOS3Zs?=
 =?utf-8?Q?EPRY=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce12e11-7da8-4c28-b173-08dd1ab9d39e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:32:38.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogQ5GqCy3+0RWVH6yyCMnp8v8eiRbBnm0cviCAweUpCdBbnlT6Y+y0BGw7hXHEYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9305

On 12/10/24 16:21, Frieder Schrempf wrote:
> On 19.11.24 8:42 AM, Stefan Ekenberg wrote:
>> Reset DSI receiver logic during power on. The need for this change was
>> discovered when investigating issue with ADV7535. The symptom of the
>> problem was that ADV7535 continuously outputs a black image. This
>> happened for about 10% of the times that ADV7535 was powered on. The
>> rest of the times the image was as expected.
>>
>> The solution in this patch (placement of reset and sleep time of 200ms)
>> is implemented as outlined by the Analog Devices support team.
>>
>> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Signed-off-by: Stefan Ekenberg <stefan.ekenberg@axis.com>
> 
> If this is a generic issue for this chip, it would be great if we could
> add a Fixes tag here to get this backported. Depending on the scope
> (ADV7533 + ADV7535 or only ADV7535), candidates would be:
> 
>    * 2437e7cd88e87 ("drm/bridge: adv7533: Initial support for ADV7533")
>    * 8501fe4b14a35 ("drm: bridge: adv7511: Add support for ADV7535")
> 
> Thanks!

No problem, I will add Fixes tag for

   * 8501fe4b14a35 ("drm: bridge: adv7511: Add support for ADV7535")

since ADV7535 is the chip I have been using and I know the problem has 
been present in the driver since support for that chip was introduced.
> 
>> ---
>> Changes in v2:
>> - Add Tested-by tag
>> - Link to v1: https://lore.kernel.org/r/20241113-adv7533-dsi-reset-v1-1-6c1069e35fd3@axis.com
>> ---
>>   drivers/gpu/drm/bridge/adv7511/adv7533.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
>> index 4481489aaf5ebf164313c86cbf3447d2d7914ab9..93085c2b872ed98f4ee394236dc66c568c0e5ccf 100644
>> --- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
>> @@ -67,6 +67,15 @@ void adv7533_dsi_power_on(struct adv7511 *adv)
>>   {
>>   	struct mipi_dsi_device *dsi = adv->dsi;
>>   
>> +	/*
>> +	 * Reset DSI receiver block logic to avoid ADV7535 startup problem.
>> +	 * Without this reset it sometimes continuously fails to receive
>> +	 * incoming DSI packets and outputs black image.
>> +	 */
>> +	regmap_write(adv->regmap_cec, 0x26, 0x18);
>> +	msleep(200);
>> +	regmap_write(adv->regmap_cec, 0x26, 0x38);
>> +
>>   	if (adv->use_timing_gen)
>>   		adv7511_dsi_config_timing_gen(adv);
>>   
>>
>> ---
>> base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
>> change-id: 20241108-adv7533-dsi-reset-488c6fbb5e42
>>
>> Best regards,
> 


