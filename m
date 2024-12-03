Return-Path: <linux-kernel+bounces-429550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 385509E1DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA202866C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF01EF0AA;
	Tue,  3 Dec 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WaipvARB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WaipvARB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B71EF0BE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232808; cv=fail; b=SvaWhD9oHqnIofHSknJVHddRu9ML81g8NDSjdn5nlRPOlvKZ3AQ4ruWowNJf7l037GHQJBihnmRlrRpTSyo9sWD0lNRtTnBo5MoUf3VqX09S42DdRpHJArhVgcD0RiyCltV5kvtXQkUF9jgV5Rtvzi8P62rnPRBudP/iHioCwrQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232808; c=relaxed/simple;
	bh=hsMPpFXY9B4Mn5R+1HhBpTkYLs61HFQp/zpF8fJLeoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m9zITbOn73u3Gml1vU1yXPw1sJt4dqH6O9IfWuVdd3K3q95J4U6vFCWJS6S2Br+yXg0j3LfepKrQtUFmzP7FzkPeA4IMv6H1x30om1qvtsKThSBvDyhhIbNhCZHq70gxSbqtZcamXEM2s3musxmYusywDY+ImUnDgi5gF/4DjHQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WaipvARB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WaipvARB; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cw4bv9yVvIdoJnRXkyjWbM2lLLw9eIC82Eai6WCjh4o84olimCDsdiSkPzT90DxPs+j7WQADqAqKo079PTBQO91K/uXNNmQ1U1uDZsqS0aZzEEL6RB/vC+Udmwprx+q7REtZwjZGFOcspItxtNTAKZ2xTNA5C4cbkfMNxJE7e/I6bv9ZEHCDIn8lYS4eil2uprFy55iWJKhNLzZw1ih6ubCnKfs+gIxpwPx2JUvRb4aWW04GY3eUUnRzNzA1/WfTiRujKi8hS3pUJ/sN4gSbDzz31NOoNdqE0KP+d4aJF5YpkI1WGLNtxBlB0ouN5kjymyn9GGc5Vx1VFkia2rBCsw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzOdIPzFyCUlm6nJrSEhIB6pmF0cEZS3VsXZaXcMnJc=;
 b=G0Dgs03iCeFaZWkQ5MMmo1FvKcOUatH2LdbzNdYVmwgeeby1VwTus84KBsARz35/lRxWRDwYEMXa6pZ+ZCAuLnTd7nbz7Y64BR1nRUuJOeChbDTdSeAmIEbX7W7nyDrDO/GZSB2CLgGHY0wnG+sVUE/ixrJeSCPLkkyDXhLQBXLxLHRcAtRdx/7iOmbhYvDdywoPr9UIYQxuaG0D+AlUhp3cyawFkFy6Iw08JcHlZBNeZQJaDk+8JIpYbgJj4n/mAT1h72QMxB4MLLEUQ1z3rEvW15elOfeNJS7yHuwg8py92WG1LQO1JXDpZoztDKWKXpyEphs/wfEWGBDY8DLvqw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzOdIPzFyCUlm6nJrSEhIB6pmF0cEZS3VsXZaXcMnJc=;
 b=WaipvARB/kvTpJ+Ail+Csl6cG5YheHKaoaHO6Ux31CiXAQpXOpa8r0atFVrAmuy5CVU1btoBYqGUwK2eUY6Tv9DKf+0J0HXdwrTuNt8213VD6cSFehoN7gceb+D96WdZGGTkb7UC5e/m6K53JbOSkDJFSlwAAeS9FQMp37NjUFk=
