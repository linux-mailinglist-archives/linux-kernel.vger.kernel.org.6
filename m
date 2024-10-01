Return-Path: <linux-kernel+bounces-345374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3198B55D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14AF1C22D56
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339161BDA85;
	Tue,  1 Oct 2024 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="gJP3dpas"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EEE1BD4FF;
	Tue,  1 Oct 2024 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767195; cv=fail; b=a1BJCQF9YIoXy6lB5eH3/p2ak0nb7OZdN9aw2/f9tXaA8OA0nSWe8rpCQDmpxC6v+HWDPLPGorIJkIgY66mGJasj4bCOzKpc+rdSktIMfHeR0Suc1mMU4lBYE8JyGUoUyZHeSHZ46O8FbfVaqXeZKGDlPl8gtOcu15SCKmsfGOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767195; c=relaxed/simple;
	bh=GUa8F8tvSu1zrWnq/Y+87Q4YjenmoaFUhQXLcSGeclM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNuCuxM6xuKSTwqoNG0gvzMw1WhjleDhol06cMkZ6yyyR5jQGcmYUoFFXFoQFekx4qKJwBORQ3BS4QyVWNW26VugxmGQZJnlpnzH3vT1mMJKKreu0Uf1lOKGyGLMGrElJIs4PNa5XfugHbAihGvAZMWfhRrDVP+F5Rm4mjax11E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=gJP3dpas; arc=fail smtp.client-ip=40.107.244.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMbKRFLrbqpESrG43XBk2GRHFZKCaefadkgop771J8winMnwSqtEhcQI3+qTD48TJP9u2miJiLk3KG8BFhSb7WltBskdTYZ6H8Bx5J3V/WchASVrES/CDWLQN2tZPwxGKdEGoYcVJxymO062/M5WOpSWi2E5JvG6A7WfIYxIYkdovFRRolCmkJL6JTH900jOIMc+rr3r2m6juG5JyJu7Lh0ReIbmGb0LpVDQmRufrenmvRWKkK7OpRhHzcTRjmEkaByfkS0PP3oiYdPkhng34f+FonSXKY5v9uLIFlgZlflgJ4zpjZp0JjwDs1Kw7q446RFHitmJQpI8cQMN0cfP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgBVCcmHZZXG0EomBUksXFnxWDYrI5P3oecKIkhOHW8=;
 b=kAxcWikwway/UGJs1xwYy8ksVGzA7hlAaThBA7GtSaDX+NnjyzmU7Tn6+IqpKv/BN78janiarp9WgF/t/Hb5YTw0Rm9rxr2UMsMwjn3xuckEnm3Pjt5DeOu3geuwEUojs4bYAqVyCq0i6H0I6UqjRIdxL8uhUqDB8hSb146ohe375ij5k+eQjIYEswb5dVef+IDdsEr08x9bPk6iUh4rJ+SoOigCB0G1B0tp6USarfcKYeCEI7hBBeMPQTIoZt7gTkQGQPet1W/90Ez/OqcUcoqG/wnB4qFlcPZgdLmEoxZlms/i65iGm6DlvfcyCyos/6HQ5rhENrP+yLrS2oWG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgBVCcmHZZXG0EomBUksXFnxWDYrI5P3oecKIkhOHW8=;
 b=gJP3dpasUa4h3Vh1eY2mw7IZ9ZjeJ7U31PCVaFxE7BXzdB+YE+7MwarLIbCH+vxM7JEpRGkNc1+LcCu+1Jho6VFjhfRXefoeVjmEBwm1tpail89hpO9iXZozhI9EYpn8k04JvMkYF/fike3+VL0EN33tK4HmsjIU1/jW+s4rq24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by LV8PR22MB5551.namprd22.prod.outlook.com (2603:10b6:408:232::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 1 Oct
 2024 07:19:50 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 07:19:50 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 2/2] Revert "arm64: dts: ti: am62-phyboard-lyra: Add overlay to increase cpu frequency to 1.4 GHz"
