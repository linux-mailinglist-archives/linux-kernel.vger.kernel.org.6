Return-Path: <linux-kernel+bounces-569969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B64A6AA48
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E8E3BBCBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E01E5201;
	Thu, 20 Mar 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="poCV5M73";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="poCV5M73"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627074BED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.74
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485755; cv=fail; b=O0c6JgOfZGLhyFC11TO4juYdH0ngn4C4vlq4BUOE61L5kS5CNkkg9Yoxoq0dYiVPKNmZZrpzzUTgkP4pjQN7GaVj2MJ1fWlFoMFL1cgumy9MEm06s2Hd3GRAOhA0908WloAtyJ3oe1Zady+K5TbMrwPNIqqMCVhoS85Z0xAk/Gw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485755; c=relaxed/simple;
	bh=ghbHPy5wtfBDG705uPSvnxtun3roIP1vBGB95BvDkeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BOEC7NP3H/Es66vYmXyc06QDWMwqkiDIcUwe4mm8GbuRDdixManjtV/3XWGM+Nkum796JoIxZzHe0qU1XlPRhVFtVmfg6dPI84Ncx4onpEfPu3A74rnpYIJYmi2xqKXUKaPXQDsGc3kYuIVABg6q5QInnIV8yuPhPKTBhAPg+2M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=poCV5M73; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=poCV5M73; arc=fail smtp.client-ip=40.107.241.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jan+IfTBGorSdG3Ru4wEDFpQD1cmyY3buPFgvai4qgxOcRCKqgM5bKaukJxkpzZnNMVU/Gjqp9W10gZx8pDm88EysRX7DAvLZ6BdmWP0DIT8p9oPQSU7jurF73Y8QfJZ7ugD5UZVJeQONktEZ8D0/Phd2eWkrMUeK3CdeCAFvkkksfzIRCKCFn2hke8zu9+JL8bPcx18mdT0y/TuJmEsF8Sjgd92sxV5trVzr6ETeyFEbkh/iKEuYnDhyblR6/51Hjf1kqrzDIcwWYlqe6oQ6l2K77fsXJ1bwUE2tuM6Xx9ClVbGPNF7Wtlt8wZp8mml84fly4EdX2P5NhxNUsa2Ug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtSl5te2Ejwe3HWh23jUS+g821nGOJGcEJXqw5CX/KY=;
 b=PWGskK4DyJSJk8ih0BPUQXBDo3r1HBEgsL8ukD3XDYkQQlS/zW8ocOVal9J99+b6LlL/dmR6ub3nnVhxlc4MEBxl3pKxVYeSecwhxsuFRLn/TcuPCcio+K2zDmmY9/vtdgW9synoK2qg/r4ba/3C6NLySJ5MuVnMndfu2cfNWs+QiUYi0OHMKihNsUXIpZKnnVlhu6n90/XhVLIyvLawDwM38RJ5Vb911m+7NNUtiEuMgDwBahibzRynmnWooQ9TKh8j/bvk889T/8QPorG/bY/KKHjNL1MlOf0OuT+D97Vpfj0oxxZAhwEzxo8OnomJXsRx6P+cUrtnRFK8oKzrUA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtSl5te2Ejwe3HWh23jUS+g821nGOJGcEJXqw5CX/KY=;
 b=poCV5M731rNmjUaaKbU5iECRtz7o54+WRvR+/7qQ0efN7piGCfCJKz4+4iN62VveJYRkvWjW+f/wLXpzJOX/ciMNS4cvwyiNqVBT8Di81tgJbEQaH0ih7liMFNFJ/17lbRcr/6+oUeuv4x3jE6kAoQGbjapN3au72cMlaitr4sc=
