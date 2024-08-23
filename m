Return-Path: <linux-kernel+bounces-299597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721EC95D75D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B6B282703
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6917194A44;
	Fri, 23 Aug 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eN7Ux6Aq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xChTYO5u"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176D19409A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443659; cv=fail; b=BwOJuf0nqxs18w6RzRIVB2i6vyC1+ESfFWB8G5sHuRJtpSEC3A8A5PjCF72CURFRqE421VwY/JtS4ZbzmYgqJLl8rsBCQ05APIQbr+AIpZM3ayVzG2eyoBu+xVv5uc2U2+l05YhWF5DTNZfXd+vLcrL900uDjuiQRMqKjuKfMXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443659; c=relaxed/simple;
	bh=SwmQgpUvlw5Z+G25887O0K5KvjjR4d/w6KLWjgDiBCc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aGFD/fKa5jXcrNvhSOVeVwLS9ezcQEOenG/1auFKJEGrXkf3MBqtDEsDhvGut8NN6cRTY/vrZRmaZgN4L/3m8jzTsvcFgO4iazNa2Vfaa5Co0qhAciYqE6bYZDEwUqRrk29iBxcGTuu90qFKoW1VkAAi/NfmtaWJcReOtoxXLHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eN7Ux6Aq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xChTYO5u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0VXw002311;
	Fri, 23 Aug 2024 20:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=Zu5EYHIgIPvZed
	lMhlCTxdUSWCbKjzMyk6DKfShLm68=; b=eN7Ux6AqbSVzZj+8XR9LMvDIJUMLmh
	sW3+q0Oljc7EItqg4BbUqPBtGMkzuU3ElWZNapTuIKHjU+tV+r8SwsMa8cylK2ao
	eaavWFGsiQCQucDBUtYsuUOJcMkHv/WB38azELShgGpxrnTIexvHjxxwuSMQI1ii
	NwplX50p/QlWkrM688vumfKXgkP2m9HCdwsFkOegxS2Dr8ovCDg++UOJiNplBiSe
	g/fkcDHWkB1xxv9HLvxG4aPgFdR2COHslOprW14HeV4Jd0NGvvrDyJlZphyhN5k1
	O8fvUKqHgr5IPg5Wz1kBEmZ+pGddl1C+iPtSF5FqjuAYy8e1coo/sZAw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67n1fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdFFb007123;
	Fri, 23 Aug 2024 20:07:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4170s610wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9n4lvqPuyzb9KcZy27txZO0PMmXO9rxs/4PZ0x3ptypjwelUnfqef+3hcariN1IunVOTAGAaidTWvqRPjmQY8OyO8/4gvdQz4FVkz4T/kGt4HV+Sna/JexDSAEWSNazyCIsvOMvAU99gcfNYh1QP7M2rjV8qziiuiXrk/utQ5OLj+TOeHf3WKMpCKBh4o6+KL4x8Pn7+iYtqGeBDonpz1r/rBWdyvlK9QEesKqzNNhsjMKwdtJFtRUldtwbSOEIFUuMPw2Ql8aa4PKxeRP+2XYxQBqJBoo9AOu5bqH+GbnJEOr78BzDlDGaiVxMS3ms9Xlwm8ZBtRT6ksfxo1m7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu5EYHIgIPvZedlMhlCTxdUSWCbKjzMyk6DKfShLm68=;
 b=f4Pu76CHTAyf2nQpHVggbGbCt7DNegDwu5/Oy3/a+rzyMpdIsetSoGIZMx+N0+wycrGfy3qGShTicIs80Jb1Khjso2PE7yjCjCmAS/N/UE+xz053V2nEPyVDip+M52J/JJP+kE4UTkqTW0cd99YFfey3YDGUnoAF4obZD9G6GI7G0/NM4k4UKpRwvmFtG6Ba/kYw5Mm6q4yZx5C/JjOK6SWsUPDMhBMKrSJBJLdEP87oHNDIAv7FSTHr+2QhNox0Nt7YdYdnelulgyHF00Z/67GmigG5F2DuNp0VMlxMMMnkgOzCICeckbmafPTCDUsOOco3AkAxZ89fTWY67/MBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu5EYHIgIPvZedlMhlCTxdUSWCbKjzMyk6DKfShLm68=;
 b=xChTYO5uw1Evg0/NzzgGNfgN96tikKkMzh+Jltu+DghL8gGJKZaC5f7PQob4Q6x1f28wd8x9jPOx0UhLbBqzxTWT7NHl6kmChJ6E2b2UK/TQ2LqLJ/FEh3Nn03mkCuXlPqQPHUwBt+JfINqYGpVEjJB5aW/MLm6HT6vNsdfNgcM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:08 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 00/10] mm: remove vma_merge()
