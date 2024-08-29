Return-Path: <linux-kernel+bounces-306754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6029B964300
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B12283E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F0B191F67;
	Thu, 29 Aug 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UuMn5dj8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AGG4cDML"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9F18E756
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931059; cv=fail; b=Jicg+GlNAXVouLpmSICiNohuD8jlOQg7qUULy0h3n7GitueIfsM/VHOb0PRMBs70bKpzKyPThDzzvXjQISnpyN1a6GBAsuLGoycvk9tdecArYzNuvBpScmixegZk3LVLbKgRe4lglAIox0xd0NcnQZtJIuNwT6br3qvh8825tbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931059; c=relaxed/simple;
	bh=eG3Rw6N8yIu6aICR1QCPhRpCBQU788iKcX5JE3e9pWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ejNLH77Jenx5hsfSlWK67Oi4TybmSopXcQpoDfSpqCTUEzUc3SHpODwoxyfkvLWH5w8WtXeqoM08/LvXH+IL1JyEEd7WV/vx/FxpX9fh+Pn+XHDcfgvRknISprZcx/ZOnFjg6FaQcV3+0GSB9Hyeyb9mydDAiNo15GG1I0/jwDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UuMn5dj8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AGG4cDML; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TB5KK4001392;
	Thu, 29 Aug 2024 11:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4ZdfQ1Ak+A0VZmu
	vr+alP7UHvl8QgMI3mtzVcCgnFps=; b=UuMn5dj8p3Y8xUTumtd197xFi9zA2qd
	2uslZZeNlig0QH/0fgCtgJLbrek7jgznlvW0GU6d2GBCPVlYZYHe/q9QPtQgb+/8
	xDTPZLoSsT7XqvYmAgPtv0r8YTXiyl4NSxKM/Yu6uZcghfly53OeEG8x/eV+lElP
	DwqPQV/vnHMB/o9y8mjdByOXua6bQNDEJ4fg8MwGZjnwISX11cIUKoWtfPz4KBku
	sYqYi9a4giOnnAwh0lAyw7ulo5bQAVVyzZi4Zo93QkHWOBm6d+tNkpZ49Zq1sQT5
	0PnN7crs+90ieSx4U3OPkQ7XdeMXiuOeDM0KPw2e3wLE3KmTNsDXTlg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419purby3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:30:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TB0TYv017398;
	Thu, 29 Aug 2024 11:30:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5v0c7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiVE6PN+dBA/5URLlqoQMGsHpGlgKFcCQ/3uLrguf0HSLanyAesnnMgY62Q2fNlbytDvqNv/mxmSA7Dh8+LEEuCHVSNjm0Hco+XosUGAfT/Me3Hu3tGcVlvX0OsaI6o/DhALSszlO+U7/Q0cwjEUBlYsO6bKIOJmxMXx4iaY9a00SraPc+1eVoTs5uu6LuCMvpDsisftX9zI+9Y0CbLVYW6AF6p3O1WJlmpMrvvh0xXDLAbPLnBQAN+kQRQfEhEEDX2lelWH9XA2DSVc9XVxOwjeNMHKmDRH+rtSNMcbVa094sKaHdZmMPw64VN3iVaebaZY4z4VzVo+AOdbYmclgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZdfQ1Ak+A0VZmuvr+alP7UHvl8QgMI3mtzVcCgnFps=;
 b=kwE+ANB66I1S1qduCUf2jcebnXev1r2N1M5pqdweI9Ib4frRkalgaKe7Kws5H3eSL+LL0vQsCqq5oeOEu4NDSaYci/3V7/q/2cwm1YaluOdUfiIUbyBhK4DhJTlLqn6ekkhN49aVP4MyAMNch3V1dvI7uPoDzMfSLo358aUziaJCEnhWjkDWQDW9SFioS+PM6kAH18ZKclMTe2pNiLpyPorktmQjE5+6oagRuA7ChYVIGXCP4z0jFspVReUoso20w5CO36BAdQtYLVFXkIoJvvUCQ0czf7fy+oXJWJW4t7N3Ic4mAhrR+XBlH2lSgKq45JkU7YaZzDpuiLFgxRU18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZdfQ1Ak+A0VZmuvr+alP7UHvl8QgMI3mtzVcCgnFps=;
 b=AGG4cDML0gKf8BbM9FbTWVtV1/mrGkSClMAyz2klCyoCHuJ3jDPytBOGvAr5CyiOJOV+KlXQrdx3DoMjP4KU2zrck9A/huEqAEbRiDjNYDs5vpbWbl5XILahX+tehiit2zdnVM3h+2bOgrEdqnG6JmL0Ii+riw5UtwDF1IenklU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB5547.namprd10.prod.outlook.com (2603:10b6:510:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Thu, 29 Aug
 2024 11:30:44 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 11:30:43 +0000
Date: Thu, 29 Aug 2024 12:30:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Xingyu Li <xli399@ucr.edu>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: BUG: WARNING in free_pgtables
Message-ID: <e50f9da1-521d-46ae-9e12-d82c4c093223@lucifer.local>
References: <CALAgD-5kt+F6S1aAwRhKMKb0KwFGzfJCWyHguotEvJGBBBvFkA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-5kt+F6S1aAwRhKMKb0KwFGzfJCWyHguotEvJGBBBvFkA@mail.gmail.com>
X-ClientProxiedBy: LNXP123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: 8794ad33-b897-4b90-dd69-08dcc81e0500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rECbB880OVQLX+c9iRVYW0WaNvG29NzxrJazXbNq0Au6zG/9UpHUl1xV3BWf?=
 =?us-ascii?Q?gHcRJfIJM/noDtQ3fSTNOkCd4m74kjd5PuYxyvpqAq3Lh6KAuopRN/q0eFOB?=
 =?us-ascii?Q?gpdN+91OoWKISO5Xz4fcnr1ixWOAK2vStvzt1oJb+Z3ntnIXpehGpn+49GTZ?=
 =?us-ascii?Q?boTlPfQpxoPv1QgPEj+zRc4fFJWLWRBQlWABSjUYKASmaQvPG+n4vZ54yjzh?=
 =?us-ascii?Q?9JtIkNmQcscdcZiO4GKoC4SMrW3I+BrgTP4dxQy8ZVOyVG7Af5zC+azNN7w/?=
 =?us-ascii?Q?nH/0/bidBMtcCOn+AB28rvoFjvo2qvvrSjB432CF1JWKwCgfo1uzI74FVtSS?=
 =?us-ascii?Q?vpZ2o5A+o3pQHTnqj4htX/NwYNyEfdGC3XFKp5wcCpSZbcHsB76ZJpHLomKp?=
 =?us-ascii?Q?XRcepq06CMMyw8QxeAKb5AUBVNWXt62yIMKT6MbB0ko4614ty27rMO0oLkOh?=
 =?us-ascii?Q?LYOMc+O8NWCh/IGyxQl+9OX9NsGW8/HPKMqjkhGxWF/k1ngFQymWbl6EojnQ?=
 =?us-ascii?Q?TlMAADzcaPvGh9Kz86FBb99W0KsmKzcPZG+0fGm5yrBhR0+WG68mXJQtlqqw?=
 =?us-ascii?Q?9G/FYGRpsas5lWGSrxOa2LuSxVgLWK/LqrdAAhNEjIPAlDKeUmmr0Ds+kIa4?=
 =?us-ascii?Q?34/tNVyCK1hd8/6ibykhkQ0+RHvWtb5prOClMMrJzU0ilMpkDddAOupQo+zY?=
 =?us-ascii?Q?ryHUtk/9n4D+ZHWfCZ412sRcqGKOpWKKIjH8pAdeIXnKQIB11Kd+oQh43e8G?=
 =?us-ascii?Q?dVgNz/7+lUTLhI3UHXxUba9wdRLs+y7r0siqRdouScvOA+Xq2woeP1yqM97e?=
 =?us-ascii?Q?sycxgZ3RpjJld/39Qruo7UEry7QT3/ja/Tbhe40JnWX8vREOU/4QSTIcz3FE?=
 =?us-ascii?Q?ZPFiO4uyU6BjNUoccWazMciUCkNMS7aBgHxofHuSZmEGhYU8rsOm00+vUxWq?=
 =?us-ascii?Q?N0Y7FzyM/9T2aOOS2YndL6ei2SCvUTg6AzWLBL32AjBkFe/Ws1kfe+u4U8d3?=
 =?us-ascii?Q?DQcdh00ig1XfVRO/Likzr9rMMlICkdF8vdRP7AmwKLcZf7aPfX4HTS1yt+lm?=
 =?us-ascii?Q?8t5fLqf8u7kOfS1fEKyaD+Wz8byAh/9wTqGv1Crnh9LwxR3kuhMzS70/W4iY?=
 =?us-ascii?Q?ZnfQU+N/bn/bCilJjaH5N7EDlYaLr0THKrkPeJO6oCLaMxF1x8zilXsP+DBh?=
 =?us-ascii?Q?csoDnrcwn34ZUFkPiZszmJjh4sGHKUi93ozFJxCKq11Es2bwDNqLbsEocBK4?=
 =?us-ascii?Q?1XdEGevKCYrWoeTFRwDGAmii8+IBEkMRtTJSCUCF7om9y4d7LW0BIDcuqHoH?=
 =?us-ascii?Q?g3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8XmKKSgvy7EmMY1sXI0nuaFg4xsy2muvfm92PLf5tOQ5D+Ge5x9/iVOmovt?=
 =?us-ascii?Q?Bvgl4j6ZzHou8/Qi7AdOoISbC45YOGVULL6dV41Img2c4KN0Vgqu7GQlx2sI?=
 =?us-ascii?Q?kTu1wZChHtP9yVz5RTpVd5KXOcaRyNFIcbI6m84qaxs140FUv5dabvAlbx6L?=
 =?us-ascii?Q?Or4XTwBoXLWvsmuAd3tnrvHvssFGetBpYMVza5Cg46DifpkFBYGZj/9jSYp0?=
 =?us-ascii?Q?QvnkNvG9vPsvkLOF887zOuC5WsnvuLp0NznH8Wvnfil9tLKcgAq6Am4W3IYd?=
 =?us-ascii?Q?L/mzuaweFOrBWPUf0dlx1aUQgH6VR2WLEagmycnSWjTqkOGVmjzebBAim/h4?=
 =?us-ascii?Q?4VqEnCpgFTVRcboRunYlHmIyNsqu8+KsGndaEfXcY8ea75LrdplYfIu3QHST?=
 =?us-ascii?Q?35NjvQdGAzMA7/BWkp7FW7XdGEo/MjSfXtgfdMdGDXtG+euTH8d4TS7yQgs2?=
 =?us-ascii?Q?qhwVAg0ziXd46E3JUbbm1OmmCKzX1IckMRGlowwKk/JCnPPZ9USDN3qeoSIB?=
 =?us-ascii?Q?cuN+MJ8TqA6MGN3A+G/DopZvRVoqAxpGKmDIvl400xCMyeGJ8wX6MLi/gc6+?=
 =?us-ascii?Q?dUODu1s89T+KzXm9ph6sur20JvIrUFLqsH1yQyEaGE3bIjNYOFp2Q8CuGzIL?=
 =?us-ascii?Q?6tmEJwT1ofejsfP6naMYVf8GD68bTbemQAH+pifiK1OUZ/RrWHHnl1lsTg2T?=
 =?us-ascii?Q?t6LYNod/BcyIKEuQfuy6ZlALPbeRus2rga2c3IwekDX1/WYJJR7BBOudfj5u?=
 =?us-ascii?Q?c8Mybv50LCE+LTR5P4d0jrgcOb/FK7Vr6g8BIQU8dCidQZf9t4e+ZCoSS9AD?=
 =?us-ascii?Q?fY3ICxoljwgnksbRirMoBXcZqnwA7YtEb2UWnVkH2Mrh3mQbS5uy7ToWdoPg?=
 =?us-ascii?Q?GHEgYNzJbKyCxWHzIP8czqxy3J2iXT1muZSgEyCVv+eMRYuYD8QpRjM7Hbey?=
 =?us-ascii?Q?duKbYpwzh+xdYUKLgmAEuFDkjgd3pQUnkjwKLvld3fwCUsU9hGw0LJPgvUaz?=
 =?us-ascii?Q?UEFsjmXQB6ehktjh/3X6KUHhcuh5M5PB+PnfmjQG/txaoxjWuwyZPhvXQNsA?=
 =?us-ascii?Q?bH0L25+/JLphfBkCsjns5BL8NMe3JixF4dyuLJ1IX7NQRKlKGvjf0Q4/Bgf1?=
 =?us-ascii?Q?0kysDxHp+Moc9t/lLVAAza/xwps5JbM7gu5s49i6Ce06QOn/BgwmGeY9OlYZ?=
 =?us-ascii?Q?1qCmVSidCM/y7otlEHnV1gmhgx+T5ixxrOxrL5Fwwg6VWmYwgpOxud3s9UPl?=
 =?us-ascii?Q?KsvDs2Ya0stMGDU9UJONLIOxSFfFqb78Vzh/egqoyjWtJXHcr8or5QVqBTyv?=
 =?us-ascii?Q?CiGRjvtXQW7Po0/v5kE1+u8012fJms+Y4c77PiS23ptfGReVOmopphnUbcZ1?=
 =?us-ascii?Q?7SfJWdle5sVfRlJ4T4TpNMqes6gZcPChDZZFN38BPt0HUeNcZUf15rKmMCKd?=
 =?us-ascii?Q?2+djR8TkGT0FiioeB320UFYnRQyCXBP51Kv7/TlrbbEO2NloDkfD1FesjSfG?=
 =?us-ascii?Q?bbL+kHL+dra4Jzc7Hj7VAIySH4ucm5MWWuVXlDkt+5B2IrcNHyeoRgPSLV9i?=
 =?us-ascii?Q?AMfTqQfKs8r8GXjHq4qr32Zn+EiB1vvVmAg4eodekhLvw2wkNzIG2w1I6oPR?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8sID5v0J/n9eQyjKJ7Uee5KFJI6uhDJifUA5Mjlq0ZqL/nshdxf+OIYSZkia63qEQiKRhuPCLBIjAx0dUUpY3pZ/l46xD3NVKoyFodSnOwf6ry6nsuWTdoOCfMbCZ6D6DqP3dWQNiBV5k5GEanPgXjJtmcdN6a9t5dFA9Loch9X6UvBZ95gdCin3h5OYWCOGPawnW2cQbg3vzRIteAl1ehH5OOln0b+t1zz+HevJTlZLASrXR4nAbT4wlaEphqVBW8Ug0IZ0pzoJqdoeq0RSs4zKDzxZ+UCzhWRIboU91DJLe0Kxc5gi9qlO9F+aiKczmAytD+2e7QNSSTIjgwFNDdTnHoKVx0GsDiTby3Rn9GbI5LuwufikQFe93C1xpvA2AqwBEZKiTtDcUHxf1p/tSNSalTmo6wKMeebxKVJytpj5uSRrorFs7p2f1y6ywWSh0k79V7B/CPValWmOSt9qXL4YQMBIro33YRCyueiP7m7+jNl+ioTMU1Fl1UGqeLBiNSswzNYvPOkxCNdXBygbkQej0tAykCEfREHwhBWiyf4oWhPM8LyQwBTzGK01ysDx/O+YCSOU0n+lT95Jqecpl9wH2ATT2+I/wrLmxwbZ0+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8794ad33-b897-4b90-dd69-08dcc81e0500
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 11:30:43.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcpNNSrINkA2Y5gcPxM+JrVV6d0OReyZUkwUzGYndvGBNGNP7j47vJED7vFc8aQYrmLYCFXy+3crfkTFYBy5uTmWpaejvhOdG6g06SYFHoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=896
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290083
X-Proofpoint-ORIG-GUID: LtRsezUvyFsUCNEZMjwUOek4S24WouCT
X-Proofpoint-GUID: LtRsezUvyFsUCNEZMjwUOek4S24WouCT

On Wed, Aug 28, 2024 at 02:37:04PM GMT, Xingyu Li wrote:
> Hi,
>
> We found a bug in Linux 6.10 using syzkaller. It is possibly a  logic bug.

These lines are actually a bit offset for 6.10..

> The reprodcuer is
> https://gist.github.com/freexxxyyy/5f0c95e95e1bc0fb681e504114b61de8

Again, this doesn't repro for me. And the call stack suggests this doesn't
occur in the repro but on a process exit.

>
> The bug report is:
>
> WARNING: CPU: 0 PID: 8053 at include/linux/rwsem.h:203

This is:

	lockdep_assert_held_write(sem);

So presumably lockdep is on here (be good to get .config, full dmesg).

> mmap_assert_write_locked include/linux/mmap_lock.h:70 [inline]

This is:

rwsem_assert_held_write(&mm->mmap_lock);

> WARNING: CPU: 0 PID: 8053 at include/linux/rwsem.h:203
> __is_vma_write_locked include/linux/mm.h:714 [inline]

Should be 715? Guess inlined, but problematic line seems to be:

mmap_assert_write_locked(vma->vm_mm);

> WARNING: CPU: 0 PID: 8053 at include/linux/rwsem.h:203 vma_start_write
> include/linux/mm.h:733 [inline]
> WARNING: CPU: 0 PID: 8053 at include/linux/rwsem.h:203
> free_pgtables+0x4df/0xbb0 mm/memory.c:403
> Modules linked in:
> CPU: 0 PID: 8053 Comm: syz-executor107 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:rwsem_assert_held_write include/linux/rwsem.h:203 [inline]
> RIP: 0010:mmap_assert_write_locked include/linux/mmap_lock.h:70 [inline]
> RIP: 0010:__is_vma_write_locked include/linux/mm.h:714 [inline]
> RIP: 0010:vma_start_write include/linux/mm.h:733 [inline]
> RIP: 0010:free_pgtables+0x4df/0xbb0 mm/memory.c:403
> Code: 04 00 4d 85 e4 0f 84 86 03 00 00 e8 3b 46 b6 ff 4d 89 ee 4d 89
> e5 49 bc 00 00 00 00 00 fc ff df e9 86 fd ff ff e8 21 46 b6 ff <0f> 0b
> e9 b8 fe ff ff 48 c7 c1 6c 91 24 8f 80 e1 07 80 c1 03 38 c1
> RSP: 0018:ffffc9000ac7f748 EFLAGS: 00010293
> RAX: ffffffff81db0b3f RBX: ffff88801d8cbe98 RCX: ffff888021fa1e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff81db09ea R09: ffffffff8aed5df0
> R10: 0000000000000004 R11: ffff888021fa1e00 R12: ffff88802ce66ba0
> R13: ffff88801d8cbe88 R14: ffff88802ce66aa8 R15: 1ffff11003b197d1
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff0448ce6b0 CR3: 00000000244bc000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  exit_mmap+0x435/0xa20 mm/mmap.c:3352

This is

	free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS,
		      USER_PGTABLES_CEILING, true);

