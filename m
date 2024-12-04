Return-Path: <linux-kernel+bounces-432110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196AC9E454F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1C5168232
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881491F03F8;
	Wed,  4 Dec 2024 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KiGSCByl"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C71C3BF0;
	Wed,  4 Dec 2024 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342996; cv=fail; b=J3eL+GZTB+guOxUerP9CWXbd6P9kV/VYtCLMsyMNwEFL+okHCp2beJ79JQUQOQtnOGDZUUy+8UsV0VrAHUv/gNlxPn+b5GXfZYLF5eyxilTGTmLFo3wnpIo5YINARUkApvWQmHhoSO0OQXa5Dv+VpgW38IWbwmYs8Slal7gCs0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342996; c=relaxed/simple;
	bh=V9t+Bi+EjSFx0B1OvaPti9EekiM6Vcrl1QaFXFJnNmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WS8jiZXJ7lyuBiwTxkQgBWVCFtb16pnnmUgVnjRKJQPWpxTlWO3JXJy3ULhe9kqigsepNcRbym+Cc9FKeukqUejgTBT5/xFaevts885FS9Hqum6CXGyEnQY1tcs4gQ9zkXOeaPEdjh6Y5js/R1nwS64aZCC9pkuk5/RodumWZyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KiGSCByl; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N02UiwyBNRcfwHoEqkq4kO6XfwFUg1H+w86HDmBiW+GWActbz7wqH8Y8RULMtQkW/Ejf/aEY25cSATZ6qGuTDBSQHI15mAoMhwStn3LuPyuv7c5z6BJ3fpDVLXo4Nzu6RamrhmDwZ29n3liYCvua/jBkaf9NNnFLzpWyD3z23jXsfpQ8zds5jDmqfPY6Fal5h7qPzmhxs0E5M5vg8ivS1/7oRc/vgtYmTQ2SJzyTobIDFmPN7azMYuw6j4sIKma+iWwnxa6wyXxwxXXFDGxGWXhDxfbTp+QxbJCBjwX6h2exW2RNU5X/2bx/GAh2b0yzV1/HqMjakdmRH6V5pooGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFncMy3qt6NaignonE8vigflvwZGe2exIFz71QHyOSQ=;
 b=ljybeH3mfyIK5gbHFpBBzSR/3t1FRDkmwCNTJJQEbbhlivqFDtFZAOSkfEEYhEvHMt77ThkS9hksg65TbKjx6+iyRKfMhIEQqipArkryg4cjmaF+OtA9YNwg2I57KyzUa8EeRiEIVKRs39flR/qCrSkswnbC02CqE96iFs1cKB7g8PStYPhErycBuQxva013DIpjnrqmBjvl1kkhkPAHn2tYbD4SR3/aV8a9kmte9SiFMlojXpEOxB/jsp1xNZFOXsBGY+15/x/u3F6nWCQMG19S2a7xQQ+51DOpXxbTsO6KzLdVfBLwa54Ro8N7EwW6e+C7kGm+sNVrap6MFAsaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFncMy3qt6NaignonE8vigflvwZGe2exIFz71QHyOSQ=;
 b=KiGSCBylypAxxN7keFmH6j4/YIHDWbA1GCEtU8yv160tXsxCpZnUUAWLCtFmxMTO3HBQdyubZTru+GTZeztjr8etUC7KAWBsXIx6Kd677KSfJEX3wMRBu0gBL1JMCaOLq+8R7aqoJolorIKP9LKe5SKjla0VyZy+J1ewtry203s=
Received: from LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 20:09:51 +0000
Received: from LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99]) by LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99%7]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 20:09:51 +0000
From: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
To: "Trivedi Manojbhai, Naman" <Naman.TrivediManojbhai@amd.com>,
	"robh@kernel.org" <robh@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: zynqmp: add clock-output-names property in
 clock nodes
Thread-Topic: [PATCH v2] arm64: zynqmp: add clock-output-names property in
 clock nodes
Thread-Index: AQHbPMTqGOihlXJyEEaN503bepuerLLWlxhg
Date: Wed, 4 Dec 2024 20:09:51 +0000
Message-ID:
 <LV3PR12MB92606EADDE78383521D359B9E2372@LV3PR12MB9260.namprd12.prod.outlook.com>
