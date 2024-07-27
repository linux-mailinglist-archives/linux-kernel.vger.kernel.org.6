Return-Path: <linux-kernel+bounces-264209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38B793E034
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF96281859
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCF4186E36;
	Sat, 27 Jul 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X1mTcFR0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yn6LCtIe"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272F12C46D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722098603; cv=fail; b=e0XNNWZSSBcSJpuVJXSNPu1OZBfYppHjW40dlZueMn++vY8LbMEGb0RAcGQdLYQTJXTFn+GjrFdCJdfMG5of95cB3TQxrYNHnilbzHN3Jijqg6gy4dAaoc9ZT1eJKLvMiiUnjRpi3oim52ZLo5d9WcXbF1EFXLw44nn3qFjBxo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722098603; c=relaxed/simple;
	bh=WfLxxd9m8AXJKm5fmOkm835B9WKTSZF701XLH6gcjk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nvJR3UYg6ITgTrOflJlys3vv4tUVQ9msmJ4rn5GB2kY7ObXeg7MpwE8oR9/nW6zfhsmOeWP7bpjczuM5j812ZJQXgc8+JAsMvyg34jUcatx72kmnZNQ1eWzkmmRF8YaHGSuMA4oOsx+YuiPYRNZ2NPRPE0XY6TbI73yj+carJ5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X1mTcFR0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yn6LCtIe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46R6Zf5a023796;
	Sat, 27 Jul 2024 16:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=WfLxxd9m8AXJKm5
	fmOkm835B9WKTSZF701XLH6gcjk0=; b=X1mTcFR0X7jR9cukrKCIawNkYfy+RxR
	pzSEOmjnKYWRJ1qYOoX/DGSxtZU1wKRiacZxmBTgBpj4DtoHFWaLz4cBSVr+p5LP
	p/gWPhXEI9rIeqyH8TFYlGHJafQIuFIuHJukIjcsusWeKOEFM9cfzn1AyCTYbV4l
	utlIKrf9IGALxK0olMWNXR400MWsgXpEckPo9yyWYNadwSUiOkm1MKDS9V28swoR
	UQYl1eIGMwN+ISZXN+u8Qrw2ZcWak6/PJmzj7S3xGvPtQgqCX52MyO3QXWVWjmVv
	pQQTtM3IGij4sFbvu/OjU3jhFI8HC9icZ87m/sD/nxC6U16sEqnOe/A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgs0f1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:41:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RBCROk007749;
	Sat, 27 Jul 2024 16:41:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb5mgwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2i9PZyIyPuPXEykqByS+3C5OYn3NJ96KzirbZaELqYonkOOAnPCpTbrxSdD+1vC4fIxk8h57qTd1RxORbOPOnbAiTNSwPDlXQK/Py5mgYgSK2gR71Gu9CZBDa1q3p8f/5GTu80Iqf2SyqOGOtSGwst+KlNu7JPEd25HfS9s0TKNMQIfeFks4WdfyVSXC9WkRSgT+6BKZP0PNEcFkyjQb7gL5NQkndXhNPWD88X5gAi7dwYo6mrqA8pAWFTvjg/PoQQW04VLwX/XQam2EExFBdLsjUOGyW58KWr2GqOxQ4JaWk/vo20n1xEwW/19bOEvBwMrKiB3SS4cwjfjYhdEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfLxxd9m8AXJKm5fmOkm835B9WKTSZF701XLH6gcjk0=;
 b=VA8K7wtq/UvS7WygmNEm0DzdMU+488FFapseG3QRJXecT85pEKaJ1UdpYAGNAQ1qnNvwc1prajFJXq5ZFKyooUpCm3bhybxamRO0HmoBjSiqVo6d4LQTJaU9RNgnJ1Sk+GQ6P8UE8wncxAa2s9mWZjXTj2Yg49yvR9kXwmxRgCzIjoMq2T+Vws4iyhTpzu//aguolllca9+gksfihg7WW/SAf/UfaqcTssEs4JPJ8ryyE/TpsdpeiN7gzP22+YT65ba8699GREeTRg8NDdvl897yhRNpSVerQiv4c+/jKfHli/sn5KuLUO0I/1AE1cDeqQRC1+6i+6m7B0hiPAy6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfLxxd9m8AXJKm5fmOkm835B9WKTSZF701XLH6gcjk0=;
 b=yn6LCtIeccZXp/IUFyGo1lfSnwnHfLZb7AKg0PFIgMcOytO7JTDu/ApkksddQ3e95tFazKVRp4YVwZX0bNzGyISM7t75tuQ2ZBEB/55yLLJAIMuH3vLgdjGKDW8I+alMZ7EijVKVRn5pi7FqRNPlml1OU9H0JZzBA80kN/tAXtU=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Sat, 27 Jul
 2024 16:41:35 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%6]) with mapi id 15.20.7807.009; Sat, 27 Jul 2024
 16:41:35 +0000
