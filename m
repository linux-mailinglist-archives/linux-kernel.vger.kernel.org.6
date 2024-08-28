Return-Path: <linux-kernel+bounces-305421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468AC962E69
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C6A281641
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B331A4F38;
	Wed, 28 Aug 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EIvqehKM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EIvqehKM"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2F36130
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.81
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866001; cv=fail; b=kBIsXM1Ud30K2/R+kby87DRfwonah+VROe/k9l5hv9Heqdw5/qu9W26ONIo3PflCqy2zNAZQPHnLdILL5s+FBuUI94GwFKXtx2jZFhWNwxnQatEkPO/vMKmgHrGJMAhDvX4gqj1QW02FssiTk1EPjTwUx+YPrB3pPHCaL6OTLGU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866001; c=relaxed/simple;
	bh=UKOYqKkgx/aK6mj4HhJKlKrD+AKKA7kkyAuuRcmCOkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8hmXBKoR+E32e4hCP4ZBE+bbfDp1og2q24WuNvM2PGpTqA7kUpOLKXQjMMcQ0S1WQe/8FCC+3Uo1W8l9h71q6rHAJE/NIH82Bh1bgiYrjaoEJmvfAOkQ6dI51Aruya0gD07oeczoSMBZDvtw2cd8eCnAmEyGp8xMt4WBGaPTsU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EIvqehKM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EIvqehKM; arc=fail smtp.client-ip=40.107.247.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xct5yLGCHUtngnTwcNmbo/Xkn4iOzIufdtxeSpDxXAb/RnxZppw/03//nDL6NCkG3TGd3ga9z8/LBgqnwIpT+aQ400SC9FQGqTa5UxsjBkR6XNYN7pgYiHP7bL1oFDHiP3320DcaCjjHRmjjJ4WAUj1RZ76FCo2wOfoBjrjF8Qxs5/W1WfXqF1N1EE5s+DnWSdCthazqWhWCcYkVZ8wG7QJ6B02HL2xVMdhUqpruoEe/3GuI59Ce1Dw0Nz9gNQmNEOrfnVAJa3rkfxTJg7EtDJ9tIkQmSvUmhX6k3W6HA+3rEyAKQ6Z/bxDWnOjSXZF/YN0TOkognyaULHlH2hLV3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m7hf/25ORVUBhUoMY/OJ1lZUWDEtBtLgjWn3WpUW2w=;
 b=FZ8FutZ2o3Y/amul7rMMfn9tcFXYxJyjm0ulMD5a/9i7sRWdbsDY031Nul3rka5Y2tY1F6FXkIYNPs8EQ6oj6HCMLRyTtvvvk8f+fWUXVqR2N8nIHXpPkpD3AonSCsOm26bEfdVF7MhwCuNJJRs9ll5T/kMGFi+9AQwCCqddr+x9RWL7T/XCHE4j5vLzjXHl/rqAZ+BykG3xu7snNA6RwGBr1caNuh676ewYMfW/ypBjJLqQLj+BTqYRl9bxQ0ktt8KnlyqIJAFpO7hurI+ZxtXsYHUYjFFlKLoOHWYz2lg6WhVnjOT7xY302d48pOTRC8y+QWWJ6flDafd4B/A4yA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m7hf/25ORVUBhUoMY/OJ1lZUWDEtBtLgjWn3WpUW2w=;
 b=EIvqehKMEo15SqV552K7PAvjSQenaRqryK/wVdHC/eJMoxIhZAao1vMzJmriBg4uN4V7O2GfXKKbg2bffE3wWfoVhldam7+mL1uVu1Uqnfzf40rcrVHchqiRyad1+50CkRlTrYASBD5SSH2dPVSfkfDQiNsXonCk6r5xIn1kNPY=
