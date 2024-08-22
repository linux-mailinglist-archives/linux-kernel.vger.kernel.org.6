Return-Path: <linux-kernel+bounces-297879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CFE95BED1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AAE1C231F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155611D0DC3;
	Thu, 22 Aug 2024 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z8UpFi4Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FS9fdp2p"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9091D0498
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354788; cv=fail; b=Tt28ilxp0tfsUg72BkDz3KqWje8pjByvvMnTRnB7wKN8Z/x0yXuxojxWQIZbAexXEkCDTUclPCwBoV3j/Gm3z9N1xzQwXxgg1H/fO0YJ25Sge4ZS3hLtNZb4O5QsHxKq8ChqNezB414TnR88Fu/Tuw+auYyzqIE1oUlZlbShduo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354788; c=relaxed/simple;
	bh=W/1DXSXZ+f1p7TmWamdRwVekQJGjTMWa+MoW9FOnwOs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qfWD+U2fK6B5WpDk1Tvl+e4nDcEFXqlXRCXL5zvuRRV1Y7MyyvMZu1jW5f0D9Ci9egTd4J8eABgWGOYd4QD/VZM22rJftHSgPzhWWKjP3SIPXfcEwKZ8W0keLSa12Lf7idW/xud9WXOC+2u4eHFB2iUfkusRt92mIRS8zxFDHTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z8UpFi4Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FS9fdp2p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMnni001345;
	Thu, 22 Aug 2024 19:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=CneEaELPIVdmED
	hnSNMWg2uSW5EOWAEp6X+PaxnpZ/s=; b=Z8UpFi4Qq0m+dTy971Zzz/nKcB3uWa
	NMKGuonxchmhvj5Y8c0ghqcEidB5kdTyWrw0tWCn5M9kGpXpQiJqMJ6MNJXaEtbg
	SyPdOCNBz0olyKD0P/4Kp9lQpPUFydOxe+Ps5mQN/cOj3Dn5kkLMwQ3VKGA9/9ta
	Auh49OOcfFLWxtu4IxQCJG8yMyjYwLZNPY2H5PoZAR/e74IZsV/qNsXb0bMbyA8H
	978yzlVwXPAnDQ1tpR5rNTPSlsLiASR/oF8sGXa7dNh7ADjeDl/WbHMlVMFLFTDr
	4ZpmY5iXCRTIZonkBTqloewhCoo8b6OMW90LXOMV2stOI0PK/We6/ctQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gjwqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MINtZl028119;
	Thu, 22 Aug 2024 19:26:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416ajutjhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRYu3RUyUT19ktb36XqO4eQQU4ReZADLF/eMl8mtDKk2LIpZW5m2q0TcR4WqqPR2nOFY6ZeqEWknfV1WfT7zQbyXGDceQ3YYDR0qiUlQRdk0jUj9RrXci9Eiir62B3TSWHyGM3xLj/M5EJ+uo3ZaA0DFtQHcNphWUp4CqiwF9GzKDToGXZ2g2zQq876oM7mfJqpM4QjldsKAGSFJfWyVz4vnzWqg/MpSgaYmWeVyxF14DSrFx+Svttv3fffrXgZc41EbObErTZ3LXYaNgHIs3sXQddu1s7j8e8ZX8NllhAPpfIzZKfF5xBHmQMh0iqwuBWsu1ZguDki6kBnLWknIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CneEaELPIVdmEDhnSNMWg2uSW5EOWAEp6X+PaxnpZ/s=;
 b=ruHxZnUEpC1m5ttzsCP008RmUWFwg8NT1xM4lapjMStoQRvL9SEJAEu90KOMWFugfaFqk4pmXoXZyaSaPdJ/CB1hv82748SMwwiCYCBZdPGMqUAET3+Myfm6+rCDIv6ZtV1HTa7aE2Q3t5EUdk7k3zE2Wc+FSUwaEHJaNU8T/JQF9F8+n5AAmPkuDNVdXr0gL6JMKsH0iJtWKmzH4tLXk9Ffc/k7jx5quCsQ3fBu9I1ouk70kRoAy+1qPck0Tup05ULmTIuuARu8MpUtD+FgpPt2HlFVaPrnlf7fOfs99NnllTn+IP/XfF3DZHUAjqtA5R0MH4cRscPTuWGCh4GxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CneEaELPIVdmEDhnSNMWg2uSW5EOWAEp6X+PaxnpZ/s=;
 b=FS9fdp2pGs3+OPyGssgYo6peA/eGd5lhUlIa7CA19DTvFmyU4PdSWKnV8VRWJyxLuOqPJunZ6DLZgWbbS0mmdBey0rC7+rzq9x9PKwwQCAKexeqdKQEbKom6KWhYgEnJ4Pe7QqtY9FbflGWMUBS8Us+PP4ZEC/GiqvGUAY6aZrs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:25:59 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v7 00/21] Avoid MAP_FIXED gap exposure
