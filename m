Return-Path: <linux-kernel+bounces-573786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F095BA6DC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A05D18898A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E125F79B;
	Mon, 24 Mar 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PMXDsM4U";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PMXDsM4U"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012044.outbound.protection.outlook.com [52.101.71.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622002AD14
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824771; cv=fail; b=QE/DrDqC7vn/oaha9pIVBStRN4L00R//KGvWrTbal7AKCq2jCarzv4eerM1m4T+IOql7zoTzYSOkqI7YBIpSuGBrK7iZEDOHywN4cMnbHh2jw7ND/X9jKPy8gepWq8d9Zw1/2a5CaC6RrlT/EXSybul8R95RPeFYGZ7v1EHVmrs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824771; c=relaxed/simple;
	bh=aAl9sJ9ak3VspW11GqjhfjZrPv4qh1uZwPszm2s/QQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FKK/4+9yNeiocZvJCehs9It+u1Gmw+vs4t4DHFwaIaGfIxwIWMei7/GJ++wSpctEbpoDE0Vyk3Nhi6+2uiFKpzK2UqOFudM22wK6OROmB3AVUGtIwvnb2Qyo5+VRtgnp7f1tJMliR07lzeyDnMj4L/A0cwgEkyEEcSkDzZ0lbEU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PMXDsM4U; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PMXDsM4U; arc=fail smtp.client-ip=52.101.71.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QUgKRTw4ARj1859J8jOaj9bPo2nMqoboiwmQ57uHmgPjp7GiLE7FJY4jOn3VO5zvRFUejW2syWi+tAzZGIqAwDaQokDSYwyTLh6JUUYdleCKThw7Ann+xAn53Rqd/d6UNQQOxNGKIVty9YSBtN155Cx4sgIh92f0ZMMxEfz1o0pfzlw/ScAgzkNAcJAlTkVKviQRm2yuYQ1o1eHHb2uhkSJlAQO0IgJfWpZv8zh+/gXZ8XW2HtUqDJFtlOF0OR5NkAMmoXfJeKDJv7FQomKMR+I7bmgmf2EvMT1Gu46EvIy1/D8/wfI+Gar/neEBC6PSBOWaTldqMIWPhomdzEakUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6yq5CGgPlBmoLZ2Mtu9rlk0QM9i1DCmla59TD5sdNA=;
 b=qXUlC2mR9MsNCZPSzGmHLD8dt9qP8TtQHX24JWVPNDz1l+fe+FDwUoz1x26StI8h6gB+Inc6ehCALpDkTVvTx5kl6OgFfeg0nw954zJgROA/rFDy92XrsGn2Uvn/gMHrM4680SEFmb6sOzYcwoVDN0Jjj7EreKzgRjNdf/EfkvgIQ/m6zWGueGcyGPS0zrG8h/hR0+jBbNLVjZv0MVPLmDnitiqJvxndyACxAsk1MZc6ZlzvplwgO0l+BWU1S/k4DGSlyncZK3+vB1foXByKAXoa33I/TUiDHM86jyBO1VRma33BsyAQj7wYqqBSnjtzo/Je3BoIe2pK+srE6ui5eg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6yq5CGgPlBmoLZ2Mtu9rlk0QM9i1DCmla59TD5sdNA=;
 b=PMXDsM4U5mVSfS6JtlDrwxX++wKAylmSHZTl8dgbZIyLVYkd8mW962TpGEOciZj5pyHOfj+mfQ87n+CCukimDsV4RAUVRmAO4PfmkNSwGWM0tuyM4dDYo3L57nmJSK7UG2aODprWLhSZnKNSIpdwAU0XYL6qjHBo+mbFflIFJMA=
Received: from AS4PR10CA0028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::13)
 by VI1PR08MB5392.eurprd08.prod.outlook.com (2603:10a6:803:131::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:59:25 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::d7) by AS4PR10CA0028.outlook.office365.com
 (2603:10a6:20b:5d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 13:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Mon, 24 Mar 2025 13:59:25 +0000
Received: ("Tessian outbound 9d54e9aaa332:v601"); Mon, 24 Mar 2025 13:59:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0e806b41dd95f978
X-TessianGatewayMetadata: azwWZN2mEcJEweTDDYFYAsJDCShVnB1ZeGkgMwDg3yVLoGHiCEYYilyhrQuo2iBnvQTY50dycCelN8V68HMoHBEfdFICphs4t0FQSvQZn/9qbNmEZ/hNdfCKtqPMGW6ONpgWCLJPAFjHlWoqL7Ww3A==
X-CR-MTA-TID: 64aa7808
Received: from Le080dd499df7.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C5390B29-8CC5-42BB-84F6-22C8E53E8CE5.1;
	Mon, 24 Mar 2025 13:59:14 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le080dd499df7.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 24 Mar 2025 13:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+okwCyasF3ZEdvzrAbPz/RsiggT+RGqEHviapWWGxzt8l3/n5cSXdXC2PxDQYo7WZ7ULHFMyoiNKP/YeOX7Eb9ewDL7P5+UdXiOJN1e720qdmlnEL1Bo1JNEZxWEskG2y0fNy/ofbWjcBVQoU8MriIWRykAePBD25VQ89tEC3/oahohOwOzG1tN0/W+Bh6I50Llo2G9Z5ZG9y6Gj3Z7JMkVaN707zgG7lFmYl1GQe8Lcd+W/ScgB9AXRyqXS/wcBQ/l+J17TkaVmEBisgujCdFdVTOPPgr7v854M46fxY+lE7YqaViHogrcw3EvBp99gb44Pq0z/4calxzAvWGb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6yq5CGgPlBmoLZ2Mtu9rlk0QM9i1DCmla59TD5sdNA=;
 b=BD0gQv5OSPoxWMove+lxTnfmHT7BRP5mQom3F+0L5/ANvLvix08vn6d5yMIsNU3SnRnozmmPo4MEvMrCOWuWabty8+4t7aS9Oc/oPBmzntbJK0W6qvvh+ithR/Yk5hnjXt6MC9Y8XlfhbtLxx1RGZbdavs+gg8+ltyl0vg4+g/NIWtAU1pX0flrtjPXQUgtkFZlh3vEBnZ0pKoeOk2K5j+MdrJudWydhP0iApu2p62jk+LCBkof4LSCOvCzhdg/XiwTpg3EBSW5nQvc0VI4KIPT8eFagnACYqWR+KijTST9VveVVfu/76QDhnKXbhiSArhcanXWFX5RIRhDbRDbTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6yq5CGgPlBmoLZ2Mtu9rlk0QM9i1DCmla59TD5sdNA=;
 b=PMXDsM4U5mVSfS6JtlDrwxX++wKAylmSHZTl8dgbZIyLVYkd8mW962TpGEOciZj5pyHOfj+mfQ87n+CCukimDsV4RAUVRmAO4PfmkNSwGWM0tuyM4dDYo3L57nmJSK7UG2aODprWLhSZnKNSIpdwAU0XYL6qjHBo+mbFflIFJMA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU2PR08MB7376.eurprd08.prod.outlook.com
 (2603:10a6:10:2f4::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:59:10 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 13:59:10 +0000
Date: Mon, 24 Mar 2025 13:59:08 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki Poulose <Suzuki.Poulose@arm.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] coresight: prevent deactivate active config while
 enabling the config
Message-ID: <Z+FlLDLV9WkGNbj+@e129823.arm.com>
References: <20250109171956.3535294-1-yeoreum.yun@arm.com>
 <CAJ9a7ViuVntYL62q=WYPkFR3++cyufPdKUHm0FUAPyGy76pB_A@mail.gmail.com>
 <GV1PR08MB10521BB7C93822F5124F2D66EFBD22@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <CAJ9a7Vgz+L+UYf8Yqyu9J5hp3AB3WPSKutA4AvR-OFdu8b-dPA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vgz+L+UYf8Yqyu9J5hp3AB3WPSKutA4AvR-OFdu8b-dPA@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0240.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU2PR08MB7376:EE_|AM4PEPF00027A6C:EE_|VI1PR08MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: 97583ed9-9011-42da-9dd8-08dd6adc1612
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?r4sV95qHglwWag+fMTTX/oNlMoA1CoRrPeHBN1g4/CgZNBTt0lE4a/SeBrGe?=
 =?us-ascii?Q?6gKLGC6W4q2eyXnZIlWuQipTr6OQUZpSMi+xWiJu93c0+O1vcSreymHcK8us?=
 =?us-ascii?Q?kQ65YnDVydrMcN7168hL8VS30IRjSMxnYzDATisRqf3kU+wRTcRbrpXloXwV?=
 =?us-ascii?Q?wGWJVclhkLw3fy71OODvOtnIc7whuYrQv5IiGfvOdJS9qUf1xH6/2VmgftJ9?=
 =?us-ascii?Q?fD5ggi2nd9YSHJ9CHXkVGaid8O333+nuJ/tTe6zU6ttje0Ier5tBSxgZSS9l?=
 =?us-ascii?Q?rSmsc0AsHo0gJVR8p+TLtjV8LXlHa53tN+MLr7CzS+vJpkTQUJ3p1Wolawyc?=
 =?us-ascii?Q?0fvbwVHipRVhDjsOocp73yTJlwFxGrsB58UejilMnwGkW48SvPQ74vPKjD7+?=
 =?us-ascii?Q?9Zh7kn3QxhfNazNhEIJ9ZlvSzeBWrlDlYzh6Bx/Kklw1QDC5ZdzWx79EJzOH?=
 =?us-ascii?Q?7bpGxMTM8UJlGyFAr/A6S42DHogs/f+ui76poVAJ42I5qckQsiJgXKEZbngU?=
 =?us-ascii?Q?yIz1TVGyLewtc78yIiWwS/iIYRBWphwe+RtjNrpzHQUCifcKa/gyFbw3K5ji?=
 =?us-ascii?Q?LL4Icww1QiebCT5qMUej8o2to04XtvKy64BEzXz4qS35vBw2f0wYEwthavxv?=
 =?us-ascii?Q?T09NAfi8WEJwUHz3t45Hk82T2slegoxtooyJtg9nVDdMB5njcjl24rGuCK0u?=
 =?us-ascii?Q?LoJQxVTpq8065fIoYDxmeFMLeAVy0hfyL6eO7zkNrzjftrsewS17HVGdzSjB?=
 =?us-ascii?Q?dLSoAbz5nPCGFckOn6c9QGg3jm4NAD47iaNJP8Y9a3ETB8qSZBmwNuXKiwr2?=
 =?us-ascii?Q?DKlMbc1BSa2OdwI0kWvICpWHawtX3jTeeRFpFIHb76LZa4aKHgk8Q2+0udWf?=
 =?us-ascii?Q?SlNzRYI7M6C8AeZanMJ1ILhzrTSZVj8UFKOWQmXn7/WzX/Uij2gOdxQ4YWsW?=
 =?us-ascii?Q?K8wIoXUtFI1PjyQT+fWdCTiVbYKH0l0IpVub56rRzkmSyxTneRkvgvbD5STs?=
 =?us-ascii?Q?nxLsXUNXVokHE5bphup82vLfJCiwQO73NRNmcUNaaFjakMRuCrTEr2KHzfBQ?=
 =?us-ascii?Q?7C9txaOSQCBPCVFgRhsRzgFvQFkbMPI1LN+1hfvtxZLG9WorZ5cRdNJSSBhX?=
 =?us-ascii?Q?/s/4IWNMUQbl45aMQlCqZ/gdk4YtWFxQ+QmCakK1ukxDUVvfGEIvQWO5FpfV?=
 =?us-ascii?Q?M802NdlnMwc/PjBBSfAB8lKKWxsRKrRFCJP68WYlBqBS0LUkByZ8juIKc6p8?=
 =?us-ascii?Q?XZWaN4b2dsc5qwwDZs/yGFiR+wSf90TdaqlBCpgrzsKmQR3ZjSZVbtACwTpG?=
 =?us-ascii?Q?nzlQzvxaGCIsS6ZZo9wxBmhm1C6S7v4+atXicND71nXZGmv/ghRc8jJ7Akfy?=
 =?us-ascii?Q?WSFv8aptj//rtoL1adsuGXcTcPBg?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7376
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a982d4dc-09b9-4b2b-0f8e-08dd6adc0d3a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oHYea3Z7gilXkTUFFdN0KrqlfqhfHGg6ZZC1uj08A6csi0d9u5jJRpyFAtDv?=
 =?us-ascii?Q?9dFoMexIatlZ8lw3zTmeZvR+sb942t5LGhVCkuWEvCeYUnABcZTMncRvf0zm?=
 =?us-ascii?Q?l4CNv3BLJDTQqlr5+rrVlBwSdib3rWEYLj3NdACj99qE++oKNDE2W629nS+A?=
 =?us-ascii?Q?25C7j1nkztM4tV/N4RhNpfqJJN2fqSb29oxip6XR1cf1tB9+aScEAGfs+FKI?=
 =?us-ascii?Q?s4NvhpQrmFeagSSxevwROE4r9ZYUNhECFBEHeKcwQTug8ZUoHYznkiSPR88E?=
 =?us-ascii?Q?dfN+ImN0y8kYxxCPSUrMVRHhoST5S4bRaQ97zwmqihgifE5FZ4GpsytfRlHr?=
 =?us-ascii?Q?TupLBLGBv5Tpse2NFyrgWLmoN49Cy/EiNUug3TNYIdTLnCDvnHVRKvLZoJ/+?=
 =?us-ascii?Q?6QOf36ZTgAFEiEXlxeispRcshpIbQ/yXH7c2Eh8FAV7FDYhg+sRhECY+Qgz0?=
 =?us-ascii?Q?JhQp4my6DlfQ+BQQsM1ji1BD6Nquc4/RkeD12VB2A+BWjHN9LdtPolXJseE1?=
 =?us-ascii?Q?BaKO7ejnB1uxOc33LueK6Tnvwr1A1ibl7cGZglhfBeCAldLC4flGv6C//ApI?=
 =?us-ascii?Q?cNUMSSJkve1SXEbkiBhWXSZmv38I2LqH+cyoez1iYFTwfj13Q2FGhOvogbPS?=
 =?us-ascii?Q?yuSHeV2uPMWMhUf7HbYEuASsVTqLV7Db5aAZk/liDOXyp+5xBtJt11KmUEFj?=
 =?us-ascii?Q?IHp8QrayM5lm5kurGUOlAAgd0uSyTdds9+gHY8VLmLYbvZUj7zEuHtpjGvb6?=
 =?us-ascii?Q?7IiZn+VWIT6oiFOonImldhJ1i+qi6yVR7ItltUv+zibsEOg5fTZWoYFyzQYM?=
 =?us-ascii?Q?Oep78B8oTCRdeY6NhhrIon4teog0r+aY4fwe8LSSH4wmy523OTdBu3ViOEjV?=
 =?us-ascii?Q?4UcGyPZOu5DYTeG9M9PNYBp0x/f++kLP4bY5kN0ZoW8V4y/gbiOrMNrdpura?=
 =?us-ascii?Q?NI7gchKgfh/aqbG7Cv1+Q+/pwUKes83HCoxjI8z2V03V/87yOFpB5aMRIdEh?=
 =?us-ascii?Q?tbTGxoUpUY5WzAWDOJeqLJWNfNEh+3g99z39nXsJK6eSIBDXDFJikXSWxTBB?=
 =?us-ascii?Q?WsysPREOkpJCPN8UB4SYCIvpuIVnKlpr1bft1O+9VQHNoBI0M1aSSdVMPszx?=
 =?us-ascii?Q?zCWwOY1/JyHYITdK625GqHcTVvVCTmtlRadBY/hXPo5Z/07lnA+7PaCfHP4c?=
 =?us-ascii?Q?B50sbUhqrNDZOBehjC6PG9dsNcJQ4CwDKj73TFpz4w6iy2xio3Z2J7El4/2s?=
 =?us-ascii?Q?Uuybcgkb/kj5fzGEwA/p27C/3yh6l0xexzKDnEnAkPsTJ6UX5hxJyLG9VX46?=
 =?us-ascii?Q?2kWPRd+jROHUFT09jn3I6NoEzpdRAMF2j5T+SYy6EZYNwN+Z+7zvJ4fw1hYU?=
 =?us-ascii?Q?+gTWgdrbhDfH37kSQMzAnrnitHPLmvd9Cnz7G408YaLgw1DL6hl2x26eIC4V?=
 =?us-ascii?Q?r6xo+Mwx7py5VcJhzvblxbdyiHM58oImaLVyzfHXPRGmm1UR+eKCm2tK+K3a?=
 =?us-ascii?Q?20Ip9Kzba/xzWF4=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:59:25.1521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97583ed9-9011-42da-9dd8-08dd6adc1612
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5392

Hi Mike,

Please ignore my foremer mail.. and please see my comments for your
suggestion.

> Hi
>
> On Fri, 14 Mar 2025 at 15:25, Yeo Reum Yun <YeoReum.Yun@arm.com> wrote:
> >
> > Hi, Mike.
> >
> > > >  static void cscfg_remove_owned_csdev_features(struct coresight_device *csdev, void *load_owner)
> > > > @@ -867,6 +870,28 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> > > >
> > > > +static bool cscfg_config_desc_get(struct cscfg_config_desc *config_desc, bool enable)
> > > > +{
> > > > +       if (enable)
> > > > +               return atomic_inc_not_zero(&config_desc->active_cnt);
> > > > +
> > >
> > > Not sure why we have an "enable" parameter here - it completely
> > > changes the meaning of the function - with no comment at the start.
> >
> > Sorry. But what I intended is to distinguish
> >     - activation of config
> >     - enable of activated config.
> > Because, current coresight doesn't grab the module reference on enable of activate config,
> > But It grabs that reference only in activation.
> > That's why I used to "enable" parameter to distinguish this
> > while I integrate with module_owner count.
> >
> > > >         list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> > > >                 if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> > > > -                       atomic_dec(&config_desc->active_cnt);
> > > >                         atomic_dec(&cscfg_mgr->sys_active_cnt);
> > > > -                       cscfg_owner_put(config_desc->load_owner);
> > > > +                       cscfg_config_desc_put(config_desc);
> > > >                         dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
> > > >                         break;
> > > >                 }
> > > > @@ -1047,7 +1066,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > >                                      unsigned long cfg_hash, int preset)
> > > >  {
> > > >         struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> > > > -       const struct cscfg_config_desc *config_desc;
> > > > +       struct cscfg_config_desc *config_desc;
> > > >         unsigned long flags;
> > > >         int err = 0;
> > > >
> > > > @@ -1062,8 +1081,8 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > >         raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> > > >         list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> > > >                 config_desc = config_csdev_item->config_desc;
> > > > -               if ((atomic_read(&config_desc->active_cnt)) &&
> > > > -                   ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> > > > +               if (((unsigned long)config_desc->event_ea->var == cfg_hash) &&
> > > > +                               cscfg_config_desc_get(config_desc, true)) {
> > > >
> > > This obfuscates the logic of the comparisons without good reason. With
> > > the true parameter, the function does no "get" operation but just
> > > replicates the logic being replaced - checking the active_cnt is
> > > non-zero.
> > >
> > > Restore this to the original logic to make it readable again
> >
> > It's not a replicates of comparsion logic, but if true,
>
> sorry - missed that point .
>
> > It get the reference of active_cnt but not get module reference.
> > The fundemental fault in the UAF becase of just "atomic_read()"
> > so, it should hold reference in here.
> >
> > So, If you think the cscfg_config_desc_get()'s parameter makes obfuscation,
> > I think there're two way to modfiy.
> >
> >     1. cscfg_config_desc_get()/put() always grab/drop the module count.
> >     2. remove cscfg_config_desc_get()/put() but just use atomic_XXX(&active_cnt) only
> >         with cscfg_owner_get()/put()
> >
> > Any thougt?
> >
> > Thanks!
> >
> >
>
> The get and put functions are asymmetrical w.r.t. owner.
>
> The put will put owner if active count decrements to 0,
> The get if not on enable path will put owner unconditionally.
>
> This means that the caller has to work out the correct input conditions.
>
> Might be better if:-
>
> get_desc()
> {
>     if (! desc->refcnt) {
>        if (!get_owner())
>            return false;
>    }
>    desc->refcnt++;
>     return true;
> }

I think This makes another problem when
it races with _cscfg_deactivate_config().

CPU0                                          CPU1
(sysfs enable)                                load module
                                              cscfg_load_config_sets()
                                              activate config. // sysfs
                                              (sys_active_cnt == 1)

                                              // sysfs
                                              _cscfg_deactivate_config()
                                              (sys_active_cnt == 0)
                                              (config->active_cnt = 0)
...
cscfg_csdev_enable_active_config()
  lock(csdev->cscfg_csdev_lock)
  // here get module reference??
  // even sys_active_cnt == 0 and
  // config->active_cnt == 1.
  get_desc()
  unlock(csdev->cscfg_csdev_lock)


  // access to config_desc which freed
  // while unloading module.
  cfs_csdev_enable_config


Because, the desc->refcnt meaning of zero is different from the context.
   - while activate . it should get module reference if zero.
   - while enable active configuration, if zero, it should be failed.

that means to prevent this race, the core key point is:
   when config->active_cnt == 0, it should be failed in cscfg_csdev_enable_active_config()

Because, according to context the handling the zero reference value is
different, It seems,to integrate the get_desc() interface to handle
above case together without extra arguments (in case of here is
"enable").

If this interface is really ugly and unhappy to you,
I think It should remove get_desc()/put_desc().
although we can add new interface for cscfg_config_desc_get() for enable
path. but it makes people more confused.

So my suggestion is:
   - sustain this patch's contents
   - or remove get_desc()/put_desc() interface but use
     atomic_inc_zero(&config_desc->active_cnt) directly in
     cscfg_csdev_enable_active_config()

Any thougt?

Thanks.

