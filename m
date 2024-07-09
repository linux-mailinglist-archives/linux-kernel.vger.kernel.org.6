Return-Path: <linux-kernel+bounces-246094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2994692BD80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E022818B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4A19CCED;
	Tue,  9 Jul 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J3FnQ7zq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AvOwPjpe"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D618E76B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536773; cv=fail; b=PB+Wr8FS4H3WW6WCakxHQtLdSXE7ycZ6LP9Z7tsR5Q3WE4dxRFHljE9uLnhKp+IuLgjczLKCElrrrCn7OnWJdY7dkU4ZedLzFgqD1tbssr/7rnHG6hn3krgtOXmawzWFyVXi8QYAPK6fQt6mx0Wpfp4PlOaj+lTiFOXOfcAPgS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536773; c=relaxed/simple;
	bh=Y/LE7OKK55fUQKV9g66LnWVIsKBwIlDREfmvF7a/fcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dW5zh+Y856+xHiIe+k6q9W0nIEtMt4FciOX/VnJoAnjAtpRN+T+xHnNCiCN8A3SeXtxvskIxnwBePhYI1y8pi+aD3OShJOp4Jd7vx2KwZikDijQu1v956CM8rWzcOPIe5/6YVgzALMeFBQCOgkAuQcEtZ2FtzDEeoZhX+0rJ0ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J3FnQ7zq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AvOwPjpe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT2jM008089;
	Tue, 9 Jul 2024 14:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=kpAWFP2B5yP5pM6
	G0vBa0L3bU2kc1hIQCC6w+l7ALk8=; b=J3FnQ7zqNWu1YRAG5GYdUNbFYFEDT+8
	ve9UT2kKaWlkTcyi5D1BeVROV8nB4Vd9D1SlruXmSl2pUDHg5yK/89bkuFcyeYhn
	IcyoKXDvd6kEr0vqmx7cxRWSBnAV0kVT2QZXlQspMdGbIcW1D4sUgXiFT57dx98E
	FdFNzbUpqmDRs8DxjcdG9+tC9GxWdU7RGq6kFLFuvj7uv+m1Ek+tyEUYwyKf8q+3
	0f72FCsoTURiAJqJnZ0zWjchBuaEUudDIoWlACKtrhRWVav3NBLoSLWe6pf5GuH+
	9D0Sua1jNpQVpGQYq5rmQQmvblmRxZ0Oe6M8L+7hlaZq0m4NxSRjbBw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybn6ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:52:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469E5kV1037261;
	Tue, 9 Jul 2024 14:52:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv1ejvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsaVzB4TQ7mhBzvC+GsYqtSI7mgneFZ2V6VIi4XnKPSU3BFzseAsQozbdDLXOn3Po3+pmDmP+JIes3wq/MvLudVVbKXs6NP1fkMJB4gXh676uLBafYkbA9E+8Z7NXjgU6eR3XTVwVQRLTHqMxaf/vgyncQ3Hlyvw8iZ5Hqj5pQl+zRTKBPWhMS6mQ37tdYx9OD7xACIII0iwjp9aPiQSoznHC/QdjJ6F/CVfHQAXphQdSI0dXfWO0tCVueW0bn6wPxG9q02vYkODamHGbNYhBNhSazoW91hnw+QEOpWF83J0L+zNHeDmXNSc/uDPK2xbDsBlSS+gHr+HQwlGaH/LpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpAWFP2B5yP5pM6G0vBa0L3bU2kc1hIQCC6w+l7ALk8=;
 b=Jfx3Qowh0TAnIkLCACNQmkgmSAX6KjSkSrwK4iDGQJhxbJXWa+ymp2uzkaoaSS5zlfH9IpkSdK9byvJrhGoWcJRhHnEFd1kz8SlcKLHS9xapiOcgJeRnxEDq3/R/s2TPASU/bXRGUwYxQEFvgOx4mXQ9jgXO6YkhXQubu1N8HPoX4L0lA/yXTh3NZjWiy0MioIse2PBggHDxozDCZEUy/P7D5QzXUxP5wD4+ZfoH6bYQscUFkjeiY2Z5fto6GrU9yI7/8DVL6NI6OnD6m/cKYTg0F4bu4ydxlWRSLi2RDD7zK8JhBQ1HUSm8WH7QjdL05d36PgHTQtSpco7kjvjQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpAWFP2B5yP5pM6G0vBa0L3bU2kc1hIQCC6w+l7ALk8=;
 b=AvOwPjpeOwlVmKdVP81wGfNuWbKcU/84OMTP/1d8PJkh3+yjkgz/dXQca4PhwIs3/atLBYkOtXH5E9NCidRoHlmpogN/0Doe6pgQDbWtrt/tRaOneDYA0huR9GNifVIrlU/PuPac6OMvYWLhsPgEQI2xvnJowpmOLmBPKQX/ER0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB7373.namprd10.prod.outlook.com (2603:10b6:8:ef::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 14:52:28 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:52:28 +0000
Date: Tue, 9 Jul 2024 10:52:25 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 16/16] mm/mmap: Move may_expand_vm() check in
 mmap_region()
