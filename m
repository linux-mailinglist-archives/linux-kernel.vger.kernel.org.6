Return-Path: <linux-kernel+bounces-229571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670EE9170FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8DA2B26014
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E031317DE10;
	Tue, 25 Jun 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJSJDqwa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iTzP7DrI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560D17CA04
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342744; cv=fail; b=SqRkpmVFPtvIoG/SkswV1vbV4RQRGzZbWJEx5mxGfUCLh3tJ4ZBJaNO8YV50S6HAllvM3vfgGKHH0KG5V23BfOz85lS0m7VjkORlkS0lxPzKhRdkchgGOXkdUHp7PsrC8xop0AVFvKGkz+x6lfBDJ6fLCSHgKdWSCBWPkldWoqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342744; c=relaxed/simple;
	bh=TJe26+4xmfs4cm5MU20Ixh4qXojLenLsmPLjcjqSsvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dKwlIhCyFp4pvipIZZHo/ooslJyStzpEwDYl/zCz5jEpSdo5isLnSkYdoPo/Dg9sEj7iTTk0EOZDJXs/Dmf/cCsOLhD76C5f0KQ3XjZ8LXhS7VaZpn+ENh0hQ0wBjv8DDyAfeKMJfP8mlsDFibPKsk3CK2kiZhKcgnFqNiT9Pw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YJSJDqwa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iTzP7DrI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfXbc021444;
	Tue, 25 Jun 2024 19:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=eRq7JyP2yI0dRhju0RZTyqnMYJTiuiqUZEZuPD6xbEU=; b=
	YJSJDqwa+5+TCTgJLUTj1Cmhk487/LTNbONa1JlKMIMDaCFE44zc5Lnm1qKO2IWC
	XOVbMsSaikQphCg8JzQU0Fdp9vTeg3e5s1qzlYIsrs1jykXmkO+Vw2jlMCNsZ8Ir
	CKHebnIuIRx626oEWIBUq7ZInMrVFYsPPgd/cZK9F0Ab+C7LLqO8E3SUs8moEd46
	rJTCD1/FP/LOl8ejY+DKmvKfngVtllvzcUvAW3iGWlxmdEKTQNrFeANB4yVi8qWA
	AB4sGzSK1c94XoKtVAEqJtKxBfOZsRaFV+H3DpX8jhv0g3+KTpIFEqjGzCpXKp00
	xIHa77oyD9PEqMBqMBmUKw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg99av7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PJ61Pg001320;
	Tue, 25 Jun 2024 19:12:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn28rc1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP0ZL3/ObjUXmGeDUnkGuYQ1Bwr2M8u7KPeK9pq7TEdp/umAx8WX/AK9wDXBeHs0Mj0G13wAoLr8knbw6XA4YUYwrZuhTfrijKfxQLE/4hrsbMAz7MOYWIvwgrt94vNPVI8TPD89Jz2OsGMLfzPCjLYcD6TcvAG9Xm9Efj5eEBd8G2N36C0Bj0z52GlPCt6ZkfFSV9ZZdx13iYJAcb+wLGfQ2r9pQo2SsYYbg7yzknBnRS3Us5qBVOtaQQjCC5OiVYGrZyASQR+OkYCkAnhxc2x6Z6/M9EVYzsNR6Qk38R6DZHbNyGgBaF2C8fuhVVccQsgPp7NvYjzp+ew/gmWtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRq7JyP2yI0dRhju0RZTyqnMYJTiuiqUZEZuPD6xbEU=;
 b=dO0UZPAPzVxJnJnl67ADAevLpXHdcihxMLJi5nxiUTRu1jADcTyvSObIN84W9nrT4suxkQXwgBk8eOKSdmxmtLjB7AQ0L/I3Jv8wv1s8mTf6wHGO+j88J6BMBHTihdQT3Izy2cdr1AfOZhaYdQLK2p+fYFUmk34HtRfSs1LbpHB2k8+4UoUyrTTV4z7zPu1eRuOdg0llEHrm+0TbvkXbM/7wQP1FgOHRyCdm+UCnBMu4Fr1cFpfup1mxS80owwJiDAaUWEUkOE3ETUod5CnL0Srca8VB6C7ZneHIqC7jFsqAEcOE+DkfDZsRSnF6l8ICuYdfiG+3WQ/71WuBoy+YQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRq7JyP2yI0dRhju0RZTyqnMYJTiuiqUZEZuPD6xbEU=;
 b=iTzP7DrIQJRMi8hAjDlw5rh6mBTIga11RPGKm8SlndsSLO2SYDVkxbCFLT6e8Zhon1hNouiIdV7GHxuBz5wh1KNNUvsMbf9C2lGPu4rMnHLbII+kIYmIWGOWnK72bbfxdxR+cP1cONi1WcLTGPfFZ6fwNkt/8mvBJg6QcbKadr4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:12:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:03 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 05/15] mm/mmap: Introduce vma_munmap_struct for use in munmap operations
