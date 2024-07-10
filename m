Return-Path: <linux-kernel+bounces-248160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA692D908
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FF5B24A61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81845198A32;
	Wed, 10 Jul 2024 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5A/wOOY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S8wYpHUs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E51198822
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639429; cv=fail; b=eQjpkc8QpmB9UTzeZ+QZ312GG202uWyKFSQu1+QhahfCHctPJtEuDDugaQPYx2+hqRWM9izCz10GLaR/E9ROs+FIHRaOvjLqI95ZFmsVz8RlZmKBVfTFg/bdXlEUy13cxzxMxWBRz2MwTMidzpa4spiltQkwV6wymLc5VkJlFSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639429; c=relaxed/simple;
	bh=z9lPIBEB8h0tkNv8hatUxAW8h6cpl1NOiwc80r4ThwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2QcJhrYeArPPXka4H8bLkHbBGqCm2DMW8no7W+rYfwgJrhzAVNpVNyBsaf9PMGdm57h++00sT72JaRb+hD0p64ViBMgc7ky27TtWfWb6+Dh14Pn0ipOPCJ8XIjr2B6EgvZHLPhLr6YqrX0wEvzk/5JgANQaaejQIcoQNaYrY6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R5A/wOOY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S8wYpHUs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFi5PI019322;
	Wed, 10 Jul 2024 19:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=W8ePtixmHK858Jxwt740eyTinrn/Sv9QWh8NJ5u4sOE=; b=
	R5A/wOOYY8Qatr4JlzU3ePjjPB1w0R/rAO2qJK+MfnF6N5dmf5d/axwTi8vYKfSh
	1+KVxMnDt56T6EutjveE3q8j/7+b9l/veCO6sN2k6PEptCNVmwsFLPkJO2rjteQr
	ZfMhrsnRF0hflKV75iNYQe3EkXzSymw2dXpJDZHX+sBxtTHvl68L+tGeyAautazX
	Yx1DeEvLClVgdHNpmhbPNEXi7V1l+p7gnOVL9Rsm4K6l4vI/HnlytUR2TmmBAHAy
	SROli0D+05BOEUGNn6hJ7aCziQfkjvSsargp6wcJkVW+n3f70jolT+BOGocm0qrp
	QrO9steOzr2oRsqdJtDmVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky83qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIjker030110;
	Wed, 10 Jul 2024 19:23:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vva92t4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl3xzpuRhts1DvEVy+xkFcdeU04eamOfXqhn4URndKPr46JxhBEbvuTB5zrNEOCmh4fMaZ+m4rYyxbiV80RdqjGUCOmxpxfmeIL4JBJ2bIlAG7pQ4Dq/bW5I8cCFsK7UHJQU1xlXfCzDvW1IOslHxO1le8xtKBWdWZPR0R3XaX9M2e8Cb1iUKM0lFUTay4h2e7+7ljHNd2nKQL0i2amW0WPXhCh3FdHCez3NRKcUF9RSEmHxBgSnJJPtnAmIC1crs76UKtnLt5xCnE5VTQCxjZRctAZd8UtTsMCNfZQyNRHjEOtT9GPYQT9fIw+/vvNmQexlrsqtv7cEGSVjsiw3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8ePtixmHK858Jxwt740eyTinrn/Sv9QWh8NJ5u4sOE=;
 b=Ntozs2hctpAFV6qseL7qZTcreXO44Pid74OLpLJp4t6vkvMUPyZpVK+TbatX/Vuxx8Awly9fS16H5EFaQ57+d8Pgf/k4sPptFU04rEQZXnWLAO4AnxV3mSfzubHnWwdQusLEN5mRbKwtSmsa2cpaR/p5KFucBBunFcOMI2rkiBLBiBLVKP0Qe33hXac6plBTJGn8WWZlqcptldVx0GOFq5xfz9+etiX3qxQcO3j6oPhBG59G1qU+mcp2UpmoYNZPkAP6v8x2cLnAm4+cGojTDUzQjh7OlM2UPa+yybAjTV76m7OrmissfixXqlQVKrn45sdnJfUneA74g5pLPolmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8ePtixmHK858Jxwt740eyTinrn/Sv9QWh8NJ5u4sOE=;
 b=S8wYpHUsEemp/h0DlJ737ZjXHmZVKo8F0CEJdAzJNwhltLz4ayN3gIa+jQ1KFLXZrnujc66jJL03/Sb7XHX9KH5WJn5NgVJBYzhOjKCOgVBtLRHhcvu6k0xdK6J7Agw5GWwPSy67ticxagJ3yTvHFTfOC53YV/W8gJSjvSUHRQE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7295.namprd10.prod.outlook.com (2603:10b6:8:f7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 19:23:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:06 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 04/21] mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