Date: Fri, 23 Aug 2024 21:06:55 +0100
Message-ID: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 129e80e6-eb2f-4fa8-7e91-08dcc3af2aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+KPHNhQaYTI8bakp69PD0H4iMO8c1mBTvgJG/7/8RCYMBwlJf6eTOGJYbFuZ?=
 =?us-ascii?Q?aS1nwS3Mboe5LCldkOzHWgkWn+mTQ6arigqpLYeLwwtOUiv4AVR7qpHM6Uyd?=
 =?us-ascii?Q?3n8ppYv7NH92lY5jBSsvopMCE0IUB9Wnb+U14MBKgMZqjeTwGLDSLIvOdGFq?=
 =?us-ascii?Q?KcOFJ1j0i37UgpSKYjwCUWsJXBaRjo4ENG/yGbqu5IZkzFcQjuwvfwQlMrA5?=
 =?us-ascii?Q?Eb/+Nj3L6qqas5VXKmIUmsTyq9+vz3VnpuT3VwTNPS7UXuX/dQ0pqFd+ftYM?=
 =?us-ascii?Q?pG/JKZXUsZt2DDOAzG97uGd7t7la7wwyks/J7U3r54ZWAogzSYlSthXSlkU0?=
 =?us-ascii?Q?xq0p3E+blfVs33dBcAGvSbKEtG4CIOV0H0TvXmi1ShgFA9AcgWffOLmQtvp5?=
 =?us-ascii?Q?NNwfZ8B6N2mXnAXWr/f7a4DyN86xSIUZ6BwNH7PVDUip4VS5b01pzUt/eml6?=
 =?us-ascii?Q?8K+htMVcCYVoIMJ1F7s0uFbgc7yCoUwwGTLZK10s/Tj7vghGrIg/B6Id2j4q?=
 =?us-ascii?Q?EEGZyoWsZeDi1ZCEYtxAUnR6Po2OljeiCyhLVMJBLceg5rb8BA/5l4KaXxFo?=
 =?us-ascii?Q?FaZgBssfDj0YAaUBtmwS48MQdPjP7gEszSBrU6Yq3Rh+uflMrRwXo04mXIPT?=
 =?us-ascii?Q?nBPc388R7JNWt6XJKTtiX4hr10vW0vyUEChY1FW3NBDtH9qoR8JcBBB5zNcG?=
 =?us-ascii?Q?+pVGMTrGut2xUXfo9SzlmC2nDZSjJN/UD+etWVscvz9XBvm4uOM/CxqgjHVi?=
 =?us-ascii?Q?jEhfKrSJJB8dryzo6mcVldc3Ov6tY0O61ixMhN/LJLKbxNqGgU+WqioorJ24?=
 =?us-ascii?Q?UjZOiC7AmnieWVm+1ic95Ukglm/IOHdihwvRIGj6Z0a1OVjzgRBWf/lB2BG9?=
 =?us-ascii?Q?IaU0pW87ZMD52OLS8+E/l7k/gzYeNhcvpKqdIo+zvdSd6Ibwv7G5QAJRmjh3?=
 =?us-ascii?Q?noqejIm0cY11/ooJv0CZbLJ+W6gpBiwmBrqlQuOj0xl3JtK7x+8Cq8ZiLAaL?=
 =?us-ascii?Q?NKN1jRBUYVvL81RRzabHnoraFzqnzGx1HvbIlTVO+zxhzUSUcGh6DdnV7ITu?=
 =?us-ascii?Q?7iMQeTxbioqh5UeDSgDETAJ2Vgk3FHu7ReDeytbTL7HVDCRkjnl4KbaSx/7c?=
 =?us-ascii?Q?D2hn6FqgppIdm6GAHWQKTHgXeAlSV92dEm4iNjuLYtkvrP9oPkbinyUeT0qb?=
 =?us-ascii?Q?x4quX+BGwsh+rfHJXorhIrxEs4ZgRxkA3AIXdSGJIa2ekm0dg+9W/iDfiZm9?=
 =?us-ascii?Q?rHYa3h0fjUXRxPUiN+7XwHwRw7Eef76nmrMLvNnUA+6TRYsWIBMt7lLp9STm?=
 =?us-ascii?Q?udyX9gUOulm4Wg44zeIv6Y6f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BEHaoyMFhc8hGHGAgqRGOQdEes6Sj1rt8EHqS5hIibwCHmEwaVNx0Mhz//b9?=
 =?us-ascii?Q?c979TCzmApTTdKsVzssjTYdSjcdXGRg8wae2ueNA7d/zBPQv9FCbSL9u2HdB?=
 =?us-ascii?Q?tSCQZ2DwK6/ygQm8YpaZJuQU42Eq7v2qrFECM43dwnBChvZaFMbn0SbczeK3?=
 =?us-ascii?Q?lPZBsAP2U3zfql+BQTCc2yThnW815MY/PVjNeRILGe7+hnmJMc2XIrZtAo2Z?=
 =?us-ascii?Q?E2LtIZ6d9VReJQUG0aPsq6Cr2xPyjYKR7K3zKOOCA2S06yKtyIvZV7N+IHvL?=
 =?us-ascii?Q?6CKOKs5op6oyK7JPZCL7DFP0ZFcdf7BDqwaNOuvssxHexuPvke/6MbBJIi8C?=
 =?us-ascii?Q?39GHyWEPxxNxITQVFg2Migklm08Ow5dDJy0dKfIMeoyN5lwYBv2lPYMRx9AZ?=
 =?us-ascii?Q?c4o2kg9mlwHE/nbflGrqpmIUA5VDfy72E65cj/fc4dPPD5Gmboh5SqvRMswI?=
 =?us-ascii?Q?LhQdMkZe3YKWCbE1TpIjifRfZXgJcn5h2EcIZzNDrBJCJfNNr/PoUijzh/Q4?=
 =?us-ascii?Q?JhYRK9Ewx1fwIkbjZBQrgUgktgOauNOGZQLhkXqjnUtBQSZ5pK1hsp8P0cmw?=
 =?us-ascii?Q?6RtfDfKhtpC64HpZqzNv+RE9dk8Ygb+YMbMfZYuCSuPc94Ff7I2tUq+Es7XI?=
 =?us-ascii?Q?2m4NhPh8D4AS01LnX0vsZSi2kB8RSp1TcmMHitstlev0yrdxS40aL6PfxOpY?=
 =?us-ascii?Q?n6Z3XrjsVQ4/dNVgCWcEH6sIUct84ZNVz3IdNBMMKta4l3Q6/F7fVxLuRTGB?=
 =?us-ascii?Q?wiXa6TdVMMPe5816mPk2wCsSa8I5BWPSBHvzwShTL2pwZQdspwlRtIqz2TR+?=
 =?us-ascii?Q?KjU2UtCIwEXCqqZ2zGxPnY8uT9GXkUSKvoOKifOLh2Zg32fBGf+q/Bk3sQD4?=
 =?us-ascii?Q?Sc0J5Fn4CLSyB4GcSkqHvii0GlinLfDvhfXCHOFH3V/QTL5f0Kjv7UGpJAGA?=
 =?us-ascii?Q?9zNQTOitq1FWcqBZrFyRrPwioqSI/Sb3QCwkCETlw71h7ADVl9TjQaBSCwg4?=
 =?us-ascii?Q?RjReb9N+qf5aOfQmbKhF1kQG5Gks1sB7Pi9NO0B8JdMdSyiCDweR/n1XEoyP?=
 =?us-ascii?Q?sB+wPA3xo18kyAZfNmrBTJ/LHEpq4N+4/HMPtw3Kl1pwMNVGUEjqK0+bEmSz?=
 =?us-ascii?Q?PVPgiArtbNzKNkax+uvYkbZ3t/8iU0/M+2YIlT8DCkfCviIGYIgRCEJnWafs?=
 =?us-ascii?Q?6dut+No/ksSbwsbQ+tZlhMERzwpqv8k6XRLwXe0jJUyO47efYlTyoaNOB9ic?=
 =?us-ascii?Q?J7cmogP3+N+O48O4cgiLcFJD2X7mjlH2SxXhDGPSJo8BIDabNiXh6NSUu3Pf?=
 =?us-ascii?Q?zNxxFUDgqpCltJWIruGJpBB38plrATqH5JIVZIgaW0Ij/B9L9WmDUY3DsbVR?=
 =?us-ascii?Q?DdkJ+XVdTbidAipCyrgUJV73RtdZrescI4zzzORijtS9qQ1PQvLde2ZejkxO?=
 =?us-ascii?Q?wrXn0uOOBwFf1ji1GJaVLNYscNCRBtYUrIumQ8V8A9HhmWvG07y3rjXEVnk+?=
 =?us-ascii?Q?vtbc8D9cvkgn0MdJ1SXATjqX/Aefurk5LUE8/YZiSULOL0IaHNGyrnhgn9ZM?=
 =?us-ascii?Q?AVqpjHwEgTvWFzx9x8vWoiVLArM7zI1pPQ2Iutfm/SyFBYiti/bv/2XofrTm?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y8En+oQCXJ7EUy0jujI1+6pCtem0rA+d6w3Pti8GxpTvWnXdUnGEkc3rKEoqCKZpvKk4VaRvnUC9r7oL6EbQkfjRvDCg9V/HiqfOYDngIhWKK+TXWnN59VtdeJqRspF7fDOZQ0Q8Js2Fr7LpmOy+8AaHdAxVnvpPTstJuRLWlD+ghOXxDveU/bR4dwggTRYn7JaVYNe5GIwd0mZoFce81010nPacugBJ6+wxcop+DrJN8tX4FgqWQL1lrwloLPVEvO00NB9Yfdqr774N5e9c+LkPRRDbmWkeAgiWaBaaFm8mzHERovYSZPTW2KYn56hMLA1g+QAx4rKrDMom+s5AKR/QuhR+6E3FZs5dcZbReiQpUOmLQzTvtMYzFv+DEps8v66Z+RqDGFjNOGv6P1UmKhEsk8U9hl7UZGfOqetS5oSf80qAEuZOzjTr8drb3yCoTLWC1vHZZzMQKeu1QFbQEk6+vDGcRzyLGl4wrB+lVK4TOyJtkaoOoLX9nmWspTJDAp4vOAJtxjPCkYyYnmUGLBMnprbLn47KJZD8k5Ld+vfmMJ3LnRJd5POX3IpNc0H3WfnfN8LoTUOMyTSpk3+eXwDUIhLTcYDp4xOpTxudN3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129e80e6-eb2f-4fa8-7e91-08dcc3af2aba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:08.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bNeDTLM2WaWvChtUml86YO24db1hsvxuhJ1tQFjsbaJVtKf5jqQIW/uvtGiUskDjlNh/GmFGzOz/4nQd8amNQPzXmy+ONTLxRWvcA5apZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: 6PQykAVQjy7rTNTHWKS6tHPB5bgDqLnK
