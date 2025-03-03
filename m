Return-Path: <linux-kernel+bounces-544858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB6AA4E66F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55438825D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6001FC7FF;
	Tue,  4 Mar 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RS+SaFNk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Naid5mPG"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6E1FFC57
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104304; cv=fail; b=VAvfHQk7afJtseSq67OneAWUDhBMSSKYpfkGSqDK+HPN3NwR8BWq3RwuWgfPqLbPaMYsRYYuObRu6F4bnSl9AiQ0ODbRDsPHe0LUwW8ndZZpWKr6tIHYYo7J+wBwTeR5yVm+8wJxk1NWCIWsxhCZu9ZyxSgdPKSCFVqfsYKflX8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104304; c=relaxed/simple;
	bh=7cmP8SgUaYzmbuC9Q04pq+hL6MZj+IGSuaJ4yA0XdEc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dscG0zGv49FEdAiKhoGQn2w+OkCTox0Xj38xgpAzVEEkB/eB2uWo0OLWZ7rJYiNSaqxhNMPXkwcas0XvihTPqcW/5c22xLs/r76dKPmIkW9AJyC52YVq5NGH3cR2jvFEmNk4uhEXdlHeURAcsDW2vhrY7Ogz3pLU+DZozD5/lQ0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=oracle.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RS+SaFNk reason="signature verification failed"; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Naid5mPG reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id C2BC140D91A4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:05:00 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gTT3TgczG2BK
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:03:41 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id E39A742740; Tue,  4 Mar 2025 19:03:32 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RS+SaFNk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Naid5mPG
X-Envelope-From: <linux-kernel+bounces-541515-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RS+SaFNk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Naid5mPG
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id AE00E41BDF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:14:48 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 443172DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:14:48 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B5A173CB0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9EB1F9F51;
	Mon,  3 Mar 2025 11:09:12 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A91F4162
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000147; cv=fail; b=iDHV7fD1tf8XATubijejDvl6GDFN8IcBEx6jwLbZbzNPzkWVjKpYepvU7ynr7taU3bQ0fB6CbetlKUJCfJPjmBuynJc9GJlx4VX+68VyPsbWWl/M1+QeFP2vcdpm8fjHqKSjxXBht8mt6AC11SPiJ8MYGCYLpYSfGLeZ4v1sGu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000147; c=relaxed/simple;
	bh=ldDB12YCC/vdZx05pi8mnj4yIPQYHJqJFjG5noujMRs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Sp6nyEHj3bDy2f1fjwE91FVYjFiuGxbMC2+AEyDOPQmTIl/3n3hRklPWiMe6l9RG8eSy9I6FCLH6rv9qcPWSgEMktLEn6urJS24PpNp8daFyryxTIK69l15OtU5SjGfBjJyXMeHB9nmEE99841B6b2DDECqhf0RtC/QCpPcYvzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RS+SaFNk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Naid5mPG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tiQY031358;
	Mon, 3 Mar 2025 11:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=j2j9gNw+L4cfSW6T
	J+BAgk3kTUABeGBtIPI/vZBD7HE=; b=RS+SaFNk8O9qMcV7ABqbrAr5jstCtyVU
	9qe+js7MuWQiUFWm+3fccx1gHYsr3hec6PuO8+JB/SVecQxYzRSFwW1Y5YfdPJ1m
	scd6gvZeDyv7F/0KF9XpaFyrVCgs7eaPpf70SGud9HYb5ss6gpgUyB5rtwGk0QDk
	JReyae1xwIW5kcjpvzXjhG92riuWK8XytpW3S+aqdt9A3OcwluGRME5FNeMg8Tno
	q2fGvHQoTMiAUK2IEUv5Ceq9pvaLulGaKA6FjSXDe0U7G79xwfnad8bkyemdMR3d
	BoaJ22wvnlW1jF07Vkbap56nYFg8FBEZQcIS1Qys/kxKii5K78JFPw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81td6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523A3vTW022509;
	Mon, 3 Mar 2025 11:08:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwtapad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK/WAWtuWvVoHbHgPL7M+24PXWwb6bap0YbaMZJxk2f7q+iL+qDzFYKKkSL0MJDgLSpDrhpPCgA+L53AzvQ282x2EqKqATBemvAa4nFvp6leMuAsW+rmy2TDTOc5vIvAEmtSK3b7+5mczS8a4TmY19joXPo3fvggW+IIY3FeU3wgMwNO+QdeDE5AV/Bp1NjjbZNXrm1JzOpwAokS1o0MIzNgDZFOtSOdvHGf/xE2pHmG2sMTEOXNZjyWz3cF3pPZbnKDLwcknbW15SY3Y0TSVoAuQX3pqmIazYF9qMcWJpsrV9m3WjNaerOiNqbMC1GOm2cNqEJpBP/t7xyEYBmaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2j9gNw+L4cfSW6TJ+BAgk3kTUABeGBtIPI/vZBD7HE=;
 b=MJBf8T/zt7bUKQvrHurkmPIlxl3APZQ6zV7z2tWJSQqihx8YmPdOX1jX6p6/YxScpf2/Eck6OEKDUOZJadopsfMgDK9CCfCpEKMoBZQxlOlIJMTOmDfuNXhkq3qhIMUR6UccZwBpn/VMYQKLZD8GK/A4NnbbHGyUgPOOAwFB849pgbvU5+C3zt5/NJ8Ps08wYnP9YCvR5ewhPF//8EaETlO+N9xA4nDGDk6I+8FbjSy96UdLfHsu68+I4fewR4IslENBCttbNdUQ42nIgLsZhV1+KUpCpJt6V1dGZXlT+l7u0UHh4/Xei6GtN9ensQRvtpd8gW2dBnUolXsFK/q52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2j9gNw+L4cfSW6TJ+BAgk3kTUABeGBtIPI/vZBD7HE=;
 b=Naid5mPGUo2LvgOb2SzOGO/2YDvaabmvMvgYl7MgV79rYbPg8/Yf2ZvOq2zWPCi8fZmgve0iU3o+LXKYIih66qCPtDM2qN0+8vaJT+VWOiyXyuyjJJKwK6rP34wuBOVW4B+lffsyEo7XjSJXX7AlSmuEG13wGkdueZQiANdIHxo=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 11:08:48 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:08:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] refactor mremap and fix bug
