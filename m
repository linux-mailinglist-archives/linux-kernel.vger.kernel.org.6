Return-Path: <linux-kernel+bounces-547483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C37A50A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19587A5126
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2371C19DF48;
	Wed,  5 Mar 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DLASd5Wb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xOJxavhL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439D16426
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199721; cv=fail; b=FzM8TUaMR2PP7t2McRcYPSrw6D+RHrqAsJFhLb6OJZ96Ll/4a5+7TEwzudGwK4k4okplmH3vBA0twhtu9Oi0+THAq5UVStXX6E1AnlqNQmqls2MOFCbxdUtv8ArQQac9o1d9GPuZ1ZK6OnYFzwPPi4pSUvkEm7Ib7TCQ8D+qFNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199721; c=relaxed/simple;
	bh=fMbBkk0H6i2vfCwyEwaNW3NYWfb9pc2vbRY5SoDXrGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EWFX8ns9YTxQp6zIDkR3K5wQKQbkJ3IWK3TwsuEmwbpS78VvN0biMpfGpKGCegFDmn75J4CNDvz9/4K3ufOcK5ycxVWyTQ6eNn0dkhXP57Im0UaeMCOMmtvCi5yaKiz604kMZRRiDb3b5sMx47y9p02yXEmSGk1UV/UPLsROnFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DLASd5Wb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xOJxavhL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMsxV005838;
	Wed, 5 Mar 2025 18:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GeFBMtzLQ5RfehHgFW
	TkrSImMifIYUOytUvsYd8i9ks=; b=DLASd5WbPneYbqt7UU9/m4NIeCo75Eb1+3
	tT5Y1xiZLLozsSBceWE6A4M5CbydQ4YKN+9fXBiolg3QkrUN2SRiaHOLyOSKkueg
	UefNvmGRdX+WcJK4dNl7Oqb2kDDJ6IYblXYFhz//pMdHf44ZTbsR/1J9zedyfluG
	D3jnTDYI6uLgnkFBPn39K2aStH2ZnXQSzs2IvSn8mEWlGiiQKIhaaBHc+C6TE3yk
	+0qiElH3kD1ZH69QkxC1nKJ2zXNc1KshV8X8vzS8SdensYqf8uD1uNMbM/3vzULH
	5lkFDVNgR9qiOhJH5K06fjPa+0Vy8UxfNNokB4dHIb0qY29TKvSg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wr7rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 18:34:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525IPrV8017866;
	Wed, 5 Mar 2025 18:34:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbykc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 18:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BClClSiO3NOr7O/sCgGmm/I3e1dhXwPPkV1CYIOsrxdT6s5ewO8WmyRmGTxnbq/BDPgZpIqdtVF6m2LbP6urQuBVBLfi4ta0HonGFn7MlBTuoEieOBXYB9DL6xLjfxdetqlp+8cQhVcFhLpGH1YA1NvlrNJ3/QcFUavlZlITgM2HfZ26TgjsNkcOmAh5R1FqAtJPIVZ+lFVr+/B1zGpHE3TvfIMcFbaReaedDGByIZxjiduyejHWDEzAdtoDojEo0vtLDSKF6aaQN8TrzHgoqThHpQRJMlDsp7nwuVmdZYfkrv/K1BsbCnRJNlYuhWbdgFjFuvqwRRcDmGhnIO2Ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeFBMtzLQ5RfehHgFWTkrSImMifIYUOytUvsYd8i9ks=;
 b=ZOpLu2mIka8gabpLKhbsSFbnY17kmdrxsJIzP0pBulYdhRlHJTMs6bCcIFuj29Vyk08XXqSK0tQQvCKf7lp32WcMGUam980r87TMRqieZc8qfJn5bw7NUHB4/vrY+F7dES9pZwWIktLLenPwW/BDZwfOLNfAEb9fVrWI+YBAVGI8KAs7uoY7Rt1qPZXB36voGmyA5TfHzLlVOlTxpZARfjzTTlA8Mhx5M9Zct0+augPa44RYrtsmOzATSW98jCoFuSiLUXxYCYCtqOHe08tpPYYKyY3Pbz03uGtXeJ9rSy5+7Ez+A+bHyx5kuyeqqnh/tlguUMCR/YiunQDY5nOZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeFBMtzLQ5RfehHgFWTkrSImMifIYUOytUvsYd8i9ks=;
 b=xOJxavhL8+f9hQC984VvrkN/gEItqIy+pzgWDbsLaBuFECuvYVgbYtlxGtkAnCZJBnKx+wmiit3oRJe+yf7PMQh4+JQXntdObY2oLBJdR0VWp/Zfij2BM7TET73Ij5fg+K5f7J++HrkFmIK6Sp+m7vPxZskVK68Hto4PkgKyqyQ=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by BLAPR10MB4867.namprd10.prod.outlook.com (2603:10b6:208:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 18:34:55 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 18:34:54 +0000
Date: Wed, 5 Mar 2025 18:34:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: fix uninitialized return code
Message-ID: <07467d4e-4882-4649-8845-c53cb2cc243c@lucifer.local>
References: <20250305172800.3465120-1-arnd@kernel.org>
 <bc7c9b8a-83e7-49f8-bf0a-2f2bb950b99d@lucifer.local>
 <eda53542-14f2-44fe-aa18-8cd3dfe1ed75@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda53542-14f2-44fe-aa18-8cd3dfe1ed75@app.fastmail.com>
X-ClientProxiedBy: LO2P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::19) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|BLAPR10MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a17e84-0b66-4c40-5be2-08dd5c146c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pFCErxNHirz1dpvO8REvncX7i2ytQhrzNo2KWdHrEkuX2x1QL9+AVi0MX3Mr?=
 =?us-ascii?Q?hUFXGs7V8mslqsFpALWUo4i6ENJIAaMTqX5uEIGVn+bkKlGAjbzxRcb1DPFr?=
 =?us-ascii?Q?2KQUEop577ZBGRmKrqfc2ermN87LBWx/OdcKsJL1WPr9kizRcV7vtKqNo+/w?=
 =?us-ascii?Q?7mNxMlS/gb28nGfTAQ9JnZKr5EG59dcweVwLzHE9d5mDLYWFMG4IQlDZwau7?=
 =?us-ascii?Q?ZuiXSuRYVR0zjMo0MIvDGF/Ol6UplvE3pEUjf8+zCsYzWZ6jxmF5yh7C+taB?=
 =?us-ascii?Q?O9aKmRulvtpEAuhnYoO7hUKptx8MqB+VYyMyvttfwLaCOc8WOpp+NHAf/r82?=
 =?us-ascii?Q?m36lTWC9g43hxTN79oXfYg15xVRC79EA6I9slfjRxrYDOQ27QsGVq/hZIkry?=
 =?us-ascii?Q?KklbDyQuoKvvjyiE/98boXvyjFI6HuhPakLQZ1Cn69qiS0Pujr0OBzg7Cw5g?=
 =?us-ascii?Q?iEyVVRQzdW3PiIDNx9N7It/wrUDlZ8cshkydmJiF2LCxJ27hBQ9Gureh75BF?=
 =?us-ascii?Q?1r2P7Or7nkVRa9HLfx3U3b2wUyvpFW0F5D+q7/+j6gtJJhVfN6Bz7mxdupk+?=
 =?us-ascii?Q?8iVkJ9h2MQaweN8j2vfjmnl5VaNMZCWv5iE3ExCKHaYZYwRuaPdedWaVLqQQ?=
 =?us-ascii?Q?vzUoJv/N2lOa/FjJ7jkWNokGq2BcTaHQp2BGa6DgFTnrcKQHMF3ctuCN0tq1?=
 =?us-ascii?Q?xhas5tTMySoTHB+j+AaRsXHe3j0lUnfbn/yNKUSMcB5+fbLkS/bK9onBlHDY?=
 =?us-ascii?Q?jH+TZ64sZMGiFgJFTrFsMkxONW7SaFeHc/ZAs2dxwDL3ykb1Q4xKNhn9kG8S?=
 =?us-ascii?Q?XM06ew19xLsqNB6+YmIVhYVYcRIaBwK4h36TFGRiYM28QqAEHAVqen1ctdYF?=
 =?us-ascii?Q?5w3YWVwbBg0qQdyLS77v1cy9eSloV47EXBe2R5nc/ufiVlIYzCVQMsUjw2C+?=
 =?us-ascii?Q?Atpa7fJDkAI5Jpq3y2Sc6HY7aYM5EoO3cOKDQtSxlHmXl3lSXQ1L0qkZsFJo?=
 =?us-ascii?Q?E9S3vvyoGCXXnV1CPa7dOT3/N9VrHmd7oHxq57LIr/SR+dMPNJoNAY8pI9MQ?=
 =?us-ascii?Q?wasCJwglMh71tIOFPq0h5xC7FiAD9bJ79tq+u0gP2yda4ZUKljY/fUNiXyz8?=
 =?us-ascii?Q?deVN3XgQb72v7btKuZ/xJ5IVO1BA8ubXqek0aB78ukss/3mlD5ieA1x2H9yV?=
 =?us-ascii?Q?1WsSdC3XMSuHyQPBuoBNY6t/kDTNtWHssYOFkT9U+AUTlrRS1kEZ5G9az1ds?=
 =?us-ascii?Q?5zw8zJkJyxiBuhLeZc9fzzxBC3MvQDAPW/vbWjAlSAKU2zgSsUlkcGabSAN0?=
 =?us-ascii?Q?XqBxI0NVPTVAtq6dR+wMgkD1ngt6srIbNF4TrVtoWKl/lMg2KNdEPs153y9k?=
 =?us-ascii?Q?Wbj4ylw75kD9VkF5CRuIMxByuhat?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2VrVnk0Gpi7WZuyhS17j6QJynIvOWc6+smRiUe9InjdGmnK4w6xsBApYQVBS?=
 =?us-ascii?Q?kvs3KPQMBG9M9KzAKHtpbpz5K9MAlGiR2nhe721sU3yTul7i96DDVW6zDMdZ?=
 =?us-ascii?Q?MRrhgOTy+TkDYWzpO5RdtpJFspVZIzaes5jxpA1H/opLxcZpG2U6OGdnMRVC?=
 =?us-ascii?Q?U43A3l0PEgANXAQBm0DuVVsRzSQ3sABmbsh8ydPoRvtU2fbU52VLRcFvuzIA?=
 =?us-ascii?Q?J+lSrZcj3LEkZFmICwiTRaoxFHn3YIXfiJ8BKDTNnmfJ77n4WZF/mYNEfXy7?=
 =?us-ascii?Q?K69hSUSgsM+3DOQUC0cmuUq+lfTuhIZCZENyu9RV6RWw8OEGfbN1+8esEyLs?=
 =?us-ascii?Q?G8x+Z6KnsoGuAwgsT4Nw1E1SmAJnauUDjScuDmE4C1Vf2mcMB5tz21nen6BF?=
 =?us-ascii?Q?lXNPBT++f9UYknRUGdZZU5tOmP/msgK/I3/YrCDw5VoH4p/WhaS4bPpBjPBx?=
 =?us-ascii?Q?X9XaH+7ng8M7h4U2WXXWXw0rfunxQ/kQOeuGRtUPwZJy90Q22GbGyv1LwR/g?=
 =?us-ascii?Q?kVxHdecvWeH10YTQdhgGYv2YDOeUbN/+z30wsvmQg6wcfrnF1giXHs2YpQdl?=
 =?us-ascii?Q?BstkPmulBidDmNkGTE2avQvXwBNJhfEngQLYzTzdI5ypERE/XOyExFhAJqI5?=
 =?us-ascii?Q?aBpL7b86nbVhn1yOW6ywuXRYVyuGWtnWp3rCsddTrXFRYEBLISYYM41TIErt?=
 =?us-ascii?Q?6bxajZmeluoNkCHyY+hKfaZ0hoqAcTD9FjF6PpMdDVU1XTdEO5kwRtQMKzxc?=
 =?us-ascii?Q?rIik4XnqwmYqg9lOnMubAWQ96goK/a0lFk9aAroKxINSjN5blXsnJYSTE9tP?=
 =?us-ascii?Q?i/RgXt301uXA67SUYyTBD9ngosOhR0Pv/AEqhS6+eKeYP0QTN57LAFD/jECe?=
 =?us-ascii?Q?wMW58PS4meZal6OyMvH2bFhfBq++A9z0431EIM7DQn+XAgpqXR/PNJ/TZU48?=
 =?us-ascii?Q?iV7J2fU9cYDz3ZhzS3++gHDAJrtTvWiNeMmiBnfDBpl6okjE0Ul6HETp08jU?=
 =?us-ascii?Q?TjG7TN0B98uILCs1PKzxOXbFVzz1p7mFuUrk8BwKdbWJau9b2/FwKeox8BRx?=
 =?us-ascii?Q?+ESFX9Vvs9cz36rApjmrrs+X9+kQoaoN4wJ/OQpPsSMLhFlTxOr3KLDV/aHT?=
 =?us-ascii?Q?3ZpbhgTqckY9yH7sm65R7wR5IZjgxszOFPiBXxwVZM2ku/nLbnlgkKcDusLx?=
 =?us-ascii?Q?fxvojKGn7d3jap9jI1wKbfETQYqw5rV95hKJti8aIIp4QYvmyUhGg73lGvjW?=
 =?us-ascii?Q?ZbZ33XR6ptlOgvmeLz+V/mAcEOn6Lbd9Tq07rL41gFcne3WN+h8PGmEqb+RF?=
 =?us-ascii?Q?O1SgQSgQ6ctmUl5sRbdzNm0DpVO7WfsIH5q64/nBMIAz60XFaIvzZeCs0Spu?=
 =?us-ascii?Q?Lv+82MmZzulnvJ7HYO+hNW0/bccPpA8SQuEfJ3+ZX5o3AmrM7eNx0EEoJOJI?=
 =?us-ascii?Q?zR+UhAyRykApWqKjo/rKFodU/LW816hbK9dPSxu8pnSzZHbnLMJri+FE7MD3?=
 =?us-ascii?Q?JDwOj6l7pwcYJdNgUr4j/1Sc5F35WFMpni3oY+m7xvp4HdxfYou5jwIjQ5Qw?=
 =?us-ascii?Q?RhklwDw7qe7n6v0e0DKBrNKaUTFdi3tnEX3UIvC9mZCR7ZKjmExUkt0/iiwh?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gs4rF/sIJO8NY8J7uSxj3L1xB6BetzktZCargj9QoJoNMMlSDGBD1In59EgqRpYp15txDvRnX4r5D+AXMPqSXMlxmEERT/vfCxGaVXsfkf9NaehFkfwmo9HYeNQcyUZqhRzyHFsm1XK7pN1rKcpV0ZiA01vM6g6LcVWiqYszzbZHVJurj5eJZzCW8Bjy6qNks/m/mTc0ejUGgQ4vbtnJvIdY4SEc0MiRlZv9ynbIy4Myloh6akbiQ4DfkiVIrRSQJin+LJWDUUby2P6nnhbuuIK+iOhc6bymB9YLFCzfpll7F6h/xHlL7cVW++y8VzdNqq5oJGL9kqgBdXjesUx7uURTCGrBhGaisdpqnheNmSYXFyYHkRmLJFuNOBE9ESsPiB5sS/d64gnuP5txxYEExbiwgjHZbSOzZRbwZrAwLzCo3DWhhnJcMT8LAVg7LSb0gp6guhQIjWlL3modVrjw+1wSDEX1URorz0AnuaWA5tRJSDDUq7LNFmAHYyYaYE66Cy0wdSfPvB9149FIUqKGzKl2Y4AtZb26FtzwiOrbk9WQfAFueX6Mtxajgutz8pPcPBEEYy2WQRiA2aH0EYVDBa3sYtkDAwf3q7MNpf+kP30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a17e84-0b66-4c40-5be2-08dd5c146c91
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:34:54.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmJi16htECyaIsicoWeMHcKdwBaXZVYLjhnUBnpTjxJBfPlgri/NhaQrKWsBbLHX0YJwiIBO1OhcXSCN0SHWBUrJGftAOYzz3fx0SGXfhew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050142
X-Proofpoint-ORIG-GUID: Ybr4q9BC0YWV3n4-3AO-H64pVIZmVRos
X-Proofpoint-GUID: Ybr4q9BC0YWV3n4-3AO-H64pVIZmVRos

On Wed, Mar 05, 2025 at 07:25:38PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 5, 2025, at 18:29, Lorenzo Stoakes wrote:
> > On Wed, Mar 05, 2025 at 06:27:56PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> The 'err' variable is set in a conditinal branch and is not
> >> set otherwise:
> >>
> >> mm/mremap.c:1017:7: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> >>  1017 |                 if (vma->vm_start != old_addr)
> >>
> >> Set it to zero before the initial value is set.
> >>
> >> Fixes: 3129f7896afb ("mm/mremap: initial refactor of move_vma()")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Thanks for this, however this has already been fixed via Andrew doing a
> > fix-patch which should land in mm-unstable,-next soon (possibly tmr?).
> >
> > This is entirely my bad btw, for some reason my compiler locally didn't
> > catch this even with CONFIG_WERROR on which _really_ surprises me...
>
> Unfortunately gcc never shows warnings about conditionally uninitialized
> variables. There is a -Wmaybe-uninitialized, but that has so many
> false positives that it is completely useless and it is turned
> off globally.

OK I notice by building with LLVM=1 this is immediately reported locally,
so from now on I'll make sure to do a clang build too.

At least there is some means by which I can sensibly determine this!

Cheers!

>
>       Arnd

