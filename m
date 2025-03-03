Return-Path: <linux-kernel+bounces-545319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34247A4ECA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307788A72EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92125F979;
	Tue,  4 Mar 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iH2QS1iO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O2JncHgF"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF242E3397
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112105; cv=fail; b=CUJLsaymNEPIF2uzB1r6WEJdVDTshPYHHGXPbSeNwMnSuF/ZLuwNVYQYkgIXmU64yWUb+KPcZftOOD3VwO6yU60a4p6MMr/h22zCaspwbogttVTnSPcmvLLf5npJMuHTsI2Syio9ra5bXCFhUDu6aS+w2jSKbIb5+KDrqo1N4lY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112105; c=relaxed/simple;
	bh=hoF5QbcIShWrWBRDginqSaSCd5yVxy7h1FUF4T8l034=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/fVbgqhdQ3Fu6IKJSJgUmoisDOgu+tAnQ2vnSAzCVybfntXgp1ER0aHGxBHdTJXs2mX5SLcw0AhPRnJY8vi36hMH+ksO/dIc4Bg0MkvuUtF6Uon9pr6EFU2InYdhqC7cRVAS4atM3GNXFwJ+Shr4PiM67bHlcSn6tbd4oVbZQU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=oracle.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iH2QS1iO reason="signature verification failed"; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O2JncHgF reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 8AA4440D1F58
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:15:01 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=iH2QS1iO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=O2JncHgF
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gdP0skqzG21L
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:10:33 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 945D84272B; Tue,  4 Mar 2025 19:10:27 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iH2QS1iO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O2JncHgF
X-Envelope-From: <linux-kernel+bounces-541523-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iH2QS1iO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O2JncHgF
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id B8BD842DE4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:19:38 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 1EBF5305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:19:37 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102443B49AD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D371FBEB3;
	Mon,  3 Mar 2025 11:09:31 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36B1FBC86
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000163; cv=fail; b=YU7DJQjYZ5lc7geBEfHUDlOwiYkNJbhrSd6VLZz/kt2C3GmafYDYPmXXLO7xlUM2D0mDrb7PlFmbqVMZJ8i4djTpYjVDTcY+GlkUD/0P+yBwxPTUtLJD9qtHdTmnpcGiOC/z7+Ju7HRQophDU4071oAkvrYR1cA/DNh1S+61n7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000163; c=relaxed/simple;
	bh=+PqdysjGaqsMs/RyOvwIbDftdHU6O66mV/5tp1gOW3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7G6+L8W2tkFPKIqCEZSk0+jEFivgBJW84tWUvqZjz2Xt7x8rm7AuVzGN6JreJjF46DgIokh7FYzglQzwM2LYN1v8oEVunqSkFQ37EEXYiYUn6qbf64EYZtFASD0663qq53iIQiDVgaavV9uNgqYpcZCsY3euwG75LomqLh+n74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iH2QS1iO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O2JncHgF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tfkr030074;
	Mon, 3 Mar 2025 11:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UFeyc5hv/+DZiP4eqFY8b2qd+q4XOCr8h7SaLZMjDX8=; b=
	iH2QS1iOBGl4WfxExuk3108/k10SvuBjzkzmG9CCcTQ5WOBUPz1hYQ4ENO7koGCu
	AjtuhLay7+TRFrcVcf/FGSckszvslEjaUPFJo9Rv1ANsdk50pDqf9XrDpWYn9Ify
	JE4zbLZhGNqNksQJWGyuoVpszZeiu6i/ELCypeGHQA4IS5D+phno3wtD7fbuD1oS
	cbRF5hOWDQhrJOEH+3zQeQfZYUp7AdnlQqV00d/oshiHSBmXGxQUXHgHp4W1g1Z4
	QzqcvLkLS/L9NxL3i0VYObAfkthsr1ZRB/7OZH4BJIxTihwM295Lr0A1PLzLHe61
	Y8UrLuX+yTwgxN7zxTsDWQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86jdd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:09:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5239EudP003158;
	Mon, 3 Mar 2025 11:09:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7bfxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdjP82/V1IJTywZm6Sr3Hz1LeUYFD5Il4MvZbJj+9z+Z1MIjEdyH2bz9J9v1tlh+LHcHHksyhYrqB/ltd50+xrWvMOXN5l6DJdr9wlFJOk/sN1rEa7bH5gtqvix1+g1Q1kptfihk0JLdqDw7V7ufayJgSGRg/oVMJ8UICii32lEzXu1FXTXBcWMRh1lfpmAW2AhEdg8k4XLYo7pdUaTQv9Zu/d4hYTXtWWbO6sTt2a95NgGVNLGWuuuw2oN6L5G4j1jtuUzeiDIJJpUOfVT64Rpd48B9YkbSwZECw+puW2c+qCpQRgLVM1+VZuvrTQT2hs9W5Mwv1sTk7ZatbC5qnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFeyc5hv/+DZiP4eqFY8b2qd+q4XOCr8h7SaLZMjDX8=;
 b=bhAQy7ll4PjgooIRMWJbJwYbl/UBXpiZgNu899oarz/hY6pJ6gyT36B5/ey9NZ9Ag+ka+0Pga+T0ULJvo4a2AI+IoF2DOr1Hc31RMqwkKDHyClzb9N5cAmReVyIG7KBdMcEqFcPFyiKj0txqIrQ4DHPCEhrfe1VtaQRb7asTXTowe+flKrg09MzRVnQ+if9KSi1QvHkHtlxOukJ7oOLimSX7pnIUbP20emrQ5SyuE278AEk3lj2pIyvWdnP0L/jQmHvem22cDIipJTp8SnX2eUHtFxlziFaZqmxHoYOpNxYKFR0VIHVKVZINFBJ5UwOJ48h/ili+4DjbTZ6zQoisQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFeyc5hv/+DZiP4eqFY8b2qd+q4XOCr8h7SaLZMjDX8=;
 b=O2JncHgFPwzmYrnWrcHGkNWIU0dkKQBGUOXodBJLXXHXDLMwpYdEs/9OM1+ySGv7Tm+7vTRnZPfOKpUD1tl8vJ84C0Lv4+Xkljqr1ddN5ts8LXhjTOMG+WFmULwJ/J0VkXn/DS4nPSHq5RSRKO/ZIeeR63QW6ZXdC7lKihLQ6MM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 11:09:02 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:09:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mm/mremap: thread state through move page table operation
