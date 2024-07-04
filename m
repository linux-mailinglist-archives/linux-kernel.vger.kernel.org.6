Return-Path: <linux-kernel+bounces-240984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8679F927554
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44362282D67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD891AC44D;
	Thu,  4 Jul 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qZz0TUi9"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18FE1AC231;
	Thu,  4 Jul 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093287; cv=fail; b=EMU2bHA8C+4zsYxrtgdWG81DZjTcLN0jgBBe3/fwQQe1YsZosET9bSXth5w3XyzGQdrP1UXqqMEwIqEbO/jjct5P2BAEu5g+0Gj+LyvXkWnwkDGeQmbcXjy2A6vQfzV4izM42a0lCMi7kCFtbPfCa8LwExmCyHO1D4VDPNS7s68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093287; c=relaxed/simple;
	bh=KfaGwfSRuXrHBmb3pCeYHkdxpEBi8EBGqMIdbUJ1LMA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JoEb63EuduJYQyvh5jz2miHFwwMymEzZyd73HlD6weZiSRaABKrwLULR7i+/15zbeCgLLewB+wkDHMFyQSKkquJW2qjP+m5+XKe18zEGuXRKus/gfhf6vRxSJxJdWs+MbC3mrFC1n2IrJKF/APcOAsSNYgjRUkioU/OlfcjPTQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qZz0TUi9; arc=fail smtp.client-ip=40.107.241.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+Ml+X1iY8NrfNkhrtJLLegWY0+tUxK1Ri999Q6cxPJuuNULPzzpTGcEt7zTULWmnQHgqwYLHAeXEGgxXGuUuIwaQl7z3o7TiOwBtpaG83FcsaBAm33ldM7O7x4WgStucTU7S97dzv1B7heMboBYEgnraIccBmcVeeHAgyRXtiKtMhgAd+0glqld4RyrcoxJ+ctSHo9TExBjLQhgpWtasOSQ+pH1k/bQxxO8FdDAkdFpfz4KsNml1IAFk8C45RQ+c7xiXRYYA/6QwtlVODChDtR9v12y8kkoj5CRwfgMp3hBo93KHwrIR6Vvb9DW1wX/D3HV+H4NAydMaOUpNSRBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0aJW+9/SdbrGrGZ8ytJo7ivT6FRosF0aObvHg/VOmM=;
 b=g4kd97sPBDRdvg2fTVy4g/tJY/HgnAvc+vy0tgT0mI5ESz4YQKq3MLlaFd9uXzG2gDGn85UJafO4+l99L5O5dVSZXNW8ePokrmV0AvHHcRlN12FyLft8nYmI4cn+YxYEtL5Nfw7OeBO1aE4rXGjqGWIwtbkXDx61CJvJwoch/QckFtXG1+zPgx9fZ8C1Mho9vLgP9lm0ZqKvzNwGnGd3gTEGeehSXw9isteLrQ1BSlDZfsBzV4M4gXQLUuwh8vOIv0dYt5XMZZZR+M5f+2oeI4Ol6mZyX5jvFeL5rL38osJzcg0ZDQFyMf8iJ01AXitjtmU7GCRig6ZzgtrG9iFUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0aJW+9/SdbrGrGZ8ytJo7ivT6FRosF0aObvHg/VOmM=;
 b=qZz0TUi9wNAjv0IK0Bn9TDw6ZyfyQuV2hgIHmnPsFYeKR6THj7SVh2HBezQ6RoSP18bmeldVoDPXkIqjeZbbx+EG8NrIBATqMmcu4NAgs5IOdPdEBvcF8rAm1lGSM0BZZ04GUarHjz7zgeTEgp6ipwRcM4dVK8bUpuvpk81u8Lc=
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by AM9PR04MB8397.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Thu, 4 Jul
 2024 11:41:22 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 11:41:22 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "quic_obabatun@quicinc.com" <quic_obabatun@quicinc.com>
