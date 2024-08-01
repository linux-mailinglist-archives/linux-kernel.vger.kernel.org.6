Return-Path: <linux-kernel+bounces-270565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FEA94417E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39CE4B21C62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619C13C9A3;
	Thu,  1 Aug 2024 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZ1oLLlk"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013056.outbound.protection.outlook.com [52.101.67.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71BF139CE2;
	Thu,  1 Aug 2024 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481179; cv=fail; b=JWj1s3pG+dOntk7hC3VpuCRr+R3ohpxH+O4+Fs1UZCqEt6lSytFxZyS+oqlLeStZZq5s6IJ5iK+OadchbJI1SoWyn64FWga+bJGIpi/88/N3aXl1frPbmg2xlP8BMc+82cg+KBA1qN0djl60imMwJBhn2eZdr+ZcLEzyW6So0rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481179; c=relaxed/simple;
	bh=CeFsNa3lY3cLUEGG1/GlTrmIdv8MLMWhl+C6VqBijdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QQEaSfnT+JaC5UZNVYzrAUN0s7JOXBywd9DwxtxsZdttzkZejEsR+64Cy3IzOahY8gwyVrtm/uYqHZOStpGYgS8iKRLY5e7qoQ2+JDGdH4y70OoZkOWog4FuZ1cBhXWmd/rt+5cAGxWwTKnLajcnXQ7nPK/z8dfWyD0uZ3q+uPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EZ1oLLlk; arc=fail smtp.client-ip=52.101.67.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6U2bPDrSCu3CMdqEJv1kX7yTmq8skD+eWBH8WU/nDEqU/zoq7Pw0W+uXdXob9eOfmI3dPz+pGMHw2Ud+QYJgLEWUTvwpDHB+g4dJxwf2p8brV6JMjtQYYbe5UeWlPfTc63pDsad5xIqhZukDK7VSSvwNYfvjqweM+YSI8XMJMV2HI3jzi0go6MshlRUghx9tUyWq9r6S2BcjdLKMWkHnGv91yyDvJK9qeAWil4tKbKyEKRVB2yh1DRl9mVyLJrNcubKYrxTY2idd4rbKSnSjHBkLGumNkJvQgHuLevSrabRftPZO3yvG/nSl4K2zFMfjEEwhf5E9gNvKgKcAb2ZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeFsNa3lY3cLUEGG1/GlTrmIdv8MLMWhl+C6VqBijdI=;
 b=F9WGr1eqEyu9Q9q9QgzWU39wvm0IXYSq3PyhitzwXLLgOwj+WOpzE1CsbkdYD7/pQEHdiW2POqQ6Rn22KXA1JTym4ZfhqJRzvCdUQTUdOUe0+crDr5eEEemBcHnndeL0EsDCRi+vVycZANiU4/jLtaUmv154ugSjeCOzQbvEYHoMjp++NcQkvh/EeL1tbxEmfJmHdi5jZay9IH/1ZwZj6WQbnht6xvyQJ7mL7YXuq7PYq9TIx0t4jZFjZRXPUwV3H8c7vzuuAzI1L22cfVeKdYHxtsHE4YOD1FtI2urQ2WM8MLms4q0HWg//tUuNP1XeXoi0Xr1zwmST5W6GBQxYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeFsNa3lY3cLUEGG1/GlTrmIdv8MLMWhl+C6VqBijdI=;
 b=EZ1oLLlkmg93IJ5mSAjY/0AuoeNgx3MVHiRQ8/TfP3KZIW98Lj+XXUJkiiVZUMdaG3YyD5tzPhd4PjIVqGGZ33BI5tK87RcSXdRltCdTmWSS/ycWnbhJfKSbXWIai1AvLWCHuNm+2q+YnTrvXNpxwiO5edJrTVa7ggFFuUQGp76tbYSoBtaD3yKbDUPvU7/IBhEhZeO22al1Rjv8qwJemzR2uVgcxnLuOVY06RaJ5zCD+b9axv9Ng8RCovLJX5OU60J82ptGxMkRAdXZLbOJrV3sOsHCXIuQXUTrvwJ+BUx+sYHUBJWdDMG8BxF/BPgyeZw7Llv9LBYx3nWvWN2HiA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 02:59:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 02:59:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux@ew.tq-group.com" <linux@ew.tq-group.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/14] arm64: dts: freescale: imx93-tqma9352: add eMMC
 regulators
Thread-Topic: [PATCH 04/14] arm64: dts: freescale: imx93-tqma9352: add eMMC
 regulators
