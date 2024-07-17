Return-Path: <linux-kernel+bounces-255414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F5934079
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47931F24317
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3B181BA0;
	Wed, 17 Jul 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cg3vIY4H"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D296FB9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233921; cv=fail; b=A7f6a//PGgRzFyJ1hZINV9O71w3J2iiFFgYGnVv+4NTsRNH67mznjHzsG+LUFL0Yuqz8Le9H7rI7F10e13rvzN97plazBAfTz/SKqaxhQ3AJrGc5fiCDjpIXd0PhrtF1HwhnaQLonvbn5TLRapWC1fmpU7qVbVcluAn/tnQ3Ub8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233921; c=relaxed/simple;
	bh=gKsXei67ri6aOtbFAghe0/R9jCCtl3XKWVsQIiMTK+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mc+1HewpAQKpObQwTDygvNFGvDN1VNqeTirc+CtrLoxCVCYWo/TfksRVkUS8KncZn4dWeREJQKIu5lz4dB002phYTNVyXcSkyZAr9OAjaAVoCVULy3p13vDZzNXKgyoCOr0A/0wgk9Jw9wrMdHAkCY6kUkJVtiL3WpytETid838=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cg3vIY4H; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmEIlQcnwDqxs3oa1BwVJToOEkxuyRp6VXAErwhTjPYakVvt1ZXTlVtEkgYr83KXZ/QkYS/cUYDa29yL4Q6gvupoSdl6QtHdONyyLnDJUyLcnz6e6TpIQDXAyvn5+4g9ofZGSSJ+fy4ELZB2FzLMN6NUb3itugJCDhY8jO/LfpH52JCrrOemNMb3uv1UMhVx1audQIQuV1WaHIerw39f2F1IjjS5mdMkbz0w6sXC2oNEAJ1asVdqnXDdYff6OpCBw9ypOgNwIga3OTnfzZA0WF/g5B5k7YFeIq0Q9XKNJ5H0iksfhJ11JgcplxeBjXhXUDWWae2eaUDWazdKhAxtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sPdWMO46reUrYOTttj8+uGLimwUb7QjGg5Lh1TvF/I=;
 b=lCQlEYPEC3Sgid3vNqcDmaTNnK7NS8WxM9zMHFFLBLZSbtLANjdHUWfMjSELCzXEbDRaQ9bJfyQyzdYb4LBMsDYYWLDTBqxTiiQC4et8h5S3Kt6GGJyyqKxa5CEpFUHYdOKtC5w/uKeT2CaGjU0OgTAyaQRo60oa5fm4PMj9wO9UYPqdX3c48rQQipb2AW7FiLzYASRzgeXo+GHpPYnqruAYvTh/mDJTm1Alk5gQIljnD2nRDf62GED9GvZ4xb2OLH3UxNrbVp/KhAYxOdu0JKKI9hRDbHmrPcwMZyFKCeu6Xt2LPtlPIs/I8JqEDbHANRHau0a8YINKcunHksuraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sPdWMO46reUrYOTttj8+uGLimwUb7QjGg5Lh1TvF/I=;
 b=Cg3vIY4H0UjwUe3loLmsoav1T6Wr8dxqPas7tdfwaEm/fVbBfxuUwkZCJqWcCvdyRx7/uYUWg1hKquPVcDFwFhpMtWL+HN1jdDy1tRyRWr5WPmgycDOVeCSv12+WgwPh3IOieXmvtVUZZnzhZMzAEnO6/7wrOyXL9OROg764i7775HdSrxUqEAAVLyih8ht8uB9NqHutEnYoioRtWrWbF4A0yohIm1yZdPZ8bO1BxxyZUzoOjtcfnw48laLXpWXirqk/llqZJAPBxQ8n1q1cEMi2TrMyf8XT1PkcPVGItYMGSaX8EktV+aGRsKlyX1qzkU0LTqEbTJZicZXKlbZIRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 16:31:56 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 16:31:56 +0000
Date: Wed, 17 Jul 2024 13:31:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"x86@kernel.org" <x86@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
	David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <20240717163154.GF1482543@nvidia.com>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <116ca902-103d-47cb-baf0-905983baf9bb@redhat.com>
 <Zpfxm_Nj9ULA0Tx6@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpfxm_Nj9ULA0Tx6@x1n>