Date: Sat, 27 Jul 2024 17:41:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
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
Message-ID: <969b864a-a27a-4bdc-ae1e-e6132dfbfca4@lucifer.local>
References: <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
 <f26b8167-ee81-413e-b48a-0469680fb768@kernel.dk>
 <93243310-22cf-4d44-810c-17629b46a33e@kernel.dk>
 <1d87456d-b565-410f-bf4b-91fe5704617c@lucifer.local>
 <0c5b8177-3602-4840-8956-6196a6175c04@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5b8177-3602-4840-8956-6196a6175c04@kernel.dk>
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 5961bd30-e64a-4483-e3c1-08dcae5afa76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7cUlpnUGOrojtApqjCTRUcc1XUgxtubvfdCRniHxCNP6BigAOYOba63qsEWg?=
 =?us-ascii?Q?zZU88Db5pqYIrywM20Uin/ilV9byFBVLpyzvAjhmngYSoAjj2eaaUQv9ZjQT?=
 =?us-ascii?Q?aOckwrXKyJAKjtPvEWAzjPv3ErbXrekbzN7Z9jurFyLlQO3IEzPVbjWlRM0n?=
 =?us-ascii?Q?mHLiNeUAE5QO4xrkzyiBo1yzWto6AKXZzBgB8Mxyhpwm9uJznGRw2NGoYiL5?=
 =?us-ascii?Q?EE8xysc2Nk0GnzBR/CFrFK7hmhZch7M4C3lZG0ZfGiPMojPaZABA7Np8rHLZ?=
 =?us-ascii?Q?M8cm9xGZnmm1agEUDWj6kat54MYkOJQ7EpXdDUM4y6macumussjXc7hUSZ4B?=
 =?us-ascii?Q?AS321QPelVfBL/+NQXt+S2EaWkDD6fownTln/0siKBLGFG8bp1eSEAZwjsLF?=
 =?us-ascii?Q?xDN8jZKlQPttJG500SMmUfzmUGTS/4nL4j1ADkS08NUWejty5OccN0U3pRpq?=
 =?us-ascii?Q?B0X6fLCKu1et9xQrfzpfUYYen7I5S/2xpCntYmVSDWZcIAe8FpRJoja+Bnzy?=
 =?us-ascii?Q?/A5Z8aR8KCtgCBFUe6dgmWYGQkuGaehV85M6l1nfYRDMDf8vVHONrmorkPyk?=
 =?us-ascii?Q?O36SGff8E1ZwOxBbtJybbXozDdT80Jt+Uthvflkk/+AbExWZDcKFzkZj3Rci?=
 =?us-ascii?Q?yp0iHAcG9D+RcgKTJ7VGpewynjUZIJ0Skmer8pwXBpRcVRc/2j7wNgYPeFHD?=
 =?us-ascii?Q?/j/yD0vIUV1aQDtZrvi4TCMt/Q4mhAJboykIisTKIcnMAFloyC06oiijE5ps?=
 =?us-ascii?Q?uC4g5iuyWG7HQX9yKXu+vGX/Uz+IOaP5SNUgbIpH2CdkP+0vA/W5EVngPT5/?=
 =?us-ascii?Q?Dkn7UH8iVCxb1WyUEzlaDBMbMIL3wevhMCSSb0gYIVxFtoK6M1bCE3BvvPjG?=
 =?us-ascii?Q?/zyK5YWElutHeWGq+HCbeYegW5KD7NgSSQ5U4rfM4nAq0KDomjwOKFXA1Dfa?=
 =?us-ascii?Q?c3/Fs8vzW7g429XkjNAyXz59WmuhnpjbkpkRLZP4RQVwpnNb6fgFDn+/NZSJ?=
 =?us-ascii?Q?IiBkRsBgwJhjwDJUH9kfamBfJ20d48VYC+UNiQmHYxB0Um5y6BDjbcrF2eCJ?=
 =?us-ascii?Q?Twx+O7jVFFZJGCpgr7JcI93xM824GpUN23xNXbpXCSJICVGzgxnjfjxnCSXN?=
 =?us-ascii?Q?03sREPAx3evZHBj5LJSsngicJ2YlYfiAnlIOEJRSqzqeokxIoajPi6Y11P97?=
 =?us-ascii?Q?//Q+68fHzfQ2I3kemAj+01PlAIookU6w289O/H7H/lPxTNJ3GLSyvi3rkQpv?=
 =?us-ascii?Q?NtehTpIJCPsRVeTo2EDNgg0QDgN9W5CvOVfQXYhDWQ4LXpU6ozd2f8flf33y?=
 =?us-ascii?Q?uazlXIrFMr2CKompkS4xQxsdLbhDyyTL+du9YSZi6/VO9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n61NDZrPtvQNQlAs/G06cx89ipbCkAkBJ4AcdK0URzBNNdmZfmiYtiR7vhJ1?=
 =?us-ascii?Q?Ztc4k3+CWXEUPz4ZY/4IU90Vtx9LEHvkGMXfnKvJXT3IEBxw8nPs8wcpY47A?=
 =?us-ascii?Q?62XkMDDP86szjES9WyhRO0nV1sxvd/i8U+1NkOGrygzcrviOWprjOjh86EsH?=
 =?us-ascii?Q?B7Y+5jt18la1ygu9EF/CAba3fDmrU8RaNOlrcAsEo57sv53Lxm33AcTKBy3C?=
 =?us-ascii?Q?fqcPzROOuDxxXYhvWUtQ3QQTxXx7j2b5BiVNj7nP30b+vKjH9x8swa6TVvK/?=
 =?us-ascii?Q?GdYRxuqBjeUASHQxwKroeNdjYZLEfuN4YW6uIUReqZlFUZOT3KShqLNhfBsj?=
 =?us-ascii?Q?jfHLs+Jg0aXy5CBObKZnqF2bVapzOFSc10/41asIOAhTMcEKSaIcpMN1Xhn+?=
 =?us-ascii?Q?vmZvqn1QhDD2yfIcyf/3DuBM+knPRd/k8Clwb2VovGX/F+is/cf8vKKrEYEf?=
 =?us-ascii?Q?v1wydxI3rYUKmyeXZUZRZcIRkpqfGgCoCXDHJJswjaTPV0D9LY9IFyebJd0q?=
 =?us-ascii?Q?ZGWPoIJ7Xm3XS+EPJFECYefU61p5/OOc8WtHXMwNBuD9ODyGtHO3eC0p0y1s?=
 =?us-ascii?Q?0I5UCb4QSuoijgd7JPUZ+JZ2sc8Q1ft49JJWiYq67xaAgVqClVt8/KD4wOVg?=
 =?us-ascii?Q?TA6Vc7TNVAFhR8ysND0Iixrkqt0ym59PHlAuYhBELiT9igIeEYqJxq2zw7VT?=
 =?us-ascii?Q?xfAwWrW0DlPmeFuSVqUF1CgQbUb2KLOnv0wM+hQBnXZQXZN9tD3YXSiLFwGx?=
 =?us-ascii?Q?0HC/zvJEUiJ6/U5zrmeIRIbDAZ7sdRawDdSy2P/TpCJ+CTQYIfoGQaygEGQ8?=
 =?us-ascii?Q?yBWE1TT1wyhVV4PrrAI54Rh9HjyDfJ3WT0NNKUvSFdBH5ChGyLz9MKv1+7tl?=
 =?us-ascii?Q?m7Vyl81jMru+EQodzPrWS5KV30qt1nMatP519bg2LiLbFwxpmP5haTcuSTYJ?=
 =?us-ascii?Q?/OePxNTplCE3YR7hcdKS11W2ZsEvOe7OisK97/BP6WNnBNYKgcAmltkVYCw2?=
 =?us-ascii?Q?UE0Eb1lnvJzpkTnee1AlKOqjnXxhI94v5nDpiTF0E18BQlIoz6IiF173rxVj?=
 =?us-ascii?Q?qmvT1/XCcpViHcE1DPCZy1/ZTg5jcY7+ciF25lEV/AfYOmJr8k9Gzq877wZr?=
 =?us-ascii?Q?89est+hNDu2+O2Iid0Ep4aUBxblu+fOErrC/GnkWQx4ykdM7fvi1nIy90qOR?=
 =?us-ascii?Q?+AqLPmo1VIEVtFuCoMQ/hU4nOCZJtkst1IkXXXPk4tZc/Rt48aMZm1Jg+dP7?=
 =?us-ascii?Q?tDxz76TSUD9cs8zce4GOMvlf01zSumWSraeGvA87v9gkUmrLuqnSo2xtoQmt?=
 =?us-ascii?Q?3ZHy6gnA1ybwrsYRdZRQY8/OaPOCYog13Pc8dyM7qWnnAw4kjn1/29SE1Ani?=
 =?us-ascii?Q?SCCuTzUONXkcxeS62S0GPEK7Y8w5GO4kHQdThc312vFmJ6jgDHoNNt2ww7n6?=
 =?us-ascii?Q?glMcR5ySAg0/7Vqh4ID9GGJNUZ3kaWcTqNyUGG5vCqbpw8HazER+a1hAaOH1?=
 =?us-ascii?Q?Grh2J9j7N1RmQYPNbYRvt8D4g/AOXnGLo4sIB9ar8Cdii85Ro+vv09avauJ6?=
 =?us-ascii?Q?5+W1GujgrSPOr9+s48eTROLVBJuD1GhQfVl8wbS4x2AdV9qanFD76mGU7Hp1?=
 =?us-ascii?Q?Vmi3uBT2sUERLK2qJwgOEHzx94UZe1dedJ6xxH2tvQBppPz85tSJChVcQ1C0?=
 =?us-ascii?Q?Bd/R4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D/1Of+/3i+SMV4rNYl+JaQ4ItXpxl3XgzBHrQo/9WRUigdI8UkRegMu+HVOkDSP/2tA6USEFZ9qIBkGANeJds3xC9hDOx4lxgm3JD8XjoMWFJG+f5f1V38/xaqk8GQX+gnSSreI/dO5NKTSTdRCwWLRS8P40eD5yrQvgBCMfZYQy+IXlMyNp/UtQmuKpI5K12TCxw8F478UzzHkV8M9yh1GC7K9mTmt6zNrT3Fd7ItfwmcDsGclYA+pBYKqC0UwlvPCn6QrIEv5jXLgCNUQRLS9i0TEW/1JyXhZSLBm7To1AUjlThjgFfRtyjk4Vei95xP1JY8PVYYCLUCync3J8fQ3eIMrWD2vXZ41vsO+xZD9p/sVrefGtZmwMsFq4y3rzJbqAD1ZhG7ACL7v4G4UjJaNH0I3Fz29JJDwGHhbzfAhuARUpHxlRNEZjmii0Glucjn/JFB/1lakgthHew0Bvaei0/NpC9nZRMH/yTmHnUNn4bpOj1RlEiQCTKnZFvwEK+48JOzOOkJE0xFGnDcX4HNhb4Lk6Fq+3aUv8OFos8RJF4k8xbrNImbtIVrouaMifMHQAixRoYPEMCcpdOLFlcQSnz0qPzdppWkJiaBRNMqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5961bd30-e64a-4483-e3c1-08dcae5afa76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 16:41:35.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2s3ND0jfUqlpVkPiQ7XAtOSUiflvs/St7DGNA6/ARKELXBNMYApIqUKRC9yOH+2kjzDDmOuncXa9yJ67d9XGi+2JbHS1NWTF0pGMf/sEVes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=761 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270113
