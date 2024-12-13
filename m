Return-Path: <linux-kernel+bounces-445077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372D29F10E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0852A1882B29
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C11E25F1;
	Fri, 13 Dec 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HyzYnTf2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ogjeFf+U"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24711E105B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103462; cv=fail; b=EcCINsZQMo4JbMUXBcfzXteb+lKtsm0dZeVSbKVEup7bcyFW7g8+bPF7oVCDsSZeYAMK4VScYBtuB0FOwoEAhHCDh53gGe0cnffdgvrcFBgotbkBwnTbYfkmDj8MeIOtYqS+gLajxxCtmLlJo3hT0F+lWRzrpDb0S1Vt4VLAgQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103462; c=relaxed/simple;
	bh=2HCWKsaBgwmIjiu9hXJF6ueoMJK7ySEZJaPdWDorOHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T7vGZPSu6slGXoSwPWtjqdqFAauORJdaX33DsN0FSPMCh0LK/mhOq/GN3mY/z3aRkRCaCrQpf807RO/4oW6TtecSkOhlihMjDQV/F1bOKIngm7v/ECJgIKCgtRXgVZkyRWYE1EdPcDvOmgsOqJB+lzOGYjzH4Ut24u8ouP6Gwuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HyzYnTf2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ogjeFf+U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDjoVd023206;
	Fri, 13 Dec 2024 15:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7AHGSKfBPebafs+74W
	WpHq63F07ZdjUHlm7YYKOzNS0=; b=HyzYnTf2ZHnPqCvK8oI6PqRNvn5fjiIRRi
	b2xW+YnAiIgDG7JQe97OWTRpU8QmwbR8Ql1AoiYcoAMxvGqwVsvVDj+0Cu72wxpj
	5KbxQ5jGVjZHlB/jwgCN1w9gYa4ETpbo9qfp1fLDpXL31lbYv6pMFhu2itgCetHI
	ooBDfxgP2+dKphEpewuRPgJaKT8UPdqwP556HbR3uK2blFG597vofDL7j0/FKb3r
	N6CCwyP7nIZjyPrS6D6DStl+JDAIRxgpSW1+sRklfTGVTalskCjscJhZP75p6B4N
	AB4QFQpJuVNDKF8D3mh5HltxjHflukmyihLTON11QLWZTUDS3bGQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy0dtgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 15:24:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEHELW034958;
	Fri, 13 Dec 2024 15:24:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctm4778-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 15:24:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7vFvqc95pCg4J6bBykBXTHvYbvUR0i56sxqIwhbyrJ/GDny+7HZ1BKFtFYXcfMAFs10toVAaZfPuY+lbzd2ixf6Oxk8ZeGD0NMa5jrVX39ilYJaaGO8u25Htda7HB5W4MU4MdwzqBagieAjlGbtD/GbYCMJX6YHBJMtU8lCsfuseCGvVd17hGQny2sZXRiopsp3eExABrIjja9NoJSC2OI72Mkk90JhHHrBppB+aFBAxladh15oS0S8AWjLcRaV42BOoIVlOETUsLB1Z05u8vjuc0J29YC65p7uNMwiQwUcHuq2fm3+FEqLX2yfzDrMCZdcfz/mRWIwabApmG+ZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AHGSKfBPebafs+74WWpHq63F07ZdjUHlm7YYKOzNS0=;
 b=C0p3LH4nsFSRDxOynUZ2w4AlaeypBw1qTvSxHwFUAj5hV+JuuzhOVukdsDHL+Nbsw3HNYhd4jqGRyqnp2EO2mcF2u8D63WZcA7tUqRi4yk0tP7zHDSpQoiQdlpwbbisKuT4M/O8fiJiL9V1t5av6iIb/F+AuDgOhh393KqkbtQJN8uNUHMcakYma1rY1hXypQdqL48VWaZmXns7wyReNFWvlzSb3CxNMYmRzC0baqnitXFMWIbG3pssJ91w99jPTrMXZYucMsTCgcqHTjKF35hN8O0q7JBRphllDLrJsJVQkvJuq44Y1+qoCYCsRbYCc3RTt3Iof95mOflYPsf+2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AHGSKfBPebafs+74WWpHq63F07ZdjUHlm7YYKOzNS0=;
 b=ogjeFf+Ucmo4XqmiN7mkWCIAg//caEWjEjNKzE2IBBpR1yS+gPQGf9u7x380NYBna2DgvnXbupcIZrdXcaCJErZOy2/07J0NHmtZo4vOGAPiRIqxJAghabJNmQXMRtorHLxr28MkJu72hmn14TpagPtGhM6+07wMJxPVL5FqK1g=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 15:24:02 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:24:02 +0000
