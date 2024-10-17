Return-Path: <linux-kernel+bounces-369556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB08A9A1EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE29C1C20D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB5416EB76;
	Thu, 17 Oct 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b29oqP/3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eEO2Gz6r"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C41DA634
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158475; cv=fail; b=IGF9zb2k06l3cuAhC9CM8jZKMWcASahJlhL8BzcYBeLKYNdH8uolEgVzU7CS9TF2V2pViXc56Vhteg+dRDlgwdljB6wguEkYVC8hXvvkFoI7Nam7TID8ZvQzo+14R9jOZ/fSYtiHr/h3mynfJPpwvAZ5ilIkv0tmjdf29kyrW2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158475; c=relaxed/simple;
	bh=JqLdfg7UWy2uvCBG8a9y0hYNFLmtFfmSIkiwL/mRBPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LNIzYqbbBcncIAB2NFCjB9hS+Y0gP/o1X3J4kBUsGybbqPsao/D3DKlVUyxsjuJY7GzFvGerf8n76HwdRdq6ADAATqu8BWSGmD1X0etpoRB3+wc6OgPiExMbgmGHLn6hapnryVpP1BalQrj+ikFirDS9XtMkRy8LEIPNRwwX8bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b29oqP/3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eEO2Gz6r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9McpI017429;
	Thu, 17 Oct 2024 09:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pKPywqv/vustSBj+Aw
	Tf6middn0vjyc8A9ZTPEFUfbo=; b=b29oqP/3PN54lWbOSbIuVKZZVXOPLcQaX9
	fzKrTz3z3vJFZKXFdM5ZRFnCMJfkG7IB8KkqDFL/YeKnhH63PjAnKI7RQE3gp2XG
	/KaUg9OcTmg1FjxyBny70b9DSSzkvoZIMyBeibBMWM60hI/ZYcZ6vyzYInsJYBK9
	kdxGUZPYrHg+xxJDRegB2YPmTkSBS2LzQXBX5425pUlLzOwFbm5dK8lCRhjGR1Ge
	9BxyU8wX5ITqMNrn0EdCXf4p3YTkkyP5gUGIMGLsIX6tIqRVkGKuNeSq8LuS+rtX
	mTKz76GuPlCtjRBPxpRs7nW0W3Fv4bfYRdOXojb/fHiXGjYoBbYw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2p1ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:47:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8uVUK010370;
	Thu, 17 Oct 2024 09:47:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgaewd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+by+eckOmws8jddTRj5vkqbECfZZu9SaegWrG+3WSR2nui+FLz4ax99ri0RAC2whp26iOrRGEzur0KHXOjt1vpszamRp6zTJ3WTEhBqa1YUDzWGTQ0A2UJwfC37sHIb4oATF9MfkBJPcd/uFYgwqqRFx2hs1WmeSREh5voZUxe/UFqaZMs4q6+4qyR1fkqC/lT3+PNKthNrWSuSX1zAXPNTuQsznOlGdPGm2QrDDnFOuwO0iFJbPOXq6ZeVGCQPU7bm6T/zOcQRfhSfF40AzGaJBDnd7/Dz2PFdUzvsLdtvT6a8kXowfBo2X9PBCBbllURrF/hwzpBcLi6m6MUBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKPywqv/vustSBj+AwTf6middn0vjyc8A9ZTPEFUfbo=;
 b=qGCN3Y2A1aS2tyVcapMSO2G1hQNvNP2TaQdNxjwQGqkc8QdLrkCsvE7Vw9NVCVzBv/c0XvBdrgksmCeutHppnQP09UI3Rh7JLzNWe2zpgG0KInsBeGX39gsUj4ZxIsVR1gyOX6fQJNTXzNcn7MpqUclrcvrNbuFei+I5iwon5J1fyGmc+qOVna0EHnCy5BDHKX+cGm8l0QWOkbLFt1+lPUJs9Cwz9stDA9466lVCHHVV7gVZVm0EbuuoM+iO4Y+BHY1w0g4vnsMDx+PL09fkiVTX/lEPKM8a+rtfmFWysNwGNbiJMjDYS3NyxWZmsKcDSLTC+/MsChg/mYAqqD+Gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKPywqv/vustSBj+AwTf6middn0vjyc8A9ZTPEFUfbo=;
 b=eEO2Gz6rL0UTxkvGM5ZM1AQZ7hIK5qDzxLIQHM+MOwSA7jCGYPradT/VYxpO9LT6EAWIBk1kdzg55V7HziF3tszBZVMNX0q4iMXzz31UM9qRyhb6YYIyMEL4QFLukel4EQMdjpWGiHCkDCr99Lu/os2xpo6xMszlJrPjAjGtsms=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 09:47:42 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 09:47:42 +0000