Thread-Index: AQHa3cl2jqxfhUyoLk+QbqKdPKDUQ7IRwgng
Date: Thu, 1 Aug 2024 02:59:34 +0000
Message-ID:
 <PAXPR04MB8459845C4CAAC6B671F4DE3C88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-5-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240724125901.1391698-5-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: 427a92bf-4f11-4bce-6d8f-08dcb1d5f92a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qPhewwyTcDVNjT+D1kN33t731mUXJ/POzp7ztEzl3GmzsKvOM5f8eI+Hq1SX?=
 =?us-ascii?Q?Gl3jZ27SfmYd7HDInQw+hy02pcnKSd05a6odSOjwd34llblo/z5BJqQga7HM?=
 =?us-ascii?Q?P3SreZApGRkfwYDG6ndcuFTt9ZBlD01dzP/gWb+/SDXCcGhR6dDX+0u1e8fT?=
 =?us-ascii?Q?PZkeVKboW7IzrOtrKhBZ6frpBdt1lvghLbj+CxhS3WvsHOh3yn8fb6wheXJp?=
 =?us-ascii?Q?b+1dq2OjVQ9SxHWL0PDBycqfkvWNwa19GSyAol8Q/ycwpWS5xkVB2v1bNTJV?=
 =?us-ascii?Q?eizMtx0sjfDshxOqNA6BerOMIDE5oj6GE0eNWYVnIW+/ucXFmUzA5NnxTXmW?=
 =?us-ascii?Q?Ca/rFpdiOnnuMYdFQLYbPsmfXLAp0Aekuo4Osy86uG8wUAownlYIG7FeigWv?=
 =?us-ascii?Q?KfVwOf5mTjw5oQB9KvBEr4ChfPlhlZ71eZXjZpZnh+RwrGqKarOg3y8RvYvl?=
 =?us-ascii?Q?8OodrSHqiuNF66mf+Xm6wXXRc2mpZzLhWeQt+kdDWkupKOCAIy7RdJGuynKl?=
 =?us-ascii?Q?l9rPN1BDq+R9NNC9A91qFd21dJ2GsaETS7HphuidHPgDWi9qxyzPGIigFd41?=
 =?us-ascii?Q?si2pqrshS6eI4fmkp134aNFR0kRyjNY0x/NDzH/isJ52VhB9496ZVZxUkd/h?=
 =?us-ascii?Q?MzmCKyS60/5N5XPrEITWdg/cuFbeaOzRELiRxTJCs2WgDmWJFn8iJ/mSxZzV?=
 =?us-ascii?Q?pS1mj3LgjbIpoFwDt/8qmkixBQPsWDA2ooWIK9pajdZ3r8Bj4d/ClO1qdwXI?=
 =?us-ascii?Q?4R28FNNXLxhXBebi88CoR/jDGWtXIOQaeQHUsCTCOWYYDbIweQmFmcIay08s?=
 =?us-ascii?Q?d3drKtKHNnFyGku2aUSxg8DhOPhLzPosUjauu+BlWmPyzdT7hH13P3IG5dme?=
 =?us-ascii?Q?t0gJ0oRSxpx4oA7rUWVWdJIXrFfheBT9w+CTSeNV7FTba9et98BR/KzV9Kou?=
 =?us-ascii?Q?uLW/9QbKaJxfjwH4NsUUeTto2phKc5zzkpREd3xgB5SDS79zjtr3Mb/ZhX73?=
 =?us-ascii?Q?Cp3M/UQKwzwGvMmFh3CyH8ODfG58j1eSvCjUNEJrxmCAlW4G4ft4tc4Q5KA2?=
 =?us-ascii?Q?K6AfJ7dba5/uK03eUgEpuiAcJr5spy0ZzPZfH2XivLfhvSjmy0pOcxvoxL0H?=
 =?us-ascii?Q?hZfZa2jOHyvXSspRl/vDkyUtDTlqxqITfq54ljpSvhb55O2maDM53yt6wyr0?=
 =?us-ascii?Q?ccizMtUhsIgGLqIOxnbspTjPxknSCW6KYBdeVVX2B6xbi5fWMHSRyTKgYSrR?=
 =?us-ascii?Q?eqTD8JmptGWlnLtHxj3FPDwG5vqgkj7I4Jw8UCtcbb/esXWpiM2ZvwgtHIAf?=
 =?us-ascii?Q?Wgt6zOOBeZrismzxjrhLt68oymko8LcYvq4JcXeYc6e0T2nJsfdy5jx5O9tK?=
 =?us-ascii?Q?x/E2Lykpb4okWkcB1txkFsrjELPn9+5OgjnYaLRjKUGbeqOjnw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b6yNw/7x1/SFOhX2adCyCAxaJVbbpoBdVr3atqF0fUfRoQ5F6XMlcDVuxVQ6?=
 =?us-ascii?Q?3/rb0PY2aln80l+3TxLQveo7sqVEfBduU/wByzulXcS6IxulMR0Z5DJDKFhx?=
 =?us-ascii?Q?EGO3kHyyuKJ4/I4hXWasP+Xy+bavyu4SbJ0XBpwLliwFs5wS/Jb2zCEumzFL?=
 =?us-ascii?Q?sREJgd+mBfZm0ELImSLgE2ilh4Yrx8z8ZmD2QSsS7kBDNxIiHCOK8cePc/eU?=
 =?us-ascii?Q?AuvoYZAco4z+jUZs7NLHq/AzAR6nen0EF7zqJDEUZs0smcZWhJQxmDbFALxt?=
 =?us-ascii?Q?pBnvwiC75oTjRX6HGozDdmK9qmWs9QN5YBNwMPdY1mHO+9t2PZ5Pk7bemAvZ?=
 =?us-ascii?Q?27T9Ly2/Gj8Jq6Z8zWN35zvQufZmdffEBKzoD76BCYvY8nnIPGT8rUxl8BL+?=
 =?us-ascii?Q?g6ael9TR3+P9f+jX52nTWsOqZ3gCWS7EWF9Mu73PoFtM/ykAWb0i+Q2PbkLh?=
 =?us-ascii?Q?Fz4wbQyH+fmMksC8y3JPbb+Mx3v0/zZxttk4s6mBtR9ZXxo0r6gPxT+H0jwt?=
 =?us-ascii?Q?xIHBEXC18E0J7Jkh4/wqxyR3YbLWG0Y0J/t3xH+gg0FMQVc/pTUxHMKB/D68?=
 =?us-ascii?Q?vXaYEg4gk2OIfDfcFSXabLoi5hU+0v79nVZFW8r/RsTWJgVJg22C4wMVipXC?=
 =?us-ascii?Q?veHen7Y4XVCfsmhdD5MDNLj4044kKbPAXv8qWqN/J0kl358vXqJ65kcny+ya?=
 =?us-ascii?Q?B1aGmg1fZpMx+UGot/DSD1qH9Prwzx4bsRo8PrMZ16kXDd3IJEYMIVrTGns2?=
 =?us-ascii?Q?YPS7aaa9+dVXDNeR3fpAOKY0agIKclPu1djSJGTTPAw1MWhrQ+1f5B/8pHCH?=
 =?us-ascii?Q?SqgQr2H6Ad01EwuOLYIfNLqfQ9pKPHFp098Z1xE/LMwcge7a4ynjlKPEEuQ1?=
 =?us-ascii?Q?PFrmjsHf8XIvIYo7F3dLIvQVCf1MmFA4xBlCLfsPEfELgAnZBFYqG77QdEgk?=
 =?us-ascii?Q?5RUqZWAt//eHLBmNWXLlrLJUp2PodVIIymIb3Z9spXi4GgJOEKZCKMUyjv5H?=
 =?us-ascii?Q?5WZslRD4xUsd7WcA8XQKdUo6Y3YbIItHi77Na3jxOEgp/jiHcu+7H7TbObqg?=
 =?us-ascii?Q?H9cNyvQAgyC7a+l64zqtZ6dp264n8jnrmbs2SbJd/SNqsuX0s4i+21gsmR7f?=
 =?us-ascii?Q?fu4eA5Ive+yQ5S/CqskD9Qhg3m0k1BCpMLlzAg+Hc8XQYZAugjXtYJxhOnP8?=
 =?us-ascii?Q?d87oi4ury/UkkFuAqWz/SGkkdsNJ0hCRD296v6MA6et62bfvFDk57qYchAiV?=
 =?us-ascii?Q?hqnqLzu8zpPlFvVEyLTNLt4O3KAXe075RGZUWxjACSrujCQFrjiAB8geGnXV?=
 =?us-ascii?Q?bD7K4YbxGG1eQ7r8FFiReTg+hoxCnSERkE2t+AeKpTF4EsHmvQCAtMCrMZrh?=
 =?us-ascii?Q?AKwq/9J1zqPYrTLjSnhi1q3HI+uWuW/xB7DmCfHpqSoz0mrNkYD6AZnPTZ9w?=
 =?us-ascii?Q?I4am1u6QdGEpyl0DOOTCGApOzlQs8p2eEIvl6zi8F2fAksdmfOZn/rdUelkB?=
 =?us-ascii?Q?UTSEiQbVoeLCD0MqguuovhhKiouZy4ZuN4JVkb3rZxjnJCqCcQZ4nT+oAhHB?=
 =?us-ascii?Q?b0RXWkBDWwLZ87HHgF4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427a92bf-4f11-4bce-6d8f-08dcb1d5f92a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 02:59:34.6146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGxUFbHtKzIbBuq3nsmPtrcTZ7me9TLmC07KC1JFbITeyhBA/lstUHUbpdzvHj3Q8qULLRYdpOE8u7BHPvDoxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925

> Subject: [PATCH 04/14] arm64: dts: freescale: imx93-tqma9352: add
> eMMC regulators
>=20
> With PMIC node in place, add the correct regulators for eMMC.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>


Reviewed-by: Peng Fan <peng.fan@nxp.com>

