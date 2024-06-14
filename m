Return-Path: <linux-kernel+bounces-214385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F1890837F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE66D2818DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338891474B2;
	Fri, 14 Jun 2024 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vyvh4+pr"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A619D895
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344969; cv=fail; b=MkKv5IC3fRWCq+1TudfVR4yHheBkY/F0XwdIUOM4Y4L0WHcUrX+SgDgx9zl+D6OWGlSBjNlLEVeY4xIuyIU7Xe75HnX9Xzhg1Mvxtjo6KcWQvyoNUNoMi6A8WHj/+u3UAiNk+sWJ2JGq5/50kQ2m8B5Opaa6qrlBYf4fRwrOh6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344969; c=relaxed/simple;
	bh=TjIBEgxTpHIF78Qid+mwuBUIX+Oo1QoT6ue73aY6vQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MfBjOxozBIA9m+35cEFYv3r6VWB7DVIc0BVo2wr/Kj8uMx9Zm4oVfAKoehChVSkMPY9SJPRqJ3uPOHqQVnzcTWKY+4rijAQ5WVtkro48vnC2JFVOtPJGy3sLfozUY15ACwnnggo+PTX/OWeuSfTzpQmFuOmbFi2CNiQymUM9bJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vyvh4+pr; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhR8IcLD/GsLqpXUn9tVQxoKPa/pg9vdgxOPwl6Vaaor82sV5T71fI+ex9LysDNLXVK+rJ7V8iFbIe60klbWdNXVRWKlwbntcDX0/XPMpllRuuyO9sb2p1YuEo79jUfqVybDT0dEWcdG+wiouGZe2F5l+FeXGLeI+AbQNSXhIHDoKbB8zYjK91+FHE+JzmgrCx3wS7X6ylHnMT5sSR+FjnDJKvFuuAHupuWMROf+07WK2n6jB5nDhvFgWzF2iWZGra1LDrw3LrPiY0Qn0K/+cMESmDgeZApd3Xu63OlDL5Cd/GucB0QKtFrk8APo1v2a9DCmjntcICbOGs0XEjfDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPWXZD8/EUcAPJc+Lp8SPFvdV88lVYqQGd0/TSlX8D0=;
 b=RBYODz8QrSS+B07Hgs85d2Aqt2kY6K/jeqdn60PUp8pjI5RmRz65tMG8j1BzdB3h7yjG5TyXk7e51R4b8WRt5yiEZdMwQ97NbgqZ4sZddSqQmfEOjg/PsEU1IoMsa6zIgV6fhZxhARJyZj00ZcQIjrY7gmhuc/a4EeuD88pwu6oORy46Cuv5yQ2M9YaQVyFv2HlwmLWTGWqggtu8i/Xf6Ww+xxnGPkHzL98fEosMKEJYlCCoHNFLkRwdPQPade2nkMaJHpS4hf6kB+3sjnKV226a+nsBrYqLIa+J19uhtyUPNpuZn8vE4dMw2kyz5WbX/OP2QfLOK6y3o/n5oE+sTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPWXZD8/EUcAPJc+Lp8SPFvdV88lVYqQGd0/TSlX8D0=;
 b=vyvh4+prcMXPeO9XAbDOiY/6miNt7uWOMjcBDNbC96R0NlZr9+jzzBCjjSj7bfl2TAf73zs8OEiJeJkVeZLJCK2XBnKKe92aeW2eupxrJf/3gGbbXd8kkt7mq/FNchNl8hgpQidxKTCR8MoJ2R+55r8uvHw29I/K+/ZCcJYiypU=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Fri, 14 Jun 2024 06:02:43 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 06:02:43 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>
