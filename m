Return-Path: <linux-kernel+bounces-418522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D7D9D6286
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E3CB2784E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F01DED78;
	Fri, 22 Nov 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VAaSvmVQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M2wi66M+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A5713AA4E;
	Fri, 22 Nov 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294068; cv=fail; b=hSG0cJOBdVrFcxVlvuDp8DM4uOyY26mwsPUdU67gSFdKDKNfquUt+MyDGwEs1QcAjE7IlzMp/YRNvCtAEpZGS9QXOX+y+LQGVlPMRFPrdHhM7ST5ummHy7FmSWfOtPARyh1U/YlbVUw7hNp6Qv1thctOUFwq25Lr9FajzUy50s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294068; c=relaxed/simple;
	bh=lY6BsjsqOl2L0xXyNKNBKixqTfe14GUjjtzth6BmUJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PubuRTAVQu6zRpRQPzbca6UZE68p/hvQkXpB4baww9+moGfU54mDLqQEy+OsNvWjZvdsc/aNk7BHcupt26Zbw31nujq33kKHci8Z7vefnRfidiN1d37D5mXfH37l4xUkEAsThO4wvPp97+EJEHOSv/3sqMINhdh2dtfbfC9xJe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VAaSvmVQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M2wi66M+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGBcrA003080;
	Fri, 22 Nov 2024 16:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=htsAYgsABXLOElrfPo
	YPRlk8xghjS0XrD3IwgCD0wzo=; b=VAaSvmVQbts2YGO6u37OZrHMihlXoh8SLd
	oRmrTh5R/LD+YJfkJPb2N+kPTf957H+YWiEEYnUH3n+/tP9ju2I8CG3H3GuDnsK3
	PvOuE6wubGAoq/vAgLf3Udmlm4lIc68eyw4zPgbeyfDodptQqxWeVYQAY/63caBD
	zTyqi3/9wd52PovXLFo1ovnkLxd6lkngS/baVu9s6EqAITGaq3ebYJrAh3idsXDm
	zZY/sgJYZ0BBaB83QaGTmYSYJ/WkWBPvsS7rIyKQ8x4vWy6fXJLcHF5zznITPuRM
	zADK3K12d4SlXaCuPCNKT23VD2Gnna2C6SB2NbYfuZCzsXOSQr0w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98vagf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 16:46:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMFtU7o039957;
	Fri, 22 Nov 2024 16:46:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudb1h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 16:46:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+1xgImMtJCIWa3wTf0f3oKgXly8EWJwoS5AN91jl8SsnF4pvjoWGSsJaICNtkA2+r4tFsWN+jP2NWMk/B2jfhNTU8o1yRTQwUcW6vj9Zkyqtn48emuAHqNmAfP7nHQAFWWniPnj8ZUZzYxBldOpCuxS6iUm9DSGaJ68ETx+/uGzmibPOR3prWpbpfxJSyQH8BAvEMIf7osA5wukAR516eW/6vJzlaZ01Stt+g4GigYlWOFybl2FvBqSDnhB7YUMuU3nsJx8lFg4NHNQtsbwiJxmun7P9+tYTeGXnyhFHf60ER4Jc93f6VasSJNtSOISlhoDhieGRX4+jQ1UUzGbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htsAYgsABXLOElrfPoYPRlk8xghjS0XrD3IwgCD0wzo=;
 b=J9Ek8h4dk86Mi0RwgUii6p8dYgOns+ncwmYId6IgNmpJ8MPxl6uv7g61EaZLzATsWkQcu4g788oNujz4ppJpg/IWMCrLN8t4o/YJxN6vv4Z302/XtCsG71PicYN+eluLluIM5tGOvGNp0mw8nwVzTIkQ+RpYBJYM8wWhIFxNvHbO1wCA2FEcS8GRL57hRqmXzcZWlhpvNzmOccbyG7zZ5xLE8IZQbUUi9GVEUTZgD2ZiSgEGfQQMKFXrr6TO/ibLqaZzOGRcY4rACO2EzrZ4Kzz/GagHdb8yyKobjb40L4Tz8zvhVNAvjGKLio7I1TsarplnNd+StQ+f8G5e91NAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htsAYgsABXLOElrfPoYPRlk8xghjS0XrD3IwgCD0wzo=;
 b=M2wi66M+nj2uc55gJTWNSx/XB9iYyNMnhzhXgccVSyFR6GdzV5+2T0seRNkGZidxh387SDSltSAgB+pz3V9uTbh5txJPjBwN2SA14YuvCvFLQSK2iLcS1XEmiY9YkUPkf+iX8GGr5liCBv65SKUWTtpSd4vyjjYGEEaMNk4Tg4s=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7781.namprd10.prod.outlook.com (2603:10b6:510:304::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Fri, 22 Nov
 2024 16:46:47 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 16:46:47 +0000
Date: Fri, 22 Nov 2024 16:46:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 3/5] mm: mark vma as detached until it's added into
 vma tree
