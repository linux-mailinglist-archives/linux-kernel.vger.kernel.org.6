Return-Path: <linux-kernel+bounces-201180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D78FBAB4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00AD1F226F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B382314A4D0;
	Tue,  4 Jun 2024 17:42:25 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8A14A09D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522944; cv=fail; b=u5jh9TaSrnA0sWRC3A2toQ7QEqu5DOBYwIIf6uweeNpDXTzzsQ5fYWbGxyeyekSTD3fTnUBdN3HjdxDo7mKRbE7xPyf5cx2bov9gx9qFRig44PgvnG+4SVWmlzWWwA9biwRWez8YKyYL8lBzOEP79q0Jg3qnKtmOkQAVNpVhFhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522944; c=relaxed/simple;
	bh=jDPxcSHhXuUpaixrzhhwLoqIuF5PHG+jA1YdXTGxgwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B91kzI4/3UlM2YkFtJOgVLM/91zzpYvG7xqZ1MFQFb7T90XtnhMdpOY7OkVQtdgvKi0C4YICMwdMXcLKiI4ERmgj+4O1J9QRIK6ujUWNjlefhVATUrQ9kBHdjmuHBjOu6juC5vnGZkeJgQVB8wxP4yBiBZxU20b8ud4S/Ns/ebQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BoOW2000986;
	Tue, 4 Jun 2024 17:42:04 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DIFa12ztC6344mQoKk7BmgG7Jc7jYdExwlXq1ZppxlRg=3D;_b?=
 =?UTF-8?Q?=3DVRHgwHDUnOlAdjcyamNN7L4J37enDUziA0fG6GG9MHExQ5Y+GXnBKfCV306d?=
 =?UTF-8?Q?LVDxUcTd_KZwcMYqUUBwudfAzmSWmVkC4FLXvMIam4wINlNqEdu9Xsg7BrS9/J4?=
 =?UTF-8?Q?XCd9Okrh/aX4Wg_9coEiXr2p97FbFu4JIHYE4tuQGjKdBRzCEpqNY2VP+EzVSim?=
 =?UTF-8?Q?/3istU1abApznMkPuYTc_ewhZwaqwn5DFYZvYrPZTDJ4GXv1xJAMOYnEPIXHoWE?=
 =?UTF-8?Q?YWHf9H1y2YoQ9iCGPUyU4M9Amn_JxOXot1m2sa4d3CzORoMjlvv7hKR/j5pIxeb?=
 =?UTF-8?Q?05RiVMjbmxbsAV/s4h4YILp2bKgzreXi_Dg=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u5jg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HL73e016288;
	Tue, 4 Jun 2024 17:42:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaf2s6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkNDAv1AlDySpzbUPJZs6BXFzH04AuO6GiTScyYhJovGCIWFcHRAOadzAbg5+EhAIBWur0/tTLgp7fWt0NT2lFg4LXy1gKeRHQzgGmLevoQg3/4q1ymjAeRMGDo8teWl54M945LI/xrUiiXMHhpzy+Us6qQPAAdxG7crXohnm6yXADAeU59OlK7NIEflWIFQ0xvDSaJO+28QiY5dTvMQCTgEQT/B+AITUXwpJeb0hwM7WlSTkfLFUR/IF5Nb/3BjK7F2+pPHgOGtuPQo3CKsHRyMCwr2qzW5erpeqt8jvTWzu5uAllb9hJK7ivLGJDnQ4cRKmEVSIpa/k3SCRH+XYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFa12ztC6344mQoKk7BmgG7Jc7jYdExwlXq1ZppxlRg=;
 b=KArCMdJ9k1kT3mHnrVm3k21H0Q8xrkLybCYA57Z+JzkLMriwLUf9qw36Z7SoUagkWJT9+kwy++OXNDnC01UxuWXnLz3B6XLQKr0pjp1x8m/l+UIw4n7ImAxSvKFpwuOCba5FuGBZNhaiDIKXVknYhQX0fSpgKmfBZyGZ4c6u7at2RAUJXrETPgwQ4Fv+CPksrrOmpAY+6uUg9tKSA+OEnZMUTVoeXvm/qD8oGF35HbkIJ1aZokeUemHQF6hEjqlJUIPV2nuViBPNwz2S97VTe4O7KOapgfiq7TSf5tJl64zfuQRpQYavg2uWrVUlULcPF2Bs621bXlquPw/o3TQFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFa12ztC6344mQoKk7BmgG7Jc7jYdExwlXq1ZppxlRg=;
 b=XakMCM3AfyljSSwFBE8EYUmgdHdX51t0FwxKu3GenjdAh56c1Gt1AUBY6fw4yan7IUhA7wH9w1V67dro7M1e3kDIAi7+8HlltCNoUZiGMzUxyMox+0mKC+ihRqaTA7I6pmg0CR1dF13FyntH2VDrPLgG3vtGP4rYbZutiPyc/tw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 17:42:00 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:00 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 03/18] maple_tree: move up mas_wr_store_setup() and mas_wr_prealloc_setup()
