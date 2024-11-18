Return-Path: <linux-kernel+bounces-413046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536CC9D12B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148AF2833A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635271A0706;
	Mon, 18 Nov 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dKHc+EUS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jq83cj9q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015B7198A39;
	Mon, 18 Nov 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939062; cv=fail; b=J/cR2+wfy2jlNaRFwEh8WhGUC3t5c2Yj+avASlg5qgI+C+A5AQxr+wvQB/ohyXXVoBAn4IezjD/yVxjWlVqSlJvm+MdsC5UPYspfpDJerx/WI1D7pWXrti6MYdNTpjrkJKVtdnMMVeSLJ8H+E5HNJs/ORXqQm/oWA9jHjfi7/zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939062; c=relaxed/simple;
	bh=9hqn+WFWggGq9CuOzhhbfUqmHjRmZQR0XSpV/Z4Zw1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pyddkJTk5z9olWHLQww4ixMQhpftxTHi0kYaNsISJanXNve9tbXr/GvpSye63vBHyTwolc7XcZXxZMNyMXh1hymIgcSRmUjg4p5UeR3+i1vhtH3VR+0YpNyjPyjK7sO2KJwGKbnau1EO/rVJ7lnFLyvNssNSgi065cSe8qAqG84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dKHc+EUS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jq83cj9q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QXDb009201;
	Mon, 18 Nov 2024 14:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=PyiFHjH+UswnNt9d9h
	rDYHFwKgDunZc1/qJIt/2dkCg=; b=dKHc+EUSPCMo/2hjQSC27wm5B/GjrtYGH4
	8p/z3+ASzcel/O61WJVnvs9hybCbwPJ9508jvmeHYVCdTYUsvIYyrdXOxeOGpHmG
	OD6+YcXXDK0N3qZY38FxtHtGKgG+qJcaW3sR1veV55LS7c2VLreB0UIiHnMEK1Po
	HndludSyleu8knx4DX8ZdgU2Nq/nZvoVDyM/FKBMiRgb542w6OX85ohbv8erI+hh
	yVZCBOkGuvCnGyVEVWKuKIb9REEd6RJmC5xbaNAV4krX94NrwbhQ3Zq6abB8CHSc
	7x++YYay0p8jz/Yuof9T1E02KLRKjgSKsTkMLQ9f9RU+SpeHEsog==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc2rs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 14:10:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIC6e7l008935;
	Mon, 18 Nov 2024 14:10:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7btfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 14:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REfdFc/2Hvaol3pG7AIN246Xv+sCCnVKC40Jj/+eVcvEdfdCPZu6r7geGOJ/KRq4DwTOvGlv1MwkCwBvcRvo4UzCQhIEtckl8qYkIFqaEn/olLnG0H4B4ksz9mSJZ1YUq6qy/+9BpXhoTIOFtE2nMcauy99nFTIT7uatLDVsGHk6q99UDEVG/flYcBuet6ZZ3RX+qTMFGmzB28hktjCGk6RFzzmFvgNHa5Ivuu9CDhLMWob2BzvRmCCFywDdWAERr8XIkuK5stWQG4f2Obc18JIXFLIp9JFprusbzZhdTlEDSu5JJy4tyfxmrpHIRTJBrcC55Gdp43Si3A/x3wSBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyiFHjH+UswnNt9d9hrDYHFwKgDunZc1/qJIt/2dkCg=;
 b=B8z+tFkc/h9SNi5Iqcn2l4vgwoAirFyMsrOMhkKnMEU8vyX1SJV1rSbk1w8BBFTOSnjgaS3K868Dn8ok8euDZO4JXjUcNgSsNdInCK3hFrg2avzLYjXLcGLoqzcC8XQqErLlAe/tsKEs1+FYqbdYp3+r/Nzhss7YUNX17dflMpUpS0zCFEVBb3+zhmu8sB3Ir+7ORgjxVuh3rTYoz5g5KXUXD/QWpfMA1Gvu1851ci+HhV26RNNtgQxsPgp2+5tWJAueCgPNFoYshnKpORgsNZWvqtJDggDh3Aq1nfX/yjGCkxMgoz8y4ZAqwHop10k0pf/h3D8dVKvmwCzye0wOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyiFHjH+UswnNt9d9hrDYHFwKgDunZc1/qJIt/2dkCg=;
 b=Jq83cj9qZScSwMZFyu5gv8ffI4BGu3BnP6lnR/XHw/Kh1x+1HsD2jb/n9NW/Y9Fj4gHFYjRcZ8oPTQl6iCGD1qFMjYsUiKH8vfTyJL+APsbwEAlzIiEsGgtiCp03XUoNmj2KTydfOJQeV9tGGy+Uv5oL5S1YAw1fsAZXNQR1OyQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7733.namprd10.prod.outlook.com (2603:10b6:a03:57b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 14:10:19 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 14:10:19 +0000
Date: Mon, 18 Nov 2024 14:10:16 +0000
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
Subject: Re: [PATCH v3 3/5] mm: mark vma as detached until it's added into
 vma tree
Message-ID: <8e651b4d-ecdf-4b73-9ca9-c3537da63122@lucifer.local>
References: <20241117080931.600731-1-surenb@google.com>
 <20241117080931.600731-4-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117080931.600731-4-surenb@google.com>
X-ClientProxiedBy: LO4P123CA0537.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 6245128b-cc7c-4a18-7dff-08dd07dabbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7mbmpVJz74nit0K08sCc29xjC7ZIi3wOsE2REbDA3uNoHcNrw/8pp72jedHb?=
 =?us-ascii?Q?smY0KH5k3wBFeOynmO7cOL5hBCYsQpogKXDi4lSNEFm8jTGeFj/0zOzI1hYu?=
 =?us-ascii?Q?dBDBd5Pli+XZr/KJqqjGohfx55BU4b5t4bG7FuBeYiHCwJ4SHpa/X3KoEYmG?=
 =?us-ascii?Q?ELV5ULr6fg9etz71La6TXC8IOAYta4dtdDZxx322Y7m0QUacA/w0v2u98rPc?=
 =?us-ascii?Q?eMEigoTh3y807WWafbtIjq2tNfEsTCoxyVoKEVj/tIxc+1Qaj639Ja5rSVWw?=
 =?us-ascii?Q?eAWJl20jM11lYiIM3io9FK+Mg8cVZuZK1wiIauf24djVMN6j5Tw/LTX1HCoI?=
 =?us-ascii?Q?VUsdSptBLf9LMox6NNfOWqfNmPB7q9mBF1emYeL45EzCgsOsepu3Qge05ReS?=
 =?us-ascii?Q?52E88NBGghIZsSkw6tIqN6OS1lTE9ItNOA68JCtwR90OmYGPb9Bdl6q9sNCB?=
 =?us-ascii?Q?YdlupBWUjOpGI3dBbYKfUqYeyDigw1DfYqZh4dKk398jkqPVYJIglTU2HjiE?=
 =?us-ascii?Q?YlDOnh2X9oZ6hlLTRqgCChjtbO34VLKOGcLwzxl4z2xRj1OoV7p0vm+veS3P?=
 =?us-ascii?Q?EJwza3CF8x28d8KGEuhVL0dmcSfxdCPBn8SjJMfiU84JZBZr5yXtYpkMY15y?=
 =?us-ascii?Q?ZxYXloIOHIi9EaHi2W1yeGqRG0MUHFBfbzAZ/NrWLPrKNtr6Jt24aT8GFMYh?=
 =?us-ascii?Q?NlEGanedmykQHEjDVV5IVnbRNVkxysbaWfPptOl3o2GLCtNR1hLC12EW7aEd?=
 =?us-ascii?Q?UX7PBkIzJoPO6kx7hE0KAFoRqlMY7xHx8Ve6pTdL1OL0bQzbHPXImxaHvDMI?=
 =?us-ascii?Q?JZG3Pn87T22TsVStbI7gEhlZJyq9CmiK3qwxiG/Qq7h3sePUM5Z6RJChRmNp?=
 =?us-ascii?Q?Wrqvi+A1j7SaG7kFVq0sfZuRVwGe73AUnapcshuaNmmTkJAhqzG+xaGonpGx?=
 =?us-ascii?Q?r18eXdMbT+WJl4u4T4iKHRIjdalb9DLidzFtuZIDVKJLT9AxIESeBABnrgsA?=
 =?us-ascii?Q?k2Hlv2Am9yQahl3zAquLCN0zpfJTHkHnI/yyI5cTdgUQUfPXE0iEstF6D3Ok?=
 =?us-ascii?Q?ZKOvBe5wsnWAJQ/JFUACqqt1wxZdfeOWfwCVlgVzfVKUCccZXr/s7ymYmlVX?=
 =?us-ascii?Q?xzBpXdVFWTX/0GCbhzqvEAxgKS49Aq2VJomtlS9AdF0jkslQ0OaaSreVz1qA?=
 =?us-ascii?Q?Kf1ad52DBpZXBquMfNbsGbbuQsrWbke/W2TT/vJAZtzk3lskh6tNSf3IqGJm?=
 =?us-ascii?Q?dBkPrdkmXXuaLneC2YBuO1uNKa5Dn4jb5qpRCVnuVpZY47xgynoD34YJTEfd?=
 =?us-ascii?Q?lsZ1aw6q5ap53mukAjjvpfBc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?plrbIEHhICQIlFcU4tlQauV3lHXnOCOvb9CK2BM8hWoylM2N0ipaeDPruEBm?=
 =?us-ascii?Q?hiuz7n7+V5dcKipl7Teqg2yF3ayR5aQaqm/9YbkrCnHyGCyy342fdEc8K9ox?=
 =?us-ascii?Q?We68v5oK/wO3yoyBuUgbSDVJEoxf1fGqD/CWdjWicgL2WmG9y1Dz9iQuJuXD?=
 =?us-ascii?Q?nbyRzogYdsD9qre2XH5Usm2nRBKqATP1xOPXTFgdLEXdaKSxKxDQg38ydl31?=
 =?us-ascii?Q?Veo/ld1rBxrDoafTIPyndOrk6dfMMBY6Bq2RV2t9B1hYv+buKvvzHFS8ZQfI?=
 =?us-ascii?Q?EQ2G/Jm4eAmhe//Tr8rz8B4gkx1J8oKHtxEYM2or6y9/c3jJye8PXPFu0gvR?=
 =?us-ascii?Q?nTtfdntFWDOBjrPK8eOVKQc4Jd8vPOzEoxszsPr0wOgShPKDJMGVj0pOcFCZ?=
 =?us-ascii?Q?VEpZiQtpw9TOWlpL23CAqi9DUiUph07lctv6UtyZcVsPPOACBRKcGtEVs8Ly?=
 =?us-ascii?Q?cOfj6Iq/CdHh8xK64mYU3/cPbnfAuj4PmTHQed5RXVlWOwwto1lC5n90UdCO?=
 =?us-ascii?Q?NIbhYzSw+uAwdwFKBy/ys0eHwVuivc/hh/yQll9TA6afqlfjffU3NqyHto+U?=
 =?us-ascii?Q?Ty+v8VxUaMt0fNGA2SwTX7sTGja3P9wH1vPUan9cPdp1tDCphbODuV3nijk5?=
 =?us-ascii?Q?gGHH0ioZJ/YUvtwlmovzJISCCPK4CMHUPD3I9S2Yc76QUMdShHRxGB6d30lr?=
 =?us-ascii?Q?c6lDNfsI+2Efoem2358QeTDLqUvr9fRYJ1BC2vnevj9smuh5+soLE7jlwVWo?=
 =?us-ascii?Q?uC8FssZ7ermIIxqPT3/2idy0VhdN187Ga3oCv+gR0JaIdh4VpDwbA8hcd20/?=
 =?us-ascii?Q?ic7V8e2Hj6ymS+8ziDHTltCSh21M60D4hgcE21VAnv4Xrm+kVB3Ve3IHR1YM?=
 =?us-ascii?Q?nVky9BCjlCPtDzqNGbnj500w5VIQEjhOpt6/aLYuWdT+tqrI8BUNP7umkCuw?=
 =?us-ascii?Q?BZu1glSH0Z6HBDe/5SbHxvx6BWmvj4IJyQyU1Zs7v10G0rrMcbkx89v5mfcH?=
 =?us-ascii?Q?7lLwekregymXlKNdZfXPNQSg8YOyk+uh9WjncuxVpVx9heb0ryZ2sq400yLZ?=
 =?us-ascii?Q?yQlp5Wqn/HQevJso3ZpjljwgX3Q9XIrEK5hbNHTsRPOpozFWL7PPUzR/wzV3?=
 =?us-ascii?Q?kUfXByVgX0GAuTOeHC36pQgg2FQ79LAkqi5Ga9TMrx4Rs02/H+7uaXAIeaDd?=
 =?us-ascii?Q?fHojEnKce7vOw4D8ioxT1k+r7zytv5AERhWv1TRl5sRRuAD+tS7I6owUqlAt?=
 =?us-ascii?Q?za4iAEvoqKYqZrHI0rXirPg9LHsgO5c+MA3XMdUuFOG/9kyMFr69YLb05aMy?=
 =?us-ascii?Q?tQdng8vqi09LbMkQliUCWY7/qMxqhaYWz5FWZZtSurT+QE469+biITfNp9Jk?=
 =?us-ascii?Q?MELY/WWByA2rdfxpjRCjQxXCZj510W+4tXObv/i/CDlqQM3IbIQRXwhMOIh9?=
 =?us-ascii?Q?koLDU+Pkib/URY+R5KMKxQT76hM0dpr7r4sHuhCDXw56JKWshdS8cP7LZLfA?=
 =?us-ascii?Q?AoQL4vDpdY8/PGtBZQ22/FHEGgsSySQ9LfXOVoeBs/yZYRGTcA/y0+JawTeZ?=
 =?us-ascii?Q?q7CeOgZLXmQOnqrkh/SgmeJWB0K65la3Imvm9kDhNezSNbC0xSNoS0VqdL3i?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bcxjiHP7FbOEFasOcFJD69UwebBcYi9A0bO/9oOj49Y2uojsnXXoaigvm6k6NCmZpc+EAtmaMiJrPxMDToql0D48p4+3swQm8GPYfKNrTScu6DjLLzqHUSQmBWwhUFrSh3fFInix4aSbsOk6p5mloJOdxsd0IYzxrLloW/GGbKemJQwOd7TtKCZskWahWqCIfYUzVvfc8fvUmM048Sd0eiJC2F0qh7culKXlOEE6AE7ju+MijNjaA3rqr+zjAVbpfD25s+FKoPmpLPYWEg3fQZSuGJ1OHK3+VcTa+/+MHaUp0hpdDkuZpzFs82o9mA9wYKoFR8kzTfKwip2Lgk4cDSmXxePvPZ2CInvf8N61jNe+ILeBviuxwLQlHkKMde4ClKqJJuWPeUs0MpWwwyIUGcC7BXh+eFTZal+WaPZSwV9dILoveuvqbGdSw67pjxbwCJZfYuHzNBS2L7e/t1ljxAf78RAbKKSgNV39zDlMB30ylpddj6MeaiG3Oe1SujG8guj2pfarFUm1Zzv0o2sqZudTj2uVIWSZ5uQ42le9vnt/i+R9pyqebgzzW6EgN+eZQW8cntpJ8S5qR8XPLXNePvOzdUIS3QPHbaf5xyhdkng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6245128b-cc7c-4a18-7dff-08dd07dabbd4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 14:10:19.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXMUY8fnY0rejXvaqHoOB9eb2hsRf3eDA8PyRtrXDiCrQrxwUmlp+qqpuaivuZdaDO7Ew0Ni4zSYA8le1TB1BZ5/NzvH97exS8I75oXbnVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_10,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411180117
X-Proofpoint-GUID: CKWYnrjwtVJMLZiraZN2mKM-cf7eXJXL
X-Proofpoint-ORIG-GUID: CKWYnrjwtVJMLZiraZN2mKM-cf7eXJXL

So, this causes VMAs which are already attached to be marked attached
again, and when the check added in "mm: make vma cache
SLAB_TYPESAFE_BY_RCU", which is:

static inline void vma_mark_attached(struct vm_area_struct *vma)
{
	/* vma shoudn't be already attached */
	VM_BUG_ON_VMA(!vma->detached, vma); <-------- here

	...
}

Is executed, it fails and asserts on boot, as per the below (I ran
addr2line and identified this as the cause).

[    0.615256] vma ffff88810086e000 start 00007ffedf98e000 end 00007ffffffff000 mm ffff888101bf0000
[    0.615256] prot 8000000000000025 anon_vma ffff88810026c000 vm_ops 0000000000000000
[    0.615256] pgoff 7fffffffe file 0000000000000000 private_data 0000000000000000
[    0.615256] flags: 0x118173(read|write|mayread|maywrite|mayexec|growsdown|seqread|randread|account)
[    0.616232] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[    0.616416] CPU: 3 UID: 0 PID: 1 Comm: init Not tainted 6.12.0-rc6+ #9
[    0.616618] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[    0.616914] RIP: 0010:commit_merge+0x361/0x390
[    0.617059] Code: 28 e9 58 fd ff ff 49 39 44 24 10 72 c7 e9 81 fe ff ff 48 39 57 10 0f 82 1d ff ff ff e9 1c ff ff ff 48 89 c7 e8 70 0
[    0.617609] RSP: 0018:ffffc90000013a48 EFLAGS: 00010292
[    0.617778] RAX: 0000000000000138 RBX: ffffc90000013b68 RCX: 0000000000000000
[    0.617995] RDX: 0000000000000003 RSI: ffffc900000138d0 RDI: 0000000000000001
[    0.618209] RBP: 0000000000000000 R08: 00000000ffffdfff R09: ffffffff82b089a8
[    0.618429] R10: 0000000000000003 R11: 30203a7367616c66 R12: 0000000000000000
[    0.618653] R13: 0000000000000001 R14: 0000000000000000 R15: ffffc90000013a58
[    0.618846] FS:  0000000000000000(0000) GS:ffff888263d80000(0000) knlGS:0000000000000000
[    0.619041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.619186] CR2: 0000000000000000 CR3: 0000000101c74000 CR4: 0000000000750ef0
[    0.619357] PKRU: 55555554
[    0.619425] Call Trace:
[    0.619491]  <TASK>
[    0.619546]  ? __die_body.cold+0x19/0x2a
[    0.619644]  ? die+0x29/0x50
[    0.619719]  ? do_trap+0xc5/0x110
[    0.619808]  ? do_error_trap+0x60/0x80
[    0.619901]  ? commit_merge+0x361/0x390
[    0.619995]  ? exc_invalid_op+0x51/0x70
[    0.620092]  ? commit_merge+0x361/0x390
[    0.620185]  ? asm_exc_invalid_op+0x1a/0x20
[    0.620288]  ? commit_merge+0x361/0x390
[    0.620383]  ? commit_merge+0x360/0x390
[    0.620478]  vma_expand+0xd0/0x1a0
[    0.620563]  relocate_vma_down+0xe8/0x1e0
[    0.620664]  setup_arg_pages+0x1f6/0x360
[    0.620783]  load_elf_binary+0x37b/0x1720
[    0.620912]  ? __kernel_read+0x187/0x2e0
[    0.621038]  ? load_misc_binary+0x225/0x2f0
[    0.621173]  bprm_execve+0x22e/0x5b0
[    0.621288]  kernel_execve+0x10b/0x140
[    0.621406]  try_to_run_init_process+0xa/0x2e
[    0.621545]  ? __pfx_kernel_init+0x10/0x10
[    0.621675]  kernel_init+0xde/0x130
[    0.621796]  ret_from_fork+0x2c/0x50
[    0.621914]  ? __pfx_kernel_init+0x10/0x10
[    0.622046]  ret_from_fork_asm+0x1a/0x30
[    0.622174]  </TASK>
[    0.622248] Modules linked in:
[    0.622356] ---[ end trace 0000000000000000 ]---
[    0.622502] RIP: 0010:commit_merge+0x361/0x390
[    0.622643] Code: 28 e9 58 fd ff ff 49 39 44 24 10 72 c7 e9 81 fe ff ff 48 39 57 10 0f 82 1d ff ff ff e9 1c ff ff ff 48 89 c7 e8 70 0
[    0.623213] RSP: 0018:ffffc90000013a48 EFLAGS: 00010292
[    0.623381] RAX: 0000000000000138 RBX: ffffc90000013b68 RCX: 0000000000000000
[    0.623596] RDX: 0000000000000003 RSI: ffffc900000138d0 RDI: 0000000000000001
[    0.623825] RBP: 0000000000000000 R08: 00000000ffffdfff R09: ffffffff82b089a8
[    0.624045] R10: 0000000000000003 R11: 30203a7367616c66 R12: 0000000000000000
[    0.624268] R13: 0000000000000001 R14: 0000000000000000 R15: ffffc90000013a58
[    0.624484] FS:  0000000000000000(0000) GS:ffff888263d80000(0000) knlGS:0000000000000000
[    0.624746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.624926] CR2: 0000000000000000 CR3: 0000000101c74000 CR4: 0000000000750ef0
[    0.625149] PKRU: 55555554
[    0.625244] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.625545] Kernel Offset: disabled
[    0.625658] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

If I add code to detach first in relocate_vma_down(), then
expand_downwards() has the same issue. It seems this code doesn't account
for such cases.

If I add code to fix _this_ then a VMA merge triggers it and... I think
this is just fundamentally broken...

There are cases where we change the size of an existing VMA and overwrite
stuff in the maple tree, this is normal, and we do it to an attached VMA.

So actually perhaps... we should just drop this check altogether?

My workarounds are essentially to mark detached immediately prior to
vma_iter_store() which seems to defeat the purpose :P

On Sun, Nov 17, 2024 at 12:09:29AM -0800, Suren Baghdasaryan wrote:
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

We should definitely add the

	VM_BUG_ON_VMA(!vma->detached, vma);

Check that is added in "mm: make vma cache SLAB_TYPESAFE_BY_RCU" here
instead, if we want it.

But as per above I'm not sure we do...

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

Do we want to assert it was attached before? Then again given the attached
assert probably not :>)

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

This is on a subtle error handling code path, we should definitely do some
careful checking of this (it might be nice to add some to the vma.c
userland tests...)

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

