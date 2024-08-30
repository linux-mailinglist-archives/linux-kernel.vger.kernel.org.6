Return-Path: <linux-kernel+bounces-309228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2809667CA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE9A1C240C7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AC91BA88A;
	Fri, 30 Aug 2024 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fK/5XyeP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AK/UT+tf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27621AF4ED;
	Fri, 30 Aug 2024 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038181; cv=fail; b=PMJQdQnCFVPyehh9Foy2e1IT5hUQfylItqwUzf2pH0LP+f0PLazJEgOGQ5OjArfvcloBxtY72OUt4pRRepHhhsG1/JUHgDvRG84JSFzoV4ZD9z3NVfiHzrOT7GNmmWXZQT4FtwpXWRWfD/oT2HiD3zBZCjcpjB4+Tzj9Dw9BiIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038181; c=relaxed/simple;
	bh=iKkVVzmytxhF5Z+AgJ1WQEsNxKx41tgjL8I9rMWmqYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=u9munv7huPxhWP+iKy6NitlAIpbru9ziT5fVJzSvK1N9WHv5ohlhR78Cp/zjmVslr+quCl/YAkzzCEM5EDY4XfkNVqljoUaKPilkgIzsL7hysZzqiI5u4bIcR4b0PyjmOZ/OKMgWWg4vf0Gp8kQU+ETN+7ZKmlTETg5YfqM6/Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fK/5XyeP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AK/UT+tf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UF8SFk011978;
	Fri, 30 Aug 2024 17:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=trXIFKYJo53Pb1
	DCv0l38QAl/1jl88LaYXR62v4idqs=; b=fK/5XyePLJNgjsK7UOaoVzv1o44DWe
	1uKGgbLXJnEoEo+Id5111paGkYihIzYC0dRaftpOt3ZZrfRfaDg4GyzdZCxHznfP
	D5TdgVRTidNtuZhrrc1JGyTPyvNyuVf2umVKPRBYrggOuYjx0zMLCEfQmCl957p/
	cM3ROHFuE7sLkRwdgImHCFqArZz6FK1DgU+JMR89VJXPMh5cvrwZUVNkaakUVWfR
	BdAPA0eHoNaF+EVD9OULa+7o0UlHZROlxEOkLaSzodsWpTGfuIQFtaWcjZlAPotj
	dylvFfnIS4bhNKnVkUqU2op2M28+B3hERbh9aJO1p/+oo/zzKJHUV8sg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugy9d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:15:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFGq6Q036511;
	Fri, 30 Aug 2024 17:15:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jpua4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOuO9JbWn365eYrGw1cMMYaDy1lOXVOuscgibTyZeLnYUJO/3RVOrhjOyKSIZ/4svCbjSQ+NdDMZhT0trKPslhycU7aVILcSQx8Evaso0GxOuYKWYElCQQN6obsknGcKTgczFC9guoMcqgnH4wM3ZUzXRTaJYiDbuWHtx7WbeoM6hO26sUdzqc+hnTBaV600ypMyc7yX9q7PVU2oZIpPQJckyiY6kk4YxUmDH34y5VotwDK5xiawqWvlKANrr+ZEwr11KT6bzmVW4A4W6cFf0gJwIamHTVijl4KJgL807l5ktntoPj7wDURpxbBWQJa2/J4Afw9m42grfjpAdvKfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trXIFKYJo53Pb1DCv0l38QAl/1jl88LaYXR62v4idqs=;
 b=L9GRzh8sjd0P3hcvINvXRp/XFb9O9kAZfxOHCd8O8kMGQp1Xt7dWLSQeWzdCBjPvDnYx3bm9REKPdaQrBdXYGQZWu7YdCK0AD+47KtL0+tVihpYWB3e2xHF9CzfhAbVA4EO5nXS3wz74iHh/tqaZDFNef6d+HVu+fgEFGqzWIxwqQ3WsHDljMF5fW7OxmcbWd9PuTgQK7nRYM4OFsS+AP7bh0iCF8JyBu6iOVSvKPbxwyA+KLhd664SP/qnb6bc1j+eG8Kqcdvo6q+1NKRvQypuiF40IUQQUwixE5T5gUhmIVrp6TcI/tfSvL19wcZA/kjHgOov8a5fvap7WJxnqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trXIFKYJo53Pb1DCv0l38QAl/1jl88LaYXR62v4idqs=;
 b=AK/UT+tfjVpmcIJdwblwR7Op79zw7d4WqPtv3P/iGl1TJL3omfn+4OYdDpmZK9y2HA+geJhG/R7ykTvsvkbTGJZrG2ed9db87mhWFo/rzyOKYk68/8hzldRMSTW2jYkD+7FwTVN04BHzj4DQPLfNHkLTkvODPUIk/y13aWaF0Hk=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by BL3PR10MB6138.namprd10.prod.outlook.com (2603:10b6:208:3b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Fri, 30 Aug
 2024 17:15:53 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7918.018; Fri, 30 Aug 2024
 17:15:53 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>
Subject: Re: [PATCH] Documentation: Improve crash_kexec_post_notifiers
 description
In-Reply-To: <20240830140401.458542-1-gpiccoli@igalia.com>
References: <20240830140401.458542-1-gpiccoli@igalia.com>
Date: Fri, 30 Aug 2024 10:15:50 -0700
Message-ID: <87ed66q6d5.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:207:3d::48) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|BL3PR10MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fed499-c93a-4654-83a1-08dcc91766fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zeJcLOtcQCKpdm0CFHnwX99f/Ov8b8Pm4MQZ/EbMHRYwYDK6gVwnzPUCkf3Y?=
 =?us-ascii?Q?mXP0TYXm5VsbkoPZ5YVZWN5bS9B48UvZjahvSImmyV2XWybZyYJM7K3j7vtk?=
 =?us-ascii?Q?ecmXxQ3QlzwxdWY0SsfMR868id3JZERGY8UNrrs8AK0pOePffJ1ZR2xR5/Nf?=
 =?us-ascii?Q?EwMKb4iY4zbGduPAKXK9CuDVpjfR4s0dcLOb9vWvQfsAfsTmEYXRyu74ud9d?=
 =?us-ascii?Q?uBX+35aQHy01BoeCrFIyVfOyKFGGTDK1Q411GWKeDFM/cxesRCFrhrxXIOBn?=
 =?us-ascii?Q?25d9wT/wODjS74WjlyP4mIlNci60T5UcKevc7bqfqjPLMguld7nE95UcVDpp?=
 =?us-ascii?Q?IWl0BwQyGIfVDgBcNDCz+q+qCGbu0O4kSTPohGtxTwyqYnpa29r3Emn9W2Fy?=
 =?us-ascii?Q?KqFv0XjIZh8JS6e+1ePK1Yz3Z5HnF34wDTgOrAX1Nl054eDldfj/KQOzzS63?=
 =?us-ascii?Q?z99Fz84Ub/jng9XudRvGzAmkzqDrSHTRFWyZRYbLGFskhuo+HAc0D5JPJ6SF?=
 =?us-ascii?Q?RtQy8Q/3AV9jcbhFQK5lacD4SlWTI1bMQNAfNkxhZ9Vh6aMfNcgVUuahv/Ab?=
 =?us-ascii?Q?1VM6rsgOat4kx25b4JYQbKM7hbG5VXizuLBXWDCtnGGwWDufopMpoa3oSQpw?=
 =?us-ascii?Q?Cw9yk5TaaoE90Oj90OJtsg/adwpNIf3IBwIDQQCP4fztGOEpIBCbumLo7k7L?=
 =?us-ascii?Q?xfpRofOyAey6sHbMjrJewRK67kSnW2Jt4QtEfGRm63hD4t8dMgvIeDQv+P03?=
 =?us-ascii?Q?Ck4lvg1XQtZJORv6W5/MbhhjLLp1FNwuN/HE2S9YldrY5f6oMSED8jkgRd1d?=
 =?us-ascii?Q?mJVkGYmuAoAg95z9qD2wvndVhSUaLu49+9kHVgx/grR4OVgK6hbPgr2ujrze?=
 =?us-ascii?Q?avikhLTgd5Pr99UKKC0iOoEOowafoWR6l7YE1sTURav89Bt9u7f/dK7E3/5G?=
 =?us-ascii?Q?I0JbxxhsQ+LmUxW6X/kL81TcNydtYfJtXCA/UKEHaatWSko3bFydEyRWg+MI?=
 =?us-ascii?Q?/YJJUPtu5COMI3PqSRx+xsrnoEIO1FyGhJ5O47ZHhNdwsBUmnN5uynzJLMDg?=
 =?us-ascii?Q?OrrL/UPsZEm4KoCB5XPmd+Uthc6dLfZycJ5OdFkj4tlSIqGJ8ipyq0rS+c3k?=
 =?us-ascii?Q?eOPCUF3FZzR98vyyOb4VEyUF8LaVp0Q+N8j6KRUL7mgyzOsL+sdhf74h3waL?=
 =?us-ascii?Q?iwWAUEdxn2TcoBcWq282gbzI/jyOlfgrsvgzroJky1GWFZeTNDKlo6mQ+sUR?=
 =?us-ascii?Q?3roiZiQhBVSnEviP9EtOvd0WJxEaNZY1TgpOahy9eYKhupMsmKiGDvMxWqpw?=
 =?us-ascii?Q?0LI5/ba27VLag1kwTJotBRR0amJdlX8/gbTHoZCMut5EQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bnVnTt/KyfL1IL52tmSl6rKxppH0Gsf9VB7ZRUlMEb/IYt9ueqsEoXpWwMi6?=
 =?us-ascii?Q?4ssIChgwjWnIpqMUEu7vsbScpa3LqoZUDwAhrfmKiuIInTO3gjbSkXCryhBg?=
 =?us-ascii?Q?zxpKydjQn1zhxc4vP9i/dmcE/j2hCyBNG0BcvLm9BDAQ/tB8WFLmXC1JtvGH?=
 =?us-ascii?Q?gM5uoZPKPlgj75UNhmkXQehWzFtGWyQQXrvdTu3h7vbmkEJaRBR9dVE6yj4G?=
 =?us-ascii?Q?ErJ4RXxrCC25rTzx68G4TGtrBNI+0Kd4GmnYcGCvoh/eBp44CUfgQzJkIBVr?=
 =?us-ascii?Q?/UBs0CzwLNsahId7lv85hHcVWidf8gFlqJPk1htdMO7xCQGE6aD3cjfayEjp?=
 =?us-ascii?Q?HlEYAR9SC64jo16zTdjYV6NSj52yJjrSb502FJ08TPTe2htPnWal+nbdeyAy?=
 =?us-ascii?Q?sNtTE2Z5up4PjqLR3T0kE8rdgNjG2k4vBX3heOTRcSMD3FEu5L0XFOehbgJ9?=
 =?us-ascii?Q?KxaNwntHkpvCMbOBuLwF5QzwDcD2U6FKX33sG6ej7YT5ci4qprsM4SHiZjlc?=
 =?us-ascii?Q?xBNIbuZs8ONMbRRoEEXNEJt2HNo2FDvxV1VXtf1v00pDkIuX9xpt4wg3TUz0?=
 =?us-ascii?Q?pg+s5nV0Gh4hfx7V3lZ+Zqvu+Te2UafhAqPBOEVunvO2wvSvy8F4GXjZAq7n?=
 =?us-ascii?Q?2laMVjob2QyIbZoZJoy0ne12BQTs/oBE1V3ztBCBxQ7ws6doAKdF8r3PNFg5?=
 =?us-ascii?Q?xvowtMUeuaP99X1D91ub7UVZ33gHKNmt+DbWaSs5DjM3JpGAvD7SU4UDCn7y?=
 =?us-ascii?Q?7KMqshederSythq14mUcdUJddcKeAT3d9y4C1plbKzl1TjQ1+BtCQp+bmNRf?=
 =?us-ascii?Q?dqSS7hGxakHJbLAdctUgBkaLnsg2NG/1mg6A/9jA6RJasrvlDamPBakrSPBm?=
 =?us-ascii?Q?3Y5Jsom3+7CyB9rjXXZ3vSQxGqfvRHwYLTjlv6CG0YXCaJvuKdhFQhU5Obv3?=
 =?us-ascii?Q?+io/9eaSRzrPAOxpnlb+6RRtjwlmYNbcOnAjPDd0FE+m3uKpSRqnX+ux8kAu?=
 =?us-ascii?Q?A4roK+YwaSa1v+fMV1duBIsHswY75IZD3qD0hg9i7BUWY5iPVkokIguPgYtz?=
 =?us-ascii?Q?a+yHZTdX7wkjVxlp0E3hQ3s+eZZb8DELekF9D9XYgiN+eMKw+v5HSmF2wZJz?=
 =?us-ascii?Q?+K6ultYpU1DyGjtp30XfKr1I7x5isBdbmGO0KO9DjetIzn+eMI1MNhqSUOAY?=
 =?us-ascii?Q?zeGmW4onb94hSHYER1ZmXhupDa/GjoIEDC2nVt6eN/1AM8EAb4fOCrm1WOU4?=
 =?us-ascii?Q?hpnTMcgOiw+bcpoyc229bzMNV3ysd2n9iLGBsrW51an77Q5jjapYOe1ORg68?=
 =?us-ascii?Q?kxKqjIg4ZjTT5v31ZisKGt2njS/OupDnV0c3OITa7KN1f1FLeIBvfApf3M0m?=
 =?us-ascii?Q?7M2hCtwNhsMX1PQmD23FF8yrh6o3QYr+HmBo8JG2B60Kq6cWhV99nUPvsUMN?=
 =?us-ascii?Q?HytIlpZ76bR9Kb1worNcShMfnBHItmYmti7RMUc4ST51YXbdOOwmeqg+gew9?=
 =?us-ascii?Q?MtBOJ2lUKxdDd9807ilTTPaGi/+lqQt7frQUMgxKYXdwBXtBFl6ZEdVtY94v?=
 =?us-ascii?Q?+dfRMBL2T/DygTkvz1/cnf/pYZLzeiXn90j9H7G8tOGfwzOIofGOB1rpU4es?=
 =?us-ascii?Q?JjwxrWbsXN0W5E5ZjyWlm53EoS4hGyRdiMzqQOejXzcT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i/7umgNT6bae6T7r16w71tvFGA/poD3VfwGjC8IQsO+PO2a4chtoHbo46gMYSHrNABT/O7Axm+ObDvR47XI08DzIIF6toOKa2A48IZMdOyZ1qUv1tLZMZjDlgWCP93HoFwfUe8KwwcF/pWjKZ8FiY1lXlDZgQhEhFheNkGU3bniImPCD3NPmrCkwpIbUobz9kfIP9B5o4hefjaZNSKzzpgh8m6TS1NLq8A3egFvGcdkcP5r9ib8sM+nmoCrziknvAGpiCZK05a9IPkaNFGJbejMp6RlyGn4qk9gm+lPRU+RCA25bAwWkXq4xHy+3DkbHhhj8FwPUgeIy/YYkFR11JlocBk5vNTV9H7FnkpXsxu18+ep2uJDxekhKrwa+gs+HNSZUbmHKGj7O1jGTxpTwZ+bZ5LZUy/sn9yV0BYcJDY3obiqKNKhNaqkOYrz/HLR4e9FfTIcXsXiXWEOAoRkUfOz+Yd5VMsTG5Ts7HYcgGiYTG0YDYVw/iKDeQQXYA9VCtVcD9KW/hadJYLyT0GfXhCa0II+v0usxb2IkXQeIhKVdCkP2WEg0q6BgPnQtaU0tdj8BoEAXal0pIP/oZR6zJwY6fxBSFC2ssjFEvOJJP2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fed499-c93a-4654-83a1-08dcc91766fc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 17:15:53.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzyG1NCk5YXbOfkc65jNrD0QtIj0qm/ImAzxdC0FJgtRmh4IndSH24LvDxecLn9hG7g0Th9BUNPVPv6wgL0HMXTJaVEPDcn+TC5VQps0GGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300132
