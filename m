Return-Path: <linux-kernel+bounces-280739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F53B94CE62
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28072283275
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EE6191F8D;
	Fri,  9 Aug 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nABup7pD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zYt4pcO2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD819148D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198510; cv=fail; b=OT6sY3RPgVisl4S9HAGGWFWJkc2fHF6a/r2UaAplJ03zh98Qe4+27IVdaWuX8xBVoorjbxmO7Z2bwyHRLNXyp+k89er7j3H+mJ9FmmsIyRxoXYClgHa15Sn6iNgw48CO8poWtxemKOIMGCUo4IBJbW2fn4K7x/F/kZuZHvBXXGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198510; c=relaxed/simple;
	bh=Lplp8IjH9YDwa2B58GNbmFzD00Z2rK+hchOP6aVvlss=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PBB+hwk+8ThqHsradXtMjFh7wFatLXWU1AFn9zuOxDPpQnhFghXFKaLVcYiot3rkbsTMmBNxoai00G7VdkuTuc36+VKf44PqJihRFKudJMEOvH+Df4ztOVnGEXaizL0g8vXADrexeztGYJaWhJZ8vLD7TYlWlq6apTBcUNzZHik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nABup7pD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zYt4pcO2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4798fWci001460;
	Fri, 9 Aug 2024 10:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=fP5huHLC42v1dtr
	VW4bkleYnfedgHOoRm7GJ52Wp4ZM=; b=nABup7pD8UdEtXCj1jVE3Y51pc9S7w8
	9Rwj9WKirrXVse8pdKXz2x93naNOpRc358EswNOgTkFB5VovQhsBMALW4ITott1H
	Md+DBzM6FgJ7TNJ0kVjPZGlMKYlbjR+coD3dkf99zxtM1zXrCWENFtAq43Cfz7ex
	T0z5Rw2lDWca6Xy2Y2oHjdZGFOQXm/PbWQrs8no+gMbXwFhXFDCB80Lpsj8A1TsD
	sfnY6Ia6v6t82584KAKnsTWQx20ctyRR0cLFT3MDd0etWytPFVJF0i1Irt4nbQcB
	JIMoZPOsy4QyoY1hzGauX48TQkq3V9Nque7bJNSPRU3CfHQciYp1ODg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sayebh6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 10:14:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47986MBb040713;
	Fri, 9 Aug 2024 10:14:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0cumqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 10:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqTT0P10+Wu8UjrCSYtZzPp3waAWzyLsgOdhjJGkIAluZfw12UmVse+3zfV0SE3ARieI6J2gcjmQffZ1RUmVBpe00WTfj74Z3hDXMxpl8soBs8IwD/KO0D7myHhtFHes5FXARNpJXi49bWj1PCbY4/Kf1VN43rGOsc7cdffKVn7enBfLAXoWEYhosjVwTCRm7YAxV1COl2OTv180ZaJhvNHdWKYwpIDRPEbLPm3H5AEfb4EZlPUuaPp5ZhGj19A8PWdKuU/PKjCxEg7f9pfjMfUW/wEPOxSaAFkUW4jEs/ltBhL9mKha9eaBzd93MxaI+i+cq2SkNd7lnaQ/Cr4kIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP5huHLC42v1dtrVW4bkleYnfedgHOoRm7GJ52Wp4ZM=;
 b=XQha+xW/4wz+1kd7CC5FSbJwkMGjEefnd67KQxcUXruKNoaVT6aiQBj8NjBxKfPflLeJW27kBXZxc6cjWQgewX6Fkxg4RJnetvr7Efv3txQVwk0+n0mfv/F3pa4910jFQniZq/vzvRdXaCdnywR6c3OEweutTlb7VqglnX3xka3gsW+Y3wjVdHG+ynaAQ/lZxFSXYhBJ9uK2Pa5JA65lQapM2KhOqcFxbqU8QhtsL3DwRZmb+wX/kKMEtvm/iXeHvr+K1jGAaqTNj7I8fiTAWYsrcCSe4rwhJzWryOnqOuxOdK7Y65rS4eJrsW+70hDU1z5/jQ7MxNfBpeQJuDEXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP5huHLC42v1dtrVW4bkleYnfedgHOoRm7GJ52Wp4ZM=;
 b=zYt4pcO2/yajpi94n/5vG+U5yV98icYepTe0oqa5f1ivm1/v2ZKMVrnAXWMBVwl87CaFETrvYCUko56u4qL3K1fx22hh2sTy+3w/14j1kOyW3+Hp3yYMDucF9PiscvsKgVYzv1A+x47i8BKArdFyS3aYa7dikXN1gT1KMKmZFCM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Fri, 9 Aug
 2024 10:14:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 10:14:56 +0000