Date: Mon,  3 Mar 2025 11:08:30 +0000
Message-ID: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbff7a5-06f5-4a79-d20c-08dd5a43c523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rtr4XVwaS0y9PS2YMOesIWlC3UH9+pSEC0Z/ejUbyGRSKNxtaopY3icqTUYI?=
 =?us-ascii?Q?B2aJFtR6w6UOZSJoSB39hAv0TVGZFK4M5ZHN5bxq+ikSHtO7JJ1L3hx/S93c?=
 =?us-ascii?Q?VxqqoncPk17sPPRLA+iDNjsaBY0k0WWyVi/JsrAqXYNclALJEenc/g/+kwpU?=
 =?us-ascii?Q?zvp1oMnZC6OzzKrbvGPnJydz340lP9Rbrv9sTri7g2G1eeSAx3rkf8W1KrSb?=
 =?us-ascii?Q?l2d2dpy6IR7epXR8n6brAB2hl5Cg8jixtsaze/q886JqoISpR5GTv6NgQPf/?=
 =?us-ascii?Q?qGPeKyzyXqFXZ8CRnSY6Y4aAmmc1S09v3HcV1Ej4twD6V5mAvYVUGP2gdeMe?=
 =?us-ascii?Q?XGNMA/eyp62TBYyrVIknuGnoDNBiW/Y4rV3olPkpHYhSnJWCBmEyOPTgaYhh?=
 =?us-ascii?Q?gNr2P9KUSVbteNLnjQ3mXSx4qhyZbDBfcj/JTHFdY24pKZZyBxjFFC5aPxeR?=
 =?us-ascii?Q?BtJ9x5qx46LyWgosh4AbkCZXtqNN3NkOaQceoN/zm88mc3J2CjvTfzwhVgnj?=
 =?us-ascii?Q?EWIIQtmVP6kxQvE8tJZm6UY16I4kz7BT0GVE62Pxp4pgvCNGWq4W0QIdnlvW?=
 =?us-ascii?Q?ywHTLmvu0e6VgAXAHIZH0+skVfRppJjQoSfzAE3XVvOnfvZy5+Jhksazqwg0?=
 =?us-ascii?Q?4lTmKyVcOPmH+jiQwOFn1W/E9dhL4iIXOwj4TRAkhlr21yU68lM2TrvMrMef?=
 =?us-ascii?Q?Plg1R1mfQaBAipFR/0FDPPM0sdz5pn4PKZekAd7DzaYJ0fBN6YnHE+uS94pt?=
 =?us-ascii?Q?V4sQKW5ZcKQ7gm1j4aSBuDzLpBkisbUZuhxm8FULAs5Y81VC+WoarfzhabJA?=
 =?us-ascii?Q?UPO9qO2aNotvaIEXhF60bEE5YKtjVznkHNwPJQ24it9hIKfNpSAN/LFLQVo7?=
 =?us-ascii?Q?6KWCHXMBW1efFaAD/ww4oVO0ncXYPzVTWsX/pgQquS3zhGDKxt5Osnnok+RA?=
 =?us-ascii?Q?fkZbvWCFP9igS78uS7ZAYSYXjl/lnSX9yZBRrt0UooH8Ex0pmImozgpxSSDF?=
 =?us-ascii?Q?M2sGlxtUCeHIHiXjzKWsN/T319CgmrTelqrteCoFDHbjPUJkUIDczvAqMd1v?=
 =?us-ascii?Q?xrPxI0zRuJy/tiJdaKnVMQCGAV5FsTJJD90+PPGTFAqgVgwIBPatqGTS5O8a?=
 =?us-ascii?Q?aFjA1rlwd8ZJyTUAjooPNPpg2TVSXC05VSR9iH9cPXPNo+BjBab//8l5doNs?=
 =?us-ascii?Q?FF+ysjYAtkQHliktkqG0DMCdQfUM+JnKNIUgmg2/++xa8Mmc/idixz71cJ+4?=
 =?us-ascii?Q?ONs97rJ6q19N9ieZw3mS88nmuaaLsCGSydN/tYJsyeUtN0ea7s/HhCc/1oBv?=
 =?us-ascii?Q?h2gID4WX6BSGJ6bIMOJe25SAVinonI1T9DcOyXoJmdi7BoQnnj611C6NHjwT?=
 =?us-ascii?Q?KWFpFj48tLaSJ8bdid6urnVlzJId?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sG3jEspAkZ0wD4AvL3lq8HGE5PQdZNAYEzkm/huqM8L30oru7N36LvTVxfLc?=
 =?us-ascii?Q?5WXb5Dg5gRHpM8OVgt71wYg3/ZdQ0tLkq/7nRzCR74JmnR5dcRXZhytBusWM?=
 =?us-ascii?Q?hRW/JPYQ/bJOovSsGvA7JBhHNV8aTrPyhYI67QSG+eT8l9rnFFPbMR3Mp1pC?=
 =?us-ascii?Q?1qjYUdcF9V0sUhN+REMcCFGhSF6EV9RC15nBvYnsZthl67PHZWZYU/lRjpnv?=
 =?us-ascii?Q?NKfaqr1tySUIZqkBhkc5O/qqznErfEk9u18Rm3NeHci0XTE9onq+d1oAuWaO?=
 =?us-ascii?Q?qlADNNhEY39mAy2KSmaISipI1uT67+Z20jBNazTVjTnX3eMuU1GV5mMHtumQ?=
 =?us-ascii?Q?vQL7f5L42vkGh5Js6L9V7iPQFdQjmIkwS9ylZ15st7drFrv1vUCJIi73xLEe?=
 =?us-ascii?Q?J/tD65nQvqIk9GMe32SL2cxRoM7IWJ1OsMosv5UERlPOmY4qsLc4t1Fplnbz?=
 =?us-ascii?Q?+hadQVpB+f7DlohRSXlFbmIAzqcPBTenHG2H3PNckwLpmyBLRivSyAB7jKXm?=
 =?us-ascii?Q?NVkWc0jysxEdhyBOuXVYmpCuY0P1555H9CtoRCQk9i+Yttkz8oxp/iug/aS3?=
 =?us-ascii?Q?iN+A+lYXC/jKaUdX2cbzWkg3GtgTAyn69eMNnGJ0ybw8NxJAuvawqn60Yw+S?=
 =?us-ascii?Q?5cvVSyuigjj/TWXdl2Kw7eLuMpI59PPc9Uuu6eL/ZJ5w/FI/Mm3aDghh1sMu?=
 =?us-ascii?Q?74RPWgrqcUVy9+vObP83r6mYwMbvtZ0Hlo3BQ2WBpFwo5PO9dBFd7APdEUId?=
 =?us-ascii?Q?gRHgniRrQh8HKadAakHR9ZoPRdwdSm7GhALz45e4V/6TtL9W8xWiW+w81DmQ?=
 =?us-ascii?Q?YkenTrMXu9aXLsJ5mUkuOR0Ku8O0W3H0zFT2kj4lDzw/41MY8sj01Jw894ej?=
 =?us-ascii?Q?wuVTaq3w0KfDOwvF7BpDl9vDc16qiv5xQ+8jMnZ3Sw7hHnJAOntzDkv5p4Vp?=
 =?us-ascii?Q?raEM2yNy2wVjulzwYT8QNfTJDexhnSHtjbX0TDFekeH7C1fvbsWvFrJPsLc5?=
 =?us-ascii?Q?A62pMPyLTqxwfZ/pvMIo+KS+Z4VwkklBy51pDg2UnMbhJqduiZnhdwdvKW4o?=
 =?us-ascii?Q?fAds7hrbt+Ujw5fdZiJFF/xBPvAXwvAzuis8i62UJ9ZlHHmgu+RBQoBGKOJG?=
 =?us-ascii?Q?LLdocV5k9oz9Pc4E6rm7R1vdBTushS+dkUyjhLUjFD2g+RWlpGWH3AeMyMFI?=
 =?us-ascii?Q?LC6mWHs9FdtBSXaDDhU0XLYbg+cmCIayXlYdMJ9/L56Y3vCGDxiZD2RBvqIZ?=
 =?us-ascii?Q?pdbvWGt2fKpRLBQdgw7MejTynt392T6nuYvTvTPP9woaCS/A4vefZFW/HPaA?=
 =?us-ascii?Q?fbgr0MZrPw+oYHs+gpESFtBtsxcN4uo+l5A6s3DcNRO1jE1SuxnF1H9e2+8Q?=
 =?us-ascii?Q?4fkDKg9CEg9ZIML+takhS1iGMwJHCaHH5SLgYXgGjVh362m/NBT1Vyd45O/3?=
 =?us-ascii?Q?ZbaDovYW7Lh2xhvr6u5lLjhsZRw4ldtN+fyWzF3wuve3bBBX5mNTyZMlxuR1?=
 =?us-ascii?Q?CrQ24LmJnK3Sf6O21vz0PS+TnqfLa8X+bKoJNTUhnsnwIb8l0cTaFoZUIEFE?=
 =?us-ascii?Q?/Jw6DmXnTeQZsZFCYCF5yb5aYNPCvJYH0mm1SUWEnH9wGp0bG210w4hQqEB0?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YqTqIXmYGM0F23eEkacquLS3NAjixABNuqoGvyWjdHOxxjgL7UgatrxXSM/tHHXrX4rSOxYaSIHbdRbN/e1kNIes9QZ8cuCZ9ql8FvTEy+bHatfsm3wP1vCDST3vs73huBFPvpcJmQGGHvHRLmJb6gGOCjZwOcoQPFsePvxAU5OfHIwDIQViEe4Hdk0UV32efO+7jbaEIceFYO9ehX48AsoSWBlQKmDl/dcbG6zhQSBY88uCm1tDJrDLMtn/OIeiqBkitDuNP7Md1Ckk7Nbxd7pnxMIr3mX2jeNKuOshZBnokCTj3qVm/8i/3bDpFTTG4bJE2wCJkaVO9lA6VsZ6KAze6VbzLwsqPsf7sMPiaZacdmL9QLEIT7/Y8xgpwxTyL6Rck+xNXSo4BQPuJ/JrxCGC2xtW7LNLv9DHHjo5jIvtRF0LMcLcKcBmC/G5xwCa8rlwQ8XzgM+PaxQnFND4dJwIpHS2tWzFYyJTl3n4hHXYPsLO8ixEEtP6ws9U/J2W4/TXBXzaMkOcCGNiLF+TxtETR0vgnYHkWFmouAzcqvHCU5hTfTvUiijHV7YFwINg5AaPin7z/f5cObcIzoGSRiIhqzLjTwKoSN9DrbcUCjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbff7a5-06f5-4a79-d20c-08dd5a43c523
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:08:47.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN7rVMzFiIfm7kPHXzIsSIbkSXYz1dpk9h1xEEDyfwTNkicy2ev0OhedK1i5fR+QC9bfDFizG25o+lxhsij01JZY4pNQBaULQ8cPn9HhVUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=534 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503030086
X-Proofpoint-GUID: qOw-LyYoUVt7uRdi6RpGiYNoS7b1rCiK
X-Proofpoint-ORIG-GUID: qOw-LyYoUVt7uRdi6RpGiYNoS7b1rCiK
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gTT3TgczG2BK
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709037.79855@V2eks0yVDEurm4B+/t9Dfw
X-ITU-MailScanner-SpamCheck: not spam

