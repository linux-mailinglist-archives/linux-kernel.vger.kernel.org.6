Return-Path: <linux-kernel+bounces-269254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A366C942FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11290B256DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78B1B0114;
	Wed, 31 Jul 2024 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IPChzrgY"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF41AD9C3;
	Wed, 31 Jul 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431557; cv=fail; b=UlWjEttpN4aKj+bE1lejp6gML5bCHUJ+yL+tuCHkqiE5Wp79ymYbMeBrBxx94hOCzoTV675ON3mDsBjLImrpQxq7+HhabfA0mT0n2qZClI0AnaSSHwTYd0wW6dlXL6ilv2SvEyoBJ5ze1YtVRGkJl60MN07aIAKUp7v+NXb/u6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431557; c=relaxed/simple;
	bh=cGcrKTN72DJ7PhMzaeFBEt4NcgzmmHMQMaeRo/4dIsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+5NmAlYGvYNl0vtiL2naKSkaw8w9xarOao+KcZkSdpmNJ8vkIpVPAkD4F6MsSNWR+5GSF3hh1I88SETZNVSiqzFGfNCZIFY8JHUieYx5J+EEdcwdVkwNPwrKCJq3Trgv6tfkH8ssFPV+OwtmuguwLFWxSe1cEP0s5DNRp57x8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IPChzrgY; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJm2QXHe6WvVIlenU9xRG/yLwqE7/xHSzNtSj+wGznXYzdW9/oC+Fu7NhhN3U/ay/3ktOm8Ee6jns7OxwHkeGYRZnu7XEl4PBGX3zu84Yd9NJd3SIQa5h7v3qWfxw6Zz0cKFcQh8D1eb0iGkKVIoK6Rezm33dmFQqVc1ghalurcxz8nCOWYeid9kIR3v79DU0CB+HIo8ykcVTT3sZ13nD9gSIW5HVLBv2r1t/snmeXODsU10pkGMsHgFzoS8HTsET9SCTN7DIo8aLXAmJxoJ+kzJPNFCWEf2GW8Fb7XzEaXrqE+kejKR26m/xIrjc1Sklvxd4n/IMklIhgKMIF12bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzdczd0Ynbj7ph5+k/eGHOuV00biMNAInp8wHGfp44I=;
 b=qg1U49VDQteCKHSfLjbmBtWxJNJHQNaxB5AXVkvcVFV1E82hk17ZxDWZ8sNcQxxe6UZmALbPZ93UIg6y73gya3fTH2qlIzsX3EAwcrjiL0hp5iUasmXSYM/z8UCsJmdbNzwVATQKBIhdVMtDw2JZx1o+ZdFul9nLiy9Gduq+F9K7ny8zfOGBhJ2EZ6w9z9DFfbNcpe9dRPTFdNis5kUFU6FiRG8si/5DVep7iX+Tm/dIl5TPqUirhOJDkY0iY27tGoPFAm3vsDmn/UlwC5R0E+lElQzU/urOfSXjYaBvkNuT8VqdnkmAFi84FuYEA8jU0QGie4rfsY5sE27LMcyMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzdczd0Ynbj7ph5+k/eGHOuV00biMNAInp8wHGfp44I=;
 b=IPChzrgYqPAG9KgeK8WUZEjBvF+wqvDB+SpGoSdYlmI4bE5Ca65yUCXcYVq1Gi2zNrqn6Fib6N+sgFKl7EypfX1xuMIB6jlCO9bCs3+npB8wHSY7JD/iPNjNfORaUsZS2WfjEiGJAzAB7G8MDgVlHNo3pd1LufyLP/RQi+C1VWwfwQXKpYZPgRfyX5Caj6zrwVz2ImThmC/S/FkJ+XMBF37fwRf2ZCsm3923R8oqQi7dfCRBX0UlElwE2n3OZvsT43bY7bSzguJHEAh4WatKABN5vE2XXLRUo9OGNvREdKL8MQvg/3rLTSiNd6zlyPfmm63dyo+HtQN3jCFrJOXJpw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7000.eurprd04.prod.outlook.com (2603:10a6:20b:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:12:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Wed, 31 Jul 2024
 13:12:30 +0000
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
	<souvik.chakravarty@arm.com>
Subject: RE: [PATCH v3 0/9] Make SCMI transport as standalone drivers
Thread-Topic: [PATCH v3 0/9] Make SCMI transport as standalone drivers
Thread-Index: AQHa4oUgFaiYY0PN7EOE2GRX5NZpB7IQ0Vhg
Date: Wed, 31 Jul 2024 13:12:30 +0000
Message-ID:
 <PAXPR04MB845955E748C7C059A16FCA3188B12@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
In-Reply-To: <20240730133318.1573765-1-cristian.marussi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM7PR04MB7000:EE_
x-ms-office365-filtering-correlation-id: feac1cda-9bc3-41e3-5119-08dcb1626eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Qfvv8lemr2+Eqq3A9XvM4Jdvf4GN/9PEa8Mqs7cIk2aWoaJToZza3qLyDWpA?=
 =?us-ascii?Q?RMT/2KKRqlxkLTEBFXW6ROO8E7XM/mulfQhyQ1jJPUJhl4l5eTKamgodtUBO?=
 =?us-ascii?Q?lbwsD7rqkWMMjw1KMcaEiyYb5UZrgK2ScFmSrfWCUdOoPHAkH1jzDzznmoIH?=
 =?us-ascii?Q?iNcu1RTHSVkerlBMPEnNtKf0JIwgrHckZqszusdYVaD1MBELM1q3h7ivdCKf?=
 =?us-ascii?Q?dpOG+NCj/ti9VkW2FvnDLrkdrc0vfR2Yc0T25I6mi/lTk0F3zD2+RBPyvU+I?=
 =?us-ascii?Q?hiZCve8AuAZ+f08SbM/cio4VoljWviIXPJ83ivCNmkmFyRkMaTR/jYv+mlaD?=
 =?us-ascii?Q?Bb6hbaUstDVB8/VBbKwNdn9vEuiJBu9sxG2bLdbh4CLrYzd88UnqaiG6BN+X?=
 =?us-ascii?Q?/99HpU7wGvolxcU+v0yqfyDr9Ahzpqlg+MT9yuBXA6X9C8XHJT3gbu09YilB?=
 =?us-ascii?Q?pYOJtgcatatQkocSWYVCOMCLofH5EGKX+ciK5KXldreUDLPyWBPUtK9vP08R?=
 =?us-ascii?Q?9MwdZFVGPo3L3jHV6qLmNGYuxRHIt0w10x4vzkf7x7eIp0D3zmQzz+gJtqa0?=
 =?us-ascii?Q?p265sk1R8q1X/wdq+mD/4dX2OIZCz1vhLL88jeAcdKyeCr5hOe46axjts2QO?=
 =?us-ascii?Q?ThVke7Kf4NTyNNvSK6vcxz1bKQwh92TWtyh2NkZEzHrnE9LdCbvRATWUP51s?=
 =?us-ascii?Q?Rs4WhZBYxZHUv7uCV+TZvObYEhzs76yEom4PiVqS5zhA4Wbuj97fSCfYZbAs?=
 =?us-ascii?Q?2JAUarSftZ+939OGkvDWdmrohgz8zo1TnjC1CsM1MXDtjMJW6MwCjeUkosW3?=
 =?us-ascii?Q?3jV2Ly9p6z5QRhmuBsVOHeDCnxmxc3uO4MvTm+osyOB1UEjdJaiasyyBvBbx?=
 =?us-ascii?Q?DASv+h4ynb7+9AwUS1pTQqD9ig12Pqa5d6kA07La/e8m/LheZBC+hY+btKPB?=
 =?us-ascii?Q?WE3kznIzRBIetyo8BwsxEdHOKitrpp6phr8KRutBfO3mkulKfl6Qn3a7vSeC?=
 =?us-ascii?Q?Qyhpoqi9gc6UCDPb6+EijoAYXSSAxLVWocNnPZs55TziOKQ5AyWpcQg+b3q3?=
 =?us-ascii?Q?PyQ9iSm9Ml3rPUf2INOzoRmzeeAyH4MCwe+L9BdoyH8HL3NIdnHyrVLaqJn9?=
 =?us-ascii?Q?jn0V67LQBTAtMd9O5BajMWdA0xKPgorXTGuSl2NpzJ4tGNbKVufHnsxtOqFB?=
 =?us-ascii?Q?uaxoF6oZkjjDAF+yMDwJE/Z4uA4KuXi1rumqO/IhjJpoRojxliP/D2oY2cbs?=
 =?us-ascii?Q?sdK2E2a47AGgSwdUJlUO4gTACJ+4lTrtmOQeoOJe3MKu3gkCA5NQ0n2tOdAx?=
 =?us-ascii?Q?TZFDee3uAWGPQgEVGIMYzJom7OekDdOBKZkCBLUmfQv6+WFfy/i8u1/QUm9s?=
 =?us-ascii?Q?RdEtCzwXO8D6Qfg8EneoCsWLAu2yG2FeHIIyFgUIYnxALwu1yQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SuXSnbpReR1AAE2tNAM8hvpByhocfic0nAL4jMfy36lPzuW377UiA050U1V1?=
 =?us-ascii?Q?ebtuc34ewpI6Niw+rJ2cC6/I8V6WNtf4N2HqL0YAksbhtmwGR5gzSHS50UKu?=
 =?us-ascii?Q?mTt453MQo3b2qEn11m2f3Y9XNYo7vTHQyk1KyzLBjSe8VQyqjHPTe7aLfLbb?=
 =?us-ascii?Q?+HoYzTaGfvf48nbHF6q3KdMk1L8jajv4+wSmwHcSyIIQrNlzGIXvnTrl45nA?=
 =?us-ascii?Q?LTcg7n7r11pz1qg863O0xFalQRgSiL3DPi0cV6I419acggJQUtiHxaG72GWJ?=
 =?us-ascii?Q?PYiE/vUv13u5FKmDa2SvAJGLttX24E8d4o271BGJAS00oY/dSzy6U32KDIC2?=
 =?us-ascii?Q?W/lY01h57yBfLQfJt1M+KyfRyhDHeZ6bvy2dDQtHUvHLA4j8V3R4ogeUFM+U?=
 =?us-ascii?Q?DQRiQPh5K77qspGsNU+WlTmLdPKmkdQEfTRJkjPYI+73GFJqQ8s8Fy7hkJpX?=
 =?us-ascii?Q?QbEpfK4t8C0KaUo045lJpqlYyebKJfLk4N/M3//sg4fh20EOMoZ/p6tDrgp5?=
 =?us-ascii?Q?ypFXMy+j0nprjH/XamGR2a/8mrOuu2mVjQdIBeZxXvOxuIpCufDBnMWqWLcr?=
 =?us-ascii?Q?1GutQu5tPTzeSrvLSwwiPDipAnLZJET4ws3LaakqmN544lbCAM87/KsMP7DS?=
 =?us-ascii?Q?huAv1IsC23+9sHyO6ybgSEwA37rlIKNgeyOuURI9OdZsMW7DocaXCOstrnkx?=
 =?us-ascii?Q?isQLYEtcZ6h1OaVmUutonFVxz1oGRPYn/WOCkheNNeoG7cXNUErkTTkdx2hJ?=
 =?us-ascii?Q?YTWupRMnx/kf1ceo5mJNcxUjjgLMJxjexhWee+POLimwFlgXGiplA8OOSZMP?=
 =?us-ascii?Q?iDKZ2KPDYgvPXhiJffiH3I4AWA5u7I7HkbDz67lc5kHN+pEZYYtMfCbFxiUn?=
 =?us-ascii?Q?asA0QPNSVuLfWhdEwIsizk3nYBr5tq3+FqnwHX0Snv5LvEvG0CVOQzkyv5dE?=
 =?us-ascii?Q?ksF06Gq0zSrIlsq5icjZ9TvaIO7W38Du/CinEeJNr5XeYXiaH0tFURqs/kZc?=
 =?us-ascii?Q?o7JyznWKUy0JRGS6XAKV8wc6xb1yrpyfbDW7mumWMb8wdp3ebTpdarQvjkH3?=
 =?us-ascii?Q?OvpJ/hXo5TdH5iVufksPknBOix5vhQNjgJeisnU5UGJNjWjEyEjFcv+/6I+j?=
 =?us-ascii?Q?vBGlvJAsYJ3uRvW0dnP5VjqeU+wJFaDKoSZ05f1woImhPZRornVga8MOTgwN?=
 =?us-ascii?Q?xCBRAJCS7qhl+8m2FzfeHTpic1WPVwF+tPXHHPd/5NNpFTJU98VrMej8eviL?=
 =?us-ascii?Q?MogqxpeX90SG8uN+a7iJw/OugW3SsFXZoBwlcnG+Eq2f1ZufppEB1HyOtIji?=
 =?us-ascii?Q?tVrkxvMT4cqZ4ogD0bYT1vP6lPnFGVDBoR4aFdhkj76iGCCst/024oTvz2Gt?=
 =?us-ascii?Q?Bs4LMeBQ0w4mCudVvND+m8uJj+ywsuL7aKDYS712mY5tfo2ZvvDVpITUImf3?=
 =?us-ascii?Q?3ZAewisJRdg4s8mg0DTo6auVWzBYywXyjRzQ0fNeMsub0Wv4tzWlskEhq58B?=
 =?us-ascii?Q?ltKUQl/ddPg1dSSuzFsNyc9rSElDAnr4f7b/aoE8DwVdOK8pDYfVZz67ZS5y?=
 =?us-ascii?Q?cutmEbdkjzpGC0tj+lY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: feac1cda-9bc3-41e3-5119-08dcb1626eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 13:12:30.1481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlN+GIS4iksJGNaU2c1oCBAiPNHlRN1G/eX1QVJoNm/03/a7oorABgARoSBHWauO//vTwcvhyxqKcElpIDspkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7000

> Subject: [PATCH v3 0/9] Make SCMI transport as standalone drivers
>=20
> Hi all,
>=20
> Till now the SCMI transport layer was being built embedded into in the
> core SCMI stack.
>=20
> Some of these transports, despite being currently part of the main
> SCMI module, are indeed also registered with different subsystems like
> optee or virtio, and actively probed also by those: this led to a few
> awkward and convoluted tricks to properly handle such interactions at
> boot time in the SCMI stack.
>=20
> Moreover some partner expressed the desire to be able to fully
> modularize the transports components.
>=20
> This series aim to make all such transports as standalone drivers that
> can be optionally loaded as modules.
>=20
> In order to do this, at first some new mechanism is introduced to
> support this new capability while maintaining, in parallel, the old
> legacy embedded transports; then each transport, one by one, is
> transitioned to be a standalone driver and finally the old legacy
> support for embedded transport is removed.
>=20
> Patch [1/9] is a fix around the chan_free method for OPTEE transport; it
> is really unrelated to this series, but included to avoid conflicts.
>=20
> Patch [2/9] is a mostly unrelated (but much needed) clean-up from
> Peng, which I included in this series to avoid conflicts at merge.
>=20
> Patch [3/9] simply collects the existing datagram manipulation helpers
> in a pair of function pointers structures, in preparation for later rewor=
ks.
>=20
> Patch [4/9] adds the bulk of the new logic to the core SCMI stack and
> then each existing transport is transitioned to be a standalone driver in
> patches 5,6,7,8 while shuffling around the compatibles. (no DT change
> is needed of curse for backward compatibility) While doing this I kept
> the module authorship in line with the main
> author(S) as spitted out by git-blame.
>=20
> Finally patch [9/9] removes all the legacy dead code from the core
> SCMI stack.
>=20
> No new symbol EXPORT has been added.
>=20
> The new transport drivers have been tested, as built-in and LKM, as
> follows:
>=20
> - mailbox on JUNO
> - virtio on emulation
> - optee on QEMU/optee using Linaro setup
>=20
> Exercised using the regular SCMI drivers stack and the SCMI ACS suite,
> testing commands, replies, delayed responses and notification.
>=20
> Multiple virtual SCMI instances support has been tested too.
>=20
> SMC has NOT been tested/exercised at run-time, only compile-tested.
> (due to lack of hardware)
>=20
> Note that in this new setup, all the probe deferral and retries between
> the SCMI core stack and the transports has been removed, since no
> more needed.
>=20
> Moreover the new drivers have been tested also with a fully
> modularized SCMI stack, i.e.:
>=20
>   scmi-core.ko + scmi-module.ko + scmi_transport_*.ko [ + vendor
> modules ]
>=20
> Based on v6.11-rc1
>=20
> Any feedback, and especially testing (:D) is welcome.

For the patchset,
Tested-by: Peng Fan <peng.fan@nxp.com>  #i.MX95 19x19 EVK

Regards,
Peng.
>=20
> Thanks,
> Cristian
>=20
> ---
> v2 --> v3
> - rebased on v6.11-rc1
> - fixed spacing in Kconfig
> - fixed Copyrights all over
> - fixed platform_driver_register callsite in OPTEE transport
> - refactored DEFINE_SCMI_TRANSPORT_DRIVER() to:
>   + use alloc + add_data + add platform drivers methods so as to
> implictly
>     use a standard default device_release method.
>   + drop .remove method in favour of devres_add_action_or_reset
>   + use explicit parameter passing (no more concatenation)
> - renamed scmi_transport_lookup() to scmi_transport_setup()
> - use IOMEM_ERR_PTR to avoid sparse issues
>=20
> v1 --> v2
> - fixed setup_shmem_iomap to address also SMC needs (QC/nikunj)
>   (silencing also warnings by kernel test robot <lkp@intel.com>)
> - using __free OF cleanup.h magic in setup_shmme_iomap
> - properly handle platform_driver_register() failures (Dan)
> - fixed a few commit message style
> - added a few missing static in scmi_desc
>   (addresses warnings by kernel test robot <lkp@intel.com>)
>=20
>=20
> Cristian Marussi (8):
>   firmware: arm_scmi: Fix double free in OPTEE transport
>   firmware: arm_scmi: Introduce packet handling helpers
>   firmware: arm_scmi: Add support for standalone transport drivers
>   firmware: arm_scmi: Make MBOX transport a standalone driver
>   firmware: arm_scmi: Make SMC transport a standalone driver
>   firmware: arm_scmi: Make OPTEE transport a standalone driver
>   firmware: arm_scmi: Make VirtIO transport a standalone driver
>   firmware: arm_scmi: Remove legacy transport-layer code
>=20
> Peng Fan (1):
>   firmware: arm_scmi: Introduce setup_shmem_iomap
>=20
>  drivers/firmware/arm_scmi/Kconfig             |  20 +-
>  drivers/firmware/arm_scmi/Makefile            |   9 +-
>  drivers/firmware/arm_scmi/common.h            | 184 +++++++++++++----
> -
>  drivers/firmware/arm_scmi/driver.c            | 142 +++++---------
>  drivers/firmware/arm_scmi/msg.c               |  32 ++-
>  .../{mailbox.c =3D> scmi_transport_mailbox.c}   |  72 +++----
>  .../{optee.c =3D> scmi_transport_optee.c}       | 130 ++++++-------
>  .../arm_scmi/{smc.c =3D> scmi_transport_smc.c}  |  57 +++---
>  .../{virtio.c =3D> scmi_transport_virtio.c}     | 102 +++++-----
>  drivers/firmware/arm_scmi/shmem.c             |  85 ++++++--
>  10 files changed, 477 insertions(+), 356 deletions(-)  rename
> drivers/firmware/arm_scmi/{mailbox.c =3D> scmi_transport_mailbox.c}
> (86%)  rename drivers/firmware/arm_scmi/{optee.c =3D>
> scmi_transport_optee.c} (89%)  rename
> drivers/firmware/arm_scmi/{smc.c =3D> scmi_transport_smc.c} (87%)
> rename drivers/firmware/arm_scmi/{virtio.c =3D> scmi_transport_virtio.c}
> (94%)
>=20
> --
> 2.45.2
>=20


