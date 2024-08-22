Return-Path: <linux-kernel+bounces-297429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC79C95B82D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B03283385
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341A1CBE90;
	Thu, 22 Aug 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XNKw1Wmv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500F1EB5B;
	Thu, 22 Aug 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336407; cv=fail; b=Oa5AzysDBOStM7iDffX2dH+KHBlm+cGkcuB7niwQ5PIlCWFHYn6K4MS08Zcx5zr35oGI3E5ENPfLPrfXqk5EGUIHxmnlaQarGI16Hspy7f8fDZtSSaac3/Dy+id68x5J1phyc9bJ62ryTYCE6o2qyWl5YsF0UahX2s9YQvlvKJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336407; c=relaxed/simple;
	bh=zIf7jV5O+YDOu+8JRdu3UUl70IROXyLOLmI9sZSGbuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LgN/6K8bKtOHMrf2fNEsU8JEa0rFIU4O2IMiEjdPxZmdcrk7HZ9pHwdjJpC+DSj/ChngaCyP/nlcBb9prXbS+WJdowpO9x5hg+t2ZwnzMkFxk3qtu9N6KljPyftX5vdklAzdpZpO8R3teAf7HZD8slm+USBQ//nY0JyCTmCgSrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XNKw1Wmv; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj7u3dVkzn7iLGOt7xHlzX0jssgCbuFm34umsnMmSjvuIq5DEXjmPv7sNvORzvGoeFAxI0Fm5iSjBFnwgUp4srg7kxbmoyKiQRUbM8TSXY32FZi1WVCUjxvkojTTzSSnKaX9ybJAWw1h6AzC0TGxbe2hrJugC62FRUoos6gnNDLM3KR07tDQ9/cHqjT8t79II7neZ/9deGOo9oNfFHJkOdqyh8qzbaufjvv3qPUO3q2j22tYuTVu1s+WTB3W9B2nc+w5MXP4lpPC0nsmY3Xm0pFx5wXp1+XknJ4iZuzABZrFgnZBZGgkj8FY4edHY6C3gp/Jj+Pul/c3q9V9GIA35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlUBu4W8d98C3c8Q9/95Xv+hyFGrsQB5ZPVlXhbWWRg=;
 b=tnqOH5tVsT5pa7NbUbpZwGQMdFA7SVWKFh8gOhKrUM88YDzpW0K0zA3NlIftBLwDfFpeYzT3rzUSX6R4FFDSjTZedbtuDstdBx3G7W4i5GPa3//vVSrk7dbbjPo+DTDAobt2/pmg+r7lRlgbM8Hm238htJT3xeMtRBCNphg8shR/9BVtjDjs/Xp7Qmm4zmR1NfXd1xloUPHkGES3g0EVCpejTfO1toX7RrucN8C9V8GOrCRGY6WMWKXm54iXLbsB8+eXvSLdH7ISSnU27sq9lwgc7e6oJQkmAte/RIyCo+HwH7B+nrBOyTvS7eAedY7fe8qJxN1TH//C9bEOZfcrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlUBu4W8d98C3c8Q9/95Xv+hyFGrsQB5ZPVlXhbWWRg=;
 b=XNKw1Wmvfa286oW/LHz4GhtIV1D714EiN0rdYPGHzQjJyrRTS4tludumpsL2a0KJtgXObp0sKBcoQ1fCFfGT/5bnC2IDQCTwOzQT/udTItUO6MPof8iy1avCQkY5YWp+4f+N+E8HXyJ8rWtmIh+3flwm7/DweHM654kHAQ+Alk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 14:20:03 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 14:20:03 +0000
Date: Thu, 22 Aug 2024 10:19:58 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (k10temp): Use cpu_feature_enabled() for
 detecting zen
Message-ID: <20240822141958.GB211090@yaz-khff2.amd.com>
References: <20240820053558.1052853-1-superm1@kernel.org>
 <20240821130916.GA1062@yaz-khff2.amd.com>
 <cb08e5d9-17c1-457b-af9a-a172feb5e72f@amd.com>
 <8e93ccd6-803e-4750-a1dd-69f243f5ddb7@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e93ccd6-803e-4750-a1dd-69f243f5ddb7@roeck-us.net>
