Return-Path: <linux-kernel+bounces-345649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF198B8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D81C1F22446
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A755319DFB8;
	Tue,  1 Oct 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y5nKtu8E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VV+4A4Qr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881B19B3C0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776164; cv=fail; b=fWhVGwi84ZvsWzb3/vTFr4bCu+jR0K/f67FHBnDuEw/pr2YnK22ejuCPUehB5dLrofdT/9JuXaWKCTFV7jVMOIr1zJZwzH0Tq8j6Dx6LyvG9jW2WYnMCLscgs1cGVJpN+XbPV8M4GjDO1RUi/5Q5FMqpwD0lADWbY16pbFMB2PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776164; c=relaxed/simple;
	bh=1yBFrj4ZIxe+meio4o+YEAuxLMZNn3oA/rwEn1g3Ehg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e2gGEeeT6Q0bwQdHjMe7bEDgB6xnMi61VEWFiNY02iKaM4AtObNNEGOxqiEPO5HWlqbaaJOjRAO1GIs+lm7SLSR538rkgE7EdDUUh+23+73GQPd82BKqH/AT7oFBUINeJP1ghkC0KCD4h2E867ASQ4ShlwrBs1b8HV9Aym46now=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y5nKtu8E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VV+4A4Qr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911td1k030477;
	Tue, 1 Oct 2024 09:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1yBFrj4ZIxe+mei
	o4o+YEAuxLMZNn3oA/rwEn1g3Ehg=; b=Y5nKtu8E2+gvYogAFFD95f4x10Ksyn7
	kmqmYNX+VvY6Yxe5uzJOnaJHshgGKVMCYoQ/I3p+k5qk4OYz5tsT2zbpR5dl4/JP
	GJldxrVjN8eUgh2APa+rCdEzD/8vajp1xzN5Gub+N7t4qYW85uisgtYbWIv+6O5g
	1jHh0YHIF5e0YmlRxPsdYwqoLsUXbHNXEoR954SL23Q3168c+pVFRAoBhmJQq+r3
	uzxcPddyTRG+7WL+ovgpL1asXZYq//vWJeBUSp3BwHlDDAH6Txb4JmV/ezpvoFqD
	x43mVqJwawYIrKlrdoJ5LyJ3DyjwudoKXOc1TwGqvME1gVmcfqjJlBQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d5tek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 09:49:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4917jnYF012524;
	Tue, 1 Oct 2024 09:49:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88723xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 09:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8/OFr1KkfVxZVZRZ61/DAigz6sVzHpwlEPjCIjTSoaHuHDQlf4M0vQBAMbKBSBNerXi4RlBzZjx8mnAEsZ0IJ/6CxCSyljy07nPg68WpbpeQN/uNeOoPOcQ7oDv5SUguidxhgkzMg91gOO9u4X9DJbd/McpdLc6ZwOjOK3BiD4cso2VnkzxOum+30+KxaRmOAi86ZQDOwky6iV37fKWexJGZWPXCfOdRyeJCYL9stdpIP5r6Ktyap/1AIrLdm7NChBkZ7Ai8jdA5ez4wVRWZBzUWboFi8Xk9+dJ0IIfi3ZY8APGj3i5Zd9bxj2pR3yir87tEEqcKq3+qsTXX+Z4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yBFrj4ZIxe+meio4o+YEAuxLMZNn3oA/rwEn1g3Ehg=;
 b=nK+xGzRTN3edlqiogBS0zO3nwPl2VycZ4dzXgaPMfJ70y2/JPTml67vD48ojK1De/xsDpJzm4jZ4TjXbyQ+2HN1p1sHNSN+U57Sat4Jz4MJQktLa8aWwrG36CwtTf3VWnsl0UQdu8SJjv6zyRX3XiRQGXzcUJM7V0qLle0WNdwHbSn2S1wk06rc85u5jCagMUHphJSjallyT1mokzfcLcG/3ijVI+HnMNDZBTTao3B8xsrFZqaEMUF1o6T8cAp0UACgiYj1CBz8vGEEgLroXs92P9f/4WMwL+NzLv3cmnmib/9f0YsMuLpu8olMcHyU6xe4BqV7Vkv8QkDp97yLpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yBFrj4ZIxe+meio4o+YEAuxLMZNn3oA/rwEn1g3Ehg=;
 b=VV+4A4Qroas56HjxHU0RlS6HQYwmlvbMdc3jSMz7OcbaKIOcJpxbTtxxft39EYYX8+etrpSPckfOruUbrdN4uEz9f1/lkHhost2DN0ucKAk6I8FIZyRTgyY6ueP58riBB6dX1mLq1kksSR2gG25A9P5NQuIjl7myVgsgAv8gd1M=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN0PR10MB5911.namprd10.prod.outlook.com (2603:10b6:208:3cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 09:49:13 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 09:49:13 +0000
Date: Tue, 1 Oct 2024 10:49:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <386f485c-5dec-4c7c-81f8-a23aa98a72e7@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
 <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
 <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
 <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
 <fdaa29c2-e1de-4f77-a23e-8fa7523919b2@lucifer.local>
 <32226c4d16d2a17d8dbdbbd007d583a2a6a2663c.camel@web.de>
 <cb24ddf8-2299-4b65-af04-e8a1ecc180e2@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb24ddf8-2299-4b65-af04-e8a1ecc180e2@lucifer.local>
X-ClientProxiedBy: LO2P265CA0438.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN0PR10MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: a458116b-5bc7-4391-ebba-08dce1fe4ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TVVacltMGi988Pbj1MUkO+PHHOuaWLL35Va5xJiCwR6bi1aMTZsPpl7vINgQ?=
 =?us-ascii?Q?/eDyttNRUy6vuQDyRX/elOzdP+eNLvRFtimK25nv4H2/jiq4mSPm7kHuV2Wn?=
 =?us-ascii?Q?b4HSVqy91pWe+Ji89iBG8Ss5l/Vs904oOUqJ2U+52r/2hxvyzgbUH787aI4n?=
 =?us-ascii?Q?DBj1VkNx2m0genJ3cMVAUjAXqzPoarJ0fRC5jYvoJ+yd+sLhIcKkEKZX4aFn?=
 =?us-ascii?Q?5vGTiCi1gJmuEbH5+SSua62xIV2WiiOkiozSXV1cTyYifCo5jT0AyElTgjgo?=
 =?us-ascii?Q?m3jAcS36rAbKi7jVsOyqzFk+i+K7mBhHp3fjrWOTc/W7R3AYuGjwA2cd4pBZ?=
 =?us-ascii?Q?lN2CQMDi8o8SevmH6Kzf+PwCxYLXLiY7Xe431GcIgnd9pxtUFuN2EQkHONGd?=
 =?us-ascii?Q?OEHHsy2ecIDpqkcqMqV13WIBiHqfk0S4OJduL0PQecfNW2JHwf96ok0zrf6r?=
 =?us-ascii?Q?n/kll7n/g0W59UGglaUMpoWGI8KfQO7CHQpAGrKIZj9gdobKTakAp/wwqRsz?=
 =?us-ascii?Q?uhyait+cDze9TM8QzNgTabrceocW4c887n972097Q/+PDgHDnMIZnoxFsZVk?=
 =?us-ascii?Q?RkCZPr0Ea0SdxJrvDoOiytXlw1FZS6iLeD2grNDKYSu9b/yVMNgiEKm7iBeU?=
 =?us-ascii?Q?TDp+vzoNBCo0SIqpsOh6vjTfI/B1+y4P3NtXOYQpEV8vsJ13/sKQ8Lxt/c0D?=
 =?us-ascii?Q?cEaW98flUyDXYZPY2lHwROh+0fvZZyDszAXHiYVk0USJFZlbXP8DEj+ukFyH?=
 =?us-ascii?Q?lH02H6Z2V5WSrZPr9SdGdqzhppSwwdFasGx2Jj39aBFLrd4/Fjbsrm7yXWEM?=
 =?us-ascii?Q?cYUZB9/fHIWGQaomuzrWPMgE+9hRciDeVJ/LufcCoxxLmwBNKMMXwZr8YYWh?=
 =?us-ascii?Q?5Ft8jb/bbd0nY6RwEWrC8/32XU4GoEk10F15hzTQYE4jLFd396WJ/VQE9GMi?=
 =?us-ascii?Q?Pl6OBv8j+2/JsKUwB5VrVkENr7z2qcXtB0KnGNr90VJB8NRQvMUP02E0QQq6?=
 =?us-ascii?Q?K6l37OdhHHy92rkoBmXYiaESqCS0h5TWj6FwcSHbrXqn5uxJQqucjJm5jZs4?=
 =?us-ascii?Q?e5LmVMrICG7OS/IejGLFoHpYpIjdN/7upWHKef5YfG2lk2vlYOtn5jJPgk3q?=
 =?us-ascii?Q?OfFUICOktguD41HXh8BaD+LXyOAbDpcM+EIhgVoQerfh2JXnyGwjcLc1V4D7?=
 =?us-ascii?Q?px5Nm2DMtU6P2RDySxE1l5I/E9Slx7ybmvzKdvlvSXjdLRaySnt2gIHmjyJl?=
 =?us-ascii?Q?XEaCwwGNKmoj+v4KyKMzaAc0WwYcrpsc220vCqEhmtUeCODBmISmvGyvjUtF?=
 =?us-ascii?Q?NjZRIQlV/g8cnBSka+BgHo77pjLDbkJs4SfjC6hfMPqn4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qLJyGQ5wAvGE7h3TUjIxmc3Sz6dIuiXxtdYC4WINNMAU987wXEcwhp0gTgl?=
 =?us-ascii?Q?iLOBecRsHGjaFcjahUfx1Ww+JtHyLeyyVRLXFTn1GjwP8p88Jrl1jNIb9Q+w?=
 =?us-ascii?Q?+shy7rye4vzeqLWyJ6/A01P+19Am1NimBsZ891BrSuuQIKv+wJEdmlQZiHW8?=
 =?us-ascii?Q?knqSLHBwvsrsOwrhoQLqJfdaHebFecDenTXT1Pow7pwP7sQiuyVtRDfg9BXC?=
 =?us-ascii?Q?EqtgiJ06Cz5N1d4iRFT7gPi7ob32CKvK54eQaugz2GyNOI2uJ8Eq7g6wGeED?=
 =?us-ascii?Q?SFZsdhophgBJMCDW6lEHsGhxdl99UXRHkMWtxX3YHoNGWEsNTeFi1xB5ayLQ?=
 =?us-ascii?Q?9/fW16ZEl6Nw0+nzpo1wrYuChL7AUu77by6Y/hmlg9hUcFqCuxJAB8ziMy9X?=
 =?us-ascii?Q?BieO+LgG35fzNx9aMbp3KIbl7VzcbQAEOMTYCACfneNuo2gbZ1sOhSy/vcPL?=
 =?us-ascii?Q?BEGtOt4r2O4OkTGhcL3QLc8oU9RmB/45hbM7jRGqTXBVE2xNlkmMgs5PBEEZ?=
 =?us-ascii?Q?4us3XN9cjy3El5tyTSrynoULg4IyFZaj3SlBXYJUnQB+U4qgEwtrww3ufbuv?=
 =?us-ascii?Q?NfL1QR2FKmGiniweX9Yaxbv0Szj5JOAEg4wGka+MHhKavooxp1zh5r9qivVj?=
 =?us-ascii?Q?Cc8X6SLghcB+e92DCSpAf0tGTSyCl4PrKxnL5vUkxOGYg/4yopQlIEtGEPXR?=
 =?us-ascii?Q?/VERTpjSNzaihXV371dYZCRugLVCCKr6Em/N8iJZKxNZpo32Hb7Rt1QT3yx7?=
 =?us-ascii?Q?X2G+d31MXAhq4mkkvpJRpbWLfRUuT997t7E2cdw9PqVyeP29KxaRNqYSVBv7?=
 =?us-ascii?Q?VVchDPwcrNueCt1+Ms3dIV+hEt1k6x930xGmtuDnt+G6II8wBbbVSxmUOdU7?=
 =?us-ascii?Q?ehRHSqvcpN/+vyfLWaZbHUgF7Oz+t0wGVKBgo4DnjA6pTj8b8/wDyQmcZ0Cf?=
 =?us-ascii?Q?PZBA7H7iVm3MHbyjr2Z5u4bZMDF9jSDPrj9dxFyALFm51WwZv3etzysSAY1/?=
 =?us-ascii?Q?46lWY1Htz/N5lZkEq/elVsmC0+OUkhGJD+Ol3xeRDBehkhkfySXHg1HfGQtv?=
 =?us-ascii?Q?WivxkUImHD7tQq5xByMPCZDJawJb0571FZPZa+AAVlvnOHcSs6k7tSXcJtcN?=
 =?us-ascii?Q?fw6NepsyiZV9hly6m3yQ7HYqFqxceKanHiKHEo5UhPXLR3MGPfBGM3Y81Drs?=
 =?us-ascii?Q?+alTB4KD3nMteGYJciGlRXpXb0b8itRWLrUHxi7aV5QvwqEeQozrgTwyARZk?=
 =?us-ascii?Q?FhYG+vhoof/UsKZhc7AZsPq5lNALnKNtOn26aqY1ylgTnvm9ksH9v/BVDorB?=
 =?us-ascii?Q?tTg/eJ2iyfFDRfhHCv9MHXyGs1iix8iYIxfB9Mj9eQMZss/qhhfh+uxOCktE?=
 =?us-ascii?Q?rCIW2o2/amMoKuzWJRjNzGFyLQ1pX36RJUwx3s/ia+nx1qDjRciBjcgJRfEB?=
 =?us-ascii?Q?4rxClPi949vhhdfFGuHNEmyf2TBd5tiIC/GuKhjUSOurXFSzXPzS8XEnOLlg?=
 =?us-ascii?Q?OreUa34kABsazcvA9MT7RAWsdXfPh4QJxbc4uaE3xg11zdS+BryYXsUbs/rp?=
 =?us-ascii?Q?RIYLN2mwhk5B4Jtccdg55C0cL1otnnZlD7yvfQst1zwJWRLX1JBKrridzYgZ?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xFamwBsrOR/d+DqdnEtD258Ru1KgpZBwGRP1hJ2c106oGL/JUPKKwZ5KLN1Qad/WsIF90j1KxNge740X9LLOPDqQPxQDH1pD+uGn06A0P/l2atcJiuUuaay07sOmoUQjMIM1KLNgSxkJQboBjBkFBDdvSA05yZdkkJznRrMcsYt2Kg6t6WTtIgRTAm2Ma2ltTniqf03BAMO6NMREzcR3TB/4kALLw8IqV4ZuAJzb8aC3EtHqqs1PWXOJRwUQvOKy2cSnCsISg+FtTxZr+5PCaSL7QTi30PZxAQtSSG58QL49ugjoyIjyJJeWUTdLOrTP+PBk9hBsIYywJYjwaycGO9w9pEPIcHiPNFysjyDzaXxaP3TwhXqlbo9W2L4M95MHGBuZYzxBMzE381a8C9Df7lxPQXvV4cac5eDPetwXkLrg7j7nyNLtvShTrsRxtPqIV4/gqobHqZdr/Ek3IbO/iRu5/wg44agFFz29GdslKNQQwGIQSrLL0Ym5YesepcCXjAAUV2EQc8uLEInDy649gkVGn8PO3ZbU3SIC6d8dznxNxLh7jwlaz1nAvKGfYWb60xKiE+pQbF25nLk4GXuiD6GEGK8Yf27iLJCpgV3Gbbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a458116b-5bc7-4391-ebba-08dce1fe4ea1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 09:49:13.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zgYXCLHL9OnpCv6477EYqBOKldnfLNRspGKnSPwwWgTWBurhkrzAOPznXanESIaviqMGxlmNeBlkUqkM3VKuEBYxn+vDQLiGS24VXKGe+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410010064
X-Proofpoint-GUID: kYb0vceYAL40mK_tbENv9UvfAG3-Apxt
X-Proofpoint-ORIG-GUID: kYb0vceYAL40mK_tbENv9UvfAG3-Apxt

On Tue, Oct 01, 2024 at 10:20:02AM GMT, Lorenzo Stoakes wrote:
> On Tue, Oct 01, 2024 at 11:10:55AM GMT, Bert Karwatzki wrote:
> > It seems that the maple tree broke down, here's the result of the run with
> > CONFIG_DEBUG_MAPLETREE=y in all it's g(l)ory. (Here I didn't need to try to
> > kill
> > the processes to get an error and soon after the error occured everything
> > stopped working so I had to reboot via powerbutton.)
> >
> > Bert Karwatzki
>
> Yike thanks very much!
>
> If it's at all possible for you to confirm this happens on Linus's tree
> just to be super super sure (again I totally expect this) then that'd be
> amazing.
>
> I ask because we have another thread which bisected a problem to this
> commit which we didn't think was the cause and seemed actually to be the
> result of something else fiddling around with things it shouldn't so just
> want to entirely rule that out (a fix was applied to Linus's tree for
> that).
>
> [snip for snaity]

OK so looking at the output it looks very much like your report is
unfortunate truncated...

There is a 'BUG at mas_validate_limits:7523 (1)' report but immediately
prior to this there should be a line containing data formatted to "node%p:
data_end %u != the last slot offset %u".

Could you do something like:

dmesg -w | tee log.txt

Prior to kicking off the repro to make sure we get it all?

Or you could set a cmdline parameter of log_buf_len=1G or something crazy
to make sure dmseg has it all :>)

Thanks! And repeating myself but your help is very much appreciated.

