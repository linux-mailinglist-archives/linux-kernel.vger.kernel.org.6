Return-Path: <linux-kernel+bounces-576795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32287A7148D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C2171119
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2781B9831;
	Wed, 26 Mar 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="njBJLP8b";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="UUHnv3sX"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB701A5B9C;
	Wed, 26 Mar 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984115; cv=fail; b=AwxH5kw4NInJMF0aRylCH++Xncg94rLyI9EULkuJ2YKxsJmShVJ7cn7zQ49GeXTt5s2uP+HoyPfwD05PRgLARfpikVJUR5K9ZRUrlK/4BVuOb/34IHgmTUAX5LNqYQUYBKQ8TO4JecDM+Q1pymExCYM868U71wACwOFBdJUxN7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984115; c=relaxed/simple;
	bh=d+vPmXGwUBGs4T1cKvC94aN/XDa5D0IFLy0E+FpzKVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHoQKEweHUVcTDRJpGcsstZOZ2cJgnTul4cnifywkwKuS2O07YSOBqusfSCG9QEf7SuyOGZzyGJeVF3owZ6DHpl1Tyy6sKebrGNFmRp7Jfx+FzPfmM9u3dk/2jRRbac0UEqwMMOxDvviNSB4K78nYv00THao3sjfIXlcNOrYCNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=njBJLP8b; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=UUHnv3sX; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q8goOo029427;
	Wed, 26 Mar 2025 05:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=heZhTZnUHqqMVfhi1Q
	ShpP9qxczksckzkDxd69d8a14=; b=njBJLP8bimKQWo697Mp5ncbCqz1X0FSAPn
	jIhLTU4BFmzbWZTWGKwggY+Df0zWx2YVYiosplj4/ENwTNPVJSra3HOvPa6h5dqn
	0uU4V6nqOjdUqxUzml04VI5H2BbxU+RxOT/31qXi0uMzDz1ZoSmFu9JIr2HfdaIv
	XSM0hzge2cURYK3NveuuxaNxFcqFuMt3EuGd9I5PVwpeI7jY/7IWX/N74SwUEN0W
	gvrjNJtR2Y3Lp2NOGRwM3kEXX6b+BCacbmCz51J2PDZxlCNIxJyXL2A1wXXPfXC0
	y0+5i9Z6MEn3jxIV9RGFCPWd3BRJFn98WYRRArBHpZUifKmFr75Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45kmrgtj67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 05:14:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1HsRgt5Cs/Vsa5oq2IGCboe4wou0W24ItvUqYSp7XgthdvM+I4XiuSdRVotsYP8iksNfYPJxNpizpq9IdUl1HL7OrjuurMoGuT4/ji4yyiEtxwRdEXwC96+U01bh7LN8T6UmrzXsKKPRezWy0ruOGkutuidmYiHW5wjIod1Qg5JXSCxWihIVoIk1UHXMB+gjxCGgtjn0WVA87uFh/ChgXzWUmSGkUZWX8rF93n6dle5EQDOH97LvH+6p/UaE36uGTfJDy0dVzaYGkvRUQMe6SuYhF8qHvNjyglv01RlVikPy/8hywQmLmvKZ7y+Y9AFTdsz+ogHCEbrrRWUuCoVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heZhTZnUHqqMVfhi1QShpP9qxczksckzkDxd69d8a14=;
 b=t26ZKXtD2kCSeKKhVeIMxJqkmGTVpaepK6rRko7iJ6zDk2kVtKCfKiFeNsHSQPYvzckYO6TNWfwySr1fyGLQvUo7QqePA0KCMHNrxDQJGFOF3uK2Fga/vXIVzYq7DfZuGUZrH7+xbGAG/T9QSyU+UuBQ+8K28VL70gCA06n5ee5LNh3dLviD4Fj+9pyy4Lb2w0RFU1YOXRj0NRE2FL0lPMyOEfEVgfSpUvvcYoOupU8hQnecAGBs7gz38BQvr8LBkvt7fGbu6AzOqmSkmjMXsnl9ih5Cv0NiGbY1nYDe7xUTeOXUAoKXgu385yxbiZZkvaln03HCTDi6AS+YzVy+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heZhTZnUHqqMVfhi1QShpP9qxczksckzkDxd69d8a14=;
 b=UUHnv3sXZs/JvmCwY436lqKOi5ZieJ+sZbz6/ATkFDpX0WrpsOCxOBZ6CYDMUNba+dVJ44Ew77XtxjS7//cgVkEbJ8EKbt9pi+16mGT3JGPv6E/ADxL6PmaJh7xIgXIgpN9QlZzNWN/MnthUxqygtXZZJQe887uW/62hU2oUbnQ=
