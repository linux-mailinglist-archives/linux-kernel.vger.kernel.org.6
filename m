Return-Path: <linux-kernel+bounces-190167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D58CFA77
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEC11F2194E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4AC224D6;
	Mon, 27 May 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TTFcUrTa"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C722079;
	Mon, 27 May 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796215; cv=fail; b=mpjSFm0m07mYTWlWRuLku1brPo4vJ8C2nUhNk2HyNqSkEUdXFAFicMfAGmEYrgobwW9qgLnwCA65YXLU2XjpAjzY+3nLS7IFybDPhzoERi7tLUXEzi+ziUIWqIsp+xw2e6SMV6PfOWOWVSlteWP8hezKwLUQQ96GOg2XRBXpoh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796215; c=relaxed/simple;
	bh=0r83rudtottwUHmJG/okPv+XDtoPaNMkMxpYhQpS/g8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GiIxN1Yp/HBB3NZQyKkvd8rILBH/7/RDNZqX3JUen0zPQ4tsIes3qrg/k3sZ14JnWMh+G+95j6guSQYM7GD4x0+S5XVPgRcbHkcQmevI4f+jQJXUTkshgHa3SyvMVAe5Ydzy8pDTKLcwj5ZAxQ3OCI9LDr11vKv7XfA3Ig1x/yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TTFcUrTa; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu4nNywTJFqBBS05Uvvl4QeC1YS+CS6tauXto0/LaV0iYF6l4JV2NDhyzqvnZx3/pCrDanw/5eLhch6F7mEfTNqbJcsYNub9LN8hJ2Qe51GkLrUoIP6BLyheKyt/QRhXGUH4nwiNWbrVxlq+I9LZmsVKkk5e/HSwLEpvu/mvqneHnhBWJTZcoqOxo98ExPz+H0azjz310CCRyV8GMkiLvWK3pc9P4bCoiJHjpDg3FWBfyV+XxA/UBkj8IVBXIStL37MzBMISmyxKLb+hvgWbHnYpfQRQLFGJmpPTf1VnUYPO+LvKehdJ3Pl4Ei4baGrEKkOIK0268+rRgGGzFlmmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjy2w7pSwQCP2eRyDVv5BqQ/tMmazt1CWtKNnrhp1U8=;
 b=MgpGEpQc+WKgmhw//oIWpj8nN5BP934EvymyS1zcJ9hNxXhiQmz0PYJx51D0nAcUZ+Y7eAYxB7YVQ9RFl2iyHSSEwCXG36iU9Dho59QFKIXToaE7aN8anhKAZ1CdGRy5e/kEHNIKPQKGUp55pxsEwVtRsQWdsMzuxFd1TgQcbSdGDVc0bBEFsAqoNqLa5GQ8uCMc041+or9UFe01xi64vdy4mKQGlXjU/9K2mQcYaZRC7WQ0q6r0x2inmeK/NaMIW6cTN39ZMomhy3JaeyJx6IbhniF5nivRmW/2ZZivAuhg3P7C8QMje2UePQLqXFVZw4Utx2dfPbxDssHgosJTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjy2w7pSwQCP2eRyDVv5BqQ/tMmazt1CWtKNnrhp1U8=;
 b=TTFcUrTarPd+9Of+hzurqtreyZ8qR/Ex5kBvFf1gIX48DXW3GNv5pgDVq8+ASPR5/V8DgO0uo3OJesHg6HheI2j5QszWCDoTMjHhSepnugTQP7DnlBEA+RR/35I0sThynnhL6yMVlsZWtzK1VL8RykAmKBDYk5JjWrWNJVfI2Rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:50:09 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:50:07 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com,
	gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com,
	joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com,
	Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de,
	m.othacehe@gmail.com,
	bhelgaas@google.com,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	pengfei.li_1@nxp.com