Received: from DU7P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::15)
 by DB9PR08MB6364.eurprd08.prod.outlook.com (2603:10a6:10:253::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 17:26:32 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::e2) by DU7P195CA0001.outlook.office365.com
 (2603:10a6:10:54d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 17:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7897.11
 via Frontend Transport; Wed, 28 Aug 2024 17:26:32 +0000
Received: ("Tessian outbound bc251c670828:v403"); Wed, 28 Aug 2024 17:26:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 114beb05aceef6f8
X-CR-MTA-TID: 64aa7808
Received: from Lcc029bca0bdb.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id AE4A4B2D-0B6E-42AA-A923-F4CC217FC0F1.1;
	Wed, 28 Aug 2024 17:26:24 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lcc029bca0bdb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2024 17:26:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuke8e0Zn3Fj3gTkxMyG/sqdz8WBII4AuxCcjL7RZUiI/UxW9avjpQR3FhQpI0urD60w+WfVo+ZvK0Mkm5BgzgOXSgHT+tMvD832so3Kq2jSkkN+xlM+LOoqb564ImOEvtvUIkVuHCa7wX58jSHrR/HRD04V5gggLraZ4MWeYe9WdIO2LTtkJezDJAVqD7QYz9osynYqqTYTVu6P1G454rdsORsYZUy4N4LJIe0a1/vInhPsdmGCKeIfeyH6T75CUOV3Hp1BWSMcA7JhVnQeyTJeviEKlD75db94WiE846+Ljf7gmXXr3eL1Nyf0Ea1xPgT4fN3f0VsehaLMmkOXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m7hf/25ORVUBhUoMY/OJ1lZUWDEtBtLgjWn3WpUW2w=;
 b=h+kJ7nMOf9vJ6CniEbbAeSGaXH1rwJrsuKYA5X+3eVIOxt1fq7jMc+ZyKtIX22FmJ2bweOUhJOcBJiSV3J1gzvbrq0Pi3SfPSdhJt0zm4+SPoaODCVPdQkRNCQiahvQ5BjdhC8DMOdnXO1Ny7YerBXZS6ZEPrIsH2sv6YMJHhbUoFvpZGiJssQkVTyct67z9opSTaBpmINwIwEToCEb42vBnoBj6S4SVbKi+0pn3NGCTJr9Az9eV6MIEHG7ohFuQK/XgoSBGsldUN898q11MKTB+I2iiXbnKFIG1oe7if71NbYpi+wceFdDqaqgJ+w2nj0kJ2tSBhlukTOypCyBbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m7hf/25ORVUBhUoMY/OJ1lZUWDEtBtLgjWn3WpUW2w=;
 b=EIvqehKMEo15SqV552K7PAvjSQenaRqryK/wVdHC/eJMoxIhZAao1vMzJmriBg4uN4V7O2GfXKKbg2bffE3wWfoVhldam7+mL1uVu1Uqnfzf40rcrVHchqiRyad1+50CkRlTrYASBD5SSH2dPVSfkfDQiNsXonCk6r5xIn1kNPY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS8PR08MB6551.eurprd08.prod.outlook.com (2603:10a6:20b:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 17:26:22 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 17:26:22 +0000
From: Mihail Atanassov <mihail.atanassov@arm.com>
To: linux-kernel@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Ketil Johnsen <ketil.johnsen@arm.com>,
	Akash Goel <akash.goel@arm.com>,
	Mihail Atanassov <mihail.atanassov@arm.com>,
	Mary Guillemard <mary.guillemard@collabora.com>
Subject: [PATCH 1/8] drm/panthor: Add uAPI to submit from user space
Date: Wed, 28 Aug 2024 18:25:57 +0100
Message-ID: <20240828172605.19176-2-mihail.atanassov@arm.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828172605.19176-1-mihail.atanassov@arm.com>
References: <20240828172605.19176-1-mihail.atanassov@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0652.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::13) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS8PR08MB6551:EE_|DB1PEPF000509FF:EE_|DB9PR08MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: c6509ab7-f4f1-49a6-8b13-08dcc7868f53
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?H+07acMR5wfp5zw4dTIlj0gT6pIHd6F/XbN42E2J4saFl9bedXzmz2fq7Vpy?=
 =?us-ascii?Q?yMK1mEPp46mU6JzjhuGxQmMaeVXsK164a2RdUKV54evZ0uMgchclSsvpNqm6?=
 =?us-ascii?Q?YUD8raav5ob7Qk3iYM3NmqCzxYdS1Ox2msG7wIwkk8qZ9Mc7STmgvvxSIGhf?=
 =?us-ascii?Q?YtWSIzDtqQjp1CV7Hsj0EqE749F2Lq/WPjg0wK3wQDswYuRKEqzteDL4vY1y?=
 =?us-ascii?Q?pN9V3OmSOhtOe3LU3SFRxLlt05Hznqdm0D40Ij8VY++g4TbuvTl1dFPCHJTJ?=
 =?us-ascii?Q?W8Dy+KTUDQFssmL5T9EKN1f7PBoJSdU4uEBORWBe1CCE/LpYzTJo68uA5Hxm?=
 =?us-ascii?Q?GQH6DAnfnNZ9TLenn1SW+33FNWGBtSqQKCgbIfYFr7Zucw2T8z9Y3rAwU1Nm?=
 =?us-ascii?Q?kB+oW6XeuLvZu0xPfWYaJjTLw/fmMSj4/acY45xsKOD983tiFv0Kl3/wp7NW?=
 =?us-ascii?Q?v0Tlvw5aPbLNVs3ExV+WiOTUWLZkTtgwSURVjNE/aWbU11lAVw+9H9rezkYt?=
 =?us-ascii?Q?F652VmNe3ad3JuMg0BrIlCtc9HjoZh+T4KKxdWjFe+rL887ET6yIyRO+YNu6?=
 =?us-ascii?Q?65R7amxRBZqCjPV9jXqxgjfFlrMDP2FR6NSYWwJsN1vuxUfRg/8+vaNDjj63?=
 =?us-ascii?Q?Y0fC8G/VLe6RgaXLTSg0T3ij/Fhq5LHdcl7xEMz4zR2uM2dSbBPTkWqELipY?=
 =?us-ascii?Q?0wyCMM/H/HTlE72X/1RWn1KjfUbLgBBghgs1rua7JUTF/W9xUCE7ox1VtAPT?=
 =?us-ascii?Q?ouqEWVR2lbx89nnN1WS9NIOfKZrSCgq+jFtGgGTo2x2whgYl+AtGM4fUNkOG?=
 =?us-ascii?Q?2As33t2vFlAN2ZlEdlKdaUOClir4cJE83Abkp7CR/LnbTE2HtwaUzmbj7RBx?=
 =?us-ascii?Q?8t7+oXoyWBAhYwZ/rQwv2qMucD+luQet3OfJRf7Tk9r4FCuD9dKiBco1dFVV?=
 =?us-ascii?Q?yKMGWPVyEYl20PZJNVk2iETxMhgZ7K9JCjGWo6nAjf/4uhqeSBDhQJ35G9CP?=
 =?us-ascii?Q?vjxBnFudRoM4m+bM82OjtjmyGcHUIEtnFEa59CwDzdYOw63gz7G35HStb094?=
 =?us-ascii?Q?xRp7PybwCdPBsK3ju2FxoSXlQ7Wkjm3TB+1KWLzYEMRrfXJMmwlksbXJIasN?=
 =?us-ascii?Q?YKxb1MC63r6+DW02Zcu+TSnPG7LEQrx2NCNnTkJCIC6C0fOrbsFCFCMx2Ehv?=
 =?us-ascii?Q?XtOIyS+r3+d3c56swscj52cuPB3BSkbrX8fFNb7jjLmuPO/qFx8S7e0N32+J?=
 =?us-ascii?Q?DNGebZcpBsXqSRRu/nFh1P+Lery+FTG+3D7YINCvYqbiFVs5vfllC41Mtu73?=
 =?us-ascii?Q?Yvg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6551
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	996232fb-c16a-44cc-1e3e-08dcc7868951
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sSC5Sg4Qsg4gy8xNVdsqjZM4ANs9ih/cIGIU3MRnJBuiHwH/PdAbqDYbX7rz?=
 =?us-ascii?Q?IkU/RXWxBg35LArx/fzocZi4iGmZYFDgfSYQMq/jQ+/apnD2mniseYND6Fz7?=
 =?us-ascii?Q?ecMnBmmU2bSEQLgTi9AePSbJ4eGTvQuWyfSemo8jrb1shcSZouR6wgXGzhS2?=
 =?us-ascii?Q?J5N+7ogMNHEKPNh5pxIdIm9k/0Mbz44Wave/EuwLDYWdK8HNZEP1uY5E+UCn?=
 =?us-ascii?Q?8mdk/jwqujj0fbB33LbrLk2lvTMSij3eSyhD9MpDid9W3GZDQcoqvrHXLfWE?=
 =?us-ascii?Q?vhp2OFKAzeXljfpNvFhxLwFMnx/9X0RazJuOSsfFRku3ob1lN28Wc7vIdawl?=
 =?us-ascii?Q?jvN+uewAYPFfdxlKWhQyVoCaCfPtu8RbboRHvV/iAkTcF6yQm5bAeg584lR9?=
 =?us-ascii?Q?TrB3UfA7LVyfhZApY4C99DtU9CxoTUzNgiVcNkvZiwA/2xPrEF/9OaBq/ql5?=
 =?us-ascii?Q?8dU83mUCeQ8oDVJI4Sfv97yw7aRtwpBd2WM2uDb+JMnxnpfOopYNYTXcWdaV?=
 =?us-ascii?Q?iI71AbEcQFsQr2hzVRaiGg38xke6GMQEqdjYrFxqdsY7PSr/0yUoilE8FYzE?=
 =?us-ascii?Q?PrcwbBvDc3UmEh3+/r0MHCRnC1dgEyzB9mCA2XtsMO+Rk/vutAiaI77qW7KK?=
 =?us-ascii?Q?EYNOweRcRHsFlb5h/G9f4b486U2A+WF/2ZBRWPf1h2/GTt0niKMd/DSuCW7e?=
 =?us-ascii?Q?BRUh9mt47NUpa3NKR2NRb+F6/Cq9157zNcrYbxWw+ChdkFqJnMz61NYqygtY?=
 =?us-ascii?Q?rPuPsYm31ZUAHOFQuNhwKWNVfyipQWm1+GiqG3c+HXwBtpCIfXE8XsD2P+7m?=
 =?us-ascii?Q?biOy8avy0DSPQZ4Co+y/gI+NryIUHbL8ASxcjFAW6bym+1akUiq788+oK8T2?=
 =?us-ascii?Q?BzCYVA1aKiygyjYSMrGeBLz3J3KG4yq/Zu0rUTTCe49CxszNxLFp8nQmwN5b?=
 =?us-ascii?Q?kBmHd7nzfTKncsQ+T5TPQlwVtOTEXU+7FDcgRJYn+l9g/2BEKj+m8aKZdf3m?=
 =?us-ascii?Q?DZXbj/NFnfaAyuYEPbAjYjCp7zzfIG6bQ0WH8K/eXS3/p32VhctkJ1yXs5mf?=
 =?us-ascii?Q?SnWKuMJfS7w3Wv1pLGFhxqL5e4zhoRBfh0hmmfJ2PVNGf+Dev41w664rhKhV?=
 =?us-ascii?Q?iXwR/+g8ycMewJGe0UhxaS4/ogIwIZOh3mvKygO2AxzdpH5Gty60IgECatX6?=
 =?us-ascii?Q?yJ1x8kLlt2JbVz/rBcR9jtdJJoFpl7+K4PXVNlsTmVQk7xtZICOquxVwEgFK?=
 =?us-ascii?Q?c5UfkrIdEQ1dFhJJps2KyXqNQEyFfEs33pHQpuSRjaOi+qWXkwh9WycP4qaI?=
 =?us-ascii?Q?luFG7wg3H92sTsfF1wDuEw4j+4ftq5SXn2xSrmEM9iDkmris+mlYpFTHEJEL?=
 =?us-ascii?Q?sf/snkQSjZhzSZlsIgxEL9oCvJzKdOm+cORBRZp/ha1n8YChyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:26:32.3461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6509ab7-f4f1-49a6-8b13-08dcc7868f53
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6364

From: Ketil Johnsen <ketil.johnsen@arm.com>

* Extend GROUP_CREATE to allow the kernel to expose the ringbuf, user
  I/O and doorbell pages for each queue, and add eventfds to signal sync
  updates and group state changes
* Add a KICK ioctl to re-evaluate queues within a group
* Add cross-group sync (XGS) queues as a mechanism to synchronise
  between groups' queues across a VM
* Add a SYNC_UPDATE ioctl for user to notify kernel that it needs to
  re-evaluate groups and XGS queues; use eventfds for kernel-to-user
  notifications

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
Co-developed-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---

This is going to conflict with [1] due to the driver version bump.

[1] https://lore.kernel.org/dri-devel/20240819112508.67988-2-mary.guillemard@collabora.com/

 drivers/gpu/drm/panthor/panthor_drv.c   |   3 +-
 drivers/gpu/drm/panthor/panthor_sched.c |   2 +-
 include/uapi/drm/panthor_drm.h          | 243 +++++++++++++++++++++++-
 3 files changed, 244 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index b5e7b919f241..4f1efe616698 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1372,6 +1372,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
 /*
  * PanCSF driver version:
  * - 1.0 - initial interface
+ * - 1.1 - add user submission path
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1385,7 +1386,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.desc = "Panthor DRM driver",
 	.date = "20230801",
 	.major = 1,
-	.minor = 0,
+	.minor = 1,
 
 	.gem_create_object = panthor_gem_create_object,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 463bcd3cf00f..b2cf053b3601 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3089,7 +3089,7 @@ int panthor_group_create(struct panthor_file *pfile,
 	u32 gid, i, suspend_size;
 	int ret;
 
-	if (group_args->pad)
+	if (group_args->flags & ~DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT)
 		return -EINVAL;
 
 	if (group_args->priority > PANTHOR_CSG_PRIORITY_HIGH)
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 926b1deb1116..1a6a3877e5b3 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -127,6 +127,21 @@ enum drm_panthor_ioctl_id {
 
 	/** @DRM_PANTHOR_TILER_HEAP_DESTROY: Destroy a tiler heap. */
 	DRM_PANTHOR_TILER_HEAP_DESTROY,
+
+	/** @DRM_PANTHOR_GROUP_KICK: Re-evaluate group for scheduling. */
+	DRM_PANTHOR_GROUP_KICK,
+
+	/** @DRM_PANTHOR_XGS_QUEUE_CREATE: Create a cross-group sync queue. */
+	DRM_PANTHOR_XGS_QUEUE_CREATE,
+
+	/** @DRM_PANTHOR_XGS_QUEUE_DESTROY: Destroy a cross-group sync queue. */
+	DRM_PANTHOR_XGS_QUEUE_DESTROY,
+
+	/** @DRM_PANTHOR_XGS_QUEUE_SUBMIT: Submit a cross-group sync op to an XGS queue. */
+	DRM_PANTHOR_XGS_QUEUE_SUBMIT,
+
+	/** @DRM_PANTHOR_SYNC_UPDATE: Notify kernel that a HW syncobj has been updated. */
+	DRM_PANTHOR_SYNC_UPDATE,
 };
 
 /**
@@ -170,6 +185,16 @@ enum drm_panthor_ioctl_id {
 	DRM_IOCTL_PANTHOR(WR, TILER_HEAP_CREATE, tiler_heap_create)
 #define DRM_IOCTL_PANTHOR_TILER_HEAP_DESTROY \
 	DRM_IOCTL_PANTHOR(WR, TILER_HEAP_DESTROY, tiler_heap_destroy)
+#define DRM_IOCTL_PANTHOR_GROUP_KICK \
+	DRM_IOCTL_PANTHOR(WR, GROUP_KICK, group_kick)
+#define DRM_IOCTL_PANTHOR_XGS_QUEUE_CREATE \
+	DRM_IOCTL_PANTHOR(WR, XGS_QUEUE_CREATE, xgs_queue_create)
+#define DRM_IOCTL_PANTHOR_XGS_QUEUE_DESTROY \
+	DRM_IOCTL_PANTHOR(WR, XGS_QUEUE_DESTROY, xgs_queue_destroy)
+#define DRM_IOCTL_PANTHOR_XGS_QUEUE_SUBMIT \
+	DRM_IOCTL_PANTHOR(WR, XGS_QUEUE_SUBMIT, xgs_queue_submit)
+#define DRM_IOCTL_PANTHOR_SYNC_UPDATE \
+	DRM_IOCTL_PANTHOR(WR, SYNC_UPDATE, sync_update)
 
 /**
  * DOC: IOCTL arguments
@@ -680,6 +705,40 @@ struct drm_panthor_queue_create {
 
 	/** @ringbuf_size: Size of the ring buffer to allocate to this queue. */
 	__u32 ringbuf_size;
