Return-Path: <linux-kernel+bounces-523752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9DA3DABE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DBF3B9114
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A671F63E8;
	Thu, 20 Feb 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="FjYK8ioM"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E11F5845;
	Thu, 20 Feb 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056629; cv=fail; b=m859WComPxhpNlRAa+2cu4acdjL927DrFrDhoptNlM1ocZ+Ck1TLxeQAb2g9dvjT58ZG4Fkw9iu+M5BB50nJfb+kA/h+pkExlzfp6gNzSJwWZAmd80V9ce0n35BKzaNkUzIp/6noLewUdH1CuJfG2WK+hmLWPs06sYXClyuDvT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056629; c=relaxed/simple;
	bh=Qfo+EOtmzS34sT4ACPnELe1104OurewLoEawCxinmr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rloJ51SKbQjR5wSWcr0RllqSOpCH8UAcvxDEWGfuEff260ynaVlFimHtebIjnSrvbWmE/6Uat/7ggQi8l1uA78SXJcrI+15MRzyJMVIS4F9637ICtZjyecl+oQEncm/L40PNxSY7ir26BFU6C3Jk22cPdCygBLFge/lUftVijkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=FjYK8ioM; arc=fail smtp.client-ip=40.107.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/aiOQEGDPpmrecCyM2DbJfn0CdFA/EsYXCXPdtoMQ+tsaSKOZJ7/ZULluw0i+OQnRaBZCEStnp+vjT/Tav3p3DHo7eb/4EZoJ8THUhEOq+Y147cPsyQ5P3SNNTBXwUc9Cnx2LkrdbgVA/sAe07fgWdz2+dja7GEjUZvPdjF6R4jeVwvqeKp68HR95kWebSaiwzzMv1llreNWsAP7Gb1h91FLlFFPwZhxram0dFNgjerFkGsz0vnFikZFBZjUr3Gv7FKZn8cGdVL41QQUqJlz0igZPOE2d14EYE0AUBQH/L122yiieqglrbFNxQjFUfPbymJ7Qs/jk11RbvYrIKv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXGj8fOL7mzFSgM5TT4hmy45kIm0wjY4xEE1lcpyIfk=;
 b=ytdvXqYimgE4l8rFDcp0z5Hyn96QuiejH5fZn1I439gtdcvJadNa/XqHZdoQV4qQsoxNH1DNILgXyK5py4yLwef++S8htBhalHivscGaJjxFakJqbCFTPnLz6kMDfF/HCrE7+Fb4oAosMU7BfobFON1MqHiLzsEZCM5OOqIii1xPHlSnwJnoPmEqgW/9DcZ0evXEjXol5qU5dSHobWXligr4HNYVlk3kPV2XhJ/QmVC969Uu/w/PQi5SkqwWlfIG5/b58ajuEgrSlWvP7aKCSLrpOuykhkPb1Yx0SkqnnhUYY+zrFSpYfIL7qTH+i/Yjx4XzHkUv2Y/Xjw16xlSgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXGj8fOL7mzFSgM5TT4hmy45kIm0wjY4xEE1lcpyIfk=;
 b=FjYK8ioMf8z8RzLSzywuj9f6lH5/MXH+OQGcp+LjGZDqzOXPgLDMxF/fJthhkBouvYRZpLrwdx/ig4uHJ8GNwUDyiqPwdpnD3gU4+avaKMtVG6yjkU69QwDhx5LaObX+VLerWHGzuelqqIbtt0UTYCQd0AJjDn/ncINOAD8lwdJMv2sPolPCQoisbxzba0qjMkw0ibMkF9IItEBntmGmNzFR81v9w0aWUZY99fpow44qdWtf69TUnWbGCzaGBdDuvg+T1A//3s4ZWNdRsrWMb+mqu5JxKMCZWL031zQezOtpJz7Nb13+161gqMfY0b8VNvwE/aBNi0fE84PXpDrUGg==
