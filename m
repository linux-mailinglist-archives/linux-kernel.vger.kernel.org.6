Return-Path: <linux-kernel+bounces-534723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45370A46A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A94516D846
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726A236A9C;
	Wed, 26 Feb 2025 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A51fNAdn"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C8236421
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596230; cv=fail; b=bX20cVqjGm2zGPuhheaaZx8jILS0xfDh3BjYvSr3R1VXKvhi+BwA8K9sCJ18NUvagUrGUcqX+VF4QHUWH6OKrZzbTheOJf3J6uRoOy6SgaO2th5DTe9nRhQtXpP3P2qZI1uFXtpSD2927qlwkrxA4G1hXrf7J1pPG17nd4wQVtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596230; c=relaxed/simple;
	bh=/O95HYEvshFw+5QYLfuc0LKgPUJNNm9dc0ALqdkN4fc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZddE5w2ij2OetqfH12h2GryRlP49pEjeMsVhRZLQb3Zwb7ZoTe4sSvR+3MNLtr8xXT7rbHIBr/KuK06CbfDjucUfF7AvGVK+yemxwOqLyakZ8g/sRRGC+nGVhtoTRqZTwuFOXhzJElaSLg5+g1LpES42dC4lxMJYqnuugBRPn+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A51fNAdn; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPKHlycp1FnBIvwh1M68HjCsAzgSLlTxrtLXPleHK2P1c2hcNXu//rVar55EMVA5/fOPr7kCKpWRVxyPOjBVL9PBglysJIJ05rBmgvLTGOoq/iajHjjZCl6be8KRRCpNY6zf15XlK8bry9kiLmTEJI3vQ+lqK0+Ha1WQKFlvquPxFovjAy502euHS9F/tPUK5J74Hojt0vS7T4geMzZEz5SR+atoUPZDxNGBocnY5TwdAUO5y18M5vkUdIec3HdCofaeLy035djRNO6eOLm22GSPGtVUh7EzGKh9WLXZEF0knA5gF/KYSPXfKYc19PaVj5VRrEj/TCvtig7nnWjMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECvCHEgMUUjQhV7OJ0pjP03FNvoyaJGDYA9b5rezlfo=;
 b=xY+yN/epNmnymbqSXmG9Sp3JYtTm1MeT6RK/q+h19ykr0JyLq6bwjzS6cyovq5zYMtUVz8WNRph+cNXlp5ATGk06KsOeinmXTddCiREBSWTC0rql5WOMJAazZaoCDK89zzeJxkWO3ojodAXFvf5+rjBa4DuOkaU8zSpfjE6twubouzMPvEogSIkMjwGpnXdtcovbyp8p+eheR/SfLqr8z+02yVPvZ3+Fml0Fa7eonoWYzC/Rx4nBRdwEMQXKY0Vrz/OjEt2bs3B4/UUPRievQKqKGmiAbc93AHc7O/pHsfR+RBt8bkZ/lHLMSAlK0uPLmJbBBJGc+cYjPNM+nWp++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECvCHEgMUUjQhV7OJ0pjP03FNvoyaJGDYA9b5rezlfo=;
 b=A51fNAdngz3IwH2yBFUx3wVRnGRNuornIlwXEkPSR0eza+P3ZJe7SVm8cecs19NxW90ootuAz90XIaSixcSYOysFGEqSZlAFNdrkwQuiCt66qOnXXEiTF5YYY+DjXC1LkrM5oa3HOi3jbdpEV/M9gxBHCkqv+nANj+KGl4MBvsw=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 18:57:06 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 18:57:06 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Topic: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Index:
 AQHbfK/msIIkfjoqOkyd6FXsW3bSnrND631ggAfdInCAADBpAIAAAIOwgAA3cwCAACLxwIAAWYuAgAAd6ICABAIeAIAJN77A
Date: Wed, 26 Feb 2025 18:57:05 +0000
Message-ID:
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-21-david.kaplan@amd.com>
 <20250211180752.pfsjvz62bztpnmoi@jpoimboe>
 <LV3PR12MB9265804700AB74A446F5220F94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
