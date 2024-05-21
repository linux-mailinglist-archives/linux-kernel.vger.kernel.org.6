Return-Path: <linux-kernel+bounces-184881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE78CAD61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745E81C21FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10F873189;
	Tue, 21 May 2024 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="J9c57whk"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2085.outbound.protection.outlook.com [40.92.73.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7452F74
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291009; cv=fail; b=Hl57wlMiwM4FudQK2pr2L9MJr2Ehsl44+L7ohs7fHwHv5ORC9xeKypHZXOP6lehkYJLstdEbRuZXjldKeA7fq6vOGA95X4vNDRcS4l15kgrc3Sfhfp1fX6WfvSM7z+cRrbBIM/nt94VHi60VfUQMYzsPEN8eEfwwwtMCDPFsBsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291009; c=relaxed/simple;
	bh=bm/tnynTifmANTsncJbriqNoGs9/hdNyPBxsAdsmn4c=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cU5YGJIO9VdK8z3LZpq12CeF5cETzBy+bL3oukKpws+CzcZH4ys/LUB3UpHsUzjWuAbWjMD0zcILI7Xy0fNg73eLxn1KgchLlVnaVcilFfZPfzKo24k97lktJyZfokhSkeuK7e2xLg2reXDpqOoniKrWHx6KEm1J2owjLmatlco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=J9c57whk; arc=fail smtp.client-ip=40.92.73.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVgyoYb6H+fiA/7vYrNnNIvLHzmHjElWJOemqEX5ruZx3ynfX54gO4s7y3Y2K04Y6jU+D+FSSaQDs+keW7/TPVxta/J22hNZEvkFndM+ftEoA5s13HpTBqKQNjve8EYmaFLdAzZjHyvDbkD9Npn8BQdx8NQHefTcTQ4CXs3z0IvrTr8TCCnmAxw9eI+Rt1KJ7EWWDk9ex52A6QulneqchBlREAXPZGWpsy+kW3ap1QNjdtqcYJoDXIYizxmuoPTPjb93hZpmDQZHU7AQkczI8wrgGL5yHzmDMB6JMCsZpg1/6VAIky8VsIloRvKExQB/Z34RAyjPKbPN0V3XzNhW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDDQXoGKrogCEZrlFrFQmo7lmQpvCa/4eZSAVfPbWHo=;
 b=WTDc8ZI3SdwLQoGgEP6Wmh6UgUPeI0HKqtyjMAfUnPRRe/tXgwnLi4lbSL7ufM+tlZLCgUAeR4+c0apFZKJNoCpMP5M9h/m6j3K4IxKqHn05W/TNyuHKlU51vNF4PoCRKMhhKeiiAaBLEXFfyRTy3W4aQBimluyxpgiIHY4y0dxnGVwoTUFLY+Ks7lZgILRrItQsL3hYoPUVPIj5c93ZY09Nz7ZdBIVE9Ro+shdTOtWFXslJrqCZ+UqXvqJ1ZduU6cBOSyQf9It0zvQIOmkb/+gctZX0DWXeoRtKm5hrkQeVy4SLxDfvwMhg67wXIO+t7jP8DHnv0YgbQ3BUqFw53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDDQXoGKrogCEZrlFrFQmo7lmQpvCa/4eZSAVfPbWHo=;
 b=J9c57whkrDeppjJ24DvbL3e848XYEpycmFIXJa4lWt5fWeOQ2rt6PPfkYVeTqF+02IkAykpvlehRzR1+EEFtYb/9+AJldIMP+ZUF8kbW3n7u61raIqEQiCyhrCwQ2xyzEDG4/QfBMoqx8SeO/0xTYRtjfYMTBQqbbh5xKkoatSgGWwN0e9QziiT+UxQZMAfFoaITL8rD+AwFC6xK+p/nII1PHbv9LSXimvTDOb5Nd66Nh+jYaVqAQBeEIsQuCCtwd9651vAGe0mWXLFgXo5fKM7sPTC9mv7rIi7j4BCTLPsKbRyVKMyXyYDwMKvmntxgIagkurc55fhzqXmoqBXS0g==
Received: from DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ae::7)
 by GV1PR10MB7980.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 11:30:05 +0000
Received: from DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::64e4:38c6:256:36f1]) by DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::64e4:38c6:256:36f1%3]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 11:30:05 +0000
Message-ID:
 <DUZPR10MB8267047D1C4EB689FB63BABB8EEA2@DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM>
Date: Tue, 21 May 2024 13:30:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Nouveau] Kernel problem with multiseat on one card - Wil be more
 than one window manager on one card
From: Gert Vanhaerents <gert.vanhaerents@hotmail.com>
To: Timur Tabi <ttabi@nvidia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bagasdotme@gmail.com" <bagasdotme@gmail.com>
References: <AM7PR10MB39235DD53D163910E88FDB938E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
 <AM7PR10MB3923E07D6024434077E95EBA8E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
 <ZWsuiq7zrYS-pDli@archie.me>
 <655a02097e9b49c2da7a2be60d7c154a48a916f4.camel@nvidia.com>
 <AM7PR10MB39235076485E2E3905F422508E86A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
 <e046050c7e9be5d4f816d33dd1a9dd50e2de3308.camel@nvidia.com>
 <DUZPR10MB8267520A4F44DA38339969A78E93A@DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: nl