CC: Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Jason Liu <jason.hui.liu@nxp.com>,
	"dongas86@gmail.com" <dongas86@gmail.com>, "saravanak@google.com"
	<saravanak@google.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: CMA Regression issue - [PATCH v2] of: reserved_mem: Restructure code
 to call reserved mem init functions earlier
Thread-Topic: CMA Regression issue - [PATCH v2] of: reserved_mem: Restructure
 code to call reserved mem init functions earlier
Thread-Index: AdrN5nCIgybrvPp3QT6OipXmVetsBw==
Date: Thu, 4 Jul 2024 11:41:22 +0000
Message-ID:
 <DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|AM9PR04MB8397:EE_
x-ms-office365-filtering-correlation-id: 112a7fef-193c-4761-5204-08dc9c1e3a7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yUjN6cjT4ohlKsCKVnPlwMf0gbrrQHmocc5JIn9fMIOSO+gUqYbmJtDfy0ot?=
 =?us-ascii?Q?/NwQaGvS25PRM5gL2sk19MMLz0akufYKeMVBObbUoG0AC7ajAZWLpEJQNepo?=
 =?us-ascii?Q?il8dmdTWeZpg56ctCqbsRknfp/uYaPTDCky3DpAgXaJSiVcZCjufHmHGTBg9?=
 =?us-ascii?Q?KE60PnrjS+QmuywzMzHyErZwJskIUgJgwQwBTB/PhpLkKO0Jgyxb6YHlELDf?=
 =?us-ascii?Q?NcF1aj29pKvjShuN5chdIsKnzLLFe0wLko1l1xFYQqIVLOUCJLi6EfP0OeNa?=
 =?us-ascii?Q?//qHjImNLMRqJhdA7L+w4ejc9k4ZuZzR9dPenF/lfXfTuhws+rs9PqWjFVR1?=
 =?us-ascii?Q?ULWbdbTM0I0CrnugID8tnDH44rCVpmD2CuVd/Is+z7vuFfoPRt2PpnASRZSj?=
 =?us-ascii?Q?yxUIiI9WslsT5QUxfV613BtQxgUQZ4lp7hXevrjgKhnDekjd6pA4Qg2mbU4D?=
 =?us-ascii?Q?SMWQTj4C3LMi0Yq4f0EPngQ20S/t9jSphRxpiluZMJeTjQUnOfOJyl9iRaj/?=
 =?us-ascii?Q?SjCz/hAOx1vHvPtGoscCUW7nxcGu7dxrPYrR3DcdPWDL8JeQTwnv5N9KHyub?=
 =?us-ascii?Q?e8rg/4m/qcJk1GCLeXQmhOJQsWK2DpkLKSzb/lv5rYeSbdZwQAd8DD8mH3gH?=
 =?us-ascii?Q?0++3bvHwqPeD6ev2JgG8MacUgr4bg3JJqzOSPtp/7bzicfQ44xscUXiv42cm?=
 =?us-ascii?Q?uT5chvyRPruFimpVwzZ7g4N6o0qUMM5DBkveHPfGVRCJLJ3cdck9uussLaPU?=
 =?us-ascii?Q?wsypm+UoaNiSS9CQK30rSxZZJQvRQX/6E6ZMbB3vd2WmQc04mcTSaxNGdPfU?=
 =?us-ascii?Q?AGD42LoWlAwo8eEjj7i2A2HDt17W0QnZg/UeLPw/fkwVeItRPcgfbotWnxr3?=
 =?us-ascii?Q?XaJ1CcZxhy/29RFbQvNePt+hnjzBxR9Oqe8QCkU1E3Ak6wc9ggySiBu/jjLi?=
 =?us-ascii?Q?nUWnHlAbEJNZ/0K6jJuQyU3tlPUCyhCZfPZaHCtQtPwPLV/6tvK5h4IYK62b?=
 =?us-ascii?Q?T0NLbu4LPTA0qzcfL+T2OiEuJTrT/marixeTi8e3Y6OvG10WvWm0T5mUBT+n?=
 =?us-ascii?Q?9n6/V6xL9s6xzVK34lRal+pt11sbTRZVP7oK4+UNPc8OYmUNenBcPp6vMfTV?=
 =?us-ascii?Q?rWO2AdkHZY66kP/bSNb9xTOCEkwdU2J8ryK76kyd0bzZlXMQ0YzCaMF7MZ3C?=
 =?us-ascii?Q?Rlwh2GnSdyzv6rllO4lhq11tgxM6y3mIL9oN5ooXsR4hTL5H3a3v0mcDs3a7?=
 =?us-ascii?Q?xVPWNxH2TI1/n7DiXOopfz7PcoitCXovUct/sVppnkNIvZ7fGEfdFk5QN37u?=
 =?us-ascii?Q?aYQKDKkH9lcu2qb5Y0eQYUAOiqAc9oTfpTy5AD172fn2KKPLQKRgUQct4OOq?=
 =?us-ascii?Q?F1wICko=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+4RLQvkibjaj8/XWB0TGYeQWBZFw+6sq7ddystKv0snCOwZjSe6/bp4cjQgd?=
 =?us-ascii?Q?uJck+LHY+DCZm59K1KMYm8b/8B7HuxHPAuwH5xKuUk4ybsoeGTv10th1vAJG?=
 =?us-ascii?Q?RZVmwcz5DwRm3zcYrxmd6G54ZZWu55DX/JCoFBbVcOQBnYNQqLFRKUptkaNx?=
 =?us-ascii?Q?2mnbCnIfD/vJbObTZtEgyKavN5Kh+bzTxXwqvHrR64vTNLLoPUXALvQPP6R5?=
 =?us-ascii?Q?vuUOKWXeXGaqelbzj/vp0uWpbq7pN9tifXd3pehZ5rFFUhzrnjCIPj6CiDQX?=
 =?us-ascii?Q?T/2B/8TSQEgBqw6C6jf/d2kldox1DAhM5FsIHtC56PDSlya1tU1AFV6n+5z5?=
 =?us-ascii?Q?2F107hi/caM0UR5Cd6U78/PTTYPo6C8OS7d3aStI8DXdam4CLxTrm/Zac+dP?=
 =?us-ascii?Q?OwPh1oLm1Eh5/L1fzkF+6MS0p/lpj4Mnc3DMsrnTVBdKP3FAtelkPLTJqs3A?=
 =?us-ascii?Q?vuWrQ3WGpnr5iP1mm5Tn9lAJFVuW6UNsvKW7z66qnEkuSA0HxN3oVWzOWrBP?=
 =?us-ascii?Q?WQLlAu/AsfSrl2yUc227Rs2rT396hGIS8C9+koeGSnTWe/KX0AbXl12p4Dhy?=
 =?us-ascii?Q?5+8pgdpfnduOKYR30rBULQSsjaFB9x1cnbiqJIYU76JhkJVz2nTp0qwB7Cjr?=
 =?us-ascii?Q?2iMHSAPXHtfIj5Me3SmaNzXqDRN8wDDctynG/YCuGqQSS6HardTs7cX+IA7R?=
 =?us-ascii?Q?AULG2NnyhIppFSuGD1Fe8/7pus2lO4jEhIsEfQPirg/x/l7rFtq81LziipzB?=
 =?us-ascii?Q?wVdCAzcbzSmGRY6cigOZMfDHZmpD4wCamDg4OPzb595QFY/61aoCGK5ITHO0?=
 =?us-ascii?Q?iim6c7z6Vk5+2m8wGQH78ZzjGeoRy+Dov8ioKexLrGBXwVRnvKY02rHfG9Dm?=
 =?us-ascii?Q?m3ZVI3naasimwDXOwxN8nb+Er2v9n7LZBj7NFYUZGmaXvS4b2lZKd+npflOr?=
 =?us-ascii?Q?xhshrnxCsUsA/W/tdNd4QShh1Io100YcQxOQiryj3ib0Stmp7NuAculyiOVQ?=
 =?us-ascii?Q?2q+Etp9nBmC9eEjba1GGFFbzq0FIuTDNTl+4sPPVqUbBjEjjsJcA5FhV2Bt5?=
 =?us-ascii?Q?y3RShOzNIKtpZdKCQQMuoO+u0jPFYwrUA0uLGIpiMtey+NA275kDVw/MjsJB?=
 =?us-ascii?Q?bWoAFprwnYorquS7XpyCB6IJevy3sxJawdfyUlHaaYKCy7QgiY1Cf49VxnG2?=
 =?us-ascii?Q?XhZXQZWusFSPmBsGDUrqRZkuvqiZUs3aZE5CJ/XP8eX0D7iXfShuTxiVsRdk?=
 =?us-ascii?Q?BVQjIr3Qayi62HlEnMyl+Ve4EdJYCHe9S+fWtBUaDf2TzxoIM3wcwR1v3Mv1?=
 =?us-ascii?Q?q1p5P60ZMyFut34UUVN/p50aFkVKxNfTW1s8PkovHIK9MLpnAEiZbhk8bxu6?=
 =?us-ascii?Q?k8SxUK5919SGBu2J+1JbYnVmkXsizaGQHpe51BSXiPQvZ+R2+RdLOGPNvDNl?=
 =?us-ascii?Q?Va3p1uBZnMt1YJ0VHDWsOHGoQXwjrF1TF608c0w9mmBagG+QhhkCXJBWR+Wt?=
 =?us-ascii?Q?t32LmS5LvbKi3jzqoaj/tDFJDrYDSUwA3vR9XNlBCDM0431W8ORK07yaRlGs?=
 =?us-ascii?Q?q3OuwPmdgAGCpPLESKhSn7Si+tSLnkamC0jq2+1i?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112a7fef-193c-4761-5204-08dc9c1e3a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 11:41:22.3542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pweSKVdYuXIjp0MdI8iOtArQpCHgtl5l7PrbToB+FLUxb1yC3BzMwAeP+YgoqXWRy4d3kV6WLvHfWABitrWKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8397

