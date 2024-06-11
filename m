Return-Path: <linux-kernel+bounces-209989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10C0903DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785B1284796
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB74E17D363;
	Tue, 11 Jun 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CjLhVykq"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856A17D355;
	Tue, 11 Jun 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113303; cv=fail; b=hGOnfsP7BaHhVeXnQ40IAY7Otx8TSHMBqhh+2YkGuLFnCWJb+SrlI/JdctH8R5+M/a61iRCJjgo3iYQWXBvT1TDLPM3HfgF+Mj9Ro3yYhboZnNHYsvNa4P0XfwHQfnWZlbAqU0smwXoD8hb0sEZLH8DX5UUEKxC0mcbHhbqQB0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113303; c=relaxed/simple;
	bh=yq3dXureARJQWfxHHOlpOCayOHaYfVlN2+DplpmG/q4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lydNgyDRxzyaJqD6txnzHlrxDXWGViMfUtlpwrR+zgOhZRZHiBfBQzfaW0QX5cRhx1DrTSmA2fv6TaRUv6RMsbWB7gfR+NPqYNYcizxSa1oj5rojVf6Hl+ujKROTkVtGfCV09Pu/uQVAvxleqJsjtdPJrKuYTl72f8cO0YmG4IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CjLhVykq; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY/G/AE0kra5E4Rsd3sFdu2lzE29N+wswfXgQLvwjzsuHJhyPfhIS556caV6Qw4NwmgKkwgatc3lnoy1TjNqsN17z3l8IeZpCv9ymfIod/9WPW36fMY4T85/Onj2RkdYUEwos4Eid8cLGkRmhmpom4MG6UJEdOUC8cYonPSlym4mvNn7TyTSZULyrNJ9mk5KaQuUDThMEPkNf+ayZpnwhKe3Yrkv0YE1gfHB4XzICbz0mmMHDGuYr6L4fF2JdVXeAiMfFYLAt8fY3lpEXkhPrAG+4LZH/2jmVFW1v0nP5PCSrFS3Ad5Bj0ngJJyFFyWmtUcm+4HJmVuH20qb1gVGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9GwJUHrgPLNIyLhoCmrWeoQHBdTCEUPMVazDIhYA3s=;
 b=oRm1Zwt5wqupjznDtIrDV4XSoJ4n6HH5k8UWBgWE0qNg81xbwZ9vmpiveqPEJ+jss4SggbBEzG0DmdDaYCQYQ7mxgSGFB2BiOqaftIaXaTL0+UInVdmh0YTSPc9U9yj+44ZhAL3Cm1pMyMgdE0b2d6dzGyr4/8MU4eSLJcuq3MPAfZRfpr+jRHeg8CojQk0srI1m1CxwAJzHPUIej2NDWNd6XX6tSY3ND2+LLlvRW54mDWZ3b95pjSSxuT+PrN6SaS/Cy3hOt1u5w6h6FKQYt2l4hEl3KtncWpJrOV7520V8ql/YhIPW8GWc1dVqitfrHuOPWRAkSRvHW+UQBnsyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9GwJUHrgPLNIyLhoCmrWeoQHBdTCEUPMVazDIhYA3s=;
 b=CjLhVykq42Dwhj8ul4q8/X9cysnJ4t2IlcajYjhS+muxpSa6koKbaUYr9ALpb71R6RjlCuff6FwYOXsedV5I8xtFaMJiuAU4T7WkN7GuB5IPnTPW/fub7p/u1Y1D12iLw3Em24sk8d96drmFyl/vyquxWA6aN9J/miwcOaWH62B3u42MYJZmuLxHXOg4SVlCXjHDyk5PHMWxdccbQt1NQFVnOCo8G11ojuwlwLnZQ07XyuHpDB0Vzjrw6XxGshCBW8uNjg1cA0wPfIOXRzxeDu1OBnFGUtrg3ZiJb+WJ8fU2Cqf4jmMZjgjQ6UnQmuJTpVFRtQPnhdu7MfjK74wEmg==
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 13:41:39 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:41:39 +0000
From: Shravan Ramani <shravankr@nvidia.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>,
	David Thompson <davthompson@nvidia.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] Documentation/ABI: Add new sysfs fields to
 sysfs-platform-mellanox-pmc
