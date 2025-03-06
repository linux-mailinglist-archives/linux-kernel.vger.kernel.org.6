Return-Path: <linux-kernel+bounces-548674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC35DA547DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62303AD00B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B0620ADC9;
	Thu,  6 Mar 2025 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mrU+Bf3A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OcoAzVVg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970AC2066E1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257276; cv=fail; b=UVjjDdmhNq8g1DJGJy/NMMffw7Nk5dLZ3BAu2wsEGRN+hGADRj0q314E3PWjkrdszAWr9Pqle3Uoyvl2yaD4qHWBfG4yXy/iq+9A6KCno6KH7fhZRyDg/ctDBaH819eXjhfwbh9SjGctWqsAIG6CosxqBiVziwrQCwKZaXPyTTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257276; c=relaxed/simple;
	bh=3Ip6ezazDR5dmPFDYTDhTL5typUmOGeonxIIxsWBIJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRQzllFdrDhK92uSJ/V7lgTA/i4Zz/wy0VCY78GxHBDTBruf6Myas4qqjsCfMUfryabkw2BLtkRrDdSSiRoT0E8+C8h6VIu6mtOm4Gzcv6dCPKlrea0zUEjM/8rYajxztzR3BBvLSKFQZmX0rd0q2AcnP77ptWged34mHOdg10c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mrU+Bf3A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OcoAzVVg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526ABlfS000825;
	Thu, 6 Mar 2025 10:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8KOwdcZdySxF73nLwM+suOaK5y/3OXix4HdEU9hYnXk=; b=
	mrU+Bf3A1I5RZ0SKpOd3dcccXAVMeT5NkCqbADHroTQu4FbcxoCKLaFbih2s7vzU
	Wq7ukb42g4oe8kq7oOBt/IFupBL7o7sN55XtBa8er4p4T+pARRUNFqL7F24Fz8Al
	ENURFLv1blVi9iFgVXbEh+UrO6919WIB6sZnG3VOZkC3/praz4c8ErHaUi8/eI0E
	Tq5k7IFl/oQBUAoFvQQ8U1XfvT0UCSdEQzTspRsjYNoXEUqPJ7WbCZtiS0yFb8fy
	XS9GOsezo8rG8QPTKkvbKt/zk5JsjK+3tEzinf9NHrPzXsOnQG3TRD/1OtdWoEu2
	TM+xW0zQkZMmLaxZ4G/0gQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u821v6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526AJ5N5010984;
	Thu, 6 Mar 2025 10:34:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdh6t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1bjbba1F5zqVcQb+JdgCAl+EQMOw+UZGpbCQ0fk7Wd6pfOTJvpZ8eTsMNbboL/VLjV+kfwRUFRDFBPJP4Hkvxsvh3ZXyqmZhv6Z48A2mcuH7v7tfViG7y+AzBBXttEzNoBs5roNiorHWleGbUKrhpsMZoAfAXv+ajJ7Qm/95gfAgu35sXPGsIVzQNDD+dNsCeFSyTIlYHSb2xZsF9g8HAuiy+sBicU5O9LmHbyyr0ijG7s6iLean/i2weIt8YnGBIuRLTUyyKw+tnJhMvttYEsJO+F+SObTnfqDUkIy1fHsXZFFkMPHdh6PGOmQBWw1IMnwGls5EXANN9AEfPKM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KOwdcZdySxF73nLwM+suOaK5y/3OXix4HdEU9hYnXk=;
 b=p9WwXbvCRaWE3I44iSKv9Ydmrxrot/z5VfuXD/7CuLXDEJ8kXTDjSvJfx22ZYHyCbXKmKvNXXJzwsEmUHSbiqeOZsB+ghh0NlqTj9c8dGUdeNjJIritJxhzuDRXLFNLhfayn6u2VfiW6q+duJdw1T7f+FeyKz41RIanBxr5MbUuo4FPtxfxUSpsm0zZJGR+BdHqX4GsYMYjlruLIFWXf+ita/yL/6x7LPFma36IcIuPOn+nj8AIQRGg8m0pfDyxfx/Xfi9ZGSxbfAPu1AQjEM5r+DXYropPxtTRdWRl0HW5NVXlSxn2qv9D8Bh15LVuVFmzGgXQXt10KdwcvL/FyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KOwdcZdySxF73nLwM+suOaK5y/3OXix4HdEU9hYnXk=;
 b=OcoAzVVgRlrwC11xbURMSqxmVHmKGJ//nEWdI2Z414EIoaC+qjPTLfd1jYDuAvKDmSfPkjj4vZd76atCFFgpLowvmBNOPIwrxQpw/Ecjs9WzenRlrPg2wfN8WFcBU/PvnrNqbp87z52j2f4l8mpbvr4ptDvudH2diERQ5sJEvb4=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 10:34:18 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 10:34:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 5/7] mm/mremap: complete refactor of move_vma()
