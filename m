Return-Path: <linux-kernel+bounces-303676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1F6961382
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6B21F2441E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545441C7B71;
	Tue, 27 Aug 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AtTVaFNE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fM0duFVt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEAD1CCEEE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774567; cv=fail; b=Hu/g/U/2OP2HWLdYaIEzLkkE+ylhLK/viJIradcjzoVanRft2H0bTZIPVx8dFbV2rW1yTsD+OhfHICFzcYl2zPLZn6BD7wotlmwftAPFCjJh/tyyrG7l0aiy2kGQwAD6dWGL8sSM8Yv3ROn4DleuLTn7uTush+DAubpS4/UKdU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774567; c=relaxed/simple;
	bh=GOiVSQ2o9qEoXyoRjqwbvAUDKPowOyzd4W6dXJWTY10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u/od+gdDTaeIUMeQLgiqApn3ZjZiDuPVYESJegtpqs0t7rz24FQ7zsPh5gZ4XMURnkhdR8hw5U2oMfuavobryBjET1ySxqrKN6rzbSyfITQXcsUkN8wnyaviSg8AAotmqhrM9obR6dqYHvHxpzoHxM+yfqhzL6icte8kQmPpwME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AtTVaFNE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fM0duFVt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RCBTQu002530;
	Tue, 27 Aug 2024 16:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1XyDkL2C0x+y1qI
	VYn9nDN1BZTTD6FRcw5BEmwL4LJU=; b=AtTVaFNENMoCFyaaRzhGfHvZDt+lk7i
	Mpv90a2RP+AYEvN2au/qkyouItu9iiM+MjyLIf4rHfMF6lRei+L+ll6bzhUjoM+B
	IpmhZcLbBuT6qsvbaEeSDiFrZNg5Jv9BcQ3A3r4scON4C9V13ls4rm+vFHW5M2EX
	RC+Ihq2e+0CxXTp9myCY966O4WLziX+awIcc+wnxI+xoqGpJrM8zqWTYytVEpcNk
	aS77hOuP9k2/leYP0qZgSF4WqERzyL8pNpkk6FacX0HJ0aTwvZe9Rh/wwFux+lrX
	erc8xGKVg32OX0kOgV6xxyNMsrHr+22idznGuOuNewUYtv8OUPwepaw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177nae06t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 16:01:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47RFPhRF035048;
	Tue, 27 Aug 2024 16:01:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189st8bw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 16:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3b4nxAz8VSbSP/bqEmEKdJhNmo4Uv+oEXNhiILBYGmyEXI35jcjNxbsFCq0lJs66Gn5ZVRN3k0aCJHP23QWbt1naUCJvQ7m9TLmBqV5Ew76KKv2gj9VSvxvj9h19hrEtkVUgxEmAf3Z5eHDzw7aE1rv5ffSwF+CUspzun9G/MCuEKssl3/TjXAZp48DuvbFLLezCWGB1YNO96HyGG46wen5sFNHVfZhbETl0JXSP7yJ2kdk8nTXatvjKiCItzNU4MRgav1lie8xjiRDKWkpMu2ZWpLhqLt0Yxm4WlTZrGdZZulWC/FvQDOUfBiAdl3W2ZSYCElxhzJUKruOQVuwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XyDkL2C0x+y1qIVYn9nDN1BZTTD6FRcw5BEmwL4LJU=;
 b=cqzzr1HkPCtr+jqJGSHdhEBd++NHg3Vj+tbqhJ8gMSKr7LqtI6WmFFDDjEPqbVqfFnTITTHK/ClfiIX5zcMVx/F+XJIw2AwfeZzvz65yiy7+edqrBhQNvShmsIjhlt+fhAf68GGlsz/aujLqavTczdiRl08ZiuimqCkK/wFzTVfiflLe23/wJNrqndcabQRFQzAZs8gSGJAZGOtK4IJnQa6fynAL1ikgd/XIgb6A334k78BRGQt8QoidKgiCj3HGMeiJyOI63sXXn01txQ4rIHohueY2ZlhezkJ5VoebT5VWiuXm+hVu1p6bdALeXTpNaAm27XRpgWEtDHcfVRymBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XyDkL2C0x+y1qIVYn9nDN1BZTTD6FRcw5BEmwL4LJU=;
 b=fM0duFVtFh3yiPhypCFBU9O/bZNEcl021oHTotSvBsMpdzJpTAKpey2S+1d0beehy+9ODFqE89PTiNpU1COmSCvuWTwtBPf137/Gv+iweQdoVKMaIdcUhSMBAbkO4JlS0NVb/gflR9xINkYj7ZAnqk4E9/qzWgYwe5yQu3bwCOs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Tue, 27 Aug
 2024 16:01:30 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Tue, 27 Aug 2024
 16:01:30 +0000