+
+	/**
+	 * @ringbuf_offset: file offset to map the ring buffer
+	 *
+	 * Returns a file offset which can be used to map the queues ring buffer.
+	 * The size of this buffer is as requested with @ringbuf_size
+	 *
+	 * Only valid if DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT is set in
+	 * the respective drm_panthor_group_create::flags, 0 otherwise.
+	 */
+	__u64 ringbuf_offset;
+
+	/**
+	 * @user_io_offset: file offset to map user input/output pages.
+	 *
+	 * Returns a file offset which can be used to map the user input page
+	 * and the user output page (two consecutive pages).
+	 *
+	 * Only valid if DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT is set in
+	 * the respective drm_panthor_group_create::flags, 0 otherwise.
+	 */
+	__u64 user_io_offset;
+
+	/**
+	 * @doorbell_offset: file offset to map doorbell page
+	 *
+	 * Returns a file offset which can be used to map the queues HW doorbell page.
+	 * Note: multiple queues can share same HW doorbell page, and this offset
+	 * will be the same in this case.
+	 *
+	 * Only valid if DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT is set in
+	 * the respective drm_panthor_group_create::flags, 0 otherwise.
+	 */
+	__u64 doorbell_offset;
 };
 
 /**
@@ -696,6 +755,16 @@ enum drm_panthor_group_priority {
 	PANTHOR_GROUP_PRIORITY_HIGH,
 };
 
+/**
+ * enum drm_panthor_group_create_flags - Flags for group creation
+ */
+enum drm_panthor_group_create_flags {
+	/**
+	 * @DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT: Enable user submission
+	 */
+	DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT = 1 << 0,
+};
+
 /**
  * struct drm_panthor_group_create - Arguments passed to DRM_IOCTL_PANTHOR_GROUP_CREATE
  */
