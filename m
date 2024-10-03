Return-Path: <linux-kernel+bounces-348896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF00098ED48
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBAE282187
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799FD14D708;
	Thu,  3 Oct 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F4hGcvKO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="shQ0kBs6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9880BFF
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952422; cv=fail; b=ckfGURGlF3sPQLH5GyLC3tP9YZvaAWxyS/iP98NQUpwctZqJwEsGN375J5ZO/YAhsHJQbbhfQj996Ns5mV1H1vB2IOdPAy3bEv6ojWpm+XYlhm8fSpu95wNiUqiCsuk2Z1o/j/7AgYHW0u+u93OZ6AMU+WMa6TrrdMT/vLVn86A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952422; c=relaxed/simple;
	bh=9mi7KFr5A6ByBdXeZczyeQjaO30rHy1WzUSEB5J1QtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h7cTCcuGrcxoQqr+q3N8OaQ4gFxY1kgJ6C9iXN01TzdQisnjM9cw1zhTin9AIrBTZgWbSv2EJqJzCCRB4M8vdhzOGMjWlTyv1gnJOTfFvQ9ypr1fylyxzSox8PR5LbDeOfa+DHoQpbjj+Vurz2/E/L71/KkWmaooh6vVGa+cs/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F4hGcvKO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=shQ0kBs6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4938tbYk024366;
	Thu, 3 Oct 2024 10:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=9mi7KFr5A6ByBdX
	eZczyeQjaO30rHy1WzUSEB5J1QtM=; b=F4hGcvKOrmL14p4lA8IuQ86VdeMRhQI
	N/WEPzek8VB98G1zJcSOotwCmD3HnsiMTtVAZfQ0qTAvZwjd4I09gfryUMWtJHaQ
	/jURHWdf1qxpQ7In2VYayPbTCnm04Ha5w4qItLIMv9DZaTgfYWbWyOy5Vw7Sc2jr
	VOLbNiTQ5XVX7nxeMMYyb8tUQEimrEGluEZyqycqpNJ4lMVo6xJTnos99q+/60vq
	AAYVnO9RI692WzyuViJuoLjXnHHF8VrYzWM0yvVWbu4KjJzVESgvtQpGLoqABXEP
	5As2+opzhiu1q7AOgP9XwhQpqh7wGVe8yh7Hoj71Xhe9cPzB7M8BjzA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtupvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 10:46:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493ANRNW028453;
	Thu, 3 Oct 2024 10:46:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88a8pfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 10:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVolal93t6jTDmtEclm2fYxurVh/ll6jT6DCCcAq0TfS9KNJnpIO5M1IUchDihFc3bZ5x4n6qNnTF68qVS6Kk7PMkVhaBjJUUWrV5MUudjYz089/0Br6Zh4e9fh693TRMUssXDV9DQPZi1hOhyWP2o3YLJFGyXMk+tvxmlI+p8ktFZkChXbG2cSjPqbQzFyDxjQX3ygRQkv3pEo5oJK9Xr52OXC9Oe78kEpTP1UXBtwj3C7z7GogNkUMHilOBcT5hRbaKADOdVdNUPMCVb+UR2O2gFWa2hor8OKTsGFgrlgd3pgoLQKrpnHuMvxOFxBQU7xdvL/WYMVhO+KJQkXb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mi7KFr5A6ByBdXeZczyeQjaO30rHy1WzUSEB5J1QtM=;
 b=brCNBb5FbUUU7AVzMnpImt8MbnKLIyyLsMqXlGAfzMIlAErqU5ZfqQUFYAFb6A2OOx7KEOBMjtM6PFL32n0v3Rgz1xbYw+u2PWFds5MSjW6KXJdvXUN9aapgOg7Dhyhp/Zj/yiJakPeiwRujhAuy+XsixdP2thMXXe80yyHm2BWajDLFInhG9DycM2c+ZTUtBZnmFOSzxzZB7wT4HKzaOyg1yfWxhW8sv+dL6Z16mSWNKCOB0GWwXRNma5+eUT05KKiVoU5OE3XWcZWqAsfnSJ4JylWOg7hhLoi759dKDPkS/AptUEc4qF5qloUg+mpXKOOZHRQqEc+v6BkSLj9GiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mi7KFr5A6ByBdXeZczyeQjaO30rHy1WzUSEB5J1QtM=;
 b=shQ0kBs6icXi7jwQPIMlZfI+9kwvlTcujvMt/Rn3/Rn6NWHTcpV8D8QOT6SaHIAyeujDoZF9a4898atUveyoouqXpM4JIH6oM/FZLMm74aoj8rgRAYono1nuSL1JEdbl//DFGY8OaSPEACJnNay9xy+uLBmitLApXL1iikqiEEE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN7PR10MB6408.namprd10.prod.outlook.com (2603:10b6:806:268::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 10:46:51 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 10:46:51 +0000