Date: Mon,  3 Mar 2025 11:08:37 +0000
Message-ID: <4cc18ebfc0cb32e9e42d86503cef3265108343e4.1740911247.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::14) To MN2PR10MB4112.namprd10.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8700b456-d818-4d55-6f43-08dd5a43cde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0zj+xJvfYIryvjuVkbe0uhNLWWbYCIOBuNemyh/OleEvtm32OObzwzFlNScE?=
 =?us-ascii?Q?X8nvwfzBnTMW7fD69KLKfTDiSQ9OmT+Yv/cxu26o87ZSB5hLmWzq3us8Bkxp?=
 =?us-ascii?Q?c4HnO+yFCBWMIbUR87Hq2KPYcdVgqRAqOJe3pE6Qx71Ep6oAJErJ7kKtjq5B?=
 =?us-ascii?Q?VC4NIH69+Uu3gB/QYX/qHh5MF3zQxOFvliWt23Roq9mMh81idtfmcVWL8CQ2?=
 =?us-ascii?Q?rK4C+aanHKyMbQzP1H1/vQbzV9NcepHl5jYMM2W04P1AxLgMs+wOFP/BN0Bm?=
 =?us-ascii?Q?XgTpdIIcLNGwQfK+tPsCZ+BrmMrkM9fzIQh0nkwPOxXZizJApPC5y0DPw4ag?=
 =?us-ascii?Q?l8KFABh01h6oBDJzQupRuOsSZ6qRE9qnG/fRDILjF2/w3AQNh0NbXC8nyAzK?=
 =?us-ascii?Q?kmwDtFvM5qx/6m71Z0F8TLhXEzLKH2sGcDtFNsRpo0Lm7Uq9PYVwCjR4YWpG?=
 =?us-ascii?Q?Nq6CP989Q7iusNOPUjn20ITLpK9QaEkDZSGe1ohzkBUCb+XCSvbKarS336NV?=
 =?us-ascii?Q?gV0VgtU+5NEs3jZReIdYS4RSjdSDZ/TbNBqlqj50p6PBwsMZOD7oum214g8w?=
 =?us-ascii?Q?cNmhEJc0NeBkyZmLYTzJjlwoHnEarpfUekzQklE2U4o2bHBVI29H+J5yYhRe?=
 =?us-ascii?Q?FuyxmLY67D0X7EGjVhfT87NJrmB8Qzo6cxLdX8ASHzuI3JABaQ0C2v6fVpzX?=
 =?us-ascii?Q?ES2lR3xr3TKcmz02ZkGx4J33ArwKhvYaJCNSee20mMiaEpm+5UX8D6fZajVp?=
 =?us-ascii?Q?0/IcsDqd1jcRi0wROjPpDynMyIYE71Lji6GImkDQPrcr9a3o18MikSfcvQjh?=
 =?us-ascii?Q?O8FBgRQhRj8h5qVGyVbTC7lcJglsqZwoRW2IHIT5DK6ST8s+y3/hY6amVPhg?=
 =?us-ascii?Q?G1kLGLrxahRGRPiCw9Vz5AuWAgik/PRbQSzQom50hrhGauMPgtNgvdP/oQ44?=
 =?us-ascii?Q?GcMb889bBdCr/Fypbm9+Fnmhv4NQ083fQ+WlhdwqjUCS2eXo/ab9AcSEXOmc?=
 =?us-ascii?Q?1fdhT0H0fuArpXJ5ieYwtEKfO9vqHYJRVgAzJJd2N1ZoGTXFNLlC35nqtvqX?=
 =?us-ascii?Q?SAsgw82pMpJN5y2kGne/9MW9Yd4EKLOjGdtJxikDpx4Le0Lst+ETLRvLnnR9?=
 =?us-ascii?Q?TK1cvlZCnRJrP1OswTd9zzD5aVz8mkxyvbszkPSaBvC1tElFKSI6u76QX8t3?=
 =?us-ascii?Q?jXM8nzMqxN3na1ly6bJT0971cInNAD/P3ekeariWDexcD2SqxERJR1Mo0prg?=
 =?us-ascii?Q?37ilkuMQbyB5q0RVC9fJCkGirltodct1Juc2kWL3yBMTsgX1iKcsj2czFMGE?=
 =?us-ascii?Q?ZX3dyuPyufYqjMU68lvXg6U3BxXx2ZwWFzEq1XiYvK8+JJDen9nRJFeZwfsi?=
 =?us-ascii?Q?a4KFGho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wPxyi+XJ7sxtjdgIUwPRB0Q7AYvNphPzrTiEz23IEZgLR5ie/I07wBHqwUwe?=
 =?us-ascii?Q?QP2G25GfWrUpDa4HAO2DaiCIOrM1xBt8vGuIvLB+pjfNwXLvwxHpNpRq2Y8q?=
 =?us-ascii?Q?OM63l6cV8CLFD4K26zLWwSlV0HUiLo8M75DPhmeMFBb6/OQuaVHFf5oW17Xy?=
 =?us-ascii?Q?neIlbTWR3Z9KpONO3ou2ZaaWp5ikQxWzGNgvKYl8g4rqmzRGHqTh9lFne8AE?=
 =?us-ascii?Q?i/Q+748x3dUngi1FpYp/Isbcvx1WZuBOruBaqJlV1RZcWdMihVnWNH40c4hP?=
 =?us-ascii?Q?UUHMYRROg8hyLXOQjJQMSQEJuTfHHGtNTVnMh1a3eR5LookgJUpdL7JHUQHI?=
 =?us-ascii?Q?YKXhwgTpF/IDclrW3rzB/Aq/A+bz/xwoRnQOWV/xpEM6e41YuYlFbQ0Qj0KR?=
 =?us-ascii?Q?IT0/NTw/HX3SQfjFrNyxIgTP6e+iaYXGzFqlo+csYK0sNv20IYbM8B53+82P?=
 =?us-ascii?Q?TjU1/Wf3gYgIeu2h8EaaicL31JnEM2vTZmxmoXg0J4hpkMTFqTlRNLXwwUX1?=
 =?us-ascii?Q?w6+YcsZaP9t5ROUChcpOOnfaqssT487zbXTTyNarl5vQy7bcM1bliv+A+1cb?=
 =?us-ascii?Q?T3Zu1mdv4JyFgy5E+jwG1b5MP2RjIUWjfG841Nu13ojhR04IcfxzF1oCpU7U?=
 =?us-ascii?Q?NMncsGTb54FMq66RCHhyfPSbVPGdwF6Vbbr/EWss6Rh02Q4d6t0SXnl/ji6/?=
 =?us-ascii?Q?Vu5tdWe2u6BCSig9myuhz6DquW2HOwDBZ5XbbFkuY7JUb2f/PuRIJsS4Ey2N?=
 =?us-ascii?Q?WZ0RlO6Fkw9Lt8ZOIcAeogqmb3Y+fTBg+DxbYdXA7UxxR9IbkMsT9fAZW/y0?=
 =?us-ascii?Q?fPESbUjnZN2BLe9IQbWphGNUb0dnVMkR0pcXR0dT49d31X5SzXNsORAhXwj2?=
 =?us-ascii?Q?CIUTKIAk7RowXPwuQdBJDKk2V2UI2DtcLUY+U73R3pGjPWZNsYrRx8+HiLSB?=
 =?us-ascii?Q?8x4u7fupycAd47Xk7QG4tCo1uhcRq429aRE/Scc4WGEIQWUF1FrQCGcKQu4E?=
 =?us-ascii?Q?TYSyMNx/GXFG/dp24W0AK65obHRidFBjrQrLduELv+Wv0QrATVLJo0wEPKfW?=
 =?us-ascii?Q?20Iw4ax41NCqi86SYdKQfhaBQDcwjEXNcxNOSfHC8CuP3q00gePfsrEe6LQK?=
 =?us-ascii?Q?ZDlHR8cLp0CRqLV8dP1lSkWEwjEMCsVzovpYZQb3KksrmqgryrTHYO8ubKyA?=
 =?us-ascii?Q?kC32YWwxw/IjcB+BdO+mlIZEeTy86EzZqTjmskqXrwQpkpeXVyXnVmKm7lQy?=
 =?us-ascii?Q?SBQPgcGL7FSjXgqZ6ON1L9dpuf2emMNiAaLxaDM0pyKXGxkJ0hT3Mjtt24+w?=
 =?us-ascii?Q?UGE+no1/DQESgtRGsl57T1ScASfXaWGntPNVArMCg+9LzfzwBDiH+PZEoNpm?=
 =?us-ascii?Q?dez5OHGLOsI4l1XnDNYG8kAy1jMiGaKmucS8iOyVdA6aKzkklzNFfLGUohpG?=
 =?us-ascii?Q?JX3pd3AgZIMk3T4e4AQvDzr5wu7Q5/G8VgGmVeeKVi/KPXC++vESJbmdYFDX?=
 =?us-ascii?Q?x1pgyo0+UKETuHC2onDauw/2ChGKKI8fcGSUQpkTzWUgPuq9hgJHcgp966Wh?=
 =?us-ascii?Q?ICTobfXtR+SBALPlVD+AIcNmiELP5DBmtCapp5/IgZCo+XURwL3K/HDmvzp/?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U82lH12dy3eznMg7/Q/rf5tNIbtwhMS+EAeok8o0LxtydrpImDqppsMghwjpwIbZKbnEUQecIdbcGVF+cetr7tQRTYdItQCf0QR3ZmjB0/KcG/KM73zqLOt1BGFVKhKKqP8+kCU3JaN1hwiFmifpDRZFRjs1+iwDwyGZBTqNL7ZU3+jWE6dP5CB1wFq+u1EmdgrRWD1SFE5glHEuXViLTZ9jkcqOOEWStBaPliMaxXW6v8RsbOHk72z6RaH0jyPG3H7/NZuG8HmIIJ6xesvWGP/pn8JNL8A+eT/5hWd7banLQsXytLSCQcgrIQeYMMPeQros9peXPBsH9D5F5T0miolyYna0GPrZkfkfm+c0PsFKe+3fR3k5zxMtO6KJUeZIuVWT66mGNxx1BbbNdB9Kd4fgJm9sBlJ9fLWh7zTwqNSKemvlw8gSGRYTCh7x7uppFxUPY6qMs/Pm1tj7yWepIRssnz3R3OTvjcYBhG82t7o338VcwvHXizvkWtT+Wo6Ptia1FClE2J6h7j2uaXOKv3l5bPGLn9MiRMwDUb9Bxns9cdkGY9CfvR5yagnZJDSnSpMkEi/2U0gsDfymcKKyAnp5Q2aGuc8aSGfM7ozrioQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8700b456-d818-4d55-6f43-08dd5a43cde9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:09:02.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16YwVYvP19DhC+dg28E2ocjsWv2htTfet55kEJn6mpmDacTE4e59pgoCKJYkAr+Ew5sCOKus5CinOGOlLv/7Kz/N9guDh9tJons3lH8T6+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030086