Date: Thu, 17 Oct 2024 10:47:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH fix 6.12] mm: mark mas allocation in
 vms_abort_munmap_vmas as __GFP_NOFAIL
Message-ID: <b5cfb010-c892-49d6-a278-fae0e1a0b0fc@lucifer.local>
References: <20241016-fix-munmap-abort-v1-1-601c94b2240d@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fix-munmap-abort-v1-1-601c94b2240d@google.com>
X-ClientProxiedBy: LO4P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d46e43d-ea9c-4375-fd8f-08dcee90bef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+JceeEfjA2k1ZZ1HVvBXDydzfJBGWuYNbqkYeUKKpln5/HmaUnMhk4WX3jQc?=
 =?us-ascii?Q?G3TPfaUp9uP1D0oZo0OjqtkbRxwCbQ0PPHb8H+zIE435vt9X58lpj/SkgMmY?=
 =?us-ascii?Q?dZvuaMoHa8WvSv5Col5bky4qu7PzxpBwpExfhr4rsIZR0hlKBUy9taOGIimj?=
 =?us-ascii?Q?Q1RXLGM3N8I95KHH6f1VwW1tX0QnmrBFUs6hnTdOe5s7z/2Is9HpXkgLaCJx?=
 =?us-ascii?Q?8yaKO/wkT9J5XxjLzkxCWcvrA2qyYUN0kk8fZwzCEEBToP7e4LNKLV6zpoeA?=
 =?us-ascii?Q?79C3KHHNcuRO9VgzYk0Pxf7n8295uHW1xJgkXKr4S51NB29xPZkUjlzp2K6K?=
 =?us-ascii?Q?sNPBU1BtISp9uTmWyId3905aZmDkyKDWZnup/EKA1vrjEZ/L9M3kQKIBWyuR?=
 =?us-ascii?Q?FqXGMm8GFJmsP1NMcgoW3lPW0E9Nbc8IMrEIf2ZfeU80K91Midt+KbfDPHlT?=
 =?us-ascii?Q?yyLqVhESzQyl0gP9mQc6Gwg4l+Nlhk699g1AnlvqvYUdNBosv1bbhwhtSpwF?=
 =?us-ascii?Q?G0XqpIw77a4kl3JSrmzfjVq0bMcgu25iyNlIlba0nZuABdutVf18nh7ht2Rp?=
 =?us-ascii?Q?TVlG47/tzwgZPZkz2aSoLyI85Ctrv1PrRBBGlZgNS9Rigstg6xe6WhEJanyS?=
 =?us-ascii?Q?m7uRYuHM1/7JQNYBdVh0n0JsFkePgKuZ/E9RAKnMN+XCVQXAowe3rcdBbP2c?=
 =?us-ascii?Q?xHQdkbXcGcfgV9F5d8s8i0VYkr4UJ7Qxo8k+JwCJt5OmhRuswvLp6uoLwjnm?=
 =?us-ascii?Q?GQy1POVL8DlI8jrertu9TtfUJfvFuiLAJT16qkr5O+I336Usdhc36vETGpme?=
 =?us-ascii?Q?byFAXcyjIswwBtvvPL3UCmlCGlt8pxsTKrAVErULD0XDH4i+bZ9pxGJ2bnFS?=
 =?us-ascii?Q?8ibgLyP8+jgWU5PhIcHc37zOOdUVnInXwyyxBtLR+1/1r1+US+Aag0aa0Hez?=
 =?us-ascii?Q?7KX8xr1NJQvsY1WhZ22xpj4LPxqaJ11vnc09avVELPT5vo5y+C33XpDAAYWC?=
 =?us-ascii?Q?Rf375k9QF9c8hxLfSL9M67Tg1tMCn4LGhuZJymV8r9lt7r6mS6J3cXgNdIB4?=
 =?us-ascii?Q?4fFS4qC0nIioABTpW5MJn4D9AriPUtsBDOJ4SdhLAmOgwp1gx29ztEJTCbU2?=
 =?us-ascii?Q?97/QrKB4upRiHRxbNohFBmCRoIxRASGzJrcjiruZkBnug+o0nn15JjB4W1BA?=
 =?us-ascii?Q?ws2AWIPUHgV4uYTe4BKjg9NNscabqSqo/ElFAaWcGEVn9CREdZ83OmN9c8gn?=
 =?us-ascii?Q?Ao0bsQEErdtZra8+E5VVgogx82+ptTL0DQBqm1jfLaaWiInDalikTkjbcugf?=
 =?us-ascii?Q?jCyhdJ9ugNmbn1XpyMgJKizE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1TmVw/oszyd1+uy+ehQzU3DFwXHc4iA6JItTQNhCmpMi/60ZnU8maoB1kq1T?=
 =?us-ascii?Q?AgNxyj/bMxQKgzPK4wZcGJFHWiR0B4f83cmoa3chnia69uNPslu8tkqwsRAN?=
 =?us-ascii?Q?OlOe267FXSAEMsUEDDU2jSGOWjp3TycrkQqKK/lInZuaO7e3Gvfi/Oej7gRz?=
 =?us-ascii?Q?C7j2k6HkzvOJrl6onz1JVRq2OqTnWxJQTpEjI5QtYos+1IyHZByH61PBakJt?=
 =?us-ascii?Q?kXlD2mASGrxDbaXZ2iYb48xfib8uEo5dlDHe8Pc1rIzFPncuTmmXFNNEiqWK?=
 =?us-ascii?Q?2RutWBF4rfMOtNbR2jkNi7hN9b3hwmFU6bjo9itOdKdLKpIIHedshlX7Airk?=
 =?us-ascii?Q?R8CvrkbtGXBeV7C6QNQEg6Ca99O48G9xMljzFjiGAuwCDR/CjC1NoYQRcQTl?=
 =?us-ascii?Q?qWfdU5V7MMEdZDimHUpStvQVuZXrCCVvleSxvcIiQiW1Z5yOM63mNXnhIqaQ?=
 =?us-ascii?Q?Xeo1wnR/TzeAt0Zi38VOSVJn5++xxCAb3Btow7cp+bIGj+3Sg/nKEuuVFxK8?=
 =?us-ascii?Q?/Rd42+UzliH6ECAzS6fc7Ok9e5aL1TcfxPQ703YqNdvz8WqeY4F1m29chYNf?=
 =?us-ascii?Q?MyL1lYMLsYZw6AQbgbJLpjhs4HgSo+Qqzu0xfh+8LCaNyFaIWg5KyUdggP5E?=
 =?us-ascii?Q?1uKz1NnMHRhA9WjyEP7Lx9ohtlr/nGjvRim0iEclfrNGv49I0Nhd6yGtHZTU?=
 =?us-ascii?Q?VZfBebVBSEnu3Pw0hZEyo69jcQNn5aU25CmwhZ12aEsjtmcrKEJ3KTSI30wX?=
 =?us-ascii?Q?d6Hp4sq//rYMGPlAhrfkWTqo66aDI26g2EOB37/n9wakAk5L0UztwuWwI2xu?=
 =?us-ascii?Q?q72WP0auRS+qu+RIs6/b9cjM281ACm51w/Wj3rKYL4PJDAOZU3rEzu2acTR0?=
 =?us-ascii?Q?HhENMbNquddg8/3BXvPP47OaBhKr6JKIyzWo+wsqwG4yNGO/W7ceVLHGaQ6J?=
 =?us-ascii?Q?glYm3Atr92/6fwr6AYeeIsUtGcEkKrupsn6U9BBL23Zf1QeUA2zfN/ZYkNzg?=
 =?us-ascii?Q?sMit4hMuZdRoQTovB1z6ewu/B474gLaHWyRr83nKRcT7LAdr4kUxi9FoFYqK?=
 =?us-ascii?Q?o3/cXJT0cn/O6wcsVhJwIECuH7xGJSFoocUPSyr6PZj4GeEO6spP2c9/15Im?=
 =?us-ascii?Q?AaMlnEbktjjJX4oclY3gPeWQh109Qmuic98yuafqSROmysvl8GQAwSQPOrmg?=
 =?us-ascii?Q?0fuxUHzlqBMfCuEqs861qywSo6GwB8ie6Kv7jdBwRoxRgUDkDUT5E+6f/vPR?=
 =?us-ascii?Q?rsSAZtry4HteaXXZf/NlMSoOx7/p2lD+QqNBgUG3sfJwMsk3Li8bwJc/M9ku?=
 =?us-ascii?Q?GeyQEARbUxoKxEVAfJOb5w9gfv26q0sBVOUB9Np8hyM3pU5NPnrdM9hWutQr?=
 =?us-ascii?Q?Vq9WDCHHsvVnE60dipnULqdVG9sdekecoyZCIWSnb03GTQe4zSXSYXPae9Wr?=
 =?us-ascii?Q?dmFGgpORVWn/bSCRGGxnt6EXVBzcfhsMzEHQktEu9q87c4d2NbHILT/uoBOQ?=
 =?us-ascii?Q?GgavzWviiuahctWEqNKMyrP8j0mjHXLwJyywrmfmN3d3BhGXtDQjRmNtLwYD?=
 =?us-ascii?Q?lp26SXafOZ1nQKZJ5cWNwv5mgsoBa8HHffFg0RASWJ8w18S6RdziD46G0vf2?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Q4R7wD8wIxKRxCEziKLKtR41AIHoGD94affrrpa5C1anwz7A6FjlVQ/Uilz5VmGBHlej01m36mnCyMXNtDgmG9wPBF8DsFxPRCyoMK47XXgn8qYWwqfLkEQrkssfO2gIeIRLoIdjhV8MXfkyxlCH85eAK6pdNVQalXzXzJVv7auqlDtkk+eElDZv1+7ZJN+GHUhYnWXwYXjdq56M3CpiC+K7pMcPnLd0ALkJyINH2m7Y8z/8oFYjx0iAbdPV+/KGCvIsnliVkLpMeuwoPyFnWhm85svSdOp07D9xkQBmGq0wTFLLUVtnILfJTfgU0J7Zpv0Sa6dCh0T1Z73y3yuANztwo/U7etwweucqhcKzIA9M71gwCtPw9CYm49Exll3et8LNOn+maqFO4nk12mkUEWs2o2Cku9+HvuW99iJn0k56qSdn4NIyMvLsQbIn5ymXhmYuXWRoBTDxsMUaR5uRCFgeX9481YCBicIPd+RdTxJS0uNLJ7gJlshb3Asnxh5O7WDN29VqvZnOO3brdtOSk2Y/h8f1d3yAbLzm8/tycjlGvhOSgXrGv4xG6eHatD9Jdg+Y68hgNeQpkK+91i3sM/M8P0iIj3Z5Tn9rNePBB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d46e43d-ea9c-4375-fd8f-08dcee90bef5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:42.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DWEFiRfkAxWYfrFra6hn1Y30BxOvC6skEYtNBNKXzTBwx2AUsESZ8BmNTeyquaGryX+WNw/aUaJMPH7g8QGvAJXv8pkZ7KtsM1h4PS0Y3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170066
