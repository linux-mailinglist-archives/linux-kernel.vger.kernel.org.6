Return-Path: <linux-kernel+bounces-219726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF090D6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A191F24946
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C154D8CB;
	Tue, 18 Jun 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P4kDpNwW"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2084.outbound.protection.outlook.com [40.107.6.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8E4D135
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723591; cv=fail; b=WrfrAvoSaYEt69q1dSPPm90NxULE5Ef7Mr5/+qJjdQM7Qn+i/0djWD1NbheMihKd+bcSY469njYI5aed2TIpqL0bgdZQTIlH9RApgUZper6gzKFoRpTDGsW2nVkUggAZgXpfFdLnN9CVl8nntmwfUXJJO4ptBv6Vv473NoZJveE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723591; c=relaxed/simple;
	bh=zUu7GVI5PBIKyRZFP4OtkKKLDThNdGuQyQ2sKF8YH04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r4ODDrGU+78PsLZQiNYy0vqQJLQ97q44e2VzCT7XKx3LYlnKpKy/aWLKVLIlnMFpJBucGsiqR6fZ2mmTNFWBOSgmE+cuQx8ENOxIDs2LJWVepPsJZNRYVtWuiHSXHD/jLvrINjqO/0KFjmhPUs0jGLfxdJ7F4h0bzApd2Luvfxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P4kDpNwW; arc=fail smtp.client-ip=40.107.6.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpHYHJq89ParnLivB5Kg9gNmo+hwryVFVpd75oPsLDwWCvtO4sPpD6ReeJv9LBQ2rWiFlSg5uFaQjEqQ0kFDrtw+GBzmxc1MUPv++N/aoxr1QLWwhwrArGGgh8DlEhEHM7AWuA9Ew5sfQYGtAx8xkOVAf8qV3x5Hxh12rE3AoaED9aHL/M9yq14s49+kFLGcIW9Cp3qRO3YqdR4jlo4lX6DXSS4HhKW+9cZKN0JAQOpWdA5X8ePc75zBjI9dutpq0ge9EfzKbKZFt+rq2nI4TLsd3uTgeqLt4n00vTybGuQ25kqL1nuSTdksBRxGooHhmCrf8ZwWsANXypEN0w9rZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr5jB4FBNzKsSRpXIJjNCoMukhYMPPNAIVUHvJzKIyg=;
 b=DYY5BjvgvxcGi6MAc4ciE82mbw7LD65ZlVdMou36lzsRukzhHy0rUJbegPAQ1iAbCjH6KzGIKjH2k+9pm1ShxddRcsG2pT6kBSxw2QJZF+ie4Szx04t1PW5aJRsf35/QknYQ1tXcejJ3l3STkK9MNNPU1wtX4LxPetATJ5g/tjl5CXkjDcVQnQVDtBj9wE/4yb90g38ptjU6aQlx3dJNpqfmHEXCpEzo0miy2SEIuhd914YTNRw2xkMxBMPRajsEtxz53WEBmOlJyEM+7rWngvMo+UyKapQdIJ4t5fOpHE3nkIu5JnlQAK+kvaz/luIIGtu5tdxC5y/sURqO+zYYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr5jB4FBNzKsSRpXIJjNCoMukhYMPPNAIVUHvJzKIyg=;
 b=P4kDpNwWlBCaBYOGTz+31VBA0C3GapImclnhmR8vZWhP+ViKv6ERvbc/8Voe70fSvNLgUdHLRfaNLwcksZIkE2rtuxBzBEfo7ZroabBM2PQh7Z3Y33IvtNnmZnVQqvyixCV65SKbMh9rf9kgXfyKyN2Rd0OBi0fTbXlKGARPhYE=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI0PR04MB10637.eurprd04.prod.outlook.com (2603:10a6:800:25f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 15:13:05 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:13:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Jassi Brar
	<jassisinghbrar@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] mailbox: imx: fix TXDB_V2 channel race condition
Thread-Topic: [PATCH] mailbox: imx: fix TXDB_V2 channel race condition
Thread-Index: AQHara6pB5d0fDZleUSTT4bcpXDYYLHNyHvg
Date: Tue, 18 Jun 2024 15:13:04 +0000
Message-ID:
 <AM6PR04MB5941581D46DA309123EE528888CE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240524075632.1009044-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240524075632.1009044-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|VI0PR04MB10637:EE_
