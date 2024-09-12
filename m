Return-Path: <linux-kernel+bounces-326106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D239762B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06068B21FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B618DF6F;
	Thu, 12 Sep 2024 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="mUScowEx"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD3126BFC;
	Thu, 12 Sep 2024 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126172; cv=fail; b=KOC9kgTrO6K54J3hLwwyH39VcUcwkgUvAfRZD/kMzZ9WDac2g2ztm27aN4zp9/SD85S0drV+Jv4n67M2AYy39r6XqUvgTCF5QUFshXh1kceb8TEuDOo3k9kijSiub1grCjjOc4n66rpxThg/rRtU9CB6WYUbdvt7NBRde2yoVxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126172; c=relaxed/simple;
	bh=lMeBmpCRCjh6FHd9Ki71Dzpjy2RVNJ67HWURpcYmdRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=im4vCMHs+w4BZTIlkBSuNPD665FacImSJYf1MN0TvtploV9HMIDw48YdjMC1XyhI8B1dP1ON+6HJXrLz8WumE/dbwTtQHyxKI61sRSOIgoA8hFi3G+30lAdaBXYFIU0iPzVpAhxfn68YQ4ybm14DmWX6WWC2cMuPo4oHHkIGT3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=mUScowEx; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COPmVjDnfMcFomWsjo3+B1YUBRnI8Te02uLFm4kJad06vfYY9pzwNyuk3dlYrU9GypuzPXbwMxQ0mTXmfUAy9NPYli5HbJtOnKvOh11d3BoTDOZw4T5IOHgGm3oTxjgf0rPf2gKkP+slY1kjpNOEqV/qhMZyXGDkriJ0quw9vEVmN0zz9s1TI1Nm7mNXFo3s9D6D6dqN36HjpU1u13eL932fRAV3mWHCayQPHpdmet4xFZX/PEhjDfMpllHV1QWICsg88Z09CInBKpVZ4TrgyZ0kKjPnC96pP6IFgPa6M7A6qhi/lG3PEBdIhqC+awwTLUa/nPt5w0o2K41ihFuV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASQD8eOHJFUrJMaXZdG06IB6i8q7WC6ueGv+y8I8mDw=;
 b=DIBGrLwz3QABWDO2k5JWpxTfPMPpayW9CsZKpowft7GlhJ0uNLKiJlj6tVFwNW8t1l1rGeUAv9Ccj5G11oT9fn9fmA5qPOPJTVOcT9NaGVacgyoemUids9Iyde22pL/8afUb9UcLvd/nnbdBBPxpqW8stbUKM+YtBGOCx0D+zKhDglFyWTFNFk73lZ7tWrIKfGNrOxCiGsd1wDsLT4eJ2kROye00ujNMUQOhQoR4udCyDcfvS8NYmulWgPrObZsiiuV5ynk2x3XOBKnSRHUh0SDiGNKHaRMupoDw0s8AlvDDes93aI5IVOwYr+YNZMDmKLiBVA7H8orohDMPm0PQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=beagleboard.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASQD8eOHJFUrJMaXZdG06IB6i8q7WC6ueGv+y8I8mDw=;
 b=mUScowExEsytzXUBaFq8Jhkp2sA54/xIqE54YlAx3MMasGTaaTXfpFV0oIXUiFfhJ1K9cpCUdmt4lvb6sX4fd4a5xD2Tv95WQnCnS87IBE+9dhelfv3upgxjz8y7rgCztuyyYDVPMVT8tEopFTxUPhx5+NaJ55hIcBq4EWB+sFDrKipaTp26EbYc+UkqIXgfTm1LlGTZbJejsPDscvpTBH1nZrBrF4jed1ybkqfy4/A5lQgIYndD73dB6zYQyD3Uw8HjwBqvBJeuzXJ2jy8+4mDV1C0DnkhHkhEHf5XK/5ggWTznPtfDaoVGVxls7SRBvEU5eFcWLdSIWPMxKeb1fQ==