X-Proofpoint-ORIG-GUID: TMNM7E2cya8tb_S3HByPFNBcnCbtfU0e
X-Proofpoint-GUID: TMNM7E2cya8tb_S3HByPFNBcnCbtfU0e
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gdP0skqzG21L
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716775.7494@ho9SEqKP+e4Gi/i3OOT7WA
X-ITU-MailScanner-SpamCheck: not spam

Finish refactoring the page table logic by threading the PMC state
throughout the operation, allowing us to control the operation as we go.

Additionally, update the old_addr, new_addr fields in move_page_tables() =
as
we progress through the process making use of the fact we have this state
object now to track this.

With these changes made, not only is the code far more readable, but we c=
an
finally transmit state throughout the entire operation, which lays the
groundwork for sensibly making changes in future to how the mremap()
operation is performed.

Additionally take the opportunity to refactor the means of determining th=
e
progress of the operation, abstracting this to pmc_progress() and
simplifying the logic to make it clearer what's going on.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |   3 +
 mm/mremap.c   | 196 +++++++++++++++++++++++++++++---------------------
 2 files changed, 117 insertions(+), 82 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5d9894e5adfc..fdd3eeca9968 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -39,6 +39,9 @@ struct folio_batch;
  *
  * Use the PAGETABLE_MOVE() macro to initialise this struct.
  *