X-Proofpoint-GUID: 6PQykAVQjy7rTNTHWKS6tHPB5bgDqLnK

REVIEWERS NOTE:
  This series is based on mm-unstable and rebased on Liam's series [0],
  including the fix patch [1] sent for this. In order to review these
  patches locally, if they are not already in mm-unstable, you will need to
  apply those series before applying this one.

The infamous vma_merge() function has been the cause of a great deal of
pain, bugs and confusion for a very long time.

It is subtle, contains many corner cases, tries to do far too much and is
as a result very fragile.

The fact that the function requires there to be a numbering system to cover
each possible eventuality with references to each in the many branches of
its implementation as to which case you are looking at speaks to all this.

Some of this complexity is inherent - unfortunately there is no getting
away from the need to figure out precisely how to execute the merge,
whether we need to remove VMAs, whether it is safe to do so, what
constitutes a mergeable VMA and so on.

However, a lot of the complexity is not inherent but instead a product of
the function's 'organic' development.

Liam has gone to great lengths to improve the situation as a part of his
maple tree implementation, greatly improving the readability of the code,
and Vlastimil and myself have additionally gone to lengths to try to
improve things further.

However, with the availability of userland VMA testing, it now becomes
possible to perform a rather more significant refactoring while maintaining
confidence in its correct operation.

