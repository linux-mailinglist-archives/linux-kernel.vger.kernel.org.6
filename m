Return-Path: <linux-kernel+bounces-547662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB7A50C20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82DD165171
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEEB253340;
	Wed,  5 Mar 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q7bcZx4D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nQwYo4In"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E67255237
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204918; cv=fail; b=KnyDN/VveYD54DpjvMcnBx52gM10MW6I4SHbgvbNLUc75MfJUxI0aU3CdkkfKlKbnYfD7jSTYsVwmU/ceE0G0VsPVw1/xI8us8rmScMtnymcxceQ90egBJYDu/BfJpXyE8dmOsSkMkucbAmjbf7UczbGuhNTjvox2z/fvd5QDws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204918; c=relaxed/simple;
	bh=yNr2gutMjWf7ii8O3rn5VtQbtG4nq1gcs0EHciaJjNk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQJvQZO2QdyW7+XHSSvDAdTuD5CQeIE2u75ZgUEvKdiv8zhEZ8pgpVBYS8l11QzEB6gZblaLJLOMMvs0/sd1wlNnBC93/1id2H9vZSM6+1g0bH3H4AAwvWPjhxKn4FcugZFfBZcl8WXy6cNRpn/BKiAWqJ31GQigWkY1FRqXn1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q7bcZx4D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nQwYo4In; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMeBC019603;
	Wed, 5 Mar 2025 20:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wJwax1trbH3xbXZdEZ
	932roLN6bnO+xjFkUr25kxfBo=; b=Q7bcZx4DXOQHlV10iQ+J/lKNSo4TyfLEms
	kSS7vCA7k9KO9qsKlIZAQQqw0FPtlIw0gzSEK9/c9KvpVsRxg43mgXWJ93R+LL57
	UcddfvTmfSkQFjqmNKkkjeOxbOUjT6YtTlADBuhodH8zgNEFMvhekZbhI5frIhe4
	xwYuKScfv1EZEdjcBHGwQhVxUh74Yvo7bNkTQcMF8aH9f6cob2Oj8CQxjdSUZGkb
	Nn3Zr1vb2FcRmh3hVYV4cCcB4lzG6h4qgyhKaySQf/kn2mkyg3abVtAHbuCjrIZK
	WMlqIzr61akfwg0eaHdy9sRhi3XmlFSgKfpMBMUBeU6v0eDy8EoA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub78k0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 20:01:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525IoSwN040395;
	Wed, 5 Mar 2025 20:01:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rph6rhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 20:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEc3xqZYawF04lFaXXNVx0okWXzHfe976MzFzuSuy/XGo+KKMVOjQFTENlxFXW0DkUNl96v28uDDYgNsE5wdY2RGoK7ZdRDS+0TYmmU76G2WFLjxHUjviY1+aCi1VRMmeRLJe9Go9pCy69aQgM+c2wCK43GEhcpkwMqrqUEta/ogsetnVKhTSlPynpXhBCBSpXf5i3PuTF6wrSpLE2EFQpeclgQRvudwc/j7LM5bk/r2xQbgqFMlsBUZe5cGwnf7B+/yojuQw9xy0RPDBz1jc+n0JMsvLizNMiKeMx/6Y4kYGpUVYRrV+X3r9+PQCX+vGSySNdgxwGPpyhxo76/LZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJwax1trbH3xbXZdEZ932roLN6bnO+xjFkUr25kxfBo=;
 b=YmimiFqq10FTC2hiDT9l++6QoZKD+VixRHNVIfIo4BLcRVseGdVghuew2KEE94E4Zvu95Kyg8N+RNSB3D16co78cFiQd1UZ0Hs2DHGjTuWaZEqVhBL0z+iekrLork6/o7fo10v1oSjYchh/8tp4hxdRqhzBN2nsOV4uuYw03x7rGm/Hvm3J4gwD6E6gCZtvT/UbVyMegcXxZaxF/lpOXkXL2mj4IA4qD5EaYQAVrIz/1Zjjoh/PbjAAShJo88Ci5DR8zDseXPHwkcsCSgASsoFRRiY7oE39XnHbqizQCay5fe0dY86sTsneUYzi40bmOn4yxwNszyNVy0h9bj1HAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJwax1trbH3xbXZdEZ932roLN6bnO+xjFkUr25kxfBo=;
 b=nQwYo4InTG0cTEyNnbctPmyk7xliWw02jcll45JMEMU7lkFYiZa09S8WZe2LldbSTGTXzS2F4oLQ/duHAp+51DFJi/i1JmRdMX9QPU22oIB+7x/GcAcrXF3mjLjvm1hHy00yCSKnh4z08Z2m2ypI+NqXCd7sxmjvqr+ImnndS+E=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CY5PR10MB6012.namprd10.prod.outlook.com (2603:10b6:930:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 20:01:41 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 20:01:41 +0000
Date: Wed, 5 Mar 2025 20:01:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mm/mremap: initial refactor of move_vma()
Message-ID: <5973cdf5-3fd8-447a-83b9-bf4a735ae6e9@lucifer.local>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <b4e64684d6ac753d5a66c0da0da5f4b94d033859.1740911247.git.lorenzo.stoakes@oracle.com>
 <ovtjegskokdpz4gawasilhazfalrhgtgnoh6qxsjtbcenaiao5@glwldebq37in>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ovtjegskokdpz4gawasilhazfalrhgtgnoh6qxsjtbcenaiao5@glwldebq37in>
X-ClientProxiedBy: LO6P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::19) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CY5PR10MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: a4306000-8c34-4afe-866f-08dd5c208bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jZGWyGHX0/lAlo3PdSLVTh9OSwLiS558SzvdWq7KQCwjbPWecn5SJ+nSPXt2?=
 =?us-ascii?Q?9bdKQ8feKCleTXFItWmXx/39cgsHKygn2VNvMykIx9GiMAHIBH6j1EFsKpsB?=
 =?us-ascii?Q?fKMUEveZsNv4UIUYMUDIGxUxJK7CCE6YMhFiMaaICIi7uGuhCaIA+xORIS9q?=
 =?us-ascii?Q?pLzTxxQsu2cQaTZZTZRNBUvBrESEJqfJaPYGIueX/mBTzynpJLxX3qo7HV71?=
 =?us-ascii?Q?e3L8gpgY/9m32uA8lqiaRQxk7R5sZ1mNgi6YMSNolpTKHMfJ1reg2d2Y8r0F?=
 =?us-ascii?Q?yOtounN+vdPFUijc5Bd3+HbxUHpkzIvdfYT2YYaJ0c7FfWL8HD55p6uSYLjF?=
 =?us-ascii?Q?rUXEV3WMu6tvuyG/Sk/c1zpdUCVL2E7mwcyCCMPj4rzOzOPFlx+LfUuzPe/z?=
 =?us-ascii?Q?pgVBcl6jGg7ffEHp1pUzF4HNjinDaHJEMGjn+NbEG6Tu5lGYrBmYvhKe0bP7?=
 =?us-ascii?Q?B3TkN7OFeVK8lzK0K7VPuhmY297E/Ikbr6XngDozaOn+vN7WkWVB5G4hTg2k?=
 =?us-ascii?Q?QZxvhF14z3klZJykp/l8WuyARr3oNhehH8cthfWHYlAXhsicQZT/ebFHkZPH?=
 =?us-ascii?Q?tisKr3wefuVuZ8nN3u85BrO+WbuVTVfkLca/OG9Z8Kj+7InwNw4M1FzWZCCV?=
 =?us-ascii?Q?a9Lx0rWB/xmZBk/slk9fOA8mrVVXDdfKQRXIw+dESfR584fvK9gFJPwpd8hC?=
 =?us-ascii?Q?mwzcpdkuTarMXeGcNUIjQz4gpOf4sSdpCT0hpEcaXEaIyrtyUliV8ax/xZU4?=
 =?us-ascii?Q?sdM164HAo/CNoICoDpjL2pG2tkVP5XLGzEVYVQ8jb2H9HU1kUwLkALYljDto?=
 =?us-ascii?Q?5a+IzrVgPzJtziklZEZH8dTdwKmqM1MRdwgxfDJQuQspm7ohp6IT7CSTjI5q?=
 =?us-ascii?Q?T4munDK7GQrZuPzn1zH5hqn2B2+DZkNIM51G37sHi46c4hV4KjAWRrfb6lZq?=
 =?us-ascii?Q?9j768zPbVvUPQTonHXOjO/r1xu2RA+Quy+85uJZmRkIF1S/aFUEpv4rn3a62?=
 =?us-ascii?Q?6WGMBK/mJbLsW3AoCpkFqU3ZdYrwqXGhEUSTognlF7lPP5kKccwXQf7xpMLP?=
 =?us-ascii?Q?7CPaq68qbLZvUjbhdZ8aVQ89Mp41EzLwpDOm77lR/ucp887MGxyGwS88uZ1W?=
 =?us-ascii?Q?drJL0K2U/m1R0cWObjE1sE+OPDC70GKzjYx76gCV4gw6nzQkwi4hyX9pgRro?=
 =?us-ascii?Q?OZzd0Xm0Kc5UAutuj7jr3cr90ZmKnIlZf6TbT0udiQLbwVaqfc9h4PAQHUi6?=
 =?us-ascii?Q?ukXi5U/l6Bs0JYJz5t4cw4EgTHBZHKzS1UzqvrTTHsj8h/8YxnNXmvB/5DwY?=
 =?us-ascii?Q?HpH7g030ErQun4gtTEJNKIf/SNFsNNd/htBn3Jv5XkXYxRhDQEpLzpc0/c9+?=
 =?us-ascii?Q?3kbWEpo7zqmSPSNfRmavrslWE6Re?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pt6i+0EW9P1N4D/7z1NPNglsG4H+mHSL96GEy3vccIWIfbdm9akMGz3r09az?=
 =?us-ascii?Q?n1sdMGulYZBeSKF2j8RcHIdG48iG06EPf89PgQouVJq7P1Qi4OgxcUEwEpb/?=
 =?us-ascii?Q?izBpWYek28G9CnXDGBkiU3ilZ6Q99bXms0Oo2kIbEo6fD8pgguTkfsLF+pi3?=
 =?us-ascii?Q?3cKWmkPsc6CEn2+i5xw7b64Zb7uIyT8eXUY1Dvpkr6AYMBwEkPp4+/GzCrC5?=
 =?us-ascii?Q?3lY6jh1Gx3HnUtjaG0gBayLGVR8UHXTuwaF4JKkRLVFzP4gWlqB9tQzm3AQZ?=
 =?us-ascii?Q?4CWiPB9q6/+T7pZujGtbd0gTFJZWYPP1nRjeEorHwb9cGbAK5hKTz4/HZow7?=
 =?us-ascii?Q?Y69BprdDq7S+wT8LQep4j5lsmpFV4IVmDJ0Dpopys0PLKXYsGBlB4neJut4R?=
 =?us-ascii?Q?t+SpiTQh8F5qYAWTbFY9au89THTbOH+E3XESCniX8Ymv3oBTBstVhwKRvyMW?=
 =?us-ascii?Q?m9UA1MeteW0iSZcQknvM2fPUvrir27m/yJKlr8CN1YpVXRiGj3PTEQOt/MKN?=
 =?us-ascii?Q?hxpwjv7movW1yOyEUhVvl4B2wVKrE2hHniAY26kSmuHGiDh4T/OwX1XLJ4YI?=
 =?us-ascii?Q?EBlbBFusDXlF+AiHdUaJVU2kHXl+gzPBV0v0Up76duZ9e+vzGOZ6YI5oeLQ1?=
 =?us-ascii?Q?f3BRnA1v1fyj8fheQblUinIpjZ4CooGBhTIjs+ty1JY9ZEpjtb9fIA/Cu28K?=
 =?us-ascii?Q?snNfrzmibADQ8dEb3Cb2MSW7N1Zd3BIdLAPzQ4s2FI4dRIOMv3iDH8weDMz0?=
 =?us-ascii?Q?4NB4r8l+sUTpnjlMOzNzuDgmJ5ON3hfxEFNXfuNWLx/na9+4T2odfJP3QwFD?=
 =?us-ascii?Q?RCK2fVCeLeGL2Qyx5DWw8KCcx3hDwAm2XqJQZl0JMIivax1QKz8VPr04ZEZJ?=
 =?us-ascii?Q?cB5qsw7CgDMTGi7e2iHkNhgywSGC/5vp06Sn3ONUpJWUm0qsUu81O4P0XH10?=
 =?us-ascii?Q?O3+IQowpWk6l34uAZ45qj6lxIYlMfHjdDRFDc9Q3kV3zQ1RKe0BHS/geYAfU?=
 =?us-ascii?Q?JvAqoSgjl1A/ZZX3ObzWXMmtRYovFK+kZRKYP/GsZ/g5LAg14kBtubWrBme0?=
 =?us-ascii?Q?xNwN1A40fBwdz0w7Dh55SpDtZSxcbqjx482AwMSB1X0hDCkL3nPI3iab2bUd?=
 =?us-ascii?Q?nbNsdHV07TqfMgOMnsMBw7QFguEO5cEdaKXlAr/gBdt9SJwXvk9Wm54MFV8+?=
 =?us-ascii?Q?KhiAFn/CNkKUsKzp3h8hYjFvgOGjwQ28N5RyUXhhiAYpeU4Cqe+0x2Kgd/Oq?=
 =?us-ascii?Q?24d3wHEHOzZYOP3rlr4MR2wrz3Ul3ysfd+LN/AfUSDQP4PCYuJs0jQOgtTdO?=
 =?us-ascii?Q?X0YmGoLddCD3mX2qUbf2EubHn6klP0AJE7bOHUQYY1HX51yvYLJskbrBFl9g?=
 =?us-ascii?Q?8O4hNUB7cRS+ox7rvkVJVd8sb2W9+kfou+bkGQP3VkL6qKqF3v/kiC79weyG?=
 =?us-ascii?Q?KKLFOmFM0dt5/JR6AEjr8B+Ma5AkjNKwC+kXh64jx8c9AO+6zNxieEAQ0Tr/?=
 =?us-ascii?Q?Dq67LR7qUmesO+Sje435QK52xuxikRNh82X4dyKeA+aW7iDR8ruMbfTQvfHs?=
 =?us-ascii?Q?xV5/OIKIHyPv+TLwG1LcmEZJ/JPkTDACUIhZ79ecAa3Gis20SEkM3D7yBl5x?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eTJwSkLqYZCypHK25tuQSeKKWwgbxecVNm3SY1Yizj3z+YLOZzoivQTIeku2Do05LFB+X2kK6V3Rct4P/mN+Jf8rGT9UcFJFs9k3w7gNGNB5vNomyKJqsAu8vPzupWGZOyS/TLLNIBfj//NDpKIWjuFLtt5dpKHfZBBYOa6F3xYJhfE+jTacuhp6h8d7wimAMRTOHNl7Q5V7Kih9kRCRvAGe+oOj0zvzxM2kaGVXlF5UchaVmPfXmVieiQTAb1vho50bV8w8KH2KB3qWbW7bAgUdihr3q2nXEB10jS/66choKCqnS2qgpTjCuz2XfU4cb/RFyZVWnbCUHcZRf0Orx+SAozyZOyVkoIR/Ivpw7/pOcNwxz8vXj+P05C48KQuwc2snr9vBIJ8lLjjx+KVdvfsqVb8H9ldzU2jMbAobvjE7Mg1K3I8cgKVdodHsAGzEbRXtJhbKCpbdWOEXCInCQuCHGL1tKFFdFxziWPjpcxDwR0hqSwzUmUxepvjpQNs4QMaX1lUhCiXHNL7vIUzZRkj95Bl35f9wL574/SjPmGptXdLuG7a76hPvC//xLs8AnhUGP5HcWYU0D56Ou4lMUOf8rzvW54FBivbBPhts7jg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4306000-8c34-4afe-866f-08dd5c208bfe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:01:41.5898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUfCTYM8b5Gh1gVcx4hZB5mv8a6rdBW3shR9jMGgxZNNq4FhJgxb7UxqOIFapO/ftNQcojZkJvZxTgpeTF5c2qiUh678jkdTRoBNPiqSpEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050152
