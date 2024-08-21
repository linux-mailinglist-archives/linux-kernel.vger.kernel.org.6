Return-Path: <linux-kernel+bounces-295312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555DE959992
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81D01F21CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5699F205258;
	Wed, 21 Aug 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZWMuNPQU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O+95QoEF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C925205252
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234862; cv=fail; b=KPf143AZrqunBSXCCZZZSBfElfEIB0IabSQav79iKrMU0YcRqFxkDc7rEU8BPrPDbevxUPgoHPHJ9L2LdoaByF4yA6nM+Y2uiA6Ht96Z2x/m8ltoln72e1MQYEfXOFU74YSKNm60zqSsIpmGBPX9QDfHQQrTPEGLdNaCqd/12PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234862; c=relaxed/simple;
	bh=9JS1g7XjE8InBobldeGYnTsQCEhHzp7WfSjiG9+YJSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VZrA8QBtLAoAkJUruglKL/ej5ik8ytH+RTl6QnT53qvWeePikK4XcbLIHkospKwwUZh9xkJ3cjuKmuuzcFty7QXZJ9r5fKF/FG7TgGCQgQAYWE/F39U9kruxEwWBuNxFhrdC2mWqjXH/2Ck7CYkvM6gHQ2lzVJF+gYDdQCK13Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZWMuNPQU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O+95QoEF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L7tWeM000436;
	Wed, 21 Aug 2024 10:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4NkcKq4DXNQ5ZZd
	/TWukkJfcSc0WSNy1dk0KMKCQi0A=; b=ZWMuNPQU9T8lFgbhdjrWQFH1E0G8TXg
	Mao0jZ6YkcUU7RD+8ANkb29mFidLdG2Yxqta6VWvcxO8Nca9K+qd+kBN8LKBlbuc
	JSbAj4LtKp3jXhC+I2mHUuIqzsUKOmGcpO/O/pQ+UmyB2gV0UMLQU7+JhK0f3ZmS
	R/Kqr3kH85XXbIzPMlULOU0/nMXBf1qIsPSSICpUYmlk6Ss98etuKRwDBwVZRKQJ
	+NZjVN/ie1PnPD8DpgaKSJ10Dj0+Uxubg1IZDUrVIeF3oP6uOa3Zhme++TT4KPYW
	FIUVYWH80IYPEMf+2Gq3IzcJC6JZT9of0ygTJl5ozn8RTadIYB55Q1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj1e2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 10:07:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LA6rso021371;
	Wed, 21 Aug 2024 10:07:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415e6vr0c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 10:07:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi5pNwLFG8aIdWS4kE7Bie0J8r2CUpxJ+kaPnYZ3VfrAatJrVGAVzeE23Zrpw4K4i4Yul+9KGOZtePGGuxz/93/vCV3AQUWxRnTl2EJtHXWNjddn8EA//rlogmr+6hUjij3iK2fpqGKpYK64Cb9HCNfFN1WtU6NaR61NnMCNjxHF4VjvZZ1sa66cP48UJXCh+1gRXwiC8AXSSKX1gXc6k02ZXKxm/Wc6dam0uy/VXHvlNfkylWmhzqh6IT4wGLiSXHVYfH4QmA1INJjU1V8wRcSmEdGT47H+3/FvEByOu/DSN0hfcnfgrBD0mnHeCxOEUdlYmFE1TvCGF6bvKD89bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NkcKq4DXNQ5ZZd/TWukkJfcSc0WSNy1dk0KMKCQi0A=;
 b=XMU0dNHLY62hbB5kOwZfUfA2+8WxWtYVy4hBXkKtiqDYUXl105gludGiRSt0u4TJrswLmBgf1oktaKgEzS4NF9LBk0Heq1wB5I6DObuTh98mbpQic2jIUotovjb3+yiUrSIdpnBShDT6b0avWhSVmK3lQzPIHf34iK/lR28auMqcr2D0ohePM3N8rAd+dFlfcvc7KKbqBg9lRmRCDog2YtQpaRFEKbCKY8Eg18R3ekrTWGzUpSXkvR1gtWtDR48MLQ8KuqUX1ie10kMKqDzLyTVF7brOfNPAogyePTNd8Er8Z0vm7GFDlX1usx2IQas9xi4rZZdq4jWvqSnsmPR5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NkcKq4DXNQ5ZZd/TWukkJfcSc0WSNy1dk0KMKCQi0A=;
 b=O+95QoEFZnMBxYyDOV54h8KPPB79URZSXBRlaYhOMjMkpVCLXUQmt/ec6qenzjWakX5ME2C22Ga5CuZyGIlDSUAQHHw34Q2SfqxJrnhfBIJpt3JkBHsaBYQ1TgbzAdSDfqiEnllyDg5bcbnV6KEXKtT9zWoDePiepWRnLOc/8Mo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Wed, 21 Aug
 2024 10:07:15 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 10:07:15 +0000
