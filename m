Return-Path: <linux-kernel+bounces-541521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5312AA4BDD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBAF16A58C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2C1FAC5E;
	Mon,  3 Mar 2025 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QrBXgMAQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gQFjzAf0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DC1FAC29
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000157; cv=fail; b=ocBzqtR6CSUL1I6pZSFRS3bv67iyTpkpCZ3hTmQDUc6m6E8jc8h7Sa5Mm/DrtfUDVyteLH5AVXNrGQ+wvq4e7K4Qqxjjuzb8a9O4QC0RaZgK8nnzno+mCNzS2Y1iu08Um2YZXxz42qrhckcpiMQFNUeTl1Ptgq8pSSzaiSc1OtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000157; c=relaxed/simple;
	bh=50YZom3HaAhWV6dMavjOek78ussOjGJ/JxlBN730JIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3b591s8wovNk2VMXEfU0PfhYSm2GV0knESMOyeiP3seXoKSvFc64b8AyX+oGmjTyyieF2EruL7/Xem72x7Py0JlNgR337hntqPy8NEV6eOahSgDYIO3KmEEzx5YTTXcIIo4VJUvoNVPWAtqeWkSc7L/7OwT1EmcdcT2SPZdwTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QrBXgMAQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gQFjzAf0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237uDpT008103;
	Mon, 3 Mar 2025 11:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bIYkEwe9IxN3IrcpgG1lPRkBq/md1eyAzQ4D5Fqcm0M=; b=
	QrBXgMAQ0+rFTkroY9ksc2XIjKeSflCMoM06hQCNsSlFz3Bfo+sfiO7ws/sAh52V
	rnk3oz9Qgzhksud52L5XFIIpspE8V0CxLLClGnJkJJp4Weqw9op+rOV0zurZEvAh
	quYhBwQl3cPt6UEQdQNgc5WrlB7qkwzU+kXYzWBSRZXhmexegiBlUdze+h0Ye9jq
	RjDyTqxvqHC4p369rb3LaNcw2Yn8WxKrpsubULSg925wR7s2cFp0OoO3fhFVtgU3
	dHlpqzMV5h++E5sRcoQcJsHbp9A2oDLascEsmNCZPhinTg91KV4wglP4rlJecTPQ
	nPZocQtC6plDD4oFsySv/w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub72cvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:09:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5239IXXB003236;
	Mon, 3 Mar 2025 11:09:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7bfwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6JU53eJIx74iVzXFZiZGEIPRD0O35vzCuhFDBWAsCKNF2myDCtOH82vtrUc+mP1uETPCFCK/UeRgKOcsMKao8U2QNly1Gq/TXAz/aRr8PnpCn8FVdfJIZVgwpkE6iylphYpoCjDU2jwOqnCGtFyhHR+SUxm1WjBkt2vI6Lj/tRsv+K8H0bbe6m3mkXkuf+2X1wU0cTTOEjT1DQ7eDT8jpnEm0TZ1xSo9UTHea3Jlj2Rr+n//z/NYG3mR3kuQb5jw9czLaNloDtozzFFD+9lBp0twpcS/ez1T+W1n2pSTeuLk9iieTYodYFa1K10+IAFHLiR4A79MPPJJ653oSmujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIYkEwe9IxN3IrcpgG1lPRkBq/md1eyAzQ4D5Fqcm0M=;
 b=R25Ykwvon/jdo/F4/kPXRhyiWtjT4eiV0LjjY/W55VyKE+L5Jraia1bZmXVYMu+cHMD3+FQwRdJkB0Ft/N6/cXF7dWKgfJEQWAQajubeA3yviKQp+GU7ZLxV60awAcZFSJ8rBaEFgfzfRnNFKzTawx1xcvxpnjingjMuFfLKWd5K3gy2Re1ftgytPMmTOxLOmC1dmmnV9uS0k2MLZP9sEXjG9ZtZoovzU85PLfZJy+UXGyx89AedKc8ZZ8wRuugZNSVEMrKU2tHpUyIwL3UHj6UOC0vqHmHOUnv0XIpotHyzp7eQezP/UTVYDhvRN52GiZC65ivgxsRipjNN/kINzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIYkEwe9IxN3IrcpgG1lPRkBq/md1eyAzQ4D5Fqcm0M=;
 b=gQFjzAf0iUWaMG95ez4QJHVqms/8uMMC2jlyPSpFtWqSaWBMPNQPHnrYStAhoitB+v9IlJcOKNX8TDIEbGbAbjIwlcTZtwCAd8HqBYaiUwklxp7VfEScj+aIxbU3nn1Oa+IbycBqJEePVvMiWxcborwmsIMDzR6mxjgY4jfsqO4=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 11:09:00 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:09:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mm/mremap: refactor move_page_tables(), abstracting state
