Return-Path: <linux-kernel+bounces-403970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5824C9C3D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1B71F247BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6FD189B83;
	Mon, 11 Nov 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cvLZfqFl"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285F156F44
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324522; cv=fail; b=WhkDPZMZ42oP9+XuRqArGwcJR481nwRyFXLpDaBbZRp/Nq74tt1GGGu912nH2yAo2rjbitmtLwl33ahmusLy4ZUI9mg/mHm24aAxewbYPoO5a3npbbKSXEXXX5oWNgRYdodmfdx5h4uiKaRoUOjhx/ksEC9xgYJIyToDebXtUTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324522; c=relaxed/simple;
	bh=LugCKa9bJXdoOC3d6cyfRzbfQLj9WSo8E37r+xZvrqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OuVGBMnSpVB1PTqGOGMbIgTwRNJ5HJphdF6YUzFPFuNIa7Bm/bMQFletVDBqHvjsqUgp6RYhPgTDyRyMndv/XRYVTNedx+IhusseGlPIjHqAdB21MrA2bRBMEMcOQ0Dz/ZtkaV9C1tuK6mozI4eu+LTxdJa4dCyP8nuYbh/Q2vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cvLZfqFl; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+PAqkNzf/mPuoKRPvPxgwnHjYZc5F9cfGENl7HnO8vYq0W9xwYsHrHK6H+921X9E/R82MDpqcGn0aTcspwuLV8htE2RJg2ecA+mvcw0dmWMqLXMv8Ii1eK40w3mOuuNJmDV3azOEHvzSqGTcmx1Kx1EFr1gpqGlAp5hES08B69uqjeZDkVkq3JQJiN7P3jJHVWvJrnr8nLF85vhV086YwNtzYLuWVtMM7t0YduQ2gMNgu2wmE583oXZRhfTVEAi62rwiOL0s4yHQfxxXwrKL7ZECjV+rLPTeKlIRyQSDLjmPTICpzLVnsZSpGmfb5UZjwkzYBfGZnmCjBS427Cg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKrTUGc7LR4awNZu6ApJmX76FH3hIosToyB8TG4o5PA=;
 b=B1YE/gP3ppktRfRfppRZqVHLB9ociSAwokJ7G0yz+XZ1as1S925LK3WRLiUDLbSWCOBui9hO5PoIDMFSVBYqQon3VE7dTq39xHQTEzj0cBqRCf2YjKIPeEZHgDJIirF8q0jpvR7B56edz2YFn0cK2ylDsXLXKthY1zYWuCwOx+ZMThcI/nHTgEDFwlvzU0pndbl/AC/b0DG5JOZPARXKirkH3HAV89uH0lzMgms6vKAJzDQydy4lFwoyTYH3C3O9Wut1EtjJmgjXPxrhYURE7YgT6uNF59j3eLoaaBy3cAKYLpI6j+OTzCozLukT7+zdkP7FlaKn+EIkMYXlrUNsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKrTUGc7LR4awNZu6ApJmX76FH3hIosToyB8TG4o5PA=;
 b=cvLZfqFly7RacyhkMYXlSRtW2kaRM6iRHgWItzNEAp81E8pWXCibsEFFIVCA6Q7tr62SqR8OHvoCz0BiUfP6+Aplx9yt09JnHBCUhj8eWy9kvsw6LhL5PSWSMr+unYGVzM1qyg61QEJHCc4869V7NCgPFbGjuF0yASugKEKGPgk=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 11:28:35 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:28:34 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
	"Gupta, Nipun" <Nipun.Gupta@amd.com>, "Gangurde, Abhijit"
	<abhijit.gangurde@amd.com>
Subject: RE: [PATCH 1/1] cdx: register shutdown callback for cdx controller
Thread-Topic: [PATCH 1/1] cdx: register shutdown callback for cdx controller
Thread-Index: AQHbIIAlsF2UGEakjUuXPDEBcrNnuLKyF73Q
Date: Mon, 11 Nov 2024 11:28:34 +0000
Message-ID:
 <BL1PR12MB5333A3682D6D14D28F63DE619D582@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20241017103216.316114-1-abhijit.gangurde@amd.com>