In-Reply-To: <DUZPR10MB8267520A4F44DA38339969A78E93A@DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [FjiKRKomemXX1FGc+gNr/qdOw+JegCoM]
X-ClientProxiedBy: AS4P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::13) To DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ae::7)
X-Microsoft-Original-Message-ID:
 <571bdf11-07ad-435b-bdac-60c4740be713@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DUZPR10MB8267:EE_|GV1PR10MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 2daba15e-a899-4d66-b82f-08dc79895c9a
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	Odzty7/IHdkh+J/A3Zmc/JCKxglwbX0My0T2RWGN5YkyZmeQvGHU9XV1tblStho4K+eXxb1LzLBLZP0/P0oFDBIPotSFh/03DP4a34E8rQgp3WwciHENO1ZgO6UySOcd2IkE5Q5KQtXy4lpP7CcmENdkkZrqTakfdoLf9UBBQnsSbI1D0VY/0n0CtwAnO9qyc7pA8avggTn8+aJDDYYw6ewrv+8x/0D9NkaDKTeU3gXy6hY+paD5M7EFRo+PTHavRmQO8nPO+Ewz08ERtDjOji32FOd6xW27eNgxj6N/4fNbIlhM0s+3nLvbcCBCeW8+qBhcZ4XDccaTstV4j04Z8tIvpGht9yCDZoAXeL83Jwujggj5iCAbUYRvw21FcNMPhbAhy2qAORRtK62k67M5znJQFimv3aNGAok97PV8OrGUWsTYtwj3gz7OY6f/OFz64o+TqumEGNyMlS1TMIEFuFQXkObiQBMMORS2nkqzQeCnBJM3V8jVJkPH6lt1GyrDEr+1A25uDWNXYKifD45oXmVQ6Y0uP4IhwMY133xTqKnvt+F2DsNTu3+cM3/JS1kM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0VLTTBOT1JEeWk0a0krNmJhK0E5bjdPQmd5dTRhZnJlSkI5RFh4VW04V25N?=
 =?utf-8?B?bjJRc1hCR04xT2FxM01BVy9BcEZraUU2VzA3T2NVSUI5Ujc4Kzc0TTQxKzVh?=
 =?utf-8?B?MzJKMGRxN0U5cUlqaDg3a0pXTEJodmpHUG1wbS84Rm5DSkoyRHdLMzNhOEpB?=
 =?utf-8?B?QVlSZHhrOWVRMkl4ZHdIZmlUeFo5Q0hsVmkyVmNLeUdJdFQ4UXc4Y2ZCV2xR?=
 =?utf-8?B?TGRScytsK2pRWkljWC9NdDhZMitwSDB1VVgwTy9DUXJPcmRVdGtVblQ2ZHNr?=
 =?utf-8?B?bTg3djRvekEyZDhTd3JvSXRxQ1FHTzdpaVJiUXVkNzZSL2libmhSTlI4SE1q?=
 =?utf-8?B?TkE0eG5XMC8zem9HMmRHVFhRaW84d3VmM0ZSaEVjRXVib294M3Jka2FnU0lL?=
 =?utf-8?B?NjZaQUU3cWN5aVBEMzdBN3o5Z28xSGo2UG1JWERTY2FFMGRsWjZiM1BpTXBL?=
 =?utf-8?B?NDRSZmlNWm5Bemk0UWw0RGI4YTVmSlk4TTRkV25IdlNOZ3c0Skw4VGtjQ0Fv?=
 =?utf-8?B?Yk1ZRFZVVlVXVnV4STRHNjluYXEycGtBMzdnc1UxQmJ3bndzYmxvWWdOTUNz?=
 =?utf-8?B?RndoV3JOQ0p2OHdDbVhaRFJJMG9RYnNzVjA5am1OOVUzZkFtc24yMldId1pC?=
 =?utf-8?B?a0ZSaUljRkczZDYrbWlYd3JKR2ZOa1gyYlN1bkwwd0NrOVpzakwzd3cvYXI1?=
 =?utf-8?B?SThLcHBmbWdObnAwbnZKRGN1bTMzbWxMdmRBSG9aaUpWZC84U0pWR09xMGR3?=
 =?utf-8?B?b21MQW5oUW9jYlJxYnA3UU96NVVjSGw1S1M3WXFPOGRoYmZPOTdZR1JtcnVN?=
 =?utf-8?B?M0RjTnNVRE9KMEJia05LSnVkb0pNZkJRbUZiYjBmYm02QThvczFjWXo0RkV0?=
 =?utf-8?B?WnNnWjJxaUR0ZGtYd05QWkxFWnM0cDFqVjJOM1JIdXVYV2tmYUJUYm10eDNl?=
 =?utf-8?B?OTFsK2VWTno4alFTTEJ6Y1UrcVZNamMwQlZld0VZVE00dnc2LzY4U29TdElW?=
 =?utf-8?B?K2FnMmJCNGZ0Ym05TUJ6bXFaUjRNeHg5SFJiYkxHZFo1bFlJbVRXNWozNngy?=
 =?utf-8?B?ZEZsQVU4L1YxVmYxTENYTENSNHc0ZEFuTndGTGROTCtmcHA0QTZnekhXd0tX?=
 =?utf-8?B?d3dCK1N2UE8rTjBLVEljSEhUdmR6aHVCYS8wWkNPREVCSE5ocHFuaW9abEht?=
 =?utf-8?B?bHhlRkJ6N0dFVHRTOHdzcjE5czZ3MkFrTU5Ed1dmQ0Qvc0EvMFRMQmdkRkRZ?=
 =?utf-8?B?Z0phYjlpQUdEYTllODVpSE9qNTlUSDkwSXh3MDlFbDgwaWl2THN4RnlvY2p3?=
 =?utf-8?B?VGU5dUl0ZGFJREVxN1lKWlVhcWZvaStMRWljOWxZOG5DNVB1Yy9wVFpnUkxn?=
 =?utf-8?B?STJuUjliSDRncVpJTm9XcDlRMm1Edk5LZW5XWCtYVjVlOUVHakZXT25raU5a?=
 =?utf-8?B?M2h1M1FoaTRCalpqTFdqQm1ZeUNrNERUT3BiR3FsMnBvQnNLUmk1QWcrMm9s?=
 =?utf-8?B?QjcvdlJjcDdlZGV4WlJma2xPN0tMR215R013VTg5OHcyZHJDTEt6V0tqMVF5?=
 =?utf-8?B?NW45a1J5a2FySUMvMTdnZlNCbUdWUVpTUzlhME14WXRHNFpRLzJCRktoKzVE?=
 =?utf-8?B?cHNhT1Uwa3FwWVdQMGFSVytGSDh3Y1BRbTlCbUc3RkoweFFVRVh2RFBwdnRi?=
 =?utf-8?Q?xyiSVB6+teOf1V/8QTq5?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daba15e-a899-4d66-b82f-08dc79895c9a
