Return-Path: <linux-kernel+bounces-412056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFDC9D032E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108441F21893
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C3143C69;
	Sun, 17 Nov 2024 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZthAnym6"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076911CAF;
	Sun, 17 Nov 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731841522; cv=fail; b=Lj1hENiIhxMEqTCgRptgBhLsMDM1uw+oUkHQy56q/vn1i/YaDw/vf6oLyIIM6uT5DmSiPSbhzVAU/tayk4xOsrZw6cobdZXX0ixTByxjReZzRY2LCzCxWC23y2y2JIQEyhJ6OxNXSl4XYO10HwIYt7AKfGadKtBajp6UiCPU4xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731841522; c=relaxed/simple;
	bh=XS6GQ3/cQo31G1bx3cXNgo7Wbc0Xuzh/DWFN+PanUjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KFEMNwf38i7MBczwsNC8PJaW9mK2jaQMYdTF37Tngm9vIdop1K9R1y50+Oxy6tW32giDk5fMCJUvZA259CfwPQVx8bjBVNAnTu9FREjQoYsn4/QHDeZKfSwhqex1JyHNV9/mOBjgjZx1BcnFwFleDPPPZAv0lukJU8prE/yenZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZthAnym6; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOsGhAtj5GC/uWQF9qyEW73CICIhUoRzShIeeIl2wtsJCesbmvHiPHUWV/tpOQn07GeojSH0zf1KxRXK3sw3puWlqPOAPrjRM3/5XlBj1nEvuUdQLovE4g/VgUncAMKwhQQYmtkcWXNvL08q5gUJ4uK6xGtUIM+YxK05h9uk5nXFJzvHD01utB4IRFiAkmm5f6234Oq8PJvZgJdx/F3dLfy8lpBGo455YgVTVS3tMgQioTGTRKZPQpNwvZ+hm0vCq9C061SK5HRFwI465ww4G+ovLFypfc4gvEtC26x2r+9zaSvS99eWknaPFiX2/YMs5C9PFrtDDedcBpxpNXrjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BWWNVTdkNGyl8rSGU7lY6hiQeXgFE1H8FZjz0oJr00=;
 b=BQsAlODFlLdsjnECw+OH4ROIB8pIpLg30O4QRa6WFbNWuicKtcB5ncBsfUhnD+tyQatwTMZYnd98R8FXW5jz13eXvGfPHfGQRUoIrFjqYbZLuEHLATVnJblH1pnOpKHTtutqxOnmrLBy1QdNM/Hq8j19jBmBZH68mQS+jSGhRfetKQr6uCR6WCQj9OwvwAntpukc+PvVTsI3UzNh3Qa4RNDY/swD8KP1MJmCZhte1fVjjZ6DLL2HFFU59BIzv6KUCqBuG+ii2OErv4SFma2i0bnQ/YUznvOCr41TPMuJ09sP9sjyaQRXN3i/UjSOeEvOJ6Zqje3pKf6WE5KKuFIhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BWWNVTdkNGyl8rSGU7lY6hiQeXgFE1H8FZjz0oJr00=;
 b=ZthAnym6ilEOeSpbkKrsPjCbeC8Htnh+uGb5ryPJdAq7uGxReB3VC0UaRWpYAy8VyLR7376eDrqRICzpJuS48dnxbkTQ/16i840MwcJo8+N//9wiwTJgRY+ApXUpzd3AJqq2Z5zfTlrdFesMCyO/e0baFp/cKC+o3Uds9pkp+mQGwnZZ1lbbdmcLL/dhzl1HunF857Ata4LZx5tettXzfg0/0/CNnvI1Dp5qkhaRbvKXaCeOO1iGzcjXfH11F6Pr6VkeaOe/CBgq4OK+RwuLo0CM443DtdnsyKVEP1wg2rpg7OJt7s3mdWcKjAft7w3hfFWdeZaw3m77eikDU2TczQ==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sun, 17 Nov
 2024 11:05:17 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8158.021; Sun, 17 Nov 2024
 11:05:11 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, Cristian Marussi
	<cristian.marussi@arm.com>, Arnd Bergmann <arnd@kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: fix i.MX build dependency
Thread-Topic: [PATCH] firmware: arm_scmi: fix i.MX build dependency
Thread-Index: AQHbN7LzwMkd4Aivn0y4f3lE3b1b17K7QGuAgAADz4CAAA1RkA==
Date: Sun, 17 Nov 2024 11:05:11 +0000
Message-ID:
 <DB9PR04MB8461B16FE35C25C81432D2CB88262@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20241115230555.2435004-1-arnd@kernel.org>
 <Zzm_X0o-TkkGQeAN@pluto>
 <40fd6f5c-e3d8-4e75-b479-00d3f81423a8@app.fastmail.com>
