Return-Path: <linux-kernel+bounces-403869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E59C3C03
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4761D1C21F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E291586C8;
	Mon, 11 Nov 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="huDHunsv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nvmlJ9qo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF112F59C;
	Mon, 11 Nov 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321168; cv=fail; b=fAIn1hIZRBq9aX7ovKVheIhHNqPtKs3XZ9uqYDrAXOpDf01iS5PlE1VQfsj5dFNIQzLLlY3goJeSKPyJRG7zL9oOVuZz+z9qMF1vunnHftgmboWIvumRSvrBPj06+muBSYgCFbqDtS+yeoMTYvXGJZRZlhmG+GQ9rq0KdwPZUco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321168; c=relaxed/simple;
	bh=fDSA3kY4gqxydqMT6oBVWyLTOSe6DjZrIW+TZDxzFsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pwQREMwYpxyN9kYKAM71OPPsAox/j//z9JOkbIE0c9tYXHkdlYz3MJdtCkrTFyWBsZ9RK9KVmDY+ona4K0J1Z130gjlSCPRTuRepATWHWHuJz1MeNzHdMBLoipFlmVLicmoCz1x9g1YuRCipxDWvC7/UFS7xrj56Yc+9FHRHMZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=huDHunsv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nvmlJ9qo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9srmu030180;
	Mon, 11 Nov 2024 10:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fDSA3kY4gqxydqMT6o
	BVWyLTOSe6DjZrIW+TZDxzFsw=; b=huDHunsv0XlMS3aOLgQoWJsaII33+Qvk90
	1CcB1Yh0R+BOxipUVQ+7tSlwFqr/FObuXONrr0FH5J+RY9r82b/OcsKpyWnEERLo
	Lv4KmZSk+oPH+GOwjsVCOgbEuyRY+A0cv3gWkAFXPh2yrcnoqzxDcVs0Q0ZkfEwV
	enDm7ILUo97dw7sCAqFPQuT7HGJmu1sbNYNVa11Y14A+S61YqEYmzJLn+YPpDKHQ
	2OFwkBYa0+iAHWWpWELKtaPWo6RoEE8D1uwvMHTdPUfOGxX4jOsVSovWoMexNIfE
	ooZz2ELOGyVHe444csC8vQ5LuJ3p42E20qV1EyNJQb+IbkjMl/RA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbt5mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 10:32:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB8T2PV034546;
	Mon, 11 Nov 2024 10:32:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx66vxxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 10:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Utk9U9nudU3hYwxqsgTKRdXoJYUPZkY2l/xOnxjtNRyFoh/YDevCjBynSDLaZASNhRpNgECOVZorhv64S864p2Vl4yvl5gpvdwc2NLtEE4Yu6Cefm7bqzPywbBqYNBr4N8ZwlV4nRN3Xy+dHqzKwXfoKdvHJzw6p5kJjk1ErTE+NOJkAu28UIJqn1pPOsVdiGsv278Uxfg7IOGXMkcqZu5QIP6LTrira7dqdTlvADldEABMbR/Omwx6rn8WOTbDLhkaNSS/wVCkjSoBZbAj6oUXF80EhSbGdVLDYpCvt9/9Qc+6YH9GzDf1pNFy9vWWa+lh7RaAmEr6mcpsyeXvs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDSA3kY4gqxydqMT6oBVWyLTOSe6DjZrIW+TZDxzFsw=;
 b=iDDNGPunug1AQ5omNUBHpxHlLVUf0ZoLNOLk6iK6TA7iHIKjAMQDJztGO+aeeJPHRD47sra/r7lsUkfu/B3Tx2j4Yn71Gx+iXljby9aGHh2qVX3K1SbtKybGvBZbEHhokMoPEiX9UncELnqW1NfAsH4cVB0NQQf1WBUr41wXBZLoNoewflgAawhG9Fmq31nwbsm2psi+cW8Q3DPpoGPA3fZm7VXboWpeJGEbJnfolpFHTamWKF6BOFMniPDkVfek+oEWsMf6gpUtXRW+QiJLEN6IiFqP2Kru0gM/0zUYKRYEuASnqtoPB6T/B7vepTg2xCL5/nFE2npw49pUOCr7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDSA3kY4gqxydqMT6oBVWyLTOSe6DjZrIW+TZDxzFsw=;
 b=nvmlJ9qo0VJKRBzD8Jbb1xqI9WXnjkvM6O/B57KyjoUR4QmXc85fdU6PWOvkQKpAV/vkW+06+qBjnkwN3wtLLNYO/J0iuU/FcBJe5jUUMWRoeHSm87z9XQbBkuUIIZdsBnpEI0Hc1qPF/hqXr2c3y9SwAT4V+2T7fj+9haXOf+Q=
