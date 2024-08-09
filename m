Return-Path: <linux-kernel+bounces-280743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9000494CE7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455582828C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B925191F65;
	Fri,  9 Aug 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OnCCV/0S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pGGAiHu/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624341C6E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198725; cv=fail; b=hufkllKh6haWziJkyRgwFoSO1ENknmbbw0qshV6hFadnPCZxAtlyMjJGibjqX8XWRN19t8pG4MWH4H+QeIIiU9+OxKkLjTWkHraABpbYUxkNtyiOmqQHQwDMoiMqtFQpYvJLJiG4RdeAHOXgeBOc92rzcXwOdRsHOVttJqG439A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198725; c=relaxed/simple;
	bh=KVZlu4iitk+BtzBKEKU2K+C4T+qjV6zQ6SYv6uZ3xGI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=foxS5FVS8xzW80xQ81rkNc3prbH1EtAm5ayU/dF9Ad9vp/+9Pxt9D2fF67SMXRapBJY0LWuzN8eLwHsdQZT9NeK+P95+1D/jqr/FcG7tNPFy1S7xbkt2Yw8B3ZfyGoFm+8SIzgaH98dGxuUqns1Pzy1e302Wb/93I5dYklp9J1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OnCCV/0S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pGGAiHu/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4798fTpr002154;
	Fri, 9 Aug 2024 10:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=RB9ACbcgpzXXx65
	qGapJ5xO65407sEXsC8b6sGr3FNs=; b=OnCCV/0SSEgB+q0rEXRAwN5xPWS5oAR
	uHTkovPT1LQHWJNFx/2ULnZEMrnjylBMM7tkareID8cY1+Hgp7bsMd0FnjVNa4zu
	X1tfha3fZ5/nx+ZvDCkCbAkGDsNMBn0AAw9G+4dKdIrqW6ZvzowG8fuEO0mjD+JY
	jgiZI0IMwA07dAZwgeLIoWIFHKC5UP+ltAgH2WhNeKm0kUvlmdjbAp6NRkE1k3Wt
	/bowuwfJwUgtrOHKsqyNV5A4oZz8pmKUQXp/4JgaLUr/n7ux1TgovZkdx/N+ivqg
	i2HEEzZmEBXogNMk9ipCMF2tQJnjc0t/q/w3LXOY6+vVn3hb3aCu8WA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcknrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 10:18:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479AA5j2040776;
	Fri, 9 Aug 2024 10:18:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0cuqv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 10:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmmDF9bN+aI9nAJHbQEmmFAwrO5Hln+ft1OPP6Rk8HAPCeYF25OhqOVtiOOguYf6DS3YTbVrK+wZn7w9G72SsrUCMgDOFbnqQz/kSHvbMDiMDMnt9rZEd5puJ3w4CGEGcuYP11wfZaDhG7Sd2tyA2ouRbLQWHEUOc7IVTE8wKDDr/lYHS3MAqpDbasrhiNOP2xNvbwhaClU+LXJkBeKvXGsCP6+PRiGeGQ6sbbtJXR9bgqrZTREXXwUFmaewqJ1fwgMn3gdx8oGQvo18YMOzRVoiFibFi05z4dICsAyuPdhe9lmaBbL6OAM3T+jh0CwpfxttNwmj/ohgSDWqX4O2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB9ACbcgpzXXx65qGapJ5xO65407sEXsC8b6sGr3FNs=;
 b=EDylcqIek/Mo/hFVX8wBPFXqJoAumHrsWGHbbgMJerHM6u4PVqD7VRejoOfTE930DsWnzmxtrwTEl3ZWZcCRCOmoc26sZm0IxlPkh4060S5lqKDu5FleWPnUgnx/pHzS0Uek7ms6qPhiO/dpxR4eYMT0NFWuBu2WwBV+GP5U/Pzf1QJeVTbSl+CKcgEDTF1X0sgmh+1l5S2Lh2N7YzAI8fVi3iA6VGtGAEbW7WtA5T1dpp9cYnJWDIPY5sMn0AO5ejZI2UotmU6Q7DpWDF2ydcCE1RNZAKtHPkpHkBMsOkT0jLUY0rKWNreTPprrPgHDEOeklyVsJzvhkUqEgOMFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB9ACbcgpzXXx65qGapJ5xO65407sEXsC8b6sGr3FNs=;
 b=pGGAiHu/49AFP9FYV2/Smid5F0twNCrfWeOiT4E68LhJ7qiw2SxI//4YGld//QCmFzYE4V0/pjVYjC65zRK2NKpjoXtDoutSm1QefAucBmBa0EOjtoFGsR2ImTaBugYe0XOCWHYnMvNbj38b+ei+gpyOxI2aRUc+AuFGLWtn+x8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW6PR10MB7659.namprd10.prod.outlook.com (2603:10b6:303:246::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 10:18:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 10:18:22 +0000