X-Proofpoint-GUID: iiHRrH_6Qaa5PbKmlj_2dQltF26bYwtP
X-Proofpoint-ORIG-GUID: iiHRrH_6Qaa5PbKmlj_2dQltF26bYwtP

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
> Be more clear about the downsides, the upsides (yes, there are some!)
> and about code that unconditionally sets that.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index efc52ddc6864..cb25dc5cbe9a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -913,12 +913,16 @@
>  			the parameter has no effect.
>  
>  	crash_kexec_post_notifiers
> -			Run kdump after running panic-notifiers and dumping
> -			kmsg. This only for the users who doubt kdump always
> -			succeeds in any situation.
> -			Note that this also increases risks of kdump failure,
> -			because some panic notifiers can make the crashed
> -			kernel more unstable.
> +			Only jump to kdump kernel after running the panic
> +			notifiers and dumping kmsg. This option increases the
> +			risks of a kdump failure, since some panic notifiers
> +			can make the crashed kernel more unstable. As a bright
> +			side, it might allow to collect more data on dmesg like
> +			stack traces from other CPUs or extra data dumped by
> +			panic_print. This is usually only for users who doubt
> +			kdump will succeed every time.

This is definitely clearer and an improvement! But I didn't (and still
don't) love the phrase "users who doubt kdump will succeed" because I
think that implies user error or silly beliefs.

What if these two sentences read something like:

In configurations where kdump may not be reliable, running the panic
notifiers can allow collecting more data on dmesg, like stack traces
from other CPUS or extra data dumped by panic_print.

> Notice that some code
> +			enables this option unconditionally, like Hyper-V,
> +			PowerPC (fadump) and AMD SEV.

Yes, great addition.

With or without my suggestions it's an improvement, so:

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

