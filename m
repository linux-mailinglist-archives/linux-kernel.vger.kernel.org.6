Return-Path: <linux-kernel+bounces-424300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2CE9DB2C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA05282848
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B5145348;
	Thu, 28 Nov 2024 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZS6SOQo2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZS6SOQo2"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0841422B8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732775022; cv=fail; b=CG4QxptC9Hw/OrJAO21mjwkU0v9VWYZSiXfBap7NpH6m1G4qsqNUR7tFRrIq36h484PEYqNs3sAHW8zd9FoXMShjS1UrUElwPs577nFPf+ibAorOOe5C+AkdXdWTqPjMUcj8ORxB+KpPmbXOIdI+Jij+H19CMX90AfGMIce89xY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732775022; c=relaxed/simple;
	bh=la0VFwEfOAWorGt4SbPWkCAnXN+lgGCBJQTxs/MHHiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M7U5qCixzCEmYiOw899SEu5sGDihHX5SbKDs+poD/jpCiwWVBTVPO7QfBGI2Y05c84/4Vb7vRNo8lOan/ZMw4POmqHJ8kNxpvv6StCpa7XgIXHBbK88hIH6zBsgVXzw1qj5uQs3GLbIPsmds0PRJ5gPZYeCGQW9NwYCkDjaGR2g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZS6SOQo2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZS6SOQo2; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=p3LSGp5qmrsbZozFfqr/eu0GHTugy0v7KvLzvrWua4+J1u+yA1434ygC1VJZwE9IUDgx1jxU7rCfwzgqBHtOVElj4yKnKZvEJv/qNIv+iipysGAIS4QBqXX85zRlk+1iOs+RIUc6TuKFZrooLj5zzQ6sxMakdjLMg1e387Y5Emxs/Nf8ED0Glg5ChXxoiRWLosqd1dA3K2p9nxLKm3V861Wi+XqdksFu24+c/rpfcZiZL/jsnQxwbOu1r897nxiuBpt59KY/qZK3grQo+qmlHQeGZUkpDQZlCKu5/4xEXwHDggYSm0cvblMjT+3N4oNdt6t43qeY9VsQHnG276GbUA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B845PDujJZA2/PooLgD+a8zkPUg1aX618Fzlgyw05jE=;
 b=uLm9zVwvzuwV+7a9JUGNWVCKdYdPncZ5+dFA9y7u6SWXG7oSoc/vpSmqQaorkCajA72mJ9ORZC3GEGuKy2qDSKnWNrwFXmnKGTGX4DipJSohYDThO31pxUBLAH8yv6ER+SC8nl/7BlBW7ZUUZrJblqvD8UJ9qyHK3CR4L/xOVqLdsC9S5KTjlclMVEp27y29XL+ZdFnqJkNcIo7uQtXDt4oomF6iCTkoyYO6IlZliYszQgVU1MB0i406hkfiTzj9uSIkY3Nk178dWzqM4FBB6AJd7UZQL90u57AcaNSdVPCi7PtVdg2g738v4rQ5f3Ya53FWOTWn4FnmlpzuxPlSYA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B845PDujJZA2/PooLgD+a8zkPUg1aX618Fzlgyw05jE=;
 b=ZS6SOQo2vAQ2jiVfvHlJNO/ntuYBNCro9A+gFDHxwnSSUoRYjIBI5YIilG82lSDQ0FS+j9R26YA9fS7zVfg67M+pBNrUqJtWW5Ikq3q4oVNW4jkgo2Q2/hPDVsbh5JV6pDDmzZJ2IP1Vm38LGMLeEBB3Oe/u2aTga0ih7PtvYZg=
