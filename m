Return-Path: <linux-kernel+bounces-432922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455E9E51C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160081676E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC849217642;
	Thu,  5 Dec 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d8CFCkJk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d8CFCkJk"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A51D5CC2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393464; cv=fail; b=P7z2NQmRAILkyKUAVPacXl6lJOrxl6Y2rVJs9BJIWsyoKIe2ekXKpl31kMBmd3PXA7kLrwH4Q/edfETajLNDSHxmKW7nJHZhe8P8203OuJvrW/Gu1K1wTGbOV9xRgQLZitUM+Yrht1qC6YM4jQXCw2iQqbJXzEopYu7ajRXdNPM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393464; c=relaxed/simple;
	bh=rh7LITKMj/m0UphF8VCmUQ/warK0rOSpY/zIKX/RyFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R1Td8A2i4QephsDEkORmO9hMaPW9Ju7N6+pjTxqmxe2U9uiOtTR4YuBu/70x523E71T3jfoHS9kiJ7x5oeZn9Zh+67vc5k+XVDidedJEbynu3rnvH15XgEDnN+RvQR+tQkUiBxow5QLH6jjkUeoKFkQTlhIYvwMWPIYZkWhdU34=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d8CFCkJk; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d8CFCkJk; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=T/FHNdinvicC0zn9jdmZE3cVSLL9+Vtbz6SDXheYqhSN2a7l/vpNd6C1LQnaAp6bCXu+N1CPAtiqfW0znfr0O6Ma5xvm2KY6+D6wBUSHuF1W4KaatHYXQ+l2I5mNFnRHMIR+KbW8fn221CLTxAst928rLLfeGCJAgNunhSQAY88kPKEeEoM+7NsaYAuJzJybVm417ufw+oMtS1utZoPbghThzJ8fy6/gell2MTMBAfoQ/SX51a8dFiQUHI/0sLu962GRrYhfphJdwhQTvkkoedvzP2C18mhhovtMA0LKzg4H6acvhJlye5EsVcRbV+kw6ixdOPYFLpES2dizbfLrnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fxgstqu4kL7XDKPdwY2DBEKhuTQcOAxcEXyrHulBmw=;
 b=kRY7wOrrKIacjgwDXlbXcG+my/l8kS0ymKiiQ+P0hBbLPGokaG1mpFtCHsyl7WojiwKRL+sti6olTT2H+L6bI5o5ghzoNJN45kGAqFWXhLw3SXVKNCQCqEciqj7M1pHl3dx/Sd6bApCuTsytgw96w40VyJpPbdziv1fBKi9Kcmiu3y+sgg+B0/jTYQaUsGcP8iIiwd8cSmlcrXEAmKKOaOhMe6kx/Vy5IZI9+7ndTXNkvbSfwB3MSFKPFpR49ikGHyadgmQaaOcjc0vxSwN/DhU338S3lzAj95TnqIa9AtT3yT4uQ+iRA6oa+XIQVu2ddzRbGR4rszhFOcajO5frKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fxgstqu4kL7XDKPdwY2DBEKhuTQcOAxcEXyrHulBmw=;
 b=d8CFCkJkQUvPC3rcG79ZmvQj6YiXBYamvvubi40dhiarFOg8GeHaGChMDHWKH5k9sB6fK2jB4VDRpud4uYc4v0RexJ/9iT+dVmwvvT9h07Up6ZcGXnRLhOGwv/2Qm/ZZLy2yX30hFUbDAXxJCxguSslhxGU7Gm1uEqwtei8rx/I=
