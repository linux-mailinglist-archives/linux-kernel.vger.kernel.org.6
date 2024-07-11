Return-Path: <linux-kernel+bounces-249369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5059992EABE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21521F227EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12C51662FA;
	Thu, 11 Jul 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dukoQFQR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fC45OP8e"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BB15ECED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708141; cv=fail; b=uyKDSnHcmTJq5YJLcNseKYOBI/wRX+5/UkoABB0WXRjhxJkZFvuFn4zlVRCp+KVMlJVniVURHfSKXpcRmyvpytfwuhnODwGQvOZc+JJHr2kUh8Np1P9Y3wQp5J+L6OievUYKmZ7uKn3qo2a+s8Tshx9tMg9uqyLrIGbSUp7EgDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708141; c=relaxed/simple;
	bh=/vl0A5AJ1hsUmfLqQW1im3cSaqqjLW4ejxVgqNHehIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CdtP6xyBE4ZnuqUx5PkDPrjXIxF3zZ+3eGD85hXyXduACgVzlGNmSBBnNvSjFPu+BjJ4t3/IXrmc3M48ljpzONNV+qUMPQun6R9S9lb+/vgdpla88VIwMGwlpH1lPv2X24bf2EXSQignqP+SNbAYdZtcVkfrwNJS6IXJaU2t1Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dukoQFQR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fC45OP8e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7taSi025411;
	Thu, 11 Jul 2024 14:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=9zFW/MEq4jjl1FL
	K4TWJHHgWR27/WAPXRIuHL+kFuaw=; b=dukoQFQRuHZ+8eABZH8G33KWAg+uyqX
	2Oq22ejDtgoYbGKsEbLDPgxCuQjpary08Th3JfDEnrJcdXP8Hxz3vlsULO9teWol
	td0w3WGDtm+B+XUXpREOYg2XMfxI+59+PcmHHtkQGQN4HirPlNv+9id3RpJEJnR/
	LuWOVk7bLxPDrWLJgaSfNW6Ox5wvF60oWK9UmImkkAuDZ2hyb/2yresG7yYkWsGo
	e+WBL1XY0Q6j8eRqhokOSqF1e9lSHzcymvVlFKTwWGXuDqjDaj2Z2DWWHPHDPEu2
	+j7aEWo2XjCDowECVlMmrPCuCi8HXHbQXk9vnS8A8tDKC0r09n69Aug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt12jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 14:28:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BD8PfW011075;
	Thu, 11 Jul 2024 14:28:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5u1ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 14:28:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNr8qJb3dq7Agtay9bb1drDhAHsbSAZ3uIXbMJlMd2+JBC0H+WMqCMjZ/GSwYi7sV0kblyo/XXLiTItca6HshxQ2MGDu9k37cz1AZox793gr5aYYp9qGtEDZYxRIsoWcd6n+53E2XJlUk9VgKF7jBaCVUmlo9Qt8KCUGJjabvEHuVi2UCdrsnbfVAoa/ekNgY3xoxuVSCO5hsjp4qwQJYLkxxbPM3OEjEBMptCDTeFLCz7//hI133/T6sn/tA+Q2KKw+w9ljVaNSFTG57dmOat/4RxoxB6i23fykxq3JKj8sKX3XAEX7pUo4pkiN1IlQyyurBi8beFq9/a1/zPElbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zFW/MEq4jjl1FLK4TWJHHgWR27/WAPXRIuHL+kFuaw=;
 b=lS2XOQ1kX/qX9x9Tw3Kc+mPqeDB0dT0oPNjwkJ4LO2e4yMozzMPci5DiMLgvUDA8dZQRIeEVG+wzvejC96NOehOmSqArUueeb7ChoLVe3gwsUgCxGOC+7U2q6mBzd9pGaDhDblVocVObTwHmSD/jCFjQfV0tPUWtUi2Mm+v8/d01JX+d13l4WhsEzHvItUwtnNY76Qf+Yp9vfPIGrouT0AP50qQVCa6LnmhW+63gMb2hyWpIayGfzmS5Ireef5R+buOtKOj0xdaJUzyaD5aL8CUIlQliecUsYA5YcjsG5pS7rMCWbUmIki6r68AuTdwR1jIvsYDtVxwO1Gs3KSnkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zFW/MEq4jjl1FLK4TWJHHgWR27/WAPXRIuHL+kFuaw=;
 b=fC45OP8eLl61xMIKnemhisnFB4jVGLxbbq/rNoWjhssgTQT5EGJ7ilBKAU44Ytf2JzUZXCov/AOSutX+5M+l0RZqGLwT/OSkAfH9Fv7qU2mDANhs/fSYJP8nkNHt2wd/XLElohKc2DxUs+9yth8+Sx2CUbhhyMOt2490K9yS3bo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH2PR10MB4165.namprd10.prod.outlook.com (2603:10b6:610:a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 14:28:12 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 14:28:12 +0000
Date: Thu, 11 Jul 2024 15:28:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 10/21] mm/mmap: Support vma == NULL in
 init_vma_munmap()
