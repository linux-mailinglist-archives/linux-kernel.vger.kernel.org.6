Return-Path: <linux-kernel+bounces-264241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8486B93E0A6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72561F217F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384631862B2;
	Sat, 27 Jul 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aJAkbTBj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hxfk3eX5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E71CF8A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722106869; cv=fail; b=Nl1c7AlvD8+63MjpqqB6sMqFvDEg4R/Cm1Cq+Xcdk9Mk7NESaby6ZtPA2Ld7g7mIRFUu2HuLm9UydWLhT2EpxzI3Al4S8Sai+p/uOYz7TBcyWhVpcQqavYW1rFi31WsB4dyIMJq2TaWSHObFXZukJ3eBSsmB1NKRFC+SxNxnSnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722106869; c=relaxed/simple;
	bh=y8Rlo/yicbs/1iZI6ai+FVYh4mk++U+Ph0AzV9H3th4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KK8EqjbQs9bFIp4gWwiYC0LYF1wg6h70npAzXuFNtoXHziFVpJ+E5UxUPrxpNkUSfRlhEZBpwVgGcu6GqmX8kqrQwoEdpAibJlZyoEJysI8CvsWY7XDxA2nrIqA81BcJHOKzyQi+Twthe520QlSLcYu88wiz3AuAMKYgtFlG4/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aJAkbTBj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hxfk3eX5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46RF3L7W019861;
	Sat, 27 Jul 2024 19:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=XsDIpy8y5u3LfUN
	BJYyNyWHlMPQUJ6NALDcDoZScPEw=; b=aJAkbTBjGJjwjaTSdDItY8OUck9szQZ
	vOeL5pQFkabumLOgs/iJZxMiZrkmECMThl9Pph/pjHQl3GSUqEC+uB7wg0OsJ/aa
	wq+JS4CRSjb9U2TNP0S58zSg1e18VP5XZ4cpVzr0TeT4JY7tVkGvSpppqb1XYBbA
	S3Kf+oCU+J43rZhT/3shgjiQDbZTzHCnN3bJ7gN4evYkBnDpRZN/QDOHyx6RCYL7
	SKzAUb6D3+flKGpH6XjqoP9U/0DziUNynYhpQfihyV5JsqbIRDYoJ+qvxr+smWFc
	UNHOrDg5pG+3l41Cd377/rqsrxyTFEgJHlPVCGgRBgRtNMezatzSSpA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msesgg0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 19:00:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RH2C0Y016009;
	Sat, 27 Jul 2024 19:00:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb5ebe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 19:00:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lbsp6wp5HQPKX1YeyVccqlxSbT6SRLn+JIPwHk3ZBXeyUDhLYY9onZxhymAXF2MUeRYw9ejSZwsdw4T4bSW+lMSn7MZQcf9tZuMa0K2TbTQiDRjyEPrt33nrz+z+/E6xm1Ez7w2hdgEBDmuA8tfcmKIPgcKIW4qK3nHnX46CT9ShQJ37YZ3g8VEH12g8lMV5k4oW2zn1AIDX7frqivFEPqKuKbeXtyjELAbAREGOmegxJsYnVJyIvYUdPlkW2TBY/+F/1vs76qxRvwXrpr64N8ym8NLhxO1cVft7l5fSI3vaFSnAxhvdL/j6EOoWppViMtciC53qc1vU9nv1jXC6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsDIpy8y5u3LfUNBJYyNyWHlMPQUJ6NALDcDoZScPEw=;
 b=bTbs5iv2O9stVigY1bRONm2oaFPnwcnw0Itq4D3Z8ZznpwQMOYpE85vCmevdSididqePx6V3Smw/1++HIeNlkkXZ0kEMwuLnzg9puGAuDK2iCm7uHBIjUwaeFYBSWGq41ugJuOd0wgPxHJg31lbDYwD/h6pEtPR+m2ZshG7hvI1zWrPN/VJLNXAc8Y0UhbTIocfHpLuqECRdrhoEPXNOFdIzmkHkPEPJy/MTH7pzdPCL54FwxCqkSrG05LT5FUmEvPxBIakhHEy/2jhTeYcd15myMc8h3Jbwy8ancP+fqWQlafi41poydwlmwW6OANulSUJWXL5bQQnHigDma5Gjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsDIpy8y5u3LfUNBJYyNyWHlMPQUJ6NALDcDoZScPEw=;
 b=Hxfk3eX5MNOVzgOQOvfHxsftHRBSFmz0Tp5FE+LnzSsOb47CMStvr1gbVcKl8etxwdVaORG7ZtOScZBu8NxL+eOYZBow/orvbhzvsIgeXhKPwTdS/Xijfv3UvZDIg+wnuLWVodeDt1kjWCWrpqjcbx2OwuHQtfHtPQOY1cf7xEg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7239.namprd10.prod.outlook.com (2603:10b6:208:3f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Sat, 27 Jul
 2024 18:58:58 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Sat, 27 Jul 2024
 18:58:57 +0000
Date: Sat, 27 Jul 2024 19:58:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Linus Torvalds' <torvalds@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <eea5d9a4-fcb4-4076-8222-fcff668a2bfa@lucifer.local>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
 <40369e153bd447e5b597c31e7bc9a2b1@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40369e153bd447e5b597c31e7bc9a2b1@AcuMS.aculab.com>
X-ClientProxiedBy: LO4P123CA0159.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccf7dd3-b388-444d-e365-08dcae6e2b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6NkOiPbDQ6FJBFb0WXyzXmNF7DJPsj1CXKvCG8AJXAY34d4jsgrLv9EEKb1g?=
 =?us-ascii?Q?S2dZIDovxjf9mZg9J00krYLLVFmEiVf//oMx9ELqg0R+ISr5e7yJPGWX9uwW?=
 =?us-ascii?Q?TCbkMZRtasXmHY1lptij5Ui0HB5SHfkhm7jndakLyiHfwGcNg5wHnuVMXJWo?=
 =?us-ascii?Q?mqrmyoUv7nlcxInxorB9AKhvu7MswCqlDBHjd4ZebqPJB7DVhlcQxVtusj2q?=
 =?us-ascii?Q?sO6VPvS7fXV7gDtI4/0VrGa2MChj+xA3fLOOe4dfuTIIjJgZuGpo3hG3ozHK?=
 =?us-ascii?Q?jZqQjCu/T4tIh7CdqhCzWFl/asqkViPWhV+f8K9Y4vBnQzLkbp8fyJujunHY?=
 =?us-ascii?Q?FKlAMNbAPP40oTd5DN63jTNEDX/zsvHfVqcq7oJZBs1jtqSzUPUaMUCA12RS?=
 =?us-ascii?Q?+SxiVBEVLo6MJBBSw1zAww4dL8p8W9GFReKSnZgkeGwuI8e8MBWCR+O9xol3?=
 =?us-ascii?Q?6ZRCfvG9w1HmNk9JI0OGFZVEhlT9kvgOeuxAaR+Wo5M78pUes2at3VhI1tYF?=
 =?us-ascii?Q?jxS9i04cjkOJss0aECyVhXYLDoxWIbPOxuQJPRSLZnLXJuGx9UfvA7J76guP?=
 =?us-ascii?Q?yU48sJzPqjOJqYBwxt0tZvEbD1xTLp7WRvYoHppoauXze82YNjAH4v++bXJd?=
 =?us-ascii?Q?1n42BzhT5/r84qFn8gf+wOd4QlkKtrLbgc5fDyXrzwHTdNYt6lQ4j7dJDIrJ?=
 =?us-ascii?Q?37zR5uH28d5RaszfKJPBUwC7JJXgcyVsYOCd1NRUZEHtxYEchmrp2R1LSWe7?=
 =?us-ascii?Q?Qn0833lM+Tu2pW7hAAZgzQgVDdjDfYdp/huLtZo7UBY2qY8b4MWEeLE1ge0F?=
 =?us-ascii?Q?42cKDGH6G1VaEZT1qh5pxbzoQ5/xIydTMQnAXeV9pTFmUXn5n7h3wderfPKL?=
 =?us-ascii?Q?JXXL2jW8KTnf15eiCdQ8OM3Dq33T1lSKrWRx/Du5tPjBQ1omL1t10IVMFRfr?=
 =?us-ascii?Q?UBv4HbvZ580OAt/EvAId0xXoKYhabY9squx8AbSdQHXEa62PeET/1s63KdtS?=
 =?us-ascii?Q?ormDQ3V0Uq4dMRh+aXwyBuyu95XN3KApHHstWhhAIBkOm41WXlWjhoiRnPQM?=
 =?us-ascii?Q?sD5exvJE5WjCeR4VTi3xi9kSGYDezZfaI883+wi4NF2IXgzAgHwuM2ZhHnRw?=
 =?us-ascii?Q?xainBLPkt/ksk6tIPAWVGdaS+MjH35I9jS7aGPVBAMietPOOMrcxNFnWqbUo?=
 =?us-ascii?Q?/J/JujmPmDOyebUyxiFPTHsg0XeupBDNEYDkpPy+wnPUx5sh5rbsOfb34VWE?=
 =?us-ascii?Q?tDvRTpRVXHHW3Q4HRzjHo154fs2hnAwPR/PiabNfPi+jsJoqC57gC37Hnt5F?=
 =?us-ascii?Q?NGIhlTPXtgIkY8Kx4sj5RmfKJDKoF3yknS6VJZMCxbauUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Qm1Nn4qXAO2a4FwuPGlml4ar1KbENplicDUNC5Aqq0f21Zc7pCZHvY+my7T?=
 =?us-ascii?Q?+V00WgE7FDy/6Z+NYYx3P4lzhJ2f2E/3OR31dzRJI+2Zepvasvo/YvA6DMA3?=
 =?us-ascii?Q?2o+GZ4CsvHjTbr4NAdXWLcK9bvbFnkY0MmAzCjYSEeQdxq0V0odEVqZ+4lap?=
 =?us-ascii?Q?P7Jp/unQ2RKM6e+Y7DaKrbD1XFFeSPxIQm50mRvNnFdKA7qjFkDWV9kilX8J?=
 =?us-ascii?Q?uIr28PUIepHx4bdkMgS5qF8LGrsdWdjC9qjrgfn/S5r8aSiwNhijPm5E9/P+?=
 =?us-ascii?Q?+NJ5cnKYyHg/3iVwVq8k9c/fisMGm6vB2+LjM6XWN17+jxVkHSCktAlCQUJa?=
 =?us-ascii?Q?HmRYCxThV+bVjrlquJfmd/VEaEhIoPCDbKrH/rUGdKXBmHqhM+3j8PCpgu0X?=
 =?us-ascii?Q?oMCr/2WKSeTII9vZy2OxItwpk3LeMInymKT4pPHWdZNjDcuwwAdiKtN34vjv?=
 =?us-ascii?Q?ZNb/oy5n5X4AEJmuJrUvChQfIWFn/2BA3UAQL1XQhdwqp3dN196ytgcRGFtu?=
 =?us-ascii?Q?4MeEKPnQRaUw5fpG6WqOAWB1fKGk/HGWfIFaU5Kz4IgjlKHlqP0LVvU/Tldq?=
 =?us-ascii?Q?owQZr/4isQ7IaGSSTHzPEZ6zwOXXM6+nMcYhzDSwoszocOszB70dEIY9JCSv?=
 =?us-ascii?Q?kYyx6Nfy9ySXoUCx3Y4ek6mgn7x+41pnJTt6p1gNF5Q7O4H0JqWu9XP03gHU?=
 =?us-ascii?Q?EQ27+Og1OQvmruBOkJnAx3v8GEDOfLzavJiJzjgFFKHpg49DOKtefc9jn9UO?=
 =?us-ascii?Q?b+CuzLU3zjeGhtCCvUxXV25cFwmRuglIGmnquwmmGfQzmURj8nKX8x2grCRj?=
 =?us-ascii?Q?8DxNyF65Pm0Zu+Wka1lpmOIJvLrGGcG6H4grpGH9YbCi1m/P5JIsE2deRvCx?=
 =?us-ascii?Q?u5GP5xqtiXj8SjpWDEwpEi94dPq5uW3IAcGUqKSrN27OGXfw77Udt0+wfU+y?=
 =?us-ascii?Q?mCOEzgQ8CJPJmBGVpCmhWXJt7DVzTsCevBW2ntPAKmnGvqeWYY+iruJ2xEBw?=
 =?us-ascii?Q?r75375v+F8oYzswUlowJiywh0Jk/Gct/n9+L2JI2KGvcavclJls3iRsKxjuO?=
 =?us-ascii?Q?VTOd7DF5MovkIFvA0dv+BT6GX/mmBYl0REgJ88yjIqV5ObAooC/gg7CR2dR9?=
 =?us-ascii?Q?Pj6nsdkf7na3lcjzr7MGjCQzzibhUKvFWsU6WFO/osbbkRm0aWrPfyJyfXQL?=
 =?us-ascii?Q?GB++5a4dU044VaTfjfUC+dOBu6tc9Rm9XSkaEF9QR9XB1D7BPfi70kay12sx?=
 =?us-ascii?Q?yvlSSN0mi6QV8rFsbL18saVKK2BUs/5NI66lHLSy3dQy8qg2rgT2CqoZ9Ou6?=
 =?us-ascii?Q?HLfIOOr2Mecjg2ErSbDKj8DRg1AseEnTs2n1hMNve1D5GQAPLwhIYixvQGtj?=
 =?us-ascii?Q?x/uwiw9EWCG+RlVWI9PdwVp13KTCOt2OdSACQ2hoV/jrUaahOphFC2cdvlvc?=
 =?us-ascii?Q?YaL174eMZfP+3hcbXRpg8irQVSAToSfOqoB9bGU713bsSXhArYYb7rwAAKLw?=
 =?us-ascii?Q?TLrEyp0yY7g1F6sbGXjTeFtbM3WQoY0zsbZ7Si1GvJxFsbuLi6v/C5ZangPb?=
 =?us-ascii?Q?HhsAk8PyIklbpudqiBXWBO9+679SoUkNpxrJuTn5nrXbUc92m6TXYFOdS6tl?=
 =?us-ascii?Q?EWq0niUVT+pFQukFAr57ZdUmobhxP2xqRnOM7WFgemXc2kWdegI1FU5zx8M7?=
 =?us-ascii?Q?4Pyydw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q7Nuuy9dtZ2m0VpekQepqIOiEwSHY+ugBgUUuYTLSQrLgtiYaURvv7Wps8GPhS9NkYodZELNF3fDhiNzXqOu0QR2Y07fEv+mcUWE2OF2487ezNzCbb8HkNBkVfNVdByvwtD1u8P6diPogZkWYzvmww16ZZU4Rao02oJslN9GL4Or+Dpkc5rs8CoyHeCrm9HuICHS9O3lP5DvVrGPteLbsNnH0LRPq8tzN+2G6xOktUuMUY7zFDMD864n5T0Tird7PLrk10idEqZPZBhrgRHKJpIZNnneOpHBkaYDfp0fRmfMN5uwTNLIOy32NQ1g1XMXCTUdND4L5sgxLgSw+NECtCABFPzprNVG0FvXPW3biVqWHEI32XXQORb6DP//9TmUlz7yTEB9XtAO5nB1RBBeHSz1i1k0fs9EvQjmDKpdwrCzToJhdI4GFRMnhPx3Wtpaw9FFkowZ+wUhPKSqrWLkURHe4qug2c1lleGfolMImcIk3FYDb6BrbvE8DtvV2+vyarKLY/lXwzfenkwbFNxZiRu66mTmx9Ef+NyI5Lm+22O6XSRVlszhOGyc5nmerNBOR5jDNRJa4nL4Oqw++Wn1qEGqhmXrcN7jf09XdydMMHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccf7dd3-b388-444d-e365-08dcae6e2b4f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 18:58:57.6761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oec8jy+7Qx5zLVr7qjQV2caQnW7VCm86z4nYQaxG4PZDcPT969GjOatgTRa/cLjbzmJYJKwE9cyY1COxu/e6bospZAr15mNtNfWd0rODcqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_13,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407270131
X-Proofpoint-ORIG-GUID: NK44Wq4HK60901T4FTr_S0s4gr76U5Th
X-Proofpoint-GUID: NK44Wq4HK60901T4FTr_S0s4gr76U5Th

On Sat, Jul 27, 2024 at 08:08:39AM GMT, David Laight wrote:
> ...
> > and it will spit out
> >
> >   Longest line is drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:1136 (2346kB)
> >      '   ((((((pkt_size) + __builtin_choose_expr((sizeof(int) ==
> > sizeof(*(8 ? ((void *)((long)((__builtin_...'
> >
> > to tell me that we have that insane 2.2 *megabyte* line due to the
> > MVPP2_SKB_HEADROOM thing, and I should apply this patch:
> >
> > -#define MVPP2_SKB_HEADROOM     min(max(XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
> > +#define MVPP2_SKB_HEADROOM
> > MIN_T(int,MAX_T(int,XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
> >
> > to fix it.

Yeah sorry just saw you had already addresed this Linus... I just went with a
clamp()_t in my patch.

>
> Or (if I've got is right):
> #define MVPP2_SKB_HEADROOM clamp(XDP_PACKET_HEADROOM, NET_SKB_PAD, 224)
>

I'm pretty sure you can clamp_t(int, ...) here safely based on usage.

Part of the expansion is because of NET_SKB_PAD as you mention below...

> Hmmm...
> I've found:
> #define XDP_PACKET_HEADROOM 256
> #define NET_SKB_PAD max(32, L1_CACHE_BYTES)
> I'd bet that some architecture even has a non-constant L1_CACHE_BYTES.

I checked and unless I missed something, nope.

You'll see in my proposed patch that I jut replace this with a dumb #if as a
result.

>
> But the 256 means the headroom is always 224 (whatever that limit is related to).
>
> It is definitely worth freeing up MIN() and MAX() for:
> #define MIN(x, y) ( \
> 	BUILD_BUG_ON_ZERO(__is_constexpr((x) + (y)) + ((x) < (y) ? (x) : (y)))
> which is then usable for static initialisers.
> Just assuming that no one is silly enough to get a negative constant
> compared to an unsigned value.
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

