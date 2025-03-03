Return-Path: <linux-kernel+bounces-545039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262CBA4E840
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1C37A4F9D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5BE296177;
	Tue,  4 Mar 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mgt2ekRx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nmLdRnED"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30F293B71
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107097; cv=fail; b=o7Mjicl8dlO9k+VwQhNgcfDmHcKm8ckc5frxhuKQ8XWWKCwjIPnEDUbHnlLRFeshpDU2xEwMZVlHcw/HL7tjK33bCCePvSG8DeBw6AB1hTxpjkZrXFy5GuuQTAqa+O8LrPrEblE0r/CqsbqMcS7pUKO5hgeLzHsasmhNvlxcwp4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107097; c=relaxed/simple;
	bh=HxHRboPuKSJ7lxGVjFFC1n2DnvG1/F27j8UTD7GV/0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qKkrff9V+iz87VsSjsIGwclpOy3FZ5AQo1fy1/+b0hTXxuvL/+epnnFSxQDe7Oehe6OcMNa6ZtzL1apOpgND3TS5wsC+gWgxhTn3C6RM4eDD4NS/Y1vEufruxX9BZjoEstMhu9k/hK64tYItVvk3fFpapBL3dIKch1QiQn0Q8Fw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=oracle.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mgt2ekRx reason="signature verification failed"; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nmLdRnED reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id A9C8A40D1F45
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:51:32 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=Mgt2ekRx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=nmLdRnED
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g3b4cDNzG1HW
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:44:43 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 3F0A442721; Tue,  4 Mar 2025 18:44:29 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mgt2ekRx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nmLdRnED
X-Envelope-From: <linux-kernel+bounces-541519-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mgt2ekRx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nmLdRnED
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 8ECDD41D8A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:15:30 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 25BC03063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:15:30 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A23B1757C7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9F31FAC5B;
	Mon,  3 Mar 2025 11:09:18 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD001F582F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000150; cv=fail; b=iqcjxOsbuiKHZNZr94V4EINS/gKeC6AETgJ1P1NutU/e3wlH88sAMLL6GwkYx6DEdHh5Qh4qfH5BIPETMT3L8SohIpvmuWcimCx47qbH4AjIOV0kGOH09jNkyqznUxY8IQRfY/a93xFOXll8RQveP/Ry08XSlXlaVGwqXxhCws8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000150; c=relaxed/simple;
	bh=QJSvL382/HvTp0VpygB4ESMQYpQeJUm2VvyzxntzJes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJm+BdRVJ8kWww1/H/0lhOLdM3xkzDUS90itnvCgdY9dEE4C+idS0Sqdks6ALTq+0mZFZG97IjTsRaAaApMOHJ6zw8GMTFnifK8MtbvxClfCI10XExCoRJTSjqSdqEzGXpz8GaMSjyhEhVjTiesUliRGuToEXbK/wMdxb7xf5+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mgt2ekRx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nmLdRnED; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tiV9026461;
	Mon, 3 Mar 2025 11:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Au38QI6Bec+OFkRDyXv79mMYH5dNLY0/KARSrcoXYSA=; b=
	Mgt2ekRxUwVThS+ZM4eKes2Drg2u2pGICuVYJrt9gh+5lPcItlf0kXrGab4qsAOF
	kHiwuc9QgqVWBVntoTfPOJpp28tCO47JKQ9gynOmGsN1ZQIqjDSIk7i7X+rzzfsa
	Kbjjb3dfQMVik6sGVtJpiKoL3BFRdJ+sqZKSBcmq+p7lYq6WBtAoouoH/ytlQ1UF
	4xyduJwTA3eEKeowu/EZ7y/EDHdCFLNPmIpnQeyb86DFcdsvyVXJsobEhwrgmsHI
	JmbjRw62f3pvpTE9oLHaC3NWnpAxoyzL0X0YtIiXb29eqm1kouxrmjPLve4u69JI
	OGZeWgNMH42We9bypaCvmQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qae10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:09:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523AiLnP039768;
	Mon, 3 Mar 2025 11:08:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp82hmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkrAc9NQ7HxhwOBW4XKEWDIBO+LrfWUEKCU75TWKLMf5hGsvShVDBdsCSdHKOyMv21ZZQY0HTTr1mXOENQWOAb4Prs+dM3dfVVlU34JVMH0KAo59xFIrh1HJvlhsOXX6WKoT6xgseMbdtU7TqZwEsfewBj7YwLmAVwRIVp3wjSrQxUhOko8A5QT5PGVCpURZrSvxEt7X5pTdUHUDp9bHRRoLvNyGo0rKCy0VuUy5gJ8Z/1yTOtdb5xsfJRfeNmILLyu5l+gEgzEcAfwtTtHxri+ypXS/k0C5jyFyKaES3LeSJp7P3AFOGrTOKHaTu/u13Dl+IDk7zyeImkzUzDj80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au38QI6Bec+OFkRDyXv79mMYH5dNLY0/KARSrcoXYSA=;
 b=fCUVZy4WO0g5gMhxuDKd1d/VDFTp8lpJuj7og/tgmf8awrsMqeX9KteteR8oitjSvo01uRV+tNm1tHR5WAlvp3rGawEKOlyRkQa0NwppTfadNHn+YNEBiWPc58NwdUETBq+URm63iky+EN/w4ICOOhec0JEPsUSciTJ10ztHXBNPorbutSbMYt+xoGXEyTmjNXmURAM3H9QmEu+xaWma1pDL21A1MIUZQEeVwv126J8xv3++DvnZlFCKtrQ/JKjNBpKLWSLzQV97eaU6Y7Tx+MbgLpb4WbaRrCUY06afD+Q/MrrOHUnVd+tqdKzg9kZaY8ZSmeJm/LQSniqDo4+RWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au38QI6Bec+OFkRDyXv79mMYH5dNLY0/KARSrcoXYSA=;
 b=nmLdRnEDFtMwvBAWrbYGJ9CVqrihqtW9dk9zg0S+uK24MOf9DQj4WzcR3eorHbmEGWMo/7VWj6x1jdYJOHIeiTe31iQqnsTiKBKUc5oXc6KXX054140z+gilbZioicX+FZ6HZcAMVKjWOBpModdUequ11ofyPL9D8NEvbYF71bs=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 11:08:58 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:08:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mm/mremap: complete refactor of move_vma()
