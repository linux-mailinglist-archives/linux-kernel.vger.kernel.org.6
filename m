Return-Path: <linux-kernel+bounces-322435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2F9728FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599D71C23C43
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694E216BE23;
	Tue, 10 Sep 2024 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="SjY6yZYY"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A8BA42;
	Tue, 10 Sep 2024 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947285; cv=fail; b=P85e41zsZMQk9tCy5CWiteD22xIg8ke890GdOcWQFofFRpT05/0k7PiZgdepefJFbNOpS5vkGBvi0nOjWiLV+2Lnv2z1rcmr0u4S1Kojew+FhJzN6yT0iAIO1MKQ1WJgpn8enioI0/1csnx/xfFLvErUzivi7Z/RxmzqfaOZBFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947285; c=relaxed/simple;
	bh=eaD/K34T9n8TxAG4r+PoRQ38CiDNHOHERl+p/CeyeEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OHjEznSkJo91RTgG5vhjOh8PE/47kAOz4MBgduqFpIT+nZIqQq4nx+Ay/xgcM1LPnAfkiJwfRuETwt/O/jt1mi6XrcQjpfGL4aIVIyG1UfIc3b1h4C1Tna6oC3wY+TSTyNgWKUW0RlTnVyHdB+i/JkpNWeMJCqwFJFIgFqcGhag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=SjY6yZYY; arc=fail smtp.client-ip=40.107.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhKrGWvAExacYImlC8kZ8gBLRY36Rlu/NxajgyILLBz2sRVW+oUGk1GwbxzIhxYAqHGeYjuUo/la/SI77WobkZAFgw+5T5vtIUuruuofT0H3R759dVWGaHpllvg5+vFjRxPsIy9VkfknuB1DtdVA+2GmBJE81IDr2/oaKWuTCq43rZYDa3ZohmT3Za+LXxMpujCveQYUubC88Sgczz2gi9nUQ67NjYp+dBZ3KScXQ8N+xMm3TGaKhH0bQAQwXW+q8/1n3nr54POXJwUCrJUoTtj8C7UGjx4Syuxk/OOQiaEQJlYsuaLhgcSjt3ff+aLkIHuwdPmFC3Fcp/eIlCl5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDLbwJxcVO6qXb84Bz9khN14NF7j0sVNm4T4YFM2eMs=;
 b=lH9eIY+5w2NOwcTz7LKiRxfWNzyW5g70rI2uxBTr4cOUZc7nlqNbhYLHqQZ97iZBF5r8zIKGVKsi9vzPmmRPeKxBJmL5lM2UMUtBd3tnqqUQpCESTf/qEqbCgAnfHvZtk/XZt2QtvM7pRQmjW1Pvd3EOlRw2ie2XQunqRaE4cUPhauBf+8y/jyihYSJeKIo44BZ6js5hnJOEEiJxonVnAJrIT3RvRry4kadbZMBHMjcTh+sn5upTFE+nuPupqW2yX6O7M2+kpLNE6Ia0XhOjvG51nmfoGx+oviRS0SMAraL3MRekEhVGiA5VIo4ItxBEIouh4rQIPp5yH8tno/xSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDLbwJxcVO6qXb84Bz9khN14NF7j0sVNm4T4YFM2eMs=;
 b=SjY6yZYYJL4ZyYMEJqrEdqNr8B3CsKIu216VWCEqK3POD3BNXAlW9KFAXaFRSEievn8f16Zs45nJGQkA6rNH753wDltrhD7nBapmJJR1fDXRXyv/Efyxp2NmmKFvkkh3US4qAlw91Kb550GLs5Fdxjl6LwbTIT/QQ2PZEpyq4vW3EbirM/s0gfsVYvFmeo6YOO3127fk9tiogJNqiAczqbb4DP5xT6vdCQ690uJhhqdZeDkp3g6MiSfuIAdKa7QnMLtlhiwJrEW2wcKs3VLNt9HIhb4zNmbXBSV97AnGTsvuzttD0pJJcIryK2Pe/u9RDCq9Zf7C+cTS9oq/pii7Rg==
