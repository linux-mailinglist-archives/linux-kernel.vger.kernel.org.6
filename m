Return-Path: <linux-kernel+bounces-172511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34908BF2DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB191F215C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095D82D64;
	Tue,  7 May 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Q1yK7cxD"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2137.outbound.protection.outlook.com [40.107.236.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF537F483;
	Tue,  7 May 2024 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124198; cv=fail; b=Tz8UiBHuYjo12ioh0Mao7lfeVbBEP7N6q1Gmau3D3A47n9Dsp34pKh85dHD6ve1qWQd5oarKaYuCng3R+9Z+kVrAeFWBc6AWBsypj4mGOL9x4rMYpeNHyBvZQOfpoJBeE5z2148+7c+U7Y7j6V5oB/jhKkZrlOHumOifSAwg1vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124198; c=relaxed/simple;
	bh=e7sm/LkTvJ5RpPPhLxqQQ2jaIZkEAjqayP/ivPz4l4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoWg+VxOA8jiTmzFW8QO8MJ+R7cDopdBGPWdsYkUM4mATugTF+/9JflhFemLajD1UQkID1Gq30pQcUzqwjRow8em4J+ZCOC3yUXktPy+r8OzcDwZgcIB0YgP0e97YPtcaFmrTdiWrzIaueQ2QRUfW3DRYVKxxip3TcsMN/qZEEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Q1yK7cxD; arc=fail smtp.client-ip=40.107.236.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/6YRhwDyQoPkBR/qyGxtZ/ENodrnWoAxs0jSkOYOP/TDYf8vBxbHrQtfz0dXL0pV2QYOPQVsj0559krMrn5HZGUbHEP0qX61Q1rwKFHjdimj3P48BkmXunpMS5dn6aCpLTdIqZ3LFTdLWURCFUtUJq2H94QAGrNqnCeF+hk0Eumwu2KjdTKUUTQ3OX+5Oawf2BGovYSqIMFhHaKT9RzTOQMYXFR0Lmkx8xr+YewNhhp6LjwA2OsKQaG5wrJ62R909JSvBfqkrsoDreRVaMGnJznQa0jFBQggWC85kxvCJ96viHN+7zQImHDJTCqKHEqCfJSCpmLoNDQ2Z2lILa10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4QxjbTNl6CXlsaKEyXbUwiORWPr+dfW0MbfS50eBvo=;
 b=U3Hejsrq7WXLD2+sdXOyuZt2CUdQqPRqMHRwBNNMFfU4iWGoahL5ywEYwbvtBH2X1bljP4BAmuVLE258thmfA3a+wBLT9fIQY50cqEcvQL/WjMzcDR7OeZMXKZ+TBE8UbQ9OtZy3hKmK5IvMkF9NDIu2s3+4HDmnDaa+ddE+8l0W2t01S7lqLIXotM1pmAL31drs1eCIlwS1VdNfYhIxNVU7GzCjkgmu0Ar564BS+y3916LgK8kyj9msNZL5NUBnLG+kHmTi6nFpJRup4FGjBt9KpbavmxsJvURzc1DlpLDVey76d4regyPNlGIBPHHHdZpHYHRcOJLaGU0tAAJrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4QxjbTNl6CXlsaKEyXbUwiORWPr+dfW0MbfS50eBvo=;
 b=Q1yK7cxDF7yjRnQssh898kGkMKESB2saB8QYKgD3YCbToeLU5kLwCRL0b3njeWmNbNyhIlFiqHD/DUTQbOp9b56anLYumaIhVYyzlB1AlkIi2DJcBNj1DNI8Vrktq8LVHmzUxzkd8Ci/yG92cM3jbtaoKIrj90hdilIMO69Lu2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by SJ2PR22MB4226.namprd22.prod.outlook.com (2603:10b6:a03:546::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 23:23:10 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 23:23:10 +0000
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
Subject: [PATCH v2 1/2] arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
Date: Tue,  7 May 2024 16:22:55 -0700
Message-Id: <20240507232256.2865168-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507232256.2865168-1-nmorrisson@phytec.com>
References: <20240507232256.2865168-1-nmorrisson@phytec.com>
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
X-MS-Office365-Filtering-Correlation-Id: f007293d-3733-4870-df03-08dc6eeca901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?trk6Ypp4Elc99txQqWsW2VfIAPVqcA7EBw1NdZWv9aqgTqt8FjUDvP/3n/XF?=
 =?us-ascii?Q?EUZraDnRwGYiy439Ivkkb5Jq+U8iYUfR77/5Mg0NiDTkKDL1sOpMpCt1hv2E?=
 =?us-ascii?Q?vnZiJZ8LdnpvFj7l42I+CFaS5HrVQitQS3UnmyGIYvrbixDU5HZ73QPcQwUa?=
 =?us-ascii?Q?fBBZdHnqw0bCcFeeAkOwgAEiHr6S/nzhKsh6tg3Qc2701DpHDf5rn/wqHLpc?=
 =?us-ascii?Q?ODoqUeLIG81pW6EQJMVrYDIUV/AalHCLOY5RtyEi3M6JSOwrPc6DdWU+ut9H?=
 =?us-ascii?Q?i23MdydDxdDbSLx7oFYmbvZaTC3LpHneqT5TysJQ7SEYNEL4xIEo2sVvTwRO?=
 =?us-ascii?Q?9c0iuAqwUDeTx4y2sZpKrSDvUa5MBd1BN2+xilW/SphfYpRpjIZ7k3S+GAWA?=
 =?us-ascii?Q?Nx8jA3YBCTIvif4WvH7qi+zmV4QW9Kmk6MtAfSgjcregynfUdSSIZOHexKSr?=
 =?us-ascii?Q?Fc9sb+2uyaNgSEizryJuMi11Bwupg8P8YdPToYe0dgMAPhU1y/bGkCe/SK2z?=
 =?us-ascii?Q?RE6C7Lg+NUjZRmYdiNXH4gjuYr29ty7Qcojx8HJnZNPkLzoynHlDUw7XfSO2?=
 =?us-ascii?Q?SBtGWx8DnAMcAytnRvpz/+n9hUgbD1HjGjV/EVNZ/iLoQp5B2TQGCbWooc/z?=
 =?us-ascii?Q?WQ+omeyR6u8SLwdAkCBYcxwJ673QQiuN+uscxzyGbamPW1aAXJXnyY0j3uX4?=
 =?us-ascii?Q?ebo2bdmGUFM4z8KwHbW5LbDUALvxA5cl9Co3Pwxjg00SK3guxlvW7cX9acAH?=
 =?us-ascii?Q?YeCQWTRiDCcOkEmHINbKUMD7DvBaWEaBvxgigO0WvsMZJ7/FZI6d+ANbVX/R?=
 =?us-ascii?Q?f7L7hrK9A8HRWCBzeg0eNabFF0Sen/VIZ04cq1muYOmTIXB2IUYnS1TKKPjG?=
 =?us-ascii?Q?3UVejAw1zcbRD3a6ee2prpF/IvsQ+oktECtp8Kpdmm03EcGt+MZSHfioEYPO?=
 =?us-ascii?Q?/v0CDwm/giv28Vj9/AWSYQ7+a6gt31NAaeSsQguIN32nIkZtIedbdcoDZycq?=
 =?us-ascii?Q?DAfjrhF6Stt3Gu6AvTMCIKCbdQesMySz8qriH7lmJwZxVYGBz77UqEBwC0px?=
 =?us-ascii?Q?vPxea7wxlmI2mRTUz+gqXoGxnqCyySBDTP9jsh7mvziZE0dYgzgF5YhtgvMl?=
 =?us-ascii?Q?odmoUzXxsQgL7zTXf0Dcz4JoAOGZ9x+fAzcV+Npzas8rEWWJs8tgZmhmd7ir?=
 =?us-ascii?Q?EyGGxHT+5agAyJ2uMT7AeCgWK58ZVDDvxDgMpxh6Y9yQ0pesv+CeYIjR3M2l?=
 =?us-ascii?Q?1f1qwd2DS8vGNTMCOt7QYdzF9crtlMiX68mYABp1qI9h2WI5B6pMUF5jVPAx?=
 =?us-ascii?Q?9P3gKL052L14IAwQTgQBLfjtlVFQjiXDPaLcHGUZ2Vx3yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uZ99EcV+31Kt2qitn9z5O+qI0p9cGUdIqztWpdXJsht9DJrfn1oGIat9lBFs?=
 =?us-ascii?Q?K+gZ/nkK4Q3XdAgp5CpQniVoDcTyxcZBeFq9lOSdz05CDk/l6Ig5YHDPuw6W?=
 =?us-ascii?Q?xYc88e6x9FIliHMr6CSnvwAfbzmA8vxtS0KH2IRcKnN0PXVD0jPlSTIuJdOo?=
 =?us-ascii?Q?2mtf5oWM2nELE4Puoc3y/ikWATXqyH/xUbWKIM+3iRFL9nlK8fu13PA7OUTm?=
 =?us-ascii?Q?zJcc4vEE+LakQP2g26LGk81dIMogR6O1l0TUejaQDi9WHc5u4PeDQkNFKUWF?=
 =?us-ascii?Q?Py82BUUqNJiFrA2zDxGQ8M7CfjhDjFXiRs/l0BZ12DTTM6mtadmj/aAwYFR1?=
 =?us-ascii?Q?OpXZkiBErHCTIKNhP98YmF2f2MHJqCu2+lO/CdAqxLXOU/xeRLTN0iQ28gHu?=
 =?us-ascii?Q?dUcsxJX65RQLV9c+gYzEoHQX7BeTlXhmgfMcgoKGxEO7oEPtxr1nxzaKY1tC?=
 =?us-ascii?Q?GPW/lyuOvehwy4NA1nYAlrVz4D00LNjDiO63xuRqHuWt8/o12KjwkenSKIn4?=
 =?us-ascii?Q?4XCRqeVWoDAnOwUtGtzmKByh6nO0Yj62rTL9ZYYTUsfsyZwKjVTIZtb3IOq8?=
 =?us-ascii?Q?cGtgMUyYsdFuGGA4hED6GmHyN6RETyIa3sBnK6imgkYrL9KnVFRxSt+uF+nW?=
 =?us-ascii?Q?GoVogxLLcQrcYKVQO1TNDuyjPAiFf01VzSN83ueVWTVw8jbAdCJymue2MgeV?=
 =?us-ascii?Q?GBGbFv7KADRrBEqvhaRQKIbtb05eFUxG98cfZV0p7rtXx+izcVLJMBi3w+OO?=
 =?us-ascii?Q?UHqcAUZizWtaQ62wrjFb6f5x5d1VLeiuqMt5KwMIWde9bjVLyGWthQVO8ur3?=
 =?us-ascii?Q?nses3c/k2O0nLlrcifUgL4f9VtVPnl1kfXHYJUM5QKTAZ0zuRFSxF1KwcYFg?=
 =?us-ascii?Q?gARD/KxTXEx+BN+2KDDJPkD/7AgsHZmKeUNRNoTomGT6bicytToGl3dE36Ze?=
 =?us-ascii?Q?lA+4+9aqCEUdC86AOw1zYIdC6GTehmfDAsOvr31/kRE+38hEHTxmrr/a/QG9?=
 =?us-ascii?Q?UkQDn43RLmHNzDQHnPcJwqjwdJZUPIoD381B4ZyGKTkBURSKlKixQyNI9qaf?=
 =?us-ascii?Q?8AzC3vKUnywsMNaNgOluxVDExLLBUbOyjbbIo7t5AVAAzjABQTH8YD2DS9kF?=
 =?us-ascii?Q?JT3w3X6f3NOcR/54kQfncC1cx4/k0NeAsyqPgIhT5LYYYOLIfKwp2nWG7tXU?=
 =?us-ascii?Q?b0Jt3TRjC8eZRChfcA5+mjqGOFTeu2bF9KMYK2PfNiEF1bjAVovSFM1A8uCo?=
 =?us-ascii?Q?6uiz5eGGDMnkAE54Dn9xm3UCM9WcD47Vr8ihp5jEDABN/7AdnAbFcLJurkzx?=
 =?us-ascii?Q?8bpywLecFbucza7VFTH1uBABAQU8wl7kz3XtKqN28MoBPTwMjzJTt/lIDUQV?=
 =?us-ascii?Q?i5Lnn6+Cu1PzfU2mbly8GadHGO8sPVib2aZspFXYrYHxFjLWpa1RDFxfPSZI?=
 =?us-ascii?Q?LxSWgr7zgve4JGUQzLqClS3WrqmzuDTp0vgV/ql0Kn6Dh/QZotfMORyehkyv?=
 =?us-ascii?Q?A7aGHTx6N45DAD1LAU03okcelJloL9sh1cYLw2zpVSBksTtcHQ8Msx9IuIZ7?=
 =?us-ascii?Q?0CeCwIihZuDMpn/G09BNkMNPIuSVSKVlJriQzvhg?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f007293d-3733-4870-df03-08dc6eeca901
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 23:23:10.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59gjgmg7GVS4mnUOs63tf6+KcYiQMVY2f/yovps3ffve86tHHDoNyApJ2z1Q2bVsH7M404M9RyR/jrxOOeiaaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4226

Remove pinmuxing for PCIe so that we can add it in an overlay.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
v2: No change

 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts    | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 8237b8c815b8..58cee0a8412c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -190,18 +190,6 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)	/* (E19) USB0_DRVVBUS */
 		>;
 	};
 
-	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
-		>;
-	};
-
-	pcie0_pins_default: pcie0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
-		>;
-	};
-
 	user_leds_pins_default: user-leds-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x003c, PIN_OUTPUT, 7)	/* (T20) GPMC0_AD0.GPIO0_15 */
-- 
2.25.1


