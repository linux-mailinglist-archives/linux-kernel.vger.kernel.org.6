Return-Path: <linux-kernel+bounces-413465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1889D1969
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB892834B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716701E47CE;
	Mon, 18 Nov 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DLL4byAC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d1S7tPg3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED661BD9C1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960175; cv=fail; b=PLejJnt98LGZROArcMekiH6F2Nbkv46QwEl1KKj5q6sahMZvN7Ea+yeRbCNeplVjRxqCv1egfK8UzJJ4HwS9uWYkPFm3AW2389h9S1NaWh0NfeV3RPH9o/245+PsLugBKt6MvAPv/CO7LrUN8zhha84ZmaJCWOuwe6YENOxiKfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960175; c=relaxed/simple;
	bh=sCgERp6sFfx47I7nQkb44D51/CWrH71x2xSB8sfngtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ldor+HtN64jbNrER4WYOJRCx16Zs+gSewZQ4aPf7K33xyVrGOhkBo6MVVnb2KdJ0Sy+04MxGADHop95bJa8xPOM2oleOy/RU5lQ2h64z6hGGWqZMX5VhxaHtxILAkVhA7p8MHLeJAAGiJurQEVXAOs6uLrKE7/dO2Ru9+UHrdf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DLL4byAC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d1S7tPg3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGauB2001172;
	Mon, 18 Nov 2024 20:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Hao7Blh5lGaZ2m0qdh
	wl8G4q1xBXybYnSf26GuaiVbc=; b=DLL4byACy83BpGhnwxjxuBuZcBLq0Js8nl
	p3Wv2no+vEv63In6NwFkkRI2IEH51ZanzroL1VlQdlLj4DrQ/430qbydy4CYK0NY
	QKRslTzFQmjEf46aRfxe7iQTSJtAVhbj3udmFrDOpnQnVRFBTIM5FEE5pv9PCnn/
	JFI6i/MBrw/IDePJDn3evrpQc/JiDh3mNJEtwlS48DQGaPCipUObeNF6H76FE237
	lrYspUfagO9reSuD6o1FhQn7jtRmkUratUaOul6O2M+h8Ze7w7eoL29jcPNBiiU3
	cLrqRLFqat05/Ncvm4T4eZOncr0hzPEgtWnBEsIr6vtoGItNGFSw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyybjmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 20:02:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIJjaOl037259;
	Mon, 18 Nov 2024 20:02:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7saw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 20:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRopenIr+k++UrA2ywJQu2AAplyCFXI4Iw9YL+TnFqdU5g0di7zmx356cdoCto6WM/zOco+KYPO4yYRuKhBzZ5gKiqnBZv0G1ZfsRAuuPBZzt7nFP2C9WI/EaY6IkIMo33cikbjAqwORzFQErZwFiSL7CClwYFiJa3Tiq37Jb5BA2itmip3y5jp6J0QD3XeTNm3as9D3AzFmu7m0XquteOwnMRYiT1mSsIhqZUXPDTSLMrgfzCTa/BzSeaXufiMPpQ/yVX8nNEMXEAGf8uFSQY8oKRWCfJqp5FeqddPJ0/Tp+t8fNws4SO5Jv/JDqVrTROrQYdhQCHQqHuscNZ8vDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hao7Blh5lGaZ2m0qdhwl8G4q1xBXybYnSf26GuaiVbc=;
 b=O/fcfodsIk/ZfoQ2AlJJmO+ozH7qYun/tf4rXOI4c5O7LY4NeuBp4gNuWOShaMjttWoFzc3pJOaaNIh4vGbtT7iP252zQ1tJVTFbzAAa3OtQzHQ3Y3/GMCY2iQq+iiPMzwFWvoN1t9FI4QtcIF4brPUKTg9sFOcp1OQ6OwClY1QfRQ4RFh1rCC0ITnLwTd2r92EMuJiCiB2a9Fz/CosBL1irJ3BjDOcphtrXnr5nCZPpTf9Dw3Od4AL+UTv1MlSQ6DzqXQy6OXRogepOKWIGKPqebOgk7aNFTvg2P837mITcTziEbMYa6AqH937weyx+3bWFbj5/DlcBCjEJFn9o9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hao7Blh5lGaZ2m0qdhwl8G4q1xBXybYnSf26GuaiVbc=;
 b=d1S7tPg3KDwQP1D46l0FYOynHeV7hinPxBM8C0c4vHIxaleVlJYYh95kZtNKguxP+BufCfBPXPIRy1PvWpd8KeRVGDqCSTsORM63vQv9JB5JfhGISh1B9Z1h0G2bxLMobuz6z0OSmGg4a3ksls2+9Kox/2AsQrKEG6Vxd6bFQ+g=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS7PR10MB5197.namprd10.prod.outlook.com (2603:10b6:5:3ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 20:02:40 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 20:02:40 +0000
Date: Mon, 18 Nov 2024 15:02:38 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: correct typo in MMAP_STATE() macro
Message-ID: <hxinljr62axgkndypsof3yvqp2f5my7sokvipndwoltx3c4wh4@bghfja7slw75>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241118175414.390827-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118175414.390827-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS7PR10MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8f7a43-80d8-4ac6-df5e-08dd080bf50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EqCRAGdYWYkt18NE2ko8vePzzElOPD1uX4Yb2P41ss9MYUB+gdG++9NHM7jh?=
 =?us-ascii?Q?JNCw80WMGP0lCRugPO4pMYgmmm/yRFBC2xhKYNF9ChpDAZsy47YR5Av0yetD?=
 =?us-ascii?Q?pDs0+/dTaqd9hjvq5uYk9bp8DgIq7tbJ7bmWDIxN5IFjEl2nyVE1etCrJ2jv?=
 =?us-ascii?Q?CKi378jKJKcgJhQGLiau1852NyIMKKsHBemPzalEpnBEBarfyc0gzo9p21Ht?=
 =?us-ascii?Q?pLTweKDAJi1Bhm+yG1evNl7kHqOaeOcmqTLU/LdB+TDIrsepLaAmfgayr16k?=
 =?us-ascii?Q?pcCZKH9SBXk6hhLNC9i3uNlHjjxY7chulh10QWPJz+lWZGNe6rWtcxJ1FKFd?=
 =?us-ascii?Q?M3bCxqAE2mgluOHKvobt3qa/qFywC12V7aipDHUianhv+5MOdPpFu+FwD4dA?=
 =?us-ascii?Q?wbIDaaiMKeASIW/WRbPmbLIccH/BQEvg8Ps4C815+pX0Sxf2U6XOk42/Es/G?=
 =?us-ascii?Q?sIEK0GHhud/4FIpK6hzylK+N9zzBHKiqjbXz/lMg9Ce1b9QjA/ew42stbTC/?=
 =?us-ascii?Q?Hr9l6hP2GOBLJPylbavji5C5NeZRwR9qOC7I0tdh2RToSilaLhHa1LqXR5sU?=
 =?us-ascii?Q?WMSP/sK4JFJuB4lve8+yTRLcLcikWiWWXXXgP4ykjCo079AcIve4dpS2w0Ni?=
 =?us-ascii?Q?hnPvBHsdujdc38fx0PFZax/xu28XRiETVVt6ucmznGv+OorajZcPzsfxw90q?=
 =?us-ascii?Q?5frs1rlvNkK04jSaMkVvLj1r5TQkUM413MdTXV/XX1jpFEclZH8AX0iLAqNA?=
 =?us-ascii?Q?eeJ6ULGsADaJtF/2owa7quEflmKq4Y72D+z9JDut2K9YCx7qIk2G0I8lgg4u?=
 =?us-ascii?Q?FZLoajxUv1XH+Kb2WxXxvKoms0gwBz/Gc4QZMmrinGcNjnjEa3Mj6ia127LG?=
 =?us-ascii?Q?PxVFzfo57lX8YQYdfw14La7HpsZDNl6z95ANglKJSdgeXWqPaOFFqRLDV1oK?=
 =?us-ascii?Q?DpD50hQDcZYrpU4lUem0sfV199ziwQtf/l4k7rWm3z8wbaDti6a2FfgECCXw?=
 =?us-ascii?Q?/SneTlGfcQ5+QUkDLiQrMIvD678q7+S+wcCBrnlqQhB0dalUGl+VkyMIFyiQ?=
 =?us-ascii?Q?QM2PwDU/Ey6Uu9bMPeJX68r85qfRIW/D1FA6OwRo8bjE/uxE41EcR/5CH+IK?=
 =?us-ascii?Q?ImDVi2I3NvmElzcd/QcxyPBPS3gvJM+//fXAmpYi+5fAJKvvU6pIc+oo/kvd?=
 =?us-ascii?Q?jPY6cYYst0QgInCUEImK8gwZ2sqPno4SbFrfcmckiSG1QjGh0qUpOj/IAeNI?=
 =?us-ascii?Q?JT8r5XULmpsfe/YbY5KswLN5odc/lMwLR4Q+/eeE4iVGaZceZjnm2uyLREVZ?=
 =?us-ascii?Q?uup/Nm4PQpbgbI0lGafm8onU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Er84dl+A30xgdRZ5z12YGpyRJ4XMyDP5+fDYF5Wmn6tS2t9YwayXzKYBM02E?=
 =?us-ascii?Q?ZkJp6lU3H/EihSvylfQfWmfNfxlaSGCWKzHaQL8sRQatS7vIGEL7nBY01/rs?=
 =?us-ascii?Q?mpliG6nvLSPkvydrc9OkgUVjoEtsppKshD3zF1uyUbc400hqhoolrLFdEIZz?=
 =?us-ascii?Q?LkFYZWz8c9YaQ1epTd/GPK0Lg3D+K6JdifVUvLcEmTjDqmJEpPkay2PBJYOq?=
 =?us-ascii?Q?OCuE8DxD6Y5LGPoUjJ1Ms3NqNXU40OGDL6M3pCNuSWhfPgZ+77LeCykMTnxP?=
 =?us-ascii?Q?zKHBg29ubi8z4V9N+1cn24ZE+t0cwCXwMucjA4SMyx5Q5wK/f8lGAwjEVmrT?=
 =?us-ascii?Q?tTfu3Y33KvLMjf3snDwRet9RNeAAcccQaj5FAu5s9gOuMG933CIOOoEYW65H?=
 =?us-ascii?Q?L+2Q9Pd/cG9mOA8d4EBjFwSqC5JExZ8TB+wlDJaWRmPWtJIJX06+fcsHbDT/?=
 =?us-ascii?Q?yv7ctaQ8Ddwq0KYJUaxNGxpUIzpvOpkFIm5E3LhItDm0HPmvVwLknjek7+Ss?=
 =?us-ascii?Q?0Okj3eJOaOL+8J9sD6fE1t4WgMCO20f/XBB+DTA9jIJ6zCAqIX4cIiCbcgae?=
 =?us-ascii?Q?FQit8H8deo0M6BkyC3O0fGDHuwrA4FtxjlD0hJ2pa77soQG8f+Fh5bcHgeWr?=
 =?us-ascii?Q?WELd/FOXHEB+RHsmZaV0c8JQWB7SPXDJMcQKY8FDj+9DdvVYzNDQoTbQUXuM?=
 =?us-ascii?Q?NUgFbM4CwYGQIhD4kFkflP43z11WxG6c3Y25GeOXoZFYtnnIwl6vgZTkSgAw?=
 =?us-ascii?Q?3s985ZkH/BqTErvLfu+R+/KijuNm9vMhFdGBQtQTIZ3YPeoYy6ZoIS1jTu06?=
 =?us-ascii?Q?MpoIEUVmNvcAGh72v49U8cF6ZI6a+NTwzqsnoZSn9o+TKWZf7IDEWs+MdD/D?=
 =?us-ascii?Q?ciC44m14sPDuz7HxZZpVsIV33zol32oPItqP0NGqT1YrMYMD3KXHdTSTp6Si?=
 =?us-ascii?Q?z6xyxnufu0Kyrp6ri2OBG9MmJN2CtCqERA12se4CbHb2ZVEPNAF2fybn8kOx?=
 =?us-ascii?Q?tkQLRVMARkCPJ2WyLYlS0ifhdGljwcm2Ja1/K3Ywo2YeCxepLhndbybEpK0T?=
 =?us-ascii?Q?bFaA2eDE/8hUgAuNTXjmOD6U51UNzXFzNVbQu27QtHKx+d9QemqwUVZUGLf6?=
 =?us-ascii?Q?l1x+p1M2EoZ3+fFpGIsGAKO5DmA1oaKrDL0LKP7kwnVrSErkgkDE8xgDc0rt?=
 =?us-ascii?Q?/oOQKWZe7A4X2WgPF90rRpVCyFemIQPV/JcjcMwLomhROR39WIzurMz+kqS2?=
 =?us-ascii?Q?3BdHVauqZtLgBEj6wBae4KD5C1Au85WCdaW3APpym8i67caN4oADialp+YfW?=
 =?us-ascii?Q?TopahMbO5nsp+U/H+sWj6G+G7UEd4cbTH7IEk8QL/cy72lxIh0SZv8PAjhUk?=
 =?us-ascii?Q?EIxmHIUsMk+JBcjJHteUKqCqaVoFum3RGfjxSw8FkkhtbFACr1t7KNBDs1cY?=
 =?us-ascii?Q?QXC+M/+L97sTyAzTC7JxtMdP9KQdAjlZcYxUm6LUUuiOzgOuCCK8OdtDirLS?=
 =?us-ascii?Q?6zH+PMM+VoQRYur9SIkkMDBaA6zfJJ2fOZhszik+y1QP0xm612vY7sSU1quc?=
 =?us-ascii?Q?ZpP5GSuqZRq/3QT7dTmyXVkjiaV4XainLVnkhRON?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kRcFp/3UkthrUvWBwYuMES4LnK00uml6AybUuo4TIILvN07gQx9OtWqfSjaLWgy3W7FOPU14fQ7ZA7ZpWCedxNeuH1AyS2QY/48ScFwjunYfsxhWlFw1T2n+Qi3HC6DWSTN3DKQB8ymZtS6c2P9ZDXcvEuK4G98QekjpWD2VnI9zxf+IemkuLpZP++VohVVRbPXbuV1zORl53A61TuD/uPk0zJ1nuPgnmIEMJVzdZfeMKZcCp10t/7cvL3gQ8xiJ67hTsGBgvTPbFhwYuSvAzd1EPqAT8+SUFMpthczlI4rbv0EnRTgK3iNUnfqt39s5U5AzkdYs+A7J6J3sMSvy0GYPbThiHAH++Gy5+dQUQiM+lfcplqToU2f3le6HQZXa0XAzoixw0sk8GZXJTwnBwjfGjlrpGRdImR0KJsx322j0T+SDIncgxu7rJNaBt01Wb70pi31BnfGyIwLFDbqo1LBBcma4A6bB9fOl7XfFZM+G5zymUXIUBTcntbgyZ7Glo+p2IVg/CErw8Ixv3u188CXDB0AXxAZtv0ODGlg98JhruomHRujhkm5HBPqPfa9lzTN4a1M9JXnv4PsUwGQKxyAESFzhwViuWnZoP4Vlqu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8f7a43-80d8-4ac6-df5e-08dd080bf50a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 20:02:40.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sww0Thq2nBzHSKf7VkMmdIDkgkgx7m9Flyr50EVPVujvX0P5WxunkOGUyJB+UJ2MPeJL9NFOgD0Dnu8M7wm56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_16,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180163
X-Proofpoint-ORIG-GUID: mUM0fhXl9j9Ef4XQY8FSv77Rkl2e2wVO
X-Proofpoint-GUID: mUM0fhXl9j9Ef4XQY8FSv77Rkl2e2wVO

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241118 12:54]:
> We mistakenly refer to len rather than len_ here. The only existing caller
> passes len to the len_ parameter so this has no impact on the code, but it
> is obviously incorrect to do this, so fix it.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/vma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 8a454a7bbc80..8e31b7e25aeb 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -35,7 +35,7 @@ struct mmap_state {
>  		.mm = mm_,						\
>  		.vmi = vmi_,						\
>  		.addr = addr_,						\
> -		.end = (addr_) + len,					\
> +		.end = (addr_) + (len_),				\
>  		.pgoff = pgoff_,					\
>  		.pglen = PHYS_PFN(len_),				\
>  		.flags = flags_,					\
> -- 
> 2.47.0
> 

