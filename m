Return-Path: <linux-kernel+bounces-351503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1042B991231
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888D61F24284
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB6A1AE017;
	Fri,  4 Oct 2024 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="hs7xmFRU"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2123.outbound.protection.outlook.com [40.107.95.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94714A4C6;
	Fri,  4 Oct 2024 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080048; cv=fail; b=E1gmq7YbMTmG1aRM6gotegRx7Pv0Bohb3Z91qcOvedVGCbXmPs+KLQnw6zn2Xt7V0DI+uIFbQ/uUCyXW5Mb1zIl5DtKB6ZS5dbg2URY7iefMW/WzXCxIx0DfiH99XEHvAkHg9OjzmmIPRcEHUdr2hxSurqRcxsqy28DKu06bCjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080048; c=relaxed/simple;
	bh=k7ep0iRG2Bg856J6G2frsd8mJf7pL3MIxrsqHO4alF8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZkW/NhbqleW/qF3nuZlGM7FVnAJaYPDjzrhlavnTVFQ5XaUxRHXJYD/L0zSGhdUR/jt1C8j4pGrtEX5icQvM3sdMSHNnz19wtvtDKth5He+3e/6U/j+TASvdRxW7FRHIj1hxn8ofsj2y/adpe1G0tqDjw3jFDmvFEv7Y9kBPl9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=hs7xmFRU; arc=fail smtp.client-ip=40.107.95.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIpEmQpAT+mpZoFHeSKcFCZ2l/5kouG9Eh4P+PPYEZqTakarQkVSnYrac3LdiBYSutkVmStiAVgBOWvTg+kmxdzLoHVrcK0Yl3yCs3dLlPcQ3Ohq7wwbjqMBKowZALnCLqRBKVHHhprtMZUjNzuPc806cUFRZRQjiLwGSdha/3jERprVuXdD9S+fj2PsM9ALNYqnso5IiNd0tU9QHPzqL1uZBTFCD2KRiCV0iBXqJnbvKtWpLYM/hhuVUOUCBmn/2BL77FfsVKyyY68OxT2RdDtGpSifwxcAZTaI8veYdolhGoWI4sYz4THLUXfaZdnaW1dihKTEY5jrXNpg9/3Q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umVWZy+HIuXXbu/a7grHas7wg8FccBadU+Q8F90lj6w=;
 b=MV68+J6dVmMPz7Ok4yDZ6tpmmPpzjDYUY/Nj7/gsRhjo3FT0Cc4aQ7u16P5h738Y9rMKoYeLlzTVQjz04A95dferxsOF8db3DZbGK5t5ba3gPszaTgYaPDM794pxM1EIVduQe1fEfjbWSvZjmu6+xLMICj/oK0cHXGWlq3UtPE+rZLgaW7UMrf7kGa3PpaVUe7FDn8wt5NY6PXadnlGQBsg25mAApw7FNKq+9k5Vcc0Wer/SwTCo9vKYxyNY79xedRrzhWq7ZFveOG5WkUhOcxhRFc7qC6zYmGcBjNI6iCE+WFMl3PKW5ZKW8JsjOwWDrB2/1r7PsnKai0imcXR7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umVWZy+HIuXXbu/a7grHas7wg8FccBadU+Q8F90lj6w=;
 b=hs7xmFRULmuqhGq/MkYkEt0+n4/O4uMelbx3Pgl/zHGQo+qHoA4wKJnHUJZDjXdg4mBTrFbh7zKEn0WvJ77l2jDOXQRB8PWG/0efeWdVEikrY2a6aK6YA/wJFEW3H69zIw+godE8lSm9sYxWE3WEVwygKnBeLV6aK6+r579tE7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from LV8PR22MB5389.namprd22.prod.outlook.com (2603:10b6:408:1c2::21)
 by SJ0PR22MB3974.namprd22.prod.outlook.com (2603:10b6:a03:4d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 22:14:03 +0000
Received: from LV8PR22MB5389.namprd22.prod.outlook.com
 ([fe80::e13b:a158:3ff2:8174]) by LV8PR22MB5389.namprd22.prod.outlook.com
 ([fe80::e13b:a158:3ff2:8174%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:14:03 +0000
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
Subject: [PATCH] arm64: dts: ti: k3-am62a7-phyboard-lyra-rdk: Update ethernet internal delay
Date: Fri,  4 Oct 2024 15:10:49 -0700
Message-Id: <20241004221049.1155022-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:610:32::33) To LV8PR22MB5389.namprd22.prod.outlook.com
 (2603:10b6:408:1c2::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR22MB5389:EE_|SJ0PR22MB3974:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f99f1d-7010-4ebd-9d07-08dce4c1dabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4YBfRPDLkJdOVaKc/2v2/cH+OuiKOOR4r/s+USCR4SW4v3YB8LquWZBC2GCc?=
 =?us-ascii?Q?0c3+8R6/qJ+HmLyjKxjMveKxQwyIay8hMIM4s+S2zaZ/5m0WAauizZXVwKpD?=
 =?us-ascii?Q?CEBk1EBrE2FdUp8O/cFTXY5xmediSezFwqZYwalHSQDqIBU9OBkU8EEX/UrA?=
 =?us-ascii?Q?6gUuvJBIKTKq8aN0Z63sHv7xBQ521mMwLOhRepE8+Zf+pufAAfcPW2Eh3ZJa?=
 =?us-ascii?Q?bKcWKbi+wkB+X5wiw5BCZiZLfDHCm8LjSlqsTbQD953Mlhi10E+lPwogILPc?=
 =?us-ascii?Q?7XyBJdpO+0n2o2uFUzjD4t/sWgFnWlNe0QDwI/kgyr7TrQE/1wHHxbxARa+Q?=
 =?us-ascii?Q?MJh111hOH+rce4sxxWCNCDni/Q4anTI77HGqhdvK5hkXFcZd8AmYzgplyWzj?=
 =?us-ascii?Q?XD6+CFF39OIsf5HRpwS4DEfjUSg161IKedQZYXGjxCa3mS4fREDF/VKEZNpx?=
 =?us-ascii?Q?sTOQbwvaWsbAILZPf6gDJJ4+DVmxFV8tHIep9i6REMjxoql3nmUK18ymcgpG?=
 =?us-ascii?Q?+3TdqxImFK6dinRvHLzqKjlyS+ru/35ZJTaDsJZnM08Rhre3/nNKvjO6bkQz?=
 =?us-ascii?Q?/38pxhXS/jPfjJmeR1oBZEEEjGmLoXhCLp5HGvypGHXXQDICDI5kXRKgu64b?=
 =?us-ascii?Q?9Hi4cVY0e6UHb7u73fUnwBYF+kwPaslxT4bY560qV/auXdejR9+wGxG0Sxjm?=
 =?us-ascii?Q?+RkiwRibu/G1Ix0ke5cF4iXfHIxM/mfG8I6dysBEBoPKxZ5MNMnyC0reZNCt?=
 =?us-ascii?Q?8Osln++Qcruua3ptDoBoEAJ6xbIiXs694IkXDghZpIh94ud4zH+P1uF0jRmO?=
 =?us-ascii?Q?o+qrWfYUib9rn5ttmnpq63NDz31hs9PLjjsbegvrRi/hTkjdHyl4oOxAtzbD?=
 =?us-ascii?Q?8bBAEF4NgI+VGiDgsTD/jcHNUTTl462bVZx1xyDH5C9HEbY4l53eWuN5U9zP?=
 =?us-ascii?Q?1qFc1p1NPRMgrVLl63aZESDg8IQJQmdT7/HriTvWZWL1AmfQLA4SHdigUh1S?=
 =?us-ascii?Q?Jl+dHYRZ3FryAzmjZUjlUTNsPdg5737EJ9Kdrqq9n1gyBFxvIqVN6NJ3cL0g?=
 =?us-ascii?Q?Bg+s1pLl9dHOGn4QR/opvg0n1Mmf1FTQeHVFeEDozmKvAvMPBLJ6CsEvjBIY?=
 =?us-ascii?Q?TtegOUJ7sTCWaESsNActXPaKviUOEpQkrLxgK0z4PniVGQK0ZTuOUw5ItGKt?=
 =?us-ascii?Q?gckxtTa72qrIxN7YTaoUl+bBKLtlVA5vCyRNxRitkTbSBzFMfascLupTepbe?=
 =?us-ascii?Q?TR0XfPUh1WTmb9VNm017AUahMKLrzk1RjgSPF1B7PxTsfVQK+Uyan421Uh3b?=
 =?us-ascii?Q?F27MgFxEW0YohhqIdRVs/qmMTWw1s44CvTgTwZByzbUkxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR22MB5389.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKgQLH/UmfrnokhlB0jM6RuXD7PSEBEUohqFTPfqeX4fxIMcDl8NPWTOa/c1?=
 =?us-ascii?Q?cDTU9qJfzhEz/uByUMBGuiIqgd6/wunu65HLAPGLh/LQ4vQxJWli6SAxRDaj?=
 =?us-ascii?Q?/0QoMRUXpX/D/ekiWGNexrIC3zSQz8zLQWXB2uMQCDl5Gi2hvpU3azZaWqVb?=
 =?us-ascii?Q?6gSsaYkwXlOR5aznbmwHDI1qhhQpm6onEfjKlFQA01Wp4UN5dnbK/xT7NILl?=
 =?us-ascii?Q?Cv4BKn4StaPxEJkveu+Xy1lRbe3sBaGGJQ3CSWVFdrk/mISlNqhZ+OwNdjxM?=
 =?us-ascii?Q?k5aJCZtZJEoKtSf9zjGfSAIRgJc6XTEqlq/9ii29GhoNQFlxFxw1YlDSFJHR?=
 =?us-ascii?Q?PqiNHAmMbe4BT+VJ/gTxTA3893UCVMwMP/bbg6x8Mq+OYnJSCDEi/Fpppl09?=
 =?us-ascii?Q?4M36bm8/xhIW7kBmGf5HYg+La6yR9IbKMErfD4761PHr9qCPdXnIGgPHMVhZ?=
 =?us-ascii?Q?TYe8Ad8vUqTYfVHMJ8Fv/tekNATDnSPAPtlQeNLSZJLkMQgVT3W+mO2jskew?=
 =?us-ascii?Q?fvpbZVKuqH/P5+VjeWfEOHFGprNv1crYbGH/58+v/w56Vqq3D7Y0AsYoUWvR?=
 =?us-ascii?Q?nB63ut/XDDhTMWhgs82nstN70qI/tRc6E+ci1Sa/WQMudNWXcUmqHd/llrPB?=
 =?us-ascii?Q?cl0vx6PR3ABHltJVdOXfck2NtTNIOz4UzhSIE1WuAd1bqSzbxvlEyR0IMtto?=
 =?us-ascii?Q?FBlJAJk5Dtx3uHL0FaxNwe9XAdb7UsgA2n/glLfN3a+rRFNt1CJVZM/ntM6x?=
 =?us-ascii?Q?wHmfhNsYSEToY+J/Vvo/8pPMRCUHx7+/BiYdBC6ASla8YDVwhaDofu8mPN3x?=
 =?us-ascii?Q?81hVgmrQ1ftDzDT+KIklwcummjEA3EFJV+0IbfSKP/vaZFFv+9v9a7pUzip+?=
 =?us-ascii?Q?vLWXeI+twIiDb6uqIbP5PljKXevu6cU1Zk07mPGyZU6I607gGc+zMEEaPy3W?=
 =?us-ascii?Q?bPxBI0zdgx3Ycka5QUZWrlx8C9Mw+ZNyR+jFbZ2W4TeW0F2FyGU2NG1loAi9?=
 =?us-ascii?Q?YYIutHRlYfHX20lynY+d+bMgAvr17/MW9p15zGlUPxUVOJbqMDh3JRpiVXxh?=
 =?us-ascii?Q?0wcGXJE1dCzf72LYQuqH96WjssmIHiW8VfREgD3MunHDo2C0s1g6DMdfCWR4?=
 =?us-ascii?Q?2UV/pXhzT8mTwwJTagFxdmkUvPWdWQST0Bw47O32AC9uJ0NcqIEH5HnSkAw2?=
 =?us-ascii?Q?I2d8ZnSwUlmUzEAhoCu66zZa+FuJvIlytZYhpn2P8u7d3a4P+K606ZEF74WH?=
 =?us-ascii?Q?uBerZlkmUz5Xq6oXFvjJbBS9jhG1fZxDowB/qZyKI75fg6g9yt+NNCgUJrO5?=
 =?us-ascii?Q?3d60hOy3VRpiyW4Z9hcJ48H3z6Vv13B890HCsUqNxlJeuExDggKOlOOE6Ctn?=
 =?us-ascii?Q?yX44BWzw21yfKgwKtq25ME0RCRTLwO7df62+80Hz/mARM/Qjuk6TYwQnaR+5?=
 =?us-ascii?Q?p98LZmBtDMN7frVR6L6knBRhQLaz/lepgaxIAPyeJZYx6c+Q3y25JH5nGcNv?=
 =?us-ascii?Q?fiyoIkqVBVok8dqHAGaULH5YoLwk5E4XSV9FyFFuRnTTXeqrzSUcUNFIKbyJ?=
 =?us-ascii?Q?+x8CPFiC0orQnWhzbqR3XpgIJJAh6uXU/R5BCOYT?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f99f1d-7010-4ebd-9d07-08dce4c1dabe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR22MB5389.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:14:03.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVZmwZpCZrZXQq2d1lriuDfp88m7+OzB/no35c5g9tL+ckfUGYVL4ZpkOrPbmS8lbsgWipzV1CrpZz/uPEMIRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR22MB3974

Update the RGMII delay to 2.5ns to improve performance. We use an
additional mapper board for the am62a7 phyBOARD Lyra which makes this
delay necessary.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
index 3b93409b23e7..77e5fef618ba 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
@@ -16,3 +16,7 @@ / {
 		     "phytec,am62a-phycore-som", "ti,am62a7";
 	model = "PHYTEC phyBOARD-Lyra AM62A7";
 };
+
+&cpsw3g_phy3 {
+	ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
+};
-- 
2.25.1