In-Reply-To: <20241017103216.316114-1-abhijit.gangurde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=0e27b01a-5382-4bce-ab41-acfdbedaa180;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2024-11-11T11:25:44Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|DS0PR12MB8767:EE_
x-ms-office365-filtering-correlation-id: eb3a70f5-2b69-4b1d-3592-08dd0243fa7b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rasqrZl0IJZPs/EFuHYgf+Qp+O5oZP+1s9Gjr4tYevmZhnWHUxNNFBtIm7Tw?=
 =?us-ascii?Q?22Fv22DmpAy4DsHG474TsKKkq0wr9dRGTtBTrYDs/jcogMRpsCH7nP/Z/fj8?=
 =?us-ascii?Q?325SrPET2xT4KiKp1I6o4Jqvzk4+UPNQKeeolzD3HbmKjwhfQau3KqjaOptU?=
 =?us-ascii?Q?/fLWpCYS65juz6TIlE0VnmZOLDXvQgLgfvgV54T1nrN4XY6QgS1jNUFO0i0t?=
 =?us-ascii?Q?rJXWvFJA7XkFKUZxlodGH+kBjsB1ljxqU0/hBFDCi82DIYn3W/iFmG8PIIEd?=
 =?us-ascii?Q?Fo5u5QEDN4xGa4ta9oVpHri0heMOKdVwYehNngQ89qeDdkewxEma8hgX8ytw?=
 =?us-ascii?Q?l/pPHiL21lr/hR4ode998/fZsZ+1EokaYDdoR7DlQq+SYnaqbHxR8raHTdrg?=
 =?us-ascii?Q?K2lb2UjOx9b0EFKz8RlYdsy6TikMQIgDcQfJku3fdKulJnUernzi1Yc0jDMg?=
 =?us-ascii?Q?gO+g2ctbmC90lWJmM9NVu3JX1OyaGT7049vBpT/iOj6DSolYR52u9NbiFvDL?=
 =?us-ascii?Q?SkVGL0+q7ne+NeAu2h3mBna+RrkKevCFekw7zjwGyH53Jo3Tui6xDP6X2sh1?=
 =?us-ascii?Q?9Y+cZjEaD7QHMGu83RZU/V9MqB8ekDCGE22sr4L13YQ8F96VBtisYDYXVpLE?=
 =?us-ascii?Q?ofIEYWYEdK+ZfN095RRtbNONU19Jba81IAuuMKpVdhE9XdpfInbCJWJto2OG?=
 =?us-ascii?Q?B9gB36DrqjnMQhrDA0GvYfc2YfsJtdOGmb3XUGfT6KM5u43QhnruUobKGO8e?=
 =?us-ascii?Q?24YNLOewT7WKIF5q9Xo1IiLDsMDRW/Qy1+A64I2GAYWT2mAaPMqLbeJVKYGt?=
 =?us-ascii?Q?NfnSCJDGNStmhHcTOUvnCvKfeG5dp0YBY6gJGR5fLY/2pTbxvq5JBVI1rEJA?=
 =?us-ascii?Q?I/bvaQSC+zxRhJehLZKFBJ+c4gYd7T6Wxy0pZp/0kZN0CfCE0DwmU+GjHfr8?=
 =?us-ascii?Q?ufHxOj40C1EetN2pB3jxASGDPRzc24H25Y/8Zby6lEYfCsHyJMFMlmFe9dJv?=
 =?us-ascii?Q?ajvCkVYSJVVgJuRGZl5ZxAuTPVBQ9oJVherKI/OHHNkWRpdFQSpQuKOVq6S2?=
 =?us-ascii?Q?zLavOnymCBlu3aITUTJFrID4p/48TTqJEpj3Zi6Y9bceNLmyTU4Y5+9q+F1j?=
 =?us-ascii?Q?WSQgAAhQ33CwWs1fn4ACvpiFK54qLDuF4e+se2fYKL9L49RJA8Qe+dUdjTxV?=
 =?us-ascii?Q?INLlkbYfoe4BvzRdHE4KlomGshhEnSr9v1On71FAWyQW5LBdFDXE5oS2fMer?=
 =?us-ascii?Q?17Vxkp0ETe0S4KeqBk92KtzdLGMtmMgJ2cIubhXu/bQhfLj2p1JmOcLHfj4v?=
 =?us-ascii?Q?f3lxWQM2AnIV9KnLqD4Olcoo/BSrkCyk0sia8tIXl292RSxj5eaQKQ5Kxf1x?=
 =?us-ascii?Q?iqZ1Afg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?INaIder4/yZtjPEHvoy8aSYgn54eeP5j57LCJG3XyCTx9nsc2gchwUKTYBQJ?=
 =?us-ascii?Q?vOLwqUoc2RtImKA/axYc0IoOZOrN8pDeS8dYPu418Gy/+PE5krIlyYBObv8h?=
 =?us-ascii?Q?d9yDuaa6gs/bkNZNOo0P4t3aYYYeYNQSv62R7AGXenovrW7CPf4WKantF/Rc?=
 =?us-ascii?Q?CORNWwEJZVK0skmlGcocsB1oWxTg5HUyUK5C2sYHxLs3MIM16NNNyMSlzHVr?=
 =?us-ascii?Q?btbFMqNckNzwrC3BRirpmvYkl1dMxiZ7UOWcVFA8Y2ygVJ+2BuG3mwX4GYAo?=
 =?us-ascii?Q?9LRk4ByuCTNGKzZozKsPSaFpa5LJBkkItqZJlUzh4U/AnRsddHhp57AjTtd1?=
 =?us-ascii?Q?+1Oykd9CHkif8cVQpbwd3loqxbAByLA7Y+Fqlh7HnYjt65OQM3u2aTqm/s9h?=
 =?us-ascii?Q?WoU31X0lSobKjh1myAUEn1qZTbgH8PvCI1+NGnOoFeH1JwthD7kMNc7h0V8w?=
 =?us-ascii?Q?SnLetfgrlzI0O5Ho157zxefb29T/Xg1GmvKY8r04gq/SPYK7mrdqTeJZtnVn?=
 =?us-ascii?Q?+SQ3qb644SrlqUfn6d6gJVTlZarVwTNOOqpnE8cAcxB4WihAYWjiNoj7ET/A?=
 =?us-ascii?Q?Rcs2mvfGyr23hxSexnTFUxZf+u4dzRbw0lLbWX11OvG3P4tPFrYZBIu9nTJr?=
 =?us-ascii?Q?42HwBRLA3/P+dDmi7gujzeVwC2SSLcNSVxpL7bhMsWggidxz/y/IC5vTAhrv?=
 =?us-ascii?Q?zvbik29zcNhVR7aTVA43K+/kXk36O7oE0DAs/D5S7RbFYjSIbtRK9+yqHdiE?=
 =?us-ascii?Q?UKP3lMBugbLmgmr3cBCsOXubbtPP1sfTcvuVd03kW0hubNEi/uxtrfVwWhVX?=
 =?us-ascii?Q?UpY49e+gpWkrTTTfJTl/GLt4m13GGRP7+XVq/t153I27JURVrIEC81GuHevm?=
 =?us-ascii?Q?rCatsfBAlNCFTSh4R/KMPH1QImzW4BY1nzjbfpu2cAOUuvig/aNHOQsyiU1T?=
 =?us-ascii?Q?noENBHD9rSfGAjRIdSR6lEoSxrbUbipworJydsqENyNP+vC9OmZRs+ZmJ3hC?=
 =?us-ascii?Q?u0TnVexxWL1Od47arlL+m6eWevGwCshCqy5WLXfEOGofyLKK4APGZRfJv8Lh?=
 =?us-ascii?Q?71bx3ulPQ82tXzVPHdm76yHrdvic4Pj7rdRf3Sl/zi5kt+lO2Bhl+/09fBzU?=
 =?us-ascii?Q?Zfe66Qb4RqWUZSzxZYFhQNTJNNyazZbmeHNYwH6JcxVmBphragzP/OUSRrOf?=
 =?us-ascii?Q?ETc/F233iDuYvkzZOkvy1QtdyYih8sZnM0+g/jh/kCDsHELaWyEyq4Zgl9ZL?=
 =?us-ascii?Q?eZ5KurLHHv3wLyGr0D9kMCc3NYLN4gGbZzeCs2uD6N+JNPC6HG0URiCQJdHV?=
 =?us-ascii?Q?wWo42PiBSfZrR/AyM8XBd7NKb2JQigxU+wLUT5lAjMsuNhBDYAMDJcbvRFga?=
 =?us-ascii?Q?SUu7oRt7dPNyAZuntzPRNxlqpYvtFHZWfMCbFChChK4iKLo99mTb99u5ikWO?=
 =?us-ascii?Q?sgvTWBcMSUK0cBuJqGpps25R6LuUJKnMTwuPideTHXMdWp8wkfHEA+ejKbTO?=
 =?us-ascii?Q?rocZOe5YO5cmSp7/kRs8HeNA1yVf5FRkysS9iaJ7+74w9401Wh9L7YUYX5PQ?=
 =?us-ascii?Q?YLkWRka6jfZwtDXsE2k=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3a70f5-2b69-4b1d-3592-08dd0243fa7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 11:28:34.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ab9LZRmB90OUIZ4Rfw6p8HIEbdlOaaZ5CRR72p96bkHDPCzOHEBnVTQjyEpzrnRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767



> -----Original Message-----
> From: Abhijit Gangurde <abhijit.gangurde@amd.com>
>=20
> register shutdown callback for cdx controller platform device to handle g=
raceful
> connection closure of rpmsg transport.
> Also, handle shutdown of cdx bus device by disabling the bus.
>=20
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
>  drivers/cdx/cdx.c                       | 5 ++++-
>  drivers/cdx/controller/cdx_controller.c | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c index 07371cb653d3..65=
5a056bca4e
> 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -338,8 +338,11 @@ static void cdx_shutdown(struct device *dev)  {
>  	struct cdx_driver *cdx_drv =3D to_cdx_driver(dev->driver);
>  	struct cdx_device *cdx_dev =3D to_cdx_device(dev);
> +	struct cdx_controller *cdx =3D cdx_dev->cdx;
>=20
> -	if (cdx_drv && cdx_drv->shutdown)
> +	if (cdx_dev->is_bus && cdx_dev->enabled && cdx->ops->bus_disable)
> +		cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
> +	else if (cdx_drv && cdx_drv->shutdown)
>  		cdx_drv->shutdown(cdx_dev);
Please drop else from here.

Also, as suggested by Greg, please split this patch into 2 separate patches=
=20
for device shutdown and controller shutdown.


