Return-Path: <linux-kernel+bounces-300146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746BC95DF5D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5DB281C22
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531FF45003;
	Sat, 24 Aug 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CjvZtSPY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VGFZlBS5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF553D967;
	Sat, 24 Aug 2024 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522669; cv=fail; b=rApPY5biymSdGzd9Et/WPxpHN9urmUYrsB7UeUw//kTHQuw5DUZ0MQFoZPhFLRRMmln/gY4EMMFTHs+8sh878iJtFevg28NeQ23MwTqo/T6oNduf0fh4LowQzlmth8J57P9/Ap4EP6TPaA8maw3ssg/b3RJYxoNSAxuKt7DQMCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522669; c=relaxed/simple;
	bh=XE/Aki4wyqnmVzV/FBBcSARrhZTy5FYJ+8hpGWGa8Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rWnhRH4waBRLCtbseDNBDoWTgEEbykFK68rJmaXca+VaUL1xVd85TXFndAA9CsL0KsDqYj5i0dgkkEux46IaG64Z1SxSBBpgRS94r3JnQbtp9aZ+LOqoqs0jT23jsPvok6rSL9uSoRarFW6j0Gm445AeL6h4Sd2EmC9LAgWT+ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CjvZtSPY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VGFZlBS5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47OGDLlS029227;
	Sat, 24 Aug 2024 18:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=b6m0MEm8J+k6XJH
	qN/rsgcrJ1Jdk5YcGb+HEoFQJzzM=; b=CjvZtSPYJI7b8j+npA8AvZC1BqLrH+w
	XhviXt6VHx8QjHsPnRL4wdi1fhMke5XqnkN7tLASd76KXrdIkpMu4tgejKSiiIwv
	PDt4w4synrm5Z1v/qAFh+bf9ZzZSZ5ezDlqveQ8u3znN3UECQMoRamfs/06+//Qt
	nuO1LsslRI5JZn/NBClgw7fOUw5A1ZEzvF3/norwRgwUWRhX4m1P/kGBfhpS6kQc
	qoUhuQHYVwGnEWBgyJ701ylFmV7wWL7oG/7PTfHoZMyHcAP7qM8Fi7ncvxUaX6IU
	I2OAhlrpmJsgqsBgGq6OFFhGdhCK0Beo7iLZHi37fdEtdLg7Gh2YQzg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177nw0j9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 18:04:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47OHiOnd007147;
	Sat, 24 Aug 2024 18:04:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 417m688ay6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 18:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bz3mNQ6b1KrLXNbwZnuVtSfTfwN9P+/1agU8IHJhlg5Dh3H3Q27o4zU97SzgS/TacFdYItxsbeOsBOfknhyfzkQujzSm9WkSiu1mzzr+wkl7pmy6rPL9FcFQqkR1YV2272fkM/YvEykFyFavRaNCl4APeeB6Vc+FWE/a/FEKpTQTGYT4ADLKUOylkWICJFIVwsThLNRQ3LZHYSClDHbC0dVu6PKfWvJM9u1gWILFOGcc/+9Mmq0cY2w+U6E4KJHvJFm8tiNbywSsINBkv7sH3Znw32gCXc3No4W86qCTTeKOIOLi8Hqt5BK3o5QAosc22g0s3FuGIcorad80SBM2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6m0MEm8J+k6XJHqN/rsgcrJ1Jdk5YcGb+HEoFQJzzM=;
 b=F4UZ3yCtCCkoySFxV+caQtsN9+PSGAx6kz2k/jC98ixqddHua8cBzSM2sdySdr7jmTFBArduB2qb2GSRiPpGZPuwkQgbgWYDG/PrwUyHd9rVWpSXM/yTnLsJUy+Qmk6myTU81VDo8f7qOV1bmBHvGcS7wgeQWlbu2anHWIzyAS9EZLTzGgL+ALkHvxUo0cP78NukwXqGw6rQk3MHLWo1gOS5LtQzKM1AH/XghIjo+mhSpGeN+nVe2MkRdb4PiYLCy/ou63zIMN4SYw4KnV+pIAXHc8lr7CwPJdlXsMdPFWgGGUX+gItErx9/70ZIGJP9cqDxMfEnwM//splwHp3ApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6m0MEm8J+k6XJHqN/rsgcrJ1Jdk5YcGb+HEoFQJzzM=;
 b=VGFZlBS5ck8j/eUIS2dkToCa3/WTe9slzs7gRiqCq8DiduruVs7vS8as4Fvza2CV9VFUQ08voNR4BARIYkwI0CBag/WsrdAuHcBbbqWoBCcdwmCo2Hy8zvS507XxrbnfTJSFX4qV8e4pan/K0nX0zG9x5fU10NBM6+2H0trx/P0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sat, 24 Aug
 2024 18:04:16 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Sat, 24 Aug 2024
 18:04:15 +0000
