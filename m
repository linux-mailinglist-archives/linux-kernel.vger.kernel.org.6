Return-Path: <linux-kernel+bounces-575195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F83A6F1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692D7188ADF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB41F7586;
	Tue, 25 Mar 2025 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Y+QdaCrY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="vcBc5nFp"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22A2E337C;
	Tue, 25 Mar 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901600; cv=fail; b=Fu3p16etst6xBIo/hJweefRDC/Nf5X/cGC2Kvl/eQ61Nhw9OWEhoRyJGvn6JeGzFaLO5uAFclTw7XMmFjPtvw1lNL/v3bVSIEq4fVbsy4pPhKJwS35Zi6Cl6kDldMtC3OYx6cmL1FGCQ/Uq4pjhrh2RPBGnyfwNmzSQh75KiNAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901600; c=relaxed/simple;
	bh=9XdAZF2Yg7Z6M5QZwjTdPS0WIyML6KqAh4AsaAZ5kuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/obNBGlDOOG8goQ2kwb5xcmfk0cTz2nJW/17iCSg9aitQ/Z+qdE1M1GfRMp29HJZLKt1ILmtnKai0LoZV2obJylbBDvv68RGzJqbD+IPKTKUMPaPK86dz5600Pu6Z7kFAzm7r4kumgO/tS2eWg4Od8anlwU2aevRWVdi9aqTDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Y+QdaCrY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=vcBc5nFp; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P6Pb4u031536;
	Tue, 25 Mar 2025 06:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=IKo5Rjkk1drvPjdkRX
	Qp2GdXI1KS6eEZjClSn3L8f3M=; b=Y+QdaCrY5pTmzzyxlxPYIxy83cHdGDof9e
	DwVLDvsw2Pu3QGU1P/lRxS0xL/0Z0NbRfhTXcSvcEsBwzfnenXccko0DLzo72TN4
	zVGZv8LgD3lU9KjLOvAC/PKGY2wB7ISEigHSfaLPbNW/GAv1InCrZZt+NKxW8oYr
	5SCD/c5H8am9qFc/QFbTDepkLNrk7nqHGAYnM1j1Nx0sECHYSgj5ja9mmXw2pE0c
	pTFsX+qOfj4iBf23ChKTRxA/6+9NWhsB2cZJj/hkNA99dEUOudkt0cLHK7XPf/gG
	+xs7hrtE/tf2hVgiNBjByjgYA4eAQTLNMe6HI5cmP3/NKIIKjEWQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45jntbub81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 06:19:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKty74byWOmVZ6a+Aq4E57FYrWnSYfPDx7jqz7CM+90k2MzvDm7qpPGfeHJpP5EKYhZDfQFgzYDuimeGBM0dDKmIw2Xzvy2Wc9xBjbRr9QjPjexEa2wYKTQ7370D9Hc7KfqL09Dc7PrTvsC8vq2c8DO/Aq9OncWPDOvR/qP6438A78s/WBQ+8ptLEHU5QXr68+eubETznIOedLagK9faxMLPnAnJPnuQdxh1wQn2IA8DVSBY5ukUnY5CSYFIlweuDcNiBm4026SMKa+bBFaoKn9fVaBgeOJdjv1yUS1bQJvIQEWAyEZ4lINPoowZpx/05VeXKm86WNH+sOeOi55I8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKo5Rjkk1drvPjdkRXQp2GdXI1KS6eEZjClSn3L8f3M=;
 b=kfujfIBDfmtn/zJfS7hebs3EptJOEt7DJ1SbIDrZD4yzzkkoHbRmb5B22AfDfIK8JoQRbVTfCF8OCN3ERIjuS4DyFabcD+G9gtNGthNs1cQ1sBv5ii7z1phWE1/zA1AoGP7mplJEbrg/H0lYk2HHxYXPVkCvwUz9FPX97G9qiGkaXluL5OltjuWplDX5F08VIVA5qNMrG8ojJMZaVerax/HSmiS4BYULE6lkM7YQVvoem/0GLVZ2RkRXGUHBJzPfadpYniHChDCEKi4XAfmRZ0j2aYTJ/QOM2v0d5+wZw292RYLy9I7buMnLqqyOLRb7eS8gMAQjAphjsyc34MABMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKo5Rjkk1drvPjdkRXQp2GdXI1KS6eEZjClSn3L8f3M=;
 b=vcBc5nFpL1uRL4C7P+csMm+fwA+VqWoeqNBjxEBQHWvUk7qZYI9hHNwHfHonnSGzivIDgh9LJZgh+oEcyWx0GDOoT7NmM0i173/I/Qcvc4OOu16Tkhz0sKCzW2X7JCENgXCfMB8pxQij830BiRoWfcqS6KuXdbtYgA2neqIRqaw=
