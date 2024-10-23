Return-Path: <linux-kernel+bounces-378650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A19AD3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24D91F23641
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790FD1D14E4;
	Wed, 23 Oct 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9rZ7PJq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v4igexv7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D931D0797
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707175; cv=fail; b=CODCLCc3ZeMptjmRtG6dmtVMCK1+ArLDaHrBlL/rhj6Re/m4BjNc84uTu7rMx6BqZcr23FOwaVfNqAOA1SSi2+Wt8PoMFEAK105Ikjoak8f+7RRdOB2YELgbKomKAeCT/dPaOra5ovbTDQ/UlhadSlkf+vLIGQfbp8zg0Fn4gaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707175; c=relaxed/simple;
	bh=NcfX3IGh+NjL3IL+RS+b7Jqxi4sCbcYoChwUDXzOueE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SpkVhiN9TFAVEHzhvQ6IuIR2qhth+Sx5DBMLlzmWITaV2XxSA/SexVmdr5vUddtcojxdwGJdyXKUCltnoN/9dR99b1Wf6z2tfxpd5lFZaNPCrGGxEo0ObG2/YGq7Squlvwjdiq62miikdL75XmsBebPGJ+dMdlT/r/CVGlBP0LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a9rZ7PJq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v4igexv7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfnRt026817;
	Wed, 23 Oct 2024 18:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=w7nhMY8g/gNd7RhHoQ
	hdlOHbPkse60Y6mWm9r5Oj17c=; b=a9rZ7PJqSMMEtecrCn6IRaYY4VXr5FOOO6
	+YOyjkWy8CCt9nyo1heegzDCE2q/vP6TqsNZg2XZxaxKsJ8LJbF3UUNpFZhZ07/N
	p1CCvrAbGNqpFCVgenYGARi8sZ0zkRAS5+eEgvaVUNGXkPpOjvkd3oSt3aVCJ7Nh
	/bfEfyAYsujVbOUaWGWubCPvaF9Jsc2ShOqg9bz2hfEQwh+sudTMOSDiqoV08S/i
	H894rclkM7bLKJYRMjjbD3Capnnqw8lsoH4UfGswYXwU6Yw5XRjlepe6rxxR7/WF
	qx/gsJewsDAtKRSSx+3rl6AwVToYrdbUngd532CuYtIfqlF6Yscw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55egpyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:12:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NHJka1017761;
	Wed, 23 Oct 2024 18:12:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhjw8p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/YudxCLr9l3fb+s0SE/BOVXchScgJoCmZD2hu4iANlaDlzUFY980W3bgBl2k4YTY1uwXaI4LutFDwf4D62Aq0S/4HnYRxjCd8kpAj30b1HB28S9qyEAuee8WiQf32cX+yD2VQ2r8BI7w+jMsJyTuK9XcS7sz255SLtZxGFFDCnPtjjPnE0iiiG5azOhOfJ++UHCX/VVmXz0fqmHWkDcUxiqwsVdXg8CVZX2tjge2KSghdZye6xxKK0sqDNnhK9NQ2BYIBkm/Q0mexU61TjvK09LByIQXRNSIShVbqUz2AkG4ziXKO4tYDCjnyOfU1u+npfAwWJpJ6QNjPHI8asmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7nhMY8g/gNd7RhHoQhdlOHbPkse60Y6mWm9r5Oj17c=;
 b=qhHLfSbDbkfD/i0HJ4j6NL2X/dgeZJngTZRPLgrm0Ht9/3EqT6xQMScTXyTnlM7qZVYxzdQxCbx007Srif8jbGzS1AIIOLgSIVYTNzU913LL89XD0xEWLkrDxDjdqRtzFdVmDq7WKb29ejw6CSTHEpjIk1lj7vJOJEVxw/JP+Nf7Az/yffdxaecPP/I4qfG7yl0o+5M99zpt5URNJaGBRu0Etb7gIrEnPf87FAeNFfzaKCYuv5ieNkeKDOhamskgGSCPOrpxzNne82whBQQxF8QvncM1i+pFA4hdl8WEEC2hBsZsgovMVuqSCOSA1UEWZqI7Unl3Vx6xJrsOriIU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7nhMY8g/gNd7RhHoQhdlOHbPkse60Y6mWm9r5Oj17c=;
 b=v4igexv7UzEx22P/orY/PtZNmwgEm1hl6pxsHOrLqmjuAY2CgfW8vPU46K9wqDYLl+xO77VOR5XHt1IhKPn+NSPzSOuwuZGw1u8NETXiQZ4xA+pO20zkPJiyBROyCIZEpJcbqefbKEvS5nFP2wjb1CKNe6IHv5jM4zWFkP2kQNM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 18:12:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 18:12:22 +0000
