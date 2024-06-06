Return-Path: <linux-kernel+bounces-205164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9878FF842
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2CB1C24A64
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8CD13E3FF;
	Thu,  6 Jun 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="WgcEWwKs"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255484F5EC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717323; cv=fail; b=H2QI3BzNbXtbH5szqcRHQUwgyCBAyPR/itGzcNSv89zWjL5n/ab3hKKFuO8ZBGyJ8Cmx/QxQ+88mqvdT67XZJgQ9XIyNLOta5HNNiwAP+vz8bl5lAcZu+hgqaWqI/oMSmk6S3Qv9acxKa0WV8AHFSU5i4d4XP8R4udcqjmJ77o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717323; c=relaxed/simple;
	bh=2kMrQ8y/jYXuaCtM/Hrud7wvkKCSn15WI9LksWBXwdw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KylezSUwKRkxymL6ip1hy3gtt71N2e/CTBaOcRSeUCWdB/7zV1AgVvfhQqHDMda8A78sGs7vqY0cwx320Oyph1FU7nw5pCLuhkzT1guEtQEW3FnKGpU7FOVbYfyTbyIJacwyREqfY6++TcyxzIlcqRpkZkbL9zEk8ASyN40QSzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=WgcEWwKs; arc=fail smtp.client-ip=40.107.223.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYCYhcPqwNkNEKRm7XgP1K6GcTeTq9n9rKACLQPiIJO8txUx/ofTHNYOIrX2Qyxg9jr9H2fy1ZUA0EvgZ6FEeuYuV5T3umaQnC/oH63SfKiNrFgc5NB4Wnrm4w11SSeSXC9xlK2OYoDW3TPdW76kHfXrjL9hgAiOahYA78QifhNlf20LSmBzGFNXH/hwCadAk6SZGlqNw8T6vRbG8KFRdbKLpXR+aMrPLpPLk40Ue/UGHmgvuKFiynFGlDPhvgr5OOPqsVbBhNRAnijiZZxL9N34vpM4brhPJAeBtANQso47hSQeAD3n+olwvRchq82T62HwUc3w+NaX4va4kWwdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29poo6YadLuV+7+2M/Jp4fgFaYRKPq0cMXG8risIO20=;
 b=Pzrf5JyDxeZD7Vw5s8BFXMVhZeL2WbiPRUjMVZGzXdhyI5TE2qKRfDsbKgmKQOCQclk8bEVTHKIB0TuxGeutJ0rpRXSXnfx/WMzjQ6GwXtvhO72LOqHEBN0eJiSEexCSDbtbqKXoaaCAMNpfTMP/5W9RqIa56Hh5LnsWszLOslfj8G235sGqQgqeVnT073BnQZQCUbCuLeXGx1zEUIEflCsi6ToXcBnS2lU3p7STG2fAZq0wOW258/hGV3Cp0JUI7jwIjnWoHtdUS/iB+WpF1Tedfb6rO7VEpm7QMgVjf/wd4iiwZrNpIf/II96Ry6AK7QoI1ObFos1yzyRzKecIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29poo6YadLuV+7+2M/Jp4fgFaYRKPq0cMXG8risIO20=;
 b=WgcEWwKs6HYQ8nArvJH9oYUfYnrtOsaXrahaK55YzR3/NAvO2McK5uzgSCFNqESR6jXleu9tBNxw+P03IWxGIfSmrHNsEloiy6DFgmuA7pR4FlZHGL6bGhkeSbv0Em0JKloonnpcl+J4CxDfE9sUvTP9MFfuqJPoj/JDdceNnpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by EA2PR22MB5380.namprd22.prod.outlook.com (2603:10b6:303:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 23:41:59 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%3]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 23:41:59 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	krzysztof.kozlowski@linaro.org,
	konrad.dybcio@linaro.org,
	shawnguo@kernel.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	m.szyprowski@samsung.com,
	nfraprado@collabora.com,
	u-kumar1@ti.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	w.egorov@phytec.de,
	upstream@lists.phytec.de
