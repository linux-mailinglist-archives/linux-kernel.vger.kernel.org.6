Return-Path: <linux-kernel+bounces-404151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E19C3FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3F81C21B51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872F514F126;
	Mon, 11 Nov 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mMiQUC0+";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mMiQUC0+"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B81DA53
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332865; cv=fail; b=SHcEHVaArlGBugteML2b1Sq1Wn01KRaOuJfbrKt7EHw3eIvzVxsM9nGo+BHAV1JAXvgaZ0CUirxyLw2Alh0rxVfu8KScevcpf9jVwnY3mpYoARrypCsHhJx70M4yAhG/Yk9evco05SlTOvH154J1pYqLi+sKsLh40ofm5mIGCGQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332865; c=relaxed/simple;
	bh=wMj27NMY/UcVtecHScN9a2ZWFKeYb/HHXQhqcHGmxX8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fZCvOAkLss+LypI4qmD7Qlwzyc2B6et4uSzkZtoOHJFxRnoVHKb3i/uEr4sWcJB/AE/hDG0GuoLAJo6aREpJsTX40qFb+nZ2rWuI2ppE2BNeuHGwy32jrXkyTRU54wmVNsjdamKbfWbJUnqqVKW8a6tPeABJkKYZeRWSZb65+JI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mMiQUC0+; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mMiQUC0+; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DqN4GZ8MS36ZmgBVnB3/9ygQTkCn3bTikOmRIrkN6j+dSTUjO9VwM0VtOPoMaIOC8H9ryGEsCzh0ykKJTABHfnQb6D0NN8m36J6JyfjaCeVg6g2VjdVd/5vqTJMOtt6z2G7NDBbW8mdE9P+OYHlTTllLI+InJnQh8njDPcpcCXROmwPtISXE6kayALsn3pEb+2fa9GsvtJp9RX8UhhkBjzRmrwunSbbSlevt9w3+/nz0BsGBG3w/PMLbozs2yqRTKEYoXjK1WR9tWdIjf5EJvc1L3lVdpzV2ePfmP0sr+O/xSvrTdUXnwSB9mxdKBhFj7hIIIOsG3U/Ogr0iiaLTCg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz/YdidCUvsm0/1YeVz0mY5fg9cwFdORZy2m3ITzB18=;
 b=VRGShVKxM4Vl7+PQPYGSP1gw3xGD0HTRRzVKyieSZhLMle1s7lgl1fF/gIVEAlnJwI1Z67pmaHd3tdhVMFeEtIbcZ3qQXd3VW4u73ZhkTHfC3AW3N4xaaLxfdP50ARILSJxUgfYAF+UFI7jAdlg8cVbHUT9ULLc27ODZWI/389TLNstuAGiBWISBdQhPUHkNmKZeDMs0ZuM2lII2AuRcMiUrmj3SmK64EN2OI3Zyeg+t70o0nKSPxD0OwGaAfKd6xobOR3PzrUn+A1An78AI965uqrUSdK6Jhc1sgKKobEM4xXtXMdnUZKnDR1+wbx1aBUIBaVvcNUjpZUiYTQvQxg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz/YdidCUvsm0/1YeVz0mY5fg9cwFdORZy2m3ITzB18=;
 b=mMiQUC0+95enqGc53WCzgWnKTVFyVt4+FKffvBBNRuRv0dXca//3xcbOwIBDnKqiZqohK6+EZR0jZZ10aAcyZ7m5/zi101no1Oe5m1KL5Tv7Z1lXaJQMKunU1cab189u2KsD9xY3Q9zNb0hxZu4fXFstGgIggOuNxhxFlm8H76E=
