Return-Path: <linux-kernel+bounces-295552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67363959E32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245A128219B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E098919995F;
	Wed, 21 Aug 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rPj1eY4v"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630B19994F;
	Wed, 21 Aug 2024 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245768; cv=fail; b=UCfaxbDVaaY2iGjOG2OJp/SLfol5f3D9SYjcskhUjccN7a3CseucqWCxBpG0j5jE7xY4Jk/Wlvadv+ge7OBnUX0rN/Iu70/PwCsGcKvXK7GdjX0yo8UbfJdKqNw5T95V+8v+rDd6RDj5yD3XVXQTnJI1s0XWqC3LRRXpzenfbSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245768; c=relaxed/simple;
	bh=EhK5MrVtkx0keu3Hzy0H9R1lOh5tKcXUA7hO4swFy+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A1khHhYscn94FTdvHa5lC6MUIhvIoUH3lw2Gc1bRiy9KyIp9dU6PsVywFLXJ+oGckSxgn9b9XljQDSe/VQzup7DzO0rLBnRJx52L6t4LTPjBAu3eK2nitRcfEEj3s0QGpekPrUqxk4y/Y8bK1EQ2DDlDMlp3cJ9oZks5O6Qv1CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rPj1eY4v; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIuI5w4oax91/I/oLDx9gwMF4Wt6HD0PaGzMbg5ZnrwItF19dLSelDaxu0HzA5zVEVm++dyu8rGpmz2X5nLR1GKMscfsK55hK64gN5yRbuQvyXc2ctv5XOUMzBHL8phOHgsXWwEE/OzfEZ7jk5U0/XBbTDoJxahHsdBuhhjwz6Ml21P48MPerHL7oHVmss6Hmc6nE/cd80DzptBldBEqcQRxLpU7BvYVoGdX7gEt2ymCjD+c5BFpyFhiq6jjB0+3NLs1yTFsEPhEAEh8kaW5SlIG6fQbqGjFQUOcqmrmpSSacvjw4A8Sr5lFlxuIcMtvSvlL41bVahanNox4qRASrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxWxDb9w70D0070r1oNUr/NjMioZ0oynPRFXFk+HFrc=;
 b=aqfSZc9mww2wVsnV0jymitX4nFqgWax/iWc/EEroh/1f7o1wQt+6fIngFU6m5tMDiF66SRi4jaJcq6C4clLahZxWLByIuXhpvs4CjYS/deuAMjJI8/Vktftkmu4Zf4ImL8sG3Dh9J0HJq8+qt08QZzu1uxTbByDYUooZCx9sk16aEr5O9clrsph0jsL2S2xFEwc+7b4d5Lrq6n4Sl4Ol4+Rgp5meqtxb5FahOz2h1fLS7SrUXf2gQd2/HHBmiYkivx94xfTiWaJnEusF5oJpkWJj6W8bIjXlQhLdtK8V7BTCXH1tIN3iK+LqzEDZf4SF7nOysXtZBj7c6fJIVm3leg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxWxDb9w70D0070r1oNUr/NjMioZ0oynPRFXFk+HFrc=;
 b=rPj1eY4vEUNLUY/Pp7A7mg7e8jlm9JrpAc+CBFjqdtVYHUh66wbliIF3XkKFRpI+E3fkjTGX9X9UUcpWyo2/3pfxMYWXOkxCzeKrXtwV35uT20szY5x+FL+R56HnnYk0Uf1xBbjZ69qdGpG+p+sQEzjFz5PyPfrrUDg3lvb15S0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Wed, 21 Aug 2024 13:09:22 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 13:09:21 +0000
Date: Wed, 21 Aug 2024 09:09:16 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] hwmon: (k10temp): Use cpu_feature_enabled() for
 detecting zen
