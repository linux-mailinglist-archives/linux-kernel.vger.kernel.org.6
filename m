Return-Path: <linux-kernel+bounces-386993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B49B4A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF39228435D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FBE205132;
	Tue, 29 Oct 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l2YNyRrQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l9+0LvLW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9944206517
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207067; cv=fail; b=UxttqCjF6tuA7+oYq33z5ni+VwCEqLBvCjHi4AKEcQ9MbDiwsAFDEBMWcOr2ZCE5mQYIQyQ4J8sj1zC/3Q0NFJo2MbEyKPHPHcd89xtB0TCoIP95FfwI46qjKUd+1yurjuV4hRypu5ILqXGrqlLRTY+w327sJjSAkXmjVXkfh74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207067; c=relaxed/simple;
	bh=3k8eGYPX0IV6y7jcp2J4f00AARzr/yEL5pvSwM4ks2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TrkrRRfrdn/D1zhEstPzgTqnWV5JDFm7Ck6T+61CgMEQsdTqUeRgdbD1CgHye9OvBbv8CsJPaEI8sYrqqR2yVOKuoDACsU5803czEaZ+M8E4qX0CEDoRxQOORuqaIWhZg3hsuOpgs1JMIpxGCAq4Tck/LI8RGqplId4Z4ywo9xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l2YNyRrQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l9+0LvLW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCbuXM031407;
	Tue, 29 Oct 2024 13:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n/a5qI/qPIV7EvCPopGmVIpb6ZM0YGR4l7zVgmrebNE=; b=
	l2YNyRrQ6geGSqSvT5z5XQNX/k/OgVCfiYNhxJp+62l3G4fLuofs+WOT8pcwDF9d
	a2azkT5C4j6OSsxOy8cHNPDfwXQPsdjLdL0feq3KZp617gU+DDl9awBn/wFC5n08
	owDL+UPyKwKRG3cfnp2siD+kclb9CY/3UjYWqidadasu/cegzmdPLBnzBTGL7JLb
	TYiJDKXGcb9sPrNUdsUPkwBeLRg6MRmcneYexT+UgCq2AEEAM5YixV0rfFNHuSYY
	o/kUqivola925JXAZQGaAviWaFo9doVr/k/McWadmYKjAdplefple5FAOPCfbpFc
	xosAHXjeilhO1enTmMd5fg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwdb40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:04:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCcQkZ008475;
	Tue, 29 Oct 2024 13:04:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne9kred-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yyn1MxPhITLQs2XVHoGH6b1jo+GDHvJR3Q+GOhBXJHf4okS10TYAo/iJv0fWwwxAqOsC04nGXdKM7teoV4uNGHpETR0RcxV+LHCjTS1HzV5UoZxSDM/FXKQMADEcTHz936sV4Zp7ncP85LCOn5OwCUVCcwKWN2l58E1P1xC01wN/VfGGdLH9GJHV5uUuEzgMS2tRHbwB59qnK+0CWNFjF8/4VWJJUUqQFWC4ubPz/mkWtJQGKIMAmncSSzDXvTvRg8lz+B6op0d4hls5QOV/YWCzqyA9IL5ZmWkKZDwDfhdknQthg6YLLAQ8Z3ddGn2HGBIZbe3PTxviVR3D3L329Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/a5qI/qPIV7EvCPopGmVIpb6ZM0YGR4l7zVgmrebNE=;
 b=r5U1cZezebp6JTHToUEKBUtoHS4QeLK6DvM4n2kqvZCVvklQhfNRKVWUIXjlbqLqKZVmpe6LRQa3CxjWyUa3niLx06OUKH9fv7XPIwlc4mVr8/PUOvOCfioUma4IRXvMSLAMuSSYMT5zWOryyML0/9wvgMyc7CclskP5GbQyV3GKJrgvFI10G+qBCAASE/OrgL3rdyM3eXHoGzQjk2IqtEUislFsAISA2WfDP0zh+N1eSbn0WLTgIabKQnpPRnmL/o2EpRhixM0zHI5nEBapl/zAAfVfldedF+GVhlxgo4ssEwKNy2nM9PwrioH9mn5qpiHecp10/FFikHQhuD2GGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/a5qI/qPIV7EvCPopGmVIpb6ZM0YGR4l7zVgmrebNE=;
 b=l9+0LvLWV4569b5yPIn7de7ZHaxFj3iNHhwbOXXUmu7C5r6ki1N3I7Y6RPvyEITdL+bBJMD4hP0fXF8LayLay2OoX/wsSQjGlgIS+0neLQa9eeN0igAystgUXeOzfcKW/CiAmKdD9pjHIj1HX5mSSAigWVgigVPpDsMxEr+Zo7U=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 13:03:58 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 13:03:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH hotfix 6.12 v3 2/5] mm: unconditionally close VMAs on error