Date: Thu,  6 Mar 2025 10:34:01 +0000
Message-ID: <bb6fa26fe29c5ff6cdbb162fd9ffdb0b050dfefe.1741256580.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0678.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::18) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 04162979-2f0b-4e4f-3284-08dd5c9a72fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pKDvZL+RB0Nyhq0ZwAmQ3QI7lLq+tcrSgraDerjAtbcCiEJwxaQ2kvi5KBLc?=
 =?us-ascii?Q?4bFz4BqCC85PzH9CBXp9hPsSqz2eRv3o6YpDxt376vUQ4aqHJhVZLZBFWdYN?=
 =?us-ascii?Q?ULV/YyEp5BIHW2XOxvmpAsxTqZkxA345fV8xKtQ/B9OYY/BY6XHa/9dyyrFC?=
 =?us-ascii?Q?EBBRKVp3tzkjj4cs2lropCv5Cbk4oLZokNcP/N2fWimA9f+7RtliPcsDSI+9?=
 =?us-ascii?Q?Uz4PaopV1vjun7C8W+njASBkCFaWJs+OxI4kHvZYuC+ZPhQw/dPHse+apq7D?=
 =?us-ascii?Q?SWAVspR/Wvi8OQ/f+EgPQEbAiW6UsVS+bOds2uIhSX9H3kwgt8S4ssLVMHkM?=
 =?us-ascii?Q?ahiHbQpEPuCrpCjR4PdNQNj3nW4O0afUMlOaKMlakS9Wqk+LP0P5iAwqetcb?=
 =?us-ascii?Q?jHVFQha0NW0WWW4BHDgsvaI1Lm7RffZoWqxXiEXTfG1WdPrElA7OEEGEBPeN?=
 =?us-ascii?Q?sOOeGYko2U7+CN15VcMQGM40cdcaA70JqdyK2bGtQUcKSzn1h1iXwhVMg68W?=
 =?us-ascii?Q?kcn2h0Z57YgVM2Og6MhbmRECbxH6fGGy1Lsmc5lpdrRlw7+NfeIpNSkZ+FYs?=
 =?us-ascii?Q?8VTBIoq7iu0txSS5MRglZAy0LM3OcQlZbNEi/sBDFfvMl4ow/PQgd/YDmB3v?=
 =?us-ascii?Q?XGdfl6eah+lY1W33DHhuLAMnWlQLRzGNds81msmMiL2zDX1ARlxApV4Gsq0b?=
 =?us-ascii?Q?+RIHZlkdb96/Bfk5ngr7IGkU9cBFR0NocsXnzjOqxv6vzPhqF4cwr703oPps?=
 =?us-ascii?Q?5ALY/k8J+PoF3PWlBY15g9S8K2uBK9EgQyOTG7Bu4Oht6a0/qDar5SeGat6f?=
 =?us-ascii?Q?67baErT3uBOWqVL/hGHS9rh540CVxSVRXLrVgYIczeS6ktwyxhPLo1OBhbhy?=
 =?us-ascii?Q?1aXghmuQ9UR+kLJLFxwzFZXZW0fp2Aa3RWA3U1wV63nTqsGD/qXI4AhFrzvv?=
 =?us-ascii?Q?p3kgj8HgHSnarB++2wyMXweEh5BdPlK8DHtRD4HuVzcG6Je/jxLvj4ZkgL8N?=
 =?us-ascii?Q?hMf0Qz5IuhcY/X9U0gI7zlOlw6oc0tBSvB9y8q2rNqZhfJlJTra2NnlX2ETf?=
 =?us-ascii?Q?qDZpRpe9b7fzoktZnCUcttf7aUtPXVdTbpVCS/i8V4ROQhMxYmy/0Nd/41lT?=
 =?us-ascii?Q?EzlqJB1O3NQ0I0k3qegZZv2if4zknTzoflGW67IkTAY3tQMtWfy0omsVpsLv?=
 =?us-ascii?Q?n2O/kqvngsbRfgg2TuB901UubfE61oOLTXqgeze+2Ias+KP9Rk2A2+Nze0VA?=
 =?us-ascii?Q?BVn/3XHWX0cU+flY/lB98ifVuZot5z440Vw7k6Z9m3yyqHJv913JXIY4enM0?=
 =?us-ascii?Q?o34a5nCN0fLZdYp3+Kjfh1g0aLghvNDnxI+Lotl0b9+yBATinW6zsQVGgn+K?=
 =?us-ascii?Q?HbCgVdVxQ8cfczguOhmzLYCuLnU9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gX7NpOgc3DbAokVBuDDGJJ6vv089fZRjtbMo3Ba7TZF9biNNEJw8zRMbOmlh?=
 =?us-ascii?Q?lRCVVsNfLoL6z7nJ0cagqXYZhkWGJ4WWOkWfFM5/Qt22C5cO6WMGI/Ji+ECy?=
 =?us-ascii?Q?XObmQsQkudmcryLLUak6uyamILyKovw5pDfpG8xTdEIKf0T6PqKTPq5QTFcv?=
 =?us-ascii?Q?1oZE0oy9b9v/G4ZLmy2lIaqB3f9Ph06WupknPK/pSeiAQ7ZBv9lk0Zg7Spyo?=
 =?us-ascii?Q?nHHa8AR6U011XWILI1yo3MI5gq5I4dIO5QbZQ6cURQnibFjv6k9X5Okm5v6B?=
 =?us-ascii?Q?3NUpedU+rJkBQIG+2GilRmuzKK/e1hxx+X7UBeiGGGuWMmZp4U+gqO+ULnFV?=
 =?us-ascii?Q?edR0zW9Uu6zbATDOaWoL4Wvx2W7D80dSHQm1O+8GbO6xwdJYpciUAzwx4/mD?=
 =?us-ascii?Q?aru+1dAfK6P4rni4nt6GlE4/xEuUi6O67rBcsHx1Lkaczmn7kFtmU/7e0c4/?=
 =?us-ascii?Q?byF8kAm+2oErMZuYlRdSSN7cgxW8n39G4ONxEjTezP+MfFfVBcb2zyP9Cybq?=
 =?us-ascii?Q?+39QR8zWAWNnbfdY1WVEoilpZTgvG7blw6ZwFoIOALcBPpwafQ6ujdjYlWVh?=
 =?us-ascii?Q?9lgpEmsYfGJ3JkE5c0OhbDOKG87x5OvRRaBiO3SSS0gm1vEy26ChsLnPXjTd?=
 =?us-ascii?Q?LgvWWFz1SF5l4XT5YaIwzE9Wk5Xm2PxMQtdvmv08UD6ADDEnTyRF6w1vQXFD?=
 =?us-ascii?Q?g4OsVWNhIVx/e5ZPtfTmEn8O44CvHFHqNoOzO5HTTsUNNddKU3aWKCpNI65A?=
 =?us-ascii?Q?8Z72xDy0QpjxPJYyL67CFmdVSdDBfOcJ1/yRzn57Er5sHdZXOlZ4hNlBij1E?=
 =?us-ascii?Q?vNVPkhjtIoN6WgewRgd6YOtXWuKlVWrhAoYTNHVkNfM/2pdIpkfFoG0ZkS1X?=
 =?us-ascii?Q?4yG54YeVzCfI6pxV1LeaxRRQDsVc/cIImGaibFOcZDHrkbhHCNnmHLAftCq6?=
 =?us-ascii?Q?IVPkcjeZH33ssbpuuDTVvC6iRwClgQQzsyeBSXlCza+SU/E21rzQZEGimZUT?=
 =?us-ascii?Q?IMXgX4sjFU0iIHmXDF7w56h9vkWo+gWfNhTQP6rz4pujjkGKTHSn/pDyl67/?=
 =?us-ascii?Q?QNYrkdb35zaGcDtEWC3vJrh8GN+QEvHaLnP0nNAEAlSRj8JGzmuu8EeSd49p?=
 =?us-ascii?Q?yToKiA2CBD6L7NRaF2VD2I+0VpiDzEInrmd2F5nUPb2lrlGh3BxT6Oh3XJg3?=
 =?us-ascii?Q?Y9dB1VRPe0ImnqUPZF3btWbzwQBsatnzlj4fNbd0Uu6f0G0h/1OkktP4wfOO?=
 =?us-ascii?Q?+2hHgfNBLr4PsYAmGbfxy4aL3UOh7Z6mHTrY5OZDPHzo+ocDPbPbmVvbcl0l?=
 =?us-ascii?Q?Se410XmovQ/1qiGxVYoQWrQivSddZMFnENSpGYPqTCImHwWUjTzmA0qzgrQ6?=
 =?us-ascii?Q?V0gwi913cXg0SAFwE/6lokDq7VHnWUdcWU4xS8MtmBf0qRQy65mCBZw4qzma?=
 =?us-ascii?Q?qlrt7XqxhhLr8k2qdIXZQCnUkVG+vY0n3k3vWl6a7FW2nvp9RMfnqfH/FC6R?=
 =?us-ascii?Q?KLCA+SVZJXNPC6Cx7Y4M9nD6oxxX3cjJsjpnoH1dZclDxQ1zVY/j6hJRmkmq?=
 =?us-ascii?Q?+AcPGEXjOVCJo6HDFqPnjB81jDKSjgN7+LZvV/t4MZh+mUrEmv8XZKZ9ufVi?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0yNigm3Zt1ibHkgTNqHu2/w9gc6E208y5BZtR2xEXtDyVC4Xnr6S3xzgwpTeoJ4zMRj0UjSm9gTziuMClvNrbnIDYsy1YIeqOgzYYpbUPGK6NO51/TqHK/R2o4L5JaFGBNqK+q6e8lunHbzcVZQyzhbwJjCmkrLZkhGt0tEh0bWFKm/cQ0jmwAKRa0Fz1ldTqKm45N8HZgRAYZN3SX1rMo6YKqAqxBrapjctR/PzRJgcJCDZsxh21B6Lc4XYTWp2w8giIY+cnKO35Kfuo2HnUO0ZzcEeg/rq7PjPS1y/gEQy8Ggp013laZSmONFEjzExwxIhyrRnzp7wf0OiQi1jL8K/ox8zlnX/URosgqkIuaKq+etSwb7kA4n/wkP5hBw1+Iwf6q88EiW4jZHiPN+RbMzN8iKGfqEmMhllkeEFkXunfeqb7UHzDcOoRcAlmaTfsO11nC4KWMRCHDWPGbwJ2nvR1mk1mfsb9efcTrPYhv6a8QvPpnbg6LSNna1QmcXkdhPfF7RaWTdrRak4QbJkXm/Q9pgLyg2upOlW4Hrk4TxOAdEWbkwvwep/5ZtEFsvXArj2oVxAYBfJinuKZIdSeOQsFI9mypTB/UF6J53DL90=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04162979-2f0b-4e4f-3284-08dd5c9a72fc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:34:18.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjSP0qlscp8YHaMA/dGg/YSowLm3GthSE1L7Mg6MMmiDo2zWdbsogox1/2nQQ02JOvWPrxEEEC9r6bKaOrydlCX7LKkxs+ujgWxDMCYju/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060079