Subject: [PATCH v2] arm64: defconfig: Enable TI LP873X PMIC
Date: Thu,  6 Jun 2024 16:41:45 -0700
Message-Id: <20240606234145.3311068-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::13) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|EA2PR22MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1abb38-47da-4e33-9639-08dc868241de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MceUjGAzw0bKrlhrhqEKrxP8I4/Y3p5EizbLj/ohjYOjldtZgtG9ZjuqXA3A?=
 =?us-ascii?Q?nigiglC8/4W5pYIuwJeKdZbZHQNa9o8mOZbg7kCYx9GQrVSS7KEUhT8m6PHQ?=
 =?us-ascii?Q?aC/p4Kn5+FJFze8kxC6Ja0BXf2XEMuAqkN3S9sCd2pQotMEPr1+m2MxT6Hj5?=
 =?us-ascii?Q?NufEDvOgbu3tY4ytIec1Otxk5miyVRo8nPEcgV/5VllTuWOj6OE+ObKCTTPy?=
 =?us-ascii?Q?60AVUqvYca3i+eQ1G0eYAk214gVlpC+LebZP5ejludl6WQgBRZhol6wnBUgx?=
 =?us-ascii?Q?VHJwGcy/OIiOikEKWNB4YC3Z92LyxwmnBlXu76FFZ2OVkAAN4IDh3/MX6IqM?=
 =?us-ascii?Q?4di/KzvYFvjoQhxNJEEqb55CcNfhrpnoiPvU2I3MQmkurPJy9OK/q55sCQFp?=
 =?us-ascii?Q?sNRmM6+QTklJdASVuKzZiXP/c0BBxQUB4nnIaOAWMvuL5z8v2Ra6jubddiUm?=
 =?us-ascii?Q?hghXaVF7bNMTfWEIAD1TYbWhTc0CQ3Qazz3M7BBWyWNL+g5SdURhc5s8R2XF?=
 =?us-ascii?Q?wVFU6+nxtcgFkNYAlMdS/IRg1VuDhF8R4+98v5kznWhF9d1dsClPwk6pbRY4?=
 =?us-ascii?Q?G81Umzl+jUgfjkCiDkuMZFm9/z9USltk4yggdjOGbAm0zhJQBr6xenb2Cak2?=
 =?us-ascii?Q?MYEULhmhZIa2/JcWq4bMOQ/Zoe/xS311Uay1IugWQlW7jH2q81kXZ3rQYz2P?=
 =?us-ascii?Q?RezmBDDfgHYyMAFZ9oIYE33nXgWK41a+oGzg9Cy7nDIuKdSo4iv2WUF6qY0/?=
 =?us-ascii?Q?83Hu/HPeNTsTLkLUqWBLR08d/isgFP/KJbaRf0UqxMKL+8TieUq2//dw02Sy?=
 =?us-ascii?Q?NqwOgh5BEaqxjnF4ekkksksRCyBPPPoV8+zffw8aIzFAdBoZv6gw8+wgML7n?=
 =?us-ascii?Q?mv43cd2f3/0dt6AgRuYAYE7gVmz+/m6hKMrJXcNA8QdO0IYegsJmQ65bGsbo?=
 =?us-ascii?Q?XEqQB5Cwsfo2osX3kDe4eijTKws/x04UIA6peKPm+FliKU8/sxUowOMsQRym?=
 =?us-ascii?Q?L8M/Uy2ry4ifro4ZdJHHL9krdHJpoCxo7oNGBZW9tJo1ALBL4GYbO7peXoKd?=
 =?us-ascii?Q?Pnv7BA4qgiUFUuCG9RGipkqCsLGzgKZ199lCXUV1ZFT02loouxG733T0cTM6?=
 =?us-ascii?Q?31QgQNNJCxdUmLnkBx09HbmLX85CoBokev1/QJQprMafrpL9YSLv2Tumri5V?=
 =?us-ascii?Q?umdPdku+cdqmvHOmLaCDXJT9Iygzr91souvWXL1QwJVjmPxTBhdBddcKn5rP?=
 =?us-ascii?Q?5H+ls4+f6XlNwAbyT5A3n8TTU9wP43srK00fvc6jRi45tHMcFEXWYsYPDXnj?=
 =?us-ascii?Q?hGW9cgSzyeUcJWedY/CdagRyNrg+a7bAhe8AV/Ah+Jo8ta0VBWHmty3sBGdG?=
 =?us-ascii?Q?rrK0cFYMPXexOpuf0JHIxdhuSbdn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ypzVDN8+xNu3og3yIdZc5FtGI9ctHeq6Tku/bd5DoVRsN9JrzS6TUAMJPql4?=
 =?us-ascii?Q?yCDcdHt5oGlLLuig1COHTnO8+2K4iODBmfVzOZsATW74afKOeg+1QUYgeLWL?=
 =?us-ascii?Q?Xxw0Sa6jTakC/w9LXFDEv9Xdu433lBVG/488gGMIMe11HlJVB4h2s/bXigx6?=
 =?us-ascii?Q?nwg/YnpPOc0Y1qS9UTgwuMPo01KlYkAFQ2gjUIr+mbpEIuRREc3g985blgi1?=
 =?us-ascii?Q?oc0BtqnqO8bgUJV7vkQ7GE+TaRYfqWh36F2SMpDI36n6bqhLbJ8mqlI/dt8C?=
 =?us-ascii?Q?Lt2Rlt+t00hW3RkVRvYGpqxjukmuojRWKZDkUpPTXVhh2qGLHgaLJel1/+/Z?=
 =?us-ascii?Q?bSi3vDb7jViqCfkiSanI0o75mKHNozlb+C95S9d1T0oidCAmSnbRSRiR/mlb?=
 =?us-ascii?Q?rPtp/UpUXGQXIOUJr8CvgYNRimRl5Qr+vsVrAPC3cbKYooQsw/k8s1NRb0kl?=
 =?us-ascii?Q?MhF6fOfQZc4yRNpVHK912OfiuH2Fw9QoBrKXv3zDzfhLjdMdunuDj7iV7Kt0?=
 =?us-ascii?Q?LTJTZLnQfr4GiRSIlRvhKn0FXwWkiFvxIINyVsDkOhNifKxfCsNqYZEFFLIF?=
 =?us-ascii?Q?au+wSZemEjPSABe3XiRIOzMpPTMsyRvaWUIJimIm57GC03HU6RrreSYM/utI?=
 =?us-ascii?Q?2Qwn8h3+xmMqM4mR+xxiO8YyNH+IouIPPwrFtSFA7W05GzI+IaAdbBhwHDIe?=
 =?us-ascii?Q?UfqpGDEPuDCIog33+BsLRIuy/jY6dxO+xTEIM2sAAn/lAvc9kRH3V0z6ndwS?=
 =?us-ascii?Q?+Ugeb/J8JwqxrlF63U6wkuHb5QtOmrOedn/vfyeoK+obX3GYpeocISiKC2Fo?=
 =?us-ascii?Q?ec5/8DrkZ5u7SXwJyv2yhzyzktggYw0Ucs9WYLinFVbRmMbnbbGuIBpblOFR?=
 =?us-ascii?Q?3BjQNJI1dCS9fHcGP8i0DMKQYg+/kR2/9ss2Dngd65NeGMHEUo9lsfBWvfx1?=
 =?us-ascii?Q?UHVDS47SVCBfscx3fVcTN07aeCDq54FDstzyLC+X+ExidlB1HKfgo18H6M2+?=
 =?us-ascii?Q?skfhZjpfGDxmF/y1zg4j9fHRuFT+JmTmT3XFvVBOc9FL6R3Xpb/sK+vo0/y/?=
 =?us-ascii?Q?0+FKCculWWJvzs7+amv9HEQXpnRsAOdb7yT9ZCIqWfuh6WxTC52u7X2Yn5i7?=
 =?us-ascii?Q?sK+7SZeBvEpksLVIUDOAVUjsLxp4cSCQTL19/zgUbxzMfJUtGKEz1dhWuCX6?=
 =?us-ascii?Q?Ni7ikUnkYAwCZSRuw2TM1ZJxdhHfXguyByU6lsy1GxEpz4xDex+oOy4a+gYd?=
 =?us-ascii?Q?MMDggmgwyFU9jkXnlRTz1ZDz8jhNvC4JlslkMuqVYeQ2r67tpvkT1jVUJNm2?=
 =?us-ascii?Q?NugF/wuu0RNLoHWKLrOTYRtfTCUkX+zXnO2LxM5ACqNf8sqF0wHTTTjqDHp+?=
 =?us-ascii?Q?J7e+A2dDQlVXiX1tJakxetxLi67pip/Kvj2794EjrZ/bhsI/hXfy4D52yZWV?=
 =?us-ascii?Q?UugVFLUBEFw89EdG9Q20tvqlz0OA3RsPSXSZENUVnpb4AcCr3EhHQP8Bc5bh?=
 =?us-ascii?Q?dd59/vdtmIHzzb9bku9dRHZn5JTLEc2dDLiQKY9dk533NegADVhoQjJif/Eh?=
 =?us-ascii?Q?0ErRfeIkWYgU6Axgn3wYpwvSfPWodf2C8VusU+RN?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1abb38-47da-4e33-9639-08dc868241de
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 23:41:59.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZZizwcnm4aQNPVAjGTb86vbanmQ561VOM5MWquDNY/CAAepXn3kTxD1UAVKlq27+e82aoh/zkpIfuy0B08vUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5380

Enable the TI LP873X PMIC configs for the PHYTEC am642-phyboard-electra
board.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---

v2:
  - Change to use m instead of y
  - Note which board will use the defconfigs in commit message

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 57a9abe78ee4..2d4905dc4c3d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -745,6 +745,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
 CONFIG_RZ_MTU3=y
 CONFIG_MFD_TI_AM335X_TSCADC=m
+CONFIG_MFD_TI_LP873X=m
 CONFIG_MFD_TPS65219=y
 CONFIG_MFD_TPS6594_I2C=m
 CONFIG_MFD_ROHM_BD718XX=y
@@ -760,6 +761,7 @@ CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
+CONFIG_REGULATOR_LP873X=m
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX20411=m
-- 
2.25.1


