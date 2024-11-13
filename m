Return-Path: <linux-kernel+bounces-407879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89449C76C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BA01F2100D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F153770E2;
	Wed, 13 Nov 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gfci5v5p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bNTpzBXQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F8249EB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511424; cv=fail; b=CA3mOcdZFSLQ9Xta2uSeTTP2G4/f9HFCqCH/mLT9SSDqGwmFrceGwJDmPyrEnD/apFM4NJcRpMS0Gl/DfdLqA25Nav9Fp8UjnLgQTybJWY+8Loy00z6/BHWgovC4qo+wRcInuNd2yDYMnF0AdqlR11/hnWU5yEku7lvaucwl4cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511424; c=relaxed/simple;
	bh=2fQzjn13j8jFNekzMv1i4aAihwLTQoVaxA+0v57jTvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mpgpO1UtGGdoLXsmydaM1gcN779IP6N+3G+v1MtYoPFcJ9rvZyKUkHQRo6beJDFq7rZYYT7TqbK5p2FkUerlbe7vslfytLsOVOGmOT/V0te1CHV96BLXikjCv2IgwrkQd9Uw1GC4UYLD8KBr0fjUGy9a113nlO+mU68xpxzouow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gfci5v5p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bNTpzBXQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXX3k013710;
	Wed, 13 Nov 2024 15:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4Id25lrqU8UV3J6dfD
	Gl6kpT5jqKj8Q4tANAPQtan2o=; b=gfci5v5pRYKh0XKrZ1SIRHuXwLZ4IOhcGr
	9ocI544gtFwSHMluCDUkOsuV2FDBUP3J4C0tnQcfEC9n2mhE3CgzlVfRYIj1piiO
	4PbAON7g3a5Od5rwnrJtb0g4ni39spD6/6uGMUYO8Da5xTl/ypoMsG78RiEgmf4/
	numsZdoDFuh5lEDQXFHwdLb3UUQdl0nydS281DTmMgnCNfNqpmfxfQhrw2VIjF/w
	uaZDe/uc8insF72j3cGXgUaPbA0ZWJA2ZpdKBnkZmyGxk+CIX4qOVRP7Yhmsm6x9
	zoMtJ2auv9rG3GJGoi1CrzcqAQ0SzUyuZIoC+PKmGkAbYIXzIZcw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbf5y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:22:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADE6lPw035876;
	Wed, 13 Nov 2024 15:22:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69f36f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:22:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha+ZDUamb7uM5zccR8q2dHrFyUZRB/hoRE8osja7O7yN6ijx4TQgihvHkV+ck+ivCJ4spmOeA+gfY8UggobaS6gnZRAu2EOXHXRNgGcRsKqtk2lV9cn/D9hoZoXXEzsyDQoD9H2WTxRNXC4vDtSnG1XlGcCDKjzid/eDptHpNq3kY/uUTLUEYdfGF9ehlwWI5yu/W05ZsxLXVBABp3mh5wFXAlFhGYr1FG/IwXXrKlEhIpZJvNZTZHrCOfEAUXoo2NFoMz89Hml7KhrLSjELSA+2ztn0Id8YyAxg58f2g0G0jtdmiBkQcCm8ePuKZFjRU+JOB5a2EaWEdrfy0jMN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Id25lrqU8UV3J6dfDGl6kpT5jqKj8Q4tANAPQtan2o=;
 b=As7r4tZjudsxIMGYF1EuqpRk3dnVmQL45TbHHYdnc1sRURgmd2ZqcJJX/ZHiF65znvF3roQDwJMIyENcVwQxC6sKQsEUjJ5UjrQvOhIKF7bCIkpTGUAkaaViuwKepI2VOKUnLYh143iqgoBGlzHIVMTPBTDp3FqsJ9vWOO/Ilr/VM4Zlnx0IxaRiE7Bwt09V5sYAHFNSnZ43d9QxalHrCJ2OvibXQBcLH/NIepecADY5hH1gXK9D64TTlHgBcLOJV/7WqKGMyY9eXcvEyMDf0m/r9nLZNixfXq0QNrVjCkG6fkuXWwi3UUA/VuwzbuUeZYSWJCG+012XZfw3ae87AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Id25lrqU8UV3J6dfDGl6kpT5jqKj8Q4tANAPQtan2o=;
 b=bNTpzBXQbrpSrasltu5dfmOOIOYzjgJB8LADMwmDaw75Th3NEzMT9IKTmwpHY8nhon9KoBjlf8psk0mEZpbuXUEWrc0XKGBIeHnAmTpLmJ+Sf5IsjX7xpHDSYspD3DdCAav7L400i34v61wnAgQXtSsoJLamXnM2agtAWg2O47s=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by CH2PR10MB4165.namprd10.prod.outlook.com (2603:10b6:610:a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 15:22:55 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 15:22:53 +0000
Date: Wed, 13 Nov 2024 10:22:49 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
        hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
        mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
        oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
        brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
        hughd@google.com, minchan@google.com, jannh@google.com,
        shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Message-ID: <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, oleg@redhat.com, 
	dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz>
 <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
 <ZzSwM5qwStadOZvv@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzSwM5qwStadOZvv@casper.infradead.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0078.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::11) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|CH2PR10MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb13001-9bc8-4624-6b3e-08dd03f70ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qq9F/hzrBaNideHN1inm/1IohcIleXV7ml7DlhJSDJ4pkc46fl6OJ+J2C9XE?=
 =?us-ascii?Q?pmUpO1zc15NEkAgC7TKhcIYfQcZHNw5fhQJxO59GBXYR3biNVtVXXjHqK6Z+?=
 =?us-ascii?Q?FzyEzhZCwoI8VXds4BslmQyMwqd2l8cpVzHKFiuRyvFTEEaUKqS1LUvtOCVV?=
 =?us-ascii?Q?oc31pWiu8wMczQCMQ9EmUCSziglI+QhNPu1gKvJm0Sh44VjwnhmMJpzGP7+V?=
 =?us-ascii?Q?MTVUF2c2ehZL63F9yM42c8sjQHiBGjKVgpFRSUEe5Eg8xIH0dCKTi0qJwQ8M?=
 =?us-ascii?Q?UOiNlwENINgaESEOp/Qjip3nHwnMuYTl7mVpZPaYh4tyfgN6Y3kvbrR6dx5g?=
 =?us-ascii?Q?LDp1qh4Blis98tbbNIM3S45il2VdE/90rr8TncBtKD+3yngoS3l45f5wbNu6?=
 =?us-ascii?Q?XPbCILiCF2EU5B7SicoC/kAAfvIN2M93WT8NOLYBNa2ybwPAbAipiXSMFyqW?=
 =?us-ascii?Q?garaouYKBkfDd9nTllajWZscyyktwXiWZBhiyUkSDGztoDfN4cC0Wh3hBQsR?=
 =?us-ascii?Q?aQKge7NfH8ajerfsnirT1pp2uPO9Z24ZPheZfejSTE6Ax0yQQ5YpTjEMvjYq?=
 =?us-ascii?Q?gfGWooh9DFkZyc2jP41qgGVyFRafRCv+epsUtaJsMjwH5yj9uvIvKgXw2get?=
 =?us-ascii?Q?qURIUCUtDprZEeKvFL1LcEQekUVPQfQGacvhuBElg8yf+EoDzXEdClo2z5rq?=
 =?us-ascii?Q?ypYECbBdO7GVE/rlR8quc+JI/FQ/Nb+ZtfGORJ14rGWlGjBPFVqWlCJL7dTB?=
 =?us-ascii?Q?rA/E8vNTWrXN2MlmAS0YoEx3LyyzOKBweK+IS/muvlPEiQubdBrtzQpzeJWj?=
 =?us-ascii?Q?Hk0EGLj4Naix0YMSaPPaU6hE0E9WmAC2fxxaFgJngcn3dDun51Vy9kxRPymB?=
 =?us-ascii?Q?ODn9AaSSj9M8Gcaeogva+BospeJW2mGMPv8omGwv0PG7qfrFilMZ2pMIkGVy?=
 =?us-ascii?Q?BM3/mxNOErrdZYAXPJ1vxvv230ChlvPeUpOpqylbi+HbjnD3B4Rmjy17QRPs?=
 =?us-ascii?Q?ItXyoxkrOdKHOOW9ihNEuJT6VJIN+q4CsC3PU6dbECPJpvzP6tDh8OaKFKQu?=
 =?us-ascii?Q?oyoQmPAFHXeIfeOslrpVUch0a3JJI7tLi1rY7pW1fWUcgQJyEMTpqibPkdxz?=
 =?us-ascii?Q?7qRB8PSo6e8EZ9+m2XonfLm3WqZAl9Ulw7HNVdMa+1Yrjyl6dtoWQAC7p5Po?=
 =?us-ascii?Q?nw0Zly1k9+GKxP5lhmvA2swPeYauL2i1xKHiajVkxGjNmHV/q2HewW38Bsd8?=
 =?us-ascii?Q?Sa37GVDJQp/fCadt4vbkyLnHhsHq//VX3rohKvMRhGNcgGohNYwYEHSiRL69?=
 =?us-ascii?Q?9YVwcjpsbUkZVZuWQ0xowjbOdiBQq1vRJVFZdG1qxytJxejEowpEdmiTcOHc?=
 =?us-ascii?Q?D+np5H8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gGPoehzwscxJ0PPggmdMJOWCDP2OoVq5LSKM1cw8b+Ddw4VMlxKbYmGsCcq2?=
 =?us-ascii?Q?899xhAUBdQ/CbYI4F8fiRMgeG4k85rjEZApzj4RzRiAwMmnQqOxH78vCxcng?=
 =?us-ascii?Q?JZj6/WMgTuFkT0IRJ26ALtw5AIPE1+RwUcVF67Rq4MyvlYuKfqEYwgaPw13F?=
 =?us-ascii?Q?wq3pcLFpD3h5hzcUceobtVHCGcGfliuyB9VvnbJMPLhA6qt+oDs4VcatS0H0?=
 =?us-ascii?Q?Jy3MsmhQiwpP0c4jHEFzee+O0eNINksX63OfGoNJApKFQlGHBkfizcbynpgE?=
 =?us-ascii?Q?okYlprzFMIBs8xE9STL7w5UwIXodNx8WrJyFCptukPx4c7WuUU8yKeQ+tk7g?=
 =?us-ascii?Q?QK9MUtdBBqKWsEKOmYJ6HdqgkfSdo6pVri+hWvBU0As38vKsYA0quc8xbnvn?=
 =?us-ascii?Q?O9g4x2X9LiN32GA9vszduD/wCZi4MeoSC8SbG4U7+gch1QDZGJVDTU+QFpTg?=
 =?us-ascii?Q?jbwVs8eSgN7DnPkmKdzm1Q36VqGveIqFbFxN/SbJ6MaQqH8HpKcVKNRSkeuS?=
 =?us-ascii?Q?VquULgOK3BypBP7DzIRdb5uOlTTErfkBgXFZwshLQ2ttbFzuCM5IhzTlxhQV?=
 =?us-ascii?Q?8ijpmy8KtSgAY87AQCbGKZs9+wc2tahw5CKASxVZp/89D8u8n5otebRqIqKZ?=
 =?us-ascii?Q?jdKVq1xwHjIrGQ7q6PsEVU+F2M+q9zUDLdUXmA1ONSyA8d2YiRtM8p0REWNf?=
 =?us-ascii?Q?/8z3SgzvBCfyKZWoTmzIJDaeFT0ofEqgbsU6Q+vKIQxg62aUY9KfuaOIa4Rp?=
 =?us-ascii?Q?FmBq7/VPPH/KVz9jhTycTedZLopqZXM5M5dgjoKUv2JbQdOi9yfQK0EEdHi+?=
 =?us-ascii?Q?BvUEd5rA4oUgNnay2Ylrd0xoSYDtXz2yMmsio9WArpuweyemORSXERksYIgg?=
 =?us-ascii?Q?5KsFiEoTFymb3nAE8xRHUn+vNRe5CaydfXqC2Pf8Rtdw+65ckrSFljgUbUGu?=
 =?us-ascii?Q?8ql/FnDimsLJvuAAUGHOO7lOWxYHHyu37SRMoy5Fg71Htx6zLhtaal3PHvwy?=
 =?us-ascii?Q?M98bL/4QknVn78grSWJBswHsLQY0BXMxbg/KdhRdC15ahAdrYiRFRpO2H9L3?=
 =?us-ascii?Q?tWiun8bXm+kODFsSB/06V0vCGZXORpZx1IBZLUTDKq6HKdx+80E9OTBgovnN?=
 =?us-ascii?Q?u3aHWmcAXeHAAGtvfOOKtCzSHzb/50txqRzARldAomn1EI/9Znzp8sYnAoKK?=
 =?us-ascii?Q?nQglkdIDUj5nPYgl9QILydAuQmUmQS1bzzSqTCjw7rf64HP71vLvzIKcRS3C?=
 =?us-ascii?Q?PypOiJLG0/judNfdweD9lNj0YnkubTWpXiih56+u5O4G0vIpKr/duYNcDW/B?=
 =?us-ascii?Q?qkJWKJo/gN4utaCvGr5tao14gXEMjI+HuoolR565EQexsc/ptAnZELVK+N9N?=
 =?us-ascii?Q?Q14znMEBqU4GLzQ66eTI8zAY9FNz9dOhe1tefE4tC0WuB4hFP+6iy5Fv1MqW?=
 =?us-ascii?Q?gjvtlmtBSj1lkuDdgevB2+uNL7NLLS/VRyqCmYxhmjdfyM4uYtlDKBBJ88Pl?=
 =?us-ascii?Q?4S3xyKYdGA5bNlUkofVj+qBFbW7pKpKtZ74wHKioK3op3K7ag1pOu9JNrea7?=
 =?us-ascii?Q?FMiE/pEm3jlCj27KTJJ8X5gQ+Yy2ZDksfIYKq6Yw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bgNjtsxuLghjrQdU4Z+NM7CCxdDdMHyq++RnTU6KakdluDID/dC3H8e6GuJr1Xy76/lob0MbYtcN/tJoKYbhEyGymiSsUx0Nd3hx+5cZbOaz4h2a52hzZaNG7cgiBuc7d94Q5EHgE5PGcVK2MfUk9epu0egyKVdlHHkVzdw87eItwywSsQ4ov2Hrwbcuz2mZXa6FYIISTIUfTLob3paLlUK01+fQeZfdIyw4GEJ65rKYTZdPC4/R4P8RLbrru1FrmeTAawHxiMCefO+d6E3Usqha+o0bB6GCAC1YCI+wIEd0YT+U+mizvNPQlfExx29pCQU9Mr4Ngf0J4I+q73XkZd7+jUFNpLRr/N1jfzAEkysktHf2ov1c8m9OSAKYpcxLjhx/OGlkogsADEZszB/rLZORaWFUjqP3VFOgjZuFKul76Fpovs1ixle5/3x0QORjIvMFmeuMdbWiimOFRNy8JXckCw8VtU9tn2QHk2Umu12eMoB6RBHqGCrYb5MBWMrpRTp1hxby5chLk8E0owshEzcvTFNUi+n+L8OGTTh+ONIrY2FCAOzZ8HvTjwgTB68VNAQvKg/v1OhgS2yvOMG2yDheu0/eNvLrFCSkFUBaFe8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb13001-9bc8-4624-6b3e-08dd03f70ade
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:22:53.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDvg/JtOopVB5NyVjeRk4PNJ/m7MblohSmzQxBb+EkZbOKYTQT32QoixALQnTQ1yv0T7OJiJv0CwKCubaawBrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=927 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130129
X-Proofpoint-GUID: Uwbbpa8uRMTr6-6E3Nhz7-Y0kr0khL6u
X-Proofpoint-ORIG-GUID: Uwbbpa8uRMTr6-6E3Nhz7-Y0kr0khL6u

* Matthew Wilcox <willy@infradead.org> [241113 08:57]:
> On Wed, Nov 13, 2024 at 07:38:02AM -0500, Liam R. Howlett wrote:
> > > Hi, I was wondering if we actually need the detached flag. Couldn't
> > > "detached" simply mean vma->vm_mm == NULL and we save 4 bytes? Do we ever
> > > need a vma that's detached but still has a mm pointer? I'd hope the places
> > > that set detached to false have the mm pointer around so it's not inconvenient.
> > 
> > I think the gate vmas ruin this plan.
> 
> But the gate VMAs aren't to be found in the VMA tree.  Used to be that
> was because the VMA tree was the injective RB tree and so VMAs could
> only be in one tree at a time.  We could change that now!

\o/

> 
> Anyway, we could use (void *)1 instead of NULL to indicate a "detached"
> VMA if we need to distinguish between a detached VMA and a gate VMA.

I was thinking a pointer to itself vma->vm_mm = vma, then a check for
this, instead of null like we do today.

Either way, we should make it a function so it's easier to reuse for
whatever we need in the future, wdyt?