Date: Wed, 23 Oct 2024 14:12:20 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 7/8] mm: refactor __mmap_region()
Message-ID: <bx6t4tvyhxf7w6bmo6jo6ztuolxjzdsjiy3ivavihk5yagac7d@tirovba2c5mo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
 <81712eec-440d-421c-93b4-8b6d9c491693@suse.cz>
 <oubvc6lpzfkrryt3ai6xp63aqexymi3nm42aq3tljj6d7sdart@x5qj44cgtxzf>
 <23f8b278-293e-43be-b61a-63239be5dc59@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f8b278-293e-43be-b61a-63239be5dc59@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0435.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fa5b3c-3170-4e65-f95b-08dcf38e3d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2Zl3KcInPuNKq6nebPkzk+sDWYr+Fq+GmWYs5Z+aY03VXatlsLdZaqR61OD?=
 =?us-ascii?Q?TrD2c1XMXGdnEgPdi0pk/cBIIxnvhyGiEtapCo5BSvl/54/rx2dKNOKz8tgg?=
 =?us-ascii?Q?PR1ehrFqIQXNZTiVsFue9Id70Dqi1X9PKTQXQORsfY1JeLS+HwF/FFUBI9ou?=
 =?us-ascii?Q?nSDNPU/O8tGo1uz7s2+yWw++zJOPk+kKKb55oqVlo26e/t2VFBec7pkKhSsw?=
 =?us-ascii?Q?jDVRv1BQ90BM8WfanF6yU2qm61ecky7djQsLSvuYzH0dC1R3wa7yTSTSOYpg?=
 =?us-ascii?Q?tURROzXs7pT/aBmOJtvrTFKnAwU+iSsXBQR63R5BfBykdeNSicwRw/ol5ssc?=
 =?us-ascii?Q?Bf5ErUDRoHn5HTBP+LFLAAElW0r81QzXpBUD/rSwgVsM256D2+5L4hebOCFx?=
 =?us-ascii?Q?IC6Kcd1JnhaFegV88mSTXhdTuq60kelnQXeuMpWiTgiKbpeLMMoUQcmUVljh?=
 =?us-ascii?Q?2HgoImwtRmRb9T+tFvw5ZSsrAk8axvIU+dwpEl7M2zJot39e3eFIFW15eOsZ?=
 =?us-ascii?Q?bNLkEO6S9Miid/IFGFv0eAtjGEnuQON1PTJnhHwba3eU3On/ORp65iKACXft?=
 =?us-ascii?Q?XGv4wq1OlVxtOco7MIV3rAd04c9l5hjIm4f8BWA0q7UqbB+4tXoqeA/Z0+k/?=
 =?us-ascii?Q?/hZSW2x4TWpJPi/Tp77bG7vokBK64NAg/OqXuwNBfuyUTk3cP1DIXZr6zBNw?=
 =?us-ascii?Q?rlzcDHNEwsS364K4WzPZpGzRft9h23SSLFgr5fTp63VTk+MOYXn61IEHLSxZ?=
 =?us-ascii?Q?LasKfL97z5ItioCW3IvNOvyKi92mQCdWryoN1BVKTe7drL3ikTPfYM9+7nNo?=
 =?us-ascii?Q?OOwdD9RjqQdpN4cIknQlA5T4jmz5rn+bFyt1ogZIwPaSP8BtfGHKA0x3x7Bg?=
 =?us-ascii?Q?aQDusEHNs0f3Jq3MwVZs90kJlMMTQ2fi21mrwnUfRfTz3rcIIRcL2hVe2/X/?=
 =?us-ascii?Q?8oKW7C9sbekdOPd8Sv8MVL4aKgFcs0TWF4AcqHPoV/bzzVIpRnsR3hZE7V0n?=
 =?us-ascii?Q?RYbhcP6762lRG7d7GcmPBv2ycn8rDoZsgy5EuCnVwghcOeWPlrvQqx5c6XwV?=
 =?us-ascii?Q?5lOCAuOysNln6zMHYhZFDPzmvD3fmqqppQJWEvudvP7QMe0CeDNB4gdgWZmx?=
 =?us-ascii?Q?GGtSDe6TYpEFLgawaE9jrhR7R07p32gfcsYRKZOz1wQhq6tPss3zFd843Ae0?=
 =?us-ascii?Q?tjE1tZEasPkllpWXX+/rvkmxdt3Z1EvSI3sKCNzfmbH0vnR2Dk6L+z0pyl57?=
 =?us-ascii?Q?CT+Ybh4ca9icESLn2g7HtXgR2ivENdPddqAAX5PDUNhqrzkVnTQmTY2B5CaB?=
 =?us-ascii?Q?bSJdtL4fYDjWtaBxyR3a2kGF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yo8GTiUvg0dEZAawsfpRna9ckeRkPU7CxyDmlUyic8N0Idz+/BjvlBqjgina?=
 =?us-ascii?Q?Nh9794CLUA7INq+6DRA7ZH9b/xsWSCho9URrE/g4lBLVtU4OsfbaU2mymiZ4?=
 =?us-ascii?Q?0O/jM7aiG9zz93kbTpzDqr1UOOceEuDFCXMzEUXCecFH5SSpUWwr5KkYFwgB?=
 =?us-ascii?Q?BIoS8bdligGjo/5XsRbFMp66uBFh8I3GW2CyBmVct4wBp66rL4mXj1tn4C9t?=
 =?us-ascii?Q?EUcIzQtsDiAGMEckZTmIW9PFsDWx+S+30DishgARzl9fLEahh4Uv5SmhZZWk?=
 =?us-ascii?Q?CnbdCVu68IGKUHis9RZ8jORLlZTGPYNj/BgSYVf26L2zv/thQwwyjpEsFl5I?=
 =?us-ascii?Q?Kmjhpc6SuN0kv+2WEej1Cgkgv6fVG8zU6Ch4eV1XVIAJ03H1qjQPCMOX3cpY?=
 =?us-ascii?Q?dRa7W9iem12oBte+fvng3fQ/yEXOe/M57LWyGK8zUbqxptiS8FBCkeyfYQXk?=
 =?us-ascii?Q?h8HdcGH/3u60IETNlKd+8mO2/adSIqkjOp9dmaCw9IwNlz3ZJ/2IM0tcVxZF?=
 =?us-ascii?Q?CV43kKYLVE4uprYBiIg337O0JmLrG6AeH5sakOKs9HD5xEdQ7vw5rF7ubaQ3?=
 =?us-ascii?Q?+KwafaRxtcm+pbe8cwUwhwkaQH5AFLpnd6WlA5QDx3O6MdJivb/RHF6nIFbe?=
 =?us-ascii?Q?lz+ouCRUQAiDAy4lA8wTpMXwK+Wz6+SmKZdRbso3R+I/cHxYHv6qtqU+WWjG?=
 =?us-ascii?Q?NBzK54590a3BjvyjudHwRWj3+nIn0BvrlKLgZ0VjROhESTVdXyjnF7iZZ3Mj?=
 =?us-ascii?Q?v2CJ8qlA8hYFLJfD7iLzDgu1+t2XxTaI21CHpIADkallc/PYbMgRGCwof5zf?=
 =?us-ascii?Q?UpT8UEiiyVUXFHRfmJUX15dFUogjNi0mwJHWI5Cb0nGi+JlDJLCqmk5bK3Fz?=
 =?us-ascii?Q?cVHRvW6gChwkl4V//AVFGTbMDICSKz5DAY9JSbVL4HhfbuatmyrgJAEgIihs?=
 =?us-ascii?Q?zrSfWBEpgZ3mP4uXH4ihAALAIah1C2wf8L6btAa+sqoV2EZt/cV4HfV4fAzk?=
 =?us-ascii?Q?Y1vSO6XQKT+rjm9X9S+hamnpQ6qukmEGqc0ATV3pLRUmbqqUWrxiRgQO+TAq?=
 =?us-ascii?Q?3JycOFmORYJBCTLCEEnsCjnVcMwJA2QGY+CplzqeXEeSikonrTkaDMLH5T8D?=
 =?us-ascii?Q?vYCnOJ3LL6L379WVyvUE9nvzJT56V3zzJbMVObnJM/WlJXid2xz2qSYs7sP0?=
 =?us-ascii?Q?aQAgATOKp/8+ckuWk1Y6mfuoGnHS3CN93KYkTY3xws1e7dpv6se1fBVTEGje?=
 =?us-ascii?Q?z+2o/7co2CiMITsxD94e2LN2JNC+ikxQIlRLevSt6j3ArJoInjLNN4jR/Tso?=
 =?us-ascii?Q?VBL8NiydwcH4sl1ayY47mVzUXoHgdCJ1Z3MN0p+l/2eYfexpwWuzKocW4Hp4?=
 =?us-ascii?Q?lUK8iCsFCZq6QCTLlOiHft51U8LCw3K5UXRt9IzvRHLKG1UtfjBNHO0+w3k8?=
 =?us-ascii?Q?NAAqmKdzJ4Syb+vaoY5uiU7LGB4gDeTxeDD2hiA99zGytEtQyXno0/K+COU7?=
 =?us-ascii?Q?rnIsusj9sRRPFvo/vF8B/ge7KlYkebyZhxVcmTlThns4gQG2jNtRrx6DBkkQ?=
 =?us-ascii?Q?0jqIP8Uc9D//bNCrvHgdog6pXK+gvXjv9MyJzUxv1u2rt6YyqflAlaQjg6uK?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DB7EpqKmU3ge6hsNFWeAgg/LRQ/HON6Mhn4XO/vZuV1WIBs9NLEFil1ud48Ph72IgTMznHE31Upjc/SqVB8zKEYEY78u65a4M9tN7HiCXNsNG8KQX5qCSZFpdIxIGc1QmHyBU96cTCrhBNvaMXcPdrkenyfmWuYid+BqB7l+lALt6fz0BI5oULOGyhHJO5nnGbXtN6+05yKluLtEi375trZCz+Jclh+fbaLlaDHM6ocEw50kxlwpQxwN1VQkfdcIJ0gE2HAI+ZR0aAqY/biW77x5vfuQ9+pOQRxnwt1I1rcoc732LYllFjH8GG0kO0DmL+vHJAJ3BnOzxSulujMwQXGBGlbE5WU5j5mK65EYREktN1kX/LnRl9U3ODMG64zxQ/aMDsAs1rkh8+RV2CiO8p/DJiYkGpf3yC3xD0ddmuZGRvZq4NktffMTRPgVCG5/tbReMhJblMx2PvIP2MW2Tl1Tfldcw7skJMu+3rAL4kodOix29Q+VNAZB1nigcBwVY30SXlKzAWrv9maGwg5AcNp4ogIv+gBJ7v2pZ7cG8y86fbpTotZNyy+Wnkt4QhwrKXwN6rISxuuvtFBSzHKvVH7pRiMX/8vejBibpQa0uVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fa5b3c-3170-4e65-f95b-08dcf38e3d70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:12:22.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDQVsqVI2OSn8vdsYod9GDCo9q2UHAiAdJEp33VAlEm4pEwf3IsKsspxk0pl8k3fAJoxsz00nnYWAkyISjZg2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230114