Date: Mon,  3 Mar 2025 11:08:36 +0000
Message-ID: <1afa8a1a40277aa4cfd595c50f5fa85ea3839813.1740911247.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b52be1-7ace-447b-c7eb-08dd5a43cca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T7Uco+fzPpWqvr342rfgpIg03729LVfoN6GAqPabKT5PRueaxuoLxrHHIQ4x?=
 =?us-ascii?Q?CHsDc/rQliOm3ryhA+NqShTjXzOEGQjx8Bv0GlH3Ml0KaKOo5RZTVb+0wUGH?=
 =?us-ascii?Q?GcNSDZesB7xoPBFwp81p0GmmVjneYGYqG5iqpBUg/GCuL4LkEX7ut3K6sgrU?=
 =?us-ascii?Q?+P91xQJ4z31WayN+R9i1OGAD9Gj9iKkouUxfMBayEzZbsK8Qg9tuanUK40Nv?=
 =?us-ascii?Q?1WsXuQ5+GHkHgfFKwnF1MbVuIrcMG7g5YqokQRC5FX8AKgu5oWyhtdlQ5d9s?=
 =?us-ascii?Q?Ds5GiSCfs8WXsugYsNjhahc36Z2IJnOWKhDMP9u36eYxANOy5ULqwZ2btWLJ?=
 =?us-ascii?Q?3zEocMvf/3NgH8cj5PAxA5olh5D0OgvJGXdz1xweXexU7jkWApJdEK755KEj?=
 =?us-ascii?Q?nphvWHhiYC1lUCU9m9DJiyq6atBrRJJOrz7/23/JNu0QSsUgmUrQu90NlDq3?=
 =?us-ascii?Q?HJdNGN4e9JBUWW440vV628oT4ZXY7hh4cpD5uw9PGDXpxIVDyRMeazmZsEw0?=
 =?us-ascii?Q?1rRbfgVS69oUl/ZRIQLQ0bCf7w7E0lFnqFeD0CvS9UU+8zrrXJ5i/o3vqeX8?=
 =?us-ascii?Q?F63kVVugRvYp+NkTlLMsUsdAV2aQP7BRiL26kPAiwjrQUxQ1NC7vu6LYC4Ru?=
 =?us-ascii?Q?JdPDMsAhevFI9snDOPKY8+VZHDxT5JNqSsj3nnRTE4Kn0OAixiQ4dUJFU118?=
 =?us-ascii?Q?1uwmocc6JisnwDZP7Q0Q4V/dP3dGV/Fq3cjOG5q0q0YkRDJJBDAH5c4O30PZ?=
 =?us-ascii?Q?rkNdRpuPnFv+YvBAMH2m2Nt6IkxTqqPsBhLzf+NI1kVduHZYWxinvewM+YLR?=
 =?us-ascii?Q?c7PiZoiHc27ojfGJJz39y9vFNQeSO24lj2UrryHCCYIFw9FIgyeTPAL7K2Fq?=
 =?us-ascii?Q?3adqgZHRa1CauYLj7RTScX4avR/Z0n1Fb2W5vFsOs4z1f4+2awoqVNbBEhZg?=
 =?us-ascii?Q?Oo375wAstxIm8Z8R5MUJZ8NPWc40yyuKB6wi2AuHjYLn0GkZYD7KTsHwU2Aa?=
 =?us-ascii?Q?z1pVq9czhY9LTIjC4k0XzsJ+yfD2tpKrYd5EjP/ZV3gX+o1R1NiYq2Pvgodj?=
 =?us-ascii?Q?JKppZiehNgFmDmoqPf87qPDqMzbsy05J0U5Z/6J4eOVV4IfkIoB+KQ5qPhss?=
 =?us-ascii?Q?G+z1izHS1TeiDd7ZEEBZtrzRprdhItOwiyk5WRndWhatqRNByOliquwrj0qO?=
 =?us-ascii?Q?6avvxeh1nbAwKQ0NsKlRnNZnnoFn3EyurEjNEJS0VrXU39jbZgjPfJ2/mbds?=
 =?us-ascii?Q?20UPXAVHHPbyxxzTUo1lt6hsfXH2fqLjasB3CLOtCb1zwrNhg7g5CKiYKJ6v?=
 =?us-ascii?Q?5a0tPA3CSfUzY4eix1JKx0cz3wsPb/pUxPHvpv7uBnZCS3iFONpN8xhF4UzW?=
 =?us-ascii?Q?nqXU2j8/7iOxAzVD01OU2izKAZtb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4SxdX5hj0yoptzcD81jfRYt/jJ21ntJ1mfbUB0y8tBSjTmx1AM2DFXeEgbhZ?=
 =?us-ascii?Q?Wc9uFwU0ghK3rab7ynrvSk4pwNyv55GUaNIElMRcO7FwZ+V9WIe0PXGEu11d?=
 =?us-ascii?Q?wMpBjEr41oGEXXqRA6FeXZKlMz1cQc+y+9mKxxcw7JylAu38wvDFHXyfcKnZ?=
 =?us-ascii?Q?k00TlANbQmgmbIT23Nq+ABURewX+wQkM0YffYBncrDCPJMdxseqaaRRv7Yvo?=
 =?us-ascii?Q?h5IdlKkvl1QjGUJhnqMh4LSRWxaSGvPwRI6OG9L/9gD+srZUmHVXTS4FwS0C?=
 =?us-ascii?Q?u60Yne2Xe92UnsrnSfZUzTefbmV0r87mUQwT4mL8fxLUgSUzZFrXrh++cnEa?=
 =?us-ascii?Q?KIFS5m/C34UxkAO3OM2uRCQg/kL5eq03AHOwkvCrCk3xSp/exKNTLeOXN6pR?=
 =?us-ascii?Q?y22z2bLi6FtNRTmNxor/OKq6rqDK2fFXC0oVuQfRZOHUGoWMBaX1bxrCUJq4?=
 =?us-ascii?Q?8cD8FkRi2nfeh7d0VDfG1SJ0zOD375YIMd/lPGEccKxhWxywazFhv3i5Owid?=
 =?us-ascii?Q?qJIHAM5DYrAzFxLIRROM15nbss3y/WRb95LMmZFzvNvfCuKavK1ErWRPn7iO?=
 =?us-ascii?Q?Uq3Ay0O3E9z0Lm9J4UasUNDDGL6rGpmzUjPHllBzr1N11YG7Bnr3WlSO9mLM?=
 =?us-ascii?Q?yw+uO/6iwXzCkdbdLKxqbd1ZPM4RWT6TdHNrPjfT3uk0jU/oXmeV43hf8wBO?=
 =?us-ascii?Q?rpYhwH7X8lzbPUDTFc7FFlv6XIM+Q8gf56SuTvodiVWnh7NJ5HXnNI6ccCje?=
 =?us-ascii?Q?F4Z7IbL0TyEPwJ4LQdRdugpLvL2F6vw10vzBG0pFEuAWRRYbWE3SmE3z9aPo?=
 =?us-ascii?Q?U4ugp/YKBTQJ4AGll08xy0zRiz7FquXIxfUW5aMG1QSCs0Ulyjsx8MJYlHXO?=
 =?us-ascii?Q?9Egl0XBb0aTkIxMZkKN5kmqxtOWEbU9Ug2gxZMooYOJ6H9SWE3FYfV8fCUik?=
 =?us-ascii?Q?dowOCKNSHhkJCCZFbrzM2J9fPGa7AZ4frN2z9FVQhfwxeTOMxkceyzRu3F/u?=
 =?us-ascii?Q?SR1vCIWBsxku47sEoUyFeInjr3QVyy7GB0dVhwchL0kKp5KaXmqdwZjjkkCG?=
 =?us-ascii?Q?jLHqfSqaMzo+eIqtV3VAEO0om0TPNFtA911mvUA2VP1FujdfRWLGQihGKopV?=
 =?us-ascii?Q?BxYqf/uzB3rWXuCn+fnM0Z1+dUYNMq8hobqyfrrxeotJxd8Sv6QiIDPQLSjy?=
 =?us-ascii?Q?3PviqYOP+PS0b+9aubKKfrlIt7+jKa96JDX/+f5xXxDy2AYDh9QuvdfbO8MF?=
 =?us-ascii?Q?n3Ao5A0XI82l2ZWDBeJWcpLpewm86WLv1F5Ge/bb1phIeVeRRz/o4bZylbaD?=
 =?us-ascii?Q?2nDfTMH4Ymb44Sz/j5P7Ymm0zd9djtdAcAny4LZ61SS98h6+YBdbkm3SbdoG?=
 =?us-ascii?Q?OXnntiqGXHkpQ6tmA0F0aUmaK0FJpl96zRsFC+z+61E+d1/ljZaFOhf7ta7w?=
 =?us-ascii?Q?rja5qnIiGSdIzaUAEUWs1w7r4/PM8paXGNdgO3Vka/WGKzdexQ+X9IOqdW96?=
 =?us-ascii?Q?OLFoC+WuTqC4GNy86KF6c8zBKtrF37jSneKbqTbiRJOzngbpVzESkRvnpnhX?=
 =?us-ascii?Q?pN3PQZYHvIzGxU8vWKo5VhfijB1BdqUZ8++BURAmlOOQkJWi+yom4M9XZEd9?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hUipud32XFnTxz92qr7uX/dEhcrmh/MjvU00yjgmCPpACqYyvE1pDM2FXA4WrAJsS+3HCyElapnF4wD92frMxDJcSbLkUBJ44u7m5MYlR+zeIYnro92qyix1VHmpVYj+SPcXfMh8XXNoS5GovZ//+6HaRd7+HqQszoRrtJk+VOT9VEjSsR25bQg3IhOQ4DOinRMApHoZ814jce2nyAz4kJqvWzlaRFnrSHFWwbxvvGNNWZy1O18iiwhAa3FHgxcummMx6yEOov1sxn1WgmX95KfdaeG6uuyK/FeDZDqRTeMLAiIORgIK8uHQf7fs+T5TdyLybBqYI56Yu/qyzYd12LuGtLXZCxahWFZiiDeLNRqYbmRCyMiECpAuahHlMbRCtX7104DYJoEZ12/vBArHfnbW1hKSdZhZW/G+hrw2gpgcP7Vb+TmqAhSy03CQ6cPTENbgwyCpUWBZPwuYOTp4+p/vVkEdEgv1I/NaJtAcxOKe3QkvSjKwjRkI00/lPjLT+11q7dlACtZYvDmNz4DLOGicf9IRkxo7XXlVNzxNXs5wObiJlAv7AyfFLwi/BGL+bOCVIoKpn2YKi3dP9qpYrdLEUt5yaQtjwLszptJCf9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b52be1-7ace-447b-c7eb-08dd5a43cca3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:09:00.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdwLobELdaRC9fWOrWY4VPei2qSZ/VLOxuNQaB2g1dxYW+jKKzLdJkDysrhNJ0px3xxJZIJ8kUtJIE9DtK//ak60rihL8c9nCYMwquzLlLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030086
