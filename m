Return-Path: <linux-kernel+bounces-548673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC126A547DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79043AD044
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922920968E;
	Thu,  6 Mar 2025 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LBUT4bXL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NhiKF4oz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114992040B3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257274; cv=fail; b=X06qG6Nyfx3muBRFHGs0gr2PRAhziabqPm/CODdg6IKZf8zB/eksneRtU3qBNQAZvlLYqeuU4+YQb8Kcn0PKJAOqb13w9+M9SJ+DUvq6dii2IIf0RTtT2p1d9LnkWn0FMH+IQdUk8WB+D3LAoBywrL5v921E2hWpD4+usCLkxEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257274; c=relaxed/simple;
	bh=kR0VMTouP5a768/PXsjFNe7YPzR3RBenXOj2HKIK34I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOSVBEqRPG7oMR58FRjJMSVpCvF7zUjtBU17DhTNvk5qY4udbqnZ//EoKasF+iJ9leOyj+mIicCYswgZeBDj/Igsdq7MF8bfneK3yJIgyCa8zjf8kiyAErkL4xHxHj//uWnyqNnWdqdNWJzcp5mbtU0dKZLLiE2VEJJCBrApMNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LBUT4bXL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NhiKF4oz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526ABfhG024533;
	Thu, 6 Mar 2025 10:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=53S3I5wh33yuvzRwUMeMC0CFiZy3kRXRqKeBTovpeX8=; b=
	LBUT4bXL+yQFh93FHTkND1jHuvwa+5yJxV/tTE7TxMQq6ew/wBPn7tDEPVEzYMG3
	ceB8ZZkCEloEgGQ5UeH+7Yplx4rLeST6Jgxj2f9KO6xBbIJNmXTns0LKh8ndffWu
	SdR3p/oDdNzVIyO3poGS4/nbOYTfqEqSRaN4YPuLiKl/FssQWkthAdGkXFbwAgmo
	QBI0T/KUExNSxT9oA4JRb3fJJ9S9j+QEbc7a3J56r9azgBiNIbc/FFi5oDKfpjbR
	TdeBP7GDgry6Clbliud/yeSIq4l8Z9J5NmaP1G3QMLGOoSIQTMv3lxadNNsEqEDA
	2CHgc6YO8Sg1x2UEPn0Nwg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hhttk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5268WZMR010893;
	Thu, 6 Mar 2025 10:34:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdh6uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6Tg6Nv0dwtXhfA+aG5ym6gDaxQ6sZZS8KfQRg+k+sM1bQnFjKZtLAeztAy5cvI/M/hg/ZCdz5qX/f2x3qCG2jYt/7qGT1OF297G8y567EX04YnPA7vxwsqHhwH5HXJk/XhM0tzmw/V+Y0INa/BB+uWnpkow3g8YDjLPfNTljHCeU2GHt7DjyTLsyGgRKlfD2zwFHyKEMv14xnUew5699Y2WvpCtlIdHLh08b7tMRqqJwvm8u5n6AfeJBvOrmqt3Rj6CqmpNl358rVU5u1LT2RLU3n/NHhN5/6hmzqllxx61TmD5B/3AcBmMBl3759A8bW4qTh1XL9FNyGTefzEXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53S3I5wh33yuvzRwUMeMC0CFiZy3kRXRqKeBTovpeX8=;
 b=ZNE+NwjoHFYxUdjY8qI93Qqp9xeUnEkvhy6vbvBFAOjcgao/Cs6wVBT6bWPPtO0yYqBYBN5Pv2OrGTI4oEdoyi9udZFPIb9X795U7NUelBYvJFojioYzi8gIsPJn+MRN+3sdsHGQYERgkj4DtYdj6tjH/Lh7nN4ryBpWCqRAnKaksVpDLZlEX22D4ZlfznHqVszHwGHfszz6qnXpsceU1Jg1CrP/PwW91D594F24PODdYW7UanWLDjSpbVsDfytoVFYQAWYCZS5FYXFWfZcBGR+tFn1BKAf6Ah1vkw5BU9+Fc9/D+KbXOFTxxn4ap4a93pEUVMLET3aWsZUQAPLAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53S3I5wh33yuvzRwUMeMC0CFiZy3kRXRqKeBTovpeX8=;
 b=NhiKF4ozy3EdTJ3VmtcUbk+qXyphvpw9+EdTbJUFeH0NXc8zHAvB/HS+IwfG37WEQ1u9bnu45orAue8QVhYS/5vTmU95BYxFFQTaKdgrz8/0GHLmEEiqzx079+7+wn+wV59/OLnny9itaP841+nSIyBNTT4Fpf17w2yEgiUUYSM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 10:34:20 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 10:34:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 6/7] mm/mremap: refactor move_page_tables(), abstracting state
