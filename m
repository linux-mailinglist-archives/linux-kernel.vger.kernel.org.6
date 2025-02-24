Return-Path: <linux-kernel+bounces-528225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D96A4151A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3396B188DF99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B91C6FF2;
	Mon, 24 Feb 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="tfrd44PH"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2108.outbound.protection.outlook.com [40.107.215.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02442142903;
	Mon, 24 Feb 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377415; cv=fail; b=m//XUgrt4PWkpafUuHlD2soF/vupemqu5I1rFHx1x6K0Wts6unaGiLCSu4LZYYL16BYW/RcZB3OeeRuSc7YS+tYbg49W7GyuLhT5A4wdFYRxyAB/HNPGXgn5GUdZSSQm7yztsXWxWK7I5QMbL+6m3ICWkJM6Fy/JmBusM452nrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377415; c=relaxed/simple;
	bh=nkIAIcS1RFunrNVos/GoPJBsWtP9wATI6b6sRaJwKwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbE8aoeRAcbemFyYwpdjcto0E+G9QniDypZUbstoQBk5OGgyunGe0v0jODM8RldLmJHRtmJxiEy1kn6uCbhO9CGR+vduJ/TUKJYVsZPqpkfIMJTviECT005h4VDqM9wwri3Np5w97MFTF8VHHp0EuZZYgTp8rhFYSaNCHs89xCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=tfrd44PH; arc=fail smtp.client-ip=40.107.215.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMyyv3qK5p9BS0kqxjatB57zNV6tHdE/Lae+KBRq8UYN53obaHyWiT0if6uLPVQvt0Syft+kdBVUk72qkt1L1IqVkzKmspTupfHxXxxoll9LNNHCH8eG3A5UU3BwGJ4G75MiwDz8+ZbWpEWJeeEiyi567b4Iq2ntTXVoUW4DmoaSYPyUQNZa8kRRAD3IHBWORf4GorI719bwkzhK9uzU+ClzmyB0mG5qlsqjrYQvseZNGh7DcxpQjIqcZHj0lIy+LC6zeV3x5VrX2dOW7Wncsiux81ZL8tCIxJ5i++6nFgXT0zxZfXJpwDv8vkSPIA7OSVwGwfoQZHUE5oePE2vbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDpTnnEHsAi4FgQC7LhstlHC0mg0iuvlDcEazgclWnY=;
 b=wD+zP9qM6y37kf6RszMPSBaZWDUwxI1zvTLyW2xytmIxl5YX6WrPdBjxHjmyKnZSW8yJCB2zoYHg3h51SkJ08SPdNtLLm5PeK1Rfbp2OxtfQCP0kHBgrT/O/D+T/6Un8gfLhz2uTdK9AJeosJHePFg1TNt+usNLqXaVV67aTDra/0uRUmKOhcpZqVw5W82RI8pcaJ5/55YMfAfE1XpXj9xIrni+prO54EN7xbzood5cMgF2yhfzNoXWQNrrtCsdZzzXovXfn23nM+kHQUEIFMReqbgmMYRxr0WP23hApoG7YGDCq/IT4nwFsVWmZ6afso8r8FdFAtOB7iI8w/aNPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDpTnnEHsAi4FgQC7LhstlHC0mg0iuvlDcEazgclWnY=;
 b=tfrd44PHfcPM9Ht2aApe12bPmO69vp3CA0oexY5Z0vswJMdxbEGbjMC7j5TyWQve3HjT2txyGUqFfDLVlPyWsMdrCD5kCjbnus0r4z5kPMEHcvSe+IQHptRcrg6nJz7qqJ6iH1xQqKNQGnboip5mI9pPzcfx1NcPMsLw3mWwaobjZqfZVG5SezKn3jWvXZ1jNDVRaCC0SNTidjrzcJndUKPI8YNZcgjLmWBDo1P0jX1UJtbziD4KEGak2etShg5HJCvV5+TQKR5IRYRBnMuu0UPsv2roZ6lu2ve5OmIfALSR/27+q18Yw76W49ZY05SPpnQX8Bf259rdYu77scLGWQ==
Received: from SI2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::18) by
 TYZPR06MB6915.apcprd06.prod.outlook.com (2603:1096:405:3c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Mon, 24 Feb 2025 06:10:08 +0000
Received: from HK2PEPF00006FB1.apcprd02.prod.outlook.com
 (2603:1096:4:190:cafe::88) by SI2P153CA0026.outlook.office365.com
 (2603:1096:4:190::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.7 via Frontend Transport; Mon,
 24 Feb 2025 06:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB1.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 06:10:07 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1777D4160CAD;
	Mon, 24 Feb 2025 14:10:04 +0800 (CST)
Date: Mon, 24 Feb 2025 14:09:55 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Rob Herring <robh@kernel.org>
Cc: "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Message-ID: <Z7wNM_RNRrbuqJnZ@nchen-desktop>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
 <20250220084020.628704-7-peter.chen@cixtech.com>
 <20250221224651.GA195444-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221224651.GA195444-robh@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB1:EE_|TYZPR06MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: c031b0eb-5344-4e52-6419-08dd5499e366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kP2VJS7+cw+XaibpjHRviLkaPBRPU30aoKZUXwqXO1naMj2eylUj2YxS3T6T?=
 =?us-ascii?Q?sXBxvLygcGbRcws1x9dDteacQ2+Lga3nUSRUIQ12L1piuMfimPhMZIb3CIgI?=
 =?us-ascii?Q?BTERNzhCyOcFSny/28s2DaFVndSUSi9KQkWpCQoSEWfIqfR8iyttHi8p5USk?=
 =?us-ascii?Q?ybZYjhIX3RzbarN3O+tXQAEW326sYNI5rT+6HIO82aALxXDGyf13rGlZG8tm?=
 =?us-ascii?Q?Pn4LicOy4DHrrFr5rPqjohJ/u+3R5DvrYwmtupjeGcSP5iVRY3NQe6TA1Tj2?=
 =?us-ascii?Q?a9x1ktrkyZ2j88Hijag0FwrcoUxmgQ22ybzcHb2KK2IbocRk29SAVZEJ4epN?=
 =?us-ascii?Q?JFT5FoHFb+ICAwuOJBpsq1O8oIJykAOAJPUBT5ssKfDmw6CkyhCglnhKwEtY?=
 =?us-ascii?Q?andSC7PprAWq8Bu4Fas+9GAcQPy6OUfLT1rvWQSoKcvLiVcxQAL2dLUS+ZLW?=
 =?us-ascii?Q?7DYEF8j4BRQnfmtBkGIb4F+rLt8twpka+r9JFil6XXlG88b5l5TZ05d59M4t?=
 =?us-ascii?Q?zIjTNa5eG776HXuSR0E6+KzG1lznvb/cdBF9nMHvN2SmDfikO8c54DFhU9gN?=
 =?us-ascii?Q?VDmnNmfktic9eVHzCi8GqHuvCNiu5tLSO72BLOYxdgHp/6pcqxs/gwSkGlxf?=
 =?us-ascii?Q?QJM1rJ3R7C7kBf817ISnQ1IYNM30h+NpEipXf5mfKAcCdXcRVEzN/ac5rVmw?=
 =?us-ascii?Q?IXsP2QJ3mtY2Zd6RU7qSAkg4YWmlyQWYUhLMe+FxrFO5Gik1sMuNsAhnmVWc?=
 =?us-ascii?Q?1rHC4PLG8FH0ZHF1JQx2BQIWN13t83LEz7IwL/TWQsKqwNrhfUkptAmSHGYM?=
 =?us-ascii?Q?aQZCBQ/mMo2moOpO6xlFyod5iozaVbyPzlEAEZsQrsJJ6/H87SePEpPw9hnA?=
 =?us-ascii?Q?dnivDaUpZ8UzUES6wRCzwWBtwOtcL/a2T611ZcqGWAsl4lSvMClrZfXD/UqD?=
 =?us-ascii?Q?MA/xVd9RzD3iiSXCfTQtgulyckE5yYthAEI0nQu8zhcJLnNg3Ol2sYsT30T4?=
 =?us-ascii?Q?sYYlDLt+Q4/NQW9AQDGsTvSJre5udF5mUvwRuiet2yTUKpPDf3h7uwHuxazc?=
 =?us-ascii?Q?3BQPaMdKuIg58z0Mrh8vuUFEKfuJZnMdGYavUfUPRj5QIw2/gy/aUdfI6sqZ?=
 =?us-ascii?Q?SpMDEGe8WFHdc/Xjxx2mt2B6p5t6IzCKZgUkwR+grw0CJ7hQtNvr+mInrEwe?=
 =?us-ascii?Q?lTu6z2Z4znb53CphTU4+eLSbBk2/Ag0+ZCC1RKN6wvWRlbm3CKv+1rAQpqPV?=
 =?us-ascii?Q?Mbza45uuNFL9vNrKBJVkOQKDFlrVrJM0ijbn0srne+YNk6t5wWDLZK1OHKW+?=
 =?us-ascii?Q?h8l3gYBlvgiVPrm3incVOkiEOG02vRbdIEPr3DKoGcMhXtXu9fwVr1/DMGxc?=
 =?us-ascii?Q?EYRNI/fn3Qbk8vgMEjBR9ruF2oHqsKlA8pi6sIfV+C187sOA+Y3WUHb7IYHg?=
 =?us-ascii?Q?thZMvSmePD1qqAWpxaSTzJiMrwd9ZDO4TWrXOqiM1MG4CaOlYPJH9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:10:07.6002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c031b0eb-5344-4e52-6419-08dd5499e366
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6915

On 25-02-22 06:46:51, Rob Herring wrote:

Hi Rob,

Thanks for your reviewing.

> 
> > +
> > +     pmu: pmu {
> > +             compatible = "arm,armv8-pmuv3";
> 
> Also needs the CPU model specific compatible string.

For CIX Sky1 SoC, it is Armv9 big-LITTLE architecture, if we
add two compatibles for both A720 and A520, there will be two
Arm PMU devices, could it work well for user tool like perf?

> 
> > +             interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > +             interrupt-parent = <&gic>;
> > +             status = "okay";
> 
> okay is the default, don't need status.

Will change.

> 
> > +     };
> > +
> > +     pmu_spe: pmu_spe {
> > +             compatible = "arm,statistical-profiling-extension-v1";
> > +             interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW>;
> > +             interrupt-parent = <&gic>;
> > +             status = "okay";
> > +     };
> > +
> > +     reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             linux,cma {
> > +                     compatible = "shared-dma-pool";
> > +                     reusable;
> > +                     size = <0x0 0x28000000>;
> > +                     linux,cma-default;
> > +             };
> > +
> > +     };
> > +
> > +     sky1_fixed_clocks: fixed-clocks {
> 
> Drop this container node.

Okay, I will delete above line.

> 
> > +             uartclk: uartclk {
> 
> clock-100000000 for the node name.

Will change.
> 
> > +                     compatible = "fixed-clock";
> > +                     #clock-cells = <0>;
> > +                     clock-frequency = <100000000>;
> > +                     clock-output-names = "uartclk";
> > +             };
> > +
> > +             uart_apb_pclk: uart_apb_pclk {
> 
> Similar here.
> 
> > +                     compatible = "fixed-clock";
> > +                     #clock-cells = <0>;
> > +                     clock-frequency = <200000000>;
> > +                     clock-output-names = "apb_pclk";
> > +             };
> > +     };
> > +
> > +     soc@0 {
> > +             compatible = "simple-bus";
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +             dma-ranges;
> > +
> > +             uart2: uart@040d0000 {
> 
> serial@...

Will change

> 
> > +                     compatible = "arm,pl011", "arm,primecell";
> > +                     reg = <0x0 0x040d0000 0x0 0x1000>;
> > +                     interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clock-names = "uartclk", "apb_pclk";
> > +                     clocks = <&uartclk>, <&uart_apb_pclk>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             gic: interrupt-controller@0e001000 {
> > +                     compatible = "arm,gic-v3";
> > +                     #address-cells = <2>;
> > +                     #interrupt-cells = <3>;
> > +                     #size-cells = <2>;
> > +                     ranges;
> > +                     interrupt-controller;
> > +                     #redistributor-regions = <1>;
> > +                     reg = <0x0 0x0e010000 0 0x10000>,       /* GICD */
> > +                           <0x0 0x0e090000 0 0x300000>;       /* GICR * 12 */
> > +                     redistributor-stride = <0x40000>;
> > +                     interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> > +                     interrupt-parent = <&gic>;
> > +
> > +                     its_pcie: its@e050000 {
> 
> msi-controller@...

Will change

-- 

Best regards,
Peter

