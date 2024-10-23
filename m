Return-Path: <linux-kernel+bounces-378809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3D9AD5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073DA1C226AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5EB1FEFD6;
	Wed, 23 Oct 2024 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KNSMlhMS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GFqBd5jp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645AF1FE101
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715973; cv=fail; b=KHwEZqOsKIlANSMULlu24nskPSCHQMjsyos+n2IeGwG4kcEbjNe1BfqP2jMOm5PH4z08rtx1qPw3OH6jUuc6CZnoam4pAW+kbSSmCl6PeyYW3wyoyNL9saxPrvMxmEgIQWuDDsgicrq4b+HbiIcn+gieBOSlU0n8wVEP5EoBu9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715973; c=relaxed/simple;
	bh=c+eCOGJZ+Zh3ywALXgZ/UOe4ZFcyQZlfqRps5mPLMN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ro4GW1Eynody15SzHofPa1cNfso8H8ji5g7qxqtPFOhqMueiBTnRT/ACR721A0VzpSwusav1w3XI/AyOAs6IZGjU5CRtHX5rIVoiUGdQdoIHo8sTpDsu3HwY74D/e2awJwh42Wgfm2h3jqtdn3qeEGmAOgP4aw9USqcZ+uuTFF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KNSMlhMS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GFqBd5jp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKcaOe010483;
	Wed, 23 Oct 2024 20:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GwbeFR97uKuCzPgrgBwD5NPAUJTeqMBP0i3dribbKhQ=; b=
	KNSMlhMSEWAYRqXQBGhaC/RZY5VJ9JQ5PdotPIm4QDqnrk0Wr6cE13dPhNGH7GYl
	QhfBh953PDn1TJjkheoNQNhBqRIaOJGUERv+UOZ7JXwzeVawAI4ODpVaVgBlxueU
	+Kwp3D1k45FbAYdYMkL3uyfq0Li7TYVJRgura9o2BpjMIXd0BitvQQK68+dTTJ+S
	0Q07fphzlBQoGyxw1i+GjWh9LAyTwKNzPZKWhk+iTRaGEQNdyjSvdSw/Evvmr/6B
	r0Xj3slVU3gGSfCPNqY5PcxQp2nJ+FzZznqjq5EUICRbeZg7lHEiiYAwTTZ3PImD
	XzK//tegIRHxzYDJSOR0HA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3g8wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJJHjq027526;
	Wed, 23 Oct 2024 20:39:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3bkfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whSU4dnrtKXW4Rz5+pNN4L6xbV7w81YPF49v9gWPI4TqCMCXeYQpnH+ZT48Fu4TJI7HfG594cd/XQnaMxRwhdq9r974MfXuSTCHJbGJCVcjgNs0aibb1+FOKLVIoGUa54Pp9QJp3bJ//OxL/MfvhAziO+gCKDbK6vfVyGUlf2RmonmGHWq99WB1Z+jCPGrB8vV+gOKxnK6CygnDQH4tUB7HwxQ0A1TMKoxQljfBRptI+xtnf+wwRZYi3uVjVvG/Evg8xyOdrW9OUy1sYtXERFREEUWNvzJF0u3MgDE9KzILm+GFugFYyHDzp7SOlm+I0eQ6facjQeyM2TR4idz9XRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwbeFR97uKuCzPgrgBwD5NPAUJTeqMBP0i3dribbKhQ=;
 b=qUk8ZtarKbE7li9ykmqO8A6C0WWZZb1OodbTRlpYapon0MS+np31RXqnLm6oMVX+aKwTt8g8NmOMs+edMESbqEoqco+dtmlxFa6hSTpDkd7lKFhbWgScqcLjmWeFjxhHlAyCpfZM4WWL80xKame91af1JKcyUvBreTISe3h/dcgZwLh6DBEpWFb04NjgYFNmD9u8goyiA36HoIaWFpYeouMvK4VwLzxZsHvHuDk0xDEWWxPP15E2BL41N5GQSY+eVlXK4ff2caYI8NbOgk97dJTwqZKBqOnoYHbkgTv57r3juNQ9IrQjg+H3EMzBit0bY4RvVmHK+TFey1yiDZE98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwbeFR97uKuCzPgrgBwD5NPAUJTeqMBP0i3dribbKhQ=;
 b=GFqBd5jpj9muymT+SWrnW+fj8ApLyGzO2JEvYT0O2zxJP1n2rQHk7aw1jiJWY8/F6oGqdzn7/Jo2XOsDqu0S+qTyMsBtkN5+RWhTHFZIUDiK7Id0m1rXtlVO9aEkkDjT/H+g4s4u+4yqrugLh9jdL7yFXx9aWmbbKsmJ+dvrwZU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6338.namprd10.prod.outlook.com (2603:10b6:510:1cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 20:39:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:39:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 8/8] mm: defer second attempt at merge on mmap()
