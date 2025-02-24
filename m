Return-Path: <linux-kernel+bounces-529102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A0A41FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D00E3AB30D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA82571A1;
	Mon, 24 Feb 2025 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="vCO18ODv"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012028.outbound.protection.outlook.com [52.101.71.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC4233737
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401681; cv=fail; b=H0ysb4TC7715ps558lihePalUoOGyNRTFxpL3RsIrXnWsR/xmFDQMkpiJBwpTtjZWJ0eKAyc8fARZ7IHxlNuUPS8jfyRuL7uAmLst+8qpSP5HQpOzrGYuZtGFf9BZmJYUO+D2TNEdeT63S+TaMyMoZ4CRsNEqezsUky2GzbvB20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401681; c=relaxed/simple;
	bh=CL8+e011908UactK+BB2kPw6A3IdDdizVF6JZPq6ITo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhlGeQFCbrpt3g9TDeKth+rGXmj85YrY8/NPQvWTY0XuKhQBXt7ryh4sQVWXJTZ7vqSdEL3IypznTEkH02A84Gw6gy/3e8FCOZB/3I9RuTBrpIcP0kvMvMfDr9mmdzxVxYmmNVdZFTnfbFdrhK6NrGTR+rRlvSle/sV2gctzn9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=vCO18ODv; arc=fail smtp.client-ip=52.101.71.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9KqT+PVAsUUjrSWedw7RidmU7by31BlHOniO0rFlCweDLAyixmz4mOfPGY52RLSQMA+Mzfnla94+mnNb6xd3nFm43iVvNleBwByk5ZpDRMJJsHMx4cfJWasKH/ixZwa59L/aZEt+VhpTH1L262Jhj1ecnXZDBZqCPSvicN7warfU7l25bYgqIsYXRxj6H2HcZczPgoZQV7CwEsyHYikyKc5FoFcPeEsr1KvJx4Lblx8IPkh4F7/XJ/C36K0xaRjx58SufkgBU1UYX58euQiOpgmDSm1ffp+wpoD9YLSCFCzcKUuxU3zg/sQ3+X0Cf3VTha/PwszBku1VKJXP7UX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPY+AbXPVqEBqj6CfiA4mxL6D1mnsKj9EIJzZOWAfG8=;
 b=VVo+ODdncsPeMhwcJWY0J1PUPCTCfP3iQ4nuqZAyUM+3luFhA7B8NbFLBg0r0TI8nBDfDxga2ztgQ4SuenloL/p+x2GBHQ757LTkRFC7ZehXJTGWZBJUCesXfwEzgnr8iy/wjHC2YEo40NMRjOGHHbRD3EkOBBLkS+zyzEC9p44//yG7MP4kM80XJY4XQJ0Rg8p5KwO8OzcEyaQNYzLlHLtGqgpEYHtSxFflu85tV9ZUQjaxmmf3axzTMnyAcP9Rzd0hnChmVFCvKAq/5uHcKBfsCd2ss7/pgW7jw7/pr59+56ZgAl/h00c9ML0lJVEG7XOe2ZUWCo2V8kiNHz+RrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPY+AbXPVqEBqj6CfiA4mxL6D1mnsKj9EIJzZOWAfG8=;
 b=vCO18ODvLXVbXUwz1ULRyyCplBlygbrP9wgNhVE7zGUqnLiszdHMXf/0fcdLIg0K57cL9YdyVdZQyh157p1oRatcwUI6ngZlUOTVg7T9TxV+7CjfIeOUWVwVf3fb+1iCo5Fs389XA1AYj5TTYdnBYqDKWVl5XfvDS5/1NR0HV3o=
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by AS8PR07MB8102.eurprd07.prod.outlook.com
 (2603:10a6:20b:371::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:54:34 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::b2) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 12:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 12:54:34 +0000
Received: from N9W6SW14.arri.de (10.30.5.17) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 24 Feb
 2025 13:54:33 +0100
From: Christian Eggers <ceggers@arri.de>
To: Russell King <linux@armlinux.org.uk>, Yuntao Liu <liuyuntao12@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann
	<arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Nathan Chancellor <nathan@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH v2 2/2] ARM: avoid that vectors are removed during linker garbage collection
