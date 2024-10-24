Return-Path: <linux-kernel+bounces-380139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8049E9AE96E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40831C21E98
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E151E7C0E;
	Thu, 24 Oct 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M6MnQW+0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M6MnQW+0"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B11E378F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781718; cv=fail; b=rOHCqE+I55znqVqnoosd2BYgS1CsvO1C5tx0LCDemD4PFkKtFBVzGpDmPc164OXUBSlyPIlbD8XehkuFCjPTmLYdOsl68I48jm3lIS1Ma+u1sfSk0wGyWdoy4BDNKU9UJe8jaUK+PL/SnG7HkHqUsMWnW6F3vYbwVP/sfTCvSWM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781718; c=relaxed/simple;
	bh=FllPSsmj+UpsYp2e7Zy2Mk1nTmMvW9IjR3Bafvj62lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I2FqmL1KcVTKzIYv2zHJNdcVgLE82eZFSD5FupTmZbrgH0MJwyNIwu8flbUI5v2ppIEjjoNC6jiT2LosQYXd+yRmTFnuSo0qLgHUv15FSdfYp0tK7jTB37DUD8Gq/60QHfe0vzs6w9xyUfbgM5V4GKFCAqQ1r29R9hE2V4BdQBA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M6MnQW+0; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M6MnQW+0; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eUs41xd8N6QpwBIxQMlZ3qA+BxMTY6TUJltjq1GyO9bDY2bELEkNMFwvfiXtitxksH4BGXRZSB9Qt4zrlq4XfS5vf3jpTZJiZCJaYDQlHnJdeiVBWdvbCFphJ2y/HkUmljV/5JB29HOnobW6psqM3RCAv2d0jT5kKETL+9kipAf4NV4o+znf7B2oSqvnmmlbCUmHcpj8gH1RXz79X8ruFLTXc5cvqB4k4LfaAVyAjCc9qwLG4sbFxS3gD1AYjMP0MatabgAo5pXrX0ampTPB31PPlsMU9x08/5o2sW4hSDCBoUIfJ8kha6zP871BWI2mbg6Dp0RAu2ExE8HOiBV8IA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1k6AHKcebCqZS9bf/ulWbnrH3kW6rKUZhzlMa753s0=;
 b=O+g1xR6OS88EOVBuw6blm5m3GfWpUSWYh4H4C8Iym3n2u3zAX6YcaTJehFB1yYjK/RCOfhKg7R54rqu7XMj7Qpb2yUHshIqUGgFOggxenepXfS10jg5ueVKMsi1xNno418MpxWat0PuRlbRlgwlfQVccfGdQ2KRqiG1PVhcQSCQ0WwqAXGbvN8i4mTB6OffO8fl5HTGLgUU5n7ZlN6ngy8pDoTRJSygdHELvzkx5bjw/90YWHkk8+DLrvk/fon3dRauiC/7SGC8j9FZDfPWnsDca3HLU51LhjuhMwSENNgAr/5ugoWoel9/ebJnJ9k89lRMRNWpekzAP6iY9yBcoIQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1k6AHKcebCqZS9bf/ulWbnrH3kW6rKUZhzlMa753s0=;
 b=M6MnQW+0PXO0/6idWH9wqnWl4F2w6w7oh0n8qm+WpggiADi2aNCe6vDTgwX31uLhqbl1xlpZ8lOKvLsCBKyxtvp11nf/c0zyAdTxpzmYbE4UNXYhPNmM0WpISuYMiv9qygz96TVDaUlgtMmyl3Vd/R5z5AXjmm4UT+1q07jPgxM=