X-ClientProxiedBy: MN2PR01CA0054.prod.exchangelabs.com (2603:10b6:208:23f::23)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdb06ec-8e0d-47f1-901b-08dca67df941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tt91lv2+LJOWPVzgg1xNbqk9hkzf7OsA8UGQD2KT1oESu+yvl0rzcJosu4VD?=
 =?us-ascii?Q?oO5ex8ua3nAiqDtkLA2e/7JosezUHEbS9mDeUeMu95pF7D80/dzRG66tYqEE?=
 =?us-ascii?Q?Fqll0QIdDx5ShYNaFVTnYeGu37YoL7AICzPn5/9haRwqcZMUMqGqJJ9rAXZu?=
 =?us-ascii?Q?YvmDuuoNmz/nDxtRaPQeqjxGoacitP3AxgZLRYEJOiI//TnTiLsG0tNhXxHi?=
 =?us-ascii?Q?OVoiowUSma/jU6sKTxycg88CUL42+zn1THFcBEuWEO56efqI//8cE0u8GXMz?=
 =?us-ascii?Q?JQQ7uGZVdiaA2kDQC3v+zvpJY1b0v25eQnUoLmCRAfgWWuHaMBatL+WfnY5M?=
 =?us-ascii?Q?OiGmLcAaNghZC7H2fi8Hr3hdS+KXYXfo5qkbmlVo+zRJNdCaIHFGZfWvwcEa?=
 =?us-ascii?Q?aedmRzTGWG+WTTHzcHJvI0ILUkGIJPxZAVolexXzISuxiOhnQITGDH4OYe/9?=
 =?us-ascii?Q?JC75yzxfyl50I9lHr6ObXDRcXU0ghI+GjO47uH/Fh8aPoDeXikIZX79yNODT?=
 =?us-ascii?Q?T7sxdJWeYFZ+eLVmXL5CShQj5j0tVFsH7aO4McOMohezAsib2b538FCCWg6H?=
 =?us-ascii?Q?yI7H1SjgWP8XmgWSlIUFoTCyPf1PkmG2rnHv3smOv6SRoA3ndIgn/m/u1X36?=
 =?us-ascii?Q?ATP+kfWrHAFMMcOkOn/mgqBE9yc6UdaMchuFJXa4XQzxe8oT5yunGZmMM+ds?=
 =?us-ascii?Q?ouI++drYdNPUDsxi3+62ILasTMRz6bQCUVh0XFvtPNgnOqM+/I2Vo+JtI8wo?=
 =?us-ascii?Q?wd2eGtNleYve095CBRYnfvDOvyCQE3wDj3/bMBxsvWp6nwj6Ef9kO0Qt2E5a?=
 =?us-ascii?Q?Te62QreJ394uKvHe8/IiB6/5XqwEQxYabJqaCLF4ey/Qj16YwLIxCW3GR0B1?=
 =?us-ascii?Q?e0f1Dwtw9wiE+9G0ib0BOMrlwd4mbi+DmDmurP0Eke1FVZZMT/IRZgM/8uAf?=
 =?us-ascii?Q?wm+umjNC4PAVnq0WHSE5+yJpMgnAmP/oG2FZoVS7wm9YaDbrA01QrF6pmBY/?=
 =?us-ascii?Q?D/X5iO+d0TmWlGda7ELIMUOG7rwn7wMip1pdAm6CN+a3sJSuzflmnAvIYs4N?=
 =?us-ascii?Q?txytWzj3PNmkUkRJnNTTPs1ga7rmsTIejHkWgD8Q0GiRCDC4aqae8SJkAEi1?=
 =?us-ascii?Q?CIwjS2pg6oo1fiwcr7j5pnHy5muquMKxwUH+1MiiIlj+J47/ZY79vWEcceSE?=
 =?us-ascii?Q?Vv6y4RLBAPS8a+F1JXaaSvTwIqxNmo452P1IVMyLnWj5Yj15InPjNet0cf7l?=
 =?us-ascii?Q?vkWgQNyaB5EVnZitUQsajuCi2Qe+jZCwQ61D9rR/VKWLpe0lQwow/KSBl7a5?=
 =?us-ascii?Q?bK0T3TyBHKYRXxK4eNZaptF2LM9xgteayDpEEGoGXvj5zw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?olo/luM6GUaHxtLAiFid//tuqE3EJTlgwiNrbXq5q/MPY+0S8sgfaRoepamn?=
 =?us-ascii?Q?u0eZqMqBuJL/dQwSjfbL7pwNvim7S7gIV9nA4sTgVm/zbLjqf7Y2HRozfibw?=
 =?us-ascii?Q?Q5YOK7wL6kFFSYJJCHs/FK84NopfdbDwylK1Ps6l00QBNo4EIWmEzWQ41YY9?=
 =?us-ascii?Q?FQDcDalTkAwYxKWQbhmWByhNMeh1o4ZobPfzAGerCE6TmJ1VwsnH3OD1JyIb?=
 =?us-ascii?Q?LewSbc/ikCGxHLdPutli74qF/2vymRKfKzH9nNZQz/OwaPCHlrUsZct4sfrS?=
 =?us-ascii?Q?Ipx+FIPPupvD916INY0AZdPpSE3JsN+6+gA/ScK4jqAjARBWC0gROzCR1xFa?=
 =?us-ascii?Q?qyZVU+z55IIVq1hjGHmRGX9qGMs0S3FciSgxYZt1NpLkfGNWctiqqpwpA18k?=
 =?us-ascii?Q?er+nNvZ7xsKXBKZkk/xZ+XTyjtxcz+Gjv7taKo0BXrRkGvINW/h+39+UN/FV?=
 =?us-ascii?Q?HlRjkcaP5z/0ABq0uNsJvZbFGhXz0WSEeUkAMXG6GP25rsnYVLh0Dmp5xi2e?=
 =?us-ascii?Q?UYj2a+z+Tk6g9uqmZ/xsGtjGK2ukzruys6kF6S2GfWNwvZ+2w0gzhEd/OTh6?=
 =?us-ascii?Q?9c58y8j2E44jnmA9KSRmF9BmWkn7ttnvKvGK8wNlJJq/ESw5s8WRaeR0QzC5?=
 =?us-ascii?Q?dU48ynbVJvmhXorA64AdOZaN29f+Ffs4rUiXQkkntnYcA6ByjPZYButTOz92?=
 =?us-ascii?Q?TBUqQ7Wcdnr/Zy0xBFBTxYtmZC9DHTDkoPasg3eIglTmL88ctSPR+Onn1+dB?=
 =?us-ascii?Q?4VB7YtblyvWJ2j9RlWq2w91wCENr+D+9zT7v3avD4k8YhDErFPB7eTV1cSuF?=
 =?us-ascii?Q?jLOGvDl/DfnccUsHY7u29loETi5JquEtN1ZLoDxcQfD5La0t6Ak4mGmEqGhG?=
 =?us-ascii?Q?hCj/d1cTygN4qQG+Mj3+oLFuG3y8hvci5lS27M3qhAIXrGNyqixznt99b2xO?=
 =?us-ascii?Q?QpCqhJrIjWa9r0roigd1317MM6+6EuR4/gfKxuVmX8Txb7DhPzXzSffyqdZ1?=
 =?us-ascii?Q?vbf2BEBvo/qGY1ThcjvzPOU4dIdoFxdO6/cENV8e06R1cQnVy2fjsiXIO6HB?=
 =?us-ascii?Q?LZ2xc+oc+NIJ2Ue8sFEeuidEAnpIa40eG6/vZWvKzPzFdQMpu9voZliyzYJ3?=
 =?us-ascii?Q?6neu5okTQjRfx9Qba0v4RV4r8c8qOvRQY3NdaurrLKaKvKzSYR4xRzQyRX/7?=
 =?us-ascii?Q?vSm8Ij8ttCZyAvJI35rw9xBx0NrtDW59i5iu2j1vUvY1/nUJhzBGeNNNYDm9?=
 =?us-ascii?Q?/tKEBPSqoNtpoxhYp3ZPIn7T9TmRYDi+OPrbGrXnemrkyPSzlxzJNjIocv2I?=
 =?us-ascii?Q?llrobN4x29kOfEhvAE6W2zczte+FDvIAYF75Ar/uKbbHfYQlXebHcwAN+Fm+?=
 =?us-ascii?Q?nZrKP3+xVnm/M7MmVQ+0lvN8GossAjHBB+jsKUgQl+mPS8L7Uc4EAEhHCwIl?=
 =?us-ascii?Q?MmbTzCtQwD2r8lw+dE0bGkaphWqDwEj+wpCT5CWExHq/a24aWqU6Pdg/BB/V?=
 =?us-ascii?Q?Pffqws1PgiuPATwRaJjr5IfCTCxpKmaMpsmfrRvcLc+geObDbswPIYtyXw03?=
 =?us-ascii?Q?v3P0i6ZFo0RTmk8CjpWbvPrUQKLpqUzGLgOALtuT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdb06ec-8e0d-47f1-901b-08dca67df941
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 16:31:56.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZCOcwgGVX8EL76pNwQFx6ZEhRjkDogwhyr+4UnZo8PdvLBDBkkhxs/2db29AR3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392

On Wed, Jul 17, 2024 at 12:30:19PM -0400, Peter Xu wrote:
> On Wed, Jul 17, 2024 at 04:17:12PM +0200, David Hildenbrand wrote:
> > I'd be curious how a previous truncation on a file can tear down a PFNMAP
> > mapping -- and if there are simple ways to forbid that (if possible).
> 
> Unfortunately, forbiding it may not work for vfio, as vfio would like to
> allow none (or partial) mapping on the bars.. at least so far that's the
> plan.

vfio doesn't support truncation? Or does that means something else
here?

Jason

