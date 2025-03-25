Return-Path: <linux-kernel+bounces-575761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB260A706D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA2C7A2DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9767825D1E6;
	Tue, 25 Mar 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bUGQY087";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ueHmTBft"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025625B690;
	Tue, 25 Mar 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920083; cv=fail; b=rd0Or/maWT87zvt+poRSwjCIIFBb3BMHRr7XHV6igH+Hv/y6O+w8FFsryn+HXUtdhn00vgeAmgVquzPugu6Az6vvMxw+YAFZuW7TqFL7iDboz7OgWOp3YXTz48A2UMb9F1gp1K0daR56MdM9IzXSQYhSuEafO5Nh+ZnL3HDsBxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920083; c=relaxed/simple;
	bh=JsNRVLvzQEhd/bGuIBNa5o0CRKbsSEuCvMljjuitAJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNCLMF8wkyMWNAoLplwQV944iSX2XV3OUuFbUAhFx3pdkdcb35OQO8r+Yx+0HwMpXXkYMj4dOuoAU/Lafrkm1LiPY/e8iMDbYTYAa/w7AfuS3852Q5cYqJ5leWzcxb3iutKFTR+93i+o7PVdRF3IdWgznCBDOj5NAbGB9OVcHEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bUGQY087; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ueHmTBft; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5qUN5002058;
	Tue, 25 Mar 2025 11:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=HMs0g3t2JDbJVgcBWe
	sNrTur5qopoP9cNd4NW85mtA4=; b=bUGQY087IC3JspGhz2X8zJEpfcEn1A0ool
	etUsePLN5quL/0QYYJhfK1FOFxF+Z0ngMeaMRuGRrodyI5bywMaMmEKv3H+jPF6e
	5oQRcvsRjiBGDbv8diqYpBAyWSt3xtsdyfXeYPkBTSXQMNX9kkuEdd6FGMtKO0bN
	YsHKcY67r2cdZWgA2AdhPbSN0mutebxRWY7hqf7s0SKDGcAwIQJEtLJdj5eXfLkn
	LAKLsPX8TlTYBD/M4O/uWlCDK9YMqhriuZJtbm4ODGdgAAGEGvY1wJbHy85yGkyX
	o8/XSSBxTxFaA1BtyEsEGPZxdrwU7MyRYsHO2QcA9DSLa69K+LVQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45kmrgs5y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 11:27:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsBExHbMUfbtWsKmmvmfuZdajX7XxxZzK4Bb6+Xqvjc+HEvdT7z5SpyZNQ9exdWb8EWNpC8GEhPLUelP7MVFs4WXH1qsiGRtJczE+0vkcjlG1eAQnzh2+zQcvVWOJKmzaYcWBy3v3SWSrUb8w+aHVBzK3FPvWPCD5847Pnh4N6JjqTmXtC0qcGT0q89+k1ceT/6yp/SDu3blR4XswA+fY+ySRfD4K/oSTicheaYkVnZQjQdWiSc3W23hTkIlghTqUJZHW7R4EzprXi5P78aOpterNJqeHfulvsFd8psk/Wa4ckGPj+51rrVVMTznP9tvbcNwN1jD4he1U17HlsiyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMs0g3t2JDbJVgcBWesNrTur5qopoP9cNd4NW85mtA4=;
 b=YY8SS9t2/+p5gcIPCzMIlQrzExWMIwhJCWgWXNZeJaW/wIfhUvox4AkpK+0XowIF37f8O98VlfwId4K6+FEIqlaX8oYC9DwvMKbYcsot50Q7fQXhcO6kc/d4tC3aBmdgJrrln3L8Cp6KQQMEUqc9FgzILvaGRccVJoL3t1TLreG278wzcb0npCZ6uQ8ReDppSMaIcbGeLK684fMW1mu7eS3eeAeU0NPN3KrHOGewUZ8ZKTD3fa/iSwW4HhfSnXvmkwXE4FQk0PrRFIH91XHti53EHHsnGk3DQ8ShpU0/ysZevJtaJlF8qiKkTOxIS3g4uEfB1UZJiu4OwDTdHftvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMs0g3t2JDbJVgcBWesNrTur5qopoP9cNd4NW85mtA4=;
 b=ueHmTBftMwjUmGf1dPWfMOjQGa1F4R4TcXGdfUd+09EUd80kpbNvJ/D1sCg/q8HNRIqwlGxYozRubOXre3XrVS5W1lke20Qcgm3p7Ie7qDG0bX51FCBKBBbrAYCCcn3CX6F51r16HG7f1sdeWKiCHKAZ5Ouo0IMoQ91ol3ZpPU0=
