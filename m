Return-Path: <linux-kernel+bounces-523750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555CFA3DAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B236D16FCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D1C1D63E8;
	Thu, 20 Feb 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="g+yVesRQ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65FBA3D;
	Thu, 20 Feb 2025 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056557; cv=fail; b=InjlagGBXsHBjVyERcPzrJ8LCBMaGiN1ixzVE6RQso5QgmAEa/Mlfthdz5YCZcfY3yz8TkoFSZDzUUCGRNRNba0AGOfcPwQGjwcIbkCwxE3BBy61p4rx/6NVFQ7C1eCU2BZoAI3VmPitw1hozM2TIZyv2wDXfIDKmu/gbedR6As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056557; c=relaxed/simple;
	bh=YqZaA2n9qsD669H5Tk8kzQbIlLttBlTHt5em1ZE2v9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhPsujdfY+bEQobKJqdbzymc9+X93LiLkEFK3UQk2rwDOg3RmVTA6nAU9fpaIfu2+CKNXXzrEuUs5mHebgS7MmIdomrEFfY96GiIouFuPMzxJhgPRjGgSBDQMS7GyuMN/fBd/uDMcH/m18DHgeiD4exEhzYEOjyZafCC+t5xJFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=g+yVesRQ; arc=fail smtp.client-ip=40.107.255.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOFJAtE2qU9L/H0vsuEWzVomQbSnPvbT6CcJiv2iN3nRHbtJAusS3Nexg/sHRrV6r0Sb2Er2SNs1kcGj4CewtBEk6MGKbL0tIKu1+7Yu3mVnNvVTvgt8ZtpqChPu/BwTGqmsG/PrXPULZv6A5HleulFJduQIdyCjxqgzCDx370WWiZYJKJl/i4JYHJuJ5c2XDYZIiee3tRfh8UDn5dtz61KqIGBw6xmB4haOZiKAaAVJZ3h2KFSbEowRppcyBqFq7U/SDQ0J0UxqnmdxM031tcBoDUAHtwvAIj7etJ8R5j02eLsUJZ5yrE8vkcmdOqTROFcD5HI0RkLUooMFgWnYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCoP7IpccWKpwzJs+D3ogy7FJkrmSjLlKqZ1jzKPrto=;
 b=RXGjkydJIAJEqboDzyBYT+ViULratHUVOxTtjNQecZYwKWieevNHhDTc4TXHXEZmc+2NqdA2+ioed6h0SScCsCDsOpJDz5zq9ZS2l18ZDJbPU7OlWsDCQJQl2jg1jf2KZAXoD8yPJngMML27E7S/Je5ka9i5Qx8596hZlH3zIBEBp0LAB8gu04t3T8WrMTmPCorawrA8ZaRX3tnpc4WMfIgc/IImQ7vB6muU8xVHOW08nAO5GcB+k+KUKi0+Oy5l1gBLGYOj4mPPfav4Zcul1K4U9WdFK9yqX/9OXJHaqhgRtQLEs32rcZ1aDvkmSKtYTAWlQX9JjZIqPfTuLXLiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCoP7IpccWKpwzJs+D3ogy7FJkrmSjLlKqZ1jzKPrto=;
 b=g+yVesRQYgKCYndkSQMMPCcgqBZVawjfmr9CfhjzXyVzUK5oe2K6RfEeyHNf06EBJBKapFsJw6sjxynULmnK7dvVO106Jq3I9QI9vEhAxfLV31HP96SD8kZtbfyCOqYagSD0hlKj2SwX4tg72HLDWPWnx/aIpiSVhsUFpwZW/a3KXVhUoXs9mvqB0YDfZCAUmEzSwV4B2t94FzEpVRoA7SM9YrwHI27MMbg1gguYOg6W5Xtsb0aIbYS99ECXeI9UK4Wr3iqri4GvUbz0PVoU2jZKlnTM83ei6w93xpVHJoZjpG7UV5pAIVTqqbocL8XIydzAIZVHhUGrQ3YXEyQFfg==
