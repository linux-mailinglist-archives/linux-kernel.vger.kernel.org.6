Return-Path: <linux-kernel+bounces-432766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61EA9E5006
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B000283319
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EE31D45FE;
	Thu,  5 Dec 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ikpzKQUW"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BAC11187;
	Thu,  5 Dec 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388144; cv=fail; b=kgiAg3l6HV18pnVj0MpsS4MEX8oUsEHgi2iKaj05I+kXwwWlS58R1W7ahKiUpRC12O1N4l0dPwypIiVXDJNq3PkJuktms9blvknlaT28WcDiaUD/MJpiXD4rT7gNAA2MyrDIh1+Y5uXSBDGWJIMEoNMUnrjbtbJ7r5W06NTdqh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388144; c=relaxed/simple;
	bh=wql2Vbi87I9thyREB5f2uKCKP6eATsfM67pDcaJyIic=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Giw2obNXamXZR89l5uD6cgmIdZBsOS9BRrxhePqBGHLGKLg6tOHdRUCxP2J5dUkey/uZDHZEuumFCXKafc9G5yUJkZ7W5pig/CbFeyCRx6uq2w56gz711v3h77c4Q/d1YR5uZ++JBL6xdSaT/rO7BUS/xvT/EaOWmuiGC8GZGs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ikpzKQUW; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYskxP6K1zArrIgriixG/JP9lPQiuTPEkjK9Faf9Fw1xJlbFvhx4SrG8RVei0cpuhZJMw0bB0K68cqJJUNe55Y2CLtveCYSERcTvRKxokMctVqISXmEUgw4QUmSMc1y3j+w67yq84YSeMXaFfxmahZpR5KA7scPBL8Y3iO635lkpc9FDj/iMjWhJFcaLeMD2/KhGJZlBJrmfAP6OSrhSG/MjgwXZYqF4/RIB3zJH/m6ECMBpSs79ELEX8xVXDESnU5ZjbtabD3+yy8yDjgB9ztGP4hN15oGzrJwQWMHtaq7YBdwDJoQl969HnyrkWih9NzHLGTplZVbHf8X14UKutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ykhw1RHRH05n23YdQQAXOwby/U0VSo62npwXzH7O1g=;
 b=HLlEAVl0+bNVLk2CgyXc4E85Snu0NCYIT7lTNEIFA5waovvoq1jcTd9ef+ea0h03+mg9yeaQfZ0JFazZXntOTnkhJ8mUACnhYT1iljjI+I9JiqApckx6xFdqgL+3IrRZcDzdT4w7NosTQ/mhUc8HcQv8jivk3szwqAiawpfW+y7PlraVlFmQwaKJxgCBKrzukqUgY7TpX55DQFU1b5captozRS3MILsvz8mbFG0re9Z8OtP55ge4EJ9Yd7AsR8g5M2y/wbhinAU8yfzQHRJBNU0w5Z7wlQyvxE8bg2QL1ltgy2IZ64G5WiHB0X2/pdYJTbu8yHGErnvOdtPDXDgaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ykhw1RHRH05n23YdQQAXOwby/U0VSo62npwXzH7O1g=;
 b=ikpzKQUWXF+iRjAUj5M4iFOJYq9EE+fLHYFRQiiDxQN9kzPBPZicc6eqIPFsGE7637zBWGDwZme6/Lgm0KNY0HoKHXttKnRsx/XKBxCANqCcuVN6FaCsfC0GYinQbxlvFNHJ27GNBqDhaajlyMdmvuwwdpTc4fWIuSguADdsKX8T47wQVFnpuFvzn4zNC43HXnlgDPxs/OTeZhZP/TmIW91J1MQS5J1AG329qeiGRi6/gmlvFJL1oR2dTpQxeh+BBWMxEIYjmjQmtJQesi1IRnJvMQ2XlpeIx6OV3SYJm1T1MzHwITV6qK0EFfnEsvBTj8PL4W6VQy0iBM59utr40A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 08:42:19 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 08:42:19 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu,
	mathias.nyman@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>
