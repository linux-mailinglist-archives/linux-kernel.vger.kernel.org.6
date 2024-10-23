Return-Path: <linux-kernel+bounces-378566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCF99AD264
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245731C211A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735DF1CCB3A;
	Wed, 23 Oct 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GWi6sTyF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q4k2BzIP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC721C9EAC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703998; cv=fail; b=PYr3T1XVQtj6O1TnEmEonLdQqxZiyJ0JA0XSUMyA3CO0bzeWwg0chuzblDQmcnFsdyZNYcbMeMdZP/Xpl/gchTpdf3ltlULCi9RnLPq7PfpUNM0iHZMDRQiPQPdh8oZJdO1Ao+EJElAW2CsjPkNbm2Lhf2jslLfsPDnV0onDB2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703998; c=relaxed/simple;
	bh=qGbi4TLEg4tuHcCsgOzVucBv2FK776cmC7A5uy7WJzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gRsNfcleTir+M/xGKkEd9b7Kw5747QCl/96b0Th+zvt2RxQBc/fJ9A4ncmRsEM5fU9I+aOhSv+gxifVCbcZ6gFC3Vkt+XY0RDdwlv1UjeTth7EgF8KUSWKm/98/Rf8UaE2S+UGrJy2mWoYGOodT5E7VOZ13Q4PYTVx9ZvaFYPkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GWi6sTyF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q4k2BzIP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfeCw011111;
	Wed, 23 Oct 2024 17:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WTkhOLbNLAQlyVWiIU
	PgywvBm8XxMo4fUB01FJaJtVU=; b=GWi6sTyFyRDoTB5+SLEAdOTApqzcmKdQmS
	PRk7fxTkRxSPBlmZyx/6RIXH87mKQl5jnghEyZKMmXU+ZG1VEGGMt5CAAPDNGJDJ
	9X/bPcYpQAUuT7KrN3YgdrdDjbkERAAVxQk0+2gSy1HRncyk/+HzXTlpZTjx5mxp
	d0luvNHDLaQvmeRw8KrTRfHqdWC3PArwlqTtClkB1E6HJOiHyi+73gmnpCMjb9pr
	scsdts2QkguAfjmzhZxEa20EfpV0AephjeKhNfAv7hdxndWHoiPGNMlR05ZlDE79
	GVfM/bEoF7V/n3AXIQHHl+KCEn8B515R64vlCazsoTC+QoQRNq7Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3fueq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:19:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFrE2O027526;
	Wed, 23 Oct 2024 17:19:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh34bn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACcLf6qK+avujADa3przI23yh0DWFU/W5lynlxiMxilTiSk1OQvR3ZuutWfI4RZt43UjT7M/cKDJQ62x8NaHfLllhhu2fYCKl8rW2s1bXyuvr7WJ8jOscHfQEMBQdogBBPAMPJlhjUVYZ6SaKqPn+pmhpHxkKarAzCK4lJ1CToJR72WEm/K+HwSEYgxRPftNZni7KZ5suv8PsTsBTefw4BRrCXeV4mks5WP1C4ClngrCWFCid03sBF7rtXEmPyLbxfwylDSEc/vISdvLYiOTpU5nKuwJC2j1ZT4wLsqja8cfnrcZLcXTWtfHKo/wcMrHVulLGZMjf6XQ0topIV1FKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTkhOLbNLAQlyVWiIUPgywvBm8XxMo4fUB01FJaJtVU=;
 b=u7evbH8U1bbEAzsUNcYcNebBGbcfPsRZxYfoCxjta2RbPhoqh+3H8hTeSRNIXJnLjje05kgdFU2OJpu7f29PPlitvp6Xdj3N6kdQgWZtf8y4LDeIJfXu04wmgmLCLzb220lqCNWYFAmzBOKw3mqDRUkKnqrTkLqmnZPoCu3AHcK4zP0HG3x1DEX8CS7ovBkf1qtQfLOzFvjfam3LAVNqjhKdrLYSZpItWxDeA+kvy2er3CytQWMROQAxnlEhjfZUAfoJOo6q27KVdJbqzJhQlY0deubYuvUi/ckCvivbvva5ptvXZ23eJ4pPDUuWYS0RfVjofgoH33iV5JqOXJ6Yxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTkhOLbNLAQlyVWiIUPgywvBm8XxMo4fUB01FJaJtVU=;
 b=Q4k2BzIPMIq0sIWCimGwrhhL37n7z6ryD95XxD7zhnt/xbN33YmvFbeGLLGgW3yPbz4HpRQWLIWUpxaXyxnxwKN6YlnPPhum2XN7uXZsbvI1m/P552slpgBA5GGfUbTvY6PVGlieCGvf7EV3WHClDYI/B8dskSjI776cSa5XoJE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 17:19:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 17:19:37 +0000
