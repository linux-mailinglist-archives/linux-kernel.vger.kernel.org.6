Return-Path: <linux-kernel+bounces-542576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4DEA4CB41
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3181896AA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BBC22DFAF;
	Mon,  3 Mar 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c/vDs0Zb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LCpABz5V"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97C1DE2BF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027833; cv=fail; b=lNBnhf1jBIHW9d6cXO8ZFVir3Nn0hIMc43u8jNtBcLdolTiKXA7UkcyNmZ2+qIno+Xt34loVfysgEtILNSNkH8/tuQjFNwXr6PUImOE9Ck4G9eJKRwYD/wCTKONpw1G+Wsa9cOZpSBuu/M54tvIYgNhBczDLfLvqp8JBQdl2uO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027833; c=relaxed/simple;
	bh=uBb5/qvPynYtd1GTfv5Rt4WmFm6c8HKMzIlEyvvpWaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QAd3/+iGKQZb/sBillN/Ot3eDcdxBM2DdRAO4kqNDR+6cF5jdmeIOs/1HcHEMMnBB7genE3wrkCj+Xbra3E7BpB/cw7qNX6/6HEA4T7BOgOYNgGppEpI2p6zk1PHPYHCfpPbmdeW54mVW6AEILoLj0pno6bT+Z8Iy1c8fpWR+5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c/vDs0Zb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LCpABz5V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523Ifink006185;
	Mon, 3 Mar 2025 18:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WoqlvDlF5U5DW4JTfO
	HMQVFYJ3Z7O/uZYCNSUHNkCkY=; b=c/vDs0Zb5D85uG95bOH3KQERZcO0dKea8c
	LFV1m6ppNeEVQC2tT3fQ4XOAt8f+vyfc9xbHqFqQ2Nh25MxJSGvzIOsLYlI8/nZc
	EV3sx7W5RMqBM0P6E8ZSDMCu36eLL1AqLhoCJYokJU59qYiSPLCME+X5Ec/zgM63
	ZvZqKe/jpf8qyVieZoLnzSTlVtG+vgF+fV2Q5J1PDkdy3/18XFv9EZ6jfX/Ohwi2
	qZSfpMzYFGtHH1bvptZ6rHhWwBOjkOhHW9N3NKNSZi/RvrJ6rhgL9w5YMr/DmFtc
	4KWpk/HbDoEQB9IKUDpSyzyZniaEH2kMVzQKEx9tN84Quq+q/Uuw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hbcy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 18:50:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523IDsKA010933;
	Mon, 3 Mar 2025 18:50:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp9dynq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 18:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ6acT1WTTMC+RotGKvyhz6UuQ9yY8ZCiOwzxobYTDE/zpvhfn5kSdY/E0J9Ggxff0PaL13uO15YcvwY+faB/Q8c5Epkx0bM0f9fSuQjuETUQJbiYbA/CbrZVfPYuu+m8OTlZRGXCYtOItLNUyoUqn+4/t3jWvhzwW7lDKlIFzgCMwaCzsNu0i7/HqmqyVdEsIQYyf2Mw+V0xtrGh/PuyaK4uOYHOcxnGhA2EseZo0P/IOWGmj7nzOEpu1TMrYKYt7WSNXrFtt4J2LNMUDedLmxH/rtawwL33m1asT7eQMFgQEvMtHOIcUKEs8QGcvToaO/y4LH8LBWQ5e7WMW3yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoqlvDlF5U5DW4JTfOHMQVFYJ3Z7O/uZYCNSUHNkCkY=;
 b=Sb3v6d2w880Mfj6NPaxN8bWaq6Nr1TbkaCvN1Jhu0obh5xH2h2eqlnj+b+su8UPOxbbCAnkVCV1kYI3M4TIsnNNqDbAfAUb0j0bnYW79nfGLNK2FFvNWNJXI9yLf0irXaTFnHseZw33nV7BRTdwlmWXson1RJf8SEt4+PuKCm+antJEa9DlX6SOiyRo1aCvlUaeAX+7wgfMYwi+PrRq/LOkgeBUAOvpxo8XQg4Wcqitoo6PLYjELvn4mb9oTeEUc5597+SDbK1lrulDoNPpnI6NHFfW9KGk0/HX/FiGa1XUc10v0Q/9pAA9LSIpIL0IPHuUKAsI6/fMdV/OsyUoexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoqlvDlF5U5DW4JTfOHMQVFYJ3Z7O/uZYCNSUHNkCkY=;
 b=LCpABz5VOISrSs/Ut5l0/SsvR2H3pDN38L2OcW3WPcQ3ADXKicjtZ55JzWZN13jAo+1n4VURYKn59XXATqTBWwMCvNi9HtCTMARZG/cPxs/KzpNJ4Msgnporwz9KYoerx7NE6Sg4bIbLZzIb+15NW3Epog9VqFlxqhlhvrfLEdI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4804.namprd10.prod.outlook.com (2603:10b6:303:90::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Mon, 3 Mar
 2025 18:50:20 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 18:50:20 +0000
Date: Mon, 3 Mar 2025 13:50:17 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/mremap: refactor mremap() system call
 implementation
Message-ID: <tdgtcgwiaxwlncw4s7j4is25rouxrcl54bm6cui4iguuovsqmg@qt63fkl2qklf>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <e6b80d8f58dd2c6a30643d70405dec3e9a385f7f.1740911247.git.lorenzo.stoakes@oracle.com>
 <g4lus5wcyzcfmvcf4w7yzsaej2dfprwttcqdjh5thvb7qgqiso@hl34vyxbuhe5>
 <658d7d04-af2b-4f73-9408-2fc13398b2d5@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658d7d04-af2b-4f73-9408-2fc13398b2d5@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0079.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::9) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2ddbe1-2a39-4257-4605-08dd5a843f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NXV0JdI1tmP3JMzUZ2RJKd7z4fqh3xzAv3xE67egVCGXANycciEtWeB/ICiu?=
 =?us-ascii?Q?nxHI8mp77Cx5p/MBGJA4/YvOhuTXcjDJRErgl9t1OwjYEDh04mXJRZNRCwuB?=
 =?us-ascii?Q?Ax+0TiZTHrC/PWB2wuCqL/4qhyPre1v3v3/V36M8qTPN5s6/PRYWZFX+/JKj?=
 =?us-ascii?Q?8uHhwmp5+BnrAbQHBEFJ9zB8razqzV9b/nh4H9FQOKYVgi44EWhZtbKWZvdw?=
 =?us-ascii?Q?FeaUzJ3mi9YxJT2wpmIh9qG/9SegmVUQtYXPt5YmG7QRZpCAGcGxSv2qs2XP?=
 =?us-ascii?Q?QjuH4lr40pQwR5HAfYKo9/scyg5pzf22t4TnKrkkkkoOwh3NfzQDjFMxOkMf?=
 =?us-ascii?Q?DmM+i+/3UpAMrfm1AlEYqmkOvGfvN2u7GQKDsF1E3XejIFnpaRkJrJZc8Ayo?=
 =?us-ascii?Q?RzQzCqZnX6hqtKuIglB5X2d1RE4wfb2kchNuAPyN2pYKwwdhlCaByvCT9NKM?=
 =?us-ascii?Q?ZBhxs0+eeeTVaCVGzUmmT9wzVOVZmKVKheE2AsmFmUY2J4QOiw2vY2zoJKNt?=
 =?us-ascii?Q?fvDSRN7jlOhAUm8wUFI3yKr6vzyzlXccUWNhKThG2FfoLea5x2I5BbfdSTKx?=
 =?us-ascii?Q?VWSJZRB6HP1e/P6JWcWIkgtuRKzOvKc+yuxM4IlFq4JccsAwDO14INzc7oSi?=
 =?us-ascii?Q?7eLk6+hewjBdmIJIJ3TVGuNqrkQIHJEHmbS/zxkJhv6mF4Z/obmL66Kiw/UJ?=
 =?us-ascii?Q?hUUAnXuCk9pmR8TPQJiPfmpsFgZVogHU6Fe3cVJz5ZjRdjLJM+U55gb4cYZK?=
 =?us-ascii?Q?T3acWo5BAZtIJNTDsm3rKgdkyGdmp5p4Gkbh68b3dYOdXpzSPRzfERyXcG7I?=
 =?us-ascii?Q?Uaovk0VuCb3Y6jOmT0r/ogzh7nKGey4ed5RvGr9cKSeAVa6JSu7hoTASRE61?=
 =?us-ascii?Q?9pww+Dnw2NZcA97vj7bIxLHeLNbFtUaUO9SRLAbTKq/+8UM/Fo55OAiRVAdO?=
 =?us-ascii?Q?6oY/wxyiekSQIsTqr5J3uBP0mnWxT/wro56J+8EJO02wJgnapA1GVGaDV6O/?=
 =?us-ascii?Q?4VyMwvI0Kf0+RTOFbsGqsa3iTjGS2eQpzVXzmB99doPQwy7itJhYhXVOcKJ5?=
 =?us-ascii?Q?E4xJEM8KB1A0vyg2RF+8er+gpxSEkDB+qwmfS2bNwInnp6PTqb2I1x4CkDpB?=
 =?us-ascii?Q?H2l2fw7GZPhy+fWRYPIpFWyPFOGld2udfWTn9cfgF+ixcjTmCQ146D9+tbmf?=
 =?us-ascii?Q?VQPaNBQSp7StxsNpXCzP6LUrd5Ojz0hUAauzSc9F6KagcE3qW8A6dY9oUJcC?=
 =?us-ascii?Q?mynsV+r0htTC1j5/BXwU2z/MDloMDO9yk2OTQVnGBVMlJHGTi3IXuY4mnjpO?=
 =?us-ascii?Q?w7wYXAeuFXN3CgEbNQqF0LYUYWiTLGXwVyFExRkgbuD/xPJooeo0haSK6q9z?=
 =?us-ascii?Q?TKk7UA8/VRpQv4n44DZ9C/zC/ETe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?runBXdV1A8kVrGWO//ItH1gOHpxy3CajSrg4fWsu33FJxqRLCWnYnpAbC7UL?=
 =?us-ascii?Q?bz7rBimgDZQGxXAxXMSPkKkM7+FMdDd720RwY6SBSm5pNRSTfrdgOTTEXhJY?=
 =?us-ascii?Q?okUu38q5e/BxVYnNTdX/C1zIpMNOnGXYeSgdMlUYw6upRn7VRdzp7wvYA690?=
 =?us-ascii?Q?q3wCbXkVmp7NhVfVixC4Qah1yLUFjW8c5TkwW3KhsXqo2bHbb4QlTGyfsyk6?=
 =?us-ascii?Q?hOjnhdlqQww4m8SWHK4OjIAZPpz+Zg6tdNiiO0u//Y8avFeznzimMGIeRYki?=
 =?us-ascii?Q?/u9vZPRBrbZENjm3PEbeA7iDLtGrYEa5CADjYtyBaE8Kyil3636J4J0k+PWU?=
 =?us-ascii?Q?sVWlV9QJlqpUqPnWdA1Qx6tHe3pDx5JAOKhk/EVnBsJGD5TuRBPlkOyLkeuD?=
 =?us-ascii?Q?ZNNVg4qOFxECnQUZUwDH0dAbIyqPhLRLuFaVQncXOhWMB3saYR1/SjiSFwMw?=
 =?us-ascii?Q?/KaG0lDoJUUaoJY0kEHs/8g8w2YWPEqreL4Os4P3XwAz649mPS8wZusN+KkZ?=
 =?us-ascii?Q?jC3tyEi/EIbMlOIt7bOwWon30FL6E8d1cqHAyyspHUJaSl/kFtEUtM5/Z4Wu?=
 =?us-ascii?Q?s0shWTOwv0lVonn/Kz1xh3WNjHpKX6dMzEbulqJTs9Z16tCZSEsLrKaUTbD7?=
 =?us-ascii?Q?KD406WPjtYJhr/opwxWIkszy/9PJj5CVm9zG3pL/xYCekOBm4YSDDMCHM1Hi?=
 =?us-ascii?Q?eb/khTFcgk8UjoJStrno5XFMGF4WALMEPTKbMXrvlu5gxaVE0zVKFO+YKuKt?=
 =?us-ascii?Q?GW5AmOZj6H7vZNU9TLevTVAL+c4aJQi3pIthk4pGUxQy3LA7QzecUN4RKTX+?=
 =?us-ascii?Q?kw4N2zR/6ylVTFoEDJrwoX22/WiwDjZZGjvjcYo/x5Wlmwz1rLUC1br0knXU?=
 =?us-ascii?Q?YzauIPMjFrQc3tmawb3s8PBeRlvHf4ONaxWgPXliGYk47LjKO07IZ5CfjP/b?=
 =?us-ascii?Q?BaIsL2+UDolSdy30mYm+mk5HoFr6kDHZbrSMCSz+r3m51IH4IDRYQOqOfWwh?=
 =?us-ascii?Q?OyZ7tzhVxlIWA77/jsOPJw0S4wVD/2F/1FNM6yVjgqDwebWaJ3hre5xiDC3h?=
 =?us-ascii?Q?wsFKdsjWtooM0etOQRQb5Kt7l9Hkk3vQsuWIaHLI2kSgt1+bp6DhZrfCsSM/?=
 =?us-ascii?Q?DYZVJww+j2r5BDpCtxsdK5be52hhwmh+fzRdJN99l5b4sNy02MDU718MwGlV?=
 =?us-ascii?Q?CKtHmp8jK6fLUPhBQ0PKsvCOScGj5BqCe15yi6wlzQcvLbVLxpMxgxRjgl9q?=
 =?us-ascii?Q?GhVJ2fWke837GcWvVzCvyU2EVOPhJdgKAa6OawLvuOzUd7XTD+Cmi172Nn9p?=
 =?us-ascii?Q?3mKU8UNBmQ0ZkpqyBJCwz9p9YhrOOAn/VoKlwhSzZBevBZTUqK4p8dS+lh1j?=
 =?us-ascii?Q?gYUG/eg7orVBGctdyo+6UGQZEd3O/QFpFPBzWVJ9ZRJbcZC3znrGb1LeqYBa?=
 =?us-ascii?Q?cB5jtZ4PDrqElML3vuWm6tMCUEMDXzwgYEHZsMCLmu8ns21ljvWvoFjIGJwW?=
 =?us-ascii?Q?7bEbwF3Q3YyYUCf+5oYb/SmQKZpw/PPL3SaMLVd64tUcEovJhkWZcbvvu+RU?=
 =?us-ascii?Q?vXbEHAr/aSRjkVzMxUisnncBY83au1VEwSyBG7v+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IO9nH5kATl9nT+0kG97BqvNTv0t5AGGdvN4IXwKlOSignfxmZalmiR5ywEBQ3/hxfsrr7dnvGuM5zLF8EEfvuXDCzxuoZUECPth2edPvxOtNpAxj241Iss/TmCp2v1Q1hxpVmErLirpmFnbupd8PWgpH6Oi03wEhrAPh58Vi7xmyotvlJpRX7bfRX0GWDpFBQjNggSu7XZ7X3Z6MncW9vgM0RSeQXmyoKM8ubsQJ0otJwi8sWOlx11Qnc+Tmh3EApo2LoXkEuWdjACIJJToxDBTqpTXa3kc2reiBWWs6yo5RMGA0GmwW+PnzcX6003QHgw3v4i+OsN91qV60N62o0023YLQt4ljnlAjtoR2aZwbTa5PRSuI0+7IUANZ+7IVKt8ctufZRe3RbB3RkIYDsJtcQGdXnOzhkkolYmx5aq6EkgfQbtCS6uaHpE3xasx1ibHvPn21z504HC7exb81tjRZquzg9Dzeefc4vTq5HfuEUvvo9NNZ9bNiWvvoVeDUbHgffd+26LebzpmII466WhtLrLimOBW+x1EcuFk8IZ8Xvl4piPzkfy1+XDh8dCid/DZmhSb7+GgyaL+hO30PH9QBwNietDevOWrued6C1xg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2ddbe1-2a39-4257-4605-08dd5a843f28
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 18:50:20.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMEeVmLW8ptW6ZL4QiCSWMUVVoRqGGhJriieyg1FaL5NyNim+0fmAxcomotMHgjq5DvGS97lh6UCJAXT9dhxPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_09,2025-03-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030143
X-Proofpoint-GUID: YKXByKfL3PJK8qCFJI8UOe-yfvmoBf9d
X-Proofpoint-ORIG-GUID: YKXByKfL3PJK8qCFJI8UOe-yfvmoBf9d

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250303 12:21]:
> Thanks for taking a look! :) I know this one is a bit painful...
> 
> On Mon, Mar 03, 2025 at 12:12:07PM -0500, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250303 06:08]:
> > > Place checks into a separate function so the mremap() system call is less
> > > egregiously long, remove unnecessary mremap_to() offset_in_page() check and
> > > just check that earlier so we keep all such basic checks together.
> > >
> > > Separate out the VMA in-place expansion, hugetlb and expand/move logic into
> > > separate, readable functions.
> > >
> > > De-duplicate code where possible, add comments and ensure that all error
> > > handling explicitly specifies the error at the point of it occurring rather
> > > than setting a prefixed error value and implicitly setting (which is bug
> > > prone).
> > >
> > > This lays the groundwork for subsequent patches further simplifying and
> > > extending the mremap() implementation.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mremap.c | 405 ++++++++++++++++++++++++++++++++--------------------
> > >  1 file changed, 251 insertions(+), 154 deletions(-)
> > >
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index c3e4c86d0b8d..c4abda8dfc57 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -942,33 +942,14 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
> > >  	unsigned long ret;
> > >  	unsigned long map_flags = 0;
> > >
> > > -	if (offset_in_page(new_addr))
> > > -		return -EINVAL;
> > > -
> > > +	/* Is the new length or address silly? */
> > >  	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> > >  		return -EINVAL;
> > >
> > > -	/* Ensure the old/new locations do not overlap */
> > > +	/* Ensure the old/new locations do not overlap. */
> > >  	if (addr + old_len > new_addr && new_addr + new_len > addr)
> > >  		return -EINVAL;
> > >
> > > -	/*
> > > -	 * move_vma() need us to stay 4 maps below the threshold, otherwise
> > > -	 * it will bail out at the very beginning.
> > > -	 * That is a problem if we have already unmaped the regions here
> > > -	 * (new_addr, and old_addr), because userspace will not know the
> > > -	 * state of the vma's after it gets -ENOMEM.
> > > -	 * So, to avoid such scenario we can pre-compute if the whole
> > > -	 * operation has high chances to success map-wise.
> > > -	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
> > > -	 * split in 3 before unmapping it.
> > > -	 * That means 2 more maps (1 for each) to the ones we already hold.
> > > -	 * Check whether current map count plus 2 still leads us to 4 maps below
> > > -	 * the threshold, otherwise return -ENOMEM here to be more safe.
> > > -	 */
> > > -	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
> > > -		return -ENOMEM;
> > > -
> > >  	if (flags & MREMAP_FIXED) {
> > >  		/*
> > >  		 * In mremap_to().
> > > @@ -1035,6 +1016,218 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
> > >  	return 1;
> > >  }
> > >
> > > +/* Do the mremap() flags require that the new_addr parameter be specified? */
> > > +static bool implies_new_addr(unsigned long flags)
> > > +{
> > > +	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
> > > +}
> > > +
> > > +/*
> > > + * Are the parameters passed to mremap() valid? If so return 0, otherwise return
> > > + * error.
> > > + */
> > > +static unsigned long check_mremap_params(unsigned long addr,
> > > +					 unsigned long flags,
> > > +					 unsigned long old_len,
> > > +					 unsigned long new_len,
> > > +					 unsigned long new_addr)
> >
> > If you use two tabs for the arguments this will be more compact and more
> > readable.
> 
> Sure, but a later commits eliminates this :)

