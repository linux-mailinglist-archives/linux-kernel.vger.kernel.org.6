Return-Path: <linux-kernel+bounces-541523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C5A4BDD5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D97518981C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDA1FBCB7;
	Mon,  3 Mar 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iH2QS1iO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O2JncHgF"
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::14) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
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

Finish refactoring the page table logic by threading the PMC state
throughout the operation, allowing us to control the operation as we go.

Additionally, update the old_addr, new_addr fields in move_page_tables() as
we progress through the process making use of the fact we have this state
object now to track this.

With these changes made, not only is the code far more readable, but we can
finally transmit state throughout the entire operation, which lays the
groundwork for sensibly making changes in future to how the mremap()
operation is performed.

Additionally take the opportunity to refactor the means of determining the
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
+ * The old_addr and new_addr fields are updated as the page table move is
+ * executed.
+ *
  * NOTE: The page table move is affected by reading from [old_addr, old_end),
  * and old_addr may be updated for better page table alignment, so len_in
  * represents the length of the range being copied as specified by the user.
diff --git a/mm/mremap.c b/mm/mremap.c
index fdbe35de5e5a..4b1647d32fb0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -107,8 +107,7 @@ static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
 	return pmd;
 }
 
-static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct *vma,
-			    unsigned long addr)
+static pud_t *alloc_new_pud(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -121,13 +120,12 @@ static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct *vma,
 	return pud_alloc(mm, p4d, addr);
 }
 
-static pmd_t *alloc_new_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
-			    unsigned long addr)
+static pmd_t *alloc_new_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	pud_t *pud;
 	pmd_t *pmd;
 
-	pud = alloc_new_pud(mm, vma, addr);
+	pud = alloc_new_pud(mm, addr);
 	if (!pud)
 		return NULL;
 
@@ -171,17 +169,19 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 	return pte;
 }
 
