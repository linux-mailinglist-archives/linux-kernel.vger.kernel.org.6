Return-Path: <linux-kernel+bounces-449755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED929F55BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC47170461
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4CA1F706E;
	Tue, 17 Dec 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kO8xjiki"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED53398A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459104; cv=fail; b=YiVZD4wsjm2gDp3XJywvDw86eluJDUG9wSV4uW2/Lk1LXQ2T2afhkYIQYO9prDsZe1+3ISuP04ZH9U3nFIRy1/HlaBVpId+vSyorv7CyWwxGHLsCUl27qjleA9OyjfvTXOKj7Mp2Kq0zA0sqCf441qU7WntN28fhLelbahdlYR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459104; c=relaxed/simple;
	bh=GiwJ+UpmnEMfZUZ8GaXD09XQe4IAM+cuoHZvUCF0aWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FwkrjGgJ1e4mbKeIb9AX+G8ALfDBK/gAqcGXIJjtFP+ZOqq6D+CYtl8dGapyJPYUA28tfpHJFBwTchYU5V2FsJtpIWrhBs1hBKhoJjuCKeIMB5N5DAuOvX9jahlKgX2AJIduGmw6O4CVQ4W8Tex6isoMH4oZ1dhPZKAJ1uJm/CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kO8xjiki; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lR6n0uU7BUwzgcNUdJ3I0H3k8H9RsPzPqxOxJX70gpyngK1rcHJSzjznsUC55mtu42nLJBNqpAUt8cnJJk30pQL48y5OemIHpRsFhyJP4qy92YkTRxzwJKRyNsMCDf7DZ6MX0OXsNS1Z2k6+pPTq5UO1ipDyjIz4ePJUVx2rJAt+NdmNjU09YZSyGWthKvYIHn5o7D1cCKrvGQd1fNX3SUf256sJU9OZxqFpYTRNlL/tRTIZkM1tND+RRDoiJeeY0TqE4j6faVypRX/+66w/s70JfIjXEtmObXUVQV1rC6kwsoK2lK3mg/0cjBnFuPLuE80lA/0ZmPwQIVzQxg1AzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt2xgIHL/EE1chHTp11R0qM5zenjKp2wLBuCnVnzMnE=;
 b=rK4kgEHpwfXqSWi2EjNxJd5MRiXWFyInV+fNjEuh6BK43A7R4kwjC0nY7erqhKbnm2UaBI4UJPBK3rQehMGRFfFBVw1AUUpolbq+MyJLw4Ii8XgE22oYzsXPL7QqhICjfWKS+Logq3j3cHcQnSoYGTsoOkcMO3i4QDPlwCshgk466gtmrXtLBJbleNZWaTXDUGX05Wsr4ZykbuzwcG46lgTFoHxzyVcDIrjTC90peZ+/8yMUVdcM1+cHw1DxNPMOX48uzjZ39EffdUNYL6clLR2CJD9JUz//ySwObiHiMlJjaGoW3r9el//KO6lxgtPFtpQLUaw7pB9a3B4M+hPQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt2xgIHL/EE1chHTp11R0qM5zenjKp2wLBuCnVnzMnE=;
 b=kO8xjikiGzhzCPa/ZPQ+jutLzbvi3owLLBNnNVXToNl4lKm/g/EOxv3LIB8Yfb12Stn40wEZEPKzPJlqGgSGRcerY38pZpXfqYIpUZq+hpXGP26267rgn53WKcmEg1BL7/5nLfGsh0R8NoIzvwJ8yH1vLlqLOmMUhcqMgJL7rzuJVoAf/wmRTCfYYZ+e2RK+cE+J3PCEqhcfmh4SusgHKvVdmDzfzFYWeTIcjWKde5ibey6393n/LvOM5UjgulJAxKFHLdvnDpjKrvetQuJQw5aAzx+9eA1QdVAXgyavT1O9UHMBL8LTKYhVytxU1sD730DF9c5FxS6YD4BrEvfVWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 18:11:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 18:11:39 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 david@redhat.com, kirill.shutemov@linux.intel.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com,
 apopple@nvidia.com, dave.hansen@linux.intel.com, will@kernel.org,
 baohua@kernel.org, jack@suse.cz, srivatsa@csail.mit.edu,
 haowenchao22@gmail.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/12] khugepaged: Rename hpage_collapse_scan_pmd() ->
 ptes()
