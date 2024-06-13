Return-Path: <linux-kernel+bounces-213393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F300907487
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB671C23A75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF474145B1D;
	Thu, 13 Jun 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CG0ZxdTi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="neMbH1yK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5775145B1F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287374; cv=fail; b=YQWLxBKE7SsJVDQlwtso1XYFZb9bmnFreJ+kRMeQecjvtBdzBvyiW+1NsjHvOB4/ZWHsoNwdqbFLh0SOY9L085SJmXz1lHp7k1M/gkZrKZDcqc9sXFodCb+NZaxo5FDB9oaxT7Bd+B41gjiaqDK7Hli+u2YQf5JbozuQc3NoN+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287374; c=relaxed/simple;
	bh=kZCzUYUlwHCda+7Idq/JDLqA9l3orEgQStKvCKnZjT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MCRTYcnszuLrbmU0/YZ/oxQJrQ7jQtYCXscxfhf6+Oeo5gpkdM6GbKOu7TpeP9sagOueXj8wnZQAqGmg9uVGIok8LHA3oOD33cyE20/+CK7XDGjCZJgtEoiGd8cUk5FcYjyqwSAHgbqxwH5gdLcmhbqyEEaHQ8BWtPabOTpjEis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CG0ZxdTi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=neMbH1yK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DBtRkr011444;
	Thu, 13 Jun 2024 14:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=+qnUlffserPo+FX
	AwYhyR8RHFMRiAj412cROXXhUSyg=; b=CG0ZxdTi6ywSBub9RQ+xzO2522K3Wx6
	DeavErvnbnteWwAqzAG+0M0nI0FejpKjOevWj9zpyRhyIi6Lja40EE+K478pwK2D
	xJvDo3PbSvXOTfcdi01LCqs3Id1ngZ4dF9jNp9Ak435/DqW6omdym0Hva/WJeJC3
	lvOR45fEkdgS48f6TDbIN1NAcZBXUDC1M3C3Uc0reKqGC9icdXZ0GPmAK3Em2ocU
	lXaRYwq5gJc8/fFyn/O6qPIqsB7Ns07W/UnpzKemWAbXB1D1nkzj47OFkvQQMNaM
	T9rquopQUIrumHMjKonj3H4ZLXaAG7HEdnMzBhQLWd5M9HdGrt2eczQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mhn0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 14:02:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DDLt2Z036551;
	Thu, 13 Jun 2024 14:02:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ynce09y1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 14:02:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYnyjBcAbVUx4Mr22ACZOl564ijCw7wCNc7gm/NhnMFj/ugw0xCBbvnVra3BXnHMlBQg/sW9R6yT5+a71KGrAbEc/Ti5tXNj2xq6ep7jFLSTcyBATu6TevrWxlI6sBhl0Ad2b4uxiAqD8HGs4HNx44iqRY2O4CbPC5OAQURHKIVMnV73/knWdSUlNfZsi09ZopVDdFGNGcGJrraeIp2wX1Jz0a37YN8pCUr5rYsvoZXJJYT3gvOVThHUVnFwoIi2xsnuPCAJYXwzxy+MfWOr0nLGYKU6bGzFcyu/5qky6jFWVqO6aMIDdBQm6zY1feX4YXnU3MM4g1fdsXFlJKnP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qnUlffserPo+FXAwYhyR8RHFMRiAj412cROXXhUSyg=;
 b=i5vYr7HZrvAXq71Aj4lGyMwKqnaVC9oMhBXVlRcR2FlWFLUhqZe3lTcx9BCBWr/d8x36jbsQdgsPXbK1FGSxR60/g6pBhNQYjdKN4k17JeoZVxwnmHQZ1qHU98fICUeBUyGIv8ZLAMib2AGisQAV4JGGDSeZ4SdDsn5V0lDR52Da79oQmofRq3V4GyAPdhqAj9wlOjPNGrutbOW/B4y/CDUDfXuSq0infNoyZodB0QaC8Yp9W200KYb+7GOZQ6CW7WXHisP7FQd964FuCHrYLVgyuL9k1NXg1kxrL1K6wVu5QsfF1HXq/TP9gRG6aLK1nfVSgnWvWLi6dSmMFcm6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qnUlffserPo+FXAwYhyR8RHFMRiAj412cROXXhUSyg=;
 b=neMbH1yK0kTmZXTmxNmdInPC0/WoU0DvrG0NwIuF3VSHoKsQ88MMLVPQJDwlseg0eB/mp7vg43kdEaOcR7d9Wg8if4hVnADIYpChFvK4lP+Woc5+DbtsnPWTt9Mg83gL7Mk76ASCtzWxKH1u/5VVaQar+WQPERTilLzVPQdT7G4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 14:02:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 14:02:14 +0000