Message-ID: <6460975a-46b2-481a-9073-55a5f2ac2f46@lucifer.local>
References: <20241120000826.335387-1-surenb@google.com>
 <20241120000826.335387-4-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120000826.335387-4-surenb@google.com>
X-ClientProxiedBy: LNXP265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::30) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: e7545502-557e-48e0-f4b1-08dd0b15411c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IANjeimg57WshIN7NBYF049hPwWg17P3XHtdoqcP2I4w/9rQw4/41bY2zWGX?=
 =?us-ascii?Q?CSYtCOuW54XKWzWPY18OWDCR6nCO0KQxD649G7kZXxwDemnAk47v11MbM/tG?=
 =?us-ascii?Q?CJOiGPq7QkCCewNqlItC7Mw/4MfKL3kitIwqJ5I5GkPrcMGvCGtl/jiys81E?=
 =?us-ascii?Q?0Lw9nTq6CPUF0A8QcJr4uOcZq8Cb350E3iZN/3euU8wpMhKAiwwLrenr/FK0?=
 =?us-ascii?Q?et3OMEtYc1cshTFdCno4leW5lYt4LOJTCHtfU0fDtn0+OKfxOK2YpN0+GQcp?=
 =?us-ascii?Q?MBDkjBcZHBKl01yDWvUoSK8eXoyLe3NrgGIh88jLFYkWI6sVddXeLKyXhYRV?=
 =?us-ascii?Q?CGgDrcwJ645kM6je4l3+u4EZuFH6dCPR1dJNdfio9EpxeuRTmJwzLUckjgYJ?=
 =?us-ascii?Q?4p2kAV72vI4OUo3g01/uI9cKfu84ddPMsuhuHwMZz5tKw9SsZ1sz/VLbmQED?=
 =?us-ascii?Q?lewezmf6oorRJgqSo5QOlcnVaRk526Z6Qiy0u9z+2hLvDoHiOA1HLgot9G+g?=
 =?us-ascii?Q?7kG7cp1RoEVR4yr8+2Xro5Fnn01GqfTGEGJiVDzM07K3OQm/bEkzNA9/2jva?=
 =?us-ascii?Q?7D22KxiS9Y08aBnTZLYfZGuPjmZ3Q//f7q7upv3Hl3mhHR5UwLcqtHBcpwN5?=
 =?us-ascii?Q?HLJrdF+k6rwEPwykxXVZ7gumZZs+kxgqMkrOqcdiYeICUOLwz26oKvpNKMKk?=
 =?us-ascii?Q?g6dD5OZnhJYOScLlbdY06jY2STXuXAB58xODO49VAclRyqz/GhtK6N6+6p9H?=
 =?us-ascii?Q?JxeJaOMobAJkzZS6cjmRBXUyvKHit/UwXxjJv/hqCpyta9hUItlpDe9nM6n7?=
 =?us-ascii?Q?CT6vkGeBrx6QsuF4lJDS50A/q3BSXxi84VysQU7+f87Cm2Bd3d+36RdBb88u?=
 =?us-ascii?Q?hPeLFouw1gJ/IA13Opl2zTyL/YNO282lk+wVznRM0TbMVu23AIJ+o83bNOsp?=
 =?us-ascii?Q?RODkw3LoTamXGTMwsEZBmHCr9yGogKzcX+m0HNZT4ezMbRguI5MKilWbhVN6?=
 =?us-ascii?Q?auI6xndTC5OXb2KhnUwOl7FYeFvCXvWETpciM2Tdl9sM8p7C8iyWsgAr43Xt?=
 =?us-ascii?Q?jotDTuJMOyx/AjoGocm+9KSNM0ORgs8hgc4kAS+DLCcRxIhMIO8ZIWF/emGF?=
 =?us-ascii?Q?UV2GwBPhQfJsjkeVZZCto29mZfRyW/oIM/lArb3xJwr8ZvepjSZr+iSnkCbw?=
 =?us-ascii?Q?/653rEvtC/VhicKK77cARPtozy1eOCPlhtKdWkIGdUwr7Nr3XFy6Bg3tZjVc?=
 =?us-ascii?Q?vJYD/IagxtoTfRZv4s1C/YZklrmk5iFtxG7wmLf6I3g4yngw/9qEkU/6Qry0?=
 =?us-ascii?Q?rdrZH/rIzUKbTcbFB1fcWEAlHK+bIuubrt2w5PG98ziuGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gj4I0eUy/dYQzpZvejPIjQ5Y3IrUjTSyMyMWQHZw5VvvaRFj89I11bDiNlje?=
 =?us-ascii?Q?8Rrar4z90uc7X1WT2EbSCMPCQ9rqem9J72V1zpX8OcrNVWGNZJcs7+kWCR2u?=
 =?us-ascii?Q?cjRIUs8PTEcRV2GLQ18Y7wi6o7+4w7bDOFr1yQXROCdPUlrmPzE4xEltECVA?=
 =?us-ascii?Q?4B0gR0Lpjgrc13dEtLUGx7SlspPD9DAlDE4Na7VkGOY33lUbRHGj148EcvHs?=
 =?us-ascii?Q?M1EsvUmNDsR82QZ7APxP1yET4VxeOmWtvZJxEWQotMV/N5aLs72I7Y3xXM0C?=
 =?us-ascii?Q?mRjRFb+ompjH5zMN+Erx/x7hYlT8vhUfJQqmPBu/XP8yVlivEIHQhaz1YIki?=
 =?us-ascii?Q?/HCtn49eg02cvcjQKY7/gap4oXJ6ifJRss0RqAN+j9MB7xbMXHe5v/al8t5y?=
 =?us-ascii?Q?SBlYb5/YnvkFlGoA3y+T1yk/nxir7FDOCEz2jKyNyQzXpWA5BT+YxBz99kVZ?=
 =?us-ascii?Q?09N/eGTNoCWglSbor6vzIQwwurXUmGg87QPjy09SpbxRXl2Jmxy78ME4yPXO?=
 =?us-ascii?Q?8ibsM7rMtQWvBO+uvt08N7lMB5bQNCTkG+wVryOptQCSzsOYZwPsZ4lvXIgW?=
 =?us-ascii?Q?RXfVau9w/4bbb7xkjV3oKgx07X22isE2BfGHbLVuw7Qdw5KwkTji6I4SHHQh?=
 =?us-ascii?Q?KA05eRgNwQwKYo5k5B1mavtjdHEVWG2Cfs0/SRag03ed9oIyIEDju44E0aQz?=
 =?us-ascii?Q?6RKNqE9ghXBYJGxy4rzYo0O5/Fd/6pRIGSob1Aj417pU90E+MwOYYy9ROA1C?=
 =?us-ascii?Q?/9O7BF9Jo12Yn9VLcmOI+kO0SkrEjrteoRY5Gz/MjsglB/aDpeLX51qfWns9?=
 =?us-ascii?Q?T/EXy0jI4KNgnv59qL7USPmjMrXxbRDnwutWfgV457Ju5I7dlNVRPioVHhNm?=
 =?us-ascii?Q?nfMfXdEODeG3T9KUZIMqbISgwnIXAGV15gPMvKS+uJx5r4VmeFRBty2Wo3bt?=
 =?us-ascii?Q?N8ShQoWR/9m5p7hXMEuj+n9q6IesJ+Vocal11DaGOK3LRC5/USl4lzuFkpqq?=
 =?us-ascii?Q?KRiYT5XH+QzH8HGMsHWeVzc18XuYQ3MWNHuYY4uLOMaRSuu+yWGX+IiIAJJv?=
 =?us-ascii?Q?eyWGtwZ76A72zqML4/A+CC0bD1kDxT/Er8g9r8QB0sN1Vua6GcMP7EwDCMrm?=
 =?us-ascii?Q?N4BaPAapBSlFPfV3vv7LARJDIDmgA4bwR6fpSEKVLKJVRohCpLpiRVkZn9GQ?=
 =?us-ascii?Q?9Ea3MWz79ehNyW55ajnviVdiylPdLk1qUkHseYibX/nyvpr+C/mUprPxbJtn?=
 =?us-ascii?Q?SbiKJwA3elwSLjyke3QJMDqjM3mrY8hi0NCltSI6yRpMfFj+JcwdAVusBCyr?=
 =?us-ascii?Q?M3KI8waXjcdnc1llVOr4m6MPzciIHd7wlyeI7JrzX2D5TEF+gCaGYS7vdJt9?=
 =?us-ascii?Q?nT+WlhMMWetNxelhEQBIrRa8Zsyl3uLLkcxRcB/HES0BlWyk41UHPe5nObnJ?=
 =?us-ascii?Q?sGFMTKuKViURHU9kd78Yvyn6eQm62hmOOdFWNENegohF8b71fWqFym1Oy7Z3?=
 =?us-ascii?Q?khVtcI+nyiI3p+X7waZdl3tSYkz65llRiO651Z4cef59N/LaK0XoPPiQQIKI?=
 =?us-ascii?Q?7Oggoy+mBCB0lMMrL+P5UMgAL2PIieLbBVK/WKpmF1Rx2IeRDPFdqnEppfmW?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sqFwcvhUGcwcwuthV6wJdVtk27fOlZwm+6ZwMWra4H+w0+sh4rOTptxFc8xwpT2uFO00uPH7waJjPUR3zxPltrQ1nfIoyn3gGpJ+OWgmuGM3+B6P04UHY/utHwLOLkdcTUpqrdk4Dz5mrKpmvReacGHvoBW6guZfKjBP/Ud6jHxTWvZCEVDiq/aMXtYgDKIZ6+DGPKISAdBzu0fBvj0dmR3gVIGZrePUubVBkZKFK/NyRoibml2eA/U80u6fJDmgT6ssRLI9SbDNeQDFZ1GCkbVE2m1+8pJU5tP0XwRY0XSzPNEh1InDXut58+ZR+uGj4/GLsqb9k8SR1W1OyYLYlKUcHJ0E03M+urUZ+tITC7bZINo7qwJ8TFGjdlA/WoghlcfBakxqwEblgZ1IBE9aUX20uAbYro9fOMHGSZ/bLulQD5jACo/7rqrw2T0FC4rvzBYgN/EuPoE5ymgEhHslVAwJ4sPUbe9O8l5678fbVIcHW0A1qw59sVrnnOjEtLWPYZ+bCr+hI7lVgPxx3vuxMmI5H1pm3oDWHSuFKUA3MAzL4G7xHUdUmsHOgOgxybcyB7GRyQoSE+gD4WnArlwmBCHzOMKa0klIK32ygdF8pcg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7545502-557e-48e0-f4b1-08dd0b15411c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 16:46:47.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tnhgEF1wtsUJf+aD9ToUKfSWzXmnUeu5hWWRtmMw9jXyKboVD2bbprkgRKg5bXzrmFDa2/FkW2fhKFP5+u7ZkfLcdA9BghIiGcDEIr2jEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220140
