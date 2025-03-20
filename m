Return-Path: <linux-kernel+bounces-569764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86A5A6A738
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4193BEDEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F760204F85;
	Thu, 20 Mar 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rfP0FWQs";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rfP0FWQs"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71B1C5D7E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477627; cv=fail; b=WxoDTh6Z4G8lu7JEbzOPsvpC1193l2gDG/TgljFcsRivzlGjSN/q/JBoPMhJq6DPXMNBTn5vYCdS5Mh/0Fu2d5riXV6vbh2Gti+W6riLhNgRZ4YjLNSnKETEjP0Y8uzK3fs5d3Gk6ZR0RC1XiByYxIbXeSgG4iVnfMQCL5IE8Z8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477627; c=relaxed/simple;
	bh=2wqYGg0nv2bvpd4YI3UVVvXUJigit3nrIkWVFBWLIdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NgbcW9Ey6303TVEjhSMilYMbRUIGR3ArQqUsC5Wt28zAigyOPtZ+WeHqlE3GAxBzraAxdv4+3Rdq+PNJbqvjoKygY7YnPf9O09XR0mOyim3+mAr7gogf4QyMb0bjtODi8hAUm/GMrkFeMeBcrUYvAlBwjMMg9CL4UamZzVPtU+0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rfP0FWQs; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rfP0FWQs; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VUHT4TNMZZW2etn6oSzmqZlHk/uSS2p5oz1VYIhk0wHgW23R5LBHZAF26fsGt2gja25qd4DPmRst8I1Hm2+hUlSCvYZNkVBU1Y5I0eOBQRzpQvNn8YiZFAeKZKDZ0djucPZOBmJIUZ0aIRk7nuBqVDyNhviuIVTs5zOk1KUTA3Myi0zNTTya+Tn3vBE7pu6ZiONHBAGTNXefdr/yskIuubHwVEi0TeME4HRxXQa4HkoNZvsC4YykpF1N/2e5GbldHXF1V385TbjDFqjO1QInmPes0tQQVBfXF7QIASovYOPzUP42wv7YbONA6ILmFW6Jq1uowM/3z3yoQUHmIMYefw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMxaM2N48rm6vGMbdTQ1w1BMkuFRg1eybv7fmbnqzgo=;
 b=nDA+/+xFQpAPD3DjCGoDOZcu84Qnw1qgUxxno5UNhupW4pb1vaBRdiqVADIZ2wX6Pja29JoVOB/ljp5+2wM3xUZ9XSXnJruxGrVPX13QyrdJz5vCuzwYSex/IR9wrkwFen2gBrsthM/pL2eapfuVIgP4sn2Ey90dTelMYxecRUcH5SGMF8pukXrkBIG0vMCT/81NLqAckR2zm/twB1uR5Yu+QHNU0FSCJgSyy4/Qx7fkwDV8js2gLgcQ7351yQ7hfRhcOI7EMsZLnFY8CtQ2oHRGbmSEMV2SQ42KE1sib+lkavBo5aytb0k/KONQKpMdO228EdTh/vPxScQK9GeXHQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMxaM2N48rm6vGMbdTQ1w1BMkuFRg1eybv7fmbnqzgo=;
 b=rfP0FWQsEwI7eREGqbmCx1e3JviDVTh9HOw9KgUpwajBDUSehfQo5z9EpoYxgToRksdTHyIWvBH/Ux5wKLPQSqEpLVSnMZhZqMcm/r4nH2qZ78aKMrI8BODvLSp8D2MdcX5lIcjvAy7w+RXa4GYCfmEfVpy0c1hPI9jMU4lOGlI=