Hi Oreoluwa,

We observed a CMA regression issue on MX8MN that the CMA region failed to b=
e
setup by rmem_cma_setup() since the following patch:
f2a524d9ef5b ("of: reserved_mem: Restructure code to call reserved mem init=
 functions earlier") [1]
And the CMA node was incorrect parsed (e.g. non-reuseable) due to NULL node=
 pointer.
Below is one line boot log tested with the tag next-20240703 of linux-next =
tree.
OF: reserved mem: 0x0000000058000000..0x000000007fffffff (655360 KiB) map n=
on-reusable linux,cma
NOTE: actually there is a reusable property:
linux,cma {
        compatible =3D "shared-dma-pool";
        reusable;
        size =3D <0 0x28000000>;
        alloc-ranges =3D <0 0x40000000 0 0x40000000>;
        linux,cma-default;
};

The root cause was that the CMA region was initialized at a very early stag=
e
since above commit in question.
The call flow became:
early_init_fdt_scan_reserved_mem()->fdt_scan_reserved_mem()->
__reserved_mem_alloc_size()->of_reserved_mem_save_node(NULL, xxx)->
of_init_reserved_mem_node()->__reserved_mem_init_node().

The rmem->dev_node is still NULL when calling __reserved_mem_init_node()
which fails to call the rmem_cma_setup().

Please let me know if there's already a fix patch.

[1] https://lore.kernel.org/all/20240620001027.2326275-1-quic_obabatun@quic=
inc.com/

Regards
Aisheng