Date: Tue, 29 Oct 2024 13:03:44 +0000
Message-ID: <28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730206735.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c1c1bb-66d5-4103-11a0-08dcf81a2687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2zxpNUp5DuOKUP4LkK244ER3Cg2cIg0cpDK6z9MvX5Ig55Qi7NzXH9wtJgTQ?=
 =?us-ascii?Q?TsO69I1tUyovGN9ofilv0BIxqnkovBt0lvEaBsF7ySi/njHKOgjkCQGS5yZL?=
 =?us-ascii?Q?YhzcUK+qdMBI3Ke1vsFuO8hll4P7ZsUPobVnpXBSBRR3aja4GNMWAjPExPKg?=
 =?us-ascii?Q?si19EPXZauxkkT4eVScEabA6a5ltU1mpjWHVtgBmg+rJeR7EO75+O6AqyUrG?=
 =?us-ascii?Q?uGZ3V3G0hnuJ2Bq3V08av4Buuuf5PYE+012/n7CMBR3ndLtOZGToZgI0K3TP?=
 =?us-ascii?Q?yPlQ2ARquQMNnGlgjOPvQ7u1rx5VFe2gVkHLdhoFReuHYuBrZUFfm3V73Y7q?=
 =?us-ascii?Q?YNtr8pVz7W4OhBaEjOhcEvoG9VvttOBbQtYUkagbtiiOGdItrT0b9/yx+ORH?=
 =?us-ascii?Q?OMIqmXTgh8T+ZrG9aBK9dwHQU4YtJaEa106vXVB+DDHTioVQ7+Xzt7WA2gJ5?=
 =?us-ascii?Q?7gKSUZ0GvFJPtevQ/RFaQ85ThH/X7DZPg9H4kS9fkTQgKFKScWOPTa9uO5zv?=
 =?us-ascii?Q?Nu/yB5VXMnufJdVJ63R+u7+XfZiKxzILHrDX5ifqBclM+jEvdM5Qffa5yo90?=
 =?us-ascii?Q?txg2pfg+0YX19ixMRUzzLCaQH+aP9Gw0ewQhw6YVKdAtBBMAj2DgHRNHqF4Y?=
 =?us-ascii?Q?DWzB5WUSetRM8uzJmhPcxyZlJ2uXiGUOcEFmUA9RTHG3YYUf6XMbmAUQ2YN4?=
 =?us-ascii?Q?BBy1+iqYMo5WKdddR5JOX8vw/v7MasDZ/tqtwxUBLN55pQrPw5cWjGu+Xop8?=
 =?us-ascii?Q?gXa6IoKXVLkaBHBcONwohF3djrTY4xG33r0+4NhiADTI1Urix6YDjbXLfCUn?=
 =?us-ascii?Q?KsNiQuiQ5NR9pdrqHc89gHQfowHOsXbJ0NHbk7dsaB+7x79SeFQZGySU1C7p?=
 =?us-ascii?Q?W7V4z0xtsp2KpLz25cgVbtgFCwrgaH68g+1Mq/Z9IUnoKVYLDh5lw7Gr38D6?=
 =?us-ascii?Q?cYl3dSvvD9rCUQUyaOi+kwT7x0MDtjUbd/8m/6awktjqog66pBE8V7NoR+hZ?=
 =?us-ascii?Q?ID1wRZCrGC6tdsYiCDeSDOOYCWPbda03zq7DoNhocLgfOi/VSFY6lR3FlMiV?=
 =?us-ascii?Q?dIAexe+5ANXaoIh+eynEk8Mim6tE/xwrB8qfliRakb1yZ1C+A1AjO4SW7+Hx?=
 =?us-ascii?Q?yCmbjlysB2rM8SMhREjUpt29uhssXudESBl3rqG2S74hZD8SZWo91TT4anM+?=
 =?us-ascii?Q?Pnl7MIDWjhP3SkVQ2Zlgau8ZZJJ8d+ozn9swZ9916hFmu85rmZQlgeYjkIIa?=
 =?us-ascii?Q?qoZbVfSL1MR4O9b2pKilVXIk1Ybs5ixxCnyTDRJNSp5/stJgUiqzNsnT4DZK?=
 =?us-ascii?Q?9syy52g1IbUpUPDBozB5Lw9t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZaAIX/6ZgsHjG3Eb+KSiMjrcSPTPRf/PTadTOQt6l2xL2iaYhX5Vign4x0G?=
 =?us-ascii?Q?fAek/oBa2RzHzrXpiWCk6y+wwFIHu/0ArM83bLCL3ICvV5QWXbS6jaE8eFIO?=
 =?us-ascii?Q?A10BsgLHq4jc0fJyq/DQBtaZnTSYVNJwgzl1olUHVl2diPtA3G+voQXiYkoe?=
 =?us-ascii?Q?4+J5TJ9Sr8IdrB50CWmEBZYQyuf8X4S6pH3a9M68MWI6ujZy8MS9b7mvHD2Z?=
 =?us-ascii?Q?/0Gz6aKAWAw5sgoLjZ/PkRep3b52s7e4A9Qo1MjYHYlLPesT5TgytHHk08ZH?=
 =?us-ascii?Q?VNqHiS9/Pc+qQZwAV9jod0+I4pnRE69PVnFx7aXxA6jNtoNDJdIy53dCbx/B?=
 =?us-ascii?Q?Z1088AVoDd2xfmv/xfoPSSs2jZfpE0qCGkAXZqfItf7wtMwUVcW2kV4thVY2?=
 =?us-ascii?Q?l0hv4uZG9/gBlni4qkWOy8orBZyjNpZXEAkshP8z1N8a0Ica8UlUsbetvkkn?=
 =?us-ascii?Q?mzgmSccHC1wPJtx/dJwX3SUXDKMcOvBXNVSg1SiNfQSd2UGHjLttZuiOAhhj?=
 =?us-ascii?Q?pud6zr+/py71eo09ClhL/Fk5pC6keyES1Zv7xrYbYvzgGNR3eVfEzC/vWxsU?=
 =?us-ascii?Q?3paPYrFQGqEnIoIYpmtf2EIz5IL3q293teCPM6e/P1FiYhNTcb2K++SMMq1u?=
 =?us-ascii?Q?AHGkExjES520XnVGU0pkQ3pIGaO/oQ9rbSleUU6pL6AISSmioqdPTNO3aTAc?=
 =?us-ascii?Q?ctSoG9HRZzWwVPLmVqgIgB9jTJd1Vs0rzu7dUX4TnzD1qKD3Rs2N0xEOBtJa?=
 =?us-ascii?Q?8pU/szhSHbdqCpYPuTNXqnSpae5GStPXmF9/DqJpp9Oljur0B9QS1JNOEepJ?=
 =?us-ascii?Q?M4j6+yPp7foX5sSeNCFAa9hfjd62nSeXtDhgyVfZ7hzsCWse0PWXi4/thUi+?=
 =?us-ascii?Q?isCPDQIbHJh65k7JcGu+9JzbWUXjefvAS8NwfpnP0pXN1o41QJXS79309Z+8?=
 =?us-ascii?Q?D8eXhNrLd/O7qpR/9qPvoHJKST/D5ZHIBqwqcVnPOL7xQBZle7+WnVuCDlEx?=
 =?us-ascii?Q?0aoVQD1wlVSoiDYOl+UMHaBhxjc0ffW3DBQiNfpy2Er0axG4DRThVJ5jGZMY?=
 =?us-ascii?Q?3SA4o2pUyhAlSzIKbPTAz1kg0aTptttKxqW10VrxcH8u98X+oyT7GJ+F3JqN?=
 =?us-ascii?Q?lSKzlvJfJoMdmFoCTqWxRP+n9rcIYBoV70UTfNd4r4mnsPxuI+RlkADS1ttJ?=
 =?us-ascii?Q?+e4enMQmstjH+yvUKuBq36A+zS3S5ixNf2IFQQY/ZmDtCEiTuEq0lmvtp9Oi?=
 =?us-ascii?Q?/W4NH/hJ3Bqvfh6FrOwbg3ZP+jNmoPiB94JU1qJe4sfxH75z9XmDJeNAa2Ap?=
 =?us-ascii?Q?dK5BkBAyaLgXsimW+1Qv8IqqUTb7W6QjtmVw6IZk3RpouEQb1bzH/xZQNKhZ?=
 =?us-ascii?Q?q/ojaPiy08QJsP68MXlse2//4ly3XAYzHkir8usGh/iNybckBYcADM+eCjDE?=
 =?us-ascii?Q?0Q8Z97F5dARepmRzK+PeYRYZOQkr5wcBnngnV3YPHiISy9gXkGZeGubLUd6e?=
 =?us-ascii?Q?pmNlMMq6P+EGEp97Nbkxw0r/eaom3/WQEp48AXAHr+xE34LEfpGFU7MRm2wR?=
 =?us-ascii?Q?q+ypSPuiAOm6BtlY+8F7nmdYkTrwjcmN8RpZlKTVEUVxv4rCh0bYMTJzib4O?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pnk4gEG+6rJgb+P9c2g9NRCegSS4EhhYtpt8xRqaaqH/A6kyWMO5Gy9zouHYkoGJaO/zEq6qPgZH/Tczq8yqniP0ql8adhDQXgIV+TljUBZwCkGlRYWjvQWe9W4vo2pdNicQD0ubyruceA5gu6Dt8xAwRNNIvLSXd26rctZVSh5aeEb1c5rjD60lEed1WUVwvtHVZB5NW6uf/v7uk0Z3Qv0k4KUsl1c4lhA/fxWO6qJNT3VV6kVk+QtzOdGj5UNQDvLxyxrhH3i1YrVs5qfbZ29Zjr/il1G/H78R+2lzAHI57NTbWoDyCqGa+eGy5eICyjbni71HqVjlLEdbXDS3y2hYjA+LriHhV7azcs3lnjSEIPen7qgoEvTIBYGPiho2ULtuLflTy7vpwq88v8YgjfCAOPdeLX/m0GKLaft+k4GK4kOj14b7UHh0Ovgmn5epux8VrKfmwQVseg5izJHOUnj4lE+RQF/hhjMKkGa9DAz1rxnZW5sZc7R7w/jMcpZUUW2atg1QZ7vXdJKueGQRo+MwJgRqFqM43TJKpBdj0Xgmkc2qi+GKt7bUS8Y/eAXSt2l2vwnxbh10t2+OSwcWzQFQctMq7e+a7BZGCxtPWUc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c1c1bb-66d5-4103-11a0-08dcf81a2687
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 13:03:58.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1U5mx/vpwpEBh5EeqWH/wsRv9Nb7pfaoGxfwFGMKdSbIIlONL8gDsygE3v5hc8IdJ/I0t4qGdOeJ3hmoslj2jkYQlmMVCVhdRkIrDhjXQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290099
X-Proofpoint-ORIG-GUID: _qoJqAsXEoa8eX8u-nxYpx_b2WVe98-m
X-Proofpoint-GUID: _qoJqAsXEoa8eX8u-nxYpx_b2WVe98-m

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 18 ++++++++++++++++++
 mm/mmap.c     |  5 ++---
 mm/nommu.c    |  3 +--
 mm/vma.c      | 14 +++++---------
 mm/vma.h      |  4 +---
 5 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4eab2961e69c..64c2eb0b160e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -135,6 +135,24 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }

