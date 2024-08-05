Return-Path: <linux-kernel+bounces-274632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F87C947AF0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08FC1F217D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153E1586C5;
	Mon,  5 Aug 2024 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hM5K3w92";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ivbhsCd9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035431581E1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860081; cv=fail; b=iWgor26gTSxtGJ2S1MyJu8k7GvOWa7iB4hlB2RoYxN0buda6iUS/UrZlzv8Uxxo8YXr5+YAZZowLHe3HPyA0l4CXC2fjDwuXueN46J1dYDY9antf6rdUQfEL3adGCJ3bYKAhXo2adEdbFVOqh+KPmZxBJL8D4pZ0n9+IXvq3YYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860081; c=relaxed/simple;
	bh=dv8ODy+oIWSYbVkt0IK/WXmSoAhzDNR9eDrJOhBUjjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NAbebFUcGzESq7os8xQhZUkosvX/GjA/GscxzHrw2kiw6dAYpwFWR53oZHFky6FKTi2d7zc7BJqmlDFvtbXoAyZvhZ2PjrnZ4tnp+wFQV2Sh73megUHILBRsC20PYoegreVChMpV72hUcYDiL3qgd7N92NKjwsiUdVIi9LkbgBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hM5K3w92; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ivbhsCd9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fbW5027485;
	Mon, 5 Aug 2024 12:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=GT4IfTGhfHAPrFMGRxjZsbTc+MQcsBmHmJoRmmTA0Mc=; b=
	hM5K3w924mqgoJUq0jio9/rFu/W5uDVBr2Dyw33YJiXAs3+/IVKqmULps1v3FJMN
	ZDWay+teUu5PuCXBB4K6fI63j4I1Hz8YLNkDgmsxBISz/PMwxSlsiGqboTh3PoEp
	ixG7gjJvpTu31Ae5n/XRfXTIW8upNjDIYa50Y7oMAjUj/ZqZsgtnkcIOu61OH2UG
	Au6Wj4RfWCFYaJf1cMFaVe4Nc3FmxmlGzGXHflq2fr39SYwFRb7egBPxo9YvoZc4
	NtD3B+WrYdV/BqmC1VomZWJVWd9uw6Yyjf0I96opIyssHpL0iXlUX+z3PpwzOSCN
	xeEs1v74EKK7LE0NASYnaw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfajgk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475BUP21004733;
	Mon, 5 Aug 2024 12:14:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0d6qa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/RRwY20z8eHvj6EKP+HdKodyjXsDNW0FKKqLK+FFhZOgEM7cKSfL9TWbDpQJLuZSf48eI4jdGhZLnVUJrxDJsRsUL2OKi4AE6JhTb+rpOa/gbHyggzxi/08s4k7EcBCdujQR4XAy0FIVao5DzqMQ3ct7+qg4aSyzBn27382aJcoGEe6KwVV5Yj/C/JSYvPKhgMWh8TYCNVeERzfmafC16g85pX8UB0DuPpdYFpvEwm8Tq35m+sa6I6akjHSJz+n58NBW2NoeDjEPjKxm+XhfKlurodUdG+0Dg6idd0/xNQpiLjQbp8wl9nqut+ejWmsWp/6wmYDXBBJQc+T24ymqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT4IfTGhfHAPrFMGRxjZsbTc+MQcsBmHmJoRmmTA0Mc=;
 b=AsQde710EfgT9nOZg+PZgzIcc2lgpPqHEnW6TTApb//5/mzHhs4axwuCWJpgK+h5B+j3DahTQrQcjpKz7jrk1oZzAmRNP4s4mRfqw8OrnfiBnY6qKNT+Ke7a+N6aNVQL8DUxO9WtNE0LGN4VYUHt12oKJyqbiGVkjttl/7OKW8URaJ29QlHy6HkypD5SGWfxICbTbG8KXbkeXAZzQm8Ul95sIV8J5Acp4Xjzj2idZRpbgrb0RvvGxoyL6dAH2tKoXd+SDNiFZ5DtiHxzcXosxG+y1s+CXeHGnOhEi8mVd6VhYs3Hftkq34uJXT1QHr90pOg2ne6A2/vcnjr7kfUPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT4IfTGhfHAPrFMGRxjZsbTc+MQcsBmHmJoRmmTA0Mc=;
 b=ivbhsCd9gKMXkmbixFiqI9TX9m2TJGT+eNALmSLQra72GOj9amB3nztLX3RrsG+S3OMPtSHg8s3D30L50WLesieuTRmnZtLkh5VT4PhJanN1Resu74GrbPgQ8dH/V/cRMfYxZP/pntlSzdpdBSqCNZJQ4+y/ARFxb2DbkBt57os=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:14:28 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 04/10] mm: abstract parameters for vma_expand/shrink()