X-Proofpoint-GUID: rOzcFZKG7zbL_sCpvPHYpxKueLY-PR_a
X-Proofpoint-ORIG-GUID: rOzcFZKG7zbL_sCpvPHYpxKueLY-PR_a

A lot of state is threaded throughout the page table moving logic within
the mremap code, including boolean values which control behaviour
specifically in regard to whether rmap locks need be held over the
operation and whether the VMA belongs to a temporary stack being moved by
move_arg_pages() (and consequently, relocate_vma_down()).

As we already transmit state throughout this operation, it is neater and
more readable to maintain a small state object. We do so in the form of
pagetable_move_control.

In addition, this allows us to update parameters within the state as we
manipulate things, for instance with regard to the page table realignment
logic.

In future I want to add additional functionality to the page table logic,
so this is an additional motivation for making it easier to do so.

This patch changes move_page_tables() to accept a pointer to a
pagetable_move_control struct, and performs changes at this level
only. Further page table logic will be updated in a subsequent patch.

We additionally also take the opportunity to add significant comments
describing the address realignment logic to make it abundantly clear what
is going on in this code.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  46 ++++++++++++--
 mm/mmap.c     |   5 +-
 mm/mremap.c   | 172 ++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 171 insertions(+), 52 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2e5310d47bf8..5d9894e5adfc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -24,6 +24,47 @@
 
 struct folio_batch;
 