X-Proofpoint-ORIG-GUID: 4QfLrt6fNhXvECkfZLFbJSozoaqnw17O
X-Proofpoint-GUID: 4QfLrt6fNhXvECkfZLFbJSozoaqnw17O

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241023 13:39]:
> On Wed, Oct 23, 2024 at 11:21:54AM -0400, Liam R. Howlett wrote:
> > * Vlastimil Babka <vbabka@suse.cz> [241023 10:39]:
> > > On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > > > We have seen bugs and resource leaks arise from the complexity of the
> > > > __mmap_region() function. This, and the generally deeply fragile error
> > > > handling logic and complexity which makes understanding the function
> > > > difficult make it highly desirable to refactor it into something readable.
> > > >
> > > > Achieve this by separating the function into smaller logical parts which
> > > > are easier to understand and follow, and which importantly very
> > > > significantly simplify the error handling.
> > > >
> > > > Note that we now call vms_abort_munmap_vmas() in more error paths than we
> > > > used to, however in cases where no abort need occur, vms->nr_pages will be
> > > > equal to zero and we simply exit this function without doing more than we
> > > > would have done previously.
> > > >
> > > > Importantly, the invocation of the driver mmap hook via mmap_file() now has
> > > > very simple and obvious handling (this was previously the most problematic
> > > > part of the mmap() operation).
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  mm/vma.c | 380 +++++++++++++++++++++++++++++++++++--------------------
> > > >  1 file changed, 240 insertions(+), 140 deletions(-)
> > > >
> > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > index 7617f9d50d62..a271e2b406ab 100644
> > > > --- a/mm/vma.c
> > > > +++ b/mm/vma.c
> > > > @@ -7,6 +7,31 @@
> > > >  #include "vma_internal.h"
> > > >  #include "vma.h"
> > > >
> > > > +struct mmap_state {
> > > > +	struct mm_struct *mm;
> > > > +	struct vma_iterator *vmi;
> > > > +	struct vma_merge_struct *vmg;
> > > > +	struct list_head *uf;
> > > > +
> > > > +	struct vma_munmap_struct vms;
> > > > +	struct ma_state mas_detach;
> > > > +	struct maple_tree mt_detach;
> > > > +
> > > > +	unsigned long flags;
> > > > +	unsigned long pglen;
> > > > +	unsigned long charged;
> > > > +};
> > > > +
> > > > +#define MMAP_STATE(name, mm_, vmi_, vmg_, uf_, flags_, len_)	\
> > > > +	struct mmap_state name = {				\
> > > > +		.mm = mm_,					\
> > > > +		.vmi = vmi_,					\
> > > > +		.vmg = vmg_,					\
> > > > +		.uf = uf_,					\
> > > > +		.flags = flags_,				\
> > > > +		.pglen = PHYS_PFN(len_),			\
> > > > +	}
> > > > +
> > > >  static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
> > > >  {
> > > >  	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> > > > @@ -2169,189 +2194,247 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
> > > >  	vms_complete_munmap_vmas(vms, mas_detach);
> > > >  }
> > > >
> > > > -unsigned long __mmap_region(struct file *file, unsigned long addr,
> > > > -		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > > > -		struct list_head *uf)
> > > > +/*
> > > > + * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
> > > > + *                    unmapped once the map operation is completed, check limits,
> > > > + *                    account mapping and clean up any pre-existing VMAs.
> > > > + *
> > > > + * @map: Mapping state.
> > > > + *
> > > > + * Returns: 0 on success, error code otherwise.
> > > > + */
> > > > +static int __mmap_prepare(struct mmap_state *map)
> > > >  {
> > > > -	struct mm_struct *mm = current->mm;
> > > > -	struct vm_area_struct *vma = NULL;
> > > > -	pgoff_t pglen = PHYS_PFN(len);
> > > > -	unsigned long charged = 0;
> > > > -	struct vma_munmap_struct vms;
> > > > -	struct ma_state mas_detach;
> > > > -	struct maple_tree mt_detach;
> > > > -	unsigned long end = addr + len;
> > > >  	int error;
> > > > -	VMA_ITERATOR(vmi, mm, addr);
> > > > -	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> > > > -
> > > > -	vmg.file = file;
> > > > -	/* Find the first overlapping VMA */
> > > > -	vma = vma_find(&vmi, end);
> > > > -	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> > > > -	if (vma) {
> > > > -		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > > > -		mt_on_stack(mt_detach);
> > > > -		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> > > > +	struct vma_iterator *vmi = map->vmi;
> > > > +	struct vma_merge_struct *vmg = map->vmg;
> > > > +	struct vma_munmap_struct *vms = &map->vms;
> > > > +
> > > > +	/* Find the first overlapping VMA and initialise unmap state. */
> > > > +	vms->vma = vma_find(vmi, vmg->end);
> > > > +	init_vma_munmap(vms, vmi, vms->vma, vmg->start, vmg->end, map->uf,
> > > > +			/* unlock = */ false);
> > > > +
> > > > +	/* OK, we have overlapping VMAs - prepare to unmap them. */
> > > > +	if (vms->vma) {
> > > > +		mt_init_flags(&map->mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > > > +		mt_on_stack(map->mt_detach);
> > > > +		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
> > > >  		/* Prepare to unmap any existing mapping in the area */
> > > > -		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> > > > +		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
> > > >  		if (error)
> > > > -			goto gather_failed;
> > > > +			return error;
> > >
> > > So this assumes vms_abort_munmap_vmas() will rely on the "vms->nr_pages will
> > > be equal to zero" mentioned in commit log. But AFAICS
> > > vms_gather_munmap_vmas() can fail in Nth iteration of its
> > > for_each_vma_range() after some iterations already increased nr_pages and it
> > > will do a reattach_vmas() and return the error and we just return the error
> > > here.
> > > I think either here or maybe in vms_gather_munmap_vmas() itself a reset of
> > > vms->nr_pages to zero on error should happen for the vms_abort_munmap_vmas()
> > > to be a no-op?
> >
> > Probably in reattach_vmas()?
> 
> Hm, but that only accepts a mas and seems redundant elsewhere... am going for
> simply resetting nr_pages for now and maybe we can revisit if needs be?

Okay.

