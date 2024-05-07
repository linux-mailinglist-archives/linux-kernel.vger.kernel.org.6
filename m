Return-Path: <linux-kernel+bounces-172510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7B18BF2DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0AB1C21BDE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3F81734;
	Tue,  7 May 2024 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="WKLk5a4r"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2137.outbound.protection.outlook.com [40.107.236.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE187E107;
	Tue,  7 May 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124196; cv=fail; b=HQLRQ9yWTmXSmRnl/oircxUmOnCv+qnEGYXoCnHdX2owUKkIabwXulFgTPr8WoxOTEkvV42Y6Gy9U99js+8w41aKy7Fe1aszKSz/Pa4qL32NLw41RLTphIV7pPUj2OkFjNu4PR8rY6SDkiaJ0Z4o8svJ3t1QFaDQXm4bxLsgUuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124196; c=relaxed/simple;
	bh=0G5NdDVQyJdmaTVRo3z/BUXXsXQzAfvfeadRsvHKeBo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=irJXekp6Rrm7OUQnQ1pisYjImYgscaPa/LfVNNolgLdE4wrH1YZzt4Po7RZSN6N9Q9Io2TAiMaaDZwVohet2oqr4ei7PfijvcSdgTcLhZENx5vhk8Mc8IQNQRJgSCrssRQQjYyASTg1Fy8wvx576CcEcerIOlpf30fhs51hp+NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=WKLk5a4r; arc=fail smtp.client-ip=40.107.236.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOTPAq/wKOG0Ax9DH/Z4Bd1hI3Wo9YRV1K8GVIBtNbw+03hCK5xy3EZ8Jky4uY3u8z2j9wDxlNfSUd7s8yB801o+fbcW0sg2qeJr2raCxqBnxaUD3PkGVvJctQKWwpSlc9JEmkJeQ5hEE8p9YX5yhgCqc24Ac+UgQOD4yeM5iYQA55/3ZdP3GvsFwrTeS4XIwWXJJaOOdR+ObsC2rO1kVOXbkeGq8gHQikcMWFzag1rdwTS7HOAuYrtJvzAA6kzmyM0FeIz6GYNjX1pt4CUs65OdAf/kk6/dmWYy5qpfvxMtOBNQtl14huFTX361gmf8wIC/vo7kJJ2sfCDNAnppsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA/gG2zfHwPS8LiQzrBHxZUijOYzKDPgfa7ii+uDfXU=;
 b=VfqgHRjc9VtUjiT939j89O1k0oAMO86QXwBVvNdc3l1VvPp7UqZ0ggnVjbju00u2EQsd0Dgx3JrKwLvF9pWwO6Ie8aAJAa4mf7UETv0UNdX/EJ26qhKs0Bk7Av2lWLtNDPTvtWLHMhlIvpCVJ2KFsTpwUoBYtvNASsT5P8LuVpcag74iDgmWD087oB8wzdkIGwSyLx6DVS2JKFmmlxpdckhnVlya8gDH9Z5TJKmnUhHRAJP6nrsd8kRKUd4qHH6i5ACWZAKh6JR67+89as384P3TYkF2jRjuCmVy8P19cilXYq3EJQmxe8EnkyGoWupzUjJ0OIF5YdTN2gTFy4LB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA/gG2zfHwPS8LiQzrBHxZUijOYzKDPgfa7ii+uDfXU=;
 b=WKLk5a4raNwM5PHNedR2vmLkC/GP3c70I+kn4w436hmW3V5ehVtNLEXhpRcWWk/barS2CXXvPpRkA6eNeWpg1kp1aYCI7tIeKwgkDTTk/grLwgh4WR0jNinEn4rl5VnX+edroicGG4x75iJzoAUwGAe0Cc7cN83qfxDToVq7fwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by SJ2PR22MB4226.namprd22.prod.outlook.com (2603:10b6:a03:546::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 23:23:09 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 23:23:09 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v2 0/2] Add PCIe overlay for am642-phyboard-electra
Date: Tue,  7 May 2024 16:22:54 -0700
Message-Id: <20240507232256.2865168-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:610:4c::14) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|SJ2PR22MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d3823b-7cee-4ef8-ddcf-08dc6eeca80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TU2+oCfcS8vtqT6e3XdIIfYFjrSE0iI9fTTPVjliBisGPJEsD8SMYd0F9YjV?=
 =?us-ascii?Q?Y3yhALp7POIPk39Wp8P9ACrvvOurBP/kBLafUuzHdzAx0KwEGTXHY90s1sA3?=
 =?us-ascii?Q?0NZf086S0Z9h3XTlDWMY/Dr8B2M6GgQU02R6umcgeIHYWMwsqJnESa2W05LT?=
 =?us-ascii?Q?FWN7BN5bh5cu6CDDH5PhIUsBNqNphGutgHsWkZL7nZJ4s/Fqn2Ra7ESfRU2i?=
 =?us-ascii?Q?OIQcuYV5J2j8AZWWNKlAwubLWr8fQmBEuzPq5Yj6uo4o8IEiBqIKgrKciueI?=
 =?us-ascii?Q?reO8BH5tKIC2dC9qywKtpoAh7l1m4iO/rboI6ViLnmsyVhN841GR+CS/txMi?=
 =?us-ascii?Q?SG0nOeeYQKiwi2JH1r7ynRKkFpapOA/g+uXaK2qt0DHTu8zQqmBgU57J2NO8?=
 =?us-ascii?Q?aZBScHJqN4/K8Cq8kPFQAqWk1WN4n849fb6OR2iXVYyevC62BBjJVV98MAUb?=
 =?us-ascii?Q?lkbuxiumfDON00uC6v2GhaYacUb+FJTqKHC5q1WoEv6qJhnjLJ0fxK8OVgtT?=
 =?us-ascii?Q?kEHWII/Av6m8iX5kBIHqb2bqGcefZOkhe3BuELZ119Z4cDyfpxCbVwaq0u38?=
 =?us-ascii?Q?WIDdBalo2LertuH5Pi/Umjn5tnLAdomXut+MO21f45W53/um3cqx/Ch71AH5?=
 =?us-ascii?Q?tk4ed/m2X5ljXdrki7mbc/6jdYC/uVN4MbN+VOUO0cJKvR4SyQlZB71Av1Yw?=
 =?us-ascii?Q?Wsi51OmCkkl0nBMF9bBgSNjsZq8451nejb8hYcbk2ep86aY4tQqf8YO9LVnh?=
 =?us-ascii?Q?7CtsjtOE/ZlzR5OaJcgtcMNgxa6Ds0ruWBP/4JJXUxRJXX0zqvF9WEKGNAIr?=
 =?us-ascii?Q?kuL3gTTlE6yBHhot9A3nJO5LbAoFBdbXB+Y9Lz4RHk8eX63fiHJjaxKbzeiO?=
 =?us-ascii?Q?gP3tWzZ13sRdO5lgb64klvZ/bHoZlJFCwI7oKFRLL2ZH1fhS9dwIcS1yCP5U?=
 =?us-ascii?Q?vbDvXwu5CKPHwggJGLuas5bz+IhllEw6jEO3RRuWGMu2PbEpPMTgOx/qwCrj?=
 =?us-ascii?Q?ieirFo+Grk+h6F1SbH9d257VXKGofNPBlOAVNmxZp01ZiA5CYUmqCSPK2mAt?=
 =?us-ascii?Q?uDNkA0E4CU0bH+lW23zuBD+aATRaHS5mG1wH2T2Rb6hjn+wqaf+kSBDvKJLO?=
 =?us-ascii?Q?tyA6BsdFky9AUmSXbs+1rCC0EePVKD2By5HElI5uKQnDEUwfSY7bL1y2GQun?=
 =?us-ascii?Q?fIlgNI5Ov5bvxGEfbTBvMfZqjUEFZROUoBzXTpH/+WLsR6vNm1Ux1J+7Yapn?=
 =?us-ascii?Q?IWquiC+dtI5+IyAeOGlVVw+TppnvXzUOXzb3vrVWuY+GDc6WWWtKatO9QraH?=
 =?us-ascii?Q?ELJaQPr7aSLhVNXy9FXzZyMYU3co7udppCxRKoBFIFwhMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aeKBo3o5ll+Thc85zfbfCHz3/lY5RyxDUdSqQeSym4TckMPgVhu3b+wYmEqj?=
 =?us-ascii?Q?r8PhUNYajO+ZFUfK+XouuQAtL/PvmXvdTUG8V1V7ID9OXykMefZ+ohxNx+uE?=
 =?us-ascii?Q?kxGEVO1p34xfbiC9zK9hJXHJvKZFRDzk/Y4FPYjQGiEdYz/a9LSB/k30jePx?=
 =?us-ascii?Q?fLwZzhYW63ad8J41fqU8YQ8YMJe24KCGkw48fnG5mAB7ow8qhJHFTDiGHV2x?=
 =?us-ascii?Q?3ch54dQvxmkZY8B2To9XQsVa3SQkGxwwAxjHQsJMsaYUk8r2W4pd8f2aIp4R?=
 =?us-ascii?Q?W3SJRghwi8a06McZkdV9k2ZJLo782vg/aMCbqsfFv1rzaAkLRRLsJLUVGvgc?=
 =?us-ascii?Q?jIkKNLgdiPDzbyzFxVGyhE83ZRcN6sO2hvZseXNMSaKIrP/Kw8m2ZNZizDsD?=
 =?us-ascii?Q?CnsbAm3rMRyetuemBdCpXSrnMD67EkpW8ZvTV3oHOAwNaCXyOEEMbic1hYLn?=
 =?us-ascii?Q?OWlE/RWyEfXCaS9hu0FOMaSbcXuIcY9DoVuyISWl1i0LJLnQQxnMHEfiQH8z?=
 =?us-ascii?Q?mCB9HxAjq4ewR5VktHvH2E76TJ5jYndCY8lHjtmc4LQLB2OZTI1dhlG+s0eL?=
 =?us-ascii?Q?GKMNQTbARt4zGg2FrgqYqMXuKsdx6jS6OJiZIBmAJ05KxvAXQUqfVN4ZHKku?=
 =?us-ascii?Q?VEfc2B11CeQat9aCx0+52wKfQmsWlDyNVeJmw4OKuV4b+ym1CCYzhVpehKOS?=
 =?us-ascii?Q?wSDf0RyypWWSeaC6h9XuM6w2Dqr+URcj9bZDic1WtevwEay4ZzHPmkm+241X?=
 =?us-ascii?Q?n/BEPDfPZ9Tcb4ls6D4NHEmlT84QJI8Wk7gzI421KFCCU1NRtu1fGpGC9can?=
 =?us-ascii?Q?KFq3yvVl1bvF85UMgW6XN0j43zGGCRL52rVw2ofjx0K5nehhcrhgml8/WPVK?=
 =?us-ascii?Q?S3wUfiyy4l64T4ulhDVCy5pGHOouvlds18+GfTbdZ0z5Lo9jztiRY0LH7s4R?=
 =?us-ascii?Q?L4Z06XacsXR0dNqpkZHCHNfpR8QjIM+gTIggHdm/LzIbxF0KWqNdiTXAe4aQ?=
 =?us-ascii?Q?tVeLxHVCCafy5sftyzFvGs8KwDrNvO9Rkpbn6LfwB+XDkxwwykTVQdIxjIdr?=
 =?us-ascii?Q?W//mZU/E/WiHPO5zSc/ZPp1EBblMstnCPb1M66wDff44fs1JIiBlZaSSEto8?=
 =?us-ascii?Q?oeOvDoSYTlLX4CwVGTNn7t7tLbVs/lYY3fjVD8ycrvr0yfK1iHBU/yr7LGye?=
 =?us-ascii?Q?siGAQ6/kNL1YsjGEoMvVbeRX0CU6KyCj62vxmM6en79Ul6hixZIPKY8SGKJW?=
 =?us-ascii?Q?HZmmwn0bs4YcHKnQE8q1UxH5rjSSlcBxOXakGwA2/hNfxkQekXOKzitaU8LU?=
 =?us-ascii?Q?wZ5x+m44Bb19Gj7PNHDL4qkusjcRPKYVdTkWVGgo4oKds+en0CchccnHdXYD?=
 =?us-ascii?Q?psId59ZWFM8pgHclR6W1Xunr26iYczecKzuyNMG0+YLgD8J3kulB4QtiFqQI?=
 =?us-ascii?Q?t9sXZsPJtcIqsbVy02r6ktCQDNETJkqdg1ZGysm5z0yugsatXhx3lCb114RZ?=
 =?us-ascii?Q?7cJZID0YlVVYcq+LT7VisICnFKTB1/lgKOu1qZgANXS4sfMw3pQWpW8pRtJR?=
 =?us-ascii?Q?lfsBl1EtvpXXuXLhz1tqVW64tsCdcmXcIsej+DC4?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d3823b-7cee-4ef8-ddcf-08dc6eeca80b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 23:23:09.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQyW2W5aNmo580k68JFsA7AmUiSiI97AkFpg41Ah/Fhx9AhFOvLDy/vcPaF6cN3dkxN7ZIvs1sW8ZDMWnSLgTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4226

Remove PCIe pinmuxing from the am642-phyboard-electra device tree and
provide an overlay to mux and enable PCIe.

v2:
  - Fix double space typo
  - Remove redundant status = okay

Nathan Morrisson (2):
  arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
  arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../k3-am642-phyboard-electra-pcie-usb2.dtso  | 87 +++++++++++++++++++
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 12 ---
 3 files changed, 90 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso

-- 
2.25.1


