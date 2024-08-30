Return-Path: <linux-kernel+bounces-308026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB19B96562B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB291C22545
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD10716D9C7;
	Fri, 30 Aug 2024 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FIUxMWPp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KVmrCEOh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62114E2EF
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990535; cv=fail; b=PFFFY00uxBMuOXwagnmrwEJAYArijsKWWnPw/ygO3TKwLgnpI0zSPqiigMEiS7ca9T0LPiUpa/44ktQgqo8fcJvoEJmIkpvbSChmd5ysZq0k25zSevv1sKP2PqAwXuFeCaBZBT+SwbopiBqN/7YTnft3Q+FHIQXyirPG2KHgdg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990535; c=relaxed/simple;
	bh=4jMdX+QLIvC5a42fwvlsXVROM/J/4prkMvfzrdKjGBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9OPUtOXdR+Nd9ZUbK6sU8rRUUoDbz70cY5dBAoehj8xCrtbcPvWD6aogUiSgkTBVyHkrbCWZiWsVROijpuIv87QS2Ro5lSCKIBIyu0Rto7TDlf3SpyUjn7QUGzwoSaT4bXLPGqJb76vbUUhXEIkUxhQMGsXM4xJFcRsZZs5Ygs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FIUxMWPp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KVmrCEOh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2t1Hm018731;
	Fri, 30 Aug 2024 04:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=IkBZ6GD23mbbB8bJTVNg6HDcbosrtE9UJ0jUv27UWio=; b=
	FIUxMWPpig3MoPvn1N9nov6adRhP8qByjAwvvi5ha3haGaOHTrS9S47LvZZ9o99Q
	rkvPgLxA0KuBxrqhnIcI9EIUqFAa843cpC0glod5dHJAMlWNmopLfwivItuoKG1C
	vjbVxXr5GUjqsUIk/KBh54PS6vG8MRT+Eh6KvOzwaoT9hRkByJ5Ww0W9BSSx7kj/
	sRT98mGch8VDWHBNdqj5MKg/2a/VPKz0fUx9V/LrD3+aFPnTI5Fl0QIoSWm2pofI
	YJ8WSepz4apAV2N/SPNhO3QhKEr8Euzgw6zXFKKnuIKeA48ig1oNou0EeEpwFx9k
	mEsuNby8bgGvsgrEsnqzdQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b5q381j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U1FiMp036757;
	Fri, 30 Aug 2024 04:01:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2trw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpdL20deIAHzhKov6aCdca3RM2IpLONvMZXtXEzgI8oTlZHKRQIgybUqx2CTfW/AkXU9REf62UB5w6EWGxNl6YkcMv/ur6poD2d7N6eFBRnB6MaruYMbT6SCTWYnsMcK4W+Rt55NsQdV471zqL8isXydX1PnNCLku1aiE8NAR2xcNgFu5ORXshJpEK+LJBOojQ9hxNCTc9Ew/sbgyd0F5TV4pbZcpLFkrmtwmw2aTpsz+DNiF8I/VN9x2PrCf/BAEgDKwFrfMKt6XEXWCoxbz3C7tLFAOZ2GyEa7/kAWC+QrnZ0UBEoCv6MvQGVmR30grWOP9pakqp+F3MUu5kO5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkBZ6GD23mbbB8bJTVNg6HDcbosrtE9UJ0jUv27UWio=;
 b=SbIGnQczqAxSxrj2CJlHbxsz9d1ytRNt7wPNOHOsj7J8SB5mnv54FOtWebnJDPWwjV4t07+o8opHDXzN3jzLdRqCkmNCPhk6sqh1stwT4Vdhy/e3Ig5OPnpADaEGsg2bxDmQC377tTG8TpIdZQt5HGhNqwjKdrMnDyxn+EjLcSx1rItAdWZ4YKwf2tTs/454Q8Bo79476KffKoGbKkAUgxSVhFlIyTpqrhtcc7UhGp0EgCnm7quj+xs5n4E9YuZ2N0doxQdO8mVCl2Jt1oFGpgFt3lHmrcphogT/1xTLveXbKkkbVin6dSC3YFFPOvMcR50XRBnWgvulPYFSfDrmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkBZ6GD23mbbB8bJTVNg6HDcbosrtE9UJ0jUv27UWio=;
 b=KVmrCEOh81hlGBngWm+OuYkDsVi5rzFuwbGkckjgjcOntFCbNUqst8RL0CtwbBAsk1bIrqsPr5pELkcpw4QjL4/H/4tCD2rzdFzxXlhyZl2KJTyWQkEENsOAl7hUYf7MlUD9ObKQWp/DcJ0baIDN5kaiX43INmMJlflTbXdlhgI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 04:01:54 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:54 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v8 21/21] mm/vma.h: Optimise vma_munmap_struct