Date: Wed, 23 Oct 2024 21:38:33 +0100
Message-ID: <e063d9d31a4dbd83c2d77a3f1e0114e6a0788724.1729715266.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: c715a4b6-e8fd-4d7a-d582-08dcf3a2c438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uYFLPUMO3sryJ9098QEuykuHJR3SNKI7C8dbadX4jtZRmPQSEHBRNkViU2uH?=
 =?us-ascii?Q?+xfI0jh92l29jdtP/8sPeSWva0AdMKhlu1cshrwqBY6vDtUy3FSsjVWbidP0?=
 =?us-ascii?Q?fIx+syhjPfVRPwyUHZZK0L8usmIw9PKv3TlHV4ULPGh7UqmhSOB2eENiZ6Hh?=
 =?us-ascii?Q?qYV3ttwZnuNr5i9B84OkjVuxSCcZQm1u5jjSqvNAjIK6ZO0g6uxfVAfFXdqQ?=
 =?us-ascii?Q?RbGXQJohvYMuqwBKDHsy6QGJoT2Dgy27A6Zfp7HQOlpktsPVzZKUdMn0qtEE?=
 =?us-ascii?Q?OWYIGAlQXEyN+oJ+jD8kS0ThiQw16MiJ2IFl4TDDZFIUbCdzu0IHCrVLR6dk?=
 =?us-ascii?Q?2/3YxdmbaH6xJ9sjabgfwIctEy1mn7lfOXnpk/m85RRz9lwrK8KuP66zxZiP?=
 =?us-ascii?Q?UgcmgipQ7YseOjzlD0YQLtsSqDZUJJtIzPabDymnRL/++ti5Wn60rvgOBIwu?=
 =?us-ascii?Q?WXZm5NpsPPfy6Q+bWIl/wEE2neBN8ieoAJg35JhHQKADhvxUm7A3jPX0elKK?=
 =?us-ascii?Q?lX5OVoprrfBFWZrH9eQvBB+92b5O0YMYu0AfNnFpy+cLD21ZIgJScIkwI5HH?=
 =?us-ascii?Q?sG7y5oKU2N9+DjB5qW+1ZffnvBq4JfFyTPo4NJuzUHjgKESYbsfGDsP/E4mr?=
 =?us-ascii?Q?8hU02NrFbkR6O0+qFjYiQ1UNY5WsC5R/XK8ihwNHJccVZZsOGBNmHT/xMKxz?=
 =?us-ascii?Q?mKLCf3CG+twrj75CZ8IS8/gnXBhh8e7RdMyDQHuSTAT1HWQUCvbo8FPOeEaq?=
 =?us-ascii?Q?A2fomFdsmzqKzROupV2mO4khW4zTScIc39aMknKACl9k69eUJDxFLES2/WVk?=
 =?us-ascii?Q?7F2sa56ImQHuVwUpT9YWBro6x2cMQRcmFKDr5RrcuuPNzTlKUnIasv0ZEssQ?=
 =?us-ascii?Q?xkQe3gKMmmJvDZr3ZdOufiuD850tJjyuL/4/k3k6YLsKZOr899rb4frXzkBO?=
 =?us-ascii?Q?KkLGjtuC1MOzF7J7cee7SNv5ZQ3/0G/YRNASyQe4Bcic6aQvk1aNVkJ7B2px?=
 =?us-ascii?Q?L/u9uJKtAa8SmvBP0CqxJ6/JbqOtfjZdkj7543bjea580O5cM0xdesohi/YY?=
 =?us-ascii?Q?U5YvdtlH0hf/f2jnl/crBDxl6h8iQxwmMHtrCZBiEO81RYrqo7PotEOgn/Zl?=
 =?us-ascii?Q?+F5KxZJaA/aQ9Sev5Qp1YnwCnYiYZpMrtPguoqKyrTbwqtmoGH3s4VQ0Cqn9?=
 =?us-ascii?Q?5Lc80HID+4Ox7ZSarr3+VkqAFUHEo4Q2RzzddfxudODjWCYyV2cmsgdlBfsM?=
 =?us-ascii?Q?7L5AfulO3RAQD69xXJXd1ouyUFeZ3LBhTXT+9cy8q1yDc2uIQ+fxYA8OM62+?=
 =?us-ascii?Q?5BKPt3kpHPwlfaLWPgWxfIPo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnRX8wrGTW03TSbkpwMn7wz+U5RDViPCK8PzHZxQDS0Gz9fjgI8DqnV+zxMF?=
 =?us-ascii?Q?1Pfetm7PveOPDxYE7yWSI/8xo6Hpqrm8xCcurnFrw7jU4L1p0WpTCr7GtpDM?=
 =?us-ascii?Q?UJ/0Dowjksd822kdYRKUNUcE6J5UEgg3MidyTE+7Prq5V7KwR2Ho9XBBCnFh?=
 =?us-ascii?Q?Nef+3YFgLbJjfpRaU+vDJyysLLeUslZ2kc5h+nRRBO7RTwrTCOh85cSezy9h?=
 =?us-ascii?Q?G2Nh67C/as7iW1Q4D80qUh5JWe8pM/iuzv5s845+rum7kiUWs/yOs/3w4UQ1?=
 =?us-ascii?Q?bXdGJUjWKn/2pCXXbb2rAgFodVpX2xvrN/1aJrgxeHWKcFtpAWHo/0aDJXhv?=
 =?us-ascii?Q?sDE1y+VB4Z+cEHIbX41qPNLcDiSK2eRylWyc22/uQ/adSGILOYeSFfuXRytS?=
 =?us-ascii?Q?JlwXgnDKq3lUw739eF3F55PUD9Nu793fSncZ1Ez7DZLw4h7r1fQUbmJeZPJ4?=
 =?us-ascii?Q?l1BYwOts8Gz7qVYV48820CoAMYjSGT5XTus4IHX8/btqe+WY07SNuwLpNI2s?=
 =?us-ascii?Q?Pe11Q1cX6hPDxlzz32iLU/ugMCZUEsd1kgsy0vbxXP+YEZhshuXRX5ZO7JA2?=
 =?us-ascii?Q?c3f6dm4Rm/VLE7SirAqGl/6LeNiC89LwNRqM2UkzfRZJCmOs4nhYYO03Hz1w?=
 =?us-ascii?Q?3Xjsib7VSZ7lKDl1cJTJiCMjQQa5nWQ4c8k34z/v9YFlZCkRhekqmJMUuVRd?=
 =?us-ascii?Q?FCwtQDA32UJoTCvbLA3J7YjIW4csB4nzj+8Kf0JWy3JwJ4UVPWgUw8hjvnQ6?=
 =?us-ascii?Q?bjTg8k6J/Rjx76lvSL/DODinYb6OUlYZDS5egxl9W/vxfsKerIEEWfjDhUqV?=
 =?us-ascii?Q?5Cb4g1ko7tKROm9dF6exqjxH37fRphfGKR/2uvwttQw2FVlWjgWkAgnZq+g6?=
 =?us-ascii?Q?s1oTBAidwgEPkaIuvTPkilK4ku8SuwHNrlF+g4+RII4qykUFjNVg5qcML5Jz?=
 =?us-ascii?Q?VzQwllY7NsSdH2pXqoGdcswisWf4zNzMeSD/OulXCSJTI2eFiciQhOfvQ9U8?=
 =?us-ascii?Q?SSBdmZdyCId6d9KsCo30bQS4U40NyeDXFEI4svC3v9OTSN3Qbyv1UeWHITeQ?=
 =?us-ascii?Q?M6Ja9rY5zY4BSipjGN48W0oVqEJHCyk+Hv70dVuinC22pzgWSgUhDyPUIUtG?=
 =?us-ascii?Q?3VNwIqt4Km/+sQ8RQL1boD/hC3VjQ5gUPjpp3K+nIyXamPwWeihEf4R/Z2c9?=
 =?us-ascii?Q?/T491rJBiHkjUJZs8rqTX46cmwkDXUnugbo9QUKCg9Be4zZTUaJXb1AFRMfF?=
 =?us-ascii?Q?6uvQN9Y0YohRrotOYjPG/zu9QJmmocUp22IbxVxtufcCZk3q2rVPFGTLEJN4?=
 =?us-ascii?Q?vF0emR2oNun3NszkiXPmQtDv7JGSt730tPExbgNJMcBebOpiZYVj7GAKOCdH?=
 =?us-ascii?Q?yGB7W/0J/gmkhWdnkOkmFc+wcWaT8qnUD50buaK0flNND3r167B4mWWZTamc?=
 =?us-ascii?Q?HiIHGwJbkVYrYbLezMxdphZNap45oqzBxcxPMGt1pfB8oNZULIZKElLIDFx3?=
 =?us-ascii?Q?guCVAhz9ptc3mNv79oFmE+KwrDXn3pL9cstKMq1q6EEPgHXJrMKIEffDnD//?=
 =?us-ascii?Q?Gmu5vXC+K6wu3+2aRiqkOUfpbHHG/nKHZBTX73N0tOM6sD1Srb3V0iHxz2rb?=
 =?us-ascii?Q?W7oXXnMCxqh5HjVo4vQw4CwjT5jIP1sB4+8upYi5uboiFc3ZZN8YmpbdePRo?=
 =?us-ascii?Q?d3YQKQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0GjygpMZ85rQ/nCkoK+tPa+puJoRZsDoQGtv7mjiprcUfIOnz9hClfAaSlEQ2jSvg3Kp3D0PmgtzjTqZSaycCJMZhsZpdVpHlN9LpzwOmhQr0qJfg0m8I8aTLxAlyYd60qjRqoC17CZex/XZRITqGKHn7vnILoNF+B7WmefPUfGG6ERi3jOpjbpTteku/5vsabsdDdKmkc5aqqlIyI2uXpjIZM9UkiEJXCtLrwSOe+nVKuN88N9DPecK4sVnS5FOKiMKK4roEOaS9bxMjEhiMPgeTqhMCKfACAKf3osuwfzAS//c7Hy0jFbcxq7N806RzhHJfJ2ju0Yof1pKpHn6eZKqrKSkEkO4eubLNU4mwm2/zW9jmnuz07z6SzRggyPrSE9ruCdrwAPn5AJxgo7rSzYZ9v5VrfjQ6yd+D1prsEUIBQRSWNUMavkh1jgvGbhC+C20jBYlDfqxGkG7ZF3q5C9rzCWcRuBrzxXbRbQwWqrElwmMLbnlitJitLLfqF72I3YPhL5NYRIVw6aXAe5a6YmeJLoa5TmSP9h9zG18NDp/GMi3zqlOUS5KY8IbbyrLBxAF7SXv2IMJW7cCQcXa/1kFaev+Tx1PCKFUTFJBqBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c715a4b6-e8fd-4d7a-d582-08dcf3a2c438
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:39:18.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYrbbkG9MvNzsE2Cb/JXOvn1JSwB+cUlAVQgFNseqOxZCJdpLohFtbAsuvU1qLONmnNQwVRjE1q+4wbIkBlALtZeXFs63VbBcimZeAwQcYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230132
X-Proofpoint-ORIG-GUID: YzzipgxMoHitkMQ4xa8d9FIDOn6-IItv
X-Proofpoint-GUID: YzzipgxMoHitkMQ4xa8d9FIDOn6-IItv