-static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
-		unsigned long old_addr, unsigned long old_end,
-		struct vm_area_struct *new_vma, pmd_t *new_pmd,
-		unsigned long new_addr, bool need_rmap_locks)
+static int move_ptes(struct pagetable_move_control *pmc,
+		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
 {
+	struct vm_area_struct *vma = pmc->old;
 	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	pmd_t dummy_pmdval;
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long new_addr = pmc->new_addr;
+	unsigned long old_end = old_addr + extent;
 	unsigned long len = old_end - old_addr;
 	int err = 0;
 
@@ -203,7 +203,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	 *   serialize access to individual ptes, but only rmap traversal
 	 *   order guarantees that we won't miss both the old and new ptes).
 	 */
-	if (need_rmap_locks)
+	if (pmc->need_rmap_locks)
 		take_rmap_locks(vma);
 
 	/*
@@ -277,7 +277,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
 out:
-	if (need_rmap_locks)
+	if (pmc->need_rmap_locks)
 		drop_rmap_locks(vma);
 	return err;
 }
@@ -292,10 +292,11 @@ static inline bool arch_supports_page_table_move(void)
 #endif
 
 #ifdef CONFIG_HAVE_MOVE_PMD
-static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
-		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
+static bool move_normal_pmd(struct pagetable_move_control *pmc,
+			pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma = pmc->old;
 	struct mm_struct *mm = vma->vm_mm;
 	bool res = false;
 	pmd_t pmd;
@@ -341,7 +342,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
+	old_ptl = pmd_lock(mm, old_pmd);
 	new_ptl = pmd_lockptr(mm, new_pmd);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -358,7 +359,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pmd_none(*new_pmd));
 
 	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
-	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PMD_SIZE);
 out_unlock:
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
@@ -367,19 +368,19 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
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
 
 #if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_HAVE_MOVE_PUD)
-static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
-		  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_normal_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma = pmc->old;
 	struct mm_struct *mm = vma->vm_mm;
 	pud_t pud;
 
@@ -405,7 +406,7 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(vma->vm_mm, old_pud);
+	old_ptl = pud_lock(mm, old_pud);
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -417,7 +418,7 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pud_none(*new_pud));
 
 	pud_populate(mm, new_pud, pud_pgtable(pud));
-	flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
+	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PUD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -425,19 +426,19 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
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
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
-static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_huge_pud(struct pagetable_move_control *pmc,
+		pud_t *old_pud, pud_t *new_pud)
 {
 	spinlock_t *old_ptl, *new_ptl;
+	struct vm_area_struct *vma = pmc->old;
 	struct mm_struct *mm = vma->vm_mm;
 	pud_t pud;
 
@@ -452,7 +453,7 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(vma->vm_mm, old_pud);
+	old_ptl = pud_lock(mm, old_pud);
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -465,8 +466,8 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 
 	/* Set the new pud */
 	/* mark soft_ditry when we add pud level soft dirty support */
-	set_pud_at(mm, new_addr, new_pud, pud);
-	flush_pud_tlb_range(vma, old_addr, old_addr + HPAGE_PUD_SIZE);
+	set_pud_at(mm, pmc->new_addr, new_pud, pud);
+	flush_pud_tlb_range(vma, pmc->old_addr, pmc->old_addr + HPAGE_PUD_SIZE);
 	if (new_ptl != old_ptl)
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
+	unsigned long old_addr = pmc->old_addr;
+	unsigned long old_end = pmc->old_end;
+	unsigned long new_addr = pmc->new_addr;
 
 	switch (entry) {
 	case HPAGE_PMD:
@@ -528,38 +531,54 @@ static __always_inline unsigned long get_extent(enum pgt_entry entry,
 	return extent;
 }
 
+/*
+ * Should move_pgt_entry() acquire the rmap locks? This is either expressed in
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
  * Attempts to speedup the move by moving entry at the level corresponding to
  * pgt_entry. Returns true if the move was successful, else false.
  */
-static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
-			unsigned long old_addr, unsigned long new_addr,
-			void *old_entry, void *new_entry, bool need_rmap_locks)
+static bool move_pgt_entry(struct pagetable_move_control *pmc,
+			   enum pgt_entry entry, void *old_entry, void *new_entry)
 {
 	bool moved = false;
+	bool need_rmap_locks = should_take_rmap_locks(pmc, entry);
 
 	/* See comment in move_ptes() */
 	if (need_rmap_locks)
-		take_rmap_locks(vma);
+		take_rmap_locks(pmc->old);
 
 	switch (entry) {
 	case NORMAL_PMD:
-		moved = move_normal_pmd(vma, old_addr, new_addr, old_entry,
-					new_entry);
+		moved = move_normal_pmd(pmc, old_entry, new_entry);
 		break;
 	case NORMAL_PUD:
-		moved = move_normal_pud(vma, old_addr, new_addr, old_entry,
-					new_entry);
+		moved = move_normal_pud(pmc, old_entry, new_entry);
 		break;
 	case HPAGE_PMD:
 		moved = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			move_huge_pmd(vma, old_addr, new_addr, old_entry,
+			move_huge_pmd(pmc->old, pmc->old_addr, pmc->new_addr, old_entry,
 				      new_entry);
 		break;
 	case HPAGE_PUD:
 		moved = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			move_huge_pud(vma, old_addr, new_addr, old_entry,
-				      new_entry);
+			move_huge_pud(pmc, old_entry, new_entry);
 		break;
 
 	default:
@@ -568,7 +587,7 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 	}
 
 	if (need_rmap_locks)
-		drop_rmap_locks(vma);
+		drop_rmap_locks(pmc->old);
 
 	return moved;
 }
@@ -704,19 +723,48 @@ static void try_realign_addr(struct pagetable_move_control *pmc,
 	pmc->new_addr &= pagetable_mask;
 }
 
+/* Is the page table move operation done? */
+static bool pmc_done(struct pagetable_move_control *pmc)
+{
+	return pmc->old_addr >= pmc->old_end;
+}
+
+/* Advance to the next page table, offset by extent bytes. */
+static void pmc_next(struct pagetable_move_control *pmc, unsigned long extent)
+{
+	pmc->old_addr += extent;
+	pmc->new_addr += extent;
+}
+
+/*
+ * Determine how many bytes in the specified input range have had their page
+ * tables moved so far.
+ */
+static unsigned long pmc_progress(struct pagetable_move_control *pmc)
+{
+	unsigned long orig_old_addr = pmc->old_end - pmc->len_in;
+	unsigned long old_addr = pmc->old_addr;
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
-	struct vm_area_struct *vma = pmc->old;
+	struct mm_struct *mm = pmc->old->vm_mm;
 
 	if (!pmc->len_in)
 		return 0;
 
-	if (is_vm_hugetlb_page(vma))
+	if (is_vm_hugetlb_page(pmc->old))
 		return move_hugetlb_page_tables(pmc->old, pmc->new, pmc->old_addr,
 						pmc->new_addr, pmc->len_in);
 
@@ -725,87 +773,71 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 	 * Only realign if the mremap copying hits a PMD boundary.
 	 */
 	try_realign_addr(pmc, PMD_MASK);
-	/* These may have been changed. */
-	old_addr = pmc->old_addr;
-	new_addr = pmc->new_addr;
-	old_end = pmc->old_end;
-
-	flush_cache_range(vma, old_addr, old_end);
-	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
-				old_addr, old_end);
+
+	flush_cache_range(pmc->old, pmc->old_addr, pmc->old_end);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, mm,
+				pmc->old_addr, pmc->old_end);
 	mmu_notifier_invalidate_range_start(&range);
 
-	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
+	for (; !pmc_done(pmc); pmc_next(pmc, extent)) {
 		cond_resched();
 		/*
 		 * If extent is PUD-sized try to speed up the move by moving at the
 		 * PUD level if possible.
 		 */
-		extent = get_extent(NORMAL_PUD, old_addr, old_end, new_addr);
+		extent = get_extent(NORMAL_PUD, pmc);
 
-		old_pud = get_old_pud(vma->vm_mm, old_addr);
+		old_pud = get_old_pud(mm, pmc->old_addr);
 		if (!old_pud)
 			continue;
-		new_pud = alloc_new_pud(vma->vm_mm, vma, new_addr);
+		new_pud = alloc_new_pud(mm, pmc->new_addr);
 		if (!new_pud)
 			break;
 		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
-				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
-					       old_pud, new_pud, pmc->need_rmap_locks);
+				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
 				/* We ignore and continue on error? */
 				continue;
 			}
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
-			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
-					   old_pud, new_pud, true))
+			if (move_pgt_entry(pmc, NORMAL_PUD, old_pud, new_pud))
 				continue;
 		}
 
-		extent = get_extent(NORMAL_PMD, old_addr, old_end, new_addr);
-		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
+		extent = get_extent(NORMAL_PMD, pmc);
+		old_pmd = get_old_pmd(mm, pmc->old_addr);
 		if (!old_pmd)
 			continue;
-		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
+		new_pmd = alloc_new_pmd(mm, pmc->new_addr);
 		if (!new_pmd)
 			break;
 again:
 		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
 		    pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
-			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, pmc->need_rmap_locks))
+			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
-			split_huge_pmd(vma, old_pmd, old_addr);
+			split_huge_pmd(pmc->old, old_pmd, pmc->old_addr);
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
 			   extent == PMD_SIZE) {
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
 
 	mmu_notifier_invalidate_range_end(&range);
 
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
 
 /* Set vrm->delta to the difference in VMA size specified by user. */
-- 
2.48.1