Date: Thu,  6 Mar 2025 10:34:02 +0000
Message-ID: <89f2446f70acd41172dadbb3404db9d95415c78c.1741256580.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::21) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d3d8c4-96f1-4d01-28ea-08dd5c9a743a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IeV3kaKjHwejKuZia+sgfye9xP8bS8DdDkU8oEPVFBqLFGEmzZOBoBPNQb5o?=
 =?us-ascii?Q?Kc3P6r/UG5nXzFwHoe2v0Cs/+i0xeRXWI+P5Rm6YXZ+VH7yoV9jK8y8AFAcw?=
 =?us-ascii?Q?+sNBXBRAaEJFzDob6UvMG39RfNRhE/CPAFore5keLcNaaoh+KU208MUVndsj?=
 =?us-ascii?Q?nax9Qq9JRybrPHTlyedmyxbXo1Hblj88/jQXCcQzTJXENqUefYssTlBfGUSH?=
 =?us-ascii?Q?7ZwXgARkcR0cMmXjpZfsS3U1G/+ReBzkeVR1WzEdfpb4MumUbvyZQJIyvioJ?=
 =?us-ascii?Q?6u887pdW8B/BJvZWL7XyUggjv8D2O7hOWHe3jXvB9pc/+dDp4SFje1B8TB5s?=
 =?us-ascii?Q?sBi4bA1gLNFXgqAlLrmwX5jEteN36LaWNS4iwdR+Mymar3qxQgYWs5+0WLTT?=
 =?us-ascii?Q?6erBeJlCQzAy7yzSTx5vxfq/klQUWkwkpsfsKQAG6/rhvyAWt1YsQSwf9Ngm?=
 =?us-ascii?Q?yXCJR7VaHTOxoYyqB1mwmpkGSIukXSOm2HZ8xBGjH9rg0EVTX03IqJZEGUOf?=
 =?us-ascii?Q?GrUoe+h30m6BDnE1sdVym7TZl0wsiIy1Msqd1l4c6TIUOxTkPF3zYki24F1d?=
 =?us-ascii?Q?81PnQL3kiR6uTSqaHOol67Vc1ykc7EwU4pRHG+uahSlvNxdr+k7UtkgsNEjP?=
 =?us-ascii?Q?nVhNFUre6VnZvpLufDuLvv6cbVur4GSABQWT6FoO3i50+lwozNpW1H+yuuQX?=
 =?us-ascii?Q?SF5Lroxnp1KxlCeL2fLEaHJK+LF5cICaiuICE0WtkViiAzgBblrMQFD/CUKb?=
 =?us-ascii?Q?ofo7ykj/61x/CB/LHoJcQxcOqlIqfD4KFgpbTqXhiCAyPiXitg8lxPJg9ged?=
 =?us-ascii?Q?3D3vdNShn8zRZpYPBxse/yZOKQw2DlWtNwyzAysNccGdBeSFIwuRS0DWIv8c?=
 =?us-ascii?Q?xjXKKB8n7Nvdbq+lm4tGHfmEwjMgGkLVpPPSo4EjkdA/eRRpafqOm9pb85Zz?=
 =?us-ascii?Q?e0pXgXJvpeo9n60CQuYsYCEVqdwy9cJHmREr3Mi+ZQNuxUZMl6W7thj8eqo4?=
 =?us-ascii?Q?sFC1fYqku10+DTZIglmihXOLqqC3bpJgSi10FNSpCgJd+QVpSDy7P3PSRDWm?=
 =?us-ascii?Q?Wazh5DD9Sk2AowVtwJPoMSKhTF87b3NcBOA5mTHLZflaE+D00G5QSDF+CUKi?=
 =?us-ascii?Q?477L1ftVxyGbluqaCMP4Q2AiqkpEMx+7zy0ijVc+6WXvMQ3cRcpq78gFmquV?=
 =?us-ascii?Q?v09g5HZPLI2eGl2kVPUk9OTkqeJSkfmz1CbiisG4Zeg2JBb8kSwJr3QX3duR?=
 =?us-ascii?Q?7WXX6db7BGlWOaE5CWiTt9ID/5h2OADZPLlEaMQVlFs6W4IE9blBM3vhSN4t?=
 =?us-ascii?Q?lGc6QXCceBz/RI24iPYx59R2i9AUQLvF45Pt9vGQ0CZhPDdgKfhrLS3NyNj8?=
 =?us-ascii?Q?H20YNdTR9uYAh88Q6Whn0qsWVcdv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j063hctU8IAJiaUa9IlOTIBfZ0jEcQTee0meBkdg62IR5lJhJJq+Ezh1N/Yw?=
 =?us-ascii?Q?vQBJckbCZDrAnLUD2Ypc0CCWeRmAWCtniAQ1kTnVJBf3BFEHUTaRA4bxchk4?=
 =?us-ascii?Q?qHtdJUyv3LvzuOaAvP8cL7oC0mP5QFw8z+vwL979m3MIcrHap9DgHhWwcLrB?=
 =?us-ascii?Q?XSzbG+pVQqeiC5MwNjw37X0nVpElckKkfDFelkteEtsh0fy01CLyOJIILtKY?=
 =?us-ascii?Q?f0j/BjD/upGh80XVZtQOkHDD0LUE6I+ZnbsySCtM38V6EKDJsm9gLd6y7VVu?=
 =?us-ascii?Q?jgAsf+xgjmdsyQ5e9Q2oszsIJWgBUsPFs8ZO/dBzrUhHCItqY3ECDtkfyaF+?=
 =?us-ascii?Q?8tk8m7HOO6MGS1FpotFmaKZ2dD84IW4T89PwFtA4SU1HHMuxpOB7B67OIOw/?=
 =?us-ascii?Q?pZT8wHisWoYYFEEF0U3XJMD4gjFocDYWMDhdpX+ViKxolyVZyzqtusm5LJk7?=
 =?us-ascii?Q?Inon2FlG4FN0dO/q1Ui9Cvng4YMepY00Wq7qmXc40jkAS8Piw6Ock7qVB9Z+?=
 =?us-ascii?Q?QbbEhtmIqI7omGXoQV1aX97J9Pe8a9caS2nntfJB2ONS2CyvG2nKDK8TpRtp?=
 =?us-ascii?Q?8bPV239XhqLKl7nskIFEa3CE8Np8n9QsOHYZwgAo1AVZ7vARm5dLyztRssVb?=
 =?us-ascii?Q?ZOADyEQMSwNWkPE1wdQHX7tnV943CH9Q1jJCVpBX5zdhnctiOBlpy+TpxzYT?=
 =?us-ascii?Q?WI+m57feqh55O+wRkiygWn9kEVyuHNwnHZAA5NzdrwGAEF3RSJCl1+zcP+9M?=
 =?us-ascii?Q?1G4UGO+JpndjGHHwWXbHf3G+s3VK6g1YWdHvh3kGizmBqM8Exkz9aCxlSBHj?=
 =?us-ascii?Q?XNu4jRlhBAAssr5bsxlbX5ck1i0tPW1oYPYXL+RhGtoRp5ivyA22TokrORon?=
 =?us-ascii?Q?E3dsfALoGZp679EBEObK8+FtGIM+5N9pvBgqMfivSquQnLEBNruvbG0i+0TA?=
 =?us-ascii?Q?cBkkvOhnWiTbbl5EXy2BrzzYXcguTEXm4FFIu2akxqeW6o6OsInlf7akUfbo?=
 =?us-ascii?Q?AZqxPc/Ozr+n6dw5KpB4a3/PDOK1l2DFX8pxpOFhExIiAbc8EJx1Ps5xXnrl?=
 =?us-ascii?Q?sZuMwWBTUGjdqExDuqHQgvn5XFB/0Xwi3ZGqbbW/BmbD0AXOxHJfc6U7Jxo5?=
 =?us-ascii?Q?oNqjjrDJBBYOqxRJVpxJQI30EJIOCsKkgXLPqNnei09E2pO8v0o5jv9uhZ2L?=
 =?us-ascii?Q?XOB/ABfdqxQrqSdPwO/GaLtA+GlUVBksIoISYD8KJf3wYfnzUFnGtP7sj7E3?=
 =?us-ascii?Q?pgyaZIOxEku3IPaqxDCLfiH9Z1gYigUf860K1K5XRl31I1hlqh+iBHTTIwXH?=
 =?us-ascii?Q?sLkocIKtFvfjX8xjONQ3LBBEfTeJPRjrlcxaruTE20wQd9H/jvThwsYrVHOb?=
 =?us-ascii?Q?KxBcodxW2J5dH+4a8NkUEOaesD9gXNjic31NDtkJnOspcsE5T5q91SvAcUQ+?=
 =?us-ascii?Q?JBh0/aIDyYEZITANIkd1/SW8++dFYnqF9vMXi14XABSW2ifcG0L96kP0gu/x?=
 =?us-ascii?Q?UZgV9YfS/93Q5XJZ+K4nIlAPSpEIK0xa8tEIU5YzgMWyhctC1jkSyh9MvptV?=
 =?us-ascii?Q?yvjLPl9TOAMRTt4NJXnwa1PIK+GGBpiI6l02YrAlQjmQDHFTjyqo+fpEPyvG?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uS6S/KBn/0Kuyu9+S3dAFsAAShjHuQIR6IdN/NLTFyJJP34tA0DE0tNUnx9/cbvUBk3SrAdLokdJIApSPCSIxFwfECFstxRFtrlcF9wuzUYWEcuu/1NizBHwXPvFZAOqRS+bwegML8U0kuevUN+vKzuACqYxG6YL3xWC6Hd6gzTf+KWA6LA9N7QprTcOAz+RkXunaoGNi9Em+I2a++PYg/4atblugwV4XFhkWTyupJEjT9+M+nTm5jCKIOwLkhtx+yBtOlxe6S2p6do/anGcZdtp0p3lfr2GtplKd4NBALDdmseZoUlvdVmnuPlhibSphj83+IbHZQhCjxVNvLwU3ftLNOoY3VUXBBIVl6PMNGjjXTy450ltsrKlB+w2aRaWRaV9WB181kvcmQVQXuqvsJMUTRW2432aXkZjM0zEj0baUaYETo1n/nh75joUiyrk14jvXlYWxlhrlyh7lD+dEKTVroilWH/Ny86rTrVBv2MC2qOmlVIkhObWBWG8GXliyh0FXXrhm1ZyLodHm9DLh/RMa1KkAV9HA5N6g88qSIT2FKGjO/uX9S0In8+jcty0V02dEEfERJh5oqWHMJlsKi1FUWk/VrVNi1wIVLmIO0w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d3d8c4-96f1-4d01-28ea-08dd5c9a743a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:34:20.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0GH2Ti9WVlgDC/HE2rwWU9Ng1u/irwcecOof94F+JuHKI4rS0d+BDEas+Q2aFl1ZRdr1WMWuS3MNTN0m2p+H8hTN8Gavt8VIzx1uKofuh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060079
