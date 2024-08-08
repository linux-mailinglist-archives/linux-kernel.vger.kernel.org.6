Return-Path: <linux-kernel+bounces-279150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C461A94B995
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582961F2209A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07DE1465BE;
	Thu,  8 Aug 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TC2E84YF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EQWIBKpH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727652575F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108961; cv=fail; b=eICAOBTS/TD8krLJqnFrwnbnHqfKrNviYCxAfe8hK7wELU6siTI7wCkllJ0YESo2P66FiovJG0kY5BViguz+HfuMahnqW0A6jSyvuvjFdoQwoZnIy2X2UM0REtF3xLALho/8J+tFQIv6x93tgGG3Hp1kqWVWbBzajWQDWLtCAUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108961; c=relaxed/simple;
	bh=cf6GVuEtEj94KcEkKCVsPWOk7YdiZpZ8CsRsSrifWLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cVLyYPTIKjt1rDB9AI/MOwTOh/hqLg4G+sK53RVbCO778mvYCwQM7DtXkSrmnDHMHnvieMSFwP3MiUzvPEIIhtKnfg7zdbIDP/8DapUVyogzeBJSLGgo8qjJPKDdDMfZg2PEA40mMVoxdpEAMtsGVyV4kUS2+woO5FQIfoCkBks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TC2E84YF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EQWIBKpH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477L3KgB031092;
	Thu, 8 Aug 2024 09:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=44bnE8vFUJwsn6T
	LQ26IoqtdD/RZK/ln0BrJ9rjgJlg=; b=TC2E84YFT+c8Az6RudAopNrgYtx+R0t
	+GdCt/9Juj0io16FiqU+XFqAbXeWC1QLvua71IuzNjEtDIvfILaeamJFU7g4a9H5
	7JzFqmnFaeXpsLL52LmlfV7a1NtJyKZMrr5nGV0Yh/V0XpBn1HMQSr5IKorbNaT6
	16QSnZNYgxUnVD/H1cKwqiwjwo0cONjlelzYiT7WD/B0pIbfDkp7b4x0U9ZpUTFR
	vrxfHsT9lr68PCSy0+RDLqEnBjqZ7X0kSbXyHWv9HPdqPj9sYQulH/5uVAikQ+J1
	z4+xvaYKZEhXwUXTYeyd099NjqKKrQNJLFeeZScI7bGOhYPavm+Qcdg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfasfhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 09:22:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4788VnSn023767;
	Thu, 8 Aug 2024 09:22:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0h511w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 09:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqmLJtobmcdFZQVqlKQ4Frq6s1KaeCTqV6NfZ17iIxL1iKicmkBOHMPWLlxF7kG/X1gpWcmn33i0nizr26pPEPsUGzpqNNyY0hV6r9gPaj0bmucpegkAb+gYUVDPfg4R3V4qjnCk2Lr3kC44GotsHS+QWRtqb8CSQvb57H1GJ7GJjDgEtUW1e/WAj4rlTNif9EVPS7ScUfZtY0jml+/eA5FDgMTC4Nn9jfbQB5X4cES4mIwyiLEgptKK8DfMx1NihBC7NIXUriX/E4r7lkYEd2GjBqGrCsPnUXmXApL3zkfbcVoroNH0GTI8B5Jq4zJz1FShJc0BE/U9Iwx2zReYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44bnE8vFUJwsn6TLQ26IoqtdD/RZK/ln0BrJ9rjgJlg=;
 b=w3N+rhuf1Adk1Z2eHwI7kasQZGuMbBsZjfkatrZMc/4bd6gSdJ0B97DEQS62eijdrXxttnrRiakl28x2H1Vp2/3hGyINYF0/JxIo6QWXJ50wvSGL4AzOXTchpqLUoeMYfxGHRnvpUkT5bEEtjwa9MgDAWkTzd9kTykdzICv6x3v/jVpW1BwAh78p4hICErH8dQ9Cu9QzQfo1uci2zvHNhztXuHWPxe/GCFt0sK3pd1yd5jPvUVLxWt5dSGb0AXA12kUVz2o0zVGez0KCYLzgfSIx/kcgGZ8Q2ceGJ0Hjzk/j1Vtn9hnpx79zubtfoxOjbjWcTH/AR9fwIPl2OjFzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44bnE8vFUJwsn6TLQ26IoqtdD/RZK/ln0BrJ9rjgJlg=;
 b=EQWIBKpH4r9Qv5MC8fAnDF9oOSay0kSu1mahuAqm+MmG7AcjhhGkmXJzf8waTm6NwDWNcBNxjT6szvwOOCUN3tYs+p6kWgnAhEp/B6d/u0XMfG+4ljU9hTnUfSZcXJhfCSHUIoEATmUiDJt+VXcJrgDsh3qjGTli3zLMpe5jtnA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Thu, 8 Aug
 2024 09:22:26 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 09:22:26 +0000