Received: from AM4PR0302CA0013.eurprd03.prod.outlook.com (2603:10a6:205:2::26)
 by AS4PR08MB7455.eurprd08.prod.outlook.com (2603:10a6:20b:4e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 13:47:35 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:205:2:cafe::92) by AM4PR0302CA0013.outlook.office365.com
 (2603:10a6:205:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Mon, 11 Nov 2024 13:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.14
 via Frontend Transport; Mon, 11 Nov 2024 13:47:35 +0000
Received: ("Tessian outbound b291e78f2ea6:v490"); Mon, 11 Nov 2024 13:47:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6d72aba52f051b3d
X-TessianGatewayMetadata: zuZBtxbUpY4gYrAteEJodP3HTMzbY6C4x5oDA9LcNFbkC01ic7/RzdpLjQppSZfMaTfcLjJb0bH+ZNamRaweF/dvEwORuBoIwA/QVpzZGNIol6Zm+dxsBGh8lfEjN/reZHgMdIrtw59pveFuY9hG5kZ+PRtjORCyimr43RLMLhw=
X-CR-MTA-TID: 64aa7808
Received: from L3b3e890fc096.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 794663EA-600C-49BF-975F-B6212CE3ED26.1;
	Mon, 11 Nov 2024 13:47:27 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L3b3e890fc096.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 11 Nov 2024 13:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjWM1hAHYAW3dpxigUdRy0CGGkrs9qUQB15jvx4pO7E8BFm0Sy30MJJxYqUUB441kJB2vPeIntk/GgdLi8KKuGDSye54YzOknrfOg0UcCx+nR3loyU1t0DNMoJ3IfMpGkEqDWl7o1NScA9TlL97E94kJ9cnlcH4lyxIDz0kKhDv5U/olmjuzOyZg2xuxaZ2y5jPo3cm0JK3o7NgsqEnVCkho4Q4LZnQiE/ZQ2q1PLwuaW98PaBYeYxaK6TU6yXeB5F6jl0RRSlhxkBNqkVsHzGASe7z0yZXWHVMFUyvf7vq3SwC/xsoyBtnrr0Z7G/5dvjScS+dGLtMGiL6KF0dSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz/YdidCUvsm0/1YeVz0mY5fg9cwFdORZy2m3ITzB18=;
 b=V+PbcJ71Mb6YhNwQtl0cskUsJzCDc+brAOjhYPjgTKDWYSOn1ChusDh2Rfs2hW6fYyrgE8zTQnsjBVP3PT+r1C4iFFoYcYJobrOe/EvV7r6MRSOXXkcMXZliloBGq/u9NWgvqinrgouHKUcEMPVC3AmrNGq5fslThcJYXaDcBS1WLZkhJoDQ7PDQzskBBvN2zO8sd97yubtyGCqSzHM3dJOianSccQu7TQpn1KniqUW/dpxpRGzJW4U1E4sj7SOSjgs6eL5TprKYNdbAsfvxDfH1mfKwFjuLkktDDPJevus6ChQT4iiwgHAAdE9IJgiPAhCE44sjGXrAeCulITaTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz/YdidCUvsm0/1YeVz0mY5fg9cwFdORZy2m3ITzB18=;
 b=mMiQUC0+95enqGc53WCzgWnKTVFyVt4+FKffvBBNRuRv0dXca//3xcbOwIBDnKqiZqohK6+EZR0jZZ10aAcyZ7m5/zi101no1Oe5m1KL5Tv7Z1lXaJQMKunU1cab189u2KsD9xY3Q9zNb0hxZu4fXFstGgIggOuNxhxFlm8H76E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by AM7PR08MB5319.eurprd08.prod.outlook.com (2603:10a6:20b:dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 13:47:25 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 13:47:25 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com,
	liviu.dudau@arm.com,
	steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mihail.atanassov@arm.com,
	ketil.johnsen@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nd@arm.com,
	Akash Goel <akash.goel@arm.com>
Subject: [PATCH v2] drm/panthor: Fix handling of partial GPU mapping of BOs
Date: Mon, 11 Nov 2024 13:47:20 +0000
Message-Id: <20241111134720.780403-1-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::21) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|AM7PR08MB5319:EE_|AM1PEPF000252E1:EE_|AS4PR08MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e6abdd-af17-479e-8dc4-08dd025765d9
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?4jQcbtEXgvjjXi1gbZWSY8UerqVMji2avmuYwkTcDmZVyuhxqGX7usnZY13Z?=
 =?us-ascii?Q?kBpMfNHU1kX3QKWoIdhk+tB6/0V/ePGCbZrZTZQcBNCoJohrwjx7llcvgFM1?=
 =?us-ascii?Q?gOIkXMIus0rBH+UlezskkdG7BBvE49HMQS+L9I4fZc++nUikbAdIIKYHtmHX?=
 =?us-ascii?Q?iYJiGVzIs4ykJEhr18Cr97ipUgcJ7b505mDF78aEpF9PhfqWlWh5Xfs/IHgx?=
 =?us-ascii?Q?DKJAhK3/PcmaILhsgTkoowpSz5xAidvNVRRTVPaIZ5ev/FeEXszhhA0MfMEW?=
 =?us-ascii?Q?gKAL+406e/rybBPdxKW1Q2w8975KlgvY7G3130CnSdynhIwXsAx6DXmE1ox2?=
 =?us-ascii?Q?Wzu6Oci97vtsAIoLkZNvzKMtJo6V1q31Ix2UVbjOuHEW0/UZIaipNP1Fxxpn?=
 =?us-ascii?Q?QX+rr+BLR0alEYAz3UTcuBkuv0vXK9pF81RVYsyg/pbc4W94etTBvVSq+mY5?=
 =?us-ascii?Q?dWSU+Xw5LuGd8WH1vGRK0/uDoRVtRmMf7ko/Mlw+OwJCYgLzcbVsm0ofahYy?=
 =?us-ascii?Q?tUmH6uX/t+SxnnwshFupkWzbUv+XQsstjkJnfK/qOzV55VNe1DD/w+WyHXcy?=
 =?us-ascii?Q?cEtqeNNN+y89j1232RQCR/kbd46oGhYf19ur1NgvkKwjwwal0g+0ywsVig+N?=
 =?us-ascii?Q?vwnlBF2NkSSwJPNMJ7zTp09H7WdnXmuodGLTHurSeBTuo2n0g9mzR6+Ts0A/?=
 =?us-ascii?Q?JHGfpfjFnVa0fcNacZrPoIqf+cL2QEbsyj4cAKDFiVG/waVsG7OC445Xl4ik?=
 =?us-ascii?Q?5ro120QaUEUnaKb8JxucgfNV7UAVY8mHbIrBLcKRdh23oxmovezqn3+p9ksX?=
 =?us-ascii?Q?5t4cV5rdB6Ve5QKHsm8f1pmP4BeiBltozv+a8s419NA04+PfSmNprtrg/ZUZ?=
 =?us-ascii?Q?o4b5sIOLtkbaRGbB24G8QzGqZY/Lt2k3GX2MBo8aIifscCm8sIfiFgvqz3Mb?=
 =?us-ascii?Q?pXsI4xMOulpsZqfwmy1biQlceCiaXRE67WXBJVQ8dvQrAGaN2hf3jS06Gxza?=
 =?us-ascii?Q?x1zZt2fx/+e0YVqWBhUkdRSPJRFfClYhtf3fUsprM4dtUhbibbZ/ya1MrL4K?=
 =?us-ascii?Q?ROt3POqLi1oiSu0lRNsccJBSOWzoHA0CXiywP5GV/BB0/DJIBwynpstBXuQH?=
 =?us-ascii?Q?CWQS4aHzd71hcH6J2GYU9C4bS0xz4qh2NOUibAbVmq7FrN76qftzPP0a5Ung?=
 =?us-ascii?Q?DGDf9/6CjgkdkFCP7gU5hwL3QzCVlXLVlJlQSr5Lzmu7Z6r8+n6REhCFJPVa?=
 =?us-ascii?Q?8n5ZtnYMukYzRQ77P5QKrc8NGwuEa1xwkZ7S4w0qqXUjrvhpiQ8PB099Mb9i?=
 =?us-ascii?Q?ZeIh1vAZEle+XYZ70fohRGIW?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9580b422-b4fa-46cf-d54e-08dd0257600e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|14060799003|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?obo++0Uq9TT6lfmWvKPHa5Ypq/RVPnmL8MeKaipAYeejwb1U+SWjTZctf61L?=
 =?us-ascii?Q?Z196sXWkbv6ymrxkMxulb0b8U0DwA5RFepT7LPLmDkKThwqLrGKwg7pOdRY8?=
 =?us-ascii?Q?P0GwjsYJtC12hvuAbc0TsYqnh4pR7wTqsdfXozkzLL4xATUBSb5axcztFlyd?=
 =?us-ascii?Q?P9paHrsOxc3JFnlr0GvhCi7YlkkKAqsjoUw2yyQakGTG9CLw9z1hU1+FKmo7?=
 =?us-ascii?Q?MUBOJ8PIfuPVKSDnNbbXSQRoeHCJtodxxn6lgVx7A41ZCOYV19k5jUdmfAih?=
 =?us-ascii?Q?rZsNnUwH3ShJ75cE2xA0zwE3S6LiMJR7Af0Zd7eb6mqkkFcDR8CWP74uSMGd?=
 =?us-ascii?Q?AEO7rndcseZuheDvxikhpvBiZgcLKhc4MEVqbTgOPqmTJfTXuJ91mntwGiiU?=
 =?us-ascii?Q?roL6FVHe73E7N2tk/c21B+ppVZhSw7RddtJPJJMFlDewvpdity83RFvcF/V8?=
 =?us-ascii?Q?ApIFIABRH7QQAf8JQogSgHcg/oc+JDdOhcigfjP30FhtOGW9poBrONwMOCdP?=
 =?us-ascii?Q?qXWXXxy7gWVZtLJHkMbk1ba8ixRBHsIZbWxvFgiMoKOOTya5Qo2uSeRR+VsP?=
 =?us-ascii?Q?0N4HU+iZmV/SLP79OPHbQQW+D2nXMT7nkdQxr6tEK6qODaJ9XVJeRLPQaz3a?=
 =?us-ascii?Q?TBWEQn430HMX5+C2CnpYS5OSW1iyStKwGmwthFZbwuOQjI11PtjMjoQ8wouq?=
 =?us-ascii?Q?AMUG9k/wEe+2G4IUwFxeOZH4dHRze1DVPLLv0z3FX4Y7apdW2hlm/8czKAmL?=
 =?us-ascii?Q?jgNtQYRaZXFD/6YK7X6bG6RrVEQMMuUEJJFujB+E3k84UCBq7HvGX1ExGTBL?=
 =?us-ascii?Q?+/lcBWZVkppmKQj9tIus7s2mBhZIwihTEeGU4RKZKeuVfA3+DxpQk9qfvUO4?=
 =?us-ascii?Q?XfYnGolnxUVkQV6erc2PuKF5P+kWVfQgcMIsnACg0YEyIP8YWKX9voG4qai7?=
 =?us-ascii?Q?gYW/yqBTRhqAVe7B5dWzZ6A963MHh5fsnPYK2h4EJ+LUwOkBdn39SpVRxTu1?=
 =?us-ascii?Q?ozeco99AXCv3ywDztUNmhdScugBQZWNhi8rHyVyHWLmMon45+x3nZ3mnNjRC?=
 =?us-ascii?Q?bRGGEnc6xBI6eUwF+kCPVUlTuP/EJSF7wWR0gJXb3RDerfZoLjw//EaY0hdK?=
 =?us-ascii?Q?/WwEWkbK9KF8Eqkt6QNlkxLaS1WWzNdJ2CTeUxziSZ2gGaWnn4ZOV6PCBWSH?=
 =?us-ascii?Q?V07oH5w1w+xNzBzhpUN9OdIo3creFKQmAKVNYfE/h30GyIbDVjserIzH9PbN?=
 =?us-ascii?Q?9iIHGySNA3YsUChpoHz3Wb5hVDCnBnKHCMAtbjT8RxOqVf0RSnZs+ap1gFoq?=
 =?us-ascii?Q?hY5mr8E5a0huBvVRLyEKxYbET6gDLPmuQJujCo9zGtlGconF8O5x+b33YUuq?=
 =?us-ascii?Q?mSmEHoxekQXWRr5Dx/RwOqns9LY2HwDc1Ls89X5f1mpRxTIaBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(14060799003)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 13:47:35.0176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e6abdd-af17-479e-8dc4-08dd025765d9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7455