Date: Wed, 23 Oct 2024 13:19:35 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 7/8] mm: refactor __mmap_region()
Message-ID: <zbv5u5rqlny4l77n2be4eyh32nkojjbnyy6j5ve4uv2x7pynqp@v33tjz73yeyf>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0371.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f98af4d-5563-478e-13e8-08dcf386df20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uOC9pVJ3F7+PEnY3XuIv7Rsw3T+l8Q/jgklcLG3MXZQVNsaod4MM7CVpqt8g?=
 =?us-ascii?Q?BFheUBCsl7AQbRIQX9iEJ1v+VyKTG6VujXqRYiEglKEuyN9rF3xgLPryaXmA?=
 =?us-ascii?Q?Rfc55ERzjK6kZe/rbubhsRi5Ke3WqSp8YYjlHAly5ITgHUIcDqGYQ6LSAFEz?=
 =?us-ascii?Q?xAloj021LMOD44+ncs0N3i7toLPC3yBlV8xt1xS0ozSvC68N0J1b6iYMpnC8?=
 =?us-ascii?Q?lvirVnBA6krbgz3khUzb5+CE87TyCEDgvvK88sC7sxjzr885VyNx09xxZ1QO?=
 =?us-ascii?Q?qQaruwP7PXKIsGnDp+fgGt/dMjnBLWNLrUh7Q6xiv6Vw821SI7Z2fP0+KQxL?=
 =?us-ascii?Q?i+wTXSTXswf13YEp44MWwAACd3P5bM0ADHxJfxmXtc4pR3yQWAfVsDI19snK?=
 =?us-ascii?Q?KiyNpSeLaTWG5vHizYXYpVF0ecsu4H4LcqUJlgsS3YA6MD7d6yiKzm/Q1OSD?=
 =?us-ascii?Q?zQXuL9xJxA4BPbIXdH1BXtKWijPOu0ShPx0LfsJJ0DFDraUiU7pnAf31OHrw?=
 =?us-ascii?Q?9vBpkv9p+8JjloyBLIQA525r2pRUo8wUii5cvGtTdNi+OOZtm3RfKUI6M36k?=
 =?us-ascii?Q?zIf1eEM6DLJ3SAdEB2v8HnTySty5PUKISo55+4t+QKxaHn+pBoce3uLmwlgU?=
 =?us-ascii?Q?ZxW0rT/ODY/j8CDNeWMPR5TGJX6KSi2vzyStfyEYMyhS/782ZLriYCFBhdIm?=
 =?us-ascii?Q?mKDOQ/YknK4SZDcpsyzt3sjPK0NeBf37BFKnGA3nPhZGGGIBSr/dUCuIDOdK?=
 =?us-ascii?Q?l66fZExRctSnDaoZ1EtOVbLRNXU/hEUVdWQin8RjWaLnIR/TUFn4cJVXskPo?=
 =?us-ascii?Q?eL0qXyM2JkpDQUeIiy/MUqy9Ao5GI9JGdhkF8HdBA+4z4/8wp2WfCYBWqvy6?=
 =?us-ascii?Q?3s9oXKgxVP9NaItshSc5eoYtIkdPRhAuYWyeql+3P1CfpccriqV3AVgSdLQ+?=
 =?us-ascii?Q?sjXpXxTB9/6d2Hhq2x17csNuDNOykP9L809IoYR5QQoTyiyLbHriUoh282DI?=
 =?us-ascii?Q?HTz2PIEInsxw3b9LB0z7CByhsmDIKXqa6GqmdfZY0tK7u3uqZKig2o9MGm//?=
 =?us-ascii?Q?R1EtShuUexerQ4jEV8ewdGcTEm4wK+mbs3MJA43MeSStS5pmPUBAPQ2qsZqv?=
 =?us-ascii?Q?jQ/BRr6gE8kTO1VmkknD5nmKyl9zC750n4rvW5ZVPevjed6dMK1wRL4Mxp9V?=
 =?us-ascii?Q?BrghtcvJMqN7dk8wauQFRhFU4KiKYnppxRc0GAKLO2GCP2L9IEPserRwWppq?=
 =?us-ascii?Q?S1+lReGHxwxwCpC6ko2Q9aYgeSsK+zBnfpHgAjOE7Z2RyQ5a8XnCUpHYEhZ2?=
 =?us-ascii?Q?Lh6Gm9CfUqDzaaOCZ+p95OFF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZzcgQZW6+W7qtoDsocvPJDniEydgzj8IlxpdvWDchj8aM853MfBjvTmXWl7G?=
 =?us-ascii?Q?Ct3YKlG1/+j2wjgTZtbOk6GCfXv4OLABRtln0QgW4ssheAZaVl6CMPQuf03C?=
 =?us-ascii?Q?ex0YBK5JT9iDnwACFDNK7khfskbQ91FNn5HC873Rm2blzDEueHIrrBwjdxyo?=
 =?us-ascii?Q?DXQWw8VrHQ2E9ZILH61bDnNgba7mcqGsP/xlKH9Qd0o4635L9aCM2USqU/zx?=
 =?us-ascii?Q?miZ7ArTc8KuStwsK1/UQOrHHOayJtaUXFr4gjWgVO3yXZd1anayqX6GivNls?=
 =?us-ascii?Q?+uPbAiw2EaIVGNwIEp38TtTSknslbbpl7w3x1Jzj4QtPszls6VWNAYybcFpL?=
 =?us-ascii?Q?84Hj6gRslRYURHGTRDI24BRkzzgsm+t0mvX0LyPusCQBVUhfz7RADaW6thyy?=
 =?us-ascii?Q?pCglXTezUtdeZ/E084n+H4hZ/Dk4VZ4VgTpW1sTKgXvMSdw2sbvGjvPYJOmo?=
 =?us-ascii?Q?yyvvF2mUGjcyR5aobI1JXmhDhKnnPDm0UqARm+rDIXzPkBUyAs0wbHbFADQZ?=
 =?us-ascii?Q?7jSp55dvECMeDH1FDeFLJc18cnaxBQmoUUuA17yWdlmDUyYJdwLo1PJDjyQV?=
 =?us-ascii?Q?qSP/h1QyUAq+SZOyG8QM8ZocRq4Ejeu4UsgYRFJIR51+HsWI/6S2pZudiaJW?=
 =?us-ascii?Q?QRPuLOXMxvHy6pfAgAVmmxAW7oK9uBZcJIuflX3vadKMRtceTZ+xv8hBGYoM?=
 =?us-ascii?Q?Lgk61mgiypM8xUrlbPh4MRbam5EEr4zx60eN40Ra0hpD1+VOBeBZQzrCHWRF?=
 =?us-ascii?Q?6C8tQCNdAyhI0pPPuPGQ2eRvQblaLOq4URvQUKBo37lYCKjxd0S9khMRxKh8?=
 =?us-ascii?Q?zaHDxxsKuTW5vqghNXkyykFSpSrP2fTplx1E/VcruPywTPLL46Ylff3l5xiF?=
 =?us-ascii?Q?qsDVwUSY8c19dfnpxTINl83E4TVBXrZYYW0tlWz1EH25Je52mPNhb2o/O63p?=
 =?us-ascii?Q?IwOrzfJBHn/1DTGQ82IvdBSGcJsj68tfFGlxp2r3uwP4QbOWdEWEBi5uFM0h?=
 =?us-ascii?Q?lng7j356a3m79YE9WBXGCcxts8RygE4GICvVAf0IZY6N7pxbbFBAB44elSg3?=
 =?us-ascii?Q?QPr3TiasrkXbLv3f+WKBQxt92ivVtPbiUuq19o5MZSFqGhQ/NNe/nydqqztd?=
 =?us-ascii?Q?hJn0cIUBXftq36T2DT1iYEAIOf+hKchyHNs/O1PAI6R/Aqv4fsQgUMG9a8ls?=
 =?us-ascii?Q?vSO85V8bBAieQyPkwJgpB/VBVLA5KldVUKCUGt5QRjB8BqB6rDq7gQwh87D2?=
 =?us-ascii?Q?oG272NybfXyzy8N7enPYOlZJmTr0qV7gKWJC+9VdnEbA2E68XrCwge0XE+R8?=
 =?us-ascii?Q?dUG4j8OfpU/bCEEam2lopjobfke99j02Xc9CtELsXSgQL6p34iNIhinngTRd?=
 =?us-ascii?Q?t5HKlElqaUdpjkwc9S8S8PIOAU1GwoTMm/59Q099tAx37a0e0mRkka6kSnbe?=
 =?us-ascii?Q?NLTxl28X9S6uIC3RBW8/TEp3dWop5+LIogsdMrRgfEbTlcZfViWLb6VVdsdp?=
 =?us-ascii?Q?IE4gfrq/kIn/wcXWFGkxIWefDI8jXIstAXYLVQC0xvnOun8vHS1+TUPZfqCQ?=
 =?us-ascii?Q?bhigB7/GulK6lYKUzP+aM0NAbp7Zy3ikQ8tUHV6B?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yf4l25u7WzlqkgOEgBiIw4LrmLw+N+UqkjD15TqJcPz+D7DAc5LZd20jHSQhryBiSj2CX5VreTdE32Jp7fYY0j2bVHc6bFql+TZf9Tz2RtvU0F+c+1rxXEtwwRkXqE0up0ahIQTUsSjrOwKef0V/mhe1YdumayGuc/wgujs8JXvROWLEv34YkrFKkP30AaevyGyZ3oLOHIzrAIITHpyX0nYPlt81IURt4eXaJzN3lPtKT0IlgYCECSBkxXfISFbg2L9XXoah4Bzqra9KmyhjJXZuJHO3GBDzBt6sDK7myjhfMXoMCgB0IxaRohg4+17yvD1aNDRwKsK9yPoaODQmz8uuAjEWZIDogVrSYjQ9jto4NXMAkGM74ye1LhZTozGIr1uLKgVwuV0s97fSBeWlNYEdqIFnvIrHvI+dI2iU2zkp7d5vTxMHJWsY4p6mxvRl4j42VEyljhdpbFtwkWgW3sxv63LiaIG8tXc7T324R6660d+4Fs7rUDBnll0fEpzv73og7qOjCo5ylGjWJT1d8bttuVubAJ1+qb4qmtD+lFdD5XiD0/UWeQx3E8gknBmAuyKJm0ZdC146eveSn7OY1lzqrW+VxKCxNq0D7JOZhxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f98af4d-5563-478e-13e8-08dcf386df20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:19:37.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g13CsWtZouoHNr0l/SJaJd3DohBicVFv8m0wmlqkNcJvZRkjqshWyreKPVYsi6+e9++Bccm28dfYik4At8uDwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230109
