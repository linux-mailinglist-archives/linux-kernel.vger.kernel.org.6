Return-Path: <linux-kernel+bounces-386888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019D9B491A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3347F1C22459
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AB420650E;
	Tue, 29 Oct 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y260Rsa5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uBZOTAMP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232C205ADB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203644; cv=fail; b=egPo/3d7HwKXzwZFPa+EEM9diMRnstZdyKzDqDRXTEkiRLmh2i1PM/pKz08LeWXyGNDDYE9qKf9gH5SpPEpA0J9ISQbkSRuM0OeP6nqXBHqxSK9+3np/kPLONOtvLqHybyJ25COtXV17im1e5dCsEuhA+/gKw2fOTZudR96Iae4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203644; c=relaxed/simple;
	bh=5ofLjwPfKzJkiEzONsNAQCC7Wd5QhEuybmbbedtXp08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F1rGZCxXXr0jQh6PJS0TgGmOR/OQeKM7Lgd9d7F+4f3CNPioGTeDYTd59kGhuWu5ewINuSyBWVzDGhaspB/nOP08ygbVNLVln+jW/9XU/wU0c5ojz4rNgAX5pkb/Tmo9C8nCTd6yrb3GnwjTddO6/uccyCTyklUYHmT6mwQHnU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y260Rsa5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uBZOTAMP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T7txRs015642;
	Tue, 29 Oct 2024 12:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Fym9M47Lpl9ykJG73b
	avfRvBteJ3BQO/TYXEh8HHcls=; b=Y260Rsa5MBRTXhT/ntCcUo4v4aGVB7wwHB
	vlM8teq5rhRXszF4DnssGT86YuUCo/aQmAAMjaNKqkYCdQdVhY9Qdo9N9sxMWz4H
	ZPwIXBm29VIgk4GTtgb2wUwncoR68Fmi0wYKrC7tg7+GoaJJW98mKCgb4INZywk3
	PFSkCDm8COSk2QLEQc6+41o4NRWIu8fY7ssdrPtdYBDEWFo6hCYiACpgLLu293ey
	LpSPcbSFEuep2vc0sN0NKz9KzaebgUrjQV08/bQWeHfTeAF2+NOpp58t/1kvEAZ6
	1pQhflGprSdjwefiEXhfHsRWpR7tnaJFSDTyNe2OEkXEPby6S/tg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1w6h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:07:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TC0UIQ004790;
	Tue, 29 Oct 2024 12:07:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2u5q8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMXs+AiOiaplcIGA4C9ijV2ZesSeZrP+K1LgT4aqhQfGMBWMjCtoSWIrmNdWCIRPBev1VOh1vfB4k2Mo61KA+OoA57VJCsOTcf7dQvvlL1fQfMZ3VaBFr9NBH7FrmLof6b3RGOEE3U5yBY0qZk3ql5K1vhAVI8ztB7DrDnwM0YW+v/UndrbgL+Tm6IyjcybycinK88096Ogy0uv8oOyvB6eqq8b5/1ks/i4lrnqOqBSC1+7nN0Qfnkr4cHhJ0ccXUHqXbH3ARsgTOjS6oWPq3Qc2Y4xgHAAiEKp5q3LZ/ndaPV8ER6q3Hr/3RxhNnbv8gVTtyCL7ixr5G4U4tveAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fym9M47Lpl9ykJG73bavfRvBteJ3BQO/TYXEh8HHcls=;
 b=hKgZaKOmTwKQVjyE6qSYDIxa4s9jaTOrgyNIn1L5aWBQvLA9ctgKi+gKTSBZEMChDTugqfUEkKTkHgv6r4Hz9PqBQk/EyBt4UYbdCHby702WrQRaFb2tW4TF8I0+lJdfe4ruIntErFmr/txTJLgf5tprbQFT4h04z06d0TmpAFYuwLHPh6Wem6WOroX6BTznYNuwO2qh0G3OUAJZVmNRwxlZneyMFGZcn6N3b9wh79GZI+xfkVG6wshGAhkHKluApX0z111Q1Uib5ysc0KB/XBiVuelUtT/X5KSrDhCw37ou6Ssi6WAc/jaeHZklfR9LIeuhgpBPlB+TSiDYqMhgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fym9M47Lpl9ykJG73bavfRvBteJ3BQO/TYXEh8HHcls=;
 b=uBZOTAMPaqfpSv/HfrWDVUZ11eodESxweRarLlLfbFCnwREg7m063qcKgSXIJRKAXvqZAOIQxWXg0Y2tpElw0FhRQnBve2FM0HAuKrKw+NyLyzzcsldWM4EB50U1b0pUJfOTinUTN4Ix5D40kP2vCgB0dmPGCVvaseubt1qeuyE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BY5PR10MB4177.namprd10.prod.outlook.com (2603:10b6:a03:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 12:07:05 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 12:07:05 +0000
Date: Tue, 29 Oct 2024 12:07:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        syzbot <syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in zap_huge_pmd
Message-ID: <3b06d23d-de9e-471f-ab99-54c96cb077bd@lucifer.local>
References: <67205708.050a0220.11b624.04bc.GAE@google.com>
 <ri2667onovzkphvyxqnxe724ymxqs52pkzpdesina35v55ccnr@4kghwz6eevom>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ri2667onovzkphvyxqnxe724ymxqs52pkzpdesina35v55ccnr@4kghwz6eevom>
X-ClientProxiedBy: LO4P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BY5PR10MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d39278-4d71-4eaf-8736-08dcf8123448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z+LgDcHR1hFAZUokVPgPzYgIHm7BdwEZ+7D5Wii9/6r1HjMDwVyo3q+wu9Ts?=
 =?us-ascii?Q?72LxA/6oVAFv/iJTy7EHAz5+R+jitBlsoECydxJL+tiQXbdxpFVkejAIig1G?=
 =?us-ascii?Q?Nxr3VflQyIKtUQPbeYGTPE4mEBOz0ilYH8uEs9eu1lqbfTpue0OW251byBQM?=
 =?us-ascii?Q?ZQFdmuG1Zj3r920DrygSa/SQMwnLE6xtw4fU9WkdrX4az3TeKpQ9DKIMI6F1?=
 =?us-ascii?Q?CaKUdo22Bd7ps2+txhwoWa8XSQ3nRPG8WFFzQ2O2l2yBSfFzTgWalnGGWm4F?=
 =?us-ascii?Q?X4cu/e0MmL3FKUqIAv+nE77RJZ6xgRotLCb1rb+s6tLgvQh4ebms5J0CT20R?=
 =?us-ascii?Q?xu8vxPzSKp8IH1yXCYBqKOtTOpLQWGCSHMYPW/rOH+CrvprYJVNShXAZHrQz?=
 =?us-ascii?Q?MwELU84BW/uMabOw3bitPUdlf8E1AWVL7+VidKiTlPDiblRUnNlXl9Jl6YtQ?=
 =?us-ascii?Q?moqKOre40hfmfgnWkYVOSfJsPENJm9nUCNkHPY20A46PEbgZk1Elgufj/70j?=
 =?us-ascii?Q?tMg5k9KKl0dm2XLml4qsSHTLJb5zAu6OFxC+yywVnvfRyo5gbm4qBLsA586N?=
 =?us-ascii?Q?WQZ04blzn+wHd29mXU6mdYQnoc7XddPWHfATabNI/mCAd1zJR0CoAU3tlpkj?=
 =?us-ascii?Q?bJhZh7ituA9iekherVz427jQJwvBERMQ1ySAjHozlqqlrXW8QId0ahKre3Lu?=
 =?us-ascii?Q?eQui9A+gPVI8vsXa+IY3q5Fe/pgAI29HVv0SA9cj0fN9ojZ2kMalgOhjAB35?=
 =?us-ascii?Q?hZcwnWbvpodMNwbG1qpNVNYYeAkQZ0EhZ3dPvaFEeAmufTBOyiDwjmm5Xmfj?=
 =?us-ascii?Q?OaXyqWuRA/UsgymgZf3/yc+PL2UBCZw2EYRfOnjGPC5lFYZwy/CKRXpw+WUG?=
 =?us-ascii?Q?j1LJcXMeCbMrgDW2T+uWZy9pCUzuNLtYBH40MbzF9Xq0ZZyrA1EF0E6iIVtu?=
 =?us-ascii?Q?zTYTHZx91G4FROPIvwXMR5pXd4ITRAomtLfNrsr9Ims2hE/zFDwBm8vf2Doa?=
 =?us-ascii?Q?nhKkYnqepHy24CijLYPUXvf84jiYJUVsBHXmtFmkznH6WbGatWeNXwDeo1is?=
 =?us-ascii?Q?/SqZmE+s+2HfeSomh/H63K+HDquhcPtKiQDKTGa7awFye4qjDWD9ofmRnFmF?=
 =?us-ascii?Q?rwKt+OwhKu+J0DgRTnMwu+YRTgbBtWRXPbgANkBTy+2zSwVGjbUUUnuxNura?=
 =?us-ascii?Q?RIRWIZ5kFLfALKCmwh4FC905oEfxCutJOJB0i4/WIqwh4qIFrcciJ1zQMnBn?=
 =?us-ascii?Q?XM6nYoNIbkZhQuZqRG82qgVyWZwaQCL14E4CGt5GVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2HJr6IANVenqmg+I13nEmTOSyxlZ4Vx2KsbPB9qg35VYUuxTLACqy0czmTBv?=
 =?us-ascii?Q?r5XEU/VSygzIHqAOOKdVNo45J9mlQY/NvWJUh1bSdIMjIRx6aLO4JNnJvgYm?=
 =?us-ascii?Q?hM8f40E7WFQo6zYjxViJW+nwjYpT/x4JVYA1iw14aEmmMl0btGNTdj3e24P/?=
 =?us-ascii?Q?CFQ4knIW5Kfw2Y4HQ7L57AcDL5cePIcIEb+2FCjokvwajZb4hQzolO7j/kjV?=
 =?us-ascii?Q?zgPpsKP8BYlo7aJH/u6cGQhNYUnjbpxOSTUvTBP9w+Dq5qGj5i68wR9Xwwxb?=
 =?us-ascii?Q?9ee1L2xvlbMJ8WHUKopBZc8jORTql6rCZKiHPucPmO3/kja16M2ty8z0AI3k?=
 =?us-ascii?Q?hugwBiG4tZfDTKQKvfLl80Wj6IozQjeaaklY5kaxfpAh3eLwPu5bCLb6iiDy?=
 =?us-ascii?Q?n0tluYprdwdvglgQpEfVOXEjxQuQO5Vbbj0TPU9Uxv9RuyiVusKph+0Vy3YT?=
 =?us-ascii?Q?eIbeMR+y160jYsUdtylPORveG3GEMr+XS24mRMNX2p4U14lcrHtIrxX8zH7c?=
 =?us-ascii?Q?oV5WHBT13CHM4a6yJAqM6cNKx2kkJxLO4s1qESOsfiK+w8qPfVGJg0XaoK/e?=
 =?us-ascii?Q?lbgwWTarNlDxbY76RdYO1SxNfXNUD9xOwd/zw9DcKB3wL2M9QYNKtaoOriqt?=
 =?us-ascii?Q?1+OpQELY4bSyxXmIfrj+WXr6lYcu/mePRHSe7wJUSrW0ueVwYzxEsxET8dcV?=
 =?us-ascii?Q?06vladDPfoFUjpLt2HDx6m/UVDeYp8InRd3eZISPw3I4+YRQnNfqRkSoDFtK?=
 =?us-ascii?Q?6Qs9rgsE2OHBKcowuuDeZCFIgyC9f2/60T8Gm3uolRwam/1wFL1k+U2QtRPk?=
 =?us-ascii?Q?OH7K7Cp/Ivliz5dCMG1a1ouvZHR2E1anfQiqEGt3w9Mo8oTC3Sj4aRIFi/5i?=
 =?us-ascii?Q?7WFtqhULOz0T0RSZDHXFbIM81+jdprQwDYqCba4/fETrRrFHPOjj43PTapMn?=
 =?us-ascii?Q?KvUnlxfdoSe569pcQYN3v5AtLirT7OxS+K3m0tnA8P6f5s2/IVWiMifJyw9l?=
 =?us-ascii?Q?LApTw0IuLwWkULEM3mD8+IWwSHmEhO/l+bLU7MAh5ScXAtQ+2Bgh7HiVTXIW?=
 =?us-ascii?Q?I+ac7enN85f3DfBbYvR9u8O0Sx/M68tl/1EBUWwockgHHlibhLKfGDWYAEgI?=
 =?us-ascii?Q?ynmnVt392QR2cqoDZsUndGwjXrvnIvR0G4eYYSbD2/Y3eVMy4NWOOJ1Jdr4W?=
 =?us-ascii?Q?koQ0E3LqLG6Sc2CRzI+Qh1q1nqMSd1EZQugN8hsWEsLFzgg9RmQYt//o0bbK?=
 =?us-ascii?Q?VRsnklkwcAfRTl/AZvwtnJLQ6H840YrHnOuBvj705YfwXhePGykmBHtrwNCs?=
 =?us-ascii?Q?m+NUKGYTCoH3TRXDZjTT95xV6zkH8JhSerDNwv+4t4Gczp9+Ixdn0NUbBfV+?=
 =?us-ascii?Q?7YdtxYYcIDe/bwvB5UWxbbq7bcDiRBqwOG3vcXUSpw6XhYFS9mRZgiDvQMiv?=
 =?us-ascii?Q?K1XP0pEQHFEQ9OMZ9uWK8UZC85U6JRwGs3A6QT8drJPEjoBzcTaQvqHF+HGB?=
 =?us-ascii?Q?oyaQ3Ts+mGfZZSfW++ILR0piV6eQSvBCFyw/HDNCi70oclWJsPDusi0R3etn?=
 =?us-ascii?Q?mlZFZ9Yh+BUJyiKHR3ZHbDiMNJMeFjfNKdoNdx2EnI/AYfFC8IndVgvHJYKP?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R4cIrRdrHzgTGvObjjIAm3c4jJutxGr9q9UWZa5S4z3Ylu55HmUZusM3e+oBWkoxSq2NGRNcf0904FYZE7LMczynj/APnIiLOSxTXacLrynD/7JP6XILhFlJKONlB5qKoWwrwTGCl4FHqTiTQC8pilTdcVunmHMCsUpkflLhGdAefOlhfPfU5BsjGm+uCMGkPd0d7TS/OKGmF93XHEqPG88AfEMWfQ0R1pSVCJ4Rw/piL2OgIAevNAkEGPZbQLzcO0mGb8fyu3MfhIp6qIAYTT526b5x6o2CkL5KqwElb/9D3Qx/vANfeL4qbDJdalsGdF5+HPuMTTieYkO11AKlgyMJuK61fYw/gubEiycQ5PUk+W9aVJfBYL4NmVshbNnTdn5LQtAi5ZtRWi3z1Fjqxwm8IvXcPst60v3mDqPM2YJu5zidb1nTfqOXvLRs61DD2hN+3fg0vnAu48gb25ilgcZwgIaRk93UsxbiCY9uLEUfA8ZeQFbDyg4RmzyLbbfCzHP5IUEh4EMEdJUN4xEMXOgGSQLxzoD5c/ToAYoVtlBY7X8EQmRKYEZBWUntAOi92j28y9cP2QHe4cPwMaOSuQ822RPzFjUlxbOyjCkWMDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d39278-4d71-4eaf-8736-08dcf8123448
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 12:07:05.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tnY3ury/Ve/aQHmi33kwrhTJz/XBqBhueM7FhScq2OG8nxt5kllgmIXkZe0nQH9KNwVB5LhgoSPMmqdCo2o8cQxCdAa9fqhlM3OeCez4nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_06,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290093
X-Proofpoint-GUID: EAW3-BpKoyDDQjwZcungphkdHaaHiqLE
X-Proofpoint-ORIG-GUID: EAW3-BpKoyDDQjwZcungphkdHaaHiqLE

On Tue, Oct 29, 2024 at 01:44:47PM +0200, Kirill A. Shutemov wrote:
> On Mon, Oct 28, 2024 at 08:31:20PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    4e46774408d9 Merge tag 'for-6.12-rc4-tag' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10fb2ebb980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4b5c704012892c4d22fd
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f730e7980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177eae40580000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4e467744.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/058a92aaf61a/vmlinux-4e467744.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/0b79757fbe5e/bzImage-4e467744.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com
> >
> > R10: 000000000401d031 R11: 0000000000000246 R12: 0000000000000004
> > R13: 00007f33ed7673fc R14: 00007f33ed737334 R15: 00007f33ed7673e4
> >  </TASK>
> > ------------[ cut here ]------------
> > kernel BUG at mm/huge_memory.c:2085!
> > Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > CPU: 0 UID: 0 PID: 5095 Comm: syz-executor380 Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:zap_huge_pmd+0x953/0xc40 mm/huge_memory.c:2085
>
> I believe it is bug in mmap_region() around handling
> vms_gather_munmap_vmas() and vms_complete_munmap_vmas().
>
> What reproduces does is:
>
> 1. Creating hugetlb mapping
> 2. Setting up UFFD on it
> 3. Creating a new that partially overlaps with mapping created on step 1
>
> On step 3 an error is injected which makes vma_iter_prealloc() fail and
> unmap_region() is called in error path.
>
> The unmap_region() is called with the newly created as an argument, but
> page tables still contain entries from hugetlb mapping that was never
> fully unmapped because vms_complete_munmap_vmas() has not called yet.
>
> Since the new VMA is not hugetlb, unmapping code takes THP codepath and
> calls zap_huge_pmd(). zap_huge_pmd() sees PTE marker swap entry installed
> by hugetlb_mfill_atomic_pte() and gets confused.
>
> I don't understand vms_gather/complete_munmap_vmas() code well enough.
> I am not sure what the right fix would be.
> Maybe call vms_complete_munmap_vmas() earlier?

We just changed around how this stuff aborts in a hotfix series that should
avoid this, actually.

Unfortunately I don't have the netlink setup syzbot has locally so not sure
how reliably i can repro.

I guess I'll try to tell the bot to try a commit that should work (one that
I'm about to respin, unfortunate timing here...)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

