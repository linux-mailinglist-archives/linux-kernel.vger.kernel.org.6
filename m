Return-Path: <linux-kernel+bounces-540523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432B5A4B1C7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3973B26F1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2951E51EE;
	Sun,  2 Mar 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bUO4AwwE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dNIyDKcc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9B189BB0
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921142; cv=fail; b=Z9MhvE+GUDrdx0OoMGvgVCp94EyVvIU1ZpxoTkCkea+Ot/NSxrcPKx+2mJpFLMZvx4aIciksxGfqV2LZ7dsDT0Tx+MQneG8JQTzIr8PKFdZ+f/MEVkmv/Js5l0+XTaFsi+lmztrxCj9SRJs+Kt1mGOBTQsQPiRRjc+WQ0+UP5bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921142; c=relaxed/simple;
	bh=4YKNvqTGKjhwORqlSYxcQzm+fSJfEviJjJg6pTWxGck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lmi/jGop0tE5GulraGKFufV641LckRbyTG3xWmBRyb1VM7Js95BXRq0ouewcFWms5X1yQmIHD4aRao1SR1HclLouzQiyJ2wlaWGt+fuzkFGg3M4oe4p7d8Olac/KurCfzxqTzjOxgoxs5FyHKG9TJJ/Fo+EfOKEPjnKDAIS5Vqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bUO4AwwE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dNIyDKcc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522BU2Qh024092;
	Sun, 2 Mar 2025 13:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SxomTDo+L3k6j2sM3JPK2JiP6EcT57DnPQlJ8ymp7Rg=; b=
	bUO4AwwE71ITQVPz4l5VXLUgc+kLYVWNDXhBWjAMFUiVGclrBzKUAcYcAI/5TPk7
	18KV6NTePB/hxTAcIVX2/QXrNaeUJ6Dq+alqSUhCjmpUQS4IBdeL4YZYpxK3TWQ2
	W4DORIOc2fu5l4OPFhQb0co25uPPpdTgYIeBwGZqQEAJ9EmO8Dn7KYHPiPA8tP1v
	g9xbywc5Q8b5PHzEIniLNEbWXZ9mMOWxLdtLIm7yoM9lo8IJPQbyEg+kCNORmmFP
	nTL8iDHQxxYrfps2myQo1Rl7HHtWQXocJYeqMj54ofCMu+IWt7HynbN90cXjt6/W
	Zi2oQOWcNYqgfzsTioropw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9q9bnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Mar 2025 13:11:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5229k1J0040400;
	Sun, 2 Mar 2025 13:11:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpcs9mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Mar 2025 13:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYEH4HPhbCj0YJPTwjU/X111MSPOzb9Y3Z+DN2pYYFq2QCFNEY1TMzZxNRpV4IlavGGEZtEKWbZK4d4rGG37uBHHYZOzNctX+WquyIpacXpE7YgWy7GpcShwTxyBPgNI9pYyHwHjWYAb61BFzJ+p6PJpzxaw8we4o9DXhBFLlxTG7Ou1SjDX6N26/BT8Yf8ep09cW+71oi8WaeF41q+QGlHBT2gcUIsS3b4wB2lALL47PBp5KpYocM0MZxHnjzDsf8U+oYTgqulomxw2lbua7cEm/eB/jguP3XKQYMhG1Tv5gkf1u7QgmaS5HzDQH2DVlWZ7V+T7SWxpm4p/2JxvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxomTDo+L3k6j2sM3JPK2JiP6EcT57DnPQlJ8ymp7Rg=;
 b=yIZt+DY7ATTv+1jmr8khfL1FafkIJD8URojo7eknaGMg5H5Xbp6jtcZC/uNvu3NKa1CGN+DtjP7CT0TZQoNOWBmO26JhTrAtY6MAwgINICp9alamH60G2YxGYHFsONsQ4ZO8L91GSUA0kI6JbmPv3XNLficPFFTzZpb3szGlHMJIC/i48zIfrJJYnv44lxdEXFDpBfGs21vAkT6Ymq55HaGsvPVaKS0hXqsLcFOkBOB8KoSMTa0yVkBykuEwQ9YbO6XRsVQ0msBINFAuNIPp59hzeQGDe1xflCq+vqofO//PZJRilQilPE5cgc1s/VOGVtBpjfUhmGNN5EQd578T9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxomTDo+L3k6j2sM3JPK2JiP6EcT57DnPQlJ8ymp7Rg=;
 b=dNIyDKccjoaPbTAoEEEFqH5iKVM8jKQQjQLHwZHj/cihmi3zRRs89hbQG19mk7nmW/7sCL9zxAPR6msXNni5inK3v42ah5IvdDvNezSpvkDqkf8iZoAaDgXDWKHRthgiSw+XJg7m49mqYHmpzp7+Sok+Z6SYLYDi+Y22t06GqKg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Sun, 2 Mar
 2025 13:11:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 13:11:42 +0000