+/*
+ * Maintains state across a page table move. The operation assumes both source
+ * and destination VMAs already exist and are specified by the user.
+ *
+ * Partial moves are permitted, but:
+ *      from_vma->vm_start <= from_addr < from_vma->vm_end - len
+ *      to_vma->vm_start <= to_addr < to_vma->vm_end - len
+ *
+ * Must be maintained.
+ *
+ * mmap lock must be held in write and VMA write locks must be held on any VMA
+ * that is visible.
+ *
+ * Use the PAGETABLE_MOVE() macro to initialise this struct.
+ *
+ * NOTE: The page table move is affected by reading from [old_addr, old_end),
+ * and old_addr may be updated for better page table alignment, so len_in
+ * represents the length of the range being copied as specified by the user.
+ */
+struct pagetable_move_control {
+	struct vm_area_struct *old; /* Source VMA. */
+	struct vm_area_struct *new; /* Destination VMA. */
+	unsigned long old_addr; /* Address from which the move begins. */
+	unsigned long old_end; /* Exclusive address at which old range ends. */
+	unsigned long new_addr; /* Address to move page tables to. */
+	unsigned long len_in; /* Bytes to remap specified by user. */
+
+	bool need_rmap_locks; /* Do rmap locks need to be taken? */
+	bool for_stack; /* Is this an early temp stack being moved? */
+};
+
+#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_)	\
+	struct pagetable_move_control name = {				\
+		.old = old_,						\
+		.new = new_,						\
+		.old_addr = old_addr_,					\
+		.old_end = (old_addr_) + (len_),			\
+		.new_addr = new_addr_,					\
+		.len_in = len_,						\
+	}
+
 /*
  * The set of flags that only affect watermark checking and reclaim
  * behaviour. This is used by the MM to obey the caller constraints
@@ -1527,10 +1568,7 @@ extern struct list_lru shadow_nodes;
 } while (0)
 
 /* mremap.c */
