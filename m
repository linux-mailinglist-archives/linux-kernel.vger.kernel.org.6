Return-Path: <linux-kernel+bounces-255502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5593418F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E486A1C2133D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9AA1822F9;
	Wed, 17 Jul 2024 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BcFLr8nt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mbtM6jQY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE47469D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238187; cv=fail; b=ihxf/eCI2MeQCGFvlGGtiyYhp4ivFS7ewkNTuv1vSJVfk6F0WoKApJkxohf+yTwjKxL5T4HDHukJ1IC3UijZNxCd2B4KH9Dq9S2pWt81VA0KW7/pIuUzwAF45Js24p4e5Fxbra4tbQHwNUuOahfEt5A/7rmVPjlwiX6qHShrawY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238187; c=relaxed/simple;
	bh=aDm84gzg82bpWoyfvXchJljlkFwzDatP/KKnn18q0wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NWsJ0MpBELC5eSqf+XG1Pmgw2zh/ZQ7bZf/FRny1Z5i2h1ugkzgXFvQ5RaoXz0H+uksf5tB2DO1ATElhTY8CcCbylyzAP6x+Oge8PtP/f0RWL6CnMM0Z+yITInPWxu1XjKP+VOlhZ+Ji4ATDYdK5u9Fb4KXNxDFZmTtwPRMpnwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BcFLr8nt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mbtM6jQY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HHfe4V018276;
	Wed, 17 Jul 2024 17:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=BtQGnGliepslM2U
	2owk6QE/izXoH13T/TH04asra/sY=; b=BcFLr8nt7ljVRK+yNB5SFslwp2MGC54
	NgyWYTbcSXPyLq/7h0R1NGmKSQEp2779yHmmkI3SQtF9YvoKlS5dWmGFcG9HOzKK
	hBG2wGkn+y0tmp1U9u8xvhzUEVxWddOkcUOiSqTVgvncfS8ouS8GXj3F2kWeeZIW
	E9MabvTETMX5BweEAYYTyHlx+mfyQCaYQZ1/otdOVzPGjdwR/VctK4jNcNey8zHo
	zaLz5QVYSyzfY8z/7DjX4lrNIqTl95pUwbzY4eEDCpLeEfQhwHfgg4PQl1s4efje
	VbiQr6smrTRAWiieJKMvxls0f43ihbnzaVeJiunXND5Hpqyp34C1eBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ejjdg032-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 17:42:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HHKm8O039531;
	Wed, 17 Jul 2024 17:42:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwevbjgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 17:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izjgJsyZoNA0ekoo6kKYzn+kVkesH8LbtdGUM8TLGlrFHmj2eKvNrYHlRpPbDqB+Ee0qJEBsObFm9WoQ5tfVn2imx/r1b3SXzPFxebZ6BT3l2qylhjIie9EkGQUWlefcS2Q2vtT7CowsIY/CkiQlUvLlaxK5RBbGiw+l4ixrMA3qV0gFi/O7btxiql0ZLZEcOKb3nEdoY48TC1eGZCC9Dec4rBfTzxqY9p3Eh6VoFiBYXjuZb0MWscZ8DbYxwpXRQ0K4X+Vf8aoQgk72HO0AqVkJczY8EOPvtCf8p5z898e8eGBJN1hxOpbEK/7pqO22kgkbHt9P90O8q1/sk2i2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtQGnGliepslM2U2owk6QE/izXoH13T/TH04asra/sY=;
 b=ejqfhRfDGOs1H3ftMOS3osKx6SVG6K4HIMo9yPAkOrvhgDWlvtIG7NMndU6XVhok66dL1+ISo+pX6wQ6auMBBiFIRse8/E38yqC6Hud4wOO1Ie7oPxIUH6duH/DWhUKYzGHvn8xSTRWyC453YH61YSn4s9BSwAsQWUiFizFN22fhxGuk1Fghe8Q4IDqiQdHnoPuXTpqadvdOSWChY75qx+9dOTJHUgjs35P4poEiGbbZZov83qfEjq9+LB04U1eDk43ch8xOIzo+jdrtUlu5vcnn9XHPJ0qd4ST90opGSV/QE4/Zh+Q6b6g7g2NZddRjR84eoGPeDexxnBS+3T/gyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtQGnGliepslM2U2owk6QE/izXoH13T/TH04asra/sY=;
 b=mbtM6jQYxQtAW7WXgynJQY9mkVT+tBDCKtwIlKUpu6KjaUDXgQGj6DT+lQetgDqe4z3SuxFL0Emopi8xyX0RD10AJaP4A8QELL/gRPvdpQGcL2yZhRq2LhPnx3+scX9+uKqj12sNOqlP5AJf3r14cYSGg/eaFLiM1CBW/b/kUK0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Wed, 17 Jul
 2024 17:42:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 17:42:40 +0000
