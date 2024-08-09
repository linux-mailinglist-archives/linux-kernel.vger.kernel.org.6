Return-Path: <linux-kernel+bounces-281045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB70594D24E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6003A281C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD8195FEC;
	Fri,  9 Aug 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dZoI4zRU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gc8k62FV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13D13FFC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214278; cv=fail; b=tj3540PiXPtOogUBHsGzsyvm9jToXEEyPS4xnCvxln2oo1T8mo1Vw1cYaHmuLrFZRra2nxPDjkRS237Chlyi9TGm/SLY3hniv0VpEVVn18Gd0bRhsy8nCj8QHBcMKQ79XWpQp++t72Yvh9DJqpImJym8njzjlajC+d9m0VTkvY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214278; c=relaxed/simple;
	bh=JW2Kl8q0E624bjaySZ3Qc0Wdba3xW4Z0ZQMmH5mAMr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UPKQ4oAQQDRPH+2QO+znhgBmEEWC2VwfZzKX3JxVlJ5mGkCjghEH1LZoIp7F52N/5DpGvfoIn/Kjc6B8CjgDR0kB9gEXruSi9mVFogMcq30FcKMWEVPr7FxhJPkw7GJgYL/Ibpof/EMMkNmJ8h8F7bnoTd6U9YxdnmngN4EQF1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dZoI4zRU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gc8k62FV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4798fXOb001499;
	Fri, 9 Aug 2024 14:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=zoVQ39xYUOPZTTL
	xOQZ0Ttwa/wIPg5nstM10zqp5YfI=; b=dZoI4zRUir2E5hJKVtT3s1SsVU2fcvw
	VSubHA7ksUlMrcUdJPvCgNIxiSo16Cy6r50spf/3qJYTCI3Dpk7tN1M+fzfE5yFD
	s4SlkYYW57gvkCpxmf+4acOy7SjxJzBhhVmkVhKrtXsvkAme3MHSC5pGUBXr9t+k
	40teZLsLFVTBXWcYJJ78kna6Z0FLBYh0oGgSGMmuxS3awdHxtPfnr/4rAoytQAXt
	gMONH7P2elvLAGXO/5U4NLm9BZbqbtvczqpaM3o1CKMNzxkSlPxY79Tpo5Rs31ZB
	CPDTb8eY6GzYtEK0NRy28zEyGABjdGwUytVRf/unnJrVT6rBs+M9Z9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sayebxj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 14:37:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479ESS0f040741;
	Fri, 9 Aug 2024 14:37:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0d3pq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 14:37:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNfoRDRBgLgCx4wlnCQx4ZgCjbtiJOzqpLY7rNESREtZ+PV4/cw2ECsbx1l9V6+V5dJbIEOXRTF4MakRch1Wibz4uSKsQAycR8FsNAv4XNypUOb2tcvBZAcBvloDmlE73uOvG/7HBZmFFpck4oMZBsddI+L3T0vtEoBTO0h11LURG7YlRXt05PDtc/xRSl8GTuSYuANCvghbNvQ+N1M5up2NJOpoJACM4LZA5HklCIaeFgLKVQnWhElaobNAKgQJpCbn2KXrysgNd68omv1QVLJm7i3A3H07JeuRZBfYLErXgQe+j3c+u+XLd/9HZqCrS6+MFPV/WmFNoV21/OmqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoVQ39xYUOPZTTLxOQZ0Ttwa/wIPg5nstM10zqp5YfI=;
 b=ngC1sniRnUwcKVC141sbD7uKtkmrLhbZ4fqDVTrMniQU5lmQes5FKtj4d6XPMhs2duJglQA41ObJwztUcqCa6jQo7LTrwiZyL3R8xt3fMJFHBrRGp8J3LiNRx4e5gM5Ht+9O9Y7ymnfXw9E/PuNvXHMIBOPCw0Yd/S5vd/yGApGj5RiOy/oI2ui4t2R+3yKCveu9lShvhMm5EIxt2V97DSpskd5+j2qwLMnqrga3qsOqpMKrEIPQFAOs1IT8ZmlihiptY7QZ8SM4f/fjDNG23k7BL1N4S6Hkzn3rYuddSlomqBZdRERtYe6T/+NfEMkE+fzOrtYBnEE9En2S65sfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoVQ39xYUOPZTTLxOQZ0Ttwa/wIPg5nstM10zqp5YfI=;
 b=Gc8k62FVK5ZDobNUnJmemWVFIVNxYCuE1w02THaefRW1scjgw/zWi7AYU43WgdlSAmrPI6deplVuj1iZ+VBxNzkgLMgZwnU1WzVLHnSvS5ypHD7wIUrJ0nV9Eqg1Evw7ScE5UhyyaZ+IUrvfhDYLUZxNopxNyzkkF2M7axK09Js=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW4PR10MB5863.namprd10.prod.outlook.com (2603:10b6:303:18e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.25; Fri, 9 Aug
 2024 14:37:42 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 14:37:42 +0000
Date: Fri, 9 Aug 2024 15:37:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 10/10] mm: rework vm_ops->close() handling on VMA merge
Message-ID: <5d04a880-ed06-49ff-888f-56052eb69319@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <0afd85543d46fd743c0c71b6f6520f9580174b4f.1722849860.git.lorenzo.stoakes@oracle.com>
 <46d631a3-47f6-4ea7-9a69-32bf1a3adf01@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d631a3-47f6-4ea7-9a69-32bf1a3adf01@suse.cz>
