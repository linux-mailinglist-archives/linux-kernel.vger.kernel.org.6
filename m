Return-Path: <linux-kernel+bounces-228194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CB915C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6F21F2259B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE53433B1;
	Tue, 25 Jun 2024 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OAgTQanT"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6A39FC1;
	Tue, 25 Jun 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282370; cv=fail; b=GLpR/CkyPvNnGgnPCmbw672w1RQvtIvbep/nTtBQV/fyA+iElsx72nEXFdtT4XkZ8MEABbIHKJl3PetXEfOWxZuJKAs3VuOplSofNHSm55v8XANmt0WPKGGSthuSfOicmrt9i5iYgETQdgnbZlnQKI181AvxFROeisxxYRCPn90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282370; c=relaxed/simple;
	bh=L897ZvKAQEhXZN/XqikrJkhP0gjX975OoIV8WBqPX5A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mpBXwlL5DaMbVUrTg2TSxfpcejMoHTUdobT+6l9CTIl3Of3uSv+IdkYgNJPvxWsZEPvjoW9Qh+RuRZ3kKjGHP5YwLg2aRQ7xR+pUs5CFJXS+IH6Y00W0awakQNLEe+6JEHOBca8FeUu9bJXT014OraGvWh3rV+HymfG/EZUbcg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OAgTQanT; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkCMEVBKZw3u37Ni3OxGhqMeN+fov5eI61wU6+wlUOWJPMqwEoSrW6nntC+4PIA3cHMJsBjGPXRjpzZkBgYI//XAwohPpUitQRfSYr50osJMzY3b+Gmpw64qxXZiXZnmS9bfVl0ATb6NhmhmJj++8IPa05IUV2E6nNxBb9gyRH/94rIvUh2kJahyJAiPdlcrfuDiGNo7PEqn6xLCmKvDLSzeKD8dmVaonFmEHPbfArQ/2dXvRjrJUosV/e47FY+3o31liJ//QJcVLPNA/7Uap1D9As9PooiCAbo4KjyMqXEJTY1rhPKfsyoTp3fC0Af1rpBLtu0m5K5idxBPNbT0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAzpkgGDOm9c31UpOE+1B1xI9cO5SVEk4Vz6l/wsaBk=;
 b=mNNULWN0BSEBzPmhJzICygTM5jkXWz9QGXW7KtXpzrHbfQ1i/0Z3wX6pjb8KmMTPfNfOA5CSDG0VngvH97KHwBV6uZrPGcSRBkKaZjePvFpOR+jX8k1W5fdwHE1YwGJk4P25yQBPXAVbdGvwn8FOh98V7IOQyJpTL9uHpuH9mUvBL7A9wzIm1zm4gp4nlXgJ/Q1G6ku9BQaMmLcoryMTAh93IdtrAZT2rGeP/E6ZM5X98ZVgx1JkUjIJt1BB8wml3YHLVXtFGHR896qpc4lU0O1ZAwrDHPvGmJ1RNImbNrxmC1M8us9NCyI75SbboQxpbMwvsEDCWd6jNyQh6FQX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAzpkgGDOm9c31UpOE+1B1xI9cO5SVEk4Vz6l/wsaBk=;
 b=OAgTQanTRamGjBHCgAaYMTWPrt2WlL/Kd7KW0eFoy2JPC3QA/0/y6OABW9dKS1AHCoHkUb8HDANe4LiDoOy+X9lFOmt0KXqrBXxWMH4Edlms3+WcvBlyuyUmkJ/1X57pYj+vJFAfTB3Ey5uVKeKOgU8AndWVRuKGmXfreCnEf/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10705.eurprd04.prod.outlook.com (2603:10a6:150:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 02:26:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 02:26:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: usb: Convert fsl-usb to yaml
Date: Mon, 24 Jun 2024 22:25:40 -0400
Message-Id: <20240625022541.2007010-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10705:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afc4db9-93c1-4f07-40f3-08dc94be29a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T89RuMxea7qr+D2/sSsKaUh1S7wTleePNnXYUFyhdMQg7YbvrMmXNENeD3hL?=
 =?us-ascii?Q?qhCg9D0Dgjf2ytFyhKAWNC6Mh4sDwdBid6PKZ7XrbJFlftFQ1jsF6Eltrxw9?=
 =?us-ascii?Q?81nFbVdP4reNyUsGtXe2ESyjzD1/1eN3bjtysGw+25CdLY24XWZ97O4Oz6eC?=
 =?us-ascii?Q?o3EVz/lOSAw6DycSgUD4U9RDp2XyhjoBuJzbLzojGPYyet5FXGh5Yc7fp0fl?=
 =?us-ascii?Q?inK0/kyGUb5UdeB+yvsKe8euajABj+TucI/hpsP9+j8zFNiTR+GC7NdhNYSC?=
 =?us-ascii?Q?H0X8CmniSlfu/KGax60hpliR8eZfoBIv4OCihOcwdwLyZeZQLivDDxThhH92?=
 =?us-ascii?Q?n90jAbMpf8/WernmS3iNBqXdqUHS2nj1LBphub7tTBl+P9EfCGc8YzwCh4h2?=
 =?us-ascii?Q?bplJhfnomhALymhel35/we5bI+L+QVp9Fb8Gv58dHOzhG8hzfwCoNLBs/aAG?=
 =?us-ascii?Q?DpqaOZuXRqEHAb+8sPJdLbu6hjbgvOOsJjlcomV9XwVazCxuMDtvw9fPmnWm?=
 =?us-ascii?Q?9M195/9es7yYRPq1foT0mNQNYEqezrE5Xgl9S+VpqcPKy48JM3BAOWznCLQt?=
 =?us-ascii?Q?bdRJ8GY7RWJXA1ODbIILZcHW16ptnpQdeaZzRJTw/lPMaU8FdxDZ2J8iUwOi?=
 =?us-ascii?Q?MJ7l2O4hgbiOH/gttLWDyWnKWHSYp1WrCDfrsOCt0+t9FhUrKfk16RVrujZs?=
 =?us-ascii?Q?yWGnJ3feJO5V92T2045Ltxk3gJsXokInnFsDY9ExQ/0uk4TpNBjheY9FOOwO?=
 =?us-ascii?Q?gV8+DW+Y5Elq/m0zwgHMZTxn1zZNxCiBbDtqFV9gvUt0YZWrbPGazwmWcbQt?=
 =?us-ascii?Q?ovz95+6O/Wj6W41BDG4ZZk92wX3HygNr9SgD+rHeRugIK+EkGVzhrlYtuMR2?=
 =?us-ascii?Q?bdcj0r4Z9i4IUiMI9V4hac6iHByLl3xp02RG1vLZAZW30O9ChERVAiKsIcB6?=
 =?us-ascii?Q?bgvNXgMZa+xnEEz+bKPhKLB3efe5XKeFROyuqHm4UtyEX8CiBLUAZHc2FEtC?=
 =?us-ascii?Q?CPvgIaGCfb0LhiQAUesTLJdQRPrMF71YQESD50npdCBx4mqTyN4IdRJtnhN5?=
 =?us-ascii?Q?9/8EMYxpCE0aAa4gJF1ryj9s8sc+CBn66MiCKjEL2PDpHhIk2wXFVQ3vZoqV?=
 =?us-ascii?Q?2lq2LRs/A7Q1kLL2GaPBNdSuIYBeHxX9EkwWjwGDNZNMyP2Gy3XqrZMTfZ+B?=
 =?us-ascii?Q?ZNiJioPKD2vqpRAN0GvDedcBmH+4ZLf5Brqnge0KYYxoTqA6uUfRKPlBK6x4?=
 =?us-ascii?Q?rEWFQdHDt+OYQGHsGPaLOSbHIQZKr9M+SVztTdnplKXjvF0Czt4YSb2scScq?=
 =?us-ascii?Q?888dVvBwX9rQSzyQ1fJ2y+YS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h6RDvSveLODiNIWVdGmmNdHViISLc803ktS0wgj1CfAXgRWaooe8sNS/QhxF?=
 =?us-ascii?Q?r3mSPCzCjuzrHAHggoMqE3S8isNYo+4DINeYN/bmfr4Eih2U7u9OUl77GpsD?=
 =?us-ascii?Q?KQdPPqBtOYMTzIhZeRGOH+lCjBg70sV7sD1rPsfqfldG3dNXhkzlWhA7ZI5E?=
 =?us-ascii?Q?QoD07Iu6WA5clTT/3G/1PNxqp/FaeFFr0j99umeCf7/yNvVCxhLqgz5Rwvd2?=
 =?us-ascii?Q?MmWfipFJg9ajgt1lwaoO3PUK6LhryG6P5AUXE0TKzPTI4rcbdUYsk36VQklF?=
 =?us-ascii?Q?e770ShoxvuO/XmrfZqeshGBfW5ifQFGZxbGCuJnJclXvSWDFLx0aHTtxj1Gs?=
 =?us-ascii?Q?uElBYhWIXWmg8jcnOUnXawYcc/BoJFXdCeOcqZL58+KeXXuFozXuWoTyjFqc?=
 =?us-ascii?Q?oQ1dzpN+06yC8CW35F5xjTicsS4GfboP9MZ6Ah6BmRZrtfKISJFubFT7fovC?=
 =?us-ascii?Q?F/K8aNZQk5nIj0i/0kM8HolmkVv5uBarEfkLVj6fuCzyOATopju2kTDc1beP?=
 =?us-ascii?Q?e2CMba6LWRsWYojqs2YNX/3eOmg4SZe7smZ3ddamG4oToNwAwvQzu6Yey51H?=
 =?us-ascii?Q?RRgMqMskHzJs98c2mNmIB+s6XMmfE/LPmcHIzDqbqiWtOGObb0/rMnr2Ds94?=
 =?us-ascii?Q?4/IMGkGsfGd2mGv6IQ7pkWvTple0RoHaF3D3EXezu4ITZOz3X76oK3Rjuv11?=
 =?us-ascii?Q?qgI0ooYMzQj1H6cwYRNmgWOGjWAZ4QAhdYbCy2tYbzJa/vSyw6Ak41LUZdYI?=
 =?us-ascii?Q?JDg9M4td/jcH02JrtOKThE/Gw1c3Mz06531bnBD2/Y9Q0c004LuRYNpsXwvD?=
 =?us-ascii?Q?3Uv9FbPlAEMy3NVmxlzm3YgZS+ZpEsaJ1q12lNCfX2/JmB9oGoinN2rwpQ93?=
 =?us-ascii?Q?SmfZw5eDcreivAgCah4nghZgZJv6cGaRFhktEdLFjCcPn9mWLuvToUq4P+H/?=
 =?us-ascii?Q?/2/nNcZuqDlcNlw4kAeuSG9DWCbkSaUo6Myq62sLrQeZ73KwCX3/H4XIKJJz?=
 =?us-ascii?Q?5DdBNbnevY8YRBaaYymFI88c56fA3xDjyA2246dshBGrnC81cbgLmQmih13X?=
 =?us-ascii?Q?2CLeV7qy5E2R7GjRulKNgMqJj+P44oReP3eSl7wbop+7f52UQcZ3oWxyEXlu?=
 =?us-ascii?Q?2fD5c+pFeiRO60VobA7BE9cI9WtsLJ/ziy/Rm/eXP0uuXEoaN576YOs3koKX?=
 =?us-ascii?Q?fmoRO25T3h4eKIaIqmhDWil+Ncde1wS85ZBxDc+QIVTX1J0ntY7EddOkoyyg?=
 =?us-ascii?Q?1Peir+N21V0aoWQ4T/fhW8neQIT8qkK9wLfmZuYwgOTPzajiy23kkuY6NhxS?=
 =?us-ascii?Q?szxHzyjTkyX6O8JkPkZSmYqyAs7lumJiYgTSp+nL22mqYurLX5HHKKqcrd84?=
 =?us-ascii?Q?WFvRjOFdcLecaIjV7ys5U/kiKArIgR6Ms0MLTSC1F37cwjeOPWYljhg3cxww?=
 =?us-ascii?Q?BZpYrmDfygopC4J1/57I1BKr4VgDMttu8BgGtwVvCRCjC4JMtJMv3RCbM4Vk?=
 =?us-ascii?Q?DSUYwulLMw9UBGJE3BHAhbGRhb4XwrXQ1Htaitf79OaHbLJQ7ZWcRysQ3h3z?=
 =?us-ascii?Q?B08pCoLNyC82j5tKgbM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afc4db9-93c1-4f07-40f3-08dc94be29a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 02:26:04.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOfbRLo3SQKbrDMoxUuMtgjg9kQxe44VJy41nSPd2UlzcVjIEIq46RIUEb5iL/tl7pj/8MFYcD713YsXCu45ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10705

Convert fsl-usb binding doc to yaml format.

Additional change:
- Remove port0 and port1 from required list.
- Use common usb-drd.yaml for dr_mode property
- Keep two difference examples.
- Add interrupts to required property list.
- Remove #address-cells and #size-cells in example.
- Use predefined irq type macro.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/usb/fsl-usb.txt       | 81 ----------------
 .../devicetree/bindings/usb/fsl-usb.yaml      | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 81 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/fsl-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/fsl-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.txt b/Documentation/devicetree/bindings/usb/fsl-usb.txt
deleted file mode 100644
index 0b08b006c5ead..0000000000000
--- a/Documentation/devicetree/bindings/usb/fsl-usb.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-Freescale SOC USB controllers
-
-The device node for a USB controller that is part of a Freescale
-SOC is as described in the document "Open Firmware Recommended
-Practice : Universal Serial Bus" with the following modifications
-and additions :
-
-Required properties :
- - compatible : Should be "fsl-usb2-mph" for multi port host USB
-   controllers, or "fsl-usb2-dr" for dual role USB controllers
-   or "fsl,mpc5121-usb2-dr" for dual role USB controllers of MPC5121.
-   Wherever applicable, the IP version of the USB controller should
-   also be mentioned (for eg. fsl-usb2-dr-v2.2 for bsc9132).
- - phy_type : For multi port host USB controllers, should be one of
-   "ulpi", or "serial". For dual role USB controllers, should be
-   one of "ulpi", "utmi", "utmi_wide", or "serial".
- - reg : Offset and length of the register set for the device
- - port0 : boolean; if defined, indicates port0 is connected for
-   fsl-usb2-mph compatible controllers.  Either this property or
-   "port1" (or both) must be defined for "fsl-usb2-mph" compatible
-   controllers.
- - port1 : boolean; if defined, indicates port1 is connected for
-   fsl-usb2-mph compatible controllers.  Either this property or
-   "port0" (or both) must be defined for "fsl-usb2-mph" compatible
-   controllers.
- - dr_mode : indicates the working mode for "fsl-usb2-dr" compatible
-   controllers.  Can be "host", "peripheral", or "otg".  Default to
-   "host" if not defined for backward compatibility.
-
-Recommended properties :
- - interrupts : <a b> where a is the interrupt number and b is a
-   field that represents an encoding of the sense and level
-   information for the interrupt.  This should be encoded based on
-   the information in section 2) depending on the type of interrupt
-   controller you have.
-
-Optional properties :
- - fsl,invert-drvvbus : boolean; for MPC5121 USB0 only. Indicates the
-   port power polarity of internal PHY signal DRVVBUS is inverted.
- - fsl,invert-pwr-fault : boolean; for MPC5121 USB0 only. Indicates
-   the PWR_FAULT signal polarity is inverted.
-
-Example multi port host USB controller device node :
-	usb@22000 {
-		compatible = "fsl-usb2-mph";
-		reg = <22000 1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = <700>;
-		interrupts = <27 1>;
-		phy_type = "ulpi";
-		port0;
-		port1;
-	};
-
-Example dual role USB controller device node :
-	usb@23000 {
-		compatible = "fsl-usb2-dr";
-		reg = <23000 1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = <700>;
-		interrupts = <26 1>;
-		dr_mode = "otg";
-		phy = "ulpi";
-	};
-
-Example dual role USB controller device node for MPC5121ADS:
-
-	usb@4000 {
-		compatible = "fsl,mpc5121-usb2-dr";
-		reg = <0x4000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = < &ipic >;
-		interrupts = <44 0x8>;
-		dr_mode = "otg";
-		phy_type = "utmi_wide";
-		fsl,invert-drvvbus;
-		fsl,invert-pwr-fault;
-	};
diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.yaml b/Documentation/devicetree/bindings/usb/fsl-usb.yaml
new file mode 100644
index 0000000000000..8b5724e213f09
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl-usb.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale SOC USB controllers
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The device node for a USB controller that is part of a Freescale
+  SOC is as described in the document "Open Firmware Recommended
+  Practice: Universal Serial Bus" with the following modifications
+  and additions.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl-usb2-mph
+          - fsl-usb2-dr
+          - fsl-usb2-dr-v2.2
+      - items:
+          - enum:
+              - fsl-usb2-dr-v2.2
+              - fsl-usb2-dr-v2.5
+          - const: fsl-usb2-dr
+
+  phy_type:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ulpi, serial, utmi, utmi_wide]
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  port0:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates port0 is connected for fsl-usb2-mph compatible controllers.
+
+  port1:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates port1 is connected for "fsl-usb2-mph" compatible controllers.
+
+  fsl,invert-drvvbus:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      for MPC5121 USB0 only. Indicates the
+      port power polarity of internal PHY signal DRVVBUS is inverted.
+
+  fsl,invert-pwr-fault:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      for MPC5121 USB0 only. Indicates
+      the PWR_FAULT signal polarity is inverted.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - phy_type
+
+allOf:
+  - $ref: usb-drd.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb@22000 {
+        compatible = "fsl-usb2-mph";
+        reg = <22000 1000>;
+        interrupts = <27 IRQ_TYPE_EDGE_RISING>;
+        phy_type = "ulpi";
+        port0;
+        port1;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb@23000 {
+        compatible = "fsl-usb2-dr";
+        reg = <23000 1000>;
+        interrupts = <26 IRQ_TYPE_EDGE_RISING>;
+        dr_mode = "otg";
+        phy_type = "ulpi";
+    };
-- 
2.34.1