Date: Wed, 17 Jul 2024 13:42:37 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
        ltp@lists.linux.it, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <hdmrqvvszg3fmvc6qtmia42y2d7gfpsqrp7totg6pibidyj3rr@eaze3r45vx4f>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org, 
	ltp@lists.linux.it, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240710192250.4114783-15-Liam.Howlett@oracle.com>
 <202407162022.5a730c37-oliver.sang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407162022.5a730c37-oliver.sang@intel.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0447.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d77661-1a2c-4742-5310-08dca687dace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QwM/VPxA71AmOgjhc0/d3JZsDrBJHEHnEP5T/rltc24O39DsYuNgXRnE4HOa?=
 =?us-ascii?Q?JHixUcWgwkawYfpUo7l+QqPHQjZzzydNBcYep2XSZb11HFM8RODoyeUrdl4c?=
 =?us-ascii?Q?UJJYjDXK56SCnMIHQ1urme/OtDKzlJ5WLUfoTXNI7vYlDeVycdfcB27wWF3f?=
 =?us-ascii?Q?LFIgb/xIgcH7ALLPXWX+IMOXh0EigvYypoox2qJhr3E07zLNvm0rJOe006Zd?=
 =?us-ascii?Q?zoMoxcH90YZECvBcAStubGktWOGyMJ9Up0g/PigFFCX/P+MWx8eYqyU75Vda?=
 =?us-ascii?Q?SG24SogtvQP86EC3NQ+L/XmIiLcsZg2MXb3inPWOeEzGY4YXpCgLswIJYf1c?=
 =?us-ascii?Q?XZJcVD1hWAqiTRGmBFpm/6nL3QrYbIfPiXz+rhmLt6PNPKnWhr+dmvkn3QKp?=
 =?us-ascii?Q?hhB/6mtrGdpm9Cu2ghAymV+onPSmXI08Gr8Ib32gp0qLiyHXwWSCzm2Sz6wL?=
 =?us-ascii?Q?MWl4dcntyQVKz2Yuxcid1GiC9kNh1CcK6A+t3GFEAUpc/n2fB9sEW/dud1Pr?=
 =?us-ascii?Q?21/WOb2qu33lnn0VngDrHZmGa5HJEhg0I3Msbv9NB3lDavQn6xDyqMHSYS4M?=
 =?us-ascii?Q?CRjNPrUb4CB2tlP+2upute2zAEFip1VpTDdrPHUPTgO2UAgZaXMrUzsfODIk?=
 =?us-ascii?Q?OnZeSWUxuaRH71+pOXlSOB0D+49yMtWoudENfSe8wjbT8sa2RrgGzdTbaZ8O?=
 =?us-ascii?Q?/ySxJN8k4P6b1ViGoqeIFwo2qsooqxSbjaIku0v/eUfdsKbWKTtZD4EL1npo?=
 =?us-ascii?Q?f4VVO2WKea1tXuCS7534omsZN5iyoeFE9RMckBnV+JYs9gFQ+3kVcp6NPtV/?=
 =?us-ascii?Q?wAKWUD6ZPufMG6FICRs/laNJca8yv/2SdbKHbQaF7OOj2qsUW8P7fK9xtGBK?=
 =?us-ascii?Q?KixiVqSdW/lzFQ/hS+BR1CdWwkC2JxLnbcMmcl4DBa24FgnrC3POHii4rd8o?=
 =?us-ascii?Q?aQ2SxAGOS6ZlBQRGcsY6f5noqLCSInOMhUakvgecV7Y6qVa+WQKZkb/eal+y?=
 =?us-ascii?Q?Fe7XmtzKxGc22hoqJcUyjXUkpLJReqGtX/558IQAApOaZLSxyYnlD+Cb+4L3?=
 =?us-ascii?Q?8Jhf5ioeQzMZlX8pu/Onu88pcBzEs6qyNsYg3+HbYCxStf1UqLE1540TTMh8?=
 =?us-ascii?Q?uIeWUXSPe/YX7JsHeefnghDBkYD2VzQ50TQVod9qMbDQq3ifInyum6EPXLzi?=
 =?us-ascii?Q?9mX7KW+pPSDefgYVJU7wHLYuItXZGIg3aV/HsJHrwwjlnSeTv05wavQmQzOl?=
 =?us-ascii?Q?1ftP1X337TJFQ5K4/Su5tr9+TCf5+6/7UhuCfnS8SQFHEAie2vW0Q5eBQUFZ?=
 =?us-ascii?Q?daM4sxNuhLxsOt3GbORxJn5Q?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wX/70oE+t/kWnMXL9Mh2/zArCZH/Twc8NC5/SiLQQHMTeHL3oit/fMlDl4jC?=
 =?us-ascii?Q?+BYzEPTLgY99/i0HBhL8/9IC1awKx7Y3EljZnH41IChYFsi7PpyIyXoIdILR?=
 =?us-ascii?Q?OjXhCecuHIaltvrD5zp7ZLXzwim3i5dnLCHdLWN+SLvYzOC1MpYXZ407Ov+i?=
 =?us-ascii?Q?5TjX+0r9r0rd5UK+q5TMgTfeFVI6VXB8DDkaS1x4rJFZ/md9SebyGDL1Dc7J?=
 =?us-ascii?Q?yFsdVJ/FgqipRst+2gomVzkJU2UT9mBcXG0VP3MhibrIJhiVwMfnoQFL2Vme?=
 =?us-ascii?Q?c7n/w0ZinpNCzgqoGoZYUllwsfhOQQRaht+IGVtO085NZxePNP+XCvqPILPF?=
 =?us-ascii?Q?GuSycoBjqFHyxbppTKYoiL7vvdGko1NaXqmvsCuCkB6zxK2RcvdM2OdQg83G?=
 =?us-ascii?Q?ickzL5EKbuXB46gxE3QMrxX91x24FHO9EYRUDEZqIvSG644OyUFHcn3CaQ9M?=
 =?us-ascii?Q?Dj+eRLwN/I9q2Ld8wpwKEpO2rSuO9Wb/efr+3eeIFMwrv1wM+fbN955Huw+S?=
 =?us-ascii?Q?/fUzdbS7JS2x9rxmzdRgrsf2/BPfVyEf1gwzBcmu54x2XQejXxLcwR48tU9S?=
 =?us-ascii?Q?WUe2r+qIC+To/XEJExjGDMqaiA9wJf+GCgo+3sSyLDG0HgdrRHOIZldY05I+?=
 =?us-ascii?Q?QCd9KzXLjVfQZwmXInrVjeta4K4PNtHCK3VG0Ux8fH37wgLKfObxIjoPUuK2?=
 =?us-ascii?Q?V1iYOBt7XyJyp+DHrbHtvA28KGHlqphOyl+KE1feYuPTN460bBpOXpxpg/qV?=
 =?us-ascii?Q?pAAkJRqkGv/5dwHYyYz4uzWUnnu5q/3H3aaRjp1A10FRDmWkan4zC9dQpwou?=
 =?us-ascii?Q?CiRFaSILjvC/K0NDQsihh2P36ZaYZcpC+g3KOt3OqHm5aepDvMDbKZIymNwt?=
 =?us-ascii?Q?YtnAgUWtfieH7OUnvfYSA6AXGeerbcuo15WwolH5422pr15SodQltabJe2Z+?=
 =?us-ascii?Q?X/2gDxOPlVEaHw9gDdbl5+y70hL81gtUe+WsZlQOaGaKHT3x22+JmibHxZQs?=
 =?us-ascii?Q?QWWw4Bb7IIWIdtw21JjqoHwTIRnopnRBItzBLYePala3QBNyeR3D4FTNC50d?=
 =?us-ascii?Q?5s6ejiZEqjJiRpqFW0CqsN7ghE5zpqWj3EGP2jz9kYLHaPE0VDeem2b3ew+C?=
 =?us-ascii?Q?AO/e0NBKnd1zDGTH02PK0Ep549s8Me2JfD9YsPpql85sGrBD02ILiM9nicQS?=
 =?us-ascii?Q?PNmlCNxe7Vbu1lgiS3an8ch7bOJLR1XlNhk123We433nd/SBblhjfarekKu2?=
 =?us-ascii?Q?P3nn1bcwXJQAT7CqU3i7Z/c4aOeZe9Xg/N0Wfay3kVEXOLofZi3ER31QXA74?=
 =?us-ascii?Q?dNEgxE+guglL2w9yK/LA0pddBs4K2qiu8nv4a7dhxE3iQGne44SmT94x8jZy?=
 =?us-ascii?Q?ptNEnGFpkbk/OC71rfJZjCk8cNWnyKMiWwyasZoQi5Iss+EaB4vuBHUf4+pX?=
 =?us-ascii?Q?S8nXvAov4gaXQXAqcPCkvAweHD/b1RFNMYynToYMTFQ1ZvUOuAwdLFNiHdWf?=
 =?us-ascii?Q?AdyelZlGwN5bvMImwoTbGa+Etzv06Kpc2csT4oqbPII3T7vv3t8KiqO/zvFq?=
 =?us-ascii?Q?kLbCkLA+a2aNm7c1/xZ8j7GoDO4VTQOL16u4r7el?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	w1sbJpA0pd5RxmqZm0GHrX117nqqKK4gKfjSVAev53umoe9jNsegcGYepioZdjhE9osjv5OPHdOj4aATU+OqMNip3TIu1El+pJ1h4sRMSycdHEadN0BfkFUkZgC9O4lfZqYYVsw+DPEbfU1baYLCBKaAnZxzmvk4FTwkUidFw5plHjxIUsqMHCdFNdx4wA+CaDwaZLECdWeeW9uJhkglxVE2Ehoz54jeNsyNHgaAeumB+4Wp9Zz/TNb8XvFJrcyvj6dRx9J3FjaE0bBt4iv3YP3Q4CmsXcH9MENHweAcnARNfZFCW1uoU67opOB89qXAeHthD3hZ2/w/mMaFsiXC9rL/17mMqys9xx6vcGvwGaCv6eiFofkP9ERfWxL9Qjt0dKqV/CwooJNslT60tmnM31o6jmBMC9H0AaTga4WQ2jLLiYK2X36ipCl9dxQfwRHG/22oxvgKDa60QC7/PvyPAz7A/qallvcOunXR7akC8NaX3kodd/ltovtZgP5W/4Ddk19ckIQiM7EkPlo9iXykd22YaJTcE1WxOq9Kl/5HxFcSXoX3sisx+yz0k7lsEVbfDRWmSecRY9xZTBopJFdYiT1f5g3qCsg7RNbM0LGTdk8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d77661-1a2c-4742-5310-08dca687dace
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:42:40.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ih8A/3sC6uAJW7euj6RMthMAcVRGKh/9ckrv80cfxVc8c37Fp9uTDtwPgvfDEjU9BftPz6IiHJvXGuEJOIdkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170134
X-Proofpoint-GUID: 4r4glHjWB63tISUoQSm8PtY8wGh57_s8
X-Proofpoint-ORIG-GUID: 4r4glHjWB63tISUoQSm8PtY8wGh57_s8

* kernel test robot <oliver.sang@intel.com> [240716 08:47]:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.hugemmap06.fail" on:

Hello Robot!

Thank you for finding this, it will certainly help me improve my next
revision of my series!

> 
> commit: d793398401db9fb81084bd4fe2f782342201df18 ("[PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()")
> url: https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/mm-mmap-Correctly-position-vma_iterator-in-__split_vma/20240711-075019
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/all/20240710192250.4114783-15-Liam.Howlett@oracle.com/
> patch subject: [PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240706
> with following parameters:
> 
> 	test: hugetlb/hugemmap06
> 
> 
> 

This is because I am trying to set up a MAP_FIXED huge page before
hugetlb_vm_op_close() is called, which removes the reserved huge pages.

I will address this in v5.