Date: Wed, 21 Aug 2024 11:07:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 10/20] mm/vma: Support vma == NULL in init_vma_munmap()
Message-ID: <26331945-9801-4af4-8e10-86992df0e3e3@lucifer.local>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-11-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820235730.2852400-11-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO2P265CA0501.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 2486ba56-1638-4eeb-c455-08dcc1c90834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Elx2OMqDFMriq+6ut5VLSP+5P0u+cZEETZq0rr695pL1bwFfdQGFOrA2mSbV?=
 =?us-ascii?Q?tBMsq7v+CIM5rEh189fymwC97j52VM3Wuj4MTOKKNskuEb0B1kQ/yqtlGkv2?=
 =?us-ascii?Q?NfE4g6iZa0UB+vQkxNl7hMrsqugngyNIl7nBwt79qNjC13l8wzhgZH8fbqxM?=
 =?us-ascii?Q?OPBhkNWE6hW/qPfhdlbx2iP5RymDP0yV8yxIFm25wsD7EjW5EQA99zJAewxA?=
 =?us-ascii?Q?R0ZRSGzGJ1xeARqOKP/s2Vf5Pnu0KZmOHzUHSSYkv0YczFrGK3kvA5Rob5hb?=
 =?us-ascii?Q?2d08qySu2zpKztZssf7e7SnaRopHM9RDqVrS+cnJvIMB+427al/6vIta1iWa?=
 =?us-ascii?Q?hnNZOTnPtSdtp+u5dd2O2xVuR8jFjMLRjn4IdwUkLyPfbFMTvE3F+eJxxsA6?=
 =?us-ascii?Q?S4biQTVuAl+KqJxMxhs3jV6qJe+DB8pEGNGA/76xpxKvV6/xq5BCs/bSpg0m?=
 =?us-ascii?Q?vNamh8vEQXf6CGs38s/goCCThV2ltUp6Ad5jGxFnsqfV53lROxBYwFQriylC?=
 =?us-ascii?Q?IoR55hrmUziH+f3K7sAkn+u+OpQKTRxRqcXO5e+72XbUsG6Ho2wEHLfsVAWm?=
 =?us-ascii?Q?w1N6D8hUm+DonBAu3OXcdio6BUrsai/CuYBF1gr/5EICfEMjLuHqsKOxsaws?=
 =?us-ascii?Q?tRyqoc+DeGR5Q9gzTOiGscjdTFyvIKmwFPXX6OajLCTU75KTw66FSsAlsdz4?=
 =?us-ascii?Q?S4Uh1e02F73plzamsI0d3HIPl+j/PVwlduQeUE1bpGjGk7KwqcmHgXuv9wd+?=
 =?us-ascii?Q?Z85oYgyzDMCQGtraLFaRAtOrK72lDu3x2sj4Tb9hXS5qDPVGK5Dt3RduIkex?=
 =?us-ascii?Q?tV8omcZfxaqw2FGwVkwe9BbWXjTVs3iV5oRX81o8HUClfqEmWDMhFru1T5lk?=
 =?us-ascii?Q?lWzKd8EauWZtImxf0lQwG8q/j1K8tUhcqAZvrnZKUgwEtwaV4bWj6t84fwSf?=
 =?us-ascii?Q?dJ91ibl7jROkI372PyYK8/ropYmRHrskthqUFmFVTpb5Dwa+GPjVgwoa6/ao?=
 =?us-ascii?Q?XO5N4/a38PVulpjCxUCyeAcUITgtg+1kiqyIZ8rTVTxJZBxCwxx/O8mEwhAF?=
 =?us-ascii?Q?mzzUay2C5elxE9cc/chvAZ2uWC6ub+jsKsAoTzr/FTwtmY965xIkRph/u5fi?=
 =?us-ascii?Q?KoPY0vDgJ/bXaZ22hwSHq6kgq1lnQNZvTeEeyE43lw4xAyc6d4W3Gtda2+C9?=
 =?us-ascii?Q?IrrZj4+l/Q2KYzPlbXRQCYammbP9g2iUKAlaXH9UPwCHZ3MX4RrM3zZWGKp+?=
 =?us-ascii?Q?cWjDr9TnVeceSpTGhu8qCFRHKt3ZkzxJGNnS9t5+9WoWDO0PbHiM0DVe3IyN?=
 =?us-ascii?Q?ZxKYxTVe4hq2HGhSbxK6eCYvP2i/wbdbGjKgqOcYTmskFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N6mS4U+F7fxJsye06xXipTzvYo90B6en/dH3xW8aqTPrWLPkFqPEv6dTn4fA?=
 =?us-ascii?Q?zPxK3wb/dZSNVWQEpqvVXIjsr1IoCRYxrrDvtJEKFw8fTmcufzAkUdQBKFXO?=
 =?us-ascii?Q?0b2+cbAsTnms0BUprrVAK5nADNl5+zN1WgGWvA7IpNsv498oGF1wTik2tKtp?=
 =?us-ascii?Q?EWjTiRDkroR0wWwgMAyxXtzosg03rNKqWh1byXee7QWK9eiucOZysmiHtTNG?=
 =?us-ascii?Q?drO7PJowUp3KgnycMPtn3JO5LfsB5MHZpFGtzBazBENlcjQs/qcIqJ88VKVg?=
 =?us-ascii?Q?1AzsZq5O105bPKaPFdMAfsIqzI7PpcTDHDUE/fVpUdhru9diSDwQmRnQN+f8?=
 =?us-ascii?Q?PoSXeiyo0NKdbg6ruIXNTZDyLfgDCkWQIIsN+Bk1Q7kWSLUGBEyzZvPlohsG?=
 =?us-ascii?Q?QfmcG3ZiHbEUlz3pZ3zP+NTgetksgx/tWixzDNtXWe3UKMqYtbiEQVE5aCJR?=
 =?us-ascii?Q?3QD+LwoqYrwucqbb9KT7jOoCbA8s9bVsehPUfhC6xWQHZGjasrEn2PrHTfGX?=
 =?us-ascii?Q?tQKWuNfOcM4MAQHqzn23IoLBjDD8jKcLuW9WsVvzJSMEm+GnJ1euneePXjQw?=
 =?us-ascii?Q?5AZw8UpUWLOxSJ8HWVuJ4BUrYT7qx0ZW6r+nE8OcLNfQNfLG4a7n7KGr8vuX?=
 =?us-ascii?Q?E6+NYUw/5mAmr3hXco5eOO+tYOLzn//3pxa+p99f5QYzAOaOfyIYvgbUHBuT?=
 =?us-ascii?Q?cX+yBTEo+Jr7h/djo5bp8LTNqolYhZICvq8vk2psJP6v3T3u+Q+w7QnrQGxu?=
 =?us-ascii?Q?k6mZijQc7yaL0GYthF7DvYToIoCuGTkOYF//nT1Iz5vRTpMt929ea0/ViZhg?=
 =?us-ascii?Q?mkzvJ/1h3yn8SRqpibf81VCBAS+kcHJRb/WHMI0sNjrvbjBKFp4Sbl4TQN6D?=
 =?us-ascii?Q?ebJ3E/Y/kJU2Rpw+3lI3GMMejPzKv4kOozQ3YdmSDyIoxNcd9pR4BOyExpYP?=
 =?us-ascii?Q?RexH2Ho4hj5S5IvfcXXKE9uDOxwt/uqBMynHZ+1Ri3Be3HrY60s+IIp4HRus?=
 =?us-ascii?Q?/oqzclJAU2Y84E8g+WV1AOs4QSF9w4QzykfOZRWvv0P/QlVvXiriA+DmF4kC?=
 =?us-ascii?Q?spXm4S8rXoGAI7LUAKyhkipaS0RNKCba/uutHfXXKPjx/8EkAbgmPPxkAIv8?=
 =?us-ascii?Q?CV7xRtv7oS6fZ1jFtwGAXgq+1M1JsaG1rFFL1PTFkLRwySAYEj1UC4dUs7vS?=
 =?us-ascii?Q?omFyF5gBiXUDG5wPDz2TZGnPdDDAyXZorOWLdfDOdpD6cXGxeaVnzsdNXUXQ?=
 =?us-ascii?Q?rGIKWFkaLqs+g4fboIkWpdwPunidN9vhTX30XOJLO+fknLG/mRiMoExLmLhu?=
 =?us-ascii?Q?1TUzO56BVtUOyQ8pemlwgPtaDgxatES9aj2VDd/DaAXVC2UenrctSJULdvIP?=
 =?us-ascii?Q?9pFAesXLxJ8kT/ndWEVLRqjLRrg3VOhrfWlrlSITg/G/xgnh5GLNhituDLIV?=
 =?us-ascii?Q?L9xju3sAZtN3ZFQPrD584Wvr+rE8tDTyyLHHzBSRkisyn9GK9qPquwXjIfLk?=
 =?us-ascii?Q?TZ0naNomJ2+hHKIk5k1yUYYmvN7lqhZkOJWHT+jbrz7+eZF54wKpIGx4rdh4?=
 =?us-ascii?Q?NRcntHh8vsAY7E3SdkouEfOWAH336KjK+M35ha/1t4mB/UMSOCmk/bPDYY2t?=
 =?us-ascii?Q?ZFE2dZbvXsKc5YXaQtpeRedZO1dA9ccyMVQiou5gkC6Uv+dScbTKZzk3BJYt?=
 =?us-ascii?Q?8XsxSQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WjAP9PBxOvzNF0+PZMUpswgVP3PwsYd/5740Px6pi2MElAx56ZXz2mv1nysN28dwhR/BYTd08UjUvdL67E7xQMXQiaIfM/gRfkv5EKeOAwpA2itc8ot8OW9FMbsb+NBijJOCv4twv/vul0x1PNLMi4f+urJLjtwn9o5HmIhcRsKhlDYSzUoINOJCqKfEFBLBLm5vHLM/jf6RXZ2o1kh8mF0uDXqcNoOmEecwtmpeJ3TxCIN0d42za1bQFoEJRfZjEubkhYZWxoNdP8mBrczDJ/ToUOxCQj0ie162Y4LYB4cplFAYeB85UPj+GiEgSnIGOi8eGoT5edUae3ZGNySWF5+mxQogqIqIsfi1fHXCpCvZvbWXuIAIkAcDbh+eJ6TVkwtAaUz6N8f73yWpsQGVH2xVoTviFuigubIqLveNAz1ZhARcnML3iMTWBNiDDnCg9PgDJEgEK0yiKXCmSUECwmagCUSxhoAMcaoqPqT3ZgIhbhJkrhejdPagVS/sd2Xy8bWakEQStbLC/hYIDH9OBC0ur6paLe3/sWXxtdXXR+sqB06nTNzRcpEqgtj4gN2lCFTvZ5REFNKm2vSJ2Kv2+Hf2V/3fhMG8PINr9XxFRg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2486ba56-1638-4eeb-c455-08dcc1c90834
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 10:07:15.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5hbSeG6yrqLOMVO9Q2bCd0e2xXCkvotktqhhp4MA7HTLCihVBl9/X50M7TFo3INOS+uuqSek55Hzh8arZTG/8devduma2x9QIkF2CCfauM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210073
X-Proofpoint-ORIG-GUID: myOPoc4iDJ_4KxfaEZ_A7zU-8dIIUiZ_
X-Proofpoint-GUID: myOPoc4iDJ_4KxfaEZ_A7zU-8dIIUiZ_