Date: Mon,  3 Mar 2025 11:08:35 +0000
Message-ID: <61a8071433adf3815713523a5c1db62cbe1e55a1.1740911247.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0246.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::9) To MN2PR10MB4112.namprd10.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f93c710e-318d-4a3a-006e-08dd5a43cb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRQETfuCm8tEHR1Q2btnrPKTHtfRag5V1b0QlkpcWiA27KRuDS3HJsn3vZky?=
 =?us-ascii?Q?GYxX2JS0+a6tNaGx3EAuL/uwt/sKTZBZD9gAk/ASxdnjIaDXkp9ONxHDBe82?=
 =?us-ascii?Q?meAOKdNhV0DDQtEACtfd4tqQ20aiOrn5QrRPT7uUjni7xLiaJP/8Rp5/OQAq?=
 =?us-ascii?Q?O51hyG1fFLfublnjPZVepghEakf99aIdc2t30teUJnF/j7NCwqhMCtM1Vvo7?=
 =?us-ascii?Q?kYDxVSQwFGZKGkwl5L71qLKQmbAoreYqVFchqfOcBp+mEUXwb8P0CTKMeMFc?=
 =?us-ascii?Q?qaQJUGcq9355OzFd0ZeRa5pUN0d6dHjoB9XXMheKKY2vt0VPNQdHdd6728xM?=
 =?us-ascii?Q?IccIZH2SEZfUaUxKkuokaLMWjOR0lDvR0gHhrMFhJKlEufuNdjawb7BkYRkk?=
 =?us-ascii?Q?M+9ZuPV0z8FhWckZWDCqow3w59oQDScBopphRMrOi70VD8YmLK53p5iqFE9Y?=
 =?us-ascii?Q?NNGgr6RYgqHFlGlIE0l6gaHSbCDBuUv5iVSkABTp8ithakk7O30niyL0Yx5v?=
 =?us-ascii?Q?VcNqx3x5ezATzuGgBsElgW74+DLixKO7V7K7fwSQCGBvybwPFpzJ2S+v4grE?=
 =?us-ascii?Q?M/mwIhJMQT+VN+N0yG+flEMPmokrhUjfXHJHN/cYwRkSU+OdJpuPgR1mkVd7?=
 =?us-ascii?Q?ngYG1zVNp9uMQL6J8ZNYCjlbIatOHh7iJ7E40xTkxl6ASLN+fKNn7PWyv/Jg?=
 =?us-ascii?Q?3ziUGhBIeWHvFEzVwkO/qgoO90BUC/lkA95UXlFroanmZBxQgjLI+aHZUj+z?=
 =?us-ascii?Q?SknBlZPoRmp9tsN2FZC/pPZFvh/df7VogRHQ5yQmERImNpFB1tKHfCWvdDG3?=
 =?us-ascii?Q?igAyU28T18A6Ux3fVu6YziH8YMfHjE1bmxwfD4GOVkY2CfXtYgD+ltj890gq?=
 =?us-ascii?Q?wVe5+/ZyDLfVJfZIz18rkFXmxrO3Aif/odBxF0MDHlktGHlLbKXIQ0Tp8zAP?=
 =?us-ascii?Q?OBMbgQM+HzPIiGQmFN/XNi5Cimo+S68/KpCk64vX0Q/U35T0Slr3sspOkTmt?=
 =?us-ascii?Q?iUJJkllHpLdn/d6UGFTmm7kApSFwoSIzaAfXCzPAA9D6PI8X4YlJ/50Qtcr2?=
 =?us-ascii?Q?Ag9Ok0jHEAfSO5TVa0dmPUy7eRHz0R1yIWlDBqe5Lnc7PKzqVZuqrQWDIdLr?=
 =?us-ascii?Q?r3PVOegQrKZUqesdQSbPo7TwJ6+nUYRrYjF7uSzgR6lmVM/UMKpBaxH99SFA?=
 =?us-ascii?Q?sbErrXWFsB31f1zXcOFxfAr8kuTbVJkvbltunagpLyXtwi9Q3NHeCz0nDDkg?=
 =?us-ascii?Q?dKL7TrRuyozsxGr3DyAWQZfts8S1MWzJr55z4t4VTNZRs2b6VxcWOg3fgCNU?=
 =?us-ascii?Q?Wc0awrcmjsxyUujvc1qtNkgPSXXBbupw9rE3N+7DcZYHvTyBaMIEJOo6cqmw?=
 =?us-ascii?Q?ODwf2MYYZMFp+szoDeFpPgMcxmSU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MKkuKZ1OqBOeo6QTj2OtGgrblUUbQLb3GrCAXPiF6+eG0AMkf1Y17+SGjal9?=
 =?us-ascii?Q?dBvSzd9g7k8VnO72XaWQXuxBeliAAEuNKjJX0iomIKI+3/yReA8sHd9yrVeY?=
 =?us-ascii?Q?eyDeby/E3i45/B3JXfWkdNg3LAkZ++fsXPMypCz4yo3lChRlPz1g6+sn/ml9?=
 =?us-ascii?Q?hXFZa1XVl5izkxIHQRg9NfcYPXQphQH+5saq9BWo7r3/dVZ4Kp7zByxp612o?=
 =?us-ascii?Q?jLSfRBmQKKhB7UjWMbxVrxnf3eIsx1Pz+I0kvfBkERLReaKEpP6HagU+/jXl?=
 =?us-ascii?Q?TPnJ71pdSNjBpNHUgXkTe7733bKnyomrcswz+w3+LbRVdvGgasUnqGUchhXc?=
 =?us-ascii?Q?UhanvrRpi8jf394AJ9p0wGCA9+hMxnCYEFG9iph2xz6xXkVKt8D8wzE6WZwe?=
 =?us-ascii?Q?54xDNTdlnqSgXlnug64fI78LQtfDnSRB2zXB8BL7erLepwRqMC95dolCi+sT?=
 =?us-ascii?Q?Jsrj7OomVUwatpYC+gxCyb5B2Qe+Lpm/5E+YEGUSg005RFiCy5n75MGKbwm4?=
 =?us-ascii?Q?OkXDXu0+bvOCEXNQqxw3zr3OZxBcGPoa1DJn9YaqdDcRhCMa7dyZWB7945vb?=
 =?us-ascii?Q?GeXE4wO/C41htob1Oae4cZy8mTLgkiBwyMbVH8M84V5Yor2EkYnoh3TAyCJk?=
 =?us-ascii?Q?w6JlXpXITQe/x0dcppex9RbPw/cIhdelaC1uyDTZScRVOsmneoSbRnUsxOt6?=
 =?us-ascii?Q?gCsx5ns4sgpyR9YnvIFc91IuVba5jlsYf8LMuVHTfS90u2zatr8nwC6c8+um?=
 =?us-ascii?Q?6u6McFEKPTedj3dMoF2TyhV3eutBMUgytvQYoAp6THzg7W51ATpc4cRandke?=
 =?us-ascii?Q?oMnVdBkRk2aCAe96pBK5dLYNHTIY8KybEwzQ02/SPH6lfNRJyntT1WhBwn2/?=
 =?us-ascii?Q?uMDMmpRWpyqdTLmSh41iAVozLg5LKCl8hubjK3hBtNy81Wk3p4Mj3TAAUbDG?=
 =?us-ascii?Q?O7TD7h1tr7ko/w7pKILxPkcibjFpwVDFvnx6790mEhWq/+AawERyZ3PzFJ3F?=
 =?us-ascii?Q?2BaMHhfxuDRbxua6kAX2ruLn8AwA81jWGn/onrry3wGuB3HVLmviq62bRTqY?=
 =?us-ascii?Q?0ktoAYNek/z5PGk15DkOK0Kk7BCRoZlkuHCDUfqMVofZ8IEU3hUa62pyoCRK?=
 =?us-ascii?Q?pAEOelGbk2tlBTGhzdyGee+nV6ohwrpvxeytMwbCdwWzjLu/rv6gkzxkLjr7?=
 =?us-ascii?Q?Asevj9hyq/vnw474yKJvUe21/cST6Sj9Hdm4Qe8rNLUImuGfl6VMGUwqs2KI?=
 =?us-ascii?Q?n5H6VM1xgVPJCXDMMUpkZWTPQk1Jri0iE4mx82OdUqZ1mUv1LN77Dby5kHet?=
 =?us-ascii?Q?QZtG82ljlv1TytK4/8+8cDUj55iC2zS+220l6ydYNpmw8jQ/BL8GT99eCZmO?=
 =?us-ascii?Q?XLIrJzo64YAHwwYcHisTQvt5gj/wYvA2GYs9j7x+UOGo2rqSxsUMtcb5Z7c/?=
 =?us-ascii?Q?uj5UmAmYrq380xwtNG6TqhLW1KDvXt0z+iB1ld5fs4bWBl7jf4F5J+60pbhn?=
 =?us-ascii?Q?3A9Oig+vVzQ+ZFzCZ5PeFrx8kCOOmPaNvxJDWHm8vlm5vy0f5K2sPVyJ6X7X?=
 =?us-ascii?Q?ZhSerARi8N6lTl6+bVYx4s+4l7429Bsk3cD22mh0/8y2uI+hZT1S3MvBX1gA?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I5YimbcIR7hzzno79S/mokoTxaoyBDWuBp054+ne4yoFvatEpzrlLZZ6ms+FJcQ91Vy9pfrynpt/tCL3xz/tEB2RpF0X47CmB4hTVaJozIZI2fNFMWud6TM7aF3MdnvkbNRZX3lDMFq4zUmrBTpJTmDcVdE7et2kkgg/cdsCC5Me3VyMz7ZlbBGFY6Rp7mqeVAfoMQgLJq1AP0QQyL/vS8Iq9x5M/nAk0x/isajvbNEzHf77ki7hkAMOHmm+/ljEYZw2nRwg6TYoWvzib21yw6kj84kR52PICjvBMi6NEYM7zc/JWUC7qCCJzoGOf65UP1lsSaEEJ+BHa8U+ppaDl9R5gyhjtzM6fsCCMUVPYuSjZYzwMGoRf8JRMKBVnKRF807egHqq+fRNrHOf8jorlUYhHhbqJ0bWxf66+OL2zswRU6K7UnOY5ylfhWp50FJn5JMhZwtP7gwmkcHbj8b/QklmbxPmqFVvcBhaGFLiXZ+znwOAeI/DsPCOlGCDTwHa1emAXGd5eR1uCUXB8Px1/SdlJkalLdFLLrFoOAoMGJcis8EcpL0X9IcbqN0bctW65F1+/o/YJFY00B4u63WkWiV3jTXrlufM6uw8SllDkc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93c710e-318d-4a3a-006e-08dd5a43cb59
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:08:57.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwvxwxaJ4doyWXUQGQp1E+AAcjtnSdQ1Xhco5kXpDH9QAnzIx9aqOVxBXyyzBSdJBGUwmXHdCbFtiZi/3p1lHyC5C3YnsxjlGsjMw860s3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030086
X-Proofpoint-ORIG-GUID: iGtWUZAdCvS-U_l0Rv6oWk35Vgms-Xva
X-Proofpoint-GUID: iGtWUZAdCvS-U_l0Rv6oWk35Vgms-Xva
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g3b4cDNzG1HW
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711804.72151@TPvlanr66IEveap0s2PHSQ
X-ITU-MailScanner-SpamCheck: not spam