Received: from MW4PR04CA0195.namprd04.prod.outlook.com (2603:10b6:303:86::20)
 by MN0PR19MB6287.namprd19.prod.outlook.com (2603:10b6:208:3c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 10:14:51 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::e7) by MW4PR04CA0195.outlook.office365.com
 (2603:10b6:303:86::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 10:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Wed, 26 Mar 2025 10:14:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 17F90406540;
	Wed, 26 Mar 2025 10:14:49 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id DAA85820248;
	Wed, 26 Mar 2025 10:14:48 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:14:47 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: broonie@kernel.org, lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        peter.ujfalusi@linux.intel.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/3] ASoC: SDCA: Create DAPM widgets and routes from DisCo
Message-ID: <Z+PTl4fg5tRoXmEE@opensource.cirrus.com>
References: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
 <20250321163928.793301-2-ckeepax@opensource.cirrus.com>
 <2b899796-b9fc-49ef-a4a7-858baa90a36b@linux.dev>
 <Z+KROae2x3nB6Ov8@opensource.cirrus.com>
 <a5aa25de-919f-462c-8aab-996fbc381de9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5aa25de-919f-462c-8aab-996fbc381de9@linux.dev>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|MN0PR19MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: db00dda0-1998-4153-e329-08dd6c4f0baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a01uxkcOv3qAvM1pV9hzq0tUyrLGelbkSevWg96WEJPl+iuevMtQkxukI+oL?=
 =?us-ascii?Q?a/26D/EcyZvhnJ4d1Ljg/pbNRDTKuZCXVo8+MBrIbA1YWWSxa7Pm31eJGcaF?=
 =?us-ascii?Q?gbYKd41ybkXh2r+nS9pDMbfgHlHMKz3ZfFxyGyAJWNXRKKpE2j6h46W6QzXs?=
 =?us-ascii?Q?UuGei8FyFFctBLvrC0Bt2vDtB/W0oLI6wMTAbaInjy7zm5WRI42vgF0XEvah?=
 =?us-ascii?Q?uCoeXUP+yk1PEHS+fMAoaOGht+yE/m8GEaZQ8zf0GytrqDnMS6grLm6s0R+g?=
 =?us-ascii?Q?Yf5Nj8GRgp7LVX1xT9uI/d6T+Jr6PL1iXRsxwjCY2I5UuJk7zb++U3gLEtIQ?=
 =?us-ascii?Q?S0M/lRG60O+M4sCrNCsFD4kCdmsmrTJjSyGgQu+aH+cQ7jTDE4AjXf24HK35?=
 =?us-ascii?Q?h9gry3K/PJSdgcRmW07sUX8eQxQaS/IKkVfxd8mN/CCORkW8Ua5CgPZ69WG7?=
 =?us-ascii?Q?CLi4hbysmrcxHUY++y59b9E7HNgamOP3R7vZS07YvdcQbHespOSYUQpdHKBk?=
 =?us-ascii?Q?ekSksrs4YL84zifMmt+lUZXQ9/K75YBwNbDeFbwu8ri6lB+Tyyp5tlle9ZJe?=
 =?us-ascii?Q?xlVybMUegzhJEkZu3OA5gzA51S8eER/oKmSBOPGPk7YJG7MUSTQ8O731pL90?=
 =?us-ascii?Q?YoIGzK8VYCVMx66EWfJQUtLVXN8mETOzsuPaEW1xFSKyvmLWmJm0l8PLKgMC?=
 =?us-ascii?Q?d/X6hwdAdbEjL+v7ekxzLrC/uov+idf0RFHXrl0Lvp93YPsFydCAh7b1EPCh?=
 =?us-ascii?Q?6tn/SiGHjf42vg0rbMem6S53/yeyD9Tn7KGY2xJNDcsGp0AwSTGzpBQpWKcc?=
 =?us-ascii?Q?NE2XODuT8j7LLNyMqgW9yX74xbHPtrwVOM7Hc8L/mdmm4sZlVVuGkX27Ddpu?=
 =?us-ascii?Q?HT/QGAtDH2a2eu1fPvscluoep2lpotQAVnZBBc2wR7PevEGiOtoSvqF3jyNn?=
 =?us-ascii?Q?4GaJxQyoGAC2ibLP3cW4JCuoAEpbEVObuYXw4wYEscuJC4CPchqbUJ/7iH1S?=
 =?us-ascii?Q?stZMDGPjkuZgUfz4kUlkqNdBEJ5H/5KCaiDYN/WQZozjKjtIhHuL0EAp4SwV?=
 =?us-ascii?Q?IAM8UxD9VP4lKp2OqSfiZ09Es3hmqV2/VpZe3DG1YzTfJr08qQk0AkIgijjT?=
 =?us-ascii?Q?FszL4OxJgvsdTt5R8RWbvbNqo7Tnp1hddL+mgLcWY0IailPyoaSlaK2tEuX2?=
 =?us-ascii?Q?Hko2JV0NLSCGKyNcINO1+4ctSy9iT3zlw5fDA/D6N8/pz7IpPd2+tnBfUu4L?=
 =?us-ascii?Q?s5VbcOHjZzN441UMIS3HrY2G/3Eq4D82+JvdG/I7Juv39Gi0CE0E1Ein39jZ?=
 =?us-ascii?Q?r54JbYXdZ/eC8lY09DTe+QgBrCP9djCMnMQXlLw+XCsqZK9s8uPN+eyIpj93?=
 =?us-ascii?Q?NHpwGv4ZfWodBwdLFI98Lcu97UUoWayt66DI5xW7qizuOCfI6aVI3Jx6/39v?=
 =?us-ascii?Q?Nh9tGOMgpWo7j+svhHFOKs88ezEKf33a5gWeI7qGwoZW88MPPV0VsjotjfGj?=
 =?us-ascii?Q?h+VAP/hAsKdHIko=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 10:14:50.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db00dda0-1998-4153-e329-08dd6c4f0baa
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6287
X-Authority-Analysis: v=2.4 cv=GrdC+l1C c=1 sm=1 tr=0 ts=67e3d3a0 cx=c_pps a=YkRwJB1Lcas13D3J5+BQ6w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10
 a=RWc_ulEos4gA:10 a=KZXpsyWr3WEUDrRS1P4A:9 a=CjuIK1q_8ugA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: sKL6lk32cN-DsD97Vrm2tio2CKAqMvUn
