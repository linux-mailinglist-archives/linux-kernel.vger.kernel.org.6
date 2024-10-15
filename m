Return-Path: <linux-kernel+bounces-365607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8482A99E4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437CE283892
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500CB1D2F40;
	Tue, 15 Oct 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A1tsEJ7F"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2055.outbound.protection.outlook.com [40.107.103.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EB18A944
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990017; cv=fail; b=VDqz5p3gsxY5mNSb7OqLPRvhinnTSbaluXFMWfanDRlp7s/adgXj2mkQX23/otHyDCgu9Q5CiQMj0d8TgGlr5aHo1J4BwPY9B+k8/+rGfQZjX/hcZHJGXcWJfQmUzo6KRURfqMoSRWfJlrJoDWKEXdWat1BvqNVdNqDfwIEYJns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990017; c=relaxed/simple;
	bh=q7flMUPH707ltPwLDFXbp29DvFm5eZs2yXGjSVF7j1o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EwEks67hBbRMX79j8BnwKw/uW8GQLQgje2WBKRLx7dkQt1qZNKtVHlVSFI5/6mL48Lkh7QlvNqDQ8k9NI8VGDpN7W1wyqwLrd0DzQgrYPoE7PCPmYJ224p8E9MHXJ8t9uRz8ylQkK54oW+l/abRbbP0s+RkqoG2XNLJul8I3np8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=A1tsEJ7F; arc=fail smtp.client-ip=40.107.103.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gvd5S7FvhhaRKBA2bqH1RSVK3Ga4zx8uoDZgRGJIef4N3XxbqYKl1eFZHUM6TGkevhXJci7JVz0Xu+4X6qTbCHolcq7W1uG5XOsJkDDAZ0ZZb7OoVmSUiNVU7KJxICdI2N1oWld6rcj8WcxN2ov6qOlhYIOOX3yjcGrYo7A6tDqwPRnxxqmWsFukGb3v9BW2n9/egEPH1zkxrN0US/wCXLBSKGa4Yg1L1+IdXzbK52f07PNP96toS5tNW0aL67M0SR6zq1gIUyM7aAOLQlCOZ6PClAGOTSQNpYtmu5cUhuNFglZTrIwXgaqSCQyxLl1HUHylHw2vYaqvEYBAW64g8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHQjkZXb/6OURw7Kb/Bgp2XF1hBud9V3o4HSC1dLYQw=;
 b=gJNv8iOTVL03ueWhSP57er7cN1BNLZKczOP8u5lBHCjutCZS5JSjACLPl7Idtdxd6tKm0pTv/ktMywvVpV4PJH/YwjOkeBu/CUklapolHbsei5gsUreKMmlf+xXXDVNQJs4+xbVfzM+baeVF/xmjyhz6P52+s8xjRsLxAXxBg8xe4l6ik6rXKfO78ONQ97iHYIqVFuuMn1Yw97rbYUbAHCPNaCixfRUyFk8QJ1dYEIXqej94O1MCcJyR8r/X2j2nnKBUi6KeLpealnDWuXpNNui/zsKzxOGeD0358UVfBPJKymoCbYdsTqFztCZGuuz8E7FqNMqbJBCDApXsOdo6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHQjkZXb/6OURw7Kb/Bgp2XF1hBud9V3o4HSC1dLYQw=;
 b=A1tsEJ7FJXYJNxqLrWe+kwCPLOD3tQApV+AS9ObHTXz073HrdGas/CKXbwiZtKwHVqqkUwvZzE30VxoYO5pWi7GVIN4Q4P1YDv3zxR3lotCl8N92dMk+zTQ6eylnTw9BxcyW2Lp41H5pNMYdgi1BuHA97aWxMOxTyDhhJdhNBU/i6UGBcmkmnTx2Zx44PEZJi0awDcKJqtqqCg/3fbdIWlWeJSYp6+ynwgTRoodYnrkgdfxrjVfXfi8D2DNe91U8UuXc8rE4Qi3FP+cknRvR0JFlFqmiEL9eR5Zx/5vuQQMiUStt+v8FT34QvstdjxskHkqUmmgswMXjL1KNFNX9rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB10771.eurprd04.prod.outlook.com (2603:10a6:102:493::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 11:00:10 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 11:00:10 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH] checkpatch: mark 'devm_rtc_device_register' deprecated