Date: Sat, 24 Aug 2024 19:04:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
Message-ID: <aba1cad3-ab23-4b42-8ce8-0ed662919c99@lucifer.local>
References: <20240823150206.565-1-justinjiang@vivo.com>
 <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
Content-Type: multipart/mixed; boundary="vpqxaifkk44w6k3q"
Content-Disposition: inline
In-Reply-To: <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
X-ClientProxiedBy: LO4P265CA0208.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: f93c240b-c2a6-4e78-4e76-08dcc4672a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FVTNSRvTR8Y61X+PDtAUHZh6M0XYXTnOTcDLjI2aF55s+wCUOXs/MzOaATM5?=
 =?us-ascii?Q?ll3EcvlDPvkh4d0TRS348zsS9Nuys1TzgqIoWKLEQ7YwfCwvUtabqif7es05?=
 =?us-ascii?Q?js4P/kxGSx3G5LaN6WMLmux0zXf4CbuHE1Cv91UAVHfiywmDLWlj0NDLZGCN?=
 =?us-ascii?Q?4SAH6Dz6ceSwAQesOQh0/acTFnWJDU6n9xW9obVuCuZGN/DPEP9e+CRWElRn?=
 =?us-ascii?Q?8dUegPePAhMm3RbRJ6GG2c/8qPR64f01DBevff5uzyf2nlWuDlC5/0uwn4qU?=
 =?us-ascii?Q?MGJSOoY6ZubmYt0zeVBzc42zYLFxrYWzLX5NhTVhd4iJA8yWJY1dXWHD/SWp?=
 =?us-ascii?Q?lzk1Nzfe0rkaJuIYe5RyKuJTKN+FSCH9M7xnm/U/SWYY4qXZeuwiePb3td89?=
 =?us-ascii?Q?UMb7Z5CDGnsa8u2izup49Ug7ku8JGWPIXyKIuKYpydT60kdv4f/VgX/GHp+R?=
 =?us-ascii?Q?N8C8dEpoYwGxhSS06ls7CDIyPpu52JP5vzpaqcY+PZVQ8d6H9Z6xy64kFWji?=
 =?us-ascii?Q?RmFv9qCzEf3lb7X56cNgq5IWciI+zPHThk2VOLJ9eFdxUBQoxS3iq2OCIFJV?=
 =?us-ascii?Q?q2xiYeA6ys4MtV5XIvP5PmixW7OGoHvL2kYosvudNgN48FHj+lKR6BXLCCvQ?=
 =?us-ascii?Q?MvQ/5yeQLnolmco07DN9Sfp87C92Fz5C1zXzp8ITL33KPT9kwAt6ZWGHIUpU?=
 =?us-ascii?Q?fL9vX1158BBYPa6tXdSk82x6SqueIkbTM76KjCoiXQr0oxAKCDktvFNweTUz?=
 =?us-ascii?Q?Rr0iPvBidkadyKwV7A4u0Oo0Cou9d/1kFOR8/VBEK/y00dRWurO+ak0P6vkP?=
 =?us-ascii?Q?SV8p5K9V3MOzERTkMrF1Ui9ysgl3ZU2UNQ0d9AVXO8jUSR+nf+sq5Sj+/VM+?=
 =?us-ascii?Q?E+FBDj9J5SFofN9R2jxLWoPWraOL6cr7JrUXY+K5SkdWMsSFWAmR5VR506eH?=
 =?us-ascii?Q?P6ahckAkvEjr8IKwPZFRdMQX3NGcMiR+ZSkiUVpW8dL3MvBHiwzJFwsDLuwF?=
 =?us-ascii?Q?r6xKoy07mnjCJWhloZ6RxpVy4fwgapAJdsE3zqZ0WAVT8m0YEpPm9RgrLTPu?=
 =?us-ascii?Q?tioZkEqRb5Go9VGFT1zaszOBD0HckXEBnzu2FNsUV4pT5fZwtQOXNbOc5nmw?=
 =?us-ascii?Q?nWR/HTSUR5P4bAzgvyIZW3bLT4378u6p4+Ec5H3ShjseO8bOzbUQQjHAa2Z5?=
 =?us-ascii?Q?dDHL5ddE8QNuPvMT9navUGF9U8WpcsAQpqYBENaJCT7N6camUXt4ME8x74Uv?=
 =?us-ascii?Q?VWYIeI1eQ4SAcIbLsqUHbyKGM5mts1tJVEQSx2las29XdhFdGbApiQ7YyC9o?=
 =?us-ascii?Q?HM5aabjZhRyc+qAKEV6mS98+fmXFaJxY71gXvPkIMLUPug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qkN83OLzzDlcusCHaNHCNVEe3jKpSRCTJS+bo2fiVOhxAbCXe8cgQWBaWDSO?=
 =?us-ascii?Q?sMLvWBQiWU03mSlddTLNaCOt6of8HXOmbBF2DX5eBLubd+5RXEGEVfiuhI1r?=
 =?us-ascii?Q?d6jy3Oyl9dSklFmY/oLx5EYoB/pQ/Ose90BDfXrIUGekj6asLOX7jiywBeKX?=
 =?us-ascii?Q?8p+EhukUFRyyHoBjwhd84uiD5qeWIdm2+3fx3g+9gvIgYVsyTaZFi/4yrox5?=
 =?us-ascii?Q?oomZgUPtWyR0mjQpZJDVRfy7ATtkkWl2TZIN7fJej3N6RjA1qJacYDS7j8/B?=
 =?us-ascii?Q?E/dZmyzRkO8ms+n+JzOLCtzWltSn8OOSXPeQCMmxilkKl6zu8DoMIOW40Sp4?=
 =?us-ascii?Q?Fh44rpl4ANI8ypr4A7funnH3EVUGjMug54200E2ceU6WEk9haS8fbuKF+mKz?=
 =?us-ascii?Q?smiTrEIJRZowiXWvjs2+ufh5kvLR2PYYzUieUFKi2+NlpckpE0/jGo96ngh/?=
 =?us-ascii?Q?dVwdUbAx0YHaPISQEmZ3gc+EsQ8vd50hSsHG1sdvonJqgWW8wc0xD8fVKhT2?=
 =?us-ascii?Q?WzxWkJT+QS+a0P6lsI+l+fe1rqQ78XZp9e20tJFSYmZBVE8rTcvja5mCyQ2b?=
 =?us-ascii?Q?Ir/axGqV3ONLmsww9tlLj9Q6qAyfCRh3pPm549U1oHPpzqKMkLUCdsbUG4cV?=
 =?us-ascii?Q?Tz0dqI9bPtR7NA0BFB8oDV1eO6rwn/p5cX/V25G5JC19Io13jSuCmWCov0D1?=
 =?us-ascii?Q?/FKcZsyPjgRXJea42cB0p0iZZdirGtQ2PZjl+AU0c2pu75N9cTLKROpn3phU?=
 =?us-ascii?Q?ttfp+dMmd/2SU2I7oSK2ufMYHHDcxugXiZdhRD+7wgWR1NHDKPxDrHKpQaPx?=
 =?us-ascii?Q?akfoKPsn35w8m9ua/TD/TlWwNTZvQvlZMeyESrKVb5P2h9G27Hfr5hAVEAjw?=
 =?us-ascii?Q?9+9O4/MhyGRViznNjTSHILHC7Fm/Fi7I1qlUD7U7bXvzQ+AHj+3B/2QljvxZ?=
 =?us-ascii?Q?t/T9iMSQELvsiGMmjh076k33xZr1v7etVEoImlZH1/TAMBg4gqjJhO1/zCvX?=
 =?us-ascii?Q?DJo628JKhtUrkomnGmWN37kiufPEIrLIONZM4Y7NA2eEPQ0Ii0H8ZP5SAcu0?=
 =?us-ascii?Q?WTY2WgCfk+EHMHOdMCmyMJOtBERiv8K2q4E2GGJPjSvb6TL87ecs4Cr4AiuS?=
 =?us-ascii?Q?MTn0oAaShqE/hpR3huccVlBmGpiEke7ZvsxzE8w9qgSUMu8YuI8YYZhX9cGm?=
 =?us-ascii?Q?qsqskMH4afyX/FMYknS3MPEY3oZm5oVv+ymA9ZlfF1kCiM1SgRdXAsgTiKZk?=
 =?us-ascii?Q?oKILQq4MVQzW+nUaCDFBEXjUDiJB0GHmgWrfgoGtnh12pkvwtMXbDriUu796?=
 =?us-ascii?Q?RtQnJu3u/tYDpzYKeraESxWpKAynOdHeT9BIJCljYEHAdwmk4JwN+fgg/0pX?=
 =?us-ascii?Q?bMLlF/BHyugVVSlqqfxT2BJBc+JizwU7tas6kMPlKoaxCRs3hVBaNDEc2KfM?=
 =?us-ascii?Q?snCjFhQUKwz5CJFDmna7bz2OSiVKrfLPV/6CF6zwmHTo5VpXdmpOwzJmAwjG?=
 =?us-ascii?Q?FlVSqjbmzJnbZ0qvdHXqvd2WO7gXsd2SAUxj6ottFE5gCeBQD8f5BaLJiY9i?=
 =?us-ascii?Q?zZnqFZNEpafgOT/2mOQ/OedPLvBfTz8GspUYUyK2jlTvY5bn0FzqgQnU3s1Q?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T/9P5eGSrtHochEKwZ3pU4yJU4FRhPwKp3AFSYaOiEFriFNEkcsFXbkHtibwnuKS6EeU7KcdgA3QFvHPFaij/ZrGzLeLMmILwYTLPcFKoOLGQk/SClKIV7P1Kdr63EC7BgwoVx0sVcLI2E4yqqP/FVFNqD7NmvVj95KLEwjewRYm+zl4DcQpeihpuq2pTM0oeJEIfORcvhVKM7zAmA+vKEdadXbmUQ8OizfCmaLwevqnjUmFA4ztCk2fM1/Ac1qFr3sCbu8Bt5qo/3uH4PuJpvMKOg0RU3GeFhv9KH/CGjfeHrUMqfzeFXkLyukkxNHYWa2lSeqdub1UMVOudOf6rg4lkF2IXzWg6/XmWK7GWk7N2Ri6kEOH3dg5eUBQBP4Z1CgveyVOiPrF8QilYcrfSU9f6VQwqaUiP6rKrq8eo/syuB7R3ty/yncr31o1wgcrtgi4+L9V9RGxxcC92oQJY6p6wNuW0MNV/wK1IvLliTYUR3TIAoBWZE2onNaBWPjo/2uhY95Oz70Ys5oO44XKnrpM1FjC1+w4JtChjRoGZrwtIL/ah3btLvpqEcFVEob5uWn0R8zhXTVuYH3i+T0WJLPS1MTvadKJV/k+F/ucEp8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93c240b-c2a6-4e78-4e76-08dcc4672a38
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 18:04:15.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5z9Hx71qZz4o8pWNXYbO2DJKTZWTYgSULmdy7UPEmnII2LxmBwI01MtTykF6b5nb7au/0DZF+gvFpv4eZgeca/RC+GdhLR7vQ8xul4OoIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=838
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408240117
X-Proofpoint-GUID: bYsoH0L1Qqksf7km1210te7gWjrjnRo3
X-Proofpoint-ORIG-GUID: bYsoH0L1Qqksf7km1210te7gWjrjnRo3

