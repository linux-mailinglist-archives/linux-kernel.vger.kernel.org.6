Return-Path: <linux-kernel+bounces-539188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9142A4A1D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D571890FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696C27CCE0;
	Fri, 28 Feb 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vaetg57A"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0D27CCD4;
	Fri, 28 Feb 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768020; cv=fail; b=RBymmC5wmTJYJspOy91xOU1m2sBUOdX/Kp5e0Og/NXNVWVybKAMWgTAuyeQ2tVYkL4Vu9+UH74mOQ57Qfi+LxnuHu2AZnbZirqzSkApkChwpsAZ8kuBzJnp71QtuMSsSTEpASHlVxTr0E6d0rnT/4D8DNRBw0+AJn6Fn3POEwSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768020; c=relaxed/simple;
	bh=hS9cYrQnFWCEn6bny45Bpgp3/DwToWF0OAExBiUYDNI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e42FiwrNO1eahsCG1AST7alOgHtE0YTpIx1HsXcMtCd4OBqN3MSTD8Akq26gXeKO0rEi2Rp/bNRvyUQSZBma0N69d5G0Kn/HmiE/HSq0wlHgsIFI3EdEtcPCEaXwyVtNq0ETbhjXT3qudIfXdKipNDJMWpEfr+XLMkF9kO1/nO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vaetg57A; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWd+yJ+lOLz69iV+GuXTgtxFhNMhmErnggWNmJBiwYMpvVwFjDrYJ2NH8QbNbx428raMombMidvv1kTptOlmV7g3Q0EI6QLPxJpsCbUAo7E6n+1jBaypZw55pyGF8MxbWpoMsXn3n7ZAmZgue960Q/+4qJEYBNXEabpgulw+nn4mnXqBQmGO2/01rzNniY0nqk6N81O0EMageVla5vV01NUmjysjHlRBxelwsNyufsdlCuyXFDQjympv8JctyTEAhadiQBfHG+n51yyfOUNvFc7WMKxrTxtBEWi4D7TcylXB8elgZrDFIYn9dIn0KsPZEQNu7p6kBNYgQU0/Us7x3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKW+DtdLI9fFxtwyfnfn/AxsjzUyv+C6Fn3yU6FlNDI=;
 b=X5gGj/zN9btxLu4yKBGZ3rBIgsjRWhRP1Wz20uH1HfeM4/JUZJw//kgGwHxvzVXl0PGWL+skjgIUD6+5ttWzKPRrRwAEzTXA04GsWv3fLDcSctnxG34CUzSQE5Hfj52eSvpC5PRJI0b3JUrQDvUFbkVS67spPSzbJh4nQ0aYwZKwMOA7dxrw6jTMaWJ71SZLNtEOssLglDCNCiVDWrDHrKse3ppB52mXFRD42Sd1cM2E0NyJ7xlC7u5uymLaa8K4dnJvH026kSZRbC4z9XLFI13DWjrXJPsmg7evbdFSP8LiwX1n2WFH4QqEbNKBMTJdN1qZQcB1YTMmELWFDJxerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKW+DtdLI9fFxtwyfnfn/AxsjzUyv+C6Fn3yU6FlNDI=;
 b=Vaetg57Aysv+juJzyZBgEau4gGiyhA36VEaUTWmX8/f0NWer1b25OPMvkSr4XetpBso3VGdLGIogo+RuonXcn7PQ30cLpt2R1qesROKyn8LHCoSzYXLeCyD5W1gEJfnkdkpuDvxmHatiqps5WFtr0jxBhYS4kWH2x3z4xNnLeCwCbS9PTVAi9drlTDCCwBxa1qRGEq5j23t1JGbxSY4wkAbyvo9A9friuGwaoXnsbzDlf7LkYGF3oCVTjBdFm+vZhrJ8IYzfEM2elQgFclye7TQr/muqDlu/Rj4dATpsQqgndiEODEcrkUDoO8JVFRcM50QIOjH9qu4jxEsW08MK3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 18:40:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 18:40:15 +0000
Date: Fri, 28 Feb 2025 14:40:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <20250228184013.GF39591@nvidia.com>
References: <20250225225756.GA4959@nvidia.com>
 <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com>
 <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
 <2025022644-fleshed-petite-a944@gregkh>
 <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com>
 <Z8GViQzZJVFPxfNd@phenom.ffwll.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8GViQzZJVFPxfNd@phenom.ffwll.local>
