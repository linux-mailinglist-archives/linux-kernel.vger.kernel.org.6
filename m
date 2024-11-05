Return-Path: <linux-kernel+bounces-396570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A29BCEFC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AB2B221E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4291D95A4;
	Tue,  5 Nov 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lt7fgawd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B/AAFbIR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A01D54F4;
	Tue,  5 Nov 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816343; cv=fail; b=aF/BG3tmlotqMDIVeyLk+QZkizTKVgSXkk7M6DqqjTN3g37DiSHsHd5bYL8P59N0gNtlCadmgfRCt/1bRwmwRuzIjhFy7TRtsR5cPHQkXoRLJD2kjpmZ+w3WdSelp0bSeJPHB94OQMdwDY1CjBIiAS5qSj/EZKYAJswXfZUX38Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816343; c=relaxed/simple;
	bh=EfnrAyz5U/F5ZbGdcygB1JTF03owORDExwNHBSEHG68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gHqw0q8/mQOh/58TYnoX4/CtKFSce/QAnwtJalJK4tFDdiX9aibndBZ3auLwKfu86cv625OgsfSxXttr3emtMZK9dQeLGekKJ2SCFm4pnuitiLykEi8fvfXA05vSQBFqJAkIbKX/gPabYyTVt+yKHymnQ/Uj8Ad2z4edKG+8i8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lt7fgawd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B/AAFbIR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DiWTw030789;
	Tue, 5 Nov 2024 14:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=EfnrAyz5U/F5ZbGdcy
	gB1JTF03owORDExwNHBSEHG68=; b=Lt7fgawdJKuLSIXoh06U+8snyGCyH28S50
	FTnTpZeD7Fsqn4eUShHxCDWkqz2c0S8MnTOi4hE1yXPAVc8sWYU0UtgG1dyMLdva
	RNzpRznOEC0Kw5nmAUXixLYk8vRlbhKRIvKRsj59TgFSrKqbzNfJ6u3owkBMhiY7
	HxFjUwzoJWA/mfAqnahxXRki3ddJFCvI7zZslWeG6IQQKTSrH6xCzC5bnJ+fl4VQ
	OEs/NO83FfShO0iVhE48oHMVLtBYczHZtLXkGimvRycUr/S+9PtH+31/gRlip5/g
	FSjkpiWjuYREPIwa6uqGml6geyUPCjeJvQmaRtYSh8lT9tzaX+tw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpsndk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 14:18:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5Dm4Fj005170;
	Tue, 5 Nov 2024 14:18:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87akp7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 14:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVa6am38QpJo27Fzi+1SwgvKL2JLDKxx7LvWz+KwQxHDoopRGurxazVfWB26nbJp35uLQXri91W93z0r6RA4tlaKpROSpLs9ajwKSUNL9HLexHWsUiYnwhQ27F4avGyf//KYJ3ZWaahPU31Aw+fpixcpc3iphrrxSNNr6JIBbAur9OfmR5ZsTr/IMWEtGwAiVKGDr+iFkuWb+M5HLoy5M3nfSxo/AAb/6otTZo+yS0p/KOtlwN75qTSC2UZWaauec7UAErDi9sg0TZixQdyStmbJTWRgB8yoNH+RX5i9JRptT3K8AVLM7U8o8yeqL/Y20D4ZhgtovA91X3K4k2TZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfnrAyz5U/F5ZbGdcygB1JTF03owORDExwNHBSEHG68=;
 b=bfF9ys50ZN6dHLffGgnKSY0HHIZihh2U27zpVBHaR+8vLq9JoYuhGydhMRFA8+sgxM8Fe4TbHzHtIwzB98oOoojxFdW2uYPSZdqgtmz68t4/Oysak72rXuRC8tjLC+vM2Md/JnWUeWWSoAu0mW6izPOiVclt5hHzfHSHmmNsAt8b6kNZj7JFvt+7aXf2cNSqMJJzjn/ERFMvBNWRQY+uBIuBIeGk1L8T3Wzw0abWqH5wTZFg2tMH1VFs2opdE6EqB4HkTNipGmckY7GM43pn+MPRLyrd/M8V5TqGgJVYCdg1DlRL8GFnEVPo2GsKPDYHO4LHqpOSz3iwuJpWiWUwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfnrAyz5U/F5ZbGdcygB1JTF03owORDExwNHBSEHG68=;
 b=B/AAFbIR94XPf9fDJCzpxff0VI8Xi32lozW8wcbe8dFBd1JpdDyI1a9z+gs75AYKbQtdazFwjB+zE4dUSUfDfr6rdYtHq/OrU+4hpY3JCj2mmP+Q0sz1zPmbF/d+EACzoqGbde7Rz+xnEB3LZeueD9BzOyzOLHk/AkftqFIvvWY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB7313.namprd10.prod.outlook.com (2603:10b6:930:7d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 14:18:05 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 14:18:05 +0000
Date: Tue, 5 Nov 2024 14:18:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <441f3ae8-1e8a-42be-9f65-54ccf58e3fa3@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAH5fLggUZJpmSd7F_k5bVKs0-ErK_74-zpWgMyWHX4vcSM-8Lg@mail.gmail.com>
 <e41dcb48-b59e-4d70-98f7-da18fafba31b@lucifer.local>
 <CAH5fLggpEezhR_o+8RPmYix-JLZ47HwQLQM2OUzKQg3i7UYu5Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLggpEezhR_o+8RPmYix-JLZ47HwQLQM2OUzKQg3i7UYu5Q@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0438.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: c18e04b3-8631-4393-5c0b-08dcfda4aa30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wnemb9M3QJXge/o9wJSBmaryOFxIkyVPjztT1eXmUH4Rw0HDuZdS5LmoOflZ?=
 =?us-ascii?Q?3PLBhLBmBFpgqUkUMA4r8qgmPhH47/m7vzmzXS9+7ggYawP376J84LGlt/Kb?=
 =?us-ascii?Q?J0nmeR7u7vlLOybsJk23zpPoC63VxvR9A+8coaKmVqXByIpULakdML92cbec?=
 =?us-ascii?Q?PbsOblQRS8kY71dpT+/RDmnL9nsncOoKFzDrc9jz/Kjf3E+OXlB7mmcr8jYN?=
 =?us-ascii?Q?XbRIphkAm284jQ407afQ4hwP7nZLD34+mlXP27Ok0TLHmMRBIJPKqawOq9Zk?=
 =?us-ascii?Q?4PUh/lx7xeeSlxNFzWqWjXtLbn63qpBUhk/mEQzK6xOWP932uIn4as06dK+Y?=
 =?us-ascii?Q?aUTkT2UV7NlDYLAVBI1tcFW7OmJtasuyK/DDCCjEi5Yjd+WYncCDwvtbYuDx?=
 =?us-ascii?Q?sAc6f4HcdWhtuLjnxgy6diojsKwvUR1AU+OSc54CJkOoRp+uzqmg8+7zZ0Ji?=
 =?us-ascii?Q?uJgSAQQHhutvXny9rBHGg5qoCOVhw6oG+6KDIwBOM6XpFnwNpsNafkJXJIuZ?=
 =?us-ascii?Q?ew01RziPaubBExTbEUNj09UGfj9bdxn2xMN7/INKNeqNtoK4gsn8IzZ91zSq?=
 =?us-ascii?Q?gOYD7HP0+OBiOkqu8wcIkd/ApekTWaExUyHGZBXJBujWgqu7OTMeAFLAd2tH?=
 =?us-ascii?Q?AhFSsG4rQuJ1nQt2D0ZhVTX+6Vp1pQ+RrrsSNVe7OUR934my9i3RhsjEU1SO?=
 =?us-ascii?Q?2nc2dr7BBM0nG5vJchVLEsJqnJUMK/IXsCBdRI7DCLAXQTUf+c7q/avUHBq1?=
 =?us-ascii?Q?rIizmK8S2slFPun/puw9QcYVHbxaaQHIliCNDKwOepTJwGG92RKeXqyPQ8h6?=
 =?us-ascii?Q?iHLOdvcXkcZ0STOZRxTQVbMoGcQwTtUAV9h9+kebr7ZQjFDD2rj0V+zvW9/1?=
 =?us-ascii?Q?fs8IB5yJzC1W4nh+47zwxT5iYGrqaXcOA8hdJ0iezCmeqEho538gcJ7vM+1q?=
 =?us-ascii?Q?F3r/RbodvC8kqbJX8uFNQZ/vG7gYG1LhOKa4mxnqz9hiq1Usc8c2rgx5fRvi?=
 =?us-ascii?Q?XvuDjmhiBE/5b2jrtsrFaWi4q//T+v+GF8D16cgbmlbmswU68XfhV189mGWC?=
 =?us-ascii?Q?nEYURN0QvL9q/jKYK1f3kG57MJtrIawZ7Hm58HUF6z311AFTr4bUDus2b11l?=
 =?us-ascii?Q?VUQw0SziDOhX1+/AH/BF6pz+Ma3bJiq9cSzPD3iD1UCMYY20S7MYzAUriRrD?=
 =?us-ascii?Q?kDtDYa9h/0VRi3H3zux+NYaQuPe0uCA/qdf19cazjARPrs9plQsEApdohUh2?=
 =?us-ascii?Q?bqNydNhP12+x4LgKAcxwz7/iMyBC7Ri5eipo0sdrD4qPCzakb+oSmN7B9UL8?=
 =?us-ascii?Q?VS8k4mscfVLk81qarYhsWMc1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VyVhXTzFm+dSzFDzxE/3MHAjqZNYQ8ggis3FmxUUldVZoaoRTEA3TMZJPK6X?=
 =?us-ascii?Q?MCw8AcOUZR36BW5Dh4ct9w5+bdoz9jQuUvi5NO1dkTFW0DtMZ2UuedohnLGX?=
 =?us-ascii?Q?/iKqACzX7uiSxuGzWiig0i9SDpfPWszCu0BUZ6dOiHhNX7F/SqzXV3/50Cxv?=
 =?us-ascii?Q?AnIWU4ZZBVYUZLUmwp0+m7DskzWreti1asNsqaltZn47dvb/0IjFzG4MlfS7?=
 =?us-ascii?Q?nMbixJZEwyVjA1tNR0xcY1PdyBfHn0wlK4smgf8ryQzgstcDuAULWP/2sc+i?=
 =?us-ascii?Q?NA8rz0DtIDtUebdR2Gyxz2Kat/byIWD9xsnurk7Pe6b6QjITsaYN2oS0UqPT?=
 =?us-ascii?Q?a7tpH7S1TehLrquoEt/yCyThOrXNKPsbjbIHZbKmsVNE3ltgr/R8raI/hz8E?=
 =?us-ascii?Q?lTUeufJIp76pzBGqT9UhWIEH5IS0F1IUC7NtfBSWZYBKPm72XpzL+W7Q7ikn?=
 =?us-ascii?Q?g4fi+FvBSMt1W0s04BrPCLGYVkltP0jghtyGL/EZfrQVMaUsEkxJxzO+rPWt?=
 =?us-ascii?Q?c4lYywMXHX5nlWvH7/eLZgn1C/Ydga2gJb8ZNHi2vnYX3deds+KLPI7gPQXk?=
 =?us-ascii?Q?+yCZMxzaPnULyNsPO8olskRofmBPVOE3cL7J0ewkRHP8XcIuElgGFbMXdr/w?=
 =?us-ascii?Q?Zw2U6zZDhWrn5slUyUnCoH3MT8U4k90SmnQChdJaQzbnaWag8K2zTzmA6wy6?=
 =?us-ascii?Q?mGERYWrx6nl+jO0cYmSUT7dWj84XX3HHJ8RRRgrn+tTu2uy+whRUJPDHIlrB?=
 =?us-ascii?Q?hGZr0HlxW/Ic8A3MiwHN15cWzYDmvlEHlgvQBqAC+8xmJ9hpzzMYhUnB3+aW?=
 =?us-ascii?Q?l0ZkuB4RSydqy7XrA6a9ZYMYtUCcg1Ip3OQEzIjK6jC/OjPtBfx9WABWL3aM?=
 =?us-ascii?Q?Z3oENHaTmf5+uJYEcu4yJC3Nv3DHQk3TTg+6ICrCk5HfGu24OKakisu1iP4E?=
 =?us-ascii?Q?+px5SEsKYPMdB5zAt1jnWZ66hdgv95JArkVuRn/ptDuhB/SgLu7lek96MdUV?=
 =?us-ascii?Q?loSBEW+YU/B/9LaYIbEiPVC4IyYkvQiI5ruojfYZDOOd6sF6fsGsBVjozmhr?=
 =?us-ascii?Q?7fnSrxN5JTK875Np48zLN29KP6fdJ4RUDWU/Up4YBArkhjmk94Z0kGrkIxRt?=
 =?us-ascii?Q?Sm/BBULby2Yfs+E/vCNW3vV6Bnqo22MZvjADjMcvnC0VNdzMiMVb3+utrXBz?=
 =?us-ascii?Q?gitBx1LV3ykxQVLqoOlAl7A650PQsvAi/XnenqwE2L1Gdi2S71gnKMK0wNvL?=
 =?us-ascii?Q?gAjFZFgYa2p5VLzD3kELMWIHueTMtdwpally/U3TIwvvSouh4Yy4h8zJKeUO?=
 =?us-ascii?Q?jNODoylbIYBKUkRzurevxg9NrOaglgXtUC/SgFawIk/8Wpm5Y+Qn32+laXb5?=
 =?us-ascii?Q?LMos1DlK5bSCL5DnAm0JpZmZYDZK8FiTgfKXBFL+pDUO6drXbiC6SxdNd4EV?=
 =?us-ascii?Q?AbneX+Qj5J9251x9LZv7PaXRoxea5/ZzJrEmFgDVI9eM+Wto20BuK0XCAUf8?=
 =?us-ascii?Q?CnAKB4NJFIn77vj7B7OAGJM4J2V7x1b4n6AsxN/pLPTdulL/tQ/VU0r7tqKu?=
 =?us-ascii?Q?TGpfIA1M/ZCbuKCfd47+gYvEAzosaBqnenL5SPGeQiKLsrPvm4D/lOBDLZih?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GnZ+eEEUTNB6NQt1CjDR58K7j38P64zJMxpfxAT9AqGs5yYn/cCZg4HGn8qvIHkYTtTh1B+feoeCRIO9KofEKV0mMLPiUeuQbLPKHl2jA5W9HE1kVB1qwjgj3Nw2k7y0FrPCm2VhMD/6spO8XBSL3H3g+ZXCDENXOgQyjHXT5kpXtkmAYZnAgf50JOSCOLnvE5B6yIMJhHDl+30Hdc8ik/K589GXER2XF9dpCbOGyq4Jc3JS0fxXRDoDcB/fZudsp/CKfQ96qGAofZpaxpo64aGGs8uqtoRrPzR0hV6+igm7P1ZCGcsCYpyjn48NouvzzMiW1yX2CbRPDw8vXJjrrodP1kK80CTjoUNAM/8UBad21olTrgpaKY9B9eCZrcQNA+cQYS4QbgSyEptRn0v3lj5BFUEPPeThdCwO8akyQaBZnSl+FaKzYaHuK0+6p19sOXLzMG6kYLY/+otDrnwwK996yRr8+g8rShkOaW+a+pmprFEFsjfnuk3xQ/5L7+h3bkMvuiHYhR5A3TiU3LIh62XH3Jw+MFfluP1GG09ExF0gph7DBurR5b050/eE+5U1PgWIF5Pz262raWw5/ZUyCkMNHEFQCOwUlS0Lnxoljfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18e04b3-8631-4393-5c0b-08dcfda4aa30
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:18:05.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVTnLhepUCKY0+jSGgyt/kJVJYCgGCbdCdEIw35NgQNVM6GGjopD4MXAKNtVGDzDaIFYohSbfFmvFvKjrPugMbPoRtLnk1yiw4CVIOLrPI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=805 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050111
X-Proofpoint-ORIG-GUID: FENv9_TpPq63jmwe5tEGhNnCNfIlvONh
X-Proofpoint-GUID: FENv9_TpPq63jmwe5tEGhNnCNfIlvONh

On Tue, Nov 05, 2024 at 02:56:43PM +0100, Alice Ryhl wrote:
[snip]
> >
> > As a wordy aside, a large part of the motivation of this document, or
> > certainly my prioritisation of it, is explicitly to help the rust team
> > correctly abstract this aspect of mm.
> >
> > The other part is to help the mm team, that is especailly myself, correctly
> > understand and _remember_ the numerous painful ins and outs of this stuff,
> > much of which has been pertinent of late for not wonderfully positive
> > reasons.
> >
> > Hopefully we accomplish both! :>)
>
> I do think this has revealed one issue with my Rust patch, which is
> that VmAreaMut currently requires the mmap lock, but it should also
> require the vma lock, since you need both for writing.
>
> Alice

Awesome :) I am genuinely hoping this doc will aid you guys in rust in
general.

And maybe I can use advent of code this year to actually learn the language
myself...

I nominate Vlasta to join me ;)