An attempt was previously made by Vlastimil [2] to eliminate vma_merge(),
however it was rather - brutal - and an astute reader might refer to the
date of that patch for insight as to its intent.

This series instead divides merge operations into two natural kinds -
merges which occur when a NEW vma is being added to the address space, and
merges which occur when a vma is being MODIFIED.

Happily, the vma_expand() function introduced by Liam, which has the
capacity for also deleting a subsequent VMA, covers each of the NEW vma
cases.

By abstracting the actual final commit of changes to a VMA to its own
function, commit_merge() and writing a wrapper around vma_expand() for new
VMA cases vma_merge_new_range(), we can avoid having to use vma_merge() for
these instances altogether.

By doing so we are also able to then de-duplicate all existing merge logic
in mmap_region() and do_brk_flags() and have everything invoke this new
function, so we universally take the same approach to merging new VMAs.

Having done so, we can then completely rework vma_merge() into
vma_merge_existing_range() and use this for the instances where a merge is
proposed for a region of an existing VMA.

This eliminates vma_merge() and its numbered cases and instead divides
things into logical cases - merge both, merge left, merge right (the latter
2 being either partial or full merges).

The code is heavily annotated with ASCII diagrams and greatly simplified in
comparison to the existing vma_merge() function.

Having made this change, we take the opportunity to address an issue with
merging VMAs possessing a vm_ops->close() hook - commit 714965ca8252
("mm/mmap: start distinguishing if vma can be removed in mergeability
test") and commit fc0c8f9089c2 ("mm, mmap: fix vma_merge() case 7 with
vma_ops->close") make efforts to relax how we handle these, making
assumptions about which VMAs might end up deleted (and thus, if possessing
a vm_ops->close() hook, cannot be).

This refactor means we do not need to guess, so instead explicitly only
disallow merge in instances where a VMA with a vm_ops->close() hook would
be deleted (and try a smaller merge in cases where this is possible).

In addition to these changes, we introduce a new vma_merge_struct
abstraction to allow VMA merge state to be threaded through the operation
neatly.

There is heavy unit testing provided for all merge functionality, added
prior to the refactoring, allowing for before/after testing.

The vm_ops->close() change also introduces exhaustive testing to
demonstrate that this functions as expected, and in addition to this the
reproduction code from commit fc0c8f9089c2 ("mm, mmap: fix vma_merge() case
7 with vma_ops->close") was tested and confirmed passing.

[0]:https://lore.kernel.org/all/20240822192543.3359552-1-Liam.Howlett@oracle.com
[1]:https://lore.kernel.org/all/20240823133034.3527917-1-Liam.Howlett@oracle.com
[2]:https://lore.kernel.org/linux-mm/20240401192623.18575-2-vbabka@suse.cz/

v2:
* Updated tests to function without the vmg change, and moved earlier in
  series so we can test against the code _exactly_ as it was previously.
* Added vmg->mm to store mm_struct and avoid hacky container_of() in
  vma_merge() prior to refactor. It's logical to thread this through.
* Stopped specifying vmg->vma for vma_merge_new_vma() from the start,
  which was previously removed later in the series.
* Improve vma_modify_flags() to be better formatted for a large number of
  flags.
* Removed if (vma) { ... } logic in mmap_region() and integrated the
  approach from a later commit of putting logic into the if (next &&... )
  block. Improved comment about why we are doing this.
* Introduced VMG_STATE() and VMG_VMA_STATE() macros and use these to avoid
  duplication of initialisation of vmg state.
* Expanded the commit message for abstracting the policy comparison to
  explain the logic.
* Reverted the use of vmg in vma_shrink() and split_vma().
* Reverted the cleanup of __split_vma() int -> bool as at this point fully
  irrelevant to series.
* Reinstated incorrectly removed vmg.uffd_ctx assignment in mmap_region().
* Removed a confusing comment about assignment of vmg.end in early version
  of mmap_region().
* Renamed vma_merge_new_vma() to vma_merge_new_range() and
  vma_merge_modified() to vma_merge_existing_range(). This makes it clearer
  what we're attempting to do.
* Stopped setting vmg parameters in do_brk_flags() that we did not set in
  the original implementation, i.e. vma parameters for things like
  anon_vma, uffd context, etc. which in the original implementation are not
  checked in can_vma_merge_after().
* Moved VM_SPECIAL maple tree rewalk out of if (!prev && !next) { ... }
  block in vma_merge_new_range() (which was changed to !next anyway). This
  should always be done in the VM_SPECIAL case if vmg->prev is specified.
* Updated vma_merge_new_range() to correct the case where prev, next could
  be merged individually with the proposed range, however not
  together.
* Update vma_merge_new_range() to require that the caller sets prev and
  next. This simplifies the logic and avoids unnecessary maple tree walks.
* Updated mmap_region() to update vmg->flags from vma->vm_flags on merge
  reattempt.
* Updated callers of vma_merge_new_range() to ensure we always point the
  iterator at prev if it exists.
* Added new state field to vmg to allow for errors to be returned.
* Adjusted do_brk_flags() to read vmg->state and handle memory allocation
  failures accordingly.
* Do not double-assign VM_SOFTDIRTY in do_brk_flags().
* Separated out move of vma_prepare(), init_vma_prep(), vma_complete(),
  can_vma_merge_before(), can_vma_merge_after() functions to separate
  commit.
* Adjusted commit_merge() change to initially _only_ have parameters
  relevant to vma_expand() to make review easier.
* Reinstated 'vma iterator must be pointing to start' comment in
  commit_merge().
* Adjusted commit_merge() again when introducing vma_merge_existing_range()
  to accept parameters specific to existing range merges.
* Removed unnecessary abstraction of vmg->end in vma_merge_existing_range()
  as only used once.
* Abstract expanded parameter to local variable for clarity in
  vma_merge_existing_range().
* Unlink anon_vma objects if VMA pre-allocation fails on commit_merge() in
  vma_merge_existing_range() if any were duplicated. This was incorrectly
  excluded from the refactor.
* Moved comment from close commit regarding merge_will_delete_both to
  previous commit as unchanged behaviour.
* Corrected failure to assign vmg->flags after applying VM_ACCOUNT in
  map_region() (this had caused a ~5% regression in do_brk_flags()
  incidentally, now resolved).
* Added vmi assumptions and asserts in merge functions.
* Added lock asserts in merge functions.
* Added an assert to vma_merge_new_range() to ensure no VMA within
  [vmg->start, vmg->end).
* Added additional comments describing why we are moving the iterator to
  avoid maple tree re-walks.
* Added new test for the case of prev, next both with vm_ops->close()
  adding a new VMA, which should result in prev being expanded but NOT
  merged with next.
* Adjusted test code to do a mock version of anon_vma duplication, and
  cleanup after itself.
* Adjusted test code to allow vma preallocation to fail so we can test
  how we handle this.
* Added a test to assert correct anon_vma duplication behaviour.
* Added a test to assert that preallocation failure results in anon_vma's
  being unlinked.
* Corrected vma_expand() assumption - we need vma, next not prev.
* Reinstated removed VM_WARN_ON() around vp.anon_vma state in
  commit_merge().
* Rebased over Pedro + Liam's changes.
* Updated test logic to handle current->{mm,pid,comm} fields after rebase
  on Liam's changes which use these. Also added stub for pr_warn_once() for
  the same reason.
* Adjusted logic fundamentals based on rebase - vma_merge_new_range() now
  assumes vmi is pointing at the gap...

v1:
https://lore.kernel.org/linux-mm/cover.1722849859.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (10):
  tools: improve vma test Makefile
  tools: add VMA merge tests
  mm: introduce vma_merge_struct and abstract vma_merge(),vma_modify()
  mm: remove duplicated open-coded VMA policy check
  mm: abstract vma_expand() to use vma_merge_struct
  mm: avoid using vma_merge() for new VMAs
  mm: make vma_prepare() and friends static and internal to vma.c
  mm: introduce commit_merge(), abstracting final commit of merge
  mm: refactor vma_merge() into modify-only vma_merge_existing_range()
  mm: rework vm_ops->close() handling on VMA merge

 mm/mmap.c                        |  106 +--
 mm/vma.c                         | 1297 ++++++++++++++++-------------
 mm/vma.h                         |  152 ++--
 tools/testing/vma/Makefile       |    6 +-
 tools/testing/vma/vma.c          | 1302 +++++++++++++++++++++++++++++-
 tools/testing/vma/vma_internal.h |   51 +-
 6 files changed, 2217 insertions(+), 697 deletions(-)

--
2.46.0