We invoke ksm_madvise() with an intentionally dummy flags field, so no ne=
ed
to pass around.

Additionally, the code tries to be 'clever' with account_start,
account_end, using these to both check that vma->vm_start !=3D 0 and that=
 we
ought to account the newly split portion of VMA post-move, either before =
or
after it.

We need to do this because we intentionally removed VM_ACCOUNT on the VMA
prior to unmapping, so we don't erroneously unaccount memory (we have
already calculated the correct amount to account and accounted it, any
subsequent subtraction will be incorrect).

This patch significantly expands the comment (from 2002!) about
'concealing' the flag to make it abundantly clear what's going on, as wel=
l
as adding and expanding a number of other comments also.

We can remove account_start, account_end by instead tracking when we
account (i.e. vma->vm_flags has the VM_ACCOUNT flag set, and this is not =
an
MREMAP_DONTUNMAP operation), and figuring out when to reinstate the
VM_ACCOUNT flag on prior/subsequent VMAs separately.

We additionally break the function into logical pieces and attack the ver=
y
confusing error handling logic (where, for instance, new_addr is set to
err).

After this change the code is considerably more readable and easy to
manipulate.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 292 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 203 insertions(+), 89 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index fdbf5515fc44..1ceabd0d9634 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -889,13 +889,13 @@ static void vrm_stat_account(struct vma_remap_struc=
t *vrm,
  * Perform checks  before attempting to write a VMA prior to it being
  * moved.
  */
-static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
-				   unsigned long *vm_flags_ptr)
+static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
 	struct vm_area_struct *vma =3D vrm->vma;
 	unsigned long old_addr =3D vrm->addr;
 	unsigned long old_len =3D vrm->old_len;
