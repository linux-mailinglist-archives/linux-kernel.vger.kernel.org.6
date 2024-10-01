Return-Path: <linux-kernel+bounces-345566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3DC98B78E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3CE282D91
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FF18D65A;
	Tue,  1 Oct 2024 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BscV2o2b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d4GMgqqm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706E19D083
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772621; cv=fail; b=tYeMjT1THcvom6me0PPxYgSRhk0m3gBAwXDj/uzqx3Fu6Fj2MZvXrY0bEOc2AEU9XfV2enVhKzB9pJbXgwoz3KRpQwcnzdapUeKNnkaT61UvZ47eZrAJGObMlRZyupAcVN3ZsWbWr2xJPifaHn4ixFWo+IZyploTCZJqmrzSycE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772621; c=relaxed/simple;
	bh=0d5N7LPX84jjaNs6ImHjFU7lBYua5QYApRTACG7r/bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jf1aT2FRENLV0KduKHYnyAJ4RLBSOM7KOptDhKE0VLDu8WraBvi0AaXFwHmArR8cJpTM0hUuiJ1LkKUPCoMreEoLA87iIXoA+93F2RgAxLO/qB58bYTlVYZMiA9glm9gPR5/2TQr05IvTdZe1eHLlBoKklYxKEgnPsrKOn3wu1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BscV2o2b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d4GMgqqm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911tjWK029451;
	Tue, 1 Oct 2024 08:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=YheN4pN0wKTCqHF
	p2GeKvutCs/0Uermyalq5yaMQLvs=; b=BscV2o2bg2HxNhr215jy8JT2zFNGPWh
	NNKGFq4z/+8v6mgw6h4yUALM/okLWP+paUER0rad7BK0dRuKtsISMmC8gFmjho6k
	0lK+ziJAjho4QtGkLmISrt2EMJbzjdwzK+5BvhCG1axr61Z1v9wWWHBEUyQJKonw
	UcuwGRiXZwFKcgB/dYPUCG35AZdvuhNHBJBKkYDCB68TL9Prjb5gaGeXrLyCmezY
	asQUvinpeaIiWdyiSW9rMLWHu38/kAMJvtGMUWjNdsrYQI9TQJAf4zWZMnM/rn0z
	KNdn8WXXVREA0oB6JdsWxzuDi3iT07Qr1XnqC61G5LaKIufMy2YImGg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtnn5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 08:50:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4918S6RQ028441;
	Tue, 1 Oct 2024 08:50:06 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x887fg9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 08:50:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUVFHOjUjqyh1M4sTD5epgT6cML6lMcD9JL7cEkEbElR5XrJyZwrx19MTXq1ETKSfUPe/PsHoQiVKMdwzra8Z0F0mUKHqXs8FnR0jmJ1suScfCKNYagE9dS/UVvXdIEJYyoQU3Z3zyrGTfR1kBZ7SkB/Zs6rraQOxJY5ElpAHJshddNDOiL6zr6f224vxRGFLAH5Ehm68p9Bl/fA8QTawfIFFDQb7/E9RavLRl0trfU0iUhYe+ConNfgQiiRs7Syi1BN1wjmB48Q2ckZXS0pgy3ShgiYm4Pb6uWnLNbfXXKPgDJNOy4F09DQeZpqaC53Q56hZTkQQL7BFWTBilhkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YheN4pN0wKTCqHFp2GeKvutCs/0Uermyalq5yaMQLvs=;
 b=N7juHipydGDvtvm8MMY1LUDL/PTAmuvX36EaqWWKISHgz8CzrAGUjzYIcP8nmaNJQ8A/hDpVJXKmqBHg0+jtl6IOKlm6jHYm/jg/4Vne83fYxTsVTe/URovcoZFSv54TL4hutsVE87QYTy/E8waTZ7tH59/ms85buig7fKEPrHUKQNQtOgs8mzL98SCJlx1O0QVMEkhSvTVF3BpO8t3yXS7gLOf416bx/A6AjN2o2mAhsjxRMGyzfEKRNmXVw/O9QdbEnrC2/FTjyJ1CGMenWJjUcbxKBCiLBv9OUFtdPEq3LGahyGX55stVTHGvPEn/eBnoE0PkTxo+t+QtdwtKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YheN4pN0wKTCqHFp2GeKvutCs/0Uermyalq5yaMQLvs=;
 b=d4GMgqqmtr5/bnzNwA+oPzI7teDaR4JaYWYQOCR9aZB9+2TQTeDWC4yUJm0rlsycc5n0nSlDpCVTY/UZ1kcA4Yn6fkN2pfsJYU7cJDoEUmh4wFRRJ6KSN6XJ2Dl1FePCzg0uyr5Kl2VqEVceV/UR9jRjo2J7ANBz/kzmQEOOtb4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA3PR10MB8116.namprd10.prod.outlook.com (2603:10b6:208:50b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 08:49:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 08:49:54 +0000
Date: Tue, 1 Oct 2024 09:49:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
 <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
X-ClientProxiedBy: LO4P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA3PR10MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: fd41a5dc-7547-4c43-3f0c-08dce1f604e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rpe5PxfhnZbeNv32tQF4SOPWaukED8lLMQmDMdB/SX3JSEp+lUKY/84UnOXV?=
 =?us-ascii?Q?pXn8Gtuz7SXvUDhEuRauoMXUwUH95UW8ljnRwkh83kM/wUAedQGzSKAVrKz6?=
 =?us-ascii?Q?MWpdLS8+8JmDG8GMDuzBLHPGKHIzEiiN8xCycLD0m0FjsYbrvDBkNMwPb69d?=
 =?us-ascii?Q?bGs1ImYPbY0auX3fvr4JujqRxZWXPVPGXQApafMUJAPYoVoogMjGTUqW9lOb?=
 =?us-ascii?Q?RIYe2J7cbZeJus3/16NolNpM42ZBlj9j7jknlwWFzu99AYlEV7msWqJAAook?=
 =?us-ascii?Q?aFRFjPefWhCaDe52Q0+y+DTQ8etBmbYLrT9wtv6OdPrJm4RT09JTR3qW4qbu?=
 =?us-ascii?Q?XmDnoG3Ev111p6zfDTZvaa2kK3vz6Bh//sNtn9EtFO1/12cAT/GyJ1dtyAwi?=
 =?us-ascii?Q?KRsjYgJsjbVsHrbp7o3yFuz+DhGxQRK1cPAgZHPLW9RFpR9d0tzLH/iZhAVh?=
 =?us-ascii?Q?PB3iHSBa/kTbp9wQpk7h3wGebgh5Hm9CfRt2YkES7H+rzDCSEHuFqG6gJDdq?=
 =?us-ascii?Q?/Zbejr5QfAAx+cFx+fjL0E/hI0yN0/kEq/y7oKzuelZvy/GIA5MgOCndv3B4?=
 =?us-ascii?Q?2WDmuUtIaC7TIVMbc6h6Q7iEIh2e0JZzIda9xN8wSRpMgD3e7WE+PrvrH9z/?=
 =?us-ascii?Q?2Ek2wZL/47UFkdkXbBkZLlDivHJ0VdKySYrUR3VEhVs0j0L5Odq8nxjNqoOU?=
 =?us-ascii?Q?eoZGwiBu0PIUipZj/ryNu8V+Ps7GB7Gi20zCfO3MOPlZEOEdpn+JhDH6V1/W?=
 =?us-ascii?Q?2DjYBTT+RDGHmphxQOxJHv+kLjQGUGjQaooHFQgAL1XWawRIptN18OTlYScg?=
 =?us-ascii?Q?FA+YnvwrqX3FPQbKBHoLezh+2c7U13qc4AFKcn+9fq6cC6aUpNiC19w7zfgQ?=
 =?us-ascii?Q?7DqfYRTNHUtosRgE0mqlTEAHA1l/hnk6HA6a5T8iCsaV4H6HzPj8QxQu5VdX?=
 =?us-ascii?Q?ZAa+dIUjcfCftIPosctgKUAPkbFy0Gxxgjh9vSUXFNM7VtZGowz6o45l5kqN?=
 =?us-ascii?Q?U8rn7SDK5HdM5QsBeWG7LS9xZ8ImQ23WRj6AgYULNzFW323+nvLQ3kETIboz?=
 =?us-ascii?Q?sgM8iTzEI43RuonKxjGwX19rJr10/DxYsRxgRGt5x8X+H6PXpO1FLnCzHHVa?=
 =?us-ascii?Q?CUmRL6BNYGPjwHg8c5tHttfCL1JeD/eVts7bEHAC/26dKwqWjTXYzcqmedLC?=
 =?us-ascii?Q?vKH/nqoL0uX8h2kyN8TVulgIGDnZDrH/HDD26Fd2wdMqlwiV7/vO8h/em2i3?=
 =?us-ascii?Q?ZLMUeZ81v9ItuddDSnROrRsKyT9KFHSd27CIw8Ay4D9WQWIdCm5fQW3wdBNh?=
 =?us-ascii?Q?yZy1WfXUeQpYmuYCC9S0fh/dDIgOdh49JJHoXWTu8VIltw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nb1KEN36bJ7AbLAGJR4FCOjFji+EtyGpVOZAIFN5yeAgX4G+F1Fk2S2nir9+?=
 =?us-ascii?Q?jNQsNvIWC2/z+5M+smzaRJM/4iLPJEe5h3hE8TJD94he5GGpXcdBlt1W72gS?=
 =?us-ascii?Q?ShJbGTRC8AF9R16RAFd3lzewZBDIOQoRIR7dBVTmrQIB7r1xzj7fuCarrQPu?=
 =?us-ascii?Q?LgYqMSlMVi5+7IdYEXlbnPAXTTZX6kAdNlx0OtrQ3O8SctgLPO25rgSzd6yf?=
 =?us-ascii?Q?u6bBHYa13j5ivDB9UhaPD+Z/T7MQPHedGkxsWwj1MHnt+RedMVmJfJwHXl4a?=
 =?us-ascii?Q?QSiI8il6vv5r8TJOYd//8Szaco4PFEj2DL63Wu7H15GHousE9Rtnq1NoqCTV?=
 =?us-ascii?Q?ia3tWfXhrus4R0vtNNu7ebOGHXn0pcClmEofPOroU3BO6QFVOpJiOQuVY3cs?=
 =?us-ascii?Q?bKdTecQv9Z7Vz5ASR0rBSkeZKSdb8v9DsE+7t7qGCPrhzYvvnRYL9p+/uhuo?=
 =?us-ascii?Q?qr8XSK6RuC/+PkcLbh/u6608iyHiRPSUwovOwi1MOKnpKCaAwhS+6j9+rbaF?=
 =?us-ascii?Q?fFC8t9/YVTSt/QYruDmUEKCWv1rfZjjMLv3rDbolCvAUyvET3YUp7DCdFXiJ?=
 =?us-ascii?Q?HGA68sNfcY7bFFaXI1N1ZqIjQDVCwj7JLvOWnJHDAezoDhGpHKn/Ris7ap9I?=
 =?us-ascii?Q?gTVxdpo383+yuLBNikqE6qivPSvwKMpR0l1KyA9tD8v55YrYtUkpJLi/Yrhu?=
 =?us-ascii?Q?70+qE9ZrRdGbSluAcle8C0ErZjDPgCn/m8D8DnlCE8Xbs1moBDvez+ajA1t0?=
 =?us-ascii?Q?/+l47kmKGM0SoZgljxZ3RJcZRv8VJvnieT5lYPvJTjUvEIkEeQ4w+eYJYysh?=
 =?us-ascii?Q?vZudk1a3d5nJzuwHj1L6qZx/A+qmzzSvzIb2fl9zoprGydNJKHskUOmCBr+p?=
 =?us-ascii?Q?6MpzY8Q9JcuRA5A/6wxKodThGVuLdgkYKd8q02SjS7vDa9b15oHMm1TSC3EU?=
 =?us-ascii?Q?zJ6acgQZ8hKDUXwKkAn7uGdN+dUSFKPJvpbvtORk/bdMvFp45RpbA0p3e+L8?=
 =?us-ascii?Q?iLmH+tfyZOWEdgfux0eVhj5w7BqsReetbuDG/dJ3TKMaOy96gaLWzVdu5U90?=
 =?us-ascii?Q?KWOdknn6jG5xGrrrUleTW6Tk3ZTiW9eesrvTq93EgnnR6mcC9V2YksyohDAX?=
 =?us-ascii?Q?zwMhH26zFEmNc2AXqfiUHKkHeNMlefHxoepJ1jflQ4MnptEgsVbuJtUBeUIc?=
 =?us-ascii?Q?6TOA6WU9hvnJ8wOMlG6zxfG9W5FQAmPMg6bXsd4TxrtL97xpCrt/a94rpdNU?=
 =?us-ascii?Q?88b5X8hN/trwfTDRpiYweaDYpfAh/PHO28ST+uN47Fg1xNyPj1IPpM/Zf+hF?=
 =?us-ascii?Q?9+ha09/EtxtwU0gnbxju3ZUsdEtqiy6LUnZ1UdxGXuKOriBM2olSqz30xQng?=
 =?us-ascii?Q?T6hbA5uXlSJFkIqBPjM7cvuVphzDvtAudz1tk81+MLPBYTIDuUOTLJ4IQ2Tf?=
 =?us-ascii?Q?utdXWuNkgaw7GbJf1SthVmnz+zGxKLd5IoDR8YhdcpvvJG8H+zF2HPxQWfDF?=
 =?us-ascii?Q?JnQvkUcujJrgSTgNqIofju6S8DTsSTXj9c9y8DtUlHkaU/K/8uOfHdUKkVwW?=
 =?us-ascii?Q?KA0QbGtMDq/Wd843knG2nwPCuUhuqYZGp7yP1Pqw3J8h4kmVYNF/Xz/CX7KR?=
 =?us-ascii?Q?VVypS2stOv+/7IY/82Yv2sfQfrCLiajqI+kVcWD4u6ub2owxE98MXLFRkVfn?=
 =?us-ascii?Q?VoemxA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ieQUNhMZ3ZkUBdAW8BeVo1XPGnAUvmlFB+LLl97w55L+g+SeVOiRmejdMf62fJRVhU+zMHfgSJgFlTMZw36ta26cJ7wnVUTQQid6WNhGsSeUHDbI35Blc88v8/z//BeIYfpHCuS186PPEiBii9iejvoFg3M0nSwfbWM+IlHMGUU01C8F7PKQWwXnP/CRfuEBuycnC0eVzrCFMoX7EtmdwOlAP07czzbcz88JHipwx8y+TA5Ey4a5h65srsM8Lj2U7lt2TvlcCa4hHmtXCCr+PAu4kQtKkohPk5V0dNMSdg3rPJTHRrdA4gP391kVbl2ATV/BL7EtQv8QxIedxWwX22kplWvEW8dxDWfwNdnmGOX9t1JXVXgG4nPAZ70AUIyF9ECjmeJ3Moczfe22d7bS64qDLIbAV9lnNbD5DISftaupxHqG+0VCXj7QJ7yt6NN2wPRRn6CC1oZJQaD3XIjJtELVSKIt0zHf5iQ5cVSeZv//qOPXFztxyQKgk42AsqWfcCfttThBp4boywVRWmTQnF+MnPtUExV2NXxrfMPzGsIBTLQYm6TkEKpQOCeVoAFffyJr/jhAMsn79Iysy5jEDs5oX4Lm8SylZtWGQFSfECo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd41a5dc-7547-4c43-3f0c-08dce1f604e6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:49:54.1122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2Lre8mu4msuZdlxQT3kjd46rQfTcN4456h+dw923cSYFf5JAyUXfQTKTvLj2tRj8Ij8yOdSLBFZLfFvzE2DK6kx2Aqx1QFbBohr2yIKpKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=866 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010057
X-Proofpoint-ORIG-GUID: z3PjHfazQx2UfIlP_zHfVXmQ7Fbaqpsl
X-Proofpoint-GUID: z3PjHfazQx2UfIlP_zHfVXmQ7Fbaqpsl

On Tue, Oct 01, 2024 at 10:38:35AM GMT, Bert Karwatzki wrote:
> Am Dienstag, dem 01.10.2024 um 09:02 +0100 schrieb Lorenzo Stoakes:
> > On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> > > I just noticed (via a bisect between v6.11 and v6.12-rc1) that this patch
> > > (commit f8d112a4e657 in linux-next tree) leads to a severe memory corruption
> > > error under these (rather rare) circumstances:
> > > 1. Start a 32bit windows game via steam (which uses proton, steam's version of wine)
> > > 2. When starting the game you the proton version used has to be updated
> >
> > Yikes. Thanks for the report, very very much appreciated. Will look into
> > this as Liam is out until next week.
> >
> > How repro is this? Is it consistent?
>
> Reproducability is 100%, only the method is weird, you have to switch to an
> older version of proton in the steam settings of the game, start the game and
> then switch back to the new version and start the game again.
>  It might also be possible using standard wine and repeatedly upgrading and
> downgrading wine and (I have not tried this, yet ...)
>

OK that's good.

Actually a quick one if you have a sec - could you try the same thing with tip
of Linus's tree?

This will help eliminate any other possible cause.

Thanks!

And again very grateful for you taking the time to report this/provide details.

> >
> > Can you confirm exactly what commit you are at in the kernel when you
> > generate the below dmesg?
> >
> > If you are able to reliably repro, could you try again with:
>
> Kernel is "commit f8d112a4e657 (HEAD) mm/mmap: avoid zeroing vma tree in
> mmap_region()" in linux-next tree.

Thanks!

>
>
> >
> > CONFIG_DEBUG_VM, CONFIG_DEBUG_VM_MAPLE_TREE and CONFIG_DEBUG_MAPLE_TREE enabled?
> >
> > Might be useful to get CONFIG_KASAN on the go too... and CONFIG_DEBUG_INFO :))
> >
> > Actually CONFIG_LOCKDEP and CONFIG_PROVE_LOCKING would be handy here too...
> >
> > Very much appreciated!
> >
> > >
> > > The effect is the following: The updating process of proton hangs and the game does
> > > not start and even after an exit from steam two processes remain, one of them at
> > > 100% CPU:
> > > $ ps aux | grep rundll
> > > bert      222638  1.7  0.1 2054868 87492 ?       Ss   23:14   0:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf
> > > bert      222639 99.8  0.0 2054868 2380 ?        R    23:14   1:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf
> >
> > Is there any dmesg at this point? Or not?
>
> As long as I don not try to kill those processes there's no error message (but I
> only have let them run for a few minutes ...)

Ugh ok I'm thinking debug config options should throw things up.

>
> >
> > >
> > > When trying to kill those processes with "killall rundll32.exe", these error happen:
> > >
> > > [ T4313] ------------[ cut here ]------------
> > > [ T4313] WARNING: CPU: 6 PID: 4313 at include/linux/rwsem.h:85 free_pgtables+0x233/0x250
> >
> > That should be rwsem_assert_held_write_nolockdep() if my kernel is not too
> > different from yours, which suggests we're asserting that a write lock is
> > held and it's not...
> >
>
> Yes, that's the warning.

Thanks, that's really crazy though.

Digging further...

>
> Bert Karwatzki
>
>

