Return-Path: <linux-kernel+bounces-304230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83FB961C39
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B511C22DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884776034;
	Wed, 28 Aug 2024 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FOo6j8GY"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13891F5FF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813048; cv=fail; b=f67xbbv/8/fCoIK7lBxP1YZL+8UCw3mq5nHOb9O9flMzKr2iwixj08bCSE4uldH6btPofYavu8NP7UYypsBPJqpfUp2Wkie5WvOptwM6aaTiQR0lN9u7EAl8P5G2Me1Mo6XeXPD3xakoi9fpvyk7W3+57WdV93mSUoNdx1Gyk+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813048; c=relaxed/simple;
	bh=ivK5Zl7QoOfxBAnKdcDgwteo6/bHFB1ZSLwJq1MinnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jEtjEL2zzXdxF5RBbwxD81teut6XlAZWDxRsmhBu0+03VfHhBs9QkwqMzmeotpQQXIsQQUMBCTp2FGcTnTxEeNUDNazUyLnDa6MsmRPdRbXHFQfr5k/3fiGdCAUo365KbLzYCtkeCmTzJHRJVldPCMc0uTyFi8ZQHQFb7vuspiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FOo6j8GY; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEvgxouLR0XnUaTyhzIh+Biy4I0M0kn7s0cvncvR2eBlT7zlAqDmGFlwJXxU9qiLfqiXl0jvql0gvINJGdswlpoBZ5sxj0B+AfovRcGdmZQDWkXNxHENnf53Q0mhxSBqlqhOTySv1rNEpw9kPvw+W7lOLm/CZgPywgAiMNXaAX7TC05wbv01RQdEL9JW55cDjW1yNQ224530N3H8V3oNthbRLDJd+84V2Fj5X/8qzgvXZKohRIu2Ktqo0lSY8owjX0w6Nn6oDCUk4XxlKUTZYfqnuPQziQ8CiOc3BUTiQS5a3EhnVtdyGahPKbYYmXE4pfS2WVQxSk583+5jXtLHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIsognfvdI+S6bVS6snERZ2WFyHHwFERAE3cX6ilidc=;
 b=auDugSJMh+R38p0oitTRLpwbef+E0sgFptzgO2bP3SZ8QtSsRwuAhFHp5ryEgwAmX32WQu8iz03HTsEVzD3kiD0eJ5CLXBD4xMreAdrbo7iW6Wz/IQY9v3DeMcASjU7GOOglvWSEu0Pgfsn05oOekYbgukoB/xH5ffmHiBHgAh2Jo5OwwVduX3SePpnRgDpTU2nrOKSkl7m8ZVQq2cFT7vSKHYiedMs+pC0OYEMQBA1VjICchl7pFDEF6TdVm0D6nA4B0iIw7Lh75GhbzEgRCb2vi9/yJMTybR97qtGjXuL0geKmcCnUECLBW92sSTcaeLZCwoFfe842tERAIQIojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIsognfvdI+S6bVS6snERZ2WFyHHwFERAE3cX6ilidc=;
 b=FOo6j8GYOLwIQtSO8D6ee/o9iiYQbZL3a63XNyhH7i00Eaj7f08hpG2/TQIj93RhRzIq6ePMm0MAHCLkFgvwW5SHscntFjUj5Ne14qIlvz3z0743Lw/2pG5Gh/lczyNEOsFYmeEdmPGFNMLlL5xRS7v+e55XoQNLXmgfH6E7nKu4JdsNpgPMkOH8oYRmH4wGGJmem8OWJDi7bihtiWp/ckDANt2Zk+SJsvm7ixxtSoMtSPtOcxMdwlDtBn07/CMcCMbfLeQ8rm767F4KAIbygC06uMhTVhTabIVBisUEPRKY1oxGi8dmAdIXxIZABi0rvzUCJqSVFX/rYv6XhgLZeg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7856.eurprd04.prod.outlook.com (2603:10a6:102:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 02:44:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 02:44:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Feng Tang <feng.tang@intel.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "nicolas.bouchinet@clip-os.org" <nicolas.bouchinet@clip-os.org>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "vbabka@suse.cz"
	<vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"open list:SLAB ALLOCATOR" <linux-mm@kvack.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1] mm, slub: avoid zeroing kmalloc redzone
Thread-Topic: [PATCH V1] mm, slub: avoid zeroing kmalloc redzone
Thread-Index: AQHa9SPdEQxIue98MkeZxIMfiUY2nbI39J6AgAQEQWA=
Date: Wed, 28 Aug 2024 02:43:58 +0000
Message-ID:
 <PAXPR04MB8459FAA6D4E1BB8A1BD1841488952@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240823062415.3632189-1-peng.fan@oss.nxp.com>
 <ZsssFS68lfFR2yJU@feng-clx.sh.intel.com>