Date: Sun, 2 Mar 2025 22:11:35 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lilith Gkini <lilithpgkini@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
Message-ID: <Z8RZB-Adxp9Lgo0t@harry>
References: <Z7DHXVNJ5aVBM2WA@Arch>
 <Z7blsPJiOPTFWEL2@harry>
 <Z7b0CvTvcS47o7ie@harry>
 <Z7iUVJA-luvNaIac@Arch>
 <Z7lLXCZB2IXth7l8@harry>
 <Z7mX6PFxUptwX0mW@Arch>
 <Z7u2jgDadOwceYeN@harry>
 <Z7xiHTN0Q5yI-UmP@Arch>
 <Z72WiUlhxOGnrXFb@harry>
 <Z8CVcNMGa7pTZvGB@Arch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8CVcNMGa7pTZvGB@Arch>
X-ClientProxiedBy: SL2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::29) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: a9318ca5-7d3a-494e-3133-08dd598bc678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWw1UW1JcW4wMUdLY3RPb3M4TDc3M3J5bkpkNEpGZmZTN1ZKbktqVnhLdUp4?=
 =?utf-8?B?S1hKSXpRUmdRdEViaE9KeXN5bFFRREExSUpyd3JGV2J0d29LRmRsMWJkMHdW?=
 =?utf-8?B?eGpoS2Q5ZHRQMFZQNUdJMkIvRVB4UTU5MnY3cUxWK2U5S05OZ2c2YVlZTFZw?=
 =?utf-8?B?dm83MkdHRjF5N1FzK21YdVVlNUNPWkFrL2xWUFdtSnUxbnhWZE8xV0J1RWtv?=
 =?utf-8?B?UUJqRGJvV2lPaU1nbW92Q3FmbVRDUEdkcVZKN2JQR2ZKVVR1bW9LZWFlTEt0?=
 =?utf-8?B?cms0MjhPY2c2bzREY2lzbDdnYVlOb3VMMXdvZGM1eW5OM1BYc3NQUDlhT292?=
 =?utf-8?B?cm45YXk5Tm9HYmx3eUxQYzVlbUpxa2QvdHVlanVlaHBsM08vRXRsQjZLN1VR?=
 =?utf-8?B?TkJRNjU3K2wyNW5KYlFOTDdHYndtZU05QzhmZ2kwd0lORlhyTGpWZ1JBSkEy?=
 =?utf-8?B?b3I5TUpLUnoxMFNlNktkZDhqRDBWY1V6VHZ2VjFubTdaMEFTdWJKWkMyR0JN?=
 =?utf-8?B?c0hNS3V4SVNrcHpvblNocXdlZFlRV1psNmsvVjI5dEx1MHAzOXdYUlFRZ2tr?=
 =?utf-8?B?ZDRwcEhwZ2lrTkdKdllJWFpMYU0vZ0RGVU80Q3NGQnpON3N2WVFqVk1iWGhp?=
 =?utf-8?B?dkphN0QzTzI3YUdRWGY3L1pSUyt0ZHFvclc0Rk93Q29HL2FQWm5PS29wc2hx?=
 =?utf-8?B?SFA4SUFyVU5jUDAvVTJKQnUvdWtiM3lsaGNXTUpFVlk5UEVYQlo0Ums4NWFO?=
 =?utf-8?B?TVpVUzVEMHplZzlJQmQ2R0RXcGlmd01pZ04xYmc2NEJNM3pOcldIMDhua28v?=
 =?utf-8?B?OHZwRzRSUUxKcyswQ0t0d3hNYlk3djNFd1dreUlxZWVJZjRuT3ZIVWl6dTha?=
 =?utf-8?B?allJTzVSeDYyUmpUVXQrdGJSTlRjb3N1Zk14M3d6MlhmY0pUeTc4czJkZW5W?=
 =?utf-8?B?UFJHTmVodGk3YlFISEFVWGh1cTBPRW5QYXNpYkZJRlpMMlNoVnNNamdYRzVq?=
 =?utf-8?B?d0pacXdsYmdjZk1OQjdGQk1taWRmWkg3VWdrTUVqMWEvWW9DT2NQeHZPM3Q1?=
 =?utf-8?B?YmNhSXhYRzMvWFA2MHprdTErUnRKQ1loeVUxa213ZWZyMk9PZkw2SEtCZFNq?=
 =?utf-8?B?cDRXM01SUTd2R2cyU0R2Q1A4TEZnZ2dJK2l5UC8yQisvYmN6T0N2Nkl3dnlI?=
 =?utf-8?B?UlVTK1pSbjNHUHJmdHRmTVNjdFR4Mlduak9McU5DMmdnenlqK2ZqWG9tZ2dj?=
 =?utf-8?B?SDVVSGdoTjM2WFlqRXZnb3p3RzJCUExEcUNrRkFOaFNoandoUnFaWWpxZWJH?=
 =?utf-8?B?end3MUpGeFh2REYyVWFCamVvbHFkQ2FpdTJWYnZRNW1YM2I0aHpOb0VBTVhG?=
 =?utf-8?B?cGd4dDREQlhzWlVXYmtTenNtUVkxZW9nTVRkRnBpTEwzWEt6dW1ta2daOSsv?=
 =?utf-8?B?T0JwdGNXV0orVm1RTUtyc2tKb2laeTZ6cDYyUVNNU0ZZWWljaDdtOVhpWGZO?=
 =?utf-8?B?SDdXVmJ5YXdHNTZrMUJTdytLRHhXZ2lpNnQyQ3RqQ2ZTVndYNXJjR0w2NjA3?=
 =?utf-8?B?MXJtai9nM21YUVhjbXpVRmxBQUh5MXVZUzRmQWFoQ1g3RmRUU2lEU0YvK0hH?=
 =?utf-8?B?VWxBMlpXcHU0eFVBQ1o2THE1OFl2bTRoUXpvalprZnNFU1p0a1U4d1I4Skda?=
 =?utf-8?B?ZHVRbW1tWGh4cU9FZSt4WDVXUlRmbTJ6ZUMrM09rZW45K09YUm9GUjh2N21t?=
 =?utf-8?B?NC8rTFpoQnV6QXZsMnFhVDVONkY2T0dXOU5GNHhtaHRjK3BHTDViaGw1QUoz?=
 =?utf-8?B?M0ZLRUVyck9iS2dQcDdqNHBoa1l1Rkl1czFYbnBnZXlmdEdkbjhnNDNMWEtR?=
 =?utf-8?Q?jS0ohs4WeU6Ds?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEx4RE50WmJXcHF5R2dVL0o3SkNWZFRhOWhSVGI1aHlKalM2SmVCM2NhQlkr?=
 =?utf-8?B?enA4ejZnN0hXNlZQR1ptUlZsZ1p0NGl3d3pTZy9HaVp0ZGc0VTJ1bE00YnJY?=
 =?utf-8?B?WlpkdjhtMm51M1h5VFg0cUdDenRoV3Z0d3FORTVqQUNFR3p1NTJYR0ZaM1Fv?=
 =?utf-8?B?b2RzemxLNkRlbnJYQWVIdnlJU0ljRmR6NHZ1VWIzY2VtNWVhSU9UajBINUsv?=
 =?utf-8?B?U1hHZ21CSk5reWgzd1pZUUxTbDE4SjA0S2tFOThBVmZJd0JPT205R3lmNDI5?=
 =?utf-8?B?b0RIdHlVYVhRaW9ldnpybHp5bWRYK2ZXRTdjSks0WHkvV1RXT3ZOK0pLbk11?=
 =?utf-8?B?MmpaY3h0OUdmblNGa2pybWRaay9vMVZxNnF6SHh6aUNWTm4rZ05NVGg1N2Vw?=
 =?utf-8?B?MU4raUlMS0xabFFHZitzczlUd1hLbnMyZ09DZkdYWVMwUlBEek9sS3Fid0hF?=
 =?utf-8?B?VXA5MG9LeXZzMnpIdzJMRk1VY0p1RE90dWErYmVNMEhZWVE1Um12R2FseDV5?=
 =?utf-8?B?MTJ2bHZZRzUxejZFS20reGliUU1WM3lQQUFHUHpnNjNNUlVzRGNmZVhSMS9t?=
 =?utf-8?B?YUNRaG4wNGFITXdjT2ZkQVBGVlhmSnNtM2JYRG5QMmlWTzU2cTlpK0FkVkI4?=
 =?utf-8?B?YkFFVGEvYmJ4ODlLYnJ6bFRidEM0ZFBQUEd0bENncFVTSW5mbXgwcVNsQ2Vj?=
 =?utf-8?B?R2JsaXowaFE0Tjk1OGdoS21oWnZBZXlGT2VtMWNZU2VxVkFrV2Rhc2RCNW1U?=
 =?utf-8?B?OGhrYXNHRytFdDBnN29UeTZsckZOS1orNGJEeUIvY00zWlBGU0pkM2xZN1ZS?=
 =?utf-8?B?UTFWb2FnWmkySDZwYzNpNXUyMnRNeUNDa09pM1JTSjBMUVE0V0hseVJVWEJw?=
 =?utf-8?B?REV1ZUFwcXdSaDV4UkRSc0JKYWNPZkRPNk10Z2pibTFhVm1LV1hObWtFYWVw?=
 =?utf-8?B?Vmc0RWNNRGRlTHBsNTdJaFpsQ2pWQVVzOXhjYTJNTmk3TktzZHhEWWdWMldv?=
 =?utf-8?B?YXR2eDVDU2k2MjNLMkVUTHpXVmd2enRHYWgvWkxnVWg1a3lvOXp5WEY2NE4z?=
 =?utf-8?B?MXdxRWQvemFWNlN2N0NJT21ySDhCZ3VBOG9lMzkrbzMwKzU0RE9aMHc2czd0?=
 =?utf-8?B?bUJIL3B1VjZHcnNlVW1VSndHYXRlbStqaldUWTJ5L3RHbGxrdjlwUHRlRmJQ?=
 =?utf-8?B?VTI5QnkzNWMzVmN2dlhWY2NjaUgxVWlHY3ZZcm44WjNpbDNOOFZpTENaNlln?=
 =?utf-8?B?SlNTQkMxMjh6TUhtZ3BVdHJ0czczeWpkeVpnM3FrdmVzeXZkRVk2NkVnOEo0?=
 =?utf-8?B?L1V3YnZlbmZHQ3Z4V0FFbHpqdzhBMC9YaStCVEs4RWtKb29rTzZpVG01Qnc4?=
 =?utf-8?B?dHZHRVBVUlZ2K3R2a3NERUI3QThjS0xFZzJ2S0J3TjJCVzNiNEw0V0k3dDJE?=
 =?utf-8?B?bGl2SnFFTUcreHRHUHY5aU5tMFlxUlFBTi9XallPbDN4SllSMUR0NmFYRHk4?=
 =?utf-8?B?K2gyWW9uUG5GMmdHTE1iM2VZNU5HaWZwMnRsRm0yNzlHRlYzY1NxR1phRGx4?=
 =?utf-8?B?QmRzN0R0cUxmc0g3bUxqTXhyZEt5UkN5dFp3QXRIZjFWN2lqZ1BiSCs3Q2Z1?=
 =?utf-8?B?LzFiQ24vb1picnM5SlMvb005SG1BM3RwUktLaTYvL3BZMWhKeU9RU0creHA0?=
 =?utf-8?B?eW1JNGhKMTM2bTdXanFVSExJWGQveHpNWEF1azBCcDllMVU4NFNlTTZSdWw3?=
 =?utf-8?B?em5FdERZUnBtZjhjUHZadDdjeEZOTWN6aC9jSXdxekQ1NWdLU1dnYzVJYlRx?=
 =?utf-8?B?VFprNjlRRGpWSmNQZUNoZjlnQWJjVkVEaStoK0tIaWd0ZjRvTFFSQjZmUkY1?=
 =?utf-8?B?aEY2WGw3a1NIZXBSQy95T1hVRTBMWGUyQThUd3pLNnV3dm5UZjlzellJdkFu?=
 =?utf-8?B?VnYrSEIxaHprdzloYWFXK0ZXeFhnSDhaWGloUDBGVkpmMTRxZ1NvL2pCRE9a?=
 =?utf-8?B?N0ZNa1g4VFBEM2NwTHNZMTR5MXBPVitvNHBTQlZOOFpwUERFOTFjODkraWxU?=
 =?utf-8?B?SStxaG91OWZRRE1sMDFtODFJWU1HcUQvclFWSWZJTFV1U0hPNVd6TE4yeDZj?=
 =?utf-8?Q?UlW6D+D2DROSHIPCWa4pn7rT/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ONaz3B+0B3UnSJAhVmKJaGZSeWuVLmu10DvCCJhtVRVZC1X2KikSaBN19JOAog7MQ3U0jQfNReNVhzvo3OiO38vuuufqBJix+dwmn4lO+xZIr4ICJcRuswH50v0/zOf9YHieF9joQ/KhEbprNpTp6J8FtgWW52pHQomASEZshxIpDIsCczvJS3pIR8LGYi7L9f8YB2ryELDx3jgiwmw/869Sn69kSndijON69bCUV1tfd3bo2g6fnsOhaXO+7MJd5bJLooXRhQPMq73N+HkGm+SUFfM4/ILvdusMljB218Gz2OoIVT9kKEGjzo/Yt9sQSqXog61JSpAsN31oxyR+JtQ0WzC5/Ue6fhfMY71zwbofewHE0o1YcCF2wl4kBUdJeC7RlUAGISN/k+CVA7I8HwukH/FsDyEGH5JYwhEkCdsDesrPrfkVLDYP4rmN2bKB+edbKX+YlaKS6GUr37Ig7JE5y1lgQYLBHWF69HDaciu/5inAkngvKAINxMJ6YLTZSc81vtaDaH4U7IV3kbM8dRZH/WOTyFUG4bCYXq+Lto7AVKhvkExHb7EcOCWXRhCfyr1okruMUGzoLSJSCk8HnD7x0oi8a9MlyO7PfAuBmzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9318ca5-7d3a-494e-3133-08dd598bc678
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 13:11:42.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S0fwttA3kQSn2UCFGy83PQt0lkWVnUBgferYqK+YvWwtVBVlih1d2D4EQ14/OaxDz45LLk6t3mK20w6gS4lrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_03,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503020107
X-Proofpoint-ORIG-GUID: dSRE_0MgbGK2BcVbeAfAumovU0bbJok0
X-Proofpoint-GUID: dSRE_0MgbGK2BcVbeAfAumovU0bbJok0

