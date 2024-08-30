Return-Path: <linux-kernel+bounces-308010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E964D96561A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B92DB21BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DC21509A8;
	Fri, 30 Aug 2024 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ic8hQ9pP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SVdHwDT/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E414F9C7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990503; cv=fail; b=hd+LGr2LhUR/13eI4sydCqUCs46ZcM1xLXO/D5G7DvUiWhhTXuJxkvqu+QpOOPJqigCqXQChKtwYMBItGSOKSzDeU5FdwRvPpbkMMiAApbEQKmEysg0wY09EQP6qPEB3YgKmEHvqH2JNbne07U23qTJ1nscZ5K4vACRo1br9Su4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990503; c=relaxed/simple;
	bh=u6bz/mYSytjSKhdbSNV8alE84POEkhq3QkbG9CxJaoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LG57kzOuaV239F0F3bi3vidRRRZjSIG7YzIHxuIJ7w685sgm045zvCDjXz6QoUadmz8Qf7HioTgrS1m8+Fy0K8CQirzNf5OZDfldT3iB+tZxo8m5f4NZHxy9GvSVqGbf/47uQSbuRpma6IDMvxvOdHKob5QH4E2IinFovUYCwwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ic8hQ9pP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SVdHwDT/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3MisE024297;
	Fri, 30 Aug 2024 04:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=X3TVDEXy+8mIis7fJmNHmIG5dYhcUaHLYXCY/rRjgL4=; b=
	ic8hQ9pPkBNxwDq4NPuxoJOSFC5XWqvCWHHSx4TZC9qPEM689PbNRFayqne90gBm
	9z224mp4mt8tbAfXS0wdQmepwa0Hld2f0rWCsBnDffcJsLeT6lvCiFswvxn2GSsl
	9DSfPQhpdDMND244jFKqVEkKKA5pRqX5CEYmRUC4E2LObUGFmr1mJ4K2XFZ30swq
	sBcCGoO4sLpA5h4nxMZv/NFUGwjE7hGnavJYLEqnoJbamMbysx6UgxmuRvLJqjwh
	vhK6UBmI78vOJj006QfDMyoowaSpAIYFUrQuGp0Uz02hBGxN205TQqIg2qawZ/Bk
	l9qkXqMK2Enn5ozd0ydRLA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b3myr588-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3j9dj034714;
	Fri, 30 Aug 2024 04:01:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189swukv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUqFvfKmM/gnDTJAuhlDbJjNArRQnpLh3AOHUNVEysFDuywIVKqMLlKKc27/YPF/97f3Veg/hke1mj4EQU1djNNIwCCK8GOXDZpt1k30FQVfr110Rh9NcpYDo2ba9ov9Ce3ltkHFW3XuSzaE00JPsqa3Dtki4aMNBOcgsDavPojABpdWrGAdcp/Q1aeQ9KYEin57PS+ADA5qS3PVJTpLNsnUuoFFOlmZ7meNWJWKsQ1Du8w/xXHDpT+2kOeLE80BmWbd1WA5OUgFDjwaVSlLNm01tLygmb6tuZsR0l5+LHllWPyleegyDAMAoDN/BYIdUgkeYCGDVVFa8aq6I4AUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3TVDEXy+8mIis7fJmNHmIG5dYhcUaHLYXCY/rRjgL4=;
 b=n3wIfYTx9X6pHM9wc3JPj064Rjd8K5ISNCmrtSI86NIlcOH8UuB8a/gDovlP5i5o70kSl7yQ+lbVBZd+IYt+TP0198cPJs+v4nsJgSkDXqN0cuFCsm6X9uGsNgTC0UMs9YCPaxZVKlD3ea5L4NOu5+FCcYvA5y5ywUUUINixrZSfPAm8iXMog1gdKlbBAw/WS7Cg9gPp5ZS4UIiag76jzwg4isnmNn6VWPvdECBD7UNn8oNZVXwjWtw1h8d2FYBfL4fBoCqGyun3NNQfpKf7wQLHr58x72+eRfw4aOgU2nbedG3rQLeWmE+j6kRBxgH3R0u5k7JNbr7bhLlklcsDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3TVDEXy+8mIis7fJmNHmIG5dYhcUaHLYXCY/rRjgL4=;
 b=SVdHwDT/3xNFUPu1eVmKU68O7YQdsp5ov7kj+dvtsFirIj+SjGdPtxjMbo+PNPAyBNG1oTABKHBMTTJ+DAuLcdokPWXl+fWz8tY07egBoWL9j5MdNkHnLHP1q2foGqVzYb3gGI4KHD2byY1lh+VyvsBJ3w+X6D3Z5kz+DyymkP4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:29 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:29 +0000
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
Subject: [PATCH v8 10/21] mm/vma: Support vma == NULL in init_vma_munmap()
Date: Fri, 30 Aug 2024 00:00:50 -0400
Message-ID: <20240830040101.822209-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 16142e4b-0027-430c-eb64-08dcc8a86d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XjkQNhXW4d9SsIpeSndOAewtTj6N/ncaKr5X4R5PHNxc7Re0EX8A7pL123HB?=
 =?us-ascii?Q?B2M3hEQMvNCv7Gy+E52HBOuXNf8O+ItgTKxGHr6jhta7e2xE1VD7FwI5yjvE?=
 =?us-ascii?Q?cwaYuUxlyzlmcKTDI2vEg95+NpqyQZu0X2JeHXVVj49ecL/ee3XXOVgQytI9?=
 =?us-ascii?Q?Y/OT6ZsvqdFFYhiWlO1cj4D+CxeyKQpTq7Jsb1EW5wBKF+ZQHpNEMwyMFuRe?=
 =?us-ascii?Q?QEUlqne5LQq8RPv3Mz2MbpG2eGKicC5qycnonKIsf8YEnnuPsJtZvdo8XCUs?=
 =?us-ascii?Q?wNCeSBYCrdUvGtzVM2dV5YrUgo4j/LtDbOBsqBdS5wc31sMsOxeIK84aGBnL?=
 =?us-ascii?Q?ngEOZti08AupKaLHPd9hjNoHl2ZCKb7SuPnUkFk/bgtr+stC3YCFfzPN7E4M?=
 =?us-ascii?Q?HsW0iaRG365B5C1HnjG3wAo5CjSjq8Xj2PQ7Pjs1lJpwBhXy0TWEytH45DRi?=
 =?us-ascii?Q?cvkzs0wNWT+Hjb2omBZAITz9K6nkFTlvKDDrTCxlj5N4L+PMw+X3X08NIKwR?=
 =?us-ascii?Q?q9ivl/9lslsKyTdPbMe+7dcbYf5HbsxdE6s9hTZvFYMMnau00cJuKfmZodqu?=
 =?us-ascii?Q?j26nQHN+lBzTFH3wxmj5mQoDbpZdnFwQbvbj/47krJU6UtgeoGMWMYtutT3Q?=
 =?us-ascii?Q?cMiA/Kj5l4BkjcP6qo424cqPwn6Zr7DZh9vZtMvYHsc3yAfn0CLWmSCzndhx?=
 =?us-ascii?Q?Iw0ndexhmLUufiKqfw+cKoX4Ta8/XBBUuTaLz3MpQMPC7jNCuBSTS8o7X50f?=
 =?us-ascii?Q?WUIQGjIXhwEC17gJlrd2o/0kghF7RJKrwHteLAfJgw4jBoYWGIgl4GgBVtdg?=
 =?us-ascii?Q?eD3igYqPZpDcRZti1J5gKMqH8rcrCU6ledZcOWhvxAsd2PsZGbbWJrv+N0Gq?=
 =?us-ascii?Q?FWCFSV+lVNawlO+wol1bb0pYqLWy3CiXnae2MRihqSE2tVkTnIfT29mU8ebE?=
 =?us-ascii?Q?ImXjrCKOIHKOocjQ7XXX00BATajdHZMQun4AZNtXUzMY94doSwxRWSCxRLQX?=
 =?us-ascii?Q?nUUAghxRF+UvJS11iqjAi5sPfn++LM6PV9fiYcs6nMm65whFu1/eceMnuS3x?=
 =?us-ascii?Q?nObiSO8xLzrrNptA144kjBzhFtjF3dHMAGy+TxSdX0W69h2o0XT2p1hFUcLy?=
 =?us-ascii?Q?SRtNZjbqcedxG2u8dJIsi62oBsNP69i1hOLxroI6ETY8wanlvSEa893ZBsdl?=
 =?us-ascii?Q?6tgk5RTy6++oYzXt1uY76qJ/QTgD/o8PzCKrzITfXqDPTmE+Rbo660hg/K7g?=
 =?us-ascii?Q?66mrWD6FFjlb3zqPQmWHLUxFgm99uzt6u+ef3xmKSbWop2TlnWpr1J1ecd6r?=
 =?us-ascii?Q?m9dUSDyc7fd4YKDFOLpMIM98g/qMFhsFhjSmV9pfQhHZnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YQ4aTX8cEv+kiBxqQUwXVmvhQAXbTBcpnXh+UnZH1IFOLDQQmewCuqOE888I?=
 =?us-ascii?Q?+DaLP8JLaYNbX/hebj3OhdDbsLYg0Fpxvjrt58YUt18r4g6jzf9pRuwSxvC9?=
 =?us-ascii?Q?kKwDrBBJOc1PG2KTam0MK0KIGVyfMZK5rwVrwBZuOpszmPAeO2uIIuTT9odN?=
 =?us-ascii?Q?3D262+o94aPxYsufz5JusDCriptc5i9/rWgteGTLQffSJ76W03ykmj6dPJ9g?=
 =?us-ascii?Q?s89X0lRnS28IXunTWjjLa/rg92Qf+uf2OUezuJ0cO7uQeHaMbyTrXn5XtW7R?=
 =?us-ascii?Q?dXKdgRVft73SiRm9PeP9hdMsbop7lvh1Yw93p4Gs6lCemTZ/osIdeXIxf6is?=
 =?us-ascii?Q?diP3vCvHj+dgVKH6aKtWkDLsn7ob/EuV5wS5Vj7LLwLwHcbtXsew3fliNdX2?=
 =?us-ascii?Q?caMco4ULqr88RDHf6Ip+e/ELvrjrHRcDDhziZghl8o459YyzbF5amDSC3zSb?=
 =?us-ascii?Q?6GC3ijvS0z+MHCk/Gai2BZ3G3CFVvXiK7RlDzY0MxWNIzSsv5UizS/CFi7oB?=
 =?us-ascii?Q?Umd8l5OZKPt147caZqiQ8Ud4gh8Ty4QzVWTd278AbxjU65H5RuNZCWs9AL+y?=
 =?us-ascii?Q?HATPlSi9tSmtNb2QgEfHPs2B3uzEY9lHCjr0td8pOy0xm7DdmG7yVaNaYM0+?=
 =?us-ascii?Q?4dQ4O2MU/FE63rWGBgFCEaCsSJj8adKvS1fppYB7x45An4o2zVigCZTP4B28?=
 =?us-ascii?Q?K+bitUALzFNG8e++rKJNuFw1qJQ9Y8YlwpLJUjvxU4HysiwqRCBX1/C00NEw?=
 =?us-ascii?Q?+UTCBNcCn9eO8pMeQSDIknZVWgR16SQT5igw/dtGgP12uhPlUSbJjHzHIPjD?=
 =?us-ascii?Q?D45ZWxfuVVTiSjlEqgeIMDm3HZDmMslSrqrJB8OpW/j12apV5toUScB6+zQs?=
 =?us-ascii?Q?kI3++cGXmnr2bCIBDxvZ8GQ92r+l/M4LYSwS0QNu2gpD22YpuXzTuQ8lChKm?=
 =?us-ascii?Q?m2cVFy45Sf8Y0OtQnR3A+37TaAOZdbz2slpRqKAmZevMFtAKku20rSqGin98?=
 =?us-ascii?Q?tJhRq4HRserLl5U5n8/m3bG8xac1tdXT0VfsArV/mmrkMJ768bmxBflcJS/F?=
 =?us-ascii?Q?iRMqcFolexA6Q8gUD8D8Godd+S2dU3oFLBQFdEDz7y7Fmm37DSPtRK02m54D?=
 =?us-ascii?Q?WvHoHFF7MLHDHJgcof/MxMjx0BCi5FmnfjD5jyMAU5kjXPr9dLvTDMWtCc6s?=
 =?us-ascii?Q?q2vZJ0ybCNnhOknMyA3DmSGdUaONVLc+a/uOcCoR+hpmnGPTBO8JF0yrxgka?=
 =?us-ascii?Q?aDGOR9ybksfDnTuDvmRngBfNhp9Qpi8YvePCeSALcEjZKIfduhdSGFFWkveg?=
 =?us-ascii?Q?pU0HgYfjkYwjfEaG0UEpeVVXy9zS+uljDue4L4sSIZnCJaAhitl7o/av8DXg?=
 =?us-ascii?Q?3n506tdBXtkqdznl9TYZPMyO0BIS88FeM+9YIBiFw/Q1AyTTR4VLIkFKDQnM?=
 =?us-ascii?Q?fuqQfeV1+2GSjkqtew/j2viYR+G1A9Vv+lgFaqoOGST+RdzW1JXhYlq7p4hv?=
 =?us-ascii?Q?UQorOOdgQibEjqSdOwWlouiWvTcWm48buV1ClfFLMpVvp8O8+4B/y0FfyEoS?=
 =?us-ascii?Q?Jw3KMUVHUBVXkdP41f4xl4cjH1X4Pm8Kfljq+yC0smOvZH5lYNcgOvuZwbMQ?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3zscJbNDGyELvyMSql93u8Fdkm7aRJTvxnZx/C+qAw3MJPRZfa36Jh82g/g6ylawgU4QXasNc94Y7/BICyx++R07K+cnPZyCgHHvdS0132We1ZuX89G0ezLSLegmpbrG9tYiLRhvTP9byjT3erqnuQLZ2tqYYGuWBaG0gZVpRTFHqW7vq7gBCMQURbv/3yLXhSicOp5Zn3F8YA0B/TRNqbxQMofeiMnwBgqVI4IYvVjZtTh5vrNnhzMTEZN4b9n1DhcRZ9JoLGiWmsRzLvalXpFgNa7yE6d+yWjJzcU36u96C3q4+5jZ7lfBJMhcmg0OMOZVCK6SKdcpuikUnQusgOmkLoJX54LeQPmF4Ttf+JpV1Zc6oSdF/B6A/bO4Mam7lFvUsykqm9+IucV8czrXT982QHuOZRP5LzT+FSkpx/VvXkkVqguKlHkltb5t1mr53P0MWBuEk+cN1hX8S328vI3GyTDF+s8r0O2uxqX/EAB1C6wqBXtPA22nAc9FuQkxbQekjcQcA7wfAjAelgOvjI3vGTsxV8c8TGMgOagtgK9ExLxwyAkQ88Ndfhs6qL98L60eziepezTxjK4+W1SaEK5HKCd4h8hzGcKg02BjmUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16142e4b-0027-430c-eb64-08dcc8a86d22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:29.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVwcVMbY2p0ouECm7pX3hxAZJ0CqWee4qHSJY9Ljs2tn0wL6M0KEuH/8Lr/MWVVKYEf2b7owbWf+jorLuIt3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: eOhw1X3WPtRStrFG46zQ7AKI6eVAj2tH
X-Proofpoint-ORIG-GUID: eOhw1X3WPtRStrFG46zQ7AKI6eVAj2tH

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Adding support for a NULL vma means the init_vma_munmap() can be
initialized for a less error-prone process when calling
vms_complete_munmap_vmas() later on.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c |  2 +-
 mm/vma.h  | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 84cb4b1df4a2..ac348ae933ba 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1393,11 +1393,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
+	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
-		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 		/* Prepare to unmap any existing mapping in the area */
 		error = vms_gather_munmap_vmas(&vms, &mas_detach);
 		if (error)
diff --git a/mm/vma.h b/mm/vma.h
index e78b24d1cf83..0e214bbf443e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -95,9 +95,14 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 {
 	vms->vmi = vmi;
 	vms->vma = vma;
-	vms->mm = vma->vm_mm;
-	vms->start = start;
-	vms->end = end;
+	if (vma) {
+		vms->mm = vma->vm_mm;
+		vms->start = start;
+		vms->end = end;
+	} else {
+		vms->mm = NULL;
+		vms->start = vms->end = 0;
+	}
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-- 
2.43.0