X-Proofpoint-GUID: kOCqwMupLgrbaANq-pjmdnq2wjf6jbaN
X-Proofpoint-ORIG-GUID: kOCqwMupLgrbaANq-pjmdnq2wjf6jbaN

On Sat, Jul 27, 2024 at 10:36:30AM GMT, Jens Axboe wrote:
> On 7/27/24 10:31 AM, Lorenzo Stoakes wrote:
[snip]
> > I tried this patch, doesn't seem to make a huge difference, going from
> > 3,958,564 bytes with longest line of 82 kB to 3,943,824 bytes with a
> > longest line of 77kB.
> >
> > It seems that the .bv_len = ... expansion is what's doing it, so I tried
> > patching mp_bvec_iter_len() as well to do a silly ?: thing (sorry), which
> > takes us down to 3,880,309 with longest line of 20kB.
>
> Right, I did compile it after the fact and applied the same thing to
> mp_bvec_iter_len().

Ah cool :)

>
> > This is starting to feel like whack-a-mole isn't it? I looked at the next
> > longest line, which originates from include/linux/pid_namespace.h believe
> > it or not where some compiler cleverness + a loop is resulting in _another_
> > combinatorial explosion.
>
> Oh it's certainly whack-a-mole, doesn't mean it's not worth doing for
> the low hanging stuff :-)

Yeah I'd say getting down to 20 or 16kB is probably worth it, hardly
difficult.

I guess I resent the fact we're being forced to do this because of insanity
in the macros.. but if it's obvious and not going to cause regressions in
existing code then no harm.

>
> > Patch attached including Jens's change + mine.
>
> bvec side matches what I have here, fwiw, except I also did
> mp_bvec_iter_len(). Didn't see big expansion there, but might as well
> keep them consistent.

Makes sense, am happy to give R-b tag for this patch if you want to put it
forward? Not sure if Linus is minded to just pull something for this now?

If we're whack-a-moleing may as well sort the drivers I found in my
allmodconfig too obviously as some hilariously low-hanging fruit there...

>
> --
> Jens Axboe
>