@@ -730,8 +799,8 @@ struct drm_panthor_group_create {
 	/** @priority: Group priority (see enum drm_panthor_group_priority). */
 	__u8 priority;
 
-	/** @pad: Padding field, MBZ. */
-	__u32 pad;
+	/** @flags: Combination of drm_panthor_group_create_flags flags */
+	__u32 flags;
 
 	/**
 	 * @compute_core_mask: Mask encoding cores that can be used for compute jobs.
@@ -772,6 +841,23 @@ struct drm_panthor_group_create {
 	 * destroying a group.
 	 */
 	__u32 group_handle;
+
+	/**
+	 * @eventfd_sync_update: eventfd to increment for group SYNC_UPDATE events
+	 *
+	 * Only valid when DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT is set.
+	 * Can be set to -1 if UMD don't want to receive these events.
+	 */
+	__s32 eventfd_sync_update;
+
+	/**
+	 * @eventfd_group_state: eventfd to increment when group state has been changed
+	 *
+	 * Only valid when DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT is set.
+	 * Can be set to -1 if UMD don't want to receive these events.
+	 * DRM_IOCTL_PANTHOR_GROUP_GET_STATE should be used to retrieve the new group state.
+	 */
+	__s32 eventfd_group_state;
 };
 
 /**
@@ -955,6 +1041,159 @@ struct drm_panthor_tiler_heap_destroy {
 	__u32 pad;
 };
 
+/**
+ * @struct drm_panthor_group_kick - arguments to DRM_IOCTL_PANTHOR_GROUP_KICK
+ */
+struct drm_panthor_group_kick {
+	/** @handle: handle to group */
+	__u32 handle;
+
+	/** @queue_mask: mask with queues to kick */
+	__u32 queue_mask;
+};
+
+/**
+ * struct drm_panthor_xgs_queue_create - Arguments passed to DRM_IOCTL_PANTHOR_XGS_QUEUE_CREATE
+ */
+struct drm_panthor_xgs_queue_create {
+	/** @vm_id: VM id to associate this XGS queue with */
+	__u32 vm_id;
+
+	/**
+	 * @eventfd_sync_update: eventfd to increment when a XGS object has been set
+	 *
+	 * Can be set to -1 if UMD don't want to receive these events.
+	 */
+	__s32 eventfd_sync_update;
+
+	/** @handle: Returned handle to the XGS queue created */
+	__u32 handle;
+
+	/** @pad: MBZ */
+	__u32 pad;
+};
+
+/**
+ * struct drm_panthor_xgs_queue_destroy - Arguments passed to DRM_IOCTL_PANTHOR_XGS_QUEUE_DESTROY
+ */
+struct drm_panthor_xgs_queue_destroy {
+	/** @handle: handle to XGS queue to destroy */
+	__u32 handle;
+
+	/** @pad: MBZ */
+	__u32 pad;
+};
+
+/**
+ * enum drm_panthor_xgs_ops - Types of XGS operations
+ */
+enum drm_panthor_xgs_ops {
+	/** @DRM_PANTHOR_XGS_OP_WAIT_LE: Wait for condition to be less-or-equal specified value */
+	DRM_PANTHOR_XGS_OP_WAIT_LE = 0,
+
+	/** @DRM_PANTHOR_XGS_OP_WAIT_GT: Wait for condition to be greater than specified value */
+	DRM_PANTHOR_XGS_OP_WAIT_GT,
+
+	/** @DRM_PANTHOR_XGS_OP_SIGNAL_SET: Set XGS object to specified value */
+	DRM_PANTHOR_XGS_OP_SIGNAL_SET,
+
+	/** @DRM_PANTHOR_XGS_OP_SIGNAL_ADD: Add specified value to XGS object */
+	DRM_PANTHOR_XGS_OP_SIGNAL_ADD
+};
+
+/**
+ * enum drm_panthor_xgs_op_formnat - Format of XGS object
+ */
+enum drm_panthor_xgs_op_format {
+	/** @DRM_PANTHOR_XGS_OP_FORMAT_U32: XGS object is of 32-bit format */
+	DRM_PANTHOR_XGS_OP_FORMAT_U32 = 0,
+
+	/** @DRM_PANTHOR_XGS_OP_FORMAT_U64: XGS object is of 64-bit format */
+	DRM_PANTHOR_XGS_OP_FORMAT_U64
+};
+
+/**
+ * enum drm_panthor_xgs_op_flags - Flags for a XGS operation
+ */
+enum drm_panthor_xgs_op_flags {
+	/**
+	 * @DRM_PANTHOR_XGS_OP_INHERIT_ERROR_WAIT: Propagate XGS wait errors to XGS queue
+	 *
+	 * WAIT operations for a XGS which is signaled with error will set this XGS queue
+	 * in an error state. This error state is cleared on next XGS submit with either the
+	 * @DRM_PANTHOR_XGS_QUEUE_SUBMIT_ERROR_BARRIER_PRE or
+	 * DRM_PANTHOR_XGS_QUEUE_SUBMIT_ERROR_BARRIER_POST flag set.
+	 *
+	 * Note: Errors during SIGNAL operations will always set the XGS queue in an error state
+	 */
+	DRM_PANTHOR_XGS_OP_INHERIT_ERROR_WAIT = 1 << 0
+};
+
+/**
+ * struct drm_panthor_xgs_op - XGS operation
+ */
+struct drm_panthor_xgs_op {
+	/** @addr: GPU address of XGS object */
+	__u64 addr;
+
+	/** @value: value to WAIT for or SET/ADD */
+	__u64 value;
+
+	/** @op: operation from enum drm_panthor_xgs_ops */
+	__u8 op;
+
+	/** @format: format from enum drm_panthor_xgs_op_format */
+	__u8 format;
+
+	/** @flags: flags from enum drm_panthor_xgs_op_flags */
+	__u16 flags;
+
+	/** @pad: MBZ */
+	__u32 pad;
+};
+
+/**
+ * enum drm_panthor_xgs_queue_submit_flags - Flags for XGS queue submission
+ */
+enum drm_panthor_xgs_queue_submit_flags {
+	/** @DRM_PANTHOR_XGS_QUEUE_SUBMIT_ERROR_BARRIER_PRE: Error barrier pre operation
+	 *
+	 * Clear queue error state before processing the XGS operations
+	 */
+	DRM_PANTHOR_XGS_QUEUE_SUBMIT_ERROR_BARRIER_PRE = 1 << 0,
+
+	/** @DRM_PANTHOR_XGS_QUEUE_SUBMIT_ERROR_BARRIER_POST: Error barrier post operation
+	 *
+	 * Clear queue error state after processing the XGS operations
+	 */
+	DRM_PANTHOR_XGS_QUEUE_SUBMIT_ERROR_BARRIER_POST = 1 << 1
+};
+
+/**
+ * struct drm_panthor_xgs_queue_submit - Arguments passed to DRM_IOCTL_PANTHOR_XGS_QUEUE_SUBMIT
+ */
+struct drm_panthor_xgs_queue_submit {
+	/** @handle: XGS queue handle to submit work to */
+	__u32 handle;
+
+	/** @flags: flags from enum drm_panthor_xgs_queue_submit_flags */
+	__u32 flags;
+
+	/** @ops: Array of struct drm_panthor_xgs_op sync operations */
+	struct drm_panthor_obj_array ops;
+
+	/** @syncs: Array of struct drm_panthor_sync_op sync operations */
+	struct drm_panthor_obj_array syncs;
+};
+
+/**
+ * struct drm_panthor_sync_update - Arguments passed to DRM_IOCTL_PANTHOR_SYNC_UPDATE
+ */
+struct drm_panthor_sync_update {
+	/** @pad: MBZ */
+	__u64 pad;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.45.0


