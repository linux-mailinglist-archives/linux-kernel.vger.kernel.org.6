Return-Path: <linux-kernel+bounces-569506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1CBA6A3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B29F1899723
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB2A22423D;
	Thu, 20 Mar 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="HeOQ7OpM"
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAD215047;
	Thu, 20 Mar 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467196; cv=fail; b=nvM1V59Zlumd9Nt1zspGBSFHwUSzOMBFEZXy+jb4kqLOCEzfeaoYrOthqrBHarxrdccJoLukveT95ZMQ/6z1uhS8CrRHISemV+nyTiR37DlSYTV47bccpTfbT4/xEMPcLxp4uFYfQG1gqjLHC6jofMGSlnG4PuhiqhehQsw4bl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467196; c=relaxed/simple;
	bh=Xg02EIzdZm3kgQMBaTCQ30h1ss07b6ydPOO5yYMeXw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r/Y+9ynlIPFVFJevzD6GsS83uX3iUlDNd4KJS86A9UrEbkUzbd7W+tcJEtdkNFdycmvP0lDQgjfnH6pVnHLObOk+X7ZU5D5KotGRYqIz+05uFsc1jWp4cDkpKY/Q9Vf6LXFGlN11HpiYXKHw/D+fvfBYjKnJGRrvsSIZPK2nIhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=HeOQ7OpM; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uid434CRpYUTw6W+yFvjbUWVFQmXivlES0y4gVINQferJd05Ovz+sFcr5xjLJqXD5DnMTaCzrI7QKtxU70CwBASPF8AOO1cvO9E3Rwb+CsB0zWvjYRALPs+rIF9yA7P9uSXZ7JlzGz6WKepFmCsOKaDbZdwLTHTB7NA2QDQYMzlXLanHA+4F4346bd52pKTJiMOfl2K4lkeydNCVUMBORM9N9ujFrNpSC8lTzCsU9GsMxAUV2MdKYrWHo2M0LwJT3GENasq7tcUtpdzl1STE6WCep1OIlboMZP2QEdSISL1EMe4kCRVB5KipCCTGZLBe2X8GrR3UDVli2zP/E3MiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRKra4RKXCHhbDyAPeqnrPg5HBgHMzVkALA3j5/i+Ns=;
 b=jHUvtLTKAWa0Ic8kpvxtxlEYIOmpgLk2iAQgOr2xhKVy1fJqFwQHXX19SUieHCI5mDv4DhdO2d6j/sbv6pRnHgOCuzrbdUg1BVKwfu8l3HJDaaNX22vppeDOx7Vgbtopy/sXc9bxdR8X5IeHhRceO8KEwy1G0NQML4C9sAAtAUWQzVCCdDPyhectDhi7zbW37r5TctFb87Xrae3TJ/sQBIn/41p39If41Fuy292mMDP5Z5ZQ5LhHNYkKgD01x6Il26PXhulEm6OhQ8+p/DZZGw9NTUK+n1GT/QM6aWl5WmtFoBwR5w9hkziH80f2fDUYOgV6ER6i1r5Ja3DpIOy7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=einfochips.com; dmarc=pass action=none
 header.from=einfochips.com; dkim=pass header.d=einfochips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfochips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRKra4RKXCHhbDyAPeqnrPg5HBgHMzVkALA3j5/i+Ns=;
 b=HeOQ7OpMHcSqPuuuAqotkBbK9+48uYsNYnzgThl5qu8XvBpI+Pud4dP+7jhcV7dKsIxCdJEp+yFu+biCF4rfT7pATzs3PuV4s/Rz3gqYsky5AcLp38i3I960C1lH1lh9Wdcwc4Yo+TB/jOTXYGR8c9YyWA3DEfd4zSRuGQiWAPA=
Received: from SA3PR04MB8931.namprd04.prod.outlook.com (2603:10b6:806:381::22)
 by DS0PR04MB9485.namprd04.prod.outlook.com (2603:10b6:8:1fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 10:39:52 +0000
Received: from SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d]) by SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d%5]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 10:39:52 +0000
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley
	<paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Min Lin
	<linmin@eswincomputing.com>, Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Yu Chien Peter Lin
	<peterlin@andestech.com>, Charlie Jenkins <charlie@rivosinc.com>, Kanak
 Shilledar <kanakshilledar@gmail.com>, Darshan Prajapati
	<darshan.prajapati@einfochips.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia
	<a-bhatia1@ti.com>, "rafal@milecki.pl" <rafal@milecki.pl>, Anup Patel
	<anup@brainfault.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] Basic device tree support for ESWIN EIC7700 RISC-V
 SoC