X-MS-Exchange-CrossTenant-AuthSource: DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 11:30:05.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7980

In the meantime I have contacted everyone who could have something to do 
with it:
Kernel groups
System D
Nvidia

And gues: Everyone says it's not their fault.

But we don't give up. Linux is such a beautiful and solid system. Why 
would it work with Windows and not Linux?

Our analysis has now discovered that the problem does indeed come from 
the kernel. The kernel does not allow several users to access a graphics 
card at the same time.Indeed, to use it, several users need access to 
the graphics card at the same time.
Can this simultaneous access be allowed by the kernel after all?
Or can the kernel be adjusted so that this would be possible?


Op 15/12/2023 om 10:59 schreef Gert Vanhaerents:
>
> Op 4/12/2023 om 15:11 schreef Timur Tabi:
>> On Mon, 2023-12-04 at 09:51 +0100, Gert Vanhaerents wrote:
>>> OK  i will report it to nvidia. But with the nouveau drivers it's 
>>> also not
>>> working. Are you sure it's not a kernel problem?
>>> Because according to systemd it would be a kernel problem. 
>>> (personaly i am
>>> also thinking it's a driver problem)
>> Unfortunately, it's not easy for Nouveau to debug problems with GSP-RM.
>> However, if the problem exists in the proprietary driver, then Nvidia 
>> could
>> fix it.  That would then lead to a new version of OpenRM that Nouveau 
>> could
>> use.
>
> I have contacted Nvidia and now i can see the outputs such like this:
>
> ─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0
>           │ [MASTER] drm:card0
>           │ 
> ├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-DVI-D-1
>           │ │ [MASTER] drm:card0-DVI-D-1
>           │ 
> ├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-HDMI-A-1
>           │ │ [MASTER] drm:card0-HDMI-A-1
>           │ 
> └─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-VGA-1
>           │   [MASTER] drm:card0-VGA-1
>
> But the problem is now the same of with the Nouveau driver. When you 
> do this:
>
> loginctl attach seat1 
> /sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-VGA-1
>
> For the seat1 (the VGA d-sub output for seat1 and the other HDMI 
> output for seat0) and of course the mouse and keyboard.
>
> When you do this, all the graphics outputs are on the second seat 
> (seat1) and not anymore on the first seat. So i need to move only the 
> VGA output to seat1 and not all the outputs.
>
>
> The problem is that linux can not start 2 or more window managers on 
> one card (even if you don't need a multiseat, but use only one mouse 
> and keyboard).
>
> So how can i fix that i can use more than one window manager on one 
> physical graphics card? (without Xephyr or something because they are 
> to outdated and works not good).
>
> I have tried with: Linux Mint, Ubuntu and Debian all the same problem.
>
>
>