X-Proofpoint-GUID: 5eQy4ZvzBW-TrCMFYVT1J01ichUAQFl2
X-Proofpoint-ORIG-GUID: 5eQy4ZvzBW-TrCMFYVT1J01ichUAQFl2

On Wed, Mar 05, 2025 at 02:20:37PM -0500, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250303 06:08]:
> > Update move_vma() to use the threaded VRM object, de-duplicate code and
> > separate into smaller functions to aid readability and debug-ability.
> >
> > This in turn allows further simplification of expand_vma() as we can simply
> > thread VRM through the function.
> >
> > We also take the opportunity to abstract the account charging page count
> > into the VRM in order that we can correctly thread this through the
> > operation.
> >
> > We additionally do the same for tracking mm statistics - exec_vm, stack_vm,
> > data_vm, and locked_vm.
> >
> > As part of this change, we slightly modify when locked pages statistics are
> > counted for in mm_struct statistics. However this should cause no issues,
> > as there is no chance of underflow, nor will any rlimit failures occur as a
> > result.
> >
> > This is an intermediate step before a further refactoring of move_vma() in
> > order to aid review.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Thanks!

>
> > ---
> >  mm/mremap.c | 186 ++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 122 insertions(+), 64 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 7f0c71aa9bb9..fdbf5515fc44 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -67,6 +67,7 @@ struct vma_remap_struct {
> >  	bool locked; /* Was the VMA mlock()'d (has the VM_LOCKED flag set). */
> >  	enum mremap_operation remap_type; /* expand, shrink, etc. */
> >  	bool mmap_locked; /* Is current->mm currently write-locked? */
> > +	unsigned long charged; /* If VM_ACCOUNT, # pages to account. */
> >  };
> >
> >  static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> > @@ -821,35 +822,88 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
> >  	return 0;
> >  }
> >
> > -static unsigned long move_vma(struct vm_area_struct *vma,
> > -		unsigned long old_addr, unsigned long old_len,
> > -		unsigned long new_len, unsigned long new_addr,
> > -		bool *locked, unsigned long flags,
> > -		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
> > +/*
> > + * Keep track of pages which have been added to the memory mapping. If the VMA
> > + * is accounted, also check to see if there is sufficient memory.
> > + *
> > + * Returns true on success, false if insufficient memory to charge.
> > + */
> > +static bool vrm_charge(struct vma_remap_struct *vrm)
> >  {
> > -	long to_account = new_len - old_len;
> > -	struct mm_struct *mm = vma->vm_mm;
> > -	struct vm_area_struct *new_vma;
> > -	unsigned long vm_flags = vma->vm_flags;
> > -	unsigned long new_pgoff;
> > -	unsigned long moved_len;
> > -	bool account_start = false;
> > -	bool account_end = false;
> > -	unsigned long hiwater_vm;
> > -	int err = 0;
> > -	bool need_rmap_locks;
> > -	struct vma_iterator vmi;
> > +	unsigned long charged;
> > +
> > +	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
> > +		return true;
> > +
> > +	/*
> > +	 * If we don't unmap the old mapping, then we account the entirety of
> > +	 * the length of the new one. Otherwise it's just the delta in size.
> > +	 */
> > +	if (vrm->flags & MREMAP_DONTUNMAP)
> > +		charged = vrm->new_len >> PAGE_SHIFT;
> > +	else
> > +		charged = vrm->delta >> PAGE_SHIFT;
> > +
> > +
> > +	/* This accounts 'charged' pages of memory. */
> > +	if (security_vm_enough_memory_mm(current->mm, charged))
> > +		return false;
> > +
> > +	vrm->charged = charged;
> > +	return true;
> > +}
> > +
> > +/*
> > + * an error has occurred so we will not be using vrm->charged memory. Unaccount
> > + * this memory if the VMA is accounted.
> > + */
> > +static void vrm_uncharge(struct vma_remap_struct *vrm)
> > +{
> > +	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
> > +		return;
> > +
> > +	vm_unacct_memory(vrm->charged);
> > +	vrm->charged = 0;
> > +}
> > +
> > +/*
> > + * Update mm exec_vm, stack_vm, data_vm, and locked_vm fields as needed to
> > + * account for 'bytes' memory used, and if locked, indicate this in the VRM so
> > + * we can handle this correctly later.
> > + */
> > +static void vrm_stat_account(struct vma_remap_struct *vrm,
> > +			     unsigned long bytes)
> > +{
> > +	unsigned long pages = bytes >> PAGE_SHIFT;
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma = vrm->vma;
> > +
> > +	vm_stat_account(mm, vma->vm_flags, pages);
> > +	if (vma->vm_flags & VM_LOCKED) {
> > +		mm->locked_vm += pages;
> > +		vrm->locked = true;
> > +	}
> > +}
> > +
> > +/*
> > + * Perform checks  before attempting to write a VMA prior to it being
> > + * moved.
> > + */
> > +static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
> > +				   unsigned long *vm_flags_ptr)
> > +{
> > +	unsigned long err;
> > +	struct vm_area_struct *vma = vrm->vma;
> > +	unsigned long old_addr = vrm->addr;
> > +	unsigned long old_len = vrm->old_len;
> >
> >  	/*
> >  	 * We'd prefer to avoid failure later on in do_munmap:
> >  	 * which may split one vma into three before unmapping.
> >  	 */
> > -	if (mm->map_count >= sysctl_max_map_count - 3)
> > +	if (current->mm->map_count >= sysctl_max_map_count - 3)
> >  		return -ENOMEM;
>
> With the refactoring, it is pointing out some things that need to be
> reworked at a later date.

Yeah agreed, let's revisit this!

>
> >
> > -	if (unlikely(flags & MREMAP_DONTUNMAP))
> > -		to_account = new_len;
> > -
> >  	if (vma->vm_ops && vma->vm_ops->may_split) {
> >  		if (vma->vm_start != old_addr)
> >  			err = vma->vm_ops->may_split(vma, old_addr);
> > @@ -867,22 +921,46 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >  	 * so KSM can come around to merge on vma and new_vma afterwards.
> >  	 */
> >  	err = ksm_madvise(vma, old_addr, old_addr + old_len,
> > -						MADV_UNMERGEABLE, &vm_flags);
> > +			  MADV_UNMERGEABLE, vm_flags_ptr);
> >  	if (err)
> >  		return err;
> >
> > -	if (vm_flags & VM_ACCOUNT) {
> > -		if (security_vm_enough_memory_mm(mm, to_account >> PAGE_SHIFT))
> > -			return -ENOMEM;
> > -	}
> > +	return 0;
> > +}
> > +
> > +static unsigned long move_vma(struct vma_remap_struct *vrm)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma = vrm->vma;
> > +	struct vm_area_struct *new_vma;
> > +	unsigned long vm_flags = vma->vm_flags;
> > +	unsigned long old_addr = vrm->addr, new_addr = vrm->new_addr;
> > +	unsigned long old_len = vrm->old_len, new_len = vrm->new_len;
> > +	unsigned long new_pgoff;
> > +	unsigned long moved_len;
> > +	unsigned long account_start = false;
> > +	unsigned long account_end = false;
> > +	unsigned long hiwater_vm;
> > +	int err;
> > +	bool need_rmap_locks;
> > +	struct vma_iterator vmi;
> > +
> > +	err = prep_move_vma(vrm, &vm_flags);
> > +	if (err)
> > +		return err;
> > +
> > +	/* If accounted, charge the number of bytes the operation will use. */
> > +	if (!vrm_charge(vrm))
> > +		return -ENOMEM;
> >
> >  	vma_start_write(vma);
> >  	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
> > -	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
> > +	new_vma = copy_vma(&vrm->vma, new_addr, new_len, new_pgoff,
> >  			   &need_rmap_locks);
> > +	/* This may have been updated. */
> > +	vma = vrm->vma;
> >  	if (!new_vma) {
> > -		if (vm_flags & VM_ACCOUNT)
> > -			vm_unacct_memory(to_account >> PAGE_SHIFT);
> > +		vrm_uncharge(vrm);
> >  		return -ENOMEM;
> >  	}
> >
> > @@ -907,7 +985,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >  		old_addr = new_addr;
> >  		new_addr = err;
> >  	} else {
> > -		mremap_userfaultfd_prep(new_vma, uf);
> > +		mremap_userfaultfd_prep(new_vma, vrm->uf);
> >  	}
> >
> >  	if (is_vm_hugetlb_page(vma)) {
> > @@ -915,7 +993,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >  	}
> >
> >  	/* Conceal VM_ACCOUNT so old reservation is not undone */
> > -	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
> > +	if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP)) {
> >  		vm_flags_clear(vma, VM_ACCOUNT);
> >  		if (vma->vm_start < old_addr)
> >  			account_start = true;
> > @@ -933,13 +1011,12 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >  	 * If this were a serious issue, we'd add a flag to do_munmap().
> >  	 */
> >  	hiwater_vm = mm->hiwater_vm;
> > -	vm_stat_account(mm, vma->vm_flags, new_len >> PAGE_SHIFT);
> >
> >  	/* Tell pfnmap has moved from this vma */
> >  	if (unlikely(vma->vm_flags & VM_PFNMAP))
> >  		untrack_pfn_clear(vma);
> >
> > -	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
> > +	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP))) {
> >  		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
> >  		vm_flags_clear(vma, VM_LOCKED_MASK);
> >
> > @@ -952,22 +1029,20 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >  			unlink_anon_vmas(vma);
> >
> >  		/* Because we won't unmap we don't need to touch locked_vm */
> > +		vrm_stat_account(vrm, new_len);
> >  		return new_addr;
> >  	}
> >
> > +	vrm_stat_account(vrm, new_len);
> > +
> >  	vma_iter_init(&vmi, mm, old_addr);
> > -	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
> > +	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, vrm->uf_unmap, false) < 0) {
> >  		/* OOM: unable to split vma, just get accounts right */
> > -		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
> > +		if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP))
> >  			vm_acct_memory(old_len >> PAGE_SHIFT);
> >  		account_start = account_end = false;
> >  	}
> >
> > -	if (vm_flags & VM_LOCKED) {
> > -		mm->locked_vm += new_len >> PAGE_SHIFT;
> > -		*locked = true;
> > -	}
> > -
> >  	mm->hiwater_vm = hiwater_vm;
> >
> >  	/* Restore VM_ACCOUNT if one or two pieces of vma left */
> > @@ -1138,9 +1213,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
> >  	if (err)
> >  		return err;
> >
> > -	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
> > -			vrm->new_addr, &vrm->locked, vrm->flags,
> > -			vrm->uf, vrm->uf_unmap);
> > +	return move_vma(vrm);
> >  }
> >
> >  static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
> > @@ -1245,17 +1318,11 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
> >  static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > -	long pages = vrm->delta >> PAGE_SHIFT;
> >  	struct vm_area_struct *vma = vrm->vma;
> >  	VMA_ITERATOR(vmi, mm, vma->vm_end);
> > -	long charged = 0;
> > -
> > -	if (vma->vm_flags & VM_ACCOUNT) {
> > -		if (security_vm_enough_memory_mm(mm, pages))
> > -			return -ENOMEM;
> >
> > -		charged = pages;
> > -	}
> > +	if (!vrm_charge(vrm))
> > +		return -ENOMEM;
> >
> >  	/*
> >  	 * Function vma_merge_extend() is called on the
> > @@ -1268,15 +1335,11 @@ static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
> >  	 */
> >  	vma = vrm->vma = vma_merge_extend(&vmi, vma, vrm->delta);
> >  	if (!vma) {
> > -		vm_unacct_memory(charged);
> > +		vrm_uncharge(vrm);
> >  		return -ENOMEM;
> >  	}
> >
> > -	vm_stat_account(mm, vma->vm_flags, pages);
> > -	if (vma->vm_flags & VM_LOCKED) {
> > -		mm->locked_vm += pages;
> > -		vrm->locked = true;
> > -	}
> > +	vrm_stat_account(vrm, vrm->delta);
> >
> >  	return 0;
> >  }
> > @@ -1316,11 +1379,7 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
> >  static unsigned long expand_vma(struct vma_remap_struct *vrm)
> >  {
> >  	unsigned long err;
> > -	struct vm_area_struct *vma = vrm->vma;
> >  	unsigned long addr = vrm->addr;
> > -	unsigned long old_len = vrm->old_len;
> > -	unsigned long new_len = vrm->new_len;
> > -	unsigned long flags = vrm->flags;
> >
> >  	err = resize_is_valid(vrm);
> >  	if (err)
> > @@ -1353,7 +1412,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
> >  	 */
> >
> >  	/* We're not allowed to move the VMA, so error out. */
> > -	if (!(flags & MREMAP_MAYMOVE))
> > +	if (!(vrm->flags & MREMAP_MAYMOVE))
> >  		return -ENOMEM;
> >
> >  	/* Find a new location to move the VMA to. */
> > @@ -1361,8 +1420,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
> >  	if (err)
> >  		return err;
> >
> > -	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
> > -			&vrm->locked, flags, vrm->uf, vrm->uf_unmap);
> > +	return move_vma(vrm);
> >  }
> >
> >  /*
> > --
> > 2.48.1
> >

