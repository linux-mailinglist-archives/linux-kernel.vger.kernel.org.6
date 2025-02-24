Return-Path: <linux-kernel+bounces-528103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374B7A4138F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC76C7A5A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576491ACED7;
	Mon, 24 Feb 2025 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="VWnmMkNU"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020087.outbound.protection.outlook.com [52.101.128.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8321A317E;
	Mon, 24 Feb 2025 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740364027; cv=fail; b=mEWdVP1z7Xly/5+FHpUCqfPaOK/xsljgAcOoPoaMNNSCXhfw2uApzjGuHqi+pDp2e0VaG5JJw4S1U3PbqkRf2mzrH3KZT3xJn4VfV8WHDlPesqlHUMGX1k59lyEWq2Ip7lsZwBlKIk+D8q7dEG/dpW/PKgXE1xTbX6liPzblrgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740364027; c=relaxed/simple;
	bh=9460166e2nvsJMw/L0KTefSI0sM862KrWYrVr9Qgx8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxsjDt9u3v2+5DaFQeutLH8VcQ2cb/eZkUEVdoccWZnKOjWGVxKC6IQ7yw2TMnPckSVvltif+f+PQ9LRtyRFUQPqVVBnkdw4sQXv6yADy9ysnxLkpgHY+rcZR2LMieX5K+psxNyNhb1w6IPJkyXLoRRqIwWaPG7QDDCCXPmXeag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=VWnmMkNU; arc=fail smtp.client-ip=52.101.128.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBG1f+RCWNTWgsnimd2yoVLSDAsZNyZ5ZdZ2HPcutLUK0HRmdbUDsAWovrDLzKzXQkzBV6Fn8P8ZMw6WL0Co13wSeZdatE7tlhN236BXE8celykyJ0X0+3kH7WJPDhXMsyEYzJHEySSBcHz9TxhCvpPw77VLFKPtFpMRZIfHD7DwErefj76G7RnViIg/hAO3P/ZE+f064c8D0s81naezI88XpqBsLKkOM/5ofvaMn6Vz3FTfl+u/mLswt6OHlzGvd2o6lRIewVD/53napX7yya3Aiw1BttoR5ztzrHHirDomdO7QPNCIc0rmcpVk0JDSLclknrMgWVu9zznhUgEytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+CQGTKaBKlOk4JW9/8KU0cpMDlr1GgqiyhTkD3wW/Q=;
 b=TCeiqu+DFobv3OdEC9bnLfXcSUILt5vVAAgYelM7ZdC1H5MKo7nL9Q095Ra24t9lRrAokWwgF1CI9bP2wOYv9kg26EbW6MIGxQ0NHf2SvYY55aZTX+EjVWhchkMoJx69TWoXjBwUsJ5BXXOaFaRUzjfVNZ7aXbMrd3zsC9ejyksMm/xjMtyWKfBCXJmVFU9DX1Jup+qkW37yw/gs6EaNeYn21pneddVVmwIvX5cbI4eMz/qZBib7F2tRvc7eP8587ab+3pPAUYCRha45yqu6HF+FpPVMR4mqY6iAELzVuT6QGhXVYbuqqJN57alEeZmPCTJdDWnssJhqDyAzMaDGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+CQGTKaBKlOk4JW9/8KU0cpMDlr1GgqiyhTkD3wW/Q=;
 b=VWnmMkNUUxng1X4tSQf1Fmv0j5gvA4WKAx49+PDB9QsWmwpElnj89/4XOYz9h8NWcm/vy4k1KZrVH80fbPi+a9RNm83MRkBuJ7BnLYhEWFB44PGOdziIZwURjWMxbhvbmoinILb+6DkBnpXAFhACblCtd2c8/P0MRJXIUgKGO+viZ8CRsaOn87Uspc0dwPWT4DtDr6nXDm+eWqeNQOaHmhY7TP5QYT7OtNkRZKXL1GEa2DUk65LQ6WU6/Jim0D4lgCSjfvI4X+0C1kbJCyTObvrG06GL3bMF0qTdFlIb8RfLc7wtzIzPSw/VCQKENHE8zK6P2lJjgO6TluUDdwez1A==
Received: from PS2PR02CA0033.apcprd02.prod.outlook.com (2603:1096:300:59::21)
 by SEYPR06MB5670.apcprd06.prod.outlook.com (2603:1096:101:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 02:26:59 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:59:cafe::21) by PS2PR02CA0033.outlook.office365.com
 (2603:1096:300:59::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 02:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 02:26:58 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4887D4160CA0;
	Mon, 24 Feb 2025 10:26:57 +0800 (CST)
Date: Mon, 24 Feb 2025 10:26:46 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
	krzk+dt@kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	"Fugang . duan" <fugang.duan@cixtech.com>
Subject: Re: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Message-ID: <Z7vY5kHfEGzCCuWW@nchen-desktop>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
 <20250220084020.628704-7-peter.chen@cixtech.com>
 <4add2867-8c09-454a-b3e2-b4baaeccfd44@app.fastmail.com>
 <Z7cga0L6UYmPXoFw@nchen-desktop>
 <5f88cdbe-f396-49c6-bb48-f50cbbb21caf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f88cdbe-f396-49c6-bb48-f50cbbb21caf@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SEYPR06MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 721b272d-dd48-40fc-182b-08dd547ab6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hsw+16N17BYyqlUDes1/Dmyu9it/wSAfKTHUg7h67xcTF5G3BCIQypY4vEqu?=
 =?us-ascii?Q?v4Y90BJdVT0mNHq9P/w/0H3dUVRPez7U4G019+sxndS+27hScRfKIZskx+Xf?=
 =?us-ascii?Q?h6RF9bB4QFPt9rqdMrt3jngjIfl7Ed8sHoYwKlXlh9bfvS+OWC+fRKPDe9I4?=
 =?us-ascii?Q?D03uERoR8qyOr8CQzWN3+VkpWx1vpZQv+xZ8mO6E1ygOyaA/IzqFPR702aZx?=
 =?us-ascii?Q?9qK6h2uVfUj2wG51BHJK7GhClAp8qU3LtYshqLUEiWuInzhheNUY/dmKwyuB?=
 =?us-ascii?Q?EY6VgP+jGpL6KmC/bZoo1uebi/n0BLJWUKG5durC+H/GyVh3/BOhImq/+Mh1?=
 =?us-ascii?Q?UO7rvoK2VvwyVW8stP6DKXPYPMgLvoR3DdA0QMVg2Dl6FQBLYWPPDLgp0jS0?=
 =?us-ascii?Q?VjHgbxIvByZAu/n2xsm9cfR7tgW4Fumiaoc8dYLqLczNImRTgA0Erq/FPWLo?=
 =?us-ascii?Q?ww46/B/tyFQ0wv4vRYhTL+v0EsQLg2PtR0s4U1+iz8GxXBXqFRK2z3KbCL+Y?=
 =?us-ascii?Q?N3WQOgxaACbEV/r2GHX4BuMKcXOIt9jlwmhsEAeKz/fqk5vtTC/dfxJKZSgG?=
 =?us-ascii?Q?UcWxWTeF3fdBUkzySMPYN3daTQiWx9TWT40LVfZoBxTNIYQmsgtcHjKQHpI8?=
 =?us-ascii?Q?3ajmG6yWpGaj4p+SnJwBbnPdJYgp/UzSJM1plGyWsfF8GuTdov/bSnhsYJAM?=
 =?us-ascii?Q?+Ue0+zMIErm9Ryab+SZ8dyPlyEctTAZA7tx3kAkRJKTEFnbo8bGzVXQxJIvq?=
 =?us-ascii?Q?fq4BUW6Fn7T4Em/sEfhAKlmPufK6j1Jr5UBC8LwnJXkN0nCO8ktX5GZ0szrQ?=
 =?us-ascii?Q?vvfdinTvCIGIdP3sH7czQsjzVr9W3lQuvYGMB7l9xXmX2w/f2Hn90Dxj6eHx?=
 =?us-ascii?Q?mDgMGds64Ge2RITl7LoqsxozsiaVKn/9JzlrLEzxul8CRsHSiSgNo3Ub1t50?=
 =?us-ascii?Q?cybvNA6S02tFD8qDWvgPsGndo2AA4ylTQr2Xa8pdIvlvahJN4CCKeYnuewPb?=
 =?us-ascii?Q?Wu6FH4jQPEvDib5Gkmenlf3evlfjFwHtjxJ9r3kaZKE9ezW9DxKMvyerUsZR?=
 =?us-ascii?Q?jHViDmxMormc2bWc3kEg2zrRUZoXWN7ii1KQHW8Pml0ypqTIqyvU6ua1RLfu?=
 =?us-ascii?Q?BV1V0uXEowQIkONq2vckL6Hc3fLrCfbQadiwtRy0s/cWPg9k9jV6EABQGTYG?=
 =?us-ascii?Q?7fEDsVMFPJrH32sg1hMH0v/1ID0cm59EXwDMq4qFLRUi3aanB2w2MJoQkQai?=
 =?us-ascii?Q?VzQutyCJNIDY5id15fL5XBLThzVprQrjZpEbODyY/Wjdd5yczLBXgIZnzoOw?=
 =?us-ascii?Q?F55kQxdRdslj4fK6M3WT71EG7JcfraNWpgC+BwTnshcMjhIAlG+kfz5vwAHw?=
 =?us-ascii?Q?B3t8nZ3/fZnM+zYuhomppNAnTdD3jqt12IonnUxyZndFPEKGeyE4bFq2+oKD?=
 =?us-ascii?Q?ZFLMKTDSEb4=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 02:26:58.1544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721b272d-dd48-40fc-182b-08dd547ab6ab
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5670

On 25-02-21 12:42:23, Krzysztof Kozlowski wrote:

Hi Krysztof,

Thanks for your detail reviewing. I am afraid my email client did not
receive your email for comment for this patch, I reply at this one.

>> +#include "sky1.dtsi"
>> +/ {
>> +	model = "Radxa Orion O6";
>> +	compatible = "radxa,orion-o6";

> Never tested.

> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.

I am sorry for that. I just reviewed device driver patch in recent 3-4 years,
forget doing additional check for dts patch.

> 
> On 20/02/2025 13:30, Peter Chen wrote:
> >>
> >>> +
> >>> +       aliases {
> >>> +               serial2 = &uart2;
> >>> +       };
> >>
> >> Please put the aliases in the .dts file, not the chip specific
> >> .dtsi file, as each board typically wires these up differently.
> >>
> >> Note that the 'serial2' alias names are meant to correspond
> >> to whatever label you find on the board, not the internal
> >> numbering inside of the chip they are wired up to. Usually
> >> these start with 'serial0' for the first one that is enabled.
> >
> > In fact, we would like to alias the SoC UART controller index here,
> > and amba-pl011.c will try to get it, see function pl011_probe_dt_alias.
> > It is initial dtsi file, so I only add console one which needs
> > to align the bootargs passed by UEFI.
> 
> 
> Your "in fact" is not really related to the problem described. If you
> put it in the correct place, drivers will work just as fine.

You also mentioned that in your comments. Yes, indeed the board dts file
could remap physical controller index as different board serial number,
but it is not what we would like to do (at least for CIX platforms).
In our both HW and SW documents, we have fixed our uart usage cases,
for example, UART2 as AP serial ports. UART0-UART1 as uart application,eg
bluetooth. Customer will do their design to follow above rules, and
it avoids each customer writing this alias at their board file.

Meanwhile, fixed uart alias as its physical index is better to
understand SW/HW relationship. Imaging you are debugging one UART
bluetooth use case, your application passes "/dev/ttyAMA0" as its
communication port due to board dts alias, but in board schematic,
it is connects to SoC uart 1, the person to debug may confuse the
different mapping at first.

Also, in kernel device driver, it also uses alias id to its uart
port index, it could better understand device driver hardware
behaviours, esp you may dump hardware register to debug, you could
easy to find related registers if the mapping is the same.

> 
> >
> >>
> >>> +               CPU0: cpu0@0 {
> >>> +                       compatible = "arm,armv8";
> >>> +                       enable-method = "psci";

Will change Label "CPU0" as "cpu0", and name "cpu0" as "cpu"

> >>
> >> This should list the actual identifier of the CPU core, not
> >> just "arm,armv8" which is the generic string used in the
> >> models for emulators that don't try to model a particular
> >> core.
> >
> > Will change big core to 'compatible = "arm,cortex-a720";'
> > and LITTLE core to 'compatible = "arm,cortex-a520";'
> >
> >>
> >>> +       memory@80000000 {
> >>> +               #address-cells = <2>;
> >>> +               #size-cells = <2>;
> >>> +               device_type = "memory";
> >>> +               reg = <0x00000000 0x80000000 0x1 0x00000000>;
> >>> +       };
> >>
> >> The memory size is not part of the SoC either, unless the only
> >> way to use this SoC is with on-chip eDRAM or similar.
> >>
> >> Normally this gets filled by the bootloader based on how
> >> much RAM gets detected.
> >
> > Will move it to dts file.
> >
> >>
> >>> +               linux,cma {
> >>> +                       compatible = "shared-dma-pool";
> >>> +                       reusable;
> >>> +                       size = <0x0 0x28000000>;
> >>> +                       linux,cma-default;
> >>> +               };
> >>
> >> Same here, this is a setting from the firmware, not the
> >> SoC.
> >
> > Will move it to dts file since our firmware has already released,
> > and it needs to support different kernels.
> >
> >>
> >>> +       sky1_fixed_clocks: fixed-clocks {
> >>> +               uartclk: uartclk {
> >>> +                       compatible = "fixed-clock";
> >>> +                       #clock-cells = <0>;
> >>> +                       clock-frequency = <100000000>;
> >>> +                       clock-output-names = "uartclk";
> >>
> >>> +               uart_apb_pclk: uart_apb_pclk {
> >>> +                       compatible = "fixed-clock";
> >>> +                       #clock-cells = <0>;
> >>> +                       clock-frequency = <200000000>;
> >>> +                       clock-output-names = "apb_pclk";
> >>
> >>
> >> Clock names don't need "clk" in them, and there should
> >> be no underscore -- use '-' instead of '_' when separating
> >> strings in DT.
> >
> > Will change to:
> > uart_apb: clock-uart-apb {
> 
> No, instead explain why this is part of SoC - or what are you missing
> here - and use preferred naming.

It is in SoC part, APB clock uses to visit register, and the function
amba_get_enable_pclk at file drivers/amba/bus.c needs it during uart
device probes. It uses common Arm uart pl011 IP, the binding doc
described at: Documentation/devicetree/bindings/serial/pl011.yaml

Since it is the initial dts support patch, I do not want to add
more to avoid reviewing efforts, eg, clock gate, reset, etc.
That's the reason I use fixed clock here to let basic system
work, and boots to console.

> 
> Please use name for all fixed clocks which matches current format
> recommendation: 'clock-<freq>' (see also the pattern in the binding for
> any other options).
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1
> 

Will change to "uart_apb: clock-1000000"

>> +	pmu: pmu {

> Keep some sort of order. See DTS coding style.

I will follow: Documentation/devicetree/bindings/dts-coding-style.rst
to fix coding sytle issue at v2 patch set.

>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>> +		interrupt-parent = <&gic>;
>> +		status = "okay";

> Where did you disable it? Why only this has status=okay but other do not?

I will remove this one at v2 patch set.

-- 

Best regards,
Peter