In-Reply-To: <ZsssFS68lfFR2yJU@feng-clx.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7856:EE_
x-ms-office365-filtering-correlation-id: ec3799a0-e315-48d1-a479-08dcc70b44c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6EoxSIqAvU28vNxUwfwzLrRHWBZX1kOBkil7pWHgmqsUTUetSaroKnSI3ATR?=
 =?us-ascii?Q?A6xHQ4GfkXmYyetA5O8jv/42pBJjtU1YFpG0BJrAc0fmh+lyaMjdxvwjlNnh?=
 =?us-ascii?Q?+oljenkrxOtlFtgv3bSYXtvGXmYaoy5I3/Agp+iKvQegh252nig/1kHcOKdg?=
 =?us-ascii?Q?lIe7cR7WD5QFAvJQUaTSSMohs8BtK3UiuJP3ivO56Gy2mHf0AYmjQuKJWklz?=
 =?us-ascii?Q?DcpZR9QF+qQdeLU3tr3B1Z7Hz5QvmNSGeJ73Ug4jGmvFDIaQB22eO/v7Rn7W?=
 =?us-ascii?Q?mwl7Km1J2dnNLyVu6zu8uO88nU29e7U0VS4VNRK7y+juJQHuO+4kIBTEPJEV?=
 =?us-ascii?Q?M4lRCSX5DdODZYiFrSsAHkp2VBRNUb4Vg2CstxTCWNdRX/ej2tsqRK9cKvLa?=
 =?us-ascii?Q?WQKEXvOEINvbRZpaei+2aM6jK9r2kqiE0Y5lMt0bspA8nBCkxL9wJNKw8Jzm?=
 =?us-ascii?Q?IOX4FikKCSEV5I5utW3D/DrJomSOvzvk8XYhAztkaXk0D5dhTqSGCWoGrvK5?=
 =?us-ascii?Q?ZQ/1b8Z70BQfwrbFqxH4TMJDlWP5TiDutTbiAv3jbRnjheZEglqfiNaPnYFl?=
 =?us-ascii?Q?q7K3ev0hS7ufbmcHTjD2lBja6KKWPq6Vquu8LEsJMbRZPjqjWdYJ/Di+ZYpf?=
 =?us-ascii?Q?D//TZUMC00ptZNiozdQIhsqZeMNohwuGx1hgqQFnH1q/f85SG5qXGX8lAvdr?=
 =?us-ascii?Q?B0r7QztmCGD1rKAgvRr2YbGWTGXd6RT3On8p++VPD2E1sHay2tDjcKYH3BsA?=
 =?us-ascii?Q?xDSn5/JhvX+9XzP6xKowsizXz3jmhK2RBEc4woOxEB1OCZgjd+j1vq/cv7Ow?=
 =?us-ascii?Q?oKakaUrCklUaEFIjr3a42c7+3NWZkp2OO76pIQBTMUppwnwzMZZkn+31njlj?=
 =?us-ascii?Q?IDMcwRccXgEZN/jwRhlluV8mkBO9CBoLpAnmzr1nhQWCzQX6hSuKxPqrKnY/?=
 =?us-ascii?Q?BtbvQr6sdu7c/4Mwft9YyApgNEe7pyLasAbCUeYT+lHD1n78GKDJ8nJPD3wu?=
 =?us-ascii?Q?+9G1DVtLTejMHa/YEH9GSiM8qklK0ufAtZoqtuSy3XQUI0KY889CyBrRHYJN?=
 =?us-ascii?Q?UpE3NARBc/3Ub0jlC3Kmw6poOuAPqnrGYgibg3Txy1uBU00m76aB28cGW2Ec?=
 =?us-ascii?Q?migRF1/SkhLwNC3R88C9uSL1pWT5bsrbGdg6br9GoNaBOE2rkYxRDQ4QfM+p?=
 =?us-ascii?Q?dbhj6zMnvkP2awQJ1hxiKdh4xBR4GuAHkXMcNviH79CqJfFs+3xMru/BVuaR?=
 =?us-ascii?Q?9sn7RoSxi4AFAmljmK8NXIn49RTcD9/JVhb9JsitwsU51AOEtE108Gt92o3E?=
 =?us-ascii?Q?lZ1yi52qhlwb0va/2RRwoWjKTeowWSVtU7Nxo17ucs5CtsW5L0TD6IiU9cuW?=
 =?us-ascii?Q?z1Zms3dSfWFdg3h8nG1bvExWnp10xwAwRXpIjyWuPrS2CzySNg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bRzIuzbadBCG9yot1zGdBwWzq6+zhQ+Xlqyl549r9H7bXD+X4jmlAww23gEb?=
 =?us-ascii?Q?FdXukkC4LUJ+ch/Z5H0EL4fxjozq3Id7q+kgL4RG/eXm3ClbD7oOWLPHfI4f?=
 =?us-ascii?Q?EJzDl/bGkxsJTx5vbXfTFhFgcQkoVB4eaWQu1vHL4KAhqgb3dTzXzgIRzuz7?=
 =?us-ascii?Q?2L3HLKe1/NvJ9f1GeA0rtelc+REevSXCBstfF5YiFz47ba6zYRQvt9F5Q0Cp?=
 =?us-ascii?Q?iUOqfIMz88yf+jybGxLsVC1qE42ZIRajsMWk8u880ID8fZ59qL7oCzaaPAUP?=
 =?us-ascii?Q?JRBAVuDSlLMwkjjaOONpBcdW0hsKkNRSI7VrFWzQdqKgV47hpzz2MZHey7qA?=
 =?us-ascii?Q?oYsqwd6Kd8iGhlJ451+q/8M+1tIoq0f0D4eJljoJ0kuIrZ3j437z3f8yhzel?=
 =?us-ascii?Q?ShNzbNfm+vEbDDV0TNmxMtX5Scg/IzO3Ja58yFX17rP3apR69J+29+tPJdd3?=
 =?us-ascii?Q?kWB5bp+fcaLPRWXXzpizBk93KDTGvlyc/ufN/kSioVI+zOMHgsG4byJrWY/v?=
 =?us-ascii?Q?FZbzmdJjwwlf7mHsd9YUYLZuIqJZRROIufuXHJ1m/GZYCrtJRUTvUTruEx/z?=
 =?us-ascii?Q?ANsLwYrocp/DfS41efFQYsR/D1UX5Tpijk2H9134ksUp4WbOdJ2ZaySNty0c?=
 =?us-ascii?Q?LsvENko+P6v0/FPc2o20jRBelnut2FqFLoRcbkXty34E/efLYSK5yo4VrWcf?=
 =?us-ascii?Q?6RdeJZ5RmEU8ASWrJDcdeT8DKYqANgG1549sZeB1Dx0D2sKsGdwuXJcY8kZa?=
 =?us-ascii?Q?j0hHVxOIrasgvDr87Ix97ynXI+zZkGA/QVUcPIBvVAVRPk34QRAtZFbYkz/e?=
 =?us-ascii?Q?Y0FVRN1iKrZsUmSosFkXpEfrnf3WNJby+v8iRCm+p1yiJgV0GY40/ttXAJN5?=
 =?us-ascii?Q?+XZHXl2r+c5MiVA1c+x2uubhavnWOYNhWAZ2sEY37FQzyJAm9qlWQwWw0j4n?=
 =?us-ascii?Q?qMi1WDd6hjCw0hk5fMHzgaCZxprw7SVNwSS+PJ0t5yDXrYBfrlLK5SbhKgkA?=
 =?us-ascii?Q?iwcKLGlQrrrDXMdqHKLwKTwS97CX7HyAAeClofGkiqvpJMJ48509oiU0RTaG?=
 =?us-ascii?Q?J/Q9jq3NS9JDpagDCrJbmnB2paMb7Bm2KkfTBVvixn3djUba7jd39nV7CS5i?=
 =?us-ascii?Q?RLgzQbsLHx5jJJPhm+5mKTDsPf1GtNCPo0AxRR80iDTAdR6EV/WpbW8aUOg1?=
 =?us-ascii?Q?T8V9esrlf0G2UBfyNSCPDeWzN8y++VNvC+YoHPHU6hhc5d+cq6EWN+HEf87K?=
 =?us-ascii?Q?YIyKA3jEUDKrvPt+Cnh6P6cAuoRIbY1J/snbmQH496+9GH0fJNAznMg7hTu0?=
 =?us-ascii?Q?d9Do7/EueHvVcc7PxYqZw0XMuVkwh/ee0wHOrJ5vn3d4uroiU8/PAHwXGGpK?=
 =?us-ascii?Q?5lzRSN+WL/hyp33VLIVblw8rB36phQZFBleIp2IlSwmc+/svCI3O8eCeALwH?=
 =?us-ascii?Q?ZvF/YdYgfYWdQEluNWeNnANNQ905viw3QDWRLT6y0oyrcRExRfWLlHi4MDEb?=
 =?us-ascii?Q?j+VcXETSAXmStzEqgKhJ7NX8+24Xz4G+xHziU57DE3vw8ICO+ukJgqbgwVUc?=
 =?us-ascii?Q?4d5WA8Rpei13OC5zS2Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3799a0-e315-48d1-a479-08dcc70b44c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 02:43:59.1679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KAoCPubbgSwsZCSMZPixxJo8UORi317BgF54LI/k+hMwfgoHCtAYHT8jG4tiDaWgApexhQFis6/aGXry0T8oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7856