Date: Fri, 13 Dec 2024 10:24:00 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH] mm: fix outdated incorrect code comments for
 handle_mm_fault()
Message-ID: <qby7q5ghatldakzgayxr573g247pgoyuz2jkytbcnvwhas3mla@nvc4whogmnut>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jinliang Zheng <alexjlzheng@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
References: <20241213031820.778342-1-alexjlzheng@tencent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213031820.778342-1-alexjlzheng@tencent.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1P288CA0017.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: dc81ffb1-7984-4a27-c7b8-08dd1b8a2ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qYj2TvZ0szFVt2COL89/XYiyuT7tuaiLq3GwOgTz3F9I9UemahBurjDQycAK?=
 =?us-ascii?Q?hm5Q/1fmD4WadwwNUp1c8E0Ca57DHX5tZnc3msCseGNEG2kSuEjHmvS7sefR?=
 =?us-ascii?Q?Sj/GiTKPjU7kBWF5PD1ZE1WgHY3rTIdHjzTmWmbkwEKNHBNuISTH32zwvHec?=
 =?us-ascii?Q?piFa1tiYpFKQyu3CyP4/erSSy05HzbisWDnE0fq/ropowXCbzigQ6BywQkuJ?=
 =?us-ascii?Q?zpkyGI4yTPXKwIr+hZZzin/GB8KgQgH0LPk0oBKeQsd0A+o3xP3kdBCrbuo6?=
 =?us-ascii?Q?A16G7XQ2NWm1UhvQsWgSP/KP/cEVHYVyFtxT+5vzruomV4V1i4dImlMglmZV?=
 =?us-ascii?Q?oly7xmOrKYcp2FOI06rnFaegQyPCeG/GqHay/v3JFjk7nI41bKPEv/HTilsL?=
 =?us-ascii?Q?1Df32Zt+QEBESP5kzZJT9dsi6yyp+ke1zRmrlnsFg5/436h6Z3Qg5qjfjZ5t?=
 =?us-ascii?Q?p0o+1iy3UdsGEQ5ZVd+BMWedAXYvO7mUfmRjqfON80zcbEd0sObLxjJngzsY?=
 =?us-ascii?Q?AR/EGKtV3k6MqK7A0kRreTOLQHHDwf9OFG/clZMimDi8fmZX754xxAvkF3nB?=
 =?us-ascii?Q?8FIvgr9+fr6z3vD8DxDRJEVQJX5G/lBSDj0AqNS4q/0lcnA7ebQtEW0s1o14?=
 =?us-ascii?Q?eOCSHlEKd1TFaWW01aFOVhTCu9uRmRZ1hCIABmMIxNyaj7nLWBcJe2DGcrFx?=
 =?us-ascii?Q?9Afjv15vzwc7LlhHKXgIGDRwTknYla9QGId72LWkXroiQ/JvO/h+EX5n5CDH?=
 =?us-ascii?Q?on7CbVH3f48r+eD33o4jJbydwT4q2b9iVrqW52+BDjPOQ45DcDzVzFkD5211?=
 =?us-ascii?Q?4mHtC637oVxwk/7X9/lToHGuz4l0akbVmlf1U1aWi5vYnw+Evh5HYe8kLvDw?=
 =?us-ascii?Q?D7I45pT05nZxiuvz6KUW+mOe6TTgRE7HXFS/1YSxZzNRVlBmYga+MeQBe9Fs?=
 =?us-ascii?Q?G0GuWY/QhgvDu1qJDQtDZ5T2zpsR+dXUWdLSkfIxM5b1PnQ6/WzU0cRDXpeN?=
 =?us-ascii?Q?jGY87poCViOMi+P2/xY/GgAWtj09r5rEsr869yzhJ3wexbLas9Sz0RQQy3zd?=
 =?us-ascii?Q?UF0I7rIbdrYo4+F2vK0MHJitD66GpIHstOFh6XapKn8qQ2rjybNj78ItSx0v?=
 =?us-ascii?Q?hfqcGwH2OrKUFXQ3BVL8s/BncBPux7RGBRhSif0hVkSMY0OteJ+2Ylt4Qmxh?=
 =?us-ascii?Q?mqdihZycnjkRv78ONHjzXunzk8GYs0t7mofj9xklcE828A+bM/xc165IBUjZ?=
 =?us-ascii?Q?OOGnkeIHu6cdoVi/eJ42n7nVCr2ctei2V228taneqWJLmsLGvdS6KUokF4FU?=
 =?us-ascii?Q?yFzBnR99t+eH9xK6/9dPo3A2Hw9SX8VMf2asx5llcA/ttw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dJ47G/gJ340s6ot/rrEvW9sE7iy7dkUsF+HNLS0xEA8ljRlILPyKz7wpdcJz?=
 =?us-ascii?Q?IBt4Q7Sb3bQv0y0Y+UtaRWinQ7ipbRtWSJjPQ4RW4f8zyJnaaxfz/Ix9FweF?=
 =?us-ascii?Q?3zLsNOm566BW1YG0rTQ6UYA4a5T5VT+czSAFsWuxWZaWaHuR+5SGE4pQboXJ?=
 =?us-ascii?Q?Crt7NN6x+abiNqHu2pt7VHJezABAlDOYtVSbPcK4y6Fy4Gg9NR3hSsrii2nk?=
 =?us-ascii?Q?Upm/H2LH6qzqQ1JQtlM94iBp2zis4w5kws7JJ5JNUTBmYzs1fSz7yKbGq9kN?=
 =?us-ascii?Q?u9YICDd7S5TDt0yJjcIeak5mCypZDGANChTHne28JIgzT+eGL9Xgk9rhXwJf?=
 =?us-ascii?Q?3EsxFgT70I7vMUKpnyBii2gGr7fMzUNFoZ0gFAykJ+bHwbPt6mbRkgijq5dc?=
 =?us-ascii?Q?n8X1jnpU6QSP6rQSlH3y1MKPQfGyOxcXhOik+WiUxnFTDTqBW2+RkXmjQ6xs?=
 =?us-ascii?Q?QTglGEcFXXXjQVsEKD47514XjHizxSmhPngq832sxSrY21F1YxAjdqQlBB6+?=
 =?us-ascii?Q?10jjmHyZgNeMJxfklWIr5ZTnacGpYHnKzqszs8jPYCJtcmU8Ezdizri40lWc?=
 =?us-ascii?Q?FnUvRspa1I8qiS8QAwTbIuck27pgOaaRkfnoOrJO7Gk+yTRJbmZuuDQutzTI?=
 =?us-ascii?Q?OEDnJYRonbUeiJii7A78SR+pLkB/32X4ta6M6FYqAqzUEoWc9hE+0j8GUs1c?=
 =?us-ascii?Q?1cw10nzfGk0uuwSX0PmWBf1Wl0S1ENhcHNGbXRLRui2YpQTj5CK3aIyYtsyP?=
 =?us-ascii?Q?J5xISooV0KzukA5tEOKGXbPwZxaaW42B+U24qQttd10OSabaqArakGqtrWhg?=
 =?us-ascii?Q?GTeW1xBMCetw6b01r/roqdGS1PiKnPQ8XohM0ss4+AV2H4tS5K0eMpZWuchb?=
 =?us-ascii?Q?q9K2TzE++LluUM9+ichX+joTudZSkl7zc/g14aCRBrVtoIJHirvcOShlptW2?=
 =?us-ascii?Q?8X6An2oy7untC/n4d0pCtlfglf+ROTioiqn46CTjxAcoHY5rlvhxoUKtGJtS?=
 =?us-ascii?Q?Wts4si25BqVLvifmD5lrwRhMsTsEPtehWqi2cJf7Q/cAigkhr2nwLGsqEiZ8?=
 =?us-ascii?Q?/nZJBm5qra7BXEAOZyVV4j7BVZ8U/QCuXrgW4O2hcpem6cGtlkfMk+nwOPvS?=
 =?us-ascii?Q?0zgnAE0p82yIE2DFFjegqSet5bbld5qRdbKCg6mgpW43LtM2MFcD4lt/n1xU?=
 =?us-ascii?Q?wsOvUPcfITuNq1HxEyr6YCsFMrmcRSRVfS3xpwu0jn53OdRKPk5bEVSUEfPP?=
 =?us-ascii?Q?18G/Rrc1o0uOBZ1X5e8LaK77qeaDE36D4d+aYLgWHiXzRvCLP153IPpJISia?=
 =?us-ascii?Q?Kn9ermOP73t6ZaL1gdlK9p+Uji1iV+tGihCSMhIi9t7ujLRsxhCVpXyKWewK?=
 =?us-ascii?Q?WtwhOSrednmLwj0AV2z9ZZtmEf+JPKT6oLKxxz2/cDvqpHapQ73J1rpNKYFj?=
 =?us-ascii?Q?AFy6Rsa2nexoJ7IR59RebVXuQFSynKYHEowD9uKNej0Y7ciBK5UbvJIw+DQf?=
 =?us-ascii?Q?OOtWdZRnAjY7lhd9pL+h0URu5aPNa0k0JQ4F6L1DtfoCTD9nMEyG359h29+P?=
 =?us-ascii?Q?E3T4cNXUuftJUlPzhhJxy4P2SS4DCmkjg8Aw+Tq0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tYtLqAXlKv5v3+wYnrZ8fB9PZoOAaxR52EfuqQYhq2uo2wrLN9XRsFUkLxjcVgyAGYqmovPeU0xiC4N0z7aavntbkIz0G5M2oSZMp/YCUv4RvRyFFHInpGya5Yski1lX7Kx01pXe434SoyDl4Hys+RjaoanokhRsfpCkzZXMUgvyvulvlO0+M/FKXuQKoPQrlrNyNhI5vSD5TG7Dko8F2rEcbsdZr1ABPT6d2Z02zPGzmQlTrHqLbc70on5reH6//gFVe6tBhvGkwVNvT6qzvwo/Zg09nUrkW/EP8SODK3oLaRA+dOd80a/B6GfBVUiDkAIgNObg5w9fZGxOuax0IpTmT8MLlqFjQg17u302iY2nqfUo05MmIx4DWrT98dmQUHb5AytLigvm5TR93RazRQ41+foyinK50RytyfWtAKZ8SX/vGrNdqbOgdm5O9Im7UxcO+AAAzuTPqVPtzaldxRmr3LGec5loicDTvHJ6gHXvp69HUHg8T15C5wflTi+ciOJQnILDfGV9UGbl3aK6TR8VVpRZHOi7TbxJJk6uzNUi7HadGMongSZDf43yOqi3feSf9JI3nL9B5q+A/uO+B6xD8v6qkBw5jiHRgrHg8ps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc81ffb1-7984-4a27-c7b8-08dd1b8a2ca5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:24:02.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/oVo+sRnb2vXpwj9uaWsaf2We7xhAYtMPsxex37OZ7khWh08g88YBGnc2v/9+b15DVXz/jpRhw+7KdlX7QsaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_06,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=859 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130109
X-Proofpoint-GUID: wKn23aWYtCf1aKqyrnVZ6pU6JVkhm27u
X-Proofpoint-ORIG-GUID: wKn23aWYtCf1aKqyrnVZ6pU6JVkhm27u

* Jinliang Zheng <alexjlzheng@gmail.com> [241212 22:18]:
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  mm/memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d9af83dd86bb..d7342a726845 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6159,7 +6159,8 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
>  }
>  
>  /*
> - * By the time we get here, we already hold the mm semaphore
> + * By the time we get here, we already hold either the VMA lock or the
> + * mmap_Lock (FAULT_FLAG_VMA_LOCK tells you which).
           ^ lower case here please, otherwise looking for mmap_lock
	   could fail. ie: grep mmap_lock..
>   *
>   * The mmap_lock may have been released depending on flags and our
>   * return value.  See filemap_fault() and __folio_lock_or_retry().
> -- 
> 2.41.1
> 
> 

