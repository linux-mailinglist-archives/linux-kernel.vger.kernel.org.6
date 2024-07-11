Return-Path: <linux-kernel+bounces-249219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1E92E8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58D91C20B16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CD15EFC5;
	Thu, 11 Jul 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kilTLU20"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0CE15DBC6;
	Thu, 11 Jul 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702671; cv=fail; b=duJqV8RWhQuTAN+SCinzegB5qRDyIjSEP3cKkG2Ue2T/iDqHh27nk4NHNPbBcNQ2WtK/j2ERDymOvTJx/QHxfO9jBsY3hB93IrhUrxeNmx/bS7nRlEcRxZu38MGhWxmdqv8qDCP6Ko+robOqToP+107Xc8nesSjPqI230BswB2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702671; c=relaxed/simple;
	bh=mcUqyMzgomyRG7La2l7cTeXwhiw2XpwQCTNBhEA0SMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E1hxXukmFi8CVzJF8qdr9XsVZ2HBPL64S+tzMMUMgK/7gflxixsjPRKwtsURO9UoQZF7N2gncpF8FJoQdJbFhpRIs/Vr0zw9s83BAtfzLF60G7sBHJ+F3oR9wxU9af5z+p0ig22YitNPyVy7PjfUW9y6vUiwcSJt6Gz7bgKV7Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kilTLU20; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzY31JeZbqaRc3xzV+A9iaA0Sr8rIjvEnU4Qz16tELdr5HnLMq31wgcyh3RtKdaoNtrQfPYVzpdBOs8b6yeZgmxr5Zhhs3BXvWatDgr6F3mmNTk7+nqS2IKlleaidAGBAGVuZqbGRLYg2boSg4hDXZXuYLYhIuq3XyiqvtIZUlTkypeF5EiC41+KEy5Tf5jmMuv8RnLOa1yMM3D0E9gy/6q5HJP0AT+kFC+zGy5USbXLbQ0doQEvbrp50cKiOvfplU3zauv5KB+SUa/7WBKF/xaxwcBR1HqTPMYXodngYwQMFAc18a0ozVMvl6TWZdoU7wMyEWvUoYN5zRR1Z35YPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhSG/Oiuf/JdGJt82ZEyGxvp6bCMQxGuemeTG9sWICc=;
 b=F4L27p2ttV3Twowcf/smIayuKkFbr7OH81NT5D/C+XkrekNnloN9OtLgtNFP+l+11ONU/C1mTI6F8jCQcM7MtsOfQtNsZXGk/ynY7F5qf/f11cbWiai2PIoWx337n6L+w8asRbyk4rICVtZeUy1eWsFSRhWWqfC/NdTz6f2Db3eTwkmoYjsK2xUeS5eohrhXfAU6KPQxfDrDHkAC3BHtpKOD0oVVpTOf3fyEbANDnJjwiVpLTTWuj7BLCbNhVplBXac0FY/dJv8uUuE6n2oMi0DnfRzPsN+sci4KTI3e341wXviyl0sMbtqYWELfgZE/P8lvVIlIHjDT1dFBUojNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhSG/Oiuf/JdGJt82ZEyGxvp6bCMQxGuemeTG9sWICc=;
 b=kilTLU20a4tB14296SnO4+DnmrNw1zK9XmxPW1UBGsHLxsYLfPNEbOvXoErHxWMa7fiXdTnSnWV+uSI9f72F76PJrxvX7Mb7ngaf8qYGggO4s3OSXahzvFBIGhe+Gn9Qy9mxiJEUIcathr3qrnpkvkm8dO8V+zmiirLBqUZQ4QA=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10848.eurprd04.prod.outlook.com (2603:10a6:150:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 12:57:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 12:57:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "etienne.carriere@st.com"
	<etienne.carriere@st.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>, "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "souvik.chakravarty@arm.com"
	<souvik.chakravarty@arm.com>, Etienne Carriere <etienne.carriere@foss.st.com>
Subject: RE: [PATCH v2 6/8] firmware: arm_scmi: Make OPTEE transport a
 standalone driver
Thread-Topic: [PATCH v2 6/8] firmware: arm_scmi: Make OPTEE transport a
 standalone driver
Thread-Index: AQHa0u8qrWdd58QeTEmFHXIFXdEdX7HxfblQ
Date: Thu, 11 Jul 2024 12:57:46 +0000
Message-ID:
 <PAXPR04MB8459B0299D11F08605C20BB988A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-7-cristian.marussi@arm.com>
In-Reply-To: <20240710173153.4060457-7-cristian.marussi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10848:EE_
x-ms-office365-filtering-correlation-id: 16e0f69a-253c-4ce1-975c-08dca1a90f99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?t/fE2qeNrdi+y8PBuSacit0wXMqAZ/RBjjiKjnB+CNqsdK49JcKWEVWhbP1+?=
 =?us-ascii?Q?Ri+SJwXY30ose4+vZAP6M34zG1zX2HZ00O++hg07+gGdYEdnPszyHtVjLDhV?=
 =?us-ascii?Q?PhXncIkpC6PUo45lxltAfvC+EUQS96Yn/KMsEDYbuyOaV2LXhQOEnEAmfs1a?=
 =?us-ascii?Q?5hkw+QbdWtmuejWkhsaQnTlHpBYldD8dWaKOXMzfdMcLrDzu5LzOOnM/rOLJ?=
 =?us-ascii?Q?pAf4Agylv1ZnWIp0bBnznyErYw9iH3I+GojRbwj1AtoEpg7TEyUa8Gd6B+TV?=
 =?us-ascii?Q?szs0lKLrRZ0tQIMLHQBwxHMr3b2XHfPW/yhK87fVVSXMtDrtSB2ahh1nQXTr?=
 =?us-ascii?Q?Dett3r65F8sQfNy5vnKzd/55a4Qe4t7RY9VJqlBZZ0yKGz/3x/4V0meT47xp?=
 =?us-ascii?Q?GR5n7WoWGPbhNPVmSsarvHePXp/TwdmPUKacOs53gFRm+UxSiETeP2PkZUkK?=
 =?us-ascii?Q?FvlDa3SYGRUOil21pybPQ7F9M4wbmly28BiZcG161+dypGLEtQuliFxZ4Mvz?=
 =?us-ascii?Q?BEtroz8blFSiQcRMg3Yr445BNObpWVB9tc9z1E5XelU3AmrNYKwMykJVVrIi?=
 =?us-ascii?Q?0iXtfeFTZs1aG0AZ6z9/wWibYA1j8RSe4W3GSzJhpmUqLLi+R2XZXq3jySxG?=
 =?us-ascii?Q?coYXJJ+gdFzZoJ9F/vfEB5CeikebMY/oXrG1m3dxU/EKQ13p8RrF5mSbpwaC?=
 =?us-ascii?Q?X+3/voryuDe7EY6f/zyxeqBstIQB//hX0T3NgXwzfN2RWwx9Uo0KV2GJ70h2?=
 =?us-ascii?Q?rWOhXX5SbTz1GwuSNfIJqpZb08w87UKVh35rZtRS3lCPGrcuXdnvQlnXdkEY?=
 =?us-ascii?Q?RJ81IfmDGKsGIDTx18LzHPw+Gs0p7L7Pw4/FRMXzYpjEAXVwh5x3bvnKxAcX?=
 =?us-ascii?Q?rgnHoya3YfTDn5DYkVgP4DR1MuLVKIX9rG5pjUQLNGbT7R4nsmRdWc3E0/8Z?=
 =?us-ascii?Q?BuiCHYoijVnCi8c9i7NkKb04ugQ/v+iUd1+YCzaaxdzvRaiK7KMxJ7Z9m6iz?=
 =?us-ascii?Q?WmS2r5lFXnlQTwS5Oz5s37SE4xf37n/1Mv1kbkghmJvq0s0BdEJnWQgRsqQD?=
 =?us-ascii?Q?dwgFLVa5DJR2iyKL/d5QqwENrEQP8Lyak2ZUjBHOtlISU+5WRyNsX4gi17Nx?=
 =?us-ascii?Q?7c2Do4iMkWxVMwbVCl7cxaq2KbcMjSwJAat4fG1Q+AcoN0m++hhvmQpmMSM5?=
 =?us-ascii?Q?c/+eKYX1zP0r+Qk7R+yCt+mqNbdmruXJQy6k/JTxyI74JZCQsX85FlaoUCEK?=
 =?us-ascii?Q?Aw7CV0BcYTnD1mj3Fxen5WhsqTuG64C0EDrQ+YMaWYKZoQYHsYlSmbN7TQqG?=
 =?us-ascii?Q?7uwcP5gijBX2MYdmDnVlDPBwdxYjZK6iotpKWdY3RxhtBo1l6Ytv4F1BeNdX?=
 =?us-ascii?Q?KygjAhjl5nhk1i8baFq/9ZSCGy/frmcbUHmLf90uuOO0mtFbLw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PBrGBryScrL/qKaPmZT6UEJfjKnps/Rf6brqFHMl+hxy0H5HH5IEePSDTtIH?=
 =?us-ascii?Q?IvxXoOl0ymeJdqfrAA6oN2PHWXMD3nIFRiRQ1dmwpYcBZSgT9QWO3yAJmg0V?=
 =?us-ascii?Q?ko0Bs2A1C5BBPRbtHfNyZSOFDVYEUUElPlNLaLkkoixe3yhubAZ0Qt4n40Wr?=
 =?us-ascii?Q?PkpDx4q5pcZ0iAoKr5yfoGpy5EG1GrjMV13qB4t3RVKSmaIQB12yAD/Rr+3W?=
 =?us-ascii?Q?MUYvB01pt+LTAXGJjk+UhKpxjvUdcYbMoTAXpW+lCXS81av3HNiIIdGSI4Xn?=
 =?us-ascii?Q?f6ei+0dPxQ9nLuR3J54+MeFnzu0hWjdddJyKK6lOcLYaiIxsGwxxujteIMVf?=
 =?us-ascii?Q?7o1H4SqNRaI6M9CE6s88TVPjMTJStSLPwE7Ndlj1H6UiQpYpAFJe8xuWoFav?=
 =?us-ascii?Q?lcyN5S7MftLLltsS9IIttMJw/HpkYBZCVk+ZLjgB5u45pk0mAyty1QE/HVFJ?=
 =?us-ascii?Q?myg+mM72yQC1pS0jQ+6lryZ9a4j326sZILPe5CRYAOTVteOPivKzVmtx7OZW?=
 =?us-ascii?Q?RkeZWY53t27xLe72vCuqAc0Nird1XNvi42O5j1MZsPIE5pxZliMToAhhDCuY?=
 =?us-ascii?Q?mVzp3dSIocOysCDkbm/xYq+zWrPj2ZfomBxrBEQxJKYAyxi1pR8tb3uPTJwL?=
 =?us-ascii?Q?oRdwABJXDxHQilqAYtUwNT7ODJEWJ+yKL2C+U2RfvvGnK3ElsFFH1ZNqbpEr?=
 =?us-ascii?Q?ui+DCdMLTAV98NH0jfmWXtfb3CXXTelirGk/JqVkzprE/C0ZJQ4kcKaanKA+?=
 =?us-ascii?Q?Z1HtSwH3gEOivvnYTfdEMfWfR6xfM6DAevvSm8Fc4wJEjGGZZujB+hp3J7Nu?=
 =?us-ascii?Q?r//mhSJjozWm/bKwBUjlnTsH5X9+6flSVlQrqzVjmXbUJRZkkOUgj41xugsN?=
 =?us-ascii?Q?LqH/kR3ZDcC5bGuPPLmmDXEbqHgOXP/CppD0Awxnc5WADUz4pYiigIic2eKk?=
 =?us-ascii?Q?T4y8txGP4hEm0XogDg4GO2PWiDXdOn0NrpZn52WSNxSQllNLTpaHkhgIHXUE?=
 =?us-ascii?Q?qXx483Opgt9w0fS1qxcGsE/8IUvlQwJs6xcQGUne22aFIuOe+N665opBM9y/?=
 =?us-ascii?Q?8JpEx2QjY+CxUugK+kIPkHs5RjNqeXM69jTmm38djR9a1MwXcZDHR6fRLdNU?=
 =?us-ascii?Q?c5r7mIqbq4Y3IKMScj8BFO8rb/ahPtuEuW3eVBOv7H5PkI+QSfrE0jr6qCra?=
 =?us-ascii?Q?mMX68+TzcKVl5koR7l1LhhqxFSUx5ytv5tTGJ63B3e72Evgf6j9YR0U+ZjRf?=
 =?us-ascii?Q?fBqbzuVTYhWmKzOjX3US7fCxdIb08qz0bOpi2IIjWgHeLPnmvqXRE+Laa02h?=
 =?us-ascii?Q?SDkEdqauQZ+GjzLZ8X15K+gI1XKfWvz10MxYxYucUw1kFZDSOAPZa+dWLpo1?=
 =?us-ascii?Q?hX02Zoqi4UBiPl8qoh3HBDMnsm4sqDHqxsinJTP9YnWMr6ncRgcy0FLxPGSL?=
 =?us-ascii?Q?3Ir7Iplb0Nq47bGDsgZsG43MgfPNNkbp585LhGaCZMUK7AUCqVEzkunm8MX6?=
 =?us-ascii?Q?gBNxidDnE9GcCxzvrrOa15FvWgLbf51IExazNQy8ERDdGZo3SD+1N/CGtYOB?=
 =?us-ascii?Q?AeM6Mwj+3BLSaLYl5Lo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e0f69a-253c-4ce1-975c-08dca1a90f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 12:57:46.2942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSljgEBdR5HhWBq4wq3L5ynXN64ith8qri7yHE/xzLzOzBPd4ijq6wFxuPmZ9b71tzoLmuEoBUB6+1YmPIIrTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10848

> Subject: [PATCH v2 6/8] firmware: arm_scmi: Make OPTEE transport a
> standalone driver
>=20
> Make SCMI OPTEE transport a standalone driver that can be optionally
> loaded as a module.
>=20
> CC: Etienne Carriere <etienne.carriere@foss.st.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - handle platform_driver_register() failures
> ---
>  drivers/firmware/arm_scmi/Kconfig             |  6 +-
>  drivers/firmware/arm_scmi/Makefile            |  2 +-
>  drivers/firmware/arm_scmi/common.h            |  3 -
>  drivers/firmware/arm_scmi/driver.c            |  3 -
>  .../{optee.c =3D> scmi_transport_optee.c}       | 91 ++++++++++---------
>  5 files changed, 52 insertions(+), 53 deletions(-)  rename
> drivers/firmware/arm_scmi/{optee.c =3D> scmi_transport_optee.c} (90%)
>=20
> diff --git a/drivers/firmware/arm_scmi/Kconfig
> b/drivers/firmware/arm_scmi/Kconfig
> index a4d44ef8bf45..def7e3f09356 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -89,8 +89,8 @@ config ARM_SCMI_TRANSPORT_MAILBOX
>  	  will be called scmi_transport_mailbox.
>=20
>  config ARM_SCMI_TRANSPORT_OPTEE
> -	bool "SCMI transport based on OP-TEE service"
> -	depends on OPTEE=3Dy || OPTEE=3DARM_SCMI_PROTOCOL
> +	tristate "SCMI transport based on OP-TEE service"
> +	depends on OPTEE
>  	select ARM_SCMI_HAVE_TRANSPORT
>  	select ARM_SCMI_HAVE_SHMEM
>  	select ARM_SCMI_HAVE_MSG
> @@ -100,6 +100,8 @@ config ARM_SCMI_TRANSPORT_OPTEE
>=20
>  	  If you want the ARM SCMI PROTOCOL stack to include
> support for a
>  	  transport based on OP-TEE SCMI service, answer Y.
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called scmi_transport_optee.
>=20
>  config ARM_SCMI_TRANSPORT_SMC
>  	tristate "SCMI transport based on SMC"
> diff --git a/drivers/firmware/arm_scmi/Makefile
> b/drivers/firmware/arm_scmi/Makefile
> index 6868a47fa4ab..b04119ce972f 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -7,13 +7,13 @@ scmi-driver-
> $(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) +=3D raw_mode.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) =3D shmem.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
> -scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
> scmi-protocols-y :=3D base.o clock.o perf.o power.o reset.o sensors.o
> system.o voltage.o powercap.o  scmi-protocols-y +=3D pinctrl.o  scmi-
> module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>=20
>  obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D
> scmi_transport_smc.o
>  obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=3D
> scmi_transport_mailbox.o
> +obj-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D
> scmi_transport_optee.o
>=20
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-core.o
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-module.o diff --git
> a/drivers/firmware/arm_scmi/common.h
> b/drivers/firmware/arm_scmi/common.h
> index edb786cde25c..0ce1d804b3fc 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -289,9 +289,6 @@ int
> scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info
> *cinfo,  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO  extern const
> struct scmi_desc scmi_virtio_desc;  #endif -#ifdef
> CONFIG_ARM_SCMI_TRANSPORT_OPTEE -extern const struct
> scmi_desc scmi_optee_desc; -#endif
>=20
>  void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr,
> void *priv);
>=20
> diff --git a/drivers/firmware/arm_scmi/driver.c
> b/drivers/firmware/arm_scmi/driver.c
> index b14c5326930a..67b416c7f2f5 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3251,9 +3251,6 @@ ATTRIBUTE_GROUPS(versions);
>=20
>  /* Each compatible listed below must have descriptor associated with
> it */  static const struct of_device_id scmi_of_match[] =3D { -#ifdef
> CONFIG_ARM_SCMI_TRANSPORT_OPTEE
> -	{ .compatible =3D "linaro,scmi-optee", .data =3D
> &scmi_optee_desc },
> -#endif
>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>  	{ .compatible =3D "arm,scmi-virtio", .data =3D &scmi_virtio_desc},
> #endif diff --git a/drivers/firmware/arm_scmi/optee.c
> b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> similarity index 90%
> rename from drivers/firmware/arm_scmi/optee.c rename to
> drivers/firmware/arm_scmi/scmi_transport_optee.c
> index 99f3b0bfb956..7a16c8d3e213 100644
> --- a/drivers/firmware/arm_scmi/optee.c
> +++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2019-2021 Linaro Ltd.
> + * Copyright (C) 2019-2024 Linaro Ltd.

This should be kept unchanged?

Regards,
Peng.

