Return-Path: <linux-kernel+bounces-437309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C827F9E919C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B7B16566E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1B92185A3;
	Mon,  9 Dec 2024 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ENU8+0bB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zs+1dJZd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97B227565
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742188; cv=fail; b=VIyq34EsjbwxooI1atEuL7MHWxcRZbDAutSg5CK42sXv/elkpl2+K/jutxeRxvxGn8MH9c8KvfXig750pKC6r47ZQeFTIe/twOpIf0LpIyO7PxvfAQnaFuhCDYK/fkw7TUuDLdAABGTq75o2/0+mnY0i1B2291NwvITCjXh4THU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742188; c=relaxed/simple;
	bh=b6aSUdM+r80B8pJQIq/E6pD8+jMRrGMXVrFz16rDkMc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iEpA4ywEt7Ho62i/to7GIN0+9AIDdk9+nunzm67jioMiCntlHESWU9Wpdz32ax3kezTum1vG49wk9iBbmGnMVfD9LZBRw6XZe4Rq08dT6BIBV1/EqIoBmEBHh5xgmxRRVJGdnKbsDltOs1mLgl3MkpBsIp2krPSQIkVwFKe+mmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ENU8+0bB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zs+1dJZd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98gE9Z020341;
	Mon, 9 Dec 2024 11:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NVu0rPzwj12kItZCPw
	Uuy1FYTG39BRCwLuDHzDyFyMs=; b=ENU8+0bBYQOoo7cUAqatvN6J+lftvXRQCd
	9+KmAeLJrUZpfmRqjFdC0Ftqo4fVAhKpndTCqo9kkYVXA6FqtH+dmdDKKgCzKf+K
	XmU5frQi56L8xrPrscjuxkIn5rDlv0TKnRteNWqBAqfOohznDwx459XzCyyWt0Kx
	SEjumYWa2qKOtYANt75xKmPNBUw4ztW4GIx+edtF5iQ845Io5dKIKk9PSVSUBMOk
	OsPcELMTHl71UMNQqnOTq4xy9fJRZXW1WfXvObcS2xcHgosnKiE7iyJQXK1lZ2/2
	kZWXRTNrz+/ArLiUUtoaEqFGl3a2dQzZGyfTL8Sf3++2z+RYETwg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdystygn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 11:02:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99sSEa036266;
	Mon, 9 Dec 2024 11:02:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct757dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 11:02:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOterZMDhkQ/7dj73eUsc5O3qsDwR7UveV4O26XYN/1OhyZF/axaA6LNbEryCpFQqnJpANaQP1EvMJ7mIbppJw8yDw4uzgzq4Gx9MjeW3Zwpw0Cb9Av0uto8Hqyci5MFTWRGQoYRJ0PFjsFFFPZovgLYlZQIBWPPemv02OBXi3cRBd3nOFEbbIZlMxqEUdk4FjEe6qwXJTk3UYMGscd4fo8xBo5XP0M5orJAlbW0BZZ8uKfLvatoyk2KYgm4l3A0c2KfORGr/ACIVaBTRc/8sAv7jiQmpH6ZJp9UGO7XWX9jHsBmiYm52ZL4HepxyJofDATj/kGhczvAjOFswmfGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVu0rPzwj12kItZCPwUuy1FYTG39BRCwLuDHzDyFyMs=;
 b=oeCU2lXuGWHpHxTwCe9KW5awhjGyl9SDD4K01UqJVOki4ODUvqi53PBtKcHyYcUckeGMlIIVigziDPwRMK0B7a66vdnybFASw6zJ0iOnxnSBgz14QuARvwMWftmTKEn/qKcP8/ZTKws0CtBabbwx2mPc9+MHDWpe+kyqfDcYjDqCKgc9tNBF1NCuAtz07reQJFYBxvBsXKJjMY9V82/Nh44cHu3IdDPr4fJiBKUh4C8CNzS2p+Mh5Ce/wrgQXpnux7J2m8X2E4rsCzLC9BzI6KtHAsgpFXDTgior8GomWmsg8MXNv5bNo5jqO0dcnNg/NlLcJiezAH6ynNZJSISS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVu0rPzwj12kItZCPwUuy1FYTG39BRCwLuDHzDyFyMs=;
 b=Zs+1dJZd5tqrJYZaCKKCsNwQP+DVoKXpgMpLJSjoA6G7lWyLvrtdcj75TEZzAebmONGcx1JMLmD706t5kvhNGz7YjWeqhnpvp+iHHcbcD4S40KIIYzK7X4Gjqk8YcjjW78XO98ZTjFaJKW5jZbH67+w8yCJy+Rl+FNAqf0t+Z6I=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV8PR10MB7751.namprd10.prod.outlook.com (2603:10b6:408:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 11:02:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 11:02:54 +0000
Date: Mon, 9 Dec 2024 11:02:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: correctly reference merged VMA
Message-ID: <6d8f9fd9-5735-4285-b7db-9d8c1bf58c95@lucifer.local>
References: <20241206215229.244413-1-lorenzo.stoakes@oracle.com>
 <qvsozunpi4yvooov4usji4xu3v2dt52f3mxcwkwtdcywu6xpgb@oald6acxjrui>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qvsozunpi4yvooov4usji4xu3v2dt52f3mxcwkwtdcywu6xpgb@oald6acxjrui>
X-ClientProxiedBy: LO4P265CA0246.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV8PR10MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f1655d-abc0-414c-707f-08dd184107d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HeGofJ0p5GRENZZR8fNDD86sGgEh7JQvat7UL69YK47rD80fp2XGt6ehmXX4?=
 =?us-ascii?Q?FhuCm5T3n9dGvwQmYFCCYvNcuZde7/jK0k6n9YPNo54E1jH+A+vuDCdM5m/p?=
 =?us-ascii?Q?6VdwbsWa5Avt9vE4RAQfaE5hTx134XnTUBSbBguWT83iiZVi60wo+e+58B6+?=
 =?us-ascii?Q?iA7T4wOmU9l35gUW/W4+QYG/27+c35jgHXVFwtcqSnQy73AMQT5uZ294MDiH?=
 =?us-ascii?Q?ygAEY7wLzq6aLy6u7xvIXv6xSbgl35v5/aSHmiKYu2oZghC8lCgqkOeDbfEQ?=
 =?us-ascii?Q?jex8wK85TE+01NZtsaK/ap8NL4J31givvBjTc/1oaDBWcT1yJhGdpJ8JotMi?=
 =?us-ascii?Q?yTx8qGQDc5bF3vO49GTOMjypGuCX8U1TcHJFMyu0uG+YJPokwZMaRRwV7nPO?=
 =?us-ascii?Q?ySmIj4IumlwJV66u+ftI4MjTyDAs3DgI7nETIuXU1pC9x3SrF2oGmq3cpTnh?=
 =?us-ascii?Q?2mDkNImAOcQRrtNz3koIx6yQqGDhw5t0j6+AUKF0suRlRFG4YC1/bZT/mqP1?=
 =?us-ascii?Q?eGPKSJObXecWS0tuziU+EzgTZcDI1C7vIXqkLM4SJrcGeGL+nJQ81ewAwAKt?=
 =?us-ascii?Q?x4G9uHR2JpJQBbajD4omTmIxR69gU+RjdcfzAEm8cPN4ZPvTF4eOxk9MqzZC?=
 =?us-ascii?Q?08qywmE123IYUIEiErMJ9+YwQQIDpxmhckWjqlAWRgy8T2vtcyPD0tn0jSSZ?=
 =?us-ascii?Q?auOOKlmYN8FOzsNV7ykJ9mZElEnTZGb3DKXCrVtCa/xoAAwJOHNcLZrsHl1z?=
 =?us-ascii?Q?oyxUBfnEYyuApEmalfogH6XFhZlWTDHO25SkKFBmJvSD9rL2yrH4TjqKJrRR?=
 =?us-ascii?Q?tQAnknGMeW5+eqzKkbbaQD9imAH/AqbC83qfL7RbIuQY8lYq4rQ4gLIyUNZ4?=
 =?us-ascii?Q?vaH65pThDK++OOtAPM6qcqoon5b8UPht+esIA26MFn4pGCAU9YNTe/WFqTap?=
 =?us-ascii?Q?jF149I2YnIDVis5cwIxNBbIVWWIP+8+39+tVaGIsC4lzpLqyRkPhDVJOy0KD?=
 =?us-ascii?Q?MgUIH9K7pS0b7Lr9rfLPtGKpX+MkAOjiMuaEII3rcQEv9VD1hH46SZmgwLPS?=
 =?us-ascii?Q?+UzWaIWdsJnmM0W36JRLDwcKZjqhENkR2uBy0xjaG65CEc7xlPIIblzNdpRj?=
 =?us-ascii?Q?eFO8thorLafPxWqahGHN3R4dT4+xvDi6rMt1AgTJiQAcJBl88PIGvaw0rwm1?=
 =?us-ascii?Q?dURUcqrcF1vvmkCn6uf4XQBKky3z6FPnBl746loqGsjWDiWHvWh14h1LCUU6?=
 =?us-ascii?Q?8/V8/w8GN4UCBGxMem8WsILy+QPTg80tnKiJVoH7vhGdHLUtEii3mynZIPmW?=
 =?us-ascii?Q?OTN9+o8bH7ZXSh/NMd8zKI6ED2B4rCgNjJAMxLmUqA9xC7np1xOzdEazTlvd?=
 =?us-ascii?Q?kuCIe28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hI4A3KgWQzcp7uAz3s9ayAewAysAyKBjxEVDM9Y8Wshf6PHPQu+0ynRP3to?=
 =?us-ascii?Q?B8CbO1r9wpn9gKkxfg97pfGjEY8jKl4yWAHKAL6b+nO/O5j4I6YFb86ZUI1k?=
 =?us-ascii?Q?awmXE7YnutFicMtsJHQT+xZBM7cos04QSP7xUvGU/OhWEg30nYOtl78jXcvU?=
 =?us-ascii?Q?+hUgnzd/9YbQEXHWuI+lJPQb5k14jYTetjjBqzsjgad2/ZACm7QHJsEkVzgH?=
 =?us-ascii?Q?PlqSY8LupVfx9WrOlirqsptfwZduOrL8m9irajp1yfFkTQ0CVv82WQrDw+Nl?=
 =?us-ascii?Q?cbV+uWuOP1HfC7Wx6cFa0yPcmIPJCWrtBg2JDI+LU1q4O0wEPz0WddrPMplk?=
 =?us-ascii?Q?bDNi1bAhNBHtwmz+lZDv2eLx8pkTt7ZQ+xaxOi0VRi1HV9hg8WwOL2MuTaUp?=
 =?us-ascii?Q?Kjnrm2BTgyT4v0fLIGn5r3P/86woq88OCrMuK84KVrmFcdujJp4wWhsLflG4?=
 =?us-ascii?Q?vt3WQMEbBc0Dk2C0dU4DasJTVmtdslzHZBOsXUYh7UH0xIbNucZ1a/2Phvb4?=
 =?us-ascii?Q?vHqLPJDHAw/60no5uMnJXBFEoMBMapUC2c+kXESZIiZEX+JxiAJdN4P0K7SV?=
 =?us-ascii?Q?H6wcgyE7tFApC0X0qFHUbtkxC2YIFOMe+0SsMieSmBASv8QxCDl8MVGCCO0A?=
 =?us-ascii?Q?ztswPDFa5NZr6WCWNaXHRoO2PqRPQ0rM0GWPHDjeK7gvnDUHMsRGYBbGZj08?=
 =?us-ascii?Q?hbsn3x+ehepg+Te2hmftFewkY8/rNlWH0qR/jiO7pK7fn37aVH79Zpck7s1h?=
 =?us-ascii?Q?5cFyP003yeBA1N34menXOQjZoYTRWZ+Ea5d04No42/WaEQwpJutiUGIOVwhT?=
 =?us-ascii?Q?1zMwUgwu1YpkEkDt7UwFIVHBMPRtAmtmiYC+5s7GBIDWsVbuue+4MkuYw2+C?=
 =?us-ascii?Q?Re2e64x1Gsd6H0bOBTn4mQo/DnGw1D4PpARXzV8/yU8Eeuf6MO1Kugb/Wfcr?=
 =?us-ascii?Q?W90ezaqn6Ms3zQ4wtX5ZguW2za3fO1djCLL+RnybMpnbIOknfSmhn/jHawv/?=
 =?us-ascii?Q?E/Spx5pbRtApqiZ5lmt2RYNyqYS1MYzDWKl17e3h5BnIt6/u7ndOp1gWkfC6?=
 =?us-ascii?Q?af5L2QfwCNv6JBuLLWuiwNrFGwc+d59v99z1lRy36xrrawpumWowoH3TaX07?=
 =?us-ascii?Q?0UQpeUlcfcG4SATD1N3h+wulgvlbzu/Qhflt1a6S87oaI2jtlgDkHdMVlOTs?=
 =?us-ascii?Q?pvAsrpbMdJ5+8v9wkS6ki8dyjlWnL3aQp3ScKm567ObxsLLv2M6kGgBKe8tH?=
 =?us-ascii?Q?gKwsJKcnZiZYqf7bCTnOAyGLmt7k1e2kjs9pUG8JEOPqhF/ugaemCpPQMrjV?=
 =?us-ascii?Q?LI3WV5sFIlfyB/gZLGDsTN1VMoDTsAmYPkuqQv/LZ3GsEWrwq+U7ZLvnHxV/?=
 =?us-ascii?Q?79oGCxGEOKlGWZ0wC4x+xVzQkQ8nau2ChizR2tppAL+OGQPsmCtFhTrdaBXV?=
 =?us-ascii?Q?eDrAozd9LaNQIAMq1yoFVnJv3dzfoyNUL5fsfQLRBX2cJbs52RxuGY6eYCTZ?=
 =?us-ascii?Q?5TQDwVm/2YIp9CrCA1cqdfOQuxGEBpFzlhlhybck6KHnPnUew/sIPneMmJrR?=
 =?us-ascii?Q?Kx2DVs+4URURK3yBZtQ2uAsiVA1A6HFG8pUUHKd1HIBEXR0e91Ni+4HyZCjR?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NEf3LgAS9JPqVJkdTIUgB3/hYlTIKZBXyrforRrRAJn6qRPfgOS6Ct1l2cuHyGSDMogtTlkA9hUUtoPkgDfpJoGTv3JIL3wO3uLC+Hy9BFO6oYXK1MzYDBRHylICIXeaRN3DhcNaOkfEBZvEDtKsEw/5MktVka8Czu88Z3PuVJSAul4H0B2XlHSK8SZN3o3W3llGCqzIADfTYxqvtBzaMRKZiIvbR8Xi4w2UMmLKcUbBmb5Uy4QmroIu4daq5a13slzm8l8t0XjFpAUPAc4vDmz/DDPnfhZawRO6AkRvedQOpnL0YeX5oCMw59pObfdjdGZQ3EqsHJ6GT2+btpbvjSqKBdSVwosBNka6qTUQL5SJXcmOLrWI1b5hAPJG/kSwfLaSEn88ddP8behpkEnJlftElaVoiKBqo3Bw4aN+Gd67aTS7fBF7ZzX839Ivvh/hjUPTXaAHYcw3b447TiYM7uP0tMVxcqnG1AmRNxwXxXOwYL8yt5bIKVlNe0Jt6x88Naj9TMMbABpu2HHd++G9Vpx8/MHubdi1lVx5iZtcauohugwdaU3kyqiaSG3j59n8jBQYM8u/CgN9LmoqcaF6VlYe3RYbrTJlxQZGeY/UqMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f1655d-abc0-414c-707f-08dd184107d9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 11:02:54.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlQBBrmQD4C04+WUmO9D03hQNxYoHtIEXP1YNokFBydZMvGECsY10D6NGoeFw3znvoZl0df/q6UZR86HxcdMZOgbRPFCUTzL8Qthl41Un4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_08,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090086
X-Proofpoint-ORIG-GUID: 7Yt0oZUypmd79FHuOKqGHFRVUP4k3H7F
X-Proofpoint-GUID: 7Yt0oZUypmd79FHuOKqGHFRVUP4k3H7F

On Fri, Dec 06, 2024 at 05:40:39PM -0500, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241206 16:52]:
> > On second merge attempt on mmap() we incorrectly discard the possibly
> > merged VMA, resulting in a possible use-after-free (and most certainly a
> > reference to the wrong VMA) in this instance in the subsequent
> > __mmap_complete() invocation.
> >
> > Correct this mistake by reassigning vma correctly if a merge succeeds in
> > this case.
> >
> > Suggested-by: Jann Horn <jannh@google.com>
> > Reported-by: syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/67536a25.050a0220.a30f1.0149.GAE@google.com/
> > Fixes: 5ac87a885aec ("mm: defer second attempt at merge on mmap()")
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> My cries to delete this optimisation continue.