--vpqxaifkk44w6k3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 24, 2024 at 05:26:46PM GMT, Lorenzo Stoakes wrote:
> On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
> > After CoWed by do_wp_page, the vma established a new mapping relationship
> > with the CoWed folio instead of the non-CoWed folio. However, regarding
> > the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
> > not same, the avc binding relationship between them will no longer be
> > needed, so it is issue for the avc binding relationship still existing
> > between them.
> >
> > This patch will remove the avc binding relationship between vma and the
> > non-CoWed folio's anon_vma, which each has their own independent
> > anon_vma. It can also alleviates rmap overhead simultaneously.
> >
> > Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>
>
> NACK (until fixed). This is broken (see below).
>

[snip]

I enclose a patch that fixes the issue, but leaves a LOT still
broken/resolved/todo including locking of the reparented anon_vma (that'll
really need re-rooting too).

I still seriously doubt the value of this patch given the complexity risks,
but since I got bored and looked into this it's useful to examine something
that works, and which might be helpful to you in testing.

--vpqxaifkk44w6k3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mm-fixup-orphan-avc-cleanup-logic.patch"

From 973ce5f0aea78196088cd527905cc0fad40edb29 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Sat, 24 Aug 2024 18:55:31 +0100
Subject: [RFC PATCH] mm: fixup orphan avc cleanup logic

