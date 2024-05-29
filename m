Return-Path: <linux-kernel+bounces-194212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246BA8D3874
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEDB1F27A35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D981D1BDCF;
	Wed, 29 May 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G6nq/Wsq"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410D91AAC4
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990871; cv=fail; b=lwhrS2JWpNm6U5+lqCfyMmSBItlynyI+fGmoMiq86RxVnzEEm6oLqcuDU2GSgzj2yMq1aZ8oRjn5lLpU97fwoHDQ276gK+IGPolutyhIjdBIsMBtcdx00afbe4qLOu2sy0QoBrAyl05ONINwMzzE4IK7GT/xIr9U2IWoCW+j9Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990871; c=relaxed/simple;
	bh=dLcb/m46f4mHFez7+qYJZ6owuALFJJCwldKrcprJfRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=THODz8lMO1ESOenC2RKiEQCtcolsaiQbHYicwRViJboHXeElKnBHONFeXHAF6KWeBGfMZbKHUl89/5XA0KBLUSo1ijOkTyPpFeaVts4WmT7btfF6tX8+jay9SXIN9/3avQWqjYMG5xctWiQzWhulHgza45ThorRk7Bo7oj22BzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G6nq/Wsq; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJyep9qJxDBbYZIdVEPios97m4yivUVI5zS+BpCs7kwg8PfFP0Lzw6lhciRzD37SALi7TSdE99PpUphdBYYiYn6GTlKdFxSHR1pbDgFRbDxIponriVpoblizR/iD0HoggSJbquAJQRoXVlMhIT9oTrVcvrNFACDzjBeJ6N7yBTBsKSzN09gaT9Ct6q9E6IN7ZZ6KEYhnszASh3REe27jcwtenlh9AQnilV5fPyhPhcbxGgiWWRGOEYvnVFQCqSgQwtA4BYjDIa3wGNetOtjn/aPgpzgyp45uf/QoEbtN2vUwzt+syoKRHdwX5y7jIkY62vLfFshHMw+KIVHTBeSR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxFUVLsWAaEskTBzKKHY1nywwnuiYdLW21f/ORgFrr0=;
 b=EPLBz24Vcf+OF+69Yp/OY4HkIYAayn1yvo0QcvAvnajh6MAlpOtt1NwS67MTW2/CLl5tPpFyfAKUrsDGPmb8K5D5rrqfaPh0C5HzS7fs/BFGmJ8qiomkfo3yUAYcBCagpGzKDRKA+y63L7kmaA0UjQAwGYfcbHxUDlsNqhIVkOjZ4INTKKGgy1h25TtfLvvzwE6GuVK4m25sZ1Sjz8u9+OOfuiCMKRYu41ODk60T2ekOCsSk8BaBitDpvjt8JiU3Ixzcm4ENY1xx2i4BWuaiKNle92ooLc5XMZRmKJm0qorMPLWuUOmc9aTQ+8JxN6N0S1gHFH8vvelxX/vaBZU3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxFUVLsWAaEskTBzKKHY1nywwnuiYdLW21f/ORgFrr0=;
 b=G6nq/WsqbLF9Z6dcJIVENl3CRsIHjbVp1Bna1a9ywO0B6ZZMFnZkXu0M4rSPwxRb3/7Vaa7omqFzPR/dpexor316tiRUDH1GqNlZGSXN0a7VsavAqft4VSi7rUUkxj/jCyGJ0nZ+r+mz9VVoqrQUvgGBrsuHF2+J5/BCCBu708w=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31; Wed, 29 May
 2024 13:54:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 13:54:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>
CC: Evan Quan <quanliangl@hotmail.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] MAINTAINERS: update email for Evan Quan
Thread-Topic: [PATCH] MAINTAINERS: update email for Evan Quan
Thread-Index: AQHascuLV49pwrA7CkO/aF72jGzTg7GuO1WQ
Date: Wed, 29 May 2024 13:54:25 +0000
Message-ID:
 <BL1PR12MB51449A1977FA06BACE4FF306F7F22@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240529114621.11795-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240529114621.11795-2-wsa+renesas@sang-engineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=bd98857b-6104-4cb0-b492-3e5926516051;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-29T13:52:57Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB7020:EE_