+	unsigned long dummy =3D vma->vm_flags;
=20
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -921,56 +921,150 @@ static unsigned long prep_move_vma(struct vma_rema=
p_struct *vrm,
 	 * so KSM can come around to merge on vma and new_vma afterwards.
 	 */
 	err =3D ksm_madvise(vma, old_addr, old_addr + old_len,
-			  MADV_UNMERGEABLE, vm_flags_ptr);
+			  MADV_UNMERGEABLE, &dummy);
 	if (err)
 		return err;
=20
 	return 0;
 }
=20
-static unsigned long move_vma(struct vma_remap_struct *vrm)
+/*
+ * Unmap source VMA for VMA move, turning it from a copy to a move, bein=
g
+ * careful to ensure we do not underflow memory account while doing so i=
f an
+ * accountable move.
+ *
+ * This is best effort, if we fail to unmap then we simply try
+ */
+static void unmap_source_vma(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm =3D current->mm;
+	unsigned long addr =3D vrm->addr;
+	unsigned long len =3D vrm->old_len;
 	struct vm_area_struct *vma =3D vrm->vma;
-	struct vm_area_struct *new_vma;
-	unsigned long vm_flags =3D vma->vm_flags;
-	unsigned long old_addr =3D vrm->addr, new_addr =3D vrm->new_addr;
-	unsigned long old_len =3D vrm->old_len, new_len =3D vrm->new_len;
-	unsigned long new_pgoff;
-	unsigned long moved_len;
-	unsigned long account_start =3D false;
-	unsigned long account_end =3D false;
-	unsigned long hiwater_vm;
+	VMA_ITERATOR(vmi, mm, addr);
 	int err;
-	bool need_rmap_locks;
-	struct vma_iterator vmi;
+	unsigned long vm_start;
+	unsigned long vm_end;
+	/*
+	 * It might seem odd that we check for MREMAP_DONTUNMAP here, given thi=
s
+	 * function implies that we unmap the original VMA, which seems
+	 * contradictory.
+	 *
+	 * However, this occurs when this operation was attempted and an error
+	 * arose, in which case we _do_ wish to unmap the _new_ VMA, which mean=
s
+	 * we actually _do_ want it be unaccounted.
+	 */
+	bool accountable_move =3D (vma->vm_flags & VM_ACCOUNT) &&
+		!(vrm->flags & MREMAP_DONTUNMAP);
=20
-	err =3D prep_move_vma(vrm, &vm_flags);
-	if (err)
-		return err;
+	/*
+	 * So we perform a trick here to prevent incorrect accounting. Any merg=
e
+	 * or new VMA allocation performed in copy_vma() does not adjust
+	 * accounting, it is expected that callers handle this.
+	 *
+	 * And indeed we already have, accounting appropriately in the case of
+	 * both in vrm_charge().
+	 *
+	 * However, when we unmap the existing VMA (to effect the move), this
+	 * code will, if the VMA has VM_ACCOUNT set, attempt to unaccount
+	 * removed pages.
+	 *
+	 * To avoid this we temporarily clear this flag, reinstating on any
+	 * portions of the original VMA that remain.
+	 */
+	if (accountable_move) {
+		vm_flags_clear(vma, VM_ACCOUNT);
+		/* We are about to split vma, so store the start/end. */
+		vm_start =3D vma->vm_start;
+		vm_end =3D vma->vm_end;
+	}
=20
-	/* If accounted, charge the number of bytes the operation will use. */
-	if (!vrm_charge(vrm))
-		return -ENOMEM;
+	err =3D do_vmi_munmap(&vmi, mm, addr, len, vrm->uf_unmap, /* unlock=3D =
*/false);
+	vrm->vma =3D NULL; /* Invalidated. */
+	if (err) {
+		/* OOM: unable to split vma, just get accounts right */
+		vm_acct_memory(len >> PAGE_SHIFT);
+		return;
+	}
=20
-	vma_start_write(vma);
-	new_pgoff =3D vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT=
);
-	new_vma =3D copy_vma(&vrm->vma, new_addr, new_len, new_pgoff,
+	/*
+	 * If we mremap() from a VMA like this:
+	 *
+	 *    addr  end
+	 *     |     |
+	 *     v     v
+	 * |-------------|
+	 * |             |
+	 * |-------------|
+	 *
+	 * Having cleared VM_ACCOUNT from the whole VMA, after we unmap above
+	 * we'll end up with:
+	 *
+	 *    addr  end
+	 *     |     |
+	 *     v     v
+	 * |---|     |---|
+	 * | A |     | B |
+	 * |---|     |---|
+	 *
+	 * The VMI is still pointing at addr, so vma_prev() will give us A, and
+	 * a subsequent or lone vma_next() will give as B.
+	 *
+	 * do_vmi_munmap() will have restored the VMI back to addr.
+	 */
+	if (accountable_move) {
+		unsigned long end =3D addr + len;
+
+		if (vm_start < addr) {
+			struct vm_area_struct *prev =3D vma_prev(&vmi);
+
+			vm_flags_set(prev, VM_ACCOUNT); /* Acquires VMA lock. */
+		}
+
+		if (vm_end > end) {
+			struct vm_area_struct *next =3D vma_next(&vmi);
+
+			vm_flags_set(next, VM_ACCOUNT); /* Acquires VMA lock. */
+		}
+	}
+}
+
+/*
+ * Copy vrm->vma over to vrm->new_addr possibly adjusting size as part o=
f the
+ * process. Additionally handle an error occurring on moving of page tab=
les,
+ * where we reset vrm state to cause unmapping of the new VMA.
+ *
+ * Outputs the newly installed VMA to new_vma_ptr. Returns 0 on success =
or an
+ * error code.
+ */
+static int copy_vma_and_data(struct vma_remap_struct *vrm,
+			     struct vm_area_struct **new_vma_ptr)
+{
+	unsigned long internal_offset =3D vrm->addr - vrm->vma->vm_start;
+	unsigned long internal_pgoff =3D internal_offset >> PAGE_SHIFT;
+	unsigned long new_pgoff =3D vrm->vma->vm_pgoff + internal_pgoff;
+	unsigned long moved_len;
+	bool need_rmap_locks;
+	struct vm_area_struct *vma;
+	struct vm_area_struct *new_vma;
+	int err =3D 0;
+
+	new_vma =3D copy_vma(&vrm->vma, vrm->new_addr, vrm->new_len, new_pgoff,
 			   &need_rmap_locks);
-	/* This may have been updated. */
-	vma =3D vrm->vma;
 	if (!new_vma) {
 		vrm_uncharge(vrm);
+		*new_vma_ptr =3D NULL;
 		return -ENOMEM;
 	}
+	vma =3D vrm->vma;
=20
-	moved_len =3D move_page_tables(vma, old_addr, new_vma, new_addr, old_le=
n,
-				     need_rmap_locks, false);
-	if (moved_len < old_len) {
+	moved_len =3D move_page_tables(vma, vrm->addr, new_vma,
+				     vrm->new_addr, vrm->old_len,
+				     need_rmap_locks, /* for_stack=3D */false);
+	if (moved_len < vrm->old_len)
 		err =3D -ENOMEM;
-	} else if (vma->vm_ops && vma->vm_ops->mremap) {
+	else if (vma->vm_ops && vma->vm_ops->mremap)
 		err =3D vma->vm_ops->mremap(new_vma);
-	}
=20
 	if (unlikely(err)) {
 		/*
@@ -978,28 +1072,84 @@ static unsigned long move_vma(struct vma_remap_str=
uct *vrm)
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
 		 */
-		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
-				 true, false);
-		vma =3D new_vma;
-		old_len =3D new_len;
-		old_addr =3D new_addr;
-		new_addr =3D err;
+		move_page_tables(new_vma, vrm->new_addr, vma, vrm->addr,
+				 moved_len, /* need_rmap_locks =3D */true,
+				 /* for_stack=3D */false);
+		vrm->vma =3D new_vma;
+		vrm->old_len =3D vrm->new_len;
+		vrm->addr =3D vrm->new_addr;
 	} else {
 		mremap_userfaultfd_prep(new_vma, vrm->uf);
 	}