Existing logic failed to reparent the anon_vma whose avc was removed which
resulted in assertion failures.

This patch corrects this, fixes up some comments, and does some other
cleanups.

We also do not do anything relating to anon_vma->parent manipulation if no
orphaned AVC is found.

I still feel this logic is highly dubious, but this does fix the issue with
anon_vma->num_children accounting.

This doesn't correctly handle locking of the reparented anon_vma.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/rmap.h |   2 +-
 mm/memory.c          |   2 +-
 mm/rmap.c            | 101 ++++++++++++++++++++++++++++---------------
 3 files changed, 68 insertions(+), 37 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 8607d28a3146..f1a835f54064 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -257,7 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
-void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
+void cleanup_orphan_avc(struct folio *, struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
diff --git a/mm/memory.c b/mm/memory.c
index 4c89cb1cb73e..989b078dd860 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3435,7 +3435,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * between vma and the old_folio's anon_vma is removed,
 			 * avoiding rmap redundant overhead.
 			 */
-			folio_remove_anon_avc(old_folio, vma);
+			cleanup_orphan_avc(old_folio, vma);
 		}
 
 		/* Free the old page.. */
diff --git a/mm/rmap.c b/mm/rmap.c
index 56fc16fcf2a9..3ac264962917 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1523,56 +1523,87 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 }
 
 /**
- * folio_remove_anon_avc - remove the avc binding relationship between
- * folio and vma with different anon_vmas.
- * @folio:	The folio with anon_vma to remove the binded avc from
- * @vma:	The vm area to remove the binded avc with folio's anon_vma
+ * cleanup_orphan_avc - remove the avc binding relationship between a parent
+ * folio and child vma with different anon_vmas which, due to an operation such
+ * as CoW'ing a folio, is no longer meaningful.
  *
- * The caller is currently used for CoWed scene.
+ * (insert ASCII diagrams and explanation here...)
+ *
+ * @old_folio:  The folio which contains the parent anon_vma which has an unneeded
+ *              avc binding.
+ * @new_vma:	The VMA which is unnecessarily bound to folio.
  */
