Return-Path: <linux-kernel+bounces-255614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9454A9342ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7159282A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CA1849CB;
	Wed, 17 Jul 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PXMg6VvV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VOsEjgRS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A7183074
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246857; cv=fail; b=Bja7B16BUgVAJfiSF86udJo+F9xLTD5Ehq/03YAcPzhc0myodjR7XDZKdHdyx7nU5FrlU0g1yv26IwIyjGuFsg41j3awP42OuOrYX4Famm935Pf7LpW6kwzVNrxT75Z7e92z/dECfSSfK9WR60pYs6dz+krKylKJl77KEkcsz5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246857; c=relaxed/simple;
	bh=ZPESTzeh8XvfaDK583IP69YPpytuZWpRLgai7JM9aKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UAqzLR+CM3lpjR9XQmLyKkN9dnagVuodgpsDOjBf1wUBD0D526WJ7cBrUM0EOlN3wNuJtIoBjnjYImRWtBtLEjoxgzle2MHGSadchdfCqMLuZbqssn2jEf0N+qxdJ3/iimEB48GvinUyHOr3hG5y+BQ9MAUyMgKw67sD0bDRYEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PXMg6VvV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VOsEjgRS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJu5hB000339;
	Wed, 17 Jul 2024 20:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=; b=
	PXMg6VvVChm6zPaY5LxlXGuDAk23rLTAEuihIW339N2dcu4knnjE7D4uhSnD6aBY
	Q3BjC5RuYHrWlTgtd7wwdFBEmKD6eCvbcz0EMDP4OD1oXlxDUkok7EMJ8f9ua6VM
	DSQdnco0RO3v4klG9W76IPAKvCSIitzkIKqfiDdBkjGMuyzqfdVR7KHTE/HrVJk1
	Ot5Lig3trbcwbfCOnbCbVF9HckP6BFYPd+zyCLjnih1KkdoBgYVnBh/t4c3X3RhY
	U9cFnS2fBVM7QpJCO1bI78EG+vbh8fyGZRNGLgX5dkGJoI9iHrz0rc1rdmiC24OJ
	Qgw6MLVWh/cnvvnR4cSysQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emhpr0q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJ01Pu006829;
	Wed, 17 Jul 2024 20:07:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwey1f7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+8Zpl685VyB6GnOoPaYwgeIVSTMWN9pHHLGHFm/F8+31mK6kZj5rQBPW8iKPvdnWNbMEtTIjhVw9YE/R3Qx4JVAZuQCNHJ4YPWTSdgKQncF4r2stoMlNw3uGUrocs8+PiUAfLbC6+WWpoLSyG93PyI01XwavgoRG4q2CBM3jmyts3J1yOL4DlxTvwf0WdQ0QQ6tmq7CllfzQI7L+83J/O9zhMkC6kjsSS7gfk438EW3FT2lQuH4lpN3nidng07QVlG4V/eEv7avL/Y0RF0rFz8jolgFWAyZ05SKbMM3j5D+1tSIxusRm8Onwkfr/589sNpeLNhJ53a70loaIP3vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=;
 b=YnZzkqnsVdpKq0YIYgdiSLBVr0nCXBZ6KHbnlm3OM6ki7K6+RphKkns/B4lfchsqGf8w6NGv92v/PdjODATxSKAFzfZG8bvMVr20kkFH60rPNY1W1yYF1xGJeQp7WdrYfXa5zdygaSbcHBXv1jV2ftKVT6pAT3S09QMLIJLNwZ9SkXTKa8mufhiykJDNH5hsAyjRZbrquqB43WAkeLanTjGl4j1ToVC5XYL7HXCYnci95xkUMUJXHixVGEUhLOxISqCn4/m5hT9xf+sDS3rCocnYhCdcEgnhyaXxfgem1da08MYw1qf1aHf1Y+JaBQ9ZZGrkOzIzAUROC6zPkyzIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=;
 b=VOsEjgRSUUQGs3auk+9Zi3ip/V6p43uGOMGR+sUQWJmQv9E0UedlN7DulpJxLzb7bsiEfRSfDLoFzeyb5Ekfycc5y325ykXSwleTMo+Ptb0yo/gN7hAi4GXKEoKtQ8awoVOTCL9NVrmojB7OebO+yhcSg0MMcXnvHiOR4kKJecY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:15 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:15 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v5 01/21] mm/mmap: Correctly position vma_iterator in __split_vma()