Date: Tue,  1 Oct 2024 00:19:16 -0700
Message-Id: <20241001071916.1362213-3-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001071916.1362213-1-ggiordano@phytec.com>
References: <20241001071916.1362213-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:610:38::46) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|LV8PR22MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: df5065fc-b02d-4cf7-6ac1-08dce1e96fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fgoCGAvL0bfZSJGL41YlmfWvIoBM4Y5VuaqR5fIfAaWqswpR98tkmOT9MLD7?=
 =?us-ascii?Q?IUrrFCAS8OSkmepGHuOvYy/q9DQAFX1TM5ugtRBPbKgmiPRH6BEAc3jfoOBH?=
 =?us-ascii?Q?Hz/RLP0lqX38/lxbHq3nEvoaNr+rzqVtNBtApg7ZcreijJvV+anWV7zIUVGq?=
 =?us-ascii?Q?BCJmpKhM+HDZCvgYYA9fw/n3d6IENjtMF56Ycns2MLl26UvYceRa5eZtqjHx?=
 =?us-ascii?Q?mi9N2QAlwy4D8uw10R+UaZ3bNZnQZBYFALW+d7l2KRh50/NVMa+HQrnz8nhh?=
 =?us-ascii?Q?eM5qjLZJBaUZxF+MO0afuOYQSdim4vSCJF9waBP//2T4W45hKP5XqDNC0WxQ?=
 =?us-ascii?Q?54SSzCk5tO/nGuZLzq5EJ7XN2xfRHMojfZr2PQwlYf2StM+hPbldMyJPc6tA?=
 =?us-ascii?Q?J8QIxAdVVtmG5am0uUZa/MckgXfCkDwPxnhXfIwzRwgI+ety0iCh/bg1Xkb3?=
 =?us-ascii?Q?zH0+LFrbh+5SZmpOSHlFCjpr4+3CsDiEw6Hd61NU1E/yhJKHSmIBy/AU7ubR?=
 =?us-ascii?Q?fa8VOPqco3zHQYpE7y00R5ibXDt4Ruf8ZxwoKKdGyjbvcXOEv73Ukpzclky6?=
 =?us-ascii?Q?lljqq2/8TkmwH/6CR/Wal4c0rCIVeg4HfwxjolSH9qM2SL/LvojKMyWCiHR8?=
 =?us-ascii?Q?Rh7sjA/Dbmzam5IBLTnWecDc9UZ27/t/33x1PiTPAr/0UhY9FMUUgBdENeY5?=
 =?us-ascii?Q?JtocnqgHTzkTTWFjaPRItyXMuJq4X6HhD+qaucf8DJ4kBiLHiyFnu1r55fpn?=
 =?us-ascii?Q?GoSrL/MOaHr0seVRmnRNooxdsZWhwb5JiGbS6F5nRXdZsQUy1gzVzp8NIIsg?=
 =?us-ascii?Q?6Y2MmL+XoZwgwZflwc3alCA30veLE5Yyy2T1yK2keyPudanzSpH50qMmYKB9?=
 =?us-ascii?Q?sOEoJ3cjLJsMzwhCY71oyQIYWiDDfF+4ZXVK1/G3u59RwrLkqyXZ9hGkx2cl?=
 =?us-ascii?Q?MiK3dH5XQIuY1o4ji0fX2dGS4tIMlYMDO6G+EjqzsyRKNZe8U11QGwD/BL6c?=
 =?us-ascii?Q?vKpzLHcL8ZlY8/k3SvOMQW9/+aNqt2k/42bip9DenRnmaVatIoxGS9GH5HI1?=
 =?us-ascii?Q?hOvvn52/+DvAH5Ps5ldplgXvZ7daxA6xBKEGhaR77Cn7qUqrbKkNE4nU5QAc?=
 =?us-ascii?Q?ZrmUNlrfQR5ZU5K0wSpBH3QHJB4yMwlqdBg0iiLryZdx84kIaBE2O2l+1pTQ?=
 =?us-ascii?Q?d70ltscs9MU9X9wQWMJJbJu/dEpxi8li6Slyr+dW2Nu+9crz3MasNYiXwHtA?=
 =?us-ascii?Q?fbH59NLV1x03HXub5YSzL673toPmQSpBLcrcYhtGEBlbntQ5mb69QoGw10My?=
 =?us-ascii?Q?6Giuj2vqm2WvQK2+ao9kS7f+8hAYVJ3x5CPAv3Apmtc/jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbf2/QoP+zqW9YHAX/OeDUZkYZzQrGnvNCf4kEmBUKEgbHWwTM4pJ4Vz4Jx/?=
 =?us-ascii?Q?aGwsFmZ8Xdyids5HS+WZ5SBHUxXJrxKQkvdV4vyrek6QMeC4YQseGEhC5+Wo?=
 =?us-ascii?Q?EEMTZJi+bx2Qasv1C1xoi26910jHK44KQgJfNebVCtrUZwgSk5vnsb56QsI8?=
 =?us-ascii?Q?WX5cfiU49r7k4bS3wp37iIYANKn393JZJyJ7jrHhOz5EsM+eBNECelb7M4Ef?=
 =?us-ascii?Q?SrU2cdNR25EKvtSan5bnUAbELvnKzJIyI/HyDSZFrOjGGWiUGMzNA71czrMO?=
 =?us-ascii?Q?l+FufLSfrPiRqjjheYQKEiH0+ajW/308UDsgYfAjH8yX/9JNlwXzLzoEx7UB?=
 =?us-ascii?Q?dSxDPfS9Un8v40S75jC/mRQb9C8ZVSR7nREfxUNNNCVtBC3bTikZUhbLrX2d?=
 =?us-ascii?Q?HvxjslSQPtJpypbHuOMF+/uZ2ZJv1xZyC260tpf43oN1vggR1R3YbkTBw+vJ?=
 =?us-ascii?Q?bBwqRUuhUpbiSLsd2Yqwz6gjYcq8zWW3fN0lKn2AbUY/WJOBWS216ilUMnTV?=
 =?us-ascii?Q?emc62iOwjn/Pz/90BhUgMqURv4oSUzs33efJZbWol88Lwy9RjHI3QVx81NjZ?=
 =?us-ascii?Q?0saQvbrQM0QxJgIQT1ngTEbWgKCLBAiuNGYX8Uzdmdmj9DOWX6nmpLlD/JDE?=
 =?us-ascii?Q?242dD4h4+Sll4Rsg+t209B9XDiY8uL0u7EMBzLgafQBWDwD80ANCcIdA9TOW?=
 =?us-ascii?Q?QOhXduPT1M6CbyuugJSRXv82z8yMw152nRUNICauLViXJn4z3GKVI5qXabUt?=
 =?us-ascii?Q?4BfFkD/O8r0FAXmtX3a9zMx4a6vU3FCZiPoUfU5HFj5F0E3dS48vIoYeioM0?=
 =?us-ascii?Q?/Z/cRi52XCKcCsE8YdR/vyGqfq5ZXxlcT5hPRMNXc8KA2YrE6PrIClJqppro?=
 =?us-ascii?Q?nxQYr2gOWLDZwuwE1Z7YWNW7dTTexw8De5VZSKDkzhu+umnV3hprPd1MIdIg?=
 =?us-ascii?Q?ZakImsFGRFXTLs5KwuJIFMiy2jubjUpu71cPj44T7hp0wH/7/ExNUcLWnY4g?=
 =?us-ascii?Q?DhdFDAzLJbyOzKC6rrhwfrxpvcarQZWjWrGQgzo/Noa8N0TDhX+0PuPuHxSx?=
 =?us-ascii?Q?qX5fYRStw9eS971+BXuFMuY9ZEWBHJAEY0G7iayCW/dCoqZku07KBj0BXUuz?=
 =?us-ascii?Q?ajKAmB2kUDJ0/9e7R2+TZTv94rVB8LlQBoM6bdaXTUqJJoq6Z/9THTWqkY2q?=
 =?us-ascii?Q?GU9npHWC59er8of8xxQyqgkDbFiS+h71Xo0zHO7Y++nU5L3WDyqAX9d/X7l9?=
 =?us-ascii?Q?C4+oh39q1+Z18GUGVHu9vCshMTyHhu3P01ZwR8cnym178O2fLXpBx8VCEbxU?=
 =?us-ascii?Q?DPXkSpC1ZWhoc3waX5gpve8C1zsRdPDgABcplAETNYVlQIHd+pRlufYJB3Ca?=
 =?us-ascii?Q?RCIoeYsnR14KV+aj7/7F9bmCW/2sFtQyosqhAhEhwr2Ez2DKEMhpo0ipyoDT?=
 =?us-ascii?Q?T5w2k5oh7WPD4n+J8YURiNRkaZHvg5TCXI9pJfsxsL+LTAtI+zbsPn86xegz?=
 =?us-ascii?Q?IJ4h7ztUrV2PGQM9OjskNpJhio2LkLpIpLeWxTSXD20wOEkysb7c/H8hAbCW?=
 =?us-ascii?Q?N0pARhZ7pnSQiJ5Q4SxheijbSgr0PqNFtAGkiE6r?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5065fc-b02d-4cf7-6ac1-08dce1e96fc0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 07:19:49.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQaecYIq02XA8wqWL26c8cLKIhOPhIHU0tI8Yc4oXaeRnaNo63eLfBHZedA2TnOYqL4mAvQcT68U7kLp8Naavw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5551