Rather than trying to merge again when ostensibly allocating a new VMA,
instead defer until the VMA is added and attempt to merge the existing
range.

This way we have no complicated unwinding logic midway through the process
of mapping the VMA.

In addition this removes limitations on the VMA not being able to be the
first in the virtual memory address space which was previously implicitly
required.

It also performs this merge after the final flag adjustments are performed,
something that was not done previously and thus might have prevented
possibly valid merges in the past.

In theory, for this very same reason, we should unconditionally attempt
merge here, however this is likely to have a performance impact so it is
better to avoid this given the unlikely outcome of a merge.

The vmg state will already have been reset by the first attempt at a merge
so we only need to reset the iterator, set the vma and flags and try again.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 75 ++++++++++++++++++++------------------------------------
 1 file changed, 26 insertions(+), 49 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 065f5e1f65be..c493ecebf394 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -19,6 +19,7 @@ struct mmap_state {
 	struct file *file;
 
 	unsigned long charged;
+	bool retry_merge;
 
 	struct vm_area_struct *prev;
 	struct vm_area_struct *next;
@@ -2280,9 +2281,9 @@ static int __mmap_prepare(struct mmap_state *map, struct vma_merge_struct *vmg,
 	return 0;
 }
 
+
 static int __mmap_new_file_vma(struct mmap_state *map,
-			       struct vma_merge_struct *vmg,
-			       struct vm_area_struct **vmap, bool *mergedp)
+			       struct vm_area_struct **vmap)
 {
 	struct vma_iterator *vmi = map->vmi;
 	struct vm_area_struct *vma = *vmap;
@@ -2311,37 +2312,11 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 			!(map->flags & VM_MAYWRITE) &&
 			(vma->vm_flags & VM_MAYWRITE));
 
