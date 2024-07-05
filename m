Return-Path: <linux-kernel+bounces-242885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA7928E61
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D581F2581F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309CF144D3F;
	Fri,  5 Jul 2024 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mpo6qb+O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F7xE2SSJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E89208A7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213020; cv=fail; b=ecXOh9GRYift1TqryoOJFaaOtVnp2CqyezGBdcDoV4XlsuTIG0mIVMV5ps1Ma8Cb3rBhts8fgb+RkQbhlKNXGpsqWALMchDpPljDp6xlSAtv+UMGljovTldpRiqgjRgmQ0nu8X+LjuyNQRPYgsRGBjxJqFYIbsMVwt5p391+FoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213020; c=relaxed/simple;
	bh=1V03H4WH3HWj3TiBYJzuHkXTVTVQB0LmyKTED9v85ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WHARM05pjCT8RfZgs2gb+OfGH+8a5l1RHhvf8iY4B7eOM7CY+W0ChVAY1Mel9eHG9RBYkcWqpUhfOzyu6+BRmceHicWbUTnShxW6z8BVFlwqUyTFB7gNAmK45N2s46SsIqYx5XeZrIlsOqzyAXYGC5K5K5g3o5boX8INYN7NrHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mpo6qb+O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F7xE2SSJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465K7Vmc024115;
	Fri, 5 Jul 2024 20:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8ZRcYTA+TUlwnHW
	tnxcMPEiIfblmmUXC3huWOEfvvko=; b=mpo6qb+OiY7vfI/OQYl+FJvkWWmDWyD
	8esOQKnYl19mZdP3xnNAroVqLeXy5yqla2fekI5FZYeb6ZossOQx3OsZoCdBjtT7
	hoUsPa3IqNMsLS62gz12JYlqDyR1DPfSoX+glnys5gucMbtojHGb6tdU1CtlbwHX
	RYVQ9ot/J3ehCZ1NCKHYA6J8beXpb0KFEjjUoe0USvGVJpiLk74DsrDZO80f5RB9
	0tRsOJXJFOBtBITKY5GgUBXo/FqYV1K2ln9bjOz/NgIeP7D9teD1oTPnKBA/MHi2
	LH61BA+M26AQjSsDUnBU1ZUCHQdkMxZd6jcxj/ZzEpBeiZ5UmkF7BPA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacmndf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:56:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465Kc0XD035692;
	Fri, 5 Jul 2024 20:56:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbfg93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdERNIT+t/TGuv+6YRSL7UJWRytHQY3QKC+U01qc9Y1jZmKp2gMcXSEaNX1cyvO0DuYRYjtUAtAlBgjaALrO8g2YtNnSeA18/io32mSgSKQpLPbHDF52jD4dzXyGBTdUHMeYrhMzfCa09CzVzn4K45+gsndSGs7/66Njbqjf7X1kiW/VpHNhOc+hH4nlA78N+zHisix4wVkuLGve+tJdvcaFqUyPELG6DVg+BOYdGXtjNCnJ9Y7LdFJ3jzDuORDt9t5/WT0xKYnBwkp5sd1f9UTJk0Muj5UU9NMcmz6pgasxnYvX2cO/BfBqIER1KnnU7xMH+4I69VvK78CKjk6qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZRcYTA+TUlwnHWtnxcMPEiIfblmmUXC3huWOEfvvko=;
 b=kWf6x2l9sfkcOSy7YcURSBVBd24klYTjZgKLs5hAThBKKodtHkKRuhyU4m/Clakk92WYWg9O4mMjNSnsXO/dcKgvC0wTfhx2uNnfLNBFpEOxNmoeSrPJAhdBfSYR8EKx5Pzm3C9LkX8hbwxZUUplHNn6wcG8EPQFrYXrxPFYgE5lljS5opDgqTuwhTPGjwNJED+3zuI956LY15smVduQp7HdIVsdwR8NkbIU5TBU4pXlH97aQhT7f7Yzqyf6kBPz9Q3r9xT4n/WbnADBbmtjdImRflDzIflcbGaySxrXn7Iw9V6P38UGGxopV7orkU/+6L/45uWRZBKL8hsSlwAuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZRcYTA+TUlwnHWtnxcMPEiIfblmmUXC3huWOEfvvko=;
 b=F7xE2SSJwgoavj/FWlQ+e5Up5a0ncCN8nFM2I6B0rKHYwdcqMd1FNfsFFy5VIaAcUURlkdqxDwK1rhAY+ukVcPiGCS8m04kGhTRtBKUIr2buvuOHGw45wOdauFVcO8rDAI1W6fBVIE74lSa+cCwrBbwqQd8rtLHXDs+TwiQie/0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN6PR10MB7441.namprd10.prod.outlook.com (2603:10b6:208:474::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 5 Jul
 2024 20:56:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 20:56:37 +0000
Date: Fri, 5 Jul 2024 16:56:34 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 10/16] mm/mmap: Reposition vma iterator in
 mmap_region()