=20
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_vm_hugetlb_page(vma))
 		clear_vma_resv_huge_pages(vma);
-	}
=20
-	/* Conceal VM_ACCOUNT so old reservation is not undone */
-	if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP)) {
-		vm_flags_clear(vma, VM_ACCOUNT);
-		if (vma->vm_start < old_addr)
-			account_start =3D true;
-		if (vma->vm_end > old_addr + old_len)
-			account_end =3D true;
-	}
+	/* Tell pfnmap has moved from this vma */
+	if (unlikely(vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_clear(vma);
+
+	*new_vma_ptr =3D new_vma;
+	return err;
+}
+
+/*
+ * Perform final tasks for MADV_DONTUNMAP operation, clearing mlock() an=
d
+ * account flags on remaining VMA by convention (it cannot be mlock()'d =
any
+ * longer, as pages in range are no longer mapped), and removing anon_vm=
a_chain
+ * links from it (if the entire VMA was copied over).
+ */
+static void dontunmap_complete(struct vma_remap_struct *vrm,
+			       struct vm_area_struct *new_vma)
+{
+	unsigned long start =3D vrm->addr;
+	unsigned long end =3D vrm->addr + vrm->old_len;
+	unsigned long old_start =3D vrm->vma->vm_start;
+	unsigned long old_end =3D vrm->vma->vm_end;
+
+	/*
+	 * We always clear VM_LOCKED[ONFAULT] | VM_ACCOUNT on the old
+	 * vma.
+	 */
+	vm_flags_clear(vrm->vma, VM_LOCKED_MASK | VM_ACCOUNT);
+
+	/*
+	 * anon_vma links of the old vma is no longer needed after its page
+	 * table has been moved.
+	 */
+	if (new_vma !=3D vrm->vma && start =3D=3D old_start && end =3D=3D old_e=
nd)
+		unlink_anon_vmas(vrm->vma);
+
+	/* Because we won't unmap we don't need to touch locked_vm. */
+}
+
+static unsigned long move_vma(struct vma_remap_struct *vrm)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *new_vma;
+	unsigned long hiwater_vm;
+	int err;
+
+	err =3D prep_move_vma(vrm);
+	if (err)
+		return err;
+
+	/* If accounted, charge the number of bytes the operation will use. */
+	if (!vrm_charge(vrm))
+		return -ENOMEM;
+
+	/* We don't want racing faults. */
+	vma_start_write(vrm->vma);
+
+	/* Perform copy step. */
+	err =3D copy_vma_and_data(vrm, &new_vma);
+	/*
+	 * If we established the copied-to VMA, we attempt to recover from the
+	 * error by setting the destination VMA to the source VMA and unmapping
+	 * it below.
+	 */
+	if (err && !new_vma)
+		return err;
=20
 	/*
 	 * If we failed to move page tables we still do total_vm increment
@@ -1012,51 +1162,15 @@ static unsigned long move_vma(struct vma_remap_st=
ruct *vrm)
 	 */
 	hiwater_vm =3D mm->hiwater_vm;
=20
-	/* Tell pfnmap has moved from this vma */
-	if (unlikely(vma->vm_flags & VM_PFNMAP))
-		untrack_pfn_clear(vma);
-
-	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP))) {
-		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
-		vm_flags_clear(vma, VM_LOCKED_MASK);
-
-		/*
-		 * anon_vma links of the old vma is no longer needed after its page
-		 * table has been moved.
-		 */
-		if (new_vma !=3D vma && vma->vm_start =3D=3D old_addr &&
-			vma->vm_end =3D=3D (old_addr + old_len))
-			unlink_anon_vmas(vma);
-
-		/* Because we won't unmap we don't need to touch locked_vm */
-		vrm_stat_account(vrm, new_len);
-		return new_addr;
-	}
-
-	vrm_stat_account(vrm, new_len);
-
-	vma_iter_init(&vmi, mm, old_addr);
-	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, vrm->uf_unmap, false) < =
0) {
-		/* OOM: unable to split vma, just get accounts right */
-		if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP))
-			vm_acct_memory(old_len >> PAGE_SHIFT);
-		account_start =3D account_end =3D false;
-	}
+	vrm_stat_account(vrm, vrm->new_len);
+	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP)))
+		dontunmap_complete(vrm, new_vma);
+	else
+		unmap_source_vma(vrm);
=20
 	mm->hiwater_vm =3D hiwater_vm;
=20
-	/* Restore VM_ACCOUNT if one or two pieces of vma left */
-	if (account_start) {
-		vma =3D vma_prev(&vmi);
-		vm_flags_set(vma, VM_ACCOUNT);
-	}
-
-	if (account_end) {
-		vma =3D vma_next(&vmi);
-		vm_flags_set(vma, VM_ACCOUNT);
-	}
-
-	return new_addr;
+	return err ? (unsigned long)err : vrm->new_addr;
 }
=20
 /*
--=20
2.48.1