Subject: [PATCH] USB: core: Disable LPM only for non-suspended ports
Date: Thu,  5 Dec 2024 16:42:05 +0800
Message-Id: <20241205084205.39773-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b02ff4-b67a-4bfa-5ba9-08dd1508ba56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JxN8H1Hf4+91rce4qXHZm6ZB/waZJvl6q1Xl1icKIcpNprXblaeoB+0zAMng?=
 =?us-ascii?Q?JgOajagZfnyzXKb4UeVXDqIp+PpdlrcvRHyBuBkXtoZNPAlEWPiV72qIthTk?=
 =?us-ascii?Q?mRGwsUcBdTIBd6T1Aofz8yrCks38zNJZB9+YuqVYDf9F2T06llparjBvvp0v?=
 =?us-ascii?Q?hwgg9zMhocAss+sEdBsDcJAZz1b25u+BqlJstuIY0IV7oMVyD2kafocWnNwc?=
 =?us-ascii?Q?8D/FlO4VRqoepAMtl8sa4AA7pz6W7bqgh5fn1jdgCwPr/BC1VliXdTSqCBCq?=
 =?us-ascii?Q?6IxiIgpzHdOYrfTX+btEJWN98v57kFaq9Iti11H/MGH5EQDBeuPzhkDJpfac?=
 =?us-ascii?Q?KyWNapETAR18s+imvxM59EkX+2DDyQyjydMkFASGrAgqJh9mbsFTbk4AbKSn?=
 =?us-ascii?Q?QJ43XVloo3FNdmlNeBLxGaODqgsOqTlud1uGjVn/XXxC59kJxFI9BNHYiQj0?=
 =?us-ascii?Q?Nwk7FEuhw8FTmXSMde2voplWWjN9HKO75Bm+wCZ214xt+P3VHHtbLNrXKaDa?=
 =?us-ascii?Q?6tTdWftNOq+iym99u/bcc4jgNs6PN645K0MdLJ6YjP2oTGxw1sKkxwal58Ai?=
 =?us-ascii?Q?GjVO8p0gQdSt0L9w1rX+hZ7GEALvTgbaJItYMTVfAvv4GIZ2HgCmT0CBjFIk?=
 =?us-ascii?Q?iDuU6mkbftJ44pYow0qvNkAL2g3pbNm8tcaZwMqupsUo9k5A0KlkRi8G0Dld?=
 =?us-ascii?Q?6YoI2lCzM4Y6iJSUeaa4j3t6VJ/uPs3VZ7MzzqYyRTlTS8WsJHKYTujp46Tz?=
 =?us-ascii?Q?3qcyt+ARLEAdGbAf+pIiq82YG3eNZh8sJXapU20V5TUs0ORTdZwdQeu81uyx?=
 =?us-ascii?Q?rT3iwKNjM9U74VBQbA9hCdK+7RMLkbZRfYoKWF4jEDiY27C8mqtQDoHUBP4W?=
 =?us-ascii?Q?I/Iuhxfa5Ku0D9lhjkJFrNLbNBFtBLN+h3O0+jFDjNjomo2OgZCdoFeeGPMp?=
 =?us-ascii?Q?rXcnhThIGF88sl/6ToH+SFb+zc/1E+WiOTnA+DBIL7hf25bdocWlCRcUkIZA?=
 =?us-ascii?Q?VLeNfUw0qy3NZgu6VsOV1Ta7NgmQ9hFqrUS/ChqLg3jb374A0jVPXU5ycYX3?=
 =?us-ascii?Q?ThFWoUzNkCNZqnqpHK9iKNKPZPU9SW+oHwJKQMX5696eyF47TipbssRnVYaB?=
 =?us-ascii?Q?m+HU2Ry7jfWGIW4QQ54AyCERYpnbilg6ab+suIGlubCjpYIMVUjBQ0uunv/i?=
 =?us-ascii?Q?9Yj0ZKxM8520R0vgA6XmJa1+prxXFaKfF2/DcAfOSGB6kYOnECNXjL0a84Xy?=
 =?us-ascii?Q?tcpjFQ7rUKcO6GvZC8SKmi4ZLWZjMJnsVdXPEp5JpIvmwdgaLdwrxiVgu9Na?=
 =?us-ascii?Q?a1tUv16PadlCX6ExSgDZViq0llFAcZ1/PqVxth1eFDTL6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nyEXZKe0uIk765JCWAogmEH0fGFvXooakWpYYagWNy7kEkjqAkmq7CJLWgZc?=
 =?us-ascii?Q?UpLXw5uk0OzUhN/G9IHSCKVji5qY+otypP2mW7gTwQziVv9ASDRQBS38pPJ8?=
 =?us-ascii?Q?JkK3C6bIiWYF1pKWxuwy05X+vPvNSznQfafl4v0ZFIr7QBCz9d2uPt3EtjpQ?=
 =?us-ascii?Q?HtuZfzmWKy8+9mPh2eOve5t7VaImEEx5PK0yenIfGbMXyDxfNEbKuol3q4qw?=
 =?us-ascii?Q?E2P87o5jCo/jEo+aWI+Bk8rOMsqsNPBExL2BygyyUzQsSihoZGEwf7/mKhNI?=
 =?us-ascii?Q?N0Z2bbJt9bRL1yC0xPJCRlWz6CqywquL5d3oDIvMU6WxrpPNh38elW+wAW9d?=
 =?us-ascii?Q?1kv0gS/ToU9gohQFd3xKPuPujDYJoDNNf4VzL5hOoJ/qM3OkoBXIk9ogNo1n?=
 =?us-ascii?Q?w8Q48PouvS6I4XuboiVyQRg0G+CYO4K7jot9ntyb83tARF1zNKbJm/rcppsD?=
 =?us-ascii?Q?4K6L9KEOwswJsk3qsjhrbIjafJ+WbslzBUyUpDIi5yCag17LI6DXPujxNSks?=
 =?us-ascii?Q?9W3fyzJ9WSfpcoeIlbtNC/9LG0/H4FGTXGj8UC38eFDHoV4Is03BlCerujkh?=
 =?us-ascii?Q?TC5CeytiskhkcQwl0V5ZMeuqkh3n0JeoBtqAPSuFny0o4rEsOeLA/dkRSEEt?=
 =?us-ascii?Q?IXTdin9baqICgn19qeqPatMkv+N0g/TQhxUwoOWn9MSyFgHRrT0JVabnjjRl?=
 =?us-ascii?Q?kZYejdoLuTYWRwsGIWUWUZk+XUS6f0sa3o+s01CAdhIgvJcK/i3XtsYHRC8g?=
 =?us-ascii?Q?hQqgJ5WaDFGj8M/ZhovMVUkhwoXaOAyXSWTsHrl+4pCycDgs5TyVnRkFMPRe?=
 =?us-ascii?Q?zC3X2VzgScqUnfCs3c78eGQFk+Tk6Y45vhjK/EKzkUharZ5wk8LI+f07NiMY?=
 =?us-ascii?Q?U2gAgt+PzDimPYEI+QcjBf1YMc5vrkaW4o5+9UD/zvyGYJdUC8esb/0+u5Nt?=
 =?us-ascii?Q?IMvdQDL1iIJ43JowEgwhob8dUymVrSYU4Aw06023zmVoMr0D0Z7xOX/Gz4/T?=
 =?us-ascii?Q?pRRIedgYLMTr/rkN4Bv2unYSkOTgU7RECkbmncBceHdMmGbFdX45LCMsOSaJ?=
 =?us-ascii?Q?SngpF2vVojfycvFsg2IUykvl1QIJFmRnHSA4iLqWwPXHVV6WJCYrOW6bNIhZ?=
 =?us-ascii?Q?HI0WXapdedyy4tx/WVtqtgg4hqp+B33bg1EWF9JpHMnHzDjUqQyLTPT2pYHV?=
 =?us-ascii?Q?LJORZxR7ussIODOI2Q5JhMtMmiNWgIapz2Qzk8guv6iYWXngOPmkt+dB3vcD?=
 =?us-ascii?Q?5vtOZddc42pNsBFWNcYuNmPEDmP1rt/NVgEpb/px8yKaC1KQS8fP/+dkis2j?=
 =?us-ascii?Q?65c3FMs3tP6I/OEknJJsSMS5LYW/sNFcbj64FbJ9YJoG/uWgWdeT9hlf6tMl?=
 =?us-ascii?Q?WLwi4Kusx4hee43R4ug99WFVmQUxcOw/CVVxI/fyxV0oa4GfsivbQPMkUfgw?=
 =?us-ascii?Q?SmS6wi+gWdAAmBk0GjpVQqdkAOX5WRQ/nH8SD8TmRGe5eqesNiVXcE2+sX6E?=
 =?us-ascii?Q?zwevy7RCYXswf+C8+vhhqi56ZtVmd3B9Xi7UzvgSh0XCHSOiYvIuBd3cD+H9?=
 =?us-ascii?Q?8jXU+T0z4ATFpy2lmVbBk6oEs6fBprpDennCdp5k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b02ff4-b67a-4bfa-5ba9-08dd1508ba56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 08:42:18.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aw3GyniQJnxe2LkuACaARvo0s0bN+nbo5Z3hwb65l8anMly2RNkQPtjDNoG2usIdHlle5tGpRpRcSpQEo7a6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086

There's USB error when tegra board is shutting down:
[  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
[  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
[  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
[  186.157172] tegra-xusb 3610000.usb: xHCI host controller not responding, assume dead
[  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
[  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for evaluate context command

The issue is caused by disabling LPM on already suspended ports.

For USB2 LPM, the LPM is already disabled during port suspend. For USB3
LPM, port won't transit to U1/U2 when it's already suspended in U3,
hence disabling LPM is only needed for ports that are not suspended.

Cc: Wayne Chang <waynec@nvidia.com>
Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 drivers/usb/core/port.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index e7da2fca11a4..d50b9e004e76 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct device *dev)
 static void usb_port_shutdown(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
+	struct usb_device *udev = port_dev->child;
 
-	if (port_dev->child) {
-		usb_disable_usb2_hardware_lpm(port_dev->child);
-		usb_unlocked_disable_lpm(port_dev->child);
+	if (udev && !pm_runtime_suspended(&udev->dev)) {
+		usb_disable_usb2_hardware_lpm(udev);
+		usb_unlocked_disable_lpm(udev);
 	}
 }
 
-- 
2.47.0