X-Proofpoint-ORIG-GUID: YrkOqudzDwckwZb4duwQ8U84zPV6sXcl
X-Proofpoint-GUID: YrkOqudzDwckwZb4duwQ8U84zPV6sXcl

On Tue, Nov 19, 2024 at 04:08:24PM -0800, Suren Baghdasaryan wrote:
> Current implementation does not set detached flag when a VMA is first
> allocated. This does not represent the real state of the VMA, which is
> detached until it is added into mm's VMA tree. Fix this by marking new
> VMAs as detached and resetting detached flag only after VMA is added
> into a tree.
> Introduce vma_mark_attached() to make the API more readable and to
> simplify possible future cleanup when vma->vm_mm might be used to
> indicate detached vma and vma_mark_attached() will need an additional
> mm parameter.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I tested this (whole series) locally and on real hardware and did a kernel
compile on real hardware just to be sure :)) and all looks good.

The code looks sensible, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h               | 27 ++++++++++++++++++++-------
>  kernel/fork.c                    |  4 ++++
>  mm/memory.c                      |  2 +-
>  mm/vma.c                         |  6 +++---
>  mm/vma.h                         |  2 ++
>  tools/testing/vma/vma_internal.h | 17 ++++++++++++-----
>  6 files changed, 42 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 737c003b0a1e..dd1b6190df28 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -808,12 +808,21 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
>  		vma_assert_write_locked(vma);
>  }
>
> -static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
> +static inline void vma_mark_attached(struct vm_area_struct *vma)
> +{
> +	vma->detached = false;
> +}
> +
> +static inline void vma_mark_detached(struct vm_area_struct *vma)
>  {
>  	/* When detaching vma should be write-locked */
> -	if (detached)
> -		vma_assert_write_locked(vma);
> -	vma->detached = detached;
> +	vma_assert_write_locked(vma);
> +	vma->detached = true;
> +}
> +
> +static inline bool is_vma_detached(struct vm_area_struct *vma)
> +{
> +	return vma->detached;
>  }
>
>  static inline void release_fault_lock(struct vm_fault *vmf)
> @@ -844,8 +853,8 @@ static inline void vma_end_read(struct vm_area_struct *vma) {}
>  static inline void vma_start_write(struct vm_area_struct *vma) {}
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  		{ mmap_assert_write_locked(vma->vm_mm); }
> -static inline void vma_mark_detached(struct vm_area_struct *vma,
> -				     bool detached) {}
> +static inline void vma_mark_attached(struct vm_area_struct *vma) {}
> +static inline void vma_mark_detached(struct vm_area_struct *vma) {}
>
>  static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  		unsigned long address)
> @@ -878,7 +887,10 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma->vm_mm = mm;
>  	vma->vm_ops = &vma_dummy_vm_ops;
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
> -	vma_mark_detached(vma, false);
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* vma is not locked, can't use vma_mark_detached() */
> +	vma->detached = true;
> +#endif
>  	vma_numab_state_init(vma);
>  	vma_lock_init(vma);
>  }
> @@ -1073,6 +1085,7 @@ static inline int vma_iter_bulk_store(struct vma_iterator *vmi,
>  	if (unlikely(mas_is_err(&vmi->mas)))
>  		return -ENOMEM;
>
> +	vma_mark_attached(vma);
>  	return 0;
>  }
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 7823797e31d2..f0cec673583c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -465,6 +465,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  	data_race(memcpy(new, orig, sizeof(*new)));
>  	vma_lock_init(new);
>  	INIT_LIST_HEAD(&new->anon_vma_chain);
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* vma is not locked, can't use vma_mark_detached() */
> +	new->detached = true;
> +#endif
>  	vma_numab_state_init(new);
>  	dup_anon_vma_name(orig, new);
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 209885a4134f..d0197a0c0996 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6279,7 +6279,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  		goto inval;
>
>  	/* Check if the VMA got isolated after we found it */
> -	if (vma->detached) {
> +	if (is_vma_detached(vma)) {
>  		vma_end_read(vma);
>  		count_vm_vma_lock_event(VMA_LOCK_MISS);
>  		/* The area was replaced with another one */
> diff --git a/mm/vma.c b/mm/vma.c
> index 8a454a7bbc80..73104d434567 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -295,7 +295,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
>
>  	if (vp->remove) {
>  again:
> -		vma_mark_detached(vp->remove, true);
> +		vma_mark_detached(vp->remove);
>  		if (vp->file) {
>  			uprobe_munmap(vp->remove, vp->remove->vm_start,
>  				      vp->remove->vm_end);
> @@ -1220,7 +1220,7 @@ static void reattach_vmas(struct ma_state *mas_detach)
>
>  	mas_set(mas_detach, 0);
>  	mas_for_each(mas_detach, vma, ULONG_MAX)
> -		vma_mark_detached(vma, false);
> +		vma_mark_attached(vma);
>
>  	__mt_destroy(mas_detach->tree);
>  }
> @@ -1295,7 +1295,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		if (error)
>  			goto munmap_gather_failed;
>
> -		vma_mark_detached(next, true);
> +		vma_mark_detached(next);
>  		nrpages = vma_pages(next);
>
>  		vms->nr_pages += nrpages;
> diff --git a/mm/vma.h b/mm/vma.h
> index 388d34748674..2e680f357ace 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -162,6 +162,7 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
>  	if (unlikely(mas_is_err(&vmi->mas)))
>  		return -ENOMEM;
>
> +	vma_mark_attached(vma);
>  	return 0;
>  }
>
> @@ -385,6 +386,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
>
>  	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
>  	mas_store_prealloc(&vmi->mas, vma);
> +	vma_mark_attached(vma);
>  }
>
>  static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 11c2c38ca4e8..2fed366d20ef 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -414,13 +414,17 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
>  	vma->vm_lock_seq = UINT_MAX;
>  }
>
> +static inline void vma_mark_attached(struct vm_area_struct *vma)
> +{
> +	vma->detached = false;
> +}

Yeah I think sensible to just accept that sometimes we are already attached
when we mark attached.

> +
>  static inline void vma_assert_write_locked(struct vm_area_struct *);
> -static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
> +static inline void vma_mark_detached(struct vm_area_struct *vma)
>  {
>  	/* When detaching vma should be write-locked */
> -	if (detached)
> -		vma_assert_write_locked(vma);
> -	vma->detached = detached;
> +	vma_assert_write_locked(vma);
> +	vma->detached = true;
>  }
>
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
> @@ -431,7 +435,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma->vm_mm = mm;
>  	vma->vm_ops = &vma_dummy_vm_ops;
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
> -	vma_mark_detached(vma, false);
> +	/* vma is not locked, can't use vma_mark_detached() */
> +	vma->detached = true;
>  	vma_lock_init(vma);
>  }
>
> @@ -457,6 +462,8 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  	memcpy(new, orig, sizeof(*new));
>  	vma_lock_init(new);
>  	INIT_LIST_HEAD(&new->anon_vma_chain);
> +	/* vma is not locked, can't use vma_mark_detached() */
> +	new->detached = true;
>
>  	return new;
>  }
> --
> 2.47.0.338.g60cca15819-goog
>