Date: Mon, 24 Feb 2025 13:54:14 +0100
Message-ID: <20250224125414.2184-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224125414.2184-1-ceggers@arri.de>
References: <20250224125414.2184-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|AS8PR07MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f2f877-6beb-4e29-4658-08dd54d26354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r9FTJH+Ym/Md5mgn6VJG04Y5ILulrxXV9l4Tabugbl/Y9B9NAAQhp1PHtpPx?=
 =?us-ascii?Q?uFdY07NgAqj8UWxsJn8l4umRGTKQEz62tQfDiIizwkvvvZPoFwNuIoqOKfHz?=
 =?us-ascii?Q?35zinvTs8UiN9WlqQQruzhSjPxZBWgzC2OgoRF/H3H4aGWE74289CgnVQK+E?=
 =?us-ascii?Q?hVyRbJ6goZ9Y4YJGtFFfKz7IVSchCrnscGKogatJbYyxBP1c8vAIgsYb273P?=
 =?us-ascii?Q?ETkj9b9RsEkcpVe52cZ8kMgq2MirDn18Of8yTvlV38S1D+JV/JgrbwNSCZcJ?=
 =?us-ascii?Q?Nc0p4mJw7ZCu/C6ZPBUQHXW5Fc5G4leJhu2jMYXZ6sEDvorwpKSlDqDup9DT?=
 =?us-ascii?Q?ZKMtxOIs8UpCrEl9jIp8XO4QYJa2a3xJ5uPckKC0HtUTU/hwdXp+NmKEmlsi?=
 =?us-ascii?Q?3dCJf0lok0bMxe3AgibLhOP/DaIHPZlbLpCQxM8W84TgKPrOfh7vtDttAUKy?=
 =?us-ascii?Q?hdBqEBkGhtvyWwKKr11qnxhatr6vIY+xfRsDf/TR4YT2zNRg3bd2VJ6Br/e8?=
 =?us-ascii?Q?S+Yk1O/F6odlDfjS8o8yZTsOsMGJan9ls/OONUdAj8tFHmzLVXG1oR+cjExo?=
 =?us-ascii?Q?UjDObbFeMTOi0u11Kk2oNq5Q9pTQR0gtCS95AKbVjRGV6a4iNpN+GMfn5XcK?=
 =?us-ascii?Q?i9hElRB69kEQbAqhJWNVJeJzErJsdDqp+IT2WQmNH1YFg6gQn3sMqLsDNv4e?=
 =?us-ascii?Q?5oSMnIGrlhX5Dbt3DUs82WX62iW/AYPQD5mA4yplzuhR84K8e6bIW1m6LmQj?=
 =?us-ascii?Q?Buio8DKMVZNsIbfXBp7xPV5NmrxnIM0mHrfH9sMX0WdwYHrwzTrLo2TETQa3?=
 =?us-ascii?Q?owAZzG3zjgtwAKUV7tRYMkV4njMRhEPwEJSWkPNR2D9+0XgLr68VTZ1sxKJH?=
 =?us-ascii?Q?lHteeILDM9QjzBJTQY/DiheMWSZmuthTByeVX2Uvfq4ORRhRIE+FTaYrSTl6?=
 =?us-ascii?Q?btmL25a7atgph3whcW4TK1MeQSiSA2e8h89hCowvcKNE/2PZtlaRCHRl/zbB?=
 =?us-ascii?Q?ztDoeEfaHKQpb6dYdmk+1qHnzn4OJ1jPTuBCVc58iYtnJx39sjzfEf+4GoB0?=
 =?us-ascii?Q?EQErp8ujwW8L8OJhDDCBRRjv9qOxV/umjYlg8XIGeto5f1r1rQrUSj/VxK7X?=
 =?us-ascii?Q?2diLMM1o8KgW18RFe4EMIqWOjy2U0AcJeF3PqiVfvtJOjGAD/wjhBWk9ubTY?=
 =?us-ascii?Q?GSmIWkOergsZat2CwqyadJZv4Ru0pOBdMB6Vk2t9xueKfwRgmKovmUCnrvb6?=
 =?us-ascii?Q?gUmkBtQ35pkDDXh0OTH0A1KbH6Vm2XM0FLyhK99GOOBj2VxLQntp9YegUVXx?=
 =?us-ascii?Q?hC8APcdhcptUEYnAJdltUJn3AnNs7gsbiVA0accuYbtVjIenmzQft4DEDuRN?=
 =?us-ascii?Q?o87uKbkxVwX7haKfmPSC5lkRHw5vLRp15MRJviz7r37gy5K49rErU+W1qwfB?=
 =?us-ascii?Q?CftnPif1yuTXd8fBv8Lxv6ZKqf67w9haEK7ZBYQWo4zrvQad5eEGKDnn32Pt?=
 =?us-ascii?Q?ybpAnzjORHGXLh8=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:54:34.2186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f2f877-6beb-4e29-4658-08dd54d26354
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8102

Without this, the vectors are removed if LD_DEAD_CODE_DATA_ELIMINATION
is enabled.  At startup, the CPU (silently) hangs in the undefined
instruction exception as soon as the first timer interrupt arrives.

Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION")
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
v2:
- changed patch title

 arch/arm/include/asm/vmlinux.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 7ba309f826f9..288057e07e69 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -126,16 +126,16 @@
 	/* Note: The LLD linker seems not to support marking input */	\
 	/* sections with KEEP() inside a OVERLAY statement */		\
 	.vectors 0xffff0000 : AT (__vectors_lma) {			\
-			*(.vectors)					\
+			KEEP(*(.vectors))				\
 	}								\
 	.vectors.bhb.loop8 0xffff0000 : AT (__vectors_lma +		\
 		SIZEOF(.vectors)) {					\
-			*(.vectors.bhb.loop8)				\
+			KEEP(*(.vectors.bhb.loop8))			\
 	}								\
 	.vectors.bhb.bpiall 0xffff0000 : AT (__vectors_lma +		\
 		SIZEOF(.vectors) +					\
 		SIZEOF(.vectors.bhb.loop8)) {				\
-			*(.vectors.bhb.bpiall)				\
+			KEEP(*(.vectors.bhb.bpiall))			\
 	}								\
 	ARM_LMA(__vectors, .vectors);					\
 	ARM_LMA(__vectors_bhb_loop8, .vectors.bhb.loop8);		\
-- 
2.43.0


