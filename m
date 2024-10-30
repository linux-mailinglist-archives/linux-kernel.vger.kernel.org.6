Return-Path: <linux-kernel+bounces-389697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF499B7013
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603761F221DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22931F4288;
	Wed, 30 Oct 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aU1RHlCF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aU1RHlCF"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2046.outbound.protection.outlook.com [40.107.247.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C21CF5E0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328886; cv=fail; b=rnmUxn2ib4rpg6XuRL4emYID9x4MbRdvFrlB7QWNDZAvwcU72aB4c8HrveasRlmt2+0f9YGy1sf+nnU8t6KLosdYL2xS/xM77sbDhKPCPue9gT9aKGomtmuKhmTLP5agnUem8kdDpYFULMQtTQi3D6o6/ZWuR0IJCb1noA6XD1Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328886; c=relaxed/simple;
	bh=rlkcQbHmT59an0hA5sZjOehOj6/xkd5+Vj/W/sy08TM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HqKgclCg4IPYW6nTWtTI27Enhk9HRBV2SOjEfQi1L4eod3rkyDBqCpr/li7dIPLyxgu0NAU6FVRrPJPBsi6bCRs4HyqsssUe/tMYwJnK72cGfG3FU6g7QAoaVn18B+o6ES+I3lff5ZbT6gb6QDKvO/w/lvKmHh1gBmbOyykk3is=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aU1RHlCF; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aU1RHlCF; arc=fail smtp.client-ip=40.107.247.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yFzQKDkSQRhCuV1R+lv8KonAXA2etKFUnb/oty7vhfG+CsgizptD+ZcaKSXatAECrFf6ee88plLlIonvtb1ekunonfcHRt5wm5ZPV5/tU/9dsMeAqlUV4OlEPPx9S6R8VPg5xb2fHUb0XzzOo4ihEa9qsBbhVboLJiRm4QqCQXXVeMk76t54xZfO2oiRBc6yAO2TQbMwcRkz8i8z93QjqdNeyqz/Brm7O9yLkyvBGLWVl+yBNm28Xyf3VGfieL3kYtHoFm+e7iEyrH7Fal6B5tIO0Tx0qyEhLfbOVdCOCGh84BckzUWkdORfBvsLHaAKpa1ot45naXLhBTiJttxkmg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK4o6Tefj4JpBNHe4RLQZrUUgg5f7o5vfnlnfGnlzgw=;
 b=rgVgLXvWZPh1qOyJjd4Cflbt8yC+fhAB7ABOKw2YjDQACAesJP+Kud8il9vMNY9GvZcBNDYzfdW62Hd1pf3Dq/kAcvHfvhq+WMGU4MbTcuHiHwt0/lvGX/jFQ1W2pNbRJK9qfHdPNVx55XpP0b2jDP6OKen1SPC8KBzHih3v5+P9Ih8wzGP3gjutGO03SDkevNoMt9nlliHnf5bGWZQalYfGcH7V9KfZAhQ9W0fhhxIlF+o6mbr/x21+Ku9rvcqJx0/+c1LNOF/X+0W5uCVVWp0ApNCTpuK1m79P9x5i+WF/E2z6iFfYpdA6w6wLak7KVcED3gnQf4rjMIwVycMHVg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK4o6Tefj4JpBNHe4RLQZrUUgg5f7o5vfnlnfGnlzgw=;
 b=aU1RHlCFbhTMmdMigIvxSpqrvd2uaz9VhRJ3iSW3jHjOiKuGWNvHI9g32Q2WV+KogPsOlrnbT9v0s/tXR0dPB5UD0ViGEBpPvoJUPGq4sEefI5ITm3uHMJVpsqTbzDJ+vgdPzWqgBYLeOQ+8ZeNkUjHmbYwHXLhmXwJeKTa3j9M=
