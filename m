Return-Path: <linux-kernel+bounces-536598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F3A481DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F95E179E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D00237180;
	Thu, 27 Feb 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OE2Ns7Qn"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AF231A22
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667005; cv=fail; b=KDb94tjQOdfbZueVelqhil4eG2UCwGJrJIKYvUwoIPEYiFNPWBOWYVoeWiocVOIqjKPeNazAywju7LXTZowJIPZTLo89UqLYuA36/9ptv0Cbja1gyhdSeaguMetvM04NPnzIn1rSpIHhmByX449OF7SGUSGf5HSbx976zdFxsiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667005; c=relaxed/simple;
	bh=wANP6GSMZyPhpmiwgEUiIblj4tjZ0eEpBqeec0oO+co=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B5+PTfjVg2gTCFJXDEhTlOuDPzALtox4YtgWIO8f8ICizLvOuZZyyg5wsCMFKMP6zrZoz6M+pBZv9G6mau38IiWkd/1hw8nGxutlS6eUK7S14kKe2Uuki8N7xKyW88mYE4kuWbC/XGZxVg4ahtmaJH4dHfrKg3ZdaaXPSH28mcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OE2Ns7Qn; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgl7lB3xiIWW+zKGb8avR2h/Pwe2m62nCpzg3J7li336p29efXLs/5HobJIBK5cggOU2x3koVV3DujEwjGf7T83mpLsdil27jPLygDpZNUuDzIgR+SK9MGkFzIbbGC+513hAev9O+iOsgfzKA+IXVXOKSeH6jT6q80PsUKpesKObn7fauVZGcu/s6a/lW5TXhI1zLJ4RGickmNJY8EROuml+hLPIDcXC1XcLUOhsoRo7v1ePJtFdw123c1nZ1YteHov9gJmXCAF/R0GzZzpmZhLR1IxovS2giTQXCoidq5+L+Ik6pncUpkrxWyqfZMQgVRyO4eCjcpX3qlvuBI5L2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA8/0OG/Z7uxbLD/f1olQPAMAiV6yA1J0pxALm/YuKc=;
 b=DzY+Xue5IGj2RfiHIia1RumrzyEgJwL8wKTuhmBf3TuSO042mAStnuswk5z9jpUeVqBaqo39lulDMaGxKTmLTnTYtKVguTpw2l/svWIs5BrYeQgWxJymOyMs1h2M8jfHiC3oBVNWZuDouanaVnR+pMKUSmCMVU3I19lLMJ1dEEY4SNd+zvZW9XUd3e52mhrR2jJRiERqBVQOT9M+4gpTKwtWctJ6L8SOWDkgNXMLY9jIyQDBIBWgg5g+R9dBessL1rnrbItWGBmpJHqW6vdqNYp6WYMnneyXZNiJX2YoLHeJ7NuEJYCNBPig4nwKbD//zuPgySpbqQ9vbsVL9y6AoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA8/0OG/Z7uxbLD/f1olQPAMAiV6yA1J0pxALm/YuKc=;
 b=OE2Ns7Qns0FtvpIPZVfs/+E/j3XSWgVP7pFYctPvUCE/2cqHUt4i5wked/Bu7IBa0NkWP6vuCrSac9nJ0NqjNjPN7GVxjrQ/sA5yCN15TCa13XuqbUXNANnoNad33XzSZ5WH99bR8pCLFe1dcWAkmm8Q0QUQBat/kWHCyFPViJU=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 14:36:37 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 14:36:37 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Topic: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Index:
 AQHbfK/msIIkfjoqOkyd6FXsW3bSnrND631ggAfdInCAADBpAIAAAIOwgAA3cwCAACLxwIAAWYuAgAAd6ICABAIeAIAJN77AgAAXk4CAAAqGMIAAFpcAgAAZgACAAA4xAIAADWqAgAApHQCAAKzDAIAAAyFg
Date: Thu, 27 Feb 2025 14:36:37 +0000
Message-ID:
 <LV3PR12MB9265B1854AB766EBB7F098D294CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
 <20250227003528.hnviwrtzs7jc3juj@desk>
 <20250227012329.vbwdmihjlqu6h5da@jpoimboe>
 <20250227034813.booxbhxnff66dnqx@desk>
 <20250227140858.GEZ8Bx-tTaQF8D5WBj@fat_crate.local>