Date: Wed, 17 Jul 2024 16:06:49 -0400
Message-ID: <20240717200709.1552558-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0242.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 601ed92f-7f4b-4ad4-5dd7-08dca69c0d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Lye1SotZqYbu9AKIX/iRjbsoSp764YIJuWJ8w16eR2Q8I2cWCG6BwcU2Cmqe?=
 =?us-ascii?Q?ottneQQN/iFU/kOdJIIfeRig65vqtFo7kINJqDC9nmZK5o46DLods/KFrDnH?=
 =?us-ascii?Q?Q8+ah1gokKLm4fAaDHjKfOGjW6FuC9M6i9o4GIFOE5VnI+MIyA1ujV++vkRF?=
 =?us-ascii?Q?tf9oNIiVyxzqM1LcB69AnXVu9TjsfxnksVI8xJDglNRboauzA+Dhbm9R7Kro?=
 =?us-ascii?Q?QuHxJc6chXsp57z8ba2RlE+SC+VcLv82Bwrj083MOPGbkGY7H9GIdCy7NVV6?=
 =?us-ascii?Q?QAJDsGsrmWPFFaybh0BrvIsYHDKj+iFhFNBJhn2uxE4C+73djtjkFDH1ivxt?=
 =?us-ascii?Q?OLsE7tQuxouGTEFUytAIJGO/atO4xtY4OFhottxD2dncT84yNYJGZL+y0E8U?=
 =?us-ascii?Q?w79CxYHhRoQfGUB3Bp7ZODQ+kb6Q90NTQe7mhi8yIixFQDXnVjH66O8R+JlE?=
 =?us-ascii?Q?8RdsGkjK6lzIlxAoijTfxuzUp+IvB2PTK0FSrjJE0ABgX6tywagHMlQrnMVz?=
 =?us-ascii?Q?CLDHWcILZY3b+VYpzcRsjLxnvUps/hwj9jxJXH6mQBgBq5zdp7qWWqeFYgfu?=
 =?us-ascii?Q?X1gS2C0udbNWqU00xlE5S7mGjcGFoxx3+9+mWUGw/xLghOIOWivRd61DsI1j?=
 =?us-ascii?Q?Mi/efUjSxEigMZNc4z9ucGF1vnatd0sjtxs/eWKXyFN/zEQyiG0XnYjvDngR?=
 =?us-ascii?Q?JbgwqxPSlRXs4kb3TeOgxZWxgj6gntdg6YFmLitfDtGOotbgDqk9CxIOOSQ+?=
 =?us-ascii?Q?Zb1WBmddUaJg7S2q5yItpQKH0rKquSXqHYnzdAB3QZ1WUT748qTidN53gkyv?=
 =?us-ascii?Q?vyfvHjJYaU6Oh4GRkT8ssvZ5FwfNNQqECEPAyUXkECGI6VJoClnbQP6P+2Tx?=
 =?us-ascii?Q?U74n0Hllus/2GAkwRaAqfGt5Z8rQv+5aGEFIl06RxxkopWArXIfgATpkovwK?=
 =?us-ascii?Q?cKntxwLnMchtnBjcXXxhN9H2S8ZG+6T5RnviDkU28EeWY1L40DlFMlC5ZPxy?=
 =?us-ascii?Q?zHJ9ba/i0xsxuXZVVLqDkiaO0wwKFGUVVS6bkSY4aeGFw4zhOHwVABhC6TzK?=
 =?us-ascii?Q?pwbOWAtfgc8guwOCm1OSwlodbbTFjUHxjFkjpueI6eu/C91Kkodt3+ktFaaH?=
 =?us-ascii?Q?6IB43jGXGHvM2gmqGIGPtcNIfq97nvMQJ+U6yQEMhTFQNGumTjpIxQx45/ju?=
 =?us-ascii?Q?EgT4mt6hM28fyK6OqWzQt4sW7bEcvf5gm/EDX9GIt1UIIsmC28GL1YP2As6N?=
 =?us-ascii?Q?OT45rTapPy+DxJeWXOaMsJZqGat2gRWjLQcGmbRDrOrkFiZTckMJCaFJ/Dar?=
 =?us-ascii?Q?WIKyvVvvSd2hfuO0h0STaH7/zQy4Tmppbr6k3mERpKd2Dw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RehTt9hjQSgvOhQHWS0DSfsUzlgd5nVWV87librkiTso+nqo3JpRod6ppw17?=
 =?us-ascii?Q?fS9nD0oKsx5OSziBuzYrMFG4Ptm4228OMWNd/t/NpslupTua00nQNUA1MDmp?=
 =?us-ascii?Q?zn4/obveLwHZGtq/MOM0/Lv9HTtJ5J4JdRxm9AGZ8jZa64oy9Aad7/E7mnY5?=
 =?us-ascii?Q?CsrAfnKexUMRkkPTwXyofJKmONlnR2Hm5hwPjjyzAV1iDVldxtoS57Rnn+8Y?=
 =?us-ascii?Q?EdKf0uKwq+jOiqQS8okh3a+s0VrZoYCkI6jGhh5z3NsTCPmTyDHlz9pD2UsP?=
 =?us-ascii?Q?2gKZrwPJLmpqhwuh5Flq0/GLkWSyo9mWEcSLfgxsCb3+SZmF9xPHy4FPvMVr?=
 =?us-ascii?Q?BatEi8kb++tsNYnur4jTl3ldC3TXxWXgQCPUKFbm07tCOrjWjVxvBbdIdyyh?=
 =?us-ascii?Q?iuIx4t4a7YwLJRRQ7f1i3zjqr3it71S9udDUuDzEj4Q6q6bnATEin4HgyEMt?=
 =?us-ascii?Q?yZVAqJkpfH5oBHjv8zzjYR2csqluSm35/UsxQmerPC0efpV6/vYxqsOFqFjj?=
 =?us-ascii?Q?JTejaubVhQVu5Drvhe4zJXwbV6Birv4KeSfHgkiZyUq81az0gvlTHP/yk2RT?=
 =?us-ascii?Q?UGjThlXmBKrmBNHIniTJEvoIOX6H00vL+Xa5gaup0Tk9gFoYGHsxc3RrQYQj?=
 =?us-ascii?Q?//2SiyzfxDKhDv5jJW1BuiHOWLF1yl5SvVUB1Vp8OnSvhS26kjEH20zhIZ/3?=
 =?us-ascii?Q?WdiFhBX1+PU6KfhTdWVdfe8IVeIqVUczecIFpTOl7ut8MSLjfuJVO65qkhg0?=
 =?us-ascii?Q?s9JpV7nwOw8PW98haxJAs1YPMO2+llpDK6HcWzulPCraYL0zIKgsAJ1ReZlN?=
 =?us-ascii?Q?KF7KsBABiXfx1KtSDr4GvhHbjn4bDK9V/ZnR2X8yA6mi1HdhwLTFXpEH3Bxg?=
 =?us-ascii?Q?5jXwSgRMvJySvrexgNNQGZ71AIYwbyb/51H+tgFWBhYEibAvFoN9fWwPWPUO?=
 =?us-ascii?Q?YUBAXjI6LSyPrmy3nmiMsmn+MSqNEqeWA4TG0uyLVpuIwUKq3xOepXmu8hSb?=
 =?us-ascii?Q?clwP0GbHKnPl80WUzbbmiuRO4XdWxrJYyqfUg0mcC4r2cgWw7eou/c1oY3wN?=
 =?us-ascii?Q?5jLC76oqyzx2OFcRmmRKm3Mr6IZezCWxmK/6v/+tkR5RNJlrirr8sGfVzCrh?=
 =?us-ascii?Q?5cPxbYKuTEA8BLPDsXjnu36dvP/vn3EuOsq3c8ZSNHObtWNdTaD3gupkWSqr?=
 =?us-ascii?Q?B8+tnishXyWDmxAx2itRgkfPNOtEJK1q6gtL+D6RUaKH+kwcC/XPjJZH9qAv?=
 =?us-ascii?Q?plgOjxD7io4tepaFHx4cnFpJ+jFEWuDu1VuRtIZHwadXTwrptPx+FyiG0c/6?=
 =?us-ascii?Q?nZ35CmCX83g9ojWeGSOGdylRXxlsnzq2yF85yUiWMadL+ql+PDODWk82AS7i?=
 =?us-ascii?Q?7q0dGatGJ35CpO4KbTLNRPQdA0KsjSv3lTYOfB+RZJPqsmhzIiX5EIUum6dK?=
 =?us-ascii?Q?QdL5tq++7XS6Hk41CpYPIDzrZVJWfeN1TcZp2y/oKlyzOjKvtwPZwAavLkXw?=
 =?us-ascii?Q?NskJJ4Zt9O4LCkFlzVZaJ/A3qSLjZsF2fTtYOynW4AEbB6Ikh9OuzJxW5RM7?=
 =?us-ascii?Q?xA9JvKOqMcK7wJvyYGUg42OlpWEAQhtzlV0hAjv3HPxSj4ZBJ3divE29V8Ec?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vt7qNiN7clzQPgCUlr1B142FzDrMIQodC3KehzzdPbxzh0H31S4takTPTjDbLUeQaQ3H8Ll13aDIUkI8WKq2KYYy/08FFLyYlpQTmFJfaCa2gvnXH459zkiMuE3od/0LIE6J3wisvbT+45UWrKYTkfYREYmaQcxgeChVB8lE7ZyiP6IVxYl5z757kFZ0suuLdlYzw4cUiDbdf0af1xsdPAxQfW3HpnZIY/pst7S/1tuULuBBAiaA+dBqZkBe2Hx0NtfSG16HLntefRnKCr+UKMTp5o6PArIRt2Jf99vOqUJuyKQTDIbLVZsCJM7eW+Nf77pqZI+pxhzv2qtRzeXhumPteOy7J7yhQzNq7JsT3fXTUjMOwkNt02XodU6PwPjwtLgCuWru+kFz3b6PVZecxUBmzDvRz4qfquTlSOnFCZwa+W2FkHbFGa9ev2A4G0Et1c1hGUdvsyw36FdTkcUpaAlnUkT5GzwU0NHWkPQJbEiinvptoLTeiGt46PDXuCOM69l3s3LDBuA6L2YgMb/ZuDifYWyLF3zFCH1ug4q5gBs5Be+KYU2LAe2w0rw60yyIT99B/gdqMH8A/tlLb4tuXz2is89DE5RH/tIIFy9eEOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601ed92f-7f4b-4ad4-5dd7-08dca69c0d93
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:15.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgtYF8bXCuReoB1TnYjaq900+/AgT9zy1vODnUpRdhgd16IMI73yjxGvM7/Gg0smATC1HFH/8G1xufE2hkmmiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: 8OI3qzsgwM6PVv8UAj1fSiyPCHzfEas2
X-Proofpoint-ORIG-GUID: 8OI3qzsgwM6PVv8UAj1fSiyPCHzfEas2

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e42d89f98071..28a46d9ddde0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2414,7 +2414,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
- * VMA Iterator will point to the end VMA.
+ * VMA Iterator will point to the original vma.
  */
 static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long addr, int new_below)
@@ -2483,6 +2483,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;
 
 out_free_mpol:
-- 
2.43.0