Message-ID: <qje65pz4hj2rffrjszmkyofygfo63pgw2j66ldmm56v5zdy4gx@ufe7ydvmio7y>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-17-Liam.Howlett@oracle.com>
 <8fbb424d-a781-4e61-af7a-904e281eba8c@lucifer.local>
 <e5ldsusdn3som7wn2rw76wtrhnlrxk3vkyk3iyimh6qv3ptvwu@24zfmamllev6>
 <jn4owbmmjrthhmaene5lsnliou6lfoyrvn4cxs5mbmkvmd5qoo@banbwbsp3l7q>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jn4owbmmjrthhmaene5lsnliou6lfoyrvn4cxs5mbmkvmd5qoo@banbwbsp3l7q>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH2PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:610:50::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 7683e087-78c1-4511-343f-08dca026c0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lPUxFE63OxxE//mt9mTBluHardf18lADf633ym7Esh0VV1AkGzCIglaaL1NH?=
 =?us-ascii?Q?Yo870O9XblROLHbO0vA9PuY4bymgZjrMDld2gUhCl4sLljdDrMgOAHSgcbCZ?=
 =?us-ascii?Q?rTaNr/QwbvSqE/ZT22xcYDvsw0lr2YX+2GbW3k0yE+/CKEqux3YB6dyMxnA6?=
 =?us-ascii?Q?V+vEzjCVcb9+6yvbB3taM3hE0oQwpBKr+vKguOjC8WgM6chq/4x/Bf2j4K2T?=
 =?us-ascii?Q?tYsI1qJSBQPiH6/0hfnzcJu43D+sPtgyF44u+G7L/sEYQBZwLIg0dY82h3UB?=
 =?us-ascii?Q?jgeZx3q5voYC9MDGo1CWYAd9/jXqpSW6ZL/7BbfIBhBV9Km+348mRDwvWttw?=
 =?us-ascii?Q?cHW24MZDcX+uCBc5scmCUW/LS/r3jb/IR8yZVdOmclSVUFanYkgIvakn3qKA?=
 =?us-ascii?Q?u7+1QvpNKALB2JboxQRUypwlZbN9CSOojFF3QVTL6SJhdSNjGsnpwus3enwE?=
 =?us-ascii?Q?KzCYVU3bl34K5q/OatLN4UaxzqhA4QYiDwZn0iFv0Zmu6XUaxv8XMid3hqJc?=
 =?us-ascii?Q?IW5wDB5i5q/dRwv/jibHTmlU7WAYq+lHXHhmnFkET1dkPbom28InZxFEbW6v?=
 =?us-ascii?Q?jLEPbPaXidhnqR+IKgq2aixSclqT2ZHDJrH3T237LAIX3YfgSTDcVWkuvQsD?=
 =?us-ascii?Q?mze+4/BQD3g+A8XDoB2P46uOM0WE69FGYrff7bUOjJwnrXuMnwHDc2t6m2HL?=
 =?us-ascii?Q?lzLsPB4ULN7hOuiyxX1tRWR6OgfbYZoKHWKsvClslCUK8lceVcKsD47HsI1K?=
 =?us-ascii?Q?Z8u+NHPMa88PNcjSxrzA7zDJWcMc+6YY6qsEVJzXNWWw1fWEmU1gxW4Q0NJK?=
 =?us-ascii?Q?SzAn12kWHqnvd6fY9n7mIdi+tNgCf2I6yeHQuGpTUclL60qSqi0Qos/UAX6m?=
 =?us-ascii?Q?13BbRzFfeUilSarhLeJU+NTmPinQgtNQBrg1S/kroLI99UyYWqDmtwiyCIkY?=
 =?us-ascii?Q?9E/wFrPLr5CIFUuA1r0J0ao4znf8BvZ5emFtmE3VCiPlpTmn7SqxvaULLXzC?=
 =?us-ascii?Q?2+A+1lfnmQhmTedXEP8ozZ2b4f9falzOMy3YvgDCvO0hEs1oFTLbyo+DgegQ?=
 =?us-ascii?Q?aQVZHpJjHIlx5nWJ5rvWDOMFGcOPObL574oTE7LmXFCzv+8Ts4mwMT6aBqB7?=
 =?us-ascii?Q?kziZ5Z0w8wAzkfWRGVYmwOHVad8PvmP9olec3XQQfzmOvxIg879NaBvsUKLb?=
 =?us-ascii?Q?gM9c72fYT5ogW71gyi4hRgVoE4Zux/ra5CuiPh3Zq+h8KSsHrUpuEFoowlAH?=
 =?us-ascii?Q?aNpEJmmtbhzH1j0ZNAvS0en0qayD9NlE+O0LWT3o/+HaHqqVjot5+d04ol2z?=
 =?us-ascii?Q?K7jcD7LqlEog9FCQtGnvXjwF1oCZku08Vbm7/0OJjph2SA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?noyWsJjTT8jPKjGl3s8lFbJ8RlQHVevfOPrFYl4PW0F431rgz3EkKkD3+lmM?=
 =?us-ascii?Q?nIgEeZuWGL9qgS+IEtAkhJv556sBaMvmOSn5WXizDFXGN+Gn3Euo6EDZsShz?=
 =?us-ascii?Q?mL2VIzTDH4p4dlVjGI4BVJjEEu2fTKig8pTT64WV3frLUUq87LbgxF/wcu+5?=
 =?us-ascii?Q?fYSFV/97nauDEFt3IfQz04cpdcuoFyHrDjHsW3QPE7sh7xoGNR7pg1etbmu7?=
 =?us-ascii?Q?EjicmkDpKY7S/iDMZdm2KS0HJ2C7m4htaxF4EstSO7reG6bD0staIY6PPm8K?=
 =?us-ascii?Q?AS4FXFbZU8KjanBa9aDzs8WPHbK1kfBJJsisTAH1axUwU6D1W1S2ZBKPZPtA?=
 =?us-ascii?Q?AyK7rpCp3ZfO9kIeSs8GNKtZWv96ToAOfd+kUl7rTMK1XBoq8b4ItW1Y6TBE?=
 =?us-ascii?Q?zjWw8ermTHbfAVM0piS+u0utfqn2j6vpEu8WfP0AYEgXa7iCM5NnSj2Tlqmr?=
 =?us-ascii?Q?BfuTx9gz+yuVHWR4tTCOOATh3H3q0AxKmqAB9tX98ASefwTHeRfEnZ1g+4T9?=
 =?us-ascii?Q?mInQODwQpluX43WNOa1cLkA9waXGMmr8HLyLmf8tfvZmuzd95uNUwYxUrRQU?=
 =?us-ascii?Q?ZK2nrb0JPcg8KyyfBDzlu6AvuAeZ6M64SLiPapxKodX3cpIX2xGRePWUWKht?=
 =?us-ascii?Q?GoSyqREz/bCTQ0XFa6ow1mqiX7vwCr/0anWd6lsbwUmwnY74o2i6QvvleF8i?=
 =?us-ascii?Q?FmskCJyI090AoajsgQUhZ+yBqIcdTGkyHP5hYoBOobbzT8wumAtWe2zgv4Ub?=
 =?us-ascii?Q?O0CJ+ghpgFL7PRBXbcmWojV/Hguru+EagTLMpva60CKOCR15u3lumOt8yw/4?=
 =?us-ascii?Q?UzEnZcbZl/COuZwAK0FWfCfx7GXO942J0UriYgQnpc+T44vVdeVoqUTb67Yp?=
 =?us-ascii?Q?Uq9JemXFdRSjQ5GXal6GQTVadp2aIIU+FxkBn1hsKC+pz3Rvw7YrdjcHi9Yu?=
 =?us-ascii?Q?/RrsbjG3R7KGxv0HJFN64XtAnlNURFtjm0/qP5uVQXL3CcKGbtQVmq1GBIJ4?=
 =?us-ascii?Q?UyhzV0bRQRDoI+MCIUob+vKbREtSy3Gb0S55pPIbL/IxUausrGu/J7mH3rYy?=
 =?us-ascii?Q?CtFUkCI/ToMNrpTYndEBF3UniIwNqETQD6iHnw/QeT4Pu4XdLg4LNfaNX7BE?=
 =?us-ascii?Q?OW6HkpOYFU40AGpdJZ17+lstO3JDAjoB3ZRl0kUCOBS5DNU/HQf+LlNo8Prp?=
 =?us-ascii?Q?Rbb6NW8f4Eaa+AexiLQCCDALvVrk0sPhmju/2Kqju+axdalw5hRmNe4ej5Ay?=
 =?us-ascii?Q?uxLwY9FqKoAEfzvGgG88VYqlA2+TX/TxPQHR/n9t3wFLG7fj3N7KIgh6u9di?=
 =?us-ascii?Q?2MVc6Tfa7fIqPP+qwBSJR/qeqTiFAEmaxa0KrBKYiSxkJC5xehtuRCyk6xdt?=
 =?us-ascii?Q?keEmpgnslyDcobbse7GlKH56/Ra6uzJnOwWN9Kk933l52NI4gpd7Zc29eEq3?=
 =?us-ascii?Q?LHfblxH9Wu9j6gUh8X8cSZuUztcvK7yyQI/+UzXiDbpo/08CCP10h15N/TqR?=
 =?us-ascii?Q?01Dh4yycXnoTyK2oI6ZE4ir6M/E+iGxLdp9JKV4AqBhwW4MWWm2u5jBQ3tiO?=
 =?us-ascii?Q?d1ol1J6p3gDU7Kh9aWhjCXmE3c2A4gzqbKLbvQIuAOHGEgOaopi/XVIAnVkf?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DLh9danHzPsaGsmR/s2yU3G+NMaJiN7ZVJNhFYlOMySmC2YEe3VnUaBjk73MTSAVZV8sg3mZ/0o2qvSjBugmcrJcGigSenVc0Of/L3r7lL5JuTLze6eiWyQxPBdNJXBeEroupjekrEa+7NCqtUxa/biO5LUnrgBZiJZ22fEjcrLEtsGZdbrKQuC3nbkzYWhMbjtx2bN0Vdw478C8yZaADWtuafM2mQncmqm2Scy+rbHu5ZpKCjnoHyDxpQXOEamW7N2uTtP09V0+ktsPWaX1NiPMn7EkSz1dYLZZtXTIW8hfyXpX5aUs4jeujRgn7pEoNpQ2HzfzZpVDoNwXAHmEjPQ7XkIldSvxhxQiqT1rJVuTUM80UCXqq/BkpxagAGc8AXUPjmcKkeVpO2L+zpRYZGug/R7oPdZynShPzX9ciGQurIJs7csgegN5bdrAQRNDcLfRt2MkWULNhr5gi1lx22n9aI7uoTnaz8jl1o+8iLfk6XLqDITdqXPvOURrAdN/iONvF9jjkTfMxjaUozTS4mdWTkKizPCkvarBMB24WYuAs52G7Y/MeuwKqxj1o/hwup+r/rxD7ynfUlBdGsKlDWyN2O8SWzZnYoRJVq6It+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7683e087-78c1-4511-343f-08dca026c0a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 14:52:28.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jct8yc+QRUx5qQkeb8SjzMpZEfujYyAGfOUL+UqxiXdoQlzizE2Vy9OaXfNlEW7U72FAngqV0PH+vXAk7SSLsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090096
