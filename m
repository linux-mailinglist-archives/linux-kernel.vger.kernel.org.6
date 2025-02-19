Return-Path: <linux-kernel+bounces-521803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A98AA3C272
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629D57A7090
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FA61EB5D0;
	Wed, 19 Feb 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fi799h96";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rVa47YTh"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C618C008;
	Wed, 19 Feb 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976404; cv=fail; b=g11decQed1sHncSwVxF9vIJW3KgTbQWuew5xAhVAhwKBxIPqaPkw9R9F+O1odTce8zjOMbQ26/EM8TS5iVlZ8YEdmmGm1KRnbyiguNnrXkz4C2O4465aCtJYXV5eZmI8QzsDgUPaX5LXyhROuXEDxY3VXV+0pBeh4ej7hDSsvlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976404; c=relaxed/simple;
	bh=ClMBGWMGYZ1mDy+6rLL31e7ZONy7Vq9vsvgiUzVxFcc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=oYmrhPhyHWNBexI57SJ8HRTz1NnBXT1QFHgs0Obw7mZr5o5B/uxraTkzjtpeE4SFvGxBQmhmGon35zqvhgGjnW0k6BqrmmfVf/l6jjnvUIqYht17JUgQhwkEPsuKeZ/9xbLjBOdS+6pJxKUyp8DYOilL/Z/a3JlbjWa3d3icHf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fi799h96; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rVa47YTh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEBceS019232;
	Wed, 19 Feb 2025 14:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KjoruCJjuthie/PjGh
	zPdI5Wobm73FQo5ixhefIWMdc=; b=Fi799h96D9tJNdeF4+v48HMsvjiVarnPdY
	zKF9micz60NMU4cWTk2QUTDqMrchalFg4OqqwYHJKKaKgXivJC6tE3X2VpMyw1QP
	38dQhSCgMp0gUO3SOEBMvds6o6LQzENmJ04amfvN6MNMmQkm9nPr7VK8pnLNSWNA
	lC7lzTqpUF9RAzRlqObv/ruhQ8NvLSassTP7TsAC3CIjlnFV4EgyQJmgokmzJZ5I
	JVWMOKuLpXgsdt8maNQpcASfjIpGxyDzsWOm1yvdRo4lG/6VYRLqQnRwNELOxOL9
	TY8LxTp7E5PpBZe0wkHprkqgfjTVvoCIC73Q+VA0r8LteGLRcDKA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nht18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:46:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEbooS002305;
	Wed, 19 Feb 2025 14:46:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tkt8p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9E/HJqWhTacgQ/+QXN1d/MvoFG5Ik7zJKwy9b7SiQCs7ZXqUanZJp8oUrr3mCLWHPYaab5M9xv8VHaL4NMebzDDa5PLIElbkTqMgLXL4Q2loGM6JqtJGW8h/JlWwjbAIWnE4lXeRTp1o8JEgwboVpjEsVOuWPc8Xz2U0jkheiTuYHP4W+eqyJOTy6i1/yLoAbUtGtFZjhCTD91kwO7WwWNdXdY6E7XFkyktVF6M8SA1TSRntYrHtX2X/+4LmBq3NQnyv+IwYEly3fyB0xdriSFnrXg3tC1Fi5WKX+1uo5+X8Eqvbg6i0o32doG4xpJ85EXOH0slLXaRPsDclaWByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjoruCJjuthie/PjGhzPdI5Wobm73FQo5ixhefIWMdc=;
 b=XzjFij/PL/1ilzlqYTbNxithNH2UPtFnWjGtbZogyhkqX71OiyP8n83kVUevwyBs3dO8UaUwi4bvYJHIbpKc9iBM2Gci7cHruE8+X+XgXutvi5tGw0h4DjYff4sTj/c6R6qFfHKcCOAJt/UhN7yvnNUisLacdAhDchv62//HFZZs1wD7qakK02QaZRz8GdF3nmK2ofFk83yWPmC6/WibhM8e/an2i0KO3yx7247Ik8sOibM+S4Bmtlo1JXIGa2CvrCuv1udKaOQD4v/6ALbFrJu19CG026pmVut8y8Vige7swvLiZ9DV8EYsuH7p/efmIq1wUhHPOUEd7rT/pz2oVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjoruCJjuthie/PjGhzPdI5Wobm73FQo5ixhefIWMdc=;
 b=rVa47YTh/Y/c3l5orGrUKojhvXyyAgU+E1OLu65P/BX/X09gYrVAewzt1x4V4XUlFMqi+MaosgCt/Cvq7s3dTGf4AYTOQWEArdv1Xis4ikxQq9cZ2IOeKvkRqZmEuvBKl44+3LslVf97Cdo9XuokqXIQfTRAC93M1m0VMt204oc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ2PR10MB7654.namprd10.prod.outlook.com (2603:10b6:a03:53b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 14:46:24 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 14:46:24 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds
 <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
        <linux-kernel@vger.kernel.org>, <ksummit@lists.linux.dev>
Subject: Re: Rust kernel policy
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
	(James Bottomley's message of "Wed, 19 Feb 2025 09:14:17 -0500")
Organization: Oracle Corporation
Message-ID: <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
	<2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
Date: Wed, 19 Feb 2025 09:46:23 -0500
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::20) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ2PR10MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 183dd26a-2765-4b57-127a-08dd50f42ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YrqSQhgPmgTSFET/HmYwSHDTmMnhP/FjYHxRFGnAGfFp11oPN5iq3BQOv+ZU?=
 =?us-ascii?Q?Z6NFpzEg3iwNYSkpuu51QGWXDLrUKz4hg5gr6k85iFRq3Kjw0xvw5SXxX+s+?=
 =?us-ascii?Q?etWg+Eb77WtFVHPDMI5ccs4SONwlSd81ef4y6OIj1BhDeAWe7AMuZFq7VDxd?=
 =?us-ascii?Q?WFhtPiF76msFOjgmU63TOXc7WXZ4akaMe9G4Zz8fmHcXN+EN3YgLj81YV4Pk?=
 =?us-ascii?Q?7cxYO0252QNFoErwRN8Os6N6tz07i5RW5fZeivpDy3wnmVhcmAn27rHCRwjy?=
 =?us-ascii?Q?MNdF6yJcyn4ERfY3EcXjzvbecwokymOsqoJvbUW3aLDaQhqY+rLXPXNp6tTw?=
 =?us-ascii?Q?dE/huOY7XIO4Fi0g3+tsdl3Jw978M8w+D0wGrGvIsiDo4dzvLla3Aw3j2x/g?=
 =?us-ascii?Q?s29D6IhbH/9eWW0wJaCRGNtI8xhF37/icTBKDLNCwbOxgn0UYD0jodmrV7yn?=
 =?us-ascii?Q?c+wXHrwsmAG1JtQB7ICh43i9/l0G4eWSqhwKamNOWYP3g+Ri0HTHx5ugNucV?=
 =?us-ascii?Q?g1F/7USc9N9UQY9S1inveC2H96YG2nuGk4Qai7imA2ZIG5johsBdgnrDUJmV?=
 =?us-ascii?Q?B7SxCkp3d6WLUu6KoUoX7ctAdRrmh65tbIkfo6dipvo+djBmPqn1AGh9WX49?=
 =?us-ascii?Q?1ZKSlmYPynJCLP0yaVyXrZl0MRh88KReXb2xOX3shzPL65vkZvIuHPOCHuca?=
 =?us-ascii?Q?EBn1+IfEmxfiWToJqq63iDXZ6uFULplY20COf0FcdFusC3O++n80zY2x3cx1?=
 =?us-ascii?Q?QrW68iK//R1BqaIvl5ZC/ENK0hoFmihc7HpecefwssthPsf1PkWjyKoXlHD4?=
 =?us-ascii?Q?CEEvr7j7EY3SSyT1BOI3j6tj4OPqYWsBfIecUF0G0JFg+G+bdR4ivoMmsWIf?=
 =?us-ascii?Q?Egb3YwfKDdmA/MFouDcKabE/GbsitGFcFpHqYAmzIyg+7zT875AoXZmC8vfF?=
 =?us-ascii?Q?N0XYRGmfRyb6xXBS5QsajFlkAnXkwPg7mxm5csW2QVQbqtQrh7h+U3t+flJz?=
 =?us-ascii?Q?7A0XaXbr6EVi+34BPI70cbjNKy3DaBmTb9FvPJQEiiYDjqWXd4v6e2Z27xhm?=
 =?us-ascii?Q?5WgHFkJtidVS3GitKV+Qg25FGUjKxs8PL86gqK+sQ0ZDHrLsQwROyW6H1691?=
 =?us-ascii?Q?uz0sjWLFw53pQRTBC9gNHF3To7v7F9Y1ON3uhD8z8wqBNmgKY6qzef1pMh0U?=
 =?us-ascii?Q?pDZA2Up+aQULRdrhQOUHhVpwz4HHO8iHR1TyYQlncwad/Dv+W4ANA4QTYnon?=
 =?us-ascii?Q?cOd4bBApZv82nEbnfsMzd8H9n7ZCCl2Nni9Zt73fwrY2tylG6mzVvcZai58Q?=
 =?us-ascii?Q?GGmT2RxCS7i2q6kna1E/w8mqK8jRGm/zURjtVxL2Pnl8miZKn5UP6HYeRN8O?=
 =?us-ascii?Q?+4f8pyvM6ZStv4elF+drnnQ4ghKu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YVKa3KCku/s14H/Jy9iWXD69zZk1VNm9TgC4k6brglrjcUQzMrqqY8WM0YYw?=
 =?us-ascii?Q?Um1dkAe+WSEV/LKJLAGShE4dtAwd+7GCsb9gE0apy9NBOGkqUh1yTfEqBFVZ?=
 =?us-ascii?Q?4VjRqlvwk0Bm4lgyJUwKSiVg4PSBavjEbpmGXAnPNKAId8kaoHdM7NZNyY2H?=
 =?us-ascii?Q?JGaJkbonszxnzcBiIGUrieQeQZotqFn85X7ZBpi9SWA1Iy9niXCSsG9jMiwO?=
 =?us-ascii?Q?OTk1sL7qIVlkpnbEG3rRjKFNnLeSHDAVaq0ptQekJmQxwMN3i1Skrwll5VpV?=
 =?us-ascii?Q?t7V/N2RTpnHsAddYnpxyurwC2ivL4iUjUD+y0GdQg3T+YVEmjWa8skHoBS1r?=
 =?us-ascii?Q?q8Y+2XDGfj+gu3+1LXBvE1J4ApzkyXTBLhO/68+6YbRtVTX278HmvLkyuV0K?=
 =?us-ascii?Q?9BlX0cwz2BKQd0G0an7wGz06VbSGgIiQuISNKPxcvqLMWOpY5jU3rmBx6Juq?=
 =?us-ascii?Q?MBpMYt0GJ4rJ/RntC+ck6/npm3yv6ATWdh0RkjinGNlepLVtkZeEjP1Vjw71?=
 =?us-ascii?Q?AVqWfbhUywbXwFPM9/9zwn+JL7LS1DAsDDSmRH7Zkf2FZHPGscDJ32OZBFm5?=
 =?us-ascii?Q?SV7SVr8kzgkvstVniY8NNssbi7lvlQ240pTT2E3FSWZyXhzGEUhW5rOQA8KY?=
 =?us-ascii?Q?5kLfiryvm4MZ2RqWFsFv7f2H6S2EhfmH2hpj7gyIXadogtcBRnjBznW4kErB?=
 =?us-ascii?Q?CZs1whXEE3Sz7FSyliBMnKPtZtEPS653tZolWnvX2/Ct+IVlwjuirNPp2ort?=
 =?us-ascii?Q?/FHmTTCpLr2JhCZPV2frPfO0htDGVqKRs65uDkgtnkMdUlPWe/v12pYlG9Xl?=
 =?us-ascii?Q?GeI8RX3vF9nAna72ZMQmtNeofKmJzJRJ+4eVLUx5WqaDtiKO1pQS5xUrx6hW?=
 =?us-ascii?Q?9SG0aqo/fnD9Igg/8a3VhRYH93DdJjV4+n7XH2wokwJfZhVtmXd8iVhJ/LC/?=
 =?us-ascii?Q?XM5p32Um0yzUs28TYkxPm0VKVAwghKTm0dJkHWeoVkjMfFbKOOjL3dnWUeMk?=
 =?us-ascii?Q?NobYf/aBdU7uniXKceMnzzTBqsmg2xxv/lSF2EH/hyB336NDf7pU/7wbFs7C?=
 =?us-ascii?Q?obS7pzU9KQApy4YjPnMdidlYizBGNpcafzgxsgTmACGB7uRywbbhigV4dWjP?=
 =?us-ascii?Q?9g+cUa3I2t1Jpyy+wWjSFX/Q2SaQy0+Kci6bbHJkHqXI29RbCWu+FeAY2HOF?=
 =?us-ascii?Q?4pudBXVFR8MROZ7JZsmonuyWBCJqJKapsdBEcBH6meohgtaNufkslBswrW5F?=
 =?us-ascii?Q?1bhdelbGBNXDwO4/2iAEIpVKxzRm0t0iAMr0FcvZbjjUHR0Lv+L/xOb3JACa?=
 =?us-ascii?Q?EJcUwXhooUG/eSDQeOBbkSwg93meSYb3s1Hp+knjthn+CoT8Ff8+9aItftFQ?=
 =?us-ascii?Q?W/IeCDlaS6neQce+CA8OqQ3Q0rWzTzlFT8YSjoK4lttHYojfq0w1DZQBBdBO?=
 =?us-ascii?Q?sCmoPYqUWl+Sduhfof+OFG1mI5povs0PHJY1P3lO7fm7eQZHT3pHYBSJY4A1?=
 =?us-ascii?Q?aUSrQpI5GYbH3YPoLIpW7v6UHDKmptF3J4HJkdByEaYSEWu1dxYnEsvJe6AO?=
 =?us-ascii?Q?BqA03mHFAzUeWZhUNi+MYagPB3vOXodkJQdoIC20c6KqPUqO9vmprakBKufr?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nhXCuYVmdsNLXKMggfhhkr0S5UNPvt3U1PDILJ9KTeoDEm+omdIeWA3ien2jZpsh8O1YPaQ7bTtJqESQBHey4tSVXm5zuMHRek/8UBMCqueW9dvhYuCifwX31v+ojQtrKDtTmYVntA46Oc7aD1DDnjSse6sgmzHUQ2jvA15OCcJDMnjxBABbE218FVRXkfxEN4nt5cSIPbzt1jWCGDQB5qdtHAaMNujaz6Z3exzJye6cUdqkCxVmnneinKzz7zJaQbifJIwo5XQIx3pDI3pkw2jxTGNT28+Nn/CygMJead3GiFP/wAHoZsvOYcT3wnjISPyi9J9sSf4iQTTPP+Fsr2ShhdydNPbju84lxRj2r/qkZDlUWZredAEc4Deurzld5yaZjdQ4DRtKf74dOy9iyh2jEPtGf7VD7ZARrKHmKWZtqk/JOHA/jJSXukDuUjweG/xxcJOk2c8IgdH0AzPRG+6MygdXVIjSO0YrlXRt0q9efGahRNpXqs3zQlMhxSyN01u9lr0f7Qd+Z3VMxLw/CI9JK7MPBHjc7JfEQOwNS171Sq8940y881LlMIcoN783KmWsypDhh5WNvSluLWogfd6wIp8nW+MfKfaPeMMd++Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183dd26a-2765-4b57-127a-08dd50f42ebe
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:46:24.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6y76BHVa+uVJ/sA7g/q18vtktV+tW7nDhhF0uxXxQII5zc62Zl1QETZLhBxyfCZPSoOilviO22lgdCqIW2R3X7u/z1249KWf1gfJJUccZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=616
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190117
X-Proofpoint-GUID: FLeXHKCQATlvzf2VBOv7weFlbmBUKOeE
X-Proofpoint-ORIG-GUID: FLeXHKCQATlvzf2VBOv7weFlbmBUKOeE


James,

> Could we possibly fix a lot of this by adopting the _cleanup_
> annotations[1]? I've been working in systemd code recently and they
> seem to make great use of this for error leg simplification.

We already have this:

  include/linux/cleanup.h

I like using cleanup attributes for some error handling. However, I'm
finding that in many cases I want to do a bit more than a simple
kfree(). And at that point things get syntactically messy in the
variable declarations and harder to read than just doing a classic goto
style unwind.

-- 
Martin K. Petersen	Oracle Linux Engineering