References: <20241122095712.1166883-1-naman.trivedimanojbhai@amd.com>
In-Reply-To: <20241122095712.1166883-1-naman.trivedimanojbhai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9260:EE_|IA1PR12MB6529:EE_
x-ms-office365-filtering-correlation-id: 8bfc711e-2fa1-4f5c-74ad-08dd149f9c9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sPJiFmxnKEuQYgGtS47IU8vNVygxT4c2HsjX/zCBI4lpVfgv90uXvkRYB5Nj?=
 =?us-ascii?Q?HzA9XbzbsmX/My4v66zqSjQGbGnH312etugFA7+jb3lFEGMYvxENmtK2oAUS?=
 =?us-ascii?Q?M4VSakEpqwaSnrSawkPnb95byVW/2yCK0UELVSuX3jUyDYs21WO3zY37rcrE?=
 =?us-ascii?Q?l/oet9UXc9v9auw3H7nEwsKgR2fKFG5NCz9eo3kN6es+dfZhLptBqmoLwCcR?=
 =?us-ascii?Q?JadthdfW8m3dNMk1bg0/ievU3lYemdt092dJlRtPWJH7MGQ9hl5wyUXAyl4Z?=
 =?us-ascii?Q?0UC9SV0AB6MfSX9ElGxNaqbknvdu4D9Q6FbygEFgTB72RnbG0TzruAVs3Fcw?=
 =?us-ascii?Q?2HiROGf4p9V6wDS1LfcOgF8GE1uQ4PEilAOV/sg0o9gL3hcxIKD0fkm0/+h/?=
 =?us-ascii?Q?8jioFSHTNr1YLt7Mkcatm6DdkOSTUFcqBZoqbUJK4xwpubL4r12SywoDAvsp?=
 =?us-ascii?Q?TbHv1EjA9K0zvr30E6MW4PQ1+aOSmJr2nrWGiuXNkm4Bddk2dJL4dxUsROCX?=
 =?us-ascii?Q?6mgQc6G6ikOnCJNcSgtIwgivUu74kijAErDdSuriYPn8FNjRCvsJQK80PWTg?=
 =?us-ascii?Q?JswcCpOfGIwOD0aTHgfsr+FgL14kKfM+KqDA+asRvF8W8kD7CJDBpcxwqQqA?=
 =?us-ascii?Q?OOQVqAGFlLZ3sBBtdd3qOi+VR/U/ehURDtjK6C8+dNzXBWSElRBMgcSrl7Fe?=
 =?us-ascii?Q?pSXxAWfRVVB1iX7KGMQMsAk9EatmdUfMKSEvH2TsTq8iU1+Pi6K4ES2TGPQM?=
 =?us-ascii?Q?VRc33jw/eFHC56WTPphLM/Z4wFwD6faaryWRt4IkSsQ9b9KOhLHRbjGe6WhG?=
 =?us-ascii?Q?XshKYw3U74I99q947+3jn+uEOGZrRd8LKzeEKaSB7LGs0U3Q0Mfg/yHjZwj3?=
 =?us-ascii?Q?tpdggedB/a0Ab0nnqXLnVND7V7cFEmCxaFSUB0kPDHa7bwTqPXjBl5qoAEVc?=
 =?us-ascii?Q?rPfotFsLu8BCdvtqa+jcNISOH1Vz+5l8BT6Pwf9vlu+h+neo/AJ5IycIlOZ3?=
 =?us-ascii?Q?hcr87ZDG1YoQI7Xqb29LIZLnrllyt9JFXRt0Poifn4DoRqSRTydD2oClbkoK?=
 =?us-ascii?Q?ZyjUofr1CK/RWFjVn+8GpwaflwVBLrcpEyDWs1BAGVwsbLCokmcE+0dQEIZy?=
 =?us-ascii?Q?Y/ZvA1y57/950l4+Bh9XAHQD5Kwrc7Kaydcsyip84ZMhglOhCArlUF1l7A49?=
 =?us-ascii?Q?y/ZSI/tZG/jnnByp5aV1yYfdgCq21Z6CZHf/YaGKe38lPQI3LSXwoh8r+KhU?=
 =?us-ascii?Q?h8OQ9I4dA7ySfPbMf6QK+OZ7BAH1bjKneeK/X6D+ULjlewVBtSDH33WxQTgN?=
 =?us-ascii?Q?v66eIB8qlMAXT2evik+hecswaWStg1PhDDYyot9VqKG9QMvoS68xojMoQaee?=
 =?us-ascii?Q?kream2Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9260.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BYHfoGFFm2jckT0jAEU7Vxy4Hv2edlakb50fcSXrXlQPo8ZctvVNlH7Lhs1K?=
 =?us-ascii?Q?trVv3ppfGAvGZf0sb1v6ppsvvNoYFnTblQEy16TUzUrv6hPUNusP73I9CJuo?=
 =?us-ascii?Q?ZCFnGCUgM9eTAnTW3A9n3hBysulOKOE+/fZ8GGaLuALeXLn8oonLRIMt5UVm?=
 =?us-ascii?Q?eLilSvj8qtoSr5pTpu4itrpla7QVECU+WGQ9w8T4hZPaiIHCFGlEZP2LCbbb?=
 =?us-ascii?Q?eJvfbhejUoMK6YJNNnh7u0yLzh8OvfRY5ZCPEo5mI2vomox26w5lkx0qw0F8?=
 =?us-ascii?Q?qwcNIOeW4ZbeLpIPZpIlz+i9K+u9cql1GC840VukItL6vbMMEqB1oNvfBH7p?=
 =?us-ascii?Q?A/5imyuo8bX0uU7vNtPG2pnVvaDuNZ0YnVwqbrMEfD7BvXBk1rh3pjWcTe/8?=
 =?us-ascii?Q?xXK6j/EI3/oGPnRGKitT0SL27KudgIP7cXPN+EsDF33uYpVms8ELEIMtnvrW?=
 =?us-ascii?Q?6STPYpzxQUDk+nPhKJLBvLzpeROLVKfaNMWhJm5tomCx42uep28Nn+2QI+pJ?=
 =?us-ascii?Q?gTeljE9sVkH8JHXCs7WkDieyXTtZAn++pPEBhy0gQ8Dy3fkMUi/rBU0E/TSl?=
 =?us-ascii?Q?Y7AYh65b9DOMu5oUFDJJKStG33gM5NsE8JlaaWMTqcDfqWbVqeNKE7s1Aa9J?=
 =?us-ascii?Q?c5VXZQSIe9efXmAk5fA3TY7qaF328E3MlyF4rbTej9L1k9TKAQDbA+7aE+v6?=
 =?us-ascii?Q?OL1ramT3oAPmRqLu4CjVWc/VJBRN4BVE6fm9n5+kIYr1ziRsAQVlQ9ulSE+d?=
 =?us-ascii?Q?0U8rWnQS97nY43fFSNobVT88kV05YaJtdNHZ7t0zdStS86Y6htZB9uDO0paQ?=
 =?us-ascii?Q?3uBodFPshaR03nJ1ZASOlaxq7Pk0lyDjfS8qSvQzGnx4aG0j/2F1D2Xuu6oW?=
 =?us-ascii?Q?4uphwl2d4x0YC7PBWNiAEZsQDz/KSnWoBYYGIPhnjGn+jhsqKaRxmBeJRtjM?=
 =?us-ascii?Q?54nouZ6w0coMlUCGKVFKu3GPuvcdHgYXOsdLDyqVH86wczpbOVH4kYwjbDc0?=
 =?us-ascii?Q?o1UEBnNDdAQxKYSGQtqnWLHY5ajsiwTI9kROK6NDb/OxLBAA6potRbTlRCl1?=
 =?us-ascii?Q?rPKgCQ6ZrI0DMpGan9ZWfp2PtNpi16yoPMnK8ICM1g+iNAXpo9k9ibVOB7I9?=
 =?us-ascii?Q?Ql7VOQhJTf1Ahnyw7nTzYo7YAUf2xxf1ixrafUgBE+T7nZJHjHwWTc/cuBmN?=
 =?us-ascii?Q?5p/nhsqOO7Q77irTuMNsixHV485cUSkOwRFfrshVUPcVfW7jmbdm0tS5LuAr?=
 =?us-ascii?Q?tTpRPi4ZoUaBB9/Ge8iMXooVt0/gJmM5kLdEsUp3jjNvf1NZEfmu6rPWpagD?=
 =?us-ascii?Q?EcDXNfdAXV8iaLVNy24g1f6/GrK7cA3OKzDfApXvzz06Fk/tvQDVz6Y+6S5w?=
 =?us-ascii?Q?XTGBJr+pQAeOib0li4WTseQf5k/ifV5elsqFDT1OUE3K0LrZYhkFslFLY9wn?=
 =?us-ascii?Q?1bml+Incd2fh3VOmogkbjYBspFLnC3bYnNEWYbi2BoVGOWiqIOIP2j/epE0S?=
 =?us-ascii?Q?Dy8dpr5DA0Pe5y1WBY/ZBn2DG97i/NKEmhAV2eOe4bO8zfcxvbRIP3U4s2Mb?=
 =?us-ascii?Q?dVJeWeOshWeTmt9VeKM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9260.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfc711e-2fa1-4f5c-74ad-08dd149f9c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 20:09:51.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSPWWb85QLrjzZSgae/ojihOxaGdVyB+PEiGkPp/JVvvWllw1BVRp5XYmIwZOfO3SBbG7b72OM563/7hkpUMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