+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+static inline void vma_close(struct vm_area_struct *vma)
+{
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &vma_dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_MMU

 /* Flags for folio_pte_batch(). */
diff --git a/mm/mmap.c b/mm/mmap.c
index 6e3b25f7728f..ac0604f146f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1573,8 +1573,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;

 close_and_free_vma:
-	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);

 	if (file || vma->vm_file) {
 unmap_and_free_vma:
@@ -1934,7 +1933,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
+		remove_vma(vma, /* unreachable = */ true);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
diff --git a/mm/nommu.c b/mm/nommu.c
index f9ccc02458ec..635d028d647b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -589,8 +589,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/vma.c b/mm/vma.c
index b21ffec33f8e..7621384d64cf 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -323,11 +323,10 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
+void remove_vma(struct vm_area_struct *vma, bool unreachable)
 {
 	might_sleep();
-	if (!closed && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -1115,9 +1114,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
-			vma->vm_ops->close(vma);
-	vms->closed_vm_ops = true;
+		vma_close(vma);
 }

 /*
@@ -1160,7 +1157,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
+		remove_vma(vma, /* unreachable = */ false);

 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -1684,8 +1681,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;

 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);

 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/vma.h b/mm/vma.h
index 55457cb68200..75558b5e9c8c 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -42,7 +42,6 @@ struct vma_munmap_struct {
 	int vma_count;                  /* Number of vmas that will be removed */
 	bool unlock;                    /* Unlock after the munmap */
 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 	/* 1 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
@@ -198,7 +197,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
 	vms->clear_ptes = false;
-	vms->closed_vm_ops = false;
 }
 #endif

@@ -269,7 +267,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);

-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
+void remove_vma(struct vm_area_struct *vma, bool unreachable);

 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
--
2.47.0

