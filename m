Return-Path: <linux-kernel+bounces-363612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E199C4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338711C221E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02C514D6EB;
	Mon, 14 Oct 2024 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k9oVzGgw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KegrtGWj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824814A0AA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896716; cv=fail; b=tG1ilNT6BoSYXNPgUwU8W7hFOgYfMk+kdfAYQN7oxb06Dpn161D19RiyG7CY52ExEm4AErbHxWzTl06FK2T/uDfIIw9vk8H18FZNI3WZtOnaD/XRGURKkaZ7atN6KNc4KAshNGw1YMHFfr+kO00pdRdlZcjz0xVHMW0XR3cM/5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896716; c=relaxed/simple;
	bh=kpA844iO7II17zDx337adji4HQXXG5nMN2KvWUs2LV4=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jghTcbkIfXZK+uChAr7sVBkaFYrTnSiMkysghl1KpgefEGDiS9n4hzwGr7qpUF2K/xS1R9cyibo4zPk8avQl8wusiDBJYGk8yP9i1aJGiR61C0azBQkJ5BVaRSd7UYDMwW5kAerQYtAkB2AQUne6OYZyY7rnLRlPoHUi9uLo6+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k9oVzGgw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KegrtGWj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E7feRQ008710;
	Mon, 14 Oct 2024 09:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=nW1lPlm3+cHoN7WuHu
	feQdjnk13MZHOTINK/867RAtQ=; b=k9oVzGgwVmHJB5wNSikyAK2l/pNuYYY2BH
	P1NmhEDRdzSgS6hfRNNq0UKwJVShDEXBqqZ0UwoKuZfPYKgPRX5WPRnunl0OFTU6
	aozS4drajj6Rwx2TsRG6AFFiGk+zgVL0/HKm9ppGZqROQXXPoAuZ+FBraZcZ1Z8w
	c2qen3+yiujRDyArY9eGzfGxN3q3uEbHnQAA/BkFPmrQjuEKfJp6TYQpl2o3+Y1a
	NzNc3oF5sefH6mgO7HLhHxo+oHYGyXk6Aqf+TwGGIfT/vjkhge2lVvW2gMO4vFUg
	pEu4T3xNYR4/5AwVwMU79FlKvliAAOdrWaMoH5YvxAB3HEHEZTuA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqswu3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 09:05:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49E8Mi8d027565;
	Mon, 14 Oct 2024 09:05:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjcb626-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 09:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsxONB1hHLPH7+J09hY1bTrRGPAcqoNHagO3tOB0c/UMoWa9wFYKwJN/Ai4eKnxRjLDCoZI19issfb2vtiaOjFxTOSaBzXOKErICn2iRoonTcPOeAFp2bASjgZyL4pXMHTKQCog5KSg6dU1Aqr0sdgS1QSPA0wH06IIFT7zTHCULQlojzEsWwrDz348+t8+0+Q42WDxUM7xmcY39w14y7+hCylBO7Qnafb6i/7WgnFlYf24255eWU+EK42+QmBzb1Xg32aRK6iVpb3BkRC+20uzPsSSdC1S+/Lwl8M4lU4+SEEZepvMiaVDHWDuZPTEsMSnSCe5EMjZxeH0mTw7FSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW1lPlm3+cHoN7WuHufeQdjnk13MZHOTINK/867RAtQ=;
 b=VS0aoMvqN9XcbHjEqBZYhV6V1ZVBKEYa9c6JxrqbAtse27D154Ae9nH3xS8tKdtY507gqJ5yH95UXWsxnG6D5LX6yWJYVsZdKMALzd/CwYqcA2Hyo6HwqtrRk+4URIwgXPT6NaV6RUEjyf3URFytYTnU485b027YoHl1atv3HWshShlNJx4lvLbUteCjgSPyR4iY4gldaddxSF+YFSwJIDSWFelExcS/AmwZHe7omj4LnQKEK2z+GB5r2T/zWIQczYaCAC1KMbSUvqbnaiqBvziB2BOVbnpLUssYMXtGZhApFYwPWuOSjkgYXq50URwDwQY60sBX7EyM1A+TKHUEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW1lPlm3+cHoN7WuHufeQdjnk13MZHOTINK/867RAtQ=;
 b=KegrtGWjLpTGVBp0obwYwCOaIoZ9HwHbK39AOdQsKXqOaHHbw64sfKnQ1H+k0h/fWMJISrMHHXrC1DiUK6d7qasuKSxwHEN6X0d9dZqIPk8K/QMU4kESBbY1j4m/zx0UhyVo6AYgLcuMufWEqpI0MZ3BDK5hRAKP4WFzJ4CErXE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM6PR10MB4153.namprd10.prod.outlook.com (2603:10b6:5:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:04:55 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:04:55 +0000
Date: Mon, 14 Oct 2024 10:04:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot <syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] INFO: task hung in exit_mmap
Message-ID: <f43ce864-4b4f-4b48-815f-0fa3e338cee0@lucifer.local>
References: <6707f080.050a0220.64b99.001c.GAE@google.com>
 <72188763-843c-4e83-a25a-90be2d0bf9c0@lucifer.local>
 <ZwvLJKnyWuaKp8NL@sashalap>
 <oluo6mk6zlb4wk6zul6hd3joasqjms3jwexxbcacewp537eenp@37gwchfwzddi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oluo6mk6zlb4wk6zul6hd3joasqjms3jwexxbcacewp537eenp@37gwchfwzddi>