Thread-Topic: [PATCH v3 4/4] Documentation/ABI: Add new sysfs fields to
 sysfs-platform-mellanox-pmc
Thread-Index: AQHauMR++tyHAsTfQkGG/OwDOB+aWLG8dAwAgAYit+8=
Date: Tue, 11 Jun 2024 13:41:38 +0000
Message-ID:
 <DM4PR12MB51365BA9AF19ED18E7516195C0C72@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <cover.1717755404.git.shravankr@nvidia.com>
 <ef3f942c1d933ef757a0de84c2890d6779471239.1717755404.git.shravankr@nvidia.com>
 <c7464064-d08b-ecdc-8e07-b621a466d967@linux.intel.com>
In-Reply-To: <c7464064-d08b-ecdc-8e07-b621a466d967@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|DS0PR12MB9422:EE_
x-ms-office365-filtering-correlation-id: 994d1c75-60b6-4c0d-6d8a-08dc8a1c386e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?thnanBfOmx2JENNczTH7BLVI6UxSuxMAjRsEGePneeklZpugZbp01AcUaD?=
 =?iso-8859-1?Q?Q7Ysv5H7i+rcFmboFRBxEFueLd8St7qDRIKRmsnG0gG5Ij8A4um7+TbqQk?=
 =?iso-8859-1?Q?h/dVfLcuCbO35FmuZLdrHry0lKYIi1HYxQdKiciAwt92dkVI/B83/J7Uu1?=
 =?iso-8859-1?Q?6Uy0O9fWDZHD6OEaEM6mbyydUmVODlXSc96/VEs+ZXiR3EvzXJO7R+//Od?=
 =?iso-8859-1?Q?KSXMkW4bcRZiCBwbnlfWidE6PGf1LU520hCUd8Wio3QsA4RlDzREgPb7Z+?=
 =?iso-8859-1?Q?moOeuC3ktrhBTvziZ7C6z3i7Cp42hctelWwAjh0jJIT86saymBM4Of0OL7?=
 =?iso-8859-1?Q?KmXjjZWkW77pFVNxuPThe2ak4XmS0MSJ4SOYW/FzkzNK006jjhEl093FeY?=
 =?iso-8859-1?Q?1ZcroyGprLmxIdmhJrVQJFAhlhrGrbXH9GDDfn3d8FNYhrx3nigGZBdrMF?=
 =?iso-8859-1?Q?7RapJbzaLwkK6nZ1fWeUBHZ9t0jIxamfVt75HrB0c/7F4pEfYbe9OquMln?=
 =?iso-8859-1?Q?OC4zTwMSJRofcp/Fjh1WP/b44PqP3+yK/LvghL5kDRKK1FxMyt4LIXxPVO?=
 =?iso-8859-1?Q?rfyxE1nP1gioJqwL1UYKfnAtUHAFor2kXxxqrY/l78w3rvWOoNSBUjqJ3t?=
 =?iso-8859-1?Q?ycDaMyU+BpKcvDBUzjoAkeFfMm5cokCOZHXgEbZLaTNPopXCTiWs4ko+UL?=
 =?iso-8859-1?Q?KwPeZUQIGa5A2qdxK0GElq7Y0IBQZwPshei79DK+7nSC41n3aH3kFcxsmv?=
 =?iso-8859-1?Q?7b/zNe/6c1TuP9x1TMpXzgeMAkR94BbngaQwTghG3MrKaZKidK6UCcZF0t?=
 =?iso-8859-1?Q?G51QMtV6MLphBzpODDAwAe3RTxoBxc6Hs30LQrok7zet8FNLJkQBzliDIS?=
 =?iso-8859-1?Q?/VkiCFOMAh9fPiJ8JZqZUV/WcDaQS3gRBFUTPlex2GKmSXkqJkl2dLuTvR?=
 =?iso-8859-1?Q?MV1lGiomhdQF5auxags2G+VMQiChZQFF/MCx9PjlD2ibiSKptamAJh062G?=
 =?iso-8859-1?Q?rBSjTigk1Gcqbfadq2RL2spM0HfOaGpuw3hSUhCRrmtO3umk5qLQm4cJOW?=
 =?iso-8859-1?Q?0Do1VLtr8d1MmmirNF5w0aVDjRVIakEBqUTqCAPvUgxktRH8SRF0DcyiXL?=
 =?iso-8859-1?Q?u8AY89gR9AdKxCQH7lc3vL2dfYEukzMb8zsP1Xb00Qdj2QZIecxEPeI3us?=
 =?iso-8859-1?Q?2uV5IjCWffYVIin96Ph/sENl/l+9D07iczC6CAT2TVIafasAKmTBt7Dhja?=
 =?iso-8859-1?Q?WJnAcWTqTriJRDsGkVGLmXDMUwxT3QcEim+E1dpIyFgHeZ+oYM9CDk54Vv?=
 =?iso-8859-1?Q?Wq2YtnsDtP9QTjzQXKd6L1EakZJzBHmbqJXALcrNZjeLgmeTNGS8kNqhmN?=
 =?iso-8859-1?Q?s4BMd6x2mnaSphZsDPHy3SHX2DWADG1oYKbZ2Au/AD1aJNKV1fraU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dMXqLSmPq3WR1I1e45jwB4b2kxUv4eCHGqY0o9MncoHyFjMX/JxgJ8AcVg?=
 =?iso-8859-1?Q?MfnVHdPhHsER0iZppMelWBMpi64/5vVuMS+hvWkl6Prm7bxYqrc35fZuk8?=
 =?iso-8859-1?Q?mxqwk18pExRwxBgyUD4cL5wDi6jHVcCir3YCqVHv2aeVBmOKzq83wQAI6M?=
 =?iso-8859-1?Q?YWSccqo3Swk1B2ol7w3GEmIQU0Dapc3kPe1er6/lWZXnGhTuDlL45w+yoJ?=
 =?iso-8859-1?Q?VJYM+rVQ0NGOmX6YWwXlbZVDvGPbBIBcy7UHYiO7I5947YfIUVQeHvWudm?=
 =?iso-8859-1?Q?BfWeTAg2VJFs+EIlDmTP1qTm2jT68rs/VF4eItYNBxcyhAcEX6sPVLgVEs?=
 =?iso-8859-1?Q?gP70Y58Ss9D5wHayq6gSXpFenUEpK2NuC/wZjE2es4fiWG+m0alZrAovhS?=
 =?iso-8859-1?Q?SBfz4ZB/w20UP2N977GT/7auHkXFUaAqHEWF1q2dkUD3GFTTaijZhRyRyw?=
 =?iso-8859-1?Q?7JzgDBuD66RkcCTVQKxs+Tr/av9dSZxlkzwaUk2gALhGFPzoIxMFEmIqVq?=
 =?iso-8859-1?Q?LFXijFfm3TwaiNTbAFa+SU3z+ALn2EfnwV57o+apNsa0kkmSuBIhuU/6ZS?=
 =?iso-8859-1?Q?B2F50Fg1RFqRHUdQXuzktMy+NGcwwi6Tzmw7kIUy+CM1Hl/BljPgOom8k9?=
 =?iso-8859-1?Q?fjOwceY1KXr7sjPm6eJJwXKdXcZRGGbcpp3iaFuDnr+IN8AMf7VrfYI6P3?=
 =?iso-8859-1?Q?LrmsEDiS0toma+ghgz+vfi8YdnieEJ3X/aQTWUABSC7afb4XCFxNYI/V2E?=
 =?iso-8859-1?Q?SyRe0RJHONzTwMEca1nAbD/f/pl899HizyEjMEXajhhYjqRpcmi4Pp80cf?=
 =?iso-8859-1?Q?ZGX4wON1e1SBusWJrqi4eiJdJMjHiuv6zpRI0knYv3BuoFAqyc+D8eH9y1?=
 =?iso-8859-1?Q?BXfTYWozctBy/qA/zFqheHMLm8phjaU4zkt/n8S9atgV1j+r5lPWqQcYKL?=
 =?iso-8859-1?Q?xolcRQ+tbsjDR7l3qfi1vJIx143rE0+NAUWQLdIPGtWgPOu9kFKThLx3Wy?=
 =?iso-8859-1?Q?m/dTY0TO6TsiVrco6bRqPJw4PpzUgWjxy9r2M3VuJjSUAhpcMh97OycbSl?=
 =?iso-8859-1?Q?aUwByiYBKrVVE5DhxrI7GPQNmS2WN75bNaMOVi3tlj/G1mI8SCA8uqLND3?=
 =?iso-8859-1?Q?g+X8I4T5AZ5Wjd5UOrBN7ud3/JTNegtaLqvfS0Tz1s1y1N/R+qrotZVmF1?=
 =?iso-8859-1?Q?xnDrtJPpbChIanywLrkUoatiq7HmTTh7fh3NkiRhtyQeDWh45HGbBIlBaA?=
 =?iso-8859-1?Q?wUtSSRK84WnLZAVcM0KOk5hpQoVHvhx62Zh+8W2NfvQT37XeBzU71MUEvQ?=
 =?iso-8859-1?Q?BO4Ain12JiFR87vgXMQRXvBlILnnjBaRfE0wYvT+EG1i4X1XI3bwH6+gF5?=
 =?iso-8859-1?Q?sDxnyq89KxU5JiJEk3P5f2mnElXNitdRePkACx2dYlxjjV7Wee0w1P9eOj?=
 =?iso-8859-1?Q?82eh9L+fuICcDXXBVjFgqn6/rYP3z9PsAZ1QH0K2d2nahuDSPThPULw4nz?=
 =?iso-8859-1?Q?gNEXGoLL8sJ++iorDvTHBc9w3TL+frhigAg+SzvAJwV/3xdzm80wjIGbUJ?=
 =?iso-8859-1?Q?N2oGI1SnsM1tNWXOD8O2nu5XiabIBqy0nTXYEErgrNfz+77GLPWSIpuTvp?=
 =?iso-8859-1?Q?CJsHwq6jUcw+tDpIheq8zhR5dEyZunOSMK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994d1c75-60b6-4c0d-6d8a-08dc8a1c386e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 13:41:38.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oI6QTfQlka3fYTRI2+r7U89vHhNHLH7nQTw3X3mfYdD+T7ZiV6g5eY17Jrry8u4ih6JrnQb9egmKDUXznWhRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