Date: Tue, 27 Aug 2024 12:01:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bigeasy@linutronix.de
Subject: Re: [PATCH] x86/mm/pat: Support splitting of virtual memory areas
Message-ID: <yvcwdfgxnyet7rjf6lhnsypz72jmp5czfkb2muvgzcul53scn6@rkhqrfgdaxsw>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nam Cao <namcao@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	bigeasy@linutronix.de
References: <20240825152403.3171682-1-namcao@linutronix.de>
 <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>
 <20240827075841.BO2qAOzq@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827075841.BO2qAOzq@linutronix.de>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY5PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f2df50-463d-4d5f-82e0-08dcc6b183fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DsuSlAG03cLeS2Kmm1C5iHu4TaOrVOtFjfZS4ZU+G0oVi7k1oobiS/utKIMF?=
 =?us-ascii?Q?mSbcqzUtv4iA3DVaWXiPzx9LHhvL2fXWiUp45mVHNX9aQn7CD/YSGEZ5kNmV?=
 =?us-ascii?Q?ZN8uitN7vm7Sn8aLl7NYycdHu1OI/gL2eMc+tWjOmqLuWhrmQxr6EErEI8zz?=
 =?us-ascii?Q?SukptgTvt6cCh1LWncNVw4JWazI7nMmgSYcJCuT0b9UPEp39fcdkWkpB/MZo?=
 =?us-ascii?Q?Yu17DXni0dlU+QfsDHHmDUCsouk2qMohI69ni3yDwmSt7c5IA6hqCt0J6hlI?=
 =?us-ascii?Q?DeXwXgodSUkCaJOd42OvLg7UpQ8pGbGxmIaR70nmVuPBACZXsJul7WH07tNU?=
 =?us-ascii?Q?7h/1FwgN0AsD6F8N7GAauY19r+4tA/WGozq3oVwdlRVJ46/VquYHSbfCDn5L?=
 =?us-ascii?Q?XUdFOEkeeWlXA432ykmJG2jAxJgU3aysWfwtYfk+CWq/tAYjY0oLBpQYTR5K?=
 =?us-ascii?Q?9XjSO1EHoaz1lic1b4ZAWF6G/yogQKmsSR01aRmkxOv1Z1EH1fgpQ/9fdueD?=
 =?us-ascii?Q?27eTS22KC7oKewf2BZbPS4guc39NEmDJEHj0satSryzYKocZDQL46fqGI8Hn?=
 =?us-ascii?Q?p2VP1OzPBjej6HThmrayij/kfgIbTkY3bQLHSAjqTc/qF2e+XnXl2KE7xKzS?=
 =?us-ascii?Q?KOVk9yPnmXcP+bpZHMFxlGN0/KDyyEGskBWyGWcWzCohA7aXBmqoNXMYThQx?=
 =?us-ascii?Q?DQbNLlFxdvxRgtVOrdCebKm7NPoI0frNTfDwmU1kKta9AWOPCL+k8MBx/hdt?=
 =?us-ascii?Q?jEUEKSr0cQYOr/ohs8x3NNFcErenKwCex3TmrQrSSZTnTwdPFB5YTWFiUf3v?=
 =?us-ascii?Q?KCQzr34PemaDfhzSE5pz7p4z/Q94A0cOdpqF/dk4pebaC16hyAYiVJR40sHC?=
 =?us-ascii?Q?jI0hikdUfxr+ieB99MDNaUypiPAJmi4WWox5+OV1fo0cPNQmJPzYm4txOAip?=
 =?us-ascii?Q?7Xe2nhYvnnnwcYuga8Fo7Ek8ust0q1bJw47vPhaKmH2FfirB1CAqV6cClVZI?=
 =?us-ascii?Q?s3LqH54XORoYVD56oo85elBgPIP4lDhwRZL6sl7fLdhW5sgI0/49nntCXQLg?=
 =?us-ascii?Q?w+ArBCFYFGRBQuAPWa+W9wQOxyJP/nJ6lb9VoAATEqxZKx6lyAXnzL/zOJpd?=
 =?us-ascii?Q?8nfhG09soxoLpYetZhWtApuxZuzE+S6YdaLqpQVa5jIZZAeHWs+u9lMBzdSj?=
 =?us-ascii?Q?PxEUxJcdMj0VRwj45O6BAQ3nWeYZ2pDjGoAQkTXmKHHoo0GFeMHE44iky+kr?=
 =?us-ascii?Q?/liOZDIJvvKzhqTlyXSWae7shKA5WlT4LJzcuFRZH2pHT4Lclu73goDzNnjF?=
 =?us-ascii?Q?AGpps7niemesahDa+3v3iS6vyy7tY8VwoRoy/dEXRj9AEJHubg5GtziN9/4Y?=
 =?us-ascii?Q?5ao52JPEkXnHwF6wKdEkd4lx6S4uK3zBfxRvAs+kfZ9w3TRoLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VaGlRTcXZvJ3D5kbYc8PUSaFeWkflDi5ZSrcxm1CxXlGiXYegY3DItk5Opk2?=
 =?us-ascii?Q?crn5WvlClS2OWxwGlft/NdBLR5EoknovFuQ9wqqA7K3gmAkeBJqwyhLBRhnO?=
 =?us-ascii?Q?k9WiRGkGSjroa7J7gU8rCVSge1YN7tGbmZN3hjKktB8mRBowi5JB/BOy59mP?=
 =?us-ascii?Q?AabGorgKsKMq5klGen173hT9SFuXWQNRRnRGMivBPLWQuzfR9fBXcYP8ILFe?=
 =?us-ascii?Q?iTxtUYasJcOme4MijG0u79LNgJvi+qkb/tPT8HgL//zM8TEYI4RLwTbG4vUp?=
 =?us-ascii?Q?A2sSu1OSFrQToPQkU9akJrlxgYG4wW7k5ARAYDl7E00C2UdOaZELYhyWlW3i?=
 =?us-ascii?Q?0hgq/iLPTNbQ937ASEBRXBVTykn6tWcLqHJuqHVAz+K2DB0WxniMZoXS+gWQ?=
 =?us-ascii?Q?3x/EcZf1Pbcw00zgEXLpgDMhGpGwThXQcwFRCBw1xIo6MjuI4EmaTdC7dfhL?=
 =?us-ascii?Q?qpnONk8K5SwfnYi+QxNck7Ax8K1pXvnMAe+XtgoOF8TWARSZBwSRFKe7Wu3r?=
 =?us-ascii?Q?GOG6mbdrsJFeXt9FlBeR2wndUPgdtqC+aeUsBjSUkG6gPSnLRKWNDEWKd94w?=
 =?us-ascii?Q?uQyALIqUE2d2ATStLxR00mMZ5SR0MyRS6nkk6RyMOQE8E2yAyMeJtuqgobgF?=
 =?us-ascii?Q?gY4+XcDwaMpb+O3qnjK2fmBnq+ypwWNu1p85ULOfV1s85JljabIGgaVfYvGx?=
 =?us-ascii?Q?wCr30T3aLcSsLk2BCM1ixUcB+ZCGNxLo94ihKOKP/TnHoSj9BWXFXcfwie7w?=
 =?us-ascii?Q?TvlQohXjxLQX4RVe5gRyRr2kr6xdNcaxL2oF5YSZLd061ouI+RfouUo7FAy0?=
 =?us-ascii?Q?Oa5UBi+UvniF2ym5/Ry87Al2/8XKZzC4RvOk7bSWUlFola4FUwkx0TsFjL0x?=
 =?us-ascii?Q?BoTHzL2jhJTGIi9so3vEps9sSK4LIjdaCcUGaAWENebcG64+LTrDjcKIwEAJ?=
 =?us-ascii?Q?O79f9Havaw9eX9qZg9WGlUEDo1007kPjoUsrTmLNWlaX2Eo+C5GhHi5Jz7jq?=
 =?us-ascii?Q?4KEFyajMdHsPNst7mW0vf8hFfTlQIdbWt7yVgAJNnH7V/lrYBdytLo4C39qu?=
 =?us-ascii?Q?WqRJbgE0ZFUNgUVPOrmlv+xbtOWP8ViP+Nc4zrbXdwkyO5N7uRybov2ALGk1?=
 =?us-ascii?Q?NX2dxWhl33w34hOSxLMaWI27XrUCnWEJj2W7wEBkjteiQZ9QXHLgejOb2pAm?=
 =?us-ascii?Q?kC6cuulZfLtD6/uQvDK9JJk/i5Jtb8rPvWbQwc3pmy9RRG1Myal4chiU7UKW?=
 =?us-ascii?Q?bXf34eUWev1pG/zQMzSeUcks0jt/ndL4Skeh9uWZqzmQcK5hpz7f5mxt/wUp?=
 =?us-ascii?Q?wWeWk0IQp0hGb1Far7gZRRaOpVk50D7Wwzpj85Qc6ZN4Pq0o6F5Y/VPhbqBH?=
 =?us-ascii?Q?/kgmubR/5/5/atbNDZHIWYQ3lpx4YG6GMaQMPC63TdcifddABMjxA3Vz0MTx?=
 =?us-ascii?Q?/C9peEYwHJfIiG/hB0GopW1UfgWq+k6ciBg/vYZ9q3vTPIdHwh2/KuQHY2dm?=
 =?us-ascii?Q?DoSSx8OKhsEqVZEKMV7TfforPrANoQFGDK19/SHLnzkYcb0Aoazyoi7GwQgo?=
 =?us-ascii?Q?V2OT+QjLAovMHujYF8HuKcg03EsJQlTySoqz2gz9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yvhbgd50XVCZfcsPSo1T25OeLGuJYJYz4pICmfKWzEiMatbVc3sF4J1jePOnvSgLrYaHFS5tl9t3e+guwbsKlBmEqUgR/cl3uMb48LXTWtnVxkZsnzsG+ev+Bc6qf5x2aySFtrjE055ric30aOYH4W3/wKTSHyszPUJ7eeCqcj1hdjJBu/e0IBlWJmVChg9GP+dUqhcXboQG9PsZGwdZ+dh1vD19ZcBOy88kTkLnZhnU6eTjSn2TMiRXJDXQLhq51dUTDeVOEhV+Def3Q9npW6h2UEdI1yiLTtx4wMyRwRJeUwWIRx3Qe4+TBIxj7RA1aTF10n+D+UkSsOoEgUa6/jGDqEbP54Wg8GIq0LfugIyOCpzJzwfKjRmShirPAM19Ciu9S+IvgqpF0/+I+5EmpENVVIY/IhyqQS1bodoTzt1q19qm6oM8VLyhulO+54pbm8Bsj+DBmjAU/4p2I3ojUZ3hXIZ0gG087OD2bvMZrRyBV46IffI+9gyBDSb+Lixnjwn5XY0MRHxThmIB//exstmAtgr3eZk8J7FMBSFKId1xtzxb6GaZ4iO6f+848oyUqOSnAhZMoTixActU8SQdLMAQAGgIYWQPUq5A/ChJEJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f2df50-463d-4d5f-82e0-08dcc6b183fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:01:30.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuyeBJYnd3CYnTlMo3ftu3oeXzp+KdNmYLV4MugFxFFVfqC7Ds1COe9XG2rKjJ8l9gWwdgQd++MB3QCPiqX6pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_09,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270120