X-ClientProxiedBy: LNXP265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::33) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW4PR10MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c40816-e8fe-46d4-6aee-08dcb880d3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qA7guavpvCLdZWsC69CMxvK3X1glksQabAthlVmUnRL+4/ApL/7NIrqLvOx1?=
 =?us-ascii?Q?WSVUbgwAoAER3CFr2ZZbgntrtIZ46paaFYw9ZO+8liTPDGE0vkPDRGNivB5k?=
 =?us-ascii?Q?JYM3HAk+9KrgL9XAg2L3OS152vUJ/b3f+0taasod/p6g7e6Hf1V6vpZlkePE?=
 =?us-ascii?Q?Uwie7h7QrvOKk6suX4+U8NMgHeFcNBus2Xx57l8o8lOGoD+i35eHg5TMj738?=
 =?us-ascii?Q?QJpOVDqnJZCUipSnDnadLJphvdWEB/jDzRm61CNQweE4Y7S3ZRZ1Ke50Xy1n?=
 =?us-ascii?Q?qHUQ3foBCv8qCKvuVVk/fiaDMjinVJwzGJx0AemOUn0XmAdfk2cwiYvQIM9r?=
 =?us-ascii?Q?FSQCWNRAujlksTIBxzGjmGlYJZfxcRq6DOavJnJNRVyftl6vRHX6NrYLNMEb?=
 =?us-ascii?Q?uojya4qRIGbokZ0e4lFUTh3m/CNB/mr8kD/MYNwi+iRdKinLfKQAeoyHXIG6?=
 =?us-ascii?Q?ajsZxtxCeRo+er4AxFRC/LA7vO2KMgYxu3L3Us9YgA0wdDfcrLd7c1Cnn3ek?=
 =?us-ascii?Q?ACen8CnBi7SafP4WARZL2KoLMrRb/zNcll01nmm3B8puyi3ZkugJ6ulrpxRs?=
 =?us-ascii?Q?JxNQXO3DlFEn5lk7WQKYLgUmUECxRGz0/O8cP40rIIsi7UCbL7A9l/Ku+0MZ?=
 =?us-ascii?Q?w429rEKAvTKTuUKTY1+AIJ7/S2TM2rbFsNF78MYD4d1EN6AnAY9KgcNw7GsN?=
 =?us-ascii?Q?L9yLUEnq9NhTL9MubWq99lbLyUUk9WUkqt7xxEvA0gWv4DfBmyv+vOsYk1kC?=
 =?us-ascii?Q?FfRKGT7TEPvBZHsg/yfz5Ktcbqbm6B4jirSt5IaR5nWe1Brov3+vC/I4zCw0?=
 =?us-ascii?Q?SJHyOTEka9bssWON+A6maW3xCRt6HsOazzqkbN712rta7Rbhlxd2lqVM1AaB?=
 =?us-ascii?Q?iNy2AFRnJe0LbEi76EzxCtdRDp/vQrvDTgZe+z9ZQidzQw/QrXXEnrhvMFau?=
 =?us-ascii?Q?jwsOxvzg1yOTUz1g3SKGJ7DNvqhKoz6xI4dMdHzdQAK5vHhEnxjfAjLuedj0?=
 =?us-ascii?Q?CAULYVmYlLPlg02XL7Hppz21qjuvrd2NGaWc1DQNOgRk1zgsCy+ubDQKIKUQ?=
 =?us-ascii?Q?5gSKkJyCUrzHooPV/RgGIp0F3WQWtQZEREv0DuY4dFWKXya2edXJzEk01QDb?=
 =?us-ascii?Q?SUo2olokdQdmLUACKVTwPL+zMV6CQ36hPn9thyNEdtiuWGvE2jXwJG//Dmce?=
 =?us-ascii?Q?D4BZFr791RY2DbJ5GVGnyKRSQJ2jkbgwPoo23RKEOsJ7WLFgKihsTzODtmNm?=
 =?us-ascii?Q?x+rYW+YHdokajClIbAWrgcvP6nB0LwGMzuTFhswEWgWv/v5iRbzzWVt6a7zK?=
 =?us-ascii?Q?YuYoK5cJWXNS67GsuSxvyYpKfSropa/UzPVSjH0HaRCjSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5jWbE/SM99wEAZcZBdyz/K+TrbhChZl1Q4qiCw/Zmj/x4vUPfFeFNKZ/IDs?=
 =?us-ascii?Q?eJIBjkin9BB55yI9BPPTmtPj+kFI6S3A50QKewrPsitsEiQGPEJe59GI1IfP?=
 =?us-ascii?Q?o8MkRQXfwq0bTa/JGPPmk6MEwWJPvOG6HLnqTACaKYI/7uVrgkyckOn5Hwbk?=
 =?us-ascii?Q?/XWi9csYVUeftbPK4lS4XXNv7lk4tSWZbTGeJklntvaMs5Mze4vVRwIEF9tD?=
 =?us-ascii?Q?tIpIP3EnQJwNZ0DeqiJe0sc3Tyba48UhxahL0f4KfeWUWbIN4KN/MbCOXB7X?=
 =?us-ascii?Q?bmQK0P0fUH3EzVqQApxFZ4z13/NlR1L5YpWVKMlFJR7GKVeJ4uKpbo2WvuLO?=
 =?us-ascii?Q?jnOp/xdtTwsMXlfkDn8MziL6yUq4Yozlhw7v8ApfQLw+KvMcSshFKfoL+FYe?=
 =?us-ascii?Q?2HvZnUAwRBQHZIk/UVmv0VphFOh1sVtwRi+orM9OlZk4Dl9J2xTTTVIIcLOs?=
 =?us-ascii?Q?BX2SpQ0hv81WIguRngRcG210H5uqkt8JY3tCDdAjywjyhEgk6bYDJMCoTL96?=
 =?us-ascii?Q?n7d8VFhqb6VConJefLjCXUHRTyQTrcTh7mFEo8u0Pn1jZmmrWASxtPoIPtZc?=
 =?us-ascii?Q?EvWFiN5NS1tvVzjdxMIGa3a9IoH0St1+8X7XPKTIlgF0u/t6Q3P7kGpqo59D?=
 =?us-ascii?Q?ShEcBWWrdN1ud4bnP7yH6TrdQes0i2C3wJJDXWrGNw8xLv91vDIZhBJzYq/+?=
 =?us-ascii?Q?XXqOc6zpZm1JokvuM0azYrya3N+StYEvgNWFv3aDWf1b1BjBLMQQ2RluCuvx?=
 =?us-ascii?Q?WIK4E5v94nG+EHH6asbBbOy13YKaTyppkwyJ3fCuEEO2UfOfomID3+3FfBhk?=
 =?us-ascii?Q?pDZnKLPk6b184cpPeMcS0wGwTyRlZJR3Y3F6E6UZgHbq8DJWt4UmyVTr7hFL?=
 =?us-ascii?Q?CBSDpwvrNI4eyu0jzObxz+ZQuVMteFFnNuesEmz+dix55e+Ip9V3UTtb8E9w?=
 =?us-ascii?Q?YeiS7VYzbPx6UshEFPOlLAUdhTszeZnOk0C42mh/tyl8/MLwEj1nWjSyHakp?=
 =?us-ascii?Q?MqX7YMICCW+mA7az3fLiXzfcvN+S5hET/qVGBaQRqlokcsCqMfrrLjr26i+/?=
 =?us-ascii?Q?cIQ3nyiotU0yoCpV86Q3V8Wxy9soQhqHpOJnXR+15aJ6fcTaKMYEQNL8K+LY?=
 =?us-ascii?Q?RjGqE3xFdW0ShtlWCioHpsn5Idbrl5+zsZuAx2ataAVouvCX98DcQwS7OTex?=
 =?us-ascii?Q?Wsjpu6rOZfHDZeGkTQAXrLsjKQF92f7EIkFJcGXIazZQpyfoYtNMr9S5uHFb?=
 =?us-ascii?Q?KUJ1qZINs3kOEPONjtrts+teVkjJ1wD1uuJwBBE0arhFY1q6AFgnhbq5aj3D?=
 =?us-ascii?Q?jPfvkWTVPVyRxIdSlMMR34IRIazJ0vCo2LZp/d4tu/MWGi5Aael8xaOApQ76?=
 =?us-ascii?Q?tEHFsm2DNoIPyPUGM4f3UE7Rg69/XGrSjx+vmcPZnvB4WK2eFpYfLuGcinwk?=
 =?us-ascii?Q?l2QgDvRIaLLQ73iEFUONK6RtW12WIcFPKOOCaarNYphejNMVAStTrGzl0oTi?=
 =?us-ascii?Q?EzarIHTO59PctuvIYxyoqWJ/CK9Qw7K4vAdw+yPnhLqBMPsICUnPjTHI1rto?=
 =?us-ascii?Q?+C2MmYfj+FN8B9f5cW7zOFhyum6afurqiNAl/E94ne928O0wnPNO/v6foiHG?=
 =?us-ascii?Q?wBqSkZvd4eldiMUCl4kSOV0tQBZPpcAeKzx/WN7AyWeeTfybtB0FmwXP5ebu?=
 =?us-ascii?Q?kNfzWA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vi0k328J//Nld47fXD9NqiMLEB/sV0ChQ2Yh/BiwbxmIhxq8kmAJqL+rnSthGD3EmSVrt6PpLb6VjsVfErkKy7D1SK9GJDgPI5lj5CtfABtdpNEaXkg9Tn3+TBxoLiLUze5DT+7nn+p11+P2tXW+A0C/WZQGD1GfVuW0FAubImDFWcC+hgGAz9Xeji6sfgQWCANRRfg+TenyBRcn4tmr6R6nhdDciSZq5qKHEpbVyRFFCFQjuKgwfriUdNYeh30Bxj5uUBJA68TdMiSj51wXDdWJ32ehXNNosPkbF1x2SG8SsDnL3ME+eX9HFGSfAJlZwl3iWDh4NmN9NOFJWBJWujkPKzT4eLsQK9kwsY51aOkXVRYv8RsQPERX6MsQSDltj+hnLm5qVZTXKANo4p1e+GIlwKLuhaXTzBsQ/XKekiy75N439sXAf7WjrjvTopZxWRVknhoai2cDGufpUbakkYNM6siWVmie4xdY62EYbxbwThACrCPEq5sW8C9hw3sEsgcE9euXmEGrrmdgtkZ8T8qKnvrkyn9XAOCNVxmJfAvAJZn5HbOPgzUIPyUQUAd98PiFFNjSe8fI9fyPhSkcJqtbsy8Ca1Ro832zxlI6618=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c40816-e8fe-46d4-6aee-08dcb880d3af
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:37:42.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxJlLbg0gnFLxUzgI20i0lpfSYAen4wVDV0cvDg9yilvjcRkTGbi6RSeriOr+laLyIkw7GMikqUiZODFejPXoi3FqhV7ynJHqeojRb3MS4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090105
X-Proofpoint-ORIG-GUID: FhlwZYF4XYd6l-QX6_9_KZ5xxBnRdSIp
X-Proofpoint-GUID: FhlwZYF4XYd6l-QX6_9_KZ5xxBnRdSIp