Date: Tue,  4 Jun 2024 10:41:30 -0700
Message-ID: <20240604174145.563900-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 189ec041-9209-413c-0d4f-08dc84bda311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SPo9OZeyy2vibTrfnc1UJWiXBAXKYOOv6WP88bNYi1XrPY7HyoKT+2tdrmwD?=
 =?us-ascii?Q?/sddj09/sV77EvvqRSk90OgqAz+KO3elfxedluSZHY+SJjF35LIeuKALlXdT?=
 =?us-ascii?Q?86iNCnyULQgDvizej+nBJsDTEDH1/A6dX0rmWmnHRgSYyMnMTuW5zSrvoeFv?=
 =?us-ascii?Q?m6zN/Gzaa4S2AXo1ALSbx+D8wyqAvKRHTxYXTA47K8/0EtIbWayHFE3vSD50?=
 =?us-ascii?Q?TXQAjrQ+SAmo/8C8sp8RLX39BFA1iaMT0fKxQVLNvd2KeY5niQCaEVdwy/pL?=
 =?us-ascii?Q?HUhalON2WolT/FkvvXuhUqmylZsscFa0zwM6fHEQ8BaCFrbl8qCpEJnUDGsn?=
 =?us-ascii?Q?Y2GN2HP9fHgWokyGx9/3+RJe1gKpjZ5mNm29Sve5hnofkvAlSeCYo5uvNPE7?=
 =?us-ascii?Q?bqJ7Z4AaMGAf7f2sR3/HPnsafbUWIdBaW/K0C9OBhI2Vc47BNKM6cdxXqD70?=
 =?us-ascii?Q?Qppdmiy97L+PF6Vp6wY945qGXqxmFbZwE/bj8c6HL46oFRdjYKxgJMUG4JL0?=
 =?us-ascii?Q?CsrE4epQsMedujCfiod7T2V49beufJMc8owDpcDJvSTl8uI6afNP9k0Q++a3?=
 =?us-ascii?Q?Rz0JPFmg0G93gbje6H7igsQFy0ESZm3pUj5W8EOsMLx1e8iIz/h0DQuV5neQ?=
 =?us-ascii?Q?yu3+6fyZ4Wm6ONcbhikwPTiHLvnQr3mGESqoAds6xq1/pj0Qualvz6rAsJN5?=
 =?us-ascii?Q?O0UIyuLI3NdglPoLcyadxsVDayxpTghlhbBZ+rWNygWMzCFiK1lkAyWV+oty?=
 =?us-ascii?Q?ehHmCoPHsK2+Q2NEqOim1ZeN8mx3weIHHf9Xaq0SYnwACmOpLxxOyPWFmr5I?=
 =?us-ascii?Q?yvKl+Ow3a6+APWvAbZzshRKd0+NlRCkiyGwMD75pkquKOb20FxQRMD9DEmpo?=
 =?us-ascii?Q?2YeIB74Jn94cm4mJYDX1NJQG8VguA1A/xgPaSyk4OXvGLf+SWt5XEzHrVHtd?=
 =?us-ascii?Q?y43+XzHG346BsXc/3okiu54wKxf/FOCF+rgQ8BlBHIJtY5sZVFX7Vu8hc4MQ?=
 =?us-ascii?Q?LBXJXnqT/txhXSRX895pGTv4PWWWBu29FZSIQYnIfgOLMBM/JkA+bIddvGzg?=
 =?us-ascii?Q?WKmOPglCJW97MIlIQgKCKOiJVbhZCPyRqfDBDpOpLQRnUftz/gv74qKT3rWa?=
 =?us-ascii?Q?X48s1lEISzs1bO0URQZ03AvsU693axe3dUVVhqyV3RBeFm2uWNCvn2ql/YgS?=
 =?us-ascii?Q?6u5v/aiQqO7kmu1710fk7e9ZP7G+FQOFHuk+a3CnQzTeGDVKOiqsYjipwDvK?=
 =?us-ascii?Q?UtmV0xwMFvCmlN2KKjDtaskmzvna5SD5mau4fn9eXe4fyXkn1w5JSAS5HOSX?=
 =?us-ascii?Q?Ypo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+R+Scbix0Vxmi1exU3+pZKvVrsInYeb7iDfLg7qIMIkGsLwySm/7eyGmZJHi?=
 =?us-ascii?Q?GAOGKmiAW9yqfDy2eO9gJqz3dqGkjGZy0qT0oKTYX15yPrwQXgA6oK/wFNJV?=
 =?us-ascii?Q?9bYIz/n1/vVqDJYhhmtxsgnS6VbCZV3Ma9xKcbCPzmxXgbN7HgzXqiLS+3/V?=
 =?us-ascii?Q?+++wXod/oX2RYY6LjZShDAsimqhjd8TX53oFOCCvcQc50KgnvK8JnPeBsADJ?=
 =?us-ascii?Q?Cz0/pWx8cnMKr4bRF4XxQUqjwcBXVCnw/6zqqNFPYZmQX6HxxZOQJtq/huVe?=
 =?us-ascii?Q?G9iyYbDj0jAD8IiP+4qyjEr5SrkXYwPIjNvEGtY7xFEJQQTr42fM40ORr363?=
 =?us-ascii?Q?SUsT5DWaz7CiExzXgSwCZfmnKTxzfPn/7PhBBWzs2rdM2ua6zVPlsyiHq4Ga?=
 =?us-ascii?Q?zyUon43u2F28N1oNUJywaF/oOG7AkayPQfhj9cc5Qlqi+rSxXbZBIh+UsgMH?=
 =?us-ascii?Q?3aN2ZSD2PeMO76AfY9wsvK+7njyqimD4lbVdwjGNJUn41cKT1VsGmyO2JsdB?=
 =?us-ascii?Q?G4tXDxwn4yEh5EtHj97YKWYSxAFREcPZTH3hfYuCcjNtMQtZKNc+eT+I+ri8?=
 =?us-ascii?Q?SYuozjKiPiSoCZA0wVW3N9cH8E14aFuIBzcCiqd1EPaJzAOU6bL65PmRPJRa?=
 =?us-ascii?Q?5fLvpba8Ir7cLGol7Ifnp/GRtp528TwGIuArT7FYaSgMWZU53Swfq2tKEJiS?=
 =?us-ascii?Q?ckUEStHj16bPIgHYFPK/6RqNfK6XOK7TANDe4BTStTncVnvc1Bmz6k1gWX1M?=
 =?us-ascii?Q?Wr1DMPn6nTWwtNx3ZPyNnQpONNKbNk4VIqSgv7GPjtmJkioh0rVhzIv38JrR?=
 =?us-ascii?Q?E82HVrFA3xVJ7Uzz/02IfQ2uA1FuPcpSxDqb2w77bEFPSVsaFzJ670qDKeFZ?=
 =?us-ascii?Q?/+g1DW/zTQC6G4g70TLSSyz+tpMxDzYpHff5kNQZpefsvxYrzLdNzZIGi1Gi?=
 =?us-ascii?Q?HZyTTLKwsJ9IQDtrwj5K3tpBhJGvvg0gM+ky+scpkCaU9rlIVz7pEb6i2Mjt?=
 =?us-ascii?Q?d6i9RlCoQnxd6EDKQvnViMfbaWs3x4LNrRlEZGiMmHDrw7OtrzoRUj2bKmDZ?=
 =?us-ascii?Q?KNLapTzas8SeaXNc+fb59P6DvoI0r2pomgpQvqntifVGS3EExsTar47eXAlH?=
 =?us-ascii?Q?V6HmWFheFsvq9R552IK0Pb84ulqBREV6whpxNkSBsncJWM0dweUUcSor3KJv?=
 =?us-ascii?Q?hm1Fiqo2Cf5wfuhPMQaPIQ0aODzHRyq+3Mlk3Y6qj1d13o2gaG7xZ8fN+YA6?=
 =?us-ascii?Q?Kyu2eMO6GFaQc9GMWpA/jUekQNkalZoLvF7ZSO+cUnqGNifePd/By9YIK9k2?=
 =?us-ascii?Q?/fX1pxmCU1mqQu4qe0wlDwgG2sKKxc2puLFP/RLxHM+Y1jift6b/7ktkJ+yi?=
 =?us-ascii?Q?bU0KF4WxyeyXpfmWpf+uMpW8z42zEh7G11dMM/zbMETSWGKTtgwFNxiv+OEH?=
 =?us-ascii?Q?OeUQKwyxSp6odaB+j85Ta7BUpVuNAlwrdNmuny8QdnOluOn+tRXfswL2lY/R?=
 =?us-ascii?Q?JAdOBihAAxL0waKGNbI5aBVkpU62S3TgJHbjarcGZBZdfky+b57mMQagr6K9?=
 =?us-ascii?Q?PgrFjQkaAxsEgHMgl49t5J6/4SkFAg0tZYjk0azI1DU3Jy1Mq6qWP8h+GrMA?=
 =?us-ascii?Q?OwJD0iBzuckBnd15HjPnuFM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IF6zp7jFyF3ex5Kipyg8YGJ911Zm6xn2UjNYWoUNWQB8pw/yu+9tUvvEPulddz9XTWrGVjzO08LbDchaa2lfso2N8icmedSD5G68tZEtzebpqj2HW2rE+FJxYUxzktQb+enefU32EL0iWBd5hG48f9+XNkNzKEmhLVTbUTY8eqHyh3MUiatCHt44e9QuO7ZJj0QLN5Vu0trFHlp1n1mmJtNRx3x4HJIXtFt5+LTQ+l6DZAapzMe3ta+Buixl2v4CPQPVqsb6NrKrnZ6ZiNO+33RatokRuY20KBYYySG5whbCDpt7KqzNMvT34l8rjXp7ulPuiJdOy218WMcggaTgz6EMosqHW/oZYAS/QrAQ3FD5mGscr6YqaPOKk3FGOaDHFIteUHGBGMZULYVKqCJ0GukJ15Kn6rl8t6BSX1BxVWHXP0C4LYe3tcovnmovMQpuCW+PjxA0geyTTkfAa/vix8sClUg2zdeCcjFxgsJq9ZGP1NirRugfrVbXy2F4RSkFsJ8i3mlxd0zsAnMp8xiyL91azNWzihIdPFrYV/ZtWolLFgCokShRAfKG/gsbt9poFbjgyQ9c9bd10cKp6Got2hRkTMLhRLjoTywzccE6re0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189ec041-9209-413c-0d4f-08dc84bda311
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:00.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: od+GEj1D5yWLvI6cJ+bapcnSEOF/IM2uYF68lF2q1zsLWYThhsar5MQ7ix0NpZ7YXqeg2yQA4sRT3vKe/azmBQWJyvVsdSsqSaTa+Ma88P8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-ORIG-GUID: imfhJuZMVcmblS4F39nelFij2xIZ3W1T
X-Proofpoint-GUID: imfhJuZMVcmblS4F39nelFij2xIZ3W1T