Date: Thu, 13 Jun 2024 10:02:11 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] maple_tree: modified return type of
 mas_wr_store_entry()
Message-ID: <4gv5fj26lpdhskj7u4fs42h6o3573ozsxcfqhvf44rfqef6v2y@c2rtba3wveu7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	JaeJoon Jung <rgbi3307@gmail.com>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20240606014656.7491-1-rgbi3307@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606014656.7491-1-rgbi3307@gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4bff3a-f315-48a7-875f-08dc8bb16d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nDUnK/TfxQOZv9YNEOzedbmRyPg2x1hzK6HIjNLFGbOvga0OlCubeCrPTnPS?=
 =?us-ascii?Q?dZo8vZ944z1t9pvJzqF1VzNiWIgZm0QmWgUssHz/7+tXcOCMQwQV14ntrbrS?=
 =?us-ascii?Q?Sn7JNaDF/gdiwvJp98DNKkPccMDdopSQtOESa9fHBXf5pxFDOXLLpUBT5Dt3?=
 =?us-ascii?Q?VkT6ZFbKVpA3LQ1vVHUlv5ej8aFl+DMILh7wovTY+Zw2QKNXlod3vq7IADtd?=
 =?us-ascii?Q?1E1YQ1esdqCPcZhgPWba+HENqYwXB4HVrdPb/VpofWAo/0AeBkmsChEUO1W9?=
 =?us-ascii?Q?iqXMEMB2oFMxFwrn9uxhyS+/I5yb8W8usXIKCmeQCXHZoADKZj9t2pF8VAVV?=
 =?us-ascii?Q?V5QNLZShz9IbFg+fM1vBnHJh+/3koTb+Ay9QxMuquR6xsreIFFtMu+Ihf+CA?=
 =?us-ascii?Q?tvm0jGyQm1r5cEkmKrtinzgWUerB9xuzmF9PN/otQT1jN28ncWGq72DY7OVD?=
 =?us-ascii?Q?PkVz6VJUcGWj9AgBkqsQNhTUpJAXDvALzUCquD0GgZE6ojigqCqEAKEEOM5O?=
 =?us-ascii?Q?DOqovSp4XcddIDrwNs5qLIB4V6nxmP9mLq4+ihkUfwfIxK8ZNfyY7DAw8wyg?=
 =?us-ascii?Q?hOC5sOuAnhbxAEhJfRlqe3zhvRL2oiKJ5WyPK3rQzgvtlFVzNM0DcCfmhleg?=
 =?us-ascii?Q?Tx714rg/oLpsvhVh9eYdeXQTw1P6oDfIbmdWjsTf2CtB7XpJH5Aaq8xbA+h4?=
 =?us-ascii?Q?nscBJXBMyOBWznqZwfo6vhpzK2QWp9TSuvNucNmJ9pyqJPt4x4pbbHUGPbM0?=
 =?us-ascii?Q?oe4JPQJN/noGNTaOpENc0w9BQiTCJuwnNFg3TZheMKuNqalLFNbMIwi3U6J4?=
 =?us-ascii?Q?sNT20DKRORDmccNZTg94Wqg0mOgehflU9Bg8/WiVYnqMWrakBAmiI2U/Petl?=
 =?us-ascii?Q?4flv45XYO1rW2N0Jd55x8iMLij8Ub6gpP7eta/fTK3ab9ivaPuclXRTP/YwT?=
 =?us-ascii?Q?tSGp2M6YKzA6j+DyCg99GSPabsVrjPi4uu0d3ajXbJmUtkbBCaGGIwaQCEFj?=
 =?us-ascii?Q?sTgtwjI5yqhtvejfnj+0OKgAFMtF08vD7JQ0tEd3wo+Q4oEcoobcIOnkBpoc?=
 =?us-ascii?Q?YiKqpbEXab97PCBiIIRqkCkZDm4py4FqjU4GGq4SRrYsQtYEfWoZPFeHcuCA?=
 =?us-ascii?Q?GnJSUthSi3g+/xMWxNnvPWpgPiJR/aRqtuSD2Kmna+VmuX/UdzTBnYYEVmPd?=
 =?us-ascii?Q?IFeo9aJogn8LLJoqi56mBSb/lnmzT7uuwoF5oLkHmepigeh5ImUodffQ+2IS?=
 =?us-ascii?Q?mEazQGjxP3suzlCfGUBO3A3ZvUeB2h7MLcrkwHGMOeM0AdkLkCqlcWdkDoNv?=
 =?us-ascii?Q?xoM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q9W0RlR0y6OF+P7knPrOghzURjgWBkA1TbAhQl+dpkhKo+WJhmKFn4FISEbs?=
 =?us-ascii?Q?XdTL6NTQ0wnOpkv19DXKPY7Rcgpvs8l591eORCxVy1+GmBEjEUFmRJSCYoNa?=
 =?us-ascii?Q?XqPEQuQjhAxyY0P/McjD3DAfyNHzzM2YNmUFn/hvVwIhhe7/Zw4y+DtksTqU?=
 =?us-ascii?Q?pfvn2Uwx7zGbKOm4fkHt3KnT1DoBdlTnIecu8k2qCUTKvuo0CH802OPm2cU1?=
 =?us-ascii?Q?bj7cyGjFG99DkOOhmq0BmtfF1bDeQI1EXNh9stQEc36xT3QraMBGEpPgAn3n?=
 =?us-ascii?Q?FoQdwQdi2m1CFCK8fBukTC+BMG/YWB0rrjdK1ke0cgCIr6BaCKOaj4q+Slt+?=
 =?us-ascii?Q?A+4rAaNppDHyk9Z7XmhE+dlTpKfIfV5US/43mFoumcx7wjh1q3l++bIZqFdI?=
 =?us-ascii?Q?94z3PqCCIPrnxk0P8EFVeD4qg6ZppOEexqZkbBdFquDfQUP6Usp/hhVK6iLC?=
 =?us-ascii?Q?Vit5SjqWzk6T9KoZmnxJzCSg0QKSUUkLtBA9IjRoLqNrs9cOHL2sNT+uUYDU?=
 =?us-ascii?Q?bQ6ZpeM5bYUeLGN1/Q9oIbNCTTqG90z7Z7tjBi1uB8qPv51ElTO+wagQWf7s?=
 =?us-ascii?Q?tc4u9+nwnA/gkQfmFgGDhyjitKIQr1OkqZ4tV9qPyypWKpva6tey81CLEpJR?=
 =?us-ascii?Q?2fhvjT/wm9xTvsNO3coglMhbL/MFFe/lSYT7narI5H6m8fQ8vJNjd7mPzfbg?=
 =?us-ascii?Q?xaXMC1XkX+DrMGjynoA6w5NuShuxhl8w8Rrws/XhFg4F/T6MaT/fRLyBDBca?=
 =?us-ascii?Q?fepmD6I7cZVwQ0IEsmkQT8vTWWWm3FM82T3LUbZcw/JX0huv57jzdM+wbzor?=
 =?us-ascii?Q?1QULAAo6xSxuk5T1RXvujSz88ZTI8HG0Tzv75VW4tI1VgT2K1PC2wqbIAYMF?=
 =?us-ascii?Q?fNPLMyINVc27nwvevHjP7/gWG3NKYqcOkhAChSrzOLQwixpha6/5lGbAZ9O9?=
 =?us-ascii?Q?vFHDj09p/IgsFuOyOWdu3PEBhmtytICYxw8Yrr8Au6opPNTxBu7J9IYsWZ/g?=
 =?us-ascii?Q?RpwZIcrmfEEog65nUeaQICQYaHCXgT531CwXAktM+CanChpyu1F8U3wUOMCs?=
 =?us-ascii?Q?JHzRUJ18vMK4AOI9e1v1W7BbGGO6oTpy+9nURIGltZvP2QrnvWuhm1Axm0p7?=
 =?us-ascii?Q?E/POi7FupY3J/kYkVs/z+lIHd/hGlJMEK0+qdjN5kZTZyWP3NMobtYkcY0xz?=
 =?us-ascii?Q?5fEq1+pDlZWypUPMJywKg/+uUU1e9PN18qevrrnmw/8yeynkH4X0X4Ui6Qar?=
 =?us-ascii?Q?WA0KnU8ouPQT3JAQk0iL2GfoNStral2N5CDkQWvnCEgRELGhEMiWLmdEIQBD?=
 =?us-ascii?Q?NeQxdMuFt3pTr3JbIYtWFJrsRMS5jDUC88TLjyOW+Qwzbg/BJk8d/QCzcLSr?=
 =?us-ascii?Q?Gkg0NtKSQzZEjbeOeTJkHhx1MmYckSTu5XuAaztU2Y1c8gEw4OdBxkKb0+JS?=
 =?us-ascii?Q?MlkDTSye2pZygwGIkwcKiXUueNULWzkwVZRb7WewoOi719/khy0ml793hGG+?=
 =?us-ascii?Q?FeR74dBHN3jUDLqJYcFnzdjOGlYhZJ7crvilHRTP57u0/upNtocR5cxWv/Pg?=
 =?us-ascii?Q?c7xMreaJ01dUq9e03dJfS1LoXTwn1caal9A+NXXP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o7cCumum9L9Ai0tJ07HRJhn4d6cN62hPYOBKKXLY+qICJrvBN1nYRdUF8eg5o36i7IaUOE8q++hNi3yZ0pX1UdxNx38FAHsQUdBzgOxNPMWPNDbceROW8jUB6lo2WzRJsLWnqmJ65psr5r2zIp4EbmhHnT/hhNv+ZlyOJYp8fupauYS26gZNkwO96NRIzzAE2p9I5GfOMXzJqmp2FlIMANdrAI0Q8xVE/vESyiup39vbGxPQDu4pc4fQ0jN3gYZsFD9waOO1F6C/LyBdU10bT+rOrUPaNEEg2Pg24wOhO69bE8wWvrFLYONbzWUYB79HXfA6CDd+CFpwWamrQkJP97CcHbX9Y/Mg3Wv7OfVdjEJfeCWfLjySb+rbItg0iPTJGWtG64vUKYpN9ZF5cK+gQMvi3tMruq/GAKLEg8q6Ju6BFZCPuS68yCnACfZegaFE7cB2vu0uNLkp+pw7bi0KhH0lAZUa97h/ybdQULCIeTHJJ6R2EiJCVQ8T3Wh04L9L+u8wWozz8ArIQ/PLEU/PCzo9nM+DQtL9+PDRThAqdU3ev8zA4sUoJplrBoOAPl2KRdOV1NCGHV4WSbaBGAksF0752myamJyVOYG7swGvxpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4bff3a-f315-48a7-875f-08dc8bb16d92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:02:14.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS4m0e0tmoBltwtGQw/aTK2QQoNe3iYgjjzL6tvkphS4g1jn0QjNEC5CA/lW2f3ZaAUlrvt4Jpa0rrWRTbcvjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_07,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406130102