-void folio_remove_anon_avc(struct folio *folio,
-		struct vm_area_struct *vma)
+void cleanup_orphan_avc(struct folio *old_folio, struct vm_area_struct *new_vma)
 {
-	struct anon_vma *anon_vma = folio_anon_vma(folio);
+	struct anon_vma *parent_anon_vma = folio_anon_vma(old_folio);
+	struct anon_vma *child_anon_vma = new_vma->anon_vma;
 	pgoff_t pgoff_start, pgoff_end;
 	struct anon_vma_chain *avc;
+	bool removed = false;
 
 	/*
-	 * Ensure that the vma's anon_vma and the folio's
-	 * anon_vma exist and are not same.
+	 * If this folio were not anonymous, folio_anon_vma() would have
+	 * returned NULL. Equally, if the parent and child anon_vma objects are
+	 * the same, then we have nothing to do here.
 	 */
-	if (!folio_test_anon(folio) || unlikely(!anon_vma) ||
-	    anon_vma == vma->anon_vma)
+	if (!parent_anon_vma || parent_anon_vma == child_anon_vma)
 		return;
 
-	pgoff_start = folio_pgoff(folio);
-	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
+	pgoff_start = folio_pgoff(old_folio);
+	pgoff_end = pgoff_start + folio_nr_pages(old_folio) - 1;
 
-	if (!anon_vma_trylock_write(anon_vma))
+	/* This is an optimistic attempt. */
+	if (!anon_vma_trylock_write(parent_anon_vma))
 		return;
 
-	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
-			pgoff_start, pgoff_end) {
-		/*
-		 * Find the avc associated with vma from the folio's
-		 * anon_vma and remove it.
-		 */
-		if (avc->vma == vma) {
-			anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
-			/*
-			 * When removing the avc with anon_vma that is
-			 * different from the parent anon_vma from parent
-			 * anon_vma->rb_root, the parent num_children
-			 * count value is needed to reduce one.
-			 */
-			anon_vma->num_children--;
+	/*
+	 * Iterate through all AVC's tied to the old folio, looking for the
+	 * redundant one pointing at the new VMA.
+	 */
+	anon_vma_interval_tree_foreach(avc, &parent_anon_vma->rb_root,
+				       pgoff_start, pgoff_end) {
+		if (avc->vma != new_vma)
+			continue;
 
-			list_del(&avc->same_vma);
-			anon_vma_chain_free(avc);
-			break;
-		}
+		/* Remove the unneeded avc. */
+		anon_vma_interval_tree_remove(avc, &parent_anon_vma->rb_root);
+		list_del(&avc->same_vma);
+		anon_vma_chain_free(avc);
+
+		removed = true;
+		break;
 	}
-	anon_vma_unlock_write(anon_vma);
+
+	if (!removed)
+		goto unlock;
+
+	/*
+	 * Removing an avc implies that the associated avc MAY no longer need
+	 * to point to its parent, and we need to reparent it.
+	 */
+
+	/*
+	 * If somehow we aren't already the child of the parent anon_vma, we
+	 * have nothing to do here.
+	 */
+	if (child_anon_vma->parent != parent_anon_vma)
+		goto unlock;
+
+	/* OK, we abandon our parent, and reparent to ourselves. */
+
+	parent_anon_vma->num_children--;
+
+	child_anon_vma->parent = child_anon_vma;
+	child_anon_vma->num_children++;
+
+	/*
+	 * Here we should probably reset the anon_vma->root, as per
+	 * anon_vma_ctor() but this feels icky and horrible. Bit weird to share
+	 * a lock with the old parent's root.
+	 */
+
+unlock:
+	anon_vma_unlock_write(parent_anon_vma);
 }
 
 static __always_inline void __folio_remove_rmap(struct folio *folio,
-- 
2.46.0


--vpqxaifkk44w6k3q--