On Tue, Aug 20, 2024 at 07:57:19PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Adding support for a NULL vma means the init_vma_munmap() can be
> initialized for a less error-prone process when calling
> vms_complete_munmap_vmas() later on.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Thought I already R-b'd this :) Anyway,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mmap.c |  2 +-
>  mm/vma.h  | 11 ++++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e7e6bf09b558..2b7445a002dc 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1393,11 +1393,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
> +	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
>  	if (vma) {
>  		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
>  		mt_on_stack(mt_detach);
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> -		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
>  		/* Prepare to unmap any existing mapping in the area */
>  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
>  			return -ENOMEM;
> diff --git a/mm/vma.h b/mm/vma.h
> index e78b24d1cf83..0e214bbf443e 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -95,9 +95,14 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  {
>  	vms->vmi = vmi;
>  	vms->vma = vma;
> -	vms->mm = vma->vm_mm;
> -	vms->start = start;
> -	vms->end = end;
> +	if (vma) {
> +		vms->mm = vma->vm_mm;
> +		vms->start = start;
> +		vms->end = end;
> +	} else {
> +		vms->mm = NULL;
> +		vms->start = vms->end = 0;
> +	}
>  	vms->unlock = unlock;
>  	vms->uf = uf;
>  	vms->vma_count = 0;
> --
> 2.43.0
>