Received: from AS9PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:20b:48a::9)
 by AS4PR10MB5871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:516::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 07:29:25 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:48a:cafe::43) by AS9PR04CA0134.outlook.office365.com
 (2603:10a6:20b:48a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 07:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 07:29:25 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Sep
 2024 09:29:10 +0200
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 09:29:13 +0200
Message-ID: <419bf74e-74cb-46ca-95d0-03b3bab3948d@de.bosch.com>
Date: Thu, 12 Sep 2024 09:29:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] addon_boards: mikrobus: Add GPS3 Click
To: Ayush Singh <ayush@beagleboard.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Ayush Singh <ayushdevel1325@gmail.com>
CC: <fabien.parent@linaro.org>, <d-gole@ti.com>,
	<lorforlinux@beagleboard.org>, <jkridner@beagleboard.org>,
	<robertcnelson@beagleboard.org>, Andrew Davis <afd@ti.com>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
	<dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>
 <2024091149-vocalize-composite-6e48@gregkh>
 <44039255-159a-4284-abd8-a0f558ad006d@gmail.com>
 <2024091151-unworldly-dance-9a80@gregkh>
 <097159c7-1602-4e32-8e6f-9cd023d62238@beagleboard.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <097159c7-1602-4e32-8e6f-9cd023d62238@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|AS4PR10MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: b77f24fa-7b32-4f46-7386-08dcd2fca115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUMxOTVCTHcxeUIyNEFPY1NWODR0UlIza3M1VDdoUmhxa3lCM3JpT21LU2Q2?=
 =?utf-8?B?YlpSekJoL1dOdi9oamZtSHQzWVFwT2lCUUFIVUlaRHNvdE11eDNGK0VyaHBV?=
 =?utf-8?B?UXVLblRrRkpKZERra1BYeEYzQVIyME1nb0lqSDRld0EyWTM2N2ZNREFibmhG?=
 =?utf-8?B?OGN0eU4zL05YcUJqRHF5SnVIdzFBYko2aUhkU2w4TmtuUi9BaWJlZDBXbWRW?=
 =?utf-8?B?SXczMnF0QzFnREJGNjJsWW80UWNsMDlEWVVEZ3V4Y2Nzdys1Z0cxZmEzNHlC?=
 =?utf-8?B?L202UXUzWkF2MURqeEFSdXhqZEpRa2VUTkRLVmJUNkFCTkNDVXptV3BDTnVX?=
 =?utf-8?B?KzdFMVRISFE0OUhhc3grWjA2aXl6SHFGZGo1eDNzWVl3Zy9pQXlaMXdHdllK?=
 =?utf-8?B?OElzMzMzdW16WUg2Qm5aSno4eE5BamdNVE5GSEljMnZwWmtVZWowVEZPdnUz?=
 =?utf-8?B?TVpJNEtBTm5UV04yREJVekJDVWNyWkZRK20zVUVGQVFNQ2d6YzJLcFJ0Wk1E?=
 =?utf-8?B?MitvSS9Sd2s3KzdFMGswaTliVXdLTDltZ3ZvbTVtYW5oUlRxNXdzWlFIUjhT?=
 =?utf-8?B?S3o5MFMyT0dkaFJRZXRJTkk4ZVNyOXVmMzR1QmtLSGM0OCthMnJzWUw0V2Z5?=
 =?utf-8?B?MlQ1UFRObUgrVnhuV3l2dUpMdDM1NisrN2dRdWUvVWFLQUxDUmFKbTRPSTFs?=
 =?utf-8?B?T0FKNW5aenk1cFFJang4SVk5dUw0WkdQemEvekV3QUhmZ3d6b3ptYnFUT25o?=
 =?utf-8?B?ZjN5eU1IdXExT1lzUkZQSThMVVFWTUdkQkh5VTB1ODcxK1V5eEg2eitPTzho?=
 =?utf-8?B?UDhzcWFnT2ZOcFZBWGd2YitXUU5pdmpQYkpUS2dpOE5oVm56ZHpSWjJsdXQy?=
 =?utf-8?B?NzQyZk9QQ3oveXNuRDhuVUV3Q042bk0wNURLeTdOVGlDS0RWRFRkbW1TQ2xG?=
 =?utf-8?B?RTgxQnh1QkFrSEEwZTJiOHYrWVlmSlZ5dGVMSU5MNFFHV1A4MTdXM1ZhUklX?=
 =?utf-8?B?Q3pDY1dTN3ZNZFd5ZEJMM0dPOEJ3QlNSQUI3WFhZYU9ZeW5OdEFkV0VUTHBq?=
 =?utf-8?B?djhEc0lPbmMweHlTNmdhKy81TTBsVXVNWkI2aEZNR2JBVHVlM3JxRXVnNmRs?=
 =?utf-8?B?OXYrSnJZcXI2am9TWmh5ZlgrU1BqUzJtdEJVZWIxRy9RT3Z6RHpLZkJsRHpm?=
 =?utf-8?B?SCt4SWplSHRVY1BPY3FYdjl4RndpVWFrY2h5R3d0WDJRcEY1WjNMcEhJY1Jo?=
 =?utf-8?B?bktDa01SejViN2M0SnFYZi8vRUE5STZWdklwVlZrMDhETGNaSjUxZjNrZjcv?=
 =?utf-8?B?dHh2NURlNXA0a3hWV2JTYWYxTWdvREYxRHRwQ3hBMFhaaEFPWUdiVG5Va21j?=
 =?utf-8?B?SmpvUzBEQUhqaEtNVGY1VDVWeGlPbVZsQURjdnVScEM4Y1JrRnk1bFBOOE4y?=
 =?utf-8?B?SllDV1pOa2JFQUFEcEsxMGp5bStvbEd5OWNhbDlSSWdrR3dYajl2SHp0U09v?=
 =?utf-8?B?UnhzTmx1SE9jMC9JQTZwNUYwMDByTytKbG85a0NiZEg0QzRndEJtQmVWYjlB?=
 =?utf-8?B?N0NETi8wek8wd3p0bnhveDF5MnZCZjVRNkVZT0RaM3hTVlVjNG4xeUpwS3hF?=
 =?utf-8?B?cDUvNWVub3J5M2VIRFppSzRmVUQzT2x4R2gyaDgrM3Y3ZzJEaW5idGdhWVNK?=
 =?utf-8?B?M0pySmk5cUdTMkxHNHVMbVZPRzh6NkVkbVJBQkh6ZHN1UFhSRE10SUxESHhD?=
 =?utf-8?B?ZW1ML0d3bjh0UUxDOUhTNmMvOEJtcXFQL0VYeWppaW5EOXEyd0pCNTBUaTEv?=
 =?utf-8?B?YkRHMWlUM0JtekFZUHJidm1DaXJya2RaZlFPRG9ybDZaVmR2UDVRRHd6Y01n?=
 =?utf-8?B?akh3MWF4ZW1XQVQvTHVXZEo3T2NyckpEVGFzMVBnT2dtclZ4VUR1U1hOT1d3?=
 =?utf-8?Q?SZ3IZ0dRK40BTsonEdHLC+EMKHqQb3b4?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 07:29:25.5272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77f24fa-7b32-4f46-7386-08dcd2fca115
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5871