x-ms-office365-filtering-correlation-id: 84c3e3d9-4044-402d-b448-08dc8fa9271b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U82zqxSgF565srM5Db9gtOxx+6fMTUixWlX+1yY+d1ZQEC94aD1JmSoN6ecE?=
 =?us-ascii?Q?omX1lSXgNnYoj1DHy4I8awguOEC/T/LPNF88PAHJjDnCr51qndmsmS6xsLV4?=
 =?us-ascii?Q?/Yqggx4VIYNBpV0FQ8TMVQfTRbiRv17mwxxVB6I5laEhlq3mv2CXBa/Ys337?=
 =?us-ascii?Q?PRvLGNK4rfWPOuNvUKwWriWGooe3lyvk0hMnF/3cq6x4D4gQVFLhp+N5AKNZ?=
 =?us-ascii?Q?9itzzUTeabwm6MoZMWNOMXbHN3Bx0xWIpHElJ0SDtq7clYX+4ghnVr8RGUxl?=
 =?us-ascii?Q?dlnv0Q6ttJ3lCxc3t2BcJK2HkrRmE28CNkPhb1Lv2ZoXO8QjNFxK89ikv1M9?=
 =?us-ascii?Q?n6QnuEytkK+izUtq0SKm7ZyJ4KeYE53uFahjvk7EaghyoT7zujXFMwLqsycQ?=
 =?us-ascii?Q?2l1uXYjlGrrMRXFZTJcjyH42JFTvgBte6GfjX1Hw0Z9UGM6AmEN4zb6OjZSJ?=
 =?us-ascii?Q?eSCnezh6AOcSgaZNun5dpsG3fX9t18Fcz16Ly85b5nGZ6R4Rk5Hj9TXYIMs3?=
 =?us-ascii?Q?R/WEaoiZJ4u4axqdhT9W3DFEmjlDxQpSef31OQlqtOPSS5dOvFeycdK7RRIr?=
 =?us-ascii?Q?qNSgrSvwa2kHMQKDFFEJLYQ0C9q9RIQrxmoeFvMYcbG1Vy9WUALcuVUxXW4z?=
 =?us-ascii?Q?kkjSqcjHgizbxgqOsRK/QUsvHvWqSvKP1WJDzVF6NFdNI+vWzPSB5b0VtfpY?=
 =?us-ascii?Q?FderGG7HK2oD08OGjYsUdqlvTVuzShH2vS6OOUY1y51GmoXJ3s1ctp3sSeOW?=
 =?us-ascii?Q?bOS+bYs1Z1ocXQV2Qv5a/CXsdx8d8yOEpWH7w23bJbANVdgFytoYHbJ1xOTf?=
 =?us-ascii?Q?TQGJ/pn1Tw3gx9DH8iKrdvP7+w4QLhGuQ2ZG76JhYurlM625/xFfn74GbcAA?=
 =?us-ascii?Q?bP0yudpZZ18mmcrO5EY6rL4VzxwilXjjwYScAC9zpwGY2x4U0tsHgQ8ofb+M?=
 =?us-ascii?Q?jKvtG9OM8HfV9Huyy14dvh2byjVkSRnKFvwoW/9cr4Nj/2mbEP6cjUlLyMKI?=
 =?us-ascii?Q?/uoALTyRCFLlBd+6TvaQcwxdhJ/RUfH3AZy78qbNYL2JXIqrAIl+1G60gxnY?=
 =?us-ascii?Q?DSnPAvYvsj4MON4bibGMmsJAG1szFKajHhmhUXLCiHjL9Lw1qkMiGzgVSXT5?=
 =?us-ascii?Q?7Fb91JSM6HNXIZyDWYAROnOMcrdFbTw/FpSVYm3UaW+wGK6M6XLiTWU7nq4R?=
 =?us-ascii?Q?TCyK6N9KxJZMnOxu9LMPUB58MkXn+Mc5IvehNyeY6lAYVoM6p8o0Yj3pmdal?=
 =?us-ascii?Q?LT9ObZekU56YLM7gb64noGv+IGV+47E29WfP1JnKE11FtzwpbCmItYOPdu7G?=
 =?us-ascii?Q?i27+izVCHI3tPt46hp6pGaO8SpiNrTJTT/HANEfO3JZ2hBJOJ9Q2424I8eas?=
 =?us-ascii?Q?uvooNIM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cGQhMM3cPMPvVGtef4rGZ0pZNYn0PkO99FcVCWYlgQheRwxDweOWkrAW2zwV?=
 =?us-ascii?Q?t4VN4WbBxelqxUtXTKzbDt5mfZmbVDaWh1l1L64JbvFyUT2khNyXswH0V/RG?=
 =?us-ascii?Q?ikI22TxhSNn8v/ggM1Bvn56/hz3ed6m0+xo+51EWe9vx+1UC0NzbGvPm347D?=
 =?us-ascii?Q?i5CmLQqTqsEV0yr5tjXQdUUo59NoC6A3MMYtqVW9Tkg2/7hjTvTpj0O4iCt8?=
 =?us-ascii?Q?jcEAj9bod3tWZCBOr5PVpTfytI1/faa9jUirYNNKhItHsSbWPG5xKyxqHZg+?=
 =?us-ascii?Q?8INKGMqYa/nMKVHiRe5TwNRIKBh/HUDN2dg7oKPUzMqZqTeY6PQT/7stud1s?=
 =?us-ascii?Q?0WjVsUjmzgGpNPDaJ8BoifCkQ0mnDiiSgolFfiUt4FwkxT2nBRrXGEJA9Xt2?=
 =?us-ascii?Q?QWzNV+v+tDzF7Eg0c3xRmK/3MUAomAct5Cak0CDx+jjE7N6jWwksuAOsDTdG?=
 =?us-ascii?Q?aUYJvHogcIlgjA1iavkaaGaDcsd61sPVYsI/BiMXEMofK9qzpk1FWxxFTQkK?=
 =?us-ascii?Q?TBpGsdJYGsgd7tzFjxcdBhsOXwsXqyHg41qC9mOnMh8csO2w6SvshhrI/Q9e?=
 =?us-ascii?Q?4JBl9XlaPDfFE5Z3b6f7QtdcDZSWiJeBqCPxDB/KTGWkXs8uK+O3uGSVZIRL?=
 =?us-ascii?Q?P8azBzrRdv/NrHr1PcAiRGPIFbZesJdm/uP94i6wyXJFMd53/oRKwO7Z+uhv?=
 =?us-ascii?Q?aivatNdjVO6PLeGeHuAxdX0mYHR+1kk+CNgG4zW8+xM7jRW2LqpPJFVeAef+?=
 =?us-ascii?Q?iZd1wjXj8zf7Qz8mNXo8bGBVPK5FediggVZkpHTNKZl/m+ms/c4J/sTnq9XE?=
 =?us-ascii?Q?ZU/fXzi/Nb+aQmdzyvazaQoFmA/1LKZ4KShNuyq8vShQguDe+ZRthoWNGz72?=
 =?us-ascii?Q?0Tdpt2BNyNUsc6kAUOKEIUNdUkSDlM1SaG9XUtxSAIDdVYYs6HODuIfh7cQJ?=
 =?us-ascii?Q?QvgCbcHSJPF7sdftvdPXIF28pk1Wg/aB07j0igai4SORFp0lIm2bkuKPEby9?=
 =?us-ascii?Q?KzxOZymcXmnTzYx0RzTH9l3krURkrWj9hS3HHxf13mwGPCdatLlNnrgFA72Y?=
 =?us-ascii?Q?ewnGx2cNNSWY5JsvOzneJGP09DV1YQry9Uil+jbpu9F+V525VAluytJFafPM?=
 =?us-ascii?Q?xhz320snIB20ubcWpYY+4vfgFseOLH+HLZXUbUKWcEi05kcVhgOxT27YX0ww?=
 =?us-ascii?Q?yYzijGmFs+ldyR8FfMcWzihPc5oneQR2+ayuLsMOtd+F+EUEc1ois1KyyKtJ?=
 =?us-ascii?Q?r3bkxVS/Tgk6bgIJNT1RnJmiJZyHoDo3spnXHktT+8Ygb0ocICKuUCtx5tzF?=
 =?us-ascii?Q?0fhWfxyq0g3QCddxsMaLRnU6Jcr8p19ybiaAm8rKuSx8cZ54kv0Obu3hEkIV?=
 =?us-ascii?Q?Sr2A3DRQ08LPtOLLU+uMuPOi40hvIG/k9Q19kWl77kMwr6TV0EiJCnjbZW0d?=
 =?us-ascii?Q?AC8jZi8dXPa6RA/D2WODrgAlmiJyJHLPAto6oaoW5Ia8aJGszidRmxcIpsga?=
 =?us-ascii?Q?ubXY0fjTYFNSn4xdbU9PwGcdGLtO7Gtzxgo3VCInv0inJoLBkOtxndvY3U0U?=
 =?us-ascii?Q?EhP0TJb0Sq33LHyBoE8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c3e3d9-4044-402d-b448-08dc8fa9271b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 15:13:04.8044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ehvAr0NEFz/SZAA7YKM6jPhMvjHhRdbNL7tr53bbOUCU7AayNIEJDR/VcCm3JbXRQHQWu/LKK9/p8xFpDG1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10637