Received: from SN6PR01CA0010.prod.exchangelabs.com (2603:10b6:805:b6::23) by
 IA3PR19MB8739.namprd19.prod.outlook.com (2603:10b6:208:50a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 11:19:24 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::9d) by SN6PR01CA0010.outlook.office365.com
 (2603:10b6:805:b6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 11:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Tue, 25 Mar 2025 11:19:23 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8C8FA406540;
	Tue, 25 Mar 2025 11:19:22 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 5F44F820248;
	Tue, 25 Mar 2025 11:19:22 +0000 (UTC)
Date: Tue, 25 Mar 2025 11:19:21 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: broonie@kernel.org, lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        peter.ujfalusi@linux.intel.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/3] ASoC: SDCA: Create DAPM widgets and routes from DisCo
Message-ID: <Z+KROae2x3nB6Ov8@opensource.cirrus.com>
References: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
 <20250321163928.793301-2-ckeepax@opensource.cirrus.com>
 <2b899796-b9fc-49ef-a4a7-858baa90a36b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b899796-b9fc-49ef-a4a7-858baa90a36b@linux.dev>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA3PR19MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a075d1-edbe-4d69-b3fd-08dd6b8ee5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A2l4Q2SCVXoiibNcj7iiFPxEL7bLDaKreM8n+UhJ2Zmdq+QNeBOTtakCa7+a?=
 =?us-ascii?Q?t/961dOwgv54uL37Hf0LyNJvjbw+yZvkBr5g52xZYatTRJyzg5wYGQBwqUeS?=
 =?us-ascii?Q?XIXJR1y+S0+OR9bAuIwn06sVQ8K5l0bPuUrQ4ipsZbIpCkeLWPuUdUYKEhKw?=
 =?us-ascii?Q?eienXZP7Y158O3T50+V22ekTQd7qx1oQiABCU27MNhPSF4zjXov9gN9qQKtH?=
 =?us-ascii?Q?tt+Lut/pSHzDY1B9Y8bw+dwmaaRaB8unEC0EOT8BZeWt0lKU0xz+rwdCPKud?=
 =?us-ascii?Q?Yq1VlRZpkYOzO79pGj9+G9QnvO2y39KUQ/wU/kLS8QTzbJq05v9rGvTPo8fi?=
 =?us-ascii?Q?JjUgNLML2rdKWRpO8z07pId0uxWeY51YhSsfXu9GW9ySFxWJyPfDNimhaRgX?=
 =?us-ascii?Q?lxPDApEjdnYr8yw/g2Bl5Ke+VE/PdpDE3pzrYime2sWVI+5H3fLaW2d4Q+x0?=
 =?us-ascii?Q?N1ftnUkgwobdv1DmZAWew3lqEudVVdxqks/OvoRAyBHMGoHH030xLXiyiLSd?=
 =?us-ascii?Q?FYaIFsZheYwLaKuHrGkZrWvm/a1Io8uTvllktaqq6hp4dheC50sZP/7WHYwA?=
 =?us-ascii?Q?9wAbVjglyFKa972BC+pinc0UOYQtO25x1n9vm2Rdu887cWMxGLl1g8g2QuZE?=
 =?us-ascii?Q?FDTaBUls9Ss29GcwIFx+jJvGdP1Fvk/dTtRNNC0GlZ9E3Pc78u6TPCZvSgie?=
 =?us-ascii?Q?AR1TWANL/bzPp3SU2BuOPnaY2OBnYMWVxWROI81+s00E/+Tv9AvbnWsp/Hdr?=
 =?us-ascii?Q?5S2QEeF7QK1pfQ4tmi0wip4Xlfqz1FiFENM2KMabECe0b2gIJpVsPJhLPOeM?=
 =?us-ascii?Q?iME9HP8ye1W/w+V/wJVOooTrHjWzmE66eMQim6/0+GPLC2/F8XPls2o9YGFP?=
 =?us-ascii?Q?vfNU3giZIq8Lj2k2OzVmbq4dHo2rD7ELnH+L7T40d6pHJQd++EhZVqnmozMr?=
 =?us-ascii?Q?SSjUkSiHCXbr9LUVzQjqkmL0L+L7mV/3yZxu3cXAPvtHNe3h0aOXcYgQJ+0w?=
 =?us-ascii?Q?CuZvT6TVwR08PqeYmHyCv8yu07mvhQbz0XGk2G2rBShF7Q45EyhsLBXJafmY?=
 =?us-ascii?Q?FPAS+pVXJJ7tejSDi0IguwV4IvN+g757020OKxfrP9EWOxYEc+qfmTLBIvAG?=
 =?us-ascii?Q?A6I/AyZrfDe/SmnIndXFF/BAcnBR58vFEfIMM8ZpVrGPQnE6ihvH43VrfJlq?=
 =?us-ascii?Q?GTDToS+B0kjk5dLZx6OdsndTLnvcKTReLDYh42bi5KwRG2VC/3iuk3GHG7Lh?=
 =?us-ascii?Q?qAgnP5+Ssu+u6eK/zqIz/LhZbEuGPbCt2XGjYgZ+kWp8SwrcGUh36cJV789g?=
 =?us-ascii?Q?gV0UvoICb/J32vR853iT87sZWqDVu9d+kUA8KAkbsq7Hu278HhpGON5tIYrr?=
 =?us-ascii?Q?XTzXjHAnNnw4HeGjnCwAaLwqeVjIJjOVOKhewwEFQrHEcuo/f9kSitLLrTm2?=
 =?us-ascii?Q?lFMdJuz5W0WT0eR4LejNqnE2H2rQu/xS9Jv4XIaQHFZy+Rwk0AGcaMa0HzEd?=
 =?us-ascii?Q?pFKElKy7sJwaKCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(61400799027)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 11:19:23.8748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a075d1-edbe-4d69-b3fd-08dd6b8ee5cc
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8739
X-Authority-Analysis: v=2.4 cv=JJM7s9Kb c=1 sm=1 tr=0 ts=67e29144 cx=c_pps a=kqCqMoaEgQjRYYKBKtAp1Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=J3hq4zHnGsKQgpLjqwIA:9 a=CjuIK1q_8ugA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: Ivepl0aO0T7B0BEFNu9BTrhZHclBZIUd
X-Proofpoint-GUID: Ivepl0aO0T7B0BEFNu9BTrhZHclBZIUd
X-Proofpoint-Spam-Reason: safe