Date: Fri, 30 Aug 2024 00:01:01 -0400
Message-ID: <20240830040101.822209-22-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ff8fb2-7576-4cf8-f03b-08dcc8a87c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G7jf839ShxVKWgFTzRVkF4+HO4/VytUIjIQFQFS5fy9mUfaCLRD3rRlJoF7d?=
 =?us-ascii?Q?EKBzGJmb2XeGz/f2ejXAGzcTJgVoXu4+gfdaeF7gp1FpUJiopS73laK9RgKJ?=
 =?us-ascii?Q?Q9RLApqB/HJbSRi/7eSwWA53BV9XH7dCru6b4EkgrYaNf/FVVoEvb2NJUNxC?=
 =?us-ascii?Q?3IueTmVi8bJFTpdZQQePYb4H0xU4IV9lUoESdkIu9Z28mfb79ov6QD6jodJC?=
 =?us-ascii?Q?VEeF45dOvFqRj4ByeUDZ/Ql9e6fOZoPcH63NlYcaOBsI8Eye1/dXYiaW7Hc7?=
 =?us-ascii?Q?JLxL/eUoB6Y+wgtT8DKPVe6k3yZBl84s9HZow+I9ki/q/aBEEE8oF9PJsOlx?=
 =?us-ascii?Q?jGQX5sr0V0CLVwozW1H2/Up1AZ170uGFV+pN4eg20uRcv1g8EO4D9b3M6tEe?=
 =?us-ascii?Q?8WkRvVxSsMAXK+i8KU35F5bFZlAPwbrJjYiXVckvgJmwW0j1UvAm6/ODtAFy?=
 =?us-ascii?Q?o6FfPdizYl9SvrtA6TfPMO3Y56wcId+qyPG82xufmECiXsiLgfQoHAR1HJUc?=
 =?us-ascii?Q?1zT8ib6rvdKuQSdG2/0U+0rXXoJT2+RyW7FjLkcu/5X2IvxlO70Cy17dAVKn?=
 =?us-ascii?Q?ZuDio34lNT1WeTjylzH+5NB4Jx2R1UDWBJLv4+sXseLkIXXz2AXSxNffD0hO?=
 =?us-ascii?Q?WsTJp1+vZGtfcFVRG++L5z26UcpEyxYKVlNJNsEBQmGwzzOKLoMeZvKKvK3c?=
 =?us-ascii?Q?6KBwsS/uYOAJid4bO7ghITxs1decIIgHzdJY2f9lHAsUIGM0fFJ9LUTMC0q5?=
 =?us-ascii?Q?2XmNTKhZtPPujhSI0OaRcvbThMElDwaEbuBzBMt/MLWdxoUPdaEH4gQyBra8?=
 =?us-ascii?Q?YV9CPIYYp72xRnwFaD+lAulR9C4LjSKfDRhpThq6mW906U6EbNIpyUvgT5K5?=
 =?us-ascii?Q?FAqFf2r+8n92L0hVT2wzy+sVWD/0kNVWnoDHvv8zuYVAhFQ+fn7SPMAS454k?=
 =?us-ascii?Q?NSPcby2mSMzVZ7zjAzB90668ne26pMWu5MWu6hC9CYBgV/NZiQP6qMm0dDuc?=
 =?us-ascii?Q?WuszPadmhWbKOg+KUc8A8+H3Rc5GQwK2GfRAdECtmc32klX4Q9Z0uG9reH6c?=
 =?us-ascii?Q?p7570kQqjh/zrKybMTKelDwtCJxr6JcfYiRNoiGJcvq4ZwolQefkg7TWAUIj?=
 =?us-ascii?Q?cDN34J9nBtnc4YvEp9/fmYRjy/5EJqbsX6SrZnCoV5b3haQLVM6x4PTwYdU4?=
 =?us-ascii?Q?VHrOlatR5xe2IXsm1OkpS86HtUvoQLKApkQ9bsQMRICoXGJ8myOvAIPep9NE?=
 =?us-ascii?Q?C15JK37nAIYqRT594MESvTWiJA5SrBhfrjjHpyKuz7jek9ao7pWuR2eEyGIf?=
 =?us-ascii?Q?O7pqJEfK2KP4fksnUX0GDbr8TSE+MdI0OTvzXgFGJU84hQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d67dAFAilp4OI8vPR6X2c1g5p3Zv+4W1lLCe8ZqyfQFpXTcy7283DdOMVgUq?=
 =?us-ascii?Q?ZKI9yY+TxxH2FCCpx02V1gXII1hKmeMnEqUX0f4hrNzXF06nMeO4SuIo2WG1?=
 =?us-ascii?Q?d/zCn7K7X7K/UYnKsWmIY3YQR0WqNYx7JLvXF3zjriAM0Sh7fU5RxyU1f7Il?=
 =?us-ascii?Q?lOEGsqarBgU9fMj806q+WKuS0R7xCna2w7ScxIQlUjN+84ssCiZlwB7CPkBo?=
 =?us-ascii?Q?mIC7fhNhpPPkUtwrx5fW5PZTxultJW2lanSSfpmyv97MFFFzcXibh4TfkGdh?=
 =?us-ascii?Q?MiwBAGCwC5/2yp5GyvyUtWC+oY7aCAPzOeQM0WjOoENtjqjgmRTi63PMNaGC?=
 =?us-ascii?Q?RMdIqzAD5FjVuOuELs3ax7/D+STZPohonk/BDVAhZM9aWns0f1X8OoVmHgOy?=
 =?us-ascii?Q?2Fe04bVmjz/IqDZYPZ4J433rPOvhFlTr6PyaSJZNPog7Ga1seL2di60zrxyg?=
 =?us-ascii?Q?BtWnrwCgVeBdCX8a9zRuNN0i8BmVAVcFfS3tkWGUEj2Ukab787UWY6qb7506?=
 =?us-ascii?Q?71mOdBBT/GwW0kdcNYoTYVOS37PBqfDlNoqtuehU2ISurgwbnmDJ0Y4d+uY+?=
 =?us-ascii?Q?b8fTdtSRsvmf/Bmpu69q6o4d+erVaWDW3dixiaL8Sl8mkFPUYiq2aVcNCsBa?=
 =?us-ascii?Q?fpEQRt86kJER0b5eHOP8yFL7O9ROdl8WEZTAu1qqz7AoyForOrib2DaV4iwE?=
 =?us-ascii?Q?eWMhVHfdBoh42cT7V3Eju3/pMqY9VqWhrX2DIPYs1A7vN08QrHo//wOxf+RI?=
 =?us-ascii?Q?1v45WB7E7AhfMfIdBpaZbAJXqxIN4TOaqsiS/t0vp4SKwO2XZmi2CA9NB8Sm?=
 =?us-ascii?Q?tcjrKIY6868bDq9HYXFlHQkHEpxnOnmypthD555bPx1zv5wI9D8Q4qkkMRGW?=
 =?us-ascii?Q?WBxdieSGt0SyWGL4Ps95ViVlnF4mVL6saFM5RucI6x4qgQy1/Am0wNuxo1hz?=
 =?us-ascii?Q?gZTq/XD+N/95nYvqZD9D6g34ryskg9HIUDSY7IaRNupaA1AzTZAX9wfpN+ft?=
 =?us-ascii?Q?3Q8htH41snxqqogUvOnPMXwKMJaaKHnVfdQlmRNBsXuL+xVuDKj6fISY2gI2?=
 =?us-ascii?Q?0uga7UGtLlAK6Z36uBleHz9ftBhsVtoktiAr6J5miWS3Yen0yvPZpypndwtS?=
 =?us-ascii?Q?0huIIJQoVpChfZ5X3/MJUnOAmBKRZT2Mk6bCwqgOvALzlasDd2ji/hkZLNAu?=
 =?us-ascii?Q?c8aGzWS+ktX+IZkeU6yikskF5nIe55KJy929OYRj4mIHj54pwhKTgzz/eGSX?=
 =?us-ascii?Q?NUeR0dSfCVdrWe1WyoGl1NxdhrDr6gMHyjxNlBVQA0wQPusHFQ393/qwQzc8?=
 =?us-ascii?Q?5hGKdHFo1u13Un2+V9R3cQp7gzbaj2/x3bcNdM5hD9wSWekDEmQP71qIYWvL?=
 =?us-ascii?Q?xnwdmhwIXc+HLYNCjmD3KJi+ymaizR6UzrQQiGB16S8+neXFeqoTCzF5/gJC?=
 =?us-ascii?Q?wH1cYsweoGuAjTD7CwzabKHiP7e3yWPbQYPuGocZ3rcsBQ6WU2Sm00niJ1YT?=
 =?us-ascii?Q?tEbfDhxx/XF5/owzkIUjJ3DondCbSpL33zjyjYw23iuHD/aUeWpfa3ZpaFfp?=
 =?us-ascii?Q?6Lm4EcO9mUGIoxXbasQkzM8ERjQJc8ovpa9KvJ5+ZyUB1iohxfFAI8piO3wV?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1oQA15hjtjlfNQAwAP1GanlpFtXf0PZmB+yPy1l9jtH/1/a1UA1maPhbHknPm9pHPy4pRK/pML3CkiKcTZCNZvAliAu7dlFko2aKtSzA8DTp5dpsNOFaO6Vx6y+6jNjBYu144zn6yCDHA8b9cZhCanA28rIh8urXjzjsFX+Idh9Mk0xNNb8Nd3GYIUjJ48mQHVRWV1aUca0y+S8SNmkviotmqYhn+alG7Fxu+OTmvmAbU5WwJC5KPdtD0SUj+jmFGTLwo5MSb7R/SfG4OBvZELUWyHTtiwDLs9V3221viLyLw6akZd2qMIc8JGsjraADBxLvGeDwY2IGGLp3l8o0hrYkjX/PTgz6zU3bXuYWBbPAf5wfQsatF8XeOw9A6u0+mVZy6z+3tHHMT9M1FRDWBBpFeL8bfd6Fg70BDGt0EmKXz3OXMhgXdK984yIikie/K5VKcPXsFsetWEZqJNHdT5sN0AYUFmiPdqsG0f18NRL57ZEm7RgzUWbqgzkmviLIZl9GlK7/q0fa8WFXV+qVeYXk/kEYpAdzdrxKa6jR+2Xe+L9UVUNMDB4RYgF3GyVxfDdHrCh/nuV+mLYm1agobk0RSDA/AdzNoH6AowuUK+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ff8fb2-7576-4cf8-f03b-08dcc8a87c26
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:54.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bf7QfIcvpBhcxfum2CBcEIEQUh9LyZOhMT1syy0IsJ0EZaueALB0HvUG471D3Ltj4Qe/KnwO5yU0HUCpTtdlKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: GxSzGFAWR-p-cHxD2Uvldj6tTmhvTIDs
X-Proofpoint-ORIG-GUID: GxSzGFAWR-p-cHxD2Uvldj6tTmhvTIDs

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The vma_munmap_struct has a hole of 4 bytes and pushes the struct to
three cachelines.  Relocating the three booleans upwards allows for the
struct to only use two cachelines (as reported by pahole on amd64).