X-Proofpoint-GUID: O4r79k61AZwph2guSg0q2LrFizcX8NY4
X-Proofpoint-ORIG-GUID: O4r79k61AZwph2guSg0q2LrFizcX8NY4

A lot of state is threaded throughout the page table moving logic within
the mremap code, including boolean values which control behaviour
specifically in regard to whether rmap locks need be held over the
operation and whether the VMA belongs to a temporary stack being moved by
move_arg_pages() (and consequently, relocate_vma_down()).

As we already transmit state throughout this operation, it is neater and
more readable to maintain a small state object.  We do so in the form of
pagetable_move_control.

In addition, this allows us to update parameters within the state as we
manipulate things, for instance with regard to the page table realignment
logic.

In future I want to add additional functionality to the page table logic,
so this is an additional motivation for making it easier to do so.

This patch changes move_page_tables() to accept a pointer to a
pagetable_move_control struct, and performs changes at this level only.
Further page table logic will be updated in a subsequent patch.

We additionally also take the opportunity to add significant comments
describing the address realignment logic to make it abundantly clear what
is going on in this code.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  46 ++++++++++++--
 mm/mmap.c     |   5 +-
 mm/mremap.c   | 172 ++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 171 insertions(+), 52 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7a4f81a6edd6..a4608c85a3ba 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -24,6 +24,47 @@
 
 struct folio_batch;
 
