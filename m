Return-Path: <linux-kernel+bounces-417476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C223E9D548A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293AFB21172
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01281CB9EC;
	Thu, 21 Nov 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RxKVqXOI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC071A2C04;
	Thu, 21 Nov 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223408; cv=fail; b=r6nd+d4rcJBODZyA+np203a09oMAqYRZHlbDZK6zZXgeT2bVBWbQHa65a3KTwpdgu4DlbQ+y3Le4UUMmjfoqwAE5NfwGqdsDFR1IDxd+R5QuHmuYuSjE4cZAiMyg6pMvsb5e4YCxpeQYjfxWHr+JuU3v+cxhzbRwxYwH6B6e62Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223408; c=relaxed/simple;
	bh=Hwg9ywIMYiQe7crGeKCdu0jM6HR+ofuB2KyH2Ez53Vw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sOLS6UXHNZjLg6hPB2qAAVuedbLAEFJdBU6BYV+DyZ+8sQgBrozhEWeHr04z0FPEgmT7mPEJqj4BypcMajjexSaLeBTxgLUCu0qYTw55AfkOUMxWiwiZYQmYa4jBh4RUWecGS9HXVPPJXuU++/rRoXC+E0zPlzoFPZYSjHWyAFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RxKVqXOI; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPBL+Hkb7v73Ngng7A6WMpkgym1Onc1AWU7KzxhYdwjwBYsnRGbdF4dgKlWy1hUPS13FeOjDXKQWbDb6IrOiwjUpFm+qVVuSIEdFKCSeXGbc1HgZhBWBENWbbWemMPPrYnh04KLisDWgn6hdVnxLZYcULAJ9EIpLWoumpsV35wfWYRGdGTAcuZ4XvkaCfwA2Ys4RYKhcGhWG3n50hMGQVLG7ChB1LjJK60V3p+zcUA9CMQmjsxwCH+eftYLY3xcpqeQhTzJ+/OtrfOhjhcHl9xHwW5z5K+Vvkg32F/OrEGy5nNvatq/0A6gWGFXI5ihkZJqBfHacr4wtZo92l4jefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgSc5phI+m+P6c9488x/CWagQboPxwn190+yXg6Iuus=;
 b=NjxKppXrlOsxHDqXE62SuS3vtmzUQghV/ovVMs8ULOphWLcQk8JTrwwVohSG1q9ckfMxabf3fZCM4Z+2dH6NTU/yJuiivlapTpLKket4mPTv8Zw3f4O6dZGcV9SjfECts4ld3leQrsDnSv36swvH+mG2wqdZWKUzBhKtdac3CRexYLiVguR7CaWjbdYB2uyuXLQMM8CFKwEN7fGn8XEx5cnZWaRlvAkf1vFnZty5IWkqoKuZwjySJsp8L7ozB+VgMwbvUvEY7bz6bMHhWRiwZWKZgvLbvFClNGb7ib/MmSl2Mv7zyrsdTFFja4VgnehtI98FKk2yqzvq3zYBW4NvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgSc5phI+m+P6c9488x/CWagQboPxwn190+yXg6Iuus=;
 b=RxKVqXOIGpgrK4DhTZG/BGl89gNLQu0J1zb+6cGYsIt2vBkodONolbPQ1y2KhqTHuw4pIQBmTGQiqPkexuu/xyHJ9Z2zXRiVK08LCX3SRSv1pwYHpB5FNe13Z4VjDIm5XbpEi19f9lStYKEoAcH1FCu8UALmoOv2sZMKxUTfkljtf0zHMFh2ioM9cRT6Yf2v4ksLI2iDHkvWeAH0R9ckZFLLNL009lixS+rajpj1LTVesc9xL4UXR82RYWRLzk+qBLO5ycWHzZWMxHSyZOMHuometAJZK1/Mei4Vs08Z0F9SqjvE6CiYbldTynCKk7lC8Gjio0BBkrjIlwt6RznwSg==
