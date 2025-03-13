Return-Path: <linux-kernel+bounces-558831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B288EA5EBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD6D18941C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5281FAC33;
	Thu, 13 Mar 2025 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zk0uPES1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E078F37;
	Thu, 13 Mar 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847803; cv=fail; b=t7Ym+DQ211CoIyQ+UCtZpiTJGwbw0x0Q8W6rbtYfS32i4PekRqNLh93FXUE5ZMlodsItdo9V9+0gyjLEAjjXL47/1WSh7KQ5NiOw6nf2yksEv50WMlkRYNaQgGj4VJTSZle9I7SQODlcuTWW+S81Na/Urrpof/jOCObYJBzC7SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847803; c=relaxed/simple;
	bh=6ZVbTBK6l8M/5ylv2yMAEfoUbHuBs+YEd5L6Oz6QkN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R2Myg9L7YgDkfp6DSfrQhc+kzEWhI5MsR5SSVSrxIAUr/aE8sX0WUXTaDGWzT4V+Eq1gmyFE282Feqn/kTpXD41UOfYZThCruqNL6vNfuKByZDWji3dLGOiE/suMnT95SOLXsQIxY8D81OIWE3OwFoyvb/w/iFjzA7GmsoIGgDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zk0uPES1; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg/xDL6sRh1mEYuzKOBGxp7iYGHkBWB0z7f6Lz+bzQ6bAUQDxQMwOE0FjlrMgBPoQwzFXlQRc9hc6VTT8o111imb04Xgrqkh+9nukveeWMkUTsQPSSXMbnDzvdVYTK7gfKZrJgi39Ul149gtCN4YCX4NpwK6uCjGbwcigfM/ttpziuaV5vtMll174dZefX8K7xDlF8czCciAQ0rFnW0NHPTASiVBnozHsYYe+OwKqth4wEpzqWn1u7MpqcO5bBdMnTMhP/xt85Ur7Jlqpb4CpRwAuUz/zU5l5Gk72BjsG7gEEsbXPxljcFNos1OhZCzKHEZrTmpP5Htf91GDuHmlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9GQvN6eAq5O0guwPtkuvhhGOk5JuU0nmo5VNi6oETg=;
 b=ehoZS4JAph2rgkzPyz1KYpqcQsngCINXfmtBL7VL9b0r/U2Mw21h0xKFfeFthOo/mm3ycskMFgPme0NDE8rZdvuy0IWWESLW3gS5Es9mf2/T6S1I7zx7/nkQVvqGscu37MQjkx43uXfLjRFTPAUc/d2rUan4O85WhQVgqMWPtHgyWxyypSWJApNL7/vNk+OT4dyHxjOFllHu9lxjT9dxiBHdItVzDalU3usA7cniqmCvObVCwmhkIh9/LkEYPR0jkJYP/Vgs95CGrDlGv5aV8wXHELdmtqIG9QdVahjaccUVUzQsMFoHzJjS6IqX0lUnXuDHekpTl7UdqFQMI4mhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9GQvN6eAq5O0guwPtkuvhhGOk5JuU0nmo5VNi6oETg=;
 b=Zk0uPES1WgvV9IeUHWhL2KuBVBkTbuG/6myLsQ448bJmnnaGQ6PK7YY2pWjhAkIHdhuk4h1UgeOFahjJIE4YzByxCGkG1MoRr8qF5wOeloTUNA/JyMO+FF/KBYBYJeT9AZR85uJlH++bKD3yh1akmfFTjRiNgHhSu+46UBk+Vl8=
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 06:36:37 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 06:36:36 +0000
From: "Visavalia, Rohit" <rohit.visavalia@amd.com>
To: "Visavalia, Rohit" <rohit.visavalia@amd.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Sagar, Vishal" <vishal.sagar@amd.com>
CC: "javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] clk: xilinx: vcu: Sequence update and call trace
 fix
Thread-Topic: [PATCH v3 0/2] clk: xilinx: vcu: Sequence update and call trace
 fix