X-ClientProxiedBy: BN0PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:408:ec::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 281dd4e8-e5e5-460b-b4e7-08dd5827575c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Due+63O+KG77AejcKcr9edI0rcZAzXv5VKeBjiiHAXU38kJc7/1wo69r19uE?=
 =?us-ascii?Q?9Gvuqlkfp0j/Uw1kPR7lsZTm43fxkNHTdLIi2GQQDYQyCETcVacu4J2cf442?=
 =?us-ascii?Q?eTeJzO570mk43n/uDyfv47pYfexf0Vt3dla3lKK/brv3F5TqNtSnHdyQ5JUf?=
 =?us-ascii?Q?l4e+nY6j8gtWp0/MSsFHAwm+k2HS4TtP6FZUOit1WyvTxUoGii412om4l1Ln?=
 =?us-ascii?Q?3ZsQUgx61P6lxZYCoZxqWHLlyWRMSxe/GYcnqEsIV1U/YBUDpRvWOcI7GCiR?=
 =?us-ascii?Q?nxVZ8nHUfXbwOLUX9IzI8YbQLq9jix9mwsinUZ5CXNgDu46EN3vgmV2oLALI?=
 =?us-ascii?Q?153sQNRGGLXYvxVRXaeg5eUktUAP4yrfIbVRhLxdfpNCyJ/h5jArsXCWfSHe?=
 =?us-ascii?Q?azT7MPiawtiBXkaAS9Xu3s0/F3CBWUyB7xDuk25ok5qDvweO1u7Pma8zXXJW?=
 =?us-ascii?Q?WbLy0SxIMDNCc5cbb2ZpKFspQ7NRmeramNkpEFrWs6gUMTzxuW2XozbhKycU?=
 =?us-ascii?Q?sX/Ey3sg9uSoduF/ZGiLytn6yTjs5yrCoknxtJqD8+yWV3eJrCeuCt6YAeP1?=
 =?us-ascii?Q?VIPwqZRbmtexe8NT5T0K13FMOcsr//164je/jQB7jNXl1Lms3vKpUO+NEncl?=
 =?us-ascii?Q?JMsHHEvKXuLajTOt+wvniBZeve0jlhPmCN4Ywcf6geOFlo1PKuDuS7yqvKGc?=
 =?us-ascii?Q?6oYafQFEXieR/XfANQkGFQnW3neAiUwzBDgzdTgDSpaqtaZ9hIdF1VTsJEB1?=
 =?us-ascii?Q?vOrv5PzH7FF65+NhCS5guM2JQuJdntYQM56HDRhpHa9QfCNvxvZ+mnEfYwt0?=
 =?us-ascii?Q?5gRtqDmp9s2WhX4SKd2OG2t/YY8GvtPpmsW8WvliZU9RJk126dX+I9mEwvpG?=
 =?us-ascii?Q?QwjZoFlvHfzFSopHaIKuM78QQieax3EnJ1Nl8eTlS25f25N4MC30tENhqic7?=
 =?us-ascii?Q?oXCSoj0fMmnj6th+azYzAj5kWxjFBB5LZ9ZFqs9n+Qon94tLxsgfO41rIZRb?=
 =?us-ascii?Q?h3oeUeZ9Qi77Co7DVMaWNXfaoxSUtsupLv/djlXWV6isAn7Su5jmBi67oZho?=
 =?us-ascii?Q?0rZoYyAiC/NrInOXxw/siDSXmdtIWEHHydgIFm2UDQwqrc4Uzr7g7N6q1IGj?=
 =?us-ascii?Q?jQbexVZBv+rwas3SyfVTkJ7qE9P1xB3eqYx0irJTY/TuzgWgcmo6nhHeHCnC?=
 =?us-ascii?Q?WXlPyhmLZ2kLnHDV0pyNEJsqzDXFUAbYejmcRZ/F9jJHcjMJa1na587cPOye?=
 =?us-ascii?Q?ARAwXS+kJZRXoxAe/iCu9J7+qMOCq6U5Xj8p0upd9HoMFWzlUoU2HPBE5H4E?=
 =?us-ascii?Q?nvUgMpEt1ZZGlL/dx87VjoPkfUyofXJsOwLVjuFQKt/4J8KRjGi8nmtmCUL0?=
 =?us-ascii?Q?0H7viXuKzJnm1NqFN8cPZq/gga0munSarLN7uOe1rPZ50LPpAl9/v+iXwPD9?=
 =?us-ascii?Q?XMvdfWPZ23A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g4AXc5wtluoCyfSuBy6t2JT0finG/wa4eDjSWnd+UNAnz5qvV0TymUrYw9/M?=
 =?us-ascii?Q?ppC2I61W3v13Hm+7Z2Y7uhAv28SLOhGFAGv/u38pUrmVy2xbgzRPGUl4HBLX?=
 =?us-ascii?Q?uHZHIlZ/3QJVtFxWy5pM166I+t563so/Cm8X3/ZviKMkVAmubMjm02dNzqaC?=
 =?us-ascii?Q?46Srex9A+ZY6SOBIjORykDn62dmpmajBqYcZ8H2WlCj3Cod6yejTBijFJSG4?=
 =?us-ascii?Q?bqwp6lia9K+CyiN3oQHLa+MuiYiitGZuJR2HtAIbhXyoUwV8XHy9DcPJ2tUm?=
 =?us-ascii?Q?AzLlnbZZs6ZEZwEnQmk7rQSKNL5yA9SGHhcwsiToGzA302cacaNep/CZ99fe?=
 =?us-ascii?Q?hGLDvjG6RsElKXEr7TubJijLYNpdoubOOX+D85V+1YtXxk+jT+TVKk2F8mF6?=
 =?us-ascii?Q?d3LL68O9H0cpqNvO687ETc5tZwJIOMMZIyrjyeuMf87bS3S/y1nQoqj3FZhJ?=
 =?us-ascii?Q?NhMyfmbbg1UJAxy4pVq2OBYynDhkPz20Clg6moWBa0ngSSKOswIpvKFAoIET?=
 =?us-ascii?Q?vuxCCo/JVZjP2JBp4y3YmCl5Ls4Sta9u4SOACSUd0Lt0jyBCr0DktG4o7wQz?=
 =?us-ascii?Q?+WXFblX1XSB0vgNztFFx+/eeB47aS/mXH9KytLKhAE6QPbwV1rqysGaFEvFV?=
 =?us-ascii?Q?y2xret2E7dioAT2o0xULfZiXrGH+6SQ73D1/G64GMe+Ud3cVFbB8A6qn6+Yq?=
 =?us-ascii?Q?t+7zrkXJRBxS6uJ+hPkX1IXE1f+QyjVfejCMfGMuoOyDM+K8s85L8B9anNPM?=
 =?us-ascii?Q?My6fpK5YNBToNpTYyZHzuhJzCmj2nsbo3okgfoIsuc9eEwbpe5dEziYeY+0v?=
 =?us-ascii?Q?0ydMEuWfzoNbdy7CVBugYvW28cfvoukBO+CPn97NrXdqfOy88Igs2YJT/aV8?=
 =?us-ascii?Q?8JZfxOb6Z7idRHWr6IbOLWGAVmiyH3auW236q4sSe7hGoG5t4K1FWqggzCfR?=
 =?us-ascii?Q?IE2VU1J3+Tuz1OoMuCkICQiZXUhDAuZC8Y8/6L9yLQetVEXL/1eNRnjEyrKv?=
 =?us-ascii?Q?qxM0rq2phhpueX2znGEh/pl5nBEWxLCeYNOzP/TQSgXfW7mBUTJc3O56+zMC?=
 =?us-ascii?Q?WUnSHBBEKDVeNUaYGuseCsx7JdTlPudm8X49+KOQ+Y0gyYrFUyw2b87pDGOa?=
 =?us-ascii?Q?B7ddcl7hu+Qn4vi8M2ogLzDhBN6qE2wtY7oXbNEIlvA36YSdskqQYPwS84KN?=
 =?us-ascii?Q?icvWOOXogkwQ4owKrQ2cnE9xpG+HU614Zf8tH9WoBFgvfXeA20XIZWuroZzx?=
 =?us-ascii?Q?+nsxlY1atoQ+ZRkQTOb+vqKIN282oNtUVsxnCUwPtQ9wYofVQTPj686nMK2C?=
 =?us-ascii?Q?Dfe1o9MT/DlNu+XMQ53weRusDVDsypRIn4ivOH7kQVd25GFUiTJps01f1ct4?=
 =?us-ascii?Q?GwU0u7wlMRWAYTHYfreIngNv9m/WQjPPX4BGXiPojdtaGrIKsZf/2CzWm37D?=
 =?us-ascii?Q?Xrrdtwez1LfQc/AV9J90uOpFEv8T7W6kmKP+MRi6zZku4JVwCCisXO/QMNrA?=
 =?us-ascii?Q?c/PQCc9WpeiqdmRg0n+fYP4MyRyjw1JtMqc6Easg85bqgCPPD71XUayP06q+?=
 =?us-ascii?Q?6Akj/EBweX+uJhuu+luSEE7B7UvUcbkBl2TcBqV2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281dd4e8-e5e5-460b-b4e7-08dd5827575c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:40:15.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAbn1fH13ZefMjA+LdI3OSII7oWIlGk2cte8I0QfycbjCW34s/O5g8quShoYtzqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977

