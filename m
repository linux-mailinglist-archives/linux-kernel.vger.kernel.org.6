Return-Path: <linux-kernel+bounces-241602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0641927D06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571B928255D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98B3137764;
	Thu,  4 Jul 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kiRzqXIO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sd6JnKsI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A303142E87
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117690; cv=fail; b=EYQ+GHkeiMiRT4A7k2YNyROubT8XMR6wflDi7ppt2F6hbXcEokmbcWLTZkyT+y0FONCyrQC87jUQtUeKFMjaLR7l3Zxh2Fq5sr7TaHT2g0X60bE0t+Zsqcjfesq8Y08go25+X4DHkT83ZZ1aGGUlR63/theQzdVk8xnYmjB+z2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117690; c=relaxed/simple;
	bh=psOkxb7iDuyI3+imAiN4r7EdGQrQ73DkMYZilaAr0AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGT/FTJfg9OLp1bL2EynMisYSckbHN86f6qv2Rll6bWsmTuXP4PbGqbss9SIMk2XvP/Q11qBmqNLhA1xbwt3SivKBVkASlesn/hMvR+TLBU+cs8XwIVx4Z4qA5Hv2gspbHq52PujVgQS2nKyRCiFOSl/KMaEw50jsYtq1fjzbzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kiRzqXIO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sd6JnKsI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Da8ew031153;
	Thu, 4 Jul 2024 18:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=XTVQda/B1LDqelqTwWuPluxnpObvBBanz2FuJ3HyIMQ=; b=
	kiRzqXIOYpX9WQvQ13iVeNa5TJP/IFvf2XAagiepAuDsMFfyCa/gT41lDaKg+WE4
	/HivymS9FELEeJW/p90fpOKiTUiXCJLwIXv4YW98UZvqrO2qzMvcdMwLNXqKnix6
	jQFX+wQWFMsa1h6FlnHTMTScAK7aAyyw8PzbLIIMTMZHvBy9JGaZjDpXmD7oATHR
	ujuTjS6IrFMlsBMLLmfgtfXrYrSalpBK4I3G5ElOGoSkGWaTiCYvfuRSd4xQWPPa
	A8hEjLxBk+qnp9bPCHewDjadjKDTvuLIs0ZPjlB+gp8ubuF61gIbCNdINnoEnesO
	HD3+GBjQhCJ+kWMk3QRwGw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vstk44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464F64KX035674;
	Thu, 4 Jul 2024 18:27:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qacuq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEAltHsR6zYig+cry4SFJKO/dp5LBE2+hcjA8yCo2q5YbRisW3ZVIFMVo8k2tbvj/iquQ07Kx8ulWYqbwd/Xt6UvSQA3JAXQejBiOrmr1ZWwh5GOq6i539vjMERIyRzUAlHUzBOiTkPogGzIE5TB0lKS5+K/0/YQ3XINNj7AJUmjtsDWxZCyY/f/W4bnByTBMZ6vZWiTgLpWRTVRlHeDsPE40t2sX8bM94AvGl7mn8ATLKd4XcTaKXdwBBoASoyWcVY+wFlVGiClP9DbhSXHMMrsMEwsViibpTk+ym1hW0QThUhcUffEHLvHCK1gIsdpfpcnZuJ+4RfiS8yRz5QGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTVQda/B1LDqelqTwWuPluxnpObvBBanz2FuJ3HyIMQ=;
 b=PV1IDo16tyKnT0iHP1SEWv6YdqjLaU8i4847uvG/X2MivRsK9yY0+Ct+wAmrBoJlV1GwCWSzQkcAbR6VHb4fzqe5Vw8WLMBRsjppKkZdUxcch4z+rgPlFwhhrQmjdhn4IvsZfr2kxHljEGtU/9DBbsi2m0z3+ZuxYyml2vlkUO3arcANeTcvD/Ng5HLmBLLLogrnpdiybvJGxK7it3YCriTYqKNdc9g0lYD3Q5XKhPph9/zAWiTQx+JY77LlQ+NiB+N1K6SUx2q3X5kc+hCC0kl9A6AHvXWbP0Wu0d9UYi99QtQMzFJaEyAdBhpS7Jwi3Tn/MIqcypHHn6h55wpX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTVQda/B1LDqelqTwWuPluxnpObvBBanz2FuJ3HyIMQ=;
 b=Sd6JnKsIWO3Ub1DCEl8PC1lVEF/InqkkQmqD73uZ6Sis+4EBGtQ6uCW/y/Y6dS5WDezwSbyuDJm3ig8X5d46TkEZr1KZpg6z2yoCvom0TlSfxIRGlG6I18q4kcI7J4o3fXDiRGczsXj4rwqd8qKC0zUgXBuQ9Z9h3TRDMNMp8h4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:52 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:52 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 14/16] mm/mmap: Use PHYS_PFN in mmap_region()