Thread-Index: AQHbe7AMf9305KtbS027DZl22Wzb/7NwzORw
Date: Thu, 13 Mar 2025 06:36:35 +0000
Message-ID:
 <DM6PR12MB48770D3D5731EA5ED4DCCA6DE5D32@DM6PR12MB4877.namprd12.prod.outlook.com>
References: <20250210113614.4149050-1-rohit.visavalia@amd.com>
In-Reply-To: <20250210113614.4149050-1-rohit.visavalia@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ea9f7b2a-afb5-4793-8892-00a36fb27681;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T06:35:38Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4877:EE_|PH7PR12MB8178:EE_
x-ms-office365-filtering-correlation-id: 2b54472e-47cb-4002-10ba-08dd61f96700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3wzyrKqAimS3H1odk4rxLRBKKBXn6UQVIrUMQ16D+Wu2y4yzt5vO8onswfC2?=
 =?us-ascii?Q?d57Y8GfgF0mOY+Eg/4slfvnXS3pbzsSNlt54xWJ04tm5p3G8x8enLoAEVEXf?=
 =?us-ascii?Q?oNNCZu5L7h4HHyivoYZf7YQj9KeWawVKTIFfOmq1e9oI+3MDtx2ojKO1ZBu/?=
 =?us-ascii?Q?2HskeZq+O6ElMfbpF5MszUmVx0YxWnExO6zb40Y/pAlhIjf9vjS/1htItRh+?=
 =?us-ascii?Q?6GC5JGL63Xaol7mdmOX6r0xIZhUJ9l7HC9wQ2GH3X3xOq9hcfDqZOhPGMeUd?=
 =?us-ascii?Q?dW7PahU7l3LmuyEjMwn61+KmAWqGQ5cbgozvCVTS1WLkkKowLC/sRQwLW+X3?=
 =?us-ascii?Q?Zs0DNtHJs2/t3PogYeugfs8zyBqOzbZzKg0hI8UCibLLZsG6vg12R7NLZwyM?=
 =?us-ascii?Q?DK2E0ayiJ9niZ65K26qtnB4zW6PjUBDSga+adLgLGYWEpiTf73t9mpRqARJv?=
 =?us-ascii?Q?4AFQhMJobwjALkebG4a/SVtF4ujowwWwK8KqKHPYseR9g4WjQfPkt9WNN2lw?=
 =?us-ascii?Q?jlJVPJM1goxT7mrNhUTdTiK7ZX8o5ODseQGa0meQq8xWQv1H2xyD2pxW0mwz?=
 =?us-ascii?Q?duD/dM0mjwEp2JYEYTrnWGy7SdOF7UBSB99KHV8P5sLN7TKDV9TkUgrT1WuL?=
 =?us-ascii?Q?czEaMJAzNgq6QKtpIX1VreHRKlkHEm5HivUZIZNEQB6sa4G4CBkBeOnWi0rG?=
 =?us-ascii?Q?3DmH0ytJgQ53iYRUNlPhM/77VK1D5Kl43LK6Lfd2I/9hjGB5bdl79FeUjVod?=
 =?us-ascii?Q?8+CjY5PGOhm5KsUaT7wc6sD+FyA8+Lhrf7kOgPGU9t95BhDaVWCVmWC/k5wX?=
 =?us-ascii?Q?FmcPSE4M4VZ+dZ/v+so+m9qZkK7sduC8nLQnbATXGMysibMZ2Rh/XHvYzs+u?=
 =?us-ascii?Q?eYamfzDQLShX9etM1QA7HJVUOLByorx05VRpe/7DIwzho2I6BT1L30UmscH2?=
 =?us-ascii?Q?a9KX0TJwOT1/p62p+21eKiQtD0bgcNdKGpxwp/10zJnhcjnSoXjwpbOOO2pY?=
 =?us-ascii?Q?9x74FPoEY9hAI0LImkmYg2iDI5aDqLYFxUsCkcWFDbOq2E8NJhE+apPQ4X5n?=
 =?us-ascii?Q?iDXZj/ayp831vWoslJW3kGhiEw3ca0sIlkxAOdfQdQeTnq/9s8IGB1dKZWvn?=
 =?us-ascii?Q?WXXZlMHIkHXO/yLS8dXAbTnjcbJQRZyQN13+vtdyscHV5jfRSlp7mjZSSN6U?=
 =?us-ascii?Q?NSsRCy1SNNZFFCQFMbhXx2ZwcP4f6lb6VTOD3hF6iPy3bqfRU65xv+VERsfJ?=
 =?us-ascii?Q?VuNoCIN9TT3ng6IqH2iR80kFoyfSeskjCVYHjGZZmCzJD0czLiVnZM2iMx42?=
 =?us-ascii?Q?IBd06FZW+2zNm64T96Z13rYe8ZVD5f+BE7D11UGqCRPMVtGsq4/MzkEx7+cb?=
 =?us-ascii?Q?po5RMIW+D+3VxEhj/uT/GZ2sKrpemBHsX28sVcE8Tvmp6pOVAodLxnkOEg4X?=
 =?us-ascii?Q?Q9RBTQLFbypr3jCNIPVzew6AnxfwrxIB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4wpwLmQK2OaMhHhhZFNWLntoE9nodt7TJGU/WPwcLyQsoNe8ej+lRTlQMl4I?=
 =?us-ascii?Q?2eSb8H0o+KIXWUXtRfl27PJc06NfFgNTuaEZmujD7rrzNkf1OHgw+GrWiqEL?=
 =?us-ascii?Q?uJzteNoM2MPQe9qhfGjZRBsWJvF1XiEXa936o3fAcWeoacd2VsgO1H+kNSl1?=
 =?us-ascii?Q?DBDvrG3s+j28NzovoqYyoNKLO5TE2A6pkHS74rpTQvUQPYHhYRodVrqdmbAF?=
 =?us-ascii?Q?7aUK8CSbSeV3OyB2inJz/qTB+9z45nv3UMqdiBNMiynxr+BH1avKpQn5FM3L?=
 =?us-ascii?Q?0erAWRlAluq42XMyQNoFRepmahyhFBfcBYUPve8y43ECUwosa7KSXCd+xZss?=
 =?us-ascii?Q?R9KT07S06GFWQQhjF5nI6RHM2YWoVH19OSQO594HqWOOVWW33KhwvSFtRq86?=
 =?us-ascii?Q?W2qy1Y+mJAluIF9ZNZ2sGsxeGhJpuOov+KCHnjgsEL/talINhNQJlJEsy9K5?=
 =?us-ascii?Q?MKl0GvguFM//AaIP8i+PWJO/v22pPDQkEQjHHeRa+pq8JCKWrwmDmQt+Vkwj?=
 =?us-ascii?Q?4mw6H99BnL8aI09ihvGCRFEDOYdeVFVwwNyhO8QhW/l6U7d9KIDcaACl+OVi?=
 =?us-ascii?Q?vhe+EsZZUhs/zs/8m0TyaCFLia1JSs3VMkzFCVcjfg+Imqyc2LpPlIQZh3EK?=
 =?us-ascii?Q?ScUtzXFofForOl8zcN5+KakhEuP5W0+w5/QJSJ0hLRx6x7pvT9Oh2qP4ZfpR?=
 =?us-ascii?Q?fW8MTNGV5FTlJFRlf0IZ8TnXgmR0KaBKQ60i8TJ5Ee+g2HqX3C4EixYih24D?=
 =?us-ascii?Q?0NcCOJ+AfiA5uGKeTTNSUHC3wxgaN2Ud0bdaoluRgRl5mUtdMNriM9A+OCRm?=
 =?us-ascii?Q?KeZAHI/YjnhOjdk53KVnmnLOHCORHYOeHsYbJ6OgFbdnzHGJUzfY9M+SrMRV?=
 =?us-ascii?Q?cHfriodLykbdKTzH8lWVCBQFg+y4gP6zX5OLQZXLxzkr9JJUKnXnIHK2kEvZ?=
 =?us-ascii?Q?Mfl6IdYWSF9xxoCepexyCcDVq25mJodRQRL2BAKQr7vyRRv7bIfh/IVJb3yi?=
 =?us-ascii?Q?LqoZIiapjrem/awsYCvXRRQqNPGU8KTcAbxi6mpeAlhp8ErMUUPSvcoCTn0p?=
 =?us-ascii?Q?/kYov8R8vw6QeXJjqzb7odifu5757oua9QlXGaUhea2sxmrNxpZJex/mYYYK?=
 =?us-ascii?Q?U2axVfM+yljyrAAXUl6EFUs60tUQIhwZ52noA9kUc3pOOEsTOWzwhAD5N8qy?=
 =?us-ascii?Q?Ky/CEMzYuch9m6Dw1Nt0JSb6jcM+qYBNpuaYi+IXNSV+wTb/YPcR8DxN6IjE?=
 =?us-ascii?Q?NpA75LoQpKjrbtGuVoWxY0ZNQlc2vzdtvuSf6fZCTP9z4MJxK3WxT6pvuCEQ?=
 =?us-ascii?Q?WJOcpaWVJH9/XWDJZNL3N7OZrsi5jV8m9pUHAZDnoVm2bQmIjqABXIysJFS+?=
 =?us-ascii?Q?VaHvTrKnQmo3GQjBRpvWxQGTPF0jLb0DoGqzyu9GEDiOE2Nn/eDpi4tCGUwH?=
 =?us-ascii?Q?2Bz3R55zGdcPiHVaP02QZTWgTZXmHFnHYDJ4XHcieYJ4QyYxNGQoDMvZiWis?=
 =?us-ascii?Q?KlVCLkvFpOabl/GtPcALIOw26eXrfy31V1jJ0tYQ7KXwP20lDdJlCvZtmbK0?=
 =?us-ascii?Q?yeiVoj+TN/thJmrepus=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b54472e-47cb-4002-10ba-08dd61f96700
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 06:36:35.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7lngKExtEgnR6ncVrnLsoUCZG3qXVqTvPJBswNGJ+DgbpDztgUtrygrp2fF1gj9K3aVAAfJNHxRo2AL7oD/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178