Subsequent patches require these definitions to be higher, no functional
changes intended.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 96 ++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ccbec0f66562..2558d15bb748 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4230,6 +4230,54 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 	return wr_mas->content;
 }
 
+static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
+{
+	if (!mas_is_active(wr_mas->mas)) {
+		if (mas_is_start(wr_mas->mas))
+			return;
+
+		if (unlikely(mas_is_paused(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_none(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_overflow(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_underflow(wr_mas->mas)))
+			goto reset;
+	}
+
+	/*
+	 * A less strict version of mas_is_span_wr() where we allow spanning
+	 * writes within this node.  This is to stop partial walks in
+	 * mas_prealloc() from being reset.
+	 */
+	if (wr_mas->mas->last > wr_mas->mas->max)
+		goto reset;
+
+	if (wr_mas->entry)
+		return;
+
+	if (mte_is_leaf(wr_mas->mas->node) &&
+	    wr_mas->mas->last == wr_mas->mas->max)
+		goto reset;
+
+	return;
+
+reset:
+	mas_reset(wr_mas->mas);
+}
+
+static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+
+	mas_wr_store_setup(wr_mas);
+	wr_mas->content = mas_start(mas);
+}
+
 /**
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
@@ -5361,54 +5409,6 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 		mt_destroy_walk(enode, mt, true);
 	}
 }
-
-static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
-{
-	if (!mas_is_active(wr_mas->mas)) {
-		if (mas_is_start(wr_mas->mas))
-			return;
-
-		if (unlikely(mas_is_paused(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_none(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_overflow(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_underflow(wr_mas->mas)))
-			goto reset;
-	}
-
-	/*
-	 * A less strict version of mas_is_span_wr() where we allow spanning
-	 * writes within this node.  This is to stop partial walks in
-	 * mas_prealloc() from being reset.
-	 */
-	if (wr_mas->mas->last > wr_mas->mas->max)
-		goto reset;
-
-	if (wr_mas->entry)
-		return;
-
-	if (mte_is_leaf(wr_mas->mas->node) &&
-	    wr_mas->mas->last == wr_mas->mas->max)
-		goto reset;
-
-	return;
-
-reset:
-	mas_reset(wr_mas->mas);
-}
-
-static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
-{
-	struct ma_state *mas = wr_mas->mas;
-
-	mas_wr_store_setup(wr_mas);
-	wr_mas->content = mas_start(mas);
-}
 /* Interface */
 
 /**
-- 
2.45.1


