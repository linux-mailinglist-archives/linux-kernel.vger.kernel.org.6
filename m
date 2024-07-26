Return-Path: <linux-kernel+bounces-263064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E50D93D091
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF3C1F21F36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2E17837B;
	Fri, 26 Jul 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YVaB1GLz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O0NQLmnB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80530176AB2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987078; cv=fail; b=XH7TZKT6eAINm63MiGOIlm5IhsYxATbvU5UiH6EmhaHW0Ywi9uc13lZt99fA6cXZe2IEfrSuQ9v0nEEiLml8Eu26Bw+OQh0erK5ueOP64tvfW0lh3aVfDUEyxGfh8KhyiNp7CJps9XUoffGiw3fef/aY0cHQF33cTVIA0+1Bmpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987078; c=relaxed/simple;
	bh=DjCYH61cSaYkeHnJ79Wfcad2K3QdtkQ+a4ussvHw/sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9jKbVfiz2R7oQ9E5DxNWJm0nhmMH2tI7o1jCloVlavg9E9+IVzxJM7/rGjXKB+TjKIjIEvCNrist/VJOA3TiFghqwAXOWEe5ZU30Bbb/CiygtKGUfQlVwLLoT7HvWJmP+oZXxy0QY2582yvnnJ2JmapRIOJVzeJK/mnZw3dOts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YVaB1GLz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O0NQLmnB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8tV69026115;
	Fri, 26 Jul 2024 09:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=SGCc/oCB/296qgZ
	SFllkrj5xh+K+si01P17aypbr1lg=; b=YVaB1GLzm9ujNgkrU63q9Izey/jFk7C
	JSi2QRS4OKO72iiol27kC3RfHbCOS1J4onYbLpiM/s66LYkfkMe+oxy5RBYiglNM
	pvbeIm321xHCP3ZyjxCI6cc7mz9BumexuPmdm8Wd26xlDU9e9Q1+/6Kl7h7fCrAH
	sHqmPjl1whN7WjKw9Gq3MWS95U1FIAhUzhWdeRMGs0agrbdm+Vk+S8wKL5To51/M
	2x9EkeaSuCbh4ArV7UderNqbplzbDjWCLpcJdr5Li8FFv08cIeWLkvMUKD8iQcsV
	4NqpgkGwVx2zfG9cfFpifTfjxfbliqo3TK13KZRIZEMjWvukglP3XTw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe7nd7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 09:44:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46Q8dFoD022147;
	Fri, 26 Jul 2024 09:44:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27rrv9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 09:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niU0n8npAFMeqxEZ6LTE+WPXRbIgpQB+ANx30A9+Dn68fvNIp+eVA/MsEBNfeu90OUR3ZMY5QGRcSgQV9UdfgPvy9eAWSfzyq+GpYcSOEAPtJt9t9XDKJgK6jkyxEGFN1qCVWaIAyDlEaeAwIbP1GbaTymgAyn3uZKOUCxyFX6sNR7SkQ1jfaWX5hllQnsro87vTZIzK9kPEwzX4oXbZE+3zSrVeBbWs/UysLNZj/qA/FrrYkFvbNkaE53OfpWw7B80yAh3btqJLsg3yh+oxfTZOG5fNYUm/XwdFawOSCe7BuQtakzvR6gfY11cKFbU/9b3RVZpzBtV6PoMopoBl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGCc/oCB/296qgZSFllkrj5xh+K+si01P17aypbr1lg=;
 b=Npm62E9g0S73eBlhiQWu53ynJ81TTrdKy0fTgf0DfO8LM7U7Rk3XYGGhGfughyuXPXBaVMMLiYuryIjCTgukH0BqLjt0+moniWbAPtB7kc5cp3gVCvpIDLuSQIEuP/YYvgJDsxTo4ipJBwbVeDx3HTkfRBm29qWsK/mz6/uhOvZF+qHLUT005N+oTO3PhtfKy+b3uUqTsfAi9peXNQZf01du6Fh0tcWei7iYnL9RXcJpvp1ImCLg+eadkEvntSZST7lH8KYEOFrKjqIMjVrzwILgoVO6haque2i/Jt8uuSNkw638LJAwonSqcrspMbIMFoECkjqRMzxpywD+9g4q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGCc/oCB/296qgZSFllkrj5xh+K+si01P17aypbr1lg=;
 b=O0NQLmnBtq7fIEDxhx3bClQPZbb41YTehRPgCigaaYDH0FrDDkM6TCQ/pAi29G+vx3el0VUOfglMklu2rZHqzdvEPEGDL3Z6vfpxs9NQgS20Lqj85XWH0oVjtVI1f3LlZ7moPDugaDsqrsftkeVjZDuS2ONG+aJl0kr2eL/hk00=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6020.namprd10.prod.outlook.com (2603:10b6:208:3b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 09:44:02 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 09:44:02 +0000
Date: Fri, 26 Jul 2024 10:43:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: David Laight <David.Laight@aculab.com>, Arnd Bergmann <arnd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 4/7] minmax: Simplify signedness check
Message-ID: <d48ce3b3-9173-4309-aae6-96be42327f97@lucifer.local>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>
 <ef130c0a-b82f-472f-8c53-f7ef4c236c44@app.fastmail.com>
 <CAHk-=wh_+muDANgpjC6_31QMh4OnKEOgbZiD_MymHxAHRZRyqg@mail.gmail.com>
 <5a129d04e0b84b48ba6c5189a047ac8f@AcuMS.aculab.com>
 <CAHk-=whLcr11D28vu2NotZYn3GNH6BCTK57Zw4d4v7eut39z=g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whLcr11D28vu2NotZYn3GNH6BCTK57Zw4d4v7eut39z=g@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0368.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: e082c5fb-8c62-4389-80df-08dcad577b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLsCCuH6tRNvLzl6dCfCrDcdVN+KCNPR6fuPm7YiW3becQNJe/fIOxQmZuY6?=
 =?us-ascii?Q?k5ALYjUo1XBHLxeTLh0dSb7vlr14Xd/vq0jqLpohz+wmwCpzzbS8WfRybzMY?=
 =?us-ascii?Q?FiESJgG5mKFk5klXhh3QB2GZbiw5hPxpxLVxHIeLIWEfEtam9EWTl/ArFS+6?=
 =?us-ascii?Q?ebbJwi4gfLOEN400hWhEn5dBe7NUnDW5uFtbpYFutaRA2+6O7Vlw1SLyM/Kl?=
 =?us-ascii?Q?eCR83+EGiEMHpabT7ypICywOiXKp9ZVszDJobYx+478WH95/bCbFhhNL4YfA?=
 =?us-ascii?Q?ZWWp2YWS2DCVT6JTAR9LYOC6E7qrAzoHF+kKLyQs5urupu3uSUwufYSm59i1?=
 =?us-ascii?Q?71M6Z0Wb1EkZbKAFBZvtGiJuYCUaD4Ga13VbNHqANjOYx30eu+4j//d31b+B?=
 =?us-ascii?Q?EumWwAdioEWwW0yYRfYp7kopXVz96BGYmTfBw22R68j1eCEhG5wf3TOkaF6O?=
 =?us-ascii?Q?CPFKmjHdfeUu1uJ+gibTGaNyTEzNXzNEO5ZH1jSIAH2F2AqHejlZkPRx36jX?=
 =?us-ascii?Q?GRDb9mC69kvqX4vCijQR7UfsZmcHyK9XBFl6ZbQOXLN8ongMpYPp3m08VIeL?=
 =?us-ascii?Q?ueu7RSJrKFYcgHbfVHYKwNMwv1iOrFTcFs1Uo7EiR+K9sEGQM/3JIcZ6K/O8?=
 =?us-ascii?Q?NUOFcVuChkTNcyjyLTwneL5/xDf9KhoboReAg8QJaVPv4G4qNAuQx1AxCxHZ?=
 =?us-ascii?Q?f+OHc6DZGQS0diJRwORsqlPH29YxljTt5J5XJJoIDk/L1Ye9f6l76h+ao0G4?=
 =?us-ascii?Q?7DtTnEkc0FHTKEAXJayOPGCy5pRUYhI3AL13tpd/17rEa8GF+EnskB+Ay1Sz?=
 =?us-ascii?Q?t1GLbdqN7TXxggo74ZhjWayHlUClJ88Z2p2C4sqXbr58bYx0IOzt7GM15Nop?=
 =?us-ascii?Q?CCYbWuyp0IRrQzq235qv8cLaM9Y7JVPV0lq5/s6E+nInFGVD66WY0Ncaelmb?=
 =?us-ascii?Q?nLAvg/gwKckgqCliFgvKRgvoEeZHFdDTfL2KqCo78hh7VUFMbBmq7LAO6Wgt?=
 =?us-ascii?Q?/nK2zJSakzofSQ5mmNLAhiid7k4ZEuAG33C2ChczfKk07QoqHWv2XkCzLGyA?=
 =?us-ascii?Q?4hBD61WeGx604q86lfczaLIB8X+E42VA3y/Y+/B+5tL9cwgiUcD9USSUYfr5?=
 =?us-ascii?Q?GpY0b3j83pFTDNiIUI8ZFwL57PDwDfMhxVC9WiugIzF2CvW5vk9nI5yTqEv6?=
 =?us-ascii?Q?QecXOs1xmoi292Maa2qzvC3SDtNNyt33AkHSjKd8A+XMzCzmKlEaT0EWRsUx?=
 =?us-ascii?Q?FvuVXvw++ja1YyMVx0HcZP+z2F3ksq1XdWT+KKi3gkpMNZcSE6HxfKActFtZ?=
 =?us-ascii?Q?nB+1qL48kzyqDki0F7F9aM8Z1YB5GPOJd5beo8ZqaiiJkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fCmtIWSda0yUn1g9pP6LvupJbh5o4FqSsjjZTjp+X2fj1CsV0yNAANvacic?=
 =?us-ascii?Q?JFi64u1MkFlzP0U++HY0W6e1xIOWQ54S5R0uBsa7hg6WDeb2bcajC1tIHBOR?=
 =?us-ascii?Q?QYJBulqvPoNLte5BbTaoLhYOHS2MKtDBTMGgzgFeZ2oze4uwRZU9BBgn0hym?=
 =?us-ascii?Q?9ravVi0LAoxqjvS5lqx7P2JddvnE5WmcwYzmOBFkWo11AvL9Zn+2rkNRd1g8?=
 =?us-ascii?Q?Ml9XqcTVsxTcIRTIIST2GU2H+FldnkHfeQaWfk2c6b4Wb0obQwxa7r9qAq36?=
 =?us-ascii?Q?aon0iapvl6/enu/GZuU3yHNypGUjCzGa+G6oMkAY9FkDouRRHK3HgrgPRuzt?=
 =?us-ascii?Q?1GwQw82A5dcukGe77gJ0azp5mZeWoVIcQtLbP/Acy8JG/3biQcJr1TvWUHIz?=
 =?us-ascii?Q?w4D9Gio/w5tsMTKLHGAkvhYK/dgTC/s3RAgWzmfBjtc4pHVo2uHFkMZ2Wqe6?=
 =?us-ascii?Q?D7lL9JMW6pwZlfJxo6r5dC0Hpry1oluFPTSoocSN/z32Wtmiu5zf6Qsx/dKo?=
 =?us-ascii?Q?hf/T2Z8ga2/nGLnNWVkKPLbaxL6csuAucj28GcdG/U9UT1maSXKWnhbF3SKi?=
 =?us-ascii?Q?/027DFqTeKsPWWrwFTcr7TcglMvfwe0NnAKVZH3UB9pMfjo32/C+pE6JZ4BK?=
 =?us-ascii?Q?LDd0UATcBUcd1h3RyqHq/PSZLOsj2eyySQak4G1VN7c9xtISFPUYQOj0iSIi?=
 =?us-ascii?Q?JmL0Yo4BjDbmRRZCJMimL5gZzS/6QERdf45LH+Vbgk5XXkTOQhg8kGEu8rC0?=
 =?us-ascii?Q?nKdmc2b51OSZfcTDRghvh4uJ3h2NdO/URfEZkRuskqsRA+jcV1IwwYW0nSPO?=
 =?us-ascii?Q?0gDoAS+dC2V0X8XmaJ2/6howjv9tj44Yuin+MabfejO5Se3ucvJ73RZRFKw6?=
 =?us-ascii?Q?nl7+0WItGO7enMBZVW5cNwa6svSqko1PcZdLVF/xSJkA4IVPf7OPAxAkd49Z?=
 =?us-ascii?Q?ZXPIX35MLjjP6w8hQL5R6qOvHfXYGc+7gfsRnoo37y0929OoB1wJLR+syX/I?=
 =?us-ascii?Q?E+0Lqdh+JHzjE/HenC6MlbQMn3sunzdD2wPGfsyt88pTrLM8Ck3Fr9BdeC8I?=
 =?us-ascii?Q?Op6YnELJAEYPD09fDY5knes38uVLVYI1OFXZFT1S/Tfhcw1BTYoZbdjhNda+?=
 =?us-ascii?Q?QS+DivzHkG4FMQUiA54Luqes+upAwnEeA/rk213W4d76j9SIl5NsGVuJDMaF?=
 =?us-ascii?Q?dOYcQ2me9mDZKb5Ttcj0apNgO4zDTBcQsgDMItnYW7Xf4mL9RvRf5DrUpmnz?=
 =?us-ascii?Q?oB3UvXa2go+Di2sgj9oVuA0bF7FbAvRHg2rjdRwDnxwqE0hqPLqp/FFOjh2W?=
 =?us-ascii?Q?+03QnXqyvfLb7Zb63xUvpkSwes/XWSt2CsxWOjwjsqOQ75RV8Om7jeKzO32M?=
 =?us-ascii?Q?djJcLuClmQylXW8l7EkVXNmxy4H8c5gRkkVFHSfBDwuaZbo1q76YvWX9apdi?=
 =?us-ascii?Q?UuyKIRIOiHZiJO2ZpVtO/9nr9Bd4wgFVsI3Njuwn90vu9WB4f2QABhWHYUzo?=
 =?us-ascii?Q?uI5oNL9FlC8tB1gE0oR5rddlATRVIl2P+CrOc65TG3kt7iDft7PNMU+74G2h?=
 =?us-ascii?Q?/dfoHICuAcZcI2BFKd6+naEaFN1zbsNnWWTYrEBL5UhyFm5ZB/6MdpEjecKH?=
 =?us-ascii?Q?WvhTP1P85TR6opFciiYlsq3ABz0nweV6MBzfgSu4i87OT13ykgOWR7WrWQC5?=
 =?us-ascii?Q?oiXrQw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CtU6ZTFGhvzFlGeeEAmeFvkeo8uQ2ccfdOQyJ7VPCJtkBOnyBkhVfMoiLYgx/3IvNfsSDKYDey3PpSb7DVE4L+QgYyODhSEhLd3bp6i+or2hNGmR2aFoOoeeTQL3fx5joAB6AAMA5gaTaH4c4J2F5UgxcqGqIQAGbSe/ciH6jTflOEJuw6bM3gt/Vco1cK3sZV+CbNXuO8gl/3pL/P2opK5bhzziGkkTo+lHm2yMuf08UbouThvHGiVYrjaDtipHxXsghWJGOXBa4EaCEXglalwhexP60PLz+a5piLYV2dzINKVaUTqXMoikDuUbpNzQ6Y2Un935gZKPD2MybRUyxWCE32VA38ml4ImvIID0xn8bXZk0sJVnMhYIfzD9LARaxp763eUWLa7O59bS0rp7jAjMwgmD3EAdSdO/u13wymdX4a91kf5k0i9mM1hHtmJfY/AhknB9M9V0HRrEYKo7YcKISjbhgVdK6PvNidvxZw/r5b0YUl2+X7QaDMl5FjXYUoyo7ZhHBNM891FouhAM6MNwzIOHdNFvB6VT3dJjYDPjl97TmfXmPUpZCqqyx7+YaOxgZnhHVZjQo2sZTy3WENZSSKf/1+PAbbLvsyRGLtU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e082c5fb-8c62-4389-80df-08dcad577b1c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 09:44:02.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2epNlPQv2s+JP1IcD1xwWrKP3CVoEWfo8tMsKCgDPAgDjR3GUcQRCbB3p0yfI4x5gd4rLMwY+1pj91TdpWOul05ptl8WGpCSsxEC/k7rxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_08,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260063