In-Reply-To: <20250227140858.GEZ8Bx-tTaQF8D5WBj@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=41472e76-93c7-4548-8b24-4a5f242b112c;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-27T14:20:09Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SJ0PR12MB6855:EE_
x-ms-office365-filtering-correlation-id: 88eb31e9-5f5c-465f-b7d1-08dd573c2426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mXectUu4c/levrbOfdjRF13u1ZiNLmzfnTtbAJpGyekAkP1MfLcpBqGzB7vT?=
 =?us-ascii?Q?sHHMGvEp1+bNKFNPzHApiRxsVsl2+Ad8n+OLRGa3CTvcx5w4JgvOyttT/GCP?=
 =?us-ascii?Q?baSAI26AsoNnyfoK3B8KCYfEfOrGfJfiIBJpyjrHRWjRMoqK+vK8tJP4tBtd?=
 =?us-ascii?Q?1ILFJ9VibOtPdVOz6fn4oSoHF+Cm5PeRrFcbueYYSjfxeT0rAqIrwd8mYqCT?=
 =?us-ascii?Q?58ztofKmCQ7zsiRhg8Qj/sTl5klYu0ABO3r2fBpgGaebPIw0Yi5pIDe7sTa4?=
 =?us-ascii?Q?FWsMLrZmjIsr6uUCwv0+Vg7P67StrvdePfJvr6a2oeCrojmuKkCpr4U2WAcT?=
 =?us-ascii?Q?bkoJslb5cA3y1hnMlKlTtA2d7xv6xJqBPWxaDhN8S/J7pTZtDYh1aaFKOsTJ?=
 =?us-ascii?Q?EvcEDX8hXjB9Ap0KbL92A4O7ST3cwPss+En/4IvgNjKe4gBnJVHKCpdP715g?=
 =?us-ascii?Q?IaAxOiekfTqvETQagaHTqBwWNoAg2Kp0sZVxkhsr0FVJPhDwRJMneU6oyZHj?=
 =?us-ascii?Q?KzGP0Pe9HDF1xxIeWpMsD86/PS/aAdR1Zkc7KOgqgg9cQm9Lj2QxyYoWaXlz?=
 =?us-ascii?Q?h+1ZxH6EAlHlbQphEMeLkiPSl3HuGEdxKZozrjczcOYUXJokelZTOLWNOJ26?=
 =?us-ascii?Q?FwRoXzZml4gDVJaVQp6WKaAEL+5V0nZCBJ9xXq3Y242vK6k+kVB7awG0PqTs?=
 =?us-ascii?Q?tJp0f3BgNpHpbnRgYWxuwCgGzS+0veCd0QRQmTJ6B6bmdlXUF4skKAI0AeJt?=
 =?us-ascii?Q?swPlrJvNiFhjmRY6TnRTvCvy2pjt5ohDI5d2Ra3U6MVS6G5PCPFlj+KfkNHh?=
 =?us-ascii?Q?lGKAkbYBEL3k+YedHyNXXB4GMP3oqtxfn57Dw5F8iW7RlEB1tRCKtlaxIsSR?=
 =?us-ascii?Q?POGe360xzDffyVOpKXCmRRCFXm2y2KZADDTkpIxhMVxxSboFivHWOlsES3gj?=
 =?us-ascii?Q?WFSJ+fi1hEd7j1QQ21VvzzzE9CTQBS/fsOslatU5TzpIrh5vOumx4ippVldB?=
 =?us-ascii?Q?bsqYgD8ls1cn9IKzPxl2Nf+abTNwR+4NHMa0yaEPJcZ80V43oguGTko4jJK8?=
 =?us-ascii?Q?ka60aOoCIhFgUKVhBgPz/FkNSe9s/ZKDivN/zyPQczhSMlruy6cIyxXWNbzj?=
 =?us-ascii?Q?LzftGBnU0nG0nfiYdzKy3bqskleIzh0JTv59BAhXHZS6b1GVfv358HaRn32n?=
 =?us-ascii?Q?XNkfKHCA1gPtUP6SRlzon8qhv09wlX975IQG8oqTVX1OsXuWlMAg0Yi2Seza?=
 =?us-ascii?Q?/WiKtiE6hLl9qstpfjra0Tc0tJPuL1AdYN9qgGs+X54cQNwfKYzMXDpGSr2X?=
 =?us-ascii?Q?zMF3cUhTY3UXN8b7WjCUY2Tvgjpnz56DR+wljrY7ywuDvGzdVQ15KfVRpBkh?=
 =?us-ascii?Q?CitZq4ivZMDH4F6cph8skb1M/WTCR+akydH+kz3cEmPARaNIHVPtHFyoXeKZ?=
 =?us-ascii?Q?X4ubffmwrP3WeDVBIeRwXBUtNPGG+fwe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mQM/+H8Eq+iVJgyP3fBv55rhOMjidd8hUEYnP1HbNOeTH2ULrlmB7CbfE2ht?=
 =?us-ascii?Q?+lbTYvB1W/hnGJOwfiX48Z/2hApdWEBwxXpHKUlsfaVXg68NWuwrLu5aSgxL?=
 =?us-ascii?Q?kkTSJLXHNZdsK3rPk8FouI6dJMa+TYHnpM/nUdMF3BH29lYRsMdZFfwGzhs4?=
 =?us-ascii?Q?XzxBZ7xVJblKMtYqsxDowaKV4o4i2SbS7Pyf1XRLI0ibhzOVKvjH0BMFGY6e?=
 =?us-ascii?Q?x9e4cb9MnBn42yUHW7u6FF0YsZzJu/x6G7BzCij/38bN+2WRhvZ/Y15uqvgE?=
 =?us-ascii?Q?LVCXHWTeRw619KOb8oe3t7Lj1fbrVCW7J1ik/Oaa4nXgn0BbE2U8R1bR7+Sc?=
 =?us-ascii?Q?XQS3Ra2W0ylhAW1hV40i0IE/UZfwyJ4Hgwkf2j3XMhAAAzELByP7MFPrZWpW?=
 =?us-ascii?Q?hsSn2dZdD0B3TI7hR9A77Pz6WLxQXrOANgYgb/Wn7dFAJAyU3Bje+dX3LOpQ?=
 =?us-ascii?Q?QcSUQaBegqruLVXVj4j5iCxaCMXOyRTujyIWx4RNSfokakFcvGZB+3PmfVpz?=
 =?us-ascii?Q?6fYiNi4KdJcl0MjwxXhy9dgWleFbx+IFQQGaIfvWVKQb9w641E5y/tRWhlgn?=
 =?us-ascii?Q?pjJKrpxRkLKocb24EVdga1xH403ltMIvpMRGWhpH3QepHM0L8mX0oM/WvSjm?=
 =?us-ascii?Q?4IFlgbg3+kx6orQQP3wMFcbjeHcAm2NeKHsbCbIyoGNuRV0JrbUnuEOl+85U?=
 =?us-ascii?Q?RsMdINoL99uekibAah9dp2zh3JYyNoeQ02npbQQyY1jMkoDLhtm5gfNVoKKU?=
 =?us-ascii?Q?Q/hffETSu2f2MkaiPDu0YJEOEtCgpVS+qs11yIIEPmphcwIUYjsPdPmHNxxV?=
 =?us-ascii?Q?L3g+IM0kO4ubpwI1QC8/y/sawomag4P0obtCa2bsNXikNym0rk+pxKjdADfb?=
 =?us-ascii?Q?zuBgx3pbHmzhZVtOjSnVxGgZOHtLeES7/7jRwSNEa9zKtW4TN2I0dXa3Cs2H?=
 =?us-ascii?Q?W9M1ctfbkKWsb2cIUasOdZYby+2+M+8zH6VAwYMLJcpmTn6uWXjrX3kh+70K?=
 =?us-ascii?Q?LqbW7/DKKz+12iOTH64wgHSKdUSK07ZpgQDK+zKzLmis2mTYEdz7YX10LnHL?=
 =?us-ascii?Q?K8IxSEz3wwymv8ruQn1GrzvZsMu7p/UtqPhMXMYkGiLjWyq4Fr1LM9MNry18?=
 =?us-ascii?Q?wMSnJEZvockkPY9aKeg22GP216gEhELmkrsp/KAzbyPgrQxZIXrMgu+xr/8g?=
 =?us-ascii?Q?cccaYHPXJjn1IzmFWDiLsmcF0N6S99IJKQPV7gaC0mIUi+emmkZWYmoUbm9S?=
 =?us-ascii?Q?wcEfl0KvWBDpAVfOZ5Sws6ckSxyulfQ63t7NbdFTVbFNyNAroUEH/khhAhEu?=
 =?us-ascii?Q?RUHXN9WwrFc5uVl24jFF6EqGmdn/Fn1qULrUYFKknM6CBI3mKND//2W9sGok?=
 =?us-ascii?Q?Sgbkmm+bhOph/DlEm5K5EKmNGP2CuYoIN2CGWVkCGOy/TthdCI24XcYEVD9Z?=
 =?us-ascii?Q?1S1FJP0ndNpAD+HGmSZspso7X7dcWthpzKF9wr4OZIVxljQZPyciP5anZ/iD?=
 =?us-ascii?Q?pG7S6G8XnVfwog/u+I9aYlHUjkHFpTPopzAflZtcUgw8wbXoaUSk/HTdw5gh?=
 =?us-ascii?Q?NwA6nsi1aC6p9bwjRsA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88eb31e9-5f5c-465f-b7d1-08dd573c2426
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 14:36:37.2608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UFdvHSrASvTIQio4QMrjtubxvouIeTrthdL7TwVBq/qoWJt8T+G8B4lsdHxe83t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Thursday, February 27, 2025 8:09 AM
> To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>; Kaplan, David
> <David.Kaplan@amd.com>; Thomas Gleixner <tglx@linutronix.de>; Peter Zijls=
tra
> <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, Feb 26, 2025 at 07:50:38PM -0800, Pawan Gupta wrote:
> > Thats fair. I certainly don't want to be adding new option if we are
> > willing to live with some minor quirks with auto,nosmt.
> >
> > Like, should the order in which nosmt appears after =3Dauto matter? IOW=
,
> > "=3Dauto,no_foo,nosmt" would be equivalent to "=3Dauto,nosmt,no_foo"? I
> > believe they should be treated the same.
>
> Yes, they should be. The order within a single mitigations=3D<string> sho=
uldn't matter.
>
> > So as to treat nosmt as any other attack vector,
> > CPU_MITIGATIONS_AUTO_NOSMT should go away. I am thinking we can
> modify
> > cpu_mitigations_auto_nosmt() to check for smt attack vector:
>
> Looks like we're calling it an attack vector if I look at the cross-threa=
d section in the
> documentation patch:
>
> https://lore.kernel.org/r/20250108202515.385902-20-david.kaplan@amd.com
>
> So I guess the cmdline format should be something like:
>
> mitigations=3D<global_vector_policy>;<list_of_vectors>
>
> More concretely:
>
> mitigations=3D(on|off|auto);((no)_<vector>)?
>
> Btw, it probably would be better to split the global policy and the vecto=
rs with ';'
> instead of ',' for an additional clarity and ease of parsing.
>
> Before this goes out of hand with bikeshedding: please think about what
> configurations we want to support and why and then design the command lin=
e
> syntax - not the other way around.
>
> I'm still not fully sold on the negative vector options. Although it sure=
 does save
