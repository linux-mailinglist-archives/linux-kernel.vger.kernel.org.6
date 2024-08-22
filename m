Return-Path: <linux-kernel+bounces-297885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2246D95BED7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87F8285AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A11D0DF7;
	Thu, 22 Aug 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cJ5TO2Fv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rP0qG9Zt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62AB1D0DE6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354814; cv=fail; b=Us0gJ2x5ATt3QXkz9kKwujirq2MODTs6Nok7MxOadlnpVZ2OiESKijb84sKKJm5m/W5nkx/dAI47MsOUZytrVJgJAUPbBqmX8MRcM2MeEUcEvLIUEVTsWIyG/hsuhdf0qeKrPN71hllp/CiiJsLnuPyQ0ffgINfX+iEfzaMJ7pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354814; c=relaxed/simple;
	bh=/psJFe+eAvZXArjnY/+3VeKeg+EaFuI+beJ39+gCOhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QrxV8hS9VGX06vvxwBJZFdp5Qbs4HOjtGP23hh2q9g6AkmQ5RP3UzlJtWh/x7MUGRW15Dooo0I9aFvwD5GjcYhAwYE6sfQLp0IwoyBPvaeSlHM/adu/4WU00UvzKC6hhZls1fOLpyvQ2R/5mIzHL7TIyu/URzCd6fEDGQ2SuEl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cJ5TO2Fv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rP0qG9Zt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMWwK019187;
	Thu, 22 Aug 2024 19:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cmaw/1Mrrp9JLuXw7iqgGPqWl0hYk2ZF3JfbQyhb8XI=; b=
	cJ5TO2Fv1xutqCEkrZaC+cCFyxPBh4FuCsuCDLge7LCcUqa/KavUJUSLohN9C+d4
	muNB9xs+Qj9TOH/tbrqLTy7HdEUcnPyynnHzFSFvgz7aVFM/R3wixulj1497CNMw
	X8yNbcdeuNHE+Fm3mClEk309/2s7E1LIw4nX3AM70uH9584pieu7q9pIhRi9+6u+
	w92MllYRWyAJ95oWIl7WjCKE7yckrb/IUZiOSOPUl+IWVsrPzLXUQGqMqPRu7C7q
	MwZU1ecyp/SUJF4tX0C7w3axXUdVwjCbXnEM8ermM6s1d/sZTY07Q23U9z7cE9rp
	G3nlgFgza2P+BvFDPMae6A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45jwa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIqaQ0019453;
	Thu, 22 Aug 2024 19:26:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416b0b9ckf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N51eNV7Ul/gPm7P1GyfKFYsZSVlhooWiF/EpZDn7S4IMPOkNJtmQuJKBeOqNJqh0iWKH5DcTkUr5FU1UWLRyrw0WKdqTUN/wFt7FCKLpEiNz3JPSTCSEQEvEix3q1rnWkYGHKHDqQbZWMOtZarRhyoqrI2KAjaqLQ1ZQrjsXcPv6rrhy2qC4/eJaXeNjh8XFaifn8yhfDh4pjxKIKDDoSmaHdSVB+j8N4mcWkOFJs63DoO/5O5IR9SFU15R1MehTyDhNHpXyAt/wO4r2cQlVGMrzvA9pmTi3J23E4t/VfRZJvIsIqthQTfKdI8nw0OBWtaFnxq2aNYf7QnB/REJyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmaw/1Mrrp9JLuXw7iqgGPqWl0hYk2ZF3JfbQyhb8XI=;
 b=PqyeddQBmqK+BT+71osGUBh1pG7L4uTMugRGil7lGMFcF+v7bK/6ECzRhWO+7y+YYwn5wZMnXHLdcxrowwgjOIit+ltf4aWBQ11rL9pfilICOJ4Rpjqf8mz6c3LmGZ6TwGiICuGI7pyS93bydmf4dLjB2pOvxwJy5Bee9DFNnmX8gK1Uc1LruWOs+bXJ/xzC9kaORKUn9P7xCb0+IJFSJVBRYaGieUzo9Qnfwz99iGEu/Iw68GZbKl4l8qvclmfUwUYm25qSVUgUFGkX3s8kbnPayzVp/r0nWdGYPHIsmZldFNeGw7s65ZaDo8bJ8fiGJ94crBskFD4XRpvQKar60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmaw/1Mrrp9JLuXw7iqgGPqWl0hYk2ZF3JfbQyhb8XI=;
 b=rP0qG9ZtaH6dffR9INs0owwEoL6gQje+f5VkJq+AnmASF6HCVKnVTD116yfBLa3TYmDJqGTF18kRpgxXCY/z6S555lxZq3YlnHHF6YDy9oqyp3bgyXoCZW6VZoTnV9CjXeYPC9VnOPOStkjPwGaO7qO2dlFug9aPJZhbx55CZKk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:33 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v7 12/21] mm/vma: Track start and end for munmap in vma_munmap_struct
