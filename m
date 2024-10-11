Return-Path: <linux-kernel+bounces-361044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDB699A2BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FC61F23A41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883821645A;
	Fri, 11 Oct 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hk0/1Jms"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C220FA9A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646379; cv=fail; b=CCdimooH8Mn9kigGhWbanWUzCL4O8A9dL8c5izjt9eaLXmEXxHr/vpiqQI+MUQo/ujr+ghPDhryikbpoaToIYLT/LybVs7auic2kFA3WKlpZsT8LyZUpTYhUMiy6w6rPYqmgFWY0O0Lya7zsGWW6/XHTIqUPxd1449IioXlxiaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646379; c=relaxed/simple;
	bh=D7uFhRAoWccYNy0yL8+xiODHI6QvmAnfkZtruB8JuM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sSgwfF9XoOfszXgt6Dw22W8lKsaVXZ63wxKGa38qxY2J9bC36CjH9tt4ZI3XqiCUf0lQsse7xSW39OSlHHXG0vdrJLqeXio1+UA7ASl9vKm6tSaAhW5zMpOQoLbKrKUpO4O3fC9VK2sbQVvgtSTPJB9IGAK54cjGUMOwfbO/fF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hk0/1Jms; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enKUZJIN83S5+i9EC08j6yau4RwkEL6C2Kxj5RmR0Qtj1wN0Te7k/CjhL0IryBgDCiiiVT/3oIsd0WTZjDCpspEtGkOfZ56bv9/LZG47zkdOid2MlPTtCmJtcWxmbewT6Prr7zsovksaXciA2Rg6bsytE/LnDFa5TrzLZF7rmZDAIunUmhHn1YeZMHLwHlNWkIB4FRg00PxfazrqSNaijIDmt6+Ddm44zTI0p8x39gfehejSr6A9MQ5Omzj4ArKfhwckrHqKRCwsanvfB8UN/Npm8a5tEQpQVlTjTuCjjM21NCNivzmKz5xa8qwbklqvQhcMaacgf4DYZnW4t9QQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkdtNaaRYF4FxUfKZPS9rineA5Kuy0hc3LHOhDHDArc=;
 b=pQts2kMjUOdD8+ZdyeOHK8AudQhNYhL7fVw4iRt1iL0KCVLJSRJHl3kQZDZBN93QJnBa2nsBsesMdOn8tfRSlJv1H0FNsltxjnvZ3pmd9GI4ERN4w+75W7aQDOj32cWSuelhTQMcSqJnpXm5FOGx8LBvRyz3M1G2RsumPJR3IuQAjBfO12/tC+O3efcbSPac2EBcJXbhq7JWxWuWVScTMNMNsxsfL+dbH3MWJA5RTUMvp8vwhkKjN+/L3rb1+6/cGVGVIT8LRIb7I1b46G58r7CBcgpknP470N3CD1whOe+xcIQEsEaqZnLmkXxEwqK5i3foHLKwH6cTpo3YPjifQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkdtNaaRYF4FxUfKZPS9rineA5Kuy0hc3LHOhDHDArc=;
 b=Hk0/1JmsssoarFl1KYMdtkZtjWl+mkJ+/XCSgL2DACdKwbODzsIGhoJdtLiYudjpsDTMwyoRq81SeV95GUm7NbBlZvavWIOvAC+A0NUz0aYv8ffDVI2q7NvfEEZTByQOy9scbbnY4szcDc950G8Blipc4q9kezUokGWzMW9KbZ9WzfqEsNVV1pUqAURUEuiqnPLbBJPhoZBPFMFaHJmqWfeTXgVrvLX7NsBe1FQryhH6VRCgh0M69icEEiFjqCn9aQYFnuhe8APtflelErkFPjixL2A12WMj2eiIaoDVqEuWUlCOaek6KinSs6jwXQ0KZ7K13t+TfegFfLglncCGDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 11:32:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 11:32:27 +0000