Date: Tue, 17 Dec 2024 13:11:36 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <35E34233-3435-4873-A82C-A1DFBD0AFC55@nvidia.com>
In-Reply-To: <0a33f5c1-c974-4d4a-94dd-6741399e186e@arm.com>
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-2-dev.jain@arm.com>
 <Z2D7pi1Gl4Bq-ln2@casper.infradead.org>
 <0a33f5c1-c974-4d4a-94dd-6741399e186e@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:208:32e::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 3201b4bf-7a10-4def-930a-08dd1ec640a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vDmx2zNRZrmrx4Gp/I+XufHn/H0xbbwZm5KvghvehBkjhYV+KSS1XId+x0v2?=
 =?us-ascii?Q?C89jMZRAB/pDDWOCxxNNCt2EOUW6zNRzIzC887lVPzP7eAGKSXQOQQdWpcBF?=
 =?us-ascii?Q?Jt3abRBnRkAgXLgidgSN9SLt6oCmpGOGX6hhZ82YJQ5bUHzNIKTfgN5GLjZL?=
 =?us-ascii?Q?8mjgKilwZow7fVRi6Jld5d3Ymvu2GKBHCOx14O42aoq0z2MDqPKI+ZnySUNp?=
 =?us-ascii?Q?LDsftgZFwJ3e4gWckxW2yv2Rd2F2Fa3jF9kIL7lTdlSMc26Js1NDCnAv7+BY?=
 =?us-ascii?Q?g/cTGBbmfAzUf+PHXyrPhXdCOQOoxhbZmOaPIx5QzcyIBvDf2Lpp06DUOtuN?=
 =?us-ascii?Q?xa05GQ0cKwprwxNk7dY+2uo/8n6lnDW+qJLrFv+aKBMfuOrq6hrTbO6wMVyC?=
 =?us-ascii?Q?vZMokGjlYdIxa3YgfIhYFu9axtS41fPTh1ZVjXjacvcYXpNtScpV3p1I4SC0?=
 =?us-ascii?Q?ixw1Q6upYg0uldax7AGi7u59yjJRdNruN6Chj1521HF/a8yN6TzM8xkWHxBF?=
 =?us-ascii?Q?/LWqPOkA3gd3uV2pvm9KywJq17te9gAXpfvAB1PJ8rkfGr3SVu1C0/S7Huqo?=
 =?us-ascii?Q?UpWtpUMvOf4BnmnonJhrS3cBKPGPX2ndoVAFDze6fviinfFjqoZRWgRoYEHp?=
 =?us-ascii?Q?MVNOFWtFEntaJPnmG/lqPCG59VAhC4hLvnkFfc8vIY1ywnkBFafDFyWzgv1P?=
 =?us-ascii?Q?fPJfvx9Q6IC5l20ugreILsn9NV7T8G1q67FngjaUIRTvc2u+6pfMRq+QsTqq?=
 =?us-ascii?Q?uxPbkVNmtfQI1+w7SjLIYRKHf4RCK/r8bmlYgTaRrvPOr04TwT3TgdRYliLy?=
 =?us-ascii?Q?/0qQO9Uek1riU0KW2u6X0crXnM6HOx4ndztydla3OYNuoS5LZnxa9GxMt7K6?=
 =?us-ascii?Q?qPOoaxSvSlTvULmSIrgp1RjN3wbjZfi0s2oprF95uMt0MbhwePxaXRjSDNs2?=
 =?us-ascii?Q?mLEpKLYYEpmm6EFXlkJcc+G0jwYlrgBQkQTuZS01Evp0is/e4+Ju/jtGSIC3?=
 =?us-ascii?Q?Ofg9LI23URVK+JqSQu6Ytg2enlhkmaJbrUktR9rAKwvUoMC3ubfVyO3RAoRt?=
 =?us-ascii?Q?fQFDF7d3uTRqw5eQuWZ3rWxIB76TPpDGexaINo7hCCOa+E+zCzl67xiIpTE0?=
 =?us-ascii?Q?+Y4uY634n8qDMfuTgKwgp7rzRWqjV20f+8OSzR3AvleucnSdjyhGILJ5dPVI?=
 =?us-ascii?Q?ewnrgOjTl/lcnsFLyiA4iEF3rO1WVAj22kegE3g2aFuD119gMFgd4/Ww8b/2?=
 =?us-ascii?Q?+F2GeKXoUr4YctQAz69qWOsv5NW9AN8UXvVMgwuN9nucfL0+tVnRL2qViSu0?=
 =?us-ascii?Q?4mvQlnVaXDK3QZH9AC2cPTIWxS2jJCKEw5phQbzL3qr78ywglChPK0JXxUS7?=
 =?us-ascii?Q?W3v5Rcnu38UOpI4PMpDRd7aafq10?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spJmirXlzkT364voE/FJp5msRNVcgpXXY+vqja1iZ3AIcP4bOk8qXYNgPiJi?=
 =?us-ascii?Q?fXYR46RLDC8mh121rC9SAypTmWk7dn+eHLyU/+rpSbj2+H7gRJalaGFbHw01?=
 =?us-ascii?Q?UCE49V5ho1re4iZbyLcFOKSMd8k8e8hmztW5pkU/A+lKYQeezIvwwy/cA0KF?=
 =?us-ascii?Q?ZNcDGljkfioyjANUQ+vONqzMFuMHYZZWo3MM2I2hX8lQGMe49a3PR00emDAP?=
 =?us-ascii?Q?WFvK5fDuSZBdnlKV5CK78B21fGaYmLKeOJeahjYNhhjywwmEGldOmjj9Fjqw?=
 =?us-ascii?Q?IpUU6+irzGTg9wnu3Sq3pOMPYwIOUwFg5iCouaNKJUebsrruwuk2/VBxLmdm?=
 =?us-ascii?Q?z9Vue3/Y0lnbwaOiXy8GyJGE696mOVrGSF4iL+osnT1Haum8kd9b1g1uc/Aw?=
 =?us-ascii?Q?gfeoq4PzJ5KTZspYjxOSU3K0swZh0uzIOPJwUFfVAzdL7YM3F04jnRFDKqu9?=
 =?us-ascii?Q?xD/k1NY/cVhgxzgW3BLLst0A5ONji+8/Dy2syWoik3AZaIyeN09F1P9VHIcN?=
 =?us-ascii?Q?0XhHvrw1z5xDZvXl4dxfGESCBgMk+E4FWQdjY/QLtKND2Y8nX+yleCdEeHOt?=
 =?us-ascii?Q?U2+FMUHRCW8L7JRWiyorQWo6vps2wyqT7Nrdoe8uSDf5nBHqU9FlWtVK9HhM?=
 =?us-ascii?Q?rIaQaXC5XUgQTAh7sCkgJZNd+EcfTALSeFnXfMcyuVgYphvwzbYrktx6071B?=
 =?us-ascii?Q?7zJPHZwIfanLTty6q5CTNL6ZmTaFiKyayyN2/kd/q+Ayo7VRZCOIo11Z7Qrp?=
 =?us-ascii?Q?k8ajI1fy9jSSoqVj7K4+iH5njLhB5QkQxnyWLJkE5ZNqm+/a5LbNUO7uag7r?=
 =?us-ascii?Q?7DmCiq+vSADtLTW5/OSHwqJubrVxkGksfMxyH6hSeDI5BU+jfZkR3bbE28uJ?=
 =?us-ascii?Q?8++XMdR9gDx/3COdiVufPCkBSKq28UQCMH1tJjBXDbvRYeV6O/Hud7U51VGS?=
 =?us-ascii?Q?eegdpgNZngnE6r7I97gsfi5McR68KriVGPqMGDmwSKExydwIHro+MzHEfALt?=
 =?us-ascii?Q?K57bATki9aueLd0cCci9edWZz6bQdXEpHc04HPfAcFws2RDpVcOTkRLBMz+s?=
 =?us-ascii?Q?sHYZ4Z5iKtbtOnUbfFH9MjBdgDON6Ru8uE09OGYOWiqDdOdLnHRCHlzZtici?=
 =?us-ascii?Q?GM31C4hvEnWuvBoen9B9B+kztv8QGZloMExzbsB8pmwFGp8bxjtxJKcSwogj?=
 =?us-ascii?Q?0GmxcLYnvqblxExBDt34Nme4aUtbWHkGjI+AdjrVqCZRtICbYpL3Ou2ZbFlk?=
 =?us-ascii?Q?uqO2YdgqwMBN0waPVy0VJEXHFkaUWD1Gi5arwl4Sz9mWBP3AemrVCOFC8f8I?=
 =?us-ascii?Q?3Edlpx6DxeU+KO0zjkBxqhPCw958exBtrrLcy7NiP9BJ31uk1odKH7FE9NQQ?=
 =?us-ascii?Q?pS5LHa44Zq+Kl+B1Jy+MajxaP6k8dyENkSZ0WiImPO/WLGKUNCxnrLMQyesr?=
 =?us-ascii?Q?aKcvZAhBI3aEEuSWALHnoVCBVThwvDWNz0nEzEMf27WPpSiX3JUChZml0uPB?=
 =?us-ascii?Q?cYM5OZWTOMMfJ8EqovMEoNm3z7z871NrxGdYJ7YvGxeBx15rbKi9MW0xUnrO?=
 =?us-ascii?Q?XUixRDN8dabIp4bVcCSe1BRouKS5fHoXiLEomEa6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3201b4bf-7a10-4def-930a-08dd1ec640a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 18:11:39.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQtroX3kzKBRMmU3dYD7sCBHVhnbLcfS0fbFP0VRH9GxiSxszRTb11kd89z8SW4s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