Date: Mon,  5 Aug 2024 13:13:51 +0100
Message-ID: <95292b1d1215f49bd895f1aa38f54a8274c350af.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: e600106b-1c9f-4dda-4806-08dcb5482727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ggSu+uZvIz/znKvzeU52drZZ23U4QkWL0Xo6vgP5EnvCiXe4N5kkbPvc9L4P?=
 =?us-ascii?Q?CocDiTny+guur9tkpdeEv92uaxKCD3BERXbH0HkGuAYo+0yjBA018OGbomLm?=
 =?us-ascii?Q?TXUZEEUn0JoxofIRAUdTc1ugJygADQx5JzUiTTannGrL3J01Wz3zvR1SvEfm?=
 =?us-ascii?Q?ZijQWRSjMSWe/Je90EMCpJBN1/7JYmxEnenu975wiHQWM7DtJat/BkU+/FRF?=
 =?us-ascii?Q?ffIY0wXoGhgkiOZFiIJjDqHWMXW5G4GHrn49YKsHgbvKsHMpEE5Xzus2xtIY?=
 =?us-ascii?Q?MsXHzFgcdo8CSnVHrhAg+1dy6UseeYRS3NHLR/2qizHwLGX+iNkQDh5f76je?=
 =?us-ascii?Q?A0BBo9wGLZ8ac4wCwiGO6RYh4FvfSUOw+ctcKRvk3CnwTh4WvqDRBgWLnaBa?=
 =?us-ascii?Q?Y1T7lSb31EvCdf/VCwmbqtdHkkKSY7J0H+HN8qKd6gZDHqGDkGfEYf6RmKGU?=
 =?us-ascii?Q?x1xCFksUs3+zL3iRabNo3iswEJPu8eVaBrJQ14rm6gxQZu83h/txmnQs5rGs?=
 =?us-ascii?Q?/wgsnasMgMSkE5kRMOcSAWT6fxxoV8CXEMXduHdEGorvEfvME7jRVvnGEGBe?=
 =?us-ascii?Q?QJuT91xKBIhBdiH/lU4c9cbr8IjXo/3D7gAu9maPv5vTSD/uoWXR1gdL95dv?=
 =?us-ascii?Q?Qq6Zz/mraydO/BA+ZS53rDsbHLCeoB5ZCzqUit3Tf++KbcTpTk/EZVwa5saV?=
 =?us-ascii?Q?vHKRar81Y+1nPw5DyLPhjLUVFyoEY0Sy4lrvlEIgpFm5g9jhp5lmVzNjCFwq?=
 =?us-ascii?Q?sPQNOa0Ms4n0EqZzFVs+i0SRvVa+tH6v+G494PR9UGvurWIUV61ioYD045si?=
 =?us-ascii?Q?xcrtZ22TNZ9RPMQRctG8gJjlibeYfYD4pu/FNJ5pB5EU1f7GgpQOJAoov2/X?=
 =?us-ascii?Q?yw4OssdPHJ+Dqhar+/zhrJQ0EOVrN+RXWrUn9l3XwD2mT9O3kK3nB1aFm+9u?=
 =?us-ascii?Q?67GJv+GjdjmTjiNNlI3vmXN3gjFq51LjUHD/eGU4ESHksU8+fdIFQ7kJcVql?=
 =?us-ascii?Q?cDldLsBxjPhgsmUHl6ZrJtZNAmkcO1ofpJD578FM9VV02v5PVauln3oeL+WW?=
 =?us-ascii?Q?wUo781eHQfkph14Wosac2N0+5wrqpoPseX76EU3GATm2l6NOE8DH8tz5qK6S?=
 =?us-ascii?Q?FmUjl6C70giw7XbEX3agW8Dbv/xbxwXTtfjn6Q/jRdzPo01LHx+A9TNYSai6?=
 =?us-ascii?Q?Gk+fw7qzBCFzR+fHUUroqSFLnV6LP64JXBhjQuqtW2E/DEk8TcOMZS/e5dUN?=
 =?us-ascii?Q?4vD6OKJuEdVH0r2e3x4vHEboOgGz58GtDXj+8AUoTCpnVOW4oVeRZXBTA7Sb?=
 =?us-ascii?Q?pTbKC2iRO0LOFEsY5SA+9ccSDGgCr9EvlWktig0ezZoQag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBrrqULExFAkGiUjXkYi2zciYlgY3NbEiBwCR+FcmnwDvgpxF2SJgFixwNd/?=
 =?us-ascii?Q?Za1bJ8aOvhYXAOxKnPgrX8bKwrTUno9lUbl7AA0w8CuhHoI03ZNb+lHC3XQe?=
 =?us-ascii?Q?Zf/qE+ry4fheVIrgzdzAhlG8f1XueY6CHnjPfdz8eweQlapp98JSVtFs4/CD?=
 =?us-ascii?Q?s/NP91UW9z+A/BCUwW9KH75p1psElEL7TNs9i4wDhr94H63qKyL7EXnFeC7O?=
 =?us-ascii?Q?agh6Wpe5SWiw+U+qg1FcfCiUOhqZwMC0+R6SZFWhBH512LHWpgq6qn0q4z69?=
 =?us-ascii?Q?H9nUAxDTugIifERsmkQZGxNOBalP51I7EfA8MrjmoxvPefQlrhqtvDNQPkV7?=
 =?us-ascii?Q?bScYZODKn9rfPW/Dfbk0XyuS4ybS7cAw1xnn6OeKVz5oJg3dD0QisYRkgHih?=
 =?us-ascii?Q?uaiOwqsM9rAHRhhzvYIckjdev98RJZyLg2BrWbwmuMgWRqr3b2hlUE8n0/l5?=
 =?us-ascii?Q?A8dryG0SUMoYS4VlOQAGi86pnxRkVptkt2Z1i9qki4fz8KaZHlW80iMYq8yP?=
 =?us-ascii?Q?LD2leNXB/L1E8aZHJfTE46FnDD4p5aUQ7D8LEyx99qKRVml+D9kQEA2S7eGa?=
 =?us-ascii?Q?BUNRo3EkxvcmqQlshUXYyu0hQ3eiyXBu08g7J9w3NNMXKO9q+Xjea/hq2Fcv?=
 =?us-ascii?Q?BiALLyrjzPEBqL3UftGVgSA9P+DflB5CVcse56ArGfIvIjGbxytRVArTQVZw?=
 =?us-ascii?Q?OTrKyv9UxUmNU7c9R0FIAbhKP1WzK/Y+KnLyk+gYu4a/LgvRXPQbcU2CxXG1?=
 =?us-ascii?Q?qXTsbTsdLwyaWIU/NOoKZC69PlIGsefSktMj+svrZlYgq0BqaL9cTjdPP2BZ?=
 =?us-ascii?Q?78JFwWGqzJBnkPw6aHV+mWwOVP66k949pVeZ95B1L5GsvleDis9Q/q4Xftp3?=
 =?us-ascii?Q?yZfctCKJqDq6bRO/YTDYed2WWFBq1WWBb/EEgK7NxQ2Xn89+h/1I/ZUQiHCW?=
 =?us-ascii?Q?W8UjrXYERwf+SJdPWJA4V4k5kwtX2QzMYbuAvHZam0XOCQFPWSuhfm1V0IV+?=
 =?us-ascii?Q?virkOWFMysogXKKBVdVlIqa2Wuflz4VfnClliXcA2SGuyzm7TtB37He/R2cm?=
 =?us-ascii?Q?7xU/DQvJLeMYYSzzJaRMXSX/LO2qHm63JaF9Pe7Rrn+3Quy1sVF8JNC25eLj?=
 =?us-ascii?Q?7F0qaOubvxPr9bsdXWSCuPzHVCsmgETgUNxVCyT96KUPsGYRoB6YlPcIqYgF?=
 =?us-ascii?Q?ffroo4zE14283VuagxvYpbvHTtiwoXIB0tskSkJvlo3tznx4c0w50tnT720h?=
 =?us-ascii?Q?2M+RJAlacvU6pMONvGV/S5SiXXNei79J3ZxofWI+tRFlNmMwqoGczcmMxRMU?=
 =?us-ascii?Q?anplc+MvnQBR626VOsC7vPASNxodzsW06mbwGz3ZZ+pxxxuNh9qGfp8n5KOp?=
 =?us-ascii?Q?b35Y47GTxq4gnihoNjkypLnLgnnk54C2HISZtPu7w5HH/9eG8H1csAutWzKR?=
 =?us-ascii?Q?akdvl5km6kQta8Qy4PVh2F00lRsqvL9yJiNV7o3aoCbEIOQSgeUgDWmh9uL+?=
 =?us-ascii?Q?W51skqohdbbTE+Qi2+34Nq4/O4wQgBDxfUr0tm4krYaGsgN87KMKQClZMSNY?=
 =?us-ascii?Q?05vbThAstna8XmikGohb9WmEIKicSdQnekQ9+CjbfKGGD3pr8t10Edg8U6Ke?=
 =?us-ascii?Q?Z0A/DYbhNIIHdQXJmE/Mtsr8n7/RsAM6wSaRjksEL1ikTVmzQtJ1xWDI2PR9?=
 =?us-ascii?Q?q9fAPA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rb5ndVeligxB73pqq6hqk/aXB8sQ3BzqbmqtAU9Vqv+FRa00o4pdNlDtoqTF+WIXy5ecFgwR7rXauCyESF4CC1H0tf9QBH4+/b5e5d7LaIcmJfq4eZwZ/iBJ518276Fq5mFUYOV3AcQr348Y54SI2lRNT5sRoZg9burjieOUNFMhDlitZe3a0qTd2PeQvyr0aLe4nGf9Sy8WBLJl/edlQidP16sMT76XWmpLhDOD/p8TXF63TzDBFeooSXMbicwnsClM9wMv+ISVxvByp40re7zaLN20d0CV6/e0AKj0O2fFIrKJzxAnuOsoM0+ndrZQ5FF2AJVc/LCSW1jQH/ajTdJqO3e4H0Rl41ERtZYe8qOFyf+myQ9Yw9CPQuwW7Towej8xjke1kSVZ0JJ+H+OIO2Guv+7h/Un9sOxDQJGWsivtCH1bluao2OKjlDGKt99wKiKLKSrYe2VknP/hmXJMdl9cu0d4P8pSIkSJpTdYH95LmN4uLhVk3tNigKheKjPJCLrPUDDU2DLQNG38iKBWoyQbhKzHk5evJ5h+veSWVtGfQ8uf6nikDWbZSd5ePjL4pE4pNY/5+dFno81sD8iWqvmOXZPdXgRHw8QZ/IohUb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e600106b-1c9f-4dda-4806-08dcb5482727
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:27.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+fxybTYTCi/9p4M09GOuvPzzGFQhvIvg+0bcqgnHIFob47BDu3OFuF6laUg1SzsAm4JF2gk1+6h3H36crA9PXVGxFGzJqGi8Cs0fmUaVaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050088
X-Proofpoint-GUID: zzvnbEPIIlnELCAbUISlKy_fOUcyDNwT
X-Proofpoint-ORIG-GUID: zzvnbEPIIlnELCAbUISlKy_fOUcyDNwT