+/*
+ * Maintains state across a page table move. The operation assumes both source
+ * and destination VMAs already exist and are specified by the user.
+ *
+ * Partial moves are permitted, but:
+ *      from_vma->vm_start <= from_addr < from_vma->vm_end - len
+ *      to_vma->vm_start <= to_addr < to_vma->vm_end - len
+ *
+ * Must be maintained.
+ *
+ * mmap lock must be held in write and VMA write locks must be held on any VMA
+ * that is visible.
+ *
+ * Use the PAGETABLE_MOVE() macro to initialise this struct.
+ *
+ * NOTE: The page table move is affected by reading from [old_addr, old_end),
+ * and old_addr may be updated for better page table alignment, so len_in
+ * represents the length of the range being copied as specified by the user.
+ */
+struct pagetable_move_control {
+	struct vm_area_struct *old; /* Source VMA. */
+	struct vm_area_struct *new; /* Destination VMA. */
+	unsigned long old_addr; /* Address from which the move begins. */
+	unsigned long old_end; /* Exclusive address at which old range ends. */
+	unsigned long new_addr; /* Address to move page tables to. */
+	unsigned long len_in; /* Bytes to remap specified by user. */
+
+	bool need_rmap_locks; /* Do rmap locks need to be taken? */
+	bool for_stack; /* Is this an early temp stack being moved? */
+};
+
+#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_)	\
+	struct pagetable_move_control name = {				\
+		.old = old_,						\
+		.new = new_,						\
+		.old_addr = old_addr_,					\
+		.old_end = (old_addr_) + (len_),			\
+		.new_addr = new_addr_,					\
+		.len_in = len_,						\
+	}
+
 /*
  * The set of flags that only affect watermark checking and reclaim
  * behaviour. This is used by the MM to obey the caller constraints
@@ -1537,10 +1578,7 @@ extern struct list_lru shadow_nodes;
 } while (0)
 
 /* mremap.c */
