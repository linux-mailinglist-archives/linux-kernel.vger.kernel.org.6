Return-Path: <linux-kernel+bounces-212936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C6D90686E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEC0B27480
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3A13DDD7;
	Thu, 13 Jun 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O6o3E1b6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C129AB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270446; cv=fail; b=Hmj1OR5nGOM2h1jhmUPHAOT5x2TNllCXocAQ9EaTaX2irLxXHUApwM0yq23v3Q3s60TyTu5OlBII6cFespToBdN6vCnaeUDpJvgaBalvRHIJ32uqB/69SRxPmxzkqvWsVidQsqk3SCA/Fk+mVYnNfYJkQNbINH8SDl1qA7VAEdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270446; c=relaxed/simple;
	bh=f6awzMbGcfzXuJQekv8hywtGNSycjpvn/o6Dv7/fdOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p9sT5OsQDFXBqgH/pY1sFkiFjj2buYmgqw8nRmhciLa6zYvSejAkHmBJsv3CrtmeP7ABt4z9Phkx6jW5ESaUsOR7UwN3ohNMBi/FdoxBJC+f5W2Eh3FfUceitkTSGBFJKA3p8kQVme7q/Do++FwpH/yVnmK4jkko6EDqFuIoXkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O6o3E1b6; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZjbhIZUvJCwXCrcQBLzj24wJ//LTdRELYJksZMk/qnvVp5vvYDlOcdXlCmItvw6jyAV3gXQCinGG/GNCvjWmfjjdS/UoM09+3o3FXYYAhapTBPH3vkpdLMqlh2xJZbQ7EL34M80NfcsRp3l68cy+D79PBH1COUum1KyOjx0Y9rAFNkjy02AZf2Pj7tINJIAquvPsuO/wS6CuSLMlVDYE/aj2EzRSPwb//+tgoDyZS//nxM/J/rxvhD2NksNvWOHhIc/72W61OJTAOhb8LC1xXUdeCnNkLI8iln3/ngdGjfMmmzoCXSqhZyLeGtfZRReJ7Ih0Nh4eauuNoZs4XVBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4Gyt+bczsyvG9yQ7hpnLnVjO+JElgVujQgoHYwiBWA=;
 b=Bwfcu237zIU1G+AFWahHrJMeXOJVmmmd3RBAAwoXKMBKNbvldRuVN7+ALqyImvz6H71M5JfMundvvJSqc4ayifC266lQIHYLjjn9yR4/yVnk4sS8UPMELSnd0FYTWjf0B8z9TCGiX6GFXB1vUHjZqkwSGEUDtdW9ZIUd8mxW405J5uDbX8DvzojLetIHZWsdu+wi71jVdE7LBDGE/mgKePXUBdpvs4cJju2G8yoclYqd5N7gfrpg9TND8uODLGq7PPuTzbEyD26TZty0dJ7Nwj47/o63wpVi8QkeNfeUrWp9Z07BCiuj9hWc3ydY5RKqTSWLi+iD8fvThavtEMvBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4Gyt+bczsyvG9yQ7hpnLnVjO+JElgVujQgoHYwiBWA=;
 b=O6o3E1b6+beRoqz0eG7up4nMFZyeG1OL8wIQOVYDPkyj92NdyjCUqMdmoxKSnmfyTgingFsqtIY8FOhrBOXpbxnmycMv9JUC/L5dIaAEs6J+YRRs5grlDN6F17LXATjqh5EOrOReuhwWPQ7xeip39jkGNjDzqqvPvSdMys5VH8c=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.20; Thu, 13 Jun 2024 09:20:42 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 09:20:41 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>
CC: Vinod Koul <vkoul@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: RE: [PATCH v2 4/4] phy: zynqmp: Add debugfs support
Thread-Topic: [PATCH v2 4/4] phy: zynqmp: Add debugfs support
Thread-Index: AQJ83aedMQVFXzZR+sovobCavopdtgGvrfvSsHOmC7A=
Date: Thu, 13 Jun 2024 09:20:41 +0000
Message-ID:
 <MN0PR12MB5953519A685A222CC603A2FEB7C12@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240506170110.2874724-1-sean.anderson@linux.dev>
 <20240506170110.2874724-5-sean.anderson@linux.dev>
