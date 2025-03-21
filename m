Return-Path: <linux-kernel+bounces-571779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39418A6C22C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA547A58EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC9822E414;
	Fri, 21 Mar 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EmbymvB4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jD8cvAM2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B622D4F1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580702; cv=fail; b=SbqxjEpe2dNYMoEyVZtvfJ4AEqgKPDdtfI5FxIpv7X19H6X13d2UEdOSmffDkt5nhZi2C2Zj+xJYr4VqzJ77+danBlw/InzSGgB9XVA/+MC41lFRG+FVnuUF073r54f+nNLK0G0mWp5IJnsBXPmGnbR5PdtqRziYvcZAX2ruxig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580702; c=relaxed/simple;
	bh=0LULwrBx2WPPqv+bz/xgwZYTgFO0gZnnw55i2b7obLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCaywZaNhzsJS0E3OXnDlsNg7wN7PDLJ3WHdt3s8gsnKla+HPdXCHwQ551QS7XrLQ4BTytdMmtzC4oKXO98lpEyey86pyFuFuMAlPD63LwfmGk9u1/hhVwYnE8KdoO9gK5d6Mc9IzHzImLruhvljTdAYe7++zkkRa57RpDmX/Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EmbymvB4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jD8cvAM2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEBv9E010163;
	Fri, 21 Mar 2025 18:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=luBnlfhTPb8HMwRbvt
	SSPi+iBA07axzUODmxeCGqTqY=; b=EmbymvB4s72wvkjFcTJIsSjMUlKsTcYwVW
	lEquQ4YcpTs4zalyPPUkwWBFLLDj/BWSzsJlVjhK4wWLelgEEWI9ghjrt+tukgta
	lrWuVm3fDfXL1rEd/d32ZgV012n79KB9TSCIF5JE0orTY9jSilqt7Ott3Kx/0tms
	O7PlEjJ1V/ol8ZzhM0O1XTy+D744b5ZPj6pZu+aZDOOqlXjQxDp918QPRRfwVwSb
	4weQ5OIDWr7kbUFzQMuQSbEEonwDRChpwDO1yy/lIlzAzyJJew0wIbJv6dds7lpq
	u5LL7TwV8Kz0E3sVZeWlGRsAd8Sb85/CGyZySen5Rm+8hN1ZeQNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hg95ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 18:11:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LHtJLQ009582;
	Fri, 21 Mar 2025 18:11:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm4ebjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 18:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qouLcs2FriLWZpAkR93W21pAsDQ/o92RYww8xMH4NluBqQI78YCArpLYfGdxMg7x0fQy593iEfu3jwZ0OGRA8JWsco9WkbEjp5X3fRWwUxZ6rh8pacP6xkBN22Ijasrqbe/0Q/b4O36T5ljkwo7xwbIjpf2JhKmiWTB7h3LAwJD1jUhOvF+j6KHqAerZF9ULE7Hh+EVflM519zKGLnYn8DjWWsXk1d0Crt8075C4QYkKMwMdTrMsq84i9mnhemUqCk4RMOSSauGAOVLIY+j2gzm4PU1mb1K+gF6RrccxG0bi2Upc9/M7jHgRiu7ZNTab5BcT+qpWImnFXEUK7Up4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luBnlfhTPb8HMwRbvtSSPi+iBA07axzUODmxeCGqTqY=;
 b=niggd/SsL9lX65gEvpsJRu3lcoOk6pnlFuoiizzRHCGu5Mgc/A6p35jAEWlkO5vjr2xJOSxnGHLiqOB2Rvy0W/DXGowPPn+n4PVzdClF8So/0NHVScFXgVlUxrovLxx4qxBncuwujfAhZZb0BkPm72dkykg2ii+sM2Bt30/owxFc8OOGV5BmlzawVEPT+UlqVJ8ABEQ7dKlziWJilVLzFponYr5Apk+m9nW94Pj5nFdbra9khBi7zOM4h48Qa9A2tcQIXfszPkvI8eKu2tnqvkL+aPJasxE11c+Xmx+g+dsx4q12k+WxGGx+wfX52J9NW3lTPadfYUvZfe4X8hSFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luBnlfhTPb8HMwRbvtSSPi+iBA07axzUODmxeCGqTqY=;
 b=jD8cvAM26RIk0rQ9k30XLvir9L31WC1+7Hf+ExszBVheYU7UR4xcLh9Gxv+41veiG89WSRfdzEMyY8qQaXf4IJ0urARB4f9XMLmXJqmqhL2GZmXbSuPSe48V/cp2VSGdTQauHfk32saBfNwIreycBgo90foM0ngaDrDKjecQBk8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB7387.namprd10.prod.outlook.com (2603:10b6:208:42d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 18:11:10 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 18:11:10 +0000
Date: Fri, 21 Mar 2025 14:11:06 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 6.15] mm/vma: add give_up_on_oom option on modify/merge,
 use in uffd release