-unsigned long move_page_tables(struct vm_area_struct *vma,
-	unsigned long old_addr, struct vm_area_struct *new_vma,
-	unsigned long new_addr, unsigned long len,
-	bool need_rmap_locks, bool for_stack);
+unsigned long move_page_tables(struct pagetable_move_control *pmc);
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 void accept_page(struct page *page);
diff --git a/mm/mmap.c b/mm/mmap.c
index 15d6cd7cc845..efcc4ca7500d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1694,6 +1694,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
+	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
 
 	BUG_ON(new_start > new_end);
 
@@ -1716,8 +1717,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	 * move the page tables downwards, on failure we rely on
 	 * process cleanup to remove whatever mess we made.
 	 */
-	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false, true))
+	pmc.for_stack = true;
+	if (length != move_page_tables(&pmc))
 		return -ENOMEM;
 
 	tlb_gather_mmu(&tlb, mm);
diff --git a/mm/mremap.c b/mm/mremap.c
index df550780a450..a4b0124528fa 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -580,8 +580,9 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
  * the VMA that is created to span the source and destination of the move,
  * so we make an exception for it.
  */
-static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
-			    unsigned long mask, bool for_stack)
+static bool can_align_down(struct pagetable_move_control *pmc,
+			   struct vm_area_struct *vma, unsigned long addr_to_align,
+			   unsigned long mask)
 {
 	unsigned long addr_masked = addr_to_align & mask;
 
@@ -590,11 +591,11 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 	 * of the corresponding VMA, we can't align down or we will destroy part
 	 * of the current mapping.
 	 */
-	if (!for_stack && vma->vm_start != addr_to_align)
+	if (!pmc->for_stack && vma->vm_start != addr_to_align)
 		return false;
 
 	/* In the stack case we explicitly permit in-VMA alignment. */
-	if (for_stack && addr_masked >= vma->vm_start)
+	if (pmc->for_stack && addr_masked >= vma->vm_start)
 		return true;
 
 	/*
@@ -604,54 +605,131 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 	return find_vma_intersection(vma->vm_mm, addr_masked, vma->vm_start) == NULL;
 }
 
-/* Opportunistically realign to specified boundary for faster copy. */
-static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
-			     unsigned long *new_addr, struct vm_area_struct *new_vma,
-			     unsigned long mask, bool for_stack)
+/*
+ * Determine if are in fact able to realign for efficiency to a higher page
+ * table boundary.
+ */
+static bool can_realign_addr(struct pagetable_move_control *pmc,
+			     unsigned long pagetable_mask)
 {
+	unsigned long align_mask = ~pagetable_mask;
+	unsigned long old_align = pmc->old_addr & align_mask;
+	unsigned long new_align = pmc->new_addr & align_mask;
+	unsigned long pagetable_size = align_mask + 1;
+	unsigned long old_align_next = pagetable_size - old_align;
+
+	/*
+	 * We don't want to have to go hunting for VMAs from the end of the old
+	 * VMA to the next page table boundary, also we want to make sure the
+	 * operation is wortwhile.
+	 *
+	 * So ensure that we only perform this realignment if the end of the
+	 * range being copied from is at least page table aligned:
+	 *
+	 * boundary                        boundary
+	 *    .<- old_align ->                .
+	 *    .              |----------------.-----------|
+	 *    .              |          vma   .           |
+	 *    .              |----------------.-----------|
+	 *    .              <----------------.----------->
+	 *    .                          len_in
+	 *    <------------------------------->
+	 *    .         pagetable_size        .
+	 *    .              <---------------->
+	 *    .                old_align_next .
+	 */
+	if (pmc->len_in < old_align_next)
+		return false;
+
 	/* Skip if the addresses are already aligned. */
-	if ((*old_addr & ~mask) == 0)
-		return;
+	if (old_align == 0)
+		return false;
 
 	/* Only realign if the new and old addresses are mutually aligned. */
-	if ((*old_addr & ~mask) != (*new_addr & ~mask))
-		return;
+	if (old_align != new_align)
+		return false;
 
 	/* Ensure realignment doesn't cause overlap with existing mappings. */
-	if (!can_align_down(old_vma, *old_addr, mask, for_stack) ||
-	    !can_align_down(new_vma, *new_addr, mask, for_stack))
+	if (!can_align_down(pmc, pmc->old, pmc->old_addr, pagetable_mask) ||
+	    !can_align_down(pmc, pmc->new, pmc->new_addr, pagetable_mask))
+		return false;
+
+	return true;
+}
+
+/*
+ * Opportunistically realign to specified boundary for faster copy.
+ *
+ * Consider an mremap() of a VMA with page table boundaries as below, and no
+ * preceding VMAs from the lower page table boundary to the start of the VMA,
+ * with the end of the range being at least page table aligned:
+ *
+ *   boundary                        boundary
+ *      .              |----------------.-----------|
+ *      .              |          vma   .           |
+ *      .              |----------------.-----------|
+ *      .         pmc->old_addr         .      pmc->old_end
+ *      .              <---------------------------->
+ *      .                  move these page tables
+ *
+ * If we proceed with moving page tables in this scenario, we will have a lot of
+ * work to do traversing old page tables and establishing new ones in the
+ * destination across multiple lower level page tables.
+ *
+ * The idea here is simply to align pmc->old_addr, pmc->new_addr down to the
+ * page table boundary, so we can simply copy a single page table entry for the
+ * aligned portion of the VMA instead:
+ *
+ *   boundary                        boundary
+ *      .              |----------------.-----------|
+ *      .              |          vma   .           |
+ *      .              |----------------.-----------|
+ * pmc->old_addr                        .      pmc->old_end
+ *      <------------------------------------------->
+ *      .           move these page tables
+ */
+static void try_realign_addr(struct pagetable_move_control *pmc,
+			     unsigned long pagetable_mask)
+{
+
+	if (!can_realign_addr(pmc, pagetable_mask))
 		return;
 
-	*old_addr = *old_addr & mask;
-	*new_addr = *new_addr & mask;
+	/*
+	 * Simply align to page table boundaries. Note that we do NOT update the
+	 * pmc->old_end value, and since the move_page_tables() operation spans
+	 * from [old_addr, old_end) (offsetting new_addr as it is performed),
+	 * this simply changes the start of the copy, not the end.
+	 */
+	pmc->old_addr &= pagetable_mask;
+	pmc->new_addr &= pagetable_mask;
 }
 