Date: Thu, 22 Aug 2024 15:25:22 -0400
Message-ID: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0078.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4cbe77-bf89-4244-6fc2-08dcc2e03cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NHsblPQOPd0+Zs6b20HkfT30J0G2GvCclc6qSxV3T7GkJcjmPpYkDGsn4j2t?=
 =?us-ascii?Q?vH+2XjOtV6EGezPvZoYZruhMXkX7KXX8zRPFqjKySRaNzos/DyBJATYHW+h5?=
 =?us-ascii?Q?UgoxD6Bz/ny3Z/SJrlX32kxLK3h5bvP+5R8DUg3kercEmKUqIbQf6NzUoHQa?=
 =?us-ascii?Q?hFS6WRDpiedOw8OAc5AQuFuFveN7XmVlkmDhF49L6gapZDkjgJZkUoShV22k?=
 =?us-ascii?Q?86hdaymvmkJ4tJsq/k6LK3cP+JzN04nGIJNS0gN8KKO9b2BEcqfX/V61AL/i?=
 =?us-ascii?Q?Bxbi4bnQtDQbH8rSOb46X8/bu7O02Pq80olIRydkX4vUoXq48o3pTwOZz/Kc?=
 =?us-ascii?Q?bLpbUyg/+Sld9ifJWiLsXmgBYkr+MPqC2Wzg5DCYnDl/dmCbpb6yUhobVhpc?=
 =?us-ascii?Q?Fv9S3r57+KhPVvFeXcf8yej6wutX/ua1dCOE64i+MAlvDta/0XnkdSi8thh2?=
 =?us-ascii?Q?0teXMdzLgrwEGqgu6/pHAxHQBFxoTkqL8/Fae6NxZ+e56mXhyTXchPM46iDk?=
 =?us-ascii?Q?wajTlBcP2C/K5w30HmVgnhfLP4vmBSLwNV8fy/ausl18vBOVoP+9dLoCgvtE?=
 =?us-ascii?Q?X4yPFHMjfuaUQXOM2gngrvrTTg8tQuiR9dxm8W1NgI/W5jXUuilVT0iwsz9W?=
 =?us-ascii?Q?q6Nm26MpRz/5v8YkrdJbDZ9It53s7tIXK0C1Ab5RwncfgdgLkP3Qul4plLuu?=
 =?us-ascii?Q?upYox4bQIaPsRCxDY9nxYwtp1QETb3G3LflQYG5EoXJ8dxcIQ8u8v7wqZCO/?=
 =?us-ascii?Q?SPcAaagmohrXhyG7diw01TVuGIAcQ1LkYq+tY2hsKrxfklOYT2iqg3FArfV/?=
 =?us-ascii?Q?elvPkmfXh2LG8+dC0k2VlVElPYd4WQUlCAq/nZk04CpABfKrkRGBfgaBfOMe?=
 =?us-ascii?Q?CYROzFxR9c9KR0ohGol7MeiVfeFc29/B22eRxP9qHdS6xclIryNZsVGCbtw7?=
 =?us-ascii?Q?3i/087zHqJzHe59R+1PNCFanP0Onjmy0xQYIrksH9IMlWfadvillZMhLgi01?=
 =?us-ascii?Q?4EU0zxxArw+pXMApTSMusMyTH9qnu7nAtkqqzyfubPGT9+i+lQXDzlRrdi1k?=
 =?us-ascii?Q?zwlJRijWNbvAcNOneuLHJodeisw66rQ+gds9rnXt6sWbWywS0KV8KLYOpOVx?=
 =?us-ascii?Q?NL434lN3SW1oqv6i14YZhiN/ywFKDXShvgw8WTTnpbOFdZt8OUGs07Ju0J2Y?=
 =?us-ascii?Q?oCTWX+u8Y+C2ja4TXFsER8MqWvPRiPajvXFvo192+elqckfs1cOlv2MnzMGI?=
 =?us-ascii?Q?3bpFd/qgVuwhSb/a84OyxSTbuGLpps80xBfHcGADs0k5nYqskQsmcv1mIORz?=
 =?us-ascii?Q?yiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HRpWWrG3QpW1t0MipP8KOMpTcNJmeLDm1t+BLYr30JjpY4SEy5CuuGwE+B5r?=
 =?us-ascii?Q?+2CSJwzwq0sIa2TS4G7NQeEv2iBDZ8RdzaZq4P5DPOda4qyEjJhzo1XKGUXu?=
 =?us-ascii?Q?rZXtaCgyrJfOmWdvih7XVz4VpN3IHJZJHTL1fjKB34tSUSUffFRMh++SgyTX?=
 =?us-ascii?Q?ztp5tLBJP1Vn0LPLDWfAlqnh6U0v9yl0tYwAH6QdA3rP6pPOV37ReNy+BQ75?=
 =?us-ascii?Q?6DgPi0hIPmKL5Uv5WQTLlAHJ+qSLmtVmLfjB8KeXJKjs2EdMkvb2HGWAi4o1?=
 =?us-ascii?Q?S2H4Aw3byQREt+CYrUU4OvdWYGio3kw3DMMML2DnQACQiuR3vwz7lb5hpIjM?=
 =?us-ascii?Q?RUfQc2vFvKUG0nKYspA6spugE02f99K42hmLv6pIRHeObqbGv7Ilk8cbBAUO?=
 =?us-ascii?Q?LnXG0I91TuIkxxQ/TJ5vkg+E2T9LCZDu179tm4saakRek7+In7cqq1ZClUy7?=
 =?us-ascii?Q?HEuuQ6WOYkvoAjNmgvqdshVoeQLg3apsqYWCVujyDaCbzDY7jFeh5kiRB99n?=
 =?us-ascii?Q?p+/IV3XiKqLzmNsJlI2fRjPldFtLyWyNGoz8w/Lw1fFvt7nhtiVNh9EqIKND?=
 =?us-ascii?Q?RnYchuNB9w8BQeYIgGek82wTvPWjCScU9hCTSc7eoXfQgJH+osR0fgj1N6el?=
 =?us-ascii?Q?Xe8zha41SDbv8VTxmvjKnczXPzHZRbTIVDZT0uynN8q5V8n2uuGG7Rq2BWH8?=
 =?us-ascii?Q?ixElW0q2ddUKFH//GZCG2Xl9ikIa6cMZONTDkhSj/x5CSU9jlLb6eftvzUim?=
 =?us-ascii?Q?mrv7lrEZ4EX5RfiGhN6+BSjOkOo5Q5BkZC4irlpC7XB1oimaYkUola25fxE4?=
 =?us-ascii?Q?O/e9099+AxfkGKlfJI7UKEL8q6llJYMMJhGz2mkod84Sb5MugH3wgtH/fPPg?=
 =?us-ascii?Q?WIi9zT2TP5Nv+mtjunivbfuLo2ZYIGELdxM4dJiq0oAPAi8bmZOh3r4TEJ36?=
 =?us-ascii?Q?MyUboSpZDhInfHUig9VjRpUYsVjy/TpPFvscLB1nBNixAHCt1ON1JCrV3NfA?=
 =?us-ascii?Q?OSE9W7tD0Iu/cNUK1x5ApHYRi0qVHQavhNJjIUtY0ZGkAajKOIj1wVzAC/N9?=
 =?us-ascii?Q?Xt2zNqu/UO/fUNDVC76XDF2TfSdJOHh4t4X84cpr2DDzyITjGnmxptqCGnkQ?=
 =?us-ascii?Q?lsxVP39H0CpXKKj9GqXTYsak74z9z+uDBmMydYoCkSyaZA3ryglsCLnF8xsI?=
 =?us-ascii?Q?yNOCazP/eBVKa6Lru63ijcEvLxoHY19oOnCwu9rfi7szvfFvvOkAk7Et+dWA?=
 =?us-ascii?Q?aDX/L8OT6fQNJUIaqifEIUsxK3UNj1MnVyvqZzvrRKodTSR13Dhp7p7N9i7s?=
 =?us-ascii?Q?0qCbrzjG+C39QeNHDVmNX23atsGzkMDkbDn7ys/imZ4F4+Sf8taHCC6r8+Qk?=
 =?us-ascii?Q?eNf8J3gzPwGErcupIAkf+8LbiH9fnJh7nLwNraLTnNJePO9AJTwMSYRxpz+H?=
 =?us-ascii?Q?ukDEW5B+D4UUxuSE5rIiOE7XDmea2pjaPFt1MUQpVTD2ufhti1g68PPpO5sO?=
 =?us-ascii?Q?Ga9cuF3/DsCvEbfDuq///2kO2o+gzCM54/J2wkevmg1IUYWLIvOSh/E7xHXF?=
 =?us-ascii?Q?1a3snB3+Lh3zL7TpMY9R9oe+OjiZRoV1kakdHSPb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kfkqksVI65SjmSxuOdoSyw6RTYurLWQbLBQMHL5lRzc3c4BTQsgill1pieAbvMbnH6spG/cNUer5P5DdpRbR1uNIJsIItdkQ4rDOEUxOFk4PjNzLRxDMXdgquuOJ/p+EWMKKQY5buwQXVrw38h2+3sHfnZWXuh9gYmcDoizKWfgOlgGzFA56JgnsCrlf80h6ivscegznKOOxGGOW7NZhTGW3ENshA9ARIZichryPEHUL+wruutyoZmmN/d9Xau2zNDOIfEXtyfcEcJDDT5bB+3txnqmFZawuQ3WlI9lLXyzUn/HUEFuaFFV6CuUBv3Gfxqzu9X+Wk9QAAg7YzfAsLdW/DhqagojB10mz9dBqcrPQ0IDtLc/NZx13dmbwWzrYuV8xCTym+c2kL10RGO7wDCtk/8jOJEJRym1tYQMugg3B/8F1gwN038WI47fwQjw7yjicyfP2XM2YV1MMNC+30VO51t6RlqNd/yfJncHqh4EnEBFqCc/EJB7dSfaPCywbBraWD5bvnFk3BTt9GUK73V0gmCXIsOix3g9Bx4HfuxKu90Ypi5PbC6d94E7yDyffH3E2EY1KUmCZposjYZTwh4G1D/bRuSTXLuP78N8oX0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4cbe77-bf89-4244-6fc2-08dcc2e03cd1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:25:57.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prZ3sub5PIYAsRpI69eqKmSzO1raFe/pXFV8iQEKLRoJaQPVz+WZnlNbvt8VhTVTGaO4wtF9D+SE2keeuGRoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: 9MaY4qcxEPmL5xGvaJNS9ykAoLDUN8fU