Received: from PA7P264CA0240.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:372::17)
 by AS8PR08MB8659.eurprd08.prod.outlook.com (2603:10a6:20b:563::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 14:55:10 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:372:cafe::57) by PA7P264CA0240.outlook.office365.com
 (2603:10a6:102:372::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 14:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.2
 via Frontend Transport; Thu, 24 Oct 2024 14:55:10 +0000
Received: ("Tessian outbound 99870d44e01c:v490"); Thu, 24 Oct 2024 14:55:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 717ff9876fee20f5
X-TessianGatewayMetadata: /arqyLPVBFlv2vFa+ySf3E7Qt4WbzNoYTKAxL09H8rUbD7+GsW/VBcAM0569anH9Jn+18wziLLWIBbdsW6OTR+Re7UWgLl4/9F0YzHlDUsU714nSdp2sQQ7p3DthtplMidhcAYUWwT2VkhP3Yh28HMvuGf8N8msHMO/PhDJoRqI=
X-CR-MTA-TID: 64aa7808
Received: from L054ac04ffbd5.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 205136E1-5B90-49D7-8BC9-5B130364E637.1;
	Thu, 24 Oct 2024 14:55:03 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L054ac04ffbd5.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Oct 2024 14:55:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqN0uibQmBxx7VFfOefsRJkb5sdbxmMrAJ15BGsEw91BDp3yvoTAeDffrrQHYk8DQXeNWL87inA2jCLmA56MIU4Gho200Csi+/KNa+2irGcc819QUkmhsx/7f1yhHdNkZ4+XsXJtYLXTCanXzgXj4Qag7ix+vpUz91qzBobypYps8eqtOXP4xNec+N4KtbYIZg7SK8YPAXRw39jQZLYe1R9QaJCgnP3VgEVMfsbJT17yLosoO/kaUC2G+KWynXjo1dESZhpRYrIjmNoeA5GSG1iyO51f4wwohEB0s73RJ6kiDk8dTOot/mxbHP+sb8ICqLYxBEC/KG0pFh9kZd6lLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1k6AHKcebCqZS9bf/ulWbnrH3kW6rKUZhzlMa753s0=;
 b=gRgQzs+wfkuYlBM7MNb6I0Bzr6+I4pBH4NM4nxEkRgbu+QWRWwW6Os3HYhPBAT36LxTydXnsx1pS7tKOsE9fmsdEPHEBMhPHKoYVXTVrA8kzP60KWb1MwgRLhuoGT16lddRdweVsi0uGP+fWNOsZjk9/KwfelANrKQYP8kGCnfzPjWa2A6VzI1fqKgLTmQC66ygHaPPq4jGVkomePwxZ3pQnfXHQA83avhcjLwb1jCQs3ozQkMuNv1LM+mY0b/ZI1kO8m/9g3ni0g8q2bJntTAigRxfQs7BtS7xom06I7beIurKN7gcnmsIjzZcDF7s5yopvbMObTQz8P5vC++Nj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1k6AHKcebCqZS9bf/ulWbnrH3kW6rKUZhzlMa753s0=;
 b=M6MnQW+0PXO0/6idWH9wqnWl4F2w6w7oh0n8qm+WpggiADi2aNCe6vDTgwX31uLhqbl1xlpZ8lOKvLsCBKyxtvp11nf/c0zyAdTxpzmYbE4UNXYhPNmM0WpISuYMiv9qygz96TVDaUlgtMmyl3Vd/R5z5AXjmm4UT+1q07jPgxM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by PAVPR08MB9650.eurprd08.prod.outlook.com (2603:10a6:102:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 14:55:01 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8069.016; Thu, 24 Oct 2024
 14:55:01 +0000
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
Subject: [PATCH 3/3] drm/panthor: Prevent potential overwrite of buffer objects
Date: Thu, 24 Oct 2024 15:54:32 +0100
Message-Id: <20241024145432.934086-4-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024145432.934086-1-akash.goel@arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|PAVPR08MB9650:EE_|AM4PEPF00025F9C:EE_|AS8PR08MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: bf42d7da-8fd2-402f-1dc2-08dcf43bdbc1
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?VDlZ/mJOEoNsY94F+qCXfgQ47C+PM54oxcgDpRvq09OY8i8rUGteUAOqt2sd?=
 =?us-ascii?Q?7XjJbs0zbwOvSIzGk7ojyJgzaVSkhcGGcquKheSWfYfoN4KTYpp3QqsByOHQ?=
 =?us-ascii?Q?LiR84sjMSVScLww2sy4D6dHFrnpO5j8EdIAePw3Z2kpRDURG0ZyJddJLUl6H?=
 =?us-ascii?Q?kG4+JdC8Tvi9WrVgEVSvnfHnghX6LQfjJhIj1w6eWTfYDWbzr8pF/a/BdOvK?=
 =?us-ascii?Q?PWIE7g48+NoF68QyyfXh74ydSn2UV3Ln1EE65jfipKTKlUQ0WAPjGUSyimy+?=
 =?us-ascii?Q?5EbrOUxuGQKtBB+eTZxPU0pf/oh9Nn4bEAjciLDQ0XZ0PxNOaoLVH1AZTnNg?=
 =?us-ascii?Q?G1iLO3exrbZNNEZmWE57cvCELvmjc/ygN3Dqo/bQIRJ5NC4ksA1RyqtR2/+z?=
 =?us-ascii?Q?JDl8ugerFLEr4Ecs1j1ArnLHloy4jbuU0RQfq/s6+PWPbuqILcf/Ec5qVhOl?=
 =?us-ascii?Q?sdjd7U/EMjZNqXbk1qXYS8Ma4gdj8fdyvRTKisCE5hgSXvmNImi7/OpbIwpP?=
 =?us-ascii?Q?chuh0Hun3tuDbv3qenTSRhgELgQWZmE7170UwRutgCi/uJ1DQUBRhsnOi3B8?=
 =?us-ascii?Q?9+g1/XTEo0lRL5tDpHpf8StxOwbn6wA0StcyWCzQ5KimjQNagWYlvlFrJgaT?=
 =?us-ascii?Q?7drmyiWVQqpw8r/NgzmBMYw4KI7wELg/v0/oXNW8+5WR1pN51K3o1Sqhcioc?=
 =?us-ascii?Q?YjpQW/+xzzWzLfMZNXsZH0q+Ncm2uwFm0Z9AzNWqWN569Qlj6j+Xfq+SRAls?=
 =?us-ascii?Q?vpf8Te+bYii3vREW37JpisY/iafUElX6zZGrgv4i9rGaACx1VOrrTg2x2fTb?=
 =?us-ascii?Q?IvApdkIQ0jtrxWl3Np+M91Z12NH2kBIFuDJzO9EpU7zwO/MinrYn4emTuCQo?=
 =?us-ascii?Q?yybfqUnoROozmbj5ykkcsh762uan7wlFL2YhGzT6aevWytr1bpOKJUpuI2lH?=
 =?us-ascii?Q?ShDhmcpeWOAnPgbgATrdDUWehb4EIpfpbfK1wJWtKZ1tj35cXpX/06dEQN00?=
 =?us-ascii?Q?uwMpnmnOsOq/AEbSGrteErR5cnIQepRjaGN3OTM4J18bUOzolM2DqP1v/nFI?=
 =?us-ascii?Q?YY7QqaLh1GAd+3uG9iJgT7itltK6BKSqJeYwPlhXppLYShe/KW/FCwk1Nici?=
 =?us-ascii?Q?OdqtwAMNtMTod+RWuM2Vke3NqodqNyzFAYL1Y0iBIFn1pN+q3xO3tP7Nn7cg?=
 =?us-ascii?Q?bMTR7wENdn9AdFvJbCHsEtGMfl2uW4hYrbSRIkq34ouB00p3XpzOA41WMm0X?=
 =?us-ascii?Q?xJy8DYS8F8x/uhKZRhgGK6jMjfxOzLfOc0ZH2LHaegMA6o2rUursLC4RfoyV?=
 =?us-ascii?Q?TzeGJMemi9iCdCFdkzcfr2pX?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9650
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	212e5514-41a0-4060-31cb-08dcf43bd673
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|35042699022|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PjPT/yXkAEYIWnSAalM+yYgehQUmu9eQvRWf+jSDuuPqZuunTvdEdAzt1UTl?=
 =?us-ascii?Q?o4PcYhWOD7Jac+B5PQr6allg2XbTAc3mudomVS9LMPwRqH2PgnSuBAK3wdLP?=
 =?us-ascii?Q?u/tTfWvTCsViWjcbySffN3N0A9sI8/bxnzDRrnuAZuiu3qEetsQz4JFBZP66?=
 =?us-ascii?Q?b8g7lcbj5xVDrhGRq6yJzKEYTMp6HMhhKeazi7WAhPVFzlwyydjYV5eyXvph?=
 =?us-ascii?Q?pwccH9IcFl60uRYEt/nEaP/gg73SZZcLnrRfixsaBFQpcopGYl2F9SJbnTBR?=
 =?us-ascii?Q?mhBFe71B64trtX03qXYore+wJVjqAGQ56FTS+931plZHUM5Yq+EO7S4ac/TH?=
 =?us-ascii?Q?4bVoNu3inZ9+w6qgRWE4KKfu+y+k8OnsH52Y1z4CASr1iQFXUNhrJ0WCOy5x?=
 =?us-ascii?Q?V1TdUUgNtxRs0CxYhdg43NLJ90iJX1er8vywN/xA7OZvzJ+DNx/Q2G+DxjOT?=
 =?us-ascii?Q?9VH+zeolJmCkEGbjgqlYRAYcu3HgrW2K2G0NefoogvR5Uqi6nhM2w11TgbuC?=
 =?us-ascii?Q?J1J3wYrguFBpn7sF86/x6SxpKJKj0StBvjvzi8aNUc64tFBSsMifvE+UhvXN?=
 =?us-ascii?Q?pWOqUm3GjfbyPwPiqbJirWr0ejW4Hk/wqo9m3MB4KQroSHkqOdYkHPhJEohB?=
 =?us-ascii?Q?ZTPlxptdkh4q6vZPH4h4hCF9/wRlKexKxt7l92bpId3REtFql3/IFHZk3FPp?=
 =?us-ascii?Q?8NE2gfBKpSS18/jPEJEE1gcZTnhPGOaES14zIXuPbcWJH8Ecr4rf0klTZyoc?=
 =?us-ascii?Q?459M1TO5/S+E1qTU1RjNGrYWVGhOkK6o42HX0ACfpotfuTZvAlS2zxEP77XE?=
 =?us-ascii?Q?Shq9hod/JK/HPp/fdQ7TifT4rA6AcDEfygHjDSRGuZuY+jhBXpBVDD0imTnj?=
 =?us-ascii?Q?45D+m5d7k93TOvw/wda6JHVALQz7rwJHk+9Tx5s1gsBnuO9zfam1ewnC0aPa?=
 =?us-ascii?Q?IPO2sJdlhjVLkuO9Eat8STTHJ1z/xUSutG7MP52yVi83QArDv/c9Pr6H4yrw?=
 =?us-ascii?Q?wYyrId2nYqjpKvvPq56Cl94EHEvaOzzopAqzDowCKx3EyBYevv4aYPUFnmdT?=
 =?us-ascii?Q?uBY1dzCP9xFWs9kh4FV1uLdxb2E1twAfProzqIJhYLnLgsxGA3F/+uhaQBd9?=
 =?us-ascii?Q?y5cdaEFE7fznvP69rr85ERrrntMVbvBvj2TOc5xkeuUFyIKVvYOUKF+hyD9A?=
 =?us-ascii?Q?EHp/ElQSU1bM91NB5hajukqAH70h4mOHwIZemqF/wRwUNc8lha9cO+4jzjpj?=
 =?us-ascii?Q?pXobTHP3rRC08vvRpUX4FOe+9fTNcvXnM6KmOQ2Rq1lRlDmKOoPP7T2CdyJk?=
 =?us-ascii?Q?dfEhksbpHjm6vzqYulGhzj0xTOvN9GXK3TKs00MyFKkkUe8uRzlFsvDhYd4k?=
 =?us-ascii?Q?jtLxzsFVie/z6QayvNg7zkb3BneLHW6GIkz7pcNLbcjCack4hQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(35042699022)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:55:10.5788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf42d7da-8fd2-402f-1dc2-08dcf43bdbc1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8659

All CPU mappings are forced as uncached for Panthor buffer objects when
system(IO) coherency is disabled. Physical backing for Panthor BOs is
allocated by shmem, which clears the pages also after allocation. But
there is no explicit cache flush done after the clearing of pages.
So it could happen that there are dirty cachelines in the CPU cache
for the BOs, when they are accessed from the CPU side through uncached
CPU mapping, and the eviction of cachelines overwrites the data of BOs.

This commit tries to avoid the potential overwrite scenario.

Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gem.h | 10 ++++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index e43021cf6d45..4b0f43f1edf1 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -46,6 +46,16 @@ struct panthor_gem_object {
 
 	/** @flags: Combination of drm_panthor_bo_flags flags. */
 	u32 flags;
+
+	/**
+	 * @cleaned: The buffer object pages have been cleaned.
+	 *
+	 * There could be dirty CPU cachelines for the pages of buffer object
+	 * after allocation, as shmem will zero out the pages. The cachelines
+	 * need to be cleaned if the pages are going to be accessed with an
+	 * uncached CPU mapping.
+	 */
+	bool cleaned;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index f522a116c1b1..d8cc9e7d064e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1249,6 +1249,11 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 
 	op_ctx->map.sgt = sgt;
 
+	if (bo->base.map_wc && !bo->cleaned) {
+		dma_sync_sgtable_for_device(vm->ptdev->base.dev, sgt, DMA_TO_DEVICE);
+		bo->cleaned = true;
+	}
+
 	preallocated_vm_bo = drm_gpuvm_bo_create(&vm->base, &bo->base.base);
 	if (!preallocated_vm_bo) {
 		if (!bo->base.base.import_attach)
-- 
2.25.1