+ * The old_addr and new_addr fields are updated as the page table move i=
s
+ * executed.
+ *
  * NOTE: The page table move is affected by reading from [old_addr, old_=
end),
  * and old_addr may be updated for better page table alignment, so len_i=
n
  * represents the length of the range being copied as specified by the u=
ser.
diff --git a/mm/mremap.c b/mm/mremap.c
index fdbe35de5e5a..4b1647d32fb0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -107,8 +107,7 @@ static pmd_t *get_old_pmd(struct mm_struct *mm, unsig=
ned long addr)
 	return pmd;
 }
=20
-static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct =
*vma,
-			    unsigned long addr)
+static pud_t *alloc_new_pud(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -121,13 +120,12 @@ static pud_t *alloc_new_pud(struct mm_struct *mm, s=
truct vm_area_struct *vma,
 	return pud_alloc(mm, p4d, addr);
 }
=20
-static pmd_t *alloc_new_pmd(struct mm_struct *mm, struct vm_area_struct =
*vma,
-			    unsigned long addr)
+static pmd_t *alloc_new_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	pud_t *pud;
 	pmd_t *pmd;
=20
-	pud =3D alloc_new_pud(mm, vma, addr);
+	pud =3D alloc_new_pud(mm, addr);
 	if (!pud)
 		return NULL;
=20
@@ -171,17 +169,19 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 	return pte;
 }