Date: Tue, 25 Jun 2024 15:11:35 -0400
Message-ID: <20240625191145.3382793-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0336.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 616d0428-3c02-45ff-68f4-08dc954ab243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dJVQWsEQITQzEELYI/Lqtd6uZ7xSl0rd1D16K3J3dB8TPx5+4KMgn5VlRcZz?=
 =?us-ascii?Q?zIiFixI6M41BBapCA409VCgUHg0D9VgaQsb9tBCzktAz9/SFVLYql0LjWL1s?=
 =?us-ascii?Q?TYwPhCag+wW3JJ4JWoQZ7qTLe6w/Fg7pJBCBPV09dWqQnYKrso4izCoLeEh+?=
 =?us-ascii?Q?Q6LK6TUCRvPlklBwzU/ZFW3CDZoc85qqvgNMNel0LW1B7OvsIzF4bgUUTAJJ?=
 =?us-ascii?Q?7ed8zWpXUuQ+NeRZm6LOYtS/8bvXayvZp0xuBEn3ZMlVQo8IiZu3V+c/HxGy?=
 =?us-ascii?Q?uUxvEI6Y3Ae+Pm8/ceHSXoVDK7dnwONcaY8FRF593L32A2ndcUxrTTTENih2?=
 =?us-ascii?Q?uv6ycOSMLGOxsco8iayCkeVzQMQr1fx03ht7qrFeoGKmxwrJTu3GV4KJVN3O?=
 =?us-ascii?Q?ngtDQr40IklrqXHc4w962b5raK18ab0fKI6G9Rz7JKqen/C6ncO8Dtg19b9K?=
 =?us-ascii?Q?bUUrKKrhrilbvb+u1wRxklRgUFI5Ulzy/5a1e9iagUQgi5W7ZoESzc/zGXSx?=
 =?us-ascii?Q?UhdAGo1cotlwwB/VgDf/aIOldx12fM1vTiN57Uv1W4RQS8nzmA42L8MSSZMY?=
 =?us-ascii?Q?CRJRC9NlnFz3X28BovMItRxFPFomO19ZXUegaPZJZvyG+E/CwUHHiAtQsr0V?=
 =?us-ascii?Q?yuQWw639fINs/4WOOKpGQL9fqDNmQMb4dpzyZ7pqt3Hnldn4cMeClVSKnaGy?=
 =?us-ascii?Q?gJRg51z0hH/J4u4HcsPzc3hJLBhbOoHDirVNZb2s3KSWJ19j4RJAHRk0kCHf?=
 =?us-ascii?Q?APMS6zeQX24GbFYwor6I4mpxyRyZXY8VgUQl0f8AXGdzotV5WnBJjiPBmd4K?=
 =?us-ascii?Q?CTlS+W7XYJVRaeAGzRDE1v2n2qmkwuKxgNUYLpAHyPUn7yNZUAHjMC9mOyBZ?=
 =?us-ascii?Q?3G500dm4XSQGczzV9M3SqU3jD7ylPWlCVbOzxoXTGu4fiEAqxiuCWEapLOqf?=
 =?us-ascii?Q?fd4j0jiSNuInm2z7KdgFy8XsVLsxiogqyFvnjnvNtShX/PfdpdcwD9akEVmo?=
 =?us-ascii?Q?pbJSR043Q0oD3OiyyqTU8PQBN9Hv6tiZ+RraY2ISbI9AmewYJuyL8n8nTnjf?=
 =?us-ascii?Q?UGg9z0nmQhdHs8QvMk4qC4/lgUqAS1ehBhj3719WM3NB/GA0B6OAw6RtgtML?=
 =?us-ascii?Q?Xr+CXbNWztWD5BEEOnKf97LllGOj7nuEoigZjWK5J0l9u4n/R/K3JLiMuwHU?=
 =?us-ascii?Q?KvMQ4oAPBF2IaswDYycn50yg/1zYTB4OkgKvt9jkDq/2mNhnQ6XSEmzwEnQm?=
 =?us-ascii?Q?oeCAl/Ux6omUFKW1NWwherMFo7xd8oOVghrIhbDgJIcrzAGqC4IHOIcsPx/c?=
 =?us-ascii?Q?VunWrcD6xQYZKKZjgf67wID1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4iH4xbZ85kdg1iwLgjX3ofdl2cud47vV1BtGuU8H91bHoDBySPhc003PsFQo?=
 =?us-ascii?Q?PMHsYoCIswIAnHfPEIHmzM7BJDYNc80Ubsn6YBOvCX8GU9j21za7yBXzwb9t?=
 =?us-ascii?Q?qXNc3rfz5kkx9/VnrobUDTsOVpTYJBsAKOTTSIedwQncZQLk1hfL3QToWacm?=
 =?us-ascii?Q?XzYNh+tt0C71jPMRrUQFBEsinDrFRK3tEXPxbOfd+slWat2CKkD8jN8RYFK+?=
 =?us-ascii?Q?OPHyNvlGjkXgxPS9+gSIYw8YSJFYYGSHER6gcx5YTozokZAsANUbb4eQrTqa?=
 =?us-ascii?Q?L6b0BvNE/iociVu5PnAPMIhNlb27xd8ggOdOKn3g8dJ0cS1/UBfJqs1moO4t?=
 =?us-ascii?Q?3uoDXJmOJStNugjm+7ix2VzS61xSVsivWJzD9X1sq989ZhaRIeotdV03stRb?=
 =?us-ascii?Q?DAzxhlBjCSChYjOvpXc4lC/TAPZKPl4ay6rpjo+OGG6R311Uhd8qQlxryAfr?=
 =?us-ascii?Q?FxxC7cxPgczI5wlc0fZwBJAyUygB7yWQlWCBFDKOGWtW/Us17ko5i6Nvn3UK?=
 =?us-ascii?Q?Z85gr7YlAJUlcgSBiFXLcKgOzQ7u1aXOQNcQZYB3WiawRQe1LsLAyefR9QEk?=
 =?us-ascii?Q?CdiFJkmrs45mPb1N3xL3LI+0uLn29NhT/6qB74TDKi0uGRXsKmAXwvRZ3L9D?=
 =?us-ascii?Q?LB9wkSk7OT0xI9JMcOXGKBmQZzBjsKwCLcOKOoPMeU6W8Hon5T1tA/JSLqGt?=
 =?us-ascii?Q?royobGLwHkLGOqBXrx4aKjfE+KvGvKwRJH+8sSc8ad5ed7KFdD+AMfY8PD0V?=
 =?us-ascii?Q?62sZ1c4M0fsMxcIAWkl0z07iGXJXATldnapyWJe2l+6I13zJUzIhN/9LEQSD?=
 =?us-ascii?Q?39z0LjoxkgXkQpQX2jGmn4aEr71LaQhFsm8g0ou2wSB/0WdBoUBTNwLtA/xZ?=
 =?us-ascii?Q?olQ7elRzt6KsnyG/LX+NhoUpKx6+8L9lwyRv5vUx/c0d6XIlM0126ku3YxvT?=
 =?us-ascii?Q?/KvhWUgRcmTVygHS/5vgstab42eLH0g1LmQ7TcezjdML0qO1uIPpLTnetI9O?=
 =?us-ascii?Q?ICGjp9Dm9ulafXRRRRINqJdHm0xDLM897jWPpRWdY2sgt+Mt4xNTyIFUZaGX?=
 =?us-ascii?Q?/2kv6uGmmwNR0gKIZowEftsHFOtz/Ph6jh9q2dh2YAUMC7QcvyflDH2pwtl+?=
 =?us-ascii?Q?m9imscY5Jmr3BEhdEt59hyp+ubiwInYyYYVOyczzLveUmDfd0XMKB9L7F6zU?=
 =?us-ascii?Q?PYGMxbxMZLb20ZPk5QUUwWCKDW/i6NT6VXQdfdmhwZIbjC5BBm/H2l4RNkdj?=
 =?us-ascii?Q?FiSfJa1RKMjzgfFSUS4kcD4D6N6IzQ/kgquFxUUu3p8KdN+cV4JYjdz5KI+A?=
 =?us-ascii?Q?uRP5bbb2eVUoo1oPPzDDt5P0xRABNS47vkQclW7ygOzZFsAFOFCdOeTRl2Cq?=
 =?us-ascii?Q?nwyM07c/pxhYJ4cZlJ/NNDftdaKUHfA7zTwtld9MwnoXKu7QTHs3pA0WkfKX?=
 =?us-ascii?Q?YjL4MaV0bsJm1JSW9lQwQQ4KVE7gNNhAYXkRUSxP8Ul3/6ekj9HmZGBulh88?=
 =?us-ascii?Q?cOFDEzrVSlTRNux1HUH00Kv5Lg0pbO7WOdxbDrGB54bGyxoWiJDQM/jqnonm?=
 =?us-ascii?Q?XU7DnOgv+GER5nSpCCISdB1uZVK8ISM3fILjQTN9wbZoyvJOuiN2NKMxUFA0?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	I9SYR3yqE+calzTRTJV668B0ecycMvIpv4Q1oera6UB8rj40oGY5KUh1Yv+9LfcHiMC6DOEeOzqB7sH5OYF9fHJ8toT/AlOsc3ckBpQsRE8qyieov8keUjwyUOak+Aj54qBRKS5vbzr/pPswc+7tG8ofan6dHaFBNFYQaFlariqlkkkfYV88PuhZP5hOrFDQ5iDyHLDYHH9irVcyj4SmtMgnrZlecj44RCiIO9kixdXBlv+xBc3KKiu2va/7ywgjnHnEE12AhKeofgn4Fo9LKU38lz2ATF5FkI1vxQR5Qx6Yhlf4n9GylsWhQ9tkehLbCcNEEcY61sx5UgnjQiLnWSBiSSkgNFO5gkosGNx9P+SFICxEVHApQcLgG2SNU1q1yf3evgiXkaalgWTEO4IUB6dSyokribX3Jsv4OD2foBDsvOhBQhrLaoENaUTCtpuKO9ooMOTQRYs4Y9fM3wI7gqRSdg8b9MbXHtbPSwEiZ8d4HqJZlcKjNzCRYh0E1MHzje58IpIFZb8DIG6HktB148Snj/eRlRbDJ1PkzFNiFExF2dvFp2oXG73rITsX71u0VETkeQ7l66EnT/TuOJsMjOzU5UAfr5DWobAMHus59r0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616d0428-3c02-45ff-68f4-08dc954ab243
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:03.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWBI0C7mDayE8dbiRcb7HgoxgKXXc2IW4jU6FzbvBoreAfyP8lXKI+HIbNoU/FvwaB1VS97gumpp5qZa4RM0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-ORIG-GUID: Qq3Bz_KxF5J0wx83meMA9FSCHhvtb3JH
X-Proofpoint-GUID: Qq3Bz_KxF5J0wx83meMA9FSCHhvtb3JH

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Update vmi_ function names to vms_ to indicate the first argument
type change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/internal.h |  16 ++++++
 mm/mmap.c     | 137 ++++++++++++++++++++++++++------------------------
 2 files changed, 88 insertions(+), 65 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b5e8484059c9..22563c959861 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1480,6 +1480,22 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };
 