Subject: [PATCH 0/5] arm64: dts: freescale: Add i.MX91 11x11 EVK basic support
Date: Mon, 27 May 2024 16:51:53 -0700
Message-Id: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: 6311255d-d16f-44e4-027e-08dc7e21a061
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|7416005|376005|52116005|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?NzT94lBHC4us9A7pOVP5iLrbHtDVB8wwQfjVbhQbSff8VmNv4gdnUuaUktWg?=
 =?us-ascii?Q?mQcbMJTMJJsnY/wdG3arAPVaUDEI3PaHn9ymaSNykSiTTo+W5viwIX8eGPkU?=
 =?us-ascii?Q?f0bRAfIG3UH7SdzL+YpUQG2dtMMwBSE5jkNzOS1sXXMbUoGlHJmogGIVV5Lu?=
 =?us-ascii?Q?32JXUKb7l8gl3I6ZhsdZXZHmtMuyaGiCGPbrvSN+zJAxly+GVl8UcXnYfAvK?=
 =?us-ascii?Q?tBr6YCZc0XBz3KNvtq5+NdkFEhnyRYsT6iAOwEhqeQQnCyyQBAnmL/9hAF24?=
 =?us-ascii?Q?LEdeBpnH6au46T3nlfLXItwqkS8R/6/v9mXzJahVIQCZbp20RvzH5++21QX/?=
 =?us-ascii?Q?SOYRtpbcvOH0wxHybke65dBi3ciprEDi/rYeOy6AQUNWJDEQMjw2pAaMkeMi?=
 =?us-ascii?Q?J4/vvrTMoWlRRfFRrPQQk/yx7U1umqohcpwckla84AdCCJW1deydFVFdxjsU?=
 =?us-ascii?Q?icqZEOI0dRibug7kFfgVUnqPPX7AWNLOqUUJbXi/jp9cDtqIWL20okhjSllD?=
 =?us-ascii?Q?A2R36MC7IVpqHIRdFJXTpbYVO0YmcAGttYwwZhldetqX2Af//wd1tT0cCuKT?=
 =?us-ascii?Q?kI413Ju6RdBXdRDFFHfYVak4fkK27LmJHX6B03O1a972ALfN+C/Rz7eKdrn6?=
 =?us-ascii?Q?SVyeaJGCZ815EuW/eK6OSHmXEj90HCENPp5IZ9ejwPxVBKKj/x51xx8fSzIy?=
 =?us-ascii?Q?T9yQJXJGKhTeOMD5WSruPLNT8kDsYjygvEFPE6kQAVwh2EdwdBobEQQr0juD?=
 =?us-ascii?Q?JFFN0G9Q0uMZkM0T33+vBvUmnVxEQL+k8hRzzHrPVMIEsRCr5he7oem+eRn9?=
 =?us-ascii?Q?9MCSfK1UuO6jyk3UJDjbJ/AKnkIYYEbiVbLcSWxI+RemB1KNm/5U2UoYxmbU?=
 =?us-ascii?Q?IKbh9V6o4LX/MLZLBsYyOFWrpNEp9Ahi/2qS4lN9GfAyvBuvYmq3+riSJULo?=
 =?us-ascii?Q?kvOblYb4mpGnVVb4QPZ/uiTH4a9/JQsmIWZT9NRu2kYePB3J64kuMibwen9n?=
 =?us-ascii?Q?g8ffMb3h9KJkP21mzxxB7JDnYUkY/3yyOwxIUh9kKb1I0nhNF/sKQHp1m8eD?=
 =?us-ascii?Q?lWFHmyanG8rTf+20P4CWFkOnI7XRrhsB23SGYORDi0THSU+iy3nlSfuH4hIc?=
 =?us-ascii?Q?rBRaIybHqdMhyfjlw96+faEBz35ooge6LLHfK25MfXpXl5FuZm6B28DwpC3C?=
 =?us-ascii?Q?6tZEC3PSesoSYRouq1p+5IXSBwWSjSKK3UPhg1gkuYDn9nrFDs6Cf9PESwgE?=
 =?us-ascii?Q?IHDuuCZJTZA6Yu6nMkKx5m054lasPhTj5HHTm44CShr+SW0Yy0tTahhzp5hN?=
 =?us-ascii?Q?yD50qE9kU31Zs7yOoW7osI94OKrM/lXcwNdPRPlZcu5SgSjk5IMQyr/t5bBB?=
 =?us-ascii?Q?SHeK/dw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?WxQ48jg8OSNCBh8ujOw2Rc/fL1NTVh/6sjfbWIRX2h32qZfd7hEdtHBraDPz?=
 =?us-ascii?Q?qU7N2/yq1eRdRm6ova1qHENuZJagmkNiQ6VPHWa5TvFXlOb6HlblgelhvJFs?=
 =?us-ascii?Q?A5ITzFw5kgKo1ktjfwOg3VtaFRVECb9xMzJY23P21bw0pWkzh364M9WRHa6V?=
 =?us-ascii?Q?/D3UM876ZV5PsEn/27r3wLOlDg9kvJ27SSsI+s6O4XegHHkAtrdbIBoVqd4Z?=
 =?us-ascii?Q?4U2lGy+27bWxHHP1BaQMNHA8R1K3iEiL865vAhVfCoj9Wqqj1PrEtYWUYcsR?=
 =?us-ascii?Q?MfUKBOKuSAAXPDTazuT6LxMlXED6VDD8bxm4YAi9cr1osFeIvdZRHgoyKoMn?=
 =?us-ascii?Q?GsyqAIsi7lYUALbJRC0U/u7ImjACMqbZ1zr4TqmrLHrdZylOsevC77ulU0xR?=
 =?us-ascii?Q?nh1oRMRXHDb8bpwyUvRhZZ9ejCy2G6C99xzjwpH5fEbELpeI3dwWOziE+hGk?=
 =?us-ascii?Q?/IfjiPAEx4GNHPPp7PcKpDIoy34uT7OnE97HD8gEKMkWA1SdJ0dLDhZv315/?=
 =?us-ascii?Q?/HxU7YMPiRMhKPdXmQaX9cgue7g8MzHnYP9KhzGNQvKpHfbaLBB9mDN63TDD?=
 =?us-ascii?Q?SFpvHnS8mv8iejAE6lYu1ryJVvgQRGL7kbF+0YN3VBSwDxDEJSig7TpWIsZZ?=
 =?us-ascii?Q?663LLHXtqMzpHgi9hTaG3D2YwZsYT/OSgoAMVq+gunoCteen4EcGr/BV4box?=
 =?us-ascii?Q?rwj7VLxnmGbo2oiYBYwfsMNRQf1AscyJeyiXL6DR6zwkQFzB0+RbVtQ9W42q?=
 =?us-ascii?Q?puTF/zHK/3iRzSWjj30wk8zPEDIBD67fiEYnbIN6samFtdf8y0iXAepjnOkT?=
 =?us-ascii?Q?QgBGzbXHpd2yIJzf21hnGnQC9ANc2fOTXPMJbniMz5kgBH0CVW2sFudH/sLi?=
 =?us-ascii?Q?ssmDHaQDfUqu2Gk1rso1RaajoBirvp3OchrvCMVOEg43zsqBQ06K8/VQK0xk?=
 =?us-ascii?Q?ukN4SE+eJk6DXxLqA3QwkjiLBb/qUOIrrRcZ3RgrRrAc23hiXfmC8RCUdjGF?=
 =?us-ascii?Q?1wl+XWowh21SHwhXMgY1u2AT8grF+qY6BsPANnO+nEDz0DszgQ/8Xw+bicOQ?=
 =?us-ascii?Q?qRAhV/OFMXNInF4E6wzbs90pMpmYz7RlfG2eFB8SRlCzk+lHPXXh8rI1hyZi?=
 =?us-ascii?Q?7Bvb47TcPSdTjljcvMIcL3c6qzSuBVkrz75bCLq/LZBfeCNxENpSUA/J1ard?=
 =?us-ascii?Q?IZjn1BDUxaHOYTK/C9CR2mzV9tv8JR7l9EdYTe9O5O2UTbhcTgcqz3t8l2SN?=
 =?us-ascii?Q?TwWQcCeNV8RYybQSy5rivkx4TMD5GcNZcFODxo+ZH8+EWdGP+YW+OKjrvjgj?=
 =?us-ascii?Q?ltkE2igCndDlC9NZW2fkhKss56s8GuPvfoe9tvbSLDag5+r2LQ3yVLN1R2FC?=
 =?us-ascii?Q?gxEWRPUgo60w35bolhtBwPgVFld+mh85+w20Wavx0DBIrb/V2bW6ySIkrPEP?=
 =?us-ascii?Q?2IQ0IluzaFPViOqabWhLHtZyQNYsO2if6pYI6bhhUBH9pxsWBOV0fU6bkkq5?=
 =?us-ascii?Q?03I2rsJHiZHkocM/9PgWDKwywM7Uz8ahTAFIknZNujh8FHnwaPF1RdPntdq+?=
 =?us-ascii?Q?YF2b5ijhjx3vtNGb+MD4Rb8rCVDJVA0ujGDMAy49?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6311255d-d16f-44e4-027e-08dc7e21a061
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:50:07.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzzghDW6cHyXGRfvxqiP+ZMG2u/KE08IHYO2fQE91buc7U/CrkxO1WoumvrBYxdAQPZHaOdIOpwN4VAFqm/eCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

The design of the i.MX91 platform is very similar to i.MX93.
The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core

Therefore, i.MX91 can reuse i.MX93 dtsi.

Pengfei Li (5):
  dt-bindings: clock: Add i.MX91 clock support
  dt-bindings: clock: Add i.MX91 clock definition
  arm64: dts: freescale: Add i.MX91 dtsi support
  dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
  arm64: dts: freescale: Add i.MX91 11x11 EVK basic support

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../bindings/clock/imx93-clock.yaml           |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 807 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
 include/dt-bindings/clock/imx93-clock.h       |   7 +-
 7 files changed, 1657 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi

-- 
2.34.1