In-Reply-To: <20250220220440.ma5yfebhiovkqojt@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3efbbfec-c4a0-49cc-aecf-30c929d116f9;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T18:50:31Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM4PR12MB6254:EE_
x-ms-office365-filtering-correlation-id: cbf6b765-f877-498b-7a15-08dd56975d43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XhUDWUZtHlYH0Z26vpem+j1E2cJwYQRAf3qkltdZNhvRy37yuQePt8tH/iOP?=
 =?us-ascii?Q?bs1TvGnfRFRlG2F/b8StyKkCXohWLWpqMUAt8181xfpT4/HBcuOEOoH5ygmf?=
 =?us-ascii?Q?lZZx/3MwtUJAam/y1cIQh8gdk3Xvh5U64TnGuyzpSybsBD77MrbmesE6hKpQ?=
 =?us-ascii?Q?sktyR/dOF3tVdpscym2cDVgeBMAljAYu+JeVr0Dymncs77LczfEbDDzKQl/g?=
 =?us-ascii?Q?m4KMvwGkxX/HiJZqU5SWsQxErFdWsJwB59zVng5eJCotG6yI4Ja/FipSSl2K?=
 =?us-ascii?Q?6tZPGekydQQI+/b6fsBj2Wj5D7D98Mr6rchJSGxoq3sKd6H2dQ2nfMd5bE6k?=
 =?us-ascii?Q?ayjZsZCTaLTumt/k1Byndjp8/pMVkBhHyaYt3K7je8MuI0TwvbdybizI7K78?=
 =?us-ascii?Q?WwiFHmrgmxQ/0Lewi9a0B8WVo9z3BhLU9mZfWhwYeU5ZC+vEDDYg8o6ww5F5?=
 =?us-ascii?Q?nnhD98Oq3QWlaE37g0p+1OBiwf7ogQm3691ypOQW6lDdaXQy/Dj35AFswwGT?=
 =?us-ascii?Q?y1obJhLZJkQkLyOD12EwU9K9hSNho/pGmnOOo9RBGmZC9KWcqv75CyPV7zxr?=
 =?us-ascii?Q?O2Puqy7O2Sx1R7LlA5IQX8/zdKYlC0n/gxPaMq5jyxcSv1gpmHzN0qZtrW/z?=
 =?us-ascii?Q?3hNcP8dFwXf2PIutIMOlUmll0Ev3YwESAYH7FMtk59a7dXg5YWHLKmFcPi8k?=
 =?us-ascii?Q?qopx+8BzaibJVtPlA1dhzJxSIEqkRujRjOVAPVAGSmadxi8C1SYdnFZnFSpe?=
 =?us-ascii?Q?LUFjjo3EK9BxN8yp7KtBpfyytOlXxgQHr2nrlFmKHbIaHRhUL+/FiG61+T8T?=
 =?us-ascii?Q?GIDPkm1700xXLQb0j7GP62CReeh3yEzdPdGiEG+pWxfwZxKUJbE+vdq1ZY7o?=
 =?us-ascii?Q?ORqU7f+seDjl3zIOWIkeZunIz3RQXPV97uWgxFwOQDaZY21hCR1Ulbr4Gnwx?=
 =?us-ascii?Q?zsr/PXG13+RKgDSFd4B/z35WkbufvwuEi9Blfuccz4fzoT4YGfCdYKEfgYQO?=
 =?us-ascii?Q?99QurKzAMrYXV0srfHvxEed3vMjzO6ct149RtGZGcVSjqH7PEG8kwopkXRXR?=
 =?us-ascii?Q?wZA8BF70PhiPsS91fy5vvIN7oPPZdbd0hcJgRm1qvF3miECyJM/ENcsvgjFS?=
 =?us-ascii?Q?px1FMNTym72Zmeqn/L72IMeuoZbfbaJg5n9ZBk9QN6SNXLGe9u9os8HLefpJ?=
 =?us-ascii?Q?3OaTUV6kJtlHVngkhsEVpriKziAyMoiFnYU9LQL3880GtAEPz7NIDK7DAKQL?=
 =?us-ascii?Q?lTFZtDYKdmWL/qYCNQ+3dA+avshgEazT4bnueGdNi/DtyAAuUnZiEV42kCS4?=
 =?us-ascii?Q?0uy+NG/D3A81G7gaS66Jn8hqNDilA65MEKa38XciRVOhP90ZCEjIZiHLhlff?=
 =?us-ascii?Q?gnYWmDDuW/Wo1wGtNcCc3VxAJf9HAf+ZzdQXrjDUat/6A+zPHQv0RKTXLwUE?=
 =?us-ascii?Q?jS9Iza2+rYFFDzjWuZoeeeI7IYreMSYj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bn6kejjQ7fXKhlG3aZi951VcirkCdAJaxBT+NaV1N03jW3v4Eibr5qkiqvJQ?=
 =?us-ascii?Q?w7Sba3t5XjW9px1NOTbfCKzl0pJ3jceqH2ql2rg3qcDF6ER7rmX11IArU+X+?=
 =?us-ascii?Q?D6425GnRlH9jFdZU+7cgzjxG0ICYPaKwixup12apy7UalWNO+4SYlTygiHJI?=
 =?us-ascii?Q?1c3/aJzgp4NCwb5NV+bTKhiehw6l4qWCVJ20Fk64vN5ejl/RqkkBpI7YXFF9?=
 =?us-ascii?Q?HxXeJd88029ZcAM+CkpQhzR9/SHqeZAieIbMdmJsY1TD9zn6K44lWQCpOpIW?=
 =?us-ascii?Q?PaMq/BAuO/U+dk5tLboKoeBfE9JLQsgH67KjezUhDDWWPbpGQ94ADjdzylL8?=
 =?us-ascii?Q?yz6PNohnjfxwjSRpPv8b636OLh6TS1N4TuBR/LzhnPNZKz9poXWAOePyI6Pf?=
 =?us-ascii?Q?5dEgyAkUAIazMcrs2lrvoYpDB3/mVpccDQxjd4dopqlRBC49mrHwzPRcJdBN?=
 =?us-ascii?Q?JRRi/XzIwG+PK+D27JyZihJibiG46TVzWM7yy2Svn6h8E1iBdeGtpRReH8kI?=
 =?us-ascii?Q?yPtwIfzYrq/NKSgHnQBfYb3oTEchCYRPOf3VnxbdqOYP911hzLd0EVqP7A2U?=
 =?us-ascii?Q?tmPu9J0tB4OcrtUmdZz7Qb3fh5hZESi07hGqcbIZx6PZrNJvjRkpydT6rbRA?=
 =?us-ascii?Q?6Qeda+CZNsq+htEay3pTY+WUT+rtXnApCDrWESy0IBjZHgWkVwx0lXkyV3x0?=
 =?us-ascii?Q?PG9GwtAkd/NSZCtdLCOeMcTg5NhNpp3/HbpQZO0GawrE1wx8KE+qbzDwDiHs?=
 =?us-ascii?Q?P4evGz5x9ufiocJI9cDl/JnUBWzQpOq5nHdqh/H/yguhJe2hdJq5kjq6SLxY?=
 =?us-ascii?Q?vIDWxP6DDuiR1esj/nlvTIckqzI8U31hwURPmE+88pZpm3MHqUfcrQTQP31x?=
 =?us-ascii?Q?vQ2k6Cyg33Mj/QTXPesQ1eeNcf19A1GhWwkO59XP5oVpv7Rb8SVAPOiP3+rN?=
 =?us-ascii?Q?1waGDbnTnO3B49oZSe1Kwpkl4O9BKvpVhc5rS0g6l7B4r2NpciuPdX4Ae0HR?=
 =?us-ascii?Q?Jsd8HKTE/0OzTyldQ/Vo7vUeqaRCEDCSLAryxcrkFBPsQvTqBlhV+dyny1FE?=
 =?us-ascii?Q?vcQcmvBeT94mt6apc/rWYo1Cld0EvUi/Eyh++kt8DMrtkxMjMOLuIMSbIfyr?=
 =?us-ascii?Q?uBCgH0tNvyghgLcxbnrcdJ9UhbbRyCStqZllOdw49rR7OhI/LFthI8gN/mnP?=
 =?us-ascii?Q?UpuO1mgf1k0RGRRkdoZ8SvDZoVOtKfs9hEzaGq3sF3TYH2IepRGtKamr3Ftf?=
 =?us-ascii?Q?xrKCg18HFsdB8yIfZE5At4sB8S4cMw5rKUew7VzizepnFpM99B8tXh25UjpC?=
 =?us-ascii?Q?QgZXGsseFRPYXvYA/YknQ3gsw6D7uEmxxC9v27JgwUz04hwNe2gmaPPs3uEW?=
 =?us-ascii?Q?6hDAimZU9u0uAyHgJV8xOqZ9o5NmBIYM4yjpxX1Sto/WGPIiRGQMjKotofJH?=
 =?us-ascii?Q?7tLxXXd0WZM4kYOjeL11xBEyLy+ODPPTBYhZEmZbRncqKHQfN4RXN5ngNQ0Y?=
 =?us-ascii?Q?UpKMHkevPt5mYNo9ztvOEjOStcwdzXaK6uukepXkL7foTB6rhspUJ17Y10jI?=
 =?us-ascii?Q?MgS56Zo3mv0UiksN3NU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf6b765-f877-498b-7a15-08dd56975d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 18:57:06.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55l2GKmovj7Vcotap0JIy+nmaQ7vnRmwJkoMc1wGVxFLOGsPgdwU/HyrV/pGuuX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Sent: Thursday, February 20, 2025 4:05 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