Received: from MN2PR10MB3374.namprd10.prod.outlook.com (2603:10b6:208:12b::29)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 10:32:05 +0000
Received: from MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348]) by MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 10:32:04 +0000
Date: Mon, 11 Nov 2024 10:31:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] docs/mm: add VMA locks documentation
Message-ID: <a7653ed5-0acf-4ce7-a10b-6d146096e957@lucifer.local>
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
 <20241111024244.5ro262uyorwhxq3v@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111024244.5ro262uyorwhxq3v@master>
X-ClientProxiedBy: LO4P123CA0490.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::9) To MN2PR10MB3374.namprd10.prod.outlook.com
 (2603:10b6:208:12b::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB3374:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c95c713-c42d-4cbe-2804-08dd023c1568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?57gl376zeg0kgCFKl1ZxT0OGTtzumWZoeEJDOqXjGEgq4cdCoi+cGsl54Wr3?=
 =?us-ascii?Q?3iOlxvJJNLbX6I/BqFGXbsQv0ECxmeriOv5531so6zTysnQQWtjjnNeIEJop?=
 =?us-ascii?Q?HNiSr7U+fA3TvXb19fPaqcp/fWWdQOx74L5SsRpMk9QgCsyNdSXhc3tzrhI3?=
 =?us-ascii?Q?uKC8/zN4eb5ku2Nw9jKjuAPTuchttprpLj64UOCO9znSrXQVAXmuAYIPBjaY?=
 =?us-ascii?Q?Ts485m/F9CsZfvRm45fsRDPtrjpRBCOQQYpTLn3C73rFuq7c3fzj2VX8mGmr?=
 =?us-ascii?Q?RJIcUb+mCnmm6OaG9wMsybqCU1zL9rMlQLfsubgS6TiHBZIVvzl67klt4PoJ?=
 =?us-ascii?Q?XpankJNMXOVBfvG209g8YGqkB3yqn4/u3i3UINvNTbja5/NWs+U5U4RAoGng?=
 =?us-ascii?Q?WhAyDKKtRj3uaIVwvhzX8Ldq5l1r9hFq0NhFqwvLqyrdp7ilSDNmxAU5nsZE?=
 =?us-ascii?Q?EgIrWLVQvbW6bzmHlqYPGrIDw3q4uX9S6HrC/+63Pb8jxRzBF+MZcdxhdYtL?=
 =?us-ascii?Q?zFQkI2F4LExf+RtFcY61uiIAg68sCkOtD1qs77JmY+8nJrmF/y+TOZY5dD7L?=
 =?us-ascii?Q?zMNQSICWphOX3r/0umFPrGuuaosrP9me5ZI6QSutTh+aO5PCUQhFV+KZe5Q8?=
 =?us-ascii?Q?NNg1iApKMgkZkZpmj0TjKq2lSVcbDdwUinjU5hwP35BCVxKVs1giI/seiyT+?=
 =?us-ascii?Q?z83j35ZU/BBiXpQ4q8JZYl1bwBSXIBfLc6OpkeQZmW6LB3ne70ALVJN9rbt5?=
 =?us-ascii?Q?2ZRWBg2mTf6EGJCFf7IwwxX1BA0PL7UHhh9UmPexpThmB30x6x/qCNo84kgl?=
 =?us-ascii?Q?/WnFuj6IbivWEU1yX3mgiEgT7Ui7FQ1MYhDXDdLr1zp8jaQkv6C6EhrY7vaF?=
 =?us-ascii?Q?4wmhSHZaN2J3fPGXV0xzZMTkMwcbrjM2qWkvgfAGSXjKRVc65VIlaGBDFbkM?=
 =?us-ascii?Q?GOMesbeI/mQMxMP5wwEMPW5QfOHKg0MNoS4NooFuwJSui/FD7MBJAUggrOCk?=
 =?us-ascii?Q?gQbztqhecJHaXfTs+XEbU/+wQYJtIVcGp+CzTLN9gM4XgMBJMTnB3A8cM/Js?=
 =?us-ascii?Q?ZOM2vBjYE0ugMPPPCGA4T0kR6Ibpao6FV3aInE8zpL8pV80tRQ6a3Yl6JJ33?=
 =?us-ascii?Q?P7OywTg3TJkPdcx5dBSFjMzpb7X0X4YyimBGV/MAtpTFuWbuDN0WnBjYUjkD?=
 =?us-ascii?Q?hz+msDVOrQccC/3HzxN2cKn1sbiKsfgu02IWV/OkSqNc7xYt5qw3iPlxdvcb?=
 =?us-ascii?Q?mYuVUttEyfq0/Zhc8aqcjoAEcN6XMD0bKNfABtysu0r+j97592uloOlqFVgV?=
 =?us-ascii?Q?fYI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3374.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ncj/0XpQ0+amS6NxTc+xj09J005e1hcJM4bYEMEQ69JjGo2LHP0Gxerz6TUZ?=
 =?us-ascii?Q?RYducZbZIfWzRGqPMEF86miG6R30V/CBV7UwIPEYG6numzMz1wATnr+MGSNm?=
 =?us-ascii?Q?peSIX+mGVLsCJbM31+FmCyfl8ixuJ6MHmiZ1UUyfy9vYuDbdnebyBKrFJYer?=
 =?us-ascii?Q?G6XM8sXHXlco+4qc6gy1jJaKBAzAigZpYay5sHWNtOAUTEJcVAmAd04wE3Hi?=
 =?us-ascii?Q?CbIrTjWxYmpWj/FRUo0piNwq/Y2YSNONcIP4eQ3YR9lEseqYtQZWcOzhFLzQ?=
 =?us-ascii?Q?ZcH9KI9yJ6L02fujgwb9sDGi8ujBhTIJhNRh66Aq43bXlcA5uO46EvK8Y8yT?=
 =?us-ascii?Q?hNvSRPWT1BTSP97CFiDWFtHBMac7KE76evBfwuWqeIEK+jiyNFkfAqKAUr1k?=
 =?us-ascii?Q?IZKNUFgVdcv080Bs6j5jBPp8qyl184Wn/PDWCUKJZaLFsMibKDnKiIjA5b45?=
 =?us-ascii?Q?x/oiTZ3bAeycpVmUqUeyZQ+K2IpcmeOizpNbim0TiBb1LW0yAnrMfhb8MAIn?=
 =?us-ascii?Q?8X4gKpY7BHUpPzeMtNJwQ5Vihu8UuQSZHP+QS3phjMaMBI3cEdmugQnHD5sX?=
 =?us-ascii?Q?6ZWRCInxqSf5YouHsdLkpfB7TJHBnuZ+o2S/8ZYjeEeCUmDculBjhoRDAqF/?=
 =?us-ascii?Q?hY3km7K1NHGa0Vp0eXr9KM/VkO24tZxQvYdhz7StgphmlFcSnTXpZTRgGVea?=
 =?us-ascii?Q?iS56xXvfoS6Dhbqpd0ygeibh0JV5nU0pII8tjKGxGvaBhpZX47CDJ6/VOt25?=
 =?us-ascii?Q?pUCjt0rh3acHnObIYecb3iVlrwdv7UFz7Q2NL0TLw9vYOQueLJ6xOXJKst1b?=
 =?us-ascii?Q?F3ZDOYo+8ZOX/jaaTCkRs/Zth0f7qKTPoMbYLMBjtWLGy/HTlFYPTyq/mdMV?=
 =?us-ascii?Q?dwbOEfSbdoYbsK+Fp8RU18L6llQAX+/gBBOqKFDTmpbTmeT+0BouKUzWwjcP?=
 =?us-ascii?Q?L4ygoi0kGKHbCbByO4qZcVgh6fNhnj0SyVuH9B8Nw4NAeOTdXdObVB2lfUNy?=
 =?us-ascii?Q?EbW719ch8ox9GGFHZsYBJZN5dBgN5tRtAZcLJLgj9cXJLL4D2ejK3qUoh+WV?=
 =?us-ascii?Q?/feff3WsRW4T8yMSWTI1kK/3H99vHxpWIlXxPQ5bHYvg+WTD4b9C+bJFptoV?=
 =?us-ascii?Q?KaV1fCz0YACmICkMwP8PZRU5L2RyUzuF2d0nuxvQ6JIZriLQt59wrs7Z3oYH?=
 =?us-ascii?Q?lNTZlQY3MP5x/+QOop6oFSdM0U5TCDIHmbOnsA8D62P9iE8j1sddeX2iZEDr?=
 =?us-ascii?Q?RFoPpMqBES2pP8lw4OX3GpRqTBg9ZV9o8omwc62Eg/ecfNbKHn/XsaV2gVS+?=
 =?us-ascii?Q?6KKayvN3NaG+uBnI3Z9A6QKLEAkA5EYJ6jn9o3p9dud1zhSppDBxQMnnrtZV?=
 =?us-ascii?Q?L7rGXBt/i5skb6gnVBDKWqO1IdkJbqVfNZ0DCaEaPz5Rbsjfz1y0rMphhmI7?=
 =?us-ascii?Q?buafjY5YiTPpjaBryq4JponPrzE8Iws9jNL9rOygi0+NH8bCHq4cfahRA2v8?=
 =?us-ascii?Q?xw6z7U6iVfnzl2uufJQiicJ2/7ovgmJ0Hd8yCLZQDBL1/yPThobJRXn8nM+s?=
 =?us-ascii?Q?uNFNj4RXNkONRC1AjMnf6SfJfaYQJ8lOiDFktfVixGRsXQtRJcRd/zQOLl6m?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ji+MXktw0Xgsl0wPrFxEvJxhCj/e8ev+qHZ1ixmBe7687hghX8owwgNHssbVUVcX7biYLgwNWsqBQ1pmKZITjLFl8/FqyyNurZT7/5iIwFLMIqODksQxRwSGCVZC5144/Hlm7qt3K05Y3D90+mG+UmnDS/2dNdxXGlUioNs17md3fuYKXYdurUp/ngk3WedlbJE8KGmMkCG6aqojFBIxsts6B4+5wHZXwjxZ5RJ7XX6Zbo+ToD9TdC+9bPxPbDIaOMHiFDTouAOtOIjMP4IbSDDDpZc6SJFDOU9AD36pwIrKBV40AN2ay0lXADNkHp60+dBvs5fmIz2k2ah6tTtsBfeBiVE9X5tUpKpditSTOINSXxggtiyoe4IGLb81PuVl10N3XupV1dLzLF7ME1Jz2DpZA4jUqCAckNH1Zn674wddqG2Kggdmo9t6Hg91LOuws/Ai/O+TMaoCGdXHBaCxHvKs9tGFHKu3b0ID2qDz5pfHTEgAnUUWsImZ2pVssm9q8DK9INIXkFz6v1yFUsPaWschfkgeSTcktexlJ5Nf//v9a86vnZJ4IGeE5b2ymQpfXA6tm5u6aEjGD2pW/UY5ImKorqHyWPpNZso9hdt70dY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c95c713-c42d-4cbe-2804-08dd023c1568
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3374.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 10:32:04.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9FkFYgWd2CeqRKVMDsilxIP6AxS/LqA/aNoQzXqf3ubIHBvpj2x2N+nTlDyf6tXu75l408117bqy6thF6V0pIqisLu5OMnGzeOLrHNQon0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=653 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110089
X-Proofpoint-GUID: 1sHj8T5T8Ss8Yd_BSUcwjNUEiVQqBc4t
X-Proofpoint-ORIG-GUID: 1sHj8T5T8Ss8Yd_BSUcwjNUEiVQqBc4t

On Mon, Nov 11, 2024 at 02:42:44AM +0000, Wei Yang wrote:

> >+Read locks are acquired via :c:func:`!vma_start_read`, which is an optimistic
> >+operation, i.e. it tries to acquire a read lock but returns false if it is
> >+unable to do so. At the end of the read operation, :c:func:`!vma_end_read` is
> >+called to release the VMA read lock. This can be done under RCU alone.
> >+
> >+Writing requires the mmap to be write-locked and the VMA lock to be acquired via
> >+:c:func:`!vma_start_write`, however the write lock is released by the termination or
> >+downgrade of the mmap write lock so no :c:func:`!vma_end_write` is required.
> >+
> >+All this is achieved by the use of per-mm and per-VMA sequence counts, which are
> >+used in order to reduce complexity, especially for operations which write-lock
> >+multiple VMAs at once.
> >+
>
> Hi, Lorenzo
>
> I got a question more than a comment when trying to understand the mechanism.
p>
> I am thinking about the benefit of PER_VMA_LOCK.
>
> For write, we always need to grab mmap_lock w/o PER_VMA_LOCK.
> For read, seems we don't need to grab mmap_lock with PER_VMA_LOCK. So read
> operation benefit the most with PER_VMA_LOCK, right?

Yes this is the point of it, VMA fields are read-mostly and the most natural use
for this is page faulting.

The whole intent is to allow for the read lock under RCU.

