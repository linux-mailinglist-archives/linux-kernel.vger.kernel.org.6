Return-Path: <linux-kernel+bounces-260842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F793AF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B8282719
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB04152160;
	Wed, 24 Jul 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P7Kp90TO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U4vDANLT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BC5336B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814238; cv=fail; b=kIbo0EEvc5XW+x/DfvhCswrKwJh+z7kpjr5A5SKY/iLXlPZNjTejN/I6lTlO4egbrfmU/m6CIE75OVZ9Ii1iPSWoWu51vlvQlcCVyD+pCVFkIhn/UI3RfKnBRJf/pwjQ2lx3hzm46p//RJMEAda1YJ3SIm5SattgElsKCjWKpdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814238; c=relaxed/simple;
	bh=YD24kjo+Y5MXkoj+KhduOkyH05CkoZoQ9DUbaZ/srEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gVSSMNh3MEJ42BtnDKzxPclVgF7rJCiba4M96Wg76i2R3oSTZBHzcyDH66+sU6aos6TuBhQf42DI/ipNQrt79MkUtNk0t0lMnjo50BaHxSNHXj+s5Sq3p76zo2u0oJe/Q1FiCfFP6pjxO+AjKfhS/IbZpxrqZETcGjoGo2madNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P7Kp90TO; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U4vDANLT reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O5ovfW005359;
	Wed, 24 Jul 2024 09:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=YD24kjo+Y5MXkoj+KhduOkyH05CkoZoQ9DUbaZ/srEA=; b=
	P7Kp90TOb1NbYeQAr+fXtp+BPU4IdvLOITek5FodrTnEzOPgRYKC6ad4e2CxW46m
	xYCMmFNcsMGtvw5BwucdZ3TUuQzOtFYOr7a3QXAEhrL32ZlC0xATGGg52V3W5Zaa
	NFU9W6NLXsZNPk1rQjODiE+cxmKvjimSP6sNMECc6W5z9hA6bmDDCruWURu4nVSZ
	Q5uTxaNOdvLXocoJBoi5980/mQBwholw1wRP31ubr7Bt7uP2wwN2eJx7nL9daDKL
	DHGeKa8KgT9eurQkpBGVfdt7Vkg2MsWf4/paiuLm3u/28cWSbgAme0SHFOyg/+OO
	uMokmZ04UoaVX6DZg2EpkQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcrgkt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 09:43:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46O8PZAj018568;
	Wed, 24 Jul 2024 09:43:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h280stup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 09:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNeUTvbUPOTpyEmGDWHMeHZMcmdMkLDbdI6FmWQKIQLJlb3QPBAS9icbisrJoqvG+OxqK2FoDZYZzxznaGguYZMAnS2NYNd3dMB8hx5Cyvk3saLFr/RxhYR6fxOgf1v99OYFPP8JQRdN1m+lPtbKLOflx4LdDKr+Qm/ycPU4SamjNYxey4tA0CP3JR2JT/qbL3uTeHNPjlZvPXGPnYqNTRAc7dOuKfak+ekV01sXL2J4Vf2Q4dyQbAghrD8gQQpYl73phtOWSAqOjyAL/4SkbNknLIXc3tRNwHf1P4p+vGErwweqUVXyTW0PSIg0mGPwgDEMpHT7+SNkWMGErU2zqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA2vUKV5uLwIe6sFSJd0LKbDSNY/Hwk40FZnKb+cV00=;
 b=d08DNkj60BuwrcIbDHZKXHFe8gknitjxdZ2b82jk2Q7mSBt83qxMQkG46IMxDT+OQ6RFY+YNRwQm54PiO5d9HH4m3Rz3PNqC5qyNSwTpFoi/0nXGcCq29h29j8bAUYApEBtD7M7Hg+oj6qHcCQ3ScIJVCycr0TYISXDtqaZwxXnwgCFteSdKhWJlXIWGwH1nnatTgNOV9PjM6Q7tECQEXk1/jWLnGwFjmQkjOqJWps3wNNAsvkEfKxzflNjYlh2DsvlzNeUFneukV7cHr/OSoPoDxbfBvQDxeABOz6GGLfzCATnKRJxNHjAKo8ljeClPDYJknA2Be4k8NNKPUiuung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA2vUKV5uLwIe6sFSJd0LKbDSNY/Hwk40FZnKb+cV00=;
 b=U4vDANLTXuOfM0eYKKC9UIlhZyoMvlJDIoAlmoVKs7L2dLoIxGLbCr2S9wbR39HTar/l6qMrQEonNHiGZeYMIvH3+ExgNYuVzI7f5YQ8vkdWfy0+1HoSXjtQ42iEehD4cJp46VfqGIyfqI7YTIgrm73cPPEijRBx2Lz3g+Ljwcs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7433.namprd10.prod.outlook.com (2603:10b6:610:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Wed, 24 Jul
 2024 09:43:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 09:43:38 +0000
Date: Wed, 24 Jul 2024 10:43:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david.laight@aculab.com,
        Arnd Bergmann <arnd@kernel.org>, willy@infradead.org,
        torvalds@linux-foundation.org, Jason@zx2c4.com, hch@infradead.org,
        andriy.shevchenko@linux.intel.com, pedro.falcato@gmail.com,
        Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Build performance regressions originating from min()/max() macros
Message-ID: <5be98712-80a9-4574-a796-51d16c1a1f09@lucifer.local>
References: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
 <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
 <9d62cd2d-a00b-4260-8ffb-0e0e4574f222@lucifer.local>
 <0b11e6c8-170d-4b95-ad14-76685d657643@suse.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b11e6c8-170d-4b95-ad14-76685d657643@suse.com>
X-ClientProxiedBy: LNXP265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 741998c2-011a-4a5a-7be3-08dcabc5185c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ed9aNwfbhFYr4ePmjsrJTz41BO4SCdPhfgpUXaTzNgw+jWMe7Kh6a+UW6V?=
 =?iso-8859-1?Q?igM3ZT6HSeeWOJw2lyE4VrrsCc9JhmcFswPJ1lqpXmz7tZ8X83/zB2TztC?=
 =?iso-8859-1?Q?7Fz/Tsne3pm53fCWQxQROJkH+M7w+b/WHGAqzzGo9bVHV57P44xl+nCnYD?=
 =?iso-8859-1?Q?kY/vvk/L3oWbS7LSsi96OvtYBDpEpVE7iccNoDQRNOiOFwP07kLHNHgFtH?=
 =?iso-8859-1?Q?Ww6oOD4udVaOgmEoZk3L/St+op/cD+J8DAekvPCAB4EJuf/w+9cJEkLX0p?=
 =?iso-8859-1?Q?6dWaBx8KFkWk0bWBW5Zepto6b4N1QDhB2tfckAzd8dcOYsSFRhMCvDDtR5?=
 =?iso-8859-1?Q?MgKf5lAyq6r5EolvM2RzLyoRUQb3zdRrFeUTb+odcBDIrnTux2Jwxtojsh?=
 =?iso-8859-1?Q?TeCh9vk8kVjvDuV8LDJxQudDmZa4D+3F/iO50UlOOrZcKBCTHagIJUClUF?=
 =?iso-8859-1?Q?4Ho3XpkfYipGoexZBVSZGZCY/09tjuJ4PoS5VzO3FmZHZzlyUmT7caHT/G?=
 =?iso-8859-1?Q?nLPGgdNZjzZKwq+eAteXaEfI0A1Z32xvax0uGbUStDIiZK779gVSZTVUVc?=
 =?iso-8859-1?Q?Ra5Daq/2e23aK7I1kHzJ6nBdNMECKnAWMQab7z0tDHlUf90DHxlsKZ6xhQ?=
 =?iso-8859-1?Q?nhIGJCPg9X6bQ7ERjQ3+E1Rvx6wh9s6v3DwI5GeDNYpRnWTQLmJkxiHcwD?=
 =?iso-8859-1?Q?Eg/84C3OzGd1YZvtVv1UwRtV7A6Q6TUbcymuFIjhmM/2ck22Vh1zaXOi/0?=
 =?iso-8859-1?Q?yXY+OxiBRmWrnnJVxuSrtMFJH9AdZFBQHlr9K3p4n8AtveKIPyTX7TvbMw?=
 =?iso-8859-1?Q?8MtRLrZOKiBe3tkZTEl6zZrjrqI+bRXGUryOl8Tm+n63KEjTk4L1VKRmiJ?=
 =?iso-8859-1?Q?Nfn97vAyE5Xhiu4QK3mifJDXsMffgnceKkQjL+I01h9RPi4ptO4RD0SxbQ?=
 =?iso-8859-1?Q?Voqq+lfpO27/0qRUZAnNA4E0xTRfBl4V0C9XdPP1wdcD7exiTdGot3zU+I?=
 =?iso-8859-1?Q?RCD+58nYNI3QHBuz2/31rbksz9MD8Oz8NqM0sEJcnL228PJU+ddI3ClbMC?=
 =?iso-8859-1?Q?oQC77RmhakXa2p387uic7XMqgMoPQy62nmx7hLXYQcZY/Bt6A4u66dCUNI?=
 =?iso-8859-1?Q?wBQT8ZVrdQXKJpTGjVXKfonIDDp4i3SAvlCTTxKL7VSZnbv/jRuJ6fzV+o?=
 =?iso-8859-1?Q?EJJxHeFpv3C36cl91yXlaEbXSz7kj2srqelaSkUu/Ctl1mzrekXbc30FHm?=
 =?iso-8859-1?Q?cA2I7o5lCVus95KPopAeUcSLDWnVhOICb7nN+sIiTezNumhzyUPLcS0Q7x?=
 =?iso-8859-1?Q?X9NgaPnb8GXJ8gWNonvSYVDXS2po5v7Gfcc7ObkF5Q4syL4/RJgEIMrMDv?=
 =?iso-8859-1?Q?eeQJZ+Bu/cjiyna9dhnl9U3Wb1VbxOFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?uMMoqtNgCz0qEx39y+FBrY6sIJQ6rszczKD/ohYQplF5bdJ/brn8+GV7nt?=
 =?iso-8859-1?Q?ZN8kUVa4l/qmbdwHoGqbB5Zu7VZ2KP7J+oW2MKuhkt5sVhQcIuJXaciPds?=
 =?iso-8859-1?Q?wTvCTf9Y3+ucYrkdeg9ulZglDzMTApIc/BnsgytrnZb72/y/TV622QHgSW?=
 =?iso-8859-1?Q?c9vib1LrFK+yMUp/dTa/OSb2xtNAlC2ncbCRRxsRaBb8sCZT4Sos4I9Q/t?=
 =?iso-8859-1?Q?KsQpcJa3aeygYsPS8+x73WpuW9VplpZG8fu+tjxaZqHqX3vomd5YCemXZ/?=
 =?iso-8859-1?Q?rLRibxzUCFc32WLE2et03tqXKiWhn/t/TJ71MrwVTC8PgF//p1UMYPArpc?=
 =?iso-8859-1?Q?/k2NLqxDHttXfFoudhxQhKTm4qNL4oLAVR1hM0qhSlN2oaKBwfnLPmkW59?=
 =?iso-8859-1?Q?2xpCa4Y00yUxPqLk8pOnsSYkqbvOvTwzNpQLmWbHoRzUWtKv9YJLrbDuUC?=
 =?iso-8859-1?Q?nmTOMe6n+k14IOyYquvRqlz/3Y6xvlHUgjzVFPoDUaFpX+zAf84pNJhZfE?=
 =?iso-8859-1?Q?1UndtK3/i+O7vT3v3uScaUH7mD4p+Vkg4C2AMPMadB2v4XTzvGptuzbNUT?=
 =?iso-8859-1?Q?KWk1IfHmdRJDJhRY+v3EMc9UzXdUW6F9gtmw02F2/jC5wqn8J3Wd9L3+vl?=
 =?iso-8859-1?Q?mlRW8XHMUqOZHfQ5Hmf1gYFFuvbWdxZRvJs/m8tHQmxHzYbp9fcu5boIxw?=
 =?iso-8859-1?Q?NYbC2cJe+KcBiyUlA/MW2iVi7EMcQD/2vyty/AcRApOiU8RzU24gR/YtQa?=
 =?iso-8859-1?Q?vL1lM8teDNQeKSuV4usAXY62qfrZtKvcKH9MDIAKWC8tJbxzn9RGktwG0Z?=
 =?iso-8859-1?Q?2qsDTvePlAfqlljYL0Uo1pRYqaiTOv2pCostwWFQljEr36Wak0Cob4Vm+G?=
 =?iso-8859-1?Q?NsjiwnJ4huIN5J4PdMFFNTE0hBSXzZwzsfnh7YY2yTPvHDNv6+ypVWcsvd?=
 =?iso-8859-1?Q?REBDCXYtRqAVcgZLX4lubrQN+B+/FCUqg7pimEwE22v+64X3j/TmI9QYSV?=
 =?iso-8859-1?Q?UJRdoH9R02Bbfd7Oa3WqkzN4ET3fnFoGfet2a040Z20YaJ/FtJqxafJpcb?=
 =?iso-8859-1?Q?VsD48v5Sg6stSY1+j66h6r0l3s3BSBQT6Yc3UalA4+BBYao35HTPJCUYYT?=
 =?iso-8859-1?Q?toWbsRxI5sAOVOs3tT//RFRBB9+eAIlNKnANveQJR33TUiYQFJjFDqsfxL?=
 =?iso-8859-1?Q?sJbKJKRBkTw8S8j70OQgG6j6OGAQduOUjZyH+6ij3ZVGB6gxq/JUtfm7/I?=
 =?iso-8859-1?Q?mIQL12R6pAuHshMEQUGUzS0PXg+qOYVEv/6yycZrRWzQ3qVOR6aCaWeaIb?=
 =?iso-8859-1?Q?YHMUJacu9eXTZJcPZHue2qx+/xAroQ4Mg4c7JL/nDGjqGoEc9XHTXFmksg?=
 =?iso-8859-1?Q?F1AcelnDlTi43snW3RJa+NEHIzwuKG8LADdSthItIMTdUmJLAi/BcwZNlx?=
 =?iso-8859-1?Q?OZD3/FaUqF4E7Mb5OZHf6kwAXQDNVuVccMDlZfyAUT+Cs8fo/+yd4zbrF5?=
 =?iso-8859-1?Q?h+9FW5PxMDMnZCLM5Hgy0iIfbfCMo7HkzsiQvvt4FSYBMG3wTox8vWAdMT?=
 =?iso-8859-1?Q?7PdAr9SPN0jJD/XKzg9V4ZJ5A6kbxo9ib1apBA398/mhU2pHlPTnz2xdFN?=
 =?iso-8859-1?Q?mOf98FDnUK/8bwa02qcGllsBkLVbPhtC2hJIoYVDhqCidb84nDHH0rpLK7?=
 =?iso-8859-1?Q?SVVykSz3BqupFLqr/WK19vOJhnNDDkINab6rcrq/OGG+K1H/PzBUIRHMLN?=
 =?iso-8859-1?Q?xJSg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K9Z2hBu1ZYDczJb9/x8CE/33REJ+LAqTOuOPeOMKBEvJelnzzkvIHjxKqT74uJmj2KaFd1bV5FJL+oq+JHjsyZ7nr9amOTvIMFIZc+dbGUkMpnTqyyPJOpYiZ/9HIJ/slsu1/LI9HXN87VW99SZDM7P9vnrPF9GXGq7/5qIK6cFM1Y3K1ToVXotXHnqr8Yct5myI2smi3uoCTpz2vQ8JKcrMTl9zrrf1dzPdxNLHAfiHS4e8SEx0di7i2aAl8jU3VSKNVrMUSnDf1Sblk1J5MqmyKbmbteSPlmfvXidHwpTGH8eiDakdKyCh/N0oJ+25ysNyDHA0e8oRyo9EnCroewXtJpDMETG2aLnM2x4AatfnJ/Sgd0UC9/ewiHrDanoEL2/0Jp+8vEHqKRlE/2+eaOSZBnSMYunLpZvApc5HXsCMvsEyvuMfQByiF+kg04q0NO7cFgxoXggk7NrUTkrSwGbRFqqyOS0gXKrXK1JftpKHtceXf9+QdHPOlNgfjugAUT86OsJ3Y7qEWsn+DVRMq1nPTYFmS2m2bpJ1o/G/yVi32xugKZ6e6lV3/YE+/iF3Qj5wfybT0HdJVtdloRC3bw725Ye+pXRYXK+R+WVVl1Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741998c2-011a-4a5a-7be3-08dcabc5185c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 09:43:38.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnjI23Fwew/Nw1/U1oHn7iZcq0Owl62pJY4Mwq558EPC33+R+Gt314vMw6EteChDaw8+xBX5XQ8usgKNGRjUTvuTilIYr2WQnSIcBHFUUvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_07,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407240071
X-Proofpoint-GUID: uoCAst9l7GD_ED20dG7_FWhjHHEEUkqO
X-Proofpoint-ORIG-GUID: uoCAst9l7GD_ED20dG7_FWhjHHEEUkqO

On Wed, Jul 24, 2024 at 11:40:07AM GMT, Jürgen Groß wrote:
> On 24.07.24 10:31, Lorenzo Stoakes wrote:
> > On Wed, Jul 24, 2024 at 10:14:12AM GMT, Jürgen Groß wrote:
> > > On 23.07.24 23:59, Lorenzo Stoakes wrote:
> > > > Arnd reported a significant build slowdown [0], which was bisected to the
> > > > series spanning commit 80fcac55385c ("minmax: relax check to allow
> > > > comparison between unsigned arguments and signed constants") to commit
> > > > 867046cc70277 ("minmax: relax check to allow comparison between unsigned
> > > > arguments and signed constants"), originating from the series "minmax:
> > > > Relax type checks in min() and max()." [1].
> >
> > [snip]
> >
> > > I can send a patch to simplify the problematic construct, but OTOH this
> > > will avoid only one particularly bad example.
> >
> > Thanks, appreciated but I am a little concerned that we might get stuck in
> > whack-a-mole here a bit. I'm pretty sure we've had previous patches that
> > have addressed invocation points, but obviously the underlying issue are
> > these macros which will keep cropping up again and again.
>
> The xen example seems to be one of the worst due to nesting of min3() and
> min(), so being de facto a min4().
>
> I think drivers/firmware/sysfb_simplefb.c has a similar problem, as it is
> nesting max() with max3(). Same applies to arch/x86/kernel/cpu/cacheinfo.c
> and multiple times to fs/xfs/libxfs/xfs_trans_resv.c.
>
> There are probably more such extreme cases.
>

Yeah to be clear, I am not opposed to these patches, I just don't want us to
lose sight of the need to fix the underlying problem if possible.

It feels like we are leaving the worst kind of landmine - a construct that you
simply wouldn't expect to cause massive build perf degradation - for others to
step on.

I suspect there are probably a few specific O(n^3) cases (as David pointed out)
that account for most of the problem and a bunch of other less problematic ones
that hit perhaps O(n^2) cases that add up.

>
> Juergen