Received: from MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.17; Thu, 21 Nov 2024 21:10:00 +0000
Received: from MN0PR12MB5907.namprd12.prod.outlook.com
 ([fe80::e53b:7416:2158:6950]) by MN0PR12MB5907.namprd12.prod.outlook.com
 ([fe80::e53b:7416:2158:6950%5]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 21:10:00 +0000
From: David Thompson <davthompson@nvidia.com>
To: Pei Xiao <xiaopei01@kylinos.cn>, "hdegoede@redhat.com"
	<hdegoede@redhat.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] platform/mellanox: mlxbf-pmc: incorrect type in
 assignment
Thread-Topic: [PATCH] platform/mellanox: mlxbf-pmc: incorrect type in
 assignment
Thread-Index: AQHbOyEStfwJ7V3SRkSuF/aZY8y/r7LCPP3w
Date: Thu, 21 Nov 2024 21:09:59 +0000
Message-ID:
 <MN0PR12MB590751AC951287F325FE26BFC7222@MN0PR12MB5907.namprd12.prod.outlook.com>
References: <202411121935.cgFcEMO4-lkp@intel.com>
 <fece26ad40620b1e0beb733b9bba3de3ce325761.1732088929.git.xiaopei01@kylinos.cn>
In-Reply-To:
 <fece26ad40620b1e0beb733b9bba3de3ce325761.1732088929.git.xiaopei01@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5907:EE_|DM4PR12MB9072:EE_
