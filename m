Return-Path: <linux-kernel+bounces-417675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4B19D57D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DA7B25D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB861607AB;
	Fri, 22 Nov 2024 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WgCELD3P"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E11805E;
	Fri, 22 Nov 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240211; cv=fail; b=FdEaWY7KpnzTdxcTPSDg591OnAIRc/q2a8hw+BPS0+pQuthHNc4wgaIclMA+nM3O4wU9Uc4hE1Ly8HKAZ0SKZRvM2iae29RqABcirkkwwzAViHwxnIor4dtfR1sEAazN/ReM5VG0Bb+VoDsuAfE6jDXhpzszb9aSHXAVjxm4R3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240211; c=relaxed/simple;
	bh=v4cjerPyg16379IXeBUC25CaMYv4pMhjRwns0I0MqZM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=id6TIjWBR8AaCeFxkJgRTpdJEkRJPfUP4CddLYNw82apNQ8itMBik/laQaNX21vX0mnbjY//mLq3y4LuKgD/SX4SuLpc6yMoTfxib4/dcMXRZpfxapbSu4tcmg9uzarkYRQ204GScghP0j4rD9SXES+V8vgJCzkqgTJX1I8vMuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WgCELD3P; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDs5DH5csgMzbX8251aUKHI77cR9NGoMljOpJE1+GEkemaKC3+C9uDJvPuxdZRvxEsbrvLLizVw2P+JxHleFP+wK58ggAgF/2OgS/lq6iQ+RPu18jlzGejzdjhuCtREfy4UUBgsJ3nNaeksT1ot4ik5xOZf2+KvgzFLpeLF/FZ9MUuxTKroRwz4ZJgMlA6yebzDhhyVdtifS8pIDbPA0dx7twhdrKmYh3vDH5w1WtVoR2IbYF9PKs0dzqZ26R0uKaS2ndJbSmYvu0Tbd/TaEyaTz6Ge/jsCR5dvn7TGTrxbaS3Ux5fNjIbAPxOa6FbTsRKBNYHX1eg+nCq/DaTg4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZlavkXCuKy+PWF5aoTgAP7xsYSCxheL2MhSFHgxDss=;
 b=FY2kKJZShu3D25ATvpoAsCPREJb+0hh24l47tlM+U1OO8T+bfM2Dp/fIGcJpMNbkGDa3nQlULIiWIi37lK6V/UOtMHkKxkInT69YI6n5hSLHyCbwl/Stvwr3Aumi5Hzco4aVV2ptL/Vzx3VqM+zb0agNmsjeq999d2ruSBrm3gjzrMI2N3lEdhyyxRKUHQ61joQuagUPFZ1eAgI8pyMRSVFT0HsJhzxZlaijAl6CIxh9wo/B4KJYEkxeSKd8B3WSAGDeVEWbmW9SNeywdtXkvFecy2YSVeB7Oym/tJ2hlpP+psxWjG4EUP/SR7sz+c3ZtnFw6rirnOeVwCjwaTRQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZlavkXCuKy+PWF5aoTgAP7xsYSCxheL2MhSFHgxDss=;
 b=WgCELD3PfS201Zvt5KYtJt4cryjhXetoJVPPR8qnIFvoMXUAAyexYx6R1li31uhl5OGFwkRqiquQ3Pis6J6hIvuxhXuC68IWu3/KsJeFVL6/4iX8up+MDEwcExaOVK2tyVE7VCk0GzisXZ1qcw1DbJX2OYyHv2ljFEqf8K1VC2/7YnMN1dGldlfhSmHgnnlRf5bHqsaq0dcfVHmrGUUKT0bTu/U2ZPf+XfmjrNamAQXRD1MQkj4Gpustbh1AxiXZupu8MemdAEFLlG8BTQtj5h4OGkND+jMXw8VeeZqtAplpXbc/FDRlpRvg/aL40U2SSDyUrYXdjET8d0JrCpq1tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AS8PR04MB8929.eurprd04.prod.outlook.com (2603:10a6:20b:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 01:50:05 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8158.013; Fri, 22 Nov 2024
 01:50:05 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: fsl: change IFACE_PCM to IFACE_MIXER
Date: Fri, 22 Nov 2024 09:49:39 +0800
Message-Id: <20241122014941.503789-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AS8PR04MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 5595aa80-32e7-45f7-82bb-08dd0a97fcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OemJ3Not/8VHEblux29e4d5WTtMnnSvaRvzE4LsJJ26v2txUfPfis2Z6MHav?=
 =?us-ascii?Q?xcR/GkgGmVOB0iHImEiJdPzXQkMRyZvakKk3Jx5JfMwPZLZQJ2t1zIsJCHz0?=
 =?us-ascii?Q?cKo/JIBkh6dhON9gvkBl1f56ockaqv5CLmDRKHw+iNexC0W07PktmVWzkRJD?=
 =?us-ascii?Q?Zbe8ybFhnsFA9H6WZD3kGK/PJ77UeSFcBHqe+ra6PtqMzpKlrybh03fdvcC0?=
 =?us-ascii?Q?dXRPqTouPJGR4Wf5q6othS6Ui5mAGix1BwajTNF/x3Eoz4JL5HWeSdtPBM5G?=
 =?us-ascii?Q?wRRlJkEsxWd9kQqjSteyB1zzJ/s2PW+iT7o0bM+l7OUL09uaZWWas5nWfx7v?=
 =?us-ascii?Q?HMuPzOKh7yvowQ8w9F7G1xzYKbvNdPTnwOqGP96ZHOHPAOpCoKx1KGLYD9mf?=
 =?us-ascii?Q?nwVckynaVYyYq9c9iWP47TkhwWxeogw/bpQIo++r5RdCB9tCEHXhMtqSgUnN?=
 =?us-ascii?Q?exDm9c29Ii34vURFywesNeXn59jkoza9BXDiZkkVb6rLBQHyoiftdb9y52Tg?=
 =?us-ascii?Q?SLrzt799yNEIB876B/SjNjY5aT0LdSIsOWy8S3eoXi02ogKK8o7+IlmjYgPo?=
 =?us-ascii?Q?xW2qxQ75J8Wm644XgBxoehNvMDB2eXfdKFJwkuVOks3hdcKwFREQz/h7vHyl?=
 =?us-ascii?Q?M0YnpAdATfL8zYaXFf5dhuaxlFd94vALBQHCNvz4DgBPDQwNH+KiVm5Cnd4X?=
 =?us-ascii?Q?m10uSAm25uMEewGodjznv2mQhbBgpnEDMteXer3v2yhr0ZkBujaN3C6MWOfm?=
 =?us-ascii?Q?nuhLIC4TSId5JHWVD7oEoi00EesRgRIARmWRtTcd4m3hlTqexrOqPpnhaqp8?=
 =?us-ascii?Q?FSRRIVuhQwd0sIwJG6rgTZZOXMPMV3M5kLCgExJISYfqgrJzFIVI2tyEkUhA?=
 =?us-ascii?Q?xyLRmY/Ze+Qa0nQpYw3orccDrn7PtwwKPmJLHv4qtnzIJE/9wllDraYLXXVz?=
 =?us-ascii?Q?EpbeBagzMUsze38Hs2BcXx8yc0LcirS2765lp3LCkh4nK7rDPfbbi5TX4QFS?=
 =?us-ascii?Q?l1HOQ2lqgUSyKa8K9ZrcGd1rUPQStLdpzeJlSfzaxKMBs0pjCXjMgak0LXAi?=
 =?us-ascii?Q?X+RCq3wQXdg9rvh8if/yqMHxrUaHbqGAnJmc95HlKrrdsTIUCjyIPlbSR5go?=
 =?us-ascii?Q?yRPJO6uy2OTqjd7X3OmenTIUZPeCplhK+Z93N6OIKgnyuqUK1XZX36cFbHwZ?=
 =?us-ascii?Q?kdRa/mgSyEBb2Jx2HhlFptAR3HlRWS8D9CKD/Mvs49QvOQpEe1bfKHBlGALd?=
 =?us-ascii?Q?3tcqfRVdTva6vGpJylR2nAvTn/jRDwvm6jYfYrv22izOqTQxJdufoPVcr4Nt?=
 =?us-ascii?Q?k10D3zLuOVIlvAuYnbJ8/MAm2Retmfx1rzPO+UMMWwlbOvJqGLwCJbPj73b9?=
 =?us-ascii?Q?6X07uh/sdzL2BCIk1IwDN2krK/Mb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6fG3nPc8YraFRUZPdDdW6snzZ/GWN0c1N/Lz4DsOW7UocLDZ90ZQokwqWSLX?=
 =?us-ascii?Q?vwANzCdACglKjwe2lRpP7yFdQ/oQJAhWaKURroBD9MAJegldAoV5lVElXSJx?=
 =?us-ascii?Q?DwlkQXm1WXEcjWMaQuaJaxSVzLsvSiye4fEWgbS98dH/38RLYvk8e15kxUsy?=
 =?us-ascii?Q?9TqRexyqtD3V5H/gvwaSoAeUlK+0nJtMHz6hyiqCWqqa/TeakWcwk3cKFI6E?=
 =?us-ascii?Q?CWHz+hxB+T99iuB+B/DNj9EmO0KFUtQ0WnA4cdyzdjrEMDMMq2jxP3QfeOMR?=
 =?us-ascii?Q?j2yaINhif3vejyX8/ft7z2MZxbZHnszFzmLyVm5d0zj93qVrNbuf0wUWMuyU?=
 =?us-ascii?Q?gp6GGdP7yWTTlHrrgcvbnqMe04/LsZ8s/h0/hP4KVNwe0tVUdo5efFtYV5hU?=
 =?us-ascii?Q?nrL9WZ1Bfmdba7MrIbXpZKihtxXSTzcMn/XWao8qg4I1VDwdTIXQvBI08ZNY?=
 =?us-ascii?Q?M0A1lwVw0BsYlWgbmGLQfLctjPthoGJzdRbmukfXZ3RhexlAkbpfJMApk6/y?=
 =?us-ascii?Q?ktlZKt/6X07DrO6mPS5A28KqFV+dK+m2Yv2ex7Oai1cxyIitTFi8IrKW18HQ?=
 =?us-ascii?Q?5hn916F4SRM/WYC78KmV9mcB04EuQ4AIKBPCJEnCN29l9Bx9tnFSAw8+yp1Q?=
 =?us-ascii?Q?xM7pTT0G6JQmg2QwPltWc1Y50bxG4exiU51bDj9ynMP3UgWGx/mqaqeMw6lP?=
 =?us-ascii?Q?bkB3rGvpqWRxhLgjy3U0ypTFS/VfsN9HZtArvUrrExGnIL+bmHiXoEHXAWBL?=
 =?us-ascii?Q?fOUzz0Es5cuSJ0yDGafo4v+Nr9qTOZahvAtzEeM6hbqG+VIzoxiFDeV1tE4Q?=
 =?us-ascii?Q?vAq+1JB9pYoqY3L4SvX4sxA0SWpdXISWHTolfqBPHQ/nPCtfEHIB5HrmPFQC?=
 =?us-ascii?Q?t/Y/YCOlZdMQaoyuJjEbpaniSZ/m2oS15us0fUYuRLO8iRs41ihhyBAI0jUV?=
 =?us-ascii?Q?Qp7+IS03GL5K++S0uSN8F8mVVkyRWqCbk5IucBcv86jLwDo9DPVxgTzGezr+?=
 =?us-ascii?Q?/iuvN5IbCGA4t7HRXh1OnP2/TRms1seC2jwANkecvjRWjywbbzaJEdlhUiOK?=
 =?us-ascii?Q?k7CV2R/BFLDCgaBmrW2WgManuq8V3kKP2DnClfEI5/8F7o/EgsuSELdVuExJ?=
 =?us-ascii?Q?/jJOs1CuQd4FExv1482MBsEGFEjzVTA5LSyalTtvpmFKAcBops1zdI6AA7Xq?=
 =?us-ascii?Q?eyde8a1a/kgDWo/VuKnDRHjr3G+o7I9NsFxfdVb22+g2Yz2h+rqJDV9kt0i4?=
 =?us-ascii?Q?+gNAMG5TvIlFSLw/TfrOQKb2KrJA2vBEyw872pEjb0jy2BDElJDZjJcHFnZD?=
 =?us-ascii?Q?mj7wocM4u1rx5uSYORfhp7e6a7uM4bNgDtigwQ5ReffdjhLPFlHI4t9XTR4c?=
 =?us-ascii?Q?kbmYnTm1FFPXoMp7bjF4ojFdIZD2p8qPYHqfS8hJ7It79Q+lNi9hAqBWZGs2?=
 =?us-ascii?Q?L0NRTd+ZB1cJ/WCUbrXzPRiSYjNmpOkN+swxCGiS/Q8u0A+b96+qbT3imbgS?=
 =?us-ascii?Q?4L8xmKW4pycleYgq2No4UNiDIhZ8BVqewN9EILhw4XB9eZ0jWOv1t9fFcnPO?=
 =?us-ascii?Q?FdBp6lnKqP28vk48r7yn16Klz2vSrWgvoiaYj3HQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5595aa80-32e7-45f7-82bb-08dd0a97fcc4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:50:05.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GO8wENR18cCylJ8jHmMp//rNAvgGVjP6wHORu+YELEUCN6iElljjyjfK6/+dJc2u6RYI2Dbc5fQo/YoDQq3/GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8929

As the snd_soc_card_get_kcontrol() is updated to use
snd_ctl_find_id_mixer() in
commit 897cc72b0837 ("ASoC: soc-card: Use
snd_ctl_find_id_mixer() instead of open-coding")
which make the iface fix to be IFACE_MIXER.

if driver need to use snd_soc_card_get_kcontrol()
the id.type need to be IFACE_MIXER.

Shengjiu Wang (2):
  ASoC: fsl_xcvr: change IFACE_PCM to IFACE_MIXER
  ASoC: fsl_spdif: change IFACE_PCM to IFACE_MIXER

 sound/soc/fsl/fsl_spdif.c | 2 +-
 sound/soc/fsl/fsl_xcvr.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