X-Proofpoint-ORIG-GUID: sKL6lk32cN-DsD97Vrm2tio2CKAqMvUn
X-Proofpoint-Spam-Reason: safe

On Tue, Mar 25, 2025 at 04:10:21PM -0500, Pierre-Louis Bossart wrote:
> On 3/25/25 06:19, Charles Keepax wrote:
> > On Mon, Mar 24, 2025 at 04:15:24PM -0500, Pierre-Louis Bossart wrote:
> In most cases the purpose of a GE is to control multiple SU
> states. However the SDCA spec took liberties with this concept and
> added new properties for the NDAI topologies, where a GE is present
> even if there is a single endpoint. It'd be worth double-checking
> that the way the GE is exposed in this patchset is forward-compatible
> with the 1.1 topologies.

I will go and double check but I can't see any reason why a GE
controlling only a single entity would be a problem here.

> How would the state of those DAPM SU widgets be updated
> though? I think we need to 'translate' the GE settings to tell
> DAPM which paths can become active, but the SUs state is set
> by hardware so I could see a possible racy disconnect if we
> make a path activable but hardware hasn't done so yet.

All the SU DAPM widgets are linked to the single GE control,
the same ALSA control is shared across all the widgets. So
all the paths are updated in a single DAPM sync, and on the
hardware side with a single write to the GE control.