Date: Thu, 3 Oct 2024 11:46:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <60d07aa7-e5d3-4b4b-a497-9665be68448f@lucifer.local>
References: <20241003104135.2838-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003104135.2838-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P123CA0678.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN7PR10MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ce6822-96d8-459c-8981-08dce398b053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2y1M+IICytwa2u7UBRKPqhT4LO/ZTgcPdrxMaHf2KqhFF+oZGqYoiYaSXFJk?=
 =?us-ascii?Q?UOpTMBir2XAy3+zfU1yThxh28dDo/ifCgp5YeLPB5aQ/s8XddLBgVP6axJl0?=
 =?us-ascii?Q?buIE1qUQ7RnDFAdbo6yabiCIomkIF6Ln0x7tWOW0H2SWtfocjsZpUqUxdtlA?=
 =?us-ascii?Q?SelidiBE08jYD6Hz2T3NcvcZl9cCUrLYcoiYDDmE3OsV4AQrjLVlj2klvKC0?=
 =?us-ascii?Q?zCHEAkWr5Mi2bDiulBMFyqSAAOvepSYjOq97ebPJYh8FhQwfNUkFC3En53TJ?=
 =?us-ascii?Q?XmxoN48XQSLEM/bM/6unjllyS++3gIXIbt/F6v0vO11Cap57bCR6Qk4TlyOb?=
 =?us-ascii?Q?kgmSavxnRaAaMN4saZo+kQI4HbiiUyspqlqW9N22grXhfd3E2xXLnMIjpTf+?=
 =?us-ascii?Q?bJ3OLK2HIhWpgfONOGBcplF30NVbMDKLhnqlxbPMravuKkAY2MBCBcjXxssU?=
 =?us-ascii?Q?o5LZHBqjg8xhVbE9PuJEstbnF3pnFtcKRQ3bl/ObM2lDKB6GuADMpP0a1/wx?=
 =?us-ascii?Q?p6PhDye5RFDaV32EMn5EsQADwvnXAEYY2Ux4Xi6oMScuZdFH18pTxyyxGBq+?=
 =?us-ascii?Q?uaffMOl9xRh0hDXDvIZpFxNCrbRkVMEH8z9ZGI5iFWibWugd88mmY3spj87A?=
 =?us-ascii?Q?p8NskYPBtVsZihdhcWxRsepAlk4VMKK05uPvi/GTUau4JduXksucabc7qcnL?=
 =?us-ascii?Q?26idUxWF6qe6+z1Tf+DRMV+dnm17yz8IFCPjRXS8wkj6F9jWPym5HoS9w7W3?=
 =?us-ascii?Q?NwxfSY/yRgBdgNlBNClEYhwKsE/OxsUd8h9E5dYw+z9N+iBd0d/2IEY0kDb6?=
 =?us-ascii?Q?7p9qu6oOC2s5N8y5F+wovRzBtKWFUIG01MUQ5rNomO2t/G3h6oFKTsKZLOOX?=
 =?us-ascii?Q?Kmv/UOcHyXQ9/RwnH2WROtwq1hdbL2TlGRn9NsuXPacgDxq3YKjrI74X7JGd?=
 =?us-ascii?Q?8wCGa6z4LxRUByg9pwZiwLo5xyJNta89kDwKLDn9pcAaRYvmmBDp9V1GmgtK?=
 =?us-ascii?Q?I8nUH3nwaGlMpQ/cynpFod+SXq26XriTg5nDXhCCC6btjB1nvLdCQxN5kJcF?=
 =?us-ascii?Q?KSQiSEi/MUcqE8FJW8Xz1bwxlNDkMIoGWUGW4J4DTuFyNe8GybumaZKk0xg4?=
 =?us-ascii?Q?yjSUICWVf5Vl/04bqUckBRYnFf9gK2GkoTVLADBqF0KJFa7dVFsAZZxAZ4xK?=
 =?us-ascii?Q?jWB6+iYovRgTuM0sfFdG5h+kCoFNFi6HszCry9SljhsPEIxunsqcT24MMpAC?=
 =?us-ascii?Q?irDHdmioEuopzXnDgJQCpOV8NVK14lBPgx2pboUeJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PfZ46W8K9Kb15nQ9c0QLbrgLmlwIa5ju9Nmon17lJuT4XWuVVgBdXQllWCaZ?=
 =?us-ascii?Q?Ha9i6r+Miv4uvtJX0dPpyv5idDXX/5hUN2aEG4QZpZcBek27ih0ymO4H2Aw0?=
 =?us-ascii?Q?r0kp3lpDPJnoVQqLw/pyZQg1FwPVfZGU0KQ3+tVssz0njxeOed/TmvL5/RDO?=
 =?us-ascii?Q?48Ol300SsR3CmSrozxFTIT1XMg6Ib48VgjrZ4+37qbK03dxuwI2tiXU30F6S?=
 =?us-ascii?Q?0vZ2dj8PpRugy9A4qDwWm0vV812kYXy21adR1iYC3ohVO89903C3apKaXiSv?=
 =?us-ascii?Q?4I19Ab1BRkAY+ZTj12uZyw4uYUkzAfPYvNYpOQA4SjswM0qaZbPlzfH5flZ6?=
 =?us-ascii?Q?GvgRWq8v32EymQKteoV/XGMfexjYC0NyW+6f6yJtXu2rqS1fWdxsKo4XOfNN?=
 =?us-ascii?Q?GbiYTZZFnu76+YAy86FJlZ4spQyfRBQ0tqYd/cTMyMwjgdhuisZVPFRTIErz?=
 =?us-ascii?Q?mZPBSZiYEt4KJVVWogYlbJxmGmqTAYAy23nMauctEUPIiDq43Ld9BrUu55fO?=
 =?us-ascii?Q?kLHOfgwDFDv0xvQ1V5Plz8CBmOUKztnvxY0KvCdVSuvTyxi0RF1kLVbYZc6R?=
 =?us-ascii?Q?M17E7+wItvTah9ckZY5mDC3Gapmmr2GD/vD2ylw5hR1PWtHXipgHe+cJUMbX?=
 =?us-ascii?Q?soZoGn9EPiN/hUjv1hHvPjpkf/QDVIarsia+yeDcUKeFd2ODz0/sbm3Fk25A?=
 =?us-ascii?Q?x3HGUePQCG6injkNBPrg3Na/5LS7QuPpg/GLDokmT0RTaG6WyK88NIYzRqvu?=
 =?us-ascii?Q?IpT5CIGuhX1EezAZ6kMFQUnlqjrOKwKLVr/dINhBd1vzmRNCLOLe0UXKtXqZ?=
 =?us-ascii?Q?MKays98RDPYMVT907vyEBPJwiNKoYCk81DSBEhhI03OlcsjAjGidK3YcMUZL?=
 =?us-ascii?Q?gCR54cwpMNhEFcr1wf4vHD92J/ICsTiEXFm/N+WuoPBD9uAoJsJFe4EOcdzO?=
 =?us-ascii?Q?dAUOcmVcJBqs2nGd3a+zgu2mZ00qWfdYFabFFMKdSsJqMIOIgadpOyuwWwlx?=
 =?us-ascii?Q?/gcIUK5yN5HNFo5CDf8RV6A/BTr2IGICJs9/YP6NW9ExiQqG/PbTY4/OyoRZ?=
 =?us-ascii?Q?8HV2du/6oLOvXHnkcFA1KfBuMh3XJtwg5+dZcV+62lpz1BpPeZymo4nrhVIu?=
 =?us-ascii?Q?Cbj5LBW3mv6UBWcJbYdBfXPmxKXa8J281etG0fRc063lJUtt7WrLfilR+LtR?=
 =?us-ascii?Q?gKnxgYn8oPOQC82WO1BS5MywzNnva4qbPK3uSCFaGfXN37TJWe5Jno0evCgY?=
 =?us-ascii?Q?MXUuzZDUROd0UvZs9oVhc3JfiuYwMQcilzwrljn9d93LYM9XKpGsZAL6gpGK?=
 =?us-ascii?Q?yRHSDGaBHRciaBVZDmLIcks5E6daaaJPFyDZ0AuBE6EbGz2rcjAJEwK9w7DL?=
 =?us-ascii?Q?wdqgfcD5H5wfYY7S7gpLSFKcJt1VYVYL5jHCAdJDkG0GaVU+OwCerdsnytBo?=
 =?us-ascii?Q?DDfKuGR5stweYHM9buMUBsU4/c3thUKsU6nl9ODDk8e6YOR3+DYQE0Q+1cxz?=
 =?us-ascii?Q?TwHpssW8f8bpZFkl2EsvDnCvrzbw9MHWfLFFXw+OYyuwY9bBKOALFB9a+3zk?=
 =?us-ascii?Q?FcE2c6W3YW0uBbKRnCU5YhtYl5gqSTbSSTyNhXHJ91AE5DLPq9jPtGoekeWy?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FvMo6ZUSpMzYTWi9tRRprFfRKnR7sNxdSAB47KHPeXRGS3/nVu6RhfIVpp2xVrkd66LCkwSmxPFnHSgv5E3khocigUQDIznDhREyvVWWYiz/+TNVRqJ9br07HJXNwwiabgaILKmWY1fiYA1O8s3RKmqCcz3QIIXmXODrcLlH8+z9ot1CSqAAbowR3JcCiZ0kV40PIYwV3L+25Zj3NrfSZS5eKOLnDdMDHeSxk0oOlJ/LxBxc6O/K8phxZ4+brxvIsfVHNOiGUMr0HdutCyH5i548QCYAhMz9Lo3TPXTm2Qi1wcR/HFZWBOrVadqAPwOKJV6p4m/AljfUQI5XAA11RqsJpyfXsjYlDyROrtgQkzKA55rOWW30hJ4J2Pdbi92lp5UlE8NTxZDa/WXtLlFwkgkExeBFVOFRX3LGgJEzAgcpK4XpjKOL9EpBTs/I9o3+bJed5iD2D6Apw8cOCqPiW/pibFfGdox+kOjvmZJJUB23V9yR4/5wXVq9UPXzr1/BC86fLTyjOzZ9fTajefqMxEStJJR8eGovJq10H2Dh/tG9eaDYKou8ptDdUwufDsf79L/zWUINefMsGI+3g1PAgKr5ROaEC05F+tlZIoIm6JA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ce6822-96d8-459c-8981-08dce398b053
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 10:46:51.3369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lZTnqKOisjIjo+C7GKxYmMqVxQAPYpOsfMeyfm7mohc4BCPFbvkcignAb95y/Bawqr9B9E+HNVxzeXlmak9y4jxPa5jRMW2mjwK7qLR+iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030078
X-Proofpoint-ORIG-GUID: WVg9COLgsIxX64iiafz9YP7iUDkQvGsg
X-Proofpoint-GUID: WVg9COLgsIxX64iiafz9YP7iUDkQvGsg

On Thu, Oct 03, 2024 at 12:41:33PM +0200, Bert Karwatzki wrote:
> Here's the log procduced by this kernel:
> 79012bc73c33 (HEAD -> maple_tree_debug) maybe fix
> db8adf7c0a23 hack: mm: see if we can get some more information 2
> 7e3bb072761a mm: correct error handling in mmap_region()
> 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
> The "maybe fix" did not work, as you already expected.
>
> Bert Karwatzki

[snip]

Thanks!

The 'maybe fix 2' I sent separately I strongly suspect _might_ fix this,
please give that one a go, it might finally put this to rest. The fix there
aligns very well with what we're seeing.

If not well then, we have more info in this log at least :)

Cheers, Lorenzo

