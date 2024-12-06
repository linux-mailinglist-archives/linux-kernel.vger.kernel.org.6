Return-Path: <linux-kernel+bounces-435539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB099E791A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9DE281687
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086D51C549C;
	Fri,  6 Dec 2024 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lDf8kqnY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HtCjFfE5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B71C5485
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513770; cv=fail; b=u3804/JZmqddG//2TceHOuYCGIBmmK6Wcze+d99hMwCOyajJYI+ZB0+QwdR0gxZJitPExvgCCMSQ3NmKD/ROqIQD0Wq98va10NSOkVQQEP9T6lge77xysO1bAlUEvbF7TTIkHBLhoRdR5f3MdCkqQwIC8HoK26fyd9pU3nA7sxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513770; c=relaxed/simple;
	bh=mQogRlXQLIO++zt3z1onGkKUo71OeroTVmDqRY10VvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ERz1ffvAQmmeJ0GCjqwBn8wfp1Tnc/spk72uB1FhVmhtJ+bj1s6IfJ5IkzbFvRAjteYMmViSGBOsaxki1zvD4lfjDcyop0nZzQbt9LsqM+SgWNnz4TlECAvqsclgf18mYEs2EcAa2XtV0SVFeSUN0g5D4dBC7Ke/kz1MSdFeGC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lDf8kqnY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HtCjFfE5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6JMgsH018687;
	Fri, 6 Dec 2024 19:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dDuFBAVGuIj5UgU2tg
	cJVcX69e1XkBkKACPMki7q9Aw=; b=lDf8kqnYMfq3cheGdNgDmlTH6JaCZVe+/t
	/3v7h0OQvl1531wr4WCUm5UDtj9Q6o+V9kUElaVF4wfgT+5O3c7NkKQYYnb8RxEn
	LDP8QsVtLV+OQFbmEsi2H433lUD2BY84PXNMN4ozteTU758hxYfwU4i88Xw9t29k
	0re/oF/DNIgp6NALzLoDtGNTxdRf46ab+w/xnV2BmMnsIv/DRcTciPxnOkwxrnrq
	1wF1saUGoTWH+xd+aWJbo048nSpEWvDGetWiNSGoUMeYFugG8M1FYB2d3rMHQBlb
	BNhu4EhaYJRf0jA97Prm1Kz4aA0vkXMWfLW6VYarxr1qjmKJUhfg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tase0gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:35:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6IIU0w020679;
	Fri, 6 Dec 2024 19:35:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5cpar0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw/EdarrAVqQib28AS/wexdSBD/xnzZr/wj2eWLrPhS3f5MEk+nTSPFl5twFo8grmfGcM87SBnszNg7hji2rIdMRp1CpTe/2Dqgv8u4Gy7BxfM/PoKAHq8xqPWTgKF/fgIVqvzWE4yTWmS73lW7YdFxvYk9B1lnKV9NfLCK3AZrTR/+KWKjWtqjXOJCiZPrkEh9Smii1nGpZCgadKfglqQ8HBAPIDEhfD0iZ5V2ORP6TXsFooi7hJJ1KGm45AwXHsjaQQ2jJxJCEbH9uR/H1fZ056irLiayvfvNmejUkt3MsY3C37f3VRS22ZlzB8C6I/yhCYmGqgaTms6QqRIMI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDuFBAVGuIj5UgU2tgcJVcX69e1XkBkKACPMki7q9Aw=;
 b=EwiaEsIDIeF/plq8VCfZa9dG+OQv7r9Qbn3Ye9PVFHXyq5jfsmoy0ggl9ryMox3T65xUaO5q/uhQyl64GL09a5ITRRm1s5QKjuXzL587cL+ZegUlGPAYdV0HJcgVJILoq3cdYopIkK6XgWN+wreXYf1pWxHNmCYr1qhDnBjO1uz/yqNtViuCtMBos2CNp5tFdIbDo2Xu/RxiITirbEagZcYAxnpH8a5kot2nUFf7EX8UGJBEANB4Cm0yy6gaWcJ7hZW/CPT2ljba5Jdva7BmktBhHt2vYc8eZ+WBVBPIxSBVM5Qvj/8jBEYTVE7PaZOKz8NzgOXsx44CljME0ALa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDuFBAVGuIj5UgU2tgcJVcX69e1XkBkKACPMki7q9Aw=;
 b=HtCjFfE5HV3umCYmyTDEvTyWK7zCho4l1A8l5anezJO+mDPvjgPMMdkDnRa9lhGZWEWw1AS3x1L5Q/VdqTv0u+RMjQTqCxHBZXjyZeFjw1BL75npFgLc/Uer1V/NGovS78ySoWD61rOOkgCIfjh3BpuyMozZBDpwXUlWweAIUuo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ1PR10MB5905.namprd10.prod.outlook.com (2603:10b6:a03:48c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Fri, 6 Dec
 2024 19:35:53 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 19:35:52 +0000
Date: Fri, 6 Dec 2024 14:35:50 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <bsk3da3fd2h76uqljrvakvemna3lfmrjlj5bwva2x6shphebmw@kangvdblxunu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ1PR10MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ae15ca-617c-410d-e128-08dd162d320d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UG6BrKQtwIjWMbSt049yEGTbOmJFkwTwPGRoqHGaC9Oq/+pvT/YJ6GiJ/MWw?=
 =?us-ascii?Q?++xTvtnQtDenrL+N0Fk0s1s79DBKSV/jrtUP5RN5F6xi/gB6+HwXcINf9L8b?=
 =?us-ascii?Q?Z/tKPDO3GLG/nnkD8dKddJCphZqKDrg5AgHyOVlPPIjkR/oF7dIHVsaYFnzC?=
 =?us-ascii?Q?S7WLf2Frlea3LCv3C4fS7Y1beYl7EtLotv7z4CLjM1l988UP8/Hkr7Xos/5m?=
 =?us-ascii?Q?GXjUuBKyAWdMruP9HzO3gpUjmGaWqmrHw3FbnQPjbU0uMYEIkA09y3xvhJtP?=
 =?us-ascii?Q?aFheGPE/M2P/N3IItCCDZbmMnSX308dnxnKhic42GDcf4SoZiN2WWLRft5Oa?=
 =?us-ascii?Q?WxS2+3io9XcbZW9VJ1+3MYoPqPx2bQSzivAj3oPhU1lexGiQq78EQsSa7hKx?=
 =?us-ascii?Q?v32ROnrpPhB0LUiJYmlJZSpdwPsGAm45lYkwm6+eOhjJPQouCaP5nOBpjyYU?=
 =?us-ascii?Q?GHWIr+eEyv45cB7IY0nElh94v5p997YWWnZR8hJCT2FO2bR0ypnXoTU/fsnj?=
 =?us-ascii?Q?kdHIc3usDBmnvJ0CaB3oD96Xj217wfXx3H/xCjmPUTy4L455KOSAXTr7wO2f?=
 =?us-ascii?Q?XSjMxinbUK7iz/W+z4Jlbi8xzUQLOCKdt//yKxcLMJGPH3nI9cSbYDvJy/0d?=
 =?us-ascii?Q?Ax0GNnLzV94ueyRCdSUqLqmua1lh8HbvjCYUQifInAMVGdpXlueePt73qlTf?=
 =?us-ascii?Q?p0kVmoMNbwhLqIKgf2ufpLRsvXjqg5AV5lGt2yP+exarSfKGIQnzSi5+CDnN?=
 =?us-ascii?Q?+IZlhEivxcggTPzk3iqLCCgDHZ+PQC2xPDuA3wr5A/KE5BOCV3lc/K0vIMPT?=
 =?us-ascii?Q?mnKz1UJVw7TZYEwq9bZzMfRfhUH4xfGmf3iP7mhIVxXeOLi1ikNO4YYhCiHy?=
 =?us-ascii?Q?PrqZ9TNNV1tk8sLFyfcHJ6SHjaErjnbgWqpeoZjr2xYw+3oKNB7/x399p2GW?=
 =?us-ascii?Q?txVgMlQjtCEP4SXFTJ3+k9AXLHOePQaO2F0qNcuyxshQgYSQcllEW+Xtq0KG?=
 =?us-ascii?Q?Hsk6GOs2T7oGv1Huo4uno2KsFi2zsm4jfWbyyM6WbDSHQXGffzopOv7QpRCA?=
 =?us-ascii?Q?V7M9E2y+OiuYlhsQ1BofJIpXKNKmk3BRWhM7amhJwfva5E8h4cpg7hHeo1GK?=
 =?us-ascii?Q?+ulnuq4A3is4IRZvj/nqemtYZJ0Rt8kTLvpegYMrW5pnwwdDNfjKEwM6tMjS?=
 =?us-ascii?Q?7IOS6KohmgNUecX2hytoyv7wPFbsoOEhrrl9OXMlp0HLtriztYLHtIzWmWLj?=
 =?us-ascii?Q?VYAEw2jrGqBd4o9VM5tW3t22wheWNEYUOYlxsbB+YKww8ypa6BwCp6yUj5hT?=
 =?us-ascii?Q?lsWqLHDLNdTlN1d49hoOgorWWbKQiG66xnJGxdyZgIuF+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q1wDc/+DbD8VEK8yqYmy6kh82vOGuTuzratoUgePPx1RBNQjA1Np2Ys7Mpcn?=
 =?us-ascii?Q?PxzhL0ZRpCLHSwhbPwfFqxhjNNcN+eeV+RweMOR3W+YAlJEFf7d+2H6ig6Qo?=
 =?us-ascii?Q?H4HfsCSU0PRyN6K7gzkGkIoocjcL9HO0cxcB3SX23OHDYzSbV+jEzaAsAkPV?=
 =?us-ascii?Q?3vKRF2wKNmtB6o5bI/Q38OyddATCBXRS2cY2VORfNDgp7XeIO3b6svOb3Tk7?=
 =?us-ascii?Q?kHQxrSdNykwvM3uFKBOugh909NDCB6jgFiRwZSTVU0kdwJt85hH1TpLiQ7aE?=
 =?us-ascii?Q?52sTScTJV2JXo4O04nmqIjfLbIqjh/QejDNGxmO1qtk6TfRMBBCazTy7pFm2?=
 =?us-ascii?Q?9HI/hyPEUZ3wuCVP8l1+94v4MzToEDRNg3GKeRw4vpieRVp+Yk/+ROG1YJ5M?=
 =?us-ascii?Q?pkOyU96i3E5cU9BEWFfGpo1fBdLTy/JvvflfxCAVQnEr2epXbAikx+3BzOsW?=
 =?us-ascii?Q?TSsOr1483iBkwgLOyvxA6/1qxuOP2GDGn9hVZSxqdWn+uvLACvN/W/l8Epng?=
 =?us-ascii?Q?v9piyLttO1/1B7UWlFJnCun7aZeqb0jgqtOSb44v+it3hQKpw/kCj6v5rW75?=
 =?us-ascii?Q?f5wbSrG8xa35FSjRbMEkC0Y28QrAL5gX7Nul1f5qf8tGlbP1+helkzgqzkVD?=
 =?us-ascii?Q?abkslvsuUTvqjCJ6vPRjFK0rJ+J5xW0NX80K7xTHxJUUEWx8LYpKJ21asPA4?=
 =?us-ascii?Q?IS301jlRd2Ys9NfgbaW0UOT3Y+UkIjnT1hJ4hcU0r4ZP2ulhP0PGoifXa0Wl?=
 =?us-ascii?Q?mpA7XMgGJdlQ/kBSJyYACxEEk3Big+vFXbVNNtQsXibS/9Nf5UmdYiikTbya?=
 =?us-ascii?Q?SxJ4HHMYV+5LrWxPb5x0/5tBEOJchMxWDWAM4E8ndnX7G2nR1hRwOu7P39uz?=
 =?us-ascii?Q?hutJ7Vf0lJJhq9bsRSrWtYDDmhqPfMNn3sXTvATCn8/Xx/gOqGSYiHZIQyHc?=
 =?us-ascii?Q?ozOzwIZwCrwtr/2OjY7ufXYyeHmobslghOzse3ii0IdaRvTez2bNBFOomyoC?=
 =?us-ascii?Q?nNkCsRJgYIGM28+73xuwFUQhaNK7EC9j2khU6yH58tkg3NkXPQyR+KmZttBf?=
 =?us-ascii?Q?tZ5rgB8/yQD43cOTgPPOpn/pq2xCcvI561gw988K05v8JGBydXCluVLoepPc?=
 =?us-ascii?Q?hRqi+pxZeODjPyyY1GZjY2kdQ2fdvn7/EZqQ6GQOTndIjOYZVpOe/uT7ucw5?=
 =?us-ascii?Q?sUASdPHiMDhnZK/RFwx0zy0Oh6GtAmsMycFgW2jU8mcemAG3D6p/SNcLP6KR?=
 =?us-ascii?Q?6eowtBpkPJRooQ6OedaD6qR1AWffKN7uD+ouaqvGTWL9PF/iFVpctjmWVK4Z?=
 =?us-ascii?Q?vPe0VGf8ouarWMu2jfC7Rpom3/HRhlXyWEs2Qg8oIYDKzv/GLXyQRp5A1XMK?=
 =?us-ascii?Q?qjLWxUXoGnYyYt7qCEB3GXDA3n9hxhYqPPvd/QgqPdDHUagxBFwyaBqf4Tkq?=
 =?us-ascii?Q?jaMzqdo9wZ6M04JnDzjBxv8dEp4MQbL9FzjT3+dqBDgilsZdPbaSG0RYwNiz?=
 =?us-ascii?Q?YUxJABpmX6Oe1lLKIrUWHN/v7bQF7Fu+Hyd1VKuTxj3Io2eHcVoSUh3V3Gri?=
 =?us-ascii?Q?T6Z6w9L0/uJAdPlMu2FxGjPjV8/fFJ+LlTC4aPM8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E/zvataDQ3WZ1BQe6mY34JSxv1k7hi1+f24akK4aypPBuyuzY6d8QBIx8lE6Zj6mB8E5juMQHu8fAHbVU3t9v+iBcM81yd0yX7zn1AzpXONleyvWJgN9BI3ov/3u9lV5EEylCw2A17jSJEqGCBn4Vb8Ie7EpIAE7zAxmE5SkVdCpv6Omq9VXDulkSEpw8DsZfH/h4lJwhoIW9JDHTcXh+Il5DrCPKfl7d10fjCtc89CjWOkKbfhQotDblHjUZRJLmJCjkJ2sQY7F9WF4uZa79JNE5aXWGq9B8f1GFTPW2Zca7DOVdW133XcdF/R7KsAqCaQqJLXMgWd7L0vT+l56n755RpbTqocn8vCINnQJXkJgkd9Jl0Ly4JvfE+E1HC1iZKLdZakeG2PbARI1fzdCcaHaaVX8nVOG1HoRYDSWbly+s4qDOE2JErYKNjkDR/buY0fXaYiS4bwSFC/UgfePkSyFaE0cOPLtHvVsmHSf0uksHaxP/hSTHFus+BYxGtvq1cQ1u/NP7i6CCsREE/eyIxX9oYMLY2KeWIlJeEoVaeV0nIbDV9Wy6viNjUhH5uK10eFc9sKcy4/JM+8mE3rMhvg4AnQRwLVGhJKEM1KLQ8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ae15ca-617c-410d-e128-08dd162d320d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 19:35:52.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ezv0gOOdoKDBPxjVs5Wn6nZQK1qHTQF0sus9GnhXUHyMASJ7ul3+oeqczjb0r8x4MoIow28yih/VqVzRviGbsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_13,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060146
X-Proofpoint-GUID: vaFdrALHs86y9TS9xudcoc5N4DQmfFIv
X-Proofpoint-ORIG-GUID: vaFdrALHs86y9TS9xudcoc5N4DQmfFIv

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241206 14:16]:
> There are a number of means of interacting with VMA operations within mm,
> and we have on occasion not been made aware of impactful changes due to
> these sitting in different files, most recently in [0].
> 
> Correct this by bringing all VMA operations under the same section in
> MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
> with VMA as there needn't be two entries as they amount to the same thing.
> 
> [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

nommu doesn't really make sense under this header, does it?

We're often (always?) involved with fixing that already.

Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  MAINTAINERS | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e930c7a58b1..95db20c26f5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15060,18 +15060,6 @@ F:	tools/mm/
>  F:	tools/testing/selftests/mm/
>  N:	include/linux/page[-_]*
> 
> -MEMORY MAPPING
> -M:	Andrew Morton <akpm@linux-foundation.org>
> -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> -R:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Jann Horn <jannh@google.com>
> -L:	linux-mm@kvack.org
> -S:	Maintained
> -W:	http://www.linux-mm.org
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> -F:	mm/mmap.c
> -
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>
> @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	https://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	mm/madvise.c
> +F:	mm/mlock.c
> +F:	mm/mmap.c
> +F:	mm/mprotect.c
> +F:	mm/mremap.c
> +F:	mm/mseal.c
> +F:	mm/msync.c
>  F:	mm/vma.c
>  F:	mm/vma.h
>  F:	mm/vma_internal.h
> --
> 2.47.1