X-Proofpoint-ORIG-GUID: IA7MZMlx5mEB7DwfAjbmDKs4RzOjAb81
X-Proofpoint-GUID: IA7MZMlx5mEB7DwfAjbmDKs4RzOjAb81

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241022 16:41]:
> We have seen bugs and resource leaks arise from the complexity of the
> __mmap_region() function. This, and the generally deeply fragile error
> handling logic and complexity which makes understanding the function
> difficult make it highly desirable to refactor it into something readable.
> 
> Achieve this by separating the function into smaller logical parts which
> are easier to understand and follow, and which importantly very
> significantly simplify the error handling.
> 
> Note that we now call vms_abort_munmap_vmas() in more error paths than we
> used to, however in cases where no abort need occur, vms->nr_pages will be
> equal to zero and we simply exit this function without doing more than we
> would have done previously.
> 
> Importantly, the invocation of the driver mmap hook via mmap_file() now has
> very simple and obvious handling (this was previously the most problematic
> part of the mmap() operation).
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c | 380 +++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 240 insertions(+), 140 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 7617f9d50d62..a271e2b406ab 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -7,6 +7,31 @@
>  #include "vma_internal.h"
>  #include "vma.h"
> 
> +struct mmap_state {
> +	struct mm_struct *mm;
> +	struct vma_iterator *vmi;
> +	struct vma_merge_struct *vmg;
> +	struct list_head *uf;
> +
> +	struct vma_munmap_struct vms;
> +	struct ma_state mas_detach;
> +	struct maple_tree mt_detach;
> +
> +	unsigned long flags;
> +	unsigned long pglen;
> +	unsigned long charged;
> +};
> +
> +#define MMAP_STATE(name, mm_, vmi_, vmg_, uf_, flags_, len_)	\
> +	struct mmap_state name = {				\
> +		.mm = mm_,					\
> +		.vmi = vmi_,					\
> +		.vmg = vmg_,					\
> +		.uf = uf_,					\
> +		.flags = flags_,				\
> +		.pglen = PHYS_PFN(len_),			\
> +	}
> +
>  static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
>  {
>  	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> @@ -2169,189 +2194,247 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
>  	vms_complete_munmap_vmas(vms, mas_detach);
>  }
> 
> -unsigned long __mmap_region(struct file *file, unsigned long addr,
> -		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> -		struct list_head *uf)
> +/*
> + * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
> + *                    unmapped once the map operation is completed, check limits,
> + *                    account mapping and clean up any pre-existing VMAs.
> + *

nit: formatting seems wrong here?

> + * @map: Mapping state.
> + *
> + * Returns: 0 on success, error code otherwise.
> + */
> +static int __mmap_prepare(struct mmap_state *map)
>  {
> -	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma = NULL;
> -	pgoff_t pglen = PHYS_PFN(len);
> -	unsigned long charged = 0;
> -	struct vma_munmap_struct vms;
> -	struct ma_state mas_detach;
> -	struct maple_tree mt_detach;
> -	unsigned long end = addr + len;
>  	int error;
> -	VMA_ITERATOR(vmi, mm, addr);
> -	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> -
> -	vmg.file = file;
> -	/* Find the first overlapping VMA */
> -	vma = vma_find(&vmi, end);
> -	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> -	if (vma) {
> -		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> -		mt_on_stack(mt_detach);
> -		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> +	struct vma_iterator *vmi = map->vmi;
> +	struct vma_merge_struct *vmg = map->vmg;
> +	struct vma_munmap_struct *vms = &map->vms;
> +
> +	/* Find the first overlapping VMA and initialise unmap state. */
> +	vms->vma = vma_find(vmi, vmg->end);
> +	init_vma_munmap(vms, vmi, vms->vma, vmg->start, vmg->end, map->uf,
> +			/* unlock = */ false);
> +
> +	/* OK, we have overlapping VMAs - prepare to unmap them. */
> +	if (vms->vma) {
> +		mt_init_flags(&map->mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);

Nit: line is too long.

> +		mt_on_stack(map->mt_detach);
> +		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
>  		/* Prepare to unmap any existing mapping in the area */
> -		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> +		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
>  		if (error)
> -			goto gather_failed;
> +			return error;

As Vlastimil pointed out, there is an issue just returning the error.

> 
> -		vmg.next = vms.next;
> -		vmg.prev = vms.prev;
> -		vma = NULL;
> +		vmg->next = vms->next;
> +		vmg->prev = vms->prev;
>  	} else {
> -		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
> +		vmg->next = vma_iter_next_rewind(vmi, &vmg->prev);
>  	}
> 
>  	/* Check against address space limit. */
> -	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
> -		error = -ENOMEM;
> -		goto abort_munmap;
> -	}
> +	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
> +		return -ENOMEM;
> 
> -	/*
> -	 * Private writable mapping: check memory availability
> -	 */
> -	if (accountable_mapping(file, vm_flags)) {
> -		charged = pglen;
> -		charged -= vms.nr_accounted;
> -		if (charged) {
> -			error = security_vm_enough_memory_mm(mm, charged);
> +	/* Private writable mapping: check memory availability. */
> +	if (accountable_mapping(vmg->file, map->flags)) {
> +		map->charged = map->pglen;
> +		map->charged -= vms->nr_accounted;
> +		if (map->charged) {
> +			error = security_vm_enough_memory_mm(map->mm, map->charged);
>  			if (error)
> -				goto abort_munmap;
> +				return error;
>  		}
> 
> -		vms.nr_accounted = 0;
> -		vm_flags |= VM_ACCOUNT;
> -		vmg.flags = vm_flags;
> +		vms->nr_accounted = 0;
> +		map->flags |= VM_ACCOUNT;
>  	}
> 
>  	/*
> -	 * clear PTEs while the vma is still in the tree so that rmap
> +	 * Clear PTEs while the vma is still in the tree so that rmap
>  	 * cannot race with the freeing later in the truncate scenario.
>  	 * This is also needed for mmap_file(), which is why vm_ops
>  	 * close function is called.
>  	 */
> -	vms_clean_up_area(&vms, &mas_detach);
> -	vma = vma_merge_new_range(&vmg);
> -	if (vma)
> -		goto expanded;
> +	vms_clean_up_area(vms, &map->mas_detach);
> +
> +	return 0;
> +}
> +
> +static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
> +			       struct vm_area_struct **mergep)
> +{
> +	struct vma_iterator *vmi = map->vmi;
> +	struct vma_merge_struct *vmg = map->vmg;
> +	int error;
> +
> +	vma->vm_file = get_file(vmg->file);
> +	error = mmap_file(vma->vm_file, vma);
> +	if (error) {
> +		fput(vma->vm_file);
> +		vma->vm_file = NULL;
> +
> +		vma_iter_set(vmi, vma->vm_end);
> +		/* Undo any partial mapping done by a device driver. */
> +		unmap_region(&vmi->mas, vma, vmg->prev, vmg->next);
> +
> +		return error;
> +	}
> +
> +	/* Drivers cannot alter the address of the VMA. */
> +	WARN_ON_ONCE(vmg->start != vma->vm_start);
> +	/*
> +	 * Drivers should not permit writability when previously it was
> +	 * disallowed.
> +	 */
> +	VM_WARN_ON_ONCE(map->flags != vma->vm_flags &&
> +			!(map->flags & VM_MAYWRITE) &&
> +			(vma->vm_flags & VM_MAYWRITE));
> +
> +	vma_iter_config(vmi, vmg->start, vmg->end);
> +	/*
> +	 * If flags changed after mmap_file(), we should try merge
> +	 * vma again as we may succeed this time.
> +	 */
> +	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
> +		struct vm_area_struct *merge;
> +
> +		vmg->flags = vma->vm_flags;
> +		/* If this fails, state is reset ready for a reattempt. */
> +		merge = vma_merge_new_range(vmg);
> +
> +		if (merge) {
> +			/*
> +			 * ->mmap() can change vma->vm_file and fput
> +			 * the original file. So fput the vma->vm_file
> +			 * here or we would add an extra fput for file
> +			 * and cause general protection fault
> +			 * ultimately.
> +			 */
> +			fput(vma->vm_file);
> +			vm_area_free(vma);
> +			vma_iter_free(vmi);
> +			*mergep = merge;
> +		} else {
> +			vma_iter_config(vmi, vmg->start, vmg->end);
> +		}
> +	}
> +
> +	map->flags = vma->vm_flags;
> +	return 0;
> +}
> +
> +/*
> + * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
> + *                    possible.
> + *
> + *                    An exception to this is if the mapping is file-backed, and
> + *                    the underlying driver changes the VMA flags, permitting a
> + *                    subsequent merge of the VMA, in which case the returned
> + *                    VMA is one that was merged on a second attempt.

It seems all the descriptions have indented lines.

> + *
> + * @map:  Mapping state.
> + * @vmap: Output pointer for the new VMA.
> + *
> + * Returns: Zero on success, or an error.
> + */
> +static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> +{
> +	struct vma_iterator *vmi = map->vmi;
> +	struct vma_merge_struct *vmg = map->vmg;
> +	struct vm_area_struct *merge = NULL;
> +	int error = 0;
> +	struct vm_area_struct *vma;
> +
>  	/*
>  	 * Determine the object being mapped and call the appropriate
>  	 * specific mapper. the address has already been validated, but
>  	 * not unmapped, but the maps are removed from the list.
>  	 */
> -	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		error = -ENOMEM;
> -		goto unacct_error;
> -	}
> +	vma = vm_area_alloc(map->mm);
> +	if (!vma)
> +		return -ENOMEM;
> 
> -	vma_iter_config(&vmi, addr, end);
> -	vma_set_range(vma, addr, end, pgoff);
> -	vm_flags_init(vma, vm_flags);
> -	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> +	vma_iter_config(vmi, vmg->start, vmg->end);

