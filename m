Return-Path: <linux-kernel+bounces-217994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7E290B781
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED3A1F2242A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736816A93D;
	Mon, 17 Jun 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LzijGhWk"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435D1684BF;
	Mon, 17 Jun 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644198; cv=fail; b=fEA/Z6z0x/1kdsBVbpz2OGGE/ri8SJTwwyf5CUvyUd/scY+kx3TB3jewyu/YjvxEg+ez7UWG6o1f4fxtscrClHskGPobn5v+ObBozFfOW5oeeX741jjcFeZBCDnnap9s3trKlcQDdcsADhSseSB8LDx8IBfO1O1ZPl4n9UvUZfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644198; c=relaxed/simple;
	bh=rjOrEX/dWdOjbJMNHG5rqVmJ0ZKwhpvKSDIsorEizxo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BZGvpyu5pak7HZyAF1EiJ7Ea6lzll3g2HAboeVZPdLeFcmeLS8t7aMq7wxntmOQVo4DVpq2LR6EHlWYH9ZqrL8MebxrYXGtToW+QYxG2V3u9cEjFsgl8IjtwRrQ+HPY/9BGbu+ZtcApaen4vmX75pYiGgGkt6my46IRvvZwHLPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LzijGhWk; arc=fail smtp.client-ip=40.107.14.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOl4FbQtZhVfUfmZNL6rptdNXrsp6PXWwpladspfTzCWIGEHQ5Tc6sihKfA/wQqY9KKsQ0VVw8o0K+nsLY2q2oBkQdHz88sF38w59PCrPqe5xqsxAV7XqCSA6NFCrq4rLPsuRI6g/UoJwxYiwlpKDNAzlNika8Svqo+3GE5CAc7jcVFt2J17GCpALMIIVA2A8M1mNgSSou9d99kvmLuLpKSYG3rKwlYP2386+xK3xkZNmImdWYuzKTe6UaCSRkZbrYGyjYKuXaPlkQDcDBiXJ+bPaZ46VWbgfDEAcaUnz/AfvkK5/5/1MfPxAVntt2EuUYnN5w7B+IDrAqVVoD9Qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32drMUEQ09/a+iNqgvk5r3b/8ECzgsVcW4Nad/5RJFQ=;
 b=SNri/l2nUdi0lBPFv0d3JhYwbmRoD33apmnTbM9jQLMK8KnFozc4l9XFmyocphzsZv5mMJP+VHYfbHZQgwPhCnIfHuqFbt4m5zCocbwPx6YIEjlByRbUXLJjWP1vzSKYomJ7gWwLxYj0J8CPtk8b1VGMK1S/0rj6zaCnfkuzNaGkrW64Fw2Etgexi/MDgbI0vFkaWcS2RUSd7amv26eam6y6ErjtLgRpMoLXiBGY9Mu1yO63qi8a5oyxNUaOQHCPJESRWn+XCdzfFpjv0Ik+JgmPfptn8l+QtWApjoTG1r9Y+nzQeFI4r0uK1a7MiNxSorYza+b7gnCZtFjJJkuHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32drMUEQ09/a+iNqgvk5r3b/8ECzgsVcW4Nad/5RJFQ=;
 b=LzijGhWkqEAWMlcbOCFU6dMmMaOo3TwJ3XBgFNctr1kyj/8OXC5c95rOBazu1RhEDTlf5gpxRCB17N0KaSDhghHAgbvXOl5JjnukX6Rc8HcUWFjwm66l7sq78IV9p/R9ppNFcAOg4wTXLlH3sN1oFHjFISXLEi/LV76jzaC2I+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7480.eurprd04.prod.outlook.com (2603:10a6:10:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 17:09:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 17:09:50 +0000
From: Frank Li <Frank.Li@nxp.com>
To: robh@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	laurentiu.tudor@nxp.com,
	linux-kernel@vger.kernel.org,
	stuyoder@gmail.com
Subject: [PATCH v2 1/1] dt-bindings: misc: fsl,qoriq-mc: convert to yaml format
Date: Mon, 17 Jun 2024 13:09:34 -0400
Message-Id: <20240617170934.813321-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fa6062-84f9-4563-8f3c-08dc8ef04c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sTPYjU1rthPDvef/BwyqODplpCDSZkMN+qsWLVosEYkehid+uyuqdF7OETM2?=
 =?us-ascii?Q?lks/MHJm5al3U9QVHOX6hP7iDDzgPWccWDcNGRAskhdfrIiyoGR1eaI+u+No?=
 =?us-ascii?Q?4CohJxAFHa7cWP/aHVDN+mcqG4ID+wTnXSflThpaR7BUR6tDOH5dWxSGwXmY?=
 =?us-ascii?Q?bIij9KWByV2nhLIflWljG3Oob/3z7vtNik6+NkCxNpEtAyB7md0CgzwGYvO0?=
 =?us-ascii?Q?UsTUBps2RdNF0w1RkHV/I/1txS4MtEjOyUCyyQzpvDs6v3KAWnzCWJFLwJjj?=
 =?us-ascii?Q?lm0uFZV1Y9jQKmjJwfkulaKrpn1yTxWg5HVKXQsIDkn16r1fSBU/eJGbRwsE?=
 =?us-ascii?Q?WwzPICpVRo6glAyizn+8wfgrF6CFJnhKDVZwSOEf0hOevI6vVMyA1/214ePt?=
 =?us-ascii?Q?syFk0ui6gAqKq4sTrcoebktKGgpdfEKI0WfyNyXsf9XPQIYQNGDUK/T7buLR?=
 =?us-ascii?Q?pVIgon+u0hAz5jhIYQFAst2INO6pv/Dgq6ALGMcKdb3arRmxS5nxEaO02ArD?=
 =?us-ascii?Q?OCfoKW1L3xGfvn+2CBUFWFo9fL5HNxLLGSqAEtr+RCa8vd3//eAMfnJrhAwK?=
 =?us-ascii?Q?a6y5KTDiu4JNBiXFgnwQsZ7O9bFcLc77tE/I2JjBnqxN9Wc56XSWnXi59N/v?=
 =?us-ascii?Q?fdFCyS54jr18Q1H/pgO9mMrM38CnCaWFOIcwdIi/dhY8H+VR41KVkNPRlx7h?=
 =?us-ascii?Q?/ZR80vGl9YAuw2Cryr/dSnW2oOjXO1QkKJKMzlpObgdrPMD2vyiHM1VegMVJ?=
 =?us-ascii?Q?Yimh3kMjXbiR4/bfFwFWf4vsG242vEkFBTPwo0jSTp6rfyb8NaC0KuBg3dTp?=
 =?us-ascii?Q?IFQnkiiHQPogBPo7Cn7MJPEL1OxB0/75C5kXOYIKbw+AKPa+j62WOVGT/87J?=
 =?us-ascii?Q?gF8hVNTr5lRz8gEjwgOrDkV0GH3SAXgr16X6WGtyNxnlhzmrQOwXU67Xgwbe?=
 =?us-ascii?Q?sJd7eetL34XseMNSmzzJV1U2xtiK9GSnNTSr5glJ/W+4JlXN1R6UBJ5SzfWo?=
 =?us-ascii?Q?H6xqblLREJr46YdVNS3wrjEG6sIycfv+8ERgV70Y0lhFEaGJKV7neyacujKh?=
 =?us-ascii?Q?IPMKT0X55Dzqh2aryv7P5hgTZ1QqcTvdv53u4RHsvG3fPkwQ9YCtwNUd6lxr?=
 =?us-ascii?Q?is5R5LGiiU/CfQjTOWPyeXMcAqLhCC/Tj8+gDeWrs2BGjspZIjK3DvTTHEmC?=
 =?us-ascii?Q?c2InSe1JZsvyjk7eODhSM6WWjCIrBYLwrGLGogy/oNcKkA8mj2Mc7XCJpA9H?=
 =?us-ascii?Q?THjCnpobmBUtOSCAdIfE5yj+6iz/W/x9eCe4qZ4GNgWQW3haethJn71mQDQB?=
 =?us-ascii?Q?XJLU8Crzl52pNtFoMWxmtu8d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kqGH8VZp4POj++aaeTRxeZuYOR8r7fdNMnEDh/aohjTJaimilD1P7WT//id/?=
 =?us-ascii?Q?u1DU/9BBPMx8L4ezYEbGcpFq1ISR6gXgfcvAngWDdD1yR8ZvDbuHhwE1EVSL?=
 =?us-ascii?Q?MMco6fXlO/QEsJRkH9Kxfl14RdDRtc8Nz4tBsXgDX3JEsZkIHwhVAEjJqLcd?=
 =?us-ascii?Q?cBDyZJEeXO0S0JP1RbsnV+V2vdpm5RO1XEuUQSXome/wv29TuC1mjnxYNfBX?=
 =?us-ascii?Q?6XrcyqusVzBn3//Vwe3rowHGCuqzxi2hUfqeRHSQH87DKC7vwhe+PODRqKKq?=
 =?us-ascii?Q?UArZ57qBxRQQiOqZMhtdTHxQmiZbTpFWx88q0serZEUMxylDGBx2JLx9qjkL?=
 =?us-ascii?Q?xn6hsah8c5yeeZVw/Jems+6ZhkfYmIQfnjJTEdgxRuKQdh/q+PY+PPynXAVz?=
 =?us-ascii?Q?dJGKMgwFb1K94U36Yjl8W9XfdH9/q1mbN1uBsuIU2gbhZ9y77Laj2viMa07h?=
 =?us-ascii?Q?gGko/Se5nPYVvlz5nGfp+Zygk50qjvSwv49/Usyrk5186ECxvvKqmN7mxCq+?=
 =?us-ascii?Q?eeh/WFIhec2+iTqahOTyhw+BuhLHKXyfWwlA3Cu7XA467geNrzhlXFur4e/M?=
 =?us-ascii?Q?+cO30ayFmxZnsvKByCSrUaO/LJMeVfAoB9Ie/4X8xz+5FACuIWzzPKCVxA0l?=
 =?us-ascii?Q?PrfhVWUidLuyHQXqCoaMLqN7LKJesvJj5QYePQvTdK9XJoqrxRugEb7vPoGe?=
 =?us-ascii?Q?bhZvY3ojYPDkcWAy1Zf/5/V/jssUeBuWhd2+lrVD7s6Tao1WcLC2zq+UR8Hu?=
 =?us-ascii?Q?vpIG1+AwtloniX18/lIMdPudw8WLQ8Cn/rz+kbsZqtgc8E/loixqxzipkNGK?=
 =?us-ascii?Q?nFAMWE1Ue8rY8chXkjzkoR5YDIckvvSRVOC46lXHzu8gVJrW/BDheyvS1MuU?=
 =?us-ascii?Q?dKretboI0fNoM0jnVKUSxtFiRE9GHuDfRbqoEJnFhrJ7+O59MalL0POAWEFL?=
 =?us-ascii?Q?QO8zxFQkA0tCA423uVTjCWGl25zYU0I5j7DM/NWy8Poa73f1iTumUYdtVRhI?=
 =?us-ascii?Q?6ooP/QEuQJAXf8FD1Iwupp6SsVn5DjY5+L7E+key/IRQmgp4ahOUrXoTg6f3?=
 =?us-ascii?Q?260lqBMS2VonabzEtvxivaM7HKvVWi8jRAoC0gr7IxfXn4FvJWw3Bz/7oMxx?=
 =?us-ascii?Q?M+mSNjF5bXNtMW8sY2SNWkk2+bjZRB7OLH9ZUIplbqITir6j2x6SXK9ITz6P?=
 =?us-ascii?Q?3AI1Oii1FRnueYMRt4/blMzXh+gpX4ki8RRLQaDEYtb1Qhaj2dSBAdCgNrgy?=
 =?us-ascii?Q?HF6zsY5qIMqmCNkd5zcNjuvastjBZxlop0kiTVUO6XSk6oGdjH6gl9scg96/?=
 =?us-ascii?Q?UZEiSeSoPP8QrfNljQo9LlhkS4ROYf9mrWud7pXRCSXzzwYyIM80oXQmzmGn?=
 =?us-ascii?Q?pXGJ2CJHwl52jrXt4F08oFNtkd4p1DJ42FCsbhmzwH0zbG4O/hpsiaOonZWE?=
 =?us-ascii?Q?aAxvSidI8oDC/r4qumMFw82FHz3weqNbw1RXhiQt0rzHFbQyMbHVDtPr3lcG?=
 =?us-ascii?Q?McVqVh21clnuqpT2urxEnL51a826H8LkEUU2ZZ7l2k3v0sxO13bvK8XPt/q/?=
 =?us-ascii?Q?sG6muxxSzrmyTXaQT40HMuNwFVJxc6UVkyiBrFrC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fa6062-84f9-4563-8f3c-08dc8ef04c02
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 17:09:50.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bdNfUPSVRY+2lrUF2kdtHDo0L3jgp/QsD8E5NcJ5NFrxCLnbS22x70lBxe3Ryo4ZKY2VF2IHuYwg7ZJ14gN2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7480

Convert fsl,qoriq-mc from txt to yaml format.

Addition changes:
- Child node name allow 'ethernet'.
- Use 32bit address in example.
- Fixed missed ';' in example.
- Allow dma-coherent.
- Remove smmu, its part in example.
- Change child node name as 'ethernet'

Signed-off-by: Frank Li <Frank.Li@nxp.com>

---
Change from v1 to v2
- fixed warning find by make refcheckdocs
- Change child node name as 'ethernet'
- move range after reg in example

Pass dt_binding_check
ake ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,qoriq-mc.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/misc/fsl,qoriq-mc.example.dts
  DTC_CHK Documentation/devicetree/bindings/misc/fsl,qoriq-mc.example.dtb
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 196 ------------------
 .../bindings/misc/fsl,qoriq-mc.yaml           | 187 +++++++++++++++++
 .../ethernet/freescale/dpaa2/overview.rst     |   2 +-
 3 files changed, 188 insertions(+), 197 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
deleted file mode 100644
index 7b486d4985dc7..0000000000000
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ /dev/null
@@ -1,196 +0,0 @@
-* Freescale Management Complex
-
-The Freescale Management Complex (fsl-mc) is a hardware resource
-manager that manages specialized hardware objects used in
-network-oriented packet processing applications. After the fsl-mc
-block is enabled, pools of hardware resources are available, such as
-queues, buffer pools, I/O interfaces. These resources are building
-blocks that can be used to create functional hardware objects/devices
-such as network interfaces, crypto accelerator instances, L2 switches,
-etc.
-
-For an overview of the DPAA2 architecture and fsl-mc bus see:
-Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
-
-As described in the above overview, all DPAA2 objects in a DPRC share the
-same hardware "isolation context" and a 10-bit value called an ICID
-(isolation context id) is expressed by the hardware to identify
-the requester.
-
-The generic 'iommus' property is insufficient to describe the relationship
-between ICIDs and IOMMUs, so an iommu-map property is used to define
-the set of possible ICIDs under a root DPRC and how they map to
-an IOMMU.
-
-For generic IOMMU bindings, see
-Documentation/devicetree/bindings/iommu/iommu.txt.
-
-For arm-smmu binding, see:
-Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
-
-The MSI writes are accompanied by sideband data which is derived from the ICID.
-The msi-map property is used to associate the devices with both the ITS
-controller and the sideband data which accompanies the writes.
-
-For generic MSI bindings, see
-Documentation/devicetree/bindings/interrupt-controller/msi.txt.
-
-For GICv3 and GIC ITS bindings, see:
-Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
-
-Required properties:
-
-    - compatible
-        Value type: <string>
-        Definition: Must be "fsl,qoriq-mc".  A Freescale Management Complex
-                    compatible with this binding must have Block Revision
-                    Registers BRR1 and BRR2 at offset 0x0BF8 and 0x0BFC in
-                    the MC control register region.
-
-    - reg
-        Value type: <prop-encoded-array>
-        Definition: A standard property.  Specifies one or two regions
-                    defining the MC's registers:
-
-                       -the first region is the command portal for the
-                        this machine and must always be present
-
-                       -the second region is the MC control registers. This
-                        region may not be present in some scenarios, such
-                        as in the device tree presented to a virtual machine.
-
-    - ranges
-        Value type: <prop-encoded-array>
-        Definition: A standard property.  Defines the mapping between the child
-                    MC address space and the parent system address space.
-
-                    The MC address space is defined by 3 components:
-                       <region type> <offset hi> <offset lo>
-
-                    Valid values for region type are
-                       0x0 - MC portals
-                       0x1 - QBMAN portals
-
-    - #address-cells
-        Value type: <u32>
-        Definition: Must be 3.  (see definition in 'ranges' property)
-
-    - #size-cells
-        Value type: <u32>
-        Definition: Must be 1.
-
-Sub-nodes:
-
-        The fsl-mc node may optionally have dpmac sub-nodes that describe
-        the relationship between the Ethernet MACs which belong to the MC
-        and the Ethernet PHYs on the system board.
-
-        The dpmac nodes must be under a node named "dpmacs" which contains
-        the following properties:
-
-            - #address-cells
-              Value type: <u32>
-              Definition: Must be present if dpmac sub-nodes are defined and must
-                          have a value of 1.
-
-            - #size-cells
-              Value type: <u32>
-              Definition: Must be present if dpmac sub-nodes are defined and must
-                          have a value of 0.
-
-        These nodes must have the following properties:
-
-            - compatible
-              Value type: <string>
-              Definition: Must be "fsl,qoriq-mc-dpmac".
-
-            - reg
-              Value type: <prop-encoded-array>
-              Definition: Specifies the id of the dpmac.
-
-            - phy-handle
-              Value type: <phandle>
-              Definition: Specifies the phandle to the PHY device node associated
-                          with the this dpmac.
-Optional properties:
-
-- iommu-map: Maps an ICID to an IOMMU and associated iommu-specifier
-  data.
-
-  The property is an arbitrary number of tuples of
-  (icid-base,iommu,iommu-base,length).
-
-  Any ICID i in the interval [icid-base, icid-base + length) is
-  associated with the listed IOMMU, with the iommu-specifier
-  (i - icid-base + iommu-base).
-
-- msi-map: Maps an ICID to a GIC ITS and associated msi-specifier
-  data.
-
-  The property is an arbitrary number of tuples of
-  (icid-base,gic-its,msi-base,length).
-
-  Any ICID in the interval [icid-base, icid-base + length) is
-  associated with the listed GIC ITS, with the msi-specifier
-  (i - icid-base + msi-base).
-
-Deprecated properties:
-
-    - msi-parent
-        Value type: <phandle>
-        Definition: Describes the MSI controller node handling message
-                    interrupts for the MC. When there is no translation
-                    between the ICID and deviceID this property can be used
-                    to describe the MSI controller used by the devices on the
-                    mc-bus.
-                    The use of this property for mc-bus is deprecated. Please
-                    use msi-map.
-
-Example:
-
-        smmu: iommu@5000000 {
-               compatible = "arm,mmu-500";
-               #iommu-cells = <1>;
-               stream-match-mask = <0x7C00>;
-               ...
-        };
-
-        gic: interrupt-controller@6000000 {
-               compatible = "arm,gic-v3";
-               ...
-        }
-        its: gic-its@6020000 {
-               compatible = "arm,gic-v3-its";
-               msi-controller;
-               ...
-        };
-
-        fsl_mc: fsl-mc@80c000000 {
-                compatible = "fsl,qoriq-mc";
-                reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
-                      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-                /* define map for ICIDs 23-64 */
-                iommu-map = <23 &smmu 23 41>;
-                /* define msi map for ICIDs 23-64 */
-                msi-map = <23 &its 23 41>;
-                #address-cells = <3>;
-                #size-cells = <1>;
-
-                /*
-                 * Region type 0x0 - MC portals
-                 * Region type 0x1 - QBMAN portals
-                 */
-                ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
-                          0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
-
-                dpmacs {
-                    #address-cells = <1>;
-                    #size-cells = <0>;
-
-                    dpmac@1 {
-                        compatible = "fsl,qoriq-mc-dpmac";
-                        reg = <1>;
-                        phy-handle = <&mdio0_phy0>;
-                    }
-                }
-        };
diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
new file mode 100644
index 0000000000000..01b00d89a9921
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
@@ -0,0 +1,187 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Management Complex
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The Freescale Management Complex (fsl-mc) is a hardware resource
+  manager that manages specialized hardware objects used in
+  network-oriented packet processing applications. After the fsl-mc
+  block is enabled, pools of hardware resources are available, such as
+  queues, buffer pools, I/O interfaces. These resources are building
+  blocks that can be used to create functional hardware objects/devices
+  such as network interfaces, crypto accelerator instances, L2 switches,
+  etc.
+
+  For an overview of the DPAA2 architecture and fsl-mc bus see:
+  Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
+
+  As described in the above overview, all DPAA2 objects in a DPRC share the
+  same hardware "isolation context" and a 10-bit value called an ICID
+  (isolation context id) is expressed by the hardware to identify
+  the requester.
+
+  The generic 'iommus' property is insufficient to describe the relationship
+  between ICIDs and IOMMUs, so an iommu-map property is used to define
+  the set of possible ICIDs under a root DPRC and how they map to
+  an IOMMU.
+
+  For generic IOMMU bindings, see
+  Documentation/devicetree/bindings/iommu/iommu.txt.
+
+  For arm-smmu binding, see:
+  Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
+
+  The MSI writes are accompanied by sideband data which is derived from the ICID.
+  The msi-map property is used to associate the devices with both the ITS
+  controller and the sideband data which accompanies the writes.
+
+  For generic MSI bindings, see
+  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
+
+  For GICv3 and GIC ITS bindings, see:
+  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
+
+properties:
+  compatible:
+    enum:
+      - fsl,qoriq-mc
+    description:
+      Must be "fsl,qoriq-mc".  A Freescale Management Complex
+      compatible with this binding must have Block Revision
+      Registers BRR1 and BRR2 at offset 0x0BF8 and 0x0BFC in
+      the MC control register region.
+
+  reg:
+    items:
+      - description:
+          the first region is the command portal for the
+          this machine and must always be present
+
+      - description:
+          the second region is the MC control registers. This
+          region may not be present in some scenarios, such
+          as in the device tree presented to a virtual machine.
+
+  ranges:
+    description: |
+      A standard property.  Defines the mapping between the child
+      MC address space and the parent system address space.
+
+      The MC address space is defined by 3 components:
+        <region type> <offset hi> <offset lo>
+
+      Valid values for region type are
+        0x0 - MC portals
+        0x1 - QBMAN portals
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 1
+
+  iommu-map:
+    description: |
+      Maps an ICID to an IOMMU and associated iommu-specifier
+      data.
+
+      The property is an arbitrary number of tuples of
+      (icid-base,iommu,iommu-base,length).
+
+      Any ICID i in the interval [icid-base, icid-base + length) is
+      associated with the listed IOMMU, with the iommu-specifier
+      (i - icid-base + iommu-base).
+
+  msi-map:
+    description: |
+      Maps an ICID to a GIC ITS and associated msi-specifier
+      data.
+
+      The property is an arbitrary number of tuples of
+      (icid-base,gic-its,msi-base,length).
+
+      Any ICID in the interval [icid-base, icid-base + length) is
+      associated with the listed GIC ITS, with the msi-specifier
+      (i - icid-base + msi-base).
+
+  msi-parent:
+    deprecated: true
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Describes the MSI controller node handling message
+      interrupts for the MC. When there is no translation
+      between the ICID and deviceID this property can be used
+      to describe the MSI controller used by the devices on the
+      mc-bus.
+      The use of this property for mc-bus is deprecated. Please
+      use msi-map.
+
+  dma-coherent: true
+
+  dpmacs:
+    type: object
+    description:
+      The fsl-mc node may optionally have dpmac sub-nodes that describe
+      the relationship between the Ethernet MACs which belong to the MC
+      and the Ethernet PHYs on the system board.
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      '^ethernet@[a-f0-9]+$':
+        $ref: /schemas/net/fsl,qoriq-mc-dpmac.yaml
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    fsl-mc@80c000000 {
+        compatible = "fsl,qoriq-mc";
+        reg = <0x0c000000 0x40>,    /* MC portal base */
+              <0x08340000 0x40000>; /* MC control reg */
+        /*
+         * Region type 0x0 - MC portals
+         * Region type 0x1 - QBMAN portals
+         */
+        ranges = <0x0 0x0 0x8 0x0c000000 0x4000000
+                 0x1 0x0 0x8 0x18000000 0x8000000>;
+        
+        /* define map for ICIDs 23-64 */
+        iommu-map = <23 &smmu 23 41>;
+        /* define msi map for ICIDs 23-64 */
+        msi-map = <23 &its 23 41>;
+        #address-cells = <3>;
+        #size-cells = <1>;
+
+        dpmacs {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet@1 {
+                compatible = "fsl,qoriq-mc-dpmac";
+                reg = <1>;
+                phy-handle = <&mdio0_phy0>;
+            };
+        };
+    };
diff --git a/Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst b/Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
index 199647729251e..32ee827a3a2cf 100644
--- a/Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
+++ b/Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
@@ -339,7 +339,7 @@ Key functions include:
   a bind of the root DPRC to the DPRC driver
 
 The binding for the MC-bus device-tree node can be consulted at
-*Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt*.
+*Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml*.
 The sysfs bind/unbind interfaces for the MC-bus can be consulted at
 *Documentation/ABI/testing/sysfs-bus-fsl-mc*.
 
-- 
2.34.1