-unsigned long move_page_tables(struct vm_area_struct *vma,
-		unsigned long old_addr, struct vm_area_struct *new_vma,
-		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks, bool for_stack)
+unsigned long move_page_tables(struct pagetable_move_control *pmc)
 {
 	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
 	pud_t *old_pud, *new_pud;
+	unsigned long old_addr, new_addr;
+	struct vm_area_struct *vma = pmc->old;
 
-	if (!len)
+	if (!pmc->len_in)
 		return 0;
 
-	old_end = old_addr + len;
-
 	if (is_vm_hugetlb_page(vma))
-		return move_hugetlb_page_tables(vma, new_vma, old_addr,
-						new_addr, len);
+		return move_hugetlb_page_tables(pmc->old, pmc->new, pmc->old_addr,
+						pmc->new_addr, pmc->len_in);
 
 	/*
 	 * If possible, realign addresses to PMD boundary for faster copy.
 	 * Only realign if the mremap copying hits a PMD boundary.
 	 */
-	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
-		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK,
-				 for_stack);
+	try_realign_addr(pmc, PMD_MASK);
+	/* These may have been changed. */
+	old_addr = pmc->old_addr;
+	new_addr = pmc->new_addr;
+	old_end = pmc->old_end;
 
 	flush_cache_range(vma, old_addr, old_end);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