CC: Vinod Koul <vkoul@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: RE: [PATCH v2 2/4] phy: zynqmp: Store instance instead of type
Thread-Topic: [PATCH v2 2/4] phy: zynqmp: Store instance instead of type
Thread-Index: AQJ83aedMQVFXzZR+sovobCavopdtgFTIz4jsHfmDjA=
Date: Fri, 14 Jun 2024 06:02:43 +0000
Message-ID:
 <MN0PR12MB59535CC0B70185DDF8044AC5B7C22@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240506170110.2874724-1-sean.anderson@linux.dev>
 <20240506170110.2874724-3-sean.anderson@linux.dev>
In-Reply-To: <20240506170110.2874724-3-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB6472:EE_
x-ms-office365-filtering-correlation-id: d2aad0cd-bf85-4c84-d73f-08dc8c379b2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|366011|376009|1800799019|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u/KerNC8EZPdnhHs5bV6O9Z82mSMQD8vUPPpnSFNbfICNCjGtXJ0aOxlqphT?=
 =?us-ascii?Q?P6ykmXdKHNrA14xYCVm/1qbbGwycJK6zaSlHVqsEyE9JGmDz1hlwzrwxxQo0?=
 =?us-ascii?Q?vqy6fcFmSl1dpPoPW7OTmlrsqeZcHKptm23NXQtRKgaYY+oQs9bvrFaZ2jvb?=
 =?us-ascii?Q?whl0CB+fvteqwcV8ON9yN6i++zBfcY8L/KNXZnk+J75k4eFoW8cov+jkO5TH?=
 =?us-ascii?Q?YYU88m8jXfKf1dmulnUlDwuinS1i0j4AT1NoJkVG1MqBByyNkmumMaeAL1yb?=
 =?us-ascii?Q?jVaYhmLSFYgaok5mVctHDw2fKIiVvqrX5qpL/XvM4sKijnKb3fgKo2AY5hrf?=
 =?us-ascii?Q?tASNYRPLVSWjjEymevGB2tPzDiE2XwKG0gscO9T0hpwgtQnjjYCk3WiFganM?=
 =?us-ascii?Q?wbfrVboYZO8EHjKFUVvcpukAoXuUDjmwDztXTct/QhtJ/VzyN1CsibZSzt/H?=
 =?us-ascii?Q?g1ziuAkJkYdBx9rQ5dQg1AGhqZ7eey/nsB4GUgtqdbEEBgB0JY3gETdz7SUU?=
 =?us-ascii?Q?l3tRz6+isfpmLgd17oC2DfuTrmz0AQdV3O0pRtWAN3MaFCB0rdbF10LsT1Oi?=
 =?us-ascii?Q?OtjcSXivGZqbz5br99ytvVM0o6poSSyzvqXcZEo6pNSF1Ex88geyEgog9ken?=
 =?us-ascii?Q?3jt9Nyu2u1CSp7jQlKjb5f8S+bvHhg63We2kljsFJiZwBAhJwUxqXhCHxcGh?=
 =?us-ascii?Q?rZVKoGt7mx/NokOsbx/PLENqvM42dyCBXGt+wUR6FylEkSDVUvKCs9Vr+53r?=
 =?us-ascii?Q?EYmsSt/MzEvV1rAha00MenIu7ndEfO4k6GlMJi3jv1e0HUlt2rezi7sRQx39?=
 =?us-ascii?Q?sfr9aoDBFWfQe+3KGZA88+IPF+pBpittLJrF4rF22rxWz0mZzU/sp2Zhz4Qe?=
 =?us-ascii?Q?UX4Xemxu8moUsD1x74myQPCBz2rd+ztJVmkkKat0bWHD+dAmbX/lPmknpH6W?=
 =?us-ascii?Q?LDFT51+XyPsUuNiuKWhRVuUyc7hyxtFTHYGHIidC5KAl1VgcsPfqsbblCiu6?=
 =?us-ascii?Q?EMa0p51MgLZ3vy7nFd0NpNwDAVvA2oeeuqjynV9hegfZf7uSLOeW8A6ss/5a?=
 =?us-ascii?Q?N8xBzGIlZCoz0J/wB29j8GsT7sRYnZLqKyHlBUTK6JPQ2HgNc8FGfbsMvvpz?=
 =?us-ascii?Q?6hkdNT4q2E2gQSHlUiA/oWPAqzRlc39aw/m/xHHUWtFCS8L8LDFwO9xbNjXa?=
 =?us-ascii?Q?jgEueo+irgW1oXASN3oFaCD2KJKhDnuuQMwE7pFU8TE8d7ZteF5WOESTie1s?=
 =?us-ascii?Q?9WBjFSrH14M/QNoCcDqrlV/nqKjKFqf8lp+8Mbcmh547qZgRmLTYeqxdTIRX?=
 =?us-ascii?Q?140c3m3DA0PvLnGys40nag2SJqBkql0S4ZKMp4SUR2wi0pmfQ9g+aKGNirzO?=
 =?us-ascii?Q?2fbeaf0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(366011)(376009)(1800799019)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DIiVoCfLMiGEyEiZMQRJWUIsgrmrktk0L2UY4dYvgOoFn0mVl4KL9o/kOGwJ?=
 =?us-ascii?Q?HPqA7i1zq+tfCk6bvBbQ73j7kQxrrnIvNyIHqjitR8jZ/UUR/JIEwL8YoXlN?=
 =?us-ascii?Q?GBAquMS9C9ztpkr8zGQChSZGt2/6sDdxmb8USir6UwXOdBMnJH6GaKfTm7p4?=
 =?us-ascii?Q?EmKiT5R6hKQFs6nFcDqAL+I7ufUOJFu/tfmeLcl9Ucf4huZddCkWXiuKru8Z?=
 =?us-ascii?Q?OyOfyUJ5AUebJF2CdrWsxAj3bqN4NKj+aoN5jbLFE7jwrL2/29oaqBlFWoHj?=
 =?us-ascii?Q?CVDkWdWHAKgNJvO4dPGsBIeEOKpVRwXkr751vfgfj+KwV3Rj/E3FDL2WxNFA?=
 =?us-ascii?Q?2t/YlELIbxOW3w4X3+6JVqv1iYECF7a2FEpr2YMWRxrsj8hR0s8D8YoU/3er?=
 =?us-ascii?Q?T/cwX4AXXhmYSBi8Q0V04DZhde8Z8VbPaeUmPiQVSuJehbuu29ZsRNZ3oI+t?=
 =?us-ascii?Q?AIwhwrE98YTVjIzjaPRsp2ZCubpmj/7dhLJbf3LsG8pageTkorbf7KRQIUW8?=
 =?us-ascii?Q?UhIshNnGWdDKvp9RRXNNzAEWfj8bqaAIt5mHl6l60za81mjXra0QLIj27yAI?=
 =?us-ascii?Q?/cFBggsWLarEeB0bBu/1qctNST3zrDuR12sfePD7JX1zF4/kBSojFkCKgjMR?=
 =?us-ascii?Q?1zg6EsRvIOCnut9BLj8aHLdXXHz4k6mg9EnPO2d3FZVAi5lW0+d9Wt9u8yca?=
 =?us-ascii?Q?qDPYRTwGIFXg16nAKWm85b7xT+oUTTH47CauddEt/TFjMW1o9v3KW/Q3r381?=
 =?us-ascii?Q?rnzaxbtMNVhfvTzBqqPFIrW8paU77zuA6cT6uKS1bRo5VlHvzRTsfJ+7X4cL?=
 =?us-ascii?Q?hSHcQXDmhIO4KAtfqAap+/IdEoPgQBTqRW91WsMrLa6Tleyda5rYlXepa+E8?=
 =?us-ascii?Q?HbuL45vZ8Wd83kiolEXyb4gRVsTn1K6/FQj4YA/il1atWt2TOXDqruAri3LX?=
 =?us-ascii?Q?2y2a/L65/D0XOE0nUiFBtWIStT+lEKLz7x53+wnL6htEst94dDcJfH89IQKe?=
 =?us-ascii?Q?MCEdxRbyj8KPcoFqMd7FXm8N8ls/ZLb72mJM8cHM5za0GsdQCCTESweWuiNu?=
 =?us-ascii?Q?EVv7UjWd77yEaz3fzeg8jmva0OkT0jvUm2wHzs3OX3Z1L2+b448QG6OORGNe?=
 =?us-ascii?Q?ADhKoxJ8Vxo66k0IIkVWiFvJjGGljeLUQSaeTWYs9PtXvTQXR2x2GfreO1ZP?=
 =?us-ascii?Q?jbN0azd6ShDvUtFLORjLcHunyG3fTYmsPvlPtfSp5+2AD03Fg6RShEr+FoX9?=
 =?us-ascii?Q?OXtQIiK3V2+jOxnyXmWUjfEKf2GhpeZHCQHRpYmmoBhXFNwEd6vBDmB8Wky3?=
 =?us-ascii?Q?oJSWv09DEHA7l3N4KZbLkSya33rFUCDyoMmK21wA87AWA/SuJ7XnwlMwuo+u?=
 =?us-ascii?Q?5DQooc7zyY6iBWv27DNMCrwY6Yz87KtYT/XHX6WBlDKWsSeiiQ84CtrW4QD0?=
 =?us-ascii?Q?8n1AMWlnA7VJOo0xFHTd/adf1tTA9jloABT5+QZaL/sPaFYeIo0yJWxdscby?=
 =?us-ascii?Q?o9YYXSgcpORG3xp7jCQ6T5uEzt7sKS/Ib9oR4jcsMwFYf/hlgpbm+gFav4Io?=
 =?us-ascii?Q?epv0/K2yxUk1pRTEyEA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2aad0cd-bf85-4c84-d73f-08dc8c379b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 06:02:43.3822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvNeFlvX69hfQcl67ezaBYN5W1OhaAZ3O69YNIxkYinLaI2/zUrzlw3MxOJPi00u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Monday, May 6, 2024 10:31 PM
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>; linux-
> phy@lists.infradead.org
> Cc: Vinod Koul <vkoul@kernel.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Michal Simek <michal.simek@amd.com>;
> Kishon Vijay Abraham I <kishon@kernel.org>; Sean Anderson
> <sean.anderson@linux.dev>
> Subject: [PATCH v2 2/4] phy: zynqmp: Store instance instead of type
>=20
> The phy "type" is just the combination of protocol and instance, and is
> never used apart from that. Store the instance directly, instead of
> converting to a type first. No functional change intended.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>=20
> Changes in v2:
> - Expand the icm_matrix comment
>=20
>  drivers/phy/xilinx/phy-zynqmp.c | 115 +++++++++-----------------------
>  1 file changed, 31 insertions(+), 84 deletions(-)
>=20
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-
> zynqmp.c
> index 5a434382356c..5a8f81bbeb8d 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -147,22 +147,6 @@
>  /* Total number of controllers */
>  #define CONTROLLERS_PER_LANE		5
>=20
> -/* Protocol Type parameters */
> -#define XPSGTR_TYPE_USB0		0  /* USB controller 0 */
> -#define XPSGTR_TYPE_USB1		1  /* USB controller 1 */
> -#define XPSGTR_TYPE_SATA_0		2  /* SATA controller lane 0 */
> -#define XPSGTR_TYPE_SATA_1		3  /* SATA controller lane 1 */
> -#define XPSGTR_TYPE_PCIE_0		4  /* PCIe controller lane 0 */
> -#define XPSGTR_TYPE_PCIE_1		5  /* PCIe controller lane 1 */
> -#define XPSGTR_TYPE_PCIE_2		6  /* PCIe controller lane 2 */
> -#define XPSGTR_TYPE_PCIE_3		7  /* PCIe controller lane 3 */
> -#define XPSGTR_TYPE_DP_0		8  /* Display Port controller lane 0 */
> -#define XPSGTR_TYPE_DP_1		9  /* Display Port controller lane 1 */
> -#define XPSGTR_TYPE_SGMII0		10 /* Ethernet SGMII controller 0 */
> -#define XPSGTR_TYPE_SGMII1		11 /* Ethernet SGMII controller 1 */
> -#define XPSGTR_TYPE_SGMII2		12 /* Ethernet SGMII controller 2 */
> -#define XPSGTR_TYPE_SGMII3		13 /* Ethernet SGMII controller 3 */
> -
>  /* Timeout values */
>  #define TIMEOUT_US			1000
>=20
> @@ -185,7 +169,8 @@ struct xpsgtr_ssc {
>  /**
>   * struct xpsgtr_phy - representation of a lane
>   * @phy: pointer to the kernel PHY device
> - * @type: controller which uses this lane
> + * @instance: instance of the protocol type (such as the lane within a
> + *            protocol, or the USB/Ethernet controller)
>   * @lane: lane number
>   * @protocol: protocol in which the lane operates
>   * @skip_phy_init: skip phy_init() if true
> @@ -194,7 +179,7 @@ struct xpsgtr_ssc {
>   */
>  struct xpsgtr_phy {
>  	struct phy *phy;
> -	u8 type;
> +	u8 instance;
>  	u8 lane;
>  	u8 protocol;
>  	bool skip_phy_init;
> @@ -331,8 +316,8 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
>=20
>  	if (ret =3D=3D -ETIMEDOUT)
>  		dev_err(gtr_dev->dev,
> -			"lane %u (type %u, protocol %u): PLL lock timeout\n",
> -			gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
> +			"lane %u (protocol %u, instance %u): PLL lock
> timeout\n",
> +			gtr_phy->lane, gtr_phy->protocol, gtr_phy-
> >instance);
>=20
>  	return ret;
>  }
> @@ -647,8 +632,7 @@ static int xpsgtr_phy_power_on(struct phy *phy)
>  	 * cumulating waits for both lanes. The user is expected to initialize
>  	 * lane 0 last.
>  	 */
> -	if (gtr_phy->protocol !=3D ICM_PROTOCOL_DP ||
> -	    gtr_phy->type =3D=3D XPSGTR_TYPE_DP_0)
> +	if (gtr_phy->protocol !=3D ICM_PROTOCOL_DP || !gtr_phy->instance)
>  		ret =3D xpsgtr_wait_pll_lock(phy);
>=20
>  	return ret;
> @@ -678,73 +662,33 @@ static const struct phy_ops xpsgtr_phyops =3D {
>   * OF Xlate Support
>   */
>=20
> -/* Set the lane type and protocol based on the PHY type and instance
> number. */
> +/* Set the lane protocol and instance based on the PHY type and instance
> number. */
>  static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>  				unsigned int phy_instance)
>  {
>  	unsigned int num_phy_types;
> -	const int *phy_types;
>=20
>  	switch (phy_type) {
> -	case PHY_TYPE_SATA: {
> -		static const int types[] =3D {
> -			XPSGTR_TYPE_SATA_0,
> -			XPSGTR_TYPE_SATA_1,
> -		};
> -
> -		phy_types =3D types;
> -		num_phy_types =3D ARRAY_SIZE(types);
> +	case PHY_TYPE_SATA:
> +		num_phy_types =3D 2;
>  		gtr_phy->protocol =3D ICM_PROTOCOL_SATA;
>  		break;
> -	}
> -	case PHY_TYPE_USB3: {
> -		static const int types[] =3D {
> -			XPSGTR_TYPE_USB0,
> -			XPSGTR_TYPE_USB1,
> -		};
> -
> -		phy_types =3D types;
> -		num_phy_types =3D ARRAY_SIZE(types);
> +	case PHY_TYPE_USB3:
> +		num_phy_types =3D 2;
>  		gtr_phy->protocol =3D ICM_PROTOCOL_USB;
>  		break;
> -	}
> -	case PHY_TYPE_DP: {
> -		static const int types[] =3D {
> -			XPSGTR_TYPE_DP_0,
> -			XPSGTR_TYPE_DP_1,
> -		};
> -
> -		phy_types =3D types;
> -		num_phy_types =3D ARRAY_SIZE(types);
> +	case PHY_TYPE_DP:
> +		num_phy_types =3D 2;
>  		gtr_phy->protocol =3D ICM_PROTOCOL_DP;
>  		break;
> -	}
> -	case PHY_TYPE_PCIE: {
> -		static const int types[] =3D {
> -			XPSGTR_TYPE_PCIE_0,
> -			XPSGTR_TYPE_PCIE_1,
> -			XPSGTR_TYPE_PCIE_2,
> -			XPSGTR_TYPE_PCIE_3,
> -		};
> -
> -		phy_types =3D types;
> -		num_phy_types =3D ARRAY_SIZE(types);
> +	case PHY_TYPE_PCIE:
> +		num_phy_types =3D 4;
>  		gtr_phy->protocol =3D ICM_PROTOCOL_PCIE;
>  		break;
> -	}
> -	case PHY_TYPE_SGMII: {
> -		static const int types[] =3D {
> -			XPSGTR_TYPE_SGMII0,
> -			XPSGTR_TYPE_SGMII1,
> -			XPSGTR_TYPE_SGMII2,
> -			XPSGTR_TYPE_SGMII3,
> -		};
> -
> -		phy_types =3D types;
> -		num_phy_types =3D ARRAY_SIZE(types);
> +	case PHY_TYPE_SGMII:
> +		num_phy_types =3D 4;
>  		gtr_phy->protocol =3D ICM_PROTOCOL_SGMII;
>  		break;
> -	}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -752,22 +696,25 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy
> *gtr_phy, u8 phy_type,
>  	if (phy_instance >=3D num_phy_types)
>  		return -EINVAL;
>=20
> -	gtr_phy->type =3D phy_types[phy_instance];
> +	gtr_phy->instance =3D phy_instance;
>  	return 0;
>  }
>=20
>  /*
> - * Valid combinations of controllers and lanes (Interconnect Matrix).
> + * Valid combinations of controllers and lanes (Interconnect Matrix). Ea=
ch
> + * "instance" represents one controller for a lane. For PCIe and DP, the
> + * "instance" is the logical lane in the link. For SATA, USB, and SGMII,
> + * the instance is the index of the controller.
> + *
> + * This information is only used to validate the devicetree reference, a=
nd is
> + * not used when programming the hardware.
>   */
>  static const unsigned int
> icm_matrix[NUM_LANES][CONTROLLERS_PER_LANE] =3D {
> -	{ XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
> -		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
> -	{ XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
> -		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
> -	{ XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
> -		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
> -	{ XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
> -		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
> +	/* PCIe, SATA, USB, DP, SGMII */
> +	{ 0, 0, 0, 1, 0 }, /* Lane 0 */
> +	{ 1, 1, 0, 0, 1 }, /* Lane 1 */
> +	{ 2, 0, 0, 1, 2 }, /* Lane 2 */
> +	{ 3, 1, 1, 0, 3 }, /* Lane 3 */
>  };

Feel this change reduces readability and introduce magic values
for icm_matrix and num_phy_types. At times decoding these=20
numbers can be hard.=20

Can we retain deriving num_phy_types from ARRAY_SIZE(types);
and also defines for ICM matrix?

>=20
>  /* Translate OF phandle and args to PHY instance. */
> @@ -822,7 +769,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>  	 * is allowed to operate on the lane.
>  	 */
>  	for (i =3D 0; i < CONTROLLERS_PER_LANE; i++) {
> -		if (icm_matrix[phy_lane][i] =3D=3D gtr_phy->type)
> +		if (icm_matrix[phy_lane][i] =3D=3D gtr_phy->instance)
>  			return gtr_phy->phy;
>  	}
>=20
> --
> 2.35.1.1320.gc452695387.dirty