Date: Wed, 10 Jul 2024 15:22:33 -0400
Message-ID: <20240710192250.4114783-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 008c11c5-6327-4eca-bcf4-08dca115b9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?F/9PaqLKZOucEMDReCZg7S8HIYF5SHe3YYStYeJq8HOPOWeFtO3/fl/pl7Y/?=
 =?us-ascii?Q?W29UkuwyaeJbNPejjuOvfDXqm8cBVCKUyhqYp2ne+QWg15sHs/kBWQNgRNAX?=
 =?us-ascii?Q?Z4VI13FihpXokcH05wHiQTibmNlkC2f699zvZGdxbtuJC2Zs4uVQ92eRizSl?=
 =?us-ascii?Q?8ShmsYRWYxvH3pjkYb61varMORMMepkjXC922/8mnzpCjlTvPL0+EW40tv4o?=
 =?us-ascii?Q?nuLy7CaDgVJtq132RP/Cbg/9P0v27gD9WUYeAW5yX6T2pVIOG9cT7I5bC5S1?=
 =?us-ascii?Q?GCK5PUqpN7ElOGpSEAAkbVFLnu0i9jUW+tJqKO3kj0c4Nhu0KWxCR87ReSXU?=
 =?us-ascii?Q?wlrrPr/ut4MzrOj6DHM2nttam2DGAJtP3H8Rw5QAieoULeKP/6582TiWHr5q?=
 =?us-ascii?Q?Lo9hLNayedFpdF9OvyAbOttx+5Bv2zes/WUJtKQVvEQ8Sl1+k0HSjcPPq+XV?=
 =?us-ascii?Q?UiRdDHw4z5AFGQhJAh4GTnPqAihwX67QwQSMyIn0iO8zcGqC5CoXc4DkmD2H?=
 =?us-ascii?Q?COHh7d7XzM6WYTJYpULTolCWohMpehnFKG4uLu68SGsRZvQdwRo3dcKo8PTC?=
 =?us-ascii?Q?MAU3v2a5hbBtuQ//r7E24m2T2bSxbprXWLgocfurAay5E6yBIvtRlNDG6FeG?=
 =?us-ascii?Q?SnzkF/ZuEVpfYb2/5sJf/qM6/m1s3v5Z4zJmiVCIleHpn3RoezUxeJNSRJ7v?=
 =?us-ascii?Q?tyjh4wmYjEFe09gaWVbNtU/9eYyLYt32u0vYA2L2C5vW0S0XWbhS5cIyvGgj?=
 =?us-ascii?Q?JkzaX8sLxNHDzjiGcCl0BErAKRAdC7gO0k82df1C6z2LG5JkLOY+9m//Unk1?=
 =?us-ascii?Q?IOIWTXjo5NvyCLV36vf59r4miAIRvvPg9Y5dogKzb9ao6tMVY+V+0NdxXFju?=
 =?us-ascii?Q?a7nfKfuE3yo8qiMSot5yVEzeMLaKoMLP0XT2gHcEwvFcJngGV7EaNLRQC3/s?=
 =?us-ascii?Q?oivaiHaHgFT4enPfSQt5pTyM9UbMjvAYJAg339dDdQjFrqdMg+YnKtfxJwFd?=
 =?us-ascii?Q?zV+quDiZXl5RZn1BVD+nPFMO2RLmOGMa9ncm7VFGrHe0i6jZmK+plG1262TG?=
 =?us-ascii?Q?dC4TPKh1QLlZBN8oZeDuarvK2U2mk7mIFVIXuxRTRdNSP4UGJnJDXSv0+ERh?=
 =?us-ascii?Q?92I0Tg35qzfSTtvVRF6wsy3WuSW8vQswwI7GIRoN+2pNd+HuKoZSt+DNstVL?=
 =?us-ascii?Q?hHFoCGmxmV4DjcC851q8Dir/93lb2JABvMXhmSJZJQSI/ODfRG+qrhP8fUbT?=
 =?us-ascii?Q?WFbdt1Pru64zA66aWOBB4oArgpPdv432eFgzGszOAqj0iu3ghzSRJYbYf8DT?=
 =?us-ascii?Q?TGqMzCu1bBn9A4Ubtz9VlUxQ8QEOxTNxe1ZX0j+RpqSs2Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mGCCFtVikbShfEpWWl1dHjefbeKNRoO/P3nbBZZ/GptBATTx2eAMEsgpTx0d?=
 =?us-ascii?Q?twRAOZT9wqssNzWkU2c9TV0lb1CfnNoxD57IbMOYOXhs7K4SdeedjBjqWOya?=
 =?us-ascii?Q?5Zb8MEKqvVV85fT/WzGKtR9fLtSVFAl+pV5ft0Lb4mCojaqDgFn5xlRrvGQI?=
 =?us-ascii?Q?hL9hxH7657vdyiVISpzGh8G3tWJYXXNA5vlVYPgkaC+cXbt74S/7yB+nfIUh?=
 =?us-ascii?Q?EpbUX7/HyWiwvcNqgBPHREffc/aVBHu9rEoRuYvmCkHEp17+RMK/aZk231w6?=
 =?us-ascii?Q?bE7WhRV+fl9+LYKnRChfH3TubjYaewHd4uwj442+yIRUeOsJ9SiuuN+h07NK?=
 =?us-ascii?Q?Z3ctTP91kyaD6hNIn08VFxVYR2crLu9J7ENoUqpoFDqFog/29fsekAEZhKIz?=
 =?us-ascii?Q?J9uN/sNp9Se9Cz0i0ZyT9TmGMa1/uC+RVyTGmLs84bBNPI79R9qBcMUQrh7V?=
 =?us-ascii?Q?wqVIxuj+vVEL1ax1WVSz5djsHURLYn6eVQrlt9Qk7ncWobY/Y+Kcu6XlOMjj?=
 =?us-ascii?Q?JJSLMwPlopduggatJN/f3S8e78hQvU+3lwGP1DmZc+9rNBe+c6nxW+JFeR2R?=
 =?us-ascii?Q?gKo+0XAlysMrowqi7w5eTjv+a2h7asbqKNDIgqawKRDWfsNT4wpf5AAAj08V?=
 =?us-ascii?Q?EJVLyLbYPCWG+6HCShbC3yderlCDXWWsrJ6B7fR+xwCDlUmouVe1jgLuJfTC?=
 =?us-ascii?Q?/pjoBBpCN9UQ+lNSAgDp+fhnr2gTqjaL79wFxwa3oorQNxK2NULWL5DUdQs+?=
 =?us-ascii?Q?chU5A+8jSMDiIYinWpTH1i75DKnelqKv31LkzvZ2eQONVbHr3haNfqYmLV+X?=
 =?us-ascii?Q?LRcRTk9FxA7iRCJiWgL5T5VsC7afdTDyH05l2euM8I/B0AZrfz7LFB8kihg/?=
 =?us-ascii?Q?yNOpdzpst6PrKnHO+r4unrKPvvKt9JVapC5arDxmCtUBWX6TksnSNvldE8fk?=
 =?us-ascii?Q?5gvFxT/eLkAj2Z/dtGZZvwPhETJWjrFUebWN6pgB6OXZfz+eAD9WQPx/+ZUH?=
 =?us-ascii?Q?rF0yQ23ABsoLz1GWOvlVtBgzx1Aym9QJlVIH4C7OaiTS1jLA0kPNPxKpa3xM?=
 =?us-ascii?Q?gfeNIcqgbAeW4x7e/uANUm42POG0ip7fZlmxk2Q51YQ/Z5SmjofoKVdNFAkc?=
 =?us-ascii?Q?1GDS52BtXcJ6bKHyLfb3ewzE2d+ELBowANkW79t/Wd33oOtVl0Em8f2PERZh?=
 =?us-ascii?Q?u0mgJtDPmYqxFGheqyAiLHa0mF/NBfi1N5WV4vC1uh6usJ1/6gMryHBsDcar?=
 =?us-ascii?Q?/DdjjzysPeTfRuMbsuvd4//7eAdmaVy6Krj+OgtROEpns6DUwk0acRmJa0Qp?=
 =?us-ascii?Q?aNyIkucDjVGPiDq7VRhd8l/2xcywwrBRwSAmwDOPS/iiT57JA5033P8tSZ+C?=
 =?us-ascii?Q?l8D0+WT6AJO+ArGyxw0Tkdkrq0MUdiMVuQh5luGO8Xvt4ziqHYKRxJ62Dhss?=
 =?us-ascii?Q?nIfmqvpQiSohDZ3N0MNy9G1akbu9iX2R0nDDy1Hmn6/S/0MwOUkAXqBQKgaE?=
 =?us-ascii?Q?rWvv8nMyQsrIF96KLf+T63YeweDobBjx1lckeV113siq+6HSO29Bhjetkw+P?=
 =?us-ascii?Q?ug/10+cEe/ya+VjNFY8Kfn3tfKDOFv8hudBhjmqPt1cRqCMg794y3n/HGD7T?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4rTPG9VBrLxGjbt6naD39oT90Xz/N0yim7HQM5pUFAJxTMjckqZ17dQwGwvaZFDevmeA5y7k9yBME71XEIjHyxdO71Mqh2NdcQqC45wYnOuIyKn7d6dRF3/B8lzulf+HKmlOpf2Z7p0+hxrqmNQOhs6WypQNFj9xoKH3g1Im+ZZsozsqniSEYr53MIK8yDngSbRb+B6ZRcteC2dCsCfkcj2TmbbC/cpAafusIupxKaDvohsw9TTRaxjbqEh0H0OH57O96V/pIXjqYV9VStNfcrPZa7w42JlZu2IanrYWGvM3tzDGis/JNdrjXlcAM6jxlSHByepgBzGj0FnwOXjXLWt3N+1WaBljNbKZtMW7NTT60tKSJLM2GcxuMJgCpAIARWSiWZUbUnwUbM71ff2NBr9pzooiaeRlBMVDC+weIZXjAFq/b/+Hafhkia+9yiCkbhyX4WBuCxSSd3alwMDiP72Hg8gHigNIwaZZR/l/IrhPqSRiKZ1SqGZD2duzdIiChu0ZNyo2EqetGgO/Ej4jN/QZD/a27ejZ5m8+mP1aBYOSKX8JJtg7azXQVU21vFfrTKl2yR4QF8rzZAnpO84gSw3w9JI1DU13Y2EWZG1jwlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008c11c5-6327-4eca-bcf4-08dca115b9d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:06.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWVe3LxpoStddjeTgqamNVRoPfI5zRl3FSUKKzOWRHZWztj+goPi7nKNxk08aqmCaEOtfnQZJ1+B9PHda9ntUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: D7zIRJzmtCucabQKyIqMWmuOrFFmyYTV
X-Proofpoint-GUID: D7zIRJzmtCucabQKyIqMWmuOrFFmyYTV

Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
detached maple tree for removal later.  Part of the gathering is the
splitting of vmas that span the boundary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 80 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 22 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bd3378935c70..0d03fcf2ac0b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2655,32 +2655,30 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * for removal at a later date.  Handles splitting first and last if necessary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
+ * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * Return: 0 on success
  */
 static int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
 	struct vm_area_struct *next = NULL;
-	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2719,15 +2717,15 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		mas_set(mas_detach, count++);
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
+
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
+			*locked_vm += vma_pages(next);
 
-		count++;
 		if (unlikely(uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2752,7 +2750,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
@@ -2772,6 +2770,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);
 
+	return 0;
+
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+static int
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm = 0;
+
+	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -2782,12 +2822,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
 	abort_munmap_vmas(&mas_detach);
-start_split_failed:
-map_count_exceeded:
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