Date: Thu, 8 Aug 2024 10:22:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] lib/stackdepot: Double DEPOT_POOLS_CAP if KASAN is
 enabled
Message-ID: <5a40a5fe-45ab-4c39-a849-2ebb0c2652ba@lucifer.local>
References: <20240808023215.1160684-1-longman@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808023215.1160684-1-longman@redhat.com>
X-ClientProxiedBy: LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aee399f-b11f-4393-7819-08dcb78b9e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrFasumsqDYu+XL5M0KYKyFln2mGurrOp7WSCRenid+Y1elbmEqzO6+GTdxv?=
 =?us-ascii?Q?zYPduR7GPWnzHFHF17wJP4ZehR3eOgIyo4E2rESsaC5tUGItGoxoyMwlmnzZ?=
 =?us-ascii?Q?xVUVfH1pIjLWX1FlfzrsqL0TKGYaMhYAT8e9hSuliK5PG/4DKKi06Ip7HZKi?=
 =?us-ascii?Q?CwcVH8884781vA2+NdrsqzYApcLea6+l1HskC0ObMSrRA4X2Uz54WYMqYA9B?=
 =?us-ascii?Q?4s+jMB7Etz8Ju5KtMZL7nkuC5ZJhFfweYQ4KKhK94h8YTCZL9+NFwrFI8XB1?=
 =?us-ascii?Q?GCvid9aU/aLK/9zo89o5lEBB6m19Fg5Zz/6bd9cLTlSlsDEJTdxGTY7V7bgq?=
 =?us-ascii?Q?hPrdpSOC8fPgJCXk0LWo8ZOQ9xXz5865kSCC4NLqiuIj2w3aWuoH0RibxLC2?=
 =?us-ascii?Q?Q46/TpRhRfp4/le+bNcehMvp+SHbVGl5BdFHk6IEBBmfIDDEkUwBKBXAAfr0?=
 =?us-ascii?Q?mU1wvM8K8GfW6PC8+7g6rndqRrCOgqKKLvy+HlhuZUoU9HTgOhL/lY5w1875?=
 =?us-ascii?Q?CAPncDzlLSCzr+1pVnAx1rLZ5fJhkZsnaucnxiUoAY1V1wQw2iudcLATtgGJ?=
 =?us-ascii?Q?/SJ8o/HOfZl96NRA4V0lqeWY82holPlRc2xHlxJ0XiC8erWSaug7OCSFaHho?=
 =?us-ascii?Q?/q3DfvrpqnHZhl41ek97GEou8KCPMb2RTlDFsxw8n0uvgSw+A/P6cby8f0/i?=
 =?us-ascii?Q?fNnQ0qmhqEDkM/dO/n76mT0dEBRsta/mFqSHEoLB7xRffoj4uRln+Kn5D/l6?=
 =?us-ascii?Q?wHM9YG1xQtAXWLHYJeky/i7vrOSHD8vAL64TpMFU8VRGPcBHo0XLHY6Jdz8x?=
 =?us-ascii?Q?2wNNCQeeIMMr/QWme1UKTjsaWHaHsGrvHLY/NtRBHz4YSd8AmSIYItGAg5RY?=
 =?us-ascii?Q?wc37vzWekZAL4rHVb7KzraLY/wf/WWnxrfQ3mHvRHkpKaon2VjRRsDx4Uo5b?=
 =?us-ascii?Q?HwePDuAoi0MvGbdYMiQeahlTgS26FF5UWiwieouzVs9HTfeuc9agP8z7AaZY?=
 =?us-ascii?Q?GGyYvK875WEnXfR554VsJ3eUQVDFFps7J9BH7AAXyr8fSMphvWaJkm74i7MG?=
 =?us-ascii?Q?M9FYmFlHT7LEuhs9G1Rp7EKa+WfAVWgzoWY9XtMqbmKo4Rje4tWDYivqsHZW?=
 =?us-ascii?Q?oph7CrhsS5H9mBGeWFwCP12H/y+DMrlkEQRG0Q2k9HHWyPr24/iVJu0rEP73?=
 =?us-ascii?Q?RkpZz3BbleCqRKNePcjckrBPLicLO1ULiFUpdGIMCMqOahjj8Mh72iMIDcyF?=
 =?us-ascii?Q?7iMDhcTsoVURNvtL5xRtSTNmso6rzOaUrTpcXpLQR8FPZSd2DT38JcSRfUtS?=
 =?us-ascii?Q?KmMzf102sd1ajU0wBYa/pEPw8SwkXGEWPztr58WAlACIoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZgeWLyCXlaqsjvrb4/spe8mQi1cgB1h9/AvvNtRhEQg1uJ2G8n8DnzmyH+km?=
 =?us-ascii?Q?HEL2TWpMDq2K8ooPivEDFLYe/d7bJQCc6HoBW9VR40FV3R4YCaqQE0qP8L3I?=
 =?us-ascii?Q?F2Jn0MVnRr+gb1sn+xeRtKTSO60/236aNyTR+mQchdZ6Ya3zKBgmudUKxPy8?=
 =?us-ascii?Q?N+MfAaWH5sBCnZh6Sgy6ZQVjHN5zMSfzrtDHt9KtA0Pyf+1vNTRz8hznItc+?=
 =?us-ascii?Q?jVctcb6yuPtAwPMu9/DKg3NufS8tYaFqUwkUNXh9yi06IUiptVFcPsKM5RvK?=
 =?us-ascii?Q?cImkLJzMrv0BQ2yz3oCndkksagrZMD4+CleWcqXvZlu24+33X4jR5k7dQiN6?=
 =?us-ascii?Q?5PTtSH2iQxA9JmdqrS3sx3B8sPOKvLo97lGkZ5cxmc06h2PWE4lg50JzTJpH?=
 =?us-ascii?Q?RMhGB3pldmeLEPPlU0R9EUylSUVHy6JfNjpdNptFZ2+jSrcMw2tZO6XxNODs?=
 =?us-ascii?Q?BSO1oOYbfDN3k5taqWj2cMLfTVWbbRKatzwIyKTdtYQw4gvTF7kOqRvInv4F?=
 =?us-ascii?Q?DkC4OcH8oa88WWrXdjsPWZTqZaWgsmme0XyNPj+UFN+XB9Hdk651Iis7GB01?=
 =?us-ascii?Q?QJAumHX17ONU8NONb38LwvIJktHS+lQXVWdBhIKCUSEDwb8hLv9/bykN4f0F?=
 =?us-ascii?Q?FvTLK79HaEzMu08SZ6WYsT4fErx/zX/eY+UtlZJl6MIl6wU74Zmn96DzjuLt?=
 =?us-ascii?Q?en1jy2ulyEz1LuvFMQwYYRB2VyefHJoNFHKWdb2iK10MHPI9j1Xh72kIr5rS?=
 =?us-ascii?Q?Ayawss1ueH+EvQx0nz23Tsc24Jybd5OW5y3pmUvzt0ZKp+4Hkgh2yVIDB9QR?=
 =?us-ascii?Q?XDKqj64MQ1F6dTCVH6O2oPcZuKNCdY7iRx4lnc9nwcBuswmEKEdb20cCv6Eb?=
 =?us-ascii?Q?e+pfkSPVB+kk2eHljnOggmkTqGPC7E5jG2Ibu04n7vCV19K7HiSo0qHRslp1?=
 =?us-ascii?Q?zgeJpsO80hgFkimAxaO+aWrQOKwgGEfpw0HC5WhZvwzaRK5J09iCTtgzxNG/?=
 =?us-ascii?Q?Tf8ckC+IWorh7zVX1uOKk2Q7pwJm7CJImwYIJB+eRTzoIXPM41Y6Z96NoOY9?=
 =?us-ascii?Q?sOUuQ2/sJLHnI6nZ7qKtM2crXe0K4F7vZtcs3UiFYWxjZ403/2VAxVEYMHO7?=
 =?us-ascii?Q?gbkkCw8KqsVbk/VxTVe9BzN76JGRwGVji3Ehgl1vjnIFC2i5y39serLqmeTN?=
 =?us-ascii?Q?lBpRoktaLIgmqbZh0XPTO2pAbeoXtD2tWMSBWGFGP/2W9KMeRHy/nnpIwg8q?=
 =?us-ascii?Q?T1919C0HodVP3WcYDRJPeqLgsweFKZMLnHcTFhC4VzZ5JkbcRj2XHppI5owH?=
 =?us-ascii?Q?gueHESy2TPI0/FBW9Xab6hGvAvFE6lFmv9FFboa+Ezmc2jIZPB9wHg9uxwaM?=
 =?us-ascii?Q?CBfIUa7U6JJGwNQJf3PLHlK8tTIUjXuJZwZG+UyDinBS1lbghqJoV9C+D2Y3?=
 =?us-ascii?Q?VyJV1/yEV/uMl8yG2+FDEzkXWmy73AGGEF/TPj+UEQCPcK7UlFDCdYpS0hUh?=
 =?us-ascii?Q?YHbD6LS75VcGt8afNZODK0pNWXoKkUiQUHYfvp/4Cl3aj+/DMC1w9eWMm6tT?=
 =?us-ascii?Q?EoXPPgulPgwgX7bBEnojWiIWGVqpMIZEWhKykvgVxkFRi0vYPY9fPgDkjmYI?=
 =?us-ascii?Q?NVk04bTdKmHyvVizaip8LDYRcFmal0k8JlbA3OwTUo5mytqypaTWsCmPpJwu?=
 =?us-ascii?Q?lW8Aig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1QZcz2r7gaog4I2CmblitNYgCDa9v59ZTSDn/9MgnD69wlGvHRFvtiszCFvIAzxelvJM2uPWaPDgtFBquVhbIWXaGy6N1yV08/bG1p7aHTN0YvGDnrBGLjTGrM5tXub3JUBjugKI73kgb9BV33s47kCIxhRsomN5DN4ED4AH5rAOV6NveuDwK1qAvBsNKedxhi981FGjCODtFPiA6oR0/q2qAIrRDKqRDPsITcOri//kTEAlxQF69VXvAr2BaDZfao0hXnyBxkBdP8rACVy4k4JVTec+xkD8PiUE9z4H7xapMr71ZYq73osOsdBFHbL/CyuxcCUwHQlCcN8H7x28enkXbiOqBpFu1k/GOSsvF6aX63998tcHaWen7qTmPDCSo8jEb/c3cHOYvuZUjOiAp7zl2SbHzGYa77TXkfsy6FD8881sL0DXmnxoqNHcXmL+WCHyWUpMDYLO5FuYJ8ceXC2SCuQ7iGV0Jmexv71mTnoZ5WLRm9HFEuDsl9PE+qYYiGdIDH/waYKAdUxfZKGkcZ2TU6K3VWER1KnuoP+CIzDICSakrF6GJk4k9B0eKQfjS49PRDhlxL4usEij9I9nPqyCYjGxVGInXzy/mUSddvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aee399f-b11f-4393-7819-08dcb78b9e5e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 09:22:26.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOJXhohBWmk5wXuj4JY04jRXxaYvHrzLl9zNHN+COcTxF5IXvkiozhgF5oPoTLicrLCOV+1VkazRfTJdsDjdfEfhi6xzZXfB05G3/dm9lrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_07,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080067