> >>> SDCA also has a slight habit of having fully connected paths, relying
> >>> more on activating the PDEs to enable functionality. This doesn't map
> >>> quite so perfectly to DAPM which considers the path a reason to power
> >>> the PDE. Whilst in the current specification Mixer Units are defined as
> >>> fixed-function, in DAPM we create a virtual control for each input. This
> >>> allows paths to be connected/disconnected, providing a more ASoC style
> >>> approach to managing the power.
> >>
> >> Humm, maybe my analysis was too naive but the SDCA PDE seemed
> >> like a DAPM power supply to me. When a path becomes active,
> >> DAPM turns on the power for you, and power is turned off some time
> >> after the path becomes inactive.
> > 
> > Correct, the PDEs are modeled as supply widgets and those are
> > powered up when the path is active as normal. The problem
> > alluded to in this paragraph is there a couple times where
> > SDCA topologies just have a permanently connected path so
> > things would always power up.
> 
> Ah yes those loops would indeed be problematic, but no more
> than in existing non-SDCA topologies where we used pin switches
> to disable such loops. All existing TDM-based solutions used
> pin switches, I was assuming we'd use them as well for SDCA.

I wanted to do a little more thinking on it. The general
concern I have is that typically the pin switches are added
along with the "fabric" widgets in the machine driver. As this
code here is effectively creating a single codec (function in
SDCA land), it feels like it is probably inappropriate to hook
up pin switchs at this level.

To put that as a more concrete example this code will create
input widgets for IT 31, 32, 33 (the UAJ mics), however it
would be unusual to hook a pin switch to those. Something
should be creating an actual microphone widget, attaching
that to the input widgets and attaching a pin switch to that.
Typically those actions are handled in the machine driver,
there is possibly an argument for handling them in the codec
driver for SDCA but I felt it would make more sense to progress
things a little further until resolving that one.

> > My opinion is that even if we end up adding the pin switches as
> > well it still makes sense to allow connecting and disconnecting
> > the inputs of a Mixer Unit.  These are typically where two
> > audio streams come together and having the ability from the
> > host side to say if you want that connection or not seems very
> > valuable to me. As in SDCA land you basically make that choice by
> > directly flipping the PDE.
> 
> I have no objection if there are both pin switches and MU switches.
> 
> I view pin switches as a more generic mechanism that userpace
> has to set to use a specific endpoint.
> 
> The MU switches seem like debug capabilities to isolate which
> path has a problem. My experience fixing Baytrail issues is
> that you want a default mixer switch to be on, otherwise you'll
> get warnings on unconnected items or 'there is no sound' bug
> reports. In other words, the MU switches are a nice-to-have
> mechanism to disable default paths, so even if userspace
> doesn't touch those controls sound can be heard on endpoints.

The mixer switches do default to connected.

What I like about having mixer switches is it allows a
clearer specification of intent. For example one can power
the capture path and one can power the playback path, but the
mixer switch makes it clear user-space has an intention to
use the sidetone rather than just those two paths being
powered coincidentally.

I could drop them for now and just have the mixers permanently
connected, until we deal with pin switching, but I am inclined
to leave it as is and we can revisit later if necessary.

Thanks,
Charles