X-Proofpoint-GUID: ePo4O83pbHKiR00TvVP5qDSWFIpbMdYd
X-Proofpoint-ORIG-GUID: ePo4O83pbHKiR00TvVP5qDSWFIpbMdYd

On Thu, Jul 25, 2024 at 10:02:45AM GMT, Linus Torvalds wrote:
> On Thu, 25 Jul 2024 at 02:01, David Laight <David.Laight@aculab.com> wrote:
> >
> > The condition is '>= 0' so it doesn't matter if it is '1' or '0'.
>
> Yes, but that's because the whole conditional is so inexplicably complex.
>
> But the explanation is:
>
> > That gives a 'comparison of unsigned type against 0 is always true' warning.
> > (The compiler generates that for code in the unused branches of both
> > __builtin_choose_expr() and _Generic().)
> > Moving the comparison to the outer level stops all such compiler warnings.
>
> Christ. This whole series is a nightmare of "add complexity to deal
> with stupid issues".
>
> But the kernel test robot clearly found even more issues.
>
> I think we need to just go back to the old code. It was stupid and
> limited and caused us to have to be more careful about types than was
> strictly necessary.

The problem is simply reverting reveals that seemingly a _ton_ of code has
come to rely on the relaxed conditions.

When I went to gather the numbers for my initial report I had to manually
fix up every case which was rather painful, and that was just a defconfig +
a few extra options. allmodconfig is likely to be a hellscape.

I've not dug deep into the ins + outs of this, so forgive me for being
vague (Arnd has a far clearer understanding) - but it seems that the
majority of the complexity comes from having to absolutely ensure all this
works for compile-time constant values.

Arnd had a look through and determined there weren't _too_ many cases where
we need this (for instance array sizes).

So I wonder whether we can't just vastly simplify this stuff (and reducing
the macro expansion hell) for the usual case, and implement something like
cmin()/cmax() or whatever for the true-constant cases?

>
> But it was also about a million times simpler, and didn't cause build
> time regressions.
>

:)

>              Linus