X-ClientProxiedBy: LO2P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::33) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM6PR10MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: 01226119-464a-4465-e336-08dcec2f4584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+haIkwrw7HV8F+NwzxFJ++zyWafGp7wUPwaW9qs91NAR/uFcvDzSTwyerhJ7?=
 =?us-ascii?Q?QV/AewMCQWrDAyPcow0SeRxAdllg/9he/8Ki0KKDODJmeSauxiJz++NTnZDI?=
 =?us-ascii?Q?DYBy1p3PCJU39NMTPo7I6HxJdVqJPBpTjm+ZTcluA31HokJ7XW6vWe9je4JJ?=
 =?us-ascii?Q?NqKdCvdJsGjWg7u7ikOPo398/S9Q/DnpgvkD9xodnq7tz02XlxADPo1BZGoN?=
 =?us-ascii?Q?3C/yZRmYaNGJxdaY9u4VHC13V00UdF78+BQFlCzacvwKI9d3SYpLeQTlKTdC?=
 =?us-ascii?Q?bcC+xdSq0TNmoX8nBxhcp3ejzyY9ZVM6WT/8P7SvLKP3aUJ98ygZ5LJ3E02h?=
 =?us-ascii?Q?cHjnxhcghK6UPBLGCUs8fYKhN+pi61i8piLoF8dF9c5bccFWoXJytHPa15Ay?=
 =?us-ascii?Q?142xr3uZg6WuWWQzL9M72fMmAWhX2g09j5c2S0FJw95byVqHhNDatV5n/sKJ?=
 =?us-ascii?Q?yiPYK7hS91p3vWTWN/HOqtTOpG3jQy0vSyqtwY08lMnOZjPcFsyPhs89rRus?=
 =?us-ascii?Q?a4ojZFXQQhIIbw4kMZppoSOE4xDb7i1w+gEv8QgDtoqLDWwWI7xVHTnFT4c9?=
 =?us-ascii?Q?FvTOjhvFfFLgXgSNLqsHpPK7B33V/rlCvaaEJAUgqeMorI5iBI9BfCMypK36?=
 =?us-ascii?Q?eODkZ/YsRxWlMbw7GiG2bpLxL3VhRGh9TlnsCS/WP4QEF4aqqfAkCdclcpam?=
 =?us-ascii?Q?C/jo12fstGLmvJlIs/cLgtxTLYjPx3f8IYBCtMbTNA9qSLhT9oG33WmRLgEM?=
 =?us-ascii?Q?GPtkXtsu5rCIpJnKLe5VnF6qrA8SXBEMRrZKPwSNOf4ZNgDozkJICJAeaSmm?=
 =?us-ascii?Q?K7ZTEVuAWl68bq34CGibbhUMNTfwYnngB++dXeIaTETYrZIgN3U4GbP+a4K8?=
 =?us-ascii?Q?8zPmV2scEZBmRANWB8F7yVJRlrB9xk5kueBe3NZk34E6IwqrMhMh4UNln+km?=
 =?us-ascii?Q?RjZwCnCAQWJPv7tjeZxIkcs+7eXBEjmjMoiRYbw66z38MJ3PG+SBswMg9UgX?=
 =?us-ascii?Q?opcNcIvB/zVH5U8m7W7nQD9UfiihVuBGEOchVCMdv8Zapx6yOFCAqaO4vsRb?=
 =?us-ascii?Q?NKxuM0WkZC4Atqe4ls3gD/fSyCNUoRSORCBYmI5aHm/ng5cC1LkpQY/I0Zyt?=
 =?us-ascii?Q?h9L0Nm5/HJtF1BwdXdvJ1t4E/Zny1PLCeDcNladx/aKB8meRztgJM6TJAGM2?=
 =?us-ascii?Q?2iF9DMIhOWQHoJJ4AVzn/9NxNedVsg0Mh1UQ5xBTRl6XSbZfqxGZgQuj0Pk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMwz+xNd8PYkUnBvvK2hORr+M2FF2UPypM3+UJIeHQpnC9RBg0VDHtNFX8YB?=
 =?us-ascii?Q?9Dh3jJemXupe7Ofiy/gW3W36lwT1FqRb3AitODdAuu/ZZHJcMBVqO6d9v919?=
 =?us-ascii?Q?pEKAE97yZCetw3WgV9uJsfrp6blLe6P7OWuIRzk5nsI0cRs2CLVhpScIkJeX?=
 =?us-ascii?Q?cgw9kYQNDxCP8Ny/1ASywJDnJM4Yz6PAtfk8DHOT+qhdnFH0tY6XtIOskJvE?=
 =?us-ascii?Q?+H/CDwlSR6ZAnyVqQPNi6U+EVs0OWyIcx53GYJ83Aqu+8vVcsfdAg9T1xVwr?=
 =?us-ascii?Q?Gpw/118/i/Yq5F6Gx1JZ8eY3l0FVPgstFdxWKcCcAAv/Ibiu33n5zi4DP41c?=
 =?us-ascii?Q?4u+7Jjvzi4MJccGEzP0EECT79wOO8S/wnXXfrolNaFTXIb5oCsT5YRg9F1QG?=
 =?us-ascii?Q?+na9CW/qEK5Z9tZW+0oktkatMisMa/x3DKNDilyriWx4R1Syzr42l7wMUV2i?=
 =?us-ascii?Q?qWbeA4Yt/QRQtnhz4mQn+L2QJq8NiT8o10EO5h6jo4jMIwVmXE4jRD0QXCCX?=
 =?us-ascii?Q?wZSi3ttZuin0NmpdUa4Exg38yALKZy4yd2ecDJMXcH7pUTJGwYhqJl4r/96E?=
 =?us-ascii?Q?BlsTVXlHgDVjfoLIO9pq04PFhwlbK0py7prPRWtS1XhiihVG4nIdm4KfJscn?=
 =?us-ascii?Q?j8UQcy0Hw/RRJ1LQT5L2/RX6FDU7T9fJ8WGWEwU3PEKq6Ybb++S89RsZBkSy?=
 =?us-ascii?Q?5kB8ed9EeUadWJYyL3dO4ABXaRsF3Sn0ICB5553jUqx5Evjguh+Cm5shUFTr?=
 =?us-ascii?Q?xhzrzE+qjFklI/XzTEq7M5MKKoRwLmw16GSDd6HzfaNko9Cbw7Iq7Dfn+q8X?=
 =?us-ascii?Q?6sVYsm/IpGCHBOXhyUHAPlHa0x82783W8Bcny4x77ds8YMbRBJScfQDJGTdx?=
 =?us-ascii?Q?6EUOYLHP0rnyEo5xhs8PVz2pPYFP2zay6mm2zPG47shUSHvPd8kLGiqY/2ff?=
 =?us-ascii?Q?GcNGrC2RG1yJ6WW+cq3r+bRl8j6Y6dYnJ2Z7f2XmeAU8WHF4AiDYhBC6NFrM?=
 =?us-ascii?Q?qH+rDXGf9fmTF4kb77lniPgWDNN0lRxRgzfoF1AgNh4oN0Bs2nOOi7K3l+/E?=
 =?us-ascii?Q?+ubFMIF5LaCVgVr6rP7VvqskP7MaQOQfhS8GDdLtScAn1G7mIq8qOOP1g3VK?=
 =?us-ascii?Q?JUOCrjikLCb4cRqr7zdxueS500W6myZ/WkWf1xcmj8sKxFyVdnV09XSx4Grc?=
 =?us-ascii?Q?1h/ZVwWQj8JnkRnuqX2Xshy93cghHjFfLq0CNfkB7+FXn99hpSGuaVvUx5TL?=
 =?us-ascii?Q?ow5H93IH26puIZGjxP3MRCqoYO16G0QWGM59Fw+d1xuRZ6tbim6ora0VMPVI?=
 =?us-ascii?Q?bhxxSz4Ot2Wu0U+JgyyqkzCvxs/FIKhfVP0Cwa2s8bCcUWvdjqe5Axppq2BO?=
 =?us-ascii?Q?RKZs5r1MlFb0NGKgNo5rF1m9H/KTDFyXI3gwfB+c7mVVQCZtPkG7HwGRkd+J?=
 =?us-ascii?Q?ZOxZCJ7MinlcOGSMz+4+q1vfqL57MWmkoIQfoCjFRiyJ616PM0yqLqLx/svP?=
 =?us-ascii?Q?DT71Z7EdR1rWUN9VVtK6LPP7HkDlngA70AyHf/H8hjLPAjsOBoswgaYGEYxg?=
 =?us-ascii?Q?Su0Nm1CU7LRc30ksmRBsEgbViULvF5JZno2xZWiqAwXCYvvSBVt+ncv4wDGl?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nco9785Ba3clHpzs3tKeg6cAqeOkZmuOGUvB9Rpl+PtKJT8zYwEivI9XbI/3u/rQOUQZgvfctsH5ZYkGd5W7T0JL8jgyFN1HXZapgdYpj3kv8qf7s8SFp1lP2ikiVkHgowXhfZBjpkJw3WP7v4dKoSGR3n8UC5W6R8pfsK6PVyTlgVzyBvIH50yRKOJ8V6PwJmAeHSRscpqbAPwSbsLpg/+9VeK7uyXfmRwqlECHPRi53QSFDB3x+vWBjuzfkryAy4cTUv1CruV9RZIAxL6ay7a8cEO2v5Usw8YmJPx+0IyFMvV9QNEm2x2Wov0vwpl4xKN+vHvNz+hXa4ByynyVgbW6y8S91L7ezmptB4V1eSOoJgGldDx/mLO4i9TzTOtIECyqidk63IH3Lp79qAU3XERO5XHIW5E+i9i68DDtCnTPyhVrEVeXxVenWa4cho2mtLk0A9W3yKcYUlebMqoOItX8TY3oktXj0FCnJWY4Jwp7aUx9cZuNMUNNR16VcFCY2dzBVnVvq/z/G2jCXuM8DAby6DaWVns2kp2ss38iuYwpIyrf9zjYSm6624vJG4asA+Cf1IBM7cmsTwoqOS6d73y4dl8ShsKWRmfDy1/Ez7c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01226119-464a-4465-e336-08dcec2f4584
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:04:55.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qxx9fa/iOt7OFWtrKP9bahm5/3YETNW+rpWWrNNSlXTOndPEG/QnbEfBGmdj/DXNxTgRREayj+mTQGHrksORL8mm1FtrFMkRCH/deL73T5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_08,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140066
X-Proofpoint-GUID: k1ut6bvZ05yimqkcL9z4BtcmfUgyE7lx
X-Proofpoint-ORIG-GUID: k1ut6bvZ05yimqkcL9z4BtcmfUgyE7lx