Message-ID: <f531253a-f2cd-4e1c-999b-5833a6468241@lucifer.local>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
 <20240710192250.4114783-11-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710192250.4114783-11-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH2PR10MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2df9d1-ad33-480c-d118-08dca1b5b1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KnflizkX6yTFaftfqWml5ZaxMjW1gehP2ER5Q3IhqSoArMYzXEBmAgaAjhqJ?=
 =?us-ascii?Q?QMBaFyN9KNIa/j/OHBaCQbi4fGHNtHNt9c7iZvVZUXL70PLRTKoZxAM3CoHS?=
 =?us-ascii?Q?ltOlQlb1u//36xWs/B7Z+3hS8oW85sph13I2oTl9ijJ1gXtbTkYkEqDvhsR+?=
 =?us-ascii?Q?STlvcOxZImVHscLPiQ7ngJj68aIVpHP7Q7LoAPazzYOj8DG35FvXj441kQSF?=
 =?us-ascii?Q?1I1sLu1Mo5iEAQ4PPA3XiBHqIFAtpZNFe2tOA43glORZl3PdU/XlTD5FOTCd?=
 =?us-ascii?Q?e6nuCyIsOb24+oC97t8Z+FsgBawID/XxoJMPIyLmdbc2nNUBajNapI5RCL4q?=
 =?us-ascii?Q?ScG8Zb6ZjSHByzmnbh2Pz1JTvZD89q49IncFxHreewP/9sp/5F2pfaGdxS9o?=
 =?us-ascii?Q?PAS3/FgDfBGiLQYx1jdya+w/f/HzX373oNLX3IAGw920RB44O3B3Rfc6pPYk?=
 =?us-ascii?Q?sIHcHTxNTg+UvF29D2sdvu31iwbmA6OCED/HPYQesIXJvSAehVKtu1sNA3/i?=
 =?us-ascii?Q?UM91GIwdhJDCHgGgRYG+XJiYsQEvxlapy3GXRJDByA0NcV/WQlXAkysZ+WPA?=
 =?us-ascii?Q?FaLQhE+DcPq55fhkPoXe8uHeQhFRUtr0QsA1ZTnhF3uFjY4j/ii3LLVcX5EA?=
 =?us-ascii?Q?fASR8MKbLkjBGx0ABDxJRQ3EbN+QEMbmwMnrOrZ545jHaytb+bATel36aw0A?=
 =?us-ascii?Q?FR/VwRhkYuewktcfNP36k1iLtDt8pmQ4cu+f5jcrJ0f4TTBc3xf/gi4TsJKr?=
 =?us-ascii?Q?ecA6QTthgI5k1PRrEIj3C3HCFl7KV9eVuj0QpxIsaQYzlGCGgOGCJJ2ZaLji?=
 =?us-ascii?Q?kwbZ9rhj18JWV2gj5B7FmKwfonLvXv5G0KzSYZ007tObGSlXuYJiyDeJsbcv?=
 =?us-ascii?Q?88Xeur5YbYhckSjyqYz7NSVQxiytS+6EXgn/yVH1ZGKqNELWrWnS0UZycLKi?=
 =?us-ascii?Q?Ol9Dyrk0soRApmPBIzj4WPiYMDY+PTnfL4lbHsatPZhHQ7e+UuUUKZI8sR6R?=
 =?us-ascii?Q?dWsdg9aVr36oA4jgquWvehBONlxseF+pdz7HJxkG7SgWUlO0xAnphVhVOzq9?=
 =?us-ascii?Q?u6IW15g7DaTegVKTMV8WQTTuKy0//PSi78s8NOQDJLR7WlEugj9LsQCr8Ykj?=
 =?us-ascii?Q?kCi7qpWFf/Lka3WOoSs2BVqEUdJ6YeHqgISe+8zWCiUJqbqJudfR386E2+bC?=
 =?us-ascii?Q?6sScOv/X3P2EI2bxf2nAI37SjkRNISQDbwS7L79bqvkflGKrIkJZY96Reu0r?=
 =?us-ascii?Q?vytf6G+QIrIV5QbqqT2VNoww75C2vzrxsfzABf9xWjqF/hAUGLHB3qpp+4n0?=
 =?us-ascii?Q?1YifwIKj1rFOWrCjtebH3YzI9J5W1/qKqPuXFkL904S1aw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E6/kxho5nSBhbT6KXpisIqLyQkB/0RxBtu1I0O2MX3QebhNMzH98lEQrBiDo?=
 =?us-ascii?Q?08WkjcPAqAiBIoZY0bcbteDOvTY6PN1+21Nbo+aapH28QsdYGFAfpLX72ZkG?=
 =?us-ascii?Q?J/xEV+gYoxrm3r+NB1ai0JKTMx/K8pllqUPFflzADps/q/hbMdzMiXjJzoYk?=
 =?us-ascii?Q?IOqW+qMDhO2XVxvAOXnB0S4scNi4WcyhvDQpK60GBO8oJBNRsHXEtSmKTtFY?=
 =?us-ascii?Q?mtqgv9BQPXoWsFPvO7ChnJIc3bUO2ugLBr/lO8lODhuvKlbXbRcTWfmlRQW+?=
 =?us-ascii?Q?0Z65la80ZS1JJG3SHaniNTdPlZcRiz9LHnJpZqF004ZdUzkcx1qSGprtdlss?=
 =?us-ascii?Q?+xTibRBdRs8ERvromdMvbRXx7z14nr3skuTKD85x5v68LL5g2yQPpQpRSSfS?=
 =?us-ascii?Q?k9LJDVYn2x0BKRUrzsl5Bs/v6fq++1IyIF/r3JgnYhOxkpTo0Rs871KDMtm8?=
 =?us-ascii?Q?uQWY3GE8TLbnGwq/mVDkZmtNPUal3kSwUoiCrMQqQHkrELfgzjZH1PyYn6Ox?=
 =?us-ascii?Q?fPb/Gs94LpR0vcQ3iwQOrI+RSvyh0+eW7RLgxcHK01dudXeoV7bqQG1IKXkg?=
 =?us-ascii?Q?hikndLDnBr2BKZfTZIu+o662S5yFNI6ChwB0WeOc69JZu0pqIxGnn2PMr752?=
 =?us-ascii?Q?R/giIso0JzoumUvly1JuTSlF2f78K37hdqnDtoofENnnQomO+3QYBXxlNLJG?=
 =?us-ascii?Q?+/jq1AD1qux+EHNpH5zmwVMwBdSoC1Hc1MaSVONQMwihUdEnXOEZPWg39zW7?=
 =?us-ascii?Q?989Vdehyz4ElUVUs1HnwpZFTN6ISnB1yIpnj51NXB5rHtF756wc2CycXeNes?=
 =?us-ascii?Q?2+8ncPoEcZb800IbG3ZkZkKe2k2C8gaqxjk+RKKUi3sN08aETCH0cDynTEIl?=
 =?us-ascii?Q?7PxvuPWjh5Yvzem+AJhOkRVxoqmE33ihgh/Moz1pvQ2yeIGlq0rJ1n55835x?=
 =?us-ascii?Q?SS9Di85azIhoRnf9yq5kwZM20R1vlzyQwAwdyqul1LMXyLJKvarIuhhY1xtO?=
 =?us-ascii?Q?AD3LJlblUcfndEi5Q/iHvRrBCxaaRII7//ZmYEKa8adIsDNNPfSTQqmzOmip?=
 =?us-ascii?Q?mJZELmq9vzi6PydgflCCi4dOw68mA8jjJrJPVkb7ZvpcWyM/rOufaE//f11e?=
 =?us-ascii?Q?mq7YBi90LlHpMXZq/+HotFQz79R0zYe1khC6GhCGr70FqTwnhMd1SirsXTge?=
 =?us-ascii?Q?y1vtKSEj5BSiDcHvTi/urRA+1VBxZLOxvfK3DES23cIrW9KdpqMwzkZItm33?=
 =?us-ascii?Q?3a6f/uVFLbUVLrXgvzNYoPseHejo+6x6RYr5K7PIQgobFSBo1iMM8ACvolRH?=
 =?us-ascii?Q?sgTXdunGPH5ZZS4IroxjZ1CVde62BzhhJ9aFLDCL2DnbMw6hT4ivmo2dbYbP?=
 =?us-ascii?Q?kd4ISMkiUB2O3n7zHNXAlPhFfxpGrrPkpzljTiXd7gQ/E5ywMGtYL+O7WCIZ?=
 =?us-ascii?Q?iRkgQ5kjEnqMDOSlnWysWWmTJlencrvGH+ogJjI/y14FUHRzlU8zQap4FNUq?=
 =?us-ascii?Q?BiTJLw8ZioDScTmHVf2E1aaodkdSmlP/S6IGz3KlAZUgIwHO7g36Q2gNi0gl?=
 =?us-ascii?Q?ln3ikoR+L5L5lvtBqcnSVr347ALHTc7uOhghS9Cdmg3Hh2QKW91auThN7TyV?=
 =?us-ascii?Q?bdpVPnsAe45Rtf0XAdHEZhlK07FrbJwfAXATtnfuIxs2at9EKdRuO5liuwFY?=
 =?us-ascii?Q?D18iVA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	H1i6ukIyWp8tGjJlCYfdhcytNhR7XDu+ExqQ7fiSHi2XZc8MYFOidZTN6tGhGoXq4D48SoxnKJsL1YATeUPC1I0ukTheOOf+Jjp28yNdRrhGFd62t34HzH0G1Vhd2lQjJpvG67UX2oKhi+tBo8eBA9hNakfxGVASGMHhqYCnB7APSlvrJYMgbljnY4hb2wfe74xATjxZlWhR4cjDKQW/cl37HrnlY7rU+eFNqbXgFVdRZp1Um2o1bDM0vzHHK29x/lFDkIjgvUktWpKHYsogSdxqVfNN4JCmUEHqPy1KPg2gdVbvFPkTPezxsmGzB4Nxts6IgSf5Vfje9gfFLEA1O/oruwckGDc7cXCwTaPxEDg0G+cIclROz/FQ12qLxs8jP5UGRbFPZ3kuiaV66MMFurNKpvQmrvxcYWE0wfJv0PFm/Z04u+3zkBEnxteHUNiKOUfKr+O4J8/w8DzSOKftKShmVXUegIP/1O6Xpb0VQRCVDqLgJs1/XHSAPc66PkfCFi5FdadPrRf1Z37/+9mVCyc0okJed1xgpf4ds95X8qIPK8HVrNdaR+3RmFhBOhxNjxfuMFjdsiS+O7qY0LaXqJjZBEcEHGnbxNwB9aMS1uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2df9d1-ad33-480c-d118-08dca1b5b1ae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:28:12.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBzhyv8Rychmky3KqtuJGHNJNeMR059Lz4OuD8zOWjZ461f5X0Sb310KF8ZMunTr5ghY56JMymhsY8sbxhzHQScdil0nlt85j4noLxOSzjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110104
