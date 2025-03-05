Return-Path: <linux-kernel+bounces-546129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C671AA4F6B5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47CEA7A37C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97CB1C8621;
	Wed,  5 Mar 2025 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8fmIL9G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pjTat7dP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7843AB7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153965; cv=fail; b=cJUpdoNkmthqxbsBgcPDBxlfeDQDcZm6Yk2FC7R2/9+CI2BwY8j25vNcBc4pUGEcIRU5blQcQGFfehiN8aQqMZ07dWsOL6d0RpF3534N/lwyCBPeljZEK01xpGERCimKqofy/fF/9+dytS3ndKnqkPOmonDoKoAkCtZdvWfQ9cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153965; c=relaxed/simple;
	bh=fS7BjWopT+1d8SuuFUyYOZwdyQ+vBiWZyo3iIYxwdSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bm2gBJHQRuyu6uu3tjEZ811e1ghoxWRCTpbjqnshIxO8FGKE1KxIwYvUVmA+uM18lWHPObhvZyga3t+hA2wvxHDS75K3hIqGIzsrv4EFEEF8mno+RHJ6+rYnx/ZvczppTw3zWWo0a5/r53aoFhe3DecnStKXRVE4S8uaGEgz/+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m8fmIL9G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pjTat7dP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5255Mghp004421;
	Wed, 5 Mar 2025 05:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=HIJfNs6TRgDpfFz970
	86QaL/zRjq0mezMZG3RT8yB3s=; b=m8fmIL9GwQYY5/qNXyRXTMRCoGtMa6LmTb
	5sgg4CuWfO3M+GLj3orxh2GRKHHJwqhdI8nlgFqJ0fqFJ9RmsNzBiWMtV3qEtcxO
	gadaQ608JzGsHY1GMNoUe1aP5B+1yrUGrIE7H6jeIaXBhsm0uquN7jOXu9YUGuGM
	uEM0g+RCgUDnjzG0bu23lEV3Blaqa2vlNc0CWsKLeWtbNDpHFHHjyV4kv+FzZl/c
	3eXmMyKC/Af4BPciyvM2LZxevPD+oq51mhhaY2StTq8UnuHso7qzB/RVvbFxNwV8
	6jECQhMN4K29neS+yjmM4ghwIziP/QRXncTJZiEfPVi6JuurDxfA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub76rsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:52:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52540T0A000326;
	Wed, 5 Mar 2025 05:52:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpamt48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aaq0zcXTJuRQiB9XbXSAivOAFoXyVz68hsmOwsxsv25WQlfDvPIs5VxAq8kJg9YqyMnHScgdpAZzEibTHPeKTGGuKb8brXORByjd3puPX98MeNIpOy4g9Lsb2tw1yd2tu3SlbqtEMkW1sB/LYc1Fh2DvpRS1bnz7YKf8crOdPzH2aXBNdc9zE5p6CFCWHtNcQh7PJVJbVzB+GJSmT02cRp4rKNYaGe5X3v3UCgER8IqLwhxCvWTKuwtaohW+3anoJ8HYK+s9+vbCzGVWFqykh/oYuSDMqz5li8AlFlsxKZYfYJ99Ca+X7PhhFKWTMt9B/tYY7NqUsyW3+9x8eHl49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIJfNs6TRgDpfFz97086QaL/zRjq0mezMZG3RT8yB3s=;
 b=biKU5ZKxiI7NusrxW8BVTPmWqWsTXym68FnPGiaWWoIT7lgxQYQ05sRjD7Crk+r+kD/sKw3h1Yak3pWCq6MC7+j2Qn0NePHEzUxKsspnJU+JusShsTkJwjljoWtnSYSIbYA4IA9W2MJfXRiOtaDCP2eX4tghKdBJp37bBXIh6l1iZSyIAZzwdhx1S6vMEcMNQ8/paiHStqkNLcGr0VI99EjYMzO/9MVpHWD/gIXJpA6uKy8Bz7Q/7mdFDh9ckDRTXks1BY8zJC+ZDW7dG+NYaWJAsoQhrBbQGbnvTKyfNiRzVDqItL8AOKS9yCyluZTKxDdo/dlvhzlifwAEtgcYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIJfNs6TRgDpfFz97086QaL/zRjq0mezMZG3RT8yB3s=;
 b=pjTat7dPvSdLVbXDUNBC+7qxtCkzcoabAQTeho9soWa2HdM2t7m3D1UWQfyujdapImieKA3qinAATQLbzIbcEKQFZ6ne2DhxXrVTNsjCM0JJcD8D2ykKSD/N7rJAG9UlM/a/Xu5SCJ8njtYPAIcw81fkrVj1uILSFqdrA2+ervU=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB6073.namprd10.prod.outlook.com (2603:10b6:208:3af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:52:28 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 05:52:28 +0000
Date: Wed, 5 Mar 2025 05:52:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mm/mremap: initial refactor of move_vma()
Message-ID: <6ea7dd50-6367-4c1e-878b-1d9b86ab4ff1@lucifer.local>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <b4e64684d6ac753d5a66c0da0da5f4b94d033859.1740911247.git.lorenzo.stoakes@oracle.com>
 <Z8d0d9N26JBGwi8N@google.com>
 <20250304151556.635d9041a7ca36f1960fe664@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304151556.635d9041a7ca36f1960fe664@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0137.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 547bce0d-bff3-497f-7b06-08dd5ba9e970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+AKzuvtqEYOfX0GrVB/Ocw/EzN6PTpFTMJaHmeD+hAloYKUQRR8AKmuvWO13?=
 =?us-ascii?Q?WSv2dy4QBkphWKnl0YWscj5S/8g71qWpYkVrQ4ZUvBQdXe/kE3ucJw5DBk1i?=
 =?us-ascii?Q?zVTN44BECu4ftGzifEYDVC3mrqBS3diskxkO7AjxdylZnVrLQB+EoivcNatV?=
 =?us-ascii?Q?XX6Rx/Xrn0AYGDoob5lM2m9XJiCg3Ht2m0bT+mU1CbZZQ4fFdUwXq5uetK6j?=
 =?us-ascii?Q?iUYPBILj3dSswGYDOjGNhhVyWbImQnWLZVWqbpG1xJ5fWpZkwldleUK0dbfA?=
 =?us-ascii?Q?WIle0wqx+b0ZQEHiX+A4sBSyIE13nzspDmzX9Q2kCHX+94SHWRM/+NSsGuxI?=
 =?us-ascii?Q?UkJTThM//8GJmKbXEHmum9vb2fF6ry544yZ3dFL4jGq00VfwywUTao+wWreE?=
 =?us-ascii?Q?I+CexatVvQfJ007P5ubJN47Yykh2bCltrbJEKFdALeMoHlh6QyiZxt2dU8Tb?=
 =?us-ascii?Q?b/6LYJe/ALT0ziuobsh+C2lUlSVma5IVDgXqhxIsnHi/7R8pzqVg8OBtDchr?=
 =?us-ascii?Q?MsGUVW0AZER6p6cibRUsOb7nim7P1RCAt2TAPL7Lrrdj38mUoxwmGci6eO2R?=
 =?us-ascii?Q?CxJDWj6sFckGhkXNT2vdrdHE4GnJhlvrOtx2ey42cA5RUpxQ2YC2ZiWeo8Vx?=
 =?us-ascii?Q?b5HzxTArVkHKXfOlCEXS+ndu4ilRJZjihDk2bmu0tu3q8n4PZo7y0XQc0pCO?=
 =?us-ascii?Q?xxu7PoFY6S2u6MYhC/VjdLwRV9t28gxaWOWHg3GQjX/2MdKXSU3SEut32JZy?=
 =?us-ascii?Q?XRDUoGPQPnJEWjq3qD6H40QRZ6Fy+EsvFrPTUaSb95zdxHaU8pSUN6woBVys?=
 =?us-ascii?Q?K18Hsz85VotHYnV5yvjocBkF1E5oEogsj6C5v92Allr18gd6lNWm7JXTCgsY?=
 =?us-ascii?Q?fNo6OgR6/bSDfjmln/OizjJpm4V7HavqH9H28uZqDV1SGa12Wk8PqCI7LF1s?=
 =?us-ascii?Q?J711W+1ZIlJUyFNlcD0gaed8h1y+OiJtmQH59mSn1SqctSe/PgFn1/PFtYF/?=
 =?us-ascii?Q?kHYWmh26ycl+QTLenKpMl9X7Wcfsc4T6teRNU7FMI6r9rymti63SZT59CsLA?=
 =?us-ascii?Q?/f3flWm8jQzHy2CbGFPin/KNIbOtc1IKDIL1LEW06+N1TngX1b95sl12HOjP?=
 =?us-ascii?Q?34IlTYaZSY0Ooi06xBlLkWtXgY1iW4vjDxcCKcJXRvyY8vuviMIXeLJRo3xd?=
 =?us-ascii?Q?AEA0lP/U4wz/78qAuX9ko3bSfzOVnPaSRx4aEQxnNuPm9pIM6XEfOGnuQzso?=
 =?us-ascii?Q?YT3oHnBWczOO6s7ntiFFnppP/0OWfr9+ifHcfh6rAfAprwDDvNOPLjezOwdk?=
 =?us-ascii?Q?I8vYO/qgYl17bbDPZdcryaX4j+Yc2Uhvs7EqW8FxYp6tgz8xzvYvy6Xlvx2j?=
 =?us-ascii?Q?+tHZ0/FnJT1SfCGZHa8L0fejZ+4C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MUc5mDRrr6LdhZmdJSycMcqD03tpKh32DhUg+OfIBbwR01OlQYDqAwUjg4gb?=
 =?us-ascii?Q?VT2YIOxKFqQNrAFA9RwJ7WpfEp7WEbt1dQBq57hyKIxm9NebCsyGwl6cTNjr?=
 =?us-ascii?Q?6Q/FAXd5pJbJx79Lk1EjYycx33eaQxWFTpu8WcJArg0zkPWpOIdCIvyCqZ2c?=
 =?us-ascii?Q?ja7+lO8IHeTdnLxnjVmrp7Fb52VWl/tUDlGNLlcgdMGph26cricHqeTF1RUo?=
 =?us-ascii?Q?YbIrZOs3Q7dr4/JoFqtqws1j49UT5peFncapq+Sp3PCqN4enrBmGiJ9IC4Wi?=
 =?us-ascii?Q?PRyr2spEnLn5cRwk0jpkoKgbI3Xc39HdwpKwAf+8A1DLLHd4hM1Ji0uWqOdb?=
 =?us-ascii?Q?vj9iKoIyo3EErYKlPPOAX0tr05dGrLniJaf2zLJjJ3lwuvov6sXvoX0dVwNR?=
 =?us-ascii?Q?enQS+6sqfJW0DJ9pix0wPLoGilv0aK/yQCXhiw3PL899n2hY+pd3Db7P4D22?=
 =?us-ascii?Q?OrVXFNW6OZTKnHrKShjSe1NEuJ/M10WQAdZtVYeoLHU4wIIZbtlRlt91EGQO?=
 =?us-ascii?Q?DzijNq8J6VLeKOFrn0LQ6BsfcHR/Jy/X0XrCQrvZnm88YLUXBueoLxBWTiF2?=
 =?us-ascii?Q?71p57zGzqj/kHhFk5+Kyl7T8/k37hoV8bmXwFfrmKjkAoZj6Bt8EUwG1vH2N?=
 =?us-ascii?Q?dZsBqwDJ6aTygs2m7csVnHzMcPDxiW4XxK64Ok+JY9Bn6o6cunlG0254hYnN?=
 =?us-ascii?Q?cBgvzJGhBiX+iyLd1gn30PoF/bkW/faG7qLaKdV8gq4Q0NK12QqC7eLyjhj2?=
 =?us-ascii?Q?jHtWwfrT7jc50AsWOcfZJ3WrwXyLtnwclBGxPfLIpUAyI+q+BiVNOjt+mRVi?=
 =?us-ascii?Q?hlshwvnJuVcH7iyw2IPFt7ecJrsCTtQtlwEFg2N+rknrZVU7Y22Oiq4fRqZt?=
 =?us-ascii?Q?p9nevwoo8JZAJVn84BLFo3c+D0nTCtCs2Tn6Kx4TieV83DacooX64rchksY4?=
 =?us-ascii?Q?EIryU02C/XvaivvBqJOqrcWlcsHTw9KToNA00nA1yNMmPKuBK4OS52e+h2oY?=
 =?us-ascii?Q?uPVlPSI2WjZrS42kUH55aC6gYhkTqCzcYrypUFLdrmkUhbOXdwBghBc0fpZT?=
 =?us-ascii?Q?qjTnPcMxDTKCA5UAkUOYwfsBdD2ivUvsiYrsAes9f3AJkHb7+u4EMOLkpdJm?=
 =?us-ascii?Q?rOwzaEnYw6Bnkls5nmj7dyNqHy+0RXrCu/KOi/LN1FT/fByHMxapaiJAS4uK?=
 =?us-ascii?Q?lB2Z4D+mv8+nX+Lx/HdApgb9/JR0Lcuao54OHu76oBBw6vwlg96893dKlzCh?=
 =?us-ascii?Q?6cwWzRkd4AciwYiwoiB2H14kuIjSmNi5JrzAiUh2yXLadl2QeCIVzFGY2uGC?=
 =?us-ascii?Q?d3JxYW5Cmf0mBj403yLu8fdrOVz5lPhaoDXS19NbscNl680nfVLdQgAWMgfi?=
 =?us-ascii?Q?knpIRgMQXTsLzz+aGJk0CeoE/db9OdDybH6N9lNhUBfiBbExiKqOlwBjyUAl?=
 =?us-ascii?Q?ApkTsS6GNP4ozNQViuhttfumdNTRWo1SIJGIvlca1qTa9eJsJTKDpoIT3cUm?=
 =?us-ascii?Q?EPR+eBaGwnQxGiRlH12+JiFTwpDPUj91Ck33OPWPCAaY0g3UDW0rv57unEus?=
 =?us-ascii?Q?NT7NoQJsStr4bORrM8BWecausQttFImgwRAtrZnpz8VLWW8MGPtqovWZV1JA?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BYMuSWQadyyfrWp5ok0S6Uz/4bYZkuqq6gWBUtZrLvRaTV/s0rI8vZwMGe/g6mdkDLixyPgxY5O+OW1EbtVI4M8qBrmLtH/es1ACqVOtz/QzwsWzce/nUaZ7kVuqY5awQvF2rdi1+Yq2CIOgad0CLLbA1aPYYJmx2u9PbqwgzE6xoQykYUylCgUPuymVXqERrhX9m41tt+K5aWbmyM5zPzyjvgRwpo8bitlwXWsePVPosD05UnGf3SF9QrUMMaTYXA09udBXrqP4T0rra+kl1zI7sQ0z2HhrGbedOKP0EEVwhxthaUi3MQmlNQFmj8gMR1fA6+jrV/GmnVrFCwGH72CPpzrXXX036q2WrMaG8LhOMo52yf4jRj7LIizuot6j6FV6h6qzqnGvI6k4SDI0OPQ3BzOJsHhTCYQw9b80KCq/1lNdUXpLs/H/ESoLAklB9TFYz8rM+rCRP/UvblR8l21ldlwChTTDy5RIEtDtnTUhGF7p6Gb8uMm46HgoXAO8BBVsiPPieR9VlbhOfvv05fYqNFbt1gCmAASZ60kcnF3Deb7GpjoRQ+EiEkfy3heBteYSFpgDGWbZSSrfThUHe+8CmzqzHmNkRYaJXoyS6YQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547bce0d-bff3-497f-7b06-08dd5ba9e970
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:52:28.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wrel+Ct8sj5fSSKV1ChhrYWiS4ypDaJA7k+QvANEPmJFhcckS7JhqZNgU2R7UJyWqoQiM5kT4LuF+Ue4PvsWlihURokfiRSRy2zUZqfPZA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050044
X-Proofpoint-GUID: Uf9wgtDlvmNeWLwrEGtZFsarDqNPCoal
X-Proofpoint-ORIG-GUID: Uf9wgtDlvmNeWLwrEGtZFsarDqNPCoal

On Tue, Mar 04, 2025 at 03:15:56PM -0800, Andrew Morton wrote:
> On Tue, 4 Mar 2025 21:45:27 +0000 Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
>
> > On Mon, Mar 03, 2025 at 11:08:34AM +0000, Lorenzo Stoakes wrote:
> > > Update move_vma() to use the threaded VRM object, de-duplicate code and
> > > separate into smaller functions to aid readability and debug-ability.
> > >
> > > This in turn allows further simplification of expand_vma() as we can simply
> > > thread VRM through the function.
> > >
> > > We also take the opportunity to abstract the account charging page count
> > > into the VRM in order that we can correctly thread this through the
> > > operation.
> > >
> > > We additionally do the same for tracking mm statistics - exec_vm, stack_vm,
> > > data_vm, and locked_vm.
> > >
> > > As part of this change, we slightly modify when locked pages statistics are
> > > counted for in mm_struct statistics. However this should cause no issues,
> > > as there is no chance of underflow, nor will any rlimit failures occur as a
> > > result.
> > >
> > > This is an intermediate step before a further refactoring of move_vma() in
> > > order to aid review.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > [..]
> > > +/*
> > > + * Perform checks  before attempting to write a VMA prior to it being
> > > + * moved.
> > > + */
> > > +static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
> > > +				   unsigned long *vm_flags_ptr)
> > > +{
> > > +	unsigned long err;
> >
> > I am getting a warning on mm-unstable because 'err' is sometimes used
> > uninitialized, I think here:
> >
> >         if (vma->vm_ops && vma->vm_ops->may_split) {
> >                 if (vma->vm_start != old_addr)
> >                         err = vma->vm_ops->may_split(vma, old_addr);
> >                 if (!err && vma->vm_end != old_addr + old_len)
> >                         err = vma->vm_ops->may_split(vma, old_addr + old_len);
> >                 if (err)
> >                         return err;
> >         }
>
> yep, thanks.  I added this:
>
> --- a/mm/mremap.c~mm-mremap-initial-refactor-of-move_vma-fix
> +++ a/mm/mremap.c
> @@ -892,7 +892,7 @@ static void vrm_stat_account(struct vma_
>  static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
>  				   unsigned long *vm_flags_ptr)
>  {
> -	unsigned long err;
> +	unsigned long err = 0;
>  	struct vm_area_struct *vma = vrm->vma;
>  	unsigned long old_addr = vrm->addr;
>  	unsigned long old_len = vrm->old_len;
> _
>

Thanks Andrew! Apologies guys, my bad. I don't know why this wasn't flagged
locally... :/

This fix looks correct!