Received: from DB8PR06CA0062.eurprd06.prod.outlook.com (2603:10a6:10:120::36)
 by GV1PR08MB11179.eurprd08.prod.outlook.com (2603:10a6:150:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Thu, 28 Nov
 2024 06:23:30 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::2c) by DB8PR06CA0062.outlook.office365.com
 (2603:10a6:10:120::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Thu,
 28 Nov 2024 06:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via
 Frontend Transport; Thu, 28 Nov 2024 06:23:28 +0000
Received: ("Tessian outbound 5b75617ec243:v514"); Thu, 28 Nov 2024 06:23:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: db5955d616ebdeeb
X-TessianGatewayMetadata: Rc8PV39BqiggdIQTS8Vudkj0CP3bfkkYYdjcjDlba+G0vC+kejbugkfdMeqleAVr+R2sSIdUy+91gbtqpZ40gRanI4eSqnts20NIMc0me4q0Y1ETixtcuEdLUVwC8vpcOp2KhDqd7f86SLXT96bmTawfOPgSN6VAqquBVdkX3L5iqAZeOqzcsDbddD3567CEb+nrefs8633n8H7jP8m0xg==
X-CR-MTA-TID: 64aa7808
Received: from L2f045e2287c3.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 381FD8D9-87F3-4362-831F-3E42D3D9A737.1;
	Thu, 28 Nov 2024 06:23:18 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2f045e2287c3.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 28 Nov 2024 06:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nkqde/YoUiDCxpEUVdvI02JtxAzwz1rb/ezKlOxzsmwenQHJSlMliqP0StmC9Ongz6NGpccLjUt+UBTgaDNGKTa9hzJzrNuuhnv0FqxltriR4fax696faiE4feusGVhidwnXcz7uxEF7zOxgcsrVZjYinLp8UjAz2jR7Wx7FhzJL9aifVq1GOgkG8A8rrLWSvdmd9lvQ7delA1/DUVCaNtY7Ni81Oz9K3c6tnYqVyeUAbkIcVo4ej1dLmVYc3qDWM1tb2/LtTmrY0bqoSvRxsApwfM2KgEaPdcVygFHIlCjCG5WzRkNIcvVpZ2btAVA9WbOqA/NyethmIjDWD+MWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B845PDujJZA2/PooLgD+a8zkPUg1aX618Fzlgyw05jE=;
 b=Z//n+oR9lEWaJtTRlVInZE23rtfjVGzJKAs/9L5N9shXZInR9uva7FyOPiutxiDPXtisy2aAK/I8RAVca+1zl4iT/qmc/1iIYZ5YZGIiT+TP1LsWEu1emmQx+yYLsDfdfjr0tAdEHTZlcs1YKxldgsY9oKAa6p2S9PU1E39ZHqiRKRuHF/Jl0G7UcMkjSrE2rD/QtC/BHqV/mcL376osxiFesSIX6MFJl84y6p58/FcByCxum9DGjxhtdawOs3bkJCRYkrICPkud6CNI9g+8gebJKCjgVp5KTiUGWZMgUNDOHDB7hXe628N+7mizZG076j8DQKZL/SLQvjFlmg7r4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B845PDujJZA2/PooLgD+a8zkPUg1aX618Fzlgyw05jE=;
 b=ZS6SOQo2vAQ2jiVfvHlJNO/ntuYBNCro9A+gFDHxwnSSUoRYjIBI5YIilG82lSDQ0FS+j9R26YA9fS7zVfg67M+pBNrUqJtWW5Ikq3q4oVNW4jkgo2Q2/hPDVsbh5JV6pDDmzZJ2IP1Vm38LGMLeEBB3Oe/u2aTga0ih7PtvYZg=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI0PR08MB10798.eurprd08.prod.outlook.com
 (2603:10a6:800:211::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 06:23:15 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 06:23:14 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: James Clark <james.clark@linaro.org>, Suzuki Poulose
	<Suzuki.Poulose@arm.com>, "mike.leach@linaro.org" <mike.leach@linaro.org>
CC: "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Topic: [PATCH 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Index: AQHbPx8wr3p+WgsBJEaSjUrN0UERgLLLWRsAgADY9mQ=
Date: Thu, 28 Nov 2024 06:23:14 +0000
Message-ID:
 <GV1PR08MB105210FEE951B6331F48CF6CCFB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
 <22ef761d-7a9c-46a2-8d61-3d16c2188c0c@linaro.org>
In-Reply-To: <22ef761d-7a9c-46a2-8d61-3d16c2188c0c@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|VI0PR08MB10798:EE_|DU2PEPF0001E9C6:EE_|GV1PR08MB11179:EE_
X-MS-Office365-Filtering-Correlation-Id: 6673f23c-2e16-44f1-27d5-08dd0f752c9b
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?oArepz0AHvUorkAVihbHyDx1aLWT/P4CelSiPiSzf8tlrtsdiYkf+sm+yg?=
 =?iso-8859-1?Q?00U91Sp9MkFRyIMsZz62fpaqCpN44g+lgj8VHBrsVQO6BpQnhHOhRE7san?=
 =?iso-8859-1?Q?9BQUV1278stb3LH+6rY7FixkoM+BZKw23tJmO/6/VOsQP724rAlVfQ03ij?=
 =?iso-8859-1?Q?3z2tsi6yDfFqIX4rHY1fYuz47GpaPrsUb+cg4fV5xiTzaEwVt739l4+kDK?=
 =?iso-8859-1?Q?S1MldVdAaccLYCdFWw/S79h5nBGO55IwbeqckyNAd7RFZgY1iAIxKvNDIK?=
 =?iso-8859-1?Q?FaxewkGuRF6XBEwiM5pMZAh6Wwb2PvhYiKzEBKrB43Upsc8rlWXwdOHIJ6?=
 =?iso-8859-1?Q?7HXsyhicmL0X83t3REkINzSyWiq+K+Dber0sRhWOXG62FMOL/aOdJXqj/d?=
 =?iso-8859-1?Q?aeqeB4+udnnrGDWLyM5AuwX7kuloK1zb0BXgepEo/EhK7/Zjgzs3q0MV68?=
 =?iso-8859-1?Q?8cRFfWxGLwjaGwmOjBGhW/zwdAloEI+xZHeEGZrv3TUpi2Vp/ljhLFmt9S?=
 =?iso-8859-1?Q?QbiylD+29ZLWfL/XyWEr+JtH/vm2fGywNv17piXQekjfSYqWr3zbt6KGaL?=
 =?iso-8859-1?Q?pvx2wYr7vRK0hI0NSaO444zP4IEbpMm2gigN7ZBUKj+AegTXBE3ryg8bW6?=
 =?iso-8859-1?Q?W0nt97O+v6EUvNzOERNwgbEq7xfXvWs0izGGuvrlLdchgzbT3eYxGXUEcm?=
 =?iso-8859-1?Q?MGPETeGERxQfdUy+1a2MdCa0U3L4tgZivrjAeY85y1vUJmuMD5s7WTi6WL?=
 =?iso-8859-1?Q?dFa3A+uHJ03lPRV3CN4FHlnFhQUFp8N3wooX/dC10dVTZA+pPpKc9MSnIZ?=
 =?iso-8859-1?Q?IHdtWRWQZhgYIKrh7P1liY7+t6tS/IeLSwAhKw8AynOrqSBH0vG+uKltTE?=
 =?iso-8859-1?Q?LeaPKcYAeeFDtUjnB9rllgolbrywRSxgTyarOnCFe9QLnhkT1c5OK5GI9q?=
 =?iso-8859-1?Q?EBGTcfE93cmP/YvXnLS6wwGlM2Rld6ufWx4PQtW/JGj5ufP3p6fLTftPB5?=
 =?iso-8859-1?Q?ToRPAj7F7M54zqX/wS6qBtt3fiJMkICSeHf8ZwSOJkNTi2C8d1/OAooXka?=
 =?iso-8859-1?Q?TsKTpzFSu3bDE0XHIhXNpB4so6zPTIgbbb4HLtfdoIm0dwcaB6e0FpvF/3?=
 =?iso-8859-1?Q?/NyuF5tv2W1lYHDJyak/L2ONbRWjNYfEVv1iKEU3bOUFaVx2RdMwZIJkU9?=
 =?iso-8859-1?Q?l1SEfasiZybvTMiT9545zUtit3c/0G+AUlTEdixyLTPEiMy/Y0gnjuEytp?=
 =?iso-8859-1?Q?+CuPJEknY1oHGl5eHukTMBD+opTieEoLhO4tPhkBt+wTvZx/9Y3IIH0QqL?=
 =?iso-8859-1?Q?7BrXU1x46w1fu+6t3Pg11yZ2R/f+1RU0wqe3DLwViYBjWOisuz3Xp1gwT7?=
 =?iso-8859-1?Q?lfmJqgUTHTCdZugPSbO4ENjrZ3MqCXOic5me7GOoyVW02hLmeiBng=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10798
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	03d00084-f778-4c69-265f-08dd0f752404
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700013|376014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?k+xnfm5C6SrUZywVxD5FHjME/NIqs9vTcvBNy20fY8WMIqOhFfA4xJET1A?=
 =?iso-8859-1?Q?x9FZAmFdNyW1AjopcH1Dvz5LvH0cyBFBQoeM2SCgaYnvH8FRpSHt5/0Av1?=
 =?iso-8859-1?Q?+jnc3Zq7Saxhmdcbwjveciq80r2zEJ2OROyT8pN89ivtA/urjtMYIUA4CO?=
 =?iso-8859-1?Q?qHcD94dyljDYz3gQydg51cTZ4DDynRsFGD5I1Nd+OpwhVAj8BfsYDiINtQ?=
 =?iso-8859-1?Q?oluxSo/HhJRycOrfrvaVTYPf0iklR5rDwGm6uqhDTq5sIeSw9TWajxIze+?=
 =?iso-8859-1?Q?q1qnTth1TzSKPx7FZXt2Kk7T/LGGBQ+q4syreVuwvYlvOUIRWKmYW2ikk4?=
 =?iso-8859-1?Q?9fXEPTEZ4Z1oUwRqPc/ebiGVfoWbPCGhcfzRyehcSoGZm05XLORVENOIcq?=
 =?iso-8859-1?Q?BIVsf1gxHHbkn/AB+8YjAmP3jd6dypKDrVrJSqnhk0b7yZ8Pm8OGpRrqCx?=
 =?iso-8859-1?Q?JEHKR2Lxawtfp67BfP9dP1zXSymjGo8KuUkZJGZagBiRjF9I//QP81ApVD?=
 =?iso-8859-1?Q?rNP5Njs9w/yGjypt4ldTxPVtB+G2Oimj5O455lRyv5NbMo08GQ/CiJ4Ry6?=
 =?iso-8859-1?Q?fmR9uA0WvBA4qIm07PZMFkiFj6wKbFb3qczuBdbG/NRGCntQ0D2sh8YUgd?=
 =?iso-8859-1?Q?5WBvVCV+KDZgJNF32mSGy9R6UTBtxCK488DEcTS/V5wkZhGHxxAaJfOmj8?=
 =?iso-8859-1?Q?d1UdfikxnfNUmcBzZZOAQF0Fa6cv1TZC+Ub+MtfDA2ZmsEH9FIJXqMeDFw?=
 =?iso-8859-1?Q?GSF6yuswS82C8pp+kG6ve2zirspdpddANuP9kGpSfsnxj33QumiXAAyinn?=
 =?iso-8859-1?Q?cCBn8XJga9qFt/Q373fmqHqp15DgPB5D8e67yllbxJljcCfviDUSYHd+eU?=
 =?iso-8859-1?Q?Hv2yTJICeaAGUTiyNgroGpoU1ZHJGIGtPiyhxw4YgQsKIREmZY9h+D/AoZ?=
 =?iso-8859-1?Q?0jyaR06XG8QH0Tqsf3lmtaWAy4zac4cG//mNjlaIeOvaPJXti6j4EX67sJ?=
 =?iso-8859-1?Q?wbocSa5BGM6UFLsj9KAINje3q5g6TOR0fvL59slKqqhDpaWFuFf1CqhdiX?=
 =?iso-8859-1?Q?tWoC8SbkEmb8iYE9EMHL4Cb9Keyk4RS8EgUcTJ3aDILsxQBWvK9Ejrffv8?=
 =?iso-8859-1?Q?V5m3wXyfDwQToQ/6cLCpe5frN9UxQuq0PL0XniLJuAr/JfPajgv2SeK/cH?=
 =?iso-8859-1?Q?KVVVXpXqhK9LbsWc+PVXqf67U/luOOGp961aalZF7FKEJTD8AspS7bS1xy?=
 =?iso-8859-1?Q?QNH8XtwbfycQzzoLgzuxV7TYNmI09AgTnDOCxgG5VShnAJxmHCeeONoPqV?=
 =?iso-8859-1?Q?4K5ECXIo48Bt78wIj+bHkH9+ItK3x7rrBI6yP06JDW/s5eFUKMyLbc/KEd?=
 =?iso-8859-1?Q?Ky9q2dx5Tw1ma6qE+A1/XKemeeOW0/89ojy+BMcdUut9UEBGlVVHH4dm7B?=
 =?iso-8859-1?Q?2UhsrCVVEwTtgtQYST1qT/NPAkWcZy0k1UuexQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700013)(376014)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 06:23:28.9028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6673f23c-2e16-44f1-27d5-08dd0f752c9b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11179

Hi James,=0A=
=0A=
Thanks for your review.=0A=
=0A=
> Somewhat related to this change, but not something that needs to be done=
=0A=
> now:=0A=
=0A=
> All of the spinlocks for the syfs store/read functions don't need to be=
=0A=
> raw spinlocks, or spinlocks at all. They're never called from the=0A=
> scheduling code and can be locked by coresight_mutex instead.=0A=
> coresight_mutex is held on the sysfs enable/disable path when those=0A=
> values are actually used.=0A=
=0A=
> Same point as here:=0A=
> https://lore.kernel.org/linux-arm-kernel/9a637e74-d81d-405c-bad0-c97ec1aa=
4b77@linaro.org/=0A=
=0A=
> Probably needs a review of which values in each device might be shared=0A=
> between perf mode and sysfs mode when they shouldn't be, as there was=0A=
> one in the link above.=0A=
=0A=
> I thought the only thing shared between sysfs and perf should be the=0A=
> 'mode' which is taken with a compare and swap without locking anyway.=0A=
=0A=
I think it seems bit of hard while sysfs exports interface to modify config=
uration.=0A=
Think about one source enabling via "PERF" and other process try to call re=
set via "SYSFS"=0A=
wihtout locking enabled "PERF" event can have different configuration =0A=
because "SYSFS" can change the configuration while applying "PERF" configur=
ation configured by perf event.=0A=
=0A=
(CPU0 - enabling some coresight device with PERF and configuration from per=
f-event=0A=
 CPU1 - reset configuration via "SYSFS")=0A=
=0A=
I think it seems hard to shared only "mode" between PERF and SYSFS mode.=0A=
=0A=
Suppose one soure device's mode is DISABLED, and=0A=
    - one process setting the configuration via SYSFS interface=0A=
    - one process enabling source device via PERF according to configuratio=
n saved in perf_event.=0A=
=0A=
wihtout locking, how to prevent "SYSFS"'s change of configuration while it =
saw "DISABLED state"?=0A=
I think wihtout lock, It falls to enabled perf event with inconsistent conf=
iguration.=0A=
=0A=
IMHO, only shared cannot be mode unless sysfs provides interface to config =
something=0A=
which can affects function of hardware.....=0A=
=0A=
Thanks.=0A=
=0A=
=0A=
  =0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