On Sun, Oct 13, 2024 at 10:22:11PM -0400, Liam R. Howlett wrote:
> * Sasha Levin <sashal@kernel.org> [241013 09:29]:
> > On Thu, Oct 10, 2024 at 04:28:18PM +0100, Lorenzo Stoakes wrote:
> > > On Thu, Oct 10, 2024 at 08:19:28AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    d3d1556696c1 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10416fd0580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=39bc767144c55c8db0ea
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/0600b551e610/disk-d3d15566.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/d59d43ed3976/vmlinux-d3d15566.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/e686a3e7e0d6/bzImage-d3d15566.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com
> > > >
> > > > INFO: task syz.3.917:7739 blocked for more than 146 seconds.
> > > >       Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
> > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > task:syz.3.917       state:D stack:23808 pid:7739  tgid:7739  ppid:5232   flags:0x00004000
> > > > Call Trace:
> > > >  <TASK>
> > > >  context_switch kernel/sched/core.c:5322 [inline]
> > > >  __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
> > > >  __schedule_loop kernel/sched/core.c:6759 [inline]
> > > >  schedule+0x14b/0x320 kernel/sched/core.c:6774
> > > >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
> > > >  rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
> > > >  __down_write_common kernel/locking/rwsem.c:1304 [inline]
> > > >  __down_write kernel/locking/rwsem.c:1313 [inline]
> > > >  down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
> > > >  mmap_write_lock include/linux/mmap_lock.h:106 [inline]
> > > >  exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
> > >
> > > Hmm, task freezing up or system becoming unstable/locked up is reminsecent
> > > of the maple tree bug I fixed in [0], which is still in the unstable hotfix
> > > branch.
> > >
> > > This is likely not going to repro as it's quite heisenbug-ish to trigger
> > > and the failures are like this - somewhat disconnected from the cause, so
> > > not sure if there is any case to speed this to Linus's tree.
> > >
> > > On the other hand it's a pretty serious problem for stability and likely to
> > > continue to manifest in nasty ways like this.
> > >
> > > Can't be 100% sure this is the cause, but seems likely.
> > >
> > > [0]:https://lore.kernel.org/linux-mm/48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com/
> >
> > On my Debian build box, running a 6.1 kernel, I've started hitting a
> > similar issue:
> >
> > Oct 12 17:24:01 debian kernel: INFO: task sed:3557356 blocked for more than 1208 seconds.
> > Oct 12 17:24:01 debian kernel:       Not tainted 6.1.0-26-amd64 #1 Debian 6.1.112-1
> > Oct 12 17:24:01 debian kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > Oct 12 17:24:01 debian kernel: task:sed             state:D stack:0     pid:3557356 ppid:1      flags:0x00000002
> > Oct 12 17:24:01 debian kernel: Call Trace:
> > Oct 12 17:24:01 debian kernel:  <TASK>
> > Oct 12 17:24:01 debian kernel:  __schedule+0x34d/0x9e0
> > Oct 12 17:24:01 debian kernel:  schedule+0x5a/0xd0
> > Oct 12 17:24:01 debian kernel:  rwsem_down_write_slowpath+0x311/0x6d0
> > Oct 12 17:24:01 debian kernel:  exit_mmap+0xf6/0x2f0
> > Oct 12 17:24:01 debian kernel:  __mmput+0x3e/0x130
> > Oct 12 17:24:01 debian kernel:  do_exit+0x2fc/0xaf0
> > Oct 12 17:24:01 debian kernel:  do_group_exit+0x2d/0x80
> > Oct 12 17:24:01 debian kernel:  __x64_sys_exit_group+0x14/0x20
> > Oct 12 17:24:01 debian kernel:  do_syscall_64+0x55/0xb0
> > Oct 12 17:24:01 debian kernel:  ? do_fault+0x1a4/0x410
> > Oct 12 17:24:01 debian kernel:  ? __handle_mm_fault+0x660/0xfa0
> > Oct 12 17:24:01 debian kernel:  ? exit_to_user_mode_prepare+0x40/0x1e0
> > Oct 12 17:24:01 debian kernel:  ? handle_mm_fault+0xdb/0x2d0
> > Oct 12 17:24:01 debian kernel:  ? do_user_addr_fault+0x1b0/0x550
> > Oct 12 17:24:01 debian kernel:  ? exit_to_user_mode_prepare+0x40/0x1e0
> > Oct 12 17:24:01 debian kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > Oct 12 17:24:01 debian kernel: RIP: 0033:0x7f797d75a349
> > Oct 12 17:24:01 debian kernel: RSP: 002b:00007fff37f0d3c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > Oct 12 17:24:01 debian kernel: RAX: ffffffffffffffda RBX: 00007f797d8549e0 RCX: 00007f797d75a349
> > Oct 12 17:24:01 debian kernel: RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> > Oct 12 17:24:01 debian kernel: RBP: 0000000000000000 R08: fffffffffffffe98 R09: 00007fff37f0d2df
> > Oct 12 17:24:01 debian kernel: R10: 00007fff37f0d240 R11: 0000000000000246 R12: 00007f797d8549e0
> > Oct 12 17:24:01 debian kernel: R13: 00007f797d85a2e0 R14: 0000000000000002 R15: 00007f797d85a2c8
> > Oct 12 17:24:01 debian kernel:  </TASK>
> >
> > It reproduces fairly easily during a kernel build...
> >
> > It doesn't sound like the same issue you're pointing out, right Lorenzo?
>
> It could be.  I suspect there has been a change recently that has
> made the bug possible - although, I've not put effort into finding out
> yet if that is true.  If the bug existed for a long time (probably since
> I fixed the live locking issue in 6.4 that was backported), then you
> could be hitting it.
>
> It is a single line fix.  If it happens frequently enough, you could try
> it - this fix will go through the backporting route once it lands.
>
> Although, I am not sure it has much to do with the maple tree as I don't
> think anyone should have the mm to take the mmap write lock.  If we were
> stuck in the maple tree somehow, the mm wouldn't reach the exit_mmap()
> path - unless I missed something?

I think this is the same bug, as the problem is, once it manifests, the
actual problems it causes are delayed down the line until we hit a
situation that is _caused by_ the bug but somewhat detached from it.

In fact Bert and Mikhail hit the same thing with a process locking up in
this path AND in that a lock is held that really makes no sense.

As Liam says, this is a one-line change [0], could you try taking it and
seeing? It has already been taken by Andrew, but we delay our hotfixes by a
week or two so isn't in -rc yet.

[0]: https://lore.kernel.org/linux-mm/48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com/

>
> If you can dump the running tasks when you hit it, we could get a clue
> from the (probably numerous) backtraces?

I suggest first trying [0] :) if that doesn't fix things then we will
definitely want to dig in further.

>
> Thanks,
> Liam

Thanks!