On Fri, Feb 28, 2025 at 11:52:57AM +0100, Simona Vetter wrote:

> - Nuke the driver binding manually through sysfs with the unbind files.
> - Nuke all userspace that might beholding files and other resources open.
> - At this point the module refcount should be zero and you can unload it.
> 
> Except developers really don't like the manual unbind step, and so we're
> missing try_module_get() in a bunch of places where it really should be.

IMHO they are not missing, we just have a general rule that if a
cleanup function, required to be called prior to module exit, revokes
any .text pointers then you don't need to hold the module refcount.

file_operations doesn't have such a cleanup function which is why it
takes the refcount.

hrtimer does have such a function which is why it doesn't take the
refcount.

> Now wrt why you can't just solve this all at the subsystem level and
> guarantee that after drm_dev_unplug no code is running in driver callbacks
> anymore:
> 
> In really, really simple subsystems like backlight this is doable. In drm
> with arbitrary ioctl this isn't, and you get to make a choice:

It is certainly doable, you list the right way to do it right below
and RDMA implements that successfully.

The subsytem owns all FDs and proxies all file_opertions to the driver
(after improving them :) and that is protected by a rwsem/SRCU that
is safe against the removal path setting all driver ops to NULL.

> - You wait until all driver code finishes, which could be never if there's
>   ioctl that wait for render to complete and don't handle hotunplug
>   correctly. This is a deadlock.