X-ClientProxiedBy: BN9PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:408:f6::29) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: dc73b9f2-0811-4311-3cf5-08dcc2b58392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4CGChERogxcGEY2TnM0Kq/K6gvWyO3iN7Xfkyhm68uZmcOGveo1UZJV2zoge?=
 =?us-ascii?Q?ghcp8oginMNlfHcJrNVYXmo6wbhQ4ufAtPE1yWqAO0gyCMhOZYPTI137ETJi?=
 =?us-ascii?Q?EoHd9s4e9ZaZo4DZ1vuabX+uKMkdWzVH8iBlQ7ZBFaPn3lJo5Ls1FVe/voaw?=
 =?us-ascii?Q?uCCvjKMjNqc7KGx35I/8K6g4tYHw84oypvPxeicp3Fr8nYRx1ZhpWguxbPSg?=
 =?us-ascii?Q?mqGM6pGaeZVuuFqscEDNG5VTZYrtcm1jxIaEV9tBysCQ3tvyu5cFIFir1DJL?=
 =?us-ascii?Q?gAdDKJtdRYSXPTypu78GJIgm1FsC1S9Lp2axhD51W0mifnSrTUeocc+Opjjw?=
 =?us-ascii?Q?bmqtljZgHUbfOuhygbRlTdRyG/iKJdnbL6rsb7EFD1BnYkkUJpBvQR2cZ+/b?=
 =?us-ascii?Q?7EyuYJearw+e+PRzHZ5K3LAFHjdlVYx2MjHKWNTviZ836ECjIsHOoENbMhAl?=
 =?us-ascii?Q?nLMqgSXAxlZrzBDy+8PqalZMKruYnhdJBDsWd0t7MMUk0Yc1HvTBO5De2Knr?=
 =?us-ascii?Q?0B3BifQ50Wl/mTTkWpNbKg8OT3pw8ofh+4fQGH9It6cHz2YJ3U+Ui9PyhUii?=
 =?us-ascii?Q?RIn+ezWnULjMFKm4HGMXKoQjyfpEiteN6Nm0uOzZNgeS/K/6/KDHW8edzy0S?=
 =?us-ascii?Q?5uQQ+3TbYJOooosVCSvp4IMrfegqPBeJBcbxYUGmX0BBGsHmFhd6USET0Hbk?=
 =?us-ascii?Q?70Lzl1hLkYENBv4XMlcx5b03lk23/ww967gAu3LHB+Ashjs6mmYGtVv5nwGu?=
 =?us-ascii?Q?niAifyAefCeC0PcdtR08jT0gmpFCJmOWXQPj48QfFl03UX5X00dWCzpe2V31?=
 =?us-ascii?Q?McBYhDsUI1rFtcVFncdK97D/wzLqpt1CE0UD0FjGbkThuRJsQw/yu6aewO++?=
 =?us-ascii?Q?yWMhp2BNMX2ckVd//1Q1VgEr+mUbWpoQJnsM8wU7+vtMgoYWgelgJhLxy7RY?=
 =?us-ascii?Q?o2+GKG2XxkD1ahFFr3bga7pSud4RxKtZ7ursLWuM9FofjplXQ6AOMn6o+/CN?=
 =?us-ascii?Q?VvKewtEEdjC4lFB7gqO5j4OLsZgi1SlZvOzBha6rs4p+obCMQvW5RbshXAGe?=
 =?us-ascii?Q?92JJioSLdgTZc7Zu7sAV5BMEQ4mS9qfXK+YC6whce/G1h/yxAdgjV07gg98T?=
 =?us-ascii?Q?06ni24lLnmApbn4hr2GaIaxqbjeREZ6r0m3HWbF0fPtQdtADtGSjl4MnX1Og?=
 =?us-ascii?Q?y1tolytsj2klAkKozeacg7lhe8uAh1fUj1QXYyNPZPjFfvOGXnmrJRhREkab?=
 =?us-ascii?Q?8+MC0thY285MFy2aWohqwq3qgZiMv6W5FEAN3xttKXYr/XX6bkEOj3/jEfa5?=
 =?us-ascii?Q?DijYBWCfDWt0rAk3DrIbEFQCFgYtGUd8MDSANRuFROjSAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BKIoAkpO9GaUxH7IGNIxekpYQJGA9ly46n5zU1v3gKiv6f4dli9mvtBSPKk2?=
 =?us-ascii?Q?cMKEv+ylQ2ZjQqHNaTOy+Fw+GRzFH+TP//0dUyCdczXIHgN0nGbngadFW+9u?=
 =?us-ascii?Q?5L/sCRFPFUkTp25s8HdLBnw+aTW2v1Jv7yvehCVdxHtcc3d5ux73m+jH1mr4?=
 =?us-ascii?Q?nD/R+cvktvwl3SeU+p73akkwvjTxRUwWoy/sfXf8H+q8PSg50IDycU9fe0q7?=
 =?us-ascii?Q?C9z1F69P5aj9lFYix9vuZIzO1XdetxeVYawI1sTzMj3JYU9Gw1oIwCtVGLL8?=
 =?us-ascii?Q?C854xHXKASOgHaUHmI7u1gDoNhT4LyTtkvJkryqVM62QcFhBGGXBQX/Azf9R?=
 =?us-ascii?Q?BlTzBPgJLrYE8y/Ec4WI8qQ0Prz+m+a9NeWcjd+WZW2/q5HpR9Md4HyOZjh9?=
 =?us-ascii?Q?Jk1FoKM3P3MxoVFxMeqRqfT0oXBpYH78v2KmGWj05guWvp2ZHlxlg1ngqOE0?=
 =?us-ascii?Q?DKbX3oFC95M2DscH1aI12zk6rumuDxn+v1CRe9rjhdVbPte1sR0eQ9nE2E6X?=
 =?us-ascii?Q?7tfdDStaKj8YAjNB/o8Rt4O1dZZE3tl+UHF7HwHw+b1nBwz1KIJJFkSP5Y5d?=
 =?us-ascii?Q?72pWDt9D7bvGLNVPesdYCAkPAZCWGEl+estUsClLfR76KlQDvb2g1EArV+md?=
 =?us-ascii?Q?6owohkV5NBNUfz3qN8AlzwErvou6TCn70pWAoML3ZidAaeDmwqwsCgyHHLR7?=
 =?us-ascii?Q?rj2l0V/knZBxDBjSo0pkLEDdLbut2g0c1a0xXSbNZpIN4xnWunqHN/6U4q0S?=
 =?us-ascii?Q?1EkQL6ysTzNf0Wyfd4d/R2dPwURD3FP+aZigic7kAvUz/V+K+L371iNz4HJH?=
 =?us-ascii?Q?TfXYnJkCinaRxjfkgZ5eBJOHovv9W0sR447cPHeMSs8slafKdZRKK7ORD7JV?=
 =?us-ascii?Q?pX+4GQ3P+bHlsh1vwRcwmqeUy3E94EUhEolFLAyJG0vqzAxdh5mt472IcUOy?=
 =?us-ascii?Q?Yb3VvEM5dWbKNV8T0IG2z7lTjvgT42i0utzdf/q70ZCfpn6lDOx7NkATVOiv?=
 =?us-ascii?Q?vRneMOCBMAIIFTWv79lPEVWJ8gKKxEYyBqiQ7RGjbkpNtoDwkQ+jUqUNE+R6?=
 =?us-ascii?Q?77hrTg+1jmSkf+If6toB1ZGEWd+cooMzWRBHc5ssJ6XiWXVDZ58zGpNruisG?=
 =?us-ascii?Q?uJH7GAfFkDabgdGGX007bupRcvzSzgWfPb+8MIVAaEudmKaJqdecblTDAXD4?=
 =?us-ascii?Q?Z9zr2pRRCG3duZ46EcLv2cwI/CG1AC5MfyUkk9AV4f1/Lppe/utLv4CtGDoq?=
 =?us-ascii?Q?TVQbzLhqb9uk6SpFQMgbhaOkD8CR1N2UyRt/hgcv2+eVIGQLo1yAwVUZPTFA?=
 =?us-ascii?Q?V2uJRKjwebWLmmPc2CCbKaf9CAoeke0MlNn7jIc/N6VP0FlrlL+48y4SQHE6?=
 =?us-ascii?Q?gXcISkkPn/EL/vZhwwa66efnUUn5VT7bVjrNQs04Uszos0Xch+xDB+fzdLc0?=
 =?us-ascii?Q?KjRlEdn7HePz7vdnSOtuMly5EKSIV/9IKUG9sW93uKbl3iWDUValYUan0KXt?=
 =?us-ascii?Q?zrj7MlZ471RbMRkIOLj2vGsdfB0RxR1lgcA1gO3sf3KBM40T/i6syQHjyzLg?=
 =?us-ascii?Q?qVvkaCOK4O/2GBcBhlJP+aMt+I4bclGI9HYhd/CF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc73b9f2-0811-4311-3cf5-08dcc2b58392
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:20:03.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSJayLPqnw6GQ2vjDBXJaK8yjv0ryvTm/yYELuTi+jTaIz+w1h8pkfvQya419xp33zy9c6zfx29RhlxCRfbvmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