-	vma_iter_config(vmi, map->addr, map->end);
-	/*
-	 * If flags changed after mmap_file(), we should try merge
-	 * vma again as we may succeed this time.
-	 */
-	if (unlikely(map->flags != vma->vm_flags && map->prev)) {
-		struct vm_area_struct *merge;
-
-		vmg->flags = vma->vm_flags;
-		/* If this fails, state is reset ready for a reattempt. */
-		merge = vma_merge_new_range(vmg);
-
-		if (merge) {
-			/*
-			 * ->mmap() can change vma->vm_file and fput
-			 * the original file. So fput the vma->vm_file
-			 * here or we would add an extra fput for file
-			 * and cause general protection fault
-			 * ultimately.
-			 */
-			fput(vma->vm_file);
-			vm_area_free(vma);
-			vma = merge;
-			*mergedp = true;
-		} else {
-			vma_iter_config(vmi, map->addr, map->end);
-		}
-	}
+	/* If the flags change (and are mergeable), let's retry later. */
+	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
 
+	vma_iter_config(vmi, map->addr, map->end);
 	map->flags = vma->vm_flags;
-	*vmap = vma;
 	return 0;
 }
 
@@ -2349,22 +2324,15 @@ static int __mmap_new_file_vma(struct mmap_state *map,
  * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
  * possible.
  *
- * An exception to this is if the mapping is file-backed, and the underlying
- * driver changes the VMA flags, permitting a subsequent merge of the VMA, in
- * which case the returned VMA is one that was merged on a second attempt.
- *
  * @map:  Mapping state.
- * @vmg:  VMA merge state.
  * @vmap: Output pointer for the new VMA.
  *
  * Returns: Zero on success, or an error.
  */
-static int __mmap_new_vma(struct mmap_state *map, struct vma_merge_struct *vmg,
-			  struct vm_area_struct **vmap)
+static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 {
 	struct vma_iterator *vmi = map->vmi;
 	int error = 0;
-	bool merged = false;
 	struct vm_area_struct *vma;
 
 	/*
@@ -2387,7 +2355,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vma_merge_struct *vmg,
 	}
 
 	if (map->file)
-		error = __mmap_new_file_vma(map, vmg, &vma, &merged);
+		error = __mmap_new_file_vma(map, &vma);
 	else if (map->flags & VM_SHARED)
 		error = shmem_zero_setup(vma);
 	else
@@ -2396,9 +2364,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vma_merge_struct *vmg,
 	if (error)
 		goto free_iter_vma;
 
-	if (merged)
-		goto file_expanded;
-
 #ifdef CONFIG_SPARC64
 	/* TODO: Fix SPARC ADI! */
 	WARN_ON_ONCE(!arch_validate_flags(map->flags));
@@ -2415,8 +2380,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vma_merge_struct *vmg,
 	 * call covers the non-merge case.
 	 */
 	khugepaged_enter_vma(vma, map->flags);
-
-file_expanded:
 	ksm_add_vma(vma);
 	*vmap = vma;
 	return 0;
@@ -2430,13 +2393,17 @@ static int __mmap_new_vma(struct mmap_state *map, struct vma_merge_struct *vmg,
 
 /*
  * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
- *                     statistics, handle locking and finalise the VMA.
+ *                     statistics, handle locking and finalise the VMA,
+ *                     attempt a final merge if required.
  *
  * @map: Mapping state.
  * @vma: Merged or newly allocated VMA for the mmap()'d region.
+ * @vmg: VMA merge state.
  */
-static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
+static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma,
+			    struct vma_merge_struct *vmg)
 {
+
 	struct mm_struct *mm = map->mm;
 	unsigned long vm_flags = vma->vm_flags;
 
@@ -2468,6 +2435,16 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_SOFTDIRTY);
 
 	vma_set_page_prot(vma);
+
+	/* OK VMA flags changed in __mmap_new_vma(), try a merge again. */
+	if (map->retry_merge) {
+		vma_iter_config(map->vmi, map->addr, map->end);
+		vmg->vma = vma;
+		vmg->flags = map->flags;
+		vmg->next = NULL; /* Must be set by merge logic. */
+
+		vma_merge_existing_range(vmg);
+	}
 }
 
 unsigned long __mmap_region(struct file *file, unsigned long addr,
@@ -2490,12 +2467,12 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
 	vma = vma_merge_new_range(&vmg);
 	if (!vma) {
 		/* ...but if we can't, allocate a new VMA. */
-		error = __mmap_new_vma(&map, &vmg, &vma);
+		error = __mmap_new_vma(&map, &vma);
 		if (error)
 			goto unacct_error;
 	}
 
-	__mmap_complete(&map, vma);
+	__mmap_complete(&map, vma, &vmg);
 
 	return addr;
 
-- 
2.47.0