> > +             Form 64-bit counter using 2 32-bit counters. This is used=
 to combine=0A=
> > +             2 adjacent counters to form a single 64-bit counter. Each=
 even counter=0A=
> > +             is represented by a bit and setting the bit will join the=
 corresponding=0A=
> > +             even counter with the next (odd) counter. The full 64-bit=
 value can be=0A=
> > +             accessed using the same 2 counter<N> and counter<N+1> sys=
fs, with each=0A=
> > +             of them holding the lower and upper 32 bits respectively.=
=0A=
>=0A=
> Okay, thanks for updating this, it's much clearer now what the intent of=
=0A=
> each file is. One thing that is still unclear whether both bits are=0A=
> expected to be set in count_clock when use_odd_counter is used to combine=
=0A=
> two counters?=0A=
=0A=
When use_odd_counter is set to combine counter0 and counter1, for example, =
the counter=0A=
value will increment only based on what event is being monitored by counter=
0. So for=0A=
counting cycles with 64-bits, count_clock needs to be set for counter0. Bit=
1 in count_clock=0A=
as well as event1 will not matter once counter1 is joined to counter0. I wi=
ll capture this as=0A=
well in the doc in the next patch when I fix the kernel version.=0A=
=0A=
Thanks,=0A=
Shravan=