Received: from DUZPR01CA0180.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::14) by AS8PR08MB8971.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Thu, 5 Dec
 2024 10:10:52 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::be) by DUZPR01CA0180.outlook.office365.com
 (2603:10a6:10:4b3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 10:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Thu, 5 Dec 2024 10:10:52 +0000
Received: ("Tessian outbound b3b8c95264f7:v522"); Thu, 05 Dec 2024 10:10:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4dd44acc2c537840
X-TessianGatewayMetadata: sWUYHkyNzow/HT5o+LNEkdX7TODUeOZHtIkoAFm3PCXgqacDoCEOmTitvGdYEFS+w6UdY0oYd6jGCL83bXBporOv9osDhnjWhGszL0YP43kCfO2gy5vlVFI43TMnKR/wfV8ns1dYmeUy1bpGNH0MAg==
X-CR-MTA-TID: 64aa7808
Received: from L10d7b83da4aa.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id DAB7DC0E-8FFD-4FE5-BEFB-3C96F78776CA.1;
	Thu, 05 Dec 2024 10:10:44 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L10d7b83da4aa.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 05 Dec 2024 10:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKjnTIfO1JPsY4mG4AIRjYPEnAKUnJn2hOadjjMUsUv5/yM4QbAsGAUey5+UD/eAoz9gtp6XXKgoqbv/+yu03G6bOIzDCsaH0ngou+1XBNxCMbDfk9H+HhiFm2TIteUbBdY4iSxRMDi+QPle5VO8JgK+SgUipzi7TXHWYgNkYxGBnq7/JNQfXDnJKQs3zwAvdLgF/3jP+odmRpEcsBLIZlRmiwFYN+3xtQ3sL3kjgRgq5h9Y6/M1l8L2Egl6yEvwlIl0JarepW8iJw+5ZL3oTT4B1zm8Bwe/ZYYP323kbdXPFCSra2aPpoAxlZK9FcP69nZ1m6mvmxzAb/qWqjgvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fxgstqu4kL7XDKPdwY2DBEKhuTQcOAxcEXyrHulBmw=;
 b=xEHI9oZjHVI5jifGiMhxHzQnC8HK14DW7Ja7LIOD/8oqOUGnSMjSuI32pqjCBde6X0mhvtilkUPzx6hl8p6foHRIbMk0h+tBBX5rZLZIcfStGf7MrlUsiiJwFjLc7lhZx2mtHgVaatPYY3Pdi9KJP0w+mtWIornJXP8Y928u1Gj7OxCds1qSCR6oB6SohgPRjZGTN6Zn0bfWFQUnEkh76fAwhfZQ2UME7WNcL2yHBg6SuMl2Opn7ohTlT3A8ROpwGQHppluGEQUODaFxIbc2I52FfxUPm71rvSxpkCrVtz0aescsgIsXiN9u7dejtDLEXkXyseilhLwdOeXdOn4slA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fxgstqu4kL7XDKPdwY2DBEKhuTQcOAxcEXyrHulBmw=;
 b=d8CFCkJkQUvPC3rcG79ZmvQj6YiXBYamvvubi40dhiarFOg8GeHaGChMDHWKH5k9sB6fK2jB4VDRpud4uYc4v0RexJ/9iT+dVmwvvT9h07Up6ZcGXnRLhOGwv/2Qm/ZZLy2yX30hFUbDAXxJCxguSslhxGU7Gm1uEqwtei8rx/I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB6326.eurprd08.prod.outlook.com
 (2603:10a6:20b:335::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 10:10:42 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 10:10:40 +0000
Date: Thu, 5 Dec 2024 10:10:38 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: suzuki.poulose@arm.com, coresight@lists.linaro.org,
	mike.leach@linaro.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: Drop atomics in connection refcounts
Message-ID: <Z1F8HvLY/04jukUH@e129823.arm.com>
References: <20241128121414.2425119-1-james.clark@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128121414.2425119-1-james.clark@linaro.org>
X-ClientProxiedBy: LO4P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB6326:EE_|DB1PEPF000509F2:EE_|AS8PR08MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fd8dd6-8f5d-4435-d7d0-08dd15151998
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?OQIVLrw6u8Vs3eMM+1wUvUBmD4GMBjD69bXM6rgv5vbMgZycjH2LqFo+yIrq?=
 =?us-ascii?Q?bXsCS5+x3oLppj8m7o7eKcRzoJy63KwlMdoTQwodb9hHzBkU81irle3qWD1C?=
 =?us-ascii?Q?lXYillkFv1ps08THa9AAYIrt6FvFGp2IhU4Pu4D5720thp1sd16zNuZq2Pq1?=
 =?us-ascii?Q?xgbI2LZo42KTWT62vzC0OuaqWUrWWg6cRyobdv5T5cMvj6epb3PZcu1wD/Md?=
 =?us-ascii?Q?gWRrYTa20xgGEMASxeg81+oryfbbSwQMQUBXmWFFPrnvolu3bP+mOn4DgQ4a?=
 =?us-ascii?Q?tR33syN/MBDSPzWzmDv81YKH1SXHXPv2OaBU+Ssk4cXA5UK7lZ9qgXAkA/l1?=
 =?us-ascii?Q?CkhVnzBfS+WKGXC6jKLPg96tZ7AYFse4bU++8ag0jKhCatRFogGlJJc9TobK?=
 =?us-ascii?Q?/8zb5rCTsnwZ7fIXahwWv/duxkB7MjGqzRmhkcgvriLxfXa/QvmRvdNifY9J?=
 =?us-ascii?Q?mqI4VNpgju1bnJ0Udauhm1CCxYSuH7QjH6yhRDOg58CbWjxUs2Oo43MVntPH?=
 =?us-ascii?Q?aMb0xeyuW/bEj2PUduQPJ736iqcef5a5Y6t6lY0DI8Z1yQwQbvKiOic8PJHf?=
 =?us-ascii?Q?AWSAJl+8t+l1pEAfkt7SecPvsyVt5PCHYq0xR1CPbBIbMWW9Ef2Nk6DnyNjO?=
 =?us-ascii?Q?ZFhOAo87UrkMTtON2mjk/+l5nxzdDihtCTR9D6NzPlrvUcqiWogF5bkysdhd?=
 =?us-ascii?Q?gc2chMZHMAu8O0h5YtAOd9OkXuzVQ9xuYiSIgF+cZqy5B/8J+fB+/BNpuedz?=
 =?us-ascii?Q?luoHmBB3haeRv+B+pHU+GU8ZtQrgQxeHCqFJM2bUzEYwo45H8cQMJiPNMd9N?=
 =?us-ascii?Q?tpaD/wiIfhVaAM4CZs1q8qyKWGKjyYnyTpCqIXLAG96nTbW73feTyx1t/38L?=
 =?us-ascii?Q?iVdXPJlLIXZuqw84eHvQxHrR0ehuiOI2PKT+AFLxcnSJGXfk8FRk2K7h30ru?=
 =?us-ascii?Q?h99R3mu5uCWf5/DrJ6+lI8Rs+rdU0OuY5S1Q7s+rY0HBI6F0b3QyOONQqtih?=
 =?us-ascii?Q?WSQhbwIraqo7hdozww+DhJzHzIrZPiZMlidqVqBKwRN9DXQ6ebXv2b5L1kf+?=
 =?us-ascii?Q?FAjuVUaMbftYSoj7ZeoVdCnwIzMkplMIZ/8PdfpJuhkauyYKKmc5ukrVqQ0Y?=
 =?us-ascii?Q?LKLKQ8zIisYiikZHZ0tTIe2QrRkx4JCNpaeDry9BZAOg8Y6FbkAafAzuU4c3?=
 =?us-ascii?Q?drnvlFF0HBRmTT1IUIpGPCvixw7wW7y9gUOvBlZxtCjajhDZkoPS91qgYOi6?=
 =?us-ascii?Q?a75XZIFsfQL25oUB5yKDUva1/2WBzeik8VxwQGTfkBeC5qcob5YQd9VcutQb?=
 =?us-ascii?Q?QpGvwPo8zDEnZwyNG1DwTgoa9jdCGdDTLYiAXqLGqiPwpg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6326
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	09fe9639-97c6-466c-a8a6-08dd1515126c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700013|14060799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hCJSAtP55yIj14NIt7sAfsqr6CyDMPwH3ZMq3sfw9DXSWxIzWY1xWWedxJRl?=
 =?us-ascii?Q?ZiVz8/ySoBQhdiiC4ppV2P/o4AesVCN2En73U1LhaG1PG2SofGvcZzEI/Zj/?=
 =?us-ascii?Q?7wxpDFSRDEvHWQNvSmaNkkF6QmIZnyiJGV2JLKePgDaiLOTJIGcp0/KwN5ve?=
 =?us-ascii?Q?WWCIFKRdTkGMnq0OVrvJwl3NVmeZdOTW6T7o7j1PuGofsBIZwWOKhzkeZNh0?=
 =?us-ascii?Q?eirzfxUErxCiqM66qiFCinTtEoRsQ5AJR+7vLcihRhkdH4Hw3nm4h1RAQSYp?=
 =?us-ascii?Q?eH3xvC32T5z7WG5ucD8w5JrQlsZtmvMooI3DU8XY41StCrBk3DPiJSjGgaYx?=
 =?us-ascii?Q?xyQF349o1vxSiu1IbKK0/x+Z9ybtifQ7KNrnrq8CmJMfRkbwcjyT/pU1ffzq?=
 =?us-ascii?Q?tSZ1LZbNCVE1oItD/eONHR/nQ1uwh6L3/IoQTUdgbec2Mfn5XDeQbUR6A8JV?=
 =?us-ascii?Q?bukQU40cXvyH7S6jW+ihRPkVWXViczfLOBz7X3pfK/5HzKtEgBkSQiCkBxxa?=
 =?us-ascii?Q?NuxZLCfZ9OFo2KV/ixExDTD7rYhKLHIHc70nVb7y9ps4ujapjTQ64jWdLX5p?=
 =?us-ascii?Q?YMfgAM0G2iDS7DfolcugaQexjTjoKx1h73hkuLUOZcZubG9DysyllybFoYrK?=
 =?us-ascii?Q?4mZ9/uFNRo+K79tE5M2RXGJnwtS/RbiCqVu3o4fMh0yPtjjVhcgwYzUzSzkm?=
 =?us-ascii?Q?4tI3T0EJ36Difnsv6ePAJuKLmV1dNvtQYwX7vfjohy+u6a8w8fEwAfW2PleD?=
 =?us-ascii?Q?DOjZIu28DPiDcHRVflLT4b6zqzr2uYlWx9lDtciolhZ6+EY1jCtcvmBFpjmF?=
 =?us-ascii?Q?HZGydo6k99FHwu8a/SnEy6yZbeQLl0zpeiLZWyx/J+0mvqjr73lFPh+kpmlR?=
 =?us-ascii?Q?MBYB9Qz8VfNyRPTYAyfewO4dzz3vBeLN2qSmEGrZQeWBRUAv7iTKg6vx7RsI?=
 =?us-ascii?Q?tldAQy1vJJpOdlUUXaJpOR6+OeI0fwfQXKm00rDR+eJzJBuubvR0tpqavoOG?=
 =?us-ascii?Q?vuZ3i73bFPqrgSU0sERln1rMiYdDU6aXAYxTpWcOaXi/35FVWqbLh8HMLIy/?=
 =?us-ascii?Q?55vDwK1BuLhGpZU7WKZp48TxoUy3vRJMtCtNUDaJjLTO2H3AvFkNiCUO1a3/?=
 =?us-ascii?Q?zYJJ1aoJDY04l/j5MJT4N7pA4pQYL3P4BLLruhuYKrV1s1BaDVd+cZ1Zpgsi?=
 =?us-ascii?Q?RJf8bQJ2Z5tW1qwJhKn9n0yaa/Qbrl+1u/KmOidQXTGvMCBpaHCL5azDuOZM?=
 =?us-ascii?Q?8AbEL23ZdyCQ1uwcAEKF1PcEFGgOtJqg4bXyjLOsjkU9o8b37quinDC4LFzG?=
 =?us-ascii?Q?BGsyOPeDM1lCGla0itk2HGkK/io7AWwR9oBZH6BsHkuKMfjuYrlqchbXRJxX?=
 =?us-ascii?Q?f+HetZhrezOuS/jDOyq6P6qceKdMWjCLQ9Pphxh9cK9UfUfriYox/nT02d3q?=
 =?us-ascii?Q?6t8FsccjDDmtYstjzzHXuDjjLQuqhHGrU5kz7Yn+d3NB3wCBCkznZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700013)(14060799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:10:52.2547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fd8dd6-8f5d-4435-d7d0-08dd15151998
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8971

This patch looks good to me.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

On Thu, Nov 28, 2024 at 12:14:14PM +0000, James Clark wrote:
> These belong to the device being enabled or disabled and are only ever
> used inside the device's spinlock. Remove the atomics to not imply that
> there are any other concurrent accesses.
>
> If atomics were necessary I don't think they would have been enough
> anyway. There would be nothing to prevent an enable or disable running
> concurrently if not for the spinlock.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c     | 6 +++---
>  drivers/hwtracing/coresight/coresight-replicator.c | 6 +++---
>  drivers/hwtracing/coresight/coresight-tpda.c       | 6 +++---
>  include/linux/coresight.h                          | 4 ++--
>  4 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 5a819c8970fb..bd32f74cbdae 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -86,14 +86,14 @@ static int funnel_enable(struct coresight_device *csdev,
>  	bool first_enable = false;
>
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (atomic_read(&in->dest_refcnt) == 0) {
> +	if (in->dest_refcnt == 0) {
>  		if (drvdata->base)
>  			rc = dynamic_funnel_enable_hw(drvdata, in->dest_port);
>  		if (!rc)
>  			first_enable = true;
>  	}
>  	if (!rc)
> -		atomic_inc(&in->dest_refcnt);
> +		in->dest_refcnt++;
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>  	if (first_enable)
> @@ -130,7 +130,7 @@ static void funnel_disable(struct coresight_device *csdev,
>  	bool last_disable = false;
>
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (atomic_dec_return(&in->dest_refcnt) == 0) {
> +	if (--in->dest_refcnt == 0) {
>  		if (drvdata->base)
>  			dynamic_funnel_disable_hw(drvdata, in->dest_port);
>  		last_disable = true;
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 3e55be9c8418..31322aea19f2 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -126,7 +126,7 @@ static int replicator_enable(struct coresight_device *csdev,
>  	bool first_enable = false;
>
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (atomic_read(&out->src_refcnt) == 0) {
> +	if (out->src_refcnt == 0) {
>  		if (drvdata->base)
>  			rc = dynamic_replicator_enable(drvdata, in->dest_port,
>  						       out->src_port);
> @@ -134,7 +134,7 @@ static int replicator_enable(struct coresight_device *csdev,
>  			first_enable = true;
>  	}
>  	if (!rc)
> -		atomic_inc(&out->src_refcnt);
> +		out->src_refcnt++;
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>  	if (first_enable)
> @@ -180,7 +180,7 @@ static void replicator_disable(struct coresight_device *csdev,
>  	bool last_disable = false;
>
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (atomic_dec_return(&out->src_refcnt) == 0) {
> +	if (--out->src_refcnt == 0) {
>  		if (drvdata->base)
>  			dynamic_replicator_disable(drvdata, in->dest_port,
>  						   out->src_port);
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index bfca103f9f84..4ec676bea1ce 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -190,10 +190,10 @@ static int tpda_enable(struct coresight_device *csdev,
>  	int ret = 0;
>
>  	spin_lock(&drvdata->spinlock);
> -	if (atomic_read(&in->dest_refcnt) == 0) {
> +	if (in->dest_refcnt == 0) {
>  		ret = __tpda_enable(drvdata, in->dest_port);
>  		if (!ret) {
> -			atomic_inc(&in->dest_refcnt);
> +			in->dest_refcnt++;
>  			csdev->refcnt++;
>  			dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
>  		}
> @@ -223,7 +223,7 @@ static void tpda_disable(struct coresight_device *csdev,
>  	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
>  	spin_lock(&drvdata->spinlock);
> -	if (atomic_dec_return(&in->dest_refcnt) == 0) {
> +	if (--in->dest_refcnt == 0) {
>  		__tpda_disable(drvdata, in->dest_port);
>  		csdev->refcnt--;
>  	}
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index c13342594278..834029cb9ba2 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -200,8 +200,8 @@ struct coresight_connection {
>  	struct coresight_device *dest_dev;
>  	struct coresight_sysfs_link *link;
>  	struct coresight_device *src_dev;
> -	atomic_t src_refcnt;
> -	atomic_t dest_refcnt;
> +	int src_refcnt;
> +	int dest_refcnt;
>  };
>
>  /**
> --
> 2.34.1
>