X-Proofpoint-GUID: 8-_JTm2VKi4BhNVIKweAw5iD6iEHz9CB
X-Proofpoint-ORIG-GUID: 8-_JTm2VKi4BhNVIKweAw5iD6iEHz9CB

* Nam Cao <namcao@linutronix.de> [240827 03:59]:
> On Mon, Aug 26, 2024 at 09:58:11AM -0400, Liam R. Howlett wrote:
> > * Nam Cao <namcao@linutronix.de> [240825 11:29]:
> > > When a virtual memory area (VMA) gets splitted, memtype_rbroot's entries
> > > are not updated. This causes confusion later on when the VMAs get
> > > un-mapped, because the address ranges of the splitted VMAs do not match the
> > > address range of the initial VMA.
> > > 
> > > For example, if user does:
> > > 
> > > 	fd = open("/some/pci/bar", O_RDWR);
> > > 	addr = mmap(0, 8192, PROT_READ, MAP_SHARED, fd, 0);
> > > 	mprotect(addr, 4096, PROT_READ | PROT_WRITE);
> > > 	munmap(p, 8192);

What is p?  By the comments below, you mean addr here?

> > > 
> > > with the physical address starting from 0xfd000000, the range
> > > (0xfd000000-0xfd002000) would be tracked with the mmap() call.
> > > 
> > > After mprotect(), the initial range gets splitted into
> > > (0xfd000000-0xfd001000) and (0xfd001000-0xfd002000).
> > > 
> > > Then, at munmap(), the first range does not match any entry in
> > > memtype_rbroot, and a message is seen in dmesg:
> > > 
> > >     x86/PAT: test:177 freeing invalid memtype [mem 0xfd000000-0xfd000fff]
> > > 
> > > The second range still matches by accident, because matching only the end
> > > address is acceptable (to handle shrinking VMA, added by 2039e6acaf94
> > > (x86/mm/pat: Change free_memtype() to support shrinking case)).
> > 
> > Does this need a fixes tag?
> 
> Yes, it should have
> 	Fixes: 2e5d9c857d4e ("x86: PAT infrastructure patch")
> thanks for the reminder.