In-Reply-To: <40fd6f5c-e3d8-4e75-b479-00d3f81423a8@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|GV1PR04MB10560:EE_
x-ms-office365-filtering-correlation-id: c5c7dea5-19b5-4101-37c9-08dd06f7b481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QWpBSbOCSdogALbDnI6PG8GLPPwLG7xdQxcVkakMPJk9b1PdgXxq8qrbSih8?=
 =?us-ascii?Q?bs+X1qR45bXHKO09fyb7HLQnO4tu1jKS8RJ5RmcHAF4MqsfUp4LKwQAmpOON?=
 =?us-ascii?Q?H0YqHm4hIs4cOvMNk7WmUwct2LDQId4l4tKmKQVURLghnlXYKc7gpjR0EoVW?=
 =?us-ascii?Q?cjDRjFUaTKmtlKjmEMbgjjwgBPVFFzgJzP8ksIsNXuf4HY58FB7vPl44szOu?=
 =?us-ascii?Q?hB3Jet8NGgiBHNKq3nRANEvccMxBhWCPCd9Ir8z0kOrRl/rlfrfNjISSnTte?=
 =?us-ascii?Q?vNdts0dLb8L9OFMZ25AaaZ0gdjvHJJDizEUPnW5ocRAlu/NzwArQFlDge1pl?=
 =?us-ascii?Q?II3zDuP9aYW/GrwNeMz6BOrRapNAx8TgHOXvAKiLwIoUy1CSYbhPHg9Kd8hm?=
 =?us-ascii?Q?ACkcHH2rzmdOQMnRt8Ck+jNLEJPVX3qnrqIGoJpPx5lbLcn7GW4RN9LITh4h?=
 =?us-ascii?Q?uoJ4YzDaDss3+OxQHjVRwbDFu2Q/v3wdkLSd6tulExu3oLWAY/lGZxGNnC3k?=
 =?us-ascii?Q?0XajzHq1AlMCZjeP27T5X3S7FF3/GXTx44ONtb1Q26jUPwMygouxHXKtVES7?=
 =?us-ascii?Q?LprvTOLRbJaauPoJm80aiQzn9Fr5JoWBXS3/aeg93k4ko8W6s0Qc3rea8nVz?=
 =?us-ascii?Q?gtQ+5xOBemCyf74gqkjxvVjrF1Bw7fdK+1v7e1L+obLbuxSfEzy0P5m8vFnl?=
 =?us-ascii?Q?W2FuzwdBWwaXSMgUr24GNdItFgGsuHUO/MOUt0wXit485hEdxcAM2MGhR5sf?=
 =?us-ascii?Q?jfzUbi2JvZHikeLZajh60pOFm6defAX90jBeKpG5g2LARzgLMeuVdEHJ2bGi?=
 =?us-ascii?Q?GcpRCTTz5VWRUuss9OfDDejR7hxqBTAtFqmTMI/hNb3Mm2W4Ff4chAdbmaze?=
 =?us-ascii?Q?uk9h7CaNThtnLmjzLjGv4dBRYxO//ALzAhA4ZtkphRbtZ/zTL0rNwY150hBu?=
 =?us-ascii?Q?ot5E/Yb+dPUTc/mfshVWpzyM7rlvicJLLwAtEZ4uyzSHneJOQOs+h5H7t2sk?=
 =?us-ascii?Q?h2JtoxBSwdtSjkxFMoB6XeT4ttwwV9cojnKbAmfMrguo6nev73IczP33KMuA?=
 =?us-ascii?Q?R26hurXArDTfsbAWw8Cixir2GLPrqXOKrVkoBkuV/g2dqbk7zJz/MjFxRm2J?=
 =?us-ascii?Q?2Ry0egHi5p3b3Bet+dQIlgoD9kDiLDymcgS4x3svtBg21xRACvHOXLtRf6Eb?=
 =?us-ascii?Q?tfVouhGuiCw6B112ND9qAOnl00tUVSRkWFPUPzRPaNL4lIr+dbuTD8xbNBN+?=
 =?us-ascii?Q?PR7578w6JuFEB+F43jnjcEt5RH1cyee39v+UWQZ+uItPwlHjI4eijTiFoBpr?=
 =?us-ascii?Q?mKN2WOP76eQcFnDX20Rg6weYVzW5ZeX31k8mQ3ERE81Z/YMIPjoy/p2w6Zai?=
 =?us-ascii?Q?sjBsveo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gw1swwvEyv0Tdu3NvrCQLsbWRB+5zqQAb74tXh9gGexnfbRMLoAXagQ6toVl?=
 =?us-ascii?Q?GVcmSic4dbstVi7x+5/ED61OlQuSxmnbX8imsJyc6NkaItS26rDsss4YB730?=
 =?us-ascii?Q?SBuUbRIcWxPaAGP7Y5uRKC59KI4C9sYU1g6O+OWBG4zlGVUb6UaOQhbEoUCe?=
 =?us-ascii?Q?qbZ5JjlD1hiwtfJS/t5woQ3buASFeuMli4KJE/HjdTfEc2Fl5ENh7RgcbKBH?=
 =?us-ascii?Q?UdgKFOBjYeI4YF8fb4Uk8o+AEFE9DP9oawQ9WVODVMXzYiLtRBUMzjqj/u9z?=
 =?us-ascii?Q?DODtVAUtLRbJJYROevVnG68HXrkvHtu2tcnJ9n/wD82LB+V4YGJYJYyFBCjN?=
 =?us-ascii?Q?dzFVd9UbnHKkPTXysLbAuu6N/yelmLBLwrQ8vV2amlDpSfSz52vSpG+hyVry?=
 =?us-ascii?Q?dICMm7uWk+whjFBbEerro0Zo9tGd/d0Sud93vlJQo40wNq7nyGeoqhzQOsmX?=
 =?us-ascii?Q?I711uOrjKGGzLRk6GOsiNqO4phg2mmeqRimku1wGL8Wxnxj1/3qfIATYlwm4?=
 =?us-ascii?Q?THlqRdfi+HeDtray1GEGU1/j+FR3krHH2Mc5RXrt2xNKzM9N+AnBsgOxat0X?=
 =?us-ascii?Q?zQSKnR0ytAP6Cw+rWJlbdQ4cQVxmDPSlwE4b1nH5fIqY176bLP1zFBTzJ2CF?=
 =?us-ascii?Q?EnM94tl5WEPIcytJpK/oT7dtytKYelmIJHYme/IRY+n7JkZwKT94GByRfkVT?=
 =?us-ascii?Q?T6hPVe13coWFYrRbkUnNCLXOJ9rXhiAVd2twm8ejkH5HZGn9jWm5Eg6sT0h7?=
 =?us-ascii?Q?7VUl9C7kyPcLvN+jN79kjE70X2Uuvr7GeCmMjSop+wWrqscisjtxcgreNBaz?=
 =?us-ascii?Q?LxlKbX4KOJmsW0mzmEhVIKB4S86K7EArAjwOQi2fqvoIDWICI/LhtoKvv3Yg?=
 =?us-ascii?Q?Rnu5m6VP0dx0R8yqmisbpqe0w6xIgFhY5FRPIiwecNmSML3duEP6VVtKVtm2?=
 =?us-ascii?Q?82+dVwsJ1skDUPMAG4Id+weT8YQjxouz9AjKz/UwLJM95zFEIw2336qXXScf?=
 =?us-ascii?Q?I41ieHB97j/mFzV8uMW2LybWK9p/ZlpWY2epV6yBZchR8BCW/R49E+vkLFB4?=
 =?us-ascii?Q?jI2EcMcz6+ruGFV6FJfyBRu4V9BHoybCjD+doVCxESx7TM4X3v32YMo35DFT?=
 =?us-ascii?Q?TMJEygWpUoRzNtKJ6o2K92mkb3RVrM8D5QFdRQRN2B0O81qGCL8g0VOE4gpz?=
 =?us-ascii?Q?TsVDB6m8IpYSm+9+mhb6MMN7M0DQ+S4eEmLXSB0dZTKOSkUoOymunHt8BIvU?=
 =?us-ascii?Q?JhZ/vj9UYF6LLKDryyKOQgB7dZbJh8NjXXYDUr7oWS8F/qjbD5ent72pbtaT?=
 =?us-ascii?Q?Dc9ZgDgve6zTpMs+CttHVEWeyxZwcwqTRut6qFPh/qC28Ldwu0YhZsgzYo3W?=
 =?us-ascii?Q?PoQo607MCdE/HgJeZUsjB+7VeXUvkn6otkhIET6xMBQeGXNQ8ybN2ijoXeSZ?=
 =?us-ascii?Q?FtO6scZOqzWZjhfyKYudNGk6I3DfbgwnJA1kNR3Vf6b3KcQ6e0lcuuii68f8?=
 =?us-ascii?Q?s2AXrfrEMhiuHWgxjI7QYJqcRuXkt0K7bJGhxqrkz7lU2zlIy1bNJrqgXPfR?=
 =?us-ascii?Q?LjLtVBh15UgstU0OzFI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c7dea5-19b5-4101-37c9-08dd06f7b481
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2024 11:05:11.1050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RajrL+lHZziSbt5Dvx4qrtj7RbwOtz2GjoofnkhzltwauQC2mid+oSMPBu1T6ioDE5ndEPJRY2YIp+6+L2jS1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

