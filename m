Return-Path: <linux-kernel+bounces-243418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A019F9295F7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EC5B2156C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4B45BF3;
	Sat,  6 Jul 2024 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dMG+m0CN"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2087.outbound.protection.outlook.com [40.92.18.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982B2AD39;
	Sat,  6 Jul 2024 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720308898; cv=fail; b=bM3v/TDt7qAl/+F79yBGTZd1wDLrgocTsGIQxZP7jh7XIRTysqxAftOdhQYfphRCuVIFmQ5NZ1J8aO6DCCjheH+xbPE+qfRUpbK9uYlDNNGAE3EJjjhcFdG2kIH9kVIE8wquSITADAcRXoS4gyql4/XAFE+QVSd+52SGeuHELmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720308898; c=relaxed/simple;
	bh=8zNcLGBTCnsoMFHmJjFtCrKBC0PsOpf8P05Az4bcIoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NMCjwIltIowVC4rDn72dEjqyy/Byjf6A3wsJDKgB8zApzeQQZuMNcwkOriASRO72UnFoihbtZyJI8HOfgYPoXr9JimNMaKpUNWU2BTtsIxI/UW02wZI5g0rwYE9DFNO45tyBkweQ9d82eHgJRGrgPsW3gPNr4GyVBOk3sDovnWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dMG+m0CN; arc=fail smtp.client-ip=40.92.18.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiPQMabcKVcy0/SwYqkuiIWjwblFbmtO9IqiW6+NGNPNPmJNgDlidC84roggw18AA2tegaTbcKhYpfaEPd968LA1I4pWbPoZ6CGF0qWaFimOam7lOu/4GRfkHKWBlrvuF7zGbFsYzNioDoSt+H0bnlhBA+rLOUWImckfLk4IRVgMLoTxwLuoovvEZF9HBYhbiycZeS8DTrWHK2AuMZkaVAg5HtlysRGR+qjt9BZxGlrASou6O4nz8f5BAA8pEfqQnyxx2nCdE3Ki3ytHCn5qLE3GNgLVQ4kj2fn7DvZPEcYN0o5fcjrRI5b4Zq8qslW3R2/A1W3iNCZ5s1tK889lnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJrjAOoC/ScX7Z5gRWPDjkUOhJBqRRq1Bga/D5XGQmc=;
 b=IQRazR/+tdzfV0GCyf+Qr+yTyupHJXJ6ZSF3ABLGE3cipZcLDNS9AxRQ5jXrbRqdDru4rwgGrNyT6pj4BRhjSBSEqMBg+C8LqQXEcO1csW8ibvaH7xibHOgKws86+Vy/M4rFisdOI9Dx41HkZRYj0uo+FbnV/Ryy5J+kBdAxg6T5cjUn1cemGtIKaDlPo0aT7DAfdywkbHOGPOVLMVGFwQdb0hs3bcWHd5tb5730E89wOsrVzmRV0qJi506aGI9nX/gZhAl3b5HRYofXTcQNLfZz5UK2V9+IAtWhRd805A0oFRPgq0GfgcI0gkMn4XLTmNDPoO3nElckSc8DI4tdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJrjAOoC/ScX7Z5gRWPDjkUOhJBqRRq1Bga/D5XGQmc=;
 b=dMG+m0CNIw2WxbDom8wD8CkIgPomwUFJubi0ixW/tzQ/R/Eg1vLDHd+MUoz75ihvsri0eKLb6+ParSpoQG+AcVEz73cu7PkFtuXeVQ8ZLuc5DGAu5l5WpD4eVtTdKDIW9jUtxl3nU/pKzvk081pfFw0IXqtGXi4Je+BlTpXLfA66RL4ty9C+4oMqIVRigqTEjnYn+4AAR86oHu2Uoksec3sw3XS0DXJjL/0406FPIRA9pSFh9ps0UYBStM3I6s7QX5u1XltkCclgn5/YGIEq1FYYKk/0gGhfLjqIqD9ytFIUvg888daAZTGVw7CilIl2y1NtcftWaJYtKVPNr1SQoA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5394.namprd20.prod.outlook.com (2603:10b6:510:1ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Sat, 6 Jul
 2024 23:34:53 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7741.017; Sat, 6 Jul 2024
 23:34:52 +0000
Date: Sun, 7 Jul 2024 07:34:15 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB49539E946C2D5D025932ABEEBBD82@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F58B631D836F3863115ABBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <5a2e23f4-d54a-45ae-a09d-e557b110e017@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2e23f4-d54a-45ae-a09d-e557b110e017@roeck-us.net>
X-TMN: [zp/B3sBqUNBpSq93FAIVPPpkwEPE+omn6gIHEWoW7mE=]
X-ClientProxiedBy: PS2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:300:41::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <dd5nfysjvazvhcacpjivcltwuksratkrsn7ljmcr7jzjbppekd@o53f5hyby3z5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb9e203-f509-446c-d090-08dc9e143bd6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|1602099012|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	IxHPt89lN9Wi/jFcoGVg9ICYjB+K0vh6vKc3Skqc+J0wDUQqAJbWllUEeBZgeMc80yFTankDJGucouRKAoo6CUU9dgXosqX7gQctiT0LMO+28rn04yT7m+VRBPsgvBh2CoEeD38Xdz7NlPimIKT+o00DvV6QxBhol501KDvXieyR9RVyqgyYTebPVUBlN58FDxp9FLDT9MFmkhbSLN+DDYGdJ/gvUgWDdi/wshbSFqgUgeS/cs2XIH7M762aJpNkNKcS2aALUCevJDTZxvPK51OwXoZZ/Gxq5Ks29Zs+Xdxhn9F9nK9LT8DXs4TeSw9Gpn5rdUHAkeFoPqTS7AzGUeouBwv6etRVSwPsLwVDfLQpNaUCQqbJr0720G9WpPdmAPynSfbyq7Q1qq0Q0V9Bn8tl+q25X6gmdQ+L0BJkQpBAthfZoRonVczcKKHrFgSZ7VYES/lsrX+GCIC8zLOu7DQNtea8zJb1/W0Hug49K3kYhIih9QifCRNKmJrdKrauFf74/PMtPEOfQC974B1Vyfan4eUQw9nPV0IA/+iyyCT8YW/DW9WSUXbKZ6uA5U76cKBf1sJJug3k7qoH7wYtfQKJMMMwlDVUyx59MQsLtqakhsuyyExg+0Zf/KL3j83NMhh4p6vuOJou0nTxgg6nmMsttybiYPiDT70N+n7hYiznkRHq5I1iN9uNNFsmkbmDhJx0DPjBuG9k0OkRpzxDt5Hta28rIXjT64gsYjgQnRHRnzR+np259U6qeuBRj52a8Rin3u0IqDrvGuknvlBEaxotpwplRuUUka9ncrAtpYA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ZBukuE9BDSdIZhgWhDrkEzZIZTvlAKBbVVZKvH+CMN+dHoFToWIUqZmW9+w?=
 =?us-ascii?Q?ZQc937YfXWPcMPPVWA0At0vqNxA4J1lGubMeYflzbMPCyE3HVkLKAvXhNgvz?=
 =?us-ascii?Q?2+77WSIn91q3AWaDWHQqnOHqIG1/67nykMiiXfGPXjNzHbjLfrmpP1OV7YSs?=
 =?us-ascii?Q?ufDWtauDp4iCFNq0prC1bWvvNVCxONRv09Lb+paHSkPeRVM6IeFsyQj/CfZc?=
 =?us-ascii?Q?gsBBLKW8WedewHeNAeE5qODPW2WZPzgydBwqHKECMTi1oh7wh2iPFwRPazvZ?=
 =?us-ascii?Q?+YTUrdLMktPSRtDYBkwbW6Iilb/wGsAHi1HKZcslV4Xhelt8L3BtDJHKYdOu?=
 =?us-ascii?Q?LfnTaTRD5RU1U6NiIBEUpzvj7MqCBkZJdV/Vp9vHxnD2niOxCunfZmy9CXyO?=
 =?us-ascii?Q?Rx1Ql9kEmD+RyW/OgreImnX44x8SYXX/fBORmQTElpw6+5Xt1IxN2YS/4MqF?=
 =?us-ascii?Q?51HTlemWpinNkVG4N9Nwsd6+pPOcXRXGezbJ54Xk0hXNzobieWwfEP1lb00u?=
 =?us-ascii?Q?KOcPDPKY3WV3iJbNyD7M+z5b2OEr1qFmtjzhePURyyQQY/386xDTEtM+IkVO?=
 =?us-ascii?Q?cg4MXtCG4ftps9Xufyqj1krBsB/JEzP4sBdO/8cXYlvDRw+ibM9nyr0WG60M?=
 =?us-ascii?Q?Ay3jF2pqFQXNizX3raeseer1z9W/oZbh8I+NMQE3UC5lfpo0H/yr6TYudcBm?=
 =?us-ascii?Q?qzpw+YifO7LcfooLFdF0PkWptqtqr526bQzHICgto2iXloE/OGpG3NkvuJPU?=
 =?us-ascii?Q?tMgUDMDnjm993w+NVcnJy9Ddq9WiYl0N6qTpg4oETqj+VJL/VEQNRzFrPN6Y?=
 =?us-ascii?Q?u9KvvbcGLaVTKcR4Z83MmNdHr8r8/S/3EzNXYcgIwGJEzTrO5YviWZ5TQ35x?=
 =?us-ascii?Q?5AMutSLP/yioMd0JLnAEFLltEGSq8VH1nR2oHoiUd/icnSj5phAo/AvSY+Vv?=
 =?us-ascii?Q?f7i42SltOFN3QjUKTETbwl0hlG+EOH10bQmoIxKz9PkkM3oCQMMyOwnSjqEj?=
 =?us-ascii?Q?Q9+FUpKBniAb02+skgKox2n5O4ylEN+Lg2elTpzGzl8amNgDASglF1GV6TIv?=
 =?us-ascii?Q?iQcmliuq0G4S/RiYf6Nuwgr22uOef9CtzhIDfH9D+7oMLl7LXKAgHHeotzSY?=
 =?us-ascii?Q?6VP3Yvp5dNy9ceAGiv+yJSw/mFzG9c6+FIHc9liZ5+xEgfAHQdhJzwzy2jQi?=
 =?us-ascii?Q?cg0oenSur72DEhNzo0soNtXjeY6FcBXifIncHN7P+g14JhjqQ4Vv0rPehtp9?=
 =?us-ascii?Q?JWemOgRaqrwbwNa4kDXX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb9e203-f509-446c-d090-08dc9e143bd6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2024 23:34:52.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5394

On Sat, Jul 06, 2024 at 09:48:58AM GMT, Guenter Roeck wrote:
> On Wed, Jul 03, 2024 at 10:30:43AM +0800, Inochi Amaoto wrote:
> > Due to the design, Sophgo SG2042 use an external MCU to provide
> > hardware information, thermal information and reset control.
> > 
> > Add bindings for this monitor device.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> > 
> > --
> > 2.45.2
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> > new file mode 100644
> > index 000000000000..f0667ac41d75
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo SG2042 onboard MCU support
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,sg2042-hwmon-mcu
> 
> According to the other patch, this actually covers four
> distinct models/devices.
> 
> static const struct sg2042_mcu_board_data sg2042_boards_data[] = {
> > +	{
> > +		.id = 0x80,
> > +		.name = "SG2042 evb x8",
> > +	},
> > +	{
> > +		.id = 0x81,
> > +		.name = "SG2042R evb",
> > +	},
> > +	{
> > +		.id = 0x83,
> > +		.name = "SG2042 evb x4",
> > +	},
> > +	{
> > +		.id = 0x90,
> > +		.name = "Milk-V Pioneer",
> > +	},
> > +};
> > +
> 
> Is it really appropriate to use a single compatible property for all of those ?
> 
> Guenter

These board can only be detected at running time (even this should on
a specific board). On real world, it can only sees a MCU onboard.
I don't think it is a good idea to add some bindings to cover these
model. It seems better to remove this array and let userspace to parse
these ids.

Regards,
Inochi