That commit is from 2008, is there a bug report on this issue?

> 
> > 
> > > 
> > > Make sure VMA splitting is handled properly, by splitting the entries in
> > > memtype_rbroot.
> > > 
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > ---
> > >  arch/x86/mm/pat/memtype.c          | 59 ++++++++++++++++++++++++++++++
> > >  arch/x86/mm/pat/memtype.h          |  3 ++
> > >  arch/x86/mm/pat/memtype_interval.c | 22 +++++++++++
> > >  include/linux/pgtable.h            |  6 +++
> > >  mm/mmap.c                          |  8 ++++
> > >  5 files changed, 98 insertions(+)
> > > 
...

> > 
> > It is also a bit odd that you check VM_PFNMAP() here, then call a
> > function to check another flag?
> 
> Right, this check is redundant, thanks for pointing it out.
> 
> I stole this "style" from unmap_single_vma(), but I think the check is
> redundant there as well.

If you have identified a redundant check, can you please remove it with
a separate patch?

> 
> > 
> > > +		err = track_pfn_split(vma, addr);
> > > +		if (err)
> > > +			goto out_vma_unlink;
> > > +	}
> > > +
> > 
> > I don't think the __split_vma() location is the best place to put this.
> > Can this be done through the vm_ops->may_split() that is called above?
> 
> I don't think ->may_split() is a suitable place. Its name gives me the
> impression that it only checks whether it is okay to split the VMA, but not
> really does any splitting work. Also that function pointer can be
> overwritten by any driver.