Date: Fri, 9 Aug 2024 11:14:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <0570a5ed-2583-4d96-9d92-95865ee65b97@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
 <28774b9d-b74e-4028-acef-5d4f09a5d36a@suse.cz>
 <dec849e1-cfa5-4a1b-820b-8dc2ee5a8bdc@lucifer.local>
 <jlie2tieccx5ulr3b77dpvw4fupeocsu4ftiuwtjkd663qkjzl@vc3imtfqgemi>
 <neghnx3e4alozuee2v7ucu5utced3olxscg7ponqtt7f3tr4cs@73az35wxv5ed>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <neghnx3e4alozuee2v7ucu5utced3olxscg7ponqtt7f3tr4cs@73az35wxv5ed>
X-ClientProxiedBy: LO2P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::28) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a517689-fc5b-442a-eae7-08dcb85c1e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kmVgoJEQDt8BXGzvhP16fzfqllablU5Pc4s/aWtZVuBJ4q5H9EaUL/WsBuze?=
 =?us-ascii?Q?HK+i8YRcHN2qsTZbKBRaz64qxIr578HfCrt83WWOc2X6nfVYbLCzwNC3qHFA?=
 =?us-ascii?Q?g2n30vKu4+AtXpp8ApLt0X5i7TsBukTb/0ipzsSglwo+TUEgfW8QbVcnHfO6?=
 =?us-ascii?Q?+NqQJeoyLrtyWkuPrvILTxhR7FWYvDu0xz0g5RmI7J8QWMPMtP+Nn+Hz2l2A?=
 =?us-ascii?Q?8/n9fChxn7OkGQBFEdk4Rz9q7TBqAC0Pa97V0T0VDHToengrRFITBrihPLmX?=
 =?us-ascii?Q?JEwg8dB7G3EV+UBMZtqkURTyJu8zLaTPTromkVTc53izCe20rYqz5jkqfJTU?=
 =?us-ascii?Q?1X3/ji30sDwwWUui1uHkWO+n5lylJHgA/peq+9Ngju9CbPr8SwY4kiaBTFdr?=
 =?us-ascii?Q?Vko3JNyM7+Ysaj3YAf6mE3Hsk79I2O6EqSy2EOLVMbkVdi+7Cm59jQgZgF5c?=
 =?us-ascii?Q?fOTlEigoqsUVf1Qq08ebgNeg6iuG4M+vSuwC1wKs3vsC7b4oMzck67sXa9kT?=
 =?us-ascii?Q?jHyeLIpIpCqDH2xzks2uxI+7vCUHzAaHVpxSt2nY2TqItvLfLz/MrpgAtvVJ?=
 =?us-ascii?Q?pn6kneXWG6tmwZ01QNWtdXfliVBQOJvj+3bba3/HDBZ0QdjVZeEG5VbLBIJu?=
 =?us-ascii?Q?JaeZAZZgHW/R92kQGV+y9EyBPMRdzGydauqLml4Iwo22W2lCH4wiTRe+4BQd?=
 =?us-ascii?Q?G40NApLoXjGvUHYStqWa3nap/lplqah/EVxErlruvYrNumI5CdQnElL177J+?=
 =?us-ascii?Q?j/Dknz8nqJ9cJ6fE39fpms2O8yHnhDmJeD1cFTogCXY6xW2BWj/ZQnFXrts9?=
 =?us-ascii?Q?aLE9CC407HCEz1GES1ZBf/VBAdexOZSIGO10jWBZ6z2lDz8/jx/FbZSMq83M?=
 =?us-ascii?Q?DbdCWCYzkqYBRsqZUHSuqoAk72NfwZcrCIrOE8obocOtpBZPtIEGcc0M77L9?=
 =?us-ascii?Q?a/yxBHAI4MOqoD+vjMN0dDWU3DOQYzuJXlTXpFejDhDdIb38MloAZuSoL+iV?=
 =?us-ascii?Q?cxNn8Fl6jzIqD6QV9PRw6MRuN3USNtw7CpKsR0y+rWXS3ffJr+WmBn4ond7c?=
 =?us-ascii?Q?rcUn1EvIMi84VxbOCeIFn3fhKWCs2Bn/jnme3QPza1MjNuXKtxEMhc5cE2oY?=
 =?us-ascii?Q?FiDLnTG+uGvCzZ1WIFct7k+Or3wNNV/JLAn7ByHMIGvNVeoStYD0b7X2YzQz?=
 =?us-ascii?Q?dm+pNYSfauI4wfKxpzTvnIDM+92c3ISOe0BhjpwAUprWAvMmnZNsizpRE6zN?=
 =?us-ascii?Q?qzDIKVwGLZNt/VI1w4LKgaXP3F1J3vyTAU4vPZXK9+Fx3Leht4iqIsHAuP0K?=
 =?us-ascii?Q?7JdLdfxdOOdiNvVsXUUjg5Y24dkG4G5OKAZosublGWxGvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6DV70eeIp1DfjgY4pBqItAa0w0AUdodUAjZktVrYaqCP/MM9zizBCtU6HPxB?=
 =?us-ascii?Q?m+0nDrozQf6MTJO3ZIBeEk5fRj5cZQcGid26LD2FXG8DbVlEFMg9fJJC+7E0?=
 =?us-ascii?Q?tYw/WCCFSByhtR8sEH1Qxj2A3ltlbJLg7BfMTcSQo0PDrHIsD9O4RL0GXXFm?=
 =?us-ascii?Q?NCy1IelX+kJDu291xAhm3bMvqu5RAxD8f5zSLCxq82vj8ruqppyyvTP3ZGAm?=
 =?us-ascii?Q?f3P71sXhQUO+zfKlXYmQQM6eoG3VHrv6UX931wZoJNwDrFWgNd841AafQX5f?=
 =?us-ascii?Q?APlNGknb3HP9krd6cvzDOWTXlR1xNwHtcqEsgArvzKVVokfkLrO7PgAEAv+w?=
 =?us-ascii?Q?/AcvCAYYGOs7Jemsiwtf5Qg0KMp/qlh4B4WcEhMKkXob3j0lLhx/C4YT0y+b?=
 =?us-ascii?Q?hqtaEqA1cF/T1Xa8fuhazcg9ESuSi7kjGnj/YLWCWDjDSZJFmtClwWNS/PHt?=
 =?us-ascii?Q?DDLnt3Rj5fwxy2F2F7uSy0sGzHQhpnp0f42WP5DMNqlxRmv6PEVQelELjiqT?=
 =?us-ascii?Q?A9ZRDb5URRxM8i9L5tP7/xjirysnzBMdDcYZPwkkHLQZqANErIGu9oMAxjhj?=
 =?us-ascii?Q?t/DJArjU6WtQsh3j9zjWiy8lSeT3NXQo0Ilelxcw8JrECIs+QUIz+5k0lyvL?=
 =?us-ascii?Q?mhbBITCDgehq+Dyya5H6jmiLqIeHSOltL81jgdsHQnqVi3vus/1MYpRbq7OB?=
 =?us-ascii?Q?0CgQptoo/O5bySDVWWHIrsQfudxT7DkyQ+HSxWzy+Eu1o/f/Zums4b1c2Qbi?=
 =?us-ascii?Q?qAAXjHlA4zgYa81hscOWdJb9aqgPLX3DLxsPZkfGBeKZy8EGxxeO63KrArJO?=
 =?us-ascii?Q?bCE8Cu6rQdmOl8hH779Vq2v9qO18RdglDhsmje6AfuK0D+x+gGiMiO83y4ke?=
 =?us-ascii?Q?sF4B152iq5h8FgP9zypjlXg7TQn6KgdNCmx6BI2YmHDnJK+mpHMbqiov4T7c?=
 =?us-ascii?Q?fqd20+jQJ+1CzACd04A2ZNlvNZJ3W9l9niZXSk0zNMSdGT/+3tG9yWN41lkc?=
 =?us-ascii?Q?5H4ASwrKOD2ciN7l5VaWcSf1hjzjZHYyPUtYEiFF0cqVpAp45DFWkTHp3QE4?=
 =?us-ascii?Q?EHnOjAP7POETuLhJbyvlHzn7VdNJ619JdYYcWxR+6wP+VYZQjRT8/MYSSYTx?=
 =?us-ascii?Q?POAZyIxQK+X6GHfxImxh3cjXFYlhloe1xXbF0pooByw3sMa1HwVnxL6c+eAv?=
 =?us-ascii?Q?L09heexuQXXTSm8SMWaaoPhiWloBHF3xh2sehUj3XuaNZ3pdfSnos4ZJ67jH?=
 =?us-ascii?Q?/5iIFSae0FEAdDeGa7NjeiFaP2tGnJUtOIpxzXUejcxPGGEp2GsXVCucznY8?=
 =?us-ascii?Q?jFZJKlSLlNU2hXOgpn0OmFeGwXT5gtPu9EVnylLJmMMATIhykvRsYAZSxuMr?=
 =?us-ascii?Q?ccBWsQC5qG2UUMFtiMW+KTVoiH8e6vMGg3H4nOjuja04ZNLeuadNotJYYfVM?=
 =?us-ascii?Q?XGkt1xRKaagLZiLH7fn7u+Jm1abFJOmLdx7zXzhH9jTNMo3JxHj1BmztydA2?=
 =?us-ascii?Q?ExoJRVzFaF8svu9sWQjjcfWwvXYeqUrCVKOTx4lpaS+WbmXhzBaSngTV7UkF?=
 =?us-ascii?Q?kpZwBgTIyysU3OdiVgYHq8Fw+3UBTygRPCz/ZIrHH5FIh77oz2j2ySkSZcvj?=
 =?us-ascii?Q?q9qbDCPh14RvHs7+TqFArQq4VBhK/UEq1Vae6jmzyxxMnhT5DOsXwprTdT4I?=
 =?us-ascii?Q?Y/RZRQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1KZwg12mRFUwVAIcF7Y+52KZdLSHqJ315ANVkN0Fy1L/nKwAAa7Cm6LhmGQZknyBWmY+NNJv/rvPqDKEnPDkVtAJfencaEVnAgOOEIZOnOkXvLmLjPNCT+IIa78FYY8LIU29AwpdPHhvEX2hRBx3rot2JiiH61KzIOHd+FMaAIi97C++HCR8529LX5PxZ5K4UXqREwo0GTuRkiHES9G0jlCIF51Ld6PhzN73sdcbIscfmdXU55yZBWvvq1PpQIlLff7NoKmpOxk7uUTNhWK4ZpbZZgZfvMpoJc5s2xOLnK7FhSwXnWqynaUVezRDbAHFnNLeN+vw9WltgwEQ0RryA+BYqCwbRj1fg+HGtNp9HHGVfGJMJhJvRGZLxmFSenHPFD/X0EfOQE741lw4gJDZPgG1YFcSivNjnEjU5FqlMbJ5M73QzLVqnnL/d/RaWjHxtTMPv9ieXvp6Sa5pWLYHVX+mXLS7/6YBWahK2UTbzRSrFpWRXoWlYitfif1LqcVm/kj8WF6Sc3rjfFWboRBvouNTgtJ32+IE0j3j5hfWZTFYl0zHJomh4VqFsTKESR5I6DkIHgFSuyqCENyqgO0SASoQcdGV+Dp7Hj+lsjgFfs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a517689-fc5b-442a-eae7-08dcb85c1e09
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 10:14:56.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRBEAcvndEhex2bhlbqzRrY2sI0+v1/KRi+TcjCBeUyMchpxxINhF1SJ5mOXyUKdT8X1RMVUu1F12Ic1iQpZ4Su/i/hZebRgN0dyducuO0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_06,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090074
X-Proofpoint-ORIG-GUID: HLu59R6tmDEua40Z9Y5_aBwI29nhxMD3
X-Proofpoint-GUID: HLu59R6tmDEua40Z9Y5_aBwI29nhxMD3