Date: Fri, 11 Oct 2024 08:32:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu/vt-d: Refine intel_iommu_domain_alloc_user()
Message-ID: <20241011113226.GE3394334@nvidia.com>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f5efb7-63c1-4f88-8802-08dce9e8629a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c0ywXaKKQxMkhapz6Iq7OwQowOr2WEJpY008guOwSz1QiCoKQ2HljFjzpYj5?=
 =?us-ascii?Q?O3x4BKa5w4NlsOaa01WSAEZd9ItTl2VnpBiTtGOGzwJVxlQAUqst+BG+hPZ+?=
 =?us-ascii?Q?LnDFm/F9e/Yz2HyzqgxaGqSSjegPbceI5Jf7y9jX4oq35q6Ud7Q7j7LYLbLV?=
 =?us-ascii?Q?E28gD1WXcqHsw0uCYEJZZzyAV0TiSlBYKEhS/K/mGlMp+z5GDTaMsyrHpORn?=
 =?us-ascii?Q?SXEOznBOgYw1cX6IyM4fXTtDH0EMUgq8V390h4TgmUxoCXDnan8+k0dOnkpP?=
 =?us-ascii?Q?JNGhn8r2GJ1EiTjlb7Z4COXOJGbHPJmDs/Xd/XzA79DORJArs5Tf6rnpLBdq?=
 =?us-ascii?Q?VHFXbtcBsb4PXzSPDZb2bT3/eXbtJuD6XqsJjmSFg4gRglWqZ18xDSgZcAfK?=
 =?us-ascii?Q?2qOs+q2nk03pxflJsCtAGdvDRwxwpxUgBF4szLSTwuKewv46c8/IV0p1jXhf?=
 =?us-ascii?Q?wTJiuseCAYaShhOa46PmAnCixq5i2eK6ekU0Lm0sJHrnKu2Vas4F58mEys/0?=
 =?us-ascii?Q?nT5G82yrFrzqcdRjZUYT4Uy2+bMxfg8VACYkN/Hc+OLZarxsXqYe+tbsUeBe?=
 =?us-ascii?Q?kcQvGrypyWnGNNxkd932266LgDWg7IzwFDUvTwhUVZFN5OH7ViXTIm0JBk3X?=
 =?us-ascii?Q?9RBncpaKkNvIvlWAVPFitWx8XEKFT0BLOH7emBAmZWXMXCL6jHu3ex+7GMCT?=
 =?us-ascii?Q?BnO+tiCucqhszdrrtcoL2uba6M8xH+oVpTXtYEfzQbkUxjYcJLtNarYrZwvi?=
 =?us-ascii?Q?XN1e2tJDcMnS40+83H/+aKTI+fh7mP6Fl4dpf8sYJs4FCXvHv7P+MH3WZk6D?=
 =?us-ascii?Q?tvptmhB0saElCgKZvqUz+o98hNxRDu05i5If8slW67S0twKg6XN42IIa9NOf?=
 =?us-ascii?Q?pOzM3Y5tFS4uXIPhqaMpVZqlpSkwp0AuIxOhzV9EypdgTjuJfIz1vmS/QiDF?=
 =?us-ascii?Q?VYrQ0zy71IYRlJjstAXyIAU6kOTDQkvcN4M1ZFob1/Jbo0ZirwGCthyq4d3N?=
 =?us-ascii?Q?OhsUnyq4vGtJC3LQ+ej0s+IuFc1JIPm5eKostzTx9p5wDLOqyhui6UkLUqb8?=
 =?us-ascii?Q?I4xoR5YGt0dAlbJYkXSk8NXPLPWga1cwuf65+tzsVTA3TJQVLNMGDk50ilus?=
 =?us-ascii?Q?HADwwE6XGy7zHyc8C2psdBYyNpmXsB8+0DeygR7g+sTXCR2rqHBQFJRtPFrX?=
 =?us-ascii?Q?MdLe/KIzpEsDKBhnUrBV2Tuycr/3wxxXRs6jOj7aEmmK6FO8QRXuRI2wFpcA?=
 =?us-ascii?Q?GxFU6hw08dKDUBe0X1sFJOA1+eGHiHP8kpb8Mh8EFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKmx8Uo3s/G9CLhTJoZm8sB/dMQeshoh1JnopuXQGNBBoxjfYRFZLGMSCzJ2?=
 =?us-ascii?Q?PmjMCWc9XGtN2fx6dhNLiadXhK3GAyx1KXRtrqcNcpV5imS7KJlgLfsu3Dw/?=
 =?us-ascii?Q?X56vbFU/j6R7rRqVRZrxG3iPLomJIhBsBkN7UoYNQmyp4SERowmwdcuI2Bg6?=
 =?us-ascii?Q?CfWvg9Q+P7FZiyZj24gKivdGbWT1Q6AdnJP4d6pP//sT/hXyl+vJ759jcUCq?=
 =?us-ascii?Q?L8hDnzKuxEHEbrAw2NHtJqiErxVetqfUT2IDnJnTFuXjIR2GL3ca4cZDt3B+?=
 =?us-ascii?Q?Qdkc6p7dBUZuDX2P6khTLav5B00UWeCFrMq1go2Qvz1+CGuvSSI3+cA4gw67?=
 =?us-ascii?Q?9QT4yuw8ugkl9Epe8/HB1gf3N1hSI8yN/8ww/+IIXlzQwWO+s/3yjgHbkgUY?=
 =?us-ascii?Q?MXbZ5mdRHiQtW5pwVnsrpVNnyDqj2u1jFYJNjuuL1f8XtdBkZSGH83xSrXQP?=
 =?us-ascii?Q?GhQtn97fj3YGeSnxlEjGlnQcASkLyj8XD2X+WMYL/253VddDsgB5u+qjwCvU?=
 =?us-ascii?Q?cTAtJPG4HVR+AkVFFJiMUf2B/tt3Xfo5ZIRt0u+Y7uYaHsCnOCASvmuzcpH+?=
 =?us-ascii?Q?NpC5bIMu+02VXI64UmJuyozdQEBN2wBlYoaZUoEiEkiDD+hQ3JcDsbdwgsm5?=
 =?us-ascii?Q?kCwg1/lMeIrGx53Oxh8pBJB/3rZne++F3KtcDGXwY4siMlwJfMLRuU5AJrGI?=
 =?us-ascii?Q?znItLh4Dzejju+Q8VCMPcgLZf1G6XDILarvu4BTiQTspEkDvpZr7ZSVIqc+b?=
 =?us-ascii?Q?FrvLqXmLGQ2wdqQP6n15f5p164G6JV9DOj3ULzo3XYOuzvCwe+bLbkEASXsJ?=
 =?us-ascii?Q?RtAHD++YtpkFv2JiBYOew7jZbm9ux4P4V6qwlutYx3Dett/sXh7sIYruNsLq?=
 =?us-ascii?Q?iQ6ER47ap0Gv3Axf4xsehbO6nbeXe2zj7psChMLOPNF8muYxgvKWU6T8CeVf?=
 =?us-ascii?Q?zFeNJXJ8OVWa3MWpxbCL8c5IeqmOxQsvqGHo9pOVFnDDFjmRf8hXCurHke2Y?=
 =?us-ascii?Q?RtTIRTAkrTiuMl8ZT4FZPGJ+PoXOVjhA9rcJvGQZU1P/CNHvyDYNfqKVfsoC?=
 =?us-ascii?Q?RflK86nyYWQVllyI85hLb5qdjOwgm5BnAW/b9oGGQ4vGCBkKkUudk3OXcZbl?=
 =?us-ascii?Q?EH/momRW0BcgjrVd+n+EB8n0g69e0/qQvZlkdf3B2fIZHN6U2mUS02nsPIVW?=
 =?us-ascii?Q?lSbnVGOLZVPjFPG4cCfJWQ6SkK+arjzQ+iqY/O1mPW647/JYMYRPKxC6F2Q8?=
 =?us-ascii?Q?oUXFiGuc0yXxIENEJ8WTWikIANGbAjcdSfsPDNKyuCwHnJYpsYQq3xRyj5pH?=
 =?us-ascii?Q?Ix0DPmjZWHvDw0GKrQ7K1psT3T84m8Ooa5P2tWDM+6+A5G9oyW8B4DoxwvQ0?=
 =?us-ascii?Q?MYDo4/GSIAncxeGp6S39PJ4AF1MvpsFI6siI5IBeKPGeB4yE6MzkwBfctIqW?=
 =?us-ascii?Q?dUks9lrm205UZQ8BgfpEu6Qo/3SxMeAy2ocBjg05frzIcKjTBYGRZOVEDuWR?=
 =?us-ascii?Q?IDcK3rkyBRgItukYacRh5M5sTN5mfByI8vL4fCiTgZFEaT0mBqS/Y4TgFtNB?=
 =?us-ascii?Q?OoPihW260IykPqb90x4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f5efb7-63c1-4f88-8802-08dce9e8629a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:32:27.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHYiC+AjrUhjgiKHLlDFt3VdoWeUKIeaxNRnBQBZBTVLPQdBcK7T/wr+v2RKr0fb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916

On Fri, Oct 11, 2024 at 12:27:22PM +0800, Lu Baolu wrote:
> The domain_alloc_user ops should always allocate a guest-compatible page
> table unless specific allocation flags are specified.
> 
> Currently, IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_ALLOC_DIRTY_TRACKING
> require special handling, as both require hardware support for scalable
> mode and second-stage translation. In such cases, the driver should select
> a second-stage page table for the paging domain.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Maybe even for -rc/stable since it fixes uAPI?

Jason