Meh. We waited for all FDs to close for along time. It isn't a
"deadlock" it is just a wait on userspace that extends to module
unload. Very undesirable yes, but not the end of the world, it can
resolve itself if userspace shutsdown.

But, IMHO, the subsystem and driver should shoot down the waits during
remove.

Your infinite waits are all interruptable right? :)

>   In my experience this is theorically possible, practically no one gets
>   this right and defacto means that actual hotunplug under load has a good
>   chance of just hanging forever. Which is why drm doesn't do this.

See, we didn't have this problem as we don't have infinite waits in
driver as part of the API. The API toward the driver is event driven..

I can understand that adding the shootdown logic all over the place
would be hard and you'd get it wrong.

But so is half removing the driver while it is doing *anything* and
trying to mitigate that with a different kind of hard to do locking
fix. *shrug*

>   This is why I like the rust Revocable so much, because it's a normal rcu
>   section, so disallows all sleeping. You might still deadlock on a busy
>   loop waiting for hw without having a timeout. But that's generally
>   fairly easy to spot, and good drivers have macros/helpers for this so
>   that there is always a timeout.

The Recovable version narrows the critical sections to very small
regions, but having critical sections at all is still, IMHO, hacky.

What you should ask Rust to solve for you is the infinite waits! That
is the root cause of your problem. Compiler enforces no waits with out
a revocation option on DRM callbacks!

Wouldn't that be much better??

>   drm_dev_unplug uses sleepable rcu for practicality reasons and so has a
>   much, much higher chance of deadlocks. Note that strictly speaking
>   drm_device should hold a module reference on the driver, but see above
>   for why we don't have that - developers prefer convenience over
>   correctness in this area.

Doesn't DRM have a module reference because the fops is in the driver
and the file core takes the driver module reference during
fops_get()/replace_fops() in drm_stub_open()? Or do I misunderstand
what that stub is for?

Like, I see a THIS_MODULE in driver->fops == amdgpu_driver_kms_fops ?

> We can and should definitely try to make this much better. I think we can
> get to full correctness wrt the first 3 lifetime things in rust. I'm not
> sure whether handling module unload/.text lifetime is worth the bother,
> it's probably only going to upset developers if we try. 

It hurts to read a suggestion we should ignore .text lifetime rules :(
DRM can be be like this, but please don't push that mess onto the rest
of the world in the common rust bindings or common rust design
patterns. Especially after places have invested alot to properly and
fully fix these problems without EAF bugs, infinite wait problems or
otherwise.

My suggestion is that new DRM rust drivers should have the file
operations isolation like RDMA does and a design goal to have
revocable sleeps. No EAF issue. You don't have to fix the whole DRM
subsystem to get here, just some fairly small work that only new rust
drivers would use. Start off on a good foot. <shrug>

Jason