-unsigned long move_page_tables(struct vm_area_struct *vma,
-	unsigned long old_addr, struct vm_area_struct *new_vma,
-	unsigned long new_addr, unsigned long len,
-	bool need_rmap_locks, bool for_stack);
+unsigned long move_page_tables(struct pagetable_move_control *pmc);
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 void accept_page(struct page *page);
diff --git a/mm/mmap.c b/mm/mmap.c
index 15d6cd7cc845..efcc4ca7500d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1694,6 +1694,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
+	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
 
 	BUG_ON(new_start > new_end);
 
@@ -1716,8 +1717,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	 * move the page tables downwards, on failure we rely on
 	 * process cleanup to remove whatever mess we made.
 	 */
-	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false, true))
+	pmc.for_stack = true;
+	if (length != move_page_tables(&pmc))
 		return -ENOMEM;
 
 	tlb_gather_mmu(&tlb, mm);
diff --git a/mm/mremap.c b/mm/mremap.c
index 1ceabd0d9634..fdbe35de5e5a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -579,8 +579,9 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
  * the VMA that is created to span the source and destination of the move,
  * so we make an exception for it.
  */
-static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
-			    unsigned long mask, bool for_stack)
+static bool can_align_down(struct pagetable_move_control *pmc,
+			   struct vm_area_struct *vma, unsigned long addr_to_align,
+			   unsigned long mask)
 {
 	unsigned long addr_masked = addr_to_align & mask;
 
@@ -589,11 +590,11 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 	 * of the corresponding VMA, we can't align down or we will destroy part
 	 * of the current mapping.
 	 */
-	if (!for_stack && vma->vm_start != addr_to_align)
+	if (!pmc->for_stack && vma->vm_start != addr_to_align)
 		return false;
 
 	/* In the stack case we explicitly permit in-VMA alignment. */
-	if (for_stack && addr_masked >= vma->vm_start)
+	if (pmc->for_stack && addr_masked >= vma->vm_start)
 		return true;
 
 	/*
@@ -603,54 +604,131 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 	return find_vma_intersection(vma->vm_mm, addr_masked, vma->vm_start) == NULL;
 }
 
-/* Opportunistically realign to specified boundary for faster copy. */
-static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
-			     unsigned long *new_addr, struct vm_area_struct *new_vma,
-			     unsigned long mask, bool for_stack)
+/*
+ * Determine if are in fact able to realign for efficiency to a higher page
+ * table boundary.
+ */
+static bool can_realign_addr(struct pagetable_move_control *pmc,
+			     unsigned long pagetable_mask)
 {
+	unsigned long align_mask = ~pagetable_mask;
+	unsigned long old_align = pmc->old_addr & align_mask;
+	unsigned long new_align = pmc->new_addr & align_mask;
+	unsigned long pagetable_size = align_mask + 1;
+	unsigned long old_align_next = pagetable_size - old_align;
+
+	/*
+	 * We don't want to have to go hunting for VMAs from the end of the old
+	 * VMA to the next page table boundary, also we want to make sure the
+	 * operation is wortwhile.
+	 *
+	 * So ensure that we only perform this realignment if the end of the
+	 * range being copied from is at least page table aligned:
+	 *
+	 * boundary                        boundary
+	 *    .<- old_align ->                .
+	 *    .              |----------------.-----------|
+	 *    .              |          vma   .           |
+	 *    .              |----------------.-----------|
+	 *    .              <----------------.----------->
+	 *    .                          len_in
+	 *    <------------------------------->
+	 *    .         pagetable_size        .
+	 *    .              <---------------->
+	 *    .                old_align_next .
+	 */
+	if (pmc->len_in < old_align_next)
+		return false;
+
 	/* Skip if the addresses are already aligned. */
-	if ((*old_addr & ~mask) == 0)
-		return;
+	if (old_align == 0)
+		return false;
 
 	/* Only realign if the new and old addresses are mutually aligned. */
-	if ((*old_addr & ~mask) != (*new_addr & ~mask))
-		return;
+	if (old_align != new_align)
+		return false;
 
 	/* Ensure realignment doesn't cause overlap with existing mappings. */
-	if (!can_align_down(old_vma, *old_addr, mask, for_stack) ||
-	    !can_align_down(new_vma, *new_addr, mask, for_stack))
+	if (!can_align_down(pmc, pmc->old, pmc->old_addr, pagetable_mask) ||
+	    !can_align_down(pmc, pmc->new, pmc->new_addr, pagetable_mask))
+		return false;
+
+	return true;
+}
+
+/*
+ * Opportunistically realign to specified boundary for faster copy.
+ *
+ * Consider an mremap() of a VMA with page table boundaries as below, and no
+ * preceding VMAs from the lower page table boundary to the start of the VMA,
+ * with the end of the range being at least page table aligned:
+ *
+ *   boundary                        boundary
+ *      .              |----------------.-----------|
+ *      .              |          vma   .           |
+ *      .              |----------------.-----------|
+ *      .         pmc->old_addr         .      pmc->old_end
+ *      .              <---------------------------->
+ *      .                  move these page tables
+ *
+ * If we proceed with moving page tables in this scenario, we will have a lot of
+ * work to do traversing old page tables and establishing new ones in the
+ * destination across multiple lower level page tables.
+ *
+ * The idea here is simply to align pmc->old_addr, pmc->new_addr down to the
+ * page table boundary, so we can simply copy a single page table entry for the
+ * aligned portion of the VMA instead:
+ *
+ *   boundary                        boundary
+ *      .              |----------------.-----------|
+ *      .              |          vma   .           |
+ *      .              |----------------.-----------|
+ * pmc->old_addr                        .      pmc->old_end
+ *      <------------------------------------------->
+ *      .           move these page tables
+ */
+static void try_realign_addr(struct pagetable_move_control *pmc,
+			     unsigned long pagetable_mask)
+{
+
+	if (!can_realign_addr(pmc, pagetable_mask))
 		return;
 
-	*old_addr = *old_addr & mask;
-	*new_addr = *new_addr & mask;
+	/*
+	 * Simply align to page table boundaries. Note that we do NOT update the
+	 * pmc->old_end value, and since the move_page_tables() operation spans
+	 * from [old_addr, old_end) (offsetting new_addr as it is performed),
+	 * this simply changes the start of the copy, not the end.
+	 */
+	pmc->old_addr &= pagetable_mask;
+	pmc->new_addr &= pagetable_mask;
 }
 