> -----Original Message-----
> From: Naman Trivedi <naman.trivedimanojbhai@amd.com>
> Sent: Friday, November 22, 2024 1:57 AM
> To: robh@kernel.org; Simek, Michal <michal.simek@amd.com>;
> krzk+dt@kernel.org; conor+dt@kernel.org; devicetree@vger.kernel.org; linu=
x-arm-
> kernel@lists.infradead.org; Thangaraj, Senthil Nathan
> <SenthilNathan.Thangaraj@amd.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH v2] arm64: zynqmp: add clock-output-names property in clo=
ck
> nodes
>=20
> Add clock-output-names property to clock nodes, so that the resulting clo=
ck name
> do not change when clock node name is changed.
> Also, replace underscores with hyphens in the clock node names as per dt-=
schema
> rule.
>=20
> Signed-off-by: Naman Trivedi <naman.trivedimanojbhai@amd.com>
> ---
> v1: https://lore.kernel.org/all/c5d6effa-bdcf-49e3-a4bf-3713db889b70@kern=
el.org
> Changes v1 -> v2:
> - Fix the clock node names by replacing underscore with hyphen.
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 60d1b1acf9a0..385fed8a852a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -10,39 +10,44 @@
>=20
>  #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>  / {
> -	pss_ref_clk: pss_ref_clk {
> +	pss_ref_clk: pss-ref-clk {
>  		bootph-all;
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
>  		clock-frequency =3D <33333333>;
> +		clock-output-names =3D "pss_ref_clk";
>  	};
>=20
> -	video_clk: video_clk {
> +	video_clk: video-clk {
>  		bootph-all;
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
>  		clock-frequency =3D <27000000>;
> +		clock-output-names =3D "video_clk";
>  	};
>=20
> -	pss_alt_ref_clk: pss_alt_ref_clk {
> +	pss_alt_ref_clk: pss-alt-ref-clk {
>  		bootph-all;
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
>  		clock-frequency =3D <0>;
> +		clock-output-names =3D "pss_alt_ref_clk";
>  	};
>=20
> -	gt_crx_ref_clk: gt_crx_ref_clk {
> +	gt_crx_ref_clk: gt-crx-ref-clk {
>  		bootph-all;
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
>  		clock-frequency =3D <108000000>;
> +		clock-output-names =3D "gt_crx_ref_clk";
>  	};
>=20
> -	aux_ref_clk: aux_ref_clk {
> +	aux_ref_clk: aux-ref-clk {
>  		bootph-all;
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
>  		clock-frequency =3D <27000000>;
> +		clock-output-names =3D "aux_ref_clk";
>  	};
>  };
>=20
> --
> 2.25.1

Acked-by: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>

Thanks,
Senthil