This function is only called from __mmap_region() after an
__mmap_prepare() and vma_merge_new_range().  The state should be fine,
so maybe this could be WARN_ONs?  Although, it's probably safer to just
leave it.

> +	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> +	vm_flags_init(vma, map->flags);
> +	vma->vm_page_prot = vm_get_page_prot(map->flags);
> 
> -	if (vma_iter_prealloc(&vmi, vma)) {
> +	if (vma_iter_prealloc(vmi, vma)) {
>  		error = -ENOMEM;
>  		goto free_vma;
>  	}
> 
> -	if (file) {
> -		vma->vm_file = get_file(file);
> -		error = mmap_file(file, vma);
> -		if (error)
> -			goto unmap_and_free_file_vma;
> -
> -		/* Drivers cannot alter the address of the VMA. */
> -		WARN_ON_ONCE(addr != vma->vm_start);
> -		/*
> -		 * Drivers should not permit writability when previously it was
> -		 * disallowed.
> -		 */
> -		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> -				!(vm_flags & VM_MAYWRITE) &&
> -				(vma->vm_flags & VM_MAYWRITE));
> -
> -		vma_iter_config(&vmi, addr, end);
> -		/*
> -		 * If vm_flags changed after mmap_file(), we should try merge
> -		 * vma again as we may succeed this time.
> -		 */
> -		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> -			struct vm_area_struct *merge;
> -
> -			vmg.flags = vma->vm_flags;
> -			/* If this fails, state is reset ready for a reattempt. */
> -			merge = vma_merge_new_range(&vmg);
> -
> -			if (merge) {
> -				/*
> -				 * ->mmap() can change vma->vm_file and fput
> -				 * the original file. So fput the vma->vm_file
> -				 * here or we would add an extra fput for file
> -				 * and cause general protection fault
> -				 * ultimately.
> -				 */
> -				fput(vma->vm_file);
> -				vm_area_free(vma);
> -				vma_iter_free(&vmi);
> -				vma = merge;
> -				/* Update vm_flags to pick up the change. */
> -				vm_flags = vma->vm_flags;
> -				goto file_expanded;
> -			}
> -			vma_iter_config(&vmi, addr, end);
> -		}
> -
> -		vm_flags = vma->vm_flags;
> -	} else if (vm_flags & VM_SHARED) {
> +	if (vmg->file)
> +		error = __mmap_new_file_vma(map, vma, &merge);
> +	else if (map->flags & VM_SHARED)
>  		error = shmem_zero_setup(vma);
> -		if (error)
> -			goto free_iter_vma;
> -	} else {
> +	else
>  		vma_set_anonymous(vma);
> -	}
> +
> +	if (error)
> +		goto free_iter_vma;
> +
> +	if (merge)
> +		goto file_expanded;
> 
>  #ifdef CONFIG_SPARC64
>  	/* TODO: Fix SPARC ADI! */
> -	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> +	WARN_ON_ONCE(!arch_validate_flags(map->flags));
>  #endif
> 
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
> -	vma_iter_store(&vmi, vma);
> -	mm->map_count++;
> +	vma_iter_store(vmi, vma);
> +	map->mm->map_count++;
>  	vma_link_file(vma);
> 
>  	/*
>  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
>  	 * call covers the non-merge case.
>  	 */
> -	khugepaged_enter_vma(vma, vma->vm_flags);
> +	khugepaged_enter_vma(vma, map->flags);
> 
>  file_expanded:
> -	file = vma->vm_file;
>  	ksm_add_vma(vma);