But on line 3349 we have:

	mmap_write_lock(mm);

None of the calls before free_pgtables() unlock this lock so that's super
weird. I'm not sure how this could possibly happen?

>  __mmput+0x114/0x3b0 kernel/fork.c:1346
>  exit_mm+0x207/0x2e0 kernel/exit.c:567
>  do_exit+0x996/0x2560 kernel/exit.c:863
>  do_group_exit+0x1fd/0x2b0 kernel/exit.c:1025
>  get_signal+0x1697/0x1730 kernel/signal.c:2909
>  arch_do_signal_or_restart+0x92/0x7f0 arch/x86/kernel/signal.c:310

OK so this is exit on a signal... so not the repro? Or when the repro was
killed?

>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x95/0x280 kernel/entry/common.c:218
>  do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7fb06353406d
> Code: Unable to access opcode bytes at 0x7fb063534043.
> RSP: 002b:00007fb0634d10c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: 0000000000000002 RBX: 00007fb0635c92e8 RCX: 00007fb06353406d
> RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000004
> RBP: 00007fb0635c92e0 R08: 00007fb0634d1640 R09: 0000000000000000
> R10: 00007fb0634d1640 R11: 0000000000000246 R12: 00007fb0635c92ec
> R13: 0000000000000000 R14: 00007fb0634f67c0 R15: 00007fb0634b1000
>  </TASK>
>
>
> --
> Yours sincerely,
> Xingyu