Date: Thu, 22 Aug 2024 15:25:34 -0400
Message-ID: <20240822192543.3359552-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fce7fb4-eb17-4ee1-1eb1-08dcc2e05495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zl5m9uWswjpJuSyEA83zUyeoHPqx8LxlXge11OEhw4KMZVxPo6sHYGEbSPg5?=
 =?us-ascii?Q?DJaXVtQM6UsOXS32jH5WpY9HEKfs4d9MyBGfqe0SjIFOQJ+Oe33h75A/8DWe?=
 =?us-ascii?Q?bgPo/9pVfeyRoFmPiiszIBi7Nc27pXdwnJk0JWFC2EkbClBafB2KaOoPaA37?=
 =?us-ascii?Q?mZDOlZMxpHVz5q8W+IxbbmKQl17fC4k4Innyy4znaMABdtGbNRw4a6wCVANQ?=
 =?us-ascii?Q?q+zHccbPVkttQQ/i7xa+XpvbQBENxgjteWVURnt8Rl8m7C2qBWMZr32ETs9U?=
 =?us-ascii?Q?Cz2HrdY3WXZIk8Z3O/6VysPrazBpbqgV1oN6d6wSFlMPgLqG58N7KSeC2daz?=
 =?us-ascii?Q?m1cLH8gnB4wJNHxjCV1CZeglVNqAndKoPbJ86XbbJgNyLTNRG+tCKopnpJ4L?=
 =?us-ascii?Q?6HggEAcvZRH/RM6GA7Vqi3+04ThCnXep+eR4voa4X4z79rTd6gH0bIq38lUs?=
 =?us-ascii?Q?QMcJXOLkEof0vDXY75705TrG6v1ZgSfBKu4JLCnmgoHHwFMB/Xzqd7htwwm3?=
 =?us-ascii?Q?xo/5rRh04WDJuW/W65+hpfsXyRtIH4j+UqcehOBzf8mEifE+pZk5U/Z+XiQ2?=
 =?us-ascii?Q?c20LZyy9GsBWO8BIDc1ge2wnGBJHQASKYph4XY2wNTlXsSpKQ95L7rkStt4u?=
 =?us-ascii?Q?3A+fsvUNollK9qa6HVU08wLdiakhznZ9dGs3SKersolvG680uoIiUY7ariE7?=
 =?us-ascii?Q?j///zugy/0IzA1QvJoaZl+24AIC9Ld2Q/u3Pg4aatWx1UTop4+6v1aDFqZU/?=
 =?us-ascii?Q?9lYYd0AvbdN1/I5VANJCPGddif+b4b9QYkIjsgBHBcZRV6rGyKcX5HRrz4X3?=
 =?us-ascii?Q?BvrFfWYmv72AKeKvO6ncj0VV3tN8E5ozVIV32gN2luZVguLITlVhxdfBHMJt?=
 =?us-ascii?Q?qm1PPu6/QEIG/PORjULDSipNeVFxUUmxzzQQTZ+3tqw4hd5SVq8P4c+PLoOe?=
 =?us-ascii?Q?BLWb3r69j7cWZzNTost2E2ZVgNxIw2M8ZMhp3T2yNE2Sot3eNe77/YsNVMiL?=
 =?us-ascii?Q?xQ6TFlq2jgzIpqOLQQPX6N8GKfYJFiue4A7DMUd/HQSio0mEUJ4Y160uI6aL?=
 =?us-ascii?Q?mk4REUuyxGINIXd3SS5QAYn9O+kWa6g+DaOKbd+qqiSV1PqVXI5cUWzAQlx6?=
 =?us-ascii?Q?WnWXcUaw9WljYWLHfAkEFfDP/tEaQcFxP5/7lyFk8Ue6SHK+rN6PNPiqk7Ea?=
 =?us-ascii?Q?mBwyZ4NUBe9XNWu1D4Qx4uu98ogwYUP1y+EFZmlKwlyFeZ+jhn+7ZMQJF6JB?=
 =?us-ascii?Q?9b8CMou/1nNUXYRQTSofYs3DIhpQWcByFhUipurmprPGpnqCug6LhB55xLJz?=
 =?us-ascii?Q?ZeIPSC7HEeeRnAcjc+AQ1aECBJBqvXX9cCzVmEvPbJ6lQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?70SiWU+v6TRYfytFuX5ktenH9a4W6O2MQT4F07VviKASyXiH1j9icQyA6u2X?=
 =?us-ascii?Q?vRzy8sAFfxoazAWvmZjIX6St7DIMJn5CJvF6unGbMS0Rtkp4J2wrnXQkJgBn?=
 =?us-ascii?Q?vzKNO+poaXoApKH0YYa4ieUMVht/Hj5wlY7v0nxQp0IrVfFhsd4GcbaYTSPm?=
 =?us-ascii?Q?zZM696huqcW3Uvrk2vB5qxCu1Y6/GLkeQozUEDgR3MK32k2fAKvoZOtWfQSd?=
 =?us-ascii?Q?/A7l+AVXf8uTaFWluagM3hMvq20J0UfdOtnmngrEb+i+5VddDO08+O/rO1E0?=
 =?us-ascii?Q?V/INGGTMW5dqesXhoPOjgETknm2pjhuQ4AN9FRSCY94QOKKS9GslW7mernPb?=
 =?us-ascii?Q?hzQb54qxFwMPnKzFn0/MhkUNDevxfFWIkpFK+NuV0h5FhEvMJXjlO1kbG/UL?=
 =?us-ascii?Q?PZXIZnqjZs7+oNs1h+8JI6jtst00KVAQhIehN1JaduwJJTTMCgXMc21dSFin?=
 =?us-ascii?Q?ZfZY/0QvkUS7hhmjL6VGy6TiYsAumBEYP5PqYOIMkL9bxGtzICyUZrxHqGq1?=
 =?us-ascii?Q?xwRFLEiPOhUqt5i5CMQxEF0DorDVFzWqcLG7Ese0vC3nJgUQb0iSKQJL5P7s?=
 =?us-ascii?Q?PS0iURGFkCTWVmGLgaBqJAM2wrd8SRHrk6V+6V3eAsn28YNmsjPSrvS4lIpB?=
 =?us-ascii?Q?+rtRcKfGMvf7EccXVA3BmHvAXSO+Gur0JvSaXetye8Kk0OPqckK1Uefd9OqP?=
 =?us-ascii?Q?T1zGF8YDpLXCLSTMoGl52DtFs8UfUuTMPOA8i7mS+DrAXA7CDqnLxInPcIOr?=
 =?us-ascii?Q?k3HcFYxyzUZ1+D2hFSwUPobHajP+6q4eVmyullOjQv4u0aBs2EV06754BeWe?=
 =?us-ascii?Q?sXcLNuu1JYGeBCCy2QU+IbPkC/W7JAyEX+yhZIp8+SGHhtGOYHlAMnIgA6mF?=
 =?us-ascii?Q?sOIl9/9kZn00OfM41RDLMYXTyC81b5UIjRzSePO7M3aWaicVJpl9Iwwfnld+?=
 =?us-ascii?Q?Irm70OMYiwykizGWxZvXKoleXfLRVSjAAt+wRzd0Zt/dKPyKkl4OLZmyUMFL?=
 =?us-ascii?Q?u539Du1Pd04wvtYnTh29oIgTwj4vNhSi/tzUiUiJnb7gJbujHNtt9T1zH9kB?=
 =?us-ascii?Q?O6Af8WCDR7W7oMGmq+9CqQUAwthf/z8umXiygI4JVEziHRLuva5AY7wwbKzV?=
 =?us-ascii?Q?zYM6mSlNKgH8vKLsZrIS7z6QaSxA4y2vWN2TXmzSVd69n8nro1d/e7kaHGmT?=
 =?us-ascii?Q?K3lLMV9wiDn4E4tKS/YJQkpNDkEH7HS0ln+97FqXkHyAOdb9Vbk4vB0sdDcV?=
 =?us-ascii?Q?yGKq6dYw6ioBLaDahi5qGoEQ8wVFpq/xpNIp9fMWj3mYAKxNfKpfnWMlyHCV?=
 =?us-ascii?Q?w3yxeBxaJ3pa9FTAyObiZY4c9XbD8xpU51L//ctELwTxRb5iroeNvcIJOnYa?=
 =?us-ascii?Q?Qu9VWzYQRZSfznW2kWlJillgE+ofCwkxM5geXPv2jFkSPIM8RQNBHr3PphdV?=
 =?us-ascii?Q?IjGSHT0lJGYvULhjz0urouVMKKHuDcjkt8bu6z2zTAp6+1Zo/ZdocHPxdzDp?=
 =?us-ascii?Q?1AE+P7Jh+QXiKJO9t4g7Bgd+WbdoZiPNbvRkk5q+ZkmOoJebH4ocEu/2iWm/?=
 =?us-ascii?Q?J9KDReoTud3sViOs8paS2fo3nr3szk4owAaIo89Q+MVxByNdSnYhIES95NZC?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2j8d/EA0tN9TUx2ag+qe02ed18qXqaY6x7o+LcNQmELh+lgkxXaOVy0cFAzrxGDOtrIR/vgHF3YOcyUjejcOwhiL55GpmUvcTk/Z/Wn+vxHfmIwBHQI71XtKW85hhtnAwPPxYKlVwl1f6X/gjqnfE1fpIniM8LQzfaAKVc4/rjJr/db+EApJxDR5qPdkH/AiVjXfynf9TRw3g6JGgf0zaHX8bCxnDHQSmX/IHuXCoJRx1rKWzbU4CgDfAfE7Jl0XorgIByQj1lZplwrkh3Muh3Yh3Xduz6098fqF6Gv0aef3FlZhNRWAcoyPqWK220ufeCp6FX/Nzf0TG3j+54UHLQ4gPgS1Ms4PcT7bf02Hd14eNXUMSffDZ5452QTqMGAvUI6TFV0VDhTvHvak1cMfjHzoY6uU4OKFmkyBWBcuBxXORcaJAidcYZ5/qzRkl0a00KarIunqXCvnpAmjNoKtS7MQYrb7FjRC3s3+E4Tz7lLPqFiMNrxser1BDUqjB5f7DmgtJViDPVvrtDwf2BJYcI/BC16Yux0DpF5G/V/Oa1b3Tlm3LyL06kZYgf02mMe/lIjn6YtZa+KEPv+1lK151qK5EuEjrJZATyHNvocWWnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fce7fb4-eb17-4ee1-1eb1-08dcc2e05495
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:32.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaaJk9UdI+AEI3Z8IIZb83/1mqkens7BESWXG2b2W6MsoakzLOYQDJ1XVB1nBrEnGDHIJjYGI6x8orJ9q4dtHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: i_8CGIDrfEBl9JSAre4-N8OErO2kVPbw
X-Proofpoint-GUID: i_8CGIDrfEBl9JSAre4-N8OErO2kVPbw

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Set the start and end address for munmap when the prev and next are
gathered.  This is needed to avoid incorrect addresses being used during
the vms_complete_munmap_vmas() function if the prev/next vma are
expanded.