Received: from SG2PR02CA0136.apcprd02.prod.outlook.com (2603:1096:4:188::16)
 by SEZPR04MB5707.apcprd04.prod.outlook.com (2603:1096:101:72::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 05:47:55 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::d1) by SG2PR02CA0136.outlook.office365.com
 (2603:1096:4:188::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 05:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024
 05:47:53 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Yosemite4: Add devices on I2C buses to server boards
Date: Tue, 10 Sep 2024 13:47:49 +0800
Message-Id: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR04MB5707:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c4935c1b-99ad-4b86-8943-08dcd15c1dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cBH6avbHty3OJe5OLHsTbSOCYrOG9RT/1tuiMDrezmk+drNEIoTZzg0ekvtw?=
 =?us-ascii?Q?iFDt9dFPt8UZD1JYRX+l+j6OeK4YpUnoKrN20IJRQRkSJbMtoc2qk0ZAjsQJ?=
 =?us-ascii?Q?IL1zMgrUROjEitZZhoFIld6kLh7iOq0w2qVu4sv+XKVYFEd/RzjMPFdRaCEU?=
 =?us-ascii?Q?u/EtP15cn/WIsLfD6uQPTj9oBtq4D2Dtb/vbYtAs+mCUNeiObHcdTaXa+oWF?=
 =?us-ascii?Q?Ts17LuDTSbihCIB8W5jI7s2B59yF5eliY1Ec1Ndgh5d+eNbxv9YFDyhdD8xP?=
 =?us-ascii?Q?/VX4x4ajI9r1vc0VeRhDmXV1RUc375M9bxXzSxZo3oG7nlFlBLNG0FsUklRF?=
 =?us-ascii?Q?NXWYVrUAMyiBjwLZRM5c9OeDHS87Yt2mT+Hqq2Sv81pchXfeljyk04ekaNha?=
 =?us-ascii?Q?H/5UB+AHDf3IYjBB+GZzvBt0wkid/Gfh96Gj9rySD1y2DWpHVJDM8IhHCjPc?=
 =?us-ascii?Q?8GYYHJLn/hQJall0FAacJ15Ypa65cqPRhzylSGAXdkmP4cHOlO/RCprwhSVL?=
 =?us-ascii?Q?mcgSWO/WoxX6dxBAM53lWttnKuaykf0duV4WMa5aojY0pyCOpa/Rl126P3kQ?=
 =?us-ascii?Q?mLygDfceOzUDsxwgxRfMUZwKLSTTecvI/ShtmQlUW1YovGmeIFEbduyoTgU6?=
 =?us-ascii?Q?HivQ9wW9+6lS5aLXRIqG1Gi/ZRAliO/kIMBxrPKVUPGQ4IgzHUM8ED+x6PKo?=
 =?us-ascii?Q?2w91jKoOmPwOOabY/7EReQP63ajym9nPlv67VTL0Lh1un/Ldzus8RKBq95lL?=
 =?us-ascii?Q?/8g+RS1jcm7F370zUZUnFYrN02sjzZtLloEuj+fhZQAzlG++8lFibGsLn15g?=
 =?us-ascii?Q?LHtMRgUxKWtUHyLKpcD+9gi92G730fhCnB5qS6EZeCaPe9aciX/WvhI9R5IG?=
 =?us-ascii?Q?6dLJ85vzrS98kBVaMct58fTbJdkYI+KAQcsAj4ZqLoT0mvaXBYNm37b8hdem?=
 =?us-ascii?Q?KV5F0x5rmeR0t438YhaiTfQ4MYXJTdbjCaDXcQ4NWBJFI+h19BhcOSCH1EuY?=
 =?us-ascii?Q?bmrnEjZY8rhQSCyzgXzn9coTIUBzRVFlf5Y1im6Y/ewUGiuS2IFncqDUEACF?=
 =?us-ascii?Q?zcWqGEcSoqDbSQITFOTc8qbxPiCaTDlnlRxJyoodPU+1xwSNFERLSE3cYCuF?=
 =?us-ascii?Q?tcuifR7AUSQZ+28IX75xSi6iZIrtUm/hUIq1st+KrO79G8VHWi9M6mM2UsF+?=
 =?us-ascii?Q?LXASeqEKdqU7x0wnoO6t+Bko2+kB6brcaUHY02PxV/gLXMrt1/7wIDR74iz9?=
 =?us-ascii?Q?xydbd+gJYuPYXeZ6idDjAi1FgPtQnFGTz679Y94sjhgQCrxbnqM21eZxTjF+?=
 =?us-ascii?Q?IldATg05v7RxmCrbUn29XxyjWpG9prPX1CiZSF+pnphxEW8RZDcGTNhkNAw2?=
 =?us-ascii?Q?NN2PdSV1Z8ObSsfBsUC50axysU8DVmzoUKPn8hVzpAoVTYCza1Sn04Vi5sl3?=
 =?us-ascii?Q?Z2v6vI+Y6xBPXpWq32T/GTpZ/fH9Cgih?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 05:47:53.9901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4935c1b-99ad-4b86-8943-08dcd15c1dca
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5707

Changelog:
  - v1
    - Revise to use adm1281 on Medusa board.
    - Add gpio pca9506 for CPLD I/O expander.

Ricky CX Wu (2):
  ARM: dts: aspeed: yosemite4: Revise to use adm1281 on Medusa board
  ARM: dts: aspeed: yosemite4: Add gpio pca9506 for CPLD IOE

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 276 +++++++++++++++++-
 1 file changed, 268 insertions(+), 8 deletions(-)

-- 
2.25.1


