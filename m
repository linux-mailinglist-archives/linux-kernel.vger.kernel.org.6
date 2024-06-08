Return-Path: <linux-kernel+bounces-206954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6290107E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4582B222C6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B3177986;
	Sat,  8 Jun 2024 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QD+0ukpJ"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2074.outbound.protection.outlook.com [40.107.114.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6B29414
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836187; cv=fail; b=VR9MzbBTvPe/IpjKmWobE/fr5AvkwEl0dgczUtSgrAfhrnkrICvnLvvTSgt98gP+Wy0+3V4MwWT13klhVUqmNb0gtIaIQFtOtBdYEcrQ76zJz/iVnz7FaPOWiWqzps04uxX65oAD4yK+bbzG0s2R94MQIkF+OuBWhBAEbgq1KtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836187; c=relaxed/simple;
	bh=A6jSsbIOPBkqmFZybvklY8LAHaN0GgCAuin/ws5lDck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R+TkMy7ZyQXvTP1JKEtEVrUdpG5CkzEQ+uT2Evp4+STVA1T/ZqiJ53Y6j2TNC5pA1V1JrY2wjsnw+14ngr64zfR2eSXj03TW5uHabXTlyNtLIHvnwcYJmQjtxPa+t4TshEHzAl70aYP22UiuVG5C+U+5H7jWCicJ7LIwM9QHuq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=QD+0ukpJ; arc=fail smtp.client-ip=40.107.114.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl/yHzyKuqn5ihc/SHfJvtgszhp9gps7qpyCxcrnRf3th0iANm+GLcy7sU+FdnSoy6rwg9VxQlb9NPG/BwI2LVQAWOC2s32PTjYrhVguT7THZ27hyXsctIxRF2yK8vhP+FHqM8a2oY6uk1aZz6ujdUKToEMjZRSphAuAxLlU40/afLlcLE+Q1bwkGH1UlEIjWhH3EeVx6tJKKAvBtcXsDpAcTw8yOVGpF2RREcxFRoSs1XhscOoFSGBrh8vjcF+kgZes2YcNp1L6d7780wF/JGGx/Z9if58iYWPV1D0vR5PNVMisArFPE7Bsp8hMl4s9fV6ios/MgNjHzrpKSrUiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjK55HYxf9YIlmZxIuKcNLnIE7gkbIE+Nz6/KeIHPoc=;
 b=byspFVaM4MlxRS02o3MMms3vk/kJUF+fW2SiXI5oxW4mVLSqhpA5aXUQgZmktJRdgPMsNeczWGy/mdpJ6DTpMeK+Hv+JfjrhdgXDtXRM92//fOC6sr3R9hbPyCBYyNO5pmY1QvZsZUaN8i6viCU84JbU2o0QyGb6HhYPu6dwV+LMhVrxAR2DJv/ZhdvsViJjOa9pzSJxNTUDI9gnssv9xncZ1Fi7NcukFCVb/oGZRHxZvVWwEBc6dyAG2YtKmMAs5azhXKBjx3dhiPrV1O0XFRYaxEDGhqvMt6Jg2/bGOW84Xv93ePHSD5OlZS5IkUEoXxhLEUAAeMR/AdOT4tAsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjK55HYxf9YIlmZxIuKcNLnIE7gkbIE+Nz6/KeIHPoc=;
 b=QD+0ukpJAj9vkt7vJojQSDcojz8dq6HgUIvxyVKt8GoFHsK8kPhzBifksWRraCXAHy4kt6Bm7T9D7fOr2YyNFW87JdthOld/O1h4gCBKQjSepYb5W3UntKfIKkdCyzNC9AcA587r4zy89RzOuhT/kgrqswX7FMHBPSnb2insY68=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB6289.jpnprd01.prod.outlook.com (2603:1096:604:f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 8 Jun
 2024 08:42:59 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 08:42:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: kernel test robot <lkp@intel.com>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: RE: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning
 (graph_child_address): /soc/video@10830000/ports/port@1: graph node has
 single child node 'endpoint@0', #address-cells/#size-cells are not necessary
Thread-Topic: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning
 (graph_child_address): /soc/video@10830000/ports/port@1: graph node has
 single child node 'endpoint@0', #address-cells/#size-cells are not necessary
Thread-Index: AQHauWXuNNufcFVNdEChjApJ0f0KZLG9jE4Q
Date: Sat, 8 Jun 2024 08:42:56 +0000
Message-ID:
 <TY3PR01MB113468C94F2ED383F5EB883A986C42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <202406081329.snoMrZsJ-lkp@intel.com>
In-Reply-To: <202406081329.snoMrZsJ-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB6289:EE_
x-ms-office365-filtering-correlation-id: 0f3d9c62-d0c4-4e93-0f47-08dc8796fe6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|366007|38070700009|220923002;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ciUzGACaFIIla1zaYtk2bV+W7nxTVJ9I01DXXMOHU2DIx1Zq8uajxamIdwH4?=
 =?us-ascii?Q?Dsh6smdZFDE1Q5QigjsayRoHfSris2o9FS5PMC8sI68RnM3BWA9QYObnKFkb?=
 =?us-ascii?Q?h0bNYU/kUzIpgoYmSprw3f7Vy4cjgCn5Ipt1BWCS6SSE0a3zbEtFghfKGxNZ?=
 =?us-ascii?Q?GRAVfo9yiMUWFS0dg5rppZuzx2hp3ztxBEMEu9bNyfD8dTd04EfmLwtvgIVI?=
 =?us-ascii?Q?DClwUi2IZhpmj56Ed279Ih316gkA08m805iuo4DHGFey9cKlv0IetJC0LEfY?=
 =?us-ascii?Q?lWfq61I8A65vFXq3PglItTEMdVEbXuFlym+DmnywZ0Ko++lmcxL56wqT0O8q?=
 =?us-ascii?Q?Rwx/cboVbD56FTv16IFwHfYVK51PKsqsBert16hxdc3PYR8ngixhme8fAn8d?=
 =?us-ascii?Q?riL4EmvXy9rfM4NURvbb5oPPeII6xZRdT002ElGxnJazua4X3Jr2H9iBQKOd?=
 =?us-ascii?Q?5sJ6gM3gUTVtfdM5x0jIG5PNOGYufgM1mU/kHuQ7FuMVjrIgtDmx76z7LFLw?=
 =?us-ascii?Q?j/0M+SIbqjYkYI6h/pcvDHlqhXRwM+abfQ3TLMwe9boGh4A9FD0BRbv3hBhM?=
 =?us-ascii?Q?XueiKk9QBrR5g2owmdNcL+9VH2QLCMe+3L58MVReZ9mSVrfiVQ2ecuMwYe08?=
 =?us-ascii?Q?HAdjRYNQnPRpCT3hACi4SlBMfmnNHJxkRrSHNz6BaFRAErqyl7At0C9vS9ef?=
 =?us-ascii?Q?R2OKqgjzW1iZ4/+5AvchuHXHspKb49zZv/Um8RsoDyAa/vJ9SP2iV6FD6xeP?=
 =?us-ascii?Q?eWqV+36Cuh6SvUMDnKn7BLCnshW/OUSLU0purrHteH3Uc6JwwEXuCDCxhFss?=
 =?us-ascii?Q?MQyA3AciI4XAzFzQfz7fpG6S7scu3tRK9l5lFwK9TKZK8mToJ5WPFH8kE6W4?=
 =?us-ascii?Q?LO96a7Ve+T+tJLK5sxeRU5phNETAaWGav6sYy+gSHyQn8pd+Z3RKgezjZpao?=
 =?us-ascii?Q?VSCS84fifAGWgDPPOJRHKlaA1XxyzvT+VDt1eXzqC7kFElBPHZ2XlaFsYkJC?=
 =?us-ascii?Q?wwh8OfJIHmMgZnfOZJu/aLuqL3So4mXgDIJK9zKkmqD4XcEOAH6yO/pB/JS8?=
 =?us-ascii?Q?XRxuBp3dUI68H8xfDOz0Gd9mDP08SxAD9Wq+CnYOrBvRM+ZEzLwGNjDTAcrx?=
 =?us-ascii?Q?JeBxAB7kzfgfgp7PXYCJk9F0MBgKyk9dKQc4nH18teFg2UqpIrMgXjGFWveg?=
 =?us-ascii?Q?xkzXF1mciiAfLnzaBEIvEs18F1j9vOqadlywS5yCmBCzckvu8JflHMdCcyEK?=
 =?us-ascii?Q?fRcBDnDfLe3HwDdBkHTRxxBHMiGnjh0OYRX5QdidGBk4nURRuYOQfHhqD4JQ?=
 =?us-ascii?Q?ywjfStXthM13nSTvi1kHnXnCQMvaU+WjOmtiPeOGZL5CsA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(220923002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JOvAlfR5j8J8Io4cmu2C9tLyKOREEjO1tsEDakXUVqIxyOL2zhHROsZNpgXt?=
 =?us-ascii?Q?WGQ0kJNZFvx7X2gwG7cXYwci2wzhJ4wZxEtV5kfpPb0KK19HyfEGSTuOSWt1?=
 =?us-ascii?Q?Q1hDDa2H+KWWXr7XxkHRZflHYELuypEaAPs8atVfc0mPhiQkq8KbqubmbNCe?=
 =?us-ascii?Q?WUTRBwil67/TIuKaWFo3GOXbklRbY0bx8Gb5SigkFrv0STL7XuvJ19qeh075?=
 =?us-ascii?Q?ymbjcmEV+ua1nNOpSBF6BVkORp2H5WVPBHcnXg7wsL9TrcIvf/MlGQjuLBn6?=
 =?us-ascii?Q?w57YXKs1JIRsUDfZzKp7cdg9acuBTe4l+TE4n1D3roY2aFxCPN8NbUwttR4X?=
 =?us-ascii?Q?ChDgPhVjjGq9s4qZwvjhEVOMoLNdglodMkvFB4CyXRC1iaFh02ETladqAcDz?=
 =?us-ascii?Q?STcj+GtKO+jCUMIqR0FWlj8s6v4X1Rgiugz7DawVjbnkZBEdaEqmu/r6xFNz?=
 =?us-ascii?Q?KDlTzVk4yUj4/5CqWuc0KUe7PdPLwB2sU2EuR9qPigL3N2jyM8Lf8vt67QZk?=
 =?us-ascii?Q?GhGH88z+vgpIb87Xq3TmOsxh8mNxvTdsRtKrrK5W21r+vKwmQjRlKqaF7DvX?=
 =?us-ascii?Q?5Av64aUB2Kr1+svizwey/fHhfXZOU2V+Y3BlHExttC8ETnJvP6vWdBWfX547?=
 =?us-ascii?Q?oonmGwwrao6zB903F+SyqwKGWoTzZhXLTmRZt2nvyhkO91W5PVG1Q7QFjWWz?=
 =?us-ascii?Q?GTOSNuGBF1cigD3yrHQuMcvh6Kbg4MKYTlVupeYPgm/yaV32uOUkiOSV/3Ql?=
 =?us-ascii?Q?fO2lUL4yl4A6wtIMuHT/phwOAqZZ464bE2rPxHxZwt6oBLp90AuHbR1pIIEO?=
 =?us-ascii?Q?hfoSGEH7a/9E5iRY7KjIXN9MncPJtgkO9xrcnrMcaJC5/sALaAxl+lls10Xc?=
 =?us-ascii?Q?oXUmAEvichOd2BftaKzsbo6w29X6UtChiUSGprg+s7XfOTJlsBCSQ09tsG/v?=
 =?us-ascii?Q?uhyHGOG2fclMPatOVEz92ItiszZSZHjONwkyH6m11h9MXH8BRPUc8J18fQ6C?=
 =?us-ascii?Q?L05be3NVrXAfIN9JIyn34nO38Nh8ct/iW9HDu3Lhr+goBP+0V5RTJsPLctpI?=
 =?us-ascii?Q?hTH1w7KNaYKpVMgjuH2v4OWp764jXTFldjsMPS8AI2NX6iztSIHm+Pd102AE?=
 =?us-ascii?Q?6+MrwKlj9E83Twpf2zUduwsbsmpwHsBEhWkJOjIFQv2RqKUKnZoKbLG7JzLO?=
 =?us-ascii?Q?ewGVd5uGCtEqcOHibeSs279+C66VpImppAYf44KUtYqyU31PeFUhwnhFbGmj?=
 =?us-ascii?Q?h7xRAUoajj0iGFL/xoF+6lvCAIpfxU58UbPVuzeNMk7CnlL+/ak9ajSuMSdd?=
 =?us-ascii?Q?aKN4SK0ygeGELIyoeRVAKztbG7ILph/gN8Dc2qRZNAslbQeNsXfBtiOfBwHd?=
 =?us-ascii?Q?vVVd+QHCm2e/Dt99C13RLGBuUPbAcJOYqw5QkzRixpaGqMKHuk47no3B+6dW?=
 =?us-ascii?Q?nrif+IYOzd6H6XVrvGaDSUr0kUNoEsqeiLvl0OPv5+RfjDwp1xbAynOwEaPT?=
 =?us-ascii?Q?f86FfujJ4FS/wih8HhMvWLbUlzSJu5LGlnyLYNmCZw7rSM9hfcarq8GVD+qD?=
 =?us-ascii?Q?vBLzTgjXO3JoAWloCiks5oToI85m1RVHALuJ8qxfySFiz0r2WnM34u1AoWlI?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3d9c62-d0c4-4e93-0f47-08dc8796fe6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2024 08:42:56.2381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qp73TkPcQb+q3HsuLBuPP+Lpo0fJ6PZZZkXi3jMZJQ4E/WEiJJoK+VCmgdoNF+ywe0nvfLkKmSdCkkLOUk1HCOzLJldJ3bJ7ky0GXUZBZic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6289

Hi All,

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Saturday, June 8, 2024 6:37 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Geert Uy=
tterhoeven
> <geert+renesas@glider.be>
> Subject: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning =
(graph_child_address):
> /soc/video@10830000/ports/port@1: graph node has single child node 'endpo=
int@0', #address-
> cells/#size-cells are not necessary
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   dc772f8237f9b0c9ea3f34d0dc4a57d1f6a5070d
> commit: 971c17f879352adc719ff215e0769f8e0a49d7c4 arm64: dts: renesas: r9a=
07g043u: Add CSI and CRU
> nodes
> date:   4 months ago
> compiler: aarch64-linux-gcc (GCC) 13.2.0 reproduce (this is a W=3D1 build=
):
> (https://download.01.org/0day-ci/archive/20240608/202406081329.snoMrZsJ-l=
kp@intel.com/reproduce)

As per this,
dasb@ree-du1sdd5:~/lkp-tests$ mkdir build_dir && cp config build_dir/.confi=
g
cp: cannot stat 'config': No such file or directory

So I have generated .config and copied as config

Than I got the the below issue,
COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-13.2.0 ~/lkp-tests/kbuild=
/make.cross W=3D1 O=3Dbuild_dir ARCH=3Darm64 olddefconfig
-bash: /data/dasb/lkp-tests/kbuild/make.cross: No such file or directory

Can you please provide the details how to get this tool chain?

So that I can reproduce and fix the issue in same environment.

Cheers,
Biju

>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of the same
> patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202406081329.snoMrZsJ-lkp@intel.
> | com/
>=20
> dtcheck warnings: (new ones prefixed by >>)
> >> arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning
> >> (graph_child_address): /soc/video@10830000/ports/port@1: graph node
> >> has single child node 'endpoint@0', #address-cells/#size-cells are
> >> not necessary
> >> arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:120.11-129.6: Warning
> >> (graph_child_address): /soc/csi2@10830400/ports/port@1: graph node
> >> has single child node 'endpoint@0', #address-cells/#size-cells are
> >> not necessary
>=20
> vim +85 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
>=20
>     60
>     61	&soc {
>     62		interrupt-parent =3D <&gic>;
>     63
>     64		cru: video@10830000 {
>     65			compatible =3D "renesas,r9a07g043-cru", "renesas,rzg2l-cru";
>     66			reg =3D <0 0x10830000 0 0x400>;
>     67			clocks =3D <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
>     68				 <&cpg CPG_MOD R9A07G043_CRU_PCLK>,
>     69				 <&cpg CPG_MOD R9A07G043_CRU_ACLK>;
>     70			clock-names =3D "video", "apb", "axi";
>     71			interrupts =3D <SOC_PERIPHERAL_IRQ(167) IRQ_TYPE_LEVEL_HIGH>,
>     72				     <SOC_PERIPHERAL_IRQ(168) IRQ_TYPE_LEVEL_HIGH>,
>     73				     <SOC_PERIPHERAL_IRQ(169) IRQ_TYPE_LEVEL_HIGH>;
>     74			interrupt-names =3D "image_conv", "image_conv_err", "axi_mst_err=
";
>     75			resets =3D <&cpg R9A07G043_CRU_PRESETN>,
>     76				 <&cpg R9A07G043_CRU_ARESETN>;
>     77			reset-names =3D "presetn", "aresetn";
>     78			power-domains =3D <&cpg>;
>     79			status =3D "disabled";
>     80
>     81			ports {
>     82				#address-cells =3D <1>;
>     83				#size-cells =3D <0>;
>     84
>   > 85				port@1 {
>     86					#address-cells =3D <1>;
>     87					#size-cells =3D <0>;
>     88
>     89					reg =3D <1>;
>     90					crucsi2: endpoint@0 {
>     91						reg =3D <0>;
>     92						remote-endpoint =3D <&csi2cru>;
>     93					};
>     94				};
>     95			};
>     96		};
>     97
>     98		csi2: csi2@10830400 {
>     99			compatible =3D "renesas,r9a07g043-csi2", "renesas,rzg2l-csi2";
>    100			reg =3D <0 0x10830400 0 0xfc00>;
>    101			interrupts =3D <SOC_PERIPHERAL_IRQ(166) IRQ_TYPE_LEVEL_HIGH>;
>    102			clocks =3D <&cpg CPG_MOD R9A07G043_CRU_SYSCLK>,
>    103				 <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
>    104				 <&cpg CPG_MOD R9A07G043_CRU_PCLK>;
>    105			clock-names =3D "system", "video", "apb";
>    106			resets =3D <&cpg R9A07G043_CRU_PRESETN>,
>    107				 <&cpg R9A07G043_CRU_CMN_RSTB>;
>    108			reset-names =3D "presetn", "cmn-rstb";
>    109			power-domains =3D <&cpg>;
>    110			status =3D "disabled";
>    111
>    112			ports {
>    113				#address-cells =3D <1>;
>    114				#size-cells =3D <0>;
>    115
>    116				port@0 {
>    117					reg =3D <0>;
>    118				};
>    119
>  > 120				port@1 {
>    121					#address-cells =3D <1>;
>    122					#size-cells =3D <0>;
>    123					reg =3D <1>;
>    124
>    125					csi2cru: endpoint@0 {
>    126						reg =3D <0>;
>    127						remote-endpoint =3D <&crucsi2>;
>    128					};
>    129				};
>    130			};
>    131		};
>    132
>    133		irqc: interrupt-controller@110a0000 {
>    134			compatible =3D "renesas,r9a07g043u-irqc",
>    135				     "renesas,rzg2l-irqc";
>    136			reg =3D <0 0x110a0000 0 0x10000>;
>    137			#interrupt-cells =3D <2>;
>    138			#address-cells =3D <0>;
>    139			interrupt-controller;
>    140			interrupts =3D <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HIGH>,
>    141				     <SOC_PERIPHERAL_IRQ(1) IRQ_TYPE_LEVEL_HIGH>,
>    142				     <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>,
>    143				     <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>,
>    144				     <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>,
>    145				     <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>,
>    146				     <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>,
>    147				     <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>,
>    148				     <SOC_PERIPHERAL_IRQ(8) IRQ_TYPE_LEVEL_HIGH>,
>    149				     <SOC_PERIPHERAL_IRQ(444) IRQ_TYPE_LEVEL_HIGH>,
>    150				     <SOC_PERIPHERAL_IRQ(445) IRQ_TYPE_LEVEL_HIGH>,
>    151				     <SOC_PERIPHERAL_IRQ(446) IRQ_TYPE_LEVEL_HIGH>,
>    152				     <SOC_PERIPHERAL_IRQ(447) IRQ_TYPE_LEVEL_HIGH>,
>    153				     <SOC_PERIPHERAL_IRQ(448) IRQ_TYPE_LEVEL_HIGH>,
>    154				     <SOC_PERIPHERAL_IRQ(449) IRQ_TYPE_LEVEL_HIGH>,
>    155				     <SOC_PERIPHERAL_IRQ(450) IRQ_TYPE_LEVEL_HIGH>,
>    156				     <SOC_PERIPHERAL_IRQ(451) IRQ_TYPE_LEVEL_HIGH>,
>    157				     <SOC_PERIPHERAL_IRQ(452) IRQ_TYPE_LEVEL_HIGH>,
>    158				     <SOC_PERIPHERAL_IRQ(453) IRQ_TYPE_LEVEL_HIGH>,
>    159				     <SOC_PERIPHERAL_IRQ(454) IRQ_TYPE_LEVEL_HIGH>,
>    160				     <SOC_PERIPHERAL_IRQ(455) IRQ_TYPE_LEVEL_HIGH>,
>    161				     <SOC_PERIPHERAL_IRQ(456) IRQ_TYPE_LEVEL_HIGH>,
>    162				     <SOC_PERIPHERAL_IRQ(457) IRQ_TYPE_LEVEL_HIGH>,
>    163				     <SOC_PERIPHERAL_IRQ(458) IRQ_TYPE_LEVEL_HIGH>,
>    164				     <SOC_PERIPHERAL_IRQ(459) IRQ_TYPE_LEVEL_HIGH>,
>    165				     <SOC_PERIPHERAL_IRQ(460) IRQ_TYPE_LEVEL_HIGH>,
>    166				     <SOC_PERIPHERAL_IRQ(461) IRQ_TYPE_LEVEL_HIGH>,
>    167				     <SOC_PERIPHERAL_IRQ(462) IRQ_TYPE_LEVEL_HIGH>,
>    168				     <SOC_PERIPHERAL_IRQ(463) IRQ_TYPE_LEVEL_HIGH>,
>    169				     <SOC_PERIPHERAL_IRQ(464) IRQ_TYPE_LEVEL_HIGH>,
>    170				     <SOC_PERIPHERAL_IRQ(465) IRQ_TYPE_LEVEL_HIGH>,
>    171				     <SOC_PERIPHERAL_IRQ(466) IRQ_TYPE_LEVEL_HIGH>,
>    172				     <SOC_PERIPHERAL_IRQ(467) IRQ_TYPE_LEVEL_HIGH>,
>    173				     <SOC_PERIPHERAL_IRQ(468) IRQ_TYPE_LEVEL_HIGH>,
>    174				     <SOC_PERIPHERAL_IRQ(469) IRQ_TYPE_LEVEL_HIGH>,
>    175				     <SOC_PERIPHERAL_IRQ(470) IRQ_TYPE_LEVEL_HIGH>,
>    176				     <SOC_PERIPHERAL_IRQ(471) IRQ_TYPE_LEVEL_HIGH>,
>    177				     <SOC_PERIPHERAL_IRQ(472) IRQ_TYPE_LEVEL_HIGH>,
>    178				     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
>    179				     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
>    180				     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
>    181				     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
>    182			interrupt-names =3D "nmi",
>    183					  "irq0", "irq1", "irq2", "irq3",
>    184					  "irq4", "irq5", "irq6", "irq7",
>    185					  "tint0", "tint1", "tint2", "tint3",
>    186					  "tint4", "tint5", "tint6", "tint7",
>    187					  "tint8", "tint9", "tint10", "tint11",
>    188					  "tint12", "tint13", "tint14", "tint15",
>    189					  "tint16", "tint17", "tint18", "tint19",
>    190					  "tint20", "tint21", "tint22", "tint23",
>    191					  "tint24", "tint25", "tint26", "tint27",
>    192					  "tint28", "tint29", "tint30", "tint31",
>    193					  "bus-err";
>    194			clocks =3D <&cpg CPG_MOD R9A07G043_IA55_CLK>,
>    195				<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
>    196			clock-names =3D "clk", "pclk";
>    197			power-domains =3D <&cpg>;
>    198			resets =3D <&cpg R9A07G043_IA55_RESETN>;
>    199		};
>    200
>    201		gic: interrupt-controller@11900000 {
>    202			compatible =3D "arm,gic-v3";
>    203			#interrupt-cells =3D <3>;
>    204			#address-cells =3D <0>;
>    205			interrupt-controller;
>    206			reg =3D <0x0 0x11900000 0 0x40000>,
>    207			      <0x0 0x11940000 0 0x60000>;
>    208			interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
>    209		};
>    210	};
>    211
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

