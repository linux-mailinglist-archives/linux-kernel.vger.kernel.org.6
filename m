Return-Path: <linux-kernel+bounces-234354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3149491C58D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9582BB24E32
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5FC1CCCB2;
	Fri, 28 Jun 2024 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ptotVdRV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916673398A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598853; cv=fail; b=OOxV22Uo45qDCxJauu0/7rKhBZHDTkmvy+0hwzes8O4rJi/2nM0b6M5nBaUwrGQ5oxt4BOry0dRqkfylZzo7eZ6y4D7ob2Ktd/XdMT9A4wowNW3NHM2HMMLqwXo/RTkmfWRFGMvaDN+lRPscqRINYg6fmclOHyYoY3DEk3FpNzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598853; c=relaxed/simple;
	bh=2tejSmI8cDE+zR9+cO8HwZqHo4AYMUVaEYTbPepcrBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t6+bi6tOvrWWsXu4nVK8ETjozCRbFm/DQCucwlOVxGFJl21UdqXq3h7VoSNaB3Z2+T/KKls6vEHc7NMyNBo4BseHnl7+F2wPSSIz/SmZPQYWGGiPPbJtoDQvIOWQfNyPer2hkVzXo2C83q0V+XMLe8oyb1Xdw/pbZOFVkcGKK58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ptotVdRV; arc=fail smtp.client-ip=40.107.237.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoaNTgYZMwcvPQiY8nhElyLP/z4ElIEBIQNfYp7LiWegq9LiLwS6oWeHYKpTmOtLi77Dh9SO+HB3EIpnzyha8QA+ZFB7vfvjyXKYZwlYY065YOkLqpytM7LhDYoHzPGwhnvOAxZtcXWAUBaBZgOhbufbS2Wb/rtPNXE2MFchYliP/Jc57Xcf9UIDOh5llb2+VizqGLMGQjU2sa14ky4pesaySHPZknbOzyPRguIUTDo7rm4uqt+itTALpHxk5RcZDCshfNwAlusJN/ZjaE0dP45nayERxQOZaiPBhAkSvRwn+GxlDcsQnJEFzitCPHv6Na9EwRC4ba/l9wvFMq5tsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aokek1ur7ysrMl+Y7vwbJQ4Tf7TCcPojhWPsZ+uZSBk=;
 b=C4SU8Yj4RBTazdo+PZ87WduDvc3kvKSxICVqvGa4RDvlegsri0rKDHXN//ZmOT1UhahSNM2MxIg3zEOl9qAopshf4/D9S+/EOZjm1zsG51+gLAC9MSzMiABwYvgBpPSe72dxdGx05F8BaIGE3W7oLVYtrzMxYYO+VEjiwnNN42xICZZ+Unas4AeqpPSqgsSq1w/Qe3y53UdCniPC2KKXya+IvLcQJ5rgJRf4cFXxMHh6psi/0+Z53tYv4dajVEdnx1OzTn6XLwCkBXaWv97ILhvYgDyf6RdhdtBmkkq7Q0niFMH/n+c3JBysoThmjwzOTt4/snpziVB+98E8NTeovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aokek1ur7ysrMl+Y7vwbJQ4Tf7TCcPojhWPsZ+uZSBk=;
 b=ptotVdRV+E/bbbRmplNijCMUyCgNuSeCu/VHoD0MoKy0nwNrIqIDQ/46nOQtiIHuKBOV0QWpxooBX8Nc4urOl7KDHRPT3qzgP2Zp/uoDq1eg6bwbE6ZRw0UyOZfWdPUFXt+fX//ez8pk21py9VbUQEr6gxY68WaJXfB519+H+JQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5471.prod.exchangelabs.com (2603:10b6:208:11b::13) by
 PH0PR01MB6777.prod.exchangelabs.com (2603:10b6:510:93::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Fri, 28 Jun 2024 18:20:48 +0000
Received: from MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80]) by MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80%7]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 18:20:48 +0000
Message-ID: <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
Date: Fri, 28 Jun 2024 11:20:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: will@kernel.org, anshuman.khandual@arm.com, david@redhat.com,
 scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zn7xs6OYZz4dyA8a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:610:cc::23) To MN2PR01MB5471.prod.exchangelabs.com
 (2603:10b6:208:11b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5471:EE_|PH0PR01MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe35d8f-5470-44c3-3ddb-08dc979f08ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1pDNU93NU55cnhFVGdxR25mbTFqM3ZqcnlLbDhoQm5QSEpmWndWeVNneXRF?=
 =?utf-8?B?OE13Tmpkd0d5TFhiczA2ZDh0SHdEZ2NQRDAremRkcGVmL3pEVm00MmdxeHBT?=
 =?utf-8?B?cGxtSkN2TTdud1RSenlFNE1Eb21ka1ViVzM2bndzY2w4WVF0b29jc2tON2Qr?=
 =?utf-8?B?cjFSN1Zod0tvay9DM0ExRFFvWVpXMElFMjF5aTd3b2lDS3R6UHhFUjBxWmlk?=
 =?utf-8?B?WUNobFIxbHFDeFRmNitRSHR1Y2h2S1hWcWg2bHRKelpkRDBiYWdGTkFRcSth?=
 =?utf-8?B?bGxJVFNBRnFFbTFjU2xrZWJUaXVDd3V0TmVwMDVDc2NLM2ZvQUxabHZwYWJx?=
 =?utf-8?B?eXlPeEd3ZnhPUXVESjJZbzF1NjZNZnU1R2Q1eXVZWUdGeGhESFZsR0h5cFBS?=
 =?utf-8?B?VUR4UGRuRU5vYWZ1L21DZmYrT2RiOWlwbXNWNE4vbTRBeXRtS3BvZ2NtTmhP?=
 =?utf-8?B?YzMybTFQVnR4aU5IK0gvL3VINTdXMHVaenRsMldEbE1MTDNDL1ZhbmswN09z?=
 =?utf-8?B?cjNiM0YvQkxXNXV1OUpJWXp0a2JNZWh5RnF6QS9MbmVBRHFYc291SWhQOUJq?=
 =?utf-8?B?T1BGL0RNTEU4cm44ZW9PZ0owRW9KSTYrUFh3NzBBVTF2ZmdRd2VqalJiT1FV?=
 =?utf-8?B?Y2pYR0drU1oyS1BUOVh5dEdmVzJLb2RVV1FGeVp3VnZQNVJzNXcrOGc3M2t0?=
 =?utf-8?B?YlFOc0ljdlM0OE40TUFyNVJ3NWdxOEVIbmllNk0wa1BMQWY2aGJzQkM5OUhR?=
 =?utf-8?B?citYY3RGWDBtTzhsV3FrL0FydU1XU2VzZFB0UXJtYXFleWs5bDlaaXErcE5v?=
 =?utf-8?B?TCtadkpCbGZoNGlvZk5EQTZvUTlrNEtGZXB3SWxxTGM4aTlaR2FPNlhPRXZp?=
 =?utf-8?B?TEo3M1ZWWWVTbU50N3c2endvSzRsYnBIVzVtdmVsaFJ2SmFpVHNpdmJ3STZB?=
 =?utf-8?B?TDI3WHJKUG9Za0VNV0c1a09TRnJhcGpvZGNOaDlqbnQ1dXlvWHExYXAxejF4?=
 =?utf-8?B?SUZ4NFJzb1ZBMzhnMzBuUVdoWFBrWElIVFdnNGhnMDVyMDZYdHhlbHVQQnRI?=
 =?utf-8?B?QXVoc0I0UzlReWd1M2YrTUZvT1FtZ1NuQlFUV0p0RDFQWVhNU0I0dkhwbXVV?=
 =?utf-8?B?N0JiL2l6MG4xcU42TFgrWVZkcjl3blpodEhsUHMxWDdCZnNiQmM3TmppRzJM?=
 =?utf-8?B?Njdqd1pGU0lLVjdQZDVmNDVjUlQvVEY0WktaMU51T0NFYUd2aHVma0FiUm11?=
 =?utf-8?B?MC9MeFBrYnl4M0Y4NGZHcW1FRmdYMlZFUDBqdFZLRllyNjRBQUFZNnpXTkVO?=
 =?utf-8?B?UWFOMytOOVJDdVJCMHRDOGRxRWRZY1pWZk5qSnlOUWxqT3g4ZjFxWUxrMGly?=
 =?utf-8?B?RDJrU2oyQ1FWMUQrQXJNcUU2Q0Vlazl0QW5vSlNXUk1Qd0pFZ04rcjVBMTVO?=
 =?utf-8?B?RGJDL1ZSWWR4OHFnVUpIQ2xBaHFmay9XV083Zk94bDBzRTlUbW5OREFwVXFB?=
 =?utf-8?B?czVSUmtDbmUrbHB2eWZnbzNpaUpIN2hTdVlyMWJMNGlCK3R5aHRhTnlmQ25N?=
 =?utf-8?B?amN2eUVjbHY1aTZ0L3lXU1BXOW1FUUQwVGxrSjRtMHVYd0NtTkFvcy96UUZt?=
 =?utf-8?B?R0JETmlYaUtBR2hHc3dxcVJ2S2U4S2NORm9BczZVeWszNFhYcld1VDR6RGZR?=
 =?utf-8?B?a1B2amIwTXVRUFFSekxQZDBaa2QvTXR6ZlN1anRrQkJqMm16elhnaEVXT25W?=
 =?utf-8?B?UXg1TkFxWmVuWWlJVzhwbTJwbFBYS2pWRkNjRG83Y2F6V1lvZ0FGZ0ozalJ1?=
 =?utf-8?B?ZEp5czVlbS9YT1A3OFpQdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5471.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si9seHVlbXQ2elFzK1YwQUpNdWNoNEZRRlBKT0xXbkhBVm9CWUVpLzVJMDdX?=
 =?utf-8?B?VjJaQkVLT1lRaUtsTitqVWFnQXZ6WDJzL3Z4Z0ZaVHdXMVo2Y2l1VTJJSFI0?=
 =?utf-8?B?WC82Yi9xNlFuK1FpWW16S3ZXMEdybVRkOHpsWFpsVDdVd3ZhS0x4eVFUaHJq?=
 =?utf-8?B?VHJaNUpHVlhtdHhEY0ppNlowdUdTYmpOZ0gybGZxZjVUNmNyc3g1UXNzYTBO?=
 =?utf-8?B?VVdwZzFlRjJpNGZaWlMrN0ZiZzZvcE4wdVlrOUg3V2hRTXRacGtiY01QN094?=
 =?utf-8?B?aGVOOVpkOHlBM2tUanVodTQvQlJZeG93bklKTE1VVk5RYVV0eHhuYkVuZ3ps?=
 =?utf-8?B?VER6eUVtM3BkUW95d1BwcWRTeGQyaVNWb2psT0VBUmJpbDlLSVJueXh4Ykxy?=
 =?utf-8?B?YWJUL3lkOVVqbXZIaGd5TzU0QUYyS2RGUUYreDc4YXR5MmpBTXJyQ202ZHM2?=
 =?utf-8?B?RWJzVjVsRUI3WFF1bU5XOFBuM29XeE5RQUU1NG1ub3lpTDV6ZXVaUGxWWjA1?=
 =?utf-8?B?VnlkZE1QNmJhdGR4ZUZPNTlVQ3oxYjJTT2xpaElaT0REZjYyYnhCVUM4ZWYr?=
 =?utf-8?B?RmhFdFFLWnRGMEJHMEV1NUtNd2RuNEQ0L0N2NnM4NUdsaFl3by9BZ0NWQWx3?=
 =?utf-8?B?Wm9aRFNGYncyZ1BGaVNMeHJBdy81cmJLd2I0cHFLZ1Blb0lkYzl1dWdqMTM1?=
 =?utf-8?B?bWtmcnJqSjZ0LzA2aXdiVHplelk3QjZOV2VmRzBneFVZd2ZOc25vb1VieTVs?=
 =?utf-8?B?SnBrSEtzRTlaMXBrTS8rWlRhL2tLUExwTTdtMVc2ek9FTDBIdmZZUlhhNGEv?=
 =?utf-8?B?V3FuTm5oR3dmT0VxeWhHYXc5TG81TmZBSytSLzc5OWlrUW5BakV4a3U3Ykk1?=
 =?utf-8?B?SzFsWisyMjBqdUJpWFBKK0ROdWhOcVpMMm1nd1N1RkZ1RDNPQUtiM05UWlh1?=
 =?utf-8?B?VlhMcE1yQ0FLR3BwMlFKVTlVbEpraUZ1N3NVc0RpNEw4RDZJamoweGZLcXVj?=
 =?utf-8?B?ZmNNbU1CK0FiODBsK0JoK1dSMHFCM0NTTnJ0b1NZSFJrUWE3ZHMyN0p2SFpQ?=
 =?utf-8?B?VUh1YXlUQU5wNmdBcnJVbVM3MitwaVBBQzUzcks4Q3QzdTdNWGlJZjB2aVVC?=
 =?utf-8?B?LzNZeklhOUNacVh5eHVjVG1ZTWtUbWZQVm5ySFhBUEEybUFKK1AzNW83Z212?=
 =?utf-8?B?NG0xV2dQNkFiaElZMUN1UGR0bThCR3RZdHNwUFlhK3R1Y2ljQ2p2V0hZNGRN?=
 =?utf-8?B?RENYUWZEam5zdjdkK21tWUtkem00U1hqWCtGTTZEZDBYc0FWTkErYm51TGdw?=
 =?utf-8?B?N01UNXB1SURNTDNKdHJxdjF6RER1SVVzOVRWMVJvNGFldklVL2JocXZtTTd6?=
 =?utf-8?B?WXBrVFJTNXUyY1RNTmNaS1I1R3pMeXpxQ3MrOWZnSmVZMmVKbXdONDZyQ3lR?=
 =?utf-8?B?UldFbjhTcmh1VEpxaXRrN3BvU3h4dHVteUZ1ZDViYnNOOWg0ak8yTS9rODBn?=
 =?utf-8?B?MFJpUzB5NVRNTWVIa1drZDVvVWJNN2tVYytPaFAxRWJJMVlra0NORnpCZ3Na?=
 =?utf-8?B?VkpxOEVJQ3ZUeXBycU9KbzMvN0pjYkpVcGR5UlFON3lPN2I1MDhpMlBZQk0v?=
 =?utf-8?B?Yk9uSENaVW1LdnVENkFCOUFYbWxJeWt6UlRiT3d0U0thYWVrN2ZYN09LeGRW?=
 =?utf-8?B?Wm11eTFmcFpVeW00eGNQdkJuWld2NTM1SENrYWFvc3I4SXpaM0x1UGMzQlVV?=
 =?utf-8?B?YjVrNUxBeVZLVWZ6NUVSYlFuM2hYUFlNeTRYTDlTUWZvWkM1WloyNVdKSDVS?=
 =?utf-8?B?eEVvc0g0ZEk3Smo4SlIzSEZ1V0Z2eG5icElUUWlzYTQyUFFrRUdaWU93VFBj?=
 =?utf-8?B?RTErTVdhYjk4U25wT003UTNIZnIvajBLQi94MUtXYTA4anc1VXpTWVJ0SHJT?=
 =?utf-8?B?WUFDbitFK1hkZFV1Ymp3MmtBcFJOKzdlelJ4NjhGNU5sbGhPOHVhR09EdjV5?=
 =?utf-8?B?eHIycDJKZlEzM3FtdWxkODY5QUkvbGhjOE9wNVgxQmlHMkZIMFkzY0FjWllQ?=
 =?utf-8?B?cHNxZndNcm95dFAyMWhidUlTQWtYdUZHeVh4bFI4V29NU0hyb01SalAxTG1k?=
 =?utf-8?B?UytrcEVCM0JZakNzaHFEa0E1cjZXWnd5S1B5aUtDN3dCODVpRHY3R3V1UlJ4?=
 =?utf-8?Q?g7JxfKsjbZCmUvOldlNT0a8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe35d8f-5470-44c3-3ddb-08dc979f08ac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5471.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 18:20:48.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwSVDns2pR5W16ePIjtrVI5jdSWmWSKnjT+PdQdN6K674exjUd0g7HeGZ8iSGPhllGYY8wk2Ce4GeTzFlvEYc5zhMy/YH3Bzlg/hWIffcmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6777



On 6/28/24 10:24 AM, Catalin Marinas wrote:
> On Fri, Jun 28, 2024 at 09:57:37AM -0700, Christoph Lameter (Ampere) wrote:
>> On Fri, 28 Jun 2024, Catalin Marinas wrote:
>>> On Wed, Jun 26, 2024 at 12:18:30PM -0700, Yang Shi wrote:
>>>> @@ -568,6 +596,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>   	if (!vma)
>>>>   		goto lock_mmap;
>>>>
>>>> +	if ((vm_flags & VM_READ) && (vma->vm_flags & VM_WRITE) &&
>>>> +	    is_el0_atomic_instr(regs)) {
>>>> +		vm_flags = VM_WRITE;
>>>> +		mm_flags |= FAULT_FLAG_WRITE;
>>>> +	}
>>> The patch looks fine now and AFAICT there's no ABI change.
>>>
>>> However, before deciding whether to merge this patch, I'd like to
>>> understand why OpenJDK cannot use madvise(MADV_POPULATE_WRITE). This
>>> would be the portable (Linux) solution that works better on
>>> architectures without such atomic instructions (e.g. arm64 without LSE
>>> atomics). So fixing user-space would be my preferred solution.
>> Doing so would be requesting application code changes that are linux and
>> ARM64 specific from applications running on Linux.
> Linux-specific (e.g. madvise()), I agree, but arm64-specific definitely
> not. I'd argue that expecting the atomic_add(0) to only trigger a single
> write fault is arch specific. You can't do this on arm32 or arm64
> pre-LSE (I haven't checked other architectures).
>
> IIUC, OpenJDK added this feature about two years ago but the arm64
> behaviour hasn't changed in the meantime. So it's not like we broke the
> ABI and forcing user space to update.
>
> This patch does feel a bit like working around a non-optimal user choice
> in kernel space. Who knows, madvise() may even be quicker if you do a
> single call for a larger VA vs touching each page.

IMHO, I don't think so. I viewed this patch to solve or workaround some 
ISA inefficiency in kernel. Two faults are not necessary if we know we 
are definitely going to write the memory very soon, right?

>
>> A lot of these are proprietary.
> Are you aware of other (proprietary) software relying on such pattern to
> fault pages in as writeable?
>