X-Proofpoint-GUID: l8rAdMTJmyXcFZ43eM7XMC4IjzFhrqx4
X-Proofpoint-ORIG-GUID: l8rAdMTJmyXcFZ43eM7XMC4IjzFhrqx4

On Wed, Aug 07, 2024 at 10:32:15PM GMT, Waiman Long wrote:
> As said in commit 02754e0a484a ("lib/stackdepot.c: bump stackdepot
> capacity from 16MB to 128MB"), KASAN uses stackdepot to memorize stacks
> for all kmalloc/kfree calls. So stackdepot capacity was increased 8
> times to accommodate KASAN usage even thought it was claimed 4X should
> be enough at that time.
>
> With commit fc60e0caa94d ("lib/stackdepot: use fixed-sized slots
> for stack records"), all stackdepot records uses a fixed size with
> CONFIG_STACKDEPOT_MAX_FRAMES (default=64) entries. This is merged to
> support evictable KASAN stack records. Commit 31639fd6cebd ("stackdepot:
> use variable size records for non-evictable entries") re-enabled
> the use of variable size records for non-KASAN use cases, but KASAN
> (generic mode) still uses the large fixed size stack records.
>
> With the default CONFIG_STACKDEPOT_MAX_FRAMES of 64, KASAN use of
> stackdepot space had been more than double than before. Assuming an
> average stack frame size of 16, a KASAN stack record is almost 4X the
> size of a non-KASAN one.
>
> When a wide variety of workloads are run on a debug kernel with KASAN
> enabled, the following warning may sometimes be printed.
>
>  [ 6818.650674] Stack depot reached limit capacity
>  [ 6818.650730] WARNING: CPU: 1 PID: 272741 at lib/stackdepot.c:252 depot_alloc_stack+0x39e/0x3d0
>    :
>  [ 6818.650907] Call Trace:
>  [ 6818.650909]  [<00047dd453d84b92>] depot_alloc_stack+0x3a2/0x3d0
>  [ 6818.650916]  [<00047dd453d85254>] stack_depot_save_flags+0x4f4/0x5c0
>  [ 6818.650920]  [<00047dd4535872c6>] kasan_save_stack+0x56/0x70
>  [ 6818.650924]  [<00047dd453587328>] kasan_save_track+0x28/0x40
>  [ 6818.650927]  [<00047dd45358a27a>] kasan_save_free_info+0x4a/0x70
>  [ 6818.650930]  [<00047dd45358766a>] __kasan_slab_free+0x12a/0x1d0
>  [ 6818.650933]  [<00047dd45350deb4>] kmem_cache_free+0x1b4/0x580
>  [ 6818.650938]  [<00047dd452c520da>] __put_task_struct+0x24a/0x320
>  [ 6818.650945]  [<00047dd452c6aee4>] delayed_put_task_struct+0x294/0x350
>  [ 6818.650949]  [<00047dd452e9066a>] rcu_do_batch+0x6ea/0x2090
>  [ 6818.650953]  [<00047dd452ea60f4>] rcu_core+0x474/0xa90
>  [ 6818.650956]  [<00047dd452c780c0>] handle_softirqs+0x3c0/0xf90
>  [ 6818.650960]  [<00047dd452c76fbe>] __irq_exit_rcu+0x35e/0x460
>  [ 6818.650963]  [<00047dd452c79992>] irq_exit_rcu+0x22/0xb0
>  [ 6818.650966]  [<00047dd454bd8128>] do_ext_irq+0xd8/0x120
>  [ 6818.650972]  [<00047dd454c0ddd0>] ext_int_handler+0xb8/0xe8
>  [ 6818.650979]  [<00047dd453589cf6>] kasan_check_range+0x236/0x2f0
>  [ 6818.650982]  [<00047dd453378cf0>] filemap_get_pages+0x190/0xaa0
>  [ 6818.650986]  [<00047dd453379940>] filemap_read+0x340/0xa70
>  [ 6818.650989]  [<00047dd3d325d226>] xfs_file_buffered_read+0x2c6/0x400 [xfs]
>  [ 6818.651431]  [<00047dd3d325dfe2>] xfs_file_read_iter+0x2c2/0x550 [xfs]
>  [ 6818.651663]  [<00047dd45364710c>] vfs_read+0x64c/0x8c0
>  [ 6818.651669]  [<00047dd453648ed8>] ksys_read+0x118/0x200
>  [ 6818.651672]  [<00047dd452b6cf5a>] do_syscall+0x27a/0x380
>  [ 6818.651676]  [<00047dd454bd7e74>] __do_syscall+0xf4/0x1a0
>  [ 6818.651680]  [<00047dd454c0db58>] system_call+0x70/0x98
>
> With all the recent changes in stackdepot to support new KASAN features,
> it is obvious that the current DEPOT_POOLS_CAP of 8192 may not be
> enough when KASAN is enabled. Fix this stackdepot capability issue
> by doubling DEPOT_POOLS_CAP if KASAN is enabled. With 4k pages, the
> maximum stackdepot capacity is doubled to 256 MB with KASAN enabled.
>
> Also use the MIN() macro for defining DEPOT_MAX_POOLS to clarify the
> intention.
>
> Fixes: fc60e0caa94d ("lib/stackdepot: use fixed-sized slots for stack records")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  lib/stackdepot.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 5ed34cc963fc..beeb70b57710 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -36,11 +36,12 @@
>  #include <linux/memblock.h>
>  #include <linux/kasan-enabled.h>
>
> -#define DEPOT_POOLS_CAP 8192
> +/* KASAN is a big user of stackdepot, double the cap if KASAN is enabled */
> +#define DEPOT_POOLS_CAP (8192 * (IS_ENABLED(CONFIG_KASAN) ? 2 : 1))
> +
>  /* The pool_index is offset by 1 so the first record does not have a 0 handle. */
>  #define DEPOT_MAX_POOLS \
> -	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
> -	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
> +	MIN((1LL << (DEPOT_POOL_INDEX_BITS)) - 1, DEPOT_POOLS_CAP)

This breaks the build for the mm-unstable branch in Andrew's mm tree which this
patch has been taken to.

This is because we don't appear to have commit 1a251f52cfdc ("minmax: make
generic MIN() and MAX() macros available everywhere").

This commit is in Linus's tree so perhaps the easiest solution is to pull this
into the mm-unstable branch?

Thanks!

>
>  static bool stack_depot_disabled;
>  static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
> --
> 2.43.5
>
>