Hi Jassi,

> Subject: [PATCH] mailbox: imx: fix TXDB_V2 channel race condition

Ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Two TXDB_V2 channels are used between Linux and System
> Manager(SM).
> Channel0 for normal TX, Channel 1 for notification completion.
> The TXDB_V2 trigger logic is using imx_mu_xcr_rmw which uses
> read/modify/update logic.
>=20
> Note: clear MUB GSR BITs, the MUA side GCR BITs will also got cleared
> per hardware design.
> Channel0 Linux
> read GCR->modify GCR->write GCR->M33 SM->read GSR----->clear GSR
>                                                 |-(1)-|
> Channel1 Linux start in time slot(1)
> read GCR->modify GCR->write GCR->M33 SM->read GSR->clear GSR So
> Channel1 read GCR will read back the GCR that Channel0 wrote,
> because
> M33 has not finish clear GSR, this means Channel1 GCR writing will
> trigger Channel1 and Channel0 interrupt both which is wrong.
>=20
> Channel0 will be freed(SCMI channel status set to FREE) in M33 SM
> when processing the 1st Channel0 interrupt. So when 2nd interrupt
> trigger (channel 0/1 trigger together), SM will see a freed Channel0,
> and report protocol error.
>=20
> To address the issue, not using read/modify/update logic, just use write,
> because write 0 to GCR will be ignored. And after write MUA GCR, wait
> the SM to clear MUB GSR by looping MUA GCR value.
>=20
> Fixes: 5bfe4067d350 ("mailbox: imx: support channel type tx doorbell
> v2")
> Reviewed-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V1: This patch has got R-b inside NXP and could be directly applied to
>     upstream linux, so I keep the R-b tag from Ranjani.
>=20
>  drivers/mailbox/imx-mailbox.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-
> mailbox.c index 5c1d09cad761..38abe07babdf 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -224,6 +224,8 @@ static int imx_mu_generic_tx(struct
> imx_mu_priv *priv,
>  			     void *data)
>  {
>  	u32 *arg =3D data;
> +	u32 val;
> +	int ret;
>=20
>  	switch (cp->type) {
>  	case IMX_MU_TYPE_TX:
> @@ -235,7 +237,13 @@ static int imx_mu_generic_tx(struct
> imx_mu_priv *priv,
>  		tasklet_schedule(&cp->txdb_tasklet);
>  		break;
>  	case IMX_MU_TYPE_TXDB_V2:
> -		imx_mu_xcr_rmw(priv, IMX_MU_GCR,
> IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx), 0);
> +		imx_mu_write(priv, IMX_MU_xCR_GIRn(priv->dcfg-
> >type, cp->idx),
> +			     priv->dcfg->xCR[IMX_MU_GCR]);
> +		ret =3D readl_poll_timeout(priv->base + priv->dcfg-
> >xCR[IMX_MU_GCR], val,
> +					 !(val &
> IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx)),
> +					 0, 1000);
> +		if (ret)
> +			dev_warn_ratelimited(priv->dev, "channel
> type: %d failure\n",
> +cp->type);
>  		break;
>  	default:
>  		dev_warn_ratelimited(priv->dev, "Send data on wrong
> channel type: %d\n", cp->type);
> --
> 2.37.1