+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct list_head *uf;		/* Userfaultfd list_head */
+	unsigned long start;		/* Aligned start addr */
+	unsigned long end;		/* Aligned end addr */
+	int vma_count;			/* Number of vmas that will be removed */
+	unsigned long nr_pages;		/* Number of pages being removed */
+	unsigned long locked_vm;	/* Number of locked pages */
+	bool unlock;			/* Unlock after the munmap */
+};
+
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 8dc8ffbf9d8d..76e93146ee9d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -500,6 +500,31 @@ static inline void init_vma_prep(struct vma_prepare *vp,
 	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
 }
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = 0;
+}
 
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to altering
@@ -2606,78 +2631,59 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 /*
- * vmi_complete_munmap_vmas() - Finish the munmap() operation
- * @vmi: The vma iterator
- * @start: The start address
- * @end: The end address
- * @unlock: Unlock the mm or not
- * @mas_detach: them maple state of the detached vma maple tree
- * @locked_vm: The locked_vm count in the detached vmas
- *
- * This function updates the mm_struct, unmaps the region, frees the resources
- * used for the munmap() and may downgrade the lock - if requested.  Everything
- * needed to be done once the vma maple tree is updated.
+ * vms_complete_munmap_vmas() - Finish the munmap() operation
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
  */
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct mm_struct *mm, unsigned long start,
-		unsigned long end, bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
+
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *prev, *next;
-	int count;
+	struct mm_struct *mm;
 