X-Proofpoint-GUID: orjMAdc9IKTY6N9urDEKZRDymsYeMLsN
X-Proofpoint-ORIG-GUID: orjMAdc9IKTY6N9urDEKZRDymsYeMLsN

* Liam R. Howlett <Liam.Howlett@oracle.com> [240709 10:42]:
> Cc'ing Dave Hansen on this.

Really adding Dave to the discussion.

> 
> * Liam R. Howlett <Liam.Howlett@oracle.com> [240708 16:43]:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 08:53]:
> > > On Thu, Jul 04, 2024 at 02:27:18PM GMT, Liam R. Howlett wrote:
> > > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > > >
> > > > The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
> > > > call, so use it instead of looping over the vmas twice.
> > > 
> > > Predictably indeed you removed the thing I commented on in the last patch
> > > ;) but at least this time I predicted it! ;)
> > > 
> > > >
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > > ---
> > > >  mm/mmap.c | 36 ++++--------------------------------
> > > >  1 file changed, 4 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index b2de26683903..62edaabf3987 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> 
> ...
> 
> > > >  static void __vma_link_file(struct vm_area_struct *vma,
> > > >  			    struct address_space *mapping)
> > > >  {
> > > > @@ -2946,17 +2925,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  	pgoff_t vm_pgoff;
> > > >  	int error = -ENOMEM;
> > > >  	VMA_ITERATOR(vmi, mm, addr);
> > > > -	unsigned long nr_pages, nr_accounted;
> > > > -
> > > > -	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> > > > -
> > > > -	/* Check against address space limit. */
> > > > -	/*
> > > > -	 * MAP_FIXED may remove pages of mappings that intersects with requested
> > > > -	 * mapping. Account for the pages it would unmap.
> > > > -	 */
> > > > -	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
> > > > -		return -ENOMEM;
> > > >
> > > >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> > > >  		return -EPERM;
> > > > @@ -2987,6 +2955,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  			vma_iter_next_range(&vmi);
> > > >  	}
> > > >
> > > > +	/* Check against address space limit. */
> > > > +	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
> > > > +		goto abort_munmap;
> > > > +
> > > 
> > > I know you can literally only do this after the vms_gather_munmap_vmas(),
> > > but this does change where we check this, so for instance we do
> > > arch_unmap() without having checked may_expand_vm().
> > > 
> > > However I assume this is fine?
> > 
> > Thanks for pointing this out.
> > 
> > The functionality here has changed
> > --- from ---
> > may_expand_vm() check
> > can_modify_mm() check
> > arch_unmap()
> > vms_gather_munmap_vmas()
> > ...
> > 
> > --- to ---
> > can_modify_mm() check
> > arch_unmap()
> > vms_gather_munmap_vmas()
> > may_expand_vm() check
> > ...
> > 
> > vms_gather_munmap_vmas() does nothing but figures out what to do later,
> > but could use memory and can fail.
> > 
> > The user implications are:
> > 
> > 1. The return type on the error may change to -EPERM from -ENOMEM, if
> > you are not allowed to expand and are trying to overwrite mseal()'ed
> > VMAs. That seems so very rare that I'm not sure it's worth mentioning.
> > 
> > 
> > 2. arch_unmap() called prior to may_expand_vm().
> > powerpc uses this to set mm->context.vdso = NULL if mm->context.vdso is
> > within the unmap range.  User implication of this means that an
> > application my set the vdso to NULL prior to hitting the -ENOMEM case in
> > may_expand_vm() due to the address space limit.
> > 
> > Assuming the removal of the vdso does not cause the application to seg
> > fault, then the user visible change is that any vdso call after a failed
> > mmap(MAP_FIXED) call would result in a seg fault.  The only reason it
> > would fail is if the mapping process was attempting to map a large
> > enough area over the vdso (which is accounted and in the vma tree,
> > afaict) and ran out of memory. Note that this situation could arise
> > already since we could run out of memory (not accounting) after the
> > arch_unmap() call within the kernel.
> > 
> > The code today can suffer the same fate, but not by the accounting
> > failure.  It can happen due to failure to allocate a new vma,
> > do_vmi_munmap() failure after the arch_unmap() call, or any of the other
> > failure scenarios later in the mmap_region() function.
> >
> > At the very least, this requires an expanded change log.
> 
> After doing a deep dive into the vdso issue, I think it would be best to
> remove the arch_unmap() call completely in a later patch set by changing
> the two areas highlighted by Dave in patch 5a28fc94c914 "x86/mpx,
> mm/core: Fix recursive munmap() corruption" back in 2019 in regards to
> the powerpc pointer use.  But that's for later work.
> 
> In the above mentioned patch, the arch_unmap() was moved to an earlier
> time to avoid removing the same vma twice from the rbtree.  Since the
> mpx code no longer removes the vma and powerpc never removed the vma, it
> seems safe to reorder the calls as such:
> 
> can_modify_mm() check
> vms_gather_munmap_vmas()
> may_expand_vm() check
> arch_unmap()
> 
> This seems very much fine because:
> - powerpc is the only platform doing _anything_ in arch_unmap().
> - powerpc used to work with the arch_unmap() call  after the vma was
>   completely dropped.
> - The vma isn't even dropped by this point and so all proposed changes
>   will be completely undone in the rare case of may_expand_vm() failure.
> - The arch_unmap() call doesn't need to be that early anymore anyways
>   (mpx was dropped by Dave in 2020 git id ccaaaf6fe5a5).
> 
> I will make the order change in v4 of the patch series in its own patch.
> 
> Thanks,
> Liam