X-Proofpoint-GUID: 9MaY4qcxEPmL5xGvaJNS9ykAoLDUN8fU

It is now possible to walk the vma tree using the rcu read locks and is
beneficial to do so to reduce lock contention.  Doing so while a
MAP_FIXED mapping is executing means that a reader may see a gap in the
vma tree that should never logically exist - and does not when using the
mmap lock in read mode.  The temporal gap exists because mmap_region()
calls munmap() prior to installing the new mapping.

This patch set stops rcu readers from seeing the temporal gap by
splitting up the munmap() function into two parts.  The first part
prepares the vma tree for modifications by doing the necessary splits
and tracks the vmas marked for removal in a side tree.  The second part
completes the munmapping of the vmas after the vma tree has been
overwritten (either by a MAP_FIXED replacement vma or by a NULL in the
munmap() case).

Please note that rcu walkers will still be able to see a temporary state
of split vmas that may be in the process of being removed, but the
temporal gap will not be exposed.  vma_start_write() are called on both
parts of the split vma, so this state is detectable.

If existing vmas have a vm_ops->close(), then they will be called prior
to mapping the new vmas (and ptes are cleared out).  Without calling
->close(), hugetlbfs tests fail (hugemmap06 specifically) due to
resources still being marked as 'busy'.  Unfortunately, calling the
corresponding ->open() may not restore the state of the vmas, so it is
safer to keep the existing failure scenario where a gap is inserted and
never replaced.  The failure scenario is in its own patch (0015) for
traceability.