Equally use struct vma_merge_struct to abstract parameters for VMA
expansion and shrinking.

This leads the way to further refactoring and de-duplication by
standardising the interface.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c               | 30 +++++++++++--------
 mm/vma.c                | 66 ++++++++++++++++++-----------------------
 mm/vma.h                |  8 ++---
 tools/testing/vma/vma.c | 18 +++++++++--
 4 files changed, 65 insertions(+), 57 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 721ced6e37b0..04145347c245 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1367,7 +1367,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
 	unsigned long end = addr + len;
-	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
@@ -1423,28 +1422,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Attempt to expand an old mapping */
 	/* Check next */
 	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
-		merge_end = next->vm_end;
-		vma = next;
+		/* We can adjust this as can_vma_merge_after() doesn't touch */
+		vmg.end = next->vm_end;
+		vma = vmg.vma = next;
 		vmg.pgoff = next->vm_pgoff - pglen;
-	}
 
-	if (vma) {
+		/* We may merge our NULL anon_vma with non-NULL in next. */
 		vmg.anon_vma = vma->anon_vma;
-		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
 	}
 
 	/* Check prev */
 	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
-		merge_start = prev->vm_start;
-		vma = prev;
+		vmg.start = prev->vm_start;
+		vma = vmg.vma = prev;
 		vmg.pgoff = prev->vm_pgoff;
 	} else if (prev) {
 		vma_iter_next_range(&vmi);
 	}
 
 	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
