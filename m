Return-Path: <linux-kernel+bounces-283904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE8B94FA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195881C2236D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364CC198858;
	Mon, 12 Aug 2024 23:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QOL0RhnZ"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E21804F;
	Mon, 12 Aug 2024 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723504718; cv=fail; b=WGkzv8NOAIToPdHiOEsRES6eMb6DNJYeDFxc9GJilblqYkGL2gHUB25v/m1Cew0VkXjh2sq3Dai/ydVCNjfMq50zK3TN9tf2mQh7hFi0+Jg4Zu0k/MKVbKJoGImyE3qSCpYXzlBlPlwIxkCuK7OiKdXJHStduHeOOiPDcXa6zMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723504718; c=relaxed/simple;
	bh=hPRGEHG5X4idGu7+jA+7unQ1Q0STfYLVJ5H7n5Qu3/A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QpnZc6QJQj6GVxPN3msU7QRtSUykbWC5jLux/0uchG+mI7d7abhH40yb+gvDPkChylW9jzlygB/MH5e2gR67ZTKdSt/fa1V2v2GmIeR+CMvhs9wrZ5pvQmuIMjU5GFX4Hwh1PUw+KdZN5dg3jcXKn2/+mph5NLvR2VoM606K/uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QOL0RhnZ; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIqjjjJbxgzYW+JQGWZtQ9v4Zc154xgu6FJaWJVAH2S3rkRdcpNeyKiTrd0LfY17AOyd/igjvOUuUFvFZhu6MxlTvGSDLO3mi3f4dL6UVl1CMR7zs5FduqYxxRW0j04Bt96wgmY7uSpO7d4x1377pBt9QbVqDgWSONorsn/2/L/908v4mN1R9kSw+GQgCZOeSjhy3NBffoeOvRpDxFT+sazJ5fp+XmS/ZUC9Yx8VzKj9pEpsZIob74+/2m62smwlkEXCsc99MGPjM7mMRfCQiHl0B1DZmvFg4SDQQHVnIzAMICCugFlxuv5xMDPidzUl71fuelEj8PJ/UyutdiwJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSWDOKr2iMpyKnL4ZhVwTy9KqejKfyVBQzhhe7kbyeA=;
 b=jEiESVVflVTyFYOj2P6G1FGWrghceiYpWARVd9nJhWfZ+6SSVI8ZQc/EPbaVrCkOd1FjsdjeGo9wEibTpXXX2OsXAKuoGq1RfbbPwRBX4GQ5lVsCvG/aREUdAWyHj0z0uwfKGJl/m/CzVWSiCE4N8dPg69W25yG10+NX3ssndYeIBjb+BnrUdGdbkfkHjRtVU5fp6dhlKVk33BkWAmYzfyrc9uRMTMeY8tKGYfTWj6EHxMc0GNtvqQwblSxha2Bv/V7CGM9NqB3FWHbBYkuphpObWVXZLWj62Jjrw231MZOXBZIoc8YrdhxHcE2bSSDt/C3wJUac9xu3F2ZFbmNnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSWDOKr2iMpyKnL4ZhVwTy9KqejKfyVBQzhhe7kbyeA=;
 b=QOL0RhnZw2CFVr/ywWB8MkrX5ZFT6FnTGz44Jn+4sLVoRzccVoFXp6iatRlTu+Snu4MGTxpx7i6B/xuuDrAGHLZxE1DuD5JjOF0209IOPSWmM+TBBbsu4H4uc1dqyZCRnzT3GUzcpRYNR6gb89tOsh3h9J6IuuvLHThkJZUlXnO7uStVgY0MOSRJoQqfO7B/V90T9BA+U7QK1//9fxPxmWqI8vsXHjSAIZykPP3Khn+hJiBieeF1ARHhr6eK74X353iispjUTHCa1Ifqgq80kRpAyXXlx+u+2LlDOi3MUeM9finQs45tmr5oMfpprLO3LXIfu8qS+gnGbTPew5+9MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6852.eurprd04.prod.outlook.com (2603:10a6:208:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 23:18:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 23:18:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: extcon: ptn5150: add child node port