Message-ID: <uqfhdwbk7rm7p4m2iozi2vbnkqrmi45qyup67eopnt5klszjq4@4ccmlhjha6t4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Pedro Falcato <pfalcato@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>
References: <20250321100937.46634-1-lorenzo.stoakes@oracle.com>
 <233o4lohzhriye27szk6mucduneuvosmnp6pmnjepz3enxjgtt@id6kwhjgysbj>
 <owmqbntgrnwzbjuyzq7r2it7isqjvskq5svvdiosfd6mjpiowx@gm2lu3gol34x>
 <494b3b71-4331-4365-838c-84974bbed32f@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494b3b71-4331-4365-838c-84974bbed32f@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::19) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: 0643731d-9eb4-40b5-c60f-08dd68a3c1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+P3yFeDCsC9Ba38FsD30oNGnDXjKm+kiL2gu5zs5r18jExNFbLPa6Ng7B6KB?=
 =?us-ascii?Q?A4oB0hFhpcTay83kKh0a7uDcjfPneJFDqWsH0fFByaapV7jDWTNjUy001Gwz?=
 =?us-ascii?Q?9VIcX5l5lcayjQ4pH6uElouoqHcZSa294r+nGGVxNXgzvbknBOueTmCjyYCk?=
 =?us-ascii?Q?jSpsGlnxACEYMGJk6/4BvjAJWtTb7+BuR7IqcF+wH8LfrUOoB7b0uhu4/ReH?=
 =?us-ascii?Q?jPQNTaF47AYkEdcgxEGCo121Ele/fy+HylBoBXaXra2rmnjrZgYD0Sxl2cjL?=
 =?us-ascii?Q?YQ9bNJLaDVoEdT+NyVCL7YoN8l/wD2HxHNR9RGZY1IjJvs5Fi464p01jeev0?=
 =?us-ascii?Q?73M0lAReMjC2JzdDwVj3bB9AZkWN0GWD2fkiHw25mXaXRJ1cinI522IPFwK3?=
 =?us-ascii?Q?ds9H0832zhIqjF3y2xifISPQVAM+KavScFylKGH7V15Zz/AQbEwBGe5wRyGC?=
 =?us-ascii?Q?sa79hwerzEieazApviIuTumGgZUHm30kQVmI8mHmViPA/0bHnRK3d/IW9/ZQ?=
 =?us-ascii?Q?col3KAhhnW+ZOw7QQE/SUJMURe4cc5+PKcYdrzbunaSQxu6Sa4m88g28iRon?=
 =?us-ascii?Q?Xpf8hN4+KA9ZgMObYb0ahEojJ6lfZp4LyiT5O2TCuQEhz4PrGtVIqlAAcQtU?=
 =?us-ascii?Q?t0sTe2/AyEVV+n4ma44BO8YlJPvDdETtjnWFEQYYBfFjzl4+VYTEo68YOw5z?=
 =?us-ascii?Q?cq6vLOkuiBezWP2tvbgsUaM6ioGqtE9gy7SEwdaaJGlxab1uZyTQu2hxS3KH?=
 =?us-ascii?Q?GIUC6kCFgFLaZcMkRcaW2kwm6fVaJhAIlGsHU2VwEI0Yvcflf54rRQGY/37q?=
 =?us-ascii?Q?qsENpQ2wmH0eXtpA1g0NKoWLRtdlIwmpkz28YcnEQHl44E4/y+io13xGP5/n?=
 =?us-ascii?Q?Jz3K5h0Wiv679iGc+mQSTNxs+zSQYubW66JM2dFbgbZw8H8bH97OMTTR+SSy?=
 =?us-ascii?Q?5lOUIkYdwAgwnRNqffv4wBBxKCLzavMIzTZhkWs3SA5UOaHRPxJhGWCIEUXj?=
 =?us-ascii?Q?DblCCAQsEYoaUVG88QhUwZY7onuAn91KNoAbCT53EkB/QcCVwWtMYNv2HdYK?=
 =?us-ascii?Q?2uOsZ7NKe/u6bCn+rC7FLYLCf/MNf4Pxhj77sD/MCqLSAAX/nUsshd1YI5n7?=
 =?us-ascii?Q?7GDUzJDzZgKmiwrLWZ2OBAMiyWLoJCar127LMjbpNcV8PQcJns2fHyo4CCO0?=
 =?us-ascii?Q?7nehdvsABAG8gOh0wOoVXNkXSqBViBfBJFuqJWapdrFjQsECmmdLTrstDc+L?=
 =?us-ascii?Q?mUtO6M5TxDK4vhzTDUbegxQ2gHPkTHTx3WaWaBFhMtlMTq85ykl1LA8X/LWs?=
 =?us-ascii?Q?wpBbY80/57VvPq3/wm/Br/SL4s5SLExGrEMxk4ztIOvACwXXoFS1wpb+rU4t?=
 =?us-ascii?Q?i/YzaSaMY0hQgv9mN2VbiUKURXry?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?85l6mEPpWQ5r7NjmVGb4MN8K0fCX5Ft7hWfVJEkYVgu7xBQCAUskHADbPdCg?=
 =?us-ascii?Q?318XUALY6I20A+z9xuYl0Y7b9RtVn1h4bNCVp0/eyKrXhsUgygIX8L7u1lnq?=
 =?us-ascii?Q?Wg0az3MHHo+gyhgyoDduynBdYKMzGPDflKzqKj7+uJmXiEco5kOwYOi6/B1z?=
 =?us-ascii?Q?Dz5TLeMnqsakCEFZPBvx0ThzLlkguKCq2ovtVx2uXoLjUJl0cgR3FXxM1cA1?=
 =?us-ascii?Q?21bb8IlijmjKQmW7aoDDDjnDtegYTj7hWgJ8nooGGDmuvCaYWQrpf81eMHEL?=
 =?us-ascii?Q?NJQou2crh8GipmYEmXgFFcEiRnQa3DtipRR6R7YypUD14/bKwdSoQcmEJ1cR?=
 =?us-ascii?Q?Ha0oCxTuBwaD4l6Q3ZW/VTZC083/J+1k0wI86zsA9a7KiKaQWw169WRWFHfU?=
 =?us-ascii?Q?JtMlRvVjS7DURHFZHyp8G/KimiBOHXCfNwwk/b10mMzy5+evXSNHabgtNEjE?=
 =?us-ascii?Q?F0EWXKHxMgsIeY2T6lLTeZPXKA50BaJLiVAF4Yvu6p0gfdgiTeMxU931b9tT?=
 =?us-ascii?Q?ljznvzvNzV47dr3m4PUvpbX4anA6h5ocVrW6Y+gd30zxRhFeaZY1ajk7zwt6?=
 =?us-ascii?Q?+bv5aWTVljisS/dvy3hcHRlYGv4hp3Iv48TmboqzhwKQXqjweaVgY4h6hY6t?=
 =?us-ascii?Q?tvim5NcoUeM3F557ISCf0E88238qeUFgYW3xPyPMWFxQA5z25wC+yzD0QMU9?=
 =?us-ascii?Q?AZ+K4G20veQnSpDqzgSkytnRsnaCivHcdIV2Z6e0E6bQLDZocV6JnAwnXXBJ?=
 =?us-ascii?Q?Vgt2agW4qVaUUhL2lIW/rxVOB+ABEJyThnFTz1747qeUJmtElbnLsMc5pA9m?=
 =?us-ascii?Q?LSXqQUInkU1dWPlIxZlOM7oXYpw7TjDmsHa3kN0YP5+cGbXGeiU6stWL7Fie?=
 =?us-ascii?Q?8d3kd/29uwJ7UYukljEDDte4cbgN6SA8kKovzgkiySPdmVhp9784ThHtWo1v?=
 =?us-ascii?Q?iJTIO7joPrIAkkilXQOT45YADJa50aQgN2Ird5DSx+Ir1bdyr1tpQOBZWLfl?=
 =?us-ascii?Q?0TYDgbnt7WAZZITQk3o9xNmpC1Wlrkkgn3Us+UuaM7og04DvJKrmrHRU8mXs?=
 =?us-ascii?Q?CLt+xk+hCqln/PHzF4Gd/I3a/bGq8JBvWEBomBPxR6KTuBo1FQvxXHQhRw2L?=
 =?us-ascii?Q?g2QUnr4I3RhS+t7uSdc2DVPOmEi30A+x0su27fhbjn6eKjgQboApEigrqcXA?=
 =?us-ascii?Q?7GFDvqAqVNh9b+joWrM8hYxqbxYCINiR4ZYe6qdeBLcWRz0IedOF4L0naUfa?=
 =?us-ascii?Q?/fvDQ2PH/R0XvhfRKyLCezSSzFuGvuh1ge/1o3Np6wjoRdxYeM2iq/mhRKde?=
 =?us-ascii?Q?tE3gb3FPQJ37XHoqLsjoiX/AardgIafXVM56OpZ2S/KYkiAdHaCTp9UjssBc?=
 =?us-ascii?Q?Do+0Hbg8OKu8QKFOLULJFWALOgAoTljnI+xpKT6mqKxhKJI5NwUUKtx6e6f/?=
 =?us-ascii?Q?Cg5AiTLuunLw6YGlO9Diki0BA+O5GMry/Vs5y4f4znG3wne0rk/MQEMQy4l9?=
 =?us-ascii?Q?c1ZfzQQdjp6OMPTSql96TqWZPkUa0OsFxghUGu2w3fpLP7btDdSQpb5rKPTM?=
 =?us-ascii?Q?FJw3PUgzNPp4CDKgkUw4i+QDUn7N7jNgyggCgCRt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f9dzR6Ng8PhUdr+QMlQ0gNlD2YERUu9U6IH1HlE4QFB+IH40jNEBmjKwqZSKb45GlB14EgDJWHgoO2DSQLRPsPgfk2fQkKbfqyAqPHOcM7hZzvtzvTjHHffKd8m/qkkK+wKvbf/l+Cbo21YgfiU3IVAJACfJcQ1H/vywjmIeKbzRwdnh5mUxoHlv9ZjrBcBjRyOb0lEpnDDbFPXo+eQ2WWceWw2O0qZnS4uehJZh5bA4UN6qUYhHn4n11H+d67nX/+27gyfgAF5sCr3qli171r2RiTKOq5X7J8Me9lIdTs4pVuC12wrj/2NSAT9Eh5Ba/lEAqWkPcK3bueTwupToeaNUq28UXg4fHlVq3DhGTIf1NdQ0HaS/N99xOSEk9Zw8UV5uXkF0rqdhpS5GYOnQM7AVvmR+Nsjyu7/cwTnQJ2jajJtnR5AHZk/6SpgFNUky86bmUIIl/t9zK9sCmacFwfJFARcClSTGGEzTGRPcXCjjkiem7ha8AIL+rE7HqvSPdGgFmlN4m8Qrasnsp6q0EyQSoc3t2L2JXPu0i+bDHzjLjmLAbQO26MNPVeLUqNIpA7hLaL6mPVTrP5ioELwcuosPMfwgZLNNaRqZU7JdYS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0643731d-9eb4-40b5-c60f-08dd68a3c1d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 18:11:10.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ndBLlm5KpYapkrgejOvcWY2NChuFVB9AVm2IufgtDLnwQQQwQpcyPqggjc7RSI1SIXzbJdq1Uzxa1QkQFUM0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210133
