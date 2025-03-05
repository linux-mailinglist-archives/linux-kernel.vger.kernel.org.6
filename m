Return-Path: <linux-kernel+bounces-547519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F36A50A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4011C3A7BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23518253358;
	Wed,  5 Mar 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R7mhmB7R"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4192253326
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200842; cv=fail; b=nj3dtda1tUvMqu/nXCdVf2HwxRl+PNWBYnp70Mfe+u9P54lzdcy0lextMV5IfoTHW6KYhrx7cisdivhHzUXvy/w17QLrDo1x0MFpxH5symK4SSGEYI4p0TnpkwsEfIr54z/sZ11BaorTfQnIDs2W7bJ1rl4SgdjvenIOvlLblto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200842; c=relaxed/simple;
	bh=+4pq5OGRX7PK8BrRz4IT2zeXL//Cuz1fsAuYy9M4sk0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD0Y8MZoLMeq4RkWJ47qF4BrakKZtWvzVTxgKTW0etvN7RP0c4rC1qIX1uo9uOkh8dJsdTJF7k1PLs1zTDIXqSF46KZTt5AdNZExTgR5bXAkHyjAVbJiIP4eOJdcXmPWUvRC/zll65o6IbEG56FhdyWvwEDPWhUh9TdI1AMtmi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R7mhmB7R; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBCNNFxzr443IiA73y51pubLYhA6u7JfV1bsQohmrtQ8ko40dxchQA3OL4NE11rKw6HqF1uSgGzfuVdQkAb0oUhmkNG1cliAo4gygvj1mCP2XY3wyimwFX4IVxdRne/Ql6H5Uw6HfSzcYSEYSiREq8Mn+S6Y+6X78Vt5AtkAECwbfqxOGnk++9mBZG4Htbb8fueqANHUKleLxeoALzO+tRLl3vQ4mkMZgQogPFi7O0hm3Hwab7Mri/+OJDbAjX4sWzzIgKwIb4saNRkrArIdy0vPau4j/SwrbrLCYWQ3RBHLIb3u4gT0AP1feDMfcgDaQU6YmQn2H7dyhwWMIvds8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4NmDYPwxglN5RRv8/uK+lu3JemvSTC4c2kWDB2b64c=;
 b=n5irR6oOCeKy8Hbhz+g0i4ctbqIVO8LIMq1PeGeXQu+YtUmoBSxbPXQb6UYebujhpCbFaQnKq5aZrB/HyxVWY5NWqLEz2l137yyqamBqc9ydjT8/ESGbKjgPjiM/p4cdz5gX5+m4kPKvBH/PEIjMtk3d4UHeDqR7bGM5wcihM0p/CCDA7puqmpBvf68PTZ9sLykciaCCUSxj/CELSPAZZxgHKtJohOhXPaCyYVCEyf4DDZeqnqcR9A67CXrU772rUpq+IKXZI7pVJjCqNXtT4pqF5W4g54acJtTmjhwZcPnogOvEPUtVzn6YSyr1U7NOE9pHasctRlnYMRVvsBTnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4NmDYPwxglN5RRv8/uK+lu3JemvSTC4c2kWDB2b64c=;
 b=R7mhmB7R2e1/9o01aCCImOh8yalGbd22mle/EMarBv7tQEwEPFcbbDx5ymC5SXxKrtM+9Hh//G8JOERdNndXO8dd8FsibYpLykx20iEISDkjJA0k1SqUR78gvsIVD/OpRqLTZ/Vjsn3SmSccI3xmTT6dKhddweifJMgyyKgBbkMn25myjnSWmMS8O5QHDUA1J0rjtZ75g3Fu0E5/8cUFt8wjwxtqjGErNfQPQcyd6OLY1WOX9kBp+HuJMAS5bJQsYmOnNWRY4LhdzJFycqhVMDxsr6ZX/ZWwE7zvwfbPRUimf/imxUkWIN+ohSG1/9cYgHPK1FFZJM2Szed5Lm8V+w==
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 18:53:57 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::66) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Wed,
 5 Mar 2025 18:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 18:53:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 10:53:47 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 10:53:47 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Mar 2025 10:53:46 -0800
Date: Wed, 5 Mar 2025 10:53:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<will@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iommufd: Move iommufd_sw_msi and related
 functions to driver.c