Received: from SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21) by
 SEYPR06MB6824.apcprd06.prod.outlook.com (2603:1096:101:1a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 13:02:22 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:b0:cafe::79) by SGBP274CA0009.outlook.office365.com
 (2603:1096:4:b0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 13:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 13:02:21 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8A7D5512A743;
	Thu, 20 Feb 2025 21:02:20 +0800 (CST)
Date: Thu, 20 Feb 2025 21:02:19 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	"Fugang . duan" <fugang.duan@cixtech.com>
Subject: Re: [PATCH 5/6] arm64: defconfig: Enable CIX SoC
Message-ID: <Z7cn23Im0SeHuBFu@nchen-desktop>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
 <20250220084020.628704-6-peter.chen@cixtech.com>
 <30f92eb0-8483-4699-83b9-387a1fdd4931@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f92eb0-8483-4699-83b9-387a1fdd4931@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|SEYPR06MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ce068f-1660-400c-16d6-08dd51aed018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qvo/f2Mz0Rj+6Bv+7pICWWhVx/gQADi8gXioZHZGwOzKQSGtpYSoLvYzQ7EH?=
 =?us-ascii?Q?zYgSkFKzX3Z7DEjtcyIZsRCILBhjlBNjX1bSDo3OMDk72zbDrDYSPeGgHfFp?=
 =?us-ascii?Q?XNjOyfJgbZUlCgesT2M/yG7gFP0fBzmiHL4NRVtxgeiyBube7lnCKwAxLTjx?=
 =?us-ascii?Q?NKFaeVIG0GwMa4PF0XkkrLasG+F9MqZtk+c5/9w/Z7+O5mAsRhflv8KQn+m5?=
 =?us-ascii?Q?4DXkBXoLG0mAMjo7Rxl6o0zLqBzvtz1l2nBma/X+/RcfSJ3M39e34zKKZ7po?=
 =?us-ascii?Q?kf8W7yIwF3NI9RiULYNzlNjRRiWqQ2+0uaNAEMFAOJO0CoWmQP5pa1v1YnZ+?=
 =?us-ascii?Q?u75meYO5+y+XESDNHVNyx3AwRvbqqY7ZkiSlgor+SxTxqC9cLBrOYDZiSDui?=
 =?us-ascii?Q?jotKmB9uJtpeTLhdlLC+g10nCk5Es8ErCNMjWZPkOZRd44vWyimhB/48fTvS?=
 =?us-ascii?Q?IvQJV22PD96nbzhPkWWwK4bi7juS6rtWlRtEQUwzzKWTT72GxJS5ZZ7v6cbp?=
 =?us-ascii?Q?TDiLer7iNVket7a3ubnhcq6PY9oIcMAeIRVjO4YxWgIZD5yc5ARluOttQfM5?=
 =?us-ascii?Q?8lULBW7NZkee3Wxb/JNOuWQxHLBbd8RUqojgRCnESElv+Xf2UblId1DWM8YS?=
 =?us-ascii?Q?VXfJ0WlEqBhY7Ml7PifTtC5KGHNW/qNGe56nHclDWwqH2j+B9DLqWIlrXfm9?=
 =?us-ascii?Q?X5wUe7vnUXgzomW3wYhAM564abVdzs23JWAHNhAVsm2XhhYgI+vzBr+WgIrn?=
 =?us-ascii?Q?4byRH31hcn5BYsNBLHNit9Fln5UkvQsqdPhNWgB93yJOb2fzGsxzj5BQSNsx?=
 =?us-ascii?Q?Dq5LWzTEGFdrlziPpBQYtXeqnp2ITBcI6FL3Y8Hze2zS90H0ZlYH9EUL/G90?=
 =?us-ascii?Q?QhSOp2j7Z/O+aMCtOGZogUl/AiriXw2QTeotHismPPG/LfU0sgYugPgnGJh1?=
 =?us-ascii?Q?rNtN7ZlEsLYlxUQ7vXONz2IILggAjzT0lekSmAPtdd0smdTHgIdpgcaUw9A1?=
 =?us-ascii?Q?9QwFzHV5Uq00pMCNknbfQHjrp99K82r9DCfUaiWal0hxGclTeZLpLS2uVkUO?=
 =?us-ascii?Q?St2uG1YSgiAJNBRnYbLCz5mfQw61HqZ6SGKqLq26UK2t3s10CnO5il9BKu1d?=
 =?us-ascii?Q?prWSu1wU2Mdv2e0yv940WtYDLP254vcLvIeqKrL71PLWbuXCoUaAOdXUobyq?=
 =?us-ascii?Q?CVOQO3IJB1I8x1VVPHDpFM4M0GhO5sWIzUSd+y1gYruY0BQF5t9igr/9gSN+?=
 =?us-ascii?Q?hc9Dw0RBtfIeldXZ76OafrSYJ8vO6ujJwPopXKmVUK7wdetwrucW3aKCT2Rk?=
 =?us-ascii?Q?ZBI0suFaa2jI7z5Ey130fIIVDlMPeMToNSdGWnRwmqwMiIOEjoxDMMCY5Dd1?=
 =?us-ascii?Q?hBlHKXUE3PEymOZdp0DrHs4V0RRclsDyHT1VwxMN7EGy9gSXPBdUUYUOQzg2?=
 =?us-ascii?Q?1a0PU4n8GZ5f4xHI/ltRVtaCfXPYbFRt6Y+H1BK74VVlpTS1CHpS+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 13:02:21.2158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ce068f-1660-400c-16d6-08dd51aed018
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6824

On 25-02-20 13:19:13, Krzysztof Kozlowski wrote:
> 
> On 20/02/2025 09:40, Peter Chen wrote:
> > Enable CIX SoC support at ARM64 defconfig
> >
> > Acked-by: Fugang.duan <fugang.duan@cixtech.com>
> 
> You keep using different names in different patches.

Sorry, I just copy-to-paste. Will change them.
> 
> > Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index cb7da4415599..1dd46d200401 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -45,6 +45,7 @@ CONFIG_ARCH_BCMBCA=y
> >  CONFIG_ARCH_BRCMSTB=y
> >  CONFIG_ARCH_BERLIN=y
> >  CONFIG_ARCH_BLAIZE=y
> > +CONFIG_ARCH_CIX=y
> 
> 
> And this is not in order with savedefconfig...

This probably due to I have not added entry in order for
arch/arm64/Kconfig.platforms, after I keep Kconfig.platforms
in order, the defconfig will be in order after running
savedefconfig.

So, I still keep the patch content un-modified, just change
the ACKed-by tag for correct name "Fugang Duan" at v2?

Regards,
Peter