Received: from PR1P264CA0192.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::17)
 by GV1PR08MB8475.eurprd08.prod.outlook.com (2603:10a6:150:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 15:49:00 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:102:34d:cafe::63) by PR1P264CA0192.outlook.office365.com
 (2603:10a6:102:34d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 15:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 15:49:00 +0000
Received: ("Tessian outbound c541cdb55eba:v597"); Thu, 20 Mar 2025 15:48:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c0c55902ceb5e97f
X-TessianGatewayMetadata: oz1CWi7ZcfQC6qehWVMvtKsn26LS38K9qFU8a3MQ5KhgaZcIC9I6fNnBHFgl8BSPXQWPiseievNI1EtFAxxAwYZeQ2xV5nrpxmL1XMwBaSfuAn84+hDWAHgmjPxFjdSdu1U/sWRsS9obxsooO82KEA==
X-CR-MTA-TID: 64aa7808
Received: from Ld278db1a9a7b.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id FCD19D75-6D54-4344-B331-302CCCB4BECF.1;
	Thu, 20 Mar 2025 15:48:54 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ld278db1a9a7b.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 15:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/JcnD35ZIafdLZfiZYTJqwOMXaxWaBA5EmT9zUHckuphSBpEzktE/U1S5R0+hwMUYYkw393ejogTUR2ZPoLUUdu7xBzf8joz7x6zahyvmZLUQXiKGK9thFocQQgFf0pPyQtAFie9O5JsRq4kT+ApMgUzkb2d0YObmShOZsbmeK060VRBylJfe5JlPrFtSQkehPnLeF1v4iMLLWz/NC9lHfb1GfePTFn3gp8JoWf+tSkGzBx7j6YCVNCRxm07re4A2xoYFNrU6FDasjEjLfT7ybMjiQ1xdiN97rwMesmWP4eXsLMwKmR6E5wtXgjcXgACGBk5B9DdVu7KWiSSlHwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtSl5te2Ejwe3HWh23jUS+g821nGOJGcEJXqw5CX/KY=;
 b=tJAn9x63BcQRUGyU+0imvKxHwhfhhCcZP9w40JTdg8LkYukwOs9CpP6trnnT4I0YxG8wY9v2Pf4/k1m8+Pdd3lI1It56cXSFku/rAbaNLqyJV7K5gGnZ1VbTLGjVFXt0dxT1/Ed/wBwataG6Bihou1WTTl7roHF0ww3IP51zqNqBolIRGgRHFIqnBwtbrRUyLjmxzVYA656NscXpAWyKJV79NB/AuDjfQH1GmpZUg0gLj/gRpoEKJHoGZqvOM9o11EBSjOVCsPlrUYCFqLxtdQJGG+OOIhrzRlKULFkK2DR1Dp+t0YENnDaGmyQ9qngNvaOsdggWoU3+PfkcYupFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtSl5te2Ejwe3HWh23jUS+g821nGOJGcEJXqw5CX/KY=;
 b=poCV5M731rNmjUaaKbU5iECRtz7o54+WRvR+/7qQ0efN7piGCfCJKz4+4iN62VveJYRkvWjW+f/wLXpzJOX/ciMNS4cvwyiNqVBT8Di81tgJbEQaH0ih7liMFNFJ/17lbRcr/6+oUeuv4x3jE6kAoQGbjapN3au72cMlaitr4sc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB10670.eurprd08.prod.outlook.com
 (2603:10a6:150:169::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 15:48:52 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:48:52 +0000
Date: Thu, 20 Mar 2025 15:48:49 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, leo.yan@arm.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 0/7] coresight: Clear self hosted claim tag on probe
Message-ID: <Z9w44Qq7Mo+kTWZ9@e129823.arm.com>
References: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
X-ClientProxiedBy: LO4P123CA0527.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB10670:EE_|AMS0EPF000001B0:EE_|GV1PR08MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df56d36-7978-4a2d-f6c6-08dd67c6bb8f
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?+zO5+4oZKyeyBnp4IKpBeONVzqP0x50Xg1JzLhD8CmNy26ta6A2HN4Na400X?=
 =?us-ascii?Q?ToXkvwu5Uq1P647AcgIujI0T8PV5sY87xUpFRGtliJe3qIdavGNMp1CgoF1e?=
 =?us-ascii?Q?Znxguoro9i55a4j9I/FUlb+snL1MJ1VTRK9yr5nfyMilscnJZK9mokprgWqE?=
 =?us-ascii?Q?lnF1pW44uvKKBcaKVbjdc53y5dymfDdkgmi5eA2muxp9DgWvQXam8jH1NOyT?=
 =?us-ascii?Q?aT8v3s4JB7gFsGCiHQQ7C8G0wLPsdHxQlb3dM7AR2BJaI17zt5oDyWBYs80r?=
 =?us-ascii?Q?fRvkfGJHzd6sznFqSnXrYvcDpbAHjt1DlO1O12ki7pyWDJGlD7tUQm+DSvKy?=
 =?us-ascii?Q?vvTn1RJ9Am+/pmRTHWNZAziO4FAOm7hJF41AEuupa1f8/EPRYRQ94EyGUQHI?=
 =?us-ascii?Q?28eBcHo/z8lHFqpJLdkCEEZsbtJuqWR70q2V4hLiNqV+WHtyMZ8IGvsmanjT?=
 =?us-ascii?Q?MQTUMQ7krZ0x+fvJ13NYpUUU8kiS7gFEoB6tx93+86Obgv7uc4JEWnDILtI0?=
 =?us-ascii?Q?Xj73rr2Flh3O5fGoZrYXOZq4956XV9YBkDTI0n5B/kRfV+mLaLKXyBDOzyOo?=
 =?us-ascii?Q?crwpTWt3pnX/exYc6t602DV9zb7Fhbf0Ju5puUwoI5N6nabFP8AS6swaGa5k?=
 =?us-ascii?Q?LT+rAM5GrngPTV9ARvav7rblv8aiTpg8+9vGgRYuEYrpn8UWMcTjfjnVMpqK?=
 =?us-ascii?Q?yev6OBc5tTbeo7KDUru2A91w+AoI1SvD9FSufEE0QG0TyCquJbZ3boAaLmIl?=
 =?us-ascii?Q?Z0S+ciVK2eq+8UBi1HYG59SYZs0m7hkn1qFlbA/wOmj6IY4Lg7GUA9PNKikm?=
 =?us-ascii?Q?A82wZeEqI7rdlwuxWiYNK3j/TDEu9XWAud/bC1WNhebYNJkEWLENkqD/TWej?=
 =?us-ascii?Q?Q22BHTnN+oZ6Sg6sdQ5vrXsmm6iIwkEI8ffDGH4TjTuzvf5HVW1dgyeageEC?=
 =?us-ascii?Q?gtRHUt9vUP4BzNlIGeKvNzpHvC7ULrlARoIzfY4xcIlo11tcDsVnjoL+S7/3?=
 =?us-ascii?Q?2kqVnX6uD20Q635yX5oJPL+/jmTMaf3H7fJhMP3Ag5gbcMu8PelDBvc0zY6H?=
 =?us-ascii?Q?v+gFlO3zx3v3ZuZbp7RDOZ3+YjEb6ltN04RNN9ZuDjk/4rzAVwosuNjoRyQa?=
 =?us-ascii?Q?9tCsIoyFiORhfN/074zeFEq4fo9emOwqvub42rvjt2xuSPZ/2jpYT6C6l/pr?=
 =?us-ascii?Q?CZGmk4FY/8ZdGe/IqBr4M0I5JOTZGRfUG02xpJrg3lHCrqm2ZGH9sNBASuTL?=
 =?us-ascii?Q?EKKPviIZqUBSEPP6bxMK3rHN9DNbMS8DvU0T9Azn3M/alVFY+9brp+NmwvVD?=
 =?us-ascii?Q?y84EhbKSltVzZh3UBAUYzNtUYuU97NcShAChyO6N57hNhw0QlqLBNNL5YUEJ?=
 =?us-ascii?Q?L35sItaUJv2lupZYPD99qm30Xdw1?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10670
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8415fb90-3032-4406-d8c2-08dd67c6b66d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5oHoL/f0Gs1VH1fjfl8TZ9mHm3yqmbjMx3ZeQQVqWEj7nu2zjz9c7z44wmY?=
 =?us-ascii?Q?xHJewacFniHKc7jZKydx6xoq4KaC/uFd+w35lXKdfSeHlYm7GfAY0lr+Cm+o?=
 =?us-ascii?Q?+Lh1OYCOdQ9d23EpQl43v8gbGzCWRSVm+BVliHFTRUgTo54ZbkeXNdGgc+L0?=
 =?us-ascii?Q?gFVLkMUFMxr5pMNvtx0fMBwHzPi7XBJcEP9lVHH+0wtFYVKeBfGr5ovfcsII?=
 =?us-ascii?Q?xRgmv+NM4ag3fpr6OSf+3Lx/wbT+qWkkJe9Y3IJaBD3zS/sQykAgYLMwiDbP?=
 =?us-ascii?Q?FRxqdN7c7TXLO5nR/J0YRJxksmg3YpsrdTBl0bxPMKAtJTXBLOEB/YFSmqo7?=
 =?us-ascii?Q?xQZp8H6dIVBCQ28PtZ1cSld7p9zsg47Suax1YkS5cm20q1pPtAKn6ltS4EPG?=
 =?us-ascii?Q?Sq0rKEPrXjV4NsZD4zGN22F6l77MaurxMocCDqpvWmLI+PB7AL94TPnhV5ze?=
 =?us-ascii?Q?cYAiBtOUnJGdi5hxF48wgAA1hRwnlXnxT3OTS0dNyJB7mftREpW1Ku6UF0Fl?=
 =?us-ascii?Q?czA+U+P/NMfqr3J8Y9kpVztr7GigVZ/a/OgcYqeIxKKfk2V3Ie0qi6kOrbVs?=
 =?us-ascii?Q?g1n3qtJxbA+oh5kLQbL+uHd9Yz/oqzhpUmba4072SZUTA3eJYbcXaciGcgc9?=
 =?us-ascii?Q?KSc67SOngrQDGQ/WQyUbXfrdoogCdrW8tFuMrD5+lEC4z90ZgNI+Ewyt9OrB?=
 =?us-ascii?Q?YaPuV0r5hcoxjxANuTEu7xmTmvWTBXPaO305KBhhSGa3zHfB1H1B3emZq8dN?=
 =?us-ascii?Q?2W1iOFBC0h7FrMtwoP4fsTX8wany5m51coKhCD0B54yUUxBjUJcuA4XJTyEB?=
 =?us-ascii?Q?BDTLJTrMorAbzBLliCJMm3HPcL+gr1sJ+HfvcMjkbEUvDBOpiscnuOjEDBgJ?=
 =?us-ascii?Q?Zgz+a3NR59BnRcdjomWMTcR9doLBvXdHgC4nmEPlkuRRURWspzc2P0AtBn/g?=
 =?us-ascii?Q?KwOzbCuBWsgX4vDzVlwwZRa69wnr/A9h7Ba0v9IY6eQsO1SouHt9Pvk6flgV?=
 =?us-ascii?Q?5y5vJ324v8BUXybvAnMRb6aynHUn1dRcF6Q0dHFxos/9a/bDFtmU+dyPmkRF?=
 =?us-ascii?Q?K8MUiJAip9VmA4avnVbf7FedAoBnWMwiHq1LV8IbAuBQRd9GQoon1FRmDslt?=
 =?us-ascii?Q?mJ8RSkP8aCiKWmgk2ZaNnoHlmuaJ08/wesUdGICbyumOfLsTRLUFWvOcA8kp?=
 =?us-ascii?Q?fGYiuLTBSt251w060X8MZFLrlRioObZbkEQyH+As6g9xH0g44gvmSAcBXufV?=
 =?us-ascii?Q?LFLNWajCUpXWE5cDilynU6pcx+5E/4xTRekWSgrS1338c99kopTVxxUOwZ0S?=
 =?us-ascii?Q?R95ySkdD5hGJaBag9jk4eBXZG9BZBBBjAXX4NvDFHiseq7CaKI5rfdzpkaxI?=
 =?us-ascii?Q?pikwdGiTrPCV8IXOkhcBQf+Cf6xOrgqkrdNWqtmVIXr3zHsUFN92ik1peA4e?=
 =?us-ascii?Q?JT7TcVbHB1sFEBD+Ke3YN+j8jBzPV5cEQR8m+6flSYF06gNDFyp2KN4Ntol0?=
 =?us-ascii?Q?IUrqQshmNC4G6ng=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:49:00.3969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df56d36-7978-4a2d-f6c6-08dd67c6bb8f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8475

On Thu, Mar 20, 2025 at 02:34:09PM +0000, James Clark wrote:
> I've gotten stuck a few times with unusable Coresight after a warm boot
> due to lingering claim tags, especially when testing the Coresight
> panic patchsets.
>
> This change does some tidy ups, adds some debug messages and clears the
> self hosted claim tag on probe. The last two commits are unrelated
> tidyups but they touch some of the same functions so to avoid extra
> conflicts I'm including them here.
>
> This gets as far as fixing the claim tag issue, but there is some other
> state not being cleared on probe that results in the following error.
> This can be fixed up as a later change:
>
>   coresight tmc_etf0: timeout while waiting for TMC to be Ready
>   coresight tmc_etf0: Failed to enable : TMC is not ready
>
> Changes in v3:
> - Collapse rename and locked/unlocked addition commits of
>   coresight_clear_self_claim_tag() so we don't change the name twice.
> - Make coresight_clear_self_claim_tag() a bit more generic by only
>   doing UNLOCK for MMIO devices (although there is no use of this right
>   now)
> - Link to v2: https://lore.kernel.org/r/20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org
>
> Changes in v2:
>  * Revert most of the interface changes, just call
>    coresight_clear_self_claim_tag() directly. This is possible because
>    we're not doing the read first, so it has fewer knock on effects.
>  * Split out the change to add struct cs_access to etm3x
>  * Add another warning for racing with external debugger
>
> --
> 2.34.1
>
> ---
> James Clark (7):
>       coresight: Convert tag clear function to take a struct cs_access
>       coresight: Only check bottom two claim bits
>       coresight: Add claim tag warnings and debug messages
>       coresight: etm3x: Convert raw base pointer to struct coresight access
>       coresight: Clear self hosted claim tag on probe
>       coresight: Remove inlines from static function definitions
>       coresight: Remove extern from function declarations
>
>  drivers/hwtracing/coresight/coresight-catu.c       | 12 +--
>  drivers/hwtracing/coresight/coresight-core.c       | 87 ++++++++++++++--------
>  drivers/hwtracing/coresight/coresight-cti-core.c   |  2 +
>  drivers/hwtracing/coresight/coresight-etb10.c      |  4 +-
>  drivers/hwtracing/coresight/coresight-etm.h        |  6 +-
>  drivers/hwtracing/coresight/coresight-etm3x-core.c | 28 +++----
>  .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  8 +-
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++-
>  .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  4 +-
>  drivers/hwtracing/coresight/coresight-funnel.c     |  1 +
>  drivers/hwtracing/coresight/coresight-platform.c   | 26 +++----
>  drivers/hwtracing/coresight/coresight-priv.h       | 20 ++---
>  drivers/hwtracing/coresight/coresight-replicator.c |  3 +-
>  drivers/hwtracing/coresight/coresight-stm.c        |  6 +-
>  .../coresight/coresight-syscfg-configfs.c          |  2 +-
>  drivers/hwtracing/coresight/coresight-tmc-core.c   |  9 ++-
>  drivers/hwtracing/coresight/coresight-tmc-etr.c    | 16 ++--
>  drivers/hwtracing/coresight/coresight-trbe.c       | 18 ++---
>  include/linux/coresight.h                          | 40 +++++-----
>  19 files changed, 168 insertions(+), 134 deletions(-)
> ---
> base-commit: 5442d22da7dbff3ba8c6720fc6f23ea4934d402d
> change-id: 20250317-james-coresight-claim-tags-ae1461f1f5e0
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>

Look good to me

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