I'd love to too, but it does seem that has an important use in that you get a
file system/driver that sets certain VMA flags.

So you have:

         [  VMA B  ] <- map
[ VMA A ] < space > [ VMA C ]

Merge attempt #1 - missing VM_xxx that is set by f_op->mmap() hook
Merge attempt #2 - succeed because VM_xxx is set.

This, I think, speaks to the need to provide a means by which
filesystems/drivers can manipulate VMA flags _up front_. At which point we can
eliminate this.

I mean as you say this is an -optimisation- and having split VMAs will work fine
(modulo mremap weirdness), but because of the above it becomes possible for
there to be a major proliferation of unneeded VMAs, so it's not quite as much of
a fringe thing as it might appear to be.

I mean we can also talk about the fact that there's logic in __mmap_complete()
that clears VM_LOCKED | VM_LOCKONFAULT under certain circumstances which is just
not considered for merging at all but... yeah. That is, at least, much less
likely.

>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Thanks :)

>
> > ---
> >  mm/vma.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 8a454a7bbc80..1ec349141f5e 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -2460,10 +2460,13 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
> >
> >  	/* If flags changed, we might be able to merge, so try again. */
> >  	if (map.retry_merge) {
> > +		struct vm_area_struct *merged;
> >  		VMG_MMAP_STATE(vmg, &map, vma);
> >
> >  		vma_iter_config(map.vmi, map.addr, map.end);
> > -		vma_merge_existing_range(&vmg);
> > +		merged = vma_merge_existing_range(&vmg);
> > +		if (merged)
> > +			vma = merged;
> >  	}
> >
> >  	__mmap_complete(&map, vma);
> > --
> > 2.47.1