X-Proofpoint-GUID: jjy4k6qFOEU3A8m5H3QfKZtw1lrPuIxj
X-Proofpoint-ORIG-GUID: jjy4k6qFOEU3A8m5H3QfKZtw1lrPuIxj

We invoke ksm_madvise() with an intentionally dummy flags field, so no
need to pass around.

Additionally, the code tries to be 'clever' with account_start,
account_end, using these to both check that vma->vm_start != 0 and that we
ought to account the newly split portion of VMA post-move, either before
or after it.

We need to do this because we intentionally removed VM_ACCOUNT on the VMA
prior to unmapping, so we don't erroneously unaccount memory (we have
already calculated the correct amount to account and accounted it, any
subsequent subtraction will be incorrect).

This patch significantly expands the comment (from 2002!) about
'concealing' the flag to make it abundantly clear what's going on, as well
as adding and expanding a number of other comments also.

We can remove account_start, account_end by instead tracking when we
account (i.e.  vma->vm_flags has the VM_ACCOUNT flag set, and this is not
an MREMAP_DONTUNMAP operation), and figuring out when to reinstate the
VM_ACCOUNT flag on prior/subsequent VMAs separately.

We additionally break the function into logical pieces and attack the very
confusing error handling logic (where, for instance, new_addr is set to
err).