RFC: https://lore.kernel.org/linux-mm/20240531163217.1584450-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/linux-mm/20240611180200.711239-1-Liam.Howlett@oracle.com/
v2: https://lore.kernel.org/all/20240625191145.3382793-1-Liam.Howlett@oracle.com/
v3: https://lore.kernel.org/linux-mm/20240704182718.2653918-1-Liam.Howlett@oracle.com/
v4: https://lore.kernel.org/linux-mm/20240710192250.4114783-1-Liam.Howlett@oracle.com/
v5: https://lore.kernel.org/linux-mm/20240717200709.1552558-1-Liam.Howlett@oracle.com/
v6: https://lore.kernel.org/all/20240820235730.2852400-1-Liam.Howlett@oracle.com/

Changes since v6:
 - Added ack by Paul Moore
 - Added some more SoB from Lorenzo
 - Fixed some minor comment language
 - Dropped extern from header
 - Removed constant from argument list of vms_clean_up_area()
 - Added VM_WARN_ON() to stat counting
 - Removed duplicate counting of VM_LOCKED vmas
 - Renamed abort_munmap_vmas() to reattach_vmas() when other code is
   removed
 - Added description to vms_abort_munmap_vmas()
 - Removed mm pointer from vma_munmap_struct
 - Added last patch to make vma_munmap_struct 2 cachelines