__mmap_new_file_vma() may free the vma.  I assume this is what you
mentioned elsewhere about UAF.

> -expanded:
> +

Extra whitespace.

> +	*vmap = vma;
> +	return 0;
> +
> +free_iter_vma:
> +	vma_iter_free(vmi);
> +free_vma:
> +	vm_area_free(vma);
> +	return error;
> +}
> +
> +/*
> + * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
> + *                     statistics, handle locking and finalise the VMA.
> + *
> + * @map: Mapping state.
> + * @vma: Merged or newly allocated VMA for the mmap()'d region.
> + */
> +static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
> +{
> +	struct mm_struct *mm = map->mm;
> +	unsigned long vm_flags = vma->vm_flags;
> +
>  	perf_event_mmap(vma);
> 
> -	/* Unmap any existing mapping in the area */
> -	vms_complete_munmap_vmas(&vms, &mas_detach);
> +	/* Unmap any existing mapping in the area. */
> +	vms_complete_munmap_vmas(&map->vms, &map->mas_detach);
> 
> -	vm_stat_account(mm, vm_flags, pglen);
> +	vm_stat_account(mm, vma->vm_flags, map->pglen);
>  	if (vm_flags & VM_LOCKED) {
>  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
>  					is_vm_hugetlb_page(vma) ||
> -					vma == get_gate_vma(current->mm))
> +					vma == get_gate_vma(mm))
>  			vm_flags_clear(vma, VM_LOCKED_MASK);
>  		else
> -			mm->locked_vm += pglen;
> +			mm->locked_vm += map->pglen;
>  	}
> 
> -	if (file)
> +	if (vma->vm_file)
>  		uprobe_mmap(vma);
> 
>  	/*
> @@ -2364,26 +2447,43 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	vm_flags_set(vma, VM_SOFTDIRTY);
> 
>  	vma_set_page_prot(vma);
> +}
> 
> -	return addr;
> +unsigned long __mmap_region(struct file *file, unsigned long addr,
> +		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> +		struct list_head *uf)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	int error;
> +	VMA_ITERATOR(vmi, mm, addr);
> +	VMG_STATE(vmg, mm, &vmi, addr, addr + len, vm_flags, pgoff);
> +	MMAP_STATE(map, mm, &vmi, &vmg, uf, vm_flags, len);
> 
> -unmap_and_free_file_vma:
> -	fput(vma->vm_file);
> -	vma->vm_file = NULL;
> +	vmg.file = file;
> 
> -	vma_iter_set(&vmi, vma->vm_end);
> -	/* Undo any partial mapping done by a device driver. */
> -	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> -free_iter_vma:
> -	vma_iter_free(&vmi);
> -free_vma:
> -	vm_area_free(vma);
> -unacct_error:
> -	if (charged)
> -		vm_unacct_memory(charged);
> +	error = __mmap_prepare(&map);
> +	if (error)
> +		goto abort_munmap;
> +
> +	/* Attempt to merge with adjacent VMAs... */
> +	vmg.flags = map.flags;
> +	vma = vma_merge_new_range(&vmg);
> +	if (!vma) {
> +		/* ...but if we can't, allocate a new VMA. */
> +		error = __mmap_new_vma(&map, &vma);
> +		if (error)
> +			goto unacct_error;
> +	}
> +
> +	__mmap_complete(&map, vma);
> 
> +	return addr;
> +
> +unacct_error:
> +	if (map.charged)
> +		vm_unacct_memory(map.charged);

So this is effectively undoing __mmap_prepare()'s accounting. I don't
have a better label for it, but it's not obvious by the label that the
accounting was done in __mmap_prepare().

>  abort_munmap:
> -	vms_abort_munmap_vmas(&vms, &mas_detach);
> -gather_failed:
> +	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
>  	return error;
>  }
> --
> 2.47.0