=20
-static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
-		unsigned long old_addr, unsigned long old_end,
-		struct vm_area_struct *new_vma, pmd_t *new_pmd,
-		unsigned long new_addr, bool need_rmap_locks)
+static int move_ptes(struct pagetable_move_control *pmc,
+		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
 {
+	struct vm_area_struct *vma =3D pmc->old;
 	bool need_clear_uffd_wp =3D vma_has_uffd_without_event_remap(vma);
 	struct mm_struct *mm =3D vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	pmd_t dummy_pmdval;
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush =3D false;
+	unsigned long old_addr =3D pmc->old_addr;
+	unsigned long new_addr =3D pmc->new_addr;
+	unsigned long old_end =3D old_addr + extent;
 	unsigned long len =3D old_end - old_addr;
 	int err =3D 0;
=20
@@ -203,7 +203,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_=
t *old_pmd,
 	 *   serialize access to individual ptes, but only rmap traversal
 	 *   order guarantees that we won't miss both the old and new ptes).
 	 */
-	if (need_rmap_locks)
+	if (pmc->need_rmap_locks)
 		take_rmap_locks(vma);
=20
 	/*
@@ -277,7 +277,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_=
t *old_pmd,
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
 out:
-	if (need_rmap_locks)
+	if (pmc->need_rmap_locks)
 		drop_rmap_locks(vma);
 	return err;
 }
@@ -292,10 +292,11 @@ static inline bool arch_supports_page_table_move(vo=
id)
 #endif
=20
 #ifdef CONFIG_HAVE_MOVE_PMD
-static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long ol=
d_addr,
-		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
+static bool move_normal_pmd(struct pagetable_move_control *pmc,
+			pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma =3D pmc->old;
 	struct mm_struct *mm =3D vma->vm_mm;
 	bool res =3D false;
 	pmd_t pmd;
@@ -341,7 +342,7 @@ static bool move_normal_pmd(struct vm_area_struct *vm=
a, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl =3D pmd_lock(vma->vm_mm, old_pmd);
+	old_ptl =3D pmd_lock(mm, old_pmd);
 	new_ptl =3D pmd_lockptr(mm, new_pmd);
 	if (new_ptl !=3D old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -358,7 +359,7 @@ static bool move_normal_pmd(struct vm_area_struct *vm=
a, unsigned long old_addr,
 	VM_BUG_ON(!pmd_none(*new_pmd));
=20
 	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
-	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PMD_SIZE);
 out_unlock:
 	if (new_ptl !=3D old_ptl)
 		spin_unlock(new_ptl);
@@ -367,19 +368,19 @@ static bool move_normal_pmd(struct vm_area_struct *=
vma, unsigned long old_addr,
 	return res;
 }
 #else
-static inline bool move_normal_pmd(struct vm_area_struct *vma,
-		unsigned long old_addr, unsigned long new_addr, pmd_t *old_pmd,
-		pmd_t *new_pmd)
+static inline bool move_normal_pmd(struct pagetable_move_control *pmc,
+		pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	return false;
 }
 #endif
=20
 #if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_HAVE_MOVE_PUD)
-static bool move_normal_pud(struct vm_area_struct *vma, unsigned long ol=
d_addr,
-		  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_normal_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma =3D pmc->old;
 	struct mm_struct *mm =3D vma->vm_mm;
 	pud_t pud;
=20
@@ -405,7 +406,7 @@ static bool move_normal_pud(struct vm_area_struct *vm=
a, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl =3D pud_lock(vma->vm_mm, old_pud);
+	old_ptl =3D pud_lock(mm, old_pud);
 	new_ptl =3D pud_lockptr(mm, new_pud);
 	if (new_ptl !=3D old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -417,7 +418,7 @@ static bool move_normal_pud(struct vm_area_struct *vm=
a, unsigned long old_addr,
 	VM_BUG_ON(!pud_none(*new_pud));
=20
 	pud_populate(mm, new_pud, pud_pgtable(pud));
-	flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
+	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PUD_SIZE);
 	if (new_ptl !=3D old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -425,19 +426,19 @@ static bool move_normal_pud(struct vm_area_struct *=
vma, unsigned long old_addr,
 	return true;
 }
 #else
-static inline bool move_normal_pud(struct vm_area_struct *vma,
-		unsigned long old_addr, unsigned long new_addr, pud_t *old_pud,
-		pud_t *new_pud)
+static inline bool move_normal_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	return false;
 }
 #endif
=20
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_HAVE_ARCH_TRA=
NSPARENT_HUGEPAGE_PUD)
-static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_=
addr,
-			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_huge_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma =3D pmc->old;
 	struct mm_struct *mm =3D vma->vm_mm;
 	pud_t pud;
=20
@@ -452,7 +453,7 @@ static bool move_huge_pud(struct vm_area_struct *vma,=
 unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl =3D pud_lock(vma->vm_mm, old_pud);
+	old_ptl =3D pud_lock(mm, old_pud);
 	new_ptl =3D pud_lockptr(mm, new_pud);
 	if (new_ptl !=3D old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -465,8 +466,8 @@ static bool move_huge_pud(struct vm_area_struct *vma,=
 unsigned long old_addr,
=20
 	/* Set the new pud */
 	/* mark soft_ditry when we add pud level soft dirty support */
-	set_pud_at(mm, new_addr, new_pud, pud);
-	flush_pud_tlb_range(vma, old_addr, old_addr + HPAGE_PUD_SIZE);
+	set_pud_at(mm, pmc->new_addr, new_pud, pud);
+	flush_pud_tlb_range(vma, pmc->old_addr, pmc->old_addr + HPAGE_PUD_SIZE)=
;
 	if (new_ptl !=3D old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -496,10 +497,12 @@ enum pgt_entry {
  * destination pgt_entry.
  */
 static __always_inline unsigned long get_extent(enum pgt_entry entry,
-			unsigned long old_addr, unsigned long old_end,
-			unsigned long new_addr)
+						struct pagetable_move_control *pmc)
 {
 	unsigned long next, extent, mask, size;
+	unsigned long old_addr =3D pmc->old_addr;
+	unsigned long old_end =3D pmc->old_end;
+	unsigned long new_addr =3D pmc->new_addr;
=20
 	switch (entry) {
 	case HPAGE_PMD:
@@ -528,38 +531,54 @@ static __always_inline unsigned long get_extent(enu=
m pgt_entry entry,
 	return extent;
 }
=20
+/*
+ * Should move_pgt_entry() acquire the rmap locks? This is either expres=
sed in
+ * the PMC, or overridden in the case of normal, larger page tables.
+ */
+static bool should_take_rmap_locks(struct pagetable_move_control *pmc,
+				   enum pgt_entry entry)
+{
+	if (pmc->need_rmap_locks)
+		return true;
+
+	switch (entry) {
+	case NORMAL_PMD:
+	case NORMAL_PUD:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Attempts to speedup the move by moving entry at the level correspondi=
ng to
  * pgt_entry. Returns true if the move was successful, else false.
  */
-static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *=
vma,
-			unsigned long old_addr, unsigned long new_addr,
-			void *old_entry, void *new_entry, bool need_rmap_locks)
+static bool move_pgt_entry(struct pagetable_move_control *pmc,
+			   enum pgt_entry entry, void *old_entry, void *new_entry)
 {
 	bool moved =3D false;
+	bool need_rmap_locks =3D should_take_rmap_locks(pmc, entry);
=20
 	/* See comment in move_ptes() */
 	if (need_rmap_locks)
-		take_rmap_locks(vma);
+		take_rmap_locks(pmc->old);
=20
 	switch (entry) {
 	case NORMAL_PMD:
-		moved =3D move_normal_pmd(vma, old_addr, new_addr, old_entry,
-					new_entry);
+		moved =3D move_normal_pmd(pmc, old_entry, new_entry);
 		break;
 	case NORMAL_PUD:
-		moved =3D move_normal_pud(vma, old_addr, new_addr, old_entry,
-					new_entry);
+		moved =3D move_normal_pud(pmc, old_entry, new_entry);
 		break;
 	case HPAGE_PMD:
 		moved =3D IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			move_huge_pmd(vma, old_addr, new_addr, old_entry,
+			move_huge_pmd(pmc->old, pmc->old_addr, pmc->new_addr, old_entry,
 				      new_entry);
 		break;
 	case HPAGE_PUD:
 		moved =3D IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			move_huge_pud(vma, old_addr, new_addr, old_entry,
-				      new_entry);
+			move_huge_pud(pmc, old_entry, new_entry);
 		break;
=20
 	default:
@@ -568,7 +587,7 @@ static bool move_pgt_entry(enum pgt_entry entry, stru=
ct vm_area_struct *vma,
 	}
=20
 	if (need_rmap_locks)
-		drop_rmap_locks(vma);
+		drop_rmap_locks(pmc->old);
=20
 	return moved;
 }
@@ -704,19 +723,48 @@ static void try_realign_addr(struct pagetable_move_=
control *pmc,
 	pmc->new_addr &=3D pagetable_mask;
 }
=20
+/* Is the page table move operation done? */
+static bool pmc_done(struct pagetable_move_control *pmc)
+{
+	return pmc->old_addr >=3D pmc->old_end;
+}
+
+/* Advance to the next page table, offset by extent bytes. */
+static void pmc_next(struct pagetable_move_control *pmc, unsigned long e=
xtent)
+{
+	pmc->old_addr +=3D extent;
+	pmc->new_addr +=3D extent;
+}
+
+/*
+ * Determine how many bytes in the specified input range have had their =
page
+ * tables moved so far.
+ */
+static unsigned long pmc_progress(struct pagetable_move_control *pmc)
+{
+	unsigned long orig_old_addr =3D pmc->old_end - pmc->len_in;
+	unsigned long old_addr =3D pmc->old_addr;
+
+	/*
+	 * Prevent negative return values when {old,new}_addr was realigned but
+	 * we broke out of the loop in move_page_tables() for the first PMD
+	 * itself.
+	 */
+	return old_addr < orig_old_addr ? 0 : old_addr - orig_old_addr;
+}
+
 unsigned long move_page_tables(struct pagetable_move_control *pmc)
 {
-	unsigned long extent, old_end;
+	unsigned long extent;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
 	pud_t *old_pud, *new_pud;
-	unsigned long old_addr, new_addr;
-	struct vm_area_struct *vma =3D pmc->old;
+	struct mm_struct *mm =3D pmc->old->vm_mm;
=20
 	if (!pmc->len_in)
 		return 0;
=20
-	if (is_vm_hugetlb_page(vma))
+	if (is_vm_hugetlb_page(pmc->old))
 		return move_hugetlb_page_tables(pmc->old, pmc->new, pmc->old_addr,
 						pmc->new_addr, pmc->len_in);
=20
@@ -725,87 +773,71 @@ unsigned long move_page_tables(struct pagetable_mov=
e_control *pmc)
 	 * Only realign if the mremap copying hits a PMD boundary.
 	 */
 	try_realign_addr(pmc, PMD_MASK);
-	/* These may have been changed. */
-	old_addr =3D pmc->old_addr;
-	new_addr =3D pmc->new_addr;
-	old_end =3D pmc->old_end;
-
-	flush_cache_range(vma, old_addr, old_end);
-	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
-				old_addr, old_end);
+
+	flush_cache_range(pmc->old, pmc->old_addr, pmc->old_end);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, mm,
+				pmc->old_addr, pmc->old_end);
 	mmu_notifier_invalidate_range_start(&range);
=20
-	for (; old_addr < old_end; old_addr +=3D extent, new_addr +=3D extent) =
{
+	for (; !pmc_done(pmc); pmc_next(pmc, extent)) {
 		cond_resched();
 		/*
 		 * If extent is PUD-sized try to speed up the move by moving at the
 		 * PUD level if possible.
 		 */
-		extent =3D get_extent(NORMAL_PUD, old_addr, old_end, new_addr);
+		extent =3D get_extent(NORMAL_PUD, pmc);
=20
-		old_pud =3D get_old_pud(vma->vm_mm, old_addr);
+		old_pud =3D get_old_pud(mm, pmc->old_addr);
 		if (!old_pud)
 			continue;
-		new_pud =3D alloc_new_pud(vma->vm_mm, vma, new_addr);
+		new_pud =3D alloc_new_pud(mm, pmc->new_addr);
 		if (!new_pud)
 			break;
 		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
 			if (extent =3D=3D HPAGE_PUD_SIZE) {
-				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
-					       old_pud, new_pud, pmc->need_rmap_locks);
+				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
 				/* We ignore and continue on error? */
 				continue;
 			}
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent =3D=3D PUD_SIZE)=
 {
-			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
-					   old_pud, new_pud, true))
+			if (move_pgt_entry(pmc, NORMAL_PUD, old_pud, new_pud))
 				continue;
 		}
=20
-		extent =3D get_extent(NORMAL_PMD, old_addr, old_end, new_addr);
-		old_pmd =3D get_old_pmd(vma->vm_mm, old_addr);
+		extent =3D get_extent(NORMAL_PMD, pmc);
+		old_pmd =3D get_old_pmd(mm, pmc->old_addr);
 		if (!old_pmd)
 			continue;
-		new_pmd =3D alloc_new_pmd(vma->vm_mm, vma, new_addr);
+		new_pmd =3D alloc_new_pmd(mm, pmc->new_addr);
 		if (!new_pmd)
 			break;
 again:
 		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
 		    pmd_devmap(*old_pmd)) {
 			if (extent =3D=3D HPAGE_PMD_SIZE &&
-			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, pmc->need_rmap_locks))
+			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
-			split_huge_pmd(vma, old_pmd, old_addr);
+			split_huge_pmd(pmc->old, old_pmd, pmc->old_addr);
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
 			   extent =3D=3D PMD_SIZE) {
 			/*
 			 * If the extent is PMD-sized, try to speed the move by
 			 * moving at the PMD level if possible.
 			 */
-			if (move_pgt_entry(NORMAL_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, true))
+			if (move_pgt_entry(pmc, NORMAL_PMD, old_pmd, new_pmd))
 				continue;
 		}
 		if (pmd_none(*old_pmd))
 			continue;
 		if (pte_alloc(pmc->new->vm_mm, new_pmd))
 			break;
-		if (move_ptes(vma, old_pmd, old_addr, old_addr + extent,
-			      pmc->new, new_pmd, new_addr, pmc->need_rmap_locks) < 0)
+		if (move_ptes(pmc, extent, old_pmd, new_pmd) < 0)
 			goto again;
 	}
=20
 	mmu_notifier_invalidate_range_end(&range);
=20
-	/*
-	 * Prevent negative return values when {old,new}_addr was realigned
-	 * but we broke out of the above loop for the first PMD itself.
-	 */
-	if (old_addr < old_end - pmc->len_in)
-		return 0;
-
-	return pmc->len_in + old_addr - old_end;	/* how much done */
+	return pmc_progress(pmc);
 }
=20
 /* Set vrm->delta to the difference in VMA size specified by user. */
--=20
2.48.1