Received: from SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::12)
 by SA1PR19MB5054.namprd19.prod.outlook.com (2603:10b6:806:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 16:27:35 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::10) by SA1P222CA0063.outlook.office365.com
 (2603:10b6:806:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 16:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Tue, 25 Mar 2025 16:27:34 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 973CA406540;
	Tue, 25 Mar 2025 16:27:32 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 87E98820244;
	Tue, 25 Mar 2025 16:27:32 +0000 (UTC)
Date: Tue, 25 Mar 2025 16:27:31 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.dev,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/3] ASoC: SDCA: Create DAPM widgets and routes from DisCo
Message-ID: <Z+LZc4BS/Le/CKbH@opensource.cirrus.com>
References: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
 <20250321163928.793301-2-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321163928.793301-2-ckeepax@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA1PR19MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 08733ca8-5e4a-4c75-3455-08dd6bb9f2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FlkmkeDpVyelB0zU+VrG+9IUQ7womzHzKqa8jDpdka93YWCKaTmCDLZMy5P5?=
 =?us-ascii?Q?RIBSwh18ZJ/r9IKG6w9IXabMHcCugFLh06qEy3Mg9XKliLtlpA9s//0meWY/?=
 =?us-ascii?Q?9F5ni2xW6sm0tyggQrZrLYw9/WmFmrIa8DRykEANJB6aC4cmiMB+pU5LOBbf?=
 =?us-ascii?Q?ehUyAroWKpSrwRqCEhAzUG7TSFPT7+27V2NGufOupP7vrB735cJPXvFrOYVS?=
 =?us-ascii?Q?EJdPkXGVumxf4Olhh7y7euP+6gloqwJSXmwlwX7vzZZ5lajoEPpMQMztDKaX?=
 =?us-ascii?Q?sO+eTj5g+8fiLE0P+D8Hdf2S7zTPG5YJImqF2aG8j6N+yu018i4/7ayw2+Vr?=
 =?us-ascii?Q?lG88ZGM5lQ/4gWYGQpiEUqazTvKInFgmK3Vd8yROlDz6ReYYRVEPBnSHGTIS?=
 =?us-ascii?Q?kEkErqwvl2zKJAJ6EIDI7GHQ0EDWN7yq1j1LGzKRrhjhiW334WKWB+nT5aVm?=
 =?us-ascii?Q?ps0OzF2NIHnhw+JSaqyznCDVKv8VPOIDw/0inqB0rUpTMLbBKkTUSTHYw/hp?=
 =?us-ascii?Q?gzRSMkJTw/xUyaUwO0qWklYp7UcrLxn+7yBme47psb0RHBhd1uRWwVN4lPbs?=
 =?us-ascii?Q?G3wTg7lBn1EPOcsNoS5gkeS73Ye2jAYlLEre23pn3h1AHUxpNJZeLSWVtgqs?=
 =?us-ascii?Q?sZDVpGakOYC06T8UXReKwdvRgbcdZq5WtQ+SDJhM5OvCn6DjSPpqTXYMQN6T?=
 =?us-ascii?Q?C8EImt360n7nFxfYQHRS2BERC35uqZqGJHDkpWIjSl1nka5Y7YbTxXcwSxvc?=
 =?us-ascii?Q?anI8BhonEvVJJN410AfJyv+58OWS5Cnk3VaMJWkVIuXIV0CPN35gcKNXrdxl?=
 =?us-ascii?Q?+3OfR9v9tijzrXLqkG9FhxQaZF3U4kq5hG33PTX/8LxNXJ1uITAZvnt9vD7C?=
 =?us-ascii?Q?J18NBTDAGIGZ9WgrYQU4BD3JWW5HM/Sspn3xgFN4j5whvKnesD9hmswmjAFD?=
 =?us-ascii?Q?vPicDDybuyOX96N1XOuiFx0VtRQEvuP8lT65UlE151BbzhcpRT1E/usbgwcV?=
 =?us-ascii?Q?6vF87HlOtoXCOLZ69Wc2AnR666i1+PpNg0g+2XXm1pGO6BoAa8Iz04wGsDX3?=
 =?us-ascii?Q?l6S6QPR6g11cQk4M8qda/oSYqBfs3kxApj7JA7UNsZcc824ng+TCx3dHt14G?=
 =?us-ascii?Q?zJRfv9JwBd/tG+pHUsIzBtxITSuMJbgkEqPw6wwmvP6vEpuoEKXawNuLSM7N?=
 =?us-ascii?Q?223rLiOiBkdp5esbx5lAL5sj9kL0ZMOzA3AE3jBkDlZCQnOp8ZAX4BP2GxU/?=
 =?us-ascii?Q?kKU7/fnbrpOCdhxmJ10QDsc+mh8/XEgf0T+N5h8JwcI0A0DZolvhhhqFiu4s?=
 =?us-ascii?Q?Hv81XGIESRD4YHfLUSUmKwHB/Nz44SCUwV+tuxhi4dUFk52Xmhh4IwKtD2/w?=
 =?us-ascii?Q?gQNxCOe199hyzT7mbkTtRzD5aFI+3EsEQo5y/v5ZRmJfCHm2+g9UKZuljV4C?=
 =?us-ascii?Q?222JHDGKa8EVBK8hl5Rf+HnN6rkj+ks2AV/hNGb8zSJZzGcWf1lbahLls+eG?=
 =?us-ascii?Q?XSKjG9UVVsQYbdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 16:27:34.1264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08733ca8-5e4a-4c75-3455-08dd6bb9f2d9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5054
X-Authority-Analysis: v=2.4 cv=GrdC+l1C c=1 sm=1 tr=0 ts=67e2d979 cx=c_pps a=F7QtyTBSWJEVkVFduP+sHw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=5rOdpqCoejgofGPXKkEA:9 a=CjuIK1q_8ugA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: q2LiVkhZ4c1PgXVhDFBa9KL-azL9-LW1
X-Proofpoint-ORIG-GUID: q2LiVkhZ4c1PgXVhDFBa9KL-azL9-LW1
X-Proofpoint-Spam-Reason: safe

On Fri, Mar 21, 2025 at 04:39:26PM +0000, Charles Keepax wrote:
> +#define SDCA_TERM_TYPE_MIC_JACK_NAME			"Microphone "

Whoops extra space in the string here, will fix in v2, when I
update the commit message for Pierre's comments anyway.

Thanks,
Charles