Date: Fri, 9 Aug 2024 11:18:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 04/10] mm: abstract parameters for vma_expand/shrink()
Message-ID: <fc88af6c-b06b-4dde-b4cf-92695fbe72d2@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <95292b1d1215f49bd895f1aa38f54a8274c350af.1722849859.git.lorenzo.stoakes@oracle.com>
 <f12608ec-9c40-4977-a5a6-479f86b44e80@kernel.org>
 <2d85f8a8-6937-499c-91fd-7dc5deced71f@lucifer.local>
 <s3m3vhyh6wpxksleq7f64xq45dcf4qpywtjfedhetjsl4o36zq@ayef5yglqdxt>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s3m3vhyh6wpxksleq7f64xq45dcf4qpywtjfedhetjsl4o36zq@ayef5yglqdxt>
X-ClientProxiedBy: LO4P123CA0426.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW6PR10MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ceee912-3465-49e1-5828-08dcb85c98f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fJzTi0D1RwLQgT42qvtkPS14gl2pkxavChNGEgQcATxrh3jzD2eb7uIlBwJi?=
 =?us-ascii?Q?cHtohq9bs0yYKTDYJAfSWa5vSMrgQptCW/sbr0xXQIOBiXw/YupXomX4FnfY?=
 =?us-ascii?Q?Qm+XwnRV29Hh5UB17UeMARHxfGDe9g6YF5Y6rM8XuHX8NZEhCR5YWZD4TgiJ?=
 =?us-ascii?Q?ZYA7oPP8COWMMOwINWcDTX5ySsxUzJ2DQ/efDot2licjjG+aEw5+a3y2IQAo?=
 =?us-ascii?Q?nFHVtDu48f3SnW1tercJkwT1vBHaH1wtUcjRr/+Xk945mTMZX7DqfoRbzhX1?=
 =?us-ascii?Q?RPtW00vDAf/g5RzrLT+HPGZIqGsuHHD6H/a/VJRCOjXYW8OtYl+UAsGiAtcI?=
 =?us-ascii?Q?oFUVsIoIKd448lQhI38eA+7NUrLgQifAyod/zpNvum5hF9J28TkC0ooDUcrd?=
 =?us-ascii?Q?NsNY4F6mMXZYkZs0xIrEz8ZTB4AD7FCL8onvgIjOTDBiXK6YV4FW2VCrbW/K?=
 =?us-ascii?Q?oZsOxZ6+4acFlna2xzv6t2N3hlsgEgZGUpE0Irzfk//+lpt1ZlIOXkSVNNpw?=
 =?us-ascii?Q?VKkL+QQnaBTrIvR8VoUSbSNJnxuEXt2TB3BTaheHK6vMe7s1WyPtPzsdzqe2?=
 =?us-ascii?Q?G5UUCF6zktf40VTIOitDldIgowpPBXpo0yxhRtdZD0Wfe2lt3lqzCZyR0mH8?=
 =?us-ascii?Q?oJmyYjRnXTpE6IWWfrxBaGhWayh9rZhoknNDIOyOpSxPmsb2Q1dyp5UWns2N?=
 =?us-ascii?Q?S4TgEfWAxP2ucuBI4H0WIxHhqJCA5HZTRDuvrilrrclzz3spDmyzUazsnTs0?=
 =?us-ascii?Q?X1K4nGiaIwRblMjYjDKRek8avcGEm4jptUb0pMDYg/7lh6PxqIWvUNrXl8SQ?=
 =?us-ascii?Q?0EyB/hEUjSOb5c3t0y7zVGJSkaY6DKIiRm/k/YiwP+Djf2YKtqmT/lbu1dTF?=
 =?us-ascii?Q?Aqa2G8iNrwe6VE33M4A11mQGyJ+qLx//Ybuj0X9mFKzagJvInOxMCLfCA2Qh?=
 =?us-ascii?Q?OSJTRDhWstemzjRpRYlf/PuycevCe8KL6LXBa2poFoHYZnuhGesrtEQrWJAC?=
 =?us-ascii?Q?CvREz0GeyS8NMgKWgLiKTt3KgQK9QTtpQRJq6UUv4Jwv+REXtmCJJ/2gA0xY?=
 =?us-ascii?Q?zKkC2c94YXwRx7bCk4An/YY9UtXXan/e0EkiU5PbnG5SKug2ysk3zxcBKDqs?=
 =?us-ascii?Q?cpuhfOqdbB7yfaivSNRFGWRBM0dkKekBhfG9rnBHuTakBL/90M3kHEqRZx4M?=
 =?us-ascii?Q?01KgloS8mW41jTLHsRK4UCElwzmJBJwtwDaijcwkwoO0fYfJNNOklZCXOCD7?=
 =?us-ascii?Q?541B+YEMo2o05YyNqerwNl90+ufUy5QY9T14vEecOViuU+kAEIgJpQ8um4jT?=
 =?us-ascii?Q?wZNSQ71NFN+gFb3N7L1GUwm+G5uWVrUd6qnF4S3DsSjFiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X6/U6w6eI9W1g43p9hMwRJz3I+bkRJYs2MNBCW+B7B2oPHwykhLFaTOFJj/S?=
 =?us-ascii?Q?jS3kAh66V9Iarlbewms7sW0FtlDUUC03t2W0wFBO2t4dFkPKAT2e/gQBOnPd?=
 =?us-ascii?Q?M+d9CbCTb1GuGJz5L5BAkiecuD7RmZSB3Z3NpRjGXmNbk+8t/dVZR6b55t8N?=
 =?us-ascii?Q?zvqUAqUAIltcfv2KjEt5DCEkNlhioVaf1SVCH4oKp6Dy5RysyBvb0Byjzy/r?=
 =?us-ascii?Q?f71lCSFoh7VtWEQaTuZnYKmp4l6d7KK0SOwhEoXtdHNRcRdldibFPOay22Ys?=
 =?us-ascii?Q?adasjMk8yajzhgUEnxhUkP4SLIPONuYaraGqCH0YldY3F0z2opIcq98QNw9j?=
 =?us-ascii?Q?M+Z1iEANNZNrArStGXqZ3FXN6kd2wk2IGg8S1ipjfX/bbSRPplwz2g6qc2HV?=
 =?us-ascii?Q?badRoQi97YVjYnNts4ogQoCmI2mT9yst61Le/dbKJL+jlecZZzvZ+iNo4ZnJ?=
 =?us-ascii?Q?Tpdk/W4tZoaVyLqMZxZrouMxyYpwPQR8qvDZ74Su9ZvaxCKQ1s1jvcf8gzcn?=
 =?us-ascii?Q?5T9umC10xFdrlSjk/F1zHBk5WGP9mhbCbwIGcWesFzx2JEyCaEIddYyg2WkG?=
 =?us-ascii?Q?fPULPA4Dnqz1xoUips/tS2N2tQvPdFcnOsR8NNFKNolJN7EsJU5M+ENTpynM?=
 =?us-ascii?Q?bGFdHxkNnwcESDV/etZ3jMbypkQuZXIKoOf/i/MDDd+ih8T4jTctJPTS5G3P?=
 =?us-ascii?Q?9uA1aNngJBzpIaa1mbxkiMpoeMVs8HdXk/o88XKv9KJhR72L+D/M11OsG8Xe?=
 =?us-ascii?Q?R20XqLMkt5nh1dHzyWcaqgIwT3ybgptQIl9WxBUvU/E22aq/Gz1XMFQr57mC?=
 =?us-ascii?Q?gR2VgMt6uSowOjfoFclD/AHbRUzLmb9ODbtTB3aZvtLT7uHUbJpgK06CGQfH?=
 =?us-ascii?Q?8I3F6aHNTXrFe4F8a7eIP6s3IHGKR32ukuPGE9NxsvO32oSWAAKoME1R3tmr?=
 =?us-ascii?Q?zSGw3bwh/iqLJ5eyfrxcH+Xb5WYkaD3oll208wEc7u7FZLWa+aOJgsvxo7RM?=
 =?us-ascii?Q?nTdepCAKp6DRol97D/Cx/DDMd+vVNQvsM/y6Lh8Mz+37yyzklah7aIDxu1+U?=
 =?us-ascii?Q?WFcdUi2+4VVqY8Hka2oKfao8Z18AbQmwJ2ZUeDNU/Oyfbb5OIMicT9IavGMT?=
 =?us-ascii?Q?Z89OspB5weXoH5dhg/iBjGChbbO3aGM6yOE1CxEkIWFgLZNBxmA3hwHazD/Q?=
 =?us-ascii?Q?H+ddmdXleoxxuMqFEUgnnet4+VKXSttWXw5BeSEH8i3mIS5XfiDnjAUwkT4y?=
 =?us-ascii?Q?LbH0niZiNzvfMoIBb7Nlcjn0DrsUJyhDZJfBW8M08FIDm9Fux6X9PduHYVqa?=
 =?us-ascii?Q?ls8fUwkEW3ypbgYsXNdKsMAvPiyHrJ9OU4PMKWywCekMSp+pee/fwXWAY9Ii?=
 =?us-ascii?Q?IxP/SGIrU0apUAyFbVQfrknZHZ81DhaLMoHLMaHMnafDyZ1ezonetiDhGmae?=
 =?us-ascii?Q?pR5pfDLcEwnrolLzxlHSJiOIb/r+TY3755OpuSajPWAYy8PJlFA11MrnAWl0?=
 =?us-ascii?Q?CLR5aCysl3rBnrVHl2wATSfkC1KcDTbb9cTPsBNOkiaZI/AA73B/O5MUy5dl?=
 =?us-ascii?Q?qSsmKPc+t1f21Og8KrrLwBf1fViESEtY8efk5kXUkmHOEGhlyKBt54x4+A7W?=
 =?us-ascii?Q?9/GOwSTnKeRBpQ2eBu2GzIgAnSgs+V+gKydqx9r9OupV3oDrZhBlLMuv/nhT?=
 =?us-ascii?Q?RtHwmQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CR84fJNkLKxpiNwATZVARQQ6xUUYIAKat9aAMH72Mi4wQknAxrUKPRsl8aIeIiyGJIjm8Cp8CIhoVjwt5gJNK+chKSpotXvbt8Wwer3bOstlkr9+q1wTSW1BHGiH4liPp289GXxtabKvg3tO8M2pcguRfBDSqZFrA5KQwMgRak+nwbbNKBcOF19/WlQj+bbV9lvetp3amXflCOsMupUGuvZoEu0JJdRKpI044sBQvYOjwYU3gg5HBcqeRs+mYlMlEzNaG+4feVPY1Rqy9RcQiflvNv103VIGxwGBMKDwVUR+LA4tOls/rbPUMbZqxXduP76R7yqeRr/URT+kdarU4lTtl/jo67U6halgNyYDYOEFngyto+/j9949jXsJxNvwGutcSZs/jCXTfYCLCDLb2f71Vbr/whBKQHOC83feGwmcceuccrTrg19nv4xUuTe2hsR02jQbJ8i4eQUcMvMPUT/50g6ygEMJvs0tPoEeKyv1L7Vrv89b72BT9I2pjBemY1pp+e+xkRhlvDtXO1RMX0RF7T89HpliBaN8mbVZuRkGk8PjXW9prnSGxgq/mPqz9nKUhyfXo8ds/25WzDCd8RsvDrpw91kZTK8ltpoOxi4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceee912-3465-49e1-5828-08dcb85c98f5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 10:18:22.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syJOB+0K9tFvIMo9B4WSvaJr9YbnI+LThZ0sIJI3XAN4Z6YI2X+EoQWzHdIsGklc/AABybHIv5sNrTKIiAL5XIvMwA8dii1ORG3U5djPo2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_07,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090075