On Fri, Aug 09, 2024 at 04:25:53PM GMT, Vlastimil Babka wrote:
> On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > In commit 714965ca8252 ("mm/mmap: start distinguishing if vma can be
> > removed in mergeability test") we relaxed the VMA merge rules for VMAs
> > possessing a vm_ops->close() hook, permitting this operation in instances
> > where we wouldn't delete the VMA as part of the merge operation.
> >
> > This was later corrected in commit fc0c8f9089c2 ("mm, mmap: fix vma_merge()
> > case 7 with vma_ops->close") to account for a subtle case that the previous
> > commit had not taken into account.
> >
> > In both instances, we first rely on is_mergeable_vma() to determine whether
> > we might be dealing with a VMA that might be removed, taking advantage of
> > the fact that a 'previous' VMA will never be deleted, only VMAs that follow
> > it.
> >
> > The second patch corrects the instance where a merge of the previous VMA
> > into a subsequent one did not correctly check whether the subsequent VMA
> > had a vm_ops->close() handler.
> >
> > Both changes prevent merge cases that are actually permissible (for
> > instance a merge of a VMA into a following VMA with a vm_ops->close(), but
> > with no previous VMA, which would result in the next VMA being extended,
> > not deleted).
> >
> > In addition, both changes fail to consider the case where a VMA that would
> > otherwise be merged with the previous and next VMA might have
> > vm_ops->close(), on the assumption that for this to be the case, all three
> > would have to have the same vma->vm_file to be mergeable and thus the same
> > vm_ops.
> >
> > And in addition both changes operate at 50,000 feet, trying to guess
> > whether a VMA will be deleted.
> >
> > As we have majorly refactored the VMA merge operation and de-duplicated
> > code to the point where we know precisely where deletions will occur, this
> > patch removes the aforementioned checks altogether and instead explicitly
> > checks whether a VMA will be deleted.
> >
> > In cases where a reduced merge is still possible (where we merge both
> > previous and next VMA but the next VMA has a vm_ops->close hook, meaning we
> > could just merge the previous and current VMA), we do so, otherwise the
> > merge is not permitted.
> >
> > We take advantage of our userland testing to assert that this functions
> > correctly - replacing the previous limited vm_ops->close() tests with tests
> > for every single case where we delete a VMA.
> >
> > We also update all testing for both new and modified VMAs to set
> > vma->vm_ops->close() in every single instance where this would not prevent
> > the merge, to assert that we never do so.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Amazing!
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks! :)

> > @@ -710,9 +706,30 @@ static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> >
> >  	/* If we span the entire VMA, a merge implies it will be deleted. */
> >  	merge_will_delete_vma = left_side && right_side;
> > -	/* If we merge both VMAs, then next is also deleted. */
>
> Nit: This comment ...
>
> > +
> > +	/*
> > +	 * If we need to remove vma in its entirety but are unable to do so,
> > +	 * we have no sensible recourse but to abort the merge.
> > +	 */
> > +	if (merge_will_delete_vma && !can_merge_remove_vma(vma))
> > +		return NULL;
> > +
> > +	/*
> > +	 * If we merge both VMAs, then next is also deleted. This implies
> > +	 * merge_will_delete_vma also.
> > +	 */
>
> ... changed to this comment. Seems spurious, could have been like that
> before already? I don't see how the new "This implies" part became relevant
> now? We already tested merge_will_delete_vma above.

Will move to previous commit.

>
> >  	merge_will_delete_next = merge_both;
> >
> > +	/*
> > +	 * If we cannot delete next, then we can reduce the operation to merging
> > +	 * prev and vma (thereby deleting vma).
> > +	 */
> > +	if (merge_will_delete_next && !can_merge_remove_vma(next)) {
> > +		merge_will_delete_next = false;
> > +		merge_right = false;
> > +		merge_both = false;
> > +	}
> > +
> >  	/* No matter what happens, we will be adjusting vma. */
> >  	vma_start_write(vma);
> >
>