X-Proofpoint-GUID: 50MOK3o_AxFwDWuRaB57yayAJ-o_RCye
X-Proofpoint-ORIG-GUID: 50MOK3o_AxFwDWuRaB57yayAJ-o_RCye

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250321 13:16]:
> On Fri, Mar 21, 2025 at 11:27:34AM -0400, Liam R. Howlett wrote:
> > +cc Peter due to uffd interests
> 
> Gentle nudge for Peter to make himself uffd maintainer :) I am not a fan of
> this 'happen to know person X often touches Y' stuff, this is what
> MAINTAINERS is for. If you're not there, good chance I won't cc you...
> 
> I also strongly feel we need somebody to take overall responsibility for
> uffd at this point.

Yes, uffd isn't well represented today and Peter seems to be doing the
work of R:, if not M:.

...

> 
> >
> > We are essentially avoiding the compiler from catching the error for us
> > by returning that ERR_PTR(), which (keeping with the theme of my email)
> > I hate.  It's fine for little functions but we've made a mess of it too
> > often.
> >
> > Reality will probably not align with the realistic view and people will
> > just copy/paste from wherever they saw it called... so we should think
> > twice about the failure scenarios on code review and I think a flag
> > (or a function name change?) might make this more obvious.
> 
> OK so what I think we have have is a break in abstraction, where we are
> trying to do an 'iteration through VMAs where it's convenient to keep track
> of prev' and then people duplicating the code, making subtly false
> assumptions (yes pointer being returned with the obnoxious ERR_PTR() stuff
> possible and -god knows what happens to the state if not present-) and
> etc. etc.
> 
> Don't we just need a new kind of vma iterator that handles the prev bits
> for us that can just do away with this crap?

I've been thinking about the iterator and the prev/next stuff for a
while.

I am not entirely sure on pulling it into the iterator.  My hesitation
is that a lot of the time we don't really care about prev, except
merging.  Merging only matters if the vma is touching the start of the
vma being modified, and if that's the case then we are very likely to be
in the same maple tree node and the previous slot.  This should be in
the cpu cache, almost always.

So I'm wondering if we want to have an iterator do some fancy "this is
prev" or just ask "what's the previous slot?" - aka mas_peek_prev() or
something (that doesn't exist today).

We also have the users of contiguous iterations which wants to fail if
there is a gap anywhere before the end, and detect that error after the
iterator too.. ie, did we reach the end (or is the end a gap?), or did
we find an intermediate gap?

So there are a few common scenarios, and maybe we are getting to the
point of having a clear view of specific users for each that would
result in less bugs with common patterns?

The patters are also not entirely clear as the regular number of vmas
iterated - many are written this way to work on many vmas, but in
practice there is only one vma checked the majority of the time.  So we
may be over-complicating things by keeping prev around and up to date in
the first place.  Perhaps clever iterator coding could avoid this as
well.

Thanks,
Liam