-unsigned long move_page_tables(struct vm_area_struct *vma,
-		unsigned long old_addr, struct vm_area_struct *new_vma,
-		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks, bool for_stack)
+unsigned long move_page_tables(struct pagetable_move_control *pmc)
 {
 	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
 	pud_t *old_pud, *new_pud;
+	unsigned long old_addr, new_addr;
+	struct vm_area_struct *vma = pmc->old;
 
-	if (!len)
+	if (!pmc->len_in)
 		return 0;
 
-	old_end = old_addr + len;
-
 	if (is_vm_hugetlb_page(vma))
-		return move_hugetlb_page_tables(vma, new_vma, old_addr,
-						new_addr, len);
+		return move_hugetlb_page_tables(pmc->old, pmc->new, pmc->old_addr,
+						pmc->new_addr, pmc->len_in);
 
 	/*
 	 * If possible, realign addresses to PMD boundary for faster copy.
 	 * Only realign if the mremap copying hits a PMD boundary.
 	 */
-	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
-		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK,
-				 for_stack);
+	try_realign_addr(pmc, PMD_MASK);
+	/* These may have been changed. */
+	old_addr = pmc->old_addr;
+	new_addr = pmc->new_addr;
+	old_end = pmc->old_end;
 
 	flush_cache_range(vma, old_addr, old_end);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