Received: from SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) by KL1PR0601MB5512.apcprd06.prod.outlook.com
 (2603:1096:820:bc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 13:03:44 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:28:cafe::d6) by SG2PR01CA0174.outlook.office365.com
 (2603:1096:4:28::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend Transport; Thu,
 20 Feb 2025 13:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 13:03:43 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C2141512A743;
	Thu, 20 Feb 2025 21:03:42 +0800 (CST)
Date: Thu, 20 Feb 2025 21:03:41 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH 4/6] arm64: Kconfig: add ARCH_CIX for cix silicons
Message-ID: <Z7coLVPh7TkQWYU_@nchen-desktop>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
 <20250220084020.628704-5-peter.chen@cixtech.com>
 <22142d49-b6ba-43d3-aefe-ae64fd867e8e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22142d49-b6ba-43d3-aefe-ae64fd867e8e@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|KL1PR0601MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: 84baf534-e4bb-4c73-6dc0-08dd51af0125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C2HHjMM2nmel0Xs7H8nWTpJ0bW2uQTHtOdA05/o7ZXsfz6aWxc9VqgR4JBrY?=
 =?us-ascii?Q?g7B0ixtHN7d1/MPl/07ZnBhYx/0cgkZgmA0MG/l9w0I/CN2fDKdkuyRGKDzW?=
 =?us-ascii?Q?yvlCMWnmmogFgbvzRe6Kv1pzTUidRZ6XI64lPvGbYa4I34jOx0UcNGD6B1+e?=
 =?us-ascii?Q?lQQQBMfBHMWZQBlc8Qr/VfFIJC0nwQ2T254GUI1JFmb4nFE0JNk1ZygQuW3p?=
 =?us-ascii?Q?yQVVdpVPF3vUo2pJdtUtBqaLkFDoxkNh71sjVj95bk49k/02Vpl8i74qwx8N?=
 =?us-ascii?Q?UMecCu0OB4Wx9CZm1wIlay3skf8L+YCGI3BYhGkdc5v+1Z35YZat/v1xXiFO?=
 =?us-ascii?Q?maJ5B8uOFV3L2PhSRZdQP9msDfNOYy/o8d7UKf4Nkt3Xl3XIvH34ccpfKjTY?=
 =?us-ascii?Q?9u4WRqFRGWA4OsjK8n1jhLtmHWXAL0RsrBQ4tnyWYljfVwSw2182rT9LOBbK?=
 =?us-ascii?Q?JO53BYv94/MiAqi07fH0NxkB0u6/e61spoPoFHccISw7gSF50SvqXJjMIVBd?=
 =?us-ascii?Q?sMd25c+9LFfp9veQe+BSWLIXO5VakKGUcHbqnFrJMjrPabKS7o2JJdf3Nm2f?=
 =?us-ascii?Q?o6yynBecZsH/NmbZHnvxb94R8KMtKr+lfTP9BE92SJ4KNhrhWmfjQrW87rmx?=
 =?us-ascii?Q?BH/fD+nznW68Ze5zAqJO1ckYl7Wc2gdg0HnTeKSP3fPyL/s2bmhANBEiZdx4?=
 =?us-ascii?Q?pyf2eLc0VzJhV6VkFUxaBs3hB15rIyPrvrO7Z2LAQ8huSD2dLzz7J5/PqyrZ?=
 =?us-ascii?Q?rl5t6G82bzw1u/ASFS0XSxEi4GdqLN1D2GHc1U+o1kqbEtXfMZqMtMhpytAF?=
 =?us-ascii?Q?fhYk0Tz+VTHIotgMy6gwXybgPlfb+0HuC04RKfcqjuoNOUH/Q3ioq6SQn4pY?=
 =?us-ascii?Q?yVkfO250N2YgmYI+hUbt5MAsOgzyhXrjc1eb5v1e2XR4FOGRFtQDGBhPnO/i?=
 =?us-ascii?Q?UaI572l43xbV7NthL0o/fjKqEnlAI7i5PVg9IptpVDqXPMd85lLxRU/64nSg?=
 =?us-ascii?Q?1GuPyBxCXcNt40pBUTv49I1MQ6ni2rlvLYHSVLYUhQua8yypmAKVetOUq2xq?=
 =?us-ascii?Q?gcCdx2gfdYQ/4nA9MV2NM9SAaypXKAmoRHZT8FvsNOgKu+qOxz1/1tFBkKf1?=
 =?us-ascii?Q?VA4pUMI048U+1J4mNhvatxnyroIlZsqW8LAhWJnV88iSRf0dHlN9F6N5XkoT?=
 =?us-ascii?Q?BF8mE7fDFJDkfd4SWpw935Ue1csV22FB5U1z5ArC9L19zF3AxEGy8iV+V30S?=
 =?us-ascii?Q?eB9ibpZQkpKtk6NTWwlPIXMxEXpdhCr6zJC7dZFtvtchKn09Gw2xXFNzhWVt?=
 =?us-ascii?Q?Be8DacLuoBWXSMfiI9XdliKwWuV+EBJ63TfpwyFihKilTeKP10yjO/wev5ec?=
 =?us-ascii?Q?Lpg3fuA/2CLstsPnBB/UbhR+4SelQP4+W5Xccz0Xl4+D5gtscuk5+ZEXoyd4?=
 =?us-ascii?Q?nKHyMdU5+Ynx+nlNYRMng8COE2CK9kaD9DLTvvJ81OjiIIMm97/8GYJmOKrQ?=
 =?us-ascii?Q?UmZNqniTJvTI/d0=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 13:03:43.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84baf534-e4bb-4c73-6dc0-08dd51af0125
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5512

On 25-02-20 13:18:38, Krzysztof Kozlowski wrote:
> On 20/02/2025 09:40, Peter Chen wrote:
> > From: Fugang Duan <fugang.duan@cixtech.com>
> >
> > Add ARCH_CIX for CIX SoC series support.
> >
> > Signed-off-by: Fugang Duan <fugang.duan@cixtech.com>
> > Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> > ---
> >  arch/arm64/Kconfig.platforms | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 02f9248f7c84..977b61894cbc 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -399,4 +399,10 @@ config ARCH_ZYNQMP
> >       help
> >         This enables support for Xilinx ZynqMP Family
> >
> > +config ARCH_CIX
> C is not after Z... keep sane order.
> 

Will change, thanks.

Regards,
Peter