[AMD Official Use Only - AMD Internal Distribution Only]

Hi All,

Just a gentle reminder regarding this patch series review.

Thanks & Regards
Rohit

>-----Original Message-----
>From: Rohit Visavalia <rohit.visavalia@amd.com>
>Sent: Monday, February 10, 2025 5:06 PM
>To: mturquette@baylibre.com; sboyd@kernel.org; Simek, Michal
><michal.simek@amd.com>; Sagar, Vishal <vishal.sagar@amd.com>
>Cc: javier.carrasco.cruz@gmail.com; geert+renesas@glider.be; u.kleine-
>koenig@baylibre.com; linux-clk@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Visavalia, Rohit
><rohit.visavalia@amd.com>
>Subject: [PATCH v3 0/2] clk: xilinx: vcu: Sequence update and call trace f=
ix
>
>This patch series updates VCU init/reset sequence and does a driver fix.
>patch1 fixes call trace related to pll_post clk.
>Patch2 adds optional reset-gpio support.
>
>---
>Changes in v3:
>  - Removed patch https://lore.kernel.org/linux-clk/20250102170359.761670-=
3-
>rohit.visavalia@amd.com
>    as it is not required with latest xilinx clk driver.
>  - Link to v2: https://lore.kernel.org/linux-clk/20250102170359.761670-1-
>rohit.visavalia@amd.com/
>
>Changes in v2:
>  - Changed patches sequence to have patches with "Fixes" as preceding in =
order
>  - Used dev_err_probe()
>  - Moved warning to dev_dbg() and updated print with more detail
>  - Link to v1: https://lore.kernel.org/linux-clk/20241226122023.3439559-1=
-
>rohit.visavalia@amd.com
>
>Rohit Visavalia (2):
>  clk: xilinx: vcu: unregister pll_post only if registered correctly
>  clk: xilinx: vcu: Update vcu init/reset sequence
>
> drivers/clk/xilinx/xlnx_vcu.c | 33 +++++++++++++++++++++++++++++++--
> 1 file changed, 31 insertions(+), 2 deletions(-)
>
>--
>2.25.1