In-Reply-To: <20240506170110.2874724-5-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB6448:EE_
x-ms-office365-filtering-correlation-id: d3bf7d4b-dbd7-467f-5dbc-08dc8b8a186d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BBm9zZilPOEFWLERogC7pqYcMxdNpYOfgRsEBQ/tYbvI4mo+X7jAxDumYRBZ?=
 =?us-ascii?Q?y6+pFaOGnWgFxXtVm4J7fI8+bLFmm8lHHWomRvgWM8NE4et9oaN+ffK1zhPr?=
 =?us-ascii?Q?pPAHr5M61vDd+BbGuQwpeJW9hAAUrEZ8pOiVZFmNzV0lEMk6Uc4S8HuKIo/j?=
 =?us-ascii?Q?e7M9WIrMgbphoIWn/USPq7jfAj80H1DQewAbNZbXbCeWDr7H9Fmupdf5amg9?=
 =?us-ascii?Q?OjqeAOn95ZkbuqYxTv4ry5cQPRa4TPukYy0jOoEDcUqaHztIPKTpMAeia3yT?=
 =?us-ascii?Q?uQWzkv1bAcAVWmlirZE6bXfnb89xQB627pnpffN4pwd5M7hVovtNF72ZcFy1?=
 =?us-ascii?Q?j3q9yGH0FMkj5V3ZnujdLTusY6RB4nIklNHMSeZ6c7Zno29xA4QHFzfl0/kh?=
 =?us-ascii?Q?cH1dMIFjUe1zlMt1a/YI0kjP7W3kFax191CNVmWIBfTHz0TzoNNxyT9vt+97?=
 =?us-ascii?Q?THlVYD8l2GKpT6iHluO2M8HITnzkbEK5VRZWh9jJ22+qyYj7K2twla0bK4Y8?=
 =?us-ascii?Q?dqz8m5j7WTUEIKBTkhaJboNTdFI9AhOOYrxBsTtajm0HhUd3KWmSwsefKSul?=
 =?us-ascii?Q?iMP1OkXCD0vRYkaU899jR/MwejwdcA6LIBVos3YbNZJWsNO97GuxcDP60ybD?=
 =?us-ascii?Q?dhdR81VTLUtJfWVlU6/PM4IScU+BY+IGhN7aYSHsgidOkneCwRX6xVtjqkIH?=
 =?us-ascii?Q?/9elgNiTk7oERURHRRJpOKu5erJVe/FIOQGzoQ5B8ccnHoUVL07YHtshc8Uw?=
 =?us-ascii?Q?Aj8lAD+nlvdRM8jsPCy2lRDQPpa+0Y2+p9GUxNKLD3rg+4ZUyS7N+qx8fzms?=
 =?us-ascii?Q?G7lCSE/YRKWtKdd+UFJKUW1MP624B5ddSCDJtg5nJ7dMafwtuM4OaL0SILyc?=
 =?us-ascii?Q?7OkqI/9UOu+4/0zgJCkRvK18Js3YvOkoJtxVebRxAsiBEi6rX6s2qnZO5Vg/?=
 =?us-ascii?Q?I6/42W3frEgqlsN9LvhtLPuqzL1jCWa+YmodjfUdiZ/cWrSM2eq8m38PWIsN?=
 =?us-ascii?Q?VpcC/sxmWwZxDq6PaiHL5hN7P0aAwgOvBl+wwL6Npk4Rt/WjmmM8RMzxK5E8?=
 =?us-ascii?Q?8LcFF98rmafd/+CZc4DTP20Yo1EL3WsuqgF/g8/vvY3o9eb2S5LoJM1I4o/O?=
 =?us-ascii?Q?RJqiItEd1VXcbQOE9Hlg7vkTo0cgEJITyP5rQXsgBj4zTD2IkmPjkZXpdTGt?=
 =?us-ascii?Q?Qyzpi/w6xyXEoHQDeAzRuFYxFXxfmSo52NIMg2bVtp++kdv7IIiNEo+OxR7t?=
 =?us-ascii?Q?S/beSWYxx93OMpH4JI0iBr9vqj0uC5BkV7mn2YcfvfhSYB/HNfujWfLFLBM5?=
 =?us-ascii?Q?ngZf4hjFS9+aGZ2LzwQthSVuVohPpj9nlUbA4Z55jE/NpUfRXbj10fvUzvVe?=
 =?us-ascii?Q?AcvLtg0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o7SS+O53ScM3yIX04AJWTyeTZkm5vC4fmJ9+Me2Gw1asGzzBEyIHmlRxWq56?=
 =?us-ascii?Q?aXdNWNhmkVEYTo1z3keJDVOvOSNy7P1Nccvm9E2nYo9ncM8hKYkjKgAoA6db?=
 =?us-ascii?Q?upM4sKBeRW3NaBv1x52339mbuS5alh3LFFLHrtyR5OvsiN/qN8Gv7/H+3u7a?=
 =?us-ascii?Q?AvgRteb8hk7798zKeowLKvhXHz1LUidJT4hCgZ01V4JNzru26+qGMLcrau0T?=
 =?us-ascii?Q?hXitO8+CQlryja+QBh1+SgkXLba3ykzRpnT3jiTZVqdOUQPce/paatqs6RyJ?=
 =?us-ascii?Q?U3Q0vgfBSGA5UpwKwWqwKo6GgMOGu9LhWV/BxyXlsA3vHysvakwcEbK0O4EI?=
 =?us-ascii?Q?vxoVI2MQ4V3VAGnwubzU0MLG0ksTKObSsNpuN5TtuqWLeh4mnWHxBhaMhisz?=
 =?us-ascii?Q?tJj8y0CGcSYp6yS5rLFkHcUzmoeq/WA05OgE/Na6rxOY3EiH/+MvIwWHgaMz?=
 =?us-ascii?Q?7R8A5vJk64WPOie37gIrHINMe/nOOWWJVSFswqMqhuusQ0oaMXP43e4rb/VW?=
 =?us-ascii?Q?UMANYwFYn7dn5huWbzpgS9peMTVIFCwkpiYRQVzzZVDalfF+OzubgrtFinVK?=
 =?us-ascii?Q?CwOE1y6+c9J6cI7apZ774onZ58SlIN47JnxMz9uIPXWoSasFlp4SU0gBINq8?=
 =?us-ascii?Q?EdwM3v6yx6LYTRC3jKdeW3DbHe3atuOlxMczeqBfGAip5Tx/kMONTGjToWUm?=
 =?us-ascii?Q?wyUdKTZa4kBSlcS5PB47WqqBekmNKwsTEzws1zJQAAc2j1f6KD1vLSuFeuLA?=
 =?us-ascii?Q?kLwyg/0Cb4vnydZBggKM1IKXjAUAphUnCZaHvdJEnPLto3LlBlnldja9lC9o?=
 =?us-ascii?Q?8wSa2Vimuc9MYaVyN6qfTci2UcNU0rFAtOcwTreCmZGIHIfRDN7gYw6s7Xod?=
 =?us-ascii?Q?ExtXXdun4fz1eL1TT7YZ43aRYV8ej4AvsyZ5gNPcv3lknvs6BYhwxEb7salg?=
 =?us-ascii?Q?/mSg/zmcqACQeej8yzVTLTCmp4AWPUTIqMY1C+mom2ohoqUyf30t2NQhIJN9?=
 =?us-ascii?Q?U91tpqT1kDwGhLDGwFk+AV6enqzQqKytB8d107Hojclk014uSlsrQnw43+fR?=
 =?us-ascii?Q?+d1rLLTWjEBYfGAlu4SNBObSX+0Ts3jPcSG98Z2Yh97p8Flb2/KlEZlSJ27E?=
 =?us-ascii?Q?WcCMYv5MwqBRlcQJPAAWx8G1LfIeVpRvxUD/kuXgK3ajk7Ikh+sguSuAOOCV?=
 =?us-ascii?Q?iu4xjkHPb0W/4Z+wYaOSiRZ2PuZbhK34OD0LrZ25AWnK9HOzT363F+f7cEm9?=
 =?us-ascii?Q?PwbQ1WE6FFHsYYuY5cu5AZYxV4PoyihwybIVX9YXUO+KsND8P20Idysuxfb5?=
 =?us-ascii?Q?F9z/qmCg0zMaGp7i1Vfqr4VEK2R0pO8IZsAIi1w/Agul6oo7XikRHTR9/Crt?=
 =?us-ascii?Q?Z6+Kc7rcvHJXC/Zg97EqIw5warQXXChS6bhoCkdO71q5V86mlD9NiZbftCQS?=
 =?us-ascii?Q?ziBzyQOP4Nh87yyUZKL0whCI7Bi7D/d4swku18DNLue/DhNqTOPaXF2XhJ2p?=
 =?us-ascii?Q?rzLkGcK8wuYo+v8S27aID/kCRvtSmA4hp1OcX9Waa/GBE906Zgc7RPSB/jCf?=
 =?us-ascii?Q?wT7n/h3or0bYhj1ZG/c=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bf7d4b-dbd7-467f-5dbc-08dc8b8a186d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 09:20:41.0900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Cc80lz2j7bgJ1+O6q0Ssc0YduRwYBnGtyk1CiYVBBCp/qiCQLHxHv01wXSnN3Xu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Monday, May 6, 2024 10:31 PM
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>; linux-
> phy@lists.infradead.org
> Cc: Vinod Koul <vkoul@kernel.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Michal Simek <michal.simek@amd.com>;
> Kishon Vijay Abraham I <kishon@kernel.org>; Sean Anderson
> <sean.anderson@linux.dev>
> Subject: [PATCH v2 4/4] phy: zynqmp: Add debugfs support
>=20
> Add support for printing some basic status information to debugfs. This
> is helpful when debugging phy consumers to make sure they are configuring
> the phy appropriately.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>=20
> Changes in v2:
> - Use debugfs_create_devm_seqfile
>=20
>  drivers/phy/xilinx/phy-zynqmp.c | 40
> +++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-
> zynqmp.c
> index b86fe2a249a8..2520c75a4a77 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -13,6 +13,7 @@
>   */
>=20
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -123,6 +124,15 @@
>  #define ICM_PROTOCOL_DP			0x4
>  #define ICM_PROTOCOL_SGMII		0x5
>=20
> +static const char *const xpsgtr_icm_str[] =3D {
> +	[ICM_PROTOCOL_PD] =3D "powered down",

Protocol saying powered down seems confusing.
Should we say None or None(power down)?

> +	[ICM_PROTOCOL_PCIE] =3D "PCIe",
> +	[ICM_PROTOCOL_SATA] =3D "SATA",
> +	[ICM_PROTOCOL_USB] =3D "USB",
> +	[ICM_PROTOCOL_DP] =3D "DisplayPort",
> +	[ICM_PROTOCOL_SGMII] =3D "SGMII",
> +};
> +
>  /* Test Mode common reset control  parameters */
>  #define TM_CMN_RST			0x10018
>  #define TM_CMN_RST_EN			0x1
> @@ -788,6 +798,34 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>  	return ERR_PTR(-EINVAL);
>  }
>=20
> +/*
> + * DebugFS
> + */
> +
> +static int xpsgtr_status_read(struct seq_file *seq, void *data)
> +{
> +	struct device *dev =3D seq->private;
> +	struct xpsgtr_phy *gtr_phy =3D dev_get_drvdata(dev);
> +	struct clk *clk;
> +	u32 pll_status;
> +
> +	mutex_lock(&gtr_phy->phy->mutex);

Do we see any need for this lock? This function simply read hw register=20
/phy members and decodes it.

> +	pll_status =3D xpsgtr_read_phy(gtr_phy, L0_PLL_STATUS_READ_1);
> +	clk =3D gtr_phy->dev->clk[gtr_phy->refclk];
> +
> +	seq_printf(seq, "Lane:            %u\n", gtr_phy->lane);
> +	seq_printf(seq, "Protocol:        %s\n",
> +		   xpsgtr_icm_str[gtr_phy->protocol]);
> +	seq_printf(seq, "Instance:        %u\n", gtr_phy->instance);
> +	seq_printf(seq, "Reference clock: %u (%pC)\n", gtr_phy->refclk, clk);
> +	seq_printf(seq, "Reference rate:  %lu\n", clk_get_rate(clk));
> +	seq_printf(seq, "PLL locked:      %s\n",
> +		   pll_status & PLL_STATUS_LOCKED ? "yes" : "no");
> +
> +	mutex_unlock(&gtr_phy->phy->mutex);
> +	return 0;
> +}
> +
>  /*
>   * Power Management
>   */
> @@ -937,6 +975,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
>=20
>  		gtr_phy->phy =3D phy;
>  		phy_set_drvdata(phy, gtr_phy);
> +		debugfs_create_devm_seqfile(&phy->dev, "status", phy-
> >debugfs,
> +					    xpsgtr_status_read);
>  	}
>=20
>  	/* Register the PHY provider. */
> --
> 2.35.1.1320.gc452695387.dirty