> <tglx@linutronix.de>; Peter Zijlstra <peterz@infradead.org>; Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Feb 18, 2025 at 09:52:03AM +0100, Borislav Petkov wrote:
> > On Mon, Feb 17, 2025 at 11:05:01PM -0800, Josh Poimboeuf wrote:
> > > IMO, make them generic from the start, then there's less churn and
> > > it's easy to port the other arches.
> > >
> > > If we went with putting everything in "mitigations=3D", making them
> > > generic would be the obvious way to go anyway.
> >
> > Just to make sure we're all on the same page: we obviously cannot
> > enable and test and support a mitigaion on another arch like, say, arm6=
4, or so.
> >
> > This needs to come from the respective arch maintainers themselves and
> > they'll have to say, yes, pls, enable it and we'll support it. We
> > should not go "oh, this would be a good idea to do on all arches"
> > without hearing from them first, even if it is a good idea on its face.
> >
> > That's why those are x86-only as they should be initially.
>
> I wasn't suggesting that this patch set should *enable* it on all arches.=
  Of course
> that would need to be reviewed by the respective arch maintainers.
>
> But looking ahead, this *will* be needed for the other arches, for the sa=
me reason
> we have a generic mitigations=3Doff.  It's a user problem, not an arch-sp=
ecific one.
> Users need a simple interface that works everywhere.  That's why I sugges=
ted
> integrating it into "mitigations=3D".
>

Talked with Boris on the side, he is ok with supporting this in mitigations=
=3D, with a warning message if you try to use these controls on yet-unsuppo=
rted architectures.

Going back to the command line definition, I think that to help make the se=
lection clearer we could consider the following format:

mitigations=3D[on/off],[attack vectors]

For example:

"mitigations=3Don,no_user_kernel" to enable all attack vectors except user-=
>kernel
"mitigations=3Doff,guest_host" to disable all vectors except guest->host

By requiring either 'on' or 'off' first, I think that makes it more obvious=
 what the default would be.  My concern is something like 'mitigations=3Dno=
_user_kernel' doesn't immediately make it clear that other mitigations are =
going to be enabled.  If the correct format is not followed, the kernel can=
 print a warning and just fall back to the defaults.

This format would only be required if you're going to use attack vector con=
trols, of course.

Thoughts?

--David Kaplan