Message-ID: <Z8idue4YKTB4Wif9@Asurada-Nvidia>
References: <cover.1741034885.git.nicolinc@nvidia.com>
 <01eef75aaf5326067d8a237496ca67395994760a.1741034886.git.nicolinc@nvidia.com>
 <20250305175315.GD133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305175315.GD133783@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9036de-f6f0-43cb-bc12-08dd5c171544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9zMz6bx0Jr8f5vlSZ6ESPBuiW/0tKn972RllvGzSjU4x3KSLixkhvDFcU8tI?=
 =?us-ascii?Q?uOhtlMMoDTpHQIq9FnuYfOZu6KP6qFittEMvGWtycWYrcwK6HY8QXihSf5ob?=
 =?us-ascii?Q?93uWZh0zWOihaRStO17M+cuUkNgujUzLSzCYlvf5jpBFOP+AnCDFlJ7NDRcJ?=
 =?us-ascii?Q?LG+IR29/cDl5j6ON1pDzcGF+TCbeOSC+H7W4RqrE3xtSjcrWYzZgrU8DqwVJ?=
 =?us-ascii?Q?20j9SbQJ4f4e8CKGOKzUaVltuSrI/5azAjohbNnLhToCUbQZSo1b7VEK9XzQ?=
 =?us-ascii?Q?BBywvsudgoAELmyRk9jLj2rJbO1k5fx6eZsaNahJYtzcNzVcvcWCnOqOGf9g?=
 =?us-ascii?Q?t1qo6/1CvAaoe5vmtwu8IJ6gZ6x1nseR/Nf5WRu0mXfbX6gaFjVGxpskzSxw?=
 =?us-ascii?Q?OH9lcfDoGxzQQDwV70GK+Kr3ndsO/mApKJf5bv1h4OHNjqwnQjbi3rv9ON+i?=
 =?us-ascii?Q?khgh++H5NjQm8urdLNNT50IW+um4o88ALbCXWz3KiEGlsOZOA6YuTLr/wz6R?=
 =?us-ascii?Q?gEn/5BO7NBVeIGeYeashPvLNF0UbfJrdIBkz9cj8wBdGd9889g5iDzQ33VI8?=
 =?us-ascii?Q?pnDv+kwp32vxtIR/YD3VtDmf56XLia336kWrbPgr6s3zEEnROs3iH0yzzRUC?=
 =?us-ascii?Q?idziP46rpr0hGqtjffES79ORj/kQT0cEnAZCakOKfunDzlNUEWffylkt8yff?=
 =?us-ascii?Q?vruuVU3BvnZ/gsthiSX08d4Ip6Tjot2m9uZBw574a4OFc85+bpoIcZJJZSLG?=
 =?us-ascii?Q?5nIdTvaqn5jziy2+UdANfm6ByqvwkSLa+g3HEKuXU8JRwoREt5EIU+ukIUjQ?=
 =?us-ascii?Q?6ASqu2JTKYSShAGaLU+r/CC15mHXfy2cW09IWFIx8GN72Rv4OK8kt3MbOCdA?=
 =?us-ascii?Q?/rfBzwvYhd8oVsalh9rC7Bjidy2htotrN8nKVdK8CPgSuSVJc1CqzyuV1EiM?=
 =?us-ascii?Q?AE1TwlZCm/4C9DKs5WbBPSVtIwQaNTdz3wasVWs2ktzwRtViTMQJKkyPB/LA?=
 =?us-ascii?Q?lTB+3CsQlP7YYkTS4jxlWh7Xk4HQeC0YVWvtV3IghL63UUs+vmXKGyJtjtZm?=
 =?us-ascii?Q?VHDb5WcZXyL6YBaWYiFqUEjS45+DuHmk3OyGgFcuLVDhqSE0tBxDIpjRFJXd?=
 =?us-ascii?Q?YMRzNhFmfabG/W2KbC76ayhiIz7iA5g5zNGz5z43MSzlQqGxjN5T1J/Za/2O?=
 =?us-ascii?Q?sxgQsUnYTVA0baGh6nIcNuXAOBQqB9jPAKWsWXen4OvFMzgUUMxQIIkgEI8c?=
 =?us-ascii?Q?UWyLhLpmRv+cWsiPBft5EIGjmNy+W798qOIqMCW+7biYRi9YBZgkY3qr5LTK?=
 =?us-ascii?Q?ATqXr1T+R+XI5L/2lz4kzwRbuDjcY32c2Ry9/WpQHvIcYM/j8Ckvfbhqpap6?=
 =?us-ascii?Q?rru0RhudIIq7zhSrFzlZ8vtmOqMIbA2fLQVgJTkRDXxth7hYL1VFlPQIWRKc?=
 =?us-ascii?Q?P1js64WehSR9LWvEfDy6I5O4XR8YzPYz50AOmWaQjOJ8mm/l5UIXKMXOZg4S?=
 =?us-ascii?Q?f/H8llnJd6AcSwg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:53:56.7151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9036de-f6f0-43cb-bc12-08dd5c171544
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

On Wed, Mar 05, 2025 at 01:53:15PM -0400, Jason Gunthorpe wrote:
> On Mon, Mar 03, 2025 at 12:52:51PM -0800, Nicolin Chen wrote:
> > @@ -458,6 +337,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
> >  	if (rc)
> >  		return rc;
> >  
> > +#ifdef CONFIG_IRQ_MSI_IOMMU
> >  	if (list_empty(&idev->igroup->device_list)) {
> >  		rc = iommufd_group_setup_msi(idev->igroup, hwpt_paging);
> >  		if (rc) {
> > @@ -466,6 +346,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
> >  			return rc;
> >  		}
> >  	}
> > +#endif
> >  	return 0;
> >  }
> >  
> > @@ -682,9 +563,11 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
> >  		}
> >  	}
> >  
> > +#ifdef CONFIG_IRQ_MSI_IOMMU
> >  	rc = iommufd_group_setup_msi(igroup, hwpt_paging);
> >  	if (rc)
> >  		goto err_unresv;
> > +#endif
> >  	return 0;
> 
> Lets try to avoid these ifdefs, maybe a empty inline, or maybe just
> need to put a if (!IS_ENABLED(CONFIG_IRQ_MSI_IOMMU) in the right
> spots..
> 
> I'd also include the size measurement that you did in the commit
> message

Ack. Will rework.

Thanks
Nicolin