We now configure the a53_opp_table to include a 1.4 GHz node and set our
VDD_CORE to 0.85v in the k3-am62-phycore-som.dtsi. This change is to
match our PMIC which is now set to output 0.85v by default.

This reverts commit 7a5775a3da906dab059b8de60a2b88f6016cb4b8.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
Changes in v2:
  - Use git revert to revert the change

 arch/arm64/boot/dts/ti/Makefile               |  3 ---
 .../k3-am625-phyboard-lyra-1-4-ghz-opp.dtso   | 20 -------------------
 2 files changed, 23 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e20b27ddf901..44052354503a 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -22,7 +22,6 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-mallow.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-1-4-ghz-opp.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-phyboard-lyra-gpio-fan.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-nand.dtbo
@@ -124,8 +123,6 @@ k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
 k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
-k3-am625-phyboard-lyra-1-4-ghz-opp.dtbs := k3-am625-phyboard-lyra-rdk.dtb \
-	k3-am625-phyboard-lyra-1-4-ghz-opp.dtbo
 k3-am625-phyboard-lyra-disable-eth-phy-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am625-phyboard-lyra-disable-rtc-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
deleted file mode 100644
index 6ec6d57ec49c..000000000000
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only OR MIT
-/*
- * Copyright (C) 2024 PHYTEC America LLC
- * Author: Nathan Morrisson <nmorrisson@phytec.com>
- */
-
-/dts-v1/;
-/plugin/;
-
-&vdd_core {
-	regulator-min-microvolt = <850000>;
-	regulator-max-microvolt = <850000>;
-};
-
-&a53_opp_table {
-	opp-1400000000 {
-		opp-hz = /bits/ 64 <1400000000>;
-		opp-supported-hw = <0x01 0x0004>;
-	};
-};
--
2.25.1