Add a new helper vms_complete_pte_clear(), which is needed later and
will avoid growing the argument list to unmap_region() beyond the 9 it
already has.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 32 +++++++++++++++++++++++++-------
 mm/vma.h |  4 ++++
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 9de41e1bf3b2..dda0dae069e2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -646,6 +646,26 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
+static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct mmu_gather tlb;
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, vms->mm);
+	update_hiwater_rss(vms->mm);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
+	mas_set(mas_detach, 1);
+	/* start and end may be different if there is no prev or next vma. */
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
+	tlb_finish_mmu(&tlb);
+}
+
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
@@ -667,13 +687,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
-		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -746,6 +760,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
+	if (vms->prev)
+		vms->unmap_start = vms->prev->vm_end;
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
@@ -810,6 +826,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 
 	vms->next = vma_next(vms->vmi);
+	if (vms->next)
+		vms->unmap_end = vms->next->vm_start;
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
diff --git a/mm/vma.h b/mm/vma.h
index c85fc7c888a8..7bc0f9e7751b 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -38,6 +38,8 @@ struct vma_munmap_struct {
 	struct list_head *uf;           /* Userfaultfd list_head */
 	unsigned long start;            /* Aligned start addr (inclusive) */
 	unsigned long end;              /* Aligned end addr (exclusive) */
+	unsigned long unmap_start;      /* Unmap PTE start */
+	unsigned long unmap_end;        /* Unmap PTE end */
 	int vma_count;                  /* Number of vmas that will be removed */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
@@ -108,6 +110,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->vma_count = 0;
 	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
 }
 
 int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
-- 
2.43.0