Thread-Topic: [PATCH 00/10] Basic device tree support for ESWIN EIC7700 RISC-V
 SoC
Thread-Index: AQHbmYRpANGh5kFjEUCQWOLolkTigw==
Date: Thu, 20 Mar 2025 10:39:52 +0000
Message-ID:
 <SA3PR04MB893164FCD6C4CB8924FC8DE583D82@SA3PR04MB8931.namprd04.prod.outlook.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311-backdrop-porthole-440ae005e8fa@spud>
In-Reply-To: <20250311-backdrop-porthole-440ae005e8fa@spud>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ActionId=dcc2bdc7-1f3e-44d4-b3d7-92646426f637;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=0;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=true;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=879e395e-e3b5-421f-8616-70a10f9451af;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2025-03-20T10:31:23Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=einfochips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR04MB8931:EE_|DS0PR04MB9485:EE_
x-ms-office365-filtering-correlation-id: ea7a422d-6827-43c9-e3ce-08dd679b8c54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HWUiOWjCYzRPfXQOrgiPGhtDZUi0urruguIsdaCDwpjw/XyGyBe06FZQVDwg?=
 =?us-ascii?Q?En60uJsqL93M4Wv9i0B0U32nQT9nWoR4exUyI/YrHCSKCY7zeuIf/wZ8Ar/a?=
 =?us-ascii?Q?RAZ3mEDIf4xTJBQcfO4YwnRftN7J14xC0hX9R4fEOhdBzzCjAhVRB36/Y3dX?=
 =?us-ascii?Q?uHiVLmkXKKd80H0UxShmyEUIBXDXgV0p82fROOiVklgGvE5KP8zgmQIHO967?=
 =?us-ascii?Q?AsjnXb2geFJI6r7DanPesgX+skM3wqdQMcmzI3+KzossDwXNpG15pbhdifrO?=
 =?us-ascii?Q?Su7dwQtwgWc2PheG5BjOm1oomc97x/MnD28nrkvNz5huYzIoYNhbn+B9iv8J?=
 =?us-ascii?Q?ttwFpJ8UyLIUSGa6A5BX1JdLXz82uvdPTuppZSvDn0Bx/GcGsNGutAftAC85?=
 =?us-ascii?Q?b+Bc9g6BElAH2O8woNhH4dYC9dgndMT+GIJn4pGQxqGGrhA2IXuf90urnyD7?=
 =?us-ascii?Q?vH/l2TFQgRrjTBw16ORnqqZzDM+zF3CDAXClP+uHd2fihRYZvGQysPk4wUPP?=
 =?us-ascii?Q?JW/iZo1laJkqd/Vs8o/HoIcGrG16QGYsWwBKGPVuempn95OjRY7dXmJW1NAG?=
 =?us-ascii?Q?DsJrLYuEYQsx3TCaTObfmw4Apw6wMFLQxxrd7LRmicBCsZNR3RAg1W7sEYye?=
 =?us-ascii?Q?eTxXgDwH829PxOAxWQn2gUV4e4/+ziFPldciQ/7Gok8XzyX8UdTasVhRToHq?=
 =?us-ascii?Q?E16hMK2ltiaVYn6JRbrheIdhuFvd9JJmrTgpR+VNzkeFgu6LlQeeFdmV0PSz?=
 =?us-ascii?Q?7FliCE7Abbnm20BrGArYOL5LvnDzjPeSqen+bYfsMjY4TFfm46f5KN6NyQ7i?=
 =?us-ascii?Q?e7krtwaKFeochVsconjpPsT6OMot7gmtqeXH8dsFH4E27UXURfkHvYJr09pK?=
 =?us-ascii?Q?I3Ow3M33pmzNRlzV/rycZ9OPAZZzI5ymRvfz/NqwZYl9lhJjaYLTuDX2Rk1C?=
 =?us-ascii?Q?DyqWpZTFrdZqKO7GJMJjCnijwbVoXtfRfQ5aYzmYaxlEDpF6kB8IxQupNIzp?=
 =?us-ascii?Q?stf/q5tDQuTa4g2tpwF6tu21NXwTMUrBkABvhW27GiHa8SP8e+8xlZAT9Gue?=
 =?us-ascii?Q?1ZQstdBpeht2IlxNAvXNsAv6GCG6IoN6fWBsVP1ScX0gm7svhLJKxgLUjziP?=
 =?us-ascii?Q?tnb8hi/NDK8k7YdRanh5dkXv2AniFnx3HU71nQMe5r/Hnyx3KGcsmAi0KV3d?=
 =?us-ascii?Q?zz0eiOxO2/dh+blU2ifyLXGZfIXFTCFcpnHDhN8KNBTiq/CRUBdmXZW8uTxj?=
 =?us-ascii?Q?lRCukB0drtTxq7Ec8ZFqHWgju3edQ/b9zGGzXeQ7j/ot/hoRF3DDl/tUTyed?=
 =?us-ascii?Q?8L7Qlb1G/haHCJKkzMTUYxnhlb6DcM7fs0JzQ+M41U5Znp7VPpUj3+kYyaOC?=
 =?us-ascii?Q?pTv1YzxkyBL8tWftczZqSUmM2xj9KXwuvmT2Nq6vzIcn1oKhN6wN3zbGPANU?=
 =?us-ascii?Q?nqp8Ai4LuzYFevpQ3YmUtfiDvuR3PCWR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR04MB8931.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s+MLd9qfFt60uK+zKSj2JZnSu3ZiWFQC/6MNXtipiQFEwQ1pHpXD5iUQT74f?=
 =?us-ascii?Q?UAgP9d4RR7bjTwWbkiFp+R0lDSgFbbCHMideW4Dl8XhOG/2KBMmg66reXxjS?=
 =?us-ascii?Q?rmSqHjksFkNxRBLiXtPoLPHz6XOF7mmEtd5SO02cZE1DEa1+mcTKB8yZCE8A?=
 =?us-ascii?Q?qwNLoaIsxYUyGv5HHzpblZ5FCibrHKDoeoRf3UValN/OBHWmV4RI6T8HkF4v?=
 =?us-ascii?Q?XO8Ej8jDyWbJwyX2sxW7dW08GPPFPbXR6COAR7ExsewdCNBL7ZLc8WIRxPNL?=
 =?us-ascii?Q?DQktBAKPO2o2h5LLzGODvUlx75OFec58QmCSZDqwNSTWi+dlu07muFpBJ/Un?=
 =?us-ascii?Q?FroklaJzlrCOgClf1Bvb5Vxvm1JcTlhWHk16FR5qKdOkk1TCjCZ8/mY/iZJ3?=
 =?us-ascii?Q?26psbuf8QVeIO7lj7dbcSV8IRmqNOiyRm/BhFWa2lAlGnRf5B2qoe4H3QtnP?=
 =?us-ascii?Q?SxFOlSR+57nM+qSyEROmGzlaXtwbkMVUtNUvFZxBf76PS4NsxUk6u9qdZgah?=
 =?us-ascii?Q?aASGqRancyZaX6gi/gPKH4p2aN2EXtM51KvxVyBjv09gCrOupqXSsp18pWeG?=
 =?us-ascii?Q?PLjYTHqAt5nzr/oNPUXbDao1GUDwIKZDhclI0AIuGTthgHGvlAPy5t+zpGV0?=
 =?us-ascii?Q?0BdnzdxmKDwIP5eMefxt+im5weGlZAbaYjOpK6rlAvvZS92Gc+3sdA5E44Ir?=
 =?us-ascii?Q?h5sGwf8qQcndsNyrCZoe/6wQFbICj/W+j4Xqn0UgjtxSQ+kFJgzx9BXQpJv5?=
 =?us-ascii?Q?43l5F7RMHuGny5fNiNYA6X5TQq7axxAMFYznzkRXD++RIoG69zyDYi2D4Oek?=
 =?us-ascii?Q?EAy/4+huzuDwQEuWilzRY2CVWM1HqIFyiTnYvnQ+7mFno6MWUY08ZoCV5PSK?=
 =?us-ascii?Q?ZDQfR4BTgdS00wcxdkgG8i9h+rY695Plj0P20lcSn3K5fscAgvvHdHqZrs4A?=
 =?us-ascii?Q?NvE3LozajLKYunZW/AePBPwR86nk624AGX+qUXL9KRoPgR+Ba7JeKT7ry9is?=
 =?us-ascii?Q?tFka1E3kyjK1UWIn0QPLq5LswMgRwXOw75bhyALx5Wi6LRA7hizxlcmiURim?=
 =?us-ascii?Q?vyjMrAse0zH2QU7Qbu5EKpskRERYHDVjuqZvJPinOkTyVFJ1jAoHDLly32FG?=
 =?us-ascii?Q?fBg+1AHiMgYBY1HiPhBwHTNvErwYvQk/vUTEER8sQNif5RkTaMWvAeO3b+3F?=
 =?us-ascii?Q?wtIIndjgf632HUxBWiwQyPPVy/Xe4r/br/KgyZ4g99p645gF4u17tlrywmuy?=
 =?us-ascii?Q?vIvtZZxemUdIKHLgTqQiV8vDsT4ark/nUH2Y+BlHlAhROuCSlHD7HSHt8K1W?=
 =?us-ascii?Q?krWO+m6dqdLsHJlDBB/JTQ/Z5qMlh+piqCiHEUPqviBu2E4+LCuovjIC4c03?=
 =?us-ascii?Q?BRLDmFj4keqTbrJ0z+9k3ghX1J1AFqArrVVfXW+sNI5Dh8F274dxZiGIsecp?=
 =?us-ascii?Q?1xNAevDJrsPcCWZfg9QluDBrS3EzaoLnXGJgPwN/MQFfV+emG4YBF8Sr7dYG?=
 =?us-ascii?Q?FsP1nyjKa101X3qU7P4c7JLXZ61cd8R1yCEN6Aq6SrbJjQD0Yr6LFJwKWfH6?=
 =?us-ascii?Q?3bsXxX6QoUlTiHta5b9NTNDyTmTHZBOFFoDqpFnvMQL4uLKLo013wVf6IG/u?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR04MB8931.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7a422d-6827-43c9-e3ce-08dd679b8c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 10:39:52.7811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnT+xB0GxhqLN3Q3al6MIfb6yfNP7ghO14aesZYviabg2R2PvNkLbEyhNQNgQOYv5j8DzeM6uJCwL+x7os1eKcfr3K90D3QoKaFq9kot0XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9485