X-Proofpoint-GUID: A5M8R92WwHz9IiX7tEg-G2MA5NIfy-K6
X-Proofpoint-ORIG-GUID: A5M8R92WwHz9IiX7tEg-G2MA5NIfy-K6

On Wed, Jul 10, 2024 at 03:22:39PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Adding support for a NULL vma means the init_vma_munmap() can be
> initialized for a less error-prone process when calling
> vms_complete_munmap_vmas() later on.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a1544a68558e..e2e6b3202c25 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -516,10 +516,12 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  		bool unlock)
>  {
>  	vms->vmi = vmi;
> -	vms->vma = vma;
> -	vms->mm = vma->vm_mm;
> -	vms->start = start;
> -	vms->end = end;
> +	if (vma) {
> +		vms->vma = vma;
> +		vms->mm = vma->vm_mm;
> +		vms->start = start;
> +		vms->end = end;
> +	}

Why not store start/end even if !vma? And shouldn't we have an else clause
to make sure these are initialised in this case too?

I mean also we could have vms->vma = vma outside of this clause to so it
looks something like:

	vms->vma = vma;
	vms->mm = vma ? vma->vm_mm : NULL;
	vms->start = start;
	vms->end = end;

>  	vms->unlock = unlock;
>  	vms->uf = uf;
>  	vms->vma_count = 0;
> @@ -2950,11 +2952,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
> +	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
>  	if (vma) {
>  		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
>  		mt_on_stack(mt_detach);
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> -		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
>  		/* Prepare to unmap any existing mapping in the area */
>  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
>  			return -ENOMEM;
> --
> 2.43.0
>

I really like this approach in general though!