After this change the code is considerably more readable and easy to
manipulate.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 292 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 203 insertions(+), 89 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 9f21b468d0dc..df550780a450 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -884,13 +884,13 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
  * Perform checks before attempting to write a VMA prior to it being
  * moved.
  */
-static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
-				   unsigned long *vm_flags_ptr)
+static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err = 0;
 	struct vm_area_struct *vma = vrm->vma;
 	unsigned long old_addr = vrm->addr;
 	unsigned long old_len = vrm->old_len;
+	unsigned long dummy = vma->vm_flags;

 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -916,56 +916,150 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
 	 * so KSM can come around to merge on vma and new_vma afterwards.
 	 */
 	err = ksm_madvise(vma, old_addr, old_addr + old_len,
-			  MADV_UNMERGEABLE, vm_flags_ptr);
+			  MADV_UNMERGEABLE, &dummy);
 	if (err)
 		return err;

 	return 0;
 }

-static unsigned long move_vma(struct vma_remap_struct *vrm)
+/*
+ * Unmap source VMA for VMA move, turning it from a copy to a move, being
+ * careful to ensure we do not underflow memory account while doing so if an
+ * accountable move.
+ *
+ * This is best effort, if we fail to unmap then we simply try
+ */
+static void unmap_source_vma(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long len = vrm->old_len;
 	struct vm_area_struct *vma = vrm->vma;
-	struct vm_area_struct *new_vma;
-	unsigned long vm_flags = vma->vm_flags;
-	unsigned long old_addr = vrm->addr, new_addr = vrm->new_addr;
-	unsigned long old_len = vrm->old_len, new_len = vrm->new_len;
-	unsigned long new_pgoff;
-	unsigned long moved_len;
-	unsigned long account_start = false;
-	unsigned long account_end = false;
-	unsigned long hiwater_vm;
+	VMA_ITERATOR(vmi, mm, addr);
 	int err;
-	bool need_rmap_locks;
-	struct vma_iterator vmi;
+	unsigned long vm_start;
+	unsigned long vm_end;
+	/*
+	 * It might seem odd that we check for MREMAP_DONTUNMAP here, given this
+	 * function implies that we unmap the original VMA, which seems
+	 * contradictory.
+	 *
+	 * However, this occurs when this operation was attempted and an error
+	 * arose, in which case we _do_ wish to unmap the _new_ VMA, which means
+	 * we actually _do_ want it be unaccounted.
+	 */
+	bool accountable_move = (vma->vm_flags & VM_ACCOUNT) &&
+		!(vrm->flags & MREMAP_DONTUNMAP);

-	err = prep_move_vma(vrm, &vm_flags);
-	if (err)
-		return err;
+	/*
+	 * So we perform a trick here to prevent incorrect accounting. Any merge
+	 * or new VMA allocation performed in copy_vma() does not adjust
+	 * accounting, it is expected that callers handle this.
+	 *
+	 * And indeed we already have, accounting appropriately in the case of
+	 * both in vrm_charge().
+	 *
+	 * However, when we unmap the existing VMA (to effect the move), this
+	 * code will, if the VMA has VM_ACCOUNT set, attempt to unaccount
+	 * removed pages.
+	 *
+	 * To avoid this we temporarily clear this flag, reinstating on any
+	 * portions of the original VMA that remain.
+	 */
+	if (accountable_move) {
+		vm_flags_clear(vma, VM_ACCOUNT);
+		/* We are about to split vma, so store the start/end. */
+		vm_start = vma->vm_start;
+		vm_end = vma->vm_end;
+	}

-	/* If accounted, charge the number of bytes the operation will use. */
-	if (!vrm_charge(vrm))
-		return -ENOMEM;
+	err = do_vmi_munmap(&vmi, mm, addr, len, vrm->uf_unmap, /* unlock= */false);
+	vrm->vma = NULL; /* Invalidated. */
+	if (err) {
+		/* OOM: unable to split vma, just get accounts right */
+		vm_acct_memory(len >> PAGE_SHIFT);
+		return;
+	}

-	vma_start_write(vma);
-	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
-	new_vma = copy_vma(&vrm->vma, new_addr, new_len, new_pgoff,
+	/*
+	 * If we mremap() from a VMA like this:
+	 *
+	 *    addr  end
+	 *     |     |
+	 *     v     v
+	 * |-------------|
+	 * |             |
+	 * |-------------|
+	 *
+	 * Having cleared VM_ACCOUNT from the whole VMA, after we unmap above
+	 * we'll end up with:
+	 *
+	 *    addr  end
+	 *     |     |
+	 *     v     v
+	 * |---|     |---|
+	 * | A |     | B |
+	 * |---|     |---|
+	 *
+	 * The VMI is still pointing at addr, so vma_prev() will give us A, and
+	 * a subsequent or lone vma_next() will give as B.
+	 *
+	 * do_vmi_munmap() will have restored the VMI back to addr.
+	 */
+	if (accountable_move) {
+		unsigned long end = addr + len;
+
+		if (vm_start < addr) {
+			struct vm_area_struct *prev = vma_prev(&vmi);
+
+			vm_flags_set(prev, VM_ACCOUNT); /* Acquires VMA lock. */
+		}
+
+		if (vm_end > end) {
+			struct vm_area_struct *next = vma_next(&vmi);
+
+			vm_flags_set(next, VM_ACCOUNT); /* Acquires VMA lock. */
+		}
+	}
+}
+
+/*
+ * Copy vrm->vma over to vrm->new_addr possibly adjusting size as part of the
+ * process. Additionally handle an error occurring on moving of page tables,
+ * where we reset vrm state to cause unmapping of the new VMA.
+ *
+ * Outputs the newly installed VMA to new_vma_ptr. Returns 0 on success or an
+ * error code.
+ */
+static int copy_vma_and_data(struct vma_remap_struct *vrm,
+			     struct vm_area_struct **new_vma_ptr)
+{
+	unsigned long internal_offset = vrm->addr - vrm->vma->vm_start;
+	unsigned long internal_pgoff = internal_offset >> PAGE_SHIFT;
+	unsigned long new_pgoff = vrm->vma->vm_pgoff + internal_pgoff;
+	unsigned long moved_len;
+	bool need_rmap_locks;
+	struct vm_area_struct *vma;
+	struct vm_area_struct *new_vma;
+	int err = 0;
+
+	new_vma = copy_vma(&vrm->vma, vrm->new_addr, vrm->new_len, new_pgoff,
 			   &need_rmap_locks);
-	/* This may have been updated. */
-	vma = vrm->vma;
 	if (!new_vma) {
 		vrm_uncharge(vrm);
+		*new_vma_ptr = NULL;
 		return -ENOMEM;
 	}
+	vma = vrm->vma;

-	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
-				     need_rmap_locks, false);
-	if (moved_len < old_len) {
+	moved_len = move_page_tables(vma, vrm->addr, new_vma,
+				     vrm->new_addr, vrm->old_len,
+				     need_rmap_locks, /* for_stack= */false);
+	if (moved_len < vrm->old_len)
 		err = -ENOMEM;
-	} else if (vma->vm_ops && vma->vm_ops->mremap) {
+	else if (vma->vm_ops && vma->vm_ops->mremap)
 		err = vma->vm_ops->mremap(new_vma);
-	}

 	if (unlikely(err)) {
 		/*
@@ -973,28 +1067,84 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
 		 */
-		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
-				 true, false);
-		vma = new_vma;
-		old_len = new_len;
-		old_addr = new_addr;
-		new_addr = err;
+		move_page_tables(new_vma, vrm->new_addr, vma, vrm->addr,
+				 moved_len, /* need_rmap_locks = */true,
+				 /* for_stack= */false);
+		vrm->vma = new_vma;
+		vrm->old_len = vrm->new_len;
+		vrm->addr = vrm->new_addr;
 	} else {
 		mremap_userfaultfd_prep(new_vma, vrm->uf);
 	}