This commit fixes the bug in the handling of partial mapping of the
buffer objects to the GPU, which caused kernel warnings.

Panthor didn't correctly handle the case where the partial mapping
spanned multiple scatterlists and the mapping offset didn't point
to the 1st page of starting scatterlist. The offset variable was
not cleared after reaching the starting scatterlist.

Following warning messages were seen.
WARNING: CPU: 1 PID: 650 at drivers/iommu/io-pgtable-arm.c:659 __arm_lpae_unmap+0x254/0x5a0
<snip>
pc : __arm_lpae_unmap+0x254/0x5a0
lr : __arm_lpae_unmap+0x2cc/0x5a0
<snip>
Call trace:
 __arm_lpae_unmap+0x254/0x5a0
 __arm_lpae_unmap+0x108/0x5a0
 __arm_lpae_unmap+0x108/0x5a0
 __arm_lpae_unmap+0x108/0x5a0
 arm_lpae_unmap_pages+0x80/0xa0
 panthor_vm_unmap_pages+0xac/0x1c8 [panthor]
 panthor_gpuva_sm_step_unmap+0x4c/0xc8 [panthor]
 op_unmap_cb.isra.23.constprop.30+0x54/0x80
 __drm_gpuvm_sm_unmap+0x184/0x1c8
 drm_gpuvm_sm_unmap+0x40/0x60
 panthor_vm_exec_op+0xa8/0x120 [panthor]
 panthor_vm_bind_exec_sync_op+0xc4/0xe8 [panthor]
 panthor_ioctl_vm_bind+0x10c/0x170 [panthor]
 drm_ioctl_kernel+0xbc/0x138
 drm_ioctl+0x210/0x4b0
 __arm64_sys_ioctl+0xb0/0xf8
 invoke_syscall+0x4c/0x110
 el0_svc_common.constprop.1+0x98/0xf8
 do_el0_svc+0x24/0x38
 el0_svc+0x34/0xc8
 el0t_64_sync_handler+0xa0/0xc8
 el0t_64_sync+0x174/0x178
<snip>
panthor : [drm] drm_WARN_ON(unmapped_sz != pgsize * pgcount)
WARNING: CPU: 1 PID: 650 at drivers/gpu/drm/panthor/panthor_mmu.c:922 panthor_vm_unmap_pages+0x124/0x1c8 [panthor]
<snip>
pc : panthor_vm_unmap_pages+0x124/0x1c8 [panthor]
lr : panthor_vm_unmap_pages+0x124/0x1c8 [panthor]
<snip>
panthor : [drm] *ERROR* failed to unmap range ffffa388f000-ffffa3890000 (requested range ffffa388c000-ffffa3890000)

Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d8cc9e7d064e..8d05124793f5 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -989,6 +989,8 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 
 		if (!size)
 			break;
+
+		offset = 0;
 	}
 
 	return panthor_vm_flush_range(vm, start_iova, iova - start_iova);
-- 
2.25.1