Received: from DU2P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::20)
 by AM0PR08MB5506.eurprd08.prod.outlook.com (2603:10a6:208:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 22:54:37 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::98) by DU2P250CA0015.outlook.office365.com
 (2603:10a6:10:231::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 22:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.16
 via Frontend Transport; Wed, 30 Oct 2024 22:54:35 +0000
Received: ("Tessian outbound 72f4d55e3d4f:v490"); Wed, 30 Oct 2024 22:54:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 03d1a4fc004013c3
X-TessianGatewayMetadata: SP4WAxw5ZmtqAlg2KuxKfPEFiP9Rvmb2mSdFiGu0+9pEV8pq2jET1mJfQfMsLaYF7Zs9ly82xeNJlPJhajFYBy9Xczt252vItmr5+OiD3lUV6HdEnRjqRdXC33nh0obQNJ1UyW9Cq6DKnEV5r/krDxLB5nXmbnxIg9cv9SzX8oo=
X-CR-MTA-TID: 64aa7808
Received: from Lfcbceee7cebd.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0109A1A9-6CEF-4526-8C5B-03D0795D0DCD.1;
	Wed, 30 Oct 2024 22:54:28 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lfcbceee7cebd.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 30 Oct 2024 22:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAdnklYQtxd1wCpNw8EEgy3xhZAbHvXrYmLNScJEPdl4auPgZSkBJpYtqdE+Iu0zVyH1u5UpRrtiTk63VfwBF0vzc3wPQ8mhW07sSnQ/0I23WXSyo657Lvgn7wBeNaHGQmT4g/BfZ0hzR7GHo27eZEmT/HaSqEpfLWGpE5mQtp3UKx1afu3dgSN5H17OLpNQcO7THJZE4lQhYSwpSTgVr+n+oORE+qpYOwuxI2Gzejgh4AxnHfDsrJdjKTUEzovHAlORVG8thBv5Mw5JCD6CYCpWnCcJg9i/Q38k/kDuhH7S+MkeIOyKIGW7T5UCFOOBLKXZiVbiBqFPNA1TgG3YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK4o6Tefj4JpBNHe4RLQZrUUgg5f7o5vfnlnfGnlzgw=;
 b=VxSFNL5W8aKlRgH3APNCzYZZWkmAYKIult288UxhTyhgwA34fYnvu+Ay8tPTzrmc0ZsKBxnMBsR+OCkL+RmAzpDEAPNdDa6bPm23Hzvd9jifA9EuG1rivhKCIZ6bzYdFRGU+zWFnSN93f0RosnLB0qcmJ9g+sQyGCj6HsrSHcZefCdJ9yka1ceduIozMiAHNAUyh3NUdWf0LXRchAoVTG4mRcj0tC52Q95MKOiHtiH0u1nZI1teHGfLrb5EpE0+05BcEnhdTza02zPGHwGWFZstnuRLosqO4/dCKIxwYn3j3tswwpSuj1BRmUHwFnM+C57ZSmp8MZEUmgTABpHqrKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK4o6Tefj4JpBNHe4RLQZrUUgg5f7o5vfnlnfGnlzgw=;
 b=aU1RHlCFbhTMmdMigIvxSpqrvd2uaz9VhRJ3iSW3jHjOiKuGWNvHI9g32Q2WV+KogPsOlrnbT9v0s/tXR0dPB5UD0ViGEBpPvoJUPGq4sEefI5ITm3uHMJVpsqTbzDJ+vgdPzWqgBYLeOQ+8ZeNkUjHmbYwHXLhmXwJeKTa3j9M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by AS8PR08MB6182.eurprd08.prod.outlook.com (2603:10a6:20b:291::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 22:54:25 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 22:54:25 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com,
	liviu.dudau@arm.com,
	steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mihail.atanassov@arm.com,
	ketil.johnsen@arm.com,
	florent.tomasin@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nd@arm.com,
	Akash Goel <akash.goel@arm.com>
Subject: [PATCH v2 0/3] drm/panthor: Coherency related fixes
Date: Wed, 30 Oct 2024 22:54:04 +0000
Message-Id: <20241030225407.4077513-1-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|AS8PR08MB6182:EE_|DB1PEPF000509FE:EE_|AM0PR08MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 2154f6f3-9475-46ea-c705-08dcf935d330
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?t+wCaIUS+aslJmWXRFoi/Zuy97DJJupEQ/aCipl6UIDv3zL7KHrRq+S6uHqW?=
 =?us-ascii?Q?c+WLRqifS+JUtd2jsvRAhXIxRkXOwhygwg2nkZ1Z1eUIppMnK6oC6lLSPtTt?=
 =?us-ascii?Q?Uv/3Uvv1cxjGDgGEpOxR3x1yQGErzywIItfWSm/19RyT0LIm+75HRzOwIINp?=
 =?us-ascii?Q?Go70yxgladgUdFPNrML0l/2SnNOxgLXp7fvUdNnYoFbQC6Jn9YTAL+l89FQa?=
 =?us-ascii?Q?rk1Y0mkhzewPozTzEINUJ4ci2wO7O3+7cRxBY5nu6XOItpo/5nS61VDGz+2E?=
 =?us-ascii?Q?jiUhgpfpCVXXzUjcPIff8CjjAKnbrNuq7FdEjtnmbqsQL/JMV5Wsowb9BmvS?=
 =?us-ascii?Q?271sJzt24zATte4hmOBCfznv7I7lRRJWeHZo+jqEkWfyqjOgZCI9980Y2xXq?=
 =?us-ascii?Q?1T7uFrTl7WZrvGgqaWKE3cLoXB0gQT0zMUefmhO2lsIBS10gSHYC4HVGndU4?=
 =?us-ascii?Q?xk7zXs3iDj/WvIZjI97BSRGPvM+BjoDKChVAsifFPsnhM3wmmvH2BagPTCx/?=
 =?us-ascii?Q?7+N7DtCaQv/8bBP5FRlwiQyw+vBcIKHeWHgwRbUYJKbYZxK6q8bU5ZsuD6Iv?=
 =?us-ascii?Q?9jFBIXmdpyFsJR/EQwPJVErCbvtU4kG9V3o+TO/znTjWXYfAvWhSx+pCPKMi?=
 =?us-ascii?Q?jzYm3OGotg44HzlI1sdDLwCpsKLnf/MU0oXq+R+sphfb8XMu0nDqraU1fFVQ?=
 =?us-ascii?Q?oYBcI1EefSVR4kB6MReMHy+uPjO4T95Wz2bHAIUyP02wfiT3GGDs+j6dvZIX?=
 =?us-ascii?Q?m+F45JglR7QnANnJitjoZZ5G7JPII46c9b9YHRgGL/riOE1HUN2fzijYH7QW?=
 =?us-ascii?Q?LQ88zwpBgQpga8zTZhRlwlz/xBv0tAWvAf5SsmdETLuaUQK3guuyr4LlV0tK?=
 =?us-ascii?Q?TWj5nExigFc2Ma7/iMJXUm5bXPNFzclHL4XvopOfevWH/1JiBhVVoNcJSzRR?=
 =?us-ascii?Q?Juj0e5MZINjnyJ+KfDpCBN+2BsKN5A8QPOTeYteaXU32wp8s1rkg460zekvH?=
 =?us-ascii?Q?VxXf6fpMTLyZ1NbNby9eFE2Rx2GisewG2JHrbUDML4ZyC5H49nnvQ5fC/h2/?=
 =?us-ascii?Q?uBAjyAEvoaaYgdK+S2m0HbzxTSg3I6oJ+ueB/O9N046732v8UK5sj3CEA6ch?=
 =?us-ascii?Q?FypRYU6p1CBeVqSvYwOhQvO7M0st7RoRhjuVmZj8jGH0Ja/UZ6aeapoYfNyL?=
 =?us-ascii?Q?I/EGixAK6a9BSX7YWub1MAHfFaiDw5eBnsdFUSWdN+mAVMQQizBnx/uOD1P5?=
 =?us-ascii?Q?g8ovImmfSvnbAwWUKTCiEFZXM0y+VFhLxifoIvEN8MBmF4T5rFxV+9U6njoN?=
 =?us-ascii?Q?hjTIVEIPAlYgt+tKUdcZ996o?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6182
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	362eae3d-6668-4cbf-070c-08dcf935cd7e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MfMOoCui4Qn4NI3LoRTzuoleyLxoY0DE2Jdb+7cpY3kUVDqabIlN0Q194vxV?=
 =?us-ascii?Q?2ByC8I7U9EbGIS9+fxFBKF3hnNxBEEZ8ODhLUUM9hkoczrwTdwrv2eKgt5n0?=
 =?us-ascii?Q?stEpeDHm8y377uHf2c5/upIGIPCtp3bu97EQXCyF2QQ4Ro+pqaw/EcmybqcJ?=
 =?us-ascii?Q?6KqYTO26TNdXjdML/kEsqIxWA8IryT8TFrF1pE8p2djWnY/azdqwmdb9Fahm?=
 =?us-ascii?Q?w6uJ0f01MtWBOtJK/IpnwLyW3LLaFABXriYNjMvzS+ozoS5zoQekczyyLrrH?=
 =?us-ascii?Q?rna8K+RT5ICRMGv+mPdhh/DPeGC5gINa06wGE+g8GdG5rfyrRXpZQElp3AkB?=
 =?us-ascii?Q?dr32qw5n/pvqreRHwqu05J+iMrfz1LYnXUU2weMsYC7k2ytGSH8GvRPqpP3O?=
 =?us-ascii?Q?oug5lTPksUxCkfLH8KgdKJoS6rxSYMAIxmrbWjOFXld34FRt6xCIr/tY5YgB?=
 =?us-ascii?Q?PnCPMVg1/hf9aEdx3+cQzBsggCG17UfN0ySdPWfEh1Yv9x+ORdzsbONEnLCa?=
 =?us-ascii?Q?8OM0537c74DWf425Yg2QROL0WDbA9Mje8ojzCjYmgdiTEaMuMUwayVfIkPj0?=
 =?us-ascii?Q?/Tpyw2vggtkhRkqEFElJWqJImDoQUDnPOCuwCMiHCA2g0A7Qv5Sjag++ljS6?=
 =?us-ascii?Q?bK+Pu+9nCtBEZDi1rftPLQf3FsuQVmjYbQeshglkS3/XZ1fqM0x9nST73VmO?=
 =?us-ascii?Q?wr8sAqwQKfKHjb4JmEXr42TS7UEUAEuVKKJIfoTQ9hWqX8dmqko4BvN1dQ/2?=
 =?us-ascii?Q?7VkOEDg/tC3ISrGsJv0kJfuBxEOpQlOllmyi2bQUH9JABggUibyoVV2LzqSd?=
 =?us-ascii?Q?LEieBMWSz8GRbWKlTCVdQP5E7v6jR7YgwsfNq1gLDuuqs3SA5UC9siY0MscY?=
 =?us-ascii?Q?JT6eL3iwJljDGgGRUJJTrSoy50DqIETj8XEIOXmzsXgSIQCnDvkSzDiUmFt9?=
 =?us-ascii?Q?uQ/BaLsirg1c2A9YQJS1XaCZmDokV7/9tzBWZ4jwv6QNdUGHo/6DlDPCEIJP?=
 =?us-ascii?Q?VoM5B1YRa+b5BMr1qWfFIJZzjXoCheYKuuZDUPXqVLYi2CCq6VJxTH7Ncl2Q?=
 =?us-ascii?Q?40iwc/DAQcVAlQ/MAV6/BakfHKU1jeIg8tmnMpnobYn/aVJif/0OC7E9FKsC?=
 =?us-ascii?Q?4TkAToIVf9vDL3/3QFpyLalfkjucqMXBNcued5bGdxgSwWuwHHsodMNcJ79r?=
 =?us-ascii?Q?6nzXpHMwiJPyJ2/mlqp9uD+cI+ICoECduER50eO/syixifbmdIaXQm+6dyir?=
 =?us-ascii?Q?OhaukppBu/epyxWWKX1EwS8Xk/DetNczs5j9dYOSyb+N/pwgxbpzrwdjrrLW?=
 =?us-ascii?Q?ftjJ8eX1iMnpxSrwbc02EoLtMLyi0lZY7X/+63gFWpbPSH/qhHKcceuvFuzV?=
 =?us-ascii?Q?UrBZc4V70vSWjV8Fmm33iluIVsqqyPsjMInUPxkFCdx2G+MQIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 22:54:35.1539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2154f6f3-9475-46ea-c705-08dcf935d330
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5506

This patch series contains 3 cache coherency related fixes for the
Panthor driver.
- The first fix, regarding the Inner-shareability, is mandatory to
  ensure things work on all platforms (including Juno FPGA) when
  no_coherency protocol is selected.
- The second fix regarding the coherency feature/enable register is
  required to avoid potential misalignment on certain platforms.
- The third fix, regarding the potential overwrite of buffer objects,
  has been prepared speculatively & it may not be required in practice.

v2:
- Added r-b tags for the first 2 patches

Akash Goel (3):
  drm/panthor: Update memattr programing to align with GPU spec
  drm/panthor: Explicitly set the coherency mode
  drm/panthor: Prevent potential overwrite of buffer objects

 drivers/gpu/drm/panthor/panthor_device.c | 22 ++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_gem.h    | 10 +++++++++
 drivers/gpu/drm/panthor/panthor_gpu.c    |  9 ++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c    | 28 +++++++++++++++++-------
 4 files changed, 60 insertions(+), 9 deletions(-)

-- 
2.25.1