X-Proofpoint-ORIG-GUID: OaYC81MBtSya12RoHqzgNxb4M-ikZli_
X-Proofpoint-GUID: OaYC81MBtSya12RoHqzgNxb4M-ikZli_

* JaeJoon Jung <rgbi3307@gmail.com> [240605 21:47]:
> Since the return value of mas_wr_store_entry() is not used,
> the return type can be changed to void.
> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>

Thanks, looks good!

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 2d7d27e6ae3c..aa3a5df15b8e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4203,31 +4203,28 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>   *
>   * Return: The contents that was stored at the index.
>   */
> -static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
> +static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>  
>  	wr_mas->content = mas_start(mas);
>  	if (mas_is_none(mas) || mas_is_ptr(mas)) {
>  		mas_store_root(mas, wr_mas->entry);
> -		return wr_mas->content;
> +		return;
>  	}
>  
>  	if (unlikely(!mas_wr_walk(wr_mas))) {
>  		mas_wr_spanning_store(wr_mas);
> -		return wr_mas->content;
> +		return;
>  	}
>  
>  	/* At this point, we are at the leaf node that needs to be altered. */
>  	mas_wr_end_piv(wr_mas);
>  	/* New root for a single pointer */
> -	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
> +	if (unlikely(!mas->index && mas->last == ULONG_MAX))
>  		mas_new_root(mas, wr_mas->entry);
> -		return wr_mas->content;
> -	}
> -
> -	mas_wr_modify(wr_mas);
> -	return wr_mas->content;
> +	else
> +		mas_wr_modify(wr_mas);
>  }
>  
>  /**
> -- 
> 2.17.1
> 