@@ -675,12 +753,11 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
-					       old_pud, new_pud, need_rmap_locks);
+					       old_pud, new_pud, pmc->need_rmap_locks);
 				/* We ignore and continue on error? */
 				continue;
 			}
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
-
 			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
 					   old_pud, new_pud, true))
 				continue;
@@ -698,7 +775,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		    pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, need_rmap_locks))
+					   old_pmd, new_pmd, pmc->need_rmap_locks))
 				continue;
 			split_huge_pmd(vma, old_pmd, old_addr);
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
@@ -713,10 +790,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		}
 		if (pmd_none(*old_pmd))
 			continue;
-		if (pte_alloc(new_vma->vm_mm, new_pmd))
+		if (pte_alloc(pmc->new->vm_mm, new_pmd))
 			break;
 		if (move_ptes(vma, old_pmd, old_addr, old_addr + extent,
-			      new_vma, new_pmd, new_addr, need_rmap_locks) < 0)
+			      pmc->new, new_pmd, new_addr, pmc->need_rmap_locks) < 0)
 			goto again;
 	}
 
@@ -726,10 +803,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	 * Prevent negative return values when {old,new}_addr was realigned
 	 * but we broke out of the above loop for the first PMD itself.
 	 */
-	if (old_addr < old_end - len)
+	if (old_addr < old_end - pmc->len_in)
 		return 0;
 
-	return len + old_addr - old_end;	/* how much done */
+	return pmc->len_in + old_addr - old_end;	/* how much done */
 }
 
 /* Set vrm->delta to the difference in VMA size specified by user. */
@@ -1039,37 +1116,40 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 	unsigned long internal_pgoff = internal_offset >> PAGE_SHIFT;
 	unsigned long new_pgoff = vrm->vma->vm_pgoff + internal_pgoff;
 	unsigned long moved_len;
-	bool need_rmap_locks;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = vrm->vma;
 	struct vm_area_struct *new_vma;
 	int err = 0;
+	PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
 
-	new_vma = copy_vma(&vrm->vma, vrm->new_addr, vrm->new_len, new_pgoff,
-			   &need_rmap_locks);
+	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
+			   &pmc.need_rmap_locks);
 	if (!new_vma) {
 		vrm_uncharge(vrm);
 		*new_vma_ptr = NULL;
 		return -ENOMEM;
 	}
-	vma = vrm->vma;
+	vrm->vma = vma;
+	pmc.old = vma;
+	pmc.new = new_vma;
 
-	moved_len = move_page_tables(vma, vrm->addr, new_vma,
-				     vrm->new_addr, vrm->old_len,
-				     need_rmap_locks, /* for_stack= */false);
+	moved_len = move_page_tables(&pmc);
 	if (moved_len < vrm->old_len)
 		err = -ENOMEM;
 	else if (vma->vm_ops && vma->vm_ops->mremap)
 		err = vma->vm_ops->mremap(new_vma);
 
 	if (unlikely(err)) {
+		PAGETABLE_MOVE(pmc_revert, new_vma, vma, vrm->new_addr,
+			       vrm->addr, moved_len);
+
 		/*
 		 * On error, move entries back from new area to old,
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
 		 */
-		move_page_tables(new_vma, vrm->new_addr, vma, vrm->addr,
-				 moved_len, /* need_rmap_locks = */true,
-				 /* for_stack= */false);
+		pmc_revert.need_rmap_locks = true;
+		move_page_tables(&pmc_revert);
+
 		vrm->vma = new_vma;
 		vrm->old_len = vrm->new_len;
 		vrm->addr = vrm->new_addr;
-- 
2.48.1