> Subject: Re: [PATCH] firmware: arm_scmi: fix i.MX build dependency
>=20
> On Sun, Nov 17, 2024, at 11:03, Cristian Marussi wrote:
> > On Sat, Nov 16, 2024 at 12:05:18AM +0100, Arnd Bergmann wrote:
> >>
> >> arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function
> `fsl_mqs_sm_write':
> >> fsl_mqs.c:(.text+0x1aa): undefined reference to
> `scmi_imx_misc_ctrl_set'
> >> arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function
> `fsl_mqs_sm_read':
> >> fsl_mqs.c:(.text+0x1ee): undefined reference to
> `scmi_imx_misc_ctrl_get'
> >>
> >
> > The SCMI drivers, like the newly added IMX_SCMI_MISC_DRV,
> generally
> > make ue of the related vendor protocol like IMX_SCMI_MISC_EXT,
> BUT the
> > SCMI stack is designed in a way that NO symbols are needed to be
> > exported by the protocol layer (to avoid a huge and growing number
> of
> > symbols exports)...so usually the current DRV-->PROTO dependency is
> fine.
> >
> > In this case, AFAIU, it is the SCMI driver that in turn exports a few
> > helpers that are used by another driver fsl_mqs, which in turn could
> > be compiled and work with or without the SCMI stack, so with this
> > patch we are artificially reversing the DRV<--PROTO dependency to
> > solve this scenario in all the compillation scenarios...
> >
> > ....BUT given that the IMX_SCMI_MISC_DRV is the one that should
> export
> > the missing symbols could NOT this solved in a cleaner way, without
> > adding the fake reverse dependency, by instead modifying the header
> of
> > the driver with something like the classic:
>=20
> > --->8-----
> > diff --git a/include/linux/firmware/imx/sm.h
> > b/include/linux/firmware/imx/sm.h index
> 9b85a3f028d1..3a7a3ec367c5
> > 100644
> > --- a/include/linux/firmware/imx/sm.h
> > +++ b/include/linux/firmware/imx/sm.h
> > @@ -17,7 +17,19 @@
> >  #define SCMI_IMX_CTRL_SAI4_MCLK                4       /* WAKE SAI4
> MCLK */
> >  #define SCMI_IMX_CTRL_SAI5_MCLK                5       /* WAKE SAI5
> MCLK */
> >
> > +#ifdef IMX_SCMI_MISC_DRV
> >  int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);  int
> > scmi_imx_misc_ctrl_set(u32 id, u32 val);
> > +#else
> > +static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
> > +{
> > +       return 0;
> > +}
> > +
> > +static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val) {
> > +       return 0;
> > +}
> > +#endif
>=20
> This usually doesn't work if the provider of these interfaces can be in a
> loadable module. The #ifdef above means this won't be usable when
> CONFIG_IMX_SCMI_MISC_DRV=3Dm, while changing it to
> IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV) still produces a link error
> when the consumer is built-in. Changing it to IS_REACHABLE() in turn is
> even worse because it avoids the link failure but makes it silently do
> the wrong thing in some configurations.
>=20
> >  #endif
> > ----->8-----------
> >
> > ....to just support compilation in all the scenarios.
> >
> >> This however only works after changing the dependency in the
> >> SND_SOC_FSL_MQS driver as well, which uses 'select
> IMX_SCMI_MISC_DRV'
> >> to turn on a driver it depends on. This is generally a bad idea, so
> >> the best solution is to change that into a dependency.
> >>
> >> To allow the ASoC driver to keep building with the SCMI support,
> this
> >> needs to be an optional dependency that enforces the link-time
> >> dependency if IMX_SCMI_MISC_DRV is a loadable module but not
> depend
> >> on it if that is disabled.
> >>
> >
> > ...and maybe with the above additions you could avoid also these
> other
> > dep changes...
> >
> > ...not sure if I am missing something and I have definitely not tested
> > any of my babbling above...
>=20
> In my experience, there is no way to avoid reflecting the dependencies
> correctly in Kconfig: if one driver has an EXPORT_SYMBOL that gets
> picked up by another driver, you need a matching 'depends on'.

Oh. Thanks for sharing the knowledge. I am ok with your change.

Thanks,
Peng.

>=20
>        Arnd