It's a callback that takes the arguments you need and is called as long
as it exists.  Your function would deny splitting if it failed, so it
may not split in that case.

Also, any driver that overwrites it should do what is necessary for PAT
then. I don't love the idea of using the vm_ops either, I just like it
better than dropping in flag checks and arch-specific code.  I can see
issue with using the callback and drivers that may have their own vma
mapping that also use PAT, I guess.

> > 
> > This is arch independent code that now has an x86 specific check, and
> > I'd like to keep __split_vma() out of the flag checking.
> 
> I think these track_pfn_*() functions are meant to be arch-independent,
> it's just that only x86 implements it at the moment. For instance,
> untrack_pfn() and track_pfn_remap() are called in mm/ code.
> 

Arch-independent wrappers that are only used by one arch are not
arch-independent.  PAT has been around for ages and only exists for x86
and x86_64.

We just went through removing arch_unmap(), which was used just for ppc.
They cause problems for general mm changes and just get in the way.  If
we can avoid them, we should.

memtype_interval.c doesn't have any knowledge of the vmas, so you have
this extraction layer in memtype.c that is being bypassed here for the
memtype_erase(); ensuring the start-end match or at least the end
matches.

So your comment about the second range still matching by accident is
misleading - it's not matched at all because you are searching for the
exact match or the end address being the same (which it isn't in your
interval tree).

Taking a step back here, you are splitting a range in an interval tree
to match a vma split, but you aren't splitting the range based on PAT
changing; you are splitting it based on the vma becoming two vmas.

Since VM_PFNMAP is in VM_SPECIAL, the splitting is never undone and will
continue to fragment the interval tree, so even if flags change back to
match each other there will always be two vams - and what changed may
not even be the PAT.

So the interval split should occur when the PAT changes and needs to be
tracked differently.  This does not happen when the vma is split - it
happens when a vma is removed or when the PAT is changed.

And, indeed, for the mremap() shrinking case, you already support
finding a range by just the end and have an abstraction layer.  The
problem here is that you don't check by the start - but you could.  You
could make the change to memtype_erase() to search for the exact, end,
or start and do what is necessary to shrink off the front of a region as
well.

What I find very strange is that 2039e6acaf94 ("x86/mm/pat: Change
free_memtype() to support shrinking case") enables shrinking of
VM_PFNMAP, but doesn't allow shrinking the end address.  Why is one
allowed and the other not allowed?

Thanks,
Liam