Hi Conor,

On Tue, Mar 11, 2025 at 11:38 PM, Conor Dooley wrote:
> On Tue, Mar 11, 2025 at 01:04:22PM +0530, Pinkesh Vaghela wrote:
> > Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
> > P550 CPU cluster and the first development board that uses it, the
> > SiFive HiFive Premier P550.
> >
> > This patch series adds initial device tree and also adds ESWIN
> > architecture support.
> >
> > Boot-tested using intiramfs with Linux 6.14.0-rc2 on HiFive Premier
> > P550 board using U-Boot 2024.01 and OpenSBI 1.4.
>=20
> There's no git tree in your MAINTAINERS entry, nor mention here of what t=
he
> story is going to be in terms of sending patches to Arnd. Who is going to=
 be
> doing that?

We are not currently set up for sending signed pull requests,
so for now we plan to send changes to Arnd as separate patches.

Regards,
Pinkesh

>=20
> Cheers,
> Conor.
>=20
> > Darshan Prajapati (3):
> >   dt-bindings: riscv: Add SiFive P550 CPU compatible
> >   dt-bindings: interrupt-controller: Add ESWIN EIC7700 PLIC
> >   dt-bindings: timer: Add ESWIN EIC7700 CLINT
> >
> > Min Lin (2):
> >   riscv: dts: add initial support for EIC7700 SoC
> >   riscv: dts: eswin: add HiFive Premier P550 board device tree
> >
> > Pinkesh Vaghela (2):
> >   riscv: Add Kconfig option for ESWIN platforms
> >   cache: sifive_ccache: Add ESWIN EIC7700 support
> >
> > Pritesh Patel (3):
> >   dt-bindings: vendor-prefixes: add eswin
> >   dt-bindings: riscv: Add SiFive HiFive Premier P550 board
> >   dt-bindings: cache: sifive,ccache0: Add ESWIN EIC7700 SoC
> >     compatibility
> >
> >  .../bindings/cache/sifive,ccache0.yaml        |  28 +-
> >  .../sifive,plic-1.0.0.yaml                    |   1 +
> >  .../devicetree/bindings/riscv/cpus.yaml       |   1 +
> >  .../devicetree/bindings/riscv/eswin.yaml      |  29 ++
> >  .../bindings/timer/sifive,clint.yaml          |   1 +
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >  MAINTAINERS                                   |   7 +
> >  arch/riscv/Kconfig.socs                       |   6 +
> >  arch/riscv/boot/dts/Makefile                  |   1 +
> >  arch/riscv/boot/dts/eswin/Makefile            |   2 +
> >  .../dts/eswin/eic7700-hifive-premier-p550.dts |  29 ++
> >  arch/riscv/boot/dts/eswin/eic7700.dtsi        | 344 ++++++++++++++++++
> >  drivers/cache/sifive_ccache.c                 |   2 +
> >  13 files changed, 450 insertions(+), 3 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
> >  create mode 100644 arch/riscv/boot/dts/eswin/Makefile
> >  create mode 100644
> > arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
> >  create mode 100644 arch/riscv/boot/dts/eswin/eic7700.dtsi
> >
> > --
> > 2.25.1
> >