The existing mremap() logic has grown organically over a very long period
of time, resulting in code that is in many parts, very difficult to follo=
w
and full of subtleties and sources of confusion.

In addition, it is difficult to thread state through the operation
correctly, as function arguments have expanded, some parameters are
expected to be temporarily altered during the operation, others are
intended to remain static and some can be overridden.

This series completely refactors the mremap implementation, sensibly
separating functions, adding comments to explain the more subtle aspects =
of
the implementation and making use of small structs to thread state throug=
h
everything.

The reason for doing so is to lay the groundwork for planned future chang=
es
to the mremap logic, changes which require the ability to easily pass
around state.

Additionally, it would be unhelpful to add yet more logic to code that is
already difficult to follow without first refactoring it like this.

The first patch in this series additionally fixes a bug when a VMA with
start address zero is partially remapped.

Tested on real hardware under heavy workload and all self tests are
passing.

Lorenzo Stoakes (7):
  mm/mremap: correctly handle partial mremap() of VMA starting at 0
  mm/mremap: refactor mremap() system call implementation
  mm/mremap: introduce and use vma_remap_struct threaded state
  mm/mremap: initial refactor of move_vma()
  mm/mremap: complete refactor of move_vma()
  mm/mremap: refactor move_page_tables(), abstracting state
  mm/mremap: thread state through move page table operation

 mm/internal.h |   49 +-
 mm/mmap.c     |    5 +-
 mm/mremap.c   | 1440 +++++++++++++++++++++++++++++++++----------------
 3 files changed, 1033 insertions(+), 461 deletions(-)

--
2.48.1