Date: Thu,  4 Jul 2024 14:27:16 -0400
Message-ID: <20240704182718.2653918-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0012.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ec7f7e-931a-4628-91ca-08dc9c5703fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NuW42Xe5BwYwx485L+Uno2nQfALzxBNbYaXzhkzDFnZv3yic78Vmhfn4qcJg?=
 =?us-ascii?Q?r++BdIu+stOwUcczJD1kSZ+dj2CdqkKF276DeXfD00pEGnTdRkHAplcwUU0z?=
 =?us-ascii?Q?ZMr5duo3JwBicJJw+PPbkwNVkmcfGikORTQp1i8aTxy1PROg/7Y61n80g14y?=
 =?us-ascii?Q?EdxucdFcJXywRpmGo5dXon8wN+ogvj6/WBDLJL++qh16TQs3k8fs+evMFnzT?=
 =?us-ascii?Q?lLSbY9YEhT4v0lu2aNVgAmWQHGpb6qTqtNatsDXyFchL6r3XCRqmGrbpbqb4?=
 =?us-ascii?Q?dMjdpop0DkJBRfnONZLQB/I6vyK2FfLcdiGIgtjE9trrXQKM52s57yiXTk1B?=
 =?us-ascii?Q?4ZNa9h7eSc9/YgyP55q2RE65+QIc0PfaDq9faH748tpXiDti4HFS2V05u2D9?=
 =?us-ascii?Q?TAWUt8dwlnmSBuusCC4AxAjglzG/Mei+SmtH98qzapEbza9GqZuVAiywp9BD?=
 =?us-ascii?Q?IgfdNQWaL8ie7P+YZBFbQw4x1lXi/DEY6gLrMID1+4UKqk/r2lm3/jjRQGbS?=
 =?us-ascii?Q?BgIloAFbOeBEKD7JR7xYk50AvLznWFrUbSqpzkQGzJ1gmUaMzWEfhnY7P33Y?=
 =?us-ascii?Q?dewpK00E+4kVhERUUt/lpVwraceAIDWlPeoZmRKz39EzZY6bb3wY6MvO9jV4?=
 =?us-ascii?Q?LtQo6vrJYg7Dv9NAZyDaPpapa9EOwyKaLHnL1IrkF7oGm+7m8z5LjfRQaBdQ?=
 =?us-ascii?Q?KXJDW4csWfHzjB3Qkxs5jKlvm/8bbbP01BmRZ4/VjWJNudrzA/ZNV9UR+z5N?=
 =?us-ascii?Q?I4/KHkrehBr5+SnlhfimT+uwSzV1AsjRojVmwasX0dP4313n0OAV+yv8jshV?=
 =?us-ascii?Q?U5ykfKhyC/9lTySPlt8XzqFpyFXiFzPnPGWlrafKG8tabyBTc4OIdFGyRco0?=
 =?us-ascii?Q?8XvtIJC+jms8ni9uv+TGLAzX0knyR5jklmx1xtiudJsqUrv1Q+mZZMPeFr0o?=
 =?us-ascii?Q?tbE/AnWS352jtYXLJhDdTlyKxL+oQgAzluSCcKjA9ESAAwxY+s2Sou/UobHq?=
 =?us-ascii?Q?U2tScVFFQOo0xmifjja07dnxUDQR6ePRcbwVQycCRf0lgk5W2GHZNbzuA+qN?=
 =?us-ascii?Q?ViL12/g+OB7WLjmx77QpfLTctbkEeDzqK7ZHS2g42aetvMeb8l7a+Wbp+rkA?=
 =?us-ascii?Q?w0eQ/6rM7x4CP3TCSDdLcjzg5f+kdg54I++RmDnt/AZCvkfpkhPwx8KgwoZ/?=
 =?us-ascii?Q?soq8z0kISBgNLAqPqTGWmnsI8My7f9zfTivuDdzxijmAjI94Iw/Gc0s9QQcP?=
 =?us-ascii?Q?KLu/f19uQumfvfg2L3PLodxqwbxFqWWOeFkHZaEpGb6tK0ki5JylVWxRP7+E?=
 =?us-ascii?Q?Ib/QElta5bZ+EkE2JK3j3v/F2kYrQewjN8K++SS9KpmnhA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o0VEtkHYdJy+3+dQ/7wqIaTg8NEFepI9DyCue3Y9rBmWsxFHnQTheYUkTxQ/?=
 =?us-ascii?Q?Uo8eFg2Q6q67n5qVGuaOoTnoKcSaQ5Be7CPN6gF+gNaCh2L1sJAINk1597V8?=
 =?us-ascii?Q?NyH67i/tP/yO+OTKVDdIWbCweaAwDLyd/o7W2fEn4qFuiAeWQYkRCfzVcoFs?=
 =?us-ascii?Q?CUe5hErPxg/h9VowzUUF/HS3uqB02cj9f2xSCmW8YIzFLD+8w4QAOGCnsdwU?=
 =?us-ascii?Q?PaA0wXXyytuBgMD9uLhK6891QTtX3DOC1aeFeNw9MMADgCDfSZ5BzmE2B0Bh?=
 =?us-ascii?Q?ZOkkqdFE+zfd1CfV/6N+n6Cfyno0tNzy2zJVg4bdct6/oDC2eRbMTyp4n6Xb?=
 =?us-ascii?Q?90GyalskahmKJtEg/xkGW0wv0k51yELCFq3xdyo7FlggiJ36QN3peVaKdNZS?=
 =?us-ascii?Q?VZ07GIQeHqK6VbvW0JE+2TZr8MYRpGZFKByx4EouRB/SW+7LgieyP+8YC2jw?=
 =?us-ascii?Q?EHSKNFHndpyoJJjbFmaiILhBSMiRuyEW8NDbYw4ds4LpidOJphC38hzJExdS?=
 =?us-ascii?Q?SnkzhUH/UC2bRPhAOcCQfIeyBy7ldCTUznj4393nU3A4qGtFVV/HZ1vRFzau?=
 =?us-ascii?Q?kHLwMDtX+LQZP1HDB2/S2cGv4bWYxDD/EgueHKwqmlQd6RTig61fUWMx0c0g?=
 =?us-ascii?Q?lGA7NwVS3qCcqq02ttVUY0/8xVT4FcuC4wyPX9px0LXL6AksGNEymuf5QL/s?=
 =?us-ascii?Q?7JCe2lTETNhYb2V3YyZNb/QBtioBmLDjjTwcECbP/WB+069I3qddMwVhkAn3?=
 =?us-ascii?Q?MzmjLnHWEaI6Aj9emw+SLUX9UM3MEiatEdZTdsoUcugihTiCHul0PBp+DzSr?=
 =?us-ascii?Q?G/oYvcIsugF3wP+qRozOfqHa9UJO/K3lDN9WhxhdtwaFkspaXCIObiFANORd?=
 =?us-ascii?Q?PTzv1aiedM5Y6uOz7EZ5ZEhOsCaTBd1IihDSUSv3bceVxfQ1Yz2OAAtmST+G?=
 =?us-ascii?Q?JRDVkgqk67XA5JxON06owTeApo2eK9j7nCwV4sr+0vCWWs4QFiu4MwpJBfxH?=
 =?us-ascii?Q?lvuI4XW8txulY49S4BjLC2ItKz7KL3g1RbSy9IKnI5JgIZp7oVWmMpFFWqV6?=
 =?us-ascii?Q?t9bguooA2WQC+7n3oL6GxkYsAveGCsMVMnGkn2Yb6oz89w60OwXMsbDNT3k2?=
 =?us-ascii?Q?sEoVfLCh05G+wzfMco6HcGxGlz7r+SMtq3UmqQrMZKdzuF0RZNmYhA7BnA2g?=
 =?us-ascii?Q?dGAorHEtQukU6fjoPEd/EjvO3Y/Y4PwU2ECs/uAW52xARguvSQFoYQwJ22dZ?=
 =?us-ascii?Q?hSr7N1kiWlyAwbJv05rVL+uW4hBZQvFh4cb07S522TXCfRk4jmJ0LzjUjfSM?=
 =?us-ascii?Q?EzYxh6ex8ARQ+f6BIjoc5ct7WbtZqmUYmUWeo7AucRuFJxsZrjtTErTHbYMH?=
 =?us-ascii?Q?LaMp8sPwaA+n+KYm5Os5r0VzSyRQe0GkVhOnPMreqL6IpHREQj8NiBSS0h0l?=
 =?us-ascii?Q?X5x9YrQdu21Lxxfv+HeEOgE3tnbqFKjBHH+MSNrujoAsApjzsL0nXjCWMbdN?=
 =?us-ascii?Q?eOkfN9uTaPY//AXu4P+jN1VyFQ2R7wZkQ1dTQ4WuuKBzwpv4vXuN2aJc2Jk8?=
 =?us-ascii?Q?hl94vKzYfMGSbQiIPzXY90fSgD12/3RjVSe7zDMwqR/I3RZncZW0cdXpU8YC?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V0jUwuaN+8Vy4CthXtMK+3eougRh1kK16l0YISsbvvwmR18ISUuS6To/fTcX2KtWC8HMbeR4tFtTfPtcXpwGnmzfY+27AtqKgQdVDKHRrKuvWBeBSdOsgu5bdY39dH2sEkr6sGdrO8HB0MvUXTKjxkMo0s01gT2raQf2O3lAJEmDaQNsJpopNhRmF3tPxuRsBn7kFOpX5Y7CsxuN0r5s848VxRIDS1LSmhzB9CX48FWWfVAzgPh+/x9S4yyAcXUvgIVFpYAK1az/fW5m1i17IXHQriRTZv88nZlPTsD4KmG4gCVGq7oxDAFXOmS0bd1GR9hrhaMtD5PN0FZWmo9j8hqZZRUEhBb4jh3Nq8r/+zpz6utMw4aURSYrWzxnSTW7a0EA6nlqoyW9NvlVFF4raPZo0LoLpckhBijVvjuVpTJaKE0tEx96SZhltNku9/i2m8e0G9bQcejkX77/6mPSCbQiCkaQpQ6waVvmYZ7fkOixUcOPZaVk7t1vZxlDNuWGEvAiZR0zB+Wakyen3cdRkgvcWKPlmi6Fz5n/szfv1sMEz34Qus5Q5Z0cAQ3F2yAkqsbaj2Fn//mUmTQ8yINJDVWT+XELTM/Qp9eyM50GKFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ec7f7e-931a-4628-91ca-08dc9c5703fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:52.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98S4yYHPB24Zr5ZxdJno0jiGI7Coz3ruXq/dtYot93AJ1FGWEH99ZLSI0i+MLn8Gxu+TySGJouUvJ2jEIgVFNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040134
X-Proofpoint-GUID: iThV8naY2yXnKOxOjPv6IdJlWPl4wiQe
X-Proofpoint-ORIG-GUID: iThV8naY2yXnKOxOjPv6IdJlWPl4wiQe

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
existing local variable everywhere instead of some of the time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0c334eeae8cd..b14da6bd257f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2935,7 +2935,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(len);
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -2955,7 +2955,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * MAP_FIXED may remove pages of mappings that intersects with requested
 	 * mapping. Account for the pages it would unmap.
 	 */
-	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
@@ -2990,7 +2990,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
-		charged = len >> PAGE_SHIFT;
+		charged = pglen;
 		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
@@ -3149,14 +3149,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vms.nr_pages)
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	vm_stat_account(mm, vm_flags, pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma == get_gate_vma(current->mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			mm->locked_vm += pglen;
 	}
 
 	if (file)
-- 
2.43.0