On Mon, Mar 24, 2025 at 04:15:24PM -0500, Pierre-Louis Bossart wrote:
> > The primary point of interest is the SDCA Power Domain Entities
> > (PDEs), which actually control the power status of the device. Whilst
> > these PDEs are the primary widgets the other parts of the SDCA graph
> > are added to maintain a consistency with the hardware abstract, and
> > allow routing to take effect.
> > 
> > Other minor points of slightly complexity include, the Group Entities
> > (GEs) these set the value of several other controls, typically
> > Selector Units (SUs) for enabling a cetain jack configuration. These
> > are easily modelled creating a single control and sharing it among
> > the controlled muxes.
> 
> It wasn't able to follow the last sentence, what are 'these'?

I will attempt to rephrase this paragraph a little, but 'these'
are situations where you have a bunch of SUs controlled by a GE.

> I am not sure we can expose and control any SUs since their
> configuration is set in hardware depending on the GE settings. IIRC
> the SU values should be considered as read-only.

The SUs are modelled as DAPM widgets but the control linked
to all of the SUs is the GE control. So yes the SU registers
are never accessed only the GE register.

> > SDCA also has a slight habit of having fully connected paths, relying
> > more on activating the PDEs to enable functionality. This doesn't map
> > quite so perfectly to DAPM which considers the path a reason to power
> > the PDE. Whilst in the current specification Mixer Units are defined as
> > fixed-function, in DAPM we create a virtual control for each input. This
> > allows paths to be connected/disconnected, providing a more ASoC style
> > approach to managing the power.
> 
> Humm, maybe my analysis was too naive but the SDCA PDE seemed
> like a DAPM power supply to me. When a path becomes active,
> DAPM turns on the power for you, and power is turned off some time
> after the path becomes inactive.

Correct, the PDEs are modeled as supply widgets and those are
powered up when the path is active as normal. The problem
alluded to in this paragraph is there a couple times where
SDCA topologies just have a permanently connected path so
things would always power up.

> Why would we need to have a control to force the power to be turned on?

We are not having a control to force the power on, that is me
describing the SDCA view of the world, not the Linux ASoC view
of the world.

> And there are quite a few topologies without any Mixer Units so can
> we depend on a solution that's not applicable across all topologies?

Most of the time things are fine because most topologies
generally go between a dataport terminal and a physical
terminal, so the dataport can trigger power up. There are
only two cases I am currently aware of where this happens
at the moment, one is the side-tone path in the UAJ topology,
which is primarily the one I was concerned about for now. The
other is the sense path in the SmartAmp topology, which I am
slightly less concerned about for now.

The sense path case can't be solved with the mixer switches.
So eventually I think we will also need to add pin switches
on the non-dataport terminals as well, but this is thinking I
was hoping to delay for later.

However, we should really consider the wider mechanisms defined
by the specification rather than just the given topologies.
User-defined topologies are allowed and people will likely make
small uncompliant diversions from the standard topologies as well.

My opinion is that even if we end up adding the pin switches as
well it still makes sense to allow connecting and disconnecting
the inputs of a Mixer Unit.  These are typically where two
audio streams come together and having the ability from the
host side to say if you want that connection or not seems very
valuable to me. As in SDCA land you basically make that choice by
directly flipping the PDE.

> And last PDEs are typically related to terminals, while Mixer
> Units are usually for host-generated streams.

From the view of DAPM I don't think we need to be too careful
about that distinction. Its all just connections between widgets.

> It would also help to define which power levels you wanted to
> control for PDEs. For me, only PS0 and PS3 can currently be modeled,
> I have no idea how PS1 with its degraded quality would be used,
> and PS2 depends on firmware.

Indeed, currently the code only deals with PS0 and PS3. I will
update the commit message to call that out as well.

Thanks,
Charles