Liam R. Howlett (21):
  mm/vma: Correctly position vma_iterator in __split_vma()
  mm/vma: Introduce abort_munmap_vmas()
  mm/vma: Introduce vmi_complete_munmap_vmas()
  mm/vma: Extract the gathering of vmas from do_vmi_align_munmap()
  mm/vma: Introduce vma_munmap_struct for use in munmap operations
  mm/vma: Change munmap to use vma_munmap_struct() for accounting and
    surrounding vmas
  mm/vma: Extract validate_mm() from vma_complete()
  mm/vma: Inline munmap operation in mmap_region()
  mm/vma: Expand mmap_region() munmap call
  mm/vma: Support vma == NULL in init_vma_munmap()
  mm/mmap: Reposition vma iterator in mmap_region()
  mm/vma: Track start and end for munmap in vma_munmap_struct
  mm: Clean up unmap_region() argument list
  mm/mmap: Avoid zeroing vma tree in mmap_region()
  mm: Change failure of MAP_FIXED to restoring the gap on failure
  mm/mmap: Use PHYS_PFN in mmap_region()
  mm/mmap: Use vms accounted pages in mmap_region()
  ipc/shm, mm: Drop do_vma_munmap()
  mm: Move may_expand_vm() check in mmap_region()
  mm/vma: Drop incorrect comment from vms_gather_munmap_vmas()
  mm/vma.h: Optimise vma_munmap_struct

 include/linux/mm.h |   6 +-
 ipc/shm.c          |   8 +-
 mm/mmap.c          | 138 +++++++++---------
 mm/vma.c           | 357 +++++++++++++++++++++++++++------------------
 mm/vma.h           | 164 ++++++++++++++++++---
 5 files changed, 428 insertions(+), 245 deletions(-)

-- 
2.43.0