> Subject: Re: [PATCH V1] mm, slub: avoid zeroing kmalloc redzone
>=20
> On Fri, Aug 23, 2024 at 02:24:15PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > With commit 946fa0dbf2d8
> > ("mm/slub: extend redzone check to extra allocated kmalloc space
> than
> > requested"), setting orig_size treats the wasted space (object_size -
> > orig_size) as redzones. But (in check_object()) when orig_size is set
> > to zero, the entire object is perceived as a redzone. To a valid
> > allocated kmalloc space, when init_on_free=3D1, the wasted space and
> the
> > orig_size should not be cleared to 0, otherwise there will be kernel
> dump:
> >
> > [    0.000000]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    0.000000] BUG kmalloc-8 (Not tainted): kmalloc Redzone
> overwritten
> > [    0.000000] --------------------------------------------------------=
---------------------
> > [    0.000000]
> > [    0.000000] 0xffff000010032858-0xffff00001003285f
> @offset=3D2136. First byte 0x0 instead of 0xcc
> > [    0.000000] FIX kmalloc-8: Restoring kmalloc Redzone
> 0xffff000010032858-0xffff00001003285f=3D0xcc
> > [    0.000000] Slab 0xfffffdffc0400c80 objects=3D36 used=3D23
> fp=3D0xffff000010032a18
> flags=3D0x3fffe0000000200(workingset|node=3D0|zone=3D0|lastcpupid=3D0x1f
> fff)
> > [    0.000000] Object 0xffff000010032858 @offset=3D2136
> fp=3D0xffff0000100328c8
> > [    0.000000]
> > [    0.000000] Redzone  ffff000010032850: cc cc cc cc cc cc cc
> cc                          ........
> > [    0.000000] Object   ffff000010032858: cc cc cc cc cc cc cc
> cc                          ........
> > [    0.000000] Redzone  ffff000010032860: cc cc cc cc cc cc cc
> cc                          ........
> > [    0.000000] Padding  ffff0000100328b4: 00 00 00 00 00 00 00 00
> 00 00 00 00              ............
> > [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.11.0-rc3-next-20240814-00004-g61844c55c3f4 #144
> > [    0.000000] Hardware name: NXP i.MX95 19X19 board (DT)
> > [    0.000000] Call trace:
> > [    0.000000]  dump_backtrace+0x90/0xe8
> > [    0.000000]  show_stack+0x18/0x24
> > [    0.000000]  dump_stack_lvl+0x74/0x8c
> > [    0.000000]  dump_stack+0x18/0x24
> > [    0.000000]  print_trailer+0x150/0x218
> > [    0.000000]  check_object+0xe4/0x454
> > [    0.000000]  free_to_partial_list+0x2f8/0x5ec
> >
> > To address the issue, use orig_size to clear the used area. And
> > restore the value of orig_size after clear the remaining area.
> >
> > When CONFIG_SLUB_DEBUG not defined, (get_orig_size()' directly
> returns
> > s->object_size. So when using memset to init the area, the size can
> > s->simply
> > be orig_size, as orig_size returns object_size when
> CONFIG_SLUB_DEBUG
> > not enabled. And orig_size can never be bigger than object_size.
> >
> > Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra
> allocated
> > kmalloc space than requested")
>=20
> Thanks for the fix! I missed to test the 'init_on_free' case back then.
>=20
> Reviewed-by: Feng Tang <feng.tang@intel.com>
>=20
> with one small nit below
>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > RFC->V1:
> >  Update commit log (Per Hyeonggon)
> >  Use orig_size to do memset(Per Hyeonggon)  Add get_orig_size and
> > set_orig_size when CONFIG_SLUB_DEBUG not enabled(kernel test
> robot)
> >
> >
> >
> >  mm/slub.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 94f5a4143825..a5fbeb2835b1 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1895,6 +1895,15 @@ static inline void inc_slabs_node(struct
> > kmem_cache *s, int node,  static inline void dec_slabs_node(struct
> kmem_cache *s, int node,
> >  							int objects)
> {}
> >
> > +static inline unsigned int get_orig_size(struct kmem_cache *s, void
> > +*object) {
> > +	return s->object_size;
> > +}
> > +
> > +static inline void set_orig_size(struct kmem_cache *s, void *object,
> > +				 unsigned int orig_size)
> > +{}
>=20
> Current get_orig_size() and set_orig_size() are protected by
> CONFIG_SLUB_DEUG=3Dy macro, and with this patch, they will be called
> in both ON and OFF case. Maybe we can just lift those existing
> functions out of the "#ifdef CONFIG_SLUB_DEBUG" protection?

This will build a bit more code when CONFIG_SLUB_DEBUG is
not defined. But it should be fine. I will wait to see if other people
have comments on this.

Thanks,
Peng.

>=20
> Thanks,
> Feng