On Thu, Aug 08, 2024 at 03:06:14PM GMT, Liam R. Howlett wrote:
> * Liam R. Howlett <Liam.Howlett@oracle.com> [240808 14:34]:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240808 14:02]:
> > > On Thu, Aug 08, 2024 at 06:45:43PM GMT, Vlastimil Babka wrote:
> > > > On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > > > > In mmap_region() and do_brk_flags() we open code scenarios where we prefer
> > > > > to use vma_expand() rather than invoke a full vma_merge() operation.
> > > > >
> > > > > Abstract this logic and eliminate all of the open-coding, and also use the
> > > > > same logic for all cases where we add new VMAs to, rather than ultimately
> > > > > use vma_merge(), rather use vma_expand().
> > > > >
> > > > > We implement this by replacing vma_merge_new_vma() with this newly
> > > > > abstracted logic.
> > > > >
> > > > > Doing so removes duplication and simplifies VMA merging in all such cases,
> > > > > laying the ground for us to eliminate the merging of new VMAs in
> > > > > vma_merge() altogether.
> > > > >
> > > > > This makes it far easier to understand what is happening in these cases
> > > > > avoiding confusion, bugs and allowing for future optimisation.
> > > > >
> > > > > As a result of this change we are also able to make vma_prepare(),
> > > > > init_vma_prep(), vma_complete(), can_vma_merge_before() and
> > > > > can_vma_merge_after() static and internal to vma.c.
> > > >
> > > > That's really great, but it would be even better if these code moves could
> > > > be a separate patch as it would make reviewing so much easier. But with git
> > > > diff's --color-moved to the rescue, let me try...
> > >
> > > Will separate out on respin.
> > >
> > > >
> > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > ---
> > > > >  mm/mmap.c                        |  79 ++---
> > > > >  mm/vma.c                         | 482 +++++++++++++++++++------------
> > > > >  mm/vma.h                         |  51 +---
> > > > >  tools/testing/vma/vma_internal.h |   6 +
> > > > >  4 files changed, 324 insertions(+), 294 deletions(-)
> >
> > ...
> > > > > + */
> > > > > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> > > > > +{
> > > > > +	bool is_special = vmg->flags & VM_SPECIAL;
> > > > > +	struct vm_area_struct *prev = vmg->prev;
> > > > > +	struct vm_area_struct *next = vmg->next;
> > > > > +	unsigned long start = vmg->start;
> > > > > +	unsigned long end = vmg->end;
> > > > > +	pgoff_t pgoff = vmg->pgoff;
> > > > > +	pgoff_t pglen = PHYS_PFN(end - start);
> > > > > +
> > > > > +	VM_WARN_ON(vmg->vma);
> > > > > +
> > > > > +	if (!prev && !next) {
> > > > > +		/*
> > > > > +		 * Since the caller must have determined that the requested
> > > > > +		 * range is empty, vmg->vmi will be left pointing at the VMA
> > > > > +		 * immediately prior.
> > > > > +		 */
> > > >
> > > > OK that's perhaps not that obvious, as it seems copy_vma() is doing some
> > > > special dance to ensure this. Should we add it to the ASSUMPTIONS and assert
> > > > it, or is there a maple tree operation we can do to ensure it, ideally if
> > > > it's very cheap if the iterator is already set the way we want it to be?
> > > >
> > >
> > > To be fair this is something that was previously assumed, and I just added
> > > a comment.
> > >
> > > Will add to assumptions, and again I think any assert should be done in
> > > such a way that under non-CONFIG_DEBUG_VM nothing happens, maybe
> > > VM_WARN_ON()?
> > >
> > > Will try to come up with something.
>
> Something like:
>
> VM_BUG_ON(vma_iter_end(vmg->vmi) > start);
>
> > >
> > > > > +		next = vmg->next = vma_next(vmg->vmi);
>
> and:
>
> VM_BUG_ON(vma_iter_addr(vmg->vmi) < end);
>

Ack x2.

Thought VM_BUG_ON() was 'not done' these days though... but checkpatch.pl
has become rather hit or miss as to what should be given attention to or
not.

> > > > > +		prev = vmg->prev = vma_prev(vmg->vmi);
> > > > > +
> > > > > +		/* Avoid maple tree re-walk. */
> > > > > +		if (is_special && prev)
> > > > > +			vma_iter_next_range(vmg->vmi);
> > > >
> > > > I wish I knew what this did but seems it's the same as the old code did so
> > > > hopefully that's fine.
> > >
> > > I think point is that we are about to exit, so we'd be left pointing at
> > > prev. But since we're exiting in just a second, we want to be pointing at
> > > the next vma which will become the prev of the next merge attempt.
> > >
> > > Liam can maybe elucidate further.
> >
> > What you have to remember is that the vma iterator (vmg->vmi above),
> > contains (or, basically is) a maple state (usually written as mas).  We
> > keep state of the maple tree walker so that we don't have to keep
> > re-walking to find the same thing.  We move around the tree with this
> > maple state because going prev/next is faster from leaves (almost always
> > just the next thing in the nodes array of pointers).
> >
> > We use the maple state to write as well, so the maple state needs to
> > point to the correct location in the tree for a write.
> >
> > The maple tree is a range-based tree, so each entry exists for a span of
> > values.  A write happens at the lowest index and can overwrite
> > subsequent values.  This means that the maple state needs to point to
> > the range containing the lowest index for the write (if it's pointing to
> > a node - it could walk from the top).
> >
> > A side effect of writing to the lowest index is that we need to point to
> > the previous vma if we are going to 'expand' the vma.  The range is
> > essentially going to be from prev->start to "whatever we are expanding
> > over".
> >
> > In the old code, the vm_flags & VM_SPECIAL code meant there was no way
> > an expansion was going to happen, but we've moved the maple state to the
> > wrong location for a write of a new vma - so this vma_iter_next_range()
> > just moves it back.  Then we "goto cannot_expand".
> >