On Thu, Feb 27, 2025 at 06:40:16PM +0200, Lilith Gkini wrote:
> Hey, Harry.
> 
> > Yes. but do we care about the return value of on_freelist()
> > when the freelist is corrupted? (we don't know if it was null-terminated
> > or not because it's corrupted.)
> 
> Oh! So we shouldn't care about the return value of on_freelist() if the
> freelist is corrupted? My thinking was that if the check_valid_pointer()
> detects a corrupted freelist and fixes it by setting the freepointer to
> NULL it fixes it, so we would care about the result. But maybe if the
> whole object_err() triggers, I think that causes an OOPs if I recall, we
> should consider this as corrupted and we shouldn't care about what it
> returns, cause something went terribly wrong?
> 
> I guess that sounds like a sound logic.
> 
> If that is how we should do this then yeah, my second suggested line is
> moot and in my later patch I shouldn't include it.

I think either way is fine, as both are not 100% accurate anyway if the
freelist is corrupted.
 
> > Two falses because when the freepointer of the tail object
> > is corrupted, the loop stops when nr equals slab->objects?
> 
> Yeah! Since the freelist pointer is corrupted and doesn't end in NULL
> on_freelist() won't find a NULL, and in the case of the tail having
> garbage that the check_valid_pointer() would normally catch, the code
> won't catch it, because it's at the tail which would exceed the
> slab->objects and the While loop will exit before that, since the
> freelist* (not slab, as you pointed out) is full.
> 
> > This is true because for partial slabs, the number of objects
> > plus 1 for the garbage, does not exceed slab->objects?
> 
> Yeah. That goes back to that second line I suggested in the previous
> email. If the number of objects in the freelist is less than the
> slab->objects and the corrupted freelist has some garbage address that
> the check_valid_pointer() will catch, it will set it to NULL instead, and
> as I said since the freelist now includes a NULL, my thinking was that
> on_freelist() should return true if we were searching for NULL.
> 
> But if thats not how on_freelist() should work in a case of a corrupted
> freelist and we don't add my second line that nulls the "fp" then this
> will return false instead.
> 
> > If you don't mind, could you please avoid bottom posting and
> > reply with inline comments like how I reply to you?
> > It makes it easier to follow the conversation.
> 
> Hopefully I did that correctly this time. Should I always include all
> the previous messages in the reply chain? It was getting rather long and
> I thought it would look messy.

You can omit some parts of the email if you're not replying to it.

Also, you don't have to copy and paste parts of the message when replying.
You can break the original message into into smaller sections and add
your comments in between—just like I do.

> > You can either send a new email or reply to this email with
> > In-Reply-To header. And please cc SLAB ALLOCATOR folks in MAINTAINERS file
> > including me—I recently changed my name and email (previously Hyeonggon Yoo).
> 
> Oh! You are one of the maintainers? That explains a lot, haha.

Not a maintainer (M:) but a reviewer (R:) :-)

> I just assumed you were someone from the mailing list who happened to be
> really passionate about SLUB.

Many people start by being curious and passionate about a specific
subsystem.

Anyway, as we discussed major concerns, (I think you can either add or not
add the second suggested line), could you please send a patch with a
nice commit message?

-- 
Cheers,
Harry