@@ -674,12 +752,11 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
-					       old_pud, new_pud, need_rmap_locks);
+					       old_pud, new_pud, pmc->need_rmap_locks);
 				/* We ignore and continue on error? */
 				continue;
 			}
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
-
 			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
 					   old_pud, new_pud, true))
 				continue;
@@ -697,7 +774,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		    pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, need_rmap_locks))
+					   old_pmd, new_pmd, pmc->need_rmap_locks))
 				continue;
 			split_huge_pmd(vma, old_pmd, old_addr);
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
@@ -712,10 +789,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		}
 		if (pmd_none(*old_pmd))
 			continue;
-		if (pte_alloc(new_vma->vm_mm, new_pmd))
+		if (pte_alloc(pmc->new->vm_mm, new_pmd))
 			break;
 		if (move_ptes(vma, old_pmd, old_addr, old_addr + extent,
-			      new_vma, new_pmd, new_addr, need_rmap_locks) < 0)
+			      pmc->new, new_pmd, new_addr, pmc->need_rmap_locks) < 0)
 			goto again;
 	}
 
@@ -725,10 +802,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	 * Prevent negative return values when {old,new}_addr was realigned
 	 * but we broke out of the above loop for the first PMD itself.
 	 */
-	if (old_addr < old_end - len)
+	if (old_addr < old_end - pmc->len_in)
 		return 0;
 
-	return len + old_addr - old_end;	/* how much done */
+	return pmc->len_in + old_addr - old_end;	/* how much done */
 }
 
 /* Set vrm->delta to the difference in VMA size specified by user. */
@@ -1044,37 +1121,40 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 	unsigned long internal_pgoff = internal_offset >> PAGE_SHIFT;
 	unsigned long new_pgoff = vrm->vma->vm_pgoff + internal_pgoff;
 	unsigned long moved_len;
-	bool need_rmap_locks;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = vrm->vma;
 	struct vm_area_struct *new_vma;
 	int err = 0;
+	PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
 
-	new_vma = copy_vma(&vrm->vma, vrm->new_addr, vrm->new_len, new_pgoff,
-			   &need_rmap_locks);
+	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
+			   &pmc.need_rmap_locks);
 	if (!new_vma) {
 		vrm_uncharge(vrm);
 		*new_vma_ptr = NULL;
 		return -ENOMEM;
 	}
-	vma = vrm->vma;
+	vrm->vma = vma;
+	pmc.old = vma;
+	pmc.new = new_vma;
 
-	moved_len = move_page_tables(vma, vrm->addr, new_vma,
-				     vrm->new_addr, vrm->old_len,
-				     need_rmap_locks, /* for_stack= */false);
+	moved_len = move_page_tables(&pmc);
 	if (moved_len < vrm->old_len)
 		err = -ENOMEM;
 	else if (vma->vm_ops && vma->vm_ops->mremap)
 		err = vma->vm_ops->mremap(new_vma);
 
 	if (unlikely(err)) {
+		PAGETABLE_MOVE(pmc_revert, new_vma, vma, vrm->new_addr,
+			       vrm->addr, moved_len);
+
 		/*
 		 * On error, move entries back from new area to old,
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
 		 */
-		move_page_tables(new_vma, vrm->new_addr, vma, vrm->addr,
-				 moved_len, /* need_rmap_locks = */true,
-				 /* for_stack= */false);
+		pmc_revert.need_rmap_locks = true;
+		move_page_tables(&pmc_revert);
+
 		vrm->vma = new_vma;
 		vrm->old_len = vrm->new_len;
 		vrm->addr = vrm->new_addr;
-- 
2.48.1