Perfect.

> 
> >
> > > +{
> > > +	/* Ensure no unexpected flag values. */
> > > +	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
> > > +		return -EINVAL;
> > > +
> > > +	/* Start address must be page-aligned. */
> > > +	if (offset_in_page(addr))
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * We allow a zero old-len as a special case
> > > +	 * for DOS-emu "duplicate shm area" thing. But
> > > +	 * a zero new-len is nonsensical.
> > > +	 */
> > > +	if (!PAGE_ALIGN(new_len))
> > > +		return -EINVAL;
> > > +
> > > +	/* Remainder of checks are for cases with specific new_addr. */
> > > +	if (!implies_new_addr(flags))
> > > +		return 0;
> > > +
> > > +	/* The new address must be page-aligned. */
> > > +	if (offset_in_page(new_addr))
> > > +		return -EINVAL;
> > > +
> > > +	/* A fixed address implies a move. */
> > > +	if (!(flags & MREMAP_MAYMOVE))
> > > +		return -EINVAL;
> > > +
> > > +	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
> > > +	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * move_vma() need us to stay 4 maps below the threshold, otherwise
> > > +	 * it will bail out at the very beginning.
> > > +	 * That is a problem if we have already unmaped the regions here
> > > +	 * (new_addr, and old_addr), because userspace will not know the
> > > +	 * state of the vma's after it gets -ENOMEM.
> > > +	 * So, to avoid such scenario we can pre-compute if the whole
> > > +	 * operation has high chances to success map-wise.
> > > +	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
> > > +	 * split in 3 before unmapping it.
> > > +	 * That means 2 more maps (1 for each) to the ones we already hold.
> > > +	 * Check whether current map count plus 2 still leads us to 4 maps below
> > > +	 * the threshold, otherwise return -ENOMEM here to be more safe.
> > > +	 */
> > > +	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
> > > +		return -ENOMEM;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * We know we can expand the VMA in-place by delta pages, so do so.
> > > + *
> > > + * If we discover the VMA is locked, update mm_struct statistics accordingly and
> > > + * indicate so to the caller.
> > > + */
> > > +static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
> > > +					unsigned long delta, bool *locked)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +	long pages = delta >> PAGE_SHIFT;
> > > +	VMA_ITERATOR(vmi, mm, vma->vm_end);
> > > +	long charged = 0;
> > > +
> > > +	if (vma->vm_flags & VM_ACCOUNT) {
> > > +		if (security_vm_enough_memory_mm(mm, pages))
> > > +			return -ENOMEM;
> > > +
> > > +		charged = pages;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Function vma_merge_extend() is called on the
> > > +	 * extension we are adding to the already existing vma,
> > > +	 * vma_merge_extend() will merge this extension with the
> > > +	 * already existing vma (expand operation itself) and
> > > +	 * possibly also with the next vma if it becomes
> > > +	 * adjacent to the expanded vma and otherwise
> > > +	 * compatible.
> > > +	 */
> > > +	vma = vma_merge_extend(&vmi, vma, delta);
> > > +	if (!vma) {
> > > +		vm_unacct_memory(charged);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	vm_stat_account(mm, vma->vm_flags, pages);
> > > +	if (vma->vm_flags & VM_LOCKED) {
> > > +		mm->locked_vm += pages;
> > > +		*locked = true;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static bool align_hugetlb(struct vm_area_struct *vma,
> > > +			  unsigned long addr,
> > > +			  unsigned long new_addr,
> > > +			  unsigned long *old_len_ptr,
> > > +			  unsigned long *new_len_ptr,
> > > +			  unsigned long *delta_ptr)
> > > +{
> > > +	unsigned long old_len = *old_len_ptr;
> > > +	unsigned long new_len = *new_len_ptr;
> > > +	struct hstate *h __maybe_unused = hstate_vma(vma);
> > > +
> > > +	old_len = ALIGN(old_len, huge_page_size(h));
> > > +	new_len = ALIGN(new_len, huge_page_size(h));
> > > +
> > > +	/* addrs must be huge page aligned */
> > > +	if (addr & ~huge_page_mask(h))
> > > +		return false;
> > > +	if (new_addr & ~huge_page_mask(h))
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * Don't allow remap expansion, because the underlying hugetlb
> > > +	 * reservation is not yet capable to handle split reservation.
> > > +	 */
> > > +	if (new_len > old_len)
> > > +		return false;
> > > +
> > > +	*old_len_ptr = old_len;
> > > +	*new_len_ptr = new_len;
> > > +	*delta_ptr = abs_diff(old_len, new_len);
> > > +	return true;
> > > +}
> > > +
> > > +/*
> > > + * We are mremap()'ing without specifying a fixed address to move to, but are
> > > + * requesting that the VMA's size be increased.
> > > + *
> > > + * Try to do so in-place, if this fails, then move the VMA to a new location to
> > > + * action the change.
> > > + */
> > > +static unsigned long expand_vma(struct vm_area_struct *vma,
> > > +				unsigned long addr, unsigned long old_len,
> > > +				unsigned long new_len, unsigned long flags,
> > > +				bool *locked_ptr, unsigned long *new_addr_ptr,
> > > +				struct vm_userfaultfd_ctx *uf_ptr,
> > > +				struct list_head *uf_unmap_ptr)
> > > +{
> > > +	unsigned long err;
> > > +	unsigned long map_flags;
> > > +	unsigned long new_addr; /* We ignore any user-supplied one. */
> > > +	pgoff_t pgoff;
> > > +
> > > +	err = resize_is_valid(vma, addr, old_len, new_len, flags);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/*
> > > +	 * [addr, old_len) spans precisely to the end of the VMA, so try to
> > > +	 * expand it in-place.
> > > +	 */
> > > +	if (old_len == vma->vm_end - addr &&
> > > +	    vma_expandable(vma, new_len - old_len)) {
> > > +		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);
> >
> > You use delta twice here (new_len - old_len).  I assume this is
> > different in the next patches.
> >
> > > +		if (IS_ERR_VALUE(err))
> > > +			return err;
> >
> > Doesn't expand_vma_inplace() return 0 on success, error otherwise?
> 
> Yeah, this is copying some already dubious logic from the original (trying to
> _somewhat_ minimise the delta here).
> 
> At any rate, a later commit addresses this!

Thanks.

> 
> >
> > > +
> > > +		/*
> > > +		 * We want to populate the newly expanded portion of the VMA to
> > > +		 * satisfy the expectation that mlock()'ing a VMA maintains all
> > > +		 * of its pages in memory.
> > > +		 */
> > > +		if (*locked_ptr)
> > > +			*new_addr_ptr = addr;
> > > +
> > > +		/* OK we're done! */
> > > +		return addr;
> > > +	}
> > > +
> > > +	/*
> > > +	 * We weren't able to just expand or shrink the area,
> > > +	 * we need to create a new one and move it.
> > > +	 */
> > > +
> >
> > So it's more of an expand_or_move_vma()?
> 
> I think that's misleading, because it would be
> expand_or_move_and_expand_vma() or expand_in_place_or_move_and_expand()...
> 
> Unavoidably we have to abbreviate, I tried to differentiate between the two
> cases with the 'in place' stuff.
> 
> So we _try_ to do it in place, if not we have to expand elsewhere.

Fair enough.


> 
> >
> > > +	/* We're not allowed to move the VMA, so error out. */
> > > +	if (!(flags & MREMAP_MAYMOVE))
> > > +		return -ENOMEM;
> >
> > and by flags we mean... the flags from the syscall.  This gets confusing
> > with map_flags.  At least there's only two and not six flags.
> 
> 3 flags (MREMAP_FIXED, MREMAP_MAYMOVE, MREMAP_DONTUNMAP) :>)
> 
> This becomes clearer later, I'm not sure saying mremap_flags really adds
> anything but noise though.

Okay.

> 
> >
> > > +
> > > +	/* Find a new location to move the VMA to. */
> > > +	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
> > > +	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > > +	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
> > > +	if (IS_ERR_VALUE(new_addr))
> > > +		return new_addr;
> > > +	*new_addr_ptr = new_addr;
> > > +
> > > +	return move_vma(vma, addr, old_len, new_len, new_addr,
> > > +			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
> > > +}
> > > +
> > >  /*
> > >   * Expand (or shrink) an existing mapping, potentially moving it at the
> > >   * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
> > > @@ -1048,7 +1241,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> > >  {
> > >  	struct mm_struct *mm = current->mm;
> > >  	struct vm_area_struct *vma;
> > > -	unsigned long ret = -EINVAL;
> > > +	unsigned long ret;
> > > +	unsigned long delta;
> > >  	bool locked = false;
> > >  	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
> > >  	LIST_HEAD(uf_unmap_early);
> > > @@ -1067,70 +1261,38 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> > >  	 */
> > >  	addr = untagged_addr(addr);
> > >
> > > -	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
> > > -		return ret;
> > > -
> > > -	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
> > > -		return ret;
> > > -
> > > -	/*
> > > -	 * MREMAP_DONTUNMAP is always a move and it does not allow resizing
> > > -	 * in the process.
> > > -	 */
> > > -	if (flags & MREMAP_DONTUNMAP &&
> > > -			(!(flags & MREMAP_MAYMOVE) || old_len != new_len))
> > > -		return ret;
> > > -
> > > -
> > > -	if (offset_in_page(addr))
> > > +	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
> > > +	if (ret)
> > >  		return ret;
> > >
> > >  	old_len = PAGE_ALIGN(old_len);
> > >  	new_len = PAGE_ALIGN(new_len);
> > > +	delta = abs_diff(old_len, new_len);
> > >
> > > -	/*
> > > -	 * We allow a zero old-len as a special case
> > > -	 * for DOS-emu "duplicate shm area" thing. But
> > > -	 * a zero new-len is nonsensical.
> > > -	 */
> > > -	if (!new_len)
> > > -		return ret;
> > > -
> > > -	if (mmap_write_lock_killable(current->mm))
> > > +	if (mmap_write_lock_killable(mm))
> > >  		return -EINTR;
> > > +
> > >  	vma = vma_lookup(mm, addr);
> > >  	if (!vma) {
> > >  		ret = -EFAULT;
> > >  		goto out;
> > >  	}
> > >
> > > -	/* Don't allow remapping vmas when they have already been sealed */
> > > +	/* If mseal()'d, mremap() is prohibited. */
> > >  	if (!can_modify_vma(vma)) {
> > >  		ret = -EPERM;
> > >  		goto out;
> > >  	}
> >
> > This could be delayed to the munmap() call, which will also check to
> > ensure this would fail.
> >
> > It doesn't really cost anything though so I don't think it's worth it
> > here.  Maybe something we can keep in mind for the future...
> 
> Happy to address but I think would be better in a later commit, as this one
> is more like 'keep things the same but restructure', later commits do
> deeper changes.

Right, yes.  Me too.

...

Thanks,
Liam