Before:
struct vma_munmap_struct {
        struct vma_iterator *      vmi;                  /*     0     8 */
        struct vm_area_struct *    vma;                  /*     8     8 */
        struct vm_area_struct *    prev;                 /*    16     8 */
        struct vm_area_struct *    next;                 /*    24     8 */
        struct list_head *         uf;                   /*    32     8 */
        long unsigned int          start;                /*    40     8 */
        long unsigned int          end;                  /*    48     8 */
        long unsigned int          unmap_start;          /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        long unsigned int          unmap_end;            /*    64     8 */
        int                        vma_count;            /*    72     4 */

        /* XXX 4 bytes hole, try to pack */

        long unsigned int          nr_pages;             /*    80     8 */
        long unsigned int          locked_vm;            /*    88     8 */
        long unsigned int          nr_accounted;         /*    96     8 */
        long unsigned int          exec_vm;              /*   104     8 */
        long unsigned int          stack_vm;             /*   112     8 */
        long unsigned int          data_vm;              /*   120     8 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        bool                       unlock;               /*   128     1 */
        bool                       clear_ptes;           /*   129     1 */
        bool                       closed_vm_ops;        /*   130     1 */

        /* size: 136, cachelines: 3, members: 19 */
        /* sum members: 127, holes: 1, sum holes: 4 */
        /* padding: 5 */
        /* last cacheline: 8 bytes */
};