Message-ID: <20240821130916.GA1062@yaz-khff2.amd.com>
References: <20240820053558.1052853-1-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820053558.1052853-1-superm1@kernel.org>
X-ClientProxiedBy: BL1PR13CA0328.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::33) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c0cd11-5cf9-465a-9d92-08dcc1e27902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tmK+R9fVWM3iBdHkYGH4yzMuNji7gL6X5fnFv98v1V9eV8zktXY7ME+Byq8E?=
 =?us-ascii?Q?GFYgxkveGQS3pQFCmtZF0tcN7CIHjHN+7qdTo2tBvjsE7jtqEaZCA4iMSzUj?=
 =?us-ascii?Q?um/IA4zsOGIU9EtEcst5Y3u+dxonqnM1K+USmYUFZtiXtBnUO6xRHoJFEzmE?=
 =?us-ascii?Q?LwWfhKAJKwDtelRZaLgo2nv6nbin5qQmmqpyhnq9rilb29y7q05nCeMD6/9+?=
 =?us-ascii?Q?MY2699CSyMNW0Dlu0awz2ChQJcR3m9892sMbUMlCYi8MpJ8T0PbhAs164jCl?=
 =?us-ascii?Q?T4rkg1cYekZm1DVJH3WFl2f4gKyjhE4HNosxWe0/7WIKlP7Hno+43DoZm+k6?=
 =?us-ascii?Q?3TJB94RkG544cdAh/MRgQ/IhUqkL9AJdPbUQ+bgegJp3EELazdGWOzgvKsKk?=
 =?us-ascii?Q?gZ3zzlyAQLhD9tTHXLJ7MK9Jk8YNHgKYh4T/yrxgQTX5B2T50dZnvBEB0FvY?=
 =?us-ascii?Q?AebpVwyDM53VUgzqMHWpSO9ni/4s3XWnfH62M2UfyTF8e3mJr+OUoujVmSGI?=
 =?us-ascii?Q?ZZT2YwuJ2OCCACvuhQbxQt9KRDvNrcn4N5kgW5Ey0WYVgT1tuuZe7FYhpJyk?=
 =?us-ascii?Q?LI6JBTksQdro1tiMnIWexjnntpvgu0aRGmV2oiW6e0zwsAnz7Lh8VOQdqZpr?=
 =?us-ascii?Q?uBCeRhu1Rnz8z7Dy5MvEtuxhSbZboKF1kUa6foHXkhHC/mmMf0vtSsRx5+aV?=
 =?us-ascii?Q?JwYLZ2ZHESVALmsenMMrVGddQoBfuEI9JiGuI1pIkVqmSvGovhPkr757p6Du?=
 =?us-ascii?Q?c6J83x0gBOSl+RttturAUyaoKdZz7XYNafXWIlfDkvNNEL6Z3w0qvEGC17Oa?=
 =?us-ascii?Q?vZCxmC0gJjqmTMgN1pAOx1fvufHA0/GCTjXNowdgxTOqPr3JZwTDce9HEtwC?=
 =?us-ascii?Q?zvgeg4XIWmWEg93Rig9W5s1Su8faMsl78UsZn5AZ/7DpVhV8lhwWvb296zGH?=
 =?us-ascii?Q?Qx603RgmCGjuN74Nwy34stN3zE4dmxwoDY3HCAJK5yRet2OE3oQPtNspkqfV?=
 =?us-ascii?Q?a/9Xr0Jv+GdoEB2uRNlwO1i1YaLHpb9m3VdhxSGi4t2FdrwFOfASOnxStpuh?=
 =?us-ascii?Q?izGewxUOnZK0/8a3Yx4ye5jAfRXuDZG4V/ZneNcw7HiUfXuR3XS0YmpqPgfN?=
 =?us-ascii?Q?Mvp3+d8k3jh7gnuZJJTrnoX1+f3Wxy5TtBsrpf/ggBCD4ndw+sA2CftI2VEn?=
 =?us-ascii?Q?BgcCc1ZSgywbeixJtVAEFZighEq8su5jV1ZU3F08a/iTqiBsrJXNoXmen91v?=
 =?us-ascii?Q?WGNJX04rgcyfgtl8UwS9lFq8LsZIGMvdovMvJCjHOuM5zUNIvJGuxfCIwjxp?=
 =?us-ascii?Q?drnh4xBfmcDPkB/AY3If73JgQmpRYAN9uzFAfcLl2lSYyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djejAuqBJXKFthf7Ixq6kO3th7cQYr6RzvxWyzzrrj8hsq2OghjVTp+1x5XO?=
 =?us-ascii?Q?rlelgNMV5cTiabYDrhVEVIMjFFmoGUxOAMzf2MudXbSVxfVsDac4cMkfSFtA?=
 =?us-ascii?Q?36+MB9WpR+Id0LeOpwqXK4xyAS6KO1oczfgvwFPOyrcxRDJNXa1hOt3JK62l?=
 =?us-ascii?Q?QjVNxXtxOTTVkqgXh0vRxzq3O3qD45D8AurFDfvWejc7uyKwLvuUluYcRpDZ?=
 =?us-ascii?Q?eBcZHNe2NXl70PVHI8NKChPBuZRHZ1735qQj34Sn24kV98rB+oKqRGPML3Gm?=
 =?us-ascii?Q?5S8EllvNRJjO4xLSEQrxi/m0+ZdhRukCeyR573R8UDAXwUkfIX0P2IFV/PSO?=
 =?us-ascii?Q?hLHnpSapoU+0Cg/gY0rDUztsseDWmblj48rebxF1frxI+zdcCkB31mbxLeD8?=
 =?us-ascii?Q?DwblgQmcN5WykklWKtgh2Sk8MRWK6Uhcg/WD0gWQRplyw9z+Cjos3+rtDBK+?=
 =?us-ascii?Q?7rmLNRs1ce4aZ6yls2LHLR5pCAXmYmaJbu7j/WgCV6kMS2j9ZTfhBZvE8FxX?=
 =?us-ascii?Q?fO6rjYY7ZvmSGJh2fREv/4ntQ/szveweLvqOFdUNARhIc7z8WceIWe9HgC/m?=
 =?us-ascii?Q?pCB4Yv1F9OK4rX1oE2uq1sMhLOyObueqTkFNIM8eHmI1z7g5y1ncbSOinpWs?=
 =?us-ascii?Q?TH5p8/FWXz/rN4hLopxWtIaXBGxd72bDgcvZVlit9/oRUfKAnW1iBjMy1kjH?=
 =?us-ascii?Q?32sbj/Cppdcf783XoUIuFXig0Pr+nGbWXOV+Rv3yQGgnK6dGxIAi3biW1/oV?=
 =?us-ascii?Q?zp4643nInovGQihsDZB3yl9C1W7pOzRsQgycmgi8uqhdtGU9t0RXvMk3WrSX?=
 =?us-ascii?Q?WG7YiL8T8Plj5gsE2UxtN/CfJqv4KDAtFfRIRPKrGtXuE1hIL1uf40xWAH6O?=
 =?us-ascii?Q?8c+zCOpUNRfAy1BL3FklZEqh99Yzjui/5z5ezsH4avEAi6OK99OPRXXRFWtt?=
 =?us-ascii?Q?yMAFJUwv6+PmDATQc77GgDOlPPfS2FLykz0uml/w7p40fA+PpPzQN81VtDqB?=
 =?us-ascii?Q?ASDkH/fHFsGbz6dQp5fgxAI6kcsFEF5yJb8Dbb3BWQcdJh8k050ioFonNf9Q?=
 =?us-ascii?Q?o1r8GrG3YCYXaukhKIzRRGzUakD94kLdvbx4FbK1l/O6Abd557y4ow//+Qts?=
 =?us-ascii?Q?T7DNgvWMXsArOyqLHA5pTVYwifgsQOHMklA+ILehDJP5DxuS45orrm+XmahJ?=
 =?us-ascii?Q?ib185MqSzUYdEtfgkeiHjxJRdG9JntlczlPBIHxp5Oph7skKZllNJmde/ZPQ?=
 =?us-ascii?Q?uQa6d6w1C2Gy9+9HrRyB6Xb3sTMRuJ4833FAKMkiUqcJQqKuVCtXMW3l8C/5?=
 =?us-ascii?Q?EoJq5CfgmHwc7Ha/+L3yGCQJgh8jW6MiceLY0sq8SYWOLuGOJhWWXXJfcJst?=
 =?us-ascii?Q?6WAuHCZDafv+XMUCSXfEKp4yEr1pjHuUHpw5sh0tV9tSzWdUSkyViwefCgHM?=
 =?us-ascii?Q?NOr1/+Tp5k6x36v298EQY6qxrr5V+AN5IEUjs1SOmPH8Njxzzi/6wfqvKMbG?=
 =?us-ascii?Q?bxX40f0dKHboVn991T/4p73Q3up1f1xYy8BrTitUrfTThwq0W1fYmpB2obob?=
 =?us-ascii?Q?DFBu1VQtkSlUp46HGnKXCS+htS579bgqnD3lZVZ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c0cd11-5cf9-465a-9d92-08dcc1e27902
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:09:21.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpEFAiq+JcFEKrhkRHlDRKfXeV+ZlQ4UX3AE+t4+beBWK4KboVsfUTAzTg9KO7k/ol2Ud9zAfeWpspp3l3pCDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388

On Tue, Aug 20, 2024 at 12:35:57AM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> This removes some boilerplate from the code and will allow adding
> future CPUs by just device IDs.
>

I've been thinking that maybe we stop using PCI IDs entirely.

The PCIe devices that we match on are internal to the SoC. And they're
not optional. They're basically processor components that are exposed
through PCI config space for software convenience.

Thoughts?

Thanks,
Yazen