X-Proofpoint-GUID: rhbVsH6P--ahnP2bzPJ6pgwkbV9fGhb2
X-Proofpoint-ORIG-GUID: rhbVsH6P--ahnP2bzPJ6pgwkbV9fGhb2

On Thu, Aug 08, 2024 at 04:20:57PM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240808 11:46]:
> > On Thu, Aug 08, 2024 at 04:20:26PM GMT, Vlastimil Babka (SUSE) wrote:
> > > On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > > > Equally use struct vma_merge_struct to abstract parameters for VMA
> > > > expansion and shrinking.
> > > >
> > > > This leads the way to further refactoring and de-duplication by
> > > > standardising the interface.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  mm/mmap.c               | 30 +++++++++++--------
> > > >  mm/vma.c                | 66 ++++++++++++++++++-----------------------
> > > >  mm/vma.h                |  8 ++---
> > > >  tools/testing/vma/vma.c | 18 +++++++++--
> > > >  4 files changed, 65 insertions(+), 57 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 721ced6e37b0..04145347c245 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1367,7 +1367,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  	pgoff_t pglen = len >> PAGE_SHIFT;
> > > >  	unsigned long charged = 0;
> > > >  	unsigned long end = addr + len;
> > > > -	unsigned long merge_start = addr, merge_end = end;
> > > >  	bool writable_file_mapping = false;
> > > >  	int error;
> > > >  	VMA_ITERATOR(vmi, mm, addr);
> > > > @@ -1423,28 +1422,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  	/* Attempt to expand an old mapping */
> > > >  	/* Check next */
> > > >  	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> > > > -		merge_end = next->vm_end;
> > > > -		vma = next;
> > > > +		/* We can adjust this as can_vma_merge_after() doesn't touch */
> > > > +		vmg.end = next->vm_end;
> > >
> > > Ugh, ok but wonder how fragile that is.
> >
> > Yeah you're right this is a bit horrid, I'll find a way to make this less
> > brittle.
> >
> > >
> > > > +		vma = vmg.vma = next;
> > > >  		vmg.pgoff = next->vm_pgoff - pglen;
> > > > -	}
> > > >
> > > > -	if (vma) {
> > > > +		/* We may merge our NULL anon_vma with non-NULL in next. */
> > >
> > > Hm now I realize the if (vma) block probably didn't need to be added in
> > > patch 2 only to removed here, it could have been part of the if (next &&
> > > ...) block above already? Which is not that important, but...
> >
> > You're right, will fix.
> >
> > >
> > > >  		vmg.anon_vma = vma->anon_vma;
> > > > -		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
> > >
> > > I don't see why it's now ok to remove this line? Was it intended? In patch 2
> > > it made sense to me to add it so the can_vma_merge_after() still has the
> > > right ctx for comparing, and this didn't change?
> >
> > Yeah, yikes, I think I was lost in the maelstrom of considering edge cases,
> > and now this is broken for the whole prev vs. next uffd thing.
> >
> > The fact the mmap stuff is not directly testable is a factor here.
> >
> > TL;DR: I'll fix this, you're right.
> >
> > >
> > > >  	}
> > > >
> > > >  	/* Check prev */
> > > >  	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> > > > -		merge_start = prev->vm_start;
> > > > -		vma = prev;
> > > > +		vmg.start = prev->vm_start;
> > > > +		vma = vmg.vma = prev;
> > > >  		vmg.pgoff = prev->vm_pgoff;
> > > >  	} else if (prev) {
> > > >  		vma_iter_next_range(&vmi);
> > > >  	}
> > > >
> > > >  	/* Actually expand, if possible */
> > > > -	if (vma &&
> > > > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
> > > > +	if (vma && !vma_expand(&vmg)) {
> > > >  		khugepaged_enter_vma(vma, vm_flags);
> > > >  		goto expanded;
> > > >  	}
> > > > @@ -2359,6 +2356,13 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > > >  	VMA_ITERATOR(vmi, mm, new_start);
> > > >  	struct vm_area_struct *next;
> > > >  	struct mmu_gather tlb;
> > > > +	struct vma_merge_struct vmg = {
> > > > +		.vmi = &vmi,
> > > > +		.vma = vma,
> > > > +		.start = new_start,
> > > > +		.end = old_end,
> > > > +		.pgoff = vma->vm_pgoff,
> > > > +	};
> > > >
> > > >  	BUG_ON(new_start > new_end);
> > > >
> > > > @@ -2373,7 +2377,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > > >  	/*
> > > >  	 * cover the whole range: [new_start, old_end)
> > > >  	 */
> > > > -	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> > > > +	if (vma_expand(&vmg))
> > > >  		return -ENOMEM;
> > > >
> > > >  	/*
> > > > @@ -2406,6 +2410,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > > >  	tlb_finish_mmu(&tlb);
> > > >
> > > >  	vma_prev(&vmi);
> > > > +	vmg.end = new_end;
> > > > +
> > > >  	/* Shrink the vma to just the new range */
> > > > -	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > > > +	return vma_shrink(&vmg);
> > >
> > > The vma_shrink() doesn't seem to benefit that much from vmg conversion but I
> > > guess why not. Maybe this will further change anyway...
> > >
> >
> > No it doesn't, but it's more about being consistent with vma_expand(). We
> > maybe want to find a way to unite them possibly.
>
> No, we probably should not unite them - the shrink happens in a single
> place on setup.
>

Ack will in that case un-vmg vma_shrink().

