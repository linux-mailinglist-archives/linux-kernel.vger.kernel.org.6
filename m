Return-Path: <linux-kernel+bounces-368180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4909A0C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A4283413
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF42920C006;
	Wed, 16 Oct 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W0w7an0b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LJ81JhAx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF01DAC9C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088032; cv=fail; b=uDuh8jhpxR+Vlxw514Fl/Ee6cOzK0uJXJAyN3w/0Tw4rVVxbo9PnyImdXPQEdUGwcZz3cUsHEoSGNNZBoYm3olqdxMkuGGwNp4c4HyeYZQhe6fviH0hEEYWONtF9uSiICy9m0w7Zc+HGUR2l2iSVb+hMNgPE5JgvZueqstb+GMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088032; c=relaxed/simple;
	bh=HDU+IaJm1D9/jiDdnFwQNDQekJ8xiJxZ1UyJ6cJQr+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xog46jfEvkr3ZQiB7fLePaG7RGDaY2anELZ3pYh6BQV3XpIMTvVXiXM7im8H90FjSd2x2kXsiVa3H26QCM6wetcrKVozhO1c7ZA0c7x75OHxgtgUehQbkDOvMMvkD4VciYGmi/R1TDL3oecNzKIKZGxuDPf7iAqhEjUv4WGNYWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W0w7an0b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LJ81JhAx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GEBjX4025973;
	Wed, 16 Oct 2024 14:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=paD6SHe2+vkUW4MHtD
	+6r8gPM5WIelk3ykRDBV4c0UY=; b=W0w7an0bLengi/Q8JHdDa4xei2Ni8TpONA
	BwRIsXAZMQarRLPwDb5UCKPzTuA7wyAbEgHINwwPDXZYvU8lBIw7VoRstPp4aZhn
	UzQQWjOcGUOds1A+XrhWtHHR/fkRzvmIDFRk+uHf5+31P89otOI6SHDmQQzupDwR
	Ey/7nxzuy/2jSZbXXqUbL9um/nO0FFBIOT+ydxWOs5kSzHOAul0d9gp6h18PJRK6
	vw6iIiQBPfRSTbfMY/cDzpFxEbJcW4JPWbof5Y+rWtbhTzy67WoPi9w3QR34Ivzc
	bz4Jwl+Q1bkbwrZjRGwquqyAR9uaBZHInzBz2kQ45AtsvbFspE7A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt3ty9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 14:13:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GD10BI027164;
	Wed, 16 Oct 2024 14:13:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjfexgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 14:13:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcNJnrdtQ9gM23rujJg3z71UwA4DhzSs5uwb+P1e+Z5u6fF5ILbgDBaXyk9jfE8ZdFUW+Bjz6EGU7Uo0CyFBEkDexMjKl7xvj2kkm12009woLhcnB/7ePA2FfetZc3pftvmIqV9pG+4boGHYUn/kcvtYzGnpGI8/GU2kOqftvTknvs+GfY87Uvzjm5jSvRok+jpJkWGBzrSpMEnkv5UsKA8DAiEYCJuBXkOn0+GiFNC2LrIV+eGoHZtvS7cpybGPQyD2wz2HJgGrgSdL0pbqce4dIGw6dAe98gLKcWMeJH+PhGIqcFMD51F3IUKbKh2/dBnz7dw9AVbAi6UllNdfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paD6SHe2+vkUW4MHtD+6r8gPM5WIelk3ykRDBV4c0UY=;
 b=Wch6ZLCea91nbECFwzzOP2Nl3ITgQm9ICbISvf3jD7eGEQ9CaCH51NYpoZt43aYzipjrufhjfQu1arlqSyMdJHaZoxByxO5nOAxGkvELzquhCMj2OsSfJHjs+DWtJYO2OvnG9EEh2ljUAyyNOlOFyL5JbwSN2n6ymlfVwMMgEV8C1nLetlFY1uMEpEcupYfGdEYtCS1dqBXtZ/L5UfOlsgOshkiobTdGHj6kDqHlSOTKSzJbrYr5rqvh3BC69sJjbZkVVcjOfpkz/g/Jd57hkqt6HpVznCBtVgZmvB9P2e9aGs5MdTasVi7BT714h98HfCrqCXdaA7l007hAL+/RKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paD6SHe2+vkUW4MHtD+6r8gPM5WIelk3ykRDBV4c0UY=;
 b=LJ81JhAxZJlfMV1MWkb1Zkeqg7pnFRT2XMyfRtkH4sMNssL7m2/8GIMpngUaFpUH99gEo6Af1pLy4ZavgUc/rUvVGoDC9z/l9ny5N3yfMmuHtpNfNbNnb0VlH2TXBnJSNQbtctSjrTFAag0345LRYtbx/TVwgBW+OUE0bgKn4XM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB4709.namprd10.prod.outlook.com (2603:10b6:510:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 14:13:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 14:13:34 +0000
Date: Wed, 16 Oct 2024 10:13:32 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <radsw6c3wfzt2snc3ra6ugeqwfalzkeudmtyfmwki4ue6jx2gz@knavscb4ofbb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Bert Karwatzki <spasswolf@web.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241013223601.3823-1-spasswolf@web.de>
 <02217d08-bc08-4ffe-8e63-07878561f9b7@lucifer.local>
 <3b4dccf8dfbfb5a9d7c07a745c48a96164fbf19a.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4dccf8dfbfb5a9d7c07a745c48a96164fbf19a.camel@web.de>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB4709:EE_
X-MS-Office365-Filtering-Correlation-Id: 0362b2b5-110b-4557-9856-08dcedecb863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E4AkhUcRilFz7Xf225Rsn9mTw2uRXtThLFNxm0yBe4QlgP0DPjSqx59xc+e9?=
 =?us-ascii?Q?F37OUP5F85zfKOdpZyDh7mf9xFLjG6CVrWIit3vDPGgSX8MnPaZFmdDLADA/?=
 =?us-ascii?Q?y0aaBVOui2+xJH8fJNYLHVxMJ9UkiJIFdjIwb+Hfh1GBCcylj4FvGQx+crV9?=
 =?us-ascii?Q?2MKiG9RM62j2vMSUjnOwSow2z8J43l52v/G+6sGF0j26E8TRKa0rjcZvcVrg?=
 =?us-ascii?Q?oiA6wlpgBZntMqoH1ZBmwlDaXdCPuaco6yxC0g6IJrvUNxPydh/RQ6PH1e4t?=
 =?us-ascii?Q?xV34BAKm8KYqerbWPF5qJcuo45kYz9dhoeSyGV2AhRuesErTaqzZAtyZS78L?=
 =?us-ascii?Q?+jsglJXAees3tPsw2HK5sxw/QXTWFwip/f54WOTGATMv1YSznk3wMdIyhDHY?=
 =?us-ascii?Q?tchTAfHxsAQPR4MXN2TJV+TkKFedBHgTjkvnn9rcY2O679AGPl9kzOOA9vib?=
 =?us-ascii?Q?qOQ8MdH1GJrD/V4q2dfCgCisqAalQlo4clOBk825SXrJqjU21qLI3dtR0E2V?=
 =?us-ascii?Q?fbLmbONh0l7hW92Uks/YbJyzV2n2Q02FcIj5ASVpw1h0xy6Hw71Lq+ZsrefX?=
 =?us-ascii?Q?t7q3PFv3eM87yM0byZfGf5hC/aS4lCoC3t0OhgmB33sm+7KtaIIZQo55KuYU?=
 =?us-ascii?Q?UN1nTL35Jo51Fd2Ufl+mLSCGyvzLSVO3xmUCwrLmL71bWlq5vM++deFAupr8?=
 =?us-ascii?Q?y2AfHlmav3E6eGo6FL7rvPN2BbjgfXe00wmq7XQ87PFFhcVXuke+UYT8Jwoc?=
 =?us-ascii?Q?w/dSnHS4AaG8n6dQm/z1JJa8erVf3acTMDQ7aPXxoONvag6AhHq5GkBzRQC5?=
 =?us-ascii?Q?WNGKVf6pbCm5RvCTrYysdWhjOkq3ZetAQirir9T5Blp+KnOnXtZ+k95nl3zP?=
 =?us-ascii?Q?KfQakj8RmVQwoPFR9hLjDWuO58DhgLotI3htPoYOTaJxFqyfK9jGAeNKw7Si?=
 =?us-ascii?Q?iVp/T9fLu4U8xVsuDWUzBso1sPVqmLc+eZDe0vB5LXcRBcjWW0EjoEc2RLO/?=
 =?us-ascii?Q?SmTj1t5XIW55OZ1yH6O3PcCLMYcuJV8Nr7BQ+L/DG47zYyMXpaiaShywsRl8?=
 =?us-ascii?Q?7Vjof844+DZkRJ37fRpirfi81Sc8ALtrnAwl3AkxZNHXoiyq/s2EDFUSeTRJ?=
 =?us-ascii?Q?sYJx/XHb9gDunH6A+KUopykQyDsk/1puY9kEEUCZS1xQw1VqdQf/2HbjJFWj?=
 =?us-ascii?Q?dvQNReihZ05fMcXj9D9wvI0T+ht+55103I4Fx6lM3OSEJFGiYgfA/EQN1vGS?=
 =?us-ascii?Q?hYFEk4kWzRdJZ7DTQouXVN1LmYp7Y40GYocVJmxV6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?at4A6AJVxM6UtuOk6jaaiSOAI0de5zj3q2yT+4ErPjjpZQf5OiJg9zx3GYJJ?=
 =?us-ascii?Q?R7Ood5h6U6Uwg8AKLdVE/0cUPdvJyLoPlMutm8e9TKhlUFDmhjBlpmUFGJKX?=
 =?us-ascii?Q?t5Pv19p0OGrfI43Gygflf5U4lPRiyBvZiNYxp291uUh3t5J3KWQ0SGJLesXY?=
 =?us-ascii?Q?K9KnjcfA9dACsjZ8BHdI4T7JPoWK1bLE8LL5mY8Y0xOsTAbthIw+YHOJyyCJ?=
 =?us-ascii?Q?g5uWMg8Xyr0WFyWWoXFCeyEXmJGGgPxpfunlfFYRiruK0tqzDX3tAg4KgsEY?=
 =?us-ascii?Q?BcfkMtGwWJO0Sufgn/QX+kNgv860WIY419L1YAV+ulTXVYRMF8+nOk1WIoPv?=
 =?us-ascii?Q?ke1MT1k2AXJxkje4uGxJYWmhD6p7HOcAzHRa35Fz6plWF7rp6bpe/1DUmbGs?=
 =?us-ascii?Q?UXmtOk6s0f5lGnO4dE+rfXSlIu7JNEow9T3GvBkvPOos3fd4ZhP+KYEA7pe4?=
 =?us-ascii?Q?k30R23wjqj4AN6tgYm8T1LDAeOJXAr0c8EYWd0zQXdTaSjoXD9jAx5sKms3r?=
 =?us-ascii?Q?VMbfCxrbMn4vRO/LbOrryE1XOJy559wlA9RJLprDHoNTK4lxNSdKascnPHJv?=
 =?us-ascii?Q?A6lRkFm2PWtIq39Kf9Yt8UfhWgn8udV1yubpFJeIzqgmrUC/sqmRCsP3YSct?=
 =?us-ascii?Q?iwkKxawFpau++xVZYsErHiPlSwIL0l7+A2HbXywe318mNShvr8AGmCpSUr3U?=
 =?us-ascii?Q?ExHOk6N6mqdazXHbuAItgwtUHbbfOyEw2+8Yp4P0f65a2tMd8rUf/doZ/V7e?=
 =?us-ascii?Q?myhsrtlVo+FZZIQcPqfffcgh3TYUdETqkh0irZB07CWGVSNvr8l/OQzeIfQV?=
 =?us-ascii?Q?mVfP/XHWqi/g3zDRaSPSGPDsmimqsHAUUhxGYp9p1ffPVIndv+aZ6rFfOXJ9?=
 =?us-ascii?Q?YFXXj01zhMqYhAFqNqFYaoHaLUOX4TarhcSkvXszTeOBoR6GYVEyLI1IGBis?=
 =?us-ascii?Q?Jcgd28QzM1C+Q1170FrQDmM5/vYHRlEE1ZLFTBLQgLUNHDqmDh6TcJysGOX3?=
 =?us-ascii?Q?zZq4fv/rrbsdJqBZTiFyjGbkQsETj/yZK/wY3k7GdCG9mdjRpWF6OPj0WvGx?=
 =?us-ascii?Q?s9DVzgV44QcQ1lOFx9kdVZMfvh6kWjKf4enara5x+LtQ1J6yQImM03ZXwcKk?=
 =?us-ascii?Q?Ro5Usmi7bNpojctzhiSB3lJiE4HOymC7yCP455VMDqnxvVRvgo9I01dlK1NB?=
 =?us-ascii?Q?LlmKhfl0YxkhI/7xGOkzJ3oI9daBhvOcrCYH5IVmlMgRYZtV+vfgjZqD8yRv?=
 =?us-ascii?Q?lOPW2pa3Y8a/zSUWtCtixs2WT2fgGgug8G+Euatt8t0tYtXvSoebeGjpk95a?=
 =?us-ascii?Q?UsmaQpIY7O74jQ6ZGNc3b7C21j9uBAduMKUPpfHB6hLdyKnQXG4WQcY85DO+?=
 =?us-ascii?Q?+0+Fq1qP4yzs0hnm0m9s0xrcxeBmzPgm/Mwx5osP6ai9ffLiTaPhSt/N9wkD?=
 =?us-ascii?Q?QGoyTkPqRaA30+konxkO4uNSduIQKRudEhIvXaMpXsLHQfT9jgqY1tqnho2r?=
 =?us-ascii?Q?ZfxIMf2F7ydI1KoNm7YbQXQnJEC6bCbr/SDKCUhRcUZTGyDrk3tv8iuEgP3L?=
 =?us-ascii?Q?tiHueVX2wtmqC04nDnF0aDysKvDJdcS6H9glrhmobEe+kBmb8R+5ATjw9vSD?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MZWcnPf5/ZbdgNpvvJcijQhn7oFuZ3nF39PsDazxgnXvV5XNtXP2y5EBZuCqppUd+OYtfJg1nDpSpSaynatB8Ki38afcFAoFqZ5/rkMWQdWvLc+79tHdEhVul7XEIhYzenmyaJc0A2lrXi6Umkp08vFJkBSpJPkIlYwledPbIcnkpjuETBvLSGDzgNYjxEXULgvYTJTR151V5vhCsh/4v58M7Jo7YRqZP+4qefCCNgwEEfH9Gimie4BJ6Uqjne/CX/MXFCB1/flWutrYWfFDerk627LekdicPTwspYH3PPN3APzNMZKTstJUNaSVVenSnPUvpoMp6Lts7w2XLuiL6okVpIB2qn9xuF/pwgz9CfHvzcs+e3E4p64h9ClBYKXYSvm2yHrf1AEwWChxHZuuMQhIaWAVcVR9uypRYpxfahkinRv78VNmxeVzf0kQiQLXq7V5pY5RC4OkFaRnROjVffUJqmklPNPUpuTJsI6Si6BETxk47p6aFlZicZNRI3ED7JlR3nK7vyxiDejBY5MAdo8rVCcb7UIogG9MPHNq6n6YzfKG876sPaR6kCA3zj88UZ6CLWucRgSKewWOQX+uUDRWOCD/TK1ad89YGHpVlus=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0362b2b5-110b-4557-9856-08dcedecb863
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:13:34.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2EG2KTP0RSVgNZcVKT5yqAMWuYJbfc3e26ITqYH6X1d92RB5Qa6yyEuWE3UM16k9IqIJOmkgmSTvqoQOrEbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_12,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=822 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160089
X-Proofpoint-GUID: YdAqzoD5Xtek7zEMd2IVKHECIgZE4idu
X-Proofpoint-ORIG-GUID: YdAqzoD5Xtek7zEMd2IVKHECIgZE4idu

* Bert Karwatzki <spasswolf@web.de> [241016 06:29]:
> Am Montag, dem 14.10.2024 um 10:46 +0100 schrieb Lorenzo Stoakes:
> > On Mon, Oct 14, 2024 at 12:35:59AM +0200, Bert Karwatzki wrote:
> > > I created a program which can trigger the bug on newer kernel (after the
> > > "Avoid zeroing vma tree in mmap_region()" patch and before the fix).
> > > My original goal was to trigger the bug on older kernels,
> > > but that does not work, yet.
> > >
> > > Bert Karwatzki
> >
> > Thanks, that's great!
> >
> > For older kernels the problem should still be present, the fundamental
> > thing that changed from the point of view of this bug is that merge won't
> > contribute to the number of VMAs being overwritten at once.
> >
> > To trigger prior to commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
> > in mmap_region()") you would need to create a situation where the _clear_
> > triggers the bug, i.e. you must consistute all the VMAs that are being
> > overwritten by the store from existing VMAs you are overwriting with a
> > MAP_FIXED.
> >
> > So some tweaks should get you there...
> > >
> 
> I don't think triggering the bug on a clear works, because a write of a %NULL
> that will cause a node to end with a %NULL becomes a spanning write into the
> next node:

I think there is room for improvement on this algorithm and have been
debating changing how this works.

> 
> /*
>  * mas_is_span_wr() - Check if the write needs to be treated as a write that
>  * spans the node.
>  * @mas: The maple state
>  * @piv: The pivot value being written
>  * @type: The maple node type
>  * @entry: The data to write
>  *
>  * Spanning writes are writes that start in one node and end in another OR if
>  * the write of a %NULL will cause the node to end with a %NULL.
>  *
>  * Return: True if this is a spanning write, false otherwise.
>  */
> static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
> {
> 
> 
> I think the could would trigger in this situation
> 
>               Node_0
> 	     /
>             /
> 	 Node_1
>          /    \
>         /      \
>      Node_2    Node_3
> 
> but only if Node_3 contained only two ranges, one empty range and one normal
> range, and if the mmap into empty range of Node_3 would merge with the last
> range of Node_2 and the last range of Node_3. But I think the rebalancing of the
> tree will make it very hard if not impossible to create such a node.

I can confirm it is impossible to create a node with two entries that is
not a root node (if the root is a leaf node then there isn't a lower
bound to the entry count, if it isn't a leaf then the lower limit is 2
like other b-trees).