+	if (vma && !vma_expand(&vmg)) {
 		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
@@ -2359,6 +2356,13 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	VMA_ITERATOR(vmi, mm, new_start);
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+		.vma = vma,
+		.start = new_start,
+		.end = old_end,
+		.pgoff = vma->vm_pgoff,
+	};
 
 	BUG_ON(new_start > new_end);
 
@@ -2373,7 +2377,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+	if (vma_expand(&vmg))
 		return -ENOMEM;
 
 	/*
@@ -2406,6 +2410,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	tlb_finish_mmu(&tlb);
 
 	vma_prev(&vmi);
+	vmg.end = new_end;
+
 	/* Shrink the vma to just the new range */
-	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+	return vma_shrink(&vmg);
 }
diff --git a/mm/vma.c b/mm/vma.c
index b452b472a085..3d6ce04f1b9c 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -489,30 +489,25 @@ void validate_mm(struct mm_struct *mm)
 /*
  * vma_expand - Expand an existing VMA
  *
- * @vmi: The vma iterator
- * @vma: The vma to expand
- * @start: The start of the vma
- * @end: The exclusive end of the vma
- * @pgoff: The page offset of vma
- * @next: The current of next vma.
+ * @vmg: Describes a VMA expansion operation.
  *
- * Expand @vma to @start and @end.  Can expand off the start and end.  Will
- * expand over @next if it's different from @vma and @end == @next->vm_end.
- * Checking if the @vma can expand and merge with @next needs to be handled by
- * the caller.
+ * Expand @vma to vmg->start and vmg->end.  Can expand off the start and end.
+ * Will expand over vmg->next if it's different from vmg->vma and vmg->end ==
+ * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
+ * vmg->next needs to be handled by the caller.
  *
  * Returns: 0 on success
  */