On 17 Dec 2024, at 1:43, Ryan Roberts wrote:

> On 17/12/2024 04:18, Matthew Wilcox wrote:
>> On Mon, Dec 16, 2024 at 10:20:54PM +0530, Dev Jain wrote:
>>> -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>> +static int hpage_collapse_scan_ptes(struct mm_struct *mm,
>>
>> i don't think this is necessary at all.  you're scanning a pmd.
>> you might not be scanning in order to collapse to a pmd, but pmd
>> is the level you're scanning at.
>>
>
> Sorry Matthew, I don't really understand this statement. Prior to the change we
> were scanning all PTE entries in a PTE table with the aim of collapsing to a PMD
> entry. After the change we are scanning some PTE entries in a PTE table with the
> aim of collapsing to either to a multi-PTE-mapped folio or a single-PMD-mapped
> folio.
>
> So personally I think "scan_pmd" was a misnomer even before the change - we are
> scanning the ptes.

But there are still a lot of scan_pmd code in the function, for example,
VM_BUG_ON(address & ~HPAGE_PMD_MASK), _pte < pte + HPAGE_PMD_NR in the function.
These need to be changed along with function renaming. If after the change only
a subset of PTEs are scanned within a PMD, maybe a scan_range parameter can be
added.

Best Regards,
Yan, Zi