> typing.
>
> With my user hat on: If I have to do "no_user_kernel" then I probably nee=
d to go
> look what else is there. Do I want it, need it? Dunno. Maybe.
>
> If I do
>
> mitigations=3D;no_user_kernel
>
> then yeah, that would basically set everything else to "auto" and disable
> user_kernel.
>
> David still wants to warn if there's no global option supplied like "auto=
" but we can
> simply assume it is meant "auto" but warn. This is the most intuitive thi=
ng to do IMO.
>
> And when it comes to warning about nonsensical options - yap, we should d=
o so
> when parsing.
>
> A couple more random examples as food for bikeshedding:
>
> mitigation=3Dauto;nosmt,user_user - running untrusted user stuff, prevent=
 user apps
> from attacking each-other, kernel protections are default
>
> mitigations=3Doff;guest_host - running untrusted VMs, protect host from t=
hem
>
> mitigations=3Doff;guest_host,guest_guest,cross_thread - cloud provider se=
ttings
>
> Same thing with negative options should probably be
>
> mitigations=3D;no_user_kernel,no_user_user
>
> Hmm, I dunno: being able to specify the same thing in two different ways =
is calling
> for trouble. I think we should keep it simple and do positive options fir=
st and then
> consider negative if really really needed.
>

My 2 cents is I think the negative option form is better.  That's because I=
'd rather err on the side of safety if the user forgets something.