Received: from AM0PR10CA0107.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::24)
 by DU0PR08MB9822.eurprd08.prod.outlook.com (2603:10a6:10:445::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 13:33:37 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:208:e6:cafe::a3) by AM0PR10CA0107.outlook.office365.com
 (2603:10a6:208:e6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Thu,
 20 Mar 2025 13:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 13:33:36 +0000
Received: ("Tessian outbound 77cd431de54d:v597"); Thu, 20 Mar 2025 13:33:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e273608d7f4d4aae
X-TessianGatewayMetadata: vaMJa+ziHtdgFg1/wZF0UAqt/QrfrGXXwPAeWlfbHLt6KJpKkkBe0Zhu75Na2ofIxLs5KCDA3BQDtZQxBw45qO/bSBvI+eWMHdblIgutpagQkjsufOMcDd5QGLVU/C7PCVcxRdYUeElgV+JIkSUyQw==
X-CR-MTA-TID: 64aa7808
Received: from Lf6ae5cce66c6.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 41BBDF0E-505B-46CD-9A4A-4F60BEBB59F4.1;
	Thu, 20 Mar 2025 13:33:28 +0000
Received: from DB3PR0202CU003.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf6ae5cce66c6.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 13:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7DdeHTyB2vh7PNUQU0/4o32nqnZTfR1jS3qgjCDQ9yt61qmAZMQPgTCrsGRYSK+opFcFkI50rb0ogFvoW1CoCv5D3OLuSYoobrrUonGd5USRxyx56nrYsHPS5nfyW/IYRkcpSPOHnr61Mddb4vHVYb6+Z4054fPIG/nThJiUL86m2AMJdwdCUhnENsk+3mUrA89X1ndfF8+VNLsZePESew77S2A3LC5O5P7apkGuMqW0c/LLsJMLuLV7q0pWxQWsAuXZoJyzvatuSX0QH5+ZsQ9m6Lzhfhv5eo4TZdT+lVBKOwMgq9aPyM6ofGWP6XtseODXE7pDygjly962g9HSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMxaM2N48rm6vGMbdTQ1w1BMkuFRg1eybv7fmbnqzgo=;
 b=Y5JToLOyxF2nS/IDGMflDE0Xy8Xi1NJvlOd8F0ISnTV0u8nA6qTlrSe26khoU/aEnwLAEz8xXEOHdudefvIHDLX/afBheZyx1dC0V9UjifbI3e/sAmwAMPsr8VGwzF4cOGsZxZPkV1ghgMeus9ZdEeYyhM3MofF/k/fSJHN6zafauTDz8RoBbN9id4uMqFgLgUva67RBHZsp+K9q7q8NTAjz3XWnCOl3AX0EO9tnsbr07shYcrgAnM3N5jvI7x+vDAuS1WIWHRIP7c80bS3JMBEFkmAUpsGfWoGZuTRsKOPrmI2Rv/Gu3gBHO2qyN/fGn5oN1kuHvIQ1mtZIc66ZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMxaM2N48rm6vGMbdTQ1w1BMkuFRg1eybv7fmbnqzgo=;
 b=rfP0FWQsEwI7eREGqbmCx1e3JviDVTh9HOw9KgUpwajBDUSehfQo5z9EpoYxgToRksdTHyIWvBH/Ux5wKLPQSqEpLVSnMZhZqMcm/r4nH2qZ78aKMrI8BODvLSp8D2MdcX5lIcjvAy7w+RXa4GYCfmEfVpy0c1hPI9jMU4lOGlI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAWPR08MB11204.eurprd08.prod.outlook.com
 (2603:10a6:102:469::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 13:33:27 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 13:33:26 +0000
Date: Thu, 20 Mar 2025 13:33:24 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fix incorrectly disallowed anonymous VMA merges
Message-ID: <Z9wZJH3wbW4OIoBk@e129823.arm.com>
References: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0335.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::35) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAWPR08MB11204:EE_|AMS1EPF0000004A:EE_|DU0PR08MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c84543d-8fc7-4f09-b254-08dd67b3d18c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?90SWkKEEV/iVajc+9pcUyNmdYlFhRma5S44Q2pBKeyZmIhdWWv1FWYZdmm0N?=
 =?us-ascii?Q?8WQDCMqcujZ3j5ufZp4ydiTvY/w4zimxB8ulS/hOpni7Xp9nQo/PdL+XAzlL?=
 =?us-ascii?Q?xaxoC4LZusOVkgLdMXLG470iNE2ldcYjtOdg96/j8l/8BlTyD3GeNaPHn1rd?=
 =?us-ascii?Q?GIgaxUHZYuM8FdazgRpXOe/wccLIqvwG0iD8myxm4atm5r2QMTuy1C4242AM?=
 =?us-ascii?Q?pIUwh0Yg/C0h7ZPPGifKeu1CvvW5vHkCkCs5c/82CKKI8Cz58OJZfp+6+U/F?=
 =?us-ascii?Q?yMsZ7LiPIglrdtl+rM3mdy373MF9cJwXOCi8yP6Ux2aC66Snst3psrjJfvVi?=
 =?us-ascii?Q?kOcVqiVBdRjDUZ29SBVo+48BGKPHDvzgSGPLkwBPJ+q6jB5PkUXQD6R3UCij?=
 =?us-ascii?Q?DiWlcjWLpXvPL4pwI9s9rbvu/XdC/I36ZUbJuEw+7gZ7FZDoFgcuMDBdcWWK?=
 =?us-ascii?Q?Yc7yw3tAfpGp7bH97VtlL9Gt9axUt3tXNxtgPEoVIJFXaZoBoaodFS44Wjxh?=
 =?us-ascii?Q?qlbqH2UTpSd/ynpnTom0ECXC8LuAGMaJZI9NJyuxZDkmvA7ri9rgvqMjSxVz?=
 =?us-ascii?Q?LHFw+xVdmXce5ehSQ2V43CeDiJUBtI9viJz00ZayZurl3vVrlB8yHD5I/1g+?=
 =?us-ascii?Q?wUNfBVR6Z85cKzyFVyZGetZnNL1qwLs29rJSPCBihAPPmoie8sHxoX43iPMB?=
 =?us-ascii?Q?cL0UfCAb8tyHODCSbWkSQOvpy6QVWSzpQs8hpPzWjJYCo0sPA8X5D7ojLciw?=
 =?us-ascii?Q?mLTn7i1qNcU9AAiaL7B4gHwgkxiWKlweIcpMhYdG3V0WozVr0wzBeLsZN4LD?=
 =?us-ascii?Q?u5rkT4tIaMazpzVdpBLbXabqPxm+k0fN9t2onNzqtE85akgydst3DLGumIr/?=
 =?us-ascii?Q?27h0OORKk8eh8FDfRZByY7u4JAsDslZ+V8ps2TQA6OaEbbe0CuJmi3HE+5o6?=
 =?us-ascii?Q?YV5bVnWI95x0cjY2ahKME95KOo//RAtK9S6QgjXLoOohv79y0svjNke11CMd?=
 =?us-ascii?Q?3dkFOPj1cW5uCsHN45hCgSR4n6rh0b1DYXq0k40q6FnIXtkVFwTwRQdKAunJ?=
 =?us-ascii?Q?IX+mSfPmLxuhnEP2Tfjw/WOH7ZcBfsjO+PsLY3j5nlozlz9MCLgBWCnHWMcL?=
 =?us-ascii?Q?57Uqc40T78M6TGhWF2bzwjLfUrJwaGZOVvwvybHk+SRpUQIQOLu0tCIDDokA?=
 =?us-ascii?Q?hdZQ2cYLYW5E5u98dBGgfK4el5HbVSd8JsPkmhu3WsTNbUa1KpmLQnPe24UR?=
 =?us-ascii?Q?0QatmTt93YUzh9akBJcd0SMjT10Od28y+fksofLz0EX7strDuiHiJI+YNUsM?=
 =?us-ascii?Q?1Mm9V+FwU0pUG9ST9uBvd6RWxPW7jafUWGDCagnzmnXeKoYfpF0ry1DBnphu?=
 =?us-ascii?Q?1gESQP00hojp7xegR7hZMBCgOiXE?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11204
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8e400fe8-1280-4f70-044a-08dd67b3cb53
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|1800799024|82310400026|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Q4d9teV+4nbMkcEMV1rd0xQDSxvlmRvgZW6imaDNniKSsuqsv0/0js5Bak9?=
 =?us-ascii?Q?IUjEbuslT0JzhnfaIV3+G8sEaaxyMAp6P9qoacg10y0SKmIjaw80D69DPc9E?=
 =?us-ascii?Q?QlqSw64XjX9wOp08UbFvi7atoQB0uL6qjZovAXwQZk3GxNqX9UkF09huhe9O?=
 =?us-ascii?Q?mgILiLKVtYyXVOZtwsUSXMNP+unx7ambBFCvcMKDy7pYn69P1nGCaA300Ni7?=
 =?us-ascii?Q?XR3dwM0nOgVsb5EKc7ik6v13WLoNObhu2Otqlw9NbxBPEGu1qI7+vEKhTYm4?=
 =?us-ascii?Q?2xAopI7vufdEZ+PdbuKUiSPWiMEJjY74++Op0A8apKjck5/Viwm2UOV2dGZJ?=
 =?us-ascii?Q?3MhPxUpwFCH8NfglcVDelHBWkfpN+lPGTRdVZxgiA7TEZ1dLa3dGX+hnpqH4?=
 =?us-ascii?Q?w14FO+0+TppvfKWw/LNp2HffzCqqa7CC08kDao3+XjT2fu6CxpAdR2dBW0tT?=
 =?us-ascii?Q?dhv8nO99GUSAarEBDwuw2oB5OiVEeuczlI3qQ1mXJw5Vgl2ki5KAc4qHn1B3?=
 =?us-ascii?Q?N77kddQLZXe3vnSc13Rts+EY5yr+S7BxPnqlF9FxL+TKF2/1RpiPPll3fWZ7?=
 =?us-ascii?Q?Gtmx5J0OU1aQuBx3LjEPRB/GOCYuWLymnsW7S+p1huUQzcuNRiZ+78yjLn24?=
 =?us-ascii?Q?QoKGovYOcqeE/qbQ3B1oN5hG3beItG86QX1CKAJyKfQ2IeR8Gqwjs6qfBzfS?=
 =?us-ascii?Q?4ngQtTlavJZZkMuiFq+va/EWBtY1i5GSa4B7HaSOK0P70rTtyLhKadjYibRE?=
 =?us-ascii?Q?Fi+q/EQiR4LrY2jGANHXDptJSBk68Vzp02RfAvCm1uXcyEpu5tI3XD3WZoWU?=
 =?us-ascii?Q?Rirwv38RpExxtw6FrvDmpuiC8HB38LiHFWw++KF2yhBhvck9rL0roQG1qtNZ?=
 =?us-ascii?Q?cePlrf12mzAcXh4k/4O0+IRLbADuguzH8dMZsebQUq4I0lMjHl02R/70kOf2?=
 =?us-ascii?Q?B3uHHvCZ2LIv58oc/QHMwt65P4+L0zERy0x+2I9kElJoYfktsOHnkI3Qpgqb?=
 =?us-ascii?Q?u8Vv/4JCWOGMjZbJ6NtBOZ8sumR8QLbNIK7M2zGqT6/WN+BkuHQq+0JWbz4+?=
 =?us-ascii?Q?BmIR7c9spNketHb7dmAzQ4brwW8wKnUOgHp/fFH8a+Tc6w8fLsIRibx/F8lx?=
 =?us-ascii?Q?rMG84blrYrz0JYYMqsn/kBetq2NSBf61UkC3JvLTRTMOp8GT/fP1fTJnXFIB?=
 =?us-ascii?Q?+9OlY6eO0FbPoDPn4HD/GjOEJjTeElMoLgomtja0ktAbmZTyRQllgz/sqMqY?=
 =?us-ascii?Q?oYzV35ruwOPDvq/t4xqCD9bCZ5z0EH9UtBK0DIrmPRSQcoceo8gXYLm+AzdJ?=
 =?us-ascii?Q?8ooB7cPhxOqHLK7EBH88u8TOQbLT6bfZTOZ9UdW8eMMWFPuZW9zcw832AJ+5?=
 =?us-ascii?Q?yCPB2Q93Zqy5b/XQmyGItstuufuv6MU6Nrls7VMhXfotfHZF2ojl6ni3ggoF?=
 =?us-ascii?Q?/CnfHs8bZECEaXt+qmxYyYbu8Xyo1wIxLBMumE0KAgNKKrmE7dq5ipEiabOh?=
 =?us-ascii?Q?uZ3vBFzxgpS4jQE=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(1800799024)(82310400026)(14060799003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 13:33:36.8319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c84543d-8fc7-4f09-b254-08dd67b3d18c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9822

On Mon, Mar 17, 2025 at 09:15:02PM +0000, Lorenzo Stoakes wrote:
> It appears that we have been incorrectly rejecting merge cases for 15
> years, apparently by mistake.
>
> Imagine a range of anonymous mapped momemory divided into two VMAs like
> this, with incompatible protection bits:
>
>               RW         RWX
> 	  unfaulted    faulted
> 	|-----------|-----------|
> 	|    prev   |    vma    |
> 	|-----------|-----------|
> 	             mprotect(RW)
>
> Now imagine mprotect()'ing vma so it is RW. This appears as if it should
> merge, it does not.
>
> Neither does this case, again mprotect()'ing vma RW:
>
>               RWX        RW
> 	   faulted    unfaulted
> 	|-----------|-----------|
> 	|    vma    |   next    |
> 	|-----------|-----------|
> 	 mprotect(RW)
>
> Nor:
>
>               RW         RWX          RW
> 	  unfaulted    faulted    unfaulted
> 	|-----------|-----------|-----------|
> 	|    prev   |    vma    |    next   |
> 	|-----------|-----------|-----------|
> 	             mprotect(RW)
>
> What's going on here?
>
> In commit 5beb49305251 ("mm: change anon_vma linking to fix multi-process
> server scalability issue"), from 2010, Rik von Riel took careful care to
> account for these cases - commenting that '[this is] easily overlooked:
> when mprotect shifts the boundary, make sure the expanding vma has anon_vma
> set if the shrinking vma had, to cover any anon pages imported.'
>
> However, commit 965f55dea0e3 ("mmap: avoid merging cloned VMAs") introduced
> a little over a year later, appears to have accidentally disallowed this.
>
> By adjusting the is_mergeable_anon_vma() function to avoid lock contention
> across large trees of forked anon_vma's, this commit wrongly assumed the
> VMA being checked (the ostensible merge 'target') should be faulted, that
> is, have an anon_vma, and thus an anon_vma_chain list established, but only
> of length 1.
>
> This appears to have been unintentional, as disallowing empty target VMAs
> like this across the board makes no sense.
>
> We already have logic that accounts for this case, the same logic Rik
> introduced in 2010, now via dup_anon_vma() (and ultimately
> anon_vma_clone()), so there is no problem permitting this.
>
> This series fixes this mistake and also ensures that scalability concerns
> remain addressed by explicitly checking that whatever VMA is being merged
> has not been forked.
>
> A full set of self tests which reproduce the issue are provided, as well as
> updating userland VMA tests to assert this behaviour.
>
> The self tests additionally assert scalability concerns are addressed.
>
>
> Lorenzo Stoakes (3):
>   mm/vma: fix incorrectly disallowed anonymous VMA merges
>   tools/testing: add PROCMAP_QUERY helper functions in mm self tests
>   tools/testing/selftests: assert that anon merge cases behave as
>     expected
>
>  mm/vma.c                                  |  81 ++--
>  tools/testing/selftests/mm/.gitignore     |   1 +
>  tools/testing/selftests/mm/Makefile       |   1 +
>  tools/testing/selftests/mm/merge.c        | 454 ++++++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh |   2 +
>  tools/testing/selftests/mm/vm_util.c      |  62 +++
>  tools/testing/selftests/mm/vm_util.h      |  21 +
>  tools/testing/vma/vma.c                   | 100 ++---
>  8 files changed, 652 insertions(+), 70 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/merge.c
>
> --
> 2.48.1
>

Look good to me.
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