Received: from DUZPR01CA0168.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::24) by GVXPR08MB7702.eurprd08.prod.outlook.com
 (2603:10a6:150:6c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 13:33:18 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::c5) by DUZPR01CA0168.outlook.office365.com
 (2603:10a6:10:4b3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 13:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Tue, 3 Dec 2024 13:33:18 +0000
Received: ("Tessian outbound 206fab1c37e0:v514"); Tue, 03 Dec 2024 13:33:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 38fca3520531b41a
X-TessianGatewayMetadata: d5zEwSyy8Z3ZQ+GRErxnnH0N/utHvgAkE1LP0sJ/9X/ijHDOouCljTX0tIkQQelnBLDuKBNky1WMrqMR9KsGTHw6mAfm9gqx8tK17QDufDHnZAMBvOKq6FUc1UdO2irqqTLrFU+xsikznvBfh66PwQ==
X-CR-MTA-TID: 64aa7808
Received: from L7d1f6cb4e129.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id AFBCA9DF-A644-4E79-83EA-917BB3F5FC81.1;
	Tue, 03 Dec 2024 13:33:12 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L7d1f6cb4e129.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 03 Dec 2024 13:33:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrX7hs/2O5W3iBcc3YHZTN00S8PXNGNEbCVo8VNKfNVCLrbMHzwdEXcmCzDgOdYlOpWzkC7Lc1i6VSKqeX+R9EVpweB5I9ZeybjQVP7qMNXOsxoI5/k/0okC+Sya3pSPsA3P/L68GOI7RydJUh/8hZUoDkBGtgW6M02SKGm4XU0vUeYKw+PJ749d+hcJz8ccjDB/2A1V6QfIgt3m+HKWiPh0VZIPn6+mcv47T/ox7FzQHoG5cM4LnDtcIfE4N9Ml/0QVopUEXqPv3K1W0TMl6h5PdC8gCDywmGX9AtnvS2xv3/7e8po67W9sAviZAqDizpqFfvQFUKFOcbgAO+2xUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzOdIPzFyCUlm6nJrSEhIB6pmF0cEZS3VsXZaXcMnJc=;
 b=WvD/Rz8ykrynw/DWXvbf3fkuYG3A70Ns6+0eEpnK8ohcArcbT3k2YsNx/0Cz3gPcNPGMLfod4K8K24AlsiJR8OFMbYplPHyFynF/QwpTuKA3wV8d0J93k4hwo6iSGKd0SG8FY6aQRTDPOII3CS36kC2rYxCDRoSF6eh60OmLoEfaWRHyGbwhewwxuIcq4YxfYuUlZTl6IG+9H+Patbojn+/fcCFUYginkcQtGowMnhwxWTxDZ9Xihv8BDtZDgPrpxxAIuJYfKt+FkLcrH9RYeecUo4UtSSr6SIqNlfNtYgpL/J9uQoaYX5MZ7nzmwUv3Hl7jZi9fa/HasXVAixwrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzOdIPzFyCUlm6nJrSEhIB6pmF0cEZS3VsXZaXcMnJc=;
 b=WaipvARB/kvTpJ+Ail+Csl6cG5YheHKaoaHO6Ux31CiXAQpXOpa8r0atFVrAmuy5CVU1btoBYqGUwK2eUY6Tv9DKf+0J0HXdwrTuNt8213VD6cSFehoN7gceb+D96WdZGGTkb7UC5e/m6K53JbOSkDJFSlwAAeS9FQMp37NjUFk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB10069.eurprd08.prod.outlook.com
 (2603:10a6:20b:636::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 13:33:08 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 13:33:08 +0000
Date: Tue, 3 Dec 2024 13:33:05 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] firmware/arm_ffa: remove __le64_to_cpu() when set
 uuid for direct msg v2
Message-ID: <Z08IkRcxpBGUDozj@e129823.arm.com>
References: <20241125095251.366866-1-yeoreum.yun@arm.com>
 <20241125095251.366866-4-yeoreum.yun@arm.com>
 <Z072Mm61eE_Twx1B@bogus>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z072Mm61eE_Twx1B@bogus>
X-ClientProxiedBy: LO4P123CA0365.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::10) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB10069:EE_|DU2PEPF00028CFD:EE_|GVXPR08MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: e88889dd-6c38-4d33-ef45-08dd139f0c95
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?XBd3INCPD1SxPtrotsxA2km03XvomXLkkwHmc6bsm8objvSz6sEl1vzVkdkt?=
 =?us-ascii?Q?KgyOiCHNa6dERMcvnWUAdkvyqnO3vc+EIjqDhPtGzpc8sCnHBI7kJ9WMhM1E?=
 =?us-ascii?Q?Juq53CpsZ0CHHmFXdMQ3/wEIniLe+NHyNQlkbJSXUIRv49XcD60vnhAH0uG4?=
 =?us-ascii?Q?L7EU4M8Mn5L3HtBrBZoCbLPDmZzOuji3rjH88ilQyc0aI/ONjvVdtY13agJR?=
 =?us-ascii?Q?NPymdS8P9I8R+e6d4WAZEe11fviHYgL4hB/HLND/n8jPStuci8NQrmPkrnHb?=
 =?us-ascii?Q?vkEHpFPboD+Wvo6jU+5tXTT4sSrmWc1rfRVeVsImMtY4YNq4F6StjRCubDuH?=
 =?us-ascii?Q?H9PadbGfgdj/KgMyQLlIxq3+YPNU0ZmnBDB4uArSpYNTkpqF4zFpiteOcejS?=
 =?us-ascii?Q?kye6yluHhTP5q/GsWCLFn7ksx/D2OsCCpTUjD65uHkSh57CrHtH3PoHkVoKT?=
 =?us-ascii?Q?zr+R9gucCt70vZuDyDF6H0FXvqARzSvhmLNYv248q9mHLOJqsbp+O4d1362r?=
 =?us-ascii?Q?tdvmtBsyhbkEezKVbE263bUXiCX7yzlOe71Scyj4MRctkoxpD0+4NuT8jm6g?=
 =?us-ascii?Q?dZY2G78xUO3fNv2lKYZByfWheBOrmTmIG1rAj2Tgmzvcma5+Lna3vAjjv0qo?=
 =?us-ascii?Q?Gsiveno0B/eLaYLIQzDD/XbFTBxo5M433X81/q+/HJxaAxa8hFIGkXFHKAI3?=
 =?us-ascii?Q?h1MwsdA+Y2Ll07VXk2wXvwBWmPQluvMIAT94MAP59o2ukx97hjUAltF+xxyw?=
 =?us-ascii?Q?62tuqrnDLv3kbwpUL7ivpoQ26ocYkRtJvcnwTg+TfQh5qQuIV0K7p1cXpOV/?=
 =?us-ascii?Q?SzpIT4LY2lj2rRHBhLfhV0MnL8CrOS3F6LlmZUEiFqijuLIPOlZ0SBrEOmBx?=
 =?us-ascii?Q?6KuHT5o8lVkJuY/blnbbi2imuytDEv9AORwZVArYNQA3Y8lMrMkRGfkZHKnt?=
 =?us-ascii?Q?N8GA1G3D4rQ5GI4cRW5Tuk6skvsH6EIRDuWhKHk+mIrRo0hhu5mGWWhArCTd?=
 =?us-ascii?Q?GigPOUvUjKxMvM6ci4pGzABPLf/8yJFGwVD0xwOVkWucBdYpKCbYRSa5TMiA?=
 =?us-ascii?Q?bz4BkTCqy1bfygU6xprM/08PovyN5WKLQmA4xgmcGS84TNy7ENR60A1Fcjvk?=
 =?us-ascii?Q?YHK7ELivH8FhXPQ599baJSzG86e8OXN8IgVe++6mjYbNfP0AUOz+RL50vQdE?=
 =?us-ascii?Q?HJBxW+5H/1YgCPZ/aq6TfWqGx7ZJNBJXyLzSPnfK63CD63l1u3VyyKNFMIgG?=
 =?us-ascii?Q?+NiYENMACqzhLCwqiuCQw+PaMbQXK6vkH1+mjGoC4L2wVlDSDkWjSbmkH0Dg?=
 =?us-ascii?Q?SzypfADUY21TOHgOcecELrL0qy+yjTTaITbMd6vb56xKFA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10069
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4861b92b-a6c7-4655-16cd-08dd139f0655
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|82310400026|376014|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DoHYj6hWcCEEpHxJcqPbxrJWZSpzoNOPZTOceJzvofU/Qzj2UWwpLLBvMnZt?=
 =?us-ascii?Q?6f3MR8c5DbpF+TXKpURy4rvZi2CA3WeJh0/ib5l+O2q0h6DDFvj9M4s6Gls6?=
 =?us-ascii?Q?kKvrQDh02H/CPiHi34xS1Ji15Y1u6rW0vXJ8Mu4tr3yI7+6SMxgIFQJyJa1G?=
 =?us-ascii?Q?j0+qNBeLUmIJ1dc2oZ7FK2LpxHzhBrGIeI4DjYLKWcyTuK2lidNzS637SEJs?=
 =?us-ascii?Q?Z6Taknj3e4sxhDE+vwh3GYptgO3SY5FZFF9YIovNomlG+cTu5iJhuOv/i+qF?=
 =?us-ascii?Q?vtKacV63DJT4pxLBtAMikHcVnlJ4ti273WTc27ER/jzV+augYdqUJvPQmFuo?=
 =?us-ascii?Q?1wliBV3CF7N0PDO98vFA4NrHn5dEIzkgs14hmmo1OurPZUkuT2VxwHQzsTsJ?=
 =?us-ascii?Q?lqofK0LegJ2eu1LaLHremcTXApxU1xflPJO6Z5BJlmudx+I3oUANLKOUDuMJ?=
 =?us-ascii?Q?CHAvoeFe7SGlY9C96lnBZJp5P0iYM8q6EoBGCtzui2MYIbhyN19JKjETAWMB?=
 =?us-ascii?Q?IK1k03olVdgpc+GyNY27OuZ69q+WH5sk3Yaewx2+07q7Pne8DgJtseJPDEd5?=
 =?us-ascii?Q?6EY6IkrRRAGjhsm8bMkx+wXGHpOie5KWQhkgsnjMaZtCaybIfzdifP8MITf/?=
 =?us-ascii?Q?Ha3XZ7EyaOghq45DHdfn+xfY6lIw1BhvbYxXfoqkuqC1FTSr/xcn+LERee43?=
 =?us-ascii?Q?jb/wCaLx4figCJC0kUGcAHfVBWxnX/RFw06yjpRhmLVxkiliQFYufnHd1mUe?=
 =?us-ascii?Q?EvrmMBcG7+Ew72sPYTBgAYQg8K4oOYePFqtlr7sUjuieu3Pz/doer75mJ87B?=
 =?us-ascii?Q?QVoEljtwtlSJdp9u40pT/xgYx9ikibuBDOiZumYJaMbby8zTnutmP3nybqs9?=
 =?us-ascii?Q?UYNu6nn85lyRzYFtnO5ZbX+OrHUNmLzZ8GaaRyYMM9CxxZuU9Q5bVLII/UNU?=
 =?us-ascii?Q?LG0plr72qQizN2fKB9Gj3JoTYIG235L2IPapNAAFA9OK0EIdzL4Y41W9M3cm?=
 =?us-ascii?Q?AtfXtj6o9qpxUs3xQLeRhm5Ep3AOVFM2qrsAl+amYs4HjITHZaj6QDlkGAhT?=
 =?us-ascii?Q?k1YmyeeOZXXYEHD8cw9uaQWGUGHmM7wh+FHg7MNECItHMGzy4KxAp1Qr8VAi?=
 =?us-ascii?Q?LWKBgW9S310qOW6aWXlG3AIxaHoihwv7ChuGpfEHoEi3NcwjEhvW867lcNMG?=
 =?us-ascii?Q?3mloSqJydBSsEzoQm458epC8WkPqFOQ2iR5SFqWNGnw7uVmqfg97nQY4Lfrz?=
 =?us-ascii?Q?ohz2dL1bL9ypEaJ6CgH45SFcuMohATC7cDvyUhXb7l3W5bFUmKKANALdCdR5?=
 =?us-ascii?Q?veSQoTXo72dksrQsNBLQZKfR4aRZomjf10Ww3QX7dmQs+eJRZ72X4hU1vNXe?=
 =?us-ascii?Q?1MzufyJlPt6ac+TCMCWm4HPF8nYKcA3DU4qtOPkOgkQLYh4vyrozGyE83wJC?=
 =?us-ascii?Q?+5eaOV99YDOcJnfu+/YpECFmmCO/qWYd?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(82310400026)(376014)(1800799024)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 13:33:18.7577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88889dd-6c38-4d33-ef45-08dd139f0c95
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7702

Hi, Sudeep.
>
>   |   warning: incorrect type in initializer (different base types)
>   |      expected unsigned long a2
>   |      got restricted __be64
>   |   warning: incorrect type in initializer (different base types)
>   |      expected unsigned long a3
>   |      got restricted __be64
>
> We will get this warning back with this change, wondering if we can take
> up BE support separately.

Sorry. I'll change the type :\ Thanks to let me know!

