Return-Path: <linux-kernel+bounces-214087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62103907F37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F395C2832C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA7F14EC54;
	Thu, 13 Jun 2024 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="SaxyvvFg"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED214D29A;
	Thu, 13 Jun 2024 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320170; cv=fail; b=qQHcA9kemkazAc+H5HQgLwUxnDgF6L4wX5X/hjznqcCFopKew0SI/ujm0TSZFa2fUCY6fUkZ31ReUtfsfdRMtjMSXr/jtrlpeV0gX6SXSC9QdOlok/ymimM1v2z+Yws2MNa2waqIRsyptOfLOOJECeIA5HETmzs6pINXOzpCCVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320170; c=relaxed/simple;
	bh=7SFcFD9ysMUvS8tzhiNp5bErPlRrFvAGQ2zQ+7dnXok=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fcsrpOXF7iRt8GsniioRLRY95ikIROOvCnLag/flySlJmcs2xxpTmsi603CEn2faLlq5ZcEi7wH9A47TrL5HXmzRlOCaZjdokVTTL2ECeYHFQOthctp+3wZPo26l5dO+ZHxEFF6gSujm3M2Sp3/guisk8IvOFgwYzZYFNO989y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=SaxyvvFg; arc=fail smtp.client-ip=40.107.94.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6N2pfXppDqfJi+/9gGPeUPAF7euEih1nYwc+imfW7dWfTQjGHFDG42cdDjuVsLGOJLFqg6VdXrHTwuVtuJ7aFYvdw9qd62y600sHViH46TsPuNLreVm2u1mutCTU9iKjrZWRL5w64DBhxKid403Obk4s2sdcSuH0gVfX/xHmixWbhukcNGIn+QQGQM++i7ic/Wo1OeuxNdyY5dDG3ENne7YhHjyT01huFRlruTkQw5QdoHg+KlM8IFpp/7UAa+BMEWL2Ca1gY7Aw133CcrRDwuPY3er+dbqmz1iyanOCQubQY2LtF1l7ZiHcn1AMn51jlNKmvC4bAlFwShdxFk8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuaMcHY4b/YmEkHEQwDmQ8sZdFqBybIRBgH3Lk0SYxk=;
 b=DD1K+EcbV2YR88UOfCHImkACdS5a1zMlYVoctUUSDoV9+RsH2954lwwcOyaA+5GYRnnWBIsIXlWQpIdlhgn5DOTE7zCEMxiwfz0CFoyAQ84J1T7XxXWhmwuoIxVt6vCH/O+3SHI3uHSLlb5P2TH1HOSu0w7mbnefC5gv2SNpjKPHILK2x3QUXfKUW1uqUIvEfvPlApzOv5Jukj8XdHyQkzV9mZGCXPJizFAk8RYCzbvjhR8a6ZMmMQT8YnWI5vmRLhjP1/MuXTx6qfWssiSMF4Obi7ZqEHH4otnVtk5ct/BIAzUb3rN+HY9nCqZM7gMskjelyyHEO1+yOpXDZ3ReKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuaMcHY4b/YmEkHEQwDmQ8sZdFqBybIRBgH3Lk0SYxk=;
 b=SaxyvvFg5EDfQflCeZlIkKpzN3At3YcfZU3wJIfTQKf8FcxkOdwsZSP58JEbGeVF3wUEV6xhZ3OC2EJDj0DVJb6K3+qdeYDZrgMTiCtD0iVOvDKkPMeFHvkgry6JefDO5qnJ66cuOnahRty4BkUYES/eS/S3F/uvYrwk64HTzvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by DM4PR22MB3423.namprd22.prod.outlook.com (2603:10b6:8:46::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 23:09:23 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 23:09:23 +0000
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
Subject: [PATCH v3 0/4] Add overlays to disable optional hardware in k3-am6xx-phycore-som boards
Date: Thu, 13 Jun 2024 16:07:55 -0700
Message-Id: <20240613230759.1984966-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:610:e7::29) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|DM4PR22MB3423:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a630b3-04c2-4b32-16a8-08dc8bfddd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|7416009|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gn7/QdUzTFxb7BpMwEhnNdKquvHx9wgrI7dQnMmhuGKpjQkfemZ2x/78+IBX?=
 =?us-ascii?Q?9kecswTwRzxYM7D8YsN+pfXzdWnPDl5A3pFoZcP7tr+7ETO7mz2i9Pms20B6?=
 =?us-ascii?Q?/xrbh+wfW9Ike381bEy4Wmp6CSIr3CBgm+EuoYnTu/bCYDwzaEmkL5pihkc3?=
 =?us-ascii?Q?RL4+hX6m/o11OFA/AbGSLYWy1Rzy6UUrbC26uvnt1zIyZ1zAxlZIqaqSondH?=
 =?us-ascii?Q?eWkD5eW9sDiBgRqssWlyB/mf6PIURMVsGSjC42bxo/ynwpKB5AkFZqhkkqYk?=
 =?us-ascii?Q?RFZOvw4RZRjr8w4MNa3oy3a7wjU2taCkbFxaF0QqzjCQQD+yakIhRYeL8vsL?=
 =?us-ascii?Q?IP1NBb/8LkD/y9mnJkXtePJ9g9SzNwwvQIaW8KAa15AjJnkKats9Y01NPZQH?=
 =?us-ascii?Q?onnXPR/rinmU55CSjPmuBTerlo2LdDtvmZ1sbRS7gU5kfAgOAlL0EdEquc3y?=
 =?us-ascii?Q?HqzkQ4QiRm4zDimiCdXdiBJP97kx45GVUTAum62T6bYAQNhDlTj0MBXaL0OB?=
 =?us-ascii?Q?pFT6wQXV+ZPWcg5rTmZwx54xaTapk/mkZyVIVXnFu6OFuKyT9hYWoDv0VnNh?=
 =?us-ascii?Q?wnhhI0OaOkf3tszyF3zBbs0lAyqh7oixvmOqYvsZXlVN1FKC8fly4CckTXaO?=
 =?us-ascii?Q?1ge8R2PH+MNB4sOcsLHxYyPmd0t0DboB+s0Xw8qxyE6Cfw8YJShT3Xob8JDV?=
 =?us-ascii?Q?nnW1giMtNkVkiy9eb7JQOQ2/fgTl82TPEgU2GFxs9FLtf5vqlrGXyIWf4LhJ?=
 =?us-ascii?Q?eC98Lr+6vWgPJqC6CwH9NfI1DNlIOgwvnO2cOa9zdz4/wrjmN20FU2rxYv6t?=
 =?us-ascii?Q?jYkb3b5G3+G06Rpez4Y4nISzo7xY5gnKYYkXWBSwL924vLbEF8QtDU8VFB2F?=
 =?us-ascii?Q?dehP2qgUvgdPBbZ7pt1iZWXyScH3UOyHjNFdPk8kIBtcwKNk6PIWyuEjyhi/?=
 =?us-ascii?Q?0GcRT03avDL+ke6wuuVdE00H+hW4Hi1Z1nusW8zzOkyXlh119i7Ex3EJMp6y?=
 =?us-ascii?Q?GHZXLfWBoa3vVx+NBiYHL4H+rQQJ8z4BiPcJUaG4+T97ZHmu0Zl6/FIkXUHc?=
 =?us-ascii?Q?beDz/57ZX2nW0PDc23ZD8onfbG0Ir/lwDNqXbReBMvhEEHfiYwA8Fll8++ah?=
 =?us-ascii?Q?OV+BmwuhcwfpsHPYyqK+1AsrClAaevQFpzVH1Zjcd0IzUWTO2Qg3A+lj4pf0?=
 =?us-ascii?Q?G0HxuYWpFIElVYnlNQ1YYRD7+zKnEFfEELzgdfyqccP6gKLBHTeYddk79+rL?=
 =?us-ascii?Q?yqHZomDCuZqEJi5Lhq6Ul0lUzwwCaCLKciT7UNH7lkywo+tYaM9NNxpZm8RP?=
 =?us-ascii?Q?nkRxDWIBQ4ffpj9dTx3CktDbQRgUeXxuJkMLAxjudaeSskCSfjZ4vI6OQneA?=
 =?us-ascii?Q?+jtEOW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(52116009)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HfbBQc4bwbn+a2OGiPIDCL14/Fqt5hvXb4uoJzGZEaW3MIfIB6iD+KPpAlZv?=
 =?us-ascii?Q?az9g82xtXobGklerWHlqkELUzp/AcUSi9QwMlkfGwFVum2JHaY5RQq9Cfu7K?=
 =?us-ascii?Q?0NIeYrm/KNw5LaKQ2E4Imj+WKaANpr4AQjzzHAPnnNLqttJ4nJ1mN94V0HQx?=
 =?us-ascii?Q?C9dXmGRsR8opiYKaXH2Pj7ScIxkpOWwCf98es7BnJrvNw6buFa0Z7UE2FBmS?=
 =?us-ascii?Q?R3OqrPOmGj9Ck7KAKh1op67XjoxynZQF10Mpb+gedolgniJOPeqh+rjBMozq?=
 =?us-ascii?Q?7wQorZy61lFTY9XELuYbXf7lju0QEUpzJJ9BoB9yVPmUSwmjpu8vt5xiVS9U?=
 =?us-ascii?Q?WAEOOMdFy+1jyrM6MKSCmaM9wdmz22WYXqVlsXGwidnIqWQZHtL2/+GfwGnP?=
 =?us-ascii?Q?0OOgJPQRulXJd3JTlmbVZL+ydR7aoz3RbenHOLFYESSTotMlSe04Unt0QD3F?=
 =?us-ascii?Q?La+5mjJ+vvljmPQbZlCYR3PGjkkVMowMNvyGe2fE0a02mNlPJ/oFEgFHyxuG?=
 =?us-ascii?Q?QJrMnOyaIU27qM4ikb16pV73CP+fpYiUHb2emmIOKq/QwmX30QKN+q/A3B7p?=
 =?us-ascii?Q?2UoCU4RVNCxQG5kcZNpqeviiBdxq1OwMal/I/FSy2lvrBF0SAeu1T/0JG1Ja?=
 =?us-ascii?Q?PMkcLaCSYHHSIAQ6vMcYuR+2AdzUx/uezzpmtndNH5NSIKzFW74p/Ezxom1A?=
 =?us-ascii?Q?QbCoEg1XQwQYxhyo4ApwrPQvN3HJgdOZn1DkaWRflVGKJ4/l/AYY924OMjAc?=
 =?us-ascii?Q?D0wKOz823pmruVqiE5ZxVRDraoJBYZnFli8/ir/1rZKNctKgkZpO1+fM9jVO?=
 =?us-ascii?Q?BirJz9/vb92ZYJjd8yNFXCB6xmRlEnOZjjktZq5AtEVS7ZqfLoigDjZqfqLE?=
 =?us-ascii?Q?n/p40ibxs39ydYR0YtGBnfWeD1gHTI82kACJsL5QpCmixiu5rgOhRHlan4hB?=
 =?us-ascii?Q?kkdbVnqIHopULMVQ9aDMuFzmmVD+f6ewiRs9DMw6nSnuh7VKKmFjLzwN5CzA?=
 =?us-ascii?Q?pb7MfE4b2AG3VQ6JsRIS3JfQbCBSFts8fglXqHQilNvhw3zs69BH9jGA4SZQ?=
 =?us-ascii?Q?eOPnok1axkFA09Xm04gVhkUpvOTofB80VMvOhqfbQpygZ97W4djzLLYo37re?=
 =?us-ascii?Q?pH9W3cVdJKQbmAZ0wg7+bI5s+yVE9aBimPmd8Oi6jwpJh4SXtF8jSjZ4QCCc?=
 =?us-ascii?Q?JW6jhiL1bLYbnXO3WIuad4B0tJvllBDnSK3CUW/HYDgth3Qa2cLoNY7PayeU?=
 =?us-ascii?Q?GXFI19FlRhhv8Wf8TaaRAuWvQairrP/vgEk3V+9Y0z597gYsHHWGom+3KpOO?=
 =?us-ascii?Q?bBfiXYGRh25hMUAvrJtB0bKi7hK+KGBFx8W+Uef2/mpPEAK8GxA74zjzOnRz?=
 =?us-ascii?Q?xupneec5XQO6f82r4HD2KJB3iJBj8+1h3emoCtD3LBzwCevkYk+mES2+0vfO?=
 =?us-ascii?Q?d1rdZ4UN6cGhUbJI87dxwUYXmgRHvyvQtrCzteQ1iyF+goCPH1V0mBJZ9N/F?=
 =?us-ascii?Q?rFD+18UF+jvxlp9/ND0MyMHnYDMOZqW3a8T0DwDeYVAMg4x733I9GLb0lemH?=
 =?us-ascii?Q?fZKs+yUMahHcRXlLTn8IsoynDPT/CQcfgKHbC0DH?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a630b3-04c2-4b32-16a8-08dc8bfddd42
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 23:09:23.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EMPtv2EmRVWblMa+u2qFf1go+UrTGzckQaNv8+It5hPTFzZpZOHoA0VqUWyGyV6rGEiVezzicoLOhSQEz0B+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3423

Add three overlays to disable the eth phy, rtc, and spi nor. These
overlays will be used to disable device tree nodes for components
that are optionally not populated.

v3:
  - Explain the logic behind adding the overlays in commit messages

v2:
  - Add build time tests in makefile

Nathan Morrisson (4):
  arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
  arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
  arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
  arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable spi nor

 arch/arm64/boot/dts/ti/Makefile               | 17 +++++++++++++++++
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
 .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
 .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
 .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso

-- 
2.25.1