X-Proofpoint-GUID: zS7Vx7SLU-LHajDr-5ty7RKUScWAK2xI
X-Proofpoint-ORIG-GUID: zS7Vx7SLU-LHajDr-5ty7RKUScWAK2xI

On Wed, Oct 16, 2024 at 05:07:53PM +0200, Jann Horn wrote:
> vms_abort_munmap_vmas() is a recovery path where, on entry, some VMAs
> have already been torn down halfway (in a way we can't undo) but are
> still present in the maple tree.
>
> At this point, we *must* remove the VMAs from the VMA tree, otherwise
> we get UAF.
>
> Because removing VMA tree nodes can require memory allocation, the
> existing code has an error path which tries to handle this by
> reattaching the VMAs; but that can't be done safely.
>
> A nicer way to fix it would probably be to preallocate enough maple
> tree nodes for the removal before the point of no return, or something
> like that; but for now, fix it the easy and kinda ugly way, by marking
> this allocation __GFP_NOFAIL.
>
> Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the gap on failure")
> Signed-off-by: Jann Horn <jannh@google.com>

I kind of question whether this is real-world achievable (yes I realise you
included a repro, but one prodding /sys/kernel/debug bits :>) but to be
honest at this point I think I feel a lot safer just clearing this here for
sure. So:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> This can be tested with the following reproducer (on a kernel built with
> CONFIG_KASAN=y, CONFIG_FAILSLAB=y, CONFIG_FAULT_INJECTION_DEBUG_FS=y,
> with the reproducer running as root):
>
> ```
>
>   typeof(x) __res = (x);      \
>   if (__res == (typeof(x))-1) \
>     err(1, "SYSCHK(" #x ")"); \
>   __res;                      \
> })
>
> static void write_file(char *name, char *buf) {
>   int fd = open(name, O_WRONLY);
>   if (fd == -1)
>     err(1, "unable to open for writing: %s", name);
>   if (SYSCHK(write(fd, buf, strlen(buf))) != strlen(buf))
>     errx(1, "write %s", name);
>   SYSCHK(close(fd));
> }
>
> int main(void) {
>   // make a large area with a bunch of VMAs
>   char *area = SYSCHK(mmap(NULL, AREA_SIZE, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0));
>   for (int off=0; off<AREA_SIZE; off += 0x2000)
>     SYSCHK(mmap(area+off, 0x1000, PROT_READ, MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, -1, 0));
>
>   // open a file whose mappings use usbdev_vm_ops, and map it in part of this area
>   int map_fd = SYSCHK(open("/dev/bus/usb/001/001", O_RDONLY));
>   void *map = SYSCHK(mmap(area, 0x1000, PROT_READ, MAP_SHARED|MAP_FIXED, map_fd, 0));
>   close(map_fd);
>
>   // make RWX mapping request fail late
>   SYSCHK(prctl(65/*PR_SET_MDWE*/, 1/*PR_MDWE_REFUSE_EXEC_GAIN*/, 0, 0, 0));
>
>   // some random other file
>   int fd = SYSCHK(open("/etc/passwd", O_RDONLY));
>
>   /* disarm for now */
>   write_file("/sys/kernel/debug/failslab/probability", "0");
>
>   /* fail allocations of maple_node... */
>   write_file("/sys/kernel/debug/failslab/cache-filter", "Y");
>   write_file("/sys/kernel/slab/maple_node/failslab", "1");
>   /* ... even though it's a sleepable allocation... */
>   write_file("/sys/kernel/debug/failslab/ignore-gfp-wait", "N");
>   /* ... in this task... */
>   write_file("/sys/kernel/debug/failslab/task-filter", "Y");
>   write_file("/proc/self/make-it-fail", "1");
>   /* ... every time... */
>   write_file("/sys/kernel/debug/failslab/times", "-1");
>   /* ... after 8 successful allocations (value chosen experimentally)... */
>   write_file("/sys/kernel/debug/failslab/space", "2048"); // one object is 256
>   /* ... and print where the allocations actually failed... */
>   write_file("/sys/kernel/debug/failslab/verbose", "2");
>   /* ... and that's it, arm it */
>   write_file("/sys/kernel/debug/failslab/probability", "100");
>
>   // This mmap request will fail late due to MDWE.
>   // The error recovery path will attempt to clear out the VMA pointers with a
>   // spanning_store (which will be blocked by error injection).
>   mmap(area, AREA_SIZE, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, fd, 0);
>
>   /* disarm */
>   write_file("/sys/kernel/debug/failslab/probability", "0");
>
>   SYSCHK(munmap(map, 0x1000)); // UAF expected here
>   system("cat /proc/$PPID/maps");
> }
> ```
>
> Result:
> ```
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 100, space 256, times -1
> CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-geca631b8fe80 #518
> [...]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x80/0xa0
>  should_fail_ex+0x4d3/0x5c0
> [...]
>  should_failslab+0xc7/0x130
>  kmem_cache_alloc_noprof+0x73/0x3a0
> [...]
>  mas_alloc_nodes+0x3a3/0x690
>  mas_nomem+0xaa/0x1d0
>  mas_store_gfp+0x515/0xa80
> [...]
>  mmap_region+0xa96/0x2590
> [...]
>  do_mmap+0x71e/0xfe0
> [...]
>  vm_mmap_pgoff+0x17a/0x2f0
> [...]
>  ksys_mmap_pgoff+0x2ee/0x460
>  do_syscall_64+0x68/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [...]
>  </TASK>
> mmap: unmap-fail: (607) Unable to abort munmap() operation
> ==================================================================
> BUG: KASAN: slab-use-after-free in dec_usb_memory_use_count+0x365/0x430
> Read of size 8 at addr ffff88810e9ba8b8 by task unmap-fail/607
>
> CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-geca631b8fe80 #518
> [...]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x670
> [...]
>  kasan_report+0xf7/0x130
> [...]
>  dec_usb_memory_use_count+0x365/0x430
>  remove_vma+0x76/0x120
>  vms_complete_munmap_vmas+0x447/0x750
>  do_vmi_align_munmap+0x4b9/0x700
> [...]
>  do_vmi_munmap+0x164/0x2e0
>  __vm_munmap+0x128/0x2a0
> [...]
>  __x64_sys_munmap+0x59/0x80
>  do_syscall_64+0x68/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [...]
>  </TASK>
>
> Allocated by task 607:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  usbdev_mmap+0x1a0/0xaf0
>  mmap_region+0xf6e/0x2590
>  do_mmap+0x71e/0xfe0
>  vm_mmap_pgoff+0x17a/0x2f0
>  ksys_mmap_pgoff+0x2ee/0x460
>  do_syscall_64+0x68/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Freed by task 607:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x4f/0x70
>  kfree+0x148/0x450
>  vms_clean_up_area+0x188/0x220
>  mmap_region+0xf1b/0x2590
>  do_mmap+0x71e/0xfe0
>  vm_mmap_pgoff+0x17a/0x2f0
>  ksys_mmap_pgoff+0x2ee/0x460
>  do_syscall_64+0x68/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [...]
> ==================================================================
> ```
> ---
>  mm/vma.h | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/mm/vma.h b/mm/vma.h
> index 819f994cf727..ebd78f1577f3 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -241,15 +241,9 @@ static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
>  	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
>  	 */
>  	mas_set_range(mas, vms->start, vms->end - 1);
> -	if (unlikely(mas_store_gfp(mas, NULL, GFP_KERNEL))) {
> -		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
> -			     current->comm, current->pid);
> -		/* Leaving vmas detached and in-tree may hamper recovery */
> -		reattach_vmas(mas_detach);
> -	} else {
> -		/* Clean up the insertion of the unfortunate gap */
> -		vms_complete_munmap_vmas(vms, mas_detach);
> -	}
> +	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
> +	/* Clean up the insertion of the unfortunate gap */
> +	vms_complete_munmap_vmas(vms, mas_detach);
>  }
>
>  int
>
> ---
> base-commit: eca631b8fe808748d7585059c4307005ca5c5820
> change-id: 20241016-fix-munmap-abort-2330b61332aa
> --
> Jann Horn <jannh@google.com>
>