On Wed, Aug 21, 2024 at 04:29:32PM -0700, Guenter Roeck wrote:
> On Wed, Aug 21, 2024 at 09:34:09AM -0500, Mario Limonciello wrote:
> > On 8/21/2024 08:09, Yazen Ghannam wrote:
> > > On Tue, Aug 20, 2024 at 12:35:57AM -0500, Mario Limonciello wrote:
> > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > 
> > > > This removes some boilerplate from the code and will allow adding
> > > > future CPUs by just device IDs.
> > > > 
> > > 
> > > I've been thinking that maybe we stop using PCI IDs entirely.
> > > 
> > > The PCIe devices that we match on are internal to the SoC. And they're
> > > not optional. They're basically processor components that are exposed
> > > through PCI config space for software convenience.
> > > 
> > > Thoughts?
> > > 
> > > Thanks,
> > > Yazen
> > 
> > Yeah I think that's a good idea.  The one thing I want to make sure remains
> > though is that k10temp automatically loads from a CPU modalias.
> > 
> > This is "tangential" to this patch except for the commit message reference
> > to the PCI IDs.
> > 
> 
> Based on the feedback I will not accept this patch but wait for a solution
> which is acceptable for everyone involved from AMD.
> 

Hi Guenter,

Sorry, I didn't mean to imply that this is unacceptable. I think this is
okay. I just wanted to highlight our general trend to move away from
continuing to add PCI IDs. We'll still need to do so in the short term
though.

Mario and I are working on some possible solutions. It'll be slow and
iterative, since we don't want to break existing functionality.

Thanks,
Yazen