Message-ID: <c7vcig3ee4n3zpfev3tbv5epcsdeue5it3joi22iwob5vx24sg@ypl6ienxns76>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-11-Liam.Howlett@oracle.com>
 <76625760-1fc6-4c81-9df9-ee47697995ff@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76625760-1fc6-4c81-9df9-ee47697995ff@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN6PR10MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a70d697-e8f2-4c46-2ee3-08dc9d34f629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OzmMdYC6qLvyJ62R0+Whho3oKFR2YMoI+dmqa4138I3HbD7CBcvLFGOos4Rf?=
 =?us-ascii?Q?MNx6BpzEApZyTySw0x88RpUZoU0btD76m2WYUQtd/LNagjaCGAy7biPBczZu?=
 =?us-ascii?Q?U5WAWAspso6+9jcrSlh4Ba3yhmn/EW/+zgE8LcgafknHmpJq6bAwTvEO/LsR?=
 =?us-ascii?Q?2nNA4kyY/UAp4ztjKGG561mWrwXTK3Wh9FkgipMov4kNL1p7GH5+ihad9kn1?=
 =?us-ascii?Q?LScnntaW7gbrWLRVK7rpjeFomW5fBOFIhBkhCfB7fWqYhXmFZUMU+a+ZGTVO?=
 =?us-ascii?Q?efrNnh6Ksl9yyNX+u9nx4w0+AAL0otxPLoZSfcNdrI22sUNGBrz8mmOKkER3?=
 =?us-ascii?Q?ayONz9kVCZqb+EeO+Na6/rjOocTDYEklMtWtI3S29JzU9CwnK9A+1qyiQgHS?=
 =?us-ascii?Q?M3hjLe7GdOh6C47lr7awVcmAk+Y9WH2TPt7eFQ/T+CEVcu+Y10wZwOMJBKfL?=
 =?us-ascii?Q?dOIJujLYm9edvy5zphO/GUB1R9r+JZL3QivkhMYZcLmAr61mpOgpZz8sDek8?=
 =?us-ascii?Q?lWHQjexNtKuhhoq0yJ86TzW7L+fByhx26RRGOVH5TIEa2pyLtCyo3vmAHHUY?=
 =?us-ascii?Q?4uuP13JCvgvkyFDbZe3v4eX/p3eX9tXcn9nSFG7iX97wjB3N5r6yED26j7Ae?=
 =?us-ascii?Q?zDXUiF41qrpKb+6W1NzhG5jjnHRerHo0HY2nsT5JZbeTP1mY0f0IV8nvKuc5?=
 =?us-ascii?Q?oMFnULzDh+FiJymY3mUf9HzBt+8EBEjN8l5Gm1hEhPCHxXCDaSCFE9Mg6Ih+?=
 =?us-ascii?Q?pS1PB3ByUZnZnVv7/pPK9OBt5Dge7gi9vN+3wOG3fFnn1uaTiAfD6ejQZwWL?=
 =?us-ascii?Q?RWw9/eQextmWC9D3Cqa5K4bTTROUmnDiURnci2aOfLlMSoIc095c888/7v8Z?=
 =?us-ascii?Q?fEhlAHk5u8DKChMNKJFg5WYjArC0uwa6rORfOMcuT8yAtu0eI++FBGev4hU/?=
 =?us-ascii?Q?ZKrtIf5CpNuRCYTZO5L7XOUQtS0wBTRQTolqYjxGau+0Yq8RUl6NSktqhXiB?=
 =?us-ascii?Q?OdzvC2SC+J7P1HyWeCod1XILdlYSOLboDy4LfhXVN60Yie3b9AOYBjiSbuF9?=
 =?us-ascii?Q?OlRpggMPZm8d/8ZZEd8cp3feuKFmph1QHXPmyKg/37CL7Kn69GbK2wfMVBHQ?=
 =?us-ascii?Q?gaaAq+X6GxGle7/NQ2DiF3HC8COHqYZj39BTwAxEou6caBQWkqCVQAIsy1iF?=
 =?us-ascii?Q?lgnE2cEEIOXCi/vILNPpjVSze3Q7C9dTdouN+grBXc1+DDso7i9jl+fm0tak?=
 =?us-ascii?Q?8jJ8dM9GWQQ30OIsYjF6X1YTESSofVy4Jw51OcaV80rW38TUky9hB9vqqGoL?=
 =?us-ascii?Q?Dq/jNrMeABOSSJDBZ+RuM5tYtRZrSTb3F5Gq2/kLcMmFeg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KLSmkiuSKWLvrEchSYbMoRtplmcL/6PYnE9o+xtplz0zIkYoRtDlMm7f1FDx?=
 =?us-ascii?Q?4zxDj0hrmu/OU5EFTFAOCT/89OcemUJSllSx/SRP79+w3svGL0SO9ur2uiuX?=
 =?us-ascii?Q?JBq8ESbORb4/g5Xb388fIdGggsT66xzEsDnQ+mAijw3IihGMPfQv93Itmo1T?=
 =?us-ascii?Q?AMmslZr/wn2c3AEhyqWkIMNvICztnPo6bA+mj4epCxHlQ19BAM0CizFJF76A?=
 =?us-ascii?Q?x4YA1tOoaElnqkqOenPwcmv6+p3a9iQQ6NxMrhLtidUIXoRbd7V23fh6AdiF?=
 =?us-ascii?Q?puCEHzgQkAhAmd3G9LaXz1Z83KeXdwv1vJw489pbvIipaAcIwL9G1itu5M/h?=
 =?us-ascii?Q?14q7CXXg3jSTD6aa3MHUQm9ZTIpHdu94kccZBNiNh2BzB1GUvOUzXL/ZPGZd?=
 =?us-ascii?Q?h1AYGoPzY56oPatD3Wo5EUjfLuoeinh+nbRWICfSvOaNkzbSgqNd4QTPwb8E?=
 =?us-ascii?Q?4TAQzgEBuHL8MK4L3QAMANbauVcRt+qIqEhDaweQdBB8CWE7Xjssk9iszvgw?=
 =?us-ascii?Q?xc4+8Zs8+WfkieksbJHCmg9s5pSMLB4gF9KvNka/8QIcW/mh0/EbaO9vKHM9?=
 =?us-ascii?Q?fIZHsU//yX8JcBTYV8t++ZK3Xkq09xKJ62q3L3Rxp40JogsHwrW3ntol4IpH?=
 =?us-ascii?Q?W552/S31UwS7ECmLGmExSVdMEJSMJMClp+EY+pXj2PUiVW7QAR5nCvXlmy7D?=
 =?us-ascii?Q?fmesHcgbMoPkSn2Gy/Qd4pcPPaNFI80Lv2yOqn3598flHZAhdIkdeNNGk5ao?=
 =?us-ascii?Q?bA9g4Bh9qnehsSvHN7iVMwySlp0Yus/ZXcOTGbRd/58iaxxnUZpn6QCrPdW/?=
 =?us-ascii?Q?T8b9/K/LeKey8hLp5L5sEENcyL5JkldVmTIe2+UmRIZZG1a7LTxp22ceU2WP?=
 =?us-ascii?Q?GSGJ9M4bM+FeQdcC+RGhKPFP12L75HbfaabISBZU5eObksUmFsbX7oRyiGCx?=
 =?us-ascii?Q?dUXzxS1Q/iBhGpxrS0yueCjtCmseG888/ktrXnvwiX0XSgCBm4ELMu6Ywh35?=
 =?us-ascii?Q?HK4yAWeoZL/cya5/MyIzNz1L4C1kYgCuesVjtySzdMDNawjSAyzmhORC/C2b?=
 =?us-ascii?Q?WeyujdmKRRtBbZIjT1prnUJw8Xk9q4u5iAlk5tdcSD5xOogUdtZiItDgGWj4?=
 =?us-ascii?Q?jpCEMv4yIfFfN8ejW2cED4DzNIfWkNhVt5vTwqpHvhZ1uLkhYs6s4/+5SZQ2?=
 =?us-ascii?Q?ThSWW2uwK1HyZzHmAP1oj5V/JALzp96voElTEQZ3Cz8w38t7R+NpRz3uQLrJ?=
 =?us-ascii?Q?RGOpjCgH1qGXh5QHIo/So4dk9+hA35HaEaQREUH+L6ztB/zcE79QjgcmpzP8?=
 =?us-ascii?Q?pJWd/Fo27EHc4sYl46nV8eOsiGcAhnE0DpDaO1zTTF6X9PPTgQ3rBQjaC6el?=
 =?us-ascii?Q?SRoEyLt+YQ7Ea0lXPC4rs5h2tnppGXWoargbe8ezmdfAtkPQ+CS0bPTaLGk3?=
 =?us-ascii?Q?4EasT+jcFq3/GhhRfvOvG1bi0ygRsWBFmYwOQQ99AWDspOsaQDbNBn5CJnDb?=
 =?us-ascii?Q?mZ0NWpCbPURxstL6895QAL5Rtc62hxNaINgTZuC5woFKJWaNFM0js4CNydgc?=
 =?us-ascii?Q?ARD8Dz6aXnuEqUfOlVWdTRcsYSsDQKb5kuz8N9mb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FuZy2Hf+WERgsdcvMwy5qNNoLT3o6NY8ERUXzK3rxm2xHzoarUlqgSlWTPNYhk7fmG3+T3H19f5mbMLfe7+8DUMiVNOaBmiC2krtuv5Khl/Zi/gA6QFFZUhe9/Bszr63P1mWUfMVNOTu/r0zIrjc9t1LYRYmco9RT3eF50eZvNxbZ/yjfCPfyVS2IHWW82mFH49sY7w1kE6OeqwxXU3tMkhavqflv2hbTqhaCKiNBUOcwB7mv7p+YtG93eFVDES/boV5Nf/RZ4oUbPxye6/NUgMbPD3YGYakH0/1wqPS4YLWYPQyHtx9qP3BlO5l8LEfho4JIGIJmSh8ajdT2R93nzEi4EpNAJyE87iBEaWYKUX3hfvxPTHRnwAw8C/OoqL1GkywKx9cFvWkKb0MGKXQogb4Cc8GLSap8CMIMyhDkLrKEeCn49uGfRBoQ8Gz0e6HK3AHdwJqi2aVeZ5uTVdlO6L6kw+bH1kp5xXF9V7iiMcbjSOaKwBZbFiX9kpdVVsJM1eiHQvvi1N/CXzUofcgcUB3UqwsjMN/gCp4W3JLWXnKqLxF3lTvouZlu/1K8BsO+dCoBenFUMtojtqVo6+5ax6+K0NygU3IUUSpLKwG95g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a70d697-e8f2-4c46-2ee3-08dc9d34f629
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:56:37.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAnC8QmMzSe8il3FZxFLYj5u1971SsNrYmMtVMXEQZRhom6r76Pfbw9LfkVFsEfWIFHmObaPCgU9ltWmHjJdbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_16,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050153
X-Proofpoint-GUID: EetoT6YiUsWHBukqfjAobSxYtVyRs8T4
X-Proofpoint-ORIG-GUID: EetoT6YiUsWHBukqfjAobSxYtVyRs8T4

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 16:18]:
> On Thu, Jul 04, 2024 at 02:27:12PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Instead of moving (or leaving) the vma iterator pointing at the previous
> > vma, leave it pointing at the insert location.  Pointing the vma
> > iterator at the insert location allows for a cleaner walk of the vma
> > tree for MAP_FIXED and the no expansion cases.
> 
> I mean, it's funny I litearlly just asked why it was being left pointing at
> prev and I guess this answers that basically :)
> 
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index f5b33de4e717..ecf55d32e804 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2963,11 +2963,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vms_complete_munmap_vmas(&vms, &mas_detach);
> >  		next = vms.next;
> >  		prev = vms.prev;
> > -		vma_prev(&vmi);
> >  		vma = NULL;
> >  	} else {
> >  		next = vma_next(&vmi);
> >  		prev = vma_prev(&vmi);
> > +		if (prev)
> > +			vma_iter_next_range(&vmi);
> >  	}
> >
> >  	/*
> > @@ -2980,11 +2981,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > -	if (vm_flags & VM_SPECIAL) {
> > -		if (prev)
> > -			vma_iter_next_range(&vmi);
> > +	if (vm_flags & VM_SPECIAL)
> >  		goto cannot_expand;
> > -	}
> >
> >  	/* Attempt to expand an old mapping */
> >  	/* Check next */
> > @@ -3005,19 +3003,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		merge_start = prev->vm_start;
> >  		vma = prev;
> >  		vm_pgoff = prev->vm_pgoff;
> > -	} else if (prev) {
> > -		vma_iter_next_range(&vmi);
> > +		vma_prev(&vmi);
> 
> Why not vma_iter_prev_range()?

In any situation where we arrive at prev being able to merge with the
current, the prev->end == addr and we are already pointing at the gap
with addr.  So vma_iter_prev_range() and vma_prev() will do the same
thing here.

I thought a lot about this (and created a small test application since
it is so difficult to test vma merging right now..).  If we do not clear
the gap, it is possible we will be pointing at the first vma in the
range, and not addr at all when we call vms_gather_munmap_vmas(), but
the loop at the end of the gather function ensures the vmi is at the
correct address (vms->start is in the range). So the result is that we
consistently point to the correct location and so these two calls will
do the same thing.

> 
> >  	}
> >
> > -	/* Actually expand, if possible */
> > -	if (vma &&
> > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > -		khugepaged_enter_vma(vma, vm_flags);
> > -		goto expanded;
> > +	if (vma) {
> > +		/* Actually expand, if possible */
> > +		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > +			khugepaged_enter_vma(vma, vm_flags);
> > +			goto expanded;
> > +		}
> > +
> > +		/* If the expand fails, then reposition the vma iterator */
> > +		if (unlikely(vma == prev))
> > +			vma_iter_set(&vmi, addr);
> >  	}
> >
> > -	if (vma == prev)
> > -		vma_iter_set(&vmi, addr);
> >  cannot_expand:
> >
> >  	/*
> > --
> > 2.43.0
> >
> Looks good to me,
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