x-ms-office365-filtering-correlation-id: 2a4e9c00-69d4-4ec1-cf67-08dd0a70dc1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O3ea9/SnZt5h5mgHT4RqbVoTFb5xSD5pNo0GtBZpMde9xf5OHKc6H3stpooy?=
 =?us-ascii?Q?UwCa/y38p/NHE19tdH4PjB58gzokbr3xffj1uymxnuHYQDjt4K1kvngW/chP?=
 =?us-ascii?Q?bvQesWr2GcdBoNZBc8A7KzxWbzltnviDvo2AR+6nQi9JwXbFHnwbPge5SNJC?=
 =?us-ascii?Q?s2ntzWbijDLbnhXCiUDjPrkEp827XmpgpiuEMS8nkb06H0pxhIsSOAQ0H5Yv?=
 =?us-ascii?Q?XROsZ6g2Q6kzzjeD9WAp5fIqBOP/sYjGSdCs4bMBsgkcrO8CStosLYPHSNSg?=
 =?us-ascii?Q?VJ6BE0wbrRpWempnXyWofjg8r76Nsfgn+gVWKX1R99wc7SOOgOS4stkudrXV?=
 =?us-ascii?Q?yJYGONVXHQQT7a+/HBdsAFGXkpFq7hqXnMuSoEBVDCT+uGgRyn02WJfCHEBE?=
 =?us-ascii?Q?5supjVZrHMY9vW27rXNpzV2VgxU6y7r15J7HM/kqsaAoGf1B8M/TpW9RS2Sw?=
 =?us-ascii?Q?QbJJv6IHGw4FQwGTkbusul+Vu3ADEt4rK3wjUYT9Gm3SfTpdM8v3QqhztYlW?=
 =?us-ascii?Q?I6IQnqPxjQB61WDytKY0UPsDB5eNLenNBXnlK2OAn5MK2iC4hAiD8iutzDEr?=
 =?us-ascii?Q?13+PWrof1jXWsBS/enUaGurt17IZzeBf5hmhlvCqXK4DUK1V99g45DJMlay2?=
 =?us-ascii?Q?T+yO1sjN2KK0TaQvKy6vszrWn0J97AN/e50LB5/vHuPGkf2zXirreCNbH54E?=
 =?us-ascii?Q?aMMGk92X+21Junhn57253KmP/dKa760GBd10L9fsEwW8emJUWXgEW/vAtyfA?=
 =?us-ascii?Q?nct5dR2BXn+KcFkE8tU6iH5Ew6TmFLFjD0UzMmjG7iN/JQu/Pn3YpuYkKrO7?=
 =?us-ascii?Q?zVYVu7dgS/mnTHsBvHUf6cjiH1wCb9URUMt4RN2C/MZJIky5JRI96NU1qxN5?=
 =?us-ascii?Q?7LMYIrfxG2CkvZ7aeMo/X1/Sc/j04OLE+tcoQyaJNdSZsrh2ZtN0psG0/1vk?=
 =?us-ascii?Q?IRR0YlOhP5vj1DyJdbCETN8dRwLObTT0y4/PB0dHl302k26p3KXDCazugovC?=
 =?us-ascii?Q?z45qzFWtwX9BehFmnfDIBX6WQvNEYWnjQZY5z3M8qyrCBrsvOkQZIyJFlDS8?=
 =?us-ascii?Q?pWJeYWw5aH0In6K2HdJwL0c8nL6vUFHjQHVPfLL0HEUXalHCzEhIaD4NZzKo?=
 =?us-ascii?Q?MmCSxZm2fKfSez1fk9uENHlihsR1gn1+Y+pTu/R+DtMFGM5csKdDwaKkZ7Ps?=
 =?us-ascii?Q?PzaSFHrQVJl3Nj64EW/dzaidNl5luDnMeaj8ZJxUwVvJzIdBS6rtzDHRgT5C?=
 =?us-ascii?Q?5WG5JrSDkbeJTHd50FOx3ExbGAYa5KwzSHmwKJRRjcl8iSrAKz2b3UIE1SdA?=
 =?us-ascii?Q?XUMuE0ROPgeI1m4sJ1knJpH9lEkNz6VD0jfu37DslJOqHe+fEeM5EGClpmev?=
 =?us-ascii?Q?wPvGgT8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5907.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zNKa7yhIjoOCwrtoWmeCjvgii05j9s6PuyITjbwn/miXjiC2yepzQRlTXkP5?=
 =?us-ascii?Q?2wwZ21pocNC6+hFoA94V01CkhCsyJAETa/vca3F4734Dwa78JWsdqNbXTrjR?=
 =?us-ascii?Q?Vkd/+YXFCGVN3PczJdIkME5oI7ekWERey7MUUEQe0gEDCPC7kiMlfqhtzPBS?=
 =?us-ascii?Q?VJbxe6byCCqs4kIIit9NrmD05GUSvMx2q53/Hsi9uz8u2m55GWU3HR7X/6iq?=
 =?us-ascii?Q?gzDUcAiFVdoRRkx57GgU5w5SAVCi31HK37A0KB81Z1X1dzDXboLcqp8zzoi+?=
 =?us-ascii?Q?NBKQfAsCQRCcOKGGMrUjYH8abPKnOsUvBxyVliceA+fG072iPnk7/XNEPAWz?=
 =?us-ascii?Q?LSn95EbdxZ+CqVeP0I3Y/BgEVXSkH7Sp9YIqj4/8Zxl8wFbLXPXTG6ohNAAr?=
 =?us-ascii?Q?itWHdE8dEpLP3YAx9EN8Kt4cmLbvtXAg1947bEXOwCDr76x0bAjcj4/uMemh?=
 =?us-ascii?Q?t83rxLHXnE9Gd1GaM1Wl+HgLjpiUdr5OE5fXGa1X9fnrcDTL34iDdZf9y2Wl?=
 =?us-ascii?Q?GRcC+0gqclX4PtK0WlWWgRDyHTv7QT2/zEoQPl8YYQjWnlQubsdudeOYGgkI?=
 =?us-ascii?Q?wjFCN+QB3/ZFEoocDnvnxCICvT4VdQSdDUZ/AxaYMVfiOheQuU/hG7pCygba?=
 =?us-ascii?Q?j0kp4o6Zr6X8xwN65yI2t49LQss5c/86MMQkiJaBZO1FcSPiC+NTw2yZJgVx?=
 =?us-ascii?Q?uy+Xe0SN49eKNNcoCRl36IrjIsBF5HywSgowv7pNe1+abCZ6DjjijM+VJMkW?=
 =?us-ascii?Q?2xkYgJ+TlwFkNPg+n1mFXynHcm4M7w9nseaeIbSOFsaf1dOtfrEQo0DW/3/F?=
 =?us-ascii?Q?MGscwbbCfqmQh6wLH87fcIG5rhtZAhYYqRUucLzLD28rD4GHBjkEkczYAXtG?=
 =?us-ascii?Q?M4WBRKEB8x9H88vt/0c6OUu94kbIIyhPtSdZkqhE178lcnx9LLfWXXOlfOxK?=
 =?us-ascii?Q?W+JOtNxev+SYF2syla7hH0DncUzUDGFlZe2iww9RsLa/St9MOeY57xtZtDKB?=
 =?us-ascii?Q?/CSNK+6raTx7lRjkDwcmCxv81PEvVzRKOQDEfE/YOhfz52Xqd9IMq2AFzGgn?=
 =?us-ascii?Q?nMLdSrLsD0BWWqCts6zSRWlJt/cjw1VY4XawDlHXBoptBPaf7o9qrB/hucXP?=
 =?us-ascii?Q?VPZQBe/kUBKpw8GrXW00FIMWrKHXtJjMHVwZBeb+L4zcK4GnNg5BOAWIsNc/?=
 =?us-ascii?Q?+btLQhHnGAOtHnF/fDFPQ6DlsKGO/t1R9MUWHEtKwB95Lar2iuUQ6wVGYILM?=
 =?us-ascii?Q?1SruAHpxWG/HPFuhhScz4AuxX+n1mtshQHhl0v30buwb/fC01C65P3miriM9?=
 =?us-ascii?Q?cPVmCHuGGeFl8FiO/P1vXoXPSch2StHhq2lR7hiOQrKdbFCtIgf8qIpBKf3w?=
 =?us-ascii?Q?uJ9bx75ArPY9zJAsTwqbSLOTpnz0C8tASWAoDyb+dix1Oe4yJSHYtRujqvR5?=
 =?us-ascii?Q?lt9V8fmHWdQCFka3HhX90CY2bzp2F3qboXB4EpF+g8fCc+zho6mr1F5eb0lL?=
 =?us-ascii?Q?leG1ixzDeMbEmPBmoBxVqdvgKfexpbWXrJKM3bL55aiSqtvIWFEasxJ7xPut?=
 =?us-ascii?Q?RS6HRtiRjapua++5SwMzp7dhuJSsxnJkIySgEiKY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5907.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4e9c00-69d4-4ec1-cf67-08dd0a70dc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 21:09:59.6057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aSujiKf+z272AHCi4PdTMqKlCb6l3JdDsTtKss2hEnuLWcVQSM7YvsqQkFO/vPzegX0JH77k6qDuLBsgtYWpvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

> -----Original Message-----
> From: Pei Xiao <xiaopei01@kylinos.cn>
> Sent: Wednesday, November 20, 2024 2:52 AM
> To: hdegoede@redhat.com; ilpo.jarvinen@linux.intel.com; Vadim Pasternak
> <vadimp@nvidia.com>; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: David Thompson <davthompson@nvidia.com>; Pei Xiao
> <xiaopei01@kylinos.cn>; kernel test robot <lkp@intel.com>
> Subject: [PATCH] platform/mellanox: mlxbf-pmc: incorrect type in assignme=
nt
>=20
> sparse warning,expected 'void __iomem *addr',but got 'void *addr'
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411121935.cgFcEMO4-
> lkp@intel.com/
> Fixes: 423c3361855c ("platform/mellanox: mlxbf-pmc: Add support for BlueF=
ield-
> 3")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---

Reviewed-by: David Thompson  <davthompson@nvidia.com>