-	count = mas_detach->index + 1;
-	mm->map_count -= count;
-	mm->locked_vm -= locked_vm;
-	if (unlock)
+	mm = vms->mm;
+	mm->map_count -= vms->vma_count;
+	mm->locked_vm -= vms->locked_vm;
+	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
+	prev = vma_iter_prev_range(vms->vmi);
+	next = vma_next(vms->vmi);
 	if (next)
-		vma_iter_prev_range(vmi);
+		vma_iter_prev_range(vms->vmi);
 
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
+	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
+		     vms->vma_count, !vms->unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(mas_detach, 0);
 	remove_mt(mm, mas_detach);
 	validate_mm(mm);
-	if (unlock)
+	if (vms->unlock)
 		mmap_read_unlock(mm);
 
 	__mt_destroy(mas_detach->tree);
 }
 
 /*
- * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
  * and marking the vmas as isolated.
  *
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
+ * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
  *
  * Return: 0 on success
  */
-static int
-vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf,
-		    struct ma_state *mas_detach, unsigned long *locked_vm)
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
-	int count = 0;
 	int error = -ENOMEM;
 
 	/*
@@ -2689,17 +2695,18 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 
 	/* Does it split the first one? */
-	if (start > vma->vm_start) {
+	if (vms->start > vms->vma->vm_start) {
 
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+		if (vms->end < vms->vma->vm_end &&
+		    vms->mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 1);
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
 	}
@@ -2708,24 +2715,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vma;
+	next = vms->vma;
 	do {
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
+		if (next->vm_end > vms->end) {
+			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm += vma_pages(next);
+			vms->locked_vm += vma_pages(next);
 
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -2735,16 +2742,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
+			error = userfaultfd_unmap_prep(next, vms->start,
+						       vms->end, vms->uf);
 
 			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
+		BUG_ON(next->vm_start < vms->start);
+		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*vmi, next, end);
+	} for_each_vma_range(*(vms->vmi), next, vms->end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2753,21 +2761,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
-		vma_iter_set(vmi, start);
+		vma_iter_set(vms->vmi, vms->start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
+		vma_test = mas_find(&test, vms->vma_count - 1);
+		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, count - 1);
+			vma_test = mas_next(&test, vms->vma_count - 1);
 		}
 		rcu_read_unlock();
-		BUG_ON(count != test_count);
+		BUG_ON(vms->vma_count != test_count);
 	}
 #endif
 
-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
+	while (vma_iter_addr(vms->vmi) > vms->start)
+		vma_iter_prev_range(vms->vmi);
 
 	return 0;
 
@@ -2803,11 +2811,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_on_stack(mt_detach);
+	struct vma_munmap_struct vms;
 	int error;
-	unsigned long locked_vm = 0;
 
-	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
-				       &mas_detach, &locked_vm);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
 
@@ -2816,8 +2824,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