x-ms-office365-filtering-correlation-id: 42bcdee2-f65a-450e-da6f-08dc7fe6da03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g52COfK4L3awr0n4bf9DozWzgP9D+8YrH0lZ94D04G17nWbIIuCUOLM36Nbw?=
 =?us-ascii?Q?E0mYsOHSDtOp9QBoirK2WQ1lzZB7kKZXpVkzYUjDvfpfMrSpUjvcHroaflz1?=
 =?us-ascii?Q?QoIL3CsOAnkzxa0TstXJ76cGubjmv3czsRekhROgZyYqK8hgG3D3df6QTLdh?=
 =?us-ascii?Q?NMATXaVdgdO9Wofd0OsUP+1PUgq7UHBZo8TBdQ/e7bCIKQq+pl7+X82SyXkx?=
 =?us-ascii?Q?xoXaY7ZY5BJY6gapCcsV8u/KLs5U5JmJukMB0cq04tgdHrBr/wt8P6K2nXHH?=
 =?us-ascii?Q?mD+dDQNLTYmDLZ34v9czTaeB/22feBMSTbEXW+1mD6pmHKO43N/eR4Njn1zj?=
 =?us-ascii?Q?NAEbbTpJH59eoK1fW+GMoB69DGBgBszI60mWZSZF2co99askcLpCk3gucqkx?=
 =?us-ascii?Q?fBgilIQ7Q3Wprvs2zAjPCHrajo5srCu9h1//pDLi8xbuBenPIisf/XS7npgL?=
 =?us-ascii?Q?BaODUo0G5Ok3f8rO1lXNBI6tDsxdcw5NsqQ8damEap0IDi7a3uxEOXuUiqHG?=
 =?us-ascii?Q?dLEQ1hriaVSksjQe8YJT7c8gJFrWJrr9Z5IQFejl44g6axpZ0RfLOfa9v4TG?=
 =?us-ascii?Q?NjLELPXpFxASlL4nn3HquMT0ONFhOx1QnY2HBWG7E4E2En3TnN8RvZCMtryT?=
 =?us-ascii?Q?mWE5JBBDhrtIYi20/0384+CoXR4mQ5RB4KBhJvy7oeEGtxdX936wWfrN7EUj?=
 =?us-ascii?Q?O0g2hc9yIC8v6KsqHrD+xpNuf4RvR1PmXyPSf/5JTzh8YgJgjlctHqJCHDbQ?=
 =?us-ascii?Q?0F9sBZq2rUc+KA6dHO67ulF9u0OdrpZ/LV5b8mPir46b6HErtVGSWRgvH0ps?=
 =?us-ascii?Q?kG5hk6FoUFbohjrr4MopRO0t+l9gT79n3lbagTws791yU2w8lWdgEHKeA+SW?=
 =?us-ascii?Q?D7KcpX7HIGIBwesMABlIZ0kieGNAEzbyP2yLMoDhdaqmqxUT9KoBt7wEh/Wt?=
 =?us-ascii?Q?mmIaI7dmZ65r3dKLOAmyGhMJCIqQEJyXJ5DL1nVmY8GeLGh8zvVc8p3lb/TI?=
 =?us-ascii?Q?PY8JskfzrmDTrIL3Yo/LDgKTFnY/4VpOkDST1kvFb0M9jQS4IhGK9t2I0oxh?=
 =?us-ascii?Q?tDe/R9LNKLNnoasWSGW0NrFxNj71OkAcYqdb8L0tV9B+cTOiX1Ew6M+fC1bc?=
 =?us-ascii?Q?QNg5OgPFH7KsLLupQXCzHfIeihU1z6gOq5yDyt+iVJMUqRewPrOCmC1yDpZ3?=
 =?us-ascii?Q?HzmDAHqeaPBVg+Q6+wbCmHq4p98gMnX3Tw23DTx1/PQo6RFBi8kS+9xsBpII?=
 =?us-ascii?Q?fTTr1+1ObLyJlelJL2DxP1o7E15sutK/z6LOGITqDw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zcdhCUxjtNtgsirgDhGR/lkrWfhGI0cBN9i1jKoF34zg1KskFVf3+cZTmXka?=
 =?us-ascii?Q?kUJcApo+CKCOD9cjXYIEgdWVZGhQD/OC5avQWsy729gzA4OjAwspoQRm5YUc?=
 =?us-ascii?Q?rV45GiDRWOhcw4OJ1UzK7JhuQisEclfvJLlFMod4Zm/tXEJZZQwXQv+SNujA?=
 =?us-ascii?Q?Oyx5GKKCOYcrx1CRiWR3nZB/D3aeU4cMOfSszOpaRHsvBKeZnorkMhU05wSe?=
 =?us-ascii?Q?DqWvhFMuuuiVfYXfRomqAEW1QMgl4Xf/ZNt6t2tBIERTc/bpsiNQnWo1r4El?=
 =?us-ascii?Q?UDswh85qgQyKIMp293Q5pC+nyiEPQwzuqk5tDwNSQZWEGg0Gn2g8lHMCsT1v?=
 =?us-ascii?Q?UBXxg2FzfxkDeUEVt7ObiZDyYgWqo4Jrpyzet2owQ08Pk1hxOY1OWXjPRBtn?=
 =?us-ascii?Q?4WL2ANBIcIwQC1GVqCgnpxaR2fYEbeuIVsw3MzT5smxjAI1Ln8EG9MJIL3vi?=
 =?us-ascii?Q?lZW66i0jMG81UWJsHjOooRvuh5cwlSwmGNVRyBT0Wl7iC686UiF3Mq2SEEka?=
 =?us-ascii?Q?tFJeodWQ7C+RxxRWtQz9sK3o+VYb5B7oUcYFk4pZ2rb1Ivbd4m+wH9HKJMAP?=
 =?us-ascii?Q?TPstbsOG5BytvAnmLCGa6oGG9dei8pz6Z7/63Ij6dFwZa7ceBWarCNte1nDN?=
 =?us-ascii?Q?MOwu/piEt/dEA4v+AthF6WaHKEhrg1HATFKBZFnTH1fIYdYTsqvrlfh8wC/e?=
 =?us-ascii?Q?61OCYv7xeUv7KEQyQOGwbydEskaW44vvVh7gYOnmtRjbosuy/J31GPFKdTB1?=
 =?us-ascii?Q?XP63mZ0q7ySFL4qPfVIvCZSHsBzFoyzXtbteQ0cOTRwffiuRNyGTpkUy3CR9?=
 =?us-ascii?Q?ibCqp4ziDD5AOaqAEAf3VgknEu450RjkOsGSDRYcO1UZloPmFNuOgLBlQyuu?=
 =?us-ascii?Q?iD7Kh/zWBQADWMEMxv2qDMhMoLjbJrO4tFGLtxrzxa/4DfCJH87LhRhgKhjI?=
 =?us-ascii?Q?e3YZm9D++ovtAaXUaX5fgpfVsW21eVfhpc5jDcLyfRozSZ3OZNsw42Hj5KhQ?=
 =?us-ascii?Q?eZkg2hWYTF+UH5x9LajHjVBmZKOur0q/beuaQUM3leTYmCNlCRU5cgX3Mi4h?=
 =?us-ascii?Q?B7v80yHsijPEM5KrPn0muJZSY+hmfZUDnU2dMco+lfDBc7GfUETcn4PZDN1f?=
 =?us-ascii?Q?90VjhuG0xC8DCL5me5RqzxwSfSbP/D9MY9lYkZCC6lKc6DxwMFlWmQmb4iQh?=
 =?us-ascii?Q?y1LjMimPs/7h1jCDVTFmUnmr49cCoaZu9rs8+yRnjFNRnEQAb0Evzpikl7Jw?=
 =?us-ascii?Q?LXRuPSst4eKZ1ZaSYNLq9DU1iy20586DIAwFwNPh5lmVZAcyNvfKwnFPovHP?=
 =?us-ascii?Q?yTlzcyNtnPr5nYIYO5/M7sbK9JxglNpVUDYnH/5U6Vb7d3bohlUx70qlrCJl?=
 =?us-ascii?Q?ss988W4YxZ32VLM/ImF+3/3KxbykoEa5Z0kPiH0Lro+RCMITozmvnaF3ihM9?=
 =?us-ascii?Q?/rXjzccrCPYlctwpS222hKHMeoKB6PJcxztwG92qn/BZPEXX4UdOGq/u1ykF?=
 =?us-ascii?Q?VltK6pvjYGEsklupeoC/RvC4T/YF4sedWGkPKZ6zXBtZv8Rr4V6QVB2Veblg?=
 =?us-ascii?Q?2rXq76VmR7HY7zd4dE0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bcdee2-f65a-450e-da6f-08dc7fe6da03
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 13:54:25.6265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTAj9BtDOFepZBguNBkIWwnRs2Ik5AwRy07uWd97T73B12tETJ8S2L/kVYoZldofPO+4S+IPopil4SNIUm1Jxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Wolfram Sang
> Sent: Wednesday, May 29, 2024 7:46 AM
> To: linux-kernel@vger.kernel.org
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>; Evan Quan
> <quanliangl@hotmail.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH] MAINTAINERS: update email for Evan Quan
>
> The old email address bounced. I found the newer one in recent git histor=
y,
> update MAINTAINERS accordingly.
>
> Cc: Evan Quan <quanliangl@hotmail.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Evan no longer maintains the SWSMU code, it should be changed to Kenneth an=
d Jun (CCed).

Thanks!

Alex

> ---
>
> Against v6.10-rc1. Still needs ack from Evan Quan
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..b2fd2a19277e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1092,7 +1092,7 @@ F:      Documentation/ABI/testing/sysfs-amd-pmf
>  F:   drivers/platform/x86/amd/pmf/
>
>  AMD POWERPLAY AND SWSMU
> -M:   Evan Quan <evan.quan@amd.com>
> +M:   Evan Quan <quanliangl@hotmail.com>
>  L:   amd-gfx@lists.freedesktop.org
>  S:   Supported
>  T:   git https://gitlab.freedesktop.org/agd5f/linux.git
> --
> 2.43.0