After:
struct vma_munmap_struct {
        struct vma_iterator *      vmi;                  /*     0     8 */
        struct vm_area_struct *    vma;                  /*     8     8 */
        struct vm_area_struct *    prev;                 /*    16     8 */
        struct vm_area_struct *    next;                 /*    24     8 */
        struct list_head *         uf;                   /*    32     8 */
        long unsigned int          start;                /*    40     8 */
        long unsigned int          end;                  /*    48     8 */
        long unsigned int          unmap_start;          /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        long unsigned int          unmap_end;            /*    64     8 */
        int                        vma_count;            /*    72     4 */
        bool                       unlock;               /*    76     1 */
        bool                       clear_ptes;           /*    77     1 */
        bool                       closed_vm_ops;        /*    78     1 */

        /* XXX 1 byte hole, try to pack */

        long unsigned int          nr_pages;             /*    80     8 */
        long unsigned int          locked_vm;            /*    88     8 */
        long unsigned int          nr_accounted;         /*    96     8 */
        long unsigned int          exec_vm;              /*   104     8 */
        long unsigned int          stack_vm;             /*   112     8 */
        long unsigned int          data_vm;              /*   120     8 */

        /* size: 128, cachelines: 2, members: 19 */
        /* sum members: 127, holes: 1, sum holes: 1 */
};

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/vma.h b/mm/vma.h
index 6900e95bcaac..85616faa4490 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -40,15 +40,16 @@ struct vma_munmap_struct {
 	unsigned long unmap_start;      /* Unmap PTE start */
 	unsigned long unmap_end;        /* Unmap PTE end */
 	int vma_count;                  /* Number of vmas that will be removed */
+	bool unlock;                    /* Unlock after the munmap */
+	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
+	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
+	/* 1 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
 	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
 	unsigned long exec_vm;
 	unsigned long stack_vm;
 	unsigned long data_vm;
-	bool unlock;                    /* Unlock after the munmap */
-	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 };
 
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-- 
2.43.0