-	if (is_vm_hugetlb_page(vma)) {
+	if (is_vm_hugetlb_page(vma))
 		clear_vma_resv_huge_pages(vma);
-	}

-	/* Conceal VM_ACCOUNT so old reservation is not undone */
-	if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP)) {
-		vm_flags_clear(vma, VM_ACCOUNT);
-		if (vma->vm_start < old_addr)
-			account_start = true;
-		if (vma->vm_end > old_addr + old_len)
-			account_end = true;
-	}
+	/* Tell pfnmap has moved from this vma */
+	if (unlikely(vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_clear(vma);
+
+	*new_vma_ptr = new_vma;
+	return err;
+}
+
+/*
+ * Perform final tasks for MADV_DONTUNMAP operation, clearing mlock() and
+ * account flags on remaining VMA by convention (it cannot be mlock()'d any
+ * longer, as pages in range are no longer mapped), and removing anon_vma_chain
+ * links from it (if the entire VMA was copied over).
+ */
+static void dontunmap_complete(struct vma_remap_struct *vrm,
+			       struct vm_area_struct *new_vma)
+{
+	unsigned long start = vrm->addr;
+	unsigned long end = vrm->addr + vrm->old_len;
+	unsigned long old_start = vrm->vma->vm_start;
+	unsigned long old_end = vrm->vma->vm_end;
+
+	/*
+	 * We always clear VM_LOCKED[ONFAULT] | VM_ACCOUNT on the old
+	 * vma.
+	 */
+	vm_flags_clear(vrm->vma, VM_LOCKED_MASK | VM_ACCOUNT);
+
+	/*
+	 * anon_vma links of the old vma is no longer needed after its page
+	 * table has been moved.
+	 */
+	if (new_vma != vrm->vma && start == old_start && end == old_end)
+		unlink_anon_vmas(vrm->vma);
+
+	/* Because we won't unmap we don't need to touch locked_vm. */
+}
+
+static unsigned long move_vma(struct vma_remap_struct *vrm)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *new_vma;
+	unsigned long hiwater_vm;
+	int err;
+
+	err = prep_move_vma(vrm);
+	if (err)
+		return err;
+
+	/* If accounted, charge the number of bytes the operation will use. */
+	if (!vrm_charge(vrm))
+		return -ENOMEM;
+
+	/* We don't want racing faults. */
+	vma_start_write(vrm->vma);
+
+	/* Perform copy step. */
+	err = copy_vma_and_data(vrm, &new_vma);
+	/*
+	 * If we established the copied-to VMA, we attempt to recover from the
+	 * error by setting the destination VMA to the source VMA and unmapping
+	 * it below.
+	 */
+	if (err && !new_vma)
+		return err;

 	/*
 	 * If we failed to move page tables we still do total_vm increment
@@ -1007,51 +1157,15 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	 */
 	hiwater_vm = mm->hiwater_vm;

-	/* Tell pfnmap has moved from this vma */
-	if (unlikely(vma->vm_flags & VM_PFNMAP))
-		untrack_pfn_clear(vma);
-
-	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP))) {
-		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
-		vm_flags_clear(vma, VM_LOCKED_MASK);
-
-		/*
-		 * anon_vma links of the old vma is no longer needed after its page
-		 * table has been moved.
-		 */
-		if (new_vma != vma && vma->vm_start == old_addr &&
-			vma->vm_end == (old_addr + old_len))
-			unlink_anon_vmas(vma);
-
-		/* Because we won't unmap we don't need to touch locked_vm */
-		vrm_stat_account(vrm, new_len);
-		return new_addr;
-	}
-
-	vrm_stat_account(vrm, new_len);
-
-	vma_iter_init(&vmi, mm, old_addr);
-	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, vrm->uf_unmap, false) < 0) {
-		/* OOM: unable to split vma, just get accounts right */
-		if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP))
-			vm_acct_memory(old_len >> PAGE_SHIFT);
-		account_start = account_end = false;
-	}
+	vrm_stat_account(vrm, vrm->new_len);
+	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP)))
+		dontunmap_complete(vrm, new_vma);
+	else
+		unmap_source_vma(vrm);

 	mm->hiwater_vm = hiwater_vm;

-	/* Restore VM_ACCOUNT if one or two pieces of vma left */
-	if (account_start) {
-		vma = vma_prev(&vmi);
-		vm_flags_set(vma, VM_ACCOUNT);
-	}
-
-	if (account_end) {
-		vma = vma_next(&vmi);
-		vm_flags_set(vma, VM_ACCOUNT);
-	}
-
-	return new_addr;
+	return err ? (unsigned long)err : vrm->new_addr;
 }

 /*
--
2.48.1