-int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff,
-	       struct vm_area_struct *next)
+int vma_expand(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
+	struct vm_area_struct *vma = vmg->vma;
+	struct vm_area_struct *next = vmg->next;
 	struct vma_prepare vp;
 
 	vma_start_write(vma);
-	if (next && (vma != next) && (end == next->vm_end)) {
+	if (next && (vma != next) && (vmg->end == next->vm_end)) {
 		int ret;
 
 		remove_next = true;
@@ -525,21 +520,21 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON(next && !vp.remove &&
-		  next != vma && end > next->vm_start);
+		  next != vma && vmg->end > next->vm_start);
 	/* Only handles expanding */
-	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
+	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
 
 	/* Note: vma iterator must be pointing to 'start' */
-	vma_iter_config(vmi, start, end);
-	if (vma_iter_prealloc(vmi, vma))
+	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+	if (vma_iter_prealloc(vmg->vmi, vma))
 		goto nomem;
 
 	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, start, end, 0);
-	vma_set_range(vma, start, end, pgoff);
-	vma_iter_store(vmi, vma);
+	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
+	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
+	vma_iter_store(vmg->vmi, vma);
 
-	vma_complete(&vp, vmi, vma->vm_mm);
+	vma_complete(&vp, vmg->vmi, vma->vm_mm);
 	return 0;
 
 nomem:
@@ -550,37 +545,34 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 /*
  * vma_shrink() - Reduce an existing VMAs memory area
- * @vmi: The vma iterator
- * @vma: The VMA to modify
- * @start: The new start
- * @end: The new end
+ * @vmg: Describes a VMA shrink operation.
  *
  * Returns: 0 on success, -ENOMEM otherwise
  */
-int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff)
+int vma_shrink(struct vma_merge_struct *vmg)
 {
+	struct vm_area_struct *vma = vmg->vma;
 	struct vma_prepare vp;
 
-	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
+	WARN_ON((vma->vm_start != vmg->start) && (vma->vm_end != vmg->end));
 
-	if (vma->vm_start < start)
-		vma_iter_config(vmi, vma->vm_start, start);
+	if (vma->vm_start < vmg->start)
+		vma_iter_config(vmg->vmi, vma->vm_start, vmg->start);
 	else
-		vma_iter_config(vmi, end, vma->vm_end);
+		vma_iter_config(vmg->vmi, vmg->end, vma->vm_end);
 
-	if (vma_iter_prealloc(vmi, NULL))
+	if (vma_iter_prealloc(vmg->vmi, NULL))
 		return -ENOMEM;
 
 	vma_start_write(vma);
 
 	init_vma_prep(&vp, vma);
 	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, start, end, 0);