For instance, in the case of 'mitigations=3Doff;guest_host' there would be =
no guest->guest protection.  Did the user really intend for that?  Or did t=
hey simply forget to think about that attack vector?  In this case, their e=
rror leaves the system potentially insecure.

But if we only support the opt-out form, like 'mitigations=3Dauto;no_guest_=
host' and the user forgot about guest->guest, it would leave those protecti=
ons enabled.  Potentially reducing performance more than intended, but the =
system is more secure.

Because the existing kernel defaults things to on (the auto setting) and re=
quires action to disable mitigations, why not keep the same logic here and =
only support the opt-out form?

Some specific use case examples might be:
'mitigations=3Dauto;no_guest_guest,no_guest_host' -- Running trusted VMs
'mitigations=3Dauto;no_user_kernel,no_user_user' -- Running untrusted VMs b=
ut trusted userspace (cloud provider setting)
'mitigations=3Dauto;no_cross_thread' -- Using core scheduling

On the SMT piece, I think the proposal is:
'auto;<attack vectors>' -- Default SMT protections (enable cheap ones like =
STIBP, but never disable SMT)
'auto,nosmt;<attack vectors>' -- Full SMT protections, including disabling =
SMT if required
'auto;no_cross_thread,<attack vectors>' -- No SMT protections

Is that right?

--David Kaplan