Date: Tue, 15 Oct 2024 14:00:07 +0300
Message-ID: <20241015110007.658273-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:205:1::37) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB10771:EE_
X-MS-Office365-Filtering-Correlation-Id: 510ad66a-641a-4d83-3511-08dced088965
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVoxaHJrVlpLRms3RE0veFJKOUpkdTBrRFkzUnZ2WnFDZ0crNFhzSkRZems4?=
 =?utf-8?B?aUY1RW9pM0s2dzY0a3ZDYjhPTEVXZzJMeXU0M0x5dnlOeDNsaHR0Z2o0dTBB?=
 =?utf-8?B?cHVYRGs4NUVJQkZVTTRNclRveUtiMjZEQmF4UGRpQjBCZHFLNVVQMTJjTGpZ?=
 =?utf-8?B?Q1B5am9vdjUyUlAxK3RDa1d3NDFWRWVic3J2b0RhTmhmZ3Zqd2xOallYeUlH?=
 =?utf-8?B?Z0EwVVZQOVhFdVExQzgrbHEyVTNnemFFT1ZwbDd6amhmU0F0MEpHUzlJS0xC?=
 =?utf-8?B?ZkU1TjNiRHkwWEZ4SWcwdnFhYVhjZmNVZ0hndzVhY25OQ243VFV5MDRsMGFD?=
 =?utf-8?B?QWlQdkR4SlpIdThJWDFzdkJqWWNtQnpkMHBHU2hCWWFsU3dzNVltSEpMd0U1?=
 =?utf-8?B?V0R0NkF2c0luTjhUYnN6NFczNGpoeGsxQ3FZaVB4REhWcWdWSGVTVWZLTmp5?=
 =?utf-8?B?T0x5M085bzMrMWxtdUNnSHJmQlFEL0NKZmRGb0pQQ2t0ZFN3SS92cmRGM2xk?=
 =?utf-8?B?aXhKTnhiUnZyNGp5aXVramJVenoxaEhWU0VxZ1lOY2ZDSG03NkttZk0wSjJC?=
 =?utf-8?B?dWUyUU9XV3pBRjlFeFlhaHRkd1NlbjBzWVNNaXRMaWdiOVU4cXlKZld5T1Fa?=
 =?utf-8?B?aUY1Y1JWOWlTTEJiemZFWWIwL3lQTUZUaFN5N1VzbUh3Z2RHK0NqVlBlRGI2?=
 =?utf-8?B?eDEvMFJFUUIzTkk0LzVETm1Dak1pL0Y4d3JtaFVWc1YwbXN6V0NHWVpUNzgw?=
 =?utf-8?B?NitPMUhqaDlYTEhIcXJyUkhqMkEwMWxQMm5lUzVTOUFRQXVXSDBreTB2YXh5?=
 =?utf-8?B?T2dwUEwxc2V2R0hlVkZTanhuR2pxVW5xSjdlWjFJMDRWcXU4QTU5U0ZxaG5l?=
 =?utf-8?B?ZWdEMnpqczNsMjQva2wzRTI1ZGVCRXpMRDBXaTgzUm51d2tiRzlscmx4aStz?=
 =?utf-8?B?U2ZCaDJUaEgrNy9kSEVkVjI4eXBXL1BPZkNsb2R0dFE4Z2pGY2hXQXp3VmF1?=
 =?utf-8?B?cEZRZ3p1TjFqeXpPSjFxSXg4TVl4Qjh6eGFaWWdVNkNtY3BCcS9qc1MwSTZI?=
 =?utf-8?B?d0ppWEZScWlkSEhqZHFWQ09TRHh2NTA4THMvSnpONStOVGlRVkZGakt6ZDM3?=
 =?utf-8?B?WjVzUFZtQWxHNy9ieSs4UHdwY1JjWk5ZRFUrZkQ0QlIyRHljcW1oaUVaZFR1?=
 =?utf-8?B?Qlo4ZVN6THkxWVo0YUlvZjRHaVR5T0N2MW5qR2hMS0hwQnVsek0xdFZBWkkw?=
 =?utf-8?B?ZmkyRkY2dHcyZHhJTVZVWW41K3dRSkRLbFphMFJDRXREUnFQQWszOG43WDIr?=
 =?utf-8?B?WGNiUEc3RXdKWEJHc1pTTkJ6NEN3c3NxM0ZTaXZvMWZPc0wyajI2NjZ5SzZp?=
 =?utf-8?B?dFRYRExlR2I2dDV4Snd5eXU4bkJDb0Zub0QxRGVDU1V4ZjlQczNmT05sRWxr?=
 =?utf-8?B?cFV0VFFQdkowTDJPNHBsUndzUEMva3huZ3NUM1FLclJXdjliSDc4azNrb2s1?=
 =?utf-8?B?cDdLd2JCZS9iUVlnTlFaZHVhWUFkTWY2TlV2TW1yZmxaeXJzZ1JVTU1aeFIw?=
 =?utf-8?B?WURSNjduSS9zcFU1dGxHbWpObUw2SFJMT2wxeE5pOXArdlJKWFp1eWZ3aE5o?=
 =?utf-8?Q?euA58Js4fX/BMdRkQytSi2vr4MfMd9mH/6QM103t9Jac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2t0SGVWMXFYK0d0U0VpS09GMGhpODhYcWI0VFhCcVdIOVZ0anRtV1g0dVRo?=
 =?utf-8?B?eHFSZXo1aW1EUjVrMjg4SGw0NVRJU2Z5L0JvQXcyVURQZlJZRThSVUt3dnpD?=
 =?utf-8?B?cmQwOFMwZWZhU2txSlJvTnNuVTV1WlM5OUJtR2c1WVM2elJ1dlJnRWtZMlRR?=
 =?utf-8?B?ckFzeGxFUEROQWp2R1NIeUpOUHdqYThKaUhKdnM2ajkvdksweVdNMTR3d3Bn?=
 =?utf-8?B?SENUS1BPSGxpRkNBVGhQS04vNEYvdjZjeWJyK3J6UTRtdHRhcWNXVWRyakJ3?=
 =?utf-8?B?UmpsbUl5SW1POXZQVmxsdXJuT2dTUnRTVnEzV2lMTjc3eEh6M01KaDJYL2V6?=
 =?utf-8?B?RGhCVVMwZklrUWJOeFNrc2ZYa0k0UjgvZjNvZHhhSjgzbUNzb2JtTXY5MkNp?=
 =?utf-8?B?cHJEaHEySU50Yy9oNE04Vk9hV2hWN3BzeVVLQTJ1NDlZUWZvdkdLYVpRbWl5?=
 =?utf-8?B?cThBRTFFRE9iM3djQUJiYW83VmdCK1RsN2NISHErMnE0R2JtdXptNHdjTUNl?=
 =?utf-8?B?MENUZ0l5WnJXNWo3Y2NjNXdJYUhFNkduSmF1blo2ZXovejQwQWgwczNTSkNq?=
 =?utf-8?B?MEl6UG9GUSs2S2VJUjdGSW1GOVhSWDIvK2xtR0czMGRIOVJZNHNRT1doQlpn?=
 =?utf-8?B?blZaZGc4Und2MnpRWGp2UWxMT24xNFIvVUlOVy96NWxlT2NMU1hzSVBuL0ht?=
 =?utf-8?B?L1hKWUhiKzh5T0dvM3NuRHZaL2pkTm1GaGhVQUF6c1IreUhlYUZpeDhJUnhO?=
 =?utf-8?B?U1dLYU1FaWdCTUNNUnJSMVRMSmdzMHdHVVBBK09sSDlCV3lGN3FFa3RuaUdj?=
 =?utf-8?B?ZWIzWlUwaUQvT0ZJZy85R2hsaTRqWC9wL0d2U2kyN0k1Y1I4ZVZoR0dlMTV0?=
 =?utf-8?B?SGhwOVhzKzFEemJLK0hHYjRxSHU1aGRha0I3Wk5WaTFSZGN4RHpEa2N4S25t?=
 =?utf-8?B?QkpHYlpKRW4vUFpWNjlwc2xORXFYVnhROHJrRmd0d203MUhBTlZWRjVtZmFn?=
 =?utf-8?B?VnNKRnY1dC9xelZUN3p0WE9iTDFoRHBPM0hEN0h3L1l3Vk5LWXoveXkzZXZR?=
 =?utf-8?B?bS8xcFE0OWE2akhpNmx0VXprL2YybCt3N3VLQWMrUmtNNW9wTXFvYXJ6YTBD?=
 =?utf-8?B?Q3IvdTZFYXBpRFlVNWZIeGtGTFRoQXBNMlk1Wm1PWERRY1cyVU56cHJ3NXAy?=
 =?utf-8?B?YzVDZGpsYjIxTlRCaW9OR1NCRUZhQjBKb3NabW14RjRqbGtPQ00zQXE3QUsr?=
 =?utf-8?B?aDRqQzQxaGtlbmJhdmlqQnRDdm5tSXZxUEVVQ05EVnc5QWZrdkN4c2hIZHFo?=
 =?utf-8?B?aGFaVjFPUHJmZm9pVWpweklnZVNoeDYyUmZ6YmRHNGNLRGtPUml3dUtzWjgy?=
 =?utf-8?B?N1RRdU9uSzlXZmYvUmZIYkg2SXNYZ1BpL2x1WTVwdXpRRG1xd3k5UDM0WkxN?=
 =?utf-8?B?WFJMemtIS1l2eWNkc0pnSFU3UnRkdFZPb3RGc0JKNkE1WUpGZHZlNkZBWmc3?=
 =?utf-8?B?dmNselRSaXdvVHBMR04wYVd4S0dHczc3SHZiUXFxV29LdXYvUCtYNWdRNFlO?=
 =?utf-8?B?a1BhVXh2MXFRMlZWNVc0UFQyczFHUkUydVdsODFnZ3dlMUJkdTBrZmpPRTNV?=
 =?utf-8?B?QUdSd1kzelFmTGJmeWRqMTloWDZJcWVzU3BrMU5UNi9weUJ0WTBId3F0OG9x?=
 =?utf-8?B?emRvSkxyZUlTbHpiZUdtb0RRSmpCZTZNYzZzR01kSmx1a0VWV2N4OTZQMk15?=
 =?utf-8?B?WjNnOTZUQXN0WmV0MkVYNnFQMVBCTSsxTUF0V0p3aDQxODNHRzBBejlZY0FH?=
 =?utf-8?B?TlU2MmdUc1VFa21ZK2s2amI2ZFVKa2pvUWtnOU1tTlpIamhLOGJrTDF1VHlu?=
 =?utf-8?B?amwvRTlYQWVoV3B5R001ZGRVN1VEaTVmTlE2bnQrcmpXcURMVTN3R3JiM3Ry?=
 =?utf-8?B?U0lBcHU0M2RBTUR5WEpFRVlFNXpFcUNVYzJiVEIvZzFBaUJibGlleVpwMlFz?=
 =?utf-8?B?dzYxVzNLdXBjWW9wRkgrTGdJOHduUEtTMG9iRnJvYW5nMmZ1bnZuZnlPYVdV?=
 =?utf-8?B?VlQ0UWdnamRkUE9wcDl2WmFPNVlVMm9oN1FueFpoNzh1Q1FJZlBjN3JRY3JH?=
 =?utf-8?B?UEVqRjUzYUJPcmwxUmxXdndxYW12RDZSY2RxbWkrbDY5b1FpUG9EaG03RmNo?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510ad66a-641a-4d83-3511-08dced088965
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:00:10.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htHDknFjzEexgFwGajvDVLMpfw3DhniEJZBVjg1GYerUZ/+OD5jw2OqVXmzHBcYGrIF749ynXANq0noyewE/nADUKLLkKgdo+ui9bUNBYec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10771

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

devm_rtc_device_register() is marked as deprecated in its
declaration comment [1].

Furthermore, comments [2] and [3] emphasize that devm_rtc_device_register()
is deprecated and that devm_rtc_allocate_device()
and [devm_]rtc_register_device should be used instead.

Add devm_rtc_device_register() to the list of deprecated apis.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/rtc/class.c#n455
[2] https://lore.kernel.org/lkml/20220921114624.3250848-2-linux@rasmusvillemoes.dk/
[3] https://lore.kernel.org/lkml/6659aa90-53c5-4a91-a9f9-01120c88f107@oss.nxp.com/

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..daa1fd2d4a5b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -848,6 +848,7 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
+	"devm_rtc_device_register"	=> "devm_rtc_allocate_device' and 'devm_rtc_register_device",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.45.2