On 12.09.2024 09:16, Ayush Singh wrote:
> On 9/12/24 01:34, Greg Kroah-Hartman wrote:
> 
>> On Wed, Sep 11, 2024 at 09:26:06PM +0530, Ayush Singh wrote:
>>> On 9/11/24 20:28, Greg Kroah-Hartman wrote:
>>>
>>>> On Wed, Sep 11, 2024 at 07:57:25PM +0530, Ayush Singh wrote:
>>>>> - GPS3 Click is a UART MikroBUS addon Board
>>>>>
>>>>> Link: https://www.mikroe.com/gps-3-click
>>>>>
>>>>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>>>>> ---
>>>>>    addon_boards/mikrobus/Makefile         |  1 +
>>>>>    addon_boards/mikrobus/mikroe-1714.dtso | 28 
>>>>> ++++++++++++++++++++++++++++
>>>> Odd top-level directory for the kernel, are you sure this is correct?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>>
>>> Well, it is kinda a temporary location, since well, I could not find 
>>> a good
>>> place for board overlays but a top-level location seems better than 
>>> putting
>>> them in any arch specific location. I am open to moving them to a more
>>> suitable location if we have one.
>> top-level location is not ok for something so tiny and "special".  Just
>> put it where all other dtso files go.
>>
>> thanks,
>>
>> greg k-h
> 
> 
> So here are the directories where dtso files currently go:
> 
> ❯ find . -type f -name "*.dtso" -printf "%h\n" | sort -u
> ./arch/arm64/boot/dts/amlogic
> ./arch/arm64/boot/dts/freescale
> ./arch/arm64/boot/dts/mediatek
> ./arch/arm64/boot/dts/qcom
> ./arch/arm64/boot/dts/renesas
> ./arch/arm64/boot/dts/rockchip
> ./arch/arm64/boot/dts/ti
> ./arch/arm64/boot/dts/xilinx
> ./arch/arm/boot/dts/nxp/imx
> ./arch/arm/boot/dts/ti/omap
> ./drivers/clk
> ./drivers/of
> ./drivers/of/unittest-data
> 
> 
> Out of these, `drivers/of` and `drivers/of/unittest-data` contain 
> unittest dtso, so probably not the place.
> 
> And the `arch/arm` and `arch/arm64` are for arch specific stuff. 
> MikroBUS is supported in RISC-V boards as well (BeagleV-Ahead). So 
> probably not the correct location either.
> 
> Maybe something like `arch/common/addon_boards` would be better?

Whats about

drivers/misc/mikrobus/mikrobus.rs
drivers/misc/mikrobus/mikroe-1714.dtso
drivers/misc/mikrobus/mikroe-5761-i2c.dtso

?

Dirk