Date: Mon, 12 Aug 2024 19:18:20 -0400
Message-Id: <20240812231820.3838925-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: e607a5ff-bece-41ce-b471-08dcbb2515c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wu4THs7kofIxEpQmBw1ca77ELYsoQA2jiUHVCP1pLqTOt+jNGjz0Tu2I4oGH?=
 =?us-ascii?Q?kOj8/Bzf6M3VDjnSo/0qNPtO8SXz5gKxSOSjArjLPSvYZpsL+zMfPsh2r64p?=
 =?us-ascii?Q?oXCg5tnUAy67QyP+PvgPiBtnO3nrzK3qzLK1e1+t/J2gvs3formPrOFYbubf?=
 =?us-ascii?Q?2/TfRXOX0cSwmxPImrPe+ceFzVVpBtkvANea96lEDOu5UGauL3BsAsRLv+p3?=
 =?us-ascii?Q?JJclM8KGjMSh04O44CAVPcJLqmSpJjD4wgkcJ6WQcPWaGMR/Nx9Edjp28Xzk?=
 =?us-ascii?Q?ZNMs2O25VgsHrtZWpDazC0WbCRGEDHiVNe9LguO+mFxyRkLeyqsdooq8+Ox/?=
 =?us-ascii?Q?P0sop5MCnNAEO09VzL8d/7SBaE4WknpvYbh3aR9ScRbGYdQhL1P7zb9dtRIH?=
 =?us-ascii?Q?s1OjXkGpdD+VOARQ+IZeLdKrV8rEq2fJc8vxf3+KS7oepFi3lrdhaDRRaQ3X?=
 =?us-ascii?Q?3ncDTGEumZvkOmWhNMW50zUeeBtCZvqT2lJsYKVLiFzs7ov5L17gm5cfUVGa?=
 =?us-ascii?Q?JQk9awWsha+qaso7hjP4jk4kJ17GMgWyZF3ka7D/bqLfLp4bHhUUWyVRdbFE?=
 =?us-ascii?Q?RuyuBLPHeIQrteONLSjj9FRmDtdUbjQiGRBM+94Ib0+hAbpz+JM/9cUjQJ40?=
 =?us-ascii?Q?N5G+W/bWFoLWArBSxiq4OPE3kl9Uz+T40bpQdId2leAsZEvJYxCF6+vHe8R6?=
 =?us-ascii?Q?gKmiCnpr9MpnVqrP+vvsjw9R04ukZt8qe+basydRVThQ2BuCImjFQMTMhqfv?=
 =?us-ascii?Q?0vGezBg1WvsqlJ4PKjvVIVae08LmdygNDFfE68T8wDuuPnsLpjSTKXpL5mvL?=
 =?us-ascii?Q?m20mBdhBiZbkF3CzyUwSzRBq1k2Vl7qv+9hHVcnV1USDgbs2gyKrmTEyMDD+?=
 =?us-ascii?Q?ZdwAio2fSo7F3E8UpJIxYdg+Nckt8dudgY0Nj2tqXYPmJcYhJ6Lc9xMhIMdy?=
 =?us-ascii?Q?ymhAVCnWQ2ZIgth91blNkXu6PsEZ2X5GtWoBTfsovYW4IkIUD+xgdTJ8V5oB?=
 =?us-ascii?Q?xXmpKb+lYiTwlNjI/ahQLXKwz58/LmfIRBiqp1/rLphylfbzSDlvr/IxLuFg?=
 =?us-ascii?Q?buJomAstBQIbuSKqyEvClTin6NUGaRm74zMmaTIwSxS/PBL81j67Sydgmh1V?=
 =?us-ascii?Q?ghPDJUMYYNk7fDqw9PIeaAmlW134W+yE2iL3J1ISdJhDvTDGfRVGDlLlggHl?=
 =?us-ascii?Q?SCDL2pq48NHLJD5nrF6CRmIwBOV5/9DZXO3YNlVISxDr/BGfMgV3P1N+mSy1?=
 =?us-ascii?Q?kq+ucABVQrz7PB/sRZrUeB8KuwlocUwfmXjEyPs1ZDsEbs7Q9vKMglPvKGmp?=
 =?us-ascii?Q?qb6AayThx9p56mR7SRIEoM2rUV5dUxjZEqTYB/BPwl73cHFWdevDwHrzKVZA?=
 =?us-ascii?Q?dhu0rA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIdRso1/S4CyqdUuzcR08mJAuxsAMkvjzGtLGrmHS+MqFnyTcK0ZpPc4w/2Z?=
 =?us-ascii?Q?08opXYQIsZS/7RKalYW2fma+75zcRlAlV6nHer4qVpYlMhyRF61zWpaf8v5y?=
 =?us-ascii?Q?0i+qfQj1gBOzszM7eUTb0AjYAZ9i/Fpbnq6InfhXz1zSFLQYO6+aKsQxT074?=
 =?us-ascii?Q?FZNMWWOFsg/ejm4XIlDtoLFEOwxwTESDDa8hmijj56emUycG/K1j3CBn8Caa?=
 =?us-ascii?Q?BlTS22IBfnaUWDiErLLxLVG6W3KTRa7OWRCAk6KIyVtIjWUByNlSX6jl1jck?=
 =?us-ascii?Q?CtMtUJ+gRDPgpk1ZnQ510i0rKME9w8AgLbUEHzjNKPmRynE2e9q5Ht/Q75l4?=
 =?us-ascii?Q?AyF5h89MUA5+3hupGILc3fY8ImfE4+STwGEnMO/55X+Zy9cn1UaUI7I7lsJi?=
 =?us-ascii?Q?swi+PablwD/0s54T4S96+8ZE1sckYkr/3bzZ5RoTnEh8eXqYW5fPQc4n14Gr?=
 =?us-ascii?Q?SVFHWXgX+3/bXKTb2dfCMMor9vAlh5ntApyoHLVYm/uSGDjJknQuFqwy51nd?=
 =?us-ascii?Q?BcparKuKnQhWADUXCqdJXUlSfNvUzM814qU+FCaI4E6vdwuXcQ4LUAWfoOF/?=
 =?us-ascii?Q?GE/F7NfNkk5DBjNrrLW8P8RnXWYpZA+AZtHNPrqn7B4o01M3COoaSwajyDnh?=
 =?us-ascii?Q?vKOhq2klUpaT5zyGIO9Zpeh2WVnJsN0aDDlvF5QEhdUudVh6wmwRZmOOV+NH?=
 =?us-ascii?Q?zEc8JSkCpSLNPtnYWxPttZbSASXZd1mJgEA8CZ05xO9Uk1sVoF+1Do/dvX63?=
 =?us-ascii?Q?2h0lUpn1Zxrzl+QoktnjLm4MzgQWT+IMxwFkLPvfnWmyGMtC1RBFR0/by/iA?=
 =?us-ascii?Q?Adm8MGVRphjO31NtTZy16bJszSX2ulT4N6igr3sI0QKDEcaTz+Af218vHelQ?=
 =?us-ascii?Q?XrgAPjgAtWcwRvYAEAeMPMRlE5OxMJEkxF5//Ggg5DPqIErbUtCcyvsoDWq3?=
 =?us-ascii?Q?/qyH8kzPt3I6DFBaJC2X/1aT4sxCMaEZV6/88jUGFaDDyEf0tu89XSLMChFo?=
 =?us-ascii?Q?2Dr3RVKPxyTryKP03yweyunKQoc/FYUzWrhZ/o2bQmzjpbgpJHukH91h4BFI?=
 =?us-ascii?Q?b9rKw4jHdGrcucgeoCY+5qnZcTvrA1Lx10HpiVDCB2yzeBFBNHKzV3RjaZO9?=
 =?us-ascii?Q?WrCZOY7FHBPeB53DZqQWcCwAPa4QaqyPZWoqA1z83tc7Q2TLf+FlI0qPSaf3?=
 =?us-ascii?Q?+kkjhleQ2GK8MjP8Wh3+/DhBSDfiE2Lu4jiS+LBQXVgHJepTPYRH7FRvxROT?=
 =?us-ascii?Q?mvhV4tgi1zRdA3vdRq6k9LGrEzHSDyC+5FD3JC/19p6cxDRqP2onj2cqlOFd?=
 =?us-ascii?Q?vIB4TEjbXE1B3XtHkB1zXwJJf7CjK0oNrZozBB5X9AWfpno7l14eO/hicLbf?=
 =?us-ascii?Q?qxEjaUx2MO3erIU1iP4usvbvPeCKSAYI4CAPTlCtQ+RFAwFEg48WyEy2T5OA?=
 =?us-ascii?Q?8vsV3FU84J+j2IQT6/No/LjdjtHTHBtiTgtqFpEY12t1dAWDupcUUmjOFdLz?=
 =?us-ascii?Q?CSIxi6QOfndUBt09ce7l7BLbGckUofyz/A4c6z051QRocYD5Eih6DiFajWu5?=
 =?us-ascii?Q?jDoNzEY0prRkzqlHKfAt6P78ZGkBre9TVGIoDxbH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e607a5ff-bece-41ce-b471-08dcbb2515c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 23:18:33.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mxt8bEupdAcGt9oPiNYZNCrzf6MwkHJBNN5RcW++bcYvuSLDp0DTyVr8X1jnmyCcM2TKgGvPsn0VvH2R5W6SYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6852

Add child node 'port' to allow connect to usb controller to do role-switch.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
index d5cfa32ea52dd..28c34d78708cb 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
@@ -37,6 +37,11 @@ properties:
       GPIO pin (output) used to control VBUS. If skipped, no such control
       takes place.
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the usb controller for the dual role switch.
+
 required:
   - compatible
   - interrupts
-- 
2.34.1


