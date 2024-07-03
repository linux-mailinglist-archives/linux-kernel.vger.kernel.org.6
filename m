Return-Path: <linux-kernel+bounces-240081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691409268EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8E81C232FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80652183099;
	Wed,  3 Jul 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MOFeEzGu"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2136.outbound.protection.outlook.com [40.107.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619928379
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720034213; cv=fail; b=ahKv44WfFN+HW6hMiQAU0xo2q9Oi1s5Nc383BrDWuxo9F0GFLJ5kwzaxBjyfxfRizyuAn9P8zRfudV0guPWyN37qTGiTnHVxpfYN5+avEVjud8iLaw5/XWfvlZGWPbXal/2P5ktH9CbnVqN6fZfK2RKNhbMvjraCP1xLhngjtzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720034213; c=relaxed/simple;
	bh=VzDsvY+/LyrMg7U78dxCzzywhwy/ymUewBHw4FP6Bhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PL3g2uqZV2JjJlE32Rj0R+x7yX29tuxdGPfvVCJHDa0F/qRV8vVbvipJUMQdCdGmwrMLY2Z2wXxTHdh4Vjq37pRbBpsgp/lb5FpCcu2IN1cxfGflajAEQQxR152AM4prz2ZVemjMvj3hHwpjKo4nM81L+e0GouwS7HnMB7QmUp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MOFeEzGu; arc=fail smtp.client-ip=40.107.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR/omHmsOwA7njZHIlJMMRVZuPGzOFxzvahg3VokTJmDHD0WX2+Ij4rJtQBp8pKSgeID3R8/lS2/yUGK69c9Ixqp1D3CL9qG7RDhAup48kThVLur2cn6oVDF+bZEgkXqa1kf5VPofjsyfi29yY/8Cr5cfewVU0RWztxvS9e0yPHnSC9+emqf+9WXrdwTb47P/Oig/xrW7acFMBVsv1JfmmAi9XVGlhrdBHLQ5YqWq7+cnjdJdFQxMi4a2DFT6N0Aa0Gh7PJLmRecj6PLyHLyWE81Q4r//S57X+LnJ7IYAZb8nbBKllYjg7SxcEjXpo8PGnjLcQCBCFdwHUIGpvTWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMkjQFPBOuQVpNP7svu6GPjHPEyGVmUDqHvk7gzxImY=;
 b=BdSb/T6CdqTHvSTe9qVTeshmyhVQlZ95DE9k9/I3mt1ilU+WzxttDpAnznPVkcLcipVTWMHvbekpDi7A+V/8Gxf5+Fart9Idr37YPmyG6bJcxqovuLlPoOaZRRIqLbKF//XOL33OZYYwoPXjPOo2iI6WDypp9jlVBZnoaPOxAgcgYoAXBw9UI/Z6fssq9Ojc64md7P5/BNTr9EaVXbRL93rwo7pcnnA+BvoCEMz7vfnxijkgRSzg3qG8sf8FgnzxqLLRxJH4dZENCSHx2kMJqyVnhhkI5kjpWNDvbMpDjPMlpT5ZzXtZVLP4A4gO7+24dBFonPDtzg0ZezHRFtiiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMkjQFPBOuQVpNP7svu6GPjHPEyGVmUDqHvk7gzxImY=;
 b=MOFeEzGueSpHc7I4cLFOUzi3no8yhKaDc74/u4MHuEUgNyKpBY3D0f0WDLDt+BeYbvE+jnq/BKjixEW9vKg6NWwCdyyi8LGjkUvs6u1/2/cqYoORcDJ3AzzWxurCqI/G2Z2nZXmltbFLHwtFEXnkpwR+kRYjjBidqed7dtgZaN8=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by SN6PR2101MB1341.namprd21.prod.outlook.com (2603:10b6:805:107::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8; Wed, 3 Jul
 2024 19:16:49 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7762.005; Wed, 3 Jul 2024
 19:16:47 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Borislav Petkov <bp@alien8.de>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Michael
 Kelley <mikelley@microsoft.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang
	<kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Fix crash on kexec
Thread-Topic: [PATCH] x86/tdx: Fix crash on kexec
Thread-Index: AQHayi08OouzMdQ9yk6RhWa7zn+1QrHfHynwgAAFCYCABj7PgA==
Date: Wed, 3 Jul 2024 19:16:47 +0000
Message-ID:
 <SA1PR21MB1317B5850E4274CC31EDFBF8BFDD2@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
In-Reply-To: <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5131b71e-ee0d-4eac-8f26-c2663aebd993;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-03T19:03:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|SN6PR2101MB1341:EE_
x-ms-office365-filtering-correlation-id: 247ccd6d-3e6a-4dd3-19d9-08dc9b94af0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?l2obbLEXPW3aC9K9DrMo4oTSlut3BHvHKyXTmY4OwwD1/peQqLwfD/L7wEWN?=
 =?us-ascii?Q?beU61Lm6MU8aU4hieYkfMRDcKPh4kR0a5zDkvEk0cOzTW9xKpj7j/y+BszyI?=
 =?us-ascii?Q?WDzx0boSwAjMAu+Wfl/94yuO449RghfBJecNaI6gao5Lc99OcThv6eRrZmtl?=
 =?us-ascii?Q?pKu0HbO2PEzeopzdaKMaMPhR2GjsZKLdwCm+Y5XOVtFr2RZxCyVvIjFQb0kM?=
 =?us-ascii?Q?n8WaKJ0tHlR/jQnmKfwVk1ome3HxAEkhXZQo6YpQui9228TeeFgK4S2Mu+c2?=
 =?us-ascii?Q?fBZq4lG/2+TojVA375HkVNA+9/YaNLunzTezXHydbDgOm4NFdAXWRzbexzRj?=
 =?us-ascii?Q?GcHGTFrVPm1oLhc5L3usJQjGCfcgWMYGiKqCK7IeGGQlDpJO3e0Ef8tfK+qC?=
 =?us-ascii?Q?2nJ2JHG5GCDRoxIcxxyOCV8hrp6yYH0iCxA3+BZ04Wtg4oiO0PXfQ3jNtfo9?=
 =?us-ascii?Q?fHAFkFU1EqS97QSD37iI0FNtQ2utOaGBn4dZ8LGgCqHK/bl+VYk8ZbfeE4D9?=
 =?us-ascii?Q?Is8FK7BZbLcyS9AAl+d3PU4wWD6isul640lovnF57ssPPCAWwlVGmnQkMZ/d?=
 =?us-ascii?Q?PiObNqPgma8Qnj3HT7H1IoGkXBAPnh/FNobUQsmxQre++sZn9fYXh3XDQb4c?=
 =?us-ascii?Q?ZZjNifRopElbDX3nLsMlONrfwwzJ6GsiY5p3s8NNYNfVGWIWY7R81//zv4gY?=
 =?us-ascii?Q?G31x2ro0ien8PHzs8jULOsDi5Ukfvu5BUbGqfuQkgv9534ZLspVXvZOcyNCV?=
 =?us-ascii?Q?OvwNRSaklKSiLl2xXfT3vq4PUZ31CMYcNcYS6hKGK3AwPyAtywhdj2F0LNpN?=
 =?us-ascii?Q?UOo11NP2LkTAswd+AcEc+yCo+S0m4IXm2J8oIUQt/3WdrTt0kpAq4zvZlIrk?=
 =?us-ascii?Q?SWBIGDQR9jwHWtJju0maA0jCMsN2pq4Syw1Zcf42qKkRGcPBrwwISTyFwipG?=
 =?us-ascii?Q?IeRiHteZ6jijKI6vfyxsqPRmjz6TKyVHTlvse0CwjMu5p9b03O5qyPvHSrZE?=
 =?us-ascii?Q?93yb6Kfd1N7tYgVOqOpgyujwPwmPJ04W3bHuG7Mte2L/gVYehyl5Cr1y+0Bm?=
 =?us-ascii?Q?kJcftjsDb3sCPAHBp/M82MFHlJ5FOdD+SuY8s0YKKGB5Ck3Xc7Y27s/xR5hc?=
 =?us-ascii?Q?w+9t1KfeLsC3a9OKbI7P/ipcNc5V0XhwpekRrXA+324a3LvSOH7vCJ9b1Izf?=
 =?us-ascii?Q?KFZ1gjQARrHZW6GzJp2BJPUz8byoez5kdy/LvrIJ7+riMrjoxzW+N69q7bZS?=
 =?us-ascii?Q?86TzC6oKjQ9DEA3agbm7SuWVZgEgsbns5SR4eAGuBQvNrBUb1ovXGC9ouL3O?=
 =?us-ascii?Q?Zv+Dn/ISGInxO+50Za3/C8dTEVfqH0uqvSwcqwP3KjxqMwpYzMErcU/oFho0?=
 =?us-ascii?Q?3orqBsKMREHNwBNO3Z+ZqpKkceQbJQ8P6NNjTp422osfG1O4nA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kDbDtBroADMuamB5vdZlzNjNfqEniAEKmvFKy6dA38vufvDZkvyGBV/DkiNQ?=
 =?us-ascii?Q?/zdLEEvDf4Eo8vQwQk4yChJcbNu0Cbgh/OiZCBoFKLYSoGr+5TnAjZh0WcyM?=
 =?us-ascii?Q?BMYQwkElcp7w7sRPGu/itJ0kvCdiXKikSrzI5XnahBtTTF4AvMzWEX+rJGug?=
 =?us-ascii?Q?u8a0B4AdndxI6iAIwLvxNdL7y1CifJnwfjQvMn8wCf70VH30U8drPwzJQfQJ?=
 =?us-ascii?Q?jdSukRFyRWGYIXt1m6/x13DiRHAhe+p02LAD5iinm5PKVq5KTJMH/56oWYv+?=
 =?us-ascii?Q?Gkd3CanKjaxnrbs/EOIyxPPgmchEodYB45DYsZjTvm8+lgz+k3YjYlMJz8VK?=
 =?us-ascii?Q?2RXneqxou00mapvBg/v1wpXugko77pwTmZMNdH750ohlfcwlAH5yUldM0jXF?=
 =?us-ascii?Q?pgxQqxJGPAYomcBAVI7Ijt4inovutf9QoS644iP+w1CN2qXN2uRShkBwo4S0?=
 =?us-ascii?Q?EocjQy0Z7Z8ZEQPYPcQfVgllWcAhorviwywXVG+7GKrI7NJXzB2q/1gUgVzK?=
 =?us-ascii?Q?IKnVo9QkL39iUMFcPvGTOl+XbTrHA+6tzfdiOe9bAWM01IMZ9X3jTeT3t9F7?=
 =?us-ascii?Q?7rXlB1AhXr9+PESeFH5uL8Rc2PHMxbS+y2R9WWTIkxroD+wNS6su/HWksDDo?=
 =?us-ascii?Q?OUEUViXERF1+YLtnDL1UP0WqP0/PRNMNkgrG8kE+BO4XHVHiutZ0O2eh4nGR?=
 =?us-ascii?Q?w2VMKXpR49Phmn9MWa/oT6mU1c9YWB62KpR0KHfwwtbdLEFQO94Vhd1LwSHm?=
 =?us-ascii?Q?W+0GUXW+AE2Yw5JVJJ3LOAOxZs7z2lo/qQdDO7TcAJm+0a6dshaHZ1TDhZQ2?=
 =?us-ascii?Q?AUa0KYTLLN0or5C3UWMlmZoNUEeDnYBLvod40iK/COytptxAQdh+iM9yKd9f?=
 =?us-ascii?Q?QfvU7dFPLo2ZboUf6ix+VcsamZv2OFU3cxsPM1gm33CixOk6qrU74XuFBJx5?=
 =?us-ascii?Q?3GeR7NBglgpJ61MLTlVngTylgSYM0tu/zSk/+SJhsRNp2xO4OzI4Au9VZrU2?=
 =?us-ascii?Q?1pX45yD/3Qk3+C7r+ajP6ISPxPfEFA2dOhjOH4Uo3n8/fp2CIkFJ0zAcq1cz?=
 =?us-ascii?Q?2tfLwRq24aZicB0H4V1kz533HZLxvUK4rSsHLUPRDbL6MJYlJS07/Hz8wg2N?=
 =?us-ascii?Q?gL/4b2JN//e1Zz3aZDYg36WXUn7QFgb46/PVqBoKThWz05jxkVxfgL6wh4KW?=
 =?us-ascii?Q?EMUyEeQNVsE8A5u8SU/1VQNUPz6VE6pnhOC66opx2hPsaoBl+9DRswa7nI4b?=
 =?us-ascii?Q?CYFPtXesY7/p98Mo6iM6XdCClbgoqeaAaI0x9lqBaf9AFkSW6+wV/PbzbUeH?=
 =?us-ascii?Q?nLQ/t5Q4k0pAJhkPadp9INoFFWxhwvJrq+3bXwCX0d9H8LeffUQGkAn2FVrm?=
 =?us-ascii?Q?EOGNDVcSOQbemkSu5cyAksukgkvFdmysPz7BEGimkAxew3o1VdJfDoqquyuW?=
 =?us-ascii?Q?5eBcV6bWJOiyhc0TQ0E+yzDhm1x2cLvrXC4RvKpTbCVuBi4NCDF6nM0xA6iE?=
 =?us-ascii?Q?WOj0ioozJOeGNq8R4AKtOh2ZqFDKYLxBxNkyydvsDkY8BsXNsKYndWZLRL45?=
 =?us-ascii?Q?6dpFyS2fzMAvayO03EU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247ccd6d-3e6a-4dd3-19d9-08dc9b94af0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 19:16:47.3716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMxsjPkyiXRMoVzfgmiWeuVrPuHrAewfPqyDA6geRrpR+NV73uyyF4hQSnhP+BmzwUOV5aj4PIQ5sEd4lG1jtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1341

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Saturday, June 29, 2024 12:41 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; Thomas Gleixner <tglx@linutronix.de>;
> Ingo Molnar <mingo@redhat.com>; x86@kernel.org; H. Peter Anvin
> <hpa@zytor.com>; Michael Kelley <mikelley@microsoft.com>;
> Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>; Kai Huang
> <kai.huang@intel.com>; Rick Edgecombe <rick.p.edgecombe@intel.com>;
> linux-coco@lists.linux.dev; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
>=20
> On Sat, Jun 29, 2024 at 07:27:57PM +0000, Dexuan Cui wrote:
> > It would be great to add e1b8ac3aae58 to the branch x86/tdx.
>=20
> Sure we will, once it is properly tested. This very thread says otherwise=
.
> --
> Regards/Gruss,
>     Boris.

Hi Kirill, Dave,
Do you think if it's a good idea if I post a new patch that combines
    e1b8ac3aae58 ("x86/tdx: Support vmalloc() for tdx_enc_status_changed()"=
)
and
    your patch "[PATCH] x86/tdx: Fix crash on kexec"?
=20
Or, maybe Dave can help combine the two patches into one?

Just wanted to make sure e1b8ac3aae58 won't get lost.

Thanks,
Dexuan