+	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
 
-	vma_iter_clear(vmi);
-	vma_set_range(vma, start, end, pgoff);
-	vma_complete(&vp, vmi, vma->vm_mm);
+	vma_iter_clear(vmg->vmi);
+	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
+	vma_complete(&vp, vmg->vmi, vma->vm_mm);
 	return 0;
 }
 
diff --git a/mm/vma.h b/mm/vma.h
index c31684cc1da6..c464d25da120 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -66,12 +66,8 @@ void init_vma_prep(struct vma_prepare *vp,
 void vma_complete(struct vma_prepare *vp,
 		  struct vma_iterator *vmi, struct mm_struct *mm);
 
-int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff,
-	       struct vm_area_struct *next);
-
-int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff);
+int vma_expand(struct vma_merge_struct *vmg);
+int vma_shrink(struct vma_merge_struct *vmg);
 
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 48e033c60d87..d216e51206c1 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -142,10 +142,17 @@ static bool test_simple_expand(void)
 	struct mm_struct mm = {};
 	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
 	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+		.vma = vma,
+		.start = 0,
+		.end = 0x3000,
+		.pgoff = 0,
+	};
 
 	ASSERT_FALSE(vma_link(&mm, vma));
 
-	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
+	ASSERT_FALSE(vma_expand(&vmg));
 
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x3000);
@@ -163,10 +170,17 @@ static bool test_simple_shrink(void)
 	struct mm_struct mm = {};
 	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
 	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+		.vma = vma,
+		.start = 0,
+		.end = 0x1000,
+		.pgoff = 0,
+	};
 
 	ASSERT_FALSE(vma_link(&mm, vma));
 
-	ASSERT_FALSE(vma_shrink(&vmi, vma, 0, 0x1000, 0));
+	ASSERT_FALSE(vma_shrink(&vmg));
 
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x1000);
-- 
2.45.2


